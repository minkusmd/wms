unit frmMoneyIncomeDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Menus, StdCtrls, cxButtons,
  cxCurrencyEdit,
  cxDBLookupComboBox, frameMoneyCounterUnit, cxCalc,
  ExtCtrls, DialogTitle,
  DB,
  cxGridCustomTableView,
  DBAccess, IBC, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxTextEdit, cxMaskEdit, MemDS, cxGroupBox, cxRadioGroup;

type
  TfrmMoneyIncomeDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    ceSUMA: TcxCalcEdit;
    ceRATE: TcxCalcEdit;
    frameMoneyCounter: TframeMoneyCounter;
    cmbCURRENCY: TcxLookupComboBox;
    pnBottom: TPanel;
    cxLabel3: TLabel;
    cxLabel4: TLabel;
    ceSUMA_Received: TcxCalcEdit;
    edSUMA_Back: TcxCurrencyEdit;
    Label1: TLabel;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    pnIncasareDetail: TPanel;
    lcbUsers: TcxLookupComboBox;
    lbToUser: TLabel;
    rgModIncasare: TcxRadioGroup;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    lbDatorii: TLabel;
    lbGestiune: TLabel;
    lbContabilitate: TLabel;
    ceDatoriiContabile: TcxCalcEdit;
    ceDatoriiGestiune: TcxCalcEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbCURRENCYPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    fFLG_ACNT: Boolean;
    fLastCurrencyID: integer;
    FShowModIncasare: boolean;
    fTargetDocTypeID: integer;
    procedure WhenBanknotesCounterSumaChanged(Sender: TObject);
    function getCurrencyID: integer;
    function getRate: Double;
    function getSUMA: Currency;
    procedure SetAllowChangeCurrency(const Value: Boolean);
    procedure SetAllowChangeCurrencyRate(const Value: Boolean);
    procedure SetShowBanknotesCounter(const Value: Boolean);
    function getFLG_ACNT: integer;
    function CheckParams: Boolean;
    procedure ReadClientDebts;
    procedure SetShowModIncasare(const Value: boolean);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    procedure SetCustomTitle(const ACaption, ADescription: string);
    // in
    property AllowChangeCurrency: Boolean write SetAllowChangeCurrency;
    property AllowChangeCurrencyRate: Boolean write SetAllowChangeCurrencyRate;
    property ShowBanknotesCounter: Boolean write SetShowBanknotesCounter;

    // in/out
    property SUMA: Currency read getSUMA;
    // out
    property CurrencyID: integer read getCurrencyID;
    property Rate: Double read getRate;
    property FLG_ACNT: integer read getFLG_ACNT;
    property ShowModIncasare: boolean read FShowModIncasare write
        SetShowModIncasare;
    property TargetDocTypeID: integer read fTargetDocTypeID write fTargetDocTypeID;
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNTypes, DateUtils,
  SWNSecurityFlags, SWNSecurity;

{$R *.dfm}

{ TForm1 }

function TfrmMoneyIncomeDlg.CheckParams: Boolean;
begin
  if getSUMA <= 0 then
  begin
    ShowErrorDialog('Eroare', 'Suma incorecta!');
    Result := False;
  end
  else
    Result := True;
end;

procedure TfrmMoneyIncomeDlg.cmbCURRENCYPropertiesEditValueChanged(Sender: TObject);
var
  tmpSuma: Currency;
  tmpRate: double;
begin
  ceRATE.Value := dmDB.GetCurrencyExchangeValue(cmbCURRENCY.EditValue, fFLG_ACNT);
     // transform suma
  if (ceSUMA.Value > 0) then
  begin
    if dmDB.TransformCurrency1(ceSUMA.Value, fLastCurrencyID, cmbCURRENCY.EditValue, fFLG_ACNT, tmpSuma, tmpRate, False, False) then
      ceSUMA.Value := tmpSuma;
    ceRATE.Value := tmpRate;
  end;

  fLastCurrencyID := cmbCURRENCY.EditValue;
end;

procedure TfrmMoneyIncomeDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmDB.IBCQueryCurrency.Active := False;
end;

function TfrmMoneyIncomeDlg.getCurrencyID: integer;
begin
  Result := cmbCURRENCY.EditValue;
end;

function TfrmMoneyIncomeDlg.getFLG_ACNT: integer;
begin
  Result := Ord(fFLG_ACNT);
end;

function TfrmMoneyIncomeDlg.getRate: Double;
begin
  Result := ceRATE.Value;
end;

function TfrmMoneyIncomeDlg.getSUMA: Currency;
begin
  Result := ceSUMA.Value;
end;

procedure TfrmMoneyIncomeDlg.BindingDataSource;
begin
  inherited;

  fTargetDocTypeID := -1;
  dmDB.IBCQueryCurrency.Active := True;
  fFLG_ACNT := fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1;
  fLastCurrencyID := fMasterDataSet.FieldByName('CURRENCYID').AsInteger;
  cmbCURRENCY.EditValue := fLastCurrencyID;
  ceSUMA.Value := fMasterDataSet.FieldByName('SUMA').AsCurrency;
  ceRATE.Value := fMasterDataSet.FieldByName('RATE').AsFloat;

  frameMoneyCounter.OnTotalSumChanged := WhenBanknotesCounterSumaChanged;
end;

function TfrmMoneyIncomeDlg.IsFormDataPosted: Boolean;
var
  S: string;
