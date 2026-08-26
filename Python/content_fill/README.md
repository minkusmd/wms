# content_fill - completare imagini si descrieri de produs

Pipeline Python folosit pentru a completa in baza `SW` imaginile (`TS_GOODS_IMAGE`)
si descrierile bilingve (`TS_GOODS_DSC`) ale produselor care nu le au.
Rulat prima data pe categoria **Procesor** (`TS_GOODS.WEBGOODSTYPE_ID = 8`), 24 aug 2026.

## Definitia "produs in price"

Produsele afisate pe fantastic.md sunt cele din tabela-cache `TWEB_CACHE_GOODS`
(de acolo le ia `W_V2_GET_GOODS_LIST_BY_CATALOG2`, procedura folosita de site).
Flagurile `FLG_PRICE` / `FLG_PRICE_FORCED` din `TDB_GOODS_FLAGS` (FLAGTYPEID 5 / 3)
nu sunt un criteriu utilizabil singur: randurile cu FLAGTYPEID=5 lipsesc complet,
iar cele cu FLAGTYPEID=3 au `START_DATE`/`END_DATE` NULL, deci vechea procedura
`WEB_GET_GOODS_FOR_PRICELIST` (2013, cu corpul comentat) nu mai selecteaza nimic.

## Ordinea de rulare

| Script | Ce face |
|---|---|
| `parse_cpu.py` | extrage specificatiile din `TS_GOODS.TITLE` + citeste filtrele produsului -> `cpu_data.json` |
| `gen_dsc.py` | compune descrierile RO/RU -> `gen_dsc.json`, `conflicts.txt`, `gen_preview.txt` |
| `apply_dsc.py` | scrie descrierile in `TS_GOODS_DSC` si verifica textul prin re-citire |
| `match_img.py` | cauta produse-geaman (acelasi model) care au imagini -> `img_match.json` |
| `pick_img.py` | alege un candidat per tinta + plansa de verificare `plan_sheet*.png` |
| `pick3.py` | extrage 3 cadre per candidat -> `pick3_*.png`, `img_index.json` (pentru alegere vizuala) |
| `apply_img.py` | copiaza cadrul ales (lista `CHOICE`, editata manual dupa verificarea vizuala) |

Verificarea vizuala a plansei **nu este optionala**: alegerea cadrului (poza cipului
pentru produsele TRAY, nu a cutiei) si controlul ca modelul e cel corect se fac cu ochiul.

## Reguli de continut

- Sursa de adevar pentru numarul de nuclee/threads, frecventa, socket, TDP, cache este
  **denumirea produsului** (`TITLE`); filtrele completeaza doar golurile. Exceptie:
  `PREFER_FILTER = {igpu, nm}` - acolo valoarea din filtru e mai ingrijita.
  Toate neconcordantele se raporteaza in `conflicts.txt`.
- Sufixul `F` / `KF` inseamna fara grafica integrata, indiferent ce scrie in titlu
  (in baza exista titluri gresite, ex. un `i5-13600KF` cu "UHD Graphics 770").
- Valorile de filtru inutilizabile (valoarea = numele filtrului, sau `-`) sunt sarite.
- Blocul de caracteristici respecta sablonul tipului: etichetele si ordinea vin din
  `TS_GOODS_TYPE_FILTERS` + `TS_FILTERS`, valorile din `TS_FILTER_PARAMS`.
- Textul e text simplu cu `\n`; site-ul aplica `nl2br` daca nu contine HTML.

## Note tehnice

- Credentialele bazei sunt inline in scripturi, aceleasi ca in `sources/SWNConst.pas`.
- Consola Windows e cp1251: scrieti rezultatele cu diacritice in fisiere UTF-8, nu la stdout.
- La `TS_GOODS_IMAGE` se insereaza doar `(GOODSID, IMAGE)`; triggerele completeaza
  `GOODS_IMAGE_ID`, `ORDERNO`, `IMAGE_HASH`, `CREATED_BY` si `FLG_NEED2RECREATE`.
  Copierea intre produse se face server-side (`INSERT ... SELECT IMAGE ...`), fara
  transfer de blob si fara re-encodare - formatul PNG se pastreaza octet cu octet.
- `RDB$SET_CONTEXT('USER_SESSION','UserID','204')` la inceputul sesiunii, ca triggerele
  sa atribuie corect `CREATED_BY`.

