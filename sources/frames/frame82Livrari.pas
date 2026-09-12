unit frame82Livrari;

// Livrare
// DocTypeID = 3232
// Frame Index = 1

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs, SWNDataFiltering,
  SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit,
  cxLabel, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, StdCtrls, ExtCtrls, cxLookAndFeels, cxLookAndFeelPainters, dxBar, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxNavigator, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu,
  DBAccess, IBC, MemDS, dxScrollbarAnnotations, Vcl.Menus, cxButtons, cxCalc, cxImageComboBox, dxUIAClasses;

type
  Tframe82Livrari = class(TSWNBaseFrame)
    dxBarManager: TdxBarManager;
    dxBarPopupMenuLivrari: TdxBarPopupMenu;
    bbPrintReceipe: TdxBarButton;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    IBCQueryWaybill: TIBCQuery;
    IBCDataSourceWaybill: TIBCDataSource;
    IBCQueryWaybillItems: TIBCQuery;
    IBCDataSourceWayBillItems: TIBCDataSource;
    dxBarManagerBar1: TdxBar;
    bbCloseDelivery: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    Panel1: TPanel;
    cxGridLivrari: TcxGrid;
    cxGridLivrari_WAYBILL: TcxGridDBTableView;
    cxGridLivrari_WAYBILLFLG_CLOSED: TcxGridDBColumn;
    cxGridLivrari_WAYBILLWAYBILLID: TcxGridDBColumn;
    cxGridLivrari_WAYBILLCURIERID: TcxGridDBColumn;
    cxGridLivrari_WAYBILLCREATED_DATE: TcxGridDBColumn;
    cxGridLivrari_WAYBILLDATA: TcxGridDBColumn;
    cxGridLivrari_WAYBILLCOURIER_NAME: TcxGridDBColumn;
    cxGridLivrari_WAYBILLTRANSPORTID: TcxGridDBColumn;
    cxGridLivrari_WAYBILLTRANSPORT_NAME: TcxGridDBColumn;
    cxGridLivrari_WAYBILLSC: TcxGridDBColumn;
    cxGridLivrari_WAYBILLCREATED_BY: TcxGridDBColumn;
    cxGridLivrari_WAYBILLCREATED_BY_NAME: TcxGridDBColumn;
    cxGridLivrariLevel1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView1WAYBILLID: TcxGridDBColumn;
    cxGridDBTableView1DOCID_RASHOD: TcxGridDBColumn;
    cxGridDBTableView1DOCID_RAMBURS: TcxGridDBColumn;
    cxGridDBTableView1FLG_CLOSED: TcxGridDBColumn;
    cxGridDBTableView1CUSTOMERID: TcxGridDBColumn;
    cxGridDBTableView1CUSTOMER_NAME: TcxGridDBColumn;
    cxGridDBTableView1CREATED_BY: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    Panel2: TPanel;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    Panel3: TPanel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    IBCQueryOpenedWaybills: TIBCQuery;
    IBCDataSourceOpenedWayBills: TIBCDataSource;
    cxGrid2DBTableView1DOCID: TcxGridDBColumn;
    cxGrid2DBTableView1DATA: TcxGridDBColumn;
    cxGrid2DBTableView1CREATED_DATE: TcxGridDBColumn;
    cxGrid2DBTableView1DISTRICTID: TcxGridDBColumn;
    cxGrid2DBTableView1DISTRICT_NAME: TcxGridDBColumn;
    cxGrid2DBTableView1CITYID: TcxGridDBColumn;
    cxGrid2DBTableView1CITY_NAME: TcxGridDBColumn;
    cxGrid2DBTableView1CT: TcxGridDBColumn;
    cxGrid2DBTableView1CT_NAME: TcxGridDBColumn;
    cxGrid2DBTableView1CREATED_BY: TcxGridDBColumn;
    cxGrid2DBTableView1CREATEDBY_NAME: TcxGridDBColumn;
    cxGrid2DBTableView1SUMA: TcxGridDBColumn;
    cxGrid2DBTableView1DELIVERY_ADDRESS: TcxGridDBColumn;
    cxGridDBTableView1SUMA_REZERAV: TcxGridDBColumn;
    cxGridDBTableView1SUMA_RAMBURS: TcxGridDBColumn;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGridDBTableView1Column2: TcxGridDBColumn;
    cxGridComponents: TcxGrid;
    cxGridComponentsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridComponentsTable_FLG_FA: TcxGridDBColumn;
    cxGridComponents_FLG_SUPPLIER_PROMO: TcxGridDBColumn;
    cxGridComponents_FLG_PROMO: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridComponents_UMID: TcxGridDBColumn;
    cxGridComponents_FLG_FORCED: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridComponents_PRICE_USD: TcxGridDBColumn;
    cxGridComponents_DISCOUNT_P: TcxGridDBColumn;
    cxGridComponents_DISCOUNT_SUMA: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridComponents_SUMA_USD: TcxGridDBColumn;
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridComponents_PRICE_COLUMN: TcxGridDBColumn;
    cxGridComponents_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    IBCQueryJurnal: TIBCQuery;
    IBCDataSourceJurnal: TIBCDataSource;
    dxBarButton3: TdxBarButton;
    cxGrid2DBTableView1DOCTYPE_NAME: TcxGridDBColumn;
    dxBarPopupMenuWaybillItems: TdxBarPopupMenu;
    cxGrid2DBTableView1DeliveryType: TcxGridDBColumn;
    cxGrid3: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBColumn10: TcxGridDBColumn;
    cxGridDBColumn11: TcxGridDBColumn;
    cxGridDBColumn12: TcxGridDBColumn;
    cxGridDBColumn13: TcxGridDBColumn;
    cxGridDBColumn14: TcxGridDBColumn;
    cxGridDBColumn15: TcxGridDBColumn;
    cxGridDBColumn16: TcxGridDBColumn;
    cxGridDBColumn17: TcxGridDBColumn;
    cxGridDBColumn18: TcxGridDBColumn;
    cxGridDBColumn19: TcxGridDBColumn;
    cxGridDBColumn20: TcxGridDBColumn;
    cxGridDBColumn21: TcxGridDBColumn;
    cxGridDBColumn22: TcxGridDBColumn;
    cxGridDBColumn23: TcxGridDBColumn;
    cxGridDBColumn24: TcxGridDBColumn;
    cxGridDBColumn25: TcxGridDBColumn;
    cxGridDBColumn26: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    IBCQueryJurnalLivrari: TIBCQuery;
    IBCDataSourceJurnalLivrari: TIBCDataSource;
    procedure cxGridLivrariDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridLivrariDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBarPopupMenuLivrariPopup(Sender: TObject);
    procedure cxGridCasaPKO_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridLivrariDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCloseDocClick(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure bbCloseDeliveryClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure cxGrid2DBTableView1DblClick(Sender: TObject);
    procedure cxGrid2DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDBTableView1DblClick(Sender: TObject);
    procedure cxGridDBTableView1EditKeyDown(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit:
      TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure cxGridDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridLivrari_WAYBILLCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarButton3Click(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete, fSECURITY_OnlyOwnDocuments: Boolean;
    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenPopupMenuPopup;
    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID: integer): Boolean;
    procedure DoCloseInvoices(WAYBILLID: Integer);
    procedure WhenCustomDataFilterGetSQL(var FilterSQL: string);
    procedure WhenCustomDataFilterSetParams(const Query: TIBCQuery);

  protected
    { Protected declarations }
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
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: string): Variant; override;

  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
// TODO: ShowPrintReceiptDialog
//  procedure ShowPrintReceiptDialog;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, DateUtils, SWNValueStorageUnit,
  frmCustomerCurrentDebtsDialog, SWNSecurity, frmPKODocDialog, SWNSecurityFlags, frmCustomerNotifyDebtsDialog, frm81DocDialog,
  frm82DocumentEditUnit, frmCustomersDlg, cxDataUtils;

{$R *.dfm}

{ TSWNBaseFrame1 }

procedure Tframe82Livrari.bbCloseDeliveryClick(Sender: TObject);
var
  i: Integer;
  GridKey: Variant;
begin
  cxGridDBTableView1.BeginUpdate;

  for i := 0 to cxGridDBTableView1.DataController.RecordCount - 1 do
  begin
    GridKey := cxGridDBTableView1.DataController.Values[i, cxGridDBTableView1DOCID_RASHOD.Index];
    if cxGridDBTableView1.DataController.LocateByKey(GridKey) then
    begin
      cxGridDBTableView1.DataController.Edit;
      cxGridDBTableView1.DataController.SetEditValue(cxGridDBTableView1FLG_CLOSED.Index, 1, evstext); // cxGridDBTableView1FLG_CLOSED.Index] := 1;
      cxGridDBTableView1.DataController.Post;
    end;
  end;

  cxGridDBTableView1.EndUpdate;
end;

procedure Tframe82Livrari.bbCloseDocClick(Sender: TObject);
begin
  DoCloseDocument;
  DoCloseInvoices(IBCQueryWaybill.FieldByName('WAYBILLID').AsInteger);
end;

procedure Tframe82Livrari.bbOpenDocClick(Sender: TObject);
begin
  dmDB.ExecuteQuery('EXECUTE PROCEDURE SP_OPEN_INVOICE_FROM_WAYBILL(:WAYBILLID)', [IBCQueryWaybill.FieldByName('WAYBILLID').AsInteger]);
  RefreshData;
end;

procedure Tframe82Livrari.CreateNewRecord;
var
  dialog: Tfrm82DocumentEditDlg;
begin
  dialog := Tfrm82DocumentEditDlg.Create(Self, IBCQueryWaybill, IBCDataSourceWaybill);
  try
    dialog.IsNewRecord := True;
    dialog.ShowModal;

  finally
    dialog.Free;
  end;
end;

procedure Tframe82Livrari.cxGridLivrariDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  DoDocumentDoubleClick;
  AHandled := True;
end;

procedure Tframe82Livrari.cxGridLivrariDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
//  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridCasaPKO_FLG_CLOSED.index]) then
//  begin
//    if AViewInfo.GridRecord.Values[cxGridCasaPKO_FLG_CLOSED.index] = 0 then
//    begin
//      if not AViewInfo.Selected then
//      begin
//                    // Document prin contabilitate
//        if AViewInfo.GridRecord.Values[cxGridCasaPKO_FLG_ACNT.Index] = 1 then
//          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
//      end;
//    end
//    else
//    begin
//      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
//      if not AViewInfo.Selected then
//      begin
//        if AViewInfo.GridRecord.Values[cxGridCasaPKO_FLG_ACNT.Index] = 1 then
//          ACanvas.Font.Color := $008b8bc5
//        else
//          ACanvas.Font.Color := clGrayText;
//      end;
//    end;
//  end;
//
//     // highlight selected row
//  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
//  begin
//    ACanvas.Brush.Color := $E8E8E8;
//  end;
end;

procedure Tframe82Livrari.cxButton1Click(Sender: TObject);
begin
  inherited;
  with IBCQueryWaybillItems do
  begin
    Append;
    FieldByName('DOCID_RASHOD').AsInteger := IBCQueryOpenedWaybills.FieldByName('DOCID').AsInteger;
    FieldByName('waybillid').AsInteger := IBCQueryWaybill.FieldByName('waybillid').AsInteger;
    FieldByName('FLG_CLOSED').AsInteger := 0;

    if (IBCQueryOpenedWaybills.FieldByName('DISTRICT_NAME').AsString <> '') then
      IBCQueryWaybillItems.FieldByName('DELIVERY_ADDRESS').AsString := IBCQueryOpenedWaybills.FieldByName('DISTRICT_NAME').AsString;

    if (IBCQueryOpenedWaybills.FieldByName('CITY_NAME').AsString <> '') then
      IBCQueryWaybillItems.FieldByName('DELIVERY_ADDRESS').AsString := IBCQueryWaybillItems.FieldByName('DELIVERY_ADDRESS').AsString
        + ' ' + IBCQueryOpenedWaybills.FieldByName('CITY_NAME').AsString;

    if (IBCQueryOpenedWaybills.FieldByName('DELIVERY_ADDRESS').AsString <> '') then
      IBCQueryWaybillItems.FieldByName('DELIVERY_ADDRESS').AsString := IBCQueryWaybillItems.FieldByName('DELIVERY_ADDRESS').AsString
        + ' ' + IBCQueryOpenedWaybills.FieldByName('DELIVERY_ADDRESS').AsString;

    Post;
  end;
  IBCQueryOpenedWaybills.Refresh;
end;

procedure Tframe82Livrari.cxButton2Click(Sender: TObject);
begin

  if (MessageDlg(Format('Anulati livrarea catre clientul: %s', [IBCQueryWaybillItems.FieldByName('CUSTOMER_NAME').AsString]),
    mtConfirmation, [mbYes, mbNo], 0)) = mrYes then
  begin
    if cxGridDBTableView1.DataController.RecNo > 0 then
    begin
      IBCQueryWaybillItems.Delete;
      IBCQueryOpenedWaybills.Refresh;
    end;
  end;
end;

procedure Tframe82Livrari.cxGrid2DBTableView1DblClick(Sender: TObject);
begin
  cxButton1Click(Sender);
end;

procedure Tframe82Livrari.cxGrid2DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridDBTableView1, Key, Shift);
end;

