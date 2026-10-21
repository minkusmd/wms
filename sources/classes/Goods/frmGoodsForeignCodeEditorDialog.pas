unit frmGoodsForeignCodeEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs,
  DialogTitle, ExtCtrls, StdCtrls, cxButtonEdit, cxDBEdit, Buttons, cxDBLookupComboBox, Data.DB,
  DBAccess, IBC, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.Menus, MemDS, cxDropDownEdit, cxCalc, cxCheckBox, cxLookupEdit,
  cxDBLookupEdit, cxMemo, cxTextEdit, cxMaskEdit, cxStyles, dxScrollbarAnnotations, cxVGrid,
  cxDBVGrid, cxInplaceContainer, dxBarBuiltInMenu, cxPC, cxLabel, cxDBLabel, cxClasses,
  dxUIAClasses, dxCoreGraphics;

const
  // Parametrii vinzarii in rate cu dobinda 0%. Folositi doar pentru afisaj:
  // pretul insusi se calculeaza in baza. Trebuie sa ramina sincronizati cu
  // DB Model\price0_global.sql (coloana calculata PRICE_CREDIT0
  // si procedura GET_GOODS_PRICE_CREDIT0).
  cCredit0Months = 6;
  cCredit0CostMarkup = 1.16;

type
  TfrmGoodsForeignCodeEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    beFirma: TcxButtonEdit;
    Label2: TLabel;
    edGOODS_CODE: TcxDBTextEdit;
    Label3: TLabel;
    mmGOODS_TITLE: TcxDBMemo;
    bbGenerateCode: TSpeedButton;
    sbTakeCode: TSpeedButton;
    Label4: TLabel;
    IBCQueryCurrency7: TIBCQuery;
    IBCDataSourceCurrency7: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cbAvailable: TcxDBCheckBox;
    cbPromo: TcxDBCheckBox;
    cbInPrice: TcxDBCheckBox;
    cbFLG_DRP: TcxDBCheckBox;
    cbFLG_EPP: TcxDBCheckBox;
    IBCQueryCurrency4: TIBCQuery;
    IBCDataSourceCurrency4: TIBCDataSource;
    sbTakeDesc: TcxButton;
    Label5: TLabel;
    edBarCode: TcxDBTextEdit;
    Label14: TLabel;
    Label15: TLabel;
    cbPreOrder: TcxDBCheckBox;
    IBCQueryCurrency: TIBCQuery;
    IBCDataSourceCurrency: TIBCDataSource;
    cxDefaultEditStyleController1: TcxDefaultEditStyleController;
    Panel1: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    lcbCurrency7: TcxDBLookupComboBox;
    cePrice7: TcxDBCalcEdit;
    lcbCurrency3: TcxDBLookupComboBox;
    cePrice3: TcxDBCalcEdit;
    cePrice5: TcxDBCalcEdit;
    cePrice6: TcxDBCalcEdit;
    lcbCurrency6: TcxDBLookupComboBox;
    lcbCurrency5: TcxDBLookupComboBox;
    cePrice4: TcxDBCalcEdit;
    cePrice2: TcxDBCalcEdit;
    lcbCurrency2: TcxDBLookupComboBox;
    lcbCurrency4: TcxDBLookupComboBox;
    lcbCurrency1: TcxDBLookupComboBox;
    cePrice1: TcxDBCalcEdit;
    btnMargin: TcxButton;
    lbMargin37: TcxLabel;
    lbMargin47: TcxLabel;
    lbMargin57: TcxLabel;
    lbMargin67: TcxLabel;
    lbDiff67: TcxLabel;
    lbDiff57: TcxLabel;
    lbDiff37: TcxLabel;
    lbDiff47: TcxLabel;
    lbDiff17: TcxLabel;
    lbMargin17: TcxLabel;
    ceMMargin6: TcxDBCalcEdit;
    ceMMargin5: TcxDBCalcEdit;
    lbPrice7LEICalc: TcxLabel;
    Label13: TLabel;
    ceCost: TcxDBCalcEdit;
    btnResetValues: TcxButton;
    IBCTrLocal: TIBCTransaction;
    Label16: TLabel;
    teURL: TcxDBTextEdit;
    Label17: TLabel;
    cePriceCredit0: TcxDBCalcEdit;
    lbCredit0Info: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure beFirmaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure bbGenerateCodeClick(Sender: TObject);
    procedure sbTakeCodeClick(Sender: TObject);
    procedure sbTakeDescClick(Sender: TObject);
    procedure cbPrice4_valPropertiesEditValueChanged(Sender: TObject);
    procedure cePrice3Exit(Sender: TObject);
    procedure cePrice5Exit(Sender: TObject);
    procedure btnMarginClick(Sender: TObject);
    procedure lcbCurrency7PropertiesChange(Sender: TObject);
    procedure btnResetValuesClick(Sender: TObject);
  private    { Private declarations }
    FCreateNewCode: Boolean;
    FCurrency4ID: Integer;
    FCurrency5ID: Integer;
    FCurrency6ID: Integer;
