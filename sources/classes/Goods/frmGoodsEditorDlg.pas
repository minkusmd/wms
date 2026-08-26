unit frmGoodsEditorDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, Menus, cxEdit, cxLabel, DBAccess, IBC,
  MemDS, dxBar, cxBarEditItem, cxGridChartView, cxGridDBChartView, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGrid, cxDBEdit, cxDBLookupComboBox,
  cxContainer, StdCtrls, ComCtrls, cxButtonEdit, Buttons, ExtCtrls, cxButtons,
  dxStatusBar, frameGoodsEditDescriptionUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  cxDBData, cxCurrencyEdit, cxCalendar, cxClasses, cxMemo, cxGridTableView,
  cxGridCustomView, cxDropDownEdit, cxCalc, cxCheckBox, cxTextEdit, cxMaskEdit,
  cxLookupEdit, cxDBLookupEdit, System.Actions, Vcl.ActnList, Data.DB, cxCustomListBox, cxListBox, dxCoreGraphics,
  dxUIAClasses;

type
  TfrmGoodsEditorDialog = class(TSWNMasteredFormClass)
    cxPageControl: TPageControl;
    tbsGeneral: TTabSheet;
    tbsPriceHistory: TTabSheet;
    dxBarDockControl3: TdxBarDockControl;
    dxBarManagerGoods: TdxBarManager;
    dxBarManagerGoodsBar1: TdxBar;
    cxPageControlPH: TPageControl;
    tbsPH_Grid: TTabSheet;
    tbsPH_Chart: TTabSheet;
    IBCDataSourceUM: TIBCDataSource;
    IBCQueryUM: TIBCQuery;
    IBCDataSourceCurrency: TIBCDataSource;
    IBCQueryCurrency: TIBCQuery;
    IBCDataSourceGoodsType: TIBCDataSource;
    IBCDataSourceGST: TIBCDataSource;
    IBCQueryGST: TIBCQuery;
    IBCQueryPriceHistory: TIBCQuery;
    IBCDataSourcePriceHistory: TIBCDataSource;
    bbPH_Refresh: TdxBarButton;
    ridTable: TcxGridDBTableView;
    ridLevel: TcxGridLevel;
    rid: TcxGrid;
    cxGridPriceHistory_DATA: TcxGridDBColumn;
    cxGridPriceHistory_PRICE0: TcxGridDBColumn;
    cxGridPriceHistory_PRICE1: TcxGridDBColumn;
    cxGridPriceHistory_PRICE2: TcxGridDBColumn;
    cxGridPriceHistory_PRICE3: TcxGridDBColumn;
    cxGridPriceHistory_PRICE4: TcxGridDBColumn;
    cxGridPriceHistory_PRICE5: TcxGridDBColumn;
    cxGridPriceHistory_MODIFIED_BY_NAME: TcxGridDBColumn;
    cxGridPriceHistory_CURRENCY_NAME: TcxGridDBColumn;
    bePH_StartDate: TcxBarEditItem;
    bePH_EndDate: TcxBarEditItem;
    cxGridChartLevel: TcxGridLevel;
    cxGridChart: TcxGrid;
    cxGridChartDB: TcxGridDBChartView;
    cxGridChartDBSeries_Price4: TcxGridDBChartSeries;
    cxGridChartDBSeries_Price7: TcxGridDBChartSeries;
    lbCREATED_BY: TLabel;
    lbLastModify: TLabel;
    pnTitles: TPanel;
    mmTITLE: TcxDBMemo;
    cxGridPriceHistory_PRICE6: TcxGridDBColumn;
    cxGridPriceHistory_PRICE7: TcxGridDBColumn;
    cxLabel16: TLabel;
    lcbGoodsType1: TcxDBLookupComboBox;
    lcbUM: TcxDBLookupComboBox;
    cxLabel19: TLabel;
    cxLabel20: TLabel;
    cxLabel21: TLabel;
    lcbSerialNumber: TcxDBLookupComboBox;
    cmbWarranty: TcxDBComboBox;
    cbFLG_OLD: TcxDBCheckBox;
    cbFLG_REQUIRE_CERTIFICAT: TcxDBCheckBox;
    IBCQueryTypeGoodsDelivery: TIBCQuery;
    IBCDataSourceTypeGoodsDelivery: TIBCDataSource;
    Label6: TLabel;
    dtDialogTitle: TDialogTitle;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    beGoodsACNT: TcxButtonEdit;
    Label4: TLabel;
    bbNewURL: TdxBarButton;
    bbURLDelete: TdxBarButton;
    cbFLG_NEW: TcxDBCheckBox;
    cbFLG_PROMO: TcxDBCheckBox;
    lbVAT: TLabel;
    Label8: TLabel;
    cbFLG_SOCIAL: TcxDBCheckBox;
    dxStatusBar1: TdxStatusBar;
    IBCQueryGoodsType: TIBCQuery;
    cmbVAT: TcxDBComboBox;
    cbFLG_WEB_HIDE_COMPLECT_ITEMS: TcxDBCheckBox;
    TabSheet1: TTabSheet;
    IBCQueryGoodsRelatedGoods: TIBCQuery;
    IBCDataSourceRelatedGoods: TIBCDataSource;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1_GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1_GOODS_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1_PRICE_MDL: TcxGridDBColumn;
    cxGrid1DBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1DBTableView1_WEBGOODSTYPE: TcxGridDBColumn;
    tsSearchkeys: TTabSheet;
    IBCQuerySearchkeys: TIBCQuery;
    IBCDataSourceSearchkeys: TIBCDataSource;
    cxDBMemo1: TcxDBMemo;
    dxBarManagerGoodsBar3: TdxBar;
    dxBarDockSearchKeys: TdxBarDockControl;
    bbSaveSearchKeys: TdxBarButton;
    ActionList1: TActionList;
    actSaveSearchKeys: TAction;
    tbsDictionary: TTabSheet;
    IBCQueryGoodsDictionary: TIBCQuery;
    IBCDataSourceGoodsDictionary: TIBCDataSource;
    btnUpdateDict: TcxButton;
    cxGridDBTableViewDictionary: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGridDBTableViewDictionary_WORD: TcxGridDBColumn;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerGoodsBar2: TdxBar;
    bbGoodsTitleModify: TdxBarButton;
    cxGridDBTableViewDictionary_PRIORITY: TcxGridDBColumn;
    frameGoodsEditDescription1: TframeGoodsEditDescription;
    lcbGoodsAcnt: TcxDBLookupComboBox;
    IBCQueryGOODS_ACNT: TIBCQuery;
    IBCDataSourceGOODS_ACNT: TIBCDataSource;
    procedure actSaveSearchKeysExecute(Sender: TObject);
    procedure actSaveSearchKeysUpdate(Sender: TObject);
    procedure ceMargin1PropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure mmDETAILSEnter(Sender: TObject);
    procedure cxPageControlChange(Sender: TObject);
    procedure cxGridChartDBCategoriesGetValueDisplayText(Sender: TObject; const AValue: Variant; var ADisplayText: string);
    procedure cxGridChartDBGetValueHint(Sender: TcxGridChartView; ASeries: TcxGridChartSeries; AValueIndex: Integer; var AHint: string);
    procedure cxGridChartDBValueClick(Sender: TcxGridChartView; ASeries: TcxGridChartSeries; AValueIndex: Integer; var AHandled: Boolean);
    procedure bbPH_RefreshClick(Sender: TObject);
    procedure beGoodsACNTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure edDETAILSDblClick(Sender: TObject);
    procedure edDETAILSKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IBCQuerySearchkeysBeforePost(DataSet: TDataSet);
    procedure TabSheet1Show(Sender: TObject);
    procedure btnUpdateDictClick(Sender: TObject);
    procedure bbGoodsTitleModifyClick(Sender: TObject);
    procedure frameGoodsEditDescription1edCODEExit(Sender: TObject);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    fGoodsID: Integer;
    FParentID: Integer;
    FParentWEBGoodsTypeID: Integer;
