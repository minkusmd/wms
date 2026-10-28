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
    "BASELINE",
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


# --- etapa 2: tabele optionale (serviciul merge si cu DDL-ul etapei 1) ----------------------

def has_table(db: Db, name: str) -> bool:
    return bool(db.scalar("SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = ?", (name,)))


def stage2_ready(db: Db) -> bool:
    return bool(db.scalar(
        "SELECT COUNT(*) FROM RDB$RELATIONS WHERE RDB$RELATION_NAME IN "
        "('TPI_QUARANTINE', 'TPI_APPLY_BATCH', 'TPI_APPLY_ROW', 'TPI_ALERT_STATE', 'TPI_GOODS_EVENT')") == 5)


def load_run(db: Db, run_id: int) -> dict[str, Any] | None:
    return db.query_one("SELECT * FROM TPI_RUN WHERE RUNID = ?", (run_id,))


def newer_runs_exist(db: Db, supplier_id: int, run_id: int) -> bool:
    """Rulari mai noi pe baza TS_GOODS_FOREIGN (au refacut deciziile); cele pe baza 'prev' nu conteaza."""
    return bool(db.scalar("SELECT 1 FROM RDB$DATABASE WHERE EXISTS (SELECT 1 FROM TPI_RUN WHERE SUPPLIERID = ? "
                          "AND RUNID > ? AND BASELINE = 'gf' AND STATUS IN ('DRY_RUN', 'APPLIED', 'PARTIAL', 'BLOCKED'))",
                          (supplier_id, run_id)))


def plid_applied_by_service(db: Db, plid: int) -> bool:
    """PLID-ul a fost prelucrat chiar de PriceImport (nu de WMS / WMSParsers)."""
    return bool(db.scalar("SELECT 1 FROM RDB$DATABASE WHERE EXISTS (SELECT 1 FROM TPI_APPLY_BATCH b "
                          "JOIN TPI_RUN r ON r.RUNID = b.RUNID WHERE r.PLID = ? AND b.OPERATION = 'APPLY' "
                          "AND b.STATUS IN ('DONE', 'PARTIAL'))", (plid,)))


def load_run_changes(db: Db, run_id: int) -> list[dict[str, Any]]:
    return db.query("SELECT * FROM TPI_ITEM_CHANGE WHERE RUNID = ? ORDER BY CHANGEID", (run_id,))


def set_pricelist_done(db: Db, plid: int) -> None:
    db.execute("UPDATE TS_PRICELISTS SET FLAGS = SET_FLG_VALUE(FLAGS, 4, 1) WHERE PLID = ?", (plid,))


def set_session_user(db: Db, user_id: int) -> None:
    db.scalar("SELECT RDB$SET_CONTEXT('USER_SESSION', 'UserID', ?) FROM RDB$DATABASE", (user_id,))


def insert_snapshot(db: Db, supplier_id: int, price_category_id: int, note: str, items: list[SupplierItem]) -> int:
    """Pricelistul adaptoarelor native (TS_PRICELISTS FLAGS = 2 = FLG_API), ca importurile din WMS."""
    plid = db.execute_returning(
        "INSERT INTO TS_PRICELISTS (SUPPLIERID, PRICE_CATEGORYID, MENTIUNI, FLAGS) VALUES (?, ?, ?, 2) RETURNING PLID",
        (supplier_id, price_category_id, note[:128]))
    db.executemany(
        "INSERT INTO TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, PRICE0, CURRENCY0ID, "
        "PRICE3, CURRENCY3ID, PRICE7, CURRENCY7ID, STOCK_QTY, SUPPLIER_GOODS_BRAND, SUPPLIER_GOODS_MODEL, "
        "SUPPLIER_CATEGORY) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        ((plid, i.code, (i.name or "")[:2048], i.price0, i.cur0, i.price3, i.cur3, i.price7, i.cur7,
          (i.stock or None) and i.stock[:16], (i.brand or None) and i.brand[:128],
          (i.model or None) and i.model[:255], (i.category or None) and i.category[:128]) for i in items))
    return plid


