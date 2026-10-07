"""Anvelopele de pe site ramase: fara caracteristici SAU fara sezon in denumire (BASE_PARAM).
Doar citire; foloseste acelasi parser ca analyze.py."""
import io
import json
import os
from collections import Counter

import analyze

HERE = os.path.dirname(os.path.abspath(__file__))

con = analyze.connect()
cur = con.cursor()
cur.execute("""
    SELECT g.GOODSID, TRIM(s.TITLE), g.CODE, g.BASE_PARAM,
           IIF(EXISTS(SELECT 1 FROM TS_GOODS_DESCRIPTIONS x WHERE x.GOODSID = g.GOODSID AND COALESCE(x.FLG_GROUP,0) = 0), 1, 0),
           IIF(EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID = g.GOODSID), 1, 0),
           (SELECT FIRST 1 TRIM(p.PARAM_VALUE) FROM TS_GOODS_DESCRIPTIONS x JOIN TS_FILTER_PARAMS p ON p.FILTERPARAMID = x.FILTERPARAMID
             WHERE x.GOODSID = g.GOODSID AND x.FILTERID = 1252)
    FROM TS_GOODS g LEFT JOIN TS_SYSS s ON s.SYSSID = g.VENDOR_ID
    WHERE g.WEBGOODSTYPE_ID = 479 AND EXISTS (SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID = g.GOODSID)
      AND (COALESCE(TRIM(g.BASE_PARAM), '') = ''
           OR NOT EXISTS (SELECT 1 FROM TS_GOODS_DESCRIPTIONS x WHERE x.GOODSID = g.GOODSID AND COALESCE(x.FLG_GROUP,0) = 0))""")
rows = cur.fetchall()
con.close()

stats, samples = Counter(), []
for gid, vendor, code, bp, has_desc, has_img, season_filter in rows:
    p = analyze.parse(code, vendor)
    season = analyze.season_of(season_filter or '') or p.get('season')
    kind = ('fara_caract' if not has_desc else '') + ('+' if not has_desc and not (bp or '').strip() else '') + \
           ('fara_sezon_nume' if not (bp or '').strip() else '')
    stats[kind] += 1
    stats['parsabil'] += bool(p.get('width') and p.get('load'))
    stats['sezon_cunoscut'] += bool(season)
    stats['sezon_din_filtru'] += bool(season_filter)
    if len(samples) < 25:
        samples.append((gid, vendor, code, bp, has_desc, has_img, season_filter, season))
print(json.dumps(stats, indent=1, ensure_ascii=False))
for s in samples:
    print(s)
