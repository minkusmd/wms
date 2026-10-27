"""Etapa 2 pe Firebird embedded: aplicarea prin documente 1414, TEST_ONLY, respingeri, carantina, aprobari,
anulare, alerte, watchdog si drepturile utilizatorului PRICEIMPORT."""

from __future__ import annotations

import httpx
import pytest
import respx
from conftest import DDL, build_db, make_settings, needs_fb
from firebird.driver import DatabaseError

from priceimport import repo
from priceimport.apply import ApplyError, apply_run, rollback_run
from priceimport.coordinator import RunOutcome, run_supplier
from priceimport.db import open_db
from priceimport.models import RowError, RunStatus, Severity
from priceimport.windows import select_alerts

pytestmark = [pytest.mark.integration, needs_fb]

IN_PRICE, EPP = 8, 16


@pytest.fixture(scope="module")
def env(tmp_path_factory):
    folder = tmp_path_factory.mktemp("fb2")
    db_path = build_db(folder, DDL)
    dry = make_settings(db_path, folder)
    live = make_settings(db_path, folder, apply_enabled=True)
    with open_db(dry) as db:
        _seed(db)
        db.commit()
    return dry, live


def _seed(db) -> None:
    db.execute("UPDATE TS_CUSTOMER SET RRP_DISCOUNT = 1 WHERE CUSTOMERID = 198")
    db.execute("UPDATE TPI_SUPPLIER SET FLG_AUTO_APPLY = 1 WHERE SUPPLIERID IN (198, 14805)")
    for goodsid in range(1, 9):
        db.execute("INSERT INTO TS_GOODS (GOODSID, TITLE, PARENTID, WEBGOODSTYPE_ID) VALUES (?, ?, 100, 33)",
                   (goodsid, f"Produs {goodsid}"))
        db.execute("INSERT INTO TDB_GOODS_FLAGS (GOODSID, FLAGTYPEID, DT, VALUE_INT) VALUES (?, 3, 5213, 1)",
                   (goodsid,))
    gf = [  # (goodsid, furnizor, cod, price7, cur7, price3, flags)
        (1, 198, "A1", 100.0, 840, 0, IN_PRICE), (2, 198, "A2", 200.0, 840, 0, IN_PRICE),
        (3, 198, "BAD1", 50.0, 840, 0, IN_PRICE), (4, 198, "G1", 70.0, 840, 0, IN_PRICE),
        (5, 198, "R1", 60.0, 840, 0, 0), (6, 198, "E1", 0.0, 840, 1559, IN_PRICE | EPP),
        (7, 14805, "AG-1", 100.0, 498, 0, IN_PRICE)]
    for goodsid, supplier, code, p7, cur7, p3, flags in gf:
        db.execute("INSERT INTO TS_GOODS_FOREIGN (GOODSID, CUSTOMERID, GOODS_CODE, GOODS_TITLE, PRICE7, CURRENCY7ID, "
                   "PRICE0, CURRENCY0ID, PRICE3, CURRENCY3ID, FLAGS) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 498, ?)",
                   (goodsid, supplier, code, f"Titlu {code}", p7, cur7, p7, cur7, p3, flags))
    db.execute("INSERT INTO TS_PRICELISTS (PLID, SUPPLIERID, DATA, FLAGS) VALUES (1, 198, "
               "DATEADD(-1 DAY TO CURRENT_TIMESTAMP), 16)")
    db.execute("INSERT INTO TS_PRICELISTS (PLID, SUPPLIERID, DATA, FLAGS) VALUES (2, 198, CURRENT_TIMESTAMP, 2)")
    for plid, code, p7, p3 in [(1, "A1", 100, 0), (1, "A2", 200, 0), (1, "BAD1", 50, 0), (1, "E1", 0, 1575),
                               (2, "A1", 110, 0), (2, "A2", 150, 0), (2, "BAD1", 45, 0), (2, "R1", 80, 0),
                               (2, "E1", 0, 1700)]:
        db.execute("INSERT INTO TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, PRICE0, CURRENCY0ID, "
                   "PRICE7, CURRENCY7ID, PRICE3, CURRENCY3ID) VALUES (?, ?, ?, ?, 840, ?, 840, ?, 498)",
                   (plid, code, f"Denumire {code}", p7, p7, p3))
    db.execute("INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID) "
               "VALUES ('AGROPIESE', 'API_TOKEN', 'tok', 14805)")


