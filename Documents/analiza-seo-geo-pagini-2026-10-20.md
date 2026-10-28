# Analiza SEO + GEO: homepage, categorie, produs - 20 octombrie 2026

Continuarea auditului din 15 oct 2026 (`analiza-seo-geo-fantastic-md-2026-10-15.md`). Valul 2 (comis 5effc08)
este LIVE pe `https://www.fantastic.md` (verificat azi: `llms.txt` 200, `/sitemap.xml` -> 301 `sitemap_index.xml`,
grupurile inactive 404, meta description-urile de produs fara telefon/emoji, linkurile interne direct `/<id>`,
un singur H1 pe pagina, bannerul LCP eager + preload, FontAwesome/fancybox neblocante).

**Surse:** HTML live (curl --resolve 77.89.204.52): `/`, `/ru`, `/category/laptop-uri/laptop-uri/767` (+ pagina 2),
`/group/laptop-uri/757`, `/414964`, `/ru/414964`, `robots.txt`, `llms.txt`; Lighthouse 12 mobil (throttling simulat)
pe homepage, categorie 767, produs 414964. **Ahrefs:** planul contului raspunde in continuare "Insufficient plan" la
toate endpoint-urile (nici macar `subscription-info`) - fara date de backlink-uri, DR, cuvinte-cheie sau citari AI.
Search Console nu e conectat in sesiune; cifrele GSC sint cele din sep 2026.

## 1. Rezumat

| Pagina | Perf | LCP | FCP | SI | DOM | Nota SEO on-page | Problema principala |
|---|---|---|---|---|---|---|---|
| Homepage | 70 (era 63) | 8,4 s (era 8,1) | 2,9 s (era 3,8) | 2,9 s (era 5,9) | 1 500 | 8/10 | LCP = bannerul din slider; 70% din LCP e "render delay" (5,9 s): slide-ul e pozitionat in afara ecranului (left -376 px) pina porneste JS-ul sliderului |
| Categorie 767 | 69 (era 61) | 8,1 s (= ) | 2,9 s (era 5,7) | 4,0 s (era 5,7) | 2 006 | 9/10 | LCP = prima imagine din grila, incarcata de blazy (JS) cu placeholder gif: "load delay" 6,7 s (83%) |
| Produs 414964 | 73 (era 65) | 5,6 s (era 6,8) | 3,1 s (era 4,8) | 3,1 s (era 4,8) | 892 | 8/10 | 63% din LCP e "render delay" (3,5 s) desi imaginea e eager + fetchpriority=high; 24 CSS-uri, jquery-ui + fancybox nefolosite (75 KiB) |

FCP si Speed Index s-au imbunatatit clar dupa valul 2. LCP nu, pentru ca pe toate cele trei pagini elementul LCP
e tinut de JavaScript (slider / blazy / init tirziu), nu de retea. SEO 100/100, Best Practices 100, CLS ~0, TBT 0-10 ms.

Un lucru nou, vazut pe toate paginile: la fiecare incarcare browserul face un **XHR la `/shop-cart?_csrf=...` care
intoarce pagina HTML intreaga a cosului (133 KB)** - a treia cea mai mare resursa a paginii, pe homepage si pe produs.
Sursa e in `js/ShopCart.js` / `MainScript.js` (sincronizarea cosului). Ar trebui un endpoint JSON mic (numar de
produse + total) sau citirea din `localStorage`, nu pagina intreaga.

## 2. Homepage

**Bine:** title 71 car. + description 153 car. cu intentie clara; H1 unic; 9 H2 descriptive (Categorii populare, Produse
in promotie, Top vinzari, Branduri populare, Produse noi); 173 linkuri interne, 72 direct catre `/<id>` (0 redirecturi);
canonical + hreflang ro-MD/ru-MD/x-default; LocalBusiness+Store (adresa, telefon, sameAs FB/IG) + WebSite/SearchAction;
92 imagini toate cu `alt` (52 goale = decorative); 39 lazy; bannerul LCP eager cu preload desktop + mobil (768 px);
`llms.txt` cu 207 linii (descriere, contact, program, 19 categorii nivel 1 + grupuri RO/RU).

**De corectat (ordinea impactului):**
1. **LCP 8,4 s, render delay 5,9 s.** Bannerul e descarcat la ~300 ms, dar sta in slide-ul cu `left: -376 px` pina
   initializeaza JS-ul sliderului. Rezolvare: primul slide randat vizibil cu CSS inainte de JS (slider-ul porneste din
   starea deja afisata), scripturile sliderului ne-deferite pe homepage sau un fallback CSS `.slider:not(.ready) .slide:first-child {position:static}`.
