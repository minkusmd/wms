"""Toate citirile si scrierile SQL ale serviciului (un singur loc de verificat la schimbari de schema)."""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any, Iterable

from .db import Db
from .models import Change, GfRow, RowError, Severity, SupplierItem

FLG_IN_PRICE_BIT = 3      # TS_GOODS_FOREIGN.FLAGS
FLG_EPP_BIT = 4
FLG_PL_API_BIT = 1        # TS_PRICELISTS.FLAGS: valoarea 2 = FLG_API
FLG_PL_DONE_BIT = 4       # TS_PRICELISTS.FLAGS: valoarea 16 = reevaluarile facute (FLG_DONE)

TELEGRAM_SOURCE_TABLE = -50   # TELEGRAM_MESSAGES.SOURCE_TABLE pentru PriceImport
MAX_ERROR_ROWS = 200          # randurile de eroare salvate per rulare (restul doar numarate)


def _bit(flags: int | None, bit: int) -> bool:
    return bool(((flags or 0) >> bit) & 1)


@dataclass
class SupplierConfig:
    supplier_id: int
    name: str
    adapter_code: str
    source_kind: str
    window_mask: int
    priority: int
    est_duration_sec: int | None
    max_rps: float
    price_category_id: int
    max_up_pct: float
    max_down_pct: float
    noise_pct: float
    min_volume_ratio: float
    gone_after_runs: int
    auto_apply: bool
    active: bool
    firma_id: int | None

    def in_window(self, window_index: int) -> bool:
        return bool((self.window_mask >> window_index) & 1)


@dataclass
class ThresholdRule:
    supplier_id: int | None
    goods_type_id: int | None
    parent_goods_id: int | None
    max_up_pct: float | None
    max_down_pct: float | None
    min_price_usd: float | None
    max_price_usd: float | None

    def specificity(self) -> int:
        return ((self.supplier_id is not None) * 4 + (self.parent_goods_id is not None) * 2
                + (self.goods_type_id is not None))


# --- configurare ---------------------------------------------------------------------------

def load_suppliers(db: Db, only_active: bool = True) -> list[SupplierConfig]:
    rows = db.query(
        "SELECT s.*, c.NAME AS SUPPLIER_NAME FROM TPI_SUPPLIER s "
        "LEFT JOIN TS_CUSTOMER c ON c.CUSTOMERID = s.SUPPLIERID "
        + ("WHERE s.FLG_ACTIVE = 1 " if only_active else "")
        + "ORDER BY s.PRIORITY, s.SUPPLIERID")
    return [SupplierConfig(
        supplier_id=r["SUPPLIERID"], name=(r["SUPPLIER_NAME"] or str(r["SUPPLIERID"])).strip(),
        adapter_code=r["ADAPTER_CODE"].strip(), source_kind=r["SOURCE_KIND"].strip(),
        window_mask=r["WINDOW_MASK"], priority=r["PRIORITY"], est_duration_sec=r["EST_DURATION_SEC"],
        max_rps=float(r["MAX_RPS"]), price_category_id=r["PRICE_CATEGORYID"],
        max_up_pct=float(r["MAX_UP_PCT"]), max_down_pct=float(r["MAX_DOWN_PCT"]),
        noise_pct=float(r["NOISE_PCT"]), min_volume_ratio=float(r["MIN_VOLUME_RATIO"]),
        gone_after_runs=r["GONE_AFTER_RUNS"], auto_apply=bool(r["FLG_AUTO_APPLY"]),
        active=bool(r["FLG_ACTIVE"]), firma_id=r["FIRMAID"]) for r in rows]


def load_supplier(db: Db, supplier_id: int) -> SupplierConfig | None:
    for cfg in load_suppliers(db, only_active=False):
        if cfg.supplier_id == supplier_id:
            return cfg
    return None


