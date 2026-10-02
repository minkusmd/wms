"""Simulare read-only: politica de preturi din PRICE0 (achizitie) in loc de PRICE7 (indicativ).

Reface calculul din triggerul TS_GOODS_FOREIGN_BIU (coloanele 6 -> 4 -> PRICE1) pentru
randurile in pret (bit 3) unde baza difera, o data cu baza veche (PRICE7) si o data cu baza
noua: PRICE0 daca 0 < PRICE0 < PRICE7 (cu +5% la rezultatul grilei coloanei 6), altfel PRICE7.
Foloseste aceleasi functii din baza
(GETGOODSFORMULABYRULES, CALCGOODSFORMULACOLUMN6/4, CONVERT_AMOUNT).

Ruleaza intr-o tranzactie READ ONLY (nu scrie nimic) si face rollback la final.
Rezultat: Excel cu rezumat pe furnizor, pe politica, detalii si erori.

Parola: variabila de mediu FIREBIRD_PASSWORD.
"""
import datetime
import os
import sys

import fdb
from openpyxl import Workbook
from openpyxl.styles import Font
from openpyxl.utils import get_column_letter

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

OUT = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
    os.path.dirname(os.path.abspath(__file__)), 'simulare_price0_%s.xlsx' % datetime.date.today().isoformat())

