# -*- coding: utf-8 -*-
import firebird.driver as fb, io
GT = 319
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('verify_319.txt', 'w', encoding='utf-8')

BASE = """FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=%d AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)""" % GT
cur.execute("SELECT COUNT(*) " + BASE); tot = cur.fetchone()[0]
for lbl, cond in [('fara caracteristici', "NOT EXISTS(SELECT 1 FROM TS_GOODS_DESCRIPTIONS d WHERE d.GOODSID=g.GOODSID)"),
                  ('fara imagine', "NOT EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID)"),
                  ('fara descriere proza', "NOT EXISTS(SELECT 1 FROM TS_GOODS_DSC d WHERE d.GOODSID=g.GOODSID)")]:
    cur.execute("SELECT COUNT(*) " + BASE + " AND " + cond)
    out.write("%-26s %d din %d\n" % (lbl, cur.fetchone()[0], tot))

cur.execute("""SELECT AVG(n), MIN(n), MAX(n) FROM (SELECT COUNT(*) n FROM TS_GOODS_DESCRIPTIONS d
 JOIN TS_GOODS g ON g.GOODSID=d.GOODSID WHERE g.WEBGOODSTYPE_ID=%d
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID) GROUP BY d.GOODSID)""" % GT)
out.write("caracteristici per produs: media %s min %s max %s\n" % cur.fetchone())

cur.execute("""SELECT COUNT(*) FROM TS_GOODS_DESCRIPTIONS d JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
               WHERE g.WEBGOODSTYPE_ID=%d AND d.CREATED_DATE >= CURRENT_DATE""" % GT)
out.write("randuri adaugate azi: %d\n" % cur.fetchone()[0])
cur.execute("""SELECT COUNT(*) FROM TS_GOODS_DESCRIPTIONS d JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
               WHERE g.WEBGOODSTYPE_ID=%d AND d.CREATED_DATE >= CURRENT_DATE
               AND NOT EXISTS(SELECT 1 FROM VW_TS_GOODS_DESCRIPTIONS v
                              WHERE v.GOODSID=d.GOODSID AND v.DESCRIPTIONID=d.DESCRIPTIONID)""" % GT)
out.write("randuri noi invizibile prin view: %d\n" % cur.fetchone()[0])
cur.execute("""SELECT COUNT(*) FROM (SELECT d.GOODSID, d.FILTERID FROM TS_GOODS_DESCRIPTIONS d
               JOIN TS_GOODS g ON g.GOODSID=d.GOODSID WHERE g.WEBGOODSTYPE_ID=%d
               AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)
               GROUP BY 1,2 HAVING COUNT(*)>1)""" % GT)
out.write("perechi (produs, caracteristica) duplicate: %d\n" % cur.fetchone()[0])

cur.execute("""SELECT DISTINCT f.FILTERNAME, p.PARAM_VALUE, p.PARAM_VALUE_RUS
               FROM TS_GOODS_DESCRIPTIONS d
               JOIN TS_FILTERS f ON f.FILTERID=d.FILTERID
               JOIN TS_FILTER_PARAMS p ON p.FILTERID=d.FILTERID AND p.FILTERPARAMID=d.FILTERPARAMID
               JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
               WHERE g.WEBGOODSTYPE_ID=%d AND d.CREATED_DATE >= CURRENT_DATE
               ORDER BY 1,2""" % GT)
rows = cur.fetchall()
out.write("\nvalori distincte scrise azi (%d):\n" % len(rows))
for n, v, vru in rows:
    susp = '' if (v or '').strip() and (vru or '').strip() else '   <-- valoare goala'
    out.write("  %-40s %-22s %s%s\n" % ((n or '')[:40], (v or '')[:22], (vru or '')[:20], susp))
out.close(); con.close(); print('ok')
