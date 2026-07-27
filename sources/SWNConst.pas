unit SWNConst;
{
   Aici se afla toate constantele utilizate in SWN
}

interface

Uses Graphics, Winapi.Messages;

type
  TFontSizeItem = record
    Title: String;
    FontName: String;
    FontSize: integer;
  end;

  TSelectGoodsAction = (acChangeACNT, acChangeGoods, acChangePrice, acChangeQTY, acChangeStock, acChangeActive,
    acChangeEU, acChangeEUK, acChangeWarranty);

const
  WM_SWN_RING = WM_USER + 4242;

  // descrierea garniturilor
  cFontSizeItems: array [0 .. 4] of TFontSizeItem =
    (
    (Title: 'Mic (Tahoma 8)'; FontName: 'Tahoma'; FontSize: 8),
    (Title: 'Normal(Segoe 9)'; FontName: 'Segoe UI'; FontSize: 9),
    (Title: 'Roboto'; FontName: 'Roboto'; FontSize: 9),
    (Title: 'Normal (Arial 9)'; FontName: 'Arial'; FontSize: 8),
    (Title: 'Mare (Arial 10)'; FontName: 'Arial'; FontSize: 9)
    );

  cAppDefaultFontIndex = 1;
  cAppDefault_QtyDigits = 0;

  cQTY_DigitsMask: array [0 .. 4] of String = ('0', '0.0', '0.00', '0.000', '0.0000');
  cQTY_DigitsMask2: array [0 .. 4] of String = ('', '%s0', '%s00', '%s000', '%s0000');
  cQTY_DigitsRoundMask: array [0 .. 4] of Integer = (1, 10, 100, 1000, 10000);

  // registry key
  cREGISTRY_KEY_Run = 'Software\Microsoft\Windows\CurrentVersion\Run';
  cREGISTRY_VALUE_Run = 'WMS';

  // Applications texts
  cAPP_Title = 'iC Gestionarea stocurilor';
  cAPP_Version = 'v. %s';
  cAPP_User = 'Utilizator: %s';
  cAPP_Server = 'Server: %s на %s%s';

  cDATABASE_DBName = 'SW';
  cDATABASE_ConnectionServerDefault = '192.168.106.254';
  cDATABASE_ConnectionPortDefault = 3050;

  // auto update options
  cUPDATE_IntervalCheckMin = 10; // min

  // Login and Pass for Authentification
  cDATABASE_TestLogin_UserName = 'TESTLOGIN_USERNAME';
    cDATABASE_TestLogin_UserPassword = 'TestLogin_UserPass';

  // Login and Pass for work
  cDATABASE_UserLogin_UserName = 'SYSDBA';
  cDATABASE_UserLogin_UserPassword = 'uigres321';

  cSerialNumber_MinLength = 4; // chars
  cMasterDetails_DetailDelay = 500; // ms, time between child-master refresh, 500

  // Login Dialog

  cMSG_LOGIN_InputError_Title = 'Logare imposibila!';
  cMSG_LOGIN_InputError_Text = 'Nu sunt completate toate cimpurile sau valorile sunt gresite';

  cMSG_LOGIN_LoginError_Title = 'Eroare de conectare!';
  cMSG_LOGIN_LoginError_Text = 'La conectare a aparut o eroare';
  cMSG_LOGIN_LoginError_Footer = 'Daca problema nu a fost solutionata, adresativa administratorului!';

  cMSG_LOGIN_LoginDenied_Title = 'Acces interzis!';
  cMSG_LOGIN_LoginDenied_Text = 'Utilizatorul nu are suficiente drepturi.';
  cMSG_LOGIN_LoginDenied2_Text = 'Eroare de conectare.';
  cMSG_LOGIN_LoginDenied_Expanded = 'Login, parola gresite sau orele de lucru limitate!';
  cMSG_LOGIN_LoginDenied2_Expanded = 'Serverul de date nu raspunde. ERROR 0x13F0';
  cMSG_LOGIN_LoginDenied_Footer = 'Daca problema nu a fost solutionata, adresativa administratorului!';

  cMSG_GeneralError_Title = 'Eroare!';

  cMSG_GeneralInputError_Title = 'Eroare!';
  cMSG_GeneralInputError_Text = 'Cîmpurile necesare nu sunt complectate sau valorile sunt greșite';

  cMSG_DELETERECORD = 'Șterge inregistrarea';
  cMSG_DELETERECORD_DeleteDocument = 'Șterge documentul';
  cMSG_DELETERECORD_DeleteGoods = 'Șterge produsul';

  cMSG_CLOSEDOC_TITLE = 'Închide document';
  cMSG_CLOSEDOC_TEXT = 'Doriți să închideți documentul #%d ?';

  cMSG_OPENDOC_TITLE = 'Deschide';
  cMSG_OPENDOC_TEXT = 'Doriti sa deschideti documentul #%d ?';

  cMSG_DELETERECORD_КАССА_Приходный_кассовый_ордер = 'Sterge Dispozitia de incasare prin casa #%d?';
  cMSG_DELETERECORD_КАССА_Расходный_кассовый_ордер = 'Sterge dispozitia de plata prin casa #%d?';
  cMSG_DELETERECORD_КАССА_Начальное_сальдо = 'Sterge documentul "Sold Initial" #%d?';
  cMSG_DELETERECORD_БАНК_БППЛ = 'Sterge dispozitie de plata bancara #%d?';
  cMSG_DELETERECORD_БАНК_БППВ = 'Sterge dispozitie de plata bancara #%d?';
  cMSG_DELETERECORD_БАНК_ПДНС = 'Sterge dispozitie de incasare bancara #%d?';
  cMSG_DELETERECORD_БАНК_ПДНСИК = 'Sterge dispozitia de incasare bancara din casa #%d?';
  cMSG_DELETERECORD_Конфигуратор = 'Sterge "Oferta" #%d?';
  cMSG_DELETERECORD_46 = 'Sterge document calculul salariului #%d?';
  cMSG_DELETERECORD_DeleteCustomer = 'Sterge client';
  cMSG_DELETERECORD_DeleteCustomer46 = 'Doriti sa stergeti inregistrarea despre salariu pentru #%s?';
  cMSG_DELETERECORD_WebZakaz = 'Sterge Web-Order #%d?';
  cMSG_DELETERECORD_WebZaiavkaCredit = 'Sterge cererea de Finantare #%d?';
  cMSG_DELETERECORD_48 = 'Sterge calculul comisionului #%d?';
  cMSG_DELETERECORD_50 = 'Sterge "Trecerea in cont a realizarii de produse" #%d?';
  cMSG_DELETERECORD_53 = 'Sterge "Registru transfer de documente" %d?';
  cMSG_DELETERECORD_60 = 'Sterge "Pre-Comenzi" #%d?';
  cMSG_DELETERECORD_61 = 'Sterge "Soldul de bani in cont" #%d?';
  cMSG_DELETERECORD_62 = 'Sterge "Contractul" #%d?';

  cMSG_CONFIRMATION_DoNotAskAgain = 'Nu mai intreba';

  cMSG_LOGIN_БАНК_InvalifCurrency_Title = 'Valuta incorecta';
  cMSG_LOGIN_БАНК_InvalifCurrency_Text = 'Pentru aceasta operatiune utilizati doar valuta externa.';

  cMSG_DIALOG_DOCUMENT_New = 'Creare document nou';
  cMSG_DIALOG_DOCUMENT_Edit = 'Modificare document #%d';
  cMSG_DIALOG_DOCUMENT_ViewOnly = 'Vizualizare document #%d';
  cMSG_DIALOG_GOODS_ViewOnly = 'Vizualizare Produs #%d';
  cCOLOR_DocReadOnly = $00D1D1EB; // $00C9DAE9;
  cMSG_ButtonClose = 'Inchide';
  cMSG_DIALOG_VIEWONLY_Serials = 'Vizualizare numere de serie';
  cMSG_DIALOG_VIEWONLY_Parts = 'Vizualizare numere de partida';

  cMSG_DELETERECORD_КОНФИГУРАЦИИ_Быстрый_расчет_конфигурации = 'Sterge din oferta' + sLineBreak + '%s?';
  cMSG_DELETERECORD_КОНФИГУРАЦИИ_Быстрый_расчет_конфигурации2 = 'Sterge din complect' + sLineBreak + '%s?';
  cMSG_DELETERECORD_KitTemplate_DeleteTemplate = 'Sterge template "%s" ?';
  cMSG_DELETERECORD_KitTemplate_DeleteItem = 'Sterge din template' + sLineBreak + '%s?';
  cMSG_DELETERECORD_РасходнаяНакладная = 'Sterge din documentul "Vinzare"' + sLineBreak + '%s?';
  cMSG_DELETERECORD_РасходнаяНакладная_Комплект = 'Sterge din complect' + sLineBreak + '%s?';

  cMSG_SEARCH_EmptyError_Title = 'Lipseste criteriul de cautare';
  cMSG_SEARCH_EmptyError_Text = 'Introducerti cuvintele cheie si criteriul de cautare.';
  cMSG_ACCESS_DENIED = 'Access inchis';
  cMSG_ACCESS_DENIED_MSG_CASSA = 'Documentul este inchis!';


  // Fiscal Printer defaults
  cFISCAL_PRINTER_DefaultCOMport = 3;
  cFISCAL_PRINTER_DefaultBoundRate = 115200;

  cFISCAL_PRINTER_DefaultCOMportV2 = 'COM3';
  cFISCAL_PRINTER_DefaultBoundRateV2 = 115200;

  cFISCAL_PRINTER_MaxMinutesDifferenceAllowed = 5;
  // max minute diferenta intre vremea de la printer si computer
  cFISCAL_PRINTER_DefaultGoodsTitle = 'ECHIPAMENT TEHNIC';

  cINCIDENT_Priority: array [0 .. 4] of String = ('Normal', 'Mediu',
    'Inalt', 'VIP', 'URGENT');

  // Serial numbers
  cMSG_SN_CountIsOk = 'Cantitatea de serii coincide!';
  cMSG_SN_CountIsLess = 'Nu sunt indicate toate seriile!';
  cMSG_SN_CountIsBigger = 'Prea multe numere de serii au fost alese!';

  // Part numbers
  cMSG_PARTNO_CountIsOk = 'Cantitatea in numere de partide corespunde!';
  cCOLOR_PARTNO_CountIsOk = clGreen;
  cMSG_PARTNO_CountIsLess = 'Nu sunt indicate toate numerile de partida!';
  cCOLOR_PARTNO_CountIsLess = $000070DF;
  cMSG_PARTNO_CountIsBigger = 'Prea multe numere de partida au fost selectate!';
  cCOLOR_PARTNO_CountIsBigger = clRed;

  // Sound
  cSOUND_DefaultAudio = 'SYSTEMEXCLAMATION'; // SYSTEMHAND
  cSOUND_DefaultAudioTitle = '[Exclamare]';

  cSOUND_SYSTEMHAND = 'SYSTEMHAND';

  cSOUND_РасходнаяНакладная = 'SOUND_rashod';
  cSOUND_НарядНаСборку = 'SOUND_sborka';
  cSOUND_WebZakaz = 'sheep.wav';

  // Grid colors
  cGRID_COLOR_ROW = $00E8E8E8;

  // Web Actiunui - Culor de fondal
//  cWebActiuniColorCount = 12;
//  cWebActiuniColors: array [0 .. cWebActiuniColorCount - 1] of TColor =
//    ($005500DD, $00802F04, $000033FF, $000033CC, $00020163, $000000FF,
//    $00D39822, $0000A000, $004EC24E, $0001DEFE, clBlack, clWhite);

  ResponsableContentUserID = 497;  // Gheorghian Olga

implementation

end.
