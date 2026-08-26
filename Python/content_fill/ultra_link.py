# -*- coding: utf-8 -*-
import firebird.driver as fb, io
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('ultra_link.txt', 'w', encoding='utf-8')

REST = [279159, 335686, 367016, 369178, 369182, 373186, 373189, 379900, 392639, 399971, 402317]

# furnizorii din care vin aceste produse
cur.execute("""SELECT pl.SUPPLIERID, s.TITLE, COUNT(*) FROM TS_PRICELIST_ITEMS pi
               JOIN TS_PRICELISTS pl ON pl.PLID=pi.PLID
               LEFT JOIN TS_SYSS s ON s.SYSSID=pl.SUPPLIERID
               WHERE pi.GOODSID IN (%s) GROUP BY 1,2 ORDER BY 3 DESC""" % ','.join(map(str, REST)))
out.write("furnizori pentru cele 11:\n")
for r in cur:
    out.write("  supplier=%s %s items=%s\n" % (r[0], (r[1] or '')[:40], r[2]))

# codurile de furnizor si potrivirea in tabelele Ultra
out.write("\nlegatura cu Ultra:\n")
for gid in REST:
    cur.execute("""SELECT pl.SUPPLIERID, pi.SUPPLIER_GOODS_CODE, pi.SUPPLIER_GOODS_NAME
                   FROM TS_PRICELIST_ITEMS pi JOIN TS_PRICELISTS pl ON pl.PLID=pi.PLID
                   WHERE pi.GOODSID=?""", (gid,))
    items = cur.fetchall()
    out.write("%s: %d pozitii de furnizor\n" % (gid, len(items)))
    for sup, code, name in items[:4]:
        code = (code or '').strip()
        cur.execute("SELECT COUNT(*) FROM TS_ULTRA2_PRODUCT WHERE CODE=?", (code,))
        n2 = cur.fetchone()[0]
        cur.execute("SELECT COUNT(*) FROM TS_ULTRA_NOMENCLATURE WHERE CODE=?", (code,))
        n1 = cur.fetchone()[0]
        out.write("    sup=%-8s cod=%-18s ultra2=%s ultra1=%s  %s\n"
                  % (sup, code[:18], n2, n1, (name or '')[:52]))
out.close(); con.close(); print('ok')
