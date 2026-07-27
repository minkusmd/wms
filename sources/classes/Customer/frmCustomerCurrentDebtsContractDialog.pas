unit frmCustomerCurrentDebtsContractDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit, StdCtrls, ExtCtrls, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  DialogTitle, MemDS, DBAccess, IBC, cxLabel, cxNavigator, dxBar, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCheckBox, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TfrmCustomerCurrentDebtsContractDlg = class(TSWNBaseFormClass)
    dtDialogTitle: TDialogTitle;
    cxGridHistoryCash: TcxGrid;
    cxGridHistoryCashTable: TcxGridDBTableView;
    cxGridHistoryCash_DOCID: TcxGridDBColumn;
    cxGridHistoryCash_DATA: TcxGridDBColumn;
    cxGridHistoryCash_DOCTYPE_NAME: TcxGridDBColumn;
    cxGridHistoryCash_SUMA: TcxGridDBColumn;
    cxGridHistoryCash_CURRENCY_NAME: TcxGridDBColumn;
    cxGridHistoryCash_RATE: TcxGridDBColumn;
    cxGridHistoryCash_CURRENT_USD_RATE: TcxGridDBColumn;
    cxGridHistoryCash_SUMA_BALANCE: TcxGridDBColumn;
    cxGridHistoryCashLevel: TcxGridLevel;
    pnBottom: TPanel;
    btnClose: TButton;
    IBCDataSourceContractsDocuments: TIBCDataSource;
    IBCQueryContractsDocuments: TIBCQuery;
    cxGridHistoryCash_DT_NAME: TcxGridDBColumn;
    cxGridHistoryCash_CREATED_BY: TcxGridDBColumn;
    cxGridHistoryCash_DOCTYPESIGN: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    dxBarButton1: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bbChangeContract: TdxBarButton;
    IBCTrLocalWrite: TIBCTransaction;
    cxGridHistoryCash_SUMA_IN: TcxGridDBColumn;
    cxGridHistoryCash_SUMA_OUT: TcxGridDBColumn;
    cxGridHistoryCashTable_Upr_MDL: TcxGridDBColumn;
    cxGridHistoryCashTable_BUH_USD: TcxGridDBColumn;
    cxGridHistoryCashTable_SC2_NAME: TcxGridDBColumn;
    IBCQueryInvoices: TIBCQuery;
    IBCDataSourceInvoices: TIBCDataSource;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGrid2DBTableView1FACTURANO: TcxGridDBColumn;
    cxGrid2DBTableView1DATA_ELIBERARII: TcxGridDBColumn;
    cxGrid2DBTableView1FLG_CANCELED: TcxGridDBColumn;
    cxGrid2DBTableView1REDIRIJARI: TcxGridDBColumn;
    cxGrid2DBTableView1TIP_FACTURA: TcxGridDBColumn;
    cxGrid2DBTableView1PUNCT_INCARCARE: TcxGridDBColumn;
    cxGrid2DBTableView1PUNCT_DESCARCARE: TcxGridDBColumn;
    cxGrid2DBTableView1Column1: TcxGridDBColumn;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    procedure cxGridHistoryCash_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
      TcxCustomGridRecord; var AText: string);
    procedure cxGridHistoryCashTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
      TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridHistoryCashTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridHistoryCashTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbChangeContractClick(Sender: TObject);
    procedure cxGrid2DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
  private
    { Private declarations }
    fCustomerID: integer;
    fContractID: string;
    procedure DoChangeCustomerContract(ContractID: Integer; Grid: TcxGridTableView);
    procedure SetCustomerID(const Value: integer);
    procedure SetContractID(const Value: string);
  protected
    procedure GetListOfInvoices(var s: string);
    { protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
    function IsFormDataPosted: boolean; override;
  public
    FLG_Buh: Integer;
    FLG_Upr: Integer;
    ORGID: Integer;
    { Public declarations }
    property CustomerID: integer read fCustomerID write SetCustomerID;
    property ContractID: string read fContractID write SetContractID;
  end;

implementation

uses
  SWNBaseFrameUnit, DataModuleAdditions, DataModuleDB, SWNValueStorageUnit, SWNUtils,
  frmCustomerContractsDialog, Vcl.Clipbrd, frmDocumentPreviewUnit;

{$R *.dfm}
{ TfrmCustomerCurrentDebtsNalDlg }

procedure TfrmCustomerCurrentDebtsContractDlg.bbChangeContractClick(Sender: TObject);
var
  dialog: TfrmContractsDlg;
begin
  dialog := TfrmContractsDlg.Create(Self);
  try
    dialog.CT := fCustomerID;
    dialog.SelectMode := True;
    if (dialog.ShowModal = mrOk) then
    begin
      DoChangeCustomerContract(dialog.ContractID, cxGridHistoryCashTable);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerCurrentDebtsContractDlg.cxGrid2DBTableView1KeyDown(Sender: TObject; var Key:
  Word; Shift: TShiftState);
begin
  ProcessCommonKeys(Self, cxGrid2DBTableView1, Key, Shift);
end;

procedure TfrmCustomerCurrentDebtsContractDlg.cxGridHistoryCashTableCustomDrawCell(Sender:
  TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone:
  Boolean);
begin
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
    ACanvas.Font.Color := clBlack;
  end;
end;

procedure TfrmCustomerCurrentDebtsContractDlg.cxGridHistoryCashTableKeyDown(Sender: TObject; var Key:
  Word; Shift: TShiftState);
begin
  if (Key = 67) and (Shift = [ssAlt, ssCtrl]) then
  begin
    ShowCopyGridContent(Self, cxGridHistoryCashTable);
  end;

  // Ctrl+C
  if (Key = 67) and (Shift = [ssCtrl]) then
  begin
    // copy cell content in clipboard
    CopyGridCellTextToClipboard(cxGridHistoryCashTable);
    Key := 0;
  end
end;

procedure TfrmCustomerCurrentDebtsContractDlg.cxGridHistoryCashTableStylesGetContentStyle(Sender:
  TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle:
  TcxStyle);
begin
  if VarIsNumeric(ARecord.Values[cxGridHistoryCash_DOCTYPESIGN.Index]) then
  begin
    if ARecord.Values[cxGridHistoryCash_DOCTYPESIGN.Index] < 0 then
      AStyle := dmAdditions.cxStyle_TextColorRed
    else
      AStyle := dmAdditions.cxStyle_TextColorGreen;
  end;

end;

procedure TfrmCustomerCurrentDebtsContractDlg.cxGridHistoryCash_DATAGetDisplayText(Sender:
  TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridHistoryCash_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridHistoryCash_DATA.Index]);
