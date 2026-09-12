unit frame32ServiceRequestsWarrantyUnit;
{
  SERVICE. Cereri de reparatie in garantie
  DocTypeID = 125
  Frame Index = 32
}

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
    SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, DB, cxDBData,
    dxBar, ExtCtrls, cxSplitter, cxGridLevel,
    cxGridCustomTableView, cxGridDBTableView, cxGridCustomView, cxGrid,
    cxGridPopupMenu, DBAccess, IBC,
    cxPC, cxDBCheckListBox, cxDBEdit,
    Vcl.StdCtrls, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxLabel,
  cxCurrencyEdit, cxCheckBox, cxContainer, MemDS, cxGridCustomPopupMenu, cxClasses, cxMemo, cxCustomListBox,
  cxCheckListBox, cxTextEdit, cxGridTableView, dxUIAClasses;

type
    Tframe32ServiceRequestsWarranty = class(TSWNBaseFrame)
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
        cxGridDBCol_UM_NAME: TcxGridDBColumn;
        cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
        cxGridDBCol_FLG_ACNT: TcxGridDBColumn;
        cxGridDBCol_FLG_READY: TcxGridDBColumn;
        cxGridDBCol_WARRANTY: TcxGridDBColumn;
        cxGridGoodsLevel: TcxGridLevel;
        bbGoodsSerials: TdxBarButton;
        bbCloseDoc: TdxBarButton;
        bbOpenDoc: TdxBarButton;
        cxGridDocs_RATEUSD: TcxGridDBColumn;
        cxGridDocs_DT: TcxGridDBColumn;
        cxGridDocs_CT: TcxGridDBColumn;
        cxGridDocs_CTSC: TcxGridDBColumn;
        cxGridDocs_CREATED_DATE: TcxGridDBColumn;
        bbReturnGoodsToCustomer: TdxBarButton;
        bbComments: TdxBarButton;
        cxGridPopupMenuDocs: TcxGridPopupMenu;
        dxBarPopupMenuDoc: TdxBarPopupMenu;
        pcPageControl: TcxPageControl;
        tbsGoods: TcxTabSheet;
        tbsFiles: TcxTabSheet;
        cxGridFiles: TcxGrid;
        cxGridFilesTable: TcxGridDBTableView;
        cxGridFiles_FILENAME: TcxGridDBColumn;
        cxGridFiles_FILESIZE: TcxGridDBColumn;
        cxGridFilesLevel: TcxGridLevel;
        dxBarDockControl2: TdxBarDockControl;
        dxBarDockControl1: TdxBarDockControl;
        dxBarManagerBar2: TdxBar;
        bbAddFile: TdxBarButton;
        bbDeleteFile: TdxBarButton;
        IBCQueryFiles: TIBCQuery;
        IBCDataSourceFiles: TIBCDataSource;
        cxGridFiles_CREATED_BY_NAME: TcxGridDBColumn;
        cxGridFiles_IMG: TcxGridDBColumn;
        cxGridFiles_DATA: TcxGridDBColumn;
        bbSaveFile: TdxBarButton;
        bbSelectFromSell: TdxBarButton;
        cxGridDBCol_IMG: TcxGridDBColumn;
        cxTabSheet1: TcxTabSheet;
        dxBarDockControl3: TdxBarDockControl;
        dxBarManagerBar3: TdxBar;
        bbEditProductDescription: TdxBarButton;
        IBCQueryINFO: TIBCQuery;
        IBCDataSourceINFO: TIBCDataSource;
        Label1: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        edCERTIFICAT_NUMAR: TcxDBTextEdit;
        clbFLAGS_SCOP: TcxDBCheckListBox;
        Label2: TLabel;
        clbFLAGS_COMPLECTINFO: TcxDBCheckListBox;
        Label5: TLabel;
        Label6: TLabel;
        mmDEFECTE_PRESUPUSE: TcxDBMemo;
        Label7: TLabel;
        mmDEFECTE_ESTETITE: TcxDBMemo;
        Label8: TLabel;
        mmEXAMINAREA_PREVENTIVA: TcxDBMemo;
        edCERTIFICAT_DATA: TcxDBTextEdit;
        edCERTIFICAT_TIP: TcxDBTextEdit;
        dxBarPopupMenuGOODS: TdxBarPopupMenu;
        cxGridPopupMenuGOODS: TcxGridPopupMenu;
        bbGoodsInfoCard: TdxBarButton;
        bbGoodsPrice: TdxBarButton;
        bbGoodsForeignCode: TdxBarButton;
        cxGridDocsTableColumn1: TcxGridDBColumn;
        dxBarButton1: TdxBarButton;
        dxBarButton2: TdxBarButton;
        dxBarButton3: TdxBarButton;
        bbInvoice: TdxBarButton;
        procedure bbGoodsNewClick(Sender: TObject);
        procedure bbGoodsModifyClick(Sender: TObject);
        procedure bbGoodsDeleteClick(Sender: TObject);
        procedure bbGoodsSerialsClick(Sender: TObject);
        procedure cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
            TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
            TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
            TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure bbCloseDocClick(Sender: TObject);
        procedure bbOpenDocClick(Sender: TObject);
        procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure bbReturnGoodsToCustomerClick(Sender: TObject);
        procedure bbCommentsClick(Sender: TObject);
        procedure bbAddFileClick(Sender: TObject);
        procedure bbDeleteFileClick(Sender: TObject);
        procedure cxGridFiles_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
            var AText: string);
        procedure bbSaveFileClick(Sender: TObject);
        procedure bbSelectFromSellClick(Sender: TObject);
        procedure cxGridDocsTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure cxGridDocs_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure bbEditProductDescriptionClick(Sender: TObject);
        procedure bbGoodsInfoCardClick(Sender: TObject);
        procedure bbGoodsPriceClick(Sender: TObject);
        procedure bbGoodsForeignCodeClick(Sender: TObject);
        procedure dxBarButton1Click(Sender: TObject);
        procedure dxBarButton2Click(Sender: TObject);
        procedure dxBarButton3Click(Sender: TObject);
        procedure bbInvoiceClick(Sender: TObject);
    private
    { Private declarations }
        fCanCreateDoc, fCanEditDoc, fCanDeleteDoc: Boolean;
        procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
            AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure DocumentSelectionChanged;
        procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
            AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure GoodsSelectionChanged;
        procedure WhenFilesGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
            AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure FilesSelectionChanged;
        procedure ShowAddGoodsDialog;
        procedure ShowModifyGoodsDialog;
        procedure ShowDeleteGoodsDialog;
        procedure ShowGoodsSerialsDialog(const ReadOnly: Boolean = False);
        procedure ShowGoodsPartNumbersDialog(const ReadOnly: Boolean = False);
        function DoCloseDocument(const DocID: Integer): Boolean;
        function DoOpenDocument(const DocID: Integer): Boolean;
        procedure SaveFileAs;
        procedure SaveFileAsDB(const FileName: string; const AttachmentID: Integer);
        procedure ShowSelectGoodsFromSellDialog;
        function ImportGoodsFromSellDB(const GoodsList, SNList: string): Boolean;
    protected
    { Protected declarations }
        function InitFrameID: Integer; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure CreateNewRecord; override;
        procedure ModifyRecord; override;
        procedure DeleteRecord; override;
        procedure RefreshData; override;
        procedure ReadFrameStates; override;
        procedure SaveFrameStates; override;
        procedure SetupSecurityItems; override;
    public
    { Public declarations }
        procedure SetupDefaultFocus; override;
        function GetCurrentSearchContext: TSearchContextValue; override;
    end;

