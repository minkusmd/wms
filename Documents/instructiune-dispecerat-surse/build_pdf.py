# Instructiunea de lucru "Dispecerat: achizitii, livrari si retururi" (WMS + aplicatia Curieri) -> PDF.
import math
import os
import sys

from PIL import Image as PILImage
from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER, TA_LEFT
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.units import cm
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import (BaseDocTemplate, CondPageBreak, Flowable, Frame, Image, KeepTogether, NextPageTemplate,
                                PageBreak, PageTemplate, Paragraph, Spacer, Table, TableStyle)
from reportlab.platypus.tableofcontents import TableOfContents

HERE = os.path.dirname(os.path.abspath(__file__))
SH = os.path.join(HERE, "shots")
ANN = os.path.join(SH, "ann")
CROP = os.path.join(SH, "crop")
os.makedirs(CROP, exist_ok=True)
OUT = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, "instructiune.pdf")

FD = r"C:\Windows\Fonts"
pdfmetrics.registerFont(TTFont("UI", os.path.join(FD, "segoeui.ttf")))
pdfmetrics.registerFont(TTFont("UI-B", os.path.join(FD, "segoeuib.ttf")))
pdfmetrics.registerFont(TTFont("UI-I", os.path.join(FD, "segoeuii.ttf")))
pdfmetrics.registerFont(TTFont("UI-BI", os.path.join(FD, "segoeuiz.ttf")))
pdfmetrics.registerFont(TTFont("UI-SB", os.path.join(FD, "seguisb.ttf")))
pdfmetrics.registerFontFamily("UI", normal="UI", bold="UI-B", italic="UI-I", boldItalic="UI-BI")

BLUE = colors.HexColor("#1d4ed8")
DARK = colors.HexColor("#0f172a")
GREY = colors.HexColor("#475569")
LIGHT = colors.HexColor("#f1f5f9")
LINE = colors.HexColor("#cbd5e1")
AMBER_BG = colors.HexColor("#fffbeb")
AMBER = colors.HexColor("#b45309")
RED_BG = colors.HexColor("#fef2f2")
RED = colors.HexColor("#b91c1c")
GREEN_BG = colors.HexColor("#f0fdf4")
GREEN = colors.HexColor("#15803d")

PAGE_W, PAGE_H = A4
M = 1.8 * cm
W = PAGE_W - 2 * M

S = {
    "body": ParagraphStyle("body", fontName="UI", fontSize=9.6, leading=13.6, textColor=DARK, spaceAfter=5),
    "small": ParagraphStyle("small", fontName="UI", fontSize=8.4, leading=11.4, textColor=GREY),
    "cap": ParagraphStyle("cap", fontName="UI-I", fontSize=8.2, leading=10.5, textColor=GREY, alignment=TA_CENTER,
                          spaceBefore=3, spaceAfter=9),
    "h1": ParagraphStyle("h1", fontName="UI-B", fontSize=18, leading=23, textColor=BLUE, spaceBefore=4, spaceAfter=8),
    "h2": ParagraphStyle("h2", fontName="UI-B", fontSize=13, leading=17, textColor=DARK, spaceBefore=12, spaceAfter=5),
    "h3": ParagraphStyle("h3", fontName="UI-SB", fontSize=10.6, leading=14, textColor=BLUE, spaceBefore=8,
                         spaceAfter=3),
    "step": ParagraphStyle("step", fontName="UI", fontSize=9.6, leading=13.4, textColor=DARK, leftIndent=17,
                           firstLineIndent=-17, spaceAfter=4),
    "bullet": ParagraphStyle("bullet", fontName="UI", fontSize=9.6, leading=13.4, textColor=DARK, leftIndent=12,
                             firstLineIndent=-9, spaceAfter=2.5),
    "cell": ParagraphStyle("cell", fontName="UI", fontSize=8.6, leading=11.2, textColor=DARK),
    "cellb": ParagraphStyle("cellb", fontName="UI-B", fontSize=8.6, leading=11.2, textColor=DARK),
    "cellh": ParagraphStyle("cellh", fontName="UI-B", fontSize=8.6, leading=11.2, textColor=colors.white),
    "toc1": ParagraphStyle("toc1", fontName="UI-SB", fontSize=10.5, leading=16, leftIndent=0),
    "toc2": ParagraphStyle("toc2", fontName="UI", fontSize=9.4, leading=13.2, leftIndent=16, textColor=GREY),
}

story = []
FIG = [0]


# ---------- ajutoare ----------
def P(t, st="body"):
    return Paragraph(t, S[st])


class Heading(Paragraph):
    def __init__(self, text, level):
        super().__init__(text, S["h1" if level == 0 else "h2"])
        self.toc_level = level


def H1(t):
    story.append(Heading(t, 0))


def H2(t):
    story.append(CondPageBreak(7 * cm))
    story.append(Heading(t, 1))


def H3(t):
    story.append(CondPageBreak(3 * cm))
    story.append(P(t, "h3"))


def para(t):
    story.append(P(t))


def steps(items, start=1):
    out = []
    for i, t in enumerate(items, start):
        out.append(P(f'<font name="UI-B" color="#1d4ed8">{i}.</font>&nbsp;&nbsp;{t}', "step"))
    return out


def bullets(items):
    return [P(f'<font color="#1d4ed8">•</font>&nbsp;&nbsp;{t}', "bullet") for t in items]


def ui(t):
    """caption de buton / camp, exact ca in program"""
    return f'<font name="UI-SB" color="#1e3a8a">„{t}”</font>'


def num(n):
    return f'<font name="UI-B" color="#dc2626">({n})</font>'


def box(kind, title, body_flow):
    bg, fg = {"warn": (AMBER_BG, AMBER), "stop": (RED_BG, RED), "ok": (GREEN_BG, GREEN), "info": (LIGHT, BLUE)}[kind]
    inner = [P(f'<font name="UI-B" color="{fg.hexval()}">{title}</font>', "body")]
    inner += body_flow if isinstance(body_flow, list) else [P(body_flow)]
    t = Table([[inner]], colWidths=[W])
    t.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, -1), bg), ("LINEBEFORE", (0, 0), (0, -1), 3, fg),
        ("LEFTPADDING", (0, 0), (-1, -1), 10), ("RIGHTPADDING", (0, 0), (-1, -1), 10),
        ("TOPPADDING", (0, 0), (-1, -1), 6), ("BOTTOMPADDING", (0, 0), (-1, -1), 4)]))
    story.append(Spacer(1, 3))
    story.append(t)
    story.append(Spacer(1, 7))


def img_path(name):
    a = os.path.join(ANN, name)
    return a if os.path.exists(a) else os.path.join(SH, name)


CUTS = {
    "w0_disp_tsPickups.png": (275, 420), "w2_disp_tsPickups.png": (275, 420), "w1_disp_tsReturns.png": (275, 420),
    "w2_disp_tsDeliveries.png": (275, 420), "w1_disp_tsPickups.png": (310, 420), "w3_disp_tsPickups.png": (310, 420),
    "w1_disp_tsRoutes.png": (295, 420), "w3_disp_tsRoutes.png": (295, 420), "w2_disp_tsProblems.png": (255, 465),
    "w0_disp_ridicari_lista.png": (265, 548), "w3_disp_ridicari_lista.png": (265, 548), "w_curieri.png": (190, 498),
    "w_zone.png": (170, 420), "w_reguli_intermediar.png": (150, 420),
}


