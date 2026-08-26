# -*- coding: utf-8 -*-
"""Completeaza caracteristicile procesoarelor in TS_GOODS_DESCRIPTIONS
(tabela din spatele lui VW_TS_GOODS_DESCRIPTIONS).

Valorile vin din datele furnizorului Ultra acolo unde exista, altfel din denumirea
produsului. Se adauga DOAR caracteristicile care lipsesc; randurile existente nu se
ating. Vocabularul e cel al catalogului: TS_FILTERS + TS_FILTER_PARAMS.

Utilizare:  python fill_descriptions.py pilot|all
"""
import firebird.driver as fb, io, json, re, sys
import parse_cpu, gen_dsc

PILOT = [313727]

# eticheta de caracteristica -> (FILTERID canonic, ORDERNO canonic)
# ID-urile si pozitiile sunt cele folosite deja de catalog pentru procesoare
SLOTS = [
    ('CPU Socket',                 38,   1,  'socket'),
    ('Frecvenţa procesor',         98,   2,  'freq'),
    ('Numărul nucleelor',          101,  3,  'cores'),
    ('Numărul threads',            2895, 4,  'threads'),
    ('Procesul tehnic',            137,  7,  'nm'),
    ('Degajarea de căldură',       138,  8,  'tdp'),
    ('Denumirea de cod a nucleului', 100, 9, 'codename'),
    ('Cache L3',                   106,  10, 'l3'),
    ('Cache L2',                   105,  11, 'l2'),
    ('Suport ECC',                 144,  13, 'ecc'),
    ('Tipul memoriei potrivite',   141,  14, 'memtype'),
    ('Capacitate maximă memorie',  142,  16, 'maxram'),
    ('Procesorul grafic',          600,  19, 'igpu'),
]

ULTRA_MAP = {
    'Socket': 'socket', 'Numar Nuclee': 'cores', 'Numar thread-uri': 'threads',
    'Litografie': 'nm', 'TDP': 'tdp', 'Nume-cod Procesor': 'codename',
    'Memorie Cache (L3)': 'l3', 'Suport memorie ESS': 'ecc',
    'Tip Memorie': 'memtype', 'Dimensiune maximă RAM': 'maxram',
    'Grafică Integrată': 'igpu',
}

def num(v):
    m = re.match(r'\s*(\d+)', v or '')
    return m.group(1) if m else None

def fix_mb(v):
    return re.sub(r'(\d)\s*(MB|МБ|GB|ГБ)', r'\1 \2', (v or '').strip())

def ghz(v):
    v = (v or '').replace(',', '.').strip()
    try:
        x = float(v)
    except ValueError:
        return None
    if x > 100:
        x = x / 1000.0
    return round(x, 2) if 0.3 <= x <= 10 else None


def values_for(gid, cur, ultra_link):
    """Returneaza {cheie: (valoare_ro, valoare_ru)} pentru un produs."""
    cur.execute("SELECT TITLE FROM TS_GOODS WHERE GOODSID=?", (gid,))
    title = cur.fetchone()[0] or ''
    t = parse_cpu.parse(title)
    v = {}
    # 1) din denumirea produsului
    if t.get('socket'):  v['socket'] = (t['socket'], t['socket'])
    if t.get('freq'):    v['freq'] = (t['freq'], t['freq'].replace('GHz', 'ГГц'))
    if t.get('cores'):   v['cores'] = (str(t['cores']), str(t['cores']))
    if t.get('threads'): v['threads'] = (str(t['threads']), str(t['threads']))
    if t.get('nm'):      v['nm'] = (t['nm'], t['nm'].replace('nm', 'нм'))
    if t.get('tdp'):     v['tdp'] = (t['tdp'], t['tdp'].replace('W', 'Вт'))
    if t.get('l3'):      v['l3'] = (t['l3'], t['l3'].replace('MB', 'МБ'))
    if t.get('l2'):      v['l2'] = (t['l2'], t['l2'].replace('MB', 'МБ'))
    model = (t.get('model') or '').upper()
    no_igpu_suffix = bool(re.search(r'(KF|[0-9]F)$', model))
    if 'igpu' in t and t['igpu'] and not no_igpu_suffix:
        g, _ = gen_dsc.clean_igpu(t['igpu'])
        if g:
            v['igpu'] = (g, g)

    # 2) datele Ultra au prioritate (mai complete si bilingve)
    link = ultra_link.get(str(gid))
    if link:
        cur.execute("""SELECT pr.NAME_RO, p.VALUE_RO, p.VALUE_RU
                       FROM TS_ULTRA2_PROPERTY_VALUE p
                       LEFT JOIN TS_ULTRA2_PROPERTY pr ON pr.CODE=p.PROPERTY_CODE
                       WHERE p.PRODUCT_UUID=?""", (link['uuid'],))
        U = {(r[0] or '').strip(): ((r[1] or '').strip(), (r[2] or '').strip()) for r in cur}
        for uname, key in ULTRA_MAP.items():
            if uname not in U or not U[uname][0]:
                continue
            vro, vru = U[uname]
            if key in ('cores', 'threads'):
                vro = vru = num(vro)
            elif key in ('l3', 'maxram'):
                vro, vru = fix_mb(vro), fix_mb(vru)
            elif key == 'codename' and re.search(r'Ryzen|Core', vro, re.I):
                continue
            elif key == 'igpu':
                if vro.lower().startswith('fără grafic'):
                    v.pop('igpu', None); continue
                g, _ = gen_dsc.clean_igpu(vro)
                vro = vru = g
            if vro:
                v[key] = (vro, vru or vro)
        b = ghz(U.get('Frecvența procesor {GHz}', ('', ''))[0])
        tb = ghz(U.get('Frecvența Turbo {GHz}', ('', ''))[0])
        if b and not t.get('freq'):       # titlul ramane prioritar la frecventa
            f = '%g-%g' % (b, tb) if tb and tb > b else '%g' % b
            v['freq'] = (f + ' GHz', f + ' ГГц')
    if no_igpu_suffix:
        v.pop('igpu', None)
    return v, title


