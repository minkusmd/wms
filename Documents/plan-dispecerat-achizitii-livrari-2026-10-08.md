# Plan: Dispecerat pentru achizitii si livrari

Data: 2026-10-08
Stare: propunere functionala si tehnica; deciziile deschise sunt marcate explicit.
Scop: un singur ecran WMS in care dispecerul planifica ridicarile de la
furnizori si livrarile catre clienti, repartizand zonele si sarcinile pe curieri.
Soferii folosesc o aplicatie web adaptata telefonului, conectata la aceleasi
sarcini si trasee operationale.

## 1. Cerinte confirmate

- La fiecare vanzare trebuie cunoscuta sursa marfii.
- Pentru client se indica adresa efectiva si data planificata a livrarii.
- Dispecerul vede la ce furnizori trece fiecare curier si cine livreaza comanda.
- Adresele se grupeaza dupa zona: Ciocana, Buiucani, Durlesti, Ialoveni etc.
- Dispecerul repartizeaza separat zonele de achizitie si zonele de livrare.
- Curierii provin din nomenclatorul de clienti, mapa Colaboratori.
- Interfata soferului este o aplicatie web utilizata pe telefon.
- Confirmarile soferului se fac numai cu conexiune la internet; nu se
  pastreaza o coada de confirmari offline pentru sincronizare ulterioara.
- La sosirea la furnizor, soferul deschide preluarea; lista se blocheaza
  pentru modificari si adaugari de produse pe durata preluarii. Blocarea
  priveste numai documentul de preluare al soferului, nu toate preluarile
  de la acel furnizor.
- Soferul fotografiaza seria sau partida fiecarui produs primit.
- Dupa incarcarea tuturor fotografiilor, soferul inchide documentul de
  preluare; inchiderea creeaza automat in baza o Factura de intrare.
- Dispecerul completeaza seriile si partidele in Factura de intrare,
  folosind fotografiile. Fluxul se repeta la fiecare furnizor.
- Soferul poate livra direct din masina daca adresa clientului este pe traseu.
- Dispecerul completeaza seria/partida si depozitul soferului in vanzare;
  dupa caz, genereaza cecul electronic si il transmite clientului.
- Soferul asteapta confirmarea dispecerului inainte de predarea marfii
  clientului; aplicatia permite predarea numai pentru o vanzare pregatita
  si autorizata de dispecer.
- Seria sau partida introdusa si salvata in Factura de intrare este activa si poate fi
  selectata in vanzare chiar daca Factura de intrare ramane deschisa.
  Inchiderea facturii nu mai este conditia de activare a seriei sau partidei.
- Dupa fotografiere, soferul inchide documentul de preluare, iar starea
  acestuia devine Incarcat, simultan cu generarea Facturii de intrare.
- La sosirea la depozit, soferul apasa Am ajuns la depozit. Soldul ramas in
  depozitul soferului se transfera in depozitul de baza, cu excluderea marfii
  deja predate clientilor pe traseu.
- La fiecare livrare, soferul vede marfa efectiv de predat, seria/partida,
  cantitatea, pretul unitar si suma pe produs, plus totalul produselor.
- Serviciile (livrare, ridicare la etaj, conectare etc.) sunt afisate separat
  de marfa, cu preturi si total propriu. Se afiseaza si totalul comenzii.
- Se afiseaza modalitatea de plata: numerar, card, credit, transfer, precum
  si plata partiala, suma achitata si restul de achitat/incasat.

## 2. Decizii de confirmat

Intrebarile interactive initiale:

1. O comanda poate contine marfa de la mai multi furnizori?
2. Livrarea din masina si transferul soldului ramas la sosirea in depozitul
   de baza sunt confirmate.
3. Planificarea porneste din comanda clientului, vanzare/factura sau ambele?

Ipoteze de lucru pana la raspuns, fara a le considera aprobate:

- Se permit mai multi furnizori; furnizorul se indica la nivel de pozitie si
  cantitate. Antetul afiseaza un rezumat al furnizorilor.
- Modelul include livrarea din depozitul soferului si transferul soldului
  ramas in depozitul de baza prin actiunea soferului la sosire.
- Planificarea porneste din documentul operational al comenzii/vanzarii;
  relatia exacta cu factura se stabileste inainte de implementare.
- Un curier poate face si achizitii, si livrari in aceeasi zi; curierul de
  preluare poate fi diferit de curierul de livrare.
- In prima versiune dispecerul stabileste manual ordinea opririlor.
- Soferul confirma executarea din aplicatia web. Dispecerul urmareste
  progresul si poate corecta confirmarile in WMS, cu motiv si jurnal.

Alte decizii necesare inainte de implementare: permiterea livrarilor partiale,
necesitatea intervalului orar promis si daca soferul inregistreaza efectiv
incasarile sau doar consulta suma de incasat. Afisarea detaliilor de plata
si a sumelor pe telefon este confirmata.
Pentru aplicatia web ramane de confirmat dovada livrarii (confirmare simpla,
fotografie, semnatura sau ambele). Confirmarile offline au fost excluse
explicit de utilizator; confirmarile necesita internet.

Clarificari confirmate pentru fluxul nou:

- Blocarea se aplica doar documentului de preluare al soferului.
- Predarea fizica necesita completarea seriei/partidei si depozitului in
  vanzare, apoi confirmarea explicita a dispecerului.

De stabilit la analiza: preturile si datele facturii furnizorului, tratarea
produselor fara serie/partida, a lipsurilor si a fotografiilor ilizibile.
Crearea Facturii de intrare la inchidere este confirmata; momentul postarii
contabile trebuie verificat. Activarea seriei/partidei imediat dupa salvarea ei,
independent de inchiderea facturii, este o cerinta confirmata.

## 3. Puncte existente de integrare

Constatari din versiunea Git HEAD, nu din bufferele IDE sau baza live.
Instrumentele Kai nu sunt disponibile in aceasta sesiune; codul nu a fost editat.