def figure(name, caption, width=W, crop=None):
    path = img_path(name)
    im = PILImage.open(path)
    if name in CUTS:
        y1, y2 = CUTS[name]
        w0, h0 = im.size
        gap = 14
        new = PILImage.new("RGB", (w0, y1 + gap + h0 - y2), (255, 255, 255))
        new.paste(im.crop((0, 0, w0, y1)), (0, 0))
        new.paste(im.crop((0, y2, w0, h0)), (0, y1 + gap))
        from PIL import ImageDraw
        dr = ImageDraw.Draw(new)
        for x in range(0, w0, 14):
            dr.line([(x, y1 + gap // 2), (x + 7, y1 + gap // 2)], fill=(148, 163, 184), width=2)
        im = new
        path = os.path.join(CROP, "cut_" + name)
        im.save(path)
    w, h = im.size
    FIG[0] += 1
    rl = Image(path, width=width, height=width * h / w)
    t = Table([[rl]], colWidths=[width + 2])
    t.setStyle(TableStyle([("BOX", (0, 0), (-1, -1), 0.6, LINE), ("LEFTPADDING", (0, 0), (-1, -1), 0),
                           ("RIGHTPADDING", (0, 0), (-1, -1), 0), ("TOPPADDING", (0, 0), (-1, -1), 0),
                           ("BOTTOMPADDING", (0, 0), (-1, -1), 0)]))
    story.append(KeepTogether([t, P(f"Figura {FIG[0]}. {caption}", "cap")]))


def phone_parts(name, width, max_h):
    path = os.path.join(SH, name)
    im = PILImage.open(path)
    w, h = im.size
    full_h = width * h / w
    n = max(1, math.ceil(full_h / max_h))
    if n == 1:
        return [Image(path, width=width, height=full_h)]
    parts = []
    step = math.ceil(h / n)
    for i in range(n):
        top = max(0, i * step - (30 if i else 0))
        bottom = min(h, (i + 1) * step)
        p = os.path.join(CROP, f"{os.path.splitext(name)[0]}_{i}.png")
        im.crop((0, top, w, bottom)).save(p)
        parts.append(Image(p, width=width, height=width * (bottom - top) / w))
    return parts


def phone_block(names, caption, text_flow, width=4.5 * cm, max_h=12.8 * cm):
    """capturi de telefon (una sau mai multe, cele inalte impartite in coloane) + text alaturi"""
    imgs = []
    for n in names if isinstance(names, list) else [names]:
        imgs += phone_parts(n, width, max_h)
    cells = []
    for im in imgs:
        c = Table([[im]], colWidths=[width + 1])
        c.setStyle(TableStyle([("BOX", (0, 0), (-1, -1), 0.8, colors.HexColor("#94a3b8")),
                               ("LEFTPADDING", (0, 0), (-1, -1), 0), ("RIGHTPADDING", (0, 0), (-1, -1), 0),
                               ("TOPPADDING", (0, 0), (-1, -1), 0), ("BOTTOMPADDING", (0, 0), (-1, -1), 0)]))
        cells.append(c)
    FIG[0] += 1
    img_tab = Table([cells], colWidths=[width + 8] * len(cells))
    img_tab.setStyle(TableStyle([("VALIGN", (0, 0), (-1, -1), "TOP"), ("LEFTPADDING", (0, 0), (-1, -1), 0),
                                 ("RIGHTPADDING", (0, 0), (-1, -1), 7)]))
    left = [img_tab, P(f"Figura {FIG[0]}. {caption}", "cap")]
    lw = (width + 8) * len(cells)
    if lw > W - 5 * cm:  # prea late: textul sub imagini
        story.append(KeepTogether(left))
        story.extend(text_flow)
        return
    t = Table([[left, text_flow]], colWidths=[lw + 4, W - lw - 4])
    t.setStyle(TableStyle([("VALIGN", (0, 0), (-1, -1), "TOP"), ("LEFTPADDING", (0, 0), (-1, -1), 0),
                           ("RIGHTPADDING", (0, 0), (-1, -1), 0), ("LEFTPADDING", (1, 0), (1, 0), 12)]))
    story.append(t)
    story.append(Spacer(1, 6))


def table(rows, widths, head=True, zebra=True, keep=False):
    data = []
    for r, row in enumerate(rows):
        data.append([P(c, "cellh" if (head and r == 0) else "cell") if isinstance(c, str) else c for c in row])
    t = Table(data, colWidths=widths, repeatRows=1 if head else 0)
    st = [("GRID", (0, 0), (-1, -1), 0.5, LINE), ("VALIGN", (0, 0), (-1, -1), "TOP"),
          ("TOPPADDING", (0, 0), (-1, -1), 3.5), ("BOTTOMPADDING", (0, 0), (-1, -1), 3.5),
          ("LEFTPADDING", (0, 0), (-1, -1), 5), ("RIGHTPADDING", (0, 0), (-1, -1), 5)]
    if head:
        st.append(("BACKGROUND", (0, 0), (-1, 0), BLUE))
    if zebra:
        for r in range(1 if head else 0, len(rows)):
            if r % 2 == 0:
                st.append(("BACKGROUND", (0, r), (-1, r), LIGHT))
    t.setStyle(TableStyle(st))
    story.append(KeepTogether([t]) if keep else t)
    story.append(Spacer(1, 8))


class Flow(Flowable):
    """schema fluxului: operator -> dispecer -> sofer -> WMS"""

    def __init__(self):
        super().__init__()
        self.width, self.height = W, 6.2 * cm

    def draw(self):
        c = self.canv
        bw, bh, gap = 3.75 * cm, 4.6 * cm, (W - 4 * 3.75 * cm) / 3
        boxes = [
            ("OPERATOR", "#0f766e", ["Comanda clientului (107)", "„Alege furnizorul” →", "ridicare de la furnizor",
                                      "Date de livrare: data,", "ora, adresa", "Retur la furnizor (126)"]),
            ("DISPECER (WMS)", "#1d4ed8", ["Dispecerat: alege ziua", "Atribuie ridicări, retururi", "și livrări curierilor",
                                            "Ordonează opririle", "Rezolvă „Probleme”", "Publică planul"]),
            ("ȘOFER (telefon)", "#b45309", ["Traseul meu", "Depozit → furnizori →", "clienți", "La furnizor: preluare,",
                                             "cantități, fotografii", "Închide preluarea"]),
            ("REZULTAT ÎN WMS", "#7c3aed", ["Intrare marfă (106)", "deschisă în depozitul", "mașinii", "Ridicări „Ridicata”",
                                             "Retur 126: de finalizat", "manual în WMS"]),
        ]
        y0 = 0.7 * cm
        for i, (title, col, lines) in enumerate(boxes):
            x = i * (bw + gap)
            c.setFillColor(colors.HexColor(col))
            c.roundRect(x, y0 + bh - 0.85 * cm, bw, 0.85 * cm, 6, fill=1, stroke=0)
            c.setFillColor(colors.white)
            c.setFont("UI-B", 9)
            c.drawCentredString(x + bw / 2, y0 + bh - 0.56 * cm, title)
            c.setStrokeColor(colors.HexColor(col))
            c.setFillColor(colors.white)
            c.setLineWidth(1.2)
            c.roundRect(x, y0, bw, bh - 0.85 * cm, 6, fill=1, stroke=1)
            c.setFillColor(DARK)
            c.setFont("UI", 8.2)
            for k, ln in enumerate(lines):
                c.drawString(x + 0.25 * cm, y0 + bh - 1.45 * cm - k * 0.5 * cm, ln)
            if i < 3:
                ax = x + bw + 0.12 * cm
                ay = y0 + (bh - 0.85 * cm) / 2
                c.setStrokeColor(GREY)
                c.setFillColor(GREY)
                c.setLineWidth(1.6)
                c.line(ax, ay, ax + gap - 0.3 * cm, ay)
                p = c.beginPath()
                p.moveTo(ax + gap - 0.24 * cm, ay)
                p.lineTo(ax + gap - 0.48 * cm, ay + 0.14 * cm)
                p.lineTo(ax + gap - 0.48 * cm, ay - 0.14 * cm)
                p.close()
                c.drawPath(p, fill=1, stroke=0)
        c.setFont("UI-I", 8)
        c.setFillColor(GREY)
        c.drawCentredString(W / 2, 0.15 * cm,
                            "Toate datele trec prin aceeași bază SW: ce atribuie dispecerul apare pe telefon după publicare; "
                            "ce închide șoferul apare imediat în WMS.")


# ---------- pagini ----------
class Doc(BaseDocTemplate):
    def afterFlowable(self, f):
        if isinstance(f, Heading):
            key = f"h{id(f)}"
            self.canv.bookmarkPage(key)
            self.notify("TOCEntry", (f.toc_level, f.getPlainText(), self.page, key))
            self.canv.addOutlineEntry(f.getPlainText(), key, level=f.toc_level, closed=False)


def on_page(c, d):
    c.saveState()
    c.setFont("UI", 7.8)
    c.setFillColor(GREY)
    c.drawString(M, PAGE_H - 1.15 * cm, "Instrucțiune de lucru · Dispecerat: achiziții, livrări și retururi")
    c.drawRightString(PAGE_W - M, PAGE_H - 1.15 * cm, "WMS + aplicația Curieri · v1.0 · 13.10.2026")
    c.setStrokeColor(LINE)
    c.setLineWidth(0.5)
    c.line(M, PAGE_H - 1.3 * cm, PAGE_W - M, PAGE_H - 1.3 * cm)
    c.drawCentredString(PAGE_W / 2, 1.0 * cm, f"pagina {d.page}")
    c.restoreState()


def on_cover(c, d):
    c.saveState()
    c.setFillColor(BLUE)
    c.rect(0, PAGE_H - 9.5 * cm, PAGE_W, 9.5 * cm, fill=1, stroke=0)
    c.setFillColor(colors.white)
    c.setFont("UI", 12)
    c.drawString(M, PAGE_H - 2.6 * cm, "INSTRUCȚIUNE DE LUCRU")
    c.setFont("UI-B", 27)
    c.drawString(M, PAGE_H - 4.1 * cm, "Dispecerat: achiziții,")
    c.drawString(M, PAGE_H - 5.25 * cm, "livrări și retururi")
    c.setFont("UI", 12.5)
    c.drawString(M, PAGE_H - 6.6 * cm, "Comenzile pentru șoferi în WMS și în aplicația Curieri")
    c.setFont("UI", 10)
    c.drawString(M, PAGE_H - 8.3 * cm, "Pentru: operatori · dispecer · șoferi (curieri)")
    c.setFillColor(GREY)
    c.setFont("UI", 9)
    c.drawString(M, 1.6 * cm, "Versiunea 1.0 · 13 octombrie 2026 · descrie WMS 5.5 (Nomenclatoare › Dispecerat) "
                              "și aplicația web Curieri, prima versiune")
    c.drawString(M, 1.15 * cm, "Capturile de ecran sunt făcute pe o bază de test cu date fictive "
                               "(clienți, furnizori și curieri inventați).")
    c.restoreState()


doc = Doc(OUT, pagesize=A4, leftMargin=M, rightMargin=M, topMargin=1.8 * cm, bottomMargin=1.6 * cm,
          title="Instrucțiune de lucru - Dispecerat: achiziții, livrări și retururi",
          author="NEURON Grup SRL", subject="WMS + aplicația Curieri")
frame = Frame(M, 1.6 * cm, W, PAGE_H - 3.4 * cm, id="f", leftPadding=0, rightPadding=0, topPadding=0,
              bottomPadding=0)
cover_frame = Frame(M, 2.4 * cm, W, PAGE_H - 12.2 * cm, id="c", leftPadding=0, rightPadding=0)
doc.addPageTemplates([PageTemplate("cover", [cover_frame], onPage=on_cover),
                      PageTemplate("normal", [frame], onPage=on_page)])

# ---------- coperta ----------
story.append(P('<font name="UI-B" size="12" color="#0f172a">Cine ce citește</font>'))
table([
    ["Rol", "Ce face", "Capitole"],
    ["<b>Operator</b> (vânzări, comenzi web)",
     "Pune produsul la ridicare de la furnizor, completează datele de livrare, creează returul la furnizor.",
     "1, 2, 3"],
    ["<b>Dispecer</b>", "Configurează curierii și zonele, planifică ziua pe curieri, publică traseele, urmărește "
                        "execuția și închide documentele în WMS.", "1, 2, 4, 5, 7"],
    ["<b>Șofer / curier</b>", "Lucrează pe telefon: vede traseul zilei, face preluarea la furnizor (cantități + "
                              "fotografii), predă returul, vede comanda clientului.", "1, 6, 7 + fișa rapidă"],
], [3.8 * cm, 10.6 * cm, 3 * cm])
story.append(NextPageTemplate("normal"))
story.append(PageBreak())
story.append(P('<font name="UI-B" size="16" color="#1d4ed8">Cuprins</font>'))
story.append(Spacer(1, 8))
toc = TableOfContents()
toc.levelStyles = [S["toc1"], S["toc2"]]
story.append(toc)
story.append(PageBreak())

# =====================================================================
H1("1. Cum funcționează pe scurt")
para("Marfa pe care o ridicăm de la furnizori, mărfurile returnate furnizorilor și livrările la clienți se "
     "planifică acum <b>într-un singur loc</b> — forma " + ui("Dispecerat: achizitii si livrari") + " din WMS — și "
     "ajung la șofer pe telefon, în aplicația <b>Curieri</b>. Șoferul nu mai primește lista pe hârtie sau prin "
     "mesaje: vede traseul zilei, iar când preia marfa la furnizor confirmă cantitățile și fotografiază seria. "
     "La închiderea preluării WMS creează singur <b>Intrarea de marfă (106)</b> în depozitul mașinii.")
story.append(Flow())
story.append(Spacer(1, 6))
H2("1.1 Noțiuni")
table([
    ["Termen", "Ce înseamnă"],
    ["<b>Planul zilei</b>", "Tot ce au de făcut curierii într-o zi, pentru firma curentă. Se creează automat la prima "
                            "atribuire. Stări: <b>CIORNA</b> (șoferii nu-l văd), <b>PUBLICAT</b>, <b>IN EXECUTARE</b> "
                            "(un șofer a început o preluare)."],
    ["<b>Traseul</b>", "Partea din plan a unui curier: lista ordonată de opriri."],
    ["<b>Oprirea</b>", "Un loc unde merge șoferul. Trei tipuri: <b>Depozit</b> (încărcare, mereu prima), "
                       "<b>Furnizor</b> (ridicări și/sau retur) și <b>Client</b> (livrare). Mai multe sarcini la "
                       "același furnizor sau la același client și adresă se strâng într-o singură oprire."],
    ["<b>Ridicarea</b>", "Un produs dintr-o comandă de client care trebuie adus de la furnizor "
                         "(lista " + ui("Ridicari de la furnizori") + ")."],
    ["<b>Preluarea</b>", "Ce face șoferul la furnizor în aplicație: începe preluarea (lista se blochează), "
                         "confirmă cantitățile, fotografiază seriile/partidele, închide preluarea."],
    ["<b>Returul la furnizor</b>", "Documentul <b>126</b>. Dispecerul îl pune pe traseu; marfa se încarcă la depozit "
                                   "și se predă la furnizor."],
    ["<b>Livrarea</b>", "Comanda clientului (<b>107</b>) care are date de livrare (dată, oră, adresă)."],
    ["<b>Depozitul mașinii</b>", "Un depozit propriu fiecărui curier, în folderul „Depozite mobile”. Aici intră "
                                 "marfa ridicată, prin Intrarea de marfă (106) creată de aplicație."],
    ["<b>Zona logistică</b>", "Cartier / localitate (Ciocana, Buiucani …) folosită la gruparea livrărilor."],
], [3.6 * cm, 13.8 * cm])

H2("1.2 Stările pe care le veți vedea")
table([
    ["Obiect", "Stări și ce înseamnă"],
    ["Ridicarea (WMS)", "<b>Noua</b> → <b>Atribuita</b> (are șofer) → <b>Ridicata</b> (șoferul a închis preluarea) · "
                        "<b>Anulata</b>"],
    ["Preluarea (coloana „Preluare”)", "<b>In preluare (blocata)</b> — șoferul a început, lista nu se mai schimbă · "
                                       "<b>Incarcat</b> — preluarea e închisă, intrarea 106 e creată"],
    ["Oprirea (WMS și telefon)", "<b>Planificată</b> · <b>În lucru</b> · <b>Terminată</b> · <b>Cu probleme</b> "
                                 "(s-a primit mai puțin decât trebuia) · <b>Anulată</b> (scoasă de dispecer după publicare)"],
    ["Livrarea (fila Livrari)", "<b>Neplanificata</b> (gol) · <b>De planificat</b> (are doar zona și ziua) · "
                                "<b>Planificata</b> (are curier)"],
    ["Traseul (fila Trasee)", "<b>Planificat</b> · <b>Pe traseu</b> (șoferul a început prima preluare)"],
], [4.4 * cm, 13 * cm])

# =====================================================================
story.append(PageBreak())
H1("2. Configurarea inițială (dispecer, o singură dată)")
para("Se face o dată, la pornire, și apoi doar când apare un curier nou sau o zonă nouă. Ambele ferestre se "
     "deschid din forma Dispecerat (butoanele " + ui("Curieri...") + " și " + ui("Zone...") + "), deschisă din "
     "meniul principal <b>Nomenclatoare › Dispecerat: achizitii si livrari</b>.")
H2("2.1 Zonele logistice")
figure("w_zone.png", "Zone logistice (butonul „Zone...” din Dispecerat).", width=11 * cm)
story.extend(steps([
    "Apăsați " + ui("Adauga") + " " + num(1) + " și completați în tabel " + num(2) + ": <b>Cod</b> (scurt), "
    "<b>Denumirea</b> (cum o vede șoferul), <b>Ordine</b> (ordinea în liste), <b>Activa</b>.",
    "Apăsați " + ui("Salveaza") + " " + num(3) + ". O zonă folosită deja nu se poate șterge — debifați "
    "<b>Activa</b> în loc.",
]))
H2("2.2 Curierii, depozitul mașinii și contul din aplicație")
figure("w_curieri.png", "Fereastra „Curieri” (butonul „Curieri...” din Dispecerat).", width=W)
story.extend(steps([
    "Sus completați o singură dată " + num(1) + " " + ui("Depozitul de baza") + " — depozitul din care pleacă "
    "mașinile (prima oprire a fiecărui traseu) și " + num(2) + " " + ui("Utilizatorul WMS pentru documentele aplicatiei") +
    " — utilizatorul tehnic <b>CurieriWMS</b>, autorul documentelor create de pe telefon. Ambele câmpuri se "
    "completează împreună.",
    ui("Adauga curier") + " " + num(3) + ": alegeți persoana din <b>Colaboratori</b>. Telefonul se completează "
    "singur; <b>Activ</b>, <b>Ridica</b>, <b>Livreaza</b> sunt bifate implicit.",
    ui("Creeaza depozitul masinii...") + " " + num(4) + ": scrieți numele (de ex. „Mașina Țurcanu”). Depozitul se "
    "creează în folderul „Depozite mobile”, nu apare la vânzare și primește automat drepturile celorlalte "
    "depozite mobile. <b>Fără depozit, curierul nu poate fi publicat pe traseu.</b>",
    "În tabel " + num(5) + ", coloana <b>Login aplicatie</b>: scrieți loginul șoferului (de ex. <i>turcanu</i>, "
    "litere mici, fără spații).",
    ui("Cod de activare...") + " " + num(6) + ": programul generează un cod de <b>8 cifre</b>, valabil "
    "<b>24 de ore</b>, afișat <b>o singură dată</b>. Transmiteți-l șoferului împreună cu loginul și adresa "
    "aplicației. Un cod nou anulează parola veche (programul cere confirmare) — așa se resetează parola uitată.",
    "Apăsați " + ui("Salveaza") + " " + num(7) + ".",
]))
box("info", "Ce vedeți în tabel după activare",
    "<b>Are parola</b> se bifează când șoferul și-a ales parola; <b>Cod valabil pana la</b> arată expirarea codului "
    "nefolosit; <b>Ultima intrare</b> — ultima autentificare din aplicație.")
H2("2.3 Reguli de comandă prin intermediar (opțional)")
figure("w_reguli_intermediar.png", "Nomenclatoare › Reguli comanda prin intermediar.", width=13 * cm)
para("Dacă marfa unui furnizor se comandă de obicei prin alt furnizor (intermediar), adăugați o regulă "
     + num(1) + ": <b>furnizorul cu stoc</b>, <b>furnizorul prin care comandăm</b> și <b>de unde ridică șoferul</b>. "
     "La crearea unei ridicări, aceste valori se completează singure (se pot schimba). Salvați cu " + num(2) + ".")

# =====================================================================
story.append(CondPageBreak(11 * cm))
H1("3. Operatorul: ridicări, livrări și retururi")
H2("3.1 Produs care trebuie ridicat de la furnizor")
para("Când clientul cumpără un produs care nu e în stocul nostru, în comanda clientului (documentul <b>107</b>) "
     "selectați rândul produsului și apăsați pe bara de produse butonul " + ui("Alege furnizorul") + " "
     "(<b>Alt+E</b>).")
story.extend(bullets([
    "Dacă rândul nu are încă ridicare, se deschide lista <b>Produse coduri furnizori</b>: alegeți furnizorul care "
    "are produsul în stoc. Apoi se deschide dialogul de mai jos.",
    "Dacă rândul are deja o ridicare pentru toată cantitatea, se deschide acea ridicare (pentru verificare sau "
    "modificare).",
    "În celelalte cazuri se deschide lista ridicărilor acestui rând, cu butonul " + ui("Ridicare noua") +
    " pentru restul cantității.",
]))
story.append(Spacer(1, 4))
figure("w_ridicare_confirmare.png", "Dialogul „Ridicare marfa de la furnizor”.", width=10.5 * cm)
story.extend(steps([
    num(1) + " <b>Furnizorul cu stoc</b> — cel ales din listă (se poate schimba cu butonul „…”).",
    num(2) + " <b>Comandam prin</b> — furnizorul căruia îi plasăm comanda și care ne facturează. Butonul "
    + ui("Direct") + " = comandăm direct la furnizorul cu stoc. Dacă există o regulă (2.3), valoarea vine din ea.",
    num(3) + " <b>Soferul ridica marfa de la</b> — de la furnizorul cu stoc sau de la intermediar. De aici se "
    "decide <b>la ce oprire</b> va merge șoferul.",
    num(4) + " <b>Cantitate</b> — cel mult cât e în comandă minus ce e deja în alte ridicări (limita e scrisă alături).",
    num(5) + " <b>Data ridicarii</b> — ziua în care trebuie adusă marfa. Pe ea o vede dispecerul.",
    num(6) + " <b>Nota</b> — ce trebuie să știe șoferul (o vede pe telefon).",
    num(7) + " " + ui("OK") + ". Ridicarea apare cu starea <b>Noua</b> în " + ui("Ridicari de la furnizori") +
    " și în Dispecerat, fila <b>Achizitii</b>.",
]))
H2("3.2 Lista „Ridicari de la furnizori”")
figure("w0_disp_ridicari_lista.png", "Nomenclatoare › Ridicari de la furnizori.", width=W)
story.extend(steps([
    num(1) + " " + ui("Doar de ridicat (noi si atribuite)") + " — bifat: doar ce mai e de adus; debifat: și "
    "ultimele 60 de zile.",
    num(2) + " " + ui("Modifica") + " (sau dublu-clic) — data, cantitatea, furnizorii, nota.",
    num(3) + " " + ui("Atribuie soferul") + " / " + num(4) + " " + ui("Scoate soferul") + " — pune sau scoate "
    "ridicarea de pe traseul unui curier (aceeași acțiune ca în Dispecerat). Se acceptă doar colaboratorii care au "
    "profil de curier.",
    num(5) + " " + ui("Ridicata") + " — marcare manuală (de ex. marfa a fost adusă fără aplicație). "
    + num(6) + " " + ui("Anuleaza") + " · " + num(7) + " " + ui("Redeschide") + ".",
]))
box("warn", "Atenție la anulare și modificări",
    "Butoanele " + ui("Anuleaza") + ", " + ui("Ridicata") + ", " + ui("Redeschide") + " și modificarea datei sau a "
    "furnizorului schimbă doar ridicarea, <b>nu și traseul</b>. Dacă ridicarea e deja pe traseul unui șofer, "
    "apăsați întâi " + ui("Scoate soferul") + " (sau anunțați dispecerul), apoi anulați/modificați. După ce "
    "șoferul a început preluarea, ridicarea nu se mai poate schimba din WMS: <i>„Ridicarea face parte dintr-o "
    "preluare inceputa de sofer…”</i>.")
H2("3.3 Datele de livrare ale comenzii")
para("Ca o comandă să ajungă în Dispecerat la fila <b>Livrari</b>, documentul 107 trebuie să aibă date de "
     "livrare. Le completați în fereastra proprietăților documentului (document nou sau modificare), secțiunea "
     "<b>Livrare</b>:")
figure("w_livrare_document.png", "Secțiunea „Livrare” din proprietățile documentului.", width=8.5 * cm)
story.extend(steps([
    "Dacă documentul nu are date de livrare, apăsați " + ui("Adauga") + " " + num(2) + ".",
    "Completați " + num(1) + " <b>Data</b> (obligatoriu!), <b>Ora</b> (intervalul convenit cu clientul, de ex. "
    "14:00-16:00) și <b>Adresa</b> completă (localitate, stradă, bloc, apartament, etaj).",
    "Rubricile <b>Factura</b> / <b>Numerar</b> arată dacă la livrare se predă factura și se încasează numerar.",
]))
box("stop", "Fără „Data” livrarea nu apare la dispecer",
    "Dispecerul vede livrările din ziua aleasă și pe cele neplanificate din ultimele 14 zile, după data livrării. "
    "O comandă fără dată de livrare nu apare deloc în fila Livrari. Pentru comenzile de pe site datele vin automat; "
    "verificați doar adresa și intervalul.")
H2("3.4 Retur la furnizor")
para("Creați documentul de retur la furnizor (<b>126</b>) ca de obicei. Cât timp nu e închis, el apare automat în "
     "Dispecerat, fila <b>Retururi</b>, și dispecerul îl pune pe traseul unui curier. Scrieți în notă tot ce "
     "trebuie să știe șoferul (persoana de contact, acte).")

# =====================================================================
story.append(CondPageBreak(11 * cm))
H1("4. Dispecerul: planul zilei")
para("Deschideți <b>Nomenclatoare › Dispecerat: achizitii si livrari</b>. Fereastra lucrează pe <b>firma curentă</b> "
     "și pe <b>ziua</b> aleasă sus. Pe file (Achizitii, Retururi, Livrari, Trasee, Probleme) e scris numărul de rânduri.")
H2("4.1 Alegeți ziua, curierul și atribuiți ridicările")
figure("w0_disp_tsPickups.png", "Ziua de mâine, încă neplanificată: o ridicare nouă, fără curier.")
story.extend(steps([
    num(1) + " <b>Ziua</b> — data planului; butoanele „&lt;” și „&gt;” trec la ziua precedentă / următoare. "
    + num(2) + " arată starea planului: aici <i>„Planul zilei nu exista inca (se creeaza la prima atribuire)”</i>.",
    num(3) + " <b>Curierul</b> — alegeți curierul căruia îi dați sarcinile (apar doar curierii activi).",
    num(4) + " Selectați rândurile de atribuit. Se pot selecta mai multe cu <b>Ctrl</b> / <b>Shift</b>. În listă "
    "sunt ridicările zilei plus cele noi/atribuite cu data goală sau mai veche (cele întârziate nu se pierd).",
    num(5) + " " + ui("Atribuie curierului ales") + ". La final apare rezumatul <i>„Reusite: X din Y.”</i> și motivul "
    "pentru rândurile refuzate. Ridicarea primește curierul și oprirea la furnizorul de la care se ridică; mai "
    "multe ridicări de la același furnizor ajung la aceeași oprire.",
    num(6) + " " + ui("Publica planul") + " — după ce ați terminat toate filele (vezi 4.6).",
]))
figure("w2_disp_tsPickups.png", "După atribuire: ridicarea are curier, oprirea nr. 2 și starea „Atribuita”; "
                                "planul a devenit CIORNA.")
H2("4.2 Retururile la furnizor")
figure("w1_disp_tsReturns.png", "Fila Retururi: documentele 126 neînchise.")
para("Alegeți curierul " + num(1) + ", selectați documentul și apăsați " + ui("Atribuie curierului ales") + " "
     + num(2) + ". Returul creează două sarcini: <b>încărcarea</b> mărfii la oprirea Depozit (prima) și "
     "<b>predarea</b> la oprirea furnizorului. " + ui("Scoate din traseu") + " " + num(3) + " le anulează.")
H2("4.3 Livrările la clienți")
figure("w2_disp_tsDeliveries.png", "Fila Livrari: comenzile 107 cu date de livrare.")
story.extend(steps([
    "Alegeți " + num(1) + " curierul și " + num(2) + " <b>Zona livrarii</b> potrivită adresei.",
    ui("Atribuie curierului ales") + " " + num(3) + " — livrarea intră în traseu (adresa, telefonul și intervalul "
    "se copiază din document). Mai multe comenzi pentru același client și aceeași adresă ajung la o singură oprire.",
    ui("Doar zona si ziua") + " " + num(4) + " — când știți zona și ziua, dar nu și curierul (starea "
    "<b>De planificat</b>). Curierul îl puneți mai târziu.",
    ui("Scoate din traseu") + " " + num(5) + " — livrarea revine la neplanificată.",
]))
H2("4.4 Ordinea opririlor")
figure("w1_disp_tsRoutes.png", "Fila Trasee: sus curierii, jos opririle curierului selectat.")
para("În tabelul de sus " + num(1) + " vedeți pentru fiecare curier numărul de opriri, câte sunt gata, câte au "
     "probleme și dacă are cont în <b>Aplicatie</b>. Jos " + num(2) + " sunt opririle în ordinea în care le vede "
     "șoferul, cu ora, zona și numărul de sarcini. Mutați oprirea selectată cu " + ui("Oprirea mai sus") + " "
     + num(3) + " / " + ui("Oprirea mai jos") + " " + num(4) + ". Oprirea <b>Depozit</b> rămâne mereu prima.")
H2("4.5 Fila Probleme")
figure("w2_disp_tsProblems.png", "Planul de mâine în CIORNA, cu două atenționări.")
para("Fila " + num(2) + " verifică planul înainte de publicare. <b>Erorile</b> blochează publicarea; "
     "<b>atenționările</b> nu, dar citiți-le.")
table([
    ["Nivel", "Mesaj", "Ce faceți"],
    ["Eroare", "Curierul nu are profil activ", "Curieri… › bifați Activ (sau alegeți alt curier)."],
    ["Eroare", "Curierul nu are depozit (masina) asociat", "Curieri… › Creeaza depozitul masinii…"],
    ["Eroare", "Oprire fara adresa: …", "Completați adresa furnizorului (fișa) sau a livrării (documentul)."],
    ["Eroare", "Livrare fara zona: …", "Fila Livrari › alegeți zona și atribuiți din nou."],
    ["Atenție", "Curierul nu are cont in aplicatie: traseul se poate da doar tiparit",
     "Curieri… › Login aplicatie + Cod de activare. Până atunci șoferul nu vede traseul pe telefon."],
    ["Atenție", "Furnizor fara zona: …", "Informativ (zonele furnizorilor nu se completează încă)."],
    ["Atenție", "Ridicare fara curier / Livrare fara curier: …", "A rămas ceva neatribuit pentru ziua aleasă."],
], [1.7 * cm, 7.2 * cm, 8.5 * cm])
H2("4.6 Publicarea și modificările ulterioare")
figure("w1_disp_tsPickups.png", "Planul publicat: butonul devine „Republica planul”.")
story.extend(steps([
    ui("Publica planul") + " — confirmați întrebarea <i>„Publicati planul din …? Soferii vor vedea traseele pe "
    "telefon.”</i> Dacă există erori, se deschide fila Probleme cu mesajul <i>„Planul nu poate fi publicat: …”</i>.",
    "Starea devine " + num(1) + " <b>Plan: PUBLICAT (versiunea N, data ora)</b>. Șoferii văd traseul imediat "
    "(aplicația se actualizează singură la fiecare minut).",
    "Puteți modifica planul și după publicare (atribuiri noi, scoateri, ordinea). O sarcină scoasă după publicare "
    "devine anulată, iar oprirea rămasă fără sarcini apare la șofer <b>Anulată</b>. După modificări apăsați "
    + num(2) + " " + ui("Republica planul") + " și " + num(3) + " " + ui("Actualizeaza") + ".",
    "Ce a început deja șoferul (preluare blocată) nu se mai poate muta sau scoate: <i>„Soferul a inceput deja "
    "preluarea…”</i>.",
]))

# =====================================================================
story.append(CondPageBreak(11 * cm))
H1("5. Dispecerul: urmărirea zilei și închiderea documentelor")
H2("5.1 Ce vedeți în timpul zilei")
figure("w3_disp_tsPickups.png", "După ce șoferul a închis preluările: planul e IN EXECUTARE, ridicările sunt "
                                "„Ridicata” / „Incarcat”.")
story.extend(bullets([
    num(1) + " Starea planului devine <b>IN EXECUTARE</b> când un șofer începe prima preluare.",
    num(2) + " Coloanele <b>Stare</b> și <b>Preluare</b>: <b>In preluare (blocata)</b> cât timp șoferul lucrează la "
    "furnizor, apoi <b>Ridicata</b> / <b>Incarcat</b>.",
    "Apăsați " + ui("Actualizeaza") + " ca să vedeți ultimele date.",
]))
figure("w3_disp_tsRoutes.png", "Fila Trasee la sfârșitul preluărilor: o oprire „Terminata”, una „Cu probleme”.")
para("În fila Trasee " + num(1) + " coloanele <b>Gata</b> și <b>Probleme</b> arată progresul fiecărui curier; "
     "jos " + num(2) + " starea fiecărei opriri. <b>Cu probleme</b> = la furnizor s-a primit mai puțin decât era "
     "planificat; motivul scris de șofer se vede în aplicație și pe intrarea de marfă.")
H2("5.2 Ce trebuie făcut în WMS după preluare")
box("info", "Fotografiile seriilor",
    "Fotografiile făcute de șofer se păstrează în baza de date, dar în această versiune <b>nu se pot vedea din "
    "WMS</b>. Dacă aveți nevoie de ele, cereți-i șoferului să le arate din aplicație (oprirea închisă păstrează "
    "miniaturile).")
table([
    ["Ce a făcut șoferul", "Ce apare în WMS", "Ce faceți"],
    ["A închis preluarea la furnizor",
     "Câte o <b>Intrare marfă (106) deschisă</b> pentru fiecare furnizor „Comandat prin”, în <b>depozitul mașinii</b>, "
     "autor CurieriWMS, la prețul de achiziție convertit în lei la cursul BNM. Ridicările devin „Ridicata”.",
     "Verificați intrarea (cantități, prețuri, factura furnizorului), completați seriile și închideți-o după "
     "procedura obișnuită de recepție. Seriile pot fi vândute abia după închiderea documentului."],
    ["A primit mai puțin (cu motiv)",
     "Oprirea „Cu probleme”; în 106 intră doar cantitatea primită. Ridicarea primită cu 0 rămâne atribuită.",
     "Clarificați cu furnizorul și replanificați restul (o ridicare nouă sau aceeași ridicare pe altă zi)."],
    ["A predat returul",
     "Se înregistrează doar cantitatea predată. <b>Documentul 126 nu se modifică automat.</b>",
     "Finalizați manual returul 126 în WMS (cantitatea predată, închiderea documentului)."],
    ["A livrat la client", "Nimic automat — aplicația arată livrarea doar pentru citire.",
     "Marcați livrarea și încasarea în WMS ca până acum, după raportul șoferului."],
], [3.6 * cm, 6.9 * cm, 6.9 * cm], keep=True)
# =====================================================================
story.append(PageBreak())
H1("6. Șoferul: aplicația Curieri")
para("Aplicația se deschide în browserul telefonului (Chrome / Safari), la adresa primită de la dispecer. Nu se "
     "instalează nimic; recomandat: în meniul browserului alegeți <b>„Adaugă pe ecranul de pornire”</b>, ca s-o "
     "deschideți ca pe o aplicație. Aveți nevoie de internet mobil și de acces la cameră.")
H2("6.1 Prima intrare: activarea contului")
phone_block(["a03_activare.png"], "Activarea contului.", steps([
    "Pe ecranul de autentificare apăsați " + ui("Am primit un cod de activare") + ".",
    "Scrieți <b>Login</b>-ul și <b>Codul de activare</b> (8 cifre) primite de la dispecer.",
    "Alegeți o <b>parolă nouă</b> (minimum 6 caractere) și repetați-o.",
    "Apăsați " + ui("Activează și intră") + ". Se deschide direct traseul.",
]) + [Spacer(1, 4)] + bullets([
    "Codul e valabil 24 de ore și merge o singură dată. Dacă vedeți <i>„Loginul sau codul nu sunt valabile. Cere "
    "dispecerului un cod nou.”</i> — cereți un cod nou.",
    "Ați uitat parola? Tot cu un cod nou de la dispecer.",
]))
H2("6.2 Autentificarea zilnică")
phone_block(["a05_login_filled.png", "a02_login_error.png"], "Autentificare și mesajul pentru parolă greșită.",
            steps([
                "Scrieți <b>Login</b> și <b>Parola</b> (butonul " + ui("Arată") + " afișează parola).",
                "Apăsați " + ui("Intră") + ". Telefonul ține minte autentificarea — de obicei nu trebuie s-o "
                "repetați zilnic.",
            ]) + bullets([
                "După 5 încercări greșite contul se blochează 15 minute: <i>„Prea multe încercări…”</i>.",
                "<i>„Baza de date nu răspunde…”</i> — reîncercați peste un minut; dacă persistă, sunați dispecerul.",
                ui("Ieșire") + " (sus, dreapta) închide sesiunea — folosiți-l dacă telefonul îl mai folosește "
                "cineva.",
            ]), width=4.1 * cm)
H2("6.3 Traseul meu")
phone_block(["a06_traseu_toate.png"], "Traseul zilei: depozit, doi furnizori, un client.", bullets([
    "Opririle sunt în ordinea stabilită de dispecer: <b>Depozit</b> (gri închis), <b>Furnizor</b> (portocaliu), "
    "<b>Client</b> (albastru), cu ora, zona și adresa.",
    "Filele " + ui("Toate") + ", " + ui("Achiziții") + " (depozit + furnizori), " + ui("Livrări") + " (clienți) "
    "arată numărul de opriri nefinalizate.",
    "Pe card: starea (Planificată, În lucru, Terminată, Cu probleme, Anulată) și sarcinile: <b>Ridicări</b>, "
    "<b>Retur</b> (cardul devine galben), <b>Livrări</b>, <b>De încărcat</b>.",
    "Opririle terminate devin gri; cele anulate de dispecer sunt tăiate.",
    "Lista se actualizează singură la fiecare minut; " + ui("Reîncarcă") + " o actualizează imediat.",
    "Dacă ați rămas cu opriri neterminate din zilele trecute, ele apar sub titlul roșu <b>„Restanță din zz.ll”</b>.",
    "Fără traseu publicat: <i>„Nu ai un traseu publicat pentru azi.”</i> — dispecerul încă nu l-a publicat.",
]))
H2("6.4 Oprirea la depozit (încărcare)")
phone_block(["a09_oprire_depozit.png"], "Oprirea Depozit: ce trebuie încărcat.", bullets([
    "Apăsați pe card pentru detalii. Sus: adresa, contactul, nota dispecerului (chenarul galben) și butoanele "
    + ui("Sună") + " și " + ui("Hartă") + " (deschide Google Maps).",
    "Lista <b>De încărcat</b> arată ce luați din depozit: de obicei marfa pentru retururi, cu numărul documentului "
    "și cantitatea.",
    "Aici nu se confirmă nimic în aplicație — încărcați marfa și verificați-o cu lista.",
]))
H2("6.5 Preluarea la furnizor — pas cu pas")
phone_block(["a16_furnizor_foto_inainte.png"], "Înainte de început: ce e de ridicat.", bullets([
    "Lista <b>De ridicat</b>: produsul, codul, comanda clientului, cantitatea × prețul de achiziție și "
    "<b>Total achiziție</b> (verificați-l cu factura furnizorului).",
    "Nota dispecerului și a operatorului apar la produs.",
]) + steps([
    "Când ajungeți la furnizor apăsați " + ui("Am ajuns — încep preluarea") + " și confirmați <i>„Începi "
    "preluarea? Lista de produse se blochează până o închizi.”</i>",
]))
phone_block(["a17b_fara_fotografii_ecran.png"], "Preluare în curs: cantitățile confirmate, lipsesc fotografiile.",
            steps([
                "Pentru fiecare produs: " + ui("Am primit tot (N)") + " dacă ați primit toată cantitatea, sau "
                + ui("Altă cantitate") + " (vezi 6.6).",
                "Fotografiați <b>seria</b> sau <b>partida</b>: apăsați pătratul punctat cu aparatul foto („Unitatea N” / „Fotografiază”) — se deschide camera din spate. "
                "Fotografia se micșorează și se trimite automat (<i>„Se trimite… N%”</i>).",
            ], start=2) + bullets([
                "<b>Seria fiecărei unități</b> = câte o fotografie pentru fiecare bucată (eticheta cu S/N).",
                "<b>Partida</b> = o singură fotografie (eticheta lotului).",
                "<i>„Produs fără serie sau partidă: fotografia nu e necesară.”</i>",
                "Butonul de jos rămâne gri — " + ui("Completează cantitățile și fotografiile") + " — până e totul gata. "
                "Contoarele <b>Cantități</b> și <b>Fotografii</b> arată ce mai lipsește.",
            ]))
phone_block(["a18_fotografii_gata.png"], "Totul confirmat: butonul „Închide preluarea” devine verde.", steps([
    "Verificați miniaturile (în colț apare numărul unității cu bifă). Dacă fotografia e neclară apăsați " + ui("Refă") + " și faceți alta.",
    "Apăsați " + ui("Închide preluarea") + " și confirmați <i>„Închizi preluarea? Se creează Intrarea de marfă și "
    "lista nu se mai poate schimba.”</i>",
], start=4), width=4.1 * cm, max_h=12 * cm)
phone_block(["a19_preluare_foto_inchisa.png"], "Preluare închisă.", bullets([
    "Mesajul verde <i>„Preluarea s-a încheiat. Intrare marfă nr. N.”</i> și banda <b>Încărcat · preluare închisă "
    "la HH:MM</b>.",
    "Oprirea devine <b>Terminată</b> și marfa se află acum, în WMS, în depozitul mașinii voastre.",
    "Treceți la oprirea următoare din " + ui("‹ Traseul meu") + ".",
]), width=4.1 * cm, max_h=11 * cm)
H2("6.6 Furnizor cu retur și cantitate lipsă")
phone_block(["a11_furnizor_retur_inainte.png"], "Oprire cu ridicare și retur la furnizor.", bullets([
    "Cardul galben <b>Retur la furnizor</b> arată ce predați furnizorului, cu <b>Total retur</b>.",
    "Începeți preluarea la fel: " + ui("Am ajuns — încep preluarea") + ". Lista blocată cuprinde și ridicările, și "
    "returul.",
]), width=4.1 * cm, max_h=12 * cm)
phone_block(["a13_alta_cantitate.png"], "Altă cantitate: cantitatea primită și motivul.", steps([
    "La produsul cu lipsă apăsați " + ui("Altă cantitate") + ".",
    "Scrieți <b>cantitatea primită</b> (din câte erau planificate) și <b>motivul</b> (lipsă, refuz, defect) — "
    "motivul e obligatoriu când primiți mai puțin.",
    "Apăsați " + ui("Salvează") + ". Rândul arată <b>Primit: N</b> cu punct roșu; " + ui("Modifică") +
    " permite corectarea până la închidere.",
    "La retur apăsați " + ui("Predat tot (N)") + " sau " + ui("Altă cantitate") + " dacă furnizorul a primit mai "
    "puțin. Returul nu cere fotografii.",
    "Închideți preluarea ca mai sus.",
]), width=4.1 * cm, max_h=12 * cm)
phone_block(["a15_preluare_inchisa.png"], "Preluare închisă cu lipsă: oprirea e „Cu probleme”.", bullets([
    "Oprirea devine <b>Cu probleme</b> (punct roșu) — dispecerul vede asta în WMS și replanifică restul.",
    "Intrarea de marfă conține doar cantitatea primită.",
]), width=4.1 * cm, max_h=11 * cm)
H2("6.7 Livrarea la client")
phone_block(["a10_oprire_client.png"], "Oprirea Client: comanda de predat.", bullets([
    "Vedeți comanda: produsele, serviciile (livrare, urcare la etaj) și <b>Total comandă</b> — suma de încasat, "
    "dacă plata e la livrare.",
    ui("Sună") + " — sunați clientul înainte de sosire; " + ui("Hartă") + " — navigarea la adresă.",
    "Eticheta <b>Așteaptă confirmarea dispecerului</b> este normală în această versiune.",
    "În această versiune <b>livrarea nu se confirmă din aplicație</b>: predați marfa, încasați și raportați "
    "dispecerului ca până acum.",
]))
H2("6.8 Mesaje frecvente")
table([
    ["Mesajul din aplicație", "Ce faceți"],
    ["Nu ai un depozit (mașină) asociat. Anunță dispecerul.", "Dispecerul creează depozitul mașinii (2.2)."],
    ["Oprirea a fost anulată de dispecer.", "Nu mai mergeți la această oprire; întrebați dispecerul dacă e nevoie."],
    ["Scrie motivul pentru cantitatea lipsă.", "Completați motivul la „Altă cantitate”."],
    ["Cantitatea trebuie să fie între 0 și N.", "Nu se poate primi mai mult decât e planificat."],
    ["Confirmă cantitatea pentru fiecare produs. / Lipsesc fotografii ale seriilor sau partidelor.",
     "Completați ce lipsește (contoarele de jos) și închideți din nou."],
    ["Dispecerul modifică acum aceste date. Reîncarcă pagina peste câteva secunde.",
     "Așteptați puțin și reîncărcați — dispecerul are deschisă aceeași înregistrare."],
    ["Fără internet. Confirmările sunt posibile doar după reconectare. (bara roșie jos)",
     "Mergeți într-o zonă cu semnal; nimic nu se pierde, dar nici nu se salvează până la reconectare."],
    ["Fotografia nu s-a trimis. Încearcă din nou.", "Repetați fotografia când aveți semnal."],
    ["Traseul nu este publicat. / Nu ai un traseu publicat pentru azi.", "Sunați dispecerul."],
], [9.4 * cm, 8 * cm])

# =====================================================================
story.append(PageBreak())
H1("7. Ce nu face încă această versiune")
para("Prima versiune acoperă planificarea în WMS și preluarea la furnizor pe telefon. Următoarele se fac încă "
     "manual, ca până acum:")
table([
    ["Situația", "Cum se lucrează acum"],
    ["Confirmarea livrării la client (livrat / parțial / eșuat) și încasarea",
     "Șoferul raportează dispecerului; livrarea și plata se marchează în WMS ca până acum."],
    ["Confirmarea încărcării la depozit", "Șoferul verifică marfa după lista „De încărcat”; nu apasă nimic."],
    ["Finalizarea returului 126", "Dispecerul/operatorul îl închide manual în WMS după predare."],
    ["Mutarea mărfii din mașină în depozitul de bază", "Prin transferul obișnuit din WMS."],
    ["Vizualizarea fotografiilor în WMS", "Doar din aplicația șoferului."],
    ["Fișa de traseu tipărită, punctele de preluare ale furnizorilor, curierii impliciți pe zone",
     "Nu există încă; zonele furnizorilor apar ca atenționare în Probleme."],
], [7.4 * cm, 10 * cm])

# =====================================================================
H1("Fișa rapidă")
quick = [
    ["OPERATOR", [
        "Produs de adus: în 107 › rândul produsului › <b>Alege furnizorul</b> (Alt+E) › furnizorul cu stoc › "
        "Comandam prin › Data ridicarii › OK.",
        "Livrare: proprietățile documentului › Livrare › <b>Adauga</b> › Data (obligatoriu), Ora, Adresa.",
        "Retur: documentul 126 ca de obicei — apare singur la dispecer.",
        "Înainte de a anula o ridicare de pe traseu: <b>Scoate soferul</b>.",
    ]],
    ["DISPECER", [
        "Nomenclatoare › <b>Dispecerat: achizitii si livrari</b> › Ziua.",
        "Alege Curierul (și Zona) › selectează rândurile › <b>Atribuie curierului ales</b> — pe Achizitii, Retururi, "
        "Livrari.",
        "Trasee: ordinea opririlor. Probleme: fără erori.",
        "<b>Publica planul</b>; după orice schimbare: <b>Republica planul</b>.",
        "După preluări: închide intrările 106 din depozitele mașinilor, finalizează returul 126, marchează "
        "livrările.",
    ]],
    ["ȘOFER", [
        "Deschide aplicația › <b>Traseul meu</b> › ia opririle în ordine.",
        "Depozit: încarcă după lista „De încărcat”.",
        "Furnizor: <b>Am ajuns — încep preluarea</b> › Am primit tot / Altă cantitate (+ motiv) › fotografii › "
        "<b>Închide preluarea</b>.",
        "Retur: Predat tot / Altă cantitate, la aceeași preluare.",
        "Client: sună, livrează, încasează Total comandă, raportează dispecerului.",
    ]],
]
for title, items in quick:
    t = Table([[P(f'<font name="UI-B" color="white">{title}</font>', "body"), bullets(items)]],
              colWidths=[2.8 * cm, W - 2.8 * cm])
    t.setStyle(TableStyle([("BACKGROUND", (0, 0), (0, 0), BLUE), ("BACKGROUND", (1, 0), (1, 0), LIGHT),
                           ("VALIGN", (0, 0), (-1, -1), "TOP"), ("TOPPADDING", (0, 0), (-1, -1), 7),
                           ("BOTTOMPADDING", (0, 0), (-1, -1), 6), ("LEFTPADDING", (0, 0), (-1, -1), 8)]))
    story.append(t)
    story.append(Spacer(1, 7))

doc.multiBuild(story)
print("PDF:", OUT)
