"""Caracteristicile de filtru la anvelopele din mapa 415725 (TS_GOODS.PARENTID) aflate in stoc la
furnizor (FLG_IN_PRICE = bitul 3 din TS_GOODS_FOREIGN.FLAGS) carora le lipseste macar una din:
  1247 Latime, 1259 Inaltime profil, 1249 Diametru, 1252 Sezonietate, 1258 Indice sarcina,
  1256 Indice viteza
in TS_GOODS_DESCRIPTIONS (FLG_GROUP 0) sau in TS_GOODS_FILTERS.

Sursele valorilor, in ordine:
  1. randul deja existent in cealalta tabela (descriere fara filtru sau invers) - se copiaza
     acelasi FILTERPARAMID;
  2. catalogul AgroPiese (TS_GOODS_FOREIGN.GOODS_CODE = sku, furnizorul 14805), din cel mai nou
     %TEMP%\\WMS_Api\\agropiese_products_*.json (fetch_agropiese.py): proprietatile 7 Latime,
     5 Inaltime, 10 Sezon, 507 Diametrul discului, 16 Index incarcare, 15 Index viteza;
  3. denumirea produsului (TS_GOODS.CODE, apoi TS_GOODS_FOREIGN.GOODS_TITLE) prin analyze.parse.
Formatul valorilor e cel din TS_FILTER_PARAMS (apply.py): "225", "55 %", "R16C", "Iarna",
"99 (775 kg)", "H (210 km/h)"; valorile lipsa din dictionar se creeaza la aplicare.
Inaltimea lipsa se pune "80 %" doar la anvelopele metrice fara profil (195R14C); la cele
agricole (12-16.5) se sare. Nu se modifica CODE/TITLE/BASE_PARAM.

Utilizare:
  python fill_in_price.py          -> dry run: fill_dry.txt + fill_plan.json, nu scrie nimic
  python fill_in_price.py apply    -> scrie intr-o singura tranzactie; fill_apply_<stamp>.txt
                                      + rollback_fill_<stamp>.sql (DELETE exact pe randurile create)
Parola bazei: FIREBIRD_PASSWORD (ca la serverul MCP).
"""
import datetime
import glob
import io
import json
import os
import re
import sys
from collections import Counter

import analyze
from apply import F_WIDTH, F_HEIGHT, F_DIAM, F_SEASON, F_LOAD, F_SPEED, SLOTS, SEASON_RU, USER_ID, SPEED_KMH, Params, fmt_load, fmt_speed

HERE = os.path.dirname(os.path.abspath(__file__))
PARENT_ID = 415725
AGRO_ID = 14805
FILTER_IDS = [f for f, _ in SLOTS]
# anvelopa metrica fara profil: "195 R14C", "195R14C" -> inaltimea conventionala 80 %
NO_PROFILE_RE = re.compile(r'(?<![\d/.,])\d{3}\s*R\s*-?\s*\d{2}(?:[.,]\d)?\s*C?\b(?![/\d])', re.I)
SEASON_MAP = {'IARNA': 'Iarna', 'VARA': 'Vara', 'ALL SEASON': 'All Season', 'ALLSEASON': 'All Season'}


def load_agro():
    """sku -> {param_id: (ro, ru)} din toate cataloagele descarcate; cel mai nou are prioritate,
    cele vechi completeaza produsele iesite intre timp din catalog."""
    files = sorted(glob.glob(os.path.join(os.environ.get('TEMP', '.'), 'WMS_Api', 'agropiese_products_*.json')), reverse=True)
    by_sku = {}
    for fn in files:
        for d in json.load(io.open(fn, encoding='utf-8-sig')):
            sku = (d.get('sku') or '').strip()
            if sku and sku not in by_sku:
                by_sku[sku] = {p.get('param_id'): ((p.get('value_ro') or '').strip(), (p.get('value_ru') or '').strip())
                               for p in d.get('properties') or []}
    return by_sku, ', '.join(os.path.basename(f) for f in files)


