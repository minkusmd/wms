"""NexDistribution / NEXPRIM SERVICE (275640): API api.nexdistribution.md
(portat din sources/frameUtils/78 - Pricelist/NexDistributionUnit.pas).

  GET /api/products?limit=100&page=N  (antetul api-token) -> {success, data[], pagination.last_page}
  Cheia (api-token) se cere prin GraphQL (/graphql), cu contul b2b.nexdistribution.md:
    login(email, password) { token } -> user { api_access api_token } -> generateApiToken doar daca
    contul nu are inca o cheie -> logout. API_TOKEN din configurare se foloseste direct cind lipsesc
    USERNAME / PASSWORD.

Regulile importului din WMS:
  status = false -> produsul nu intra; code (Trim) -> cod, un cod repetat se ia o singura data (primul);
  title.ro (altfel .ru) -> denumire, article -> model, category.title.ro -> categorie, quantity -> stoc
  (fara filtru de stoc); preturile in lei: PRICE0 = PRICE7 = prices.price_mdl, PRICE3 = prices.rrp;
  un rrp sub jumatate din price_mdl e in EUR si se converteste cu cursul furnizorului (price_mdl / price_euro).
Descrierile si imaginile raman la WMSParsers pina la etapa 4b.
Datele de acces: TS_API_CONFIG, API_CODE = 'NEXDISTRIBUTION' (USERNAME, PASSWORD, optional API_TOKEN, BASE_URL).
"""

from __future__ import annotations

import json
from typing import Any

from .. import repo
from ..models import FetchResult, RowError, SupplierItem
from ..normalize import NormalizeError, clean_text, normalize_code
from .base import AdapterError, RunContext, SupplierAdapter, sha256_json
from .http import HttpClient
from .jsonval import jbool, jfloat, jlang, jobj, jstr, trunc

DEFAULT_BASE_URL = "https://api.nexdistribution.md"
API_CODE = "NEXDISTRIBUTION"
PAGE_LIMIT = 100
MAX_PAGES = 1000


def rrp_in_mdl(rrp: float, price_mdl: float, price_euro: float) -> tuple[float, bool]:
    """(PRICE3 in lei, convertit?) - RrpInMdl din Delphi."""
    if rrp > 0 and price_mdl > 0 and price_euro > 0 and rrp < price_mdl * 0.5:
        return round(rrp * price_mdl / price_euro, 2), True
    return rrp, False


def parse_products(products: list[Any], mdl: int) -> FetchResult:
    items: list[SupplierItem] = []
    errors: list[RowError] = []
    seen: set[str] = set()
    total = inactive = duplicates = converted = 0
    for row_no, product in enumerate(products, start=1):
        if not isinstance(product, dict):
            continue
        total += 1
        if not jbool(product, "status", True):
            inactive += 1
            continue
        raw_code = jstr(product, "code")
        if not raw_code:
            errors.append(RowError("NO_CODE", "produs fara cod", row_no=row_no))
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
        prices = jobj(product, "prices")
        price_mdl = jfloat(prices, "price_mdl")
        rrp, was_converted = rrp_in_mdl(jfloat(prices, "rrp"), price_mdl, jfloat(prices, "price_euro"))
        converted += was_converted
        items.append(SupplierItem(
            code=code, name=clean_text(jlang(product, "title", "ro") or jlang(product, "title", "ru"), 2048),
            model=clean_text(jstr(product, "article"), 255) or None,
            category=clean_text(jlang(jobj(product, "category"), "title", "ro"), 128) or None,
            price0=price_mdl, cur0=mdl, price7=price_mdl, cur7=mdl, price3=rrp, cur3=mdl,
            stock=str(max(0, trunc(jfloat(product, "quantity")))), row_no=row_no))
    result = FetchResult(items=items, row_errors=errors, n_fetched=total, n_skipped=inactive, n_duplicates=duplicates)
    if converted:
        result.note = f"RRP convertit din EUR la {converted} produse"
    return result


