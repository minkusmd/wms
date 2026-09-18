# Plan: integrarea modulului Deals (TDB_DEALS / TDB_DEAL_DOCS / TS_DEAL_STATES) in fluxul de documente

Data: 2026-09-17. Documente vizate: Web-Order (134), Oferta (115), Proforma (101), Vanzare (107),
Factura fiscala eliberata (112), casa (116 incasare, 117 plata), banca (120 incasare, 119/1199 plata).

## 0. Stare implementare (17 sep 2026)

Decizii luate: (1) vanzarea/proforma directa creeaza deal `DIRECT_SALE`; (2) backfill de la 2026-01-01;
(3) `TDB_DEAL_DOCS.LINK_SUM` adaugat, NULL = suma integrala a documentului; (4) `SHOP_ID` ramane NULL;
(5) oferte paralele = deal-uri separate, unire manuala (`SP_DEAL_MERGE`).

- **Faza 1 - GATA, testata pe o baza locala, NERULATA pe SW**: `DB Model/deals_integration.sql`.
  Pasii de punere in productie sunt in antetul scriptului (script -> backfill -> verificare log ->
  activare triggere -> backfill din nou). In plus fata de plan:
  - `V_DEAL_ANALYTICS` a fost RESCRIS: versiunea din baza lua semnul din bitul 4 al `TS_DOCTYPES.FLAGS`
    (-1 la vanzare/proforma, +1 la retur/incasare), deci restul de plata si marja ieseau gresite;
  - trigger `TDB_DOCS_BD_DEAL` (mereu activ): `FK_DD_DOC` nu are cascada, iar fara el stergerea FIZICA
    a unui document legat ar fi fost refuzata;
  - rutinele ruleaza `SQL SECURITY DEFINER` (server 5.0.4) - site-ul (WEBUSER) nu are nevoie de drepturi;
  - "Livrat" (`DLV_DELIVERED`) se pune manual: in documente nu exista un semn sigur al livrarii.
- **Faza 2 - iteratia 1 GATA, compileaza** (link-ul a picat doar pe F2039, SWN.exe rula; netestat in
  aplicatie, fiindca schema nu e inca pe SW): `sources/classes/Deals/` = `SWNDealsUnit`,
  `frmDealCardDialog` (fisa: stari manuale + blocare, documente, istoric, nota, legare / scoatere
  document, unire deal-uri), `frmDealsBrowserDialog` (lista cu filtre; si mod "alege deal").
  Meniu **Utile > Deal-uri** si **Utile > Deal-ul documentului curent** - al doilea merge in orice frame
  (toate lucreaza cu `dmDB.IBCQueryDocs`), deci frame-urile NU au fost modificate. Pentru o plata fara
  lant propune legarea manuala de un deal deschis al clientului, cu suma atribuita (`LINK_SUM`).
  Meniurile sunt ascunse pana cand scriptul e rulat pe baza (`DealsAvailable`).
- **Coloanele "Deal" + "Stare deal" in gridurile documentelor - GATA, compileaza**: doua campuri calculate
  (`DEAL_ID`, `DEAL_STATE`) in SQL-ul comun `dmDB.IBCQueryDocs` (`DataModuleDB.dfm`, SQL + SQLRefresh) si
  `AddDealColumns(view)` din `SWNDealsUnit`, apelat in frame-urile 24, 08, 18, 10, 25, 01, 02, 04, 06, 07
  imediat dupa legarea gridului de `dmDB.IBCDataSourceDocs`. Coloanele apar la capatul gridului si sunt
  goale pana cand exista deal-uri (script + backfill pe SW).
- **Productie (17 sep 2026 seara)**: scriptul + backfill rulate pe SW (2801 deal-uri, 5501 legaturi, 0 erori),
  triggerele AI / AU / DELIVERY ACTIVE. Marja din `V_DEAL_ANALYTICS` e NULL (in 107 `TDB_JURNAL.COST` =
  pretul de vanzare); profitul se calculeaza doar in fisa deal-ului cu `SP_GET_PROFIT_BY_DOCID_WO_VAT`.
- **Faza 3 - GATA in cod, testata local, compilata; obiectele noi NU sunt inca pe SW** (scriptul trebuie
  re-rulat): `SP_DEAL_GET_BALANCE`, `SP_DEAL_MATCH_PAYMENT` (incasare 116/120 fara lant -> se leaga singura
  doar daca platitorul are exact un deal deschis cu rest de plata = suma; apelata si din
  `SP_DEAL_ATTACH_DOC`, deci din trigger), `SP_DEAL_MATCH_PAYMENTS(data)` in masa, view `VW_DEAL_PAYMENTS`.
  WMS: **Utile > Incasari nelegate de deal-uri** (`frmDealPaymentsDialog`): potrivire automata + "Adauga
  deal..." cu suma atribuita, pentru platile agregate. Analiza pe SW: din 236 incasari bancare nelegate,
  67 (+1 de casa) se potrivesc exact; 143 sunt plati agregate fara deal propriu - MAIB (carduri, 50 plati /
  518 mii lei), Easy Credit, Microinvest, Iute Credit, curierii EVS Express / Prime Store (ramburs).
