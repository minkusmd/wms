"""Descarcarea imaginilor de continut (etapa 4b): URL-uri verificate, limita de marime, PNG de cel mult 1200 px.

Ca TMamicoContentLoader.SaveItem + ShrinkPriceListImage (Delphi): orice format citit (JPG / PNG / WebP / ...)
devine PNG, latura cea mai mare cel mult 1200 px. Fiecare imagine are 3 incercari (serverul DMLink pierde
uneori cereri minute in sir). URL-urile vin de la furnizor, deci se accepta doar http(s) spre adrese publice
(anti-SSRF), verificate si la fiecare redirect.
"""

from __future__ import annotations

import io
import ipaddress
import socket
import threading
import time
from dataclasses import dataclass, field
from typing import Callable
from urllib.parse import urljoin, urlsplit

import httpx
from PIL import Image, UnidentifiedImageError

from . import __version__

MAX_SIDE = 1200                    # cMaxPriceListImageSide
MAX_BYTES = 25 * 1024 * 1024       # o imagine mai mare = refuzata (Nex trimite JPG-uri de 3213x5712, ~5 MB)
MAX_PIXELS = 60_000_000            # bomba de decompresie
ATTEMPTS = 3                       # cDMLinkImageAttempts
MAX_REDIRECTS = 3
FORMATS = {"JPEG", "PNG", "WEBP", "GIF", "BMP", "TIFF", "MPO"}

Image.MAX_IMAGE_PIXELS = MAX_PIXELS


class ImageError(Exception):
    """Imaginea nu poate fi folosita; `retry` = merita reincercata (retea / 5xx)."""

    def __init__(self, message: str, retry: bool = False):
        super().__init__(message)
        self.retry = retry


def _resolve(host: str) -> list[str]:
    return [info[4][0] for info in socket.getaddrinfo(host, None, type=socket.SOCK_STREAM)]


def check_url(url: str, resolve: Callable[[str], list[str]] = _resolve) -> None:
    parts = urlsplit(url)
    if parts.scheme not in ("http", "https") or not parts.hostname:
        raise ImageError(f"URL nepermis: {url[:120]}")
    try:
        addresses = resolve(parts.hostname)
    except OSError as exc:
        raise ImageError(f"gazda necunoscuta {parts.hostname}: {exc}", retry=True) from exc
    for address in addresses:
        if not ipaddress.ip_address(address.split("%")[0]).is_global:
            raise ImageError(f"{parts.hostname} -> adresa nepublica {address}")


def to_png(data: bytes) -> bytes:
    """Octetii unei imagini -> PNG, micsorat la MAX_SIDE (doar micsorare, proportiile raman)."""
    try:
        with Image.open(io.BytesIO(data)) as im:
            if im.format not in FORMATS:
                raise ImageError(f"format nepermis: {im.format}")
            im.seek(0)                                 # GIF / WebP animat: primul cadru
            im.load()
            if im.mode not in ("RGB", "RGBA", "L", "LA", "P"):
                im = im.convert("RGBA" if "A" in im.getbands() else "RGB")
            if max(im.size) > MAX_SIDE:
                im.thumbnail((MAX_SIDE, MAX_SIDE), Image.Resampling.LANCZOS)
            out = io.BytesIO()
            im.save(out, format="PNG")
            return out.getvalue()
    except ImageError:
        raise
    except (UnidentifiedImageError, Image.DecompressionBombError, OSError, ValueError, SyntaxError) as exc:
        raise ImageError(f"imagine necitibila: {type(exc).__name__}: {str(exc)[:120]}") from exc


@dataclass
class CodeImages:
    """Imaginile unui cod, in ordinea URL-urilor; None = imaginea nu s-a putut descarca / converti."""
    code: str
    urls: list[str]
    images: list[bytes | None] = field(default_factory=list)
    bytes_in: int = 0
    errors: list[str] = field(default_factory=list)

    @property
    def n_ok(self) -> int:
        return sum(1 for i in self.images if i)


class ImageFetcher:
    """Folosit din mai multe fire (httpx.Client e thread-safe); scrierea in baza ramine apelantului."""

    def __init__(self, connect_timeout: float = 10.0, read_timeout: float = 60.0,
                 resolve: Callable[[str], list[str]] = _resolve, sleep: Callable[[float], None] = time.sleep):
        self.resolve = resolve
        self.sleep = sleep
        self._checked: dict[str, None] = {}
        self._lock = threading.Lock()
        self.client = httpx.Client(timeout=httpx.Timeout(read_timeout, connect=connect_timeout),
                                   headers={"User-Agent": f"WMS-PriceImport/{__version__}",
                                            "Accept": "image/*,*/*;q=0.5"},
                                   follow_redirects=False)

    def close(self) -> None:
        self.client.close()

    def __enter__(self) -> "ImageFetcher":
        return self

    def __exit__(self, *exc) -> None:
        self.close()

    def _check(self, url: str) -> None:
        host = urlsplit(url).hostname or ""
        with self._lock:
            if host in self._checked:
                return
        check_url(url, self.resolve)
        with self._lock:
            self._checked[host] = None

    def download(self, url: str) -> bytes:
        for _ in range(MAX_REDIRECTS + 1):
            self._check(url)
            try:
                with self.client.stream("GET", url) as response:
                    if response.status_code in (301, 302, 303, 307, 308) and "location" in response.headers:
                        url = urljoin(url, response.headers["location"])
                        continue
                    if response.status_code != 200:
                        raise ImageError(f"HTTP {response.status_code}", retry=response.status_code >= 500
                                         or response.status_code in (408, 429))
                    size = int(response.headers.get("content-length") or 0)
                    if size > MAX_BYTES:
                        raise ImageError(f"imagine prea mare ({size} octeti)")
                    chunks, total = [], 0
                    for chunk in response.iter_bytes():
                        total += len(chunk)
                        if total > MAX_BYTES:
                            raise ImageError(f"imagine prea mare (peste {MAX_BYTES} octeti)")
                        chunks.append(chunk)
                    return b"".join(chunks)
            except httpx.TransportError as exc:
                raise ImageError(f"{type(exc).__name__}: {str(exc)[:120]}", retry=True) from exc
        raise ImageError("prea multe redirecturi")

    def fetch_code(self, code: str, urls: list[str]) -> CodeImages:
        result = CodeImages(code=code, urls=urls)
        for url in urls:
            png = None
            for attempt in range(1, ATTEMPTS + 1):
                try:
                    data = self.download(url)
                    result.bytes_in += len(data)
                    png = to_png(data)
                    break
                except ImageError as exc:
                    if not exc.retry or attempt == ATTEMPTS:
                        result.errors.append(f"{url[:160]}: {exc}")
                        break
                    self.sleep(1.0 * attempt)
            result.images.append(png)
        return result
