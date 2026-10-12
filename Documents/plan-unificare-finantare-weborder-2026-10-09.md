# Plan: unificarea Cererii de finantare (1791) cu Web-Order (134)

Data: 9 oct 2026.

Stare (10 oct 2026):
- Deciziile D1-D5 sint luate (vezi sectiunea 4): toate pe varianta recomandata.
- Faza 0 este scrisa: `DB Model/finantare_weborder_faza0.sql`. Inca nerulata pe SW.
- Faza 1 (WMS) este implementata si compilata (detalii in sectiunea 3). Asteapta noul SWN.exe la toti utilizatorii.
- Faza 2 este scrisa si testata local: `DB Model/finantare_weborder_faza2.sql`. Inca nerulata pe SW.
  Se ruleaza doar dupa faza 0 si dupa ce noul SWN.exe e la toti.
- Faza 3 (site) este facuta in fantastic.web, necomisa si nepublicata (detalii in sectiunea 3).
- Pe SW: faza 0 si faza 2 rulate pe 11 oct 2026. Comutatorul FIN_AS_WEBORDER = 1 pornit pe
  12 oct 2026, la 07:23. Pina la pornire n-au fost erori in TDB_DEAL_LOG.
- Faza 4 (curatenie) se poate face cel mai devreme pe 26 oct - 9 nov 2026, daca nu apar probleme.

Scop: o singura comanda de pe site = un singur document **134 Web-Order**. Creditul devine
o **modalitate de plata** a comenzii (ca numerarul, cardul, MIA), iar dosarul de credit
(IDNP, buletin, termen, rata) devine o **anexa** a comenzii, nu un document separat.

---

## 1. Situatia de azi (fapte verificate pe SW si in cod)

### Volume
| | 134 Web-Order | 1791 Cerere de finantare |
|---|---|---|
| total istoric | 53 255 | 5 154 (din 2016) |
| 2026 | 976 | 114 (in scadere: ~700/an in 2020-2022, 277 in 2025) |
| deschise acum (bit 10 = 0) | 0 | 5 (vechi, rostogolite zilnic de SP_UPDATE_DATE_IN_DOCS) |
| copii | 115, 107, 120, 101 | doar 115 (2 460 oferte) |

### Doua cai de credit, fara legatura intre ele
1. **Formularul de credit** (widgetul productCredits pe pagina produsului, in checkout la
   plata "credit", in cos si in "1 click" cu Credit pe pagina produsului) ->
   `TdbJurnal::save` -> `SP_WEB_REGISTER_FINANTARE` + `SP_ADD_GOODS_FINANTARE` ->
   **1791** + rand in `TWEB_CERERE_FINANTARE` (IDNP, buletin, termen, rata, avans, ORG_ID,
   CREDIT_TYPE). Deal separat cu FIN_REQUESTED.
2. **"1 click" cu Credit** acolo unde widgetul lipseste (liste, seturi, produse fara oferte
   de credit) -> `WEB_CREATE_TRANSACTION_PHONE2` payment_type 1 -> **134** fara dosar:
   **73 de comenzi** in 2026, toate cu DTSC = PAY_NONE si FIN_NONE in deal. "Credit" exista
   doar in comentariu si in `TDB_DEALS.PAYMENT_METHOD`.

Consecinte:
- **Duplicate**: 7 din cele 73 au si o cerere 1791 pe acelasi telefon in 3 zile (ex. 28.08:
  1791 #2179943 si, 40 min mai tirziu, 134 #2179945, acelasi produs, aceeasi suma ->
  doua deal-uri pentru o vinzare). Niciun deal nu contine ambele tipuri.
- Operatorul lucreaza in doua ferestre (frame24 si frame51), cu actiuni diferite: frame51
  are doar "Oferta" si "Inchide"; nu are vinzare, proforma, livrare sau rindul Deal in dialog.
- Axa FIN a deal-ului se aprinde doar daca deal-ul contine un 1791. Creditul din "1 click"
  nu ajunge niciodata in FIN.
