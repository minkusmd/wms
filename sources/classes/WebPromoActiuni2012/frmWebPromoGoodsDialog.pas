unit frmWebPromoGoodsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, SWNBaseUnit, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, IBC,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxImage, cxDBEdit, cxTextEdit, Vcl.StdCtrls, cxCheckBox,
  cxPCdxBarPopupMenu, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, dxBar, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC, DBAccess, MemDS,
  cxImageComboBox, cxNavigator, cxMaskEdit, cxDropDownEdit, dxColorEdit, dxDBColorEdit, dxGalleryControl, dxColorGallery,
  dxDBColorGallery, dxCore, cxLabel, cxDBLabel, dxBarBuiltInMenu,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, SWNBaseFrameUnit, cxCalc, cxButtonEdit, dxDateRanges,
  dxCoreClasses, dxHashUtils, dxSpreadSheetCore, dxSpreadSheetCoreFormulas, dxSpreadSheetCoreHistory,
  dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs, dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetClasses, dxSpreadSheetContainers, dxSpreadSheetFormulas,
  dxSpreadSheetHyperlinks, dxSpreadSheetFunctions, dxSpreadSheetStyles, dxSpreadSheetGraphics, dxSpreadSheetPrinting,
  dxSpreadSheetTypes, dxSpreadSheetUtils, dxSpreadSheetFormattedTextUtils, dxSpreadSheet, dxScrollbarAnnotations,
  cxGridBandedTableView, cxGridDBBandedTableView, cxDBLookupComboBox, System.ImageList, Vcl.ImgList, cxImageList,
  cxCurrencyEdit, Vcl.Menus, cxButtons, cxGridExportLink, cxBarEditItem, cxRadioGroup, cxLookupEdit, cxDBLookupEdit,
  cxPropertiesStore, dxCoreGraphics, dxUIAClasses;

type
  TOnBurstAddGoods = procedure(const GoodsID: Integer; const GoodsTitle: string; var Added: Boolean;
    var Count: Integer) of object;


