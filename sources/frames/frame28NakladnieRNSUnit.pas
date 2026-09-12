unit frame28NakladnieRNSUnit;
{
  NAKLADNIE. Retur marfa de la client (10zile)
  DocTypeID = 110
  Frame Index = 28
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxStyles,
  cxGraphics, DB,
  cxDBData, dxBar,
  DBAccess, IBC, cxPC, ExtCtrls, cxSplitter, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid,

  cxGridPopupMenu, cxCalc, SWNSecurityFlags, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  cxImageComboBox, dxBarBuiltInMenu, MemDS, cxGridCustomPopupMenu, cxClasses, dxUIAClasses;

type
  Tframe28NakladnieRNS = class(TSWNBaseFrame)
    cxGridNPN: TcxGrid;
    cxGridNPNTable: TcxGridDBTableView;
    cxGridNPNTableDocID: TcxGridDBColumn;
    cxGridNPNTableData: TcxGridDBColumn;
    cxGridNPNTableWarehouse: TcxGridDBColumn;
    cxGridNPNTableCtName: TcxGridDBColumn;
    cxGridNPNTableSuma: TcxGridDBColumn;
    cxGridNPNTableCurrencyName: TcxGridDBColumn;
    cxGridNPNTableVAT: TcxGridDBColumn;
    cxGridNPNTableRate: TcxGridDBColumn;
    cxGridNPNTableParentDocID: TcxGridDBColumn;
    cxGridNPNTableFlgACNT: TcxGridDBColumn;
    cxGridNPNTableCreatedBy: TcxGridDBColumn;
    cxGridNPNLevel: TcxGridLevel;
    cxSplitter: TcxSplitter;
    pnBottom: TPanel;
    dxBarManager: TdxBarManager;
    bbNewGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbRemoveGoods: TdxBarButton;
    bbShowSerialDialog: TdxBarButton;
    pmPopupMenuDocs: TdxBarPopupMenu;
    bbActionRKO: TdxBarButton;
    bbActionOtgruziti: TdxBarButton;
    bbActionVSF: TdxBarButton;
    dxBarManagerBar2: TdxBar;
    dxBarManagerBar3: TdxBar;
    cxGridNPNTable_FLG_CLOSED: TcxGridDBColumn;
    bbOpenDoc: TdxBarButton;
    cxGridNPN_RATEUSD: TcxGridDBColumn;
    bbCustomerDebts: TdxBarButton;
    cxGridPopupMenuNPN: TcxGridPopupMenu;
    dxBarButton1: TdxBarButton;
    bbSubItemsPriceColumns: TdxBarSubItem;
    bbPriceCol0: TdxBarButton;
    bbPriceCol1: TdxBarButton;
    bbPriceCol2: TdxBarButton;
    bbPriceCol3: TdxBarButton;
    bbPriceCol4: TdxBarButton;
    bbPriceCol5: TdxBarButton;
    bbPriceCol6: TdxBarButton;
    bbPriceCol7: TdxBarButton;
    cxGridNPNTable_CT: TcxGridDBColumn;
    cxGridNPNTable_DT: TcxGridDBColumn;
    dxBarPopupMenuCOMPONENTS: TdxBarPopupMenu;
    cxGridPopupMenuCOMPONENTS: TcxGridPopupMenu;
    bbGoodsInfoCard: TdxBarButton;
    bbGoodsPrice: TdxBarButton;
    bbGoodsForeignCode: TdxBarButton;
    cxPageControl1: TcxPageControl;
    tbGoods: TcxTabSheet;
    cxGridComponents: TcxGrid;
    cxGridComponentsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridComponents_UMID: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    dxBarDockControl2: TdxBarDockControl;
    tbFiles: TcxTabSheet;
    cxGridFiles: TcxGrid;
    cxGridFilesTable: TcxGridDBTableView;
    cxGridFiles_IMG: TcxGridDBColumn;
    cxGridFiles_DATA: TcxGridDBColumn;
    cxGridFiles_FILENAME: TcxGridDBColumn;
    cxGridFiles_FILESIZE: TcxGridDBColumn;
    cxGridFiles_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridFilesLevel: TcxGridLevel;
    dxBarManagerBar1: TdxBar;
    dxBarDockControl1: TdxBarDockControl;
    bbNewFile: TdxBarButton;
    bbDeleteFile: TdxBarButton;
    bbSaveAs: TdxBarButton;
    IBCDataSourceFiles: TIBCDataSource;
    IBCQueryFiles: TIBCQuery;
    bbSelectFromSell: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    procedure cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure bbNewGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbRemoveGoodsClick(Sender: TObject);
    procedure bbShowSerialDialogClick(Sender: TObject);
    procedure cxPageControlComplectChange(Sender: TObject);
    procedure bbActionRKOClick(Sender: TObject);
    procedure bbActionSNSClick(Sender: TObject);
    procedure bbActionOtgruzitiClick(Sender: TObject);
    procedure bbActionVSFClick(Sender: TObject);
    procedure cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbActionStartEnterSerialsClick(Sender: TObject);
    procedure cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbOpenDocClick(Sender: TObject);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbPriceCol0Click(Sender: TObject);
    procedure bbGoodsInfoCardClick(Sender: TObject);
    procedure bbGoodsPriceClick(Sender: TObject);
    procedure bbGoodsForeignCodeClick(Sender: TObject);
    procedure bbNewFileClick(Sender: TObject);
    procedure bbDeleteFileClick(Sender: TObject);
    procedure bbSaveAsClick(Sender: TObject);
    procedure bbSelectFromSellClick(Sender: TObject);
  private
    { Private declarations }
    fLastDocID: integer;
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    procedure WhenDocumentGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure ShowAddNewGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure ShowRemoveGoodsDialog;
    function DoDBAction(const ActionID: integer): Boolean;
    procedure DoDBActionEx(const ActionID: integer; const DOCID, CurrencyID, FLG_ACNT: integer; const Rate: Single; const SUMA: Currency);
    procedure DoActionRashodniiKasoviiOrder;
    procedure ShowInputSerialNumbersDialog(const ViewOnly: Boolean);
    procedure ShowInputPartNumbersDialog(const ViewOnly: Boolean);
    procedure SetupQtyFields;
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
  DataModuleAdditions, frmRNServiceDocDialog, DataModuleDB, SWNUtils,
  SWNConst, SWNTypes,
  frmMoneyIncomeDialog, frmSelectGoodsToAddDialog, SWNValueStorageUnit,
  SWNDBErrors,
  frmSerialNumbersDialog, frmPartNumbersDialog, SWNSecurity, SWNCommonDialogs, frm53RPPFileEditorDialog, frmChooseGoodsDlgUnit;

{$R *.dfm}

{ Tframe28NakladnieRNS }

procedure Tframe28NakladnieRNS.bbActionOtgruzitiClick(Sender: TObject);
begin
     // Expediaza
  if ShowAskDialog('Document', Format('Inchideti documentul № %d?', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger])) = mrYes then
  begin
    if DoDBAction(5) then
      RefreshData;
  end;
