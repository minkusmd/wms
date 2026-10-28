# Analiza SEO + GEO fantastic.md — 15 octombrie 2026

Analiza a fost facuta pe site-ul public `https://www.fantastic.md` (IP 77.89.204.52, nginx, HTTP/2),
pe codul din `fantastic.web/` si pe notele din analizele GSC din septembrie 2026.

**Surse si limite:**
- HTML live: homepage RO/RU, categorie (laptop-uri 767, pagina 2, filtru brand), produs 414964 RO/RU,
  brand ASUS, blog, livrare, about, contact, cautare, 404, toate cele 140 pagini `/group/` din sitemap,
  62 categorii nivel 3 (esantion din sitemap), 30 produse (esantion din `sitemap_products_2.xml`).
- Lighthouse 12 rulat local (mobil, throttling simulat 4G lent) pe homepage, produs, categorie.
  Datele de teren (CrUX) NU au putut fi luate: API-ul PageSpeed a raspuns "quota exceeded".
- **Ahrefs:** planul contului raspunde "Insufficient plan" la toate endpoint-urile (Site Explorer,
  backlinks, AI citations, DR gratuit, GSC prin Ahrefs). Nu exista date de backlink-uri / DR / citari AI.
- Search Console nu e conectat in sesiunea asta (Windsor lipsea); cifrele GSC sint cele din
  analizele 23-30 sep 2026.
- Din reteaua interna `fantastic.md` se rezolva la 192.168.100.113 (IIS placeholder); verificarile
  s-au facut cu `--resolve www.fantastic.md:443:77.89.204.52`.

## 1. Rezumat executiv

| Dimensiune | Nota | Comentariu |
|---|---|---|
| Tehnic / indexare | 8/10 | 301 http->https->www, canonical, hreflang RO/RU, sitemap-uri complete, noindex pe filtre, 404 real. Val 1 + fix-urile din sep sint LIVE. |
| On-page (title, meta, H1) | 7/10 | Categorii bune (date live). Produse: meta description = sablon cu telefon si emoji, copiata si in JSON-LD. |
| Continut | 4/10 | 2/3 din produse fara descriere vizibila; blog cu 1 articol; fara recenzii, fara FAQ. |
| Performanta (lab, mobil) | 4/10 | LCP 6,8-8,1 s, FCP 3,8-5,7 s; 25 CSS-uri blocante, imagini 3,3 MB pe homepage. CLS/TBT excelente. |
| Date structurate | 7/10 | LocalBusiness+Store, WebSite, Breadcrumb, Product+Offer complete. Lipsesc gtin, recenzii, ItemList. |
| GEO (AI search readiness) | 5/10 | Crawlerele AI nu sint blocate (bine), dar lipsesc llms.txt, descrieri reale, Q&A, recenzii; entitatea e inconsistenta pe web. |
| Autoritate / entitate | 4/10 | Adrese si firme diferite pe Yandex Maps, Kompass, delucru vs. site; rating 2,1 (Yandex, 9 voturi), ~3/5 (AllPrices). |

**Nota generala: C+ (62/100).** Fundatia tehnica e solida (munca din septembrie se vede live);
frinele sint continutul paginilor de produs, viteza de randare pe mobil si consistenta entitatii in afara site-ului.

**Top 5 actiuni (ordinea impactului):**
1. Descrieri reale pe produse (vizibile + in JSON-LD) — azi 20 din 30 produse esantionate au 0 cuvinte in "Descrierea produsului", iar `description` din schema Product e sablonul de meta cu "☎022 90-30-90!".
2. CSS: 25 de foi de stil blocante pe fiecare pagina (FontAwesome 1,1 s, ion.rangeSlider si Splide pe pagini care nu le folosesc) -> LCP 6,8-8,1 s pe mobil.
3. Imaginea principala a produsului (elementul LCP) vine din `/load-image/goods_image/<id>?mode=picture` (endpoint dinamic), nu din cache-ul webp; bannerele homepage 1474 px livrate pe mobil (3,3 MB risipiti).
4. Recenzii de produs (UI + `Review`/`aggregateRating`) si FAQ pe categorii — azi rating-ul e 0 pe site, iar in afara site-ului e 2,1-3/5.
5. Consistenta entitatii (NAP): o singura adresa/firma pe site, Google Business Profile, Yandex Maps, Kompass, delucru, plus `llms.txt` si pagina "Despre" cu date verificabile.