procedure Tframe82Livrari.cxGridCasaPKO_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
  AText: string);
begin
//  if not VarIsNull(ARecord.Values[cxGridCasaPKO_DATA.Index]) then
//    AText := FormatDateTime('dd.mm.yyyy HH:MM', ARecord.Values[cxGridCasaPKO_DATA.Index]);
end;

procedure Tframe82Livrari.cxGridDBTableView1DblClick(Sender: TObject);
begin
  cxButton2Click(Sender);
end;

procedure Tframe82Livrari.cxGridDBTableView1EditKeyDown(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit:
  TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    if IBCQueryWaybillItems.State in dsEditModes then
      IBCQueryWaybillItems.Post;
  end;
end;

procedure Tframe82Livrari.cxGridDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridDBTableView1, Key, Shift);
end;

procedure Tframe82Livrari.cxGridLivrariDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridLivrari_WAYBILL, Key, Shift);
end;

procedure Tframe82Livrari.cxGridLivrari_WAYBILLCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridLivrari_WAYBILLFLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridLivrari_WAYBILLFLG_CLOSED.index] = 1 then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
        ACanvas.Font.Color := clGrayText;
    end;
  end;

//     // highlight selected row
//    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
//    begin
//        ACanvas.Brush.Color := clBlue;
//    end;
end;

