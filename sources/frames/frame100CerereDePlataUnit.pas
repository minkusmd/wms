unit frame100CerereDePlataUnit;

// Заявка на оплату
// DocTypeID = 3363
// Frame Index = 100

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes,
    Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, DB, cxDBData, cxGrid, dxBar,
    cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.ExtCtrls, DBAccess, IBC, Vcl.StdCtrls,
    cxGridDBBandedTableView, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
    cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
    dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel, dxBarBuiltInMenu, MemDS, cxClasses,
    cxGridBandedTableView, cxGridTableView, cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGridCustomView,
  dxUIAClasses;

type
    Tframe100CerereDePlata = class(TSWNBaseFrame)
        cxGridBankBPPL: TcxGrid;
        cxGridBankBPPLDBTable: TcxGridDBTableView;
        cxGridBankBPPLDBTableDocID: TcxGridDBColumn;
        cxGridBankBPPL_DATA: TcxGridDBColumn;
        cxGridBankBPPLDBTableCtName: TcxGridDBColumn;
        cxGridBankBPPLDBTableSuma: TcxGridDBColumn;
        cxGridBankBPPLDBTableCurrencyName: TcxGridDBColumn;
        cxGridBankBPPLDBTableVAT: TcxGridDBColumn;
        cxGridBankBPPLDBTableRate: TcxGridDBColumn;
        cxGridBankBPPLDBTableParentDocID: TcxGridDBColumn;
        cxGridBankBPPL_FLG_ACNT: TcxGridDBColumn;
        cxGridBankBPPLDBTableCreatedBy: TcxGridDBColumn;
        cxGridBankBPPLLevel1: TcxGridLevel;
        cxGridBankBPPL_RATEUSD: TcxGridDBColumn;
        cxGridBankBPPL_FLG_CLOSED: TcxGridDBColumn;
        dxBarManager1: TdxBarManager;
        cxGridPopupMenu: TcxGridPopupMenu;
        pmPopupMenuDoc: TdxBarPopupMenu;
        bbProvesti: TdxBarButton;
        bbCancelProvodca: TdxBarButton;
        cxGridBankBPPL_CT: TcxGridDBColumn;
        cxGridBankBPPL_DT: TcxGridDBColumn;
        bbDocComments: TdxBarButton;
        cxGridBankBPPL_SC2_NAME: TcxGridDBColumn;
        bbCustomerDebts: TdxBarButton;
        cxGridBankBPPL_CREATED_DATE: TcxGridDBColumn;
        cxGridBankBPPL_FLG_CHILD: TcxGridDBColumn;
        dxBarButton1: TdxBarButton;
        procedure cxGridBankBPPLDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
            TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure pmPopupMenuDocPopup(Sender: TObject);
        procedure cxGridBankBPPLDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure bbDocCommentsClick(Sender: TObject);
        procedure cxGridBankBPPLDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
            TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure cxGridBankBPPL_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure bbCustomerDebtsClick(Sender: TObject);
        procedure cxGridBankBPPL_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure cxGridCT_CDTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
            AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure dxBarButton1Click(Sender: TObject);
        procedure dxBarButton2Click(Sender: TObject);
    procedure bbProvestiClick(Sender: TObject);
    procedure bbCancelProvodcaClick(Sender: TObject);
    private    { Private declarations }
        fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;
        procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
            APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure SelectionChanged;
        procedure WhenPopupMenuPopup;

        procedure ShowCustomerDebts;
    protected    { Protected declarations }
        function InitFrameID: integer; override;

        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;

        function GetFrameButtons: TFrameButtons; override;
        function GetFilterFields: TFrameFilterFields; override;

        procedure CreateNewRecord; override;
        procedure ModifyRecord; override;
        procedure DeleteRecord; override;
        procedure RefreshData; override;

        procedure ReadFrameStates; override;
        procedure SaveFrameStates; override;

        procedure SetupSecurityItems; override;

    public    { Public declarations }
        procedure GetParamsListForReport(const ParamsList: TStringList); override;
        function GetParamValueForReport(const ParamName: string): Variant; override;
        procedure SetupDefaultFocus; override;
        function GetCurrentSearchContext: TSearchContextValue; override;
    end;

implementation

