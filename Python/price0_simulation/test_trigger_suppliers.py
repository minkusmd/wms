"""Test local pentru DB Model/price0_suppliers.sql (nu scrie nimic pe SW).

Regula (3 oct 2026): la Accent (198), Ultra Distribution (202294) si Comitek (1455) baza coloanei 6
e PRICE0 daca PRICE0 > 0, PRICE7 > 0 si PRICE0 >= 85% din PRICE7 (in USD); altfel, si la ceilalti furnizori, PRICE7.
Fara +5%.

Oracol independent de codul nou: triggerul de azi (price0_suppliers_rollback.sql) rulat pe aceleasi date,
dar cu baza pusa pe calea PRICE7:
  - randurile care trebuie sa foloseasca PRICE0: ORD_PRICE7 = PRICE0 (in valuta lui), PRICE0 = 0;
  - restul: PRICE0 = 0 (triggerul de azi ia atunci PRICE7, fara +5%).
Triggerul nou pe datele originale trebuie sa dea aceleasi PRICE6 / PRICE4 / PRICE1.

Esantion din SW (tranzactie READ ONLY): randuri FLG_IN_PRICE de la cei 3 furnizori (aleatoriu + toate
cazurile de prag) si randurile altor furnizori la care PRICE0 < PRICE7 (pe care regula din 2 oct le muta
pe PRICE0), plus produsul 202102 (Ultra 108551).

Rulare: python test_trigger_suppliers.py   (parola SW in FIREBIRD_PASSWORD)
"""
import os
import re
import sys
import tempfile

import fdb

import test_trigger_local as base

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

SQL_NEW = os.path.join(base.REPO, 'DB Model', 'price0_suppliers.sql')
SQL_TODAY = os.path.join(base.REPO, 'DB Model', 'price0_suppliers_rollback.sql')
TESTDB = os.path.join(os.environ.get('CLAUDE_TMP', tempfile.gettempdir()), 'price0_suppliers_test.fdb')
TARGETS = (198, 202294, 1455)
RATIO = 0.85

P0_USD = 'CONVERT_AMOUNT(PRICE0, coalesce(CURRENCY0ID, CURRENCY7ID), 840, 1)'
P7_USD = 'CONVERT_AMOUNT(ORD_PRICE7, ORD_CURRENCY7ID, 840, 1)'


def sample_keys(sw):
    keys = set()
    t = ','.join(map(str, TARGETS))
    cond_in = 'GET_FLG_VALUE(FLAGS, 3) = 1'
    p0 = 'CONVERT_AMOUNT(PRICE0, coalesce(CURRENCY0ID, CURRENCY7ID), 840, 1)'
    p7 = 'CONVERT_AMOUNT(PRICE7, CURRENCY7ID, 840, 1)'
    queries = [
        # aleatoriu, pe furnizor
        *['SELECT FIRST 300 GOODSID, CUSTOMERID, GOODS_CODE FROM TS_GOODS_FOREIGN WHERE CUSTOMERID = %d AND %s '
          'ORDER BY RAND()' % (c, cond_in) for c in TARGETS],
        # sub prag, peste PRICE7, aproape de prag
        'SELECT GOODSID, CUSTOMERID, GOODS_CODE FROM TS_GOODS_FOREIGN WHERE CUSTOMERID IN (%s) AND %s AND PRICE0 > 0 '
        'AND (%s < 0.9 * %s OR %s > %s)' % (t, cond_in, p0, p7, p0, p7),
        # ceilalti furnizori pe care regula din 2 oct ii muta pe PRICE0
        'SELECT GOODSID, CUSTOMERID, GOODS_CODE FROM TS_GOODS_FOREIGN WHERE CUSTOMERID NOT IN (%s) AND %s '
        'AND PRICE0 > 0 AND %s < %s' % (t, cond_in, p0, p7),
        'SELECT GOODSID, CUSTOMERID, GOODS_CODE FROM TS_GOODS_FOREIGN WHERE GOODSID = 202102',
    ]
    for q in queries:
        for r in sw.q(q):
            keys.add((r['GOODSID'], r['CUSTOMERID'], r['GOODS_CODE']))
    return keys


