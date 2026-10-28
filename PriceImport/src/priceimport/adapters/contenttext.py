"""Textul descrierilor (etapa 4b) construit ca in importurile Delphi: HTML, randuri separate cu CRLF."""

from __future__ import annotations

import re
from typing import Any, Iterable

CRLF = "\r\n"                      # sLineBreak - textele existente din staging au CRLF
MAX_URL_LEN = 512                  # TS_PRICELIST_ITEMS_IMAGES.IMAGE_URL
_NBSP_RE = re.compile("&nbsp;", re.IGNORECASE)


def html_encode(text: str) -> str:
    """TNetEncoding.HTML.Encode: doar & < > " (apostroful ramine)."""
    return (text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace('"', "&quot;"))


def features_table(rows: Iterable[tuple[str, str]]) -> str:
    """<table><tr><td>nume</td><td>valoare</td></tr>...</table>; fara randuri = ""."""
    cells = "".join(f"<tr><td>{html_encode(name)}</td><td>{html_encode(value)}</td></tr>" for name, value in rows)
    return f"<table>{cells}</table>" if cells else ""


def join_text(text: str, table: str) -> str:
    if not table:
        return text
    return f"{text}{CRLF}{table}" if text else table


def strip_tags(html: str) -> str:
    """StripTags din TriomacPriceListUnit: fiecare tag devine un spatiu, &nbsp; -> spatiu, Trim."""
    out: list[str] = []
    in_tag = False
    for ch in html:
        if ch == "<":
            in_tag = True
        elif ch == ">":
            in_tag = False
            out.append(" ")
        elif not in_tag:
            out.append(ch)
    return _NBSP_RE.sub(" ", "".join(out)).strip()


def unique_urls(values: Iterable[Any]) -> list[str]:
    """URL-urile in ordinea data, fara goluri / dubluri / URL-uri mai lungi decit coloana."""
    seen: list[str] = []
    for value in values:
        url = value.strip() if isinstance(value, str) else ""
        if url and len(url) <= MAX_URL_LEN and url not in seen:
            seen.append(url)
    return seen
