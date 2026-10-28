"""Imaginile si caracteristicile anvelopelor NATVEX-COM (furnizorul 26743) de pe autoplanet.md.

Lansat din WMS (frame78, butonul de descarcare a caracteristicilor si imaginilor -
bbGoodsPropertiesDownloadClick, NatvexContentUnit) prin Python4Delphi (uPythonRunner); se poate
rula si din linia de comanda:
    python autoplanet_site.py <input.json>

input.json:
    {"items": [{"code": "3485", "name": "Anvelope OTANI 185/65R15 (88H WE1000) iarna",
                "need_image": true}, ...],
     "out": "<rezultat.json>", "images_dir": "<folder>", "stop_file": "<fisier>",
     "cache_file": "<lista site-ului>", "interval": 5, "image_interval": 1.5, "offline": false}

Rezultatul (rescris pe parcurs, ca oprirea sa pastreze ce s-a gasit):
    {"site_products": 1500, "blocked": false, "stopped": false, "finished": true,
     "items": {"3485": {"parsed": {"brand": "OTANI", "model": "WE1000", "width": "185",
                                   "height": "65", "diam": "R15", "load": "88", "speed": "H",
                                   "season": "Iarna"},
                        "match": {"title": "OTANI WE1000 185/65R15 88H", "url": "...",
                                  "image_url": "...", "score": 1.0},
                        "image_file": "<folder>/OTANIWE1000.jpg"}}}

Fapte despre site (25 oct 2026, Joomla + VirtueMart, UTF-8, server lent ~6 s/pagina):
  - codul Natvex (GOODS_CODE) NU exista pe site: cautarea dupa "4804" nu gaseste nimic, iar dupa
    "3485" gaseste alt produs -> potrivirea se face dupa denumire: site "OTANI WE1000 185/65R15 88H"
    = Natvex "Anvelope OTANI 185/65R15 (88H WE1000) iarna" (marca, dimensiunea, indicii, modelul);
  - listele de categorii /catalog/shiny/<categorie>?limit=100&start=N au titlul, link-ul si
    imaginea principala (/images/stories/virtuemart/product/<MODEL>.jpg, una pe model) - nu e nevoie
    de paginile produselor; paginile produselor nu au descriere, doar campurile tehnice (aceleasi
    date ca denumirea Natvex);
  - lista se pastreaza in cache_file 24 de ore - o rulare repetata nu mai incarca site-ul.
Sezonul vine din denumire: iarna -> Iarna, vara -> Vara, a/s si m+s -> All Season (conventia
produselor Natvex deja completate). Doar biblioteca standard (Python-ul pe 32 de biti al WMS).
"""
import html
import io
import json
import os
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

BASE = 'https://autoplanet.md'
UA = ('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/124.0 Safari/537.36')
CATEGORIES = ['legkovye', 'legko-gruzovye', 'gruzovye-shiny', 'industriale', 'agricole', 'atv', 'avtosport']
CACHE_HOURS = 24
SEASONS = {'iarna': 'Iarna', 'vara': 'Vara', 'a/s': 'All Season', 'm+s': 'All Season'}

# "Anvelope FIREMAX 215/50R18 (96V FM806) iarna", "Anvelope OZKA 11.2-20 (280/85-20) (113/A6 KNK50 TL 8PR) a/s"
NAME_RE = re.compile(r'^Anvelope\s+(?P<brand>.+?)\s+(?P<size>\d\S*)(?:\s+\(\d[^()]*\))?\s+\((?P<inside>.*)\)\s*(?P<season>\S+)\s*$')
# 215/50R18, 215/65R16C, 385/65R22.5, 26.5R25, 550/60-22.5, 13.00-24, 11.2-20, 9.5L-15
SIZE_RE = re.compile(r'^(?P<w>\d{1,3}(?:[.,]\d{1,2})?)L?(?:/(?P<h>\d{2,3}(?:[.,]\d)?))?(?P<sep>Z?R|-)'
                     r'(?P<d>\d{1,2}(?:[.,]\d)?)(?P<c>C)?$', re.I)
