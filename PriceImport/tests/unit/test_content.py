"""Etapa 4b: continutul din raspunsurile API (regulile Delphi), planul staging-ului, imaginile."""

import hashlib
import io

import httpx
import pytest
import respx
from PIL import Image

from priceimport.adapters import dmlink, nex, olisgrup, triomac
from priceimport.content import desc_changed, plan_staging
from priceimport.content_images import ImageError, ImageFetcher, check_url, to_png
from priceimport.models import ContentItem

PUBLIC = lambda host: ["93.184.216.34"]           # noqa: E731


def sha(text: str) -> bytes:
    return hashlib.sha256(text.encode("utf-8")).digest()


def jpeg(w: int, h: int, color=(200, 10, 10)) -> bytes:
    out = io.BytesIO()
    Image.new("RGB", (w, h), color).save(out, format="JPEG")
    return out.getvalue()


# --- continutul pe furnizori ------------------------------------------------------------

def test_dmlink_content():
    long_url = "https://b2b.dmlink.md/" + "x" * 600
    product = {"sku": "GW-109", "description": "", "shortDescription": "  Scurt  ",
               "images": [["https://b2b.dmlink.md/a.jpg"], ["https://b2b.dmlink.md/a.jpg"], {"src": "https://b/b.jpg"},
                          [long_url], "https://b/c.jpg", None]}
    c = dmlink.content_of(product, "GW-109")
    assert c.desc_ro == "Scurt" and c.desc_ru is None             # DMLink scrie doar romana
    assert c.images == ["https://b2b.dmlink.md/a.jpg", "https://b/b.jpg", "https://b/c.jpg"]


def test_olis_content_table_and_escape():
    product = {"code": "X1", "textRO": "<p>Text</p>", "textRU": "",
               "features": [{"name_RO": "Putere", "value_RO": "2 & 3\"", "name_RU": "Мощность", "value_RU": "2"},
                            {"name_RO": "Gol", "value_RO": ""}],
               "imagini": [" https://m/1.jpg ", "https://m/1.jpg", 5]}
    c = olisgrup.content_of(product, "X1")
    assert c.desc_ro == "<p>Text</p>\r\n<table><tr><td>Putere</td><td>2 &amp; 3&quot;</td></tr></table>"
    assert c.desc_ru == "<table><tr><td>Мощность</td><td>2</td></tr></table>"
    assert c.images == ["https://m/1.jpg", "5"]


def test_nex_content_order_and_urls():
    product = {"code": "NF-1", "description": {"ro": "Desc RO", "ru": ""},
               "attributes": [{"title": {"ro": "Culoare", "ru": ""}, "value": "Alb"},
                              {"title": {"ro": "", "ru": "X"}, "value": "1"}],
               "category": {"title": {"ro": "Frigidere", "ru": "Холодильники"}},
               "main_image": "/storage/a b.jpg",
               "additional_images": ["//cdn.nex/b.jpg", "/storage/a b.jpg", {"x": 1}]}
    c = nex.content_of(product, "NF-1")
    assert c.images == ["https://b2b.nexdistribution.md/storage/a%20b.jpg", "https://cdn.nex/b.jpg"]
    assert c.desc_ro == "Desc RO\r\n<table><tr><td>Culoare</td><td>Alb</td></tr></table>"
    assert c.desc_ru == "<table><tr><td>Culoare</td><td>Alb</td></tr></table>"   # titlul RU lipsa -> RO
    assert c.category == "Frigidere"


def test_triomac_content_rules():
    product = {"sku": "T1", "name": {"ro": "Masina de gaurit", "ru": "Дрель"},
               "description": {"ro": "<p>MASINA de gaurit</p>", "ru": "<b>Описание</b>"},
               "specification": {"ro": "<p>Putere 500 W</p>", "ru": "https://bosch.com/x"},
               "images": [{"url": "https://scop.md/media/1.jpg"}, "https://scop.md/media/2.jpg"]}
    c = triomac.content_of(product, "T1")
    assert c.desc_ro == "<p>Putere 500 W</p>"        # descrierea = denumirea -> nu conteaza
    assert c.desc_ru == "<b>Описание</b>"              # specificatia = doar un link
    assert c.images == ["https://scop.md/media/1.jpg", "https://scop.md/media/2.jpg"]
    both = triomac.content_of({**product, "description": {"ro": "Altceva", "ru": "Altceva"},
                               "specification": {"ro": "Spec", "ru": "Spec"}}, "T1")
    assert both.desc_ro == "Altceva<br>\r\nSpec" and both.desc_ru == ""   # RU identic cu RO nu se scrie


