import httpx
import pytest
import respx
from helpers import supplier

from priceimport.adapters.agropiese import AgroPieseAdapter, parse_products
from priceimport.adapters.base import AdapterError, RunContext
from priceimport.adapters.http import HttpClient
from priceimport.config import Settings

BASE = "https://angro.agropiese.md/api/v1"


class FakeDb:
    """Doar load_api_config e citit de adaptor."""

    def query(self, sql, params=()):
        assert "TS_API_CONFIG" in sql
        return [{"PARAM_NAME": "API_TOKEN", "PARAM_VALUE": "secret-token"}]


def ctx(**over):
    settings = Settings(http_max_attempts=3, data_dir="data-test")
    return RunContext(settings=settings, supplier=supplier(supplier_id=14805, adapter_code="agropiese", max_rps=0),
                      db=FakeDb(), params={}, currency_ids={"MDL": 498, "USD": 840}, **over)


def product(pid, sku, engros, retail=0, brand=None):
    props = [{"param_id": 17, "value_ro": brand}] if brand else []
    return {"id": pid, "sku": sku, "name": f"Деталь {sku}", "price_engros": engros, "price_retail": retail,
            "properties": props}


def test_parse_products_rules():
    products = [product(1, "A1", 100, 150, "Bosch"), product(1, "A1", 100), product(2, "B2", 0, 50),
                product(3, "A1", 90), product(4, "", 10), product(5, "C3", "12,5"), "x"]
    r = parse_products(products, 498)
    assert [i.code for i in r.items] == ["A1", "C3"]
    a1 = r.items[0]
    assert (a1.price0, a1.price7, a1.price3, a1.cur7, a1.brand) == (100, 100, 150, 498, "Bosch")
    assert r.items[1].price7 == 12.5
    assert r.n_skipped == 1 and r.n_duplicates == 1
    assert sorted(e.error_class for e in r.row_errors) == ["NO_CODE", "SCHEMA"]


@respx.mock
def test_fetch_paginates_and_retries(monkeypatch):
    monkeypatch.setattr("priceimport.adapters.http.time.sleep", lambda s: None)
    route = respx.get(f"{BASE}/products")
    route.side_effect = [
        httpx.Response(200, json={"current_page": 1, "last_page": 2, "data": [product(1, "A1", 100)]}),
        httpx.Response(503, headers={"Retry-After": "0"}),
        httpx.Response(200, json={"current_page": 2, "last_page": 2, "data": [product(2, "B2", 50)]}),
    ]
    r = AgroPieseAdapter().fetch(ctx())
    assert [i.code for i in r.items] == ["A1", "B2"]
    assert r.n_http_calls == 3 and r.n_retries == 1
    assert route.calls[0].request.url.params["api_token"] == "secret-token"
    assert r.raw_payload and r.source_sha256


@respx.mock
def test_auth_error_is_not_retried():
    respx.get(f"{BASE}/products").mock(return_value=httpx.Response(401))
    with pytest.raises(AdapterError) as exc:
        AgroPieseAdapter().fetch(ctx())
    assert exc.value.error_class == "AUTH" and exc.value.http_status == 401
    assert len(respx.calls) == 1


@respx.mock
def test_server_error_exhausts_retries():
    respx.get(f"{BASE}/products").mock(return_value=httpx.Response(502))
    c = ctx()
    with HttpClient(c, sleep=lambda s: None) as http, pytest.raises(AdapterError) as exc:
        http.get_json(f"{BASE}/products", {"api_token": "secret-token"})
    assert exc.value.error_class == "HTTP_5XX" and exc.value.retries == 2
    assert "secret-token" not in str(exc.value)


@respx.mock
def test_missing_data_is_schema_error():
    respx.get(f"{BASE}/products").mock(return_value=httpx.Response(200, json={"message": "ok"}))
    with pytest.raises(AdapterError) as exc:
        AgroPieseAdapter().fetch(ctx())
    assert exc.value.error_class == "SCHEMA"


def test_deadline(monkeypatch):
    import time
    with pytest.raises(AdapterError) as exc:
        AgroPieseAdapter().fetch(ctx(deadline=time.monotonic() - 1))
    assert exc.value.error_class == "TIMEOUT"
