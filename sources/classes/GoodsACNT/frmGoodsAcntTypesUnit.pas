unit frmGoodsAcntTypesUnit;

{
  Denumirile de contabilitate (TS_GOODS_ACNT) grupate dupa tipul produsului
  (GOODS_TYPEID -> TS_GOODS_TYPE.GOODSTYPEID).

  - stinga: tipurile cu numarul de denumiri, primul "(fara tip)";
  - dreapta: denumirile tipului ales sau, la cautare, din toate tipurile
    (cautarea ignora tipul: denumirea, codul, optional si titlul produselor);
  - jos: produsele (TS_GOODS) legate de denumirea aleasa, cu tipul lor.

  Tipul propus = tipul (WEBGOODSTYPE_ID) celor mai multe produse legate de
  denumire, fara tipul 1 "None" (umplutura, ~11 mii de produse); "Propus, %" = cit din produse au acest tip. Agregarea merge intr-o
  singura trecere prin TS_GOODS (FK_TS_GOODS_1); "+ 0" pe WEBGOODSTYPE_ID opreste
  folosirea indexului FK_TS_GOODS_7, cu el interogarea dura zeci de secunde.

  Actiuni (doar cu dreptul de modificare, dat de cel care deschide fereastra):
  tipul ales pentru denumirile selectate, tipul propus pentru cele selectate si
  completarea automata a denumirilor fara tip ale caror produse au toate acelasi tip.
}

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.UITypes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxDBData,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  cxTextEdit,
  cxLabel,
  cxCheckBox,
  Data.DB,
  DBAccess,
  IBC,
  MemDS,
  SWNBaseUnit;

type
  TfrmGoodsAcntTypesDlg = class(TSWNCustomForm)
    pnlTop: TPanel;
    lbSearch: TcxLabel;
    edSearch: TcxTextEdit;
    btnSearch: TButton;
    btnShowType: TButton;
    cbSearchGoods: TcxCheckBox;
    cbAllTypes: TcxCheckBox;
    lbMode: TcxLabel;
    pnlTypes: TPanel;
    cxGridTypes: TcxGrid;
    tvTypes: TcxGridDBTableView;
    tvTypesTITLE: TcxGridDBColumn;
    tvTypesN: TcxGridDBColumn;
    lvTypes: TcxGridLevel;
    splTypes: TSplitter;
    pnlRight: TPanel;
    cxGridItems: TcxGrid;
    tvItems: TcxGridDBTableView;
    tvItemsGOODS_ACNT_ID: TcxGridDBColumn;
    tvItemsNAMEACNT: TcxGridDBColumn;
    tvItemsPRICE_ACNT: TcxGridDBColumn;
    tvItemsFOLDER_NAME: TcxGridDBColumn;
    tvItemsTYPE_TITLE: TcxGridDBColumn;
    tvItemsN_GOODS: TcxGridDBColumn;
    tvItemsPROPOSED_TITLE: TcxGridDBColumn;
    tvItemsPROPOSED_SHARE: TcxGridDBColumn;
    tvItemsGOODS_TYPEID: TcxGridDBColumn;
    tvItemsPROPOSED_TYPEID: TcxGridDBColumn;
    tvItemsFLG_DIFF: TcxGridDBColumn;
    lvItems: TcxGridLevel;
    splGoods: TSplitter;
    cxGridGoods: TcxGrid;
    tvGoods: TcxGridDBTableView;
    tvGoodsGOODSID: TcxGridDBColumn;
    tvGoodsTITLE: TcxGridDBColumn;
    tvGoodsTYPE_TITLE: TcxGridDBColumn;
    lvGoods: TcxGridLevel;
    pnlBottom: TPanel;
    btnSetType: TButton;
    btnApplyProposed: TButton;
    btnAutoFill: TButton;
    lbHint: TcxLabel;
    btnClose: TButton;
    qTypes: TIBCQuery;
    dsTypes: TIBCDataSource;
    qItems: TIBCQuery;
    dsItems: TIBCDataSource;
    qGoods: TIBCQuery;
    dsGoods: TIBCDataSource;
    trWrite: TIBCTransaction;
    procedure dsTypesDataChange(Sender: TObject; Field: TField);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSearchClick(Sender: TObject);
    procedure btnShowTypeClick(Sender: TObject);
    procedure cbAllTypesPropertiesChange(Sender: TObject);
    procedure tvItemsPROPOSED_TITLECustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure tvItemsCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure btnSetTypeClick(Sender: TObject);
    procedure btnApplyProposedClick(Sender: TObject);
    procedure btnAutoFillClick(Sender: TObject);
  private
    FCanModify: Boolean;
    FSearchText: string;
    FLoading: Boolean;
    procedure OpenTypes(const LocateTypeID: Integer);
    procedure OpenItems(const LocateAcntID: Integer);
    procedure ReloadAll;
    procedure UpdateModeInfo;
    function CurrentTypeID: Integer;
    function SelectedIDs(const OnlyWithProposal: Boolean; out TypeIDs: TArray<Integer>): TArray<Integer>;
    procedure WriteTypes(const IDs, TypeIDs: TArray<Integer>);
  protected
    procedure Prepare; override;
  public
    // dreptul de a schimba tipul denumirilor (fara el fereastra e doar pentru vizualizare)
    property CanModify: Boolean read FCanModify write FCanModify;
  end;