//        fCurrency4ID: Integer;
    fORD_Currency7id: integer;
    fCurrency7ID: Integer;
    FGoodsID: Integer;
    FGoodsCode: string;
    FGoodsDesc: string;
    FGoodsTitle: string;
    procedure SetCreateNewCode(const Value: Boolean);
    procedure SelectFirma;
    function CheckParams: Boolean;
    procedure SetGoodsID(const Value: Integer);
    function GetDBUniqeID: Integer;
    procedure SetCurrency4ID(const Value: Integer);
    procedure SetCurrency5ID(const Value: Integer);
    procedure SetCurrency6ID(const Value: Integer);
    procedure SetGoodsCode(const Value: string);
    procedure SetGoodsDesc(const Value: string);
    procedure SetGoodsTitle(const Value: string);
  protected    { protected declarations }
    procedure BindingDataSource; override;
    procedure CalculateMargins;
    procedure UpdateCredit0Info;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

    procedure SaveStates; override;
    procedure LoadStates; override;

  public    { Public declarations }
    property GoodsID: Integer read FGoodsID write SetGoodsID;
    property CreateNewCode: Boolean read FCreateNewCode write SetCreateNewCode;
    property Currency4ID: Integer read FCurrency4ID write SetCurrency4ID;
    property Currency5ID: Integer read FCurrency5ID write SetCurrency5ID;
    property Currency6ID: Integer read FCurrency6ID write SetCurrency6ID;
    property GoodsCode: string read FGoodsCode write SetGoodsCode;
    property GoodsDesc: string read FGoodsDesc write SetGoodsDesc;
    property GoodsTitle: string read FGoodsTitle write SetGoodsTitle;
  end;

implementation

uses
  SWNUtils, SWNConst, frmCustomersDlg, DataModuleDB, SWNValueStorageUnit, Vcl.Clipbrd;

{$R *.dfm}

procedure TfrmGoodsForeignCodeEditorDlg.FormCreate(Sender: TObject);
begin

end;

{ TfrmGoodsForeignCodeEditorDlg }

procedure TfrmGoodsForeignCodeEditorDlg.bbGenerateCodeClick(Sender: TObject);
var
  N: Integer;
begin
  N := GetDBUniqeID;
  fMasterDataSet.FieldByName('GOODS_CODE').AsString := Format('%d_%d', [fMasterDataSet.FieldByName('CUSTOMERID').asInteger,
    N]);
  Clipboard.AsText := fMasterDataSet.FieldByName('GOODS_CODE').AsString;
end;

procedure TfrmGoodsForeignCodeEditorDlg.beFirmaPropertiesButtonClick(Sender: TObject; AButtonIndex:
  Integer);
begin
  SelectFirma;
end;

procedure TfrmGoodsForeignCodeEditorDlg.cbPrice4_valPropertiesEditValueChanged(Sender: TObject);
begin
  IBCQueryCurrency4.Open;
  fMasterDataSet.Edit;
  if IBCQueryCurrency4.Locate('CURRENCYID', fMasterDataSet.FieldByName('CURRENCY4ID').asInteger, []) then
    fMasterDataSet.FieldByName('PRICE4').AsFloat := fMasterDataSet.FieldByName('BASE_PRICE4').AsFloat
      * IBCQueryCurrency4.FieldByName('EXCHANGE_RATE').AsFloat;
end;