## 2. Ce functioneaza bine (verificat live)

- `http://fantastic.md` -> 301 -> `https://www.fantastic.md/` (un singur salt), HSTS 1 an, HTTP/2 (ALPN h2),
  certificat Sectigo valid pina la 28 ian 2027, SAN pentru apex si www.
- `/ro` -> 301 `/`, `/index.php` -> 301 `/`, slash final -> 301, `?page=1` scos. Formatul vechi de produs
  `/<slug>/<cat>-<id>` -> 301 `/<id>`.
- `<html lang="ro">` / `lang="ru">`, canonical self pe fiecare tip de pagina, hreflang `ro-MD` / `ru-MD` / `x-default`
  in HTML si in toate sitemap-urile (3 alternate per URL).
- `robots.txt`: 32 reguli, fara blocarea filtrelor (noindex-ul e vizibil pentru Googlebot), `Sitemap:` corect.
  Nu exista reguli impotriva GPTBot / ClaudeBot / PerplexityBot / Google-Extended = continutul e accesibil AI.
- Sitemap index cu 14 fisiere: 53 631 produse RO + RU, 895 categorii/grupuri, 986 branduri, 50 pagini, blog.
  Toate URL-urile au `lastmod`. Esantionul de 30 produse din sitemap: 30/30 `index,follow`, 30/30 cu schema
  Product, 30/30 InStock (filtrul FLG_PRICE_FORCED din SiteMap::get e live).
- Filtre (`?brand=`), sort, cautare: `noindex, follow` + canonical pe URL-ul curat. Paginarea: pagina 2
  indexabila, self-canonical, `rel=prev/next`, title "pagina 2".
- 404 real (status 404) pentru URL-uri inexistente.
- Categoriile nivel 3: title/description generate din date live ("Laptop-uri – 345 de modele de la 6 084 lei"),
  43 din 62 in esantion; descrierile 127-160 caractere, niciuna goala, niciuna peste 160; H1 + text SEO
  de ~800 cuvinte (298-1 843) sub grila; BreadcrumbList.
- Toate cele 140 pagini `/group/` din sitemap au title, description si H1 (SQL-ul articolelor nivel 2 e rulat).
- Homepage are H1, `/brands` are title (reparate dupa auditul din sep).
- Imagini: webp peste tot, `preload` + `fetchpriority=high` pe imaginea hero, `loading="lazy"` pe cardurile
  de produs; JS cu cache 10 ani, imagini 30 zile; gzip.
- Lighthouse: SEO 100/100, Best Practices 96-100, CLS 0-0,003, TBT 0 ms pe toate cele 3 pagini.
- JSON-LD: LocalBusiness+Store (adresa, geo, program, 2 ContactPoint, sameAs FB/IG), WebSite+SearchAction,
  BreadcrumbList (categorii + produse), Product cu brand, mpn, sku, Offer (pret, MDL, InStock,
  priceValidUntil, shippingDetails 50 MDL, hasMerchantReturnPolicy 14 zile).
- Pagina "Despre" si "Contacte" au firma (SOLUTII COMERCIALE SRL), IDNO, adresa.

## 3. Probleme, cu dovezi si rezolvare

### P0 — impact mare

**3.1 Produse fara descriere; schema Product cu descriere-sablon**
- Esantion 30 produse: blocul "Descrierea produsului" are 0 cuvinte la 20, sub 15 cuvinte la 4; doar 6 au text real (36-170 cuvinte).
- `description` din JSON-LD Product = meta description-ul sablon:
  "Aspirator industrial Ronix 1231 - Preț Bun | Fantastic.MD ☎022 90-30-90! Cauți Aspirator industrial? ✔Credit 0% ✔Prețuri mici ⭐Livrare în Chișinău și în..."
  (23-31 cuvinte, cu telefon si emoji). Google si motoarele AI citesc exact acest text ca "descrierea produsului".