implementation

uses
    DataModuleDB, SWNUtils, frmServiceRequestWarrantyDocDialog, frmSelectGoodsToAddDialog, SWNDBErrors,
    SWNConst, SWNTypes, frmSerialNumbersDialog, SWNSecurity, frmPartNumbersDialog, SWNSecurityFlags,
    frm53RPPFileEditorDialog, frmServiceRequestWarrantySelectGoodsFromSellDialog, SWNValueStorageUnit,
    frmServiceRequestWarrantyDescriptionDialog, SWNCommonDialogs, frmMoneyIncomeDialog,
    frmServiceRequestWarantySelectFoodsFromDocumentUnit;

{$R *.dfm}
{ Tframe31ServiceRequests }

procedure Tframe32ServiceRequestsWarranty.bbCloseDocClick(Sender: TObject);
begin
    if DoCloseDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
        dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe32ServiceRequestsWarranty.bbCommentsClick(Sender: TObject);
begin
    ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe32ServiceRequestsWarranty.bbGoodsDeleteClick(Sender: TObject);
begin
    ShowDeleteGoodsDialog;
end;

procedure Tframe32ServiceRequestsWarranty.bbGoodsForeignCodeClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe32ServiceRequestsWarranty.bbGoodsInfoCardClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
        ('GOODS_NAME').AsString);