procedure TfrmGoodsForeignCodeEditorDlg.cePrice3Exit(Sender: TObject);
begin
  if fMasterDataSet.FieldByName('PRICE5').AsFloat = 0 then
    fMasterDataSet.FieldByName('price5').AsFloat := fMasterDataSet.FieldByName('price4').AsFloat;
  if fMasterDataSet.FieldByName('CURRENCY5ID').AsFloat = 0 then
    fMasterDataSet.FieldByName('currency5id').AsInteger := fMasterDataSet.FieldByName('CURRENCY4ID').AsInteger;

  CalculateMargins;
end;

function TfrmGoodsForeignCodeEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;

  // scoatem probelurile din cod
  if not fMasterDataSet.FieldByName('GOODS_CODE').IsNull then
    fMasterDataSet.FieldByName('GOODS_CODE').AsString := Trim(fMasterDataSet.FieldByName('GOODS_CODE').AsString);

  if fMasterDataSet.FieldByName('CUSTOMERID').IsNull or (fMasterDataSet.FieldByName('CUSTOMERID').asInteger
    = -1) then
    AddErrorToStr(ErrorStr, 'Firma');
  if fMasterDataSet.FieldByName('GOODS_CODE').IsNull or (fMasterDataSet.FieldByName('GOODS_CODE').AsString
    = '') then
    AddErrorToStr(ErrorStr, 'Cod produs furnizor');
  if fMasterDataSet.FieldByName('GOODS_TITLE').IsNull or (fMasterDataSet.FieldByName('GOODS_TITLE').AsString
    = '') then
    AddErrorToStr(ErrorStr, 'Denumire produs');

  if fMasterDataSet.FieldByName('currency5id').AsString = '' then
    fMasterDataSet.FieldByName('currency5id').AsInteger := 498;

  if fMasterDataSet.FieldByName('currency6id').AsString = '' then
    fMasterDataSet.FieldByName('currency6id').Asstring := fMasterDataSet.FieldByName('currency7id').Asstring;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmGoodsForeignCodeEditorDlg.btnMarginClick(Sender: TObject);
var
  Cost: Double;
begin
  // marja pe costul de achizitie (PRICE0); PRICE7 doar daca PRICE0 lipseste
  Cost := fMasterDataSet.FieldByName('price0').AsFloat;
  if Cost <= 0 then
    Cost := fMasterDataSet.FieldByName('price7').AsFloat;
  fMasterDataSet.FieldByName('price4').AsFloat := Cost * 1.2;
end;

procedure TfrmGoodsForeignCodeEditorDlg.btnResetValuesClick(Sender: TObject);
begin
  var q := TIBCSQL.Create(nil);
  var tr := TIBCTransaction.Create(nil);
  try
    tr.DefaultConnection := dmdb.IBCConnection;
    q.Transaction := tr;

    q.sql.Add('UPDATE TS_GOODS_FOREIGN');
    q.sql.Add('SET');
    q.sql.Add('PRICE0 = 0,');
    q.sql.Add('currency1id = 498,');
    q.sql.Add('PRICE2 = 0,');
    q.sql.Add('currency2id = 498,');
    q.sql.Add('PRICE3 = 0,');
    q.sql.Add('currency3id = 498,');
    q.sql.Add('PRICE4 = 0,');
    q.sql.Add('CURRENCY4ID = 498,');
    q.sql.Add('PRICE5 = 0,');
    q.sql.Add('CURRENCY5ID = 498,');
    q.sql.Add('PRICE6 = 0,');
    q.sql.Add('CURRENCY6ID = 498,');
    q.sql.Add('PRICE7 = 1,');
    q.sql.Add('CURRENCY7ID = 840,');
    q.sql.Add('LAST_PRICE_DATE = current_timestamp');
    q.sql.Add('WHERE');
    q.sql.Add('GOODSID = :GOODSID and CUSTOMERID = :CUSTOMERID');

    q.ParamByName('goodsid').AsInteger := fMasterDataSet.fieldByName('goodsid').AsInteger;
    q.ParamByName('customerid').AsInteger := fMasterDataSet.fieldByName('customerid').AsInteger;
    q.Execute;
    if tr.Active then
      tr.Commit;

    if ibctrLocal.Active then
      IBCTrLocal.Rollback;

    Close;
  finally
    tr.Free;
    q.Free;
  end;
end;

