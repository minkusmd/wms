"""Anvelope (tip 479) de pe site fara imagini si fara caracteristici: ce se poate completa.

Doar CITIRE din baza SW. Parola vine din variabila de mediu FIREBIRD_PASSWORD (aceeasi ca la
serverul MCP), restul din .mcp.json. Rezultatul: tyres_plan.json + rezumat pe ecran.
"""
import json
import os
import re
import sys
from collections import Counter, defaultdict

import firebird.driver as fb

HERE = os.path.dirname(os.path.abspath(__file__))
TYPE_TYRE = 479

SEASON_RULES = [
    ('All Season', re.compile(r'all[\s-]?season|всесезон|\ba/s\b|\b4s\b|4\s?season|allseason|all weather|всепогод', re.I)),
    ('Iarna', re.compile(r'iarn|зим|winter|\bice|snow|nord|arctic|\bw\d{2,3}\b', re.I)),
    ('Vara', re.compile(r'\bvar[aă]\b|vara|лет|summer', re.I)),
]

SIZE_RE = re.compile(
    r'(?P<w>\d{3}|\d{2}(?:[.,]\d{1,2})?)\s*(?:/\s*(?P<h>\d{2}(?:[.,]\d)?))?\s*'
    r'(?P<z>Z)?\s*R\s*-?\s*(?P<d>\d{2}(?:[.,]\d)?)\s*(?P<c>C)?\b', re.I)
SPEED = 'JKLMNPQRSTUHVWYZ'
# "99V" / "106/104R" (sarcina, apoi viteza) sau "T 99" (viteza, apoi sarcina)
LOAD_SPEED_RE = re.compile(r'\b(?P<load>\d{2,3}(?:/\d{2,3})?)\s*(?P<speed>[%s])\b' % SPEED)
SPEED_LOAD_RE = re.compile(r'\b(?P<speed>[%s])\s+(?P<load>\d{2,3}(?:/\d{2,3})?)\b' % SPEED)
SUPPLIER_NOISE = re.compile(r'Шина|/?\s*anvelop[ae]?\s+pneum[^\s]*(\s+p/u\s+auto)?|anvelope\b|\bFR\b|\bMGT\b|\bTL\b', re.I)


def connect():
    cfg = json.load(open(os.path.join(HERE, '..', '..', '.mcp.json')))['mcpServers']['firebird']['env']
    return fb.connect('%s/%s:%s' % (cfg['FIREBIRD_HOST'], cfg['FIREBIRD_PORT'], cfg['FIREBIRD_DATABASE']),
                      user=cfg['FIREBIRD_USER'], password=os.environ['FIREBIRD_PASSWORD'], charset='UTF8')


def norm_brand(s):
    s = re.sub(r'[^A-Z0-9]', '', (s or '').upper())
    return {'GREENLANDER': 'GRENLANDER'}.get(s, s)


def season_of(text):
    for name, rx in SEASON_RULES:
        if rx.search(text):
            return name
    return None


def clean_model(model, vendor):
    model = re.split(r'\s(?:лет|зим|всесез|vara|iarna|all season)', ' ' + model, flags=re.I)[0]
    for v in {vendor or '', 'GRENLANDER', 'GREENLANDER'}:
        if v:
            model = re.sub(r'\b' + re.escape(v) + r'\b', ' ', model, flags=re.I)
    # "Z" izolat = marcajul ZR scris separat ("CONTISPORTCONTACT 7 Z 107Y")
    model = re.sub(r'\b(B|XL|RF|M\+S|3PMSF|SUV|LT|Z)\b|[()]', ' ', model, flags=re.I)
    return re.sub(r'\s+', ' ', model).strip(' -/,')


