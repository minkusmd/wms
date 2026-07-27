unit uCustomerEventsEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxButtonEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxLabel, DialogTitle, AddDSEUnit, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxMemo, cxCalc, IBC;

type
  TfrmCustomerEventsEditorDialog = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    cxLabel1: TcxLabel;
    deData: TcxDBDateEdit;
    cxLabel2: TcxLabel;
    beCustomerEventType: TcxButtonEdit;
    cxLabel3: TcxLabel;
    cePeriodicitate: TcxDBCalcEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    meNotes: TcxDBMemo;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    deNextDate: TcxDBDateEdit;
    cxLabel6: TcxLabel;
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    FCustomerID: Integer;
    FIsNewRecord: boolean;
    procedure SetCustomerID(const Value: Integer);
    procedure SetIsNewRecord(const Value: boolean);
    { Private declarations }
  protected
    function CheckParams: Boolean;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property CustomerID: Integer read FCustomerID write SetCustomerID;
    property IsNewRecord: boolean read FIsNewRecord write SetIsNewRecord;
    { Public declarations }
  end;

implementation

uses
  frmSyssEditorWindow, DataModuleAdditions, DB, SWNDBErrors, SWNUtils, SWNConst;

{$R *.dfm}

function TfrmCustomerEventsEditorDialog.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := True;
  ErrorStr := '';
  with fMasterDataSet do
  begin
    if (FieldByName('PERIODICITATE').IsNull) or (FieldByName('PERIODICITATE').AsInteger < 1) then
      AddErrorToStr(ErrorStr, 'Indicati o valoare > 0 pentru Periodicitate!');
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Indicati o valoare pentru cimpul "DATA"!');
    if (FieldByName('NEXT_DATA').IsNull) or (FieldByName('NEXT_DATA').AsDateTime <= FieldByName('DATA').AsDateTime) then
      AddErrorToStr(ErrorStr, 'Indicati o valoare pentru cimpul "DATA URMATOARE"!');
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

{ TfrmUsersEventEditorDialog }

procedure TfrmCustomerEventsEditorDialog.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  syssEditor: TfrmSelectSyssEditorWin;
begin
  syssEditor := TfrmSelectSyssEditorWin.Create(Self);
  try
    if not fMasterDataSet.FieldByName('EVENTTYPEID').IsNull then
      syssEditor.SYSSID := fMasterDataSet.FieldByName('EVENTTYPEID').AsInteger;
    syssEditor.SelectMode := True;
    syssEditor.SetDefaultGroup(43); // Evenimente speciale ale clientului
    if syssEditor.ShowModal=mrOk then
    begin
      fMasterDataSet.FieldByName('EVENTTYPEID').AsInteger := syssEditor.SYSSID;
      fMasterDataSet.FieldByName('CUSTOMER_EVENT_TYPE').AsString := syssEditor.SyssTitle;
      beCustomerEventType.Text := syssEditor.SyssTitle;
    end;
  finally
    syssEditor.Free;
  end;
end;

function TfrmCustomerEventsEditorDialog.IsFormDataPosted: Boolean;
begin
  Result := False;
  try
    if CheckParams then
    begin

      if (fMasterDataSet.State in [dsInsert, dsEdit]) then
        fMasterDataSet.Post;

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

procedure TfrmCustomerEventsEditorDialog.Prepare;
begin

  if IsNewRecord then
  begin
    fMasterDataSet.Append;
    fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := FCustomerID;
    beCustomerEventType.Text := '';
    beCustomerEventType.Tag := -1;

  end
  else
  begin
    beCustomerEventType.Text := fMasterDataSet.FieldByName('CUSTOMER_EVENT_TYPE').AsString;
    beCustomerEventType.Tag := fMasterDataSet.FieldByName('EVENTTYPEID').AsInteger;
    fMasterDataSet.Edit;
  end;

  deData.DataBinding.DataSource := fMasterDataSource;
  deNextDate.DataBinding.DataSource := fMasterDataSource;

  cePeriodicitate.DataBinding.DataSource := fMasterDataSource;
  meNotes.DataBinding.DataSource := fMasterDataSource;

end;

procedure TfrmCustomerEventsEditorDialog.SetCustomerID(const Value: Integer);
begin
  FCustomerID := Value;
end;

procedure TfrmCustomerEventsEditorDialog.SetIsNewRecord(const Value: boolean);
begin
  FIsNewRecord := Value;
end;

procedure TfrmCustomerEventsEditorDialog.WhenCancelForm;
begin
  if (fMasterDataSet.State in [dsInsert, dsEdit]) then
    fMasterDataSet.Cancel;
end;

end.

