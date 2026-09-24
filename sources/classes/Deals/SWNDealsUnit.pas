unit SWNDealsUnit;

(* ============================================================================
  DEALS - TDB_DEALS / TDB_DEAL_DOCS / TS_DEAL_STATES.

  Legarea documentelor de deal-uri si recalcularea starilor se fac IN BAZA
  (triggerele TDB_DOCS_*_DEAL + SP_DEAL_ATTACH_DOC / SP_DEAL_RECALC_STATES, vezi
  DB Model\deals_integration.sql), pentru ca documentele apar si din site si din
  procedurile SP_CREATE_*. Unitul acesta e doar interfata din WMS:
    - ShowDealsBrowser      : lista deal-urilor (Utile > Deal-uri);
    - ShowDealOfDocument    : fisa deal-ului documentului curent; daca documentul
                              nu are deal, incearca atasarea automata, apoi
                              propune legarea manuala (plati fara lant);
    - ExecDealSQL           : apel de procedura in tranzactie proprie;
    - AttachDealToDialog    : randul "Deal" din dialogurile de modificare a
                              documentelor - starile deal-ului, pe tipul de
                              document, salvate la OK odata cu documentul.

  Totul e inactiv pana cand scriptul e rulat pe baza (DealsAvailable, verificat
  o singura data pe sesiune).
  ============================================================================ *)

interface

uses
  System.Classes, Vcl.Forms, Data.DB, cxGridDBTableView;

function DealsAvailable: Boolean;

{ DEAL_ID-ul documentului sau 0. }
function FindDealByDoc(const ADocID: Integer): Int64;

{ Executa un statement (EXECUTE PROCEDURE ... / UPDATE ...) in tranzactie proprie.
  AParams: perechi nume, valoare. False + mesaj la eroare. }
function ExecDealSQL(const ASQL: string; const AParams: array of Variant): Boolean;

{ Adauga in gridul de documente al unui frame coloanele DEAL_ID / DEAL_STATE
  (campuri calculate in dmDB.IBCQueryDocs). Idempotent. }
procedure AddDealColumns(AView: TcxGridDBTableView);

procedure ShowDealsBrowser(AOwner: TComponent);
{ incasarile de casa / banca si distribuirea lor pe deal-uri }
procedure ShowDealPayments(AOwner: TComponent);
procedure ShowDealCard(AOwner: TComponent; const ADealID: Int64);
procedure ShowDealOfDocument(AOwner: TComponent; const ADocID: Integer);

{ Axele de stare care se pot schimba din documentul de tipul dat, ex. 'PIPE,PAY'.
  '' = tipul nu are rand "Deal". }
function DealAxesForDocType(const ADocTypeID: Integer): string;

{ Adauga jos in dialogul de modificare a documentului randul "Deal": numarul
  deal-ului si cate o lista de stari pentru fiecare axa a tipului de document.
  Starile alese se salveaza la inchiderea dialogului cu OK, dupa document.
  Sub stari, daca deal-ul le are: datele comenzii web (client, telefon, metoda de
  plata, adresa, nota, UTM) - doar pentru citire (TDB_DEALS, scrise de site).
  ADataSet = datasetul editat de dialog (dmDB.IBCQueryDocs). Nu arunca exceptii. }
procedure AttachDealToDialog(AForm: TForm; ADataSet: TDataSet);

implementation

uses
  System.SysUtils, System.Variants, System.UITypes, System.Math, Winapi.Windows, Winapi.Messages,
  Vcl.Dialogs, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Graphics,
  DBAccess, IBC, MemDS, DataModuleDB, SWNDBErrors,
  frmDealCardDialog, frmDealsBrowserDialog, frmDealPaymentsDialog;

var
  { -1 = neverificat, 0 = schema lipseste, 1 = schema exista }
  GAvailability: Integer = -1;

function DealsAvailable: Boolean;
var
  q: TIBCQuery;
begin
  if GAvailability < 0 then
  begin
    GAvailability := 0;
    q := TIBCQuery.Create(nil);
    try
      q.Connection := dmDB.IBCConnection;
      q.SQL.Text :=
        'SELECT ' +
        '  (SELECT COUNT(*) FROM RDB$PROCEDURES ' +
        '    WHERE RDB$PROCEDURE_NAME = ''SP_DEAL_ATTACH_DOC'') AS C_PROC, ' +
        '  (SELECT COUNT(*) FROM RDB$RELATIONS ' +
        '    WHERE RDB$RELATION_NAME = ''VW_DEALS_BROWSER'') AS C_VIEW ' +
        'FROM RDB$DATABASE';
      try
        q.Open;
        if (q.FieldByName('C_PROC').AsInteger > 0) and (q.FieldByName('C_VIEW').AsInteger > 0) then
          GAvailability := 1;
      except
        GAvailability := 0;
      end;
    finally
      q.Free;
    end;
  end;
  Result := GAvailability = 1;
