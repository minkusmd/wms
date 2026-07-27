unit frmUMEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, SWNBaseUnit, SWNUtils,
  SWNConst, DB;

type
  TfrmUMEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    lbName: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBTextEdit3: TcxDBTextEdit;
  private
    { Private declarations }
    function CheckParams: Boolean;
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    FCreateNewRecord: Boolean;
  end;

implementation

{$R *.dfm}
{ TForm2 }

function TfrmUMEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);

end;

procedure TfrmUMEditorDlg.BindingDataSource;
begin
  inherited;
  if FCreateNewRecord then
  begin
    dtDialogTitle.Title := 'Новая запись';
  end
  else
  begin
    dtDialogTitle.Title := 'Редактировать запись';
  end;

  cxDBTextEdit1.DataBinding.DataSource := fMasterDataSource;
  cxDBTextEdit2.DataBinding.DataSource := fMasterDataSource;
  cxDBTextEdit3.DataBinding.DataSource := fMasterDataSource;

end;

function TfrmUMEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmUMEditorDlg.Prepare;
begin
  inherited;

  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    dtDialogTitle.Text := 'Единица измерения "' + fMasterDataSet.FieldByName('TITLE').AsString + '"';
    if FCreateNewRecord then
    begin
      fMasterDataSet.Append;

    end
    else
    begin
      fMasterDataSet.Edit;
    end;
  except
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;

end;

procedure TfrmUMEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;

end;

end.