procedure ShowGoodsAcntTypesDialog(const ACanModify: Boolean);

implementation

uses
  DataModuleDB,
  SWNDBErrors,
  SWNUtils,
  frmGoodsTypeDialog;

{$R *.dfm}

const
  cNoTypeID = -1; // rindul "(fara tip)" din lista tipurilor

procedure ShowGoodsAcntTypesDialog(const ACanModify: Boolean);
var
  d: TfrmGoodsAcntTypesDlg;
begin
  d := TfrmGoodsAcntTypesDlg.Create(nil);
  try
    d.CanModify := ACanModify;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

{ TfrmGoodsAcntTypesDlg }

procedure TfrmGoodsAcntTypesDlg.Prepare;
begin
  inherited;
  trWrite.DefaultConnection := dmDB.IBCConnection;
  qTypes.Connection := dmDB.IBCConnection;
  qItems.Connection := dmDB.IBCConnection;
  qGoods.Connection := dmDB.IBCConnection;

  btnSetType.Enabled := FCanModify;
  btnApplyProposed.Enabled := FCanModify;
  btnAutoFill.Enabled := FCanModify;

  FSearchText := '';
  OpenTypes(cNoTypeID);
  OpenItems(0);
  qGoods.Open;
  ActiveControl := edSearch;
end;

function TfrmGoodsAcntTypesDlg.CurrentTypeID: Integer;
begin
  if qTypes.Active and not qTypes.IsEmpty then
    Result := qTypes.FieldByName('GOODSTYPEID').AsInteger
  else
    Result := cNoTypeID;
end;

procedure TfrmGoodsAcntTypesDlg.OpenTypes(const LocateTypeID: Integer);
begin
  FLoading := True;
  try
    qTypes.Close;
    if cbAllTypes.Checked then
      qTypes.MacroByName('JOINKIND').Value := 'LEFT JOIN'
    else
      qTypes.MacroByName('JOINKIND').Value := 'JOIN';
    qTypes.Open;
    if not qTypes.Locate('GOODSTYPEID', LocateTypeID, []) then
      qTypes.First;
  finally
    FLoading := False;
  end;
end;

procedure TfrmGoodsAcntTypesDlg.OpenItems(const LocateAcntID: Integer);
var
  Cond, Txt: string;
  Code: Integer;
