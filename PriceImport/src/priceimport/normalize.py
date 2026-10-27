"""Normalizarea datelor venite de la furnizori: numere, coduri, EAN, stoc, monede."""

from __future__ import annotations

import math
import re
import unicodedata
from typing import Any

MAX_CODE_LEN = 128          # TS_PRICELIST_ITEMS.SUPPLIER_GOODS_CODE = 512 octeti UTF8
MAX_NAME_LEN = 2048

_CONTROL_RE = re.compile(r"[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]")
_SPACES_RE = re.compile(r"\s+")
_NUM_CLEAN_RE = re.compile(r"[^\d,.\-]")

# alias-uri de moneda -> ISO; ISO -> CURRENCYID se ia din TS_CURRENCY.TITLE (EUR e 976 in SW)
CURRENCY_ALIASES = {
    "MDL": "MDL", "LEI": "MDL", "LEU": "MDL", "L": "MDL", "498": "MDL",
    "USD": "USD", "$": "USD", "840": "USD",
    "EUR": "EUR", "€": "EUR", "EURO": "EUR", "978": "EUR",
}


class NormalizeError(ValueError):
    def __init__(self, error_class: str, message: str):
        super().__init__(message)
        self.error_class = error_class


def clean_text(value: Any, max_len: int | None = None) -> str:
    if value is None:
        return ""
    text = unicodedata.normalize("NFC", str(value))
    text = _CONTROL_RE.sub(" ", text)
    text = _SPACES_RE.sub(" ", text).strip()
    if max_len is not None:
        text = text[:max_len]
    return text


def normalize_code(value: Any) -> str:
    """Codul furnizorului: fara spatii la capete / caractere de control; restul neschimbat
    (legatura cu TS_GOODS_FOREIGN.GOODS_CODE e o egalitate exacta, ca in WMS)."""
    if isinstance(value, float) and value.is_integer():
        value = int(value)          # Excel: 12345.0 -> "12345"
    code = clean_text(value)
    if not code:
        raise NormalizeError("NO_CODE", "cod lipsa")
    if len(code) > MAX_CODE_LEN:
        raise NormalizeError("BAD_SKU", f"cod prea lung ({len(code)} caractere)")
    if not any(ch.isalnum() for ch in code):
        raise NormalizeError("BAD_SKU", f"cod fara litere/cifre: {code!r}")
    return code


def parse_number(value: Any) -> float | None:
    """'1 234,50', '1.234,50', '1,234.50', '$12.5', '12,5 lei' -> float; gol -> None."""
    if value is None:
        return None
    if isinstance(value, bool):
        raise NormalizeError("BAD_NUMBER", f"valoare logica in loc de numar: {value!r}")
    if isinstance(value, (int, float)):
        if isinstance(value, float) and (math.isnan(value) or math.isinf(value)):
            return None
        return float(value)
    text = str(value).strip().replace(" ", " ").replace(" ", " ")
    if not text or text in {"-", "—", "n/a", "N/A"}:
        return None
    text = _NUM_CLEAN_RE.sub("", text.replace(" ", ""))
    if not text or text in {"-", ".", ","}:
        raise NormalizeError("BAD_NUMBER", f"nu e numar: {value!r}")
    if "," in text and "." in text:
        # separatorul zecimal e ultimul dintre cele doua
        if text.rfind(",") > text.rfind("."):
            text = text.replace(".", "").replace(",", ".")
        else:
            text = text.replace(",", "")
    elif "," in text:
        # o singura virgula = separator zecimal (localizarea RO/RU, "1,234" = 1.234);
        # mai multe virgule = separatoare de mii ("1,234,567")
        text = text.replace(",", ".") if text.count(",") == 1 else text.replace(",", "")
    elif text.count(".") > 1:
        text = text.replace(".", "")      # "1.234.567" = separatoare de mii
    try:
        return float(text)
    except ValueError as exc:
        raise NormalizeError("BAD_NUMBER", f"nu e numar: {value!r}") from exc


def round_price(value: float | None) -> float | None:
    """Preturile se compara la 2 zecimale (Ultra trimite 4 -> false 'scaderi')."""
    if value is None:
        return None
    return round(value + 0.0, 2)


def ean_valid(value: str | None) -> bool:
    if not value or not value.isdigit() or len(value) not in (8, 12, 13, 14):
        return False
    digits = [int(d) for d in value]
    check = digits.pop()
    total = sum(d * (3 if i % 2 == 0 else 1) for i, d in enumerate(reversed(digits)))
    return (10 - total % 10) % 10 == check


def normalize_ean(value: Any) -> str | None:
    text = clean_text(value).replace(" ", "")
    if isinstance(value, float) and value.is_integer():
        text = str(int(value))
    return text if ean_valid(text) else None


def currency_iso(value: Any) -> str | None:
    if value is None:
        return None
    key = clean_text(value).upper()
    return CURRENCY_ALIASES.get(key)


_STOCK_WORDS = {
    "+": "IN", "da": "IN", "yes": "IN", "есть": "IN", "в наличии": "IN", "in stoc": "IN", "stoc": "IN",
    "-": "OUT", "nu": "OUT", "no": "OUT", "нет": "OUT", "0": "OUT", "lipsa": "OUT",
}


def normalize_stock(value: Any) -> str | None:
    """Stocul ramine text (TS_PRICELIST_ITEMS.STOCK_QTY e VARCHAR(16)): '12', '>10', 'IN', 'OUT'."""
    if value is None:
        return None
    if isinstance(value, (int, float)) and not isinstance(value, bool):
        num = float(value)
        return str(int(num)) if num.is_integer() else f"{num:g}"
    text = clean_text(value)
    if not text:
        return None
    mapped = _STOCK_WORDS.get(text.lower())
    if mapped:
        return mapped
    return text[:16]


def stock_is_out(value: str | None) -> bool:
    if value is None:
        return False
    if value == "OUT":
        return True
    try:
        return float(value) <= 0
    except ValueError:
        return False
