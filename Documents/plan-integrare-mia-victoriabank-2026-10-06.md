# Integrare MIA Victoriabank (plăți instant prin QR) pe fantastic.md

Data: 6 oct 2026. Surse: mapa `Mia VB\` (exemple brute de cereri, „MIA Instant Payment — Integration Guide v2.0”, `errors-and-warnings-qr.pdf`, `VBCA.cer`), specificația oficială „VictoriaBank Business IPS Integration API” v2.0.18 și swagger-ul live al mediului de test, codul `fantastic.web`, `DB Service` și baza SW.

Stare (6 oct 2026): **toate cele 6 etape sunt implementate** (§12–§17). Scriptul `DB Model/mia_vb_payments.sql` e rulat pe SW în versiunea curentă (verificat 6 oct 2026). Rămân pașii de lansare din §17.5: publicarea, credențialele de producție, înregistrarea URL-ului la bancă și testele băncii. Pe site metoda rămâne ascunsă până la `miaVb.enabled => true`.

Credențialele (utilizator, parolă, IBAN) **nu** se scriu în repo: stau în `config/brand.local.php`. Fișierele `.txt` din `Mia VB\` conțin credențiale de test ale altor comercianți (exemplele băncii) — mapa nu e în git și nu trebuie comisă.

## 1. Pe scurt

- Integrarea VB se face **complet separat** de MIA maib: client, controller, tabele, configurare, jurnal și cron proprii. Niciun fișier `MiaQr*` existent nu se modifică.
- Peste cele două bănci stă un strat comun subțire (alegerea furnizorului la checkout + un view de citire pentru fiscalizare și WMS). Datorită lui, maib se poate reactiva mai târziu alături de VB fără să atingem codul VB.
- Fluxul recomandat: **comanda se creează întâi, plata vine după** (invers decât la maib). Motivele sunt în §5.
- Aceeași pagină de plată servește și finalizarea comenzii, și „linkul de plată” trimis de operator — promis deja clientului în pagina „Cum plătesc?”, dar inexistent în WMS.
- Banca cere verificarea periodică a stării (la 5–7 secunde) ca mecanism principal; webhook-ul e „suplimentar”. Fluxul se poate deci testa cap-coadă și fără webhook.

## 2. Ce oferă API-ul VB (IPS Business WebApi v1)

| Mediu | URL |
|---|---|
| Test | `https://test-ipspj.victoriabank.md` |
| Producție | `https://ips-api-pj.vb.md` |
| Simulator de plată (doar test) | `https://test-ipspj-demopay.victoriabank.md/api/pay/` |

Verificat pe 6 oct 2026 de pe stația de dezvoltare: `GET /api/v1/health/status` răspunde 200 pe test și pe producție, certificat TLS public valid. De pe serverul site-ului nu am verificat.

| Operație | Cerere | Observații |
|---|---|---|
| Token | `POST /identity/token`, **form-urlencoded**: `grant_type=password&username=&password=` | Răspuns `accessToken`, `tokenType`, `expiresIn`, `refreshToken`. Se ține în cache; la 401 se șterge și se reîncearcă o dată |
| Creare QR | `POST /api/v1/qr?width=400&height=400` | Corp `header` + `extension` (§2.1). Răspuns: `qrHeaderUUID`, `qrExtensionUUID`, `qrAsText`, `qrAsImage` (PNG base64) |
| Stare QR | `GET /api/v1/qr/{qrHeaderUUID}/status?nbOfExt=1&nbOfTxs=1` | `status` + `extensions[].payments[]` (referință, sumă) |
| Stare extensie | `GET /api/v1/qr-extensions/{qrExtensionUUID}/status?nbOfTxs=1` | Varianta din ghid |
| Ultimul semnal | `GET /api/v1/signal/{qrExtensionUUID}` | 404 cât timp nu există semnal |
| Anulare QR | `DELETE /api/v1/qr/{qrHeaderUUID}` | 200 fără corp; banca trimite semnal `Inactivation` |
| Rambursare | `DELETE /api/v1/transaction/{id}` | `{id}` = al 4-lea segment din `payment.reference`. 204. Doar integrală, o singură dată |
| Reconciliere | `GET /api/v1/reconciliation/transactions?dateFrom=YYYY-MM-DD&dateTo=YYYY-MM-DD` | Lista tranzacțiilor: plătitor, sumă, stare, `creditorRef` |
| Sănătate | `GET /api/v1/health/status` | Fără autentificare |
| Simulare plată (test) | `POST …demopay…/api/pay/` cu `{"qrHeaderUUID": "…"}` | 202 = acceptat; semnalul vine în 1–3 s |

Stări QR: `Active`, `Paid`, `Expired`, `Cancelled`, `Replaced`, `Inactive`.

### 2.1. Corpul cererii de creare (QR dinamic, sumă fixă)

```json
{
  "header":    { "qrType": "DYNM", "amountType": "Fixed", "pmtContext": "e" },
  "extension": {
    "creditorAccount":      { "iban": "<IBAN-ul firmei la VB>" },
    "dba":                  "FANTASTIC.MD",
    "remittanceInfo4Payer": "Comanda 1234567 fantastic.md",
    "creditorRef":          "1234567",
    "amount":               { "sum": 1499.00, "currency": "MDL" },
    "ttl":                  { "length": 5, "units": "mm" }
  }
}
```

Limite: `dba` 2–25 caractere, `remittanceInfo4Payer` și `creditorRef` 2–35. Toate schemele au `additionalProperties: false`: orice câmp în plus înseamnă cerere respinsă. `creditorRef` (numărul comenzii) se întoarce în reconciliere.

### 2.2. Notificarea băncii (webhook / „signal”)

- Banca face `POST` pe URL-ul înregistrat la ea. Corpul este **un șir JSON care conține un JWT** (`"eyJ…"`, cu ghilimele).
- JWT semnat RS256; se verifică cu cheia publică din `VBCA.cer`. Nu are `exp`/`iat`, deci protecția la repetare o facem noi (idempotență pe referința plății).
- Conținut: `signalCode` (`Payment` / `Expiration` / `Inactivation`), `signalDtTm`, `qrHeaderUUID`, `qrExtensionUUID`, `payment.reference`, `payment.amount.sum`, `payment.amount.currency`.
- Răspunsul nostru: **întotdeauna 204**. Orice alt cod declanșează reîncercări din partea băncii.
- Ghidul cere polling în paralel, obligatoriu: webhook-ul singur nu e considerat suficient.

## 3. Nepotriviri între ghid și comportamentul real

Găsite comparând ghidul HTML cu exemplele brute din `Mia VB\` și cu specificația oficială. Codul trebuie scris după comportamentul real.

| Subiect | Ghidul v2.0 | Real | Ce facem |
|---|---|---|---|
| Câmpurile tokenului | `access_token`, `expires_in: 3600` | `accessToken`, `expiresIn` (3600 pe contul nostru, 36000 în exemplul băncii), `refreshToken`, `refreshExpiresIn` | Citim camelCase, cu rezervă pe snake_case; durata din răspuns, minus o marjă |
| Endpoint de stare | `/qr-extensions/{ext}/status` | exemplul brut folosește `/qr/{header}/status` | Cheia noastră principală e `qrHeaderUUID`; păstrăm ambele UUID-uri |
| UUID-ul extensiei | același la creare și la stare | în exemplele brute diferă; **pe contul nostru de test coincide** (verificat) | Exemplele băncii erau din rulări diferite. Păstrăm ambele UUID-uri |
| `qrHeaderUUID` în semnal | prezent | **`null`** în semnalul real; vine doar `qrExtensionUUID` | Semnalul se potrivește după `qrExtensionUUID` |
| `qrAsText` | „șir EMV”, deeplink `https://pay.vb.md/?qr=` | URL scurt: `https://mia-qr-test.bnm.md/1/e/BNM/VIC<uuid fără cratime>` | Pe mobil deschidem direct `qrAsText`. De confirmat cu banca |
| `amount.sum` | număr | număr la stare, **șir** în semnal | Normalizăm la 2 zecimale înainte de comparare |
| `ReturnUrl` / `CancelUrl` | câmpuri opționale | lipsesc din schema swagger | Nu le trimitem în v1 (risc de respingere) |
| TTL | minim și recomandat 5 minute | exemplul brut folosește 30; limitele le configurează banca | Configurabil; pornim cu 5 și regenerare la un click |
| Rambursare parțială | „nu se suportă” | există în swagger, nedocumentată | v1: doar integrală |
| Certificatul din ghid | „valid până la 2026-07-07” | **expirat** | Folosim `VBCA.cer` din mapă: 3 iul 2026 → 3 iul 2027, RSA-2048, SHA-256 `BD:0B:70:DE:…:02:83:88` |

