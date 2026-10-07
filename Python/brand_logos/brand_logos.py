# -*- coding: utf-8 -*-
"""
Logo-uri pentru producatori: TS_SYSS (PARENTID = 1) -> TS_BRANDS_IMAGE (BRANDID, IMAGE).

Pentru fiecare brand (implicit: doar cele fara logo si cu produse in TS_GOODS.VENDOR_ID,
in ordinea numarului de produse) se cauta logo-ul in surse, in ordine:
  1. wikidata - proprietatea P154 (logo image); imaginea vine din Wikimedia Commons ca PNG (si
                SVG-urile sint randate de server). Candidati: elementele cu exact acelasi nume si
                cele al caror nume incepe cu numele brandului ("Panasonic Holdings Corporation").
                Acceptat direct daca domeniul din TS_SYSS.VALUE_STR e si site-ul oficial (P856).
                Altfel: fara site contradictoriu, nume de cel putin 4 caractere, descrierea arata
                o firma/brand de produse (nu formatie, media, club...), iar la numele partial
                site-ul oficial trebuie sa contina numele brandului.
  2. site     - pagina principala din TS_SYSS.VALUE_STR: logo din JSON-LD (Organization.logo),
                apoi <img> marcate "logo" (preferate cele din header). Iconitele de aplicatie
                (favicon, apple-touch-icon) nu se folosesc - nu sint logo-ul brandului.
                SVG-urile se randeaza cu resvg-py (pip install resvg-py) sau cairosvg.

Brandurile din exclude.txt (de linga script, ex. branduri proprii fara logo) si denumirile
generice (OEM, NoName...) se sar.

Imaginea gasita: marginile goale (transparente sau de culoarea colturilor) se taie, logo-ul se
scaleaza proportional si se centreaza pe un patrat transparent 300x300 -> PNG.

Implicit baza NU se modifica: PNG-urile se salveaza in --out (<BRANDID>.png) impreuna cu
report.csv si index.html (planse pentru verificare vizuala). Dupa verificare se sterg din folder
logo-urile gresite si se scriu restul cu --apply.

Conexiunea: FIREBIRD_DSN (implicit 192.168.106.254/3050:SW), FIREBIRD_USER (implicit SYSDBA),
FIREBIRD_PASSWORD (obligatoriu).

Exemple:
  python brand_logos.py --limit 50            # proba pe primele 50 de branduri -> out\\index.html
  python brand_logos.py                       # toate brandurile fara logo, cu produse
  python brand_logos.py --ids 1208,1101       # doar brandurile date
  python brand_logos.py --apply out           # scrie in TS_BRANDS_IMAGE PNG-urile ramase in out\\
  python brand_logos.py --write               # cauta si scrie direct (fara verificare)
  optiuni: --overwrite (inlocuieste logo-urile existente), --all (si brandurile fara produse),
           --threads 8, --sources wikidata,site, --out DIR
"""
import argparse
import csv
import html
import io
import json
import os
import re
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from urllib.parse import quote, urljoin, urlparse

import firebird.driver as fb
import requests
from bs4 import BeautifulSoup
from PIL import Image, ImageChops

import urllib3

# optional - doar pentru logo-urile SVG de pe site-uri (pip install resvg-py)
try:
    import resvg_py
except ImportError:
    resvg_py = None
try:
    import cairosvg
except ImportError:
    cairosvg = None

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

SIZE = 300          # patratul final
MARGIN = 12         # spatiu liber in jurul logo-ului
MIN_SIDE = 40       # logo-ul decupat trebuie sa aiba cel putin atit pe latura mare
MAX_DOWNLOAD = 15 * 1024 * 1024

UA_BROWSER = ('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
              '(KHTML, like Gecko) Chrome/124.0 Safari/537.36')
UA_WIKI = 'WMS-BrandLogos/1.0 (https://fantastic.md) python-requests'
WD_API = 'https://www.wikidata.org/w/api.php'

# denumiri care nu sint branduri reale
GENERIC = {'oem', 'noname', 'nonamed', 'farabrand', 'generic', 'none', 'null', 'other',
           'others', 'diverse', 'altele', 'nobrand', 'unknown'}