end;

procedure Tframe28NakladnieRNS.bbActionRKOClick(Sender: TObject);
begin
  DoActionRashodniiKasoviiOrder;
end;

procedure Tframe28NakladnieRNS.bbActionSNSClick(Sender: TObject);
begin
  // Creare naryad de asamblare
  if ShowAskDialog('Asamblare', 'Creare asamblare?') = mrYes then
  begin
    if DoDBAction(1) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe28NakladnieRNS.bbActionStartEnterSerialsClick(Sender: TObject);
begin
  // Incepe introducerea seriilor
  if ShowAskDialog('Serii / Partide', 'Blocarea documentului pentru introducerea seriiei / partidei?') = mrYes then
  begin
    if DoDBAction(4) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe28NakladnieRNS.bbActionVSFClick(Sender: TObject);
begin
  // Emite "Factura fiscala"
  if ShowAskDialog('Factura Fiscala"', 'Eliberati Factura Fiscala?') = mrYes then
  begin
    if DoDBAction(3) then
//      if DoDBAction(9) then
        dmDB.IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe28NakladnieRNS.bbCustomerDebtsClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe28NakladnieRNS.bbGoodsForeignCodeClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe28NakladnieRNS.bbGoodsInfoCardClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe28NakladnieRNS.bbGoodsPriceClick(Sender: TObject);
