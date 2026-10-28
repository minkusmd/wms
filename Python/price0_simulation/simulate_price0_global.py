"""Simulare read-only: politica de preturi calculata integral din PRICE0 (17 oct 2026).

Trei scenarii pentru fiecare rand in pret (bit 3) unde PRICE0 si PRICE7 difera:

  A  politica veche: baza = PRICE7 (inainte de 3 oct 2026);
  B  azi pe SW (DB Model/price0_suppliers.sql): PRICE0 doar la 198/202294/1455,
     daca PRICE0 >= 85% din PRICE7, fara compensare;
  C  nou: baza = PRICE0 la toti furnizorii daca PRICE0 > 0, PRICE7 > 0 si
     50% <= PRICE0/PRICE7 <= 150% (USD), altfel PRICE7; la furnizorii compensati
     (COMP) formula regulii aleasa se inmulteste cu COMP_FACTOR in interior
     (:vprice7 -> (:vprice7 * 1.05)), exact cum vor arata regulile rescrise.

Reface calculul din triggerul TS_GOODS_FOREIGN_BIU (coloana 6 -> 4 -> PRICE1) cu
functiile din baza. Pretul in rate 0% = coloana calculata PRICE_CREDIT0
(maxvalue(PRICE1, round(cost * EXCHANGE_RATE * 1.16))), cost = PRICE7 (A/B) sau
PRICE0 cu rezerva PRICE7 (C).

Tranzactie READ ONLY + rollback: nu scrie nimic in baza.
Parola: variabila de mediu FIREBIRD_PASSWORD.
Utilizare: python simulate_price0_global.py [raport.xlsx] [factor]
"""
import datetime
import os
import sys

import fdb
from openpyxl import Workbook
from openpyxl.styles import Font
from openpyxl.utils import get_column_letter

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
    HERE, 'simulare_price0_global_%s.xlsx' % datetime.date.today().isoformat())
COMP_FACTOR = sys.argv[2] if len(sys.argv) > 2 else '1.05'
COMP = (202294, 198, 1455, 74995, 225846)   # furnizori cu PRICE0 < PRICE7 (Ultra, Accent, Comitek, AIEA, Elcore)
B_SUPPLIERS = (198, 202294, 1455)           # triggerul de azi
CREDIT_MARKUP = '1.16'                      # coloana calculata PRICE_CREDIT0

