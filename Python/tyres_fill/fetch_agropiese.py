"""Descarca catalogul AgroPiese (14805) din API-ul angro.agropiese.md, exact ca WMS
(AgroPiesePriceListUnit): GET /products?api_token=...&page-length=500&page=N.

Rezultatul se scrie in %TEMP%\\WMS_Api\\agropiese_products_<data_ora>.json (acelasi loc si
nume ca la descarcarea din WMS), de unde il citeste fill_in_price.py (cel mai nou fisier).
Tokenul vine din TS_API_CONFIG (API_CODE = 'AGROPIESE'); parola bazei din FIREBIRD_PASSWORD.
"""
import datetime
import io
import json
import os
import sys
import time
import urllib.parse
import urllib.request

import analyze

PAGE_LENGTH = 500


def config(cur):
    cur.execute("SELECT PARAM_NAME, PARAM_VALUE FROM TS_API_CONFIG WHERE API_CODE = 'AGROPIESE' AND FLG_ACTIVE = 1")
    cfg = {(k or '').strip().upper(): (v or '').strip() for k, v in cur.fetchall()}
    token = cfg.get('API_TOKEN')
    if not token:
        raise SystemExit('TS_API_CONFIG: lipseste API_TOKEN pentru AGROPIESE')
    return token, cfg.get('BASE_URL') or 'https://angro.agropiese.md/api/v1'


def get(url, attempts=4):
    last = None
    for i in range(attempts):
        try:
            req = urllib.request.Request(url, headers={'Accept': 'application/json', 'User-Agent': 'WMS'})
            with urllib.request.urlopen(req, timeout=120) as r:
                return json.loads(r.read().decode('utf-8'))
        except Exception as e:  # retea / 5xx / 429
            last = e
            time.sleep(3 * (i + 1))
    raise last


def main():
    con = analyze.connect()
    cur = con.cursor()
    token, base = config(cur)
    con.close()
    rows, page, last_page = [], 1, 1
    while page <= last_page:
        url = '%s/products?api_token=%s&page-length=%d&page=%d' % (base, urllib.parse.quote(token), PAGE_LENGTH, page)
        data = get(url)
        last_page = int(data.get('last_page') or 1)
        rows.extend(data.get('data') or [])
        print('pagina %d/%d, rinduri %d' % (page, last_page, len(rows)), flush=True)
        page += 1
    out_dir = os.path.join(os.environ.get('TEMP', '.'), 'WMS_Api')
    os.makedirs(out_dir, exist_ok=True)
    path = os.path.join(out_dir, 'agropiese_products_%s.json' % datetime.datetime.now().strftime('%Y%m%d_%H%M%S'))
    with io.open(path, 'w', encoding='utf-8') as f:
        json.dump(rows, f, ensure_ascii=False)
    print('scris', path, len(rows), 'rinduri')


if __name__ == '__main__':
    main()