begin
  if FSearchText <> '' then
  begin
    // cautarea ignora tipul: denumirea (CONTAINING nu tine cont de majuscule), codul, optional produsele
    Txt := QuotedStr(FSearchText);
    Cond := 'A.NAMEACNT CONTAINING ' + Txt;
    if TryStrToInt(FSearchText, Code) then
      Cond := Cond + ' OR A.GOODS_ACNT_ID = ' + IntToStr(Code);
    if cbSearchGoods.Checked then
      Cond := Cond + ' OR EXISTS(SELECT 1 FROM TS_GOODS SG WHERE SG.GOODS_ACNT_ID = A.GOODS_ACNT_ID' +
        ' AND SG.TITLE CONTAINING ' + Txt + ')';
    Cond := 'AND (' + Cond + ')';
  end
  else if CurrentTypeID = cNoTypeID then
    Cond := 'AND A.GOODS_TYPEID IS NULL'
  else
    Cond := 'AND A.GOODS_TYPEID = ' + IntToStr(CurrentTypeID);

  qItems.DisableControls;
  try
    qItems.Close;
    qItems.MacroByName('COND').Value := Cond;
    qItems.Open;
    if LocateAcntID > 0 then
      qItems.Locate('GOODS_ACNT_ID', LocateAcntID, []);
  finally
    qItems.EnableControls;
  end;
  UpdateModeInfo;
end;

procedure TfrmGoodsAcntTypesDlg.ReloadAll;
var
  TypeID, AcntID: Integer;
begin
  TypeID := CurrentTypeID;
  AcntID := 0;
  if qItems.Active and not qItems.IsEmpty then
    AcntID := qItems.FieldByName('GOODS_ACNT_ID').AsInteger;
  OpenTypes(TypeID);
  OpenItems(AcntID);
end;

procedure TfrmGoodsAcntTypesDlg.UpdateModeInfo;
begin
  if FSearchText <> '' then
    lbMode.Caption := Format('Cautare "%s" in toate tipurile: %d denumiri', [FSearchText, qItems.RecordCount])
  else
    lbMode.Caption := Format('Tipul "%s": %d denumiri', [qTypes.FieldByName('TITLE').AsString, qItems.RecordCount]);
  btnShowType.Enabled := FSearchText <> '';
end;

procedure TfrmGoodsAcntTypesDlg.dsTypesDataChange(Sender: TObject; Field: TField);
begin
  // la schimbarea tipului se reincarca denumirile lui (nu si in timpul cautarii)
  if FLoading or (Field <> nil) or (FSearchText <> '') or not qItems.Active then
    Exit;
  OpenItems(0);
end;

procedure TfrmGoodsAcntTypesDlg.edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    btnSearchClick(nil);
  end
  else if (Key = VK_ESCAPE) and (FSearchText <> '') then
  begin
    Key := 0;
    btnShowTypeClick(nil);
  end;
end;

procedure TfrmGoodsAcntTypesDlg.btnSearchClick(Sender: TObject);
begin
  FSearchText := Trim(VarToStr(edSearch.EditValue));
  OpenItems(0);
end;

procedure TfrmGoodsAcntTypesDlg.btnShowTypeClick(Sender: TObject);
begin
  FSearchText := '';
  edSearch.EditValue := '';
  OpenItems(0);
end;

procedure TfrmGoodsAcntTypesDlg.cbAllTypesPropertiesChange(Sender: TObject);
begin
  if not qTypes.Active then
    Exit;
  OpenTypes(CurrentTypeID);
end;

procedure TfrmGoodsAcntTypesDlg.tvItemsPROPOSED_TITLECustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // tipul propus difera de cel actual: rosu daca denumirea are deja alt tip, albastru daca nu are tip
  if VarToStr(AViewInfo.GridRecord.Values[tvItemsFLG_DIFF.Index]) <> '1' then
    Exit;
  if VarIsNull(AViewInfo.GridRecord.Values[tvItemsGOODS_TYPEID.Index]) then
    ACanvas.Font.Color := clBlue
  else
    ACanvas.Font.Color := clRed;
end;

procedure TfrmGoodsAcntTypesDlg.tvItemsCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if btnSetType.Enabled then
  begin
    AHandled := True;
    btnSetTypeClick(nil);
  end;
