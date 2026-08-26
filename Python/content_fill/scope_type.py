# -*- coding: utf-8 -*-
"""Starea continutului pentru un tip de produs (parametru: GOODSTYPEID)."""
import firebird.driver as fb, io, sys, json

GT = int(sys.argv[1]) if len(sys.argv) > 1 else 319
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('scope_%d.txt' % GT, 'w', encoding='utf-8')

cur.execute("SELECT GOODSTYPEID, TITLE, TITLE_RUS FROM TS_GOODS_TYPE WHERE GOODSTYPEID=?", (GT,))
row = cur.fetchone()
out.write("tip %s: %s / %s\n\n" % (row[0], (row[1] or '').strip(), (row[2] or '').strip()))

BASE = """FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=%d AND COALESCE(g.FLG_FOLDER,0)=0""" % GT
INPRICE = " AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)"
cur.execute("SELECT COUNT(*) " + BASE)
out.write("produse de acest tip (total): %d\n" % cur.fetchone()[0])
cur.execute("SELECT COUNT(*) " + BASE + INPRICE)
tot = cur.fetchone()[0]
out.write("in price (TWEB_CACHE_GOODS): %d\n\n" % tot)

CHECKS = [('fara imagine', "NOT EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID)"),
          ('fara caracteristici (TS_GOODS_DESCRIPTIONS)', "NOT EXISTS(SELECT 1 FROM TS_GOODS_DESCRIPTIONS d WHERE d.GOODSID=g.GOODSID)"),
          ('fara descriere proza (TS_GOODS_DSC)', "NOT EXISTS(SELECT 1 FROM TS_GOODS_DSC d WHERE d.GOODSID=g.GOODSID)")]
for lbl, cond in CHECKS:
    cur.execute("SELECT COUNT(*) " + BASE + INPRICE + " AND " + cond)
    out.write("  %-46s %d\n" % (lbl, cur.fetchone()[0]))

cur.execute("""SELECT AVG(n), MIN(n), MAX(n) FROM (SELECT COUNT(*) n FROM TS_GOODS_DESCRIPTIONS d
 JOIN TS_GOODS g ON g.GOODSID=d.GOODSID WHERE g.WEBGOODSTYPE_ID=%d
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID) GROUP BY d.GOODSID)""" % GT)
out.write("\ncaracteristici per produs (la cele care au): media %s min %s max %s\n" % cur.fetchone())

# legatura Ultra
cur.execute("""SELECT g.GOODSID, g.TITLE """ + BASE + INPRICE + " ORDER BY g.GOODSID")
goods = cur.fetchall()
link = {}
for gid, title in goods:
    cur.execute("""SELECT DISTINCT pi.SUPPLIER_GOODS_CODE FROM TS_PRICELIST_ITEMS pi
                   JOIN TS_PRICELISTS pl ON pl.PLID=pi.PLID
                   WHERE pi.GOODSID=? AND pl.SUPPLIERID=202294""", (gid,))
    codes = sorted({(r[0] or '').strip() for r in cur if r[0]})
    if not codes:
        continue
    cur.execute("SELECT UUID FROM TS_ULTRA2_PRODUCT WHERE CODE=?", (codes[0],))
    r = cur.fetchone()
    if not r:
        continue
    cur.execute("SELECT COUNT(*) FROM TS_ULTRA2_PROPERTY_VALUE WHERE PRODUCT_UUID=?", (r[0],))
    n = cur.fetchone()[0]
    if n:
        link[gid] = dict(code=codes[0], uuid=r[0].strip(), nprop=n, title=title)
out.write("cu date Ultra: %d din %d (media %.1f proprietati)\n"
          % (len(link), tot, sum(v['nprop'] for v in link.values()) / max(len(link), 1)))
json.dump({str(k): v for k, v in link.items()},
          io.open('ultra_link_%d.json' % GT, 'w', encoding='utf-8'), ensure_ascii=False, indent=1)

# ce caracteristici se folosesc deja la acest tip
cur.execute("""SELECT d.FILTERID, f.FILTERNAME, f.FILTERNAME_RUS, COUNT(*) n
               FROM TS_GOODS_DESCRIPTIONS d JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
               JOIN TS_FILTERS f ON f.FILTERID=d.FILTERID
               WHERE g.WEBGOODSTYPE_ID=%d GROUP BY 1,2,3 ORDER BY 4 DESC""" % GT)
out.write("\nFILTERID folosite deja la acest tip (top 40):\n")
for fid, nm, nru, n in cur.fetchall()[:40]:
    out.write("  %-6s %-44s %d\n" % (fid, (nm or '').strip()[:44], n))
out.close(); con.close()
print('tip', GT, 'in price', tot, 'ultra', len(link))