end;

procedure TfrmCustomerCurrentDebtsContractDlg.DoChangeCustomerContract(ContractID: Integer; Grid:
  TcxGridTableView);
var
  DocID: Variant;
  i: Integer;
  Query: TIBCQuery;
  recindex: Integer;
begin
  Query := TIBCQuery.Create(self);
  Query.AutoCommit := False;
  Query.SQL.Clear;
  Query.SQL.Add('execute procedure sp_change_doc_contractid(:docid, :contractid)');
  Query.Transaction := IBCTrLocalWrite;
  Query.Transaction.Active := True;
  try
    for i := 0 to Grid.Controller.SelectedRecordCount - 1 do
    begin
      recindex := Grid.Controller.SelectedRecords[i].RecordIndex;
      DocID := Grid.DataController.Values[recindex, cxGridHistoryCash_DOCID.Index];
      VarCast(DocID, DocID, varInteger);

      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.ParamByName('CONTRACTID').AsInteger := ContractID;
      Query.Prepare;

      Query.Execute;
    end;
    Query.Transaction.Commit;

    IBCQueryContractsDocuments.Close;
    IBCQueryContractsDocuments.Open;
  finally
    Query.Free;
  end;
end;

procedure TfrmCustomerCurrentDebtsContractDlg.dxBarButton1Click(Sender: TObject);
var
  CurrencyRate: string;
  SavePlace: TBookmark;
begin
  //
  SavePlace := IBCQueryContractsDocuments.GetBookmark;
  try
    CurrencyRate := Dialogs.InputBox('Modifica rata de schimb a documentului', 'Rata USD',
      IBCQueryContractsDocuments.FieldByName('CURRENT_USD_RATE').AsString);
    dmdb.ExecuteQuery('execute procedure sp_update_doc_rate (:docid, :rateusd)', [IBCQueryContractsDocuments.FieldByName
      ('DOCID').AsInteger, StrToFloat(CurrencyRate)]);
    IBCQueryContractsDocuments.Refresh;

    IBCQueryContractsDocuments.GotoBookmark(SavePlace);
  finally
    IBCQueryContractsDocuments.FreeBookmark(SavePlace);
  end;
