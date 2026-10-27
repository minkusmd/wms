"""Rularea unui furnizor: lacat, etape (FETCH -> DIFF -> REPORT), jurnal in TPI_RUN.

Etapa 1 din plan: nicio scriere in afara TPI_* - rularea reusita se termina cu statusul DRY_RUN.
"""

from __future__ import annotations

import os
import socket
import statistics
import threading
import time
import uuid
from dataclasses import dataclass, field
from datetime import datetime

import zstandard
from firebird.driver import DatabaseError

from . import repo
from .adapters import AdapterError, DeadlineExceeded, RunContext, get_adapter
from .config import Settings, load_supplier_yaml
from .db import Db, open_db
from .diff import BASELINE_GF, DiffResult, diff_against_gf, diff_against_prev
from .log import get_logger
from .models import ChangeType, Decision, FetchResult, RowError, RunStatus, Severity
from .repo import SupplierConfig
from .thresholds import apply_thresholds, run_guards

log = get_logger(__name__)

HOST = socket.gethostname()
PID = os.getpid()

# rularile active ale procesului; firul de heartbeat al serviciului le actualizeaza HEARTBEAT_AT
_active_lock = threading.Lock()
ACTIVE_RUNS: set[int] = set()


def active_runs() -> list[int]:
    with _active_lock:
        return sorted(ACTIVE_RUNS)


@dataclass
class RunOutcome:
    supplier: SupplierConfig
    status: RunStatus
    run_id: int | None = None
    trigger: str = "MANUAL"
    duration_sec: float = 0.0
    plid: int | None = None
    baseline: str | None = None
    n_valid: int = 0
    n_fetched: int = 0
    diff: DiffResult | None = None
    errors: list[RowError] = field(default_factory=list)
    error_endpoint: str | None = None
    error_http: int | None = None
    error_retries: int = 0
    note: str | None = None

    @property
    def changes(self):
        return self.diff.changes if self.diff else []


def make_key(supplier_id: int, trigger: str, slot: str | None) -> str:
    if trigger == "SCHEDULE" and slot:
        return f"{supplier_id}|{slot}"
    return f"{supplier_id}|{trigger.lower()}|{datetime.now():%Y%m%d%H%M%S}|{uuid.uuid4().hex[:8]}"


def _archive_raw(settings: Settings, supplier_id: int, run_id: int, payload: bytes) -> str:
    folder = settings.data_dir / "raw" / str(supplier_id) / f"{datetime.now():%Y-%m-%d}"
    folder.mkdir(parents=True, exist_ok=True)
    path = folder / f"{run_id}.json.zst"
    path.write_bytes(zstandard.ZstdCompressor(level=10).compress(payload))
    return str(path)


def _is_active_run_conflict(exc: Exception) -> bool:
    return "UX_TPI_RUN_ACTIVE" in str(exc).upper()


def _prev_run_sha(db: Db, supplier_id: int, run_id: int) -> str | None:
    row = db.query_one("SELECT FIRST 1 SOURCE_SHA256 FROM TPI_RUN WHERE SUPPLIERID = ? AND RUNID < ? "
                       "AND SOURCE_SHA256 IS NOT NULL AND STATUS IN ('DRY_RUN', 'APPLIED', 'PARTIAL') "
                       "ORDER BY RUNID DESC", (supplier_id, run_id))
    return row["SOURCE_SHA256"].strip() if row else None


def run_supplier(settings: Settings, supplier: SupplierConfig, *, trigger: str = "MANUAL",
                 slot: str | None = None, deadline: float | None = None, plid: int | None = None) -> RunOutcome:
    started = time.monotonic()
    outcome = RunOutcome(supplier=supplier, status=RunStatus.ERROR, trigger=trigger)
    key = make_key(supplier.supplier_id, trigger, slot)
    with open_db(settings) as db:
        existing = repo.find_run_by_key(db, key)
        if existing:
            outcome.status, outcome.run_id = RunStatus.SKIPPED, existing["RUNID"]
            outcome.note = f"rulat deja in fereastra {slot} (#{existing['RUNID']}, {existing['STATUS'].strip()})"
            return outcome
        try:
            run_id = repo.insert_run(db, supplier.supplier_id, trigger, slot, key, True, HOST, PID)
            db.commit()
        except DatabaseError as exc:
            db.rollback()
            if not _is_active_run_conflict(exc):
                raise
            outcome.status = RunStatus.SKIPPED
            outcome.note = "alta rulare a acestui furnizor e inca activa"
            outcome.run_id = repo.insert_skipped_run(db, supplier.supplier_id, trigger, slot, key, outcome.note)
            db.commit()
            return outcome

        outcome.run_id = run_id
        with _active_lock:
            ACTIVE_RUNS.add(run_id)
        log.info("run_start", run_id=run_id, supplier=supplier.supplier_id, adapter=supplier.adapter_code,
                 trigger=trigger, slot=slot)
        try:
            _run_stages(settings, db, supplier, outcome, deadline, plid)
        except AdapterError as exc:
            db.rollback()
            outcome.status = RunStatus.TIMEOUT if isinstance(exc, DeadlineExceeded) else RunStatus.ERROR
            outcome.errors.append(RowError(exc.error_class, str(exc), severity=Severity.CRIT))
            outcome.error_endpoint, outcome.error_http, outcome.error_retries = exc.endpoint, exc.http_status, exc.retries
            repo.insert_error(db, run_id, Severity.CRIT, "FETCH", exc.error_class, str(exc),
                              endpoint=exc.endpoint, http_status=exc.http_status, retries=exc.retries)
            repo.update_run(db, run_id, finished=True, status=outcome.status.value, error_text=str(exc))
            db.commit()
        except Exception as exc:          # noqa: BLE001 - orice eroare neprevazuta ajunge in jurnal
            log.exception("run_failed", run_id=run_id, supplier=supplier.supplier_id)
            outcome.status = RunStatus.ERROR
            outcome.errors.append(RowError("INTERNAL", f"{type(exc).__name__}: {exc}", severity=Severity.CRIT))
            _finish_failed(settings, run_id, f"{type(exc).__name__}: {exc}")
        finally:
            with _active_lock:
                ACTIVE_RUNS.discard(run_id)
            outcome.duration_sec = time.monotonic() - started
            log.info("run_end", run_id=run_id, supplier=supplier.supplier_id, status=outcome.status.value,
                     duration=round(outcome.duration_sec, 1))
    return outcome


