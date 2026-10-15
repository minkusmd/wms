# Capturi ale aplicatiei CurieriWMS (instanta izolata curieridoc, port 8092, baza de test).
import os, sys, time
from PIL import Image, ImageDraw, ImageFont
from playwright.sync_api import sync_playwright

BASE = "http://localhost:8092"
OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "shots")
os.makedirs(OUT, exist_ok=True)
CODE = sys.argv[1] if len(sys.argv) > 1 else "12345678"


def make_label(path, title, serial):
    img = Image.new("RGB", (1200, 900), (236, 233, 226))
    d = ImageDraw.Draw(img)
    d.rectangle([150, 160, 1050, 740], fill="white", outline=(60, 60, 60), width=4)
    try:
        f1 = ImageFont.truetype("arialbd.ttf", 54)
        f2 = ImageFont.truetype("arial.ttf", 44)
    except OSError:
        f1 = f2 = ImageFont.load_default()
    d.text((200, 200), title, fill="black", font=f1)
    x = 200
    import random
    random.seed(serial)
    while x < 1000:
        w = random.choice([4, 6, 10])
        d.rectangle([x, 320, x + w, 520], fill="black")
        x += w + random.choice([4, 6, 8])
    d.text((200, 560), serial, fill="black", font=f2)
    d.text((200, 640), "Made in EU", fill=(90, 90, 90), font=f2)
    img.save(path, "JPEG", quality=85)


def settle(page, ms=700):
    page.wait_for_load_state("networkidle")
    page.wait_for_timeout(ms)


def shot(page, name, full=False):
    settle(page)
    if full:
        for _ in range(5):
            try:
                page.evaluate("window.scrollTo(0, 0)")
                break
            except Exception:
                page.wait_for_timeout(1000)
                settle(page)
        page.wait_for_timeout(300)
    page.screenshot(path=os.path.join(OUT, name + ".png"), full_page=full)
    print("shot", name)


with sync_playwright() as p:
    b = p.chromium.launch()
    ctx = b.new_context(viewport={"width": 390, "height": 844}, device_scale_factor=2,
                        is_mobile=True, has_touch=True, locale="ro-RO")
    page = ctx.new_page()
    page.on("dialog", lambda d: d.accept())

    SKIP = os.path.exists(os.path.join(OUT, "a04_traseu_gol.png"))
    if SKIP:
        page.goto(BASE + "/autentificare")
    # 1. Autentificare
    if not SKIP:
        page.goto(BASE + "/autentificare")
        shot(page, "a01_login")
        page.fill("#login", "turcanu")
        page.fill("#password", "gresit")
        page.click("button[type=submit]")
        shot(page, "a02_login_error")

        # 2. Activare (serghei)
        page.goto(BASE + "/activare")
        page.fill("#login", "serghei")
        page.fill("#code", CODE)
        page.fill("#password", "parola456")
        page.fill("#password_confirmation", "parola456")
        shot(page, "a03_activare")
        page.click("button[type=submit]")
        shot(page, "a04_traseu_gol")
        page.get_by_role("button", name="Ieșire").click()
        settle(page)

    # 3. Traseul meu (turcanu)
    page.goto(BASE + "/autentificare")
    page.fill("#login", "turcanu")
    page.fill("#password", "parola123")
    shot(page, "a05_login_filled")
    page.click("button[type=submit]")
    page.wait_for_url(BASE + "/")
    shot(page, "a06_traseu_toate", full=True)
    page.goto(BASE + "/?f=achizitii")
    shot(page, "a07_traseu_achizitii", full=True)
    page.goto(BASE + "/?f=livrari")
    shot(page, "a08_traseu_livrari", full=True)

    # 4. Opriri doar de citit
    page.goto(BASE + "/oprire/1")
    shot(page, "a09_oprire_depozit", full=True)
    page.goto(BASE + "/oprire/4")
    shot(page, "a10_oprire_client", full=True)

    # 5. Oprirea 3: furnizor cu retur
    page.goto(BASE + "/oprire/3")
    shot(page, "a11_furnizor_retur_inainte", full=True)
    page.get_by_role("button", name="Am ajuns").click()
    shot(page, "a12_preluare_inceputa", full=True)
    page.get_by_role("button", name="Altă cantitate").first.click()
    settle(page)
    page.locator("input[id^=qty-]").fill("1")
    page.locator("input[id^=note-]").fill("Al doilea ceainic lipsa la depozit")
    shot(page, "a13_alta_cantitate", full=True)
    page.get_by_role("button", name="Salvează").click()
    settle(page)
    page.get_by_role("button", name="Predat tot").first.click()
    shot(page, "a14_cantitati_confirmate", full=True)
    page.get_by_role("button", name="Închide preluarea").click()
    shot(page, "a15_preluare_inchisa", full=True)

    # 6. Oprirea 2: furnizor cu fotografii
    page.goto(BASE + "/oprire/2")
    shot(page, "a16_furnizor_foto_inainte", full=True)
    page.get_by_role("button", name="Am ajuns").click()
    settle(page)
    page.get_by_role("button", name="Am primit tot").first.click()
    settle(page)
    page.get_by_role("button", name="Am primit tot").first.click()
    shot(page, "a17_fara_fotografii", full=True)
    page.screenshot(path=os.path.join(OUT, "a17b_fara_fotografii_ecran.png"))
    labels = [("Frigider FR-178", "S/N: FR178-26-004517"), ("Masina de spalat MS-8", "LOT: MS8-2609-B")]
    for i, (t, s) in enumerate(labels):
        lp = os.path.join(OUT, f"label{i}.jpg")
        make_label(lp, t, s)
        page.locator("input[type=file]").first.set_input_files(lp)
        page.wait_for_timeout(2500)
        settle(page, 1500)
    shot(page, "a18_fotografii_gata", full=True)
    page.screenshot(path=os.path.join(OUT, "a18b_fotografii_gata_ecran.png"))
    page.get_by_role("button", name="Închide preluarea").click()
    shot(page, "a19_preluare_foto_inchisa", full=True)

    # 7. Traseul dupa lucru
    page.goto(BASE + "/")
    shot(page, "a20_traseu_dupa", full=True)
    b.close()