# imagini din pagina care contin "logo" dar nu sint logo-ul brandului
NOT_BRAND_RE = re.compile(r'partner|client|payment|visa|master|paypal|award|certif|app-?store|'
                          r'google-?play|facebook|instagram|youtube|twitter|telegram|viber|'
                          r'whatsapp|tiktok|linkedin|flag|banner', re.I)

_tls = threading.local()
_wiki_lock = threading.Lock()
_wiki_last = [0.0]


def log_print(*a):
    print(*a, flush=True)


# ------------------------------------------------------------------------------------------
# utilitare
# ------------------------------------------------------------------------------------------

def norm(s):
    return ''.join(ch for ch in (s or '').casefold() if ch.isalnum())


def clean_title(s):
    return re.sub(r'\s+', ' ', (s or '')).strip()


def site_root(value):
    v = (value or '').strip()
    if not v:
        return None
    if not re.match(r'^https?://', v, re.I):
        v = 'http://' + v
    p = urlparse(v)
    if not p.netloc or '.' not in p.netloc:
        return None
    return '%s://%s/' % (p.scheme.lower(), p.netloc.lower())


def base_name(url):
    """ 'http://www.thermaltakerussia.ru/' -> 'thermaltakerussia' """
    if not url:
        return ''
    if not re.match(r'^https?://', url, re.I):
        url = 'http://' + url
    host = urlparse(url).netloc.lower().split(':')[0]
    parts = [p for p in host.split('.') if p and p != 'www']
    if len(parts) >= 2:
        return parts[-2]
    return parts[0] if parts else ''


def session():
    s = getattr(_tls, 'session', None)
    if s is None:
        s = requests.Session()
        s.headers['User-Agent'] = UA_BROWSER
        _tls.session = s
    return s


def http_get(url, **kw):
    kw.setdefault('timeout', 20)
    host = urlparse(url).netloc
    if 'wikimedia.org' in host or 'wikidata.org' in host:
        # Wikimedia: User-Agent descriptiv si cel mult ~5 cereri/s din toate firele
        headers = dict(kw.pop('headers', {}) or {})
        headers['User-Agent'] = UA_WIKI
        kw['headers'] = headers
        with _wiki_lock:
            wait = 0.2 - (time.monotonic() - _wiki_last[0])
            if wait > 0:
                time.sleep(wait)
            _wiki_last[0] = time.monotonic()
        return session().get(url, **kw)
    try:
        return session().get(url, **kw)
    except requests.exceptions.SSLError:
        # site-uri cu certificat expirat / lant incomplet - pentru o imagine publica e acceptabil
        return session().get(url, verify=False, **kw)


# ------------------------------------------------------------------------------------------
# surse
# ------------------------------------------------------------------------------------------

def wd_api(params):
    params = dict(params, format='json')
    r = http_get(WD_API, params=params)
    r.raise_for_status()
    return r.json()


def claim_values(claims, prop):
    out = []
    for c in claims.get(prop, []):
        if c.get('rank') == 'deprecated':
            continue
        v = c.get('mainsnak', {}).get('datavalue', {}).get('value')
        if v:
            out.append((c.get('rank') == 'preferred', v))
    out.sort(key=lambda x: not x[0])
    return [v for _, v in out]


def host_labels(url):
    """ 'https://www.makita.co.jp/' -> ['makita', 'co', 'jp'] """
    if not url:
        return []
    if not re.match(r'^https?://', url, re.I):
        url = 'http://' + url
    host = urlparse(url).netloc.lower().split(':')[0]
    return [p for p in host.split('.') if p and p != 'www']


def domain_matches(key, wd_urls):
    """ vreun domeniu din wd_urls contine key (ex. 'makita' in makita.co.jp, 'canon' in global.canon) """
    key = norm(key)
    if len(key) < 3:
        return False
    for u in wd_urls:
        for label in host_labels(u):
            lab = norm(label)
            if len(lab) >= 3 and (key == lab or key in lab or (len(lab) >= 4 and lab in key)):
                return True
    return False


# descrierea Wikidata trebuie sa arate o firma / un brand de produse; cuvintele din NOT_PRODUCT_RE
# o exclud ("HELMET" -> formatia Helmet, "GENIUS" -> compania media Genius)
BUSINESS_RE = re.compile(r'compan|corporat|manufactur|brand|maker|producer|enterprise|business|'
                         r'multinational|conglomerate|retailer|firm|supplier|vendor|'
                         r'industr|holding|publisher', re.I)
