# -*- coding: utf-8 -*-
"""Genereaza descrieri RO/RU pentru procesoarele din price fara descriere.

Sursa de adevar: filtrele produsului (TS_GOODS_FILTERS -> TS_FILTERS/TS_FILTER_PARAMS),
cu etichetele si ordinea din sablonul tipului (TS_GOODS_TYPE_FILTERS, GOODSTYPEID=8).
Unde produsul nu are filtre, valorile se deduc din TITLE si primesc aceleasi etichete.
"""
import firebird.driver as fb, io, json, re

data = json.load(io.open('cpu_data.json', encoding='utf-8'))

# eticheta de filtru -> cheia interna de spec (potrivire pe NUME, fiindca acelasi
# filtru exista cu mai multe FILTERID-uri omonime)
NAME2KEY = {
    'numărul nucleelor': 'cores', 'numărul threads': 'threads',
    'frecvenţa procesor': 'freq', 'frecvența procesor': 'freq',
    'cpu socket': 'socket', 'procesul tehnic': 'nm',
    'degajarea de căldură': 'tdp', 'cache l3': 'l3', 'cache l2': 'l2',
    'procesorul grafic': 'igpu',
}
# filtrele-sablon folosite la produsele fara filtre
DERIVED = [(101, 'cores'), (2895, 'threads'), (98, 'freq'), (38, 'socket'),
           (137, 'nm'), (138, 'tdp'), (106, 'l3'), (105, 'l2'), (210, 'igpu')]

PREFER_FILTER = {'igpu', 'nm'}   # restul cheilor: titlul produsului are prioritate

UNIT_RU = [('GHz', 'ГГц'), ('MHz', 'МГц'), ('MB', 'МБ'), ('GB', 'ГБ'), (' W', ' Вт'), ('nm', 'нм')]

def ru_val(v):
    v = str(v)
    for a, b in UNIT_RU:
        v = v.replace(a, b)
    return v

def junk(name, value):
    v = (value or '').strip()
    if v == '' or v == '-':
        return True
    return v.lower() == (name or '').strip().lower()

def no_igpu_by_suffix(model):
    if not model:
        return False
    return bool(re.search(r'(KF|[0-9]F)$', model.strip().upper()))

def clean_igpu(v):
    """Normalizeaza denumirea graficii integrate. Intoarce (text, generic?)."""
    if not v:
        return None, False
    t = re.sub(r'\s+', ' ', str(v)).strip().strip(',.')
    t = re.sub(r'^(Integrated|Integrata|Integrată|Integ\.?)\s*', '', t, flags=re.I).strip()
    if not t or re.fullmatch(r'graphics', t, re.I):
        return None, True                      # exista grafica, dar fara denumire utila
    if re.match(r'^UHD\s*Graphics', t, re.I):
        t = 'Intel ' + t
    if t.isupper():                            # "RADEON GRAPHICS" -> "Radeon Graphics"
        t = ' '.join(w if re.search(r'\d', w) else w.capitalize() for w in t.split())
    return t, False

WORDS = {'RYZEN': 'Ryzen', 'CORE': 'Core', 'ULTRA': 'Ultra', 'PENTIUM': 'Pentium',
         'CELERON': 'Celeron', 'ATHLON': 'Athlon', 'XEON': 'Xeon',
         'THREADRIPPER': 'Threadripper', 'PRO': 'PRO'}

def pretty_model(model):
    if not model:
        return ''
    out = []
    for w in model.split():
        u = w.upper()
        if u in WORDS:
            out.append(WORDS[u])
        elif re.match(r'^I[3579]-', u):
            out.append('i' + w[1:])
        else:
            out.append(w)
    return ' '.join(out)

def fallback_name(title):
    """Nume citibil cand modelul nu a putut fi extras: taie prefixul si coada tehnica."""
    t = re.sub(r'\s+', ' ', (title or '')).strip()
    t = re.sub(r'^(Procesor|CPU)\s+', '', t, flags=re.I).strip()
    t = re.split(r'[,(]', t)[0].strip()
    return t[:70].strip() or (title or '').strip()

def display_name(s, title):
    brand = s.get('brand') or ''
    model = pretty_model(s.get('model'))
    if not model:
        return fallback_name(title)
    if brand == 'Intel' and re.match(r'^i[3579]-', model):
        model = 'Core ' + model
    return (brand + ' ' + model).strip()

