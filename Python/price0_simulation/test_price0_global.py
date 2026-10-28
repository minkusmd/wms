"""Test local pentru DB Model/price0_global.sql si price0_global_rollback.sql (nu scrie nimic pe SW).

Copiaza din SW (tranzactie READ ONLY) schema minima + date reale intr-o baza Firebird 5 embedded:
toate randurile furnizorilor compensati (TPRICE_SUPPLIER_COST) si randurile in pret ale celorlalti
furnizori unde PRICE0 != PRICE7. Apoi:

  B   triggerul de azi (price0_suppliers.sql) pe datele reale -> trebuie sa dea PRICE1 salvat;
  A0  regulile dinainte de 3 oct (pasii 7a/7b din script) + baza PRICE7 (PRICE0 = 0) ->
      politica veche, reperul pentru compensare;
  C   price0_global.sql integral -> preturile noi; scriptul rulat a doua oara nu schimba nimic;
  R   price0_global_rollback.sql -> regulile si preturile revin la B.

Plus: cazuri construite pentru garda (84% / 85% / 150% / 151% / 0 / alta valuta) si apeluri la
GET_GOODS_COST, GET_GOODS_MARGIN, GET_FLG_CREDIT0, GET_GOODS_PRICE_CREDIT0, PRICE_CREDIT0,
UPDATE_COMPLECTPRICES.

Rulare: python test_price0_global.py   (parola SW in FIREBIRD_PASSWORD)
"""
import os
import re
import sys
import tempfile
from decimal import Decimal

import fdb

import test_trigger_local as base

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

SQL_NEW = os.path.join(base.REPO, 'DB Model', 'price0_global.sql')
SQL_RB = os.path.join(base.REPO, 'DB Model', 'price0_global_rollback.sql')
SQL_TODAY = os.path.join(base.REPO, 'DB Model', 'price0_suppliers.sql')
TESTDB = os.path.join(os.environ.get('CLAUDE_TMP', tempfile.gettempdir()), 'price0_global_test.fdb')
COMP = (202294, 198, 1455, 74995, 225846)
NAMES = {202294: 'Ultra', 198: 'Accent', 1455: 'Comitek', 74995: 'AIEA', 225846: 'Elcore', 74852: 'Teocom'}

FUNCS = base.FUNCS + ['GET_GOODS_MARGIN', 'GET_FLG_CREDIT0']
PROCS = base.PROCS + ['GET_GOODS_PRICE7', 'GET_GOODS_PRICE_CREDIT0', 'UPDATE_COMPLECTPRICES']
TABLES = dict(base.TABLES)
TABLES.update({'TPRICE': ['PGT_ID', 'PARENTID', 'TITLE', 'FLG_FOLDER'], 'TPRICE_GOODSTYPE_HISTORY': None,
               'TS_COMPLECTE': ['QTY', 'PARENTGOODS_ID', 'GOODSID']})
GF_IN_PRICE = 'BIN_AND(FLAGS, 8) = 8'


def script_statements(path):
    """Imparte un script isql (SET TERM ^) in instructiuni; COMMIT -> None."""
    text = open(path, encoding='ascii').read()
    text = re.sub(r'/\*.*?\*/', '', text, flags=re.S)
    out = []
    for part in text.split('^'):
        p = part.strip().lstrip(';').strip()   # "SET TERM ^ ;" lasa ";" in fata urmatoarei instructiuni
        if not p or p.upper().startswith('SET TERM'):
            continue
        out.append(None if p.upper() == 'COMMIT' else p)
    return out


def pre_oct_statements():
    """Pasii 7a/7b (revenirea la regulile dinainte de 3 oct), fara compensare."""
    text = open(SQL_NEW, encoding='ascii').read()
    return [l.strip().rstrip(';') for l in text.splitlines()
            if l.strip().startswith(('update TPRICE_GOODSTYPE set FORMULA = \'', 'delete from TPRICE_GOODSTYPE where'))]


