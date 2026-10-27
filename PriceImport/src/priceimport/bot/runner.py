"""Bucla pi-bot: getUpdates (long polling), offset-ul in TPI_BOT_STATE, heartbeat 'pi-bot'."""

from __future__ import annotations

import time

from .. import __version__, repo
from ..config import Settings
from ..coordinator import HOST, PID
from ..db import open_db
from ..log import get_logger
from .handler import BotHandler
from .telegram import TelegramClient, TelegramError

log = get_logger(__name__)
INSTANCE = "pi-bot"
OFFSET_KEY = "UPDATE_OFFSET"


def process_updates(handler: BotHandler, settings: Settings, offset: int | None) -> int | None:
    """O tura de getUpdates; offset-ul se salveaza dupa fiecare mesaj (o cadere nu il reia)."""
    for update in handler.tg.get_updates(offset):
        try:
            handler.handle(update)
        except Exception:                    # noqa: BLE001 - un mesaj stricat nu opreste botul
            log.exception("bot_update_failed", update_id=update.get("update_id"))
        offset = int(update["update_id"]) + 1
        with open_db(settings) as db:
            repo.bot_state_set(db, OFFSET_KEY, str(offset))
            db.commit()
    return offset


def run_bot(settings: Settings, max_rounds: int | None = None) -> None:
    client = TelegramClient(settings.token(), settings.telegram_api_base)
    handler = BotHandler(settings, client)
    with open_db(settings) as db:
        saved = repo.bot_state_get(db, OFFSET_KEY)
        db.commit()
    offset = int(saved) if saved else None
    log.info("bot_start", version=__version__, offset=offset)
    rounds = 0
    try:
        while max_rounds is None or rounds < max_rounds:
            rounds += 1
            try:
                with open_db(settings) as db:
                    repo.heartbeat(db, INSTANCE, __version__, HOST, PID, f"offset {offset}")
                    db.commit()
                offset = process_updates(handler, settings, offset)
            except TelegramError as exc:
                log.warning("bot_telegram_error", error=str(exc))
                time.sleep(5)
            except Exception:                # noqa: BLE001 - baza cazuta: reincercam
                log.exception("bot_loop_failed")
                time.sleep(15)
    except KeyboardInterrupt:
        log.info("bot_stop")
    finally:
        client.close()