def _finish_failed(settings: Settings, run_id: int, message: str) -> None:
    """Conexiune noua: cea a rularii poate fi chiar cauza erorii."""
    try:
        with open_db(settings) as db:
            repo.insert_error(db, run_id, Severity.CRIT, "INTERNAL", "INTERNAL", message)
            repo.update_run(db, run_id, finished=True, status=RunStatus.ERROR.value, error_text=message)
            db.commit()
    except Exception:                     # noqa: BLE001
        log.exception("run_fail_record_failed", run_id=run_id)


def _run_stages(settings: Settings, db: Db, supplier: SupplierConfig, outcome: RunOutcome,
                deadline: float | None, plid: int | None) -> None:
    run_id = outcome.run_id
    assert run_id is not None
    params = load_supplier_yaml(settings, supplier.supplier_id)
    iso, rates = repo.load_currencies(db)
    ctx = RunContext(settings=settings, supplier=supplier, db=db, params=params, currency_ids=iso,
                     deadline=deadline, plid=plid,
                     progress=lambda msg: log.info("progress", run_id=run_id, msg=msg))

    # --- FETCH
    fetch: FetchResult = get_adapter(supplier.adapter_code).fetch(ctx)
    db.commit()                            # inchide tranzactia de citire inainte de pasii urmatori
    outcome.plid, outcome.n_fetched, outcome.n_valid = fetch.plid, fetch.n_fetched, len(fetch.items)
    outcome.note = fetch.note
    outcome.errors.extend(fetch.warnings)
    raw_path = _archive_raw(settings, supplier.supplier_id, run_id, fetch.raw_payload) if fetch.raw_payload else None
    if fetch.warnings:
        repo.insert_errors(db, run_id, "FETCH", fetch.warnings)
    if fetch.row_errors:
        repo.insert_errors(db, run_id, "NORMALIZE", fetch.row_errors)
        outcome.errors.extend(fetch.row_errors[:20])
    common = dict(plid=fetch.plid, source_sha256=fetch.source_sha256, raw_path=raw_path,
                  n_fetched=fetch.n_fetched, n_valid=len(fetch.items), n_invalid=len(fetch.row_errors),
                  n_http_calls=fetch.n_http_calls, n_retries=fetch.n_retries)

    if fetch.unchanged or (fetch.source_sha256 and fetch.plid is None
                           and fetch.source_sha256 == _prev_run_sha(db, supplier.supplier_id, run_id)):
        outcome.status = RunStatus.UNCHANGED
        outcome.note = fetch.note or "datele sint identice cu rularea precedenta"
        repo.update_run(db, run_id, finished=True, status=outcome.status.value, stage="DONE",
                        error_text=outcome.note, **common)
        db.commit()
        return

    # --- DIFF
    ctx.check_deadline()
    repo.update_run(db, run_id, stage="DIFF", **common)
    db.commit()
    result, problems = analyze(db, supplier, fetch, params, rates, outcome, threshold_table=True)
    db.commit()

    # --- REZULTAT (etapa 1: nimic nu se aplica)
    repo.insert_changes(db, run_id, supplier.supplier_id, result.changes)
    status = outcome.status
    for err in outcome.errors:
        if err.error_class in {code for code, _ in problems}:
            repo.insert_errors(db, run_id, "DIFF", [err])
    n_quarantine = sum(1 for c in result.changes if c.decision == Decision.QUARANTINE)
    repo.update_run(db, run_id, finished=True, status=status.value, stage="DONE",
                    n_matched=result.n_matched,
                    n_new=result.count(ChangeType.NEW), n_returned=result.count(ChangeType.RETURNED),
                    n_gone=result.count(ChangeType.GONE), n_pending_gone=result.count(ChangeType.PENDING_GONE),
                    n_price_up=_real(result, ChangeType.PRICE_UP), n_price_down=_real(result, ChangeType.PRICE_DOWN),
                    n_quarantine=n_quarantine, n_applied=0, error_text=outcome.note)
    durations = repo.recent_durations(db, supplier.supplier_id)
    if durations:
        repo.set_est_duration(db, supplier.supplier_id, int(statistics.median(durations)))
    db.commit()


