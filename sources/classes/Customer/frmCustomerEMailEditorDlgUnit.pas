unit frmCustomerEMailEditorDlgUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, DialogTitle, cxControls, cxContainer, cxEdit, cxMemo, cxDBEdit, cxCheckBox, cxTextEdit,
  cxMaskEdit, cxButtonEdit, cxLabel, System.UITypes, Vcl.ExtCtrls;

type
  TfrmCustomerEMailEditorDialog = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Panel1: TPanel;
    cxLabel1: TcxLabel;
    teEMail: TcxDBMaskEdit;
    cbUnsubscribed: TcxDBCheckBox;
  private
    FCustomerID: Integer;
    FIsNewRecord: Boolean;
    procedure SetCustomerID(const Value: Integer);
    procedure SetIsNewRecord(const Value: Boolean);
    { Private declarations }
  protected
    function CheckParams: Boolean;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    property CustomerID: Integer read FCustomerID write SetCustomerID;
    property IsNewRecord: Boolean read FIsNewRecord write SetIsNewRecord;
    { Public declarations }
  end;

var
  frmCustomerEMailEditorDialog: TfrmCustomerEMailEditorDialog;

implementation

uses
  DataModuleAdditions, SWNDBErrors, SWNConst, DB, SWNUtils;

{$R *.dfm}

function TfrmCustomerEMailEditorDialog.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := True;
  ErrorStr := '';
  with fMasterDataSet do
  begin
    if ( (FieldByName('EMail').IsNull) or (FieldByName('EMail').AsString = '') ) then
      AddErrorToStr(ErrorStr, 'Introduceti corect EMail');
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

{ TfrmCustomerPhonesEditorDialog }

function TfrmCustomerEMailEditorDialog.IsFormDataPosted: Boolean;
begin
  Result := False;
  try
    if CheckParams then
    begin
      if (fMasterDataSet.State in [dsEdit, dsInsert]) then
      begin
        fMasterDataSet.Post;
      end;
      Result := True;
    end;
  except
    on e: Exception do
    begin
      Result := False;
      if not ProcessSWNError(e) then
        raise
    end;
  end;
end;

procedure TfrmCustomerEMailEditorDialog.Prepare;
begin
    if IsNewRecord then
  begin
    fMasterDataSet.Append;
    fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := CustomerID;
    fMasterDataSet.FieldByName('UNSUBSCRIBED').AsInteger := 0;
  end
  else
  begin
    fMasterDataSet.Edit;
  end;
  ActiveControl := teEMail;
  teEMail.DataBinding.DataSource := fMasterDataSource;
  cbUnsubscribed.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmCustomerEMailEditorDialog.SetCustomerID(const Value: Integer);
begin
  FCustomerID := Value;
end;

procedure TfrmCustomerEMailEditorDialog.SetIsNewRecord(const Value: Boolean);
begin
  FIsNewRecord := Value;
end;

procedure TfrmCustomerEMailEditorDialog.WhenCancelForm;
begin
  if (fMasterDataSet.State in [dsInsert, dsEdit]) then
    fMasterDataSet.Cancel;
end;

end.
