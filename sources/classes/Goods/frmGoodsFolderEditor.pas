unit frmGoodsFolderEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, DB,
  Dialogs, MemDS, IBC, dxBar, cxDBEdit, cxDBLookupComboBox, StdCtrls, ComCtrls, DialogTitle, Buttons,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, DBAccess, cxClasses, cxMemo, cxDropDownEdit, cxCalc, cxCheckBox, cxTextEdit, cxMaskEdit,
  cxLookupEdit, cxDBLookupEdit, cxButtonEdit, dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC,
  dxUIAClasses;

type
  TfrmGoodsFolderEditorDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pcPageControl: TPageControl;
    cxTabSheet1: TTabSheet;
    cxTabSheet2: TTabSheet;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cmbGoodsType: TcxDBLookupComboBox;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    edTITLE: TcxDBTextEdit;
    IBCDataSourceGoodsType: TIBCDataSource;
    IBCQueryGoodsType: TIBCQuery;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    mmCOMMENTS: TcxDBMemo;
    IBCQueryGoodsDSC: TIBCQuery;
    IBCDataSourceGoodsDSC: TIBCDataSource;
    Label1: TLabel;
    cmbWEBGOODSTYPE_ID: TcxDBLookupComboBox;
    IBCDataSourceWebGoodsType: TIBCDataSource;
    IBCQueryWebGoodsType: TIBCQuery;
    sbCustomWebGoodsType: TSpeedButton;
    cbFLG_REQUIRE_CERTIFICAT: TcxDBCheckBox;
    lcbSerialNumber: TcxDBLookupComboBox;
    cxLabel21: TLabel;
    IBCDataSourceGST: TIBCDataSource;
    IBCQueryGST: TIBCQuery;
    Label3: TLabel;
    lcbTypeGoodsForDelivery: TcxDBLookupComboBox;
    IBCDataSourceTypeGoodsDelivery: TIBCDataSource;
    IBCQueryTypeGoodsDelivery: TIBCQuery;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cxLabel3: TLabel;
    lbVAT: TLabel;
    Label2: TLabel;
    cmbVAT: TcxDBComboBox;
    Label4: TLabel;
    ceCashback: TcxDBCalcEdit;
    cbFLG_BEST_PRICE: TcxDBCheckBox;
    Label5: TLabel;
    IBCQueryTemplate: TIBCQuery;
    IBCDataSourceTemplate: TIBCDataSource;
    IBCQueryRelatedKeys: TIBCQuery;
    IBCDataSourceRelatedKeys: TIBCDataSource;
    lcbTemplate: TcxDBLookupComboBox;
    Label6: TLabel;
    lcbRelatedKeys: TcxDBLookupComboBox;
    cxPageControl1: TcxPageControl;
    tbsCommonFilters: TcxTabSheet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    bbNewFilter: TdxBarButton;
    bbDeleteFilter: TdxBarButton;
    IBCQueryFiltersParams: TIBCQuery;
    IBCDataSourceFiltersParams: TIBCDataSource;
    cxGrid1DBTableView1_FilterName: TcxGridDBColumn;
    cxGrid1DBTableView1_FilterID: TcxGridDBColumn;
    cxGrid1DBTableView1_ParamID: TcxGridDBColumn;
    cxGrid1DBTableView1_ParamName: TcxGridDBColumn;
    cxTabSheet3: TcxTabSheet;
    dxBarDockControl3: TdxBarDockControl;
    dxBarManagerBar3: TdxBar;
    bbNewGoodsCategory: TdxBarButton;
    bbModifyGoodsCategory: TdxBarButton;
    bbDeleteGoodsCategory: TdxBarButton;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    IBCQueryGoodsCategories: TIBCQuery;
    IBCDataSourceGoodsCategories: TIBCDataSource;
    cxGrid2DBTableView1Column1: TcxGridDBColumn;
    cxGrid2DBTableView1Column2: TcxGridDBColumn;
    SpeedButton1: TSpeedButton;
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure sbCustomWebGoodsTypeClick(Sender: TObject);
    procedure bbNewFilterClick(Sender: TObject);
    procedure bbDeleteFilterClick(Sender: TObject);
    procedure bbNewGoodsCategoryClick(Sender: TObject);
    procedure bbModifyGoodsCategoryClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    FCashbackValue: Integer;
    { Private declarations }
    FGoodsID: Integer;
    FParentID: Integer;
    fCreateNewRecord: Boolean;
    FDeliveryTypeID: Integer;
    FLastOpenedFilterID: Integer;
    FParentGoodsTypeID: Integer;
    FParentWEBGoodsTypeID: Integer;
    FParentSerialTypeID: Integer;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure SetGoodsID(const Value: Integer);
    procedure SetParentID(const Value: Integer);
    procedure SetParentGoodsTypeID(const Value: Integer);
    function CheckParams: Boolean;
    procedure SetCashbackValue(const Value: Integer);
    procedure SetDeliveryTypeID(const Value: Integer);
    procedure SetParentWEBGoodsTypeID(const Value: Integer);
    procedure SetParentSerialTypeID(const Value: Integer);
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    function getParentSerialTypeid(FParentID: Integer): Integer;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

    procedure ShowWebGoodsTypeDialog;
  public
    { Public declarations }
    property CreateNewRecord: Boolean write SetCreateNewRecord;
    property ParentID: Integer read FParentID write SetParentID;
    property ParentGoodsTypeID: Integer read FParentGoodsTypeID write SetParentGoodsTypeID;
    property ParentWEBGoodsTypeID: Integer read FParentWEBGoodsTypeID write SetParentWEBGoodsTypeID;
    property ParentSerialTypeID: Integer read FParentSerialTypeID write SetParentSerialTypeID;
    property GoodsID: Integer read FGoodsID write SetGoodsID;
  published
    property CashbackValue: Integer read FCashbackValue write SetCashbackValue;
    property DeliveryTypeID: Integer read FDeliveryTypeID write SetDeliveryTypeID;
  end;