def load_threshold_rules(db: Db, supplier_id: int) -> list[ThresholdRule]:
    rows = db.query("SELECT * FROM TPI_THRESHOLD WHERE SUPPLIERID = ? OR SUPPLIERID IS NULL", (supplier_id,))

    def f(v: Any) -> float | None:
        return None if v is None else float(v)

    return [ThresholdRule(r["SUPPLIERID"], r["GOODSTYPEID"], r["PARENTGOODSID"], f(r["MAX_UP_PCT"]),
                          f(r["MAX_DOWN_PCT"]), f(r["MIN_PRICE_USD"]), f(r["MAX_PRICE_USD"])) for r in rows]


def load_api_config(db: Db, api_code: str) -> dict[str, str]:
    rows = db.query("SELECT PARAM_NAME, PARAM_VALUE FROM TS_API_CONFIG "
                    "WHERE API_CODE = ? AND FLG_ACTIVE = 1", (api_code,))
    return {r["PARAM_NAME"].strip().upper(): (r["PARAM_VALUE"] or "").strip() for r in rows}


def load_currencies(db: Db) -> tuple[dict[str, int], dict[int, float]]:
    """(ISO -> CURRENCYID, CURRENCYID -> curs in MDL)."""
    rows = db.query("SELECT CURRENCYID, TITLE, EXCHANGE_RATE FROM TS_CURRENCY")
    iso = {(r["TITLE"] or "").strip().upper(): r["CURRENCYID"] for r in rows if r["TITLE"]}
    rates = {r["CURRENCYID"]: float(r["EXCHANGE_RATE"] or 0) for r in rows}
    return iso, rates


def load_rrp_discount(db: Db, supplier_id: int) -> float:
    """TS_CUSTOMER.RRP_DISCOUNT (%) - reducerea aplicata RRP-ului de ADJUST_RRP_REEVALUATION."""
    return float(db.scalar("SELECT RRP_DISCOUNT FROM TS_CUSTOMER WHERE CUSTOMERID = ?", (supplier_id,)) or 0)


def load_exclusions(db: Db, supplier_id: int) -> set[str]:
    rows = db.query("SELECT SUPPLIER_GOODS_CODE FROM TS_PRICELIST_EXCLUSIOINS WHERE SUPPLIERID = ?",
                    (supplier_id,))
    return {r["SUPPLIER_GOODS_CODE"] for r in rows}


def load_goods_groups(db: Db, goods_ids: Iterable[int]) -> dict[int, tuple[int | None, int | None]]:
    """GOODSID -> (WEBGOODSTYPE_ID, PARENTID), pentru pragurile pe tip de produs / mapa."""
    ids = sorted(set(goods_ids))
    result: dict[int, tuple[int | None, int | None]] = {}
    for i in range(0, len(ids), 500):
        chunk = ids[i:i + 500]
        marks = ",".join("?" * len(chunk))
        for r in db.query(f"SELECT GOODSID, WEBGOODSTYPE_ID, PARENTID FROM TS_GOODS WHERE GOODSID IN ({marks})",
                          chunk):
            result[r["GOODSID"]] = (r["WEBGOODSTYPE_ID"], r["PARENTID"])
    return result


# --- starea furnizorului si pricelisturile ------------------------------------------------

def load_gf_state(db: Db, supplier_id: int) -> dict[str, list[GfRow]]:
    rows = db.query(
        "SELECT gf.GOODSID, gf.GOODS_CODE, gf.GOODS_TITLE, gf.PRICE0, gf.CURRENCY0ID, gf.PRICE3, "
        "gf.CURRENCY3ID, gf.PRICE7, gf.CURRENCY7ID, gf.FLAGS, GET_FLG_IN_PRICE(gf.GOODSID) AS GOODS_IN_PRICE "
        "FROM TS_GOODS_FOREIGN gf WHERE gf.CUSTOMERID = ?", (supplier_id,))
    state: dict[str, list[GfRow]] = {}
    for r in rows:
        state.setdefault(r["GOODS_CODE"], []).append(GfRow(
            goodsid=r["GOODSID"], code=r["GOODS_CODE"], title=r["GOODS_TITLE"] or "",
            price0=_f(r["PRICE0"]), cur0=r["CURRENCY0ID"], price3=_f(r["PRICE3"]), cur3=r["CURRENCY3ID"],
            price7=_f(r["PRICE7"]), cur7=r["CURRENCY7ID"],
            in_price=_bit(r["FLAGS"], FLG_IN_PRICE_BIT), epp=_bit(r["FLAGS"], FLG_EPP_BIT),
            goods_in_price=bool(r["GOODS_IN_PRICE"])))
    return state


