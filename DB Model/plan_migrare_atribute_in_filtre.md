# Plan: mutarea functionalului de atribute in filtre

Document de lucru, 22.08.2026. Decizii confirmate cu beneficiarul:

1. `TS_ATTRIBUTE` / `TS_ATTRIBUTE_VALUE` / `TS_GOODS_ATTRIBUTE` se **retrag complet**;
   `TS_FILTERS` ramane sistemul unic.
2. Sabloanele pe tip de produs se genereaza **automat dupa acoperire** (prag initial
   20%), apoi se revizuiesc manual.
3. Sablonul este **sugestie, nu restrictie**: semnaleaza ce lipseste, dar nu blocheaza.

Tipuri pilot: **8** (Procesor), **297** + **324** (masini de spalat vase).

---

## 1. Situatia de fapt (masurat pe SW, 22.08.2026)

| Sistem | Obiecte | Dictionar | Legaturi la produse | Produse atinse |
|---|---|---|---|---|
| Filtre (productie) | 3.598 filtre + 188 mape | 135.531 valori | **1.952.261** | 142.291 |
| Atribute (prototip) | 17 | 17 valori | 13 | 4 |

Alte cifre relevante:

- `TWEB_CATALOG_FILTERS`: 2.831 legaturi filtru -> categorie de site.
- Toate cele 302.691 de produse au `WEBGOODSTYPE_ID` completat (0 fara tip).
- Un filtru e folosit in medie de **7 tipuri** de produs, maximum **394** -> legatura
  tip <-> filtru este N:M.
- Vitrina citeste filtrele prin 12 proceduri (`WEB_GET_FILTERS_BY_CATALOG`,
  `WEB_GET_GOODS_FILTERS`/`2`/`3`, `W_V4_GET_GOODS_LIST_BY_CATALOG`,
  `W_GET_FILTER_PARAMS_BY_CATALOG` etc.) -> structurile existente se pot **extinde**,
  dar nu modifica.

### Corespondenta intre cele doua modele

| Atribute | Filtre | Observatie |
|---|---|---|
| `TS_ATTRIBUTE` | `TS_FILTERS` | atributul are `GOODS_TYPE_ID` (1 tip), filtrul e global |
| `TS_ATTRIBUTE_VALUE` | `TS_FILTER_PARAMS` | dictionar de valori |
| `TS_GOODS_ATTRIBUTE` | `TS_GOODS_FILTERS` | atributul tine **text**, filtrul tine `FILTERPARAMID` |
| - | `TS_GOODS_COMMON_FILTERS` | filtre pe mapa de produse (6 randuri) |
| - | `TWEB_CATALOG_FILTERS` | ce filtre se arata in categoria de site |
| `TS_GOODS_NAME_TEMPLATE` | - | de re-legat la filtre (etapa 5) |

**Diferenta care dicteaza arhitectura:** `GOODS_TYPE_ID` nu poate fi mutat in
`TS_FILTERS` - ar rupe reutilizarea filtrului intre tipuri. Legatura merge intr-o
tabela separata.

---

## 2. Etapa 1 - DDL (de rulat de DBA, re-rulabil)

### 2.1. Coloane noi pe `TS_FILTERS` (preiau flag-urile de la atribute)

```
FLG_FILTERABLE   SMALLINT DEFAULT 1   -- 0 = doar caracteristica, nu apare ca filtru
FLG_VARIATION    SMALLINT DEFAULT 0   -- participa la gruparea variatiilor
FLG_IN_NAME      SMALLINT DEFAULT 0   -- intra in denumirea compusa
FLG_MULTI        SMALLINT DEFAULT 0   -- valori multiple pe produs
FLG_FREE_VALUE   SMALLINT DEFAULT 0   -- valoare libera, fara dictionar
UOM_RO           VARCHAR(64)          -- unitate de masura, afisare
UOM_RU           VARCHAR(64)
DEFAULT_PARAMID  INTEGER              -- valoare implicita (-> TS_FILTER_PARAMS)
```

`TS_FILTERS.FLAGS` exista deja, dar e practic nefolosit (3.363 NULL, 421 zero, 2 unu),
deci nu il incarcam cu semnificatii noi - coloane explicite, ca la atribute.

### 2.2. Tabela de sablon (tip de produs <-> filtru)

```
TS_GOODS_TYPE_FILTERS (
  GOODSTYPEID      INTEGER NOT NULL,
  FILTERID         INTEGER NOT NULL,
  ORDERNO          SMALLINT,
  FLG_RECOMMENDED  SMALLINT DEFAULT 0,   -- lipsa lui = avertisment la editare
  FLG_AUTO         SMALLINT DEFAULT 0,   -- 1 = propus de generator, nerevizuit inca
  COVERAGE_PCT     NUMERIC(5,1),         -- acoperirea la momentul generarii
  CREATED_BY       INTEGER,
  CREATED_DATE     TIMESTAMP,
  PRIMARY KEY (GOODSTYPEID, FILTERID))
```

