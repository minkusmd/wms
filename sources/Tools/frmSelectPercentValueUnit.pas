unit frmSelectPercentValueUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalc, Vcl.ExtCtrls, DialogTitle, SWNBaseUnit, swnUtils;

type
  TfrmSelectPercentValueDlg = class(TSWNBaseFormclass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    edValue: TcxCalcEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    Label2: TLabel;
    rbOptionAmount: TRadioButton;
    rbOptionPercent: TRadioButton;
    Label1: TLabel;
  private
    function CheckParams: Boolean;
    function GetValue: double;
    function GetValueType: Integer;
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted:Boolean;override;
  public
    property Value: double read GetValue;
    property ValueType: Integer read GetValueType;
    { Public declarations }
  end;

var
  frmSelectPercentValueDlg: TfrmSelectPercentValueDlg;

implementation

uses
  SWNConst;

{$R *.dfm}

function TfrmSelectPercentValueDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

//  if VarIsNull(edPercentValue.EditValue) or (edPercentValue.EditValue = 0) then
//    AddErrorToStr(ErrorStr, 'Valoarea nu poate fi 0 %!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, ErrorStr);
end;

function TfrmSelectPercentValueDlg.GetValue: double;
begin
  Result := edValue.Value;
end;

function TfrmSelectPercentValueDlg.GetValueType: Integer;
begin
  Result := -1;
  if rbOptionAmount.Checked then Result := 0;
  if rbOptionPercent.Checked then Result := 1;
end;

function TfrmSelectPercentValueDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
    Result := True
  else
    Result := false;
end;

procedure TfrmSelectPercentValueDlg.Prepare;
begin
    ActiveControl:=edValue
end;

end.

