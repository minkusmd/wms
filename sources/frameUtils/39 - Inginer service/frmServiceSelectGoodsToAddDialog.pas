unit frmServiceSelectGoodsToAddDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, DB, IBC, cxGraphics, Menus, cxLookAndFeelPainters, StdCtrls,
  cxButtons, cxButtonEdit, frameGoodsStockUnit, cxDBLabel, cxDBEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxDropDownEdit, cxTextEdit,
  cxMaskEdit, cxCalc, cxCheckBox, cxPC, cxControls, cxContainer, cxEdit,
  ExtCtrls, cxTL, DialogTitle, cxStyles, cxLabel, cxCurrencyEdit, cxLookAndFeels,
  cxPCdxBarPopupMenu, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxBarBuiltInMenu;

type
  TGoodsTypeFilter = (gtfComplect, gtfNoComplect, gtfService, gtfNoService);

  TGoodsTypeFilterSet = set of TGoodsTypeFilter;

  TVerifyGoodsExistsProc = function(const GoodsID: integer): Boolean of object;

  TSelectGoodsAction = (acChangeACNT, acChangeGoods, acChangePrice, acChangeQTY, acChangeStock, acChangeActive, acChangeEU, acChangeEUK, acChangeWarranty);

  TSelectGoodsActionSet = set of TSelectGoodsAction;

  TfrmServiceSelectGoodsToAddDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    pcPageControl: TcxPageControl;
    tbsGoods: TcxTabSheet;
    tbsQtys: TcxTabSheet;
    lcbStock: TcxDBLookupComboBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    beGoods: TcxButtonEdit;
    lbQTY: TLabel;
    lbPrice: TLabel;
    lbSUMA: TLabel;
    lbWARRANTY: TLabel;
    cbFLG_ACNT: TcxDBCheckBox;
    cbFLG_ACTIVE: TcxDBCheckBox;
    cbWARRANTY: TcxDBComboBox;
    lbCURRENCY_NAME: TcxDBLabel;
    frameGoodsStock: TframeGoodsStock;
    edGOODSID: TcxDBTextEdit;
    imgWarning: TImage;
    lbGoodsExistsWarning: TLabel;
    edQTY: TcxDBMaskEdit;
    edPRICE: TcxDBCalcEdit;
    edSUMA: TcxDBCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cePRICEPropertiesEditValueChanged(Sender: TObject);
    procedure ceQTYPropertiesEditValueChanged(Sender: TObject);
    procedure ceSUMAPropertiesEditValueChanged(Sender: TObject);
    procedure pcPageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure pcPageControlChange(Sender: TObject);
    procedure beGoodsDblClick(Sender: TObject);
    procedure ceQTYPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure frameGoodsStockcxTreeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
  private
    { Private declarations }
    FAddNewGoods: Boolean;
    fJurnalDataSet: TIBCQuery;
    FSelectGoodsType: TGoodsTypeFilterSet;
    FCustomeSQLFilter: string;
    FOnVerifyGoodsExists: TVerifyGoodsExistsProc;
    fVisibleActions: TSelectGoodsActionSet;
    fAllowedActions: TSelectGoodsActionSet;
    fAutoOpenGoodsBrowser: Boolean;
    fAcntFlagVisible: Boolean;
    fDefaultPriceColumn: integer;
    fDocDataSet: TIBCQuery;
    procedure SetAddNewGoods(const Value: Boolean);
    function CheckParams: Boolean;
    procedure ShowSelectGoodsDialog;
    procedure SumaChanged;
    procedure PriceChanged2;
    procedure QtyChanged;
    procedure ShowGoodsQtyByStock;
    procedure WhenStockDblClick(const StockID: integer; const StockTitle: string);
    procedure SetSelectGoodsType(const Value: TGoodsTypeFilterSet);
    procedure CloseAdditionalDataSources;
    procedure SetOnVerifyGoodsExists(const Value: TVerifyGoodsExistsProc);
    procedure CheckIfGoodsExists(const GoodsID: integer);
    procedure PrepareView;
    procedure SetAllowActions(const Value: TSelectGoodsActionSet);
    procedure SetVisibleActions(const Value: TSelectGoodsActionSet);
    procedure SetAutoOpenGoodsBrowser(const Value: Boolean);
    function GoodsHasSNPNNumbers: Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const JurnalDataSet: TIBCQuery; const JurnalDataSource: TIBCDataSource; const DocDataSet: TIBCQuery); reintroduce;
    property AddNewGoods: Boolean read FAddNewGoods write SetAddNewGoods;
    property GoodsTypeFilter: TGoodsTypeFilterSet read FSelectGoodsType write SetSelectGoodsType;
    property AllowedActions: TSelectGoodsActionSet read fAllowedActions write SetAllowActions;
    property VisibleActions: TSelectGoodsActionSet read FVisibleActions write SetVisibleActions;
    property AutoOpenGoodsBrowser: Boolean read fAutoOpenGoodsBrowser write SetAutoOpenGoodsBrowser;
    property OnVerifyGoodsExists: TVerifyGoodsExistsProc read FOnVerifyGoodsExists write SetOnVerifyGoodsExists;
  end;