- Context (27 sep 2026): 38 460 din 46 742 produse fara descriere RO; 95% din produsele noi (goodsid >= 398000) fara descriere si caracteristici -> "accesata, neindexata" in GSC.
- Rezolvare: (a) in `SiteController` 6406-6441 si `product.php` 1446-1520: `description` din JSON-LD = textul real din TS_GOODS_DSC (primele 300-500 caractere, fara telefon/emoji), fallback = lista caracteristicilor; meta description fara "☎" si fara "...". (b) Continuarea transferului de continut de la furnizori (butonul din frame78) + generarea descrierilor din caracteristici pentru cele 19 834 fara nimic. (c) Caracteristicile (TS_GOODS_DESCRIPTIONS) randate ca tabel HTML semantic (`<table>`/`<dl>`), nu doar in tab-ul JS.

**3.2 CSS blocant: 25 de stylesheet-uri pe orice pagina**
- Lighthouse (mobil simulat): render-blocking 1,8-3,4 s; FontAwesome `all.min.css` 1,1 s, `ion.rangeSlider.min.css` 0,8 s, `splide-core.min.css` 0,8 s, plus `checkout.css`, `contact.css`, `blog.css`, `jquery-ui.css`, `jquery-ui-slider-pips.css` incarcate si pe homepage/produs unde nu sint folosite.
- FCP 3,8 s (home) / 4,8 s (produs) / 5,7 s (categorie); LCP 8,1 / 6,8 / 8,1 s; Speed Index 4,8-5,9 s. Scor performanta 61-65.
- Rezolvare in `assets/AppAsset.php` (30-59): un bundle CSS minificat + critical CSS inline pentru header/hero; FontAwesome inlocuit cu SVG-uri inline (sau subset de 20 iconite); `jquery-ui*`, `ion.rangeSlider`, `splide`, `checkout`, `contact`, `blog`, `fancybox` incarcate doar pe paginile care le folosesc (`AssetBundle` per view); CDN-urile externe (cdnjs, jsdelivr) aduse local pentru a evita 2 conexiuni suplimentare.

**3.3 Imaginea LCP de produs si imaginile homepage**
- Elementul LCP pe produs: `<img id="ctl00_ContentPlaceHolder1_imgMainImage" src="https://www.fantastic.md/load-image/goods_image/414964?mode=picture&subID=…">` — endpoint PHP dinamic, in timp ce `og:image` si JSON-LD folosesc deja `/images/cache/goods_image/big/…webp`. Lighthouse: `image-size-responsive` picat.
- Homepage: 5,3 MB total, `uses-responsive-images` 3 344 KiB risipiti (bannere 1474x433 px livrate pe mobil, `modern-image-formats` 117 KiB).
- Rezolvare: `product.php` 181-182 sa foloseasca direct webp-ul din cache cu `srcset` (big/iconbig) si `width/height`; bannerele promo cu `<picture>` + variante 480/768/1200; `preload` doar pentru primul banner (acum sint 8 preload-uri `group_catalog_image` cu `fetchpriority=high`, care concureaza cu LCP-ul).

### P1 — impact mediu

**3.4 Pagini `/group/` orfane cu title gol**
- `/group/pentru-dormitor/1129` si `/group/televizoare/602` nu sint in sitemap, dar raspund 200 cu `<title></title>`, `description` goala, H1 gol. Google le are inca in index cu titlul vechi "Fantastic.md - Preturi fantasticice la laptopuri, PC și Periferice" (typo "fantasticice").
- Rezolvare: in `actionGroup` (SiteController ~2222) grupurile inactive / fara TWEB_CATALOG_SEO -> 301 la parintele activ sau 404; verificare in GSC cite URL-uri `/group/` indexate lipsesc din sitemap.

**3.5 Lipsa recenziilor si a rating-ului**
- Pe site nu exista UI de recenzii; `aggregateRating` se emite doar daca `GoodsRating::getAggregate` are date (0 din 30 in esantion). Reputatia externa: Yandex Maps 2,1/5 (9 voturi), AllPrices ~3/5.
- GSC (sep 2026): PRODUCT_SNIPPETS ~1% din afisari desi JSON-LD e complet — rich result-urile de produs apar mai ales cu rating/review.
- Rezolvare: modul de recenzii (TWEB_GOODS_RATINGS exista deja) cu invitatie post-livrare (SMS/email la 7 zile), afisare pe pagina + `Review`/`aggregateRating`; raspunsuri la recenziile de pe Yandex/Google.

