unit frmAddItemsToTenderUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, DB, IBC, Menus,
  StdCtrls, cxButtons, cxButtonEdit, frameGoodsStockUnit, cxDBLabel, cxDBEdit, cxDBLookupComboBox, cxTextEdit,
  cxMaskEdit, cxCalc, cxPC, cxEdit, ExtCtrls, cxTL, cxStyles, dxBar, DBAccess, dxBarBuiltInMenu, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxClasses, cxLookupEdit, cxDBLookupEdit,
  cxDropDownEdit, cxLabel, cxCheckBox, SWNConst;

type
  TGoodsTypeFilter = (gtfComplect, gtfNoComplect, gtfService, gtfNoService);

  TGoodsTypeFilterSet = set of TGoodsTypeFilter;

  TVerifyGoodsExistsProc = function(const GoodsID: integer): Boolean of object;

  TSelectGoodsActionSet = set of TSelectGoodsAction;

  TfrmAddItemsToTender = class(TSWNCustomForm)
    tcxdblookupcombo: TPanel;
    cxLabel1: TLabel;
    pcPageControl: TcxPageControl;
    tbsGoods: TcxTabSheet;
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
    edGOODSID: TcxDBTextEdit;
    edPRICE: TcxDBCalcEdit;
    edSUMA: TcxDBCalcEdit;
    edQTY: TcxDBCalcEdit;
    Label2: TLabel;
    cbVAT: TcxDBCalcEdit;
    cxButton1: TcxButton;
    dxBarManager1: TdxBarManager;
    bb1: TdxBarButton;
    bb2: TdxBarButton;
    bb3: TdxBarButton;
    bb4: TdxBarButton;
    bb5: TdxBarButton;
    bb6: TdxBarButton;
    bb7: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    teCPV: TcxDBTextEdit;
    Label1: TLabel;
    lbCPV: TLabel;
    teDenBun: TcxDBTextEdit;
    Label3: TLabel;
    teFDA: TcxDBTextEdit;
    Label4: TLabel;
    teCountry: TcxDBTextEdit;
    Label5: TLabel;
    Label6: TLabel;
    teManufacturer: TcxDBTextEdit;
    Label8: TLabel;
    teStandart: TcxDBTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cePRICEPropertiesEditValueChanged(Sender: TObject);
    procedure ceQTYPropertiesEditValueChanged(Sender: TObject);
    procedure ceSUMAPropertiesEditValueChanged(Sender: TObject);
    procedure pcPageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure beGoodsDblClick(Sender: TObject);
    procedure ceQTYPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var
      Error: Boolean);
    procedure frameGoodsStockcxTreeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn;
      ANode: TcxTreeListNode; var AStyle: TcxStyle);
    procedure bb1Click(Sender: TObject);
  private
    { Private declarations }
    FAddNewGoods: Boolean;
    fJurnalDataSet: TIBCQuery;
    fParentGoodsID: integer;
    FSelectGoodsType: TGoodsTypeFilterSet;
    FCustomeSQLFilter: string;
    FOnVerifyGoodsExists: TVerifyGoodsExistsProc;
    fVisibleActions: TSelectGoodsActionSet;
    fAllowedActions: TSelectGoodsActionSet;
    fAutoOpenGoodsBrowser: Boolean;
    fAcntFlagVisible: Boolean;
    fDefaultPriceColumn: integer;
    fSelectedGoodsCurrencyID: Integer;
    fHasAllPrices: Boolean;
    fSelectedGoodsPrice: array[0..7] of Currency;
    FCustomDocID: Integer;
    fCurrentDoc_DocID: Integer;
    fCurrentDoc_CurrencyID: Integer;
    fCurrentDoc_FLG_ACNT: Integer;
    procedure ReadCurrentDocProps;
    function ReadCustomDocProps: Boolean;
    procedure SetAddNewGoods(const Value: Boolean);
    function CheckParams: Boolean;
    procedure ShowSelectGoodsDialog;
    procedure SumaChanged;
    procedure PriceChanged2;
    procedure QtyChanged;
    procedure SetSelectGoodsType(const Value: TGoodsTypeFilterSet);
    procedure CloseAdditionalDataSources;
    procedure SetOnVerifyGoodsExists(const Value: TVerifyGoodsExistsProc);
    procedure CheckIfGoodsExists(const GoodsID: integer);
    procedure PrepareView;
    procedure SetAllowActions(const Value: TSelectGoodsActionSet);
    procedure SetVisibleActions(const Value: TSelectGoodsActionSet);
    procedure SetAutoOpenGoodsBrowser(const Value: Boolean);
    procedure SetDefaultPriceColumn(const Value: integer);
    procedure ChangeGoodsPrice(const NewGoodsID: Integer; const NewPrice: Currency; const CurrencyID: integer;
      const Silent: Boolean = false);
    function LoadAllPrices(const GoodsID: integer): Boolean;
    procedure WhenFLG_ACTIVE_Changed(Sender: TObject);
    procedure FLG_ACTIVE_Changed_Peremeshenie;
    procedure SetupQtyFields;
    procedure SetCustomDocID(const Value: Integer);
  protected
    procedure CheckGoodsFlgActive(fJurnalDataSet: TIBCQuery);
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const JurnalDataSet: TIBCQuery; const JurnalDataSource:
      TIBCDataSource; const ParentGoodsID: integer = -1); reintroduce;
    procedure ShowGoodsPopup(SearchCriteria: string);
    property AddNewGoods: Boolean read FAddNewGoods write SetAddNewGoods;
    property GoodsTypeFilter: TGoodsTypeFilterSet read FSelectGoodsType write SetSelectGoodsType;
    property DefaultPriceColumn: integer read fDefaultPriceColumn write SetDefaultPriceColumn;
    property AllowedActions: TSelectGoodsActionSet read fAllowedActions write SetAllowActions;
    property VisibleActions: TSelectGoodsActionSet read FVisibleActions write SetVisibleActions;
    property AutoOpenGoodsBrowser: Boolean read fAutoOpenGoodsBrowser write SetAutoOpenGoodsBrowser;
    property OnVerifyGoodsExists: TVerifyGoodsExistsProc read FOnVerifyGoodsExists write SetOnVerifyGoodsExists;
    property CustomDocID: Integer read FCustomDocID write SetCustomDocID;
  end;

