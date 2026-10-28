# Politica de preturi calculata integral din PRICE0 (17-19 oct 2026)

Stare: scripturile si WMS gata, testate local pe date reale din SW. **Nimic rulat pe SW.**
Continua `plan-politica-preturi-price0-2026-10-02.md`.

## Scop

Toate preturile se calculeaza din `TS_GOODS_FOREIGN.PRICE0` (achizitie), nu din `PRICE7` (indicativ).
La furnizorii unde PRICE0 < PRICE7 marja se compenseaza in formulele regulilor (`TPRICE_GOODSTYPE`).

## Situatia pe SW (17 oct 2026)

- Triggerul activ = `DB Model/price0_suppliers.sql` (3 oct): PRICE0 doar la Accent/Ultra/Comitek, fara compensare.
- De la 3 oct userul 204 a compensat de mina: 12 reguli Accent/Comitek/Elcore marite, 16 reguli noi
  (toate cele 12 ale Ultra + 4 Accent). Pretul de vinzare B (azi) e totusi cu 2.7-4.5% sub politica dinainte de 3 oct.
- PRICE0 < PRICE7 doar la 5 furnizori: Ultra 1.039, Accent 1.059, Comitek 1.053, AIEA 1.044, Elcore 1.047
  (raport ponderat PRICE7/PRICE0). Ceilalti ~70 au PRICE0 = PRICE7. Teocom are PRICE0 corupt.

## Decizii (user, 17-19 oct 2026)

| Tema | Decizie |
|---|---|
| Baza | PRICE0 la toti furnizorii, daca 85% <= PRICE0/PRICE7 <= 150% (USD); altfel PRICE7 |
| Compensare | coeficient in formula: `:vprice7` -> `(:vprice0 * 1.05)` la Ultra, Accent, Comitek, AIEA, Elcore |
| Garda cazuta la furnizor compensat | formula compensata peste PRICE7 (+5%) - acceptat |
| Elcore | ramine compensat (105 din 185 randuri au PRICE0 = PRICE7 -> +5% acolo) |
| Regulile compensate de mina dupa 3 oct | revin la coeficientul dinainte de 3 oct, apoi x1.05; cele create dupa 3 oct se sterg (politica primeste copia regulii generale x1.05) |
| Pretul in rate 0% | max(pret, cost x 1.16), cost = PRICE0 x factorul furnizorului (cu garda) sau PRICE7 |
| Marja, flag credit 0% | pe costul real (PRICE0 cu garda) |
| Seturi | PRICE0 al setului = suma costurilor componentelor (cu factor) |
| WMS | editorul de politici filtreaza intervalele dupa cost; coloana Cost |

## Ce contine `DB Model/price0_global.sql`

1. `TPRICE_SUPPLIER_COST` (furnizor -> factor 1.05) si copia regulilor `TPRICE_GOODSTYPE_BAK_20261018`.
2. `GF_USE_PRICE0` (garda), `CALCGOODSFORMULACOLUMN6` (intelege `:vprice0` si `:vprice7`).
3. `GET_GOODS_COST(goodsid, valuta, cu_factor)`; `GET_GOODS_MARGIN`, `GET_FLG_CREDIT0`,
   `GET_GOODS_PRICE_CREDIT0`, `UPDATE_COMPLECTPRICES` pe cost; coloana calculata `PRICE_CREDIT0`.
4. `TS_GOODS_FOREIGN_BIU`: baza prin garda, fara lista de furnizori. Plus o corectie: la produsele pe RRP,
   cind regula coloanei 4 n-are marja minima, `PRICE8` iesea NULL -> `PRICE1` NULL -> exceptie in
   `CALCGOODSFORMULACOLUMN5`; acum se ia `PRICE4`. Asta elimina cele 71 de exceptii de azi din test.
5. Regulile coloanei 6: revenirea celor 28 compensate de mina (cu garda pe formula exacta de azi),
   copii proprii pentru furnizorii compensati in fiecare politica unde au produse, `x1.05`, restul `:vprice7` -> `:vprice0`.
   Re-rulabil (a doua rulare nu schimba nimic).

Revenire: `DB Model/price0_global_rollback.sql` (sursele SW din 17 oct + regulile din copie).

