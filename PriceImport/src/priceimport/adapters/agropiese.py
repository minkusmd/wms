"""AgroPiese TGR Grup (14805): API B2B angro.agropiese.md, paginare Laravel.

Aceleasi reguli ca importul din WMS (sources/frameUtils/78 - Pricelist/AgroPiesePriceListUnit.pas):
  GET {BASE_URL}/products?api_token=...&page-length=500&page=N  (current_page, last_page, data[])
  sku -> cod, name (rusa) -> denumire, brand = proprietatea 17 "Brand", altfel 304 "Producator";
  price_engros -> PRICE0 = PRICE7, price_retail -> PRICE3, toate in lei; fara stoc in API;
  price_engros = 0 -> produsul nu intra (fara pret de achizitie); acelasi id repetat -> prima aparitie,
  acelasi sku la id-uri diferite -> primul produs.
Datele de acces: TS_API_CONFIG, API_CODE = 'AGROPIESE' (API_TOKEN, optional BASE_URL).
"""

from __future__ import annotations

import json
from typing import Any

from .. import repo
from ..models import FetchResult, RowError, SupplierItem
from ..normalize import NormalizeError, clean_text, normalize_code, parse_number
from .base import AdapterError, RunContext, SupplierAdapter, sha256_json
from .http import HttpClient

DEFAULT_BASE_URL = "https://angro.agropiese.md/api/v1"
API_CODE = "AGROPIESE"
PAGE_LENGTH = 500
MAX_PAGES = 400
BRAND_PARAM_IDS = (17, 304)


def _brand(product: dict[str, Any]) -> str | None:
    props = product.get("properties") or []
    for param_id in BRAND_PARAM_IDS:
        for prop in props:
            if isinstance(prop, dict) and prop.get("param_id") == param_id:
                value = clean_text(prop.get("value_ro") or prop.get("value_ru"), 128)
                if value:
                    return value
    return None


def parse_products(products: list[Any], mdl: int) -> FetchResult:
    items: list[SupplierItem] = []
    errors: list[RowError] = []
    seen_ids: set[Any] = set()
    seen_codes: set[str] = set()
    skipped = duplicates = 0
    for row_no, product in enumerate(products, start=1):
        if not isinstance(product, dict):
            errors.append(RowError("SCHEMA", "element care nu e obiect", row_no=row_no))
            continue
        pid = product.get("id")
        if pid in seen_ids:
            continue                     # acelasi produs listat in mai multe categorii - normal
        seen_ids.add(pid)
        try:
            code = normalize_code(product.get("sku"))
            engros = parse_number(product.get("price_engros"))
            retail = parse_number(product.get("price_retail"))
        except NormalizeError as exc:
            errors.append(RowError(exc.error_class, str(exc), row_no=row_no,
                                   code=clean_text(product.get("sku"), 128) or None))
            continue
        if not engros or engros <= 0:
            skipped += 1
            continue
        if code in seen_codes:
            duplicates += 1
            continue
        seen_codes.add(code)
        items.append(SupplierItem(code=code, name=clean_text(product.get("name"), 2048), brand=_brand(product),
                                  price0=engros, cur0=mdl, price7=engros, cur7=mdl,
                                  price3=retail if retail and retail > 0 else None, cur3=mdl, row_no=row_no))
    return FetchResult(items=items, row_errors=errors, n_fetched=len(seen_ids), n_skipped=skipped,
                       n_duplicates=duplicates)


class AgroPieseAdapter(SupplierAdapter):
    code = "agropiese"
    host = "angro.agropiese.md"
    default_price_category = 228          # categoria pricelisturilor AgroPiese din frame78

    def fetch(self, ctx: RunContext) -> FetchResult:
        config = repo.load_api_config(ctx.db, ctx.params.get("api_config_code", API_CODE))
        token = config.get("API_TOKEN")
        if not token:
            raise AdapterError("CONFIG", f"lipseste API_TOKEN in TS_API_CONFIG ({API_CODE})")
        base_url = (config.get("BASE_URL") or DEFAULT_BASE_URL).rstrip("/")
        page_length = int(ctx.params.get("page_length", PAGE_LENGTH))

        products: list[Any] = []
        with HttpClient(ctx) as http:
            page, last_page = 1, 1
            while page <= last_page:
                if page > MAX_PAGES:
                    raise AdapterError("SCHEMA", f"peste {MAX_PAGES} pagini - paginarea nu se opreste")
                root = http.get_json(f"{base_url}/products",
                                     {"api_token": token, "page-length": page_length, "page": page})
                if not isinstance(root, dict) or not isinstance(root.get("data"), list):
                    raise AdapterError("SCHEMA", f"pagina {page}: lipseste data[]", "/products", 200, http.retries)
                if page == 1:
                    last_page = max(1, int(root.get("last_page") or 1))
                products.extend(root["data"])
                ctx.progress(f"pagina {page}/{last_page}")
                page += 1
            calls, retries = http.calls, http.retries

        result = parse_products(products, ctx.currency_id("MDL"))
        result.n_http_calls, result.n_retries = calls, retries
        result.raw_payload = json.dumps(products, ensure_ascii=False).encode("utf-8")
        result.source_sha256 = sha256_json([(i.code, i.price0, i.price3) for i in result.items])
        return result
