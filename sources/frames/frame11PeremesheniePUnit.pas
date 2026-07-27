unit frame11PeremesheniePUnit;

// ПЕРЕМЕЩЕНИЕ. Перемещение
// DocTypeID = 114
// Frame Index = 11

interface

uses
    Classes, Controls, DB, DBAccess, ExtCtrls, Forms, Graphics, IBC, MemDS, Messages,
    SWNBaseFrameUnit, SWNDataFiltering, Variants, Windows, cxCalc, cxCheckBox, cxClasses, cxControls,
    cxCurrencyEdit, cxCustomData, cxDBData, cxData, cxDataStorage, cxEdit, cxFilter, cxGraphics,
    cxGrid, cxGridCustomPopupMenu, cxGridCustomTableView, cxGridCustomView, cxGridDBTableView,
    cxGridLevel, cxGridPopupMenu, cxGridTableView, cxImageComboBox, cxLabel, cxLookAndFeelPainters,
    cxLookAndFeels, cxNavigator, cxPC, cxSplitter, cxStyles, dialogs, dxBar, dxBarBuiltInMenu,
    dxDateRanges, dxScrollbarAnnotations, System.SysUtils, System.UITypes, dxUIAClasses;

type
    Tframe11PeremeshenieP = class(TSWNBaseFrame)
        cxSplitter: TcxSplitter;
        cxGridPP: TcxGrid;
        cxGridPPTable: TcxGridDBTableView;
        cxGridPPTableDocID: TcxGridDBColumn;
        cxGridPPTableData: TcxGridDBColumn;
        cxGridPPTable_DTDEP_NAME: TcxGridDBColumn;
        cxGridPPTable_CT_NAME: TcxGridDBColumn;
        cxGridPPTableParentDocID: TcxGridDBColumn;
        cxGridPPTable_FLG_ACNT: TcxGridDBColumn;
        cxGridPPTableCreatedBy: TcxGridDBColumn;
        cxGridPPLevel: TcxGridLevel;
        cxGridPPTable_INCOMING_DOC: TcxGridDBColumn;
        cxGridPPTable_CTDEP_NAME: TcxGridDBColumn;
        cxGridPPTable_DT_NAME: TcxGridDBColumn;
        cxGridPPTable_FLG_SEND: TcxGridDBColumn;
        cxGridPPTable_FLG_RECEIVE: TcxGridDBColumn;
        pnBottom: TPanel;
        cxGridJurnal: TcxGrid;
        cxGridJurnalTable: TcxGridDBTableView;
        cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
        cxGridDBCol_CTDEP_NAME: TcxGridDBColumn;
        cxGridDBCol_GOODSID: TcxGridDBColumn;
        cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
        cxGridDBCol_QTY: TcxGridDBColumn;
        cxGridDBCol_UM_NAME: TcxGridDBColumn;
        cxGridDBCol_FLG_READY: TcxGridDBColumn;
        cxGridJurnalLevel: TcxGridLevel;
        dxBarManager: TdxBarManager;
        dxBarManagerBar1: TdxBar;
        bbNewItem: TdxBarButton;
        bbModifyItem: TdxBarButton;
        bbRemoveItem: TdxBarButton;
        dxBarDockControl1: TdxBarDockControl;
        bbSerials: TdxBarButton;
        pmPopupMenuDoc: TdxBarPopupMenu;
        cxGridPPTable_FLG_CLOSED: TcxGridDBColumn;
        bbDescribeSend: TdxBarButton;
        bbReceiveGoods: TdxBarButton;
        cxGridDBCol_IMG: TcxGridDBColumn;
        bbCreateScetFactura: TdxBarButton;
        cxGridPP_RATEUSD: TcxGridDBColumn;
        cxGridPopupMenuPP: TcxGridPopupMenu;
        cxGridJurnal_STOCK_QTY: TcxGridDBColumn;
        bbSendGoods: TdxBarButton;
        bbPrintShipmentPaper: TdxBarButton;
        cxGridPPTable_CREATED_DATE: TcxGridDBColumn;
        bbDocComments: TdxBarButton;
        cxGridPP_CT: TcxGridDBColumn;
        bbUpdateByPriceColumn: TdxBarButton;
        cxGridJurnal_PRICE_COLUMN: TcxGridDBColumn;
        cxGridJurna_PRICE: TcxGridDBColumn;
        cxGridJurnal_SUMA: TcxGridDBColumn;
        cxGridJurna_GOODS_ACNT_ID: TcxGridDBColumn;
        cxGridJurnal_GOODS_NAMEACNT: TcxGridDBColumn;
        pcPageControlBottom: TcxPageControl;
        tbsGoods: TcxTabSheet;
        tbsExpenses: TcxTabSheet;
        dxBarDockControl2: TdxBarDockControl;
        cxGridExpTable: TcxGridDBTableView;
        cxGridExpLevel: TcxGridLevel;
        cxGridExp: TcxGrid;
        dxBarManagerBar2: TdxBar;
        bbExpNew: TdxBarButton;
        bbExpEdit: TdxBarButton;
        bbExpDelete: TdxBarButton;
        IBCQueryExp: TIBCQuery;
        IBCDataSourceExp: TIBCDataSource;
        cxGridExp_ADDEXPENSEID: TcxGridDBColumn;
        cxGridExp_CREATED_DATE: TcxGridDBColumn;
        cxGridExp_DT_NAME: TcxGridDBColumn;
        cxGridExp_CT_NAME: TcxGridDBColumn;
        cxGridExp_DETAILS: TcxGridDBColumn;
        cxGridExp_SUMA: TcxGridDBColumn;
        cxGridExp_CREATED_BY_NAME: TcxGridDBColumn;
        cxGridExp_ANALITICAID: TcxGridDBColumn;
        cxGridJurnal_FLG_ACTIVE: TcxGridDBColumn;
        cxGridJurnal_CREATED_BY_NAME: TcxGridDBColumn;
        bbCancelSendGoods: TdxBarButton;
        bbEnterSerial: TdxBarButton;
        bbObnovitiOstatki: TdxBarButton;
        dxBarLargeButton1: TdxBarLargeButton;
        dxBarButton2: TdxBarButton;
        dxBarSubItem1: TdxBarSubItem;
        bbCompositeScetFactura: TdxBarButton;
        cxGridJurnal_UMID: TcxGridDBColumn;
        cxGridPopupMenuJURNAL: TcxGridPopupMenu;
        dxBarPopupMenuJURNAL: TdxBarPopupMenu;
        bbGoodsInfoCard: TdxBarButton;
        bbGoodsPrice: TdxBarLargeButton;
        bbGoodsForeignCode: TdxBarButton;
        cxGridPPTable_SUMA: TcxGridDBColumn;
        Valuta: TcxGridDBColumn;
        btnImportPN: TdxBarButton;
        bbImportSN: TdxBarButton;
        bbImportFromDocument: TdxBarButton;
        procedure cxGridPPTable_INCOMING_DOCGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure bbNewItemClick(Sender: TObject);
        procedure bbModifyItemClick(Sender: TObject);
        procedure bbRemoveItemClick(Sender: TObject);
        procedure bbSerialsClick(Sender: TObject);
        procedure cxGridPPTable_FLG_RECEIVEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure bbDescribeSendClick(Sender: TObject);
        procedure bbReceiveGoodsClick(Sender: TObject);
        procedure cxGridJurnalTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
            TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure bbCreateScetFacturaClick(Sender: TObject);
        procedure pmPopupMenuDocPopup(Sender: TObject);
        procedure cxGridPPTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure cxGridJurnalTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure bbSendGoodsClick(Sender: TObject);
        procedure bbPrintShipmentPaperClick(Sender: TObject);
        procedure cxGridPPTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
            TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure cxGridPPTable_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure cxGridPPTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure bbDocCommentsClick(Sender: TObject);
        procedure cxGridPPTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
            AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure cxGridJurnalTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
            AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure bbUpdateByPriceColumnClick(Sender: TObject);
        procedure bbExpNewClick(Sender: TObject);
        procedure cxGridExp_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure cxGridExpTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
            AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure bbExpEditClick(Sender: TObject);
        procedure bbExpDeleteClick(Sender: TObject);
        procedure bbCancelSendGoodsClick(Sender: TObject);
        procedure bbEnterSerialClick(Sender: TObject);
        procedure bbObnovitiOstatkiClick(Sender: TObject);
        procedure bbCompositeScetFacturaClick(Sender: TObject);
        procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure bbGoodsInfoCardClick(Sender: TObject);
        procedure bbGoodsPriceClick(Sender: TObject);
        procedure bbGoodsForeignCodeClick(Sender: TObject);
        procedure cxGridPPTableStylesGetGroupStyle(Sender: TcxGridTableView; ARecord:
            TcxCustomGridRecord; ALevel: Integer; var AStyle: TcxStyle);
        procedure cxGridPPTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
            TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure btnImportPNClick(Sender: TObject);
        procedure bbImportSNClick(Sender: TObject);
        procedure bbImportFromDocumentClick(Sender: TObject);
    private    { Private declarations }
        fSYS_CanView, fSYS_CanNew, fSYS_CanEditDoc, fSYS_CanEditGoods, fSYS_CanEditAfter30min,
            fSYS_CanDelete: Boolean;
        fSYS_ExpNew, fSYS_ExpEdit, fSYS_ExpDelete: Boolean;
        procedure WhenDocumentFocusedRecordChanged(Sender: TcxCustomGridTableView;
            APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure DocumentSelectionChanged;
        procedure WhenGoodsFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
            AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure GoodsSelectionChanged;
        procedure WhenExpensesFocusedRecordChanged(Sender: TcxCustomGridTableView;
            APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure ExpensesSelectionChanged;
        procedure WhenDocumentPopupMenuOpen;
        procedure ShowAddNewGoodsDialog;
        procedure ShowModifySelectedGoodsDialog;
        procedure RemoveSelectedGoods;
        function WhenVerifyGoodsExists(const GoodsID: Integer): Boolean;
        procedure ShowSerialPartNumbersDialogs;
        procedure ShowEditSerialsDialog(const ViewOnly: Boolean);
        procedure ShowEditPartNumbersDialog(const ViewOnly: Boolean);
        procedure ShowPeredatiTovarDialog;
        function DoSendGoodsDB(const DocID: Integer): Boolean;
        function DoReceiveGoodsDB(const DocID: Integer): Boolean;
        procedure DoPrintShipmentReport;
        function GetPeremesheniePriceColumn(const DocID: Integer): Integer;
        function UpdatePricesByColumn(const ColumnID: Integer): Boolean;
        procedure ShowCreateNewExpenseDialog;
        procedure ShowModifyExpenseDialog;
        procedure DeleteExpense;
        function CheckIfDocumentisLocked: Boolean;
        procedure ShowCompositeScetFacturaDialog;
        procedure CreateCompositeScetFacturaDB(const docList: string);
        procedure ShowCreateTTN;
//    function DoCreateTTN(const DocID:integer):Boolean;
        procedure SetupQtyFields;
        procedure WhenCustomDataFilterGetSQL(var FilterSQL: string);
        function DoImportDocFromPrihod(const DocID: integer): Integer;
        procedure DoImportSNFromDoc(const DOCID: integer);
    protected    { Protected declarations }
        function InitFrameID: Integer; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        procedure WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure CreateNewRecord; override;
        procedure ModifyRecord; override;
        procedure DeleteRecord; override;
        procedure RefreshData; override;
        procedure CloneRecord; override;
        procedure ReadFrameStates; override;
        procedure SaveFrameStates; override;
        procedure SetupSecurityItems; override;
    public    { Public declarations }
        procedure SetupDefaultFocus; override;
        function GetCurrentSearchContext: TSearchContextValue; override;
    end;

implementation

uses
    DataModuleAdditions, DataModuleDB, DateUtils, SWNCommonDialogs, SWNConst, SWNDBErrors,
    SWNSecurity, SWNSecurityFlags, SWNTypes, SWNUtils, SWNValueStorageUnit,
    frmCompositeScetFacturaDialog, frmDocumentBrowserDialog, frmExpenseEditorDialog, frmPasswordDlg,
    frmPeremesheniePDocDialog, frmPeremesheniePeredatiTovarDialog,
    frmPeremesheniePrineatiTovarDialog, frmPrintEngineWindow, frmSelectGoodsToAddDialog,
    frmSelectPartNumbersDialog, frmSelectSNDialog;

{$R *.dfm}
{ Tframe11PeremeshenieP }

procedure Tframe11PeremeshenieP.bbCancelSendGoodsClick(Sender: TObject);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCQueryDocs.UpdateTransaction;

        try
            Query.Transaction.StartTransaction;

            Query.SQL.Text := 'EXECUTE PROCEDURE SP_CANCEL_SEND_TRANSFER_11(:DOCID)';
            Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
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

procedure Tframe11PeremeshenieP.bbCompositeScetFacturaClick(Sender: TObject);
begin
    ShowCompositeScetFacturaDialog;
end;

procedure Tframe11PeremeshenieP.bbCreateScetFacturaClick(Sender: TObject);
var
    S: string;
begin
  // Выдать счет фактуры
    S := #13#10 + dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString + '?';
    if ShowAskDialog('Factura fiscala', 'Doriti sa creati o factura fiscala pentru ' + S, Format('Factura va fi creata in "%s".',
        [dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString])) = mrYes then
    begin
        if dmDB.DoCreateFactura(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
        begin
            bbEnterSerialClick(Sender);
            ShowInfoDialog('Factura fiscala', 'Facut!');
        end;
    end;
end;

procedure Tframe11PeremeshenieP.bbModifyItemClick(Sender: TObject);
begin
    ShowModifySelectedGoodsDialog;
end;

procedure Tframe11PeremeshenieP.bbNewItemClick(Sender: TObject);
begin
    ShowAddNewGoodsDialog;
end;

procedure Tframe11PeremeshenieP.bbRemoveItemClick(Sender: TObject);
begin
//  dmDB.IBCQueryDocs.RefreshRecord;
//
//  if CheckIfDocumentisLocked then
//    Exit;
    RemoveSelectedGoods;
end;

procedure Tframe11PeremeshenieP.bbDescribeSendClick(Sender: TObject);
begin
    UpdatePricesByColumn(GetPeremesheniePriceColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger));
    ShowPeredatiTovarDialog;
end;

procedure Tframe11PeremeshenieP.bbDocCommentsClick(Sender: TObject);
begin
    ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe11PeremeshenieP.bbEnterSerialClick(Sender: TObject);
var
    Query: TIBCQuery;
begin
  // nu este nevoie de acest cod. 18.06.2016 Sergiu!


  // Начать вводить серийники
  //  if ShowAskDialog('Начать вводить серийники', 'Вы хотите заблокировать документ для ввода серийных номеров?', 'Только Вы сможеты изменить документ и его состав!') = mrYes then
//  begin
//    Query := TIBCQuery.Create(self);
//    try
//      Query.AutoCommit := False;
//      Query.Connection := dmDB.IBCConnection;
//      Query.Transaction := dmDB.IBCTrDefaultUpdate;
//      Query.Transaction.StartTransaction;
//      Query.SQL.Text := 'EXECUTE PROCEDURE SP_BEGIN_SN_ENTER(:DOCID)';
//      try
//        Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
//        // exec
//        Query.ExecSQL;
//        Query.Transaction.Commit;
//
//      except
//        on E: Exception do
//        begin
//          Query.Transaction.Rollback;
//          if not ProcessSWNError(E) then
//            raise;
//        end;
//      end;
//    finally
//      Query.Free;
//    end;
//    dmDB.IBCQueryDocs.RefreshRecord;
//  end;
end;

procedure Tframe11PeremeshenieP.bbExpDeleteClick(Sender: TObject);
begin
    DeleteExpense;
end;

procedure Tframe11PeremeshenieP.bbExpEditClick(Sender: TObject);
begin
    ShowModifyExpenseDialog;
end;

procedure Tframe11PeremeshenieP.bbExpNewClick(Sender: TObject);
begin
    ShowCreateNewExpenseDialog;
end;

procedure Tframe11PeremeshenieP.bbGoodsForeignCodeClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe11PeremeshenieP.bbGoodsInfoCardClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
        ('GOODS_NAME').AsString);
end;

procedure Tframe11PeremeshenieP.bbGoodsPriceClick(Sender: TObject);
begin
    TSWNCommonDialogs.ModifyGoodsPriceDlg(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
        ('GOODS_NAME').AsString);
end;

procedure Tframe11PeremeshenieP.bbReceiveGoodsClick(Sender: TObject);
var
    dialog: TfrmPeremesheniePrineatiTovarDlg;
    dialog2: TfrmPasswordDialog;
begin
    dialog := TfrmPeremesheniePrineatiTovarDlg.Create(self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
    try
        if dialog.ShowModal = mrOk then
        begin
      // verify user password
            dialog2 := TfrmPasswordDialog.Create(self, pdmAskPassword);
            try
                if dialog2.ShowModal = mrOk then
                begin
                    if SWNSecurityManager.TestUserPassword(dmDB.CurrentUserID, dialog2.Password) then
                    begin
                        if DoReceiveGoodsDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
                        begin
                            dmDB.IBCQueryDocs.Refresh;
                            ShowInfoDialog('Transfer marfa', 'Marfa a fost primita cu succes.');
                        end;
                    end
                    else
                        ShowErrorDialog('Parola gresita!', 'Transferul este anulat!');
                end;
            finally
                dialog2.Free;
            end;
        end;
    finally
        dialog.Free;
    end;

  {
    S:=Format('Отправитель: %s'+#13#10+'Получатель: %s',[dmDB.IBCQueryDocs.FieldByName('DT_NAME').asString,dmDB.IBCQueryDocs.FieldByName('CT_NAME').asString])+#13#10+#13#10;
    if ShowAskDialog('Принять товар',S+'Вы хотите принять товар?')=mrYes then
    begin
    S:=Format('%s(%s)',[dmDB.IBCQueryDocs.FieldByName('CTDEP_NAME').asString,dmDB.IBCQueryDocs.FieldByName('CT_NAME').asString]);
    if DoReceiveGoodsDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger) then
    begin
    dmDB.IBCQueryDocs.Refresh;
    ShowInfoDialog('Товар принят','Товар был успешно принят на '+S);
    end
    else ShowErrorDialog('Ошибка','Невозможно принять товар на '+S);
    end;
  }
end;

procedure Tframe11PeremeshenieP.bbSendGoodsClick(Sender: TObject);
var
    S: string;
begin
    S := #13#10 + dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString + '?';
    if ShowAskDialog('Transfer de marfa', 'Doriti sa transmiteti marfa aleasa la' + S) = mrYes then
    begin
        DoSendGoodsDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
        dmDB.RefreshDocs;
    end;
end;

procedure Tframe11PeremeshenieP.bbSerialsClick(Sender: TObject);
begin
//  dmDB.IBCQueryDocs.RefreshRecord;
    ShowSerialPartNumbersDialogs;
end;

procedure Tframe11PeremeshenieP.bbUpdateByPriceColumnClick(Sender: TObject);
begin
    if ShowAskDialog('Modificarea preturilor', Format('Modificarea preturilor in conformitate cu intreprinderea "%s"?',
        [dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString])) = mrYes then
    begin
        if UpdatePricesByColumn(GetPeremesheniePriceColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger))
            then
            dmDB.IBCQueryDocs.Refresh;
    end;
end;

function Tframe11PeremeshenieP.DoImportDocFromPrihod(const DocID: integer): Integer;
var
    Query: TIBCQuery;
begin
    Result := 0;
    Query := TIBCQuery.Create(Self);
    try
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_IMPORT114 (:DOCID, :current_docid)';
            Query.Params.ParamByName('DOCID').AsInteger := DocID;
            Query.Params.ParamByName('CURRENT_DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
            Query.ExecSQL;
//           if Not Query.Eof then Result:=Query.Fields[0].AsInteger;
            Query.Transaction.Commit;
            dmdb.IBCQueryJurnal.Refresh;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(e) then
                    raise;
            end;
        end;
    finally

        Query.Free;
    end;
end;

procedure Tframe11PeremeshenieP.DoImportSNFromDoc(const DOCID: integer);
var
    Query: TIBCQuery;
begin
    if (ShowAskDialog('Transfer marfa/servicii', 'Toate seriile vor fi sterse! Continuam? ') = mrYes) then
        Query := TIBCQuery.Create(Self);
    try
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_IMPORTSN (:FROM_DOCID, :current_docid)';
            Query.Params.ParamByName('FROM_DOCID').AsInteger := DOCID;
            Query.Params.ParamByName('CURRENT_DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
            Query.ExecSQL;
//           if Not Query.Eof then Result:=Query.Fields[0].AsInteger;
            Query.Transaction.Commit;
            dmdb.IBCQueryJurnal.Refresh;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(e) then
                    raise;
            end;
        end;
    finally

        Query.Free;
    end;
end;

procedure Tframe11PeremeshenieP.btnImportPNClick(Sender: TObject);
var
    dialog: TfrmDocumentBrowserDlg;
    docid: integer;
begin
    dialog := TfrmDocumentBrowserDlg.Create(Self, dmDB.IBCConnection);
    try
        dialog.FixedDocTypeID := False;
        dialog.DefaultDocTypeID := 109;
//        dialog.DefaultUserID:=dmDB.CurrentUserID;
        if dialog.ShowModal = mrOk then
        begin
            if ShowAskDialog('Import', Format('Doriti sa importati din documentul Nr.%d?', [dialog.DocID]))
                = mrYes then
            begin
                docid := DoImportDocFromPrihod(dialog.DocID);
                dmDb.IBCQueryDocs.Refresh;
                dmDb.IBCQueryDocs.Locate('DOCID', docid, []);
                ShowInfoDialog('Import', 'Documentul a fost important!');
            end;
        end;
    finally
        dialog.Free;
    end;
end;

function Tframe11PeremeshenieP.CheckIfDocumentisLocked: Boolean;
var
    UserName: string;
begin
    Result := False;
    if (dmDB.IBCQueryDocs.FieldByName('FLG_PROTECTED').AsInteger = 1) and (dmDB.GetDocumentProtectedUser
        (dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, UserName) <> dmDB.CurrentUserID) then
    begin
        Result := True;
        ShowErrorDialog('Document blocat',
            'Documentul dat este blocat pentru introducerea numerilor de serie.', '', Format('Utilizator: %s',
            [UserName]));
    end;
    if dmDB.IBCQueryDocs.UpdateTransaction.Active then
    begin
        try
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

procedure Tframe11PeremeshenieP.CloneRecord;
var
    S: string;
    newDocID: Integer;
begin
    S := Format('Clonare document transfer №%s ?', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsString]);
    if ShowAskDialog('Clonare document', S) <> mrYes then
        Exit;

    if dmDB.CloneDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, newDocID) then
    begin
        dmDB.RefreshDocs;
        dmDB.IBCQueryDocs.Locate('DOCID', newDocID, []);
        ShowInfoDialog('Clonare document', 'Copia este creata'#13#10'Transfer de marfa №' + dmDB.IBCQueryDocs.FieldByName
            ('DOCID').AsString);
    end;
end;

procedure Tframe11PeremeshenieP.CreateCompositeScetFacturaDB(const docList: string);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.AutoCommit := False;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_DO_COMPOSITE_FISCAL_INVOICE(:docs)';
        Query.ParamByName('docs').AsString := docList;
        Query.Transaction.StartTransaction;
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
end;

procedure Tframe11PeremeshenieP.CreateNewRecord;
var
    dialog: TfrmPeremesheniePDocDlg;
begin
    dialog := TfrmPeremesheniePDocDlg.Create(self);
    try
        dialog.CreateNewDocument := True;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe11PeremeshenieP.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[Sender.Index]) then
    begin
        if (ARecord.Values[cxGridJurnal_UMID.Index] = 1) then
            AText := StringReplace(AText, QtyReplaceMask, '', []);
    end;
