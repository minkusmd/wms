# -*- coding: utf-8 -*-
"""Descarca de pe CDN-ul Ultra primele cadre PNG pentru frigiderele fara imagine."""
import firebird.driver as fb
from PIL import Image, ImageDraw
import io, json, os, urllib.request

GT = 319
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('img_319_fetch.txt', 'w', encoding='utf-8')

cur.execute("""SELECT g.GOODSID, g.TITLE FROM TS_GOODS g
 WHERE g.WEBGOODSTYPE_ID=? AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)
 AND NOT EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID) ORDER BY g.GOODSID""", (GT,))
targets = cur.fetchall()
out.write("frigidere fara imagine: %d\n" % len(targets))

os.makedirs('img319', exist_ok=True)
resolved, thumbs, fara = {}, [], []
for gid, title in targets:
    cur.execute("""SELECT DISTINCT TRIM(pi.SUPPLIER_GOODS_CODE) FROM TS_PRICELIST_ITEMS pi
                   JOIN TS_PRICELISTS pl ON pl.PLID=pi.PLID AND pl.SUPPLIERID=202294
                   WHERE pi.GOODSID=?""", (gid,))
    codes = [c[0] for c in cur if c[0]]
    if not codes:
        fara.append((gid, title, 'fara cod Ultra')); continue
    cur.execute("SELECT UUID FROM TS_ULTRA_NOMENCLATURE WHERE CODE=?", (codes[0],))
    row = cur.fetchone()
    if not row:
        fara.append((gid, title, 'cod %s negasit' % codes[0])); continue
    cur.execute("""SELECT PATH_GLOBAL FROM TS_ULTRA_NOMENCLATURE_IMAGE
                   WHERE NOMENCLATURE_UUID=? AND COALESCE(DELETION_MARK,0)=0 ORDER BY ID""", (row[0],))
    urls = [u[0] for u in cur if u[0] and u[0].lower().endswith('.png')]
    if not urls:
        fara.append((gid, title, 'fara imagini PNG la Ultra')); continue
    got = []
    for k, url in enumerate(urls[:2]):
        path = 'img319/%s_%d.png' % (gid, k + 1)
        try:
            req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
            with urllib.request.urlopen(req, timeout=30) as rq:
                data = rq.read()
            if data[:8] != b'\x89PNG\r\n\x1a\n':
                continue
            open(path, 'wb').write(data)
            im = Image.open(io.BytesIO(data))
            got.append(dict(idx=k + 1, url=url, path=path, kb=len(data) // 1024, size=list(im.size)))
            t = im.convert('RGB'); t.thumbnail((165, 165))
            thumbs.append(("%s.%d" % (gid, k + 1), t))
        except Exception as e:
            out.write("  %s eroare: %s\n" % (gid, type(e).__name__))
    if got:
        resolved[gid] = dict(code=codes[0], title=title, images=got)
    else:
        fara.append((gid, title, 'descarcare esuata'))

json.dump({str(k): v for k, v in resolved.items()},
          io.open('img319_resolved.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
out.write("rezolvate: %d; fara sursa: %d\n" % (len(resolved), len(fara)))
for gid, title, why in fara:
    out.write("   %s  %-28s %s\n" % (gid, why, (title or '')[:60]))
out.close(); con.close()

cols, cell = 10, 175
rows_n = (len(thumbs) + cols - 1) // cols
sheet = Image.new('RGB', (cols * cell, max(rows_n, 1) * (cell + 16)), 'white'); d = ImageDraw.Draw(sheet)
for i, (name, im) in enumerate(thumbs):
    x, y = (i % cols) * cell, (i // cols) * (cell + 16)
    sheet.paste(im, (x + (cell - im.width) // 2, y + 16 + (cell - 16 - im.height) // 2))
    d.text((x + 2, y + 3), name, fill='black')
sheet.save('img319_sheet.png')
print('rezolvate', len(resolved), 'thumbs', len(thumbs))