//    function CheckGoodsSupplierCount(GoodsID: Integer): Integer;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure SetParentID(const Value: Integer);
    function CheckParams: Boolean;
    procedure OpenPriceHistoryData;
    procedure OpenPriceHistoryWithDateFilter;
    procedure SelectGoodsAcnt;
    procedure CloseAdditionalDataSources;
    procedure CopyTitle2Detail;
//    procedure DoCreateDefaultSupplierGoodsCode(GoodsID: Integer);
    procedure SetParentWEBGoodsTypeID(const Value: Integer);
    procedure ShowLastModifyDateTime;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    procedure SelectGoodsAcnt2(GoodsID: Integer);
    { Public declarations }
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
    property GoodsID: Integer read fGoodsID;
    property ParentID: Integer read FParentID write SetParentID;
    property ParentWEBGoodsTypeID: Integer read FParentWEBGoodsTypeID write SetParentWEBGoodsTypeID;
  end;

  TGoodsParentInfo = class
  private
    fWEB_GOODS_TYPE_ID: Integer;
    fSERIAL_TYPE_ID: Integer;
    fFLG_REQUIRE_CERTIFICAT: Integer;
    fDelivery_TypeID: Integer;
  public
    constructor Create;
    procedure LoadInfo(const ParentID: Integer);
    function Get_WEB_GOODS_TYPE_ID(const DefaultValue: Integer): Integer;
    function Get_SERIAL_TYPE_ID(const DefaultValue: Integer): Integer;
    function Get_FLG_REQUIRE_CERTIFICAT: Integer;
  end;

