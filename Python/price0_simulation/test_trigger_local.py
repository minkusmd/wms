"""Test local pentru DB Model/price0_pricing.sql (nu scrie nimic pe SW).

1. Citeste din SW (tranzactie READ ONLY) metadatele necesare - domenii, functiile si procedurile
   de reguli cu sursa reala, structura tabelelor - si un esantion de randuri reale.
2. Creeaza o baza Firebird 5 embedded temporara, cu schema minima + datele copiate.
   SP_CALCULATE_PRICES_BY_PROMO si GET_PROMO_PRICE7 sunt stub-uri (fara promotii) - esantionul
   exclude randurile in promotie.
3. Aplica price0_pricing_rollback.sql (triggerul de azi), face UPDATE pe toate randurile si compara
   PRICE6/PRICE4/PRICE1 cu simularea ("azi"); apoi reincarca datele, aplica price0_pricing.sql si
   compara cu simularea ("nou"). La final - cazuri construite (praguri 0 / 50% / 100%, valute).

Rulare: python test_trigger_local.py   (parola SW in FIREBIRD_PASSWORD)
"""
import os
import re
import sys
import tempfile
from decimal import Decimal

import fdb
from openpyxl import load_workbook

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, '..', '..'))
SQL_NEW = os.path.join(REPO, 'DB Model', 'price0_pricing.sql')
SQL_OLD = os.path.join(REPO, 'DB Model', 'price0_pricing_rollback.sql')
SIM_XLSX = os.path.join(HERE, 'simulare_price0_2026-10-02.xlsx')
LIB = r'C:\Program Files\Firebird\Firebird_5_0\fbclient.dll'
TESTDB = os.path.join(os.environ.get('CLAUDE_TMP', tempfile.gettempdir()), 'price0_trigger_test.fdb')

FUNCS = ['GET_FLG_VALUE', 'SET_FLG_VALUE', 'ROUND_MONEY', 'CONVERT_AMOUNT',
         'CALCGOODSFORMULACOLUMN6', 'CALCGOODSFORMULACOLUMN5']
PROCS = ['GETGOODSFORMULABYRULES', 'CALCGOODSFORMULACOLUMN4']
STUB_PROCS = ['SP_CALCULATE_PRICES_BY_PROMO', 'GET_PROMO_PRICE7']
TABLES = {  # tabel -> coloane (None = toate, fara cele calculate)
    # doar coloanele folosite de triggere (unele coloane text sunt OCTETS si nu se copiaza ca UTF8)
    'TS_GOODS_FOREIGN': ['GOODSID', 'CUSTOMERID', 'GOODS_CODE', 'FLAGS', 'LAST_PRICE_DATE', 'LAST_PRICE7_DATE',
                         'PRICE0', 'CURRENCY0ID', 'PRICE1', 'CURRENCY1ID', 'PRICE2', 'CURRENCY2ID',
                         'PRICE3', 'CURRENCY3ID', 'PRICE4', 'CURRENCY4ID', 'PRICE5', 'CURRENCY5ID',
                         'PRICE6', 'CURRENCY6ID', 'PRICE7', 'CURRENCY7ID', 'PRICE8', 'MARGIN5', 'MARGIN6',
                         'PROMO_PRICE7', 'PROMO_CURRENCY7ID', 'ORD_PRICE7', 'ORD_CURRENCY7ID'],
    'TS_CURRENCY': None,
    'TPRICE_GOODSTYPE': None,
    'TWEB_CATALOG': ['CATALOGID', 'PGT_ID'],
    'TWEB_CATALOG_ITEMS': ['CATALOGID', 'GOODSPARENTID'],
    'TS_GOODS': ['GOODSID', 'PARENTID'],
    'TWEB_PA_GOODS': ['PROMOACTIONID', 'GOODSID'],
    'TWEB_PROMOS': ['PROMOACTIONID', 'FLAGS'],
}
OTHER_TRIGGERS = ['TRG_TS_GOODS_FOREIGN_BU']  # BEFORE UPDATE pozitia 0, ruleaza inaintea BIU