def parse(code, vendor):
    text = code or ''
    clean = SUPPLIER_NOISE.sub(' ', text)
    out = {}
    m = SIZE_RE.search(clean)
    if m:
        out['width'] = m.group('w').replace(',', '.')
        out['height'] = (m.group('h') or '').replace(',', '.')
        out['diam'] = 'R' + m.group('d').replace(',', '.') + ('C' if m.group('c') else '')
        out['zr'] = bool(m.group('z'))
        # "LT265/70 R17" = anvelopa pentru camionete usoare; prefixul ramine in denumire
        out['lt'] = clean[max(0, m.start() - 2):m.start()].upper() == 'LT'
        before, after = clean[:m.start()], clean[m.end():]
        ls = LOAD_SPEED_RE.search(after) or SPEED_LOAD_RE.search(after)
        if ls:
            out['load'] = ls.group('load')
            out['speed'] = ls.group('speed').upper()
            after_model = after[:ls.start()]
        else:
            after_model = after
        # modelul sta fie inaintea dimensiunii ("W636 205/65 R-16"), fie dupa ea
        m_before, m_after = clean_model(before, vendor), clean_model(after_model, vendor)
        out['model'] = m_before if re.search(r'[A-Za-z]', m_before) else m_after
        # modelul poate veni si dupa indici: "215/50 R17 95H ARCTIC S-8"
        if not re.search(r'[A-Za-z]', out['model']) and ls:
            out['model'] = clean_model(after[ls.end():], vendor)
        out['xl'] = bool(re.search(r'\bXL\b', text, re.I))
    out['season'] = season_of(text)
    return out


def model_key(model):
    return re.sub(r'[^A-Z0-9]', '', (model or '').upper())


# lasate utilizatorului: fara dimensiune in denumire (29.09.2026)
EXCLUDED = (391857, 391862)