# --- carantina -----------------------------------------------------------------------------

def create_quarantine(db: Db, run_id: int, supplier_id: int, expire_days: int) -> int:
    """Randurile cu motiv propriu (nu ITEM_QUARANTINED); rularea noua inlocuieste carantina veche."""
    db.execute("UPDATE TPI_QUARANTINE SET STATUS = 'SUPERSEDED' WHERE SUPPLIERID = ? AND STATUS = 'PENDING' "
               "AND RUNID < ?", (supplier_id, run_id))
    db.execute("UPDATE TPI_QUARANTINE SET STATUS = 'EXPIRED' WHERE STATUS = 'PENDING' "
               "AND EXPIRES_AT < CURRENT_TIMESTAMP")
    db.execute(
        "INSERT INTO TPI_QUARANTINE (CHANGEID, RUNID, SUPPLIERID, SUPPLIER_GOODS_CODE, GOODSID, EXPIRES_AT) "
        "SELECT c.CHANGEID, c.RUNID, c.SUPPLIERID, c.SUPPLIER_GOODS_CODE, c.GOODSID, "
        "DATEADD(? DAY TO CURRENT_TIMESTAMP) FROM TPI_ITEM_CHANGE c "
        "WHERE c.RUNID = ? AND c.DECISION = 'QUARANTINE' AND COALESCE(c.REASON_CODE, '') <> 'ITEM_QUARANTINED' "
        "AND NOT EXISTS (SELECT 1 FROM TPI_QUARANTINE q WHERE q.CHANGEID = c.CHANGEID)", (expire_days, run_id))
    return db.scalar("SELECT COUNT(*) FROM TPI_QUARANTINE WHERE RUNID = ? AND STATUS = 'PENDING'", (run_id,))


def approved_keys(db: Db, supplier_id: int, days: int) -> set[tuple]:
    """(cod, goodsid, coloana, pret nou rotunjit, moneda) aprobate recent: aceeasi valoare trece la rularea urmatoare."""
    rows = db.query(
        "SELECT c.SUPPLIER_GOODS_CODE, c.GOODSID, c.PRICE_FIELD, c.NEW_PRICE, c.NEW_CURRENCYID "
        "FROM TPI_QUARANTINE q JOIN TPI_ITEM_CHANGE c ON c.CHANGEID = q.CHANGEID "
        "WHERE q.SUPPLIERID = ? AND q.STATUS = 'APPROVED' AND q.DECIDED_AT > DATEADD(? DAY TO CURRENT_TIMESTAMP)",
        (supplier_id, -days))
    return {approval_key(r["SUPPLIER_GOODS_CODE"], r["GOODSID"], r["PRICE_FIELD"], _f(r["NEW_PRICE"]),
                         r["NEW_CURRENCYID"]) for r in rows}


def approval_key(code: str, goodsid: int | None, field: int | None, new_price: float | None,
                 new_cur: int | None) -> tuple:
    return (code, goodsid, field, None if new_price is None else round(new_price, 2), new_cur)


def list_quarantine(db: Db, supplier_id: int | None = None, status: str = "PENDING") -> list[dict[str, Any]]:
    sql = ("SELECT q.QID, q.RUNID, q.SUPPLIERID, q.SUPPLIER_GOODS_CODE, q.GOODSID, q.STATUS, q.CREATED_AT, "
           "c.PRICE_FIELD, c.OLD_PRICE, c.NEW_PRICE, c.OLD_CURRENCYID, c.NEW_CURRENCYID, c.DELTA_PCT, c.REASON_CODE, "
           "c.SUPPLIER_GOODS_NAME FROM TPI_QUARANTINE q JOIN TPI_ITEM_CHANGE c ON c.CHANGEID = q.CHANGEID "
           "WHERE q.STATUS = ?")
    params: list[Any] = [status]
    if supplier_id is not None:
        sql += " AND q.SUPPLIERID = ?"
        params.append(supplier_id)
    return db.query(sql + " ORDER BY q.QID", params)


