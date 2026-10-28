"""HANSA / Numina PDF price list -> .xlsx for the WMS price list import (frame 78,
frmPricelistImportUnit: 16 fixed columns, row 0 = header).

Layout of the PDF (A4, pt): image + model label x<128, specs 128..335 (key | value at ~246),
artikul 335..400, index/COD 400..454, status 454..493, price >=493. Products are separated by
full-width horizontal rules; category headers are rows containing FUNCTIONS / COMPATIBILITATI.

Text is read run by run (content-stream order) so that a key or value clipped by its cell
(e.g. "Programs ..., Eco, Glass, 60 min" running into the artikul column) stays in one piece.
"""
import re
import sys

import openpyxl
import pdfplumber
from openpyxl.styles import Alignment, Font

X_IMG, X_VALUE, X_ART, X_IDX, X_STATUS, X_PRICE = 128, 244, 335, 400, 454, 493

HEADER_WORDS = ("FUNCTIONS", "COMPATIBILIT", "PREȚ (lei)", "PRET (lei)", "Круп.Опт")

# Category header (as printed) -> product type for the name
TYPE_BY_CATEGORY = {
    "CUPTOARE": "Cuptor incorporabil",
    "ARAGAZ FREE STANDING": "Aragaz",
    "PLITE": "Plita incorporabila",
    "HOTE": "Hota",
    "FILTRE PENTRU HOTA": "Filtru pentru hota",
    "MICROUNDE": "Cuptor cu microunde",
    "DULAPURI PENTRU VIN": "Dulap pentru vin",
    "MASINA DE SPALAT VASE": "Masina de spalat vase",
    "MASINA DE USCAT RUFE": "Masina de uscat rufe",
    "MASINA DE SPĂLAT RUFE": "Masina de spalat rufe",
    "FRIGIDERE": "Frigider",
}

COLUMNS = ["CPF", "Denumire produs", "Pret 0", "Pret Vinz.", "Val. Vinz.", "Pret 7", "Val. 7",
           "Disp", "Garantie", "Producator", "Model", "Categorie", "Product link",
           "Caracteristici / descriere", "COMPATIBILITATE", "TVA"]
INFO_COLUMNS = ["COD furnizor (индекс)", "Stare in PDF", "Pagina PDF"]


def norm(s):
    return re.sub(r"\s+", " ", s or "").strip()


def runs_of(chars):
    """Split chars (content-stream order) into runs of adjacent glyphs on one baseline."""
    runs, cur = [], None
    for c in chars:
        if c["text"] in ("\n", "\r"):
            continue
        if cur and abs(c["top"] - cur["top"]) < 2.0 and -1.5 < c["x0"] - cur["x1"] < 1.5:
            cur["text"] += c["text"]
            cur["x1"] = c["x1"]
        else:
            cur = {"x0": c["x0"], "x1": c["x1"], "top": c["top"], "text": c["text"]}
            runs.append(cur)
    return [r for r in runs if r["text"].strip()]


def column(x0):
    if x0 < X_IMG:
        return "img"
    if x0 < X_VALUE:
        return "key"
    if x0 < X_ART:
        return "value"
    if x0 < X_IDX:
        return "art"
    if x0 < X_STATUS:
        return "idx"
    if x0 < X_PRICE:
        return "status"
    return "price"


def lines_of(runs):
    lines = []
    for r in sorted(runs, key=lambda r: (r["top"], r["x0"])):
        if lines and abs(lines[-1][0] - r["top"]) < 2.0:
            lines[-1][1].append(r)
        else:
            lines.append([r["top"], [r]])
    return lines


def parse(pdf_path):
    products, category = [], ""
    with pdfplumber.open(pdf_path) as pdf:
        for pn, page in enumerate(pdf.pages, 1):
            objs = page.lines + page.rects
            hy = sorted(set(round(o["top"], 1) for o in objs if (o["x1"] - o["x0"]) > 500))
            hy = [y for y in hy if y >= 118]
            bounds = []
            for y in hy:
                if not bounds or y - bounds[-1] >= 4:
                    bounds.append(y)
            for a, b in zip(bounds, bounds[1:] + [page.height]):
                chars = [c for c in page.chars if a - 1.5 <= c["top"] < b - 1.5]
                block = {"page": pn, "img": [], "spec": [], "art": [], "idx": [], "status": [], "price": []}
                for top, line in lines_of(runs_of(chars)):
                    text = " ".join(r["text"] for r in line)
                    if any(w in text for w in HEADER_WORDS):
                        cat = norm(" ".join(r["text"] for r in line if column(r["x0"]) == "img"))
                        if cat:
                            category = cat
                        continue
                    key = norm(" ".join(r["text"] for r in line if column(r["x0"]) == "key"))
                    val = norm(" ".join(r["text"] for r in line if column(r["x0"]) == "value"))
                    if key or val:
                        block["spec"].append((key, val))
                    for col in ("img", "art", "idx", "status", "price"):
                        t = norm(" ".join(r["text"] for r in line if column(r["x0"]) == col))
                        if t:
                            block[col].append(t)
                if not block["art"] and not block["idx"]:
                    continue  # header-only band, footer note, empty space
                products.append(make_product(block, category))
    return products


