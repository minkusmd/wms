unit SWNMiaPaymentsDialogUnit;

(* ============================================================================
  MIA Victoriabank in WMS - interfata (datele: SWNMiaPaymentsUnit).

    - AddMiaColumn          : coloana "Plata MIA" in lista comenzilor web;
    - AddMiaButton          : butonul "Plata MIA..." in meniul contextual;
    - ShowMiaPaymentDialog  : starea platii unei comenzi, linkul de plata
                              (copiere / SMS) si cererea de rambursare.

  Coloana NU vine din interogarea comuna a documentelor (dmDB.IBCQueryDocs):
  starile se citesc separat, o data pe minut, si se arata dupa DOCID. Asa lista
  documentelor nu depinde de tabelele MIA - cit timp scriptul
  DB Model\mia_vb_payments.sql nu e rulat, coloana si butonul pur si simplu lipsesc.

  Fereastra e construita in cod (fara .dfm).
  ============================================================================ *)

interface

uses
  System.Classes, cxGridDBTableView, dxBar;

{ Coloana "Plata MIA" (dupa cimpul DOCID al grilei). Idempotent; la apelurile
  urmatoare doar reincarca starile. }
procedure AddMiaColumn(AView: TcxGridDBTableView);

{ Butonul "Plata MIA..." in APopup. Idempotent. }
procedure AddMiaButton(AManager: TdxBarManager; APopup: TdxBarPopupMenu; const AOnClick: TNotifyEvent);

{ ACanChange = utilizatorul poate crea linkuri, trimite SMS si cere rambursarea. }
procedure ShowMiaPaymentDialog(AOwner: TComponent; const ADocID: Integer; const ACanChange: Boolean);

{ Garda la stergerea unei comenzi web: daca are o plata MIA neachitata (New),
  ceruta in ultimele 24 de ore, cere confirmare explicita si o nota cu rezultatul
  apelului catre client. False = nu se sterge. ANote = textul de pastrat in deal
  (gol cind comanda nu are o astfel de plata). }
function ConfirmDeleteUnpaidMiaOrder(AOwner: TComponent; const ADocID: Integer; out ANote: string): Boolean;

implementation

uses
  System.SysUtils, System.Variants, System.UITypes, System.Generics.Collections, Winapi.Windows,
  Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Graphics, Vcl.Clipbrd,
  cxGridCustomTableView, cxGridTableView,
  DataModuleDB, SWNMiaPaymentsUnit;

const
  cColumnHelperName = 'MiaPayColumnHelper';
  cButtonName       = 'bbMiaPayment';
  cReloadMs         = 60000;

{ --- coloana ----------------------------------------------------------------- }

type
  TMiaGridColumn = class(TComponent)
  private
    FDocColumn: TcxGridDBColumn;
    FStates: TDictionary<Integer, string>;
    FLoadedAt: Cardinal;
    FLoaded: Boolean;
    procedure Reload;
  public
    destructor Destroy; override;
    procedure Invalidate;
    procedure ColumnGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  end;

destructor TMiaGridColumn.Destroy;
begin
  FStates.Free;
  inherited;
end;

procedure TMiaGridColumn.Invalidate;
begin
  FLoaded := False;
end;

procedure TMiaGridColumn.Reload;
var
  Fresh: TDictionary<Integer, string>;
begin
  // marcat incarcat inainte de interogare: o eroare nu se repeta la fiecare celula
  FLoaded := True;
  FLoadedAt := GetTickCount;
  try
    Fresh := LoadMiaStates(dmDB.IBCConnection);
    FStates.Free;
    FStates := Fresh;
  except
    // coloana e doar informativa: ramin starile vechi pina la urmatoarea incercare
  end;
end;

procedure TMiaGridColumn.ColumnGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  DocID: Variant;
  Status: string;
begin
  AText := '';
  if (ARecord = nil) or (FDocColumn = nil) then
    Exit;
  if not FLoaded or (GetTickCount - FLoadedAt > cReloadMs) then
    Reload;
  if FStates = nil then
    Exit;
  DocID := ARecord.Values[FDocColumn.Index];
  if VarIsNumeric(DocID) and FStates.TryGetValue(Integer(DocID), Status) then
    AText := MiaStatusText(Status);