def _gf(settings, code):
    with open_db(settings) as db:
        row = db.query_one("SELECT PRICE7, PRICE3, GET_FLG_VALUE(FLAGS, 3) AS IN_PRICE, GET_FLG_VALUE(FLAGS, 4) AS EPP "
                           "FROM TS_GOODS_FOREIGN WHERE GOODS_CODE = ?", (code,))
        db.commit()
    return float(row["PRICE7"]), float(row["PRICE3"] or 0), row["IN_PRICE"], row["EPP"]


def _count(settings, sql, params=()):
    with open_db(settings) as db:
        n = db.scalar(sql, params)
        db.commit()
    return n


def _supplier(settings, supplier_id):
    with open_db(settings) as db:
        cfg = repo.load_supplier(db, supplier_id)
        db.commit()
    return cfg


def test_1_test_only_changes_nothing(env):
    dry, _ = env
    outcome = run_supplier(dry, _supplier(dry, 198), plid=2)
    assert outcome.status == RunStatus.DRY_RUN and outcome.baseline == "gf"
    result = apply_run(dry, outcome.run_id, test_only=True, items=outcome.items)
    assert set(result.rejected) == {("BAD1", 3)}
    assert set(result.applied) == {("A1", 1), ("R1", 5), ("G1", 4), ("E1", 6)}
    assert _gf(dry, "A1") == (100.0, 0.0, 1, 0)                      # nimic schimbat
    assert _count(dry, "SELECT COUNT(*) FROM TDB_DOCS") == 0
    assert _count(dry, "SELECT FLAGS FROM TS_PRICELISTS WHERE PLID = 2") == 2
    assert _count(dry, "SELECT COUNT(*) FROM TPI_APPLY_BATCH WHERE STATUS = 'TESTED'") == 1


def test_2_live_apply(env):
    _, live = env
    outcome = run_supplier(live, _supplier(live, 198), plid=2)
    assert outcome.status == RunStatus.PARTIAL, outcome.errors
    assert outcome.n_applied == 4 and outcome.n_rejected == 1 and len(outcome.docids) == 4
    assert _gf(live, "A1") == (110.0, 0.0, 1, 0)                     # PRICE_UP aplicat
    assert _gf(live, "A2") == (200.0, 0.0, 1, 0)                     # -25% -> carantina, neaplicat
    assert _gf(live, "BAD1") == (50.0, 0.0, 1, 0)                    # respins de CLOSE_REEVALUARE
    assert _gf(live, "R1") == (80.0, 0.0, 1, 0)                      # reaparut in pricelist
    assert _gf(live, "G1")[2] == 0                                    # iesit din pricelist
    assert _gf(live, "E1") == (0.0, 1683.0, 1, 1)                    # RRP 1700 - 1% (ADJUST_RRP_REEVALUATION)
    assert _count(live, "SELECT FLAGS FROM TS_PRICELISTS WHERE PLID = 2") == 18          # prelucrat
    assert _count(live, "SELECT COUNT(*) FROM TDB_DOCS WHERE DOCTYPEID = 1414 AND CT = 198 AND DT = 307225") == 4
    assert _count(live, "SELECT COUNT(*) FROM TPI_GOODS_EVENT WHERE RUNID = ?", (outcome.run_id,)) == 4
    pending = {r["SUPPLIER_GOODS_CODE"]: (r["REASON_CODE"] or "").strip()
               for r in _quarantine(live)}
    assert pending == {"A2": "THRESHOLD_DOWN", "BAD1": "CLOSE_REJECTED"}
    # a doua rulare pe acelasi PLID: WMS il vede prelucrat -> baza 'prev', fara aplicare si fara carantina noua
    again = run_supplier(live, _supplier(live, 198), plid=2)
    assert again.baseline == "prev" and again.status == RunStatus.DRY_RUN and again.n_applied == 0
    with pytest.raises(ApplyError, match="baza prev"):
        apply_run(live, again.run_id, items=again.items)
    assert {r["SUPPLIER_GOODS_CODE"] for r in _quarantine(live)} == {"A2", "BAD1"}


