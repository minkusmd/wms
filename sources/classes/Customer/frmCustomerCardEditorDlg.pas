unit frmCustomerCardEditorDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB, IBC, SWNBaseUnit, Dialogs, DialogTitle,
  ExtCtrls, Menus, StdCtrls, cxButtons, cxDBEdit,
  cxDropDownEdit,
  Buttons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, MemDS, DBAccess,
  cxMaskEdit, cxCalendar, cxTextEdit, cxCheckBox;

type
  TfrmCustomerCardEditorDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnCard: TPanel;
    cbFLG_ENABLED: TcxDBCheckBox;
    IBCQueryCheckSN: TIBCQuery;
    cxLabel3: TLabel;
    edSN: TcxDBTextEdit;
    Label1: TLabel;
    deVALID_UNTIL_DATE: TcxDBDateEdit;
    Label2: TLabel;
    cmbPRICE_COLUMN: TcxDBComboBox;
    sbValid3Months: TSpeedButton;
    sbValid1Year: TSpeedButton;
    sbValidForever: TSpeedButton;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    procedure sbValidForeverClick(Sender: TObject);
  private
    { Private declarations }
    fAddNewCard: Boolean;
    fInitSNValue: string;
    FCustomerID: integer;
    function CheckParams: Boolean;
    function LoadSNInfo(const SN: string): Boolean;
    procedure SetExpireDateFromAddedMonths(const Months: integer);
    procedure SetCustomerID(const Value: integer);
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property AddNewCard: Boolean read fAddNewCard write fAddNewCard;
    property CustomerID: integer read FCustomerID write SetCustomerID;
  end;

implementation

uses
  SWNUtils, SWNConst, DateUtils, DataModuleDB, SWNSecurityFlags, SWNSecurity;

{$R *.dfm}
{ TfrmCustomerCardEditorDialog }

function TfrmCustomerCardEditorDialog.CheckParams: Boolean;
var
  ErrorStr: string;
  S: string;
begin
  Result := False;
  ErrorStr := '';

  S := fMasterDataSet.FieldByName('SN').AsString;
  if Trim(S) = '' then
    ErrorStr := 'Lipseste numarul cardului!'
  else if (S <> fInitSNValue) then
  begin
    if not LoadSNInfo(S) then
      ErrorStr := 'Nu este disponibil cardul cu numarul dat!';
  end;

  if fMasterDataSet.FieldByName('PRICE_COLUMN').IsNull then
    AddErrorToStr(ErrorStr, 'Grila de preturi!');

  if fMasterDataSet.FieldByName('VALID_UNTIL_DATE').IsNull or (fMasterDataSet.FieldByName('VALID_UNTIL_DATE').AsDateTime < Now) then
    AddErrorToStr(ErrorStr, 'Valid pina la!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, ErrorStr);
end;

procedure TfrmCustomerCardEditorDialog.BindingDataSource;
begin
  inherited;

  fAddNewCard := False;
  fInitSNValue := '';

  edSN.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
  cmbPRICE_COLUMN.DataBinding.DataSource := fMasterDataSource;
  deVALID_UNTIL_DATE.DataBinding.DataSource := fMasterDataSource;

  IBCQueryCheckSN.Connection := fIBCConnection;
  IBCQueryCheckSN.Transaction := fMasterDataSet.UpdateTransaction;
end;

function TfrmCustomerCardEditorDialog.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fMasterDataSet.Post;
    Result := True;
  end
  else
    Result := False;
end;

function TfrmCustomerCardEditorDialog.LoadSNInfo(const SN: string): Boolean;
begin
  Result := False;
  IBCQueryCheckSN.ParamByName('SN').AsString := SN;
  try
    IBCQueryCheckSN.Open;
    if not IBCQueryCheckSN.Eof then
    begin
      fMasterDataSet.FieldByName('DOCID').AsInteger := IBCQueryCheckSN.FieldByName('DOCID').AsInteger;
      fMasterDataSet.FieldByName('DTDEP').AsInteger := IBCQueryCheckSN.FieldByName('DTDEP').AsInteger;
      fMasterDataSet.FieldByName('CTDEP').AsInteger := IBCQueryCheckSN.FieldByName('CTDEP').AsInteger;
      fMasterDataSet.FieldByName('GOODSCOMPLECT_ID').AsInteger := IBCQueryCheckSN.FieldByName('GOODSCOMPLECT_ID').AsInteger;
      fMasterDataSet.FieldByName('GOODSID').AsInteger := IBCQueryCheckSN.FieldByName('GOODSID').AsInteger;
      Result := True;
    end;
  finally
    IBCQueryCheckSN.Close;
  end;
end;

procedure TfrmCustomerCardEditorDialog.Prepare;
var
  N: integer;
begin
  try
    N := dmDB.GetCustomerPriceColumn(FCustomerID);

    if fAddNewCard then
    begin
      dtDialogTitle.Text := Format('Crearea unui card nou. Grila de pret: %d', [N]);

      fMasterDataSet.Append;
      fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 1;
      fMasterDataSet.FieldByName('PRICE_COLUMN').AsInteger := 3;
      SetExpireDateFromAddedMonths(3);
    end
    else
    begin
      dtDialogTitle.Text := Format('Modificare informatie card. Grila de pret: %d', [N]);

      fMasterDataSet.Edit;
      fInitSNValue := fMasterDataSet.FieldByName('SN').AsString;
    end;
  except
    fMasterDataSet.Cancel;
    raise;
  end;

end;

procedure TfrmCustomerCardEditorDialog.sbValidForeverClick(Sender: TObject);
begin
  SetExpireDateFromAddedMonths(TSpeedButton(Sender).Tag);
end;

procedure TfrmCustomerCardEditorDialog.SetCustomerID(const Value: integer);
begin
  FCustomerID := Value;
end;

procedure TfrmCustomerCardEditorDialog.SetExpireDateFromAddedMonths(const Months: integer);
begin
  fMasterDataSet.FieldByName('VALID_UNTIL_DATE').AsDateTime := IncMonth(Now, Months);
end;

procedure TfrmCustomerCardEditorDialog.SetupSecurityItems;
begin
  inherited;
  with cmbPRICE_COLUMN.Properties.Items do
  begin
    Clear;
    Add('1');
    Add('2');
    Add('3');
    Add('4');

    if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Клиенты_5_колонка_для_дисконтных_картах) then
    begin
      Add('5');
    end;
  end;
end;

procedure TfrmCustomerCardEditorDialog.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
end;

end.