def _f(v: Any) -> float | None:
    return None if v is None else float(v)


def latest_pricelist(db: Db, supplier_id: int, before_plid: int | None = None) -> dict[str, Any] | None:
    sql = ("SELECT FIRST 1 PLID, DATA, FLAGS, MENTIUNI, "
           "DATEDIFF(MINUTE FROM DATA TO CURRENT_TIMESTAMP) AS AGE_MIN "
           "FROM TS_PRICELISTS WHERE SUPPLIERID = ?")
    params: list[Any] = [supplier_id]
    if before_plid is not None:
        sql += " AND PLID < ?"
        params.append(before_plid)
    sql += " ORDER BY PLID DESC"
    return db.query_one(sql, params)


def pricelist_info(db: Db, plid: int) -> dict[str, Any] | None:
    return db.query_one("SELECT PLID, SUPPLIERID, DATA, FLAGS, MENTIUNI, "
                        "DATEDIFF(MINUTE FROM DATA TO CURRENT_TIMESTAMP) AS AGE_MIN "
                        "FROM TS_PRICELISTS WHERE PLID = ?", (plid,))


def pricelist_done(info: dict[str, Any]) -> bool:
    return _bit(info.get("FLAGS"), FLG_PL_DONE_BIT)


def load_pricelist_items(db: Db, plid: int) -> list[SupplierItem]:
    rows = db.query(
        "SELECT SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, SUPPLIER_GOODS_BRAND, SUPPLIER_GOODS_MODEL, "
        "SUPPLIER_CATEGORY, PRICE0, CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, CURRENCY7ID, STOCK_QTY "
        "FROM TS_PRICELIST_ITEMS WHERE PLID = ?", (plid,))
    return [SupplierItem(
        code=r["SUPPLIER_GOODS_CODE"], name=r["SUPPLIER_GOODS_NAME"] or "", brand=r["SUPPLIER_GOODS_BRAND"],
        model=r["SUPPLIER_GOODS_MODEL"], category=r["SUPPLIER_CATEGORY"],
        price0=_f(r["PRICE0"]), cur0=r["CURRENCY0ID"], price3=_f(r["PRICE3"]), cur3=r["CURRENCY3ID"],
        price7=_f(r["PRICE7"]), cur7=r["CURRENCY7ID"], stock=r["STOCK_QTY"]) for r in rows]


def pricelist_codes(db: Db, plid: int) -> set[str]:
    return {r["SUPPLIER_GOODS_CODE"] for r in
            db.query("SELECT SUPPLIER_GOODS_CODE FROM TS_PRICELIST_ITEMS WHERE PLID = ?", (plid,))}


# --- jurnalul rularilor --------------------------------------------------------------------

def find_run_by_key(db: Db, key: str) -> dict[str, Any] | None:
    return db.query_one("SELECT RUNID, STATUS FROM TPI_RUN WHERE IDEMPOTENCY_KEY = ?", (key,))


def last_processed_plid(db: Db, supplier_id: int) -> int | None:
    return db.scalar("SELECT MAX(PLID) FROM TPI_RUN WHERE SUPPLIERID = ? AND PLID IS NOT NULL "
                     "AND STATUS IN ('DRY_RUN', 'APPLIED', 'PARTIAL', 'BLOCKED', 'UNCHANGED')", (supplier_id,))


def last_run_id(db: Db, supplier_id: int) -> int | None:
    return db.scalar("SELECT MAX(RUNID) FROM TPI_RUN WHERE SUPPLIERID = ? "
                     "AND STATUS IN ('DRY_RUN', 'APPLIED', 'PARTIAL', 'BLOCKED')", (supplier_id,))