def main():
    rest = len(sys.argv) > 1 and sys.argv[1] == 'rest'
    con = connect()
    cur = con.cursor()
    season_filter_sql = """(SELECT FIRST 1 TRIM(p.PARAM_VALUE) FROM TS_GOODS_DESCRIPTIONS x
                              JOIN TS_FILTER_PARAMS p ON p.FILTERPARAMID = x.FILTERPARAMID
                             WHERE x.GOODSID = g.GOODSID AND x.FILTERID = 1252)"""
    if rest:
        # restul anvelopelor de pe site: fara caracteristici SAU fara sezon in denumire
        where = """AND (COALESCE(TRIM(g.BASE_PARAM), '') = ''
                        OR NOT EXISTS (SELECT 1 FROM TS_GOODS_DESCRIPTIONS x WHERE x.GOODSID = g.GOODSID AND COALESCE(x.FLG_GROUP,0) = 0))
                   AND g.GOODSID NOT IN (%s)""" % ','.join(map(str, EXCLUDED))
    else:
        where = """AND NOT EXISTS (SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID = g.GOODSID)
                   AND NOT EXISTS (SELECT 1 FROM TS_GOODS_DESCRIPTIONS x WHERE x.GOODSID = g.GOODSID AND COALESCE(x.FLG_GROUP,0) = 0)
                   AND NOT EXISTS (SELECT 1 FROM TS_GOODS_FILTERS y WHERE y.GOODSID = g.GOODSID)"""
    cur.execute("""
        SELECT g.GOODSID, TRIM(s.TITLE), g.VENDOR_ID, g.CODE, g.BASE_PARAM, g.DETAILS, """ + season_filter_sql + """,
               IIF(EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID = g.GOODSID), 1, 0)
        FROM TS_GOODS g LEFT JOIN TS_SYSS s ON s.SYSSID = g.VENDOR_ID
        WHERE g.WEBGOODSTYPE_ID = ? AND EXISTS (SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID = g.GOODSID)
        """ + where, [TYPE_TYRE])
    targets = [dict(zip(('goodsid', 'vendor', 'vendor_id', 'code', 'base_param', 'details', 'season_filter', 'has_images'), r))
               for r in cur.fetchall()]

    # donori: anvelope cu imagini, indexate dupa brand + model
    cur.execute("""
        SELECT g.GOODSID, TRIM(s.TITLE), g.CODE,
               (SELECT COUNT(*) FROM TS_GOODS_IMAGE i WHERE i.GOODSID = g.GOODSID) AS IMGS
        FROM TS_GOODS g LEFT JOIN TS_SYSS s ON s.SYSSID = g.VENDOR_ID
        WHERE g.WEBGOODSTYPE_ID = ? AND EXISTS (SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID = g.GOODSID)""",
                [TYPE_TYRE])
    donors = defaultdict(list)
    for gid, vendor, code, imgs in cur.fetchall():
        p = parse(code, vendor)
        key = (norm_brand(vendor), model_key(p.get('model')))
        if key[1]:
            donors[key].append((imgs, gid))

    # sezonul pe brand + model, din anvelopele care il au deja (filtrul 1252 sau BASE_PARAM)
    cur.execute("""
        SELECT TRIM(s.TITLE), g.CODE,
               COALESCE((SELECT FIRST 1 TRIM(p.PARAM_VALUE) FROM TS_GOODS_DESCRIPTIONS x
                         JOIN TS_FILTER_PARAMS p ON p.FILTERPARAMID = x.FILTERPARAMID
                         WHERE x.GOODSID = g.GOODSID AND x.FILTERID = 1252), g.BASE_PARAM)
        FROM TS_GOODS g LEFT JOIN TS_SYSS s ON s.SYSSID = g.VENDOR_ID
        WHERE g.WEBGOODSTYPE_ID = ?""", [TYPE_TYRE])
    model_seasons = defaultdict(Counter)
    for vendor, code, season_raw in cur.fetchall():
        season = season_of(season_raw or '') or season_of(code or '')
        if season:
            p = parse(code, vendor)
            key = (norm_brand(vendor), model_key(p.get('model')))
            if key[1]:
                model_seasons[key][season] += 1

    # conventia pentru anvelopele fara profil (ex. 195R14C) la produsele deja completate
    cur.execute("""
        SELECT FIRST 5 g.CODE, TRIM(p.PARAM_VALUE) FROM TS_GOODS g
        JOIN TS_GOODS_DESCRIPTIONS x ON x.GOODSID = g.GOODSID AND x.FILTERID = 1259
        JOIN TS_FILTER_PARAMS p ON p.FILTERPARAMID = x.FILTERPARAMID
        WHERE g.WEBGOODSTYPE_ID = ? AND g.CODE SIMILAR TO '%[0-9]{3}R[0-9]{2}C%'""", [TYPE_TYRE])
    no_profile_examples = cur.fetchall()
    con.close()

    plan, stats = [], Counter()
    for t in targets:
        p = parse(t['code'], t['vendor'])
        key = (norm_brand(t['vendor']), model_key(p.get('model')))
        cands = sorted(donors.get(key, []), reverse=True)
        # sezonul deja pus ca filtru are prioritate fata de text
        fs = season_of(t.get('season_filter') or '')
        if fs:
            p['season'] = fs
        t.update(p)
        t['donor'] = cands[0][1] if cands and not t.get('has_images') else None
        t['season_src'] = ('filtru' if fs else 'text') if p.get('season') else None
        if not p.get('season') and model_seasons.get(key):
            (best, n), total = model_seasons[key].most_common(1)[0], sum(model_seasons[key].values())
            if n / total >= 0.8:
                t['season'] = best
                t['season_src'] = 'model %d/%d' % (n, total)
                p['season'] = best
        plan.append(t)
        stats['total'] += 1
        stats['size_ok'] += bool(p.get('width') and p.get('diam'))
        stats['load_speed_ok'] += bool(p.get('load') and p.get('speed'))
        stats['season_' + str(p.get('season'))] += 1
        stats['donor_ok'] += bool(t['donor'])
        stats['no_profile'] += bool(p.get('width') and not p.get('height'))

    json.dump(plan, open(os.path.join(HERE, 'tyres_plan_rest.json' if rest else 'tyres_plan.json'), 'w', encoding='utf-8'),
              ensure_ascii=False, indent=1)
    print(json.dumps(stats, indent=1))
    print('conventie fara profil:', no_profile_examples)
    def grouped(rows):
        g = Counter((norm_brand(x['vendor']), x.get('model') or '?') for x in rows)
        return ', '.join('%s %s (%d)' % (b, m, n) for (b, m), n in g.most_common())

    print('\n--- sezon dedus din model:', Counter(x['season_src'] for x in plan if x['season_src'] and x['season_src'] != 'text'))
    print('\n--- fara sezon (brand model (nr)):\n ', grouped([x for x in plan if not x['season']]))
    print('\n--- fara donor de imagini (brand model (nr)):\n ', grouped([x for x in plan if not x['donor']]))
    print('\n--- nedescifrate (dimensiune sau indici):')
    for t in [x for x in plan if not (x.get('width') and x.get('load'))]:
        print(' ', t['goodsid'], t['vendor'], '|', t['code'])


if __name__ == '__main__':
    sys.exit(main())