type
  TfrmWebPromoGoodsDlg = class(TSWNBaseFormClass)
    dtDialogTitle: TDialogTitle;
    dxBarManager1: TdxBarManager;
    pcPages: TcxPageControl;
    tbsGoods: TcxTabSheet;
    cxGrid: TcxGrid;
    cxGridLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbAdd: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    bbDeleteAll: TdxBarButton;
    bbEditGoodsPrices: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    cxTabSheet1: TcxTabSheet;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    dxSpreadSheet1: TdxSpreadSheet;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarButton10: TdxBarButton;
    cxGridDBBandedTableView1: TcxGridDBBandedTableView;
    cxGridDBBandedTableView1_GOODSID: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_GOODS_NAME: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_PRICE4: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_OLD_PRICE4: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_DISCOUNT_AMOUNT: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_DISCOUNT_TYPEID: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_DISCOUNT_PERCENT: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_DISCOUNT_VALUE_MDL: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_FLG_IN_PRICE: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_CURRENCYID: TcxGridDBBandedColumn;
    IBCQueryCurrency: TIBCQuery;
    IBCDataSourceCurrency: TIBCDataSource;
    cxImageList1: TcxImageList;
    bbUpdatePrices: TdxBarButton;
    cxGridDBBandedTableView1_CURRENT_PRICE4: TcxGridDBBandedColumn;
    dxBarButton1: TdxBarButton;
    dxBarButton12: TdxBarButton;
    cxGridDBBandedTableView1_CASHBACK: TcxGridDBBandedColumn;
    dxBarButton13: TdxBarButton;
    bbModify: TdxBarButton;
    bbValidate: TdxBarButton;
    bbClearSheet: TdxBarButton;
    bbCreateRevaluation: TdxBarButton;
    cxGridDBBandedTableView1Column1: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_SupplierID: TcxGridDBBandedColumn;
    Panel1: TPanel;
    rbSupplierGoodsCode: TcxRadioButton;
    rbInternalGoodsID: TcxRadioButton;
    cxLabel1: TcxLabel;
    beSupplier: TcxButtonEdit;
    cxLabel2: TcxLabel;
    cbCurrPrice: TcxCheckBox;
    lcbNewCurrency: TcxLookupComboBox;
    cxPropertiesStore1: TcxPropertiesStore;
    cxGridDBBandedTableView1_LabelRO: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_LabelRU: TcxGridDBBandedColumn;
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    cxButton1: TcxButton;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    lcbOldCurrency: TcxLookupComboBox;
    bbSaveToExcel: TdxBarButton;
    bbOpenFile: TdxBarButton;
    cxGridDBBandedTableView1_CPF: TcxGridDBBandedColumn;
    bbSetHint: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bbAddToWebMainPage: TdxBarButton;
    IBCTrLocalUpdate: TIBCTransaction;
    bbImportFromFirstPage: TdxBarButton;
    Label1: TLabel;
    cxButton2: TcxButton;
    dxBarButton11: TdxBarButton;
    bbAddBurstGoods: TdxBarButton;
    cxGridDBBandedTableView1_PRICE7: TcxGridDBBandedColumn;
    cxGridDBBandedTableView1_CURRENCY7ID: TcxGridDBBandedColumn;
    meErrors: TMemo;
    bbJsonImport: TdxBarButton;
    procedure bbAddClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbAddFolderClick(Sender: TObject);
    procedure bbDeleteAllClick(Sender: TObject);
    procedure bbEditGoodsPricesClick(Sender: TObject);
    procedure cxGridDBBandedTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure dxBarButton6Click(Sender: TObject);
    procedure dxBarButton7Click(Sender: TObject);
    procedure dxBarButton8Click(Sender: TObject);
    procedure dxBarButton9Click(Sender: TObject);
    procedure dxBarButton10Click(Sender: TObject);
    procedure cxGridDBBandedTableView1_DISCOUNT_PERCENTPropertiesEditValueChanged(Sender: TObject);
    procedure cxGridDBBandedTableView1_DISCOUNT_AMOUNTPropertiesEditValueChanged(Sender: TObject);
    procedure cgColorGalleryGetCustomColorSet(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
      TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton13Click(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbValidateClick(Sender: TObject);
    procedure bbClearSheetClick(Sender: TObject);
    procedure dxBarButton12Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxGridDBBandedTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbCreateRevaluationClick(Sender: TObject);
    procedure beSupplierPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure bbSaveToExcelClick(Sender: TObject);
    procedure bbOpenFileClick(Sender: TObject);
    procedure bbSetHintClick(Sender: TObject);
    procedure bbAddToWebMainPageClick(Sender: TObject);
    procedure bbUpdatePricesClick(Sender: TObject);
    procedure bbImportFromFirstPageClick(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure bbAddBurstGoodsClick(Sender: TObject);
    procedure bbJsonImportClick(Sender: TObject);
  private    { Private declarations }
    FPromoActionID: Integer;
    FGoodsReadOnly: boolean;
    FOnBurstAddGoods: TOnBurstAddGoods;
    FUpdateTransaction: TIBCTransaction;
    procedure GoodsSelectionChanged;
    procedure SetPromoActionID(const Value: Integer);
    procedure SetUpdateTransaction(const Value: TIBCTransaction);
    function CheckValues: Boolean;
    procedure ShowAddGoodsDialog;
    procedure DeleteGoods;
    function DeleteAllGoodsDB: Boolean;
    function WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
    procedure WhenBurstAddGoods(const GoodsID: Integer; const GoodsTitle: string; var Added: Boolean; var Count: Integer);
    function AddGoods(const SupplierID, GoodsID: Integer; GoodsTitle: string; GoodsCode: string; Price: Currency;
      CurrencyID: Integer): Boolean;
    function EditGoods(const SupplierID: Integer; GoodsCode: string; const GoodsID: Integer; GoodsTitle: string; Price:
      Currency; CurrencyID: Integer): Boolean;
    procedure AddGoodsFolder(const GoodsID: Integer);
    procedure DoImportDataCPF;
    procedure ValidateData(SupplierMode: Boolean);
    procedure PrepareSpreadSheet;
    procedure PretCurentInPretNou;
    procedure SetOnBurstAddGoods(const Value: TOnBurstAddGoods);
    procedure ShowAddGoodsFolderDialog;
    procedure ImportProductsToSpreadSheet(const AFileName: string;
      ASpreadSheet: TdxSpreadSheet);
  protected
    procedure DoCreateReevaluare;
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
  public    { Public declarations }
    procedure DoImportInternalCodes;
    function GetSupplierIDByGoodsID(GoodsID: Integer): Integer;
    function GoodsExists(const GoodsID: Integer): Boolean;
    procedure ShowModifyEditorDlg;
    procedure WhenAddGoods(const GroupGoodsID: Integer; var Res: Boolean);
    property PromoActionID: Integer read FPromoActionID write SetPromoActionID;
    property GoodsReadOnly: boolean read FGoodsReadOnly write FGoodsReadOnly;
    property OnBurstAddGoods: TOnBurstAddGoods read FOnBurstAddGoods write
        SetOnBurstAddGoods;
    property UpdateTransaction: TIBCTransaction read FUpdateTransaction write SetUpdateTransaction;
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, DataModuleDB, SWNConst, SWNUtils, frmGoods,
  SWNValueStorageUnit, SWNDBErrors, Vcl.Clipbrd, frmWebGoodsPromoSortingDialog,
  frmBonusGoodsImportGoodsDialog, SWNGoodsUtils, frmCustomersDlg,
  frmWebSelectGoodsUnit, frmWebGoodsSetHintUnit, frmWebGoodsGroupsUnit,
  frmSelectGoodsFromFirstPageUnit, frmWebSelectGoodsSupplierUnit, System.JSON, System.IOUtils;

function TfrmWebPromoGoodsDlg.EditGoods(const SupplierID: Integer; GoodsCode: string; const GoodsID: Integer; GoodsTitle:
  string; Price: Currency; CurrencyID: Integer): Boolean;
begin

  IBCQueryGoods.Edit;
  try
    with IBCQueryGoods do
    begin
      FieldByName('PROMOACTIONID').AsInteger := FPromoActionID;
      FieldByName('GOODSID').AsInteger := GoodsID;
      FieldByName('SUPPLIERID').AsInteger := SupplierID;
      FieldByName('GOODS_CODE').AsString := GoodsCode;
      FieldByName('PRICE4').AsCurrency := Price;
      FieldByName('CURRENCYID').AsInteger := CurrencyID;
      FieldByName('FLG_DISCOUNT_TYPE').AsInteger := 0;
      FieldByName('FLG_SHOW_DISCOUNT_AS_AMOUNT').AsInteger := 0;
      Post;
    end;
    Result := True;
  except
  begin
    Result := False;
    if IBCQueryGoods.State in dsEditModes then
      IBCQueryGoods.Cancel;
    raise;
  end;
  end;
end;

function TfrmWebPromoGoodsDlg.AddGoods(const SupplierID, GoodsID: Integer; GoodsTitle: string; GoodsCode: string; Price:
  Currency; CurrencyID: Integer): Boolean;
begin
  Result := False;
  try
    with IBCQueryGoods do
    begin
      Append;
      FieldByName('PROMOACTIONID').AsInteger := FPromoActionID;
      FieldByName('GOODSID').AsInteger := GoodsID;
      FieldByName('GOODS_CODE').AsString := GoodsCode;
      FieldByName('SUPPLIERID').AsInteger := SupplierID;
      FieldByName('PRICE4').AsCurrency := Price;
      FieldByName('OLD_PRICE4').AsCurrency := Price;
      FieldByName('CURRENCYID').AsInteger := CurrencyID;
      FieldByName('FLG_DISCOUNT_TYPE').AsInteger := 0;
      FieldByName('FLG_SHOW_DISCOUNT_AS_AMOUNT').AsInteger := 0;
      Post;
    end;
    Result := True;
  except
    if IBCQueryGoods.State in dsEditModes then
      IBCQueryGoods.Cancel;
    raise;
  end;
end;

procedure TfrmWebPromoGoodsDlg.AddGoodsFolder(const GoodsID: Integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Transaction := IBCQueryGoods.UpdateTransaction;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_PROMOACTII_GOODS_ADDFOLDER(:ID1,:ID2)';
    Query.ParamByName('ID1').AsInteger := FPromoActionID;
    Query.ParamByName('ID2').AsInteger := GoodsID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.bbAddClick(Sender: TObject);
begin
  ShowAddGoodsDialog;
end;

procedure TfrmWebPromoGoodsDlg.bbAddFolderClick(Sender: TObject);
begin
  ShowAddGoodsFolderDialog;
end;

procedure TfrmWebPromoGoodsDlg.bbAddToWebMainPageClick(Sender: TObject);
var
  dialog: TfrmWebGoodsGroupsDlg;
begin
  dialog := TfrmWebGoodsGroupsDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.OnAddGoods := WhenAddGoods;
    dialog.SelectMode := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.bbClearSheetClick(Sender: TObject);
begin
  PrepareSpreadSheet;
end;

procedure TfrmWebPromoGoodsDlg.bbDeleteAllClick(Sender: TObject);
begin
  if ShowAskDialog('Produse din actiune', 'Stergeti toate inregistrarile ?') = mrYes then
  begin
    if DeleteAllGoodsDB then
      IBCQueryGoods.Refresh;
  end;
end;

procedure TfrmWebPromoGoodsDlg.bbDeleteClick(Sender: TObject);
begin
  DeleteGoods;
end;

function TfrmWebPromoGoodsDlg.CheckValues: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebPromoGoodsDlg.cgColorGalleryGetCustomColorSet(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridDBBandedTableView1_CURRENT_PRICE4.Index] <> ARecord.Values[cxGridDBBandedTableView1_PRICE4.Index] then
  begin
    AStyle := dmAdditions.cxStyle_TextColorRed;
  end;
end;

procedure TfrmWebPromoGoodsDlg.cxGridDBBandedTableView1_DISCOUNT_AMOUNTPropertiesEditValueChanged(Sender: TObject);
var
  Edit: TcxCustomEdit;
  newValue: Variant;
begin
  if Assigned(Sender) then
  begin
    Edit := Sender as TcxCustomEdit;
    newValue := Edit.EditingValue;
    IBCQueryGoods.Edit;
    IBCQueryGoods.FieldByName('OLD_PRICE4').AsInteger := (cxGridDBBandedTableView1_PRICE4.EditValue + newValue);
    cxGridDBBandedTableView1_DISCOUNT_AMOUNT.EditValue := newValue;
  end;
end;

procedure TfrmWebPromoGoodsDlg.cxGridDBBandedTableView1_DISCOUNT_PERCENTPropertiesEditValueChanged(Sender: TObject);
var
  Edit: TcxCustomEdit;
  newValue: Variant;
begin
  if Assigned(Sender) then
  begin
    Edit := Sender as TcxCustomEdit;
    newValue := Edit.EditingValue;
    IBCQueryGoods.Edit;
    IBCQueryGoods.FieldByName('OLD_PRICE4').AsInteger := cxGridDBBandedTableView1_PRICE4.EditValue * ((newValue / 100) + 1);
    cxGridDBBandedTableView1_DISCOUNT_PERCENT.EditValue := Round(newValue);
  end;
end;

function TfrmWebPromoGoodsDlg.DeleteAllGoodsDB: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := UpdateTransaction;
    Query.AutoCommit := False;
    Query.SQL.Text := 'DELETE FROM TWEB_PA_GOODS WHERE PROMOACTIONID=:ID';
    Query.ParamByName('ID').AsInteger := FPromoActionID;
    try
      Query.Execute;
      Result := True;
    except
      on E: Exception do
      begin
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.DeleteGoods;
begin
  if ShowAskDialog('Produse din actiune', 'Stergeti inregistrarile selectate?') = mrYes then
  begin
      cxGridDBBandedTableView1.DataController.DeleteSelection;
  end;
end;

procedure TfrmWebPromoGoodsDlg.dxBarButton10Click(Sender: TObject);
begin
  IBCQueryGoods.DisableControls;
  IBCQueryGoods.First;
  while not IBCQueryGoods.Eof do
  begin
    IBCQueryGoods.Edit;
    IBCQueryGoods.FieldByName('DISCOUNT_AMOUNT').AsFloat := Round(IBCQueryGoods.FieldByName('DISCOUNT_AMOUNT').AsFloat);
    IBCQueryGoods.FieldByName('DISCOUNT_VALUE').AsFloat := IBCQueryGoods.FieldByName('DISCOUNT_AMOUNT').AsFloat;
    IBCQueryGoods.Post;
    IBCQueryGoods.Next;
  end;
  IBCQueryGoods.EnableControls;
end;

procedure TfrmWebPromoGoodsDlg.bbUpdatePricesClick(Sender: TObject);
var
  b: TBookmark;
begin
  inherited;
  IBCQueryGoods.DisableControls;
  b := IBCQueryGoods.GetBookmark;
  IBCQueryGoods.First;
  while not IBCQueryGoods.Eof do
  begin
    IBCQueryGoods.Edit;
    IBCQueryGoods.FieldByName('PRICE4').AsFloat := IBCQueryGoods.FieldByName('CURRENT_PRICE4').AsFloat;
    IBCQueryGoods.FieldByName('CurrencyID').AsInteger := 498;
    IBCQueryGoods.Post;
    IBCQueryGoods.Next;
  end;
  IBCQueryGoods.GotoBookmark(b);

  IBCQueryGoods.EnableControls;
end;

procedure TfrmWebPromoGoodsDlg.dxBarButton1Click(Sender: TObject);
var
  DiscountValue: string;
begin
  if (InputQuery('Reducere in promotie', 'Valorea reducerii', DiscountValue)) then
  begin
    if not IBCQueryGoods.UpdateTransaction.Active then
      IBCQueryGoods.UpdateTransaction.StartTransaction;

    IBCQueryGoods.DisableControls;
    try
      IBCQueryGoods.First;
      while not IBCQueryGoods.Eof do
      begin
        IBCQueryGoods.Edit;
        IBCQueryGoods.FieldByName('OLD_PRICE4').AsInteger := cxGridDBBandedTableView1_PRICE4.EditValue * ((StrToInt(DiscountValue)
          / 100) + 1);
        cxGridDBBandedTableView1_DISCOUNT_PERCENT.EditValue := Round(StrToInt(DiscountValue));
        IBCQueryGoods.Post;
        IBCQueryGoods.Next;
      end;

    finally
      IBCQueryGoods.EnableControls;
    end;
  end;
end;

procedure TfrmWebPromoGoodsDlg.dxBarButton2Click(Sender: TObject);
begin
  dmDB.ExecuteQuery('EXECUTE PROCEDURE UPDATE_PRICE_PA_GOODS(:PROMOACTIONID)', [PromoActionID]);
  IBCQueryGoods.Refresh;
end;

procedure TfrmWebPromoGoodsDlg.dxBarButton3Click(Sender: TObject);
var
  dialog: TfrmWebGoodsPromoSortingDlg;
begin
  dialog := TfrmWebGoodsPromoSortingDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.PromoActionID := IBCQueryGoods.FieldByName('PROMOACTIONID').AsInteger;
    if dialog.ShowModal = mrOk then
      IBCQueryGoods.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.dxBarButton4Click(Sender: TObject);
begin
  pcPages.ActivePage := cxTabSheet1;
end;

procedure TfrmWebPromoGoodsDlg.dxBarButton6Click(Sender: TObject);
begin
  if rbSupplierGoodsCode.Checked then
    DoImportDataCPF
  else
    DoImportInternalCodes;

//  ShowMessage('Produsele au fost importate!');
end;

procedure TfrmWebPromoGoodsDlg.dxBarButton7Click(Sender: TObject);
begin
  IBCQueryGoods.DisableControls;
  IBCQueryGoods.First;
  while not IBCQueryGoods.Eof do
  begin
    IBCQueryGoods.Edit;
    IBCQueryGoods.FieldByName('DISCOUNT_TYPEID').AsInteger := (1 - IBCQueryGoods.FieldByName('DISCOUNT_TYPEID').AsInteger);
    IBCQueryGoods.Post;
    IBCQueryGoods.Next;
  end;
  IBCQueryGoods.EnableControls;

end;

procedure TfrmWebPromoGoodsDlg.dxBarButton8Click(Sender: TObject);
begin
  IBCQueryGoods.DisableControls;
  IBCQueryGoods.First;
  while not IBCQueryGoods.Eof do
  begin
    IBCQueryGoods.Edit;
    IBCQueryGoods.FieldByName('FLG_SHOW_DISCOUNT_AS_AMOUNT').AsInteger := (1 - IBCQueryGoods.FieldByName('FLG_SHOW_DISCOUNT_AS_AMOUNT').AsInteger);
    IBCQueryGoods.Post;
    IBCQueryGoods.Next;
  end;
  IBCQueryGoods.EnableControls;
end;

procedure TfrmWebPromoGoodsDlg.dxBarButton9Click(Sender: TObject);
begin
  IBCQueryGoods.DisableControls;
  IBCQueryGoods.First;
  while not IBCQueryGoods.Eof do
  begin
    IBCQueryGoods.Edit;
    IBCQueryGoods.FieldByName('PRICE4').AsFloat := Round(IBCQueryGoods.FieldByName('PRICE4').AsFloat);
    IBCQueryGoods.FieldByName('DISCOUNT_AMOUNT').AsFloat := Round(IBCQueryGoods.FieldByName('DISCOUNT_AMOUNT').AsFloat);
    IBCQueryGoods.Post;
    IBCQueryGoods.Next;
  end;
  IBCQueryGoods.EnableControls;
end;

procedure TfrmWebPromoGoodsDlg.bbEditGoodsPricesClick(Sender: TObject);
begin
  IBCQueryGoods.Edit;
end;

procedure TfrmWebPromoGoodsDlg.bbImportFromFirstPageClick(Sender: TObject);
var
  d: TfrmSelectGoodsFromFirstPageDlg;
  q: TIBCQuery;
begin
  d := TfrmSelectGoodsFromFirstPageDlg.Create(Self, dmDB.ibcconnection);
  q := TIBCQuery.Create(nil);
  try
    if d.showmodal = mrOk then
    begin
      q.Transaction := IBCTrLocalUpdate;
      if not IBCTrLocalUpdate.Active then
        IBCTrLocalUpdate.StartTransaction;
      q.SQL.Text := 'EXECUTE PROCEDURE IMPORTGOODSFROM1PAGE(:PROMOACTIONID, :GGID)';
      q.ParamByName('PROMOACTIONID').AsInteger := PromoActionID;
      q.ParamByName('GGID').AsInteger := d.GoodsGroupID;
      try
        q.Execute;
        IBCTrLocalUpdate.Commit;
        IBCQueryGoods.Refresh;
      except
        raise;
      end;
    end;
  finally
    d.Free;
    q.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.bbJsonImportClick(Sender: TObject);
var
  dialog: TOpenDialog;
begin
  dialog := TOpenDialog.Create(Self);
  dialog.DefaultExt := 'xlsx';
  try
    if dialog.Execute then
    begin
       ImportProductsToSpreadSheet(dialog.filename, dxSpreadSheet1);
    end;
  finally
    dialog.free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.ImportProductsToSpreadSheet(const AFileName: string;
  ASpreadSheet: TdxSpreadSheet);
var
  JsonText: string;
  JsonObj: TJSONObject;
  Products: TJSONArray;
  Item: TJSONObject;
  Sheet: TdxSpreadSheetTableView;
  I: Integer;
  JValue: TJSONValue;
begin
  JsonText := TFile.ReadAllText(AFileName, TEncoding.UTF8);
  JsonObj := TJSONObject.ParseJSONValue(JsonText) as TJSONObject;
  try
    Products := JsonObj.GetValue<TJSONArray>('products');

    // Activăm prima foaie sau creăm una nouă
    if ASpreadSheet.SheetCount = 0 then
      ASpreadSheet.AddSheet('Products');
    Sheet := ASpreadSheet.ActiveSheetAsTable;

    Sheet.BeginUpdate;
    try

      // Date
      for I := 0 to Products.Count - 1 do
      begin
        Item := Products.Items[I] as TJSONObject;

        Sheet.CreateCell(I + 1, 1).AsString := Item.GetValue<string>('article');

        JValue := Item.GetValue('new_price');
        if (JValue <> nil) and not (JValue is TJSONNull) then
          Sheet.CreateCell(I + 1, 2).AsFloat := JValue.AsType<Double> - 10;

        JValue := Item.GetValue('old_price');
        if (JValue <> nil) and not (JValue is TJSONNull) then
          Sheet.CreateCell(I + 1, 3).AsFloat := JValue.AsType<Double>;
      end;
    finally
      Sheet.EndUpdate;
    end;
  finally
    JsonObj.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.bbOpenFileClick(Sender: TObject);
var
  dialog: TOpenDialog;
begin
  dialog := TOpenDialog.Create(Self);
  dialog.DefaultExt := 'xlsx';
  try
    if dialog.Execute then
    begin
      dxSpreadSheet1.LoadFromFile(dialog.FileName);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.bbSaveToExcelClick(Sender: TObject);
var
  dialog: TSaveDialog;
begin
  dialog := TSaveDialog.Create(Self);
  dialog.DefaultExt := 'xlsx';
  try
    if dialog.Execute then
    begin
      dxSpreadSheet1.SaveToFile(dialog.FileName);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.bbSetHintClick(Sender: TObject);
var
  aRecIndex: Integer;
  GoodsCode: string;
  I: Integer;
  rowcount: Integer;
  SupplierID: Integer;
  d: TfrmWebGoodsSetHintDlg;
begin
  d := TfrmWebGoodsSetHintDlg.Create(Self, dmDB.IBCConnection);
  try
    d.HintRo := IBCQueryGoods.FieldByName('Label_ro').AsString;
    d.HintRoUrl := IBCQueryGoods.FieldByName('Label_ro_url').AsString;
    d.HintRu := IBCQueryGoods.FieldByName('Label_ru').AsString;
    d.HintRuUrl := IBCQueryGoods.FieldByName('Label_ru_url').AsString;

    if (d.ShowModal = mrOk) then
    begin
      var Query: TIBCQuery := TIBCQuery.Create(nil);
      Query.AutoCommit := False;
      Query.Transaction := IBCQueryGoods.UpdateTransaction;
      if not (Query.Transaction.Active) then
        Query.Transaction.StartTransaction;
      try
        Query.SQL.Text :=
        '''
          Update tweb_pa_goods
            set
               label_ro = :label_ro,
               label_ru = :label_ru,
               label_ro_url = :label_ro_url,
               label_ru_url = :label_ru_url
          where
             goods_code=:goods_code and
             supplierid = :supplierid and
             promoactionid = :promoactionid
        ''';

        for I := 0 to cxGridDBBandedTableView1.Controller.SelectedRecordCount - 1 do
        begin
          aRecIndex := cxGridDBBandedTableView1.ViewData.Records[cxGridDBBandedTableView1.Controller.SelectedRecords[I].Index].RecordIndex;
          cxGridDBBandedTableView1.DataController.Values[aRecIndex, cxGridDBBandedTableView1_LabelRO.Index] := d.HintRo;
          cxGridDBBandedTableView1.DataController.Values[aRecIndex, cxGridDBBandedTableView1_LabelRU.Index] := d.HintRu;

          Query.ParamByName('goods_code').asString := cxGridDBBandedTableView1.DataController.Values[aRecIndex,
            cxGridDBBandedTableView1_CPF.Index];
          Query.ParamByName('supplierid').asinteger := cxGridDBBandedTableView1.DataController.Values[aRecIndex,
            cxGridDBBandedTableView1_SupplierID.Index];
          Query.ParamByName('promoactionid').AsInteger := PromoActionID;
          Query.ParamByName('label_ro').asstring := d.HintRo;
          Query.ParamByName('label_ru').asstring := d.HintRu;
          Query.ParamByName('label_ro_url').asstring := d.HintRoUrl;
          Query.ParamByName('label_ru_url').asstring := d.HintRuUrl;
          try
            Query.Execute;
          except
            on E: Exception do
              raise;
          end;
        end;
        IBCQueryGoods.Transaction.Commit;
      finally
        Query.Free;
      end;
    end;
//    IBCQueryGoods.Refresh;
  finally
    d.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.bbValidateClick(Sender: TObject);
begin
  ValidateData(rbSupplierGoodsCode.Checked);
  ShowMessage('Finisat validarea!');
end;

procedure TfrmWebPromoGoodsDlg.beSupplierPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(-1) then
    begin
      beSupplier.Tag := dialog.CustomerID;
      beSupplier.EditValue := dialog.CustomerTitle;
    end
    else
    begin
      beSupplier.Tag := -1;
      beSupplier.EditValue := '<Selecteaza furnizorul>';
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.cxButton1Click(Sender: TObject);
//var
//  dialog: TSaveDialog;
begin
//  dialog := TSaveDialog.Create(Self);
//  try
//    dialog.DefaultExt := 'xlsx';
//    if dialog.Execute then
//    begin
//      ExportGridToXLSX(dialog.FileName, cxGrid);
//    end;
//  finally
//    dialog.Free;
//  end;
end;

procedure TfrmWebPromoGoodsDlg.cxButton2Click(Sender: TObject);
begin
  inherited;
  PretCurentInPretNou;
end;

procedure TfrmWebPromoGoodsDlg.cxGridDBBandedTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

procedure TfrmWebPromoGoodsDlg.cxGridDBBandedTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeysBandedTableView(Self, cxGridDBBandedTableView1, Key, Shift);
end;

procedure TfrmWebPromoGoodsDlg.DoCreateReevaluare;
var
  q: TIBCQuery;
begin
  q := TIBCQuery.Create(Self);
  try
    q.SQL.Text := 'EXECUTE PROCEDURE GET_SUPPLIERS_REEVALUARE(:PROMOACTIONID)';
    q.Transaction := IBCQueryGoods.UpdateTransaction;
    q.ParamByName('PROMOACTIONID').AsInteger := FPromoActionID;
    q.ExecSQL;
  finally
    q.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.DoImportDataCPF;
var
  Sheet: TdxSpreadSheetTableView;
  cell: TdxSpreadSheetCell;
  q: TIBCQuery;

  GoodsID, goods_code: string;
  i: Integer;
  Price, OldPrice, Price7: Double;

  Price1, Price2, Price3, Price4, Price5: Double;
  CurrencyID, OldCurrencyID, Currency7ID: Integer;
  SupplierID: Integer;
  RecordCnt: integer;
begin
  q := TIBCQuery.Create(Self);
  meErrors.Lines.Clear;
  Sheet := dxSpreadSheet1.ActiveSheetAsTable;

  RecordCnt := 0;
  try
    for i := 1 to Sheet.Rows.LastIndex do
    begin
      if beSupplier.Tag <= 0 then
      begin // get supplier code
        cell := Sheet.Cells[i, 0];

        if Assigned(cell) then
        begin
          SupplierID := StrToIntDef(cell.DisplayText, -1);
          // daca SupplierID este -1 atunci gasim pentru acest cod SupplierID
//          GetSupplierID(
        end;
      end
      else
        SupplierID := beSupplier.Tag;

      if rbInternalGoodsID.Checked then
      begin
        cell := Sheet.Cells[i, 1];
        if Assigned(cell) then
          GoodsID := cell.DisplayText;

        q.SQL.Text :=
          'select first 1 goods_code, customerid from ts_goods_foreign where goodsid = :goodsid and get_flg_value(flags, 3) = 1';
        q.ParamByName('goodsid').AsString := GoodsID;
        q.Open;
        goods_code := q.FieldByName('goods_code').AsString;
        SupplierID := q.FieldByName('Customerid').AsInteger;
      end
      else
      begin
        cell := Sheet.Cells[i, 1];
        if Assigned(cell) then
          goods_code := cell.DisplayText;

        q.close;
        q.SQL.Text := 'select goodsid from ts_goods_foreign where goods_code=:goods_code and customerid = :supplierid';
        q.ParamByName('goods_code').AsString := goods_code;
        q.ParamByName('supplierid').AsInteger := SupplierID;
        q.Open;
        if q.RecordCount = 0 then
          Continue;

        GoodsID := q.FieldByName('GOODSID').AsString;

      end;

      // pret vechi
      if cbCurrPrice.Checked then
      begin  //
        q.Close;
        q.SQL.Text :=
          'select convert_amount(price_MDL, 498, :OldCurrencyID) price from get_goods_price(:goodsid, 1, :OldCurrencyID)';
        q.ParamByName('GOODSID').AsInteger := GoodsID.ToInteger();
//                q.ParamByName('GoodsCurrencyID').AsInteger := CurrencyID;
        q.ParamByName('OldCurrencyID').AsInteger := lcbOldCurrency.EditValue;
        q.Open;

        OldPrice := q.FieldByName('PRICE').AsInteger;
        OldCurrencyID := lcbOldCurrency.EditValue;
      end
      else
      begin
        cell := Sheet.Cells[i, 3];
        if Assigned(cell) then
          OldPrice := StrToFloatDef(Trim(cell.AsString), 0);
      end;

      // pret nou
      cell := Sheet.Cells[i, 2];
      if Assigned(cell) then
        Price := StrToFloatDef(Trim(cell.AsString), 0)
      else
      begin
        Price := OldPrice;
        CurrencyID := OldCurrencyID;
      end;

      // valuta
      cell := Sheet.Cells[i, 4];
      if Assigned(cell) then
        CurrencyID := StrToIntDef(Trim(cell.AsString), 840)
      else
      begin
        raise Exception.Create('Nu este indicata valuta pentru actiune!');
      end;

      // Pret 7
      cell := Sheet.Cells[i, 5];
      if Assigned(cell) then
        Price7 := StrToFloatDef(Trim(cell.AsString), 0);

      // valuta 7
      cell := Sheet.Cells[i, 6];
      if Assigned(cell) then
        Currency7ID := StrToIntDef(Trim(cell.AsString), 840);


      IBCQueryGoods.Append;
      IBCQueryGoods.FieldByName('GOODS_CODE').AsString := goods_code;
      IBCQueryGoods.FieldByName('SUPPLIERID').AsInteger := SupplierID;
      IBCQueryGoods.FieldByName('ORDERNO').AsInteger := i;
      IBCQueryGoods.FieldByName('PROMOACTIONID').AsInteger := FPromoActionID;
      IBCQueryGoods.FieldByName('FLG_DISCOUNT_TYPE').AsInteger := 1;
      IBCQueryGoods.FieldByName('FLG_SHOW_DISCOUNT_AS_AMOUNT').AsInteger := 1;
      IBCQueryGoods.FieldByName('GOODSID').AsInteger := StrToIntDef(GoodsID, -1);
      IBCQueryGoods.FieldByName('OLD_PRICE4').AsCurrency := OldPrice;
      IBCQueryGoods.FieldByName('old_CurrencyID').AsInteger := OldCurrencyID;

      IBCQueryGoods.FieldByName('Price7').AsCurrency := Price7;
      IBCQueryGoods.FieldByName('Currency7ID').AsInteger := Currency7ID;


      q.Close;
      q.SQL.Text := 'select * from WEB_GET_GOODS_MIN_INFO (:goodsid)';
      q.ParamByName('GOODSID').AsString := GoodsID;
      q.Open;

//            Price4 := q.FieldByName('PRICE4_LEI').AsCurrency;
//            Price5 := q.FieldByName('PRICE5_LEI').AsCurrency;
      IBCQueryGoods.FieldByName('PRICE4').AsCurrency := Price;
      IBCQueryGoods.FieldByName('CurrencyID').AsInteger := CurrencyID;
      try
        IBCQueryGoods.Post;
        inc(RecordCnt);
      except
        on e: Exception do
        begin
          meErrors.Lines.Add(e.Message);
          IBCQueryGoods.Cancel;
        end;
      end;
      q.Close;
    end;
  finally
    q.Free;
  end;
  ShowMessage(format('Au fost importate %d produse', [Recordcnt]));
end;

procedure TfrmWebPromoGoodsDlg.DoImportInternalCodes;
var
  cell: TdxSpreadSheetCell;
  GoodsID: Integer;
  goods_code: string;
  i: Integer;
  Price: Double;
  OldPrice: Double;
  q: TIBCQuery;
  Sheet: TdxSpreadSheetTableView;
  Price1, Price2, Price3, Price4, Price5: Double;
  CurrencyID: Integer;
  OldCurrencyID: Integer;
  SupplierID: Integer;
begin
  q := TIBCQuery.Create(Self);
  Sheet := dxSpreadSheet1.ActiveSheetAsTable;
  try
    for i := 1 to Sheet.Rows.LastIndex do
    begin

      cell := Sheet.Cells[i, 1];
      if Assigned(cell) then
        GoodsID := cell.DisplayText.ToInteger;

      if beSupplier.Tag <= 0 then
      begin // get supplier code
        SupplierID := GetSupplierIDByGoodsID(GoodsID);
//        cell := Sheet.Cells[i, 0];
//
//        if Assigned(cell) then begin
//          SupplierID := StrToIntDef(cell.DisplayText, -1);
//        end;
      end
      else
      begin
        SupplierID := beSupplier.Tag;
      end;

//      if rbInternalGoodsID.Checked then begin
//        q.SQL.Text := 'select first 1 goods_code, customerid from ts_goods_foreign where goodsid = :goodsid and get_flg_value(flags, 3) = 1';
//        q.ParamByName('goodsid').AsString := GoodsID;
//        q.Open;
//        goods_code := q.FieldByName('goods_code').AsString;
//        SupplierID := q.FieldByName('Customerid').AsInteger;
//      end
//      else begin
//        cell := Sheet.Cells[i, 1];
//        if Assigned(cell) then
//          goods_code := cell.DisplayText;
//
      q.close;
      q.SQL.Text := 'select goods_code from ts_goods_foreign where goodsid=:goodsid and customerid = :supplierid';
      q.ParamByName('goodsid').AsInteger := GoodsID;
      q.ParamByName('supplierid').AsInteger := SupplierID;
      q.Open;

      if q.RecordCount = 0 then
        Continue;

      goods_code := q.FieldByName('GOODS_code').AsString;

      if cbCurrPrice.Checked then
      begin  // ������� ���� �� ����������� � ������ ���� �� �����
        q.Close;
        q.SQL.Text :=
          'select convert_amount(price_MDL, 498, :OldCurrencyID) price from get_goods_price(:goodsid, 1, :OldCurrencyID)';
        q.ParamByName('GOODSID').AsInteger := GoodsID;
//                q.ParamByName('GoodsCurrencyID').AsInteger := CurrencyID;
        q.ParamByName('OldCurrencyID').AsInteger := lcbOldCurrency.EditValue;
        q.Open;

        OldPrice := q.FieldByName('PRICE').AsInteger;
        OldCurrencyID := lcbOldCurrency.EditValue;
      end
      else
      begin
        cell := Sheet.Cells[i, 3];
        if Assigned(cell) then
          OldPrice := StrToFloatDef(Trim(cell.AsString), 0);
      end;

      cell := Sheet.Cells[i, 2];
      if Assigned(cell) then
        Price := StrToFloatDef(Trim(cell.AsString), 0)
      else
      begin
        Price := OldPrice;
        CurrencyID := OldCurrencyID;
      end;

      cell := Sheet.Cells[i, 4];
      if Assigned(cell) then
        CurrencyID := StrToIntDef(Trim(cell.AsString), 840);

      IBCQueryGoods.Append;
      IBCQueryGoods.FieldByName('GOODS_CODE').AsString := goods_code;
      IBCQueryGoods.FieldByName('SUPPLIERID').AsInteger := SupplierID;
      IBCQueryGoods.FieldByName('ORDERNO').AsInteger := i;
      IBCQueryGoods.FieldByName('PROMOACTIONID').AsInteger := FPromoActionID;
      IBCQueryGoods.FieldByName('FLG_DISCOUNT_TYPE').AsInteger := 1;
      IBCQueryGoods.FieldByName('FLG_SHOW_DISCOUNT_AS_AMOUNT').AsInteger := 1;
      IBCQueryGoods.FieldByName('GOODSID').AsInteger := GoodsID;
      IBCQueryGoods.FieldByName('OLD_PRICE4').AsCurrency := OldPrice;
      IBCQueryGoods.FieldByName('old_CurrencyID').AsInteger := OldCurrencyID;

      q.Close;
      q.SQL.Text := 'select * from WEB_GET_GOODS_MIN_INFO (:goodsid)';
      q.ParamByName('GOODSID').AsInteger := GoodsID;
      q.Open;

//            Price4 := q.FieldByName('PRICE4_LEI').AsCurrency;
//            Price5 := q.FieldByName('PRICE5_LEI').AsCurrency;
      IBCQueryGoods.FieldByName('PRICE4').AsCurrency := Price;
      IBCQueryGoods.FieldByName('CurrencyID').AsInteger := CurrencyID;
      try
        IBCQueryGoods.Post;
      except
        on e: Exception do
        begin
          IBCQueryGoods.Cancel;
        end;
      end;
      q.Close;
    end;
  finally
    q.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.dxBarButton12Click(Sender: TObject);
var
  DiscountValue: string;
begin
  IBCQueryGoods.DisableControls;
  try
    if (InputQuery('Modifica reducerea in promotie', 'Valorea reducerii', DiscountValue)) then
    begin
      IBCQueryGoods.First;
      while not IBCQueryGoods.Eof do
      begin
        IBCQueryGoods.Edit;
        IBCQueryGoods.FieldByName('DISCOUNT_VALUE_MDL').AsString := DiscountValue;
        IBCQueryGoods.Post;
        IBCQueryGoods.Next;
      end;
    end;
  finally
    IBCQueryGoods.EnableControls;
  end;
end;

procedure TfrmWebPromoGoodsDlg.dxBarButton13Click(Sender: TObject);
var
  q: TIBCQuery;
begin
  IBCQueryGoods.DisableControls;
  q := TIBCQuery.Create(Self);
  try
    q.SQL.Text := 'select GET_CASHBACK_PERCENT(:GOODSID) cashback from rdb$database';
    q.Prepare;

    IBCQueryGoods.First;

    while not IBCQueryGoods.Eof do
    begin
      q.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
      q.Execute;
      IBCQueryGoods.Edit;
      IBCQueryGoods.FieldByName('CASHBACK_PERCENT').AsString := q.FieldByName('cashback').AsString;
      IBCQueryGoods.Post;
      IBCQueryGoods.Next;
    end;
  finally
    IBCQueryGoods.EnableControls;
    q.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.bbAddBurstGoodsClick(Sender: TObject);
var
   dialog: TfrmGoodsBrowser;
   LastGoodsID: integer;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    dialog.BurstMode := True;
    dialog.OnBurstAddGoods := WhenBurstAddGoods;
    LastGoodsID := AppUserConfigStorage.IntValues.GetValue(self.Name+'LastGoodsID', 0);

    if dialog.SelectGoods(LastGoodsID, True) then
    begin
      AppUserConfigStorage.IntValues.SetValue(self.Name+'LastGoodsID', dialog.GoodsID);

      var frmWebSelectGoodsSupplierDlg := TfrmWebSelectGoodsSupplierDlg.Create(self);

      frmWebSelectGoodsSupplierDlg.GoodsID := dialog.GoodsID;

      if (frmWebSelectGoodsSupplierDlg.ShowModal=mrOK) then
      begin
         AddGoods(
                  frmWebSelectGoodsSupplierDlg.SupplierID,
                  frmWebSelectGoodsSupplierDlg.GoodsID,
                  frmWebSelectGoodsSupplierDlg.GoodsName,
                  frmWebSelectGoodsSupplierDlg.GoodsCode,
                  frmWebSelectGoodsSupplierDlg.GoodsPromoPrice,
                  frmWebSelectGoodsSupplierDlg.CurrencyID);

//                  RefreshGoodsCode(frmWebSelectGoodsSupplierDlg.GoodsID, frmWebSelectGoodsSupplierDlg.SupplierID);
      end;

//      IBCQueryGoodsSuppliers.Close;
//      IBCQueryGoodsSuppliers.ParamByName('GOODSID').AsInteger := dialog.GoodsID;
//      IBCQueryGoodsSuppliers.Open;
//
//      if IBCQueryGoodsSuppliers.RecordCount > 0 then
//        lcbGoodsSuppliers.Text := IBCQueryGoodsSuppliers.FieldByName('customer_name').AsString;
//
//      SupplierID := IBCQueryGoodsSuppliers.FieldByName('CUSTOMERID').AsInteger;
//      RefreshGoodsCode(GoodsID, SupplierID);
    end;
  finally

  end;
end;

procedure TfrmWebPromoGoodsDlg.bbModifyClick(Sender: TObject);
var
  d: TfrmWebSelectGoodsDlg;
begin
  d := TfrmWebSelectGoodsDlg.Create(Self, dmDB.IBCConnection);
  try
      // load default values
    AppUserConfigStorage.OpenSection(Self.Name);
    d.supplierid := IBCQueryGoods.FieldByName('SUPPLIERID').AsInteger;
    d.suppliername := IBCQueryGoods.FieldByName('SUPPLIER_NAME').AsString;
    d.GoodsID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
    d.GoodsName := IBCQueryGoods.FieldByName('GOODS_NAME').AsString;
    d.GoodsCurrencyID := IBCQueryGoods.fieldByname('Currencyid').AsInteger;
    d.GoodsPrice := IBCQueryGoods.FieldByName('price4').AsFloat;
//        d.OnCheckIfGoodsExists := WhenCheckIfGoodsExists;
//        d.OnAddGoods := EditGoods;
//        d.OnAddGoodsFolder := AddGoodsFolder;

    if d.ShowModal = mrOk then
    begin
      AppUserConfigStorage.IntValues.SetValue(Self.Name + 'SUPPLIERID', d.supplierid);
      AppUserConfigStorage.TextValues.GetValue(Self.Name + 'SUPPLIERNAME', d.suppliername);
      AppUserConfigStorage.IntValues.GetValue(Self.Name + 'GOODSID', d.goodsid);
      AppUserConfigStorage.TextValues.GetValue(Self.Name + 'GOODSNAME', d.goodsname);
      EditGoods(d.SupplierID, d.GoodsCode, d.GoodsID, d.GoodsName, d.GoodsPrice, d.GoodsCurrencyID);
      IBCQueryGoods.Refresh;
    end;
  finally
    d.Free;
    AppUserConfigStorage.CloseSection;
  end;
end;

//var
//    dialog: TfrmGoodsBrowser;
//begin
//    dialog := TfrmGoodsBrowser.Create(Self);
//    try
//        dialog.OnCheckIfGoodsExists := WhenCheckIfGoodsExists;
//        if dialog.SelectGoods(IBCQueryGoods.FieldByName('GOODSID').AsInteger, True) then
//        begin
//            if not WhenCheckIfGoodsExists(dialog.GoodsID) then
//            begin
//                EditGoods(dialog.GoodsID, dialog.GoodsPriceMDL[4], dialog.GoodsPriceMDL[4], dialog.GoodsPriceMDL[4], dialog.GoodsPriceMDL[4],
//                    dialog.GoodsPriceMDL[5], dialog.GoodsPriceCurrencyID);
//                IBCQueryGoods.Refresh;
//            end;
//        end;
//    finally
//        dialog.Free;
//    end;
//end;

procedure TfrmWebPromoGoodsDlg.bbCreateRevaluationClick(Sender: TObject);
begin
  DoCreateReevaluare;
end;

function TfrmWebPromoGoodsDlg.GetSupplierIDByGoodsID(GoodsID: Integer): Integer;
var
  Query: TIBCQuery;
begin
  Result := -1;
  Query := TIBCQuery.Create(nil);
  try
    Query.SQL.Add('select');
    Query.SQL.Add('a.customerid,');
    Query.SQL.Add('(select name from ts_customer where customerid = a.customerid) customer_name,');
    Query.SQL.Add('get_flg_value(a.flags, 3) flg_in_price,');
    Query.SQL.Add('(select price_mdl from GET_GOODS_PRICE7(goodsid, 498)) price');
    Query.SQL.Add('from ts_goods_foreign a');
    Query.SQL.Add('where a.goodsid = :goodsid');
    Query.SQL.Add('order by 3 desc, 4');
    Query.ParamByName('goodsid').AsInteger := GoodsID;
    Query.Open;

    Result := Query.FieldByName('CUSTOMERID').AsInteger;
  finally
    Query.Free;
  end;
end;

function TfrmWebPromoGoodsDlg.GoodsExists(const GoodsID: Integer): Boolean;
begin
  result := false;
  for var i:= 0 to cxGridDBBandedTableView1.DataController.RecordCount - 1 do
  begin
     if cxGridDBBandedTableView1.DataController.Values[i, cxGridDBBandedTableView1_GOODSID.Index] = GoodsID then
     begin
        Result := True;
        exit;
     end;
  end;
end;

procedure TfrmWebPromoGoodsDlg.GoodsSelectionChanged;
var
  fAdd, fDelete: Boolean;
begin
  fAdd := True;
  fDelete := False;
  if (cxGridDBBandedTableView1.DataController.RecNo > 0) then
  begin
    fDelete := True;
  end;
  bbAdd.Enabled := fAdd;
  bbEditGoodsPrices.Enabled := fDelete;
  bbDelete.Enabled := fDelete;
  bbDeleteAll.Enabled := fDelete;
end;

function TfrmWebPromoGoodsDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    try

      if IBCQueryGoods.Active and (IBCQueryGoods.State in dsEditModes) then
        IBCQueryGoods.Post;

      dmDB.ExecuteQuery('EXECUTE PROCEDURE UPDATE_TS_PRICE_FROM_PA(:PROMOACTIONID)', [IBCQueryGoods.FieldByName('PROMOACTIONID').AsInteger]);

      if IBCQueryGoods.UpdateTransaction.Active then
        IBCQueryGoods.UpdateTransaction.Commit;

      cxPropertiesStore1.StorageName := Extractfilepath(Application.ExeName) + 'swn_' + dmDB.CurrentUserID.ToSTring + '.ini';
      cxPropertiesStore1.StoreTo();

      Result := True;
    except
      IBCQueryGoods.UpdateTransaction.Rollback;
      raise;
    end;

  end;
end;

procedure TfrmWebPromoGoodsDlg.LoadStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
        // form position
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos
      (Self) then
      Self.Position := poDesigned;
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridDBBandedTableView1);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmWebPromoGoodsDlg.Prepare;
begin
  dtDialogTitle.Text := 'Produse si preturi';
  IBCQueryGoods.UpdateTransaction := UpdateTransaction;

//  if promotion is active then disable controls
  bbAdd.Enabled := not GoodsReadOnly;
  bbModify.Enabled := not GoodsReadOnly;
  bbDelete.Enabled := not GoodsReadOnly;
  bbdeleteall.Enabled := not GoodsReadOnly;
  bbUpdatePrices.Enabled := not GoodsReadOnly;
  bbCreateRevaluation.Enabled := not GoodsReadOnly;
  dxBarSubItem1.Enabled := not GoodsReadOnly;

  cxGridDBBandedTableView1.OptionsData.Editing := not GoodsReadOnly;

  if not IBCQueryGoods.UpdateTransaction.Active then
    IBCQueryGoods.UpdateTransaction.StartTransaction;

  IBCQueryGoods.ParamByName('PROMOACTIONID').AsInteger := PromoActionID;
  IBCQueryGoods.Active := True;
  IBCQueryCurrency.Active := True;
  GoodsSelectionChanged;

  pcPages.ActivePageIndex := 0;
  cxPropertiesStore1.StorageName := Extractfilepath(Application.ExeName) + 'swn_' + dmDB.CurrentUserID.ToSTring + '.ini';
  cxPropertiesStore1.RestoreFrom;
  cxGridDBBandedTableView1.OPtionsSelection.MultiSelect := True;
end;

procedure TfrmWebPromoGoodsDlg.PrepareSpreadSheet;
var
  ATable: TdxSpreadSheetTableView;
  fArea: TRect;
begin
//  dxSpreadSheet1.ClearAll;

  fArea.Left := 0;
  fArea.Top := 1;
  fArea.Bottom := dxSpreadSheet1.ActiveSheetAsTable.Rows.LastIndex;
  fArea.Right := dxSpreadSheet1.ActiveSheetAsTable.Columns.LastIndex;
  dxSpreadSheet1.ActiveSheetAsTable.ClearCells(fArea, True, True);

  ATable := dxSpreadSheet1.ActiveSheetAsTable;

  with ATable.CreateCell(0, 0) do
  begin
    AsString := 'Cod Furnizor';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 90;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 1) do
  begin

    AsString := 'CPF';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 120;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 2) do
  begin
    AsString := 'Pret Nou';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 120;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 3) do
  begin
    AsString := 'Pret Vechi';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 120;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 4) do
  begin
    AsString := 'Valuta promo';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 90;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 5) do
  begin
    AsString := 'Pret 7';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 90;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 6) do
  begin
    AsString := 'Valuta 7';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 90;
    Style.Font.Style := [fsBold];
  end;


