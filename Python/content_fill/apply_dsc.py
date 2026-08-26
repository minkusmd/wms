# -*- coding: utf-8 -*-
"""Scrie descrierile generate in TS_GOODS_DSC (doar pentru produsele care inca nu au)."""
import firebird.driver as fb, io, json

gen = json.load(io.open('gen_dsc.json', encoding='utf-8'))
log = io.open('apply_dsc_log.txt', 'w', encoding='utf-8')

# verificare de calitate inainte de scriere
bad = [g for g, v in gen.items() if len(v['ro']) < 60 or len(v['ru']) < 60
       or 'None' in v['ro'] or 'None' in v['ru']]
if bad:
    log.write("OPRIT - descrieri suspecte: %s\n" % bad); log.close()
    raise SystemExit("descrieri suspecte: %s" % bad)

con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor()
cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','204') FROM RDB$DATABASE"); cur.fetchone()

written, skipped = 0, []
for gid_s, v in gen.items():
    gid = int(gid_s)
    cur.execute("SELECT COUNT(*) FROM TS_GOODS_DSC WHERE GOODSID=?", (gid,))
    if cur.fetchone()[0]:
        skipped.append(gid); continue
    cur.execute("INSERT INTO TS_GOODS_DSC (GOODSID, DESCRIPTION_RO, DESCRIPTION) VALUES (?, ?, ?)",
                (gid, v['ro'], v['ru']))
    written += 1
con.commit()
log.write("scrise: %d, sarite (aveau deja descriere): %s\n" % (written, skipped))

# verificare dupa commit: textul din baza == textul generat
r = lambda b: (b.read() if hasattr(b, 'read') else b) or ''
mismatch = []
for gid_s, v in gen.items():
    cur.execute("SELECT DESCRIPTION_RO, DESCRIPTION, CREATED_BY FROM TS_GOODS_DSC WHERE GOODSID=?", (int(gid_s),))
    row = cur.fetchone()
    if not row or r(row[0]) != v['ro'] or r(row[1]) != v['ru']:
        mismatch.append(gid_s)
log.write("verificare read-back: %d/%d identice, diferite: %s\n" % (len(gen) - len(mismatch), len(gen), mismatch))

cur.execute("""SELECT COUNT(*) FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)
 AND NOT EXISTS(SELECT 1 FROM TS_GOODS_DSC d WHERE d.GOODSID=g.GOODSID)""")
log.write("CPU in price ramase fara descriere: %d\n" % cur.fetchone()[0])
log.close(); con.close()
print('done', written, 'mismatch', len(mismatch))