| Componenta existenta | Utilizare in plan |
| --- | --- |
| `sources/frames/frame10NakladnieRNUnit.pas`, `bbSelectSupplierClick` | Fluxul existent de alegere a furnizorului si creare a ridicarii pentru marfa comenzii |
| `sources/classes/SupplierPickup/` | Editarea ridicarilor, atribuirea soferului, confirmarea si anularea |
| `DB Model/supplier_pickup.sql` | `TDB_SUPPLIER_PICKUP`, `VW_TDB_SUPPLIER_PICKUP`, `TS_SUPPLIER_ORDER_RULE` |
| `sources/classes/Delivery/frmDeliveryEditorUnit.dfm` | `VW_TDB_DOCS_DELIVERY`: curier, adresa, data, ora, telefon, starea si indicatii de plata |
| `sources/Tools/Delivery/frameDocsDeliveryUnit.pas` | Legatura datelor de livrare cu documentul |
| `sources/frames/frame82Livrari.*` | Foile de livrare prin `VW_TDB_WAYBILL` si `VW_TDB_WAYBILL_ITEMS`; de verificat pentru reutilizare |
| `sources/classes/Customer/SWNCustomersTypesUnit.pas` | Filtrul existent `cfColaboratori` |
| `sources/classes/Customer/frmCustomersDlg.pas` | Selectia colaboratorilor; in HEAD filtrul indica radacina 4006, de verificat in baza live |
| `DB Model/web_delivery_zone.sql` | Zone tarifare ale site-ului; au alta granularitate decat zonele operationale ale dispecerului |
| `sources/frameUtils/09 - NAKLADNAIA/`, `sources/frames/frame09NakladniePNUnit.*` | Candidati pentru integrarea Facturii de intrare; creare, validare si postare de verificat in cod si baza |
| `sources/FiscalPrinter/` | Fluxul existent de fiscalizare si cec electronic; integrarea si transmiterea clientului se verifica la implementare |

Ridicarea existenta distinge `STOCK_SUPPLIERID`, `ORDER_SUPPLIERID` si
`PICKUP_SUPPLIERID`. Zona de achizitie trebuie determinata de punctul fizic
al lui `PICKUP_SUPPLIERID`, nu de furnizorul comercial sau intermediar.

`TDB_SUPPLIER_PICKUP` contine deja `DRIVERID`, `PLAN_DATE`, `QTY`, `PICKED_AT`
si stari 0 noua / 1 atribuita / 2 ridicata / 3 anulata. Aceste semnificatii
se pastreaza; stari suplimentare de executare se modeleaza separat sau se
introduc numai dupa verificarea tuturor consumatorilor.

## 4. Nomenclatoare si date pe document

### Zone logistice

Se creeaza un nomenclator editabil de zone operationale. O zona poate
reprezenta un sector, o localitate sau o grupare convenita de dispecer.

Campuri: identificator, cod unic, denumire, zona parinte optionala, ordine,
activ/inactiv. Exemple initiale: Ciocana, Buiucani, Centru, Botanica,
Riscani, Durlesti, Ialoveni. Lista initiala se confirma cu dispecerul.

Fiecare adresa folosita are o zona selectata explicit. Nu se deduce zona
printr-o simpla cautare a denumirii in textul strazii. Sugestiile viitoare
din localitate/sector nu inlocuiesc confirmarea operatorului.

Zonele logistice pot fi mapate la zonele tarifare existente daca va fi
necesar, fara a modifica tarifele prin repartizarea unui curier.

### Curieri

Se reutilizeaza identitatea `TS_CUSTOMER.CUSTOMERID` din Colaboratori.
Nu se creeaza un al doilea catalog de persoane.

Se recomanda un profil logistic atasat colaboratorului: activ ca curier,
poate ridica, poate livra, telefon si observatii. Astfel nu apar toti
colaboratorii ca potentiali curieri. Identificarea mapei foloseste mecanismul
existent, dupa verificarea configuratiei live; nu se inventeaza un nou ID.

Fiecare sofer are un depozit asociat, folosind nomenclatorul existent de
depozite. Marfa din masina este urmarita operational in depozitul soferului.
Legatura colaborator-depozit este configurata explicit si verificata inainte
de preluare. Factura de intrare indica depozitul soferului, iar vanzarea
foloseste acelasi depozit pentru marfa livrata din masina. Seriile si partidele salvate
in intrarea deschisa sunt disponibile pentru selectie din acest depozit.
Starea contabila a intrarii se urmareste separat; nu blocheaza selectarea
unei serii/partide introduse. Marfa fara serie/partida completata ramane de procesat.

### Furnizori si puncte de preluare

Un furnizor poate avea mai multe puncte fizice. Pentru fiecare punct:
adresa, zona, persoana de contact, telefon, program si observatii.
Se reutilizeaza adresele existente ale clientilor/furnizorilor cand structura
permite, adaugand doar atributul logistic necesar.

Pentru fiecare cantitate de procurat: pozitia documentului, produsul,
cantitatea, furnizorii existenti, punctul efectiv de ridicare, data preluarii,
curierul, starea si observatiile. Marfa din stoc propriu se marcheaza explicit
ca sursa depozit; nu genereaza o ridicare artificiala de la furnizor.

### Livrarea catre client

Date obligatorii la publicarea unei sarcini de livrare: document/comanda,
adresa efectiva, zona, contact/telefon, data planificata si curier.
Ora sau intervalul orar, instructiunile si indicatiile existente pentru
numerar/POS/factura se afiseaza unde sunt disponibile.

Adresa este cea a comenzii, nu implicit sediul juridic al clientului.
Se pastreaza referinta la adresa si o copie a datelor folosite la planificare;
editarea ulterioara a nomenclatorului nu schimba istoricul traseului.

## 5. Repartizarea zonelor

Se mentine o configuratie implicita, din care se copiaza repartizarea zilei.
Dispecerul poate schimba curierul pentru o zona, separat pentru fiecare tip
de activitate. Configuratia zilei pastreaza istoricul.

| Zona | Curier achizitie | Curier livrare |
| --- | --- | --- |
| Ciocana | Curier A | Curier B |
| Buiucani | Curier B | Curier B |
| Durlesti | Curier C | Curier A |
| Ialoveni | Curier C | Curier C |

Exemplul este ilustrativ, fara persoane reale.

Regula initiala: un curier implicit pe data + zona + tip de activitate.
O zona poate avea mai multi curieri prin atribuiri explicite pe sarcini.
Dispecerul poate excepta o anumita preluare/livrare de la regula zonei.

Aplicarea regulii completeaza numai sarcinile neatribuite. Reaplicarea nu
suprascrie exceptiile manuale sau sarcinile deja incepute. Schimbarea regulii
ofera recalcularea explicita a sarcinilor eligibile, cu lista modificarilor.

## 6. Forma Dispecerat

