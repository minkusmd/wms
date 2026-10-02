# Plan: politica de preturi calculata din PRICE0 (pret de achizitie) in loc de PRICE7

Data: 2 oct 2026. Stare: analiza facuta, nimic modificat in baza sau in cod.

## Scop

In `TS_GOODS_FOREIGN`:

- `PRICE0` = pretul de **achizitie** de la furnizor;
- `PRICE7` = pretul **indicativ** de achizitie (la unii furnizori mai mare decat PRICE0).

Pana acum regulile din `TPRICE_GOODSTYPE` foloseau PRICE7 ca referinta (`:vprice7`).
De acum referinta trebuie sa fie PRICE0.

## Cum functioneaza azi (SW, 2 oct 2026)

Calculul activ e **doar** in triggerul `TS_GOODS_FOREIGN_BIU` (BEFORE INSERT/UPDATE, poz. 5),
si numai pentru randurile in pret (bit 3 = FLG_IN_PRICE):

1. Politica produsului (`RULESID`) = `TWEB_CATALOG.PGT_ID` al mapei produsului
   (eroare daca produsul cade in mai multe politici).
2. `PRICE7` e suprascris: `PROMO_PRICE7` (din `GET_PROMO_PRICE7` / `TWEB_PA_GOODS`) daca > 0,
   altfel `ORD_PRICE7` (scris de `CLOSE_REEVALUARE` din pricelist).
3. **Coloana 6**: `PRICE6 = formula(:vprice7)`, unde `:vprice7` = PRICE7 in USD;
   regula se alege dupa `GETGOODSFORMULABYRULES(RULESID, 6, CUSTOMERID, PRICE7_USD)`
   - interval `round(PRICE7_USD) between MIN_VALUE and MAX_VALUE` (**intervalele sunt in USD**),
   - regula pe furnizor daca exista, altfel cea generala (SUPPLIERID = -1).
   Sare peste calcul daca FLG_DRP (bit 7) si PRICE6 > 0 (20 de randuri).
4. **Coloana 4**: `PRICE4/PRICE8` din PRICE6 (`CALCGOODSFORMULACOLUMN4`, marja minima pe PRICE6).
5. **PRICE1** (vanzare, MDL): promotie (PRICE2) > RRP cu FLG_EPP (`max(PRICE8, PRICE3)`) > PRICE4.
6. **Coloana 5**: din PRICE1 si PRICE6.

Formulele: 380 reguli pe coloana 6, toate de forma `:vprice7 * k` (k intre 1.00 si 1.40;
208 sunt pe furnizor, 172 generale). Coloanele 4/5 folosesc doar `:vprice6`/`:vprice1`
-> **nu se schimba**. Nicio regula nu compenseaza azi diferenta PRICE7 -> PRICE0 (k >= 1).

Alte obiecte:
- `TS_GOODS_FOREIGN_BIU3` - varianta veche, **inactiva**; lantul ei (`SP_GET_GPR_ID`,
  `GET_PGT_FORMULA`, `SP_UPDATE_GOODSPRICEBY_PP`, `GET_GOODS_PRICE_PGT`) nu mai e folosit de calcul.
- `CALCULATEPPGOODSID`, `SP_CALCULATE_PRICES_BY_PP` - corpul e comentat integral.
- `UPDATE_PRICES_WITH_RULE` / `RECALC_ALL_PGT` - doar "ating" randurile
  (`update ... set goodsid = goodsid`) ca sa ruleze triggerul = recalculul in masa.
- `CLOSE_REEVALUARE` scrie `PRICE0` **doar daca vine > 0** (altfel ramane valoarea veche)
  si pune `CURRENCY0ID = CURRENCY7ID` (valuta PRICE0 din pricelist e ignorata).

## Date (randuri in pret, 2 oct 2026)

48 268 randuri; PRICE0 > 0: 47 647; PRICE7 > 0: 47 515; egale: 32 829.
Doar PRICE0: 337 (azi fara baza de calcul); doar PRICE7: 205 (ar ramane fara baza).
Valutele PRICE0/PRICE7 coincid aproape peste tot (498 sau 840); 255 randuri au CURRENCY0ID NULL.