def test_2b_pricelist_processed_by_wms_is_not_applied(env):
    _, live = env
    with open_db(live) as db:
        db.execute("INSERT INTO TS_PRICELISTS (PLID, SUPPLIERID, DATA, FLAGS) VALUES (3, 251465, CURRENT_TIMESTAMP, 16)")
        db.execute("INSERT INTO TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, PRICE7, CURRENCY7ID) VALUES (3, 'X', 1, 840)")
        db.commit()
    outcome = run_supplier(live, _supplier(live, 251465), plid=3)
    assert outcome.baseline == "prev" and outcome.n_applied == 0 and _count(live, "SELECT COUNT(*) FROM TPI_APPLY_BATCH "
                                                                            "WHERE SUPPLIERID = 251465") == 0


def _quarantine(settings):
    with open_db(settings) as db:
        rows = repo.list_quarantine(db, 198)
        db.commit()
    return rows


def test_3_approve_then_apply(env):
    _, live = env
    a2 = next(r for r in _quarantine(live) if r["SUPPLIER_GOODS_CODE"] == "A2")
    with open_db(live) as db:
        repo.decide_quarantine(db, a2["QID"], "APPROVED", "test")
        db.commit()
    # PLID-ul l-a prelucrat chiar serviciul -> aprobarea se poate aplica
    result = apply_run(live, a2["RUNID"])
    assert set(result.applied) == {("A2", 2)} and not result.rejected
    assert _gf(live, "A2") == (150.0, 0.0, 1, 0)
    with open_db(live) as db:
        assert repo.approval_key("A2", 2, 7, 150.0, 840) in repo.approved_keys(db, 198, 30)
        db.commit()


def test_4_rollback_restores_previous_values(env):
    _, live = env
    run_id = _count(live, "SELECT MIN(RUNID) FROM TPI_RUN WHERE N_APPLIED > 0")
    tested = rollback_run(live, run_id, test_only=True)
    assert tested.test_only and _gf(live, "A1")[0] == 110.0
    result = rollback_run(live, run_id)
    assert not result.rejected and len(result.applied) == 5          # inclusiv A2, aprobat in aceeasi rulare
    assert _gf(live, "A1") == (100.0, 0.0, 1, 0)
    assert _gf(live, "A2") == (200.0, 0.0, 1, 0)
    assert _gf(live, "R1")[2] == 0
    assert _gf(live, "G1")[2] == 1
    assert _gf(live, "E1")[1] == 1559.0
    assert _count(live, "SELECT STATUS FROM TPI_RUN WHERE RUNID = ?", (run_id,)).strip() == "ROLLED_BACK"
    with pytest.raises(ApplyError):
        rollback_run(live, run_id)