implementation

uses
  DataModuleAdditions, SWNUtils, DataModuleDB, SWNTypes, frmGoods, SWNValueStorageUnit, SWNDBErrors,
  SWNSecurity, SWNSecurityFlags;

{$R *.dfm}

{ TfrmConfigurationSelectGoodsDlg }

procedure TfrmAddItemsToTender.bb1Click(Sender: TObject);
var
  bb: TdxBarButton;
  PriceColumn: Integer;
begin
  if not fHasAllPrices then
    fHasAllPrices := LoadAllPrices(fJurnalDataSet.FieldByName('GOODSID').asInteger);

  if fHasAllPrices then
  begin
    bb := TdxBarButton(Sender);
    PriceColumn := bb.Tag;
    ChangeGoodsPrice(fJurnalDataSet.FieldByName('GOODSID').asInteger, fSelectedGoodsPrice[PriceColumn],
      fSelectedGoodsCurrencyID, True);
  end;
end;

procedure TfrmAddItemsToTender.beGoodsDblClick(Sender: TObject);
begin
  ShowSelectGoodsDialog;
end;

procedure TfrmAddItemsToTender.beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  case AButtonIndex of
    0:
      ShowSelectGoodsDialog;
    1:
      ShowGoodsPopup(beGoods.EditText);
  end;
end;

procedure TfrmAddItemsToTender.cePRICEPropertiesEditValueChanged(Sender: TObject);
begin
  PriceChanged2;
end;

procedure TfrmAddItemsToTender.ceQTYPropertiesEditValueChanged(Sender: TObject);
begin
  QtyChanged;
end;

procedure TfrmAddItemsToTender.ceQTYPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var
  ErrorText: TCaption; var Error: Boolean);
begin
  if DisplayValue <= 0 then
  begin
    ShowErrorDialog('Valori incorecte', 'Nu sunt acceptate valori nule sau negative!');
    DisplayValue := 1;
  end;
end;

procedure TfrmAddItemsToTender.ceSUMAPropertiesEditValueChanged(Sender: TObject);
begin
  SumaChanged;
end;

procedure TfrmAddItemsToTender.ChangeGoodsPrice(const NewGoodsID: Integer; const NewPrice: Currency; const
  CurrencyID: integer; const Silent: Boolean);
var
  tmpRate: Double;
  tmpPrice: Currency;
  toChangePrices: Boolean;