implementation

uses
  DataModuleAdditions, SWNUtils, SWNConst, SWNTypes, frmGoods,
  SWNValueStorageUnit, DataModuleDB, SWNSecurityFlags, SWNSecurity;

{$R *.dfm}

{ TfrmConfigurationSelectGoodsDlg }

procedure TfrmServiceSelectGoodsToAddDlg.beGoodsDblClick(Sender: TObject);
begin
  ShowSelectGoodsDialog;
end;

procedure TfrmServiceSelectGoodsToAddDlg.beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectGoodsDialog;
end;

procedure TfrmServiceSelectGoodsToAddDlg.cePRICEPropertiesEditValueChanged(Sender: TObject);
begin
  PriceChanged2;
end;

procedure TfrmServiceSelectGoodsToAddDlg.ceQTYPropertiesEditValueChanged(Sender: TObject);
begin
  QtyChanged;
end;

procedure TfrmServiceSelectGoodsToAddDlg.ceQTYPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if DisplayValue <= 0 then
  begin
    ShowErrorDialog('Valoare incorecta', 'Valorile nule sau negative sunt interzise!');
    DisplayValue := 1;
  end;
end;

procedure TfrmServiceSelectGoodsToAddDlg.ceSUMAPropertiesEditValueChanged(Sender: TObject);
begin
  SumaChanged;
end;

procedure TfrmServiceSelectGoodsToAddDlg.CheckIfGoodsExists(const GoodsID: integer);
var
  Exists: Boolean;
begin
  Exists := False;
  try
    if Assigned(FOnVerifyGoodsExists) then
      Exists := FOnVerifyGoodsExists(GoodsID);
  finally
    lbGoodsExistsWarning.Visible := Exists;
    imgWarning.Visible := Exists;
  end;
end;

function TfrmServiceSelectGoodsToAddDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;

  with fJurnalDataSet do
  begin
    if (FieldByName('GOODSID').isNull) or (FieldByName('GOODSID').AsInteger<=0) then
      AddErrorToStr(ErrorStr, 'Produsul nu este selectat!');
    if (FieldByName('DTDEP').isNull) or (FieldByName('DTDEP').AsInteger <= 0) then
      AddErrorToStr(ErrorStr, 'Depozitul nu este selectat!');
    if (FieldByName('QTY').isNull) or (FieldByName('QTY').AsFloat <= 0) then
      AddErrorToStr(ErrorStr, 'Cantitatea nu este indicata!');
    if (FieldByName('PRICE').isNull) then
      AddErrorToStr(ErrorStr, 'Pretul nu este indicat!');
    if (FieldByName('SUMA').isNull) then
      AddErrorToStr(ErrorStr, 'Suma nu este indicata!');
    if FieldByName('UMID').isNull then
      AddErrorToStr(ErrorStr, 'Unitatea de masura nu este indicata!');
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