## Sursa Ultra (recomandata cand produsul vine de la furnizorul 202294)

Datele furnizorului Ultra sunt mult mai bogate decat filtrele si decat denumirea:
~21 proprietati bilingve per produs, plus imagini PNG.

**Legatura**: `TS_GOODS` -> `TS_PRICELIST_ITEMS.GOODSID` -> `TS_PRICELISTS.PLID`
(cu `SUPPLIERID = 202294`) -> `SUPPLIER_GOODS_CODE` = `TS_ULTRA2_PRODUCT.CODE`
= `TS_ULTRA_NOMENCLATURE.CODE` (acelasi UUID in ambele generatii de tabele).

| Ce | Unde |
|---|---|
| Caracteristici | `TS_ULTRA2_PROPERTY_VALUE` + `TS_ULTRA2_PROPERTY` (RO/RU) |
| Imagini **PNG** | `TS_ULTRA_NOMENCLATURE_IMAGE.PATH_GLOBAL` |
| Imagini WEBP | `TS_ULTRA2_PRODUCT_IMAGE.URL` (aceleasi fisiere, alt format) |
| Descriere gata facuta | `TS_ULTRA2_PRODUCT.DESCRIPTION_RO/RU` (lista de perechi, nu proza) |

Imaginile sunt **linkuri**, nu blob-uri: se descarca de pe `cdn-ultra.esempla.com`
(`ultra_fetch.py`) si se insereaza ca blob (`apply_ultra_img.py`). Preferati varianta
`.png` din `TS_ULTRA_NOMENCLATURE_IMAGE`, ca sa nu convertiti din webp.

| Script | Ce face |
|---|---|
| `ultra_link.py` / `ultra_cover.py` | verifica legatura si acoperirea Ultra |
| `ultra_fetch.py` | descarca primele cadre PNG + plansa `ultra_sheet.png` |
| `apply_ultra_img.py` | insereaza cadrul ales (lista `CHOICE`) |
| `gen_dsc_ultra.py` | descrieri RO/RU din proprietatile Ultra |
| `audit_ultra.py` | verifica valorile si le compara cu denumirea produsului |
| `apply_dsc_ultra.py` | rescrie descrierile, **fara** a atinge textele scrise de om |
| `patch_first5.py` | pastreaza proza scrisa de mana, inlocuieste doar blocul de caracteristici |

### Capcane ale datelor Ultra

- **Unitati amestecate la frecventa**: turbo poate fi in MHz langa o baza in GHz
  (ex. `4,1` + `4100`). `gen_dsc_ultra._ghz()` normalizeaza si respinge valorile
  in afara intervalului 0,3-10 GHz.
- **Frecventa de baza difera de titlu la Intel hibrid**: Ultra da baza P-core (3,5),
  titlul da baza E-core (2,6). Ambele corecte; se foloseste valoarea din titlu, ca
  descrierea sa nu contrazica denumirea afisata. Un singur caz de eroare reala
  gasit: Ryzen 7 5700G, turbo 4,0 la Ultra fata de 4,6 real.
- `Nume-cod Procesor` e numele de cod doar la Intel (Arrow Lake, Alder Lake); la AMD
  contine familia (`AMD Ryzen 7`) - se ignora.
- `Frecventa de baza Grafica {GHz}` are unitati inconsecvente (3 vs 2900) - se ignora.
- `Modelul procesorului`, `Tip`, `Ambalaj` sunt redundante fata de denumire.

## IMPORTANT: unde stau de fapt caracteristicile produsului

Caracteristicile pe care le vede operatorul in WMS si clientul pe site **nu** sunt
textul din `TS_GOODS_DSC`. Ele sunt randuri in **`TS_GOODS_DESCRIPTIONS`**, editate
prin view-ul actualizabil **`VW_TS_GOODS_DESCRIPTIONS`**:

    TS_GOODS_DESCRIPTIONS(GOODSID, FILTERID, FILTERPARAMID, FLG_GROUP, FLAGS, ORDERNO)
      -> TS_FILTERS.FILTERNAME / FILTERNAME_RUS      (numele caracteristicii)
      -> TS_FILTER_PARAMS.PARAM_VALUE / _RUS         (valoarea, bilingv)