end;

procedure TfrmWebPromoGoodsDlg.PretCurentInPretNou;
var
  i: Integer;
  cell: TdxSpreadSheetCell;
  Sheet: TdxSpreadSheetTableView;
  q: TIBCQuery;
begin
  Sheet := dxSpreadSheet1.ActiveSheetAsTable;

  q := TIBCQuery.Create(nil);
  try
    dxSpreadSheet1.BeginUpdate;
    q.SQL.Add('select convert_amount(gf.price1, gf.currency1id, 498, 1) Price1 from ts_goods_foreign gf');
    q.SQL.Add('where gf.customerid=:customerid and gf.goods_code=:goods_code');
    q.Prepare;
    for  i := 1 to Sheet.Rows.LastIndex do
    begin
      cell := Sheet.Cells[i, 1];
      q.ParamByName('CUSTOMERID').AsInteger := besupplier.Tag;
      q.ParamByName('GOODS_CODE').AsString := cell.AsString;
      q.Open;
      cell := Sheet.Cells[i, 2];
      if not Assigned(cell) then
         cell := Sheet.CreateCell(i, 2);
      cell.SetText(q.FieldByName('price1').AsString);
      q.Close;
    end;
  finally
    q.Free;
    dxSpreadSheet1.EndUpdate;
  end;
