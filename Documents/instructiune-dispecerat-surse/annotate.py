# Marcaje numerotate pe capturile WMS, dupa pozitiile controalelor salvate de WmsShot (*.txt).
import os
from PIL import Image, ImageDraw, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
SH = os.path.join(HERE, "shots")
OUT = os.path.join(SH, "ann")
os.makedirs(OUT, exist_ok=True)
RED = (220, 38, 38)
F = ImageFont.truetype(r"C:\Windows\Fonts\segoeuib.ttf", 17)


def bounds(txt):
    d = {}
    for line in open(os.path.join(SH, txt), encoding="utf-8-sig", errors="replace"):
        if "=" in line:
            k, v = line.strip().split("=", 1)
            d[k] = tuple(int(x) for x in v.split(","))
    return d


def annotate(png, txt, marks, out=None):
    """marks: lista (numar, control | (x, y, w, h), pozitia bulinei 'l'/'r'/'t')"""
    b = bounds(txt)
    img = Image.open(os.path.join(SH, png)).convert("RGB")
    d = ImageDraw.Draw(img)
    for n, ctl, pos in marks:
        x, y, w, h = b[ctl] if isinstance(ctl, str) else ctl
        d.rounded_rectangle([x - 3, y - 3, x + w + 2, y + h + 2], radius=5, outline=RED, width=3)
        r = 12
        if pos == "l":
            cx, cy = x - 3 - r + 2, y + h // 2
            cx = max(cx, r + 1)
        elif pos == "t":
            cx, cy = x + 14, y - 3 - r + 4
        else:
            cx, cy = x + w + 3 + r - 2, y + h // 2
            cx = min(cx, img.width - r - 1)
        d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=RED, outline="white", width=2)
        d.text((cx, cy), str(n), font=F, fill="white", anchor="mm")
    img.save(os.path.join(OUT, out or png))
    print("ann", out or png)


P = "bx_disp_tsPickups.txt"
annotate("w0_disp_tsPickups.png", P, [
    (1, "deDate", "t"), (2, (236, 78, 312, 15), "r"), (3, "lcbCourier", "r"), (4, (14, 233, 1462, 22), "t"),
    (5, "btnPickupAssign", "r"), (6, "btnPublish", "t")])
annotate("w2_disp_tsPickups.png", P, [(1, (14, 233, 1462, 22), "t")])
annotate("w1_disp_tsPickups.png", P, [(1, (236, 78, 312, 15), "r"), (2, "btnPublish", "t"), (3, "btnRefresh", "t")])
annotate("w3_disp_tsPickups.png", P, [(1, (236, 78, 312, 15), "r"), (2, (1195, 213, 165, 85), "t")])
annotate("w1_disp_tsReturns.png", "bx_disp_tsReturns.txt", [
    (1, "lcbCourier", "r"), (2, "btnReturnAssign", "r"), (3, "btnReturnUnassign", "r")])
annotate("w2_disp_tsDeliveries.png", "bx_disp_tsDeliveries.txt", [
    (1, "lcbCourier", "r"), (2, "lcbZone", "r"), (3, "btnDeliveryAssign", "r"), (4, "btnDeliveryZoneOnly", "r"),
    (5, "btnDeliveryUnassign", "r")])
annotate("w1_disp_tsRoutes.png", "bx_disp_tsRoutes.txt", [
    (1, "cxGridRoutes", "t"), (2, "cxGridStops", "t"), (3, "btnStopUp", "r"), (4, "btnStopDown", "r")])
annotate("w3_disp_tsRoutes.png", "bx_disp_tsRoutes.txt", [(1, "cxGridRoutes", "t"), (2, "cxGridStops", "t")])
annotate("w2_disp_tsProblems.png", "bx_disp_tsProblems.txt", [
    (1, (236, 78, 312, 15), "r"), (2, "cxGridProblems", "t"), (3, "btnPublish", "t")])
annotate("w_curieri.png", "w_curieri.txt", [
    (1, "lcbBaseStock", "t"), (2, "lcbWebUser", "t"), (3, "btnAdd", "t"), (4, "btnCreateStock", "t"),
    (5, "cxGridCouriers", "t"), (6, "btnActivation", "t"), (7, "btnOk", "t")])
annotate("w_zone.png", "w_zone.txt", [(1, "btnAdd", "t"), (2, "cxGridZones", "t"), (3, "btnOk", "t")])
annotate("w_reguli_intermediar.png", "w_reguli_intermediar.txt", [(1, "btnAdd", "t"), (2, "btnOk", "t")])
annotate("w_ridicare_confirmare.png", "w_ridicare_confirmare.txt", [
    (1, "beStockSupplier", "l"), (2, "beOrderSupplier", "l"), (3, "rgPickupFrom", "l"), (4, "seQty", "l"),
    (5, "dePlanDate", "l"), (6, "edNote", "l"), (7, "btnOk", "l")])
L = "bx_disp_ridicari_lista.txt"
annotate("w0_disp_ridicari_lista.png", L, [
    (1, "chkOnlyActive", "t"), (2, "btnModify", "t"), (3, "btnAssignDriver", "t"), (4, "btnClearDriver", "t"),
    (5, "btnPicked", "t"), (6, "btnCancelPickup", "t"), (7, "btnReopen", "t")])
annotate("w3_disp_ridicari_lista.png", L, [])
annotate("w_livrare_document.png", "w_livrare_document.txt", [
    (1, (18, 104, 360, 86), "r"), (2, (6, 251, 96, 25), "r")])
