# -*- coding: utf-8 -*-
"""Pentru fiecare procesor din price fara imagine, cauta un produs-geaman (acelasi
model de procesor) care ARE imagini, ca sursa pentru copiere."""
import firebird.driver as fb, io, json, re
from parse_cpu import parse, norm

def model_key(specs):
    m = (specs.get('model') or '').upper()
    m = re.sub(r'[^A-Z0-9]', '', m)
    return m or None

con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
cur = con.cursor()

# tinte: in price, fara imagine
cur.execute("""SELECT g.GOODSID, g.TITLE FROM TS_GOODS g
 WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)
 AND NOT EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID) ORDER BY g.GOODSID""")
targets = cur.fetchall()

# candidati: orice procesor cu cel putin o imagine PNG
cur.execute("""SELECT g.GOODSID, g.TITLE,
  (SELECT COUNT(*) FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID)
 FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0
 AND EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID)""")
pool = cur.fetchall()

by_key = {}
for gid, title, n in pool:
    k = model_key(parse(title))
    if k:
        by_key.setdefault(k, []).append((gid, title, n))

out, missing = {}, []
for gid, title in targets:
    s = parse(title)
    k = model_key(s)
    cands = [c for c in by_key.get(k, []) if c[0] != gid] if k else []
    if not cands:
        missing.append((gid, k, title))
        continue
    out[gid] = dict(key=k, title=title, cands=[(c[0], c[1], c[2]) for c in cands])

with io.open('match_report.txt', 'w', encoding='utf-8') as f:
    f.write("tinte fara imagine: %d; cu geaman gasit: %d; fara geaman: %d\n\n" % (len(targets), len(out), len(missing)))
    for gid, d in out.items():
        f.write("%s  [%s]  %s\n" % (gid, d['key'], d['title'][:78]))
        for cid, ct, n in d['cands'][:4]:
            f.write("      <- %s (%d img) %s\n" % (cid, n, ct[:72]))
    f.write("\nFARA GEAMAN (%d):\n" % len(missing))
    for gid, k, title in missing:
        f.write("  %s [%s] %s\n" % (gid, k, title[:88]))

json.dump({str(k): v for k, v in out.items()}, io.open('img_match.json', 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
con.close()
print('targets', len(targets), 'matched', len(out), 'missing', len(missing))
