"""Potrivirea codurilor de furnizor nelegate cu produsele din catalog (plan, sectiunea 3).

Metode, de la cea mai sigura (scorul propunerii):
  EAN   - acelasi cod de bare la alt furnizor (TS_GOODS_FOREIGN.BARCODE)              0.97 / 0.85 daca sint mai multe
  CODE  - acelasi cod (normalizat) la alt furnizor - de regula codul producatorului    0.95 / 0.85
  MPN   - un cod de producator din cod / denumire se gaseste in denumirea / modelul
          unui singur produs din catalog                                               0.88
  FUZZY - denumirea seamana (rapidfuzz token_set_ratio) si numerele importante
          (dimensiuni, capacitati, modele) coincid                                     <= 0.90
Brandul diferit (pricelist vs TS_GOODS.VENDOR_ID) inmulteste scorul cu 0.6. Nimic nu se leaga automat:
propunerile asteapta decizia (TPI_MATCH_CANDIDATE), legarea o face SP_PI_LINK_GOODS.
"""

from __future__ import annotations

import math
import re
import time
from array import array
from collections import Counter, defaultdict
from dataclasses import dataclass, field

from rapidfuzz import fuzz

from .models import SupplierItem

MIN_SCORE = 0.85              # prima rulare pe SW: sub 0.85 propunerile erau mai mult gresite (alt model din gama)
TOP_N = 3
POSTING_CAP = 3000            # tokenii mai frecventi nu ajuta la cautare
MPN_MAX_GOODS = 3             # un cod de producator e "specific" daca apare la cel mult atitea produse
FUZZY_CANDIDATES = 40
BRAND_CONFLICT = 0.6
RELATED_MIN_RATIO = 30      # CODE / MPN: denumirile trebuie sa aiba ceva in comun (daca brandul nu confirma)

_WORD_RE = re.compile(r"[0-9A-Za-zÀ-ɏЀ-ӿ]+(?:[./\-][0-9A-Za-zÀ-ɏЀ-ӿ]+)*")
_SPLIT_RE = re.compile(r"(?<=\d)(?=[^\W\d_])|(?<=[^\W\d_])(?=\d)")
# cuvinte de tip produs / sezon: nu deosebesc produsele intre ele
_STOP = {
    "anvelopa", "anvelope", "шина", "шины", "iarna", "vara", "зима", "лето", "всесезон", "all", "season",
    "laptop", "ноутбук", "negru", "black", "white", "alb", "pentru", "для", "with", "cu", "si", "и", "set",
    "к-т", "комплект", "the", "and", "de", "la", "din",
}


def norm_code(value: str | None) -> str:
    return "".join(ch for ch in (value or "").upper() if ch.isalnum())


def _mixed(token: str) -> bool:
    return any(ch.isdigit() for ch in token) and any(ch.isalpha() for ch in token)


# "114cm", "2000W", "64GB", "12V", "80W90" (vascozitate) sint masuri, nu coduri de producator
_UNIT_RE = re.compile(r"^(\d+[.,]?\d*(CM|MM|M|W|KW|V|L|ML|GB|TB|MB|MAH|KG|G|HZ|MHZ|GHZ|PCS|BUC|IN|INCH|SHEETS|"
                      r"MP|LM|K|RPM|BAR|DB|NM|A|AH|C)|\d+W\d+|R\d+C?)$")


def mpn_tokens(text: str | None) -> set[str]:
    """Coduri de producator posibile: litere + cel putin 3 cifre, minimum 5 caractere, fara masuri
    (ST4000VX013, TMP215-53, C3840233, HECHT676; nu 114cm / 80W90)."""
    out = set()
    for raw in _WORD_RE.findall(text or ""):
        token = norm_code(raw)
        if (len(token) >= 5 and any(ch.isalpha() for ch in token) and sum(ch.isdigit() for ch in token) >= 3
                and not _UNIT_RE.match(token)):
            out.add(token)
    return out


def _words(text: str | None) -> str:
    """Doar cuvintele (fara cifre), pentru verificarea ca doua produse cu acelasi cod sint inrudite."""
    return " ".join(t for t in fuzzy_tokens(text) if not any(ch.isdigit() for ch in t) and len(t) >= 3)


def fuzzy_tokens(text: str | None) -> list[str]:
    """Tokeni pentru asemanare: litere si cifre separate (215/65R16 -> 215 65 r 16), fara cuvinte de tip produs."""
    text = (text or "").lower()
    out = []
    for raw in re.split(r"[^0-9a-zà-ɏЀ-ӿ]+", text):
        for part in _SPLIT_RE.split(raw):
            if part and part not in _STOP and (len(part) >= 2 or part.isdigit()):
                out.append(part)
    return out