def type_sql(f):
    """f = dict din RDB$FIELDS -> tip SQL."""
    t, st, ln, sc, pr = f['T'], f['ST'] or 0, f['CL'] or f['LEN'], f['SC'] or 0, f['PR'] or 0
    if t in (7, 8, 16, 26) and (st in (1, 2) or sc < 0):
        return '%s(%d,%d)' % ('NUMERIC' if st != 2 else 'DECIMAL',
                              pr or {7: 4, 8: 9, 16: 18, 26: 38}[t], -sc)
    simple = {7: 'SMALLINT', 8: 'INTEGER', 16: 'BIGINT', 26: 'INT128', 10: 'FLOAT', 27: 'DOUBLE PRECISION',
              12: 'DATE', 13: 'TIME', 35: 'TIMESTAMP', 23: 'BOOLEAN', 24: 'DECFLOAT(16)', 25: 'DECFLOAT(34)',
              28: 'TIME WITH TIME ZONE', 29: 'TIMESTAMP WITH TIME ZONE'}
    if t in simple:
        return simple[t]
    if t == 14:
        return 'CHAR(%d)' % ln
    if t == 37:
        return 'VARCHAR(%d)' % ln
    if t == 261:
        return 'BLOB SUB_TYPE %d' % st
    raise ValueError('tip necunoscut %s' % f)


def read_blob(v):
    return v.read() if hasattr(v, 'read') else v


class SW:
    def __init__(self):
        # aceeasi biblioteca ca baza embedded: fdb incarca fbclient o singura data, la prima conexiune
        self.con = fdb.connect(dsn='192.168.106.254/3050:SW', user='SYSDBA',
                               password=os.environ['FIREBIRD_PASSWORD'], charset='UTF8', fb_library_name=LIB)
        self.con.begin(tpb=fdb.ISOLATION_LEVEL_READ_COMMITED_RO)
        self.cur = self.con.cursor()

    def q(self, sql, params=()):
        self.cur.execute(sql, params)
        cols = [d[0].strip() for d in self.cur.description]
        return [dict(zip(cols, [read_blob(v) for v in r])) for r in self.cur.fetchall()]

    def field(self, name):
        r = self.q('SELECT RDB$FIELD_TYPE T, RDB$FIELD_SUB_TYPE ST, RDB$FIELD_LENGTH LEN, '
                   'RDB$CHARACTER_LENGTH CL, RDB$FIELD_SCALE SC, RDB$FIELD_PRECISION PR, '
                   'RDB$COMPUTED_SOURCE CS FROM RDB$FIELDS WHERE RDB$FIELD_NAME = ?', (name,))[0]
        return r

    def domains(self, names):
        out = []
        for n in sorted(names):
            out.append('CREATE DOMAIN %s AS %s' % (n, type_sql(self.field(n))))
        return out

    def param_list(self, rows):
        parts = []
        for r in rows:
            src = r['SRC'].strip()
            p = '%s %s' % (r['NAME'].strip(), src if not src.startswith('RDB$') else type_sql(self.field(src)))
            if r.get('DEF'):
                p += ' ' + r['DEF'].strip()  # ex. "= 0" / "DEFAULT 0"
            parts.append(p)
        return parts

    def function(self, name):
        args = self.q('SELECT RDB$ARGUMENT_POSITION POS, RDB$ARGUMENT_NAME NAME, RDB$FIELD_SOURCE SRC, '
                      'RDB$DEFAULT_SOURCE DEF '
                      'FROM RDB$FUNCTION_ARGUMENTS WHERE RDB$FUNCTION_NAME = ? ORDER BY 1', (name,))
        src = self.q('SELECT RDB$FUNCTION_SOURCE S FROM RDB$FUNCTIONS WHERE RDB$FUNCTION_NAME = ?', (name,))[0]['S']
        ret = [a for a in args if a['POS'] == 0][0]
        rs = ret['SRC'].strip()
        rtype = rs if not rs.startswith('RDB$') else type_sql(self.field(rs))
        ins = self.param_list([a for a in args if a['POS'] > 0])
        return 'CREATE OR ALTER FUNCTION %s (%s) RETURNS %s AS\n%s' % (name, ', '.join(ins), rtype, src)

    def procedure(self, name, stub_body=None):
        ps = self.q('SELECT RDB$PARAMETER_TYPE T, RDB$PARAMETER_NUMBER N, RDB$PARAMETER_NAME NAME, '
                    'RDB$FIELD_SOURCE SRC, RDB$DEFAULT_SOURCE DEF '
                    'FROM RDB$PROCEDURE_PARAMETERS WHERE RDB$PROCEDURE_NAME = ? '
                    'ORDER BY 1, 2', (name,))
        ins = self.param_list([p for p in ps if p['T'] == 0])
        outs = self.param_list([p for p in ps if p['T'] == 1])
        src = stub_body or self.q('SELECT RDB$PROCEDURE_SOURCE S FROM RDB$PROCEDURES WHERE RDB$PROCEDURE_NAME = ?',
                                  (name,))[0]['S']
        return 'CREATE OR ALTER PROCEDURE %s %s %s AS\n%s' % (
            name, '(%s)' % ', '.join(ins) if ins else '', 'RETURNS (%s)' % ', '.join(outs) if outs else '', src)

    def table(self, name, cols):
        fs = self.q('SELECT RF.RDB$FIELD_NAME NAME, RF.RDB$FIELD_SOURCE SRC FROM RDB$RELATION_FIELDS RF '
                    'WHERE RF.RDB$RELATION_NAME = ? ORDER BY RF.RDB$FIELD_POSITION', (name,))
        defs, names = [], []
        for f in fs:
            n = f['NAME'].strip()
            if cols and n not in cols:
                continue
            fld = self.field(f['SRC'].strip())
            if fld['CS']:
                continue  # coloana calculata (ex. PRICE_CREDIT0)
            defs.append('%s %s' % (n, type_sql(fld)))
            names.append(n)
        return 'CREATE TABLE %s (%s)' % (name, ', '.join(defs)), names

    def trigger_src(self, name):
        r = self.q('SELECT RDB$TRIGGER_SOURCE S, RDB$TRIGGER_TYPE T, RDB$TRIGGER_SEQUENCE Q '
                   'FROM RDB$TRIGGERS WHERE RDB$TRIGGER_NAME = ?', (name,))[0]
        kinds = {1: 'BEFORE INSERT', 3: 'BEFORE UPDATE', 17: 'BEFORE INSERT OR UPDATE'}
        return 'CREATE OR ALTER TRIGGER %s FOR TS_GOODS_FOREIGN ACTIVE %s POSITION %d\n%s' % (
            name, kinds[r['T']], r['Q'], r['S'])


