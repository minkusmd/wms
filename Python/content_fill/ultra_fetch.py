# -*- coding: utf-8 -*-
"""Rezolva nomenclatura Ultra pentru procesoarele ramase fara imagine si descarca
primele cadre PNG de pe CDN-ul Ultra, pentru verificare vizuala."""
import firebird.driver as fb
from PIL import Image, ImageDraw
import io, json, os, urllib.request

REST = [279159, 335686, 367016, 369178, 369182, 373186, 373189, 379900, 392639, 399971, 402317]
# cele fara pozitie de furnizor: potrivire manuala pe model
MANUAL = {402317: '226329'}          # Core Ultra 7 265K, acelasi cod ca 373189

con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('ultra_fetch.txt', 'w', encoding='utf-8')

def ultra_code(gid):
    if gid in MANUAL:
        return MANUAL[gid]
    cur.execute("""SELECT DISTINCT pi.SUPPLIER_GOODS_CODE FROM TS_PRICELIST_ITEMS pi
                   JOIN TS_PRICELISTS pl ON pl.PLID=pi.PLID
                   WHERE pi.GOODSID=? AND pl.SUPPLIERID=202294""", (gid,))
    rows = [r[0].strip() for r in cur if r[0]]
    return rows[0] if len(set(rows)) == 1 else (rows[0] if rows else None)

resolved, thumbs = {}, []
os.makedirs('ultra_img', exist_ok=True)
for gid in REST:
    code = ultra_code(gid)
    cur.execute("SELECT TITLE FROM TS_GOODS WHERE GOODSID=?", (gid,))
    title = cur.fetchone()[0]
    if not code:
        out.write("%s: FARA cod Ultra   %s\n" % (gid, title[:70])); continue
    cur.execute("SELECT UUID, NAME FROM TS_ULTRA_NOMENCLATURE WHERE CODE=?", (code,))
    row = cur.fetchone()
    if not row:
        out.write("%s: cod %s negasit in TS_ULTRA_NOMENCLATURE\n" % (gid, code)); continue
    uuid, uname = row[0], row[1]
    cur.execute("""SELECT PATH_GLOBAL FROM TS_ULTRA_NOMENCLATURE_IMAGE
                   WHERE NOMENCLATURE_UUID=? AND COALESCE(DELETION_MARK,0)=0 ORDER BY ID""", (uuid,))
    urls = [u[0] for u in cur if u[0] and u[0].lower().endswith('.png')]
    out.write("%s: cod=%s imagini=%d  ultra=%s\n" % (gid, code, len(urls), (uname or '')[:66]))
    got = []
    for k, url in enumerate(urls[:3]):
        path = 'ultra_img/%s_%d.png' % (gid, k + 1)
        try:
            req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
            with urllib.request.urlopen(req, timeout=30) as r:
                data = r.read()
            if data[:8] != b'\x89PNG\r\n\x1a\n':
                out.write("      nu e PNG: %s\n" % url); continue
            open(path, 'wb').write(data)
            im = Image.open(io.BytesIO(data))
            got.append(dict(idx=k + 1, url=url, path=path, kb=len(data) // 1024, size=list(im.size)))
            t = im.convert('RGB'); t.thumbnail((200, 200))
            thumbs.append(("%s.%d" % (gid, k + 1), t))
        except Exception as e:
            out.write("      eroare download: %s %s\n" % (type(e).__name__, e))
    resolved[gid] = dict(code=code, uuid=uuid.strip(), ultra_name=uname, title=title, images=got)

json.dump({str(k): v for k, v in resolved.items()},
          io.open('ultra_resolved.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
out.write("\nrezolvate: %d / %d\n" % (len(resolved), len(REST)))
out.close(); con.close()

cols, cell = 8, 210
rows_n = (len(thumbs) + cols - 1) // cols
sheet = Image.new('RGB', (cols * cell, rows_n * (cell + 18)), 'white'); d = ImageDraw.Draw(sheet)
for i, (name, im) in enumerate(thumbs):
    x, y = (i % cols) * cell, (i // cols) * (cell + 18)
    sheet.paste(im, (x + (cell - im.width) // 2, y + 18 + (cell - 18 - im.height) // 2))
    d.text((x + 3, y + 3), name, fill='black')
sheet.save('ultra_sheet.png')
print('resolved', len(resolved), 'thumbs', len(thumbs))