Unde difera:

| Furnizor | Active | PRICE0 != PRICE7 | PRICE7/PRICE0 | Fara RRP | Cu RRP, castiga pragul |
|---|---|---|---|---|---|
| Ultra 202294 | 10 268 | 9 720 | 1.046 | 6 039 | ~2 160 |
| Accent 198 | 2 349 | 2 344 | 1.080 | 2 309 | 34 |
| Teocom 74852 | 1 667 | 1 092 | **0.304** | 61 | ~950 |
| Comitek 1455 | 581 | 580 | 1.053 | 580 | 0 |
| Arvaliscom 292145 | 1 284 | 25 | 0.872 | 0 | 9 (in promotie) |
| altii | | 673 | | 139 | ~233 |

Estimare: ~12 000 de preturi de vanzare se schimba. La Ultra/Accent/Comitek **scad**
(costul de referinta scade cu 4-8%), daca coeficientii nu se ajusteaza.

**Teocom: PRICE0 e gresit** (ex. produs 358501: PRICE0 = 7948 MDL, PRICE7 = 120, PRICE1 = 267).
Importul Teocom pune altceva in PRICE0. Trecerea fara corectie ar urca preturile de zeci de ori.

## Decizii de luat

1. **Rezerva cand PRICE0 = 0** (205 randuri + furnizorii care nu trimit PRICE0).
   Recomandat: `baza = iif(PRICE0 > 0, PRICE0, PRICE7)`.
2. **Teocom si alte importuri cu PRICE0 nesigur.** Recomandat: corectam importul Teocom inainte;
   pana atunci furnizorul ramane pe PRICE7 (vezi 3).
3. **Comutare globala sau pe furnizor.** Variante:
   - a) global, toti furnizorii odata (simplu, risc mare);
   - b) **pe furnizor** (recomandat): lista de furnizori trecuti pe PRICE0, extinsa treptat
     (Ultra, Accent, Comitek primii). Locul flagului: `FLG_COST_IN_PRICE` din
     `TPRICE_SUPPLIERS` exista, e 0 peste tot si nu e folosit nicaieri in calcul - dar e pe
     (politica x furnizor) si numele e ambiguu; mai curat un bit nou pe furnizor sau o tabela mica.
4. **Tokenul din formule.** Variante:
   - a) se pastreaza `:vprice7` in text, dar triggerul pune in el PRICE0 (zero modificari de reguli,
     dar textul minte);
   - b) **recomandat**: se adauga `:vprice0`; regulile coloanei 6 se rescriu `:vprice7` -> `:vprice0`
     (script, cu istoric in `TPRICE_GOODSTYPE_HISTORY` prin triggerul AU). `:vprice7` ramane valid
     (= PRICE7), deci se poate pastra intentionat pe reguli de furnizor.
5. **Coeficientii.** Se pastreaza (preturile scad la Ultra/Accent/Comitek) sau se recalibreaza
   regulile acestor furnizori ca preturile sa ramana aproape la fel? Hotaraste dupa simulare (faza 1).
6. **Promotiile furnizorului** (`PROMO_PRICE7` din `TWEB_PA_GOODS.PRICE7`): azi inlocuiesc PRICE7.
   Pe PRICE0: promo-ul ramane prioritar (recomandat: `baza = PROMO_PRICE7` daca > 0) sau se ignora?
7. **Intervalele MIN/MAX** raman in USD, dar se aplica pe noua baza: produsele de la granita
   pot trece in alt interval (alt coeficient). De vazut in simulare.
8. **Ce mai ramane pe PRICE7:** marja `GET_GOODS_MARGIN`, pretul in rate `PRICE_CREDIT0`
   (`PRICE7 * 1.12`), afisajele WMS/site. Recomandat: in acest pas doar politica; restul separat.

## Decizii luate (2 oct 2026)

- **Regula de baza (finala):** PRICE0 se foloseste doar daca `0 < PRICE0 < PRICE7` (comparat in
  USD); altfel PRICE7, exact ca azi. Inlocuieste deciziile 1 si 3: **fara lista de furnizori**
  (comutarea e globala, regula protejeaza singura furnizorii cu PRICE0 > PRICE7, ex. Teocom, Arols).