def decide_quarantine(db: Db, qid: int, status: str, decided_by: str, note: str | None = None) -> dict[str, Any] | None:
    row = db.query_one("SELECT QID, RUNID, SUPPLIERID, SUPPLIER_GOODS_CODE, GOODSID, STATUS FROM TPI_QUARANTINE "
                       "WHERE QID = ?", (qid,))
    if row is None or row["STATUS"].strip() != "PENDING":
        return row
    db.execute("UPDATE TPI_QUARANTINE SET STATUS = ?, DECIDED_BY = ?, DECIDED_AT = CURRENT_TIMESTAMP, NOTE = ? "
               "WHERE QID = ?", (status, decided_by[:64], (note or None) and note[:512], qid))
    if status == "APPROVED":
        # produsul se aplica intreg: toate randurile lui din rulare trec pe APPLY
        db.execute("UPDATE TPI_ITEM_CHANGE SET DECISION = 'APPLY', REASON_CODE = 'APPROVED' WHERE RUNID = ? "
                   "AND SUPPLIER_GOODS_CODE = ? AND GOODSID IS NOT DISTINCT FROM ? AND DECISION = 'QUARANTINE'",
                   (row["RUNID"], row["SUPPLIER_GOODS_CODE"], row["GOODSID"]))
    return row


# --- aplicarea -----------------------------------------------------------------------------

def insert_apply_batch(db: Db, run_id: int, operation: str, supplier_id: int, firma_id: int, user_id: int,
                       rrp_discount: float, test: bool) -> int:
    return db.execute_returning(
        "INSERT INTO TPI_APPLY_BATCH (RUNID, OPERATION, SUPPLIERID, FIRMAID, USERID, RRP_DISCOUNT, FLG_TEST) "
        "VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING BATCHID",
        (run_id, operation, supplier_id, firma_id, user_id, rrp_discount, int(test)))


def insert_apply_rows(db: Db, batch_id: int, rows: Iterable[Any]) -> int:
    return db.executemany(
        "INSERT INTO TPI_APPLY_ROW (BATCHID, KIND, GOODSID, SUPPLIER_GOODS_CODE, PRICE0, CURRENCY0ID, PRICE3, "
        "CURRENCY3ID, PRICE7, CURRENCY7ID, FLG_EPP) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        ((batch_id, r.kind, r.goodsid, r.code, r.price0, r.cur0, r.price3, r.cur3, r.price7, r.cur7, int(r.flg_epp))
         for r in rows))


def apply_kind(db: Db, batch_id: int, kind: int) -> tuple[int, int, int]:
    """SP_PI_APPLY_KIND: (DOCID, randuri, respinse la inchidere)."""
    with db.con.cursor() as cur:
        cur.execute("EXECUTE PROCEDURE SP_PI_APPLY_KIND(?, ?)", (batch_id, kind))
        row = cur.fetchone()
    docid, n_rows, n_rejected = row if row else (0, 0, 0)
    return int(docid or 0), int(n_rows or 0), int(n_rejected or 0)


def rejected_rows(db: Db, batch_id: int, kind: int) -> list[dict[str, Any]]:
    return db.query("SELECT SUPPLIER_GOODS_CODE, GOODSID, REJECT_MSG FROM TPI_APPLY_ROW WHERE BATCHID = ? "
                    "AND KIND = ? AND FLG_REJECTED = 1", (batch_id, kind))


def finish_apply_batch(db: Db, batch_id: int, status: str, docids: list[int], n_rows: int, n_rejected: int,
                       error: str | None = None) -> None:
    db.execute("UPDATE TPI_APPLY_BATCH SET STATUS = ?, FINISHED_AT = CURRENT_TIMESTAMP, DOCIDS = ?, N_ROWS = ?, "
               "N_REJECTED = ?, ERROR_TEXT = ? WHERE BATCHID = ?",
               (status, ",".join(map(str, docids))[:256] or None, n_rows, n_rejected,
                (error or None) and error[:2048], batch_id))


