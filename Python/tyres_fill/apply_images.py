"""Faza B: scrie imaginile aprobate in TS_GOODS_IMAGE (doar produsele inca fara imagini).

Utilizare:  python apply_images.py 1,2,3,...     (numerele aprobate din plansa)
Intrare: images_report.json (de la fetch_images.py) + imgs/<nr>.png
Imaginea se scrie ca PNG; triggerul completeaza GOODS_IMAGE_ID, ORDERNO, CREATED_BY etc.
"""
import datetime
import io
import json
import os
import sys

import analyze

HERE = os.path.dirname(os.path.abspath(__file__))


def main():
    approved = [x.strip() for x in (sys.argv[1] if len(sys.argv) > 1 else '').split(',') if x.strip()]
    if not approved:
        raise SystemExit('indicati numerele aprobate, ex: python apply_images.py 1,2,5')
    report = json.load(io.open(os.path.join(HERE, 'images_report.json'), encoding='utf-8'))
    con = analyze.connect()
    cur = con.cursor()
    cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','204') FROM RDB$DATABASE")
    cur.fetchone()
    stamp = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
    log = io.open(os.path.join(HERE, 'images_apply_%s.txt' % stamp), 'w', encoding='utf-8')
    written = 0
    for nr in approved:
        it = report.get(nr)
        if not it or not it.get('file'):
            log.write('%s: fara imagine descarcata, sarit\n' % nr)
            continue
        png = open(it['file'], 'rb').read()
        for gid in it['goods']:
            cur.execute('SELECT COUNT(*) FROM TS_GOODS_IMAGE WHERE GOODSID=?', (gid,))
            if cur.fetchone()[0]:
                log.write('%s: %d are deja imagini, sarit\n' % (nr, gid))
                continue
            cur.execute('INSERT INTO TS_GOODS_IMAGE (GOODSID, IMAGE) VALUES (?, ?)', (gid, png))
            written += 1
            log.write('%s: %d <- %s %s\n' % (nr, gid, it['brand'], it['model']))
    con.commit()
    log.write('\nimagini scrise: %d\nrevenire: DELETE FROM TS_GOODS_IMAGE WHERE CREATED_DATE >= \'%s\' AND GOODSID IN (...)\n'
              % (written, datetime.datetime.now().strftime('%Y-%m-%d %H:%M')))
    log.close()
    con.close()
    print('imagini scrise:', written)


if __name__ == '__main__':
    main()