end;

procedure TfrmWebPromoGoodsDlg.SaveStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
        // form pos
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.SaveFormPos(Self);

    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridDBBandedTableView1);

  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmWebPromoGoodsDlg.SetOnBurstAddGoods(const Value:
    TOnBurstAddGoods);
begin
  FOnBurstAddGoods := Value;
  // TODO -cMM: TfrmWebPromoGoodsDlg.SetOnBurstAddGoods default body inserted
end;

procedure TfrmWebPromoGoodsDlg.SetPromoActionID(const Value: Integer);
begin
  FPromoActionID := Value;
end;

procedure TfrmWebPromoGoodsDlg.SetUpdateTransaction(const Value: TIBCTransaction);
begin
  FUpdateTransaction := Value;
  IBCQueryGoods.Transaction := Value;
  IBCQueryGoods.UpdateTransaction := Value;
end;

procedure TfrmWebPromoGoodsDlg.ShowAddGoodsDialog;
var
  d: TfrmWebSelectGoodsDlg;
begin
  d := TfrmWebSelectGoodsDlg.Create(Self, dmDB.IBCConnection);
  try
      // load default values
    AppUserConfigStorage.OpenSection(Self.Name);
    d.supplierid := AppUserConfigStorage.IntValues.GetValue(Self.Name + 'SUPPLIERID', -1);
    d.suppliername := AppUserConfigStorage.TextValues.GetValue(Self.Name + 'SUPPLIERNAME', '');
    d.GoodsID := AppUserConfigStorage.IntValues.GetValue(Self.Name + 'GOODSID', -1);
    d.GoodsName := AppUserConfigStorage.TextValues.GetValue(Self.Name + 'GOODSNAME', '');
    d.GoodsCurrencyID := IBCQueryGoods.FieldByName('CURRENCYID').AsInteger;

