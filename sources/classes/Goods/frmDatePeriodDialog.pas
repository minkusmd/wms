unit frmDatePeriodDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, ExtCtrls, Buttons, Menus, Vcl.ComCtrls, dxCore, cxDateUtils;

type
  TfrmDatePeriodDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    deDate1: TcxDateEdit;
    deDate2: TcxDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
    sbPresets: TSpeedButton;
    pmDates: TPopupMenu;
    miMore5Days: TMenuItem;
    N101: TMenuItem;
    N201: TMenuItem;
    N301: TMenuItem;
    N1: TMenuItem;
    miEndOfMonth: TMenuItem;
    miEndOfQuarter: TMenuItem;
    miEndOfYear: TMenuItem;
    procedure N301Click(Sender: TObject);
    procedure sbPresetsClick(Sender: TObject);
    procedure miEndOfMonthClick(Sender: TObject);
    procedure miEndOfYearClick(Sender: TObject);
    procedure miEndOfQuarterClick(Sender: TObject);
  private
    { Private declarations }
    function CheckInputParams:Boolean;
    function GetDateEnd: TDateTime;
    function GetDateStart: TDateTime;
    procedure SetDateEnd(const Value: TDateTime);
    procedure SetDateStart(const Value: TDateTime);
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property DateStart:TDateTime read GetDateStart write SetDateStart;
    property DateEnd:TDateTime read GetDateEnd write SetDateEnd;
    procedure SetTitles(const Title,Text:String);
  end;


implementation

uses SWNConst, SWNUtils, DateUtils;

{$R *.dfm}

{ TfrmDatePeriodDlg }

function TfrmDatePeriodDlg.CheckInputParams: Boolean;
var Errors:String;
begin
     Result:=False;
     Errors:='';

     if VarIsNull(deDate1.EditValue) or (DateOf(deDate1.EditValue)<DateOf(NOW)) then AddErrorToStr(Errors,'Inceputul perioadei!');
     if VarIsNull(deDate2.EditValue) or (deDate2.EditValue<deDate1.EditValue) then AddErrorToStr(Errors,'Sfirsitul perioadei!');

     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

function TfrmDatePeriodDlg.GetDateEnd: TDateTime;
begin
     Result:=deDate2.EditValue;
end;

function TfrmDatePeriodDlg.GetDateStart: TDateTime;
begin
     Result:=deDate1.EditValue;
end;

function TfrmDatePeriodDlg.IsFormDataPosted: Boolean;
begin
     Result:=CheckInputParams;
end;

procedure TfrmDatePeriodDlg.miEndOfMonthClick(Sender: TObject);
begin
     deDate2.EditValue:=NOW-DayOfTheMonth(NOW)+DaysInMonth(NOW);
end;

procedure TfrmDatePeriodDlg.miEndOfQuarterClick(Sender: TObject);
var month,quart:integer;
    qMonthStart:integer;
begin
     month:=MonthOfTheYear(NOW);
     quart:=month div 3;
     if (month mod 3)>0 then inc(quart);
     qMonthStart:=1+(quart-1)*3;
     deDate2.EditValue:=SysUtils.IncMonth(EncodeDate(YearOf(NOW),qMonthStart,1),3)-1;
end;

procedure TfrmDatePeriodDlg.miEndOfYearClick(Sender: TObject);
begin
     deDate2.EditValue:=EncodeDateDay(YearOf(NOW)+1,1)-1;
end;

procedure TfrmDatePeriodDlg.N301Click(Sender: TObject);
var Menu:TMenuItem;
begin
     Menu:=TMenuItem(Sender);
     deDate2.EditValue:=NOW+Menu.Tag;
end;

procedure TfrmDatePeriodDlg.Prepare;
begin
     deDate1.Enabled:=False;
     if (deDate1.EditValue=0) then deDate1.EditValue:=NOW;
     if (deDate2.EditValue=0) then deDate2.EditValue:=NOW+7;
end;

procedure TfrmDatePeriodDlg.sbPresetsClick(Sender: TObject);
var P:TPoint;
begin
     P.X:=sbPresets.Left+sbPresets.Width+6;
     P.Y:=sbPresets.Top;

     P:=pnClient.ClientToScreen(P);
     pmDates.Popup(P.X,P.Y);
end;

procedure TfrmDatePeriodDlg.SetDateEnd(const Value: TDateTime);
begin
     deDate2.EditValue:=Value;
end;

procedure TfrmDatePeriodDlg.SetDateStart(const Value: TDateTime);
begin
     deDate1.EditValue:=Value;
end;

procedure TfrmDatePeriodDlg.SetTitles(const Title, Text: String);
begin
     dtDialogTitle.Title:=Title;
     Caption:=Title;
     dtDialogTitle.Text:=Text;
end;

end.
