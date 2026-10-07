# Integrare ECC Fiscal Partner (casă de marcat virtuală) în WMS

Data: 24 sep 2026. Surse: colecția Postman `documenter.getpostman.com/view/47125184/2sB3BGFUj4` (publicată 18 sep 2026), „Manual de Utilizare ECC Fiscal Partner - PS” v1.0 (53 p.), fișa de date ECC pentru Prime Store, codul WMS și baza SW.

Credențialele de test (URL demo, API key, POS ID, login BackOffice) **nu** se scriu în repo. Ele stau în `TS_API_CONFIG` (vezi §4).

## 1. Decizii luate (24 sep 2026)

| Subiect | Decizie |
|---|---|
| Unde se folosește ECC | Peste tot: bonuri din factură (frame25) și POS (frame133), X/Z, depuneri/retrageri; comenzi online plătite; livrare cu curierii noștri; terminalul bancar smart |
| ECC vs MCC Tremol | Coexistă. Fiecare casă din `FP_DEVICES` are un tip; codul alege backend-ul |
| Retururi | Întrebăm Fiscal Partner. Până la răspuns, returul pe ECC e blocat în WMS |
| Bonul emis | Se tipărește PNG-ul, se salvează `mev_link` (QR în documente), SMS/e-mail din ECC și arhivare |
| Comenzi online | Fiscalizare automată de un serviciu WMS (Delphi), nu de PHP |
| Curieri | Fiecare șofer WMS = un casier ECC (cashierId) cu aplicația Android |
| Terminal bancar smart | Există fizic; se integrează prin `new-order-ext` |
| Firma pilot | SOLUTII COMERCIALE SRL (316910), firma pe care intră comenzile web |
| Reduceri | Preț net pe bon, ca la Tremol (fără `others` de tip reducere) |

## 2. Ce oferă API-ul (`/api/sp/v1`, header `X-Api-Key`)

| Operație | Endpoint | Observații |
|---|---|---|
| Stare server | `GET /status` | Testat pe demo: 200 `{"status":true}` |
| Bon fiscal | `POST /receipt` → 202 | **Asincron.** `id` (UUID) îl generează clientul, deci operația e idempotentă. Urmează polling `GET /receipt/{id}` la 500 ms, până la 60 s |
| Date bon | `GET /receipt/{id}` | `number`, `z_report_number`, `number_from_first`, `mev_link`, `doc_file_name`, `payments[].change` |
| Listă bonuri / Z | `GET /receipt?dateFrom&dateTo`, `GET /report?...&closed&page&nrOfitems` | Pentru reconciliere |
| Depunere / retragere | `POST /service-receipt` | `sum` pozitiv = depunere, negativ = retragere |
| X / Z | `POST /report` | `reportType`: 2 = X, 1 = Z. Z-ul deschis se închide automat la 23:59:59 |
| PNG | `GET /download/{fiscal_receipt\|service_receipt\|x_report\|z_report}/{id}` | Pentru tipărire și arhivare |
| Terminal smart | `POST /new-order-ext`, `GET /new-order-ext/{id}`, `DELETE /new-order-ext/{id}` | Stări: pending / processing / processed / cancelled. Anularea e posibilă doar înainte de „processed” |
| Livrare | `POST /delivery` (cu `cashierId`), `GET /delivery/{id}`, `POST /delivery-status` | Stări: pending / completed / cancelled. Curierul poate reduce cantități și schimba plata |
| Nomenclator | `/product-groups`, `/products` (CRUD) | Opțional; `product_id` pe articol nu e obligatoriu |

Reguli de validare de respectat în cod:

- `cost` = `price` × `quantity` exact, cu 2 zecimale la preț și 3 la cantitate.
- `name` ≤ 100 de caractere.
- Totalul plăților trebuie să fie ≥ `total`.
- `cashier_name` trebuie să existe în ECC.
- `tax_code` e o literă definită în ECC: A 20 %, B 8 %, C (6 % în Postman, 10 % în fișa Prime Store), D 0 %, `_` fără TVA.
- Numerarul cu rest e refuzat dacă în sertar nu sunt bani, deci deschiderea turei trebuie să includă o depunere.

Tipuri de plată:

| Cod | Plată |
|---|---|
| 1 | Numerar |
| 2 | Card |
| 31 | Voucher |
| 32 | CEC |
| 33 | Tichet |
| 5 | TME |
| 6 | Abonament |
| 7 | Online / MIA |
| 81 | Credit |
| 82 | Leasing |
| 83 | Avans |
| 84 | Arvună |
| 85 | Gaj |
| 88 | Compensare |
| 89 | Alt mod |

Erori care blochează vânzarea:

| Cod HTTP | Cauză |
|---|---|
| 403 | IP neautorizat pentru cheie (nu ne privește: cheile noastre nu au restricție IP, decizie 24 sep 2026) |
| 403 | SIA MEV nefuncțional de peste 14 zile |
| 400 | Licență expirată sau limita de tranzacții atinsă |
| 403 | „No pos id” (POS dezactivat) |

## 3. Starea actuală a WMS (relevant pentru ECC)