def main():
    sw = base.SW()
    trig_today = base.trigger_from_file(SQL_TODAY)
    trig_new = base.trigger_from_file(SQL_NEW)
    funcs = [sw.function(f) for f in base.FUNCS]
    procs = [sw.procedure(p) for p in base.PROCS]
    stubs = [sw.procedure('SP_CALCULATE_PRICES_BY_PROMO', 'begin price = 0; currencyid = 498; suspend; end'),
             sw.procedure('GET_PROMO_PRICE7', 'begin price7 = 0; currency7id = 840; suspend; end')]
    other_trg = [sw.trigger_src(t) for t in base.OTHER_TRIGGERS]
    tables = {t: sw.table(t, c) for t, c in base.TABLES.items()}
    doms = base.domains_used(funcs + procs + stubs + other_trg + [trig_today, trig_new])
    for t in funcs + procs + stubs:
        doms |= set(re.findall(r'\b(DM_[A-Z0-9_]+)\b', t))
    domain_ddl = sw.domains(doms)

    keys = sample_keys(sw)
    gids = sorted({k[0] for k in keys})
    data = {t: [] for t in base.TABLES}
    gf_cols = tables['TS_GOODS_FOREIGN'][1]
    for i in range(0, len(gids), 500):
        ch = ','.join(map(str, gids[i:i + 500]))
        data['TS_GOODS_FOREIGN'] += [r for r in sw.q('SELECT %s FROM TS_GOODS_FOREIGN WHERE GOODSID IN (%s)'
                                                     % (', '.join(gf_cols), ch))
                                     if (r['GOODSID'], r['CUSTOMERID'], r['GOODS_CODE']) in keys]
        data['TS_GOODS'] += sw.q('SELECT GOODSID, PARENTID FROM TS_GOODS WHERE GOODSID IN (%s)' % ch)
    parents = sorted({r['PARENTID'] for r in data['TS_GOODS'] if r['PARENTID'] is not None})
    for i in range(0, len(parents), 500):
        ch = ','.join(map(str, parents[i:i + 500]))
        data['TWEB_CATALOG_ITEMS'] += sw.q('SELECT CATALOGID, GOODSPARENTID FROM TWEB_CATALOG_ITEMS '
                                           'WHERE GOODSPARENTID IN (%s)' % ch)
    data['TWEB_CATALOG'] = sw.q('SELECT CATALOGID, PGT_ID FROM TWEB_CATALOG WHERE PGT_ID > 0')
    data['TS_CURRENCY'] = sw.q('SELECT %s FROM TS_CURRENCY' % ', '.join(tables['TS_CURRENCY'][1]))
    data['TPRICE_GOODSTYPE'] = sw.q('SELECT %s FROM TPRICE_GOODSTYPE' % ', '.join(tables['TPRICE_GOODSTYPE'][1]))
    sw.con.rollback()
    sw.con.close()
    print('date copiate:', {t: len(v) for t, v in data.items()})

    if os.path.exists(TESTDB):
        os.remove(TESTDB)
    con = fdb.create_database("create database '%s' user 'SYSDBA' page_size 8192 default character set UTF8"
                              % TESTDB, charset='UTF8', fb_library_name=base.LIB)
    cur = con.cursor()

    def ddl(s):
        cur.execute(s)
        con.commit()

    def ctx(name, value):
        cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION', ?, ?) FROM RDB$DATABASE", (name, value))
        cur.fetchone()

    for s in domain_ddl:
        ddl(s)
    ddl("CREATE EXCEPTION ERR_GENERAL_ERROR 'eroare'")
    for t, (s, _) in tables.items():
        ddl(s)
    for f in funcs:
        ddl(f[:f.index(' AS\n')] + ' AS BEGIN RETURN NULL; END')
    for f in funcs:
        ddl(f)
    for p in stubs + procs:
        ddl(p)
    for t in other_trg:
        ddl(t)

    def load(prepare_sql=()):
        ctx('DISSABLE_TRIGGERS', 'YES')
        for t, rows in data.items():
            cur.execute('DELETE FROM %s' % t)
            for r in rows:
                cols = list(r.keys())
                cur.execute('INSERT INTO %s (%s) VALUES (%s)' % (t, ', '.join(cols), ', '.join('?' * len(cols))),
                            [r[c] for c in cols])
        for s in prepare_sql:
            cur.execute(s)
        ctx('DISSABLE_TRIGGERS', None)
        con.commit()

    def update_all():
        ctx('UserID', '1')
        cur.execute('SELECT GOODSID, CUSTOMERID, GOODS_CODE FROM TS_GOODS_FOREIGN')
        errs = {}
        for g, c, code in cur.fetchall():
            try:
                cur.execute('UPDATE TS_GOODS_FOREIGN SET GOODSID = GOODSID WHERE GOODSID = ? AND CUSTOMERID = ? '
                            'AND GOODS_CODE = ?', (g, c, code))
                con.commit()
            except fdb.DatabaseError as e:
                con.rollback()
                ctx('UserID', '1')
                msg = (e.args[0] if e.args else str(e)).split('\n')
                errs[(g, c, code)] = ' | '.join(x.strip('- ') for x in msg[3:6])
        cur.execute('SELECT GOODSID, CUSTOMERID, GOODS_CODE, PRICE6, PRICE4, PRICE1 FROM TS_GOODS_FOREIGN')
        return {(g, c, code): (p6, p4, p1) for g, c, code, p6, p4, p1 in cur.fetchall()}, errs

    # decizia asteptata (pe datele originale; FLG_IN_PRICE, fara promotii in stub-uri -> PRICE7 = ORD_PRICE7)
    load()
    t = ','.join(map(str, TARGETS))
    cur.execute('SELECT GOODSID, CUSTOMERID, GOODS_CODE, IIF(CUSTOMERID IN (%s) AND coalesce(PRICE0, 0) > 0 AND %s > 0 AND '
                '%s >= %s * %s, 1, 0) FROM TS_GOODS_FOREIGN' % (t, P7_USD, P0_USD, P7_USD, RATIO))
    use0 = {(g, c, code): u for g, c, code, u in cur.fetchall()}
    con.commit()

    # 1. triggerul de azi pe datele originale (doar pentru comparatie / exemplu)
    ddl(trig_today)
    load()
    today, err_today = update_all()
    # 2. oracolul: triggerul de azi, baza pusa pe calea PRICE7
    load([
        'UPDATE TS_GOODS_FOREIGN SET ORD_PRICE7 = PRICE0, ORD_CURRENCY7ID = coalesce(CURRENCY0ID, CURRENCY7ID), '
        'PRICE0 = 0 WHERE CUSTOMERID IN (%s) AND coalesce(PRICE0, 0) > 0 AND %s > 0 AND %s >= %s * %s' % (
            t, P7_USD, P0_USD, P7_USD, RATIO),
        'UPDATE TS_GOODS_FOREIGN SET PRICE0 = 0 WHERE NOT (CUSTOMERID IN (%s) AND coalesce(PRICE0, 0) > 0 AND '
        '%s > 0 AND %s >= %s * %s)' % (t, P7_USD, P0_USD, P7_USD, RATIO),
    ])
    oracle, err_oracle = update_all()
    # 3. triggerul nou pe datele originale
    ddl(trig_new)
    load()
    new, err_new = update_all()

    names = {198: 'Accent', 202294: 'Ultra', 1455: 'Comitek'}
    stats, bad = {}, []
    for k, got in new.items():
        if k in err_new or k in err_oracle:
            continue
        exp = oracle[k]
        grp = (names.get(k[1], 'altii'), 'PRICE0' if use0[k] else 'PRICE7')
        s = stats.setdefault(grp, [0, 0, 0])
        s[0] += 1
        if any(abs(float(a or 0) - float(b or 0)) > 0.011 for a, b in zip(got, exp)):
            bad.append((k, got, exp))
        else:
            s[1] += 1
        if abs(float(got[0] or 0) - float(today[k][0] or 0)) > 0.011:
            s[2] += 1
    print('\n%-10s %-7s %8s %10s %16s' % ('furnizor', 'baza', 'randuri', 'ca oracol', 'PRICE6 schimbat'))
    for (sup, b), (n, ok, ch) in sorted(stats.items()):
        print('%-10s %-7s %8d %10d %16d' % (sup, b, n, ok, ch))
    for b in bad[:10]:
        print('  DIFERIT', b)
    only_new = set(err_new) - set(err_today)
    print('exceptii: azi %d, oracol %d, nou %d, doar cu triggerul nou %d %s' % (
        len(err_today), len(err_oracle), len(err_new), len(only_new), sorted(only_new)[:5]))

    ex = [k for k in new if k[0] == 202102 and k[1] == 202294]
    for k in ex:
        print('\nexemplu Ultra %s (goodsid %d): PRICE6 azi %s -> nou %s (oracol %s), PRICE1 azi %s -> nou %s' % (
            k[2], k[0], today[k][0], new[k][0], oracle[k][0], today[k][2], new[k][2]))

    con.close()
    errors = len(bad) + len(only_new)
    print('\nREZULTAT:', 'OK' if errors == 0 else '%d probleme' % errors, '- baza de test:', TESTDB)
    sys.exit(1 if errors else 0)


if __name__ == '__main__':
    main()