O forma principala cu data de lucru, filtre pe zona/curier/stare, cautare
dupa comanda, client sau furnizor si contoare pentru restante/neatribuite.

Cele patru pagini de planificare:

1. **Achizitii**: zona -> punct de preluare/furnizor -> sarcini si comenzi.
   Coloane: furnizor efectiv, adresa, curier, data/ora, comanda, produs,
   cantitate, stare, contact, observatii.
2. **Livrari**: zona -> curier -> comenzi. Coloane: comanda, client,
   adresa, telefon, data/interval, curier de livrare, disponibilitatea marfii,
   starea ridicarilor, stare livrare, instructiuni.
3. **Trasee curieri**: curier -> lista ordonata de opriri mixte.
   Coloane: ordine, tip, zona, adresa, ora planificata, comenzi, stare.
   Detaliul opririi arata marfa si cantitatile pentru fiecare comanda.
4. **Repartizare zone**: matricea zone/curieri pentru achizitie si livrare,
   copiere din configuratia implicita sau din alta zi.

Se adauga pagina **Procesare documente** pentru activitatea din birou:
preluari in curs/blocate, Facturi de intrare generate, fotografii de verificat,
serii/partide de completat, vanzari de pregatit din depozitul soferului si
cecuri electronice de generat/transmis. Fotografia si pozitia documentului
se afiseaza impreuna. Listele disting Preluat fizic, Intrare de completat,
Intrare validata, Vanzare pregatita, Predat clientului si starea cecului.
Pe fiecare pozitie se vede daca seria/partida este introdusa/activa, rezervata sau
folosita; intrarea poate ramane deschisa in timp ce seriile/partidele completate se vand.

Actiuni: atribuire individuala/multipla, scoatere atribuire, schimbare data,
ordonare opriri, publicare plan, confirmare ridicare, confirmare livrare,
esec cu motiv, replanificare si tiparire fisa curierului.

O zona fara curier si o adresa fara zona raman vizibile in Neatribuite sau
Date incomplete. Restantele au pagina/filtru propriu si nu dispar la schimbarea
datei. Culorile ajuta, dar fiecare problema are si text explicit.

## 7. Trasee si legatura achizitie-livrare

O oprire reprezinta o vizita la un punct fizic, nu o singura comanda.
Mai multe preluari de la acelasi punct, pentru acelasi curier si data, pot
fi consolidate intr-o oprire cu linii separate. Datele/programul trebuie sa
fie compatibile; se permit vizite separate cand sunt necesare.

Comanda poate avea mai multe preluari si, daca se aproba, mai multe livrari.
Alocarile leaga cantitatile preluate sau rezervate din stoc de cantitatile de
livrat. Cantitatea aceleiasi comenzi nu se atribuie integral mai multor curieri.

Pentru livrare directa din masina, oprirea de ridicare precede livrarea.
Inchiderea preluarii genereaza Factura de intrare in depozitul soferului;
dispecerul completeaza seriile/partidele si pregateste vanzarea din acel depozit.
Disponibilitatea fizica si disponibilitatea contabila se afiseaza separat.
Inchiderea Facturii de intrare nu este necesara pentru selectarea seriilor si partidelor
deja salvate si pregatirea vanzarii.
Predarea se permite numai dupa completarea vanzarii si confirmarea explicita
a dispecerului. Autorizarea se verifica si pe server la confirmarea livrarii.
Pentru fluxul
prin depozit, disponibilitatea pentru livrare presupune predarea/receptia
confirmata la depozit; simplul marcaj Ridicata nu este suficient.

Cand curierii difera, se inregistreaza predarea intre curieri sau prin
depozit: cantitati, data/ora si persoanele implicate. Planul poate fi creat
inainte de disponibilitate, dar pornirea/confirmarea livrarii respecta aceasta
dependenta. Exceptiile aprobate se inregistreaza cu motiv.

## 8. Stari si reguli de validare

Planul zilei: Ciorna -> Publicat -> In executare -> Inchis.
Modificarile dupa publicare se inregistreaza si apar pe fisa actualizata.

Stari functionale de executare propuse:

- Document de preluare: Planificat -> In preluare (lista blocata) -> Incarcat
  (document inchis, Factura de intrare generata). Lipsurile/esecurile se
  trateaza explicit. Incarcat este starea documentului de preluare;
  Factura de intrare poate ramane deschisa pentru completare.
- Revenire la baza: Pe traseu -> Transfer in curs -> Sold transferat la baza.
  Transfer in curs este starea operatiei; Sold transferat se afiseaza numai
  dupa salvarea cu succes a transferului in baza.
- Factura de intrare: Generata, Serii/partide de completat, Pregatita pentru
  validare, Validata conform fluxului contabil existent.
- Livrare: De planificat, Planificata, In livrare, Livrata, Partiala,
  Esuata, Anulata.
- Cantitatile partiale si replanificarile pastreaza sarcina initiala si istoricul.

Aceste etichete necesita mapare la starile existente; nu sunt noi valori
presupuse pentru `STATEID` al ridicarilor.

Starea seriei/partidei este distincta de starea facturii: devine activa la
salvarea in baza, iar disponibilitatea pentru o noua vanzare tine cont de
depozit si de rezervarile/utilizarile existente. O serie activa deja alocata
nu apare libera pentru o a doua vanzare.

Validari in baza si UI:

- Nu se publica sarcini fara adresa, zona, data sau curier eligibil.
- Nu se preia/livreaza mai mult decat cantitatea ramasa dupa anulari.
- Se verifica identitatea pozitiei documentului, inclusiv produse repetate;
  cheia nu se presupune a fi doar DOCID + GOODSID.
- Se previn alocarile active duplicate si suprascrierea modificarilor altui
  dispecer prin verificarea versiunii/datei de modificare in tranzactie.
- Cantitatile, disponibilitatea si dependentele se reverifica la confirmare.
- Schimbarea adresei/furnizorului/datei semnaleaza revizuirea traseului.
- Anularea comenzii retrage sarcinile neexecutate; pentru marfa deja preluata
  se cere rezolvare operationala explicita, pastrand istoricul.
- Inchiderea documentului de preluare creeaza automat Factura de intrare,
  prin fluxul contabil existent. Alte confirmari nu genereaza implicit
  documente contabile sau incasari.
- Blocarea este persistenta si verificata pe server/baza pentru toate
  caile de editare relevante, inclusiv WMS; nu este doar un buton dezactivat.