SIM_SQL = """
EXECUTE BLOCK RETURNS (
  GOODSID INTEGER, CUSTOMERID INTEGER, RULESID INTEGER, PGT_CNT INTEGER,
  EPP SMALLINT, PROMO SMALLINT, DRP SMALLINT,
  PRICE0 DOUBLE PRECISION, CUR0 INTEGER, PRICE7 DOUBLE PRECISION, CUR7 INTEGER,
  B7_USD DOUBLE PRECISION, B0_USD DOUBLE PRECISION,
  USE0_B SMALLINT, USE0_C SMALLINT, COMP SMALLINT,
  F6_A VARCHAR(255), F6_C VARCHAR(255),
  P1_STORED DOUBLE PRECISION,
  P1_A DOUBLE PRECISION, P1_B DOUBLE PRECISION, P1_C DOUBLE PRECISION,
  COST7_MDL DOUBLE PRECISION, COST0_MDL DOUBLE PRECISION,
  ERR_A VARCHAR(255), ERR_B VARCHAR(255), ERR_C VARCHAR(255))
AS
  DECLARE FLAGS INTEGER;
  DECLARE CUR6 INTEGER; DECLARE CUR4 INTEGER; DECLARE CUR1 INTEGER;
  DECLARE CUR2 INTEGER; DECLARE CUR3 INTEGER;
  DECLARE PRICE6_ST DM_AMOUNT; DECLARE PRICE2 DM_AMOUNT; DECLARE PRICE3 DM_AMOUNT;
  DECLARE K INTEGER;
  DECLARE BASE_USD DM_AMOUNT; DECLARE FACTOR VARCHAR(10);
  DECLARE FORMULA DM_VARCHAR255; DECLARE MM DM_AMOUNT; DECLARE MMP DM_AMOUNT;
  DECLARE TMP DM_AMOUNT; DECLARE P6 DM_AMOUNT; DECLARE P4 DM_AMOUNT; DECLARE P8 DM_AMOUNT;
  DECLARE P1 DM_AMOUNT; DECLARE ERR VARCHAR(255); DECLARE F6 VARCHAR(255);
BEGIN
  FOR SELECT GF.GOODSID, GF.CUSTOMERID, GF.FLAGS,
             COALESCE(GF.PRICE0, 0), COALESCE(GF.CURRENCY0ID, GF.CURRENCY7ID),
             COALESCE(GF.PRICE7, 0), GF.CURRENCY7ID,
             COALESCE(GF.PRICE6, 0), GF.CURRENCY6ID, GF.CURRENCY4ID, COALESCE(GF.CURRENCY1ID, 498),
             COALESCE(GF.PRICE2, 0), COALESCE(GF.CURRENCY2ID, 498),
             COALESCE(GF.PRICE3, 0), GF.CURRENCY3ID, GF.PRICE1
      FROM TS_GOODS_FOREIGN GF
      WHERE GET_FLG_VALUE(GF.FLAGS, 3) = 1
        AND NOT (COALESCE(GF.PRICE0, 0) = COALESCE(GF.PRICE7, 0)
                 AND COALESCE(GF.CURRENCY0ID, GF.CURRENCY7ID) = GF.CURRENCY7ID)
      INTO :GOODSID, :CUSTOMERID, :FLAGS, :PRICE0, :CUR0, :PRICE7, :CUR7,
           :PRICE6_ST, :CUR6, :CUR4, :CUR1, :PRICE2, :CUR2, :PRICE3, :CUR3, :P1_STORED
  DO
  BEGIN
    EPP = GET_FLG_VALUE(FLAGS, 4);
    DRP = GET_FLG_VALUE(FLAGS, 7);
    PROMO = IIF(PRICE2 > 0, 1, 0);
    B7_USD = CONVERT_AMOUNT(PRICE7, CUR7, 840, 1);
    B0_USD = IIF(PRICE0 > 0, CONVERT_AMOUNT(PRICE0, CUR0, 840, 1), 0);
    USE0_B = IIF(CUSTOMERID IN (%(B)s) AND B0_USD > 0 AND B7_USD > 0 AND B0_USD >= B7_USD * 0.85, 1, 0);
    USE0_C = IIF(B0_USD > 0 AND B7_USD > 0 AND B0_USD >= B7_USD * 0.5 AND B0_USD <= B7_USD * 1.5, 1, 0);
    COMP = IIF(CUSTOMERID IN (%(COMP)s), 1, 0);
    COST7_MDL = PRICE7 * (SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = :CUR7);
    COST0_MDL = IIF(PRICE0 > 0, PRICE0 * (SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = :CUR0), COST7_MDL);
    RULESID = -1;
    SELECT COUNT(DISTINCT C.PGT_ID), MAX(C.PGT_ID)
    FROM TWEB_CATALOG C
    JOIN TWEB_CATALOG_ITEMS I ON I.CATALOGID = C.CATALOGID AND C.PGT_ID > 0
    JOIN TS_GOODS G ON G.PARENTID = I.GOODSPARENTID AND G.GOODSID = :GOODSID
    INTO :PGT_CNT, :RULESID;
    RULESID = COALESCE(RULESID, -1);

    K = 0;
    WHILE (K < 3) DO
    BEGIN
      ERR = NULL; F6 = NULL; P6 = 0; P4 = 0; P8 = 0; P1 = 0; FACTOR = NULL;
      IF (K = 0) THEN BASE_USD = B7_USD;
      ELSE IF (K = 1) THEN BASE_USD = IIF(USE0_B = 1, B0_USD, B7_USD);
      ELSE
      BEGIN
        BASE_USD = IIF(USE0_C = 1, B0_USD, B7_USD);
        IF (COMP = 1) THEN FACTOR = '%(F)s';
      END
      BEGIN
        IF (PGT_CNT > 1) THEN ERR = 'MAI MULTE POLITICI';
        IF (ERR IS NULL) THEN
        BEGIN
          IF (PROMO = 0 AND (DRP = 0 OR PRICE6_ST = 0)) THEN
          BEGIN
            FORMULA = NULL; MM = NULL; MMP = NULL;
            SELECT FORMULA, MIN_MARGIN, MIN_MARGIN_PERCENT
            FROM GETGOODSFORMULABYRULES(:RULESID, 6, :CUSTOMERID, :BASE_USD)
            INTO :FORMULA, :MM, :MMP;
            IF (COALESCE(FORMULA, '') = '') THEN ERR = 'FARA REGULA COL.6 (interval)';
            ELSE
            BEGIN
              IF (FACTOR IS NOT NULL) THEN
                FORMULA = REPLACE(FORMULA, ':vprice7', '(:vprice7 * ' || FACTOR || ')');
              F6 = FORMULA;
              P6 = CONVERT_AMOUNT(CALCGOODSFORMULACOLUMN6(:FORMULA, :BASE_USD, :MM, :MMP), 840, :CUR6, 1);
            END
          END
          ELSE
            P6 = PRICE6_ST;
        END
        IF (ERR IS NULL) THEN
        BEGIN
          TMP = CONVERT_AMOUNT(P6, CUR6, 840, 1);
          FORMULA = NULL; MM = NULL; MMP = NULL;
          SELECT FORMULA, MIN_MARGIN, MIN_MARGIN_PERCENT
          FROM GETGOODSFORMULABYRULES(:RULESID, 4, :CUSTOMERID, :TMP)
          INTO :FORMULA, :MM, :MMP;
          IF (COALESCE(FORMULA, '') = '') THEN ERR = 'FARA REGULA COL.4 (interval)';
          ELSE
            SELECT CONVERT_AMOUNT(PRICE4, 840, :CUR4, 1), PRICE8
            FROM CALCGOODSFORMULACOLUMN4(:FORMULA, :TMP, CONVERT_AMOUNT(:P6, :CUR6, 840), CONVERT_AMOUNT(:P6, :CUR6, 840), :MM, :MMP)
            INTO :P4, :P8;
        END
        IF (ERR IS NULL) THEN
        BEGIN
          IF (PRICE2 > 0) THEN P1 = CONVERT_AMOUNT(PRICE2, CUR2, CUR1, 1);
          ELSE IF (PRICE3 > 0 AND EPP = 1) THEN
            P1 = MAXVALUE(CONVERT_AMOUNT(P8, 840, CUR1, 1), CONVERT_AMOUNT(PRICE3, CUR3, CUR1, 1));
          ELSE P1 = CONVERT_AMOUNT(P4, CUR4, CUR1, 1);
        END
        WHEN ANY DO ERR = 'EXCEPTIE gdscode=' || GDSCODE || ' sqlstate=' || SQLSTATE;
      END
      IF (K = 0) THEN BEGIN P1_A = P1; ERR_A = ERR; F6_A = F6; END
      ELSE IF (K = 1) THEN BEGIN P1_B = P1; ERR_B = ERR; END
      ELSE BEGIN P1_C = P1; ERR_C = ERR; F6_C = F6; END
      K = K + 1;
    END
    SUSPEND;
  END
END
""" % {'B': ', '.join(map(str, B_SUPPLIERS)), 'COMP': ', '.join(map(str, COMP)), 'F': COMP_FACTOR}


