# Analiza finala si iteratia 1: dispecerat + aplicatia soferilor

Data: 2026-10-10
Plan: `Documents/plan-dispecerat-achizitii-livrari-2026-10-08.md` (etapele 1, 2, 6, 7 din §10).
DDL: `DB Model/dispatch_logistics.sql` (testat pe baza din containerul CurieriWMS, nerulat pe SW).
Aplicatia: `CurieriWMS/` (Laravel 13 + Livewire 4).

## 1. Ce am gasit in schema live (SW) si in codul WMS

Verificat doar-citire pe SW si in sursele Delphi.

| Tema | Constatare | Consecinta |
| --- | --- | --- |
| Curieri | Colaboratorii sunt `TS_CUSTOMER` cu `CUSTOMER_TYPE_ID = 4006` ("Angajati"), majoritatea in folderul 8 COLABORATORI. 4006 nu e o mapa. Soferul se alege azi fara filtru in ridicari, livrari si foile frame82. | Profil nou `TS_COURIER` legat de `TS_CUSTOMER`; dispecerul alege doar profilurile active. |
| Curierul pe livrare | `TDB_DOCS_DELIVERY.COURIERID` = firma care livreaza (316910, 218482), nu persoana; `DRIVERID` e gol in toate cele 24 772 de randuri, iar view-ul il trateaza ca `TS_SYSS`. | Sursa unica pentru curier si data = sarcinile din traseu (`TDB_DISPATCH_*`). `TDB_SUPPLIER_PICKUP.DRIVERID/PLAN_DATE` raman copii sincronizate; `TDB_DOCS_DELIVERY` nu se atinge. |
| Livrari | Un singur rand de livrare pe document (`PK DOCID`); foile frame82 (`TDB_WAYBILL`) au doar 39 de foi in 2026. | Sarcina de livrare noua `TDB_DISPATCH_DELIVERY` (permite mai multe pe comanda). Frame82 ramane neschimbat. |
| Zone | Doua clasificari de sector: `TS_SYSS` sub 2 la livrari (3668..3674, 2017) si sub 51 la adresele clientilor (7665..7671, aproape mereu goale). Nu exista coordonate GPS. | Nomenclator nou `TS_LOGISTIC_ZONE` + `TS_LOGISTIC_ZONE_MAP` (sugestii din ambele clasificari, fara alegere automata). |
| Depozite | `TS_STOCKS` nu are firma; soldul e pe (firma `DT`, depozit `DTDEP`) in `TS_GOODS_STOCK`. Nu exista legatura depozit - persoana (doar conventia "Angajat 01..10" in folderul 131). | `TS_COURIER.STOCKID` = depozitul masinii; trebuie create depozitele soferilor. |
| Documente | Factura de intrare din plan = **106 Intrare marfa**; stocul se misca la inserarea liniei, chiar cu documentul deschis. 107 = Rezerva/Vanzare, 108 = Rezerva separata. Cheia pozitiei `TDB_JURNAL` = `DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID` (fara ID de linie). | Inchiderea preluarii creeaza 106 deschis in depozitul soferului, cate unul pe furnizorul comercial, cu acelasi produs comasat pe o linie. |
| Serii/partide | `GET_AVAILABLE_PARTS` / `GET_PARTS_DEP_GOODS` accepta deja 106 deschis (rulat pe SW 09.10). `GET_AVAILABLE_SN` / `GET_SN_DEP_GOODS` cer inca documentul inchis. `FLG_READY` se recalculeaza la COMMIT doar pentru ultima linie din sesiune. | Seriile din 106 deschis trebuie activate separat (etapa 3). |
| Transfer | 114 are doi pasi: expediere (sursa scade imediat) si primire la inchidere (`FLG_READY` pe toate liniile, `BOX_COUNT > 0`). | Oprirea Depozit (9F) si sosirea la baza (9D) cer o varianta de transfer intr-o singura tranzactie (etapele 3, 9). |
| Retur | Nu exista document comercial "retur la furnizor" separat; documentul e **126 Retur bunuri catre furnizor** (misca stocul; confirmat de proprietar 2026-10-10). 1945 e act fara stoc (service). | Sarcina de retur foloseste documentul 126; iesirea efectiva o face dispecerul in WMS. |
| Plata | Modalitatea e text liber `TDB_DEALS.PAYMENT_METHOD`; achitat/rest doar pe deal (`SP_DEAL_GET_BALANCE`); plata mixta nemodelata. | Detaliul platii (9E) ramane pentru iteratia urmatoare. |
| Utilizator | Scrierea in documente cere `USER_SESSION.UserID` (CREATED_BY, perioada deschisa, `ERR_PERIOD_NO_VALID`). | `TS_DISPATCH_SETTINGS.WEB_USERID` = utilizatorul WMS tehnic sub care procedurile creeaza documente. |
| Servicii | Atributul e `TS_GOODS.GOODS_TYPE_ID`: 4202, 4204, 4212, 4217 = servicii (nu UM, nu mapa 728). | Livrarea arata serviciile separat dupa acest atribut. |