uses
    DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors, SWNValueStorageUnit,
    SWNSecurity, SWNSecurityFlags, frmCustomerCurrentDebtsDialog,
    frmCerereDePlataDialog, frmCerereDePlataDBDialog;

{$R *.dfm}



procedure Tframe100CerereDePlata.bbCancelProvodcaClick(Sender: TObject);
begin
  inherited;
  dmdb.ExecuteQuery('execute procedure OPEN_CEREREDEPLATA(:DOCID)', [dmdb.IBCQueryDocs.FieldByName('docid').AsInteger]);
  dmdb.IBCQueryDocs.Refresh;
end;

procedure Tframe100CerereDePlata.bbCustomerDebtsClick(Sender: TObject);
begin
    ShowCustomerDebts;
end;

procedure Tframe100CerereDePlata.bbDocCommentsClick(Sender: TObject);
begin
    ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe100CerereDePlata.bbProvestiClick(Sender: TObject);
begin
  inherited;
  dmdb.ExecuteQuery('execute procedure CLOSE_CEREREDEPLATA(:DOCID)', [dmdb.IBCQueryDocs.FieldByName('docid').AsInteger]);
  dmdb.IBCQueryDocs.Refresh;
end;

procedure Tframe100CerereDePlata.CreateNewRecord;
var
    editor: TfrmCerereDePlataDBDlg;
begin
    editor := TfrmCerereDePlataDBDlg.Create(Self, dmDB.ibcquerydocs, dmDB.ibcdatasourcedocs);
    try
//        editor.CustomerID := dmdb.IBCQueryDocs.FieldByName('CT').AsInteger;
//        editor.CustomerName := dmdb.IBCQueryDocs.FieldByName('CT_NAME').AsString;
        editor.PaymentDate := Date;
//        editor.Amount := dmdb.IBCQueryDocs.FieldByName('SUMA').AsFloat;
        editor.CreateNewDocument := True;
        if editor.ShowModal=mrOK then
          dmdb.IBCQueryDocs.Refresh;
    finally
        editor.Free;
    end;
end;

procedure Tframe100CerereDePlata.cxGridBankBPPLDBTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var
    AHandled: Boolean);
begin
    if AButton = mbLeft then
    begin
        DoDocumentDoubleClick;
        AHandled := True;
    end;
end;

procedure Tframe100CerereDePlata.cxGridBankBPPLDBTableCustomDrawCell(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridBankBPPL_FLG_CLOSED.index]) then
    begin
        if AViewInfo.GridRecord.Values[cxGridBankBPPL_FLG_CLOSED.index] = 0 then
        begin
            if not AViewInfo.Selected then
            begin
                    // Document prin contabilitate
                if AViewInfo.GridRecord.Values[cxGridBankBPPL_FLG_ACNT.Index] = 1 then
                    ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
            end;
        end
        else
        begin
            ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
            if not AViewInfo.Selected then
            begin
                if AViewInfo.GridRecord.Values[cxGridBankBPPL_FLG_ACNT.Index] = 1 then
                    ACanvas.Font.Color := $008b8bc5
                else
                    ACanvas.Font.Color := clGrayText;
            end;
        end;
        if AViewInfo.GridRecord.Values[cxGridBankBPPL_FLG_CHILD.index] = 1 then
        begin
            ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
            if not AViewInfo.Selected then
            begin
                ACanvas.Font.Color := clTeal;

            end;
        end;
    end;

     // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    begin
        ACanvas.Brush.Color := $E8E8E8;
    end;
end;

procedure Tframe100CerereDePlata.cxGridBankBPPL_CREATED_DATEGetDisplayText(Sender:
    TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridBankBPPL_CREATED_DATE.Index]) then
        AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridBankBPPL_CREATED_DATE.Index]);
end;

procedure Tframe100CerereDePlata.cxGridBankBPPL_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridBankBPPL_DATA.Index]) then
        AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridBankBPPL_DATA.Index]);
end;