- **Nu există abstracție peste aparatul fiscal.** Trei locuri vorbesc direct cu `Tremol.FP`:
  - `frmReceiptPrintDialogV2` (bon din factură, `frame25ScetFakturaUnit.pas:2532`);
  - `frmFiscalPrinterServiceDialogV2` (meniul Service, `MainForm.pas:5223`);
  - `TPOSFiscal` (`classes/POS/POSFiscalUnit.pas`), folosit de `POSCheckoutUnit` și `frmPOSShiftDialog`.
- Aparatul se alege în `GetFiscalPrinterServer(FirmaID)` (`FiscalPrinterUtilsUnit.pas:175`), după `FP_DEVICES`. Tabelul nu are coloană de tip; toate rândurile sunt MCC Tremol, iar singurul activ e FP_ID 6 / firma 307225.
- Liniile bonului vin din `GET_GOODS_FOR_RECEIPT(DOCID)` cu preț net. TVA-ul e mapat simplificat: 0 % → clasa E, restul → A. Plata e 0 = numerar, 1 = card, iar în POS QR MIA → ALT_IP.
- Salvarea: `SP_CREATE_RECEIPT3` (factură) și `SP_POS_REGISTER_RECEIPT` (POS) scriu în `TDB_DOCS_RECEIPT`.
  - Cheia e (DOCID, NUMAR_BON SMALLINT).
  - FLAGS: bit 0 = persoană juridică, bit 1 = bon parțial, bit 2 = numerar, bit 3 = anulat.
- Retururile nu sunt fiscalizate nicăieri (`StornoPLU` nu e apelat).
- **Bug existent** (`frmReceiptPrintDialogV2.pas:1030-1058`): dacă `CloseReceipt` aruncă o excepție, bonul se salvează totuși în baza de date ca reușit. De reparat la refactorizare.
- Plăți online în 2026:
  - `TDB_ECOMM_TRANSACTIONS` (card maib): 7 cu STATUS = 1;
  - `TWEB_MIA_QR_PAYMENTS`: 13 cu „Paid”.
- Livrări 2026: 233 de rânduri în `TDB_DOCS_DELIVERY`, dar `DRIVERID` e gol peste tot și `FLG_CASHONDELIVERY` e NULL. **Șoferul nu se înregistrează azi pe livrare.**
- Modelul HTTP de urmat: `THTTPClient` + `System.JSON` + `TS_API_CONFIG`, ca în `classes/Currency/UltraCurrencyRateThread.pas` și `classes/EFactura/EFacturaManager.pas` (credențiale per firmă, eroare clară spre „Setari > Configurari API”).

## 4. Arhitectura propusă

### 4.1 Baza de date (`DB Model/ecc_fiscalpartner.sql`, re-rulabil)

1. `FP_DEVICES`:
   - `DEVICE_TYPE SMALLINT DEFAULT 0` (0 = Tremol/ZFPLab, 1 = ECC);
   - `ECC_POS_ID VARCHAR(100)`, `ECC_POS_NAME VARCHAR(100)`;
   - `ECC_API_CODE VARCHAR(30)`: legătura spre `TS_API_CONFIG`, unde stau parametrii `BASE_URL`, `API_KEY`, `TAX_20=A`, `TAX_8=B`, `TAX_0=D`, `TAX_NONE=_`.
2. `TFP_ECC_CASHIER`: (FP_ID, USERID sau DRIVERID) → `CASHIER_NAME`, `CASHIER_ID` (UUID pentru livrare). Casierul implicit al casei e rândul fără utilizator.
3. `TFP_ECC_TRANSACTION`: jurnalul tuturor cererilor („outbox”).
   - Coloane:
     - `TRANS_ID CHAR(36)` PK;
     - FP_ID, `KIND` (RECEIPT / SERVICE / X / Z / ORDER_EXT / DELIVERY);
     - DOCID, `SOURCE_TYPE` + `SOURCE_ID` (POS sale / ecomm / MIA / delivery);
     - `STATE` (NEW / SENT / DONE / ERROR / CANCELLED), `ATTEMPTS`;
     - REQUEST_JSON și RESPONSE_JSON (BLOB text), `ERROR_MSG`;
     - `RECEIPT_NUMBER`, `Z_NUMBER`, `NUMBER_FROM_FIRST`, `MEV_LINK`, `DOC_FILE_NAME`, `PNG` (BLOB, opțional);
     - CREATED_AT / UPDATED_AT / USERID.
   - Rândul se comite **înainte** de POST. Dacă WMS cade după trimitere, UUID-ul permite aflarea rezultatului prin `GET /receipt/{id}`, fără dublă fiscalizare. Asta rezolvă automat cazul „printed-not-saved” de la Tremol.
4. `TDB_DOCS_RECEIPT` + `ECC_TRANS_ID CHAR(36)`. `NUMAR_BON` = `number` din ECC; `DATA_ELIBERARII` = `datetime`.
5. `TDB_DOCS_DELIVERY.DRIVERID` trebuie completat de UI-ul de livrare (azi e gol). Opțional, se adaugă un index pe (DRIVERID, DELIVERY_DATE).

