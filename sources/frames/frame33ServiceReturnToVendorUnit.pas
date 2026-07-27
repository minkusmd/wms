unit frame33ServiceReturnToVendorUnit;
{
  СЕРВИС. Передача в СЦ, ВП
  DocTypeID = 126
  Frame Index = 33
}

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit,
    cxGraphics, DB, cxDBData, dxBar, ExtCtrls, cxSplitter, cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGridCustomView, cxGrid,
    cxGridCustomPopupMenu, cxGridPopupMenu, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
    cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel, cxImageComboBox,
    dxBarBuiltInMenu, cxClasses, cxGridTableView, dxUIAClasses;

type
    Tframe33ServiceReturnToVendor = class(TSWNBaseFrame)
        cxGridDocs: TcxGrid;
        cxGridDocsTable: TcxGridDBTableView;
        cxGridDocsTableDocID: TcxGridDBColumn;
        cxGridDocsTableData: TcxGridDBColumn;
        cxGridDocsTableWarehouse: TcxGridDBColumn;
        cxGridNPNCol_CT_NAME: TcxGridDBColumn;
        cxGridDocs_SUMA: TcxGridDBColumn;
        cxGridDocs_CURRENCY_NAME: TcxGridDBColumn;
        cxGridDocs_VAT: TcxGridDBColumn;
        cxGridDocs_RATE: TcxGridDBColumn;
        cxGridDocsTableParentDocID: TcxGridDBColumn;
        cxGridDocsTableFlgACNT: TcxGridDBColumn;
        cxGridDocsTableCreatedBy: TcxGridDBColumn;
        cxGridNPN_FLG_CLOSED: TcxGridDBColumn;
        cxGridDocsLevel: TcxGridLevel;
        cxSplitter: TcxSplitter;
        pnBottom: TPanel;
        dxBarDockControl1: TdxBarDockControl;
        dxBarManager: TdxBarManager;
        dxBarManagerBar1: TdxBar;
        bbGoodsNew: TdxBarButton;
        bbGoodsModify: TdxBarButton;
        bbGoodsDelete: TdxBarButton;
        cxGridGoods: TcxGrid;
        cxGridGoodsTable: TcxGridDBTableView;
        cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
        cxGridDBCol_GOODSID: TcxGridDBColumn;
        cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
        cxGridDBCol_Price: TcxGridDBColumn;
        cxGridDBCol_QTY: TcxGridDBColumn;
        cxGridDBCol_SUMA: TcxGridDBColumn;
        cxGridDBCol_K_UM: TcxGridDBColumn;
        cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
        cxGridDBCol_FLG_ACNT: TcxGridDBColumn;
        cxGridDBCol_FLG_READY: TcxGridDBColumn;
        cxGridDBCol_WARRANTY: TcxGridDBColumn;
        cxGridGoodsLevel: TcxGridLevel;
        bbSerials: TdxBarButton;
        cxGridPopupMenuDocs: TcxGridPopupMenu;
        dxBarPopupMenuDocs: TdxBarPopupMenu;
        bbCloseDocument: TdxBarButton;
        bbOpenDocument: TdxBarButton;
        cxGridGoods_PRICE: TcxGridDBColumn;
        cxGridDocs_RATEUSD: TcxGridDBColumn;
        cxGridDocs_DT: TcxGridDBColumn;
        cxGridDocs_CT: TcxGridDBColumn;
        cxGridGoods_DTDEP_NAME: TcxGridDBColumn;
        cxGridDocsTable_SC2_NAME: TcxGridDBColumn;
        bbTTN: TdxBarButton;
        cxGridDBCol_IMG: TcxGridDBColumn;
        dxBarPopupMenuJurnal: TdxBarPopupMenu;
        dxBarButton1: TdxBarButton;
        cxGridDocsTable_CREATED_DATE: TcxGridDBColumn;
        procedure bbGoodsNewClick(Sender: TObject);
        procedure bbGoodsModifyClick(Sender: TObject);
        procedure bbGoodsDeleteClick(Sender: TObject);
        procedure bbSerialsClick(Sender: TObject);
        procedure cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton:
            TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
            var ADone: Boolean);
        procedure bbCloseDocumentClick(Sender: TObject);
        procedure dxBarPopupMenuDocsPopup(Sender: TObject);
        procedure bbOpenDocumentClick(Sender: TObject);
        procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure bbTTNClick(Sender: TObject);
        procedure cxGridDocsTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
        procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
            var ADone: Boolean);
        procedure dxBarButton1Click(Sender: TObject);
    private
    { Private declarations }
        procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
            ANewItemRecordFocusingChanged: Boolean);
        procedure DocumentSelectionChanged;
        procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
            ANewItemRecordFocusingChanged: Boolean);
        procedure GoodsSelectionChanged;
        procedure WhenDocumentPopupMenuOpen;
        procedure ShowAddGoodsDialog;
        procedure ShowModifyGoodsDialog;
        procedure ShowDeleteGoodsDialog;
        procedure ShowGoodsSerialsDialog(const readonly: Boolean = False);
        procedure ShowGoodsPartNumbersDialog(const readonly: Boolean = False);
        function DoCloseDocument(const DocID: integer): Boolean;
        function DoOpenDocument(const DocID: integer): Boolean;
        procedure DoCreateFF;
        function DoCreateTTN(const DocID: Integer): Boolean;
    protected
    { Protected declarations }
        function InitFrameID: integer; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure CreateNewRecord; override;
        procedure ModifyRecord; override;
        procedure DeleteRecord; override;
        procedure SetupSecurityItems; override;
    public
    { Public declarations }
        procedure SetupDefaultFocus; override;
        function GetCurrentSearchContext: TSearchContextValue; override;
    end;

