unit frmPredvaritelnieZakaziGoodsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls,
  Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxCalc, cxDBEdit, cxCheckBox;

type
  TfrmPredvaritelnieZakaziGoodsDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    pnButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    pnApproveInfo: TPanel;
    pnBaseInfo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    beGoods: TcxButtonEdit;
    ceQTY: TcxDBCalcEdit;
    ceSELL_PRICE: TcxDBCalcEdit;
    lcbSELL_CURRENCY_ID: TcxDBLookupComboBox;
    Label5: TLabel;
    beSupplier: TcxButtonEdit;
    cbFLG_ACNT: TcxDBCheckBox;
    Label6: TLabel;
    ceSUPPLIER_PRICE: TcxDBCalcEdit;
    lcbSUPRLIER_CURRENCY_ID: TcxDBLookupComboBox;
    Label7: TLabel;
    Label8: TLabel;
    ceSUPPLIER_QTY: TcxDBCalcEdit;
    lbPriceTitlePreorderToSupplier: TLabel;
    lbPriceTitleSupplierToPreorder: TLabel;
    edPriceSupplierToPreorder: TcxCalcEdit;
    edPricePreorderToSupplier: TcxCalcEdit;
    procedure beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beSupplierPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure lcbSELL_CURRENCY_IDPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    FReadOnly: Boolean;
    FCreateNewDocument: Boolean;
    FGoodsPartOnly: Boolean;
    fInPrepare: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    procedure SetReadOnly(const Value: Boolean);
    function CheckParams: Boolean;
    procedure SetGoodsPartOnly(const Value: Boolean);
    procedure ShowSelectGoodsDialog;
    procedure ShowSelectSupplierDialog;
    procedure TransformCurrencies;
    procedure SetupQTYFields;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read FCreateNewDocument write SetCreateNewDocument;
    property readonly: Boolean read FReadOnly write SetReadOnly;
    property GoodsPartOnly: Boolean read FGoodsPartOnly write SetGoodsPartOnly;
  end;

implementation

uses
  Data.DB, DataModuleAdditions, SWNConst, DataModuleDB, SWNUtils, frmGoods,
  frmCustomersDlg, SWNValueStorageUnit;

{$R *.dfm}


{ TForm2 }

procedure TfrmPredvaritelnieZakaziGoodsDlg.beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectGoodsDialog;
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.beSupplierPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectSupplierDialog;
end;

function TfrmPredvaritelnieZakaziGoodsDlg.CheckParams: Boolean;
var
  Errors: string;
begin
  Result := False;
  Errors := '';

  if fMasterDataSet.FieldByName('GOODSID').IsNull or (fMasterDataSet.FieldByName('GOODSID').AsInteger <= 0) then
    AddErrorToStr(Errors, 'Наименование!');
  if fMasterDataSet.FieldByName('QTY').IsNull or (fMasterDataSet.FieldByName('QTY').AsInteger <= 0) then
    AddErrorToStr(Errors, 'Количество!');
  if fMasterDataSet.FieldByName('SELL_PRICE').IsNull or (fMasterDataSet.FieldByName('SELL_PRICE').AsInteger <= 0) then
    AddErrorToStr(Errors, 'Цена продажи!');
  if fMasterDataSet.FieldByName('SELL_CURRENCY_ID').IsNull then
    AddErrorToStr(Errors, 'Валюта продажи!')
  else
  begin
    if (fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1) and (fMasterDataSet.FieldByName('SELL_CURRENCY_ID').AsInteger <> 498) then
      AddErrorToStr(Errors, 'По бухгалтерии! Валюта продажи должна быть в Леях!');
  end;

     // approve part
  if not fMasterDataSet.FieldByName('SUPPLIER_ID').IsNull and (fMasterDataSet.FieldByName('SUPPLIER_ID').AsInteger > 0) then
  begin
    if fMasterDataSet.FieldByName('SUPPLIER_QTY').IsNull or (fMasterDataSet.FieldByName('SUPPLIER_QTY').AsInteger <= 0) then
      AddErrorToStr(Errors, 'Количество у поставщика!');
    if fMasterDataSet.FieldByName('SUPPLIER_PRICE').IsNull or (fMasterDataSet.FieldByName('SUPPLIER_PRICE').AsInteger <= 0) then
      AddErrorToStr(Errors, 'Цена у поставщика!');
    if fMasterDataSet.FieldByName('SUPRLIER_CURRENCY_ID').IsNull then
      AddErrorToStr(Errors, 'Валюта у поставщика!')
    else
    begin
      if (fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1) and (fMasterDataSet.FieldByName('SUPRLIER_CURRENCY_ID').AsInteger <> 498) then
        AddErrorToStr(Errors, 'По бухгалтерии! Валюта у поставщика должна быть в Леях!');
    end;
  end;

  if (Errors = '') then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.BindingDataSource;