implementation

uses
  SWNUtils, SWNConst, frmGoodsACNTBrowser, SWNSecurityFlags, DataModuleDB,
  SWNValueStorageUnit, SWNGoodsUtils, frmGoodsRelatedBrowserUnit;

{$R *.dfm}

procedure TfrmGoodsEditorDialog.actSaveSearchKeysExecute(Sender: TObject);
begin
  IBCQuerySearchkeys.Post;
end;

procedure TfrmGoodsEditorDialog.actSaveSearchKeysUpdate(Sender: TObject);
begin
  actSaveSearchKeys.Enabled := (IBCQuerySearchkeys.State in dsEditModes);
end;

{ TfrmGoodsEditorDialog }

procedure TfrmGoodsEditorDialog.bbGoodsTitleModifyClick(Sender: TObject);
begin
  if (TcxCustomEdit(ActiveControl.Owner) = frameGoodsEditDescription1.edCODE) then  begin
    SelectNext(frameGoodsEditDescription1.edCode, True, True);
    SelectNext(frameGoodsEditDescription1.edCode, False, True);
  end;

  if (TcxCustomEdit(ActiveControl.Owner) = frameGoodsEditDescription1.edBASE_PARAM) then begin
    SelectNext(frameGoodsEditDescription1.edBASE_PARAM, True, True);
    SelectNext(frameGoodsEditDescription1.edBASE_PARAM, false, True);
  end;

  if (TcxCustomEdit(ActiveControl.Owner) = frameGoodsEditDescription1.edDETAILS) then begin
    SelectNext(frameGoodsEditDescription1.edDETAILS, True, True);
    SelectNext(frameGoodsEditDescription1.edDETAILS, false, True);
  end;

  if (fMasterDataSet.Active) and not (fMasterDataSet.State in [dsEdit, dsInsert]) then
    fMasterDataSet.Edit;

  fMasterDataSet.fieldByName('TITLE').AsString := frameGoodsEditDescription1.lbWebNameRo.Caption;
end;

procedure TfrmGoodsEditorDialog.bbPH_RefreshClick(Sender: TObject);
begin
  OpenPriceHistoryWithDateFilter;
end;

procedure TfrmGoodsEditorDialog.beGoodsACNTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if (AButtonIndex = 0) then
    SelectGoodsAcnt;
  if (AButtonIndex = 1) then
    SelectGoodsAcnt2(fMasterDataSet.FieldByName('GOODSID').AsInteger);
end;

procedure TfrmGoodsEditorDialog.ceMargin1PropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if (DisplayValue = NULL) or (DisplayValue < 0) or (DisplayValue >= 50) then
  begin
    Error := True;
    ErrorText := 'Adaos comercial gresit!';
  end;
end;