def analyze(db: Db, supplier: SupplierConfig, fetch: FetchResult, params: dict, rates: dict[int, float],
            outcome: RunOutcome, threshold_table: bool) -> tuple[DiffResult, list[tuple[str, str]]]:
    """Diff + praguri + garzi, doar citiri. Completeaza outcome (diff, baza, status DRY_RUN/BLOCKED, nota)."""
    gf_state = repo.load_gf_state(db, supplier.supplier_id)
    exclusions = repo.load_exclusions(db, supplier.supplier_id)
    prev_info = repo.latest_pricelist(db, supplier.supplier_id, before_plid=fetch.plid) if fetch.plid \
        else repo.latest_pricelist(db, supplier.supplier_id)
    prev_items = repo.load_pricelist_items(db, prev_info["PLID"]) if prev_info else []
    prev_codes = {i.code for i in prev_items} if prev_info else None

    if fetch.plid is not None and fetch.plid_processed:
        result = diff_against_prev(fetch.items, prev_items, gf_state, exclusions=exclusions,
                                   noise_pct=supplier.noise_pct, rates=rates)
    else:
        result = diff_against_gf(fetch.items, gf_state, prev_codes=prev_codes, exclusions=exclusions,
                                 noise_pct=supplier.noise_pct, gone_after_runs=supplier.gone_after_runs, rates=rates,
                                 rrp_discount=repo.load_rrp_discount(db, supplier.supplier_id))
    outcome.diff, outcome.baseline = result, result.baseline

    rules = repo.load_threshold_rules(db, supplier.supplier_id) if threshold_table else []
    groups = repo.load_goods_groups(db, (c.goodsid for c in result.changes if c.goodsid is not None))
    apply_thresholds(result.changes, supplier, rules, groups, rates)
    problems = run_guards(fetch, len(prev_codes) if prev_codes else None, result.changes,
                          result.n_matched_in_price, supplier, params)
    for code, message in problems:
        outcome.errors.append(RowError(code, message, severity=Severity.CRIT))

    note_parts = [f"baza {'TS_GOODS_FOREIGN' if result.baseline == BASELINE_GF else 'pricelistul precedent'}"]
    if prev_info:
        note_parts.append(f"precedent PLID {prev_info['PLID']}")
    if problems:
        note_parts.append("; ".join(m for _, m in problems))
    outcome.status = RunStatus.BLOCKED if problems else RunStatus.DRY_RUN
    outcome.note = "; ".join(note_parts)
    return result, problems


def preview_supplier(settings: Settings, supplier: SupplierConfig, plid: int | None = None) -> RunOutcome:
    """Aceeasi analiza ca o rulare, fara NICIO scriere (nici TPI_*): merge si pe o baza fara DDL-ul etapei 1."""
    started = time.monotonic()
    outcome = RunOutcome(supplier=supplier, status=RunStatus.ERROR, trigger="PREVIEW")
    with open_db(settings) as db:
        params = load_supplier_yaml(settings, supplier.supplier_id)
        iso, rates = repo.load_currencies(db)
        if plid is None and supplier.adapter_code == "external_plid":
            latest = repo.latest_pricelist(db, supplier.supplier_id)
            plid = latest["PLID"] if latest else None
        ctx = RunContext(settings=settings, supplier=supplier, db=db, params=params, currency_ids=iso, plid=plid,
                         progress=lambda msg: log.info("progress", preview=supplier.supplier_id, msg=msg))
        try:
            fetch = get_adapter(supplier.adapter_code).fetch(ctx)
        except AdapterError as exc:
            outcome.errors.append(RowError(exc.error_class, str(exc), severity=Severity.CRIT))
            outcome.error_endpoint, outcome.error_http = exc.endpoint, exc.http_status
            return outcome
        outcome.plid, outcome.n_fetched, outcome.n_valid = fetch.plid, fetch.n_fetched, len(fetch.items)
        outcome.errors.extend(fetch.warnings + fetch.row_errors[:20])
        analyze(db, supplier, fetch, params, rates, outcome, threshold_table=False)
        db.rollback()
    outcome.duration_sec = time.monotonic() - started
    return outcome


def _real(result: DiffResult, change_type: ChangeType) -> int:
    """Schimbarile de pret fara zgomotul de rotunjire, numarate o data per produs."""
    return len({(c.code, c.goodsid) for c in result.changes
                if c.change_type == change_type and c.reason != "NOISE"})
