"""Test local pentru DB Model/price0_compensation_in_policy.sql (+ _rollback.sql). Nu scrie nimic pe SW.

Copiaza din SW (tranzactie READ ONLY) obiectele de azi (GF_USE_PRICE0, GET_GOODS_COST,
GET_GOODS_PRICE_CREDIT0, UPDATE_COMPLECTPRICES, coloana PRICE_CREDIT0, TPRICE_SUPPLIER_COST,
regulile si furnizorii politicilor) intr-o baza Firebird 5 embedded, cu rindurile produsului
322279 (Ultra 202294: PRICE0 335 USD, PRICE1 6891 lei) si un set fictiv care il contine. Apoi:

  S   starea de azi: PRICE_CREDIT0 / costul cu factor 1.05 (ca pe SW);
  C   scriptul: perechile (politica, furnizor) lipsa apar in TPRICE_SUPPLIERS, tabela cu factor
      dispare, costul / rata 0% / PRICE0 al setului fara factor; a doua rulare nu schimba nimic;
  R   rollback-ul readuce factorul; apoi scriptul din nou.

Rulare: python test_compensation_in_policy.py   (parola SW in FIREBIRD_PASSWORD)
"""
import os
import re
import sys
import tempfile
from decimal import Decimal

import fdb

import test_trigger_local as base

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

SQL_NEW = os.path.join(base.REPO, 'DB Model', 'price0_compensation_in_policy.sql')
SQL_RB = os.path.join(base.REPO, 'DB Model', 'price0_compensation_in_policy_rollback.sql')
TESTDB = os.path.join(os.environ.get('CLAUDE_TMP', tempfile.gettempdir()), 'price0_comp_test.fdb')
GOODS = 322279
ULTRA = 202294
SET_ID = 999999
FUNCS = ['GET_FLG_VALUE', 'ROUND_MONEY', 'CONVERT_AMOUNT', 'GF_USE_PRICE0']
PROCS = ['GET_GOODS_COST', 'GET_GOODS_PRICE_CREDIT0', 'UPDATE_COMPLECTPRICES']
TABLES = {
    'TS_GOODS_FOREIGN': base.TABLES['TS_GOODS_FOREIGN'],
    'TS_CURRENCY': None,
    'TPRICE': ['PGT_ID', 'PARENTID', 'TITLE', 'FLG_FOLDER'],
    'TPRICE_GOODSTYPE': None,
    'TPRICE_SUPPLIERS': None,
    'TPRICE_SUPPLIER_COST': None,
    'TS_COMPLECTE': ['QTY', 'PARENTGOODS_ID', 'GOODSID'],
}


def script_statements(path):
    text = open(path, encoding='ascii').read()
    text = re.sub(r'/\*.*?\*/', '', text, flags=re.S)
    out = []
    for part in text.split('^'):
        p = part.strip().lstrip(';').strip()
        if not p or p.upper().startswith('SET TERM'):
            continue
        out.append(None if p.upper() == 'COMMIT' else p)
    return out