procedure Tframe82Livrari.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Stergeti cererea de livrare Nr. ', [dmDB.IBCQueryDocs.FieldByName
    ('DOCID').asInteger])) = mrYes then
  begin
    IBCQueryWaybill.UpdateTransaction.StartTransaction;
    try
      IBCQueryWaybill.Delete;
      IBCQueryWaybill.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryWaybill.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe82Livrari.DoCloseDocument;
//var
//  b: Boolean;
begin
//  b := AppUserTempConfigStorage.BooleanValues.GetValue('PKO_CloseDocVerify');
//  if b or (ShowAskDialogVerification('Oridin de incasare', 'Inchideti documentul?', 'Nu mai intreba', '', b) = mrYes) then
//  begin
//    if b then
//      AppUserTempConfigStorage.BooleanValues.SetValue('PKO_CloseDocVerify', b);
  DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
//    dmDB.IBCQueryDocs.RefreshRecord;
//  end;
end;

function Tframe82Livrari.DoCloseDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_LIVRARE(:DOCID)';
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

procedure Tframe82Livrari.DoCloseInvoices(WAYBILLID: Integer);
begin
  dmDB.ExecuteQuery('EXECUTE PROCEDURE SP_CLOSE_INVOICE_FROM_WAYBILL(:WAYBILLID)', [WAYBILLID]);
  RefreshData;