- **Ramas**: flag-uri de securitate dedicate, regula de expirare a ofertelor fara vanzare (de decis termenul), faza 3 (potrivire automata la importul
  extrasului bancar, raportul incasarilor nelegate), faza 4 (site).

## 1. Starea actuala (verificata in baza SW si in cod)

Baza:
- Exista: `TDB_DEALS` (0 randuri), `TDB_DEAL_DOCS` (0 randuri), `TS_DEAL_STATES` (28 stari, 4 axe:
  PIPE / PAY / FIN / DLV), trigger `TDB_DEALS_BI`, view `V_DEAL_ANALYTICS` (sume proforma, vanzare,
  retur, incasari casa+banca, cost, marja, BALANCE_DUE pe deal).
- Proceduri: `SP_DEAL_GET_STATE_ID`, `SP_DEAL_CREATE_FROM_SITE_CART`, `SP_DEAL_CREATE_FROM_FIN_REQUEST`,
  `SP_DEAL_CREATE_MANUAL_OFFER`, `SP_DEAL_BIND_DOC` (deduce LINK_TYPE din DOCTYPEID).
- Lipsesc: avansarea starilor, inchiderea deal-ului (`CLOSED_AT` / `CLOSED_RESULT`), istoricul starilor,
  index pe `TDB_DEAL_DOCS(DOCID)`, orice apelant.

Lantul real de documente (2026, din `TDB_DOCS.PARENTDOCID`):

| Copil | Parinte | Nr. |
|---|---|---|
| 115 Oferta | 134 Web-Order | 574 |
| 115 Oferta | fara parinte (oferta manuala) | 1556 |
| 115 Oferta | 1791 Cerere de finantare | 30 |
| 101 Proforma | 115 | 257 |
| 107 Vanzare | 115 | 638 |
| 107 Vanzare | 101 | 96 |
| 112 Factura fiscala | 107 | 514 |
| 116 Incasare casa | 107 | 318 (din 320) |
| 120 Incasare banca | 107 / 112 / 134 / 101 | 77 (din 313) |
| 120 Incasare banca | fara parinte (import extras) | 236 |

Concluzii:
- Radacinile lantului corespund exact celor 3 surse existente: 134 -> `SITE_CART_ORDER`,
  1791 -> `FINANCE_REQUEST`, 115 fara parinte -> `MANUAL_OFFER`.
- `PARENTDOCID` e setat chiar in `INSERT INTO TDB_DOCS` (verificat in `SP_CREATE_RASHOD`, `SP_CREATE_PKO`).
- "Fara parinte" = `PARENTDOCID` indica un DOCID inexistent (nu NULL, nu 0) -> se testeaza cu LEFT JOIN.

Cod:
- Documentele-copil se creeaza prin proceduri din baza, apelate din `DataModuleDB.pas`
  (`SP_CREATE_CONFIGURATOR`, `SP_CREATE_PROFORMA_INVOICE`, `SP_CREATE_RASHOD`, `SP_CREATE_FISCAL_INVOICE`,
  `SP_CREATE_PKO`, `SP_CREATE_PRIHOD_DENEG_NA_SCET`, `SP_CLONE_DOCUMENT`).
- Web-Order-ul e scris direct de site (`WEB_CREATE_TRANSACTION3`, `WEB_CREATE_TRANSACTION2_ECOMM`,
  `WEB_CREATE_TRANSACTION_PHONE2`, `SP_WEB_REGISTER_FINANTARE`); WMS nu are importator.
- Documentele noi manuale trec toate prin `dmDB.IBCQueryDocs` (`INSERT INTO VW_TDB_DOCS`).
- Singura urma de "deal" in Delphi: componenta moarta `IBCQuery1` din `frmConfigurationDocDialog.dfm:813`.

## 2. Decizia de arhitectura

**Algoritmul se implementeaza in baza (trigger + proceduri), nu in Delphi.** Motiv: documentele apar din
3 canale (WMS, site PHP, proceduri `SP_CREATE_*`); un singur punct in baza le acopera pe toate, fara a
modifica ~15 proceduri si ~10 frame-uri. Delphi primeste doar interfata (vizualizare, stari manuale,
legare manuala a platilor).

## 3. Algoritmul

`SP_DEAL_ATTACH_DOC(A_DOCID, A_USER_ID)` - apelata din trigger la fiecare document nou din tipurile vizate:

1. Daca documentul e deja in `TDB_DEAL_DOCS` -> iesire.
2. Urca pe `PARENTDOCID` (max. 10 niveluri) pana gaseste un stramos legat de un deal.
   Gasit -> `SP_DEAL_BIND_DOC(deal, doc)`.
3. Negasit si documentul e radacina:
   - 134 -> `SP_DEAL_CREATE_FROM_SITE_CART` (SOURCE_REF = DOCID, contact din document,
     livrare din `TDB_DOCS_DELIVERY`);
   - 1791 -> `SP_DEAL_CREATE_FROM_FIN_REQUEST`;
   - 115 -> `SP_DEAL_CREATE_MANUAL_OFFER`;
   - 101 / 107 fara lant -> deal nou cu sursa noua `DIRECT_SALE` (vezi intrebarea 1);
   apoi bind.
4. Negasit si documentul e de plata (116/117/119/120/1199) fara parinte -> NU se creeaza deal;
   ramane nelegat, pentru legare manuala / potrivire automata (faza 3).
5. La final: `SP_DEAL_RECALC_STATES(deal)`.

`SP_DEAL_RECALC_STATES(A_DEAL_ID)` - stari derivate din documente (nu suprascrie stari finale sau
setate manual cu flag de blocare):

| Axa | Regula |
|---|---|
| PAY | din `V_DEAL_ANALYTICS`: PAID_SUM = 0 -> `PAY_WAITING`; 0 < PAID < total -> `PAY_PARTIAL`; PAID >= total -> `PAY_PAID`; deal finantat integral -> `PAY_NONE` |
| PIPE | doar 134 -> `PIPE_WAITING_CHECK`; exista 115/101 -> `PIPE_IN_WORK`; exista 107 -> `PIPE_READY_TO_SHIP`; DLV in tranzit -> `PIPE_ON_DELIVERY`; DLV livrat -> `PIPE_DELIVERED` |
| DLV | din `TDB_DOCS_DELIVERY` / `TDB_DOCS_SHIPMENT` ale vanzarii: `DLV_NONE` / `DLV_PICKUP` / `DLV_PREPARING` / `DLV_IN_TRANSIT` / `DLV_DELIVERED` |
| FIN | 1791 in lant -> `FIN_REQUESTED`; restul tranzitiilor manual (raspunsul bancii) |
| Inchidere | `PIPE_DELIVERED` + (`PAY_PAID` sau `FIN_DISBURSED`) -> `CLOSED_AT`, `CLOSED_RESULT = 'SUCCESS'`; toate documentele sterse sau anulare manuala -> `PIPE_CANCELLED_*`, `CLOSED_RESULT = 'CANCEL'` |

Evenimente care declanseaza recalcularea: INSERT document, schimbare `PARENTDOCID`, `DELETED_DATE`,
`SUMA`, `STATEID` pe un document legat; modificari in `TDB_DOCS_DELIVERY`.

## 4. Faze

### Faza 0 - decizii (inainte de cod) - vezi sectiunea 6

### Faza 1 - baza de date: `DB Model/deals_integration.sql` (re-rulabil, pentru DBA)
1. Index `TDB_DEAL_DOCS(DOCID)`; `TDB_DEAL_HISTORY` (DEAL_ID, GROUP_CODE, OLD/NEW_STATE_ID, CHANGED_AT,
   CHANGED_BY, SOURCE = AUTO/MANUAL); `TDB_DEAL_LOG` pentru erorile din trigger.
2. `SP_DEAL_FIND_BY_DOC`, `SP_DEAL_ATTACH_DOC`, `SP_DEAL_RECALC_STATES`,
   `SP_DEAL_SET_STATE` (manual, valideaza ca starea apartine axei), `SP_DEAL_CLOSE`,
   `SP_DEAL_UNBIND_DOC`, `SP_DEAL_MERGE` (doua deal-uri ale aceluiasi client).
3. Extindere `SP_DEAL_BIND_DOC`: 117 -> `DEAL_TO_CASHOUT`, 119/1199 -> `DEAL_TO_BANKOUT`, 1791 -> `DEAL_TO_FIN_REQUEST`;
   extindere `V_DEAL_ANALYTICS` cu restituirile catre client (scad din PAID_SUM).
4. Triggere `TDB_DOCS_AI_DEAL` / `TDB_DOCS_AU_DEAL` (pozitie mare, dupa cele existente), filtrate pe
   lista de DOCTYPEID; corpul in `WHEN ANY DO` cu scriere in `TDB_DEAL_LOG` - **o eroare in modulul
   deals nu are voie sa blocheze o vanzare**. Create initial INACTIVE.
