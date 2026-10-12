# Analiza aplicației de referință uno.md/app/curier

Data: 2026-10-10. Sursa: 3 capturi de pe telefon (`referinte/uno-curier-*.png`), din 09.10, ora 22:39–22:40.
Aplicația **nu** folosește baza SW: în `TS_CUSTOMER` nu există „Curier 3 Ciprian”, iar zonele „Центр”/„Аэропорт” nu apar nicăieri. O tratăm doar ca referință de interfață și flux.

## Ce se vede

### Antetul (comun)
- Selector **„Curier 3 Ciprian”**: curierul se alege dintr-o listă, nu printr-un login propriu.
- Două file mari: **Закупки** (achiziții) / **Доставки** (livrări). Fiecare filă are o bulină „!”. La 22:39 bulina apare pe ambele file, iar la 22:40 pe niciuna. Bulina semnalează deci modificări noi, încă nevăzute, și dispare după deschiderea filei.
- Butonul **„Незакрытые доставки 49”**: restanțele, adică livrările neînchise din zilele anterioare.

### Livrări (capturile 1 și 3)
- Grupate pe **zone** (Центр, Аэропорт), fără ordine explicită a opririlor.
- Cardul unei comenzi:
  - numărul comenzii (73563), mare;
  - prenumele clientului (Oleg) și miniatura primului produs;
  - **suma de încasat** (2338 MDL) și **modalitatea de plată** (Наличными);
  - **telefonul** pe care se apasă pentru apel (verde);
  - **adresa** (or. Chișinău, Valea Trandafirilor str. 2/b), care pare să nu fie legată de hartă;
  - **operatorul** (Irina Creanga) și **nota** în roșu („De livrat de urgenta azi pe 08.10”);
  - **starea** cu punct colorat („Доставлен”, mov).
- Livrările deja făcute rămân în lista zilei.

### Achiziții (captura 2)
- Grupate pe **punct de ridicare**: „Склад” (depozitul propriu, ca oprire), apoi furnizorul „Smadshop” cu săgeată (→ detalii/hartă?).
- Rândul unui produs:
  - imaginea, denumirea și codul;
  - prețul × cantitatea = suma (1095 × 2 = 2190);
  - starea cu punct colorat: „Ожидает закупку” (galben) → „Выгружен” (verde);
  - butonul **„✓ Выполнить”** pe fiecare produs.
- **Săgeata de direcție**:
  - **←** albastru = marfă luată de la furnizor;
  - **→** roșu, pe un rând cu fundal roșu = **retur la furnizor** („Стул Heniver Paris”, notă „5buc retur efactura”).
- Totalul opririi: „3 товаров · Итого: 2840 MDL” (2190 + 650; returul nu intră).
- Probabil defect de afișare: la retur apare „141 шт = 0”, adică lipsește cantitatea.

## Comparație cu planul CurieriWMS

| Element uno.md | În plan | Concluzie |
|---|---|---|
| Achiziții / Livrări pe file separate | §6, §9A ecranele 4–5 | Preluăm. Pe telefon e mai clar decât un traseu mixt; traseul ordonat devine a treia vedere sau ordinea din interiorul filelor |
| Grupare pe zone / furnizori | §4–§5 zone, §7 opriri consolidate | Preluăm. Gruparea pe furnizor = „oprire” |
| Bulina „!” pentru modificări nevăzute | §9A „actualizare periodică … ultima actualizare” | **Preluăm.** Planul nu are încă un semnal explicit pentru modificările dispecerului |
| Contorul de restanțe (49) | §6 „restanțele nu dispar la schimbarea datei” | Preluăm, și pe telefon |
| Suma + modalitatea de plată pe card | §9E | Preluăm pe card. Detaliul complet (produse cu serii, servicii separate, achitat/rest) rămâne în ecranul livrării |
| Operator + notă roșie | §4 „instrucțiuni” | Preluăm. Operatorul (cine a vândut) e util pentru întrebări |
| Telefon pe care se apasă | §9A ecranul 3 „Apel” | Preluăm. Adăugăm și **Deschide harta** pe adresă (uno nu pare să aibă) |
| Depozitul propriu ca oprire în achiziții | §4 „sursa depozit” | **De clarificat**: planul nu creează ridicare din stocul propriu, dar șoferul tot încarcă marfa din depozit. Pare util ca oprire de încărcare |
| **Retur la furnizor** (→ roșu) | **lipsește** | **Cerință nouă**: tip de sarcină „retur la furnizor”, cu document de ieșire, fără Factură de intrare |
| „Выполнить” pe fiecare produs | §9B: preluarea pe **document** (Începe → listă blocată → fotografii → Închide) | Planul e mai strict, intenționat. Păstrăm planul; în interiorul preluării, fiecare rând are progres propriu (fotografie, cantitate) |
| Curierul ales din listă | §9A ecranul 1: login individual | **Nu preluăm.** Selectorul permite oricui să vadă și să confirme sarcinile altuia (scenariul 12 de acceptare) |
| Prețul de achiziție vizibil șoferului | neprecizat (§9E vorbește doar de prețul de vânzare) | **Decizie**: arătăm costul la achiziții? Ajută la verificarea facturii furnizorului, dar expune marja |
| Interfață în rusă, date în română | „interfața în română” (CLAUDE.md) | **Decizie**: comutator RO/RU, pentru că șoferii pot prefera rusa |
| Fără fotografii, fără blocare, fără autorizarea predării | §9B–§9E | Diferența principală a CurieriWMS. Interfața trebuie să rămână la fel de simplă ca la uno, deși fluxul e mai complex |

## Idei de interfață de preluat

- Carduri mari pe fond alb, numărul comenzii proeminent, suma și plata în colțul din dreapta-sus.
- Starea = punct colorat + text, pentru că nu ne bazăm doar pe culoare (§6).
- Rândurile cu excepții (retur, notă urgentă) au **fundal colorat** pe tot rândul.
- Totalul opririi la finalul grupului.
- Filele sus, fixe, cu contoare.

## De evitat

- Selectorul de curier fără autentificare.
- Afișări incomplete de tipul „141 шт = 0”: cantitatea trebuie să apară mereu, iar totalul unui retur să fie marcat explicit.
- Starea „Доставлен” fără ora livrării și fără autorul confirmării: planul cere ambele (§9A, scenariul 13).

## Decizii ale proprietarului (2026-10-10)

1. Aplicația uno.md **rămâne în paralel**: nu se înlocuiește și nu se integrează.
2. Returul la furnizor **intră în prima versiune**.
3. Depozitul propriu **apare ca oprire** de încărcare în lista de achiziții.
4. Șoferul **vede prețul de achiziție** (preț × cantitate = sumă, total pe oprire).
5. Interfața e **în română** (fără comutator RU în prima versiune).

Toate au fost trecute în plan: §1 (cerințe confirmate), secțiunea nouă §9F, §10 (etapele 3 și 7) și scenariile de acceptare 42–46.