end;

function CheckAvailable: Boolean;
begin
  Result := DealsAvailable;
  if not Result then
    MessageDlg('Modulul Deal-uri nu este instalat in baza de date.' + #13#10 +
      'Rulati scriptul "DB Model\deals_integration.sql".', mtInformation, [mbOK], 0);
end;

function FindDealByDoc(const ADocID: Integer): Int64;
var
  q: TIBCQuery;
begin
  Result := 0;
  if (ADocID <= 0) or not DealsAvailable then
    Exit;
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.SQL.Text := 'SELECT MIN(DEAL_ID) AS DEAL_ID FROM TDB_DEAL_DOCS WHERE DOCID = :docid';
    q.ParamByName('docid').AsInteger := ADocID;
    q.Open;
    if not q.FieldByName('DEAL_ID').IsNull then
      Result := q.FieldByName('DEAL_ID').AsLargeInt;
  finally
    q.Free;
  end;
end;

function ExecDealSQL(const ASQL: string; const AParams: array of Variant): Boolean;
var
  tr: TIBCTransaction;
  q: TIBCQuery;
  i: Integer;
begin
  Result := False;
  tr := TIBCTransaction.Create(nil);
  q := TIBCQuery.Create(nil);
  try
    tr.DefaultConnection := dmDB.IBCConnection;
    q.Connection := dmDB.IBCConnection;
    q.Transaction := tr;
    q.UpdateTransaction := tr;
    q.AutoCommit := False;
    try
      tr.StartTransaction;
      q.SQL.Text := ASQL;
      i := Low(AParams);
      while i < High(AParams) do
      begin
        if VarIsNull(AParams[i + 1]) or VarIsEmpty(AParams[i + 1]) then
        begin
          q.ParamByName(VarToStr(AParams[i])).DataType := ftFloat;
          q.ParamByName(VarToStr(AParams[i])).Clear;
        end
        else
          q.ParamByName(VarToStr(AParams[i])).Value := AParams[i + 1];
        Inc(i, 2);
      end;
      q.Execute;
      tr.Commit;
      Result := True;
    except
      on e: Exception do
      begin
        if tr.Active then
          tr.Rollback;
        if not ProcessSWNError(e) then
          MessageDlg('Operatia nu a reusit:' + #13#10 + e.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    q.Free;
    tr.Free;
  end;
end;

procedure AddDealColumns(AView: TcxGridDBTableView);

  procedure AddColumn(const AField, ACaption, AName: string; const AWidth: Integer);
  var
    col: TcxGridDBColumn;
  begin
    if AView.GetColumnByFieldName(AField) <> nil then
      Exit;
    col := AView.CreateColumn;
    if AView.Owner.FindComponent(AName) = nil then
      col.Name := AName;
    col.DataBinding.FieldName := AField;
    col.Caption := ACaption;
    col.Width := AWidth;
    col.Options.Editing := False;
  end;

begin
  if AView = nil then
    Exit;
  AView.BeginUpdate;
  try
    AddColumn('DEAL_ID', 'Deal', AView.Name + '_colDEAL_ID', 60);
    AddColumn('DEAL_STATE', 'Stare deal', AView.Name + '_colDEAL_STATE', 130);
  finally
    AView.EndUpdate;
  end;
end;

procedure ShowDealsBrowser(AOwner: TComponent);
var
  d: TfrmDealsBrowserDlg;
begin
  if not CheckAvailable then
    Exit;
  d := TfrmDealsBrowserDlg.Create(AOwner);
  try
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure ShowDealPayments(AOwner: TComponent);
var
  d: TfrmDealPaymentsDlg;
  q: TIBCQuery;
  ok: Boolean;
begin
  if not CheckAvailable then
    Exit;
  { view-ul a aparut intr-o versiune ulterioara a scriptului }
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.SQL.Text := 'SELECT COUNT(*) AS N FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = ''VW_DEAL_PAYMENTS''';
    q.Open;
    ok := q.FieldByName('N').AsInteger > 0;
  finally
    q.Free;
  end;
  if not ok then
  begin
    MessageDlg('Rulati din nou scriptul "DB Model\deals_integration.sql" (lipseste VW_DEAL_PAYMENTS).',
      mtInformation, [mbOK], 0);
    Exit;
  end;
  d := TfrmDealPaymentsDlg.Create(AOwner);
  try
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure ShowDealCard(AOwner: TComponent; const ADealID: Int64);
var
  d: TfrmDealCardDlg;
begin
  if (ADealID <= 0) or not CheckAvailable then
    Exit;
  d := TfrmDealCardDlg.Create(AOwner);
  try
    d.DealID := ADealID;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

{ clientul (CT) si suma documentului, pentru legarea manuala }
procedure ReadDocInfo(const ADocID: Integer; out ACustomerID: Integer; out ASuma: Double);
var
  q: TIBCQuery;
begin
  ACustomerID := 0;
  ASuma := 0;
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.SQL.Text := 'SELECT CT, SUMA * COALESCE(NULLIF(RATE, 0), 1) AS SUMA FROM TDB_DOCS WHERE DOCID = :docid';
    q.ParamByName('docid').AsInteger := ADocID;
    q.Open;
    if not q.IsEmpty then
    begin
      ACustomerID := q.FieldByName('CT').AsInteger;
      ASuma := q.FieldByName('SUMA').AsFloat;
    end;
  finally
    q.Free;
  end;
end;

procedure ShowDealOfDocument(AOwner: TComponent; const ADocID: Integer);
var
  dealID: Int64;
  browser: TfrmDealsBrowserDlg;
  customerID: Integer;
  suma, linkSum: Double;
  s: string;
  vLinkSum: Variant;
begin
  if not CheckAvailable then
    Exit;
  if ADocID <= 0 then
  begin
    MessageDlg('Selectati un document.', mtInformation, [mbOK], 0);
    Exit;
  end;

  dealID := FindDealByDoc(ADocID);

  { document mai vechi decat triggerul sau cu parinte pus ulterior }
  if dealID = 0 then
  begin
    if ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_ATTACH_DOC(:docid, :userid)',
      ['docid', ADocID, 'userid', dmDB.CurrentUserID]) then
      dealID := FindDealByDoc(ADocID);
  end;

  if dealID = 0 then
  begin
    if MessageDlg('Documentul nu apartine niciunui deal si nu are un lant de documente ' +
      'din care sa poata fi dedus.' + #13#10#13#10 +
      'Il legati manual de un deal existent al clientului?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;

    ReadDocInfo(ADocID, customerID, suma);
    browser := TfrmDealsBrowserDlg.Create(AOwner);
    try
      browser.SelectMode := True;
      browser.ContactID := customerID;
      if browser.ShowModal <> mrOk then
        Exit;
      dealID := browser.SelectedDealID;
    finally
      browser.Free;
    end;
    if dealID = 0 then
      Exit;

    { partea din plata atribuita acestui deal; gol = suma integrala }
    s := '';
    if not InputQuery('Legare de deal',
      Format('Suma atribuita deal-ului %d (documentul are %s).' + #13#10 +
        'Lasati gol pentru suma integrala:', [dealID, FormatFloat('0.00', suma)]), s) then
      Exit;
    vLinkSum := Null;
    s := Trim(StringReplace(s, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]));
    s := StringReplace(s, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
    if s <> '' then
    begin
      if not TryStrToFloat(s, linkSum) or (linkSum <= 0) then
      begin
        MessageDlg('Suma introdusa nu este valida.', mtError, [mbOK], 0);
        Exit;
      end;
      vLinkSum := linkSum;
    end;

    if not ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_BIND_DOC_MANUAL(:dealid, :docid, :userid, :linksum)',
      ['dealid', dealID, 'docid', ADocID, 'userid', dmDB.CurrentUserID, 'linksum', vLinkSum]) then
      Exit;
  end;

  ShowDealCard(AOwner, dealID);
