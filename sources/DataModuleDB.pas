unit DataModuleDB;

interface

uses
    SysUtils, Classes, DBAccess, IBC, SWNSecurity, MemDS, IBCSQLMonitor, //madExcept,
    MemData, SWNUtils, Vcl.ExtCtrls, tlhelp32, Winapi.Windows, Variants,
    SWNDataFiltering, cxGridDBTableView, System.Notification, DASQLMonitor,
    Data.DB, cxGridTableView, IdBaseComponent, IdComponent, IdTCPConnection,
    IdTCPClient, IdHTTP, cxClasses, cxSchedulerStorage, cxSchedulerDBStorage,
  TelegramBot;

const
    cUPDATE_UpdaterFileName = 'SWNUpdater.exe';

type
    TGoodsInfo = class
        GoodsID: Integer;
        Title: string;
        Code: string;
        Details: string;
    end;

    TFirmaInfo = class
        FirmaID: Integer;
        FirmaName: string;
        VAT: Integer;
        FiscalCode: string;
        VATCode: string;
        CustomerTypeID: Integer;
    end;

    TFilterParamsList = class
        NewFilterID: Integer;
        FilterParamID: Integer;
        FilterParamName: string;
    end;

    TMergeGoodsList = class
        GoodsID: Integer;
        GoodsName: string;
        VendorName: string;
        TipEvidenta: string;
    end;

    TGoodsInfo_VendorAndCountry = class
    private
    { private declarations }
        fCountryID: Integer;
        fVendorID: Integer;
        FCountryTitle: string;
        FVendorTitle: string;
        procedure SetCountryID(const Value: Integer);
        procedure SetCountryTitle(const Value: string);
        procedure SetVendorID(const Value: Integer);
        procedure SetVendorTitle(const Value: string);
    protected
    { protected declarations }
    public
    { public declarations }
        property VendorID: Integer read fVendorID write SetVendorID;
        property VendorTitle: string read FVendorTitle write SetVendorTitle;
        property CountryID: Integer read fCountryID write SetCountryID;
        property CountryTitle: string read FCountryTitle write SetCountryTitle;
    end;

    TGoodsFolderProperty = (gfpGOODSDELIVERYTYPE);

    TGoodsFolderProperties = set of TGoodsFolderProperty;

    TDocumentAdditionalFlag = (dafFLG_ACNT_DISABLED);

    TDocumentAdditionalFlags = set of TDocumentAdditionalFlag;

    TNomenclatorRecordState = (nsAppend, nsEdit, nsInsert);

    TNomenclatorRecordStates = set of TNomenclatorRecordState;

    TdmDB = class(TDataModule)
        IBCTrDefaultUpdate: TIBCTransaction;
        IBCConnection: TIBCConnection;
        IBCTrDefaultSelect: TIBCTransaction;
        IBCQueryTemp: TIBCQuery;
        IBCQuerySchedulerEvents: TIBCQuery;
        IBCQuerySchedulerResources: TIBCQuery;
        IBCDataSourceSchedulerEvents: TIBCDataSource;
        IBCDataSourceSchedulerResources: TIBCDataSource;
        IBCDataSourceDocs: TIBCDataSource;
        IBCQueryFirms: TIBCQuery;
        IBCDataSourceFirms: TIBCDataSource;
        IBCQueryCustomers: TIBCQuery;
        IBCDataSourceCustomers: TIBCDataSource;
        IBCQueryCurrency: TIBCQuery;
        IBCDataSourceCurrency: TIBCDataSource;
        IBCQueryAnalitica: TIBCQuery;
        IBCDataSourceAnalitica: TIBCDataSource;
        IBCQueryStocks: TIBCQuery;
        IBCDataSourceStocks: TIBCDataSource;
        IBCQueryJurnal: TIBCQuery;
        IBCDataSourceJurnal: TIBCDataSource;
        TrSchedulerUpdate: TIBCTransaction;
        IBCQueryAnalytics: TIBCQuery;
        IBCDataSourceAnalytics: TIBCDataSource;
        IBCQueryDocComments: TIBCQuery;
        IBCDataSourceDocComments: TIBCDataSource;
        IBCQueryDocTypeStates: TIBCQuery;
        IBCDataSourceDocTypeStates: TIBCDataSource;
        Timer1: TTimer;
        IBCDataSourceIncidente: TIBCDataSource;
        IBCQueryIncidente: TIBCQuery;
        IBCDS_INCIDENTE_BLOB: TIBCDataSource;
        IBC_INCIDENTE_BLOB: TIBCQuery;
        IBCDataSourceSchedulerDelivery: TIBCDataSource;
        IBCQuerySchedulerDelivery: TIBCQuery;
        TrSchedulerDeliveryUpdate: TIBCTransaction;
        IBCSQLMonitor1: TIBCSQLMonitor;
        IBCQuerySYSSList: TIBCQuery;
        IBCDataSourceSYSSList: TIBCDataSource;
        IBCQueryOportunitati: TIBCQuery;
        IBCDataSourceOportunitati: TIBCDataSource;
        NotificationCenter: TNotificationCenter;
        IBCQueryDocs: TIBCQuery;
        IdHTTP1: TIdHTTP;
    cxSchedulerDBStorageDelivery: TcxSchedulerDBStorage;
    cxSchedulerDBStorage: TcxSchedulerDBStorage;
    IBCQueryAchizitii: TIBCQuery;
    IBCDataSourceAchizitii: TIBCDataSource;
        procedure DataModuleCreate(Sender: TObject);
        procedure DataModuleDestroy(Sender: TObject);
        procedure IBCQueryJurnalAfterPost(DataSet: TDataSet);
        procedure IBCQueryJurnalAfterDelete(DataSet: TDataSet);
        procedure IBCConnectionConnectionLost(Sender: TObject; Component: TComponent; ConnLostCause: TConnLostCause; var RetryMode: TRetryMode);
        procedure IBCQueryDocsAfterPost(DataSet: TDataSet);
        procedure Timer1Timer(Sender: TObject);
        procedure IBCQuerySchedulerDeliveryAfterPost(DataSet: TDataSet);
        procedure IBCQuerySchedulerEventsAfterPost(DataSet: TDataSet);
        procedure IBCQueryDocsBeforeUpdateExecute(Sender: TDataSet; StatementTypes: TStatementTypes; Params: TDAParams);
        procedure SendSWNMail(mailto, mailsubject, mailbody: string);
    private
    { Private declarations }
        fCurrentFirma: Integer; // DT
        FCurrentDocTypeID: Integer;
        fIsCassaClosed: Boolean;
        FCurrentFirmaName: string;
        fDBConnected: Boolean;
        FReconnecting: Boolean;
        fCollabmanFullPathFileName, fCollabman2FullPathFileName: WideString;
        procedure ConnectToDB;
        procedure SetupVars;
        function getDBServer: string;
        function GetCurrentUserID: Integer;
        procedure SetDocsFilter(const ExternalDataSources: TFrameExternalDataSourceSet; const FrameDataFilterInfo: TFrameDataFilteringInfo);
        procedure SetDocsFilter_PrepareSQL(const FrameDataFilterInfo: TFrameDataFilteringInfo);
        procedure SetDocsFilter_PrepareParams(const FrameDataFilterInfo: TFrameDataFilteringInfo);
        procedure CloseDocsDataSources(const ExternalDataSources: TFrameExternalDataSourceSet);
        procedure PrepareSearchHelper_Goods(const FrameDataFilterInfo: TFrameDataFilteringInfo);
        procedure SetIncidenteFilter(const ExternalDataSources: TFrameExternalDataSourceSet; const FrameDataFilterInfo: TFrameDataFilteringInfo);
        procedure SetIncidenteFilter_PrepareSQL(const FrameDataFilterInfo: TFrameDataFilteringInfo);
        procedure SetIncidenteFilter_PrepareParams(const FrameDataFilterInfo: TFrameDataFilteringInfo);
        procedure CloseIncidenteDataSources(const ExternalDataSources: TFrameExternalDataSourceSet);
        procedure ChangeCurrentDB(const DT: Integer);
        procedure ReadDBConfigFromDB;
        procedure CreateUserConfigStorage(const UserID: Integer);
        function GetCurrentUserFullName: string;
        function GetDBAlias: string;
        procedure WhenCommitSchedulerDelivery(Sender: TObject);
        procedure WhenCommitSchedulerEvents(Sender: TObject);
        function CanRunTimer: Boolean;

    // collabman
        procedure CollabmanInitDownloadSQL(const Query: TIBCQuery);
        procedure CollabmanSQLExecuted(const Query: TIBCQuery);
        procedure SetOportunitatiFilter(const ExternalDataSources: TFrameExternalDataSourceSet; const FrameDataFilterInfo: TFrameDataFilteringInfo);
        procedure SetOportunitatiFilter_PrepareParams(const FrameDataFilterInfo: TFrameDataFilteringInfo);
        procedure TrimiteNotificareComanda(OrderID: Integer);
    protected
        procedure GetFirmaInfo(FirmaID: Integer);
        procedure SetOportunitatiFilter_PrepareSQL(const FrameDataFilterInfo: TFrameDataFilteringInfo);
    public
        CountryID: Integer;
        CountryName: string;
        FirmaInfo: TFirmaInfo;
        sipFurnitureSalesFontColor: Integer;
        sipFurnitureSalesBGColor: Integer;
        sipITSalesBGColor: Integer;
        sipITSalesFontColor: Integer;
        sipAccountingBGColor: Integer;
        sipAccountingFontColor: Integer;
        sipPurchaiseBGColor: Integer;
        sipPurchaiseFontColor: Integer;
        sipServiceBGColor: Integer;
        sipServiceFontColor: Integer;
    { Public declarations }
        tmpQuery: TIBCQuery;
        AccentGuid: string;
        function TryConnect(out ErrorMessage: string): Boolean;
        function GetCurrencyExchangeValue(const CurrencyID: Integer; const ThroughAccount: Boolean; const BNMRate: Boolean = False): Double;
        function TransformCurrency1(const SUMA: Currency; const InitialCurrencyID, FinalCurrencyID: Integer; const ThroughACNT: Boolean; var TransformedSUMA: Currency; var ExchangeRate: Double; const Silent, GetPriceForGoods: Boolean; const DoNotRound: Boolean = False): Boolean;
        function TransformCurrency2(const DocID: Integer; const SUMA: Currency; const InitialCurrencyID, FinalCurrencyID: Integer; const ThroughACNT: Boolean; var TransformedSUMA: Currency; var ExchangeRate: Double; const Silent, GetPriceForGoods: Boolean; const DoNotRound: Boolean = False): Boolean;
        function GetDocumentProtectedUser(const DocID: Integer; var UserName: string): Integer;
        function CheckIfShutdownIsForDefaultDT: Boolean;
        function CheckIfGoodsAreValidForReceipt(const DocID: Integer): Boolean;
        function IsCustomerPersoanaJuridica(const CustomerTypeID: Integer): Boolean; overload;
        function IsCustomerPersoanaJuridica(const DocID: Integer; const CustomerType: string): Boolean; overload;
        procedure RefreshDocs;
        procedure RefreshJurnal;
        procedure FullRefresh;
        function GetCustomerDisplayName(const CustomerID: Variant): string;
        function GetGoodsAcntDisplayName(const GoodsAcntID: Integer): string;
        function GetCustomerPriceColumn(const CustomerID: Integer): Integer;
        function GetCustomerVAT(const CustomerID: Integer): Integer;
        function GetGoodsInfo(const GoodsID: Integer): TGoodsInfo;
        function LoadDocumentDefaults(const DocTypeID, Firma: Integer; const DataSet: TIBCQuery; var AdditionalFlags: TDocumentAdditionalFlags): Boolean;
        function GetServerCurrentTime: TDateTime;
        function CloneDocumentDB(const SourceDocID: Integer; out NewDocID: Integer; FLG_CLONE_ITEMS: Integer = 1; FLG_CLONE_DATE: Integer = 0): Boolean;
        function DocumentHasComplecte(const DocID: Integer): Boolean;
        function GetGoodsInfo_SN_VendorCountry(const GoodsID: Integer): TGoodsInfo_VendorAndCountry;
        function GetGoodsInfo_PARTS_VendorCountry(const GoodsID: Integer): TGoodsInfo_VendorAndCountry;
        function GetSyssTitleByID(const SyssID: Integer): string;
        procedure DoActionDB_SP_Expenses2Jurnal(const DocID: Integer);
        function GetGoodsForeignKey(AGoodsID: Integer): string;

    // Creare "Nakladnaia de iesire"
        function CreateRashodnaiaNakladnaia_DB(const DocID: Integer): Integer;

    // Creare "Nakladnaia de iesire in service"
        function CreateRashodnaiaNakladnaiaServis_DB(const DocID: Integer): Boolean;

    // Creare "Naryad de asamblare" din Configurator
        function CreateNariadNaSborkuIzConfiguratora_DB(const DocID, RashodDocID, CustomFirmaID: Integer): Boolean;

    // Creare "Naryad de asamblare" din Iesire, Factura de plata (nu din Configurator).
        function CreateNariadNaSborku_Other_DB(const CustomDocID: Integer): Boolean;

    // Creare "Factura de plata"
        function CreateProforma(const DocID: Integer): Boolean;

    // Creare "Incasare bani in cont"
        function CreateProhodDenegNaSciot(const DocID, CurrencyID, FLG_ACNT: Integer; const RATE: Double; const SUMA: Currency; SC2: Integer = -1): Boolean;
        function CreateProhodDenegNaSciotMAIN(const DocID, CurrencyID, FLG_ACNT: Integer; const RATE: Double; const SUMA: Currency): Boolean;

    // Creare "Dispozitie de incasare"
        function CreatePrihodniiKasoviiOrder(const DocID, CurrencyID, FLG_ACNT: Integer; const RATE: Double; const SUMA: Currency; CashReceiptAnalitics: integer): Boolean;

    // Creare "Dispozitie de plata"
        function CreateRashodniiKasoviiOrder(const DocID, CurrencyID, FLG_ACNT: Integer; const RATE: Double; const SUMA: Currency): Boolean;
        function CreateConfiguratorDoc_DB(const DocID: Integer; const CustomUserID: Integer = -1; const CustomComments: string = ''): Integer;

    // Ordin de plata bancar
        function CreateBPP(const DocID: Integer; const SUMA: Currency): Boolean;

    // Creare, anuleaza "Inregistrarea" pentru Incasare bani in cont (4), Incasare bani in cont (din casa) (5), Ordine de plata bancare, Lei (6), Ordine de plata bancare, Valuta (7)
        function CreateDocumentProvodka(const DocID: Integer): Boolean;
        function CancelDocumentProvodka(const DocID: Integer): Boolean;
        procedure CreateGridImageColumnItems(const ImageColumn: TcxGridDBColumn; const AddFolderImage: Boolean = False);
        function GetImageIndexByGoodsTypeID(const GoodsTypeID: Integer): Integer;
        procedure OpenAnalyticsDataSource(const CustomDocTypeID: Integer = -1);
        function GetDocumentParentInfo(const DocID: Integer; var DT, ParentDocID, TabSheetIndex: Integer; var DocData: TDateTime): Boolean;
        function GetDocumentGotoInfo(const DocID: Integer; var DT, TabSheetIndex: Integer; var DocData: TDateTime): Boolean;
        function GetContractInfo(const ContractID: Integer; var DT, TabSheetIndex: Integer; var ContractData: TDateTime): Boolean;
        function GetIncidentInfo(const IncidentID: Integer; var DT, TabSheetIndex: Integer; var IncidentData: TDateTime): Boolean;
        function GetInvoiceGotoInfo(const InvoiceID: Integer; var DocID, DT, TabSheetIndex: Integer; var InvoiceData: TDateTime): Boolean;
        function GetUserName(const UserID: Integer): string;
        function CheckIfCustomerIsEmployer(const CustomerID: Integer): Boolean;
        procedure ShowCustomerDebts(ACustomerID: Integer);
        procedure ExecuteQuery(AStmt: string; const Params: array of const);
        procedure OpenQuery(var Query: TIBCQuery; AStmt: string; const Params: array of const);
        function GetDefaultReportForReportGroup(const ReportGroupCode: string): Integer;

    // Modifica pretul produselor din document
        function UpdateJurnalGoodsPricesByColumn(const DocID, DTDep, CTDep, GoodsParentID, ColumnID: Integer; const ComplectName: string = ''; const ComplectGoodsCount: Integer = 0): Boolean;
        property DBServer: string read getDBServer;
        property DBAlias: string read GetDBAlias;
        property CurrentUserID: Integer read GetCurrentUserID;
        property CurrentFirma: Integer read fCurrentFirma;
        property CurrentFirmaName: string read FCurrentFirmaName;
        property CurrentUserFullName: string read GetCurrentUserFullName;
        property CurrentDocTypeID: Integer read FCurrentDocTypeID;
        procedure SetCurrentDocTypeID(const NewDocTypeID: Integer);
        property IsCassaClosed: Boolean read fIsCassaClosed;
        property DBConnected: Boolean read fDBConnected;
        procedure AddCallReminder(ADocID: Integer; ACustomerName, ACustomerPhone: string);
        procedure ChangeCurrentFirma(const NewFirmaID: Integer; const NewFirmaTitle: string);
        procedure OpenExternalData(const ExternalDataSources: TFrameExternalDataSourceSet; const FrameDataFilterInfo: TFrameDataFilteringInfo);
        procedure CloseExternalData(const ExternalDataSources: TFrameExternalDataSourceSet);
        procedure RefreshExternalData(const ExternalDataSources: TFrameExternalDataSourceSet);
        function LocateExternalDataDoc(const ExternalDataSources: TFrameExternalDataSourceSet; const DocumentID: Integer): Boolean;
        procedure LocateOnLastRecord(const ExternalDataSources: TFrameExternalDataSourceSet);
        function IsKit(GoodsTypeID: Integer): Boolean;
        function DoCreateFactura(const DocID: Integer): Boolean;
        function ConvertAmountByCurrency(OldCurrency, NewCurrency: Integer; Amount: Double): Double;
        function DoCreateShipmentDB(const DocID: Integer; const ActiuneList: string): Boolean;
        function GetBlobSize(BlobField: TBlobField): Integer;
        function ProcessClipboardKeys(const Grid: TcxGridDBTableView; var Key: Word; Shift: TShiftState): Boolean;
        function GetLocalIP: string;
        procedure ShowNotification;
        procedure CopyGridCellTextToClipboard(const Grid: TcxGridTableView);

        function GetOrgID(ADT: Integer): Integer;
        procedure LoadSipColors;
        function IsDecimalInteger(const S: string): Boolean;
        procedure DoNotification(aName, aTitle, aBody: string);
        procedure AppendCurrentRecord(Dataset: TDataSet);
        procedure QueryCancelUpdate(DataSet: TIBCQuery);
        procedure LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime; var ContractID: Integer; var ContractName: string; var FlgAcnt: Boolean; var ContractCurrencyID: Integer);
        function GetDefaultDocumentState(ADocTypeID: Integer): integer;
        function CreateNewGoods(ParentID: Integer; GoodsName: string; GoodstypeID, WebTypeID: Integer; SupplierGoodsCode: string; VendorID, SupplierID: Integer; Model, BaseParam: string; Price3: Double; Currency3ID: Integer; Price7: Double; Currency7ID: Integer; AFlgRRP: integer; GoodsTypeName: string = ''): Integer;