def mark_changes_applied(db: Db, run_id: int, code: str, goodsid: int | None, docid: int) -> None:
    db.execute("UPDATE TPI_ITEM_CHANGE SET APPLIED_DOCID = ? WHERE RUNID = ? AND SUPPLIER_GOODS_CODE = ? "
               "AND GOODSID IS NOT DISTINCT FROM ? AND DECISION = 'APPLY' AND APPLIED_DOCID IS NULL",
               (docid, run_id, code, goodsid))


def mark_changes(db: Db, run_id: int, code: str, goodsid: int | None, decision: str, reason: str) -> None:
    db.execute("UPDATE TPI_ITEM_CHANGE SET DECISION = ?, REASON_CODE = ? WHERE RUNID = ? AND SUPPLIER_GOODS_CODE = ? "
               "AND GOODSID IS NOT DISTINCT FROM ? AND DECISION = 'APPLY' AND APPLIED_DOCID IS NULL",
               (decision, reason, run_id, code, goodsid))


def later_applied_codes(db: Db, supplier_id: int, run_id: int) -> set[tuple[str, int | None]]:
    rows = db.query("SELECT DISTINCT c.SUPPLIER_GOODS_CODE, c.GOODSID FROM TPI_ITEM_CHANGE c "
                    "WHERE c.SUPPLIERID = ? AND c.RUNID > ? AND c.APPLIED_DOCID IS NOT NULL", (supplier_id, run_id))
    return {(r["SUPPLIER_GOODS_CODE"], r["GOODSID"]) for r in rows}


def insert_goods_events(db: Db, run_id: int, events: Iterable[tuple[int, str]]) -> int:
    return db.executemany("INSERT INTO TPI_GOODS_EVENT (GOODSID, EVENT_TYPE, RUNID) VALUES (?, ?, ?)",
                          ((goodsid, kind, run_id) for goodsid, kind in events))


# --- deduplicarea alertelor ----------------------------------------------------------------

def alert_should_send(db: Db, key: str, severity: str, message: str, repeat_min: int,
                      supplier_id: int | None = None) -> bool:
    row = db.query_one("SELECT RESOLVED_AT, "
                       "IIF(LAST_SENT_AT IS NULL OR LAST_SENT_AT < DATEADD(? MINUTE TO CURRENT_TIMESTAMP), 1, 0) AS DUE, "
                       "IIF(MUTED_UNTIL > CURRENT_TIMESTAMP, 1, 0) AS MUTED FROM TPI_ALERT_STATE WHERE ALERT_KEY = ?",
                       (-repeat_min, key))
    if row is None:
        db.execute("INSERT INTO TPI_ALERT_STATE (ALERT_KEY, SEVERITY, SUPPLIERID, FIRST_SEEN, LAST_SEEN, OCCURRENCES, "
                   "LAST_SENT_AT, LAST_MESSAGE) VALUES (?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, "
                   "CURRENT_TIMESTAMP, ?)", (key[:128], severity, supplier_id, message[:512]))
        return True
    if row["RESOLVED_AT"] is not None:
        db.execute("UPDATE TPI_ALERT_STATE SET FIRST_SEEN = CURRENT_TIMESTAMP, LAST_SEEN = CURRENT_TIMESTAMP, "
                   "OCCURRENCES = 1, RESOLVED_AT = NULL, LAST_SENT_AT = CURRENT_TIMESTAMP, LAST_MESSAGE = ? "
                   "WHERE ALERT_KEY = ?", (message[:512], key))
        return not row["MUTED"]
    send = bool(row["DUE"]) and not row["MUTED"]
    db.execute("UPDATE TPI_ALERT_STATE SET LAST_SEEN = CURRENT_TIMESTAMP, OCCURRENCES = OCCURRENCES + 1, "
               "LAST_MESSAGE = ?" + (", LAST_SENT_AT = CURRENT_TIMESTAMP" if send else "") + " WHERE ALERT_KEY = ?",
               (message[:512], key))
    return send