def insert_run(db: Db, supplier_id: int, trigger: str, slot: str | None, key: str, dry_run: bool,
               host: str, pid: int) -> int:
    """Rularea noua, direct RUNNING; indexul partial UX_TPI_RUN_ACTIVE refuza a doua rulare activa."""
    return db.execute_returning(
        "INSERT INTO TPI_RUN (SUPPLIERID, TRIGGER_KIND, RUN_SLOT, IDEMPOTENCY_KEY, STATUS, STAGE, FLG_DRY_RUN, "
        "STARTED_AT, HEARTBEAT_AT, HOST, PID) VALUES (?, ?, ?, ?, 'RUNNING', 'FETCH', ?, CURRENT_TIMESTAMP, "
        "CURRENT_TIMESTAMP, ?, ?) RETURNING RUNID",
        (supplier_id, trigger, slot, key, int(dry_run), host[:64], pid))


def insert_skipped_run(db: Db, supplier_id: int, trigger: str, slot: str | None, key: str, reason: str) -> int:
    return db.execute_returning(
        "INSERT INTO TPI_RUN (SUPPLIERID, TRIGGER_KIND, RUN_SLOT, IDEMPOTENCY_KEY, STATUS, FLG_DRY_RUN, "
        "STARTED_AT, FINISHED_AT, ERROR_TEXT) VALUES (?, ?, ?, ?, 'SKIPPED', 1, CURRENT_TIMESTAMP, "
        "CURRENT_TIMESTAMP, ?) RETURNING RUNID", (supplier_id, trigger, slot, key, reason[:2048]))


_RUN_COLUMNS = {
    "STATUS", "STAGE", "PLID", "PREV_RUNID", "SOURCE_SHA256", "RAW_PATH", "N_FETCHED", "N_VALID",
    "N_INVALID", "N_MATCHED", "N_NEW", "N_RETURNED", "N_GONE", "N_PENDING_GONE", "N_PRICE_UP",
    "N_PRICE_DOWN", "N_QUARANTINE", "N_APPLIED", "N_HTTP_CALLS", "N_RETRIES", "REEVAL_DOCIDS", "ERROR_TEXT",
}


def update_run(db: Db, run_id: int, finished: bool = False, **fields: Any) -> None:
    sets, params = ["HEARTBEAT_AT = CURRENT_TIMESTAMP"], []
    for key, value in fields.items():
        col = key.upper()
        if col not in _RUN_COLUMNS:
            raise KeyError(col)
        if col == "ERROR_TEXT" and value is not None:
            value = str(value)[:2048]
        sets.append(f"{col} = ?")
        params.append(value)
    if finished:
        sets.append("FINISHED_AT = CURRENT_TIMESTAMP")
    params.append(run_id)
    db.execute(f"UPDATE TPI_RUN SET {', '.join(sets)} WHERE RUNID = ?", params)


def touch_runs(db: Db, run_ids: Iterable[int]) -> None:
    for run_id in run_ids:
        db.execute("UPDATE TPI_RUN SET HEARTBEAT_AT = CURRENT_TIMESTAMP WHERE RUNID = ? AND STATUS = 'RUNNING'",
                   (run_id,))


def abandon_stale_runs(db: Db, stale_min: int) -> int:
    rows = db.query("SELECT RUNID FROM TPI_RUN WHERE STATUS = 'RUNNING' "
                    "AND HEARTBEAT_AT < DATEADD(? MINUTE TO CURRENT_TIMESTAMP)", (-stale_min,))
    for r in rows:
        db.execute("UPDATE TPI_RUN SET STATUS = 'ERROR', FINISHED_AT = CURRENT_TIMESTAMP, "
                   "ERROR_TEXT = 'ABANDONED: procesul s-a oprit in timpul rularii' WHERE RUNID = ?", (r["RUNID"],))
    return len(rows)


