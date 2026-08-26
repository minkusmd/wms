# Plan: pret pentru vanzari in rate 6 luni 0%

Data: 21 august 2026

## Problema

Rata la 0% costa comisionul catre banca. Daca rata se calculeaza din pretul de
vanzare cash (`PRICE1`), la produsele "sensibile" (adaos mic) vanzarea in rate
iese in pierdere. Solutia (modelul ultra.md): un **pret de vanzare in rate**,
separat, care poate fi mai mare decat pretul cash.

Referinta vizuala: `https://ultra.md/product/refrdd-starcrest-srf-86bk`
- pret integral: 2 999 lei
- in rate: **3 149 lei**, 0%, 8 luni, 394 lei/luna

## Decizii

1. **Formula, pentru toate produsele, calculata automat**:

       pret_rate_0 = MAX( PRICE1,                  -- pretul cash de site
                          PRICE7 in MDL * 1.16 )   -- costul + 16%

   `PRICE7 * 1.16` garanteaza ca ratele 0% raman peste pragul de adaos care
   acopera comisionul bancii, inclusiv la produsele sensibile unde `PRICE1` e
   prea aproape de cost. Nu exista completare manuala si nici override.

2. **Coloana**: se refoloseste `TS_GOODS_FOREIGN.PRICE_CREDIT0` ca **coloana
   `COMPUTED BY`**. Exista deja in baza ca simpla coloana de date, e goala
   (0 randuri cu valoare din 285 783) si nu era referita nicaieri, deci poate fi
   stearsa si recreata calculata fara pierdere de date.

   `COMPUTED BY` (in loc de o valoare stocata intretinuta de trigger) pentru ca
   valoarea depinde si de cursul valutar: stocata s-ar invechi la fiecare
   modificare de curs, fara ca randul sa fie atins.

3. **Perioada**: 6 luni, dobanda 0% - constante in procedura, nu in date.

4. **Doua niveluri de calcul, deliberat**:
   - **pe rand** (coloana calculata): `max(PRICE1, PRICE7 * curs * 1.16)` al
     randului respectiv - serveste afisarii pe furnizor in WMS, la fel ca
     `PRICE7_LEI`, `DIFF47` etc.;
   - **pe produs** (`GET_GOODS_PRICE_CREDIT0`): foloseste aceleasi proceduri ca
     restul site-ului - `GET_GOODS_PRICE(goodsid, 1, 498)` pentru pretul cash si
     `GET_GOODS_PRICE7(goodsid, 498)` pentru cost - ca sa fie coerent cu pretul
     si marja afisate pe site. Aceasta e sursa de adevar pentru fantastic.md.

5. **Vizibilitate**: optiunea 6 luni 0% apare la **orice produs cu pret**.
   Consecinta secundara: `FLG_CREDIT0` din `GET_GOODS_LIST_BY_CATALOG_V2`
   (azi mereu 0) devine 1 - consumatorii lui din fantastic.web sunt comentati,
   deci nu apare nimic neintentionat in listinguri.

6. **Unde traieste procentul 1.16**: definitia coloanei calculate,
   `GET_GOODS_PRICE_CREDIT0` si constanta `cCredit0CostMarkup` din
   `frmGoodsForeignCodeEditorDialog.pas` (doar pentru eticheta informativa).

## A. Baza de date - `DB Model/goods_foreign_price_credit0.sql` (repetabil)

1. `TS_GOODS_FOREIGN.PRICE_CREDIT0` devine `COMPUTED BY`:
   se sterge daca exista ca simpla coloana de date (verificare prin
   `RDB$FIELDS.RDB$COMPUTED_SOURCE`), apoi se adauga calculata. La rulari
   repetate ramura de DROP nu se mai executa, deci scriptul e sigur de reluat.
2. `CREATE OR ALTER VIEW VW_TS_GOODS_FOREIGN` - expune `PRICE_CREDIT0` la coada.
   Lista de coloane se scrie explicit (view-ul are deja lista explicita, cu
   nume care difera de aliasurile din SELECT: `PRICE4MDL`, `PRICE5LEI`, ...).
   Triggerele view-ului **nu** se modifica: o coloana calculata nu se scrie.
3. `CREATE OR ALTER PROCEDURE GET_GOODS_FOREIGN` - iesire noua `PRICE_CREDIT0`.
   Dialogul Delphi face `select V.*`, deci apare automat in grid.
4. `CREATE OR ALTER PROCEDURE GET_GOODS_PRICE_CREDIT0(GOODSID)` -> `PRICE_MDL`:
   `MAX(GET_GOODS_PRICE(.., 1, 498), round(GET_GOODS_PRICE7(.., 498) * 1.16))`.
   Intoarce 0 daca produsul nu are pret cash.
