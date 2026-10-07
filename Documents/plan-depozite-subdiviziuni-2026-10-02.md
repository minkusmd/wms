# Plan: fiecare subdiviziune cu depozitele ei

Data: 2 oct 2026. Stare: analiza facuta (doar citire pe SW + cod), nimic modificat.

## Situatia de azi

- **Subdiviziune = firma proprie = `DT` pe document** (TS_CUSTOMER cu CUSTOMER_TYPE_ID = 4002,
  VW_GET_FIRME; `frmDocumentInspectorDialog.pas:198` o afiseaza ca "Subdiviziune"; firma curenta =
  `dmDB.CurrentFirma`, setata prin `PROC_USER_SET_DT`).
- **Depozitele sint globale:** `TS_STOCKS` (29 randuri: STOCKID, PARENTID, FLG_FOLDER, TITLE,
  DESCRIPTION, FLAGS [bit0 vinzare, bit1 uz intern, bit2 RMA], ACC$MASK [acces pe grupuri de useri])
  - **fara nicio legatura cu firma.** Arbore: 1 "Depozite materie prima" (43, 44, 110),
  3 "Garantie si reparatie" (50, 108), 4 "Uz intern" (47, 48, 113-116, 127, 128), 131 "Service"
  (133-143, cite unul pe angajat). -1 = "None stock".
- **Toate firmele folosesc aceleasi depozite.** Ultimele 24 luni: depozitul 50 de 11 firme, 127 de 5,
  128 de 3; 43 de toate firmele proprii si, pe latura CT, de 1 463 de parteneri externi (acolo e doar
  valoarea implicita, fara sens).
- **Stocul e deja pe firma + depozit:** `TS_GOODS_STOCK` PK (DT, DTDEP, GOODSID); procedurile de stoc
  (`GET_GOODS_QTY_BY_STOCK`, `SP_GOODS_STOCK_QTY_BY_FIRMS`, `GET_PARTS_DEP_GOODS`, `GET_SN_DEP_GOODS`,
  `SP_BALLANCE_PARTNO`) primesc DT + depozit. Deci istoria NU e amestecata: perechea (DT, depozit)
  identifica unic "depozitul firmei" - pe asta se sprijina solutia.
- **Alegerea depozitului:** toate dialogurile de documente (09, 10, 11 transfer, 14/17, 22, 24, 25, 26, 27,
  28, 39, 54...) folosesc `dmDB.IBCDataSourceStocks` = `GET_QUICK_ACCESS_STOCK`, care filtreaza doar pe
  ACC$MASK (comentariul ei spune "tine cont de firma curenta", codul nu o face). Implicitele vin din
  `TS_DOCTYPES_DEFVALUES` (PK DOCTYPEID + FIRMA - deja pe firma; aproape toate = 43).
- **Volum:** TDB_DOCS 704k, TDB_JURNAL 1,29M, TDB_PARTS 134k, TDB_SN 276k. DTDEP/CTDEP fac parte din
  PK-ul `TDB_JURNAL` (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID), cu FK CASCADE spre TDB_PARTS,
  TDB_SN, TDB_GOODS_DISCOUNT_TICKET, TS_CUST_DISCOUNT. 176 de obiecte din baza folosesc DTDEP/CTDEP,
  61 depind de TS_STOCKS.
- **Activitate pe 12 luni (latura DT):** PRIME STORE 307225 - 9 632 documente pe 43; SOLUTII COMERCIALE
  316910 - 188 (din 17 sep 2026); restul firmelor proprii - zeci (multe inactive din 2016-2023).
- **Stoc curent nenul:** ~3 500 de randuri (firma, depozit, produs) in ~17 firme; cele mai multe la
  PRIME STORE (Mobilier) 238300, GAMA COMPUTER (Ciocana) 212049, PRIME STORE 307225, GAMA (S+) 211667.
- **Documente deschise (bitul 10 = 0) pe depozitele comune, ultimele 24 luni:** PRIME STORE 8 260 oferte
  (115), 1 214 tip 101, 411 tip 3425, 400 tip 3297, 233 rezerve (107) etc.; la celelalte firme zeci.
- **Constante in cod:** in DB doar `CREATE_RASHOD_FROM_PRIHOD` (`default_dtdep = 43`); in Delphi
  `frmGoodsACNTBrowser.dfm:657` (`TS_STOCKS WHERE PARENTID = 1`) si ordonarea din
  `frmPOSTerminalEditDialog.pas:279`; `TPOS_TERMINAL.STOCKID` leaga terminalul POS de un depozit.
  Sabloanele de raport (TS_REPORTS*) sint comprimate - neverificate.

## Solutia propusa (pentru datele existente)

