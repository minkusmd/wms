# -*- coding: utf-8 -*-
"""Pentru descrierile scrise de mana (primul lot), pastreaza proza si inlocuieste
doar blocul de caracteristici cu cel construit din datele Ultra."""
import firebird.driver as fb, io, json

TARGETS = ['295406', '306373', '307112', '312594']
H_RO, H_RU = "\n\nCaracteristici principale:\n", "\n\nОсновные характеристики:\n"

new = json.load(io.open('gen_dsc_ultra.json', encoding='utf-8'))
log = io.open('patch_first5_log.txt', 'w', encoding='utf-8')
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor()
cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','204') FROM RDB$DATABASE"); cur.fetchone()
r = lambda b: (b.read() if hasattr(b, 'read') else b) or ''

done = 0
for gid in TARGETS:
    if gid not in new:
        log.write("%s: fara date Ultra\n" % gid); continue
    cur.execute("SELECT DESCRIPTION_RO, DESCRIPTION FROM TS_GOODS_DSC WHERE GOODSID=?", (int(gid),))
    row = cur.fetchone()
    cur_ro, cur_ru = r(row[0]), r(row[1])
    if H_RO not in cur_ro or H_RU not in cur_ru:
        log.write("%s: nu are blocul asteptat, sarit\n" % gid); continue
    blk_ro = new[gid]['ro'].split(H_RO, 1)[1]
    blk_ru = new[gid]['ru'].split(H_RU, 1)[1]
    out_ro = cur_ro.split(H_RO, 1)[0] + H_RO + blk_ro
    out_ru = cur_ru.split(H_RU, 1)[0] + H_RU + blk_ru
    cur.execute("UPDATE TS_GOODS_DSC SET DESCRIPTION_RO=?, DESCRIPTION=? WHERE GOODSID=?",
                (out_ro, out_ru, int(gid)))
    done += 1
    log.write("%s: bloc inlocuit (%d -> %d randuri RO)\n"
              % (gid, cur_ro.split(H_RO, 1)[1].count('\n') + 1, blk_ro.count('\n') + 1))
con.commit()

log.write("\nactualizate: %d\n\nexemplu 295406 dupa modificare:\n" % done)
cur.execute("SELECT DESCRIPTION_RO FROM TS_GOODS_DSC WHERE GOODSID=295406")
log.write(r(cur.fetchone()[0]) + "\n")
log.close(); con.close()
print('done', done)
