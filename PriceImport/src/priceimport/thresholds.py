"""Pragurile de siguranta: carantina pe rand + garzile care blocheaza toata rularea."""

from __future__ import annotations

import statistics
from dataclasses import dataclass

from .models import PRICE_COST, PRICE_LIST, Change, ChangeType, Decision, FetchResult
from .repo import SupplierConfig, ThresholdRule, approval_key

USD = 840
EUR = 976

INVALID_SHARE_MAX = 0.10
DUPLICATE_SHARE_MAX = 0.05
MASS_SHIFT_MIN_ITEMS = 50
MASS_SHIFT_MIN_SHARE = 0.30
MASS_SHIFT_TIGHTNESS = 0.02
MASS_SHIFT_CONCENTRATION = 0.80
MASS_SHIFT_MIN_MOVE = 0.03

_PRICE_TYPES = (ChangeType.PRICE_UP, ChangeType.PRICE_DOWN)


@dataclass
class Limits:
    max_up_pct: float
    max_down_pct: float
    min_price_usd: float | None = None
    max_price_usd: float | None = None


def resolve_limits(cfg: SupplierConfig, rules: list[ThresholdRule],
                   group: tuple[int | None, int | None] | None) -> Limits:
    """Regula cea mai specifica cistiga, separat pentru fiecare limita (furnizor+mapa > furnizor+tip >
    furnizor > tip/mapa > global > valorile din TPI_SUPPLIER)."""
    goods_type, parent = group if group else (None, None)
    limits = Limits(cfg.max_up_pct, cfg.max_down_pct)
    matching = [r for r in rules
                if r.supplier_id in (None, cfg.supplier_id)
                and (r.goods_type_id is None or r.goods_type_id == goods_type)
                and (r.parent_goods_id is None or r.parent_goods_id == parent)]
    matching.sort(key=ThresholdRule.specificity)       # cele specifice la urma, suprascriu
    for rule in matching:
        if rule.max_up_pct is not None:
            limits.max_up_pct = rule.max_up_pct
        if rule.max_down_pct is not None:
            limits.max_down_pct = rule.max_down_pct
        if rule.min_price_usd is not None:
            limits.min_price_usd = rule.min_price_usd
        if rule.max_price_usd is not None:
            limits.max_price_usd = rule.max_price_usd
    return limits


def to_usd(price: float | None, cur: int | None, rates: dict[int, float]) -> float | None:
    if price is None or cur is None or not rates.get(cur) or not rates.get(USD):
        return None
    return price * rates[cur] / rates[USD]


def _currency_mismatch(old: float, new: float, rates: dict[int, float]) -> bool:
    """Factorul nou/vechi ~ cursul (lei salvati ca USD sau invers) -> moneda gresita."""
    if old <= 0 or new <= 0:
        return False
    ratio = new / old
    for cur in (USD, EUR):
        rate = rates.get(cur)
        if not rate or rate <= 1.5:
            continue
        if 0.9 * rate <= ratio <= 1.1 * rate or 0.9 / rate <= ratio <= 1.1 / rate:
            return True
    return False


def _quarantine(change: Change, reason: str) -> None:
    change.decision, change.reason = Decision.QUARANTINE, reason


def check_change(change: Change, limits: Limits, rates: dict[int, float]) -> None:
    """Decizia pentru un rand (doar randurile inca APPLY)."""
    if change.decision != Decision.APPLY:
        return
    if change.change_type not in _PRICE_TYPES and change.change_type != ChangeType.RETURNED:
        return
    new = change.new_price
    is_price = change.change_type in _PRICE_TYPES
    if new is not None and new < 0:
        return _quarantine(change, "NEGATIVE_PRICE")
    if is_price and change.price_field in (PRICE_LIST, PRICE_COST) and not new:
        # pretul indicativ / de cost ar deveni 0 - pretul de vinzare s-ar calcula din nimic
        return _quarantine(change, "ZERO_PRICE")
    # la RETURNED pretul vechi e cel de cind produsul a iesit din pricelist - nu se compara
    if is_price and (change.old_cur is not None and change.new_cur is not None
                     and change.old_cur != change.new_cur and change.old_price):
        return _quarantine(change, "CURRENCY_CHANGED")
    if is_price and change.old_price and new and _currency_mismatch(change.old_price, new, rates):
        return _quarantine(change, "CURRENCY_MISMATCH")
    new_usd = to_usd(new, change.new_cur, rates)
    if new_usd is not None and new_usd > 0:
        if limits.min_price_usd is not None and new_usd < limits.min_price_usd:
            return _quarantine(change, "ABSURD_PRICE_LOW")
        if limits.max_price_usd is not None and new_usd > limits.max_price_usd:
            return _quarantine(change, "ABSURD_PRICE_HIGH")
    if change.change_type in _PRICE_TYPES and change.delta_pct is not None:
        if change.delta_pct > limits.max_up_pct:
            return _quarantine(change, "THRESHOLD_UP")
        if change.delta_pct < -limits.max_down_pct:
            return _quarantine(change, "THRESHOLD_DOWN")
    return None


