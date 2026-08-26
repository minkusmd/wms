unit frmWebSelectGoodsSupplierUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxTextEdit,
  cxMaskEdit, cxButtonEdit, Vcl.ExtCtrls, DialogTitle, SWNBaseUnit, IBC, Data.DB, DBAccess, MemDS, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCalc, System.Actions, Vcl.ActnList, dxCoreGraphics;

type
  TOnCheckIfGoodsExists = function(const SupplierID: integer; const GoodsCode: string): Boolean of object;

type
  TfrmWebSelectGoodsSupplierDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    cbCurrency: TcxLookupComboBox;
    Label3: TLabel;
    IBCQueryCurrency: TIBCQuery;
    IBCDataSourceCurrency: TIBCDataSource;
    Label4: TLabel;
    IBCQueryGoodsForeign: TIBCQuery;
    IBCDataSourceGoodsForeign: TIBCDataSource;
    lcbGoodsSuppliers: TcxLookupComboBox;
    IBCQueryGoodsSuppliers: TIBCQuery;
    IBCDataSourceGoodsSuppliers: TIBCDataSource;
    lcbSupplierGoodsCode: TcxLookupComboBox;
    Label5: TLabel;
    cePrice: TcxCalcEdit;
    ActionList1: TActionList;
    actFindByGoodsID: TAction;
    teGoods: TcxTextEdit;
    procedure actFindByGoodsIDExecute(Sender: TObject);
    procedure beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure lcbGoodsSuppliersPropertiesInitPopup(Sender: TObject);
    procedure lcbGoodsSuppliersPropertiesCloseUp(Sender: TObject);
    procedure lcbSupplierGoodsCodePropertiesInitPopup(Sender: TObject);
  private
    FGoodsCode: string;
    FGoodsCurrencyID: integer;
    FGoodsID: integer;
    FGoodsName: string;
    FGoodsPromoPrice: Double;
    FGoodsTitle: string;
    FSupplierID: integer;
    FSupplierName: string;
    FPromoPrice: Double;
    FCurrencyID: integer;
    procedure RefreshGoodsCode(GoodsID, SupplierID: Integer);
    procedure SetGoodsCode(const Value: string);
    procedure SetGoodsCurrencyID(const Value: integer);
    procedure SetGoodsID(const Value: integer);
    procedure SetGoodsName(const Value: string);
    procedure SetGoodsPromoPrice(const Value: Double);
    procedure SetGoodsTitle(const Value: string);
    procedure SetSupplierID(const Value: integer);
    procedure SetSupplierName(const Value: string);
        { Private declarations }
  protected
    procedure WhenBurstAddGoods(const GoodsID: Integer; const GoodsTitle: string; var Added: Boolean; var Count: Integer);
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    property GoodsCode: string read FGoodsCode write SetGoodsCode;
    property GoodsCurrencyID: integer read FGoodsCurrencyID write SetGoodsCurrencyID;
    property GoodsID: integer read FGoodsID write SetGoodsID;
    property GoodsName: string read FGoodsName write SetGoodsName;
    property GoodsPromoPrice: Double read FGoodsPromoPrice write SetGoodsPromoPrice;
    property GoodsTitle: string read FGoodsTitle write SetGoodsTitle;
    property SupplierID: integer read FSupplierID write SetSupplierID;
    property SupplierName: string read FSupplierName write SetSupplierName;
    property PromoPrice: Double read FPromoPrice write FPromoPrice;
    property CurrencyID: integer read FCurrencyID write FCurrencyID;

  published
  end;

var
  frmWebSelectGoodsSupplierDlg: TfrmWebSelectGoodsSupplierDlg;

implementation

uses
  DataModuleAdditions, frmGoods, frmCustomersDlg, SWNValueStorageUnit;

{$R *.dfm}
{ TfrmWebSelectGoodsDlg }

procedure TfrmWebSelectGoodsSupplierDlg.beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
var
  dialog: TfrmGoodsBrowser;
  tmpGoodsID: integer;