end;

procedure Tframe82Livrari.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridLivrari_WAYBILL.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridLivrari_WAYBILL.DataController.DataSource := nil;

  IBCQueryWaybill.Close;
  IBCQueryWaybillItems.Close;
  IBCQueryOpenedWaybills.Close;
  inherited;
end;

procedure Tframe82Livrari.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customDataFilter: TFrameDataFilteringInfo;
begin
  inherited;

  IBCQueryWaybill.Open;
  IBCQueryWaybillItems.Open;
  IBCQueryJurnalLivrari.Open;

  IBCQueryOpenedWaybills.Close;
  IBCQueryOpenedWaybills.ParamByName('DT').AsInteger := dmdb.CurrentFirma;
  IBCQueryOpenedWaybills.Open;
  IBCQueryJurnal.Open;

     // 1. Legam grid-urile de datasource-sele
  cxGridLivrari_WAYBILL.DataController.DataSource := IBCDataSourceWaybill;

     // 2. Selection handlers
  cxGridLivrari_WAYBILL.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;

  customDataFilter := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
  try
    customDataFilter.OnCustomDataFilterGetSQL := WhenCustomDataFilterGetSQL;
    customDataFilter.OnCustomDataFilterSetParams := WhenCustomDataFilterSetParams;
    OpenExternalData(customDataFilter);
  finally
    customDataFilter.Free;
  end;


  //  customDataFilter := FrameDataFilterInfo.Clone;
  try
        // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