## 2. Ce s-a implementat (iteratia 1)

**Baza (`DB Model/dispatch_logistics.sql`, re-rulabil, Firebird 5):**

- Nomenclatoare: `TS_LOGISTIC_ZONE`, `TS_LOGISTIC_ZONE_MAP`, `TS_COURIER` (profil + cont web), `TS_DISPATCH_SETTINGS`, `TS_PICKUP_POINT`, `TS_COURIER_ZONE_RULE`.
- Planificare: `TDB_DISPATCH_PLAN` (ciorna/publicat/in executare/inchis), `TDB_DISPATCH_ZONE_ASSIGN`, `TDB_DISPATCH_ROUTE`, `TDB_DISPATCH_STOP`, `TDB_DISPATCH_STOP_TASK` (ridicare / retur / livrare / incarcare), `TDB_DISPATCH_DELIVERY`.
- Executare: `TDB_PICKUP_DOC` + `TDB_PICKUP_DOC_ITEM` (lista fixata), `TDB_PICKUP_PHOTO` (BLOB, istoric la refacere), `TDB_DISPATCH_LOG` (jurnal + `ACTION_UID` unic).
- Blocarea e in baza: triggerele resping modificarea pozitiilor si a ridicarilor incluse intr-o preluare inceputa, inclusiv din WMS (se permite doar nota).
- Proceduri: `SP_CW_PICKUP_START`, `SP_CW_PICKUP_ITEM_SET`, `SP_CW_PHOTO_REPLACE`, `SP_CW_PICKUP_MISSING_PHOTOS`, `SP_CW_PICKUP_CLOSE` (creeaza 106 o singura data; retransmiterea intoarce acelasi document), `SP_COURIER_WEB_ACTIVATION` (pentru WMS).
- Drepturi: `SWN` (WMS) si `CURIERI` (contul aplicatiei: citiri, proceduri, fotografii, coloanele contului web).

**Aplicatia soferilor (CurieriWMS):**

- Autentificare pe `TS_COURIER`: login + parola (bcrypt); prima parola o alege soferul cu un cod de activare de 8 cifre generat de dispecer (24 h). Sesiune "tine-ma minte", limita de incercari.
- "Traseul meu": azi + restante, filele Toate / Achizitii / Livrari cu contoare, opriri ca carduri mari cu stare punct + text, retururile evidentiate, reincarcare la 60 s si ora actualizarii.
- Oprirea: Suna / Harta (coordonate sau adresa), contact, program, nota.
  - Furnizor: pretul de achizitie x cantitate si totalul pe moneda; "Am ajuns - incep preluarea"; "Am primit tot" / "Alta cantitate" cu motiv obligatoriu; fotografii pe unitate (serie) sau o fotografie (partida), micsorate in telefon la 1600 px JPEG; "Refa"; inchiderea doar cand totul e complet; returul separat, cu total propriu.
  - Client: produsele, serviciile separat, totalurile, starea autorizarii dispecerului.
  - Depozit: lista de incarcat.
- Scenarii verificate pe baza de test: 12 (alt curier nu vede oprirea/fotografia), 13/20 (retransmiterea nu dubleaza), 17 (blocarea respinge WMS), 18 (browser inchis -> preluarea continua), 19 (fara fotografii nu se inchide), 20/32 (exact o intrare 106; esecul nu inchide nimic), 25, 43, 45.

## 2b. Iteratia 2: forma Dispecerat in WMS (etapa 4)

**Baza (adaugat in `DB Model/dispatch_logistics.sql`, re-rulabil, testat pe baza de test):**

- `SP_DISPATCH_PICKUP_ASSIGN / _UNASSIGN`, `SP_DISPATCH_DELIVERY_ASSIGN / _UNASSIGN`, `SP_DISPATCH_RETURN_ASSIGN / _UNASSIGN`: sarcina intra pe traseul curierului in ziua aleasa; planul zilei si traseul (cu oprirea Depozit prima) se creeaza la prima atribuire.
- Consolidarea opririlor (plan §7): ridicarile de la acelasi furnizor merg pe aceeasi oprire neinceputa; livrarile aceluiasi client la aceeasi adresa - la fel.
- Oprirea furnizorului ia punctul de preluare implicit (`TS_PICKUP_POINT`) sau, fara el, adresa fizica (7662) si primul telefon din fisa furnizorului.
- Livrarea copiaza adresa, telefonul si intervalul din `TDB_DOCS_DELIVERY` la prima planificare; livrarea esuata se replanifica intr-un rand nou (istoricul ramane). "Doar zona si ziua" = livrare "de planificat", fara curier.
- Inainte de publicare o sarcina scoasa se sterge; dupa publicare devine "anulata", oprirea goala "Anulata", iar versiunea planului creste - soferul vede schimbarea (scenariul 14).
- Sarcinile din preluari incepute de sofer nu se mai muta si nu se mai scot.
- `SP_DISPATCH_STOP_MOVE` (ordinea, Depozit ramane prima), `SP_DISPATCH_PLAN_PROBLEMS` (erori: oprire fara adresa, livrare fara zona, curier inactiv sau fara depozit; avertismente: curier fara cont, furnizor fara zona, ridicari/livrari neatribuite), `SP_DISPATCH_PUBLISH` (refuzata daca exista erori).
- Vederi pentru grile: `VW_DISPATCH_PICKUPS`, `VW_DISPATCH_DELIVERIES`, `VW_DISPATCH_RETURNS`, `VW_DISPATCH_ROUTES`, `VW_DISPATCH_STOPS`, `VW_TS_COURIER`.