// TODO: GetAccentGUID
//      function GetAccentGUID: string;
        function CheckCurrentGUID: string;
        function CreateTender(const DocID: Integer): Boolean;
        function CalcNextPartNo(DefaultPartno: string; AGoodsID: integer): integer;
        function SendSMS(const PhoneNumber, SMSText: string): Boolean;
        function GetCurrencyRate(ACurrencyID: integer): double;
        procedure GetSupplierGoodsByDocID;
        procedure SaveCurrentUID(AGUID: string);
        function GetCurrentUID: string;
// TODO: EnsureUID
//      function EnsureUID: string;

        function TryGetTodayGuidFromTable(out AGuid: string): Boolean;
        procedure UpsertTodayGuidToTable(const AGuid: string);
// TODO: EnsureTodayGuid
//      function EnsureTodayGuid(const AAuthService: IAccentAuthService): string;
        procedure AddToAchizitii(GoodsID, Qty, SupplierID: Integer);
    end;

procedure SetConnectionParams(const UserID: Integer; const DatabaseAlias, ServerAddress: string; const ServerPort: Integer; const HasSecurityConfirmation: Boolean);

var
    dmDB: TdmDB;

implementation

uses
  Controls, DataModuleAdditions, FiscalPrinterUtilsUnit, SQLThread, SWNConst, SWNDBErrors, SWNTypes, SWNValueStorageUnit, {TelegramBot, }Winsock,
  cxGridCustomTableView, cxImageComboBox, frmAddCallReminderUnit, frmBSToolsCopyGridClipboardDialog,
  frmCustomerCurrentDebtsDialog, frmExchangeRateEditor, shellapi,
  System.JSON,
  Vcl.Clipbrd,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,
  Winapi.MMSystem,
  uThreadInfoForm;

{$R *.dfm}

const
    cCollaborationManagerPath = '';
    cCollaborationManagerFileName = 'collabman.exe';
    cCollaborationManager2FileName = 'collabmanwow64.exe';

type
    PTOKEN_USER = ^TOKEN_USER;

    _TOKEN_USER = record
        User: TSIDAndAttributes;
    end;

    TOKEN_USER = _TOKEN_USER;

var
    fDatabaseAlias: string;
    fLoggingUserID: Integer;
    fDBServerAddress: string;
    fDBServerPort: Integer;
    fDBSecurityConfirmation: Boolean;

procedure ConfigureFormatSettings;
var
    WFormatoBR: TFormatSettings;
begin
    WFormatoBR := TFormatSettings.Create;
    WFormatoBR.DecimalSeparator := '.';
    WFormatoBR.ThousandSeparator := ' ';
    WFormatoBR.CurrencyDecimals := 2;
    WFormatoBR.DateSeparator := '.';
    WFormatoBR.ShortDateFormat := 'dd.mm.yyyy';
    WFormatoBR.LongDateFormat := 'dd.mm.yyyy';
    WFormatoBR.TimeSeparator := ':';
    WFormatoBR.TimeAMString := 'AM';
    WFormatoBR.TimePMString := 'PM';
    WFormatoBR.ShortTimeFormat := 'hh:nn';
    WFormatoBR.LongTimeFormat := 'hh:nn:ss';
    WFormatoBR.CurrencyString := 'R$';
    SysUtils.FormatSettings := WFormatoBR;
end;

procedure SetConnectionParams(const UserID: Integer; const DatabaseAlias, ServerAddress: string; const ServerPort: Integer; const HasSecurityConfirmation: Boolean);
begin
    fDatabaseAlias := DatabaseAlias;
    fLoggingUserID := UserID;
    fDBServerAddress := ServerAddress;
    fDBServerPort := ServerPort;
    fDBSecurityConfirmation := HasSecurityConfirmation;
end;

function GetCurrentWindowsUserName: string;
var
    UserName: array[0..100] of WideChar;
    n: Cardinal;
begin
    n := 100;
    if GetUserName(UserName, n) then
        Result := UserName;
end;

function GetUserAndDomainFromPID(ProcessId: DWORD; var User, Domain: string): Boolean;
var
    hToken: THandle;
    cbBuf: Cardinal;
    ptiUser: PTOKEN_USER;
    snu: SID_NAME_USE;
    ProcessHandle: THandle;
    UserSize, DomainSize: DWORD;
    bSuccess: Boolean;
begin
    Result := False;
    ProcessHandle := OpenProcess(PROCESS_QUERY_INFORMATION, False, ProcessId);
    if ProcessHandle <> 0 then
    begin
    // EnableProcessPrivilege(ProcessHandle, 'SeSecurityPrivilege', True);
        if OpenProcessToken(ProcessHandle, TOKEN_QUERY, hToken) then
        begin
            bSuccess := GetTokenInformation(hToken, TokenUser, nil, 0, cbBuf);
            ptiUser := nil;
            while (not bSuccess) and (GetLastError = ERROR_INSUFFICIENT_BUFFER) do
            begin
                ReallocMem(ptiUser, cbBuf);
                bSuccess := GetTokenInformation(hToken, TokenUser, ptiUser, cbBuf, cbBuf);
            end;
            CloseHandle(hToken);

            if not bSuccess then
            begin
                Exit;
            end;

            UserSize := 0;
            DomainSize := 0;
            LookupAccountSid(nil, ptiUser.User.Sid, nil, UserSize, nil, DomainSize, snu);
            if (UserSize <> 0) and (DomainSize <> 0) then
            begin
                SetLength(User, UserSize);
                SetLength(Domain, DomainSize);
                if LookupAccountSid(nil, ptiUser.User.Sid, PChar(User), UserSize, PChar(Domain), DomainSize, snu) then
                begin
                    Result := True;
                    User := StrPas(PChar(User));
                    Domain := StrPas(PChar(Domain));
                end;
            end;

            if bSuccess then
            begin
                FreeMem(ptiUser);
            end;
        end;

        CloseHandle(ProcessHandle);
    end;
end;

function WindowsProcessExists(const ProcessExeName: string): Boolean;
var
    ContinueLoop: BOOL;
    FSnapshotHandle: THandle;
    FProcessEntry32: TProcessEntry32;
    CurrUserName: string;
    processUser, processDomain: string;
begin
  // check if process exists only in current user session
    CurrUserName := GetCurrentWindowsUserName;

    Result := False;
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    try
        FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
        ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
        while Integer(ContinueLoop) <> 0 do
        begin
            if GetUserAndDomainFromPID(FProcessEntry32.th32ProcessID, processUser, processDomain) then
            begin
                if SameText(processUser, CurrUserName) then
                begin
                    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = ProcessExeName) or (UpperCase(FProcessEntry32.szExeFile) = ProcessExeName)) then
                    begin
                        Result := True;
                        Break;
                    end;
                end;
            end;
            ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
        end;
    finally
        CloseHandle(FSnapshotHandle);
    end;
end;

procedure TdmDB.AddCallReminder(ADocID: Integer; ACustomerName, ACustomerPhone: string);
var
    dialog: TAddCallReminderDlg;
begin
    dialog := TAddCallReminderDlg.Create(Self);
    try
        dialog.DocID := ADocID;
        dialog.CustomerName := ACustomerName;
        dialog.CustomerPhone := ACustomerPhone;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

function TdmDB.CancelDocumentProvodka(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CANCEL_DOC_PROVODCA(:docID)';
        Query.ParamByName('docID').AsInteger := DocID;
        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.CanRunTimer: Boolean;
begin
    Result := (fLoggingUserID <> 1) and (fLoggingUserID <> 7) and (fLoggingUserID <> 0) and (UpperCase(fDatabaseAlias) = 'SW');
end;

procedure TdmDB.ChangeCurrentDB(const DT: Integer);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;

        Query.SQL.Text := 'execute procedure PROC_USER_SET_DT(:DT)';
        Query.ParamByName('DT').AsInteger := DT;
        Query.ExecSQL;

        Query.Transaction.Commit;
        SWNSecurityManager.FirmaID := DT;
        fCurrentFirma := DT;
    finally
        Query.Free;
    end;
  // aici intentionat nu punem EXCEPT, aceasta operatie trebuie sa mearga 100%
end;

procedure TdmDB.ChangeCurrentFirma(const NewFirmaID: Integer; const NewFirmaTitle: string);
begin
    if NewFirmaID <> fCurrentFirma then
    begin
        ChangeCurrentDB(NewFirmaID);
        fCurrentFirma := NewFirmaID;
        FCurrentFirmaName := NewFirmaTitle;
        GetFirmaInfo(NewFirmaID);

        // calculatorul se inregistreaza singur, ca sa poata fi ales in "Acces la MCC"
        RegisterCurrentWorkStation(NewFirmaID);
    end;
end;

function TdmDB.CheckIfShutdownIsForDefaultDT: Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT DT FROM TSS_DBLOCKS WHERE DT=:DT';
        Query.ParamByName('DT').AsInteger := SWNSecurityManager.LoggedUser.DefaultFirma;
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].AsInteger = SWNSecurityManager.LoggedUser.DefaultFirma;
    finally
        Query.Free;
    end;
end;

function TdmDB.CloneDocumentDB(const SourceDocID: Integer; out NewDocID: Integer; FLG_CLONE_ITEMS: Integer = 1; FLG_CLONE_DATE: Integer = 0): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'SELECT NEWDOCID FROM SP_CLONE_DOCUMENT(:DOCID, NULL, :FLG_CLONE_ITEMS, :FLG_CLONE_DATE)';
        Query.ParamByName('DOCID').AsInteger := SourceDocID;
        Query.ParamByName('FLG_CLONE_ITEMS').AsInteger := FLG_CLONE_ITEMS;
        Query.ParamByName('FLG_CLONE_DATE').AsInteger := FLG_CLONE_DATE;

        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            if not Query.Eof then
                NewDocID := Query.Fields[0].AsInteger;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TdmDB.CloseDocsDataSources(const ExternalDataSources: TFrameExternalDataSourceSet);
begin
    IBCQueryDocComments.Close;
    if (fedsJurnal in ExternalDataSources) then
        IBCQueryJurnal.Close;
    IBCQueryDocs.Close;
end;

procedure TdmDB.CloseExternalData(const ExternalDataSources: TFrameExternalDataSourceSet);
begin
  // inchide sursele de date indicate
    if (fedsDocs in ExternalDataSources) then
        CloseDocsDataSources(ExternalDataSources);
    if (fedsIncidente in ExternalDataSources) then
        CloseIncidenteDataSources(ExternalDataSources);
end;

procedure TdmDB.CloseIncidenteDataSources(const ExternalDataSources: TFrameExternalDataSourceSet);
begin
    IBCQueryIncidente.Close;
end;

function TdmDB.DocumentHasComplecte(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
  // verifica daca documentul indicat are complecte
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.SQL.Text := 'SELECT FEXISTS FROM SP_DOCUMENT_HAVE_COMPLECT(:DOCID)';
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].AsInteger > 0;
        Query.Close;
    finally
        Query.Free;
    end;
end;

procedure TdmDB.ExecuteQuery(AStmt: string; const Params: array of const);
var
    I: Integer;
    Query: TIBCQuery;
    InTransaction: Boolean;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := AStmt;
        for I := Low(Params) to High(Params) do
        begin
            case Params[I].VType of
                vtInteger:
                    Query.Params[I].AsInteger := Params[I].VInteger;
                vtChar:
                    Query.Params[I].AsString := string(Params[I].VString^);
                vtBoolean:
                    Query.Params[I].AsBoolean := Params[I].VBoolean;
                vtExtended:
                    Query.Params[I].AsFloat := Params[I].VExtended^;
                vtString:
                    Query.Params[I].AsString := string(Params[I].VString^);
                vtAnsiString:
                    Query.Params[I].AsAnsiString := PAnsiChar(Params[I].VAnsiString);
                vtCurrency:
                    Query.Params[I].AsCurrency := Params[I].VCurrency^;
                vtVariant:
                    Query.Params[I].Value := Params[I].VVariant^;
                vtWideString:
                    Query.Params[I].AsWideString := WideString(Params[I].VWideString);
            end;
        end;

        InTransaction := True;
        if not Query.Transaction.Active then
        begin
            InTransaction := False;
            Query.Transaction.StartTransaction;
        end;
        try
            Query.ExecSQL;

            if not InTransaction then
                Query.Transaction.Commit;

        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TdmDB.OpenQuery(var Query: TIBCQuery; AStmt: string; const Params: array of const);
var
    i: Integer;