//    customDataFilter.FilterByCurrentUser := fSECURITY_OnlyOwnDocuments;
    OpenExternalData(customDataFilter);

  finally
//    customDataFilter.Free;
  end;

     // 4. Selection update
  SelectionChanged;
end;

procedure Tframe82Livrari.dxBarButton1Click(Sender: TObject);
begin
  IBCQueryWaybillItems.Edit;
  IBCQueryWaybillItems.FieldByName('FLG_CLOSED').AsInteger := 0;
  IBCQueryWaybillItems.Post;
end;

procedure Tframe82Livrari.dxBarButton2Click(Sender: TObject);
begin
  inherited;
  IBCQueryOpenedWaybills.Refresh;
end;

procedure Tframe82Livrari.dxBarButton3Click(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Owner);
  if dialog.SelectCustomer(-1) then
  begin

    IBCQueryWaybillItems.AppendRecord([IBCQueryWaybill.FieldByName('WAYBILLID').AsInteger, -1, -1, 0, dialog.CustomerID, '',
      '', '', null, null, 0]);
    IBCQueryWaybillItems.Refresh;
  end;
end;

procedure Tframe82Livrari.dxBarPopupMenuLivrariPopup(Sender: TObject);
begin
  WhenPopupMenuPopup;
end;

function Tframe82Livrari.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

//  if cxGridLivrariDBTableView1.Site.Focused then
//  begin
//          // context from Docs
//    if cxGridCasaPKO_CT_NAME.Focused then
//    begin
//        // Platitor
//      Result.Context := ffCustomer;
//      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
//      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
//    end
//    else if cxGridCasaPKO_DATA.Focused then
//    begin
//        // Data
//      Result.Context := ffDate;
//      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
//    end;
//  end
end;

function Tframe82Livrari.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs];
end;

function Tframe82Livrari.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer];
end;

function Tframe82Livrari.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe82Livrari.GetParamsListForReport(const ParamsList: TStringList);
begin
  if (cxGridLivrari_WAYBILL.DataController.RecNo > 0) then
  begin
    ParamsList.Add('WAYBILLID');
  end;
end;

function Tframe82Livrari.GetParamValueForReport(const ParamName: string): Variant;
begin
  if (cxGridLivrari_WAYBILL.DataController.RecNo > 0) then
  begin
    if SameText(ParamName, 'WAYBILLID') then
      Result := IBCQueryWaybill.FieldByName('WAYBILLID').AsInteger;
  end;

end;

function Tframe82Livrari.InitFrameID: integer;
begin
     // Livrari
  Result := 82;

end;

