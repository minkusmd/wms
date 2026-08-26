import requests
from bs4 import BeautifulSoup
import json
import re
import sys
import time

# Asigurare codificare UTF-8
sys.stdout.reconfigure(encoding='utf-8')

BASE_URL = 'https://smartex.md/categorie-produs/dulapuri-cu-usa/'
HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
}

def clean_price(price_str):
    """Curăță și normalizează textul prețului."""
    if not price_str:
        return ""
    return price_str.replace('\xa0', ' ').strip()

def clean_image_url(url):
    """Elimină sufixele de rezoluție mică pentru a obține imaginea originală."""
    if not url:
        return ""
    return re.sub(r'-\d+x\d+\.(png|jpg|jpeg|webp)$', r'.\1', url, flags=re.IGNORECASE)

def discover_product_urls(start_url):
    """Descoperă recursiv toate paginile de produse (inclusiv subcategorii și paginare)."""
    visited_urls = set()
    to_visit = [start_url]
    product_urls = set()

    print("Se descoperă paginile de produse și subcategoriile...")

    while to_visit:
        current_url = to_visit.pop(0)
        if current_url in visited_urls:
            continue
        visited_urls.add(current_url)

        try:
            r = requests.get(current_url, headers=HEADERS, timeout=10)
            if r.status_code != 200:
                continue
            soup = BeautifulSoup(r.text, 'html.parser')

            # 1. Subcategorii
            for cat in soup.select('.product-category a.category-link, .product-category a.wd-cat-image, .product-category h3.wd-entities-title a'):
                href = cat.get('href')
                if href and href not in visited_urls and 'categorie-produs' in href:
                    to_visit.append(href)

            # 2. Produse
            for prod in soup.select('.product:not(.product-category)'):
                link = prod.select_one('a.product-image-link, a.wd-product-link, a.woocommerce-LoopProduct-link, h3.wd-entities-title a')
                if link and link.get('href'):
                    p_url = link['href']
                    if p_url not in product_urls:
                        product_urls.add(p_url)

            # 3. Paginare
            next_page = soup.select_one('a.next.page-numbers')
            if next_page and next_page.get('href'):
                n_url = next_page['href']
                if n_url not in visited_urls:
                    to_visit.append(n_url)

        except Exception as e:
            print(f"Eroare la accesarea {current_url}: {e}")

    print(f"S-au găsit {len(product_urls)} produse unice.")
    return sorted(list(product_urls))

def extract_features(soup):
    """Extrage caracteristicile din #content_features sau din tabelele de atribute."""
    features = {}

    # 1. Căutare după id-ul specificat: #content_features
    cf = soup.select_one('#content_features')
    if cf:
        for item in cf.select('.ty-control-group, .feature-item, tr, .feature, div.product-feature'):
            label = item.select_one('.ty-control-group__label, th, .feature-label, strong, span.label')
            val = item.select_one('.ty-control-group__item, td, .feature-value, span.value')
            if label and val:
                k = label.get_text(strip=True).rstrip(':')
                v = val.get_text(strip=True)
                if k and v:
                    features[k] = v
        if not features:
            lines = [line.strip() for line in cf.get_text(separator='\n').splitlines() if line.strip()]
            if lines:
                features['text_caracteristici'] = ' | '.join(lines)

    # 2. Fallback WooCommerce: shop_attributes / tab-additional_information
    if not features:
        for tr in soup.select('table.shop_attributes tr, table.woocommerce-product-attributes tr'):
            th = tr.select_one('th')
            td = tr.select_one('td')
            if th and td:
                k = th.get_text(strip=True)
                v = td.get_text(strip=True)
                features[k] = v

    return features

def extract_stock(soup):
    """Extrage statusul stocului din .ty-control-group.product-list-field sau din selectorii WooCommerce."""
    # 1. Căutare după clasele specificate: .ty-control-group.product-list-field sau .product-list-field
    ty_stock = soup.select_one('.ty-control-group.product-list-field, .product-list-field, .ty-control-group')
    if ty_stock:
        txt = ty_stock.get_text(strip=True)
        if 'stoc' in txt.lower() or 'stock' in txt.lower():
            is_in_stock = not ('nu' in txt.lower() or 'out' in txt.lower() or 'epuizat' in txt.lower() or 'fara' in txt.lower())
            return {
                'in_stock': is_in_stock,
                'stoc_text': txt
            }

    # 2. Selectori WooCommerce standard (.stock, .in-stock, .out-of-stock)
    stock_el = soup.select_one('p.stock, .stock, .in-stock, .out-of-stock')
    if stock_el:
        txt = stock_el.get_text(strip=True)
        classes = stock_el.get('class', [])
        is_in_stock = 'out-of-stock' not in classes and not ('epuizat' in txt.lower() or 'stoc lipsa' in txt.lower())
        return {
            'in_stock': is_in_stock,
            'stoc_text': txt
        }

    # 3. Meta tag availability
    meta_avail = soup.select_one('meta[property="product:availability"]')
    if meta_avail and meta_avail.get('content'):
        val = meta_avail['content'].lower()
        is_in_stock = val in ['instock', 'in stock', 'in_stock']
        return {
            'in_stock': is_in_stock,
            'stoc_text': "În stoc" if is_in_stock else "Stoc epuizat"
        }

    # 4. Clasacheck pe containerul principal de produs
    prod_div = soup.select_one('.product.type-product')
    if prod_div:
        classes = prod_div.get('class', [])
        if 'instock' in classes:
            return {'in_stock': True, 'stoc_text': "În stoc"}
        elif 'outofstock' in classes:
            return {'in_stock': False, 'stoc_text': "Stoc epuizat"}

    return {'in_stock': True, 'stoc_text': "În stoc"}

