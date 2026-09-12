unit frmCurrencyExchangeDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, cxDBLookupComboBox, cxTextEdit, DB, DBAccess,
  IBC, StdCtrls,
  ExtCtrls, DialogTitle,
  cxCurrencyEdit, cxMemo, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit;

type
  TfrmCurrencyExchangeDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    Label1: TLabel;
    edUserName: TcxTextEdit;
    Label2: TLabel;
    edFirmaName: TcxTextEdit;
    cmbInitCurrency: TcxLookupComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cmbEndCurrency: TcxLookupComboBox;
    Label6: TLabel;
    lbInitCurrName: TLabel;
    lbEndCurrName: TLabel;
    edInitRate: TcxCurrencyEdit;
    edEndRate: TcxCurrencyEdit;
    edInitSuma: TcxCurrencyEdit;
    edEndSuma: TcxCurrencyEdit;
    Label7: TLabel;
    mmComments: TcxMemo;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbInitCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure cmbEndCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure edInitRatePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edEndRatePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edInitRatePropertiesEditValueChanged(Sender: TObject);
    procedure edEndRatePropertiesEditValueChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edInitSumaPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edEndSumaPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    fInitCurrencyID, fEndCurrencyID: integer;
    fInitMinRate, fEndMinRate: double;
    fInitRate, fEndRate: double;
    fInternalChange: Boolean;
    FDefaultInitCurrencyID: integer;
    FEnabledSuma: Boolean;
    FEnabledEndCurrencyID: Boolean;
    FEnabledInitCurrencyID: Boolean;
    FDefaultEndCurrencyID: integer;
    function CheckParams: Boolean;
    function CheckTargetCredentials(const UserID: integer): Boolean;
    function DoCurrencyExchangeDB: Boolean;
    procedure GetCurrencyExchangeValue(const CurrencyID: integer; var Rate: Double; var ShortName: string);
    procedure CalcInitSuma;
    procedure CalcEndSuma;
    procedure SetDefaultEndCurrencyID(const Value: integer);
    procedure SetDefaultInitCurrencyID(const Value: integer);
    procedure SetEnabledEndCurrencyID(const Value: Boolean);
    procedure SetEnabledInitCurrencyID(const Value: Boolean);
    procedure SetEnabledSuma(const Value: Boolean);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property DefaultInitCurrencyID: integer read FDefaultInitCurrencyID write SetDefaultInitCurrencyID;
    property DefaultEndCurrencyID: integer read FDefaultEndCurrencyID write SetDefaultEndCurrencyID;
    property EnabledInitCurrencyID: Boolean read FEnabledInitCurrencyID write SetEnabledInitCurrencyID;
    property EnabledEndCurrencyID: Boolean read FEnabledEndCurrencyID write SetEnabledEndCurrencyID;
    property EnabledSuma: Boolean read FEnabledSuma write SetEnabledSuma;
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNDBErrors, frmPasswordDlg,
  SWNSecurity;

{$R *.dfm}

{ TForm1 }

procedure TfrmCurrencyExchangeDlg.CalcEndSuma;
var
  Suma: Double;
  S: string;
begin
  fInternalChange := True;
  Suma := edInitSuma.EditValue * edInitRate.EditValue / edEndRate.EditValue;
  S := FloatToStrF(Suma, ffFixed, 18, 2);
  edEndSuma.EditValue := StrToCurr(S);
  fInternalChange := False;
end;

procedure TfrmCurrencyExchangeDlg.CalcInitSuma;
var
  Suma: Double;
  S: string;
begin
  fInternalChange := True;
  Suma := edEndSuma.EditValue * edEndRate.EditValue / edInitRate.EditValue;
  S := FloatToStrF(Suma, ffFixed, 18, 2);
  edInitSuma.EditValue := StrToCurr(S);
  fInternalChange := False;
end;

function TfrmCurrencyExchangeDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if (cmbInitCurrency.EditValue = 0) then
    AddErrorToStr(ErrorStr, 'Indicati tipul initial de valuta!');
  if (cmbEndCurrency.EditValue = 0) then
    AddErrorToStr(ErrorStr, 'Indicati tipul final de valuta!');

  if (cmbEndCurrency.EditValue = cmbInitCurrency.EditValue) then
    AddErrorToStr(ErrorStr, 'Sunt necesare tipuri de valuta diferite!');

  if (edInitSuma.EditValue = 0) or (edEndSuma.EditValue = 0) then
    AddErrorToStr(ErrorStr, 'Indicati suma de bani!');

  if (ErrorStr = '') then
    Result := True
  else
    ShowErrorDialog('Eroare date', ErrorStr);