**WMS (`sources/classes/Dispatch/`, compilat, dfm-urile verificate la incarcare):**

- Meniul "Dispecerat: achizitii si livrari" (langa "Ridicari de la furnizori") -> `TfrmDispatchDlg`: ziua (< >), starea planului, "Publica planul"; curierul si zona se aleg o data sus; paginile Achizitii, Retururi, Livrari (cu restantele neatribuite din ultimele 14 zile), Trasee (curier -> opriri, Sus/Jos), Probleme. Fiecare rand selectat = o actiune separata; refuzurile se arata la final.
- `TfrmDispatchCouriersDlg`: profilurile curierilor (doar colaboratori), depozitul masinii, login, "Cod de activare..." si setarile firmei (depozitul de baza, utilizatorul WMS al aplicatiei).
- `TfrmDispatchZonesDlg`: nomenclatorul zonelor.
- "Atribuie soferul" / "Scoate soferul" din lista "Ridicari de la furnizori" trec acum prin dispecerat (nu mai scriu direct `DRIVERID`).

Ramane pentru iteratia urmatoare: repartizarea zonelor pe curieri (pagina din plan §5 + aplicarea regulilor `TS_COURIER_ZONE_RULE`), punctele de preluare (dialog), fisa tiparita a curierului, pagina "Procesare documente" (fotografiile langa pozitiile intrarii).

## 3. Decizii luate in iteratia 1 (de confirmat)

1. **Fotografiile se pastreaza ca BLOB in Firebird** (`TDB_PICKUP_PHOTO`), ~40 KB dupa micsorare; WMS le poate afisa direct langa pozitie. Alternativa (fisiere pe serverul aplicatiei) cere un serviciu de fisiere accesibil si din WMS.
2. **Produsele fara serie/partida (4401) nu cer fotografie.** Seria individuala (4403) = o fotografie pe unitate primita; partida (4402) = una.
3. **Pretul de achizitie** = `TS_GOODS_FOREIGN.PRICE0` la furnizorul prin care se comanda (`ORDER_SUPPLIERID`), fixat la inceperea preluarii; in 106 se converteste in lei la cursul BNM.
4. **Returul (126)**: la furnizor soferul confirma cantitatea predata; documentul 126 nu e modificat automat - iesirea o finalizeaza dispecerul.
5. **Lipsurile**: soferul poate inchide cu cantitate mai mica (motiv obligatoriu); sarcina devine "problema", oprirea "Cu probleme", ridicarea cu 0 ramane atribuita.

## 4. Intrebari deschise pentru proprietar

1. ~~Tipul documentului de retur la furnizor~~ - **confirmat 2026-10-10: 126 Retur bunuri catre furnizor.**
2. Utilizatorul WMS tehnic pentru documentele create din aplicatie (`TS_DISPATCH_SETTINGS.WEB_USERID`) - unul nou ("CurieriWMS") cu perioada deschisa, sau 204?
3. Depozitele soferilor: se creeaza cate unul pe sofer (ca 133..143 "Angajat NN") sub ce folder?
4. Dovada livrarii, livrarile partiale, incasarea de catre sofer (plan §2) - neschimbate.

## 5. Urmatorii pasi (ordinea din plan §10)

1. DBA: crearea userului Firebird `CURIERI`, rularea `dispatch_logistics.sql` pe SW; in WMS (Curieri...): depozitul de baza, utilizatorul aplicatiei, depozitele soferilor, profilurile si codurile de activare.
2. Etapa 4, restul: repartizarea zonelor, punctele de preluare, fisa tiparita, Procesare documente (fotografiile langa pozitiile 106).
3. Etapa 3: seriile din 106 deschis in `GET_AVAILABLE_SN` / `GET_SN_DEP_GOODS`; transferul intr-un pas pentru oprirea Depozit si sosirea la baza.
4. Etapa 7: livrarea (autorizare cu semnatura versiunii, plata din deal, confirmare), incarcarea la depozit, "Am ajuns la depozit".