- Analitica de plata (DTSC) e PAY_NONE pe toate comenzile 134 din 2026. Doar 8 cereri 1791
  au PAY_CREDIT0 / PAY_CREDIT.

### Ce e specific lui 1791 (de mutat sau de dus si la 134)
- **Baza de date**:
  - `SP_WEB_REGISTER_FINANTARE`: creeaza documentul (firma 316910 si DTSC 5108 hardcodate),
    trimite e-mail si SMS-ul cu cererea de buletin, eveniment tip 7.
  - `SP_ADD_GOODS_FINANTARE`: pune pretul de rate 0% cind CREDIT_TYPE = 0.
  - `SP_CLOSE_WEBZAIAVKACREDIT`.
  - `SP_DEAL_CREATE_FROM_FIN_REQUEST`, `SP_DEAL_RECALC_STATES` (N_FIN), `SP_DEAL_BIND_DOC`
    (DEAL_TO_FIN_REQUEST).
  - `SP_TELEGRAM_BUILD_TEXT`: textul "cerere de credit" cu suma, luni, avans, rata.
  - `SP_DOCS_GET_MODIFY_FLAG`: userul 9 (site) poate modifica intotdeauna un 1791, dar nu
    si un 134.
  - `TS_DOCTYPES_STATES`: 13 stari 1791 (motive de refuz), mapate in TS_DEAL_STATE_MAP.
  - `SP_CREATE_CONFIGURATOR`: are o ramura 1791 (inchide sursa, STATEID = 8).
- **WMS**:
  - `frame51ZaiavkaCreditUnit`: fila "Cerere de finantare" (IBCQueryInfo pe
    TWEB_CERERE_FINANTARE: NPP, IDEN, DATA_NASTERII, telefon, fax, SCAN1/2 + nume).
    CREDIT_SUMA si CREDIT_PERIOADA se citesc, dar nu se arata nicaieri.
  - Drepturi 1792/1793/1794.
  - Sunetul si evenimentul `dbetWebCerereFinantare` in MainForm.
  - 1791 in `cPendingDocTypes`.
  - `SWNDealsUnit`: axele 'FIN,PIPE,REASON'.
- **Site**:
  - Doar `TdbJurnal.php` scrie 1791.
  - Pagina de multumire `/creditThanks` cu GA4 `generate_lead` si Meta `Lead` (la 134:
    `purchase` / `Purchase`).
  - Cererea nu primeste CUSTOMERID (nu e legata de cont).
  - Raportul /marketing/orders arata doar 134 -> 115 -> 107; creditul lipseste.

---

## 2. Modelul tinta

- **Documentul**: 134 Web-Order pentru orice comanda de pe site.
- **Modalitatea de plata la nivel de document**: `TDB_DOCS.DTSC`, analitica de plata din
  TS_SYSS grupa 26, cautata dupa codul din VALUE_STR. Se pune **in procedura care creeaza
  comanda**, nu in PHP:

| Plata aleasa pe site | Cod DTSC |
|---|---|
| numerar la livrare / la primire | PAY_CASH |
| card la livrare | PAY_POS |
| card online maib | PAY_ECOMM |
| MIA QR | PAY_QR_MIA |
| cont spre plata | PAY_INVOICE (**cod nou**, de adaugat in grupa 26) |
| credit 0% / credit cu dobinda | PAY_CREDIT0 / PAY_CREDIT |
| credit fara termen ales ("1 click") | PAY_CREDIT |

  `TDB_DEALS.PAYMENT_METHOD` ramine textul afisat. Regula "e credit" = DTSC in
  (PAY_CREDIT0, PAY_CREDIT), cu PAYMENT_METHOD = 'Credit' ca rezerva pentru istoric
  (asa face deja frame24).
- **Dosarul de credit**: `TWEB_CERERE_FINANTARE` ramine neschimbata, cheia DOCID indica
  acum un 134. Randul e optional:
  - exista cind clientul a completat formularul;
  - lipseste la "1 click" cu credit. Atunci comanda e "credit, dosar incomplet", iar
    operatorul cere actele (SMS-ul exista deja in procedura).
