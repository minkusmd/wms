# -*- coding: utf-8 -*-
"""Citeste inapoi din baza imaginile inserate la frigidere si le compara cu fisierele."""
import firebird.driver as fb
from PIL import Image, ImageDraw
import io, json, hashlib, re

CHOICE = {}
for line in io.open('img_319_apply.py', encoding='utf-8'):
    for m in re.finditer(r'(\d{6}): (\d)', line):
        CHOICE[int(m.group(1))] = int(m.group(2))

res = json.load(io.open('img319_resolved.json', encoding='utf-8'))
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('verify_img319.txt', 'w', encoding='utf-8')

bad, thumbs = [], []
for gid, idx in sorted(CHOICE.items()):
    cur.execute("SELECT IMAGE FROM TS_GOODS_IMAGE WHERE GOODSID=? ORDER BY ORDERNO", (gid,))
    row = cur.fetchone()
    if not row:
        bad.append((gid, 'fara imagine in baza')); continue
    data = row[0].read() if hasattr(row[0], 'read') else row[0]
    img = next((i for i in res[str(gid)]['images'] if i['idx'] == idx), None)
    local = open(img['path'], 'rb').read()
    if hashlib.md5(data).hexdigest() != hashlib.md5(local).hexdigest():
        bad.append((gid, 'octeti diferiti'))
    im = Image.open(io.BytesIO(data)).convert('RGB'); im.thumbnail((150, 150))
    thumbs.append((str(gid), im))
out.write("imagini verificate: %d; probleme: %s\n" % (len(CHOICE), bad))

cur.execute("""SELECT COUNT(*) FROM TS_GOODS_IMAGE i JOIN TS_GOODS g ON g.GOODSID=i.GOODSID
               WHERE g.WEBGOODSTYPE_ID=319 AND i.CREATED_DATE >= CURRENT_DATE""")
out.write("imagini de frigider create azi: %d\n" % cur.fetchone()[0])
out.close(); con.close()

cols, cell = 10, 160
rows_n = (len(thumbs) + cols - 1) // cols
sheet = Image.new('RGB', (cols * cell, max(rows_n, 1) * (cell + 15)), 'white'); d = ImageDraw.Draw(sheet)
for i, (name, im) in enumerate(thumbs):
    x, y = (i % cols) * cell, (i // cols) * (cell + 15)
    sheet.paste(im, (x + (cell - im.width) // 2, y + 15 + (cell - 15 - im.height) // 2))
    d.text((x + 2, y + 2), name, fill='black')
sheet.save('verify_img319_sheet.png')
print('verificate', len(thumbs), 'bad', len(bad))