implementation

uses
  SWNUtils, SWNConst, frmGoodsTypeDialog, SWNValueStorageUnit, frmWebFiltersDialog, DataModuleDB, frmWebDescriptionTemplateDialog;

{$R *.dfm}

{ TfrmGoodsFolderEditorDialog }

function TfrmGoodsFolderEditorDialog.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('TITLE').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE').AsString)
    = '') then
    AddErrorToStr(ErrorStr, 'Denumirea mapei!');
  if fMasterDataSet.FieldByName('GOODS_TYPE_ID').IsNull or (fMasterDataSet.FieldByName('GOODS_TYPE_ID').AsInteger
    = -1) then
    AddErrorToStr(ErrorStr, 'Tip mapa!');
  if fMasterDataSet.FieldByName('WEBGOODSTYPE_ID').IsNull or (fMasterDataSet.FieldByName('WEBGOODSTYPE_ID').AsInteger
    = -1) then
    AddErrorToStr(ErrorStr, 'Tip produs implicit!');
  if fMasterDataSet.FieldByName('SERIAL_TYPE_ID').IsNull or (fMasterDataSet.FieldByName('SERIAL_TYPE_ID').AsInteger
    = -1) then
    AddErrorToStr(ErrorStr, 'Tip evidenta implicit!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmGoodsFolderEditorDialog.dxBarButton1Click(Sender: TObject);
begin
  IBCQueryGoodsDSC.Delete;
end;

procedure TfrmGoodsFolderEditorDialog.dxBarButton2Click(Sender: TObject);
begin
  mmCOMMENTS.PasteFromClipboard;
end;

procedure TfrmGoodsFolderEditorDialog.bbDeleteFilterClick(Sender: TObject);
begin
  if MessageDlg('Doriti sa stergeti filtrul curent?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
    IBCQueryFiltersParams.Delete;
end;

procedure TfrmGoodsFolderEditorDialog.bbModifyGoodsCategoryClick(
  Sender: TObject);
var
  editor: TfrmGoodsTypeDlg;
  GoodsTypeID: Integer;
begin
  editor := TfrmGoodsTypeDlg.Create(Self);
  try
    editor.SelectMode := True;
    if IBCQueryGoodsCategories.Active then
      GoodsTypeID := -1; //IBCQueryGoodsCategories.FieldByName('goods_categoryid').AsInteger;

    if editor.SelectGoodsType(GoodsTypeID) then
    begin
      ibcquerygoodscategories.Edit;
      IBCQueryGoodsCategories.FieldByName('goods_categoryid').AsInteger := editor.GoodsTypeID;
      ibcquerygoodscategories.FieldByName('goods_category_name').AsString := editor.GoodsTypeTitle;
//      IBCQueryGoodsCategories.FieldByName('folder_goodsid').AsInteger := MasterDataSet.FieldByName('goodsid').AsInteger;
      IBCQueryGoodsCategories.Post;
    end;
  finally
    editor.Free;
  end;
end;

procedure TfrmGoodsFolderEditorDialog.bbNewFilterClick(Sender: TObject);
var
  dialog: TfrmWebFiltersDlg;
  defaultFilterID, defaultFilterParamID: integer;
begin
  dialog := TfrmWebFiltersDlg.Create(Self, dmdb.IBCConnection);
  try
    defaultFilterID := -1;
    defaultFilterParamID := -1;
    if not IBCQueryFiltersParams.FieldByName('FILTERID').IsNull then
      defaultFilterID := IBCQueryFiltersParams.FieldByName('FILTERID').AsInteger;
    if not IBCQueryFiltersParams.FieldByName('FILTERPARAMID').IsNull then
      defaultFilterParamID := IBCQueryFiltersParams.FieldByName('FILTERPARAMID').AsInteger;
    if (defaultFilterID = -1) and (FLastOpenedFilterID > 0) then
    begin
      defaultFilterID := FLastOpenedFilterID;
    end;

    if dialog.SelectFilterParam(defaultFilterID, defaultFilterParamID) then
    begin
      IBCQueryFiltersParams.Append;
      IBCQueryFiltersParams.FieldByName('FILTERID').AsInteger := dialog.FilterID;
      IBCQueryFiltersParams.FieldByName('FILTERPARAMID').AsInteger := dialog.FilterParamID;
      IBCQueryFiltersParams.FieldByName('GOODSFOLDERID').AsInteger := fMasterDataSet.FieldByName('goodsid').AsInteger;
      if IBCQueryFiltersParams.State in [dsEdit, dsInsert] then
        IBCQueryFiltersParams.Post;
    end
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsFolderEditorDialog.bbNewGoodsCategoryClick(Sender: TObject);
var
  editor: TfrmGoodsTypeDlg;
  GoodsTypeID: Integer;
begin
  editor := TfrmGoodsTypeDlg.Create(Self);
  try
    editor.SelectMode := True;
    if IBCQueryGoodsCategories.Active then
      GoodsTypeID := -1; //IBCQueryGoodsCategories.FieldByName('goods_categoryid').AsInteger;

    if editor.SelectGoodsType(GoodsTypeID) then
    begin
      ibcquerygoodscategories.Append;
      IBCQueryGoodsCategories.FieldByName('goods_categoryid').AsInteger := editor.GoodsTypeID;
      ibcquerygoodscategories.FieldByName('goods_category_name').AsString := editor.GoodsTypeTitle;
      IBCQueryGoodsCategories.FieldByName('folder_goodsid').AsInteger := MasterDataSet.FieldByName('goodsid').AsInteger;
      IBCQueryGoodsCategories.Post;
    end;
  finally
    editor.Free;
  end;
end;

procedure TfrmGoodsFolderEditorDialog.BindingDataSource;
begin
  inherited;
  fCreateNewRecord := False;
  FParentGoodsTypeID := -1;
  FParentWEBGoodsTypeID := -1;
  FParentSerialTypeID := 4402;  // partide
  FParentID := -1;

  edTITLE.DataBinding.DataSource := fMasterDataSource;
  cmbGoodsType.DataBinding.DataSource := fMasterDataSource;
  cmbWEBGOODSTYPE_ID.DataBinding.DataSource := fMasterDataSource;
  lcbSerialNumber.DataBinding.DataSource := fMasterDataSource;
  cbFLG_REQUIRE_CERTIFICAT.DataBinding.DataSource := fMasterDataSource;
  cmbVAT.DataBinding.DataSource := fMasterDataSource;

  IBCQueryGoodsDSC.Connection := fIBCConnection;
  IBCQueryGoodsDSC.MasterSource := fMasterDataSource;
  IBCQueryGoodsDSC.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  lcbTypeGoodsForDelivery.DataBinding.DataSource := fMasterDataSource;
  ceCashback.DataBinding.DataSource := fMasterDataSource;
  cbFLG_BEST_PRICE.DataBinding.DataSource := fMasterDataSource;
  lcbRelatedKeys.DataBinding.DataSource := fMasterDataSource;
  lcbTemplate.DataBinding.DataSource := fMasterDataSource;

  IBCQueryRelatedKeys.Open;

  pcPageControl.ActivePageIndex := 0;
end;

function TfrmGoodsFolderEditorDialog.getParentSerialTypeid(FParentID: Integer):
    Integer;
var
  q: TIBCQuery;
begin
  Result := -1;
  q := TIBCQuery.Create(nil);
  try
    q.SQL.Text := 'select serial_type_id from ts_goods where goodsid = :parentid';
    q.Open;
    Result := q.FieldByName('serial_type_id').AsInteger;
    
    if q.FieldByName('serial_type_id').AsInteger<=0 then
      Result :=  AppUserTempConfigStorage.IntValues.GetValue('GoodsFolderEditor_SERIAL_TYPE_ID', -1);
    
  finally
    q.Free;
  end;
end;

function TfrmGoodsFolderEditorDialog.IsFormDataPosted: Boolean;
begin
  if fCreateNewRecord then
  begin
    AppUserTempConfigStorage.IntValues.SetValue('GoodsFolderEditor_GOODS_TYPE_ID', fMasterDataSet.FieldByName
      ('GOODS_TYPE_ID').AsInteger);
    AppUserTempConfigStorage.IntValues.SetValue('GoodsFolderEditor_SERIAL_TYPE_ID', fMasterDataSet.FieldByName
      ('SERIAL_TYPE_ID').AsInteger);
    AppUserTempConfigStorage.IntValues.SetValue('GoodsFolderEditor_WEBGOODSTYPE_ID', fMasterDataSet.FieldByName
      ('WEBGOODSTYPE_ID').AsInteger);
  end;

  if CheckParams then
  begin
    fMasterDataSet.Post;
    if IBCQueryGoodsDSC.State in dsEditModes then
      IBCQueryGoodsDSC.Post;

    fMasterDataSet.UpdateTransaction.Commit;
    FGoodsID := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmGoodsFolderEditorDialog.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    IBCQueryGoodsType.Active := True;
    IBCQueryTemplate.Active := True;

    if fCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Creare inregistrare';
      ParentSerialTypeID := getParentSerialTypeid(FParentID);
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger := 1;
      fMasterDataSet.FieldByName('PARENTID').AsInteger := FParentID;
      fMasterDataSet.FieldByName('GOODS_TYPE_ID').AsInteger := FParentGoodsTypeID;
      fMasterDataSet.FieldByName('WEBGOODSTYPE_ID').AsInteger := FParentWEBGoodsTypeID;
      fMasterDataSet.FieldByName('USERID').AsInteger := UserID;
      fMasterDataSet.FieldByName('FLG_REQUIRE_CERTIFICAT').AsInteger := 0;
      fMasterDataSet.FieldByName('DELIVERY_TYPEID').AsInteger := FDeliveryTypeID;
      fMasterDataSet.FieldByName('DETAILS').AsString := '';

      fMasterDataSet.FieldByName('SERIAL_TYPE_ID').AsInteger := ParentSerialTypeID;

      fMasterDataSet.FieldByName('VAT').AsInteger := AppUserTempConfigStorage.IntValues.GetValue('GoodsFolderEditor_GOODS_VAT',
        20);
      fMasterDataSet.FieldByName('GOODS_TYPE_ID').AsInteger := ParentGoodsTypeID;
      fMasterDataSet.FieldByName('WEBGOODSTYPE_ID').AsInteger := ParentWEBGoodsTypeID;
      MasterDataSet.FieldByName('TEMPLATEID').AsInteger := -1;
    end
    else
    begin
      dtDialogTitle.Text := 'Modificare inregistrare';
      fMasterDataSet.Edit;
      
      if fMasterDataSet.FieldByName('SERIAL_TYPE_ID').AsInteger <= 0 then
        fMasterDataSet.FieldByName('SERIAL_TYPE_ID').AsInteger := ParentSerialTypeID;
    end;

    IBCQueryGoodsDSC.Active := True;
    IBCQueryWebGoodsType.Active := True;
    IBCQueryGST.Active := True;
    IBCQueryTypeGoodsDelivery.Active := True;


    IBCQueryGoodsCategories.Close;
    IBCQueryGoodsCategories.ParamByName('folderid').AsInteger := MasterDataSet.FieldByName('goodsid').AsInteger;
    IBCQueryGoodsCategories.Open;

    // filters open params
    IBCQueryFiltersParams.UpdateTransaction := fMasterDataSet.UpdateTransaction;
    IBCQueryFiltersParams.ParamByName('goodsid').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    IBCQueryFiltersParams.Active := True;

    cxPageControl1.ActivePageIndex := 0;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmGoodsFolderEditorDialog.sbCustomWebGoodsTypeClick(Sender: TObject);
begin
  ShowWebGoodsTypeDialog;
end;

procedure TfrmGoodsFolderEditorDialog.SetCashbackValue(const Value: Integer);
begin
  FCashbackValue := Value;
end;

procedure TfrmGoodsFolderEditorDialog.SetCreateNewRecord(const Value: Boolean);
begin
  fCreateNewRecord := Value;
end;

procedure TfrmGoodsFolderEditorDialog.SetDeliveryTypeID(const Value: Integer);
begin
  FDeliveryTypeID := Value;
end;

procedure TfrmGoodsFolderEditorDialog.SetGoodsID(const Value: Integer);
begin
  FGoodsID := Value;
end;

procedure TfrmGoodsFolderEditorDialog.SetParentGoodsTypeID(const Value: Integer);
begin
  FParentGoodsTypeID := Value;
end;

procedure TfrmGoodsFolderEditorDialog.SetParentID(const Value: Integer);
begin
  FParentID := Value;
end;

procedure TfrmGoodsFolderEditorDialog.SetParentSerialTypeID(const Value: Integer);
begin
  FParentSerialTypeID := Value;
end;

procedure TfrmGoodsFolderEditorDialog.SetParentWEBGoodsTypeID(const Value: Integer);
begin
  FParentWEBGoodsTypeID := Value;
end;

procedure TfrmGoodsFolderEditorDialog.ShowWebGoodsTypeDialog;
var
  editor: TfrmGoodsTypeDlg;
begin
  editor := TfrmGoodsTypeDlg.Create(Self);
  try
    editor.ShowModal;
    IBCQueryWebGoodsType.Refresh;
  finally
    editor.Free;
  end;
end;

procedure TfrmGoodsFolderEditorDialog.SpeedButton1Click(Sender: TObject);
var
  dialog: TfrmWebDescriptionTemplateDlg;
begin
  dialog := TfrmWebDescriptionTemplateDlg.Create(Self);
  try
    dialog.ShowModal;
    IBCQueryTemplate.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsFolderEditorDialog.WhenCancelForm;
begin
  if IBCQueryGoodsDSC.State in dsEditModes then
    IBCQueryGoodsDSC.Cancel;
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