2. Logo-urile din "Branduri populare" sint PNG (Gorenje 52 KB, Samsung 25 KB, Hikoki 21 KB...) la rezolutie mare:
   175 KiB risipiti din 117 KiB convertibili in webp. Generare webp 2x la 150 px in `TS_BRANDS_IMAGE` (scriptul brand_logos exista).
3. XHR `/shop-cart` 133 KB (vezi rezumat).
4. `og:title` ("Fantastic.md - Preturi mici la laptopuri, PC-uri...") difera de `<title>`; `twitter:card=summary` in loc de
   `summary_large_image`; `og:description` scurt si generic. Acelasi `og:*` e mostenit de `/group/` (vezi 3).
5. `meta keywords` inca emis (inutil). DOM 1 500 elemente (17 `<source>` pe banner, 45 in blocul de catalog mobil) - acceptabil.
6. Fonturile FontAwesome (fa-solid 147 KB + fa-brands 106 KB) se incarca pe toate paginile pentru ~20 iconite;
   `unused-css-rules` 98% din `all.min.css`. Subset SVG inline.

## 3. Categorie (nivel 3, `/category/laptop-uri/laptop-uri/767`) si grup (nivel 2, `/group/laptop-uri/757`)

**Bine (categorie):** title din date live "Laptop-uri - 327 de modele de la 6 094 lei | Fantastic.md" (54 car.),
description 129 car. cu branduri + credit 0% + livrare; H1 "Laptop-uri - cumpara in Moldova"; 5 H2 de ghid
(tipuri, ieftin, ce sa ai in vedere, alegere) = 2 611 cuvinte vizibile; BreadcrumbList; 96 linkuri de produs `/<id>`;
pagina 2 indexabila cu title "pagina 2", self-canonical, hreflang propriu; filtrele nu apar ca linkuri crawlabile in HTML.
**Bine (grup):** title "Laptopuri in Moldova: oferta, preturi, rate 0% - Fantastic.md", description 160 car.,
H2 "Ce gasesti", "Cum alegi", "Branduri", **"Intrebari frecvente"** cu Q&A reale (3+ intrebari), tabel.

**De corectat:**
1. **LCP 8,1 s pe categorie, load delay 6,7 s (83%).** Prima imagine din grila e `<a class="b-lazy">` cu
   `src=data:image/gif` si `background-image` setat de blazy dupa ce ruleaza JS-ul (deferit). Rezolvare: primele 6-8
   carduri (above the fold) cu `<img src=... loading="eager" width height>` normal (primul cu `fetchpriority=high`),
   restul cu `loading="lazy"` nativ; blazy poate fi scos complet (toate browserele suporta lazy nativ).
2. **FAQ-ul din grup nu e marcat `FAQPage`** (JSON-LD-ul grupului are doar LocalBusiness + WebSite; nici
   BreadcrumbList). Rezolvare: `FAQPage` generat din aceleasi Q&A (sint vizibile si unice = conform regulilor Google)
   + `BreadcrumbList` pe `/group/`. Pe categoriile nivel 3 nu exista FAQ deloc - de adaugat 3-5 Q&A din TWEB_CATALOG_SEO.
3. Pe `/group/`: `og:title`/`og:description`/`twitter:*` sint cele generice ale homepage-ului, nu ale paginii.
4. `ItemList` lipseste pe categorie (lista primelor 20-24 produse cu `url`, `name`, `image`, `offers`) - ajuta
   Google Shopping/organic si motoarele AI sa citeasca grila fara JS.
5. Categorie: 58 imagini din care 48 cu `alt=""` (cardurile de produs au `alt` pe `<a>`, nu pe imagine) - imaginea
   produsului ar trebui sa fie `<img alt="Laptop ACER ...">`, nu `background-image`. Acelasi lucru rezolva si LCP-ul.
6. Lighthouse accesibilitate 88: `color-contrast`, `heading-order`, `link-name` (iconite fara text), `target-size`
   (filtre pe mobil). 32 stylesheet-uri pe categorie (cel mai mult dintre toate paginile); `category-page.css`,
   `header.css`, `footer.css`, `icon.css` sint fiecare un request blocant - de concatenat.
7. TTFB 620 ms pe categorie (homepage 110 ms, produs 50 ms): interogarea grilei + filtre. Cache de 60-120 s
   pentru vizitatorii anonimi pe HTML-ul categoriilor (sau macar pe blocul de filtre).
