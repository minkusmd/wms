unit frmFolderEditorDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, DB, IBC, StdCtrls, cxDBEdit,

  cxDBLookupComboBox, ExtCtrls, DialogTitle,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DBAccess,
  MemDS, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit;

type
  TfrmCustomerFolderEditorDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnFolder: TPanel;
    cxLabel15: TLabel;
    lcbCUSTOMER_TYPE_ID: TcxDBLookupComboBox;
    cxLabel1: TLabel;
    edNAME: TcxDBTextEdit;
    IBCQueryCustomerType: TIBCQuery;
    IBCDataSourceCustomerType: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    FParentID: integer;
    fParentCustomerType: integer;
    procedure SetParentID(const Value: integer);
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckParams: Boolean;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewRecord: Boolean write SetCreateNewRecord;
    property ParentID: integer write SetParentID;
    property ParentCustomerTypeID: integer write fParentCustomerType;
  end;

implementation

uses
  SWNUtils, SWNConst;

{$R *.dfm}

function TfrmCustomerFolderEditorDialog.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';
  with fMasterDataSet do
  begin
    if (FieldByName('NAME').IsNull) or (FieldByName('NAME').AsString = '') then
      AddErrorToStr(ErrorStr, 'Denumirea folderului!');
    if (FieldByName('CUSTOMER_TYPE_ID').IsNull) or (FieldByName('CUSTOMER_TYPE_ID').AsString = '') then
      AddErrorToStr(ErrorStr, 'Tipul folderului nu este indicat!');
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmCustomerFolderEditorDialog.BindingDataSource;
begin
  inherited;

  fCreateNewRecord := False;
  FParentID := 0;
  fParentCustomerType := -1;

  IBCQueryCustomerType.Connection := fIBCConnection;

  edNAME.DataBinding.DataSource := fMasterDataSource;
  lcbCUSTOMER_TYPE_ID.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmCustomerFolderEditorDialog.IsFormDataPosted: Boolean;
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

procedure TfrmCustomerFolderEditorDialog.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    IBCQueryCustomerType.Active := True;

    if fCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Modificare folder';

      fMasterDataSet.Append;

      fMasterDataSet.FieldByName('PARENTID').AsInteger := FParentID;
      fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger := 1;
      fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger := fParentCustomerType;
      fMasterDataSet.FieldByName('CUSTOMER_STATUS_ID').AsInteger := -1; // none
    end
    else
    begin
      dtDialogTitle.Text := 'Modificare folder';

      fMasterDataSet.Edit;
    end;

  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
    IBCQueryCustomerType.Close;

    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmCustomerFolderEditorDialog.SetCreateNewRecord(const Value: Boolean);
begin
  fCreateNewRecord := Value;
end;

procedure TfrmCustomerFolderEditorDialog.SetParentID(const Value: integer);
begin
  FParentID := Value;
end;

procedure TfrmCustomerFolderEditorDialog.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