end;

procedure Tframe11PeremeshenieP.cxGridExpTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
    TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    begin
        ACanvas.Brush.Color := $E8E8E8;
    end;
end;

procedure Tframe11PeremeshenieP.cxGridExp_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridExp_CREATED_DATE.Index]) then
    begin
        AText := FormatDateTime('dd.mm.yyyy HH:NN', TDateTime(ARecord.Values[cxGridExp_CREATED_DATE.Index]));
    end;
end;

procedure Tframe11PeremeshenieP.cxGridJurnalTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var
    AHandled: Boolean);
begin
    if bbModifyItem.Enabled then
    begin
        ShowModifySelectedGoodsDialog;
        AHandled := True;
    end;
end;

procedure Tframe11PeremeshenieP.cxGridJurnalTableCustomDrawCell(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    begin
        ACanvas.Brush.Color := $E8E8E8;
    end;
end;

procedure Tframe11PeremeshenieP.cxGridJurnalTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    swnutils.ProcessCommonKeys(self, cxGridJurnalTable, Key, Shift);
end;

procedure Tframe11PeremeshenieP.cxGridPPTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var
    AHandled: Boolean);
begin
    if (AButton = mbLeft) then
    begin
        DoDocumentDoubleClick;
        AHandled := True;
    end;
