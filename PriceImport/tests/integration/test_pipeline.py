"""Test cap-coada pe o baza Firebird 5 embedded: schema minima + DDL-ul etapei 1 + rulari reale."""

from __future__ import annotations

from datetime import datetime
from pathlib import Path

import httpx
import pytest
import respx
from conftest import DDL, build_db, make_settings, needs_fb

from priceimport import repo
from priceimport.coordinator import run_supplier
from priceimport.db import open_db
from priceimport.models import RunStatus
from priceimport.windows import run_window, send_report
from priceimport.wmscheck import compare_plid

pytestmark = [pytest.mark.integration, needs_fb]

IN_PRICE, EPP, PL_API, PL_DONE = 8, 16, 2, 16


@pytest.fixture(scope="module")
def settings(tmp_path_factory):
    folder = tmp_path_factory.mktemp("fb")
    db_path = build_db(folder, DDL[:1] + DDL[:1])       # etapa 1, rulata de doua ori (re-rulabila)
    s = make_settings(db_path, folder)
    with open_db(s) as db:
        _seed(db)
        db.commit()
    return s


def _seed(db) -> None:
    for goodsid in range(1, 7):
        db.execute("INSERT INTO TS_GOODS (GOODSID, TITLE, PARENTID, WEBGOODSTYPE_ID) VALUES (?, ?, 100, 33)",
                   (goodsid, f"Produs {goodsid}"))
    gf = [  # (goodsid, cod, price7, flags)
        (1, "A1", 100.0, IN_PRICE), (2, "A2", 200.0, IN_PRICE), (3, "A3", 50.0, IN_PRICE),
        (4, "A4", 70.0, IN_PRICE), (5, "R1", 60.0, 0)]
    for goodsid, code, p7, flags in gf:
        db.execute("INSERT INTO TS_GOODS_FOREIGN (GOODSID, CUSTOMERID, GOODS_CODE, GOODS_TITLE, PRICE7, CURRENCY7ID, "
                   "PRICE0, CURRENCY0ID, FLAGS) VALUES (?, 198, ?, ?, ?, 840, ?, 840, ?)",
                   (goodsid, code, f"Titlu {code}", p7, p7, flags))
        db.execute("INSERT INTO TDB_GOODS_FLAGS (GOODSID, FLAGTYPEID, DT, VALUE_INT) VALUES (?, 3, 5213, 1)",
                   (goodsid,))
    db.execute("INSERT INTO TS_PRICELIST_EXCLUSIOINS (SUPPLIERID, SUPPLIER_GOODS_CODE) VALUES (198, 'E1')")
    _pricelist(db, 1, 198, PL_DONE, [("A1", 100.0), ("A2", 200.0), ("A3", 50.0)])
    _pricelist(db, 2, 198, PL_API, [("A1", 125.0), ("A2", 190.0), ("R1", 80.0), ("N1", 10.0), ("E1", 5.0)])
    db.execute("INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID) "
               "VALUES ('AGROPIESE', 'API_TOKEN', 'tok', 14805)")


def _pricelist(db, plid, supplier_id, flags, rows) -> None:
    db.execute("INSERT INTO TS_PRICELISTS (PLID, SUPPLIERID, DATA, FLAGS, MENTIUNI) "
               "VALUES (?, ?, DATEADD(? MINUTE TO CURRENT_TIMESTAMP), ?, 'test')", (plid, supplier_id, plid - 10, flags))
    for code, p7 in rows:
        db.execute("INSERT INTO TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, PRICE0, CURRENCY0ID, "
                   "PRICE7, CURRENCY7ID, PRICE3, CURRENCY3ID, SUPPLIER_CATEGORY) VALUES (?, ?, ?, ?, 840, ?, 840, 0, 498, ?)",
                   (plid, code, f"Denumire {code}", p7, p7, "TV" if code.startswith("N") else "Laptop"))


def _supplier(settings, supplier_id):
    with open_db(settings) as db:
        cfg = repo.load_supplier(db, supplier_id)
        db.commit()
    return cfg


def _changes(settings, run_id):
    with open_db(settings) as db:
        rows = db.query("SELECT SUPPLIER_GOODS_CODE, CHANGE_TYPE, PRICE_FIELD, DECISION, REASON_CODE "
                        "FROM TPI_ITEM_CHANGE WHERE RUNID = ? ORDER BY SUPPLIER_GOODS_CODE, PRICE_FIELD", (run_id,))
        db.commit()
    return [(r["SUPPLIER_GOODS_CODE"], r["CHANGE_TYPE"].strip(), r["PRICE_FIELD"], r["DECISION"].strip(),
             (r["REASON_CODE"] or "").strip()) for r in rows]