constructor TfrmServiceSelectGoodsToAddDlg.Create(const AOwner: TComponent; const JurnalDataSet: TIBCQuery; const JurnalDataSource: TIBCDataSource; const DocDataSet: TIBCQuery);
begin
  inherited Create(AOwner);

  fAllowedActions := [acChangeACNT, acChangeGoods, acChangePrice, acChangeQTY, acChangeStock, acChangeActive, acChangeWarranty];

  fVisibleActions := fAllowedActions;

  FCustomeSQLFilter := '';

  fJurnalDataSet := JurnalDataSet;
  FSelectGoodsType := [];
  fDefaultPriceColumn := DocDataSet.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
  fDocDataSet := DocDataSet;

  lcbStock.DataBinding.DataSource := JurnalDataSource;
  edQTY.DataBinding.DataSource := JurnalDataSource;
  edPRICE.DataBinding.DataSource := JurnalDataSource;
  edSUMA.DataBinding.DataSource := JurnalDataSource;
  cbFLG_ACNT.DataBinding.DataSource := JurnalDataSource;
  cbFLG_ACTIVE.DataBinding.DataSource := JurnalDataSource;
  cbWARRANTY.DataBinding.DataSource := JurnalDataSource;
  edGOODSID.DataBinding.DataSource := JurnalDataSource;

  frameGoodsStock.OnStockDblClick := WhenStockDblClick;

  fAcntFlagVisible := False;
end;

procedure TfrmServiceSelectGoodsToAddDlg.CloseAdditionalDataSources;
begin
  dmDB.IBCQueryStocks.Close;
  dmDB.IBCQueryStocks.FilterSQL := '';
  dmDB.IBCQueryCurrency.Close;
end;

procedure TfrmServiceSelectGoodsToAddDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmServiceSelectGoodsToAddDlg.FormCreate(Sender: TObject);
begin
  FOnVerifyGoodsExists := nil;
  fAutoOpenGoodsBrowser := True;
  pcPageControl.ActivePageIndex := 0;
  FAddNewGoods := False;

  lbGoodsExistsWarning.Visible := False;
  imgWarning.Visible := False;
end;

procedure TfrmServiceSelectGoodsToAddDlg.frameGoodsStockcxTreeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
begin
  if ANode.Values[1] > 0 then
    AStyle := dmAdditions.cxStyle_Bold;
end;

function TfrmServiceSelectGoodsToAddDlg.GoodsHasSNPNNumbers: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := fJurnalDataSet.UpdateTransaction;
    Query.SQL.Add('SELECT');
    Query.SQL.Add('IIF(');
    Query.SQL.Add('EXISTS(SELECT SN FROM TDB_SN');
    Query.SQL.Add('WHERE DOCID=:DOCID AND DTDEP=:DTDEP AND CTDEP=:CTDEP AND');
    Query.SQL.Add('GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID AND GOODSID=:GOODSID)');
    Query.SQL.Add('OR');
    Query.SQL.Add('EXISTS(SELECT PARTNO FROM TDB_PARTS');
    Query.SQL.Add('WHERE DOCID=:DOCID AND DTDEP=:DTDEP AND CTDEP=:CTDEP AND');
    Query.SQL.Add('GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID AND GOODSID=:GOODSID)');
    Query.SQL.Add(',1,0)');
    Query.SQL.Add('FROM RDB$DATABASE');
        // params
    Query.ParamByName('DOCID').AsInteger := fJurnalDataSet.FieldByName('DOCID').AsInteger;
    Query.ParamByName('DTDEP').AsInteger := fJurnalDataSet.FieldByName('DTDEP').AsInteger;
    Query.ParamByName('CTDEP').AsInteger := fJurnalDataSet.FieldByName('CTDEP').AsInteger;
    Query.ParamByName('GOODSCOMPLECT_ID').AsInteger := fJurnalDataSet.FieldByName('GOODSCOMPLECT_ID').AsInteger;
    Query.ParamByName('GOODSID').AsInteger := fJurnalDataSet.FieldByName('GOODSID').AsInteger;
        // exec
    Query.ExecSQL;
    if not Query.Eof then
      Result := Query.Fields[0].AsInteger = 1;
  finally
    Query.Free;
  end;