begin
     // transformam pretul orifginal a marfei in valuta documentului in dependenta de FLG_ACNT
  tmpRate := dmDB.IBCQueryDocs.FieldByName('RATE').asFloat;

  if not dmDB.TransformCurrency2(fCurrentDoc_DocID, NewPrice, CurrencyID, fCurrentDoc_CurrencyID,
    fCurrentDoc_FLG_ACNT = 1, tmpPrice, tmpRate, True, True, fDefaultPriceColumn = 0) then
    tmpPrice := NewPrice;

     // updated! verificam daca preturile sunt diferite
  if (acChangePrice in fAllowedActions) and (fJurnalDataSet.FieldByName('PRICE').asCurrency <> tmpPrice) and (NewGoodsID
    = fJurnalDataSet.FieldByName('GOODSID').asInteger) and (not Silent) then
  begin
    toChangePrices := (fJurnalDataSet.FieldByName('PRICE').asCurrency = 0) or (ShowAskDialog('Modificare pret',
      'Pretul curent difera de cel din document, Modificati?') = mrYes);
  end
  else
    toChangePrices := true;

  if toChangePrices then
  begin

    fJurnalDataSet.FieldByName('PRICE').asCurrency := tmpPrice;
          // update 04.03.2011 - in COST se duce Pretul 0 in Lei
//    if not dmDB.TransformCurrency2(fCurrentDoc_DocID, fSelectedGoodsPrice[0], CurrencyID, 498,
//      fCurrentDoc_FLG_ACNT = 1, tmpPrice, tmpRate, True, True, True) then
//      tmpPrice := fSelectedGoodsPrice[fDefaultPriceColumn];
//    fJurnalDataSet.FieldByName('COST').asCurrency := tmpPrice;
  end;
end;

procedure TfrmAddItemsToTender.CheckIfGoodsExists(const GoodsID: integer);
var
  Exists: Boolean;
begin
  Exists := False;
  try
    if Assigned(FOnVerifyGoodsExists) then
      Exists := FOnVerifyGoodsExists(GoodsID);
  finally
//    lbGoodsExistsWarning.Visible := Exists;
//    imgWarning.Visible := Exists;
  end;
end;

function TfrmAddItemsToTender.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;

  with fJurnalDataSet do
  begin
//    if (dmdb.CurrentDocTypeID = 125) or (dmdb.CurrentDocTypeID = 124) then
//    begin
//      if (FieldByName('PRICE').AsFloat <> 0) then
//      begin
//        AddErrorToStr(ErrorStr, 'Pretul trebuie sa fie = 0!');
//        edPRICE.SetFocus;
//      end;
//      if (FieldByName('SUMA').AsFloat <> 0) then
//      begin
//        AddErrorToStr(ErrorStr, 'Suma trebuie sa fie = 0!');
//        edSUMA.SetFocus;
//      end;
//    end;
    if (FieldByName('GOODSID').isNull) or (FieldByName('GOODSID').AsInteger <= 0) then
      AddErrorToStr(ErrorStr, 'Nu este ales produsul!');
//    if (FieldByName('DTDEP').isNull) or (FieldByName('DTDEP').AsInteger <= 0) then
//      AddErrorToStr(ErrorStr, 'Nu este ales depozitul!');
    if (FieldByName('QTY').isNull) or (FieldByName('QTY').AsFloat <= 0) then
      AddErrorToStr(ErrorStr, 'Cantitatea nu este indicata!');
    if (FieldByName('PRICE').isNull) then
      AddErrorToStr(ErrorStr, 'Nu este indicat pretul!');
    if (FieldByName('SUMA').isNull) then
      AddErrorToStr(ErrorStr, 'Nu este indicata suma!');
//    if FieldByName('UMID').isNull then
//      AddErrorToStr(ErrorStr, 'Unitatea de masura nu este indicata!');
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

constructor TfrmAddItemsToTender.Create(const AOwner: TComponent; const JurnalDataSet: TIBCQuery; const
  JurnalDataSource: TIBCDataSource; const ParentGoodsID: integer);
begin
  inherited Create(AOwner);

  fAllowedActions := [acChangeACNT, acChangePrice, acChangeGoods, acChangeQTY, acChangeStock, acChangeActive,
    acChangeWarranty];
  fVisibleActions := fAllowedActions;

  FCustomeSQLFilter := '';

  fJurnalDataSet := JurnalDataSet;
  fParentGoodsID := ParentGoodsID;
  FSelectGoodsType := [];
  fDefaultPriceColumn := 1;


  edQTY.DataBinding.DataSource := JurnalDataSource;

  edPRICE.DataBinding.DataSource := JurnalDataSource;
  edSUMA.DataBinding.DataSource := JurnalDataSource;
  cbFLG_ACNT.DataBinding.DataSource := JurnalDataSource;
  cbFLG_ACTIVE.DataBinding.DataSource := JurnalDataSource;
  cbWARRANTY.DataBinding.DataSource := JurnalDataSource;
  cbVAT.DataBinding.DataSource := JurnalDataSource;
  edGOODSID.DataBinding.DataSource := JurnalDataSource;