def num(s):
    """'19,5' -> '19.5', '120.0' -> '120', '14.00' -> '14', '10.50' -> '10.5'."""
    s = (s or '').strip().replace(',', '.')
    if re.fullmatch(r'\d+\.\d+', s):
        s = s.rstrip('0').rstrip('.')
    return s


# dimensiune flotation "31X10.50 R15" (X latin sau Х chirilic, ca in denumirile AgroPiese): 31 = diametrul exterior, 10.50 = latimea in inch;
# nu intra in filtrele Latime / Inaltime (conventia produselor deja completate, ex. 287195)
FLOTATION_RE = re.compile(r'\b\d{2}\s*[xXхХ]\s*\d{1,2}(?:[.,]\d{1,2})?\s*R', re.I)


def fmt_speed_multi(sp):
    """'H' -> 'H (210 km/h)'; 'K/L' -> 'K/L (110/120 km/h)' (ca 'H/T (210/190 km/h)' din baza)."""
    parts = sp.split('/')
    if len(parts) > 1 and all(p in SPEED_KMH for p in parts):
        kmh = '/'.join(str(SPEED_KMH[p]) for p in parts)
        return '%s (%s km/h)' % (sp, kmh), '%s (%s км/ч)' % (sp, kmh)
    return fmt_speed(sp)


def from_agro(props):
    """{filterid: (val_ro, val_ru, match)} din proprietatile AgroPiese; doar ce exista."""
    out = {}
    if props.get('7') and props['7'][0]:
        w = num(props['7'][0])
        out[F_WIDTH] = (w, w, None)
    if props.get('5') and props['5'][0]:
        h = num(props['5'][0])
        out[F_HEIGHT] = (h + ' %', h + ' %', None)
    if props.get('507') and props['507'][0]:
        d = 'R' + num(props['507'][0]).upper()
        out[F_DIAM] = (d, d, None)
    if props.get('10') and props['10'][0]:
        s = SEASON_MAP.get(props['10'][0].strip().upper())
        if s:
            out[F_SEASON] = (s, SEASON_RU[s], None)
    if props.get('16') and props['16'][0]:
        load = num(props['16'][0])
        if re.fullmatch(r'\d{2,3}(/\d{2,3})?', load):
            ro, ru = fmt_load(load)
            out[F_LOAD] = (ro, ru, lambda v, rx=re.compile(r'^%s\s?\(' % re.escape(load)): bool(rx.match(v)))
    if props.get('15') and props['15'][0]:
        sp = props['15'][0].strip().upper()
        ro, ru = fmt_speed_multi(sp)
        out[F_SPEED] = (ro, ru, (lambda v, s=sp + ' (': v.startswith(s)) if ro != sp else None)
    return out


def from_name(code, vendor):
    p = analyze.parse(code, vendor)
    out = {}
    if p.get('width') and p.get('diam'):
        out[F_WIDTH] = (p['width'], p['width'], None)
        out[F_DIAM] = (p['diam'], p['diam'], None)
        if p.get('height'):
            out[F_HEIGHT] = (p['height'] + ' %', p['height'] + ' %', None)
    if p.get('load') and p.get('speed'):
        ro, ru = fmt_load(p['load'])
        out[F_LOAD] = (ro, ru, lambda v, rx=re.compile(r'^%s\s?\(' % re.escape(p['load'])): bool(rx.match(v)))
        ro, ru = fmt_speed(p['speed'])
        out[F_SPEED] = (ro, ru, lambda v, s=p['speed'] + ' (': v.startswith(s))
    if p.get('season'):
        out[F_SEASON] = (p['season'], SEASON_RU[p['season']], None)
    return out