function TfrmGoodsEditorDialog.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  ErrorStr := '';
  Result := False;

  if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsString = '') then
    AddErrorToStr(ErrorStr, 'Denumire!');

  if fMasterDataSet.FieldByName('GOODS_ACNT_ID').IsNull then
    AddErrorToStr(ErrorStr, 'Denumirea pentru facturi!');

  if fMasterDataSet.FieldByName('GOODS_TYPE_ID').IsNull then
    AddErrorToStr(ErrorStr, 'Tip produs!');

  if fMasterDataSet.FieldByName('UMID').IsNull then
    AddErrorToStr(ErrorStr, 'Unitate metrica!');

  if fMasterDataSet.FieldByName('SERIAL_TYPE_ID').IsNull then
    AddErrorToStr(ErrorStr, 'Metoda de evidenta!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmGoodsEditorDialog.CloseAdditionalDataSources;
begin
  IBCQueryUM.Close;
  IBCQueryCurrency.Close;
  IBCQueryGST.Close;
end;

procedure TfrmGoodsEditorDialog.CopyTitle2Detail;
begin
  fMasterDataSet.FieldByName('DETAILS').AsString := fMasterDataSet.FieldByName('TITLE').AsString;
end;

procedure TfrmGoodsEditorDialog.cxGridChartDBCategoriesGetValueDisplayText(Sender: TObject; const AValue: Variant; var ADisplayText: string);
begin
  ADisplayText := FormatDateTime('dd.mm.yyyy', AValue);
end;

procedure TfrmGoodsEditorDialog.cxGridChartDBGetValueHint(Sender: TcxGridChartView; ASeries: TcxGridChartSeries; AValueIndex: Integer; var AHint: string);
begin
  AHint := ASeries.GetDisplayText + #13#10 + 'Цена: ' + FloatToStr(ASeries.Values[AValueIndex]);
end;

procedure TfrmGoodsEditorDialog.cxGridChartDBValueClick(Sender: TcxGridChartView; ASeries: TcxGridChartSeries; AValueIndex: Integer; var AHandled: Boolean);
begin
//  cxGridPriceHistoryTable.DataController.FocusedRecordIndex := AValueIndex;
//  cxGridPriceHistoryTable.Columns[ASeries.Index + 2].Focused := True;
  cxPageControlPH.ActivePageIndex := 0;
end;

procedure TfrmGoodsEditorDialog.cxPageControlChange(Sender: TObject);
begin
  if (cxPageControl.ActivePage = tbsPriceHistory) and (not IBCQueryPriceHistory.Active) then
    OpenPriceHistoryData;
end;

//procedure TfrmGoodsEditorDialog.DoCreateDefaultSupplierGoodsCode(GoodsID: Integer);
//var
//  q: TIBCQuery;
//begin
//  q := TIBCQuery.Create(self);
//  try
//    q.SQL.Text := 'EXECUTE PROCEDURE CREATE_DEF_SUPPLIER_GOODS_CODE(:GOODSID)';
//    q.Transaction := fMasterDataSet.UpdateTransaction;
//    q.AutoCommit := False;
//    q.ParamByName('GOODSID').AsInteger := GoodsID;
//    q.ExecSQL;
//  finally
//    q.Free;
//  end;
//end;

procedure TfrmGoodsEditorDialog.edDETAILSDblClick(Sender: TObject);
begin
  CopyTitle2Detail;
end;

procedure TfrmGoodsEditorDialog.edDETAILSKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = VK_RETURN) and (ssCtrl in Shift)) then
    CopyTitle2Detail;

end;

procedure TfrmGoodsEditorDialog.BindingDataSource;
begin
  inherited;

  FParentID := 0;
  FParentWEBGoodsTypeID := 0;

  mmTITLE.DataBinding.DataSource := fMasterDataSource;

  IBCQueryPriceHistory.Connection := fIBCConnection;
  IBCQueryPriceHistory.MasterSource := fMasterDataSource;

  lcbGoodsType1.DataBinding.DataSource := fMasterDataSource;
  lcbUM.DataBinding.DataSource := fMasterDataSource;
  cmbWarranty.DataBinding.DataSource := fMasterDataSource;
  lcbSerialNumber.DataBinding.DataSource := fMasterDataSource;
  cbFLG_OLD.DataBinding.DataSource := fMasterDataSource;
  cbFLG_REQUIRE_CERTIFICAT.DataBinding.DataSource := fMasterDataSource;

  cmbVAT.DataBinding.DataSource := fMasterDataSource;

  // setup database
  IBCQueryUM.Connection := fIBCConnection;
  IBCQueryCurrency.Connection := fIBCConnection;

  frameGoodsEditDescription1.IBCDataSourceWebGoodsType.DataSet.Open;

  FCreateNewRecord := False;
  fGoodsID := -1;

  cxPageControlPH.ActivePageIndex := 0;

  bePH_StartDate.EditValue := NOW;
  bePH_EndDate.EditValue := NOW;

  // Setup
  cbFLG_NEW.DataBinding.DataSource := fMasterDataSource;
  cbFLG_PROMO.DataBinding.DataSource := fMasterDataSource;
  cbFLG_SOCIAL.DataBinding.DataSource := fMasterDataSource;
  cbFLG_WEB_HIDE_COMPLECT_ITEMS.DataBinding.DataSource := fMasterDataSource;

  IBCQuerySearchkeys.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQuerySearchkeys.MasterSource := fMasterDataSource;
  IBCQuerySearchkeys.Open;

  lcbGoodsAcnt.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmGoodsEditorDialog.btnUpdateDictClick(Sender: TObject);