//  lcbGoodsName.DataBinding.DataSource := JurnalDataSource;
  teCPV.DataBinding.DataSource := JurnalDataSource;
  teDenBun.DataBinding.DataSource := JurnalDataSource;
  teFDA.DataBinding.DataSource := JurnalDataSource;
  teCountry.DataBinding.DataSource := JurnalDataSource;
  teManufacturer.DataBinding.DataSource := JurnalDataSource;
  teStandart.DataBinding.DataSource := JurnalDataSource;

  fAcntFlagVisible := False;
end;

procedure TfrmAddItemsToTender.CheckGoodsFlgActive(fJurnalDataSet: TIBCQuery);
//var
//  q: TIBCQuery;
begin
//  q := TIBCQuery.Create(nil);
//  dmdb.OpenQuery(q,
//    'select iif(exists(select * from ts_syss where parentid = :parentid and :goodsid = value_int), 1, 0) FLG_ACTIVE from rdb$database',
//    [fJurnalDataSet.FieldByName('GOODSID').AsInteger, 55]);
//  if (q.FieldByName('flg_active').AsInteger = 1) then
//  begin
//    if (fJurnalDataSet.State in dsEditModes) then
//      fJurnalDataSet.Edit;
//
//    fJurnalDataSet.FieldByName('FLG_ACTIVE').AsInteger := 0;
//  end;
end;

procedure TfrmAddItemsToTender.CloseAdditionalDataSources;
begin
//  dmDB.IBCQueryStocks.Close;
//  dmDB.IBCQueryStocks.FilterSQL := '';
  dmDB.IBCQueryCurrency.Close;
end;

procedure TfrmAddItemsToTender.FLG_ACTIVE_Changed_Peremeshenie;
begin
     // FLG_ACTIVE=0 - se inpune Pretul,Suma, TVA = 0. Acest caz este prelucrat de baza
     // FLG_ACTIVE=1 - se pune pretul,Suma,TVA = obisnuit. Acest caz se prelucreaza manual
  case dmDB.IBCQueryJurnal.FieldByName('FLG_ACTIVE').AsInteger of
//    0:
//      begin
//             // doar pentru ecran
//        fJurnalDataSet.FieldByName('PRICE').asInteger := 0;
//        fJurnalDataSet.FieldByName('SUMA').asInteger := 0;
//      end;
    1:
      begin
             // intoarcem inapoi valorile Pretulului
        if not fHasAllPrices then
          fHasAllPrices := LoadAllPrices(fJurnalDataSet.FieldByName('GOODSID').asInteger);
        ChangeGoodsPrice(fJurnalDataSet.FieldByName('GOODSID').asInteger, fSelectedGoodsPrice[fDefaultPriceColumn],
          fSelectedGoodsCurrencyID);
      end;
  end;
end;

procedure TfrmAddItemsToTender.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmAddItemsToTender.FormCreate(Sender: TObject);
begin
  FCustomDocID := -1;
  FOnVerifyGoodsExists := nil;
  fAutoOpenGoodsBrowser := True;
  pcPageControl.ActivePageIndex := 0;
  FAddNewGoods := False;

//  lbGoodsExistsWarning.Visible := False;
//  imgWarning.Visible := False;
  fHasAllPrices := False;
end;

