# -*- coding: utf-8 -*-
"""Extrage specificatiile procesoarelor din TITLE si le compara cu filtrele existente."""
import firebird.driver as fb, io, re, json

INPRICE = "EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID)"
NOIMG = "NOT EXISTS(SELECT 1 FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID)"
NODSC = "NOT EXISTS(SELECT 1 FROM TS_GOODS_DSC d WHERE d.GOODSID=g.GOODSID)"

# 'Е' chirilic apare in titluri ca "8P+12Е" -> normalizam
CYR = {'Е': 'E', 'е': 'e', 'С': 'C', 'с': 'c', 'Т': 'T', 'Р': 'P', 'А': 'A', 'В': 'B',
       'М': 'M', 'Н': 'H', 'К': 'K', 'О': 'O', 'о': 'o', 'Х': 'X', 'х': 'x'}

def norm(t):
    t = (t or '')
    for a, b in CYR.items():
        t = t.replace(a, b)
    t = t.replace('™', '').replace('®', '').replace(' ', ' ')
    return re.sub(r'\s+', ' ', t).strip()


def parse(title):
    t = norm(title)
    s = {}
    # brand
    if re.search(r'\b(AMD|RYZEN|ATHLON|TURION)\b', t, re.I): s['brand'] = 'AMD'
    if re.search(r'\b(INTEL|CORE|PENTIUM|CELERON|XEON)\b', t, re.I): s['brand'] = s.get('brand', 'Intel') if 'brand' not in s else s['brand']
    if re.search(r'\bINTEL\b', t, re.I): s['brand'] = 'Intel'
    if re.search(r'\bAMD\b|\bRYZEN\b', t, re.I): s['brand'] = 'AMD'

    # socket
    m = re.search(r'\bSocket\s*(AM[45]|FM2\+?|AM3\+?)\b', t, re.I) or re.search(r'\b(AM[45])\b', t)
    if m: s['socket'] = m.group(1).upper()
    m = re.search(r'\bLGA\s*(\d{3,4})\b', t, re.I)
    if m: s['socket'] = 'LGA ' + m.group(1)
    m = re.search(r'\bS(1700|1851|1200|1151|1155)\b', t)
    if m and 'socket' not in s: s['socket'] = 'LGA ' + m.group(1)
    if 'socket' not in s:
        m = re.search(r'\bS(1700|1851|1200)\b', t)
        if m: s['socket'] = 'LGA ' + m.group(1)

    # frecventa
    m = re.search(r'(\d+[.,]\d+)\s*-\s*(\d+[.,]\d+)\s*GHZ', t, re.I)
    if m: s['freq'] = '%s-%s GHz' % (m.group(1).replace(',', '.'), m.group(2).replace(',', '.'))
    else:
        m = re.search(r'(\d+[.,]\d+)\s*GHZ', t, re.I)
        if m: s['freq'] = '%s GHz' % m.group(1).replace(',', '.')

    # nuclee / threads
    m = re.search(r'\((\d+)P\+(\d+)E\)\s*/\s*(\d+)T', t, re.I)
    if m:
        s['pcore'], s['ecore'] = int(m.group(1)), int(m.group(2))
        s['cores'] = s['pcore'] + s['ecore']; s['threads'] = int(m.group(3))
    if 'cores' not in s:
        m = re.search(r'(\d+)P\+(\d+)E\s*/\s*(\d+)T', t, re.I)
        if m:
            s['pcore'], s['ecore'] = int(m.group(1)), int(m.group(2))
            s['cores'] = s['pcore'] + s['ecore']; s['threads'] = int(m.group(3))
    if 'cores' not in s:
        m = re.search(r'\b(\d+)C\s*/\s*(\d+)T\b', t, re.I)
        if m: s['cores'], s['threads'] = int(m.group(1)), int(m.group(2))
    if 'cores' not in s:
        m = re.search(r'\b(\d+)[- ]Core\b', t, re.I)
        if m: s['cores'] = int(m.group(1))
        m = re.search(r'\b(\d+)[- ]Threads?\b', t, re.I)
        if m: s['threads'] = int(m.group(1))
    if 'cores' not in s:
        m = re.search(r'\b(\d+)\s*Cores?\b', t, re.I)
        if m: s['cores'] = int(m.group(1))
    # "10C (6P+4E) / 16T" prins mai sus; "14C" singur:
    if 'cores' not in s:
        m = re.search(r'\b(\d+)C\b', t)
        if m: s['cores'] = int(m.group(1))

    # cache L3 / L2
    m = re.search(r'L3\s*(\d+(?:[.,]\d+)?)\s*MB', t, re.I) or re.search(r'(\d+(?:[.,]\d+)?)\s*MB\s*L3', t, re.I)
    if m: s['l3'] = m.group(1).replace(',', '.') + ' MB'
    m = re.search(r'L2\s*(\d+(?:[.,]\d+)?)\s*MB', t, re.I) or re.search(r'(\d+(?:[.,]\d+)?)\s*MB\s*L2', t, re.I)
    if m: s['l2'] = m.group(1).replace(',', '.') + ' MB'

    # proces tehnologic
    m = re.search(r'(\d+)\s*nm', t, re.I)
    if m: s['nm'] = m.group(1) + ' nm'

    # TDP
    m = re.search(r'(\d+)\s*W\b', t, re.I)
    if m: s['tdp'] = m.group(1) + ' W'

    # grafica integrata
    if re.search(r'No\s*Integ|Fara\s*grafic|No\s*Integrated|NO\s*INTEG', t, re.I):
        s['igpu'] = None
    else:
        m = (re.search(r'(Intel\s*UHD\s*Graphics\s*\d*)', t, re.I)
             or re.search(r'(Integ\.?\s*UHD\s*Graphics\s*\d*)', t, re.I)
             or re.search(r'(Radeon\s*Vega\s*\d*)', t, re.I)
             or re.search(r'(Radeon(?:\s+[A-Z0-9]{1,6}){0,2}\s*Graphics)', t, re.I)
             or re.search(r'(Integrated\s*Radeon[\w\s]{0,18}?Graphics)', t, re.I)
             or re.search(r'(Integrated\s*Graphics)', t, re.I)
             or re.search(r'(Integ\.?\s*Graphics)', t, re.I))
        if m: s['igpu'] = re.sub(r'\s+', ' ', m.group(1)).strip()

    # model (pentru potrivirea imaginilor)
    m = (re.search(r'\b(Ryzen\s*(?:Threadripper\s*)?\d\s*(?:PRO\s*)?[0-9]{4}[A-Z0-9]{0,4})', t, re.I)
         or re.search(r'\b(Core\s*Ultra\s*\d\s*\d{3}[A-Z]{0,3})', t, re.I)
         or re.search(r'\b(ULTRA\s*\d\s*\d{3}[A-Z]{0,3})', t, re.I)
         or re.search(r'\b([iI][3579]-\d{4,5}[A-Z]{0,3})', t)
         or re.search(r'\b(Xeon\s*[A-Z]?\d?-?\d{3,4}[A-Za-z0-9]*)', t, re.I)
         or re.search(r'\b((?:Pentium|Celeron|Athlon)\s*[A-Za-z]*\s*[A-Z]?\d{3,4}[A-Z]{0,2})', t, re.I))
    if m: s['model'] = re.sub(r'\s+', ' ', m.group(1)).strip()
    s['tray'] = bool(re.search(r'\bTRAY\b', t, re.I))
    s['box'] = bool(re.search(r'\bBOX\b', t, re.I))
    return s