| Anulare QR | 200 | uneori **500 `VB10000`** deși codul ajunge `Cancelled`; pe un cod deja anulat: 500 `EQ22` | La eroare recitim starea; codul care nu mai poate fi plătit contează ca anulat |
| Data în reconciliere | `2026-03-28` | `06.10.2026` (zz.ll.aaaa), ora separat | Parsăm ambele forme |
| Simulatorul de plată | 202 = plată efectuată | 202 de fiecare dată, dar plata s-a executat doar la prima cerere (§12) | Întrebare la bancă |

Certificatul se schimbă anual. Banca recomandă două certificate active simultan; configurarea acceptă o listă, iar în iunie 2027 trebuie cerut cel nou.

## 4. Ce există azi (MIA maib) și ce constrânge planul

- Cod: `components/MiaQrComponent.php`, `MiaQrSdkComponent.php`, `MiaQrOrderService.php`, `controllers/MiaQrController.php`, `commands/MiaQrReconcileController.php`, `models/MiaQrPayment.php`, `views/mia-qr/`, tabela `TWEB_MIA_QR_PAYMENTS`, configurarea `miaQr`.
- În interfață e **dezactivat**: opțiunea e comentată în fluxul vechi în trei pași și în „Cumpără acum”, iar pagina nouă de finalizare (`/shop-cart-order`) nu are MIA deloc. Ultimul QR din tabelă e din 13 aug 2026.
- Pe SW: 48 de QR-uri — 34 expirate, 13 plătite, 1 activ. Din cele **13 plătite doar 4 au comandă legată** (`DOCID`). La maib comanda se creează după plată, din datele salvate la generarea QR-ului; când acestea lipsesc, plata rămâne fără comandă.
- Jobul de fiscalizare `@ECC_ONLINE` (`DB Service\ECCOnlineFiscalUnit.pas`) citește plățile `Paid` direct din `TWEB_MIA_QR_PAYMENTS` (`SOURCE_TYPE = 4`, referința = `QRID`) și emite bon pe comanda legată. Plățile VB trebuie să ajungă și ele acolo.
- Pagina „Cum plătesc?” (`templates/content/fantastic/optiunideplata.ro.php`) promite: „după confirmarea comenzii primești pe SMS sau e-mail un link cu codul QR MIA”. În WMS nu există nimic care să genereze acel link; `/mia-qr/show` citește doar din sesiunea clientului.
- `TWEB_TRANSACTION.PAYMENT_TYPE` (coș): 1 numerar, 2 card la primire, 3 card online, 4 cont spre plată. MIA nu are cod propriu; fluxul vechi îl punea pe 3.
- Serverul de producție rulează încă PHP 7.4: codul nou rămâne compatibil cu 7.4 (fără `match`, enum, proprietăți readonly). Extensiile `curl` și `openssl` există local; de verificat pe server.

## 5. Decizia de flux: comanda întâi, plata după

1. Clientul alege „MIA — plată instant”. Comanda se creează ca la numerar (`WEB_CREATE_TRANSACTION3`) și primește `DOCID`.
2. Suma de plată se citește **din documentul creat** (`SUM(SUMA)` din `TDB_JURNAL`), nu din browser sau sesiune.
3. Se creează cererea de plată (cu token public aleator) și QR-ul la VB, cu `creditorRef` = `DOCID`.
4. Clientul ajunge pe pagina de plată `/plata-mia/<token>`: QR, buton „Deschide aplicația băncii” pe mobil, cronometru, verificare la 5 secunde.
5. Confirmarea vine pe trei căi, toate prin aceeași funcție idempotentă: polling din pagină la 5 secunde (calea principală, cerută de bancă), cron de reconciliere (când clientul a închis pagina) și webhook (suplimentar).
6. Dacă nu plătește: comanda rămâne în WMS ca neachitată și operatorul o tratează ca pe orice comandă. Pagina oferă „Generează cod nou” și „Plătesc la primire”.

De ce așa:

- Experiența maib: 9 din 13 plăți fără comandă legată. Cu comanda creată întâi, o plată are mereu un document, deci și fiscalizarea are pe ce emite bonul.
- Prețurile se schimbă în timpul zilei (reevaluările de la 09:00 și 14:00). Dacă creăm comanda după plată, totalul ei poate diferi de suma deja plătită.
- Ghidul băncii presupune comanda existentă: UUID-ul se salvează lângă comandă, `creditorRef` e numărul ei, chitanța pe e-mail îl conține.
- O comandă neplătită nu se pierde: operatorul sună clientul. Azi un QR abandonat nu lasă nicio urmă în WMS.
- Același mecanism rezolvă linkul de plată al operatorului, fără cod separat.

Costul: în WMS apar comenzi cu „plată MIA în așteptare”. Operatorii trebuie să vadă starea plății (etapa 5).

## 6. Arhitectură

### 6.1. Specific VB (totul nou)

| Element | Fișier / obiect | Rol |
|---|---|---|
| Client HTTP | `components/VbMiaClient.php` | token + cache, creare QR, stare, anulare, rambursare, reconciliere, sănătate, simulare; `curl` simplu, fără Guzzle |
| Verificare semnal | `helpers/VbMiaSignal.php` | decodare JWT, verificare RS256 cu lista de certificate, validarea câmpurilor |
| Logică | `components/VbMiaService.php` | `start(docId, sumă)`, `refresh(token)`, `confirm(…)`, `expire(…)`, `refund(…)` |
| Model | `models/VbMiaPayment.php` | acces la cele două tabele |
| Web | `controllers/MiaVbController.php` | `pay` (pagina), `status` (polling), `signal` (webhook), `regenerate`, `refund-form`, `test-pay` |
| Consolă | `commands/MiaVbController.php` | `health`, `token`, `create-test`, `status`, `pay-test`, `reconcile`, `daily` |
| Pagini | `views/mia-vb/pay.php`, `refund-form.php`, `web/js/mia-pay.js`, `web/css/mia-pay.css` | pagina de plată, RO + RU |
| Configurare | `miaVb` în `config/brand.php` și `config/brands/<brand>.php`; secretele în `brand.local.php` | pe brand: tehnomarket are altă firmă, deci alt contract și alt IBAN |
| Certificate | `config/certs/vbca-2026.cer` (+ următorul) | cheia publică a băncii |
| Jurnal | categoria `miaVb` → `runtime/logs/mia-vb.log` | fără tokenuri sau parole în jurnal |

```php
'miaVb' => [
    'enabled'    => false,
    'baseUrl'    => 'https://test-ipspj.victoriabank.md', // productie: https://ips-api-pj.vb.md
    'demoPayUrl' => 'https://test-ipspj-demopay.victoriabank.md', // gol in productie
    'username'   => '',  // brand.local.php
    'password'   => '',  // brand.local.php
    'iban'       => '',
    'dba'        => 'FANTASTIC.MD',
    'ttlMinutes' => 5,
    'certFiles'  => ['@app/config/certs/vbca-2026.cer'],
],
```

Cheia de cache a tokenului se prefixează cu brandul (două site-uri pe același cod, credențiale diferite).

### 6.2. Stratul comun (neutru față de bancă)

- `helpers/MiaGateway.php`: întoarce furnizorul activ pentru checkout după `params['checkout']['mia']['provider']` (`'vb'`, mai târziu `'maib'` sau o regulă). Singurul loc care știe că există mai multe bănci.
- O singură plăcuță la checkout: `'mia'` în `CheckoutOrder::PAYMENTS`, cu `group2 => 'rbPay_MiaQr'` (codul există deja în `ShopCartHelper`), `type => 5`, `gateway => 'mia'`. Clientul vede „MIA — plată instant”, nu numele băncii.
- `PAYMENT_TYPE = 5` = „MIA QR” în `FN_DEAL_WEB_PAYMENT_METHOD('CART', …)`.
- View `VW_WEB_MIA_PAYMENTS`: plățile confirmate din ambele bănci, cu coloana `BANK`. Îl citesc jobul de fiscalizare și WMS.
- Analitica de plată rămâne `PAY_QR_MIA` (`PaymentAnalytic::QR_MIA`), comună; banca apare în comentariul documentului și în view.

```php
interface MiaProvider
{
    public function code();                                  // 'vb' | 'maib'
    public function createQr($docId, $amount, $description); // qrId, qrText, qrImage, expiresAt
    public function status($qrId);                           // status, reference, amount
    public function cancel($qrId);
    public function refund($txId);
}
```

