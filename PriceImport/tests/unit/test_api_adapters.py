"""Etapa 4c: adaptoarele portate din WMSParsers (Accent, DMLink, Olis Grup, NexDistribution, Triomac).

Regulile sint cele din unit-urile Delphi; cazurile reale sint notate (SW, 28.10.2026).
"""

import json

import httpx
import pytest
import respx
from helpers import supplier

from priceimport.adapters import accent, dmlink, nex, olisgrup, triomac
from priceimport.adapters.base import AdapterError, RunContext
from priceimport.config import Settings

MDL, USD, EUR = 498, 840, 976
CUR = {"MDL": MDL, "USD": USD, "EUR": EUR}


class FakeDb:
    def __init__(self, config: dict[str, str]):
        self.config = config

    def query(self, sql, params=()):
        assert "TS_API_CONFIG" in sql
        return [{"PARAM_NAME": k, "PARAM_VALUE": v} for k, v in self.config.items()]


def ctx(supplier_id: int, adapter: str, config: dict[str, str] | None = None) -> RunContext:
    settings = Settings(http_max_attempts=2, data_dir="data-test")
    return RunContext(settings=settings, supplier=supplier(supplier_id=supplier_id, adapter_code=adapter, max_rps=0),
                      db=FakeDb(config or {}), params={}, currency_ids=CUR)


# --- Accent --------------------------------------------------------------------------------

def accent_row(code, qty="1", **over):
    row = {"code": "1", "hardnum": code, "hardname": f"Produs {code}", "qty": qty, "price": "100.5",
           "dprice1": "110", "promoprice": "2999", "promopricevalute": "USD", "producername": "HP",
           "hardtypename": "Notebook", "rootname": "NOTEBOOKS"}
    row.update(over)
    return row


def test_accent_rules():
    rows = [accent_row("A1"), accent_row("A2", qty="0"), accent_row("A3", qty=-1), accent_row("null"),
            {"isfolder": True, "code": "5", "hardname": "Dosar"}, accent_row("A1"),
            accent_row("A4", promoprice=None, producername="null")]
    r = accent.parse_catalog(rows, USD, MDL)
    assert [i.code for i in r.items] == ["A1", "A4"]
    a1 = r.items[0]
    assert (a1.price0, a1.cur0, a1.price7, a1.cur7, a1.price3, a1.cur3) == (100.5, USD, 110, USD, 2999, MDL)
    assert (a1.brand, a1.category) == ("HP", "NOTEBOOKS")
    a4 = r.items[1]
    assert a4.price3 == 0 and a4.brand is None          # RRP lipsa = 0, ca in WMS; 'null' = gol
    assert r.n_skipped == 4 and r.n_duplicates == 1


@respx.mock
def test_accent_login_then_catalog():
    base = accent.DEFAULT_BASE_URL
    login = respx.post(f"{base}/loginuser/getid").mock(return_value=httpx.Response(200, json={"guid": "G-1"}))
    respx.post(f"{base}/hard/G-1/catalogandstock/0").mock(return_value=httpx.Response(200, json=[accent_row("A1")]))
    r = accent.AccentAdapter().fetch(ctx(198, "accent", {"USERNAME": "u", "PASSWORD": "p"}))
    assert [i.code for i in r.items] == ["A1"] and r.n_http_calls == 2
    assert json.loads(login.calls[0].request.content) == {"userlogin": "u", "userpassword": "p"}


def test_accent_needs_config():
    with pytest.raises(AdapterError) as exc:
        accent.AccentAdapter().fetch(ctx(198, "accent"))
    assert exc.value.error_class == "CONFIG"


# --- DMLink --------------------------------------------------------------------------------

def dm(sku, stock=5, nprice=0, sprice=10, rprice=250):
    return {"sku": sku, "name": f"Item {sku}", "stock": stock, "nprice": nprice, "sprice": sprice,
            "rprice": rprice, "brand": {"name": "Hoco"}, "category": {"name": "Car Chargers"}}


def test_dmlink_rules():
    rows = [dm("A"), dm("B", nprice=7.5), dm("C", stock=0), dm("Black"), dm("Black ", sprice=11), dm("Black", stock=0),
            {"name": "fara sku", "stock": 3}, "x"]
    r = dmlink.parse_catalog(rows, USD, MDL)
    # sku repetat intre produsele cu stoc -> toate aparitiile sarite ("Black" = "Black " dupa Trim)
    assert [i.code for i in r.items] == ["A", "B"]
    a, b = r.items
    assert (a.price0, a.price7, a.price3, a.cur3, a.stock) == (10, 10, 250, MDL, "5")   # fara nprice: PRICE0 = sprice
    assert b.price0 == 7.5 and (a.brand, a.category) == ("Hoco", "Car Chargers")
    assert r.n_skipped == 2 and r.n_duplicates == 2 and len(r.row_errors) == 2
    assert "Black (x2)" in r.note