end;

procedure Tframe32ServiceRequestsWarranty.bbGoodsModifyClick(Sender: TObject);
begin
    ShowModifyGoodsDialog;
end;

procedure Tframe32ServiceRequestsWarranty.bbGoodsNewClick(Sender: TObject);
begin
    ShowAddGoodsDialog;
end;

procedure Tframe32ServiceRequestsWarranty.bbGoodsPriceClick(Sender: TObject);
begin
    TSWNCommonDialogs.ModifyGoodsPriceDlg(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
        ('GOODS_NAME').AsString);
end;

procedure Tframe32ServiceRequestsWarranty.bbGoodsSerialsClick(Sender: TObject);
var
    FLG_CLOSED: Boolean;
begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет then
    begin
        ShowGoodsSerialsDialog(FLG_CLOSED);
    end
    else if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger =
        cSYSS_GOODS_SERIAL_TYPE_Партийный_учет then
    begin
        ShowGoodsPartNumbersDialog(FLG_CLOSED);
    end;
end;

procedure Tframe32ServiceRequestsWarranty.bbInvoiceClick(Sender: TObject);
var
    Query: TIBCQuery;
begin

    if ShowAskDialog('Factura Fiscala"', 'Eliberati Factura Fiscala?') = mrYes then
    begin
        Query := TIBCQuery.Create(Self);
        try
            Query.Connection := dmDB.IBCConnection;
            Query.Transaction := dmDB.IBCTrDefaultUpdate;
            Query.Transaction.StartTransaction;
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_FISCAL_INVOICE_MINUS(:DOCID)';

            Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
            try

                Query.ExecSQL;
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
end;

procedure Tframe32ServiceRequestsWarranty.bbOpenDocClick(Sender: TObject);
begin
    if DoOpenDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
        dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe32ServiceRequestsWarranty.bbReturnGoodsToCustomerClick(Sender: TObject);
var
    Query: TIBCQuery;
begin
    if ShowAskDialog('Primire produse in garantie', 'Inchideti documentul?') <> mrYes then
        Exit;

    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_RETURN_CUST_GOODS(:docID)';
        Query.ParamByName('docID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

        try
            Query.Transaction.StartTransaction;
            Query.ExecSQL;
            Query.Transaction.Commit;

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

procedure Tframe32ServiceRequestsWarranty.bbSaveFileClick(Sender: TObject);
begin
    SaveFileAs;
end;

procedure Tframe32ServiceRequestsWarranty.bbSelectFromSellClick(Sender: TObject);
begin
    ShowSelectGoodsFromSellDialog;
end;

procedure Tframe32ServiceRequestsWarranty.CreateNewRecord;
var
    dialog: TfrmServiceRequestWarrantyDocDlg;
begin
    dialog := TfrmServiceRequestWarrantyDocDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
    try
        dialog.CreateNewDocument := True;
        dialog.ShowModal;
        GoodsSelectionChanged;
    finally
        dialog.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    DoDocumentDoubleClick;
    AHandled := True;
end;

procedure Tframe32ServiceRequestsWarranty.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    if AViewInfo.GridRecord.Values[cxGridNPN_FLG_CLOSED.Index] = 1 then
    begin
        ACanvas.Font.Color := clGrayText;
        ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
    end;

    if AViewInfo.RecordViewInfo.Selected and not AViewInfo.Focused then
    begin
        ACanvas.Brush.Color := $E8E8E8;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.cxGridDocsTableDataGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridDocsTableData.Index]) then
        AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocsTableData.Index]);
end;

procedure Tframe32ServiceRequestsWarranty.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    swnUtils.ProcessCommonKeys(Self, cxGridDocsTable, Key, Shift);
end;

procedure Tframe32ServiceRequestsWarranty.cxGridDocs_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridDocs_CREATED_DATE.Index]) then
        AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocs_CREATED_DATE.Index]);
