# Plan: eliminarea TDB_DOCS.STATEID (starea documentului) si mutarea informatiei in deal

Data: 2026-09-18. Decizie user: varianta B - eliminare completa, cu migrarea starilor utile in TDB_DEALS.

## 0. Stare (18 sep 2026, ~15:50)

- Backup complet: NU facut - baza SW are 460 GB (d:\data\sw5.fdb), nu incape local; trebuie facut pe
  server (gbak -se / nbackup) de DBA, OBLIGATORIU inainte de faza 3.
- **Faza 1 - GATA pe SW** (operatorii deconectati): `deals_integration.sql` (TS_DEAL_REASONS,
  TS_DEAL_STATE_MAP, TDB_DEALS.CHANNEL_ID, SP_DEAL_SET_REASON / SET_CHANNEL / APPLY_DOC_STATE /
  MIGRATE_DOC_STATES, VW_DEALS_BROWSER cu motiv si canal, TDB_DOCS_AU_DEAL copiaza in deal starea pusa
  in WMS cat timp mai exista) + `stateid_to_deals.sql`: 428 deal-uri anulate cu motiv (241 fara stoc,
  107 refuzul clientului, 21 apel informativ...), deschise 2806 -> 2378; arhive TARC_DOCS_STATES
  (60 157 documente) si TARC_DEALS_BEFORE_STATEID (2811 deal-uri, comanda de revenire in antetul
  scriptului). Canalele: nicio stare veche de canal nu fusese folosita.
- WMS: Motiv + Canal in randul "Deal" din dialoguri (Web-Order: etapa+motiv; oferta: etapa, motiv,
  canal, finantare; cerere de finantare: finantare, etapa, motiv), randul trece pe 2 linii cand nu incap;
  motivul / canalul in fisa si in lista deal-urilor. Compilat, nelinkat (SWN.exe rula).
- **Faza 2 - GATA in cod** (compilat, nelinkat - SWN.exe rula): starea veche scoasa din dialogurile
  oferta, Web-Order, vanzare, casa (+ regula "Statutul incasarii"), cerere de finantare, din bonul fiscal
  V1 ("Alegeti tipul achitarii"), din coloanele "Stare" ale listelor (frame24, 01, 25 + coloana ascunsa
  STATUSID, 08, 93, 104, 51, frmAddGoodsToSupplierOrderDlg), din SQLInsert / SQLUpdate / SQLRefresh ale
  `dmDB.IBCQueryDocs`, `frmDocumentPreviewUnit`, `frmDocumentGeneralInfoDialog`; butonul dictionarului de
  stari scos din administrarea tipurilor de documente; `GetDefaultDocumentState` sters. Raman in proiect,
  nefolosite: `dmDB.IBCQueryDocTypeStates` si dialogurile `frmDocTypeStates*` (tabela ramane ca arhiva).
  Site: pagina de marketing afiseaza etapa deal-ului prin view-ul nou `VW_DOC_DEAL_STATE` (drept SELECT
  pentru WEBUSER, rulat pe SW); modificarea PHP e locala, necomisa, nedeployata.
- Urmeaza: distribuirea noului SWN.exe la TOTI utilizatorii, deploy site, backup server, apoi faza 3.

## 1. Inventar (verificat in baza SW si in cod)

### Ce informatie tine azi STATEID (documente 2026)
- Starea 8 "Comanda noua" = valoarea implicita (`GET_DEFAULT_STATE` -> 8, pusa de `TRG_TDB_DOCS_BI`).
  Pe aproape toate tipurile (1414 reevaluari 2191, 107 vanzari 631, 134 626, 112 532, 119 729...) nu
  poarta nicio informatie.
- Informatie reala au doar:
  - **115 oferte** - dictionarul are o clasificare in `INT_VALUE`: 1 = LID (deschisa), -1 = pas pozitiv /
    canal de vanzare, 2 = motiv de pierdere. In 2026: LID 1148, confirmare 605, fara stoc 117, apel
    informativ 21, alta cauza 10, marfa la comanda 10, scump 9, refuz credit 9, mai ieftin 8, nu ridica 4,
    nu are bani 4, livrare scumpa 2...
  - **134 Web-Order**: 71 in verificare (52), 72 refuz client (109), 73 produs indisponibil (129).
  - **1791 cerere de finantare**: refuz credit, refuzul clientului, nu raspunde, dublare, fara stoc...
  - 116 casa: "Incasat" / "livrare" - redundant cu starea de plata a deal-ului.
  - 101, 107, 112 - stari definite, practic nefolosite in 2026.
- `TLOG_DOCS_STATES` (jurnalul schimbarilor de stare) e GOL.

