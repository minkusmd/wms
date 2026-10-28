"""Triomac (209280): API-ul de parteneri SCOP v2, scop.md/api/partner/v2
(portat din sources/frameUtils/78 - Pricelist/TriomacPriceListUnit.pas + sources/b2b.api/scop/SCOPAPIClientUnit.pas).

  POST /auth/token {key, secret} -> access_token (Bearer, 1800 s; ruta are limita ei, 10 cereri/min)
  GET  /catalog/products?limit=200[&cursor=] -> data[], meta.has_more / meta.next_cursor (tot catalogul,
       nu in_stock=1: la produsele cu culori stocul fisei e al unei singure culori)
  GET  /catalog/categories -> data[] {id, parent_id, name{ro,ru}} -> calea "Parinte / Copil / Frunza"
Cloudflare refuza unele User-Agent (Python-urllib -> 403); clientul comun trimite unul propriu.

Regulile importului din WMS:
  sku -> cod (cheia din TS_GOODS_FOREIGN; "code" e codul 1C SCOP, nu se foloseste); fara sku -> nu intra;
  stocul = suma variations[].stock > 0 la produsele cu culori, altfel stock; stoc <= 0 -> nu intra;
  pret <= 0, price.available = false, is_call_for_pricing sau valuta necunoscuta -> nu intra;
  sku repetat (comparat cu majuscule): la acelasi pret si valuta stocul se aduna la primul rind,
  altfel ramine primul produs; PRICE0 = PRICE7 = price.value (valuta listei, azi USD), PRICE3 = rrp.value
  (mereu lei); name.ro (altfel .ru), brand, calea categoriei.
EUR se rezolva dupa TS_CURRENCY.TITLE (976 in SW), nu 978 ca in Delphi.
Continutul (etapa 4b): description + "<br>" + specification (HTML), pe limbi; description egal cu denumirea
  (~60% din produse) si specification care e doar un link (~70%) nu conteaza; RU identic cu RO nu se scrie
  (SCOP trimite azi in "ru" textul romanesc). Imaginile = images[] ({url} sau sir).
Datele de acces: TS_API_CONFIG, API_CODE = 'SCOP' (API_KEY, API_SECRET, optional BASE_URL).
"""

from __future__ import annotations

import json
from typing import Any

from .. import repo
from ..models import ContentItem, FetchResult, RowError, SupplierItem
from ..normalize import NormalizeError, clean_text, normalize_code
from .base import AdapterError, RunContext, SupplierAdapter, sha256_json
from .contenttext import CRLF, strip_tags, unique_urls
from .http import HttpClient
from .jsonval import jbool, jfloat, jlang, jobj, jstr, trunc

DEFAULT_BASE_URL = "https://scop.md/api/partner/v2"
API_CODE = "SCOP"
PAGE_LIMIT = 200
MAX_PAGES = 500
CURRENCIES = ("USD", "MDL", "EUR")


def total_stock(product: dict) -> int:
    variations = [v for v in (product.get("variations") or []) if isinstance(v, dict)]
    if not variations:
        return trunc(jfloat(product, "stock"))
    return sum(s for s in (trunc(jfloat(v, "stock")) for v in variations) if s > 0)


def category_paths(categories: list[Any]) -> dict[int, str]:
    cats: dict[int, tuple[int, str]] = {}
    for c in categories:
        if isinstance(c, dict):
            cats[trunc(jfloat(c, "id"))] = (trunc(jfloat(c, "parent_id")), jlang(c, "name", "ro"))
    paths: dict[int, str] = {}
    for cat_id in cats:
        names: list[str] = []
        cur, depth = cat_id, 0
        while cur > 0 and depth < 10 and cur in cats:      # arborele are 5 niveluri; depth opreste o bucla
            parent, name = cats[cur]
            if name:
                names.insert(0, name)
            cur, depth = parent, depth + 1
        paths[cat_id] = " / ".join(names)
    return paths