În v1 interfața are o singură implementare (VB). Adaptorul maib se scrie abia în etapa 7.

### 6.3. Baza de date (`DB Model/mia_vb_payments.sql`, script repetabil, rulat de DBA)

`TWEB_MIA_VB_PAYMENT` — cererea de plată (o comandă, o sumă, un token):

| Coloană | Tip | Rol |
|---|---|---|
| `PAYMENT_ID` | BIGINT, PK, generator | |
| `TOKEN` | VARCHAR(64), unic | partea publică din URL-ul paginii de plată |
| `DOCID` | INTEGER, NOT NULL, index | comanda |
| `AMOUNT` | DECIMAL(12,2) | suma de plată, fixată la creare |
| `STATUS` | VARCHAR(20) | `New`, `Paid`, `Cancelled`, `Refunded`, `Mismatch` |
| `SOURCE` | VARCHAR(20) | `checkout` / `operator` |
| `PAY_REFERENCE` | VARCHAR(120) | `payment.reference` complet |
| `TX_ID` | VARCHAR(64), index | segmentul 4, pentru rambursare și chitanță |
| `PAID_AMOUNT`, `PAID_AT` | | ce și când a confirmat banca |
| `PAYER_NAME` | VARCHAR(200) | din reconciliere |
| `EMAIL`, `LANG` | | pentru chitanță |
| `CREATED_AT`, `UPDATED_AT`, `CREATED_BY` | | |

`TWEB_MIA_VB_QR` — codurile emise pentru o cerere (unul activ la un moment dat):

| Coloană | Tip | Rol |
|---|---|---|
| `QR_HEADER_UUID` | VARCHAR(36), PK | |
| `QR_EXT_UUID` | VARCHAR(36), index | |
| `PAYMENT_ID` | BIGINT, FK | |
| `STATUS` | VARCHAR(20) | starea de la bancă |
| `QR_TEXT` | VARCHAR(500) | `qrAsText` (imaginea nu se păstrează; se regenerează din text) |
| `EXPIRES_AT`, `CREATED_AT`, `UPDATED_AT` | | |
| `SIGNAL_DATA` | BLOB TEXT | ultimul semnal decodat, pentru diagnostic |

Plus: view-ul `VW_WEB_MIA_PAYMENTS`, `ALTER FUNCTION FN_DEAL_WEB_PAYMENT_METHOD` (codul 5) și procedura `WEB_MIA_VB_CREATE_LINK(DOCID, AMOUNT)` pentru WMS (etapa 5).

### 6.4. Reguli de siguranță

- Confirmarea e idempotentă: lock pe `PAYMENT_ID`, apoi „dacă e deja `Paid`, ieși”. Webhook-ul, polling-ul și cronul pot rula simultan.
- Suma din semnal se compară cu `AMOUNT`. Dacă diferă: `Mismatch`, comanda nu se marchează plătită, alertă în canalul Telegram `ERRORS`.
- Înainte de a genera un cod nou pentru aceeași cerere: verificăm starea celui vechi (dacă e `Paid`, confirmăm), apoi îl anulăm la bancă. Altfel clientul ar putea plăti de două ori.
- Plată sosită pe o comandă anulată între timp: se înregistrează, alertă, rambursare manuală.
- Webhook: CSRF dezactivat doar pe acțiunea `signal`; algoritm acceptat numai `RS256`; format UUID validat; răspuns 204 indiferent de rezultat. Dacă procesarea eșuează după salvarea semnalului, o reia cronul.
- Pagina de plată arată doar numărul comenzii și suma — fără nume, telefon sau adresă: tokenul din URL e singura protecție.
- `refund-form` și `test-pay`: doar din rețeaua internă, ca la maib.

## 7. Ce se întâmplă la confirmarea plății

1. Cererea → `Paid`, cu referința, `TX_ID`, suma și ora.
2. Comentariu pe document (`SP_ADD_DOC_COMMENTS`): „Plată MIA (Victoriabank) confirmată. Ref …, suma …”.
3. Analitica de plată `PAY_QR_MIA`.
4. Starea de plată a deal-ului **nu se schimbă aici**. Algoritmul deal-urilor o calculează din documentele de încasare legate (120). *Corectare (etapa 4):* jobul de fiscalizare **nu** creează încasarea, doar leagă bonul de ea dacă există deja. Încasarea apare când contabilitatea înregistrează extrasul Victoriabank; până atunci deal-ul rămâne „în așteptare plată”, iar operatorul vede plata din comentariul comenzii, din analitica „QR MIA” și din mesajul Telegram. Dacă deal-ul trebuie să treacă pe „plătit” imediat, se hotărăște în etapa 5 (vezi §15.5).
5. Chitanță pe e-mail, cu câmpurile cerute de bancă (§9).
6. Mesaj în canalul Telegram al comenzilor (`SP_TELEGRAM_SEND`).
7. Bonul fiscal: îl emite `@ECC_ONLINE`, care vede plata prin view (etapa 4).

## 8. Etape

Fiecare etapă se poate testa singură. Ordinea e obligatorie până la etapa 4; etapele 5 și 6 pot merge în paralel.

| # | Etapă | Conținut | Depinde de |
|---|---|---|---|
| 0 | Precondiții | **Primite**: credențiale de test, IBAN de test. **De trimis băncii**: URL-ul de callback (§10) | bancă |
| 1 | Client API + diagnostic | **Gata** (§12): `VbMiaClient`, configurare, certificat, comenzile de consolă | — |
| 2 | Tabele + logică + webhook | **Gata** (§13); rămâne rularea scriptului pe SW de către DBA și publicarea pe server | DBA |
| 3 | Checkout + pagina de plată | **Gata** (§14); plasarea reală a unei comenzi cu MIA se poate proba abia după rularea scriptului pe SW | DBA |
| 4 | Fiscalizare | **Gata** (§15); `SWNService.exe` recompilat, de instalat pe server | instalare |
| 5 | WMS | **Gata** (§16); `SWN.exe` de recompilat cu aplicația închisă | DBA, build |
| 6 | Conformitate + producție | **Gata partea de cod** (§17); lansarea cere pașii din §17.5 | bancă, publicare |
| 7 | (ulterior) maib alături de VB | adaptor `MiaProvider` peste codul maib existent, regulă de alegere în `MiaGateway` (de ex. rezervă când o bancă nu răspunde) | decizie separată |

Cronuri necesare pe server (de instalat efectiv, nu doar de scris):

- `php yii mia-vb/reconcile` la 2 minute: QR-urile active mai vechi de un minut → stare → confirmare sau expirare; semnalele salvate și neprocesate.
- `php yii mia-vb/daily` o dată pe zi: lista de reconciliere a zilei precedente față de tabelă. Plată la bancă fără cerere `Paid` la noi → alertă. Tot de aici se completează numele plătitorului.

## 9. Cerințele băncii pentru comerciant

Banca le verifică la activare; o implementare neconformă poate fi blocată.

### 9.1. Cerințele de acceptare din e-mailul băncii (6 oct 2026)

| Cerință | Starea pe site | De făcut |
|---|---|---|
| Termenii și condițiile de plată afișate | există pagina de condiții | de adăugat secțiunea despre plata MIA |
| Condițiile și procedura de returnare a bunurilor și a banilor, anularea tranzacției — conform Legii 105/2003 | există `/schimbreturgarantie` | de verificat că acoperă rambursarea banilor și anularea plății |
| Mesaj privind securitatea informației clientului și politica de securitate — conform **Legii 195/2024** privind protecția datelor | există politica de confidențialitate | de verificat că textul trimite la Legea 195/2024, nu la cea veche (133/2011) |
| **Bifă** de acord cu termenii, politica de retur și confidențialitatea înainte de tranzacție | la finalizare e doar un text („Plasând comanda, sunteți de acord…”), fără bifă și fără politica de retur | bifă obligatorie când e aleasă MIA, cu cele trei linkuri (etapa 3) |
| Denumirea și adresa juridică a comerciantului | de verificat în subsol | etapa 6 |

Ce cere banca după confirmarea plății: actualizarea stării comenzii, înlocuirea mesajului „În așteptarea confirmării plății” cu „Plătit”, finalizarea procesării comenzii și un e-mail de confirmare către client.

### 9.2. Cerințele din ghidul de integrare