5. `SP_DEAL_BACKFILL(A_DATE_FROM)` - parcurge cronologic documentele existente prin acelasi
   `SP_DEAL_ATTACH_DOC`.
6. View `VW_DEALS_BROWSER` (deal + titlurile celor 4 stari + campurile din `V_DEAL_ANALYTICS`).

Ordinea de punere in productie: DDL cu triggere inactive -> backfill pe o copie locala -> verificare
cifre -> backfill pe SW -> activare triggere.

### Faza 2 - WMS (Delphi), folder nou `sources/classes/Deals/` (fisiere ASCII)
1. `DealsUnit.pas` - wrappere peste `SP_DEAL_*` (dupa modelul din `DataModuleDB.pas`).
2. `frmDealCardDialog` - fisa deal-ului: contact, 4 combobox-uri de stare (din `TS_DEAL_STATES` pe
   `GROUP_CODE`), lista documentelor legate (dublu-click deschide documentul), totaluri din
   `V_DEAL_ANALYTICS`, istoric, nota, motiv anulare.
3. `frameDealsUnit` - browser/voronka: grid cxGrid peste `VW_DEALS_BROWSER`, filtre pe stari, operator,
   perioada, "doar deschise", "cu rest de plata". Inregistrare in `SWN.dpr` + rand in `TS_DOCTYPES`.
4. In cele 7 frame-uri (`frame24WebZakaz`, `frame08Configuration`, `frame18SciotNaOplatu`,
   `frame10NakladnieRN`, `frame25ScetFaktura`, `frame01CasaPKO`, `frame04BankPDNS` + 02/06/07):
   coloana "Deal" (nr. + stare PIPE) in SELECT-ul gridului si actiunea "Deschide deal-ul".
5. Stergere `IBCQuery1` din `frmConfigurationDocDialog`.
6. Flag-uri de securitate: vizualizare deal-uri / schimbare manuala stari / legare-dezlegare documente.

### Faza 3 - banca si casa (cazul greu: 236 din 313 incasari bancare fara parinte)
1. Dialog "Leaga de deal" in `frame04BankPDNS` / `frame01CasaPKO`: cauta deal-urile deschise ale
   clientului (`CT`/`CUSTOMERID` din `TDB_DOCS_BANKS`) cu `BALANCE_DUE > 0`.
2. Potrivire automata la importul extrasului (tip 3333 / 3328 "Distribuire intrari bancare"):
   un singur deal deschis al clientului cu rest = suma -> legare automata; altfel propunere.
3. Raport "Incasari nelegate de niciun deal".

### Faza 4 - site (fantastic.web) - optional, nimic obligatoriu
Trigger-ul creeaza deja deal-ul la Web-Order. Optional: metoda/adresa de livrare si UTM in deal,
starea deal-ului in contul clientului.

### Faza 5 - testare si lansare
Copie locala a bazei; scenarii: site -> oferta -> vanzare -> factura -> casa; oferta manuala -> proforma
-> banca partial -> vanzare; cerere finantare; retur 110; stergere document; clonare; doua oferte din
acelasi Web-Order; masurare timp INSERT in `TDB_DOCS` cu trigger activ.

## 5. Riscuri
- Trigger pe cea mai incarcata tabela: filtrare pe DOCTYPEID, fara agregari grele la INSERT
  (`V_DEAL_ANALYTICS` doar pentru un DEAL_ID), erori izolate.
- O plata care acopera mai multe vanzari: PK `(DEAL_ID, DOCID)` permite legarea la mai multe deal-uri,
  dar suma s-ar numara integral in fiecare -> necesita coloana `LINK_SUM` (intrebarea 3).
- `TDB_DEALS.CONTACTID` e NOT NULL: de confirmat din ce coloana a documentului se ia clientul pentru
  fiecare tip (DT/CT difera intre vanzare si incasare).
- `SHOP_ID` nu are echivalent in cod (cel mai apropiat: `DTSC`).

## 6. Intrebari deschise
1. Vanzarea/proforma directa, fara oferta sau Web-Order: cream deal (`DIRECT_SALE`) sau ramane in afara
   modulului? Recomandat: cream, altfel analitica pe deal-uri e incompleta.
2. Backfill de la ce data? Recomandat: 2026-01-01 (aprox. 5300 documente).
3. Plata pentru mai multe vanzari: adaugam `LINK_SUM` in `TDB_DEAL_DOCS`?
4. Ce inseamna `SHOP_ID` (DTSC / magazinul operatorului / magazinul web)?
5. Un client cu mai multe oferte paralele: deal-uri separate (implicit) sau unire manuala?

## 7. Estimare
Faza 1: 3-4 zile; faza 2: 4-5 zile; faza 3: 2-3 zile; faza 5: 2 zile. Faza 4 separat.