implementation

uses
    IBC, DataModuleDB, frmServiceReturnToVendorDocDialog, SWNUtils, SWNDBErrors, frmSelectGoodsToAddDialog, SWNConst, SWNTypes,
    frmSelectSNDialog, frmSelectPartNumbersDialog, SWNSecurity, SWNSecurityFlags, SWNCommonDialogs;

{$R *.dfm}

{ Tframe31ServiceRequests }

procedure Tframe33ServiceReturnToVendor.bbCloseDocumentClick(Sender: TObject);
begin
    if DoCloseDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
        dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe33ServiceReturnToVendor.bbGoodsDeleteClick(Sender: TObject);
begin
    ShowDeleteGoodsDialog;
end;

procedure Tframe33ServiceReturnToVendor.bbGoodsModifyClick(Sender: TObject);
begin
    ShowModifyGoodsDialog;
end;

procedure Tframe33ServiceReturnToVendor.bbGoodsNewClick(Sender: TObject);
begin
    ShowAddGoodsDialog;
end;

procedure Tframe33ServiceReturnToVendor.bbOpenDocumentClick(Sender: TObject);
begin
    if DoOpenDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
        dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe33ServiceReturnToVendor.bbSerialsClick(Sender: TObject);
var
    FLG_CLOSED: Boolean;
begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет then
    begin
        ShowGoodsSerialsDialog(FLG_CLOSED);
    end
    else if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет then
    begin
        ShowGoodsPartNumbersDialog(FLG_CLOSED);
    end;
end;

procedure Tframe33ServiceReturnToVendor.bbTTNClick(Sender: TObject);
begin
    DoCreateFF;
end;

procedure Tframe33ServiceReturnToVendor.CreateNewRecord;
var
    dialog: TfrmServiceReturnToVendorDocDlg;
begin
    dialog := TfrmServiceReturnToVendorDocDlg.Create(Self);
    try
        dialog.CreateNewDocument := True;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe33ServiceReturnToVendor.cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
    TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    if AButton = mbLeft then
    begin
        DoDocumentDoubleClick;
        AHandled := True;
    end;
end;

procedure Tframe33ServiceReturnToVendor.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    if AViewInfo.GridRecord.Values[cxGridNPN_FLG_CLOSED.Index] = 1 then
    begin
        ACanvas.Font.Color := clGrayText;
        ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
    end;

     // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
        ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe33ServiceReturnToVendor.cxGridDocsTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
    AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridDocsTableData.Index]) then
        AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocsTableData.Index]);
end;

procedure Tframe33ServiceReturnToVendor.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    swnUtils.ProcessCommonKeys(Self, cxGridDocsTable, Key, Shift);
end;

procedure Tframe33ServiceReturnToVendor.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
        ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe33ServiceReturnToVendor.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if ((Key = ORD('O')) or (Key = ord('o'))) and (Shift = [ssCtrl]) then
        TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);

    if ((Key = ORD('Z')) or (Key = ord('z'))) and (Shift = [ssCtrl]) then
        TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
    swnUtils.ProcessCommonKeys(Self, cxGridGoodsTable, Key, Shift);
end;

procedure Tframe33ServiceReturnToVendor.DeleteRecord;
begin
    if ShowAskDialog('Удаление записи', 'Вы хотите удалить возврат товара поставщику №' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString +
        '?') = mrYes then
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