end;

{ ---------------------------------------------------------------------------
  Randul "Deal" din dialogurile documentelor
  --------------------------------------------------------------------------- }

function DealAxesForDocType(const ADocTypeID: Integer): string;
begin
  case ADocTypeID of
    134: Result := 'PIPE,REASON';
    115: Result := 'PIPE,REASON,CHANNEL,FIN';
    1791: Result := 'FIN,PIPE,REASON';
    101: Result := 'PIPE,PAY';
    107: Result := 'PIPE,PAY,DLV';
    112, 116, 117, 119, 120, 1199: Result := 'PAY';
  else
    Result := '';
  end;
end;

function AxisTitle(const AGroup: string): string;
begin
  if AGroup = 'PIPE' then Result := 'Etapa'
  else if AGroup = 'PAY' then Result := 'Plata'
  else if AGroup = 'FIN' then Result := 'Finantare'
  else if AGroup = 'REASON' then Result := 'Motiv'
  else if AGroup = 'CHANNEL' then Result := 'Canal'
  else Result := 'Livrare';
end;

function IsChainDocType(const ADocTypeID: Integer): Boolean;
begin
  Result := (ADocTypeID = 134) or (ADocTypeID = 115) or (ADocTypeID = 1791) or
            (ADocTypeID = 101) or (ADocTypeID = 107);