def resolve_alerts(db: Db, key_prefix: str) -> list[dict[str, Any]]:
    """Alertele deschise care incep cu prefixul devin rezolvate; intoarce cele care fusesera trimise."""
    rows = db.query("SELECT ALERT_KEY, OCCURRENCES, LAST_SENT_AT FROM TPI_ALERT_STATE "
                    "WHERE ALERT_KEY STARTING WITH ? AND RESOLVED_AT IS NULL", (key_prefix,))
    for r in rows:
        db.execute("UPDATE TPI_ALERT_STATE SET RESOLVED_AT = CURRENT_TIMESTAMP WHERE ALERT_KEY = ?", (r["ALERT_KEY"],))
    return [r for r in rows if r["LAST_SENT_AT"] is not None]


def mute_alerts(db: Db, key_prefix: str, hours: int) -> int:
    db.execute("UPDATE TPI_ALERT_STATE SET MUTED_UNTIL = DATEADD(? HOUR TO CURRENT_TIMESTAMP) "
               "WHERE ALERT_KEY STARTING WITH ?", (hours, key_prefix))
    return int(db.scalar("SELECT COUNT(*) FROM TPI_ALERT_STATE WHERE ALERT_KEY STARTING WITH ?", (key_prefix,)) or 0)


# --- etapa 3: botul Telegram ---------------------------------------------------------------

def bot_user(db: Db, tg_user_id: int) -> dict[str, Any] | None:
    return db.query_one("SELECT TG_USER_ID, NAME, ROLE_CODE FROM TPI_BOT_USER WHERE TG_USER_ID = ? AND FLG_ACTIVE = 1",
                        (tg_user_id,))


def bot_state_get(db: Db, name: str) -> str | None:
    return db.scalar("SELECT PARAM_VALUE FROM TPI_BOT_STATE WHERE PARAM_NAME = ?", (name,))


def bot_state_set(db: Db, name: str, value: str) -> None:
    db.execute("UPDATE OR INSERT INTO TPI_BOT_STATE (PARAM_NAME, PARAM_VALUE, UPDATED_AT) "
               "VALUES (?, ?, CURRENT_TIMESTAMP) MATCHING (PARAM_NAME)", (name, value[:1024]))


def inbox_by_unique_id(db: Db, unique_id: str) -> dict[str, Any] | None:
    return db.query_one("SELECT * FROM TPI_INBOX_FILE WHERE TG_FILE_UNIQUE_ID = ?", (unique_id,))


def inbox_by_sha(db: Db, sha: str) -> dict[str, Any] | None:
    return db.query_one("SELECT FIRST 1 * FROM TPI_INBOX_FILE WHERE SHA256 = ? AND STATUS <> 'DUPLICATE' "
                        "ORDER BY FILEID", (sha,))


def inbox_get(db: Db, file_id: int) -> dict[str, Any] | None:
    return db.query_one("SELECT * FROM TPI_INBOX_FILE WHERE FILEID = ?", (file_id,))


def inbox_insert(db: Db, **values: Any) -> int:
    cols = list(values)
    return db.execute_returning(
        f"INSERT INTO TPI_INBOX_FILE ({', '.join(cols)}) VALUES ({', '.join('?' * len(cols))}) RETURNING FILEID",
        [values[c] for c in cols])


_INBOX_COLUMNS = {"SUPPLIERID", "DETECT_METHOD", "DETECT_SCORE", "STATUS", "RUNID", "DECIDED_BY", "NOTE",
                  "STORAGE_PATH"}


def inbox_update(db: Db, file_id: int, decided: bool = False, **fields: Any) -> None:
    sets, params = [], []
    for key, value in fields.items():
        col = key.upper()
        if col not in _INBOX_COLUMNS:
            raise KeyError(col)
        if col == "NOTE" and value is not None:
            value = str(value)[:1024]
        sets.append(f"{col} = ?")
        params.append(value)
    if decided:
        sets.append("DECIDED_AT = CURRENT_TIMESTAMP")
    db.execute(f"UPDATE TPI_INBOX_FILE SET {', '.join(sets)} WHERE FILEID = ?", params + [file_id])


