# -*- coding: utf-8 -*-
"""Vocabularul de caracteristici pentru tipul 319 (catalog) si cel al proprietatilor Ultra."""
import firebird.driver as fb, io, json

GT = 319
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('vocab_319.txt', 'w', encoding='utf-8')

# 1) ce caracteristici foloseste deja catalogul pentru frigidere, si la ce ORDERNO
cur.execute("""SELECT d.FILTERID, f.FILTERNAME, f.FILTERNAME_RUS, COUNT(*) n,
                      MIN(d.ORDERNO), MAX(d.ORDERNO)
               FROM TS_GOODS_DESCRIPTIONS d
               JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
               JOIN TS_FILTERS f ON f.FILTERID=d.FILTERID
               WHERE g.WEBGOODSTYPE_ID=? GROUP BY 1,2,3 ORDER BY 4 DESC""", (GT,))
rows = cur.fetchall()
out.write("caracteristici folosite la frigidere (FILTERID, nume, nr. produse, orderno min/max):\n")
canon = {}
for fid, nm, nru, n, o1, o2 in rows:
    out.write("  %-6s %-46s %5d   ord %s..%s\n" % (fid, (nm or '').strip()[:46], n, o1, o2))
    key = (nm or '').strip().lower()
    if key not in canon or n > canon[key]['n']:
        canon[key] = dict(fid=fid, name=(nm or '').strip(), name_ru=(nru or '').strip(), n=n, orderno=o1)
json.dump(canon, io.open('canon_319.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)

# 2) ce proprietati are Ultra pentru aceste produse
link = json.load(io.open('ultra_link_319.json', encoding='utf-8'))
uuids = "','".join(v['uuid'] for v in link.values())
cur.execute("""SELECT pr.NAME_RO, pr.NAME_RU, COUNT(*) n
               FROM TS_ULTRA2_PROPERTY_VALUE v
               LEFT JOIN TS_ULTRA2_PROPERTY pr ON pr.CODE=v.PROPERTY_CODE
               WHERE v.PRODUCT_UUID IN ('%s') GROUP BY 1,2 ORDER BY 3 DESC""" % uuids)
out.write("\nproprietati Ultra pentru frigidere (%d produse):\n" % len(link))
props = []
for nm, nru, n in cur.fetchall():
    out.write("  %-52s %-40s %d\n" % ((nm or '(fara nume)')[:52], (nru or '')[:40], n))
    props.append([nm, nru, n])
json.dump(props, io.open('ultra_props_319.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)

# 3) exemplu concret de produs cu caracteristici deja completate
cur.execute("""SELECT FIRST 1 d.GOODSID, COUNT(*) FROM TS_GOODS_DESCRIPTIONS d
               JOIN TS_GOODS g ON g.GOODSID=d.GOODSID WHERE g.WEBGOODSTYPE_ID=?
               GROUP BY 1 ORDER BY 2 DESC""", (GT,))
gid = cur.fetchone()[0]
cur.execute("""SELECT ORDERNO, FLG_GROUP, FILTERID, FILTERNAME_ROM, PARAM_VALUE_ROM
               FROM VW_TS_GOODS_DESCRIPTIONS WHERE GOODSID=? ORDER BY ORDERNO""", (gid,))
cur2 = con.cursor(); cur2.execute("SELECT TITLE FROM TS_GOODS WHERE GOODSID=?", (gid,))
out.write("\nexemplu produs %d %s\n" % (gid, (cur2.fetchone()[0] or '')[:70]))
for o, grp, fid, nm, v in cur:
    out.write("   %-3s grp=%s %-6s %-40s %s\n" % (o, grp, fid, (nm or '')[:40], v))
out.close(); con.close(); print('ok')
