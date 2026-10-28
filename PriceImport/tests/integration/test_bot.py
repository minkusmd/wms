"""Etapa 3 cap-coada: botul pe Firebird embedded, cu Bot API simulat (respx)."""

from __future__ import annotations

import io
import json
from urllib.parse import parse_qs

import httpx
import openpyxl
import pytest
import respx
from conftest import DDL, build_db, make_settings, needs_fb

from priceimport import repo
from priceimport.bot.handler import BotHandler
from priceimport.bot.runner import OFFSET_KEY, process_updates
from priceimport.bot.telegram import TelegramClient
from priceimport.db import open_db

pytestmark = [pytest.mark.integration, needs_fb]

TOKEN = "123456789:TEST_TOKEN_abcdefghijklmnopqrstuvwxyz"
API = "https://tg.test"
TEOCOM = 74852
ADMIN, VIEWER, STRANGER = 111, 222, 999
IN_PRICE = 8


def xlsx_bytes(rows) -> bytes:
    wb = openpyxl.Workbook()
    ws = wb.active
    ws.title = "Прайс"
    for row in rows:
        ws.append(row)
    buf = io.BytesIO()
    wb.save(buf)
    return buf.getvalue()


TEOCOM_FILE = xlsx_bytes([["Прайс Теоком"], ["Артикул", "Наименование", "Цена, лей", "Наличие"],
                          ["T1", "Чайник", 110, "+"], ["T2", "Утюг", 95, "+"], ["T3", "Фен", 300, "+"],
                          ["T9", "Новинка", 50, "+"]])
TEOCOM_FILE_2 = xlsx_bytes([["Прайс Теоком (2)"], ["Артикул", "Наименование", "Цена, лей", "Наличие"],
                            ["T1", "Чайник", 112, "+"], ["T2", "Утюг", 96, "+"], ["T3", "Фен", 301, "+"]])
UNKNOWN_FILE = xlsx_bytes([["Cod", "Denumire", "Pret"], ["Z1", "Ceva", 10], ["Z2", "Altceva", 20]])


class FakeTelegram:
    """Bot API simulat: inregistreaza mesajele trimise, serveste fisierele dupa file_id."""

    def __init__(self):
        self.sent: list[dict] = []
        self.documents: list[dict] = []
        self.files: dict[str, bytes] = {}
        self.updates: list[dict] = []
        self.msg_id = 1000

    def install(self, router: respx.MockRouter) -> None:
        def method(request: httpx.Request) -> httpx.Response:
            name = request.url.path.rsplit("/", 1)[-1]
            if name == "sendDocument":
                self.documents.append({"size": len(request.content)})
                return httpx.Response(200, json={"ok": True, "result": {}})
            form = {k: v[0] for k, v in parse_qs(request.content.decode()).items()}
            if name == "sendMessage":
                self.msg_id += 1
                form["markup"] = json.loads(form.get("reply_markup", "null"))
                form["message_id"] = self.msg_id
                self.sent.append(form)
                return httpx.Response(200, json={"ok": True, "result": {"message_id": self.msg_id}})
            if name == "getFile":
                return httpx.Response(200, json={"ok": True, "result": {"file_id": form["file_id"],
                                                                        "file_path": f"docs/{form['file_id']}"}})
            if name == "getUpdates":
                updates, self.updates = self.updates, []
                return httpx.Response(200, json={"ok": True, "result": updates})
            return httpx.Response(200, json={"ok": True, "result": True})

        router.post(url__startswith=f"{API}/bot{TOKEN}/").mock(side_effect=method)
        router.get(url__startswith=f"{API}/file/bot{TOKEN}/docs/").mock(
            side_effect=lambda r: httpx.Response(200, content=self.files[r.url.path.rsplit("/", 1)[-1]]))

    def last(self) -> dict:
        return self.sent[-1]

    def buttons(self, message: dict) -> list[str]:
        markup = message.get("markup") or {}
        return [b["callback_data"] for row in markup.get("inline_keyboard", []) for b in row]


def document_update(update_id, user, file_key, name="Teocom 28.10.xlsx", caption=None, unique=None):
    return {"update_id": update_id, "message": {
        "message_id": update_id * 10, "chat": {"id": user, "type": "private"}, "from": {"id": user, "first_name": "U"},
        "caption": caption, "document": {"file_id": file_key, "file_unique_id": unique or f"u-{file_key}",
                                         "file_name": name, "file_size": 1000}}}


