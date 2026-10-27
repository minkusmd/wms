"""Structurile de date ale unei rulari (dataclass-uri: mii de randuri, validarea e in normalize)."""

from __future__ import annotations

from dataclasses import dataclass, field
from enum import StrEnum


class RunStatus(StrEnum):
    QUEUED = "QUEUED"
    RUNNING = "RUNNING"
    UNCHANGED = "UNCHANGED"
    BLOCKED = "BLOCKED"
    DRY_RUN = "DRY_RUN"
    APPLIED = "APPLIED"
    PARTIAL = "PARTIAL"
    ERROR = "ERROR"
    TIMEOUT = "TIMEOUT"
    SKIPPED = "SKIPPED"
    ROLLED_BACK = "ROLLED_BACK"
    SUPERSEDED = "SUPERSEDED"


class ChangeType(StrEnum):
    NEW = "NEW"                    # cod necunoscut in TS_GOODS_FOREIGN (nelegat)
    RETURNED = "RETURNED"          # legat, dar iesit din pricelist -> reapare (reevaluarea "produse noi")
    GONE = "GONE"                  # in pricelist in WMS, lipseste acum si data trecuta -> iese din pricelist
    PENDING_GONE = "PENDING_GONE"  # lipseste prima data: se asteapta confirmarea la rularea urmatoare
    PRICE_UP = "PRICE_UP"
    PRICE_DOWN = "PRICE_DOWN"
    STOCK_QTY = "STOCK_QTY"


class Decision(StrEnum):
    APPLY = "APPLY"
    QUARANTINE = "QUARANTINE"
    IGNORE = "IGNORE"
    WAIT = "WAIT"


class Severity(StrEnum):
    INFO = "INFO"
    WARN = "WARN"
    CRIT = "CRIT"


# coloanele de pret ale TS_PRICELIST_ITEMS / TS_GOODS_FOREIGN
PRICE_COST = 0       # PRICE0 - pret de achizitie
PRICE_RRP = 3        # PRICE3 - pret recomandat
PRICE_LIST = 7       # PRICE7 - pret indicativ


@dataclass(slots=True)
class SupplierItem:
    """O pozitie normalizata a pricelistului furnizorului."""
    code: str
    name: str = ""
    brand: str | None = None
    model: str | None = None
    category: str | None = None
    ean: str | None = None
    price0: float | None = None
    cur0: int | None = None
    price3: float | None = None
    cur3: int | None = None
    price7: float | None = None
    cur7: int | None = None
    stock: str | None = None
    row_no: int | None = None


@dataclass(slots=True)
class GfRow:
    """Starea curenta a unui rand TS_GOODS_FOREIGN al furnizorului."""
    goodsid: int
    code: str
    title: str
    price0: float | None
    cur0: int | None
    price3: float | None
    cur3: int | None
    price7: float | None
    cur7: int | None
    in_price: bool          # bitul 3 FLG_IN_PRICE al randului
    epp: bool               # bitul 4 FLG_EPP
    goods_in_price: bool    # GET_FLG_IN_PRICE(GOODSID) - produsul e "in pret" pe site


@dataclass(slots=True)
class Change:
    code: str
    change_type: ChangeType
    goodsid: int | None = None
    price_field: int | None = None
    old_price: float | None = None
    new_price: float | None = None
    old_cur: int | None = None
    new_cur: int | None = None
    delta_pct: float | None = None
    old_stock: str | None = None
    new_stock: str | None = None
    name: str | None = None
    category: str | None = None
    decision: Decision = Decision.APPLY
    reason: str | None = None


@dataclass(slots=True)
class RowError:
    error_class: str
    message: str
    row_no: int | None = None
    code: str | None = None
    severity: Severity = Severity.WARN


@dataclass
class FetchResult:
    """Ce intoarce un adaptor: pozitiile valide + erorile de rand + date despre sursa."""
    items: list[SupplierItem]
    row_errors: list[RowError] = field(default_factory=list)
    n_fetched: int = 0
    n_skipped: int = 0            # sarite intentionat (ex. fara pret de cost) - nu sint erori
    n_duplicates: int = 0
    source_sha256: str | None = None
    raw_payload: bytes | None = None
    plid: int | None = None       # pricelistul citit (adaptorul external_plid)
    plid_processed: bool = False  # WMS a facut deja reevaluarile pentru acest PLID
    n_http_calls: int = 0
    n_retries: int = 0
    unchanged: bool = False       # nu exista date noi fata de rularea precedenta
    warnings: list[RowError] = field(default_factory=list)   # probleme ale sursei, nu ale randurilor
    note: str | None = None