//    d.OnBurstAddGoods := WhenBurstAddGoods;
//        d.GoodsCode := IBCQueryGoods.FieldByName('GOODS_CODE').AsString;
    if d.ShowModal = mrOk then
    begin
      AppUserConfigStorage.IntValues.SetValue(Self.Name + 'SUPPLIERID', d.supplierid);
      AppUserConfigStorage.TextValues.SetValue(Self.Name + 'SUPPLIERNAME', d.suppliername);
      AppUserConfigStorage.IntValues.SetValue(Self.Name + 'GOODSID', d.goodsid);
      AppUserConfigStorage.TextValues.SetValue(Self.Name + 'GOODSNAME', d.goodsname);

            // inscriem datele selectate in tabel
      AddGoods(d.supplierid, d.GoodsID, d.GoodsTitle, d.GoodsCode, d.GoodsPrice, d.GoodsCurrencyID);

            // refresh
      IBCQueryGoods.Refresh;
    end;
  finally
    d.Free;
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmWebPromoGoodsDlg.ShowAddGoodsFolderDialog;
begin

end;

procedure TfrmWebPromoGoodsDlg.ShowModifyEditorDlg;
begin

end;

procedure TfrmWebPromoGoodsDlg.ValidateData(SupplierMode: Boolean);
var
  cell: TdxSpreadSheetCell;
  GoodsID: string;
  i: Integer;
