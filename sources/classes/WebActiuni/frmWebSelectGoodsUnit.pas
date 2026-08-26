unit frmWebSelectGoodsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxTextEdit,
  cxMaskEdit, cxButtonEdit, Vcl.ExtCtrls, DialogTitle, SWNBaseUnit, IBC, Data.DB, DBAccess, MemDS, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCalc, System.Actions, Vcl.ActnList, dxCoreGraphics;

type
     { TODO -c01.12.2021 : De modificat in GoodsCode }
  TOnCheckIfGoodsExists = function(const SupplierID: integer; const GoodsCode: string): Boolean of object;

  TOnAddGoods = function(const SupplierID, GoodsID: integer; GoodsCode: string; Price1, Price2, Price3, Price4, Price5:
    Currency; CurrencyID: integer): Boolean of object;

  TOnAddGoodsFolder = procedure(const SupplierID, GoodsFolderID: integer) of object;

  TfrmWebSelectGoodsDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    beGoods: TcxButtonEdit;
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
    FGoodsPrice: Double;
    FGoodsTitle: string;
    FOnAddGoods: TOnAddGoods;
    FOnAddGoodsFolder: TOnAddGoodsFolder;
    FSupplierID: integer;
    FSupplierName: string;
    procedure RefreshGoodsCode(GoodsID, SupplierID: Integer);
    procedure SetGoodsCode(const Value: string);
    procedure SetGoodsCurrencyID(const Value: integer);
    procedure SetGoodsID(const Value: integer);
    procedure SetGoodsName(const Value: string);
    procedure SetGoodsPrice(const Value: Double);
    procedure SetGoodsTitle(const Value: string);
    procedure SetOnAddGoods(const Value: TOnAddGoods);
    procedure SetOnAddGoodsFolder(const Value: TOnAddGoodsFolder);
    procedure SetSupplierID(const Value: integer);
    procedure SetSupplierName(const Value: string);
        { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    constructor Create(const AOwner: TComponent; const IBCConnection: TIBCConnection); override;
    property GoodsCode: string read FGoodsCode write SetGoodsCode;
    property GoodsCurrencyID: integer read FGoodsCurrencyID write SetGoodsCurrencyID;
    property GoodsID: integer read FGoodsID write SetGoodsID;
    property GoodsName: string read FGoodsName write SetGoodsName;
    property GoodsPrice: Double read FGoodsPrice write SetGoodsPrice;
    property GoodsTitle: string read FGoodsTitle write SetGoodsTitle;
    property SupplierID: integer read FSupplierID write SetSupplierID;
    property SupplierName: string read FSupplierName write SetSupplierName;
  published
    property OnAddGoods: TOnAddGoods read FOnAddGoods write SetOnAddGoods;
    property OnAddGoodsFolder: TOnAddGoodsFolder read FOnAddGoodsFolder write SetOnAddGoodsFolder;
  end;

var
  frmWebSelectGoodsDlg: TfrmWebSelectGoodsDlg;

implementation

uses
  DataModuleAdditions, frmGoods, frmCustomersDlg, SWNValueStorageUnit;

{$R *.dfm}
{ TfrmWebSelectGoodsDlg }

procedure TfrmWebSelectGoodsDlg.beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
var
  dialog: TfrmGoodsBrowser;
  tmpGoodsID: integer;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    tmpGoodsID := StrToIntDef(beGoods.Text, -1);

    if (tmpGoodsID > 1) then
      fGoodsID := tmpGoodsID;

    if dialog.SelectGoods(FGoodsID, True) then
    begin
//            AppUserConfigStorage.IntValues.SetValue('frmWebPromoGoodsDlg_Last_GOODSID', dialog.GoodsID);
//            AppUserConfigStorage.TextValues.SetValue('frmWebPromoGoodsDlg_Last_GoodsName', dialog.GoodsTitle);
      GoodsID := dialog.GoodsID;
      IBCQueryGoodsSuppliers.Close;
      IBCQueryGoodsSuppliers.ParamByName('GOODSID').AsInteger := dialog.GoodsID;
      IBCQueryGoodsSuppliers.Open;

      if IBCQueryGoodsSuppliers.RecordCount > 0 then
        lcbGoodsSuppliers.Text := IBCQueryGoodsSuppliers.FieldByName('customer_name').AsString;

      SupplierID := IBCQueryGoodsSuppliers.FieldByName('CUSTOMERID').AsInteger;
      RefreshGoodsCode(GoodsID, SupplierID);

      if dialog.GoodsIsFolder then
      begin
        if Assigned(OnAddGoodsFolder) then
          fOnAddGoodsFolder(FSupplierID, dialog.GoodsID);
                // IBCQueryGoods.Refresh;
      end
      else
      begin
                // if Assigned(FOnCheckIfGoodsExists) then
        begin
                    // if not FOnCheckIfGoodsExists(dialog.GoodsID) then // verificam daca nu este produsul deja in lista
          begin
                        // if Assigned(OnAddGoods) then
            begin
              GoodsID := dialog.GoodsID;
              GoodsTitle := dialog.GoodsTitle;
              GoodsCurrencyID := IBCQueryCurrency.FieldByName('CURRENCYID').AsInteger;
              beGoods.Tag := dialog.GoodsID;
              beGoods.Text := dialog.GoodsTitle;
              if dialog.GoodsPriceCurrencyID = 498 then
              begin
                GoodsPrice := dialog.GoodsPriceMDL[1];
                GoodsCurrencyID := cbCurrency.EditValue;
              end
              else
              begin
                GoodsPrice := dialog.GoodsPrice[1];
                GoodsCurrencyID := dialog.GoodsPriceCurrencyID;

              end;
              cePrice.Value := GoodsPrice;
            end;
          end;
        end;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

constructor TfrmWebSelectGoodsDlg.Create(const AOwner: TComponent; const IBCConnection: TIBCConnection);
begin
  inherited;
//  FOnCheckIfGoodsExists := nil;
end;

procedure TfrmWebSelectGoodsDlg.actFindByGoodsIDExecute(Sender: TObject);
var
  query: TIBCQuery;
begin
  GoodsID := StrToIntDef(beGoods.Text, -1);
  IBCQueryGoodsSuppliers.Close;
  IBCQueryGoodsSuppliers.ParamByName('GOODSID').AsInteger := GoodsID;
  IBCQueryGoodsSuppliers.Open;

  if IBCQueryGoodsSuppliers.RecordCount > 0 then
    lcbGoodsSuppliers.Text := IBCQueryGoodsSuppliers.FieldByName('customer_name').AsString;

  SupplierID := IBCQueryGoodsSuppliers.FieldByName('CUSTOMERID').AsInteger;
  RefreshGoodsCode(GoodsID, SupplierID);

  query := TIBCQuery.Create(nil);
  GoodsTitle := '';
  try
    query.Sql.Text := 'select title from ts_goods where goodsid = :goodsid';
    query.ParamByName('goodsid').AsInteger := GoodsID;
    query.Open;
    GoodsTitle := query.FieldByName('title').AsString;
  finally
    query.Free;
  end;

  GoodsCurrencyID := IBCQueryCurrency.FieldByName('CURRENCYID').AsInteger;
  beGoods.Tag := GoodsID;
  beGoods.Text := GoodsTitle;

  // get goods price
  query := TIBCQuery.Create(nil);
  GoodsPrice := 0;
  GoodsCurrencyID := 498;
  try
    query.SQL.Text := 'select price_mdl from get_goods_price(:goodsid, 1, 498)';
    query.ParamByName('goodsid').AsInteger := GoodsID;
    query.Open;
    GoodsPrice := query.FieldByName('price_mdl').AsFloat;
    GoodsCurrencyID := 498;
  finally
    query.Free;
  end;
  cePrice.Value := GoodsPrice;
end;

function TfrmWebSelectGoodsDlg.IsFormDataPosted: Boolean;
begin
  GoodsCurrencyID := IBCQueryCurrency.FieldByName('CURRENCYID').AsInteger;
  GoodsCode := lcbSupplierGoodsCode.Text; // IBCQueryGoodsForeign.FieldByName('GOODS_CODE').AsString;
  GoodsPrice := cePrice.Value;
  if (goodscode = '') then
  begin
    ShowMessage('Cod produs furnizor trebuie indicat');
    Result := false
  end;

  Result := True;
end;

procedure TfrmWebSelectGoodsDlg.lcbGoodsSuppliersPropertiesCloseUp(Sender: TObject);
begin
  SupplierID := IBCQueryGoodsSuppliers.FieldByName('customerid').AsInteger;
//    if trim(lcbSupplierGoodsCode.Text)='' then
  RefreshGoodsCode(GoodsID, SupplierID);
end;

procedure TfrmWebSelectGoodsDlg.lcbGoodsSuppliersPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryGoodsSuppliers.Close;
  IBCQueryGoodsSuppliers.ParamByName('GOODSID').AsInteger := GoodsID;
  IBCQueryGoodsSuppliers.Open;
end;

procedure TfrmWebSelectGoodsDlg.lcbSupplierGoodsCodePropertiesInitPopup(Sender: TObject);
begin
  if trim(lcbSupplierGoodsCode.Text) = '' then
    RefreshGoodsCode(GoodsID, SupplierID);
end;

procedure TfrmWebSelectGoodsDlg.RefreshGoodsCode(GoodsID, SupplierID: Integer);
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

procedure TfrmWebSelectGoodsDlg.Prepare;
begin
  inherited;
  beGoods.Text := GoodsName;
  beGoods.Tag := GoodsID;

  IBCQueryGoodsForeign.Close;
  IBCQueryGoodsForeign.ParamByName('GOODSID').AsInteger := GoodsID;
  IBCQueryGoodsForeign.ParamByName('CUSTOMERID').AsInteger := SupplierID;
  IBCQueryGoodsForeign.Open;

  IBCQueryGoodsSuppliers.ParamByName('GoodsID').AsInteger := GoodsID;
  IBCQueryGoodsSuppliers.Open;
  lcbGoodsSuppliers.EditValue := SupplierID;

  IBCQueryGoodsForeign.ParamByName('CUSTOMERID').AsInteger := SupplierID;
  IBCQueryGoodsForeign.ParamByName('GOODSID').AsInteger := GoodsID;
  IBCQueryGoodsForeign.Open;
  lcbSupplierGoodsCode.EditValue := GoodsCode;

  cePrice.Value := GoodsPrice;

  RefreshGoodsCode(GoodsID, SupplierID);

  IBCQueryCurrency.Open;
  cbCurrency.EditValue := FGoodsCurrencyID;
end;

procedure TfrmWebSelectGoodsDlg.SetGoodsCode(const Value: string);
begin
  FGoodsCode := Value;
end;

procedure TfrmWebSelectGoodsDlg.SetGoodsCurrencyID(const Value: integer);
begin
  FGoodsCurrencyID := Value;
end;

procedure TfrmWebSelectGoodsDlg.SetGoodsID(const Value: integer);
begin
  FGoodsID := Value;
end;

procedure TfrmWebSelectGoodsDlg.SetGoodsName(const Value: string);
begin
  FGoodsName := Value;
end;

procedure TfrmWebSelectGoodsDlg.SetGoodsPrice(const Value: Double);
begin
  FGoodsPrice := Value;
end;

procedure TfrmWebSelectGoodsDlg.SetGoodsTitle(const Value: string);
begin
  FGoodsTitle := Value;
end;

procedure TfrmWebSelectGoodsDlg.SetOnAddGoods(const Value: TOnAddGoods);
begin
  FOnAddGoods := Value;
end;

procedure TfrmWebSelectGoodsDlg.SetOnAddGoodsFolder(const Value: TOnAddGoodsFolder);
begin
  FOnAddGoodsFolder := Value;
end;

procedure TfrmWebSelectGoodsDlg.SetSupplierID(const Value: integer);
begin
  FSupplierID := Value;
end;

procedure TfrmWebSelectGoodsDlg.SetSupplierName(const Value: string);
begin
  FSupplierName := Value;
end;

end.