end;

function TfrmServiceSelectGoodsToAddDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fJurnalDataSet.Post;
    fJurnalDataSet.UpdateTransaction.Commit;

    AppUserTempConfigStorage.IntValues.SetValue(Owner.Name + '_LastSelectedGoodsID', fJurnalDataSet.FieldByName('GOODSID').asInteger);

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmServiceSelectGoodsToAddDlg.pcPageControlChange(Sender: TObject);
begin
  if (pcPageControl.ActivePage = tbsQtys) and (frameGoodsStock.DataOpened = False) then
  begin
          // show stock info
    ShowGoodsQtyByStock;
  end;
end;

procedure TfrmServiceSelectGoodsToAddDlg.pcPageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
  AllowChange := (NewPage = tbsGoods) or ((NewPage = tbsQtys) and (not fJurnalDataSet.FieldByName('GOODSID').IsNull));
end;

procedure TfrmServiceSelectGoodsToAddDlg.Prepare;
begin
  PrepareView;

  fJurnalDataSet.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;

    dmDB.IBCQueryStocks.FilterSQL := 'STOCKID<>-1';
    dmDB.IBCQueryStocks.Active := True;

    if FAddNewGoods then
    begin
      dtDialogTitle.Text := 'Selectare marfa noua pentru adaugare';
      fJurnalDataSet.Append;

             // default values
      fJurnalDataSet.FieldByName('CTDEP').asInteger := -1;
      fJurnalDataSet.FieldByName('GOODSCOMPLECT_ID').asInteger := -1;

      fJurnalDataSet.FieldByName('DTDEP').asInteger := fDocDataSet.FieldByName('DTDEP').asInteger;
      fJurnalDataSet.FieldByName('CTDEP').asInteger := fDocDataSet.FieldByName('CTDEP').asInteger;

      fJurnalDataSet.FieldByName('QTY').asFloat := 1;
      fJurnalDataSet.FieldByName('PRICE').AsCurrency := 0;
      fJurnalDataSet.FieldByName('COST').asInteger := 0;
      fJurnalDataSet.FieldByName('SUMA').AsCurrency := 0;

      fJurnalDataSet.FieldByName('WARRANTY').asInteger := 0;

      fJurnalDataSet.FieldByName('STOCK_QTY').asInteger := 0;

      fJurnalDataSet.FieldByName('FLG_ACNT').asInteger := fDocDataSet.FieldByName('FLG_ACNT').asInteger;
      fJurnalDataSet.FieldByName('FLG_ACTIVE').asInteger := 1;
      fJurnalDataSet.FieldByName('FLG_READY').asInteger := 0;
      fJurnalDataSet.FieldByName('FLG_DELETE').asInteger := 0;
    end
    else
    begin
      dtDialogTitle.Text := 'Modificare marfa pentru configuratie';

             // verificam daca produsul dat are numere de serii, daca are, se interzice modificarea depozitului
      if GoodsHasSNPNNumbers then
      begin
        lcbStock.Enabled := False;
        beGoods.Enabled := False;
        imgWarning.Visible := True;
        lbGoodsExistsWarning.Visible := True;
        lbGoodsExistsWarning.Caption := 'Exista serii sau partizi!';
      end;

      fJurnalDataSet.Edit;
    end;

    beGoods.Text := fJurnalDataSet.FieldByName('GOODS_NAME').asString;

    if fAutoOpenGoodsBrowser and fJurnalDataSet.FieldByName('GOODSID').IsNull then
    begin
      ShowSelectGoodsDialog;
      if fJurnalDataSet.FieldByName('GOODSID').IsNull then
      begin
        ModalResult := mrCancel; // force to close dialog
        WhenCancelForm; // rollback transaction
      end;
    end;

    if not (SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Ручное_изменение_цен)) then
    begin
      edPRICE.Properties.readonly := TRUE;
      edSUMA.Properties.readonly := TRUE;