- Inchiderea este admisa numai dupa salvarea tuturor fotografiilor necesare
  pe server si validarea cantitatilor efectiv primite.
- Factura de intrare se creeaza o singura data pentru documentul inchis;
  retransmiterea sau pierderea raspunsului nu genereaza alta factura.

## 9. Model de date propus

Denumirile sunt orientative. Schema finala se stabileste dupa citirea
metadatelor Firebird si a view-urilor/procedurilor live.

| Entitate | Responsabilitate |
| --- | --- |
| `TS_LOGISTIC_ZONE` | Nomenclatorul zonelor operationale |
| Profil curier legat de `TS_CUSTOMER` | Eligibilitate si capacitati |
| Adresa/punct logistic existent, extins | Zona si programul punctului |
| `TS_COURIER_ZONE_RULE` | Curier implicit pe zona si tip |
| `TDB_DISPATCH_PLAN` | Data, firma/depozit relevant, stare, autor, versiune |
| `TDB_DISPATCH_ZONE_ASSIGN` | Repartizarea concreta a zilei |
| Traseu si opriri | Curier, ordine, tip, adresa si date efective |
| Legaturi oprire-sarcina si alocari | Preluari/livrari existente, pozitii si cantitati |
| Jurnal logistic | Atribuiri, schimbari, executare, motive si predari |
| Document/sesiune de preluare la furnizor | Lista fixata la sosire, blocare persistenta, curier, furnizor, depozit, stare si Factura de intrare generata |
| Fotografii de preluare | Legatura cu pozitia/unitatea/cantitatea, seria/partida de identificat, autor, moment si fisier salvat |
| Legatura curier-depozit | Depozitul asociat soferului in nomenclatorul existent |
| Legaturi intrare-vanzare | Provenienta pe pozitii/cantitati, seriile/partidele si depozitul folosit |
| Starea cecului si transmiterii | Referinta fiscala existenta si evidenta livrarii cecului clientului |

`TDB_SUPPLIER_PICKUP` ramane sursa sarcinilor de preluare. Datele de livrare
se integreaza cu `TDB_DOCS_DELIVERY`/view-ul existent. Se verifica daca foile
din frame82 pot reprezenta traseele si opririle; tabele noi se introduc
numai pentru responsabilitatile lipsa. Se desemneaza o singura sursa pentru
curier si data; orice copie existenta trebuie sincronizata in aceeasi tranzactie.

Indexare: data/stare, zona, curier, punct, document si legaturile de cantitati.
Cheile externe si regulile de unicitate se definesc dupa verificarea schemei.
Configuratia se delimiteaza pe firma/depozit unde aplicatia o cere.

## 9A. Aplicatia web pentru soferi

Aplicatia web face parte din prima versiune. Se deschide in browserul
telefonului, cu ecrane adaptate latimii mici si butoane usor de apasat.
Instalarea ca PWA pe ecranul principal este o optiune de implementare.

### Ecranele soferului

1. **Autentificare**: cont individual legat de colaboratorul-curier;
   identificarea dupa un ID introdus in URL nu este suficienta.
2. **Traseul meu**: ziua, ordinea opririlor, zona, adresa, tipul activitatii,
   ora/intervalul si progresul. Afiseaza traseele publicate atribuite soferului,
   inclusiv sarcinile restante care necesita actiune.
3. **Detaliul opririi**: furnizor/client, contact, telefon, adresa,
   instructiuni, comenzi, produse si cantitati. Actiuni Apel si Deschide harta;
   coordonatele se folosesc daca sunt disponibile, altfel adresa.
4. **Furnizor / Preluare de marfa**: actiunea Am ajuns / Incepe preluarea
   blocheaza lista. Soferul vede produsele fixate, inregistreaza cantitatile
   primite si fotografiaza seria/partida pentru fiecare produs primit.
   Progresul arata fotografiile salvate si cele lipsa. Inchide preluarea
   valideaza fotografiile si creeaza Factura de intrare; soferul vede numarul
   documentului rezultat. Lipsurile/refuzurile se raporteaza fara modificarea
   listei planificate. Regulile pentru partiale se confirma separat.
5. **Livrare**: pornire livrare, confirmarea cantitatilor livrate sau
   raportarea unui esec cu motiv, de exemplu client absent ori adresa gresita.
   Afiseaza produsele cu serii/partide si preturi, serviciile separat,
   totalurile si detaliile platii conform sectiunii 9E.
   Ecranul arata Asteapta confirmarea dispecerului sau Pregatita pentru predare.
   Predarea este disponibila numai dupa autorizarea dispecerului.
   Fotografia/semnatura se adauga conform deciziei privind dovada livrarii.
6. **Sosire la depozitul de baza**: butonul Am ajuns la depozit declanseaza
   transferul soldului ramas din depozitul soferului in depozitul de baza.
   Ecranul afiseaza produsele/cantitatile transferate si documentul rezultat;
   marfa deja livrata pe traseu nu intra in transfer.
7. **Predare altui curier**: identificarea destinatarului si cantitatilor;
   primirea se confirma de destinatarul autorizat. Dispecerul vede separat
   predarea initiata si primirea confirmata.

Soferul vede sarcinile proprii si datele necesare executarii lor. Repartizarea
zonelor, schimbarea curierului si replanificarea raman actiuni ale dispecerului.
O problema raportata de sofer intra in lista de rezolvat a dispecerului.

### Legatura cu WMS

Flux: WMS publica planul -> soferul incepe preluarea si blocheaza lista ->
fotografiaza fiecare produs -> inchide preluarea -> serverul creeaza Factura
de intrare -> dispecerul completeaza seriile/partidele -> pregateste vanzarea
din depozitul soferului -> soferul confirma predarea -> dispecerul genereaza
si transmite cecul electronic dupa caz. Dispecerul autorizeaza explicit
predarea dupa pregatirea vanzarii; soferul asteapta aceasta confirmare.

Browserul comunica prin HTTPS cu un backend; accesul Firebird ramane pe
server. WMS si backend-ul folosesc aceeasi sursa operationala pentru sarcini,
alocari si stari, cu validari comune la nivelul bazei sau procedurilor.
Se evita sincronizarea intre doua cataloage independente de comenzi.

