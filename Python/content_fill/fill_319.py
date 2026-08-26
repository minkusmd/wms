# -*- coding: utf-8 -*-
"""Completeaza caracteristicile frigiderelor (tip 319) in TS_GOODS_DESCRIPTIONS,
din proprietatile furnizorului Ultra.

Principii:
  - se adauga DOAR caracteristicile care lipsesc la produs; nimic nu se suprascrie;
  - valorile se normalizeaza la formatul deja folosit in catalog, ca sa nu se
    fragmenteze dictionarul de filtre (TS_FILTER_PARAMS);
  - randurile-titlu de grup (FLG_GROUP=1) se adauga doar daca sub ele intra
    macar o caracteristica noua.

Utilizare: python fill_319.py pilot|all
"""
import firebird.driver as fb, io, json, re, sys

GT = 319
PILOT_N = 3

# --- normalizatoare -------------------------------------------------------
def numeric(suf_ro, suf_ru, lo, hi, dec=True):
    def f(vro, vru):
        v = (vro or '').replace(',', '.').strip()
        try:
            x = float(v)
        except ValueError:
            return None
        if not (lo <= x <= hi):
            return None
        s = ('%g' % x)
        return (s + suf_ro, s + suf_ru)
    return f

def enum(table):
    def f(vro, vru):
        return table.get((vro or '').strip())
    return f

TIP_CONTROL = {'Electronică': ('Electronică', 'Электронное'),
               'Electronic senzor': ('Sensor', 'Сенсорное'),
               'Mecanic': ('Mecanică', 'Механическое'),
               'Electronic mecanic': ('Electro-mecanic', 'Электромеханическое')}
AMPL_CONG = {'De jos': ('Jos', 'Снизу'), 'De sus': ('Sus', 'Сверху'),
             'Pe partea laterală (Side-by-Side)': ('Dintr-o parte', 'Сбоку')}
INSTALARE = {'Indepenta': ('Detașat', 'Отдельностоящий'),
             'Încorporabil': ('Incorporabil', 'Встраиваемый'),
             'Incorporabil': ('Incorporabil', 'Встраиваемый')}
DEZG_CONG = {'No Frost': ('No Frost', 'No Frost'),
             'Automată': ('Automat', 'Aвтоматическое'),
             'Manual': ('Dezghetare manuala', 'Ручное размораживание')}
DEZG_FRIG = {'No Frost': ('No Frost', 'No Frost'),
             'Automată': ('Automat', 'Aвтоматическое'),
             'Sistem de picurare': ('Dezghetare prin picurare', 'Капельная система размораживания'),
             'Manual': ('Dezghetare manuală', 'Ручное размораживание')}
SUPERCONG = {'Da': ('Este', 'Есть'), 'Nu': ('Nu este', 'Нет')}
RAFTURI = {'Sticlă călită': ('Sticlă călită', 'Закаленное стекло'),
           'Sticlă': ('Sticlă', 'Стекло'), 'Plastic': ('Plastic', 'Пластик')}
CULOARE = {'Alb': ('Alb', 'Белый'), 'Negru': ('Negru', 'Черный'), 'Gri': ('Gri', 'Серый'),
           'Argintiu': ('Argintiu', 'Серебристый'), 'Inox': ('Inox', 'Нержавеющая сталь'),
           'Bej': ('Bej', 'Бежевый'), 'Grafit': ('Grafit', 'Графит')}
CLASA = {c: (c, c) for c in ('A', 'B', 'C', 'D', 'E', 'F', 'A+', 'A++', 'A+++')}

def intval(lo, hi):
    def f(vro, vru):
        m = re.match(r'^\s*(\d+)\s*$', (vro or ''))
        if not m:
            return None
        x = int(m.group(1))
        return (m.group(1), m.group(1)) if lo <= x <= hi else None
    return f

# (proprietate Ultra, FILTERID, ORDERNO, normalizator)
SLOTS = [
    ('Tip instalare',                     1047, 3,  enum(INSTALARE)),
    ('Amplasare congelator',              1048, 4,  enum(AMPL_CONG)),
    ('Culoare',                           1696, 5,  enum(CULOARE)),
    ('Tip control',                       1051, 7,  enum(TIP_CONTROL)),
    ('Clasa energetică',                  1052, 8,  enum(CLASA)),
    ('Consum anual energie{kWh}',         3670, 9,  numeric('', '', 50, 1500)),
    ('Numărul de compresoare',            1053, 10, intval(1, 4)),
    ('Numărul de camere',                 1055, 12, intval(1, 8)),
    ('Capacitate de congelare {kg /zi}',  1059, 15, numeric(' kg/24 h', ' кг/сутки', 1, 50)),
    ('Sistem dezghețare congelator',      1057, 16, enum(DEZG_CONG)),
    ('Sistem dezghețare frigider',        1058, 17, enum(DEZG_FRIG)),
    ('Supercongelare',                    1068, 18, enum(SUPERCONG)),
    ('Pastrarea autonomă a frigului {ore}', 3763, 19, numeric('', '', 1, 100)),
    ('Volumul total util{l}',             1060, 21, numeric(' l', ' л', 10, 900)),
    ('Volumul util al frigiderului {l}',  1061, 22, numeric(' l', ' л', 5, 700)),
    ('Volumul util al congelatorului {l}', 1062, 23, numeric(' l', ' л', 3, 500)),
    ('Număr compartimente în congelator', 3798, 26, intval(1, 10)),
    ('Materialul rafturilor',             1064, 28, enum(RAFTURI)),
    ('Nivel de zgomot maxim {dB}',        1066, 30, numeric(' dB', ' дБ', 20, 70)),
    ('Înălţime {cm}',                     1069, 32, numeric(' cm', ' см', 30, 250)),
    ('Lăţime {cm}',                       1070, 33, numeric(' cm', ' см', 25, 200)),
    ('Adâncime {cm}',                     1071, 34, numeric(' cm', ' см', 25, 120)),
    ('Greutate {kg}',                     1067, 35, numeric(' kg', ' кг', 10, 250)),
]

