# -*- coding: utf-8 -*-
import firebird.driver as fb, io
con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor(); out = io.open('descr_view.txt', 'w', encoding='utf-8')
r = lambda b: (b.read() if hasattr(b, 'read') else b) or ''

for t in ('TS_GOODS_DESCRIPTIONS', 'VW_TS_GOODS_DESCRIPTIONS', 'TS_GOODS_DESC_BUTTONS'):
    cur.execute("""SELECT rf.RDB$FIELD_NAME, f.RDB$FIELD_TYPE, f.RDB$FIELD_LENGTH, rf.RDB$NULL_FLAG
                   FROM RDB$RELATION_FIELDS rf JOIN RDB$FIELDS f ON f.RDB$FIELD_NAME=rf.RDB$FIELD_SOURCE
                   WHERE rf.RDB$RELATION_NAME=? ORDER BY rf.RDB$FIELD_POSITION""", (t,))
    cols = [(c[0].strip(), c[1], c[2], c[3]) for c in cur]
    cur.execute("SELECT COUNT(*) FROM %s" % t)
    out.write("%s (%d randuri)\n" % (t, cur.fetchone()[0]))
    for n, tp, ln, nn in cols:
        kind = 'BLOB' if tp == 261 else ('VARCHAR(%s)' % ln if tp == 37 else tp)
        out.write("    %-24s %-14s %s\n" % (n, kind, 'NOT NULL' if nn else ''))
    out.write("\n")

cur.execute("SELECT RDB$VIEW_SOURCE FROM RDB$RELATIONS WHERE RDB$RELATION_NAME='VW_TS_GOODS_DESCRIPTIONS'")
out.write("sursa view:\n%s\n\n" % r(cur.fetchone()[0]))

cur.execute("""SELECT RDB$TRIGGER_NAME, RDB$TRIGGER_TYPE, RDB$TRIGGER_SOURCE FROM RDB$TRIGGERS
               WHERE RDB$RELATION_NAME IN ('TS_GOODS_DESCRIPTIONS','VW_TS_GOODS_DESCRIPTIONS')
               AND COALESCE(RDB$SYSTEM_FLAG,0)=0""")
for n, tp, src in cur.fetchall():
    out.write("--- trigger %s (type %s)\n%s\n" % (n.strip(), tp, r(src)))

# continut existent pentru un procesor care are deja caracteristici
cur.execute("""SELECT FIRST 1 d.GOODSID, COUNT(*) FROM TS_GOODS_DESCRIPTIONS d
               JOIN TS_GOODS g ON g.GOODSID=d.GOODSID
               WHERE g.WEBGOODSTYPE_ID=8 GROUP BY 1 ORDER BY 2 DESC""")
row = cur.fetchone()
if row:
    gid = row[0]
    cur.execute("SELECT TITLE FROM TS_GOODS WHERE GOODSID=?", (gid,))
    out.write("\nexemplu procesor cu caracteristici: %d %s\n" % (gid, (cur.fetchone()[0] or '')[:70]))
    cur.execute("SELECT * FROM TS_GOODS_DESCRIPTIONS WHERE GOODSID=? ORDER BY 1", (gid,))
    names = [d[0] for d in cur.description]
    out.write("coloane: %s\n" % names)
    for rec in cur.fetchall():
        out.write("   %s\n" % (tuple(r(x) if hasattr(x, 'read') else x for x in rec),))
out.close(); con.close(); print('ok')