NOT_PRODUCT_RE = re.compile(r'\bband\b|music|record label|\bmedia\b|film|television|\btv\b|'
                            r'broadcast|football|soccer|\bclub\b|\bteam\b|\bbank\b|airline|'
                            r'university|school|newspaper|magazine|website|political|church|'
                            r'video game|album|\bsong\b|singer|restaurant|hotel|radio|'
                            r'cycling|racing', re.I)


def wikidata_candidates(brand, log):
    name = brand['title']
    key = norm(name)
    if len(key) < 2:
        return []
    res = wd_api({'action': 'wbsearchentities', 'search': name, 'language': 'en',
                  'uselang': 'en', 'type': 'item', 'limit': 10})
    exact, prefix = [], []
    low = name.casefold()
    for x in res.get('search', []):
        text = x.get('match', {}).get('text', '')
        if norm(text) == key:
            exact.append(x['id'])
        elif text.casefold().startswith(low + ' '):
            # "Panasonic Holdings Corporation", "Transcend Information"
            prefix.append(x['id'])
    ids = exact + [q for q in prefix if q not in exact]
    if not ids:
        log.append('wikidata: niciun element cu acest nume')
        return []

    ents = wd_api({'action': 'wbgetentities', 'ids': '|'.join(ids), 'props': 'claims|descriptions',
                   'languages': 'en'}).get('entities', {})
    for qid in ids:
        ent = ents.get(qid, {})
        claims = ent.get('claims', {})
        logos = claim_values(claims, 'P154')
        if not logos:
            continue
        wd_urls = claim_values(claims, 'P856')
        descr = ent.get('descriptions', {}).get('en', {}).get('value', '')
        # formatii, media, cluburi... - respinse chiar si cu site "confirmat" (geniusnet.com vs genius.com)
        if NOT_PRODUCT_RE.search(descr):
            log.append('wikidata %s: nu e brand de produse (%s)' % (qid, descr[:60]))
            continue
        # confirmare puternica: domeniul din TS_SYSS.VALUE_STR e si site-ul oficial din Wikidata
        if not domain_matches(base_name(brand['site']), wd_urls):
            if brand['site'] and wd_urls:
                log.append('wikidata %s: alt site (%s)' % (qid, ', '.join(wd_urls[:2])))
                continue
            if len(key) < 4:
                log.append('wikidata %s: nume scurt, site neconfirmat' % qid)
                continue
            if qid not in exact and not domain_matches(key, wd_urls):
                log.append('wikidata %s: nume partial, numele nu e in site-ul oficial' % qid)
                continue
            if not BUSINESS_RE.search(descr) or NOT_PRODUCT_RE.search(descr):
                log.append('wikidata %s: nu e brand de produse (%s)' % (qid, descr[:60]))
                continue
        url = ('https://commons.wikimedia.org/wiki/Special:FilePath/%s?width=600'
               % quote(logos[0].replace(' ', '_')))
        return [(url, 'wikidata %s' % qid)]
    log.append('wikidata: fara logo potrivit')
    return []


def iter_ld_logos(data):
    if isinstance(data, list):
        for x in data:
            yield from iter_ld_logos(x)
    elif isinstance(data, dict):
        for k, v in data.items():
            if k == 'logo':
                if isinstance(v, str):
                    yield v
                elif isinstance(v, dict):
                    u = v.get('url') or v.get('contentUrl')
                    if isinstance(u, str):
                        yield u
            else:
                yield from iter_ld_logos(v)