**Ideea:** nu se rescrie istoria. Depozitele noi sint ale unei firme, iar trecerea se face la o data
de bascula (cut-over) prin documente de transfer, ca orice miscare de stoc. Istoria veche ramine
corecta pentru ca fiecare document are deja firma (DT) - perechea (DT, depozit vechi) se mapeaza
determinist pe depozitul nou al firmei.

1. **Proprietar si cod local pe depozit.** `TS_STOCKS` primeste:
   - `FIRMAID` - firma proprietara (NULL = comun/sistem: -1, folderele, depozitele vechi arhivate);
   - `CODE` - codul vizibil al depozitului **in cadrul firmei** (ex. "01 Depozit de baza");
     unic pe (FIRMAID, CODE). Asa doua firme pot avea acelasi cod "01" fara conflict: identitatea
     tehnica ramine STOCKID (unic global), codul de afaceri se poate repeta intre firme;
   - un bit nou in FLAGS: "arhivat" (nu mai apare in liste, nu mai primeste documente noi).
2. **Tabela de corespondenta** `TS_STOCKS_FIRM_MAP (FIRMAID, OLD_STOCKID, NEW_STOCKID, DATA_BASCULA)`
   - folosita la migrare, la implicite si la rapoartele care trec peste data de bascula.
3. **Depozite noi doar unde e nevoie:** pentru fiecare firma activa, cite un depozit nou pentru fiecare
   depozit vechi pe care il foloseste (are stoc nenul, documente in ultimele 12 luni sau e implicit in
   TS_DOCTYPES_DEFVALUES / TPOS_TERMINAL). Arborele: un folder pe firma, cu depozitele ei dedesubt;
   bitii vinzare / uz intern / RMA si ACC$MASK se copiaza de pe depozitul vechi.
   Firmele inactive nu primesc depozite noi - stocul lor ramine pe depozitele vechi arhivate (citibil).
4. **Bascula (intr-o seara, dupa inchiderea zilei):**
   - a) stocul: pentru fiecare (firma, depozit vechi) cu stoc nenul - un document de **transfer intre
     depozite** (tipul 11, sau un tip dedicat "Migrare depozit") din depozitul vechi in cel nou, in
     aceeasi firma, cu partidele si seriile (TDB_PARTS / TDB_SN) ca la un transfer normal - asa costul,
     partidele si seriile raman coerente si miscarea apare in rapoarte;
   - b) documentele deschise (neinchise) pe depozitele vechi: DTDEP/CTDEP mutate pe depozitul nou al
     firmei (UPDATE; FK-urile CASCADE muta si liniile TDB_PARTS / TDB_SN); rezervarile se recalculeaza;
   - c) `TS_DOCTYPES_DEFVALUES` si `TPOS_TERMINAL.STOCKID` repointate pe firma;
   - d) depozitele vechi marcate "arhivat".
5. **Regula de aici inainte** (trigger pe TDB_DOCS si TDB_JURNAL, pentru documente datate >= bascula):
   - daca partea DT e firma proprie, DTDEP trebuie sa fie un depozit al ei (sau -1); la fel CT/CTDEP
     cind CT e firma proprie (transferuri intre subdiviziuni);
   - partener extern (CT nu e firma proprie) -> CTDEP = -1;
   - depozit arhivat -> refuzat (exceptie pentru documentele de migrare).
6. **WMS (Delphi):**
   - `GET_QUICK_ACCESS_STOCK` filtreaza dupa firma curenta (RDB$GET_CONTEXT setat de PROC_USER_SET_DT)
     + ACC$MASK + nearhivat; `dmDB.ChangeCurrentFirma` reimprospateaza IBCQueryStocks;
   - transferul intre firme (doc 11, CTDEP) are nevoie de un lookup separat, filtrat dupa CT;
   - editorul `frmStocksBrowser`: coloanele FIRMAID / CODE, lista pe firma;
   - `frmGoodsACNTBrowser.dfm:657` (PARENTID = 1) si `frmPOSTerminalEditDialog.pas:279` -> bitul
     "pentru vinzare" in loc de folderul 1; selectorul de depozit din rapoarte
     (`ReportControlsUnit.pas:383`) filtrat pe firma;
   - `CREATE_RASHOD_FROM_PRIHOD`: depozitul implicit din TS_DOCTYPES_DEFVALUES al firmei, nu 43.
7. **Rapoarte peste data de bascula:** un view/procedura care traduce (DT, depozit vechi) -> depozit nou
   prin TS_STOCKS_FIRM_MAP, ca un raport pe "Depozitul de baza al firmei X" sa adune istoria veche si
   cea noua; documentele de migrare se exclud din rulaje (sint doar mutare).

