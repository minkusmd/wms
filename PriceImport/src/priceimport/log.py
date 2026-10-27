"""Loguri structurate (JSON) pe stdout + fisier rotit zilnic in data/logs."""

from __future__ import annotations

import logging
import logging.handlers
import re
import sys
from pathlib import Path

import structlog

_SECRET_RE = re.compile(r"(?i)(api_token|token|password|passwd|secret|authorization)=([^&\s]+)")


_BOT_TOKEN_RE = re.compile(r"bot\d{5,}:[A-Za-z0-9_-]{20,}")


def mask_secrets(text: str) -> str:
    """Ascunde valorile parametrilor sensibili din URL-uri / mesaje (inclusiv tokenul botului din URL)."""
    return _BOT_TOKEN_RE.sub("bot***", _SECRET_RE.sub(r"\1=***", text))


def _mask_processor(_logger, _name, event_dict):
    for key, value in list(event_dict.items()):
        if isinstance(value, str):
            event_dict[key] = mask_secrets(value)
    return event_dict


class SecretMaskFilter(logging.Filter):
    """Masca si pentru logurile bibliotecilor (httpx scrie URL-ul complet, cu api_token, la INFO)."""

    def filter(self, record: logging.LogRecord) -> bool:
        message = record.getMessage()
        masked = mask_secrets(message)
        if masked != message:
            record.msg, record.args = masked, None
        return True


def setup_logging(log_dir: Path | None = None, level: int = logging.INFO) -> None:
    handlers: list[logging.Handler] = [logging.StreamHandler(sys.stdout)]
    if log_dir is not None:
        log_dir.mkdir(parents=True, exist_ok=True)
        handlers.append(logging.handlers.TimedRotatingFileHandler(
            log_dir / "priceimport.log", when="midnight", backupCount=30, encoding="utf-8"))
    for handler in handlers:
        handler.addFilter(SecretMaskFilter())
    logging.basicConfig(format="%(message)s", level=level, handlers=handlers, force=True)
    # fiecare cerere HTTP e deja in jurnalul nostru (fara secrete); httpx/httpcore doar avertismente
    for noisy in ("httpx", "httpcore"):
        logging.getLogger(noisy).setLevel(logging.WARNING)
    structlog.configure(
        processors=[
            structlog.contextvars.merge_contextvars,
            structlog.processors.add_log_level,
            structlog.processors.TimeStamper(fmt="iso"),
            _mask_processor,
            structlog.processors.format_exc_info,
            structlog.processors.JSONRenderer(ensure_ascii=False),
        ],
        logger_factory=structlog.stdlib.LoggerFactory(),
        wrapper_class=structlog.make_filtering_bound_logger(level),
        cache_logger_on_first_use=True,
    )


def get_logger(name: str = "priceimport"):
    return structlog.get_logger(name)