def main():
    sw = base.SW()
    stub_price = ('begin select min(PRICE1) from TS_GOODS_FOREIGN where GOODSID = :GOODSID and '
                  'BIN_AND(FLAGS, 8) = 8 into :PRICE_MDL; PRICE = round(coalesce(:PRICE_MDL, 0)); '
                  'PRICE_MDL = coalesce(:PRICE_MDL, 0); CURRENCYID = 498; FLAGS = 0; suspend; end')
    funcs = [sw.function(f) for f in FUNCS]
    procs = [sw.procedure(p) for p in PROCS]
    stubs = [sw.procedure('GET_GOODS_PRICE', stub_price),
             sw.procedure('GET_GOODS_PRICE7', 'begin price = 0; price_mdl = 0; currencyid = 498; suspend; end')]
    tables = {t: sw.table(t, c) for t, c in TABLES.items()}
    bd = sw.q("SELECT RDB$TRIGGER_SOURCE S FROM RDB$TRIGGERS WHERE RDB$TRIGGER_NAME = 'TPRICE_SUPPLIERS_BD'")[0]['S']
    trg_bd = 'CREATE OR ALTER TRIGGER TPRICE_SUPPLIERS_BD FOR TPRICE_SUPPLIERS ACTIVE BEFORE DELETE POSITION 0\n' + bd
    credit_expr = sw.q("SELECT F.RDB$COMPUTED_SOURCE S FROM RDB$RELATION_FIELDS RF JOIN RDB$FIELDS F "
                       "ON F.RDB$FIELD_NAME = RF.RDB$FIELD_SOURCE WHERE RF.RDB$RELATION_NAME = 'TS_GOODS_FOREIGN' "
                       "AND RF.RDB$FIELD_NAME = 'PRICE_CREDIT0'")[0]['S']
    script_new = script_statements(SQL_NEW)
    script_rb = script_statements(SQL_RB)
    texts = funcs + procs + stubs + [s for s in script_new + script_rb if s] + [credit_expr]
    doms = base.domains_used(texts)
    domain_ddl = sw.domains(doms)

    def fetch(sql, params=()):
        sw.cur.execute(sql, params)
        return [d[0].strip() for d in sw.cur.description], [tuple(base.read_blob(v) for v in r)
                                                             for r in sw.cur.fetchall()]

    data = {}
    gf_cols = tables['TS_GOODS_FOREIGN'][1]
    data['TS_GOODS_FOREIGN'] = fetch('SELECT %s FROM TS_GOODS_FOREIGN WHERE GOODSID = ?' % ', '.join(gf_cols), (GOODS,))
    for t in ('TS_CURRENCY', 'TPRICE', 'TPRICE_GOODSTYPE', 'TPRICE_SUPPLIERS', 'TPRICE_SUPPLIER_COST'):
        data[t] = fetch('SELECT %s FROM %s' % (', '.join(tables[t][1]), t))
    sw_credit = fetch('SELECT PRICE_CREDIT0, PRICE1 FROM TS_GOODS_FOREIGN WHERE GOODSID = ? AND CUSTOMERID = ?',
                      (GOODS, ULTRA))[1][0]
    sw_missing = fetch('SELECT COUNT(*) FROM (SELECT DISTINCT T.PGT_ID, T.SUPPLIERID FROM TPRICE_GOODSTYPE T '
                       'JOIN TPRICE P ON P.PGT_ID = T.PGT_ID WHERE NOT EXISTS (SELECT 1 FROM TPRICE_SUPPLIERS S '
                       'WHERE S.PGT_ID = T.PGT_ID AND S.SUPPLIERID = T.SUPPLIERID))')[1][0][0]
    sw.con.rollback()
    sw.con.close()
    print('date copiate:', {t: len(rows) for t, (_, rows) in data.items()}, '| perechi lipsa pe SW:', sw_missing)

    if os.path.exists(TESTDB):
        os.remove(TESTDB)
    con = fdb.create_database("create database '%s' user 'SYSDBA' page_size 8192 default character set UTF8"
                              % TESTDB, charset='UTF8', fb_library_name=base.LIB)
    cur = con.cursor()

    def ddl(s):
        cur.execute(s)
        con.commit()

    def one(sql, params=()):
        cur.execute(sql, params)
        r = cur.fetchone()
        return r[0] if r is not None and len(r) == 1 else r

    for s in domain_ddl:
        ddl(s)
    for t, (s, _) in tables.items():
        ddl(s)
    for t, col in (('TPRICE_SUPPLIERS', 'PGT_ID'), ('TPRICE_SUPPLIERS', 'SUPPLIERID'), ('TPRICE_SUPPLIER_COST', 'SUPPLIERID')):
        ddl('ALTER TABLE %s ALTER %s SET NOT NULL' % (t, col))
    ddl('ALTER TABLE TPRICE_SUPPLIERS ADD CONSTRAINT PK_TPRICE_SUPPLIERS PRIMARY KEY (PGT_ID, SUPPLIERID)')
    ddl('ALTER TABLE TPRICE_SUPPLIER_COST ADD CONSTRAINT PK_TPRICE_SUPPLIER_COST PRIMARY KEY (SUPPLIERID)')
    ddl(trg_bd)
    for f in funcs:
        ddl(f[:f.index(' AS\n')] + ' AS BEGIN RETURN NULL; END')
    for f in funcs:
        ddl(f)
    ddl('ALTER TABLE TS_GOODS_FOREIGN ADD PRICE_CREDIT0 COMPUTED BY %s' % credit_expr)
    for p in stubs + procs:
        ddl(p)

    for t, (cols, rows) in data.items():
        if rows:
            cur.executemany('INSERT INTO %s (%s) VALUES (%s)' % (t, ', '.join(cols), ', '.join('?' * len(cols))), rows)
    # set fictiv: 1 x produsul 322279
    ix = {c: i for i, c in enumerate(gf_cols)}
    ultra = [r for r in data['TS_GOODS_FOREIGN'][1] if r[ix['CUSTOMERID']] == ULTRA][0]
    setrow = list(ultra)
    setrow[ix['GOODSID']] = SET_ID
    setrow[ix['CUSTOMERID']] = -1
    setrow[ix['GOODS_CODE']] = 'SET'
    cur.execute('INSERT INTO TS_GOODS_FOREIGN (%s) VALUES (%s)' % (', '.join(gf_cols), ', '.join('?' * len(gf_cols))),
                setrow)
    cur.execute('INSERT INTO TS_COMPLECTE (QTY, PARENTGOODS_ID, GOODSID) VALUES (1, ?, ?)', (SET_ID, GOODS))
    con.commit()

    usd = one('SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = 840')
    p0 = Decimal(ultra[ix['PRICE0']])
    p1 = Decimal(ultra[ix['PRICE1']])
    cost_real = (p0 * Decimal(usd)).quantize(Decimal('1'))
    cost_fact = (p0 * Decimal('1.05') * Decimal(usd)).quantize(Decimal('1'))
    credit_real = max(p1, (p0 * Decimal(usd) * Decimal('1.16')).quantize(Decimal('1')))
    credit_fact = max(p1, (p0 * Decimal('1.05') * Decimal(usd) * Decimal('1.16')).quantize(Decimal('1')))
    print('USD %s | PRICE0 %s USD = %s lei | PRICE1 %s | asteptat: cost %s/%s (fara/cu factor), '
          'rate 0%% %s/%s' % (usd, p0, cost_real, p1, cost_real, cost_fact, credit_real, credit_fact))

    problems = []

    def check(label, got, exp):
        ok = got == exp
        print('  %s %s: %s (asteptat %s)' % ('OK ' if ok else 'NOK', label, got, exp))
        if not ok:
            problems.append(label)

    def state(label, with_factor):
        print(label)
        exists = one("SELECT COUNT(*) FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TPRICE_SUPPLIER_COST'")
        check('tabela TPRICE_SUPPLIER_COST exista', exists, 1 if with_factor else 0)
        # PRICE_MDL e nerotunjit (ca pe SW); se compara rotunjit la leu
        check('GET_GOODS_COST(..., 1)', Decimal(one('SELECT ROUND(PRICE_MDL) FROM GET_GOODS_COST(?, 498, 1)', (GOODS,))),
              cost_fact if with_factor else cost_real)
        check('GET_GOODS_COST(..., 0)', Decimal(one('SELECT ROUND(PRICE_MDL) FROM GET_GOODS_COST(?, 498, 0)', (GOODS,))),
              cost_real)
        check('GET_GOODS_PRICE_CREDIT0', Decimal(one('SELECT PRICE_MDL FROM GET_GOODS_PRICE_CREDIT0(?)', (GOODS,))),
              credit_fact if with_factor else credit_real)
        check('PRICE_CREDIT0 (coloana)', Decimal(one(
            'SELECT PRICE_CREDIT0 FROM TS_GOODS_FOREIGN WHERE GOODSID = ? AND CUSTOMERID = ?', (GOODS, ULTRA))),
              credit_fact if with_factor else credit_real)
        cur.execute('EXECUTE PROCEDURE UPDATE_COMPLECTPRICES(?)', (SET_ID,))
        con.commit()
        check('PRICE0 set (UPDATE_COMPLECTPRICES)', Decimal(one(
            'SELECT ROUND(PRICE0) FROM TS_GOODS_FOREIGN WHERE GOODSID = ?', (SET_ID,))), cost_fact if with_factor else cost_real)
        check('perechi (politica, furnizor) fara rind in TPRICE_SUPPLIERS', one(
            'SELECT COUNT(*) FROM (SELECT DISTINCT T.PGT_ID, T.SUPPLIERID FROM TPRICE_GOODSTYPE T '
            'JOIN TPRICE P ON P.PGT_ID = T.PGT_ID WHERE NOT EXISTS (SELECT 1 FROM TPRICE_SUPPLIERS S '
            'WHERE S.PGT_ID = T.PGT_ID AND S.SUPPLIERID = T.SUPPLIERID))'), sw_missing if label.startswith('S') else 0)
        check('regula Ultra in politica 17 (col 6)', one(
            'SELECT FORMULA FROM TPRICE_GOODSTYPE WHERE PGT_ID = 17 AND PRICECOLUMN = 6 AND SUPPLIERID = ?', (ULTRA,)),
              '((:vprice0 * 1.05) * 1.02)')

    def run(stmts):
        for s in stmts:
            if s is None:
                con.commit()
            else:
                cur.execute(s)
        con.commit()

    state('S: starea de azi (ca pe SW; PRICE_CREDIT0 pe SW = %s)' % sw_credit[0], True)
    check('PRICE_CREDIT0 local = SW', Decimal(one(
        'SELECT PRICE_CREDIT0 FROM TS_GOODS_FOREIGN WHERE GOODSID = ? AND CUSTOMERID = ?', (GOODS, ULTRA))),
          Decimal(sw_credit[0]))
    rules_before = one('SELECT COUNT(*) FROM TPRICE_GOODSTYPE')
    run(script_new)
    state('C: dupa price0_compensation_in_policy.sql', False)
    check('numar reguli neschimbat', one('SELECT COUNT(*) FROM TPRICE_GOODSTYPE'), rules_before)
    check('(17, Ultra) in TPRICE_SUPPLIERS', one(
        'SELECT COUNT(*) FROM TPRICE_SUPPLIERS WHERE PGT_ID = 17 AND SUPPLIERID = ?', (ULTRA,)), 1)
    run(script_new)
    state('C2: scriptul a doua oara', False)
    run(script_rb)
    state('R: dupa rollback', True)
    check('factori in TPRICE_SUPPLIER_COST', one('SELECT COUNT(*) FROM TPRICE_SUPPLIER_COST WHERE COST_FACTOR = 1.05'), 5)
    run(script_new)
    state('C3: scriptul dupa rollback', False)

    con.close()
    print('REZULTAT:', 'OK' if not problems else 'PROBLEME: ' + ', '.join(problems))
    return 0 if not problems else 1


if __name__ == '__main__':
    sys.exit(main())
