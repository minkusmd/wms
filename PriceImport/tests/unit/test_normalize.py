import pytest

from priceimport.normalize import (NormalizeError, currency_iso, ean_valid, normalize_code, normalize_ean,
                                   normalize_stock, parse_number, round_price, stock_is_out)


@pytest.mark.parametrize("raw, expected", [
    ("1 234,50", 1234.5), ("1.234,50", 1234.5), ("1,234.50", 1234.5), ("12,5", 12.5), ("12.5", 12.5),
    ("$12.5", 12.5), ("12,5 lei", 12.5), ("1 299", 1299.0), ("1.234.567", 1234567.0),
    ("1,234,567", 1234567.0), (15, 15.0), (15.75, 15.75), ("-3,5", -3.5), ("", None), (None, None), ("-", None),
])
def test_parse_number(raw, expected):
    assert parse_number(raw) == expected


@pytest.mark.parametrize("raw", ["abc", "lei", True])
def test_parse_number_invalid(raw):
    with pytest.raises(NormalizeError):
        parse_number(raw)


def test_normalize_code():
    assert normalize_code("  AB-12 \t") == "AB-12"
    assert normalize_code(12345.0) == "12345"
    assert normalize_code("Код\x0712") == "Код 12"
    for bad in ("", "   ", "---", "x" * 129):
        with pytest.raises(NormalizeError):
            normalize_code(bad)


def test_ean():
    assert ean_valid("4006381333931")
    assert not ean_valid("4006381333932")
    assert normalize_ean(4006381333931.0) == "4006381333931"
    assert normalize_ean("abc") is None


def test_stock_and_currency():
    assert normalize_stock("есть") == "IN"
    assert normalize_stock(">10") == ">10"
    assert normalize_stock(3.0) == "3"
    assert stock_is_out("0") and stock_is_out("OUT") and not stock_is_out(">10")
    assert currency_iso("lei") == "MDL" and currency_iso("€") == "EUR" and currency_iso("?") is None


def test_round_price():
    assert round_price(12.3449) == 12.34
    assert round_price(None) is None