Backend-ul verifica la fiecare citire/modificare identitatea, atribuirea
actuala, starea si cantitatea ramasa. Confirmarile au identificator unic
pentru a evita dublarea la apasari repetate sau retransmitere. Schimbarea
atribuirii ori anularea unei sarcini invalideaza actiunile dintr-un ecran vechi.
Corectiile pastreaza confirmarea initiala si autorul in jurnal.

WMS si telefonul se actualizeaza periodic si la revenirea in ecran; se
afiseaza ultima actualizare. Mecanismul concret si intervalul se stabilesc
la implementare. Planurile ciorna nu sunt prezentate ca trasee de executat.

Se poate reutiliza infrastructura Yii2 a `fantastic.web` pentru un modul
autentificat dedicat soferilor sau se poate utiliza un serviciu separat.
Alegerea se face dupa inspectarea instructiunilor si autentificarii acelui
proiect; aceasta propunere nu presupune ca integrarea este deja verificata.

### Conexiune slaba si confirmari

Confirmarile se fac numai online. Fara conexiune, actiunile de confirmare
sunt indisponibile si ecranul explica necesitatea reconectarii. Nu exista
coada locala de confirmari si nu se transmit automat actiuni la reconectare.

Interfata distinge clar Trimitere in curs, Salvata pe server, Eroare si
Respinsa/conflict. O confirmare nereceptionata de server nu apare in WMS ca
executata. Daca raspunsul se pierde dupa trimitere, aplicatia verifica starea
pe server la reconectare; reluarea foloseste acelasi identificator de actiune
pentru a evita dublarea. Datele introduse pot ramane in formular pentru
reluare manuala, fara a fi considerate o confirmare executata.

Consultarea ultimei copii a traseului poate fi oferita cu indicarea datei si
orei actualizarii. La reconectare se actualizeaza traseul si atribuirile
inainte de o noua confirmare. Momentul executarii confirmate este inregistrat
de server.

GPS continuu, optimizarea automata a traseului si notificari push raman
extensii optionale. Butonul de deschidere a hartii face parte din fluxul de baza.

## 9B. Preluarea blocata, intrarea si vanzarea din masina

### Sosirea la furnizor si blocarea

Soferul deschide furnizorul/oprirea si apasa Incepe preluarea. Serverul
fixeaza lista curenta de produse, comenzile si cantitatile, apoi inregistreaza
blocarea, curierul si ora. Produsele nu se mai adauga, elimina, reatribuie sau
modifica in documentul inceput. Fotografierea, cantitatea efectiv primita si
raportarea problemelor sunt actiunile de executare permise.

O adaugare concurenta se finalizeaza fie inaintea fixarii listei si este
inclusa, fie este respinsa dupa blocare; nu poate aparea neobservata in lista.
Produsele solicitate ulterior se planifica intr-un alt document de preluare;
alte documente pentru acelasi furnizor pot fi editate potrivit starii lor.
Blocarea nu expira la inchiderea browserului sau pierderea internetului;
soferul revine la acelasi document. O deblocare exceptionala necesita drept
distinct, motiv si jurnal, fara rescrierea unei preluari deja inchise.

### Fotografii pentru serie/partida

Fiecare produs primit are fotografii asociate pozitiei si unitatii/cantitatii
relevante. Pentru produse cu serie individuala se identifica fiecare unitate;
pentru produse pe partida se identifica fiecare partida si cantitatea ei.
Imaginea trebuie sa permita citirea seriei/partidei. Pozele se pot reface
inainte de inchidere; dupa inchidere dovezile initiale raman in istoric.

Aplicatia permite fotografierea cu telefonul si previzualizarea rezultatului.
Inchiderea necesita fisiere salvate complet pe server; o fotografie selectata
local ori aflata in curs de incarcare nu indeplineste cerinta. Accesul la
fotografii este autentificat, iar legatura lor cu documentul se pastreaza.
Produsele fara identificator si imaginile ilizibile necesita reguli de exceptie
de confirmat; nu se inventeaza serii pentru a permite inchiderea.

### Inchiderea si crearea Facturii de intrare

La Inchide preluarea serverul reverifica blocarea, curierul, cantitatile,
fotografiile si datele necesare facturii. Intr-o tranzactie creeaza documentul
Factura de intrare si pozitiile sale, leaga documentul de preluare si apoi
marcheaza preluarea Incarcat (inchisa pentru modificari). Daca generarea
esueaza, preluarea ramane deschisa
si blocata, cu eroare explicita; nu se raporteaza succes partial.

Factura include furnizorul comercial corect (care poate diferi de punctul
de ridicare), firma, depozitul soferului, produsele/cantitatile primite si
referintele la comenzile si fotografiile sursa. Preturile, TVA si datele
facturii furnizorului folosesc surse verificate sau raman pentru completare
potrivit regulilor existente; nu se deduc din pretul de vanzare.

Crearea documentului si validarea/postarea lui sunt etape distincte.
Factura trebuie sa poata fi creata in starea de completare inainte de
transcrierea seriilor/partidelor. Daca mecanismul actual nu permite aceasta stare,
adaptarea lui face parte din implementare. Validarile de selectie se modifica
explicit pentru a accepta seriile si partidele salvate din facturi deschise; validarile
de depozit, cantitate si utilizare unica se pastreaza.
Unicitatea legaturii preluare-factura previne facturi duplicate la reluare.

### Lucrul dispecerului si livrarea directa

La inchidere, factura intra imediat in lista de procesat a dispecerului.
Acesta vede fotografia langa produs, introduce seria/partida si cantitatea,
verifica completitudinea si finalizeaza intrarea conform regulilor WMS.
Fotografia ramane legata de datele transcrise pentru verificare ulterioara.
Fiecare serie/partida salvata devine imediat activa pentru vanzare, fara asteptarea
completarii tuturor pozitiilor sau inchiderii Facturii de intrare.

Pentru clientul aflat pe traseu, soferul poate livra marfa din masina.
Dispecerul completeaza in vanzare depozitul soferului si seriile/partidele
corespunzatoare marfii efectiv predate. Aplicatia arata care unitati/produse
trebuie predate; cand este necesar, soferul indica fotografia/unitatea aleasa,
fara obligatia de a transcrie seria pe telefon. Aceeasi unitate nu poate fi
alocata la doua vanzari. Pregatirea contabila si predarea fizica au stari
separate. Dupa completarea si validarea datelor necesare in vanzare,
dispecerul apasa Autorizeaza predarea. Aplicatia soferului afiseaza Pregatita
pentru predare; pana atunci afiseaza Asteapta confirmarea dispecerului si
blocheaza actiunea de predare. Serverul verifica autorizarea pentru versiunea
curenta a vanzarii. Modificarea produselor, seriilor/partidelor, cantitatilor
sau depozitului retrage autorizarea si necesita o noua confirmare a dispecerului.