end;

procedure Tframe11PeremeshenieP.cxGridPPTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
    TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    if not VarIsNull(AViewInfo.GridRecord.Values[cxGridPPTable_FLG_CLOSED.Index]) then
    begin
        if AViewInfo.GridRecord.Values[cxGridPPTable_FLG_CLOSED.Index] = 0 then
        begin
      // Open
            if not AViewInfo.Selected then
            begin
        // Document prin contabilitate
                if AViewInfo.GridRecord.Values[cxGridPPTable_FLG_ACNT.Index] = 1 then
                    ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
            end;
        end
        else
        begin
      // Closed
            ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
            if not AViewInfo.Selected then
            begin
                if AViewInfo.GridRecord.Values[cxGridPPTable_FLG_ACNT.Index] = 1 then
                    ACanvas.Font.Color := $008B8BC5
                else
                    ACanvas.Font.Color := clGrayText;
            end;
        end;
    end;

  // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    begin
        ACanvas.Brush.Color := $E8E8E8;
    end;
end;

procedure Tframe11PeremeshenieP.cxGridPPTableDataGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridPPTableData.Index]) then
    begin
        if DateOf(Now) = DateOf(ARecord.Values[cxGridPPTableData.Index]) then
            AText := FormatDateTime('HH:NN', ARecord.Values[cxGridPPTableData.Index])
        else
            AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridPPTableData.Index]);
    end;
