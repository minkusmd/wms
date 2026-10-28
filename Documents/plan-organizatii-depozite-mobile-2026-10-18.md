# Organizatii, subdiviziuni, depozite si depozitele mobile ale curierilor

Data: 18 oct 2026. Stare: DDL scris si verificat pe o baza de test locala (Firebird 5, stub-urile
din `CurieriWMS/docker/firebird-test`); **nerulat pe SW**.

Script: `DB Model/org_subdiv_stocks.sql` (re-rulabil). Se sprijina pe:
- `DB Model/company_card.sql` - fisa companiei / subdiviziunii (`TS_CUST_COMPANY`);
- `Documents/plan-depozite-subdiviziuni-2026-10-02.md` - depozitele pe firma, bascula 01.10.2026
  (acest script implementeaza pasii 1, 2 si 5 de acolo);
- `Documents/plan-dispecerat-achizitii-livrari-2026-10-08.md` - masina curierului, preluarea la
  furnizor, vanzarea din masina, transferul soldului la baza (9B, 9D).

## Cerinta

- mai multe organizatii (persoane juridice), fiecare cu mai multe subdiviziuni;
- fiecare subdiviziune cu depozitele ei;
- depozite mobile = masinile curierilor: se incarca direct la furnizor si se vinde din ele fara
  ca marfa sa treaca prin depozitul de baza. **Masina apartine organizatiei** (decizia din 18.10),
  ca s-o poata folosi toate subdiviziunile ei.

## Structura

```
Organizatia          TS_CUSTOMER 4002 + TS_CUST_COMPANY.COMPANY_KIND = 1
 +- Subdiviziunea A  COMPANY_KIND = 2, PARENT_FIRMAID = organizatia
 |   +- 01 Depozit de baza      TS_STOCKS: FIRMAID = A, STOCK_KIND = 1
 |   +- 02 Retur la furnizor    TS_STOCKS: FIRMAID = A, STOCK_KIND = 1
 +- Subdiviziunea B ...
 +- Depozite mobile             TS_STOCKS: FIRMAID = organizatia, STOCK_KIND = 2
     +- Masina curierului X     TS_STOCK_VEHICLE (numar, model); TS_COURIER.STOCKID -> depozit
```

- Ierarhia are **un singur nivel**: parintele unei subdiviziuni e intotdeauna o organizatie
  (verificat in `TRG_TS_CUST_COMPANY_BIU`).
- **Stocul nu se schimba:** `TS_GOODS_STOCK` (DT, DTDEP, GOODSID). Intr-o masina comuna fiecare
  subdiviziune are soldul ei; marfa cumparata de A ramane a lui A. Ca B sa vanda marfa lui A din
  aceeasi masina, intai se face un transfer intre subdiviziuni (DT = B, CT = A, acelasi depozit).

## Ce adauga scriptul

| Obiect | Rol |
|---|---|
| `TS_STOCKS.FIRMAID` | proprietarul: subdiviziunea (stationar) sau organizatia (mobil); NULL = comun / sistem |
| `TS_STOCKS.CODE` | codul depozitului in cadrul proprietarului; unic pe (FIRMAID, CODE) |
| `TS_STOCKS.STOCK_KIND` | 1 stationar, 2 mobil |
| `TS_STOCKS.FLAGS` bit 3 | arhivat - nu mai primeste documente |
| `TS_STOCKS_FIRM_MAP` | depozit vechi -> depozit nou al firmei (bascula, rapoarte) |
| `TS_STOCK_VEHICLE` | datele masinii, 1:1 cu depozitul mobil |
| `FN_FIRM_ORG(firma)` | organizatia firmei (subdiviziune -> parinte, altfel ea insasi) |
| `FN_STOCK_ALLOWED(firma, depozit)` | regula de folosire (mai jos) |
| `SP_STOCK_CHECK_DOC` + `TRG_TDB_DOCS_STOCK_CHK`, `TRG_TDB_JURNAL_STOCK_CHK` | aplica regula pe documente |
| `TRG_TS_STOCKS_FIRM_BIU` | proprietarul = firma proprie; depozitul mobil = al organizatiei |

Depozitele din folderul 146 "Depozite mobile" primesc `STOCK_KIND = 2`; proprietarul lor
(`FIRMAID`) il completeaza utilizatorul. `SP_COURIER_CREATE_STOCK` (in `dispatch_logistics.sql`)
creeaza de acum masina direct ca depozit mobil al organizatiei, cu codul `M<STOCKID>` si randul
din `TS_STOCK_VEHICLE`. **De aceea `org_subdiv_stocks.sql` se ruleaza inaintea lui
`dispatch_logistics.sql`.**

## Regula: ce depozit poate folosi o firma

`FN_STOCK_ALLOWED(firma, depozit)`:

1. `-1` (fara depozit) - da;
2. depozit inexistent sau arhivat - nu;
3. depozit comun (`FIRMAID` NULL) - da, **doar daca firma nu are depozite proprii** (regula de
   tranzitie din planul din 02.10: firmele fara depozite proprii lucreaza ca azi);
4. depozit mobil - da, daca apartine organizatiei firmei;
5. depozit stationar - da, daca apartine chiar firmei.

Triggerele aplica regula pe antet (`TDB_DOCS`) si pe fiecare linie (`TDB_JURNAL`, linia poate avea
alt depozit decat antetul), pe latura DT si pe latura CT, numai unde firma e proprie (4002).
Nu se verifica:
- documentele datate inainte de **01.10.2026** (data de bascula) - istoria ramane cum e;
- sesiunile cu `DISSABLE_TRIGGERS = 'YES'` (bascula, migrarea);
- partenerii externi. Regula "partener extern -> depozit -1" din planul din 02.10 ramane de
  activat separat, dupa ce dialogurile WMS nu mai pun implicit depozitul 43.

**Efect imediat dupa rulare: niciunul.** Toate depozitele existente au `FIRMAID` NULL (comune), iar
o firma fara depozite proprii le poate folosi in continuare. Regula incepe sa lucreze pe masura ce
se completeaza `FIRMAID`.

## Fluxurile (tipuri de documente existente)

| Operatia | Document | Depozit |
|---|---|---|
| Achizitie de la furnizor direct in masina | 106, DT = subdiviziunea, CT = furnizorul | DTDEP = masina (`SP_CW_PICKUP_CLOSE`) |
| Incarcarea masinii din depozitul de baza | 114, in aceeasi subdiviziune | din baza in masina |
| Vanzare din masina | vanzarea obisnuita | masina, latura subdiviziunii |
| Marfa din masina trece la alta subdiviziune | 11, DT <> CT | acelasi depozit (masina) |
| Retur la furnizor din masina | 126 | masina |
| Soldul ramas, la sosirea la baza | 114, separat pe fiecare DT | din masina in `TS_DISPATCH_SETTINGS.BASE_STOCKID` al subdiviziunii (9D) |

## Verificarea facuta (baza de test locala)

Scripturile rulate in ordine: stub-uri, `company_card.sql`, `org_subdiv_stocks.sql`,
`supplier_pickup.sql`, `dispatch_logistics.sql`, apoi `org_subdiv_stocks.sql` si
`company_card.sql` inca o data (re-rulabile, fara erori). Date de test: organizatia O cu
subdiviziunile A si B, organizatia O2 cu subdiviziunea C, depozitul A-01, masina M a lui O.

- `FN_STOCK_ALLOWED`: (A, A-01) = 1, (B, A-01) = 0, (A, M) = 1, (B, M) = 1, (C, M) = 0,
  (A, -1) = 1, comun cu / fara depozite proprii = 0 / 1, arhivat = 0, inexistent = 0;
- 106 de la furnizor in masina (DT = A) - acceptat; B pe depozitul lui A - refuzat; acelasi document
  datat 01.09 - acceptat; linie pe alt depozit decat antetul - refuzata; transferul A -> B in
  masina - acceptat; subdiviziunea altei organizatii in masina - refuzat; mutarea pe un depozit
  arhivat - refuzata; `DISSABLE_TRIGGERS` - ocoleste verificarea;
- masina cu proprietar subdiviziune / furnizor - refuzata; cod duplicat la aceeasi firma -
  refuzat, acelasi cod la alta firma - acceptat; `TS_STOCK_VEHICLE` pe depozit stationar - refuzat;
- subdiviziune cu parinte subdiviziune / organizatie cu subdiviziuni devenita subdiviziune -
  refuzate;
- `SP_COURIER_CREATE_STOCK` pentru subdiviziunea A - masina cu `FIRMAID` = O, `STOCK_KIND` = 2,
  cod `M<STOCKID>`, rand in `TS_STOCK_VEHICLE`, legata de curier.

Testul a rulat ca SYSDBA: drepturile (`GRANT`) pentru utilizatorul SWN nu au fost verificate.
Triggerele reale de stoc din SW lipsesc din stub-uri.

## Pasii urmatori

1. Rularea pe o copie a SW (ordinea: `company_card.sql`, `org_subdiv_stocks.sql`, apoi
   `dispatch_logistics.sql`) si verificarea cu utilizatorul SWN.
2. Completarea proprietarilor: depozitele noi ale subdiviziunilor (bascula din planul din 02.10),
   `FIRMAID` pe masinile existente din folderul 146.
3. Obiectele care exista doar in baza: `GET_QUICK_ACCESS_STOCK` filtrat cu `FN_STOCK_ALLOWED` pe
   firma curenta (sursa din `RDB$PROCEDURE_SOURCE`).
4. WMS (Delphi): `frmStocksBrowser` cu coloanele FIRMAID / CODE / STOCK_KIND si datele masinii;
   selectorul de depozit din documente filtrat dupa regula.