- Pe site, vizibile: denumirea juridică, IDNO, adresa juridică, telefon, e-mail.
- Sigla oficială MIA (brandbook: `mia.bnm.md/ro/business`), nemodificată, minimum 32 px, la metodele de plată și la checkout.
- Termeni și condiții: cum decurge plata MIA, drepturile cumpărătorului, protecția consumatorului (Legea 105/2003), date personale (Legea 133/2011), retur și rambursare (minimum 14 zile), dispute, livrare.
- Chitanță pe e-mail imediat după plată: comerciant + IDNO + contacte, numărul comenzii, lista produselor, totalul și moneda, data și ora, metoda „MIA Instant Payment”, referința tranzacției (segmentul 4), politica de retur.

Problemă deschisă: oaspeții nu dau e-mail la finalizarea comenzii. Propunere: câmp de e-mail opțional, afișat când e aleasă MIA; chitanța rămâne oricum disponibilă la linkul paginii de plată și se trimite SMS cu linkul.

## 10. De trimis și de cerut băncii

**De trimis acum** — URL-ul de callback: `https://www.fantastic.md/mia-vb/signal`. Gazda corectă e `www.fantastic.md`; `fantastic.md` fără `www` nu a răspuns la proba din 6 oct 2026. Adresa va răspunde abia după etapa 2 și publicarea pe server; până atunci banca primește 404, fără efect asupra testelor (starea se citește prin polling).

Întrebări:

1. ~~Credențiale de test și IBAN~~ — primite pe 6 oct 2026.
2. Se pot avea URL-uri de callback diferite pentru test și producție și pentru al doilea site?
3. Simulatorul `demopay` răspunde 202 la fiecare cerere, dar plata s-a executat o singură dată (11:04, QR `5e450aa6-50e1-43ed-bdba-7ba3ff4ef200`). Cererile următoare (QR `4282779d-…`, `36948217-…`, `f258e32a-…`, `7bf416d2-…`, `244f1e7f-…`) au rămas `Active`. Există o limită sau o condiție?
4. Există restricții de IP pentru API-ul de producție? De pe ce adrese vin semnalele? Adresele trebuie trecute ca permise în `TWEB_BLOCKED_IP` (`FLG_WHITELIST = 1`): garda de securitate a site-ului (`SecurityGuard`) rulează la fiecare cerere și ar putea bloca banca.
5. Limitele reale de TTL pentru contul nostru.
6. `ReturnUrl` / `CancelUrl`: sunt acceptate la `POST /api/v1/qr`?
7. Deeplink pe mobil: e suficient să deschidem `qrAsText`?
8. Rambursarea parțială este suportată oficial?
9. Reîncercările webhook-ului: de câte ori și la ce interval?
10. Cum anunță schimbarea certificatului `VBCA`?
11. `DELETE /api/v1/qr/{uuid}` imediat după creare răspunde 500 `VB10000 Internal error`, deși codul devine `Cancelled`. Este un comportament cunoscut?

## 11. Decizii de luat

| Subiect | Recomandare |
|---|---|
| Momentul creării comenzii | Comanda întâi, plata după (§5) |
| Firma și contul | Contractul VB și IBAN-ul trebuie să fie ale firmei pe care intră comenzile web (316910), altfel bonul fiscal și încasarea ajung pe firme diferite. **De confirmat** |
| Analitica de plată | Una singură, `PAY_QR_MIA`; banca se vede în comentariu și în view. Dacă contabilitatea vrea separare pe bănci, se adaugă o a doua analitică |
| Promo la MIA | Fără reducerea din cod promoțional (rămâne doar la numerar și cont spre plată), ca la celelalte plăți online |
| „Cumpără acum” (1 click) | Nu în v1; se adaugă după ce fluxul din checkout e stabil |
| Clientul nu plătește | Comanda rămâne; pagina oferă cod nou sau „plătesc la primire” |
| Rambursări | v1: formular intern, doar integral. Returul bonului fiscal se tratează separat, în WMS |

## 12. Etapa 1 — realizată (6 oct 2026)

În `fantastic.web` (ramura `feature/brand-themes`, necomis):

| Fișier | Conținut |
|---|---|
| `components/VbMiaClient.php` | token cu cache, creare QR, stare, ultimul semnal, anulare, rambursare, reconciliere, sănătate, simulare plată; `findPayment()` și `txIdFromReference()` pentru citirea răspunsurilor |
| `commands/MiaVbController.php` | `php yii mia-vb/health`, `token`, `create-test`, `status`, `signal`, `pay-test`, `cancel`, `refund`, `transactions`, `self-test` |
| `data/certs/vbca-2026.cer` | certificatul băncii (valabil până la 3 iul 2027) |
| `config/brand.php`, `brands/*.php`, `brand-params.php` | blocul `miaVb` (implicit `enabled => false`) |
| `config/web.php`, `config/console.php` | componenta `vbMia` și jurnalul `runtime/logs/mia-vb.log` |
| `config/brand.local.php` (în afara git) | credențialele și adresele mediului de test |

Site-ul nu e afectat: componenta nu e apelată de nicăieri în afara comenzilor de consolă.

Verificat pe mediul de test al băncii, cu credențialele `fantastic.md`:

| Operație | Rezultat |
|---|---|
| Sănătate, token | 200; token valabil 3600 s |
| Creare QR dinamic (1 leu, TTL 5 min) | 200; `qrAsText` = URL scurt, imagine PNG |
| Stare după creare | `Active`, aceeași extensie ca la creare |
| Plată simulată → `Paid` → semnal `Payment` | reușit **o dată**, cu cereri `curl` directe (referința `…VICBMD2XAXXX261006398740000093907`). Prin `self-test`, simulatorul a răspuns 202 dar nu a mai executat nicio plată — nici la o cerere `curl` identică cu cea reușită |
| Reconciliere | 200; plata apare cu `creditorRef`, numele plătitorului, stare `Approved` |
| Rambursare integrală | 204 |
| Anulare QR | codul devine `Cancelled`; răspunsul HTTP a fost 500 `VB10000` la anularea imediat după creare și 200 la un cod mai vechi de un minut |

Nu e verificat: `self-test` cap-coadă prin clientul PHP (pasul „stare Paid” depinde de simulator), expirarea naturală a unui cod, verificarea semnăturii JWT (nu am primit încă niciun semnal semnat — vine odată cu webhook-ul, etapa 2).

Pe producție: `config/brand.local.php` de acolo primește adresa și credențialele de producție, fără `demoPayUrl`. De verificat dacă PHP-ul serverului are pachet CA pentru `curl`; local a fost nevoie de `caFile`.

## 13. Etapa 2 — realizată (6 oct 2026)

### 13.1. Ce s-a adăugat

| Fișier | Conținut |
|---|---|
| `DB Model/mia_vb_payments.sql` (+ `_rollback.sql`) | tabelele `TWEB_MIA_VB_PAYMENT` și `TWEB_MIA_VB_QR`, procedurile `WEB_MIA_VB_PAYMENT_CREATE` și `WEB_MIA_VB_CONFIRM`, view-ul `VW_WEB_MIA_PAYMENTS`, codul 5 în `FN_DEAL_WEB_PAYMENT_METHOD`, drepturi pentru `WEBUSER` și `SWN`. Re-rulabil. **Nerulat pe SW** |
| `fantastic.web/models/VbMiaPayment.php` | accesul la cele două tabele |
| `fantastic.web/helpers/VbMiaSignal.php` | verificarea notificării băncii (JWT RS256, listă de certificate) |
| `fantastic.web/components/VbMiaService.php` | `start`, `ensureQr`, `check`, `syncQr`, `confirmPaid`, `handleSignal`, `abandon`, `refund`, `reconcile`, `daily` |
| `fantastic.web/controllers/MiaVbController.php` | `POST /mia-vb/signal` (webhook), răspuns 204 |
| `fantastic.web/commands/MiaVbController.php` | cronuri `mia-vb/reconcile` și `mia-vb/daily`; `mia-vb/start <docId>`, `check <token>`, `refund-payment <id>` |
| `fantastic.web/config/url.php` | ruta `mia-vb/signal` |

### 13.2. Abateri față de §6