def scrape_product(url):
    """Extrage datele complete pentru un produs."""
    try:
        r = requests.get(url, headers=HEADERS, timeout=10)
        if r.status_code != 200:
            return None
        soup = BeautifulSoup(r.text, 'html.parser')

        # 1. Denumire
        title_el = soup.select_one('h1.product_title, h1.entry-title')
        title = title_el.get_text(strip=True) if title_el else ''

        # 2. Articol / SKU
        sku = ''
        sku_el = soup.select_one('.sku_wrapper .sku, [itemprop="sku"], .product_meta .sku')
        if sku_el:
            sku_text = sku_el.get_text(strip=True)
            if sku_text.lower() != 'n/a':
                sku = sku_text

        if not sku:
            meta_sku = soup.select_one('meta[property="product:retailer_item_id"]')
            if meta_sku and meta_sku.get('content'):
                sku = meta_sku['content']

        if not sku:
            for tr in soup.select('table.shop_attributes tr, table.woocommerce-product-attributes tr'):
                label = tr.select_one('th')
                val = tr.select_one('td')
                if label and val and any(k in label.text.lower() for k in ['articol', 'sku', 'cod']):
                    sku = val.get_text(strip=True)

        # 3. Preț nou și Preț vechi
        pret_nou = ''
        pret_vechi = ''
        price_box = soup.select_one('.summary .price, p.price, .entry-summary .price')
        if price_box:
            del_el = price_box.select_one('del')
            ins_el = price_box.select_one('ins')
            if del_el and ins_el:
                pret_vechi = clean_price(del_el.get_text(strip=True))
                pret_nou = clean_price(ins_el.get_text(strip=True))
            else:
                pret_nou = clean_price(price_box.get_text(strip=True))

        # 4. Imagini
        images = []
        for a in soup.select('.woocommerce-product-gallery__image a, .product-images a, figure.woocommerce-product-gallery__wrapper a'):
            href = a.get('href')
            if href and '/uploads/' in href:
                c_href = clean_image_url(href)
                if c_href not in images:
                    images.append(c_href)

        if not images:
            for img in soup.select('.woocommerce-product-gallery img'):
                src = img.get('data-large_image') or img.get('data-src') or img.get('src')
                if src and '/uploads/' in src:
                    c_src = clean_image_url(src)
                    if c_src not in images:
                        images.append(c_src)

        # 5. Caracteristici (#content_features)
        caracteristici = extract_features(soup)

        # 6. Status Stoc (.ty-control-group product-list-field)
        stock_info = extract_stock(soup)

        return {
            'denumire': title,
            'articol': sku,
            'pret_nou': pret_nou,
            'pret_vechi': pret_vechi,
            'in_stock': stock_info['in_stock'],
            'stoc_text': stock_info['stoc_text'],
            'caracteristici': caracteristici,
            'url_imagini': images,
            'url_produs': url
        }

    except Exception as e:
        print(f"Eroare la extragerea produsului {url}: {e}")
        return None

def main():
    product_urls = discover_product_urls(BASE_URL)
    results = []

    print("Se extrag datele pentru fiecare produs...")
    for idx, p_url in enumerate(product_urls, start=1):
        print(f"[{idx}/{len(product_urls)}] Se procesează: {p_url}")
        p_data = scrape_product(p_url)
        if p_data:
            results.append(p_data)
        time.sleep(0.1)

    output_filename = 'dulapuri_cu_usa.json'
    with open(output_filename, 'w', encoding='utf-8') as f:
        json.dump(results, f, ensure_ascii=False, indent=4)

    print(f"\nExtragere finalizată cu succes! {len(results)} produse au fost salvate în '{output_filename}'.")

if __name__ == '__main__':
    main()
