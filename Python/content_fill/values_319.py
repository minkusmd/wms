# -*- coding: utf-8 -*-
"""Valorile deja folosite pentru fiecare caracteristica de frigider — ca sa reutilizez
formatul existent si sa nu fragmentez dictionarul de filtre."""
import firebird.driver as fb, io

FIDS = [1046, 1047, 1048, 1696, 1050, 1051, 1052, 3670, 1053, 1054, 1055, 1056,
        1059, 1057, 1058, 1068, 3763, 1060, 1061, 1062, 1063, 1064, 1065, 1066,
        1069, 1070, 1071, 1067, 3798]
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('values_319.txt', 'w', encoding='utf-8')
for fid in FIDS:
    cur.execute("SELECT FILTERNAME FROM TS_FILTERS WHERE FILTERID=?", (fid,))
    nm = (cur.fetchone()[0] or '').strip()
    cur.execute("""SELECT FIRST 12 p.PARAM_VALUE, p.PARAM_VALUE_RUS, COUNT(*) n
                   FROM TS_GOODS_DESCRIPTIONS d
                   JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
                   JOIN TS_FILTER_PARAMS p ON p.FILTERID=d.FILTERID AND p.FILTERPARAMID=d.FILTERPARAMID
                   WHERE g.WEBGOODSTYPE_ID=319 AND d.FILTERID=?
                   GROUP BY 1,2 ORDER BY 3 DESC""", (fid,))
    rows = cur.fetchall()
    cur.execute("""SELECT COUNT(DISTINCT p.FILTERPARAMID) FROM TS_FILTER_PARAMS p WHERE p.FILTERID=?""", (fid,))
    tot = cur.fetchone()[0]
    out.write("\n%s  %s   (%d valori in dictionar)\n" % (fid, nm, tot))
    for v, vru, n in rows:
        out.write("    %-30s | %-24s %d\n" % ((v or '')[:30], (vru or '')[:24], n))
out.close(); con.close(); print('ok')