`FLG_AUTO` + `COVERAGE_PCT` permit re-rularea generatorului fara a strica
revizuirile manuale (se suprascriu doar randurile cu `FLG_AUTO = 1`).

Indecsi: FK-uri spre `TS_GOODS_TYPE` si `TS_FILTERS`, plus index pe `FILTERID`
(pentru intrebarea inversa "in ce tipuri apare filtrul asta").

---

## 3. Etapa 2 - generarea sabloanelor

Interogarea validata pe date reale (prag 20%, baza de calcul = produsele tipului
care au **macar un** filtru, nu toate produsele tipului):

```sql
WITH BAZA AS (
  SELECT g.WEBGOODSTYPE_ID TIP, COUNT(DISTINCT g.GOODSID) NR
  FROM TS_GOODS g
  WHERE g.WEBGOODSTYPE_ID = :tip
    AND EXISTS(SELECT 1 FROM TS_GOODS_FILTERS gf WHERE gf.GOODSID = g.GOODSID)
  GROUP BY 1)
SELECT f.FILTERID, f.FILTERNAME,
       COUNT(DISTINCT gf.GOODSID) PRODUSE,
       CAST(100.0 * COUNT(DISTINCT gf.GOODSID) / b.NR AS NUMERIC(5,1)) PROCENT
FROM TS_GOODS_FILTERS gf
JOIN TS_GOODS g  ON g.GOODSID = gf.GOODSID
JOIN BAZA b      ON b.TIP = g.WEBGOODSTYPE_ID
JOIN TS_FILTERS f ON f.FILTERID = gf.FILTERID
GROUP BY f.FILTERID, f.FILTERNAME, b.NR
HAVING 100.0 * COUNT(DISTINCT gf.GOODSID) / b.NR >= 20
ORDER BY 3 DESC;
```

De ce baza e "produse cu macar un filtru": la tipul 8 sunt 1.637 produse, dar doar
**772** au filtre completate. Raportarea la 1.637 ar cobori artificial acoperirea si
ar taia filtre reale.

### Rezultat pe pilot

**Tip 8 - Procesor** (baza 772): 21 de filtre intra in sablon.

