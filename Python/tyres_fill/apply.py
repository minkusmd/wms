"""Completeaza anvelopele (tip 479) de pe site fara imagini si fara caracteristici.

Pentru fiecare produs:
  - CODE curatat in formatul anvelopelor deja corecte ("195R14C L-MAX9 106/104R",
    "205/65R16 W636 99T XL"), CODE_RU = CODE;
  - sezonul in denumire: BASE_PARAM (Iarna/Vara/All Season) + BASE_PARAM_RU, iar
    TITLE = "Anvelopa <BRAND> <CODE>, <Sezon>";
  - caracteristicile (Latime, Inaltime profil, Diametru, Sezonietate, Indice sarcina,
    Indice viteza) in TS_GOODS_DESCRIPTIONS si TS_GOODS_FILTERS, cu valorile existente
    din TS_FILTER_PARAMS (create doar daca lipsesc, in acelasi format);
  - imaginile copiate in baza de la o anvelopa de acelasi brand + model (donor).

Utilizare:
  python apply.py            -> dry run: nu scrie nimic, doar tyres_dry.txt + tyres_plan_final.json
  python apply.py apply      -> backup local (tyres_backup_*.json + rollback_*.sql), apoi scriere
                                intr-o singura tranzactie
Parola: variabila de mediu FIREBIRD_PASSWORD (ca la serverul MCP).
"""
import datetime
import io
import json
import os
import re
import sys
from collections import Counter, defaultdict

import analyze

HERE = os.path.dirname(os.path.abspath(__file__))
USER_ID = 204

F_WIDTH, F_HEIGHT, F_DIAM, F_SEASON, F_LOAD, F_SPEED = 1247, 1259, 1249, 1252, 1258, 1256
SLOTS = [(F_WIDTH, 1), (F_HEIGHT, 2), (F_DIAM, 3), (F_SEASON, 4), (F_LOAD, 5), (F_SPEED, 6)]
SEASON_RU = {'Iarna': 'Зимняя', 'Vara': 'Летняя', 'All Season': 'Всесезонная'}

# sezonul confirmat de utilizator pentru modelele fara sezon in text (29.09.2026)
SEASON_OVERRIDES = {
    ('ROVELO', 'RWT768'): 'Iarna', ('ROVELO', 'RWS677'): 'Iarna',
    ('JOYROAD', 'RX826'): 'Iarna', ('JOYROAD', 'RX808'): 'Iarna', ('JOYROAD', 'RX821'): 'Iarna',
    ('HABILEAD', 'AW33'): 'Iarna', ('HABILEAD', 'RW501'): 'Iarna',
    ('LEAO', 'WDEFENDERUHP'): 'Iarna', ('APLUS', 'A502'): 'Iarna',
    ('ROADX', 'RXMOTIONDU71'): 'Vara', ('CONTINENTAL', 'CONTISPORTCONTAC7'): 'Vara',
    # restul anvelopelor: modele de vara cunoscute, fara sezon in text
    ('CONTINENTAL', 'CONTISPORTCONTACT7'): 'Vara',
    ('TOURADOR', 'XSPEEDTU2'): 'Vara', ('TOURADOR', 'XCOMFORTPLUS'): 'Vara',
}

SPEED_KMH = {'J': 100, 'K': 110, 'L': 120, 'M': 130, 'N': 140, 'P': 150, 'Q': 160, 'R': 170,
             'S': 180, 'T': 190, 'U': 200, 'H': 210, 'V': 240, 'W': 270, 'Y': 300}
# indicele de sarcina -> kg (tabel standard ETRTO)
LOAD_KG = dict(zip(range(60, 171), [
    250, 257, 265, 272, 280, 290, 300, 307, 315, 325, 335, 345, 355, 365, 375, 387, 400, 412, 425, 437,
    450, 462, 475, 487, 500, 515, 530, 545, 560, 580, 600, 615, 630, 650, 670, 690, 710, 730, 750, 775,
    800, 825, 850, 875, 900, 925, 950, 975, 1000, 1030, 1060, 1090, 1120, 1150, 1180, 1215, 1250, 1285,
    1320, 1360, 1400, 1450, 1500, 1550, 1600, 1650, 1700, 1750, 1800, 1850, 1900, 1950, 2000, 2060,
    2120, 2180, 2240, 2300, 2360, 2430, 2500, 2575, 2650, 2725, 2800, 2900, 3000, 3075, 3150, 3250,
    3350, 3450, 3550, 3650, 3750, 3875, 4000, 4125, 4250, 4375, 4500, 4625, 4750, 4875, 5000, 5150,
    5300, 5450, 5600, 5800, 6000]))