**3.6 Meta description pe produse: sablon cu telefon, emoji, "..."**
- Toate produsele: "… | Fantastic.MD ☎022 90-30-90! Cauți X? ✔Credit 0% ✔Prețuri mici ⭐Livrare în Chișinău și în..." (taiat la 160 cu "..."). Pe brand: taiat in mijlocul cuvintului ("Prețuri atra").
- Rezolvare: in `SP_SEO_GENERATE_DATA` (baza) / `SiteController` 6406: "Nume — pret de la X lei, caracteristici cheie (3), livrare in Moldova, credit 0%." Taiere la ultimul cuvint intreg, fara emoji si fara telefon.

**3.7 Blog aproape gol; fara autor / E-E-A-T**
- `sitemap_blog.xml` = 1 URL (indexul); pe `/blog` exista 1 articol ("Cum sa alegi o masina de spalat") + 4 categorii goale. `BlogPosting` are `author` Person, dar nu exista pagina de autor.
- Rezolvare: 2-4 ghiduri/luna legate de categoriile cu cel mai mare volum (telefoane, laptopuri, frigidere, masini de spalat, anvelope), fiecare cu linkuri catre categorie si 3-5 produse, autor cu pagina proprie, data actualizarii. Articolele din sitemap_blog (nu doar indexul).

**3.8 Entitate inconsistenta in afara site-ului (NAP)**
- Site + JSON-LD: str. Melestiu 16/2; footer juridic: SOLUTII COMERCIALE SRL, str. Podul Inalt 18/54; Yandex Maps: str. Mesterul Manole 12/2; delucru.md: str. Maria Dragan 2/1A; Kompass: Gama Computer SRL.
- Pentru Google si pentru motoarele AI, entitatea "Fantastic.md" e slaba: nume de firma diferite, 4 adrese, fara Wikidata, fara `sameAs` catre profilurile de business.
- Rezolvare: o adresa de showroom (Melestiu 16/2) peste tot; revendicare + corectare Google Business Profile si Yandex Business; `sameAs` extins (GBP, Yandex, Facebook, Instagram, TikTok, YouTube, delucru); `legalName` + `taxID`/`vatID` (IDNO) in LocalBusiness; `foundingDate` 2004.

### P2 — impact mic / igiena

- `/sitemap.xml` -> 404; multe tool-uri si crawlere AI incearca intii acest URL. Rezolvare: 301 catre `sitemap_index.xml`.
- `sitemap_pages.xml` contine `/page/test` si landing-uri vechi (`/page/choosetv`, `/page/basseini`, `/page/matrasi`) care raspund 200 cu continut neclar. Rezolvare: scoase din sitemap sau 301 la categoria corespunzatoare.
- `lastmod` pe produse e in 3 date dominante (10 oct 2026: 4 414; 7 mar 2026: 4 194; 3 iun 2025: 2 207) = date de import in masa, nu modificari reale. Google ignora lastmod-urile nefiabile. Rezolvare: lastmod = max(content_modified, data schimbarii de pret/stoc).
- Linkurile de pe homepage catre produse sint in formatul vechi `/aspirator-industrial-ronix-1231/1494-414964` -> 301 -> `/414964`. Fiecare click intern consuma un redirect; crawl budget risipit pe 53k produse. Rezolvare: generatoarele interne (SiteController 499/504/6190/6947, carusele) sa emita direct `/<id>`.
- URL-ul canonic al produsului e `/<id>` (fara cuvinte-cheie). Schimbarea nu merita riscul acum; pastrat, dar documentat ca limita.
- `og:title` pe homepage ("Preturi mici la laptopuri, PC-uri...") difera de `<title>`; `twitter:card=summary` (nu `summary_large_image`) pe homepage.
- Accesibilitate (Lighthouse 88-93): contrast insuficient, linkuri fara nume accesibil (iconite), `heading-order`, `target-size` pe categorii, 7 din 27 imagini cu `alt=""` pe produs (thumbnails).
- Meta `keywords` emis pe toate paginile — inutil, poate fi scos.
- HTML-ul nu are cache (Cache-Control: no-store, sesiune PHP pe fiecare GET). Pentru crawlere nu conteaza, dar un cache de 60 s pentru vizitatorii anonimi ar reduce TTFB-ul categoriilor (520-600 ms).
- `uses-long-cache-ttl`: 54 resurse cu TTL scurt pe homepage (imaginile din `/images/cache/` au 30 zile / 10 zile pentru cache). Pot trece la 1 an + hash in nume (deja exista hash).
- DOM: 1 942 elemente pe categorie (grila + filtre); mobilul primeste toata grila de filtre desktop.