end;

procedure TfrmCustomerCurrentDebtsContractDlg.dxBarButton2Click(Sender: TObject);
var
  s: string;
begin
  GetListOfInvoices(s);
  clipboard.AsText := s;
end;

procedure TfrmCustomerCurrentDebtsContractDlg.dxBarButton3Click(Sender: TObject);
begin
 var dialog := TfrmDocumentPreviewDlg.Create(self, dmdb.IBCConnection);
  try
    dialog.currentdt := dmdb.CurrentFirma;
    dialog.ShowPreviewDocument(IBCQueryContractsDocuments.FieldByName('docid').AsInteger);
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerCurrentDebtsContractDlg.GetListOfInvoices(var s: string);
var
  DocID: Integer;
  i: Integer;
  Query: TIBCQuery;
  recindex: Integer;
  ListOfInvoices: TStringList;
begin
  s:= '';
  ListOfInvoices := TStringList.Create;
  Query := TIBCQuery.Create(self);
  Query.SQL.Add('select tdb_invoices.facturano from tdb_invoices where docid = :docid');
  Query.Prepare;
  try
    for i := 0 to cxGridHistoryCashTable.Controller.SelectedRecordCount - 1 do
    begin
      recindex := cxGridHistoryCashTable.Controller.SelectedRecords[i].RecordIndex;
      DocID := cxGridHistoryCashTable.DataController.Values[recindex, cxGridHistoryCash_DOCID.Index];

      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.Open;

      ListofInvoices.Add(query.FieldByName('FACTURANO').AsString);

      Query.Close;
    end;
    s := ListOfInvoices.CommaText;
  finally
    Query.Free;
    ListOfInvoices.Free;
  end;

end;

function TfrmCustomerCurrentDebtsContractDlg.IsFormDataPosted: boolean;
begin
   IBCQueryInvoices.Close;
   Result := True;
end;

procedure TfrmCustomerCurrentDebtsContractDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.ReadFormPos(Self);
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridHistoryCashTable);
end;

procedure TfrmCustomerCurrentDebtsContractDlg.Prepare;
begin
  IBCQueryContractsDocuments.ParamByName('CustomerID').AsInteger := fCustomerID;
  IBCQueryContractsDocuments.ParamByName('CONTRACTID').AsString := ContractID;
  IBCQueryContractsDocuments.ParamByName('FLG_UPR').AsInteger := FLG_UPR;
  IBCQueryContractsDocuments.ParamByName('FLG_Buh').AsInteger := FLG_Buh;
  IBCQueryContractsDocuments.ParamByName('ORGID').AsInteger := ORGID;

  IBCQueryContractsDocuments.Active := True;
  dtDialogTitle.Text := Format('[%d] - %s', [fCustomerID, dmdb.GetCustomerDisplayName(fCustomerID)]);
  cxGridHistoryCash_DOCTYPE_NAME.Focused := True;
  IBCQueryInvoices.Open;

//  if FLG_Upr=1 then
//  begin
//     cxGridHistoryCash_SUMA.DataBinding.FieldName := 'SUMA_UPR';
//     cxGridHistoryCash_SUMA_BALANCE.DataBinding.FieldName := 'SUMA_UPR_BALANCE';
//     cxGridHistoryCash_SUMADT.DataBinding.FieldName := 'SUMA_UPR_DT';
//     cxGridHistoryCash_SUMACT.DataBinding.FieldName := 'SUMA_UPR_CT';
//
//  end
//  else
//  begin
//     cxGridHistoryCash_SUMA.DataBinding.FieldName := 'SUMA_BUH';
//     cxGridHistoryCash_SUMA_BALANCE.DataBinding.FieldName := 'SUMA_BUH_BALANCE';
//     cxGridHistoryCash_SUMADT.DataBinding.FieldName := 'SUMA_BUH_DT';
//     cxGridHistoryCash_SUMACT.DataBinding.FieldName := 'SUMA_BUH_CT';
//  end;
end;

procedure TfrmCustomerCurrentDebtsContractDlg.SaveStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridHistoryCashTable);
end;

procedure TfrmCustomerCurrentDebtsContractDlg.SetContractID(const Value: string);
begin
  fContractID := Value;
end;

procedure TfrmCustomerCurrentDebtsContractDlg.SetCustomerID(const Value: integer);
begin
  fCustomerID := Value;
end;

end.