### Alternativa respinsa: rescrierea istoriei

Tehnic posibila (corespondenta e determinista): UPDATE pe 1,29M linii TDB_JURNAL cu PK in cascada pe
134k partide si 276k serii, cu triggerele de stoc oprite, perioade inchise si documente fiscale atinse,
176 de obiecte de verificat - ore de fereastra de mentenanta si risc mare, fara folos practic fata de
bascula (istoria e deja separata pe firma). Ramine posibila mai tirziu, pe firma, cu aceeasi tabela de
corespondenta.

## Decizii luate (2 oct 2026)

- Subdiviziune = firma DT. **Deocamdata doar 307225 PRIME STORE SRL si 316910 SOLUTII COMERCIALE SRL**
  primesc depozite proprii. Celelalte firme raman pe depozitele comune actuale - acestea NU se
  arhiveaza, doar nu mai pot fi folosite de cele doua firme dupa bascula. Regula de validare:
  o firma care are depozite proprii poate folosi doar depozitele ei; firmele fara depozite proprii
  continua pe cele comune.

## Datele concrete pentru cele doua firme (SW, 2 oct 2026)

| | 307225 PRIME STORE | 316910 SOLUTII COMERCIALE |
|---|---|---|
| Depozite vechi folosite | 43 Depozit de baza, 128 Retur furnizor, 50 Reparatii, 127 Uz intern, 47 Server (110 Vitrina fara stoc) | doar 43 |
| Stoc pozitiv de mutat (randuri / bucati) | 43: 467 / 1 675; 128: 27 / 26; 50: 2; 127: 1; 47: 1 | 0 |
| Stoc negativ (randuri) | 123 | 21 (toate; -34 buc.) - firma vinde din 17 sep fara intrari |
| Documente deschise pe depozitele vechi | 10 881 (115 oferte 8 417 din sep 2024; 101: 1 234; 3425: 411; 3297: 400; 107 rezerve: 233; altele) - 22 637 linii | 128 (115: 93; 3425: 13; 101: 10; 107: 7...) - 204 linii |
| TS_DOCTYPES_DEFVALUES | 18 tipuri (43, 128) | 8 tipuri (43) |
| TPOS_TERMINAL | - | "CASA DEV" pe 43 |

Depozite noi propuse:
- PRIME STORE: 01 Depozit de baza (<- 43), 02 Retur la furnizor (<- 128), 03 Produse in reparatie
  (<- 50), 04 Uz intern (<- 127), 05 Server (<- 47);
- SOLUTII COMERCIALE: 01 Depozit de baza (<- 43).
Transferul de migrare: tipul existent **114 "Transfer de marfa intern"** (deja in implicitele PRIME STORE).

Probleme de rezolvat inainte de bascula:
- **stocul negativ** (123 + 21 randuri) nu se poate "transfera"; fie se corecteaza inainte (inventariere
  / documentele de intrare lipsa - la SOLUTII COMERCIALE marfa s-a vindut fara receptie), fie soldul
  negativ se muta cu un document de migrare dedicat care permite cantitati negative;
- **ofertele vechi**: 8 417 oferte (115) deschise, unele din sep 2024 - se muta toate sau se anuleaza
  cele vechi (ex. > 90 de zile) inainte de bascula.

## Decizii luate (2 oct 2026, partea a doua)

- **Data de bascula: 1 octombrie 2026** (deja trecuta): toate documentele celor doua firme datate
  >= 01.10.2026 trec pe depozitele noi; transferul de migrare se dateaza 01.10.2026 00:00 si muta
  soldul de la sfirsitul zilei de 30.09.2026.
- **Stocul negativ se muta ca sold negativ.** Fara tip special: un sold de -x pe depozitul vechi se
  muta printr-un transfer 114 in sens invers (x bucati din depozitul nou in cel vechi): vechiul ajunge
  la 0, noul la -x.
- **Ofertele vechi se muta si ele** - toate documentele deschise, indiferent de data.
- **Partenerii externi primesc "fara depozit" (-1)** de acum (documente noi + documentele deschise ale
  celor doua firme).

## Algoritmul de migrare (Faza 1, de testat pe copie)

Constatari care il dicteaza (SW, 2 oct 2026):
- stocul (TS_GOODS_STOCK) e tinut de triggerele de pe TDB_JURNAL: TDB_JURNAL_INS_QTY, TDB_JURNAL_UPD_QTY,
  TRG_TDB_JURNAL_BD, TDB_JURNAL_AIUD4. UPD_QTY muta stocul la orice schimbare de DTDEP/CTDEP pe liniile
  documentelor de tip factura / transfer **fara sa verifice daca documentul e inchis** (AIUD4 verifica
  bitul 10) -> mutarea documentelor deschise cu triggerele pornite ar putea strica stocul;
