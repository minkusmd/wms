# -*- coding: utf-8 -*-
"""Regenereaza descrierile procesoarelor care au corespondent la Ultra, folosind
proprietatile din TS_ULTRA2_PROPERTY_VALUE ca sursa principala.

Blocul de caracteristici pastreaza vocabularul catalogului: etichetele si ordinea
vin din sablonul tipului (TS_GOODS_TYPE_FILTERS + TS_FILTERS); proprietatile Ultra
care nu au corespondent in sablon se adauga la sfarsit cu numele lor Ultra.
"""
import firebird.driver as fb, io, json, re

# proprietate Ultra -> (FILTERID din sablon, cheia interna)
MAP = {
    'Numar Nuclee':             (101,  'cores'),
    'TDP':                      (138,  'tdp'),
    'Socket':                   (38,   'socket'),
    'Litografie':               (137,  'nm'),
    'Dimensiune maximă RAM':    (142,  'maxram'),
    'Nume-cod Procesor':        (100,  'codename'),
    'Memorie Cache (L3)':       (106,  'l3'),
    'Suport memorie ESS':       (144,  'ecc'),
    'Grafică Integrată':        (210,  'igpu'),
    'Numar thread-uri':         (2895, 'threads'),
    'Tip Memorie':              (141,  'memtype'),
}
# proprietati Ultra pastrate ca randuri suplimentare, cu numele lor
EXTRA = ['Canale de memorie', 'Frecvență memorie', 'Versiunea PCI Express',
         'Număr maxim benzi PCI Express', 'Rezoluție maximă', 'Num. display-uri acceptate']
# ignorate: redundante sau cu unitati inconsecvente in sursa
SKIP = {'Tip', 'Modelul procesorului', 'Ambalaj', 'Set sistem de racire',
        'Frecvența de bază Grafică {GHz}', 'Frecvența magistralei de sistem',
        'Max. Volumul memoriei video a sistemului grafic', 'Frecvența procesor {GHz}',
        'Frecvența Turbo {GHz}'}

NO_IGPU_RO = 'Fără grafică integrată'

def num(v):
    m = re.match(r'\s*(\d+)', v or '')
    return m.group(1) if m else None

def fix_mb(v):
    return re.sub(r'(\d)\s*(MB|МБ|GB|ГБ)', r'\1 \2', (v or '').strip())

def _ghz(v):
    """Sursa amesteca GHz cu MHz (ex. turbo=4100 pentru un procesor de 4,1 GHz)."""
    v = (v or '').replace(',', '.').strip()
    try:
        x = float(v)
    except ValueError:
        return None
    if x > 100:          # valoare in MHz
        x = x / 1000.0
    if not (0.3 <= x <= 10):
        return None      # in afara oricarui interval plauzibil pentru un procesor
    return round(x, 2)

def fmt(x):
    return ('%g' % x)

def fix_freq(base, turbo, unit):
    b, t = _ghz(base), _ghz(turbo)
    if b is None:
        return None
    if t is not None and t > b:
        return '%s-%s %s' % (fmt(b), fmt(t), unit)
    return '%s %s' % (fmt(b), unit)

