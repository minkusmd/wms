"""Renumeroteaza TS_GOODS_IMAGE.ORDERNO la 1..n pentru produsele cu goluri sau duplicate.

De ce: site-ul (fantastic.web) ia imaginea principala si cea din card strict de pe
ORDERNO = 1, iar galeria parcurge pozitiile 1..count+1. Un produs cu imagini doar pe
pozitiile 2, 3 apare fara imagine principala; pozitiile de dupa un gol nu apar deloc.

Ce schimba: doar ORDERNO. Ordinea relativa ramine cea actuala (ORDERNO, apoi
GOODS_IMAGE_ID la egalitate). GOODS_IMAGE_ID (cheia primara) si IMAGE nu se ating.

Efect secundar: trigger-ul TS_GOODS_IMAGE_BU pune FLG_NEED2RECREATE = 0 la orice
UPDATE care nu schimba imaginea (la fel ca reordonarea din WMS).

Utilizare:
  python renumber.py                 -> dry run pe produsele de pe site (TWEB_CACHE_GOODS)
  python renumber.py dry all         -> dry run pe toata baza
  python renumber.py apply site      -> backup local + scriere, produsele de pe site
  python renumber.py apply all       -> backup local + scriere, toata baza
Re-rulabil: a doua rulare nu mai gaseste nimic de schimbat.
Parola: variabila de mediu FIREBIRD_PASSWORD (ca la serverul MCP).
"""
import datetime
import io
import json
import os
import sys
from collections import OrderedDict

from firebird.driver import connect, tpb, Isolation

HERE = os.path.dirname(os.path.abspath(__file__))
DSN = '192.168.106.254/3050:SW'
LOCK_TIMEOUT = 5  # secunde; produsul blocat de alt utilizator se sare si se raporteaza

PLAN_SQL = """
SELECT GOODSID, GOODS_IMAGE_ID, ORDERNO, RN, FLG_NEED2RECREATE
FROM (
  SELECT i.GOODSID, i.GOODS_IMAGE_ID, i.ORDERNO, i.FLG_NEED2RECREATE,
         ROW_NUMBER() OVER (PARTITION BY i.GOODSID ORDER BY i.ORDERNO NULLS LAST, i.GOODS_IMAGE_ID) RN
  FROM TS_GOODS_IMAGE i
  %s
)
WHERE ORDERNO IS DISTINCT FROM RN
ORDER BY GOODSID, RN
"""
SITE_FILTER = "WHERE EXISTS (SELECT 1 FROM TWEB_CACHE_GOODS cg WHERE cg.GOODSID = i.GOODSID)"


def build_plan(cur, scope):
    cur.execute(PLAN_SQL % (SITE_FILTER if scope == 'site' else ''))
    plan = OrderedDict()
    for goodsid, image_id, old, new, flg in cur.fetchall():
        plan.setdefault(goodsid, []).append({'image_id': image_id, 'old': old, 'new': new, 'flg': flg})
    return plan


def summary(plan):
    rows = sum(len(v) for v in plan.values())
    no_first = sum(1 for v in plan.values() if v[0]['new'] == 1)
    flg = sum(1 for v in plan.values() for r in v if r['flg'] == 1)
    return ('produse: %d, rinduri: %d, produse care primesc acum pozitia 1: %d, '
            'rinduri cu FLG_NEED2RECREATE=1 (devine 0): %d' % (len(plan), rows, no_first, flg))


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else 'dry'
    scope = sys.argv[2] if len(sys.argv) > 2 else 'site'
    if mode not in ('dry', 'apply') or scope not in ('site', 'all'):
        sys.exit(__doc__)

    con = connect(DSN, user='SYSDBA', password=os.environ['FIREBIRD_PASSWORD'], charset='UTF8')
    cur = con.cursor()
    plan = build_plan(cur, scope)
    con.commit()
    stamp = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
    head = '%s %s %s | %s' % (stamp, mode, scope, summary(plan))
    print(head)

    if mode == 'dry':
        with io.open(os.path.join(HERE, 'renumber_dry_%s.txt' % scope), 'w', encoding='utf-8') as f:
            f.write(head + '\n')
            for goodsid, rows in plan.items():
                f.write('%d: %s\n' % (goodsid, ', '.join('#%d %s->%d' % (r['image_id'], r['old'], r['new']) for r in rows)))
        con.close()
        return

    # backup local al valorilor vechi + script de revenire
    json.dump(plan, io.open(os.path.join(HERE, 'renumber_backup_%s_%s.json' % (stamp, scope)), 'w', encoding='utf-8'))
    with io.open(os.path.join(HERE, 'rollback_%s_%s.sql' % (stamp, scope)), 'w', encoding='utf-8') as rb:
        for goodsid, rows in plan.items():
            for r in rows:
                rb.write('UPDATE TS_GOODS_IMAGE SET ORDERNO = %s WHERE GOODSID = %d AND GOODS_IMAGE_ID = %d;\n'
                         % ('NULL' if r['old'] is None else r['old'], goodsid, r['image_id']))
        rb.write('COMMIT;\n')

    # o tranzactie per produs: un produs blocat sau schimbat intre timp se sare, restul merg
    tr = con.transaction_manager(tpb(Isolation.READ_COMMITTED_RECORD_VERSION, lock_timeout=LOCK_TIMEOUT))
    wcur = tr.cursor()
    done, skipped = 0, []
    for n, (goodsid, rows) in enumerate(plan.items(), 1):
        try:
            tr.begin()
            for r in rows:
                # ORDERNO vechi in WHERE: nu suprascriem o reordonare facuta intre timp
                wcur.execute('UPDATE TS_GOODS_IMAGE SET ORDERNO = ? WHERE GOODSID = ? AND GOODS_IMAGE_ID = ? '
                             'AND ORDERNO IS NOT DISTINCT FROM ?', (r['new'], goodsid, r['image_id'], r['old']))
                if wcur.affected_rows != 1:
                    raise RuntimeError('rindul #%d s-a schimbat intre timp' % r['image_id'])
            tr.commit()
            done += 1
        except Exception as e:
            if tr.is_active():
                tr.rollback()
            skipped.append((goodsid, str(e).replace('\n', ' ')[:200]))
        if n % 500 == 0:
            print('  %d / %d' % (n, len(plan)))
            sys.stdout.flush()

    left = build_plan(cur, scope)
    con.commit()
    tail = 'scrise: %d produse, sarite: %d | ramase dupa rulare: %s' % (done, len(skipped), summary(left))
    print(tail)
    with io.open(os.path.join(HERE, 'renumber_apply_%s_%s.txt' % (stamp, scope)), 'w', encoding='utf-8') as f:
        f.write(head + '\n' + tail + '\n')
        for goodsid, err in skipped:
            f.write('sarit %d: %s\n' % (goodsid, err))
    con.close()


if __name__ == '__main__':
    main()