end;

{ motivul si canalul nu sunt axe de stare: vin din TS_DEAL_REASONS }
function IsReasonGroup(const AGroup: string): Boolean;
begin
  Result := (AGroup = 'REASON') or (AGroup = 'CHANNEL');
end;

const
  cBarLabelW = 58;
  cBarComboMinW = 170;
  cBarComboMaxW = 230;
  cBarHeadW = 230;   { "Deal nr. X" + buton }
  cBarRowH = 32;

type
  { un camp din blocul "date comanda web" }
  TDealInfoField = record
    Caption: string;
    Value: string;
    Weight: Integer;
  end;
  TDealInfoRow = TArray<TDealInfoField>;

  TDealDialogBar = class(TComponent)
  private
    FForm: TForm;
    FDataSet: TDataSet;
    FDocID: Integer;
    FDocTypeID: Integer;
    FIsNew: Boolean;
    FDealID: Int64;
    FGroups: TStringList;
    FCombos: array of TComboBox;
    FCodes: array of TStringList;
    FInitial: array of Integer;
    FOldCloseQuery: TCloseQueryEvent;
    lbDeal: TLabel;
    btnDeal: TButton;
    FInfoRows: TArray<TDealInfoRow>;
    function S(const AValue: Integer): Integer;
    procedure LoadInfo;
    procedure BuildInfo(APanel: TPanel; ATop: Integer);
    procedure Layout(out APerRow, ARows, AComboW: Integer);
    procedure Build(APanel: TPanel);
    procedure LoadStates;
    function GroupIndex(const AGroup: string): Integer;
    procedure DealButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ApplyChanges;
  public
    destructor Destroy; override;
  end;

destructor TDealDialogBar.Destroy;
var
  i: Integer;
begin
  for i := 0 to High(FCodes) do
    FCodes[i].Free;
  FGroups.Free;
  inherited;
end;

function TDealDialogBar.S(const AValue: Integer): Integer;
begin
  Result := MulDiv(AValue, FForm.CurrentPPI, 96);
end;

function TDealDialogBar.GroupIndex(const AGroup: string): Integer;
begin
  Result := FGroups.IndexOf(AGroup);
end;

{ cate liste incap pe un rand; daca nu incap toate, se trece pe randul urmator }
procedure TDealDialogBar.Layout(out APerRow, ARows, AComboW: Integer);
var
  avail: Integer;
begin
  avail := FForm.ClientWidth - S(cBarHeadW) - S(8);
  APerRow := Max(1, avail div (S(cBarLabelW) + S(12) + S(cBarComboMinW)));
  APerRow := Min(APerRow, FGroups.Count);
  ARows := (FGroups.Count + APerRow - 1) div APerRow;
  AComboW := Min(S(cBarComboMaxW), avail div APerRow - S(cBarLabelW) - S(12));
end;

procedure TDealDialogBar.Build(APanel: TPanel);
var
  i, x0, x, y, perRow, rows, comboW, col, row: Integer;
  lb: TLabel;
  cb: TComboBox;
  bv: TBevel;
begin
  Layout(perRow, rows, comboW);

  bv := TBevel.Create(FForm);
  bv.Parent := APanel;
  bv.Shape := bsTopLine;
  bv.Align := alTop;
  bv.Height := S(2);

  x := S(8);
  y := S(4);
  lbDeal := TLabel.Create(FForm);
  lbDeal.Parent := APanel;
  lbDeal.AutoSize := False;
  lbDeal.Font.Style := [fsBold];
  lbDeal.SetBounds(x, y + (S(cBarRowH) - S(16)) div 2, S(118), S(16));
  Inc(x, S(120));

  btnDeal := TButton.Create(FForm);
  btnDeal.Parent := APanel;
  btnDeal.SetBounds(x, y + (S(cBarRowH) - S(25)) div 2, S(96), S(25));
  btnDeal.OnClick := DealButtonClick;
  btnDeal.TabStop := False;
  x0 := S(cBarHeadW);

  SetLength(FCombos, FGroups.Count);
  SetLength(FCodes, FGroups.Count);
  SetLength(FInitial, FGroups.Count);
  for i := 0 to FGroups.Count - 1 do
  begin
    col := i mod perRow;
    row := i div perRow;
    x := x0 + col * (S(cBarLabelW) + comboW + S(12));
    y := S(4) + row * S(cBarRowH);

    lb := TLabel.Create(FForm);
    lb.Parent := APanel;
    lb.AutoSize := False;
    lb.Alignment := taRightJustify;
    lb.Caption := AxisTitle(FGroups[i]) + ':';
    lb.SetBounds(x, y + (S(cBarRowH) - S(16)) div 2, S(cBarLabelW) - S(4), S(16));

    cb := TComboBox.Create(FForm);
    cb.Parent := APanel;
    cb.Style := csDropDownList;
    cb.DropDownCount := 16;
    cb.Width := comboW;
    cb.Left := x + S(cBarLabelW);
    cb.Top := y + (S(cBarRowH) - cb.Height) div 2;
    cb.TabStop := False;
    if FGroups[i] = 'PAY' then
      cb.Hint := 'Plata aleasa manual ramane pusa (nu se mai recalculeaza din incasari)'
    else if FGroups[i] = 'REASON' then
      cb.Hint := 'Motivul pierderii: muta si etapa in "Anulat". Se salveaza la OK.'
    else
      cb.Hint := 'Se salveaza la OK, odata cu documentul';
    cb.ShowHint := True;
    { lista deschisa mai lata decat combo-ul: motivele au texte lungi }
    SendMessage(cb.Handle, CB_SETDROPPEDWIDTH, S(340), 0);

    FCombos[i] := cb;
    FCodes[i] := TStringList.Create;
    FInitial[i] := -1;
  end;