end;

function TfrmCurrencyExchangeDlg.CheckTargetCredentials(const UserID: integer): Boolean;
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

procedure TfrmCurrencyExchangeDlg.cmbEndCurrencyPropertiesEditValueChanged(Sender: TObject);
var
  S: string;
begin
     // End Currency changed
  fEndCurrencyID := cmbEndCurrency.EditValue;
  GetCurrencyExchangeValue(fEndCurrencyID, fEndMinRate, S);
  edEndRate.EditValue := fEndMinRate;
  fEndRate := fEndMinRate;
  lbEndCurrName.Caption := S;
end;

procedure TfrmCurrencyExchangeDlg.cmbInitCurrencyPropertiesEditValueChanged(Sender: TObject);
var
  S: string;
begin
     // Init Currency changed
  fInitCurrencyID := cmbInitCurrency.EditValue;
  GetCurrencyExchangeValue(fInitCurrencyID, fInitMinRate, S);
  edInitRate.EditValue := fInitMinRate;
  fInitRate := fInitMinRate;
  lbInitCurrName.Caption := S;
end;

function TfrmCurrencyExchangeDlg.DoCurrencyExchangeDB: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'INSERT INTO VW_TDB_CASH_JURNAL (FLG_DT_CONFIRMED,FLG_CT_CONFIRMED, DT,USER_DT,SUMA_DT,CURRENCYID_DT,RATE_DT, CT,USER_CT,SUMA_CT,CURRENCYID_CT,RATE_CT,COMMENT)' + ' VALUES (:FLG_DT_CONFIRMED,:FLG_CT_CONFIRMED, :DT,:USERID,:SUMA_DT,:CURRENCYID_DT,:RATE_DT, :DT,:USERID,:SUMA_CT,:CURRENCYID_CT,:RATE_CT,:COMMENT)';
      Query.ParamByName('FLG_DT_CONFIRMED').AsInteger := 1;
      Query.ParamByName('FLG_CT_CONFIRMED').AsInteger := 1;

      Query.ParamByName('USERID').AsInteger := dmDB.CurrentUserID;
      Query.ParamByName('DT').AsInteger := dmDB.CurrentFirma;

      Query.ParamByName('SUMA_DT').AsCurrency := edInitSuma.EditValue;
      Query.ParamByName('CURRENCYID_DT').AsInteger := cmbInitCurrency.EditValue;
      Query.ParamByName('RATE_DT').AsFloat := edInitRate.EditValue;

      Query.ParamByName('SUMA_CT').AsCurrency := edEndSuma.EditValue;
      Query.ParamByName('CURRENCYID_CT').AsInteger := cmbEndCurrency.EditValue;
      Query.ParamByName('RATE_CT').AsFloat := edEndRate.EditValue;

      Query.ParamByName('COMMENT').AsString := Trim(mmComments.Text);

      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmCurrencyExchangeDlg.edEndRatePropertiesEditValueChanged(Sender: TObject);
begin
  if not fInternalChange then
    CalcInitSuma;
end;

procedure TfrmCurrencyExchangeDlg.edEndRatePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if VarIsNull(DisplayValue) or (DisplayValue = '') or (DisplayValue <= 0) then
    DisplayValue := fEndMinRate;
end;

procedure TfrmCurrencyExchangeDlg.edEndSumaPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if VarIsNull(DisplayValue) or (DisplayValue = '') or (DisplayValue < 0) then
    DisplayValue := 0;
end;

procedure TfrmCurrencyExchangeDlg.edInitRatePropertiesEditValueChanged(Sender: TObject);
begin
  if not fInternalChange then
    CalcEndSuma;
end;

procedure TfrmCurrencyExchangeDlg.edInitRatePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if VarIsNull(DisplayValue) or (DisplayValue = '') or (DisplayValue <= 0) then
    DisplayValue := fInitMinRate;
end;

