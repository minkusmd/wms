# -*- coding: utf-8 -*-
"""Legatura produs -> produs Ultra, dintr-o singura interogare (varianta pe produs
era prea lenta la cataloage mari)."""
import firebird.driver as fb, io, json, sys

GT = int(sys.argv[1]) if len(sys.argv) > 1 else 319
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor()
cur.execute("""
SELECT g.GOODSID, g.TITLE, MIN(TRIM(pi.SUPPLIER_GOODS_CODE)) COD,
       COUNT(DISTINCT TRIM(pi.SUPPLIER_GOODS_CODE)) NCOD
FROM TS_GOODS g
JOIN TS_PRICELIST_ITEMS pi ON pi.GOODSID = g.GOODSID
JOIN TS_PRICELISTS pl ON pl.PLID = pi.PLID AND pl.SUPPLIERID = 202294
WHERE g.WEBGOODSTYPE_ID = ? AND COALESCE(g.FLG_FOLDER,0) = 0
  AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID = g.GOODSID)
GROUP BY g.GOODSID, g.TITLE""", (GT,))
rows = cur.fetchall()

link = {}
for gid, title, cod, ncod in rows:
    if not cod:
        continue
    cur.execute("SELECT UUID FROM TS_ULTRA2_PRODUCT WHERE CODE=?", (cod,))
    r = cur.fetchone()
    if not r:
        continue
    cur.execute("SELECT COUNT(*) FROM TS_ULTRA2_PROPERTY_VALUE WHERE PRODUCT_UUID=?", (r[0],))
    n = cur.fetchone()[0]
    if n:
        link[gid] = dict(code=cod, uuid=r[0].strip(), nprop=n, ncodes=ncod, title=title)

json.dump({str(k): v for k, v in link.items()},
          io.open('ultra_link_%d.json' % GT, 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
print('produse cu pozitie Ultra:', len(rows), '| cu proprietati:', len(link),
      '| media prop: %.1f' % (sum(v['nprop'] for v in link.values()) / max(len(link), 1)),
      '| coduri ambigue:', sum(1 for v in link.values() if v['ncodes'] > 1))
con.close()
