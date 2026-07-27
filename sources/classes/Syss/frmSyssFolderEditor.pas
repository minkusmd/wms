unit frmSyssFolderEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, DB, IBC, StdCtrls,
  cxDBLookupComboBox, cxDBEdit,
  ExtCtrls, DialogTitle, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, DBAccess, MemDS, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxTextEdit;

type
  TfrmSyssFolderEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    edTITLE: TcxDBTextEdit;
    lbMasterGroup: TLabel;
    lbFieldName: TLabel;
    lcbVALUE_INT: TcxDBLookupComboBox;
    edVALUE_STR: TcxDBTextEdit;
    IBCQuerySYSSGroups: TIBCQuery;
    IBCDataSourceSYSSGroups: TIBCDataSource;
    edID: TcxDBTextEdit;
    cxLabel2: TLabel;
    rbMastered: TRadioButton;
    rbSimpleValue: TRadioButton;
    cbNeedValue: TCheckBox;
    cbNeedEditor: TCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure cbNeedEditorClick(Sender: TObject);
    procedure lcbVALUE_INTPropertiesInitPopup(Sender: TObject);
    procedure cbNeedValueClick(Sender: TObject);
    procedure rbSimpleValueClick(Sender: TObject);
  private
    { Private declarations }
    FCreateNewGroup: Boolean;
    procedure SetCreateNewGroup(const Value: Boolean);
    function CheckParams: Boolean;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewGroup: Boolean read FCreateNewGroup write SetCreateNewGroup;
  end;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}
{ TfrmSyssFolderEditorDlg }

procedure TfrmSyssFolderEditorDlg.cbNeedEditorClick(Sender: TObject);
begin
  if cbNeedEditor.Checked then
  begin
    lbFieldName.Enabled := True;
    edVALUE_STR.Enabled := True;
  end
  else
  begin
    lbFieldName.Enabled := False;
    edVALUE_STR.Enabled := False;
    fMasterDataSet.FieldByName('VALUE_STR').Value := NULL;
  end;
end;

procedure TfrmSyssFolderEditorDlg.cbNeedValueClick(Sender: TObject);
begin
  if cbNeedValue.Checked then
  begin
    rbSimpleValue.Enabled := True;
    rbMastered.Enabled := True;
  end
  else
  begin
    rbSimpleValue.Enabled := False;
    rbMastered.Enabled := False;
  end;
end;

function TfrmSyssFolderEditorDlg.CheckParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsWideString = '') then
    AddErrorToStr(ErrorStr, 'Название группы!');

  if cbNeedEditor.Checked then
  begin
    if fMasterDataSet.FieldByName('VALUE_STR').IsNull or (fMasterDataSet.FieldByName('VALUE_STR').AsWideString = '') then
      AddErrorToStr(ErrorStr, 'Название дополнительного поля!');
  end;

  if cbNeedValue.Checked then
  begin
    if rbMastered.Checked then
    begin
      if fMasterDataSet.FieldByName('VALUE_INT').IsNull then
        AddErrorToStr(ErrorStr, 'Мастер группа!');
    end;
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmSyssFolderEditorDlg.BindingDataSource;
begin
  inherited;
  FCreateNewGroup := False;

  edID.DataBinding.DataSource := fMasterDataSource;
  edTITLE.DataBinding.DataSource := fMasterDataSource;
  lcbVALUE_INT.DataBinding.DataSource := fMasterDataSource;
  edVALUE_STR.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmSyssFolderEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    if cbNeedValue.Checked then
    begin
      if rbSimpleValue.Checked then
      begin
        fMasterDataSet.FieldByName('VALUE_INT_TYPE').AsInteger := 1; // Integer value
        fMasterDataSet.FieldByName('VALUE_INT').Value := NULL;
      end
      else if rbMastered.Checked then
      begin
        fMasterDataSet.FieldByName('VALUE_INT_TYPE').AsInteger := 2; // ComboBox
      end;
    end
    else
    begin
      fMasterDataSet.FieldByName('VALUE_INT_TYPE').AsInteger := 0;
      fMasterDataSet.FieldByName('VALUE_INT').Value := NULL;
    end;

    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmSyssFolderEditorDlg.lcbVALUE_INTPropertiesInitPopup(Sender: TObject);
begin
  IBCQuerySYSSGroups.Open;
end;

procedure TfrmSyssFolderEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if FCreateNewGroup then
    begin
      dtDialogTitle.Text := 'Создание новой группы';

      fMasterDataSet.Append;
      fMasterDataSet.FieldByName('PARENTID').AsInteger := 0;
    end
    else
    begin
      dtDialogTitle.Text := 'Изменение записи';
      fMasterDataSet.Edit;

      if fMasterDataSet.FieldByName('VALUE_INT_TYPE').AsInteger > 0 then
      begin
        cbNeedValue.Checked := True;
        case fMasterDataSet.FieldByName('VALUE_INT_TYPE').AsInteger of
          1:
            begin
              rbSimpleValue.Checked := True;
            end;
          2:
            begin
              rbMastered.Checked := True;
            end;
        end;
      end;

      if Not fMasterDataSet.FieldByName('VALUE_STR').IsNull then
      begin
        cbNeedEditor.Checked := True;
      end;

      IBCQuerySYSSGroups.Open;
    end;
  except
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmSyssFolderEditorDlg.rbSimpleValueClick(Sender: TObject);
var
  fMast: Boolean;
begin
  fMast := False;

  if rbMastered.Checked then
    fMast := True;

  lbMasterGroup.Enabled := fMast;
  lcbVALUE_INT.Enabled := fMast;
end;

procedure TfrmSyssFolderEditorDlg.SetCreateNewGroup(const Value: Boolean);
begin
  FCreateNewGroup := Value;
end;

procedure TfrmSyssFolderEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