Dupa caz, dispecerul genereaza cecul electronic prin mecanismul fiscal
existent si il transmite clientului pe canalul configurat. Se pastreaza
distinct Cec de generat, Cec generat, Trimitere in curs, Transmis si Eroare.
Reluarea transmiterii foloseste acelasi cec; nu refiscalizeaza vanzarea.
Canalul, datele de contact si disponibilitatea fiscalizarii electronice se
verifica la integrare. Acest plan nu schimba regulile fiscale existente.

Fluxul se repeta independent la fiecare furnizor. Dispecerul poate procesa
intrarea furnizorului anterior in timp ce soferul ajunge la urmatorul.

## 9C. Selectarea seriilor si partidelor din Factura de intrare deschisa

Seriile si partidele devin active imediat dupa introducere si salvare in
baza, chiar daca Factura de intrare este deschisa. Textul nesalvat din
editor nu este disponibil altor documente. Regula se aplica selectiei din
Factura de intrare in WMS, inclusiv fluxului dispeceratului.

Exemplu: intrarea contine trei produse si ramane deschisa. Dispecerul
salveaza seria sau partida primului produs; o poate selecta imediat in
vanzare din depozitul soferului si autoriza predarea, continuand apoi
completarea celorlalte pozitii.

La selectie se verifica produsul, firma/depozitul, provenienta din pozitia
intrarii si starea identificatorului. Factura deschisa nu constituie motiv
de excludere. Seria individuala deja rezervata sau consumata nu este libera
pentru alta vanzare. O partida poate alimenta mai multe vanzari, in limita
cantitatii ramase: cantitate salvata la intrare minus cantitati rezervate
si consumate, fara dubla scadere a aceleiasi alocari. Rezervarile eliberate
si retururile se reflecta conform fluxurilor existente.

Alocarea seriei sau cantitatii din partida se face atomic; doi operatori
nu pot vinde aceeasi unitate sau depasi cantitatea disponibila a partidei.
Seria/partida folosita sau rezervata nu se sterge si nu se schimba fara
rezolvarea legaturilor cu vanzarile. Cantitatea partidei nu poate fi redusa
sub cantitatea deja rezervata/consumata. Anularea intrarii necesita corectie
explicita, cu provenienta si jurnal pastrate.

Inchiderea ulterioara a Facturii de intrare pastreaza identitatile si
legaturile seriilor/partidelor; nu le activeaza a doua oara si nu reface
cantitatile consumate. Calculul disponibilitatii si postarea intrarii se
armonizeaza pentru a evita dubla numarare a marfii deja vandute.

La implementare se identifica si modifica filtrele si validarile relevante:
view-uri/proceduri de serii si partide disponibile, selectoare, alocari in
vanzare, validarea vanzarii, inchiderea/anularea intrarii si calculele de
cantitate disponibila. Definitiile live se citesc din Firebird; eliminarea
unui filtru numai din UI nu este suficienta.

## 9D. Sosirea la baza si transferul soldului din masina

Butonul Am ajuns la depozit este disponibil soferului autentificat, online.
Depozitul sursa este cel asociat soferului, iar destinatia este depozitul
de baza configurat pentru firma/operatiune. Destinatia nu se deduce din text.

Serverul calculeaza soldul efectiv ramas pe produse, serii si partide:
marfa intrata/preluata in depozitul soferului, minus marfa efectiv eliberata
clientilor si alte iesiri/transferuri deja executate. Nu se transfera
cantitatea initial planificata si nici totalul brut al Facturilor de intrare.
Pentru serie se transfera unitatea ramasa; pentru partida, cantitatea ramasa.

Exemplu: soferul a incarcat 10 unitati si a livrat 3 pe traseu. La sosirea
la baza se transfera 7 unitati, cu seriile/partidele lor; cele 3 livrate nu
reapar nici in masina, nici in depozitul de baza.

Se creeaza si executa documentul de transfer prin mecanismul existent WMS:
iesire din depozitul soferului si intrare in depozitul de baza, in aceeasi
tranzactie, cu provenienta si identificatorii pastrati. Se inregistreaza
soferul, data/ora, soldul transferat si legatura cu revenirea/traseul.
La succes, produsele transferate sunt in baza, iar soldul lor din masina
este zero. Daca nu exista sold, se inregistreaza sosirea fara transfer gol.

Calculul tine cont si de seriile/partidele active din Facturi de intrare
inca deschise. O livrare confirmata fizic, dar a carei iesire contabila este
inca in procesare, trebuie exclusa o singura data din soldul transferabil.
Postarea ulterioara a intrarii/vanzarii nu trebuie sa dubleze cantitatile
sau sa readuca marfa transferata in depozitul soferului. Acest flux necesita
armonizarea disponibilitatii operationale cu miscarile de stoc existente.

O vanzare pregatita/autorizata, dar nepredata clientului, nu este tratata ca
livrare executata: marfa ei se afla in masina si face parte din soldul ramas.
La transfer se retrage autorizarea predarii din masina si se semnaleaza
dispecerului actualizarea depozitului/alocarii si replanificarea livrarii.
Documentele deja executate raman in istoric; nu se rescriu.

Transferul si confirmarea livrarii verifica tranzactional aceleasi alocari,
astfel incat aceeasi unitate/cantitate sa nu poata fi simultan livrata si
transferata. Actiunea de sosire are identificator unic: dubla apasare sau
reluarea dupa pierderea raspunsului returneaza acelasi rezultat, fara al
doilea transfer. O noua incarcare/traseu permite o noua operatie de sosire.

La eroare nu se afiseaza Sold transferat; soldul nu se modifica partial,
iar soferul si dispecerul vad cauza si pot relua operatia. Lista din WMS
arata distinct Incarcat la furnizor, Livrat pe traseu si Transferat la baza,
pastrand documentele de preluare inchise si traseul marfii.

## 9E. Detaliul fiecarei livrari: produse, servicii si plata

Pentru toate livrarile, inclusiv cele direct din masina, soferul vede
aceeasi structura de detalii, legata de comanda si vanzarea pregatita de
dispecer. Datele necesare predarii sunt afisate inainte de confirmare.

