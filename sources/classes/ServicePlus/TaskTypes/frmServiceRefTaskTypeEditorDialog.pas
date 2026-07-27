unit frmServiceRefTaskTypeEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxDBEdit, cxMemo, cxTextEdit, StdCtrls, DB, DBAccess, IBC, MemDS,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
  TfrmServiceRefTaskTypeEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edTITLE: TcxDBTextEdit;
    Label2: TLabel;
    mmDESCRIPTION: TcxDBMemo;
    cbFLG_START_STATE: TcxDBCheckBox;
    cbFLG_END_STATE: TcxDBCheckBox;
    cbFLG_CODE_STATE: TcxDBCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    cmbValue: TcxComboBox;
    cbFLG_ENABLED: TcxDBCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    cbFLG_OTHER_EXECUTANT: TcxDBCheckBox;
    Label5: TLabel;
    clbUSER_GROUP_ID: TcxDBLookupComboBox;
    IBCQueryUG: TIBCQuery;
    IBCDataSourceUG: TIBCDataSource;
  private
    { Private declarations }
    fCreateNewTaskType: Boolean;
    procedure SetCreateNewTaskType(const Value: Boolean);

    function CheckValues: Boolean;
    procedure SaveValueIntValue;

  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    property CreateNewTaskType: Boolean read fCreateNewTaskType write SetCreateNewTaskType;
  end;

implementation

uses DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}
{ TfrmServiceRefTaskTypeEditorDlg }

function TfrmServiceRefTaskTypeEditorDlg.CheckValues: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('TITLE').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE').AsString) = '') then
    AddErrorToStr(ErrorStr, 'Название!');

  if Not fMasterDataSet.FieldByName('FLG_OTHER_EXECUTANT').IsNull and (fMasterDataSet.FieldByName('FLG_OTHER_EXECUTANT').AsInteger = 1) then
  begin
    if fMasterDataSet.FieldByName('USER_GROUP_ID').IsNull then
      AddErrorToStr(ErrorStr, 'Исполнитель задачи!');
  end;

  if (ErrorStr = '') then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmServiceRefTaskTypeEditorDlg.BindingDataSource;
begin
  inherited;

  edTITLE.DataBinding.DataSource := fMasterDataSource;
  mmDESCRIPTION.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
  cbFLG_START_STATE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_END_STATE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_CODE_STATE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_OTHER_EXECUTANT.DataBinding.DataSource := fMasterDataSource;
  clbUSER_GROUP_ID.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmServiceRefTaskTypeEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    SaveValueIntValue;
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmServiceRefTaskTypeEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if fCreateNewTaskType then
    begin
      dtDialogTitle.Text := 'Создание нового типа';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 1;
      fMasterDataSet.FieldByName('FLG_START_STATE').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_END_STATE').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_CODE_STATE').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_OTHER_EXECUTANT').AsInteger := 0;
      fMasterDataSet.FieldByName('USER_GROUP_ID').Value := Null;
      fMasterDataSet.FieldByName('VALUE_INT').AsInteger := 0;
    end
    else
    begin
      dtDialogTitle.Text := 'Изменение записи';
      fMasterDataSet.Edit;
    end;

    if fMasterDataSet.FieldByName('VALUE_INT').AsInteger = -1 then
      cmbValue.ItemIndex := 1
    else if fMasterDataSet.FieldByName('VALUE_INT').AsInteger = 1 then
      cmbValue.ItemIndex := 2
    else
      cmbValue.ItemIndex := 0;

    IBCQueryUG.Active := True;

  except
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmServiceRefTaskTypeEditorDlg.SaveValueIntValue;
begin
  case cmbValue.ItemIndex of
    1:
      fMasterDataSet.FieldByName('VALUE_INT').AsInteger := -1;
    2:
      fMasterDataSet.FieldByName('VALUE_INT').AsInteger := 1;
  else
    fMasterDataSet.FieldByName('VALUE_INT').AsInteger := 0;
  end;
end;

procedure TfrmServiceRefTaskTypeEditorDlg.SetCreateNewTaskType(const Value: Boolean);
begin
  fCreateNewTaskType := Value;
end;

procedure TfrmServiceRefTaskTypeEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
