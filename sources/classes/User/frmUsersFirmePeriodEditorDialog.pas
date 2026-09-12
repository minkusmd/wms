unit frmUsersFirmePeriodEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxTextEdit, cxMaskEdit, cxCalendar, cxDBEdit, Vcl.ExtCtrls, DialogTitle;

type
  TfrmUsersFirmePeriodEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    deSTART_DATE: TcxDBDateEdit;
    deEND_DATE: TcxDBDateEdit;
    lcbFIRMAID: TcxDBLookupComboBox;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormDestroy(Sender: TObject);
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

uses DataModuleDB, DataModuleAdditions, SWNConst, SWNUtils;

{ TfrmUsersFirmePeriodEditorDlg }

function TfrmUsersFirmePeriodEditorDlg.CheckValues: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('START_DATE').IsNull or fMasterDataSet.FieldByName('END_DATE').IsNull or
    (fMasterDataSet.FieldByName('END_DATE').AsDateTime < fMasterDataSet.FieldByName('START_DATE').AsDateTime) then
    AddErrorToStr(ErrorStr, 'Perioada!');

  if fMasterDataSet.FieldByName('FIRMAID').IsNull or (fMasterDataSet.FieldByName('FIRMAID').AsInteger = -1) then
    AddErrorToStr(ErrorStr, 'Firma!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmUsersFirmePeriodEditorDlg.FormDestroy(Sender: TObject);
begin
  dmDB.IBCQueryFirms.Active := False;
end;

procedure TfrmUsersFirmePeriodEditorDlg.BindingDataSource;
begin
  deSTART_DATE.DataBinding.DataSource := fMasterDataSource;
  deEND_DATE.DataBinding.DataSource := fMasterDataSource;
  lcbFIRMAID.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmUsersFirmePeriodEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    fMasterDataSet.Post;
    Result := True;
  end;
end;

procedure TfrmUsersFirmePeriodEditorDlg.Prepare;
begin
  try
    if FCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Creare inregistrare noua';
      fMasterDataSet.Insert;
    end
    else
    begin
      dtDialogTitle.Text := 'Modificare inregistrare';
      fMasterDataSet.Edit;
    end;
    dmDB.IBCQueryFirms.Active := True;

  except
    on E: Exception do
    begin
      fMasterDataSet.Cancel;
      raise;
    end;
  end;
end;

procedure TfrmUsersFirmePeriodEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmUsersFirmePeriodEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
end;

end.