end;

procedure Tframe11PeremeshenieP.cxGridPPTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    swnutils.ProcessCommonKeys(self, cxGridPPTable, Key, Shift);
end;

procedure Tframe11PeremeshenieP.cxGridPPTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
    ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    if Assigned(ARecord) and (cxGridPPTable.DataController.RecNo > 0) and (not VarIsNull(ARecord.Values
        [cxGridPPTable_FLG_RECEIVE.Index]) and (not VarIsNull(ARecord.Values[cxGridPPTable_FLG_CLOSED.Index])))
        then
    begin
        if ARecord.Values[cxGridPPTable_FLG_RECEIVE.Index] = 1 // Перемещение документа
            then
            AStyle := dmAdditions.cxStyle_ПеремешениеДокПринят
        else if ARecord.Values[cxGridPPTable_FLG_CLOSED.Index] = 1 then
            AStyle := dmAdditions.cxStyle_ПеремешениеДокЗакрыт;
    end;
end;

procedure Tframe11PeremeshenieP.cxGridPPTableStylesGetGroupStyle(Sender: TcxGridTableView; ARecord:
    TcxCustomGridRecord; ALevel: Integer; var AStyle: TcxStyle);
begin
    inherited;
    if Assigned(ARecord) and (cxGridPPTable.DataController.RecNo > 0) and (not VarIsNull(ARecord.Values
        [cxGridPPTable_INCOMING_DOC.Index])) and (not VarIsNull(ARecord.Values[cxGridPPTable_FLG_RECEIVE.Index]))
        then
        case ALevel of
            0:
                begin
          // Перемещение документа
                    if ARecord.Values[cxGridPPTable_INCOMING_DOC.Index] = 1 then
                        AStyle := dmAdditions.cxStyle_ПеремешениеДокДА // документ перемещен
                    else
                        AStyle := dmAdditions.cxStyle_ПеремешениеДокНЕТ // документ НЕ перемещен
                end;
            1:
                begin
          // Перемешение принято
                    if ARecord.Values[cxGridPPTable_FLG_RECEIVE.Index] = 1 then
                        AStyle := dmAdditions.cxStyle_ПеремешениеПринято // Перемешение принято
                    else
                        AStyle := dmAdditions.cxStyle_ПеремешениеНЕпринято // Перемешение НЕ принято
                end;
        end;
end;

procedure Tframe11PeremeshenieP.cxGridPPTable_CREATED_DATEGetDisplayText(Sender:
    TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridPPTable_CREATED_DATE.Index]) then
    begin
        if DateOf(Now) = DateOf(ARecord.Values[cxGridPPTable_CREATED_DATE.Index]) then
            AText := FormatDateTime('HH:NN', ARecord.Values[cxGridPPTable_CREATED_DATE.Index])
        else
            AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridPPTable_CREATED_DATE.Index]);
    end;
end;

