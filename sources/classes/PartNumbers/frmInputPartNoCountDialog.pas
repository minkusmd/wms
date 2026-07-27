unit frmInputPartNoCountDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls, DialogTitle,
  cxCalc, SWNBaseUnit,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxTextEdit,
  cxMaskEdit, cxDropDownEdit;

type
  TfrmInputPartNoCountDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    lbTextCount: TLabel;
    edQTY: TcxCalcEdit;
    edMaxQTY: TcxCalcEdit;
    btnOK: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    fMaxValue: double;
    fQTY: double;
    procedure SetQTY(const Value: double);
    function CheckParams:Boolean;
    procedure SetMaxValue(const Value: double);
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property Qty:double read fQTY write SetQTY;
    property MaxValue:double read fMaxValue write SetMaxValue;

  end;





implementation

uses SWNUtils, SWNConst, Math, System.Types;

{$R *.dfm}


{ TfrmInputDlg }

function TfrmInputPartNoCountDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckParams then
     begin
          fQTY:=edQTY.Value;
          Result:=True;
     end;
end;

procedure TfrmInputPartNoCountDlg.Prepare;
begin

end;

procedure TfrmInputPartNoCountDlg.SetMaxValue(const Value: double);
begin
     fMaxValue := Value;
     edMaxQTY.Value:=Value;
end;

procedure TfrmInputPartNoCountDlg.SetQTY(const Value: double);
begin
     edQTY.Value := Value;
end;

function TfrmInputPartNoCountDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     if VarIsNull(edQTY.Value) or (edQTY.Value<=0) then AddErrorToStr(ErrorStr,'Cantitate gresita!')
     else
     begin
          if (CompareValue(edQTY.Value,fMaxValue)=GreaterThanValue) then AddErrorToStr(ErrorStr,'Cantitate mai mare decit disponibil!')
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,ErrorStr);
end;


end.
