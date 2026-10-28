"""Etapa 4b pe Firebird embedded: staging-ul de continut, imaginile PNG, SP_PI_CONTENT_TRANSFER, drepturile."""

from __future__ import annotations

import io
import json

import httpx
import pytest
import respx
from conftest import DDL, build_db, make_settings, needs_fb
from firebird.driver import DatabaseError
from PIL import Image

from priceimport import repo
from priceimport.adapters import ADAPTERS
from priceimport.adapters.base import SupplierAdapter
from priceimport.content import run_supplier_content
from priceimport.content_images import ImageFetcher
from priceimport.db import open_db
from priceimport.models import ContentItem, FetchResult, SupplierItem

pytestmark = [pytest.mark.integration, needs_fb]

SUP = 229466
LONG_RO = "Descriere romaneasca suficient de lunga pentru produs"
CATALOG: list[dict] = []


def jpeg(color) -> bytes:
    out = io.BytesIO()
    Image.new("RGB", (40, 30), color).save(out, format="JPEG")
    return out.getvalue()


class FakeContentAdapter(SupplierAdapter):
    code = "fakecontent"
    has_content = True

    def fetch(self, ctx) -> FetchResult:
        items = [SupplierItem(code=p["sku"], name=p["sku"], price7=1, cur7=840, row_no=n)
                 for n, p in enumerate(CATALOG, start=1) if p.get("stock", 1) > 0]
        return FetchResult(items=items, raw_payload=json.dumps(CATALOG).encode())

    def content_of(self, product, code):
        return ContentItem(code=code, desc_ro=product.get("desc", ""), images=product.get("images", []))


@pytest.fixture(scope="module")
def settings(tmp_path_factory):
    folder = tmp_path_factory.mktemp("fb4b")
    db_path = build_db(folder, DDL)
    s = make_settings(db_path, folder, content_threads=2)
    with open_db(s) as db:
        for goodsid, folder_flag in [(1, 0), (2, 0), (3, 1), (4, 0)]:
            db.execute("INSERT INTO TS_GOODS (GOODSID, TITLE, FLG_FOLDER) VALUES (?, ?, ?)",
                       (goodsid, f"Produs {goodsid}", folder_flag))
        for goodsid, code in [(1, "A"), (2, "B"), (3, "D"), (1, "A2"), (4, "E")]:
            db.execute("INSERT INTO TS_GOODS_FOREIGN (GOODSID, CUSTOMERID, GOODS_CODE, GOODS_TITLE, PRICE7, FLAGS) "
                       "VALUES (?, ?, ?, 'x', 1, 8)", (goodsid, SUP, code))
        db.execute("INSERT INTO TS_GOODS_IMAGE (GOODSID, IMAGE) VALUES (2, ?)", (b"existing",))
        db.execute("INSERT INTO TS_GOODS_DSC (GOODSID, DESCRIPTION_RO, DESCRIPTION) VALUES (2, 'scurt', ?)",
                   ("Описание на русском, достаточно длинное",))
        db.execute("UPDATE TPI_SUPPLIER SET ADAPTER_CODE = 'fakecontent' WHERE SUPPLIERID = ?", (SUP,))
        db.commit()
    return s


@pytest.fixture(autouse=True)
def fake_adapter(monkeypatch):
    monkeypatch.setitem(ADAPTERS, "fakecontent", FakeContentAdapter)


def _run(settings, **kw):
    service = make_settings(settings.fb_database, settings.data_dir.parent, fb_user="PRICEIMPORT", fb_password="x",
                            content_threads=2)
    with open_db(settings) as db:
        supplier = repo.load_supplier(db, SUP)
        db.commit()
    fetcher = ImageFetcher(resolve=lambda host: ["93.184.216.34"], sleep=lambda _s: None)
    try:
        return run_supplier_content(service, supplier, fetcher=fetcher, **kw)
    finally:
        fetcher.close()