begin
  {dialog := TfrmGoodsBrowser.Create(Self);
  try
    tmpGoodsID := StrToIntDef(beGoods.Text, -1);

    if (tmpGoodsID > 1) then
      fGoodsID := tmpGoodsID;
    dialog.OnBurstAddGoods := WhenBurstAddGoods;
    if dialog.SelectGoods(FGoodsID, True) then
    begin
      GoodsID := dialog.GoodsID;
      IBCQueryGoodsSuppliers.Close;
      IBCQueryGoodsSuppliers.ParamByName('GOODSID').AsInteger := dialog.GoodsID;
      IBCQueryGoodsSuppliers.Open;

      if IBCQueryGoodsSuppliers.RecordCount > 0 then
        lcbGoodsSuppliers.Text := IBCQueryGoodsSuppliers.FieldByName('customer_name').AsString;

      SupplierID := IBCQueryGoodsSuppliers.FieldByName('CUSTOMERID').AsInteger;
      RefreshGoodsCode(GoodsID, SupplierID);

      GoodsID := dialog.GoodsID;
      GoodsTitle := dialog.GoodsTitle;
      GoodsCurrencyID := IBCQueryCurrency.FieldByName('CURRENCYID').AsInteger;
      beGoods.Tag := dialog.GoodsID;
      beGoods.Text := dialog.GoodsTitle;
      if dialog.GoodsPriceCurrencyID = 498 then
      begin
        GoodsPromoPrice := dialog.GoodsPriceMDL[1];
        GoodsCurrencyID := cbCurrency.EditValue;
      end
      else
      begin
        GoodsPromoPrice := dialog.GoodsPromoPrice;
        GoodsCurrencyID := dialog.GoodsPriceCurrencyID;

      end;
      cePrice.Value := GoodsPromoPrice;
    end;

  finally
    dialog.Free;
  end;
  }
end;

procedure TfrmWebSelectGoodsSupplierDlg.actFindByGoodsIDExecute(Sender: TObject);
//var
//  query: TIBCQuery;
begin
//  GoodsID := StrToIntDef(beGoods.Text, -1);
//  IBCQueryGoodsSuppliers.Close;
//  IBCQueryGoodsSuppliers.ParamByName('GOODSID').AsInteger := GoodsID;
//  IBCQueryGoodsSuppliers.Open;
//
//  if IBCQueryGoodsSuppliers.RecordCount > 0 then
//    lcbGoodsSuppliers.Text := IBCQueryGoodsSuppliers.FieldByName('customer_name').AsString;
//
//  SupplierID := IBCQueryGoodsSuppliers.FieldByName('CUSTOMERID').AsInteger;
//  RefreshGoodsCode(GoodsID, SupplierID);
//
//  query := TIBCQuery.Create(nil);
//  GoodsTitle := '';
//  try
//    query.Sql.Text := 'select title from ts_goods where goodsid = :goodsid';
//    query.ParamByName('goodsid').AsInteger := GoodsID;
//    query.Open;
//    GoodsTitle := query.FieldByName('title').AsString;
//  finally
//    query.Free;
//  end;
//
//  GoodsCurrencyID := IBCQueryCurrency.FieldByName('CURRENCYID').AsInteger;
//  beGoods.Tag := GoodsID;
//  beGoods.Text := GoodsTitle;
//
//  // get goods price
//  query := TIBCQuery.Create(nil);
//  GoodsPromoPrice := 0;
//  GoodsCurrencyID := 498;
//  try
//    query.SQL.Text := 'select price_mdl from get_goods_price(:goodsid, 1, 498)';
//    query.ParamByName('goodsid').AsInteger := GoodsID;
//    query.Open;
//    GoodsPromoPrice := query.FieldByName('price_mdl').AsFloat;
//    GoodsCurrencyID := 498;
//  finally
//    query.Free;
//  end;
//  cePrice.Value := GoodsPromoPrice;
end;

function TfrmWebSelectGoodsSupplierDlg.IsFormDataPosted: Boolean;
begin
  GoodsCurrencyID := IBCQueryCurrency.FieldByName('CURRENCYID').AsInteger;
  GoodsCode := lcbSupplierGoodsCode.Text;
  GoodsPromoPrice := cePrice.Value;
  Supplierid := IBCQueryGoodsSuppliers.FieldByName('customerid').AsInteger;
  SupplierName := IBCQueryGoodsSuppliers.FieldByName('customer_name').AsString;

  if (GoodsCode = '') then
  begin
    ShowMessage('Cod produs furnizor trebuie indicat');
    Result := false
  end;

  Result := True;
end;

