"""Clientul HTTP comun: timeouts, retry cu backoff exponential + jitter, Retry-After, rate limit."""

from __future__ import annotations

import random
import threading
import time
from typing import Any
from urllib.parse import urlsplit

import httpx

from .. import __version__
from ..log import get_logger, mask_secrets
from .base import AdapterError, RunContext

RETRY_STATUSES = {408, 425, 429, 500, 502, 503, 504}
MAX_RETRY_AFTER = 120.0

log = get_logger(__name__)


class RateLimiter:
    """Token bucket simplu: cel mult `rate` cereri pe secunda, in medie."""

    def __init__(self, rate: float):
        self.interval = 1.0 / rate if rate > 0 else 0.0
        self._next = 0.0
        self._lock = threading.Lock()

    def wait(self) -> None:
        if not self.interval:
            return
        with self._lock:
            now = time.monotonic()
            delay = self._next - now
            self._next = max(now, self._next) + self.interval
        if delay > 0:
            time.sleep(delay)


class HttpClient:
    def __init__(self, ctx: RunContext, rate_per_sec: float | None = None,
                 headers: dict[str, str] | None = None, sleep=None, read_timeout: float | None = None):
        s = ctx.settings
        self.ctx = ctx
        self.max_attempts = s.http_max_attempts
        self.limiter = RateLimiter(rate_per_sec if rate_per_sec is not None else ctx.supplier.max_rps)
        self.sleep = sleep            # None = time.sleep (cautat la apel, se poate inlocui in teste)
        self.calls = 0
        self.retries = 0
        self.bytes_received = 0
        self.client = httpx.Client(
            # read_timeout: catalogul DMLink se genereaza ~15 s si are ~35 MB
            timeout=httpx.Timeout(read_timeout or s.http_read_timeout, connect=s.http_connect_timeout),
            headers={"User-Agent": f"WMS-PriceImport/{__version__}", "Accept": "application/json",
                     **(headers or {})},
            follow_redirects=True)

    def close(self) -> None:
        self.client.close()

    def __enter__(self) -> "HttpClient":
        return self

    def __exit__(self, *exc) -> None:
        self.close()

    def _backoff(self, attempt: int, retry_after: str | None) -> float:
        if retry_after:
            try:
                return min(float(retry_after), MAX_RETRY_AFTER)
            except ValueError:
                pass
        return min(2.0 ** attempt, 60.0) + random.uniform(0, 1.0)

    def get_json(self, url: str, params: dict[str, Any] | None = None,
                 headers: dict[str, str] | None = None) -> Any:
        return self.request_json("GET", url, params=params, headers=headers)

    def post_json(self, url: str, body: Any = None, headers: dict[str, str] | None = None,
                  ok: tuple[int, ...] = (200, 201)) -> Any:
        """POST cu corp JSON (`body` None = corp gol, ca la Accent)."""
        if body is None:
            return self.request_json("POST", url, content=b"", headers=headers, ok=ok)
        return self.request_json("POST", url, json=body, headers=headers, ok=ok)

    def request_json(self, method: str, url: str, *, params: dict[str, Any] | None = None, json: Any = None,
                     content: bytes | None = None, headers: dict[str, str] | None = None,
                     ok: tuple[int, ...] = (200,)) -> Any:
        endpoint = urlsplit(url).path
        last_status: int | None = None
        last_error = ""
        for attempt in range(1, self.max_attempts + 1):
            self.ctx.check_deadline()
            self.limiter.wait()
            self.calls += 1
            try:
                response = self.client.request(method, url, params=params, json=json, content=content,
                                               headers=headers)
            except httpx.TransportError as exc:
                last_status, last_error = None, f"{type(exc).__name__}: {exc}"
                retry_after = None
            else:
                last_status = response.status_code
                if response.status_code in ok:
                    self.bytes_received += len(response.content)
                    try:
                        return response.json()
                    except ValueError as exc:
                        raise AdapterError("SCHEMA", f"raspuns care nu e JSON: {exc}", endpoint, 200,
                                           self.retries) from exc
                if response.status_code in (401, 403):
                    raise AdapterError("AUTH", f"acces refuzat (HTTP {response.status_code})", endpoint,
                                       response.status_code, self.retries)
                if response.status_code not in RETRY_STATUSES:
                    raise AdapterError("HTTP_4XX" if response.status_code < 500 else "HTTP_5XX",
                                       f"HTTP {response.status_code}: {response.text[:200]}", endpoint,
                                       response.status_code, self.retries)
                last_error = f"HTTP {response.status_code}"
                retry_after = response.headers.get("Retry-After")
            if attempt == self.max_attempts:
                break
            self.retries += 1
            wait = self._backoff(attempt, retry_after)
            log.warning("http_retry", supplier=self.ctx.supplier.supplier_id, endpoint=endpoint,
                        status=last_status, attempt=attempt, wait=round(wait, 1), error=mask_secrets(last_error))
            (self.sleep or time.sleep)(wait)
        error_class = "TIMEOUT" if last_status is None and "Timeout" in last_error else (
            "NETWORK" if last_status is None else ("HTTP_429" if last_status == 429 else "HTTP_5XX"))
        raise AdapterError(error_class, f"{mask_secrets(last_error)} dupa {self.max_attempts} incercari",
                           endpoint, last_status, self.retries)
