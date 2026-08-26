# -*- coding: utf-8 -*-
"""Verificare finala a caracteristicilor procesoarelor din price."""
import firebird.driver as fb, io, re
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('verify_descr.txt', 'w', encoding='utf-8')

BASE = """FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)"""
cur.execute("SELECT COUNT(*) " + BASE)
tot = cur.fetchone()[0]
cur.execute("SELECT COUNT(*) " + BASE + " AND NOT EXISTS(SELECT 1 FROM TS_GOODS_DESCRIPTIONS d WHERE d.GOODSID=g.GOODSID)")
out.write("CPU in price: %d; fara nicio caracteristica: %d\n" % (tot, cur.fetchone()[0]))
cur.execute("""SELECT AVG(n), MIN(n), MAX(n) FROM (SELECT COUNT(*) n FROM TS_GOODS_DESCRIPTIONS d
 JOIN TS_GOODS g ON g.GOODSID=d.GOODSID WHERE g.WEBGOODSTYPE_ID=8
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID) GROUP BY d.GOODSID)""")
out.write("caracteristici per produs: media %s, min %s, max %s\n" % cur.fetchone())

cur.execute("""SELECT COUNT(*) FROM TS_GOODS_DESCRIPTIONS d JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
               WHERE g.WEBGOODSTYPE_ID=8 AND d.CREATED_DATE >= CURRENT_DATE""")
out.write("randuri adaugate azi de mine: %d\n" % cur.fetchone()[0])

# integritate: toate randurile noi trebuie vizibile prin view (join cu filtre + parametri)
cur.execute("""SELECT COUNT(*) FROM TS_GOODS_DESCRIPTIONS d JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
               WHERE g.WEBGOODSTYPE_ID=8 AND d.CREATED_DATE >= CURRENT_DATE
               AND NOT EXISTS(SELECT 1 FROM VW_TS_GOODS_DESCRIPTIONS v
                              WHERE v.GOODSID=d.GOODSID AND v.DESCRIPTIONID=d.DESCRIPTIONID)""")
out.write("randuri noi invizibile prin view (join rupt): %d\n" % cur.fetchone()[0])

# duplicate: acelasi filtru de doua ori pe acelasi produs
cur.execute("""SELECT COUNT(*) FROM (SELECT d.GOODSID, d.FILTERID FROM TS_GOODS_DESCRIPTIONS d
               JOIN TS_GOODS g ON g.GOODSID=d.GOODSID WHERE g.WEBGOODSTYPE_ID=8
               AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)
               GROUP BY 1,2 HAVING COUNT(*)>1)""")
out.write("perechi (produs, filtru) duplicate: %d\n" % cur.fetchone()[0])

# valori suspecte printre cele create azi
cur.execute("""SELECT DISTINCT f.FILTERNAME, p.PARAM_VALUE, p.PARAM_VALUE_RUS
               FROM TS_GOODS_DESCRIPTIONS d
               JOIN TS_FILTERS f ON f.FILTERID=d.FILTERID
               JOIN TS_FILTER_PARAMS p ON p.FILTERID=d.FILTERID AND p.FILTERPARAMID=d.FILTERPARAMID
               JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
               WHERE g.WEBGOODSTYPE_ID=8 AND d.CREATED_DATE >= CURRENT_DATE ORDER BY 1,2""")
rows = cur.fetchall()
out.write("\nvalori distincte scrise azi (%d):\n" % len(rows))
for n, v, vru in rows:
    flag = ''
    if not v or v.strip() in ('-', '?') or re.match(r'^(rated|ată|ata)\b', v.strip(), re.I):
        flag = '  <-- SUSPECT'
    out.write("  %-30s %-32s %s%s\n" % ((n or '')[:30], (v or '')[:32], (vru or '')[:26], flag))

# exemplul cerut de user
cur.execute("""SELECT ORDERNO, FILTERNAME_ROM, PARAM_VALUE_ROM, PARAM_VALUE_RUS
               FROM VW_TS_GOODS_DESCRIPTIONS WHERE GOODSID=313727 ORDER BY ORDERNO""")
out.write("\n313727 prin VW_TS_GOODS_DESCRIPTIONS:\n")
for o, n, vro, vru in cur:
    out.write("   %-3s %-30s %-24s %s\n" % (o, (n or '')[:30], (vro or '')[:24], vru or ''))
out.close(); con.close(); print('ok')
