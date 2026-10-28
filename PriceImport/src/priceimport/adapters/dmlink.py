"""DMLink (229466): API b2b.dmlink.md (portat din sources/b2b.api/dmlink/B2B.DMLinkPriceListImport.pas).

  POST /api/v1/auth/login {email, password} -> token (sau access_token), Bearer
  GET  /api/v2/products -> {"data": [...]} - tot catalogul intr-un raspuns (~11 000 produse, ~35 MB,
       ~15 s pe server); radacina poate fi si lista sau un obiect cu products / items

Regulile importului din WMS:
  sku (Trim) -> cod; fara sku = element invalid; stock <= 0 -> nu intra (~55% din catalog);
  un sku repetat intre produsele CU STOC se sare la toate aparitiile (un cod ambiguu nu se poate lega);
  PRICE0 = nprice (cost) daca e > 0, altfel sprice; PRICE7 = sprice (USD); PRICE3 = rprice (RRP, lei);
  brand.name, category.name, stock -> STOCK_QTY.
Descrierile si imaginile (TS_PRICELIST_ITEMS_DESCRIPTION / _IMAGES) raman la WMSParsers pina la etapa 4b.
Datele de acces: TS_API_CONFIG, API_CODE = 'DMLINK' (USERNAME, PASSWORD).
"""

from __future__ import annotations

import json
from collections import Counter
from typing import Any

from .. import repo
from ..models import FetchResult, RowError, SupplierItem
from ..normalize import NormalizeError, clean_text, normalize_code
from .base import AdapterError, RunContext, SupplierAdapter, sha256_json
from .http import HttpClient
from .jsonval import jfloat, jobj, jstr, trunc

DEFAULT_BASE_URL = "https://b2b.dmlink.md/api"
API_CODE = "DMLINK"


def products_list(root: Any) -> list[Any] | None:
    """FindProductsArray: radacina e lista sau un obiect cu cheia data / products / items."""
    if isinstance(root, list):
        return root
    if isinstance(root, dict):
        for key, value in root.items():
            if key.lower() in ("data", "products", "items") and isinstance(value, list):
                return value
    return None


def parse_catalog(products: list[Any], usd: int, mdl: int) -> FetchResult:
    errors: list[RowError] = []
    parsed: list[tuple[int, dict, int]] = []
    skipped = 0
    for row_no, product in enumerate(products, start=1):
        if not isinstance(product, dict) or not jstr(product, "sku"):
            errors.append(RowError("NO_CODE", "element fara sku sau care nu e obiect", row_no=row_no))
            continue
        stock = trunc(jfloat(product, "stock"))
        if stock <= 0:
            skipped += 1
            continue
        parsed.append((row_no, product, stock))

    # sku-ul se compara dupa Trim (Firebird ignora spatiile de la sfirsit); doar produsele cu stoc
    counts = Counter(jstr(p, "sku") for _, p, _ in parsed)
    duplicates = sum(n for n in counts.values() if n > 1)
    items: list[SupplierItem] = []
    for row_no, product, stock in parsed:
        sku = jstr(product, "sku")
        if counts[sku] > 1:
            continue
        try:
            code = normalize_code(sku[:128])
        except NormalizeError as exc:
            errors.append(RowError(exc.error_class, str(exc), row_no=row_no, code=sku[:128]))
            continue
        nprice, sprice = jfloat(product, "nprice"), jfloat(product, "sprice")
        items.append(SupplierItem(
            code=code, name=clean_text(jstr(product, "name"), 2048),
            brand=clean_text(jstr(jobj(product, "brand"), "name"), 128) or None,
            category=clean_text(jstr(jobj(product, "category"), "name"), 128) or None,
            price0=nprice if nprice > 0 else sprice, cur0=usd, price7=sprice, cur7=usd,
            price3=jfloat(product, "rprice"), cur3=mdl, stock=str(stock), row_no=row_no))
    result = FetchResult(items=items, row_errors=errors, n_fetched=len(products), n_skipped=skipped,
                         n_duplicates=duplicates)
    dup_codes = sorted(code for code, n in counts.items() if n > 1)
    if dup_codes:
        result.note = "coduri repetate, sarite: " + ", ".join(f"{c} (x{counts[c]})" for c in dup_codes)[:400]
    return result


class DMLinkAdapter(SupplierAdapter):
    code = "dmlink"
    host = "b2b.dmlink.md"
    default_price_category = 10

    def fetch(self, ctx: RunContext) -> FetchResult:
        config = repo.load_api_config(ctx.db, ctx.params.get("api_config_code", API_CODE))
        user, password = config.get("USERNAME"), config.get("PASSWORD")
        if not user or not password:
            raise AdapterError("CONFIG", f"lipsesc USERNAME / PASSWORD in TS_API_CONFIG ({API_CODE})")
        base_url = (config.get("BASE_URL") or DEFAULT_BASE_URL).rstrip("/")

        with HttpClient(ctx, read_timeout=300.0) as http:
            login = http.post_json(f"{base_url}/v1/auth/login", {"email": user, "password": password})
            token = jstr(login, "token") or jstr(login, "access_token")
            if not token:
                raise AdapterError("AUTH", "autentificarea DMLink nu a intors token", "/v1/auth/login", 200)
            ctx.progress("catalogul DMLink (un singur raspuns, ~35 MB)")
            root = http.get_json(f"{base_url}/v2/products", headers={"Authorization": f"Bearer {token}"})
            calls, retries = http.calls, http.retries
        products = products_list(root)
        if products is None:
            raise AdapterError("SCHEMA", "lipseste lista de produse in raspunsul DMLink", "/v2/products", 200)

        result = parse_catalog(products, ctx.currency_id("USD"), ctx.currency_id("MDL"))
        result.n_http_calls, result.n_retries = calls, retries
        result.raw_payload = json.dumps(products, ensure_ascii=False).encode("utf-8")
        result.source_sha256 = sha256_json([(i.code, i.price0, i.price7, i.price3, i.stock) for i in result.items])
        return result
