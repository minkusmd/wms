# -*- coding: utf-8 -*-
"""Cat de bine acopera Ultra procesoarele din price."""
import firebird.driver as fb, io, json
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('ultra_cover.txt', 'w', encoding='utf-8')

cur.execute("""SELECT g.GOODSID, g.TITLE FROM TS_GOODS g
 WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID) ORDER BY g.GOODSID""")
goods = cur.fetchall()

link, nprop = {}, {}
for gid, title in goods:
    cur.execute("""SELECT DISTINCT pi.SUPPLIER_GOODS_CODE FROM TS_PRICELIST_ITEMS pi
                   JOIN TS_PRICELISTS pl ON pl.PLID=pi.PLID
                   WHERE pi.GOODSID=? AND pl.SUPPLIERID=202294""", (gid,))
    codes = sorted({(r[0] or '').strip() for r in cur if r[0]})
    if not codes:
        continue
    cur.execute("SELECT UUID FROM TS_ULTRA2_PRODUCT WHERE CODE=?", (codes[0],))
    row = cur.fetchone()
    if not row:
        continue
    uuid = row[0]
    cur.execute("SELECT COUNT(*) FROM TS_ULTRA2_PROPERTY_VALUE WHERE PRODUCT_UUID=?", (uuid,))
    n = cur.fetchone()[0]
    link[gid] = dict(code=codes[0], uuid=uuid.strip(), nprop=n, ncodes=len(codes), title=title)
    nprop[gid] = n

with_props = [g for g, n in nprop.items() if n > 0]
out.write("CPU in price: %d\n" % len(goods))
out.write("cu legatura Ultra (furnizor 202294 + TS_ULTRA2_PRODUCT): %d\n" % len(link))
out.write("dintre care cu proprietati: %d (media %.1f proprietati)\n"
          % (len(with_props), sum(nprop.values()) / max(len(with_props), 1)))
out.write("cu mai multe coduri de furnizor (ambiguu): %d\n" % sum(1 for v in link.values() if v['ncodes'] > 1))

# ce proprietati apar cel mai des la aceste produse
if link:
    uuids = "','".join(v['uuid'] for v in link.values())
    cur.execute("""SELECT pr.NAME_RO, COUNT(*) FROM TS_ULTRA2_PROPERTY_VALUE v
                   LEFT JOIN TS_ULTRA2_PROPERTY pr ON pr.CODE=v.PROPERTY_CODE
                   WHERE v.PRODUCT_UUID IN ('%s') GROUP BY 1 ORDER BY 2 DESC""" % uuids)
    out.write("\nproprietati Ultra intalnite:\n")
    for name, n in cur.fetchall():
        out.write("  %-42s %d\n" % ((name or '(fara nume)')[:42], n))

json.dump({str(k): v for k, v in link.items()},
          io.open('ultra_link_all.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
out.close(); con.close()
print('goods', len(goods), 'linked', len(link), 'with props', len(with_props))