- **Confirmarea plății e o procedură stocată** (`WEB_MIA_VB_CONFIRM`), nu cod PHP. Marchează cererea, pune comentariul și analitica pe comandă și trimite mesajul Telegram într-o singură tranzacție, cu rândul cererii blocat. PHP-ul site-ului face o tranzacție separată la fiecare apel, deci numai așa confirmarea rămâne atomică atunci când pagina, cronul și webhook-ul sosesc deodată.
- Rezultatele procedurii: `PAID`, `ALREADY` (același cod deja prelucrat), `DUPLICATE` (cererea era plătită prin alt cod — clientul a plătit de două ori; alertă în `ERRORS`), `MISMATCH` (altă sumă; comanda nu se marchează plătită; alertă), `NOT_FOUND`.
- `TWEB_MIA_VB_PAYMENT` are în plus `BRAND` (cheia site-ului: fiecare site are credențialele lui la bancă, deci cronul unuia nu atinge codurile altuia) și `RECEIPT_SENT_AT` (pentru chitanța din etapa 3).
- `TWEB_MIA_VB_QR` are în plus `TX_ID` (marchează codul ca prelucrat); `SIGNAL_DATA` e `VARCHAR(2000)`, nu BLOB (driverul PHP cere actualizări separate pentru BLOB-uri).
- Nu există o coadă de semnale neprocesate: dacă prelucrarea unei notificări eșuează, plata o găsește cronul citind starea codului la bancă.
- Procedura de creare refuză documentele care nu sunt în lei (`NOT_MDL`): MIA acceptă doar MDL. La checkout, plăcuța MIA trebuie ascunsă clienților cu prețuri în USD (etapa 3).
- **Suma de plată = `TDB_DOCS.SUMA`** (totalul documentului), nu suma liniilor — schimbat în etapa 4, vezi §15.3.
- Deal-ul nu se atinge la confirmare (vezi §7).

### 13.3. Ce s-a verificat

Baza de probă e una locală (`C:\Temp\miavb\MIAVB_TEST.FDB`, Firebird 5), cu obiecte-ciot pentru ce există doar pe SW. Banca e mediul de test real.

| Verificare | Rezultat |
|---|---|
| Scriptul DDL rulat de două ori la rând | fără erori (re-rulabil) |
| 14 scenarii SQL pe proceduri: creare, document în USD / șters / inexistent / fără linii, plată corectă, repetată, dublă, sumă diferită, document șters între timp | toate trec |
| 18 cazuri pe verificarea notificării: validă, cheie greșită, conținut modificat, `alg: none`, `HS256`, fără semnătură, corp invalid, rotația certificatului | toate trec |
| 27 de verificări cap-coadă prin serviciul PHP + banca de test: cerere, cod QR, refolosire, renunțare (cod anulat și la bancă), cod nou la expirare, sumă diferită, reconciliere | toate trec |
| Calea „banca arată `Paid`” pe codul plătit dimineața (`5e450aa6…`) | cronul a înregistrat plata cu referința reală; verificarea zilnică a găsit-o și a completat numele plătitorului |
| Webhook prin serverul local | 405 la GET, 204 la corp invalid și la semnătură falsă (ambele jurnalizate); pagina principală a site-ului răspunde 200 |
| Comenzile de cron pe SW, unde tabelele nu există încă | eroare clară („Table unknown”), fără excepție neprinsă |

### 13.4. Ce NU s-a verificat

- **Codul PHP direct pe Firebird.** PHP-ul local nu se poate conecta la baza de probă (nu am drept să creez un utilizator în serverul Firebird local), așa că interogările au rulat prin `isql`, cu parametrii înlocuiți cu literali. Legarea parametrilor de către driverul `ibase` și drepturile lui `WEBUSER` se văd abia după ce scriptul rulează pe SW: `php yii mia-vb/start <docId>` pe o comandă de test.
- **Confirmări cu adevărat simultane.** Baza de probă se deschide exclusiv, deci patru sesiuni paralele nu au putut rula împreună; blocarea rândului (`WITH LOCK`) e verificată doar prin apeluri repetate, nu concurente.
- **O notificare reală semnată de bancă.** Verificarea semnăturii e testată cu chei generate local; cu certificatul `VBCA` abia după ce banca înregistrează URL-ul și site-ul e publicat.
- **Plata simulată prin clientul PHP**, din cauza simulatorului băncii (§10, întrebarea 3).

### 13.5. Pași de făcut de DBA și la publicare

1. DBA rulează `DB Model/mia_vb_payments.sql` pe SW (ultimele două interogări din script arată obiectele create și `MIA QR` pentru codul 5).
2. Verificare după rulare: `php yii mia-vb/start <DOCID al unei comenzi web de test>`, apoi `php yii mia-vb/check <token>`.
3. La publicarea pe server: fișierele din §12 și §13.1, `config/brand.local.php` cu blocul `miaVb`, apoi cronurile `mia-vb/reconcile` (la 2 minute) și `mia-vb/daily` (o dată pe zi).
4. URL-ul de callback de comunicat băncii: `https://www.fantastic.md/mia-vb/signal`.

## 14. Etapa 3 — realizată (6 oct 2026)

### 14.1. Ce vede clientul

1. La finalizarea comenzii apare plăcuța **„MIA plăți instant”** (cu sigla MIA), între „Card la primire” și „Cont spre plată”.
2. La alegerea ei se deschide un panou cu: explicația pe scurt, un câmp de e-mail opțional (pentru confirmarea plății) și **bifa de acord** cu termenii de plată, politica de returnare și politica de confidențialitate — obligatorie, verificată și pe server.
3. După „Plasează comanda” comanda e înregistrată (ca la numerar), iar clientul ajunge pe `/plata-mia/<token>`: starea „În așteptarea confirmării plății”, numărul comenzii, suma, codul QR, cronometrul și pașii.
4. Pe telefon, deasupra codului apare butonul „Deschide aplicația băncii” (linkul `qrAsText`).
5. Pagina întreabă serverul la 5 secunde. La confirmare starea devine **„Plătit”**, apoi clientul e dus pe pagina de mulțumire.
6. Dacă codul expiră: „Generează un cod nou” (cel vechi se anulează la bancă înainte). Oricând: „Plătesc la primire” — codul se anulează, pe comandă apare comentariul pentru operator, clientul ajunge pe pagina de mulțumire.

### 14.2. Ce s-a adăugat

| Fișier | Conținut |
|---|---|
| `helpers/MiaGateway.php` | stratul comun: prin ce bancă merge MIA pe site, dacă metoda e disponibilă, pornirea plății |
| `helpers/CheckoutOrder.php` | metoda `mia` (`rbPay_Mia`, `PAYMENT_TYPE = 5`); ascunsă dacă banca nu e activată sau clientul are prețuri în USD; validarea acordului și a e-mailului; redirecționarea spre pagina de plată |
| `views/shopcart/checkout.php`, `web/js/checkout.js`, `web/css/checkout.css` | plăcuța, panoul, bifa, validarea din pagină |
| `controllers/MiaVbController.php` | `pay`, `status`, `regenerate`, `abandon` (pe lângă `signal`) |
| `views/mia-vb/pay.php`, `web/js/mia-pay.js`, `web/css/mia-pay.css` | pagina de plată; se încarcă doar pe această pagină |
| `helpers/VbMiaReceipt.php`, `templates/emails/MiaPayment-ro.htm`, `-ru.htm` | e-mailul de confirmare a plății, trimis o singură dată, la confirmare |
| `helpers/TranslatesHelper.php` | textele RO + RU |
| `helpers/ShopCartHelper.php` | textul metodei în comentariul comenzii și în e-mailul comenzii |
| `controllers/ShopCartController.php` | pagina de mulțumire își ia produsele din datele comenzii când coșul din sesiune e deja golit |
| `config/params.php`, `config/url.php` | `mia` în lista metodelor; rutele paginii |
| `web/img/mia-logo.jpg` | sigla (copie a celei din `web/images/`, care nu e în git) |
| `fantastic.web/CLAUDE.md`, `AGENTS.md` | secțiunea „MIA Victoriabank” |

Codul `rbPay_MiaQr` (MIA maib) a rămas neatins; metoda nouă folosește `rbPay_Mia`.

### 14.3. Abateri față de plan

- **Dacă plata nu poate fi pornită** (banca nu răspunde, tabelele lipsesc), clientul ajunge direct pe pagina de mulțumire: comanda există și o preia operatorul. Eroarea se scrie în jurnal.
- **Starea de la bancă se ține 3 secunde în cache per token**, ca mai multe file deschise (sau un vizitator rău-intenționat) să nu trimită băncii mai mult de o cerere la câteva secunde.
- Codul promoțional nu se aplică la MIA (ca la celelalte plăți online); rămâne doar la numerar și cont spre plată.
- Pagina `optiunideplata` (textul despre „linkul trimis de operator”) nu a fost modificată: se actualizează la activarea metodei, în etapa 6.

### 14.4. Ce s-a verificat

Printr-un punct de intrare de test (`C:\Temp\miavb\php-tests\test-router.php`): site-ul local rulează normal, dar tot SQL-ul MIA Victoriabank merge în baza de probă, iar scrierile în SW sunt blocate.