- **Deal-ul**: un singur deal. La plata pe credit: PAY_NONE + FIN_REQUESTED. Etapele FIN
  (in analiza, aprobat, refuzat, contract, transferat) se duc pe deal, din dialogul comenzii.
- **Istoricul 1791**: ramine 1791, doar pentru citire (vezi decizia D1).

---

## 3. Plan de actiune pe faze

Ordinea e obligatorie: intii WMS-ul care stie sa arate dosarul pe un 134, apoi
schimbarea procedurilor din baza (dupa ce noul SWN.exe e la toti), apoi site-ul.

### Faza 0 - pregatire
1. Cod nou PAY_INVOICE in TS_SYSS grupa 26.
2. Comutator in baza (rand in TS_SYSS sau TS_API_CONFIG, ex. `FIN_AS_WEBORDER` = 0/1)
   citit de `SP_WEB_REGISTER_FINANTARE`. Schimbarea se poate opri fara redeploy.
3. Backup inainte de faza 2.

### Faza 1 - WMS (fara efect pina la faza 2)
1. **frame24, fila "Credit"** (portata din frame51): IBCQueryInfo master-detail pe DOCID
   din TWEB_CERERE_FINANTARE.
   - Se afiseaza: suma creditului, termenul, rata lunara, avansul, organizatia
     (ORG_ID -> TS_FINANCE_CUSTOMER), tipul (0% / cu dobinda), NPP, IDNP, data nasterii,
     telefonul, scanarile + numele fisierelor.
   - Fila apare doar cind randul exista. La credit fara rand: mesajul "Dosar de credit
     lipsa - cereti actele clientului".
   - **Drept separat** pentru vederea dosarului (date personale + buletin): se refoloseste
     1792 "Cerere de finantare - vizualizare".
2. **Coloana Plata si fundalul verde**: gata (9 oct 2026). De adaugat un filtru rapid
   "Doar credit".
3. **Dialogul comenzii**: `DealAxesForDocType(134)` = 'PIPE,REASON,FIN', ca operatorul
   sa duca etapele creditului din comanda.
4. **MainForm**:
   - sunetul de "cerere de credit" sa porneasca si la un 134 nou cu plata pe credit
     (procedura trimite in continuare evenimentul de credit, deci MainForm ramine
     aproape neschimbat);
   - indicatorul de neprelucrate ramine pe 134 (1791 se scoate dupa ce se inchid cele
     5 cereri deschise).
5. **frame51** devine arhiva (doar citire). Nodul ramine in arbore pina la decizia D1.
6. Corectii gasite in analiza, de facut pe drum:
   - frame51 `ModifyRecord`: `readonly := (not canEdit) and fSEC_ViewOnly` permite
     modificarea unei cereri inchise;
   - regula "fara responsabil": 1791 foloseste `<= 0`, 134 foloseste `= 0`; trebuie una
     singura;
   - oferta din frame24 inchide documentul de doua ori.

#### Faza 0 + 1 - ce s-a facut (10 oct 2026)
- Faza 0 (`DB Model/finantare_weborder_faza0.sql`):
  - PAY_INVOICE "Cont spre plata" in grupa 26;
  - comutatorul se afla in **TS_API_CONFIG** (API_CODE `WEB_ORDERS`, PARAM_NAME `FIN_AS_WEBORDER`,
    valoarea '0'), nu in TS_SYSS. Se schimba din Setari > Configurari API.
- frame24:
  - partea de jos are acum filele "Produse" si "Credit"; fila "Credit" se vede doar cu dreptul 1792;
  - `IBCQueryCredit` se deschide doar cind fila e activa (din cauza BLOB-urilor cu scanarile);
  - continutul filei: organizatia, tipul (0% / cu dobinda din CREDIT_TYPE), suma, termenul, rata,
    avansul, NPP, IDNP, data nasterii, telefonul, fax, cele 2 scanari si numele fisierelor;
  - fila e mereu vizibila, nu doar cind exista dosar. Fara dosar arata un mesaj:
    pe o comanda pe credit "Dosar de credit lipsa - cereti actele clientului", altfel
    "Comanda nu este pe credit";
  - meniul contextual are bifa "Doar comenzi pe credit" (PAYMENT_METHOD sau DTSC_NAME incep cu Credit).