def pct(new, old):
    return round((new / old - 1) * 100, 2) if old else None


def q(a, p):
    a = sorted(a)
    return a[min(len(a) - 1, int(len(a) * p))] if a else None


def credit(p1, cost):
    return max(p1 or 0, round((cost or 0) * float(CREDIT_MARKUP)))


def main():
    con = fdb.connect(dsn='192.168.106.254/3050:SW', user='SYSDBA',
                      password=os.environ['FIREBIRD_PASSWORD'], charset='UTF8')
    con.begin(tpb=fdb.ISOLATION_LEVEL_READ_COMMITED_RO)
    cur = con.cursor()
    t0 = datetime.datetime.now()
    cur.execute(SIM_SQL)
    cols = [d[0].strip() for d in cur.description]
    rows = [dict(zip(cols, r)) for r in cur.fetchall()]
    print('randuri simulate:', len(rows), 'in', datetime.datetime.now() - t0)
    cur.execute('SELECT CUSTOMERID, NAME FROM TS_CUSTOMER WHERE CUSTOMERID IN '
                '(SELECT DISTINCT CUSTOMERID FROM TS_GOODS_FOREIGN WHERE GET_FLG_VALUE(FLAGS, 3) = 1)')
    sup = {r[0]: (r[1] or '').strip() for r in cur.fetchall()}
    cur.execute('SELECT PGT_ID, TITLE FROM TPRICE')
    pgt = {r[0]: (r[1] or '').strip() for r in cur.fetchall()}
    ids = sorted({r['GOODSID'] for r in rows})
    titles = {}
    for i in range(0, len(ids), 1000):
        cur.execute('SELECT GOODSID, CODE, TITLE FROM TS_GOODS WHERE GOODSID IN (%s)'
                    % ','.join(str(x) for x in ids[i:i + 1000]))
        for gid, code, title in cur.fetchall():
            titles[gid] = ((code or '').strip(), (title or '').strip())
    con.rollback()
    con.close()
    write_report(rows, sup, pgt, titles)