### 4.2 Delphi (`sources/FiscalPrinter/ECC/`, fișiere noi în ASCII)

| Unit | Rol |
|---|---|
| `ECCApiClient.pas` | HTTP/JSON pur, **fără VCL și fără IBDAC**, ca să poată fi refolosit și din serviciu. Metode: Status, PostReceipt, GetReceipt, WaitReceipt(timeout), ServiceReceipt, Report(X/Z), GetReport, ListReceipts/ListReports, Download(png), NewOrderExt/GetOrderExt/CancelOrderExt, Delivery/GetDelivery/SetDeliveryStatus. Erorile devin `EECCApiError` cu HTTP code + `message` |
| `ECCReceiptBuilder.pas` | Din liniile WMS (nume, cantitate, preț net, TVA %) și din plăți construiește JSON-ul. Rotunjire: `cost = RoundTo(price*qty, -2)`. Dacă suma WMS a liniei ≠ price*qty, linia se reface ca qty = 1 × cost. Numele se taie la 100 de caractere. TVA % → literă din `TS_API_CONFIG` |
| `ECCTransactionStore.pas` | CRUD pe `TFP_ECC_TRANSACTION` (tranzacție separată, comisă imediat) |
| `FiscalDeviceUnit.pas` | Abstracția comună (vezi mai jos) + fabrica `GetFiscalDevice(FirmaID)`, care extinde `GetFiscalPrinterServer` cu `DEVICE_TYPE` |
| `TremolFiscalDevice.pas` | Adaptor peste `TPOSFiscal` existent (open/sell/pay/close în interior) |
| `ECCFiscalDevice.pas` | Implementarea ECC: jurnal → POST → polling pe fir secundar cu fereastră de progres (fără UI înghețat) → PNG → tipărire |
| `ECCReceiptPrint.pas` | Tipărește PNG-ul pe imprimanta termică a stației (`TPrinter`, scalat la lățimea hârtiei; imprimanta aleasă se ține în AppConfigStorage per stație) |

Abstracția e **la nivel de bon întreg**, nu de pași Tremol, pentru că ECC primește tot bonul într-un singur JSON:

```pascal
IFiscalDevice = interface
  function  Kind: TFiscalDeviceKind;            // fdkTremol, fdkECC
  procedure Connect;
  function  PrintReceipt(const R: TFiscalReceipt): TFiscalReceiptResult;
  procedure CashInOut(Amount: Currency; const Text: string);
  function  XReport: TFiscalReportResult;
  function  ZReport: TFiscalReportResult;
  procedure OpenDrawer;                          // ECC: nu face nimic
end;
```

`TFiscalReceiptResult` conține: `Number`, `DateTime`, `ZNumber`, `ExternalId` (UUID-ul ECC), `MevLink` și starea (Done / Pending / Failed).

### 4.3 Serviciul pentru comenzile online

`SWNService` rulează azi doar proceduri stocate. Propunere: un **action nou** în `TServiceActionCollection`, „ECC online fiscalization” (la 1-2 min):

1. Selectează plățile reușite nefiscalizate din `TDB_ECOMM_TRANSACTIONS` (STATUS = 1) și `TWEB_MIA_QR_PAYMENTS` (Paid), fără rând în `TFP_ECC_TRANSACTION`, pentru firma casei ECC „online”.
2. Construiește bonul din comanda web (`GET_GOODS_FOR_RECEIPT` pe documentul legat), cu tipul de plată 7 și suma plătită.
3. Trimite, apoi rezolvă rândurile SENT rămase în așteptare (polling).
4. Înregistrează bonul în `TDB_DOCS_RECEIPT` și incasarea (120 bancă). Totul trece prin procedura `SP_ECC_REGISTER_ONLINE_RECEIPT`, testată local.
5. Repetă de maximum N ori, apoi pune rândul pe ERROR, vizibil în WMS.

`ECCApiClient.pas` fiind fără VCL, îl include și proiectul `DB Service` (prin cale relativă).

Alternativa, dacă modificarea serviciului e prea invazivă: un mod `/auto` în `WMSParsers.exe`, rulat din Task Scheduler.

## 5. Faze

