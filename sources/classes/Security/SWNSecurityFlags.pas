unit SWNSecurityFlags;

interface

const

  // User groups
  cUserGroup_Администратор = 1;

  cUserGroup_ADM_Administrator_magazin = 2;
  cUserGroup_ADM_Contabilitate = 3;
  cUserGroup_ADM_Vinzatori_Online = 4;
  cUserGroup_ADM_Aprovizionari = 5;
  cUserGroup_ADM_Vinzator = 6;
  cUserGroup_ADM_Vinzatori_zona = 7;

  cUserGroup_Depozit_Hamali = 8;
  cUserGroup_Depozit_Manipulanti_marfa = 9;
  cUserGroup_Depozit_Gestionar_depozit = 10;

  cUserGroup_Franciza_Director = 11;
  cUserGroup_Franciza_Contabil = 12;
  cUserGroup_Franciza_Gestionar_marfa = 13;
  cUserGroup_Franciza_Vinzator = 14;

  cUserGroup_Service_Administrator = 15;
  cUserGroup_Service_Dispecer = 16;
  cUserGroup_Service_Receptie = 17;
  cUserGroup_Service_Producere = 18;
  cUserGroup_Service_Inginer = 19;
  cUserGroup_Service_Inginer_electronist = 20;
  cUserGroup_Logistica = 21;

  cUserGroup_Director = 24;


	//-------------------------------------------------------------------
	// Security flags from TS_ACC$RIGHTS. Extract date: 18.02.2011, 15:50
	//-------------------------------------------------------------------


	// DSE
	cSecurityFlag_DSE = 3143;
		// Documente de stricta evidenta
		cSecurityFlag_DSE_Documente_de_stricta_evidenta = 3144;
			cSecurityFlag_DSE_DDSE_Creare = 3145;		// Creare
			cSecurityFlag_DSE_DDSE_Modificare = 3146;		// Modificare
			cSecurityFlag_DSE_DDSE_Stergere = 3147;		// Stergere
			cSecurityFlag_DSE_DDSE_Vizionare = 3148;		// Vizionare

  // Precomanda produse
		cSecurityFlag_КОНФИГУРАЦИИ_Предзаказ_изделий = 3058;
			cSecurityFlag_КОНФИГУРАЦИИ_ПИ_Просмотр = 3059;		// Vizualizare
			cSecurityFlag_КОНФИГУРАЦИИ_ПИ_Создать = 3060;		// Creare
			cSecurityFlag_КОНФИГУРАЦИИ_ПИ_Изменить = 3061;		// Modifica
			cSecurityFlag_КОНФИГУРАЦИИ_ПИ_Удалить = 3062;		// Sterge
			cSecurityFlag_КОНФИГУРАЦИИ_ПИ_Запустить_в_производство = 3063;		// Lanseaza in productie
			cSecurityFlag_КОНФИГУРАЦИИ_ПИ_Отменить_производство = 3064;		// Anuleaza productia

		// Comanda pe firme
		cSecurityFlag_КОНФИГУРАЦИИ_Заказ_по_фирмам = 3065;
			cSecurityFlag_КОНФИГУРАЦИИ_ЗПФ_Просмотр = 3066;		// Vizualizare
			cSecurityFlag_КОНФИГУРАЦИИ_ЗПФ_Создать = 3067;		// Creare
			cSecurityFlag_КОНФИГУРАЦИИ_ЗПФ_Редактировать = 3068;		// Editare
			cSecurityFlag_КОНФИГУРАЦИИ_ЗПФ_Удалить = 3069;		// Sterge

	// PROIECTE
	cSecurityFlag_PROIECTE = 3131;
		// Documentatie de proiect
		cSecurityFlag_PROIECTE_Documentatie_de_proiect = 3132;
			cSecurityFlag_PROIECTE_DDP_Просмотр = 3133;		// Vizualizare
			cSecurityFlag_PROIECTE_DDP_Создать = 3134;		// Creare
			cSecurityFlag_PROIECTE_DDP_Редактировать = 3135;		// Editare
			cSecurityFlag_PROIECTE_DDP_Удалить = 3136;		// Sterge


	// CONFIGURATII
	cSecurityFlag_КОНФИГУРАЦИИ = 7;
		// Configurator
		cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор = 115;
			cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Просмотр = 1071;		// Vizualizare
			cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Создать = 1864;		// Creare
			cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Изменить = 1839;		// Modifica
			cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Удалить = 1072;		// Sterge
			cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Дополнительные_операции = 1870;		// Operatiuni suplimentare
			cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Видеть_колонку_цен = 1925;		// Vede coloana preturi
			cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Показывать_Контракт = 3060;		// Afiseaza "Contract"
			cSecurityFlag_OFERTE_Oferte_Calcul_TVA_0 = 3305;		// Calcul TVA 0

		// Tender
		cSecurityFlag_OFERTE_Tender = 3310;
			cSecurityFlag_OFERTE_Tender_Vizializare = 3311;		// Vizializare
			cSecurityFlag_OFERTE_Tender_Inregistrarea_noua = 3312;		// Inregistrarea noua
			cSecurityFlag_OFERTE_Tender_Modifica_inregistrarea = 3313;		// Modifica inregistrarea
			cSecurityFlag_OFERTE_Tender_Sterge_inregistrarea = 3314;		// Sterge inregistrarea


		// Alerta produse disponibile
		cSecurityFlag_OFERTE_Alerta_produse_disponibile = 3180;
			cSecurityFlag_OFERTE_APD_Просмотр = 3181;		// Vizualizare
			cSecurityFlag_OFERTE_APD_Создать = 3182;		// Creare
			cSecurityFlag_OFERTE_APD_Редактировать = 3183;		// Editare
			cSecurityFlag_OFERTE_APD_Удалить = 3184;		// Sterge
			cSecurityFlag_OFERTE_APD_Печать = 3185;		// Printare

		// Oportunitati
		cSecurityFlag_OFERTE_Oportunitati = 3195;
			cSecurityFlag_OFERTE_Oportunitati_Просмотр = 3196;		// Vizualizare
			cSecurityFlag_OFERTE_Oportunitati_Создать = 3197;		// Creare
			cSecurityFlag_OFERTE_Oportunitati_Редактировать = 3198;		// Editare
			cSecurityFlag_OFERTE_Oportunitati_Удалить = 3199;		// Sterge
			cSecurityFlag_OFERTE_Oportunitati_Печать = 3200;		// Printare

	// PRICE LIST
	cSecurityFlag_PRICE_LIST = 3201;
		// Lista de preturi
		cSecurityFlag_PL_Lista_de_preturi = 3202;
			cSecurityFlag_PL_LDP_Просмотр = 3203;		// Vizualizare
			cSecurityFlag_PL_LDP_Создать = 3204;		// Creare
			cSecurityFlag_PL_LDP_Редактировать = 3205;		// Editare
			cSecurityFlag_PL_LDP_Удалить = 3206;		// Sterge
			cSecurityFlag_PL_LDP_Печать = 3207;		// Printare

		// Analiza PriceList
		cSecurityFlag_PL_Analiza_PriceList = 3208;
			cSecurityFlag_PL_AP_Просмотр = 3209;		// Vizualizare
			cSecurityFlag_PL_AP_Создать = 3210;		// Creare
			cSecurityFlag_PL_AP_Редактировать = 3211;		// Editare
			cSecurityFlag_PL_AP_Удалить = 3212;		// Sterge
			cSecurityFlag_PL_AP_Печать = 3213;		// Printare


	// OPERATIUNI DE CASA
	cSecurityFlag_КАССОВЫЕ_ОПЕРАЦИИ = 8;
		// Dispozitie de incasare
		cSecurityFlag_КО_Приходный_кассовый_ордер = 116;
			cSecurityFlag_КО_ПКО_Просмотр = 1617;		// Vizualizare
			cSecurityFlag_КО_ПКО_Создать = 1614;		// Creare
			cSecurityFlag_КО_ПКО_Изменить = 1615;		// Modifica
			cSecurityFlag_КО_ПКО_Удалить = 1616;		// Sterge
			cSecurityFlag_КО_ПКО_Изменить_Через_бухгалтерию = 1789;		// Modifica "Prin contabilitate"
			cSecurityFlag_КО_ПКО_Закрыть_документ = 1891;		// Inchide documentul
			cSecurityFlag_КО_ПКО_Открыть_документ = 1892;		// Deschide documentul
			cSecurityFlag_КО_ПКО_Показывать_Контракт = 3043;		// Afiseaza "Contract"
			cSecurityFlag_КО_ПКО_Видеть_и_чужие_документы = 3070;		// Vede doar documentele proprii

		// Dispozitie de plata
		cSecurityFlag_КО_Расходный_кассовый_ордер = 117;
			cSecurityFlag_КО_РКО_Просмотр = 1820;		// Vizualizare
			cSecurityFlag_КО_РКО_Создать = 1865;		// Creare
			cSecurityFlag_КО_РКО_Изменить = 1840;		// Modifica
			cSecurityFlag_КО_РКО_Удалить = 1798;		// Sterge
			cSecurityFlag_КО_РКО_Закрыть_документ = 1889;		// Inchide documentul
			cSecurityFlag_КО_РКО_Открыть_документ = 1890;		// Deschide documentul
			cSecurityFlag_КО_РКО_Показывать_Контракт = 3044;		// Afiseaza "Contract"
			cSecurityFlag_КО_РКО_Видеть_и_чужие_документы = 3071;		// Vede doar documentele proprii

		// Sold initial
		cSecurityFlag_КО_Начальное_сальдо = 1193;
			cSecurityFlag_КО_НС_Просмотр = 1821;		// Vizualizare
			cSecurityFlag_КО_НС_Создать = 1866;		// Creare
			cSecurityFlag_КО_НС_Изменить = 1841;		// Modifica
			cSecurityFlag_КО_НС_Удалить = 1799;		// Sterge

		// Corectare casa
		cSecurityFlag_КО_Корректировка_кассы = 2003;
			cSecurityFlag_КО_КК_Просмотр = 2004;		// Vizualizare
			cSecurityFlag_КО_КК_Создать = 2005;		// Creare
			cSecurityFlag_КО_КК_Изменить = 2006;		// Modifica
			cSecurityFlag_КО_КК_Удалить = 2007;		// Sterge
			cSecurityFlag_КО_КК_Закрыть_документ = 2008;		// Inchide documentul
			cSecurityFlag_КО_КК_Открыть_документ = 2009;		// Deschide documentul

		// Ramburs
		cSecurityFlag_RC_Ramburs = 3288;
			cSecurityFlag_RC_Ramburs_View = 3289;		// View
			cSecurityFlag_RC_Ramburs_Create = 3290;		// Create
			cSecurityFlag_RC_Ramburs_Edit = 3291;		// Edit
			cSecurityFlag_RC_Ramburs_Delete = 3292;		// Delete
			cSecurityFlag_RC_Ramburs_Transfer_in_casa_intreprinderii = 3293;		// Transfer in casa intreprinderii


	// OPERATIUNI BANCARE
	cSecurityFlag_БАНКОВСКИЕ_ОПЕРАЦИИ = 9;
		// Incasare bani in cont
		cSecurityFlag_БО_Приход_денег_на_счет = 120;
			cSecurityFlag_БО_ПДНС_Просмотр = 1822;		// Vizualizare
			cSecurityFlag_БО_ПДНС_Создать = 1867;		// Creare
			cSecurityFlag_БО_ПДНС_Изменить = 1842;		// Modifica
			cSecurityFlag_БО_ПДНС_Удалить = 1800;		// Sterge
			cSecurityFlag_БО_ПДНС_Закрыть_документ = 1899;		// Inchide documentul
			cSecurityFlag_БО_ПДНС_Открыть_документ = 1900;		// Deschide documentul
			cSecurityFlag_БО_ПДНС_Показывать_Контракт = 3055;		// Afiseaza "Contract"

		// Incasare bani in cont (din casa)
		cSecurityFlag_БО_Приход_денег_на_счет_из_кассы = 121;
			cSecurityFlag_БО_ПДНСИК_Просмотр = 1823;		// Vizualizare
			cSecurityFlag_БО_ПДНСИК_Создать = 1868;		// Creare
			cSecurityFlag_БО_ПДНСИК_Изменить = 1843;		// Modifica
			cSecurityFlag_БО_ПДНСИК_Удалить = 1801;		// Sterge
			cSecurityFlag_БО_ПДНСИК_Закрыть_документ = 1901;		// Inchide documentul
			cSecurityFlag_БО_ПДНСИК_Открыть_документ = 1902;		// Deschide documentul
			cSecurityFlag_БО_ПДНСИК_Показывать_Контракт = 3056;		// Afiseaza "Contract"

		// Ordine de plata bancare, Lei
		cSecurityFlag_БО_Банковские_платежные_поручения_Леи = 119;
			cSecurityFlag_БО_БППЛ_Просмотр = 1667;		// Vizualizare
			cSecurityFlag_БО_БППЛ_Создать = 1668;		// Creare
			cSecurityFlag_БО_БППЛ_Изменить = 1669;		// Modifica
			cSecurityFlag_БО_БППЛ_Удалить = 1670;		// Sterge
			cSecurityFlag_БО_БППЛ_Расчитать_комиссион = 1666;		// Calculeaza comisionul
			cSecurityFlag_БО_БППЛ_Закрыть_документ = 1903;		// Inchide documentul
			cSecurityFlag_БО_БППЛ_Открыть_документ = 1904;		// Deschide documentul
			cSecurityFlag_БО_БППЛ_Показывать_Контракт = 3054;		// Afiseaza "Contract"

		// Ordine de plata bancare, Valuta
		cSecurityFlag_БО_Банковские_платежные_поручения_Валюта = 1199;
			cSecurityFlag_БО_БППВ_Просмотр = 1824;		// Vizualizare
			cSecurityFlag_БО_БППВ_Создать = 1869;		// Creare
			cSecurityFlag_БО_БППВ_Изменить = 1844;		// Modifica
			cSecurityFlag_БО_БППВ_Удалить = 1802;		// Sterge
			cSecurityFlag_БО_БППВ_Закрыть_документ = 1910;		// Inchide documentul
			cSecurityFlag_БО_БППВ_Открыть_документ = 1911;		// Deschide documentul
			cSecurityFlag_БО_БППВ_Показывать_Контракт = 3057;		// Afiseaza "Contract"

		// Comision plata bancara
		cSecurityFlag_БО_Комисион_банковского_платежа = 1660;
			cSecurityFlag_БО_КБП_Просмотр = 1661;		// Vizualizare
			cSecurityFlag_БО_КБП_Создать = 1662;		// Creare
			cSecurityFlag_БО_КБП_Изменить = 1663;		// Modifica
			cSecurityFlag_БО_КБП_Удалить = 1664;		// Sterge
			cSecurityFlag_БО_КБП_Закрыть_документ = 1908;		// Inchide documentul
			cSecurityFlag_БО_КБП_Открыть_документ = 1909;		// Deschide documentul

		// Sold bani in cont
		cSecurityFlag_БО_Остатки_денег_на_счету = 3036;
			cSecurityFlag_БО_ОДНС_Просмотр = 3037;		// Vizualizare
			cSecurityFlag_БО_ОДНС_Создать = 3038;		// Creare
			cSecurityFlag_БО_ОДНС_Редактировать = 3039;		// Editare
			cSecurityFlag_БО_ОДНС_Удалить = 3040;		// Sterge

		// Transfer intre conturi
		cSecurityFlag_RB_Transfer_intre_conturi = 3088;
			cSecurityFlag_RB_TIC_Просмотр = 3089;		// Vizualizare
			cSecurityFlag_RB_TIC_Создать = 3090;		// Creare
			cSecurityFlag_RB_TIC_Изменить = 3091;		// Modifica
			cSecurityFlag_RB_TIC_Удалить = 3092;		// Sterge

		// Registru comun bancar
		cSecurityFlag_RB_Registru_comun_bancar = 3339;

		// Genereaza calculul salariului
		cSecurityFlag_INSTRUMENTE_Genereaza_calculul_salariului = 3340;

		// Distribuire ramburs
		cSecurityFlag_RB_Distribuire_ramburs = 3328;
			cSecurityFlag_RB_DR_Vizializare = 3329;		// Vizializare
			cSecurityFlag_RB_DR_Inregistrarea_noua = 3330;		// Inregistrarea noua
			cSecurityFlag_RB_DR_Modifica_inregistrarea = 3331;		// Modifica inregistrarea
			cSecurityFlag_RB_DR_Sterge_inregistrarea = 3332;		// Sterge inregistrarea

		// ClientBank
		cSecurityFlag_RB_ClientBank = 3333;
			cSecurityFlag_RB_ClientBank_Vizializare = 3334;		// Vizializare
			cSecurityFlag_RB_ClientBank_Inregistrarea_noua = 3335;		// Inregistrarea noua
			cSecurityFlag_RB_ClientBank_Modifica_inregistrarea = 3336;		// Modifica inregistrarea
			cSecurityFlag_RB_ClientBank_Sterge_inregistrarea = 3337;		// Sterge inregistrarea
		// Client bank ECB
		cSecurityFlag_RB_Client_bank_ECB = 3346;

	// Cerere de plata
		cSecurityFlag_RB_Cerere_de_plata = 3363;
			cSecurityFlag_RB_CDP_Vizializare = 3364;		// Vizializare
			cSecurityFlag_RB_CDP_Inregistrarea_noua = 3365;		// Inregistrarea noua
			cSecurityFlag_RB_CDP_Modifica_inregistrarea = 3366;		// Modifica inregistrarea
			cSecurityFlag_RB_CDP_Sterge_inregistrarea = 3367;		// Sterge inregistrarea
	// FACTURI
	cSecurityFlag_СЧЕТА = 1;
		// Facturi de plata
		cSecurityFlag_СЧЕТА_Счета_на_оплату = 101;
			cSecurityFlag_СЧЕТА_СНО_Просмотр = 1001;		// Vizualizare
			cSecurityFlag_СЧЕТА_СНО_Создать = 1002;		// Creare
			cSecurityFlag_СЧЕТА_СНО_Изменить = 1003;		// Modifica
			cSecurityFlag_СЧЕТА_СНО_Удалить = 1803;		// Sterge
			cSecurityFlag_СЧЕТА_СНО_Изменить_плательщика = 1502;		// Modifica platitorul
			cSecurityFlag_СЧЕТА_СНО_Показывать_Контракт = 3062;		// Afiseaza "Contract"

		// Facturi de intrare
		cSecurityFlag_СЧЕТА_Входные_счета = 1455;
			cSecurityFlag_СЧЕТА_ВС_Просмотр = 1825;		// Vizualizare
			cSecurityFlag_СЧЕТА_ВС_Создать = 1871;		// Creare
			cSecurityFlag_СЧЕТА_ВС_Изменить = 1845;		// Modifica
			cSecurityFlag_СЧЕТА_ВС_Удалить = 1804;		// Sterge
			cSecurityFlag_PROFORME_CDA_Export_XML = 3249;		// Export XML

		// Aprovizionari
		cSecurityFlag_СЧЕТА_Поставки = 103;
			cSecurityFlag_СЧЕТА_Поставки_Просмотр = 1826;		// Vizualizare
			cSecurityFlag_СЧЕТА_Поставки_Изменить = 1846;		// Modifica
			cSecurityFlag_СЧЕТА_Поставки_Удалить = 1805;		// Sterge

		// Comenzi preliminare
		cSecurityFlag_СЧЕТА_Предварительные_заказы = 104;
			cSecurityFlag_СЧЕТА_ПЗ_Просмотр = 1827;		// Vizualizare
			cSecurityFlag_СЧЕТА_ПЗ_Создать = 3004;		// Creare
			cSecurityFlag_СЧЕТА_ПЗ_Изменить = 1847;		// Modifica
			cSecurityFlag_СЧЕТА_ПЗ_Удалить = 1806;		// Sterge
			cSecurityFlag_СЧЕТА_ПЗ_Утвердить = 3002;		// Aproba
			cSecurityFlag_СЧЕТА_ПЗ_Удалить_товар = 3003;		// Sterge marfa

		// Liste de preturi
		cSecurityFlag_PROFORME_Liste_de_preturi = 3168;
			cSecurityFlag_PROFORME_LDP_Document_nou = 3169;		// Document nou
			cSecurityFlag_PROFORME_LDP_Modifica_document = 3170;		// Modifica document
			cSecurityFlag_PROFORME_LDP_Sterge_document = 3171;		// Sterge document
			cSecurityFlag_PROFORME_LDP_Importa_lista_de_preturi = 3172;		// Importa lista de preturi
			cSecurityFlag_PROFORME_LDP_Sterge_toata_lista_de_preturi = 3173;		// Sterge toata lista de preturi
			cSecurityFlag_PROFORME_LDP_Produse_noi = 3174;		// Produse noi
			cSecurityFlag_PROFORME_LDP_Produse_vechi = 3175;		// Produse vechi
			cSecurityFlag_PROFORME_LDP_Produse_cu_preturi_micsorate = 3176;		// Produse cu preturi micsorate
			cSecurityFlag_PROFORME_LDP_Produse_cu_preturi_majorate = 3177;		// Produse cu preturi majorate



	// NAKLADNIE
	cSecurityFlag_НАКЛАДНЫЕ = 3;
		// Intrare marfa (Evidenta operativa)
		cSecurityFlag_НАКЛАДНЫЕ_Приход_товара = 106;
			cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Просмотр = 1024;		// Vizualizare
			cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Создать = 1025;		// Creare
			cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Изменить = 1026;		// Modifica
			cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Удалить = 1027;		// Sterge
			cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Ввести_серийные_номера_и_партии = 1029;		// Introdu numere seriale si partizi
			cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Правка_серийных_номеров_и_партий = 1030;		// Corectare numere seriale si partizi
			cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Редактировать_старые = 1652;		// Editeaza cele vechi
			cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Товары_Просмотр_цен = 1683;		// Produse - Vizualizare preturi
			cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Товары_Редактирование_цен = 1682;		// Produse - Editare preturi
			cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Товары_Редактировать_колво = 1684;		// Produse - Editare cantitate
 			cSecurityFlag_FACTURI_PDB_Stergerea_produselor = 3156;		// Stergerea produselor
			cSecurityFlag_VINZARE_PDB_Deschide_documentul = 3178;		// Deschide documentul
			cSecurityFlag_VINZARE_PDB_Inchide_documentul = 3179;		// Inchide documentul
			cSecurityFlag_VINZARE_PDB_Creare_document_Vanzare_catre_Prime_Store_SRL = 3403;		// Creare document Vanzare catre Prime Store SRL

		// Nakladnaia de iesire (Evidenta operativa)
		cSecurityFlag_НАКЛАДНЫЕ_Расходная_накладная = 107;
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Просмотр = 1629;		// Vizualizare
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Создать = 1872;		// Creare
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Изменить = 1848;		// Modifica
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Удалить = 1797;		// Sterge
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Отменить_отгрузку = 1626;		// Anuleaza expedierea
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Расчет_рентабильности = 1630;		// Calcul rentabilitate
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_FLG_Провести_по_бухгалтерии = 1689;		// FLG - Confirma pe contabilitate
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Видеть_колонку_цен = 1926;		// Vede coloana preturi
 			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Изменить_цены_по_колонке_клиента = 1993;		// Modifica preturile pe coloana clientului
 			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Изменить_создателя_в_Журнале_Товаров = 2014;		// Modifica creatorul in Registrul Marfurilor
      cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Создать_чек = 2015;		// Creare bon
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Обновить_остатки = 2044;		// Actualizeaza stocurile
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Акции = 2045;		// Actiuni
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Цена_клиента = 2046;		// Pretul clientului
			cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Показывать_Контракт = 3061;		// Afiseaza "Contract"
      cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Ручное_изменение_цен = 3095;		// Modificare manuala preturi
			cSecurityFlag_VINZARE_Rezervare_Documentul_nu_participa_la_calculul_salariului = 3158;		// Documentul nu participa la calculul salariului
			cSecurityFlag_VINZARE_Rezervare_Excluderea_numerilor_de_serie_sau_partida = 3194;		// Excluderea numerilor de serie sau partida
			cSecurityFlag_VINZARE_R_V_Ordin_de_incasare_bancar = 3306;		// Ordin de incasare bancar
			cSecurityFlag_VINZARE_R_V_Modifica_utilizatorul_in_document = 3341;		// Modifica utilizatorul in document
			cSecurityFlag_VINZARE_R_V_Create_document_Rezervari_anulate = 3407;		// Create document "Rezervari anulate"

		// Intrare marfa pe nakladnie
		cSecurityFlag_НАКЛАДНЫЕ_Приход_товара_по_накладным = 109;
			cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Просмотр = 1849;		// Vizualizare
			cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Создать = 1873;		// Creare
			cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Изменить = 1850;		// Modifica
			cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Удалить = 1807;		// Sterge
			cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Создать_счет_фактуры = 1779;		// Creare facturi fiscale
			cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Изменить_счет_фактуры = 1780;		// Modifica facturile fiscale
			cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Удалить_счет_фактуры = 1781;		// Sterge facturile fiscale