begin
  dmdb.ExecuteQuery('EXECUTE PROCEDURE UPDATE_GOODS_DICTIONARY(:goodsid, 0)', [fMasterDataSet.FieldByName('GOODSID').AsInteger]);
  IBCQueryGoodsDictionary.Refresh;
end;

procedure TfrmGoodsEditorDialog.frameGoodsEditDescription1edCODEExit(Sender:
    TObject);
begin
  frameGoodsEditDescription1.edCODEExit(Sender);
end;

procedure TfrmGoodsEditorDialog.IBCQuerySearchkeysBeforePost(DataSet: TDataSet);
begin
//  DataSet.FieldByName('SEARCHKEYS').AsString := StripUnwantedText(DataSet.FieldByName('SEARCHKEYS').AsString);
end;

function TfrmGoodsEditorDialog.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    if not (fMasterDataSet.State in dsEditModes) then
      fMasterDataSet.Edit;

    if fMasterDataSet.FieldByName('CODE_RU').AsString = '' then
      fMasterDataSet.FieldByName('CODE_RU').AsString := fMasterDataSet.FieldByName('CODE').AsString;
    if fMasterDataSet.FieldByName('BASE_PARAM_RU').AsString = '' then
      fMasterDataSet.FieldByName('BASE_PARAM_RU').AsString := fMasterDataSet.FieldByName('BASE_PARAM').AsString;
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;

    try
      if not fMasterDataSet.UpdateTransaction.Active then
        fMasterDataSet.UpdateTransaction.StartTransaction;

      GenerateSeoData(fMasterDataSet.FieldByName('GOODSID').AsInteger, fMasterDataSet.UpdateTransaction);

      GenerateSeoData(fMasterDataSet.FieldByName('GOODSID').AsInteger, fMasterDataSet.UpdateTransaction);
      fMasterDataSet.UpdateTransaction.Commit;
    except
      on e: Exception do begin
        MessageDlg('Ошибка при формирование seo данных', mtError, [mbOK], 0);
        raise;
      end;
    end;


    if FCreateNewRecord then
    begin
      // save values as default
      AppUserTempConfigStorage.IntValues.SetValue('GoodsEditor_WEBGOODSTYPE_ID', fMasterDataSet.FieldByName('WEBGOODSTYPE_ID').AsInteger);

      AppUserTempConfigStorage.TextValues.SetValue('GoodsEditor_CODE', fMasterDataSet.FieldByName('CODE').AsString);
      AppUserTempConfigStorage.IntValues.SetValue('GoodsEditor_CURRENCYID', fMasterDataSet.FieldByName('CURRENCYID').AsInteger);
      AppUserTempConfigStorage.IntValues.SetValue('GoodsEditor_GOODS_TYPE_ID', fMasterDataSet.FieldByName('GOODS_TYPE_ID').AsInteger);
      AppUserTempConfigStorage.IntValues.SetValue('GoodsEditor_VENDOR_ID', fMasterDataSet.FieldByName('VENDOR_ID').AsInteger);
      AppUserTempConfigStorage.IntValues.SetValue('GoodsEditor_UMID', fMasterDataSet.FieldByName('UMID').AsInteger);
      AppUserTempConfigStorage.IntValues.SetValue('GoodsEditor_WARRANTY', fMasterDataSet.FieldByName('WARRANTY').AsInteger);
      AppUserTempConfigStorage.IntValues.SetValue('GoodsEditor_SERIAL_TYPE_ID', fMasterDataSet.FieldByName('SERIAL_TYPE_ID').AsInteger);

      // permament storage values
      AppUserConfigStorage.IntValues.SetValue('GoodsEditor_VAT', fMasterDataSet.FieldByName('VAT').AsInteger);
    end;
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmGoodsEditorDialog.LoadStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    // form position
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
//      Self.Position := poDefault;
    // read column visibility and width
      if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      begin
//      AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridPriceHistoryTable);
      end;
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmGoodsEditorDialog.mmDETAILSEnter(Sender: TObject);
begin
  if fMasterDataSet.FieldByName('DETAILS').IsNull or (fMasterDataSet.FieldByName('DETAILS').AsString = '') then
    fMasterDataSet.FieldByName('DETAILS').AsString := fMasterDataSet.FieldByName('TITLE').AsString;