end;

procedure Tframe32ServiceRequestsWarranty.cxGridFiles_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridFiles_DATA.Index]) then
        AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridFiles_DATA.Index]);
end;

procedure Tframe32ServiceRequestsWarranty.cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    if bbGoodsModify.Enabled then
    begin
        bbGoodsModifyClick(bbGoodsModify);
        AHandled := True;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    swnUtils.ProcessCommonKeys(Self, cxGridGoodsTable, Key, Shift);
end;

procedure Tframe32ServiceRequestsWarranty.DeleteRecord;
begin
    if not fCanDeleteDoc or (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1) then
        Exit;

    if ShowAskDialog('Stergere inregistrare', Format('Doriti sa stergeti cererea de reparatie in garantie nr.%d?', [dmDB.IBCQueryDocs.FieldByName
        ('DOCID').AsInteger])) <> mrYes then
        Exit;

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

function Tframe32ServiceRequestsWarranty.DoCloseDocument(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    if ShowAskDialog('Inchide documentul', 'Doriti sa inchideti documentul?') <> mrYes then
        Exit;

    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_ZGR(:docID)';
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

procedure Tframe32ServiceRequestsWarranty.DocumentSelectionChanged;
var
    fDocNew, fDocEdit, fDocDelete: Boolean;
    FLG_CLOSED, fClose, fOpen, fComments: Boolean;
begin
    fDocNew := fCanCreateDoc;
    fDocEdit := False;
    fDocDelete := False;
    fClose := False;
    fOpen := False;
    fComments := False;

    if cxGridDocsTable.DataController.RecNo > 0 then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

        fDocEdit := fCanEditDoc and not FLG_CLOSED;
        fDocDelete := fCanDeleteDoc and not FLG_CLOSED;

        fClose := not FLG_CLOSED;
        fOpen := FLG_CLOSED;
        fComments := fCanEditDoc;
    end;
     // doc
    ButtonStateChanged(fbtADD, fDocNew);
    ButtonStateChanged(fbtMODIFY, fDocEdit);
    ButtonStateChanged(fbtDELETE, fDocDelete);

//  bbSelectFromSell.Enabled := fDocEdit;
    bbEditProductDescription.Enabled := fDocEdit;
    bbCloseDoc.Enabled := fClose;
    bbOpenDoc.Enabled := fOpen;
    bbComments.Enabled := fComments;

    GoodsSelectionChanged;
    FilesSelectionChanged;
end;

procedure Tframe32ServiceRequestsWarranty.DoFrameHide;
begin
     // inchidem datele interne
    IBCQueryINFO.Active := False;
    IBCQueryFiles.Active := False;

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

procedure Tframe32ServiceRequestsWarranty.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;

    pcPageControl.ActivePage := tbsGoods;

     // 1. Legam grid-urile de datasource-sele
    cxGridDocsTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
    cxGridGoodsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
    cxGridDocsTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;
    cxGridGoodsTable.OnFocusedRecordChanged := WhenGoodsGrid_FocusedRecordChanged;
    cxGridFilesTable.OnFocusedRecordChanged := WhenFilesGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
    OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
    IBCQueryFiles.Active := True;
    IBCQueryINFO.Active := True;

     // 4. Selection update
    DocumentSelectionChanged;
end;

function Tframe32ServiceRequestsWarranty.DoOpenDocument(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    if ShowAskDialog('Deschide documentul', 'Doriti sa deschideti documentul?') <> mrYes then
        Exit;

    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_ZGR(:docID)';
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

procedure Tframe32ServiceRequestsWarranty.dxBarButton1Click(Sender: TObject);
var
    Query: TIBCQuery;
    dialog: TfrmMoneyIncomeDlg;
begin
    dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
    try
        dialog.SetCustomTitle('Dispozitie de plata', 'Dispozitie de plata din casa');

        if dialog.ShowModal = mrOk then
        begin

            Query := TIBCQuery.Create(Self);
            try
                Query.Connection := dmDB.IBCConnection;
                Query.Transaction := dmDB.IBCTrDefaultUpdate;
                Query.Transaction.StartTransaction;

                Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_RKO(:DOCID,:CurrencyID,:FLG_ACNT,:Rate,:SUMA)';
      // set params
                Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
                Query.ParamByName('CurrencyID').AsInteger := dialog.CurrencyID;
                Query.ParamByName('FLG_ACNT').AsInteger := dialog.FLG_ACNT;
                Query.ParamByName('Rate').AsFloat := dialog.Rate;
                Query.ParamByName('SUMA').AsCurrency := dialog.SUMA;
                try
      // exec
                    Query.ExecSQL;
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
    finally
        dialog.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.bbAddFileClick(Sender: TObject);
var
    dialog: Tfrm53RPPFileEditorDlg;
begin
    dialog := Tfrm53RPPFileEditorDlg.Create(Self, IBCQueryFiles, IBCDataSourceFiles);
    try
        dialog.CreateNewRecord := True;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.bbDeleteFileClick(Sender: TObject);
begin
    if ShowAskDialog('Stergere fisier', Format('Doriti sa stergeti fisierul "%s"?', [IBCQueryFiles.FieldByName('FILENAME').AsString]))
        = mrYes then
    begin
        IBCQueryFiles.UpdateTransaction.StartTransaction;
        try
            IBCQueryFiles.Delete;
            IBCQueryFiles.UpdateTransaction.Commit;
        except
            on E: Exception do
            begin
                IBCQueryFiles.UpdateTransaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.bbEditProductDescriptionClick(Sender: TObject);
var
    dialog: TfrmServiceRequestWarrantyDescriptionDlg;
begin
    dialog := TfrmServiceRequestWarrantyDescriptionDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
    try
        if dialog.ShowModal = mrOk then
            IBCQueryINFO.Refresh;
    finally
        dialog.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.dxBarButton2Click(Sender: TObject);
var
    dialog: TfrmServiceRequestWarantySelectFoodsFromDocumentDlg;
begin
    dialog := TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.Create(Self, dmDB.IBCConnection);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;

end;

procedure Tframe32ServiceRequestsWarranty.dxBarButton3Click(Sender: TObject);
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(Self);
    try
        q.sql.Add('select J.PRICE * D.RATE PRICE');
        q.sql.Add('from VW_TDB_JURNAL J');
        q.sql.Add('inner join VW_TDB_DOCS D on D.DOCID = J.DOCID');
        q.sql.Add('where J.DOCID = :DOCID and');
        q.sql.Add('GOODSID = :GOODSID');
        q.Open;
        dmDB.IBCQueryJurnal.Edit;
        dmDB.IBCQueryJurnal.FieldByName('PRICE').AsFloat := q.FieldByName('PRICE').AsFloat;
        dmDB.IBCQueryJurnal.Post;
    finally
        q.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.FilesSelectionChanged;
var
    fNew, fDelete, fSaveAs, FLG_CLOSED: Boolean;
begin
    fNew := False;
    fDelete := False;
    fSaveAs := False;
    if (cxGridDocsTable.DataController.RecNo > 0) then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

        fNew := not FLG_CLOSED;
        fSaveAs := True;

        if (cxGridFilesTable.DataController.RecNo > 0) then
        begin
            fDelete := not FLG_CLOSED;
        end;
    end;
    bbAddFile.Enabled := fNew;
    bbDeleteFile.Enabled := fDelete;
    bbSaveFile.Enabled := fSaveAs;
end;

function Tframe32ServiceRequestsWarranty.GetCurrentSearchContext: TSearchContextValue;
begin
    Result := inherited;

    if cxGridGoodsTable.Site.Focused then
    begin
          // context from Jurnal: Cod + Denumire
        Result.Context := ffGoods;
        Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
        Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
    end
    else if cxGridDocsTable.Site.Focused then
    begin
              // context from Docs
        if cxGridNPNCol_CT_NAME.Focused then
        begin
                   // Contraagent
            Result.Context := ffCustomer;
            Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
            Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
        end
        else if cxGridDocsTableData.Focused then
        begin
                       // Data
            Result.Context := ffDate;
            Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
        end;
    end
end;

function Tframe32ServiceRequestsWarranty.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [fedsDocs, fedsJurnal];
end;

function Tframe32ServiceRequestsWarranty.GetFilterFields: TFrameFilterFields;
begin
    Result := [ffDate, ffCustomer, ffGoods];
end;

function Tframe32ServiceRequestsWarranty.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
    if fCanCreateDoc then
        Result := Result + [fbtADD];
    if fCanEditDoc then
        Result := Result + [fbtMODIFY];
    if fCanDeleteDoc then
        Result := Result + [fbtDELETE];
end;

procedure Tframe32ServiceRequestsWarranty.GoodsSelectionChanged;
var
    fNew, fEdit, fDelete, fSerials, FLG_CLOSED, fGoodsSelected: Boolean;
begin
    fNew := False;
    fEdit := False;
    fDelete := False;
    fSerials := False;
    fGoodsSelected := False;

    if (cxGridDocsTable.DataController.RecNo > 0) then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
        fNew := not FLG_CLOSED; // Produs nou + Security

        if (cxGridGoodsTable.DataController.RecNo > 0) then
        begin
            fEdit := not FLG_CLOSED; // Modifica + Security
            fDelete := not FLG_CLOSED; // Sterge + Security
               // Numere seriale, Partizi + Security
            fSerials := (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger =
                cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger
                = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);

            fGoodsSelected := True;
        end;
    end;
     // goods
    bbGoodsNew.Enabled := fNew;
    bbGoodsModify.Enabled := fEdit;
    bbGoodsDelete.Enabled := fDelete;
    bbGoodsSerials.Enabled := fSerials;
    bbGoodsInfoCard.Enabled := fGoodsSelected;
    bbGoodsPrice.Enabled := fGoodsSelected;
    bbGoodsForeignCode.Enabled := fGoodsSelected;
end;

function Tframe32ServiceRequestsWarranty.ImportGoodsFromSellDB(const GoodsList, SNList: string): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.AutoCommit := False;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_32_IMPORTGOODSFROMSELL(:DOCID,:LIST,:SNLIST)';
        Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        Query.ParamByName('LIST').AsString := GoodsList;
        Query.ParamByName('SNLIST').AsString := SNList;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.Execute;
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

function Tframe32ServiceRequestsWarranty.InitFrameID: Integer;
begin
    Result := 32; // SERVICE - Cereri de reparatie in garantie
    dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
end;

procedure Tframe32ServiceRequestsWarranty.ModifyRecord;
var
    dialog: TfrmServiceRequestWarrantyDocDlg;
begin
    if not fCanEditDoc or (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1) then
        Exit;

    dialog := TfrmServiceRequestWarrantyDocDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
    try
        dialog.CreateNewDocument := False;
        if dialog.ShowModal = mrOk then
        begin
            dmDB.IBCQueryDocs.Refresh;
            GoodsSelectionChanged;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.ReadFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
//        pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//        cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridDocsTable);
        ReadGridColumnsSettings(cxGridGoodsTable);
        ReadGridColumnsSettings(cxGridFilesTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.SaveFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridDocsTable);
        SaveGridColumnsSettings(cxGridGoodsTable);
        SaveGridColumnsSettings(cxGridFilesTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.RefreshData;
begin
    inherited;
    IBCQueryFiles.Refresh;
end;

procedure Tframe32ServiceRequestsWarranty.SaveFileAs;
begin
    with TSaveDialog.Create(Self) do
    try
        FileName := IBCQueryFiles.FieldByName('FILENAME').AsString;
        Filter := '*.*';
        if Execute then
            SaveFileAsDB(FileName, IBCQueryFiles.FieldByName('ATTID').AsInteger);
    finally
        Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.SaveFileAsDB(const FileName: string; const AttachmentID: Integer);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.SQL.Text := 'SELECT FILEDATA FROM TDB_DOCS_ATTACHMENTS WHERE ATTID=:ID';
        Query.ParamByName('ID').AsInteger := AttachmentID;
        Query.ExecSQL;
        if not Query.Eof then
            TBlobField(Query.Fields[0]).SaveToFile(FileName);
    finally
        Query.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.SetupDefaultFocus;
begin
     // focused grid
    cxGridDocs.SetFocus;
     // set focused column
    cxGridNPNCol_CT_NAME.Focused := True;
    cxGridDBCol_GOODS_NAME.Focused := True;
    cxGridFiles_FILENAME.Focused := True;
end;

procedure Tframe32ServiceRequestsWarranty.SetupSecurityItems;
begin
    fCanCreateDoc := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНГРN_Создать_документ);
    fCanEditDoc := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНГРN_Изменить);
    fCanDeleteDoc := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНГРN_Удалить_документ);

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНГРN_Закрыть_документ) then
        bbCloseDoc.Visible := ivNever;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНГРN_Открыть_документ) then
        bbOpenDoc.Visible := ivNever;

     // Fisa produsului
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Карточка_товара) or
        SWNSecurityManager.IsPartialAccessMode then
        bbGoodsInfoCard.Visible := ivNever;
     // Modifica preturile marfii
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара)
        or SWNSecurityManager.IsPartialAccessMode then
        bbGoodsPrice.Visible := ivNever;
     // Corespondenta produsului in alte firme
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
        bbGoodsForeignCode.Visible := ivNever;

    if (dxBarPopupMenuDoc.ItemLinks.VisibleItemCount = 0) then
        cxGridPopupMenuDocs.PopupMenus.Clear;
    if (dxBarPopupMenuGOODS.ItemLinks.VisibleItemCount = 0) then
        cxGridPopupMenuGOODS.PopupMenus.Clear;