def apply_thresholds(changes: list[Change], cfg: SupplierConfig, rules: list[ThresholdRule],
                     groups: dict[int, tuple[int | None, int | None]], rates: dict[int, float]) -> None:
    cache: dict[tuple[int | None, int | None] | None, Limits] = {}
    for change in changes:
        group = groups.get(change.goodsid) if change.goodsid is not None else None
        if group not in cache:
            cache[group] = resolve_limits(cfg, rules, group)
        check_change(change, cache[group], rates)

    # un produs se aplica intreg sau deloc: o coloana in carantina tine tot produsul in carantina
    blocked = {(c.code, c.goodsid) for c in changes if c.decision == Decision.QUARANTINE}
    for change in changes:
        if change.decision == Decision.APPLY and (change.code, change.goodsid) in blocked \
                and change.change_type in (*_PRICE_TYPES, ChangeType.RETURNED):
            change.decision, change.reason = Decision.QUARANTINE, "ITEM_QUARANTINED"


def apply_approvals(changes: list[Change], approved: set[tuple]) -> int:
    """Valorile aprobate deja din carantina (aceeasi coloana, acelasi pret nou) trec direct pe APPLY."""
    if not approved:
        return 0
    released = 0
    for c in changes:
        if c.decision == Decision.QUARANTINE and c.reason != "ITEM_QUARANTINED" and approval_key(
                c.code, c.goodsid, c.price_field, c.new_price, c.new_cur) in approved:
            c.decision, c.reason = Decision.APPLY, "APPROVED"
            released += 1
    still = {(c.code, c.goodsid) for c in changes if c.decision == Decision.QUARANTINE
             and c.reason != "ITEM_QUARANTINED"}
    for c in changes:
        if c.reason == "ITEM_QUARANTINED" and (c.code, c.goodsid) not in still:
            c.decision, c.reason = Decision.APPLY, "APPROVED"
    return released


def run_guards(fetch: FetchResult, n_prev: int | None, changes: list[Change], n_matched_in_price: int,
               cfg: SupplierConfig, params: dict | None = None) -> list[tuple[str, str]]:
    """Garzile de rulare: oricare declansata = rularea BLOCKED, nu se aplica nimic.
    `params` = suppliers/<id>.yaml (max_invalid_share / max_duplicate_share suprascriu implicitele)."""
    params = params or {}
    invalid_max = float(params.get("max_invalid_share", INVALID_SHARE_MAX))
    duplicate_max = float(params.get("max_duplicate_share", DUPLICATE_SHARE_MAX))
    problems: list[tuple[str, str]] = []
    n_valid = len(fetch.items)
    n_invalid = len(fetch.row_errors)
    if n_valid == 0:
        problems.append(("EMPTY", "pricelistul nu are nicio pozitie valida"))
    if n_prev and n_valid < cfg.min_volume_ratio * n_prev:
        problems.append(("VOLUME", f"{n_valid} pozitii valide fata de {n_prev} data trecuta "
                                   f"(minimum {cfg.min_volume_ratio:.0%})"))
    if fetch.n_fetched >= 20 and n_invalid > invalid_max * fetch.n_fetched:
        problems.append(("INVALID_ROWS", f"{n_invalid} randuri invalide din {fetch.n_fetched}"))
    if fetch.n_fetched >= 20 and fetch.n_duplicates > duplicate_max * fetch.n_fetched:
        problems.append(("DUPLICATES", f"{fetch.n_duplicates} coduri repetate din {fetch.n_fetched}"))

    ratios = [c.new_price / c.old_price for c in changes
              if c.change_type in _PRICE_TYPES and c.price_field in (PRICE_LIST, PRICE_COST)
              and c.reason != "NOISE" and c.old_price and c.new_price and c.old_cur == c.new_cur]
    if len(ratios) >= MASS_SHIFT_MIN_ITEMS and len(ratios) > MASS_SHIFT_MIN_SHARE * max(n_matched_in_price, 1):
        median = statistics.median(ratios)
        close = sum(1 for r in ratios if abs(r / median - 1) <= MASS_SHIFT_TIGHTNESS)
        if close >= MASS_SHIFT_CONCENTRATION * len(ratios) and abs(median - 1) > MASS_SHIFT_MIN_MOVE:
            problems.append(("MASS_SHIFT", f"{len(ratios)} preturi schimbate cu acelasi factor ~{median:.3f} "
                                           "(moneda sau formatul pricelistului s-a schimbat?)"))
    return problems
