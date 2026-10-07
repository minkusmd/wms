unit frmECCCouriersDialog;

(* Curieri ECC (faza 7): legatura curier WMS -> casier ECC, tabela TFP_ECC_CASHIER.

   Curierul = COURIERID din livrare (TS_CUSTOMER), ales cu dialogul de clienti.
   Casierul ECC = CASHIER_ID (UUID-ul din ECC) + CASHIER_NAME; POS_ID = telefonul
   curierului in ECC (gol = POS-ul casei). "Casieri din ECC" listeaza casierii
   gasiti in bonurile ultimelor 60 de zile, cu id-ul lor.
   POS_ID exista doar dupa DB Model/ecc_delivery.sql. *)

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, SWNBaseUnit;

type
  TfrmECCCouriersDlg = class(TSWNCustomForm)
    pnTop: TPanel;
    lblApiCode: TLabel;
    cmbApiCode: TComboBox;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnEccCashiers: TButton;
    lblHint: TLabel;
    lvCouriers: TListView;
    pnBottom: TPanel;
    btnClose: TButton;
    procedure cmbApiCodeChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEccCashiersClick(Sender: TObject);
    procedure lvCouriersDblClick(Sender: TObject);
  private
    fPreferredApiCode: string;
    fHasPosId: Boolean;
    procedure LoadCouriers;
    function EditCourier(const ARowID: Integer): Boolean;
  protected
    procedure Prepare; override;
  public
    class procedure Execute(AOwner: TComponent; const AApiCode: string = '');
  end;

implementation

uses
  System.UITypes, System.StrUtils, IBC, DBAccess, MemDS, IBCClasses, Data.DB, DataModuleDB, frmCustomersDlg, ECCApiClient,
  ECCConfigUnit;

{$R *.dfm}

type
  TCourierRow = record
    RowID: Integer;
    CourierID: Integer;
    CourierName: string;
    CashierName: string;
    CashierId: string;
    PosId: string;
    Active: Boolean;
  end;

  // formularul de editare a unui rind, construit din cod
  TCourierEditForm = class(TForm)
  private
    FRow: TCourierRow;
    FHasPosId: Boolean;
    edCourier, edCashierName, edCashierId, edPosId: TEdit;
    chkActive: TCheckBox;
    procedure CourierClick(Sender: TObject);
    procedure OkClick(Sender: TObject);
    function AddEdit(const ACaption: string; const ATop: Integer; const AText: string): TEdit;
  public
    constructor CreateFor(AOwner: TComponent; const ARow: TCourierRow; const AHasPosId: Boolean);
    property Row: TCourierRow read FRow;
  end;

function OpenQuery(const ASQL: string): TIBCQuery;
begin
  Result := TIBCQuery.Create(nil);
  Result.Connection := dmDB.IBCConnection;
  Result.SQL.Text := ASQL;
end;

{ TCourierEditForm }

constructor TCourierEditForm.CreateFor(AOwner: TComponent; const ARow: TCourierRow; const AHasPosId: Boolean);
var
  Btn: TButton;
begin
  inherited CreateNew(AOwner);
  FRow := ARow;
  FHasPosId := AHasPosId;
  Caption := 'Curier ECC';
  BorderStyle := bsDialog;
  Position := poOwnerFormCenter;
  ClientWidth := 480;
  ClientHeight := 300;
  Font.Name := 'Tahoma';
  Font.Height := -13;

  edCourier := AddEdit('Curier (clientul din livrare, cimpul "Curier")', 12, ARow.CourierName);
  edCourier.ReadOnly := True;
  edCourier.Width := 360;
  Btn := TButton.Create(Self);
  Btn.Parent := Self;
  Btn.SetBounds(380, 30, 88, 24);
  Btn.Caption := 'Alege...';
  Btn.OnClick := CourierClick;

  edCashierName := AddEdit('Numele casierului in ECC', 64, ARow.CashierName);
  edCashierId := AddEdit('Id-ul casierului in ECC (UUID, vezi "Casieri din ECC")', 116, ARow.CashierId);
  edPosId := AddEdit('POS-ul (telefonul) curierului in ECC - gol = POS-ul casei', 168, ARow.PosId);
  edPosId.Enabled := AHasPosId;

  chkActive := TCheckBox.Create(Self);
  chkActive.Parent := Self;
  chkActive.SetBounds(12, 222, 200, 20);
  chkActive.Caption := 'Activ';
  chkActive.Checked := ARow.Active;

  Btn := TButton.Create(Self);
  Btn.Parent := Self;
  Btn.SetBounds(282, 258, 90, 30);
  Btn.Caption := 'OK';
  Btn.Default := True;
  Btn.OnClick := OkClick;

  Btn := TButton.Create(Self);
  Btn.Parent := Self;
  Btn.SetBounds(380, 258, 90, 30);
  Btn.Caption := 'Renunta';
  Btn.Cancel := True;
  Btn.ModalResult := mrCancel;
