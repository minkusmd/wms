"""Motorul de comparare: pricelistul nou vs starea curenta a furnizorului.

Baza "gf" (implicita) reproduce cele 4 reevaluari din WMS (frame78 / Parsers/PriceListReevaluationUnit):
  produse noi      = cod legat in TS_GOODS_FOREIGN, fara niciun rand cu FLG_IN_PRICE  -> RETURNED
  produse vechi    = rand cu FLG_IN_PRICE, codul lipseste din pricelist               -> GONE / PENDING_GONE
  preturi marite   = PRICE7 mai mare, PRICE0 (>0) mai mare, PRICE3 mai mare la EPP    -> PRICE_UP
  preturi scazute  = aceleasi, mai mici                                                -> PRICE_DOWN
cu filtrul WMS GET_FLG_IN_PRICE(GOODSID) = 1 pentru schimbarile de pret. In plus fata de WMS:
codurile nelegate (NEW), zgomotul de rotunjire (NOISE), "dispărut" abia dupa a doua rulare.

Baza "prev" se foloseste cind WMS a facut deja reevaluarile pentru pricelistul citit
(TS_GOODS_FOREIGN il contine deja): se compara cu pricelistul precedent al furnizorului.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field

from .models import (PRICE_COST, PRICE_LIST, PRICE_RRP, Change, ChangeType, Decision, GfRow,
                     SupplierItem)
from .normalize import round_price

BASELINE_GF = "gf"
BASELINE_PREV = "prev"


@dataclass
class DiffResult:
    baseline: str
    changes: list[Change] = field(default_factory=list)
    n_matched: int = 0          # pozitii legate de produse
    n_matched_in_price: int = 0  # pozitii legate si in pret (baza pentru garda MASS_SHIFT)
    n_excluded: int = 0

    def count(self, change_type: ChangeType, decisions: tuple[Decision, ...] | None = None) -> int:
        return sum(1 for c in self.changes if c.change_type == change_type
                   and (decisions is None or c.decision in decisions))


def adjust_rrp(price: float | None, discount_pct: float) -> float | None:
    """Ce scrie ADJUST_RRP_REEVALUATION in TS_GOODS_FOREIGN.PRICE3 la produsele EPP:
    ceil(round(price3 - abs(price3 / 100 * RRP_DISCOUNT))) - ROUND din Firebird rotunjeste .5 in sus."""
    if price is None or not discount_pct:
        return price
    value = price - abs(price / 100.0 * discount_pct)
    return float(math.ceil(math.floor(abs(value) + 0.5) * (1 if value >= 0 else -1)))


def _delta_pct(old: float, new: float) -> float | None:
    if not old:
        return None
    return (new - old) / abs(old) * 100.0


def _price_change(item: SupplierItem, goodsid: int | None, field_no: int, new: float | None,
                  new_cur: int | None, old: float | None, old_cur: int | None, noise_pct: float,
                  rates: dict[int, float]) -> Change | None:
    raw_new, raw_old = new or 0.0, old or 0.0
    same_cur = new_cur == old_cur or new_cur is None or old_cur is None
    if raw_new == raw_old and same_cur:
        return None
    if same_cur:
        cmp_new, cmp_old = raw_new, raw_old
    else:
        cmp_new = raw_new * rates.get(new_cur, 0.0)
        cmp_old = raw_old * rates.get(old_cur, 0.0)
    change_type = ChangeType.PRICE_UP if cmp_new > cmp_old else ChangeType.PRICE_DOWN
    delta = _delta_pct(cmp_old, cmp_new)
    change = Change(code=item.code, change_type=change_type, goodsid=goodsid, price_field=field_no,
                    old_price=old, new_price=new, old_cur=old_cur, new_cur=new_cur, delta_pct=delta,
                    name=item.name, category=item.category)
    if same_cur and (round_price(raw_new) == round_price(raw_old)
                     or (delta is not None and abs(delta) < noise_pct)):
        change.decision, change.reason = Decision.IGNORE, "NOISE"
    return change


def _compare_fields(item: SupplierItem, goodsid: int | None, old: SupplierItem | GfRow, epp: bool,
                    noise_pct: float, rates: dict[int, float], rrp_discount: float = 0.0) -> list[Change]:
    out: list[Change] = []
    fields = [(PRICE_LIST, item.price7, item.cur7, old.price7, old.cur7)]
    if (item.price0 or 0) > 0:
        fields.append((PRICE_COST, item.price0, item.cur0, old.price0, old.cur0))
    if epp:
        fields.append((PRICE_RRP, adjust_rrp(item.price3, rrp_discount), item.cur3, old.price3, old.cur3))
    for field_no, new, new_cur, old_price, old_cur in fields:
        change = _price_change(item, goodsid, field_no, new, new_cur, old_price, old_cur, noise_pct, rates)
        if change:
            out.append(change)
    return out


def _returned(item: SupplierItem, row: GfRow) -> Change:
    change = Change(code=item.code, change_type=ChangeType.RETURNED, goodsid=row.goodsid,
                    price_field=PRICE_LIST if (item.price7 or 0) > 0 else PRICE_RRP,
                    old_price=row.price7, new_price=item.price7 if (item.price7 or 0) > 0 else item.price3,
                    old_cur=row.cur7, new_cur=item.cur7 if (item.price7 or 0) > 0 else item.cur3,
                    new_stock=item.stock, name=item.name, category=item.category)
    # regula din BuildRow: fara pret indicativ si fara RRP nu ramine baza pentru pretul de vinzare
    if (item.price7 or 0) == 0 and (item.price3 or 0) == 0:
        change.decision, change.reason = Decision.IGNORE, "NO_PRICE"
    return change


def _gone(code: str, row: GfRow | None, prev_codes: set[str] | None, gone_after_runs: int,
          name: str | None = None) -> Change:
    confirmed = gone_after_runs <= 1 or (prev_codes is not None and code not in prev_codes)
    return Change(code=code, change_type=ChangeType.GONE if confirmed else ChangeType.PENDING_GONE,
                  goodsid=row.goodsid if row else None,
                  old_price=row.price7 if row else None, old_cur=row.cur7 if row else None,
                  name=name if name is not None else (row.title if row else None),
                  decision=Decision.APPLY if confirmed else Decision.WAIT,
                  reason=None if confirmed else "FIRST_MISS")


def diff_against_gf(items: list[SupplierItem], gf_state: dict[str, list[GfRow]], *,
                    prev_codes: set[str] | None, exclusions: set[str], noise_pct: float,
                    gone_after_runs: int, rates: dict[int, float], rrp_discount: float = 0.0) -> DiffResult:
    """`rrp_discount` = TS_CUSTOMER.RRP_DISCOUNT: RRP-ul din pricelist se compara dupa reducerea pe care
    o aplica reevaluarea (altfel fiecare import arata "+1%..3%" la toate produsele pe RRP).
    0 = comparatia bruta a interogarilor WMS (folosita de verificarea de echivalenta)."""
    result = DiffResult(BASELINE_GF)
    seen: set[str] = set()
    for item in items:
        if item.code in exclusions:
            result.n_excluded += 1
            continue
        seen.add(item.code)
        rows = gf_state.get(item.code)
        if not rows:
            result.changes.append(Change(code=item.code, change_type=ChangeType.NEW, new_price=item.price7,
                                         new_cur=item.cur7, new_stock=item.stock, name=item.name,
                                         category=item.category, decision=Decision.IGNORE, reason="UNLINKED"))
            continue
        result.n_matched += 1
        if not any(r.in_price for r in rows):
            result.changes.extend(_returned(item, r) for r in rows)
            continue
        if any(r.goods_in_price for r in rows):
            result.n_matched_in_price += 1
        for row in rows:
            if not row.goods_in_price:
                continue
            result.changes.extend(_compare_fields(item, row.goodsid, row, row.epp, noise_pct, rates, rrp_discount))

    for code, rows in gf_state.items():
        if code in seen or code in exclusions:
            continue
        for row in rows:
            if row.in_price:
                result.changes.append(_gone(code, row, prev_codes, gone_after_runs))
    return result


def diff_against_prev(items: list[SupplierItem], prev_items: list[SupplierItem],
                      gf_state: dict[str, list[GfRow]], *, exclusions: set[str], noise_pct: float,
                      rates: dict[int, float]) -> DiffResult:
    result = DiffResult(BASELINE_PREV)
    prev = {p.code: p for p in prev_items}
    seen: set[str] = set()
    for item in items:
        if item.code in exclusions:
            result.n_excluded += 1
            continue
        seen.add(item.code)
        rows = gf_state.get(item.code) or []
        goodsid = rows[0].goodsid if rows else None
        if rows:
            result.n_matched += 1
            if any(r.goods_in_price for r in rows):
                result.n_matched_in_price += 1
        old = prev.get(item.code)
        if old is None:
            if rows:
                change = _returned(item, rows[0])
            else:
                change = Change(code=item.code, change_type=ChangeType.NEW, new_price=item.price7, new_cur=item.cur7,
                                new_stock=item.stock, name=item.name, category=item.category,
                                decision=Decision.IGNORE, reason="UNLINKED")
            result.changes.append(change)
            continue
        epp = any(r.epp for r in rows) or ((item.price7 or 0) == 0 and (item.price3 or 0) > 0)
        result.changes.extend(_compare_fields(item, goodsid, old, epp, noise_pct, rates))

    for code, old in prev.items():
        if code in seen or code in exclusions:
            continue
        rows = gf_state.get(code) or []
        # informativ: WMS a aplicat deja pricelistul, deci regula "lipsa de doua ori" nu mai conteaza
        change = _gone(code, rows[0] if rows else None, None, 1, name=old.name)
        change.category = old.category
        if not rows:
            change.decision, change.reason = Decision.IGNORE, "UNLINKED"
        result.changes.append(change)
    return result