end;

procedure AddMiaColumn(AView: TcxGridDBTableView);
var
  Helper: TMiaGridColumn;
  Col: TcxGridDBColumn;
  ColName: string;
begin
  if AView = nil then
    Exit;

  Helper := AView.FindComponent(cColumnHelperName) as TMiaGridColumn;
  if Helper <> nil then
  begin
    Helper.Invalidate;
    Exit;
  end;

  if not MiaPaymentsAvailable(dmDB.IBCConnection) or (AView.GetColumnByFieldName('DOCID') = nil) then
    Exit;

  Helper := TMiaGridColumn.Create(AView);
  Helper.Name := cColumnHelperName;
  Helper.FDocColumn := AView.GetColumnByFieldName('DOCID');

  AView.BeginUpdate;
  try
    Col := AView.CreateColumn;
    ColName := AView.Name + '_colMIA_PAY';
    if AView.Owner.FindComponent(ColName) = nil then
      Col.Name := ColName;
    Col.Caption := 'Plata MIA';
    Col.Width := 110;
    Col.Options.Editing := False;
    Col.Options.Filtering := False;
    Col.Options.Sorting := False;
    Col.Options.Grouping := False;
    Col.OnGetDisplayText := Helper.ColumnGetDisplayText;
  finally
    AView.EndUpdate;
  end;
end;

{ --- butonul ----------------------------------------------------------------- }

procedure AddMiaButton(AManager: TdxBarManager; APopup: TdxBarPopupMenu; const AOnClick: TNotifyEvent);
var
  Button: TdxBarButton;
begin
  if (AManager = nil) or (APopup = nil) or (AManager.FindComponent(cButtonName) <> nil) then
    Exit;
  if not MiaPaymentsAvailable(dmDB.IBCConnection) then
    Exit;

  Button := AManager.AddButton;
  Button.Name := cButtonName;
  Button.Caption := 'Plata MIA...';
  Button.Hint := 'Starea platii MIA, linkul de plata si rambursarea';
  Button.OnClick := AOnClick;
  APopup.ItemLinks.Add.Item := Button;
end;

{ --- fereastra --------------------------------------------------------------- }

type
  TMiaPaymentDialog = class(TForm)
  private
    FDocID: Integer;
    FCanChange: Boolean;
    FPayment: TMiaOrderPayment;
    FRowTop: Integer;
    lblState, lblAmount, lblPaid, lblPaidAt, lblTx, lblPayer, lblSource, lblHint: TLabel;
    edLink: TEdit;
    btnCopy, btnLink, btnSms, btnRefund, btnRefresh, btnClose: TButton;
    function S(const AValue: Integer): Integer;
    function AddRow(const ACaption: string): TLabel;
    function AddButton(const ACaption: string; const ALeft, AWidth: Integer; const AOnClick: TNotifyEvent): TButton;
    procedure BuildControls;
    procedure LoadPayment;
    procedure UpdateView;
    procedure CopyClick(Sender: TObject);
    procedure LinkClick(Sender: TObject);
    procedure SmsClick(Sender: TObject);
    procedure RefundClick(Sender: TObject);
    procedure RefreshClick(Sender: TObject);
  public
    constructor CreateDialog(AOwner: TComponent; const ADocID: Integer; const ACanChange: Boolean);
  end;

constructor TMiaPaymentDialog.CreateDialog(AOwner: TComponent; const ADocID: Integer; const ACanChange: Boolean);
begin
  inherited CreateNew(AOwner);
  FDocID := ADocID;
  FCanChange := ACanChange;
  BorderStyle := bsDialog;
  BorderIcons := [biSystemMenu];
  Position := poOwnerFormCenter;
  Caption := 'Plata MIA - comanda nr. ' + IntToStr(ADocID);
  ClientWidth := S(600);
  BuildControls;
  LoadPayment;