//      cbVAT.Properties.readonly := TRUE;
    end;

  except
    if fJurnalDataSet.State in dsEditModes then
      fJurnalDataSet.Cancel;
    fJurnalDataSet.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmServiceSelectGoodsToAddDlg.PrepareView;
var
  i: TSelectGoodsAction;
  Allow: Boolean;
  Vis: Boolean;
begin
  for i := Low(TSelectGoodsAction) to High(TSelectGoodsAction) do
  begin
    Allow := i in fAllowedActions;
    Vis := i in fVisibleActions;
    case i of
      acChangeACNT:
        begin
          cbFLG_ACNT.Enabled := Allow;
                              //cbFLG_ACNT.Visible:=Vis and fAcntFlagVisible;
        end;
      acChangeGoods:
        begin
          beGoods.Enabled := Allow;
          edGOODSID.Enabled := Allow;
        end;
      acChangePrice:
        begin
          edPRICE.Enabled := Allow;
          edSUMA.Enabled := Allow;
          lbCURRENCY_NAME.Enabled := Allow;
          edPRICE.Visible := Vis;
          edSUMA.Visible := Vis;
          lbCURRENCY_NAME.Visible := Vis;
          lbPrice.Visible := Vis;
          lbSUMA.Visible := Vis;
        end;
      acChangeQTY:
        begin
          edQTY.Enabled := Allow;
                            //edQTY.Visible:=Vis;
                            //lbQTY.Visible:=Vis;
        end;
      acChangeStock:
        begin
          lcbStock.Enabled := Allow;
          tbsQtys.TabVisible := Allow or Vis;
                              //lcbStock.Visible:=Vis;
        end;
      acChangeActive:
        begin
          cbFLG_ACTIVE.Enabled := Allow;
                               //cbFLG_ACTIVE.Visible:=Vis;
        end;
      acChangeWarranty:
        begin
          cbWARRANTY.Enabled := Allow;
                                 //cbWARRANTY.Visible:=Vis;
                                 //lbWARRANTY.Visible:=Vis;
        end;
    end;
  end;
end;

procedure TfrmServiceSelectGoodsToAddDlg.PriceChanged2;
var
  N: integer;
begin
  if not (fJurnalDataSet.State in dsEditModes) then
    Exit;

  N := fJurnalDataSet.FieldByName('QTY').asInteger;
  if N > 0 then
  begin
    fJurnalDataSet.FieldByName('SUMA').AsCurrency := fJurnalDataSet.FieldByName('PRICE').AsCurrency * N;
  end
  else
  begin
    fJurnalDataSet.FieldByName('SUMA').AsCurrency := 0;
  end;
end;

procedure TfrmServiceSelectGoodsToAddDlg.QtyChanged;
var
  N: integer;
begin
  if not (fJurnalDataSet.State in dsEditModes) then
    Exit;

  N := fJurnalDataSet.FieldByName('QTY').asInteger;
  if N > 0 then
  begin
    if fJurnalDataSet.FieldByName('PRICE').AsCurrency > 0 then
      fJurnalDataSet.FieldByName('SUMA').AsCurrency := fJurnalDataSet.FieldByName('PRICE').AsCurrency * N
    else if fJurnalDataSet.FieldByName('SUMA').AsCurrency > 0 then
      fJurnalDataSet.FieldByName('PRICE').AsCurrency := fJurnalDataSet.FieldByName('SUMA').AsCurrency / N;
  end
  else
  begin
    fJurnalDataSet.FieldByName('PRICE').AsCurrency := 0;
    fJurnalDataSet.FieldByName('SUMA').AsCurrency := 0;
  end;