def parse_catalog(products: list[Any], categories: dict[int, str], currency_ids: dict[str, int]) -> FetchResult:
    mdl = currency_ids["MDL"]
    items: list[SupplierItem] = []
    errors: list[RowError] = []
    by_sku: dict[str, int] = {}
    stocks: list[int] = []
    total = skipped = duplicates = merged = 0
    dup_codes: list[str] = []
    for row_no, product in enumerate(products, start=1):
        if not isinstance(product, dict):
            continue
        total += 1
        sku = jstr(product, "sku")
        if not sku:
            errors.append(RowError("NO_CODE", "produs fara sku", row_no=row_no, code=jstr(product, "code") or None))
            continue
        stock = total_stock(product)
        if stock <= 0:
            skipped += 1
            continue
        price_obj = jobj(product, "price")
        price = jfloat(price_obj, "value")
        iso = jstr(price_obj, "currency").upper()
        if (price <= 0 or not jbool(price_obj, "available", price_obj is not None)
                or jbool(product, "is_call_for_pricing", False) or iso not in CURRENCIES):
            skipped += 1
            continue
        cur = currency_ids[iso]
        key = sku.upper()
        if key in by_sku:
            first = items[by_sku[key]]
            if first.cur7 == cur and abs((first.price7 or 0) - price) <= 0.001:
                stocks[by_sku[key]] += stock           # aceeasi fisa pe culori (ex. '128026')
                merged += 1
            else:
                duplicates += 1
                if sku not in dup_codes:
                    dup_codes.append(sku)
            continue
        try:
            code = normalize_code(sku[:128])
        except NormalizeError as exc:
            errors.append(RowError(exc.error_class, str(exc), row_no=row_no, code=sku[:128]))
            continue
        rrp_obj = jobj(product, "rrp")
        rrp_iso = jstr(rrp_obj, "currency").upper()
        by_sku[key] = len(items)
        stocks.append(stock)
        items.append(SupplierItem(
            code=code, name=clean_text(jlang(product, "name", "ro") or jlang(product, "name", "ru"), 2048),
            brand=clean_text(jstr(product, "brand"), 128) or None,
            category=clean_text(categories.get(trunc(jfloat(product, "category_id")), ""), 128) or None,
            price0=price, cur0=cur, price7=price, cur7=cur,
            price3=jfloat(rrp_obj, "value"), cur3=currency_ids[rrp_iso] if rrp_iso in CURRENCIES else mdl,
            row_no=row_no))
    for item, stock in zip(items, stocks):
        item.stock = str(stock)
    result = FetchResult(items=items, row_errors=errors, n_fetched=total, n_skipped=skipped, n_duplicates=duplicates)
    notes = []
    if merged:
        notes.append(f"{merged} culori cu acelasi sku adunate la stoc")
    if dup_codes:
        notes.append("sku la mai multe produse, pastrat primul: " + ", ".join(dup_codes))
    result.note = "; ".join(notes)[:400] or None
    return result


def _only_link(text: str) -> bool:
    lower = text.lower()
    return not text or (lower.startswith(("http://", "https://")) and " " not in text)


def build_description(desc: str, spec: str, name: str) -> str:
    desc, spec = desc.strip(), spec.strip()
    if strip_tags(desc).lower() == name.strip().lower():
        desc = ""
    if _only_link(strip_tags(spec)):
        spec = ""
    return f"{desc}<br>{CRLF}{spec}" if desc and spec else desc + spec


def content_of(product: Any, code: str) -> ContentItem | None:
    if not isinstance(product, dict):
        return None
    name_ru = jlang(product, "name", "ru")
    name = jlang(product, "name", "ro") or name_ru
    ro = build_description(jlang(product, "description", "ro"), jlang(product, "specification", "ro"), name)
    ru = build_description(jlang(product, "description", "ru"), jlang(product, "specification", "ru"), name_ru)
    images = product.get("images")
    urls = unique_urls(jstr(i, "url") if isinstance(i, dict) else i for i in images) if isinstance(images, list) else []
    return ContentItem(code=code, desc_ro=ro, desc_ru="" if ru == ro else ru, images=urls)


class TriomacAdapter(SupplierAdapter):
    code = "triomac"
    host = "scop.md"
    default_price_category = 26
    has_content = True

    def content_of(self, product: Any, code: str) -> ContentItem | None:
        return content_of(product, code)

    def fetch(self, ctx: RunContext) -> FetchResult:
        config = repo.load_api_config(ctx.db, ctx.params.get("api_config_code", API_CODE))
        key, secret = config.get("API_KEY"), config.get("API_SECRET")
        if not key or not secret:
            raise AdapterError("CONFIG", f"lipsesc API_KEY / API_SECRET in TS_API_CONFIG ({API_CODE})")
        base_url = (config.get("BASE_URL") or "").rstrip("/")
        if "/partner/" not in base_url:                 # BASE_URL vechi (api.scop.md) nu raspunde la v2
            base_url = DEFAULT_BASE_URL

        products: list[Any] = []
        with HttpClient(ctx, read_timeout=120.0) as http:
            auth = http.post_json(f"{base_url}/auth/token", {"key": key, "secret": secret}, ok=(200,))
            token = jstr(auth, "access_token")
            if not token:
                raise AdapterError("AUTH", "autentificarea SCOP nu a intors access_token", "/auth/token", 200)
            headers = {"Authorization": f"Bearer {token}"}
            cursor, pages = "", 0
            while True:
                params: dict[str, Any] = {"limit": PAGE_LIMIT}
                if cursor:
                    params["cursor"] = cursor
                root = http.get_json(f"{base_url}/catalog/products", params, headers=headers)
                if not isinstance(root, dict) or not isinstance(root.get("data"), list):
                    raise AdapterError("SCHEMA", f"pagina {pages + 1}: lipseste data[]", "/catalog/products", 200)
                products.extend(root["data"])
                pages += 1
                ctx.progress(f"pagina {pages}")
                meta = jobj(root, "meta")
                cursor = jstr(meta, "next_cursor")
                if not jbool(meta, "has_more", False) or not cursor or pages >= MAX_PAGES:
                    break
            cats = http.get_json(f"{base_url}/catalog/categories", headers=headers)
            calls, retries = http.calls, http.retries

        currency_ids = {iso: ctx.currency_id(iso) for iso in CURRENCIES}
        cat_list = cats.get("data") if isinstance(cats, dict) else None
        result = parse_catalog(products, category_paths(cat_list if isinstance(cat_list, list) else []),
                               currency_ids)
        result.n_http_calls, result.n_retries = calls, retries
        result.raw_payload = json.dumps(products, ensure_ascii=False).encode("utf-8")
        result.source_sha256 = sha256_json([(i.code, i.price7, i.cur7, i.price3, i.stock) for i in result.items])
        return result
