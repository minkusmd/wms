"""Potrivirea pe cazurile reale gasite in SW (28.10.2026)."""

from priceimport.matching import CatalogIndex, fuzzy_tokens, mpn_tokens
from priceimport.models import SupplierItem

GOODS = [  # (GOODSID, TITLE, CODE, VENDOR_ID)
    (382831, "Anvelopa Nokian 205/60 R 16 SNOWPROOF 2 96H XL", "205/60 R 16 SNOWPROOF 2", 7008),
    (105414, "245/40 R 18 Pilot Super Sport 97Y ZR XL Michelin", None, 7100),
    (299430, "Despicator de lemne HECHT676", "HECHT676", 7200),
    (222420, "Puzzle Castorland 100 elemente B-111152", None, 7300),
    (395171, "Сковорода  C3840233 XL Intense 20cm", "C3840233", 7400),
    (187112, "56268 Cerc cu minere ANVELOPA d114 cm,  9+", None, None),
    (9893, "COOLER TITAN TTC-HDC2 - два вентилятора,  воздушный фильтр", None, None),
    (500, "Ремонт генератора", None, None),
    (600, "Laptop ACER 15.6 Travel Mate TMP215-53 Black", "TMP215-53", 7500),
    (235311, "Anvelopa Nokian 235/55 R 19 Hakka Black 2 SUV 105W XL", None, 7008),
]
VENDORS = {7008: "Nokian", 7100: "Michelin", 7200: "Hecht", 7300: "Castorland", 7400: "Tefal", 7500: "Acer"}
FOREIGN = [  # (GOODSID, CUSTOMERID, GOODS_CODE, BARCODE)
    (299430, 9001, "HECHT676", None), (222420, 9002, "B111152", None), (600, 198, "NX.VVREU.00E", "4710886123456"),
    (382831, 14805, "НШЛ-OLD", None),
]


def index():
    return CatalogIndex.from_rows(GOODS, VENDORS, FOREIGN)


def best(item, supplier=14805):
    props = index().match(supplier, item)
    return (props[0].goodsid, props[0].method) if props else None


def test_tokens():
    assert "C3840233" in mpn_tokens("Frypan Tefal C3840233")
    assert mpn_tokens("Selfie Stick 114cm, 2000W, 80W-90, R16") == set()      # masuri, nu coduri
    assert fuzzy_tokens("Шина 215/65R16 ЗИМА") == ["215", "65", "16"]      # literele singure nu conteaza


def test_code_at_other_supplier_needs_related_name():
    assert best(SupplierItem("HECHT676", "Despicator de lemne electric HECHT676")) == (299430, "CODE")
    # acelasi cod, alt produs (placute de frina vs puzzle) -> nimic
    assert best(SupplierItem("B111152", "К-т тормозных колодок")) is None


def test_mpn_in_catalog_title():
    assert best(SupplierItem("221588", "Frypan Tefal C3840233"), supplier=202294) == (395171, "MPN")
    assert best(SupplierItem("275042", "Insta360 114cm Invisible Selfie Stick")) is None


def test_fuzzy_tyres_ru_to_ro_and_model_generation():
    assert best(SupplierItem("НШЛ-114", "Шина 205/60 R16 (Snowproof 2) Nokian ЗИМА"), supplier=1) == (382831, "FUZZY")
    # Pilot Sport 5 nu e Pilot Super Sport (numarul generatiei lipseste in catalog)
    assert best(SupplierItem("МШЛ-822", "Шина 245/40 R18 (Pilot Sport 5) Michelin")) is None
    # alt model din aceeasi gama (0.75 pe SW): sub MIN_SCORE
    assert best(SupplierItem("НШЛ-166", "Шина 235/55 R19 (Snowproof 2 SUV) Nokian")) is None


def test_generic_and_one_word_names_are_not_matched():
    assert best(SupplierItem("A140019", "Фильтр воздушный")) is None
    assert best(SupplierItem("X1", "Ремень генератора")) is None


def test_ean_brand_conflict_and_already_linked():
    props = index().match(14805, SupplierItem("Q", "Laptop Acer", ean="4710886123456"))
    assert props[0].goodsid == 600 and props[0].method == "EAN" and props[0].score >= 0.97
    conflict = index().match(14805, SupplierItem("Q", "Laptop Lenovo", brand="Lenovo", ean="4710886123456"))
    assert conflict == []                                                  # 0.97 * 0.6 < MIN_SCORE
    # produsul deja legat la acest furnizor nu se propune din nou
    assert best(SupplierItem("НШЛ-114", "Шина 205/60 R16 (Snowproof 2) Nokian ЗИМА"), supplier=14805) is None