begin
  TSWNCommonDialogs.ModifyGoodsPriceDlg(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe28NakladnieRNS.bbModifyGoodsClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe28NakladnieRNS.bbNewFileClick(Sender: TObject);
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

procedure Tframe28NakladnieRNS.bbNewGoodsClick(Sender: TObject);
begin
  ShowAddNewGoodsDialog;
end;

procedure Tframe28NakladnieRNS.bbRemoveGoodsClick(Sender: TObject);
begin
  ShowRemoveGoodsDialog;
end;

procedure Tframe28NakladnieRNS.bbShowSerialDialogClick(Sender: TObject);
var
  FLG_CLOSED: Boolean;
  serialType: Integer;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  serialType := dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;

  if (serialType = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) then
    ShowInputSerialNumbersDialog(FLG_CLOSED)
  else if (serialType = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет) then
    ShowInputPartNumbersDialog(FLG_CLOSED);
end;

procedure Tframe28NakladnieRNS.ShowInputSerialNumbersDialog(const ViewOnly: Boolean);
var
  dialog: TfrmSerialNumbersDlg;
begin
  dialog := TfrmSerialNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := ViewOnly;
    dialog.NeuronSborkaMode := True;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.RefreshJurnal;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe28NakladnieRNS.ShowInputPartNumbersDialog(const ViewOnly: Boolean);
var
  dialog: TfrmPartNumbersDlg;
begin
  dialog := TfrmPartNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := ViewOnly;
    dialog.NewPartNoTemplate := CreatePartNoTemplate(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
    if dialog.ShowModal = mrOk then
    begin
      dmDB.RefreshJurnal;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe28NakladnieRNS.CreateNewRecord;
var
  dialog: TfrmRNServiceDocDlg;
begin
  dialog := TfrmRNServiceDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    if dialog.ShowModal = mrOk then
      DocumentSelectionChanged;
  finally
    dialog.Free;
  end;
end;

procedure Tframe28NakladnieRNS.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifyGoods.Enabled then
  begin
    ShowModifyGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe28NakladnieRNS.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe28NakladnieRNS.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe28NakladnieRNS.cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  inherited;
  if ARecord.Values[cxGridDBCol_STOCK_QTY.Index] <= 0 then
    AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
end;

procedure Tframe28NakladnieRNS.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe28NakladnieRNS.cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe28NakladnieRNS.cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_CLOSED.Index] = 1 then
  begin
    ACanvas.Font.Color := clGrayText;
    ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
  end;
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;

end;

procedure Tframe28NakladnieRNS.cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridNPNTable, Key, Shift);
end;

procedure Tframe28NakladnieRNS.cxPageControlComplectChange(Sender: TObject);
begin
  SelectionChanged;
end;

procedure Tframe28NakladnieRNS.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Sterge inregistrarea %d?', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger])) = mrYes then
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

procedure Tframe28NakladnieRNS.DoActionRashodniiKasoviiOrder;
var
  dialog: TfrmMoneyIncomeDlg;