# flotation 26x10-14, 31x15.5-15: diametrul exterior x latimea (inch) - fara Latime / Inaltime
FLOT_RE = re.compile(r'^\d{2}(?:[.,]\d+)?[xX]\d{1,2}(?:[.,]\d{1,2})?(?:R|-)(?P<d>\d{1,2}(?:[.,]\d)?)$')
# 96V, 109/107R, 164/158K/L, 173/176D/A8, 114/114A8/B, 184/D, 113/A6, 51F
IDX_RE = re.compile(r'^(?P<load>\d{2,3}(?:/\d{2,3})?)/?(?P<speed>[A-Z]\d?(?:/[A-Z]\d?)?)$')
# in titlul de pe site: dimensiunea si indicii
SITE_SIZE_RE = re.compile(r'(?<![\w.])(\d{1,3}(?:[.,]\d{1,2})?L?(?:/\d{2,3}(?:[.,]\d)?)?(?:Z?R|-)\d{1,2}(?:[.,]\d)?C?'
                          r'|\d{2}(?:[.,]\d+)?[xX]\d{1,2}(?:[.,]\d{1,2})?(?:R|-)\d{1,2}(?:[.,]\d)?)(?![\w.])', re.I)
SITE_IDX_RE = re.compile(r'(?<![\w/])(\d{2,3}(?:/\d{2,3})?/?[A-Z]\d?(?:/[A-Z]\d?)?)(?![\w/])')
ITEM_RE = re.compile(r'<a title="[^"]*"\s+href="(?P<url>/catalog/shiny/[^"]+-detail)">\s*<img src="(?P<img>[^"]+)"'
                     r'.*?<h2><a href="[^"]+" >(?P<title>[^<]+)</a></h2>', re.S)


class Blocked(Exception):
    pass


class Stopped(Exception):
    pass


def norm(s):
    return re.sub(r'[^0-9A-Z]', '', (s or '').upper())


def parse_name(name):
    """Valorile caracteristicilor din denumirea Natvex; None = nu e anvelopa."""
    m = NAME_RE.match((name or '').strip())
    if not m:
        return None
    out = {'brand': m.group('brand').strip(), 'model': '', 'width': '', 'height': '', 'diam': '',
           'load': '', 'speed': '', 'season': SEASONS.get(m.group('season').lower(), ''),
           'size': m.group('size')}
    s, f = SIZE_RE.match(m.group('size')), FLOT_RE.match(m.group('size'))
    if s:
        out['width'] = s.group('w').replace(',', '.')
        out['height'] = (s.group('h') or '').replace(',', '.')
        out['diam'] = 'R' + s.group('d').replace(',', '.') + (s.group('c') or '').upper()
    elif f:
        out['diam'] = 'R' + f.group('d').replace(',', '.')
    toks = m.group('inside').split()
    if toks and IDX_RE.match(toks[0]):
        i = IDX_RE.match(toks[0])
        out['load'], out['speed'] = i.group('load'), i.group('speed')
        toks = toks[1:]
    out['model'] = ' '.join(toks)
    return out


class Site:
    def __init__(self, interval, stop_file):
        self.interval = interval
        self.stop_file = stop_file
        self.next_time = 0.0
        self.requests = 0

    def check_stop(self):
        if self.stop_file and os.path.exists(self.stop_file):
            raise Stopped()

    def get(self, url, interval=None):
        """interval: pauza dupa cererea asta (imaginile statice - mai scurta decit paginile PHP)."""
        pause = self.interval if interval is None else interval
        for attempt in range(1, 4):
            self.check_stop()
            wait = self.next_time - time.time()
            while wait > 0:
                time.sleep(min(wait, 0.5))
                self.check_stop()
                wait = self.next_time - time.time()
            self.requests += 1
            try:
                req = urllib.request.Request(url, headers={'User-Agent': UA})
                with urllib.request.urlopen(req, timeout=60) as r:
                    data = r.read()
                self.next_time = time.time() + pause
                return data
            except urllib.error.HTTPError as e:
                self.next_time = time.time() + pause
                if e.code == 404:
                    return b''
                if e.code in (403, 429):
                    raise Blocked()
                if e.code in (502, 503, 504):
                    time.sleep(10 * attempt)
                    continue
                raise
            except urllib.error.URLError:
                self.next_time = time.time() + pause
                time.sleep(10 * attempt)
        raise Exception('3 incercari esuate la %s' % url)


def parse_list(page, category):
    """Produsele dintr-o pagina de lista / de rezultate ale cautarii."""
    out = []
    for m in ITEM_RE.finditer(page):
        img = m.group('img')
        if not img.lower().startswith('http'):
            img = BASE + '/' + img.lstrip('/')
        # miniatura "resized/..._100x100.jpg" -> imaginea mare
        img = re.sub(r'/resized/([^/]+?)(?:_\d+x\d+)?(\.\w+)$', r'/\1\2', img)
        out.append({'title': html.unescape(m.group('title')).strip(), 'url': BASE + m.group('url'),
                    'image_url': img, 'category': category})
    return out


