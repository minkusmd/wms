# -*- coding: utf-8 -*-
"""Alege imaginea sursa pentru fiecare tinta si construieste planse de verificare vizuala."""
import firebird.driver as fb
from PIL import Image, ImageDraw
import io, json

match = json.load(io.open('img_match.json', encoding='utf-8'))
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor()

plan, thumbs = {}, []
for gid_s, d in match.items():
    # candidatul cu cele mai multe imagini; la egalitate, cel mai nou
    cands = sorted(d['cands'], key=lambda c: (-c[2], -c[0]))
    src_gid = cands[0][0]
    cur.execute("""SELECT FIRST 1 GOODS_IMAGE_ID, IMAGE FROM TS_GOODS_IMAGE
                   WHERE GOODSID=? AND SUBSTRING(IMAGE FROM 2 FOR 3)='PNG' ORDER BY ORDERNO""", (src_gid,))
    row = cur.fetchone()
    if not row:
        continue
    iid, blob = row[0], row[1]
    raw = blob.read() if hasattr(blob, 'read') else blob
    im = Image.open(io.BytesIO(raw))
    plan[gid_s] = dict(src_gid=src_gid, src_iid=iid, src_title=cands[0][1],
                       title=d['title'], kb=len(raw) // 1024, size=list(im.size))
    t = im.convert('RGB'); t.thumbnail((260, 260))
    thumbs.append(("%s<-%s" % (gid_s, src_gid), t))
con.close()

json.dump(plan, io.open('img_plan.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
cols, cell, per = 6, 270, 18
for page in range((len(thumbs) + per - 1) // per):
    chunk = thumbs[page * per:(page + 1) * per]
    rows = (len(chunk) + cols - 1) // cols
    sheet = Image.new('RGB', (cols * cell, rows * (cell + 20)), 'white')
    d = ImageDraw.Draw(sheet)
    for i, (name, im) in enumerate(chunk):
        x, y = (i % cols) * cell, (i // cols) * (cell + 20)
        sheet.paste(im, (x + (cell - im.width) // 2, y + 20 + (cell - 20 - im.height) // 2))
        d.text((x + 4, y + 4), name, fill='black')
    sheet.save('plan_sheet%d.png' % (page + 1))
print('plan', len(plan), 'sheets', (len(thumbs) + per - 1) // per)