// Retur marfa
		cSecurityFlag_НАКЛАДНЫЕ_Возврат_товара = 110;
			cSecurityFlag_НАКЛАДНЫЕ_ВТ_Просмотр = 1828;		// Vizualizare
			cSecurityFlag_НАКЛАДНЫЕ_ВТ_Новый = 3045;		// Nou
			cSecurityFlag_НАКЛАДНЫЕ_ВТ_Изменить = 1851;		// Modifica
			cSecurityFlag_НАКЛАДНЫЕ_ВТ_Удалить = 1808;		// Sterge
			cSecurityFlag_НАКЛАДНЫЕ_ВТОК1_Показывать_Контракт = 3042;		// Afiseaza "Contract"

		// Rezerva
		cSecurityFlag_НАКЛАДНЫЕ_Резерв = 108;
			cSecurityFlag_НАКЛАДНЫЕ_Резерв_Просмотр = 1829;		// Vizualizare
			cSecurityFlag_НАКЛАДНЫЕ_Резерв_Изменить = 1852;		// Modifica
			cSecurityFlag_НАКЛАДНЫЕ_Резерв_Удалить = 1809;		// Sterge

		// Livrari
		cSecurityFlag_VINZARE_Livrari = 3232;
			cSecurityFlag_VINZARE_Livrari_Просмотр = 3233;		// Vizualizare
			cSecurityFlag_VINZARE_Livrari_Создать = 3234;		// Creare
			cSecurityFlag_VINZARE_Livrari_Редактировать = 3235;		// Editare
			cSecurityFlag_VINZARE_Livrari_Удалить = 3236;		// Sterge
			cSecurityFlag_VINZARE_Livrari_Печать = 3237;		// Printare

		// Rezervari anulate
		cSecurityFlag_VINZARE_Rezervari_anulate = 3297;
			cSecurityFlag_VINZARE_RA_View = 3298;		// View
			cSecurityFlag_VINZARE_RA_Modificare = 3299;		// Modificare
			cSecurityFlag_VINZARE_RA_Sterge_documentul = 3402;		// Sterge documentul

		// Bonusuri
		cSecurityFlag_VINZARE_Bonusuri = 3300;
			cSecurityFlag_VINZARE_Bonusuri_Vizializare = 3301;		// Vizializare
			cSecurityFlag_VINZARE_Bonusuri_Inregistrarea_noua = 3302;		// Inregistrarea noua
			cSecurityFlag_VINZARE_Bonusuri_Modifica_inregistrarea = 3303;		// Modifica inregistrarea
			cSecurityFlag_VINZARE_Bonusuri_Sterge_inregistrarea = 3304;		// Sterge inregistrarea

		// Vanazare prin partener
		cSecurityFlag_VINZARE_Vanazare_prin_partener = 3425;
			cSecurityFlag_VINZARE_VPP_Document_nou = 3426;		// Document nou
			cSecurityFlag_VINZARE_VPP_Modifica_document = 3427;		// Modifica document
			cSecurityFlag_VINZARE_VPP_Sterge_document = 3428;		// Sterge document
			cSecurityFlag_VINZARE_VPP_Pozitie_noua = 3429;		// Pozitie noua
			cSecurityFlag_VINZARE_VPP_Modifica_pozitia = 3430;		// Modifica pozitia
			cSecurityFlag_VINZARE_VPP_Sterge_produs = 3431;		// Sterge produs

		// POS vinzare
		cSecurityFlag_VINZARE_POS_vinzare = 3447;
			cSecurityFlag_VINZARE_PV_Adauga_document = 3448;		// Adauga document
			cSecurityFlag_VINZARE_PV_Modifica_document = 3449;		// Modifica document
			cSecurityFlag_VINZARE_PV_Sterge_Document = 3450;		// Sterge Document

	// TRANSFER
	cSecurityFlag_ПЕРЕМЕЩЕНИЕ = 6;
		// Transfer
		cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение = 114;
			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Просмотр = 1623;		// Vizualizare
			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Создать = 1618;		// Creare
			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Редактировать = 1619;		// Editare
			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Редактирование_после_30_минут = 1613;		// Editare dupa 30 minute
			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Удалить = 1620;		// Sterge
			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Отправить_товар = 1621;		// Trimite marfa
			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Принять_товар = 1622;		// Primeste marfa
			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Выписать_счет_фактуры = 1624;		// Emite facturile fiscale
			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Работа_с_товарами = 1625;		// Lucrul cu marfa
			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Видеть_колонку_цен = 1927;		// Vede coloana preturi
      cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Отменить_отправку_перемещения = 2011;		// Anuleaza trimiterea transferului
 			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Импорт = 3115;		// Import
			cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Импорт_серийных_номеров = 3116;		// Import numere seriale


	// ASAMBLARE
	cSecurityFlag_СБОРКА = 5;
		// Naryad de asamblare
		cSecurityFlag_СБОРКА_Наряд_на_сборку = 113;
			cSecurityFlag_СБОРКА_ННС_Просмотр = 1061;		// Vizualizare
			cSecurityFlag_СБОРКА_ННС_Создать = 1062;		// Creare
			cSecurityFlag_СБОРКА_ННС_Редактировать = 1063;		// Editare
			cSecurityFlag_СБОРКА_ННС_Удалить = 1064;		// Sterge
			cSecurityFlag_СБОРКА_ННС_Комплекты_собраны = 1610;		// Seturile sunt asamblate
			cSecurityFlag_СБОРКА_ННС_Открыть_закрытую_сборку = 1501;		// Deschide asamblarea inchisa

		// Naryad de dezasamblare
		cSecurityFlag_СБОРКА_Наряд_на_разборку = 1249;
			cSecurityFlag_СБОРКА_ННР_Просмотр = 1830;		// Vizualizare
			cSecurityFlag_СБОРКА_ННР_Изменить = 1853;		// Modifica
			cSecurityFlag_СБОРКА_ННР_Удалить = 1810;		// Sterge
			cSecurityFlag_СБОРКА_ННР_Закрыть = 3138;		// Inchide
			cSecurityFlag_СБОРКА_ННР_Открыть = 3139;		// Deschide



	// FACTURI FISCALE
	cSecurityFlag_СЧЕТ_ФАКТУРЫ = 4;
		// Facturi fiscale
		cSecurityFlag_СФ_Счет_фактуры = 112;
			cSecurityFlag_СФ_СФ_Просмотр = 1671;		// Vizualizare
			cSecurityFlag_СФ_СФ_Создать = 1672;		// Creare
			cSecurityFlag_СФ_СФ_Изменить = 1673;		// Modifica
			cSecurityFlag_СФ_СФ_Удалить = 1674;		// Sterge
			cSecurityFlag_СФ_СФ_Закрыть = 1898;		// Inchide
			cSecurityFlag_СФ_СФ_Открыть = 1756;		// Deschide
			cSecurityFlag_СФ_СФ_Аннулировать_счет_фактуры = 1676;		// Anuleaza factura fiscala
			cSecurityFlag_СФ_СФ_Удалить_счет_фактуры = 1677;		// Sterge factura fiscala
			cSecurityFlag_СФ_СФ_Аннулировать_чек = 1678;		// Anuleaza bonul
			cSecurityFlag_СФ_СФ_Удалить_чек = 1679;		// Sterge bonul
			cSecurityFlag_СФ_СФ_Видеть_колонку_цен = 1928;		// Vede coloana preturi
			cSecurityFlag_СФ_СФ_Корректровка_кассы = 2010;		// Corectare casa
			cSecurityFlag_СФ_СФ_Показывать_Контракт = 3058;		// Afiseaza "Contract"
			cSecurityFlag_СФ_СФ_Комплектация_из_сборки = 3063;		// Configurare set din asamblare
			cSecurityFlag_СФ_СФ_Принести_товары_из_других_документов = 3064;		// Adu marfa din alte documente
         cSecurityFlag_СФ_СФ_Принести_товары_из_расхода_мультиСборка = 3065;		// Adu marfa din iesire multi-Asamblare (Gardecor)
         cSecurityFlag_СФ_СФ_Принудительное_закрытие_фактуры = 3103;		// Inchidere fortata factura
			cSecurityFlag_DDSE_FF_E_Modifica_Tip_Factura = 3222;		// Modifica "Tip Factura"
			cSecurityFlag_FACTURI_FF_E_Создание_чеков = 3282;		// Creare bonuri
			cSecurityFlag_FACTURI_FF_E_Dispozitie_de_incasare_bancara = 3284;		// Dispozitie de incasare bancara
			cSecurityFlag_FACTURI_FF_E_Dispozitie_de_incasare_bancara_cu_ramburs = 3285;		// Dispozitie de incasare bancara cu ramburs
			cSecurityFlag_FACTURI_FF_E_Dispozitie_de_plata_bancara = 3286;		// Dispozitie de plata bancara
			cSecurityFlag_FACTURI_FF_E_Anulare_FLG_Export = 3287;		// Anulare FLG_Export

  // Nakladnie marfa transport
		cSecurityFlag_СФ_Товаро_транспортные_накладные = 2016;
			cSecurityFlag_СФ_ТТН_Просмотр_документа = 2017;		// Vizualizare document
			cSecurityFlag_СФ_ТТН_Создать_документ = 2018;		// Creare document
			cSecurityFlag_СФ_ТТН_Изменить_документ = 2019;		// Modifica documentul
			cSecurityFlag_СФ_ТТН_Удалить_документ = 2020;		// Sterge documentul
			cSecurityFlag_СФ_ТТН_Закрыть_документ = 2021;		// Inchide documentul
			cSecurityFlag_СФ_ТТН_Анулировать_ТТН = 2022;		// Anuleaza TTN
			cSecurityFlag_СФ_ТТН_Удалить_регистрацию_ТТН = 2023;		// Sterge inregistrarea TTN
			cSecurityFlag_СФ_ТТН_Открыть_документ = 2024;		// Deschide documentul


	// COMISION
	cSecurityFlag_КОМИСИЯ = 1505;
		// Inchidere marfa in comision
		cSecurityFlag_КОМИСИЯ_Закрытие_товара_в_комисию = 1506;
			cSecurityFlag_КОМИСИЯ_ЗТВК_Создать = 1507;		// Creare
			cSecurityFlag_КОМИСИЯ_ЗТВК_Редактировать = 1508;		// Editare
			cSecurityFlag_КОМИСИЯ_ЗТВК_Удалить = 1509;		// Sterge
			cSecurityFlag_КОМИСИЯ_ЗТВК_Закрыть_документ = 1510;		// Inchide documentul
			cSecurityFlag_КОМИСИЯ_ЗТВК_Открыть_закрытый_документ = 1511;		// Deschide documentul inchis
			cSecurityFlag_КОМИСИЯ_ЗТВК_Просмотр_документа = 1512;		// Vizualizare document

		// Primire in bilant din comision
		cSecurityFlag_КОМИСИЯ_Принятие_в_баланс_с_комисии = 1757;
			cSecurityFlag_КОМИСИЯ_ПВБСК_Просмотр = 1758;		// Vizualizare
			cSecurityFlag_КОМИСИЯ_ПВБСК_Создать = 1759;		// Creare
			cSecurityFlag_КОМИСИЯ_ПВБСК_Изменить = 1760;		// Modifica
			cSecurityFlag_КОМИСИЯ_ПВБСК_Удалить = 1761;		// Sterge
			cSecurityFlag_КОМИСИЯ_ПВБСК_Закрыть_документ = 1920;		// Inchide documentul
			cSecurityFlag_КОМИСИЯ_ПВБСК_Открыть_документ = 1921;		// Deschide documentul


	// SALARIU
	cSecurityFlag_ЗАРПЛАТА = 1513;
		// Salariu
		cSecurityFlag_ЗАРПЛАТА_Выдача_зарплата = 118;
			cSecurityFlag_ЗАРПЛАТА_ВЗ_Просмотр = 1639;		// Vizualizare
			cSecurityFlag_ЗАРПЛАТА_ВЗ_Создавать = 1640;		// Creeaza
			cSecurityFlag_ЗАРПЛАТА_ВЗ_Изменить = 1641;		// Modifica
			cSecurityFlag_ЗАРПЛАТА_ВЗ_Удалить = 1642;		// Sterge
			cSecurityFlag_ЗАРПЛАТА_ВЗ_Закрыть = 1893;		// Inchide
			cSecurityFlag_ЗАРПЛАТА_ВЗ_Открыть = 1894;		// Deschide

		// Calcul salariu
		cSecurityFlag_ЗАРПЛАТА_Расчет_зарплаты = 1514;
			cSecurityFlag_ЗАРПЛАТА_РЗ_Просмотр = 1515;		// Vizualizare
			cSecurityFlag_ЗАРПЛАТА_РЗ_Создать = 1516;		// Creare
			cSecurityFlag_ЗАРПЛАТА_РЗ_Редактировать = 1517;		// Editare
			cSecurityFlag_ЗАРПЛАТА_РЗ_Удалить = 1518;		// Sterge
			cSecurityFlag_ЗАРПЛАТА_РЗ_Закрыть_документ = 1520;		// Inchide documentul
			cSecurityFlag_ЗАРПЛАТА_РЗ_Открыть_закрытый_документ = 1521;		// Deschide documentul inchis
			cSecurityFlag_ЗАРПЛАТА_РЗ_Изменить_данные_контрагента = 1525;		// Modifica datele contraagentului
			cSecurityFlag_ЗАРПЛАТА_РЗ_Заполнить_список_контрагентами = 1522;		// Completeaza lista cu contraagenti
			cSecurityFlag_ЗАРПЛАТА_РЗ_Добавить_контрагента = 1523;		// Adauga contraagent
			cSecurityFlag_ЗАРПЛАТА_РЗ_Удалить_контрагента = 1524;		// Sterge contraagentul
			cSecurityFlag_ЗАРПЛАТА_РЗ_Расчитать_зарплату = 1681;		// Calculeaza salariul

		// Calculul salariului nou
		cSecurityFlag_SALARIU_Calculul_salariului_nou = 3226;
			cSecurityFlag_SALARIU_CSN_Просмотр = 3227;		// Vizualizare
			cSecurityFlag_SALARIU_CSN_Создать = 3228;		// Creare
			cSecurityFlag_SALARIU_CSN_Редактировать = 3229;		// Editare
			cSecurityFlag_SALARIU_CSN_Удалить = 3230;		// Sterge
			cSecurityFlag_SALARIU_CSN_Печать = 3231;		// Printare

	// PUBLICITATE
	cSecurityFlag_РЕКЛАМА = 1653;
		// Actiuni de marketing
		cSecurityFlag_РЕКЛАМА_Маркетинговые_акции = 1654;
			cSecurityFlag_РЕКЛАМА_МА_Просмотр = 3066;		// Vizualizare
			cSecurityFlag_РЕКЛАМА_МА_Создать = 3067;		// Creare
			cSecurityFlag_РЕКЛАМА_МА_Изменить = 3068;		// Modifica
			cSecurityFlag_РЕКЛАМА_МА_Удалить = 3069;		// Sterge

		// Matrici
		cSecurityFlag_MARKETING_Matrici = 3112;
			cSecurityFlag_MARKETING_Matrici_Товар = 3113;		// Produs
			cSecurityFlag_MARKETING_Matrici_Поставщики = 3114;		// Furnizori

		// Lichidare de stoc
		cSecurityFlag_MARKETING_Lichidare_de_stoc = 3187;

		// Apeluri
		cSecurityFlag_MARKETING_Apeluri = 3251;
			cSecurityFlag_MARKETING_Apeluri_Vizializare = 3252;		// Vizializare
			cSecurityFlag_MARKETING_Apeluri_Inregistrarea_noua = 3253;		// Inregistrarea noua
			cSecurityFlag_MARKETING_Apeluri_Modifica_inregistrarea = 3254;		// Modifica inregistrarea
			cSecurityFlag_MARKETING_Apeluri_Sterge_inregistrarea = 3255;		// Sterge inregistrarea


		// Promo coduri
		cSecurityFlag_MARKETING_Promo_coduri = 3260;
			cSecurityFlag_MARKETING_PC_Vizualizare = 3261;		// Vizualizare
			cSecurityFlag_MARKETING_PC_Modificare = 3262;		// Modificare
			cSecurityFlag_MARKETING_PC_Stergere = 3263;		// Stergere

		// Cashback
		cSecurityFlag_MARKETING_Cashback = 3264;
			cSecurityFlag_MARKETING_Cashback_Vizializare = 3265;		// Vizializare
			cSecurityFlag_MARKETING_Cashback_Inregistrarea_noua = 3266;		// Inregistrarea noua
			cSecurityFlag_MARKETING_Cashback_Modifica_inregistrarea = 3267;		// Modifica inregistrarea
			cSecurityFlag_MARKETING_Cashback_Sterge_inregistrarea = 3268;		// Sterge inregistrarea

		// Promotii furnizori
		cSecurityFlag_MARKETING_Promotii_furnizori = 3274;
			cSecurityFlag_MARKETING_PF_Vizializare = 3275;		// Vizializare
			cSecurityFlag_MARKETING_PF_Inregistrarea_noua = 3276;		// Inregistrarea noua
			cSecurityFlag_MARKETING_PF_Modifica_inregistrarea = 3277;		// Modifica inregistrarea
			cSecurityFlag_MARKETING_PF_Sterge_inregistrarea = 3278;		// Sterge inregistrarea

		// Vouchere cadou
		cSecurityFlag_MARKETING_Vouchere_cadou = 3317;
			cSecurityFlag_MARKETING_VC_Vizializare = 3318;		// Vizializare
			cSecurityFlag_MARKETING_VC_Inregistrarea_noua = 3319;		// Inregistrarea noua
			cSecurityFlag_MARKETING_VC_Modifica_inregistrarea = 3320;		// Modifica inregistrarea
			cSecurityFlag_MARKETING_VC_Sterge_inregistrarea = 3321;		// Sterge inregistrarea



	// INVENTARIERE
	cSecurityFlag_ИНВЕНТАРИЗАЦИЯ = 12;
		// Act de casare marfa
		cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Акт_списания_товара = 129;
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Просмотр = 1831;		// Vizualizare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Создать = 1907;		// Creare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Изменить = 1854;		// Modifica
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Удалить = 1811;		// Sterge
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Закрыть_документ = 1905;		// Inchide documentul
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Открыть_документ = 1906;		// Deschide documentul

		// Act de intrare marfa
		cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Акт_оприходования_товара = 130;
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Просмотр = 1832;		// Vizualizare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Создать = 1914;		// Creare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Изменить = 1855;		// Modifica
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Удалить = 1812;		// Sterge
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Закрыть_документ = 1912;		// Inchide documentul
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Открыть_документ = 1913;		// Deschide documentul

		// Reevaluare marfa
		cSecurityFlag_PL_Reevaluarea_bunurilor = 1414;
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_ПТ_Просмотр = 1833;		// Vizualizare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_ПТ_Изменить = 1856;		// Modifica
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_ПТ_Удалить = 1813;		// Sterge
			cSecurityFlag_INVENTARIERE_RB_Actualizare_preturi = 3167;		// Actualizare preturi

		// Act de intrare pe nakladnie
		cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Акт_оприходования_по_накладным = 1421;
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОПН_Просмотр = 1834;		// Vizualizare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОПН_Создать = 1934;		// Creare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОПН_Изменить = 1857;		// Modifica
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОПН_Удалить = 1814;		// Sterge
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОПН_Закрыть = 1932;		// Inchide
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОПН_Открыть = 1933;		// Deschide

		// Act de casare marfa pe contabilitate
		cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Акт_списания_товара_по_бухгалтерии = 131;
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТПБ_Просмотр = 1149;		// Vizualizare
      cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТПБ_Создать = 3079;		// Creare
      cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТПБ_Изменить = 1858;		// Modifica
      cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТПБ_Удалить = 1815;		// Sterge
      cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТПБ_Закрыть = 3077;		// Inchide
      cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТПБ_Открыть = 3078;		// Deschide

		// Inventariere
		cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация = 1968;
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Просмотр = 1969;		// Vizualizare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Создать = 1970;		// Creare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Изменить = 1971;		// Modifica
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Удалить = 1972;		// Sterge
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Редактировать_товар = 1973;		// Editare marfa
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Удалить_товар = 1974;		// Sterge marfa
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Закрыть_документ = 1975;		// Inchide documentul
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Открыть_документ = 1976;		// Deschide documentul

		// Analiza preturilor
		cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Анализ_цен = 3096;
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АЦ_Просмотр = 3097;		// Vizualizare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АЦ_Создать = 3098;		// Creare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АЦ_Редактировать = 3099;		// Editare
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АЦ_Удалить = 3100;		// Sterge
			cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АЦ_Печать = 3101;		// Printare
      cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АЦ_Журнал_товара = 3102;		// Registrul marfii



	// Acte
	cSecurityFlag_Акты = 1958;
		// Registru transmitere documente
		cSecurityFlag_Акты_Реестр_передачи_документов = 1959;
			cSecurityFlag_Акты_РПД_Создать = 1960;		// Creare
			cSecurityFlag_Акты_РПД_Редактировать = 1961;		// Editare
			cSecurityFlag_Акты_РПД_Удалить = 1962;		// Sterge
			cSecurityFlag_Акты_РПД_Закрыть_документ = 1963;		// Inchide documentul
			cSecurityFlag_Акты_РПД_Открыть_документ = 1964;		// Deschide documentul




	// SERVICII DE TRANSPORT
	cSecurityFlag_ТРАНСПОРТНЫЕ_УСЛУГИ = 13;
		// Foaie de parcurs
		cSecurityFlag_ТУ_Путевой_лист = 133;

		// Alimentare transport
		cSecurityFlag_ТУ_Заправка_транспорта = 132;


	// CASA
	cSecurityFlag_КАССА = 1205;
		// Casa personala
		cSecurityFlag_КАССА_Касса_персональная = 1206;
			cSecurityFlag_КАССА_КП_Трансфер_денег_себе = 1486;		// Transfer bani catre sine

		// Casa organizatiei
		cSecurityFlag_КАССА_Касса_организации = 1212;

		// Casa pe toate organizatiile
		cSecurityFlag_КАССА_Касса_по_всем_организациям = 1218;
    cSecurityFlag_CASA_CPO_Modifica_beneficialul_transferului = 3322;		// Modifica beneficialul transferului

		// Transfer bani
		cSecurityFlag_КАССА_Передача_денег = 1427;


	// ACTIUNI
	cSecurityFlag_АКЦИИ = 1227;
		// Actiuni promo pe marfa
		cSecurityFlag_АКЦИИ_Промо_акции_по_товарам = 1234;

		// Actiuni promo
		cSecurityFlag_АКЦИИ_Промо_акции = 1228;


	// WEB
	cSecurityFlag_WEB = 14;
		// Comanda Web
		cSecurityFlag_WEB_Web_Заказ = 134;
			cSecurityFlag_WEB_WЗ_Просмотр = 1646;		// Vizualizare
			cSecurityFlag_WEB_WЗ_Редактировать = 1647;		// Editare
			cSecurityFlag_WEB_WЗ_Удалить = 1648;		// Sterge
			cSecurityFlag_WEB_WЗ_Создать_Расход = 1649;		// Creare Iesire
			cSecurityFlag_WEB_WЗ_Создать_Счет_на_Оплату = 1650;		// Creare Factura de plata
      cSecurityFlag_WEB_Web_Order_Ecomm_transactii = 3250;		// Ecomm transactii
      cSecurityFlag_WEB_Web_Order_Anulare_cashback = 3283;		// Anulare cashback
			cSecurityFlag_WEB_Web_Order_Inchide_document = 3316;		// Inchide document


		// Cerere de finantare
		cSecurityFlag_WEB_Заявка_на_финансирование = 1791;
			cSecurityFlag_WEB_ЗНФ_Просмотр = 1792;		// Vizualizare
			cSecurityFlag_WEB_ЗНФ_Редактировать = 1793;		// Editare
			cSecurityFlag_WEB_ЗНФ_Удалить = 1794;		// Sterge
			cSecurityFlag_WEB_ЗНФ_Создать_Расходную_накладную = 1796;		// Creare "Nakladnaia de iesire"

		// Grafic de livrare pe oras
		cSecurityFlag_WEB_График_доставки_по_городу = 2032;
			cSecurityFlag_WEB_ГДПГ_Просмотр = 2033;		// Vizualizare
			cSecurityFlag_WEB_ГДПГ_Работать = 2034;		// Lucreaza

		// Website general
		cSecurityFlag_WEB_Website_general = 3315;

	// API FURNIZORI
	cSecurityFlag_API_FURNIZORI = 3307;
		// Accent Electronic
		cSecurityFlag_AF_Accent_Electronic = 3308;
		// Ultra Distribution
		cSecurityFlag_AF_Ultra_Distribution = 3309;
		// muncitorul.md
		cSecurityFlag_AF_muncitorulmd = 3371;
		// Imperia.md
		cSecurityFlag_AF_Imperiamd = 3372;
		// pit.md
		cSecurityFlag_AF_pitmd = 3373;
		// Volta.md
		cSecurityFlag_AF_Voltamd = 3379;
		// Convel.md
		cSecurityFlag_AF_Convelmd = 3380;
			cSecurityFlag_AF_Convelmd_Vizializare = 3381;		// Vizializare
			cSecurityFlag_AF_Convelmd_Inregistrarea_noua = 3382;		// Inregistrarea noua
			cSecurityFlag_AF_Convelmd_Modifica_inregistrarea = 3383;		// Modifica inregistrarea
			cSecurityFlag_AF_Convelmd_Sterge_inregistrarea = 3384;		// Sterge inregistrarea


 		// LumeaInstrumentelor.md
		cSecurityFlag_AF_LumeaInstrumentelormd = 3387;
    // Snaige.md
		cSecurityFlag_AF_Snaigemd = 3388;
		// Bomba.md
		cSecurityFlag_AF_Bombamd = 3389;
		// Ultra.md
		cSecurityFlag_AF_Ultramd = 3390;
		// Hikoki
		cSecurityFlag_AF_Hikoki = 3391;
		// Euroterm
		cSecurityFlag_AF_Euroterm = 3392;
		// Acvilin
		cSecurityFlag_AF_Acvilin = 3393;
		// MegacomCenter
		cSecurityFlag_AF_MegacomCenter = 3394;
    // ComputerUniverse.Net
		cSecurityFlag_AF_ComputerUniverseNet = 3398;
		// BeanBag
		cSecurityFlag_AF_BeanBag = 3404;


	// Analiza
	cSecurityFlag_Analiza = 3280;
		// Grupe de produse
		cSecurityFlag_Analiza_Grupe_de_produse = 3281;


	// SERVICE
	cSecurityFlag_СЕРВИС = 11;
		// Cereri de reparatie (S+)
		cSecurityFlag_СЕРВИС_Заявки_на_ремонт = 124;
			cSecurityFlag_СЕРВИС_ЗНР_Просмотр = 2047;		// Vizualizare
			cSecurityFlag_СЕРВИС_ЗНР_Создать = 1874;		// Creare
			cSecurityFlag_СЕРВИС_ЗНР_Изменить = 1875;		// Modifica
			cSecurityFlag_СЕРВИС_ЗНР_Удалить = 1876;		// Sterge
			cSecurityFlag_СЕРВИС_ЗНР_Закрыть_документ = 2012;		// Inchide documentul
			cSecurityFlag_СЕРВИС_ЗНР_Открыть_документ = 2013;		// Deschide documentul
			cSecurityFlag_СЕРВИС_ЗНР_Заменить_на_Гарантийный_Ремонт = 2048;		// Inlocuieste cu "Reparatie in Garantie"

		// Cereri de reparatie in garantie (N)
		cSecurityFlag_СЕРВИС_Заявки_на_гарантийный_ремонт = 125;
			cSecurityFlag_СЕРВИС_ЗНГРN_Создать_документ = 1782;		// Creare document
			cSecurityFlag_СЕРВИС_ЗНГРN_Изменить = 1783;		// Modifica
			cSecurityFlag_СЕРВИС_ЗНГРN_Удалить_документ = 1784;		// Sterge documentul
			cSecurityFlag_СЕРВИС_ЗНГРN_Закрыть_документ = 1785;		// Inchide documentul
			cSecurityFlag_СЕРВИС_ЗНГРN_Открыть_документ = 1786;		// Deschide documentul

		// Inlocuire marfa la furnizor
		cSecurityFlag_СЕРВИС_Замена_товара_у_поставщика = 1945;
			cSecurityFlag_СЕРВИС_ЗТУП_Просмотр = 1946;		// Vizualizare
			cSecurityFlag_СЕРВИС_ЗТУП_Создать = 1949;		// Creare
			cSecurityFlag_СЕРВИС_ЗТУП_Изменить = 1947;		// Modifica
			cSecurityFlag_СЕРВИС_ЗТУП_Удалить = 1948;		// Sterge
			cSecurityFlag_СЕРВИС_ЗТУП_Закрыть_документ = 1950;		// Inchide documentul
			cSecurityFlag_СЕРВИС_ЗТУП_Открыть_документ = 1951;		// Deschide documentul
			cSecurityFlag_СЕРВИС_ЗТУП_Редактировать_товар = 1965;		// Editare marfa
			cSecurityFlag_СЕРВИС_ЗТУП_Удалить_товар = 1966;		// Sterge marfa

		// Incidente noi
		cSecurityFlag_СЕРВИС_Новые_инциденты = 1280;

		// Dispecer service
		cSecurityFlag_СЕРВИС_Диспетчер_сервиса = 1396;

		// Procesare incident
		cSecurityFlag_СЕРВИС_Обработка_инцидента = 1408;

		// Incidente rezolvate
		cSecurityFlag_СЕРВИС_Решённые_инциденты = 1402;

		// Transfer in CS, VP
		cSecurityFlag_СЕРВИС_Передача_в_СЦ_ВП = 126;
			cSecurityFlag_СЕРВИС_ПВСВ_Создать = 1877;		// Creare
			cSecurityFlag_СЕРВИС_ПВСВ_Изменить = 1878;		// Modifica
			cSecurityFlag_СЕРВИС_ПВСВ_Удалить = 1879;		// Sterge
			cSecurityFlag_СЕРВИС_ПВСВ_Закрыть_документ = 1627;		// Inchide documentul
			cSecurityFlag_СЕРВИС_ПВСВ_Открыть_документ = 1628;		// Deschide documentul
			cSecurityFlag_SERVICE_RBCF_Genereaza_Factura_Fiscala = 3238;		// Genereaza "Factura Fiscala"

		// Retur din CS, Furnizor
		cSecurityFlag_СЕРВИС_Возврат_из_СЦ_Поставщика = 127;
			cSecurityFlag_СЕРВИС_ВИСП_Создать = 1880;		// Creare
			cSecurityFlag_СЕРВИС_ВИСП_Изменить = 1881;		// Modifica
			cSecurityFlag_СЕРВИС_ВИСП_Удалить = 1882;		// Sterge

		// Retur client marfa din reparatie
		cSecurityFlag_СЕРВИС_Возврат_клиенту_товара_из_ремонта = 128;
			cSecurityFlag_СЕРВИС_ВКТ_ИР_Создать = 1883;		// Creare
			cSecurityFlag_СЕРВИС_ВКТ_ИР_Изменить = 1884;		// Modifica
			cSecurityFlag_СЕРВИС_ВКТ_ИР_Удалить = 1885;		// Sterge
			cSecurityFlag_СЕРВИС_ВКТ_ИР_Закрыть_документ = 2025;		// Inchide documentul
			cSecurityFlag_СЕРВИС_ВКТ_ИР_Открыть_документ = 2026;		// Deschide documentul

		// Inlocuire produs in garantie
		cSecurityFlag_СЕРВИС_Замена_товара_в_гарантии = 1487;
			cSecurityFlag_СЕРВИС_ЗТВГ_Просмотр = 1929;		// Vizualizare
			cSecurityFlag_СЕРВИС_ЗТВГ_Создать = 1886;		// Creare
			cSecurityFlag_СЕРВИС_ЗТВГ_Изменить = 1887;		// Modifica
			cSecurityFlag_СЕРВИС_ЗТВГ_Удалить = 1888;		// Sterge
			cSecurityFlag_СЕРВИС_ЗТВГ_Закрыть = 1930;		// Inchide
			cSecurityFlag_СЕРВИС_ЗТВГ_Открыть = 1931;		// Deschide

		// Trecere in bilant pe garantie
		cSecurityFlag_СЕРВИС_Зачет_в_баланс_по_гарантии = 1726;
			cSecurityFlag_СЕРВИС_ЗВБПГ_Просмотр = 1727;		// Vizualizare
			cSecurityFlag_СЕРВИС_ЗВБПГ_Создать = 1728;		// Creare
			cSecurityFlag_СЕРВИС_ЗВБПГ_Редактировать = 1729;		// Editare
			cSecurityFlag_СЕРВИС_ЗВБПГ_Удалить = 1730;		// Sterge
			cSecurityFlag_СЕРВИС_ЗВБПГ_Закрыть_документ = 1731;		// Inchide documentul
			cSecurityFlag_СЕРВИС_ЗВБПГ_Открыть_документ = 1732;		// Deschide documentul

		// Predare marfa temporara
		cSecurityFlag_СЕРВИС_Выдача_временого_товара = 1733;

		// Retur marfa temporara
		cSecurityFlag_СЕРВИС_Возврат_временого_товара = 1734;

		// Etape reparatie
		cSecurityFlag_СЕРВИС_Этапы_ремонта = 1735;

		// Transfer in reparatie
		cSecurityFlag_СЕРВИС_Перемещение_в_ремонте = 1736;

		// Retur in / Primire din Centrul Service
		cSecurityFlag_СЕРВИС_Возврат_в_Прием_из_Сервис_центра = 1978;
			cSecurityFlag_СЕРВИС_ВВ_ПИСЦ_Просмотр = 1979;		// Vizualizare
			cSecurityFlag_СЕРВИС_ВВ_ПИСЦ_Создать = 1980;		// Creare
			cSecurityFlag_СЕРВИС_ВВ_ПИСЦ_Изменить = 1981;		// Modifica
			cSecurityFlag_СЕРВИС_ВВ_ПИСЦ_Удалить = 1982;		// Sterge
			cSecurityFlag_СЕРВИС_ВВ_ПИСЦ_Редактировать_товар = 1983;		// Editare marfa
			cSecurityFlag_СЕРВИС_ВВ_ПИСЦ_Удалить_товар = 1984;		// Sterge marfa
			cSecurityFlag_СЕРВИС_ВВ_ПИСЦ_Закрыть_документ = 1985;		// Inchide documentul
			cSecurityFlag_СЕРВИС_ВВ_ПИСЦ_Открыть_документ = 1986;		// Deschide documentul

		// Primire / Retur marfa de la client
		cSecurityFlag_СЕРВИС_Прием_Возврат_товара_от_клиента = 1987;
			cSecurityFlag_СЕРВИС_П_ВТОК_Просмотр = 1988;		// Vizualizare
			cSecurityFlag_СЕРВИС_П_ВТОК_Создать = 1989;		// Creare
			cSecurityFlag_СЕРВИС_П_ВТОК_Редактировать = 1990;		// Editare
			cSecurityFlag_СЕРВИС_П_ВТОК_Удалить = 1991;		// Sterge
			cSecurityFlag_СЕРВИС_П_ВТОК_Печать = 1992;		// Printare

		// Reclamatii
		cSecurityFlag_SERVICE_Reclamatii = 3374;
			cSecurityFlag_SERVICE_Reclamatii_Vizializare = 3375;		// Vizializare
			cSecurityFlag_SERVICE_Reclamatii_Inregistrarea_noua = 3376;		// Inregistrarea noua
			cSecurityFlag_SERVICE_Reclamatii_Modifica_inregistrarea = 3377;		// Modifica inregistrarea
			cSecurityFlag_SERVICE_Reclamatii_Sterge_inregistrarea = 3378;		// Sterge inregistrarea


	// STOCURI
	cSecurityFlag_ОСТАТКИ = 10;
		// Stocuri marfa
		cSecurityFlag_ОСТАТКИ_Остатки_товара = 122;

		// Sold contraagenti evidenta manageriala
		cSecurityFlag_ОСТАТКИ_Сальдо_контрагентов = 123;
			cSecurityFlag_ОСТАТКИ_СК_Просмотр = 1838;		// Vizualizare
			cSecurityFlag_ОСТАТКИ_СК_Создать = 1897;		// Creare
			cSecurityFlag_ОСТАТКИ_СК_Изменить = 1862;		// Modifica
			cSecurityFlag_ОСТАТКИ_СК_Удалить = 1819;		// Sterge
			cSecurityFlag_ОСТАТКИ_СК_Закрыть = 1895;		// Inchide
			cSecurityFlag_ОСТАТКИ_СК_Открыть = 1896;		// Deschide
 			cSecurityFlag_SOLDURI_SC_Договора = 3149;		// Contracte

		// Sold clienti contabil
		cSecurityFlag_SOLDURI_Sold_clienti_contabil = 3269;
			cSecurityFlag_SOLDURI_SCC_Vizializare = 3270;		// Vizializare
			cSecurityFlag_SOLDURI_SCC_Inregistrarea_noua = 3271;		// Inregistrarea noua
			cSecurityFlag_SOLDURI_SCC_Modifica_inregistrarea = 3272;		// Modifica inregistrarea
			cSecurityFlag_SOLDURI_SCC_Sterge_inregistrarea = 3273;		// Sterge inregistrarea
            cSecurityFlag_SOLDURI_SCC_Inchide_documentul = 3368;		// Inchide documentul
			cSecurityFlag_SOLDURI_SCC_Deschide_documentul = 3369;		// Deschide documentul

	// CONTRACTE
	cSecurityFlag_ДОГОВОРА = 2;
		// Contract de vanzare
		cSecurityFlag_ДОГОВОРА_Договор_на_продажу = 105;

		// Contract franciza
		cSecurityFlag_ДОГОВОРА_Contract_franciza = 1470;

		// Contract prestari servicii
		cSecurityFlag_ДОГОВОРА_Contract_prestari_servicii = 1464;


	// [Instrumente]
	cSecurityFlag_Инструменты = 1493;
		// Imprimanta fiscala
		cSecurityFlag_Инструменты_Фискальный_принтер = 1631;

		// Transfer bani catre alt utilizator
		cSecurityFlag_Инструменты_Передача_денег_другому_пользователю = 1500;

		// Transfer bani catre sine
		cSecurityFlag_Инструменты_Трансфер_денег_себе = 1499;

		// Schimb valutar
		cSecurityFlag_Инструменты_Обмен_валюты = 1498;

		// Recalcul stocuri
		cSecurityFlag_Инструменты_Перерасчет_остатков = 1497;

		// Recalcul cantitate in transferuri
		cSecurityFlag_Инструменты_Пересчет_колва_в_перемещениях = 1770;

		// Sincronizare preturi din alte firme
		cSecurityFlag_Инструменты_Синхронизация_цен_из_других_фирм = 1496;

		// Import produse din denumiri
		cSecurityFlag_Инструменты_Импорт_товаров_из_названий = 1494;

		// Marfuri bonus
		cSecurityFlag_Инструменты_Бонусные_товары = 1632;
			cSecurityFlag_Инструменты_БТ_Просмотр = 1633;		// Vizualizare
			cSecurityFlag_Инструменты_БТ_Администрировать = 1634;		// Administrare

		// Informatii despre salariu
		cSecurityFlag_Инструменты_Информация_о_зарплате = 1636;
			cSecurityFlag_Инструменты_ИОЗ_Начисление_зарплаты_инструменты = 1637;		// Calcul salariu - instrumente
			cSecurityFlag_Инструменты_ИОЗ_Информация_о_зарплате = 1638;		// Informatii despre salariu
			cSecurityFlag_Инструменты_ИОЗ_Планы_продаж = 3001;		// Planuri de vanzari

		// Planuri de vanzari
		cSecurityFlag_Инструменты_Планы_продаж = 1643;
			cSecurityFlag_Инструменты_ПП_Просмотр = 1644;		// Vizualizare
			cSecurityFlag_Инструменты_ПП_Администрировать = 1645;		// Administrare

		// Import marfa din alte firme in tabel
		cSecurityFlag_Инструменты_Импорт_товаров_из_других_фирм_в_таблицу = 1737;

		// Produse pentru actiunea "Discount la a 2-a achizitie"
		cSecurityFlag_Инструменты_Товары_для_акции_Скидка_на_2ю_покупку = 1767;

		// Cautare in registrul documentelor
		cSecurityFlag_Инструменты_Поиск_в_журнале_документов = 1769;

		// Registru intarzieri angajati
		cSecurityFlag_Инструменты_Журнал_опозданий_работников = 1773;
			cSecurityFlag_Инструменты_ЖОР_Просмотр = 1774;		// Vizualizare
			cSecurityFlag_Инструменты_ЖОР_Создать = 1775;		// Creare
			cSecurityFlag_Инструменты_ЖОР_Редактировать = 1776;		// Editare
			cSecurityFlag_Инструменты_ЖОР_Удалить = 1777;		// Sterge

		// Registru amenzi si bonusuri angajati
		cSecurityFlag_Инструменты_Журнал_штрафов_и_бонусов_работников = 1915;
			cSecurityFlag_Инструменты_ЖШИБР_Просмотр = 1916;		// Vizualizare
			cSecurityFlag_Инструменты_ЖШИБР_Создать = 1917;		// Creare
			cSecurityFlag_Инструменты_ЖШИБР_Редактировать = 1918;		// Editare
			cSecurityFlag_Инструменты_ЖШИБР_Удалить = 1919;		// Sterge

		// Aflare bonus propriu din vanzari
		cSecurityFlag_Инструменты_Узнать_свой_бонус_с_продаж = 1924;

		// Monitor activitate
		cSecurityFlag_Инструменты_Монитор_активности = 1935;
			cSecurityFlag_Инструменты_МА_Настройки = 1936;		// Setari
			cSecurityFlag_Инструменты_МА_Смотреть = 1937;		// Vizualizeaza

		// Cheltuieli suplimentare
		cSecurityFlag_Инструменты_Дополнительные_расходы = 1952;
			cSecurityFlag_Инструменты_ДР_Просмотр = 1953;		// Vizualizare
			cSecurityFlag_Инструменты_ДР_Создать = 1954;		// Creare
			cSecurityFlag_Инструменты_ДР_Редактировать = 1955;		// Editare
			cSecurityFlag_Инструменты_ДР_Удалить = 1956;		// Sterge

		// Muta documentele pe azi
		cSecurityFlag_Инструменты_Перенести_документы_на_сегодня = 1977;

    // Analiza preturilor
		cSecurityFlag_Инструменты_Анализ_цен = 2027;

		// Analiza preturilor
		cSecurityFlag_Инструменты_Анализ_прайсов = 2028;

		// Inchidere zi business
		cSecurityFlag_Инструменты_Закрытие_business_дня = 2035;

		// Gestionare perioade de lucru
		cSecurityFlag_Инструменты_Управление_рабочими_периодами = 3117;
			cSecurityFlag_Инструменты_УРП_Управлять = 3118;		// Gestioneaza

		// Raportare financiara
		cSecurityFlag_Инструменты_Финансовая_отчетность = 3140;
			cSecurityFlag_Инструменты_ФО_Общие_финансовые_данные = 3141;		// Date financiare generale
			cSecurityFlag_INSTRUMENTE_ФО_Credite_si_Plati_cu_Cardul = 3259;		// Credite si Plati cu Cardul

		// Sip Log
		cSecurityFlag_INSTRUMENTE_Sip_Log = 3157;

		// Cheltuieli deschise, neplatite
		cSecurityFlag_INSTRUMENTE_Расходы_с_открытые_неоплоченные = 3188;
			cSecurityFlag_INSTRUMENTE_РСОН_Просмотр = 3189;		// Vizualizare
			cSecurityFlag_INSTRUMENTE_РСОН_Создать = 3190;		// Creare
			cSecurityFlag_INSTRUMENTE_РСОН_Редактировать = 3191;		// Editare
			cSecurityFlag_INSTRUMENTE_РСОН_Удалить = 3192;		// Sterge
			cSecurityFlag_INSTRUMENTE_РСОН_Печать = 3193;		// Printare

		// Indeplinirea planului de vinzari
		cSecurityFlag_INSTRUMENTE_Indeplinirea_planului_de_vinzari = 3246;
			cSecurityFlag_INSTRUMENTE_IPDV_Vinzarile_personale = 3247;		// Vinzarile personale
			cSecurityFlag_INSTRUMENTE_IPDV_Vinzarile_la_toti_operatorii = 3248;		// Vinzarile la toti operatorii


	// [1C Contabilitate]
	cSecurityFlag_1C_Бухгалтерия = 1787;
		// Export documente
		cSecurityFlag_1C_Экспорт_документов = 1788;
		// Client bank
		cSecurityFlag_1Б_Client_bank = 3214;
			cSecurityFlag_1Б_CB_ECB = 3215;		// ECB



	// [System Events]
	cSecurityFlag_System_Events = 1461;
		// Event "Naryad de asamblare"
		cSecurityFlag_SE_Event_Наряд_на_сборку = 1463;

		// Event "Nakladnaia de iesire"
		cSecurityFlag_SE_Event_Расходная_накладная = 1462;

		// Event "Modificare comentarii"
		cSecurityFlag_SE_Event_Изменение_комментариев = 1504;

		// Event "Comanda Web"
		cSecurityFlag_SE_Event_Web_Заказ = 1651;

		// Event "Cerere de finantare"
		cSecurityFlag_SE_Event_Заявка_на_финансирование = 1795;

		// Event "Grafic de livrare"
		cSecurityFlag_SE_Event_График_доставки = 2031;

		// Event "Comenzi preliminare"
		cSecurityFlag_SE_Event_Предварительные_заказы = 3041;



	// [Nomenclatoare]
	cSecurityFlag_Справочники = 1286;
		// Banci
		cSecurityFlag_Справочники_Банки = 1352;
			cSecurityFlag_Справочники_Банки_Создать = 1540;		// Creare
			cSecurityFlag_Справочники_Банки_Редактировать = 1541;		// Editare
			cSecurityFlag_Справочники_Банки_Удалить = 1542;		// Sterge

		// Valuta
		cSecurityFlag_Справочники_Валюта = 1349;
			cSecurityFlag_Справочники_Валюта_Просмотр = 1350;		// Vizualizare
			cSecurityFlag_Справочники_Валюта_Изменить_курс_валюты = 1351;		// Modifica cursul valutar

		// Depozite
		cSecurityFlag_Справочники_Склады = 1344;
			cSecurityFlag_Справочники_Склады_Создать = 1580;		// Creare
			cSecurityFlag_Справочники_Склады_Редактировать = 1581;		// Editare
			cSecurityFlag_Справочники_Склады_Удалить = 1582;		// Sterge
      cSecurityFlag_Справочники_Склады_Права_пользователей = 3093;		// Drepturile utilizatorilor

		// Produse
		cSecurityFlag_Справочники_Товары = 1287;
			cSecurityFlag_Справочники_Товары_Создание_папки = 1569;		// Creare folder
			cSecurityFlag_Справочники_Товары_Изменение_папки = 1571;		// Modificare folder
			cSecurityFlag_Справочники_Товары_Удаление_папки = 1573;		// Stergere folder
			cSecurityFlag_Справочники_Товары_Создание_товара = 1570;		// Creare marfa
			cSecurityFlag_Справочники_Товары_Изменение_товара = 1572;		// Modificare marfa
			cSecurityFlag_Справочники_Товары_Удаление_товара = 1574;		// Stergere marfa
			cSecurityFlag_Справочники_Товары_Описание_товара = 1575;		// Descrierea marfii
			cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара = 1568;		// Modificare valuta si pret marfa
			cSecurityFlag_Справочники_Товары_Тип_учета_товара = 1567;		// Tipul evidentei marfii
			cSecurityFlag_Справочники_Товары_Комплектация_товара = 1576;		// Configurare set marfa
			cSecurityFlag_Справочники_Товары_Взаимозаменяемость_товара = 1577;		// Interschimbabilitatea marfii
			cSecurityFlag_Справочники_Товары_Изменение_характеристик_товара = 1566;		// Modificare caracteristici marfa
			cSecurityFlag_Справочники_Товары_Колонка_цен_0 = 1529;		// Coloana preturi 0
			cSecurityFlag_Справочники_Товары_Колонка_цен_1 = 1530;		// Coloana preturi 1
			cSecurityFlag_Справочники_Товары_Колонка_цен_2 = 1531;		// Coloana preturi 2
			cSecurityFlag_Справочники_Товары_Колонка_цен_3 = 1532;		// Coloana preturi 3
			cSecurityFlag_Справочники_Товары_Колонка_цен_4 = 1533;		// Coloana preturi 4
			cSecurityFlag_Справочники_Товары_Колонка_цен_5 = 1534;		// Coloana preturi 5
			cSecurityFlag_Справочники_Товары_Колонка_цен_6 = 1535;		// Coloana preturi 6
			cSecurityFlag_Справочники_Товары_Колонка_цен_7 = 1536;		// Coloana preturi 7
			cSecurityFlag_Справочники_Товары_Изменение_предка = 1578;		// Modificare parinte
			cSecurityFlag_Справочники_Товары_Упорядочивание_папок = 1579;		// Ordonare foldere
			cSecurityFlag_Справочники_Товары_Флаг_Новый_товар = 1604;		// Flag "Marfa noua"
			cSecurityFlag_Справочники_Товары_Флаг_Промо_товар = 1605;		// Flag "Marfa promo"
			cSecurityFlag_Справочники_Товары_Карточка_товара = 1606;		// Fisa produsului
      cSecurityFlag_Справочники_Товары_Карточка_товара_Цены = 1772;		// Fisa produsului - Preturi
			cSecurityFlag_Справочники_Товары_Карточка_товара_Все_фирмы = 1778;		// Fisa produsului - Toate firmele
			cSecurityFlag_Справочники_Товары_Наличие_товара_фирмасклад = 1612;		// Disponibilitate marfa firma/depozit
			cSecurityFlag_Справочники_Товары_Техническая_спецификация = 1635;		// Specificatie tehnica
      cSecurityFlag_Справочники_Товары_Просмотр_рентабельности = 1725;		// Vizualizare rentabilitate
      cSecurityFlag_Справочники_Товары_Обьединение_товара = 1771;		// Unificare marfa
			cSecurityFlag_Справочники_Товары_Флаг_Всегда_показывать_в_прайсах = 2040;		// Flag "Afiseaza mereu in preturi"
			cSecurityFlag_Справочники_Товары_Флаг_Скидка_на_товар = 2041;		// Flag "Discount la marfa"
			cSecurityFlag_Справочники_Товары_Товары_из_других_фирм = 2042;		// Produse din alte firme
			cSecurityFlag_Справочники_Товары_Флаг_Устаревший_товар = 2043;		// Flag "Marfa depasita"
      cSecurityFlag_Справочники_Товары_Связи_websites = 3130;		// Legaturi websites
      cSecurityFlag_Справочники_Товары_Modificare_complecte = 3142;		// Modificare complecte
			cSecurityFlag_Справочники_Товары_Флаг_Много = 3151;		// Flag Mult
			cSecurityFlag_Справочники_Товары_Флаг_Заказчиваются = 3152;		// Flag Se comanda
			cSecurityFlag_Справочники_Товары_В_ожидании = 3153;		// In asteptare
			cSecurityFlag_Справочники_Товары_Флаг_На_заказ = 3154;		// Flag La comanda
			cSecurityFlag_Справочники_Товары_Удалить_все_цветные_флаги = 3186;		// Sterge toate flag-urile colorate
 			cSecurityFlag_Справочники_Товары_Analiza_Vinzarilor_Pivot = 3256;		// Analiza Vinzarilor Pivot
			cSecurityFlag_Справочники_Товары_Gestiune_filtre_produse_din_nomenclatorul_Produselor = 3395;		// Gestiune filtre produse din nomenclatorul Produselor
			cSecurityFlag_Справочники_Товары_Web_menu = 3396;		// Web menu
			cSecurityFlag_Справочники_Товары_Arata_mapele_pentru_tipul_de_produse = 3397;		// Arata mapele pentru tipul de produse