function TfrmGoodsForeignCodeEditorDlg.GetDBUniqeID: Integer;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT NEXT VALUE FOR SQ_FOREIGN_GOODS_CODE FROM RDB$DATABASE';
    Query.ExecSQL;
    Result := Query.Fields[0].asInteger;
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmGoodsForeignCodeEditorDlg.BindingDataSource;
begin
  edGOODS_CODE.DataBinding.DataSource := fMasterDataSource;
  edBarCode.DataBinding.DataSource := fMasterDataSource;
  mmGOODS_TITLE.DataBinding.DataSource := fMasterDataSource;
  sbTakeCode.Enabled := False;

  lcbCurrency7.DataBinding.DataSource := fMasterDataSource;
  lcbCurrency6.DataBinding.DataSource := fMasterDataSource;
  lcbCurrency5.DataBinding.DataSource := fMasterDataSource;
  lcbCurrency4.DataBinding.DataSource := fMasterDataSource;
  lcbCurrency3.DataBinding.DataSource := fMasterDataSource;
  lcbCurrency2.DataBinding.DataSource := fMasterDataSource;
  lcbCurrency1.DataBinding.DataSource := fMasterDataSource;

  cbAvailable.DataBinding.DataSource := fMasterDataSource;
  cbPromo.DataBinding.DataSource := fMasterDataSource;
  cbInPrice.DataBinding.DataSource := fMasterDataSource;
  cbFLG_DRP.DataBinding.DataSource := fMasterDataSource;
  cbFLG_EPP.DataBinding.DataSource := fMasterDataSource;
  cbPreOrder.DataBinding.DataSource := fMasterDataSource;

  cePrice7.DataBinding.DataSource := fMasterDataSource;
  cePrice6.DataBinding.DataSource := fMasterDataSource;
  cePrice5.DataBinding.DataSource := fMasterDataSource;
  cePrice4.DataBinding.DataSource := fMasterDataSource;
  cePrice3.DataBinding.DataSource := fMasterDataSource;
  cePrice2.DataBinding.DataSource := fMasterDataSource;
  cePrice1.DataBinding.DataSource := fMasterDataSource;
  ceCost.DataBinding.DataSource := fMasterDataSource;

  ceMMargin5.DataBinding.DataSource := fMasterDataSource;
  ceMMargin6.DataBinding.DataSource := fMasterDataSource;
  cePriceCredit0.DataBinding.DataSource := fMasterDataSource;

  teURL.DataBinding.DataSource := fMasterDataSource;

  //cxDBVerticalGrid1.DataController.DataSource := fMasterDataSource;

end;

procedure TfrmGoodsForeignCodeEditorDlg.CalculateMargins;
var
  q: TIBCQuery;
//  Margin45: Double;
//  Margin56: Double;
//  Margin67: Double;
begin
//  Margin45 := (fMasterDataSet.FieldByName('price4mdl').AsFloat / fMasterDataSet.FieldByName('price5_lei').AsFloat - 1) * 100;
//  lbMargin17.Caption := FormatFloat('0.00%', (fMasterDataSet.FieldByName('price1').AsFloat / fMasterDataSet.FieldByName('price7_lei').AsFloat - 1) * 100);
  lbMargin17.Caption := FormatFloat('0.00%', fMasterDataSet.FieldByName('margin17').AsFloat);
  lbMargin37.Caption := FormatFloat('0.00%', fMasterDataSet.FieldByName('margin37').AsFloat);
  lbMargin47.Caption := FormatFloat('0.00%', fMasterDataSet.FieldByName('margin47').AsFloat);
  lbMargin57.Caption := FormatFloat('0.00%', fMasterDataSet.FieldByName('margin57').AsFloat);
  lbMargin67.Caption := FormatFloat('0.00%', fMasterDataSet.FieldByName('margin67').AsFloat);

  lbDiff67.Caption := Format('%n', [fMasterDataSet.FieldByName('Diff67').AsFloat]);
  lbDiff57.Caption := Format('%n', [fMasterDataSet.FieldByName('Diff57').AsFloat]);
  lbDiff47.Caption := Format('%n', [fMasterDataSet.FieldByName('Diff47').AsFloat]);
  lbDiff37.Caption := Format('%n', [fMasterDataSet.FieldByName('Diff37').AsFloat]);
  lbDiff17.Caption := Format('%n', [fMasterDataSet.FieldByName('Diff17').AsFloat]);

