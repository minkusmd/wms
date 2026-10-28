"""Recalcul in masa pe SW dupa price0_global.sql (ca "Recalcula preturile" pe toate politicile).

Aceleasi randuri ca UPDATE_PRICES_WITH_RULE: produsele din mapele cu politica (PGT_ID > 0) care au
flag 3 sau 5 in TDB_GOODS_FLAGS; se ating randurile lor in pret (bit 3). Spre deosebire de
RECALC_ALL_PGT, un rand cu exceptie nu opreste restul: erorile se colecteaza. Commit la 500 de randuri.
Preturile inainte / dupa -> CSV in acelasi director.
"""
import csv
import datetime
import os
import sys

import fdb

OUT = os.path.dirname(os.path.abspath(__file__))
con = fdb.connect(dsn='192.168.106.254/3050:SW', user='SYSDBA', password=os.environ['FIREBIRD_PASSWORD'],
                  charset='UTF8')
# read committed + nowait: un rand blocat de alta sesiune intra in erori, nu asteapta
con.default_tpb = bytes([fdb.isc_tpb_version3, fdb.isc_tpb_write, fdb.isc_tpb_read_committed,
                         fdb.isc_tpb_rec_version, fdb.isc_tpb_nowait])
con.begin()
cur = con.cursor()

cur.execute("""
    SELECT gf.GOODSID, gf.CUSTOMERID, gf.GOODS_CODE, gf.PRICE1, gf.PRICE6, gf.PRICE4, gf.PRICE_CREDIT0
    FROM TS_GOODS_FOREIGN gf
    WHERE BIN_AND(gf.FLAGS, 8) = 8
      AND gf.GOODSID IN (
        SELECT DISTINCT g.GOODSID
        FROM TWEB_CATALOG c
        JOIN TWEB_CATALOG_ITEMS i ON i.CATALOGID = c.CATALOGID AND c.PGT_ID > 0
        JOIN TS_GOODS g ON g.PARENTID = i.GOODSPARENTID
        JOIN TDB_GOODS_FLAGS f ON f.GOODSID = g.GOODSID AND f.FLAGTYPEID IN (3, 5))
""")
rows = cur.fetchall()
con.commit()
print('randuri de recalculat:', len(rows), datetime.datetime.now().strftime('%H:%M:%S'))
sys.stdout.flush()

stamp = datetime.datetime.now().strftime('%Y%m%d_%H%M')
before_path = os.path.join(OUT, 'recalc_before_%s.csv' % stamp)
with open(before_path, 'w', newline='', encoding='utf-8') as f:
    w = csv.writer(f)
    w.writerow(['GOODSID', 'CUSTOMERID', 'GOODS_CODE', 'PRICE1', 'PRICE6', 'PRICE4', 'PRICE_CREDIT0'])
    w.writerows(rows)

cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION', 'UserID', '1') FROM RDB$DATABASE")
cur.fetchone()
errors = []
done = 0
for g, c, code, *_ in rows:
    try:
        cur.execute('UPDATE TS_GOODS_FOREIGN SET GOODSID = GOODSID WHERE GOODSID = ? AND CUSTOMERID = ? '
                    'AND GOODS_CODE = ?', (g, c, code))
    except fdb.DatabaseError as e:
        msg = (e.args[0] if e.args else str(e)).replace('\n', ' | ')
        errors.append((g, c, code, msg[:300]))
    done += 1
    if done % 500 == 0:
        con.commit()
        cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION', 'UserID', '1') FROM RDB$DATABASE")
        cur.fetchone()
        print('  %d / %d, erori %d  %s' % (done, len(rows), len(errors), datetime.datetime.now().strftime('%H:%M:%S')))
        sys.stdout.flush()
con.commit()

keys = {(r[0], r[1], r[2]) for r in rows}
cur.execute('SELECT GOODSID, CUSTOMERID, GOODS_CODE, PRICE1, PRICE6, PRICE4, PRICE_CREDIT0 FROM TS_GOODS_FOREIGN '
            'WHERE BIN_AND(FLAGS, 8) = 8')
after = [r for r in cur.fetchall() if (r[0], r[1], r[2]) in keys]
con.commit()
after_path = os.path.join(OUT, 'recalc_after_%s.csv' % stamp)
with open(after_path, 'w', newline='', encoding='utf-8') as f:
    w = csv.writer(f)
    w.writerow(['GOODSID', 'CUSTOMERID', 'GOODS_CODE', 'PRICE1', 'PRICE6', 'PRICE4', 'PRICE_CREDIT0'])
    w.writerows(after)
with open(os.path.join(OUT, 'recalc_errors_%s.csv' % stamp), 'w', newline='', encoding='utf-8') as f:
    csv.writer(f).writerows(errors)

b = {(r[0], r[1], r[2]): r for r in rows}
agg = {}
names = {202294: 'Ultra', 198: 'Accent', 1455: 'Comitek', 74995: 'AIEA', 225846: 'Elcore', 74852: 'Teocom'}
zero_new = 0
for r in after:
    k = (r[0], r[1], r[2])
    old = float(b[k][3] or 0)
    new = float(r[3] or 0)
    if new == 0 and old > 0:
        zero_new += 1
    s = agg.setdefault(names.get(r[1], 'altii'), [0, 0.0, 0.0, 0])
    s[0] += 1
    s[1] += old
    s[2] += new
    s[3] += abs(new - old) >= 0.5
print('\nterminat %s: randuri %d, erori %d, PRICE1 devenit 0: %d' % (
    datetime.datetime.now().strftime('%H:%M:%S'), len(rows), len(errors), zero_new))
print('%-9s %7s %12s %12s %8s %9s' % ('furnizor', 'randuri', 'P1 inainte', 'P1 dupa', 'dif %', 'schimbate'))
for n, (cnt, so, sn, ch) in sorted(agg.items(), key=lambda x: -x[1][0]):
    print('%-9s %7d %12.0f %12.0f %8.2f %9d' % (n, cnt, so, sn, (sn / so - 1) * 100 if so else 0, ch))
for e in errors[:10]:
    print('  eroare', e)
print('fisiere:', before_path, after_path)
