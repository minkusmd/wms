from helpers import MDL, RATES, USD, gf, item, supplier

from priceimport.diff import diff_against_gf
from priceimport.models import ChangeType, Decision, FetchResult, RowError
from priceimport.repo import ThresholdRule
from priceimport.thresholds import apply_thresholds, resolve_limits, run_guards


def _run(items, state, rules=(), groups=None, cfg=None):
    cfg = cfg or supplier()
    r = diff_against_gf(items, state, prev_codes=set(), exclusions=set(), noise_pct=0.5, gone_after_runs=2,
                        rates=RATES)
    apply_thresholds(r.changes, cfg, list(rules), groups or {}, RATES)
    return r


def test_threshold_up_and_item_level_quarantine():
    r = _run([item("A", p7=130, p0=95)], {"A": [gf("A", 1, p7=100, p0=90)]})
    reasons = {c.price_field: (c.decision, c.reason) for c in r.changes}
    assert reasons[7] == (Decision.QUARANTINE, "THRESHOLD_UP")
    assert reasons[0] == (Decision.QUARANTINE, "ITEM_QUARANTINED")


def test_within_threshold_applies():
    r = _run([item("A", p7=115)], {"A": [gf("A", 1, p7=100)]})
    assert r.changes[0].decision == Decision.APPLY


def test_zero_and_negative_prices():
    r = _run([item("A", p7=0, p3=500), item("B", p7=-5)], {"A": [gf("A", 1)], "B": [gf("B", 2)]})
    reasons = {c.code: c.reason for c in r.changes}
    assert reasons == {"A": "ZERO_PRICE", "B": "NEGATIVE_PRICE"}


def test_lei_saved_as_usd_is_currency_mismatch():
    r = _run([item("A", p7=1823.0, cur=USD)], {"A": [gf("A", 1, p7=100, cur=USD)]})
    assert r.changes[0].reason == "CURRENCY_MISMATCH"


def test_currency_changed():
    r = _run([item("A", p7=1900, cur=MDL)], {"A": [gf("A", 1, p7=100, cur=USD)]})
    assert r.changes[0].reason == "CURRENCY_CHANGED"


def test_specific_rule_wins_and_absurd_price():
    rules = [ThresholdRule(None, None, None, 50, 50, None, None),
             ThresholdRule(198, 33, None, 5, 5, None, 5000)]
    cfg = supplier()
    assert resolve_limits(cfg, rules, (33, 900)).max_up_pct == 5
    assert resolve_limits(cfg, rules, (34, 900)).max_up_pct == 50
    assert resolve_limits(cfg, [], None).max_up_pct == 20
    r = _run([item("A", p7=110), item("B", p7=6000)], {"A": [gf("A", 1, p7=100)], "B": [gf("B", 2, p7=5900)]},
             rules=rules, groups={1: (33, 900), 2: (33, 900)})
    reasons = {c.code: c.reason for c in r.changes}
    assert reasons == {"A": "THRESHOLD_UP", "B": "ABSURD_PRICE_HIGH"}


def test_returned_is_not_compared_with_stale_price():
    r = _run([item("A", p7=300)], {"A": [gf("A", 1, p7=100, in_price=False)]})
    assert r.changes[0].change_type == ChangeType.RETURNED and r.changes[0].decision == Decision.APPLY


def test_run_guards_volume_invalid_duplicates():
    fetch = FetchResult(items=[item(str(i)) for i in range(50)], n_fetched=100, n_duplicates=10,
                        row_errors=[RowError("BAD_NUMBER", "x")] * 20)
    codes = {code for code, _ in run_guards(fetch, 100, [], 0, supplier())}
    assert codes == {"VOLUME", "INVALID_ROWS", "DUPLICATES"}
    relaxed = run_guards(fetch, 60, [], 0, supplier(), {"max_invalid_share": 0.5, "max_duplicate_share": 0.5})
    assert relaxed == []


def test_run_guard_mass_shift():
    items = [item(f"C{i}", p7=118.0) for i in range(60)]
    state = {f"C{i}": [gf(f"C{i}", i, p7=100.0)] for i in range(60)}
    r = _run(items, state, cfg=supplier(max_up_pct=50))
    problems = run_guards(FetchResult(items=items, n_fetched=60), 60, r.changes, r.n_matched_in_price, supplier())
    assert [code for code, _ in problems] == ["MASS_SHIFT"]


def test_run_guard_empty():
    assert [c for c, _ in run_guards(FetchResult(items=[]), None, [], 0, supplier())] == ["EMPTY"]