- transferul 114: DT = CT = firma, DTDEP / CTDEP pe antet si pe linii, cu partide (TDB_PARTS) si serii
  (TDB_SN); executia programatica exista: `SP_DO_PEREMESHENIE(DOCID, DOCSIGN)`;
- recalcularea completa a stocului din documente exista: `RECALC_ALL_STOCK_NEW`;
- de mutat: PRIME STORE - 10 881 documente deschise (22 637 linii) + documentele inchise din 1-2 oct
  (cite 2 de tip 106, 107, 116, 109); SOLUTII COMERCIALE - 128 deschise (204 linii) + cele inchise
  din 1-2 oct; 282 de linii au alt depozit decit antetul (se mapeaza linia, nu antetul).

Pasii (procedura de migrare, intr-o singura tranzactie pe firma):
1. depozitele noi in TS_STOCKS (FIRMAID, CODE, bitii si ACC$MASK copiate) + TS_STOCKS_FIRM_MAP;
2. cu `DISSABLE_TRIGGERS = 'YES'`: DTDEP / CTDEP mutate dupa corespondenta pe TDB_DOCS si TDB_JURNAL
   (FK-urile CASCADE muta TDB_PARTS / TDB_SN / TDB_GOODS_DISCOUNT_TICKET / TS_CUST_DISCOUNT) pentru
   documentele firmei datate >= 01.10.2026 sau deschise; CTDEP = -1 unde CT e partener extern;
   TDB_JURNAL_SP (DT_DEP / CT_DEP) la fel;
3. `RECALC_ALL_STOCK_NEW` -> soldul depozitului vechi = soldul la 30.09 (fara documentele mutate);
4. documentele de migrare 114 datate 01.10.2026 00:00: pozitivele vechi -> nou (cu partidele / seriile
   de pe depozitul vechi, GET_PARTS_DEP_GOODS / GET_SN_DEP_GOODS), negativele nou -> vechi; executate
   cu SP_DO_PEREMESHENIE si marcate (MENTIUNI / flag) ca "migrare depozite";
5. TS_DOCTYPES_DEFVALUES, TPOS_TERMINAL.STOCKID, CREATE_RASHOD_FROM_PRIHOD -> depozitele noi;
6. verificare: stocul pe (firma, produs) identic inainte / dupa; depozitele vechi la 0 pentru cele
   doua firme; nicio linie a celor doua firme datata >= 01.10 pe depozit vechi.

**Mediul de test:** SW are 478 GB (pagina 16K). O copie restaurata local incape pe F: (622 GB liberi),
dar copierea + restaurarea dureaza ore; alternativ, copia se face pe server (DBA). Fara test complet
pe copie, bascula nu se ruleaza pe SW.

## Plan de actiune

### Faza 0 - decizii (user)
- confirmarea: subdiviziune = firma DT; lista firmelor active care primesc depozite;
- pentru fiecare firma: ce depozite primeste, denumirile si codurile locale;
- data de bascula (ideal prima zi a lunii, dupa inchiderea lunii);
- tipul documentului de migrare (transfer 11 sau tip dedicat);
- partenerii externi: CTDEP = -1 de aici inainte (da/nu).

### Faza 1 - pregatire (fara efect pentru utilizatori)
- DDL: coloanele noi din TS_STOCKS, TS_STOCKS_FIRM_MAP, bitul "arhivat"; VW_TS_STOCKS si triggerele lui;
- raport de pre-bascula (read-only): stocul nenul pe (firma, depozit vechi), documentele deschise,
  implicitele - lista exacta a depozitelor noi;
- scriptul de bascula (procedura) + scriptul de verificare; **test complet pe o copie restaurata a SW**
  (backup nbackup), cu comparatia stocului pe (firma, produs) inainte/dupa = identic;
- WMS: lookup-urile filtrate, editorul de depozite, constantele; compilat, nelansat.

### Faza 2 - bascula (seara, utilizatorii deconectati)
- backup; crearea depozitelor noi; transferurile de migrare; mutarea documentelor deschise;
  implicitele si terminalele POS; arhivarea depozitelor vechi; activarea triggerului de validare;
- verificare: stoc pe (firma, produs) neschimbat; zero stoc pe depozitele vechi la firmele active;
  documentele deschise pe depozite noi; noul SWN.exe distribuit.

### Faza 3 - dupa bascula
- rapoartele peste data de bascula (view-ul de corespondenta); sabloanele de raport verificate;
- monitorizare 2 saptamini a erorilor din trigger (documente refuzate) si ajustari.