procedure Tframe11PeremeshenieP.cxGridPPTable_FLG_RECEIVEGetDisplayText(Sender:
    TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridPPTable_FLG_RECEIVE.Index]) then
    begin
        if ARecord.Values[cxGridPPTable_FLG_RECEIVE.Index] = 1 then
            AText := 'Tranfer primit'
        else
            AText := 'Transfer in asteptare';
    end;
end;

procedure Tframe11PeremeshenieP.cxGridPPTable_INCOMING_DOCGetDisplayText(Sender:
    TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridPPTable_INCOMING_DOC.Index]) then
    begin
        if ARecord.Values[cxGridPPTable_INCOMING_DOC.Index] = 0 then
            AText := 'Document pentru trimitere'
        else
            AText := 'Document pentru primire';
    end;
end;

procedure Tframe11PeremeshenieP.DeleteExpense;
begin
    if ShowAskDialog('Transfer marfa', Format('Doriti sa stergeti inregistrarea "%s"?', [IBCQueryExp.FieldByName
        ('DETAILS').AsString])) <> mrYes then
        Exit;

    IBCQueryExp.UpdateTransaction.StartTransaction;
    try
        IBCQueryExp.Delete;
        IBCQueryExp.UpdateTransaction.Commit;
    except
        on E: Exception do
        begin
            IBCQueryExp.UpdateTransaction.Rollback;
            if not ProcessSWNError(E) then
                raise;
        end;
    end;
end;

procedure Tframe11PeremeshenieP.DeleteRecord;
begin
    if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Stergeti inregistrarea numarul %d?',
        [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger])) = mrYes then
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

procedure Tframe11PeremeshenieP.DoFrameHide;
begin
     // inchidem datele interne
    IBCQueryExp.Active := False;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
    CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
    cxGridExpTable.OnFocusedRecordChanged := nil;
    cxGridPPTable.OnFocusedRecordChanged := nil;
    cxGridJurnalTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
    cxGridJurnalTable.DataController.DataSource := nil;
    cxGridPPTable.DataController.DataSource := nil;

    inherited;
end;

procedure Tframe11PeremeshenieP.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
    customizedFilterData: TFrameDataFilteringInfo;
begin
    inherited;

     // 1. Legam grid-urile de datasource-sele
    cxGridPPTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
    cxGridJurnalTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
    cxGridPPTable.OnFocusedRecordChanged := WhenDocumentFocusedRecordChanged;
    cxGridJurnalTable.OnFocusedRecordChanged := WhenGoodsFocusedRecordChanged;
    cxGridExpTable.OnFocusedRecordChanged := WhenExpensesFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
    customizedFilterData := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
    try
        customizedFilterData.OnCustomDataFilterGetSQL := WhenCustomDataFilterGetSQL;
        OpenExternalData(customizedFilterData);
    finally
        customizedFilterData.Free;
    end;
     // deschidem datele interne
    IBCQueryExp.Active := True;

     // 4. Selection update
    pcPageControlBottom.ActivePage := tbsGoods;
    DocumentSelectionChanged;
end;

procedure Tframe11PeremeshenieP.DoPrintShipmentReport;
var
    PrintEngine: TfrmPrintEngine;
    ReportParams: TReportParamsList;
begin
    ReportParams := TReportParamsList.Create;
    PrintEngine := TfrmPrintEngine.Create(self);
    try
    // get system params
        if Assigned(OnCustomPrintSetupReportParams) then
            OnCustomPrintSetupReportParams(ReportParams);

        ReportParams.SetParamValue('DOCID', dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);

    // give param to printer
        PrintEngine.ReportParams := ReportParams;

        PrintEngine.AddReport(0); // Счет фактура
        PrintEngine.ShowModal;

    finally
        PrintEngine.Free;
        ReportParams.Free;
    end;
end;

function Tframe11PeremeshenieP.GetCurrentSearchContext: TSearchContextValue;
begin
    Result := inherited;

    if cxGridJurnalTable.Site.Focused then
    begin
          // context from Jurnal
          // Код + Наименование
        Result.Context := ffGoods;
        Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
        Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
    end
    else if cxGridPPTable.Site.Focused then
    begin
              // context from Docs
        if cxGridPPTable_CT_NAME.Focused then
        begin
                   // Получатель
            Result.Context := ffCustomer;
            Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
            Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
        end
        else if cxGridPPTableData.Focused then
        begin
                       // Дата
            Result.Context := ffDate;
            Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
        end
        else if cxGridPPTable_DTDEP_NAME.Focused then
        begin
                           // Склад отправитель
            Result.Context := ffStock;
            Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
            Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
        end;
    end
end;

function Tframe11PeremeshenieP.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [fedsDocs, fedsJurnal];
end;

function Tframe11PeremeshenieP.GetFilterFields: TFrameFilterFields;
begin
    Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods];
end;

function Tframe11PeremeshenieP.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH, fbtCLONE];
    if fSYS_CanNew then
        Result := Result + [fbtADD];
    if fSYS_CanEditDoc or fSYS_CanView then
        Result := Result + [fbtMODIFY];
    if fSYS_CanDelete then
        Result := Result + [fbtDELETE];
end;

function Tframe11PeremeshenieP.GetPeremesheniePriceColumn(const DocID: Integer): Integer;
//var
//  Query: TIBCQuery;
begin
    Result := 1;
//  Query := TIBCQuery.Create(self);
//  try
//    Query.Connection := dmDB.IBCConnection;
//    Query.SQL.Text := 'SELECT PRICE_COLUMN FROM SP_GET_PRICE_COLUMN_PEREMESH(:DOCID)';
//    Query.ParamByName('DOCID').AsInteger := DocID;
//    Query.ExecSQL;
//    if not Query.Eof then
//      Result := Query.Fields[0].AsInteger;
//  finally
//    Query.Free;
//  end;
end;

procedure Tframe11PeremeshenieP.GoodsSelectionChanged;
var
    f1, f2, f3, f4: Boolean;
    FLG_CLOSED, FLG_SEND, FLG_RECEIVE: Boolean;
    fCanChangeContent: Boolean;
    fNotLocked, fChangeCost, fGoodsSelected: Boolean;
begin
    f1 := False;
    f2 := False;
    f3 := False;
    f4 := False;
    fChangeCost := False;
    fGoodsSelected := False;

    if (cxGridPPTable.DataController.RecNo > 0) then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
        FLG_SEND := dmDB.IBCQueryDocs.FieldByName('FLG_SEND').AsInteger = 1;
        FLG_RECEIVE := dmDB.IBCQueryDocs.FieldByName('FLG_RECEIVE').AsInteger = 1;

          // expired30min:=Not WithinPastMinutes(NOW,dmDB.IBCQueryDocs.FieldByName('CREATED_DATE').AsDateTime,30);
        fNotLocked := (not FLG_CLOSED) and (not FLG_SEND) and (not FLG_RECEIVE);
        fCanChangeContent := fNotLocked and fSYS_CanEditGoods;
        fChangeCost := fCanChangeContent and (cxGridJurnalTable.DataController.RecordCount > 0);

        f1 := fCanChangeContent; // New
        if (cxGridJurnalTable.DataController.RecNo > 0) then
        begin
            f2 := fCanChangeContent; // Modify
            f3 := fCanChangeContent; // Delete
            f4 := (fNotLocked or fSYS_CanView) and ((dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger
                = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger
                = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет));
            fGoodsSelected := True;
        end;
    end;

    bbNewItem.Enabled := f1;
    bbModifyItem.Enabled := f2;
    bbRemoveItem.Enabled := f3;
    bbSerials.Enabled := f4;
    bbUpdateByPriceColumn.Enabled := fChangeCost;
    bbObnovitiOstatki.Enabled := f2;
    bbGoodsInfoCard.Enabled := fGoodsSelected;
    bbGoodsPrice.Enabled := fGoodsSelected;
    bbGoodsForeignCode.Enabled := fGoodsSelected;
