"""Logica botului pi-bot: fisierele furnizorilor manuali (recunoastere -> previzualizare -> Aplica / Doar raport /
Anuleaza) si comenzile (/status, /carantina, /aproba, /respinge, /run, /mute).

Acces: doar utilizatorii din TPI_BOT_USER; VIEW = rapoarte si previzualizari, APPLY = si aplicare / decizii.
Butoanele (callback_data, max 64 octeti): sup:<fileid>:<furnizor>, apl:<fileid>, rap:<fileid>, anl:<fileid>.
"""

from __future__ import annotations

import hashlib
import html
import re
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import Any

from .. import repo
from ..config import Settings, load_supplier_yaml
from ..coordinator import RunOutcome, apply_items, record_applied, run_supplier
from ..db import open_db
from ..excelparse import ALLOWED_EXTENSIONS, ExcelError, check_safe, detect_layout, parse_items, read_sheets
from ..log import get_logger
from ..models import RunStatus
from ..recognize import FileSignals, caption_supplier, recognize
from ..report import build_message, report_path, write_xlsx
from .telegram import TelegramClient, TelegramError

log = get_logger(__name__)
_FILE_REF = re.compile(r"Fisierul #(\d+)")

HELP = (
    "<b>PriceImport</b> - pricelisturile furnizorilor\n"
    "• trimite (redirectioneaza) fisierul Excel / CSV; scrie <code>#ID</code> furnizorului in text daca il stii\n"
    "• /status - ultimele rulari\n"
    "• /carantina [ID] - preturile oprite de praguri\n"
    "• /aproba QID ... / /respinge QID ... - decizii pe carantina\n"
    "• /run ID - rularea acum a unui furnizor cu API\n"
    "• /mute ID [ore] - opreste alertele repetate ale unui furnizor")


@dataclass
class User:
    tg_id: int
    name: str
    role: str

    @property
    def can_apply(self) -> bool:
        return self.role == "APPLY"


def _e(text: Any) -> str:
    return html.escape(str(text if text is not None else ""), quote=False)


def _forward_origin(message: dict[str, Any]) -> str | None:
    origin = message.get("forward_origin") or {}
    kind = origin.get("type")
    if kind == "user":
        u = origin.get("sender_user") or {}
        return " ".join(filter(None, [u.get("first_name"), u.get("last_name"), f"(id {u.get('id')})"]))
    if kind == "hidden_user":
        return origin.get("sender_user_name")
    if kind in ("chat", "channel"):
        chat = origin.get("sender_chat") or origin.get("chat") or {}
        return chat.get("title")
    return None