procedure Tframe82Livrari.ModifyRecord;
var
  dialog: Tfrm82DocumentEditDlg;
  readonly: Boolean;
begin
  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  dialog := Tfrm82DocumentEditDlg.Create(Self, IBCQueryWaybill, IBCDataSourceWaybill);
  try
    dialog.IsNewRecord := False;
    dialog.readonly := readonly;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe82Livrari.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    ReadGridColumnsSettings(cxGridLivrari_WAYBILL);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe82Livrari.RefreshData;
begin
  IBCQueryWaybill.Refresh;
  IBCQueryWaybillItems.Refresh;
  IBCQueryOpenedWaybills.Refresh;
end;

procedure Tframe82Livrari.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
    SaveGridColumnsSettings(cxGridLivrari_WAYBILL);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe82Livrari.SelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED, fCloseDoc, fOpenDoc: Boolean;
begin
  fDocNew := fSECURITY_CanNew; // New document
  fDocEdit := False;
  fDocDelete := False;
  fCloseDoc := False;
  fOpenDoc := False;
  if cxGridLivrari_WAYBILL.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := IBCQueryWaybill.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit or fSECURITY_CanView;
    fDocDelete := fSECURITY_CanDelete;
    fCloseDoc := not FLG_CLOSED;
    fOpenDoc := FLG_CLOSED;
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
  bbCloseDoc.Enabled := fCloseDoc;
  bbOpenDoc.Enabled := fOpenDoc;
end;

procedure Tframe82Livrari.SetupDefaultFocus;
begin
     // grid
  cxGridLivrari.SetFocus;
     // columns
  cxGridLivrari_WAYBILL.Focused := True;
end;

procedure Tframe82Livrari.SetupSecurityItems;
begin
//  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Просмотр);
//  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Создать);
//  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Изменить);
//  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Удалить);
//  fSECURITY_OnlyOwnDocuments := Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Видеть_и_чужие_документы);
//  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Закрыть_документ) then
//    bbCloseDoc.Visible := ivNever;
//  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Открыть_документ) then
//    bbOpenDoc.Visible := ivNever;
  fSECURITY_CanView := True;
  fSECURITY_CanNew := True;
  fSECURITY_CanEdit := True;
  fSECURITY_CanDelete := True;
  bbCloseDoc.Visible := ivAlways;
  bbOpenDoc.Visible := ivAlways;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
//    cxGridCasaPKO_FLG_ACNT.VisibleForCustomization := False;
//    cxGridCasaPKO_FLG_ACNT.Visible := False;
  end;
end;

// TODO: ShowPrintReceiptDialog
//procedure Tframe82Livrari.ShowPrintReceiptDialog;
//var
//dialog: TfrmReceiptPrintDlg;
//begin
//dialog := TfrmReceiptPrintDlg.Create(Self);
//try
//  dialog.RASHOD_DOCID := dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').AsInteger;
//  dialog.PKO_DOCID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
//
//  dialog.PrintWithoutPrinter := True;
//  dialog.ShowModal;
//  if dialog.ReceiptPrinted then
//    dmDB.IBCQueryDocs.Refresh;
//finally
//  dialog.Free;
//end;
//end;

procedure Tframe82Livrari.WhenCustomDataFilterGetSQL(var FilterSQL: string);
begin
  FilterSQL := FilterSQL;
end;

procedure Tframe82Livrari.WhenCustomDataFilterSetParams(const Query: TIBCQuery);
begin
//  Query.ParamByName('STATUS').AsInteger:=6101; // Incidente noi
end;

procedure Tframe82Livrari.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customDataFilter: TFrameDataFilteringInfo;
begin
  customDataFilter := FrameDataFilterInfo.Clone;
  try
    customDataFilter.FilterByCurrentUser := fSECURITY_OnlyOwnDocuments;
    inherited WhenFilterDataChanged(customDataFilter);
  finally
    customDataFilter.Free;
  end;
end;

procedure Tframe82Livrari.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
  TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure Tframe82Livrari.WhenPopupMenuPopup;
begin
end;

end.