def callback_update(update_id, user, data, message_id=1):
    return {"update_id": update_id, "callback_query": {"id": f"cb{update_id}", "from": {"id": user}, "data": data,
                                                       "message": {"message_id": message_id, "chat": {"id": user}}}}


def text_update(update_id, user, text, reply_text=None):
    message = {"message_id": update_id * 10, "chat": {"id": user, "type": "private"}, "from": {"id": user}, "text": text}
    if reply_text:
        message["reply_to_message"] = {"message_id": 5, "text": reply_text}
    return {"update_id": update_id, "message": message}


@pytest.fixture(scope="module")
def env(tmp_path_factory):
    folder = tmp_path_factory.mktemp("fb3")
    db_path = build_db(folder, DDL)
    settings = make_settings(db_path, folder, apply_enabled=True, bot_token=TOKEN, telegram_api_base=API)
    with open_db(settings) as db:
        db.execute("INSERT INTO TS_CUSTOMER (CUSTOMERID, NAME) VALUES (74852, 'TEOCOM LUX SRL')")
        db.execute("INSERT INTO TPI_SUPPLIER (SUPPLIERID, ADAPTER_CODE, SOURCE_KIND, WINDOW_MASK) VALUES (74852, 'excel', 'B', 0)")
        db.execute("INSERT INTO TPI_BOT_USER (TG_USER_ID, NAME, ROLE_CODE) VALUES (111, 'Admin', 'APPLY')")
        db.execute("INSERT INTO TPI_BOT_USER (TG_USER_ID, NAME, ROLE_CODE) VALUES (222, 'Operator', 'VIEW')")
        for goodsid, code, p7 in [(11, "T1", 100.0), (12, "T2", 100.0), (13, "T3", 300.0)]:
            db.execute("INSERT INTO TS_GOODS (GOODSID, TITLE) VALUES (?, ?)", (goodsid, code))
            db.execute("INSERT INTO TDB_GOODS_FLAGS (GOODSID, FLAGTYPEID, DT, VALUE_INT) VALUES (?, 3, 5213, 1)", (goodsid,))
            db.execute("INSERT INTO TS_GOODS_FOREIGN (GOODSID, CUSTOMERID, GOODS_CODE, GOODS_TITLE, PRICE7, CURRENCY7ID, "
                       "PRICE0, CURRENCY0ID, FLAGS) VALUES (?, 74852, ?, ?, ?, 498, ?, 498, ?)",
                       (goodsid, code, code, p7, p7, IN_PRICE))
        db.commit()
    fake = FakeTelegram()
    fake.files.update({"f1": TEOCOM_FILE, "f2": TEOCOM_FILE_2, "f3": UNKNOWN_FILE})
    return settings, fake


def _run(env, *updates):
    settings, fake = env
    with respx.mock(assert_all_called=False) as router:
        fake.install(router)
        fake.sent, fake.documents = [], []                 # doar mesajele acestei ture
        fake.updates = list(updates)
        client = TelegramClient(TOKEN, API)
        handler = BotHandler(settings, client)
        with open_db(settings) as db:
            saved = repo.bot_state_get(db, OFFSET_KEY)
            db.commit()
        process_updates(handler, settings, int(saved) if saved else None)
        client.close()
    return fake


def _p7(settings, code):
    with open_db(settings) as db:
        value = db.scalar("SELECT PRICE7 FROM TS_GOODS_FOREIGN WHERE GOODS_CODE = ?", (code,))
        db.commit()
    return float(value)


def _inbox(settings, file_id):
    with open_db(settings) as db:
        row = repo.inbox_get(db, file_id)
        db.commit()
    return row


def test_1_stranger_is_refused(env):
    fake = _run(env, text_update(1, STRANGER, "/status"))
    assert "Acces interzis" in fake.last()["text"] and str(STRANGER) in fake.last()["text"]


def test_2_caption_preview_then_apply(env):
    settings, _ = env
    fake = _run(env, document_update(2, ADMIN, "f1", caption="#74852 de azi"))
    preview = next(m for m in fake.sent if "Fisier #" in m["text"])
    assert "TEOCOM" in preview["text"] and "apl:1" in fake.buttons(preview)
    assert fake.documents, "fisierul .xlsx cu detalii trimis"
    row = _inbox(settings, 1)
    assert row["STATUS"].strip() == "PREVIEW" and row["SUPPLIERID"] == TEOCOM and row["RUNID"]
    assert row["DETECT_METHOD"].strip() == "CAPTION"
    with open_db(settings) as db:
        assert any(r["RULE_TYPE"].strip() == "HEADER_SIG" for r in repo.file_rules(db))    # antetul invatat
        db.commit()
    assert _p7(settings, "T1") == 100.0                               # previzualizarea nu aplica nimic

    fake = _run(env, callback_update(3, ADMIN, "apl:1"))
    assert "aplicat" in fake.last()["text"] and "documentele" in fake.last()["text"]
    assert _p7(settings, "T1") == 110.0 and _p7(settings, "T2") == 95.0
    assert _inbox(settings, 1)["STATUS"].strip() == "APPLIED"
    fake = _run(env, callback_update(4, ADMIN, "apl:1"))
    assert "nu se poate aplica" in fake.last()["text"]                 # a doua apasare nu aplica din nou


