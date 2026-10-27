"""Clientul minimal al Bot API (long polling): doar metodele folosite de pi-bot."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any

import httpx

from ..log import get_logger, mask_secrets

log = get_logger(__name__)


class TelegramError(Exception):
    pass


class TelegramClient:
    def __init__(self, token: str, base_url: str = "https://api.telegram.org", poll_timeout: int = 50):
        if not token:
            raise TelegramError("lipseste tokenul botului (PI_BOT_TOKEN / PI_BOT_TOKEN_FILE)")
        self.base = f"{base_url.rstrip('/')}/bot{token}"
        self.file_base = f"{base_url.rstrip('/')}/file/bot{token}"
        self.poll_timeout = poll_timeout
        self.http = httpx.Client(timeout=httpx.Timeout(poll_timeout + 15, connect=10))

    def close(self) -> None:
        self.http.close()

    def call(self, method: str, **params: Any) -> Any:
        data = {k: (json.dumps(v, ensure_ascii=False) if isinstance(v, (dict, list)) else v)
                for k, v in params.items() if v is not None}
        try:
            response = self.http.post(f"{self.base}/{method}", data=data)
            body = response.json()
        except (httpx.HTTPError, ValueError) as exc:
            raise TelegramError(mask_secrets(f"{method}: {type(exc).__name__}: {exc}").replace(self.base, "")) from exc
        if not body.get("ok"):
            raise TelegramError(f"{method}: {body.get('error_code')} {body.get('description')}")
        return body["result"]

    def get_updates(self, offset: int | None) -> list[dict[str, Any]]:
        return self.call("getUpdates", offset=offset, timeout=self.poll_timeout,
                         allowed_updates=["message", "callback_query"])

    def send_message(self, chat_id: int, text: str, reply_to: int | None = None,
                     buttons: list[list[tuple[str, str]]] | None = None) -> dict[str, Any]:
        markup = {"inline_keyboard": [[{"text": t, "callback_data": d} for t, d in row] for row in buttons]} \
            if buttons else None
        return self.call("sendMessage", chat_id=chat_id, text=text[:4096], parse_mode="HTML",
                         disable_web_page_preview=True, reply_to_message_id=reply_to, reply_markup=markup)

    def remove_buttons(self, chat_id: int, message_id: int) -> None:
        try:
            self.call("editMessageReplyMarkup", chat_id=chat_id, message_id=message_id,
                      reply_markup={"inline_keyboard": []})
        except TelegramError:
            pass                               # mesaj prea vechi / deja fara butoane

    def answer_callback(self, callback_id: str, text: str = "") -> None:
        try:
            self.call("answerCallbackQuery", callback_query_id=callback_id, text=text[:200])
        except TelegramError:
            pass

    def download(self, file_id: str, max_bytes: int) -> bytes:
        info = self.call("getFile", file_id=file_id)
        if info.get("file_size") and info["file_size"] > max_bytes:
            raise TelegramError(f"fisierul are {info['file_size'] // (1 << 20)} MB")
        try:
            response = self.http.get(f"{self.file_base}/{info['file_path']}")
            response.raise_for_status()
        except httpx.HTTPError as exc:
            raise TelegramError(f"descarcarea fisierului: {type(exc).__name__}") from exc
        if len(response.content) > max_bytes:
            raise TelegramError("fisierul depaseste limita")
        return response.content

    def send_document(self, chat_id: int, path: Path, caption: str | None = None,
                      reply_to: int | None = None) -> None:
        with path.open("rb") as f:
            try:
                response = self.http.post(f"{self.base}/sendDocument",
                                          data={k: v for k, v in {"chat_id": chat_id, "caption": caption,
                                                                  "reply_to_message_id": reply_to}.items() if v},
                                          files={"document": (path.name, f)})
                body = response.json()
            except (httpx.HTTPError, ValueError) as exc:
                raise TelegramError(f"sendDocument: {type(exc).__name__}") from exc
        if not body.get("ok"):
            raise TelegramError(f"sendDocument: {body.get('description')}")