def file_rules(db: Db) -> list[dict[str, Any]]:
    return db.query("SELECT SUPPLIERID, RULE_TYPE, PATTERN, WEIGHT FROM TPI_FILE_RULE WHERE FLG_ACTIVE = 1")


def learn_file_rule(db: Db, supplier_id: int, rule_type: str, pattern: str) -> bool:
    """Regula invatata dintr-o alegere facuta in bot (o singura data per furnizor + valoare)."""
    exists = db.scalar("SELECT 1 FROM RDB$DATABASE WHERE EXISTS (SELECT 1 FROM TPI_FILE_RULE WHERE SUPPLIERID = ? "
                       "AND RULE_TYPE = ? AND PATTERN = ?)", (supplier_id, rule_type, pattern))
    if exists:
        return False
    db.execute("INSERT INTO TPI_FILE_RULE (SUPPLIERID, RULE_TYPE, PATTERN, FLG_LEARNED) VALUES (?, ?, ?, 1)",
               (supplier_id, rule_type, pattern[:1024]))
    return True


def sku_overlap(db: Db, codes: list[str]) -> dict[int, int]:
    """Furnizor -> cite dintre coduri exista deja in TS_GOODS_FOREIGN la el."""
    counts: dict[int, int] = {}
    unique = sorted(set(codes))
    for i in range(0, len(unique), 200):
        chunk = unique[i:i + 200]
        rows = db.query("SELECT CUSTOMERID, COUNT(DISTINCT GOODS_CODE) AS N FROM TS_GOODS_FOREIGN "
                        f"WHERE GOODS_CODE IN ({','.join('?' * len(chunk))}) GROUP BY CUSTOMERID", chunk)
        for r in rows:
            counts[r["CUSTOMERID"]] = counts.get(r["CUSTOMERID"], 0) + int(r["N"])
    return counts


def supplier_names(db: Db, ids: Iterable[int]) -> dict[int, str]:
    ids = sorted(set(ids))
    if not ids:
        return {}
    rows = db.query(f"SELECT CUSTOMERID, NAME FROM TS_CUSTOMER WHERE CUSTOMERID IN ({','.join('?' * len(ids))})", ids)
    return {r["CUSTOMERID"]: (r["NAME"] or "").strip() for r in rows}


# --- etapa 4a: potrivirea produselor ------------------------------------------------------

def latest_analyzed_run(db: Db, supplier_id: int) -> dict[str, Any] | None:
    return db.query_one("SELECT FIRST 1 RUNID, PLID FROM TPI_RUN WHERE SUPPLIERID = ? "
                        "AND STATUS IN ('DRY_RUN', 'APPLIED', 'PARTIAL', 'BLOCKED') ORDER BY RUNID DESC", (supplier_id,))


def new_codes_of_run(db: Db, run_id: int) -> list[dict[str, Any]]:
    """Codurile NEW (nelegate) ale rularii, fara cele legate intre timp."""
    return db.query("SELECT c.SUPPLIER_GOODS_CODE, c.SUPPLIER_GOODS_NAME, c.SUPPLIER_CATEGORY, c.SUPPLIERID "
                    "FROM TPI_ITEM_CHANGE c WHERE c.RUNID = ? AND c.CHANGE_TYPE = 'NEW' AND NOT EXISTS "
                    "(SELECT 1 FROM TS_GOODS_FOREIGN gf WHERE gf.CUSTOMERID = c.SUPPLIERID "
                    "AND gf.GOODS_CODE = c.SUPPLIER_GOODS_CODE)", (run_id,))


