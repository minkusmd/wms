# -*- coding: utf-8 -*-
"""Repara artefactul 'rated ...' produs de ordinea gresita a alternativelor din
clean_igpu ('Integ\\.?' se potrivea inaintea lui 'Integrated')."""
import firebird.driver as fb, io, re
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('fix_rated.txt', 'w', encoding='utf-8')
cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','204') FROM RDB$DATABASE"); cur.fetchone()
r = lambda b: (b.read() if hasattr(b, 'read') else b) or ''

FIX = {'rated Radeon RX Vega 7 Graphics': 'Radeon RX Vega 7 Graphics',
       'rated Radeon RX Vega 8 Graphics': 'Radeon RX Vega 8 Graphics',
       'rated Graphics': 'Grafică integrată'}
FIX_RU = {'rated Radeon RX Vega 7 Graphics': 'Radeon RX Vega 7 Graphics',
          'rated Radeon RX Vega 8 Graphics': 'Radeon RX Vega 8 Graphics',
          'rated Graphics': 'Встроенная графика'}

for bad, good in FIX.items():
    cur.execute("SELECT FILTERID, FILTERPARAMID FROM TS_FILTER_PARAMS WHERE PARAM_VALUE=?", (bad,))
    for fid, pid in cur.fetchall():
        cur.execute("""UPDATE TS_FILTER_PARAMS SET PARAM_VALUE=?, PARAM_VALUE_RUS=?
                       WHERE FILTERID=? AND FILTERPARAMID=?""", (good, FIX_RU[bad], fid, pid))
        cur.execute("SELECT LIST(GOODSID) FROM TS_GOODS_DESCRIPTIONS WHERE FILTERID=? AND FILTERPARAMID=?", (fid, pid))
        out.write("param %s/%s: '%s' -> '%s'  (produse: %s)\n" % (fid, pid, bad, good, cur.fetchone()[0]))

# descrierile text afectate
cur.execute("""SELECT GOODSID FROM TS_GOODS_DSC
               WHERE DESCRIPTION_RO LIKE '%grated Radeon%' OR DESCRIPTION_RO LIKE '%ă rated %'
                  OR DESCRIPTION_RO LIKE '%integrată rated %'""")
cur.execute("""SELECT d.GOODSID, d.DESCRIPTION_RO, d.DESCRIPTION FROM TS_GOODS_DSC d
               JOIN TS_GOODS g ON g.GOODSID=d.GOODSID WHERE g.WEBGOODSTYPE_ID=8""")
fixed = 0
for gid, ro_b, ru_b in cur.fetchall():
    ro, ru = r(ro_b), r(ru_b)
    n_ro = re.sub(r'\brated ', '', ro)
    n_ru = re.sub(r'\brated ', '', ru)
    if n_ro != ro or n_ru != ru:
        cur2 = con.cursor()
        cur2.execute("UPDATE TS_GOODS_DSC SET DESCRIPTION_RO=?, DESCRIPTION=? WHERE GOODSID=?", (n_ro, n_ru, gid))
        out.write("descriere reparata: %s\n" % gid)
        fixed += 1
con.commit()
out.write("\ndescrieri reparate: %d\n" % fixed)

cur.execute("SELECT COUNT(*) FROM TS_FILTER_PARAMS WHERE PARAM_VALUE STARTING WITH 'rated'")
out.write("param cu 'rated' ramase: %d\n" % cur.fetchone()[0])
cur.execute("""SELECT COUNT(*) FROM TS_GOODS_DSC d JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
               WHERE g.WEBGOODSTYPE_ID=8 AND d.DESCRIPTION_RO LIKE '%rated %'""")
out.write("descrieri de procesoare cu 'rated ' ramase: %d\n" % cur.fetchone()[0])
out.close(); con.close(); print('ok')