end;

function Tframe11PeremeshenieP.InitFrameID: Integer;
begin
    Result := 11; // ПЕРЕМЕЩЕНИЕ. Перемещение
    SetupQtyFields;
end;

procedure Tframe11PeremeshenieP.ModifyRecord;
var
    dialog: TfrmPeremesheniePDocDlg;
    readonly, expired30min: Boolean;
    FLG_SEND, FLG_RECEIVE, FLG_CLOSED: Boolean;
begin
    if not (fSYS_CanEditDoc or fSYS_CanView) then
        Exit;

    FLG_SEND := dmDB.IBCQueryDocs.FieldByName('FLG_SEND').AsInteger = 1;
    FLG_RECEIVE := dmDB.IBCQueryDocs.FieldByName('FLG_RECEIVE').AsInteger = 1;
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    expired30min := not WithinPastMinutes(Now, dmDB.IBCQueryDocs.FieldByName('CREATED_DATE').AsDateTime, 30);

    if fSYS_CanEditDoc then
        readonly := FLG_CLOSED or FLG_SEND or FLG_RECEIVE or expired30min and not fSYS_CanEditAfter30min
    else
        readonly := fSYS_CanView;

    dialog := TfrmPeremesheniePDocDlg.Create(self);
    try
        dialog.CreateNewDocument := False;
        dialog.readonly := readonly;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe11PeremeshenieP.pmPopupMenuDocPopup(Sender: TObject);
begin
    WhenDocumentPopupMenuOpen;
end;

procedure Tframe11PeremeshenieP.ReadFrameStates;
begin
    AppUserConfigStorage.OpenSection(self.Name);
    try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridPPTable);
        ReadGridColumnsSettings(cxGridJurnalTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe11PeremeshenieP.RefreshData;
begin
    inherited;
    IBCQueryExp.Refresh;
    cxGridPPTable.DataController.Groups.FullExpand;
end;

procedure Tframe11PeremeshenieP.RemoveSelectedGoods;
begin
    if ShowAskDialog('Transfer marfa', 'Sterge marfa selectata' + #13#10 + dmDB.IBCQueryJurnal.FieldByName
        ('GOODS_NAME').asWideString + '?') = mrYes then
    begin
        try
            dmDB.IBCQueryJurnal.UpdateTransaction.StartTransaction;

            dmDB.IBCQueryJurnal.Delete;
            dmDB.IBCQueryJurnal.UpdateTransaction.Commit;
            dmDB.IBCQueryDocs.Refresh;
        except
            on E: Exception do
            begin
                if dmDB.IBCQueryJurnal.UpdateTransaction.Active then
                    dmDB.IBCQueryJurnal.UpdateTransaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    end;
end;

procedure Tframe11PeremeshenieP.DocumentSelectionChanged;
var
    FLG_CLOSED, FLG_SEND, FLG_RECEIVE: Boolean;
    fDocNew, fDocEdit, fDocDelete: Boolean;
    fCanChangeContent: Boolean;
    expired30min: Boolean;
    fClone: Boolean;
begin
    fDocNew := fSYS_CanNew;
    fDocEdit := False;
    fDocDelete := False;
    fClone := False;

    if cxGridPPTable.DataController.RecNo > 0 then
    begin
        FLG_SEND := dmDB.IBCQueryDocs.FieldByName('FLG_SEND').AsInteger = 1;
        FLG_RECEIVE := dmDB.IBCQueryDocs.FieldByName('FLG_RECEIVE').AsInteger = 1;
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

        fCanChangeContent := (not FLG_CLOSED) and (not FLG_SEND) and (not FLG_RECEIVE);
        expired30min := not WithinPastMinutes(Now, dmDB.IBCQueryDocs.FieldByName('CREATED_DATE').AsDateTime,
            30);

    // Edit Doc
        fDocEdit := fSYS_CanView or (fSYS_CanEditDoc and fCanChangeContent and (not expired30min or
            (expired30min and fSYS_CanEditAfter30min)));
        fDocDelete := fCanChangeContent; // Delete Doc
        fClone := not FLG_SEND and not FLG_RECEIVE and not FLG_CLOSED;
    end;
  // doc
    ButtonStateChanged(fbtADD, fDocNew);
    ButtonStateChanged(fbtMODIFY, fDocEdit);
    ButtonStateChanged(fbtDELETE, fDocDelete);
    ButtonStateChanged(fbtCLONE, fClone);

    GoodsSelectionChanged;
    ExpensesSelectionChanged;
end;

procedure Tframe11PeremeshenieP.SaveFrameStates;
begin
    AppUserConfigStorage.OpenSection(self.Name);
    try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridPPTable);
        SaveGridColumnsSettings(cxGridJurnalTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe11PeremeshenieP.SetupDefaultFocus;
begin
  // grid
    cxGridPP.SetFocus;
  // columns
    cxGridPPTable_DT_NAME.Focused := True;
    cxGridDBCol_GOODS_NAME.Focused := True;

    cxGridPPTable.DataController.Groups.FullExpand;
    if Assigned(cxGridPPTable.Controller.FocusedRow) then
        cxGridPPTable.Controller.FocusedRow.MakeVisible;
end;

procedure Tframe11PeremeshenieP.SetupQtyFields;
begin
     // Товары: Кол-во
    TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
    cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
     // ТТовары: Остаток
    TcxCalcEditProperties(cxGridJurnal_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
end;

procedure Tframe11PeremeshenieP.SetupSecurityItems;
begin
    fSYS_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Просмотр);
    fSYS_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Создать);
    fSYS_CanEditDoc := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Редактировать);
    fSYS_CanEditAfter30min := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Редактирование_после_30_минут);
    fSYS_CanEditGoods := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Работа_с_товарами);
    fSYS_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Удалить);

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Отменить_отправку_перемещения)
        then
        bbCancelSendGoods.Visible := ivNever;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Выписать_счет_фактуры)
        then
    begin
        bbCreateScetFactura.Visible := ivNever;
        bbCompositeScetFactura.Visible := ivNever;
    end;

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Отправить_товар) then
    begin
        bbDescribeSend.Visible := ivNever;
        bbSendGoods.Visible := ivNever;
        bbPrintShipmentPaper.Visible := ivNever;
    end;

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Видеть_колонку_цен)
        or SWNSecurityManager.IsPartialAccessMode then
    begin
        cxGridJurna_PRICE.Visible := False;
        cxGridJurna_PRICE.VisibleForCustomization := False;
        cxGridJurnal_SUMA.Visible := False;
        cxGridJurnal_SUMA.VisibleForCustomization := False;
        cxGridJurnal_PRICE_COLUMN.Visible := False;
        cxGridJurnal_PRICE_COLUMN.VisibleForCustomization := False;
    end;

     // Принять товар и провести
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Принять_товар) then
        bbReceiveGoods.Visible := ivNever;

     // hide popup
    if pmPopupMenuDoc.ItemLinks.VisibleItemCount = 0 then
        cxGridPopupMenuPP.PopupMenus.Clear;

     // Доп. расходы
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Дополнительные_расходы) then
    begin
        tbsExpenses.TabVisible := False;
        pcPageControlBottom.Properties.HideTabs := True;
    end;

    fSYS_ExpNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ДР_Создать);
    fSYS_ExpEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ДР_Редактировать);
    fSYS_ExpDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ДР_Удалить);

    if not fSYS_ExpNew then
        bbExpNew.Visible := ivNever;
    if not fSYS_ExpEdit then
        bbExpEdit.Visible := ivNever;
    if not fSYS_ExpDelete then
        bbExpDelete.Visible := ivNever;

    if dxBarManagerBar2.ItemLinks.VisibleItemCount = 0 then
    begin
        dxBarManagerBar2.Visible := False;
        dxBarDockControl2.Visible := False;
    end;

     // Карточка товара
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Карточка_товара)
        or SWNSecurityManager.IsPartialAccessMode then
        bbGoodsInfoCard.Visible := ivNever;
     // Изменить цены товара
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара)
        or SWNSecurityManager.IsPartialAccessMode then
        bbGoodsPrice.Visible := ivNever;
     // Соответствие товара в других фирмах
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
        bbGoodsForeignCode.Visible := ivNever;
     // импорт товара из приходной накладной
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Импорт) then
        btnImportPN.Visible := ivNever;

     // импорт товара из приходной накладной
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение_Импорт_серийных_номеров)
        then
        bbImportSN.Visible := ivNever;

    if (dxBarPopupMenuJURNAL.ItemLinks.VisibleItemCount = 0) then
        cxGridPopupMenuJURNAL.PopupMenus.Clear;
