"""Regulile BuildRow (Parsers/PriceListReevaluationUnit.pas) si planificarea documentelor, fara baza."""

from helpers import MDL, USD, gf, item

from priceimport.apply import KIND_DOWN, KIND_NEW, KIND_OLD, KIND_UP, build_row, plan_apply, plan_rollback
from priceimport.models import Change, ChangeType, Decision
from priceimport.repo import approval_key
from priceimport.thresholds import apply_approvals


def test_build_row_rules():
    row, _ = build_row(KIND_UP, 1, "A", 90, 0, None, 100, USD, False)
    assert (row.price7, row.cur7, row.cur0, row.cur3, row.flg_epp) == (100, USD, USD, MDL, False)
    # fara pret indicativ, cu RRP -> EPP, valuta 7 = valuta RRP-ului
    row, _ = build_row(KIND_UP, 1, "A", 0, 1500, MDL, 0, None, False)
    assert row.flg_epp and row.cur7 == MDL
    # EPP fara RRP -> iese de pe RRP
    row, _ = build_row(KIND_UP, 1, "A", 0, 0, None, 100, USD, True)
    assert not row.flg_epp and row.note == "iese de pe RRP"
    assert build_row(KIND_UP, 1, "A", 0, 0, None, 0, USD, False) == (None, "NO_PRICE")
    assert build_row(KIND_UP, 1, "A", 0, 0, None, 100, None, False) == (None, "NO_CURRENCY7")


def _row(code, goodsid, change_type, field=None, old=None, new=None, docid=None, decision="APPLY"):
    return {"SUPPLIER_GOODS_CODE": code, "GOODSID": goodsid, "CHANGE_TYPE": change_type, "PRICE_FIELD": field,
            "OLD_PRICE": old, "NEW_PRICE": new, "OLD_CURRENCYID": USD if field == 7 else None,
            "DECISION": decision, "APPLIED_DOCID": docid}


def test_plan_apply_kinds_and_sources():
    state = {"A": [gf("A", 1, p7=100)], "R": [gf("R", 2, p7=60, in_price=False)], "G": [gf("G", 3, p7=70)],
             "D": [gf("D", 4, p7=100)], "Q": [gf("Q", 5, p7=100)]}
    items = {"A": item("A", 110), "R": item("R", 80), "D": item("D", 90), "Q": item("Q", 300)}
    changes = [_row("A", 1, "PRICE_UP", 7), _row("A", 1, "PRICE_DOWN", 0), _row("R", 2, "RETURNED"),
               _row("G", 3, "GONE"), _row("D", 4, "PRICE_DOWN", 7), _row("Q", 5, "PRICE_UP", 7, decision="QUARANTINE"),
               _row("N", None, "NEW", decision="IGNORE")]
    rows, skipped = plan_apply(changes, items, state)
    kinds = {r.code: (r.kind, r.price7) for r in rows}
    assert kinds == {"A": (KIND_UP, 110), "R": (KIND_NEW, 80), "G": (KIND_OLD, 70), "D": (KIND_DOWN, 90)}
    assert skipped == {}


def test_plan_rollback_restores_old_values_and_skips_later_changes():
    state = {"A": [gf("A", 1, p7=110)], "R": [gf("R", 2, p7=80)], "G": [gf("G", 3, p7=70, in_price=False)],
             "L": [gf("L", 4, p7=50)]}
    changes = [_row("A", 1, "PRICE_UP", 7, old=100, new=110, docid=9), _row("R", 2, "RETURNED", docid=9),
               _row("G", 3, "GONE", docid=9), _row("L", 4, "PRICE_UP", 7, old=40, new=50, docid=9),
               _row("X", 5, "PRICE_UP", 7, old=1, new=2)]
    rows, skipped = plan_rollback(changes, state, later={("L", 4)})
    kinds = {r.code: (r.kind, r.price7) for r in rows}
    assert kinds == {"A": (KIND_DOWN, 100), "R": (KIND_OLD, 80), "G": (KIND_NEW, 70)}
    assert skipped == {("L", 4): "CHANGED_LATER"}


def test_approvals_release_item():
    changes = [Change("A", ChangeType.PRICE_UP, 1, 7, 100, 130, USD, USD, 30, decision=Decision.QUARANTINE,
                      reason="THRESHOLD_UP"),
               Change("A", ChangeType.PRICE_UP, 1, 0, 90, 120, USD, USD, 33, decision=Decision.QUARANTINE,
                      reason="ITEM_QUARANTINED"),
               Change("B", ChangeType.PRICE_UP, 2, 7, 100, 140, USD, USD, 40, decision=Decision.QUARANTINE,
                      reason="THRESHOLD_UP")]
    released = apply_approvals(changes, {approval_key("A", 1, 7, 130.004, USD)})
    assert released == 1
    assert [(c.code, c.decision.value) for c in changes] == [("A", "APPLY"), ("A", "APPLY"), ("B", "QUARANTINE")]
    assert apply_approvals(changes, set()) == 0
