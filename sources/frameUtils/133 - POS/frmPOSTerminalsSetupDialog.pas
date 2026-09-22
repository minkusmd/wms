unit frmPOSTerminalsSetupDialog;

{
  POS - lista caselor (TPOS_TERMINAL): adaugare, modificare, stergere.
  O casa care are deja ture nu se poate sterge (turele si bonurile tin de ea) - se dezactiveaza.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, SWNBaseUnit;

type
  TfrmPOSTerminalsSetupDlg = class(TSWNCustomForm)
    lblInfo: TLabel;
    lvTerminals: TListView;
    btnNew: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnClose: TButton;
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure lvTerminalsDblClick(Sender: TObject);
    procedure lvTerminalsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
  private
    { Private declarations }
    procedure LoadList(const ASelectPosID: Integer = 0);
    function SelectedPosID: Integer;
    procedure UpdateButtons;
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  end;

implementation

uses
  System.UITypes, Data.DB, IBC, DataModuleDB, POSSaleUnit, frmPOSTerminalEditDialog;

{$R *.dfm}

procedure TfrmPOSTerminalsSetupDlg.Prepare;
begin
  try
    LoadList;
  except
    on E: Exception do
    begin
      // de regula: DB Model\pos.sql nu a fost rulat pe aceasta baza
      MessageDlg('Lista caselor nu poate fi citita: ' + E.Message, mtError, [mbOK], 0);
      ModalResult := mrCancel;
    end;
  end;
end;

procedure TfrmPOSTerminalsSetupDlg.LoadList(const ASelectPosID: Integer);
var
  Query: TIBCQuery;
  Item: TListItem;
begin
  lvTerminals.Items.BeginUpdate;
  try
    lvTerminals.Items.Clear;
    Query := TIBCQuery.Create(nil);
    try
      Query.Connection := dmDB.IBCConnection;
      Query.Transaction := dmDB.IBCTrDefaultSelect;
      Query.SQL.Text :=
        'select P.POS_ID, P.TITLE, P.FLG_ENABLED, P.STOCKID, P.PRICE_COLUMN, P.MAX_DISCOUNT_P, ' +
        '  (select C.DISPLAYNAME from TS_CUSTOMER C where C.CUSTOMERID = P.FIRMA_ID) FIRMA_NAME, ' +
        '  (select S.TITLE from TS_STOCKS S where S.STOCKID = P.STOCKID) STOCK_NAME, ' +
        '  (select W.COMPUTER_NAME from WS_WORK_STATIONS W where W.WS_ID = P.WS_ID) COMPUTER_NAME, ' +
        '  (select coalesce(nullif(trim(F.DESCRIPTION), ''''), F.SERIAL_NUMBER) from FP_DEVICES F where F.FP_ID = P.FP_ID) FP_NAME, ' +
        '  (select C.DISPLAYNAME from TS_CUSTOMER C where C.CUSTOMERID = P.DEFAULT_CUSTOMERID) CUSTOMER_NAME, ' +
        '  (select count(*) from TPOS_SHIFT SH where SH.POS_ID = P.POS_ID and SH.CLOSED_AT is null) OPEN_SHIFTS ' +
        'from TPOS_TERMINAL P order by P.TITLE';
      Query.Open;
      while not Query.Eof do
      begin
        Item := lvTerminals.Items.Add;
        Item.Caption := Query.FieldByName('TITLE').AsString;
        Item.Data := Pointer(Query.FieldByName('POS_ID').AsInteger);
        Item.SubItems.Add(Trim(Query.FieldByName('FIRMA_NAME').AsString));
        Item.SubItems.Add(Trim(Query.FieldByName('STOCK_NAME').AsString));
        Item.SubItems.Add(Trim(Query.FieldByName('COMPUTER_NAME').AsString));
        Item.SubItems.Add(Trim(Query.FieldByName('FP_NAME').AsString));
        Item.SubItems.Add(Trim(Query.FieldByName('CUSTOMER_NAME').AsString));
        Item.SubItems.Add(Query.FieldByName('PRICE_COLUMN').AsString);
        Item.SubItems.Add(Query.FieldByName('MAX_DISCOUNT_P').AsString + '%');
        if Query.FieldByName('FLG_ENABLED').AsInteger = 1 then
          Item.SubItems.Add('da')
        else
          Item.SubItems.Add('NU');
        if Query.FieldByName('OPEN_SHIFTS').AsInteger > 0 then
          Item.SubItems.Add('deschisa')
        else
          Item.SubItems.Add('');
        if Query.FieldByName('POS_ID').AsInteger = ASelectPosID then
        begin
          Item.Selected := True;
          Item.Focused := True;
        end;
        Query.Next;
      end;
      Query.Close;
    finally
      Query.Free;
    end;
  finally
    lvTerminals.Items.EndUpdate;
  end;
  if (lvTerminals.Selected = nil) and (lvTerminals.Items.Count > 0) then
    lvTerminals.Items[0].Selected := True;
  UpdateButtons;
end;

function TfrmPOSTerminalsSetupDlg.SelectedPosID: Integer;
begin
  if lvTerminals.Selected <> nil then
    Result := Integer(lvTerminals.Selected.Data)
  else
    Result := 0;
end;

procedure TfrmPOSTerminalsSetupDlg.UpdateButtons;
begin
  btnEdit.Enabled := SelectedPosID > 0;
  btnDelete.Enabled := SelectedPosID > 0;
end;

procedure TfrmPOSTerminalsSetupDlg.lvTerminalsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  UpdateButtons;
end;

procedure TfrmPOSTerminalsSetupDlg.lvTerminalsDblClick(Sender: TObject);
begin
  if btnEdit.Enabled then
    btnEditClick(nil);
end;

procedure TfrmPOSTerminalsSetupDlg.btnNewClick(Sender: TObject);
begin
  if TfrmPOSTerminalEditDlg.Execute(Self, 0) then
    LoadList;
end;

procedure TfrmPOSTerminalsSetupDlg.btnEditClick(Sender: TObject);
var
  PosID: Integer;
begin
  PosID := SelectedPosID;
  if PosID <= 0 then
    Exit;
  if TfrmPOSTerminalEditDlg.Execute(Self, PosID) then
    LoadList(PosID);
end;

procedure TfrmPOSTerminalsSetupDlg.btnDeleteClick(Sender: TObject);
var
  PosID, Shifts: Integer;
  Query: TIBCQuery;
  Tr: TIBCTransaction;
begin
  PosID := SelectedPosID;
  if PosID <= 0 then
    Exit;
  if MessageDlg(Format('Stergeti casa "%s"?', [lvTerminals.Selected.Caption]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  Query := TIBCQuery.Create(nil);
  Tr := TIBCTransaction.Create(nil);
  try
    Tr.DefaultConnection := dmDB.IBCConnection;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := Tr;
    Tr.StartTransaction;
    try
      Query.SQL.Text := 'select count(*) from TPOS_SHIFT where POS_ID = :ID';
      Query.ParamByName('ID').AsInteger := PosID;
      Query.Open;
      Shifts := Query.Fields[0].AsInteger;
      Query.Close;
      if Shifts > 0 then
      begin
        Tr.Rollback;
        MessageDlg(Format('Casa are %d ture inregistrate si nu poate fi stearsa. ' +
          'Dezactivati-o din "Modifica" (debifati "Casa este activa").', [Shifts]), mtInformation, [mbOK], 0);
        Exit;
      end;
      Query.SQL.Text := 'delete from TPOS_TERMINAL where POS_ID = :ID';
      Query.ParamByName('ID').AsInteger := PosID;
      Query.Execute;
      Tr.Commit;
    except
      on E: Exception do
      begin
        if Tr.Active then
          Tr.Rollback;
        MessageDlg('Casa nu a putut fi stearsa: ' + POSErrorText(E), mtError, [mbOK], 0);
        Exit;
      end;
    end;
  finally
    Query.Free;
    Tr.Free;
  end;
  LoadList;
end;

end.