# randuri-titlu de grup: (FILTERID, ORDERNO, text, acopera ORDERNO-urile...)
GROUPS = [(2711, 1,  'Caracteristici generale',       range(2, 14)),
          (2712, 14, 'Răcire',                        range(15, 20)),
          (2713, 20, 'Volum',                         range(21, 24)),
          (2714, 24, 'Funcțional și particularități', range(25, 31)),
          (2715, 31, 'Dimensiuni',                    range(32, 36))]


def param_id(cur, filterid, val_ro, val_ru, cache, created):
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
    created.append((filterid, val_ro.strip()))
    return pid


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else 'pilot'
    link = json.load(io.open('ultra_link_%d.json' % GT, encoding='utf-8'))
    con = fb.connect('192.168.106.254/3050:SW', user='SYSDBA', password='uigres321', charset='UTF8')
    cur = con.cursor()
    cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','204') FROM RDB$DATABASE"); cur.fetchone()

    gids = sorted(link, key=lambda x: int(x))
    if mode == 'pilot':
        goale = []
        for g in gids:
            cur.execute("SELECT COUNT(*) FROM TS_GOODS_DESCRIPTIONS WHERE GOODSID=?", (int(g),))
            if cur.fetchone()[0] == 0:
                goale.append(g)
            if len(goale) >= PILOT_N:
                break
        gids = goale

    log = io.open('fill_319_%s.txt' % mode, 'w', encoding='utf-8')
    cache, created, added, produse, respinse = {}, [], 0, 0, {}
    for gid_s in gids:
        gid = int(gid_s)
        cur.execute("""SELECT pr.NAME_RO, v.VALUE_RO, v.VALUE_RU
                       FROM TS_ULTRA2_PROPERTY_VALUE v
                       JOIN TS_ULTRA2_PROPERTY pr ON pr.CODE=v.PROPERTY_CODE
                       WHERE v.PRODUCT_UUID=?""", (link[gid_s]['uuid'],))
        U = {}
        for nm, vro, vru in cur:
            nm = (nm or '').strip()
            if nm and (vro or '').strip() and nm not in U:
                U[nm] = ((vro or '').strip(), (vru or '').strip())
        # clasa energetica: doua proprietati posibile
        if 'Clasa energetică' not in U and 'Clasa de eficiență energetică' in U:
            U['Clasa energetică'] = U['Clasa de eficiență energetică']

        cur.execute("SELECT FILTERID FROM TS_GOODS_DESCRIPTIONS WHERE GOODSID=?", (gid,))
        have = {r[0] for r in cur}

        noi = []
        for uname, fid, orderno, norm in SLOTS:
            if fid in have or uname not in U:
                continue
            res = norm(U[uname][0], U[uname][1])
            if not res:
                respinse[uname] = respinse.get(uname, 0) + 1
                continue
            vro, vru = res
            pid = param_id(cur, fid, vro, vru, cache, created)
            cur.execute("""INSERT INTO TS_GOODS_DESCRIPTIONS (GOODSID, FLG_GROUP, FILTERID, FILTERPARAMID, FLAGS, ORDERNO)
                           VALUES (?, 0, ?, ?, 1, ?)""", (gid, fid, pid, orderno))
            noi.append((orderno, uname, vro))
            added += 1
        # titluri de grup, doar unde am adaugat continut
        if noi:
            ords = {o for o, _, _ in noi}
            for gfid, gord, gtext, rng in GROUPS:
                if gfid in have or not (ords & set(rng)):
                    continue
                pid = param_id(cur, gfid, gtext, gtext, cache, created)
                cur.execute("""INSERT INTO TS_GOODS_DESCRIPTIONS (GOODSID, FLG_GROUP, FILTERID, FILTERPARAMID, FLAGS, ORDERNO)
                               VALUES (?, 1, ?, ?, 1, ?)""", (gid, gfid, pid, gord))
                added += 1
            produse += 1
            log.write("%s  %s\n" % (gid, link[gid_s]['title'][:74]))
            for o, n, v in sorted(noi):
                log.write("    +%-3s %-34s %s\n" % (o, n[:34], v))
    con.commit()
    log.write("\nproduse atinse: %d, randuri adaugate: %d\n" % (produse, added))
    log.write("valori noi create in dictionar: %d\n" % len(created))
    for fid, v in created[:40]:
        log.write("    filtru %s: '%s'\n" % (fid, v))
    log.write("\nvalori respinse de validare: %s\n" % respinse)

    if mode == 'pilot':
        for gid_s in gids:
            cur.execute("""SELECT ORDERNO, FLG_GROUP, FILTERNAME_ROM, PARAM_VALUE_ROM, PARAM_VALUE_RUS
                           FROM VW_TS_GOODS_DESCRIPTIONS WHERE GOODSID=? ORDER BY ORDERNO""", (int(gid_s),))
            log.write("\n=== %s prin VW_TS_GOODS_DESCRIPTIONS ===\n" % gid_s)
            for o, grp, nm, vro, vru in cur:
                log.write("  %-3s %s %-38s %-22s %s\n" % (o, 'G' if grp else ' ', (nm or '')[:38], (vro or '')[:22], vru or ''))
    log.close(); con.close()
    print('mode', mode, 'produse', produse, 'randuri', added, 'valori noi', len(created))

main()