// Clienti
		cSecurityFlag_Справочники_Клиенты = 1296;
			cSecurityFlag_Справочники_Клиенты_Создание_папки = 1545;		// Creare folder
			cSecurityFlag_Справочники_Клиенты_Создание_клиента = 1546;		// Creare client
			cSecurityFlag_Справочники_Клиенты_Изменение_папки = 1547;		// Modificare folder
			cSecurityFlag_Справочники_Клиенты_Изменение_клиента = 1548;		// Modificare client
			cSecurityFlag_Справочники_Клиенты_Удаление_папки = 1543;		// Stergere folder
			cSecurityFlag_Справочники_Клиенты_Удаление_клиента = 1550;		// Stergere client
			cSecurityFlag_Справочники_Клиенты_Колонка_цен_клиента = 1538;		// Coloana preturi client
			cSecurityFlag_Справочники_Клиенты_Комментарии = 1555;		// Comentarii
			cSecurityFlag_Справочники_Клиенты_Интернет_доступ = 1554;		// Acces internet
			cSecurityFlag_Справочники_Клиенты_Дисконтные_карточки = 1552;		// Carduri de discount
			cSecurityFlag_Справочники_Клиенты_Банковские_реквизиты = 1551;		// Detalii bancare
			cSecurityFlag_Справочники_Клиенты_Изменение_предка = 1556;		// Modificare parinte
			cSecurityFlag_Справочники_Клиенты_Упорядочивание_папок = 1557;		// Ordonare foldere
			cSecurityFlag_Справочники_Клиенты_Текущие_долги_контрагента = 1607;		// Datorii curente contraagent
			cSecurityFlag_Справочники_Клиенты_Текущие_долги_контрагента_История_наличные = 1608;		// Datorii curente contraagent - Istoric numerar
			cSecurityFlag_Справочники_Клиенты_Текущие_долги_контрагента_История_безналичные = 1609;		// Datorii curente contraagent - Istoric fara numerar
			cSecurityFlag_Справочники_Клиенты_Изменение_клиента_сотрудника = 1738;		// Modificare client-angajat
			cSecurityFlag_Справочники_Клиенты_Контракты_Смотреть = 1943;		// Contracte - Vizualizare
			cSecurityFlag_Справочники_Клиенты_Контракты_Администрирование = 1944;		// Contracte - Administrare
			cSecurityFlag_Справочники_Клиенты_Кредиты_просмотр = 1553;		// Credite - vizualizare
			cSecurityFlag_Справочники_Клиенты_Кредиты_создать = 2029;		// Credite - creare
			cSecurityFlag_Справочники_Клиенты_Кредиты_изменить = 1539;		// Credite - modificare
			cSecurityFlag_Справочники_Клиенты_Кредиты_удалить = 2030;		// Credite - stergere
      cSecurityFlag_Справочники_Клиенты_Редактировать_свои_организации = 3129;		// Editeaza organizatiile proprii
			cSecurityFlag_Справочники_Клиенты_5_колонка_для_дисконтных_картах = 3150;		// 5 coloana pentru cardurile de discount
      cSecurityFlag_Справочники_Клиенты_Date_importate_pentru_client_Nou = 3159;		// Date importate pentru client-Nou
			cSecurityFlag_Справочники_Клиенты_Date_importate_pentru_client_Modifica = 3160;		// Date importate pentru client-Modifica
			cSecurityFlag_Справочники_Клиенты_Date_importate_pentru_client_Sterge = 3161;		// Date importate pentru client-Sterge
			cSecurityFlag_Справочники_Клиенты_Conditiile_de_lucru_cu_furnizorii = 3386;		// Conditiile de lucru cu furnizorii


		// Analitica
		cSecurityFlag_Справочники_Аналитика = 1357;

		// Certificate
		cSecurityFlag_Справочники_Сертификаты = 1367;
			cSecurityFlag_Справочники_Сертификаты_Создать = 1597;		// Creare
			cSecurityFlag_Справочники_Сертификаты_Редактировать = 1598;		// Editare
			cSecurityFlag_Справочники_Сертификаты_Удалить = 1599;		// Sterge
			cSecurityFlag_Справочники_Сертификаты_Просмотр_сертифицированных_товаров = 1600;		// Vizualizare marfa certificata
			cSecurityFlag_Справочники_Сертификаты_Изменить_сертифицированные_товары = 1596;		// Modifica marfa certificata

		// Procuri
		cSecurityFlag_Справочники_Доверенности = 1362;
			cSecurityFlag_Справочники_Доверенности_Создать = 1593;		// Creare
			cSecurityFlag_Справочники_Доверенности_Редактировать = 1594;		// Editare
			cSecurityFlag_Справочники_Доверенности_Удалить = 1595;		// Sterge

		// Sabloane configuratii
		cSecurityFlag_Справочники_Шаблоны_конфигураций = 1390;
			cSecurityFlag_Справочники_ШК_Создать = 1583;		// Creare
			cSecurityFlag_Справочники_ШК_Изменить_состав_шаблона = 1586;		// Modifica componenta sablonului
			cSecurityFlag_Справочники_ШК_Редактировать = 1584;		// Editare
			cSecurityFlag_Справочники_ШК_Удалить = 1585;		// Sterge

		// Nomenclator de sistem
		cSecurityFlag_Справочники_Системный_справочник = 1339;
			cSecurityFlag_Справочники_СС_Создать = 1526;		// Creare
			cSecurityFlag_Справочники_СС_Редактироватi = 1527;		// Editare
			cSecurityFlag_Справочники_СС_Удалитi = 1528;		// Sterge

		// Denumire pentru nakladnie
		cSecurityFlag_Справочники_Наименование_для_накладных = 1315;
			cSecurityFlag_Справочники_НДН_Просмотр = 1923;		// Vizualizare
			cSecurityFlag_Справочники_НДН_Создание_папки = 1562;		// Creare folder
			cSecurityFlag_Справочники_НДН_Изменение_папки = 1558;		// Modificare folder
			cSecurityFlag_Справочники_НДН_Удаление_папки = 1560;		// Stergere folder
			cSecurityFlag_Справочники_НДН_Создание_наименования_для_накладной = 1563;		// Creare denumire pentru nakladnaia
			cSecurityFlag_Справочники_НДН_Изменение_наименования_для_накладной = 1559;		// Modificare denumire pentru nakladnaia
			cSecurityFlag_Справочники_НДН_Удаление_наименования_для_накладной = 1561;		// Stergere denumire pentru nakladnaia
			cSecurityFlag_Справочники_НДН_Изменение_предка = 1564;		// Modificare parinte
			cSecurityFlag_Справочники_НДН_Упорядочивание_папок = 1565;		// Ordonare foldere

		// Tipuri de contracte
		cSecurityFlag_Справочники_Типы_контрактов = 1938;
			cSecurityFlag_Справочники_ТК_Просмотр = 1939;		// Vizualizare
			cSecurityFlag_Справочники_ТК_Создать = 1940;		// Creare
			cSecurityFlag_Справочники_ТК_Редактировать = 1941;		// Editare
			cSecurityFlag_Справочники_ТК_Удалить = 1942;		// Sterge

		// Politica de preturi
		cSecurityFlag_Справочники_Politica_de_preturi = 3162;
			cSecurityFlag_Справочники_PDP_Vizualizeaza = 3163;		// Vizualizeaza
			cSecurityFlag_Справочники_PDP_Nou = 3164;		// Nou
			cSecurityFlag_Справочники_PDP_Modifica = 3165;		// Modifica
			cSecurityFlag_Справочники_PDP_Sterge = 3166;		// Sterge

		// Produse la furnizori
		cSecurityFlag_Справочники_Товары_у_поставщиков = 3223;
			cSecurityFlag_Справочники_ТУП_Просмотр = 3224;		// Vizualizare
			cSecurityFlag_Справочники_ТУП_Администрирование = 3225;		// Administrare
			cSecurityFlag_Справочники_НТУП_Modificare = 3257;		// Modificare

		// Branduri
		cSecurityFlag_Справочники_Branduri = 3342;
			cSecurityFlag_Справочники_Branduri_Creaza_inregistrare_noua = 3343;		// Creaza inregistrare noua
			cSecurityFlag_Справочники_Branduri_Modifica_inregistrarea = 3344;		// Modifica inregistrarea
			cSecurityFlag_Справочники_Branduri_Sterge_inregistrarea = 3345;		// Sterge inregistrarea

	// [Administrare]
	cSecurityFlag_Администрирование = 1374;

		// Tipuri de documente
		cSecurityFlag_Администрирование_Типы_документов = 1385;
			cSecurityFlag_Администрирование_ТД_Создать = 1601;		// Creare
			cSecurityFlag_Администрирование_ТД_Редактировать = 1602;		// Editare
			cSecurityFlag_Администрирование_ТД_Удалить = 1603;		// Sterge

		// Blocare firme
		cSecurityFlag_Администрирование_Блокировка_фирм = 1686;
			cSecurityFlag_Администрирование_БФ_Блокировка_фирм = 1687;		// Blocare firme


	// Grupuri nealocate
	cSecurityFlag_Не_раставленные_группы = 1246;
		// Produs fara caracteristici
		cSecurityFlag_НРГ_Товар_без_характеристик = 1247;

		// Produs lipsa
		cSecurityFlag_НРГ_Недостающийся_товар = 1248;


	// [Website]
	cSecurityFlag_Website = 1739;
		// Catalog Web marfa
		cSecurityFlag_Website_Web_Каталог_товаров = 1740;
			cSecurityFlag_Website_WКТ_Просмотр = 1741;		// Vizualizare
			cSecurityFlag_Website_WКТ_Создать = 1742;		// Creare
			cSecurityFlag_Website_WКТ_Редактировать = 1743;		// Editare
			cSecurityFlag_Website_WКТ_Удалить = 1744;		// Sterge
			cSecurityFlag_Website_WКТ_Фильтры = 1745;		// Filtre
			cSecurityFlag_Website_WКТ_Совместимые_товары = 1746;		// Marfuri compatibile
			cSecurityFlag_Website_WКТ_Группы_товаров = 1747;		// Grupuri de marfuri

		// Filtre
		cSecurityFlag_Website_Фильтры = 1748;
			cSecurityFlag_Website_Фильтры_Crearea_filtrelor = 3294;		// Crearea filtrelor
			cSecurityFlag_Website_Фильтры_Editarea_filtrelor = 3295;		// Editarea filtrelor
			cSecurityFlag_Website_Фильтры_Stergerea_filtrelor = 3296;		// Stergerea filtrelor


		// Sabloane descriere marfa
		cSecurityFlag_Website_Шаблоны_описания_товаров = 1749;

		// Butoane pentru filtre
		cSecurityFlag_Website_Кнопки_для_фильтров = 1750;

		// Magazine
		cSecurityFlag_Website_Магазины = 1751;

		// Livrare
		cSecurityFlag_Website_Доставка = 1752;

		// Actiuni promo
		cSecurityFlag_Website_Промо_акции = 1753;

		// Trimiteri E-mail
		cSecurityFlag_Website_Email_рассылки = 1754;

		// Bannere mari
		cSecurityFlag_Website_Большие_баннера = 1922;

		// Pagini statice pe site
		cSecurityFlag_Website_Статические_страницы_на_сайте = 1957;

		// Pachete de produse
		cSecurityFlag_Website_Pachete_de_produse = 3072;
			cSecurityFlag_Website_PDP_Просмотр = 3073;		// Vizualizare
			cSecurityFlag_Website_PDP_Создать = 3074;		// Creare
			cSecurityFlag_Website_PDP_Редактировать = 3075;		// Editare
			cSecurityFlag_Website_PDP_Удалить = 3076;		// Sterge

		// Web access log
		cSecurityFlag_Website_Web_access_log = 3279;
	// Actualizarea lista de marfa pe web
		cSecurityFlag_Website_Actualizarea_lista_de_marfa_pe_web = 3347;

		// Actualizare SEO info produse
		cSecurityFlag_Website_Actualizare_SEO_info_produse = 3348;

		// Configurare website
		cSecurityFlag_Website_Configurare_website = 3349;

		// Starea New si Promo pentru produse
		cSecurityFlag_Website_Starea_New_si_Promo_pentru_produse = 3350;

		// Sabloate de descriere a produselor
		cSecurityFlag_Website_Sabloate_de_descriere_a_produselor = 3351;

		// Gestionarea URL pe site
		cSecurityFlag_Website_Gestionarea_URL_pe_site = 3352;

		// Catalog articole site
		cSecurityFlag_Website_Catalog_articole_site = 3353;
			cSecurityFlag_Website_CAS_Vizializare = 3354;		// Vizializare
			cSecurityFlag_Website_CAS_Inregistrarea_noua = 3355;		// Inregistrarea noua
			cSecurityFlag_Website_CAS_Modifica_inregistrarea = 3356;		// Modifica inregistrarea
			cSecurityFlag_Website_CAS_Sterge_inregistrarea = 3357;		// Sterge inregistrarea

		// Produse promotionale zilnice pe web
		cSecurityFlag_Website_Produse_promotionale_zilnice_pe_web = 3358;

		// Distributie content prin e-mail
		cSecurityFlag_Website_Distributie_content_prin_e_mail = 3359;

		// Distribuire content prin SMS
		cSecurityFlag_Website_Distribuire_content_prin_SMS = 3360;
		// Posturi vacante
		cSecurityFlag_Website_Posturi_vacante = 3362;
		// Search pe Web
		cSecurityFlag_Website_Search_pe_Web = 3370;


	// Printare
	cSecurityFlag_Печать = 3104;
		// Manager rapoarte
	cSecurityFlag_TIPAR_Manager_rapoarte = 3105;
			cSecurityFlag_TIPAR_MR_Редактировать_шаблоны_отчетов = 3106;		// Editeaza sabloanele de rapoarte
			cSecurityFlag_TIPAR_MR_Клонировать_шаблон = 3107;		// Cloneaza sablonul
			cSecurityFlag_TIPAR_MR_Удалить_шаблон = 3108;		// Sterge sablonul
			cSecurityFlag_TIPAR_MR_Создать_шаблон = 3109;		// Creare sablon
			cSecurityFlag_TIPAR_MR_Упорядочить_шаблоны = 3110;		// Ordoneaza sabloanele
			cSecurityFlag_TIPAR_MR_Поиск_шаблона = 3111;		// Cautare sablon
			cSecurityFlag_TIPAR_MR_Редактировать_сгенерированный_отчет = 3155;		// Editeaza raportul generat


	//--- End of security flags -----------------------------------------

  // temp
  cSecurityFlag_Можно_выставлят_обратную_дату = 9999;


implementation

end.