- `TS_GOODS_DSC` = descrierea in proza (text liber), alta treaba.
- `TS_GOODS_FILTERS` = indexul de filtrare pe site, iarasi altceva.
- `FLG_GROUP = 1` inseamna rand-titlu de grup (folder), `0` = caracteristica normala.
- `FLAGS`: bit0 `FLG_VISIBLE`, bit1 `FLG_COMPATIBILITY`, bit2 `FLG_COMPARE`,
  bit3 `FLG_GOODS_LINK`. Triggerul pune implicit `FLAGS=1` (vizibil).
- Triggerul BI completeaza `DESCRIPTIONID` (din `SQ_TS_GOODS_DESCRIPTIONS_ID`),
  `ORDERNO` (max+1) si `CREATED_BY` din contextul sesiunii — **`CREATED_BY` e NOT NULL**,
  deci `RDB$SET_CONTEXT('USER_SESSION','UserID', ...)` e obligatoriu.
- Fiecare INSERT/UPDATE/DELETE se logheaza in `TLOG_GOODS_DESCRIPTIONS`.

### FILTERID canonice pentru procesoare (GOODSTYPEID=8) si pozitia lor

`canon_ids.py` le deduce din datele existente (conteaza, fiindca exista omonime —
de ex. `Procesorul grafic` e si 210 si **600**; catalogul foloseste 600).

| ORDERNO | FILTERID | Caracteristica |
|---|---|---|
| 1 | 38 | CPU Socket |
| 2 | 98 | Frecvenţa procesor |
| 3 | 101 | Numărul nucleelor |
| 4 | 2895 | Numărul threads |
| 7 | 137 | Procesul tehnic |
| 8 | 138 | Degajarea de căldură |
| 9 | 100 | Denumirea de cod a nucleului |
| 10 | 106 | Cache L3 |
| 11 | 105 | Cache L2 |
| 13 | 144 | Suport ECC |
| 14 | 141 | Tipul memoriei potrivite |
| 16 | 142 | Capacitate maximă memorie |
| 19 | 600 | Procesorul grafic |

`fill_descriptions.py pilot|all` completeaza doar caracteristicile care **lipsesc**
(randurile existente nu se ating), luand valorile din Ultra unde exista, altfel din
denumirea produsului, si creand in `TS_FILTER_PARAMS` valorile care inca nu exista
(id cerut inainte cu `NEXT VALUE FOR SQ_TS_FILTER_PARAMS_ID`, `CREATED_BY` explicit).

## Al doilea tip rulat: Frigidere (GOODSTYPEID 319)

Aceleasi principii, dar cu observatii proprii tipului:

- Frigiderele au **randuri-titlu de grup** (`FLG_GROUP=1`): 2711 Caracteristici generale (ord 1),
  2712 Răcire (14), 2713 Volum (20), 2714 Funcțional și particularități (24), 2715 Dimensiuni (31).
  Se adauga doar daca sub ele intra macar o caracteristica noua.
- Ordinea si FILTERID-urile canonice se citesc din date cu `vocab_319.py`; formatele
  de valoare deja folosite se verifica cu `values_319.py`, iar vocabularul Ultra cu
  `uvalues_319.py`. **Valorile trebuie normalizate la formatul existent**
  (`185 cm`, `310 l`, `39 dB`, `74 kg`, `12 kg/24 h`), altfel se fragmenteaza
  dictionarul si se strica fatetele de filtrare de pe site.
- Valorile enum ale Ultra difera de cele din catalog si au nevoie de traducere:
  `Indepenta`->`Detașat`, `De jos`->`Jos`, `Electronic senzor`->`Sensor`,
  `Automată`->`Automat`, `Sistem de picurare`->`Dezghetare prin picurare`,
  `Da`->`Este`. Tabelele sunt in `fill_319.py`.
- Numerele Ultra vin cu virgula zecimala si se valideaza pe intervale plauzibile
  (inaltime 30-250 cm, greutate 10-250 kg etc.) — asa au fost respinse 3 greutati
  aberante (ex. `4,38` kg pentru un frigider).
- `Tip frigider` de la Ultra (`Frigider` / `Congelator`) NU corespunde cu filtrul
  1046 `Tip` din catalog (`Frigider cu congelator jos` etc.) — nu se mapeaza automat.

Scripturi: `scope_type.py <gt>`, `ultra_link_fast.py <gt>` (legatura Ultra dintr-o
singura interogare — varianta pe produs e prea lenta), `fill_319.py pilot|all`,
`img_319_fetch.py` + `img_319_apply.py`, `verify_319.py`, `verify_img319.py`.