begin
    Query.SQL.Text := AStmt;
    for i := Low(Params) to High(Params) do
    begin
        case Params[i].vType of
            vtInteger:
                Query.Params[i].AsInteger := Params[i].VInteger;
            vtInt64:
                Query.Params[i].AsInteger := Params[i].VInt64^;
            vtBoolean:
                Query.Params[i].AsBoolean := Params[i].VBoolean;
            vtExtended:
                Query.Params[i].AsFloat := Params[i].VExtended^;
            vtString:
                Query.Params[i].AsString := string(Params[i].VString^);
            vtAnsiString:
                Query.Params[i].AsAnsiString := AnsiString(PChar(Params[i].VAnsiString));
            vtCurrency:
                Query.Params[i].AsCurrency := Params[i].VCurrency^;
            vtVariant:
                Query.Params[i].Value := Params[i].VVariant^;
            vtWideString:
                Query.Params[i].AsWideString := WideString(Params[i].VWideString);
        end;
    end;

    try
        Query.Open;
    except
        on E: Exception do
        begin
            if not ProcessSWNError(E) then
                raise;
        end;
    end;
end;

function TdmDB.CheckIfCustomerIsEmployer(const CustomerID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    if (SWNSecurityManager.LoggedUser.UserID = 204) or (SWNSecurityManager.LoggedUser.UserID = 196) then
        Exit;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.SQL.Text := 'SELECT CUSTOMER_TYPE_ID FROM TS_CUSTOMER WHERE CUSTOMERID=:CustomerID';
        Query.ParamByName('CustomerID').AsInteger := CustomerID;
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].AsInteger = 4006; // only for "angajat"
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.CheckIfGoodsAreValidForReceipt(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
    // veridic daca nu sunt produse cu cod contabilitate =-1, produse care nu sunt definite in nomenclatorul denumirilor de facturi
        Query.Connection := dmDB.IBCConnection;
        Query.SQL.Text := 'SELECT COUNT(TDB_JURNAL.GOODSID) FROM TDB_JURNAL ' + 'INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID=TDB_JURNAL.GOODSID) ' + 'INNER JOIN TS_GOODS_ACNT ON (TS_GOODS_ACNT.GOODS_ACNT_ID=TS_GOODS.GOODS_ACNT_ID) ' + 'WHERE (TS_GOODS_ACNT.GOODS_ACNT_ID=-1) AND ' + '(TDB_JURNAL.DOCID=:DOCID) AND ' + '(GET_FLG_VALUE(TDB_JURNAL.FLAGS,0)=1)';
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].AsInteger = 0;
    finally
        Query.Free;
    end;
end;

procedure TdmDB.CollabmanInitDownloadSQL(const Query: TIBCQuery);
begin
    Query.SQL.Text := 'SELECT FILEDATA,FILEDATA2 FROM TS_COLLABMAN WHERE ID=1';
end;

procedure TdmDB.CollabmanSQLExecuted(const Query: TIBCQuery);
begin
    try
    // save to file
        TBlobField(Query.Fields[0]).SaveToFile(fCollabmanFullPathFileName);
        TBlobField(Query.Fields[1]).SaveToFile(fCollabman2FullPathFileName);
    // run the file
        ShellExecute(0, 'open', PWideChar(fCollabmanFullPathFileName), nil, nil, SW_HIDE);
    except
    end;
end;

procedure TdmDB.ConnectToDB;
begin
    IBCConnection.Database := Format('%s/%d:%s', [fDBServerAddress, fDBServerPort, fDatabaseAlias]);
    IBCConnection.UserName := cDATABASE_UserLogin_UserName;
    IBCConnection.Password := cDATABASE_UserLogin_UserPassword;
    IBCConnection.Connected := True;

    SWNSecurityManager.LoginUser(fLoggingUserID, fDBSecurityConfirmation);
    SWNSecurityManager.ReadAccRights;

    SWNDatabaseErrors := TSWNDBErrors.Create;
    SWNDatabaseErrors.ReadErrorsFromDB(IBCConnection);

    CreateUserConfigStorage(SWNSecurityManager.UserID);

    fDBConnected := True;
end;

function TdmDB.TryConnect(out ErrorMessage: string): Boolean;
begin
    ErrorMessage := '';
    if fDBConnected then
    begin
        Result := True;
        Exit;
    end;

    try
        ConnectToDB;
        Result := fDBConnected;
        if Result then
            Timer1.Enabled := CanRunTimer
        else
            ErrorMessage := 'Conexiunea la baza de date nu a fost confirmata.';
    except
        on E: Exception do
        begin
            fDBConnected := False;
            Timer1.Enabled := False;
            ErrorMessage := Format('%s: %s', [E.ClassName, E.Message]);
            try
                IBCConnection.Connected := False;
            except
            end;
            Result := False;
        end;
    end;
end;

function TdmDB.CreateConfiguratorDoc_DB(const DocID: Integer; const CustomUserID: Integer; const CustomComments: string): Integer;
var
    Query: TIBCQuery;
begin
    Result := -1;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'SELECT CONFIGDOCID FROM SP_CREATE_CONFIGURATOR(:DOCID,:CU,:CM)';
        Query.ParamByName('DOCID').AsInteger := DocID;
        if (CustomUserID <> -1) then
            Query.ParamByName('CU').AsInteger := CustomUserID;
        if (CustomComments <> '') then
            Query.ParamByName('CM').AsString := CustomComments;

        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            if not Query.Eof then
                Result := Query.Fields[0].AsInteger;

            dmDB.ExecuteQuery('EXECUTE PROCEDURE SP_CLOSE_WEBZAKAZ(:docid, :userid)', [DocID, dmDB.CurrentUserID]);
            Query.Transaction.Commit;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;

    dmDB.IBCQueryDocs.Refresh;
end;