5. `CREATE OR ALTER PROCEDURE WEB_GET_GOODS_CREDIT_MONTLY_RATE(GOODSID)`:
   - iesire noua `CREDIT_PRICE` (suma finantata pentru fiecare optiune);
   - rand nou, primul: 6 luni / 0% / `monthlyrate(credit_price, 6, 0)`;
   - randurile existente 12/24/36/48 la 2% raman, cu `CREDIT_PRICE = price1_lei`.

Rollback: `DB Model/goods_foreign_price_credit0_rollback.sql` readuce view-ul si
procedurile la definitiile de dinainte, sterge `GET_GOODS_PRICE_CREDIT0` si
reface `PRICE_CREDIT0` ca simpla coloana de date, goala.

## B. WMS / Delphi

### `sources/classes/Goods/frmGoodsForeignCodeDialog.dfm` + `.pas`
- Coloana noua in banda "Preturi si valuta": `TV1_PRICE_CREDIT0`, caption
  `Rate 0%`, field `PRICE_CREDIT0`, `Options.Editing = False`.
- `SQLInsert` / `SQLUpdate` raman neatinse - coloana calculata nu se scrie.

### `sources/classes/Goods/frmGoodsForeignCodeEditorDialog.dfm` + `.pas`
- Camp `cePriceCredit0: TcxDBCalcEdit` legat de `PRICE_CREDIT0`, `ReadOnly`,
  fara `TabStop`, cu eticheta `Rate 0% | 6 luni`, pe un rand nou in `Panel1`.
- Eticheta `lbCredit0Info` explica din ce s-a compus valoarea (`= Web` sau
  `= Indicativ +16%`) si arata rata lunara.
- `Panel1.Height` 193 -> 232, `pnClient.Height` 434 -> 473,
  `ClientHeight` 554 -> 593, butoanele de jos `Top` 517 -> 556.

Codificare: `frmGoodsForeignCodeDialog.pas` e UTF-8 cu BOM,
`frmGoodsForeignCodeEditorDialog.pas` si ambele `.dfm` sunt ASCII - textele noi
in `.dfm` se scriu ASCII, fara diacritice.

## C. fantastic.web

1. `models/CreditsType.php`
   - `getGoodsCredits()` returneaza si `credit_price`;
   - metoda noua `pickZeroPercentOffer($creditOptions)` - extrage optiunea 0%
     din randurile deja citite (plus `getZeroPercentOffer($productId)` care
     citeste singura din baza).
2. `controllers/SiteController.php` - ambele `render('product', ...)` primesc
   `zeroCreditOffer`, derivat din `$creditOptions` deja incarcat (fara query in plus).
3. `views/site/product.php` - in coloana din dreapta a blocului de preturi,
   sub "Rate lunare de la", un bloc `Rate 0% - 6 luni` cu rata lunara si, cand
   suma finantata depaseste pretul cash, pretul in rate afisat explicit.
4. `widgets/productCredits/ProductCredits.php` - cumuleaza `credit_price` peste
   produsele din cos, separat de pretul cash.
5. `widgets/productCredits/views/productCredits.php` - fiecare optiune poarta
   `data-creditprice` si isi afiseaza suma finantata cand difera de total.
6. `widgets/productCredits/js/script.js` - la selectarea unei optiuni,
   `txtMoney` ia `data-creditprice` (altfel cererea de finantare ar pleca cu
   pretul cash, nu cu cel in rate).
7. `helpers/TranslatesHelper.php` - chei noi `rate_0_luni`, `pret_in_rate`,
   `pe_luna`, `suma_finantata`.

## D. Verificare

- SQL: rulare `goods_foreign_price_credit0.sql`, apoi control prin
  `RDB$RELATION_FIELDS` / `RDB$FIELDS.RDB$COMPUTED_SOURCE` /
  `RDB$PROCEDURE_PARAMETERS`; test pe un produs cu adaos normal si pe unul cu
  adaos mic, unde `PRICE7 * 1.16` trebuie sa bata `PRICE1`.
- Delphi: `msbuild sources/SWN.dproj /p:Config=Release /p:Platform=Win32`.
- PHP: `php -l` pe fisierele modificate, `node --check` pe JS.
- Numarul de octeti >= 0x80 inainte/dupa scriere, pentru fiecare fisier atins.

## D2. Verificare pe produsele in promotie (21 august 2026)

Intrebarea: se aplica pragul de 16% si produselor in promotie?