begin
  dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Dispozitie de plata', 'Dispozitie de plata din casa');

    if dialog.ShowModal = mrOk then
    begin
      DoDBActionEx(2, dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.CurrencyID, dialog.FLG_ACNT, dialog.Rate, dialog.SUMA);
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe28NakladnieRNS.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete, fDebts: Boolean;
  FLG_CLOSED, fRKO, fSF, fReOpen, fClose: Boolean;
begin
  fDocNew := fSECURITY_CanNew;
  fDocEdit := False;
  fDocDelete := False;
  fDebts := False;
  fRKO := False;
  fSF := False;
  fReOpen := False;
  fClose := False;

  if (cxGridNPNTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fDocEdit := fSECURITY_CanView or not FLG_CLOSED and fSECURITY_CanEdit;
    fDocDelete := not FLG_CLOSED and fSECURITY_CanDelete;

    fLastDocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

    fRKO := True;
    fSF := True;
    fClose := not FLG_CLOSED and fSECURITY_CanEdit;
    fReOpen := FLG_CLOSED and fSECURITY_CanEdit;
    fDebts := True;
  end;

     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
  bbActionRKO.Enabled := fRKO;
  bbActionVSF.Enabled := fSF;
  bbActionOtgruziti.Enabled := fClose;
  bbOpenDoc.Enabled := fReOpen;
  bbCustomerDebts.Enabled := fDebts;

  bbNewFile.Enabled := not FLG_CLOSED and (cxGridNPNTable.DataController.RecNo > 0);
  bbDeleteFile.Enabled := fDocDelete and (cxGridFilesTable.DataController.RecNo > 0);
  bbSaveAs.Enabled := (cxGridFilesTable.DataController.RecNo > 0);

  SelectionChanged;
end;

function Tframe28NakladnieRNS.DoDBAction(const ActionID: integer): Boolean;
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
      case ActionID of
        // Deschide documentul
        1:
          Query.SQL.Text := 'EXECUTE PROCEDURE sp_open_110(:DOCID)';

        // Emite "Factura fiscala"
            3:
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_FISCAL_INVOICE_MINUS(:DOCID)';

//        9:  // Emite "ttn"
//          Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_TTN_INVOICE(:DOCID)';



        // Confirma
            5:
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_110(:DOCID)';
      end;
      // set params
      Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
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

procedure Tframe28NakladnieRNS.DoDBActionEx(const ActionID, DOCID, CurrencyID, FLG_ACNT: integer; const Rate: Single; const SUMA: Currency);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      case ActionID of
        // Dispozitie de incasare
        1:
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_PKO(:DOCID,:CurrencyID,:FLG_ACNT,:Rate,:SUMA)';
        // Dispozitie de plata
            2:
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_RKO(:DOCID,:CurrencyID,:FLG_ACNT,:Rate,:SUMA)';
      end;
      // set params
      Query.ParamByName('DOCID').AsInteger := DOCID;
      Query.ParamByName('CurrencyID').AsInteger := CurrencyID;
      Query.ParamByName('FLG_ACNT').AsInteger := FLG_ACNT;
      Query.ParamByName('Rate').AsFloat := Rate;
      Query.ParamByName('SUMA').AsCurrency := SUMA;
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

procedure Tframe28NakladnieRNS.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridNPNTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridNPNTable.DataController.DataSource := nil;
  cxGridComponentsTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe28NakladnieRNS.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  fLastDocID := -1;

     // 1. Legam grid-urile de datasource-sele
  cxGridNPNTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridNPNTable.OnFocusedRecordChanged := WhenDocumentGrid_FocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
  DocumentSelectionChanged;
end;

procedure Tframe28NakladnieRNS.dxBarButton1Click(Sender: TObject);
begin
  if ShowAskDialog('Factura', Format('Eliberarea facturii pentru'#13#10'"%s"?', [dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString])) = mrYes then
  begin
    if dmdb.DoCreateFactura(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      ShowInfoDialog('Factura', 'Creata cu succes!');
  end;
end;

procedure Tframe28NakladnieRNS.bbSelectFromSellClick(Sender: TObject);
var
  dialog: TfrmChooseGoodsDlg;
begin
  Dialog := TfrmChooseGoodsDlg.Create(Self,dmDB.IBCConnection);
  try
    dialog.CustomerID := dmdb.IBCQueryDocs.FieldByName('CT').AsInteger;
    dialog.UntilDate := dmdb.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe28NakladnieRNS.bbDeleteFileClick(Sender: TObject);
begin
  if ShowAskDialog('Scan', Format('Scanarea fisierului "%s"?', [IBCQueryFiles.FieldByName('FILENAME').AsString])) = mrYes then
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

procedure Tframe28NakladnieRNS.bbSaveAsClick(Sender: TObject);
var
  Query: TIBCQuery;
begin
  with TSaveDialog.Create(Self) do
  try
    FileName := IBCQueryFiles.FieldByName('FILENAME').AsString;
    Filter := '*.*';
    if Execute then
    begin
      Query := TIBCQuery.Create(Self);
      try
        Query.Connection := dmDB.IBCConnection;
        Query.SQL.Text := 'SELECT FILEDATA FROM TDB_DOCS_ATTACHMENTS WHERE ATTID=:ID';
        Query.ParamByName('ID').AsInteger := IBCQueryFiles.FieldByName('ATTID').AsInteger;
        Query.ExecSQL;
        if not Query.Eof then
          TBlobField(Query.Fields[0]).SaveToFile(FileName);
      finally
        Query.Free;
      end;
    end;
  finally
    Free;
  end;
end;

procedure Tframe28NakladnieRNS.bbOpenDocClick(Sender: TObject);
begin
     // Deschide documentul
  if ShowAskDialog('Document', Format('Deschide documentul № %d?', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger])) = mrYes then
  begin
    if DoDBAction(1) then
      RefreshData;
  end;
end;

procedure Tframe28NakladnieRNS.bbPriceCol0Click(Sender: TObject);
var
  PriceColumn: integer;
begin
  PriceColumn := TdxBarButton(Sender).Tag;
  if dmDB.UpdateJurnalGoodsPricesByColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger, dmDB.IBCQueryDocs.FieldByName('DTDEP').asInteger, dmDB.IBCQueryDocs.FieldByName('CTDEP').asInteger, -1, PriceColumn) then
    RefreshData;
end;

function Tframe28NakladnieRNS.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
          // context from Jurnal: Cod + Denumire
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridNPNTable.Site.Focused then
  begin
              // context from Docs
    if cxGridNPNTableCtName.Focused then
    begin
                   // Contraagent
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridNPNTableData.Focused then
    begin
                       // Data
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridNPNTableWarehouse.Focused then
    begin
                           // Depozit
      Result.Context := ffStock;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe28NakladnieRNS.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe28NakladnieRNS.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods, ffStock];
end;

function Tframe28NakladnieRNS.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanView or fSECURITY_CanEdit then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe28NakladnieRNS.InitFrameID: integer;
begin
  Result := 28; // NAKLADNIE. Retur marfa de la client (10zile)
  SetupQtyFields;
end;

procedure Tframe28NakladnieRNS.ModifyRecord;
var
  dialog: TfrmRNServiceDocDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;
  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  dialog := TfrmRNServiceDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.readonly := readonly;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe28NakladnieRNS.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridNPNTable);
    AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridComponentsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe28NakladnieRNS.ShowAddNewGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal, -1);
  try
    dialog.AddNewGoods := True;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe28NakladnieRNS.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal, -1);
  try
    dialog.AddNewGoods := False;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe28NakladnieRNS.ShowRemoveGoodsDialog;