procedure TfrmWebSelectGoodsSupplierDlg.lcbGoodsSuppliersPropertiesCloseUp(Sender: TObject);
begin
  SupplierID := IBCQueryGoodsSuppliers.FieldByName('customerid').AsInteger;
  RefreshGoodsCode(GoodsID, SupplierID);
end;

procedure TfrmWebSelectGoodsSupplierDlg.lcbGoodsSuppliersPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryGoodsSuppliers.Close;
  IBCQueryGoodsSuppliers.ParamByName('GOODSID').AsInteger := GoodsID;
  IBCQueryGoodsSuppliers.Open;
end;

procedure TfrmWebSelectGoodsSupplierDlg.lcbSupplierGoodsCodePropertiesInitPopup(Sender: TObject);
begin
  if trim(lcbSupplierGoodsCode.Text) = '' then
    RefreshGoodsCode(GoodsID, SupplierID);
end;

procedure TfrmWebSelectGoodsSupplierDlg.RefreshGoodsCode(GoodsID, SupplierID: Integer);
begin
  IBCQueryGoodsForeign.Close;
  IBCQueryGoodsForeign.ParamByName('GOODSID').AsInteger := GoodsID;
  IBCQueryGoodsForeign.ParamByName('CUSTOMERID').AsInteger := SupplierID;
  IBCQueryGoodsForeign.Open;
  if IBCQueryGoodsForeign.RecordCount > 0 then
  begin
    lcbSupplierGoodsCode.Text := IBCQueryGoodsForeign.FieldByName('goods_code').AsString;
  end;
end;

procedure TfrmWebSelectGoodsSupplierDlg.Prepare;
begin
  teGoods.Tag := GoodsID;
  teGoods.Text := GoodsName;

  // gasim furnizorii disponibil pentru acest produs
  IBCQueryGoodsSuppliers.ParamByName('GoodsID').AsInteger := GoodsID;
  IBCQueryGoodsSuppliers.Open;
  lcbGoodsSuppliers.EditValue := IBCQueryGoodsSuppliers.FieldByName('customerid').AsInteger;

  // gasim goodscode pentru furnizorul selectat
  IBCQueryGoodsForeign.ParamByName('CUSTOMERID').AsInteger := SupplierID;
  IBCQueryGoodsForeign.ParamByName('GOODSID').AsInteger := GoodsID;
  IBCQueryGoodsForeign.Open;
  lcbSupplierGoodsCode.EditValue := IBCQueryGoodsForeign.FieldByName('goods_code').AsString;

  cePrice.Value := IBCQueryGoodsForeign.FieldByName('price1').AsFloat;

  IBCQueryCurrency.Open;
  cbCurrency.EditValue := IBCQueryGoodsForeign.FieldByName('currency1id').AsInteger;

//  RefreshGoodsCode(GoodsID, SupplierID);
end;

procedure TfrmWebSelectGoodsSupplierDlg.SetGoodsCode(const Value: string);
begin
  FGoodsCode := Value;
end;

procedure TfrmWebSelectGoodsSupplierDlg.SetGoodsCurrencyID(const Value: integer);
begin
  FGoodsCurrencyID := Value;
end;

procedure TfrmWebSelectGoodsSupplierDlg.SetGoodsID(const Value: integer);
begin
  FGoodsID := Value;
end;

procedure TfrmWebSelectGoodsSupplierDlg.SetGoodsName(const Value: string);
begin
  FGoodsName := Value;
end;

procedure TfrmWebSelectGoodsSupplierDlg.SetGoodsPromoPrice(const Value: Double);
begin
  FGoodsPromoPrice := Value;
end;

procedure TfrmWebSelectGoodsSupplierDlg.SetGoodsTitle(const Value: string);
begin
  FGoodsTitle := Value;
end;

procedure TfrmWebSelectGoodsSupplierDlg.SetSupplierID(const Value: integer);
begin
  FSupplierID := Value;
end;

procedure TfrmWebSelectGoodsSupplierDlg.SetSupplierName(const Value: string);
begin
  FSupplierName := Value;
end;

procedure TfrmWebSelectGoodsSupplierDlg.WhenBurstAddGoods(const GoodsID: Integer; const GoodsTitle: string; var Added:
  Boolean; var Count: Integer);
begin

end;

end.