- **+5% marja la fiecare grila cand se foloseste PRICE0**: pe coloana 6, rezultatul formulei se
  inmulteste cu 1.05; intervalul se alege dupa PRICE0.

## Simulare (2 oct 2026, read-only)

Script: `Python/price0_simulation/simulate_price0.py` (EXECUTE BLOCK in tranzactie READ ONLY,
aceleasi functii ca triggerul). Raport: `Python/price0_simulation/simulare_price0_2026-10-02.xlsx`
(foi: Furnizori, Politici, Detalii, Erori). 14 976 randuri (in pret, PRICE0 != PRICE7), 3 s.

Validare: calculul "azi" reproduce PRICE1 salvat la 99.7% (Ultra), 99% (Accent), 100% (Comitek,
AIEA, Arols, Elcore) - cu toleranta 2%, pentru ca preturile din baza sunt calculate la cursul USD
de atunci (ex. 17.76 pe 18 sep fata de 17.95 azi; 15 460 randuri USD nerecalculate de peste o zi).
Comparatia "azi" vs "nou" e la acelasi curs.

Efect pe PRICE1 (randuri cu PRICE7 > 0, fara erori), cu +5%:

| Furnizor | Randuri | Mediana | p10 / p90 | Total | Scad > 10% | PRICE0 suspect |
|---|---|---|---|---|---|---|
| Ultra 202294 | 10 054 | +0.4% | -2.0% / +2.2% | +0.72% | 34 | 0 |
| Accent 198 | 2 344 | -1.8% | -4.9% / +1.7% | -1.42% | 90 | 3 |
| Comitek 1455 | 580 | -0.25% | | -0.25% | 0 | 0 |
| AIEA 74995 | 469 | +0.3% | | +0.14% | 0 | 0 |
| Elcore 225846 | 80 | +2.9% | | -0.18% | 4 | 1 |
| Teocom 74852 | 1 092 | +817% | | +890% | | 1 030 |
| Arols 2169 | 113 | 0% (p90 +1487%) | | +75% | | 100 |

Erori noi (produs fara regula pentru noul interval): 0.
Ultra are 334 randuri cu PRICE7 = 0 (azi pe RRP fortat) - cu PRICE0 primesc pret din politica.

**PRICE0 suspect** = in afara 50%..150% din PRICE7 (Teocom 1030, Arols 100, cateva randuri la
Fantastic.online, Ghimnic, DMLink, Gama, Anturaj, Furnizor Prim, Euroterm).
Propunere de garda in trigger: PRICE0 se foloseste doar in acest interval, altfel PRICE7.

Recomandare de comutare: val 1 Comitek, AIEA, Elcore; val 2 Accent; val 3 Ultra.
Teocom si Arols raman pe PRICE7 pana se corecteaza importul.

**Rerulare cu regula finala `0 < PRICE0 < PRICE7`:** Ultra +0.72%, Accent -1.43%, Comitek -0.25%,
AIEA +0.14%, Elcore -0.18%, Teocom -0.35%, Arols -0.18% (total pe furnizor). Explozia Teocom/Arols
dispare. Raman ~190 scaderi > 10%, aproape toate date gresite in PRICE0:
- valuta: PRICE0 si PRICE7 cu aceeasi cifra dar CURRENCY0ID != CURRENCY7ID (ex. Ghimnic 240308
  620 MDL vs 620 USD -> -94%, Prime Store 218742 -> -90%); 9 randuri active cu valute diferite;
- PRICE0 < 50% din PRICE7: 52 randuri (Teocom 44, Accent 3, DMLink 2 -> -70%, Elcore, Arols, ...);
- PRICE0 50..80% din PRICE7: ~60 (Accent 38, Teocom 11, Ultra 8, Elcore 3) - pot fi reale.
Deschis: prag inferior (ex. PRICE0 >= 50% din PRICE7) si corectarea valutei pe cele 9 randuri.

