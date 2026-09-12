unit frmMoneyTransferDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, cxDBLookupComboBox, cxTextEdit, DB, DBAccess,
  IBC, StdCtrls,
  ExtCtrls, DialogTitle,
  cxMemo, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  MemDS, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit;

type
  TfrmMoneyTransferDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    edSuma: TEdit;
    Label1: TLabel;
    edUserName: TcxTextEdit;
    Label2: TLabel;
    Label3: TLabel;
    clbFirme: TcxLookupComboBox;
    IBCQueryFirme: TIBCQuery;
    IBCDataSourceFirme: TIBCDataSource;
    cmbCURRENCY: TcxLookupComboBox;
    cbACNT: TCheckBox;
    Label5: TLabel;
    mmComments: TcxMemo;
    edFirmaName: TcxTextEdit;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    function getCurrencyID: integer;
    function getSUMA: Currency;
    procedure SetSUMA(const Value: Currency);
    function CheckParams: Boolean;
    function CheckTargetCredentials(const UserID: integer): Boolean;
    function DoMoneyTransferDB: Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
    FromUserID: Integer;
    FromUserName: string;
    FromDT: Integer;
    FromDTName: string;
    procedure SetCustomTitle(const ACaption, ADescription: string);
    // in/out
    property SUMA: Currency read getSUMA write SetSUMA;
    // out
    property CurrencyID: integer read getCurrencyID;
  end;

implementation

uses
  DataModuleDB, SWNUtils, frmPasswordDlg, SWNSecurity,
  SWNDBErrors;

{$R *.dfm}

{ TForm1 }

procedure TfrmMoneyTransferDlg.btnOkClick(Sender: TObject);
var
  S: string;
begin
  if CheckParams then
  begin
    S := Format('Doriti sa va transferati %f %s ?', [StrToCurr(edSuma.Text), cmbCURRENCY.Text]);

    if ShowAskDialog('Transfer de bani', S + #13#10 + #13#10 + 'Pentru continuarea operatiei va fi necesara parola dumneavoastra.') = mrYes then
    begin
      if CheckTargetCredentials(dmDB.CurrentUserID) then
      begin
        if DoMoneyTransferDB then
          ModalResult := mrOk;
      end
      else
        ShowErrorDialog('Parola incorecta', 'Parola dumneavoastra este incorecta!');
    end;
  end;
end;

function TfrmMoneyTransferDlg.CheckParams: Boolean;
var
  ErrorStr: string;
  tmpSuma: Currency;
begin
  Result := False;
  ErrorStr := '';

  if VarIsNull(clbFirme.EditValue) or (clbFirme.EditValue <= 0) then
    AddErrorToStr(ErrorStr, 'Indicati firma!');
  if VarIsNull(cmbCURRENCY.EditValue) or (cmbCURRENCY.EditValue <= 0) then
    AddErrorToStr(ErrorStr, 'Indicati tipul de valuta!');
  if Trim(edSuma.Text) = '' then
    AddErrorToStr(ErrorStr, 'Indicati suma de bani!')
  else
  begin
    tmpSuma := StrToCurrDef(edSuma.Text, 0);
    if (tmpSuma < 1) then
      AddErrorToStr(ErrorStr, 'Indicati suma de bani!');
  end;

  if (ErrorStr = '') then
    Result := True
  else
    ShowErrorDialog('Eroare date', ErrorStr);
end;

function TfrmMoneyTransferDlg.CheckTargetCredentials(const UserID: integer): Boolean;
var
  dialog: TfrmPasswordDialog;
begin
  Result := False;
  dialog := TfrmPasswordDialog.Create(Self, pdmAskPassword);
  try
    if dialog.ShowModal = mrOk then
    begin
      Result := SWNSecurityManager.TestUserPassword(UserID, dialog.Password);
    end;
  finally
    dialog.Free;
  end;
end;

function TfrmMoneyTransferDlg.DoMoneyTransferDB: Boolean;
var
  Query: TIBCQuery;
  rate: double;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    try
      Query.Transaction.StartTransaction;

      Query.SQL.Text := 'INSERT INTO VW_TDB_CASH_JURNAL (FLG_DT_CONFIRMED, FLG_CT_CONFIRMED, DT, CURRENCYID_DT, USER_DT, SUMA_DT, FLG_ACNT_DT, RATE_DT, CT, CURRENCYID_CT, USER_CT, SUMA_CT, FLG_ACNT_CT, RATE_CT, COMMENT)' + 'VALUES (:FLG_DT_CONFIRMED, :FLG_CT_CONFIRMED, :DT, :CURRENCYID_DT, :USER_DT, :SUMA_DT, :FLG_ACNT_DT, :RATE_DT, :CT, :CURRENCYID_DT, :USER_DT, :SUMA_DT, :FLG_ACNT_CT, :RATE_CT, :COMMENT)';

      Query.ParamByName('CURRENCYID_DT').AsInteger := cmbCURRENCY.EditValue;
      Query.ParamByName('FLG_DT_CONFIRMED').AsInteger := 1;
      Query.ParamByName('FLG_CT_CONFIRMED').AsInteger := 1;
      Query.ParamByName('DT').AsInteger := FromDT; //dmDB.CurrentFirma;
      Query.ParamByName('USER_DT').AsInteger := FromUserID; //dmDB.CurrentUserID;
      Query.ParamByName('SUMA_DT').AsCurrency := StrToCurr(edSuma.Text);
      Query.ParamByName('FLG_ACNT_DT').AsInteger := Ord(cbACNT.Checked);
      Query.ParamByName('CT').AsInteger := clbFirme.EditValue;
      Query.ParamByName('FLG_ACNT_CT').AsInteger := Ord(cbACNT.Checked);
      rate := dmDB.GetCurrencyExchangeValue(cmbCURRENCY.EditValue, cbACNT.Checked);
      Query.ParamByName('RATE_DT').AsFloat := rate;
      Query.ParamByName('RATE_CT').AsFloat := rate;
      Query.ParamByName('COMMENT').AsString := Trim(mmComments.Text);
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        if Query.Transaction.Active then
          Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmMoneyTransferDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmDB.IBCQueryCurrency.Active := False;
end;

function TfrmMoneyTransferDlg.getCurrencyID: integer;
begin
  Result := cmbCURRENCY.EditValue;
end;

function TfrmMoneyTransferDlg.getSUMA: Currency;
begin
  Result := StrToCurrDef(edSuma.Text, 0);
end;

procedure TfrmMoneyTransferDlg.Prepare;
begin
  try

    edUserName.Text := dmDB.CurrentUserFullName;
    edFirmaName.Text := dmdb.GetCustomerDisplayName(FromDT); //dmDB.CurrentFirmaName;
    IBCQueryFirme.ParamByName('USERID').AsInteger := dmDB.CurrentUserID;
    IBCQueryFirme.ParamByName('currFirma').AsInteger := FromDT; //dmDB.CurrentFirma;
    IBCQueryFirme.Active := True;

    dmDB.IBCQueryCurrency.Active := True;
    cmbCURRENCY.EditValue := 498; // MDL by default
  except
    dmDB.IBCQueryCurrency.Active := False;

    raise;
  end;
end;

procedure TfrmMoneyTransferDlg.SetCustomTitle(const ACaption, ADescription: string);
begin
  Caption := ACaption;
  dtDialogTitle.Title := ACaption;
  dtDialogTitle.Text := dtDialogTitle.Text + ' ' + ADescription;
end;

procedure TfrmMoneyTransferDlg.SetSUMA(const Value: Currency);
begin
  edSUMA.Text := FloatToStr(Value);
end;

end.

