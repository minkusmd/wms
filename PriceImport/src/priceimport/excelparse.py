"""Citirea pricelisturilor Excel / CSV: foaia, randul de antet, coloanele, randurile-titlu de categorie.

Coloanele se gasesc dupa antet (alias-uri RO / RU / EN, suprascrise din suppliers/<id>.yaml) sau dupa
litera / index fix. Sablonul `wms16` = cele 16 coloane fixe ale importului din frame78
(frmPricelistImportUnit): fisierele pregatite pentru WMS se citesc fara mapare.
"""

from __future__ import annotations

import csv
import hashlib
import io
import re
import zipfile
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

from python_calamine import CalamineWorkbook

from .models import RowError, SupplierItem
from .normalize import (NormalizeError, clean_text, currency_iso, normalize_code, normalize_ean, normalize_stock,
                        parse_number, stock_is_out)

ALLOWED_EXTENSIONS = {".xlsx", ".xlsm", ".xls", ".xlsb", ".ods", ".csv"}
MAX_UNCOMPRESSED = 200 * 1024 * 1024        # xlsx = zip: protectie la "zip bomb"
HEADER_SEARCH_ROWS = 40

# ordinea conteaza: o celula primeste primul camp care se potriveste
GENERIC_ALIASES: list[tuple[str, str]] = [
    ("ean", r"\b(ean|barcode|bar\s*code|штрих|cod\s+de\s+bare|gtin)"),
    ("currency", r"^\s*(val(uta)?|валюта|currency|moneda|monedă)\s*$"),
    ("stock", r"(stoc|остат|налич|stock|qty|cantit|кол-?во|disponib|склад)"),
    ("brand", r"(brand|marc[aă]|produc[aă]tor|бренд|производител|vendor|manufacturer)"),
    ("category", r"(categ|категор|grup[aă]|группа|раздел)"),
    ("price_rrp", r"(rrp|розн|retail|recomand|pvc|pre[tț]\s*(de\s*)?v[iî]nzare|магазин|msrp)"),
    ("price_cost", r"(dealer|дилер|angro|ангро|опт|achizi|закуп|cost|net\b|partener|b2b)"),
    ("price_list", r"(pre[tț]|цена|price|стоимост)"),
    ("code", r"^\s*(cod(ul)?(\s+(produs|articol|furnizor))?|код(\s+товара)?|артикул|арт\.?|art\.?|article|sku|"
             r"part\s*(no|number|#)|p/?n|cpf|item\s*(no|code)|id)\s*\.?\s*$"),
    ("model", r"^\s*(model|модель)\s*$"),
    ("name", r"(denumire|наименование|название|товар|produs|name|descriere|description|nomenclatur)"),
]

# frame78 (frmPricelistImportUnit): rindul 0 = antet, coloane fixe dupa index
WMS16 = {"code": 0, "name": 1, "price_cost": 2, "price_rrp": 3, "currency_rrp": 4, "price_list": 5,
         "currency_list": 6, "stock": 7, "brand": 9, "model": 10, "category": 11}

PRICE_FIELDS = ("price_list", "price_cost", "price_rrp")


@dataclass
class Sheet:
    name: str
    rows: list[list[Any]]


@dataclass
class Layout:
    sheet: str
    header_row: int                      # index 0 in foaie
    columns: dict[str, int]              # camp -> index coloana
    headers: list[str]
    signature: str                       # semnatura antetului (pentru recunoastere)

    def describe(self) -> str:
        cols = ", ".join(f"{k}={col_letter(v)}" for k, v in sorted(self.columns.items(), key=lambda kv: kv[1]))
        return f"foaia '{self.sheet}', antetul pe rindul {self.header_row + 1}: {cols}"


@dataclass
class ParseResult:
    layout: Layout
    items: list[SupplierItem] = field(default_factory=list)
    row_errors: list[RowError] = field(default_factory=list)
    n_rows: int = 0
    n_skipped: int = 0
    n_duplicates: int = 0
    n_out_of_stock: int = 0


