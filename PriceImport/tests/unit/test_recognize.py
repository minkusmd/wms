from priceimport.recognize import FileSignals, caption_supplier, recognize


def signals(**over):
    base = dict(caption=None, sender_tg_id=111, forward_from=None, file_name="Price_28.10.xlsx", sheet_names=["Прайс"],
                header_signature="abc", codes=[f"C{i}" for i in range(100)])
    base.update(over)
    return FileSignals(**base)


def rule(supplier, kind, pattern, weight=1):
    return {"SUPPLIERID": supplier, "RULE_TYPE": kind, "PATTERN": pattern, "WEIGHT": weight}


def test_caption_variants():
    assert caption_supplier("pricelist #74852 de azi") == 74852
    assert caption_supplier("/f 198") == 198 and caption_supplier("furnizor 198") == 198
    assert caption_supplier("pret 15% reducere") is None and caption_supplier(None) is None


def test_explicit_caption_decides_only_for_configured():
    rec = recognize(signals(caption="#74852"), [], {}, {74852})
    assert rec.decided.supplier_id == 74852 and rec.method == "CAPTION"
    rec = recognize(signals(caption="#555"), [], {}, {74852})
    assert rec.decided is None and rec.explicit


def test_header_signature_and_sku_overlap_combine():
    rec = recognize(signals(), [rule(74852, "HEADER_SIG", "abc")], {74852: 70, 198: 5}, {74852, 198})
    assert rec.decided.supplier_id == 74852 and rec.decided.score > 0.9
    assert "HEADER_SIG" in rec.decided.methods and any(m.startswith("SKU") for m in rec.decided.methods)


def test_ambiguous_is_not_decided():
    # doi furnizori cu acelasi antet si coduri comune -> intrebare
    rules = [rule(1, "HEADER_SIG", "abc"), rule(2, "HEADER_SIG", "abc")]
    rec = recognize(signals(), rules, {1: 90, 2: 85}, {1, 2})
    assert rec.decided is None and [c.supplier_id for c in rec.candidates][:2] == [1, 2]


def test_weak_signals_ask_and_unconfigured_never_auto():
    rec = recognize(signals(), [rule(3, "FILENAME_RE", r"^price_")], {}, {3})
    assert rec.decided is None and rec.candidates[0].score == 0.4
    rec = recognize(signals(), [], {9: 100}, {3})                 # coduri 100% la un furnizor neconfigurat
    assert rec.decided is None and rec.candidates[0].supplier_id == 9
    assert recognize(signals(), [rule(3, "FILENAME_RE", "([")], {}, {3}).candidates == []   # regex invalid