### Produse de predat

Lista de marfa contine denumirea/codul, cantitatea, unitatea de masura,
seria sau partida atribuita de dispecer, pretul unitar aplicat clientului
si totalul pozitiei. Pentru mai multe unitati cu serii individuale se arata
fiecare serie; pentru partide se arata cantitatea de predat din fiecare.
Sub lista apare Total produse. Pretul este pretul efectiv de vanzare,
cu reducerile aplicate; nu este pretul de achizitie de la furnizor.

Soferul vede exact marfa alocata livrarii curente. Daca o comanda are mai
multe livrari, se disting Produse in aceasta livrare si Total produse al
comenzii; nu se prezinta marfa altei livrari ca fiind de predat acum.

### Servicii separate

O sectiune distincta contine Livrare, Ridicare la etaj, Conectare si orice
alte servicii din comanda, fiecare cu denumire, cantitate, pret unitar si
suma. Sub lista apare Total servicii. Serviciile nu sunt amestecate cu
produsele si nu intra in soldul fizic al masinii sau in transferul la baza.

Clasificarea marfa/serviciu foloseste atributul sau nomenclatorul existent
verificat in WMS, nu o cautare dupa cuvinte in denumire. Se afiseaza numai
serviciile efectiv incluse in comanda, inclusiv cele gratuite la pret zero.

### Totaluri si plata

Rezumatul contine Total produse, Total servicii si Total comanda, in moneda
documentului. Totalurile provin din documentele comerciale si respecta
reducerile, TVA si rotunjirile existente; nu se adauga TVA sau reduceri
inca o data in interfata. Daca exista ajustari distincte, acestea sunt
explicate pentru ca totalul sa poata fi verificat de sofer.

Se afiseaza modalitatea de plata convenita: Numerar, Card, Credit sau
Transfer. Plata partiala este o stare de achitare, afisata impreuna cu
modalitatea/modalitatile folosite, nu o informatie care le inlocuieste.
Pentru plata mixta se arata separat sumele pe fiecare modalitate.

Se afiseaza Suma deja achitata, Rest de achitat si Suma de incasat de sofer
la aceasta livrare. Restul total al comenzii nu se presupune automat a fi
suma pe care trebuie sa o colecteze soferul. Pentru card/transfer se disting
plata confirmata si plata in asteptare; pentru credit se afiseaza indicatia
de predare/incasare stabilita in document, fara a presupune plata integrala
in numerar la livrare. Platile se citesc din sursa contabila existenta.

Exemplu: Produse 5 000 lei, Servicii 300 lei, Total comanda 5 300 lei;
Achitat 2 000 lei prin transfer, Rest 3 300 lei, De incasat acum 3 300 lei
numerar, daca aceasta este instructiunea confirmata de dispecer.

Soferul consulta aceste date; introducerea incasarii, confirmarea platii cu
cardul si integrarea cu terminalul necesita definirea explicita a fluxului.
Confirmarea predarii nu marcheaza implicit comanda ca achitata integral.
Dispecerul gestioneaza pregatirea vanzarii si fiscalizarea conform planului.

Preturile, serviciile si instructiunile de plata fac parte din versiunea
livrarii prezentate soferului. Schimbarea lor dupa autorizare necesita
reconfirmarea dispecerului si actualizarea ecranului. Serverul respinge
confirmarea dintr-o versiune veche pentru a evita predarea/incasarea dupa
date comerciale depasite.

## 10. Etape de implementare

1. **Analiza finala**: raspunsuri la intrebarile deschise; buffere IDE;
   metadate pentru ridicari, livrari, adrese, colaboratori, frame82 si cheile
   pozitiilor; identificarea fluxurilor de comanda/vanzare vizate.
2. **Date logistice**: zone, eligibilitate curieri, puncte, atribuirea zonelor
   adreselor si matricea curierilor. Datele vechi fara zona raman vizibile.
3. **Integrarea documentelor**: furnizori/cantitati, sursa stoc propriu,
   adresa si data livrarii, depozit sofer, generarea Facturii de intrare la
   inchidere, completarea seriilor/partidelor si legatura cu vanzarea;
   activarea seriilor si partidelor salvate din intrari deschise si ajustarea selectiei,
   alocarii si validarilor de stoc afectate.
4. **Forma dispecerului**: paginile achizitii/livrari, filtre, restante,
   atribuiri in masa si modificari manuale.
5. **Trasee si executare**: opriri consolidate, ordine, dependente, predari,
   confirmari, jurnal si fisa tiparita pentru curier.
6. **Backend si acces soferi**: autentificare legata de colaborator, citirea
   traseului publicat, blocare persistenta la sosire, fotografii pe produs,
   inchidere atomica cu generare intrare, prevenirea duplicatelor si WMS.
7. **Aplicatie web pe telefon**: traseu, oprire, apel/harta, preluare, livrare,
   produse cu serii/partide si preturi, servicii separate, totaluri si plata,
   raportare probleme si predari. Confirmarile necesita internet; dovada
   livrarii se implementeaza potrivit raspunsului la intrebarea deschisa.
8. **Procesarea din birou**: fotografii langa pozitiile intrarii, transcriere
   serii/partide, pregatire vanzare din masina, cec electronic si transmitere.
9. **Revenirea la baza**: stare Incarcat la inchiderea preluarii, butonul de
   sosire, calculul soldului ramas si transferul atomic in depozitul de baza,
   inclusiv pentru intrari deschise si livrari executate pe traseu.
10. **Pilot**: o zi de lucru, cateva zone si curieri; verificarea rezultatelor
   impreuna cu dispecerul, apoi activare generala.

Prima versiune include planificarea manuala in WMS, aplicatia web a soferului
si fisa tiparita ca suport. Optimizarea automata a rutelor, GPS continuu si
notificarile automate se estimeaza separat daca sunt solicitate.

Implementare Delphi: VCL/DevExpress, IBDAC, tranzactii in ciclul existent
Prepare / IsFormDataPosted / WhenCancelForm. Scripturile DDL vor fi rerulabile
in `DB Model/` si aplicate de DBA. Noile unit-uri se inregistreaza in SWN.dpr.
Se pastreaza codificarile si CRLF ale surselor conform AGENTS.md.

## 11. Scenarii de acceptare

1. Doua comenzi de la acelasi punct de furnizor se grupeaza intr-o oprire;
   detaliul pastreaza produsele si cantitatile fiecarei comenzi.