end;

function TCourierEditForm.AddEdit(const ACaption: string; const ATop: Integer; const AText: string): TEdit;
var
  L: TLabel;
begin
  L := TLabel.Create(Self);
  L.Parent := Self;
  L.SetBounds(12, ATop, 456, 16);
  L.Caption := ACaption;
  Result := TEdit.Create(Self);
  Result.Parent := Self;
  Result.SetBounds(12, ATop + 18, 456, 24);
  Result.Text := AText;
end;

procedure TCourierEditForm.CourierClick(Sender: TObject);
var
  Dlg: TfrmCustomersDlg;
begin
  Dlg := TfrmCustomersDlg.Create(Self);
  try
    if Dlg.SelectCustomer(FRow.CourierID, False, 0, 'Alege curierul') then
    begin
      FRow.CourierID := Dlg.CustomerID;
      FRow.CourierName := Dlg.CustomerTitle;
      edCourier.Text := FRow.CourierName;
      if Trim(edCashierName.Text) = '' then
        edCashierName.Text := FRow.CourierName;
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TCourierEditForm.OkClick(Sender: TObject);
begin
  FRow.CashierName := Trim(edCashierName.Text);
  FRow.CashierId := LowerCase(Trim(edCashierId.Text));
  FRow.PosId := LowerCase(Trim(edPosId.Text));
  FRow.Active := chkActive.Checked;
  if FRow.CourierID <= 0 then
    MessageDlg('Alegeti curierul.', mtWarning, [mbOK], 0)
  else if FRow.CashierName = '' then
    MessageDlg('Completati numele casierului din ECC.', mtWarning, [mbOK], 0)
  else if not IsValidECCId(FRow.CashierId) then
    MessageDlg('Id-ul casierului trebuie sa fie un UUID (de ex. c9e7d0d1-e601-4a35-8072-7e483194da9d).',
      mtWarning, [mbOK], 0)
  else if (FRow.PosId <> '') and not IsValidECCId(FRow.PosId) then
    MessageDlg('POS-ul curierului trebuie sa fie un UUID sau gol.', mtWarning, [mbOK], 0)
  else
    ModalResult := mrOk;
end;

{ TfrmECCCouriersDlg }

class procedure TfrmECCCouriersDlg.Execute(AOwner: TComponent; const AApiCode: string);
var
  Dlg: TfrmECCCouriersDlg;
begin
  Dlg := TfrmECCCouriersDlg.Create(AOwner);
  try
    Dlg.fPreferredApiCode := UpperCase(Trim(AApiCode));
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

procedure TfrmECCCouriersDlg.Prepare;
var
  Code: string;
  Q: TIBCQuery;

  procedure AddCol(const ACaption: string; const AWidth: Integer);
  begin
    with lvCouriers.Columns.Add do
    begin
      Caption := ACaption;
      Width := AWidth;
    end;
  end;

begin
  inherited;
  cmbApiCode.Items.Clear;
  for Code in ListECCApiCodes(dmDB.IBCConnection) do
    if Code <> 'ECC_ONLINE' then
      cmbApiCode.Items.Add(Code);
  cmbApiCode.ItemIndex := cmbApiCode.Items.IndexOf(fPreferredApiCode);
  if (cmbApiCode.ItemIndex < 0) and (cmbApiCode.Items.Count > 0) then
    cmbApiCode.ItemIndex := 0;

  Q := OpenQuery('SELECT COUNT(*) FROM RDB$RELATION_FIELDS WHERE RDB$RELATION_NAME = ''TFP_ECC_CASHIER'' ' +
    'AND RDB$FIELD_NAME = ''POS_ID''');
  try
    Q.Open;
    fHasPosId := Q.Fields[0].AsInteger > 0;
  finally
    Q.Free;
  end;
  if fHasPosId then
    lblHint.Caption := 'Curierul livrarii (cimpul "Curier") trebuie sa aiba aici casierul si telefonul lui din ECC.'
  else
  begin
    lblHint.Caption := 'Lipseste coloana POS_ID: rulati DB Model/ecc_delivery.sql (pina atunci se foloseste POS-ul casei).';
    lblHint.Font.Color := clRed;
  end;

  lvCouriers.Columns.Clear;
  AddCol('Curier (WMS)', 230);
  AddCol('Casier ECC', 170);
  AddCol('Id casier ECC', 270);
  AddCol('POS / telefon', 270);
  AddCol('Activ', 50);
  LoadCouriers;