@respx.mock
def test_5_native_adapter_writes_snapshot_and_applies(env):
    _, live = env
    page = {"current_page": 1, "last_page": 1, "data": [
        {"id": 1, "sku": "AG-1", "name": "Фильтр", "price_engros": 110, "price_retail": 150, "properties": []},
        {"id": 2, "sku": "AG-2", "name": "Ремень", "price_engros": 20, "price_retail": 30, "properties": []}]}
    respx.get("https://angro.agropiese.md/api/v1/products").mock(return_value=httpx.Response(200, json=page))
    outcome = run_supplier(live, _supplier(live, 14805))
    assert outcome.status == RunStatus.APPLIED, outcome.errors
    assert outcome.plid and outcome.plid >= 1000 and outcome.n_applied == 1
    assert _gf(live, "AG-1")[0] == 110.0
    assert _count(live, "SELECT COUNT(*) FROM TS_PRICELIST_ITEMS WHERE PLID = ?", (outcome.plid,)) == 2
    assert _count(live, "SELECT FLAGS FROM TS_PRICELISTS WHERE PLID = ?", (outcome.plid,)) == 18
    assert _count(live, "SELECT CREATED_BY FROM TS_PRICELISTS WHERE PLID = ?", (outcome.plid,)) == 204


def test_6_service_user_privileges(env):
    dry, _ = env
    service = make_settings(dry.fb_database, dry.data_dir.parent, fb_user="PRICEIMPORT", fb_password="x")
    with open_db(service) as db:
        with pytest.raises(DatabaseError):
            db.execute("UPDATE TS_GOODS_FOREIGN SET PRICE7 = 1 WHERE GOODS_CODE = 'A1'")
        db.rollback()
    with open_db(dry) as db:
        db.execute("UPDATE TS_PRICELISTS SET FLAGS = 2 WHERE PLID = 2")
        db.execute("DELETE FROM TPI_RUN WHERE SUPPLIERID = 198")
        db.commit()
    outcome = run_supplier(service, _supplier(service, 198), plid=2)
    assert outcome.status == RunStatus.DRY_RUN, outcome.errors
    result = apply_run(service, outcome.run_id, test_only=True, items=outcome.items)
    assert result.error is None and result.docids


def test_7_alert_dedup_and_resolution(env):
    dry, _ = env
    failing = RunOutcome(supplier=_supplier(dry, 229466), status=RunStatus.ERROR, run_id=None,
                         errors=[RowError("HTTP_5XX", "HTTP 503", severity=Severity.CRIT)])
    ok = RunOutcome(supplier=_supplier(dry, 229466), status=RunStatus.DRY_RUN)
    with open_db(dry) as db:
        assert select_alerts(db, dry, [failing]) == ([failing], [])
        assert select_alerts(db, dry, [failing]) == ([], [])          # repetarea nu se mai trimite
        assert select_alerts(db, dry, [ok]) == ([], [ok])              # revenirea se anunta o data
        assert select_alerts(db, dry, [ok]) == ([], [])
        assert select_alerts(db, dry, [failing]) == ([failing], [])   # problema noua dupa rezolvare
        db.commit()


def test_8_watchdog(env):
    dry, _ = env
    with open_db(dry) as db:
        db.execute("UPDATE OR INSERT INTO TPI_HEARTBEAT (INSTANCE, HEARTBEAT_AT, HOST) "
                   "VALUES ('pi-worker', DATEADD(-30 MINUTE TO CURRENT_TIMESTAMP), 'test') MATCHING (INSTANCE)")
        db.commit()
        first = db.scalar("EXECUTE PROCEDURE SP_PI_WATCHDOG")
        second = db.scalar("EXECUTE PROCEDURE SP_PI_WATCHDOG")
        db.execute("UPDATE TPI_HEARTBEAT SET HEARTBEAT_AT = CURRENT_TIMESTAMP WHERE INSTANCE = 'pi-worker'")
        resolved = db.scalar("EXECUTE PROCEDURE SP_PI_WATCHDOG(5, 100000)")
        messages = db.query("SELECT MSG_TEXT FROM TELEGRAM_MESSAGES WHERE CHANNEL_CODE = 'ERRORS' AND SOURCE_TABLE = -50")
        db.commit()
    assert first >= 1 and second == 0 and resolved >= 1
    texts = " | ".join(m["MSG_TEXT"] for m in messages)
    assert "pi-worker nu mai raspunde" in texts and "rezolvat - WATCHDOG|HEARTBEAT" in texts