def candidate_decisions(db: Db, supplier_id: int) -> dict[tuple[str, int], str]:
    rows = db.query("SELECT SUPPLIER_GOODS_CODE, GOODSID, STATUS FROM TPI_MATCH_CANDIDATE WHERE SUPPLIERID = ?",
                    (supplier_id,))
    return {(r["SUPPLIER_GOODS_CODE"], r["GOODSID"]): r["STATUS"].strip() for r in rows}


def save_candidate(db: Db, run_id: int, supplier_id: int, code: str, name: str | None, goodsid: int, method: str,
                   score: float, detail: str, existing: str | None) -> bool:
    """Propunere noua sau reimprospatata; deciziile (ACCEPTED / REJECTED) nu se ating. True = rind nou."""
    if existing is None:
        db.execute("INSERT INTO TPI_MATCH_CANDIDATE (SUPPLIERID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, GOODSID, "
                   "METHOD, SCORE, DETAIL, FIRST_SEEN_RUNID, LAST_SEEN_RUNID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                   (supplier_id, code[:128], (name or "")[:1024] or None, goodsid, method, score, detail[:256],
                    run_id, run_id))
        return True
    if existing == "PROPOSED":
        db.execute("UPDATE TPI_MATCH_CANDIDATE SET METHOD = ?, SCORE = ?, DETAIL = ?, LAST_SEEN_RUNID = ? "
                   "WHERE SUPPLIERID = ? AND SUPPLIER_GOODS_CODE = ? AND GOODSID = ?",
                   (method, score, detail[:256], run_id, supplier_id, code, goodsid))
    return False


def list_candidates(db: Db, supplier_id: int | None = None, status: str = "PROPOSED",
                    limit: int = 50) -> list[dict[str, Any]]:
    sql = (f"SELECT FIRST {int(limit)} m.CANDID, m.SUPPLIERID, m.SUPPLIER_GOODS_CODE, m.SUPPLIER_GOODS_NAME, "
           "m.GOODSID, g.TITLE, m.METHOD, m.SCORE, m.DETAIL FROM TPI_MATCH_CANDIDATE m "
           "LEFT JOIN TS_GOODS g ON g.GOODSID = m.GOODSID WHERE m.STATUS = ?")
    params: list[Any] = [status]
    if supplier_id is not None:
        sql += " AND m.SUPPLIERID = ?"
        params.append(supplier_id)
    return db.query(sql + " ORDER BY m.SCORE DESC, m.CANDID", params)


def count_candidates(db: Db, status: str = "PROPOSED") -> int:
    return int(db.scalar("SELECT COUNT(*) FROM TPI_MATCH_CANDIDATE WHERE STATUS = ?", (status,)) or 0)


def get_candidate(db: Db, cand_id: int) -> dict[str, Any] | None:
    return db.query_one("SELECT * FROM TPI_MATCH_CANDIDATE WHERE CANDID = ?", (cand_id,))


def link_goods(db: Db, supplier_id: int, code: str, goodsid: int, title: str | None, user_id: int) -> str:
    with db.con.cursor() as cur:
        cur.execute("EXECUTE PROCEDURE SP_PI_LINK_GOODS(?, ?, ?, ?, ?)", (supplier_id, code, goodsid, title, user_id))
        row = cur.fetchone()
    return (row[0] or "").strip() if row else ""


def decide_candidate(db: Db, cand_id: int, status: str, decided_by: str) -> None:
    db.execute("UPDATE TPI_MATCH_CANDIDATE SET STATUS = ?, DECIDED_BY = ?, DECIDED_AT = CURRENT_TIMESTAMP "
               "WHERE CANDID = ?", (status, decided_by[:64], cand_id))


def supersede_other_candidates(db: Db, supplier_id: int, code: str, cand_id: int) -> None:
    db.execute("UPDATE TPI_MATCH_CANDIDATE SET STATUS = 'SUPERSEDED' WHERE SUPPLIERID = ? AND SUPPLIER_GOODS_CODE = ? "
               "AND CANDID <> ? AND STATUS = 'PROPOSED'", (supplier_id, code, cand_id))