function TdmDB.CreateDocumentProvodka(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_DOC_PROVODCA(:docID)';
        Query.ParamByName('docID').AsInteger := DocID;
        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TdmDB.CreateGridImageColumnItems(const ImageColumn: TcxGridDBColumn; const AddFolderImage: Boolean);
var
    ImageComboBoxProp: TcxImageComboBoxProperties;
    ImageComboBoxItem: TcxImageComboBoxItem;
begin
    if Assigned(ImageColumn.Properties) and (ImageColumn.Properties is TcxImageComboBoxProperties) then
    begin
        ImageComboBoxProp := TcxImageComboBoxProperties(ImageColumn.Properties);
        ImageComboBoxProp.BeginUpdate;
        try
            ImageComboBoxProp.Items.Clear;
            ImageComboBoxProp.Images := dmAdditions.cxImageList_SWN;
      // Goods
            ImageComboBoxProp.DefaultImageIndex := 12;

            if AddFolderImage then
            begin
        // Folder
                ImageComboBoxItem := ImageComboBoxProp.Items.Add;
                ImageComboBoxItem.ImageIndex := 13;
                ImageComboBoxItem.Value := 1;
            end;

      // Serviciu
            ImageComboBoxItem := ImageComboBoxProp.Items.Add;
            ImageComboBoxItem.ImageIndex := 51;
            ImageComboBoxItem.Value := cSYSS_GOODS_TYPE_Услуга;
      // Set
            ImageComboBoxItem := ImageComboBoxProp.Items.Add;
            ImageComboBoxItem.ImageIndex := 44;
            ImageComboBoxItem.Value := cSYSS_GOODS_TYPE_Комплект;
      // Serviciu propriu
            ImageComboBoxItem := ImageComboBoxProp.Items.Add;
            ImageComboBoxItem.ImageIndex := 51;
            ImageComboBoxItem.Value := cSYSS_GOODS_TYPE_Услуга_собственная;
      // Card de discount
            ImageComboBoxItem := ImageComboBoxProp.Items.Add;
            ImageComboBoxItem.ImageIndex := 21;
            ImageComboBoxItem.Value := cSYSS_GOODS_TYPE_Дисконтная_карта;
      // Combustibil
      // Produs pentru service
            ImageComboBoxItem := ImageComboBoxProp.Items.Add;
            ImageComboBoxItem.ImageIndex := 52;
            ImageComboBoxItem.Value := cSYSS_GOODS_TYPE_Товары_для_Сервиса;
      // Nakladnie fiscale
      // Nakladnie de transport
      // Procuri
            ImageComboBoxItem := ImageComboBoxProp.Items.Add;
            ImageComboBoxItem.ImageIndex := 33;
            ImageComboBoxItem.Value := cSYSS_GOODS_TYPE_Доверености;
      // Set de servicii
            ImageComboBoxItem := ImageComboBoxProp.Items.Add;
            ImageComboBoxItem.ImageIndex := 44;
            ImageComboBoxItem.Value := cSYSS_GOODS_TYPE_Комплект_услуг;
      // Discount
            ImageComboBoxItem := ImageComboBoxProp.Items.Add;
            ImageComboBoxItem.ImageIndex := 136;
            ImageComboBoxItem.Value := cSYSS_GOODS_TYPE_Discount;
      // Livrare
            ImageComboBoxItem := ImageComboBoxProp.Items.Add;
            ImageComboBoxItem.ImageIndex := 137;
            ImageComboBoxItem.Value := cSYSS_GOODS_TYPE_Delivery;
        finally
            ImageComboBoxProp.EndUpdate;
        end;
    end;
end;

function TdmDB.CreateNariadNaSborkuIzConfiguratora_DB(const DocID, RashodDocID, CustomFirmaID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := False;
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_SBORKA2(:DOCID,:RASHDOCID,:FIRMA)';
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.ParamByName('RASHDOCID').AsInteger := RashodDocID;
        Query.ParamByName('FIRMA').AsInteger := CustomFirmaID;

        try
            Query.Transaction.StartTransaction;
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                if Query.Transaction.Active then
                    Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.CreateNariadNaSborku_Other_DB(const CustomDocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
  // Creare "Naryad de asamblare" din Iesire, Factura de plata (nu din Configurator).
  // Returns: True daca a fost facut.
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_SBORKA_NON_CONFIGURAT(:DOCID)';
        Query.ParamByName('DOCID').AsInteger := CustomDocID;
        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.CreatePrihodniiKasoviiOrder(const DocID, CurrencyID, FLG_ACNT: Integer; const RATE: Double; const SUMA: Currency; CashReceiptAnalitics: integer): Boolean;
var
    Query: TIBCQuery;
begin
  // Creare "Dispozitie de incasare"
  // Returns: True daca a fost facut.
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_PKO(:DOCID,:CurrencyID,:FLG_ACNT,:Rate,:SUMA, :CashReceiptAnalitics)';
      // set params
            Query.ParamByName('DOCID').AsInteger := DocID;
            Query.ParamByName('CurrencyID').AsInteger := CurrencyID;
            Query.ParamByName('FLG_ACNT').AsInteger := FLG_ACNT;
            Query.ParamByName('Rate').AsFloat := RATE;
            Query.ParamByName('SUMA').AsCurrency := SUMA;
            Query.ParamByName('CashReceiptAnalitics').AsInteger := CashReceiptAnalitics;
      // exec
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.CreateProhodDenegNaSciot(const DocID, CurrencyID, FLG_ACNT: Integer; const RATE: Double; const SUMA: Currency; SC2: Integer = -1): Boolean;
var
    Query: TIBCQuery;
begin
  // Creare "Incasare bani in cont"
  // Returns: True daca a fost facut.
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_PRIHOD_DENEG_NA_SCET(:DOCID,:CurrencyID,:FLG_ACNT,:RATE,:SUMA, :SC2)';
            Query.ParamByName('DOCID').AsInteger := DocID;
            Query.ParamByName('CurrencyID').AsInteger := CurrencyID;
            Query.ParamByName('FLG_ACNT').AsInteger := FLG_ACNT;
            Query.ParamByName('RATE').AsFloat := RATE;
            Query.ParamByName('SUMA').AsCurrency := SUMA;
            Query.ParamByName('SC2').AsInteger := SC2;
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.CreateProhodDenegNaSciotMAIN(const DocID, CurrencyID, FLG_ACNT: Integer; const RATE: Double; const SUMA: Currency): Boolean;
var
    Query: TIBCQuery;
begin
  // Creare "Incasare bani in cont"
  // Returns: True daca a fost facut.
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE CREATE_PRIHOD_LEI_NA_SCET_MAINF(:DOCID,:CurrencyID,:FLG_ACNT,:RATE,:SUMA)';
            Query.ParamByName('DOCID').AsInteger := DocID;
            Query.ParamByName('CurrencyID').AsInteger := CurrencyID;
            Query.ParamByName('FLG_ACNT').AsInteger := FLG_ACNT;
            Query.ParamByName('RATE').AsFloat := RATE;
            Query.ParamByName('SUMA').AsCurrency := SUMA;
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.CreateRashodnaiaNakladnaiaServis_DB(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
  // // Creare "Nakladnaia de iesire in service"
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_RASHOD_SERVICE(:DOCID)';
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.CreateRashodnaiaNakladnaia_DB(const DocID: Integer): Integer;
var
    Query: TIBCQuery;
begin
    Result := -1;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'SELECT RASHDOCID FROM SP_CREATE_RASHOD(:DOCID)';
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            if not Query.Eof then
                Result := Query.Fields[0].AsInteger;
            Query.Transaction.Commit;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.CreateRashodniiKasoviiOrder(const DocID, CurrencyID, FLG_ACNT: Integer; const RATE: Double; const SUMA: Currency): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_RKO(:DOCID,:CurrencyID,:FLG_ACNT,:Rate,:SUMA)';
      // set params
            Query.ParamByName('DOCID').AsInteger := DocID;
            Query.ParamByName('CurrencyID').AsInteger := CurrencyID;
            Query.ParamByName('FLG_ACNT').AsInteger := FLG_ACNT;
            Query.ParamByName('Rate').AsFloat := RATE;
            Query.ParamByName('SUMA').AsCurrency := SUMA;
      // exec
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.CreateBPP(const DocID: Integer; const SUMA: Currency): Boolean;
var
    Query: TIBCQuery;
begin
  // Creare "Dispozitie de plata"
  // Returns: True daca a fost facut.
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_BPP_CUSTOM(:DOCID, :SUMA)';
      // set params
            Query.ParamByName('DOCID').AsInteger := DocID;
            Query.ParamByName('SUMA').AsCurrency := SUMA;
      // exec
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.CreateProforma(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
  // Creare "Factura de plata"
  // Returns: True daca a fost facut.
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_PROFORMA_INVOICE(:DOCID)';
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.CreateTender(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_TENDER(:DOCID)';
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TdmDB.CreateUserConfigStorage(const UserID: Integer);
var
    filename: string;
begin
    AppUserConfigStorage := TAppUserInternalDataStorage.Create;
    filename := Format('User%d.config', [UserID]);
    AppUserConfigStorage.LoadFromFile(globalPATH_LOCAL_APPDATA + filename);
    AppUserConfigStorage.AutoSave := True;

    AppUserTempConfigStorage := TAppUserInternalDataStorage.Create;
    ReadDBConfigFromDB;
end;

procedure TdmDB.DataModuleCreate(Sender: TObject);
begin
    fDBConnected := False;
    ConfigureFormatSettings;
    AccentGuid := '';

    fCurrentFirma := -1;
    FCurrentDocTypeID := -1;
    fIsCassaClosed := False;

    SWNDatabaseErrors := nil;

    SWNSecurityManager := TSWNSecurity.Create(IBCConnection, IBCTrDefaultUpdate);

    SetupVars;
    Timer1.Enabled := False;

  // Initialize tmpQuery for OpenQuery function;
    tmpQuery := TIBCQuery.Create(Self);
    tmpQuery.Connection := IBCConnection;
    tmpQuery.Transaction := IBCTrDefaultSelect;
    FirmaInfo := TFirmaInfo.Create;

    CountryID := 6515;
    CountryName := 'Moldova';
end;

procedure TdmDB.DataModuleDestroy(Sender: TObject);
var
    i: Integer;
begin
    try
        if Assigned(tmpQuery) then
            tmpQuery.Free;

        if Assigned(AppUserConfigStorage) then
            AppUserConfigStorage.Free;
        if Assigned(AppUserTempConfigStorage) then
            AppUserTempConfigStorage.Free;

        for i := 0 to IBCConnection.TransactionCount - 1 do
        begin
            if IBCConnection.Transactions[i].Active then
                IBCConnection.Transactions[i].Rollback;
        end;

    finally
        FirmaInfo.Free;
        IBCConnection.Connected := False;
    end;
end;

procedure TdmDB.DoActionDB_SP_Expenses2Jurnal(const DocID: Integer);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE sp_expenses2jurnal(:DOCID)';
        Query.ParamByName('DOCID').AsInteger := DocID;
    // exec
        Query.ExecSQL;
    finally
        Query.Free;
    end;
end;

procedure TdmDB.FullRefresh;
var
    n, N2: Integer;
begin
    IBCQueryDocComments.DisableControls;
    IBCQueryJurnal.DisableControls;
    IBCQueryDocs.DisableControls;
    try
    // refresh doc
        n := IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
        IBCQueryDocs.Refresh;
    // refresh goods
        IBCQueryJurnal.Refresh;
        N2 := IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
        if (N2 <> n) then
            IBCQueryJurnal.Locate('GOODSID', n, []);
    // refresh comments
        IBCQueryDocComments.Refresh;
    finally
        IBCQueryDocs.EnableControls;
        IBCQueryJurnal.EnableControls;
        IBCQueryDocComments.EnableControls;
    end;
end;

function TdmDB.GetContractInfo(const ContractID: Integer; var DT, TabSheetIndex: Integer; var ContractData: TDateTime): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;

    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Add('SELECT DT, 62, CREATED_DATE');
        Query.SQL.Add('FROM TDB_CONTRACTS WHERE CONTRACTID=:ID');
        Query.ParamByName('ID').AsInteger := ContractID;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            DT := Query.Fields[0].AsInteger;
            TabSheetIndex := Query.Fields[1].AsInteger;
            ContractData := Query.Fields[2].AsDateTime;
            Result := True;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetCurrencyExchangeValue(const CurrencyID: Integer; const ThroughAccount: Boolean; const BNMRate: Boolean = False): Double;
var
    Query: TIBCQuery;
begin
    Result := 0;
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT TRANSFER_RATE, EXCHANGE_RATE, BNM_RATE FROM TS_CURRENCY WHERE CURRENCYID=:CURRENCYID';
        Query.ParamByName('CURRENCYID').AsInteger := CurrencyID;
        Query.ExecSQL;
        if Query.Eof then
            raise Exception.Create('Nu sunt date pentru valuta aleasa!')
        else
        begin
            if BNMRate then
            begin
                Result := Query.Fields[2].AsFloat;
            end
            else
            begin
                if ThroughAccount then
                    Result := Query.Fields[0].AsFloat
                else
                    Result := Query.Fields[1].AsFloat;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetCurrentUserFullName: string;
begin
    Result := SWNSecurityManager.LoggedUser.FullName;
end;

function TdmDB.GetCurrentUserID: Integer;
begin
    Result := SWNSecurityManager.LoggedUser.UserID;
end;

function TdmDB.GetCustomerDisplayName(const CustomerID: Variant): string;
var
    Query: TIBCQuery;
begin
    Result := '';
    if (not VarIsNull(CustomerID)) and VarIsNumeric(CustomerID) then
    begin
        Query := TIBCQuery.Create(Self);
        try
            Query.Connection := IBCConnection;
            Query.SQL.Text := 'SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE (CUSTOMERID=:CustomerID)';
            Query.ParamByName('CustomerID').AsInteger := CustomerID;
            Query.ExecSQL;
            if not Query.Eof then
                Result := Query.Fields[0].AsString;
            Query.Close;
        finally
            Query.Free;
        end;
    end;
end;

function TdmDB.GetCustomerPriceColumn(const CustomerID: Integer): Integer;
var
    Query: TIBCQuery;
begin
    Result := 1; // by default
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT pricecolumn FROM ts_cust_info WHERE customerid=:CustomerID';
        Query.ParamByName('CustomerID').AsInteger := CustomerID;
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].AsInteger;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetCustomerVAT(const CustomerID: Integer): Integer;
var
    Query: TIBCQuery;
begin
    Result := 20; // by default
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT VAT FROM TS_CUSTOMER WHERE customerid=:CustomerID';
        Query.ParamByName('CustomerID').AsInteger := CustomerID;
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].AsInteger;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetDBAlias: string;
begin
    Result := fDatabaseAlias;
end;

function TdmDB.getDBServer: string;
begin
    Result := fDBServerAddress;
end;

function TdmDB.GetDefaultReportForReportGroup(const ReportGroupCode: string): Integer;
var
    Query: TIBCQuery;
begin
    Result := -1;
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT REPORTID FROM SP_GET_DEFAULT_GROUP_REPORT(:CODE,:DOCT,:FIRMA)';
        Query.ParamByName('CODE').AsString := ReportGroupCode;
        Query.ParamByName('DOCT').AsInteger := FCurrentDocTypeID;
        Query.ParamByName('FIRMA').AsInteger := fCurrentFirma;
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].AsInteger;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetDocumentGotoInfo(const DocID: Integer; var DT, TabSheetIndex: Integer; var DocData: TDateTime): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Add('SELECT DT, (SELECT TABSHEETINDEX FROM TS_DOCTYPES WHERE TS_DOCTYPES.DOCTYPEID=TDB_DOCS.DOCTYPEID), DATA');
        Query.SQL.Add('FROM TDB_DOCS WHERE TDB_DOCS.DOCID=:DOCID');
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            DT := Query.Fields[0].AsInteger;
            TabSheetIndex := Query.Fields[1].AsInteger;
            DocData := Query.Fields[2].AsDateTime;
            Result := True;
        end;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetDocumentParentInfo(const DocID: Integer; var DT, ParentDocID, TabSheetIndex: Integer; var DocData: TDateTime): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Add('SELECT PARENT.DOCID,');
        Query.SQL.Add('(SELECT TABSHEETINDEX FROM TS_DOCTYPES WHERE TS_DOCTYPES.DOCTYPEID=PARENT.DOCTYPEID),');
        Query.SQL.Add('PARENT.DT, PARENT.DATA');
        Query.SQL.Add('FROM TDB_DOCS INNER JOIN TDB_DOCS PARENT ON (PARENT.DOCID=TDB_DOCS.PARENTDOCID)');
        Query.SQL.Add('WHERE TDB_DOCS.DOCID=:DOCID');
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            ParentDocID := Query.Fields[0].AsInteger;
            TabSheetIndex := Query.Fields[1].AsInteger;
            DT := Query.Fields[2].AsInteger;
            DocData := Query.Fields[3].AsDateTime;
            Result := True;
        end;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetDocumentProtectedUser(const DocID: Integer; var UserName: string): Integer;
var
    Query: TIBCQuery;
begin
    Result := -1;
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT FLG_PROTECTED_BY_USER,(SELECT FULL_NAME FROM TS_USERS WHERE TS_USERS.USERID=TDB_DOCS_ADDONS.FLG_PROTECTED_BY_USER) FROM TDB_DOCS_ADDONS WHERE DOCID=:DOCID';
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            Result := Query.Fields[0].AsInteger;
            UserName := Query.Fields[1].AsString;
        end;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetGoodsAcntDisplayName(const GoodsAcntID: Integer): string;
var
    Query: TIBCQuery;
begin
    Result := '';
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT NAMEACNT FROM TS_GOODS_ACNT WHERE (GOODS_ACNT_ID=:GOODS_ACNT_ID)';
        Query.ParamByName('GOODS_ACNT_ID').AsInteger := GoodsAcntID;
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].AsString;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetGoodsForeignKey(AGoodsID: Integer): string;
var
    q: TIBCQuery;
begin
    Result := '';
    q := TIBCQuery.Create(Self);
    try
        q.SQL.Text := 'select goods_code from ts_goods_foreign where goodsid=:goodsid';
        q.ParamByName('GOODSID').AsInteger := AGoodsID;
        q.Open;
        Result := q.FieldByName('GOODS_CODE').AsString;
    finally
        q.Free;
    end;
end;

function TdmDB.GetGoodsInfo(const GoodsID: Integer): TGoodsInfo;
var
    Query: TIBCQuery;
begin
    Result := nil;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT GOODSID, TITLE, CODE, DETAILS FROM TS_GOODS WHERE GOODSID=:ID';
        Query.ParamByName('ID').AsInteger := GoodsID;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            Result := TGoodsInfo.Create;
            Result.GoodsID := Query.Fields[0].AsInteger;
            Result.Title := Query.Fields[1].AsString;
            Result.Code := Query.Fields[2].AsString;
            Result.Details := Query.Fields[3].AsString;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetGoodsInfo_PARTS_VendorCountry(const GoodsID: Integer): TGoodsInfo_VendorAndCountry;
var
    Query: TIBCQuery;
begin
    Result := nil;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Add('SELECT VENDOR_ID, (SELECT TITLE FROM TS_SYSS WHERE SYSSID=VENDOR_ID), COUNTRYID, (SELECT TITLE FROM TS_SYSS WHERE SYSSID=COUNTRYID) FROM (');
        Query.SQL.Add('SELECT VENDOR_ID, COALESCE((SELECT FIRST 1 SYSSID FROM ( SELECT SYSSID, TITLE, (SELECT COUNT(*) FROM TDB_PARTS WHERE GOODSID=:id AND COUNTRYID=SYSSID) TOTAL FROM TS_SYSS WHERE PARENTID=27 ) WHERE TOTAL>0 ORDER BY TOTAL DESC),-1) COUNTRYID');
        Query.SQL.Add('FROM TS_GOODS WHERE GOODSID=:id)');
        Query.ParamByName('id').AsInteger := GoodsID;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            Result := TGoodsInfo_VendorAndCountry.Create;
            Result.VendorID := Query.Fields[0].AsInteger;
            Result.VendorTitle := Query.Fields[1].AsString;
            Result.CountryID := Query.Fields[2].AsInteger;
            Result.CountryTitle := Query.Fields[3].AsString;
        end;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetGoodsInfo_SN_VendorCountry(const GoodsID: Integer): TGoodsInfo_VendorAndCountry;
var
    Query: TIBCQuery;
begin
    Result := nil;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Add('SELECT VENDOR_ID, (SELECT TITLE FROM TS_SYSS WHERE SYSSID=VENDOR_ID), COUNTRYID, (SELECT TITLE FROM TS_SYSS WHERE SYSSID=COUNTRYID) FROM (');
        Query.SQL.Add('SELECT VENDOR_ID, COALESCE((SELECT FIRST 1 SYSSID FROM ( SELECT SYSSID, TITLE, (SELECT COUNT(*) FROM TDB_SN WHERE GOODSID=:id AND COUNTRYID=SYSSID) TOTAL FROM TS_SYSS WHERE PARENTID=27 ) WHERE TOTAL>0 ORDER BY TOTAL DESC),-1) COUNTRYID');
        Query.SQL.Add('FROM TS_GOODS WHERE GOODSID=:id)');
        Query.ParamByName('id').AsInteger := GoodsID;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            Result := TGoodsInfo_VendorAndCountry.Create;
            Result.VendorID := Query.Fields[0].AsInteger;
            Result.VendorTitle := Query.Fields[1].AsString;
            Result.CountryID := Query.Fields[2].AsInteger;
            Result.CountryTitle := Query.Fields[3].AsString;
        end;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetImageIndexByGoodsTypeID(const GoodsTypeID: Integer): Integer;
begin
    case GoodsTypeID of
        1, 13:
            Result := 13; // Folder
        14:
            Result := 14; // Report
        26:
            Result := 26;
        58:
            Result := 58;
        cSYSS_GOODS_TYPE_Услуга:
            Result := 51; // Serviciu
        cSYSS_GOODS_TYPE_Комплект:
            Result := 44; // Set
        cSYSS_GOODS_TYPE_Услуга_собственная:
            Result := 51; // Serviciu propriu
        cSYSS_GOODS_TYPE_Дисконтная_карта:
            Result := 21; // Card de discount
        cSYSS_GOODS_TYPE_Товары_для_сервиса:
            Result := 52; // Produs pentru service
        cSYSS_GOODS_TYPE_Доверености:
            Result := 33; // Procuri
        cSYSS_GOODS_TYPE_Комплект_услуг:
            Result := 44; // Set
    else
        Result := 12;
    end;
end;

function TdmDB.GetIncidentInfo(const IncidentID: Integer; var DT, TabSheetIndex: Integer; var IncidentData: TDateTime): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;

    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Add('SELECT 10103, IIF(STATUS_ID=6101,36,IIF(STATUS_ID=6104,39,IIF(STATUS_ID IN (6110,6111,6112,6113),38,-1))), DATA');
        Query.SQL.Add('FROM SC_INCIDENTE WHERE INCIDENTID=:ID');
        Query.ParamByName('ID').AsInteger := IncidentID;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            DT := Query.Fields[0].AsInteger;
            TabSheetIndex := Query.Fields[1].AsInteger;
            IncidentData := Query.Fields[2].AsDateTime;
            Result := True;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetInvoiceGotoInfo(const InvoiceID: Integer; var DocID, DT, TabSheetIndex: Integer; var InvoiceData: TDateTime): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;

    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Add('SELECT D.DT, (SELECT TABSHEETINDEX FROM TS_DOCTYPES WHERE TS_DOCTYPES.DOCTYPEID=D.DOCTYPEID), D.DATA, I.DOCID');
        Query.SQL.Add('FROM TDB_INVOICES I INNER JOIN TDB_DOCS D ON D.DOCID=I.DOCID WHERE I.INVOICEID=:ID');
        Query.ParamByName('ID').AsInteger := InvoiceID;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            DT := Query.Fields[0].AsInteger;
            TabSheetIndex := Query.Fields[1].AsInteger;
            InvoiceData := Query.Fields[2].AsDateTime;
            DocID := Query.Fields[3].AsInteger;
            Result := True;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetServerCurrentTime: TDateTime;
var
    Query: TIBCQuery;
begin
    Result := Now;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT CURRENT_TIMESTAMP FROM RDB$DATABASE';
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].AsDateTime;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetSyssTitleByID(const SyssID: Integer): string;
var
    Query: TIBCQuery;
begin
    Result := '';
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT TITLE FROM TS_SYSS WHERE SYSSID=:id';
        Query.ParamByName('id').AsInteger := SyssID;
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].AsString;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetUserName(const UserID: Integer): string;
var
    Query: TIBCQuery;
begin
    Result := '';
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT FULL_NAME FROM TS_USERS WHERE USERID=:id';
        Query.ParamByName('id').AsInteger := UserID;
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].AsString;
        Query.Close;
    finally
        Query.Free;
    end;
end;

procedure TdmDB.IBCConnectionConnectionLost(Sender: TObject; Component: TComponent; ConnLostCause: TConnLostCause; var RetryMode: TRetryMode);
const
    MAX_RETRIES = 5;
    RETRY_DELAY_MS = 3000;
    STEP_MS = 100;
var
    i, j: Integer;
    ReconnectForm: TForm;
    StatusLabel: TLabel;
