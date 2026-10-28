"""Ferestrele zilnice (09-10, 15-16): ordinea furnizorilor, paralelism limitat, termene soft/hard, raport."""

from __future__ import annotations

import html
import threading
import time
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
from dataclasses import dataclass
from datetime import datetime, timedelta

from . import repo
from .adapters import ADAPTERS
from .config import Settings
from .coordinator import RunOutcome, make_key, run_supplier
from .db import open_db
from .log import get_logger
from .models import RunStatus
from .report import build_message, report_path, write_xlsx
from .repo import SupplierConfig

log = get_logger(__name__)


@dataclass
class WindowPlan:
    index: int
    start: datetime
    slot: str
    soft_deadline: datetime
    hard_deadline: datetime


def plan_window(settings: Settings, index: int, now: datetime) -> WindowPlan:
    """Fereastra `index` a zilei curente (ora din settings.windows)."""
    start_time = settings.windows[index]
    start = now.replace(hour=start_time.hour, minute=start_time.minute, second=0, microsecond=0)
    return WindowPlan(index=index, start=start, slot=f"{start:%Y-%m-%d %H}",
                      soft_deadline=start + timedelta(minutes=settings.soft_deadline_min),
                      hard_deadline=start + timedelta(minutes=settings.hard_deadline_min))


def order_suppliers(suppliers: list[SupplierConfig]) -> list[SupplierConfig]:
    """Prioritatea intii; la aceeasi prioritate cei mai lenti pornesc primii (LPT - termina mai devreme)."""
    return sorted(suppliers, key=lambda s: (s.priority, -(s.est_duration_sec or 0), s.supplier_id))


def _to_monotonic(moment: datetime, now: datetime) -> float:
    return time.monotonic() + (moment - now).total_seconds()


def run_window(settings: Settings, index: int, now: datetime | None = None, notify: bool = True,
               only: set[int] | None = None) -> list[RunOutcome]:
    now = now or datetime.now()
    plan = plan_window(settings, index, now)
    with open_db(settings) as db:
        abandoned = repo.abandon_stale_runs(db, settings.stale_run_min)
        suppliers = [s for s in repo.load_suppliers(db) if s.in_window(index)
                     and (only is None or s.supplier_id in only)]
        db.commit()
    if abandoned:
        log.warning("stale_runs_abandoned", count=abandoned)
    suppliers = order_suppliers(suppliers)
    log.info("window_start", slot=plan.slot, suppliers=[s.supplier_id for s in suppliers])

    soft = _to_monotonic(plan.soft_deadline, now)
    hard = _to_monotonic(plan.hard_deadline, now)
    host_locks: dict[str, threading.Lock] = defaultdict(threading.Lock)

    def worker(supplier: SupplierConfig) -> RunOutcome:
        adapter_cls = ADAPTERS.get(supplier.adapter_code)
        host = getattr(adapter_cls, "host", None)
        lock = host_locks[host] if host else None
        if lock:
            lock.acquire()
        try:
            if time.monotonic() > soft:
                return _skip(settings, supplier, plan.slot, "nu a pornit pina la termenul soft al ferestrei")
            return run_supplier(settings, supplier, trigger="SCHEDULE", slot=plan.slot, deadline=hard)
        finally:
            if lock:
                lock.release()

    with ThreadPoolExecutor(max_workers=max(1, settings.max_parallel), thread_name_prefix="pi-run") as pool:
        outcomes = list(pool.map(worker, suppliers))

    if notify and outcomes:
        send_report(settings, f"Pricelisturi · {plan.start:%d.%m} · fereastra {plan.start:%H}–"
                              f"{plan.start + timedelta(hours=1):%H}", outcomes, f"fereastra_{plan.start:%H}")
    log.info("window_end", slot=plan.slot, statuses={o.supplier.supplier_id: o.status.value for o in outcomes})
    return outcomes


def _skip(settings: Settings, supplier: SupplierConfig, slot: str, reason: str) -> RunOutcome:
    with open_db(settings) as db:
        key = make_key(supplier.supplier_id, "SCHEDULE", slot)
        existing = repo.find_run_by_key(db, key)
        run_id = existing["RUNID"] if existing else repo.insert_skipped_run(
            db, supplier.supplier_id, "SCHEDULE", slot, key, reason)
        db.commit()
    return RunOutcome(supplier=supplier, status=RunStatus.SKIPPED, run_id=run_id, trigger="SCHEDULE", note=reason)


CRITICAL = (RunStatus.ERROR, RunStatus.TIMEOUT, RunStatus.BLOCKED)


def alert_key(o: RunOutcome) -> str:
    """Aceeasi problema = aceeasi cheie (furnizor + status + clasa primei erori critice)."""
    crit = next((e for e in o.errors if e.severity.value == "CRIT"), None)
    return f"RUN|{o.supplier.supplier_id}|{o.status.value}|{crit.error_class if crit else '-'}"


def select_alerts(db, settings: Settings, outcomes: list[RunOutcome]) -> tuple[list[RunOutcome], list[RunOutcome]]:
    """(de trimis, rezolvate): aceeasi problema se trimite cel mult o data la alert_repeat_min minute."""
    if not repo.has_table(db, "TPI_ALERT_STATE"):
        return [o for o in outcomes if o.status in CRITICAL], []
    to_send, resolved = [], []
    for o in outcomes:
        if o.status in CRITICAL:
            message = o.errors[0].message if o.errors else (o.note or "")
            if repo.alert_should_send(db, alert_key(o), "CRIT", message, settings.alert_repeat_min,
                                      o.supplier.supplier_id):
                to_send.append(o)
        elif o.status != RunStatus.SKIPPED and repo.resolve_alerts(db, f"RUN|{o.supplier.supplier_id}|"):
            resolved.append(o)
    return to_send, resolved


def send_report(settings: Settings, title: str, outcomes: list[RunOutcome], label: str) -> str:
    text = build_message(title, outcomes, dry_run=not settings.apply_enabled)
    try:
        with open_db(settings) as db:
            pending = repo.count_candidates(db) if repo.has_table(db, "TPI_MATCH_CANDIDATE") else 0
            db.commit()
        if pending:
            text += f"\n\n🔗 Propuneri de legare in asteptare: {pending} (/potriviri)"
    except Exception:                      # noqa: BLE001 - raportul pleaca oricum
        log.exception("pending_matches_failed")
    try:
        write_xlsx(report_path(settings.data_dir, label), outcomes)
    except OSError:
        log.exception("report_xlsx_failed")
    if settings.telegram_enabled:
        with open_db(settings) as db:
            first_run = next((o.run_id for o in outcomes if o.run_id), None)
            repo.telegram_send(db, settings.telegram_channel, text, first_run)
            critical, resolved = select_alerts(db, settings, outcomes)
            if (critical or resolved) and settings.telegram_errors_channel:
                lines = [html.escape(f"• {o.supplier.name} {o.supplier.supplier_id}: {o.status.value} — "
                                     f"{(o.errors[0].message if o.errors else o.note or '')[:150]}", quote=False)
                         for o in critical]
                lines += [html.escape(f"✅ {o.supplier.name} {o.supplier.supplier_id}: rezolvat ({o.status.value})",
                                      quote=False) for o in resolved]
                repo.telegram_send(db, settings.telegram_errors_channel,
                                   (f"<b>PriceImport</b> · {html.escape(title)}\n" + "\n".join(lines))[:4096],
                                   first_run, priority=1 if critical else 0)
            db.commit()
    return text