end;

// Codurile denumirilor selectate in grila; OnlyWithProposal = doar cele cu tip propus diferit de cel actual,
// iar TypeIDs primeste tipul propus al fiecareia.
function TfrmGoodsAcntTypesDlg.SelectedIDs(const OnlyWithProposal: Boolean; out TypeIDs: TArray<Integer>): TArray<Integer>;
var
  I, N: Integer;
  Rec: TcxCustomGridRecord;
begin
  SetLength(Result, tvItems.Controller.SelectedRecordCount);
  SetLength(TypeIDs, tvItems.Controller.SelectedRecordCount);
  N := 0;
  for I := 0 to tvItems.Controller.SelectedRecordCount - 1 do
  begin
    Rec := tvItems.Controller.SelectedRecords[I];
    if OnlyWithProposal and (VarToStr(Rec.Values[tvItemsFLG_DIFF.Index]) <> '1') then
      Continue;
    Result[N] := Rec.Values[tvItemsGOODS_ACNT_ID.Index];
    if OnlyWithProposal then
      TypeIDs[N] := Rec.Values[tvItemsPROPOSED_TYPEID.Index]
    else
      TypeIDs[N] := 0;
    Inc(N);
  end;
  SetLength(Result, N);
  SetLength(TypeIDs, N);
end;

procedure TfrmGoodsAcntTypesDlg.WriteTypes(const IDs, TypeIDs: TArray<Integer>);
var
  q: TIBCQuery;
  I: Integer;
begin
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.Transaction := trWrite;
    q.AutoCommit := False;
    q.SQL.Text := 'UPDATE TS_GOODS_ACNT SET GOODS_TYPEID = :GOODS_TYPEID WHERE GOODS_ACNT_ID = :GOODS_ACNT_ID';
    trWrite.StartTransaction;
    try
      for I := 0 to High(IDs) do
      begin
        q.ParamByName('GOODS_TYPEID').AsInteger := TypeIDs[I];
        q.ParamByName('GOODS_ACNT_ID').AsInteger := IDs[I];
        q.ExecSQL;
      end;
      trWrite.Commit;
    except
      trWrite.Rollback;
      raise;
    end;
  finally
    q.Free;
  end;
  ReloadAll;
end;

procedure TfrmGoodsAcntTypesDlg.btnSetTypeClick(Sender: TObject);
var
  IDs, TypeIDs: TArray<Integer>;
  dialog: TfrmGoodsTypeDlg;
  NewTypeID, I, DefaultTypeID: Integer;
  NewTypeTitle: string;
begin
  IDs := SelectedIDs(False, TypeIDs);
  if Length(IDs) = 0 then
  begin
    ShowInfoDialog('Tipul produsului', 'Selectati cel putin o denumire de contabilitate.');
    Exit;
  end;

  // tipul propus al denumirii curente, altfel tipul ei actual
  DefaultTypeID := qItems.FieldByName('PROPOSED_TYPEID').AsInteger;
  if not qItems.FieldByName('GOODS_TYPEID').IsNull then
    DefaultTypeID := qItems.FieldByName('GOODS_TYPEID').AsInteger;
  NewTypeID := 0;
  dialog := TfrmGoodsTypeDlg.Create(Self);
  try
    if dialog.SelectGoodsType(DefaultTypeID) then
    begin
      NewTypeID := dialog.GoodsTypeID;
      NewTypeTitle := dialog.GoodsTypeTitle;
    end;
  finally
    dialog.Free;
  end;
  if NewTypeID <= 0 then
    Exit;

  if (Length(IDs) > 1) and (ShowAskDialog('Tipul produsului',
    Format('Atribuiti tipul "%s" la %d denumiri selectate?', [NewTypeTitle, Length(IDs)])) <> mrYes) then
    Exit;

  for I := 0 to High(TypeIDs) do
    TypeIDs[I] := NewTypeID;
  try
    WriteTypes(IDs, TypeIDs);
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmGoodsAcntTypesDlg.btnApplyProposedClick(Sender: TObject);
var
  IDs, TypeIDs: TArray<Integer>;
