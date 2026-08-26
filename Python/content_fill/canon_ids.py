# -*- coding: utf-8 -*-
"""Care FILTERID se foloseste de fapt pentru caracteristicile procesoarelor
(exista omonime: ex. 210 vs 600 pentru 'Procesorul grafic')."""
import firebird.driver as fb, io, json
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('canon_ids.txt', 'w', encoding='utf-8')

cur.execute("""SELECT d.FILTERID, f.FILTERNAME, f.FILTERNAME_RUS, COUNT(*) n
               FROM TS_GOODS_DESCRIPTIONS d
               JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
               JOIN TS_FILTERS f ON f.FILTERID=d.FILTERID
               WHERE g.WEBGOODSTYPE_ID=8
               GROUP BY 1,2,3 ORDER BY 4 DESC""")
rows = cur.fetchall()
out.write("FILTERID folosite la caracteristicile procesoarelor (top 30):\n")
canon = {}
for fid, nm, nru, n in rows[:30]:
    out.write("  %-6s %-40s %d\n" % (fid, (nm or '').strip()[:40], n))
for fid, nm, nru, n in rows:
    key = (nm or '').strip().lower()
    if key not in canon or n > canon[key][2]:
        canon[key] = (fid, (nm or '').strip(), n, (nru or '').strip())

json.dump({k: [v[0], v[1], v[3]] for k, v in canon.items()},
          io.open('canon_ids.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)

# starea produsului dat ca exemplu
for gid in (313727, 367016, 341784):
    cur.execute("""SELECT ORDERNO, FLG_GROUP, FILTERID, FILTERNAME_ROM, PARAM_VALUE_ROM
                   FROM VW_TS_GOODS_DESCRIPTIONS WHERE GOODSID=? ORDER BY ORDERNO""", (gid,))
    r = cur.fetchall()
    cur.execute("SELECT TITLE FROM TS_GOODS WHERE GOODSID=?", (gid,))
    out.write("\n%d  %s\n  caracteristici existente: %d\n" % (gid, (cur.fetchone()[0] or '')[:66], len(r)))
    for o, grp, fid, nm, v in r:
        out.write("    %-3s %-6s %-32s %s\n" % (o, fid, (nm or '')[:32], v))

cur.execute("""SELECT COUNT(*) FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)
 AND NOT EXISTS(SELECT 1 FROM TS_GOODS_DESCRIPTIONS d WHERE d.GOODSID=g.GOODSID)""")
out.write("\nCPU in price FARA nicio caracteristica: %d\n" % cur.fetchone()[0])
cur.execute("""SELECT AVG(n) FROM (SELECT COUNT(*) n FROM TS_GOODS_DESCRIPTIONS d
 JOIN TS_GOODS g ON g.GOODSID=d.GOODSID WHERE g.WEBGOODSTYPE_ID=8
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID) GROUP BY d.GOODSID)""")
out.write("media caracteristicilor la cele care au: %s\n" % cur.fetchone()[0])
out.close(); con.close(); print('ok')
