unit frmEditDateExchange;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  cxControls, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxDBEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, Vcl.StdCtrls, cxButtons, cxLabel;

type
  TfrmEditDateExchangeDlg = class(TSWNCustomForm)
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxDateEdit1: TcxDateEdit;
    cxLabel1: TcxLabel;
    procedure cxDateEdit1PropertiesChange(Sender: TObject);
  private
    { Private declarations }
    FExchangeData: TDateTime;
  protected
      procedure Prepare;override;

      procedure SetExchangeData(Value: TDateTime);
  public
    { Public declarations }
    property ExchangeData: TDateTime read FExchangeData write SetExchangeData;
  end;

var
  frmEditDateExchangeDlg: TfrmEditDateExchangeDlg;

implementation

{$R *.dfm}

{ TfrmEditDateExchangeDlg }

procedure TfrmEditDateExchangeDlg.cxDateEdit1PropertiesChange(Sender: TObject);
begin
    ExchangeData := cxDateEdit1.Date;
end;

procedure TfrmEditDateExchangeDlg.Prepare;
begin
  inherited;
  cxDateEdit1.Date := ExchangeData;
end;

procedure TfrmEditDateExchangeDlg.SetExchangeData(Value: TDateTime);
begin
  FExchangeData := Value;
end;

end.