## Plan de actiune

### Faza 0 - pregatire (fara modificari pe SW)
- Backup `TS_GOODS_FOREIGN` (coloanele de pret) si `TPRICE_GOODSTYPE`.
- Corectarea importului Teocom (de aflat ce ajunge in PRICE0) - decizia 2.
- Verificarea `CLOSE_REEVALUARE`: PRICE0 = 0 in pricelist trebuie sa se scrie 0 (nu sa pastreze
  valoarea veche) si `CURRENCY0ID` din pricelist.
- Verificarea surselor PRICE0 pe importuri (cod WMS):
  - Accent (`ApiAccentUnit.pas:436`, `frame91APIAccentUnit.pas:1027`): PRICE0 = ProductCost - corect.
  - DMLink (`B2B.DMLinkPriceListImport.pas:28-30`): NPrice -> PRICE0 "prin analogie cu Accent;
    de confirmat" - de confirmat cu furnizorul.
  - Olis, Nex, SCOP, Convel: PRICE0 = PRICE7 - neafectati.
  - Import manual (`frmPricelistImportUnit.pas:876`): coloana "Pret 0" din fisier; aici probabil
    e problema Teocom (coloana gresita in fisierul/sablonul lor).
  - Ultra: pricelist-ul se construieste in baza (`SP_ULTRA2_BUILD_PRICELIST`), nu in Delphi -
    de verificat ce pret (S / D) ajunge in PRICE0 si in PRICE7.

### Faza 1 - simulare (read-only)
- Procedura/EXECUTE BLOCK care reface calculul din `TS_GOODS_FOREIGN_BIU` pentru toate randurile
  in pret, cu baza veche si cu baza noua, fara UPDATE: PRICE6/PRICE4/PRICE1 vechi vs noi.
- Raport pe furnizor si pe politica: cate preturi se schimba, cu cat (%), care schimba intervalul,
  care cad sub RRP / sub pretul de achizitie.
- Pe baza raportului: deciziile 3, 5, 7.

### Faza 2 - STARE: RULAT PE SW 2 oct 2026

Inainte de rulare: triggerul de pe SW verificat identic cu sursa folosita; sursa originala exacta
salvata in `DB Backup/TS_GOODS_FOREIGN_BIU_before_price0_2026-10-02.sql`. Dupa rulare: sursa pe SW =
scriptul, activ, pozitia 5, BLR valid, tot 6 triggere active pe tabel. Verificare cu ROLLBACK pe 7
randuri reale (Accent, Comitek, Teocom, Ultra; PRICE0 folosit / nefolosit): PRICE6 si PRICE1 = simularea.
Recalculul in masa NU a fost rulat - preturile se schimba la urmatorul UPDATE al fiecarui rand.

Istoric:

- `DB Model/price0_pricing.sql` - `CREATE OR ALTER TRIGGER TS_GOODS_FOREIGN_BIU` cu regula finala
  (0 < PRICE0 < PRICE7, PRICE0 >= 50% din PRICE7, +5% la grila coloanei 6). Formulele din
  TPRICE_GOODSTYPE nu se schimba (`:vprice7` primeste baza aleasa).
- `DB Model/price0_pricing_rollback.sql` - triggerul exact cum e pe SW azi (comentariile rusesti traduse).
  Atentie: sursa de pe SW s-a schimbat chiar azi (linia `if (new.price0=0) then new.price0 = new.price7`);
  inainte de rulare comparati din nou cu SW.
- Test: `Python/price0_simulation/test_trigger_local.py` - baza Firebird 5 embedded temporara cu schema
  minima copiata din SW (functiile/procedurile de reguli cu sursa reala) + 760 randuri reale:
  triggerul vechi si cel nou dau exact valorile simularii pe 738/738 randuri comparate; 0 exceptii noi;
  cazuri construite OK (PRICE0 0/NULL/egal/mai mare/90%/50%/49%/alta valuta; raport PRICE6 = 0.945).
- Problema existenta (si cu triggerul de azi): produsele 378480 (Fantastic.online) si 393476 (Elcore)
  dau exceptie in `CALCGOODSFORMULACOLUMN5` - lipseste regula coloanei 5 pentru intervalul lor.