8. Textul SEO de categorie are 2 H2 aproape identice ("Tipuri de laptopuri disponibile pe fantastic.md" si
   "Tipuri de laptopuri pe fantastic.md") - de unit; textul e sub grila si incepe cu "Tipuri", fara un rezumat
   citabil de 2-3 fraze (ce e in categorie, interval de preturi, livrare) imediat sub H1 - exact bucata pe care o
   preiau AI Overviews / Perplexity.

## 4. Produs (`/414964`, RO si RU)

**Bine:** title "Aspirator industrial Ronix 1231 - Pret Bun | Fantastic.MD"; description 148 car. din caracteristici
(fara telefon/emoji - valul 2 e live); H1 = numele; H2 "Caracteristici...", "Descrierea produsului", "Produse
asemanatoare"; 3 tabele HTML semantice (caracteristicile se vad fara JS); Product JSON-LD cu brand, sku, mpn,
`description` real (492 car.), Offer MDL InStock, `priceValidUntil`, `shippingDetails`, `hasMerchantReturnPolicy`;
BreadcrumbList; `og:type=product`, `twitter:card=summary_large_image`; imaginea LCP din cache webp, eager,
`fetchpriority=high`, `width/height`; RU complet tradus (title, description, H1, JSON-LD).

**De corectat:**
1. **LCP 5,6 s, render delay 3,5 s.** Imaginea e in retea la 330 ms, dar se randeaza tirziu: blocul `figure > a#hover
   > picture` e manipulat de JS (zoom/fancybox/galerie) si CSS-ul de pagina vine din 24 de stylesheet-uri (1 040 ms
   blocante). Rezolvare: imaginea principala in afara oricarui container initializat de JS (fara `opacity:0`/`display`
   pina la init), CSS-ul de produs concatenat intr-un fisier, `jquery-ui.min.js` (46 KB nefolositi) si `fancybox`
   (31 KB nefolositi la incarcare) incarcate la prima interactiune.
2. **Fara recenzii / `aggregateRating`** (neschimbat): 0 din 30 produse in esantion; rich result-urile de produs apar
   rar fara rating. Modulul de recenzii ramine cea mai mare lipsa de continut.
3. **Fara `gtin13`** (feed Merchant Center si potrivirea de produs in Google/AI depind de el) si fara `deliveryTime`
   in `OfferShippingDetails` (1-2 zile Chisinau, 2-4 zile tara).
4. Fara FAQ / "Ghid rapid" pe produs (3 Q&A din caracteristici: pentru ce e, ce include, garantie) - sectiunea pe care
   o citeaza motoarele AI pentru "este X bun pentru Y".
5. `Produse vizualizate recent` apare ca H2 in romana pe pagina RU; 7 imagini cu `alt=""` (thumbnails) - de pus
   `alt="<nume> - imagine N"`.
6. `meta keywords` si 23 scripturi inline; `alpinejs` + `jquery` + `jquery-ui` + `fancybox` + Splide pe aceeasi pagina.

## 5. GEO (ChatGPT, Perplexity, Gemini, AI Overviews) - starea azi

| Semnal | 15 oct | 20 oct | Urmatorul pas |
|---|---|---|---|
| Acces crawlere AI | permis | permis (robots.txt fara reguli pentru GPTBot/ClaudeBot/PerplexityBot) | pastrat |
| `llms.txt` | lipsa | **live, 207 linii** | `llms-full.txt` cu textele de ghid ale grupurilor nivel 2 (sint deja scrise) |
| Descriere produs in JSON-LD | sablon cu telefon | **text real (492 car.)** | continutul lipsa pe ~2/3 din produse (transfer de la furnizori + generare din caracteristici) |
| Q&A citabile | 0 | FAQ vizibil pe grupuri nivel 2 (fara FAQPage) | FAQPage pe grupuri; 3-5 Q&A pe categorii nivel 3 si pe produs |
| Rezumat citabil sub H1 | nu | nu | 2-3 fraze factuale sub H1 pe categorie si grup (ce, cit costa, livrare, credit) |
| Recenzii | 0 | 0 | modul recenzii + `Review`/`aggregateRating` |
| Entitate | 2 firme / 4 adrese pe web | JSON-LD fara `legalName`/`taxID`/`foundingDate`; `sameAs` doar FB+IG | `Organization` cu IDNO, fondare 2004, GBP/Yandex/TikTok/YouTube in `sameAs`; corectare NAP extern |
| Masurare | Ahrefs indisponibil | Ahrefs indisponibil | GA4: referreri `chatgpt.com`, `perplexity.ai`, `copilot.microsoft.com`, `gemini.google.com`; GSC prin Windsor |