end;

procedure TfrmGoodsEditorDialog.OpenPriceHistoryData;
begin
  // open price history data
  IBCQueryPriceHistory.Active := True;
end;

procedure TfrmGoodsEditorDialog.OpenPriceHistoryWithDateFilter;
begin
  IBCQueryPriceHistory.Close;
  IBCQueryPriceHistory.FilterSQL := '(CAST(DATA AS DATE)>=:StartDate ) and (CAST(DATA AS DATE)<=:EndDate)';
  IBCQueryPriceHistory.ParamByName('StartDate').AsDate := bePH_StartDate.EditValue;
  IBCQueryPriceHistory.ParamByName('EndDate').AsDate := bePH_EndDate.EditValue;
  IBCQueryPriceHistory.Open;
end;

procedure TfrmGoodsEditorDialog.Prepare;
var
  goodsInfo: TGoodsParentInfo;
begin
  if not fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.StartTransaction;

  try
    with frameGoodsEditDescription1 do
    begin
      cmbWEBGOODSTYPE_ID.TabStop := not FCreateNewRecord;
      lcbVENDOR_ID.TabStop := not FCreateNewRecord;
      edCODE_RU.TabStop := not FCreateNewRecord;
      edBASE_PARAM_RU.TabStop := not FCreateNewRecord;
    end;
    if FCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Inregistrare noua';

      goodsInfo := TGoodsParentInfo.Create;
      try
        goodsInfo.LoadInfo(FParentID);
        frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet := fMasterDataSet;
        fMasterDataSet.Insert;
        fMasterDataSet.FieldByName('PARENTID').AsInteger := FParentID;
        fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger := 0;
        fMasterDataSet.FieldByName('USERID').AsInteger := UserID;
        fMasterDataSet.FieldByName('CURRENCYID').AsInteger := AppUserTempConfigStorage.IntValues.GetValue('GoodsEditor_CURRENCYID', 840);
        fMasterDataSet.FieldByName('WARRANTY').AsInteger := AppUserTempConfigStorage.IntValues.GetValue('GoodsEditor_WARRANTY', 0);
        fMasterDataSet.FieldByName('GOODS_ACNT_ID').AsInteger := -1;
        fMasterDataSet.FieldByName('GOODS_TYPE_ID').AsInteger := AppUserTempConfigStorage.IntValues.GetValue('GoodsEditor_GOODS_TYPE_ID', 4201);
        fMasterDataSet.FieldByName('VENDOR_ID').AsInteger := AppUserTempConfigStorage.IntValues.GetValue('GoodsEditor_VENDOR_ID', -1);

        fMasterDataSet.FieldByName('SERIAL_TYPE_ID').AsInteger := goodsInfo.Get_SERIAL_TYPE_ID(AppUserTempConfigStorage.IntValues.GetValue('GoodsEditor_SERIAL_TYPE_ID', 4403));
        fMasterDataSet.FieldByName('WEBGOODSTYPE_ID').AsInteger := goodsInfo.Get_WEB_GOODS_TYPE_ID(-1);

        fMasterDataSet.FieldByName('VAT').AsInteger := AppUserConfigStorage.IntValues.GetValue('GoodsEditor_VAT', 20);

        fMasterDataSet.FieldByName('UMID').AsInteger := AppUserTempConfigStorage.IntValues.GetValue('GoodsEditor_UMID', 1);

        fMasterDataSet.FieldByName('PRICE1').AsFloat := 0;
        fMasterDataSet.FieldByName('PRICE2').AsFloat := 0;
        fMasterDataSet.FieldByName('PRICE3').AsFloat := 0;
        fMasterDataSet.FieldByName('PRICE4').AsFloat := 0;
        fMasterDataSet.FieldByName('PRICE5').AsFloat := 0;
        fMasterDataSet.FieldByName('FLG_OLD').AsInteger := 0;
        fMasterDataSet.FieldByName('FLG_REQUIRE_CERTIFICAT').AsInteger := goodsInfo.Get_FLG_REQUIRE_CERTIFICAT;
        fMasterDataSet.FieldByName('FLG_PRICE_NBM').AsInteger := 0;
        beGoodsACNT.Text := dmDB.GetGoodsAcntDisplayName(fMasterDataSet.FieldByName('GOODS_ACNT_ID').AsInteger);

        fMasterDataSet.FieldByName('Delivery_TypeID').AsInteger := goodsInfo.fDelivery_TypeID;
        fMasterDataSet.FieldByName('DELIVERY_TYPENAME').AsString := dmDB.GetSyssTitleByID(goodsInfo.fDelivery_TypeID);

      finally
        goodsInfo.Free;
      end;
    end
    else
    begin
      dtDialogTitle.Text := 'Modificare inregistrare';

      fMasterDataSet.Edit;
      beGoodsACNT.Text := fMasterDataSet.FieldByName('NAMEACNT').AsString;
      dxStatusBar1.Panels[0].Text := 'Creat de: ' + fMasterDataSet.FieldByName('USER_FULLNAME').AsString;
      dxStatusBar1.Panels[1].Text := 'Data crearii: ' + fMasterDataSet.FieldByName('CREATE_DATE').AsString;
    end;
    IBCQueryUM.Active := True;
    IBCQueryCurrency.Active := True;
    IBCQueryGST.Active := True;
    IBCQueryTypeGoodsDelivery.Active := True;
    IBCQueryGoodsType.Active := True;

    IBCQueryGoodsDictionary.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    IBCQueryGoodsDictionary.Open;