end;

function InfoField(const ACaption, AValue: string; AWeight: Integer): TDealInfoField;
begin
  Result.Caption := ACaption;
  Result.Value := Trim(AValue);
  Result.Weight := AWeight;
end;

{ datele comenzii web din deal (scrise de site la crearea comenzii, vezi
  DB Model\deals_web_order_info.sql). FInfoRows ramane gol daca nu e nimic de aratat. }
procedure TDealDialogBar.LoadInfo;
const
  cSqlNew =
    'SELECT CONTACT_NAME, PHONE, DELIVERY_ADDRESS, DELIVERY_NOTE, PAYMENT_METHOD, ' +
    '       UTM_SOURCE, UTM_MEDIUM, UTM_CAMPAIGN, UTM_CONTENT, UTM_TERM ' +
    '  FROM TDB_DEALS WHERE DEAL_ID = :dealid';
  { pina la rularea scriptului pe baza coloanele noi lipsesc }
  cSqlOld =
    'SELECT CONTACT_NAME, PHONE, DELIVERY_ADDRESS, DELIVERY_NOTE, ' +
    '       CAST(NULL AS VARCHAR(60)) AS PAYMENT_METHOD, ' +
    '       CAST(NULL AS VARCHAR(255)) AS UTM_SOURCE, CAST(NULL AS VARCHAR(255)) AS UTM_MEDIUM, ' +
    '       CAST(NULL AS VARCHAR(255)) AS UTM_CAMPAIGN, CAST(NULL AS VARCHAR(255)) AS UTM_CONTENT, ' +
    '       CAST(NULL AS VARCHAR(255)) AS UTM_TERM ' +
    '  FROM TDB_DEALS WHERE DEAL_ID = :dealid';
var
  q: TIBCQuery;
  row: TDealInfoRow;

  function V(const AField: string): string;
  begin
    Result := Trim(q.FieldByName(AField).AsString);
  end;

begin
  FInfoRows := nil;
  if FDealID <= 0 then
    Exit;
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.SQL.Text := cSqlNew;
    q.ParamByName('dealid').AsLargeInt := FDealID;
    try
      q.Open;
    except
      q.Close;
      q.SQL.Text := cSqlOld;
      q.ParamByName('dealid').AsLargeInt := FDealID;
      q.Open;
    end;
    if q.IsEmpty then
      Exit;

    if (V('CONTACT_NAME') <> '') or (V('PHONE') <> '') or (V('PAYMENT_METHOD') <> '') then
      FInfoRows := FInfoRows + [TDealInfoRow.Create(
        InfoField('Client', V('CONTACT_NAME'), 3),
        InfoField('Telefon', V('PHONE'), 2),
        InfoField('Plata', V('PAYMENT_METHOD'), 2))];

    if (V('DELIVERY_ADDRESS') <> '') or (V('DELIVERY_NOTE') <> '') then
    begin
      row := [InfoField('Adresa', V('DELIVERY_ADDRESS'), 5)];
      if V('DELIVERY_NOTE') <> '' then
        row := row + [InfoField('Nota', V('DELIVERY_NOTE'), 3)];
      FInfoRows := FInfoRows + [row];
    end;

    if (V('UTM_SOURCE') <> '') or (V('UTM_MEDIUM') <> '') or (V('UTM_CAMPAIGN') <> '') or
       (V('UTM_CONTENT') <> '') or (V('UTM_TERM') <> '') then
      FInfoRows := FInfoRows + [TDealInfoRow.Create(
        InfoField('utm_source', V('UTM_SOURCE'), 2),
        InfoField('utm_medium', V('UTM_MEDIUM'), 2),
        InfoField('utm_campaign', V('UTM_CAMPAIGN'), 3),
        InfoField('utm_content', V('UTM_CONTENT'), 2),
        InfoField('utm_term', V('UTM_TERM'), 2))];
  finally
    q.Free;
  end;