begin
  fInPrepare := True;
  FGoodsPartOnly := True;

  ceQTY.DataBinding.DataSource := fMasterDataSource;
  ceSELL_PRICE.DataBinding.DataSource := fMasterDataSource;
  lcbSELL_CURRENCY_ID.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ACNT.DataBinding.DataSource := fMasterDataSource;
  ceSUPPLIER_QTY.DataBinding.DataSource := fMasterDataSource;
  ceSUPPLIER_PRICE.DataBinding.DataSource := fMasterDataSource;
  lcbSUPRLIER_CURRENCY_ID.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmPredvaritelnieZakaziGoodsDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.lcbSELL_CURRENCY_IDPropertiesEditValueChanged(Sender: TObject);
begin
  TransformCurrencies;
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.Prepare;
begin
  SetupQTYFields;

     // ascundem partea pentru Approve
  pnApproveInfo.Visible := not fGoodsPartOnly;
  lbPriceTitlePreorderToSupplier.Visible := not fGoodsPartOnly;
  edPricePreorderToSupplier.Visible := not fGoodsPartOnly;

  if not FReadOnly then
    fMasterDataSet.UpdateTransaction.StartTransaction;

  try
        // open additional data sources
    dmDB.IBCQueryCurrency.Active := True;

    if FCreateNewDocument then
    begin
             // create new record
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
      fMasterDataSet.Insert;
             // defaults
      fMasterDataSet.FieldByName('QTY').AsInteger := 0;
      fMasterDataSet.FieldByName('SELL_CURRENCY_ID').AsInteger := 498;
      fMasterDataSet.FieldByName('SELL_PRICE').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;

      fMasterDataSet.FieldByName('SUPPLIER_ID').AsInteger := -1;
      fMasterDataSet.FieldByName('SUPPLIER_QTY').AsInteger := 0;
      fMasterDataSet.FieldByName('SUPPLIER_PRICE').AsInteger := 0;
      fMasterDataSet.FieldByName('SUPRLIER_CURRENCY_ID').AsInteger := 498;
    end
    else
    begin
      if FReadOnly then
      begin
                  // view record
        dtDialogTitle.Text := Format(cMSG_DIALOG_GOODS_ViewOnly, [fMasterDataSet.FieldByName('GOODSID').AsInteger]);
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        pnClient.Enabled := False;
        btnOK.Visible := False;
        btnCancel.Caption := cMSG_ButtonClose;
        btnCancel.Default := True;
      end
      else
      begin
                  // edit record
        dtDialogTitle.Text := Format(cMSG_DIALOG_GOODS_ViewOnly, [fMasterDataSet.FieldByName('GOODSID').AsInteger]);
        fMasterDataSet.Edit;
      end;
    end;
    if fMasterDataSet.FieldByName('GOODSID').AsInteger > 0 then
      beGoods.Text := fMasterDataSet.FieldByName('GOODS_TITLE').AsString;
    if fMasterDataSet.FieldByName('SUPPLIER_ID').AsInteger > 0 then
      beSupplier.Text := fMasterDataSet.FieldByName('SUPPLIER_TITLE').AsString;
  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
    if not FReadOnly then
      fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
  fInPrepare := False;
  if fMasterDataSet.FieldByName('GOODSID').AsInteger > 0 then
    TransformCurrencies;
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.SetCreateNewDocument(const Value: Boolean);
begin
  FCreateNewDocument := Value;
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.SetGoodsPartOnly(const Value: Boolean);
begin
  FGoodsPartOnly := Value;
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.SetupQTYFields;
var
  qtyDigitsMode: Integer;