class BotHandler:
    def __init__(self, settings: Settings, client: TelegramClient):
        self.settings = settings
        self.tg = client
        self.inbox_dir = settings.data_dir / "inbox"

    # --- intrarea ---------------------------------------------------------------------------

    def handle(self, update: dict[str, Any]) -> None:
        if "callback_query" in update:
            query = update["callback_query"]
            user = self._user(query.get("from") or {})
            chat_id = (query.get("message") or {}).get("chat", {}).get("id")
            if user is None:
                self.tg.answer_callback(query["id"], "Acces interzis")
                return
            self.tg.answer_callback(query["id"], "Se lucreaza...")
            self.on_callback(user, chat_id, query.get("message") or {}, query.get("data") or "")
            return
        message = update.get("message")
        if not message:
            return
        chat_id = message["chat"]["id"]
        sender = message.get("from") or {}
        user = self._user(sender)
        if user is None:
            log.warning("bot_access_denied", tg_user=sender.get("id"), name=sender.get("first_name"))
            self.tg.send_message(chat_id, f"Acces interzis. ID-ul tau Telegram: <code>{sender.get('id')}</code> "
                                          "(se adauga in TPI_BOT_USER).", reply_to=message.get("message_id"))
            return
        if message.get("document"):
            self.on_document(user, message)
        elif (message.get("text") or "").startswith("/"):
            self.on_command(user, message)
        elif message.get("text"):
            self.on_text(user, message)

    def _user(self, sender: dict[str, Any]) -> User | None:
        if not sender.get("id"):
            return None
        with open_db(self.settings) as db:
            row = repo.bot_user(db, int(sender["id"]))
            db.commit()
        return User(int(row["TG_USER_ID"]), row["NAME"].strip(), row["ROLE_CODE"].strip()) if row else None

    # --- fisiere ----------------------------------------------------------------------------

    def on_document(self, user: User, message: dict[str, Any]) -> None:
        chat_id, msg_id = message["chat"]["id"], message["message_id"]
        doc = message["document"]
        file_name = (doc.get("file_name") or "fisier").strip()
        ext = Path(file_name).suffix.lower()
        if ext not in ALLOWED_EXTENSIONS:
            self.tg.send_message(chat_id, f"Tip de fisier nepermis: <code>{_e(ext or '?')}</code>. Accept: "
                                          f"{', '.join(sorted(ALLOWED_EXTENSIONS))}.", reply_to=msg_id)
            return
        max_bytes = self.settings.bot_max_file_mb * 1024 * 1024
        if (doc.get("file_size") or 0) > max_bytes:
            self.tg.send_message(chat_id, f"Fisierul depaseste {self.settings.bot_max_file_mb} MB.", reply_to=msg_id)
            return
        with open_db(self.settings) as db:
            existing = repo.inbox_by_unique_id(db, doc["file_unique_id"])
            db.commit()
        if existing:
            self.tg.send_message(chat_id, f"Fisierul a fost primit deja (#{existing['FILEID']}, "
                                          f"{existing['STATUS'].strip()}).", reply_to=msg_id)
            return
        try:
            content = self.tg.download(doc["file_id"], max_bytes)
        except TelegramError as exc:
            self.tg.send_message(chat_id, f"Nu am putut descarca fisierul: {_e(exc)}", reply_to=msg_id)
            return
        sha = hashlib.sha256(content).hexdigest()
        self.inbox_dir.mkdir(parents=True, exist_ok=True)
        path = self.inbox_dir / f"{sha}{ext}"          # numele pe disc nu vine de la utilizator
        path.write_bytes(content)

        with open_db(self.settings) as db:
            duplicate = repo.inbox_by_sha(db, sha)
            file_id = repo.inbox_insert(
                db, TG_CHAT_ID=chat_id, TG_MESSAGE_ID=msg_id, TG_FILE_UNIQUE_ID=doc["file_unique_id"],
                SENDER_TG_ID=user.tg_id, SENDER_NAME=user.name[:256], FORWARD_FROM=(_forward_origin(message) or "")[:256]
                or None, CAPTION=(message.get("caption") or "")[:1024] or None, FILE_NAME=file_name[:512],
                FILE_SIZE=len(content), SHA256=sha, STORAGE_PATH=str(path),
                STATUS="DUPLICATE" if duplicate else "RECEIVED")
            db.commit()
        if duplicate:
            self.tg.send_message(chat_id, f"Acelasi continut a fost primit deja ca #{duplicate['FILEID']} "
                                          f"({duplicate['STATUS'].strip()}, {str(duplicate['RECEIVED_AT'])[:16]}).",
                                 reply_to=msg_id)
            return
        self._recognize_and_preview(user, file_id, chat_id, msg_id)

    def _recognize_and_preview(self, user: User, file_id: int, chat_id: int, msg_id: int) -> None:
        with open_db(self.settings) as db:
            row = repo.inbox_get(db, file_id)
            configured = {s.supplier_id for s in repo.load_suppliers(db) if s.adapter_code == "excel"}
            rules = repo.file_rules(db)
            db.commit()
        path = Path(row["STORAGE_PATH"])
        sheets, layout, codes = [], None, []
        try:
            check_safe(path)
            sheets = read_sheets(path)
            layout = detect_layout(sheets)
            sample = parse_items(sheets, layout, {"skip_out_of_stock": False}, self._currencies())
            codes = [i.code for i in sample.items[:300]]
        except ExcelError as exc:
            log.info("bot_generic_parse_failed", file=file_id, error=str(exc))
        signals = FileSignals(caption=row["CAPTION"], sender_tg_id=row["SENDER_TG_ID"], forward_from=row["FORWARD_FROM"],
                              file_name=row["FILE_NAME"], sheet_names=[s.name for s in sheets],
                              header_signature=layout.signature if layout else None, codes=codes)
        with open_db(self.settings) as db:
            overlap = repo.sku_overlap(db, codes) if codes else {}
            db.commit()
        rec = recognize(signals, rules, overlap, configured)
        if rec.decided is not None:
            self._preview(user, file_id, rec.decided.supplier_id, rec.method or "AUTO", rec.decided.score,
                          chat_id, msg_id)
            return
        with open_db(self.settings) as db:
            names = repo.supplier_names(db, [c.supplier_id for c in rec.candidates[:3]] +
                                        ([rec.candidates[0].supplier_id] if rec.explicit else []))
            repo.inbox_update(db, file_id, status="NEEDS_SUPPLIER",
                              note=layout.describe() if layout else "antet nerecunoscut")
            db.commit()
        if rec.explicit:
            sid = rec.candidates[0].supplier_id
            self.tg.send_message(chat_id, f"Furnizorul #{sid} {_e(names.get(sid, ''))} nu e configurat pentru "
                                          "fisiere (TPI_SUPPLIER cu ADAPTER_CODE = 'excel').", reply_to=msg_id)
            return
        buttons = [[(f"{names.get(c.supplier_id, c.supplier_id)} · {c.score:.0%}"[:60], f"sup:{file_id}:{c.supplier_id}")]
                   for c in rec.candidates[:3] if c.supplier_id in configured]
        text = (f"Fisierul #{file_id} <b>{_e(row['FILE_NAME'])}</b>: nu sint sigur de furnizor.\n"
                + (f"{_e(layout.describe())}\n" if layout else "Antetul nu a fost recunoscut automat.\n")
                + "Alege furnizorul sau raspunde la acest mesaj cu <code>#ID</code>.")
        self.tg.send_message(chat_id, text, reply_to=msg_id,
                             buttons=buttons + [[("Anuleaza", f"anl:{file_id}")]])

    def _preview(self, user: User, file_id: int, supplier_id: int, method: str, score: float,
                 chat_id: int, msg_id: int | None) -> None:
        with open_db(self.settings) as db:
            row = repo.inbox_get(db, file_id)
            supplier = repo.load_supplier(db, supplier_id)
            db.commit()
        if supplier is None or supplier.adapter_code != "excel":
            self.tg.send_message(chat_id, f"Furnizorul #{supplier_id} nu e configurat pentru fisiere "
                                          "(TPI_SUPPLIER cu ADAPTER_CODE = 'excel').", reply_to=msg_id)
            return
        outcome = run_supplier(self.settings, supplier, trigger="TELEGRAM", file_path=Path(row["STORAGE_PATH"]),
                               allow_apply=False, idempotency_key=f"{supplier_id}|tg|{row['SHA256'].strip()}")
        status = "PREVIEW" if outcome.status in (RunStatus.DRY_RUN, RunStatus.BLOCKED) else "FAILED"
        if outcome.status == RunStatus.SKIPPED and outcome.run_id:
            status = "PREVIEW"                       # acelasi fisier, acelasi furnizor: rularea exista deja
        with open_db(self.settings) as db:
            repo.inbox_update(db, file_id, supplierid=supplier_id, detect_method=method[:16], detect_score=score,
                              status=status, runid=outcome.run_id, note=outcome.note)
            # semnatura antetului ramine invatata pentru furnizor (data viitoare se recunoaste singur)
            try:
                sheets = read_sheets(Path(row["STORAGE_PATH"]))
                layout = detect_layout(sheets, load_supplier_yaml(self.settings, supplier_id))
                repo.learn_file_rule(db, supplier_id, "HEADER_SIG", layout.signature)
            except ExcelError:
                pass
            db.commit()

        text = build_message(f"Fisier #{file_id} · {supplier.name} · {row['FILE_NAME']}", [outcome], dry_run=True)
        can_apply = (outcome.status == RunStatus.DRY_RUN and outcome.baseline == "gf" and user.can_apply
                     and self.settings.apply_enabled)
        buttons = [[("Aplica", f"apl:{file_id}")]] if can_apply else []
        buttons.append([("Doar raport", f"rap:{file_id}"), ("Anuleaza", f"anl:{file_id}")])
        if not self.settings.apply_enabled:
            text += "\n\n<i>Aplicarea e oprita pe serviciu (PI_APPLY_ENABLED).</i>"
        elif not user.can_apply:
            text += "\n\n<i>Doar utilizatorii cu dreptul APPLY pot aplica.</i>"
        self.tg.send_message(chat_id, text, reply_to=msg_id, buttons=buttons)
        try:
            xlsx = write_xlsx(report_path(self.settings.data_dir, f"fisier_{file_id}"), [outcome])
            self.tg.send_document(chat_id, xlsx, caption=f"Detalii fisier #{file_id}", reply_to=msg_id)
        except (OSError, TelegramError) as exc:
            log.warning("bot_xlsx_failed", file=file_id, error=str(exc))

    # --- butoane ----------------------------------------------------------------------------

    def on_callback(self, user: User, chat_id: int, message: dict[str, Any], data: str) -> None:
        parts = data.split(":")
        try:
            action, file_id = parts[0], int(parts[1])
        except (IndexError, ValueError):
            return
        self.tg.remove_buttons(chat_id, message.get("message_id"))
        with open_db(self.settings) as db:
            row = repo.inbox_get(db, file_id)
            db.commit()
        if row is None:
            self.tg.send_message(chat_id, f"Fisierul #{file_id} nu exista.")
            return
        status = row["STATUS"].strip()
        if action == "sup":
            if status != "NEEDS_SUPPLIER":
                self.tg.send_message(chat_id, f"Fisierul #{file_id} e deja {status}.")
                return
            self._preview(user, file_id, int(parts[2]), "MANUAL", 1.0, chat_id, row["TG_MESSAGE_ID"])
        elif action == "apl":
            self._apply(user, row, chat_id)
        elif action in ("rap", "anl"):
            if status in ("APPLIED", "REJECTED", "REPORTED"):
                self.tg.send_message(chat_id, f"Fisierul #{file_id} e deja {status}.")
                return
            new_status = "REPORTED" if action == "rap" else "REJECTED"
            with open_db(self.settings) as db:
                repo.inbox_update(db, file_id, decided=True, status=new_status, decided_by=user.name[:64])
                db.commit()
            self.tg.send_message(chat_id, f"Fisierul #{file_id}: {'pastrat doar ca raport' if action == 'rap' else 'anulat'}"
                                          f" ({_e(user.name)}). Preturile nu s-au schimbat.")

    def _apply(self, user: User, row: dict[str, Any], chat_id: int) -> None:
        file_id = row["FILEID"]
        if not user.can_apply:
            self.tg.send_message(chat_id, "Nu ai dreptul sa aplici preturi (rolul APPLY).")
            return
        if not self.settings.apply_enabled:
            self.tg.send_message(chat_id, "Aplicarea e oprita pe serviciu (PI_APPLY_ENABLED).")
            return
        if row["STATUS"].strip() != "PREVIEW" or not row["RUNID"]:
            self.tg.send_message(chat_id, f"Fisierul #{file_id} e {row['STATUS'].strip()}, nu se poate aplica.")
            return
        with open_db(self.settings) as db:
            run = repo.load_run(db, row["RUNID"])
            supplier = repo.load_supplier(db, row["SUPPLIERID"])
            age_h = db.scalar("SELECT DATEDIFF(MINUTE FROM STARTED_AT TO CURRENT_TIMESTAMP) FROM TPI_RUN WHERE RUNID = ?",
                              (row["RUNID"],)) / 60.0
            db.commit()
        if age_h > self.settings.preview_max_age_hours:
            self.tg.send_message(chat_id, f"Previzualizarea are {age_h:.0f} h; trimite fisierul din nou pentru una noua.")
            return
        try:
            sheets = read_sheets(Path(row["STORAGE_PATH"]))
            spec = load_supplier_yaml(self.settings, supplier.supplier_id)
            items = parse_items(sheets, detect_layout(sheets, spec), spec, self._currencies()).items
            applied, plid = apply_items(self.settings, run["RUNID"], supplier, items, run["PLID"])
        except Exception as exc:              # noqa: BLE001 - raspunsul ajunge la utilizator, detaliul in log
            log.exception("bot_apply_failed", file=file_id)
            self.tg.send_message(chat_id, f"Aplicarea fisierului #{file_id} a esuat: {_e(exc)}")
            return
        outcome = RunOutcome(supplier=supplier, status=RunStatus.APPLIED, run_id=run["RUNID"], plid=plid)
        record_applied(outcome, applied)
        with open_db(self.settings) as db:
            repo.inbox_update(db, file_id, decided=True, status="APPLIED", decided_by=user.name[:64],
                              note=f"aplicat: doc {','.join(map(str, applied.docids))}")
            db.commit()
        rejected = f", respinse {len(applied.rejected)} (in carantina)" if applied.rejected else ""
        self.tg.send_message(chat_id, f"✅ Fisierul #{file_id} aplicat de {_e(user.name)}: {applied.n_applied} produse, "
                                      f"documentele {', '.join(map(str, applied.docids)) or '-'}{rejected}; "
                                      f"PLID {plid}. Anulare: <code>python -m priceimport rollback {run['RUNID']}</code>")

    def _currencies(self) -> dict[str, int]:
        with open_db(self.settings) as db:
            iso, _ = repo.load_currencies(db)
            db.commit()
        return iso

    # --- text si comenzi --------------------------------------------------------------------

    def on_text(self, user: User, message: dict[str, Any]) -> None:
        """Raspuns cu #ID la mesajul botului "Fisierul #N ...: nu sint sigur de furnizor"."""
        supplier_id = caption_supplier(message.get("text"))
        match = _FILE_REF.search((message.get("reply_to_message") or {}).get("text") or "")
        if supplier_id is None or match is None:
            return
        file_id = int(match.group(1))
        with open_db(self.settings) as db:
            row = repo.inbox_get(db, file_id)
            db.commit()
        if row and row["STATUS"].strip() == "NEEDS_SUPPLIER" and row["TG_CHAT_ID"] == message["chat"]["id"]:
            self._preview(user, file_id, supplier_id, "MANUAL", 1.0, message["chat"]["id"], message["message_id"])

    def on_command(self, user: User, message: dict[str, Any]) -> None:
        chat_id = message["chat"]["id"]
        words = message["text"].split()
        command, args = words[0].split("@")[0].lower(), words[1:]
        if command in ("/start", "/help"):
            self.tg.send_message(chat_id, HELP)
        elif command == "/status":
            with open_db(self.settings) as db:
                runs = repo.recent_runs(db, 12)
                db.commit()
            lines = [f"{r['RUNID']} {str(r['STARTED_AT'])[5:16]} {_e((r['SUPPLIER_NAME'] or '').strip()[:18])} "
                     f"<b>{r['STATUS'].strip()}</b> ↑{r['N_PRICE_UP'] or 0} ↓{r['N_PRICE_DOWN'] or 0} "
                     f"📝{r['N_APPLIED'] or 0}" for r in runs]
            self.tg.send_message(chat_id, "<b>Ultimele rulari</b>\n" + "\n".join(lines or ["-"]))
        elif command == "/carantina":
            supplier_id = int(args[0]) if args and args[0].isdigit() else None
            with open_db(self.settings) as db:
                rows = repo.list_quarantine(db, supplier_id)
                db.commit()
            lines = [f"<code>{r['QID']}</code> {r['SUPPLIERID']} {_e(r['SUPPLIER_GOODS_CODE'][:18])} "
                     f"{_e((r['REASON_CODE'] or '').strip())} {r['OLD_PRICE']} → {r['NEW_PRICE']} "
                     f"{_e((r['SUPPLIER_GOODS_NAME'] or '')[:30])}" for r in rows[:25]]
            more = f"\n… inca {len(rows) - 25}" if len(rows) > 25 else ""
            self.tg.send_message(chat_id, f"<b>Carantina: {len(rows)}</b>\n" + "\n".join(lines or ["-"]) + more)
        elif command in ("/aproba", "/respinge"):
            if not user.can_apply:
                self.tg.send_message(chat_id, "Nu ai dreptul (rolul APPLY).")
                return
            status = "APPROVED" if command == "/aproba" else "REJECTED"
            done = []
            with open_db(self.settings) as db:
                for arg in args:
                    if arg.isdigit():
                        row = repo.decide_quarantine(db, int(arg), status, f"tg:{user.name}"[:64])
                        if row and row["STATUS"].strip() == "PENDING":
                            done.append(arg)
                db.commit()
            self.tg.send_message(chat_id, f"{'Aprobate' if status == 'APPROVED' else 'Respinse'}: "
                                          f"{', '.join(done) or 'nimic'}. "
                                          + ("Se aplica la rularea urmatoare (sau `apply RUNID`)." if done and
                                             status == "APPROVED" else ""))
        elif command == "/run":
            if not user.can_apply or not args or not args[0].isdigit():
                self.tg.send_message(chat_id, "Folosire: /run ID (rolul APPLY).")
                return
            with open_db(self.settings) as db:
                supplier = repo.load_supplier(db, int(args[0]))
                db.commit()
            if supplier is None or supplier.adapter_code == "excel":
                self.tg.send_message(chat_id, f"#{args[0]} nu e un furnizor cu API configurat.")
                return
            self.tg.send_message(chat_id, f"Rulez {_e(supplier.name)}...")
            outcome = run_supplier(self.settings, supplier, trigger="MANUAL")
            self.tg.send_message(chat_id, build_message(f"Rulare din bot · {supplier.name} · "
                                                        f"{datetime.now():%d.%m %H:%M}", [outcome],
                                                        dry_run=not self.settings.apply_enabled))
        elif command == "/mute":
            if not user.can_apply or not args or not args[0].isdigit():
                self.tg.send_message(chat_id, "Folosire: /mute ID [ore] (rolul APPLY).")
                return
            hours = int(args[1]) if len(args) > 1 and args[1].isdigit() else 6
            with open_db(self.settings) as db:
                n = repo.mute_alerts(db, f"RUN|{int(args[0])}|", hours)
                db.commit()
            self.tg.send_message(chat_id, f"{n} alerte ale furnizorului #{args[0]} oprite {hours} h.")
        else:
            self.tg.send_message(chat_id, HELP)