end;

procedure TDealDialogBar.BuildInfo(APanel: TPanel; ATop: Integer);
var
  r, i, x, y, avail, totalW, fieldW, gap: Integer;
  lb: TLabel;
  ed: TEdit;
begin
  gap := S(12);
  for r := 0 to High(FInfoRows) do
  begin
    y := ATop + r * S(cBarRowH);
    avail := FForm.ClientWidth - S(16) - gap * (Length(FInfoRows[r]) - 1);
    totalW := 0;
    for i := 0 to High(FInfoRows[r]) do
      Inc(totalW, FInfoRows[r][i].Weight);

    x := S(8);
    for i := 0 to High(FInfoRows[r]) do
    begin
      fieldW := MulDiv(avail, FInfoRows[r][i].Weight, totalW);

      lb := TLabel.Create(FForm);
      lb.Parent := APanel;
      lb.AutoSize := True;
      lb.Caption := FInfoRows[r][i].Caption + ':';
      lb.Left := x;
      lb.Top := y + (S(cBarRowH) - lb.Height) div 2;

      { TEdit needitabil: textul se poate selecta si copia (telefon, adresa) }
      ed := TEdit.Create(FForm);
      ed.Parent := APanel;
      ed.ReadOnly := True;
      ed.TabStop := False;
      ed.ParentColor := True;
      ed.Text := FInfoRows[r][i].Value;
      ed.Hint := FInfoRows[r][i].Value;
      ed.ShowHint := FInfoRows[r][i].Value <> '';
      ed.Left := x + lb.Width + S(4);
      ed.Width := Max(S(40), fieldW - lb.Width - S(4));
      ed.Top := y + (S(cBarRowH) - ed.Height) div 2;

      Inc(x, fieldW + gap);
    end;
  end;
end;

procedure TDealDialogBar.LoadStates;
var
  q: TIBCQuery;
  i: Integer;
  cur: string;
begin
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;

    for i := 0 to FGroups.Count - 1 do
      if FCodes[i].Count = 0 then
      begin
        q.Close;
        if IsReasonGroup(FGroups[i]) then
        begin
          q.SQL.Text :=
            'SELECT CODE, TITLE_RO FROM TS_DEAL_REASONS ' +
            ' WHERE GROUP_CODE = :grp AND IS_ACTIVE = 1 ORDER BY SORT_ORDER, TITLE_RO';
          if FGroups[i] = 'REASON' then
            q.ParamByName('grp').AsString := 'CANCEL'
          else
            q.ParamByName('grp').AsString := 'CHANNEL';
          { primul rand = fara motiv / fara canal }
          FCodes[i].Add('');
          FCombos[i].Items.Add('');
        end
        else
        begin
          q.SQL.Text :=
            'SELECT CODE, TITLE_RO FROM TS_DEAL_STATES ' +
            ' WHERE TRIM(GROUP_CODE) = :grp AND IS_ACTIVE = 1 ORDER BY SORT_ORDER';
          q.ParamByName('grp').AsString := FGroups[i];
        end;
        q.Open;
        while not q.Eof do
        begin
          FCodes[i].Add(Trim(q.FieldByName('CODE').AsString));
          FCombos[i].Items.Add(q.FieldByName('TITLE_RO').AsString);
          q.Next;
        end;
      end;

    if FDealID > 0 then
    begin
      q.Close;
      q.SQL.Text :=
        'SELECT sp.CODE AS PIPE, sy.CODE AS PAY, sf.CODE AS FIN, sl.CODE AS DLV, ' +
        '       rr.CODE AS REASON, rc.CODE AS CHANNEL ' +
        '  FROM TDB_DEALS d ' +
        '  LEFT JOIN TS_DEAL_STATES sp ON sp.STATE_ID = d.PIPE_STATE_ID ' +
        '  LEFT JOIN TS_DEAL_STATES sy ON sy.STATE_ID = d.PAY_STATE_ID ' +
        '  LEFT JOIN TS_DEAL_STATES sf ON sf.STATE_ID = d.FIN_STATE_ID ' +
        '  LEFT JOIN TS_DEAL_STATES sl ON sl.STATE_ID = d.DLV_STATE_ID ' +
        '  LEFT JOIN TS_DEAL_REASONS rr ON rr.REASON_ID = d.CANCEL_REASON_ID ' +
        '  LEFT JOIN TS_DEAL_REASONS rc ON rc.REASON_ID = d.CHANNEL_ID ' +
        ' WHERE d.DEAL_ID = :dealid';
      q.ParamByName('dealid').AsLargeInt := FDealID;
      q.Open;
      for i := 0 to FGroups.Count - 1 do
      begin
        cur := '';
        if not q.IsEmpty then
          cur := Trim(q.FieldByName(FGroups[i]).AsString);
        FInitial[i] := FCodes[i].IndexOf(cur);
        FCombos[i].ItemIndex := FInitial[i];
        FCombos[i].Enabled := True;
      end;
      lbDeal.Caption := Format('Deal nr. %d', [FDealID]);
      btnDeal.Caption := 'Fisa deal...';
    end
    else
    begin
      for i := 0 to FGroups.Count - 1 do
      begin
        FInitial[i] := -1;
        if IsReasonGroup(FGroups[i]) then
          FInitial[i] := 0;
        FCombos[i].ItemIndex := FInitial[i];
        { documentul nou poate primi starile din start: se aplica dupa salvare }
        FCombos[i].Enabled := FIsNew and IsChainDocType(FDocTypeID);
      end;
      if FIsNew then
      begin
        lbDeal.Caption := 'Deal: nou';
        btnDeal.Caption := 'Deal...';
      end
      else
      begin
        lbDeal.Caption := 'Fara deal';
        btnDeal.Caption := 'Leaga...';
      end;
    end;
  finally
    q.Free;
  end;
