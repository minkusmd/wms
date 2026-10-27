from helpers import MDL, RATES, USD, gf, item

from priceimport.diff import adjust_rrp, diff_against_gf, diff_against_prev
from priceimport.models import ChangeType, Decision


def _diff(items, state, prev_codes=None, gone_after_runs=2, exclusions=()):
    return diff_against_gf(items, state, prev_codes=prev_codes, exclusions=set(exclusions), noise_pct=0.5,
                           gone_after_runs=gone_after_runs, rates=RATES)


def by_type(result, change_type):
    return [c for c in result.changes if c.change_type == change_type]


def test_new_unlinked_is_reported_not_applied():
    r = _diff([item("X1", category="TV")], {})
    [c] = r.changes
    assert c.change_type == ChangeType.NEW and c.decision == Decision.IGNORE and c.category == "TV"


def test_returned_when_no_row_in_price():
    r = _diff([item("A", 110)], {"A": [gf("A", 1, 100, in_price=False)]})
    [c] = r.changes
    assert c.change_type == ChangeType.RETURNED and c.goodsid == 1 and c.decision == Decision.APPLY


def test_returned_without_any_price_is_ignored():
    r = _diff([item("A", p7=0, p3=0)], {"A": [gf("A", 1, in_price=False)]})
    assert r.changes[0].decision == Decision.IGNORE and r.changes[0].reason == "NO_PRICE"


def test_price_up_down_per_field():
    state = {"A": [gf("A", 1, p7=100, p0=90)], "B": [gf("B", 2, p7=100)]}
    r = _diff([item("A", p7=110, p0=80), item("B", p7=95)], state)
    ups, downs = by_type(r, ChangeType.PRICE_UP), by_type(r, ChangeType.PRICE_DOWN)
    assert [(c.code, c.price_field) for c in ups] == [("A", 7)]
    assert sorted((c.code, c.price_field) for c in downs) == [("A", 0), ("B", 7)]
    assert round(ups[0].delta_pct, 2) == 10.0


def test_price0_zero_in_pricelist_is_not_compared():
    r = _diff([item("A", p7=100, p0=0)], {"A": [gf("A", 1, p7=100, p0=90)]})
    assert r.changes == []


def test_rrp_compared_only_for_epp():
    state = {"A": [gf("A", 1, p7=100, p3=1500, epp=True)], "B": [gf("B", 2, p7=100, p3=1500)]}
    r = _diff([item("A", p7=100, p3=1600), item("B", p7=100, p3=1600)], state)
    assert [(c.code, c.price_field) for c in r.changes] == [("A", 3)]


def test_goods_not_in_price_skips_price_changes():
    r = _diff([item("A", 120)], {"A": [gf("A", 1, 100, goods_in_price=False)]})
    assert r.changes == []


def test_noise_from_rounding_is_ignored():
    r = _diff([item("A", p7=100.0049)], {"A": [gf("A", 1, p7=100.0)]})
    [c] = r.changes
    assert c.decision == Decision.IGNORE and c.reason == "NOISE"


def test_gone_needs_two_misses():
    state = {"A": [gf("A", 1)], "B": [gf("B", 2)]}
    r = _diff([], state, prev_codes={"A"})          # A era in pricelistul precedent, B nu
    types = {c.code: (c.change_type, c.decision) for c in r.changes}
    assert types["A"] == (ChangeType.PENDING_GONE, Decision.WAIT)
    assert types["B"] == (ChangeType.GONE, Decision.APPLY)


def test_gone_without_previous_snapshot_waits_and_rows_out_of_price_are_skipped():
    state = {"A": [gf("A", 1)], "C": [gf("C", 3, in_price=False)]}
    r = _diff([], state, prev_codes=None)
    assert [(c.code, c.change_type) for c in r.changes] == [("A", ChangeType.PENDING_GONE)]


def test_exclusions():
    r = _diff([item("A", 200)], {"A": [gf("A", 1, 100)]}, exclusions={"A"})
    assert r.changes == [] and r.n_excluded == 1


def test_currency_change_compared_in_mdl():
    r = _diff([item("A", p7=1823, cur=MDL)], {"A": [gf("A", 1, p7=100, cur=USD)]})
    [c] = r.changes
    assert c.change_type == ChangeType.PRICE_DOWN and abs(c.delta_pct) < 0.01


def test_diff_against_prev():
    prev = [item("A", 100), item("B", 100), item("G", 100)]
    state = {"A": [gf("A", 1)], "G": [gf("G", 7)]}
    r = diff_against_prev([item("A", 120), item("B", 100), item("N", 50)], prev, state, exclusions=set(),
                          noise_pct=0.5, rates=RATES)
    kinds = sorted((c.code, c.change_type.value) for c in r.changes)
    assert kinds == [("A", "PRICE_UP"), ("G", "GONE"), ("N", "NEW")]


def test_adjust_rrp_matches_firebird_formula():
    # ceil(round(price3 - abs(price3 / 100 * pct))): 499 la 1% -> 494.01 -> 494; 1575 -> 1559.25 -> 1559
    assert adjust_rrp(499, 1) == 494 and adjust_rrp(1575, 1) == 1559
    assert adjust_rrp(100.5, 0) == 100.5 and adjust_rrp(None, 2) is None
    assert adjust_rrp(1000, 2.5) == 975


def test_rrp_discount_removes_false_increase():
    state = {"A": [gf("A", 1, p7=0, p3=1559, epp=True)]}
    items = [item("A", p7=0, p3=1575)]
    raw = diff_against_gf(items, state, prev_codes=set(), exclusions=set(), noise_pct=0, gone_after_runs=2,
                          rates=RATES)
    assert [c.change_type for c in raw.changes] == [ChangeType.PRICE_UP]
    adjusted = diff_against_gf(items, state, prev_codes=set(), exclusions=set(), noise_pct=0, gone_after_runs=2,
                               rates=RATES, rrp_discount=1)
    assert adjusted.changes == []