def site_candidates(brand, log):
    root = site_root(brand['site'])
    if not root:
        return []
    r = http_get(root, allow_redirects=True)
    if r.status_code != 200:
        log.append('site %s: HTTP %d' % (root, r.status_code))
        return []
    soup = BeautifulSoup(r.content, 'lxml')
    base = r.url
    key = norm(brand['title'])
    cands = []

    for sc in soup.find_all('script', type='application/ld+json'):
        try:
            data = json.loads(sc.string or '')
        except ValueError:
            continue
        for u in iter_ld_logos(data):
            cands.append((100, urljoin(base, u), 'site json-ld', True))

    for idx, img in enumerate(soup.find_all('img')):
        src = (img.get('src') or img.get('data-src') or img.get('data-lazy-src') or '').strip()
        if not src or src.startswith('data:'):
            continue
        own = ' '.join([src, img.get('alt', ''), ' '.join(img.get('class', [])), img.get('id', '')])
        around = own
        for p in list(img.parents)[:3]:
            if getattr(p, 'attrs', None):
                around += ' ' + ' '.join(p.get('class', [])) + ' ' + (p.get('id') or '')
        if 'logo' not in around.lower():
            continue
        score = 50 - idx * 0.01
        if 'logo' in src.lower():
            score += 10
        named = bool(key) and key in norm(img.get('alt', '') + ' ' + src)
        if named:
            score += 15
        if img.find_parent(['header', 'nav']):
            score += 10
        if img.find_parent('footer'):
            score -= 30
        if NOT_BRAND_RE.search(own):
            score -= 40
        if score > 0:
            cands.append((score, urljoin(base, src), 'site img', named))

    # dintre <img> se incearca doar cel mai bine clasat, plus cele care poarta numele brandului
    # (altfel, la respingerea lui, ar urma logo-urile altor produse din pagina)
    cands.sort(key=lambda c: -c[0])
    seen, out, first_img = set(), [], True
    for _, u, how, named in cands:
        if u in seen:
            continue
        if how == 'site img':
            if not (first_img or named):
                continue
            first_img = False
        seen.add(u)
        out.append((u, how))
    if not out:
        log.append('site %s: niciun logo in pagina' % root)
    return out[:6]


SOURCES = {'wikidata': wikidata_candidates, 'site': site_candidates}


# ------------------------------------------------------------------------------------------
# imaginea
# ------------------------------------------------------------------------------------------

def render_svg(data):
    if resvg_py is not None:
        return bytes(resvg_py.svg_to_bytes(svg_string=data.decode('utf-8', 'replace'), width=900))
    if cairosvg is not None:
        return cairosvg.svg2png(bytestring=data, output_width=900)
    raise ValueError('SVG (instalati resvg-py: pip install resvg-py)')


def fetch_image(url):
    r = http_get(url, headers={'Accept': 'image/*,*/*;q=0.8'}, allow_redirects=True)
    if r.status_code != 200:
        raise ValueError('HTTP %d' % r.status_code)
    data = r.content
    if len(data) > MAX_DOWNLOAD:
        raise ValueError('fisier prea mare')
    ctype = r.headers.get('Content-Type', '').lower()
    head = data[:300].lstrip().lower()
    if 'svg' in ctype or head.startswith(b'<svg') or (head.startswith(b'<?xml') and b'<svg' in data[:2000]):
        data = render_svg(data)
    im = Image.open(io.BytesIO(data))
    im.load()
    return im