def main():
    con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
    cur = con.cursor()
    cur.execute("""SELECT g.GOODSID, g.TITLE,
        (SELECT COUNT(*) FROM TS_GOODS_IMAGE i WHERE i.GOODSID=g.GOODSID),
        (SELECT COUNT(*) FROM TS_GOODS_DSC d WHERE d.GOODSID=g.GOODSID)
        FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0 AND """ + INPRICE +
        " AND (%s OR %s) ORDER BY g.GOODSID" % (NOIMG, NODSC))
    goods = [(r[0], r[1], r[2], r[3]) for r in cur]

    data = {}
    for gid, title, nimg, ndsc in goods:
        cur.execute("""SELECT f.FILTERID, f.FILTERNAME, f.FILTERNAME_RUS, p.PARAM_VALUE, p.PARAM_VALUE_RUS
                       FROM TS_GOODS_FILTERS gf
                       JOIN TS_FILTERS f ON f.FILTERID=gf.FILTERID
                       JOIN TS_FILTER_PARAMS p ON p.FILTERID=gf.FILTERID AND p.FILTERPARAMID=gf.FILTERPARAMID
                       WHERE gf.GOODSID=?""", (gid,))
        flt = [[r[0], r[1].strip(), (r[2] or '').strip(), (r[3] or '').strip(), (r[4] or '').strip()] for r in cur]
        data[gid] = dict(title=title, nimg=nimg, ndsc=ndsc, specs=parse(title), filters=flt)
    con.close()

    json.dump(data, io.open('cpu_data.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    with io.open('parse_review.txt', 'w', encoding='utf-8') as f:
        f.write("%-7s %-3s %-3s %-3s %-22s %-9s %-13s %-7s %-7s %-6s %-6s %s\n"
                % ('gid', 'img', 'dsc', 'flt', 'model', 'socket', 'freq', 'C/T', 'L3', 'nm', 'TDP', 'iGPU'))
        for gid, d in data.items():
            s = d['specs']
            ct = '%s/%s' % (s.get('cores', '?'), s.get('threads', '?'))
            f.write("%-7d %-3d %-3d %-3d %-22s %-9s %-13s %-7s %-7s %-6s %-6s %s\n"
                    % (gid, d['nimg'], d['ndsc'], len(d['filters']), (s.get('model') or '-')[:22],
                       s.get('socket', '-'), s.get('freq', '-'), ct, s.get('l3', '-'),
                       s.get('nm', '-'), s.get('tdp', '-'),
                       ('FARA' if 'igpu' in s and s['igpu'] is None else (s.get('igpu') or '?'))[:26]))
    print('parsed', len(data))

if __name__ == '__main__':
    main()
