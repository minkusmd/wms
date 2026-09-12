unit frmConfigurationCustomCountDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Menus, StdCtrls, ExtCtrls, DialogTitle,
  SWNBaseUnit, cxTextEdit, cxCalc,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxMaskEdit,
  cxDropDownEdit;

type

  TOptionCount = (ocSetCount,ocMultiplyByCount);

  TfrmConfigurationCustomCountDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    rbOption1: TRadioButton;
    rbOption2: TRadioButton;
    lbInfo: TLabel;
    edCountValue: TcxCalcEdit;
    edMultiplyValue: TcxCalcEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure rbOption1Click(Sender: TObject);
  private
    { Private declarations }
    fQtyDigitsMode:Integer;
    fInComplect: Boolean;
    procedure ShowSelectionInfo(const ShowByCount:Boolean);
    procedure SetInComplect(const Value: Boolean);
    function GetValue: double;
    function GetOptionType: TOptionCount;
    procedure SetOptionType(const Value: TOptionCount);

    function CheckParams:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }

    property InComplect:Boolean read fInComplect write SetInComplect;
    property Value:double read GetValue;
    property OptionType:TOptionCount read GetOptionType write SetOptionType;
  end;


implementation

uses SWNUtils, SWNConst, SWNValueStorageUnit;

{$R *.dfm}

{ TfrmConfigurationCustomSumaCountDlg }

function TfrmConfigurationCustomCountDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';
     if rbOption1.Checked then
     begin
          if VarIsNull(edCountValue.EditValue) or (edCountValue.EditValue<=0) then AddErrorToStr(ErrorStr,'Valoarea cantitatii incorecta!');
     end
     else
     if rbOption2.Checked then
     begin
          if VarIsNull(edMultiplyValue.EditValue) or (edMultiplyValue.EditValue<=0) then AddErrorToStr(ErrorStr,'Valoare gresita pentru inmultitor!');
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,ErrorStr);
end;

function TfrmConfigurationCustomCountDlg.GetOptionType: TOptionCount;
begin
     if rbOption1.Checked then Result:=ocSetCount
     else
     Result:=ocMultiplyByCount;
end;

function TfrmConfigurationCustomCountDlg.GetValue: double;
begin
     if rbOption1.Checked
       then Result:=edCountValue.EditValue
       else Result:=edMultiplyValue.EditValue;
end;

function TfrmConfigurationCustomCountDlg.IsFormDataPosted: Boolean;
begin
     Result:=CheckParams;
end;

procedure TfrmConfigurationCustomCountDlg.Prepare;
begin
     // Numarul de zecimale in QTY :
     fQtyDigitsMode:=AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits,cAppDefault_QtyDigits);
     // Componenta: Cantitate
     TcxCalcEditProperties(edCountValue.Properties).DisplayFormat:=cQTY_DigitsMask[fQtyDigitsMode];

     ShowSelectionInfo(rbOption1.Checked);
     if rbOption1.Checked
      then ActiveControl:=edCountValue
      else ActiveControl:=edMultiplyValue;
end;

procedure TfrmConfigurationCustomCountDlg.ShowSelectionInfo(const ShowByCount:Boolean);
begin
     if fInComplect then
     begin
          lbInfo.Caption:='';
     end
     else
     begin
          if ShowByCount
           then lbInfo.Caption:=''
           else lbInfo.Caption:='La toate produsele va fi modificata cantitatea. In complected cantitatea curenta va fi inmultita.';
     end;
end;


procedure TfrmConfigurationCustomCountDlg.rbOption1Click(Sender: TObject);
begin
     edCountValue.Enabled:=rbOption1.Checked;
     edMultiplyValue.Enabled:=rbOption2.Checked;
     ShowSelectionInfo(rbOption1.Checked);
end;

procedure TfrmConfigurationCustomCountDlg.SetInComplect(const Value: Boolean);
begin
     fInComplect := Value;
     if fInComplect
      then dtDialogTitle.Title := 'Modifica cantitatea in document'
      else dtDialogTitle.Title := 'Modifica cantitatea in complectatie';
     Caption := dtDialogTitle.Title;
end;

procedure TfrmConfigurationCustomCountDlg.SetOptionType(const Value: TOptionCount);
begin
     case Value of
       ocSetCount: rbOption1.Checked:=True;
       ocMultiplyByCount: rbOption2.Checked:=True;
     end;
end;

end.