def test_external_plid_dry_run(settings):
    outcome = run_supplier(settings, _supplier(settings, 198))
    assert outcome.status == RunStatus.DRY_RUN, outcome.errors
    assert outcome.plid == 2 and outcome.baseline == "gf"
    assert _changes(settings, outcome.run_id) == [
        ("A1", "PRICE_UP", 0, "QUARANTINE", "THRESHOLD_UP"),
        ("A1", "PRICE_UP", 7, "QUARANTINE", "THRESHOLD_UP"),
        ("A2", "PRICE_DOWN", 0, "APPLY", ""),
        ("A2", "PRICE_DOWN", 7, "APPLY", ""),
        ("A3", "PENDING_GONE", None, "WAIT", "FIRST_MISS"),
        ("A4", "GONE", None, "APPLY", ""),
        ("N1", "NEW", None, "IGNORE", "UNLINKED"),
        ("R1", "RETURNED", 7, "APPLY", ""),
    ]
    with open_db(settings) as db:
        run = db.query_one("SELECT * FROM VW_TPI_RUN WHERE RUNID = ?", (outcome.run_id,))
        db.commit()
    assert run["STATUS"].strip() == "DRY_RUN" and run["N_PRICE_UP"] == 1 and run["N_PRICE_DOWN"] == 1
    assert run["N_NEW"] == 1 and run["N_GONE"] == 1 and run["N_QUARANTINE"] == 2

    again = run_supplier(settings, _supplier(settings, 198))
    assert again.status == RunStatus.UNCHANGED


def test_equivalence_with_wms_queries(settings):
    with open_db(settings) as db:
        _, comparisons = compare_plid(db, 2)
        db.commit()
    assert all(c.equal for c in comparisons), [(c.kind, c.only_wms, c.only_python) for c in comparisons]
    assert [len(c.wms) for c in comparisons] == [1, 2, 1, 1]


def test_report_goes_to_telegram_queue(settings):
    outcome = run_supplier(settings, _supplier(settings, 198), plid=2)
    text = send_report(settings, "Test", [outcome], "test")
    assert "ACCENT" in text and "Carantină" in text
    with open_db(settings) as db:
        msgs = db.query("SELECT CHANNEL_CODE, SOURCE_TABLE, PARSE_MODE FROM TELEGRAM_MESSAGES")
        db.commit()
    assert ("PRICELIST_IMPORT", -50, "HTML") in [(m["CHANNEL_CODE"].strip(), m["SOURCE_TABLE"], m["PARSE_MODE"].strip())
                                                  for m in msgs]


@respx.mock
def test_agropiese_native_adapter(settings):
    page = {"current_page": 1, "last_page": 1, "data": [
        {"id": 1, "sku": "AG-1", "name": "Фильтр", "price_engros": 120.5, "price_retail": 150, "properties": []},
        {"id": 2, "sku": "AG-2", "name": "Ремень", "price_engros": 0, "price_retail": 80, "properties": []}]}
    respx.get("https://angro.agropiese.md/api/v1/products").mock(return_value=httpx.Response(200, json=page))
    cfg = _supplier(settings, 14805)
    outcome = run_supplier(settings, cfg)
    assert outcome.status == RunStatus.DRY_RUN, outcome.errors
    assert [(c.code, c.change_type.value) for c in outcome.changes] == [("AG-1", "NEW")]
    with open_db(settings) as db:
        raw_path = db.scalar("SELECT RAW_PATH FROM TPI_RUN WHERE RUNID = ?", (outcome.run_id,))
        db.commit()
    assert raw_path and Path(raw_path).exists()
    assert run_supplier(settings, cfg).status == RunStatus.UNCHANGED      # acelasi hash


def test_active_run_lock_and_stale_recovery(settings):
    with open_db(settings) as db:
        db.execute("INSERT INTO TPI_RUN (SUPPLIERID, TRIGGER_KIND, IDEMPOTENCY_KEY, STATUS, STARTED_AT, HEARTBEAT_AT) "
                   "VALUES (229466, 'MANUAL', 'lock-test', 'RUNNING', CURRENT_TIMESTAMP, "
                   "DATEADD(-10 MINUTE TO CURRENT_TIMESTAMP))")
        db.commit()
    outcome = run_supplier(settings, _supplier(settings, 229466))
    assert outcome.status == RunStatus.SKIPPED and "activa" in outcome.note
    with open_db(settings) as db:
        assert repo.abandon_stale_runs(db, 3) == 1
        db.commit()
    assert run_supplier(settings, _supplier(settings, 229466)).status == RunStatus.ERROR   # fara pricelist


def test_schedule_slot_is_idempotent(settings):
    cfg = _supplier(settings, 198)
    first = run_supplier(settings, cfg, trigger="SCHEDULE", slot="2026-10-27 09")
    second = run_supplier(settings, cfg, trigger="SCHEDULE", slot="2026-10-27 09")
    assert first.status in (RunStatus.UNCHANGED, RunStatus.DRY_RUN)
    assert second.status == RunStatus.SKIPPED and second.run_id == first.run_id


def test_window_runs_selected_suppliers(settings):
    # ora simulata 09:01: termenele se calculeaza fata de startul ferestrei
    outcomes = run_window(settings, 0, now=datetime(2031, 1, 2, 9, 1), notify=True, only={198, 14805})
    assert sorted(o.supplier.supplier_id for o in outcomes) == [198, 14805]
    assert {o.supplier.supplier_id: o.status for o in outcomes}[198] == RunStatus.UNCHANGED


def test_window_after_soft_deadline_skips(settings):
    outcomes = run_window(settings, 0, now=datetime(2031, 1, 3, 9, 45), notify=False, only={198})
    assert [o.status for o in outcomes] == [RunStatus.SKIPPED]
    assert "soft" in outcomes[0].note