end;

procedure TfrmECCCouriersDlg.LoadCouriers;
var
  Q: TIBCQuery;
  Item: TListItem;
  PosField: string;
begin
  lvCouriers.Items.BeginUpdate;
  try
    lvCouriers.Items.Clear;
    if cmbApiCode.Text = '' then
      Exit;
    if fHasPosId then
      PosField := 'C.POS_ID'
    else
      PosField := 'CAST(NULL AS VARCHAR(36)) AS POS_ID';
    Q := OpenQuery('SELECT C.CASHIER_ROWID, C.DRIVERID, CU.DISPLAYNAME, C.CASHIER_NAME, C.CASHIER_ID, ' + PosField +
      ', C.FLG_ACTIVE FROM TFP_ECC_CASHIER C LEFT JOIN TS_CUSTOMER CU ON CU.CUSTOMERID = C.DRIVERID ' +
      'WHERE C.API_CODE = :A AND C.DRIVERID IS NOT NULL ORDER BY CU.DISPLAYNAME');
    try
      Q.ParamByName('A').AsString := cmbApiCode.Text;
      Q.Open;
      while not Q.Eof do
      begin
        Item := lvCouriers.Items.Add;
        Item.Caption := Trim(Q.FieldByName('DISPLAYNAME').AsString);
        Item.Data := Pointer(NativeInt(Q.FieldByName('CASHIER_ROWID').AsInteger));
        Item.SubItems.Add(Trim(Q.FieldByName('CASHIER_NAME').AsString));
        Item.SubItems.Add(Trim(Q.FieldByName('CASHIER_ID').AsString));
        Item.SubItems.Add(Trim(Q.FieldByName('POS_ID').AsString));
        if Q.FieldByName('FLG_ACTIVE').AsInteger = 1 then
          Item.SubItems.Add('da')
        else
          Item.SubItems.Add('nu');
        Item.SubItems.Add(IntToStr(Q.FieldByName('DRIVERID').AsInteger));
        Q.Next;
      end;
    finally
      Q.Free;
    end;
  finally
    lvCouriers.Items.EndUpdate;
  end;
end;

function TfrmECCCouriersDlg.EditCourier(const ARowID: Integer): Boolean;
var
  Row: TCourierRow;
  Item: TListItem;
  F: TCourierEditForm;
  Tr: TIBCTransaction;
  Q: TIBCQuery;
begin
  Result := False;
  if cmbApiCode.Text = '' then
    Exit;
  Row := Default(TCourierRow);
  Row.Active := True;
  if ARowID > 0 then
  begin
    Item := lvCouriers.Selected;
    Row.RowID := ARowID;
    Row.CourierName := Item.Caption;
    Row.CashierName := Item.SubItems[0];
    Row.CashierId := Item.SubItems[1];
    Row.PosId := Item.SubItems[2];
    Row.Active := Item.SubItems[3] = 'da';
    Row.CourierID := StrToIntDef(Item.SubItems[4], 0);
  end;

  F := TCourierEditForm.CreateFor(Self, Row, fHasPosId);
  try
    if F.ShowModal <> mrOk then
      Exit;
    Row := F.Row;
  finally
    F.Free;
  end;

  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := dmDB.IBCConnection;
    Q.Connection := dmDB.IBCConnection;
    Q.Transaction := Tr;
    if Row.RowID > 0 then
      Q.SQL.Text := 'UPDATE TFP_ECC_CASHIER SET DRIVERID = :DRV, CASHIER_NAME = :NAME, CASHIER_ID = :CID, ' +
        'FLG_ACTIVE = :ACT' + IfThen(fHasPosId, ', POS_ID = :POS', '') + ' WHERE CASHIER_ROWID = :ID'
    else
      Q.SQL.Text := 'INSERT INTO TFP_ECC_CASHIER (API_CODE, DRIVERID, CASHIER_NAME, CASHIER_ID, FLG_ACTIVE' +
        IfThen(fHasPosId, ', POS_ID', '') + ') VALUES (:API, :DRV, :NAME, :CID, :ACT' +
        IfThen(fHasPosId, ', :POS', '') + ')';
    Tr.StartTransaction;
    try
      if Row.RowID > 0 then
        Q.ParamByName('ID').AsInteger := Row.RowID
      else
        Q.ParamByName('API').AsString := cmbApiCode.Text;
      Q.ParamByName('DRV').AsInteger := Row.CourierID;
      Q.ParamByName('NAME').AsString := Row.CashierName;
      Q.ParamByName('CID').AsString := Row.CashierId;
      Q.ParamByName('ACT').AsInteger := Ord(Row.Active);
      if fHasPosId then
        if Row.PosId <> '' then
          Q.ParamByName('POS').AsString := Row.PosId
        else
        begin
          Q.ParamByName('POS').DataType := ftString;
          Q.ParamByName('POS').Clear;
        end;
      Q.ExecSQL;
      Tr.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        if Tr.Active then
          Tr.Rollback;
        if Pos('UQ_TFP_ECC_CASHIER_DRIVER', E.Message) > 0 then
          MessageDlg('Curierul are deja un casier ECC pe aceasta casa.', mtWarning, [mbOK], 0)
        else
          raise;
      end;
    end;
  finally
    Q.Free;
    Tr.Free;
  end;
  if Result then
    LoadCouriers;