- Dialogul comenzii: `DealAxesForDocType(134)` = 'PIPE,REASON,FIN'.
- MainForm: evenimentul de credit reincarca si frame24, nu doar frame51.
- frame51:
  - cu FIN_AS_WEBORDER = 1 devine arhiva: fara modificare, stergere sau oferta, dar cererile ramase
    deschise se pot inchide. Cu 0 functioneaza ca inainte;
  - corectat `readonly := not canEdit`.
- Corectii pe drum:
  - responsabilul la 134 foloseste acum aceeasi regula `<= 0` ca la 1791;
  - "Creaza oferta" din frame24 nu mai inchide comanda a doua oara
    (`CreateConfiguratorDoc_DB` apeleaza deja SP_CLOSE_WEBZAKAZ).
- Ramine din faza 1: sunetul de credit la un 134 vine deja din evenimentul procedurii (faza 2).

### Faza 2 - baza de date (scripturi re-rulabile in DB Model/, rulate de DBA)
1. **`SP_WEB_REGISTER_FINANTARE`** (cu comutatorul = 1):
   - creeaza **DOCTYPEID 134**: firma, departament si valori implicite din
     TS_DOCTYPES_DEFVALUES 134, ca celelalte proceduri web, fara 316910 hardcodat;
   - DTSC = PAY_CREDIT0 / PAY_CREDIT dupa CREDIT_TYPE;
   - PAYMENT_METHOD = 'Credit' in deal;
   - restul ramine: randul in TWEB_CERERE_FINANTARE, comentariile, e-mailul, SMS-ul cu
     buletinul, evenimentul tip 7.
2. **`SP_ADD_GOODS_FINANTARE`**: neschimbata (lucreaza pe DOCID). Se verifica dreptul
   userului 9 pe 134 in `SP_DOCS_GET_MODIFY_FLAG`; aceeasi exceptie ca la 1791, altfel
   liniile nu se pot adauga.
3. **Procedurile de comanda** (`WEB_CREATE_TRANSACTION3`, `_2_ECOMM`, `_PHONE2`): pun DTSC
   din tabelul de la sectiunea 2. "1 click" payment_type 1 -> PAY_CREDIT.
4. **Deal-uri**:
   - la crearea deal-ului unei comenzi 134 cu plata pe credit: PAY_NONE + FIN_REQUESTED
     (azi PAY_WAITING + FIN_NONE);
   - `SP_DEAL_RECALC_STATES`: FIN_NONE -> FIN_REQUESTED cind documentul radacina are
     DTSC de credit, nu doar cind deal-ul contine un 1791;
   - SOURCE_CODE: 'FINANCE_REQUEST' pastrat pentru comenzile venite din formularul de credit
     (rapoartele pe sursa raman comparabile).
5. **`SP_TELEGRAM_BUILD_TEXT`**: la un 134 cu rand in TWEB_CERERE_FINANTARE adauga blocul
   de credit (suma, luni, avans, rata) la textul comenzii.
6. **Stari**: cele 13 stari 1791 sint deja mapate pe deal (FIN_DECLINED si motive). Pe 134
   nu se adauga stari noi, pentru ca STATEID e in curs de eliminare (vezi
   plan-eliminare-stateid-2026-09-18.md).
7. **Efecte secundare de acceptat sau de exclus explicit**:
   - `TDB_DOCS_AI` (eveniment 7448) si indicatorul de neprelucrate se aplica de acum si
     creditelor (dorit);
   - `WEB_CALC_GOODS_RANK` numara si comenzile pe credit (decizia D4);
   - `SP_APPLY_CASHBACK` si `SP_CREATE_RASHOD` trateaza parintele 134 (dorit).
8. **Completarea istoricului 2026** (optional): DTSC pentru comenzile 134 existente, din
   PAYMENT_METHOD (doar unde DTSC = PAY_NONE).