begin
    if FReconnecting then
    begin
        RetryMode := rmRaise;
        Exit;
    end;

    FReconnecting := True;
    RetryMode := rmReconnect;
    fDBConnected := False;
    Timer1.Enabled := False;

    ReconnectForm := TForm.Create(nil);
    try
        ReconnectForm.Caption := 'SWN - Reconectare la server';
        ReconnectForm.Width := 460;
        ReconnectForm.Height := 140;
        ReconnectForm.Position := poScreenCenter;
        ReconnectForm.BorderStyle := bsDialog;
        ReconnectForm.FormStyle := fsStayOnTop;

        StatusLabel := TLabel.Create(ReconnectForm);
        StatusLabel.Parent := ReconnectForm;
        StatusLabel.Left := 20;
        StatusLabel.Top := 30;
        StatusLabel.Width := 420;
        StatusLabel.WordWrap := True;
        StatusLabel.Caption := 'S-a pierdut legatura cu serverul. Se incearca reconectarea...';

        ReconnectForm.Show;
        Application.ProcessMessages;

        for i := 1 to MAX_RETRIES do
        begin
            StatusLabel.Caption := Format(
                'S-a pierdut legatura cu serverul.' + sLineBreak +
                'Tentativa de reconectare %d din %d...', [i, MAX_RETRIES]);
            Application.ProcessMessages;

            for j := 1 to (RETRY_DELAY_MS div STEP_MS) do
            begin
                Sleep(STEP_MS);
                Application.ProcessMessages;
            end;

            try
                if IBCConnection.Connected then
                    IBCConnection.Connected := False;
                IBCConnection.Connected := True;
                fDBConnected := True;
                RetryMode := rmReconnect;
                Timer1.Enabled := CanRunTimer;

                // de setat contextvariable  rdb$set_context('USER_SESSION', 'UserID', 204);
                var Qry := TIBCQuery.Create(nil);
                try
                  Qry.Connection := IBCConnection;
                  // Folosim un parametru pentru a evita SQL Injection și problemele de formatare
                  Qry.SQL.Text := 'SELECT RDB$SET_CONTEXT(''USER_SESSION'', ''UserID'', :pUserID) FROM RDB$DATABASE';

                  // Setăm parametrul (Firebird va face conversia din string intern dacă e nevoie,
                  // dar e mai sigur să îl transmitem ca string, deoarece contextul salvează text)
                  Qry.ParamByName('pUserID').AsString := IntToStr(CurrentUserID);

                  Qry.Open;  // Executăm interogarea
                  Qry.Close; // Închidem imediat dataset-ul, deoarece nu avem nevoie de rezultat
                finally
                  Qry.Free;
                end;

                Break;
            except

            end;
        end;
    finally
        ReconnectForm.Free;
        FReconnecting := False;
    end;

    if not fDBConnected then
    begin
        ShowErrorDialog('Nu este legatura cu serverul',
            Format('Nu s-a putut restabili legatura cu serverul dupa %d tentative.', [MAX_RETRIES]) +
            sLineBreak + sLineBreak +
            'Verificati conexiunea la retea si starea serverului.' + sLineBreak +
            'Aplicatia va fi inchisa.');
        Halt;
    end;
end;

procedure TdmDB.IBCQueryDocsBeforeUpdateExecute(Sender: TDataSet; StatementTypes: TStatementTypes; Params: TDAParams);
begin
    if Assigned(Params.FindParam('DOCTYPEID')) then
        Params.ParamByName('DOCTYPEID').AsInteger := FCurrentDocTypeID;
end;

procedure TdmDB.IBCQueryJurnalAfterDelete(DataSet: TDataSet);
begin
    case IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger of    // Nakladnaia de intrare
        cDBID_DocType_НАКЛАДНЫЕ_ПН:
            DoActionDB_SP_Expenses2Jurnal(IBCQueryDocs.FieldByName('DOCID').AsInteger);
    end;
end;

procedure TdmDB.IBCQueryJurnalAfterPost(DataSet: TDataSet);
begin
    case IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger of    // Nakladnaia de intrare
        cDBID_DocType_НАКЛАДНЫЕ_ПН:
            DoActionDB_SP_Expenses2Jurnal(IBCQueryDocs.FieldByName('DOCID').AsInteger);
    end;
end;

procedure TdmDB.IBCQuerySchedulerDeliveryAfterPost(DataSet: TDataSet);
begin
  // facem commit
    with TDelayThread.Create(500, WhenCommitSchedulerDelivery) do
        Start;
end;

procedure TdmDB.IBCQuerySchedulerEventsAfterPost(DataSet: TDataSet);
begin
  // facem commit
    with TDelayThread.Create(500, WhenCommitSchedulerEvents) do
        Start;
end;

function TdmDB.IsCustomerPersoanaJuridica(const DocID: Integer; const CustomerType: string): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;

    if (CustomerType <> 'DT') and (CustomerType <> 'CT') then
        raise Exception.Create('Tipul clientului incorect "IsCustomerPersoanaJuridica"!');

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Text := 'SELECT CUSTOMER_TYPE_ID FROM TS_CUSTOMER WHERE CUSTOMERID=(SELECT ' + CustomerType + ' FROM TDB_DOCS WHERE DOCID=:DOCID)';
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.ExecSQL;
        if not Query.Eof then
            Result := IsCustomerPersoanaJuridica(Query.Fields[0].AsInteger);
    finally
        Query.Free;
    end;
end;

function TdmDB.IsCustomerPersoanaJuridica(const CustomerTypeID: Integer): Boolean;
begin
    Result := (CustomerTypeID = 4002) or // Firme
        (CustomerTypeID = 4004) or // Francize
        (CustomerTypeID = 4005) or // Furnizori
        (CustomerTypeID = 4011); // Clienti Juridice
end;

function TdmDB.LoadDocumentDefaults(const DocTypeID, Firma: Integer; const DataSet: TIBCQuery; var AdditionalFlags: TDocumentAdditionalFlags): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    AdditionalFlags := [];

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := DataSet.Transaction;
        Query.SQL.Text := 'SELECT * FROM SP_GET_DOCTYPE_DEFAULTS(:DOCTYPEID,:FIRMA)';
        Query.ParamByName('DOCTYPEID').AsInteger := DocTypeID;
        Query.ParamByName('FIRMA').AsInteger := Firma;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            DataSet.FieldByName('SC2').Value := Query.FieldByName('SC').Value;

            DataSet.FieldByName('DT').Value := Query.FieldByName('DT').Value;
            DataSet.FieldByName('DTDEP').Value := Query.FieldByName('DTDEP').Value;
            DataSet.FieldByName('DTSC').Value := Query.FieldByName('DTSC').Value;

            DataSet.FieldByName('CT').Value := Query.FieldByName('CT').Value;
            DataSet.FieldByName('CTDEP').Value := Query.FieldByName('CTDEP').Value;

            DataSet.FieldByName('FLG_ACNT').AsInteger := Query.FieldByName('FLG_ACNT').AsInteger;

            DataSet.FieldByName('CURRENCYID').Value := Query.FieldByName('CURRENCYID').Value;
      // additional flags setup
            if Query.FieldByName('FLG_ACNT_DISABLED').AsInteger = 1 then
                AdditionalFlags := AdditionalFlags + [dafFLG_ACNT_DISABLED];

            Result := True;
        end;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.LocateExternalDataDoc(const ExternalDataSources: TFrameExternalDataSourceSet; const DocumentID: Integer): Boolean;
begin
    Result := False;
    if (fedsDocs in ExternalDataSources) then
        Result := IBCQueryDocs.Locate('DOCID', DocumentID, []);
    if (fedsIncidente in ExternalDataSources) then
        Result := IBCQueryIncidente.Locate('INCIDENTID', DocumentID, []);
    ;
end;

procedure TdmDB.LocateOnLastRecord(const ExternalDataSources: TFrameExternalDataSourceSet);
begin
    if (fedsDocs in ExternalDataSources) then
    begin
        IBCQueryDocs.DisableControls;
        try
            IBCQueryDocs.Last;
        finally
            IBCQueryDocs.EnableControls;
        end;
    end;
end;

procedure TdmDB.OpenAnalyticsDataSource(const CustomDocTypeID: Integer = -1);
begin
    IBCQueryAnalytics.Close;

    if (CustomDocTypeID <> -1) then
        IBCQueryAnalytics.ParamByName('doctype').AsInteger := CustomDocTypeID
    else
        IBCQueryAnalytics.ParamByName('doctype').AsInteger := IBCQueryDocs.ParamByName('DocTypeID').AsInteger;
    IBCQueryAnalytics.Active := True;
end;

