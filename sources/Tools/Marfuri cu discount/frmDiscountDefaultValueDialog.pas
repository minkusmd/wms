unit frmDiscountDefaultValueDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle;

type
  TfrmDiscountDefaultValueDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    lbDiscountText: TLabel;
    edValue: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
    FDiscountValue: integer;
    FDiscountName: String;
    procedure SetDiscountName(const Value: String);
    procedure SetDiscountValue(const Value: integer);

    function CheckInputValue:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property DiscountValue:integer read FDiscountValue write SetDiscountValue;
    property DiscountName:String read FDiscountName write SetDiscountName;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, SWNUtils, SWNConst;

{ TfrmDiscountDefaultValueDlg }

function TfrmDiscountDefaultValueDlg.CheckInputValue: Boolean;
var N:integer;
begin
     Result:=True;

     N:=StrToIntDef(edValue.Text,0);
     if (N<=0) then
     begin
          Result:=False;
          ShowErrorDialog(cMSG_GeneralInputError_Title,'Valoare incorecta a discountului.');
     end
     else FDiscountValue:=N;
end;

function TfrmDiscountDefaultValueDlg.IsFormDataPosted: Boolean;
begin
     Result:=CheckInputValue;
end;

procedure TfrmDiscountDefaultValueDlg.Prepare;
begin

end;

procedure TfrmDiscountDefaultValueDlg.SetDiscountName(const Value: String);
begin
     FDiscountName := Value;
     lbDiscountText.Caption:=Format('Discount, %s',[Value]);
end;

procedure TfrmDiscountDefaultValueDlg.SetDiscountValue(const Value: integer);
begin
     FDiscountValue := Value;
     edValue.Text:=IntToStr(Value);
end;

end.