def make_product(block, category):
    art_parts = [t for t in block["art"] if t.upper() != "NEW"]
    is_new = any(t.upper() == "NEW" for t in block["art"])
    art = norm(" ".join(art_parts))
    idx = norm(" ".join(block["idx"]))
    price_text = " ".join(block["price"])
    # "7650.00", "3 599", "4 500" (thousands separated by a space, decimals optional)
    m = re.search(r"\b\d{1,3}(?:[  ]\d{3})+(?:[.,]\d{2})?\b|\b\d+(?:[.,]\d{2})?\b", price_text)
    price = float(re.sub(r"[  ]", "", m.group(0)).replace(",", ".")) if m else None
    flags = []
    if re.search(r"STOC\s+LIMITAT", price_text, re.I):
        flags.append("STOC LIMITAT")
    if re.search(r"la\s+comand", price_text, re.I):
        flags.append("la comanda")
    if "verificati" in price_text.lower():
        flags.append("pret: verificati la operator")
    status = norm(" ".join(block["status"]))
    if status:
        flags.append({"на вывод": "scos din productie (на вывод)"}.get(status, status))
    if is_new:
        flags.append("NEW")

    # model label printed under the image (last img line); "полки 2/3" badges are skipped
    labels = [t for t in block["img"] if not re.match(r"^(полки\s*\d*|\d+)$", t, re.I)]
    model = labels[-1] if labels else art

    specs, notes, compat = [], [], []
    is_filter = category.upper().startswith("FILTRE")
    for key, val in block["spec"]:
        if is_filter:
            compat.append(norm(f"{key} {val}"))
        elif key and val:
            specs.append([key, val])
        elif key:
            notes.append(key)
        elif specs:
            specs[-1][1] = norm(specs[-1][1] + " " + val)  # value wrapped onto its own line
        else:
            notes.append(val)
    # notes = keys printed without a value (empty in the PDF) or "new" / "Новинка 2026г" marks
    if any(n.lower() == "new" or n.lower().startswith("новинка") for n in notes) and "NEW" not in flags:
        flags.append("NEW")
    description = "\n".join(f"{k}: {v}" for k, v in specs)
    compat_text = norm(" ".join(compat)).replace(" ;", ";")
    if is_filter and compat_text:
        description = f"Compatibil cu hotele Hansa: {compat_text}"

    ptype = TYPE_BY_CATEGORY.get(category.upper(), category.capitalize())
    return {
        "cpf": art or idx, "name": norm(f"{ptype} Hansa {model}"), "price": price,
        "model": model, "category": category, "description": description,
        "compat": compat_text, "idx": idx, "flags": "; ".join(flags), "page": block["page"],
    }


def write_xlsx(products, out_path):
    wb = openpyxl.Workbook()
    ws = wb.active
    ws.title = "Import"
    ws.append(COLUMNS + INFO_COLUMNS)
    skipped = []
    for p in products:
        if p["price"] is None:
            skipped.append(p)
            continue
        ws.append([p["cpf"], p["name"], p["price"], 0, "MDL", p["price"], "MDL", "", 0, "Hansa",
                   p["model"], p["category"], "", p["description"], p["compat"], 20,
                   p["idx"], p["flags"], p["page"]])
    ws2 = wb.create_sheet("Fara pret")
    ws2.append(["CPF", "Denumire produs", "Model", "Categorie", "COD furnizor (индекс)", "Stare in PDF",
                "Pagina PDF", "Caracteristici / descriere", "COMPATIBILITATE"])
    for p in skipped:
        ws2.append([p["cpf"], p["name"], p["model"], p["category"], p["idx"], p["flags"], p["page"],
                    p["description"], p["compat"]])

    for sheet in (ws, ws2):
        for cell in sheet[1]:
            cell.font = Font(bold=True)
        for row in sheet.iter_rows(min_row=2):
            for cell in row:
                if cell.value is None or cell.value == "":
                    # cell must exist in the WMS grid, otherwise the import reuses the previous row
                    cell.value = ""
                    cell.number_format = "@"
                cell.alignment = Alignment(vertical="top", wrap_text=isinstance(cell.value, str) and "\n" in cell.value)
        sheet.freeze_panes = "A2"
    widths = {"A": 16, "B": 42, "C": 10, "F": 10, "J": 10, "K": 16, "L": 22, "N": 60, "O": 40, "P": 6,
              "Q": 12, "R": 30, "S": 8}
    for col, w in widths.items():
        ws.column_dimensions[col].width = w
    ws2.column_dimensions["B"].width = 42
    ws2.column_dimensions["H"].width = 60
    wb.active = 0
    wb.save(out_path)
    return len(products) - len(skipped), skipped


if __name__ == "__main__":
    prods = parse(sys.argv[1])
    n, skipped = write_xlsx(prods, sys.argv[2])
    print(f"products={len(prods)} import={n} fara_pret={len(skipped)}")