end;

procedure Tframe11PeremeshenieP.ShowAddNewGoodsDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
     // show dialog
    dialog := TfrmSelectGoodsToAddDlg.Create(self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal, -1);
    try
        dialog.AddNewGoods := True;
        dialog.OnVerifyGoodsExists := WhenVerifyGoodsExists;

        dialog.DefaultPriceColumn := GetPeremesheniePriceColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);

        dialog.AllowedActions := dialog.AllowedActions - [acChangeACNT, acChangeEU, acChangeEUK,
            acChangeWarranty]; // +[acChangeActive];
        dialog.VisibleActions := dialog.VisibleActions - [acChangeACNT, acChangeEU, acChangeEUK,
            acChangeWarranty]; // +[acChangeActive];
        if dialog.ShowModal = mrOk then
        begin
            dmDB.IBCQueryDocs.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe11PeremeshenieP.ShowCompositeScetFacturaDialog;
var
    dialog: TfrmCompositeScetFacturaDlg;
begin
    dialog := TfrmCompositeScetFacturaDlg.Create(Self);
    try
        if dialog.ShowModal = mrOk then
        begin
            CreateCompositeScetFacturaDB(dialog.GetDocumentsList);
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe11PeremeshenieP.ShowCreateNewExpenseDialog;
var
    dialog: TfrmExpenseEditorDlg;
begin
    dialog := TfrmExpenseEditorDlg.Create(self, IBCQueryExp, IBCDataSourceExp);
    try
        dialog.DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        dialog.DT := dmDB.IBCQueryDocs.FieldByName('DT').AsInteger;
        dialog.CT := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
        dialog.Doc_Info := Format('%d. %s', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.IBCQueryDocs.FieldByName
            ('DOCTYPE_NAME').AsString]);
        dialog.DT_Name := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
        dialog.CT_Name := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
        dialog.DisableDocID;
        dialog.DisableDT;
        dialog.DisableCT;
        dialog.CreateNewRecord := True;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe11PeremeshenieP.ShowCreateTTN;
begin
//  if ShowAskDialog('Factura de expeditie', Format('Eliberare factura de expeditie pentru'#13#10'"%s"?', [dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString])) = mrYes then
//  begin
//    if dmdb.DoCreateTTN(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
//      ShowInfoDialog('Factura de expeditie', 'Factura de expeditie eliberata cu succes!');
//  end;
end;

procedure Tframe11PeremeshenieP.ShowEditPartNumbersDialog(const ViewOnly: Boolean);
var
    frmSelectPartsDlg: TfrmSelectPartsDlg;
