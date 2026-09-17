unit frmPricelistCurrencyUnit;

{
  Alegerea valutelor la importul unui pricelist: valuta RRP (coloana "Val. Vinz."
  -> CURRENCY3ID) si valuta pretului de intrare (coloana "Val. 7" -> CURRENCY0ID
  si CURRENCY7ID).
}

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Menus,
  SWNBaseUnit,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  cxCheckBox,
  cxButtons,
  Data.DB,
  DBAccess,
  IBC,
  MemDS;

type
  TfrmPricelistCurrencyDlg = class(TSWNBaseFormClass)
    lbInfo: TLabel;
    lbRRP: TLabel;
    lcbRRP: TcxLookupComboBox;
    lbPurchase: TLabel;
    lcbPurchase: TcxLookupComboBox;
    cbOverwrite: TcxCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    IBCQueryCurrency: TIBCQuery;
    IBCDataSourceCurrency: TIBCDataSource;
  private
    FRRPCurrencyID: Integer;
    FPurchaseCurrencyID: Integer;
    FOverwriteExisting: Boolean;
    function GetCurrencyTitle(const ACurrencyID: Integer): string;
    function GetRRPCurrencyName: string;
    function GetPurchaseCurrencyName: string;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    property RRPCurrencyID: Integer read FRRPCurrencyID write FRRPCurrencyID;
    property PurchaseCurrencyID: Integer read FPurchaseCurrencyID write FPurchaseCurrencyID;
    property OverwriteExisting: Boolean read FOverwriteExisting write FOverwriteExisting;
    property RRPCurrencyName: string read GetRRPCurrencyName;
    property PurchaseCurrencyName: string read GetPurchaseCurrencyName;
  end;

implementation

{$R *.dfm}

uses
  System.UITypes;

function TfrmPricelistCurrencyDlg.GetCurrencyTitle(const ACurrencyID: Integer): string;
begin
  Result := VarToStr(IBCQueryCurrency.Lookup('CURRENCYID', ACurrencyID, 'TITLE')).Trim;
end;

function TfrmPricelistCurrencyDlg.GetPurchaseCurrencyName: string;
begin
  Result := GetCurrencyTitle(FPurchaseCurrencyID);
end;

function TfrmPricelistCurrencyDlg.GetRRPCurrencyName: string;
begin
  Result := GetCurrencyTitle(FRRPCurrencyID);
end;

function TfrmPricelistCurrencyDlg.IsFormDataPosted: Boolean;
begin
  Result := False;

  if VarIsNull(lcbRRP.EditValue) or VarIsEmpty(lcbRRP.EditValue) then
  begin
    MessageDlg('Alegeti valuta RRP!', mtError, [mbOK], 0);
    lcbRRP.SetFocus;
    Exit;
  end;

  if VarIsNull(lcbPurchase.EditValue) or VarIsEmpty(lcbPurchase.EditValue) then
  begin
    MessageDlg('Alegeti valuta pretului de intrare!', mtError, [mbOK], 0);
    lcbPurchase.SetFocus;
    Exit;
  end;

  FRRPCurrencyID := lcbRRP.EditValue;
  FPurchaseCurrencyID := lcbPurchase.EditValue;
  FOverwriteExisting := cbOverwrite.Checked;
  Result := True;
end;

procedure TfrmPricelistCurrencyDlg.Prepare;
begin
  inherited;
  IBCQueryCurrency.Connection := fIBCConnection;
  IBCQueryCurrency.Open;

  if FRRPCurrencyID > 0 then
    lcbRRP.EditValue := FRRPCurrencyID;
  if FPurchaseCurrencyID > 0 then
    lcbPurchase.EditValue := FPurchaseCurrencyID;
  cbOverwrite.Checked := FOverwriteExisting;
end;

end.