procedure TfrmCurrencyExchangeDlg.edInitSumaPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if VarIsNull(DisplayValue) or (DisplayValue = '') or (DisplayValue < 0) then
    DisplayValue := 0;
end;

procedure TfrmCurrencyExchangeDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmDB.IBCQueryCurrency.Active := False;
end;

procedure TfrmCurrencyExchangeDlg.FormCreate(Sender: TObject);
begin
  fInternalChange := False;
  FDefaultInitCurrencyID := -1;
  FDefaultEndCurrencyID := -1;
  FEnabledSuma := True;
  FEnabledEndCurrencyID := True;
  FEnabledInitCurrencyID := True;
end;

procedure TfrmCurrencyExchangeDlg.GetCurrencyExchangeValue(const CurrencyID: integer; var Rate: Double; var ShortName: string);
begin
  if dmDB.IBCQueryCurrency.Active and dmDB.IBCQueryCurrency.Locate('CURRENCYID', CurrencyID, []) then
  begin
    Rate := dmDB.IBCQueryCurrency.FieldByName('EXCHANGE_RATE').AsFloat;
    ShortName := dmDB.IBCQueryCurrency.FieldByName('SHORTNAME').AsString;
  end
  else
  begin
    Rate := 1;
    ShortName := '?';
  end;
end;

function TfrmCurrencyExchangeDlg.IsFormDataPosted: Boolean;
var
  S: string;
begin
  Result := False;

  if CheckParams then
  begin
    S := Format('Doriti sa schimbati %f %s in %f %s ?', [Currency(edInitSuma.EditValue), lbInitCurrName.Caption, Currency(edEndSuma.EditValue), lbEndCurrName.Caption]);

    if ShowAskDialog('Schimb valutar', S + #13#10 + #13#10 + 'Pentru continuarea operatiei va fi necesara parola dumneavoastra.') = mrYes then
    begin
      if CheckTargetCredentials(dmDB.CurrentUserID) then
      begin
        if DoCurrencyExchangeDB then
          Result := True;
      end
      else
        ShowErrorDialog('Parola incorecta', 'Parola dumneavoastra este incorecta!');
    end;
  end;
end;

procedure TfrmCurrencyExchangeDlg.Prepare;
begin
  try
    edUserName.Text := dmDB.CurrentUserFullName;
    edFirmaName.Text := dmDB.CurrentFirmaName;

    dmDB.IBCQueryCurrency.Active := True;

    if FDefaultInitCurrencyID <> -1 then
      cmbInitCurrency.EditValue := FDefaultInitCurrencyID
    else
      cmbInitCurrency.EditValue := 498; // MDL by default
    if DefaultEndCurrencyID <> -1 then
      cmbEndCurrency.EditValue := DefaultEndCurrencyID
    else
      cmbEndCurrency.EditValue := 840; // USD by default
    cmbInitCurrency.Enabled := FEnabledInitCurrencyID;
    cmbEndCurrency.Enabled := FEnabledEndCurrencyID;
    edInitRate.Enabled := FEnabledSuma;
    edInitSuma.Enabled := FEnabledSuma;
    edEndRate.Enabled := FEnabledSuma;
    edEndSuma.Enabled := FEnabledSuma;
  except
    dmDB.IBCQueryCurrency.Active := False;
    raise;
  end;
end;

procedure TfrmCurrencyExchangeDlg.SetDefaultEndCurrencyID(const Value: integer);
begin
  FDefaultEndCurrencyID := Value;
end;

procedure TfrmCurrencyExchangeDlg.SetDefaultInitCurrencyID(const Value: integer);
begin
  FDefaultInitCurrencyID := Value;
end;

procedure TfrmCurrencyExchangeDlg.SetEnabledEndCurrencyID(const Value: Boolean);
begin
  FEnabledEndCurrencyID := Value;
end;

procedure TfrmCurrencyExchangeDlg.SetEnabledInitCurrencyID(const Value: Boolean);
begin
  FEnabledInitCurrencyID := Value;
end;

procedure TfrmCurrencyExchangeDlg.SetEnabledSuma(const Value: Boolean);
begin
  FEnabledSuma := Value;
end;

procedure TfrmCurrencyExchangeDlg.WhenCancelForm;
begin
  inherited;

end;

end.