def write_report(rows, sup, pgt, titles):
    for r in rows:
        r['SUPPLIER'] = sup.get(r['CUSTOMERID'], '')
        r['PGT'] = pgt.get(r['RULESID'], '')
        r['CODE'], r['TITLE'] = titles.get(r['GOODSID'], ('', ''))
        r['OK'] = not (r['ERR_A'] or r['ERR_B'] or r['ERR_C'])
        r['D_CA'] = pct(r['P1_C'], r['P1_A']) if r['OK'] else None
        r['D_CB'] = pct(r['P1_C'], r['P1_B']) if r['OK'] else None
        r['D_BA'] = pct(r['P1_B'], r['P1_A']) if r['OK'] else None
        r['CR_A'] = credit(r['P1_A'], r['COST7_MDL'])
        r['CR_C'] = credit(r['P1_C'], r['COST0_MDL'])
        r['D_CR'] = pct(r['CR_C'], r['CR_A']) if r['OK'] else None
        r['M_A'] = pct(r['P1_A'], r['COST7_MDL']) if r['OK'] else None   # marja pe PRICE7 (cum se vede azi)
        r['M_C'] = pct(r['P1_C'], r['COST0_MDL']) if r['OK'] else None   # marja pe costul real dupa schimbare
        r['M_A0'] = pct(r['P1_A'], r['COST0_MDL']) if r['OK'] else None  # marja reala inainte de 3 oct
        r['FID'] = (abs(r['P1_B'] - (r['P1_STORED'] or 0)) <= max(1.0, 0.02 * (r['P1_STORED'] or 0))
                    if not r['ERR_B'] else None)
        f6c = (r['F6_C'] or '').replace('(:vprice7 * %s)' % COMP_FACTOR, ':vprice7')
        r['INTERVAL_CHANGED'] = 1 if r['OK'] and f6c != (r['F6_A'] or '') else 0

    wb = Workbook()
    ws = wb.active
    ws.title = 'Furnizori'
    hdr = ['Furnizor ID', 'Furnizor', 'Compensat', 'Randuri', 'Erori A', 'Erori C noi',
           'Garda cazuta (C pe PRICE7)', 'Fidelitate B=salvat %',
           'Suma P1 A (PRICE7)', 'Suma P1 B (azi)', 'Suma P1 C (nou)',
           'Total C vs A %', 'Total C vs B %', 'Total B vs A %',
           'Mediana C vs A %', 'p10 C vs A %', 'p90 C vs A %', 'Mediana C vs B %',
           'C sub A >2%', 'C peste A >2%',
           'Marja reala mediana A % (P1/PRICE0)', 'Marja reala mediana C %',
           'Rate 0% total C vs A %', 'Interval schimbat']
    ws.append(hdr)
    by = {}
    for r in rows:
        by.setdefault(r['CUSTOMERID'], []).append(r)
    summary = []
    for cid, rs in by.items():
        ok = [r for r in rs if r['OK']]
        sa, sb, sc = (sum(r[k] for r in ok) for k in ('P1_A', 'P1_B', 'P1_C'))
        dca = [r['D_CA'] for r in ok if r['D_CA'] is not None]
        dcb = [r['D_CB'] for r in ok if r['D_CB'] is not None]
        fid = [r['FID'] for r in rs if r['FID'] is not None]
        summary.append([
            cid, sup.get(cid, ''), 'da' if rs[0]['COMP'] else '', len(rs),
            sum(1 for r in rs if r['ERR_A']), sum(1 for r in rs if r['ERR_C'] and not r['ERR_A']),
            sum(1 for r in rs if not r['USE0_C']),
            round(100 * sum(fid) / len(fid), 1) if fid else None,
            round(sa), round(sb), round(sc), pct(sc, sa), pct(sc, sb), pct(sb, sa),
            q(dca, 0.5), q(dca, 0.1), q(dca, 0.9), q(dcb, 0.5),
            sum(1 for d in dca if d < -2), sum(1 for d in dca if d > 2),
            q([r['M_A0'] for r in ok if r['M_A0'] is not None], 0.5),
            q([r['M_C'] for r in ok if r['M_C'] is not None], 0.5),
            pct(sum(r['CR_C'] for r in ok), sum(r['CR_A'] for r in ok)),
            sum(r['INTERVAL_CHANGED'] for r in rs),
        ])
    summary.sort(key=lambda x: -x[3])
    for row in summary:
        ws.append(row)

    ws2 = wb.create_sheet('Politici')
    ws2.append(['PGT_ID', 'Politica', 'Furnizor ID', 'Furnizor', 'Randuri', 'Total C vs A %',
                'Total C vs B %', 'Min C vs A %', 'Max C vs A %'])
    byp = {}
    for r in rows:
        byp.setdefault((r['RULESID'], r['CUSTOMERID']), []).append(r)
    prow = []
    for (pid, cid), rs in byp.items():
        ok = [r for r in rs if r['OK']]
        d = [r['D_CA'] for r in ok if r['D_CA'] is not None]
        prow.append([pid, pgt.get(pid, ''), cid, sup.get(cid, ''), len(rs),
                     pct(sum(r['P1_C'] for r in ok), sum(r['P1_A'] for r in ok)),
                     pct(sum(r['P1_C'] for r in ok), sum(r['P1_B'] for r in ok)),
                     min(d) if d else None, max(d) if d else None])
    for row in sorted(prow, key=lambda x: -x[4]):
        ws2.append(row)

    cols = ['GOODSID', 'CODE', 'TITLE', 'CUSTOMERID', 'SUPPLIER', 'COMP', 'RULESID', 'PGT', 'EPP', 'PROMO', 'DRP',
            'PRICE0', 'CUR0', 'PRICE7', 'CUR7', 'B0_USD', 'B7_USD', 'USE0_B', 'USE0_C', 'F6_A', 'F6_C',
            'P1_STORED', 'P1_A', 'P1_B', 'P1_C', 'D_CA', 'D_CB', 'D_BA', 'M_A0', 'M_C', 'CR_A', 'CR_C', 'D_CR',
            'FID', 'ERR_A', 'ERR_B', 'ERR_C']
    ws3 = wb.create_sheet('Detalii')
    ws3.append(cols)
    for r in sorted(rows, key=lambda x: (x['SUPPLIER'], x['D_CA'] if x['D_CA'] is not None else 0)):
        ws3.append([int(r[c]) if isinstance(r[c], bool) else r[c] for c in cols])

    ws4 = wb.create_sheet('Erori')
    ws4.append(['GOODSID', 'CODE', 'TITLE', 'Furnizor', 'Politica', 'Eroare A', 'Eroare B', 'Eroare C'])
    for r in rows:
        if not r['OK']:
            ws4.append([r['GOODSID'], r['CODE'], r['TITLE'], r['SUPPLIER'], r['PGT'],
                        r['ERR_A'], r['ERR_B'], r['ERR_C']])

    for w in wb.worksheets:
        for c in w[1]:
            c.font = Font(bold=True)
        w.freeze_panes = 'A2'
        w.auto_filter.ref = w.dimensions
        for i, col in enumerate(w.iter_cols(min_row=1, max_row=min(w.max_row, 200)), 1):
            width = max(len(str(c.value)) if c.value is not None else 0 for c in col)
            w.column_dimensions[get_column_letter(i)].width = min(max(8, width + 2), 45)
    wb.save(OUT)
    print('raport:', OUT, ' factor compensare:', COMP_FACTOR)
    print()
    print('%-7s %-24s %4s %6s %5s %5s %9s %9s %9s %7s %7s %7s %7s %7s' % (
        'ID', 'Furnizor', 'comp', 'rand', 'errC', 'garda', 'C-A tot%', 'C-B tot%', 'B-A tot%',
        'med', 'p10', 'p90', 'mrjA0', 'mrjC'))
    for s in summary[:25]:
        print('%-7s %-24s %4s %6s %5s %5s %9s %9s %9s %7s %7s %7s %7s %7s' % (
            s[0], s[1][:24], s[2], s[3], s[5], s[6], s[11], s[12], s[13], s[14], s[15], s[16], s[20], s[21]))


if __name__ == '__main__':
    main()