end;

function TMiaPaymentDialog.S(const AValue: Integer): Integer;
begin
  Result := MulDiv(AValue, CurrentPPI, 96);
end;

// Un rind "eticheta: valoare"; intoarce eticheta valorii.
function TMiaPaymentDialog.AddRow(const ACaption: string): TLabel;
var
  Cap: TLabel;
begin
  Cap := TLabel.Create(Self);
  Cap.Parent := Self;
  Cap.SetBounds(S(16), FRowTop, S(120), S(17));
  Cap.Caption := ACaption;

  Result := TLabel.Create(Self);
  Result.Parent := Self;
  Result.AutoSize := False;
  Result.SetBounds(S(140), FRowTop, ClientWidth - S(156), S(17));
  Result.Font.Style := [fsBold];
  Result.ShowAccelChar := False;

  Inc(FRowTop, S(24));
end;

function TMiaPaymentDialog.AddButton(const ACaption: string; const ALeft, AWidth: Integer;
  const AOnClick: TNotifyEvent): TButton;
begin
  Result := TButton.Create(Self);
  Result.Parent := Self;
  Result.SetBounds(ALeft, FRowTop, AWidth, S(27));
  Result.Caption := ACaption;
  Result.OnClick := AOnClick;
end;

procedure TMiaPaymentDialog.BuildControls;
var
  Cap: TLabel;
begin
  FRowTop := S(16);
  lblState := AddRow('Starea platii:');
  lblAmount := AddRow('Suma de plata:');
  lblPaid := AddRow('Suma platita:');
  lblPaidAt := AddRow('Platit la:');
  lblTx := AddRow('Tranzactia:');
  lblPayer := AddRow('Platitor:');
  lblSource := AddRow('Cerere din:');

  Inc(FRowTop, S(6));
  Cap := TLabel.Create(Self);
  Cap.Parent := Self;
  Cap.SetBounds(S(16), FRowTop + S(4), S(120), S(17));
  Cap.Caption := 'Link de plata:';

  edLink := TEdit.Create(Self);
  edLink.Parent := Self;
  edLink.SetBounds(S(140), FRowTop, ClientWidth - S(156) - S(88), S(23));
  edLink.ReadOnly := True;
  edLink.ParentColor := True;
  btnCopy := AddButton('Copiaza', ClientWidth - S(16) - S(80), S(80), CopyClick);
  btnCopy.Height := S(23);
  Inc(FRowTop, S(34));

  lblHint := TLabel.Create(Self);
  lblHint.Parent := Self;
  lblHint.AutoSize := False;
  lblHint.WordWrap := True;
  lblHint.ShowAccelChar := False;
  lblHint.SetBounds(S(16), FRowTop, ClientWidth - S(32), S(52));
  lblHint.Font.Color := clGrayText;
  Inc(FRowTop, S(60));

  btnLink := AddButton('Creeaza link', S(16), S(104), LinkClick);
  btnSms := AddButton('Trimite SMS', S(126), S(104), SmsClick);
  btnRefund := AddButton('Rambursare', S(236), S(104), RefundClick);
  btnRefresh := AddButton('Actualizeaza', S(346), S(104), RefreshClick);
  btnClose := AddButton('Inchide', ClientWidth - S(16) - S(104), S(104), nil);
  btnClose.ModalResult := mrCancel;
  btnClose.Cancel := True;
  btnClose.Default := True;

  ClientHeight := FRowTop + S(27) + S(16);
end;

