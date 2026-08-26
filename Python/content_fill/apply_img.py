# -*- coding: utf-8 -*-
"""Copiaza in TS_GOODS_IMAGE cadrul ales manual (dupa verificare vizuala) pentru
fiecare procesor din price fara imagine."""
import firebird.driver as fb, io, json

# eticheta = "<goodsid tinta>.<goods_image_id sursa>", aleasa vizual din plansele pick3_*.png
CHOICE = """242461.1 283472.1 283473.1 287603.1 302758.1 313727.1 318853.2 331359.2
341781.3 341782.3 341783.3 341784.2 344266.2 348327.1 348328.2 348420.2 348640.2
354371.2 358989.2 362395.2 369181.1 369184.2 369233.2 374210.2 378185.3 378186.3
382095.1 382422.1 391961.2 395948.2 400517.1 400518.1""".split()

index = json.load(io.open('img_index.json', encoding='utf-8'))
log = io.open('apply_img_log.txt', 'w', encoding='utf-8')

missing = [c for c in CHOICE if c not in index]
if missing:
    log.write("OPRIT - etichete inexistente: %s\n" % missing); log.close()
    raise SystemExit("etichete inexistente: %s" % missing)

con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor()
cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','204') FROM RDB$DATABASE"); cur.fetchone()

written, skipped = 0, []
for label in CHOICE:
    it = index[label]
    gid, src, iid = it['target'], it['src_gid'], it['src_iid']
    cur.execute("SELECT COUNT(*) FROM TS_GOODS_IMAGE WHERE GOODSID=?", (gid,))
    if cur.fetchone()[0]:
        skipped.append(gid); continue
    cur.execute("""SELECT COUNT(*) FROM TS_GOODS_IMAGE WHERE GOODSID=? AND GOODS_IMAGE_ID=?
                   AND SUBSTRING(IMAGE FROM 2 FOR 3)='PNG'""", (src, iid))
    if not cur.fetchone()[0]:
        skipped.append(gid); log.write("sursa lipsa/nu e PNG: %s\n" % label); continue
    cur.execute("""INSERT INTO TS_GOODS_IMAGE (GOODSID, IMAGE)
                   SELECT ?, IMAGE FROM TS_GOODS_IMAGE WHERE GOODSID=? AND GOODS_IMAGE_ID=?""",
                (gid, src, iid))
    written += 1
con.commit()
log.write("imagini scrise: %d; sarite: %s\n\n" % (written, skipped))

for label in CHOICE:
    gid = index[label]['target']
    cur.execute("""SELECT COUNT(*), MIN(OCTET_LENGTH(IMAGE)/1024),
                   MIN(CASE WHEN SUBSTRING(IMAGE FROM 2 FOR 3)='PNG' THEN 1 ELSE 0 END), MIN(CREATED_BY)
                   FROM TS_GOODS_IMAGE WHERE GOODSID=?""", (gid,))
    n, kb, png, by = cur.fetchone()
    log.write("%s: imagini=%s %s KB png=%s created_by=%s\n" % (gid, n, kb, png, by))

cur.execute("""SELECT COUNT(*) FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)
 AND NOT EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID)""")
log.write("\nCPU in price ramase fara imagine: %d\n" % cur.fetchone()[0])
log.close(); con.close()
print('done', written)
