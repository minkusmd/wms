"""Procesul pi-worker: scheduler-ul ferestrelor + heartbeat (TPI_HEARTBEAT si HEARTBEAT_AT al rularilor active)."""

from __future__ import annotations

import html
from datetime import datetime
from zoneinfo import ZoneInfo

from apscheduler.schedulers.blocking import BlockingScheduler
from apscheduler.triggers.cron import CronTrigger

from . import STAGE, __version__, repo
from .config import Settings
from .coordinator import HOST, PID, active_runs
from .db import open_db
from .log import get_logger
from .windows import run_window

log = get_logger(__name__)
INSTANCE = "pi-worker"


def heartbeat_tick(settings: Settings) -> None:
    try:
        with open_db(settings) as db:
            runs = active_runs()
            repo.heartbeat(db, INSTANCE, __version__, HOST, PID,
                           f"etapa {STAGE}; rulari active: {','.join(map(str, runs)) or '-'}")
            repo.touch_runs(db, runs)
            db.commit()
    except Exception:                      # noqa: BLE001 - baza cazuta nu opreste scheduler-ul
        log.exception("heartbeat_failed")


def window_job(settings: Settings, index: int) -> None:
    try:
        run_window(settings, index, now=datetime.now(ZoneInfo(settings.timezone)).replace(tzinfo=None))
    except Exception as exc:               # noqa: BLE001
        log.exception("window_failed", index=index)
        try:
            with open_db(settings) as db:
                repo.telegram_send(db, settings.telegram_errors_channel or settings.telegram_channel,
                                   f"<b>PriceImport</b>: fereastra {index} a esuat — "
                                   f"{html.escape(type(exc).__name__)}: {html.escape(str(exc)[:500])}", priority=1)
                db.commit()
        except Exception:                  # noqa: BLE001
            log.exception("window_failure_alert_failed")


def serve(settings: Settings) -> None:
    tz = ZoneInfo(settings.timezone)
    with open_db(settings) as db:
        abandoned = repo.abandon_stale_runs(db, settings.stale_run_min)
        db.commit()
    log.info("service_start", version=__version__, stage=STAGE, abandoned=abandoned,
             windows=[t.strftime("%H:%M") for t in settings.windows], tz=settings.timezone)

    scheduler = BlockingScheduler(timezone=tz)
    for index, start in enumerate(settings.windows):
        scheduler.add_job(window_job, CronTrigger(hour=start.hour, minute=start.minute, timezone=tz),
                          args=[settings, index], id=f"window-{index}", name=f"fereastra {start:%H:%M}",
                          misfire_grace_time=settings.misfire_grace_min * 60, coalesce=True, max_instances=1)
    scheduler.add_job(heartbeat_tick, "interval", seconds=30, args=[settings], id="heartbeat",
                      max_instances=1, coalesce=True, next_run_time=datetime.now(tz))
    try:
        scheduler.start()
    except (KeyboardInterrupt, SystemExit):
        log.info("service_stop")
