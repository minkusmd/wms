unit frmForcedPerioudSetupDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, StdCtrls, Buttons, Vcl.ComCtrls,
  dxCore, cxDateUtils;

type
  TfrmForcedPerioudSetupDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    deDate: TcxDateEdit;
    sbPreset1: TSpeedButton;
    Label2: TLabel;
    sbPreset2: TSpeedButton;
    sbPreset3: TSpeedButton;
    sbPreset4: TSpeedButton;
    btnOk: TButton;
    btnCancel: TButton;
    procedure sbPreset4Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetupQuickDate(const DaysOffset: integer);
    function GetEndDate: TDateTime;
    function CheckInputValue: Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    property EndDate: TDateTime read GetEndDate;
    procedure SetTitles(const Title, Text: string);
  end;

implementation

uses
  SWNUtils, SWNConst;

{$R *.dfm}

function TfrmForcedPerioudSetupDlg.CheckInputValue: Boolean;
var
  ErrorStr: string;
begin
  ErrorStr := '';
  Result := False;

  if VarIsNull(deDate.EditValue) or (deDate.EditValue < Now) then
    AddErrorToStr(ErrorStr, 'Sfirsitul perioadei!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

function TfrmForcedPerioudSetupDlg.GetEndDate: TDateTime;
begin
  Result := deDate.EditValue;
end;

function TfrmForcedPerioudSetupDlg.IsFormDataPosted: Boolean;
begin
  Result := CheckInputValue;
end;

procedure TfrmForcedPerioudSetupDlg.Prepare;
begin
  SetupQuickDate(7);
end;

procedure TfrmForcedPerioudSetupDlg.sbPreset4Click(Sender: TObject);
begin
  SetupQuickDate(TSpeedButton(Sender).Tag);
end;

procedure TfrmForcedPerioudSetupDlg.SetTitles(const Title, Text: string);
begin
  Caption := Title;
  dtDialogTitle.Title := Title;
  dtDialogTitle.Text := Text;
end;

procedure TfrmForcedPerioudSetupDlg.SetupQuickDate(const DaysOffset: integer);
begin
  deDate.EditValue := Now + DaysOffset;
end;

end.