## 4. GEO — vizibilitatea in motoarele de raspuns (ChatGPT, Perplexity, Google AI Overviews, Gemini)

Ce verifica un motor AI cind recomanda un magazin / produs din Moldova si cum sta fantastic.md:

| Semnal | Stare | Actiune |
|---|---|---|
| Acces crawlere AI (GPTBot, ClaudeBot, PerplexityBot, Google-Extended, Bingbot) | Permis implicit (nu exista reguli) | Pastrat. Optional: reguli explicite `Allow` ca declaratie de intentie; `Disallow` doar pentru cos/cont. |
| `llms.txt` / `llms-full.txt` | Lipsa (404) | `web/llms.txt` generat din SitemapGenerator: descriere magazin, livrare, garantie, credit, 26 categorii nivel 1 cu linkuri si o fraza, politica de retur, contact. ~200 linii, RO + sectiune RU. |
| Raspunsuri scurte, citabile (definitii, "cat costa", "cum aleg") | Textele SEO de categorie (~800 cuvinte) exista, dar fara structura Q&A | Bloc "Intrebari frecvente" cu 4-6 Q&A pe categoriile nivel 2/3 (din TWEB_CATALOG_SEO), marcate `FAQPage` doar daca sint vizibile si unice; pe produse "Ghid rapid" cu 3 Q&A generate din caracteristici. |
| Descrieri de produs factuale | Sablon cu telefon/emoji in JSON-LD; vizibil gol la 2/3 | Vezi 3.1. Motoarele AI citeaza `description` + tabelul de specificatii. |
| Pret/stoc/livrare lizibile fara JS | Pret, InStock, livrare 50 MDL in Offer; "livrare in Chisinau" in text | Bine. De adaugat `deliveryTime` (1-2 zile Chisinau, 2-4 zile tara) in OfferShippingDetails si `gtin13` acolo unde exista (feed Merchant Center depinde tot de el). |
| Recenzii / dovezi sociale | 0 pe site; 2,1-3/5 in afara | Vezi 3.5. AI-urile preiau rating-ul din Yandex/Google Maps cind site-ul nu are nimic. |
| Entitate clara (cine e in spatele site-ului) | 2 firme, 4 adrese pe web | Vezi 3.8. `Organization` separat cu `legalName`, `taxID`, `foundingDate`, `numberOfEmployees`, `sameAs`, legat prin `@id` de `Store`. Pagina "Despre" cu istoric (din 2004), showroom, echipa. |
| Continut comparativ / ghiduri | 1 articol de blog | Vezi 3.7. Ghidurile "cum aleg X in 2026" + "top 5 X sub Y lei" sint tipul de pagina pe care Perplexity/ChatGPT il citeaza pentru query-uri comerciale. |
| Pagini de brand | Title + description generic ("Magazinul-online Fantastic.md oferă o gamă largă de produse ASUS…"), fara text, fara JSON-LD | Text scurt despre brand + categorii disponibile + `Brand` in JSON-LD; `ItemList` cu primele 20 produse. |
| Prezenta in surse citate frecvent (Wikipedia/Wikidata, directoare, presa) | Fara Wikidata; Kompass cu firma gresita; AllPrices cu rating slab | Element Wikidata pentru magazin (fondat 2004, Chisinau, site, FB/IG); corectare Kompass; listare pe price-agregatoarele locale cu feed. |
| Masurare | Ahrefs Brand Radar / AI citations indisponibile pe planul curent | GA4: segment pe referrer `chatgpt.com`, `perplexity.ai`, `copilot.microsoft.com`, `gemini.google.com`; GSC: query-urile cu "ai_overview" nu se vad, dar CTR-ul pe pozitiile 1-3 scade cind apar AI Overviews — de urmarit pe categoriile de top. |

