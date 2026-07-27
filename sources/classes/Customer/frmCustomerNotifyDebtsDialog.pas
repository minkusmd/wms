unit frmCustomerNotifyDebtsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, StdCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, DB, DBAccess, IBC, MemDS;

type
  TfrmCustomerNotifyDebtsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edCUSTOMER: TcxTextEdit;
    edDEBTS: TcxTextEdit;
    deCHECK_DATE: TcxDBDateEdit;
    Label4: TLabel;
    lcbSECONDARY_USERID: TcxDBLookupComboBox;
    IBCQueryNotify: TIBCQuery;
    IBCDataSourceNotify: TIBCDataSource;
    IBCDataSourceUsers: TIBCDataSource;
    IBCQueryUsers: TIBCQuery;
    IBCTrUpdate: TIBCTransaction;
  private
    { Private declarations }
    FCustomerID: integer;
    fReadOnly: Boolean;
    procedure SetCustomerID(const Value: integer);

    function CheckInputParams: Boolean;

    function CheckIsCustomerIsEmployer: Boolean;
    procedure ReadCustomerDebts;
    procedure SetCustomerDebtsValues(const SumaCash, SumaTransfer: Currency; const CustomerTitle: String);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CustomerID: integer read FCustomerID write SetCustomerID;
  end;

implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, DateUtils, SWNSecurity;

{$R *.dfm}
{ TfrmCustomerNorifyDebtsDlg }

function TfrmCustomerNotifyDebtsDlg.CheckIsCustomerIsEmployer: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  if (SWNSecurityManager.LoggedUser.IsInAdminGroup) then
    Exit;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT CUSTOMER_TYPE_ID FROM TS_CUSTOMER WHERE CUSTOMERID=:CustomerID';
    Query.ParamByName('CustomerID').AsInteger := FCustomerID;
    Query.ExecSQL;
    if Not Query.Eof then
      Result := Query.Fields[0].AsInteger = 4006; // only for "angajat"
    Query.Close;
  finally
    Query.Free;
  end;
end;

function TfrmCustomerNotifyDebtsDlg.CheckInputParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if IBCQueryNotify.FieldByName('CHECK_DATE').IsNull then
    AddErrorToStr(ErrorStr, 'Дата проверки!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

function TfrmCustomerNotifyDebtsDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckInputParams then
  begin
    IBCQueryNotify.Post;
    IBCQueryNotify.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmCustomerNotifyDebtsDlg.Prepare;
begin
  IBCQueryNotify.ParamByName('ID').AsInteger := FCustomerID;

  IBCQueryNotify.UpdateTransaction.StartTransaction;
  try
    if CheckIsCustomerIsEmployer then
    begin
      dtDialogTitle.Text := 'Закрытая информация';
      edDEBTS.Text := dtDialogTitle.Text;
      Label3.Enabled := False;
      deCHECK_DATE.Enabled := False;
      Label4.Enabled := False;
      lcbSECONDARY_USERID.Enabled := False;
    end
    else
    begin
      // get customer debts
      ReadCustomerDebts;

      if fReadOnly then
      begin
        dtDialogTitle.Text := 'У контрагента нет долгов на момент!';
      end
      else
      begin
        IBCQueryNotify.Active := True;
        if (IBCQueryNotify.Eof) then
        begin
          // Create new record
          dtDialogTitle.Text := 'Создание нового напоминания';
          IBCQueryNotify.Insert;
          IBCQueryNotify.FieldByName('CUSTOMERID').AsInteger := FCustomerID;
          IBCQueryNotify.FieldByName('SECONDARY_USERID').Value := null;
          IBCQueryNotify.FieldByName('CHECK_DATE').AsDateTime := Now + 1;
        end
        else
        begin
          // Modify
          dtDialogTitle.Text := 'Изменение напоминания';
          IBCQueryNotify.Edit;
        end;
        IBCQueryUsers.Active := True;
      end;
    end;
  except
    IBCQueryNotify.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmCustomerNotifyDebtsDlg.ReadCustomerDebts;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT SUM(SUMA_CASH), SUM(SUMA_TRANSFER), ');
    Query.SQL.Add('(SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE CUSTOMERID=:CustomerID)');
    Query.SQL.Add('FROM SP_CALC_DEBTS(:CustomerID,:startDate,CURRENT_DATE)');
    Query.ParamByName('CustomerID').AsInteger := FCustomerID;
    Query.ParamByName('startDate').AsDate := DateOf(EncodeDate(2010, 1, 1));
    Query.ExecSQL;
    if Not Query.Eof then
      SetCustomerDebtsValues(Query.Fields[0].AsCurrency, Query.Fields[1].AsCurrency,
        Query.Fields[2].AsString);
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmCustomerNotifyDebtsDlg.SetCustomerDebtsValues(const SumaCash, SumaTransfer: Currency;
  const CustomerTitle: String);
begin
  edCUSTOMER.Text := CustomerTitle;
  edDEBTS.Text := Format('Наличные: $(%2.2f), безналичные: MDL(%2.2f)', [SumaCash, SumaTransfer]);
  if (SumaCash < 0) or (SumaTransfer < 0) then
  begin
    // datorii
    edDEBTS.Style.TextColor := clRed;
    fReadOnly := False;
  end
  else
  begin
    // nu sunt datorii
    fReadOnly := True;
    edDEBTS.Style.TextColor := clGrayText;
    btnOk.Visible := False;
    btnCancel.Caption := 'Закрыть';
    Label3.Enabled := False;
    deCHECK_DATE.Enabled := False;
    Label4.Enabled := False;
    lcbSECONDARY_USERID.Enabled := False;
  end;
end;

procedure TfrmCustomerNotifyDebtsDlg.SetCustomerID(const Value: integer);
begin
  FCustomerID := Value;
end;

procedure TfrmCustomerNotifyDebtsDlg.WhenCancelForm;
begin
  IBCQueryNotify.Cancel;
  IBCQueryNotify.UpdateTransaction.Rollback;
end;

end.