begin
     // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
  TcxCalcEditProperties(ceSUPPLIER_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  TcxCalcEditProperties(ceQTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.ShowSelectGoodsDialog;
var
  dialog: TfrmGoodsBrowser;
  suma: Currency;
  exRate: double;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    if dialog.SelectGoods(fMasterDataSet.FieldByName('GOODSID').AsInteger, false, 0, 'Выберите товар для Предварительного заказа') then
    begin
      fMasterDataSet.FieldByName('GOODSID').AsInteger := dialog.GoodsID;
      beGoods.Text := dialog.GoodsTitle;
      if (dmDB.TransformCurrency1(dialog.GoodsPrice[1], dialog.GoodsPriceCurrencyID, fMasterDataSet.FieldByName('SELL_CURRENCY_ID').AsInteger, fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1, suma, exRate, true, true, false)) then
        fMasterDataSet.FieldByName('SELL_PRICE').AsCurrency := suma;
      if fMasterDataSet.FieldByName('QTY').IsNull or (fMasterDataSet.FieldByName('QTY').AsInteger = 0) then
        fMasterDataSet.FieldByName('QTY').AsInteger := 1;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.ShowSelectSupplierDialog;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('SUPPLIER_ID').AsInteger, false, 0, 'Выберите поставщика для Предварительного заказа') then
    begin
      fMasterDataSet.FieldByName('SUPPLIER_ID').AsInteger := dialog.CustomerID;
      beSupplier.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.TransformCurrencies;
var
  outSuma: Currency;
  outRate: Double;
begin
  if fInPrepare {or Not (fMasterDataSet.State in dsEditModes)} then
    Exit;

     // transformam din pretul spre comanda in pretul furnizorului
  if dmDB.TransformCurrency1(fMasterDataSet.FieldByName('SELL_PRICE').AsCurrency, fMasterDataSet.FieldByName('SELL_CURRENCY_ID').AsInteger, fMasterDataSet.FieldByName('SUPRLIER_CURRENCY_ID').AsInteger, fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1, outSuma, outRate, true, true) then
    edPricePreorderToSupplier.Value := outSuma
  else
    edPricePreorderToSupplier.Text := '';

  lbPriceTitleSupplierToPreorder.Caption := Format('Цена %s', [lcbSELL_CURRENCY_ID.Text]);

     // transformam din pretul furnizorului in pretul comenzii
  if dmDB.TransformCurrency1(fMasterDataSet.FieldByName('SUPPLIER_PRICE').AsCurrency, fMasterDataSet.FieldByName('SUPRLIER_CURRENCY_ID').AsInteger, fMasterDataSet.FieldByName('SELL_CURRENCY_ID').AsInteger, fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1, outSuma, outRate, true, true) then
    edPriceSupplierToPreorder.Value := outSuma
  else
    edPriceSupplierToPreorder.Text := '';

  lbPriceTitlePreorderToSupplier.Caption := Format('Цена %s', [lcbSUPRLIER_CURRENCY_ID.Text]);
end;

procedure TfrmPredvaritelnieZakaziGoodsDlg.WhenCancelForm;
begin
  if not FReadOnly then
  begin
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
  end;
end;

end.