#### Faza 2 - ce s-a facut (10 oct 2026)
Scriptul `DB Model/finantare_weborder_faza2.sql` e generat din sursele exacte de pe SW
(isql -x, 10 oct 2026). Daca procedurile se schimba pe SW inainte de rulare, scriptul trebuie
regenerat.

Diferente fata de planul de mai sus:
- `SP_DOCS_GET_MODIFY_FLAG` NU se schimba. In `TRG_TDB_DOCS_BU0` verificarea dreptului e
  fortata (`requireModifyDOC = 1`), iar userul 9 adauga deja linii pe 134 la "1 click".
- D3 cere lista de produse. `SP_WEB_REGISTER_FINANTARE` primeste doi parametri noi, la sfirsit
  si cu valori implicite, deci apelul de azi al site-ului ramine valid:
  - `A_GOODSIDS`: coduri separate prin virgula;
  - `A_CUSTOMERID`: clientul logat.

  Fara lista, cererea creeaza mereu o comanda noua. Site-ul trimite lista in faza 3.
  Telefonul se compara dupa ultimele 8 cifre (`FN_PHONE_LAST8`), din deal sau din
  TWEB_TRANSACTION.
- Sursa deal-ului: `SP_WEB_REGISTER_FINANTARE` pune contextul `DEAL_SOURCE = 'FINANCE_REQUEST'`,
  pe care il citeste `SP_DEAL_ATTACH_DOC`.
- DTSC pe comenzi se pune doar in `WEB_CREATE_TRANSACTION3` si `_PHONE2`. `_2_ECOMM` punea
  deja 5114.
- Comanda pe credit trimite tot evenimentul 7 (sunetul de credit). MainForm reincarca acum
  si frame24.

Teste pe o copie locala a schemei SW (`D:\FBTest\fintest\SWMETA.FDB`, date de referinta
copiate din SW): 27/27 OK, fara erori in TDB_DEAL_LOG.
- Acoperite: comutatorul 0 si 1, deal-urile, Telegram, D3 pozitiv si negativ, schimbarea
  DTSC si re-rularea scripturilor.
- "1 click" a fost simulat prin INSERT-ul procedurii. `WEB_CREATE_TRANSACTION3` si `_PHONE2`
  sint doar compilate, nu rulate cap-coada (lipsesc datele de cos si de preturi).

### Faza 3 - site (fantastic.web)
1. `TdbJurnal::save`: aproape nimic de schimbat (procedura decide tipul). De transmis
   CUSTOMERID cind clientul e logat.
2. Analitica de pe pagina de multumire: vezi decizia D2.
3. Duplicatele: vezi decizia D3.
4. `PaymentAnalytic::set` din PHP devine redundant (DTSC se pune in procedura). Ramine
   doar pentru MIA confirmat ulterior.
5. Raportul /marketing/orders include automat si creditele (sint 134).

#### Faza 3 - ce s-a facut (11 oct 2026, fantastic.web, ramura feature/brand-themes, necomis)
- `models/TdbJurnal.php`:
  - trimite la `SP_WEB_REGISTER_FINANTARE` si `A_GOODSIDS` (codurile produselor cererii, fara
    linia de livrare; peste 1000 de caractere -> '') si `A_CUSTOMERID` (clientul logat, altfel -1);
  - parametrii se trimit doar daca procedura ii are deja (`registerAcceptsGoods()`: o citire
    din `RDB$PROCEDURE_PARAMETERS`, cache 10 min). Site-ul se poate publica inainte sau dupa
    faza 2, fara sa strice cererile de credit.
- `web/js/dialogs/ShopByPhoneDialog/ShopByPhoneDialog.js` (D2): "1 click" cu credit trimite
  `generate_lead` (GA4) si `Lead` (Meta) in loc de `purchase`, cu ID-ul `credit_<DOCID>`, ca
  pagina /creditThanks. La D3 (dosarul se ataseaza la aceeasi comanda) Meta deduplica cele
  doua evenimente. Fisierul trece prin sprintf in ShopCartController: fara `%` in cod.
- Fara schimbari:
  - `PaymentAnalytic::set` ramine; pune acelasi cod de credit ca procedura si e necesar cu
    comutatorul 0;
  - raportul /marketing/orders include creditele automat (sint 134).