begin
  IDs := SelectedIDs(True, TypeIDs);
  if Length(IDs) = 0 then
  begin
    ShowInfoDialog('Tipul produsului', 'Printre denumirile selectate nu e niciuna cu tip propus diferit de cel actual.');
    Exit;
  end;
  if ShowAskDialog('Tipul produsului',
    Format('Atribuiti tipul propus la %d denumiri selectate?', [Length(IDs)])) <> mrYes then
    Exit;
  try
    WriteTypes(IDs, TypeIDs);
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmGoodsAcntTypesDlg.btnAutoFillClick(Sender: TObject);
const
  // denumirile fara tip ale caror produse au toate acelasi tip
  cSure =
    '(SELECT P.GOODS_ACNT_ID, P.T_BEST FROM (' +
    '  SELECT X.GOODS_ACNT_ID, SUM(X.N) TOT,' +
    '         CAST(SUBSTRING(MAX(LPAD(X.N, 9, ''0'') || LPAD(X.T, 9, ''0'')) FROM 1 FOR 9) AS INTEGER) N_BEST,' +
    '         CAST(SUBSTRING(MAX(LPAD(X.N, 9, ''0'') || LPAD(X.T, 9, ''0'')) FROM 10 FOR 9) AS INTEGER) T_BEST' +
    '  FROM (SELECT G.GOODS_ACNT_ID, G.WEBGOODSTYPE_ID T, COUNT(*) N FROM TS_GOODS G' +
    '        WHERE G.GOODS_ACNT_ID > 0 AND G.WEBGOODSTYPE_ID + 0 > 1' +
    '        GROUP BY G.GOODS_ACNT_ID, G.WEBGOODSTYPE_ID) X' +
    '  GROUP BY X.GOODS_ACNT_ID) P' +
    ' WHERE P.N_BEST = P.TOT) S';
var
  q: TIBCQuery;
  N: Integer;
begin
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.SQL.Text := 'SELECT COUNT(*) FROM ' + cSure +
      ' JOIN TS_GOODS_ACNT A ON A.GOODS_ACNT_ID = S.GOODS_ACNT_ID' +
      ' WHERE A.GOODS_TYPEID IS NULL AND COALESCE(A.FLG_FOLDER, 0) = 0';
    q.Open;
    N := q.Fields[0].AsInteger;
    q.Close;
    if N = 0 then
    begin
      ShowInfoDialog('Completare automata', 'Nu sint denumiri fara tip ale caror produse sa aiba toate acelasi tip.');
      Exit;
    end;
    if ShowAskDialog('Completare automata',
      Format('%d denumiri fara tip au toate produsele de acelasi tip.', [N]),
      'Atribuiti-le acest tip? Celelalte (produse de tipuri diferite sau fara produse) raman pentru verificare.') <> mrYes then
      Exit;

    q.Transaction := trWrite;
    q.AutoCommit := False;
    q.SQL.Text := 'MERGE INTO TS_GOODS_ACNT A USING ' + cSure + ' ON A.GOODS_ACNT_ID = S.GOODS_ACNT_ID' +
      ' WHEN MATCHED AND A.GOODS_TYPEID IS NULL AND COALESCE(A.FLG_FOLDER, 0) = 0 THEN' +
      ' UPDATE SET GOODS_TYPEID = S.T_BEST';
    trWrite.StartTransaction;
    try
      q.ExecSQL;
      N := q.RowsAffected;
      trWrite.Commit;
    except
      on E: Exception do
      begin
        trWrite.Rollback;
        if not ProcessSWNError(E) then
          raise;
        Exit;
      end;
    end;
  finally
    q.Free;
  end;
  ReloadAll;
  ShowInfoDialog('Completare automata', Format('Tipul a fost atribuit la %d denumiri.', [N]));
end;

end.