class ExcelError(Exception):
    def __init__(self, error_class: str, message: str):
        super().__init__(message)
        self.error_class = error_class


def col_letter(index: int) -> str:
    letters = ""
    index += 1
    while index:
        index, rem = divmod(index - 1, 26)
        letters = chr(65 + rem) + letters
    return letters


def col_index(letter: str) -> int:
    value = 0
    for ch in letter.strip().upper():
        value = value * 26 + (ord(ch) - 64)
    return value - 1


def file_sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def check_safe(path: Path) -> None:
    ext = path.suffix.lower()
    if ext not in ALLOWED_EXTENSIONS:
        raise ExcelError("FILE_TYPE", f"tip de fisier nepermis: {ext or '(fara extensie)'}")
    if ext in (".xlsx", ".xlsm", ".xlsb", ".ods"):
        try:
            with zipfile.ZipFile(path) as zf:
                total = sum(info.file_size for info in zf.infolist())
        except zipfile.BadZipFile as exc:
            raise ExcelError("FILE_CORRUPT", f"fisierul nu e un {ext} valid") from exc
        if total > MAX_UNCOMPRESSED:
            raise ExcelError("FILE_TOO_BIG", f"fisierul decomprimat are {total // (1 << 20)} MB")


def _cell(value: Any) -> Any:
    if isinstance(value, str):
        value = value.strip()
        return value or None
    return value


def read_sheets(path: Path) -> list[Sheet]:
    check_safe(path)
    if path.suffix.lower() == ".csv":
        raw = path.read_bytes()
        for encoding in ("utf-8-sig", "cp1251"):
            try:
                text = raw.decode(encoding)
                break
            except UnicodeDecodeError:
                continue
        try:
            delimiter = csv.Sniffer().sniff(text[:20000], delimiters=";,\t|").delimiter
        except csv.Error:
            delimiter = ";" if text.count(";") > text.count(",") else ","
        reader = csv.reader(io.StringIO(text), delimiter=delimiter)
        return [Sheet("csv", [[_cell(c) for c in row] for row in reader])]
    try:
        wb = CalamineWorkbook.from_path(str(path))
    except Exception as exc:                 # noqa: BLE001 - calamine arunca tipuri proprii
        raise ExcelError("FILE_CORRUPT", f"fisierul nu se poate citi: {exc}") from exc
    sheets = []
    for name in wb.sheet_names:
        try:
            rows = wb.get_sheet_by_name(name).to_python(skip_empty_area=False)
        except Exception:                    # noqa: BLE001 - foi grafice / protejate
            continue
        sheets.append(Sheet(name, [[_cell(c) for c in row] for row in rows]))
    return sheets


def header_signature(headers: list[str]) -> str:
    norm = sorted({re.sub(r"[\s\d.,:;()\-_/]+", " ", h.lower()).strip() for h in headers if h})
    return hashlib.sha1("|".join(norm).encode("utf-8")).hexdigest()[:16]


def compile_aliases(overrides: dict[str, Any] | None = None) -> list[tuple[str, re.Pattern]]:
    overrides = overrides or {}
    result = []
    for name, pattern in GENERIC_ALIASES:
        spec = overrides.get(name)
        if isinstance(spec, dict) and spec.get("header"):
            pattern = spec["header"]
        result.append((name, re.compile(pattern, re.IGNORECASE)))
    for name, spec in overrides.items():          # campuri doar din YAML
        if isinstance(spec, dict) and spec.get("header") and name not in dict(GENERIC_ALIASES):
            result.insert(0, (name, re.compile(spec["header"], re.IGNORECASE)))
    return result


def match_header_row(row: list[Any], aliases: list[tuple[str, re.Pattern]]) -> dict[str, int]:
    found: dict[str, int] = {}
    for index, value in enumerate(row):
        if not isinstance(value, str) or len(value) > 80:
            continue
        for name, pattern in aliases:
            if name not in found and pattern.search(value):
                found[name] = index
                break
    return found