- Verificat: `php -l` (PHP 7.4 local) si sintaxa JS dupa substitutia sprintf. Apelul cu 16
  parametri a fost testat in scenariile fazei 2.

### Faza 4 - curatenie (dupa 2-4 saptamini fara probleme)
- Comutatorul scos, ramura 1791 din `SP_WEB_REGISTER_FINANTARE` stearsa.
- `SP_CLOSE_WEBZAIAVKACREDIT`, 1791 din `cPendingDocTypes`, `PlayAudio_CerereDeFinantare`
  (daca sunetul se muta pe 134).
- Ramura 1791 din `SP_CREATE_CONFIGURATOR` ramine pentru istoric.

---

## 4. Decizii pentru proprietar

**Raspunsurile proprietarului (10 oct 2026):**
- D1: arhiva 1791;
- D2: `generate_lead` la orice credit;
- D3: dosarul se ataseaza la comanda existenta;
- D5: dreptul 1792.

D4 nu a fost intrebata explicit. S-a luat varianta recomandata ("da") si se poate schimba
pina la faza 2.

- **D1. Istoricul 1791.**
  - Recomandat: ramine 1791, doar pentru citire, in frame51 (arhiva).
  - Alternativa: conversia tuturor celor 5 154 in 134. Asta inseamna UPDATE pe DOCTYPEID cu
    triggerele TDB_DOCS ocolite, refacerea tipului de legatura in TDB_DEAL_DOCS si
    recalcularea deal-urilor. Riscul e mare si cistigul mic, pentru ca cererile vechi nu
    se mai lucreaza.
  - Cele 5 cereri deschise se inchid sau se convertesc manual.
- **D2. Evenimentul de analitica la credit.**
  - Azi: credit din formular = `generate_lead`; "1 click" cu credit = `purchase`.
  - Recomandat: `generate_lead` pentru **orice** comanda pe credit. Vinzarea nu e sigura
    pina la aprobarea bancii (vezi decizia FB Ads din 01.08.2026: creditele refuzate
    umflau conversiile).
- **D3. Duplicate (credit din "1 click" + cerere de credit dupa).**
  - Recomandat: daca exista o comanda 134 deschisa, pe credit, pe acelasi telefon, din
    ultimele 72 h si cu acelasi produs, cererea noua **ataseaza dosarul** la comanda
    existenta (rand in TWEB_CERERE_FINANTARE pe acel DOCID) in loc sa creeze o comanda noua.
  - Alternativa: comenzi separate, unite manual de operator.
- **D4. Ranking-ul produselor** (`WEB_CALC_GOODS_RANK`): comenzile pe credit (si cele
  refuzate) intra in popularitate?
  - Recomandat: da, sint cerere reala de produs.
- **D5. Drepturi.** Vederea dosarului (IDNP + buletin) doar cu dreptul 1792, sau pentru
  toti cei care vad comenzile web?
  - Recomandat: 1792 (date personale).

---

## 5. Riscuri
- Daca procedura trece pe 134 inainte ca noul SWN.exe sa fie la toti, operatorii cu exe
  vechi nu vad dosarul pe comanda. De aceea comutatorul si ordinea fazelor.
- Dreptul userului 9 pe 134: fara exceptia din `SP_DOCS_GET_MODIFY_FLAG`, liniile cererii
  nu se mai pot adauga si comanda ramine goala. De testat pe o copie locala inainte.
- Rostogolirea zilnica a datei (`SP_UPDATE_DATE_IN_DOCS`) ramine; rapoartele pe luna se
  fac dupa CREATED_DATE, nu dupa DATA.
- TWEB_CERERE_FINANTARE are FK pe TDB_DOCS cu CASCADE: stergerea comenzii sterge si
  dosarul (ca azi).

## 6. Estimare
| Faza | Volum |
|---|---|
| 1 WMS | ~1 zi |
| 2 baza | ~1-1,5 zile, cu testarea pe o copie locala a schemei |
| 3 site | ~0,5 zile |
| 4 curatenie | ~0,5 zile |