end;

procedure TDealDialogBar.DealButtonClick(Sender: TObject);
begin
  if FDealID > 0 then
  begin
    ShowDealCard(FForm, FDealID);
    LoadStates;
  end
  else if FIsNew then
    MessageDlg('Deal-ul se creeaza automat la salvarea documentului.' + #13#10 +
      'Starile alese aici se aplica imediat dupa salvare.', mtInformation, [mbOK], 0)
  else
  begin
    ShowDealOfDocument(FForm, FDocID);
    FDealID := FindDealByDoc(FDocID);
    LoadStates;
  end;
end;

procedure TDealDialogBar.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FOldCloseQuery) then
    FOldCloseQuery(Sender, CanClose);

  { documentul a fost salvat (IsFormDataPosted) -> aplicam starile deal-ului }
  if CanClose and (FForm.ModalResult <> mrCancel) and (FForm.ModalResult <> mrNone) then
  try
    ApplyChanges;
  except
    on e: Exception do
      MessageDlg('Documentul a fost salvat, dar starile deal-ului nu:' + #13#10 + e.Message,
        mtWarning, [mbOK], 0);
  end;
end;

procedure TDealDialogBar.ApplyChanges;
var
  i, lock, iPipe, iReason: Integer;
  changed, ok: Boolean;
  dealID: Int64;
  f: TField;
  code: string;

  function IsChanged(const AIndex: Integer): Boolean;
  begin
    Result := (AIndex >= 0) and (FCombos[AIndex].ItemIndex >= 0) and
              (FCombos[AIndex].ItemIndex <> FInitial[AIndex]);
  end;

