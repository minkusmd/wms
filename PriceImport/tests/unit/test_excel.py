import zipfile

import openpyxl
import pytest

from priceimport.excelparse import (ExcelError, check_safe, col_index, col_letter, detect_layout, parse_items,
                                    read_sheets, suggest_mapping)

CUR = {"MDL": 498, "USD": 840, "EUR": 976}


def xlsx(path, rows, sheet="Прайс", extra_sheets=()):
    wb = openpyxl.Workbook()
    ws = wb.active
    ws.title = sheet
    for row in rows:
        ws.append(row)
    for name, rws in extra_sheets:
        other = wb.create_sheet(name)
        for row in rws:
            other.append(row)
    wb.save(path)
    return path


def parse(path, spec=None):
    sheets = read_sheets(path)
    layout = detect_layout(sheets, spec or {})
    return layout, parse_items(sheets, layout, spec or {}, CUR)


def test_russian_pricelist_with_title_rows_and_group_rows(tmp_path):
    path = xlsx(tmp_path / "teocom.xlsx", [
        ["ООО Теоком - прайс-лист на 28.10.2026"], [],
        ["Артикул", "Наименование", "Цена дилер, $", "Розница, лей", "Наличие"],
        ["Ноутбуки"],
        ["NB-1", "Laptop ASUS 15", "1 234,50", 25999, "есть"],
        [10045, "Laptop Acer", 899.9, None, ">10"],
        ["Мониторы"],
        ["MN-1", "Monitor 27", "199,00", "3999", "нет"],
        ["MN-2", "Monitor 24", None, None, "+"],
        ["NB-1", "duplicat", 1, 1, "+"],
        ["MN-3", "Monitor 32", "abc", None, "+"],
    ])
    spec = {"currency": "MDL", "columns": {"price_cost": {"currency": "USD"}}}
    layout, r = parse(path, spec)
    assert layout.header_row == 2 and set(layout.columns) >= {"code", "name", "price_cost", "price_rrp", "stock"}
    assert [i.code for i in r.items] == ["NB-1", "10045"]
    nb = r.items[0]
    assert (nb.price0, nb.cur0, nb.price7, nb.cur7, nb.price3, nb.cur3) == (1234.5, 840, 1234.5, 840, 25999, 498)
    assert nb.category == "Ноутбуки" and nb.stock == "IN" and nb.row_no == 5
    assert r.n_out_of_stock == 1 and r.n_duplicates == 1 and r.n_skipped == 2     # fara stoc + fara pret
    assert [(e.error_class, e.row_no) for e in r.row_errors] == [("BAD_NUMBER", 11)]


def test_romanian_headers_currency_column_and_sheet_choice(tmp_path):
    path = xlsx(tmp_path / "pl.xlsx", [["nimic"]], sheet="Info", extra_sheets=[("Pricelist", [
        ["Cod produs", "Denumire", "Preț angro", "Valuta", "Stoc", "Brand"],
        ["A-1", "Aspirator", 100, "USD", 5, "Bosch"],
        ["A-2", "Fier de calcat", 50, "lei", 0, "Philips"],
        ["A-3", "Mixer", 20, "EUR", 3, "Tefal"],
    ])])
    layout, r = parse(path)
    assert layout.sheet == "Pricelist"
    assert [(i.code, i.price7, i.cur7, i.brand) for i in r.items] == [("A-1", 100, 840, "Bosch"), ("A-3", 20, 976, "Tefal")]
    assert r.n_out_of_stock == 1


def test_fixed_columns_from_yaml_and_wms16_template(tmp_path):
    path = xlsx(tmp_path / "x.xlsx", [["x", "y", "z"], ["Q1", "Nume", "15,5"], ["Q2", "Alt", "7"]])
    spec = {"columns": {"code": {"column": "A"}, "name": {"column": "B"}, "price_list": {"column": "C"}}}
    _, r = parse(path, spec)
    assert [(i.code, i.price7) for i in r.items] == [("Q1", 15.5), ("Q2", 7)]

    wms = xlsx(tmp_path / "wms.xlsx", [
        ["CPF", "Denumire", "Pret 0", "RRP", "Val vinz", "Pret 7", "Val 7", "Disp", "Gar", "Prod", "Model", "Categ"],
        ["W1", "Produs", 90, 1999, "MDL", 100, "USD", 4, 12, "LG", "M1", "TV"]])
    _, r = parse(wms, {"template": "wms16"})
    w = r.items[0]
    assert (w.code, w.price0, w.price7, w.cur7, w.price3, w.cur3, w.brand, w.category) == \
        ("W1", 90, 100, 840, 1999, 498, "LG", "TV")


def test_csv_cp1251_semicolon(tmp_path):
    path = tmp_path / "p.csv"
    path.write_bytes("Код;Название;Цена\nK1;Товар один;12,40\nK2;Товар два;5\n".encode("cp1251"))
    _, r = parse(path)
    assert [(i.code, i.name, i.price7) for i in r.items] == [("K1", "Товар один", 12.4), ("K2", "Товар два", 5)]


def test_no_header_and_unsafe_files(tmp_path):
    path = xlsx(tmp_path / "bad.xlsx", [["a", "b"], [1, 2]])
    with pytest.raises(ExcelError) as exc:
        parse(path)
    assert exc.value.error_class == "NO_HEADER"
    with pytest.raises(ExcelError):
        check_safe(tmp_path / "virus.exe")
    fake = tmp_path / "fake.xlsx"
    fake.write_bytes(b"not a zip")
    with pytest.raises(ExcelError):
        check_safe(fake)
    bomb = tmp_path / "bomb.xlsx"
    with zipfile.ZipFile(bomb, "w", compression=zipfile.ZIP_DEFLATED) as zf:
        zf.writestr("big.xml", b"0" * (210 * 1024 * 1024))
    with pytest.raises(ExcelError) as exc:
        check_safe(bomb)
    assert exc.value.error_class == "FILE_TOO_BIG"


def test_suggest_mapping_and_letters(tmp_path):
    path = xlsx(tmp_path / "s.xlsx", [["Cod", "Denumire", "Pret", "Stoc"], ["1", "x", 2, 3]])
    text = suggest_mapping(path)
    assert 'code: {column: "A"}' in text and 'price_list: {column: "C"}' in text and "semnatura" in text
    assert col_letter(0) == "A" and col_letter(27) == "AB" and col_index("AB") == 27
