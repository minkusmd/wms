unit frmGoodsPriceListDlgUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxDropDownEdit,
  cxCalc, cxLabel, cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.ExtCtrls, RzPanel,
  RzDlgBtn;

type
  TfrmGoodsPriceListDlg = class(TSWNCustomForm)
    RzDialogButtons1: TRzDialogButtons;
    Panel1: TPanel;
    beParent: TcxButtonEdit;
    beBrand: TcxButtonEdit;
    beGoodsCategory: TcxButtonEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    ceVAT: TcxCalcEdit;
  private
    FGoodsID: Integer;
    FParentID: Integer;
    FVAT: Integer;
    FVendorID: Integer;
    FWebGoodsTypeID: Integer;
    procedure SetGoodsID(const Value: Integer);
    procedure SetParentID(const Value: Integer);
    procedure SetVAT(const Value: Integer);
    procedure SetVendorID(const Value: Integer);
    procedure SetWebGoodsTypeID(const Value: Integer);
    { Private declarations }

  protected
    function CheckParams: boolean;
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
  public
    property GoodsID: Integer read FGoodsID write SetGoodsID;
    property ParentID: Integer read FParentID write SetParentID;
    property VAT: Integer read FVAT write SetVAT;
    property VendorID: Integer read FVendorID write SetVendorID;
    property WebGoodsTypeID: Integer read FWebGoodsTypeID write SetWebGoodsTypeID;
    { Public declarations }
  end;

var
  frmGoodsPriceListDlg: TfrmGoodsPriceListDlg;

implementation

{$R *.dfm}

function TfrmGoodsPriceListDlg.CheckParams: boolean;
var
  ErrList: TStringList;
begin
  ErrList := TStringList.Create;
  try

    if beParent.Tag>0 then
      ErrList.Add('Selectati mapa parinte!');
    if beBrand.Tag>0 then
      ErrList.Add('Selectati producatorul!');
    if beGoodsCategory.Tag>0 then
      ErrList.Add('Selectati tipul produsului!');
    if varIsNull(ceVat.Value) then
      ErrList.Add('Indicati valoarea TVA!');

    Result := (ErrList.Count=0);
  finally
    ErrList.Free;
  end;
end;

function TfrmGoodsPriceListDlg.IsFormDataPosted: boolean;
begin
  Result := False;
  if CheckParams then
    Result := True;
end;

procedure TfrmGoodsPriceListDlg.Prepare;
begin
  beBrand.Tag := VendorID;
  beParent.Tag := ParentID;
  beGoodsCategory.Tag := WebGoodsTypeID;
end;

procedure TfrmGoodsPriceListDlg.SetGoodsID(const Value: Integer);
begin
  FGoodsID := Value;
end;

procedure TfrmGoodsPriceListDlg.SetParentID(const Value: Integer);
begin
  FParentID := Value;
end;

procedure TfrmGoodsPriceListDlg.SetVAT(const Value: Integer);
begin
  FVAT := Value;
end;

procedure TfrmGoodsPriceListDlg.SetVendorID(const Value: Integer);
begin
  FVendorID := Value;
end;

procedure TfrmGoodsPriceListDlg.SetWebGoodsTypeID(const Value: Integer);
begin
  FWebGoodsTypeID := Value;
end;

end.