procedure Tframe100CerereDePlata.cxGridCT_CDTableCustomDrawCell(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
        ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe100CerereDePlata.cxGridBankBPPLDBTableKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
    SWNUtils.ProcessCommonKeys(Self, cxGridBankBPPLDBTable, Key, Shift);
end;

procedure Tframe100CerereDePlata.DeleteRecord;
begin
    if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_БАНК_БППЛ, [dmDB.IBCQueryDocs.FieldByName
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

procedure Tframe100CerereDePlata.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
    CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
    cxGridBankBPPLDBTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
    cxGridBankBPPLDBTable.DataController.DataSource := nil;

    inherited;
end;

procedure Tframe100CerereDePlata.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
//begin
//    inherited;
//
//     // 1. Legam grid-urile de datasource-sele
//    cxGridBankBPPLDBTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
//
//     // 2. Selection handlers
//    cxGridBankBPPLDBTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;
//
//     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
//    OpenExternalData(FrameDataFilterInfo);
//
//     // 4. Selection update
//    SelectionChanged;
//
var
  customDataFilter: TFrameDataFilteringInfo;
begin
     // 1. Legam grid-urile de datasource-sele
  cxGridBankBPPLDBTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
  cxGridBankBPPLDBTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  if SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Администратор) or SWNSecurityManager.UserIsPartOfGroup
    (cUserGroup_Director) then
    OpenExternalData(FrameDataFilterInfo)
  else
  begin
    customDataFilter := FrameDataFilterInfo.Clone;
    try
      customDataFilter.ExcludeEmployers:= True;
      OpenExternalData(customDataFilter);
    finally
      customDataFilter.Free;
    end;
  end;

  // 4. Selection update
  SelectionChanged;
end;

procedure Tframe100CerereDePlata.dxBarButton1Click(Sender: TObject);
begin
    FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe100CerereDePlata.dxBarButton2Click(Sender: TObject);
var
    NewDocID: integer;
begin
    if dmDB.CloneDocumentDB(dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger, NewDocID, 0, 1) then
    begin
        dmDB.RefreshDocs;
        dmdb.IBCQueryDocs.Locate('DOCID', NewDocID, []);
        ModifyRecord;
    end;

end;

procedure Tframe100CerereDePlata.pmPopupMenuDocPopup(Sender: TObject);
begin
    WhenPopupMenuPopup;
end;

function Tframe100CerereDePlata.GetCurrentSearchContext: TSearchContextValue;
begin
    Result := inherited;

    if cxGridBankBPPLDBTable.Site.Focused then
    begin
          // context from Docs
        if cxGridBankBPPLDBTableCtName.Focused then
        begin
               // Получатель
            Result.Context := ffCustomer;
            Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
            Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
        end
        else if cxGridBankBPPL_DATA.Focused then
        begin
               // Дата
            Result.Context := ffDate;
            Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
        end
    end
end;

function Tframe100CerereDePlata.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [fedsDocs];
end;

function Tframe100CerereDePlata.GetFilterFields: TFrameFilterFields;
begin
    Result := [ffDate, ffCustomer];
end;

function Tframe100CerereDePlata.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
    if fSYS_Add then
        Result := Result + [fbtADD];
    if fSYS_Edit or fSYS_View then
        Result := Result + [fbtMODIFY];
    if fSYS_Delete then
        Result := Result + [fbtDELETE];
end;

procedure Tframe100CerereDePlata.GetParamsListForReport(const ParamsList: TStringList);
begin
    ParamsList.Add('FAST_MONEY_TRANSFER');
end;

function Tframe100CerereDePlata.GetParamValueForReport(const ParamName: string): Variant;
begin
    if ParamName = 'FAST_MONEY_TRANSFER' then
    begin
        if (dmDb.IBCQueryDocs.FieldByName('SUMA').AsFloat >= 100000) then
            Result := '1'
        else
            Result := '0';
    end;
end;

function Tframe100CerereDePlata.InitFrameID: integer;
begin
    Result := 100;
end;

procedure Tframe100CerereDePlata.ModifyRecord;
var
    editor: TfrmCerereDePlataDBDlg;
begin
    editor := TfrmCerereDePlataDBDlg.Create(Self, dmDB.ibcquerydocs, dmdb.ibcdatasourceDocs);
    try
//        editor.CreateNewDocument := False;
//        editor.ReadOnly := ReadOnly;
//        editor.DocTypeID := dmdb.CurrentDocTypeID;
        editor.CustomerID := dmdb.IBCQueryDocs.FieldByName('CT').AsInteger;
        editor.CustomerName := dmdb.IBCQueryDocs.FieldByName('CT_NAME').AsString;
        editor.PaymentDate := dmdb.IBCQueryDocs.FieldByName('DATA').AsDateTime;
        editor.Amount := dmdb.IBCQueryDocs.FieldByName('SUMA').AsFloat;
        editor.CreateNewDocument := False;
        if editor.ShowModal = mrOK then
        begin
            dmdb.IBCQueryDocs.Refresh;
//          dmdb.ibcqueryDocs.edit;
//          dmdb.ibcquerydocs.FieldByName('DATA').AsDateTime := editor.PaymentDate;
//          dmdb.ibcquerydocs.fieldByName('CT').AsInteger := editor.CustomerID;
//          dmdb.ibcquerydocs.fieldByName('suma').AsFloat := editor.Amount;
//          dmdb.ibcqueryDocs.Post;
        end;
    finally
        editor.Free;
    end;
end;

procedure Tframe100CerereDePlata.WhenPopupMenuPopup;
begin
    bbDocComments.Enabled := fSYS_Edit;
end;

procedure Tframe100CerereDePlata.ReadFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
        ReadGridColumnsSettings(cxGridBankBPPLDBTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe100CerereDePlata.RefreshData;
begin
    inherited;
end;

procedure Tframe100CerereDePlata.SaveFrameStates;
begin
    if SWNSecurityManager.IsPartialAccessMode then
        Exit;

    AppUserConfigStorage.OpenSection(Self.Name);
    try
        SaveGridColumnsSettings(cxGridBankBPPLDBTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe100CerereDePlata.SelectionChanged;
var
    fDocNew, fDocModify, fDocDelete: Boolean;
    FLG_CLOSED: Boolean;
    fCloseDoc, fOpenDoc, fCalcComs: Boolean;
begin
    fDocNew := fSYS_Add;     // New Document + Security
    fDocModify := False;
    fDocDelete := False;

    fCloseDoc := False;
    fOpenDoc := False;
    fCalcComs := False;

    if (cxGridBankBPPLDBTable.DataController.RecNo > 0) then
    begin
        FLG_CLOSED := dmDb.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

        fDocModify := fSYS_Edit and not FLG_CLOSED or fSYS_View; // Edit Document
        fDocDelete := fSYS_Delete and not FLG_CLOSED; // Delete Document

        fCloseDoc := not FLG_CLOSED; // Провести
        fOpenDoc := FLG_CLOSED;      // Отменить проводку
        fCalcComs := FLG_CLOSED;     // Расчитать комиссион банковского платежа
    end;
     // doc
    ButtonStateChanged(fbtADD, fDocNew);
    ButtonStateChanged(fbtMODIFY, fDocModify);
    ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
    bbProvesti.Enabled := fCloseDoc;
    bbCancelProvodca.Enabled := fOpenDoc;
end;

procedure Tframe100CerereDePlata.SetupDefaultFocus;
begin
     // grid
    cxGridBankBPPL.SetFocus;
     // columns
    cxGridBankBPPLDBTableCtName.Focused := True;
end;

procedure Tframe100CerereDePlata.SetupSecurityItems;
begin
    {TODO: de modificat sub tipul nou de document }

    {
    fSYS_View := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Просмотр);
    fSYS_Add := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Создать);
    fSYS_Edit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Изменить);
    fSYS_Delete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Удалить);

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Закрыть_документ) then
        bbProvesti.Visible := ivNever;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Открыть_документ) then
        bbCancelProvodca.Visible := ivNever;

    if pmPopupMenuDoc.ItemLinks.VisibleItemCount = 0 then
        cxGridPopupMenu.PopupMenus[0].PopupMenu := nil;

    }

    fSYS_View := true;
    fSYS_Add := true;
    fSYS_Edit := true;
    fSYS_Delete := True;
    if SWNSecurityManager.IsPartialAccessMode then
    begin
        bbCustomerDebts.Visible := ivNever;
        cxGridBankBPPL_FLG_ACNT.Visible := False;
        cxGridBankBPPL_FLG_ACNT.VisibleForCustomization := False;
    end;
end;

procedure Tframe100CerereDePlata.ShowCustomerDebts;
var
    dialog: TfrmCustomerCurrentDebtsDlg;
begin
    dialog := TfrmCustomerCurrentDebtsDlg.Create(Self);
    try
        dialog.CustomerID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe100CerereDePlata.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    SelectionChanged;
end;

end.