### Dependente in baza
| Obiect | Ce face cu STATEID |
|---|---|
| `VW_TDB_DOCS` + `VW_TDB_DOCS_BI` / `_BU` | expune STATEID si STATE_NAME; WMS scrie toate documentele prin view |
| `TRG_TDB_DOCS_BI` | pune starea implicita (`GET_DEFAULT_STATE`) |
| `TDB_DOCS_AU0` | scrie in `TLOG_DOCS_STATES` la schimbare |
| `CHECK_1195`, `RDB$12534` | constrangere / FK spre `TS_DOCTYPES_STATES` |
| `SP_CREATE_CONFIGURATOR` | Web-Order -> oferta: pune 8 pe Web-Order |
| `SP_CREATE_RASHOD` | oferta -> vanzare: pune 2 "Confirmarea clientului" pe oferta |
| `SP_CREATE_PROFORMA_INVOICE`, `SP_CREATE_TENDER` | pun STATEID = 1 |
| `SP_CREATE_PKO`, `SP_CANCEL_REZERVATION_GOODS` | copiaza / insereaza STATEID |
| `SP_CLOSE_WEBZAKAZ` | citeste STATEID |
| `SP_GET_DOCTYPE_DEFAULTS`, `GET_DEFAULT_STATE` | starea implicita (INT_VALUE = 1 / 8) |
| `SP_CREATE_FISCAL_INVOICE`, `SP_CREATE_VINZARE_PARTENER`, `SP_UPDATE_DATE_IN_DOCS` | mentiuni de verificat la rescriere |

### Dependente in WMS (niciun filtru si nicio regula pe o valoare anume a starii)
- `dmDB.IBCQueryDocs` (`DataModuleDB.dfm`): STATEID / STATE_NAME in SQLInsert, SQLUpdate, SQLRefresh;
  `IBCQueryDocTypeStates` = lista pentru combo-uri; `GetDefaultDocumentState` - cod mort.
- Alegerea starii in dialoguri: Web-Order (`frmWebZakazDocDialog` `lcbSTATEID`), vanzare (`frmRNDocDialog`
  `lcbDocumentState` + `cmbImageState`), casa (`frmPKODocDialog` - **singura regula: nu se salveaza fara
  stare**), cerere de finantare (`frmWebZaiavkaCreditDialog`), oferta (scos deja, 18 sep).
- Coloana "Stare" in liste: frame24, frame01, frame25, frame08, frame93, frame104, frame51.
- Altele: `frmReceiptPrintDialogV1` (combo pe starile 116, valoarea nu se salveaza), dictionarul
  (`frmDocTypeStatesDialog` / `...EditorDialog`, buton in `frmDocTypesEditorBrowser`), copii locale ale
  query-ului de documente (`frmDocumentPreviewUnit`, `frmAddGoodsToSupplierOrderDlgUnit`,
  `frmDocumentGeneralInfoDialog` - acesta nefolosit).

### Site
- Doar `controllers/MarketingController.php` + `views/marketing/_node.php` (pagina interna de marketing)
  afiseaza STATE_NAME. Clientii nu vad starea nicaieri.
- **Atentie:** `fantastic.web/docs/caiet-sarcini-dispecerat-curieri.html` si `courier-api-contracts.html`
  planifica sincronizarea starilor curierilor cu `TDB_DOCS.STATEID` - trebuie redirectata spre starea de
  livrare a deal-ului (DLV) / `TDB_DOCS_DELIVERY.STATEID`.

## 2. Unde se muta informatia

`TDB_DEALS` are deja coloanele `CANCEL_REASON_ID` si `FAIL_REASON_ID`, nefolosite, fara dictionar.

- Dictionar nou **`TS_DEAL_REASONS`** (REASON_ID, GROUP_CODE, CODE, TITLE_RO, TITLE_RU, SORT_ORDER,
  IS_ACTIVE): grupele `CANCEL` (motive de pierdere) si `CHANNEL` (canalul vanzarii).
- Coloana noua **`TDB_DEALS.CHANNEL_ID`** + FK-uri spre dictionar pentru `CANCEL_REASON_ID` / `CHANNEL_ID`.
- In randul "Deal" din dialogurile documentelor: lista **Motiv** (activa cand etapa e "Anulat") si, la
  oferta, lista **Canal**.