## 6. Trebuie cont Ahrefs?

Nu pentru lucrurile de mai sus - toate sint on-page/tehnice si se vad din HTML, Lighthouse si Search Console
(gratuite). Ahrefs (sau Semrush) aduce trei lucruri pe care nu le avem acum:
1. **Backlink-uri si DR** - cine trimite linkuri catre fantastic.md si catre concurenti (darwin.md, enter.md,
   maximum.md, ultra.md, smart.md); fara asta nu stim de ce categoriile de top stau pe pozitia 9 in loc de 3.
2. **Cuvinte-cheie si concurenti** - volumul real al interogarilor din Moldova (RO/RU), pe ce ranghesc concurentii si noi
   nu; GSC arata doar ce avem deja.
3. **Brand Radar / citari AI** - de cite ori apare fantastic.md in raspunsurile ChatGPT/Perplexity fata de concurenti.

Recomandare: **nu acum**. Primele 60-90 de zile de cistig sint in cod si continut (LCP-ul tinut de JS pe toate cele
trei pagini, recenzii, FAQ/FAQPage, descrieri de produs, NAP). Cind acestea sint live, un plan Ahrefs Lite
(~129 $/luna; API-ul din MCP cere planul cu API, mai scump) pentru 2-3 luni de analiza a concurentei si a
backlink-urilor are sens; alternativ Semrush sau un audit de backlink-uri comandat o singura data. Gratuit intre timp:
Search Console (interogari, pozitii, CTR), Bing Webmaster Tools (are si date de backlink-uri), GA4 pentru traficul
din motoarele AI.

## 7. Lista de lucru (in ordinea impactului, toate in `fantastic.web`)

1. LCP fara JS pe toate cele 3 pagini: primul slide vizibil din CSS (homepage); primele 6-8 carduri cu `<img>` eager,
   blazy scos (categorie); imaginea principala in afara containerului JS + CSS concatenat (produs).
2. XHR `/shop-cart` (133 KB HTML pe fiecare pagina) -> endpoint JSON de 200 de octeti sau localStorage.
3. `FAQPage` + `BreadcrumbList` pe `/group/`; FAQ (3-5 Q&A) pe categorii nivel 3 si pe produs; rezumat de 2-3 fraze sub H1.
4. `ItemList` pe categorii; `og:*`/`twitter:*` corecte pe `/group/` si homepage (`summary_large_image`).
5. Logo-urile brandurilor in webp la 150 px; FontAwesome -> SVG subset; jquery-ui/fancybox la interactiune.
6. Recenzii (colectare dupa livrare + afisare + schema); `gtin13` + `deliveryTime` in Offer.
7. `Organization` cu `legalName`/`taxID`/`foundingDate`/`sameAs`; NAP extern (GBP, Yandex, Kompass, delucru).
8. Continut: descrierile lipsa (2/3 din produse), `llms-full.txt`, 2-4 ghiduri/luna in blog.

## Anexa - Lighthouse 12, mobil, 20 oct 2026 (15 oct in paranteze)

| Pagina | Perf | FCP | LCP | SI | TBT | CLS | Greutate | DOM | CSS blocant | TTFB |
|---|---|---|---|---|---|---|---|---|---|---|
| Homepage | 70 (63) | 2,9 s (3,8) | 8,4 s (8,1) | 2,9 s (5,9) | 10 ms | 0 | 2 169 KiB (5 293) | 1 500 (968) | 0,8 s (1,8) | 110 ms |
| Produs 414964 | 73 (65) | 3,1 s (4,8) | 5,6 s (6,8) | 3,1 s (4,8) | 0 ms | 0,001 | 1 150 KiB (1 187) | 892 (841) | 1,0 s (2,6) | 50 ms |
| Categorie 767 | 69 (61) | 2,9 s (5,7) | 8,1 s (8,1) | 4,0 s (5,7) | 0 ms | 0,001 | 1 182 KiB (1 204) | 2 006 (1 942) | 0,4 s (3,4) | 620 ms |

Fazele LCP: homepage TTFB 0,6 s / load delay 1,7 s / load 0,2 s / **render delay 5,9 s**; produs 0,6 / 1,1 / 0,3 /
**3,5 s**; categorie 0,6 / **load delay 6,7 s** / 0,05 / 0,7 s. Greutatea homepage-ului a scazut de la 5,3 MB la 2,2 MB.