procedure TfrmAddItemsToTender.frameGoodsStockcxTreeStylesGetContentStyle(Sender: TcxCustomTreeList;
  AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
begin
  if ANode.Values[1] > 0 then
    AStyle := dmAdditions.cxStyle_Bold;
end;

function TfrmAddItemsToTender.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  begin
    try
      if FCustomDocID > 0 then
        fJurnalDataSet.FieldByName('DOCID').AsInteger := FCustomDocID;

      fJurnalDataSet.Post;
      fJurnalDataSet.UpdateTransaction.Commit;
      Result := True;
    except
      on E: Exception do
        if not ProcessSWNError(E) then
          raise;
    end;
    AppUserTempConfigStorage.IntValues.SetValue(Owner.Name + '_LastSelectedGoodsID', fJurnalDataSet.FieldByName
      ('GOODSID').asInteger);
  end;
end;

function TfrmAddItemsToTender.LoadAllPrices(const GoodsID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDb.IBCConnection;
    Query.SQL.Text :=
      'SELECT PRICE0,PRICE1,PRICE2,PRICE3,PRICE4,PRICE5,PRICE6,PRICE7,CURRENCYID FROM SP_GET_TS_GOODS_M0(:DT,:GOODSID)';
    Query.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
    Query.ParamByName('GOODSID').AsInteger := GoodsID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      fSelectedGoodsPrice[0] := Query.Fields[0].AsCurrency;
      fSelectedGoodsPrice[1] := Query.Fields[1].AsCurrency;
      fSelectedGoodsPrice[2] := Query.Fields[2].AsCurrency;
      fSelectedGoodsPrice[3] := Query.Fields[3].AsCurrency;
      fSelectedGoodsPrice[4] := Query.Fields[4].AsCurrency;
      fSelectedGoodsPrice[5] := Query.Fields[5].AsCurrency;
      fSelectedGoodsPrice[6] := Query.Fields[6].AsCurrency;
      fSelectedGoodsPrice[7] := Query.Fields[7].AsCurrency;
      fSelectedGoodsCurrencyID := Query.Fields[8].AsInteger;
      Result := True;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmAddItemsToTender.pcPageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet; var
  AllowChange: Boolean);
begin
  AllowChange := (NewPage = tbsGoods);
end;

procedure TfrmAddItemsToTender.Prepare;
begin
  PrepareView;
  SetupQtyFields;

  ReadCurrentDocProps;

  fJurnalDataSet.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;

//    dmDB.IBCQueryStocks.FilterSQL := 'STOCKID<>-1';
//    dmDB.IBCQueryStocks.Active := True;

    if FAddNewGoods then
    begin
      fJurnalDataSet.Append;

             // default values
//      fJurnalDataSet.FieldByName('CTDEP').AsInteger := -1;
//      fJurnalDataSet.FieldByName('GOODSCOMPLECT_ID').AsInteger := fParentGoodsID;

//      fJurnalDataSet.FieldByName('DTDEP').asInteger := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;

      //daca e asamblare atunci ctdep trebuie sa fie -1
//      if dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger = 113 then
//        fJurnalDataSet.FieldByName('CTDEP').AsInteger := -1
//      else
//        fJurnalDataSet.FieldByName('CTDEP').AsInteger := dmDB.IBCQueryDocs.FieldByName('CTDEP').AsInteger;

      fJurnalDataSet.FieldByName('QTY').AsFloat := 1;
      fJurnalDataSet.FieldByName('PRICE').AsCurrency := 0;
//      fJurnalDataSet.FieldByName('COST').AsInteger := 0;
      fJurnalDataSet.FieldByName('SUMA').AsCurrency := 0;

      fJurnalDataSet.FieldByName('WARANTY').AsInteger := 0;

//      fJurnalDataSet.FieldByName('STOCK_QTY').AsFloat := 0;

//      fJurnalDataSet.FieldByName('FLG_ACNT').AsInteger := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger;
//      fJurnalDataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
//      fJurnalDataSet.FieldByName('FLG_READY').AsInteger := 0;
//      fJurnalDataSet.FieldByName('FLG_DELETE').AsInteger := 0;
    end
    else
    begin
//      dtDialogTitle.Text := 'Modificarea produsului pentru oferta';
             // verificam daca produsul dat are numere de serii, daca are, se interzice modificarea depozitului
//      if GoodsHasSNPNNumbers then
//      begin
//        beGoods.Enabled := False;
//      end;
      fJurnalDataSet.Edit;
    end;

    beGoods.Text := fJurnalDataSet.FieldByName('GOODS_NAME').asString;

//    if fAutoOpenGoodsBrowser and fJurnalDataSet.FieldByName('GOODSID').IsNull then
//    begin
//      ShowSelectGoodsDialog;
//      if fJurnalDataSet.FieldByName('GOODSID').IsNull then
//      begin
//        ModalResult := mrCancel; // force to close dialog
//        WhenCancelForm; // rollback transaction
//      end;
//    end;

             // 28.11.2013 - Daca este produs cu Seriinii Uceot -> numai numar intreg
//    if (fJurnalDataSet.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) then
//    begin
//      TcxCalcEditProperties(edQTY.Properties).DisplayFormat := cQTY_DigitsMask[0];
//    end;

//    cbFLG_ACTIVE.Properties.OnEditValueChanged := WhenFLG_ACTIVE_Changed;

        // DACA ESTE RASHOD, CONT DE PLATA, CONFIGURATOR, WEBORDER, FACTURA, TTN
        // NU SE POATE DE MODIFICAT PRETUL CU MINA, DOAR COLONITELE
//    if ((dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger = 107) or (dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger
//      = 115) or (dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger = 112) or (dmDB.IBCQueryDocs.FieldByName
//      ('DOCTYPEID').AsInteger = 113) or (dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger = 1408) or (dmDB.IBCQueryDocs.FieldByName
//      ('DOCTYPEID').AsInteger = 2016)) and not (SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Ручное_изменение_цен))
//      then
//    begin
//      if ((dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger <> 4203) and
//         (dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger <> 4217))then // daca nu este serviciu atunci nu dam voie sa redactam preturile
//      begin
//        edPRICE.Properties.readonly := TRUE;
//        edSUMA.Properties.readonly := TRUE;
//        cbVAT.Properties.readonly := TRUE;
//      end;
//    end;

  except
    if fJurnalDataSet.State in dsEditModes then
      fJurnalDataSet.Cancel;
    fJurnalDataSet.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmAddItemsToTender.PrepareView;
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
        end;
      acChangeGoods:
        begin
          beGoods.Enabled := Allow;
          edGOODSID.Enabled := Allow;
        end;
      acChangePrice:
        begin
//          if ((dmdb.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger = 4203) AND (dmdb.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger = 4217)) then // daca e serviciu preturile pot fi modificate
//          begin
//            edPRICE.Enabled := True;
//            edSUMA.Enabled := True;
//          end
//          else
//          begin
            edPRICE.Enabled := Allow;
            edSUMA.Enabled := Allow;
//          end;
          lbCURRENCY_NAME.Enabled := Allow;
          edPRICE.Visible := Vis;
          edSUMA.Visible := Vis;
          lbCURRENCY_NAME.Visible := Vis;
          lbPrice.Visible := Vis;
          lbSUMA.Visible := Vis;
          bb1.Enabled := Vis;
          bb2.Enabled := Vis;
          bb3.Enabled := Vis;
          bb4.Enabled := Vis;
          bb5.Enabled := Vis;
          bb6.Enabled := Vis;
          bb7.Enabled := Vis;
        end;
      acChangeQTY:
        begin
          edQTY.Enabled := Allow;
                            //edQTY.Visible:=Vis;
                            //lbQTY.Visible:=Vis;
        end;
//      acChangeStock:
//        begin
//          lcbStock.Enabled := Allow;
//          tbsQtys.TabVisible := Allow or Vis;
//                              //lcbStock.Visible:=Vis;
//        end;
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
//  sbPriceColumn1.Visible := sbPriceColumn1.Visible and SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_1);
//  sbPriceColumn2.Visible := sbPriceColumn2.Visible and SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_2);
//  sbPriceColumn3.Visible := sbPriceColumn2.Visible and SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_3);
end;

procedure TfrmAddItemsToTender.PriceChanged2;
var
  N: Double;
begin
  if not (fJurnalDataSet.State in dsEditModes) then
    Exit;

  N := fJurnalDataSet.FieldByName('QTY').AsFloat;
  if N <> 0 then
  begin
    fJurnalDataSet.FieldByName('SUMA').AsFloat := fJurnalDataSet.FieldByName('PRICE').AsFLoat * N;
  end
  else
  begin
    fJurnalDataSet.FieldByName('SUMA').AsCurrency := 0;
  end;
end;

procedure TfrmAddItemsToTender.QtyChanged;
var
  N: Double;
begin
  if not (fJurnalDataSet.State in dsEditModes) then
    Exit;

  N := fJurnalDataSet.FieldByName('QTY').AsFloat;
  if N > 0 then
  begin
    if fJurnalDataSet.FieldByName('PRICE').AsCurrency > 0 then
      fJurnalDataSet.FieldByName('SUMA').AsFloat := fJurnalDataSet.FieldByName('PRICE').AsFloat * N
    else if fJurnalDataSet.FieldByName('SUMA').AsCurrency > 0 then
      fJurnalDataSet.FieldByName('PRICE').AsFloat := fJurnalDataSet.FieldByName('SUMA').AsFloat / N;
  end
  else
  begin
    fJurnalDataSet.FieldByName('PRICE').AsCurrency := 0;
    fJurnalDataSet.FieldByName('SUMA').AsCurrency := 0;
  end;
end;

procedure TfrmAddItemsToTender.SumaChanged;
var
  N: Double;
begin
  if not (fJurnalDataSet.State in dsEditModes) then
    Exit;

  N := fJurnalDataSet.FieldByName('QTY').asFloat;
  if N <> 0 then
  begin
//    if fJurnalDataSet.FieldByName('GOODS_TYPE_ID').AsInteger = 4204 then { reduceri servicii personale }
    fJurnalDataSet.FieldByName('PRICE').AsFloat := fJurnalDataSet.FieldByName('SUMA').AsFloat / N//    else
//      fJurnalDataSet.FieldByName('PRICE').AsFloat := fJurnalDataSet.FieldByName('SUMA').AsFloat / N;
  end
  else
  begin
    fJurnalDataSet.FieldByName('PRICE').AsFloat := 0;
  end;
end;

procedure TfrmAddItemsToTender.ReadCurrentDocProps;
begin
  if FCustomDocID > 0 then
  begin
    if not ReadCustomDocProps then
      raise Exception.Create('Nu este informatie despre asamblare!')
  end
  else
  begin
    fCurrentDoc_DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    fCurrentDoc_CurrencyID := dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger;
    fCurrentDoc_FLG_ACNT := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').asInteger;
  end;
end;

function TfrmAddItemsToTender.ReadCustomDocProps: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultSelect;
    Query.SQL.Text := 'SELECT DOCID,CURRENCYID,FLG_ACNT FROM VW_TDB_DOCS WHERE DOCID=:DOCID';
    Query.ParamByName('DOCID').AsInteger := FCustomDocID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      fCurrentDoc_DocID := Query.Fields[0].AsInteger;
      fCurrentDoc_CurrencyID := Query.Fields[1].AsInteger;
      fCurrentDoc_FLG_ACNT := Query.Fields[2].AsInteger;
      Result := True;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmAddItemsToTender.SetAddNewGoods(const Value: Boolean);
begin
  FAddNewGoods := Value;
end;

procedure TfrmAddItemsToTender.SetAllowActions(const Value: TSelectGoodsActionSet);
begin
  fAllowedActions := Value;
end;

procedure TfrmAddItemsToTender.SetAutoOpenGoodsBrowser(const Value: Boolean);
begin
  fAutoOpenGoodsBrowser := Value;
end;

procedure TfrmAddItemsToTender.SetCustomDocID(const Value: Integer);
begin
  FCustomDocID := Value;
end;

procedure TfrmAddItemsToTender.SetDefaultPriceColumn(const Value: integer);
begin
  if (Value >= 0) and (Value <= 7) then
    fDefaultPriceColumn := Value;
end;

procedure TfrmAddItemsToTender.SetOnVerifyGoodsExists(const Value: TVerifyGoodsExistsProc);
begin
  FOnVerifyGoodsExists := Value;
end;

procedure TfrmAddItemsToTender.SetSelectGoodsType(const Value: TGoodsTypeFilterSet);
//var
//  i: TGoodsTypeFilter;
//  S: string;
begin
//  FSelectGoodsType := Value;
//  S := '';
//  if (FSelectGoodsType = []) then
//    S := ''
//  else
//    for i := Low(TGoodsTypeFilter) to High(TGoodsTypeFilter) do
//      if i in FSelectGoodsType then
//        case i of
//          gtfComplect:
//            begin
//              if S <> '' then
//                S := S + ' OR ';
//              S := S + Format('(GOODS_TYPE_ID IN (%d,%d)) OR (FLG_FOLDER=1)', [cSYSS_GOODS_TYPE_Комплект,
//                cSYSS_GOODS_TYPE_Комплект_услуг]);
//            end;
//          gtfNoComplect:
//            begin
//              if S <> '' then
//                S := S + ' OR ';
//              S := S + Format('(GOODS_TYPE_ID NOT IN (%d,%d)) OR (FLG_FOLDER=1)', [cSYSS_GOODS_TYPE_Комплект,
//                cSYSS_GOODS_TYPE_Комплект_услуг]);  // No Комплект
//            end;
////          gtfService:
////            begin
////              if S <> '' then
////                S := S + ' OR ';
////              S := S + Format('(GOODS_TYPE_ID=%d)', [cSYSS_GOODS_TYPE_Товары_для_сервиса]);
////            end;
////          gtfNoService:
////            begin
////              if S <> '' then
////                S := S + ' OR ';
////              S := S + Format('(GOODS_TYPE_ID<>%d)', [cSYSS_GOODS_TYPE_Товары_для_сервиса]); // Товары NOT FOR сервиса
////            end;
//        end;

//  FCustomeSQLFilter := S;
  FCustomeSQLFilter := '';
end;

procedure TfrmAddItemsToTender.SetupQtyFields;
var
  qtyDigitsMode: Integer;
begin
     // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
     // Товарные позиции: Кол-во
  TcxCalcEditProperties(edQTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmAddItemsToTender.SetupSecurityItems;
begin
  inherited;
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_1) then
    bb1.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_2) then
    bb2.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_3) then
    bb3.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_4) then
    bb4.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_5) then
    bb5.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_6) then
    bb6.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_7) then
    bb7.Visible := ivNever;