## 5. Plan pe 30 / 60 / 90 de zile

**30 zile (cod + date, fara dependente externe)**
1. JSON-LD Product `description` din textul real; meta description fara telefon/emoji (3.1, 3.6).
2. Bundle CSS + critical CSS + FontAwesome scos; stylesheet-uri conditionate pe pagina (3.2).
3. Imaginea LCP de produs din cache webp + `srcset`; bannere responsive; un singur preload (3.3).
4. `/sitemap.xml` 301, `/page/test` scos, grupuri inactive 301/404, linkuri interne direct `/<id>` (3.4, P2).
5. `llms.txt` generat de SitemapGenerator.
6. Rularea butonului de continut furnizori pentru PLID-urile ramase (fara Accent) + descrieri din caracteristici.

**60 zile**
7. Recenzii: colectare post-livrare + afisare + schema (3.5).
8. FAQ pe categoriile nivel 2 (198) si pe top 100 categorii nivel 3 dupa afisari GSC.
9. NAP: GBP + Yandex + Kompass + delucru corectate; `Organization` cu `legalName`/IDNO; Wikidata (3.8).
10. Pagini de brand cu text + JSON-LD (top 50 branduri dupa trafic).

**90 zile**
11. Blog: 8-12 ghiduri pe categoriile cu cel mai mare volum, cu autor; sitemap_blog cu articole.
12. Feed Google Merchant Center (contul e gol din sep 2026; blocat de gtin/mpn in WMS).
13. Re-masurare: Lighthouse (LCP < 2,5 s pe mobil), GSC (CTR categorii poz 1-10 >= 4%, produse "accesata, neindexata" -50%), GA4 referreri AI.

## 5a. Realizat pe 15 oct 2026 (cod in fantastic.web, necomis, nedeployat)

Testat pe serverul local (127.0.0.1:8080, baza SW): toate paginile raspund 200, fara erori in runtime/logs/app.log.

| Punct | Ce s-a facut | Fisiere |
|---|---|---|
| 3.1 / 3.6 | `helpers/ProductSeoMeta.php`: title + meta description + `Product.description` intr-un singur loc; sablonul din META_DESC_* (telefon, emoji, "Preț Bun |") nu mai e tratat ca text manual; descrierea vine din text -> caracteristici -> model/garantie, fara "..."; JSON-LD primeste descrierea reala (pina la 500 caractere, cu spatii intre elementele listei). | helpers/ProductSeoMeta.php, controllers/SiteController.php, views/site/product.php |
| 3.2 | AppAsset pastreaza doar CSS-ul comun; FontAwesome, ion.rangeSlider si fancybox neblocante (media=print + onload, noscript pentru FA); Splide doar pe homepage; checkout/contact/blog/libercard in pachete per pagina; preconnect la cdnjs si jsdelivr. | assets/PageAsset.php + 7 pachete, assets/AppAsset.php, views/layouts/main.php, 10 view-uri |
| 3.3 | Produs: varianta mobila de 500 px se genereaza o data si se serveste static (nu prin /load-image). Homepage: primul banner eager + fetchpriority=high + preload desktop/mobil, celelalte 19 lazy; varianta mobila de 768 px (promo_banner/mobile, 41 KB in loc de ~200 KB); preload-urile de categorii reduse la 4, fara prioritate inalta. | views/site/product.php, views/site/index.php, controllers/SiteController.php, components/HelperComponent.php |
| 3.4 | Grupurile fara arbore (inactive) raspund 404. | controllers/SiteController.php (actionGroup) |
| P2 | `/sitemap.xml` -> 301 `sitemap_index.xml`; `/page/test` scos din sitemap si noindex (`SitemapGenerator::NON_PUBLIC_PAGES`); toate linkurile interne catre produse (homepage, "cumpara impreuna", complecte) direct `/<id>` - 0 redirecturi interne pe homepage (erau 24). | config/web.php, components/SitemapGenerator.php, controllers/SiteController.php |
| GEO | `web/llms.txt` generat de SitemapGenerator (208 linii: descriere, contact, program, cum se citesc preturile/stocul, 19 categorii nivel 1 cu 151 grupuri nivel 2 RO+RU, pagini de informatii). | components/SitemapGenerator.php, .gitignore |
| bonus | H1 dublu pe toate paginile (popup-ul "Cadou de bun venit" avea `<h1>`) -> h2; H1 din articolele SEO de categorie/grup coborite la h2 la randare. | views/layouts/_signup_offer.php, web/css/signup-offer.css, views/site/category.php, views/site/group.php |