| Verificare | Rezultat |
|---|---|
| Pagina de plată, desktop RO și telefon RU (Playwright) | cod QR afișat, cronometru, fără erori JS, fără derulare orizontală |
| Trecerea automată pe „Plătit” cu plata reală de la bancă (codul `5e450aa6…`) | pagina a trecut singură din „În așteptarea confirmării plății” în „Plătit”; cererea marcată `Paid` cu referința reală; e-mailul pus în coadă; mesajul Telegram generat |
| Expirare, apoi „Generează un cod nou” | stare „Codul a expirat”, cod nou emis, cel vechi `Cancelled` și la bancă |
| „Plătesc la primire” | cererea `Cancelled`, codul anulat, comentariu pe comandă, redirecționare la pagina de mulțumire |
| Link invalid | pagină „Linkul de plată nu este valid”, HTTP 404 |
| Pagina de finalizare cu MIA activată | plăcuța apare; panoul se deschide; fără bifă și cu e-mail greșit — două erori, comanda nu pleacă |
| Serverul, cu JS-ul ocolit | refuză fără acord și cu e-mail greșit |
| Configurarea reală (`enabled => false`) | metodele rămân `cash, card_courier, invoice, credit`; pagina de finalizare e neschimbată |
| Testele etapei 2, rulate din nou | 27 din 27 |

Capturi: `C:\Temp\miavb\shots\` (`pay-desktop-ro.png`, `pay-mobile-ru.png`, `pay-paid.png`, `pay-expired.png`, `pay-cancelled-ru.png`, `checkout-mia.png`).

### 14.5. Ce NU s-a verificat

- **Plasarea reală a unei comenzi cu MIA** (`CheckoutOrder::place()` până la redirecționare). Serverul local scrie în baza de producție, deci nu am creat comenzi de probă. Ramura nouă e scurtă (pornește plata după crearea comenzii), dar rulează prima dată abia după scriptul DDL, pe o comandă de test făcută de tine.
- **Deschiderea aplicației băncii de pe un telefon real** (linkul `qrAsText`): pe mediul de test linkul e `mia-qr-test.bnm.md`, pe care aplicațiile reale nu îl recunosc.
- **E-mailul într-un client de e-mail** și trimiterea efectivă: corpul a fost generat și pus în coada de test; aspectul în Gmail / Outlook nu e verificat.
- **Tema tehnomarket**: pagina folosește variabilele comune `--co-*`; pe tehnomarket metoda e oricum ascunsă (fără `miaVb`).
- Cele din §13.4 rămân valabile (driverul PHP → Firebird, confirmări simultane, notificare semnată de bancă).

### 14.6. De hotărât înainte de activare

- **Comerciantul din e-mailul de confirmare** vine din profilul brandului: „Prime Store SRL, IDNO 1018600038447”. Comenzile web intră însă pe firma 316910 (SOLUTII COMERCIALE SRL). Banca cere în chitanță comerciantul care încasează, deci trebuie pus cel din contractul cu Victoriabank.
- **Textul despre retur din e-mail** („14 zile de la primire, Legea nr. 105/2003”) trebuie confirmat de cine răspunde de condițiile comerciale.
- **Sigla MIA**: e imaginea existentă pe site (fond crem); brandbook-ul oficial e la `mia.bnm.md/ro/business`.

### 14.7. Cum se activează (după scriptul DDL)

1. `config/brand.local.php` pe server: blocul `miaVb` cu `enabled => true`, adresa și credențialele mediului dorit.
2. Probă: o comandă mică, plătită cu „MIA plăți instant”; pe test, plata se simulează cu `php yii mia-vb/pay-test <qrHeaderUUID>`.
3. Cronurile `mia-vb/reconcile` și `mia-vb/daily`.

## 15. Etapa 4 — realizată (6 oct 2026)

### 15.1. Ce s-a schimbat

`DB Service/ECCOnlineFiscalUnit.pas` (jobul `@ECC_ONLINE` din `SWNService`):

- Plățile MIA confirmate se citesc din view-ul comun `VW_WEB_MIA_PAYMENTS` (maib + Victoriabank), nu direct din `TWEB_MIA_QR_PAYMENTS`.
- **Rezervă:** dacă view-ul nu există în bază (scriptul `mia_vb_payments.sql` nerulat încă), jobul citește doar tabela maib, ca înainte. Verificarea se face la fiecare ciclu, deci scriptul poate fi rulat cu serviciul pornit, iar ordinea „întâi exe, apoi script” sau invers nu contează.
- Plățile Victoriabank rămân `SOURCE_TYPE = 4` (MIA) în jurnalul `TFP_ECC_TRANSACTION`; referința e identificatorul codului QR plătit, unic între bănci. Jurnalul existent pentru maib nu e afectat.
- În jurnalul jobului apare banca: „plata MIA Victoriabank …” / „MIA maib …”.

Restul jobului e neschimbat: bon pe casa ECC a firmei comenzii, liniile din `GET_GOODS_FOR_RECEIPT`, plata tip 7, un singur bon activ per plată, cel mult 3 încercări eșuate.

`SWNService.exe` e recompilat (`DB Service\SWNService.exe`, 6 oct 2026 13:33). **Nu e instalat pe server.**

### 15.2. Ce s-a verificat

Cu un program de test (`C:\Temp\miavb\ecc-test\EccOnlineTest.dpr`) care rulează jobul real pe două baze locale de probă; casa ECC din ele arată spre un port închis, deci niciun bon nu pleacă.

| Caz | Rezultat |
|---|---|
| Baza cu view: plată Victoriabank corectă (comanda 3001, 150 lei) | ajunge până la trimiterea bonului; rând în jurnal înainte de trimitere; „legătura cu ECC a căzut”, rămâne în așteptare |
| Plată Victoriabank pe o comandă modificată după plată (80 plătit, 90 în document) | oprită: „Suma comenzii diferă de plată — bonul se face manual” |
| Cerere Victoriabank neplătită, cerere cu sumă diferită la bancă (`Mismatch`) | nu apar deloc (nu se fiscalizează) |
| maib plătită cu comandă | ca înainte |
| maib plătită fără comandă | raportată o singură dată, cu banca în text |
| maib expirată; maib plătită înainte de `ONLINE_FROM` | excluse |
| Al doilea ciclu pe aceeași bază | fără rânduri duble în jurnal; plata fără comandă nu se mai raportează |
| Baza fără view | doar plățile maib, fără eroare |
| Scriptul DDL după modificare, rulat de două ori; 15 scenarii SQL; 27 de verificări ale serviciului PHP | toate trec |

### 15.3. Suma de plată: totalul documentului

Jobul refuză bonul dacă plata diferă de totalul comenzii, iar `GET_GOODS_FOR_RECEIPT` construiește bonul pe `TDB_DOCS.SUMA`. Procedura `WEB_MIA_VB_PAYMENT_CREATE` lua însă suma din liniile comenzii. La o comandă proaspătă cele două coincid (964 din 965 comenzi web recente de pe SW), dar există și excepții (comanda 2178326: total 5882, linii 6132). Procedura ia acum `TDB_DOCS.SUMA`; suma liniilor rămâne rezervă când totalul lipsește.

### 15.4. Ce NU s-a verificat

- **Un bon emis efectiv de ECC** pentru o plată Victoriabank: depinde de casa ECC reală și de plăți reale.
- **Jobul rulat de serviciul instalat**, pe SW: testul a rulat același cod, dar dintr-un program de consolă pe 64 de biți, cu baze de probă UTF8.
- **Comenzi cu linii negative** (cashback, cod promoțional): nu am verificat cum le tratează bonul ECC. E comportamentul existent, comun cu plata prin card; de urmărit la prima astfel de comandă.

### 15.5. De hotărât / de făcut

1. **Instalarea noului `SWNService.exe`** pe server (oprire serviciu, înlocuire, pornire). Se poate face înainte sau după scriptul DDL.
2. **Încasarea în WMS.** Banii MIA ajung în contul Victoriabank; documentul de încasare (120) apare abia la înregistrarea extrasului. Până atunci comanda arată neîncasată în WMS, iar deal-ul „în așteptare plată”. Variante pentru etapa 5: (a) rămâne așa, operatorul se uită la comentariu; (b) coloană „plată MIA” în lista comenzilor web; (c) încasarea 120 creată automat la confirmare — cere acordul contabilității.
3. **Returul bonului** la rambursarea unei plăți MIA nu e automatizat (ca la celelalte plăți).

## 16. Etapa 5 — realizată (6 oct 2026)

### 16.1. Ce vede operatorul în WMS (Web-Order)

- **Coloana „Plată MIA”** în lista comenzilor web: „În așteptare”, „Plătit”, „Sumă diferită!”, „Rambursare în curs”, „Rambursat”, „Rambursare eșuată!”, „Renunțat”; goală la comenzile fără plată MIA.
- **„Plată MIA…”** în meniul contextual al listei (pentru cei cu dreptul „Ecomm tranzacții”): fereastră cu starea, suma cerută și plătită, data, tranzacția, plătitorul și:
  - **Creează link** — linkul de plată al comenzii (`https://www.fantastic.md/plata-mia/<token>`); codul QR îl emite site-ul când clientul deschide linkul. Dacă totalul comenzii s-a schimbat, face un link nou pe suma nouă, iar cel vechi se închide;
  - **Copiază** și **Trimite SMS** (pe telefonul din comanda web, prin `SMS_MESSAGES`);
  - **Rambursare** — integrală, cu confirmare; o execută site-ul în câteva minute.