def merged_specs(d):
    """Specs din titlu, suprascrise de valorile filtrelor. Intoarce (specs, conflicte)."""
    s = dict(d['specs'])
    conflicts = []
    for fid, name, name_ru, val, val_ru in d['filters']:
        key = NAME2KEY.get(name.strip().lower())
        if not key or junk(name, val):
            continue
        v = val.strip()
        old = s.get(key)
        if key in ('cores', 'threads'):
            if not re.match(r'^\d+$', v):
                continue
            v = int(v)
        if old in (None, '', '?'):
            s[key] = v                      # filtrul completeaza un gol din titlu
        elif str(old).replace(' ', '').lower() != str(v).replace(' ', '').lower():
            conflicts.append((key, old, v, 'filtru' if key in PREFER_FILTER else 'titlu'))
            if key in PREFER_FILTER:
                s[key] = v                  # denumirea graficii / procesul tehnic: filtrul e mai ingrijit
    if no_igpu_by_suffix(s.get('model')):
        s['igpu'] = None
    return s, conflicts

def build_prose(s, title):
    name = display_name(s, title)
    igpu_known = ('igpu' in s)
    igpu_txt, igpu_generic = clean_igpu(s.get('igpu'))

    ro, ru = [], []
    p_ro = "%s este un procesor" % name
    p_ru = "%s — процессор" % name
    if s.get('socket'):
        p_ro += " pentru socketul %s" % s['socket']
        p_ru += " для сокета %s" % s['socket']
    if s.get('cores'):
        c = s['cores']
        if s.get('pcore') and s.get('ecore'):
            p_ro += "%s cu %s nuclee (%d de performanță și %d de eficiență)" % (',' if s.get('socket') else '', c, s['pcore'], s['ecore'])
            p_ru += " с %s ядрами (%d производительных и %d энергоэффективных)" % (c, s['pcore'], s['ecore'])
        else:
            p_ro += "%s cu %s nuclee" % (',' if s.get('socket') else '', c)
            p_ru += " с %s ядрами" % c
        if s.get('threads'):
            p_ro += " și %s fire de execuție" % s['threads']
            p_ru += " и %s потоками" % s['threads']
    ro.append(p_ro + "."); ru.append(p_ru + ".")

    f_ro, f_ru = [], []
    if s.get('freq'):
        fq = str(s['freq'])
        m = re.match(r'^\s*([\d.]+)\s*-\s*([\d.]+)\s*GHz\s*$', fq)
        if m:
            f_ro.append("Frecvența de lucru pornește de la %s GHz și urcă până la %s GHz în regim turbo" % m.groups())
            f_ru.append("Рабочая частота начинается с %s ГГц и поднимается до %s ГГц в турборежиме" % m.groups())
        else:
            f_ro.append("Frecvența de lucru este de %s" % fq)
            f_ru.append("Рабочая частота составляет %s" % ru_val(fq))
    if s.get('l3'):
        f_ro.append("memoria cache L3 este de %s" % s['l3'])
        f_ru.append("объём кэша L3 — %s" % ru_val(s['l3']))
    if s.get('nm'):
        f_ro.append("iar procesul tehnologic de fabricație este de %s" % s['nm'])
        f_ru.append("а техпроцесс изготовления — %s" % ru_val(s['nm']))
    if f_ro:
        t_ro_s = ", ".join(f_ro); t_ru_s = ", ".join(f_ru)
        t_ro_s = re.sub(r'^iar\s+', '', t_ro_s); t_ru_s = re.sub(r'^а\s+', '', t_ru_s)
        ro.append(t_ro_s[0].upper() + t_ro_s[1:] + "."); ru.append(t_ru_s[0].upper() + t_ru_s[1:] + ".")

    if igpu_known:
        if igpu_txt:
            ro.append("Grafica integrată %s permite pornirea sistemului fără placă video dedicată." % igpu_txt)
            ru.append("Встроенная графика %s позволяет запустить систему без дискретной видеокарты." % igpu_txt)
        elif igpu_generic:
            ro.append("Procesorul are grafică integrată, deci sistemul poate funcționa fără placă video dedicată.")
            ru.append("Процессор имеет встроенную графику, поэтому система может работать без дискретной видеокарты.")
        else:
            ro.append("Procesorul nu are grafică integrată, deci configurația necesită obligatoriu o placă video dedicată.")
            ru.append("У процессора нет встроенной графики, поэтому сборке обязательно нужна дискретная видеокарта.")

    tdp, tray = s.get('tdp'), (s.get('tray') and not re.search(r'cooler', title, re.I))
    if tdp and tray:
        ro.append("Consumul declarat (TDP) este de %s, iar varianta tray se livrează fără sistem de răcire." % tdp)
        ru.append("Заявленное тепловыделение (TDP) — %s, а вариант tray поставляется без системы охлаждения." % ru_val(tdp))
    elif tdp:
        ro.append("Consumul declarat (TDP) este de %s." % tdp)
        ru.append("Заявленное тепловыделение (TDP) — %s." % ru_val(tdp))
    elif tray:
        ro.append("Varianta tray se livrează fără sistem de răcire.")
        ru.append("Вариант tray поставляется без системы охлаждения.")

    return " ".join(ro), " ".join(ru)

