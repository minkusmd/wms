unit frmUserActivityMonitorEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle,
  Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxSpinEdit, cxDBEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  Data.DB, DBAccess, IBC, MemDS, cxCheckBox;

type
  TfrmUserActivityMonitorEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    seInterval: TcxDBSpinEdit;
    Label3: TLabel;
    clbUsers: TcxDBLookupComboBox;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    cbFLG_ENABLED: TcxDBCheckBox;
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
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
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, SWNUtils, SWNConst;

{ TfrmUserActivityMonitorEditorDlg }

function TfrmUserActivityMonitorEditorDlg.CheckValues: Boolean;
var
  Errors: string;
begin
  Result := false;
  if (fMasterDataSet.FieldByName('USERID').IsNull) then
    AddErrorToStr(Errors, 'Utilizator!');
  if (fMasterDataSet.FieldByName('INTERVAL').IsNull) or (fMasterDataSet.FieldByName('INTERVAL').asInteger < 1) then
    AddErrorToStr(Errors, 'Interval!');

  if (Errors = '') then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmUserActivityMonitorEditorDlg.BindingDataSource;
begin
  cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
  clbUsers.DataBinding.DataSource := fMasterDataSource;
  seInterval.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmUserActivityMonitorEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmUserActivityMonitorEditorDlg.Prepare;
begin
  try
    fMasterDataSet.UpdateTransaction.StartTransaction;
    if FCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Creare monitor nou';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 1;
      fMasterDataSet.FieldByName('INTERVAL').AsInteger := 5;
    end
    else
    begin
      dtDialogTitle.Text := 'Modificare inregistrare';
      fMasterDataSet.Edit;
    end;
    IBCQueryUsers.Active := True;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmUserActivityMonitorEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmUserActivityMonitorEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