@respx.mock
def test_content_staging_download_transfer(settings):
    red, blue = jpeg((200, 0, 0)), jpeg((0, 0, 200))
    respx.get("https://img.test/a1.jpg").mock(return_value=httpx.Response(200, content=red))
    respx.get("https://img.test/a2.jpg").mock(return_value=httpx.Response(200, content=blue))
    respx.get("https://img.test/a3.jpg").mock(return_value=httpx.Response(200, content=red))   # aceeasi imagine
    respx.get("https://img.test/b1.jpg").mock(return_value=httpx.Response(200, content=blue))
    respx.get("https://img.test/e1.jpg").mock(return_value=httpx.Response(404))
    CATALOG[:] = [
        {"sku": "A", "desc": LONG_RO, "images": ["https://img.test/a1.jpg", "https://img.test/a2.jpg",
                                                 "https://img.test/a3.jpg"]},
        {"sku": "A2", "desc": "Alt text lung pentru acelasi produs, al doilea cod", "images": ["https://img.test/b1.jpg"]},
        {"sku": "B", "desc": LONG_RO, "images": ["https://img.test/b1.jpg"]},
        {"sku": "C", "desc": LONG_RO, "images": []},                       # nelegat
        {"sku": "D", "desc": LONG_RO, "images": ["https://img.test/b1.jpg"]},   # legat de o mapa
        {"sku": "E", "desc": "", "images": ["https://img.test/e1.jpg"]},
        {"sku": "Z", "desc": LONG_RO, "images": ["https://img.test/b1.jpg"], "stock": 0},  # in afara pricelistului
    ]
    s = _run(settings)
    assert s.status == "PARTIAL" and s.n_items == 6                  # E nu are nicio imagine descarcata
    # se descarca doar A, A2, E (produse fara imagini); B (produsul are imagine) si D (mapa) se amina
    assert (s.n_desc_written, s.n_img_lists_changed, s.n_img_pending, s.n_img_deferred) == (5, 5, 3, 2)
    assert (s.n_img_saved, s.n_img_failed) == (4, 1)
    assert (s.n_pairs, s.n_goods_images, s.n_images_copied, s.n_desc_copied) == (4, 1, 2, 2)

    with open_db(settings) as db:
        rows = db.query("SELECT SUPPLIER_GOODS_CODE, ORDERNO, IMAGE FROM TS_PRICELIST_ITEMS_IMAGES "
                        "WHERE SUPPLIERID = ? ORDER BY 1, 2", (SUP,))
        g1 = db.query("SELECT ORDERNO, IMAGE FROM TS_GOODS_IMAGE WHERE GOODSID = 1 ORDER BY ORDERNO")
        g2 = db.scalar("SELECT COUNT(*) FROM TS_GOODS_IMAGE WHERE GOODSID = 2")
        dsc = {r["GOODSID"]: r for r in db.query("SELECT GOODSID, DESCRIPTION_RO, DESCRIPTION FROM TS_GOODS_DSC")}
        db.commit()
    assert {r["SUPPLIER_GOODS_CODE"] for r in rows} == {"A", "A2", "B", "D", "E"}
    pending = sorted(r["SUPPLIER_GOODS_CODE"] for r in rows if r["IMAGE"] is None)
    assert pending == ["B", "D", "E"]                                    # amanate + esuat: raman cu URL-ul
    pngs = [r["IMAGE"] for r in rows if r["SUPPLIER_GOODS_CODE"] == "A"]
    assert all(p[:8] == b"\x89PNG\r\n\x1a\n" for p in pngs)
    # produsul 1: imaginile codului A (primul alfabetic), fara a treia (identica cu prima)
    assert [r["ORDERNO"] for r in g1] == [1, 2] and [bytes(r["IMAGE"]) for r in g1] == pngs[:2]
    assert g2 == 1                                                       # avea deja o imagine
    assert dsc[1]["DESCRIPTION_RO"] == LONG_RO and dsc[1]["DESCRIPTION"] is None
    assert dsc[2]["DESCRIPTION_RO"] == LONG_RO                           # "scurt" (< 20) s-a completat
    assert dsc[2]["DESCRIPTION"].startswith("Описание")                  # rusa existenta ramine


@respx.mock
def test_content_rerun_changes_nothing(settings):
    respx.get("https://img.test/e1.jpg").mock(return_value=httpx.Response(404))
    s = _run(settings)
    assert (s.n_desc_written, s.n_img_lists_changed) == (0, 0)
    assert (s.n_img_pending, s.n_img_deferred, s.n_img_failed) == (1, 2, 1)   # doar E se reincearca
    assert s.status == "PARTIAL", s.errors
    assert (s.n_images_copied, s.n_desc_copied) == (0, 0)
    dry = _run(settings, dry=True)
    assert dry.status == "DRY_RUN" and dry.n_img_pending == 1


def test_service_cannot_write_production_directly(settings):
    service = make_settings(settings.fb_database, settings.data_dir.parent, fb_user="PRICEIMPORT", fb_password="x")
    with open_db(service) as db:
        for sql in ("INSERT INTO TS_GOODS_IMAGE (GOODSID, IMAGE) VALUES (1, NULL)",
                    "INSERT INTO TS_GOODS_DSC (GOODSID, DESCRIPTION_RO) VALUES (3, 'x')"):
            with pytest.raises(DatabaseError):
                db.execute(sql)
            db.rollback()
    with open_db(settings) as db:
        runs = repo.recent_content_runs(db)
        db.commit()
    assert [r["STATUS"].strip() for r in runs] == ["PARTIAL", "PARTIAL"]   # rularea dry nu se jurnalizeaza