end;

procedure TfrmServiceSelectGoodsToAddDlg.SetAddNewGoods(const Value: Boolean);
begin
  FAddNewGoods := Value;
end;

procedure TfrmServiceSelectGoodsToAddDlg.SetAllowActions(const Value: TSelectGoodsActionSet);
begin
  fAllowedActions := Value;
end;

procedure TfrmServiceSelectGoodsToAddDlg.SetAutoOpenGoodsBrowser(const Value: Boolean);
begin
  fAutoOpenGoodsBrowser := Value;
end;

procedure TfrmServiceSelectGoodsToAddDlg.SetOnVerifyGoodsExists(const Value: TVerifyGoodsExistsProc);
begin
  FOnVerifyGoodsExists := Value;
end;

procedure TfrmServiceSelectGoodsToAddDlg.SetSelectGoodsType(const Value: TGoodsTypeFilterSet);
var
  i: TGoodsTypeFilter;
  S: string;
begin
  FSelectGoodsType := Value;
  S := '';
  if (FSelectGoodsType = []) then
    S := ''
  else
    for i := Low(TGoodsTypeFilter) to High(TGoodsTypeFilter) do
      if i in FSelectGoodsType then
        case i of
          gtfComplect:
            begin
              if S <> '' then
                S := S + ' OR ';
              S := S + Format('(GOODS_TYPE_ID IN (%d,%d)) OR (FLG_FOLDER=1)', [cSYSS_GOODS_TYPE_Комплект, cSYSS_GOODS_TYPE_Комплект_услуг]);
            end;
          gtfNoComplect:
            begin
              if S <> '' then
                S := S + ' OR ';
              S := S + Format('(GOODS_TYPE_ID NOT IN (%d,%d)) OR (FLG_FOLDER=1)', [cSYSS_GOODS_TYPE_Комплект, cSYSS_GOODS_TYPE_Комплект_услуг]);  // No Set
            end;
//          gtfService:
//            begin
//              if S <> '' then
//                S := S + ' OR ';
//              S := S + Format('(GOODS_TYPE_ID=%d)', [cSYSS_GOODS_TYPE_Товары_для_сервиса]);
//            end;
//          gtfNoService:
//            begin
//              if S <> '' then
//                S := S + ' OR ';
//              S := S + Format('(GOODS_TYPE_ID<>%d)', [cSYSS_GOODS_TYPE_Товары_для_сервиса]); // Produse NOT FOR service
//            end;
        end;

  FCustomeSQLFilter := S;
end;

procedure TfrmServiceSelectGoodsToAddDlg.SetVisibleActions(const Value: TSelectGoodsActionSet);
begin
  FVisibleActions := Value;
end;

procedure TfrmServiceSelectGoodsToAddDlg.ShowGoodsQtyByStock;
begin
  frameGoodsStock.ShowStockForGoods(fJurnalDataSet.FieldByName('GOODSID').asInteger, dmDB.CurrentFirma, False);
end;

procedure TfrmServiceSelectGoodsToAddDlg.ShowSelectGoodsDialog;
var
  dialog: TfrmGoodsBrowser;
  tmpPrice: Currency;
  tmpRate: double;
  N: integer;
  toChangePrices: Boolean;
