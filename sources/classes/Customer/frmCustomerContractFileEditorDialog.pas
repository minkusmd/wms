unit frmCustomerContractFileEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, SWNBaseUnit, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxMaskEdit, cxButtonEdit, cxTextEdit, cxDBEdit, Vcl.StdCtrls, Vcl.ExtCtrls,
  DialogTitle;

type
  TfrmCustomerContractFileEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edTITLE: TcxDBTextEdit;
    beFile: TcxButtonEdit;
    procedure beFilePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fFilePathName: string;
    FContractID: Integer;
    procedure SetContractID(const Value: Integer);
    function CheckValues: Boolean;
    procedure ShowSelectFileDialog;
    function GetFileSize(const FileName: string): int64;
    procedure DisplayFileInfo;
    procedure UpdateFileDataToDB;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property ContractID: Integer read FContractID write SetContractID;
  end;

implementation

{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}
uses
  DataModuleAdditions, SWNUtils, SWNConst, Data.DB, IBC;

{ TfrmCustomerContractFileEditorDlg }

procedure TfrmCustomerContractFileEditorDlg.beFilePropertiesButtonClick(Sender:
  TObject; AButtonIndex: Integer);
begin
  ShowSelectFileDialog;
end;

function TfrmCustomerContractFileEditorDlg.CheckValues: Boolean;
var
  Errors: string;
begin
  Result := False;
  Errors := '';

  if fMasterDataSet.FieldByName('FILESIZE').IsNull or (fMasterDataSet.FieldByName
    ('FILESIZE').AsInteger <= 0) then
    AddErrorToStr(Errors, 'Fiesier!');
  if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsString
    = '') then
    AddErrorToStr(Errors, 'Descriere fisier!');

  if Errors = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmCustomerContractFileEditorDlg.DisplayFileInfo;
begin
  if fMasterDataSet.FieldByName('FILENAME').IsNull then
    beFile.Text := ''
  else
  begin
    beFile.Text := Format('%s [%d bytes]', [fMasterDataSet.FieldByName('FILENAME').AsString,
      fMasterDataSet.FieldByName('FILESIZE').AsInteger]);
    fMasterDataSet.FieldByName('TITLE').AsString := fMasterDataSet.FieldByName('FILENAME').AsString;
  end;
end;

function TfrmCustomerContractFileEditorDlg.GetFileSize(const FileName: string): int64;
var
  sr: TSearchRec;
begin
  Result := 0;
  if FindFirst(FileName, faAnyFile, sr) = 0 then
  begin
    Result := sr.Size;
  end;
  FindClose(sr);
end;

procedure TfrmCustomerContractFileEditorDlg.BindingDataSource;
begin
  fFilePathName := '';
  edTITLE.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmCustomerContractFileEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    fMasterDataSet.Post;
    UpdateFileDataToDB;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmCustomerContractFileEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    fMasterDataSet.Insert;
    fMasterDataSet.FieldByName('CONTRACTID').AsInteger := FContractID;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmCustomerContractFileEditorDlg.SetContractID(const Value: Integer);
begin
  FContractID := Value;
end;

procedure TfrmCustomerContractFileEditorDlg.ShowSelectFileDialog;
var
  dialog: TFileOpenDialog;
  ft: TFileTypeItem;
begin
  dialog := TFileOpenDialog.Create(Self);
  try
    // PDF
    ft := dialog.FileTypes.Add;
    ft.DisplayName := 'Documente PDF';
    ft.FileMask := '*.pdf';
    // Images
    ft := dialog.FileTypes.Add;
    ft.DisplayName := 'Imagini';
    ft.FileMask := '*.jpg;*.jpeg;*.png';
    // All
    ft := dialog.FileTypes.Add;
    ft.DisplayName := 'Toate tipurile de fisiere';
    ft.FileMask := '*.*';

    if dialog.Execute then
    begin
      fFilePathName := dialog.FileName;
      fMasterDataSet.FieldByName('FILENAME').AsString := ExtractFileName(dialog.FileName);
      fMasterDataSet.FieldByName('FILESIZE').AsInteger := GetFileSize(dialog.FileName);
      DisplayFileInfo;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerContractFileEditorDlg.UpdateFileDataToDB;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text :=
      'UPDATE TDB_CONTRACT_FILES SET FILECONTENT=:DATA WHERE CONTRACTFILEID=:ID';
    Query.ParamByName('ID').AsInteger := fMasterDataSet.FieldByName('CONTRACTFILEID').AsInteger;
    Query.ParamByName('DATA').LoadFromFile(fFilePathName, ftBlob);
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TfrmCustomerContractFileEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