## Rezultat test local (`Python/price0_simulation/test_price0_global.py`, 19 oct 2026)

15 075 randuri in pret, copiate din SW. Suma PRICE1:

| Furnizor | Randuri | C vs inainte de 3 oct | C vs azi |
|---|---|---|---|
| Ultra | 10 102 | +0.75% | +3.56% |
| Accent | 2 359 | -0.69% | +3.47% |
| Comitek | 582 | -0.26% | +4.48% |
| AIEA | 467 | +0.14% | +0.14% |
| Elcore | 184 | +3.20% | +2.92% |
| Teocom | 1 092 | +1.22% | +1.22% |
| altii | 217 | -0.09% | -0.09% |

Reguli coloana 6: 396 -> 648. Exceptii trigger: azi 71, nou 0. Garda: 84/85/100/150/151%, 0, alta valuta - corecte.
Revenirea: reguli si preturi identice cu azi.

## Lansare (doar cu acordul userului)

1. Verificat din nou pe SW: triggerul = `price0_suppliers.sql`; formulele din pasii 7a/7b neschimbate
   (altfel UPDATE-urile nu prind - se vede in raportul de dupa).
2. Rulat `price0_global.sql`; verificat: nicio regula col.6 cu `:vprice7`, regulile furnizorilor compensati cu `(:vprice0 * 1.05)`.
3. Recalcul in masa (`UPDATE_PRICES_WITH_RULE` / "Recalcula preturile") in afara orelor de virf.
4. SWN.exe nou (frmPriceTypesUnit, frmGoodsForeignCodeEditorDialog); golirea cache-ului site-ului.

## Ramas in afara acestui pas

- Marjele afisate in `frmGoodsForeignCodeDialog` / `frmAddGoodsToSupplierOrderDlgUnit` (MARGIN17.. pe PRICE7,
  bug de valuta la PRICE0) - fisierul avea modificari necomise ale altei sesiuni.
- `GET_FLG_CREDIT0`: conditia `PRICE1 / cost * 100 < 3` e practic mereu falsa (probabil voia marja < 3%) - neschimbata.
- Portile PRICE7 = 0 din reevaluare (frame78, Parsers) si pragul 1.2 pe PRICE7 din frame08.
- Politicile noi create dupa rulare nu primesc automat copii compensate - se re-ruleaza pasul 7 al scriptului.

## 21 oct 2026: compensarea doar in politica de preturi

Cazul 322279 (Ultra 205740): PRICE1 = 6891 in loc de 6563 = PRICE0 x 1.02 x 1.06, pentru ca regula
Ultra din politica 17 "Printers" e `((:vprice0 * 1.05) * 1.02)` (compensarea x1.05 de mai sus), dar
regula nu se vedea in editor: pasul 7c a inserat regulile furnizorilor in `TPRICE_GOODSTYPE` fara
rindul din `TPRICE_SUPPLIERS` (250 de reguli / 250 de politici invizibile, aplicate totusi de
`GETGOODSFORMULABYRULES`). Decizia userului: coeficientul de compensare sta DOAR in politica de
preturi; orice alta copie se elimina.

`DB Model/price0_compensation_in_policy.sql` (+ `_rollback.sql`, test local
`Python/price0_simulation/test_compensation_in_policy.py`):

1. perechile (politica, furnizor) lipsa intra in `TPRICE_SUPPLIERS` - regulile devin vizibile/editabile;
2. `GET_GOODS_COST` fara factor (parametrul `WITH_FACTOR` ramine, ignorat);
3. `GET_GOODS_PRICE_CREDIT0`, `UPDATE_COMPLECTPRICES` si coloana `PRICE_CREDIT0` pe costul real;
4. `DROP TABLE TPRICE_SUPPLIER_COST`.

PRICE6/PRICE1 nu se schimba (formulele ramin). Scade doar pretul in rate 0% acolo unde il tinea
sus factorul: pe SW, rindurile in pret cu rata > PRICE1 scad de la 5894 la 4263 (Ultra),
1271 -> 909 (Accent), 425 -> 333 (Comitek), 253 -> 8 (AIEA), 147 -> 110 (Elcore).
Atentie: stergerea unui furnizor din politica (trigger `TPRICE_SUPPLIERS_BD`) ii sterge si regulile.
