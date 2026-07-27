unit frame81SalaryUnit;

// КАССА. Приходный кассовый ордер
// DocTypeID = 116
// Frame Index = 1

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes,
    Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, cxFilter,
    cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit, cxLabel, cxCheckBox, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
    cxGridCustomView, cxGrid, StdCtrls, ExtCtrls, cxLookAndFeels, cxLookAndFeelPainters, dxBar,
    cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator, dxDateRanges,
    cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu,
    dxScrollbarAnnotations, cxCalendar, MemDS, DBAccess, IBC, cxImageComboBox, cxSplitter, dxUIAClasses;

type
    Tframe81Salary = class(TSWNBaseFrame)
        cxGridZap: TcxGrid;
        cxGridZapTable: TcxGridDBTableView;
        cxGridZap_FLG_CLOSED: TcxGridDBColumn;
        cxGridZap_DOCID: TcxGridDBColumn;
        cxGridZap_DATA: TcxGridDBColumn;
        cxGridZap_DT_NAME: TcxGridDBColumn;
        cxGridZap_SUMA: TcxGridDBColumn;
        cxGridZap_CURRENCY_NAME: TcxGridDBColumn;
        cxGridZap_VAT: TcxGridDBColumn;
        cxGridZap_RATE: TcxGridDBColumn;
        cxGridZap_RATEUSD: TcxGridDBColumn;
        cxGridZap_PARENTDOCID: TcxGridDBColumn;
        cxGridZap_FLG_ACNT: TcxGridDBColumn;
        cxGridZap_CREATED_BY_NAME: TcxGridDBColumn;
        cxGridZap_CT: TcxGridDBColumn;
        cxGridZap_DT: TcxGridDBColumn;
        cxGridZap_DTSC_NAME: TcxGridDBColumn;
        cxGridZapLevel: TcxGridLevel;
        dxDocPopupMenu: TcxGridPopupMenu;
        dxBarPopupMenu1: TdxBarPopupMenu;
        dxBarManager: TdxBarManager;
        dxBarManagerBar1: TdxBar;
        bbDocClose: TdxBarButton;
        bbDocOpen: TdxBarButton;
        bbFillCustomers: TdxBarButton;
        bbAddCustomer: TdxBarButton;
        bbDeleetCustomer: TdxBarButton;
        bbModifyCustomer: TdxBarButton;
        bbCalcSalary: TdxBarButton;
        bbCustomerTools: TdxBarSubItem;
        bbRecalcMissedHours: TdxBarButton;
        bbDocComments: TdxBarButton;
        btnCopyGrid: TdxBarButton;
        IBCDataSourceEMP: TIBCDataSource;
        IBCQueryEMP: TIBCQuery;
        cxSplitter: TcxSplitter;
        pnBottom: TPanel;
        dxBarDockControl1: TdxBarDockControl;
    Panel1: TPanel;
    cxGridCustomers: TcxGrid;
    cxGridCustomereTable: TcxGridDBTableView;
    cxGridCustomere_CT: TcxGridDBColumn;
    cxGridCustomere_IMG: TcxGridDBColumn;
    cxGridCustomere_CT_NAME: TcxGridDBColumn;
    cxGridCustomere_SUMA_CALCULATA: TcxGridDBColumn;
    cxGridCustomere_SUMA_AVANS: TcxGridDBColumn;
    cxGridCustomere_SUMA_BONUS: TcxGridDBColumn;
    cxGridCustomereSUMA_PENALITATI: TcxGridDBColumn;
    cxGridCustomere_ORE_LUCRATE: TcxGridDBColumn;
    cxGridCustomere_COMMENTS: TcxGridDBColumn;
    cxGridCustomersLevel: TcxGridLevel;
    Panel2: TPanel;
    cxGrid_Articles: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGrid2_ARTICLE_NAME: TcxGridDBColumn;
    cxGrid2_SUMA_MDL: TcxGridDBColumn;
    IBCQueryEmpDetail: TIBCQuery;
    IBCDataSourceEmpDetail: TIBCDataSource;
        procedure bbFillCustomersClick(Sender: TObject);
    private    { Private declarations }