def insert_errors(db: Db, run_id: int, stage: str, errors: list[RowError], endpoint: str | None = None,
                  http_status: int | None = None, retries: int = 0) -> None:
    db.executemany(
        "INSERT INTO TPI_RUN_ERROR (RUNID, SEVERITY, STAGE, ERROR_CLASS, ENDPOINT, HTTP_STATUS, ROW_NO, "
        "SUPPLIER_GOODS_CODE, RETRIES, MESSAGE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        ((run_id, e.severity.value, stage, e.error_class[:64], (endpoint or "")[:512] or None, http_status,
          e.row_no, (e.code or "")[:128] or None, retries, e.message[:1024]) for e in errors[:MAX_ERROR_ROWS]))


def insert_error(db: Db, run_id: int, severity: Severity, stage: str, error_class: str, message: str,
                 endpoint: str | None = None, http_status: int | None = None, retries: int = 0) -> None:
    insert_errors(db, run_id, stage, [RowError(error_class, message, severity=severity)],
                  endpoint=endpoint, http_status=http_status, retries=retries)


def insert_changes(db: Db, run_id: int, supplier_id: int, changes: list[Change]) -> int:
    return db.executemany(
        "INSERT INTO TPI_ITEM_CHANGE (RUNID, SUPPLIERID, SUPPLIER_GOODS_CODE, GOODSID, CHANGE_TYPE, PRICE_FIELD, "
        "OLD_PRICE, NEW_PRICE, OLD_CURRENCYID, NEW_CURRENCYID, DELTA_PCT, OLD_STOCK, NEW_STOCK, "
        "SUPPLIER_GOODS_NAME, SUPPLIER_CATEGORY, DECISION, REASON_CODE) "
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        ((run_id, supplier_id, c.code[:128], c.goodsid, c.change_type.value, c.price_field,
          _money(c.old_price), _money(c.new_price), c.old_cur, c.new_cur,
          None if c.delta_pct is None else round(max(min(c.delta_pct, 999999.0), -999999.0), 3),
          (c.old_stock or None) and c.old_stock[:64], (c.new_stock or None) and c.new_stock[:64],
          (c.name or None) and c.name[:1024], (c.category or None) and c.category[:128],
          c.decision.value, c.reason) for c in changes))


def _money(v: float | None) -> float | None:
    return None if v is None else round(v, 4)


def recent_durations(db: Db, supplier_id: int, limit: int = 10) -> list[int]:
    rows = db.query(f"SELECT FIRST {int(limit)} DATEDIFF(SECOND FROM STARTED_AT TO FINISHED_AT) AS D "
                    "FROM TPI_RUN WHERE SUPPLIERID = ? AND FINISHED_AT IS NOT NULL "
                    "AND STATUS IN ('DRY_RUN', 'APPLIED', 'PARTIAL', 'UNCHANGED') ORDER BY RUNID DESC",
                    (supplier_id,))
    return [r["D"] for r in rows if r["D"] is not None]


def set_est_duration(db: Db, supplier_id: int, seconds: int) -> None:
    db.execute("UPDATE TPI_SUPPLIER SET EST_DURATION_SEC = ? WHERE SUPPLIERID = ?", (seconds, supplier_id))


def heartbeat(db: Db, instance: str, version: str, host: str, pid: int, info: str | None = None) -> None:
    db.execute("UPDATE OR INSERT INTO TPI_HEARTBEAT (INSTANCE, HEARTBEAT_AT, VERSION, HOST, PID, INFO) "
               "VALUES (?, CURRENT_TIMESTAMP, ?, ?, ?, ?) MATCHING (INSTANCE)",
               (instance, version, host[:64], pid, (info or "")[:1024] or None))


def recent_runs(db: Db, limit: int = 30) -> list[dict[str, Any]]:
    return db.query(f"SELECT FIRST {int(limit)} * FROM VW_TPI_RUN ORDER BY RUNID DESC")


# --- Telegram ------------------------------------------------------------------------------

def telegram_send(db: Db, channel: str, text: str, source_id: int | None = None, priority: int = 0) -> None:
    db.execute("EXECUTE PROCEDURE SP_TELEGRAM_SEND(?, ?, ?, ?, ?, ?)",
               (channel, text[:4096], "HTML", TELEGRAM_SOURCE_TABLE, source_id, priority))