procedure TMiaPaymentDialog.LoadPayment;
begin
  try
    FPayment := LoadMiaOrderPayment(dmDB.IBCConnection, FDocID);
  except
    on E: Exception do
    begin
      FPayment := Default(TMiaOrderPayment);
      MessageDlg('Starea platii nu a putut fi citita:' + #13#10 + E.Message, mtError, [mbOK], 0);
    end;
  end;
  UpdateView;
end;

procedure TMiaPaymentDialog.UpdateView;
var
  HintText: string;
begin
  if not FPayment.Found then
  begin
    lblState.Caption := 'Comanda nu are plata MIA';
    lblAmount.Caption := '-';
    lblSource.Caption := '-';
  end
  else
  begin
    lblState.Caption := FPayment.StatusText;
    lblAmount.Caption := FormatFloat('#,##0.00', FPayment.Amount) + ' lei';
    if FPayment.Source = 'operator' then
      lblSource.Caption := 'link creat de operator, ' + FormatDateTime('dd.mm.yyyy hh:nn', FPayment.CreatedAt)
    else
      lblSource.Caption := 'finalizarea comenzii pe site, ' + FormatDateTime('dd.mm.yyyy hh:nn', FPayment.CreatedAt);
  end;

  if FPayment.Found and (FPayment.TxID <> '') then
  begin
    lblPaid.Caption := FormatFloat('#,##0.00', FPayment.PaidAmount) + ' lei';
    lblPaidAt.Caption := FormatDateTime('dd.mm.yyyy hh:nn', FPayment.PaidAt);
    lblTx.Caption := FPayment.TxID;
    if FPayment.PayerName <> '' then
      lblPayer.Caption := FPayment.PayerName
    else
      lblPayer.Caption := '(apare dupa verificarea zilnica cu banca)';
  end
  else
  begin
    lblPaid.Caption := '-';
    lblPaidAt.Caption := '-';
    lblTx.Caption := '-';
    lblPayer.Caption := '-';
  end;

  // culoarea starii: verde = bani primiti, rosu = cere atentie
  if FPayment.Found and (FPayment.Status = cMiaPaid) then
    lblState.Font.Color := clGreen
  else if FPayment.Found and ((FPayment.Status = cMiaMismatch) or (FPayment.Status = cMiaRefundFailed)) then
    lblState.Font.Color := clRed
  else
    lblState.Font.Color := clWindowText;

  if FPayment.HasOpenLink then
    edLink.Text := MiaPayUrl(dmDB.IBCConnection, FPayment.Token)
  else
    edLink.Text := '';

  btnCopy.Enabled := edLink.Text <> '';
  btnSms.Enabled := FCanChange and (edLink.Text <> '');
  // link nou: comanda fara cerere, sau cu una inchisa / rambursata
  btnLink.Enabled := FCanChange and (not FPayment.Found or FPayment.HasOpenLink or
    (FPayment.Status = cMiaCancelled) or (FPayment.Status = cMiaRefunded));
  btnRefund.Enabled := FCanChange and FPayment.CanRefund;

  if not FPayment.Found then
    HintText := 'Creati un link de plata si trimiteti-l clientului. Codul QR apare cind clientul deschide linkul.'
  else if FPayment.Status = cMiaNew then
    HintText := 'Clientul nu a platit inca. Linkul ramine valabil; codul QR se reinnoieste singur la fiecare deschidere. ' +
      'Daca suma comenzii s-a schimbat, "Creeaza link" face un link nou, pe suma noua.'
  else if FPayment.Status = cMiaPaid then
    HintText := 'Banii au ajuns in contul Victoriabank. Bonul fiscal il emite serviciul (ECC), iar incasarea apare la ' +
      'inregistrarea extrasului bancar.'
  else if FPayment.Status = cMiaMismatch then
    HintText := 'Banca a confirmat alta suma decit cea ceruta. Comanda NU este marcata platita: verificati si, daca e ' +
      'cazul, rambursati.'
  else if FPayment.Status = cMiaRefundRequested then
    HintText := 'Rambursarea a fost ceruta. Site-ul o trimite bancii in citeva minute; apasati "Actualizeaza".'
  else if FPayment.Status = cMiaRefundFailed then
    HintText := 'Banca a refuzat rambursarea (vezi comentariile comenzii). Puteti cere din nou sau verificati la banca.'
  else if FPayment.Status = cMiaRefunded then
    HintText := 'Plata a fost rambursata integral clientului.'
  else
    HintText := 'Clientul a renuntat la plata MIA sau cererea a fost inlocuita. Puteti crea un link nou.';
  lblHint.Caption := HintText;
end;

procedure TMiaPaymentDialog.CopyClick(Sender: TObject);
begin
  if edLink.Text <> '' then
    Clipboard.AsText := edLink.Text;
end;

procedure TMiaPaymentDialog.LinkClick(Sender: TObject);
var
  P: TMiaOrderPayment;
  Err: string;
begin
  if MiaCreateLink(dmDB.IBCConnection, FDocID, dmDB.CurrentUserID, P, Err) then
  begin
    FPayment := P;
    UpdateView;
    edLink.SetFocus;
    edLink.SelectAll;
  end
  else
  begin
    MessageDlg(Err, mtWarning, [mbOK], 0);
    LoadPayment;
  end;
end;

procedure TMiaPaymentDialog.SmsClick(Sender: TObject);
var
  Text, SentTo, Err: string;
begin
  if edLink.Text = '' then
    Exit;
  Text := MiaLinkSmsText(FDocID, edLink.Text);
  if MessageDlg('Trimit clientului SMS cu linkul de plata?' + #13#10 + #13#10 +
    StringReplace(Text, '~', #13#10, [rfReplaceAll]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if MiaSendLinkSms(dmDB.IBCConnection, FDocID, Text, '', SentTo, Err) then
    MessageDlg('SMS-ul a fost pus in coada pentru ' + SentTo + '.', mtInformation, [mbOK], 0)
  else
    MessageDlg(Err, mtWarning, [mbOK], 0);
end;

procedure TMiaPaymentDialog.RefundClick(Sender: TObject);
var
  Err: string;
begin
  if not FPayment.CanRefund then
    Exit;
  if MessageDlg(Format('Rambursati clientului %s lei (integral)?' + #13#10 + #13#10 +
    'Rambursarea nu poate fi anulata si se face o singura data. Banca nu accepta rambursari partiale.',
    [FormatFloat('#,##0.00', FPayment.PaidAmount)]), mtWarning, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if MiaRequestRefund(dmDB.IBCConnection, FPayment.PaymentID, dmDB.CurrentUserID, Err) then
    MessageDlg('Cererea de rambursare a fost inregistrata. Site-ul o trimite bancii in citeva minute; ' +
      'rezultatul apare aici si in comentariile comenzii.', mtInformation, [mbOK], 0)
  else
    MessageDlg(Err, mtWarning, [mbOK], 0);
  LoadPayment;
end;

procedure TMiaPaymentDialog.RefreshClick(Sender: TObject);
begin
  LoadPayment;
end;

procedure ShowMiaPaymentDialog(AOwner: TComponent; const ADocID: Integer; const ACanChange: Boolean);
var
  Dialog: TMiaPaymentDialog;
begin
  if ADocID <= 0 then
    Exit;
  if not MiaPaymentsAvailable(dmDB.IBCConnection) then
  begin
    MessageDlg('Platile MIA nu sint instalate in baza de date.' + #13#10 +
      'Rulati scriptul "DB Model\mia_vb_payments.sql".', mtInformation, [mbOK], 0);
    Exit;
  end;

  Dialog := TMiaPaymentDialog.CreateDialog(AOwner, ADocID, ACanChange);
  try
    Dialog.ShowModal;
  finally
    Dialog.Free;
  end;
end;

{ --- garda la stergerea comenzii --------------------------------------------- }

type
  TMiaDeleteGuardForm = class(TForm)
  private
    FMemo: TMemo;
    FOkButton: TButton;
    procedure MemoChange(Sender: TObject);
  public
    constructor CreateGuard(AOwner: TComponent; const ADocID: Integer; const APayment: TMiaOrderPayment);
    function Note: string;
  end;

const
  cMiaDeleteNoteMinLen = 10;

function Px(const AValue: Integer): Integer;
begin
  Result := MulDiv(AValue, Screen.PixelsPerInch, 96);
end;

constructor TMiaDeleteGuardForm.CreateGuard(AOwner: TComponent; const ADocID: Integer;
  const APayment: TMiaOrderPayment);
var
  lbl: TLabel;
  btn: TButton;
begin
  inherited CreateNew(AOwner);
  Caption := 'Stergere comanda cu plata MIA neachitata';
  BorderStyle := bsDialog;
  Position := poScreenCenter;
  ClientWidth := Px(560);
  ClientHeight := Px(330);

  lbl := TLabel.Create(Self);
  lbl.Parent := Self;
  lbl.AutoSize := False;
  lbl.WordWrap := True;
  lbl.SetBounds(Px(16), Px(12), ClientWidth - Px(32), Px(70));
  lbl.Caption := Format('Comanda #%d are o plata MIA neachitata: %s lei, ceruta la %s.' + sLineBreak +
    'Clientul trebuie sunat inainte de stergere (telefonul e in comanda): ' +
    'oferiti plata la primire sau in rate. Comanda nu se sterge fara rezultatul apelului.',
    [ADocID, FormatFloat('#,##0.00', APayment.Amount), FormatDateTime('dd.mm.yyyy hh:nn', APayment.CreatedAt)]);

  lbl := TLabel.Create(Self);
  lbl.Parent := Self;
  lbl.SetBounds(Px(16), Px(90), ClientWidth - Px(32), Px(17));
  lbl.Caption := Format('Nota (obligatorie, minim %d caractere): cu cine ati vorbit si ce a raspuns clientul',
    [cMiaDeleteNoteMinLen]);
  lbl.Font.Style := [fsBold];

  FMemo := TMemo.Create(Self);
  FMemo.Parent := Self;
  FMemo.SetBounds(Px(16), Px(112), ClientWidth - Px(32), Px(160));
  FMemo.ScrollBars := ssVertical;
  FMemo.MaxLength := 500;
  FMemo.OnChange := MemoChange;

  FOkButton := TButton.Create(Self);
  FOkButton.Parent := Self;
  FOkButton.SetBounds(ClientWidth - Px(16) - Px(260), ClientHeight - Px(16) - Px(27), Px(150), Px(27));
  FOkButton.Caption := 'Sterge comanda';
  FOkButton.ModalResult := mrOk;
  FOkButton.Enabled := False;

  btn := TButton.Create(Self);
  btn.Parent := Self;
  btn.SetBounds(ClientWidth - Px(16) - Px(100), ClientHeight - Px(16) - Px(27), Px(100), Px(27));
  btn.Caption := 'Renunta';
  btn.ModalResult := mrCancel;
  btn.Cancel := True;
  btn.Default := True;

  ActiveControl := FMemo;
end;

procedure TMiaDeleteGuardForm.MemoChange(Sender: TObject);
begin
  FOkButton.Enabled := Length(Note) >= cMiaDeleteNoteMinLen;
end;

function TMiaDeleteGuardForm.Note: string;
begin
  Result := Trim(StringReplace(FMemo.Text, sLineBreak, ' ', [rfReplaceAll]));
end;

function ConfirmDeleteUnpaidMiaOrder(AOwner: TComponent; const ADocID: Integer; out ANote: string): Boolean;
var
  payment: TMiaOrderPayment;
  frm: TMiaDeleteGuardForm;
begin
  ANote := '';
  Result := True;
  if (ADocID <= 0) or not MiaPaymentsAvailable(dmDB.IBCConnection) then
    Exit;
  payment := LoadMiaOrderPayment(dmDB.IBCConnection, ADocID);
  if not payment.Found or (payment.Status <> cMiaNew) or (payment.CreatedAt < Now - 1) then
    Exit;
  frm := TMiaDeleteGuardForm.CreateGuard(AOwner, ADocID, payment);
  try
    Result := frm.ShowModal = mrOk;
    if Result then
      ANote := Format('Stearsa cu plata MIA neachitata (%s lei din %s): %s',
        [FormatFloat('#,##0.00', payment.Amount), FormatDateTime('dd.mm.yyyy hh:nn', payment.CreatedAt), frm.Note]);
  finally
    frm.Free;
  end;
end;

end.