def make_logo(im):
    """ decupeaza marginile goale si centreaza pe un patrat transparent SIZE x SIZE -> PNG """
    if getattr(im, 'n_frames', 1) > 1:
        im.seek(0)
    im = im.convert('RGBA')
    alpha = im.getchannel('A')
    if alpha.getextrema()[0] < 250:
        bbox = alpha.point(lambda a: 255 if a > 10 else 0).getbbox()
    else:
        bg = Image.new('RGBA', im.size, im.getpixel((0, 0)))
        bbox = ImageChops.difference(im, bg).convert('L').point(lambda v: 255 if v > 24 else 0).getbbox()
    if not bbox:
        raise ValueError('imagine goala')
    im = im.crop(bbox)
    w, h = im.size
    if max(w, h) < MIN_SIDE:
        raise ValueError('prea mica (%dx%d)' % (w, h))
    if max(w, h) / max(1, min(w, h)) > 15:
        raise ValueError('proportii nepotrivite (%dx%d)' % (w, h))
    # logo-urile monocrome pe transparent sint valide - se compara si canalul alfa
    if all(lo == hi for lo, hi in im.getextrema()):
        raise ValueError('imagine de o singura culoare')
    # logo alb (pentru antete intunecate): pus pe alb, cum il arata site-ul, trebuie sa ramina
    # vizibil aproape in intregime - altfel (ex. text alb + iconita colorata) se respinge.
    # Logo-urile pe fundal alb opac trec: fundalul dispare, dar zona cu desen ramine aceeasi.
    on_white = Image.new('RGBA', im.size, (255, 255, 255, 255))
    on_white.alpha_composite(im)
    ink = ImageChops.difference(on_white.convert('RGB'), Image.new('RGB', im.size, 'white'))
    vb = ink.convert('L').point(lambda v: 255 if v > 40 else 0).getbbox()
    if not vb or (vb[2] - vb[0]) * (vb[3] - vb[1]) < 0.5 * w * h:
        raise ValueError('logo alb (nu se vede pe fundal alb)')

    box = SIZE - 2 * MARGIN
    scale = min(box / w, box / h)
    nw, nh = max(1, round(w * scale)), max(1, round(h * scale))
    im = im.resize((nw, nh), Image.LANCZOS)
    canvas = Image.new('RGBA', (SIZE, SIZE), (255, 255, 255, 0))
    canvas.alpha_composite(im, dest=((SIZE - nw) // 2, (SIZE - nh) // 2))
    out = io.BytesIO()
    canvas.save(out, 'PNG', optimize=True)
    return out.getvalue(), (w, h)


def find_logo(brand, sources):
    """ ruleaza in firele de lucru - doar retea si imagini, fara acces la baza """
    log = []
    for name in sources:
        try:
            cands = SOURCES[name](brand, log)
        except Exception as e:  # noqa: BLE001 - o sursa cazuta nu opreste brandul
            log.append('%s: %s' % (name, e))
            continue
        for url, how in cands:
            try:
                png, orig = make_logo(fetch_image(url))
                return {'brand': brand, 'status': 'gasit', 'source': how, 'url': url,
                        'png': png, 'orig': '%dx%d' % orig, 'log': log}
            except Exception as e:  # noqa: BLE001
                log.append('%s %s: %s' % (how, url, e))
    return {'brand': brand, 'status': 'negasit', 'source': '', 'url': '', 'png': None,
            'orig': '', 'log': log}


# ------------------------------------------------------------------------------------------
# baza
# ------------------------------------------------------------------------------------------

def db_connect():
    pwd = os.environ.get('FIREBIRD_PASSWORD')
    if not pwd:
        sys.exit('Setati variabila de mediu FIREBIRD_PASSWORD (parola bazei SW).')
    return fb.connect(os.environ.get('FIREBIRD_DSN', '192.168.106.254/3050:SW'),
                      user=os.environ.get('FIREBIRD_USER', 'SYSDBA'), password=pwd, charset='UTF8')


def load_exclude():
    """ exclude.txt de linga script: branduri pentru care nu se cauta logo (ex. branduri proprii) """
    path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'exclude.txt')
    out = set()
    if os.path.exists(path):
        with io.open(path, encoding='utf-8') as f:
            for line in f:
                line = line.split('#', 1)[0].strip()
                if line.isdigit():
                    out.add(int(line))
    return out


def load_brands(con, args):
    cur = con.cursor()
    cur.execute('SELECT BRANDID FROM TS_BRANDS_IMAGE')
    with_logo = {r[0] for r in cur.fetchall()}
    cur.execute("""
        SELECT S.SYSSID, S.TITLE, S.VALUE_STR, COUNT(G.GOODSID)
        FROM TS_SYSS S
        LEFT JOIN TS_GOODS G ON G.VENDOR_ID = S.SYSSID
        WHERE S.PARENTID = 1
        GROUP BY S.SYSSID, S.TITLE, S.VALUE_STR""")
    ids = {int(x) for x in args.ids.split(',') if x.strip()} if args.ids else None
    excluded = load_exclude()
    brands, skipped = [], 0
    for sid, title, site, goods in cur.fetchall():
        b = {'id': sid, 'title': clean_title(title), 'site': (site or '').strip(),
             'goods': goods, 'has_logo': sid in with_logo}
        if ids is not None:
            if sid in ids:
                brands.append(b)
            continue
        if sid in excluded:
            skipped += 1
            continue
        if b['has_logo'] and not args.overwrite:
            continue
        if not args.all and goods == 0:
            continue
        if norm(b['title']) in GENERIC or len(norm(b['title'])) < 2:
            skipped += 1
            continue
        brands.append(b)
    brands.sort(key=lambda b: -b['goods'])
    if args.limit:
        brands = brands[:args.limit]
    return brands, skipped


def save_logo(cur, brand_id, png, overwrite):
    """ intoarce True daca s-a scris """
    cur.execute('SELECT COUNT(*) FROM TS_BRANDS_IMAGE WHERE BRANDID = ?', (brand_id,))
    exists = cur.fetchone()[0] > 0
    if exists and not overwrite:
        return False
    if exists:
        cur.execute('UPDATE TS_BRANDS_IMAGE SET IMAGE = ? WHERE BRANDID = ?', (png, brand_id))
    else:
        cur.execute('INSERT INTO TS_BRANDS_IMAGE (BRANDID, IMAGE) VALUES (?, ?)', (brand_id, png))
    return True


# ------------------------------------------------------------------------------------------
# rapoarte
# ------------------------------------------------------------------------------------------

def write_reports(out_dir, results):
    with io.open(os.path.join(out_dir, 'report.csv'), 'w', encoding='utf-8-sig', newline='') as f:
        w = csv.writer(f, delimiter=';')
        w.writerow(['BRANDID', 'TITLE', 'GOODS', 'SITE', 'STATUS', 'SOURCE', 'URL', 'ORIGINAL', 'LOG'])
        for r in results:
            b = r['brand']
            w.writerow([b['id'], b['title'], b['goods'], b['site'], r['status'], r['source'],
                        r['url'], r['orig'], ' | '.join(r['log'])])

    found = [r for r in results if r['png']]
    missing = [r for r in results if not r['png']]
    cards = []
    for r in found:
        b = r['brand']
        cards.append(
            '<div class="c"><img src="%d.png"><b>%s</b><span>#%d &middot; %d produse</span>'
            '<span>%s</span><a href="%s" target="_blank">sursa</a></div>'
            % (b['id'], html.escape(b['title']), b['id'], b['goods'], html.escape(r['source']),
               html.escape(r['url'])))
    rows = ''.join('<li>#%d %s (%d produse) - %s</li>'
                   % (r['brand']['id'], html.escape(r['brand']['title']), r['brand']['goods'],
                      html.escape(' | '.join(r['log'][-2:])))
                   for r in missing)
    page = ('<!doctype html><meta charset="utf-8"><title>Logo branduri</title><style>'
            'body{font:13px sans-serif;margin:16px}'
            '.g{display:flex;flex-wrap:wrap;gap:10px}'
            '.c{width:170px;border:1px solid #ccc;padding:6px;display:flex;flex-direction:column;gap:2px}'
            '.c img{width:150px;height:150px;align-self:center;background:'
            'repeating-conic-gradient(#eee 0 25%%,#fff 0 50%%) 0 0/16px 16px}'
            '.c span{color:#666;font-size:11px}</style>'
            '<h2>Gasite: %d, negasite: %d</h2>'
            '<p>Fundalul in carouri arata transparenta. Stergeti din folder PNG-urile gresite, apoi '
            '<code>python brand_logos.py --apply &lt;folder&gt;</code>.</p>'
            '<div class="g">%s</div><h3>Negasite</h3><ul>%s</ul>'
            % (len(found), len(missing), ''.join(cards), rows))
    with io.open(os.path.join(out_dir, 'index.html'), 'w', encoding='utf-8') as f:
        f.write(page)


# ------------------------------------------------------------------------------------------
# moduri de lucru
# ------------------------------------------------------------------------------------------

def run_apply(args):
    folder = args.apply
    files = sorted(f for f in os.listdir(folder) if re.match(r'^\d+\.png$', f, re.I))
    if not files:
        sys.exit('Niciun fisier <BRANDID>.png in %s' % folder)
    con = db_connect()
    cur = con.cursor()
    cur.execute('SELECT SYSSID FROM TS_SYSS WHERE PARENTID = 1')
    brand_ids = {r[0] for r in cur.fetchall()}
    written = skipped = 0
    for f in files:
        bid = int(f[:-4])
        path = os.path.join(folder, f)
        with Image.open(path) as im:
            ok = im.format == 'PNG' and im.size == (SIZE, SIZE)
        if bid not in brand_ids or not ok:
            log_print('sarit %s: %s' % (f, 'nu e brand (TS_SYSS PARENTID=1)' if bid not in brand_ids
                                        else 'nu e PNG %dx%d' % (SIZE, SIZE)))
            skipped += 1
            continue
        with open(path, 'rb') as fh:
            png = fh.read()
        if save_logo(cur, bid, png, args.overwrite):
            written += 1
        else:
            skipped += 1
            log_print('sarit %s: brandul are deja logo (--overwrite pentru inlocuire)' % f)
    con.commit()
    con.close()
    log_print('Scrise in TS_BRANDS_IMAGE: %d, sarite: %d' % (written, skipped))


def run_search(args):
    sources = [s.strip() for s in args.sources.split(',') if s.strip()]
    for s in sources:
        if s not in SOURCES:
            sys.exit('Sursa necunoscuta: %s (disponibile: %s)' % (s, ', '.join(SOURCES)))
    out_dir = os.path.abspath(args.out)
    os.makedirs(out_dir, exist_ok=True)

    con = db_connect()
    brands, generic = load_brands(con, args)
    log_print('Branduri de procesat: %d (sarite - generice sau din exclude.txt: %d), fire: %d, surse: %s%s'
              % (len(brands), generic, args.threads, ','.join(sources),
                 '' if (resvg_py or cairosvg) else ' (SVG de pe site-uri: nu - pip install resvg-py)'))
    if not brands:
        con.close()
        return

    cur = con.cursor() if args.write else None
    results, written, done = [], 0, 0
    try:
        with ThreadPoolExecutor(max_workers=args.threads) as pool:
            futures = [pool.submit(find_logo, b, sources) for b in brands]
            for fut in as_completed(futures):
                r = fut.result()
                results.append(r)
                done += 1
                b = r['brand']
                if r['png']:
                    with open(os.path.join(out_dir, '%d.png' % b['id']), 'wb') as fh:
                        fh.write(r['png'])
                    if cur is not None and save_logo(cur, b['id'], r['png'], args.overwrite):
                        written += 1
                        if written % 20 == 0:
                            con.commit()
                log_print('[%d/%d] #%d %s: %s %s' % (done, len(brands), b['id'], b['title'],
                                                    r['status'], r['source']))
        if cur is not None:
            con.commit()
    finally:
        con.close()
        results.sort(key=lambda r: -r['brand']['goods'])
        write_reports(out_dir, results)

    found = sum(1 for r in results if r['png'])
    log_print('Gasite: %d din %d. Rezultate: %s' % (found, len(results), os.path.join(out_dir, 'index.html')))
    if args.write:
        log_print('Scrise in TS_BRANDS_IMAGE: %d' % written)
    else:
        log_print('Baza nu a fost modificata. Dupa verificare: python brand_logos.py --apply "%s"' % out_dir)


def main():
    if hasattr(sys.stdout, 'reconfigure'):
        sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    ap = argparse.ArgumentParser(description='Logo-uri branduri (TS_SYSS PARENTID=1) -> TS_BRANDS_IMAGE')
    ap.add_argument('--out', default=os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out'),
                    help='folderul pentru PNG-uri si rapoarte')
    ap.add_argument('--ids', help='doar aceste BRANDID, separate prin virgula')
    ap.add_argument('--limit', type=int, default=0, help='primele N branduri (dupa numarul de produse)')
    ap.add_argument('--all', action='store_true', help='si brandurile fara produse')
    ap.add_argument('--overwrite', action='store_true', help='inlocuieste logo-urile existente')
    ap.add_argument('--threads', type=int, default=8)
    ap.add_argument('--sources', default='wikidata,site', help='ordinea surselor: wikidata,site')
    ap.add_argument('--write', action='store_true', help='scrie direct in TS_BRANDS_IMAGE')
    ap.add_argument('--apply', metavar='FOLDER', help='scrie in baza PNG-urile <BRANDID>.png din folder')
    args = ap.parse_args()
    if args.apply:
        run_apply(args)
    else:
        run_search(args)


if __name__ == '__main__':
    main()
