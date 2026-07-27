unit frmUserMissedHourEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StdCtrls, cxMemo,
  cxDBEdit, cxSpinEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  ExtCtrls, DialogTitle, DB, DBAccess, IBC, MemDS, cxCheckBox, cxCalendar, dxUIAClasses;

type
  TfrmUserMissedHourEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    lcbUSERID: TcxDBLookupComboBox;
    seHOURS: TcxDBSpinEdit;
    Label2: TLabel;
    Label4: TLabel;
    mmDESCRIPTION: TcxDBMemo;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    Label5: TLabel;
    lcbMOTIV_ID: TcxDBLookupComboBox;
    IBCQueryMotiv: TIBCQuery;
    IBCDataSourceMotiv: TIBCDataSource;
    Label6: TLabel;
    deDATA: TcxDBDateEdit;
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues: Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewRecord: Boolean read fCreateNewRecord write SetCreateNewRecord;
  end;

implementation

uses DataModuleAdditions, DataModuleDB, SWNConst, SWNUtils, DateUtils, SWNSecurity, SWNSecurityFlags;

{$R *.dfm}
{ TfrmUserMissedHourEditorDlg }

function TfrmUserMissedHourEditorDlg.CheckValues: Boolean;
var
  ErrorStr: String;
  N: Integer;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('DATA').IsNull then
    AddErrorToStr(ErrorStr, 'Data!')
  else if Not SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Администратор) then
  begin
    N := DateUtils.DaysBetween(fMasterDataSet.FieldByName('DATA').AsDateTime, NOW);
    if (N > 31) then
      AddErrorToStr(ErrorStr, 'Numai datele pentru 1 luna! Sunati administratorul.');
  end;
  if fMasterDataSet.FieldByName('CT').IsNull or (fMasterDataSet.FieldByName('CT').AsInteger <= 0) then
    AddErrorToStr(ErrorStr, 'Salariat!');
  if fMasterDataSet.FieldByName('HOURS').IsNull or (fMasterDataSet.FieldByName('HOURS').AsInteger <= 0) then
    AddErrorToStr(ErrorStr, 'Valoarea!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmUserMissedHourEditorDlg.BindingDataSource;
begin
  fCreateNewRecord := False;
  deDATA.DataBinding.DataSource := fMasterDataSource;
  lcbUSERID.DataBinding.DataSource := fMasterDataSource;
  lcbMOTIV_ID.DataBinding.DataSource := fMasterDataSource;
  seHOURS.DataBinding.DataSource := fMasterDataSource;
  mmDESCRIPTION.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmUserMissedHourEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmUserMissedHourEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if fCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Modificarea inregistrarii';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('HOURS').AsInteger := 1;
      fMasterDataSet.FieldByName('DATA').AsDateTime := NOW;
    end
    else
    begin
      dtDialogTitle.Text := 'Inregistrare noua';
      fMasterDataSet.Edit;
    end;
    IBCQueryUsers.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
    IBCQueryUsers.Active := True;
    IBCQueryMotiv.Active := True;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmUserMissedHourEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  fCreateNewRecord := Value;
end;

procedure TfrmUserMissedHourEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