end;

procedure TfrmAddItemsToTender.SetVisibleActions(const Value: TSelectGoodsActionSet);
begin
  FVisibleActions := Value;
end;

procedure TfrmAddItemsToTender.ShowGoodsPopup(SearchCriteria: string);
var
  query: TIBCQuery;
begin
   // Open popupwindow with filtered goods records!
  query := TIBCQuery.Create(Self);

  try
    query.SQL.Text := 'select first 20 goodsid, title from ts_goods where title containing :liketitle';
    query.ParamByName('liketitle').AsString := SearchCriteria;
    query.Open;
    beGoods.Properties.LookupItems.Clear;
    while not query.eof do
    begin
      beGoods.Properties.LookupItems.Add(query.FieldByName('TITLE').AsString);
      query.Next;
    end;
  finally
    query.free;
  end;
end;

procedure TfrmAddItemsToTender.ShowSelectGoodsDialog;
var
  dialog: TfrmGoodsBrowser;
  N: integer;
begin
  dialog := TfrmGoodsBrowser.Create(Parent);
  try
    dialog.CustomeSQLFilter := FCustomeSQLFilter;

    N := AppUserTempConfigStorage.IntValues.GetValue(Owner.Name + '_LastSelectedGoodsID', -1);
    if not fJurnalDataSet.FieldByName('GOODSID').IsNull then
      N := fJurnalDataSet.FieldByName('GOODSID').AsInteger;

    if dialog.SelectGoods(N, False) then
    begin
      // check if exists
      if fJurnalDataSet.FieldByName('GOODSID').asInteger <> dialog.GoodsID then
        CheckIfGoodsExists(dialog.GoodsID);

      // 28.11.2013 - Daca este produs cu Seriinii Uceot -> numai numar intreg
      if (dialog.GoodsSerialType = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) then
      begin
        TcxCalcEditProperties(edQTY.Properties).DisplayFormat := cQTY_DigitsMask[0];