def main():
    write = len(sys.argv) > 1 and sys.argv[1] == 'apply'
    agro, agro_file = load_agro()
    con = analyze.connect()
    cur = con.cursor()
    cur.execute("SELECT RDB$SET_CONTEXT('USER_SESSION','UserID','%d') FROM RDB$DATABASE" % USER_ID)
    cur.fetchone()
    fl = ','.join(map(str, FILTER_IDS))
    cur.execute("""
        SELECT g.GOODSID, TRIM(s.TITLE), g.CODE
        FROM TS_GOODS g LEFT JOIN TS_SYSS s ON s.SYSSID = g.VENDOR_ID
        WHERE g.PARENTID = ?
          AND EXISTS (SELECT 1 FROM TS_GOODS_FOREIGN f WHERE f.GOODSID = g.GOODSID AND GET_FLG_VALUE(f.FLAGS, 3) = 1)
          AND ((SELECT COUNT(DISTINCT x.FILTERID) FROM TS_GOODS_DESCRIPTIONS x
                WHERE x.GOODSID = g.GOODSID AND COALESCE(x.FLG_GROUP, 0) = 0 AND x.FILTERID IN (%s)) < 6
            OR (SELECT COUNT(DISTINCT y.FILTERID) FROM TS_GOODS_FILTERS y
                WHERE y.GOODSID = g.GOODSID AND y.FILTERID IN (%s)) < 6)
        ORDER BY g.GOODSID""" % (fl, fl), [PARENT_ID])
    targets = cur.fetchall()
    ids = [t[0] for t in targets]

    def by_goods(sql, cols):
        res = {}
        for i in range(0, len(ids), 400):
            cur.execute(sql % ','.join(map(str, ids[i:i + 400])))
            for r in cur.fetchall():
                res.setdefault(r[0], []).append(r[1:cols])
        return res
    have_d = by_goods('SELECT GOODSID, FILTERID, FILTERPARAMID FROM TS_GOODS_DESCRIPTIONS '
                      'WHERE GOODSID IN (%s) AND COALESCE(FLG_GROUP, 0) = 0 AND FILTERID IN (' + fl + ')', 3)
    have_f = by_goods('SELECT GOODSID, FILTERID, FILTERPARAMID FROM TS_GOODS_FILTERS WHERE GOODSID IN (%s) AND FILTERID IN (' + fl + ')', 3)
    foreign = by_goods('SELECT GOODSID, CUSTOMERID, TRIM(GOODS_CODE), GOODS_TITLE FROM TS_GOODS_FOREIGN '
                       'WHERE GOODSID IN (%s) AND GET_FLG_VALUE(FLAGS, 3) = 1', 4)
    params = Params(cur)

    stamp = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
    log = io.open(os.path.join(HERE, 'fill_apply_%s.txt' % stamp if write else 'fill_dry.txt'), 'w', encoding='utf-8')
    log.write('catalog AgroPiese: %s (%d sku)\nproduse tinta: %d\n\n' % (agro_file, len(agro), len(targets)))
    stats, plan, rollback, src = Counter(), [], [], Counter()
    for gid, vendor, code in targets:
        d = {f: pid for f, pid in have_d.get(gid, [])}
        fset = {f: pid for f, pid in have_f.get(gid, [])}
        rows = foreign.get(gid, [])
        agro_props = next((agro[sku] for cid, sku, _ in rows if cid == AGRO_ID and sku in agro), None)
        agro_vals = from_agro(agro_props) if agro_props else {}
        vals = dict(agro_vals)
        for text in [code] + [t for _, _, t in rows if t]:
            if len(vals) >= 6:
                break
            for f, v in from_name(text, vendor).items():
                vals.setdefault(f, v)
        if F_HEIGHT not in vals and F_WIDTH in vals and NO_PROFILE_RE.search(code or ''):
            vals[F_HEIGHT] = ('80 %', '80 %', None)
        if FLOTATION_RE.search(code or ''):
            vals.pop(F_WIDTH, None)
            vals.pop(F_HEIGHT, None)
        entry = {'goodsid': gid, 'code': code, 'agro': bool(agro_props), 'desc': [], 'filt': [], 'missing': []}
        for f, orderno in SLOTS:
            need_d, need_f = f not in d, f not in fset
            if not (need_d or need_f):
                continue
            pid = d.get(f) or fset.get(f)
            copied = bool(pid)
            if pid:
                src['copiat'] += 1
            elif f in vals:
                ro, ru, match = vals[f]
                pid = params.get(f, ro, ru, match, write)
                src['agro' if f in agro_vals else 'nume'] += 1
            else:
                entry['missing'].append(f)
                stats['lipsa_' + str(f)] += 1
                continue
            label = '(copiat %s)' % pid if copied else vals[f][0]
            if need_d:
                entry['desc'].append((f, pid, orderno, label))
            if need_f:
                entry['filt'].append((f, pid, label))
        plan.append(entry)
        stats['produse'] += 1
        stats['cu_agro'] += bool(agro_props)
        stats['descrieri'] += len(entry['desc'])
        stats['filtre'] += len(entry['filt'])
        stats['complet'] += not entry['missing']
        log.write('%d  %s  [%s]\n' % (gid, code, 'agro' if agro_props else 'nume'))
        log.write('     descrieri: %s\n' % ', '.join('%d=%s' % (f, l) for f, _, _, l in entry['desc']))
        log.write('     filtre:    %s\n' % ', '.join('%d=%s' % (f, l) for f, _, l in entry['filt']))
        if entry['missing']:
            log.write('     LIPSA: %s\n' % entry['missing'])

        if not write:
            continue
        for f, pid, orderno, _ in entry['desc']:
            cur.execute('INSERT INTO TS_GOODS_DESCRIPTIONS (GOODSID, FLG_GROUP, FILTERID, FILTERPARAMID, FLAGS, ORDERNO, CREATED_BY) '
                        'VALUES (?, 0, ?, ?, 1, ?, ?)', (gid, f, pid, orderno, USER_ID))
            rollback.append('DELETE FROM TS_GOODS_DESCRIPTIONS WHERE GOODSID=%d AND FILTERID=%d AND COALESCE(FLG_GROUP,0)=0;' % (gid, f))
        for f, pid, _ in entry['filt']:
            cur.execute('INSERT INTO TS_GOODS_FILTERS (GOODSID, FILTERID, FILTERPARAMID, ORDERNO, FLAGS, CREATEDBY, CREATED_DATE) '
                        'VALUES (?, ?, ?, 0, 1, ?, CURRENT_TIMESTAMP)', (gid, f, pid, USER_ID))
            rollback.append('DELETE FROM TS_GOODS_FILTERS WHERE GOODSID=%d AND FILTERID=%d;' % (gid, f))

    created = sorted(set(params.created))
    if write:
        for fid, val in created:
            pid = params.by_filter[fid].get(val.upper())
            if pid and pid > 0:
                rollback.append("DELETE FROM TS_FILTER_PARAMS WHERE FILTERID=%d AND FILTERPARAMID=%d;" % (fid, pid))
        with io.open(os.path.join(HERE, 'rollback_fill_%s.sql' % stamp), 'w', encoding='utf-8') as rb:
            rb.write('/* Revenire pentru caracteristicile adaugate la %s (fill_in_price.py). */\n' % stamp)
            rb.write('\n'.join(rollback) + '\nCOMMIT;\n')
        con.commit()
    log.write('\n=== valori noi in TS_FILTER_PARAMS ===\n')
    for fid, v in created:
        log.write('%d  %s\n' % (fid, v))
    log.write('\n=== surse valori ===\n%s\n' % json.dumps(dict(src)))
    log.write('\n%s\n' % json.dumps(dict(stats)))
    log.close()
    json.dump(plan, io.open(os.path.join(HERE, 'fill_plan.json'), 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    con.close()
    print('apply' if write else 'dry', json.dumps(dict(stats)), 'valori noi:', len(created))


if __name__ == '__main__':
    main()
