# -*- coding: utf-8 -*-
"""Insereaza imaginile de frigider alese vizual din img319_sheet.png.
Regula de alegere: cadrul cu produsul inchis, vazut din fata; daca lipseste,
cadrul care arata cel mai bine produsul intreg."""
import firebird.driver as fb, io, json

CHOICE = {
    346822: 2, 346823: 1, 348210: 1, 348211: 1, 358395: 1, 366904: 2, 366906: 2,
    366911: 1, 366919: 1, 372244: 1, 378008: 1, 378091: 2, 378376: 2, 378378: 1,
    383695: 1, 383696: 1, 384029: 1, 384131: 1, 384452: 2, 385975: 1, 385984: 1,
    386600: 1, 387550: 1, 388789: 1, 389171: 2, 389235: 1, 389865: 1, 390230: 1,
    391331: 2, 391877: 1, 392511: 2, 392514: 1, 392830: 1, 394764: 1, 395321: 1,
    395324: 1, 399098: 1, 400792: 2, 401654: 2, 401657: 1, 401658: 1,
}
# 399592 exclus: ambele cadre arata piese (raft, sertar), nu produsul

res = json.load(io.open('img319_resolved.json', encoding='utf-8'))
log = io.open('img_319_apply.txt', 'w', encoding='utf-8')
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor()
cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','204') FROM RDB$DATABASE"); cur.fetchone()

written, sarite = 0, []
for gid, idx in CHOICE.items():
    info = res.get(str(gid))
    if not info:
        sarite.append((gid, 'lipsa din rezolvate')); continue
    img = next((i for i in info['images'] if i['idx'] == idx), None)
    if not img:
        sarite.append((gid, 'cadru %s inexistent' % idx)); continue
    data = open(img['path'], 'rb').read()
    if data[:8] != b'\x89PNG\r\n\x1a\n':
        sarite.append((gid, 'nu e PNG')); continue
    cur.execute("SELECT COUNT(*) FROM TS_GOODS_IMAGE WHERE GOODSID=?", (gid,))
    if cur.fetchone()[0]:
        sarite.append((gid, 'are deja imagine')); continue
    cur.execute("INSERT INTO TS_GOODS_IMAGE (GOODSID, IMAGE) VALUES (?, ?)", (gid, data))
    written += 1
    log.write("OK %s <- ultra %s (%s KB, %s)  %s\n"
              % (gid, img['url'].rsplit('/', 1)[-1], img['kb'], img['size'], info['title'][:52]))
con.commit()
log.write("\nscrise: %d; sarite: %s\n" % (written, sarite))

cur.execute("""SELECT COUNT(*) FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=319 AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)
 AND NOT EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID)""")
log.write("frigidere in price ramase fara imagine: %d\n" % cur.fetchone()[0])
log.close(); con.close()
print('scrise', written, 'sarite', len(sarite))