def detect_layout(sheets: list[Sheet], spec: dict[str, Any] | None = None) -> Layout:
    """Foaia + rindul de antet cu cele mai multe coloane recunoscute (cod + cel putin un pret)."""
    spec = spec or {}
    file_spec = spec.get("file") or {}
    columns_spec: dict[str, Any] = spec.get("columns") or {}
    if spec.get("template") == "wms16":
        sheet = _pick_sheet(sheets, file_spec)
        headers = [str(c or "") for c in (sheet.rows[0] if sheet.rows else [])]
        return Layout(sheet.name, 0, dict(WMS16), headers, header_signature(headers))

    aliases = compile_aliases(columns_spec)
    fixed = {name: (col_index(s["column"]) if "column" in s else int(s["index"]))
             for name, s in columns_spec.items() if isinstance(s, dict) and ("column" in s or "index" in s)}
    search_rows = int((file_spec.get("header") or {}).get("search_rows", HEADER_SEARCH_ROWS))
    min_matches = int((file_spec.get("header") or {}).get("min_matches", 2))
    candidates = [_pick_sheet(sheets, file_spec)] if file_spec.get("sheet") else sheets

    best: tuple[int, Sheet, int, dict[str, int]] | None = None
    for sheet in candidates:
        for r, row in enumerate(sheet.rows[:search_rows]):
            found = match_header_row(row, aliases)
            found.update(fixed)
            has_price = any(f in found for f in PRICE_FIELDS)
            score = len(found) + (2 if "code" in found else 0) + (1 if has_price else 0)
            if "code" in found and has_price and len(found) >= min_matches and (best is None or score > best[0]):
                best = (score, sheet, r, found)
    if best is None:
        raise ExcelError("NO_HEADER", "nu am gasit rindul de antet (o coloana de cod si una de pret) in primele "
                                      f"{search_rows} rinduri - e nevoie de maparea coloanelor in suppliers/<id>.yaml")
    _, sheet, r, found = best
    headers = [str(c) if c is not None else "" for c in sheet.rows[r]]
    return Layout(sheet.name, r, found, headers, header_signature(headers))


def _pick_sheet(sheets: list[Sheet], file_spec: dict[str, Any]) -> Sheet:
    if not sheets:
        raise ExcelError("EMPTY", "fisierul nu are nicio foaie")
    sheet_spec = file_spec.get("sheet") or {}
    if sheet_spec.get("name_re"):
        for s in sheets:
            if re.search(sheet_spec["name_re"], s.name, re.IGNORECASE):
                return s
    index = int(sheet_spec.get("index", 0))
    non_empty = [s for s in sheets if any(any(c is not None for c in row) for row in s.rows)]
    return (non_empty or sheets)[min(index, len(non_empty or sheets) - 1)]


def _get(row: list[Any], columns: dict[str, int], name: str) -> Any:
    index = columns.get(name)
    return row[index] if index is not None and index < len(row) else None


