"""Accent Electronic (198): API b2brestful.accent.md:8090 (portat din sources/Tools/ApiAccent/ApiAccentUnit.pas).

  POST /loginuser/getid {userlogin, userpassword}  -> guid
  POST /hard/{guid}/catalogandstock/0  (corp gol)  -> lista JSON a catalogului (tot catalogul, un raspuns)

Regulile lui GeneratePriceList (job-ul accent-pricelist din WMSParsers):
  intra doar pozitiile cu hardnum (cod) si qty > 0 (oqty nu conteaza);
  hardnum -> cod, hardname -> denumire, producername -> brand, hardtypename -> tip, rootname -> categorie;
  price -> PRICE0 (cost, USD), dprice1 -> PRICE7 (indicativ, USD), promoprice -> PRICE3 (RRP, mereu in lei -
  promopricevalute nu e folosit); un pret lipsa = 0, ca in WMS.
Datele de acces: TS_API_CONFIG, API_CODE = 'ACCENT' (USERNAME, PASSWORD, optional BASE_URL) - in Delphi erau
scrise in cod; DB Model/price_import_stage4c_api_config.sql le muta in baza.
"""

from __future__ import annotations

import json
from typing import Any

from .. import repo
from ..models import FetchResult, RowError, SupplierItem
from ..normalize import NormalizeError, clean_text, normalize_code
from .base import AdapterError, RunContext, SupplierAdapter, sha256_json
from .http import HttpClient
from .jsonval import jfloat, jstr

DEFAULT_BASE_URL = "http://b2brestful.accent.md:8090"
API_CODE = "ACCENT"


def _text(obj: dict, name: str, max_len: int) -> str:
    """PriceListText din Delphi: Trim, 'null' = gol, taiat la max_len."""
    value = jstr(obj, name)
    return "" if value.lower() == "null" else clean_text(value, max_len)


def parse_catalog(products: list[Any], usd: int, mdl: int) -> FetchResult:
    items: list[SupplierItem] = []
    errors: list[RowError] = []
    seen: set[str] = set()
    skipped = duplicates = 0
    for row_no, product in enumerate(products, start=1):
        if not isinstance(product, dict):
            errors.append(RowError("SCHEMA", "element care nu e obiect", row_no=row_no))
            continue
        raw_code = jstr(product, "hardnum")
        if not raw_code or raw_code.lower() == "null":
            skipped += 1                   # dosarele (isfolder) si pozitiile fara cod
            continue
        if jfloat(product, "qty") <= 0:
            skipped += 1
            continue
        try:
            code = normalize_code(raw_code)
        except NormalizeError as exc:
            errors.append(RowError(exc.error_class, str(exc), row_no=row_no, code=raw_code[:128]))
            continue
        if code in seen:
            duplicates += 1
            continue
        seen.add(code)
        items.append(SupplierItem(
            code=code, name=clean_text(jstr(product, "hardname"), 2048),
            brand=_text(product, "producername", 128) or None, category=_text(product, "rootname", 128) or None,
            price0=jfloat(product, "price"), cur0=usd, price7=jfloat(product, "dprice1"), cur7=usd,
            price3=jfloat(product, "promoprice"), cur3=mdl, row_no=row_no))
    return FetchResult(items=items, row_errors=errors, n_fetched=len(products), n_skipped=skipped,
                       n_duplicates=duplicates)


class AccentAdapter(SupplierAdapter):
    code = "accent"
    host = "b2brestful.accent.md"
    default_price_category = 5

    def fetch(self, ctx: RunContext) -> FetchResult:
        config = repo.load_api_config(ctx.db, ctx.params.get("api_config_code", API_CODE))
        user, password = config.get("USERNAME"), config.get("PASSWORD")
        if not user or not password:
            raise AdapterError("CONFIG", f"lipsesc USERNAME / PASSWORD in TS_API_CONFIG ({API_CODE})")
        base_url = (config.get("BASE_URL") or DEFAULT_BASE_URL).rstrip("/")

        with HttpClient(ctx, read_timeout=300.0) as http:
            login = http.post_json(f"{base_url}/loginuser/getid", {"userlogin": user, "userpassword": password})
            guid = jstr(login, "guid")
            if not guid:
                raise AdapterError("AUTH", "autentificarea Accent nu a intors guid", "/loginuser/getid", 200)
            ctx.progress("catalogul Accent")
            products = http.post_json(f"{base_url}/hard/{guid}/catalogandstock/0")
            calls, retries = http.calls, http.retries
        if not isinstance(products, list):
            raise AdapterError("SCHEMA", "catalogul Accent nu e o lista JSON", "/hard/.../catalogandstock/0", 200)

        result = parse_catalog(products, ctx.currency_id("USD"), ctx.currency_id("MDL"))
        result.n_http_calls, result.n_retries = calls, retries
        result.raw_payload = json.dumps(products, ensure_ascii=False).encode("utf-8")
        result.source_sha256 = sha256_json([(i.code, i.price0, i.price7, i.price3) for i in result.items])
        return result