end;

procedure TfrmECCCouriersDlg.cmbApiCodeChange(Sender: TObject);
begin
  LoadCouriers;
end;

procedure TfrmECCCouriersDlg.btnAddClick(Sender: TObject);
begin
  EditCourier(0);
end;

procedure TfrmECCCouriersDlg.btnEditClick(Sender: TObject);
begin
  if lvCouriers.Selected <> nil then
    EditCourier(NativeInt(lvCouriers.Selected.Data));
end;

procedure TfrmECCCouriersDlg.lvCouriersDblClick(Sender: TObject);
begin
  btnEditClick(Sender);
end;

procedure TfrmECCCouriersDlg.btnDeleteClick(Sender: TObject);
var
  Q: TIBCQuery;
  Tr: TIBCTransaction;
begin
  if lvCouriers.Selected = nil then
    Exit;
  if MessageDlg('Stergeti legatura curierului "' + lvCouriers.Selected.Caption + '" cu casierul ECC?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := dmDB.IBCConnection;
    Q.Connection := dmDB.IBCConnection;
    Q.Transaction := Tr;
    Q.SQL.Text := 'DELETE FROM TFP_ECC_CASHIER WHERE CASHIER_ROWID = :ID';
    Tr.StartTransaction;
    try
      Q.ParamByName('ID').AsInteger := NativeInt(lvCouriers.Selected.Data);
      Q.ExecSQL;
      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
  finally
    Q.Free;
    Tr.Free;
  end;
  LoadCouriers;
end;

procedure TfrmECCCouriersDlg.btnEccCashiersClick(Sender: TObject);
var
  Config: TECCConfig;
  Client: TECCApiClient;
  List: TArray<TECCReceipt>;
  R: TECCReceipt;
  Seen: TStringList;
  Key: string;
begin
  Config := LoadECCConfig(dmDB.IBCConnection, cmbApiCode.Text);
  Client := Config.CreateClient;
  Seen := TStringList.Create;
  Screen.Cursor := crHourGlass;
  try
    Seen.Sorted := True;
    Seen.Duplicates := dupIgnore;
    List := Client.ListReceipts(Date - 60, Now);
    for R in List do
      if R.CashierId <> '' then
      begin
        Key := Format('%-24s  casier %s   POS %s (%s)', [R.CashierName, R.CashierId, R.PosId, R.PosName]);
        Seen.Add(Key);
      end;
  finally
    Screen.Cursor := crDefault;
    Client.Free;
  end;
  try
    if Seen.Count = 0 then
      MessageDlg('In ultimele 60 de zile ECC nu are bonuri cu casieri pe cheia casei ' + cmbApiCode.Text + '.',
        mtInformation, [mbOK], 0)
    else
      // textul se poate copia cu Ctrl+C din dialog
      MessageDlg('Casierii gasiti in bonurile ECC din ultimele 60 de zile:' + sLineBreak + sLineBreak + Seen.Text,
        mtInformation, [mbOK], 0);
  finally
    Seen.Free;
  end;
end;

end.