def test_3_duplicate_file(env):
    fake = _run(env, document_update(5, ADMIN, "f1"))
    assert "primit deja" in fake.last()["text"]
    fake = _run(env, document_update(6, ADMIN, "f1", unique="alt-id"))   # acelasi continut, alt mesaj
    assert "Acelasi continut" in fake.last()["text"]


def test_4_recognized_by_header_and_codes_viewer_cannot_apply(env):
    settings, _ = env
    fake = _run(env, document_update(7, VIEWER, "f2", name="price.xlsx"))
    preview = next(m for m in fake.sent if "Fisier #" in m["text"])
    file_id = int(preview["text"].split("Fisier #")[1].split()[0])
    row = _inbox(settings, file_id)
    assert row["SUPPLIERID"] == TEOCOM and "HEADER_SIG" in row["DETECT_METHOD"]
    assert not any(b.startswith("apl:") for b in fake.buttons(preview))
    fake = _run(env, callback_update(8, VIEWER, f"apl:{file_id}"))
    assert "Nu ai dreptul" in fake.last()["text"]
    fake = _run(env, callback_update(9, VIEWER, f"rap:{file_id}"))
    assert _inbox(settings, file_id)["STATUS"].strip() == "REPORTED"


def test_5_unknown_supplier_asks_then_reply_with_id(env):
    settings, _ = env
    fake = _run(env, document_update(10, ADMIN, "f3", name="lista.xlsx"))
    question = fake.last()
    assert "nu sint sigur" in question["text"]
    file_id = int(question["text"].split("Fisierul #")[1].split()[0])
    assert _inbox(settings, file_id)["STATUS"].strip() == "NEEDS_SUPPLIER"
    fake = _run(env, text_update(11, ADMIN, "#74852", reply_text=question["text"]))
    assert any("Fisier #" in m["text"] for m in fake.sent)
    assert _inbox(settings, file_id)["STATUS"].strip() == "PREVIEW"


def test_6_commands_and_offset(env):
    settings, _ = env
    fake = _run(env, text_update(12, VIEWER, "/status"), text_update(13, ADMIN, "/carantina"),
                text_update(14, VIEWER, "/aproba 1"))
    texts = [m["text"] for m in fake.sent]
    assert any("Ultimele rulari" in t for t in texts) and any("Carantina" in t for t in texts)
    assert "Nu ai dreptul" in texts[-1]
    with open_db(settings) as db:
        assert repo.bot_state_get(db, OFFSET_KEY) == "15"
        db.commit()


def test_7_match_proposals_in_bot(env):
    settings, _ = env
    with open_db(settings) as db:
        db.execute("INSERT INTO TS_GOODS (GOODSID, TITLE) VALUES (20, 'Fierbator Tefal KO200')")
        db.execute("INSERT INTO TPI_MATCH_CANDIDATE (SUPPLIERID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, GOODSID, "
                   "METHOD, SCORE, DETAIL) VALUES (74852, 'T7', 'Чайник Tefal KO200', 20, 'MPN', 0.88, 'KO200')")
        cand = db.scalar("SELECT MAX(CANDID) FROM TPI_MATCH_CANDIDATE")
        db.commit()
    fake = _run(env, text_update(20, VIEWER, "/potriviri"))
    assert "Propuneri de legare: 1" in fake.last()["text"] and not fake.buttons(fake.last())   # VIEW: fara butoane
    fake = _run(env, text_update(21, ADMIN, "/potriviri 74852"))
    assert f"mok:{cand}" in fake.buttons(fake.last())
    fake = _run(env, callback_update(22, ADMIN, f"mok:{cand}"))
    assert "legat" in fake.last()["text"]
    with open_db(settings) as db:
        assert db.scalar("SELECT GOODSID FROM TS_GOODS_FOREIGN WHERE CUSTOMERID = 74852 AND GOODS_CODE = 'T7'") == 20
        db.commit()