def crawl(site, log):
    """Toate anvelopele din listele de categorii: [{"title", "url", "image_url", "category"}]."""
    products, seen = [], set()
    for cat in CATEGORIES:
        start, pages = 0, 0
        while True:
            url = '%s/catalog/shiny/%s?limit=100&start=%d' % (BASE, cat, start)
            page = site.get(url).decode('utf-8', 'replace')
            pages += 1
            found = 0
            for p in parse_list(page, cat):
                if p['url'] in seen:
                    continue
                seen.add(p['url'])
                products.append(p)
                found += 1
            # link-urile de paginare: "?limit=100&amp;start=99" (pas 99)
            starts = [int(x) for x in re.findall(r'[?&;]start=(\d+)', page)]
            log('%s: pagina %d, %d produse (total %d)' % (cat, pages, found, len(products)))
            nxt = [s for s in starts if s > start]
            if not found or not nxt:
                break
            start = min(nxt)
    return products


def site_key(title):
    """(dimensiune, indici, cuvintele ramase) din titlul de pe site."""
    t = title.upper()
    m = SITE_SIZE_RE.search(t)
    size = norm(m.group(1)) if m else ''
    rest = t[:m.start()] + ' ' + t[m.end():] if m else t
    i = SITE_IDX_RE.search(rest)
    idx = norm(i.group(1)) if i else ''
    if i:
        rest = rest[:i.start()] + ' ' + rest[i.end():]
    return size, idx, set(w for w in re.split(r'[^0-9A-Z]+', rest) if w)


def match_items(items, products):
    """Potrivirea dupa dimensiune + indici, apoi marca + cuvintele modelului."""
    by_size = {}
    for p in products:
        size, idx, words = site_key(p['title'])
        if size:
            by_size.setdefault(size, []).append((idx, words, p))
    out = {}
    for it in items:
        parsed = it['parsed']
        if not parsed:
            continue
        brand_words = [w for w in re.split(r'[^0-9A-Z]+', parsed['brand'].upper()) if w]
        model_words = [w for w in re.split(r'[^0-9A-Z]+', parsed['model'].upper()) if w and not re.fullmatch(r'\d+PR|TL|TT|XL', w)]
        idx = norm(parsed['load'] + parsed['speed'])
        best, best_score = None, 0.0
        for s_idx, words, p in by_size.get(norm(parsed['size']), []):
            if not brand_words or brand_words[0] not in words:
                continue
            if idx and s_idx and idx != s_idx:
                continue
            # toate cuvintele modelului trebuie sa fie in titlu: potrivirile partiale au fost gresite
            # ("Explero HT" -> "Explero winter", "4Seasons3" -> "SummerS", "SH110" -> "RH100")
            if any(w not in words for w in model_words):
                continue
            score = 1.0 if model_words else 0.5
            if idx and s_idx == idx:
                score += 0.5
            if score > best_score:
                best, best_score = p, score
        if best and best_score >= 1.0:
            out[it['code']] = dict(best, score=round(best_score, 2))
    return out


def search_keyword(parsed):
    """Cuvintul cel mai distinctiv al modelului (cu cifre, cel mai lung) pentru cautarea pe site."""
    words = [w for w in re.split(r'[^0-9A-Za-z-]+', parsed['model']) if len(w) >= 3
             and not re.fullmatch(r'\d+PR|TL|TT|XL|Steer|Drive|Trailer|mixed', w, re.I)]
    if not words:
        return ''
    with_digits = [w for w in words if re.search(r'\d', w) and re.search(r'[A-Za-z]', w)]
    return max(with_digits or words, key=len)[:20]


def search_missing(site, items, matches, log):
    """Listele de categorii sar produse (paginarea VirtueMart fara ordine stabila: 235/60R17
    Ice Guard G075 exista, dar nu apare in nicio pagina) - pentru anvelopele nepotrivite se cauta
    pe site dupa cuvintul modelului, o cerere pe cuvint. Intoarce produsele gasite."""
    keys = {}
    for it in items:
        if it['parsed'] and it['code'] not in matches:
            k = search_keyword(it['parsed'])
            if k:
                keys.setdefault(k.upper(), k)
    found = []
    for n, k in enumerate(sorted(keys.values(), key=str.upper), 1):
        url = '%s/2017-04-08-13-49-05/cameras/search?%s' % (BASE, urllib.parse.urlencode(
            {'keyword': k, 'limitstart': 0, 'option': 'com_virtuemart', 'view': 'category'}))
        page = site.get(url).decode('utf-8', 'replace')
        got = parse_list(page, 'cautare')
        found.extend(got)
        log('cautare %d/%d "%s": %d produse' % (n, len(keys), k, len(got)))
    return found


