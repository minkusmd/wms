unit frmSyssDataEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, IBC,
  StdCtrls, cxDBEdit,
  cxDBLookupComboBox, ExtCtrls, DialogTitle,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxMemo, dxUIAClasses;

type

  TfrmSyssDataEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    pnVALUE_INT2: TPanel;
    lbValue_INT2: TLabel;
    lcbVALUE_INT: TcxDBLookupComboBox;
    pnButtons: TPanel;
    pnVALUE_STR: TPanel;
    lbValue_STR: TLabel;
    edVALUE_STR: TcxDBTextEdit;
    pnGeneral: TPanel;
    cxLabel1: TLabel;
    edSYSSID: TcxDBTextEdit;
    cxLabel2: TLabel;
    pnValue_INT1: TPanel;
    lbValue_INT1: TLabel;
    edVALUE_INT: TcxDBTextEdit;
    lbIDInfo: TLabel;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    edTitle: TcxDBMemo;
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    fValueINT_Type: Integer;
    fViewSTR: Boolean;
    fParentID: Integer;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckParams: Boolean;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

    procedure SaveStates; override;
    procedure LoadStates; override;

  public
    { Public declarations }
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
    procedure SetGroupTitle(const GroupTitle: String);
    procedure SetDetails(const ValueINT_Type: Integer; const ViewSTR: Boolean; const TitleINT, TitleSTR: String);
    procedure SetValueINTDataSource(const DataSource: TIBCDataSource);
  end;

implementation

uses
  SWNUtils, SWNConst, SWNValueStorageUnit;

{$R *.dfm}
{ TfrmSyssDataEditorDlg }

function TfrmSyssDataEditorDlg.CheckParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('SYSSID').IsNull then
    AddErrorToStr(ErrorStr, 'Cod inregistrare!');
  if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsWideString = '') then
    AddErrorToStr(ErrorStr, 'Denumire!');

  if fValueINT_Type > 0 then
  begin
    if fMasterDataSet.FieldByName('VALUE_INT').IsNull then
      AddErrorToStr(ErrorStr, lbValue_INT2.Caption + '!');
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmSyssDataEditorDlg.BindingDataSource;
begin
  inherited;

  FCreateNewRecord := False;

  edSYSSID.DataBinding.DataSource := fMasterDataSource;
  edTITLE.DataBinding.DataSource := fMasterDataSource;
  lcbVALUE_INT.DataBinding.DataSource := fMasterDataSource;
  edVALUE_INT.DataBinding.DataSource := fMasterDataSource;
  edVALUE_STR.DataBinding.DataSource := fMasterDataSource;

  fParentID := fMasterDataSet.MasterSource.DataSet.FieldByName('SYSSID').AsInteger;
end;

function TfrmSyssDataEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmSyssDataEditorDlg.LoadStates;
begin
  AppUserConfigStorage.OpenSection(Format('%s_%d', [Self.Name, fParentID]));
  try
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.ReadFormPos(Self);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmSyssDataEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if FCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Inregistrare noua';
      fMasterDataSet.Append;
      fMasterDataSet.FieldByName('PARENTID').AsInteger := fParentID; // fMasterDataSet.MasterSource.DataSet.FieldByName('SYSSID').AsInteger;
      fMasterDataSet.FieldByName('VALUE_INT_TYPE').AsInteger := 0;
      lbIDInfo.Visible := True;
      ActiveControl := edTitle;
    end
    else
    begin
      dtDialogTitle.Text := 'Modifica inregistrarea';
      fMasterDataSet.Edit;
      lbIDInfo.Visible := False;
      ActiveControl := edTitle;
    end;
  except
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmSyssDataEditorDlg.SaveStates;
begin
  AppUserConfigStorage.OpenSection(Format('%s_%d', [Self.Name, fParentID]));
  try
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmSyssDataEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmSyssDataEditorDlg.SetDetails(const ValueINT_Type: Integer; const ViewSTR: Boolean; const TitleINT, TitleSTR: String);
begin
  fValueINT_Type := ValueINT_Type;
  fViewSTR := ViewSTR;

  case fValueINT_Type of
    0:
      begin
        pnValue_INT1.Visible := False;
        pnVALUE_INT2.Visible := False;
      end;
    1:
      begin
        pnVALUE_INT2.Visible := False;
      end;
    2:
      begin
        pnValue_INT1.Visible := False;
      end;
  end;

  pnVALUE_STR.Visible := fViewSTR;

  lbValue_INT1.Caption := TitleINT;
  lbValue_INT2.Caption := TitleINT;

  lbValue_STR.Caption := TitleSTR;

  pnClient.AutoSize := True;
  AutoSize := True;
end;

procedure TfrmSyssDataEditorDlg.SetGroupTitle(const GroupTitle: String);
begin
  dtDialogTitle.Title := dtDialogTitle.Title + ': ' + GroupTitle;
end;

procedure TfrmSyssDataEditorDlg.SetValueINTDataSource(const DataSource: TIBCDataSource);
begin
  if (fValueINT_Type = 2) and Assigned(DataSource) then
    lcbVALUE_INT.Properties.ListSource := DataSource;
end;

procedure TfrmSyssDataEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