def main():
    sw = base.SW()
    stub_price = ('begin select min(PRICE1) from TS_GOODS_FOREIGN where GOODSID = :GOODSID and '
                  'BIN_AND(FLAGS, 8) = 8 into :PRICE_MDL; PRICE = round(coalesce(:PRICE_MDL, 0)); '
                  'PRICE_MDL = coalesce(:PRICE_MDL, 0); CURRENCYID = 498; FLAGS = 0; suspend; end')
    funcs = [sw.function(f) for f in FUNCS]
    procs = [sw.procedure(p) for p in PROCS]
    stubs = [sw.procedure('SP_CALCULATE_PRICES_BY_PROMO', 'begin price = 0; currencyid = 498; suspend; end'),
             sw.procedure('GET_PROMO_PRICE7', 'begin price7 = 0; currency7id = 840; suspend; end'),
             sw.procedure('GET_GOODS_PRICE', stub_price)]
    other_trg = [sw.trigger_src(t) for t in base.OTHER_TRIGGERS]
    rule_trg = []
    for name in ('TPRICE_GOODSTYPE_AI', 'TPRICE_GOODSTYPE_AU'):
        r = sw.q('SELECT RDB$TRIGGER_SOURCE S, RDB$TRIGGER_TYPE T FROM RDB$TRIGGERS WHERE RDB$TRIGGER_NAME = ?',
                 (name,))[0]
        rule_trg.append('CREATE OR ALTER TRIGGER %s FOR TPRICE_GOODSTYPE ACTIVE %s POSITION 0\n%s' % (
            name, {2: 'AFTER INSERT', 4: 'AFTER UPDATE'}[r['T']], r['S']))
    tables = {t: sw.table(t, c) for t, c in TABLES.items()}
    script_new = [s for s in script_statements(SQL_NEW) if s]
    script_rb = [s for s in script_statements(SQL_RB) if s]
    trig_today = base.trigger_from_file(SQL_TODAY)
    texts = funcs + procs + stubs + other_trg + rule_trg + script_new + script_rb + [trig_today]
    doms = base.domains_used(texts)
    for t in texts:
        doms |= set(re.findall(r'\b(DM_[A-Z0-9_]+)\b', t, re.I))
    domain_ddl = sw.domains({d.upper() for d in doms})
    credit_expr = sw.q("SELECT F.RDB$COMPUTED_SOURCE S FROM RDB$RELATION_FIELDS RF JOIN RDB$FIELDS F "
                       "ON F.RDB$FIELD_NAME = RF.RDB$FIELD_SOURCE WHERE RF.RDB$RELATION_NAME = 'TS_GOODS_FOREIGN' "
                       "AND RF.RDB$FIELD_NAME = 'PRICE_CREDIT0'")[0]['S']

    # date - tupluri, nu dict-uri (memoria): data[tabel] = lista de (coloane, randuri)
    def fetch(sql):
        sw.cur.execute(sql)
        return [d[0].strip() for d in sw.cur.description], [tuple(base.read_blob(v) for v in r)
                                                             for r in sw.cur.fetchall()]

    gf_cols = tables['TS_GOODS_FOREIGN'][1]
    comp = ','.join(map(str, COMP))
    data = {t: [] for t in TABLES}
    # randurile in pret: toate coloanele (furnizorii compensati + ceilalti cu PRICE0 != PRICE7)
    data['TS_GOODS_FOREIGN'].append(fetch(
        'SELECT %s FROM TS_GOODS_FOREIGN WHERE %s AND (CUSTOMERID IN (%s) OR NOT (COALESCE(PRICE0, 0) = '
        'COALESCE(PRICE7, 0) AND COALESCE(CURRENCY0ID, CURRENCY7ID) = CURRENCY7ID))' % (
            ', '.join(gf_cols), GF_IN_PRICE, comp)))
    # restul randurilor furnizorilor compensati: doar cheia (pasul 7c cauta politicile dupa produsele lor)
    data['TS_GOODS_FOREIGN'].append(fetch(
        'SELECT GOODSID, CUSTOMERID, GOODS_CODE, FLAGS FROM TS_GOODS_FOREIGN WHERE CUSTOMERID IN (%s) AND NOT %s'
        % (comp, GF_IN_PRICE)))
    gids = sorted({r[0] for _, rows in data['TS_GOODS_FOREIGN'] for r in rows})
    goods = []
    for i in range(0, len(gids), 1000):
        goods += fetch('SELECT GOODSID, PARENTID FROM TS_GOODS WHERE GOODSID IN (%s)'
                       % ','.join(map(str, gids[i:i + 1000])))[1]
    data['TS_GOODS'].append((['GOODSID', 'PARENTID'], goods))
    parents = sorted({r[1] for r in goods if r[1] is not None})
    items = []
    for i in range(0, len(parents), 1000):
        items += fetch('SELECT CATALOGID, GOODSPARENTID FROM TWEB_CATALOG_ITEMS WHERE GOODSPARENTID IN (%s)'
                       % ','.join(map(str, parents[i:i + 1000])))[1]
    data['TWEB_CATALOG_ITEMS'].append((['CATALOGID', 'GOODSPARENTID'], items))
    data['TWEB_CATALOG'].append(fetch('SELECT CATALOGID, PGT_ID FROM TWEB_CATALOG WHERE PGT_ID > 0'))
    data['TS_CURRENCY'].append(fetch('SELECT %s FROM TS_CURRENCY' % ', '.join(tables['TS_CURRENCY'][1])))
    data['TPRICE_GOODSTYPE'].append(fetch('SELECT %s FROM TPRICE_GOODSTYPE'
                                          % ', '.join(tables['TPRICE_GOODSTYPE'][1])))
    data['TPRICE'].append(fetch('SELECT PGT_ID, PARENTID, TITLE, FLG_FOLDER FROM TPRICE'))
    full_cols, full_rows = data['TS_GOODS_FOREIGN'][0]
    ix = {c: i for i, c in enumerate(full_cols)}
    stored = {(r[ix['GOODSID']], r[ix['CUSTOMERID']], r[ix['GOODS_CODE']]): r[ix['PRICE1']] for r in full_rows}
    del goods, items, gids, parents
    sw.con.rollback()
    sw.con.close()
    print('date copiate:', {t: sum(len(rows) for _, rows in v) for t, v in data.items()})

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
    for col in ('PGT_ID', 'PRICECOLUMN', 'MIN_VALUE', 'SUPPLIERID'):
        ddl('ALTER TABLE TPRICE_GOODSTYPE ALTER %s SET NOT NULL' % col)
    ddl('ALTER TABLE TPRICE_GOODSTYPE_HISTORY ALTER USERID SET NOT NULL')  # ca pe SW: scriptul trebuie sa puna UserID
    ddl('ALTER TABLE TPRICE_GOODSTYPE ADD CONSTRAINT PK_TPRICE_GOODSTYPE PRIMARY KEY '
        '(PGT_ID, PRICECOLUMN, MIN_VALUE, SUPPLIERID)')
    ddl('ALTER TABLE TS_GOODS_FOREIGN ADD PRICE_CREDIT0 COMPUTED BY %s' % credit_expr)
    for f in funcs:
        ddl(f[:f.index(' AS\n')] + ' AS BEGIN RETURN NULL; END')
    for p in stubs + procs:
        if p.split()[4] in ('GET_GOODS_PRICE_CREDIT0', 'UPDATE_COMPLECTPRICES'):
            continue
        ddl(p)
    for f in funcs:
        ddl(f)
    for p in procs:
        if p.split()[4] in ('GET_GOODS_PRICE_CREDIT0', 'UPDATE_COMPLECTPRICES'):
            ddl(p)
    for t in other_trg + rule_trg:
        ddl(t)

    def load(prepare=()):
        ctx('DISSABLE_TRIGGERS', 'YES')
        ctx('UserID', '1')  # TPRICE_GOODSTYPE_AI scrie istoricul si la incarcare
        for t, chunks in data.items():
            if t == 'TPRICE_GOODSTYPE_HISTORY':
                continue
            cur.execute('DELETE FROM %s' % t)
            for cols, rows in chunks:
                if rows:
                    cur.executemany('INSERT INTO %s (%s) VALUES (%s)' % (
                        t, ', '.join(cols), ', '.join('?' * len(cols))), rows)
        cur.execute('DELETE FROM TPRICE_GOODSTYPE_HISTORY')
        con.commit()
        ctx('UserID', '1')
        for s in prepare:
            cur.execute(s)
        ctx('DISSABLE_TRIGGERS', None)
        con.commit()

    def update_all():
        ctx('UserID', '1')
        cur.execute('SELECT GOODSID, CUSTOMERID, GOODS_CODE FROM TS_GOODS_FOREIGN WHERE %s' % GF_IN_PRICE)
        errs = {}
        for g, c, code in cur.fetchall():
            try:
                cur.execute('UPDATE TS_GOODS_FOREIGN SET GOODSID = GOODSID WHERE GOODSID = ? AND CUSTOMERID = ? '
                            'AND GOODS_CODE = ?', (g, c, code))
            except fdb.DatabaseError as e:
                msg = (e.args[0] if e.args else str(e)).split('\n')
                errs[(g, c, code)] = ' | '.join(x.strip('- ') for x in msg[3:6])
        con.commit()
        cur.execute('SELECT GOODSID, CUSTOMERID, GOODS_CODE, PRICE6, PRICE1 FROM TS_GOODS_FOREIGN WHERE %s'
                    % GF_IN_PRICE)
        return {(g, c, code): (p6, p1) for g, c, code, p6, p1 in cur.fetchall()}, errs

    def run_script(stmts):
        for s in stmts:
            if s is None:
                con.commit()
            else:
                cur.execute(s)
        con.commit()

    def rules():
        cur.execute('SELECT PGT_ID, SUPPLIERID, MIN_VALUE, MAX_VALUE, FORMULA FROM TPRICE_GOODSTYPE '
                    'WHERE PRICECOLUMN = 6 ORDER BY 1, 2, 3')
        return cur.fetchall()

    problems = []

    # B: triggerul de azi
    ddl(trig_today)
    load()
    b, err_b = update_all()
    fid = [k for k, v in b.items() if k not in err_b and abs(float(v[1] or 0) - float(stored[k] or 0)) >
           max(1.0, 0.02 * float(stored[k] or 0))]
    print('B (azi): randuri %d, exceptii %d, PRICE1 diferit de cel salvat (>2%%): %d' % (len(b), len(err_b), len(fid)))

    # A0: regulile dinainte de 3 oct, baza PRICE7
    load(pre_oct_statements() + ['UPDATE TS_GOODS_FOREIGN SET PRICE0 = 0'])
    a0, err_a0 = update_all()
    print('A0 (inainte de 3 oct): exceptii %d' % len(err_a0))

    # C: scriptul nou
    load()
    rules_before = rules()
    run_script(script_statements(SQL_NEW))
    rules_c = rules()
    c, err_c = update_all()
    run_script(script_statements(SQL_NEW))
    rules_c2 = rules()
    print('C (nou): exceptii %d; reguli col.6 %d -> %d; a doua rulare schimba regulile: %s' % (
        len(err_c), len(rules_before), len(rules_c), rules_c != rules_c2))
    if rules_c != rules_c2:
        problems.append('scriptul nu e idempotent')
    left7 = [r for r in rules_c if ':vprice7' in (r[4] or '')]
    comp_bad = [r for r in rules_c if r[1] in COMP and '(:vprice0 * 1.05)' not in (r[4] or '')]
    print('  reguli cu :vprice7 ramase: %d; reguli ale furnizorilor compensati fara (:vprice0 * 1.05): %d' % (
        len(left7), len(comp_bad)))
    problems += ['vprice7 ramas'] * bool(left7) + ['compensare lipsa %s' % (comp_bad[:3],)] * bool(comp_bad)
    for sup in COMP:
        own = [r for r in rules_c if r[1] == sup]
        print('  %-8s reguli proprii: %3d  exemplu: %s' % (NAMES[sup], len(own), own[0][4] if own else '-'))
    only_new = set(err_c) - set(err_b)
    print('  exceptii doar cu scriptul nou: %d %s' % (len(only_new), sorted(only_new)[:5]))
    problems += ['exceptii noi'] * bool(only_new)

    # efectul pe furnizori
    print('\n%-9s %7s %10s %10s %10s %9s %9s %9s' % ('furnizor', 'randuri', 'P1 A0', 'P1 B', 'P1 C',
                                                   'C/A0 %', 'C/B %', 'B/A0 %'))
    agg = {}
    for k in c:
        if k in err_a0 or k in err_b or k in err_c:
            continue
        g = NAMES.get(k[1], 'altii')
        s = agg.setdefault(g, [0, 0.0, 0.0, 0.0])
        s[0] += 1
        s[1] += float(a0[k][1] or 0)
        s[2] += float(b[k][1] or 0)
        s[3] += float(c[k][1] or 0)
    for g, (n, sa, sb, sc) in sorted(agg.items(), key=lambda x: -x[1][0]):
        print('%-9s %7d %10.0f %10.0f %10.0f %9.2f %9.2f %9.2f' % (
            g, n, sa, sb, sc, (sc / sa - 1) * 100 if sa else 0, (sc / sb - 1) * 100 if sb else 0,
            (sb / sa - 1) * 100 if sa else 0))

    # garda: un rand real Accent in USD, PRICE0 variat
    print('\ngarda (trigger nou):')
    cur.execute('SELECT FIRST 1 GOODSID, CUSTOMERID, GOODS_CODE, ORD_PRICE7 FROM TS_GOODS_FOREIGN WHERE '
                'CUSTOMERID = 198 AND %s AND ORD_CURRENCY7ID = 840 AND ORD_PRICE7 > 50 AND BIN_AND(FLAGS, 16) = 0 '
                'AND BIN_AND(FLAGS, 128) = 0' % GF_IN_PRICE)
    g, cu, code, p7 = cur.fetchone()
    p7 = Decimal(str(p7))
    cur.execute('SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = 840')
    usd = Decimal(str(cur.fetchone()[0]))

    def p6_for(p0, c0):
        ctx('UserID', '1')
        cur.execute('UPDATE TS_GOODS_FOREIGN SET PRICE0 = ?, CURRENCY0ID = ? WHERE GOODSID = ? AND CUSTOMERID = ? '
                    'AND GOODS_CODE = ?', (p0, c0, g, cu, code))
        cur.execute('SELECT PRICE6 FROM TS_GOODS_FOREIGN WHERE GOODSID = ? AND CUSTOMERID = ? AND GOODS_CODE = ?',
                    (g, cu, code))
        v = float(cur.fetchone()[0])
        con.rollback()
        return v

    ref7 = p6_for(p7, 840)   # PRICE0 = PRICE7 -> formula compensata peste PRICE7
    for label, p0, c0, ratio in [('84%', p7 * Decimal('0.84'), 840, None), ('85%', p7 * Decimal('0.85'), 840, 0.85),
                                 ('100%', p7, 840, 1.0), ('150%', p7 * Decimal('1.5'), 840, 1.5),
                                 ('151%', p7 * Decimal('1.51'), 840, None), ('0', 0, 840, None),
                                 ('90% in MDL', (p7 * Decimal('0.9') * usd).quantize(Decimal('0.01')), 498, 0.9),
                                 ('aceeasi cifra in MDL', p7, 498, None)]:
        got = p6_for(p0, c0)
        exp = ref7 * ratio if ratio else ref7  # formula liniara -> PRICE6 proportional cu baza
        ok = abs(got - exp) <= max(0.02, exp * 0.002)
        print('  PRICE0 = %-20s PRICE6 %10.2f  asteptat %10.2f  %s' % (label, got, exp, 'OK' if ok else 'GRESIT'))
        problems += ['garda %s' % label] * (not ok)

    # obiectele secundare
    print('\nobiecte secundare:')
    cur.execute('SELECT FIRST 1 GOODSID FROM TS_GOODS_FOREIGN WHERE CUSTOMERID = 198 AND %s AND PRICE0 < PRICE7 '
                'AND PRICE0 >= PRICE7 * 0.9' % GF_IN_PRICE)
    gid = cur.fetchone()[0]
    for sql in ['SELECT PRICE, PRICE_MDL FROM GET_GOODS_COST(%d, 498, 0)' % gid,
                'SELECT PRICE, PRICE_MDL FROM GET_GOODS_COST(%d, 498, 1)' % gid,
                'SELECT PRICE, PRICE_MDL FROM GET_GOODS_COST(%d, 840, 0)' % gid,
                'SELECT PRICE_MDL FROM GET_GOODS_PRICE7(%d, 498)' % gid,
                'SELECT GET_GOODS_MARGIN(%d), GET_FLG_CREDIT0(%d) FROM RDB$DATABASE' % (gid, gid),
                'SELECT PRICE_MDL FROM GET_GOODS_PRICE_CREDIT0(%d)' % gid,
                'SELECT FIRST 3 CUSTOMERID, PRICE0, PRICE7, PRICE1, PRICE_CREDIT0 FROM TS_GOODS_FOREIGN '
                'WHERE GOODSID = %d' % gid,
                'SELECT COUNT(*), SUM(PRICE_CREDIT0) FROM TS_GOODS_FOREIGN WHERE %s' % GF_IN_PRICE]:
        try:
            cur.execute(sql)
            print('  %-75s -> %s' % (sql[:75], cur.fetchall()))
        except fdb.DatabaseError as e:
            print('  %-75s -> EROARE %s' % (sql[:75], str(e).split('\n')[-1]))
            problems.append('secundar: ' + sql[:40])
    # set: componentele = doua produse reale, setul = un rand in pret
    try:
        cur.execute('SELECT FIRST 2 GOODSID FROM TS_GOODS_FOREIGN WHERE CUSTOMERID = 198 AND %s' % GF_IN_PRICE)
        comps = [r[0] for r in cur.fetchall()]
        cur.execute('SELECT FIRST 1 GOODSID FROM TS_GOODS_FOREIGN WHERE CUSTOMERID = 74995 AND %s' % GF_IN_PRICE)
        kit = cur.fetchone()[0]
        for x in comps:
            cur.execute('INSERT INTO TS_COMPLECTE (PARENTGOODS_ID, GOODSID, QTY) VALUES (?, ?, 1)', (kit, x))
        ctx('UserID', '1')
        cur.execute('EXECUTE PROCEDURE UPDATE_COMPLECTPRICES(%d)' % kit)
        cur.execute('SELECT PRICE0, CURRENCY0ID, ORD_PRICE7, PRICE1 FROM TS_GOODS_FOREIGN WHERE GOODSID = %d' % kit)
        print('  set %d din %s: %s' % (kit, comps, cur.fetchall()))
        con.rollback()
    except fdb.DatabaseError as e:
        print('  UPDATE_COMPLECTPRICES -> EROARE', str(e).split('\n')[-1])
        problems.append('UPDATE_COMPLECTPRICES')
        con.rollback()

    # R: revenirea
    run_script(script_statements(SQL_RB))
    rules_r = rules()
    print('\nrevenire: regulile egale cu cele de dinainte: %s' % (rules_r == rules_before))
    problems += ['revenire reguli'] * (rules_r != rules_before)
    r, err_r = update_all()
    diff_r = [k for k in r if k not in err_b and k not in err_r and
              abs(float(r[k][1] or 0) - float(b[k][1] or 0)) > 0.011]
    print('revenire: PRICE1 diferit de B: %d, exceptii %d' % (len(diff_r), len(err_r)))
    problems += ['revenire preturi'] * bool(diff_r)

    con.close()
    print('\nREZULTAT:', 'OK' if not problems else problems, '- baza de test:', TESTDB)
    sys.exit(1 if problems else 0)


if __name__ == '__main__':
    main()