var
  S, S2: WideString;
begin
  if dmDB.IsKit(dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger) then
    S2 := 'Complectatia va fi eliminata!'
  else
    S2 := '';
  S := Format(cMSG_DELETERECORD_РасходнаяНакладная, [dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, S, S2) = mrYes then
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

procedure Tframe28NakladnieRNS.WhenDocumentGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe28NakladnieRNS.WhenGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure Tframe28NakladnieRNS.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridNPNTable);
    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridComponentsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe28NakladnieRNS.SelectionChanged;
var
  fGoodsAdd, fGoodsEdit, fGoodsDelete, FLG_CLOSED: Boolean;
  fSerials, fChangePrice, fGoodsSelected: Boolean;
  SerialType: integer;
begin
     // goods
  fGoodsAdd := False;
  fGoodsEdit := False;
  fGoodsDelete := False;
  fChangePrice := False;
  fSerials := False;
  fGoodsSelected := False;

  if (cxGridNPNTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fGoodsAdd := not FLG_CLOSED;

    if cxGridComponentsTable.DataController.RecNo > 0 then
    begin
      SerialType := dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;

      fGoodsEdit := not FLG_CLOSED; // Modify "Componenta" + Security
      fGoodsDelete := not FLG_CLOSED; // Delete "Componenta" + Security
      fSerials := (SerialType = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (SerialType = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);
      fChangePrice := not FLG_CLOSED;

      fGoodsSelected := True;
    end;
  end;

  bbNewGoods.Enabled := fGoodsAdd;
  bbModifyGoods.Enabled := fGoodsEdit;
  bbRemoveGoods.Enabled := fGoodsDelete;
  bbShowSerialDialog.Enabled := fSerials;
  bbPriceCol0.Enabled := fChangePrice;
  bbPriceCol1.Enabled := fChangePrice;
  bbPriceCol2.Enabled := fChangePrice;
  bbPriceCol3.Enabled := fChangePrice;
  bbPriceCol4.Enabled := fChangePrice;
  bbPriceCol5.Enabled := fChangePrice;
  bbPriceCol6.Enabled := fChangePrice;
  bbPriceCol7.Enabled := fChangePrice;

  bbGoodsInfoCard.Enabled := fGoodsSelected;
  bbGoodsPrice.Enabled := fGoodsSelected;
  bbGoodsForeignCode.Enabled := fGoodsSelected;

end;

procedure Tframe28NakladnieRNS.SetupDefaultFocus;
begin
     // focused grid
  cxGridNPN.SetFocus;
     // set focused column
  cxGridNPNTableCtName.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe28NakladnieRNS.SetupQtyFields;
begin
     // Cantitate
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
     // Stoc
  TcxCalcEditProperties(cxGridDBCol_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
end;

procedure Tframe28NakladnieRNS.SetupSecurityItems;
begin
  // Retur marfa
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ВТ_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ВТ_Новый);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ВТ_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ВТ_Удалить);

     // Coloana preturi
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_0) then
    bbPriceCol0.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_1) then
    bbPriceCol1.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_2) then
    bbPriceCol2.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_3) then
    bbPriceCol3.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_4) then
    bbPriceCol4.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_5) then
    bbPriceCol5.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_6) then
    bbPriceCol6.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_7) then
    bbPriceCol7.Visible := ivNever;

     // Fisa produsului
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Карточка_товара) or SWNSecurityManager.IsPartialAccessMode then
    bbGoodsInfoCard.Visible := ivNever;
     // Modifica preturile marfii
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара) or SWNSecurityManager.IsPartialAccessMode then
    bbGoodsPrice.Visible := ivNever;
     // Corespondenta produsului in alte firme
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
    bbGoodsForeignCode.Visible := ivNever;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbCustomerDebts.Visible := ivNever;
  end;

  if (bbSubItemsPriceColumns.ItemLinks.VisibleItemCount = 0) then
    bbSubItemsPriceColumns.Visible := ivNever;
  if (dxBarPopupMenuCOMPONENTS.ItemLinks.VisibleItemCount = 0) then
    cxGridPopupMenuCOMPONENTS.PopupMenus.Clear;
end;

end.