begin
  if CheckParams then
  begin
    S := Format('Creaza %s in suma de '#13#10'%f %s?', [dtDialogTitle.Title, ceSUMA.Value, cmbCURRENCY.Text]); // dmDB.IBCQueryCurrency.FieldByName('SHORTNAME').AsString
    if ShowAskDialog(dtDialogTitle.Title, S) = mrYes then
      Result := True
    else
      Result := False;
  end
  else
    Result := False;
end;

procedure TfrmMoneyIncomeDlg.Prepare;
begin
  frameMoneyCounter.cxGridBanknotesTableCol2.Focused := True;
  IBCQueryUsers.Open;
  lcbUsers.EditValue := 409; // Papana vasile
//  codesite.Send('TargetDocTypeID=',TargetDocTypeID);

  if TargetDocTypeID=117 then // dispozitie de plata
    dtDialogTitle.Color := $008080FF;

     // aratam datoriile clientului la moment
     // exceptie, daca clientul este angajat si n-are drepturi
  if dmDB.CheckIfCustomerIsEmployer(fMasterDataSet.FieldByName('CT').AsInteger) or not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Клиенты_Текущие_долги_контрагента) then
  begin
//    lbCustomerDebts.Visible := False;
//    lbDebtsCash.Visible := False;
      lbDatorii.Visible := false;
      lbGestiune.Visible := False;
      ceDatoriiGestiune.Visible := False;

      lbContabilitate.Visible := False;
      ceDatoriiContabile.Visible := False;
//    Label5.Visible := False;
//    lbDebtsTransfer.Visible := False;
//    ceSUMA_TRANSFER.Visible := False;
//    Label6.Visible := False;
  end
  else
  begin
    ReadClientDebts;
  end;
end;

procedure TfrmMoneyIncomeDlg.ReadClientDebts;
var
  Query: TIBCQuery;
  SumaUpr, SumaBuh: Currency;
  Suma_Cash_CurrID, Suma_Transfer_CurrID, Doc_CurrID: integer;
  tmpRate: Double;
begin
  SumaUpr := 0;
  Suma_Cash_CurrID := 840; // $$
  SumaBuh := 0;
  Suma_Transfer_CurrID := 498; // LEI
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT SUM(SUMA_CASH) suma_upr, SUM(SUMA_TRANSFER) suma_buh FROM SP_CALC_DEBTS_BY_DT_V2(:CustomerID, CURRENT_DATE)';
    Query.ParamByName('CustomerID').AsInteger := fMasterDataSet.FieldByName('CT').AsInteger;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      SumaUpr := Query.FieldByName('suma_upr').AsCurrency;
      SumaBuh := Query.FieldByName('suma_buh').AsCurrency;
      ceDatoriiGestiune.Value := SumaUpr;
      ceDatoriiContabile.Value := SumaBuh;
    end;
    Query.Close;
  finally
    Query.Free;
  end;

//  ceSUMA_CASH.Value := Suma_Cash;
//  ceSUMA_TRANSFER.Value := Suma_Transfer;

  if fTargetDocTypeID = cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_ПКО then // Dispozitie de incasare
  begin
    Doc_CurrID := fMasterDataSet.FieldByName('CURRENCYID').AsInteger;

    if (fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1) then
    begin
               // Buhg, Suma_Transfer (LEI)
               // transformam la valuta documentului
      if SumaBuh > 0 then
      begin
        if dmDB.TransformCurrency2(fMasterDataSet.FieldByName('DOCID').AsInteger, SumaBuh, Suma_Transfer_CurrID, Doc_CurrID, True, SumaBuh, tmpRate, True, False) then
        begin
          ceSUMA.Value := fMasterDataSet.FieldByName('SUMA').AsCurrency + SumaBuh;
//          lbDebtsTransfer.Font.Color := clMaroon;
        end;
      end;
    end
    else
    begin
      // Suma_Cash ($$)
      if SumaUpr > 0 then
      begin
        if dmDB.TransformCurrency2(fMasterDataSet.FieldByName('DOCID').AsInteger, SumaBuh, Suma_Cash_CurrID, Doc_CurrID, True, SumaBuh, tmpRate, True, False) then
        begin
          ceSUMA.Value := fMasterDataSet.FieldByName('SUMA').AsCurrency + SumaBuh;
//          lbDebtsCash.Font.Color := clMaroon;
        end;
      end;
    end;
  end;
end;

procedure TfrmMoneyIncomeDlg.SetAllowChangeCurrency(const Value: Boolean);
begin
  cmbCURRENCY.Enabled := Value;
end;

procedure TfrmMoneyIncomeDlg.SetAllowChangeCurrencyRate(const Value: Boolean);
begin
  ceRATE.Enabled := Value;
end;

procedure TfrmMoneyIncomeDlg.SetCustomTitle(const ACaption, ADescription: string);
begin
  Caption := ACaption;
  dtDialogTitle.Title := ACaption;
  dtDialogTitle.Text := dtDialogTitle.Text + ' ' + ADescription;
end;

procedure TfrmMoneyIncomeDlg.SetShowBanknotesCounter(const Value: Boolean);
begin
  if Value then
    ClientWidth := 611
  else
    ClientWidth := 285;
end;

procedure TfrmMoneyIncomeDlg.SetShowModIncasare(const Value: boolean);
begin
    FShowModIncasare := Value;
    pnIncasareDetail.Visible := Value;

end;

procedure TfrmMoneyIncomeDlg.WhenBanknotesCounterSumaChanged(Sender: TObject);
begin
  ceSUMA.Value := frameMoneyCounter.TotalSum;
end;

end.