def _numbers(tokens: list[str]) -> set[str]:
    """Toate numerele, inclusiv cifrele singure: generatia modelului (Pilot Sport 5, Alpin 7) conteaza."""
    return {t.lstrip("0") or "0" for t in tokens if t.isdigit()}


@dataclass
class Proposal:
    goodsid: int
    method: str
    score: float
    detail: str = ""


@dataclass
class CatalogIndex:
    titles: dict[int, str] = field(default_factory=dict)
    codes: dict[int, str] = field(default_factory=dict)
    brands: dict[int, str] = field(default_factory=dict)
    by_ean: dict[str, set[int]] = field(default_factory=lambda: defaultdict(set))
    by_code: dict[str, dict[int, set[int]]] = field(default_factory=lambda: defaultdict(lambda: defaultdict(set)))
    by_mpn: dict[str, set[int]] = field(default_factory=lambda: defaultdict(set))
    postings: dict[str, array] = field(default_factory=dict)
    idf: dict[str, float] = field(default_factory=dict)
    linked: dict[int, set[int]] = field(default_factory=lambda: defaultdict(set))
    built_at: float = 0.0

    @classmethod
    def from_rows(cls, goods: list[tuple[int, str, str | None, int | None]], vendors: dict[int, str],
                  foreign: list[tuple[int, int, str, str | None]]) -> "CatalogIndex":
        """goods = (GOODSID, TITLE, CODE, VENDOR_ID); foreign = (GOODSID, CUSTOMERID, GOODS_CODE, BARCODE)."""
        idx = cls()
        df: Counter = Counter()
        temp: dict[str, list[int]] = defaultdict(list)
        for goodsid, title, code, vendor in goods:
            title = title or ""
            idx.titles[goodsid] = title
            if code:
                idx.codes[goodsid] = code
            if vendor in vendors:
                idx.brands[goodsid] = vendors[vendor]
            for token in mpn_tokens(f"{title} {code or ''}"):
                idx.by_mpn[token].add(goodsid)
            tokens = set(fuzzy_tokens(title))
            for token in tokens:
                df[token] += 1
                temp[token].append(goodsid)
        n = max(len(idx.titles), 1)
        for token, ids in temp.items():
            if len(ids) <= POSTING_CAP:
                idx.postings[token] = array("i", ids)
            idx.idf[token] = math.log(1 + n / df[token])
        for goodsid, customerid, goods_code, barcode in foreign:
            if goodsid not in idx.titles:
                continue
            idx.linked[customerid].add(goodsid)
            code = norm_code(goods_code)
            if len(code) >= 5 and _mixed(code):
                idx.by_code[code][customerid].add(goodsid)
            ean = (barcode or "").strip()
            if ean.isdigit() and len(ean) in (8, 12, 13, 14):
                idx.by_ean[ean].add(goodsid)
        idx.built_at = time.monotonic()
        return idx

    @classmethod
    def load(cls, db) -> "CatalogIndex":
        goods = [(r["GOODSID"], r["TITLE"], r["CODE"], r["VENDOR_ID"]) for r in db.query(
            "SELECT GOODSID, TITLE, CODE, VENDOR_ID FROM TS_GOODS WHERE COALESCE(FLG_FOLDER, 0) = 0")]
        vendors = {r["SYSSID"]: (r["TITLE"] or "").strip() for r in db.query(
            "SELECT SYSSID, TITLE FROM TS_SYSS WHERE PARENTID = 1")}
        foreign = [(r["GOODSID"], r["CUSTOMERID"], r["GOODS_CODE"], r["BARCODE"]) for r in db.query(
            "SELECT GOODSID, CUSTOMERID, GOODS_CODE, BARCODE FROM TS_GOODS_FOREIGN")]
        return cls.from_rows(goods, vendors, foreign)

    # --- potrivirea ---------------------------------------------------------------------------

    def _brand_factor(self, item: SupplierItem, goodsid: int) -> float:
        brand = (self.brands.get(goodsid) or "").lower()
        mine = (item.brand or "").lower()
        if not brand:
            return 1.0
        if brand in (item.name or "").lower() or (mine and (brand in mine or mine in brand)):
            return 1.05
        return BRAND_CONFLICT if mine else 1.0

    def match(self, supplier_id: int, item: SupplierItem) -> list[Proposal]:
        excluded = self.linked.get(supplier_id, set())
        found: dict[int, Proposal] = {}

        def add(goodsid: int, method: str, score: float, detail: str) -> None:
            if goodsid in excluded or goodsid not in self.titles:
                return
            score = min(round(score * self._brand_factor(item, goodsid), 3), 0.99)
            if goodsid not in found or score > found[goodsid].score:
                found[goodsid] = Proposal(goodsid, method, score, detail[:256])

        if item.ean and item.ean in self.by_ean:
            ids = self.by_ean[item.ean] - excluded
            for goodsid in ids:
                add(goodsid, "EAN", 0.97 if len(ids) == 1 else 0.85, f"EAN {item.ean}")

        mine_words = _words(item.name)

        def related(goodsid: int) -> bool:
            """Acelasi cod la produse fara legatura (placute de frina vs puzzle): cere brand sau denumire comuna."""
            if self._brand_factor(item, goodsid) > 1.0 or not mine_words:
                return self._brand_factor(item, goodsid) > 1.0
            return fuzz.token_set_ratio(mine_words, _words(self.titles[goodsid])) >= RELATED_MIN_RATIO

        code = norm_code(item.code)
        if len(code) >= 5 and _mixed(code) and code in self.by_code:
            ids = {g for sid, gs in self.by_code[code].items() if sid != supplier_id for g in gs} - excluded
            for goodsid in ids:
                if related(goodsid):
                    add(goodsid, "CODE", 0.95 if len(ids) == 1 else 0.85, f"cod {item.code} la alt furnizor")

        name_numbers = _numbers(fuzzy_tokens(item.name))
        for token in mpn_tokens(f"{item.code} {item.name}"):
            ids = self.by_mpn.get(token, set()) - excluded
            if 0 < len(ids) <= MPN_MAX_GOODS:
                for goodsid in ids:
                    their_numbers = _numbers(fuzzy_tokens(f"{self.titles[goodsid]} {self.codes.get(goodsid) or ''}"))
                    # acelasi soclu de bec (PGJ23T-1) la 24V vs 12V: numerele din denumire trebuie sa se regaseasca
                    if related(goodsid) and name_numbers <= their_numbers:
                        add(goodsid, "MPN", 0.88 if len(ids) == 1 else 0.8, f"{token} in catalog")

        tokens = fuzzy_tokens(item.name)
        if tokens:
            weight: dict[int, float] = defaultdict(float)
            for token in set(tokens):
                ids = self.postings.get(token)
                if ids is not None:
                    w = self.idf.get(token, 0.0)
                    for goodsid in ids:
                        weight[goodsid] += w
            mine_set = set(tokens)
            mine_numbers = _numbers(tokens)
            query = " ".join(tokens)
            for goodsid, _ in sorted(weight.items(), key=lambda kv: -kv[1])[:FUZZY_CANDIDATES]:
                if goodsid in excluded:
                    continue
                their = fuzzy_tokens(self.titles[goodsid])
                their_numbers = _numbers(their) | _numbers(fuzzy_tokens(self.codes.get(goodsid)))
                if mine_numbers:
                    # o dimensiune / capacitate / model diferit = alt produs
                    if not mine_numbers <= their_numbers or len(mine_numbers) / len(their_numbers) < 0.6:
                        continue
                if len(mine_set & set(their)) < 2:
                    continue                      # un singur cuvint comun ("генератора") nu ajunge
                if mine_numbers:
                    ratio = fuzz.token_set_ratio(query, " ".join(their))
                elif len(mine_set) >= 3:
                    # fara numere conteaza si cuvintele in plus ("Фильтр воздушный" nu e un cooler cu filtru)
                    ratio = fuzz.token_sort_ratio(query, " ".join(their))
                else:
                    continue                      # denumire generica de 1-2 cuvinte: nimic sigur
                if ratio >= (80 if mine_numbers else 88):
                    add(goodsid, "FUZZY", min(ratio / 100 * 0.88, 0.9), f"asemanare {ratio:.0f}%")

        proposals = sorted((p for p in found.values() if p.score >= MIN_SCORE), key=lambda p: -p.score)
        return proposals[:TOP_N]

    def match_items(self, supplier_id: int, items: list[SupplierItem]) -> dict[str, list[Proposal]]:
        result = {}
        for item in items:
            proposals = self.match(supplier_id, item)
            if proposals:
                result[item.code] = proposals
        return result


_CACHE: dict[str, CatalogIndex] = {}
CACHE_TTL_SEC = 6 * 3600


def get_index(db, max_age_sec: int = CACHE_TTL_SEC) -> CatalogIndex:
    """Indexul catalogului e scump de construit (~300 000 de produse): se refoloseste in proces."""
    idx = _CACHE.get("idx")
    if idx is None or time.monotonic() - idx.built_at > max_age_sec:
        idx = CatalogIndex.load(db)
        _CACHE["idx"] = idx
    return idx
