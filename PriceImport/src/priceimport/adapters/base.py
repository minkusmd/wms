"""Contractul adaptoarelor de furnizor + contextul unei rulari."""

from __future__ import annotations

import hashlib
import json
import time
from dataclasses import dataclass, field
from typing import Any, Callable, ClassVar

from ..config import Settings
from ..db import Db
from ..models import FetchResult
from ..repo import SupplierConfig


class AdapterError(Exception):
    """Eroare care opreste rularea furnizorului (raportata in TPI_RUN_ERROR)."""

    def __init__(self, error_class: str, message: str, endpoint: str | None = None,
                 http_status: int | None = None, retries: int = 0):
        super().__init__(message)
        self.error_class = error_class
        self.endpoint = endpoint
        self.http_status = http_status
        self.retries = retries


class DeadlineExceeded(AdapterError):
    def __init__(self, message: str = "termenul ferestrei a expirat"):
        super().__init__("TIMEOUT", message)


@dataclass
class RunContext:
    settings: Settings
    supplier: SupplierConfig
    db: Db                                  # conexiunea rularii (doar citiri in etapa de descarcare)
    params: dict[str, Any]                  # suppliers/<id>.yaml
    currency_ids: dict[str, int]            # ISO -> CURRENCYID
    deadline: float | None = None           # time.monotonic()
    plid: int | None = None                 # external_plid: pricelistul cerut explicit
    progress: Callable[[str], None] = field(default=lambda _msg: None)

    def check_deadline(self) -> None:
        if self.deadline is not None and time.monotonic() > self.deadline:
            raise DeadlineExceeded()

    def currency_id(self, iso: str) -> int:
        try:
            return self.currency_ids[iso]
        except KeyError as exc:
            raise AdapterError("CONFIG", f"moneda {iso} lipseste din TS_CURRENCY") from exc


class SupplierAdapter:
    code: ClassVar[str]
    # gazda API-ului: doua adaptoare cu aceeasi gazda nu ruleaza simultan (None = fara limita)
    host: ClassVar[str | None] = None

    def fetch(self, ctx: RunContext) -> FetchResult:
        raise NotImplementedError


def sha256_json(payload: Any) -> str:
    data = json.dumps(payload, ensure_ascii=False, sort_keys=True, separators=(",", ":"), default=str)
    return hashlib.sha256(data.encode("utf-8")).hexdigest()