def param_id(cur, filterid, val_ro, val_ru, cache):
    """Gaseste sau creeaza valoarea in TS_FILTER_PARAMS."""
    key = (filterid, val_ro.strip().lower())
    if key in cache:
        return cache[key]
    cur.execute("""SELECT FILTERPARAMID FROM TS_FILTER_PARAMS
                   WHERE FILTERID=? AND UPPER(TRIM(PARAM_VALUE))=UPPER(?)""", (filterid, val_ro.strip()))
    row = cur.fetchone()
    if row:
        cache[key] = row[0]
        return row[0]
    cur.execute("SELECT NEXT VALUE FOR SQ_TS_FILTER_PARAMS_ID FROM RDB$DATABASE")
    pid = cur.fetchone()[0]
    cur.execute("""INSERT INTO TS_FILTER_PARAMS (FILTERID, FILTERPARAMID, PARAM_VALUE, PARAM_VALUE_RUS, CREATED_BY)
                   VALUES (?, ?, ?, ?, 204)""", (filterid, pid, val_ro.strip(), (val_ru or val_ro).strip()))
    cache[key] = pid
    return pid


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else 'pilot'
    ultra_link = json.load(io.open('ultra_link_all.json', encoding='utf-8'))
    con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
    cur = con.cursor()
    cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','204') FROM RDB$DATABASE"); cur.fetchone()

    if mode == 'pilot':
        targets = PILOT
    else:
        cur.execute("""SELECT g.GOODSID FROM TS_GOODS g
         WHERE g.WEBGOODSTYPE_ID=8 AND COALESCE(g.FLG_FOLDER,0)=0
         AND EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS c WHERE c.GOODSID=g.GOODSID) ORDER BY g.GOODSID""")
        targets = [r[0] for r in cur]

    log = io.open('fill_descriptions_%s.txt' % mode, 'w', encoding='utf-8')
    cache, added, produse, param_noi = {}, 0, 0, 0
    for gid in targets:
        vals, title = values_for(gid, cur, ultra_link)
        cur.execute("SELECT FILTERID FROM TS_GOODS_DESCRIPTIONS WHERE GOODSID=?", (gid,))
        have = {r[0] for r in cur}
        noi = []
        for name, fid, orderno, key in SLOTS:
            if fid in have or key not in vals:
                continue
            vro, vru = vals[key]
            if not vro or vro.strip() in ('', '-', '?'):
                continue
            before = len(cache)
            pid = param_id(cur, fid, vro, vru, cache)
            if len(cache) > before:
                cur.execute("SELECT COUNT(*) FROM TS_FILTER_PARAMS WHERE FILTERID=? AND FILTERPARAMID=?", (fid, pid))
            cur.execute("""INSERT INTO TS_GOODS_DESCRIPTIONS (GOODSID, FLG_GROUP, FILTERID, FILTERPARAMID, FLAGS, ORDERNO)
                           VALUES (?, 0, ?, ?, 1, ?)""", (gid, fid, pid, orderno))
            noi.append((orderno, name, vro))
            added += 1
        if noi:
            produse += 1
            log.write("%s  %s\n" % (gid, title[:76]))
            for o, n, v in sorted(noi):
                log.write("    +%-3s %-30s %s\n" % (o, n, v))
    con.commit()
    log.write("\nproduse atinse: %d, caracteristici adaugate: %d\n" % (produse, added))

    for gid in (targets[:1] if mode == 'pilot' else []):
        cur.execute("""SELECT ORDERNO, FILTERNAME_ROM, PARAM_VALUE_ROM, PARAM_VALUE_RUS
                       FROM VW_TS_GOODS_DESCRIPTIONS WHERE GOODSID=? ORDER BY ORDERNO""", (gid,))
        log.write("\nrezultat prin VW_TS_GOODS_DESCRIPTIONS pentru %d:\n" % gid)
        for o, n, vro, vru in cur:
            log.write("   %-3s %-30s %-24s %s\n" % (o, (n or '')[:30], (vro or '')[:24], vru or ''))
    log.close(); con.close()
    print('mode', mode, 'produse', produse, 'adaugate', added)

main()