//    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete, fSECURITY_OnlyOwnDocuments: Boolean;
        fSYS_Create, fSYS_Edit, fSYS_Delete, fSYS_View: Boolean;
        fSYS_RestrictedView: Boolean;
        procedure DoFillCustomers;
        function DoFillCustomersDB(const DocID: integer): Boolean;
        procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
            AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure OpenData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
        procedure DocumentSelectionChanged;
        procedure CustomersSelectionChanged;
    protected    { Protected declarations }
        function InitFrameID: integer; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        procedure WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure CreateNewRecord; override;
        procedure ModifyRecord; override;
        procedure DeleteRecord; override;
        procedure ReadFrameStates; override;
        procedure SaveFrameStates; override;
        procedure SetupSecurityItems; override;
    public    { Public declarations }
        procedure SetupDefaultFocus; override;
        function GetCurrentSearchContext: TSearchContextValue; override;
    end;

implementation

uses
    DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, DateUtils,
    SWNValueStorageUnit, frmCustomerCurrentDebtsDialog, SWNSecurity, frmPKODocDialog,
    SWNSecurityFlags, frmCustomerNotifyDebtsDialog, frm81DocDialog,
    frmRascetZarplatiDocDialog;

{$R *.dfm}

procedure Tframe81Salary.bbFillCustomersClick(Sender: TObject);
begin
    inherited;
    DoFillCustomers;
end;

procedure Tframe81Salary.DoFillCustomers;
var
    s: string;
begin
    s := '';
    if cxGridCustomereTable.DataController.RecordCount > 0 then
        s := 'Текущие записи будут удаленны!';

    if ShowAskDialog('Привести контрагентов',
        'Вы хотите заполнить список всеми работниками из фирмы документа?', s) = mrYes then
    begin
        if DoFillCustomersDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
        begin
               //dmDB.IBCQueryDocs.Refresh;
            IBCQueryEMP.Refresh;
        end;
    end;
end;

procedure Tframe81Salary.CreateNewRecord;
var
    editor: TfrmRascetZarplatiDocDlg;
begin
    editor := TfrmRascetZarplatiDocDlg.Create(Self);
    try
        editor.CreateNewDocument := True;
        editor.ShowModal;
    finally
        editor.Free;
    end;
end;

procedure Tframe81Salary.DeleteRecord;
begin
    if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_46, [dmDB.IBCQueryDocs.FieldByName
        ('DOCID').asInteger])) = mrYes then
    begin
        dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
        try
            dmDB.IBCQueryDocs.Delete;
            dmDB.IBCQueryDocs.UpdateTransaction.Commit;
        except
            on E: Exception do
            begin
                dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    end;
end;