| # | Fază | Conținut | Depinde de |
|---|---|---|---|
| 0 | Clarificări + mediu | Întrebările din §6 trimise la Fiscal Partner. Casieri de test (Test5) verificați. Rândurile `TS_API_CONFIG` pentru demo | — |
| 1 | Client API + test | `ECCApiClient` + `ECCReceiptBuilder` + un dialog de test „ECC diagnostic” (status, bon de 1 leu, X, depunere, PNG). Toate exemplele Postman reproduse pe demo | 0 |
| 2 | DB + jurnal | `ecc_fiscalpartner.sql` testat local, apoi rulat pe SW de DBA; `ECCTransactionStore` | 1 |
| 3 | Abstracție + Tremol | `IFiscalDevice`, adaptorul Tremol, fabrica. Mutarea `frmReceiptPrintDialogV2`, a meniului Service și a POS pe interfață, fără schimbare de comportament. Repararea bug-ului `CloseReceipt`. Test pe MCC reală (307225) | — (în paralel cu 1-2) |
| 4 | ECC în WMS/POS | `ECCFiscalDevice`: bon din factură și din POS, X/Z, depuneri/retrageri, tipărire PNG, `mev_link` în `TDB_DOCS_RECEIPT` + QR pe factură. Editorul `FP_DEVICES` cu tip + setările ECC + casieri. La deschiderea turei ECC: depunerea pentru rest | 2, 3 |
| 5 | Terminal bancar smart | La plata cu cardul pe o casă ECC cu terminal: `new-order-ext` → polling de stare (processed / cancelled) → buton „Anulează” (DELETE). Bonul îl emite terminalul; WMS preia datele prin `GET /receipt/{id}` | 4 |
| 6 | Online automat | Action-ul din SWNService (§4.3) pentru firma 316910 + ecranul de monitorizare a jurnalului (ERROR / reîncercare manuală) | 4 |
| 7 | Livrare | Completarea `DRIVERID` la expediere + maparea șofer → `cashierId`. „Trimite la curier” = `POST /delivery`. Serviciul urmărește starea; la `completed` se înregistrează bonul + incasarea. Dacă cantitățile diferă de factură, documentul se marchează pentru corecție manuală | 4, 6 |
| 8 | Reconciliere | Zilnic: `GET /receipt` și `GET /report` comparate cu `TDB_DOCS_RECEIPT` / jurnalul; raport de diferențe | 4 |
| 9 | Retururi | După răspunsul Fiscal Partner | §6 |
| 10 | Pilot producție | Cheie + POS pe ECC-ul de producție pentru 316910, prima zi cu monitorizare, apoi extindere pe alte firme | 4-6 |

## 6. Întrebări pentru Fiscal Partner

1. **Retur/storno**: cum se emite prin API un bon de retur (total sau parțial)? Există un endpoint nedocumentat sau tip de document? Dacă nu, care e procedura acceptată de SFS pentru ECC (din BackOffice)?
2. Mediul demo-04 trimite bonurile în SIA MEV **real**? Bonul de test din 22 sep are `mev_link` pe `mev.sfs.md`, nu pe `mev-pre.sfs.md` ca în exemplele Postman.
3. Cota C: 6 % (Postman) sau 10 % (fișa Prime Store)? Se pot citi cotele prin API?
4. O cheie per POS sau o cheie per companie cu mai multe `posId`? POS-urile se auto-creează după `posId` (le preferăm create manual)?
5. Anularea unui bon greșit (nu retur): este posibilă înainte de închiderea Z?
6. Terminalul smart: cum se leagă `posId`-ul terminalului de cheia API? Ce se întâmplă dacă clientul renunță pe terminal (stare `cancelled` + motiv în `result`)?
7. Livrarea: la `completed`, bonul are același `id` ca livrarea (exemplele sugerează asta)? Cum aflăm cantitățile modificate de curier și plata finală?
8. Limitele licenței (tranzacții / POS-uri) pentru producție și cum le citim ca să avertizăm din timp.
9. Există webhook/callback în loc de polling pentru `receipt`, `new-order-ext` și `delivery`?

## 7. Riscuri

- **Polling asincron**: un bon rămas „pending” mai mult de 60 s nu trebuie reemis. Jurnalul + UUID-ul rezolvă asta; UI-ul arată „în așteptare” și serviciul îl finalizează.
- **Rotunjiri**: `cost` ≠ price*qty duce la 400. Builder-ul normalizează liniile, iar totalul trimis = suma cost-urilor. Diferența față de documentul WMS se loghează.
- **Numerar fără depunere**: restul e refuzat. Deschiderea turei ECC cere depunere; alternativ, plata în numerar se trimite fără rest.
- **Z-ul se închide automat la 23:59:59**, iar modificarea cotelor TVA în ECC închide Z-urile deschise. Tura POS trebuie să tolereze un Z închis din exterior (se verifică prin `GET /report?closed=false`).
- **Livrarea nu are azi șofer pe document**: faza 7 cere întâi schimbarea procesului de lucru.
- **Internet căzut** = casă ECC indisponibilă. Pentru magazin fizic, o MCC Tremol de rezervă rămâne configurată pe aceeași firmă, cu fallback manual.

## 8. Stare

**Faza 1 (24 sep 2026): cod scris, compilează.** Unitățile noi sunt în `sources/FiscalPrinter/ECC/`:

- `ECCApiClient.pas`: toate operațiile API, fără VCL.
- `ECCConfigUnit.pas`: citește `TS_API_CONFIG` (coduri `ECC_*`).
- `frmECCDiagnosticDialog`: meniul „Casa ECC - diagnostic”, imediat sub „MCC”, ascuns pentru utilizatorii limitați.

Unitățile sunt înregistrate în `SWN.dpr` / `SWN.dproj`.

Verificat pe demo cu un program de consolă:

- stare server;
- lista de bonuri și lista Z;
- 404 pentru un bon inexistent;
- 403 transformat în `EECCApiError`;
- JSON-ul bonului, inclusiv împărțirea 100.00 / 3 = 2 × 33.33 + 1 × 33.34.

Constatări pe demo:

- POS-ul primit („Test5”, `5ab9a63e…`) dă **403 „Pos not exists or disabled”**. Niciun bon nu s-a emis. Pe cheie există doar POS-ul „Casa 1” al Fiscal Partner.
- `GET /receipt/{id}` și descărcarea PNG dau 404 / 400 pentru bonul emis de alt POS, deși el apare în `GET /receipt` (listă). Cel mai probabil, citirea individuală e limitată la POS-ul cheii; de confirmat după activarea POS-ului.

Pentru un test real lipsesc:

1. POS-ul Test5 activat (sau alt POS al cheii).
2. Rândurile `ECC_DEMO` în Setari > Configurari API: `BASE_URL`, `API_KEY`, `POS_ID`, `POS_NAME`, `CASHIER_NAME`.

**Test în aplicație (24 sep 2026, 16:32):** dialogul funcționează (stare server, liste). Bonul de test și comanda pe terminal dau în continuare 403 „Pos not exists or disabled”, deci POS-ul Test5 trebuie activat de Fiscal Partner.

**Faza 2 (24 sep 2026): cod scris, compilează, testat local.**

- `DB Model/ecc_fiscalpartner.sql` (re-rulabil):
  - `FP_DEVICES.DEVICE_TYPE` / `ECC_API_CODE`, cu check-ul „ECC cere cod API”;
  - `TDB_DOCS_RECEIPT.ECC_TRANS_ID` + index;
  - `TFP_ECC_CASHIER` (utilizator sau șofer → casier ECC, unic per casă);
  - `TFP_ECC_TRANSACTION` (jurnal; indexul parțial `UQ_TFP_ECC_TRANS_SOURCE` = un singur bon activ per plată / bon POS);
  - triggere: normalizare, `USERID` din context, un bon emis nu mai revine în „trimis”/„eroare”;
  - GRANT-uri către SWN.
  - Testat pe o bază locală Firebird 5 cu stub-uri: două rulări, toate constrângerile, indexul parțial.
- `sources/FiscalPrinter/ECC/ECCTransactionStore.pas`: jurnalul. Fiecare operație are tranzacția ei, comisă imediat. Conține:
  - `CreateOwnConnection` pentru firele de lucru;
  - `AddNew` înainte de POST, `MarkSent`, `MarkReceiptDone`, `MarkReportDone`, `MarkError` (final / nefinal), `MarkCancelled`, `SetOrderStatus`, `SavePng`, `MarkRegistered`;
  - `ListPending`, `ListRecent`, `FindActiveBySource`.
  - 18 verificări la rulare pe baza locală, toate OK.
- Dialogul de diagnostic scrie jurnalul când tabelul există:
  - bonul și comanda pe terminal: rândul se comite înainte de POST;
  - 4xx = eroare definitivă; rețea / timeout = rămâne „trimis”;
  - bonuri de serviciu și rapoarte: id-ul vine de la server, deci jurnalizarea se face după răspuns.
  - Butoane noi: „Jurnal” (ultimele 30 de rânduri) și „In asteptare” (caută în ECC, după id, bonurile rămase „trimis” și le marchează emise).

Rămâne: DBA rulează `ecc_fiscalpartner.sql` pe SW. Până atunci, dialogul funcționează fără jurnal și scrie asta în log.

**Scriptul rulat pe SW (24 sep 2026, 16:45):** verificat prin metadate (coloane, 2 tabele, 5 indexuri, 4 triggere). În jurnal, primele 2 cereri sunt corect „eroare” (403, POS inactiv).

**Faza 3 (24 sep 2026): cod scris, compilează, netestat pe aparat.**

Unități noi:

- `FiscalPrinter/FiscalDeviceUnit.pas`: `IFiscalDevice` la nivel de bon întreg, `TFiscalReceipt` (linii + plăți), rezultatul (`frsDone` / `frsNumberUnknown`) și fabrica `CreateFiscalDevice(FirmaID)`. Deocamdată ECC ridică o eroare clară; implementarea vine în faza 4.
- `FiscalPrinter/TremolFiscalDevice.pas`: motorul din fostul `POSFiscalUnit` (șters), plus citirea stării și mesajele de eroare Tremol traduse (fostul `HandleException` din dialog).
- `FiscalPrinterUtilsUnit.GetFiscalDeviceInfo`: aceeași alegere de aparat ca înainte, plus `FP_ID` / `DEVICE_TYPE` / `ECC_API_CODE`. Fără coloanele noi revine la interogarea veche.

Unde se folosește acum:

- **Bonul din factură** (`frmReceiptPrintDialogV2`) trece prin `IFiscalDevice`. Corecturi:
  - (a) o eroare înainte de închiderea bonului îl anulează pe aparat și nu se mai salvează în bază;
  - (b) `ReceiptPrinted` devine True doar dacă bonul există fiscal;
  - (c) cu „număr necunoscut” se cere numărul de pe hârtie;
  - (d) TVA 0: o singură întrebare, iar „Nu” anulează (decizia userului; înainte tipărea cu 20 %);
  - (e) dacă nu s-a tipărit nimic, se revine la pasul de tipărire.