SIM_SQL = """
EXECUTE BLOCK RETURNS (
  GOODSID INTEGER, CUSTOMERID INTEGER, RULESID INTEGER, PGT_CNT INTEGER,
  EPP SMALLINT, PROMO SMALLINT, DRP SMALLINT, HAS_PROMO7 SMALLINT, BASE_SRC VARCHAR(10),
  MARGIN5 SMALLINT,
  PRICE0 DOUBLE PRECISION, CUR0 INTEGER, PRICE7 DOUBLE PRECISION, CUR7 INTEGER,
  PRICE3_MDL DOUBLE PRECISION,
  BASE_OLD_USD DOUBLE PRECISION, BASE_NEW_USD DOUBLE PRECISION,
  P6_OLD DOUBLE PRECISION, P6_NEW DOUBLE PRECISION,
  P4_OLD DOUBLE PRECISION, P4_NEW DOUBLE PRECISION,
  P8_OLD DOUBLE PRECISION, P8_NEW DOUBLE PRECISION,
  P1_STORED DOUBLE PRECISION, P1_OLD DOUBLE PRECISION, P1_NEW DOUBLE PRECISION,
  F6_OLD VARCHAR(255), F6_NEW VARCHAR(255),
  ERR_OLD VARCHAR(255), ERR_NEW VARCHAR(255))
AS
  DECLARE FLAGS INTEGER;
  DECLARE CUR6 INTEGER; DECLARE CUR4 INTEGER; DECLARE CUR1 INTEGER;
  DECLARE CUR2 INTEGER; DECLARE CUR3 INTEGER;
  DECLARE PRICE6_ST DM_AMOUNT; DECLARE PRICE2 DM_AMOUNT; DECLARE PRICE3 DM_AMOUNT;
  DECLARE PROMO_PRICE7 DM_AMOUNT;
  DECLARE K INTEGER;
  DECLARE BASE DM_AMOUNT; DECLARE BASE_CUR INTEGER; DECLARE BASE_USD DM_AMOUNT;
  DECLARE FORMULA DM_VARCHAR255; DECLARE MM DM_AMOUNT; DECLARE MMP DM_AMOUNT;
  DECLARE TMP DM_AMOUNT; DECLARE P6 DM_AMOUNT; DECLARE P4 DM_AMOUNT; DECLARE P8 DM_AMOUNT;
  DECLARE P1 DM_AMOUNT; DECLARE ERR VARCHAR(255); DECLARE F6 VARCHAR(255);
BEGIN
  FOR SELECT GF.GOODSID, GF.CUSTOMERID, GF.FLAGS,
             COALESCE(GF.PRICE0, 0), COALESCE(GF.CURRENCY0ID, GF.CURRENCY7ID),
             COALESCE(GF.PRICE7, 0), GF.CURRENCY7ID,
             COALESCE(GF.PRICE6, 0), GF.CURRENCY6ID, GF.CURRENCY4ID, COALESCE(GF.CURRENCY1ID, 498),
             COALESCE(GF.PRICE2, 0), COALESCE(GF.CURRENCY2ID, 498),
             COALESCE(GF.PRICE3, 0), GF.CURRENCY3ID, GF.PRICE1, COALESCE(GF.PROMO_PRICE7, 0)
      FROM TS_GOODS_FOREIGN GF
      WHERE GET_FLG_VALUE(GF.FLAGS, 3) = 1
        AND NOT (COALESCE(GF.PRICE0, 0) = COALESCE(GF.PRICE7, 0)
                 AND COALESCE(GF.CURRENCY0ID, GF.CURRENCY7ID) = GF.CURRENCY7ID)
      INTO :GOODSID, :CUSTOMERID, :FLAGS, :PRICE0, :CUR0, :PRICE7, :CUR7,
           :PRICE6_ST, :CUR6, :CUR4, :CUR1, :PRICE2, :CUR2, :PRICE3, :CUR3, :P1_STORED, :PROMO_PRICE7
  DO
  BEGIN
    EPP = GET_FLG_VALUE(FLAGS, 4);
    DRP = GET_FLG_VALUE(FLAGS, 7);
    PROMO = IIF(PRICE2 > 0, 1, 0);
    HAS_PROMO7 = IIF(PROMO_PRICE7 > 0, 1, 0);
    /* regula (user, 2 oct 2026): PRICE0 se foloseste doar daca 0 < PRICE0 < PRICE7 si
       PRICE0 >= 50% din PRICE7, altfel PRICE7; cand se foloseste PRICE0 se adauga +5% la grila
       (identic cu DB Model/price0_pricing.sql) */
    MARGIN5 = IIF(PRICE0 > 0 AND PRICE7 > 0
                  AND CONVERT_AMOUNT(PRICE0, CUR0, 840, 1) < CONVERT_AMOUNT(PRICE7, CUR7, 840, 1)
                  AND CONVERT_AMOUNT(PRICE0, CUR0, 840, 1) >= CONVERT_AMOUNT(PRICE7, CUR7, 840, 1) * 0.5, 1, 0);
    BASE_SRC = IIF(MARGIN5 = 1, 'PRICE0', 'PRICE7');
    PRICE3_MDL = IIF(PRICE3 > 0, CONVERT_AMOUNT(PRICE3, CUR3, 498, 1), 0);
    RULESID = -1;
    SELECT COUNT(DISTINCT C.PGT_ID), MAX(C.PGT_ID)
    FROM TWEB_CATALOG C
    JOIN TWEB_CATALOG_ITEMS I ON I.CATALOGID = C.CATALOGID AND C.PGT_ID > 0
    JOIN TS_GOODS G ON G.PARENTID = I.GOODSPARENTID AND G.GOODSID = :GOODSID
    INTO :PGT_CNT, :RULESID;
    RULESID = COALESCE(RULESID, -1);

    K = 0;
    WHILE (K < 2) DO
    BEGIN
      ERR = NULL; F6 = NULL; P6 = 0; P4 = 0; P8 = 0; P1 = 0;
      IF (K = 0) THEN BEGIN BASE = PRICE7; BASE_CUR = CUR7; END
      ELSE BEGIN BASE = IIF(MARGIN5 = 1, PRICE0, PRICE7); BASE_CUR = IIF(MARGIN5 = 1, CUR0, CUR7); END
      BASE_USD = CONVERT_AMOUNT(BASE, BASE_CUR, 840, 1);
      BEGIN
        IF (PGT_CNT > 1) THEN ERR = 'MAI MULTE POLITICI';
        /* coloana 6 (ca in trigger: fara promo si fara DRP cu PRICE6) */
        IF (ERR IS NULL) THEN
        BEGIN
          IF (PROMO = 0 AND (DRP = 0 OR PRICE6_ST = 0)) THEN
          BEGIN
            FORMULA = NULL; MM = NULL; MMP = NULL;
            SELECT FORMULA, MIN_MARGIN, MIN_MARGIN_PERCENT
            FROM GETGOODSFORMULABYRULES(:RULESID, 6, :CUSTOMERID, CONVERT_AMOUNT(:BASE, :BASE_CUR, 840, 1))
            INTO :FORMULA, :MM, :MMP;
            F6 = FORMULA;
            IF (COALESCE(FORMULA, '') = '') THEN ERR = 'FARA REGULA COL.6 (interval)';
            ELSE
              /* baza noua: +5% marja la grila cand achizitia (PRICE0) < indicativ (PRICE7) */
              P6 = CONVERT_AMOUNT(CALCGOODSFORMULACOLUMN6(:FORMULA, CONVERT_AMOUNT(:BASE, :BASE_CUR, 840, 1), :MM, :MMP)
                                  * IIF(:K = 1 AND :MARGIN5 = 1, 1.05, 1), 840, :CUR6, 1);
          END
          ELSE
            P6 = PRICE6_ST;
        END
        /* coloana 4 */
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
        /* PRICE1 */
        IF (ERR IS NULL) THEN
        BEGIN
          IF (PRICE2 > 0) THEN P1 = CONVERT_AMOUNT(PRICE2, CUR2, CUR1, 1);
          ELSE IF (PRICE3 > 0 AND EPP = 1) THEN
            P1 = MAXVALUE(CONVERT_AMOUNT(P8, 840, CUR1, 1), CONVERT_AMOUNT(PRICE3, CUR3, CUR1, 1));
          ELSE P1 = CONVERT_AMOUNT(P4, CUR4, CUR1, 1);
        END
        WHEN ANY DO ERR = 'EXCEPTIE gdscode=' || GDSCODE || ' sqlstate=' || SQLSTATE;
      END
      IF (K = 0) THEN
      BEGIN
        BASE_OLD_USD = BASE_USD; P6_OLD = P6; P4_OLD = P4; P8_OLD = P8; P1_OLD = P1;
        F6_OLD = F6; ERR_OLD = ERR;
      END
      ELSE
      BEGIN
        BASE_NEW_USD = BASE_USD; P6_NEW = P6; P4_NEW = P4; P8_NEW = P8; P1_NEW = P1;
        F6_NEW = F6; ERR_NEW = ERR;
      END
      K = K + 1;
    END
    SUSPEND;
  END
END
"""


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
        chunk = ','.join(str(x) for x in ids[i:i + 1000])
        cur.execute(f'SELECT GOODSID, CODE, TITLE FROM TS_GOODS WHERE GOODSID IN ({chunk})')
        for gid, code, title in cur.fetchall():
            titles[gid] = ((code or '').strip(), (title or '').strip())
    con.rollback()
    con.close()

    write_report(rows, sup, pgt, titles)