- Crearea linkului, SMS-ul și rambursarea cer și dreptul de modificare a comenzilor web.

Capturi ale ferestrei: `C:\Temp\miavb\wms\shots\`.

### 16.2. Cum e împărțită munca

WMS **nu vorbește cu banca**. Cere prin proceduri, iar site-ul execută:

| Cerere din WMS | Procedură | Cine execută |
|---|---|---|
| link de plată | `WEB_MIA_VB_CREATE_LINK` | pagina de plată emite codul QR la deschidere |
| rambursare | `WEB_MIA_VB_REQUEST_REFUND` → starea `RefundRequested` | cronul `mia-vb/reconcile` → `Refunded` sau `RefundFailed` (cu alertă Telegram și comentariu pe comandă) |
| SMS cu linkul | `WEB_MIA_VB_LINK_SMS` | serviciul SMS existent |

Tot cronul anulează la bancă codul unei cereri închise (link înlocuit din WMS), ca să nu mai poată fi plătit.

### 16.3. Ce s-a adăugat

| Fișier | Conținut |
|---|---|
| `DB Model/mia_vb_payments.sql` | cele trei proceduri de mai sus, drepturi pentru `SWN`, stările `RefundRequested` / `RefundFailed` |
| `sources/classes/WebMia/SWNMiaPaymentsUnit.pas` | partea de date, fără interfață și fără `dmDB` (testabilă separat) |
| `sources/classes/WebMia/SWNMiaPaymentsDialogUnit.pas` | coloana, butonul și fereastra, construite în cod (fără `.dfm`) |
| `sources/frames/frame24WebZakazUnit.pas` | trei apeluri: coloana și butonul la afișarea ferestrei, handlerul butonului |
| `sources/SWN.dpr`, `SWN.dproj` | cele două unități noi |
| `fantastic.web/components/VbMiaService.php`, `models/VbMiaPayment.php`, `commands/MiaVbController.php` | rambursările cerute din WMS și anularea codurilor cererilor închise, în `mia-vb/reconcile` |

Coloana **nu** vine din interogarea comună a documentelor (`dmDB.IBCQueryDocs`): stările se citesc separat, o dată pe minut, și se afișează după `DOCID`. Lista documentelor nu depinde astfel de tabelele MIA; fără script rulat, coloana și butonul lipsesc pur și simplu.

Adresa paginii de plată și brandul se pot schimba din Setări > Configurări API, `API_CODE = 'MIA_VB'`: `PAY_URL`, `BRAND`.

### 16.4. Ce s-a verificat

| Verificare | Rezultat |
|---|---|
| Scriptul DDL cu procedurile noi, rulat de două ori; scenariile SQL | fără erori |
| Logica WMS (`SWNMiaPaymentsUnit`) pe baza de probă: link nou, refolosire, link nou la schimbarea totalului, SMS, stare plătit, cerere de rambursare, refuzuri, configurare | 26 din 26 |
| Cererile WMS executate de cron, cu banca de test: rambursare refuzată de bancă → `RefundFailed` + comentariu + alertă; cerere repetată; cod anulat la bancă după înlocuirea linkului | 16 din 16 |
| Fereastra „Plată MIA”, desenată pe baza de probă în 4 stări | butoanele și textele corespund stării |
| Suitele anterioare (27 serviciu PHP, 18 semnătură) | trec |
| Compilarea `SWN` | fără erori; legarea a eșuat cu F2039 fiindcă `SWN.exe` era deschis |
| **Pe SW, doar citire**, cu utilizatorul site-ului: `mia-vb/check`, `mia-vb/reconcile`, `mia-vb/daily --alert=0` | rulează fără eroare — driverul PHP și drepturile de citire sunt în regulă |

### 16.5. Starea de pe SW și ce NU s-a verificat

- **Pe SW e rulată prima versiune a scriptului** (verificat 6 oct 2026): există tabelele, view-ul, `WEB_MIA_VB_PAYMENT_CREATE` și `WEB_MIA_VB_CONFIRM`. Lipsesc corectarea sumei (§15.3) și cele trei proceduri pentru WMS. **Scriptul trebuie rulat din nou** — e re-rulabil și nu atinge datele.
- **Coloana și butonul în WMS-ul real** nu au fost văzute rulând: unitățile compilează, fereastra a fost desenată separat, dar grila din `frame24` are nevoie de `SWN.exe` reconstruit.
- **O rambursare reușită** prin cron: banca de test a refuzat tranzacția fictivă (404), deci e verificată doar calea de refuz. Rambursarea în sine a reușit o dată, direct din consolă (§12).
- **SMS-ul trimis efectiv** și **scrierile PHP pe SW** (crearea cererii, confirmarea): abia la prima comandă de probă.

### 16.6. De făcut

1. DBA rulează din nou `DB Model/mia_vb_payments.sql` pe SW.
2. Închizi `SWN.exe` și reconstruiești proiectul (`msbuild sources\SWN.dproj`), apoi verifici în Web-Order coloana și „Plată MIA…”.
3. Publicarea fișierelor PHP modificate (cronul `mia-vb/reconcile` execută acum și rambursările).

## 17. Etapa 6 — realizată (6 oct 2026)

### 17.1. Cerințele de acceptare ale băncii — starea

| Cerință (e-mailul băncii, §9.1) | Unde | Stare |
|---|---|---|
| Termenii și condițiile de plată | `/conditiigenerale`, secțiunea XI: subsecțiunea „Plata instant MIA (cod QR)” — cum decurge plata, siguranța datelor, confirmarea pe e-mail, rambursarea | **adăugat**; apare doar cu MIA activată |
| Returnarea bunurilor și a banilor, anularea tranzacției (Legea 105/2003) | `/conditiigenerale` §5 (anulare, termene de rambursare pe metode de plată) și §X (retur, 14 zile, Legea 105/2003); `/schimbreturgarantie` | **exista**; MIA e acoperită de „Online / card / transfer bancar (plată în avans) — restituire integrală prin aceeași modalitate, maximum 14 zile” |
| Securitatea informației și politica de securitate (Legea 195/2024) | `/conditiigenerale` (secțiunea despre date, la zi cu Legea 195/2024); `/privacypolicy` | `/privacypolicy` trimitea doar la Legea 133/2011 (abrogată): **adăugată o notă** RO/RU care trimite la Legea 195/2024 și la Condițiile generale. Rescrierea completă a politicii e recomandată, dar e text juridic |
| Bifa de acord (termeni, retur, confidențialitate) | pagina de finalizare, panoul MIA (etapa 3) | **gata**; linkul „termeni” duce acum la `/conditiigenerale` (pagina completă), nu la vechea `/conditions` |
| Denumirea și adresa juridică a comerciantului | subsolul site-ului | **adăugat**: denumire, IDNO, adresă, plus sigla MIA lângă Visa / Mastercard / Apple Pay; doar cu MIA activată |

**Defect găsit pe site-ul live:** `/conditiigenerale` dădea 404. Linkul „Termeni și condiții” din subsol (`/ro/conditiigenerale`) redirecționa acolo, deci pagina de termeni în română era inaccesibilă — exact pagina pe care banca o verifică. Reparat în `config/url.php`.

### 17.2. Ce s-a adăugat

| Fișier | Conținut |
|---|---|
| `config/url.php` | ruta `conditiigenerale` (reparația de mai sus) |
| `templates/content/fantastic/conditii-generale.ro.php` | subsecțiunea „Plata instant MIA (cod QR)” |
| `templates/content/fantastic/privacypolicy.ro.php` | nota despre Legea 195/2024, RO + RU (vizibilă mereu) |
| `templates/content/fantastic/optiunideplata.ro.php` | cardul și rândul MIA descriu plata din checkout când metoda e activă; altfel rămâne textul vechi (link de la operator) |
| `views/layouts/_footer.php` | comerciantul și sigla MIA, doar cu MIA activată |
| `helpers/MiaGateway.php` | `merchant()` — titularul contractului: implicit firma brandului, configurabil în `miaVb.merchant` |
| `helpers/VbMiaReceipt.php` | e-mailul de confirmare folosește același comerciant |
| `views/shopcart/checkout.php` | linkul „termeni” din bifa MIA → `/conditiigenerale` |
| `helpers/VbMiaSignal.php`, `commands/MiaVbController.php` | `php yii mia-vb/preflight`; `mia-vb/daily` anunță în `ERRORS` când certificatul băncii expiră în mai puțin de 30 de zile |

Cu MIA dezactivată, site-ul arată ca înainte, cu două excepții voite: ruta reparată și nota din politica de confidențialitate.

### 17.3. `php yii mia-vb/preflight`

Verificare de rulat înainte de activare și după fiecare publicare. Doar citește. Controlează: configurarea `miaVb`, mediul (test / producție, fără simulator pe producție), certificatul băncii și zilele rămase, răspunsul și autentificarea la bancă, obiectele din bază, codurile uitate active (cronul nu rulează), plățile care cer atenție, comerciantul, șabloanele e-mailului, adresa de notificare de comunicat băncii. Iese cu cod 1 la orice eroare.

Rulat pe 6 oct 2026 cu configurarea locală (banca de test + baza SW): **nicio eroare**; o atenționare — metoda e dezactivată.

### 17.4. Ce s-a verificat

| Verificare | Rezultat |
|---|---|
| `/conditiigenerale`, `/ro/conditiigenerale`, `/ru/conditiigenerale` | 200 (înainte: 404 pentru română) |
| Cu MIA activată: subsol (comerciant + siglă), cardul din „Cum plătesc?”, secțiunea din termeni, nota din politica de confidențialitate RO/RU | toate prezente, fără erori JS |
| Cu configurarea reală (MIA dezactivată) | subsolul, cardul și termenii neschimbați; nota de confidențialitate prezentă |
| `mia-vb/preflight` pe SW | nicio eroare |

Capturi: `C:\Temp\miavb\shots\s6-*.png`.

### 17.5. Lansarea — pași

**De la bancă / de la tine:**

1. **Titularul contractului: SOLUTII COMERCIALE SRL** (confirmat 6 oct 2026 — contractul cu Victoriabank e doar pe această firmă). Setat în `config/brands/fantastic.php` → `miaVb.merchant`: IDNO 1026023142430, adresa juridică mun. Chișinău, str. Podul Înalt 18/54 (din ERP, firma 316910). Apare în subsol, în e-mailul de confirmare și în termeni („Beneficiarul plăților MIA este …”). Bonul fiscal se emite tot pe casa firmei comenzii (316910), deci e aceeași firmă.
   **Nepotrivire de rezolvat:** în rest, site-ul declară vânzător **Prime Store S.R.L.** — Condițiile generale („operatorul site-ului este Prime Store S.R.L., MD-2052, str. M. Dragan 2/1A”), definiția „Vânzător” de pe `/conditions` (`{legalName}`) și pagina de contact (`legalName` / `fiscalCode` din profilul brandului). Banca verifică dacă firma de pe site e cea din contract, iar comenzile din ERP intră pe Soluții Comerciale. Schimbarea vânzătorului în termeni e o decizie juridică; tehnic e o modificare de `legalName` / `fiscalCode` / `vatCode` (contact, `/conditions`) plus textul din Condițiile generale.
2. **URL-ul de notificare** comunicat băncii: `https://www.fantastic.md/mia-vb/signal`; de la bancă — adresele IP de pe care vin notificările, pentru `TWEB_BLOCKED_IP` (`FLG_WHITELIST = 1`).
3. **Credențialele de producție** (utilizator, parolă, IBAN de producție) și certificatul `VBCA` valabil pentru producție, dacă diferă de cel de test.
4. **Textul despre retur** din e-mailul de confirmare (14 zile, Legea 105/2003) — confirmat de cine răspunde de condițiile comerciale.