def fmt_speed(s):
    return ('%s (%d km/h)' % (s, SPEED_KMH[s]), '%s (%d км/ч)' % (s, SPEED_KMH[s])) if s in SPEED_KMH else (s, s)


def fmt_load(load):
    parts = [int(x) for x in load.split('/')]
    if any(p not in LOAD_KG for p in parts):
        return load, load
    kg = '/'.join(str(LOAD_KG[p]) for p in parts)
    # forma dominanta in baza e cu spatiu: "99 (775 kg)", "104/102 (900/850 kg)"
    return '%s (%s kg)' % (load, kg), '%s (%s кг)' % (load, kg)


# greseli de tipar din denumirile furnizorilor
MODEL_FIX = {'ContiSportContac 7': 'ContiSportContact 7'}


def new_code(t):
    size = ('LT' if t.get('lt') else '') + t['width'] + ('/' + t['height'] if t.get('height') else '')
    size += ('ZR' if t.get('zr') else 'R') + t['diam'][1:]
    model = (t.get('model') or '').strip()
    model = MODEL_FIX.get(model, model)
    return re.sub(r'\s+', ' ', '%s %s %s%s%s' % (size, model, t['load'], t['speed'], ' XL' if t.get('xl') else '')).strip()


class Params:
    """Valorile din TS_FILTER_PARAMS; creeaza lipsurile doar la aplicare."""

    def __init__(self, cur):
        self.cur, self.by_filter, self.created = cur, defaultdict(dict), []
        cur.execute('SELECT FILTERID, FILTERPARAMID, TRIM(PARAM_VALUE) FROM TS_FILTER_PARAMS WHERE FILTERID IN (%s)'
                    % ','.join(str(f) for f, _ in SLOTS))
        for fid, pid, val in cur.fetchall():
            self.by_filter[fid].setdefault((val or '').upper(), pid)

    def find(self, fid, predicate):
        for val, pid in self.by_filter[fid].items():
            if predicate(val):
                return pid
        return None

    def get(self, fid, val_ro, val_ru, match=None, write=False):
        pid = self.by_filter[fid].get(val_ro.upper()) or (self.find(fid, match) if match else None)
        if pid:
            return pid
        if not write:
            self.created.append((fid, val_ro))
            return -1
        self.cur.execute('SELECT NEXT VALUE FOR SQ_TS_FILTER_PARAMS_ID FROM RDB$DATABASE')
        pid = self.cur.fetchone()[0]
        self.cur.execute('INSERT INTO TS_FILTER_PARAMS (FILTERID, FILTERPARAMID, PARAM_VALUE, PARAM_VALUE_RUS, CREATED_BY) '
                         'VALUES (?, ?, ?, ?, ?)', (fid, pid, val_ro, val_ru, USER_ID))
        self.by_filter[fid][val_ro.upper()] = pid
        self.created.append((fid, val_ro))
        return pid


def values(t):
    """{filterid: (val_ro, val_ru, match)} pentru o anvelopa."""
    h = t.get('height') or '80'           # fara profil (195R14C) = 80 %
    load_ro, load_ru = fmt_load(t['load'])
    sp_ro, sp_ru = fmt_speed(t['speed'])
    # in baza exista si "111(1090 kg)" si "99 (775 kg)" - acceptam ambele
    load_rx = re.compile(r'^%s\s?\(' % re.escape(t['load']))
    return {
        F_WIDTH: (t['width'], t['width'], None),
        F_HEIGHT: (h + ' %', h + ' %', None),
        F_DIAM: (t['diam'], t['diam'], None),
        F_SEASON: (t['season'], SEASON_RU[t['season']], None),
        F_LOAD: (load_ro, load_ru, lambda v, rx=load_rx: bool(rx.match(v))),
        F_SPEED: (sp_ro, sp_ru, lambda v, s=t['speed'] + ' (': v.startswith(s)),
    }