//    lbPrice7LEI.Caption := Format('%n', [fMasterDataSet.FieldByName('PRICE7_LEI').AsFloat]);
  if IBCQueryCurrency7.Active then begin
    q := TIBCQuery.Create(nil);
    try
      q.sql.Text := 'select transfer_rate from ts_currency where currencyid = :currencyid';
      q.ParamByName('Currencyid').AsInteger := IBCQueryCurrency7.FieldByName('Currencyid').AsInteger;
      q.Open;
      lbPrice7LEICalc.Caption := Format('%n', [fMasterDataSet.FieldByName('PRICE7').AsFloat * q.FieldByName
        ('Transfer_rate').AsFloat]);
    finally
      q.Free;
    end;
  end;


//  Margin56 := (fMasterDataSet.FieldByName('price5_LEI').AsFloat / fMasterDataSet.FieldByName('price6_LEI').AsFloat - 1) * 100;
//  lbMargin56.Caption := FormatFloat('0.00%', Margin56);
//  Margin67 := (fMasterDataSet.FieldByName('price6_LEI').AsFloat / fMasterDataSet.FieldByName('price7_LEI').AsFloat - 1) * 100;
//  lbMargin67.Caption := FormatFloat('0.00%', Margin67);
end;

procedure TfrmGoodsForeignCodeEditorDlg.cePrice5Exit(Sender: TObject);
begin
  CalculateMargins;
end;

// PRICE_CREDIT0 este coloana calculata in baza:
//   max(PRICE1, cost in MDL * cCredit0CostMarkup),
// cost = PRICE0 x factorul furnizorului (TPRICE_SUPPLIER_COST) sau PRICE7.
// Aici doar se afiseaza din ce se compune si cit iese rata lunara.
// Formula: DB Model\price0_global.sql.
procedure TfrmGoodsForeignCodeEditorDlg.UpdateCredit0Info;
var
  Credit0: Double;
  Price1: Double;
begin
  Credit0 := fMasterDataSet.FieldByName('PRICE_CREDIT0').AsFloat;
  Price1 := fMasterDataSet.FieldByName('PRICE1').AsFloat;

  if Credit0 <= 0 then begin
    lbCredit0Info.Caption := 'fara pret - fara rate 0%';
    Exit;
  end;

  // valoarea vine gata din baza: daca nu e pretul Web, e costul + 16%
  if Credit0 <= Price1 + 0.5 then
    lbCredit0Info.Caption := Format('= Web; rata %n MDL/luna', [Credit0 / cCredit0Months])
  else
    lbCredit0Info.Caption := Format('= Cost +16%% (Web %n); rata %n MDL/luna',
      [Price1, Credit0 / cCredit0Months]);
end;

function TfrmGoodsForeignCodeEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then begin
//        if fMasterDataSet.FieldByName('PRICE3').AsFloat > 0 then
//          fMasterDataSet.FieldByName('FLG_RRP').AsInteger := 1
//        else if (fMasterDataSet.FieldByName('PRICE3').AsFloat = 0) then
//          fMasterDataSet.FieldByName('FLG_RRP').AsInteger := 0;

    try
      fMasterDataSet.Post;
      Result := True;
    except
      on e: Exception do
        raise
    end;
    AppUserConfigStorage.IntValues.SetValue('frmGoodsForeignCodeEditorDialogSupplierID',
      fMasterDataSet.FieldByName('CUSTOMERID').AsInteger);
    AppUserConfigStorage.TextValues.SetValue('frmGoodsForeignCodeEditorDialogSupplierName', beFirma.Text);

    AppUserConfigStorage.IntValues.SetValue('frmGoodsForeignCodeEditorDialogCurrency3ID',
      fMasterDataSet.FieldByName('CURRENCY3ID').AsInteger);
    AppUserConfigStorage.IntValues.SetValue('frmGoodsForeignCodeEditorDialogCurrency4ID',
      fMasterDataSet.FieldByName('CURRENCY4ID').AsInteger);
    AppUserConfigStorage.IntValues.SetValue('frmGoodsForeignCodeEditorDialogCurrency5ID',
      fMasterDataSet.FieldByName('CURRENCY5ID').AsInteger);
    AppUserConfigStorage.IntValues.SetValue('frmGoodsForeignCodeEditorDialogCurrency6ID',
      fMasterDataSet.FieldByName('CURRENCY6ID').AsInteger);
    AppUserConfigStorage.IntValues.SetValue('frmGoodsForeignCodeEditorDialogCurrency7ID',
      fMasterDataSet.FieldByName('CURRENCY7ID').AsInteger);
    AppUserConfigStorage.IntValues.SetValue('frmGoodsForeignCodeEditorDialogORD_Currency7ID',
      fMasterDataSet.FieldByName('ORD_CURRENCY7ID').AsInteger);


    AppUserConfigStorage.IntValues.SetValue('frmGoodsForeignCodeEditorDialogFLG_IN_PRICE',
      fMasterDataSet.FieldByName('FLG_IN_PRICE').AsInteger);
    AppUserConfigStorage.IntValues.SetValue('frmGoodsForeignCodeEditorDialogFLG_EPP', fMasterDataSet.FieldByName
      ('FLG_RRP').AsInteger);
    AppUserConfigStorage.IntValues.SetValue('frmGoodsForeignCodeEditorDialogFLG_SUPPLIER_PRIORITY',
      fMasterDataSet.FieldByName('FLG_SUPPLIER_PRIORITY').AsInteger);
  end;