@pytest.mark.parametrize("root", [{"data": [dm("A")]}, [dm("A")], {"meta": {}, "Products": [dm("A")]}])
def test_dmlink_products_list(root):
    assert [p["sku"] for p in dmlink.products_list(root)] == ["A"]


@respx.mock
def test_dmlink_bearer_token():
    base = dmlink.DEFAULT_BASE_URL
    respx.post(f"{base}/v1/auth/login").mock(return_value=httpx.Response(201, json={"access_token": "T"}))
    products = respx.get(f"{base}/v2/products").mock(return_value=httpx.Response(200, json={"data": [dm("A")]}))
    r = dmlink.DMLinkAdapter().fetch(ctx(229466, "dmlink", {"USERNAME": "u@x.md", "PASSWORD": "p"}))
    assert [i.code for i in r.items] == ["A"]
    assert products.calls[0].request.headers["Authorization"] == "Bearer T"


# --- Olis Grup -----------------------------------------------------------------------------

def olis(code, stoc="3", online=None, vinz=2999):
    row = {"code": code, "stoc": stoc, "pret_vinz": vinz, "titluRO": f"Produs {code}", "brand": "HECHT",
           "categorieRO": "Motocositoare"}
    if online is not None:
        row["pret_online"] = online
    return row


def test_olis_rules_and_missing_cost_warning():
    rows = [olis("H1", online="1999.5"), olis("H1", online=1), olis("H2", stoc="0"), olis(""), olis("H3", stoc="2.5",
                                                                                                     online=10)]
    r = olisgrup.parse_feed(rows, MDL)
    assert [i.code for i in r.items] == ["H1", "H3"]
    h1 = r.items[0]
    assert (h1.price0, h1.price7, h1.price3, h1.cur0) == (1999.5, 1999.5, 2999, MDL)
    assert r.items[1].stock == "2.5" and r.n_duplicates == 1 and r.n_skipped == 1 and not r.warnings
    # din oct 2026 feed-ul nu mai are pret_online: PRICE0 = PRICE7 = 0, ca in WMS, plus avertisment
    r = olisgrup.parse_feed([olis("H1"), olis("H2")], MDL)
    assert [i.price7 for i in r.items] == [0, 0] and r.warnings[0].error_class == "NO_COST_PRICE"


@respx.mock
def test_olis_feed_must_be_list():
    respx.get(olisgrup.DEFAULT_FEED_URL).mock(return_value=httpx.Response(200, json={"error": "x"}))
    with pytest.raises(AdapterError) as exc:
        olisgrup.OlisGrupAdapter().fetch(ctx(251465, "olisgrup"))
    assert exc.value.error_class == "SCHEMA"


# --- NexDistribution -----------------------------------------------------------------------

def nexp(code, status=True, mdl=2544, euro=130, rrp=3000, qty=4):
    return {"code": code, "status": status, "title": {"ro": f"Produs {code}", "ru": "Товар"}, "article": "ART-1",
            "quantity": qty, "category": {"title": {"ro": "Velo Sport > Sonerii"}},
            "prices": {"price_mdl": mdl, "price_euro": euro, "rrp": rrp}}


def test_nex_rules():
    rows = [nexp("NX-1"), nexp("NX-2", status=False), nexp("NX-1"), nexp("НФ-3", rrp=150, qty=-2)]
    r = nex.parse_products(rows, MDL)
    assert [i.code for i in r.items] == ["NX-1", "НФ-3"]
    a, b = r.items
    assert (a.price0, a.price7, a.price3, a.model, a.category, a.stock) == (2544, 2544, 3000, "ART-1",
                                                                             "Velo Sport > Sonerii", "4")
    assert b.price3 == round(150 * 2544 / 130, 2) and b.stock == "0"      # rrp in EUR convertit
    assert r.n_skipped == 1 and r.n_duplicates == 1 and "1 produse" in r.note