end;

procedure Tframe32ServiceRequestsWarranty.ShowAddGoodsDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
    dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        dialog.AddNewGoods := True;
    // dialog.AllowedActions:=dialog.AllowedActions-[acChangeACNT,acChangePrice,acChangeActive,acChangeEU,acChangeEUK,acChangeWarranty];
        dialog.GoodsTypeFilter := [gtfNoService];

        if dialog.ShowModal = mrOk then
        begin
            dmDB.IBCQueryDocs.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.ShowDeleteGoodsDialog;
begin
    if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, 'Stergeti marfa pentru reparatie "' + dmDB.IBCQueryJurnal.FieldByName
        ('GOODS_NAME').AsString + '"?') = mrYes then
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

procedure Tframe32ServiceRequestsWarranty.ShowGoodsPartNumbersDialog(const ReadOnly: Boolean);
var
    dialog: TfrmPartNumbersDlg;
begin
    dialog := TfrmPartNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        dialog.ReadOnly := ReadOnly;
        dialog.NewPartNoTemplate := CreatePartNoTemplate(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryJurnal.FieldByName
            ('GOODSID').AsInteger);
        if dialog.ShowModal = mrOk then
        begin
            dmDB.FullRefresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.ShowGoodsSerialsDialog(const ReadOnly: Boolean = False);