def domains_used(texts):
    names = set()
    for t in texts:
        names |= set(m.upper() for m in re.findall(r'\b(dm_[a-z0-9_]+)\b', t, re.I))
    return names


def trigger_from_file(path):
    t = open(path, encoding='ascii').read()
    return t[t.index('CREATE OR ALTER TRIGGER'):t.index('^\n\nSET TERM ; ^')]


def sample_from_simulation():
    wb = load_workbook(SIM_XLSX, read_only=True)
    it = wb['Detalii'].iter_rows(values_only=True)
    h = next(it)
    ix = {c: i for i, c in enumerate(h)}
    rows = []
    for r in it:
        if r[ix['PROMO']] or r[ix['HAS_PROMO7']] or r[ix['DRP']] or r[ix['ERR_OLD']] or r[ix['ERR_NEW']]:
            continue
        rows.append({k: r[ix[k]] for k in ('GOODSID', 'CUSTOMERID', 'MARGIN5', 'P0_SUSPECT', 'P6_OLD', 'P6_NEW',
                                           'P4_OLD', 'P4_NEW', 'P1_OLD', 'P1_NEW', 'SUPPLIER')})
    # esantion: pana la 120 de randuri pe furnizor, cu ambele ramuri (PRICE0 folosit / nefolosit)
    picked, per = [], {}
    for r in rows:
        key = (r['CUSTOMERID'], r['MARGIN5'])
        if per.get(key, 0) < 60:
            per[key] = per.get(key, 0) + 1
            picked.append(r)
    return picked