- Dupa rulare, preturile se schimba la urmatorul UPDATE al fiecarui rand. Un recalcul complet
  (`RECALC_ALL_PGT` / "Recalcula preturile") aplica si cursul USD de azi: ~+1.1% la produsele in USD
  fata de preturile salvate pe 18 sep - independent de aceasta schimbare.

### Faza 2 - schimbarea in baza (plan initial)
- `CALCGOODSFORMULACOLUMN6`: substituie si `:vprice0` (pe langa `:vprice7`).
- `TS_GOODS_FOREIGN_BIU`: baza = PRICE0 (cu regula de rezerva si promo, deciziile 1, 6) pentru
  furnizorii comutati (decizia 3); intervalul se alege dupa noua baza.
- Flagul/tabela de furnizori pe PRICE0 (decizia 3).
- Rescrierea regulilor coloanei 6 `:vprice7` -> `:vprice0` (decizia 4), cu istoric.
- Rollback: script invers + backup-ul din faza 0.

### Faza 3 - WMS (Delphi)
Calculul nu e in Delphi (`:vprice7`, `GETGOODSFORMULABYRULES` nu apar in sources\), dar:

- `classes\PricesRules\frmPriceTypesUnit.dfm:1101` - lista "produse in politica" filtreaza
  intervalele cu `get_goods_price7(g.goodsid, 840) between :MIN_VALUE and :MAX_VALUE`
  -> trebuie sa foloseasca aceeasi baza ca triggerul (altfel lista nu corespunde calculului).
  Coloanele `P7`, `p.ind ($)`, `AC = ABS(1-[p4]/[P7])` (269-288) -> de adaugat/inlocuit cu P0.
- `classes\PricesRules\frmPriceRulesEditorUnit` (dialogul regulii): nu are nicio explicatie a
  variabilelor si niciun test al formulei; validarea verifica doar ca formula nu e goala.
  De adaugat: lista variabilelor (`:vprice0`, `:vprice7`, `:vprice6`, `:vprice1`) si un buton
  "Testeaza" (evalueaza formula pe un pret dat) - util la rescrierea coeficientilor.
- `frames\frame78PriceListUnit.pas` (`DoCreateReevaluare`, 2133-2306): modul RRP e fortat cand
  PRICE7 = 0 si PRICE3 > 0 (2215), iar inregistrarea cu PRICE0/PRICE7 se face doar daca PRICE7 > 0
  (2267) -> conditiile trebuie sa tina cont si de PRICE0 (337 de randuri au doar PRICE0).
  `CURRENCY0ID := CURRENCY7ID` (2245, si `frmPricelistImportUnit.pas:896`) - pastrat daca
  furnizorii dau mereu aceeasi valuta.
- `classes\Goods\frmGoodsForeignCodeDialog`: `DIFF01`/`MARGIN01` convertesc PRICE0 cu
  CURRENCY7ID (1700, 1707), `PRICE0_LEI` cu CURRENCY0ID (1733) - de unificat. Coloana
  `P0, calc` (2017-2039) = Indicativ / coeficient pe furnizor - de vazut daca mai are rost.
- `classes\Goods\frmGoodsForeignCodeEditorDialog`: eticheta "Cost" = PRICE0 (435) - de redenumit
  "Achizitie"; butonul de marja pune `price4 = price7 * 1.2` (.pas:239) - pe baza noua.
- Etichetele "Pret 0" / "Pret 7" din frame78 si importuri - optional "Achizitie" / "Indicativ".

### Faza 4 - lansare
- Comutarea furnizorilor in ordine (ex. Comitek -> Accent -> Ultra), fiecare urmat de recalcul
  (`UPDATE_PRICES_WITH_RULE` pe politicile atinse sau update pe furnizor) in afara orelor de varf.
- Verificare dupa fiecare: preturi 0, preturi sub achizitie, diferente mari fata de simulare.
- Golirea cache-ului site-ului daca e cazul (`TWEB_CACHE_GOODS`, Meilisearch).