# --- planul staging-ului ----------------------------------------------------------------

def test_plan_staging():
    contents = [ContentItem("A", desc_ro="text nou", images=["u1", "u2"]),       # lista schimbata
                ContentItem("B", desc_ro="la fel", images=["u3"]),               # neschimbat, descarcat
                ContentItem("C", desc_ro="", images=["u4"]),                     # neschimbat, nedescarcat
                ContentItem("D", desc_ro="", images=[])]                         # furnizorul nu are nimic
    desc_state = {"A": (sha("vechi"), sha(""), None), "B": (sha("la fel"), sha("ceva rus"), None),
                  "D": (sha("ramine"), sha(""), None)}
    lists = {"A": (["u1"], False), "B": (["u3"], False), "C": (["u4"], True), "D": (["u9"], True)}
    descs, changed, pending = plan_staging(contents, desc_state, lists)
    assert [c.code for c in descs] == ["A"]          # B: acelasi text; RU (None) nu se compara la DMLink
    assert [c.code for c in changed] == ["A"]
    assert pending == {"A": ["u1", "u2"], "C": ["u4"]}   # D: fara imagini de la furnizor -> nu se atinge


def test_desc_changed_category_and_ru():
    item = ContentItem("N", desc_ro="ro", desc_ru="ru", category="Frigidere")
    assert not desc_changed(item, (sha("ro"), sha("ru"), "Frigidere"))
    assert desc_changed(item, (sha("ro"), sha("ru"), None))
    assert desc_changed(item, (sha("ro"), sha(""), "Frigidere"))
    assert desc_changed(item, None)


# --- imaginile ----------------------------------------------------------------------------

def test_to_png_shrinks_and_converts():
    png = to_png(jpeg(3000, 1500))
    with Image.open(io.BytesIO(png)) as im:
        assert im.format == "PNG" and im.size == (1200, 600)
    small = to_png(jpeg(300, 200))
    with Image.open(io.BytesIO(small)) as im:
        assert im.size == (300, 200)                  # imaginile mici nu se maresc
    with pytest.raises(ImageError):
        to_png(b"<html>not found</html>")


def test_check_url_blocks_private_and_schemes():
    check_url("https://b2b.dmlink.md/a.jpg", PUBLIC)
    for url, resolve in [("ftp://x/a.jpg", PUBLIC), ("file:///etc/passwd", PUBLIC),
                         ("http://intern/a.jpg", lambda h: ["192.168.106.254"]),
                         ("http://local/a.jpg", lambda h: ["127.0.0.1"]),
                         ("http://meta/a.jpg", lambda h: ["169.254.169.254"]), ("http://v6/a.jpg", lambda h: ["::1"])]:
        with pytest.raises(ImageError):
            check_url(url, resolve)


@respx.mock
def test_fetcher_retries_and_redirect_guard():
    good = jpeg(50, 40)
    respx.get("https://img.test/a.jpg").mock(side_effect=[httpx.Response(503), httpx.Response(200, content=good)])
    respx.get("https://img.test/missing.jpg").mock(return_value=httpx.Response(404))
    respx.get("https://img.test/redir.jpg").mock(return_value=httpx.Response(302, headers={"location": "http://intern/x"}))
    sleeps = []

    def resolve(host):
        return ["10.0.0.5"] if host == "intern" else ["93.184.216.34"]

    with ImageFetcher(resolve=resolve, sleep=sleeps.append) as fetcher:
        r = fetcher.fetch_code("C1", ["https://img.test/a.jpg", "https://img.test/missing.jpg",
                                      "https://img.test/redir.jpg"])
    assert r.n_ok == 1 and r.images[1] is None and r.images[2] is None
    assert sleeps == [1.0]                             # 503 reincercat, 404 si redirectul privat nu
    assert any("HTTP 404" in e for e in r.errors) and any("nepublica" in e for e in r.errors)
    assert r.bytes_in == len(good)
