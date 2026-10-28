"""Sezonul si imaginea anvelopelor TRIS (furnizorul 8606) de pe trisauto.md.

Lansat din WMS (frame78, butonul "Imagini si descrieri -> produse", TrisContentUnit) prin
Python4Delphi (uPythonRunner); se poate rula si din linia de comanda:
    python tris_site.py <input.json>

input.json:
    {"items": [{"code": "33728", "need_image": true}, ...],
     "out": "<rezultat.json>", "images_dir": "<folder>", "stop_file": "<fisier>",
     "interval": 1.5}

Rezultatul (rescris dupa fiecare articol, ca oprirea sa pastreze ce s-a gasit):
    {"done": 12, "total": 344, "blocked": false, "finished": true,
     "items": {"33728": {"found": true, "url": "...", "model": "...", "season": "Vara",
                         "image_url": "...", "image_file": "<folder>/sailun_elite.jpg"}}}

Fapte despre site (25 oct 2026):
  - tris.md redirectioneaza pe trisauto.md; cautarea /podbor?search_type=searchbar&searchword=<cod>
    gaseste exact articolul (codul Tris = atributul article al produsului);
  - pagina produsului: <ngcart-addtocart article= image= data=> + tabelul "Caracteristici"
    (Sezonalitatea: "de vara" / "de iarna" / "toate sezoanele"); <base href="/">;
  - sezonul si imaginea sint ale modelului -> o singura pagina si o singura imagine pe model;
  - gazduirea (FOXCLOUD) blocheaza IP-ul la rafale de cereri (503 "Access forbidden" pe tot
    site-ul). Scriptul NU ocoleste blocajul: o cerere la `interval` secunde, iar la pagina de
    blocare se opreste si raporteaza "blocked".
Doar biblioteca standard (Python-ul pe 32 de biti al WMS nu are pachete instalate).
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

BASE = 'https://trisauto.md'
UA = ('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/124.0 Safari/537.36')
LINK_RE = re.compile(r'href="(https://trisauto\.md/catalog/tyres/[^"/]+/[^"/]+/\d+)"')


class Blocked(Exception):
    pass


class Stopped(Exception):
    pass


class Site:
    def __init__(self, interval, stop_file):
        self.interval = interval
        self.stop_file = stop_file
        self.next_time = 0.0
        self.requests = 0

    def check_stop(self):
        if self.stop_file and os.path.exists(self.stop_file):
            raise Stopped()

    def get(self, url):
        """200 -> octetii; 404 -> b''; pagina de blocare -> Blocked; 503 simplu -> 3 incercari."""
        for attempt in range(1, 4):
            self.check_stop()
            wait = self.next_time - time.time()
            while wait > 0:
                time.sleep(min(wait, 0.5))
                self.check_stop()
                wait = self.next_time - time.time()
            self.next_time = time.time() + self.interval
            self.requests += 1
            try:
                req = urllib.request.Request(url, headers={'User-Agent': UA})
                with urllib.request.urlopen(req, timeout=30) as r:
                    return r.read()
            except urllib.error.HTTPError as e:
                if e.code == 404:
                    return b''
                body = e.read().decode('utf-8', 'replace')
                if e.code in (429, 502, 503, 504):
                    if 'FOXCLOUD' in body and 'Access forbidden' in body:
                        raise Blocked()
                    time.sleep(5 * attempt)
                    continue
                raise
        raise Exception('HTTP: 3 incercari esuate la %s' % url)


def season_value(text):
    s = (text or '').lower()
    if 'toate' in s or 'all' in s:
        return 'All Season'
    if 'iarn' in s or 'winter' in s:
        return 'Iarna'
    if 'var' in s or 'summer' in s:
        return 'Vara'
    return ''


def parse_product(page):
    """article / size / image_url / season din pagina produsului; None daca nu e pagina de produs."""
    m = re.search(r'<ngcart-addtocart\b[^>]*>', page, re.S | re.I)
    if not m:
        return None
    tag = m.group(0)

    def attr(name):
        a = re.search(r'\s' + name + r'="([^"]*)"', tag)
        return html.unescape(a.group(1)).strip() if a else ''

    info = {'article': attr('article'), 'size': attr('data'), 'season': '', 'image_url': ''}
    image = attr('image')
    if not image:
        a = re.search(r'<a href="(uploaded/[^"]+)" class="imgLightbox', page)
        image = a.group(1) if a else ''
    if image:
        info['image_url'] = image if image.lower().startswith('http') else BASE + '/' + image.lstrip('/')
    p = page.find('<h2>Caracteristici</h2>')
    if p >= 0:
        table = page[p:]
        table = table[:table.find('</table>') + 1]
        for name, value in re.findall(r'<td>(.*?)</td>\s*<td>(.*?)</td>', table, re.S | re.I):
            if re.sub(r'<[^>]*>', '', name).strip().lower().startswith('sezon'):
                info['season'] = season_value(html.unescape(re.sub(r'<[^>]*>', '', value)))
    if not info['season']:
        a = re.search(r'class="season-([a-z]+)', page)
        if a:
            info['season'] = season_value(a.group(1))
    return info


def model_url(link):
    return re.sub(r'/\d+$', '', link)


def image_name(murl, image_url):
    ext = os.path.splitext(urllib.parse.urlparse(image_url).path)[1].lower() or '.jpg'
    slug = re.sub(r'[^a-z0-9]+', '_', murl.split('/catalog/tyres/', 1)[-1].lower()).strip('_')
    return slug + ext


def save_json(path, data):
    tmp = path + '.tmp'
    with io.open(tmp, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=0)
    os.replace(tmp, path)


def main(argv):
    if len(argv) < 2:
        print('Utilizare: tris_site.py <input.json>')
        return
    cfg = json.load(io.open(argv[1], encoding='utf-8-sig'))
    items = cfg['items']
    out_path = cfg['out']
    images_dir = cfg['images_dir']
    os.makedirs(images_dir, exist_ok=True)
    site = Site(float(cfg.get('interval', 1.5)), cfg.get('stop_file'))
    result = {'done': 0, 'total': len(items), 'blocked': False, 'stopped': False, 'finished': False, 'items': {}}
    models = {}   # pagina modelului -> {"season", "image_url", "image_file"}
    t0 = time.time()
    print('trisauto.md: %d articole, o cerere la %.1f s' % (len(items), site.interval))
    try:
        for n, item in enumerate(items, 1):
            code = str(item['code']).strip()
            res = {'found': False}
            try:
                page = site.get(BASE + '/podbor?' + urllib.parse.urlencode(
                    {'search_type': 'searchbar', 'searchword': code})).decode('utf-8', 'replace')
                links = sorted(set(LINK_RE.findall(page)))
                for link in links:
                    murl = model_url(link)
                    # un singur rezultat al cautarii dupa cod = articolul; modelul citit nu se mai descarca
                    if murl in models and len(links) == 1:
                        res.update(found=True, url=link, model=murl)
                        break
                    info = parse_product(site.get(link).decode('utf-8', 'replace'))
                    if not info:
                        continue
                    if murl not in models:
                        models[murl] = {'season': info['season'], 'image_url': info['image_url'], 'image_file': ''}
                    if info['article'] == code:
                        res.update(found=True, url=link, model=murl)
                        break
                if res['found']:
                    model = models[res['model']]
                    res['season'] = model['season']
                    res['image_url'] = model['image_url']
                    if item.get('need_image') and model['image_url']:
                        if not model['image_file']:
                            data = site.get(model['image_url'])
                            if data:
                                fn = os.path.join(images_dir, image_name(res['model'], model['image_url']))
                                with open(fn, 'wb') as f:
                                    f.write(data)
                                model['image_file'] = fn
                        res['image_file'] = model['image_file']
                    print('%d/%d %s: %s, sezon %s%s' % (n, len(items), code, res['model'].rsplit('/', 2)[-2] + '/' +
                          res['model'].rsplit('/', 1)[-1], res['season'] or '?',
                          ', imagine' if res.get('image_file') else ''))
                else:
                    print('%d/%d %s: nu a fost gasit pe site' % (n, len(items), code))
            except (Blocked, Stopped):
                raise
            except Exception as e:  # o eroare la un articol nu opreste restul
                res['error'] = str(e)
                print('%d/%d %s: EROARE %s' % (n, len(items), code, e))
            result['items'][code] = res
            result['done'] = n
            save_json(out_path, result)
    except Blocked:
        result['blocked'] = True
        print('BLOCAT: trisauto.md a blocat accesul (503 Access forbidden) dupa %d cereri - oprit. '
              'Reluati mai tirziu.' % site.requests)
    except Stopped:
        result['stopped'] = True
        print('Oprit de utilizator.')
    result['finished'] = True
    save_json(out_path, result)
    found = sum(1 for r in result['items'].values() if r.get('found'))
    print('GATA: %d/%d procesate, gasite %d, modele %d, cereri %d, %d s' % (
        result['done'], len(items), found, len(models), site.requests, round(time.time() - t0)))


main(sys.argv)