//        edQTY.Visible := False;
//        edQTY2.Visible := True;
      end;

             // New. 15.03.2012
             // save price values
      fSelectedGoodsCurrencyID := dialog.GoodsPriceCurrencyID;
      fSelectedGoodsPrice[0] := dialog.GoodsPrice[0];
      fSelectedGoodsPrice[1] := dialog.GoodsPrice[1];
      fSelectedGoodsPrice[2] := dialog.GoodsPrice[2];
      fSelectedGoodsPrice[3] := dialog.GoodsPrice[3];
      fSelectedGoodsPrice[4] := dialog.GoodsPrice[4];
      fSelectedGoodsPrice[5] := dialog.GoodsPrice[5];
      fSelectedGoodsPrice[6] := dialog.GoodsPrice[6];
      fSelectedGoodsPrice[7] := dialog.GoodsPrice[7];
      fHasAllPrices := True;

//      fJurnalDataSet.FieldByName('UMID').asInteger := dialog.GoodsUMID;

//      fJurnalDataSet.FieldByName('STOCK_QTY').asFloat := dialog.GoodsQuantityAvailable;
      if fJurnalDataSet.FieldByName('QTY').asFloat <= 0 then
        fJurnalDataSet.FieldByName('QTY').asFloat := 1;

      fJurnalDataSet.FieldByName('WARANTY').asInteger := dialog.GoodsWarranty;

             // change price
