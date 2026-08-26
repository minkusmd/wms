# -*- coding: utf-8 -*-
"""Extrage pana la 3 imagini per candidat, ca sa pot alege vizual cadrul potrivit
(pentru produsele TRAY se prefera poza cipului, nu a cutiei)."""
import firebird.driver as fb
from PIL import Image, ImageDraw
import io, json

plan = json.load(io.open('img_plan.json', encoding='utf-8'))
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor()

thumbs, index = [], {}
for gid_s, p in sorted(plan.items()):
    src = p['src_gid']
    cur.execute("""SELECT FIRST 3 GOODS_IMAGE_ID, IMAGE FROM TS_GOODS_IMAGE
                   WHERE GOODSID=? AND SUBSTRING(IMAGE FROM 2 FOR 3)='PNG' ORDER BY ORDERNO""", (src,))
    for iid, blob in cur.fetchall():
        raw = blob.read() if hasattr(blob, 'read') else blob
        im = Image.open(io.BytesIO(raw)).convert('RGB')
        im.thumbnail((210, 210))
        label = "%s.%s" % (gid_s, iid)
        thumbs.append((label, im))
        index[label] = dict(target=int(gid_s), src_gid=src, src_iid=iid)
con.close()

json.dump(index, io.open('img_index.json', 'w', encoding='utf-8'), indent=1)
cols, cell, per = 8, 220, 32
pages = (len(thumbs) + per - 1) // per
for page in range(pages):
    chunk = thumbs[page * per:(page + 1) * per]
    rows = (len(chunk) + cols - 1) // cols
    sheet = Image.new('RGB', (cols * cell, rows * (cell + 18)), 'white')
    d = ImageDraw.Draw(sheet)
    for i, (name, im) in enumerate(chunk):
        x, y = (i % cols) * cell, (i // cols) * (cell + 18)
        sheet.paste(im, (x + (cell - im.width) // 2, y + 18 + (cell - 18 - im.height) // 2))
        d.text((x + 3, y + 3), name, fill='black')
    sheet.save('pick3_%d.png' % (page + 1))
print('thumbs', len(thumbs), 'pages', pages)