**Da, si acolo se aplica cel mai des.** Nu exista nicio ramura care sa ocoleasca
promotiile: `GET_GOODS_PRICE_CREDIT0` si coloana calculata nu stiu nimic despre
ele.

Baza de calcul este corecta: `GET_GOODS_PRICE(goodsid, 1, 498)` intoarce chiar
pretul de vinzare al site-ului. `WEB_GET_GOODS_MIN_INFO` il pune direct in
`PRICE1_LEI`, iar pagina il foloseste ca pret curent si ca `data-price` pe
butonul de comanda. Reducerea din promotie e deja inclusa in `PRICE1`:
`w_get_discount_value` intoarce doar **suma** reducerii, pe care pagina o
**aduna inapoi** ca sa afiseze pretul taiat (`oldPrice = price1_lei + discount`).
Nicaieri in cos nu se mai scade o data.

Cifre pe datele reale:

| | produse | prag 16% activ |
|---|---|---|
| in promotie activa | 341 | **272 (80%)** |
| tot catalogul de site | 47 549 randuri | 10 192 (21%) |

Din cele 341 de produse in promotie, **136 se vind sub cost**. Exemple:

    g=227117  cash 159   cost 469   -> rate 544  (91 lei/luna)
    g=159222  cash 690   cost 782   -> rate 907  (151 lei/luna)
    g=203936  cash 12190 cost 12774 -> rate 14818 (2470 lei/luna)

**Cazuri extreme de semnalat**: la 11 produse in promotie pretul de rate e peste
1.5x pretul cash, la 4 peste 2x (pe tot catalogul: 22, respectiv 6 - deci
extremele sunt aproape numai in promotii). Sunt corecte conform regulii, dar pe
pagina apar ca diferente mari intre "pret integral" si "pret in rate". Daca se
doreste, se poate adauga un plafon (de ex. `min(rezultat, PRICE1 * 1.5)`) intr-un
singur loc: `GET_GOODS_PRICE_CREDIT0` plus definitia coloanei calculate.

**`PROMO_PRICE7` (cost promotional de la furnizor) nu influenteaza nimic**: e
setat pe doar 25 de randuri active si in toate e egal cu `PRICE7`, deci faptul ca
`GET_GOODS_PRICE7` il ignora nu schimba niciun rezultat.

## E. Stare implementare (21 august 2026)

**DDL rulat si verificat pe `SW`.**

Verificari facute dupa rulare:

- `TS_GOODS_FOREIGN.PRICE_CREDIT0` are `RDB$COMPUTED_SOURCE` cu expresia
  asteptata; `VW_TS_GOODS_FOREIGN` o expune pe pozitia 52; `GET_GOODS_FOREIGN`
  o intoarce ca parametru de iesire 53; `GET_GOODS_PRICE_CREDIT0` exista;
  `WEB_GET_GOODS_CREDIT_MONTLY_RATE` are iesirea `CREDIT_PRICE`.
- Produs cu adaos mic (336348): cash 3135, cost 2719 -> `PRICE_CREDIT0` = 3154
  (= 2719 * 1.16). `WEB_GET_GOODS_CREDIT_MONTLY_RATE` intoarce primul rand
  `6 luni / 0% / 526 lei pe luna / suma finantata 3154`; randurile la 2% raman
  finantate la 3135.
- Produs cu adaos normal (336346): cash 24499, cost 19999 -> 19999 * 1.16 =
  23199 < 24499, deci `PRICE_CREDIT0` = 24499 = pretul cash; 6 luni 0% =
  4083 lei pe luna.
- Produs inexistent / fara pret: `GET_GOODS_PRICE_CREDIT0` intoarce 0, deci
  niciun rand cu 0%.
- `GET_GOODS_FOREIGN(336348)` si `VW_TS_GOODS_FOREIGN` intorc amindoua 3154.

**Impact comercial masurat:** din 47 549 de randuri active cu pret, **10 192
(~21%)** au pretul de rate peste pretul cash - exact produsele sensibile.
Restul primesc 0% la acelasi pret ca la plata integrala.

Delphi si fantastic.web:

- Compilare `SWN.dproj` - fara erori (link-ul cade cu F2039 pentru ca `SWN.exe`
  ruleaza; `.dcu`-urile sunt regenerate).
- fantastic.web: `php -l` si `node --check` trec pe toate fisierele modificate.

Ramas de facut:

1. Relink `SWN.exe` cu aplicatia inchisa, apoi distribuit prin updater.
2. Deploy fantastic.web + golirea `web/assets` ca sa se serveasca noul
   `script.js` al widgetului de credite.