begin
    frmSelectPartsDlg := TfrmSelectPartsDlg.Create(self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        frmSelectPartsDlg.DocsDataSet := dmDB.IBCQueryDocs;
        frmSelectPartsDlg.readonly := ViewOnly;
        if frmSelectPartsDlg.ShowModal = mrOk then
            dmDB.RefreshJurnal;
    finally
        frmSelectPartsDlg.Free;
    end;
end;

procedure Tframe11PeremeshenieP.ShowEditSerialsDialog(const ViewOnly: Boolean);
var
    dialog: TfrmSelectSNDlg;
begin
    dialog := TfrmSelectSNDlg.Create(self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        dialog.DocsDataSet := dmDB.IBCQueryDocs;
        dialog.readonly := ViewOnly;
        if dialog.ShowModal = mrOk then
        begin
            dmDB.RefreshJurnal;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe11PeremeshenieP.ShowModifyExpenseDialog;
var
    dialog: TfrmExpenseEditorDlg;
begin
    dialog := TfrmExpenseEditorDlg.Create(self, IBCQueryExp, IBCDataSourceExp);
    try
        dialog.DisableDocID;
        dialog.DisableDT;
        dialog.DisableCT;
        dialog.CreateNewRecord := False;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe11PeremeshenieP.ShowModifySelectedGoodsDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
  // show dialog
    dialog := TfrmSelectGoodsToAddDlg.Create(self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal, -1);
    try
        dialog.AddNewGoods := False;

        dialog.DefaultPriceColumn := GetPeremesheniePriceColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);

        dialog.AllowedActions := dialog.AllowedActions - [acChangeACNT, acChangeEU, acChangeEUK,
            acChangeWarranty]; // +[acChangeActive];
        dialog.VisibleActions := dialog.VisibleActions - [acChangeACNT, acChangeEU, acChangeEUK,
            acChangeWarranty]; // +[acChangeActive];
        if dialog.ShowModal = mrOk then
        begin
            dmDB.IBCQueryDocs.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe11PeremeshenieP.ShowPeredatiTovarDialog;
var
    dialog: TfrmPeremesheniePeredatiTovarDlg;
begin
    dialog := TfrmPeremesheniePeredatiTovarDlg.Create(self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe11PeremeshenieP.ShowSerialPartNumbersDialogs;
var
    spType: Integer;
    canEdit, FLG_CLOSED, FLG_SEND, FLG_RECEIVE: Boolean;
begin
    FLG_SEND := dmDB.IBCQueryDocs.FieldByName('FLG_SEND').AsInteger = 1;
    FLG_RECEIVE := dmDB.IBCQueryDocs.FieldByName('FLG_RECEIVE').AsInteger = 1;
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    canEdit := (not FLG_CLOSED) and (not FLG_SEND) and (not FLG_RECEIVE);

    spType := dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;

    if spType = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет then
        ShowEditSerialsDialog((not canEdit) and fSYS_CanView)
    else if spType = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет then
        ShowEditPartNumbersDialog((not canEdit) and fSYS_CanView);
end;

function Tframe11PeremeshenieP.UpdatePricesByColumn(const ColumnID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;

        Query.SQL.Text := 'EXECUTE PROCEDURE APPLY_PRICE_GOODSCOMPLECT(:DOCID,:goodsid,:pricecolumn)';
        Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
//    Query.ParamByName('DTDEP').AsInteger := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
//    Query.ParamByName('CTDEP').AsInteger := dmDB.IBCQueryDocs.FieldByName('CTDEP').AsInteger;
        Query.ParamByName('goodsid').Value := NULL;
        Query.ParamByName('PRICECOLUMN').AsInteger := ColumnID;
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

procedure Tframe11PeremeshenieP.WhenGoodsFocusedRecordChanged(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    GoodsSelectionChanged;
end;

function Tframe11PeremeshenieP.WhenVerifyGoodsExists(const GoodsID: Integer): Boolean;
var
    i: Integer;
begin
    Result := False;
    for i := 0 to cxGridJurnalTable.DataController.RecordCount - 1 do
    begin
        if cxGridJurnalTable.DataController.Values[i, cxGridDBCol_GOODSID.Index] = GoodsID then
        begin
            Result := True;
            Break;
        end;
    end;
end;

procedure Tframe11PeremeshenieP.WhenCustomDataFilterGetSQL(var FilterSQL: string);
begin
     // in Перемещение firma documentului sau contragentul sa coincida cu firma curenta
    FilterSQL := StringReplace(FilterSQL, '(DT=:DT)', '(DT=:DT OR CT=:DT)', [rfIgnoreCase]);
end;

procedure Tframe11PeremeshenieP.WhenDocumentFocusedRecordChanged(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    DocumentSelectionChanged;
end;

procedure Tframe11PeremeshenieP.WhenDocumentPopupMenuOpen;
var
    fScetFactura, fSend, fReceive: Boolean;
    FLG_CLOSED, FLG_SEND, FLG_RECEIVE, FLG_PROTECTED: Boolean;
    fIsOwner, fTTN: Boolean;
begin
    fScetFactura := False;
    fSend := False;
    fReceive := False;
    fTTN := False;

    if cxGridPPTable.DataController.RecNo > 0 then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
        FLG_SEND := dmDB.IBCQueryDocs.FieldByName('FLG_SEND').AsInteger = 1;
        FLG_RECEIVE := dmDB.IBCQueryDocs.FieldByName('FLG_RECEIVE').AsInteger = 1;
        FLG_PROTECTED := dmDB.IBCQueryDocs.FieldByName('FLG_PROTECTED').AsInteger = 1;

        fIsOwner := True;
        if (FLG_PROTECTED) then
            fIsOwner := (dmDB.IBCQueryDocs.FieldByName('CREATED_BY').AsInteger = dmDB.CurrentUserID)
                or (SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Depozit_Gestionar_depozit)) or (SWNSecurityManager.UserIsPartOfGroup
                (cUserGroup_Depozit_Manipulanti_marfa)) or (SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Depozit_Hamali));

        fSend := (not FLG_SEND) and (not FLG_RECEIVE) and (not FLG_CLOSED) and fIsOwner;
    // Передать товар + Security
        fReceive := FLG_SEND and (not FLG_RECEIVE) and (not FLG_CLOSED); // Принять товар + Security
        fScetFactura := FLG_SEND; // Создать счет-фактуры
        fTTN := FLG_SEND;
    end;

    bbCreateScetFactura.Enabled := fScetFactura;
    bbDescribeSend.Enabled := fSend;
    bbSendGoods.Enabled := fSend;
    bbReceiveGoods.Enabled := fReceive;
end;

procedure Tframe11PeremeshenieP.WhenExpensesFocusedRecordChanged(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    ExpensesSelectionChanged;
end;

procedure Tframe11PeremeshenieP.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
    customizedFilterData: TFrameDataFilteringInfo;
begin
    customizedFilterData := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
    try
        customizedFilterData.OnCustomDataFilterGetSQL := WhenCustomDataFilterGetSQL;
        OpenExternalData(customizedFilterData);
    finally
        customizedFilterData.Free;
    end;
end;

function Tframe11PeremeshenieP.DoSendGoodsDB(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCQueryDocs.UpdateTransaction;

        try
            Query.Transaction.StartTransaction;

            Query.SQL.Text := 'EXECUTE PROCEDURE FUNC_PEREMESTITI_TOVAR(:DOCID)';
            Query.ParamByName('DOCID').AsInteger := DocID;
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

procedure Tframe11PeremeshenieP.bbImportFromDocumentClick(Sender: TObject);
var
    dialog: TfrmDocumentBrowserDlg;
    docid: integer;
begin
    dialog := TfrmDocumentBrowserDlg.Create(Self, dmDB.IBCConnection);
    try
//        dialog.FixedDocTypeID:=True;
//        dialog.DefaultDocTypeID:=106, 107;
//        dialog.DefaultUserID:=dmDB.CurrentUserID;
        if dialog.ShowModal = mrOk then
        begin
            if ShowAskDialog('Import din document', Format('Doriti sa importati documentul №%d?', [dialog.DocID]))
                = mrYes then
            begin
                DoImportDocFromPrihod(dialog.DocID);
                ShowInfoDialog('Import', 'Documentul importat!');
            end;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe11PeremeshenieP.bbImportSNClick(Sender: TObject);
var
    dialog: TfrmDocumentBrowserDlg;
    docid: integer;
begin
    dialog := TfrmDocumentBrowserDlg.Create(Self, dmDB.IBCConnection);
    try
        dialog.FixedDocTypeID := True;
        dialog.DefaultDocTypeID := 106;
//        dialog.DefaultUserID:=dmDB.CurrentUserID;
        if dialog.ShowModal = mrOk then
        begin
            if ShowAskDialog('Import din document "Intrare de marfa"', Format('Doriti sa importati documentul №%d?',
                [dialog.DocID])) = mrYes then
            begin
                DoImportSNFromDoc(dialog.DocID);
                ShowInfoDialog('Import', 'Documentul importat!');
            end;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe11PeremeshenieP.bbObnovitiOstatkiClick(Sender: TObject);
begin
    inherited;
    dmDB.ExecuteQuery('EXECUTE PROCEDURE UPDATE_DOC_STOCKQTY(:DOCID)', [dmDB.IBCQueryDocs.FieldByName
        ('DOCID').AsInteger]);
    dmDB.IBCQueryJurnal.Refresh;

end;

procedure Tframe11PeremeshenieP.ExpensesSelectionChanged;
var
    fNew, fEdit, fDelete: Boolean;
    FLG_CLOSED: Boolean;
begin
    fNew := False;
    fEdit := False;
    fDelete := False;

    if (cxGridPPTable.DataController.RecNo > 0) then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
        if not FLG_CLOSED then
        begin
            fNew := fSYS_ExpNew;
            if (cxGridExpTable.DataController.RecNo > 0) then
            begin
                fEdit := fSYS_ExpEdit;
                fDelete := fSYS_ExpDelete;
            end;
        end;
    end;

    bbExpNew.Enabled := fNew;
    bbExpEdit.Enabled := fEdit;
    bbExpDelete.Enabled := fDelete;
end;

procedure Tframe11PeremeshenieP.bbPrintShipmentPaperClick(Sender: TObject);
begin
    DoPrintShipmentReport;
end;

function Tframe11PeremeshenieP.DoReceiveGoodsDB(const DocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCQueryDocs.UpdateTransaction;

        try
            Query.Transaction.StartTransaction;

            Query.SQL.Text := 'EXECUTE PROCEDURE FUNC_PEREMESTITI_TOVAR_PRINEATI(:FIRMA,:DOCID)';
            Query.ParamByName('FIRMA').AsInteger := dmDB.CurrentFirma;
            Query.ParamByName('DOCID').AsInteger := DocID;
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

end.