//           pentru Заявки на ремонт & гарантийный ремонт Pretul=0
//      if (dmdb.CurrentDocTypeID = 125) or (dmdb.CurrentDocTypeID = 124) then
//        fJurnalDataSet.FieldByName('PRICE').AsFloat := 0
//      else if dmdb.CurrentDocTypeID = 126 then
//      begin
//        ChangeGoodsPrice(dialog.GoodsID, dialog.GoodsPrice[0], dialog.GoodsPriceCurrencyID);
//      end
//      else
//      begin
        ChangeGoodsPrice(dialog.GoodsID, dialog.GoodsPrice[fDefaultPriceColumn], dialog.GoodsPriceCurrencyID);
//      end;

      fJurnalDataSet.FieldByName('GOODSID').asInteger := dialog.GoodsID;
      beGoods.Text := dialog.GoodsTitle;

      CheckGoodsFlgActive(fJurnalDataSet);
    end;
//    if (dmdb.CurrentDocTypeID = 125) or (dmdb.CurrentDocTypeID = 124) then
//      fJurnalDataSet.FieldByName('PRICE').AsFloat := 0
  finally
    dialog.Free;
  end;
end;

procedure TfrmAddItemsToTender.WhenCancelForm;
begin
  if fJurnalDataSet.State in dsEditModes then
    fJurnalDataSet.Cancel;
  fJurnalDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmAddItemsToTender.WhenFLG_ACTIVE_Changed(Sender: TObject);
begin
  if fJurnalDataSet.State in dsEditModes then
    case dmDB.CurrentDocTypeID of
     // 114 - Перемещение.
      114:
        FLG_ACTIVE_Changed_Peremeshenie;
    end;
end;

end.