def _graphql(http: HttpClient, base_url: str, query: str, variables: dict | None = None,
             bearer: str | None = None) -> dict:
    """Erorile GraphQL vin cu HTTP 200, in "errors" (detaliile in errors[].extensions.validation)."""
    body: dict[str, Any] = {"query": query}
    if variables:
        body["variables"] = variables
    root = http.post_json(f"{base_url}/graphql", body,
                          headers={"Authorization": f"Bearer {bearer}"} if bearer else None, ok=(200,))
    if not isinstance(root, dict):
        raise AdapterError("SCHEMA", "raspuns GraphQL invalid", "/graphql", 200)
    errors = root.get("errors")
    if isinstance(errors, list) and errors:
        messages = "; ".join(jstr(e, "message") for e in errors if isinstance(e, dict))
        error_class = "AUTH" if "login" in query.lower() or "unauth" in messages.lower() else "API"
        raise AdapterError(error_class, f"GraphQL: {messages[:300]}", "/graphql", 200)
    data = root.get("data")
    return data if isinstance(data, dict) else {}


def obtain_api_token(http: HttpClient, base_url: str, user: str, password: str) -> str:
    login = _graphql(http, base_url, "mutation Login($email: String!, $password: String!) { "
                                     "login(email: $email, password: $password) { status token } }",
                     {"email": user, "password": password})
    session = jstr(jobj(login, "login"), "token")
    if not session:
        raise AdapterError("AUTH", "autentificare esuata la NexDistribution (GraphQL login)", "/graphql", 200)
    try:
        account = jobj(_graphql(http, base_url, "query User { user { api_access api_token } }", bearer=session), "user")
        if account is None:
            raise AdapterError("API", "datele contului NexDistribution nu s-au putut citi", "/graphql", 200)
        if not jbool(account, "api_access", True):
            raise AdapterError("AUTH", "contul NexDistribution nu are acces la API (api_access = false)")
        token = jstr(account, "api_token")
        if not token:
            # generarea poate invalida cheia veche - doar cind contul nu are una
            generated = _graphql(http, base_url, "mutation GenerateApiToken { generateApiToken }", bearer=session)
            token = jstr(generated, "generateApiToken")
    finally:
        try:
            _graphql(http, base_url, "mutation Logout { logout }", bearer=session)
        except AdapterError:
            pass
    if not token:
        raise AdapterError("AUTH", "contul NexDistribution nu are cheie API si nu s-a putut genera una")
    return token


class NexAdapter(SupplierAdapter):
    code = "nex"
    host = "api.nexdistribution.md"
    default_price_category = 178

    def fetch(self, ctx: RunContext) -> FetchResult:
        config = repo.load_api_config(ctx.db, ctx.params.get("api_config_code", API_CODE))
        base_url = (config.get("BASE_URL") or DEFAULT_BASE_URL).rstrip("/")
        user, password, token = config.get("USERNAME"), config.get("PASSWORD"), config.get("API_TOKEN")
        if not (user and password) and not token:
            raise AdapterError("CONFIG", f"lipsesc USERNAME / PASSWORD (sau API_TOKEN) in TS_API_CONFIG ({API_CODE})")

        products: list[Any] = []
        with HttpClient(ctx) as http:
            if user and password:
                token = obtain_api_token(http, base_url, user, password)
            headers = {"api-token": token}
            page, last_page = 1, 1
            while page <= last_page:
                root = http.get_json(f"{base_url}/api/products", {"limit": PAGE_LIMIT, "page": page}, headers=headers)
                if not isinstance(root, dict) or not isinstance(root.get("data"), list):
                    raise AdapterError("SCHEMA", f"pagina {page}: lipseste data[]", "/api/products", 200, http.retries)
                if not jbool(root, "success", True):
                    raise AdapterError("API", f"pagina {page}: {jstr(root, 'message')[:200]}", "/api/products", 200)
                if page == 1:
                    last_page = min(max(1, trunc(jfloat(jobj(root, "pagination"), "last_page"))), MAX_PAGES)
                products.extend(root["data"])
                ctx.progress(f"pagina {page}/{last_page}")
                page += 1
            calls, retries = http.calls, http.retries

        result = parse_products(products, ctx.currency_id("MDL"))
        result.n_http_calls, result.n_retries = calls, retries
        result.raw_payload = json.dumps(products, ensure_ascii=False).encode("utf-8")
        result.source_sha256 = sha256_json([(i.code, i.price7, i.price3, i.stock) for i in result.items])
        return result