def build(gid, link, props, tpl_order, fmap, title):
    """props: lista (name_ro, name_ru, value_ro, value_ru)"""
    P = {}
    for nro, nru, vro, vru in props:
        P[(nro or '').strip()] = ((vro or '').strip(), (vru or '').strip(), (nru or '').strip())

    s = {}
    for uname, (fid, key) in MAP.items():
        if uname not in P:
            continue
        vro, vru, _ = P[uname]
        if not vro:
            continue
        if key in ('cores', 'threads'):
            vro = vru = num(vro)
        elif key in ('l3', 'maxram'):
            vro, vru = fix_mb(vro), fix_mb(vru)
        elif key == 'codename' and re.search(r'Ryzen|Core', vro, re.I):
            continue                      # la AMD sursa pune familia, nu numele de cod
        elif key == 'igpu' and vro.lower().startswith('fără grafic'):
            vro = vru = None              # lipsa graficii se spune in proza
        if vro:
            s[key] = (vro, vru or vro)
    fro = fix_freq(P.get('Frecvența procesor {GHz}', ('', '', ''))[0],
                   P.get('Frecvența Turbo {GHz}', ('', '', ''))[0], 'GHz')
    fru = fix_freq(P.get('Frecvența procesor {GHz}', ('', '', ''))[0],
                   P.get('Frecvența Turbo {GHz}', ('', '', ''))[0], 'ГГц')
    # frecventa: denumirea produsului are prioritate (Ultra da uneori baza P-core,
    # iar titlul baza E-core; la 5700G Ultra are turbo gresit)
    t_freq = link.get('title_freq')
    if t_freq:
        s['freq'] = (t_freq, t_freq.replace('GHz', 'ГГц'))
    elif fro:
        s['freq'] = (fro, fru)
    has_igpu = 'Grafică Integrată' in P
    no_igpu = has_igpu and P['Grafică Integrată'][0].lower().startswith('fără grafic')

    # ---------- proza ----------
    name = link['display']
    ro = ["%s este un procesor" % name]
    ru = ["%s — процессор" % name]
    if 'socket' in s:
        ro[0] += " pentru socketul %s" % s['socket'][0]
        ru[0] += " для сокета %s" % s['socket'][1]
    if 'cores' in s:
        ro[0] += "%s cu %s nuclee" % (',' if 'socket' in s else '', s['cores'][0])
        ru[0] += " с %s ядрами" % s['cores'][1]
        if 'threads' in s:
            ro[0] += " și %s fire de execuție" % s['threads'][0]
            ru[0] += " и %s потоками" % s['threads'][1]
    ro[0] += "."; ru[0] += "."

    f_ro, f_ru = [], []
    if 'freq' in s:
        m = re.match(r'^([\d.]+)-([\d.]+)', s['freq'][0])
        if m:
            f_ro.append("Frecvența de lucru pornește de la %s GHz și urcă până la %s GHz în regim turbo" % m.groups())
            f_ru.append("Рабочая частота начинается с %s ГГц и поднимается до %s ГГц в турборежиме" % m.groups())
        else:
            f_ro.append("Frecvența de lucru este de %s" % s['freq'][0])
            f_ru.append("Рабочая частота составляет %s" % s['freq'][1])
    if 'l3' in s:
        f_ro.append("memoria cache L3 este de %s" % s['l3'][0])
        f_ru.append("объём кэша L3 — %s" % s['l3'][1])
    if 'nm' in s:
        f_ro.append("iar procesul tehnologic de fabricație este de %s" % s['nm'][0])
        f_ru.append("а техпроцесс изготовления — %s" % s['nm'][1])
    if f_ro:
        a, b = ", ".join(f_ro), ", ".join(f_ru)
        a = re.sub(r'^iar\s+', '', a); b = re.sub(r'^а\s+', '', b)
        ro.append(a[0].upper() + a[1:] + "."); ru.append(b[0].upper() + b[1:] + ".")

    if 'memtype' in s:
        mt = s['memtype'][0].replace(' SDRAM', '')
        ro.append("Controlerul de memorie lucrează cu module %s." % mt)
        ru.append("Контроллер памяти работает с модулями %s." % s['memtype'][1].replace(' SDRAM', ''))

    if has_igpu:
        if no_igpu:
            ro.append("Procesorul nu are grafică integrată, deci configurația necesită obligatoriu o placă video dedicată.")
            ru.append("У процессора нет встроенной графики, поэтому сборке обязательно нужна дискретная видеокарта.")
        elif 'igpu' in s:
            ro.append("Grafica integrată %s permite pornirea sistemului fără placă video dedicată." % s['igpu'][0])
            ru.append("Встроенная графика %s позволяет запустить систему без дискретной видеокарты." % s['igpu'][1])

    tray = re.search(r'\bTRAY\b', title, re.I) and not re.search(r'cooler', title, re.I)
    if 'tdp' in s and tray:
        ro.append("Consumul declarat (TDP) este de %s, iar varianta tray se livrează fără sistem de răcire." % s['tdp'][0])
        ru.append("Заявленное тепловыделение (TDP) — %s, а вариант tray поставляется без системы охлаждения." % s['tdp'][1])
    elif 'tdp' in s:
        ro.append("Consumul declarat (TDP) este de %s." % s['tdp'][0])
        ru.append("Заявленное тепловыделение (TDP) — %s." % s['tdp'][1])
    elif tray:
        ro.append("Varianta tray se livrează fără sistem de răcire.")
        ru.append("Вариант tray поставляется без системы охлаждения.")

    # ---------- bloc de caracteristici ----------
    rows = []
    for uname, (fid, key) in MAP.items():
        if key not in s:
            continue
        nm_ro, nm_ru = fmap[fid]
        rows.append((tpl_order.get(fid, 500), nm_ro, nm_ru, s[key][0], s[key][1]))
    if 'freq' in s:
        nm_ro, nm_ru = fmap[98]
        rows.append((tpl_order.get(98, 500), nm_ro, nm_ru, s['freq'][0], s['freq'][1]))
    rows.sort(key=lambda r: (r[0], r[1]))
    for uname in EXTRA:
        if uname in P and P[uname][0]:
            vro, vru, nru = P[uname]
            rows.append((999, uname, nru or uname, vro, vru or vro))

    sp_ro = ["%s: %s" % (r[1], r[3]) for r in rows]
    sp_ru = ["%s: %s" % (r[2], r[4]) for r in rows]
    return (" ".join(ro) + "\n\nCaracteristici principale:\n" + "\n".join(sp_ro),
            " ".join(ru) + "\n\nОсновные характеристики:\n" + "\n".join(sp_ru))