def build_specs(d, s, fmap, tpl_order):
    """Bloc de caracteristici: etichete si ordine din sablon; valorile din titlu
    (autoritare) completate cu cele din filtre."""
    rows, seen = [], set()
    for fid, name, name_ru, val, val_ru in d['filters']:
        if junk(name, val):
            continue
        key = NAME2KEY.get(name.strip().lower())
        if key:
            v = s.get(key)
            if key == 'igpu':
                v, _ = clean_igpu(v)
            if v in (None, '', '?'):
                continue
            seen.add(key)
            rows.append((tpl_order.get(fid, 999), name, name_ru or name, str(v), ru_val(v)))
        else:
            rows.append((tpl_order.get(fid, 999), name, name_ru or name, val, val_ru or val))
    for fid, key in DERIVED:
        if key in seen:
            continue
        v = s.get(key)
        if key == 'igpu':
            v, _ = clean_igpu(v)
        if v in (None, '', '?'):
            continue
        nm_ro, nm_ru = fmap[fid]
        rows.append((tpl_order.get(fid, 999), nm_ro, nm_ru, str(v), ru_val(v)))
    rows.sort(key=lambda r: (r[0], r[1]))
    ro = ["%s: %s" % (r[1], r[3]) for r in rows]
    ru = ["%s: %s" % (r[2], r[4]) for r in rows]
    return ro, ru, ('filtre+titlu' if d['filters'] else 'titlu')

def main():
    con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
    cur = con.cursor()
    cur.execute("SELECT FILTERID, ORDERNO FROM TS_GOODS_TYPE_FILTERS WHERE GOODSTYPEID=8")
    tpl_order = {r[0]: r[1] for r in cur}
    cur.execute("SELECT FILTERID, FILTERNAME, FILTERNAME_RUS FROM TS_FILTERS WHERE FILTERID IN %s" % (tuple(f for f, _ in DERIVED),))
    fmap = {r[0]: (r[1].strip(), (r[2] or r[1]).strip()) for r in cur}
    con.close()

    out, stats, all_conf = {}, {'filtre+titlu': 0, 'titlu': 0}, []
    for gid, d in data.items():
        if d['ndsc']:
            continue
        s, conf = merged_specs(d)
        if conf:
            all_conf.append((gid, d['title'], conf))
        pro_ro, pro_ru = build_prose(s, d['title'])
        sp_ro, sp_ru, src = build_specs(d, s, fmap, tpl_order)
        stats[src] += 1
        ro = pro_ro + ("\n\nCaracteristici principale:\n" + "\n".join(sp_ro) if sp_ro else "")
        ru = pro_ru + ("\n\nОсновные характеристики:\n" + "\n".join(sp_ru) if sp_ru else "")
        out[gid] = dict(ro=ro, ru=ru, src=src, title=d['title'])

    json.dump(out, io.open('gen_dsc.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    with io.open('conflicts.txt', 'w', encoding='utf-8') as f:
        f.write("Neconcordante intre denumirea produsului si filtre (ultima coloana = sursa folosita):" + chr(10)*2)
        for gid, title, conf in all_conf:
            f.write("%s  %s\n" % (gid, title[:88]))
            for k, old, new, used in conf:
                f.write("    %-8s titlu=%-22s filtru=%-22s -> %s" % (k, old, new, used) + chr(10))

        f.write("\ntotal produse cu neconcordante: %d\n" % len(all_conf))
    sample = ['336188', '306823', '377097', '283278', '304414', '341784', '379900', '400517']
    with io.open('gen_preview.txt', 'w', encoding='utf-8') as f:
        f.write("generate: %d (filtre %d / titlu %d); neconcordante: %d\n\n"
                % (len(out), stats['filtre+titlu'], stats['titlu'], len(all_conf)))
        for gid in sample:
            if gid in out:
                v = out[gid]
                f.write("=" * 72 + "\n%s [%s]  %s\n--RO--\n%s\n--RU--\n%s\n" % (gid, v['src'], v['title'][:95], v['ro'], v['ru']))
    print('generated', len(out), stats, 'conflicte', len(all_conf))

main()