- **POS** (checkout + tură) trece prin `IFiscalDevice`.
- **Meniul Service:** pentru o casă ECC deschide dialogul ECC cu casa preselectată; Tremol rămâne pe dialogul vechi (decizia userului).

Test de făcut în aplicație pe MCC (firma 307225): dialogul de bon din factură afișează MCC-ul (serie, oră) ca înainte; POS: raport X, sertar.

**Faza 4 (24 sep 2026): cod scris, compilează. Operațiile noi de bază sunt testate local; casa ECC nu e testată cap-coadă (POS-ul Test5 e inactiv).**

- `FiscalPrinter/ECC/ECCFiscalDevice.pas` implementează `IFiscalDevice` pentru ECC:
  - `Connect`: încarcă configurația, cere jurnalul `TFP_ECC_TRANSACTION` (fără el nu se emite nimic), alege casierul (`TFP_ECC_CASHIER` pentru utilizatorul curent, altfel `CASHIER_NAME`) și verifică `/status`;
  - `PrintReceipt`: jurnal comis → POST + așteptare pe un fir de lucru, cu fereastra „Se emite bonul…” și butonul „Oprește așteptarea” → jurnal emis → PNG salvat în jurnal și tipărit pe imprimanta implicită;
  - X / Z / depunere / retragere prin același mecanism; sertarul nu face nimic.
- Refuz ECC (4xx) = eroare, bonul nu există. Rețea / timeout / oprire = stare nouă `frsPending`: nu se repetă, nu se cere număr, se finalizează din „In asteptare”.
- `IFiscalDevice.ConfirmRegistered`, apelat după salvarea în WMS: leagă `TDB_DOCS_RECEIPT.ECC_TRANS_ID` după număr + dată + sumă (+ document) și marchează tranzacția înregistrată (`ECCTransactionStore.LinkWmsReceipt`). Testat local, 7/7.
- Bonul din factură: pentru ECC nu se aplică `SP_CANPRINTFPDEVICE`; afișează „Casa ECC …”; „în așteptare” = avertisment, fără reîncercare.
- POS: „în așteptare” = `pcoPrintedNotSaved` (documentele nu se salvează, jurnalul local rămâne).
- Editorul MCC (`FP_DEVICES`):
  - alegerea „MCC Tremol / Casa ECC” și codul casei ECC din „Configurari API”;
  - pentru ECC, câmpurile ZFPLab sunt dezactivate, iar numărul de serie e opțional;
  - lista are coloanele „Tip” și „Cod ECC”.

Rămân pentru mai târziu:

- QR-ul MEV pe factura tipărită (șablonul FastReport);
- alegerea imprimantei pentru bonul ECC per stație (acum e imprimanta implicită Windows).

Test real: POS-ul Test5 activ → în editorul MCC o casă ECC pentru o firmă de test, cu `ECC_DEMO` → bon din factură / POS.


**Faza 5 (24 sep 2026): cod scris, compilează, netestat (nu avem un terminal de test pe demo).**

- Configurare fără UI nou, în „Configurari API”, pe codul casei ECC: `TERMINAL_POS_ID`, opțional `TERMINAL_POS_NAME`, `TERMINAL_API_KEY` (dacă terminalul are altă cheie) și `TERMINAL_TIMEOUT_SEC` (implicit 180).
- Dacă terminalul e configurat, orice bon cu plată prin card (din factură sau din POS) pleacă automat la terminal prin `POST /new-order-ext`, cu toate plățile. Jurnalul (`KIND` = 5) se comite înainte de trimitere.
- Fereastra de așteptare explică ce se întâmplă. „Oprește” sau timpul expirat, cât comanda e `pending`, trimite `DELETE`: comanda e anulată, nimic încasat, nimic emis.
- `processed` → `GET /receipt/{id}` → bon emis. Terminalul l-a tipărit deja, deci PC-ul nu mai tipărește; PNG-ul se păstrează în jurnal.
- Dacă datele bonului nu se pot citi prin API, se cere numărul de pe bonul terminalului.
- `cancelled` pe terminal = eroare „Plata a fost anulată pe terminal”.
- `processing` neterminat sau rețea căzută = „în așteptare”: nu se repetă plata.
- Dialogul de diagnostic: „Comanda pe terminal” folosește `TERMINAL_POS_ID` / cheia terminalului, dacă sunt configurate.
- Rămâne de confirmat cu Fiscal Partner (întrebarea 6): cum se leagă terminalul de cheia API și dacă `GET /receipt/{id}` vede bonurile terminalului cu cheia casei.
**Faza 6 (24 sep 2026): cod scris, compilează, job testat local pe o bază cu stub-uri. Nimic activat pe server.**

Decizii ale userului:

- bonul online se înregistrează pe comanda web 134, iar dialogul facturii urcă pe lanț;
- plățile MIA fără comandă se raportează, fără bon;
- se fiscalizează doar plățile noi (`ONLINE_FROM`);
- rulează în SWNService, pe serverul cu baza SW.

Cod:

