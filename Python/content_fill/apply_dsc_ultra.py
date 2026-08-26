# -*- coding: utf-8 -*-
"""Inlocuieste descrierile generate anterior cu cele bazate pe datele Ultra.
Regula de siguranta: se rescrie DOAR randul al carui text din baza este identic
cu textul generat de mine inainte; descrierile scrise de oameni nu se ating."""
import firebird.driver as fb, io, json

new = json.load(io.open('gen_dsc_ultra.json', encoding='utf-8'))
prev = json.load(io.open('gen_dsc.json', encoding='utf-8'))
log = io.open('apply_ultra_dsc_log.txt', 'w', encoding='utf-8')

con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor()
cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','204') FROM RDB$DATABASE"); cur.fetchone()
r = lambda b: (b.read() if hasattr(b, 'read') else b) or ''

updated, inserted, protejate, neschimbate = 0, 0, [], 0
for gid, v in new.items():
    cur.execute("SELECT DESCRIPTION_RO, DESCRIPTION FROM TS_GOODS_DSC WHERE GOODSID=?", (int(gid),))
    row = cur.fetchone()
    if row is None:
        cur.execute("INSERT INTO TS_GOODS_DSC (GOODSID, DESCRIPTION_RO, DESCRIPTION) VALUES (?, ?, ?)",
                    (int(gid), v['ro'], v['ru']))
        inserted += 1
        continue
    cur_ro, cur_ru = r(row[0]), r(row[1])
    mine = prev.get(gid)
    if not mine or cur_ro != mine['ro'] or cur_ru != mine['ru']:
        protejate.append(gid)                 # text scris de om sau modificat intre timp
        continue
    if cur_ro == v['ro'] and cur_ru == v['ru']:
        neschimbate += 1
        continue
    cur.execute("UPDATE TS_GOODS_DSC SET DESCRIPTION_RO=?, DESCRIPTION=? WHERE GOODSID=?",
                (v['ro'], v['ru'], int(gid)))
    updated += 1
con.commit()
log.write("actualizate: %d, inserate: %d, neschimbate: %d, protejate (text strain): %s\n"
          % (updated, inserted, neschimbate, protejate))

mismatch = []
for gid, v in new.items():
    cur.execute("SELECT DESCRIPTION_RO, DESCRIPTION FROM TS_GOODS_DSC WHERE GOODSID=?", (int(gid),))
    row = cur.fetchone()
    if gid in protejate:
        continue
    if not row or r(row[0]) != v['ro'] or r(row[1]) != v['ru']:
        mismatch.append(gid)
log.write("verificare read-back: diferite = %s\n" % mismatch)

cur.execute("""SELECT COUNT(*) FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)
 AND NOT EXISTS(SELECT 1 FROM TS_GOODS_DSC d WHERE d.GOODSID=g.GOODSID)""")
log.write("CPU in price fara descriere: %d\n" % cur.fetchone()[0])
cur.execute("""SELECT COUNT(*) FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)
 AND NOT EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID)""")
log.write("CPU in price fara imagine: %d\n" % cur.fetchone()[0])
log.close(); con.close()
print('updated', updated, 'inserted', inserted, 'protected', len(protejate), 'mismatch', len(mismatch))
