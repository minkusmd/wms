unit frmSelectGoodsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxLabel, cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.ExtCtrls,
  SWNBaseUnit;

type
  TfrmSelectGoodsDlg = class(TSWNBaseFormClass)
    Panel1: TPanel;
    beGoods: TcxButtonEdit;
    teGoodsID: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
  private
    FGoodsID: Integer;
    FGoodsTitle: string;
    { Private declarations }
  private
    procedure Prepare; override;
  public
    property GoodsID: Integer read FGoodsID write FGoodsID;
    property GoodsTitle: string read FGoodsTitle write FGoodsTitle;

    function SelectGoods(AGoodsID: Integer; AGoodsTitle: string): Boolean;
    { Public declarations }
  end;

var
  frmSelectGoodsDlg: TfrmSelectGoodsDlg;

implementation

uses
  frmGoods;

{$R *.dfm}

procedure TfrmSelectGoodsDlg.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  d: TfrmGoodsBrowser;
begin
  d := TfrmGoodsBrowser.Create(Self);
  if d.SelectGoods(beGoods.Tag, False) then
  begin
    beGoods.Tag := d.GoodsID;
    beGoods.Text := d.GoodsTitle;
    FGoodsID := d.GoodsID;
    FGoodsTitle := d.GoodsTitle;
  end;
end;

procedure TfrmSelectGoodsDlg.FormShow(Sender: TObject);
begin
  beGoods.SetFocus;
end;

procedure TfrmSelectGoodsDlg.Prepare;
begin
  inherited;
//  teGoodsID.Text := FGoodsID.ToString;
//  beGoods.Tag := FGoodsID;
//  beGoods.Text := FGoodsTitle;
end;

function TfrmSelectGoodsDlg.SelectGoods(AGoodsID: Integer; AGoodsTitle:
    string): Boolean;
begin
  teGoodsID.Text := AGoodsID.ToString;
  beGoods.Tag := AGoodsID;
  beGoods.Text := AGoodsTitle;
  Result := (ShowModal = mrOK);
end;

end.
