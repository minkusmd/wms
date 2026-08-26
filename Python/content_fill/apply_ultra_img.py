# -*- coding: utf-8 -*-
"""Insereaza in TS_GOODS_IMAGE cadrele PNG descarcate de pe CDN-ul Ultra
(alese vizual din ultra_sheet.png)."""
import firebird.driver as fb, io, json

CHOICE = {279159: 1, 335686: 1, 367016: 1, 369178: 1, 369182: 1,
          373186: 1, 373189: 1, 379900: 1, 392639: 1, 402317: 1}

res = json.load(io.open('ultra_resolved.json', encoding='utf-8'))
log = io.open('apply_ultra_log.txt', 'w', encoding='utf-8')

con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor()
cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','204') FROM RDB$DATABASE"); cur.fetchone()

written, skipped = 0, []
for gid, idx in CHOICE.items():
    info = res[str(gid)]
    img = next((i for i in info['images'] if i['idx'] == idx), None)
    if not img:
        skipped.append((gid, 'cadru lipsa')); continue
    data = open(img['path'], 'rb').read()
    if data[:8] != b'\x89PNG\r\n\x1a\n':
        skipped.append((gid, 'nu e PNG')); continue
    cur.execute("SELECT COUNT(*) FROM TS_GOODS_IMAGE WHERE GOODSID=?", (gid,))
    if cur.fetchone()[0]:
        skipped.append((gid, 'are deja imagine')); continue

    cur.execute("INSERT INTO TS_GOODS_IMAGE (GOODSID, IMAGE) VALUES (?, ?)", (gid, data))
    written += 1
    log.write("OK %s <- ultra cod=%s %s (%s KB, %s)\n"
              % (gid, info['code'], img['url'].rsplit('/', 1)[-1], img['kb'], img['size']))
con.commit()
log.write("\nscrise: %d; sarite: %s\n\n" % (written, skipped))

for gid in CHOICE:
    cur.execute("""SELECT COUNT(*), MIN(OCTET_LENGTH(IMAGE)/1024),
                   MIN(CASE WHEN SUBSTRING(IMAGE FROM 2 FOR 3)='PNG' THEN 1 ELSE 0 END), MIN(CREATED_BY)
                   FROM TS_GOODS_IMAGE WHERE GOODSID=?""", (gid,))
    log.write("%s: imagini=%s %s KB png=%s created_by=%s\n" % ((gid,) + tuple(cur.fetchone())))

cur.execute("""SELECT COUNT(*) FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)
 AND NOT EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID)""")
log.write("\nCPU in price ramase fara imagine: %d\n" % cur.fetchone()[0])
log.close(); con.close()
print('done', written)