- `DB Service`:
  - `ServiceMain` / `UtilsUnit` reparate. Serviciul NU compila: clauza `uses` era dublă. Calea către `settings.dat` nu avea `\` final. Sarcinile dezactivate rulau oricum; acum sunt ignorate.
  - Sarcinile cu nume `@NUME` rulează cod Delphi (`ServiceJobsUnit.pas`) pe conexiunea firului, după `PROC_USER_LOGIN`. `tasks.dat` și Managerul rămân neschimbate.
- `DB Service/ECCOnlineFiscalUnit.pas` (`@ECC_ONLINE`). Un ciclu:
  1. finalizează bonurile rămase din ciclurile anterioare (după id) și înregistrează în WMS pe cele emise;
  2. raportează o dată plățile MIA fără comandă;
  3. pentru plățile noi (maib `STATUS=1`, MIA `Paid`, după `ONLINE_FROM`), casa ECC a firmei comenzii (DT) emite bonul: liniile vin din `GET_GOODS_FOR_RECEIPT(comanda)`, plata e de tip 7.
  - Suma liniilor ≠ plata → eroare, bonul se face manual.
  - Maximum 3 încercări eșuate pe plată și `MAX_PER_RUN` (implicit 20) bonuri pe ciclu.
  - Jurnal: `<folder serviciu>\ecc_online.log`.
- Înregistrarea: `TDB_DOCS_RECEIPT` pe comanda 134, cu `FLAGS` 0, `PRIHOD_DOCID` = încasarea 120 a comenzii (dacă există), `FP_ID` și `ECC_TRANS_ID`.
- `frmReceiptPrintDialogV2`: bonurile de pe documentele-părinte (CTE recursiv pe `PARENTDOCID`, verificat pe SW: 107 → 115 → 134) intră în suma deja fiscalizată.

Test local, 4 cicluri: au fost ignorate plata veche, plata eșuată și QR-ul expirat; firma fără casă (log o dată pe zi); suma diferită și refuzul ECC (403) s-au oprit exact după 3 încercări; MIA fără comandă a fost raportată o dată; bonul emis anterior a fost înregistrat pe 134 cu încasarea 120.

Activare pe server:

1. Build `DB Service/SWNService.dproj` și copierea exe-ului pe server, lângă `fbclient.dll`; apoi `install service.bat` (sau restart dacă e instalat).
2. `c:\windows\swnServiceManager.ini`, secțiunea `[Working Path]`, cheia `Path` = folderul cu `settings.dat` / `tasks.dat`.
3. În SWNServiceManager, o sarcină „ECC online”: zi + interval `00:05`, procedura `@ECC_ONLINE`, activă.
4. „Configurari API”: `ECC_ONLINE` / `ONLINE_FROM` = momentul activării (de ex. `2026-10-01 00:00:00`); opțional `MAX_PER_RUN`.
5. `FP_DEVICES`: casa ECC activă, fără stație, pentru firma comenzilor web. Atenție: DT al comenzilor plătite până în august era 307225 (PRIME STORE).
**Faza 8 (24 sep 2026): cod scris, compilează (SWN + SWNService), testat la rulare pe date reale din demo (doar citire) și o bază locală.**

- `FiscalPrinter/ECC/ECCReconcileUnit.pas` (fără VCL). Pentru o casă și o perioadă compară bonurile din ECC (paginat, doar POS-ul casei + terminalul ei) cu jurnalul și cu `TDB_DOCS_RECEIPT`.
  - Clase: în regulă / doar în ECC (emis în afara WMS) / lipsă în ECC / neînregistrat în WMS / sumă diferită / reparat; Z-urile apar ca informație.
  - Repararea automată: tranzacțiile rămase „nou/trimis”, dar găsite în ECC, trec în „emis”.
- Dialogul `frmECCReconcileDialog`, deschis din „Casa ECC - diagnostic” > „Reconciliere...”: casa, perioada, repararea automată, listă colorată, export CSV. Rulează pe un fir separat, cu conexiune proprie.
- Job-ul `@ECC_RECONCILE` în SWNService: ziua de ieri, pe toate casele ECC active, cu reparare automată; problemele merg în `ecc_reconcile.log`. De programat noaptea în Service Manager: zi, oră fixă, de ex. 02:00.
- `ECCApiClient`: `ListReceipts` e paginat, iar bonul și raportul au `PosId`.

Test: prima trecere a reparat tranzacția „trimis” găsită în ECC și a semnalat „neînregistrat” și „lipsă în ECC”; a doua trecere n-a mai reparat nimic.
**Faza 7 (24 sep 2026): cod scris, compilează (SWN + SWNService), testat la rulare pe o bază locală cu stub-uri și POST real către demo pe un POS inexistent (403, nimic creat).**

Decizii ale userului:

- curierul = `COURIERID` / `DRIVERID` din `TS_CUSTOMER` (același lucru; numele din `TS_SYSS` din view e o rămășiță);
- se trimit doar livrările cu plata la livrare, dintr-un buton;
- doar Vânzare 107;
- la finalizare: bon + încasare automată.

Cod:

- `DB Model/ecc_delivery.sql`: `TFP_ECC_CASHIER.POS_ID` (telefonul curierului în ECC). **Trebuie rulat pe SW.**
- `ECCApiClient`: `NewDelivery` / `GetDeliveryStatus` / `SetDeliveryStatus`, `ToDeliveryJSON`; bonul are `CashierId`.
- `FiscalPrinter/ECC/ECCDeliveryUnit.pas` (fără VCL):
  - `ECCSendDelivery` verifică: tipul 107; plata „Numerar” sau „Card bancar”, fără „Credit”; casa ECC a firmei; curierul legat de un casier ECC; livrarea să nu fie deja trimisă. Apoi scrie jurnalul (`KIND` 6, `SOURCE_TYPE` 5, `SOURCE_REF` = `DOCID`) înainte de `POST /delivery`.
  - `ECCProcessDeliveries` = job-ul `@ECC_DELIVERY`: urmărește starea. La `cancelled` → anulat. La `completed` → bonul se caută după id, apoi în lista telefonului (aceeași sumă, un singur candidat). Într-o singură tranzacție: `SP_CREATE_RECEIPT3` (încasare 116 / 120 + factura 112 dacă lipsește + rândul `TDB_DOCS_RECEIPT`) + `ECC_TRANS_ID` + `FLG_REGISTERED`. Suma mai mică = bon parțial, cu avertisment în log.
- Buton „Trimite la curier (ECC)” în bara cadrului de livrare (`frameDeliveryUnit`).
- „Curieri ECC” (`frmECCCouriersDialog`, din „Casa ECC - diagnostic”): curier → casier ECC + POS, plus „Casieri din ECC” (casierii din bonurile ultimelor 60 de zile, cu id-urile lor).

Test local:

- trimiterea e refuzată corect pentru: ofertă 115, livrare pe credit, curier fără casier;
- trimiterea bună ajunge la demo (403 pe POS inexistent) și poate fi retrimisă;
- livrarea finalizată a creat încasarea 116 + factura 112 și a legat bonul nr. 12; a doua rulare n-a dublat nimic.

Activare:

1. `ecc_delivery.sql` pe SW;
2. „Curieri ECC”;
3. sarcina `@ECC_DELIVERY` (zi, interval `00:05`) în Service Manager;
4. curierul persoană în câmpul „Curier” al livrării.

De confirmat cu Fiscal Partner (întrebarea 8): id-ul bonului e același cu id-ul livrării?

**Faza 9 (retururi):** blocată. API-ul nu are retur; se așteaptă răspunsul Fiscal Partner (întrebarea 1).

**Faza 10 (pilot):** operațională, nu cod:

- casa ECC de producție (licență, POS, cheie) pentru firma pilot;
- testele de pe demo după activarea POS-ului Test5;
- activarea job-urilor `@ECC_ONLINE` / `@ECC_RECONCILE` / `@ECC_DELIVERY`;
- prima zi cu reconcilierea urmărită.
**Mediul de test nou (25 sep 2026): demo-13.fiscalpartner.md**

- POS „Casa nr.1” (`774a0960-…`), casierul „Casier”. `ECC_DEMO` din „Configurari API” pe SW a fost mutat pe el.
- **Primul bon real:** 1,00 leu numerar, bonul nr. 1 din Z nr. 2. Linkul MEV e pe `mev-pre.sfs.md`: demo-13 folosește SIA MEV de test (întrebarea 2, pentru acest mediu). PNG-ul e complet (383×833).
- **Problemă la Fiscal Partner:** fiecare a doua cerere, la orice endpoint, primește 400 „Wrong Public IP address, unauthorized request”. IP-ul nostru public e constant (77.89.204.50), deci pare un server din spatele balansorului lor fără IP-ul nostru în lista cheii. **De raportat lor.**
- Ocolire în `ECCApiClient.DoRequest`: la acest răspuns cererea se repetă de cel mult 4 ori. E sigur, pentru că cererea e respinsă înainte de procesare și id-ul bonului e al nostru. Verificat pe demo-13: stare, listă, bon, PNG, 404 / 403.
- `GET /receipt/{id}` nu întoarce obiectul `cashier` (îl are doar lista).
**Verificare demo-13 (26 sep 2026, 19:13):** eroarea „Wrong Public IP” e **rezolvată** de Fiscal Partner: 30/30 cereri OK pe ambele instanțe (cookie-uri de balansor noi, deci instanțe repornite). Reîncercarea din `ECCApiClient` rămâne ca protecție, fără efect când totul merge.

Constatări din BackOffice (`prog01`, doar citire):

- **Cheia API** `7d184ee2-…`: activă, legată de „Casa nr.1”, auto-crearea POS oprită, **fără restricție de IP**.
- **Licența** „Demo 13”:
  - nr. SFS S00404004005, model FP ECC PS, fabricație FPSPDEMO-02;
  - fără limită de POS / tranzacții, fără expirare;
  - `ips_range` gol;
  - e-mail automat activ, SMS oprit;
  - **`delivery_module = False`: faza 7 (livrare) nu se poate testa pe demo-13 până nu activează Fiscal Partner modulul.**
- Cele două instanțe ies spre internet cu IP-uri diferite (176.123.3.114 / 176.123.3.182), ceea ce explica eroarea de ieri.