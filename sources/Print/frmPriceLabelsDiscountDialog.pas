unit frmPriceLabelsDiscountDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle;

type
  TfrmPriceLabelsDiscountDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    edDiscount: TEdit;
    Label2: TLabel;
    cbApplyToAll: TCheckBox;
  private
    { Private declarations }
    function CheckValues:Boolean;
    function GetDiscount: Integer;
    function GetApplyToAll: Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property Discount:Integer read GetDiscount;
    property ApplyToAll:Boolean read GetApplyToAll;
  end;


implementation

{$R *.dfm}

uses SWNUtils, SWNConst;

{ TfrmPriceLabelsDiscountDlg }

function TfrmPriceLabelsDiscountDlg.CheckValues: Boolean;
var Errors:String;
    N:integer;
begin
     Errors:='';
     Result:=False;
     N:=StrToIntDef(edDiscount.Text,-1);
     if (N<1) or (N>50) then AddErrorToStr(Errors,'Discount doar 1-50%!');

     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralError_Title,cMSG_GeneralInputError_Text,Errors);
end;

function TfrmPriceLabelsDiscountDlg.GetApplyToAll: Boolean;
begin
     Result:=cbApplyToAll.Checked;
end;

function TfrmPriceLabelsDiscountDlg.GetDiscount: Integer;
begin
     Result:=StrToInt(edDiscount.Text);
end;

function TfrmPriceLabelsDiscountDlg.IsFormDataPosted: Boolean;
begin
     Result:=CheckValues;
end;

procedure TfrmPriceLabelsDiscountDlg.Prepare;
begin
     edDiscount.Text:='0';
end;


end.
