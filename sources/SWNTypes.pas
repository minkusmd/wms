unit SWNTypes;

interface

const

  // CONFIGURATII
  cDBID_DocType_КОНФИГУРАЦИИ_К = 115; // Configurator

  // FACTURI
  cDBID_DocType_СЧЕТА_СНО = 101; // Facturi de plata
  cDBID_DocType_СЧЕТА_ВС = 1455; // Facturi de intrare
  cDBID_DocType_СЧЕТА_П = 103; // Aprovizionari
  cDBID_DocType_СЧЕТА_ПЗ = 104; // Comenzi preliminare

  // NAKLADNIE
  cDBID_DocType_НАКЛАДНЫЕ_ПН = 106; // Intrare marfa (Evidenta operativa)
  cDBID_DocType_НАКЛАДНЫЕ_РН = 107; // Nakladnaia de iesire (Evidenta operativa)
  cDBID_DocType_НАКЛАДНЫЕ_ПТПН = 109; // Intrare marfa pe nakladnie
  cDBID_DocType_НАКЛАДНЫЕ_ВТОК = 110; // Retur marfa de la client (10zile)
  cDBID_DocType_НАКЛАДНЫЕ_Р = 108; // Rezerva

  // TRANSFER
  cDBID_DocType_ПЕРЕМЕЩЕНИЕ_П = 114; // Transfer

  // FACTURI FISCALE
  cDBID_DocType_СЧЕТ_ФАКТУРЫ_СФ = 112; // Facturi fiscale

  // OPERATIUNI DE CASA
  cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_ПКО = 116; // Dispozitie de incasare
  cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_РКО = 117; // Dispozitie de plata
  cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_НС = 1193; // Sold initial

  // OPERATIUNI BANCARE
  cDBID_DocType_БАНКОВСКИЕ_ОПЕРАЦИИ_ПДНС = 120; // Incasare bani in cont
  cDBID_DocType_БАНКОВСКИЕ_ОПЕРАЦИИ_ПДНСИК = 121;
  // Incasare bani in cont (din casa)
  cDBID_DocType_БАНКОВСКИЕ_ОПЕРАЦИИ_БППЛ = 119;
  // Ordine de plata bancare, Lei
  cDBID_DocType_БАНКОВСКИЕ_ОПЕРАЦИИ_БППВ = 1199;
  // Ordine de plata bancare, Valuta
  cDBID_DocType_БАНКОВСКИЕ_ОПЕРАЦИИ_КБП = 1660; // Comision plata bancara

  // ASAMBLARE
  cDBID_DocType_СБОРКА_ННС = 113; // Naryad de asamblare
  cDBID_DocType_СБОРКА_ННР = 1249; // Naryad de dezasamblare

  // COMISION
  cDBID_DocType_КОМИСИЯ_ЗТВК = 1506; // Inchidere marfa in comision
  cDBID_DocType_КОМИСИЯ_ПВБСК = 1757; // Primire in bilant din comision

  // SALARIU
  cDBID_DocType_ЗАРПЛАТА_ВЗ = 118; // Plata salariu
  cDBID_DocType_ЗАРПЛАТА_НЗ = 1514; // Calcul salariu

  // PUBLICITATE
  cDBID_DocType_РЕКЛАМА_РА = 1654; // Actiuni publicitare

  // INVENTARIERE
  cDBID_DocType_ИНВЕНТАРИЗАЦИЯ_АСТ = 129; // Act de casare marfa
  cDBID_DocType_ИНВЕНТАРИЗАЦИЯ_АОТ = 130; // Act de intrare marfa
  cDBID_DocType_ИНВЕНТАРИЗАЦИЯ_ПТ = 1414; // Reevaluare marfa
  cDBID_DocType_ИНВЕНТАРИЗАЦИЯ_АОПН = 1421; // Act de intrare pe nakladnie
  cDBID_DocType_ИНВЕНТАРИЗАЦИЯ_АСТПБ = 131;
  // Act de casare marfa pe contabilitate
  cDBID_DocType_ИНВЕНТАРИЗАЦИЯ_И = 1968; // Inventariere

  // Acte
  cDBID_DocType_Акты_РПД = 1959; // Registru transmitere documente
  cDBID_DocType_Акты_ADCAD = 1994; // Act de constatare a deficientelor

  // SERVICII DE TRANSPORT
  cDBID_DocType_ТРАНСПОРТНЫЕ_УСЛУГИ_ПЛ = 133; // Foaie de parcurs
  cDBID_DocType_ТРАНСПОРТНЫЕ_УСЛУГИ_ЗТ = 132; // Alimentare transport

  // CASA
  cDBID_DocType_КАССА_КП = 1206; // Casa personala
  cDBID_DocType_КАССА_КО = 1212; // Casa organizatiei
  cDBID_DocType_КАССА_КПВО = 1218; // Casa pe toate organizatiile
  cDBID_DocType_КАССА_ПД = 1427; // Transfer bani

  // WEB
  cDBID_DocType_WEB_WЗ = 134; // Comanda Web
  cDBID_DocType_WEB_ЗНФ = 1791; // Cerere de finantare

  // SERVICE
  cDBID_DocType_СЕРВИС_ЗНРS = 124; // Cereri de reparatie (S+)
  cDBID_DocType_СЕРВИС_ЗНГРN = 125; // Cereri de reparatie in garantie (N)
  cDBID_DocType_СЕРВИС_ЗТУП = 1945; // Inlocuire marfa la furnizor
  cDBID_DocType_СЕРВИС_НИ = 1280; // Incidente noi
  cDBID_DocType_СЕРВИС_ДС = 1396; // Dispecer service
  cDBID_DocType_СЕРВИС_ОИ = 1408; // Procesare incident
  cDBID_DocType_СЕРВИС_РИ = 1402; // Incidente rezolvate
  cDBID_DocType_СЕРВИС_ПВСВ = 126; // Transfer in CS, VP
  cDBID_DocType_СЕРВИС_ВИСП = 127; // Retur din CS, Furnizor
  cDBID_DocType_СЕРВИС_ВКТ_ИР = 128; // Retur client marfa din reparatie
  cDBID_DocType_СЕРВИС_ЗТВГ = 1487; // Inlocuire produs in garantie
  cDBID_DocType_СЕРВИС_ЗВБПГ = 1726; // Trecere in bilant pe garantie
  cDBID_DocType_СЕРВИС_ВыВТ = 1733; // Predare marfa temporara
  cDBID_DocType_СЕРВИС_ВоВТ = 1734; // Retur marfa temporara
  cDBID_DocType_СЕРВИС_ЭР = 1735; // Etape reparatie
  cDBID_DocType_СЕРВИС_ПВР = 1736; // Transfer in reparatie
  cDBID_DocType_СЕРВИС_ВВ_ПИСЦ = 1978; // Retur in / Primire din Centrul Service
  cDBID_DocType_СЕРВИС_П_ВТОК = 1987; // Primire / Retur marfa de la client

  // STOCURI
  cDBID_DocType_ОСТАТКИ_ОТ = 122; // Stocuri marfa
  cDBID_DocType_ОСТАТКИ_СК = 123; // Sold contraagenti

  // CONTRACTE
  cDBID_DocType_ДОГОВОРА_ДНП = 105; // Contract de vanzare
  cDBID_DocType_ДОГОВОРА_CF = 1470; // Contract franciza
  cDBID_DocType_ДОГОВОРА_CPS = 1464; // Contract prestari servicii

  // [1C Contabilitate]
  cDBID_DocType_1C_Бухгалтерия_ЭД = 1788; // Export documente

  // !!! Grupuri nealocate
  cDBID_DocType_Не_раставленные_группы_ТБХ = 1247; // Produs fara caracteristici
  cDBID_DocType_Не_раставленные_группы_НТ = 1248; // Produs lipsa

  cDBID_DocType_PriceList = 3202; // Lista de preturi

  // [Instrumente]
  cDBID_DocType_Инструменты_ФП = 1631; // Imprimanta fiscala
  cDBID_DocType_Инструменты_ПДДП = 1500; // Transfer bani catre alt utilizator
  cDBID_DocType_Инструменты_ТДС = 1499; // Transfer bani catre sine
  cDBID_DocType_Инструменты_ОВ = 1498; // Schimb valutar
  cDBID_DocType_Инструменты_ПО = 1497; // Recalcul stocuri
  cDBID_DocType_Инструменты_ПКВП = 1770; // Recalcul cantitate in transferuri
  cDBID_DocType_Инструменты_СЦИДФ = 1496; // Sincronizare preturi din alte firme
  cDBID_DocType_Инструменты_ИТИН = 1494; // Import produse din denumiri
  cDBID_DocType_Инструменты_БТ = 1632; // Marfuri bonus
  cDBID_DocType_Инструменты_ИОЗ = 1636; // Informatii despre salariu
  cDBID_DocType_Инструменты_ПП = 1643; // Planuri de vanzari
  cDBID_DocType_Инструменты_ИТИДФВТ = 1737;
  // Import marfa din alte firme in tabel
  cDBID_DocType_Инструменты_ТДАСН2П = 1767;
  // Produse pentru actiunea "Discount la a 2-a achizitie"
  cDBID_DocType_Инструменты_ПВЖД = 1769; // Cautare in registrul documentelor
  cDBID_DocType_Инструменты_ЖОР = 1773; // Registru absente angajati
  cDBID_DocType_Инструменты_ЖШИБР = 1915; // Registru amenzi si bonusuri angajati
  cDBID_DocType_Инструменты_УСБСП = 1924; // Aflare bonus propriu din vanzari
  cDBID_DocType_Инструменты_МА = 1935; // Monitor activitate
  cDBID_DocType_Инструменты_ДР = 1952; // Cheltuieli suplimentare
  cDBID_DocType_Инструменты_ПДНС = 1977; // Muta documentele pe azi

  // [Nomenclatoare]
  cDBID_DocType_Справочники_Б = 1352; // Banci
  cDBID_DocType_Справочники_В = 1349; // Valuta
  cDBID_DocType_Справочники_С = 1344; // Depozite
  cDBID_DocType_Справочники_Т = 1287; // Produse
  cDBID_DocType_Справочники_К = 1296; // Clienti
  cDBID_DocType_Справочники_А = 1357; // Analitica
  cDBID_DocType_Справочники_Сертификаты = 1367; // Certificate
  cDBID_DocType_Справочники_Д = 1362; // Procuri
  cDBID_DocType_Справочники_ШК = 1390; // Sabloane configuratii
  cDBID_DocType_Справочники_СС = 1339; // Nomenclator de sistem
  cDBID_DocType_Справочники_НДН = 1315; // Denumire pentru nakladnie
  cDBID_DocType_Справочники_ТК = 1938; // Tipuri de contracte

  // [Administrare]
  cDBID_DocType_Администрирование_ТД = 1385; // Tipuri de documente
  cDBID_DocType_Администрирование_БФ = 1686; // Blocare firme

  // [Website]
  cDBID_DocType_Website_WКТ = 1740; // Catalog Web marfa
  cDBID_DocType_Website_Ф = 1748; // Filtre
  cDBID_DocType_Website_ШОТ = 1749; // Sabloane descriere marfa
  cDBID_DocType_Website_КДФ = 1750; // Butoane pentru filtre
  cDBID_DocType_Website_М = 1751; // Magazine
  cDBID_DocType_Website_Д = 1752; // Livrare
  cDBID_DocType_Website_П = 1753; // Actiuni promo
  cDBID_DocType_Website_EР = 1754; // Trimiteri E-mail
  cDBID_DocType_Website_ББ = 1922; // Bannere mari
  cDBID_DocType_Website_ССНС = 1957; // Pagini statice pe site


  // ------------------------------------------------------------------------------------------------

  // constante din SYSS

  cSYSS_GOODS_SERIAL_TYPE_Среднезвешенный = 4401;
  cSYSS_GOODS_SERIAL_TYPE_Партийный_учет = 4402;
  cSYSS_GOODS_SERIAL_TYPE_Серийный_учет = 4403;

  cSYSS_GOODS_TYPE_Товар = 4201;
  cSYSS_GOODS_TYPE_Услуга = 4202;
  cSYSS_GOODS_TYPE_Комплект = 4203;
  cSYSS_GOODS_TYPE_Услуга_собственная = 4204;
  cSYSS_GOODS_TYPE_Дисконтная_карта = 4205;
  cSYSS_GOODS_TYPE_Топливо = 4206;
  cSYSS_GOODS_TYPE_Товары_для_сервиса = 4207;
  cSYSS_GOODS_TYPE_Фискальные_накладные = 4208;
  cSYSS_GOODS_TYPE_Транспортные_накладные = 4209;
  cSYSS_GOODS_TYPE_Доверености = 4210;
  cSYSS_GOODS_TYPE_Комплект_услуг = 4212;
  cSYSS_GOODS_TYPE_Delivery = 4217;
  cSYSS_GOODS_TYPE_Discount = 4219;


  // Customer Root values

implementation

end.