begin
  changed := False;
  for i := 0 to High(FCombos) do
    if IsChanged(i) then
      changed := True;
  if not changed then
    Exit;

  if FDocID <= 0 then
  begin
    f := FDataSet.FindField('DOCID');
    if (f <> nil) and not f.IsNull then
      FDocID := f.AsInteger;
  end;

  dealID := FDealID;
  if dealID = 0 then
    dealID := FindDealByDoc(FDocID);
  if (dealID = 0) and (FDocID > 0) then
  begin
    ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_ATTACH_DOC(:docid, :userid)',
      ['docid', FDocID, 'userid', dmDB.CurrentUserID]);
    dealID := FindDealByDoc(FDocID);
  end;
  if dealID = 0 then
  begin
    MessageDlg('Documentul nu apartine niciunui deal; starile alese nu au fost salvate.',
      mtWarning, [mbOK], 0);
    Exit;
  end;

  iPipe := GroupIndex('PIPE');
  iReason := GroupIndex('REASON');
  ok := True;

  { 1. axele de stare (etapa intai) }
  for i := 0 to High(FCombos) do
  begin
    if not ok then
      Break;
    if IsReasonGroup(FGroups[i]) or not IsChanged(i) then
      Continue;
    { plata se calculeaza din incasari: aleasa de mana trebuie blocata, altfel
      recalcularea o readuce imediat; etapa / livrarea / finantarea avanseaza
      oricum doar inainte }
    if FGroups[i] = 'PAY' then lock := 1 else lock := 0;
    ok := ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_SET_STATE(:dealid, :code, :userid, :lock)',
      ['dealid', dealID, 'code', FCodes[i][FCombos[i].ItemIndex],
       'userid', dmDB.CurrentUserID, 'lock', lock]);
  end;

  { 2. motivul: alegerea lui muta etapa in "Anulat"; etapa redeschisa il sterge }
  if ok and (iReason >= 0) then
  begin
    if IsChanged(iReason) then
      ok := ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_SET_REASON(:dealid, :code, :userid, ''MANUAL'')',
        ['dealid', dealID, 'code', FCodes[iReason][FCombos[iReason].ItemIndex],
         'userid', dmDB.CurrentUserID])
    else if IsChanged(iPipe) and (Pos('CANCELLED', FCodes[iPipe][FCombos[iPipe].ItemIndex]) = 0)
      and (FCombos[iReason].ItemIndex > 0) then
      ok := ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_SET_REASON(:dealid, :code, :userid, ''MANUAL'')',
        ['dealid', dealID, 'code', '', 'userid', dmDB.CurrentUserID]);
  end;

  { 3. canalul }
  i := GroupIndex('CHANNEL');
  if ok and IsChanged(i) then
  begin
    code := FCodes[i][FCombos[i].ItemIndex];
    ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_SET_CHANNEL(:dealid, :code, :userid)',
      ['dealid', dealID, 'code', code, 'userid', dmDB.CurrentUserID]);
  end;
end;

procedure AttachDealToDialog(AForm: TForm; ADataSet: TDataSet);
var
  bar: TDealDialogBar;
  axes: string;
  docTypeID, i, h, perRow, rows, comboW: Integer;
  tops, heights: array of Integer;
  pn: TPanel;
  f: TField;
begin
  try
    if (AForm = nil) or (ADataSet = nil) or not ADataSet.Active or not DealsAvailable then
      Exit;

    docTypeID := 0;
    f := ADataSet.FindField('DOCTYPEID');
    if (f <> nil) and not f.IsNull then
      docTypeID := f.AsInteger;
    if docTypeID <= 0 then
      docTypeID := dmDB.CurrentDocTypeID;
    axes := DealAxesForDocType(docTypeID);
    if axes = '' then
      Exit;

    bar := TDealDialogBar.Create(AForm);
    bar.FForm := AForm;
    bar.FDataSet := ADataSet;
    bar.FDocTypeID := docTypeID;
    bar.FIsNew := ADataSet.State = dsInsert;
    f := ADataSet.FindField('DOCID');
    if (f <> nil) and not f.IsNull then
      bar.FDocID := f.AsInteger;
    if not bar.FIsNew then
      bar.FDealID := FindDealByDoc(bar.FDocID);
    bar.FGroups := TStringList.Create;
    bar.FGroups.CommaText := axes;

    { fereastra creste cu inaltimea randului; controalele existente raman exact
      unde erau (se restaureaza pozitiile schimbate de ancore) }
    bar.Layout(perRow, rows, comboW);
    try
      bar.LoadInfo;
    except
      bar.FInfoRows := nil;
    end;
    h := bar.S(8) + (rows + Length(bar.FInfoRows)) * bar.S(cBarRowH);
    SetLength(tops, AForm.ControlCount);
    SetLength(heights, AForm.ControlCount);
    for i := 0 to AForm.ControlCount - 1 do
    begin
      tops[i] := AForm.Controls[i].Top;
      heights[i] := AForm.Controls[i].Height;
    end;
    AForm.ClientHeight := AForm.ClientHeight + h;
    for i := 0 to High(tops) do
      if AForm.Controls[i].Align = alNone then
        AForm.Controls[i].SetBounds(AForm.Controls[i].Left, tops[i], AForm.Controls[i].Width, heights[i]);

    pn := TPanel.Create(AForm);
    pn.BevelOuter := bvNone;
    pn.Caption := '';
    pn.Height := h;
    pn.Parent := AForm;
    pn.Top := AForm.ClientHeight;
    pn.Align := alBottom;

    bar.Build(pn);
    bar.BuildInfo(pn, bar.S(4) + rows * bar.S(cBarRowH));
    bar.LoadStates;

    bar.FOldCloseQuery := AForm.OnCloseQuery;
    AForm.OnCloseQuery := bar.FormCloseQuery;
  except
    { randul Deal e optional: nu impiedica deschiderea documentului }
  end;
end;

end.