**Publicarea (în ordinea asta):**

1. Fișierele site-ului din §12–§17 (lista: `git status` în `fantastic.web`).
2. `config/brand.local.php` pe server — întâi tot cu mediul de **test**, ca să se poată face testele băncii pe site-ul real:

```php
return (function () {
    $brandKey = getenv('BRAND') ?: 'fantastic';
    $overrides = [];
    if ($brandKey === 'fantastic') {
        $overrides['miaVb'] = [
            'enabled'    => true,
            'baseUrl'    => 'https://ips-api-pj.vb.md',      // test: https://test-ipspj.victoriabank.md
            'demoPayUrl' => '',                               // test: https://test-ipspj-demopay.victoriabank.md
            'username'   => '...',
            'password'   => '...',
            'iban'       => '...',
            // doar daca titularul contractului nu e firma din profilul brandului:
            // 'merchant' => ['name' => '...', 'idno' => '...', 'address' => '...'],
        ];
    }
    return $overrides;
})();
```

3. `php yii mia-vb/preflight` pe server — fără erori.
4. Cronurile, cu utilizatorul site-ului:

```
*/2 * * * *  cd /cale/fantastic.web && php yii mia-vb/reconcile >> runtime/logs/mia-vb-cron.log 2>&1
15 6 * * *   cd /cale/fantastic.web && php yii mia-vb/daily     >> runtime/logs/mia-vb-cron.log 2>&1
```

5. `SWNService.exe` nou (etapa 4) și `SWN.exe` reconstruit (etapa 5), pe stațiile operatorilor.

**Testele băncii** (pe mediul de test, pe site-ul real):

1. O comandă plătită cu „MIA plăți instant” — pe test, plata se simulează cu `php yii mia-vb/pay-test <qrHeaderUUID>` (UUID-ul din `TWEB_MIA_VB_QR`); pagina trebuie să treacă singură pe „Plătit”, iar e-mailul de confirmare să sosească.
2. O comandă plătită și rambursată integral din WMS (Web-Order > „Plată MIA…” > Rambursare).

După acceptul băncii: `brand.local.php` cu credențialele de producție, `preflight`, o plată reală mică, apoi rambursarea ei.

### 17.6. 7 oct 2026 — callback setat la bancă, site-ul publicat

- **Banca a setat callback-ul** `https://www.fantastic.md/mia-vb/signal` pe mediul de test și a repetat cerințele: polling la 5–7 s pe toată valabilitatea codului; după plată — actualizarea stării comenzii, „În așteptarea confirmării plății” → „Plătit”, finalizarea procesării, e-mail de confirmare către client; webhook-ul ca mecanism suplimentar.
- **Pe live, codul e deja publicat** (verificat 7 oct 2026): `/mia-vb/signal` răspunde 405 la GET și 204 la POST; există `/mia-vb/status`, pagina `/plata-mia/<token>` (404 pentru token necunoscut, cum trebuie), `mia-pay.js` / `.css` și sigla; `/conditiigenerale` răspunde 200. Metoda MIA e **dezactivată** (pagina „Cum plătesc?” arată textul vechi, subsolul fără comerciant).

| Cerința băncii | Implementare |
|---|---|
| polling 5–7 s pe toată valabilitatea codului | pagina întreabă la 5 s (`mia-pay.js`, `POLL_MS`); fiecare întrebare citește starea la bancă (cache de 3 s pe token, ca mai multe file să nu înmulțească cererile); la expirare cere cod nou |
| actualizarea stării comenzii | `WEB_MIA_VB_CONFIRM`: cererea → `Paid`, comentariu pe comandă, analitica „QR MIA”, mesaj Telegram; în WMS coloana „Plată MIA” = „Plătit” |
| „În așteptarea confirmării plății” → „Plătit” | exact aceste texte pe pagina de plată, schimbate automat |
| finalizarea procesării comenzii | redirecționare la pagina de mulțumire; bonul fiscal îl emite `@ECC_ONLINE` |
| e-mail de confirmare către client | `VbMiaReceipt`, o singură dată, la confirmare. **Schimbat 7 oct:** e-mailul e acum **obligatoriu** la plata MIA (era opțional — un oaspete fără e-mail nu primea nimic) |
| webhook ca mecanism suplimentar | `POST /mia-vb/signal`, semnătură RS256, răspuns 204; plus cronul `mia-vb/reconcile` |

Cu callback-ul setat și metoda dezactivată, notificările de test care sosesc acum pentru coduri necunoscute se scriu în `runtime/logs/mia-vb.log` („semnal pentru un cod necunoscut”) și se ignoră.