//    IBCQueryVAT.Active := True;

    ShowLastModifyDateTime;

    lbCREATED_BY.Caption := fMasterDataSet.FieldByName('USER_FULLNAME').AsString;
    if fMasterDataSet.FieldByName('GOODS_ACNT_ID').AsInteger = -1 then
      beGoodsACNT.Style.Font.Color := clRed;

    if fMasterDataSet.FieldByName('VAT').AsInteger <> 20 then
      lbVAT.Font.Color := clRed;

  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    CloseAdditionalDataSources;
    raise;
  end;

  frameGoodsEditDescription1.IBCDataSourceGOODS.DataSet := fMasterDataSet;

  cxPageControl.ActivePage := tbsGeneral;

  frameGoodsEditDescription1.UpdatelbWebName;
end;

procedure TfrmGoodsEditorDialog.SaveStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmGoodsEditorDialog.SelectGoodsAcnt;
var
  goodsACNT: TfrmGoodsACNTDlg;
begin
  goodsACNT := TfrmGoodsACNTDlg.Create(Self);
  try
    if SecurityFlagEnabled(cSecurityFlag_Справочники_НДН_Изменение_наименования_для_накладной) then
    begin
      AppUserConfigStorage.OpenSection(Self.Name + 'GOODS_ACNT_ID');
      try
        AppUserConfigStorage.IntValues.GetValue(Self.Name + 'GOODS_ACNT_ID', goodsACNT.GoodsAcntID)//          store column visibility and width
      finally
        AppUserConfigStorage.CloseSection;
      end;

      if goodsACNT.SelectGoodsAcnt(fMasterDataSet.FieldByName('GOODS_ACNT_ID').AsInteger) then
      begin
        fMasterDataSet.FieldByName('GOODS_ACNT_ID').AsInteger := goodsACNT.GoodsAcntID;
        beGoodsACNT.Text := goodsACNT.GoodsAcntTitle;

        AppUserConfigStorage.OpenSection(Self.Name + 'GOODS_ACNT_ID');
        try
          AppUserConfigStorage.IntValues.SetValue(Self.Name + 'GOODS_ACNT_ID', goodsACNT.GoodsAcntID)//          store column visibility and width
        finally
          AppUserConfigStorage.CloseSection;
        end;

      end;
    end
    else
      goodsACNT.BrowseGoodsACNT(fMasterDataSet.FieldByName('GOODS_ACNT_ID').AsInteger);
  finally
    goodsACNT.Free;
  end;
end;

procedure TfrmGoodsEditorDialog.SelectGoodsAcnt2(GoodsID: Integer);
begin
//  var d:=TGoodsAcnt2Dlg.Create(self);
//  try
//    d.Showmodal;
//  finally
//    d.Free;
//  end;

end;

procedure TfrmGoodsEditorDialog.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmGoodsEditorDialog.SetParentID(const Value: Integer);
begin
  FParentID := Value;
end;

procedure TfrmGoodsEditorDialog.SetParentWEBGoodsTypeID(const Value: Integer);
begin
  FParentWEBGoodsTypeID := Value;
end;