//  Price: Double;
//  OldPrice: Double;
  q: TIBCQuery;
  Sheet: TdxSpreadSheetTableView;
//  Price1, Price2, Price3, Price4, Price5: Double;
//  CurrencyID: Integer;
  SupplierID: Integer;
begin
  SupplierID := -1;
  if SupplierMode then
  begin
    SupplierID := beSupplier.Tag;
    if SupplierID <= 0 then
      Exception.Create('Eroare! Nu este ales furnizorul pentru import');
  end;

  q := TIBCQuery.Create(Self);
  q.SQL.Text := 'SELECT GOODSID FROM TS_GOODS_FOREIGN WHERE CUSTOMERID = :CUSTOMERID AND GOODS_CODE = :GOODS_CODE';
  q.ParamByName('CUSTOMERID').AsInteger := SupplierID;
  try
    Sheet := dxSpreadSheet1.ActiveSheetAsTable;
    for i := 1 to Sheet.Rows.LastIndex do
    begin
      cell := Sheet.Cells[i, 1];
      if beSupplier.Tag <= 0 then
        if Assigned(cell) and (Sheet.Cells[i, 0].AsString <> '') then
          SupplierID := Sheet.Cells[i, 0].AsInteger
        else
        begin
          Exception.Create('Introduceri codul furnizorul pentru tot importul sau pentru fiecare produs in parte');
        end;