def main():
    sample = sample_from_simulation()
    print('esantion din simulare:', len(sample), 'randuri,', len({r['CUSTOMERID'] for r in sample}), 'furnizori,',
          sum(r['MARGIN5'] for r in sample), 'cu PRICE0 folosit')

    sw = SW()
    trig_old = trigger_from_file(SQL_OLD)
    trig_new = trigger_from_file(SQL_NEW)
    funcs = [sw.function(f) for f in FUNCS]
    procs = [sw.procedure(p) for p in PROCS]
    stubs = [sw.procedure('SP_CALCULATE_PRICES_BY_PROMO',
                          'begin price = 0; currencyid = 498; suspend; end'),
             sw.procedure('GET_PROMO_PRICE7', 'begin price7 = 0; currency7id = 840; suspend; end')]
    other_trg = [sw.trigger_src(t) for t in OTHER_TRIGGERS]
    tables = {t: sw.table(t, c) for t, c in TABLES.items()}
    doms = domains_used(funcs + procs + stubs + other_trg + [trig_old, trig_new])
    # domeniile parametrilor
    for t in funcs + procs + stubs:
        doms |= set(re.findall(r'\b(DM_[A-Z0-9_]+)\b', t))
    domain_ddl = sw.domains(doms)

    # date
    keys = [(r['GOODSID'], r['CUSTOMERID']) for r in sample]
    gids = sorted({k[0] for k in keys})
    data = {t: [] for t in TABLES}
    gf_cols = tables['TS_GOODS_FOREIGN'][1]
    for i in range(0, len(gids), 500):
        ch = ','.join(map(str, gids[i:i + 500]))
        data['TS_GOODS_FOREIGN'] += [r for r in sw.q('SELECT %s FROM TS_GOODS_FOREIGN WHERE GOODSID IN (%s) '
                                                     'AND GET_FLG_VALUE(FLAGS, 3) = 1' % (', '.join(gf_cols), ch))
                                     if (r['GOODSID'], r['CUSTOMERID']) in set(keys)]
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

    # baza locala
    if os.path.exists(TESTDB):
        os.remove(TESTDB)
    con = fdb.create_database("create database '%s' user 'SYSDBA' page_size 8192 default character set UTF8"
                              % TESTDB, charset='UTF8', fb_library_name=LIB)
    cur = con.cursor()

    def ddl(s):
        cur.execute(s)
        con.commit()

    for s in domain_ddl:
        ddl(s)
    ddl("CREATE EXCEPTION ERR_GENERAL_ERROR 'eroare'")
    for t, (s, _) in tables.items():
        ddl(s)
    # functiile se refera una la alta -> intai declaratii goale, apoi corpurile reale
    for f in funcs:
        head = f[:f.index(' AS\n')]
        ddl(head + ' AS BEGIN RETURN NULL; END')
    for f in funcs:
        ddl(f)
    for p in stubs + procs:
        ddl(p)
    for t in other_trg:
        ddl(t)

    def load():
        cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS', 'YES') FROM RDB$DATABASE"); cur.fetchone()
        for t, rows in data.items():
            cur.execute('DELETE FROM %s' % t)
            for r in rows:
                cols = list(r.keys())
                try:
                    cur.execute('INSERT INTO %s (%s) VALUES (%s)' % (t, ', '.join(cols), ', '.join('?' * len(cols))),
                                [r[c] for c in cols])
                except fdb.DatabaseError:
                    print('INSERT esuat in', t, {c: (type(r[c]).__name__, repr(r[c])[:40]) for c in cols})
                    raise
        cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS', NULL) FROM RDB$DATABASE"); cur.fetchone()
        con.commit()

    def run(trigger_ddl, label, sfx):
        ddl(trigger_ddl)
        load()
        cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION', 'UserID', 1) FROM RDB$DATABASE"); cur.fetchone()
        # rand cu rand: un rand care da exceptie in trigger nu trebuie sa opreasca restul
        cur.execute('SELECT GOODSID, CUSTOMERID, GOODS_CODE FROM TS_GOODS_FOREIGN')
        trg_err = {}
        for g, c, code in cur.fetchall():
            try:
                cur.execute('UPDATE TS_GOODS_FOREIGN SET GOODSID = GOODSID WHERE GOODSID = ? AND CUSTOMERID = ? '
                            'AND GOODS_CODE = ?', (g, c, code))
                con.commit()
            except fdb.DatabaseError as e:
                con.rollback()
                cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION', 'UserID', 1) FROM RDB$DATABASE"); cur.fetchone()
                msg = (e.args[0] if e.args else str(e)).split('\n')
                trg_err[(g, c)] = ' | '.join(x.strip('- ') for x in msg[3:6])
        cur.execute('SELECT GOODSID, CUSTOMERID, PRICE6, PRICE4, PRICE1 FROM TS_GOODS_FOREIGN')
        all_rows = cur.fetchall()
        got = {(g, c): (p6, p4, p1) for g, c, p6, p4, p1 in all_rows}
        # acelasi produs + furnizor cu mai multe coduri: simularea nu are GOODS_CODE -> nu se pot compara
        cnt = {}
        for g, c, *_ in all_rows:
            cnt[(g, c)] = cnt.get((g, c), 0) + 1
        dup = {k for k, n in cnt.items() if n > 1}
        bad = []
        for r in sample:
            k = (r['GOODSID'], r['CUSTOMERID'])
            if k not in got or k in trg_err or k in dup:
                continue
            p6, p4, p1 = got[k]
            exp = (r['P6_' + sfx], r['P4_' + sfx], r['P1_' + sfx])
            if any(abs(float(a or 0) - float(b or 0)) > 0.011 for a, b in zip((p6, p4, p1), exp)):
                bad.append((k, (p6, p4, p1), exp, r['SUPPLIER']))
        compared = len([1 for r in sample if (r['GOODSID'], r['CUSTOMERID']) in got
                        and (r['GOODSID'], r['CUSTOMERID']) not in trg_err
                        and (r['GOODSID'], r['CUSTOMERID']) not in dup])
        print('%-22s comparate %4d  identice cu simularea %4d  diferite %d  (exceptii %d, coduri multiple %d)' % (
            label, compared, compared - len(bad), len(bad), len(trg_err), len(dup)))
        for b in bad[:8]:
            print('    ', b)
        return len(bad), trg_err

    n_old, err_old = run(trig_old, 'trigger AZI (PRICE7):', 'OLD')
    n_new, err_new = run(trig_new, 'trigger NOU (PRICE0):', 'NEW')
    errors = n_old + n_new
    for k, m in sorted(err_old.items()):
        print('  exceptie (si azi):', k, m)
    only_new = set(err_new) - set(err_old)
    print('  exceptii doar cu triggerul nou:', len(only_new), sorted(only_new)[:10])
    errors += len(only_new)

    # cazuri construite: un rand real, cu PRICE0 variat fata de PRICE7
    print('\ncazuri construite (trigger nou):')
    base = next(r for r in data['TS_GOODS_FOREIGN'] if (r['CURRENCY7ID'] == 840 and (r['ORD_PRICE7'] or 0) > 50))
    p7 = Decimal(str(base['ORD_PRICE7']))
    cur.execute('SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = 840')
    usd = Decimal(str(cur.fetchone()[0]))
    cases = [
        ('PRICE0 = 0', 0, 840, False), ('PRICE0 NULL', None, 840, False),
        ('PRICE0 = PRICE7', p7, 840, False), ('PRICE0 > PRICE7', p7 * Decimal('1.2'), 840, False),
        ('PRICE0 = 90% PRICE7', p7 * Decimal('0.9'), 840, True),
        ('PRICE0 = 50% PRICE7', p7 * Decimal('0.5'), 840, True),
        ('PRICE0 = 49% PRICE7', p7 * Decimal('0.49'), 840, False),
        ('PRICE0 90% in MDL', (p7 * Decimal('0.9') * usd).quantize(Decimal('0.01')), 498, True),
        ('aceeasi cifra, MDL', p7, 498, False),
    ]

    def price6_for(p0, c0):
        cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION', 'UserID', 1) FROM RDB$DATABASE"); cur.fetchone()
        cur.execute('UPDATE TS_GOODS_FOREIGN SET PRICE0 = ?, CURRENCY0ID = ? WHERE GOODSID = ? AND CUSTOMERID = ? '
                    'AND GOODS_CODE = ?', (p0, c0, base['GOODSID'], base['CUSTOMERID'], base['GOODS_CODE']))
        cur.execute('SELECT PRICE6, PRICE0 FROM TS_GOODS_FOREIGN WHERE GOODSID = ? AND CUSTOMERID = ? '
                    'AND GOODS_CODE = ?', (base['GOODSID'], base['CUSTOMERID'], base['GOODS_CODE']))
        r = cur.fetchone()
        con.rollback()
        return r

    p6_ref = price6_for(0, 840)[0]
    for label, p0, c0, expect_p0 in cases:
        p6, p0_after = price6_for(p0, c0)
        used = abs(float(p6) - float(p6_ref)) > 0.005
        ok = used == expect_p0
        errors += not ok
        print('  %-22s PRICE6 = %10s (PRICE7 -> %s)  PRICE0 dupa = %s  %s' % (
            label, p6, p6_ref, p0_after, 'OK' if ok else 'GRESIT (asteptat %s)' % (
                'PRICE0' if expect_p0 else 'PRICE7')))
    # +5%: la 90%, PRICE6 = formula(0.9 * PRICE7) * 1.05 -> la formulele liniare ~ 0.945 * PRICE6(PRICE7)
    p6_90 = price6_for(p7 * Decimal('0.9'), 840)[0]
    print('  raport PRICE6(90%%) / PRICE6(PRICE7) = %.4f (formula liniara -> 0.9 * 1.05 = 0.945)'
          % (float(p6_90) / float(p6_ref)))
    con.close()
    print('\nREZULTAT:', 'OK' if errors == 0 else '%d probleme' % errors, '- baza de test:', TESTDB)
    sys.exit(1 if errors else 0)


if __name__ == '__main__':
    main()
