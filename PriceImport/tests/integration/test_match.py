"""Etapa 4a pe Firebird embedded: propuneri salvate, legarea prin SP_PI_LINK_GOODS, respingerea, drepturile."""

from __future__ import annotations

import pytest
from conftest import DDL, build_db, make_settings, needs_fb
from firebird.driver import DatabaseError

from priceimport import repo
from priceimport.db import open_db
from priceimport.matching import _CACHE
from priceimport.matchjob import accept_candidate, reject_candidate, run_matching

pytestmark = [pytest.mark.integration, needs_fb]


@pytest.fixture(scope="module")
def settings(tmp_path_factory):
    folder = tmp_path_factory.mktemp("fb4")
    db_path = build_db(folder, DDL)
    s = make_settings(db_path, folder)
    with open_db(s) as db:
        db.execute("INSERT INTO TS_SYSS (SYSSID, PARENTID, TITLE) VALUES (7200, 1, 'Hecht')")
        db.execute("INSERT INTO TS_SYSS (SYSSID, PARENTID, TITLE) VALUES (7008, 1, 'Nokian')")
        for goodsid, title, code, vendor in [(1, "Despicator de lemne HECHT676", "HECHT676", 7200),
                                             (2, "Anvelopa Nokian 205/60 R 16 SNOWPROOF 2 96H XL", None, 7008),
                                             (3, "Ceva fara legatura", None, None)]:
            db.execute("INSERT INTO TS_GOODS (GOODSID, TITLE, CODE, VENDOR_ID) VALUES (?, ?, ?, ?)",
                       (goodsid, title, code, vendor))
        db.execute("INSERT INTO TS_GOODS_FOREIGN (GOODSID, CUSTOMERID, GOODS_CODE, GOODS_TITLE, PRICE7, FLAGS) "
                   "VALUES (1, 198, 'HECHT676', 'Despicator', 100, 8)")
        db.execute("INSERT INTO TPI_RUN (SUPPLIERID, TRIGGER_KIND, IDEMPOTENCY_KEY, STATUS, STARTED_AT, BASELINE) "
                   "VALUES (251465, 'MANUAL', 'm1', 'DRY_RUN', CURRENT_TIMESTAMP, 'gf')")
        run_id = db.scalar("SELECT MAX(RUNID) FROM TPI_RUN")
        for code, name in [("HECHT676", "Despicator de lemne electric HECHT676"),
                           ("НШЛ-114", "Шина 205/60 R16 (Snowproof 2) Nokian ЗИМА"), ("Z1", "Фильтр воздушный")]:
            db.execute("INSERT INTO TPI_ITEM_CHANGE (RUNID, SUPPLIERID, SUPPLIER_GOODS_CODE, CHANGE_TYPE, "
                       "SUPPLIER_GOODS_NAME, DECISION, REASON_CODE) VALUES (?, 251465, ?, 'NEW', ?, 'IGNORE', 'UNLINKED')",
                       (run_id, code, name))
        db.commit()
    _CACHE.clear()
    return s


def _candidates(settings, status="PROPOSED"):
    with open_db(settings) as db:
        rows = repo.list_candidates(db, 251465, status)
        db.commit()
    return {r["SUPPLIER_GOODS_CODE"]: r for r in rows}


def test_matching_saves_proposals_once(settings):
    [summary] = run_matching(settings, [251465])
    assert (summary.n_new, summary.n_with_proposals, summary.n_saved) == (3, 2, 2)
    props = _candidates(settings)
    assert props["HECHT676"]["GOODSID"] == 1 and props["HECHT676"]["METHOD"].strip() == "CODE"
    assert props["НШЛ-114"]["GOODSID"] == 2
    [again] = run_matching(settings, [251465])
    assert again.n_saved == 0                                      # nimic dublat


def test_accept_links_goods_and_reject_is_remembered(settings):
    props = _candidates(settings)
    service = make_settings(settings.fb_database, settings.data_dir.parent, fb_user="PRICEIMPORT", fb_password="x")
    with open_db(service) as db:                                   # serviciul nu poate scrie direct in GF
        with pytest.raises(DatabaseError):
            db.execute("INSERT INTO TS_GOODS_FOREIGN (GOODSID, CUSTOMERID, GOODS_CODE, GOODS_TITLE, PRICE7) "
                       "VALUES (3, 251465, 'X', 'X', 0)")
        db.rollback()
    assert accept_candidate(service, props["HECHT676"]["CANDID"], "test") == "LINKED"
    with open_db(settings) as db:
        row = db.query_one("SELECT GOODSID, FLAGS, PRICE7 FROM TS_GOODS_FOREIGN WHERE CUSTOMERID = 251465 "
                           "AND GOODS_CODE = 'HECHT676'")
        db.commit()
    assert row["GOODSID"] == 1 and row["FLAGS"] == 0 and float(row["PRICE7"]) == 0     # in afara pretului
    assert accept_candidate(settings, props["HECHT676"]["CANDID"], "test") == "ALREADY_ACCEPTED"

    assert reject_candidate(settings, props["НШЛ-114"]["CANDID"], "test") == "REJECTED"
    [summary] = run_matching(settings, [251465])
    # HECHT676 e legat (nu mai e "nou"), propunerea respinsa nu revine
    assert summary.n_new == 2 and summary.n_saved == 0 and _candidates(settings) == {}
    assert set(_candidates(settings, "REJECTED")) == {"НШЛ-114"}
