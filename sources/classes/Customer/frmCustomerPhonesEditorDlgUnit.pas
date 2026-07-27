unit frmCustomerPhonesEditorDlgUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, DialogTitle, cxControls, cxContainer, cxEdit, cxMemo, cxDBEdit, cxCheckBox, cxTextEdit,
  cxMaskEdit, cxButtonEdit, cxLabel, System.UITypes, Vcl.ExtCtrls, dxUIAClasses, dxCoreGraphics;

type
  TfrmCustomerPhonesEditorDialog = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Panel1: TPanel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    beCustomerComunicationType: TcxButtonEdit;
    meNotes: TcxDBMemo;
    tePhoneNumber: TcxDBMaskEdit;
    cbFLG_SMS: TcxDBCheckBox;
    procedure beCustomerComunicationTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    FCustomerID: Integer;
    FFlgSMS: Integer;
    FIsNewRecord: Boolean;
    procedure SetCustomerID(const Value: Integer);
    procedure SetFlgSMS(const Value: Integer);
    procedure SetIsNewRecord(const Value: Boolean);
    { Private declarations }
  protected
    function CheckParams: Boolean;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    property CustomerID: Integer read FCustomerID write SetCustomerID;
    property FlgSMS: Integer read FFlgSMS write SetFlgSMS;
    property IsNewRecord: Boolean read FIsNewRecord write SetIsNewRecord;
    { Public declarations }
  end;

var
  frmCustomerPhonesEditorDialog: TfrmCustomerPhonesEditorDialog;

implementation

uses
  DataModuleAdditions, SWNDBErrors, SWNConst, DB, SWNUtils, frmSyssEditorWindow;

{$R *.dfm}

procedure TfrmCustomerPhonesEditorDialog.beCustomerComunicationTypePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  syssEditor: TfrmSelectSyssEditorWin;
begin
  syssEditor := TfrmSelectSyssEditorWin.Create(Self);
  try
    if not fMasterDataSet.FieldByName('PHONETYPEID').IsNull then
      syssEditor.SYSSID := fMasterDataSet.FieldByName('PHONETYPEID').AsInteger;
    syssEditor.SelectMode := True;
    syssEditor.SetDefaultGroup(44); // TIPURI DE TELEFOANE
    syssEditor.ShowModal;
    fMasterDataSet.FieldByName('PHONETYPEID').AsInteger := syssEditor.SYSSID;
    fMasterDataSet.FieldByName('PHONETYPE').AsString := syssEditor.SyssTitle;
    beCustomerComunicationType.Text := syssEditor.SyssTitle;
  finally
    syssEditor.Free;
  end;
end;

function TfrmCustomerPhonesEditorDialog.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := True;
  ErrorStr := '';
  with fMasterDataSet do
  begin
    if (FieldByName('PHONENUMBER').IsNull) or (FieldByName('PHONENUMBER').AsString.Length <> 9) then
      AddErrorToStr(ErrorStr, 'Numarul trebuie sa aiba 9 cifre! Exemplue: 069123456, 022903090');
    if FieldByName('PHONETYPEID').IsNull then
      AddErrorToStr(ErrorStr, 'Alegeti tipul numarului de telefon!');
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

{ TfrmCustomerPhonesEditorDialog }

function TfrmCustomerPhonesEditorDialog.IsFormDataPosted: Boolean;
begin
  Result := False;
  try
    if CheckParams then
    begin
      if (fMasterDataSet.State in [dsEdit, dsInsert]) then
        fMasterDataSet.Post;
      FlgSMS := fMasterDataSet.FieldByName('FLG_SMS').AsInteger;
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

procedure TfrmCustomerPhonesEditorDialog.Prepare;
begin
    if IsNewRecord then
  begin
    fMasterDataSet.Append;
    fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := CustomerID;

    fMasterDataSet.FieldbyName('PHONETYPEID').AsInteger := 7468;
    fMasterDataSet.FieldbyName('PHONETYPE').AsString := 'Mobil';

    beCustomerComunicationType.Tag := 7468;
    beCustomerComunicationType.Text := 'Mobil';

  end
  else
  begin
    beCustomerComunicationType.Text := fMasterDataSet.FieldByName('PHONETYPE').AsString;
    beCustomerComunicationType.Tag := fMasterDataSet.FieldByName('PHONETYPEID').AsInteger;
    fMasterDataSet.Edit;
  end;
  ActiveControl := tePhoneNumber;
  tePhoneNumber.DataBinding.DataSource := fMasterDataSource;
  meNotes.DataBinding.DataSource := fMasterDataSource;
  cbFLG_SMS.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmCustomerPhonesEditorDialog.SetCustomerID(const Value: Integer);
begin
  FCustomerID := Value;
end;

procedure TfrmCustomerPhonesEditorDialog.SetFlgSMS(const Value: Integer);
begin
   FFlgSMS := Value;
end;

procedure TfrmCustomerPhonesEditorDialog.SetIsNewRecord(const Value: Boolean);
begin
  FIsNewRecord := Value;
end;

procedure TfrmCustomerPhonesEditorDialog.WhenCancelForm;
begin
  if (fMasterDataSet.State in [dsInsert, dsEdit]) then
    fMasterDataSet.Cancel;
end;

end.
