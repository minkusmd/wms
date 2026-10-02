import base64, datetime, json, os, sys
import fdb

sys.stdout.reconfigure(encoding='utf-8', errors='replace')  # consola cp1251 nu are s/t cu virgula

APPLY = '--apply' in sys.argv
OUT = r'D:\Projects\MyProjects\WMS\DB Backup\ts_goods_type_deleted_2026-10-02.json'

# tip fara folder, nefolosit nicaieri in afara de propria imagine
COND = """
GT.GOODS_FOLDERID IS NULL
AND NOT EXISTS (SELECT 1 FROM TS_GOODS A WHERE A.WEBGOODSTYPE_ID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM NGS_GOODS A WHERE A.WEBGOODSTYPE_ID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM NGS_NAM1_PARAMS A WHERE A.GOODSTYPEID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM NGS_NAM2_PARAMS A WHERE A.GOODSTYPEID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM NGS_NAMING_ADD_PARAMS A WHERE A.GOODSTYPEID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM NGS_NAMING_BASE_PARAM A WHERE A.GOODSTYPEID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM MK_GG_TYPES A WHERE A.GOODSTYPEID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM TS_ATTRIBUTE A WHERE A.GOODS_TYPE_ID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM TS_DESC_TEMPL_GT A WHERE A.GOODSTYPEID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM TS_GOODS_ACNT A WHERE A.GOODS_TYPEID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM TS_GOODS_NAME_TEMPLATE A WHERE A.GOODS_TYPE_ID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM TS_GOODS_SERVICE A WHERE A.GOODSTYPEID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM TS_GOODS_TYPE_FILTERS A WHERE A.GOODSTYPEID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM TS_PRICELIST_ITEMS A WHERE A.GOODSTYPEID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM TWEB_CACHE_GOODS A WHERE A.WEBGOODSTYPEID = GT.GOODSTYPEID)
AND NOT EXISTS (SELECT 1 FROM TS_GOODS_TYPE A WHERE A.PGTID = GT.GOODSTYPEID)
"""


def rows(cur, sql, params=()):
    cur.execute(sql, params)
    cols = [d[0].strip() for d in cur.description]
    res = []
    for r in cur.fetchall():
        d = {}
        for c, v in zip(cols, r):
            if isinstance(v, bytes):
                v = {'b64': base64.b64encode(v).decode()}
            elif isinstance(v, (datetime.date, datetime.datetime, datetime.time)):
                v = v.isoformat()
            d[c] = v
        res.append(d)
    return res


con = fdb.connect(dsn='192.168.106.254/3050:SW', user='SYSDBA',
                  password=os.environ['FIREBIRD_PASSWORD'], charset='UTF8')
cur = con.cursor()
types = rows(cur, 'SELECT GT.* FROM TS_GOODS_TYPE GT WHERE ' + COND + ' ORDER BY GT.GOODSTYPEID')
ids = [t['GOODSTYPEID'] for t in types]
print('candidati:', len(ids))
for t in types:
    print(' ', t['GOODSTYPEID'], t['TITLE'])
if not ids:
    sys.exit()
inl = ','.join(str(i) for i in ids)
images = rows(cur, f'SELECT * FROM TS_GOODS_TYPE_IMAGE WHERE GOODSTYPEID IN ({inl})')
print('imagini:', len(images))

if not APPLY:
    sys.exit()

with open(OUT, 'w', encoding='utf-8') as f:
    json.dump({'date': '2026-10-02', 'TS_GOODS_TYPE': types, 'TS_GOODS_TYPE_IMAGE': images},
              f, ensure_ascii=False, indent=1)
print('backup:', OUT, os.path.getsize(OUT), 'bytes')

cur.execute(f'DELETE FROM TS_GOODS_TYPE GT WHERE GT.GOODSTYPEID IN ({inl}) AND ' + COND)
n = cur.rowcount
if n != len(ids):
    con.rollback()
    sys.exit(f'sters {n} != {len(ids)} -> ROLLBACK')
con.commit()
print('sters:', n)
cur.execute(f'SELECT COUNT(*) FROM TS_GOODS_TYPE WHERE GOODSTYPEID IN ({inl})')
print('ramase din lista:', cur.fetchone()[0])
cur.execute(f'SELECT COUNT(*) FROM TS_GOODS_TYPE_IMAGE WHERE GOODSTYPEID IN ({inl})')
print('imagini ramase:', cur.fetchone()[0])
cur.execute('SELECT COUNT(*), COUNT(GOODS_FOLDERID) FROM TS_GOODS_TYPE')
print('TS_GOODS_TYPE total / cu folder:', cur.fetchone())
con.close()