end;

procedure TfrmGoodsForeignCodeEditorDlg.lcbCurrency7PropertiesChange(Sender: TObject);
begin
  CalculateMargins;
end;

procedure TfrmGoodsForeignCodeEditorDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.ReadFormPos(Self);
end;

procedure TfrmGoodsForeignCodeEditorDlg.Prepare;
var
  fCurrency3ID: Integer;
begin
  inherited;
  if FCreateNewCode then begin
    dtDialogTitle.Text := 'Crearea unui cod produs furnizor nou';
    fMasterDataSet.Append;
    fMasterDataSet.FieldByName('GOODSID').asInteger := FGoodsID;

    // Load from local datastorage
    fCurrency3ID := AppUserConfigStorage.IntValues.GetValue('frmGoodsForeignCodeEditorDialogCurrency3ID',
      498);
    fCurrency4ID := AppUserConfigStorage.IntValues.GetValue('frmGoodsForeignCodeEditorDialogCurrency4ID',
      498);
    fCurrency5ID := AppUserConfigStorage.IntValues.GetValue('frmGoodsForeignCodeEditorDialogCurrency5ID',
      498);
    fCurrency6ID := AppUserConfigStorage.IntValues.GetValue('frmGoodsForeignCodeEditorDialogCurrency6ID',
      840);
    fCurrency7ID := AppUserConfigStorage.IntValues.GetValue('frmGoodsForeignCodeEditorDialogCurrency7ID',
      840);
    fORD_Currency7ID := AppUserConfigStorage.IntValues.GetValue('frmGoodsForeignCodeEditorDialogORD_Currency7ID',
      840);

    beFirma.Tag := AppUserConfigStorage.IntValues.GetValue('frmGoodsForeignCodeEditorDialogSupplierID',
      -1);
    beFirma.Text := AppUserConfigStorage.TextValues.GetValue('frmGoodsForeignCodeEditorDialogSupplierName',
      '');

    fMasterDataSet.FieldByName('CustomerID').asInteger := beFirma.Tag;
    fMasterDataSet.FieldByName('CUSTOMER_NAME').AsString := beFirma.Text;

    fMasterDataSet.FieldByName('CURRENCY1ID').asInteger := 498;
    fMasterDataSet.FieldByName('CURRENCY2ID').asInteger := 498;
    fMasterDataSet.FieldByName('CURRENCY3ID').asInteger := fCurrency3ID;
    fMasterDataSet.FieldByName('CURRENCY4ID').asInteger := fCurrency4ID;
    fMasterDataSet.FieldByName('CURRENCY5ID').asInteger := fCurrency5ID;
    fMasterDataSet.FieldByName('CURRENCY6ID').asInteger := fCurrency6ID;
    fMasterDataSet.FieldByName('CURRENCY7ID').asInteger := fCurrency7ID;
    fMasterDataSet.FieldByName('ORD_CURRENCY7ID').asInteger := fORD_Currency7ID;
    fMasterDataSet.FieldByName('PRICE2').AsFloat := 0;
    fMasterDataSet.FieldByName('PRICE3').AsFloat := 0;
    fMasterDataSet.FieldByName('PRICE4').AsFloat := 0;
    fMasterDataSet.FieldByName('PRICE5').AsFloat := 0;
    fMasterDataSet.FieldByName('PRICE6').AsFloat := 0;
    fMasterDataSet.FieldByName('PRICE7').AsFloat := 0;

    fMasterDataSet.FieldByName('FLG_SUPPLIER_PRIORITY').asInteger := 0;
    fMasterDataSet.FieldByName('FLG_AVAILABLE_QTY').asInteger := 0;
    fMasterDataSet.FieldByName('FLG_IN_PRICE').asInteger := AppUserConfigStorage.IntValues.GetValue('frmGoodsForeignCodeEditorDialogFLG_IN_PRICE',
      0);
    fMasterDataSet.FieldByName('FLG_RRP').asInteger := AppUserConfigStorage.IntValues.GetValue('frmGoodsForeignCodeEditorDialogFLG_EPP',
      0);
    fMasterDataSet.FieldByName('FLG_SUPPLIER_PRIORITY').asInteger := AppUserConfigStorage.IntValues.GetValue
      ('frmGoodsForeignCodeEditorDialogFLG_SUPPLIER_PRIORITY', 0);
    fMasterDataSet.FieldByName('GOODS_TITLE').AsString := GoodsTitle;
    fMasterDataSet.FieldByName('FLG_PREORDER').asInteger := 0;
  end
  else begin
    dtDialogTitle.Text := 'Modifica inregistrarea';
    fMasterDataSet.Edit;
    beFirma.Text := fMasterDataSet.FieldByName('CUSTOMER_NAME').AsString;

    if VarIsNull(fMasterDataSet.FieldByName('PRICE5').Value) then
      fMasterDataSet.FieldByName('PRICE5').Value := fMasterDataSet.FieldByName('PRICE4').Value;

    bbGenerateCode.Enabled := True;
    sbTakeCode.Enabled := True;
    sbTakeDesc.Enabled := True;

  end;

  IBCQueryCurrency7.Active := True;
  IBCQueryCurrency4.Active := True;
  IBCQueryCurrency.Open;

  CalculateMargins;
  UpdateCredit0Info;

