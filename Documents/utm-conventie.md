# Convenția UTM — Fantastic.md (rețele sociale, bannere, video)

**Regula:** orice link spre fantastic.md publicat pe Facebook, Instagram, TikTok, Viber, Telegram sau pus pe un banner (inclusiv QR) are **toți cei 4 parametri UTM**. Fără excepții. Fără UTM, vizita apare în GA4 ca `facebook.com / referral` și nu se poate lega de postare.

## Parametri

| Parametru | Valori permise | Exemplu |
|---|---|---|
| `utm_source` | `facebook`, `instagram`, `tiktok`, `viber`, `telegram`, `print` | `facebook` |
| `utm_medium` | `organic` — postare în feed · `profile` — link din profil / bio / butonul paginii · `story` — story sau link sticker · `reels` — Reels / clip video · `paid_social` — reclamă plătită · `qr` — cod QR pe banner sau print | `organic` |
| `utm_campaign` | `plan_<lună>_<an>` pentru planul lunar (`plan_sept_2026`, `plan_oct_2026`) sau numele promoției (`black_friday_2026`) | `plan_sept_2026` |
| `utm_content` | identificatorul postării: `zi<NN>_<slot>` (`s1` dimineața, `banner` prânz, `s3` seara), plus `_ru` pentru linkul în rusă; pentru video `tt<NN>`, pentru banner/QR `bn<NN>` | `zi04_banner_ru` |

Totul cu **litere mici**, fără spații și fără diacritice.

## Șabloane gata de copiat

```
Postare Facebook (text RO):
https://www.fantastic.md/<cale>?utm_source=facebook&utm_medium=organic&utm_campaign=plan_oct_2026&utm_content=zi01_s1

Link din profilul paginii Facebook:
https://www.fantastic.md/?utm_source=facebook&utm_medium=profile&utm_campaign=always_on&utm_content=page_link

Link din bio Instagram:
https://www.fantastic.md/?utm_source=instagram&utm_medium=profile&utm_campaign=always_on&utm_content=bio

Link sticker în story Instagram / Facebook:
https://www.fantastic.md/<cale>?utm_source=instagram&utm_medium=story&utm_campaign=plan_oct_2026&utm_content=st01

Link din bio TikTok:
https://www.fantastic.md/?utm_source=tiktok&utm_medium=profile&utm_campaign=always_on&utm_content=bio

Cod QR pe banner / flyer:
https://www.fantastic.md/<cale>?utm_source=print&utm_medium=qr&utm_campaign=<campanie>&utm_content=bn01
```

## Particularități pe platforme

- **Instagram și TikTok** nu au linkuri clicabile în descriere. Linkul cu UTM se pune în **bio** (`utm_medium=profile`), în **link sticker** la story sau în butonul de reclamă. În text scrie „link în bio · fantastic.md”.
- **Bannerele** sunt imagini, deci linkul lor e cel din textul postării. Dacă bannerul are **cod QR**, QR-ul trebuie generat din linkul cu UTM (`utm_medium=qr`).
- **Reclamele plătite (Meta Ads)** folosesc `utm_medium=paid_social`. Câmpul „URL parameters” din anunț poate folosi macro-uri: `utm_source=facebook&utm_medium=paid_social&utm_campaign={{campaign.name}}&utm_content={{ad.name}}`.

## Cum se citește în GA4

- **Rapoarte → Achiziție → Achiziție de trafic.** Dimensiunea principală: *Sursă / mediu a sesiunii*; dimensiunea secundară: *Conținut manual al anunțului* (= `utm_content`) sau *Campanie*.
- **Atenție la sesiunile false:** la programarea unei postări, Facebook deschide o dată linkul pentru previzualizare. Asta creează 1–4 sesiuni cu `utm_content` al postării **înainte** de publicare. La analiză se numără doar sesiunile de după ora publicării.
- `facebook.com / referral` = clicuri pe linkuri **fără** UTM (distribuiri, postări vechi, linkuri fără etichete). Scopul e ca această linie să scadă.
