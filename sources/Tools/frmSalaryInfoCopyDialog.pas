unit frmSalaryInfoCopyDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Vcl.StdCtrls,
  Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit;

type
  TfrmSalaryInfoCopyDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    cmbYear: TcxComboBox;
    cmbMonth: TcxComboBox;
    edMonthStart: TcxTextEdit;
    edYearStart: TcxTextEdit;
  private
    { Private declarations }
    fTargetMonth: integer;
    FSourceYear: integer;
    FSourceMonth: integer;
    fTargetYear: integer;

    procedure PrepareDateSelectors;
    procedure SetSourceMonth(const Value: integer);
    procedure SetSourceYear(const Value: integer);
    function CheckValues:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property SourceMonth:integer read FSourceMonth write SetSourceMonth;
    property SourceYear:integer read FSourceYear write SetSourceYear;
    property TargetMonth:integer read fTargetMonth;
    property TargetYear:integer read fTargetYear;
  end;


implementation

uses DataModuleAdditions, DataModuleDB, DateUtils, SWNUpdateClientDBClass, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmSalePlansCopyDlg }

function TfrmSalaryInfoCopyDlg.CheckValues: Boolean;
var Error:String;
begin
     Result:=False;

     if (cmbMonth.ItemIndex=-1) or (cmbYear.ItemIndex=-1) then Error:='Âûבונטעו םמגûי לוסÿצ!';

     if (Error='') then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Error);
end;

function TfrmSalaryInfoCopyDlg.IsFormDataPosted: Boolean;
begin
     Result:=false;
     if CheckValues then
     begin
          fTargetMonth:=cmbMonth.ItemIndex+1;
          fTargetYear:=StrToInt(cmbYear.Text);
          Result:=True;
     end;
end;

procedure TfrmSalaryInfoCopyDlg.Prepare;
var newMonth,newYear:integer;
begin
     PrepareDateSelectors;
     edMonthStart.Text:=FormatSettings.LongMonthNames[FSourceMonth];
     edYearStart.Text:=IntToStr(FSourceYear);
     if (FSourceMonth=MonthOf(Now)) and (FSourceYear=YearOf(Now)) then
     begin
          newMonth:=FSourceMonth+1;
          newYear:=FSourceYear;
          if (newMonth>12) then
          begin
               newMonth:=1;
               inc(newYear);
          end;
          cmbMonth.ItemIndex:=newMonth-1;
          cmbYear.ItemIndex:=cmbYear.Properties.Items.IndexOf(IntToStr(newYear));
     end;
end;

procedure TfrmSalaryInfoCopyDlg.PrepareDateSelectors;
var i:integer;
begin
     for i := 1 to 12 do
      cmbMonth.Properties.Items.Add(FormatSettings.LongMonthNames[i]);
//     if FSourceYear <> YearOf(Now) then
//        cmbYear.Properties.Items.Add(IntToStr(FSourceYear));
     cmbYear.Properties.Items.Add(IntToStr(YearOf(Now) - 1));
     cmbYear.Properties.Items.Add(IntToStr(YearOf(Now)));
     cmbYear.Properties.Items.Add(IntToStr(YearOf(Now) + 1));
end;

procedure TfrmSalaryInfoCopyDlg.SetSourceMonth(const Value: integer);
begin
     fSourceMonth := Value;
end;

procedure TfrmSalaryInfoCopyDlg.SetSourceYear(const Value: integer);
begin
     fSourceYear := Value;
end;

end.
