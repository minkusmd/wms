unit frmStockFolderEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, Menus, StdCtrls, cxDBEdit, ExtCtrls,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckBox, cxTextEdit;

type
  TfrmStockFolderEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    edTITLE: TcxDBTextEdit;
    cbFLG_VISISIBLE_FOR_SALE: TcxDBCheckBox;
    cbFLG_ADMINISTRATIA: TcxDBCheckBox;
    cbFLG_RMA: TcxDBCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    FParentID: integer;
    FCreateNewFolder: Boolean;
    procedure SetParentID(const Value: integer);
    procedure SetCreateNewFolder(const Value: Boolean);
    function CheckParams: Boolean;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;

    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    property ParentID: integer read FParentID write SetParentID;
    property CreateNewFolder: Boolean read FCreateNewFolder write SetCreateNewFolder;
  end;

implementation

uses DB, SWNUtils, SWNConst;

{$R *.dfm}
{ TfrmGoodsAcntFolderDlg }

function TfrmStockFolderEditorDlg.CheckParams: Boolean;
var
  ErrorStr: String;
begin
  ErrorStr := '';
  Result := False;

  with fMasterDataSet do
  begin
    if FieldByName('TITLE').IsNull or (FieldByName('TITLE').AsWideString = '') then
      AddErrorToStr(ErrorStr, 'Название папки!');
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmStockFolderEditorDlg.BindingDataSource;
begin
  inherited;
  FParentID := 0;
  FCreateNewFolder := False;
  edTITLE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_VISISIBLE_FOR_SALE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ADMINISTRATIA.DataBinding.DataSource := fMasterDataSource;
  cbFLG_RMA.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmStockFolderEditorDlg.IsFormDataPosted: Boolean;
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

procedure TfrmStockFolderEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if FCreateNewFolder then
    begin
      dtDialogTitle.Text := 'Создание новой папки';
      fMasterDataSet.Append;
      fMasterDataSet.FieldByName('PARENTID').AsInteger := FParentID;
      fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger := 1;
    end
    else
    begin
      dtDialogTitle.Text := 'Изменение папки';
      fMasterDataSet.Edit;
    end;
  except
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmStockFolderEditorDlg.SetCreateNewFolder(const Value: Boolean);
begin
  FCreateNewFolder := Value;
end;

procedure TfrmStockFolderEditorDlg.SetParentID(const Value: integer);
begin
  FParentID := Value;
end;

procedure TfrmStockFolderEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