def main():
    link = json.load(io.open('ultra_link_all.json', encoding='utf-8'))
    prev = json.load(io.open('gen_dsc.json', encoding='utf-8'))
    import parse_cpu, gen_dsc
    con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
    cur = con.cursor()
    cur.execute("SELECT FILTERID, ORDERNO FROM TS_GOODS_TYPE_FILTERS WHERE GOODSTYPEID=8")
    tpl_order = {r[0]: r[1] for r in cur}
    fids = tuple({fid for fid, _ in MAP.values()} | {98})
    cur.execute("SELECT FILTERID, FILTERNAME, FILTERNAME_RUS FROM TS_FILTERS WHERE FILTERID IN %s" % (fids,))
    fmap = {r[0]: (r[1].strip(), (r[2] or r[1]).strip()) for r in cur}

    out = {}
    for gid, v in link.items():
        cur.execute("""SELECT pr.NAME_RO, pr.NAME_RU, p.VALUE_RO, p.VALUE_RU
                       FROM TS_ULTRA2_PROPERTY_VALUE p
                       LEFT JOIN TS_ULTRA2_PROPERTY pr ON pr.CODE=p.PROPERTY_CODE
                       WHERE p.PRODUCT_UUID=? ORDER BY p.SORT_ORDER""", (v['uuid'],))
        props = [(r[0], r[1], r[2], r[3]) for r in cur if (r[0] or '').strip() not in SKIP
                 or (r[0] or '').strip().startswith('Frecvența')]
        specs = parse_cpu.parse(v['title'])
        v['display'] = gen_dsc.display_name(specs, v['title'])
        v['title_freq'] = specs.get('freq')
        ro, ru = build(gid, v, props, tpl_order, fmap, v['title'])
        out[gid] = dict(ro=ro, ru=ru, title=v['title'], code=v['code'])
    con.close()

    json.dump(out, io.open('gen_dsc_ultra.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    with io.open('gen_ultra_preview.txt', 'w', encoding='utf-8') as f:
        f.write("regenerate din Ultra: %d\n\n" % len(out))
        for gid in list(out)[:3] + ['373186', '379900'] if '373186' in out else list(out)[:5]:
            v = out[gid]
            f.write("=" * 72 + "\n%s  %s\n--RO--\n%s\n--RU--\n%s\n" % (gid, v['title'][:88], v['ro'], v['ru']))
    print('generated', len(out))

main()
