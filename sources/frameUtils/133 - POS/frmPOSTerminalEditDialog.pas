unit frmPOSTerminalEditDialog;

{
  POS - editorul unei case (TPOS_TERMINAL): firma, depozitul din care se vinde, statia de lucru
  (calculatorul pe care ruleaza casa), aparatul fiscal, clientul pus implicit pe bonuri,
  coloana de pret si reducerea maxima pe care o poate da casierul.

  Casa se recunoaste dupa firma curenta + numele calculatorului (POSDetectTerminal), de aceea
  statia de lucru se alege dintre cele ale firmei.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, SWNBaseUnit;

type
  TfrmPOSTerminalEditDlg = class(TSWNCustomForm)
    lblTitle: TLabel;
    edTitle: TEdit;
    lblFirma: TLabel;
    cmbFirma: TComboBox;
    lblStock: TLabel;
    cmbStock: TComboBox;
    lblWS: TLabel;
    cmbWS: TComboBox;
    lblWSHint: TLabel;
    lblFP: TLabel;
    cmbFP: TComboBox;
    lblCustomer: TLabel;
    edCustomerSearch: TEdit;
    btnCustomerFind: TButton;
    cmbCustomer: TComboBox;
    lblPriceColumn: TLabel;
    cmbPriceColumn: TComboBox;
    lblMaxDiscount: TLabel;
    edMaxDiscount: TEdit;
    cbEnabled: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    procedure cmbFirmaChange(Sender: TObject);
    procedure btnCustomerFindClick(Sender: TObject);
    procedure edCustomerSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fPosID: Integer;
    function ComboID(const ACombo: TComboBox): Integer;
    procedure SelectID(const ACombo: TComboBox; const AID: Integer);
    procedure FillCombo(const ACombo: TComboBox; const ASQL: string; const AParamName: string = '';
      const AParamValue: Integer = 0; const AEmptyItem: string = '');
    procedure LoadFirmaDependent;
    procedure LoadCustomerByID(const ACustomerID: Integer);
    procedure LoadRecord;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    // APosID = 0 -> casa noua. True = salvat.
    class function Execute(AOwner: TComponent; const APosID: Integer): Boolean;
  end;

implementation

uses
  System.UITypes, Data.DB, IBC, DataModuleDB, FiscalPrinterUtilsUnit, POSSaleUnit;

{$R *.dfm}

const
  cPOS_DefaultAnonymousCustomerID = 286;

class function TfrmPOSTerminalEditDlg.Execute(AOwner: TComponent; const APosID: Integer): Boolean;
var
  Dialog: TfrmPOSTerminalEditDlg;
begin
  Dialog := TfrmPOSTerminalEditDlg.Create(AOwner);
  try
    Dialog.fPosID := APosID;
    Result := Dialog.ShowModal = mrOk;
  finally
    Dialog.Free;
  end;
end;

function TfrmPOSTerminalEditDlg.ComboID(const ACombo: TComboBox): Integer;
begin
  if ACombo.ItemIndex >= 0 then
    Result := Integer(ACombo.Items.Objects[ACombo.ItemIndex])
  else
    Result := 0;
end;

procedure TfrmPOSTerminalEditDlg.SelectID(const ACombo: TComboBox; const AID: Integer);
var
  I: Integer;
begin
  ACombo.ItemIndex := -1;
  for I := 0 to ACombo.Items.Count - 1 do
    if Integer(ACombo.Items.Objects[I]) = AID then
    begin
      ACombo.ItemIndex := I;
      Break;
    end;
end;

// ASQL intoarce doua coloane: ID si denumirea
procedure TfrmPOSTerminalEditDlg.FillCombo(const ACombo: TComboBox; const ASQL, AParamName: string;
  const AParamValue: Integer; const AEmptyItem: string);
var
  Query: TIBCQuery;
begin
  ACombo.Items.BeginUpdate;
  try
    ACombo.Items.Clear;
    if AEmptyItem <> '' then
      ACombo.Items.AddObject(AEmptyItem, TObject(0));
    Query := TIBCQuery.Create(nil);
    try
      Query.Connection := dmDB.IBCConnection;
      Query.Transaction := dmDB.IBCTrDefaultSelect;
      Query.SQL.Text := ASQL;
      if AParamName <> '' then
        Query.ParamByName(AParamName).AsInteger := AParamValue;
      Query.Open;
      while not Query.Eof do
      begin
        ACombo.Items.AddObject(Format('%s  [%d]', [Trim(Query.Fields[1].AsString), Query.Fields[0].AsInteger]),
          TObject(Query.Fields[0].AsInteger));
        Query.Next;
      end;
      Query.Close;
    finally
      Query.Free;
    end;
  finally
    ACombo.Items.EndUpdate;
  end;
end;

// statiile de lucru si aparatele fiscale sint ale firmei alese
procedure TfrmPOSTerminalEditDlg.LoadFirmaDependent;
var
  FirmaID, OldWS, OldFP: Integer;
begin
  FirmaID := ComboID(cmbFirma);
  OldWS := ComboID(cmbWS);
  OldFP := ComboID(cmbFP);
  FillCombo(cmbWS,
    'select WS_ID, COMPUTER_NAME || coalesce('' - '' || nullif(trim(DESCRIPTION), ''''), '''') ' +
    'from WS_WORK_STATIONS where (FLG_ENABLED = 1) and (FIRMA_ID = :ID) order by COMPUTER_NAME', 'ID', FirmaID);
  FillCombo(cmbFP,
    'select FP_ID, coalesce(nullif(trim(DESCRIPTION), ''''), ''MCC'') || '' / '' || coalesce(SERIAL_NUMBER, '''') ' +
    'from FP_DEVICES where FIRMA_ID = :ID order by FLG_ENABLED desc, FP_ID', 'ID', FirmaID, '(fara aparat fiscal)');
  SelectID(cmbWS, OldWS);
  SelectID(cmbFP, OldFP);
  if cmbFP.ItemIndex < 0 then
    cmbFP.ItemIndex := 0;
end;

procedure TfrmPOSTerminalEditDlg.cmbFirmaChange(Sender: TObject);
begin
  LoadFirmaDependent;
end;

procedure TfrmPOSTerminalEditDlg.LoadCustomerByID(const ACustomerID: Integer);
begin
  FillCombo(cmbCustomer, 'select CUSTOMERID, DISPLAYNAME from TS_CUSTOMER where CUSTOMERID = :ID', 'ID', ACustomerID);
  if cmbCustomer.Items.Count > 0 then
    cmbCustomer.ItemIndex := 0;
end;

procedure TfrmPOSTerminalEditDlg.btnCustomerFindClick(Sender: TObject);
var
  Text: string;
  Query: TIBCQuery;
begin
  Text := Trim(edCustomerSearch.Text);
  if Length(Text) < 3 then
  begin
    MessageDlg('Scrieti cel putin 3 caractere din denumirea clientului (sau codul lui).', mtInformation, [mbOK], 0);
    Exit;
  end;
  if StrToIntDef(Text, 0) > 0 then
  begin
    LoadCustomerByID(StrToIntDef(Text, 0));
    if cmbCustomer.Items.Count = 0 then
      MessageDlg('Nu exista client cu acest cod.', mtInformation, [mbOK], 0);
    Exit;
  end;

  cmbCustomer.Items.BeginUpdate;
  try
    cmbCustomer.Items.Clear;
    Query := TIBCQuery.Create(nil);
    try
      Query.Connection := dmDB.IBCConnection;
      Query.Transaction := dmDB.IBCTrDefaultSelect;
      Query.SQL.Text :=
        'select first 50 CUSTOMERID, DISPLAYNAME from TS_CUSTOMER ' +
        'where DISPLAYNAME containing :TXT order by DISPLAYNAME';
      Query.ParamByName('TXT').AsString := Text;
      Query.Open;
      while not Query.Eof do
      begin
        cmbCustomer.Items.AddObject(Format('%s  [%d]', [Trim(Query.Fields[1].AsString), Query.Fields[0].AsInteger]),
          TObject(Query.Fields[0].AsInteger));
        Query.Next;
      end;
      Query.Close;
    finally
      Query.Free;
    end;
  finally
    cmbCustomer.Items.EndUpdate;
  end;
  if cmbCustomer.Items.Count = 0 then
    MessageDlg('Niciun client gasit.', mtInformation, [mbOK], 0)
  else
  begin
    cmbCustomer.ItemIndex := 0;
    if cmbCustomer.CanFocus then
      cmbCustomer.SetFocus;
    cmbCustomer.DroppedDown := cmbCustomer.Items.Count > 1;
  end;
end;

procedure TfrmPOSTerminalEditDlg.edCustomerSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    btnCustomerFindClick(nil);
  end;
end;

procedure TfrmPOSTerminalEditDlg.LoadRecord;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultSelect;
    Query.SQL.Text :=
      'select TITLE, FIRMA_ID, STOCKID, WS_ID, FP_ID, DEFAULT_CUSTOMERID, PRICE_COLUMN, MAX_DISCOUNT_P, FLG_ENABLED ' +
      'from TPOS_TERMINAL where POS_ID = :ID';
    Query.ParamByName('ID').AsInteger := fPosID;
    Query.Open;
    if Query.Eof then
      raise Exception.CreateFmt('Casa %d nu mai exista.', [fPosID]);
    edTitle.Text := Query.FieldByName('TITLE').AsString;
    SelectID(cmbFirma, Query.FieldByName('FIRMA_ID').AsInteger);
    LoadFirmaDependent;
    SelectID(cmbStock, Query.FieldByName('STOCKID').AsInteger);
    SelectID(cmbWS, Query.FieldByName('WS_ID').AsInteger);
    SelectID(cmbFP, Query.FieldByName('FP_ID').AsInteger);
    if cmbFP.ItemIndex < 0 then
      cmbFP.ItemIndex := 0;
    LoadCustomerByID(Query.FieldByName('DEFAULT_CUSTOMERID').AsInteger);
    SelectID(cmbPriceColumn, Query.FieldByName('PRICE_COLUMN').AsInteger);
    edMaxDiscount.Text := IntToStr(Query.FieldByName('MAX_DISCOUNT_P').AsInteger);
    cbEnabled.Checked := Query.FieldByName('FLG_ENABLED').AsInteger = 1;
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmPOSTerminalEditDlg.Prepare;
var
  I: Integer;
begin
  // calculatorul curent trebuie sa existe in lista statiilor, ca sa poata fi ales
  RegisterCurrentWorkStation(dmDB.CurrentFirma);

  FillCombo(cmbFirma, 'select CUSTOMERID, DISPLAYNAME from GET_FIRMS_BY_USER2 order by ORDERNO');
  // depozitele principale (PARENTID = 1) primele
  FillCombo(cmbStock, 'select STOCKID, TITLE from TS_STOCKS where FLG_FOLDER = 0 ' +
    'order by iif(PARENTID = 1, 0, 1), TITLE');
  cmbPriceColumn.Items.Clear;
  for I := 1 to 6 do
    cmbPriceColumn.Items.AddObject(Format('Coloana %d', [I]), TObject(I));

  if fPosID > 0 then
  begin
    Caption := 'Modificarea casei';
    LoadRecord;
  end
  else
  begin
    Caption := 'Casa noua';
    SelectID(cmbFirma, dmDB.CurrentFirma);
    LoadFirmaDependent;
    cmbPriceColumn.ItemIndex := 0;
    // clientul generic "PERSOANA FIZICA", cel folosit si de comenzile de pe site
    LoadCustomerByID(cPOS_DefaultAnonymousCustomerID);
    edMaxDiscount.Text := '0';
    cbEnabled.Checked := True;
    // propunem calculatorul de pe care se face configurarea
    for I := 0 to cmbWS.Items.Count - 1 do
      if Pos(UpperCase(GetCurrentComputerName), UpperCase(cmbWS.Items[I])) = 1 then
      begin
        cmbWS.ItemIndex := I;
        Break;
      end;
  end;
  lblWSHint.Caption := 'Acest calculator: ' + GetCurrentComputerName;
  ActiveControl := edTitle;
end;

function TfrmPOSTerminalEditDlg.IsFormDataPosted: Boolean;
var
  Query: TIBCQuery;
  Tr: TIBCTransaction;
  MaxDiscount: Integer;
  Error: string;
begin
  Result := False;
  Error := '';
  MaxDiscount := StrToIntDef(Trim(edMaxDiscount.Text), -1);
  if Trim(edTitle.Text) = '' then
    Error := 'Scrieti denumirea casei.'
  else if ComboID(cmbFirma) <= 0 then
    Error := 'Alegeti firma.'
  else if ComboID(cmbStock) <= 0 then
    Error := 'Alegeti depozitul din care se vinde.'
  else if ComboID(cmbWS) <= 0 then
    Error := 'Alegeti statia de lucru (calculatorul casei). Fara ea casa nu poate fi recunoscuta.'
  else if ComboID(cmbCustomer) <= 0 then
    Error := 'Alegeti clientul pus implicit pe bonuri.'
  else if ComboID(cmbPriceColumn) <= 0 then
    Error := 'Alegeti coloana de pret.'
  else if (MaxDiscount < 0) or (MaxDiscount > 100) then
    Error := 'Reducerea maxima trebuie sa fie intre 0 si 100.';
  if Error <> '' then
  begin
    MessageDlg(Error, mtError, [mbOK], 0);
    Exit;
  end;

  Query := TIBCQuery.Create(nil);
  Tr := TIBCTransaction.Create(nil);
  try
    Tr.DefaultConnection := dmDB.IBCConnection;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := Tr;
    Tr.StartTransaction;
    try
      // o statie de lucru = o singura casa activa, altfel POSDetectTerminal nu ar sti pe care s-o aleaga
      if cbEnabled.Checked then
      begin
        Query.SQL.Text :=
          'select first 1 TITLE from TPOS_TERMINAL ' +
          'where WS_ID = :WS_ID and FIRMA_ID = :FIRMA_ID and FLG_ENABLED = 1 and POS_ID <> :POS_ID';
        Query.ParamByName('WS_ID').AsInteger := ComboID(cmbWS);
        Query.ParamByName('FIRMA_ID').AsInteger := ComboID(cmbFirma);
        Query.ParamByName('POS_ID').AsInteger := fPosID;
        Query.Open;
        if not Query.Eof then
          Error := Format('Pe aceasta statie de lucru este deja configurata casa activa "%s".',
            [Query.Fields[0].AsString]);
        Query.Close;
        if Error <> '' then
        begin
          Tr.Rollback;
          MessageDlg(Error, mtError, [mbOK], 0);
          Exit;
        end;
      end;

      if fPosID > 0 then
        Query.SQL.Text :=
          'update TPOS_TERMINAL set TITLE = :TITLE, FIRMA_ID = :FIRMA_ID, STOCKID = :STOCKID, WS_ID = :WS_ID, ' +
          '  FP_ID = :FP_ID, DEFAULT_CUSTOMERID = :CUSTOMERID, PRICE_COLUMN = :PRICE_COLUMN, ' +
          '  MAX_DISCOUNT_P = :MAX_DISCOUNT_P, FLG_ENABLED = :FLG_ENABLED ' +
          'where POS_ID = :POS_ID'
      else
        Query.SQL.Text :=
          'insert into TPOS_TERMINAL (TITLE, FIRMA_ID, STOCKID, WS_ID, FP_ID, DEFAULT_CUSTOMERID, PRICE_COLUMN, ' +
          '  MAX_DISCOUNT_P, FLG_ENABLED) ' +
          'values (:TITLE, :FIRMA_ID, :STOCKID, :WS_ID, :FP_ID, :CUSTOMERID, :PRICE_COLUMN, :MAX_DISCOUNT_P, :FLG_ENABLED)';
      Query.ParamByName('TITLE').AsString := Copy(Trim(edTitle.Text), 1, 128);
      Query.ParamByName('FIRMA_ID').AsInteger := ComboID(cmbFirma);
      Query.ParamByName('STOCKID').AsInteger := ComboID(cmbStock);
      Query.ParamByName('WS_ID').AsInteger := ComboID(cmbWS);
      if ComboID(cmbFP) > 0 then
        Query.ParamByName('FP_ID').AsInteger := ComboID(cmbFP)
      else
      begin
        Query.ParamByName('FP_ID').DataType := ftInteger;
        Query.ParamByName('FP_ID').Clear;
      end;
      Query.ParamByName('CUSTOMERID').AsInteger := ComboID(cmbCustomer);
      Query.ParamByName('PRICE_COLUMN').AsInteger := ComboID(cmbPriceColumn);
      Query.ParamByName('MAX_DISCOUNT_P').AsInteger := MaxDiscount;
      Query.ParamByName('FLG_ENABLED').AsInteger := Ord(cbEnabled.Checked);
      if fPosID > 0 then
        Query.ParamByName('POS_ID').AsInteger := fPosID;
      Query.Execute;
      Tr.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        if Tr.Active then
          Tr.Rollback;
        MessageDlg('Casa nu a putut fi salvata: ' + POSErrorText(E), mtError, [mbOK], 0);
      end;
    end;
  finally
    Query.Free;
    Tr.Free;
  end;
end;

end.
