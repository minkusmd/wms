unit frmServiceRefRepairAimsFolderEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, StdCtrls, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMemo, cxDBEdit, cxCheckBox;

type
  TfrmServiceRefRepairAimsFolderEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edTITLE: TcxDBTextEdit;
    mmDESCRIPTION: TcxDBMemo;
    cbFLG_ENABLED: TcxDBCheckBox;
  private
    fCreateNewScopFolder: Boolean;
    fParentID: integer;
    { Private declarations }
    function CheckInputParams: Boolean;
    procedure SetCreateNewScopFolder(const Value: Boolean);
    procedure SetParentID(const Value: integer);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewFolderScop: Boolean read fCreateNewScopFolder write SetCreateNewScopFolder;
    property ParentID: integer read fParentID write SetParentID;
  end;

implementation

uses DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}
{ TfrmAnalyticsEditorDlg }

function TfrmServiceRefRepairAimsFolderEditorDlg.CheckInputParams: Boolean;
var
  Errors: String;
begin
  Result := False;

  if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsString = '') then
    AddErrorToStr(Errors, 'Название группы!');

  if Errors = '' then
    Result := true
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmServiceRefRepairAimsFolderEditorDlg.BindingDataSource;
begin
  inherited;

  fParentID := 0;
  fCreateNewScopFolder := False;

  edTITLE.DataBinding.DataSource := fMasterDataSource;
  mmDESCRIPTION.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmServiceRefRepairAimsFolderEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckInputParams then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := true;
  end
  else
    Result := False;
end;

procedure TfrmServiceRefRepairAimsFolderEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if fCreateNewScopFolder then
    begin
      dtDialogTitle.Text := 'Создание новой группы целей';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('PARENTID').AsInteger := fParentID;
      fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 1;
      fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger := 1;
    end
    else
    begin
      dtDialogTitle.Text := 'Изменение группы';
      fMasterDataSet.Edit;
    end;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmServiceRefRepairAimsFolderEditorDlg.SetCreateNewScopFolder(const Value: Boolean);
begin
  fCreateNewScopFolder := Value;
end;

procedure TfrmServiceRefRepairAimsFolderEditorDlg.SetParentID(const Value: integer);
begin
  fParentID := Value;
end;

procedure TfrmServiceRefRepairAimsFolderEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