2. O comanda cu doi furnizori apare cu doua preluari si un curier de livrare;
   livrarea nu se confirma integral pana cand marfa necesara este disponibila.
3. Curier A ridica, curier B livreaza; predarea ramane identificabila.
4. O comanda din stoc propriu are livrare fara ridicare externa.
5. Schimbarea curierului implicit al zonei nu sterge exceptiile manuale.
6. Adresa fara zona si zona fara curier apar in listele de probleme.
7. O livrare esuata este replanificata pentru maine, cu motiv si istoric.
8. Modificarea ulterioara a adresei clientului nu altera un traseu executat.
9. Anularea comenzii si lucrul simultan al doi dispeceri nu produc sarcini
   duplicate, cantitati excesive sau pierderea modificarilor.
10. Daca se aproba partialele: cantitatea executata si restul de executat
    raman corecte la schimbarea furnizorului, curierului si zilei.
11. Fisa curierului arata ordinea, adresele, contactele, marfa/comenzile si
    instructiunile relevante; achizitiile si livrarile sunt usor de distins.
12. Pe telefon, soferul vede numai traseele proprii publicate; nici modificarea
    unui identificator de sarcina nu permite acces la sarcinile altui sofer.
13. Confirmarea unei preluari/livrari apare in WMS cu cantitatile si autorul;
    retransmiterea aceleiasi confirmari nu dubleaza executarea.
14. O sarcina anulata sau reatribuita nu poate fi confirmata din ecranul vechi
    al telefonului; soferul primeste explicatia si traseul actualizat.
15. Fara internet nu se poate confirma o operatiune. Daca se pierde raspunsul
    unei confirmari trimise, reconectarea verifica rezultatul pe server,
    fara dublare si fara executarea automata a unor actiuni offline.
16. Interfata se verifica pe telefoanele folosite efectiv de soferi: citirea
    produselor, butoanele, apelul, harta si eventual incarcarea dovezii livrarii.
17. Dupa Incepe preluarea, WMS si backend-ul resping adaugarea, stergerea si
    modificarea produselor din documentul blocat, inclusiv la operatii concurente.
18. Inchiderea browserului nu pierde blocarea si documentul inceput.
19. Fiecare produs/unitate/partida primita are fotografia necesara salvata;
    inchiderea este refuzata daca lipsesc fotografii sau incarcarea este in curs.
20. Inchiderea genereaza exact o Factura de intrare; esecul crearii nu inchide
    preluarea, iar retransmiterea returneaza documentul deja creat.
21. Dispecerul vede fotografiile pe pozitiile intrarii si completeaza seriile/
    partidele; seria/partida salvata este selectabila imediat, chiar din intrarea
    deschisa. Starea contabila a intrarii se urmareste separat.
22. Marfa preluata intra in depozitul soferului; vanzarea din masina foloseste
    acel depozit si seria/partida unitatii efectiv livrate, fara alocare dubla.
23. Pentru furnizori succesivi sunt documente de preluare si intrari distincte;
    procesarea in birou poate continua in paralel cu traseul soferului.
24. Repetarea transmiterii cecului nu genereaza un nou cec; erorile fiscale si
    cele de transmitere sunt vizibile separat dispecerului.
25. Blocarea unei preluari nu blocheaza alte documente de la acelasi furnizor.
26. Soferul nu poate confirma predarea inainte de autorizarea dispecerului;
    schimbarea datelor relevante ale vanzarii invalideaza autorizarea anterioara.
27. Seria/partida salvata intr-o Factura de intrare deschisa apare in selectorul
    vanzarii pentru produsul/depozitul corect; o serie/partida nesalvata nu apare.
28. O intrare completata partial permite vanzarea unitatilor cu serii/partide salvate,
    fara a astepta celelalte pozitii sau inchiderea documentului.
29. Doua vanzari concurente nu pot aloca aceeasi serie; seria rezervata sau
    consumata nu este libera chiar daca intrarea este deschisa.
30. Stergerea/modificarea unei serii/partide folosite si anularea intrarii sunt
    protejate; inchiderea ulterioara nu dubleaza stocul sau disponibilitatea.

31. O partida dintr-o intrare deschisa poate fi alocata mai multor vanzari
    in limita cantitatii disponibile; alocarile concurente nu depasesc
    cantitatea salvata, iar reducerea sub cantitatea alocata este respinsa.

32. Inchiderea preluarii schimba starea in Incarcat si genereaza intrarea;
    un esec al generarii nu marcheaza documentul Incarcat.
33. Din 10 unitati incarcate si 3 livrate pe traseu, sosirea la baza transfera
    exact 7, cu seriile/partidele corecte, si lasa sold zero pentru ele in masina.
34. Repetarea actiunii de sosire nu dubleaza transferul; sold zero nu produce
    un document de transfer fara pozitii.
35. O livrare concurenta cu transferul nu poate consuma aceeasi marfa;
    autorizarile neexecutate din masina sunt retrase pentru marfa transferata.
36. Inchiderea ulterioara a unei intrari deschise nu readuce marfa transferata
    in masina si nu dubleaza soldul bazei.

37. Fiecare livrare arata exact produsele de predat, seriile/partidele,
    cantitatile, preturile unitare si totalul produselor.
38. Livrarea, ridicarea la etaj si conectarea apar separat cu total servicii;
    serviciile nu sunt incluse in transferul fizic al marfii la baza.
39. Totalul comenzii coincide cu documentul comercial, inclusiv reduceri,
    TVA si rotunjiri, fara dublarea serviciilor sau a sumelor achitate.
40. Numerar, card, credit, transfer, plata partiala/mixta sunt prezentate
    cu suma achitata, restul si suma de incasat la livrarea curenta.
41. Predarea nu confirma automat plata; schimbarea pretului, serviciilor
    sau instructiunilor de plata invalideaza autorizarea versiunii vechi.

## 12. Rezultatul asteptat

Dispecerul alege ziua, verifica comenzile si adresele, repartizeaza zonele,
rezolva exceptiile si publica traseele. Pentru fiecare comanda poate raspunde:
de unde vine marfa, cine o ridica, unde se afla, cine o livreaza, la ce adresa
si cand; restantele si problemele sunt vizibile intr-un singur ecran.
Soferul primeste traseul publicat pe telefon si transmite executarile si
problemele direct din aplicatia web, iar dispecerul urmareste progresul in WMS.