@respx.mock
def test_nex_graphql_token_and_pages():
    base = nex.DEFAULT_BASE_URL
    gql = respx.post(f"{base}/graphql")
    gql.side_effect = [
        httpx.Response(200, json={"data": {"login": {"status": True, "token": "S"}}}),
        httpx.Response(200, json={"data": {"user": {"api_access": True, "api_token": "K"}}}),
        httpx.Response(200, json={"data": {"logout": True}}),
    ]
    pages = respx.get(f"{base}/api/products")
    pages.side_effect = [
        httpx.Response(200, json={"success": True, "data": [nexp("NX-1")], "pagination": {"last_page": 2}}),
        httpx.Response(200, json={"success": True, "data": [nexp("NX-2")], "pagination": {"last_page": 2}}),
    ]
    r = nex.NexAdapter().fetch(ctx(275640, "nex", {"USERNAME": "a@b.md", "PASSWORD": "p"}))
    assert [i.code for i in r.items] == ["NX-1", "NX-2"]
    assert pages.calls[0].request.headers["api-token"] == "K"
    assert gql.calls[1].request.headers["Authorization"] == "Bearer S"
    assert len(gql.calls) == 3                       # logout si fara generateApiToken (contul are cheie)


@respx.mock
def test_nex_graphql_error_is_auth():
    respx.post(f"{nex.DEFAULT_BASE_URL}/graphql").mock(
        return_value=httpx.Response(200, json={"errors": [{"message": "Invalid credentials"}]}))
    with pytest.raises(AdapterError) as exc:
        nex.NexAdapter().fetch(ctx(275640, "nex", {"USERNAME": "a@b.md", "PASSWORD": "x"}))
    assert exc.value.error_class == "AUTH"


# --- Triomac / SCOP ------------------------------------------------------------------------

def scop(sku, stock=5, price=12.5, cur="USD", rrp=399, **over):
    row = {"code": f"1C-{sku}", "sku": sku, "name": {"ro": f"Produs {sku}", "ru": "Товар"}, "brand": "OTI",
           "category_id": 3, "stock": stock, "stock_exact": True, "is_call_for_pricing": False,
           "price": {"value": price, "currency": cur, "available": True}, "rrp": {"value": rrp, "currency": "MDL"}}
    row.update(over)
    return row


CATS = [{"id": 1, "parent_id": 0, "name": {"ro": "Menaj"}}, {"id": 2, "parent_id": 1, "name": {"ro": "Ghivece"}},
        {"id": 3, "parent_id": 2, "name": {"ro": "Ibis"}}]


def test_triomac_category_paths():
    assert triomac.category_paths(CATS)[3] == "Menaj / Ghivece / Ibis"


def test_triomac_rules():
    rows = [
        scop("128026", stock=2), scop("128026", stock=3),              # aceeasi fisa pe culori: stocul se aduna
        scop("128026", stock=1, price=13),                             # pret diferit: ramine primul
        scop("V1", stock=0, variations=[{"stock": 4}, {"stock": -1}, {"stock": 2}]),   # stocul = suma culorilor
        scop("Z0", stock=0), scop("P0", price=0), scop("CALL", is_call_for_pricing=True), scop("XX", cur="GBP"),
        scop("E1", cur="eur"), scop("", stock=3),
    ]
    r = triomac.parse_catalog(rows, triomac.category_paths(CATS), CUR)
    assert [i.code for i in r.items] == ["128026", "V1", "E1"]
    first, v1, e1 = r.items
    assert (first.stock, first.price0, first.price7, first.cur7, first.price3, first.cur3) == ("5", 12.5, 12.5, USD,
                                                                                               399, MDL)
    assert first.category == "Menaj / Ghivece / Ibis" and v1.stock == "6" and e1.cur7 == EUR   # EUR = 976
    assert r.n_skipped == 4 and r.n_duplicates == 1 and len(r.row_errors) == 1
    assert "128026" in r.note


@respx.mock
def test_triomac_cursor_pages():
    base = triomac.DEFAULT_BASE_URL
    token = respx.post(f"{base}/auth/token").mock(return_value=httpx.Response(200, json={"access_token": "T"}))
    pages = respx.get(f"{base}/catalog/products")
    pages.side_effect = [
        httpx.Response(200, json={"data": [scop("A")], "meta": {"has_more": True, "next_cursor": "c2"}}),
        httpx.Response(200, json={"data": [scop("B")], "meta": {"has_more": False, "next_cursor": None}}),
    ]
    respx.get(f"{base}/catalog/categories").mock(return_value=httpx.Response(200, json={"data": CATS}))
    r = triomac.TriomacAdapter().fetch(ctx(209280, "triomac", {"API_KEY": "scop_k", "API_SECRET": "s",
                                                               "BASE_URL": "https://api.scop.md"}))
    assert [i.code for i in r.items] == ["A", "B"]
    assert json.loads(token.calls[0].request.content) == {"key": "scop_k", "secret": "s"}
    assert pages.calls[1].request.url.params["cursor"] == "c2"
    assert pages.calls[0].request.headers["Authorization"] == "Bearer T"