function Tframe81Salary.DoFillCustomersDB(const DocID: integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.AutoCommit := False;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_RASCETZARPLATI_FILL(:DOCID)';
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

procedure Tframe81Salary.DoFrameHide;
begin
     // inchidem datele interne
    IBCQueryEMP.Active := false;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
    CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
    cxGridZapTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
    cxGridZapTable.DataController.DataSource := nil;

    inherited;
end;

procedure Tframe81Salary.OpenData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    IBCQueryEMP.Close;

     // la Redvaris se poate de uitat conform drepturilor de acces. Pentru alte firme, trebuie sa fie numai dekit si Admin
    if not SWNSecurityManager.LoggedUser.IsInAdminGroup and not SWNSecurityManager.UserIsPartOfGroup
        (cUserGroup_Director) then
    begin
          // ascundem butoanele
        bbFillCustomers.Visible := ivNever;
        bbAddCustomer.Visible := ivNever;
        bbModifyCustomer.Visible := ivNever;
        bbDeleetCustomer.Visible := ivNever;
        bbCalcSalary.Visible := ivNever;
        bbCustomerTools.Visible := ivNever;
    end
    else
    begin
        bbFillCustomers.Visible := ivAlways;
        bbAddCustomer.Visible := ivAlways;
        bbModifyCustomer.Visible := ivAlways;
        bbDeleetCustomer.Visible := ivAlways;
        bbCalcSalary.Visible := ivAlways;
        bbCustomerTools.Visible := ivAlways;

        if fSYS_RestrictedView then
        begin
               // aratam numai inregistrarea userului curent
            IBCQueryEMP.FilterSQL := Format('CT=%d', [SWNSecurityManager.LoggedUser.CustomerID]);
        end;

        IBCQueryEMP.Open;
    end;
end;

procedure Tframe81Salary.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
    customDataFilter: TFrameDataFilteringInfo;
begin
    inherited;

     // 1. Legam grid-urile de datasource-sele
    cxGridZapTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
    cxGridZapTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
    OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
    OpenData(FrameDataFilterInfo);

     // 4. Selection update
    DocumentSelectionChanged;
end;

procedure Tframe81Salary.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    DocumentSelectionChanged;
end;

procedure Tframe81Salary.DocumentSelectionChanged;
var
    fDocNew, fDocEdit, fDocDelete: Boolean;
    FLG_CLOSED: Boolean;
    fFillCustomers, fAddCustomer, fCtTools: Boolean;
    fDocClose, fDocOpen: Boolean;
begin
    fDocNew := fSYS_Create;
    fDocEdit := False;
    fDocDelete := False;
    fFillCustomers := False;
    fAddCustomer := False;
    fCtTools := False;
    fDocClose := False;
    fDocOpen := False;

    if cxGridZapTable.DataController.RecNo > 0 then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

        fDocEdit := (fSYS_Edit and not FLG_CLOSED) or fSYS_View;
        fDocDelete := fSYS_Delete and (not FLG_CLOSED);

        fFillCustomers := not FLG_CLOSED;
        fAddCustomer := not FLG_CLOSED;

        fCtTools := not FLG_CLOSED;

        fDocClose := not FLG_CLOSED;
        fDocOpen := FLG_CLOSED;
    end;

     // doc
    ButtonStateChanged(fbtADD, fDocNew);
    ButtonStateChanged(fbtMODIFY, fDocEdit);
    ButtonStateChanged(fbtDELETE, fDocDelete);

    bbFillCustomers.Enabled := fFillCustomers;
    bbAddCustomer.Enabled := fAddCustomer;
    bbCustomerTools.Enabled := fCtTools;

     // popup
    bbDocClose.Enabled := fDocClose;
    bbDocOpen.Enabled := fDocOpen;

    CustomersSelectionChanged;
end;

procedure Tframe81Salary.CustomersSelectionChanged;
var
    fEdit, fDelete, fCalc, fReCalcMissHours: Boolean;
    FLG_CLOSED: Boolean;
begin
    fEdit := False;
    fDelete := False;
    fCalc := False;
    fReCalcMissHours := False;

    if dmDB.IBCQueryDocs.Active then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
        fReCalcMissHours := not FLG_CLOSED and (cxGridCustomereTable.DataController.RecordCount > 0);
    end;

    if cxGridZapTable.DataController.RecNo > 0 then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
        if (not FLG_CLOSED) and (cxGridCustomereTable.DataController.RecNo > 0) then
        begin
            fEdit := True;
            fDelete := True;
            fCalc := True;
        end;
    end;

    bbModifyCustomer.Enabled := fEdit;
    bbDeleetCustomer.Enabled := fDelete;
    bbCalcSalary.Enabled := fCalc;
    bbRecalcMissedHours.Enabled := fReCalcMissHours;
end;

function Tframe81Salary.GetCurrentSearchContext: TSearchContextValue;
begin
    Result := inherited;

    if cxGridZapTable.Site.Focused then
    begin
          // context from Docs
        if cxGridZap_DATA.Focused then
        begin
               // Дата
            Result.Context := ffDate;
            Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
        end
    end
end;

function Tframe81Salary.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [fedsDocs];
end;

function Tframe81Salary.GetFilterFields: TFrameFilterFields;
begin
    Result := [ffDate, ffCustomer];
end;

function Tframe81Salary.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
    if fSYS_Create then
        Result := Result + [fbtADD];
    if fSYS_Edit or fSYS_View then
        Result := Result + [fbtMODIFY];
    if fSYS_Delete then
        Result := Result + [fbtDELETE];
end;

function Tframe81Salary.InitFrameID: integer;
begin
     // КАССА. Приходный кассовый ордер
    Result := 81;
end;

procedure Tframe81Salary.ModifyRecord;
var
    editor: TfrmRascetZarplatiDocDlg;
    FLG_CLOSED: Boolean;
    canEdit: Boolean;
begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    canEdit := fSYS_Edit and (not FLG_CLOSED);
    if not (canEdit or fSYS_View) then
        Exit;

    editor := TfrmRascetZarplatiDocDlg.Create(Self);
    try
        editor.CreateNewDocument := False;
        editor.readonly := (not canEdit) and fSYS_View;
        editor.ShowModal;
    finally
        editor.Free;
    end;
end;

procedure Tframe81Salary.ReadFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
//    ReadGridColumnsSettings(cxGridCasaPKODBTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe81Salary.SaveFrameStates;
begin
    if SWNSecurityManager.IsPartialAccessMode then
        Exit;

    AppUserConfigStorage.OpenSection(Self.Name);
    try
//    SaveGridColumnsSettings(cxGridCasaPKODBTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe81Salary.SetupDefaultFocus;
begin
     // focused grid
    cxGridZap.SetFocus;
     // set focused column
    cxGridZap_DT_NAME.Focused := True;
    cxGridCustomere_CT_NAME.Focused := True;
end;

procedure Tframe81Salary.SetupSecurityItems;
begin
    fSYS_Create := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_РЗ_Создать);
    fSYS_Edit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_РЗ_Редактировать);
    fSYS_Delete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_РЗ_Удалить);
    fSYS_View := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_РЗ_Просмотр);

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_РЗ_Закрыть_документ) then
        bbDocClose.Visible := ivNever;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_РЗ_Открыть_закрытый_документ) then
        bbDocOpen.Visible := ivNever;

     // customers
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_РЗ_Заполнить_список_контрагентами)
        then
        bbFillCustomers.Visible := ivNever;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_РЗ_Добавить_контрагента) then
        bbAddCustomer.Visible := ivNever;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_РЗ_Удалить_контрагента) then
        bbDeleetCustomer.Visible := ivNever;

  // nu e voie de redactat daca documentul e inchis si nu se poate de deschis documentul

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_РЗ_Изменить_данные_контрагента) then
        bbModifyCustomer.Visible := ivNever;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_РЗ_Расчитать_зарплату) then
        bbCalcSalary.Visible := ivNever;

    dxBarManagerBar1.Visible := dxBarManagerBar1.ItemLinks.VisibleItemCount > 0;

    fSYS_RestrictedView := fSYS_View and not (fSYS_Create or fSYS_Edit or fSYS_Delete);
    if fSYS_RestrictedView then
    begin
        cxGridCustomere_SUMA_AVANS.Visible := False;
        cxGridCustomere_SUMA_AVANS.VisibleForCustomization := False;
        cxGridCustomere_SUMA_BONUS.Visible := False;
        cxGridCustomere_SUMA_BONUS.VisibleForCustomization := False;
        cxGridCustomere_ORE_LUCRATE.Visible := False;
        cxGridCustomere_ORE_LUCRATE.VisibleForCustomization := False;
        cxGridCustomere_COMMENTS.Visible := False;
        cxGridCustomere_COMMENTS.VisibleForCustomization := False;
    end;

end;

procedure Tframe81Salary.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    IBCQueryEMP.Close;
    inherited;
    OpenData(FrameDataFilterInfo);
end;

end.