procedure TfrmGoodsEditorDialog.SetupSecurityItems;
begin
  // goods property
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Изменение_характеристик_товара) then
  begin
    mmTITLE.Enabled := False;

    lcbGoodsType1.Enabled := False;
    lcbUM.Enabled := False;
    cmbWarranty.Enabled := False;

    cbFLG_OLD.Enabled := False;
    cbFLG_REQUIRE_CERTIFICAT.Enabled := False;
  end;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Наименование_для_накладных) then
  begin
    beGoodsACNT.Properties.Buttons[0].Visible := False;
    beGoodsACNT.Properties.ClickKey := 0;
  end;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Тип_учета_товара) then
  begin
    lcbSerialNumber.Enabled := False;
  end;

  // currency
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара) then
  begin
//    lcbCurrency.Enabled := False;
    tbsPriceHistory.TabVisible := False;
  end;

  // Price columns
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_0) then
  begin
    cxGridPriceHistory_PRICE7.Visible := False;
    cxGridChartDBSeries_Price7.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_1) then
  begin
    cxGridPriceHistory_PRICE1.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_2) then
  begin
    cxGridPriceHistory_PRICE2.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_3) then
  begin
    cxGridPriceHistory_PRICE3.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_4) then
  begin
    cxGridPriceHistory_PRICE4.Visible := False;
    cxGridChartDBSeries_Price4.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_5) then
  begin
    cxGridPriceHistory_PRICE7.Visible := False;
    cxGridChartDBSeries_Price7.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_6) then
  begin
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_7) then
  begin
  end;
  btnOk.Visible := SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Изменение_характеристик_товара);
end;

procedure TfrmGoodsEditorDialog.ShowLastModifyDateTime;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT FIRST 1 DATA, (SELECT FULL_NAME FROM TS_USERS WHERE USERID=MODIFIED_BY)');
    Query.SQL.Add('FROM TS_GOODS_PRICE_HISTORY');
    Query.SQL.Add('WHERE GOODSID=:id ORDER BY DATA DESC');
    Query.ParamByName('id').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    Query.ExecSQL;
    if Query.Eof then
      lbLastModify.Caption := ''
    else
    begin
      lbLastModify.Caption := Format('%s - %s', [FormatDateTime('dd.mm.yyyy HH:NN', Query.Fields[0].AsDateTime), Query.Fields[1].AsString]);
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmGoodsEditorDialog.TabSheet1Show(Sender: TObject);
begin
  IBCQueryGoodsRelatedGoods.Close;
  IBCQueryGoodsRelatedGoods.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
  IBCQueryGoodsRelatedGoods.Open;
end;

procedure TfrmGoodsEditorDialog.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
  
  fMasterDataSet.Cancel;
  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Rollback;
  CloseAdditionalDataSources;
end;

{ TGoodsParentInfo }

constructor TGoodsParentInfo.Create;
begin
  fWEB_GOODS_TYPE_ID := -1;
  fSERIAL_TYPE_ID := -1;
  fFLG_REQUIRE_CERTIFICAT := 0;
end;

function TGoodsParentInfo.Get_FLG_REQUIRE_CERTIFICAT: Integer;
begin
  Result := fFLG_REQUIRE_CERTIFICAT;
end;

function TGoodsParentInfo.Get_SERIAL_TYPE_ID(const DefaultValue: Integer): Integer;
begin
  if fSERIAL_TYPE_ID = -1 then
    Result := DefaultValue
  else
    Result := fSERIAL_TYPE_ID;
end;

function TGoodsParentInfo.Get_WEB_GOODS_TYPE_ID(const DefaultValue: Integer): Integer;
begin
  if fWEB_GOODS_TYPE_ID = -1 then
    Result := DefaultValue
  else
    Result := fWEB_GOODS_TYPE_ID;
end;

procedure TGoodsParentInfo.LoadInfo(const ParentID: Integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT WEBGOODSTYPE_ID, SERIAL_TYPE_ID, DELIVERY_TYPEID, ');
    Query.SQL.Add('GET_FLG_VALUE(FLAGS,4)'); // FLG_REQUIRE_CERTIFICAT
    Query.SQL.Add('FROM TS_GOODS WHERE GOODSID=:ID');
    Query.ParamByName('ID').AsInteger := ParentID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      fWEB_GOODS_TYPE_ID := Query.Fields[0].AsInteger;
      fSERIAL_TYPE_ID := Query.Fields[1].AsInteger;
      fDelivery_TypeID := Query.Fields[2].AsInteger;
      fFLG_REQUIRE_CERTIFICAT := Query.Fields[3].AsInteger;

    end;
  finally
    Query.Free;
  end;
end;

end.