function Tframe33ServiceReturnToVendor.DoCloseDocument(const DocID: integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    if ShowAskDialog('Закрыть документ', 'Вы хотите закрыть документ?') <> mrYes then
        Exit;

    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_VTP(:docID)';
        Query.ParamByName('docID').AsInteger := DocID;

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

function Tframe33ServiceReturnToVendor.DoCreateTTN(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_FISCAL_INVOICE(:DOCID)';
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

procedure Tframe33ServiceReturnToVendor.DocumentSelectionChanged;
var
    fDocNew, fDocEdit, fDocDelete, FLG_CLOSED: Boolean;
begin
    fDocNew := True;     // New document + Security
    fDocEdit := False;
    fDocDelete := False;
    if cxGridDocsTable.DataController.RecNo > 0 then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
        fDocEdit := not FLG_CLOSED;   // Edit + Security
        fDocDelete := not FLG_CLOSED; // Delete + Security
    end;
     // doc
    ButtonStateChanged(fbtADD, fDocNew);
    ButtonStateChanged(fbtMODIFY, fDocEdit);
    ButtonStateChanged(fbtDELETE, fDocDelete);

    WhenDocumentPopupMenuOpen;
    GoodsSelectionChanged;
end;

procedure Tframe33ServiceReturnToVendor.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
    CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
    cxGridGoodsTable.OnFocusedRecordChanged := nil;
    cxGridDocsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
    cxGridGoodsTable.DataController.DataSource := nil;
    cxGridDocsTable.DataController.DataSource := nil;

    inherited;
end;

procedure Tframe33ServiceReturnToVendor.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;

     // 1. Legam grid-urile de datasource-sele
    cxGridDocsTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
    cxGridGoodsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
    cxGridDocsTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;
    cxGridGoodsTable.OnFocusedRecordChanged := WhenGoodsGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
    OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
    DocumentSelectionChanged;
end;

function Tframe33ServiceReturnToVendor.DoOpenDocument(const DocID: integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    if ShowAskDialog('Deschide document', 'Doriti sa deschideti acest document?') <> mrYes then
        Exit;

    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_VTP(:docID)';
        Query.ParamByName('docID').AsInteger := DocID;

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

procedure Tframe33ServiceReturnToVendor.dxBarButton1Click(Sender: TObject);
begin
    inherited;
    TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe33ServiceReturnToVendor.dxBarPopupMenuDocsPopup(Sender: TObject);
begin
    WhenDocumentPopupMenuOpen;
end;

function Tframe33ServiceReturnToVendor.GetCurrentSearchContext: TSearchContextValue;
begin
    Result := inherited;

    if cxGridGoodsTable.Site.Focused then
    begin
          // context from Jurnal: Код + Наименование
        Result.Context := ffGoods;
        Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
        Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
    end
    else if cxGridDocsTable.Site.Focused then
    begin
              // context from Docs
        if cxGridNPNCol_CT_NAME.Focused then
        begin
                   // Контрагент
            Result.Context := ffCustomer;
            Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
            Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
        end
        else if cxGridDocsTableData.Focused then
        begin
                       // Дата
            Result.Context := ffDate;
            Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
        end;
    end;
end;

function Tframe33ServiceReturnToVendor.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [fedsDocs, fedsJurnal];
end;

function Tframe33ServiceReturnToVendor.GetFilterFields: TFrameFilterFields;
begin
    Result := [ffDate, ffCustomer, ffGoods];
end;

function Tframe33ServiceReturnToVendor.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH, fbtADD, fbtMODIFY, fbtDELETE];
end;

procedure Tframe33ServiceReturnToVendor.GoodsSelectionChanged;
var
    fNew, fModify, fDelete, FLG_CLOSED: Boolean;
    fSerials: Boolean;
begin
    fNew := False;
    fModify := False;
    fDelete := False;
    fSerials := False;

    if cxGridDocsTable.DataController.RecNo > 0 then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

        fNew := not FLG_CLOSED;  // Новый товар + Security
        if cxGridGoodsTable.DataController.RecNo > 0 then
        begin
            fModify := not FLG_CLOSED;  // Изменить + Security
            fDelete := not FLG_CLOSED;  // Удалить + Security
               // Серийные, Партий номера + Security
            fSerials := (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (dmDB.IBCQueryJurnal.FieldByName
                ('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);
        end;
    end;

    bbGoodsNew.Enabled := fNew;
    bbGoodsModify.Enabled := fModify;
    bbGoodsDelete.Enabled := fDelete;
    bbSerials.Enabled := fSerials;
end;

function Tframe33ServiceReturnToVendor.InitFrameID: integer;
begin
    Result := 33; // СЕРВИС - Возврат товара поставщику
    dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
end;

procedure Tframe33ServiceReturnToVendor.ModifyRecord;
var
    dialog: TfrmServiceReturnToVendorDocDlg;
begin
    if dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1 then
        Exit;

    dialog := TfrmServiceReturnToVendorDocDlg.Create(Self);
    try
        dialog.CreateNewDocument := False;
        if dialog.ShowModal = mrOk then
        begin
            dmDB.IBCQueryDocs.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe33ServiceReturnToVendor.SetupDefaultFocus;
begin
     // focused grid
    cxGridDocs.SetFocus;
     // set focused column
    cxGridNPNCol_CT_NAME.Focused := True;
    cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe33ServiceReturnToVendor.SetupSecurityItems;
begin
     // Передача в СЦ, ВП
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ПВСВ_Закрыть_документ) then
        bbCloseDocument.Visible := ivNever;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ПВСВ_Открыть_документ) then
        bbOpenDocument.Visible := ivNever;

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SERVICE_RBCF_Genereaza_Factura_Fiscala) then
        bbTTN.Visible := ivNever;

    if dxBarPopupMenuDocs.ItemLinks.VisibleItemCount = 0 then
        cxGridPopupMenuDocs.PopupMenus[0].PopupMenu := nil;
end;

procedure Tframe33ServiceReturnToVendor.ShowAddGoodsDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
    dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        dialog.AddNewGoods := True;
        //dialog.AllowedActions:=dialog.AllowedActions+[acChangePrice];
        if dialog.ShowModal = mrOk then
        begin
            dmDB.IBCQueryDocs.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe33ServiceReturnToVendor.DoCreateFF;
begin
    if ShowAskDialog('Factura Fiscala...', Format('Genereaza "Factura Fiscala" pentru '#13#10'"%s"?', [dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString]))
        = mrYes then
    begin
        if DoCreateTTN(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
            ShowInfoDialog('Factura Fiscala', 'Creata cu succes!');
    end;
end;

procedure Tframe33ServiceReturnToVendor.ShowDeleteGoodsDialog;
begin
    if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, 'Sterge produsul"' + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString + '"?') =
        mrYes then
    begin
        dmDB.IBCQueryJurnal.UpdateTransaction.StartTransaction;
        try
            dmDB.IBCQueryJurnal.Delete;
            dmDB.IBCQueryJurnal.UpdateTransaction.Commit;
            dmDB.IBCQueryDocs.Refresh;
        except
            on E: Exception do
            begin
                dmDB.IBCQueryJurnal.UpdateTransaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    end;
end;

procedure Tframe33ServiceReturnToVendor.ShowGoodsPartNumbersDialog(const ReadOnly: Boolean = False);
var
    dialog: TfrmSelectPartsDlg;
begin
    dialog := TfrmSelectPartsDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        dialog.DocsDataSet := dmDB.IBCQueryDocs;
        dialog.ReadOnly := ReadOnly;
        if dialog.ShowModal = mrOk then
        begin
            dmDB.FullRefresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe33ServiceReturnToVendor.ShowGoodsSerialsDialog(const ReadOnly: Boolean = False);
var
    dialog: TfrmSelectSNDlg;
begin
    dialog := TfrmSelectSNDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        dialog.DocsDataSet := dmDB.IBCQueryDocs;
        dialog.ReadOnly := ReadOnly;
        if dialog.ShowModal = mrOk then
        begin
            dmDB.FullRefresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe33ServiceReturnToVendor.ShowModifyGoodsDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
    dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        dialog.AddNewGoods := False;
        //dialog.AllowedActions:=dialog.AllowedActions+[acChangePrice];
        if dialog.ShowModal = mrOk then
        begin
            dmDB.IBCQueryDocs.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe33ServiceReturnToVendor.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
    TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    DocumentSelectionChanged;
end;

procedure Tframe33ServiceReturnToVendor.WhenDocumentPopupMenuOpen;
var
    FLG_CLOSED: Boolean;
    fOpen, fClose: Boolean;
begin
    fOpen := False;
    fClose := False;
    if cxGridDocsTable.DataController.RecNo > 0 then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
        fClose := not FLG_CLOSED;
        fOpen := FLG_CLOSED;
    end;
    bbCloseDocument.Enabled := fClose;
    bbOpenDocument.Enabled := fOpen;
end;

procedure Tframe33ServiceReturnToVendor.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
    AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    GoodsSelectionChanged;
end;

end.