def save_json(path, data):
    tmp = path + '.tmp'
    with io.open(tmp, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=0)
    os.replace(tmp, path)


def main(argv):
    if len(argv) < 2:
        print('Utilizare: autoplanet_site.py <input.json>')
        return
    cfg = json.load(io.open(argv[1], encoding='utf-8-sig'))
    items = [dict(it, parsed=parse_name(it.get('name'))) for it in cfg['items']]
    out_path, images_dir, cache_file = cfg['out'], cfg['images_dir'], cfg.get('cache_file')
    os.makedirs(images_dir, exist_ok=True)
    site = Site(float(cfg.get('interval', 5)), cfg.get('stop_file'))
    # imaginile sint fisiere statice (/images/stories/...) - nu trec prin PHP-ul lent al site-ului
    image_interval = float(cfg.get('image_interval', 1.5))
    result = {'site_products': 0, 'blocked': False, 'stopped': False, 'finished': False,
              'items': {it['code']: {'parsed': it['parsed']} for it in items}}
    save_json(out_path, result)
    t0 = time.time()
    print('autoplanet.md: %d articole, %d recunoscute ca anvelope' % (len(items), sum(1 for it in items if it['parsed'])))
    try:
        if cfg.get('offline'):
            print('Fara site: doar caracteristicile din denumire.')
        else:
            products = None
            if cache_file and os.path.exists(cache_file) and time.time() - os.path.getmtime(cache_file) < CACHE_HOURS * 3600:
                products = json.load(io.open(cache_file, encoding='utf-8'))
                print('Lista site-ului din cache (%d produse, %s)' % (
                    len(products), time.strftime('%d.%m %H:%M', time.localtime(os.path.getmtime(cache_file)))))
            if not products:
                print('Se citeste lista anvelopelor de pe site (o cerere la %.0f s)...' % site.interval)
                products = crawl(site, print)
                if cache_file and products:
                    save_json(cache_file, products)
                    if os.path.exists(cache_file + '.searched'):
                        os.remove(cache_file + '.searched')
            matches = match_items(items, products)
            print('Potrivite din liste: %d' % len(matches))
            # completarea prin cautare (o singura data pe zi: rezultatele intra in cache)
            searched = os.path.exists(cache_file + '.searched') if cache_file else False
            if not searched and any(it['parsed'] and it['code'] not in matches for it in items):
                known = set(p['url'] for p in products)
                extra = [p for p in search_missing(site, items, matches, print) if p['url'] not in known]
                extra = list({p['url']: p for p in extra}.values())
                products.extend(extra)
                if cache_file:
                    save_json(cache_file, products)
                    open(cache_file + '.searched', 'w').close()
                print('Cautarea a adaugat %d produse' % len(extra))
                matches = match_items(items, products)
            result['site_products'] = len(products)
            for code, m in matches.items():
                result['items'][code]['match'] = m
            save_json(out_path, result)
            print('Potrivite: %d din %d' % (len(matches), len(items)))

            # imaginile: una pe URL (acelasi model -> acelasi fisier)
            need = [it for it in items if it.get('need_image') and it['code'] in matches]
            files = {}
            for n, it in enumerate(need, 1):
                img_url = matches[it['code']]['image_url']
                if img_url not in files:
                    data = site.get(img_url, image_interval)
                    fn = ''
                    if data:
                        fn = os.path.join(images_dir, re.sub(r'[^\w.-]', '_', urllib.parse.unquote(img_url.rsplit('/', 1)[-1])))
                        with open(fn, 'wb') as f:
                            f.write(data)
                    files[img_url] = fn
                    print('imagine %d/%d: %s %s' % (n, len(need), img_url.rsplit('/', 1)[-1], 'ok' if fn else 'LIPSA'))
                result['items'][it['code']]['image_file'] = files[img_url]
                if n % 20 == 0:
                    save_json(out_path, result)
    except Blocked:
        result['blocked'] = True
        print('BLOCAT: autoplanet.md refuza cererile (403/429) - oprit. Reluati mai tirziu.')
    except Stopped:
        result['stopped'] = True
        print('Oprit de utilizator.')
    result['finished'] = True
    save_json(out_path, result)
    print('GATA: cereri %d, %d s' % (site.requests, round(time.time() - t0)))


main(sys.argv)