def parse_items(sheets: list[Sheet], layout: Layout, spec: dict[str, Any], currency_ids: dict[str, int]) -> ParseResult:
    columns_spec: dict[str, Any] = spec.get("columns") or {}
    default_iso = currency_iso(spec.get("currency", "MDL")) or "MDL"
    group_rows = bool((spec.get("file") or {}).get("category_from_group_rows", True))
    cost_from_list = bool(spec.get("cost_from_list", True))
    skip_out = bool(spec.get("skip_out_of_stock", True))

    def currency_of(field_name: str, row: list[Any]) -> int:
        iso = None
        fs = columns_spec.get(field_name) or {}
        if isinstance(fs, dict) and fs.get("currency"):
            iso = currency_iso(fs["currency"])
        suffix = field_name.split("_", 1)[1]
        cell = _get(row, layout.columns, f"currency_{suffix}") or (_get(row, layout.columns, "currency")
                                                                   if iso is None else None)
        if cell is not None:
            iso = currency_iso(cell) or iso
        iso = iso or default_iso
        if iso not in currency_ids:
            raise NormalizeError("BAD_CURRENCY", f"moneda necunoscuta: {cell or iso}")
        return currency_ids[iso]

    sheet = next(s for s in sheets if s.name == layout.sheet)
    result = ParseResult(layout=layout)
    seen: set[str] = set()
    category: str | None = None
    for r in range(layout.header_row + 1, len(sheet.rows)):
        row = sheet.rows[r]
        if not any(c is not None for c in row):
            continue
        code_cell = _get(row, layout.columns, "code")
        prices_raw = {f: _get(row, layout.columns, f) for f in PRICE_FIELDS}
        filled = [c for c in row if c is not None]
        if not any(v is not None for v in prices_raw.values()) and (
                code_cell is None or (len(filled) == 1 and isinstance(filled[0], str))):
            # rind-titlu de grupa: o singura celula cu text (de multe ori chiar in coloana codului)
            if group_rows and len(filled) == 1 and isinstance(filled[0], str):
                category = clean_text(filled[0], 128)
            continue
        result.n_rows += 1
        row_no = r + 1
        try:
            code = normalize_code(code_cell)
            prices = {f: parse_number(v) for f, v in prices_raw.items()}
            if not any(p for p in prices.values()):
                result.n_skipped += 1                          # "la comanda", pret lipsa
                continue
            if any(p is not None and p < 0 for p in prices.values()):
                raise NormalizeError("NEGATIVE_PRICE", "pret negativ")
            p7, p0, p3 = prices["price_list"], prices["price_cost"], prices["price_rrp"]
            cur7 = currency_of("price_list", row) if (p7 or (p0 and cost_from_list)) else None
            cur0 = currency_of("price_cost", row) if p0 else cur7
            if not p7 and p0 and cost_from_list:
                p7, cur7 = p0, cur0                            # doar pret de achizitie: si indicativ
            if not p0 and p7 and cost_from_list:
                p0, cur0 = p7, cur7                            # conventia furnizorilor fara cost separat
            cur3 = currency_of("price_rrp", row) if p3 else None
            stock = normalize_stock(_get(row, layout.columns, "stock"))
        except NormalizeError as exc:
            result.row_errors.append(RowError(exc.error_class, str(exc), row_no=row_no,
                                              code=clean_text(code_cell, 128) or None))
            continue
        if skip_out and stock_is_out(stock):
            result.n_out_of_stock += 1
            result.n_skipped += 1
            continue
        if code in seen:
            result.n_duplicates += 1
            continue
        seen.add(code)
        result.items.append(SupplierItem(
            code=code, name=clean_text(_get(row, layout.columns, "name"), 2048),
            brand=clean_text(_get(row, layout.columns, "brand"), 128) or None,
            model=clean_text(_get(row, layout.columns, "model"), 255) or None,
            category=clean_text(_get(row, layout.columns, "category"), 128) or category,
            ean=normalize_ean(_get(row, layout.columns, "ean")),
            price0=p0, cur0=cur0, price3=p3 or None, cur3=cur3, price7=p7, cur7=cur7, stock=stock, row_no=row_no))
    return result


def suggest_mapping(path: Path) -> str:
    """Maparea propusa (YAML) pentru un fisier nou - de verificat si salvat in suppliers/<id>.yaml."""
    sheets = read_sheets(path)
    layout = detect_layout(sheets)
    lines = ["# propunere generata de `pi mapping-suggest`; verifica fiecare coloana", "adapter: excel",
             "currency: MDL            # moneda implicita a preturilor", "file:",
             f"  sheet: {{name_re: \"^{re.escape(layout.sheet)}$\"}}",
             f"  header: {{search_rows: {max(layout.header_row + 5, 10)}, min_matches: 2}}",
             "  category_from_group_rows: true", "columns:"]
    for name, index in sorted(layout.columns.items(), key=lambda kv: kv[1]):
        header = layout.headers[index] if index < len(layout.headers) else ""
        lines.append(f"  {name}: {{column: \"{col_letter(index)}\"}}   # antet: {header!r}")
    lines.append(f"# semnatura antetului: {layout.signature}")
    return "\n".join(lines) + "\n"
