"""Faza B: descarca imaginea oficiala a fiecarui model de anvelopa fara donor in baza.

Intrare: image_urls.json  {"<nr>": {"brand", "model", "page", "image", ...}}
Iesire:  imgs/<nr>.png (PNG, max 1200 px, transparenta pastrata) + sheet.png (plansa de
         verificare cu numarul, brandul, modelul si cite produse primesc imaginea).
Nu scrie nimic in baza.
"""
import io
import json
import os
import sys

import requests
from PIL import Image, ImageDraw, ImageFont

import analyze

HERE = os.path.dirname(os.path.abspath(__file__))
MAX_SIDE = 1200
UA = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
                    'Chrome/140.0 Safari/537.36'}


def targets_by_model():
    """(brand, model_key) -> [goodsid] pentru produsele din plan fara donor."""
    plan = json.load(io.open(os.path.join(HERE, 'tyres_plan_final.json'), encoding='utf-8'))
    out = {}
    for t in plan:
        if not t.get('donor'):
            key = (analyze.norm_brand(t['vendor']), analyze.model_key(t.get('model')))
            out.setdefault(key, []).append(t['goodsid'])
    return out


def to_png(data):
    im = Image.open(io.BytesIO(data))
    im.load()
    if im.mode not in ('RGB', 'RGBA'):
        im = im.convert('RGBA' if 'transparency' in im.info or im.mode in ('P', 'LA') else 'RGB')
    im.thumbnail((MAX_SIDE, MAX_SIDE), Image.LANCZOS)
    buf = io.BytesIO()
    im.save(buf, 'PNG', optimize=True)
    return buf.getvalue(), im


def main():
    urls = json.load(io.open(os.path.join(HERE, 'image_urls.json'), encoding='utf-8'))
    groups = targets_by_model()
    os.makedirs(os.path.join(HERE, 'imgs'), exist_ok=True)
    tiles, report = [], {}
    for nr, it in sorted(urls.items(), key=lambda kv: int(kv[0])):
        key = (analyze.norm_brand(it['brand']), analyze.model_key(it['model']))
        goods = groups.get(key, [])
        entry = {'brand': it['brand'], 'model': it['model'], 'goods': goods, 'file': None, 'error': None}
        if not it.get('image'):
            entry['error'] = 'fara url: ' + (it.get('note') or '')
        else:
            try:
                r = requests.get(it['image'], headers=dict(UA, Referer=it.get('page') or ''), timeout=40)
                r.raise_for_status()
                png, im = to_png(r.content)
                path = os.path.join(HERE, 'imgs', '%s.png' % nr)
                open(path, 'wb').write(png)
                entry['file'] = path
                entry['size'] = '%dx%d %dKB' % (im.width, im.height, len(png) // 1024)
                tiles.append((nr, it, goods, im))
            except Exception as e:  # noqa: BLE001 - raportam orice esec de descarcare
                entry['error'] = '%s: %s' % (type(e).__name__, str(e)[:120])
        report[nr] = entry
        print(nr, it['brand'], it['model'], '->', entry.get('size') or entry['error'], '| produse:', len(goods))

    json.dump(report, io.open(os.path.join(HERE, 'images_report.json'), 'w', encoding='utf-8'),
              ensure_ascii=False, indent=1)

    # plansa de verificare: 5 pe rand, 260x300 per celula
    cols, cw, ch = 5, 260, 300
    rows = (len(tiles) + cols - 1) // cols or 1
    sheet = Image.new('RGB', (cols * cw, rows * ch), 'white')
    draw = ImageDraw.Draw(sheet)
    try:
        font = ImageFont.truetype('arial.ttf', 13)
    except OSError:
        font = ImageFont.load_default()
    for i, (nr, it, goods, im) in enumerate(tiles):
        x, y = (i % cols) * cw, (i // cols) * ch
        thumb = im.copy()
        thumb.thumbnail((cw - 20, ch - 70))
        bg = Image.new('RGB', thumb.size, 'white')
        bg.paste(thumb, mask=thumb.split()[-1] if thumb.mode == 'RGBA' else None)
        sheet.paste(bg, (x + (cw - thumb.width) // 2, y + 8))
        draw.text((x + 8, y + ch - 56), '#%s %s' % (nr, it['brand']), fill='black', font=font)
        draw.text((x + 8, y + ch - 38), it['model'][:30], fill='black', font=font)
        draw.text((x + 8, y + ch - 20), '%d produse' % len(goods), fill='gray', font=font)
        draw.rectangle([x + 2, y + 2, x + cw - 2, y + ch - 2], outline='#cccccc')
    sheet.save(os.path.join(HERE, 'sheet.png'))
    print('plansa:', os.path.join(HERE, 'sheet.png'))


if __name__ == '__main__':
    sys.exit(main())