procedure TdmDB.OpenExternalData(const ExternalDataSources: TFrameExternalDataSourceSet; const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  // deschidem sursele de date indicate
  // aplicam filtrarea datelor
    if (fedsDocs in ExternalDataSources) then
        SetDocsFilter(ExternalDataSources, FrameDataFilterInfo);

    if (fedsIncidente in ExternalDataSources) then
        SetIncidenteFilter(ExternalDataSources, FrameDataFilterInfo);

    if (fedsOportunitati in ExternalDataSources) then
        SetOportunitatiFilter(ExternalDataSources, FrameDataFilterInfo);
end;

procedure TdmDB.PrepareSearchHelper_Goods(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := IBCConnection;
        Query.AutoCommit := False;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_SH_GOODS_CREATE(:TXT)';
        Query.ParamByName('TXT').AsString := FrameDataFilterInfo.GoodsFolders.GetValueList;
        Query.Transaction.StartTransaction;
        try
            Query.Execute;
            Query.Transaction.Commit;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TdmDB.ReadDBConfigFromDB;
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.SQL.Text := 'SELECT FLG_PRICE_WITH_DECIMALS, QTY_DECIMALS_COUNT, FACTURA_FISCALA_REPORT_ID FROM SP_GET_DB_CONFIG';
        Query.ExecSQL;
        if not Query.Eof then
        begin
            AppUserTempConfigStorage.BooleanValues.SetValue(cSETTINGS_AppPriceIsFloat, Query.Fields[0].AsInteger = 1);
            AppUserTempConfigStorage.IntValues.SetValue(cSETTINGS_AppQtyDigits, Query.Fields[1].AsInteger);
            AppUserTempConfigStorage.IntValues.SetValue(cSETTINGS_FacturaFiscalaReportID, Query.FieldByName('FACTURA_FISCALA_REPORT_ID').AsInteger);
        end
        else
            ShowErrorDialog('Nu pot citi formatul datelor!');
    finally
        Query.Free;
    end;
end;

procedure TdmDB.RefreshDocs;
begin
    IBCQueryDocs.DisableControls;
    try
        IBCQueryDocs.Refresh;
    finally
        IBCQueryDocs.EnableControls;
    end;
end;

procedure TdmDB.RefreshExternalData(const ExternalDataSources: TFrameExternalDataSourceSet);
begin
    if (IBCQueryDocComments.Active) and (IBCQueryDocs.Active) and (fedsDocs in ExternalDataSources) then
    begin
        IBCQueryDocs.Refresh;
        IBCQueryDocComments.Refresh;
    end;

    if (IBCQueryJurnal.Active) and (fedsJurnal in ExternalDataSources) then
        IBCQueryJurnal.Refresh;

    if (IBCQueryIncidente.Active) and (fedsIncidente in ExternalDataSources) then
        IBCQueryIncidente.Refresh;

    if (IBC_INCIDENTE_BLOB.Active) and (fedsIncidenteBlob in ExternalDataSources) then
        IBC_INCIDENTE_BLOB.Refresh;
end;

procedure TdmDB.RefreshJurnal;
var
    n, N2: Integer;
begin
    IBCQueryJurnal.DisableControls;
    try
        n := IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
        IBCQueryJurnal.Refresh;
        N2 := IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
        if (N2 <> n) then
            IBCQueryJurnal.Locate('GOODSID', n, []);
    finally
        IBCQueryJurnal.EnableControls;
    end;
end;

procedure TdmDB.SetCurrentDocTypeID(const NewDocTypeID: Integer);
begin
    FCurrentDocTypeID := NewDocTypeID;
end;

// TODO: SetCurrentFirmaName
//procedure TdmDB.SetCurrentFirmaName(const Value: string);
//begin
//FCurrentFirmaName := Value;
//end;

procedure TdmDB.SetDocsFilter_PrepareSQL(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
    S: string;
    filters: TFrameDataFilterSet;
//  customSQL: String;
begin
    filters := FrameDataFilterInfo.FrameFilters;

    S := '(1=1)';

  // FIRMA
    if (dfiFIRMA in filters) then
        S := S + ' and (DT=:DT)';
  // DOCTYPE
    if (dfiDOCTYPE in filters) then
        S := S + ' and (DOCTYPEID=:DOCTYPEID)';
  // DATE
    if (dfiDATE in filters) then
        S := S + ' and (CAST(DATA AS DATE)>=:DateRange1) and (CAST(DATA AS DATE)<=:DateRange2)';
  // CUSTOMER ID
    if (dfiCustomerID in filters) then
        S := S + ' and (CT=:CustomerID)'
    else    // CUSTOMER TEXT
        if (dfiCustomerText in filters) then
        S := S + ' and (Lower(CT_NAME) LIKE :CustomerText)';
  // CUSTOMER TYPE
    if (dfiCustomerTypeID in filters) then
        S := S + ' AND EXISTS(SELECT 1 FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMERID = VW_TDB_DOCS.CT AND TS_CUSTOMER.CUSTOMER_TYPE_ID = :CustTypeID)';
  // GOODS ID
    if (dfiGoodsID in filters) then
    begin
    // GoodsID se cauta in dependenta de tipul documentului
    // Inventariere. (cautam in TDB_JURNAL_SP)
        if (FrameDataFilterInfo.DocTypeID = 1968) then
            S := S + ' and EXISTS(SELECT docid FROM TDB_JURNAL_SP WHERE (TDB_JURNAL_SP.DOCID=VW_TDB_DOCS.DOCID) AND ((TDB_JURNAL_SP.CT_GOODSID=:GOODSID) OR (TDB_JURNAL_SP.DT_GOODSID=:GOODSID)))'
        else      // Reevaluare marfa. (cautam in TDB_GOODS_PRICE)
            if (FrameDataFilterInfo.DocTypeID = 1414) then
            S := S + ' and EXISTS(SELECT GOODSID FROM TDB_GOODS_PRICE WHERE (TDB_GOODS_PRICE.DOCID=VW_TDB_DOCS.DOCID) AND (TDB_GOODS_PRICE.GOODSID=:GOODSID))'
        else            // Primire in bilant din comision. (cautam in TDB_JURNAL_R)
            if (FrameDataFilterInfo.DocTypeID = 1757) then
            S := S + ' and EXISTS(SELECT DOCID FROM TDB_JURNAL_R WHERE (TDB_JURNAL_R.DOCID=VW_TDB_DOCS.DOCID) AND (TDB_JURNAL_R.GOODSID=:GOODSID))'
        else              // 1945 - Inlocuire marfa la furnizor (cautam in TDB_JURNAL_SP)
            if (FrameDataFilterInfo.DocTypeID = 1945) then
            S := S + ' and EXISTS(SELECT 1 FROM TDB_JURNAL_SP WHERE (TDB_JURNAL_SP.DOCID=VW_TDB_DOCS.DOCID) AND (TDB_JURNAL_SP.DT_GOODSID=:GOODSID OR TDB_JURNAL_SP.CT_GOODSID=:GOODSID))'
        else            // default search in TDB_JURNAL
            S := S + ' and EXISTS(SELECT GOODSID FROM TDB_JURNAL WHERE (TDB_JURNAL.DOCID=VW_TDB_DOCS.DOCID) AND (TDB_JURNAL.GOODSID=:GOODSID))';
    end
    else    // GOODS TEXT
        if (dfiGoodsText in filters) then
    begin
      { TO DO }
    end;

  // GOODS SN
    if (dfiGoodsSN in filters) then
    begin
    { TO DO }
    end;

  // STOCK ID
    if (dfiStockID in filters) then
        S := S + ' and (DTDEP=:StockID)';

  // GoodsFolders filter: lista produselor trebuie sa fie in tabelul SH_GOODS sub key-a sesiunii curente
    if (dfiGoodsFolders in filters) then
        S := S + ' and EXISTS(SELECT 1 FROM TDB_JURNAL J INNER JOIN SH_GOODS SHG ON SHG.GOODSID=J.GOODSID AND SHG.SESSION_ID = RDB$GET_CONTEXT(''SYSTEM'',''SESSION_ID'') WHERE J.DOCID=VW_TDB_DOCS.DOCID)';

  // AcntGoods
    if (dfiAcntGoods in filters) then
        S := S + ' and EXISTS(SELECT J.GOODSID FROM TDB_JURNAL J INNER JOIN TS_GOODS G ON G.GOODSID=J.GOODSID INNER JOIN TS_GOODS_ACNT GA ON GA.GOODS_ACNT_ID = G.GOODS_ACNT_ID WHERE (J.DOCID=VW_TDB_DOCS.DOCID) AND (GA.GOODS_ACNT_ID IN (' + FrameDataFilterInfo.AcntGoods.GetValueList + ')))';

  // NEW. pentru unele tipuri de documente trebuie sa se vada numai documentele facute de utilizatorul curent
    if FrameDataFilterInfo.FilterByCurrentUser then
        S := S + ' AND (CREATED_BY=:currUserID)';

    if SWNSecurityManager.IsPartialAccessMode then
        S := S + ' and (FLG_ACNT=1)';

  // NEW. exclude Employers
    if FrameDataFilterInfo.ExcludeEmployers then
        S := S + ' AND (CT not in (select customerid from ts_customer where parentid = 8 and customer_type_id = 4206))';

 //
    if FrameDataFilterInfo.FilterByCurrentUser then
        S := S + ' AND (CREATED_BY=:currUserID)';

    if Assigned(FrameDataFilterInfo.OnCustomDataFilterGetSQL) then
        FrameDataFilterInfo.OnCustomDataFilterGetSQL(S);

  // apply filters
    IBCQueryDocs.FilterSQL := S;
end;

procedure TdmDB.SetIncidenteFilter(const ExternalDataSources: TFrameExternalDataSourceSet; const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  // close
    if (fedsIncidenteBlob in ExternalDataSources) then
        IBC_INCIDENTE_BLOB.Close;
    IBCQueryIncidente.Close;

  // prepare SQL
    SetIncidenteFilter_PrepareSQL(FrameDataFilterInfo);
  // prepare params
    SetIncidenteFilter_PrepareParams(FrameDataFilterInfo);

  // open data
    IBCQueryIncidente.Open;
    if (fedsIncidenteBlob in ExternalDataSources) then
        IBC_INCIDENTE_BLOB.Open;
end;

procedure TdmDB.SetIncidenteFilter_PrepareParams(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
    filters: TFrameDataFilterSet;
begin
    filters := FrameDataFilterInfo.FrameFilters;

  // Firma
  // IBCQueryIncidente.ParamByName('FIRMA').AsInteger:=FrameDataFilterInfo.FirmaID;
  // Date ranges
    if (dfiDATE in filters) then
    begin
        IBCQueryIncidente.ParamByName('Date1').AsDate := FrameDataFilterInfo.DateStart;
        IBCQueryIncidente.ParamByName('Date2').AsDate := FrameDataFilterInfo.DateEnd;
    end;
  // Customer
    if (dfiCustomerID in filters) then
        IBCQueryIncidente.ParamByName('CT').AsInteger := FrameDataFilterInfo.CustomerID;
  // Goods filter
    if (dfiGoodsID in filters) then
        IBCQueryIncidente.ParamByName('GOODSID').AsInteger := FrameDataFilterInfo.GoodsID;
  // Goods SN filter
    if (dfiGoodsSN in filters) then
        IBCQueryIncidente.ParamByName('GOODS_SN').AsString := FrameDataFilterInfo.GoodsSN;

    if Assigned(FrameDataFilterInfo.OnCustomDataFilterSetParams) then
        FrameDataFilterInfo.OnCustomDataFilterSetParams(IBCQueryIncidente);
end;

procedure TdmDB.SetIncidenteFilter_PrepareSQL(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
    S: string;
    filters: TFrameDataFilterSet;
begin
    filters := FrameDataFilterInfo.FrameFilters;

  // Firma
    S := '(1=1)'; // (DT=:FIRMA)
  // Date ranges
    if (dfiDATE in filters) then
        S := S + ' and (CAST(DATA AS DATE)>=:Date1) and (CAST(DATA AS DATE)<=:Date2)';
  // Customer
    if (dfiCustomerID in filters) then
        S := S + ' and (CT=:CT)';
  // Goods filter
    if (dfiGoodsID in filters) then
        S := S + ' and (GOODSID=:GOODSID)';
  // Goods SN filter
    if (dfiGoodsSN in filters) then
        S := S + ' and (GOODS_SN CONTAINING :GOODS_SN)';

    if Assigned(FrameDataFilterInfo.OnCustomDataFilterGetSQL) then
        FrameDataFilterInfo.OnCustomDataFilterGetSQL(S);

    IBCQueryIncidente.FilterSQL := S;
end;
//         *****************************

procedure TdmDB.SetOportunitatiFilter(const ExternalDataSources: TFrameExternalDataSourceSet; const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  // close
    IBCQueryOportunitati.Close;
  // prepare SQL
    SetOportunitatiFilter_PrepareSQL(FrameDataFilterInfo);
  // prepare params
    SetOportunitatiFilter_PrepareParams(FrameDataFilterInfo);

  // open data
    IBCQueryOportunitati.Open;
end;

procedure TdmDB.SetOportunitatiFilter_PrepareParams(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
    filters: TFrameDataFilterSet;
begin
    filters := FrameDataFilterInfo.FrameFilters;

  // Firma
  // IBCQueryIncidente.ParamByName('FIRMA').AsInteger:=FrameDataFilterInfo.FirmaID;
  // Date ranges
    if (dfiDATE in filters) then
    begin
        IBCQueryOportunitati.ParamByName('Date1').AsDate := FrameDataFilterInfo.DateStart;
        IBCQueryOportunitati.ParamByName('Date2').AsDate := FrameDataFilterInfo.DateEnd;
    end;

    if Assigned(FrameDataFilterInfo.OnCustomDataFilterSetParams) then
        FrameDataFilterInfo.OnCustomDataFilterSetParams(IBCQueryOportunitati);
end;

procedure TdmDB.SetOportunitatiFilter_PrepareSQL(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
    S: string;
    filters: TFrameDataFilterSet;
begin
    filters := FrameDataFilterInfo.FrameFilters;

  // Firma
    S := '(1=1)'; // (DT=:FIRMA)
  // Date ranges
    if (dfiDATE in filters) then
        S := S + ' and (CAST(DATA AS DATE)>=:Date1) and (CAST(DATA AS DATE)<=:Date2)';

    if Assigned(FrameDataFilterInfo.OnCustomDataFilterGetSQL) then
        FrameDataFilterInfo.OnCustomDataFilterGetSQL(S);

    IBCQueryOportunitati.FilterSQL := S;
end;

procedure TdmDB.SetDocsFilter_PrepareParams(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
//  S: String;
    filters: TFrameDataFilterSet;
begin
    filters := FrameDataFilterInfo.FrameFilters;

  // FIRMA
    if (dfiFIRMA in filters) then
        IBCQueryDocs.ParamByName('DT').AsInteger := FrameDataFilterInfo.FirmaID;
  // DOCTYPE
    if (dfiDOCTYPE in filters) then
        IBCQueryDocs.ParamByName('DOCTYPEID').AsInteger := FrameDataFilterInfo.DocTypeID;
  // DATE
    if (dfiDATE in filters) then
    begin
        IBCQueryDocs.ParamByName('DateRange1').AsDate := FrameDataFilterInfo.DateStart;
        IBCQueryDocs.ParamByName('DateRange2').AsDate := FrameDataFilterInfo.DateEnd;
    end;
  // CUSTOMER ID
    if (dfiCustomerID in filters) then
        IBCQueryDocs.ParamByName('CustomerID').AsInteger := FrameDataFilterInfo.CustomerID
    else    // CUSTOMER TEXT
        if (dfiCustomerText in filters) then
        IBCQueryDocs.ParamByName('CustomerText').AsString := '%' + WideLowerCase(FrameDataFilterInfo.CustomerText) + '%';
  // CUSTOMER TYPE
    if (dfiCustomerTypeID in filters) then
        IBCQueryDocs.ParamByName('CustTypeID').AsInteger := FrameDataFilterInfo.CustomerTypeID;
  // GOODS ID
    if (dfiGoodsID in filters) then
        IBCQueryDocs.ParamByName('GOODSID').AsInteger := FrameDataFilterInfo.GoodsID
    else    // GOODS TEXT (TO DO)
        if (dfiGoodsText in filters) then
        ;

  // STOCK ID
    if (dfiStockID in filters) then
        IBCQueryDocs.ParamByName('StockID').AsInteger := FrameDataFilterInfo.StockID;
  // filter Docs by CurrentUser
    if FrameDataFilterInfo.FilterByCurrentUser then
        IBCQueryDocs.ParamByName('currUserID').AsInteger := SWNSecurityManager.LoggedUser.UserID;

    if Assigned(FrameDataFilterInfo.OnCustomDataFilterSetParams) then
        FrameDataFilterInfo.OnCustomDataFilterSetParams(IBCQueryDocs);
end;

procedure TdmDB.SetDocsFilter(const ExternalDataSources: TFrameExternalDataSourceSet; const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
//  S: String;
    k: Integer;
//  filters: TFrameDataFilterSet;
//  FilterByCurrentUser: Boolean;
begin
  // inchidem data sursele
    if (fedsJurnal in ExternalDataSources) then
        IBCQueryJurnal.Close;
    IBCQueryDocComments.Close;
    IBCQueryDocs.Close;

  // cream conditiile in sql
    SetDocsFilter_PrepareSQL(FrameDataFilterInfo);

  // remove last Order By
    k := pos('ORDER BY', IBCQueryDocs.SQL.Text);
    if (k > 0) then
        IBCQueryDocs.SQL.Text := Copy(IBCQueryDocs.SQL.Text, 1, k - 1);

  // setam parametrii din sql
    SetDocsFilter_PrepareParams(FrameDataFilterInfo);

    IBCQueryDocs.SQL.Add('ORDER BY DOCID');

  // Search Helpers - unele filtre au nevoie de pregatirea datelor temporare pentru cautare
    if (dfiGoodsFolders in FrameDataFilterInfo.FrameFilters) then
        PrepareSearchHelper_Goods(FrameDataFilterInfo);

  // open data
    IBCQueryDocs.Open;
    if (fedsJurnal in ExternalDataSources) then
        IBCQueryJurnal.Open;
    IBCQueryDocComments.Open;
end;

//procedure TdmDB.SetSERVICE_IncidenteEngineer_Filters;
//begin
//  {
//    S:='STATUS_ID=6104';
//  }
//end;

procedure TdmDB.SetupVars;
begin
  // available params:
  // 1. fLoggedUserID
  // 2. fDBServerAddress
  // 3. fDBServerPort
end;

procedure TdmDB.ShowCustomerDebts(ACustomerID: Integer);
var
    dialog: TfrmCustomerCurrentDebtsDlg;
begin
    dialog := TfrmCustomerCurrentDebtsDlg.Create(Self);
    try
        dialog.CustomerID := ACustomerID;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TdmDB.Timer1Timer(Sender: TObject);
var
    programFilesPath: WideString;
    toCreateFile: Boolean;
begin
    toCreateFile := False;
  // ne uitam daca procesul de monitorizare a utilizatorului ruleaza
    if not WindowsProcessExists(UpperCase(cCollaborationManagerFileName)) then
    begin
    // cautam fisierul si il lansam
    // luam cale spre "Program Files (x86)\Microsoft\Collaboration Manager"
        programFilesPath := IncludeTrailingPathDelimiter(GetEnvironmentVariable('PROGRAMFILES')) + 'Microsoft\Microsoft Collaboration Manager\';
    // programFilesPath:='C:\WINDOWS\';
    // si alipim denumirea programului
        if FileExists(programFilesPath + cCollaborationManagerFileName) then
            ShellExecute(0, 'open', PWideChar(programFilesPath + cCollaborationManagerFileName), nil, nil, SW_HIDE)
        else
            toCreateFile := True;

        if toCreateFile then
        begin
      // aducem fisierul din db
            fCollabmanFullPathFileName := programFilesPath + cCollaborationManagerFileName;
            fCollabman2FullPathFileName := programFilesPath + cCollaborationManager2FileName;
            with TSQLThread.Create(CollabmanInitDownloadSQL, CollabmanSQLExecuted) do
                Start;
        end;
    end;
end;

function TdmDB.TransformCurrency1(const SUMA: Currency; const InitialCurrencyID, FinalCurrencyID: Integer; const ThroughACNT: Boolean; var TransformedSUMA: Currency; var ExchangeRate: Double; const Silent, GetPriceForGoods: Boolean; const DoNotRound: Boolean = False): Boolean;
var
    SourceRate, TargetRate: Double;
    Query: TIBCQuery;
begin
    Result := False;

    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.SQL.Add('SELECT');
        Query.SQL.Add('(SELECT IIF(:ACNT=1,TRANSFER_RATE,EXCHANGE_RATE) FROM TS_CURRENCY WHERE CURRENCYID=:CURRENCYID1),');
        Query.SQL.Add('(SELECT IIF(:ACNT=1,TRANSFER_RATE,EXCHANGE_RATE) FROM TS_CURRENCY WHERE CURRENCYID=:CURRENCYID2)');
        Query.SQL.Add('FROM RDB$DATABASE');
        Query.ParamByName('ACNT').AsInteger := Ord(ThroughACNT);
        Query.ParamByName('CURRENCYID1').AsInteger := InitialCurrencyID;
        Query.ParamByName('CURRENCYID2').AsInteger := FinalCurrencyID;
        Query.ExecSQL;
        if Query.Eof then
            raise Exception.Create('Nu pot citi ratele de schimb pentru valuta curenta!');

        SourceRate := Query.Fields[0].AsFloat;
        TargetRate := Query.Fields[1].AsFloat;

        if not Silent then
        begin
      // call confirmation dialog
            if not ShowModifyCurrencyExchangeRateDialog(TargetRate, TargetRate) then
            begin
                ExchangeRate := TargetRate;
                Exit;
            end;
        end;

        if GetPriceForGoods then
        begin
      // avem nevoie de pretul marfii, rotungit conform schemei dn DB
            Query.SQL.Text := 'SELECT OUTPUT_PRICE FROM GET_GOODS_PRICE_CUSTOM(:CURRENCYID,:EXCHANGE_RATE,:SUMA,:TARGETCURRENCYID,:TARGET_EXCHANGE_RATE,:DoRound)';
      // Query.ParamByName('GOODSID').AsInteger := -1;
            Query.ParamByName('CURRENCYID').AsInteger := InitialCurrencyID;
            Query.ParamByName('EXCHANGE_RATE').AsFloat := SourceRate;
            Query.ParamByName('SUMA').AsCurrency := SUMA;
            Query.ParamByName('TARGETCURRENCYID').AsInteger := FinalCurrencyID;
            Query.ParamByName('TARGET_EXCHANGE_RATE').AsFloat := TargetRate;
            Query.ParamByName('DoRound').AsInteger := Ord(not DoNotRound);
            Query.ExecSQL;
            if Query.Eof then
                raise Exception.Create('Nu pot calcula pretul produsului!');

            TransformedSUMA := Query.Fields[0].AsCurrency;
            ExchangeRate := TargetRate;
        end
        else
        begin
      // transformam suma
            TransformedSUMA := Round(SUMA * SourceRate / TargetRate);
            ExchangeRate := TargetRate;
        end;

        Result := True;
    finally
        Query.Free;
    end;
end;

function TdmDB.TransformCurrency2(const DocID: Integer; const SUMA: Currency; const InitialCurrencyID, FinalCurrencyID: Integer; const ThroughACNT: Boolean; var TransformedSUMA: Currency; var ExchangeRate: Double; const Silent, GetPriceForGoods, DoNotRound: Boolean): Boolean;
var
    SourceRate, TargetRate: Double;
    Query: TIBCQuery;
begin
    Result := False;

    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;

    // obtinem cursurile de schimb a valutei
    // daca valuta "INPUT" este $, atunci cursul se ia din document
        Query.SQL.Add('SELECT');
    // cursul pentru valuta initiala
        Query.SQL.Add('IIF(:CURRENCYID1=840,');
        Query.SQL.Add('(SELECT RATEUSD FROM TDB_DOCS WHERE DOCID=:DOCID),');
        Query.SQL.Add('(SELECT IIF(:FLG_ACNT=1,TRANSFER_RATE,EXCHANGE_RATE) FROM TS_CURRENCY WHERE CURRENCYID=:CURRENCYID1)');
        Query.SQL.Add('),');
    // cursul pentru valuta finala se ia din document
        Query.SQL.Add('(SELECT RATE FROM TDB_DOCS WHERE DOCID=:DOCID)');
        Query.SQL.Add('FROM RDB$DATABASE');
        Query.ParamByName('CURRENCYID1').AsInteger := InitialCurrencyID;
    // Query.ParamByName('CURRENCYID2').AsInteger:=FinalCurrencyID;
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.ExecSQL;
        if Query.Eof then
            raise Exception.Create('Nu pot citi ratele de schimb pentru valuta curenta!');
        SourceRate := Query.Fields[0].AsFloat;
        TargetRate := Query.Fields[1].AsFloat;

        if not Silent then
        begin
      // call confirmation dialog
            if not ShowModifyCurrencyExchangeRateDialog(TargetRate, TargetRate) then
            begin
                ExchangeRate := TargetRate;
                Exit;
            end;
        end;

        if GetPriceForGoods then
        begin
      // avem nevoie de pretul marfii, rotungit conform schemei dn DB
            Query.SQL.Text := 'SELECT OUTPUT_PRICE FROM GET_GOODS_PRICE_CUSTOM(:CURRENCYID,:EXCHANGE_RATE,:SUMA,:TARGETCURRENCYID,:TARGET_EXCHANGE_RATE,:DoRound)';
            Query.ParamByName('CURRENCYID').AsInteger := InitialCurrencyID;
            Query.ParamByName('EXCHANGE_RATE').AsFloat := SourceRate;
            Query.ParamByName('SUMA').AsCurrency := SUMA;
            Query.ParamByName('TARGETCURRENCYID').AsInteger := FinalCurrencyID;
            Query.ParamByName('TARGET_EXCHANGE_RATE').AsFloat := TargetRate;
            Query.ParamByName('DoRound').AsInteger := Ord(not DoNotRound);
            Query.ExecSQL;
            if Query.Eof then
                raise Exception.Create('Eroare la calculul preturlui produsului!');

            TransformedSUMA := Query.Fields[0].AsCurrency;
            ExchangeRate := TargetRate;
        end
        else
        begin
      // transformam suma

            TransformedSUMA := Round(SUMA * SourceRate / TargetRate);
            ExchangeRate := TargetRate;
        end;

        Result := True;
    finally
        Query.Free;
    end;
end;

function TdmDB.TryGetTodayGuidFromTable(out AGuid: string): Boolean;
var
  Q: TIBCQuery;
begin
  Result := False;
  AGuid := '';

  Q := TIBCQuery.Create(nil);
  try
    Q.SQL.Text :=
      'select GUID from TAPI_ACCENT_TRANSACTIONS ' +
      'where DATA = :D';
    Q.ParamByName('D').AsDate := Date;
    Q.Open;

    if not Q.IsEmpty then
    begin
      AGuid := Q.FieldByName('GUID').AsString;
      Result := (AGuid <> '');
    end;
  finally
    Q.Free;
  end;
end;

function TdmDB.UpdateJurnalGoodsPricesByColumn(const DocID, DTDep, CTDep, GoodsParentID, ColumnID: Integer; const ComplectName: string; const ComplectGoodsCount: Integer): Boolean;
var
    S, S2: string;
    Query: TIBCQuery;
begin
    Result := False;
    case ColumnID of
        0:
            S := 'Pret de intrare';
        1:
            S := '1 grila';
        2:
            S := '2 grila';
        3:
            S := '3 grila';
        4:
            S := '4 grila';
        5:
            S := '5 grila';
        6:
            S := '6 grila';
        7:
            S := '7 grila';
        9:
            S := 'grila in functie de client';
    end;

    if GoodsParentID = -1 then
        S2 := 'Modificarile se vor aplica pe componentele de baza.'
    else
        S2 := 'Modificarile componentelor din complect' + sLineBreak + ComplectName + sLineBreak + 'Total produse: ' + IntToStr(ComplectGoodsCount);

  // confirmation
    if ShowAskDialog('Modificare preturi produse', 'Modifica preturile curente pe preturile grilei ' + S + ' ?', S2) <> mrYes then
        Exit;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;

        Query.SQL.Text := 'EXECUTE PROCEDURE APPLY_PRICE_GOODSCOMPLECT(:DOCID,:goodsid,:pricecolumn)';
        Query.ParamByName('DOCID').AsInteger := DocID;
    // complect group
        if GoodsParentID = -1 then
            Query.ParamByName('goodsid').Value := Null
        else
            Query.ParamByName('goodsid').AsInteger := GoodsParentID;
    // user's column
        if ColumnID = 9 then
            Query.ParamByName('pricecolumn').Value := Null
        else
            Query.ParamByName('pricecolumn').AsInteger := ColumnID;

        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TdmDB.UpsertTodayGuidToTable(const AGuid: string);
var
  Q: TIBCQuery;
begin
  Q := TIBCQuery.Create(nil);
  try
    Q.SQL.Text :=
      'update or insert into TAPI_ACCENT_TRANSACTIONS (DATA, GUID) ' +
      'values (:D, :G) ' +
      'matching (DATA)';

    Q.ParamByName('D').AsDate    := Date;
    Q.ParamByName('G').AsString  := AGuid;

    Q.ExecSQL;
    Q.Transaction.CommitRetaining;
  finally
    Q.Free;
  end;
end;

procedure TdmDB.WhenCommitSchedulerDelivery(Sender: TObject);
begin
    if IBCQuerySchedulerDelivery.Transaction.Active then
    begin
        IBCQuerySchedulerDelivery.Transaction.Commit;
        IBCQuerySchedulerDelivery.Active := True;
    end;
end;

procedure TdmDB.WhenCommitSchedulerEvents(Sender: TObject);
begin
    if IBCQuerySchedulerEvents.Transaction.Active then
    begin
        IBCQuerySchedulerEvents.Transaction.Commit;
        IBCQuerySchedulerEvents.Active := True;
    end;
end;

{ TGoodsInfo_VendorAndCountry }

procedure TGoodsInfo_VendorAndCountry.SetCountryID(const Value: Integer);
begin
    fCountryID := Value;
end;

procedure TGoodsInfo_VendorAndCountry.SetCountryTitle(const Value: string);
begin
    FCountryTitle := Value;
end;

procedure TGoodsInfo_VendorAndCountry.SetVendorID(const Value: Integer);
begin
    fVendorID := Value;
end;

procedure TGoodsInfo_VendorAndCountry.SetVendorTitle(const Value: string);
begin
    FVendorTitle := Value;
end;

procedure TdmDB.SendSWNMail(mailto, mailsubject, mailbody: string);
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(Self);

    try
        if not IBCTrDefaultUpdate.Active then
            IBCTrDefaultUpdate.StartTransaction;

        q.Transaction := IBCTrDefaultUpdate;

        q.SQL.Text := 'execute procedure SP_CREATE_MAIL_TO_SEND (:MAILTO, '''', :MAILSUBJECT, :MAIL_BODY)';
        q.ParamByName('MAILTO').AsString := mailto;
        q.ParamByName('MAILSUBJECT').AsString := mailsubject;
        q.ParamByName('MAIL_BODY').AsString := mailbody;
        q.ExecSQL;
        if IBCTrDefaultUpdate.Active then
            IBCTrDefaultUpdate.Commit;
    finally
        q.Free;
    end;

end;

function TdmDB.IsKit(GoodsTypeID: Integer): Boolean;
begin
    Result := (GoodsTypeID = cSYSS_GOODS_TYPE_Комплект) or (GoodsTypeID = cSYSS_GOODS_TYPE_Комплект_услуг);
end;

function TdmDB.DoCreateFactura(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
  // Emite "Factura fiscala"
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        try
            Query.Transaction.StartTransaction;

            Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_FISCAL_INVOICE(:DOCID)';
            Query.ParamByName('DOCID').AsInteger := DocID;
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.ConvertAmountByCurrency(OldCurrency, NewCurrency: Integer; Amount: Double): Double;
var
    NewRate: Double;
    OldRate: Double;
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(Self);
    q.SQL.Text := 'select EXCHANGE_RATE from ts_currency where currencyid=:oldcurrencyid';
    q.ParamByName('oldcurrencyid').AsInteger := OldCurrency;
    q.Open;

    OldRate := q.FieldByName('EXCHANGE_RATE').AsFloat;

    q.Close;
    q.SQL.Text := 'select EXCHANGE_RATE from ts_currency where currencyid=:newcurrencyid';
    q.ParamByName('newcurrencyid').AsInteger := NewCurrency;
    q.Open;

    NewRate := q.FieldByName('EXCHANGE_RATE').AsFloat;

    if (OldRate = 0) or (NewRate = 0) then
        Result := Amount
    else
        Result := Amount * OldRate / NewRate;

end;

function TdmDB.DoCreateShipmentDB(const DocID: Integer; const ActiuneList: string): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_SHIPMENT2(:DOCID,:ACLIST)';
            Query.ParamByName('DOCID').AsInteger := DocID;
            Query.ParamByName('ACLIST').AsString := ActiuneList;
      // exec
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetBlobSize(BlobField: TBlobField): Integer;
var
    BS: TBlobStream;
    MS: Integer;
begin
    MS := -1;
    BS := TBlobStream.Create(BlobField, bmRead);
    try
        MS := BS.Size;
    finally
        BS.Free;
        GetBlobSize := MS;
    end;
end;

procedure TdmDB.GetFirmaInfo(FirmaID: Integer);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;

    // read Customer Info: Type and VAT
        Query.SQL.Text := 'select c.customerid, c.displayname, ci.vat_number, ci.iden_number, c.vat, c.customer_type_id from ts_customer c ' + 'inner join ts_cust_info ci on ci.customerid=c.customerid ' + 'where c.customerid=:customerid';
        Query.ParamByName('CUSTOMERID').AsInteger := FirmaID;
        Query.ExecSQL;

        if not Query.Eof then
        begin
            FirmaInfo.FirmaID := FirmaID;
            FirmaInfo.VAT := Query.FieldByName('VAT').AsInteger;
            FirmaInfo.FirmaName := Query.FieldByName('DISPLAYNAME').AsString;
            FirmaInfo.VATCode := Query.FieldByName('VAT_NUMBER').AsString;
            FirmaInfo.CustomerTypeID := Query.FieldByName('CUSTOMER_TYPE_ID').AsInteger;
            FirmaInfo.FiscalCode := Query.FieldByName('IDEN_NUMBER').AsString;
        end;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.ProcessClipboardKeys(const Grid: TcxGridDBTableView; var Key: Word; Shift: TShiftState): Boolean;
//var
//  GoodsID: integer;
//  DT, CT, DocID: integer;
begin
    Result := False;

  // Ctrl+Alt+C - Copy grid to buffer
    if (Key = 67) and (Shift = [ssAlt, ssCtrl]) then
    begin
        ShowCopyGridContent(Self, Grid);
    end
    else    // Ctrl+C
        if (Key = 67) and (Shift = [ssCtrl, ssShift]) then
    begin
      // copy cell content in clipboard
        CopyGridCellTextToClipboard(Grid);
        Key := 0;
        Shift := [];
        Result := True;
    end;
//  // Ctrl + Shift + C -> copy GoodsName, Qty
//  if (Key = 67) and (Shift = [ssCtrl, ssShift]) then
//  begin
//    CopyGoodsNameQtyToClipboard(Grid);
//  end;
end;

function TdmDB.GetLocalIP: string;
type
    TaPInAddr = array[0..10] of PInAddr;

    PaPInAddr = ^TaPInAddr;
var
    phe: PHostEnt;
    pptr: PaPInAddr;
    Buffer: array[0..63] of AnsiChar;
    i: Integer;
    GInitData: TWSAData;
begin
    WSAStartup($101, GInitData);
    Result := '';
    gethostname(Buffer, SizeOf(Buffer));
    phe := gethostbyname(Buffer);
    if phe = nil then
        Exit;
    pptr := PaPInAddr(phe^.h_addr_list);
    i := 0;
    while pptr^[i] <> nil do
    begin
        Result := string(inet_ntoa(pptr^[i]^));
        Inc(i);
    end;
    WSACleanup;
end;

procedure TdmDB.ShowNotification;
//var
//    MyNotification: TNotification; //Defines a TNotification variable
begin
//    MyNotification := NotificationCenter1.CreateNotification; //Creates the notification
//    try
//        MyNotification.Name := 'Windows10Notification'; //Defines the name of the notification.
//        MyNotification.Title := 'Windows 10 Notification #1'; //Defines the name that appears when the notification is presented.
//        MyNotification.AlertBody := 'RAD Studio 10 Seattle'; //Defines the body of the notification that appears below the title.
//
//        NotificationCenter1.PresentNotification(MyNotification); //Presents the notification on the screen.
//    finally
//        MyNotification.Free; //Frees the variable
//    end;
end;

procedure TdmDB.CopyGridCellTextToClipboard(const Grid: TcxGridTableView);
var
    RecordIndex: Integer;
    i, j: Integer;
    MS: TStringList;
    S: string;
    AColumn: TcxGridDBColumn;
    GoodsID: Integer;
    GoodsQTY: Double;
//  UM_NAME: string;
begin
    MS := TStringList.Create;
    try
        for i := 0 to Grid.Controller.SelectedRecordCount - 1 do
        begin
         // multiple cells selected
            GoodsID := -1;

            RecordIndex := Grid.Controller.SelectedRecords[i].RecordIndex;

            if (TcxGridDBColumn(Grid.Controller.FocusedColumn).DataBinding.FieldName = 'GOODS_NAME') then
            begin
                for j := 0 to Grid.ColumnCount - 1 do
                begin
                    AColumn := TcxGridDBTableView(Grid).Columns[j];
                    if AColumn.DataBinding.Field.FieldName = 'GOODSID' then
                    begin
                        GoodsID := Grid.DataController.GetDisplayText(RecordIndex, AColumn.Index).toInteger;
                    end;
                    if AColumn.DataBinding.Field.FieldName = 'QTY' then
                    begin
                        GoodsQTY := Grid.DataController.GetDisplayText(RecordIndex, AColumn.Index).ToDouble;
                        Break;
                    end;
                end;
            end;

            if GoodsID > -1 then
            begin
                S := GoodsQTY.ToString + ' #' + GoodsID.ToString + '- ' + Copy(Grid.DataController.GetDisplayText(RecordIndex, Grid.Controller.FocusedColumn.Index), 1, 60);
            end
            else
                S := Trim(Grid.DataController.GetDisplayText(RecordIndex, Grid.Controller.FocusedColumn.Index));
            if S <> '' then
                MS.Add(S); // append to collection formated row
        end;

        Clipboard.AsText := Trim(MS.Text);
    finally
        MS.Free;
    end;
end;

function TdmDB.GetOrgID(ADT: Integer): Integer;
var
    Query: TIBCQuery;
begin
    Result := -1;
    Query := TIBCQuery.Create(Self);
    try
        Query.SQL.Text := 'select dt orgid from ts_cust_1c where customerid=:customerid';
        Query.ParamByName('CUSTOMERID').AsInteger := ADT;
        Query.Open;

        Result := Query.FieldByName('ORGID').AsInteger;
    finally
        Query.Free;
    end;
end;

function TdmDB.IsDecimalInteger(const S: string): Boolean;
var
    C: Char;
begin
    for C in S do
        if ((C < '0') or (C > '9')) and (C <> '-') then
        begin
            Result := False;
            Exit;
        end;
    Result := True;
end;

procedure TdmDB.LoadSipColors;
begin
    sipITSalesBGColor := AppUserConfigStorage.IntValues.GetValue('ITSales_Background', clPurple);
    sipITSalesFontColor := AppUserConfigStorage.IntValues.GetValue('ITSales_Foreground', clWhite);
    sipFurnitureSalesBGColor := AppUserConfigStorage.IntValues.GetValue('FurnitureSales_Background', clFuchsia);
    sipFurnitureSalesFontColor := AppUserConfigStorage.IntValues.GetValue('FurnitureSales_Foreground', clWhite);
    sipServiceBGColor := AppUserConfigStorage.IntValues.GetValue('Service_Background', clYellow);
    sipServiceFontColor := AppUserConfigStorage.IntValues.GetValue('Service_Foreground', clBlack);
    sipAccountingBGColor := AppUserConfigStorage.IntValues.GetValue('Accounting_Background', clRed);
    sipAccountingFontColor := AppUserConfigStorage.IntValues.GetValue('Accounting_Foreground', clWhite);
    sipPurchaiseBGColor := AppUserConfigStorage.IntValues.GetValue('Purchaise_Background', clTeal);
    sipPurchaiseFontColor := AppUserConfigStorage.IntValues.GetValue('Purchaise_Foreground', clBlack);
end;

procedure TdmDB.DoNotification(aName, aTitle, aBody: string);
var
    appNotification: TNotification;
begin
    appNotification := NotificationCenter.CreateNotification;
    try
        appNotification.Name := aName;
        appNotification.Title := aTitle;
        appNotification.AlertBody := aBody;
        appNotification.EnableSound := True;
        NotificationCenter.PresentNotification(appNotification);
        PlaySound(PWideChar(cSOUND_DefaultAudio), 0, SND_ASYNC);
        ShowThreadInfo(aTitle, aBody);
// Apel cu durată personalizată (3 secunde)
//        ShowThreadInfo('Import', 'Se importă produsele din supplier...', 3000);
    finally
        appNotification.Free;
    end;
end;

procedure TdmDB.AppendCurrentRecord(Dataset: TDataSet);
var
    aField: Variant;
    i: Integer;
begin
    aField := VarArrayCreate([0, Dataset.Fieldcount - 1], varVariant);
    for i := 0 to (Dataset.Fieldcount - 1) do
    begin
        aField[i] := Dataset.fields[i].Value;
    end;
    Dataset.Append;

    for i := 0 to (Dataset.Fieldcount - 1) do
    begin
        if (Dataset.fields[i].CanModify) then
            Dataset.fields[i].Value := aField[i];
    end;
end;

function TdmDB.CheckCurrentGUID: string;
begin
    Result := '';

    var q := TIBCQuery.Create(nil);

    try
        dmDB.openQuery(q, 'select guid from TAPI_ACCENT_TRANSACTIONS where cast(data as date)=current_date', []);
        Result := q.FieldByName('guid').AsString;
    finally
        q.Free;
    end;
end;

procedure TdmDB.QueryCancelUpdate(DataSet: TIBCQuery);
begin
    if DataSet.State in dsEditModes then
        DataSet.Cancel;
end;

procedure TdmDB.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime; var ContractID: Integer; var ContractName: string; var FlgAcnt: Boolean; var ContractCurrencyID: Integer);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.SQL.Add('SELECT * FROM VW_TDB_CONTRACTS C1');
        Query.SQL.Add('WHERE EXISTS(SELECT COUNT(*)');
        Query.SQL.Add('FROM TDB_CONTRACTS C2');
        Query.SQL.Add('WHERE (C2.CT = C1.CT) AND');
        Query.SQL.Add('(CAST(:DATA AS DATE) >= CAST(C2.SIGN_DATE AS DATE)) AND');
        Query.SQL.Add('(CAST(:DATA AS DATE) <= CAST(C2.EXPIRE_DATE AS DATE)) and ');
        Query.SQL.Add('(get_flg_value(c2.flags, 2)=1) HAVING COUNT(*) = 1)');
        Query.SQL.Add('AND CT = :CT order by expire_date desc');
        Query.ParamByName('CT').AsInteger := CustomerID;
        Query.ParamByName('DATA').AsDate := DocDate;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            ContractName := Format('%s (№%s din %s, TVA-%s)', [Query.FieldByName('CONTRACT_TYPE_TITLE').AsString, Query.FieldByName('CODE').AsString, FormatDateTime('dd MMMM yyyy', Query.FieldByName('SIGN_DATE').AsDateTime), Query.FieldByName('VAT').AsString]);

            ContractID := Query.FieldByName('CONTRACTID').AsInteger;
            ContractCurrencyID := Query.FieldByName('CurrencyID').AsInteger;
        end
        else
        begin
            ContractName := '';
            ContractID := -1;
            FlgAcnt := True;
        end;
        Query.Close;
    finally
        Query.Free;
    end;
end;

function TdmDB.GetDefaultDocumentState(ADocTypeID: Integer): integer;
var
    query: TIBCQuery;
begin
    Result := -1;
    query := TIBCQuery.Create(nil);
    try
        query.SQL.Text := 'select stateid from ts_doctypes_states where doctypeid = :doctypeid and int_value=1';
        query.ParamByName('doctypeid').Asinteger := ADocTypeID;
        query.Open;
        Result := query.FieldByName('stateid').AsInteger;
    finally
        query.Free;
    end;
end;

function TdmDB.CreateNewGoods(ParentID: Integer; GoodsName: string; GoodstypeID, WebTypeID: Integer; SupplierGoodsCode: string; VendorID, SupplierID: Integer; Model, BaseParam: string; Price3: Double; Currency3ID: Integer; Price7: Double; Currency7ID: Integer; AFlgRRP: integer; GoodsTypeName: string = ''): Integer;
var
    Query: TIBCQuery;
    GoodsCode: string;
    VendorName: string;
begin
    Result := -1;
    GoodsCode := GoodsName;
    Query := TIBCQuery.Create(Self);

    Query.SQL.Text := 'select title from ts_syss where syssid = :vendorID';
    Query.ParamByName('vendorid').AsInteger := VendorID;
    Query.Open;
    VendorName := Query.FieldByName('TITLE').AsString;
    GoodsCode := StringReplace(GoodsName, VendorName, '', [rfIgnoreCase, rfReplaceALL]);
    try
        Query.AutoCommit := False;
        Query.Debug := True;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        if not Query.Transaction.Active then
            Query.Transaction.StartTransaction;

        Query.SQL.Clear;
        Query.SQL.Add('select goodsid from SP_CREATE_GOODS_FROM_TITLE(:TITLE, :PARENTID, :WEBTYPEID, :VENDORID, :UMID,');
        Query.SQL.Add(':WARRANTY, :SNTYPE, :FOREIGN_CUSTOMERID, :FOREIGN_CODE, ');
        Query.SQL.Add(':CURRENCY4ID, :CURRENCY7ID, :GOODSTYPEID, :MODEL_RO, :MODEL_RU, :BASE_PARAM_RO, :BASE_PARAM_RU,');
        Query.SQL.Add(':PRICE3, :PRICE5, :PRICE7, :CURRENCY3ID, :CURRENCY5ID, :CURRENCY6ID, :flg_rrp)');

        Query.ParamByName('PARENTID').AsInteger := ParentID;
        Query.ParamByName('WEBTYPEID').AsInteger := WebTypeID;
        Query.ParamByName('VENDORID').AsInteger := VendorID;
        Query.ParamByName('UMID').AsInteger := 1;
        Query.ParamByName('WARRANTY').AsInteger := 24;
        Query.ParamByName('SNTYPE').AsInteger := 4402;
        Query.ParamByName('FOREIGN_CUSTOMERID').AsInteger := SupplierID;
        Query.ParamByName('CURRENCY4ID').AsInteger := iif(Currency3ID = 0, 498, Currency3ID);
        Query.ParamByName('CURRENCY7ID').AsInteger := iif(Currency7ID = 0, 840, Currency7ID);
        Query.ParamByName('CURRENCY3ID').AsInteger := iif(Currency3ID = 0, 498, Currency3ID);
        Query.ParamByName('CURRENCY5ID').AsInteger := iif(Currency3ID = 0, 498, Currency3ID);
        Query.ParamByName('CURRENCY6ID').AsInteger := iif(Currency7ID = 0, 840, Currency7ID);

        Query.ParamByName('GOODSTYPEID').AsInteger := GoodstypeID;
        Query.ParamByName('PRICE3').AsFloat := Price3;
        Query.ParamByName('PRICE7').AsFloat := Price7;
        Query.ParamByName('FOREIGN_CODE').AsString := SupplierGoodsCode;
        Query.ParamByName('TITLE').AsString := GoodsCode;
//    Query.ParamByName('TITLE').AsString := GoodsName;

        if (Model = '') then
            Model := Copy(GoodsName, 1, 250);

        Query.ParamByName('MODEL_RO').AsString := Model;
        Query.ParamByName('MODEL_RU').AsString := Model;

        Query.ParamByName('BASE_PARAM_RO').AsString := Copy(BaseParam, 1, 255);
        Query.ParamByName('BASE_PARAM_RU').AsString := Copy(BaseParam, 1, 255);
        Query.parambyname('flg_rrp').Asinteger := AFlgRRP;

        try
            Query.Open;
            Result := Query.FieldbyName('GOODSID').AsInteger;
            Query.Transaction.Commit;
        except
            on E: Exception do
            begin
                if Query.Transaction.Active then
                    Query.Transaction.Rollback;
                raise;
            end;
        end;

    finally
        Query.Free;
    end;

end;

// TODO: GetAccentGUID
//function TdmDB.GetAccentGUID: string;
//var
//  s: string;
//  Resp_Json: string;
//  Req_Json: TStream;
//  JSonObject: TJSONObject;
//  JSonValue: TJSONValue;
//  st: string;
////  tokenID: string;
//begin
//  s := '{';
//  s := s + '"userlogin": "Fantastic.APIUser",';
//  s := s + '"userpassword": "D1519F75556D1D689C3C24C721CCFF9C"';
//  s := s + '}';
//  Req_Json := TStringStream.Create(s);
//  Req_Json.Position := 0;
//  try
//      IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
//      IdHTTP1.Request.Accept := 'application/json, text/javascript, */*; q=0.01';
//      IdHTTP1.Request.ContentType := 'application/json; charset=UTF-8';
//      IdHTTP1.Request.CharSet := 'utf-8';
//      Resp_Json := IdHTTP1.Post('http://b2brestful.accent.md:8090/loginuser/getid', Req_Json);
//  finally
//      Req_Json.Free;
//  end;
//
//  st := Resp_Json;
//  JSonObject := TJSONObject.Create;
//  try
//      JSonValue := JSonObject.ParseJSONValue(st);
//      AccentGuid := (JSonValue as TJSONObject).Get('guid').JSonValue.Value;
//      dmDB.ExecuteQuery('update or insert into TAPI_ACCENT_TRANSACTIONS (data, guid) values (current_date, ' + QuotedStr(AccentGuid) + ') matching (data)', []);
//  finally
//      JSonObject.Free;
//  end;
//
//  Result := AccentGuid;
//end;

function TdmDB.CalcNextPartNo(DefaultPartno: string; AGoodsID: integer): integer;
var
    Query: TIBCQuery;
    S: string;
begin
    Result := 0;
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultSelect;
        Query.SQL.Text := 'SELECT Max(PARTNO) FROM TDB_PARTS WHERE (PARTNO like :FILTER) and (GOODSID=:GOODSID)';
        Query.ParamByName('FILTER').AsString := DefaultPartno + '%';
        Query.ParamByName('GOODSID').AsInteger := AGoodsID;
        Query.ExecSQL;

        if not Query.Eof then
        begin
            S := Query.Fields[0].AsString;
            Delete(S, 1, Length(DefaultPartno));
            Result := StrToIntDef(S, 0);
        end;
        Query.Close;
    finally
        Query.Free;
    end;
    Inc(Result);
end;

function TdmDB.SendSMS(const PhoneNumber, SMSText: string): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := True;
        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrDefaultUpdate;
        Query.SQL.Text := 'INSERT INTO SMS_MESSAGES (PHONE, SMS_TEXT) VALUES (:phone,:text)';
        Query.ParamByName('phone').AsString := PhoneNumber;
        Query.ParamByName('text').AsString := SMSText;
        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

function Tdmdb.GetCurrencyRate(ACurrencyID: integer): double;
begin
    Result := -1;
    var q := TIBCQuery.Create(nil);
    try
        q.SQL.Text := 'select transfer_rate from ts_currency where currencyid = :currencyid';
        q.parambyname('currencyid').AsINteger := ACurrencyID;
        q.Open;

        result := q.FieldByname('transfer_rate').AsFloat;
    finally
        q.Free;
    end;
end;

procedure Tdmdb.GetSupplierGoodsByDocID;
begin
    var q := TIBCQuery.Create(nil);
    try
        q.SQL.Add('SELECT str FROM GET_SUPPLIER_GOODS_BY_DOCID(:DOCID, FALSE)');
        q.ParamByName('docid').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        q.Open;
        Clipboard.AsText := q.FieldByName('str').AsString;
    finally
        q.Free;
    end;
end;

procedure Tdmdb.SaveCurrentUID(AGUID: string);
begin
    var ibcquery := TibcQuery.Create(nil);
    ibcquery.Transaction := IBCTrDefaultUpdate;
    try

        with ibcquery do
        begin
            SQL.Text := 'update or insert into TAPI_ACCENT_TRANSACTIONS (data, GUID) values (:data, :GUID) matching (data)';

            ParamByName('data').AsDate := Date;
            ParamByName('GUID').AsString := AGUID;

            ExecSQL;
            if Transaction.Active then
              Transaction.Commit;
        end;
    finally
        ibcquery.Free;
    end;
end;

function Tdmdb.GetCurrentUID: string;
var
    Q: TIBCQuery;
begin
    Result := '';
    Q := TIBCQuery.Create(nil);
    try
        Q.SQL.Text := 'select GUID from TAPI_ACCENT_TRANSACTIONS ' + 'where data = :data';
        Q.ParamByName('data').AsDate := Date;
        Q.Open;

        if not Q.IsEmpty then
            Result := Q.FieldByName('GUID').AsString;
    finally
        Q.Free;
    end;
end;

procedure TdmDB.IBCQueryDocsAfterPost(DataSet: TDataSet);
begin
  ibcquerydoccomments.Refresh;
end;

procedure TdmDB.TrimiteNotificareComanda(OrderID: Integer);
var
  Bot: TTelegramBot;
  ChatID: string;
  Msg: string;
  ClientName, ClientEmail, ClientPhone, ClientAdres: string;
  TotalAmount: Currency;
  OrderDate: TDateTime;
begin
  // Date din baza de date (exemplu)
  var q := TIBCQuery.Create(nil);
  q.sql.Add('');
  ClientName := 'Ion Popescu';
  ClientEmail := 'ion@example.com';
  ClientAdres := 'Chisinau, str. M. Dragan 2/1';
  ClientPhone := '069 127 845';
  TotalAmount := 3800.00;
  OrderDate := Now;

  Bot := TTelegramBot.Create('TOKEN_TAU');
  ChatID := '-1001234567890';
  try
    // Creează mesajul HTML
    Msg := '<b>🛒 COMANDĂ NOUĂ #' + IntToStr(OrderID) + '</b>' + #10 + #10 +
           '<b>Client:</b> <i>' + EscapeHTML(ClientName) + '</i>' + #10 +
           '<b>Email:</b> <code>' + ClientEmail + '</code>' + #10 +
           '<b>Telefon:</b> <code>' + ClientPhone + '</code>' + #10 + #10 +
           '<u>Total:</u> <b>' + FormatFloat('#,##0.00', TotalAmount) + ' RON</b>' + #10 +
           '<b>Data:</b> <code>' + FormatDateTime('dd.mm.yyyy hh:nn', OrderDate) + '</code>' + #10 + #10 +
           '<a href="https://erp.example.com/orders/' + IntToStr(OrderID) + '">Vezi detalii comandă</a>';

    // Trimite notificarea
    if Bot.SendMessageHTML(ChatID, Msg) then
      ShowMessage('Notificare trimisă în Telegram!')
    else
      ShowMessage('Eroare la trimiterea notificării!');

  finally
    Bot.Free;
  end;
end;

procedure TdmDB.AddToAchizitii(GoodsID, Qty, SupplierID:
    Integer);
begin
   // add to database
   with dmdb.ibcqueryachizitii do
   begin
     Append;
     FieldbyName('DOCID').AsInteger := dmdb.IBCQueryDocs.fieldbyname('docid').AsInteger;
     FieldbyName('GoodsID').AsInteger := GoodsID;
     FieldByName('supplierid').AsInteger := SupplierID;
     FieldByName('supplier_QTY').AsInteger := Qty;
     FieldByName('DTDEP').AsInteger := dmDB.IBCQueryJurnal.FieldByName('DTDEP').AsInteger;
     Post;
   end;
end;



initialization
    fDatabaseAlias := '';
    fLoggingUserID := -1;
    fDBServerAddress := '';
    fDBServerPort := 3050;
    fDBSecurityConfirmation := False;

end.