def median(a):
    a = sorted(a)
    return a[len(a) // 2] if a else None


def pct(new, old):
    return round((new / old - 1) * 100, 2) if old else None


def write_report(rows, sup, pgt, titles):
    for r in rows:
        r['SUPPLIER'] = sup.get(r['CUSTOMERID'], '')
        r['PGT'] = pgt.get(r['RULESID'], '')
        r['CODE'], r['TITLE'] = titles.get(r['GOODSID'], ('', ''))
        ok = not r['ERR_OLD'] and not r['ERR_NEW']
        r['OK'] = ok
        r['D_P1'] = (r['P1_NEW'] - r['P1_OLD']) if ok else None
        r['D_P1_PCT'] = pct(r['P1_NEW'], r['P1_OLD']) if ok else None
        # toleranta 2%: preturile salvate sunt calculate la cursul USD de atunci (ex. 17.76 vs 17.95 azi)
        r['FIDELITY'] = (abs(r['P1_OLD'] - (r['P1_STORED'] or 0)) <= max(1.0, 0.02 * (r['P1_STORED'] or 0))
                         if not r['ERR_OLD'] else None)
        # PRICE0 neplauzibil fata de indicativ (in afara 50%..150%) - candidat pentru garda
        r['P0_SUSPECT'] = 1 if (r['PRICE0'] and r['PRICE7'] and r['BASE_NEW_USD'] and r['BASE_OLD_USD'] and
                                not 0.5 <= r['BASE_NEW_USD'] / r['BASE_OLD_USD'] <= 1.5) else 0
        r['INTERVAL_CHANGED'] = 1 if (r['F6_OLD'] or '') != (r['F6_NEW'] or '') and ok else 0

    wb = Workbook()

    # --- rezumat pe furnizor
    ws = wb.active
    ws.title = 'Furnizori'
    hdr = ['Furnizor ID', 'Furnizor', 'Randuri simulate', 'Erori azi (P7)', 'Erori noi (P0)',
           'PRICE1 neschimbat', 'Scade', 'Creste', 'Variatie medie %', 'Mediana %', 'Min %', 'Max %',
           'Suma PRICE1 azi', 'Suma PRICE1 nou', 'Dif. totala %', 'Interval schimbat',
           'Fidelitate simulare % (P1 azi = P1 salvat)', 'Cu PROMO_PRICE7', 'Baza = PRICE7 (PRICE0 = 0)',
           'Cu +5% (PRICE0 < PRICE7)', 'PRICE0 suspect (<50% / >150% din PRICE7)',
           'Mediana % fara suspecte']
    ws.append(hdr)
    by = {}
    for r in rows:
        by.setdefault(r['CUSTOMERID'], []).append(r)
    summary = []
    for cid, rs in by.items():
        ok = [r for r in rs if r['OK']]
        d = sorted(r['D_P1_PCT'] for r in ok if r['D_P1_PCT'] is not None)
        s_old = sum(r['P1_OLD'] for r in ok)
        s_new = sum(r['P1_NEW'] for r in ok)
        fid = [r['FIDELITY'] for r in rs if r['FIDELITY'] is not None]
        summary.append([
            cid, sup.get(cid, ''), len(rs),
            sum(1 for r in rs if r['ERR_OLD']), sum(1 for r in rs if r['ERR_NEW'] and not r['ERR_OLD']),
            sum(1 for r in ok if abs(r['D_P1']) < 0.5),
            sum(1 for r in ok if r['D_P1'] <= -0.5), sum(1 for r in ok if r['D_P1'] >= 0.5),
            round(sum(d) / len(d), 2) if d else None, d[len(d) // 2] if d else None,
            d[0] if d else None, d[-1] if d else None,
            round(s_old), round(s_new), pct(s_new, s_old),
            sum(r['INTERVAL_CHANGED'] for r in rs),
            round(100 * sum(fid) / len(fid), 1) if fid else None,
            sum(r['HAS_PROMO7'] for r in rs), sum(1 for r in rs if r['BASE_SRC'] == 'PRICE7'),
            sum(r['MARGIN5'] for r in rs), sum(r['P0_SUSPECT'] for r in rs),
            median([r['D_P1_PCT'] for r in ok if r['D_P1_PCT'] is not None and not r['P0_SUSPECT'] and r['PRICE7']]),
        ])
    for row in sorted(summary, key=lambda x: -x[2]):
        ws.append(row)

    # --- pe politica
    ws2 = wb.create_sheet('Politici')
    ws2.append(['PGT_ID', 'Politica', 'Furnizor ID', 'Furnizor', 'Randuri', 'Erori noi',
                'Variatie medie %', 'Min %', 'Max %', 'Dif. totala %'])
    byp = {}
    for r in rows:
        byp.setdefault((r['RULESID'], r['CUSTOMERID']), []).append(r)
    prow = []
    for (pid, cid), rs in byp.items():
        ok = [r for r in rs if r['OK']]
        d = [r['D_P1_PCT'] for r in ok if r['D_P1_PCT'] is not None]
        s_old = sum(r['P1_OLD'] for r in ok)
        s_new = sum(r['P1_NEW'] for r in ok)
        prow.append([pid, pgt.get(pid, ''), cid, sup.get(cid, ''), len(rs),
                     sum(1 for r in rs if r['ERR_NEW'] and not r['ERR_OLD']),
                     round(sum(d) / len(d), 2) if d else None, min(d) if d else None,
                     max(d) if d else None, pct(s_new, s_old)])
    for row in sorted(prow, key=lambda x: -x[4]):
        ws2.append(row)

    # --- detalii
    cols = ['GOODSID', 'CODE', 'TITLE', 'CUSTOMERID', 'SUPPLIER', 'RULESID', 'PGT', 'EPP', 'PROMO', 'DRP',
            'HAS_PROMO7', 'BASE_SRC', 'MARGIN5', 'P0_SUSPECT', 'PRICE0', 'CUR0', 'PRICE7', 'CUR7', 'PRICE3_MDL',
            'BASE_OLD_USD', 'BASE_NEW_USD', 'F6_OLD', 'F6_NEW', 'P6_OLD', 'P6_NEW', 'P4_OLD', 'P4_NEW',
            'P8_OLD', 'P8_NEW', 'P1_STORED', 'P1_OLD', 'P1_NEW', 'D_P1', 'D_P1_PCT', 'INTERVAL_CHANGED',
            'FIDELITY', 'ERR_OLD', 'ERR_NEW']
    ws3 = wb.create_sheet('Detalii')
    ws3.append(cols)
    for r in sorted(rows, key=lambda x: (x['SUPPLIER'], x['D_P1_PCT'] if x['D_P1_PCT'] is not None else 0)):
        ws3.append([r[c] if not isinstance(r[c], bool) else int(r[c]) for c in cols])

    # --- erori
    ws4 = wb.create_sheet('Erori')
    ws4.append(['GOODSID', 'CODE', 'TITLE', 'Furnizor', 'Politica', 'Baza noua USD', 'Eroare azi', 'Eroare noua'])
    for r in rows:
        if r['ERR_OLD'] or r['ERR_NEW']:
            ws4.append([r['GOODSID'], r['CODE'], r['TITLE'], r['SUPPLIER'], r['PGT'], r['BASE_NEW_USD'],
                        r['ERR_OLD'], r['ERR_NEW']])

    for w in wb.worksheets:
        for c in w[1]:
            c.font = Font(bold=True)
        w.freeze_panes = 'A2'
        w.auto_filter.ref = w.dimensions
        for i, col in enumerate(w.iter_cols(min_row=1, max_row=min(w.max_row, 200)), 1):
            width = max(len(str(c.value)) if c.value is not None else 0 for c in col)
            w.column_dimensions[get_column_letter(i)].width = min(max(8, width + 2), 45)
    wb.save(OUT)
    print('raport:', OUT)

    print()
    print('%-8s %-28s %6s %6s %6s %6s %6s %8s %8s %6s' % (
        'ID', 'Furnizor', 'rand', 'errN', 'scade', 'creste', 'egal', 'medie%', 'total%', 'fid%'))
    for s in sorted(summary, key=lambda x: -x[2])[:20]:
        print('%-8s %-28s %6s %6s %6s %6s %6s %8s %8s %6s' % (
            s[0], s[1][:28], s[2], s[4], s[6], s[7], s[5], s[8], s[14], s[16]))


if __name__ == '__main__':
    main()