### Maparea propusa (de confirmat)
| Stare veche | Devine in deal |
|---|---|
| 8 Comanda noua (toate tipurile), 115/1 LID, 1791/24 LID | nimic (valoare implicita) |
| 115/2 Confirmarea clientului | nimic - rezulta din documentul de vanzare |
| 115/30 De sunat, 115/31 Nu ridica receptorul, 1791/27 Nu raspunde, 1791/58 De sunat, 134/71 In verificare | etapa `PIPE_CHECKING` (In verificare) |
| 115/32 Chat, 115/35 Apel, 115/52 Email, 115/66 Web | Canal: chat / apel / email / web |
| 115/3 Scump, 115/53 Mai ieftin, 115/54 Nu are bani, 115/70 Vrea azi, 115/12 Refuz credit, 115/34, 50 Termen lung, 115/67, 68 Livrare scumpa, 115/36 Apel informativ, 115/14 Alta cauza, 134/72 Refuz client, 1791/25, 12 Refuz credit, 1791/26 Refuzul clientului, 1791/61-65 | etapa `PIPE_CANCELLED_BY_CLIENT` + Motiv (acelasi text) |
| 115/13 Nu e in stoc, 115/51 Marfa la comanda, 134/73 Produs indisponibil, 1791/59, 60 | `PIPE_CANCELLED_BY_SHOP` + Motiv |
| 115/33 Dublat, 1791/28 Dublare document | `PIPE_CANCELLED_BY_SHOP` + Motiv "Dublat" (sau unire de deal-uri) |
| Refuz credit pe cererea de finantare | in plus `FIN_DECLINED` |
| 101/15-18, 107/19-23, 112/4-7, 116/37-38 | nimic (plata / livrarea sunt deja axe ale deal-ului) |

**Regula la migrarea istoricului:** motivul de pierdere se aplica deal-ului doar daca deal-ul NU are o
vanzare (107). Daca are (prima oferta pierduta, a doua vanduta), motivul ramane doar in arhiva.

## 3. Faze (ordinea conteaza)

### Faza 0 - backup
`gbak` complet al bazei SW inainte de orice pas din faza 1 (DBA / user).

### Faza 1 - deal-ul preia informatia (nedistructiv)
1. `DB Model/stateid_to_deals.sql`: `TS_DEAL_REASONS` (populat din tabelul de mai sus), `CHANNEL_ID`,
   FK-uri, `SP_DEAL_SET_REASON`; view-urile deals completate cu motivul / canalul.
2. Arhiva **`TARC_DOCS_STATES`** (DOCID, DOCTYPEID, STATEID, TITLE, ARCHIVED_AT): copie a starilor
   ne-implicite (fara 8 si LID) - informatia nu se pierde cand coloana dispare.
3. Migrarea istoricului in deal-uri dupa mapare (idempotent, cu raport: cate deal-uri schimbate).
4. WMS: Motiv + Canal in randul "Deal" din dialoguri si in fisa deal-ului; motivul si canalul in lista de
   deal-uri. Din acest moment operatorii nu mai au nevoie de STATEID.

### Faza 2 - WMS si site fara STATEID (inca nedistructiv pentru baza)
1. Scoaterea alegerii starii din cele 4 dialoguri ramase, a regulii "Statutul incasarii" din casa, a
   combo-ului din `frmReceiptPrintDialogV1`, a coloanelor "Stare" din cele 7 liste.
2. `dmDB.IBCQueryDocs` si copiile locale fara STATEID / STATE_NAME in SQLInsert / SQLUpdate / SQLRefresh.
3. Dictionarul `TS_DOCTYPES_STATES` scos din meniu (admin tipuri de documente).
4. Site: badge-ul STATE_NAME din pagina de marketing inlocuit cu etapa deal-ului.
5. **Distribuire `SWN.exe` la TOTI utilizatorii (updater)** si asteptat pana nu mai ruleaza nicio versiune
   veche: un exe vechi inca scrie STATEID prin `VW_TDB_DOCS`.

### Faza 3 - baza de date (distructiv; doar dupa faza 2 incheiata)
1. Rescrierea procedurilor din tabelul de dependente fara STATEID (cele de creare pun azi 1 / 2 / 8 -
   informatie inlocuita de etapa deal-ului).
2. `TRG_TDB_DOCS_BI` fara starea implicita, `TDB_DOCS_AU0` fara jurnal.
3. `VW_TDB_DOCS` + `_BI` / `_BU` fara STATEID / STATE_NAME (si toate view-urile / procedurile care depind de
   campurile view-ului).
4. Stergerea `CHECK_1195` / FK, a `TLOG_DOCS_STATES` (gol) si a triggerului lui, apoi
   `ALTER TABLE TDB_DOCS DROP STATEID`.
5. `TS_DOCTYPES_STATES` pastrat ca arhiva (sau sters dupa confirmare).
Ordinea se testeaza intai pe o copie restaurata din backup.

### Faza 4 - verificare
Crearea fiecarui tip de document din WMS si de pe site (cos, "Cumpara acum", cerere de finantare),
lanturile Web-Order -> oferta -> vanzare -> factura -> casa, `TDB_DEAL_LOG` gol.

## 4. Estimare
Faza 1: 1-2 zile; faza 2: 1-2 zile + timpul de distribuire a exe-ului; faza 3: 1 zi (plus test pe copie);
faza 4: 0,5 zile.