**De facut la deploy:** `php yii sitemap/generate` (sau cronul `/generatesitemap`) ca sa apara `llms.txt` si sitemap-ul fara `/page/test`; cache-ul Yii se reimprospateaza singur in 30 min (blocurile de produse de pe homepage). Lighthouse pe productie dupa deploy, pentru LCP/FCP (local nu e comparabil: serverul PHP incorporat).

**Ramase din planul pe 30 de zile:** rularea butonului de continut furnizori (punctul 6, manual, din WMS). Din 60/90 zile: recenzii, FAQ pe categorii, NAP/GBP/Wikidata, branduri, blog, feed Merchant Center.
## 6. Anexa — masuratori

**Lighthouse 12, mobil, throttling simulat (15 oct 2026)**

| Pagina | Perf | FCP | LCP | SI | TBT | CLS | Greutate | DOM | CSS blocant |
|---|---|---|---|---|---|---|---|---|---|
| Homepage | 63 | 3,8 s | 8,1 s | 5,9 s | 0 ms | 0 | 5 293 KiB | 968 | 1,8 s |
| Produs 414964 | 65 | 4,8 s | 6,8 s | 4,8 s | 0 ms | 0,003 | 1 187 KiB | 841 | 2,6 s |
| Categorie 767 | 61 | 5,7 s | 8,1 s | 5,7 s | 0 ms | 0 | 1 204 KiB | 1 942 | 3,4 s |

SEO 100/100, Best Practices 96-100, Accesibilitate 88-93 pe toate trei. TTFB server: 60-520 ms.

**Sitemap-uri (15 oct 2026, 01:00)**

| Fisier | URL-uri | lastmod | hreflang |
|---|---|---|---|
| sitemap_products_1/2/3 (RO) | 19 427 + 18 291 + 15 913 = 53 631 | toate | 3/URL |
| sitemap_products_ru_1/2/3 | 53 631 | toate | 3/URL |
| sitemap_categories (+ru) | 895 (140 `/group/` + 755 `/category/`) | toate | 3/URL |
| sitemap_brands (+ru) | 986 | toate | 3/URL |
| sitemap_pages (+ru) | 50 | toate | 3/URL |
| sitemap_blog (+ru) | 1 | toate | 3/URL |

**Esantion 30 produse din sitemap_products_2.xml:** 30 index, 30 Product schema, 30 InStock, 30 mpn, 0 gtin,
0 aggregateRating; descriere JSON-LD 22-31 cuvinte (sablon); descriere vizibila: 20 x 0 cuvinte, 4 x 2-14, 6 x 36-170.

**Esantion 62 categorii nivel 3:** 43 title "N modele de la X lei", 19 alt format (toate cu pret/brand), description 127-160
caractere, 298-1 843 cuvinte/pagina (media 808), 0 FAQPage.

**Context GSC (din analizele 23-30 sep 2026, Windsor):** 274K pagini indexate / 498K neindexate; 28 zile: 21,5K clicuri,
461K afisari, CTR 4,7%, pozitia 9,4; an la an clicuri -30%, pierderea pe paginile de produs RO; 17 categorii pe poz <= 10
cu CTR 2,1%; Moldova = 95% din clicuri.

**Reputatie externa (cautare web, 15 oct 2026):** Yandex Maps 2,1/5 (9), AllPrices.md ~3/5; adrese diferite:
Melestiu 16/2 (site), Podul Inalt 18/54 (footer juridic), Mesterul Manole 12/2 (Yandex), Maria Dragan 2/1A (delucru);
firma: SOLUTII COMERCIALE SRL (site) vs Gama Computer SRL (Kompass).