begin
  dialog := TfrmGoodsBrowser.Create(Parent);
  try
    dialog.CustomeSQLFilter := FCustomeSQLFilter;

    N := AppUserTempConfigStorage.IntValues.GetValue(Owner.Name + '_LastSelectedGoodsID', -1);
    if not fJurnalDataSet.FieldByName('GOODSID').IsNull then
      N := fJurnalDataSet.FieldByName('GOODSID').asInteger;

    if dialog.SelectGoods(N, False) then
    begin
             // check if exists
      if fJurnalDataSet.FieldByName('GOODSID').asInteger <> dialog.GoodsID then
        CheckIfGoodsExists(dialog.GoodsID);

      fJurnalDataSet.FieldByName('UMID').asInteger := dialog.GoodsUMID;

      fJurnalDataSet.FieldByName('STOCK_QTY').asFloat := dialog.GoodsQuantityAvailable;
      if fJurnalDataSet.FieldByName('QTY').asFloat <= 0 then
        fJurnalDataSet.FieldByName('QTY').asFloat := 1;

      fJurnalDataSet.FieldByName('WARRANTY').asInteger := dialog.GoodsWarranty;

             // transformam pretul orifginal a marfei in valuta documentului in dependenta de FLG_ACNT
      tmpRate := fDocDataSet.FieldByName('RATE').asFloat;

      if not dmDB.TransformCurrency2(fDocDataSet.FieldByName('DOCID').asInteger, dialog.GoodsPrice[fDefaultPriceColumn], dialog.GoodsPriceCurrencyID, fDocDataSet.FieldByName('CURRENCYID').asInteger, fDocDataSet.FieldByName('FLG_ACNT').AsInteger = 1, tmpPrice, tmpRate, True, True, fDefaultPriceColumn = 0) then
        tmpPrice := dialog.GoodsPrice[fDefaultPriceColumn];

             // updated! verificam daca preturile sunt diferite
      if (acChangePrice in fAllowedActions) and (fJurnalDataSet.FieldByName('PRICE').asCurrency <> tmpPrice) and (dialog.GoodsID = fJurnalDataSet.FieldByName('GOODSID').asInteger) then
      begin
        toChangePrices := (fJurnalDataSet.FieldByName('PRICE').asCurrency = 0) or (ShowAskDialog('Modificare pret', 'Pretul produsului selectat difera de pretul din jurnal. Doriti sa actualizati pretul?') = mrYes);
      end
      else
        toChangePrices := true;

      if toChangePrices then
      begin
        fJurnalDataSet.FieldByName('PRICE').asCurrency := tmpPrice;
                  // update 04.03.2011 - in COST se duce Pretul 0 in Lei
        if not dmDB.TransformCurrency2(fDocDataSet.FieldByName('DOCID').asInteger, dialog.GoodsPrice[0], dialog.GoodsPriceCurrencyID, 498, fDocDataSet.FieldByName('FLG_ACNT').AsInteger = 1, tmpPrice, tmpRate, True, True, True) then
          tmpPrice := dialog.GoodsPrice[fDefaultPriceColumn];
        fJurnalDataSet.FieldByName('COST').asCurrency := tmpPrice;
      end;

      fJurnalDataSet.FieldByName('GOODSID').asInteger := dialog.GoodsID;
      beGoods.Text := dialog.GoodsTitle;

      if pcPageControl.ActivePage = tbsQtys then
        frameGoodsStock.ShowStockForGoods(fJurnalDataSet.FieldByName('GOODSID').asInteger, dmDB.CurrentFirma)
      else
        frameGoodsStock.ClearView;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceSelectGoodsToAddDlg.SumaChanged;
var
  N: integer;
begin
  if not (fJurnalDataSet.State in dsEditModes) then
    Exit;

  N := fJurnalDataSet.FieldByName('QTY').asInteger;
  if N > 0 then
  begin
    fJurnalDataSet.FieldByName('PRICE').AsCurrency := fJurnalDataSet.FieldByName('SUMA').AsCurrency / N;
  end
  else
  begin
    fJurnalDataSet.FieldByName('PRICE').AsCurrency := 0;
  end;
end;

procedure TfrmServiceSelectGoodsToAddDlg.WhenCancelForm;
begin
  if fJurnalDataSet.State in dsEditModes then
    fJurnalDataSet.Cancel;
  fJurnalDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmServiceSelectGoodsToAddDlg.WhenStockDblClick(const StockID: integer; const StockTitle: string);
begin
  if (acChangeStock in fAllowedActions) then
    fJurnalDataSet.FieldByName('DTDEP').AsInteger := StockID;
end;

end.