def build_plan(cur, suffix=''):
    plan = json.load(io.open(os.path.join(HERE, 'tyres_plan%s.json' % suffix), encoding='utf-8'))
    out, skipped = [], []
    for t in plan:
        key = (analyze.norm_brand(t['vendor']), analyze.model_key(t.get('model')))
        if key in SEASON_OVERRIDES:
            t['season'], t['season_src'] = SEASON_OVERRIDES[key], 'confirmat'
        if not (t.get('width') and t.get('diam') and t.get('load') and t.get('speed')):
            skipped.append((t['goodsid'], 'fara dimensiune/indici in denumire', t['code']))
            continue
        if not t.get('season'):
            skipped.append((t['goodsid'], 'fara sezon', t['code']))
            continue
        t['new_code'] = new_code(t)
        t['new_title'] = 'Anvelopa %s %s, %s' % (t['vendor'].strip(), t['new_code'], t['season'])
        out.append(t)
    return out, skipped


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else 'dry'
    write = mode == 'apply'
    # "rest" = anvelopele cu imagini carora le lipsesc caracteristicile sau sezonul din denumire
    suffix = '_rest' if len(sys.argv) > 2 and sys.argv[2] == 'rest' else ''
    con = analyze.connect()
    cur = con.cursor()
    cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','%d') FROM RDB$DATABASE" % USER_ID)
    cur.fetchone()

    plan, skipped = build_plan(cur, suffix)
    params = Params(cur)
    stamp = datetime.datetime.now().strftime('%Y%m%d_%H%M%S') + suffix
    log = io.open(os.path.join(HERE, 'tyres_%s.txt' % ('apply_' + stamp if write else 'dry' + suffix)), 'w', encoding='utf-8')
    stats = Counter()

    if write:
        # backup local al valorilor vechi + script de revenire
        ids = [t['goodsid'] for t in plan]
        cur.execute('SELECT GOODSID, CODE, CODE_RU, BASE_PARAM, BASE_PARAM_RU, TITLE FROM TS_GOODS WHERE GOODSID IN (%s)'
                    % ','.join(map(str, ids)))
        old = [dict(zip(('goodsid', 'code', 'code_ru', 'base_param', 'base_param_ru', 'title'), r)) for r in cur.fetchall()]
        json.dump(old, io.open(os.path.join(HERE, 'tyres_backup_%s.json' % stamp), 'w', encoding='utf-8'),
                  ensure_ascii=False, indent=1)
        with io.open(os.path.join(HERE, 'rollback_%s.sql' % stamp), 'w', encoding='utf-8') as rb:
            rb.write("/* Revenire pentru anvelopele completate la %s. */\n" % stamp)
            q = lambda v: 'NULL' if v is None else "'" + str(v).replace("'", "''") + "'"
            for o in old:
                rb.write('UPDATE TS_GOODS SET CODE=%s, CODE_RU=%s, BASE_PARAM=%s, BASE_PARAM_RU=%s, TITLE=%s WHERE GOODSID=%d;\n'
                         % (q(o['code']), q(o['code_ru']), q(o['base_param']), q(o['base_param_ru']), q(o['title']), o['goodsid']))
            idl = ','.join(map(str, ids))
            # doar randurile create acum: unele produse aveau deja caracteristici
            since = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            rb.write("DELETE FROM TS_GOODS_DESCRIPTIONS WHERE GOODSID IN (%s) AND CREATED_DATE >= '%s';\n" % (idl, since))
            rb.write("DELETE FROM TS_GOODS_FILTERS WHERE GOODSID IN (%s) AND CREATED_DATE >= '%s';\n" % (idl, since))
            rb.write("DELETE FROM TS_GOODS_IMAGE WHERE GOODSID IN (%s) AND CREATED_DATE >= '%s';\n" % (idl, since))
            rb.write('COMMIT;\n')

    for t in plan:
        gid = t['goodsid']
        vals = values(t)
        log.write('%d  %s\n     -> CODE  %s\n     -> TITLE %s   [sezon: %s]\n'
                  % (gid, t['code'], t['new_code'], t['new_title'], t['season_src'] or 'text'))
        pids = {}
        for fid, orderno in SLOTS:
            vro, vru, match = vals[fid]
            pids[fid] = params.get(fid, vro, vru, match, write)
        log.write('     %s\n' % ' | '.join(vals[f][0] for f, _ in SLOTS))
        log.write('     imagini: %s\n' % ('de la %d' % t['donor'] if t.get('donor')
                                              else 'are deja' if t.get('has_images') else 'lipsa (faza B)'))
        stats['produse'] += 1
        stats['cu_donor'] += bool(t.get('donor'))

        if not write:
            continue
        cur.execute('UPDATE TS_GOODS SET CODE=?, CODE_RU=?, BASE_PARAM=?, BASE_PARAM_RU=?, TITLE=? WHERE GOODSID=?',
                    (t['new_code'], t['new_code'], t['season'], SEASON_RU[t['season']], t['new_title'], gid))
        cur.execute('SELECT FILTERID FROM TS_GOODS_DESCRIPTIONS WHERE GOODSID=?', (gid,))
        have_d = {r[0] for r in cur.fetchall()}
        cur.execute('SELECT FILTERID FROM TS_GOODS_FILTERS WHERE GOODSID=?', (gid,))
        have_f = {r[0] for r in cur.fetchall()}
        for fid, orderno in SLOTS:
            if fid not in have_d:
                cur.execute('INSERT INTO TS_GOODS_DESCRIPTIONS (GOODSID, FLG_GROUP, FILTERID, FILTERPARAMID, FLAGS, ORDERNO) '
                            'VALUES (?, 0, ?, ?, 1, ?)', (gid, fid, pids[fid], orderno))
                stats['descrieri'] += 1
            if fid not in have_f:
                cur.execute('INSERT INTO TS_GOODS_FILTERS (GOODSID, FILTERID, FILTERPARAMID, ORDERNO, FLAGS, CREATEDBY, CREATED_DATE) '
                            'VALUES (?, ?, ?, 0, 1, ?, CURRENT_TIMESTAMP)', (gid, fid, pids[fid], USER_ID))
                stats['filtre'] += 1
        if t.get('donor'):
            cur.execute('SELECT COUNT(*) FROM TS_GOODS_IMAGE WHERE GOODSID=?', (gid,))
            if not cur.fetchone()[0]:
                cur.execute('SELECT GOODS_IMAGE_ID FROM TS_GOODS_IMAGE WHERE GOODSID=? ORDER BY ORDERNO, GOODS_IMAGE_ID',
                            (t['donor'],))
                for (iid,) in cur.fetchall():
                    cur.execute('INSERT INTO TS_GOODS_IMAGE (GOODSID, IMAGE) '
                                'SELECT ?, IMAGE FROM TS_GOODS_IMAGE WHERE GOODSID=? AND GOODS_IMAGE_ID=?',
                                (gid, t['donor'], iid))
                    stats['imagini'] += 1

    if write:
        con.commit()
    log.write('\n=== sarite ===\n')
    for s in skipped:
        log.write('%s  %s  | %s\n' % s)
    log.write('\n=== valori noi in TS_FILTER_PARAMS ===\n')
    for fid, v in sorted(set(params.created)):
        log.write('%d  %s\n' % (fid, v))
    log.write('\n%s\n' % json.dumps(stats))
    log.close()
    json.dump(plan, io.open(os.path.join(HERE, 'tyres_plan_final%s.json' % suffix), 'w', encoding='utf-8'),
              ensure_ascii=False, indent=1)
    con.close()
    print(mode, json.dumps(stats), 'sarite:', len(skipped), 'valori noi:', len(set(params.created)))


if __name__ == '__main__':
    main()