end;

procedure TfrmGoodsForeignCodeEditorDlg.SaveStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

procedure TfrmGoodsForeignCodeEditorDlg.sbTakeCodeClick(Sender: TObject);
begin
  fMasterDataSet.FieldByName('GOODS_CODE').AsString := FGoodsCode;
end;

procedure TfrmGoodsForeignCodeEditorDlg.sbTakeDescClick(Sender: TObject);
begin
  fMasterDataSet.FieldByName('GOODS_TITLE').AsString := GoodsTitle;
end;

procedure TfrmGoodsForeignCodeEditorDlg.SelectFirma;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('CUSTOMERID').asInteger) then begin
      fMasterDataSet.FieldByName('CUSTOMERID').asInteger := dialog.CustomerID;

      beFirma.Tag := dialog.CustomerID;
      beFirma.Text := dialog.CustomerTitle;

      edGOODS_CODE.SetFocus;

      bbGenerateCode.Enabled := True;
      sbTakeCode.Enabled := True;
      sbTakeDesc.Enabled := True;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsForeignCodeEditorDlg.SetCreateNewCode(const Value: Boolean);
begin
  FCreateNewCode := Value;
end;

procedure TfrmGoodsForeignCodeEditorDlg.SetCurrency4ID(const Value: Integer);
begin
  FCurrency4ID := Value;
end;

procedure TfrmGoodsForeignCodeEditorDlg.SetCurrency5ID(const Value: Integer);
begin
  FCurrency5ID := Value;
end;

procedure TfrmGoodsForeignCodeEditorDlg.SetCurrency6ID(const Value: Integer);
begin
  FCurrency6ID := Value;
end;

procedure TfrmGoodsForeignCodeEditorDlg.SetGoodsCode(const Value: string);
begin
  FGoodsCode := Value;
end;

procedure TfrmGoodsForeignCodeEditorDlg.SetGoodsDesc(const Value: string);
begin
  FGoodsDesc := Value;
end;

procedure TfrmGoodsForeignCodeEditorDlg.SetGoodsID(const Value: Integer);
begin
  FGoodsID := Value;
end;

procedure TfrmGoodsForeignCodeEditorDlg.SetGoodsTitle(const Value: string);
begin
  FGoodsTitle := Value;
end;

procedure TfrmGoodsForeignCodeEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
end;

end.