| Filtru | Produse | % |
|---|---|---|
| Numarul nucleelor | 769 | 99,6 |
| Degajarea de caldura | 764 | 98,9 |
| CPU Socket | 761 | 98,5 |
| Procesul tehnic | 760 | 98,4 |
| Frecventa procesor | 755 | 97,7 |
| Capacitate maxima memorie | 651 | 84,3 |
| Controler memorie | 553 | 71,6 |
| Denumirea de cod a nucleului | 533 | 69,0 |
| Temperatura critica | 492 | 63,7 |
| Cache L3 | 457 | 59,1 |
| Suport ECC | 419 | 54,2 |
| Video | 411 | 53,2 |
| Tipul de memorie | 395 | 51,1 |
| Cache L2 | 391 | 50,6 |
| Cache L1 | 387 | 50,1 |
| Procesorul grafic (#210) | 380 | 49,2 |
| Numarul threads | 355 | 45,9 |
| Suport Hyper Threading | 341 | 44,1 |
| Frecventa procesor video | 340 | 44,0 |
| Tipul memoriei potrivite | 311 | 40,2 |
| Shader procesoare | 194 | 25,1 |

Raman afara, corect: `Procesorul grafic` (#600, 132 produse - duplicat de nume cu
#210), `Specificatii detaliate` (93), `Alte informatii` (32), `GPU` (16) si coada de
filtre de placa de baza aparute la 1 produs (`Chipset`, `BIOS`, `Sloturi memorie`,
`PCI-E X16`, ...) - urme de produse clasificate gresit.

**Tipurile 297 + 324 - masini de spalat vase** (baza 224 + 296): 17 filtre, ordinea
descrescatoare: Control, Instalare, Capacitate, Clasa eficienta energetica, Numar de
programe, Culoare, Clasa eficienta la spalare, Clasa eficienta la uscare, Consum de
apa, Dimensiuni, Nivel de zgomot, Uscare, Tip, Consum de energie, Numar moduri de
temperatura, Start intarziat, Spalare program regulat.

### Curatenie descoperita pe parcurs

- **Duplicate de filtre - problema mare, nu incident**: numele identice (comparate
  cu `UPPER(TRIM(...))`) formeaza **308 grupuri care acopera 1.201 filtre** din cele
  3.598, adica **o treime din dictionar**. #210 / #600 `Procesorul grafic` este doar
  cazul care a sarit in ochi la pilot. Consecinta: aceeasi caracteristica e imprastiata
  pe mai multe filtre, deci acoperirea calculata de generator e subestimata si
  sablonul poate rata filtre reale.
  Unirea = mutarea `TS_GOODS_FILTERS.FILTERID` de pe sursa pe tinta + mutarea
  valorilor din `TS_FILTER_PARAMS`, apoi stergerea sursei. Nu se poate face automat
  pe toate cele 308 grupuri: nume egale nu inseamna intotdeauna acelasi inteles
  (`Culoare` la frigidere si la telefoane e acelasi filtru, `Tip` poate sa nu fie).
  Abordare propusa: raport cu cele 308 grupuri, sortat dupa numarul de produse
  afectate, si unire asistata din pickerul deja existent.

  **Nuanta importanta, masurata dupa scrierea planului:** duplicarea globala este in
  buna parte intentionata - acelasi nume a fost creat separat pentru fiecare grupa de
  marfa. Cazurile extreme: `TIP` = **113** filtre distincte (38.060 legaturi),
  `CULOARE` = 37 (51.821 legaturi), `GREUTATE, KG` = 36, `MATERIAL` = 31. Aici
  `Tip` la frigider si `Tip` la procesor chiar NU sunt acelasi filtru, deci unirea
  globala dupa nume ar distruge date.
  Ce trebuie unit sunt doar duplicatele **din interiorul aceluiasi tip de produs**:
  **1.412 perechi (tip, nume) care acopera 3.101 filtre** - exact cazul #210/#600
  `Procesorul grafic` la tipul 8. Raportul si unirea se fac deci per tip, nu global.
- **Filtre straine tipului** (Chipset la procesor): fie produsul e clasificat gresit,
  fie legatura e reziduala. Nu se sterg automat - se raporteaza intr-o lista de
  verificat.

---

## 4. Etapa 3 - migrarea celor 17 atribute in filtre

Volum mic (17 atribute, 17 valori, 13 legaturi la 4 produse), deci se face intr-un
singur script, cu verificare manuala dupa.

Pas cu pas, pentru fiecare `TS_ATTRIBUTE`:

1. Cauta in `TS_FILTERS` un filtru cu acelasi `FILTERNAME` (comparatie pe text
   normalizat). Daca exista - se refoloseste; daca nu - se creeaza.
2. Copiaza flag-urile: `FLG_VARIATION`, `FLG_IN_NAME`, `FLG_MULTI`, `UOM_RO/RU`.
   (`FLG_FREE_VALUE` **nu exista in baza** - vezi riscul R1.)
3. `TS_ATTRIBUTE_VALUE` -> `TS_FILTER_PARAMS` (dedupe pe `PARAM_VALUE`).
4. `TS_GOODS_ATTRIBUTE` -> `TS_GOODS_FILTERS`. Atentie: atributul tine **textul**
   valorii, filtrul tine `FILTERPARAMID`. Pentru fiecare rand se cauta parametrul
   dupa text; daca lipseste, se creeaza. Aici e singurul loc unde se poate pierde
   informatie, de aceea se ruleaza intai ca `SELECT` de control.
5. `TS_ATTRIBUTE.GOODS_TYPE_ID` -> rand in `TS_GOODS_TYPE_FILTERS`
   (`FLG_RECOMMENDED` = fostul `FLG_RECOMMENDED` al atributului, `FLG_AUTO = 0`).

Dupa migrare tabelele de atribute raman goale, dar **nu se sterg** pana la validarea
in productie (rollback usor).

---

## 5. Etapa 4 - interfata WMS (Delphi)

Refolosim dialogurile deja scrise pentru atribute, schimbandu-le sursa de date:

| Acum | Devine |
|---|---|
| `frmGoodsTypeAttributesDialog` (3 grile: atribute/valori/template-uri) | manager de **sablon**: filtrele tipului din `TS_GOODS_TYPE_FILTERS` + valorile din `TS_FILTER_PARAMS` |
| `frmAttributeEditorDialog` | editor de **filtru** (nume RO/RU + flag-urile noi + UM) |
| `frmAttributeValueEditorDialog` | editor de **valoare de filtru** (`TS_FILTER_PARAMS`) |
| `frmSelectAttributeValueDialog` | picker de valori de filtru - **se pastreaza** functiile utile: valoare manuala, modifica, sterge, **uneste valorile** |
| `frameGoodsAttributesUnit` (tab in `frmContentGoodsEditorDialog`) | grila filtrelor din sablonul tipului + valorile produsului, cu avertisment neblocant pentru cele recomandate necompletate |
| `SWNAttributeNameUnit.ComposeGoodsName` | citeste `TS_GOODS_FILTERS` in loc de `TS_GOODS_ATTRIBUTE` |

Butonul "Atribute si template-uri" din `frmGoodsTypeEditorDialog` isi pastreaza locul,
doar se redenumeste ("Filtre si sabloane").

In plus, un buton nou in managerul de sablon: **"Genereaza din produse"** - ruleaza
interogarea din etapa 3 pentru tipul curent si propune filtrele, cu procentul afisat,
ca sa poata fi bifate/debifate inainte de salvare.

---

## 6. Etapa 5 - site si denumiri

- **Vitrina nu se schimba** in prima faza: continua sa citeasca `TS_GOODS_FILTERS` /
  `TWEB_CATALOG_FILTERS` prin procedurile existente. Nimic de deployat pe web.
- Beneficiu imediat, optional: `TWEB_CATALOG_FILTERS` (ce filtre se arata intr-o
  categorie) poate fi **pre-completat din sabloane**, in loc sa fie intretinut manual
  pentru fiecare din cele 2.831 de legaturi.
- `TS_GOODS_NAME_TEMPLATE` + `ComposeGoodsName` trec pe filtre: placeholder-ul
  `{attr:Nume}` devine `{filter:Nume}` (sau ramane `{attr:...}` ca alias, ca sa nu se
  strice template-urile existente).

---

## 7. Ordinea de executie

| # | Pas | Cine | Blocheaza |
|---|---|---|---|
| 1 | DDL: coloane pe `TS_FILTERS` + `TS_GOODS_TYPE_FILTERS` | DBA | tot restul |
| 2 | Raport + unirea filtrelor duplicate (308 grupuri / 1.201 filtre) | operatori + DBA | pasul 3 |
| 3 | Generare sabloane pentru tipurile pilot (8, 297, 324) | script | pasul 5 |
| 4 | Migrarea celor 17 atribute | script + verificare | pasul 6 |
| 5 | UI: managerul de sablon + tab-ul din editorul de produs | Delphi | pilot |
| 6 | Pilot pe CPU si masini de spalat vase, feedback | operatori | extindere |
| 7 | Generare pentru restul tipurilor, in valuri | script | - |
| 8 | Retragerea dialogurilor de atribute + stergerea tabelelor | Delphi + DBA | - |

Pasii 1-4 sunt reversibili (coloane noi, tabela noua, date putine). Pasul 8 e
ireversibil si se face doar dupa ce pilotul e acceptat.

---

## 8. Riscuri

**R1 - `FLG_FREE_VALUE` lipseste din baza.** Iteratia 7 a sistemului de atribute a
adaugat in cod citirea coloanei `TS_ATTRIBUTE.FLG_FREE_VALUE`, dar DDL-ul
(`DB Model/alter_attribute_free_value.sql`) **nu a fost rulat** - coloana nu exista pe
SW. Orice `SWN.exe` construit dupa acea iteratie va crapa la deschiderea frame-ului de
atribute. Optiuni: (a) se ruleaza DDL-ul ca sa functioneze pana la cutover, (b) se
sare peste, daca dialogurile de atribute se retrag oricum in acest plan. De decis
inainte de urmatorul build livrat.

**R2 - pierdere la conversia text -> `FILTERPARAMID`.** Singurul punct unde datele se
pot pierde (etapa 4, pasul 4). Mitigare: se ruleaza intai ca `SELECT` de control,
volumul e 13 randuri.

**R3 - sabloane gresite din date murdare.** Filtrele straine tipului (Chipset la
procesor) arata produse clasificate gresit. Pragul de 20% le taie, dar produsul
ramane gresit clasificat. Mitigare: raport separat "filtre in afara sablonului", de
parcurs manual.

**R4 - dictionar de filtre duplicat.** Global: 308 grupuri de nume identice, 1.201
filtre. O parte din ele sunt legitime (acelasi nume creat separat pe fiecare grupa de
marfa - `TIP` apare de 113 ori), deci unirea globala dupa nume ar distruge date.
Relevante pentru sabloane sunt duplicatele din **acelasi tip**: 1.412 perechi
(tip, nume) / 3.101 filtre. Curatenia se face per tip, inaintea generarii in masa
(pasul 7), si nu poate fi complet automata.

**R5 - `TS_GOODS_COMMON_FILTERS`** (filtre pe mapa de produse, 6 randuri) ramane in
afara modelului nou. Fiind 6 randuri, se poate migra manual sau ignora constient.
