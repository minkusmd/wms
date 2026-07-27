unit frmUserMissedHoursSetIntervalDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, SWNBaseUnit,
  Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Vcl.Buttons, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Menus;

type
  TfrmUserMissedHoursSetIntervalDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label6: TLabel;
    Label1: TLabel;
    deSTART: TcxDateEdit;
    deEND: TcxDateEdit;
    sbDates: TSpeedButton;
    Label2: TLabel;
    pmDates: TPopupMenu;
    N11: TMenuItem;
    N1011: TMenuItem;
    N21: TMenuItem;
    N201: TMenuItem;
    N1: TMenuItem;
    procedure sbDatesClick(Sender: TObject);
    procedure N201Click(Sender: TObject);
  private
    { Private declarations }
    function CheckValues: Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    procedure SetDates(const startDate: TDateTime);
    function GetEndDate: TDateTime;
  end;

implementation

{$R *.dfm}

uses
  System.Types, System.DateUtils, DataModuleAdditions, SWNConst, SWNUtils;

{ TfrmUserMissedHoursSetIntervalDlg }

function TfrmUserMissedHoursSetIntervalDlg.CheckValues: Boolean;
var
  Error: string;
begin
  Result := False;
  Error := '';

  if VarIsNull(deEND.EditValue) or (TDateTime(deEND.EditValue) <= TDateTime(deSTART.EditValue)) then
    AddErrorToStr(Error, 'Конец периода!');

  if Error = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Error);
end;

function TfrmUserMissedHoursSetIntervalDlg.GetEndDate: TDateTime;
begin
  Result := deEND.EditValue;
end;

function TfrmUserMissedHoursSetIntervalDlg.IsFormDataPosted: Boolean;
begin
  Result := CheckValues;
end;

procedure TfrmUserMissedHoursSetIntervalDlg.N201Click(Sender: TObject);
var
  days: Integer;
begin
  days := TMenuItem(Sender).Tag;
  deEND.EditValue := IncDay(deSTART.EditValue, days - 1);
end;

procedure TfrmUserMissedHoursSetIntervalDlg.Prepare;
begin

end;

procedure TfrmUserMissedHoursSetIntervalDlg.sbDatesClick(Sender: TObject);
var
  P: TPoint;
begin
  P := Point(sbDates.Left, sbDates.Top);
  P := pnClient.ClientToScreen(P);
  pmDates.Popup(P.X, P.Y);
end;

procedure TfrmUserMissedHoursSetIntervalDlg.SetDates(const startDate: TDateTime);
begin
  deSTART.EditValue := startDate;
end;

end.