var
    dialog: TfrmSerialNumbersDlg;
begin
    dialog := TfrmSerialNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        dialog.ReadOnly := ReadOnly;
        if dialog.ShowModal = mrOk then
        begin
            dmDB.IBCQueryJurnal.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.ShowModifyGoodsDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
    dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        dialog.AddNewGoods := False;
    // dialog.AllowedActions:=dialog.AllowedActions-[acChangeACNT,acChangePrice,acChangeActive,acChangeEU,acChangeEUK,acChangeWarranty];
        dialog.GoodsTypeFilter := [gtfNoService];

        if dialog.ShowModal = mrOk then
        begin
            dmDB.IBCQueryDocs.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.ShowSelectGoodsFromSellDialog;
var
    dialog: TfrmServiceRequestWarrantySelectGoodsFromSellDlg;
    goodsList, snList: string;
begin
//  if not ProductDescriptionExists then
//  begin
//    ShowErrorDialog(cMSG_GeneralError_Title,
//      'Nu este indicat tipul si numarul documentului in baza caruia are loc primirea marfii. Vedeti sectiunea "Descriere detaliata".');
//    Exit;
//  end;

    dialog := TfrmServiceRequestWarrantySelectGoodsFromSellDlg.Create(Self);
    try
        dialog.DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        dialog.CustomerID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
        dialog.FlgViewOnly := not (fCanEditDoc and not (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1));
        if dialog.ShowModal = mrOk then
        begin
            goodsList := dialog.GoodsIDList;
            snList := dialog.GoodsSNList;
            if (goodsList <> '') and (snList <> '') and ImportGoodsFromSellDB(goodsList, snList) then
                RefreshData;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe32ServiceRequestsWarranty.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    DocumentSelectionChanged;
end;

procedure Tframe32ServiceRequestsWarranty.WhenFilesGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    FilesSelectionChanged;
end;

procedure Tframe32ServiceRequestsWarranty.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    GoodsSelectionChanged;
end;

end.

