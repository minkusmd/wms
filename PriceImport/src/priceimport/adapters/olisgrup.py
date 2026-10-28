"""Olis Grup (251465): feed-ul JSON price.muncitorul.md (portat din Parsers/OlisGrupPriceListUnit.pas).

  GET https://price.muncitorul.md/api/products.json  - lista de produse, fara autentificare

Regulile importului din WMS:
  code (Trim) -> cod; stoc <= 0 -> nu intra; un cod repetat se ia o singura data (primul);
  PRICE0 = PRICE7 = pret_online, PRICE3 = pret_vinz, toate in lei;
  titluRO -> denumire, brand, categorieRO, stoc -> STOCK_QTY.
Continutul (etapa 4b, ca OlisGrupContentUnit): DESCRIPTION_RO / _RU = textRO / textRU (HTML) + tabelul
features (name_RO/value_RO, respectiv name_RU/value_RU); imaginile = imagini[] (URL-uri).
"""

from __future__ import annotations

import json
from typing import Any

from ..models import ContentItem, FetchResult, RowError, Severity, SupplierItem
from ..normalize import NormalizeError, clean_text, normalize_code
from .base import AdapterError, RunContext, SupplierAdapter, sha256_json
from .contenttext import features_table, join_text, unique_urls
from .http import HttpClient
from .jsonval import jfloat, jstr

DEFAULT_FEED_URL = "https://price.muncitorul.md/api/products.json"


def _stock_text(stock: float) -> str:
    """FloatToStr(Stock, Invariant): 5 -> '5', 2.5 -> '2.5'."""
    return str(int(stock)) if stock.is_integer() else f"{stock:g}"


def parse_feed(products: list[Any], mdl: int) -> FetchResult:
    items: list[SupplierItem] = []
    errors: list[RowError] = []
    seen: set[str] = set()
    total = skipped = duplicates = 0
    for row_no, product in enumerate(products, start=1):
        if not isinstance(product, dict):
            continue
        total += 1
        raw_code = jstr(product, "code")
        if not raw_code:
            errors.append(RowError("NO_CODE", "produs fara cod", row_no=row_no))
            continue
        stock = jfloat(product, "stoc")
        if stock <= 0:
            skipped += 1
            continue
        if raw_code in seen:
            duplicates += 1
            continue
        seen.add(raw_code)
        try:
            code = normalize_code(raw_code[:128])
        except NormalizeError as exc:
            errors.append(RowError(exc.error_class, str(exc), row_no=row_no, code=raw_code[:128]))
            continue
        online = jfloat(product, "pret_online")
        items.append(SupplierItem(
            code=code, name=clean_text(jstr(product, "titluRO"), 2048),
            brand=clean_text(jstr(product, "brand"), 128) or None,
            category=clean_text(jstr(product, "categorieRO"), 128) or None,
            price0=online, cur0=mdl, price7=online, cur7=mdl, price3=jfloat(product, "pret_vinz"), cur3=mdl,
            stock=_stock_text(stock)[:16], row_no=row_no))
    result = FetchResult(items=items, row_errors=errors, n_fetched=total, n_skipped=skipped, n_duplicates=duplicates)
    no_price = sum(1 for i in items if not i.price7)
    if items and no_price > 0.5 * len(items):
        # din ~14 oct 2026 feed-ul nu mai are deloc pret_online: WMS scria PRICE0 = PRICE7 = 0 la toate
        result.warnings.append(RowError("NO_COST_PRICE", f"{no_price} din {len(items)} produse fara pret_online "
                                                         "(pretul de achizitie) in feed", severity=Severity.WARN))
    return result


def description(product: dict, lang: str) -> str:
    features = product.get("features")
    rows = []
    for f in features if isinstance(features, list) else []:
        name, value = jstr(f, f"name_{lang}"), jstr(f, f"value_{lang}")
        if name and value:
            rows.append((name, value))
    return join_text(jstr(product, f"text{lang}"), features_table(rows))


def content_of(product: Any, code: str) -> ContentItem | None:
    if not isinstance(product, dict):
        return None
    images = product.get("imagini")
    urls = unique_urls(jstr({"v": v}, "v") for v in images) if isinstance(images, list) else []
    return ContentItem(code=code, desc_ro=description(product, "RO"), desc_ru=description(product, "RU"),
                       images=urls)


class OlisGrupAdapter(SupplierAdapter):
    code = "olisgrup"
    host = "price.muncitorul.md"
    default_price_category = 17
    has_content = True

    def content_of(self, product: Any, code: str) -> ContentItem | None:
        return content_of(product, code)

    def fetch(self, ctx: RunContext) -> FetchResult:
        url = ctx.params.get("feed_url", DEFAULT_FEED_URL)
        with HttpClient(ctx, read_timeout=300.0) as http:
            ctx.progress("feed-ul Olis Grup")
            products = http.get_json(url)
            calls, retries = http.calls, http.retries
        if not isinstance(products, list):
            raise AdapterError("SCHEMA", "feed-ul Olis Grup nu e o lista JSON de produse", "/api/products.json", 200)

        result = parse_feed(products, ctx.currency_id("MDL"))
        result.n_http_calls, result.n_retries = calls, retries
        result.raw_payload = json.dumps(products, ensure_ascii=False).encode("utf-8")
        result.source_sha256 = sha256_json([(i.code, i.price7, i.price3, i.stock) for i in result.items])
        return result