//      cell := Sheet.Cells[i, 1];
      GoodsID := '-1';

      if Assigned(cell) then
        GoodsID := cell.DisplayText;

      if SupplierMode then
      begin
        q.ParamByName('GOODS_CODE').AsString := cell.DisplayText;
        q.Open;
        if q.RecordCount = 0 then
        begin
          q.CLose;
          Continue;
        end
        else
        begin
          GoodsID := q.FieldByName('GOODSID').AsString;
          q.CLose;
        end;
        if GoodsID = '' then
          GoodsID := '-1';

//                Sheet.Cells[i, 1].SetText(GoodsID);
      end;

      if GoodsID = '-1' then
        raise Exception.Create('Nu este indicat codul produsului! ' + #13#10 + 'Rindul:' + i.ToString);
    end;
  finally
    q.Free;
  end;

end;

procedure TfrmWebPromoGoodsDlg.WhenAddGoods(const GroupGoodsID: Integer; var Res: Boolean);
var
  Query: TIBCQuery;
begin
  Res := False;
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := fIBCConnection;
    Query.transaction := IBCTrLocalUpdate;

    if not IBCTrLocalUpdate.Active then
      IBCTrLocalUpdate.StartTransaction;

    Query.SQL.Text := 'EXECUTE PROCEDURE ADD_GOODS_TO_WEB_MAIN_PAGE(:GROUPID, :GOODSID)';
    Query.parambyname('groupid').AsINteger := GroupGoodsID;
    Query.parambyname('goodsid').Asinteger := IBCQueryGoods.fieldbyname('goodsid').Asinteger;
    try
      Query.Execute;

      if IBCTrLocalUpdate.Active then
        IBCTrLocalUpdate.Commit;
      Res := True;

    except
      on E: Exception do
      begin
        MessageBox(Handle, PChar(Format('Produsul %d nu a putut fi adaugat.', [IBCQueryGoods.fieldbyname('goodsid').Asinteger])),
          'Eroare', MB_OK + MB_ICONSTOP + MB_TOPMOST);
        raise;
      end;
    end
  finally
    Query.Free;
  end;
end;

procedure TfrmWebPromoGoodsDlg.WhenBurstAddGoods(const GoodsID: Integer; const GoodsTitle: string; var Added: Boolean;
  var Count: Integer);
var
  CurrencyID: Integer;
  GoodsCode: string;
  Price: Double;
  SupplierID: integer;
  q: tibcquery;
  SupplierName: string;
begin
      //supplierid
      q := TIBCQuery.Create(nil);
      try
        q.sql.add('select');
        q.sql.add('a.customerid,');
        q.sql.add('(select name from ts_customer where customerid = a.customerid) customer_name,');
        q.sql.add('get_flg_value(a.flags, 3) flg_in_price,');
        q.sql.add('(select price_mdl from GET_GOODS_PRICE7(goodsid, 498)) price');
        q.sql.add('from ts_goods_foreign a');
        q.sql.add('where a.goodsid = :goodsid');
        q.sql.add('order by 3 desc, 4');
        q.ParamByName('goodsid').AsInteger := GoodsID;
        q.Open;

        if (q.RecordCount>0) then
        begin
          Supplierid := q.FieldByName('customerid').AsInteger;
          SupplierName := q.FieldByName('customer_name').AsString;
        end
        else
          raise Exception.Create('Nu este indicat furnizorul produsului!');
      finally
        FreeAndNil(q);
      end;

      q := TIBCQuery.Create(nil);
      try
        q.sql.add('select goods_code, price1, currency1id from ts_goods_foreign gf');
        q.sql.add('where');
        q.sql.add('gf.customerid = :customerid and');
        q.sql.add('gf.goodsid = :goodsid');
        q.ParamByName('goodsid').AsInteger := goodsid;
        q.ParamByName('customerid').AsInteger := SupplierID;
        q.Open;
        GoodsCode := q.FieldByName('Goods_code').AsString;
        Price := q.FieldByName('price1').AsFloat;
        CurrencyID := q.FieldByName('currency1id').AsInteger;
      finally
        q.Free;
      end;

      try
        if not GoodsExists(GoodsID) then
        begin
          AddGoods(SupplierID, GoodsID, GoodsTitle, GoodsCode, Price, CurrencyID);
          Added := True;
        end;
      finally
        Added := false;
      end;
//
//    dmDB.OpenQuery(dmdb.tmpQuery, 'SELECT price, price_mdl, currencyid from get_goods_price(:GOODSID, 1, 498)', [GoodsID]);
//    with dmDB.tmpQuery do
//    begin
//      GoodsID := dialog.GoodsID;
//      IBCQueryGoodsSuppliers.Close;
//      IBCQueryGoodsSuppliers.ParamByName('GOODSID').AsInteger := GoodsID;
//      IBCQueryGoodsSuppliers.Open;

//      if IBCQueryGoodsSuppliers.RecordCount = 0 then
//      begin
//        exception.Create('Nu este setat furnizorul pentru produsul ales!');
//      end;


//        lcbGoodsSuppliers.Text := IBCQueryGoodsSuppliers.FieldByName('customer_name').AsString;

//      SupplierID := IBCQueryGoodsSuppliers.FieldByName('CUSTOMERID').AsInteger;
//      RefreshGoodsCode(GoodsID, SupplierID);
//    end;

//        if AddGoods(GoodsID, FieldByName('PRICE1').AsFloat, FieldByName('PRICE4').AsFloat, FieldByName('PRICE4').AsFloat, FieldByName('PRICE4').AsFloat,
//            FieldByName('PRICE4').AsFloat, FieldByName('CURRENCYID').AsInteger) then
//        begin
//            Added := True;
//            Count := 1;
//        end;
end;

procedure TfrmWebPromoGoodsDlg.WhenCancelForm;
begin
  if IBCQueryGoods.Active and (IBCQueryGoods.State in dsEditModes) then
    IBCQueryGoods.Cancel;
  if IBCQueryGoods.UpdateTransaction.Active then
    IBCQueryGoods.UpdateTransaction.Rollback;
end;

function TfrmWebPromoGoodsDlg.WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
//var
//    i: Integer;
//    q: TIBCQuery;
begin
//    Result := False;
//    q := TIBCQuery.Create(Self);
//    try
//        q.SQL.Text := 'SELECT PROMOACTIONLIST, CNT FROM SP_CHECK_GOODS_IN_PROMOACTION(:GOODSID)';
//        q.Prepare;
//        for i := 0 to cxGridDBBandedTableView1.DataController.RecordCount - 1 do
//        begin
//            if cxGridDBBandedTableView1.DataController.Values[i, cxGridDBBandedTableView1_GOODSID.Index] = GoodsID then
//            begin
//                Result := True;
//                Break;
//            end;
//            q.ParamByName('GOODSID').AsInteger := GoodsID;
//            q.Open;
//            if q.FieldByName('CNT').AsInteger > 0 then
//            begin
//                Result := True;
//                MessageDlg('Acest produs exista in urmatoarele promotii active: ' + q.FieldByName('PROMOACTIONLIST').AsString, mtError, [mbOK], 0);
//                Break;
//            end;
//        end;
//    finally
//        q.Free;
//    end;

  Result := True;
end;

end.

