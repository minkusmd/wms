# -*- coding: utf-8 -*-
"""Ce am scris de fapt in baza pentru procesoare: filtre? descrieri? imagini?"""
import firebird.driver as fb, io
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('check_filters.txt', 'w', encoding='utf-8')
r = lambda b: (b.read() if hasattr(b, 'read') else b) or ''

INPRICE = "EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)"
BASE = "FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0 AND " + INPRICE

cur.execute("SELECT COUNT(*) " + BASE)
out.write("CPU in price: %d\n" % cur.fetchone()[0])
for lbl, cond in [('cu filtre (TS_GOODS_FILTERS)', "EXISTS(SELECT 1 FROM TS_GOODS_FILTERS gf WHERE gf.GOODSID=g.GOODSID)"),
                  ('cu descriere (TS_GOODS_DSC)', "EXISTS(SELECT 1 FROM TS_GOODS_DSC d WHERE d.GOODSID=g.GOODSID)"),
                  ('cu imagine (TS_GOODS_IMAGE)', "EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID)")]:
    cur.execute("SELECT COUNT(*) " + BASE + " AND " + cond)
    out.write("  %-32s %d\n" % (lbl, cur.fetchone()[0]))

out.write("\nce s-a scris azi:\n")
cur.execute("""SELECT COUNT(*) FROM TS_GOODS_FILTERS gf JOIN TS_GOODS g ON g.GOODSID=gf.GOODSID
               WHERE g.WEBGOODSTYPE_ID=8 AND gf.CREATED_DATE >= CURRENT_DATE""")
out.write("  TS_GOODS_FILTERS (procesoare): %d\n" % cur.fetchone()[0])
cur.execute("SELECT COUNT(*) FROM TS_FILTER_PARAMS WHERE CREATED_DATE >= CURRENT_DATE")
out.write("  TS_FILTER_PARAMS (orice tip):  %d\n" % cur.fetchone()[0])
cur.execute("SELECT COUNT(*) FROM TS_GOODS_DSC WHERE CREATED_DATE >= CURRENT_DATE")
out.write("  TS_GOODS_DSC:                  %d\n" % cur.fetchone()[0])
cur.execute("SELECT COUNT(*) FROM TS_GOODS_IMAGE WHERE CREATED_DATE >= CURRENT_DATE")
out.write("  TS_GOODS_IMAGE:                %d\n" % cur.fetchone()[0])

for gid in (313727, 367016):
    cur.execute("""SELECT f.FILTERNAME, p.PARAM_VALUE FROM TS_GOODS_FILTERS gf
                   JOIN TS_FILTERS f ON f.FILTERID=gf.FILTERID
                   JOIN TS_FILTER_PARAMS p ON p.FILTERID=gf.FILTERID AND p.FILTERPARAMID=gf.FILTERPARAMID
                   WHERE gf.GOODSID=?""", (gid,))
    rows = cur.fetchall()
    cur.execute("SELECT TITLE FROM TS_GOODS WHERE GOODSID=?", (gid,))
    out.write("\n" + "=" * 66 + "\n%d  %s\n" % (gid, (cur.fetchone()[0] or '')[:70]))
    out.write("filtre in TS_GOODS_FILTERS: %d\n" % len(rows))
    for n, v in rows:
        out.write("   %s: %s\n" % (n, v))
    cur.execute("SELECT DESCRIPTION_RO FROM TS_GOODS_DSC WHERE GOODSID=?", (gid,))
    row = cur.fetchone()
    out.write("descrierea din TS_GOODS_DSC:\n%s\n" % (r(row[0]) if row else '(lipseste)'))
    cur.execute("SELECT COUNT(*) FROM TS_GOODS_IMAGE WHERE GOODSID=?", (gid,))
    out.write("imagini: %d\n" % cur.fetchone()[0])
out.close(); con.close(); print('ok')
