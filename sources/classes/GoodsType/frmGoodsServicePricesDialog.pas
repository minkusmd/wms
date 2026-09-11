unit frmGoodsServicePricesDialog;

(* ============================================================================
  PRETURI PE PRODUSE pentru un serviciu adiacent.

  Toate produsele unui tip (TS_GOODS.WEBGOODSTYPE_ID), cu starea serviciului pe
  fiecare. Cazul tipic: montajul mobilierului costa diferit dupa dimensiune
  (dulap 1.5 m = 500 lei, dulap 2 m = 1200 lei). Cu filtrul din grila si
  "Aplica la randurile vizibile" se seteaza acelasi pret pe multe produse odata.

  Coloane editabile:
    - "Are serviciul": bifat = serviciul se propune la produs;
    - "Pret, MDL" si "+ %": pret propriu al produsului (gol = pretul regulii
      tipului, altfel pretul din nomenclator).
  La OK se scriu doar randurile modificate, ca reguli TS_GOODS_SERVICE pe
  GOODSID (UPDATE OR INSERT ... MATCHING). Randul debifat primeste
  FLG_DISABLED = 1 daca tipul are regula pentru serviciu, altfel regula lui se
  sterge. Preturile introduse aici sunt in MDL.

  Scrie in tranzactia primita (Transaction) si NU face commit: il face managerul
  pe tip la OK, deci "Renunta" acolo anuleaza si aceste modificari.
  Grila e nelegata (unbound): datele se incarca/scriu explicit.
  ============================================================================ *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS, Vcl.Menus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxGridCustomTableView, cxGridTableView, cxGridLevel, cxGridCustomView, cxGrid, cxButtons,
  dxScrollbarAnnotations, dxDateRanges, cxTextEdit, cxMaskEdit, cxButtonEdit, cxCheckBox,
  cxCurrencyEdit;

type
  TfrmGoodsServicePricesDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    pnTop: TPanel;
    lbService: TLabel;
    beService: TcxButtonEdit;
    lbTypeRule: TLabel;
    lbFill: TLabel;
    edFillPrice: TcxTextEdit;
    btnFill: TcxButton;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    cxGridLevel: TcxGridLevel;
    colGoodsID: TcxGridColumn;
    colTitle: TcxGridColumn;
    colGoodsPrice: TcxGridColumn;
    colActive: TcxGridColumn;
    colPrice: TcxGridColumn;
    colPercent: TcxGridColumn;
    colHasRule: TcxGridColumn;
    colOrigActive: TcxGridColumn;
    colOrigPrice: TcxGridColumn;
    colOrigPercent: TcxGridColumn;
    pnBottom: TPanel;
    lbCount: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure beServicePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnFillClick(Sender: TObject);
  private
    FGoodsTypeID: Integer;
    FServiceGoodsID: Integer;
    FTransaction: TIBCTransaction;
    FTypeRuleExists: Boolean;
    function NewQuery: TIBCQuery;
    procedure ShowServiceInfo;
    procedure LoadRows;
    function RowChanged(const ARec: Integer): Boolean;
    function HasChanges: Boolean;
    function ValidateRows: Boolean;
    procedure SaveRows;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    property Transaction: TIBCTransaction read FTransaction write FTransaction;
    property GoodsTypeID: Integer read FGoodsTypeID write FGoodsTypeID;
    { serviciul presetat (0 = se alege in dialog) }
    property ServiceGoodsID: Integer read FServiceGoodsID write FServiceGoodsID;
  end;

implementation

uses
  SWNUtils, SWNDBErrors, DataModuleDB, System.UITypes, frmGoods,
  frmGoodsServiceEditorDialog;

{$R *.dfm}

function IsNullVar(const V: Variant): Boolean;
begin
  Result := VarIsNull(V) or VarIsEmpty(V);
end;

function VarToBool(const V: Variant): Boolean;
begin
  Result := (not IsNullVar(V)) and (V = True);
end;

function SameOptFloat(const A, B: Variant): Boolean;
begin
  if IsNullVar(A) or IsNullVar(B) then
    Result := IsNullVar(A) and IsNullVar(B)
  else
    Result := Abs(Double(A) - Double(B)) < 0.005;
end;

procedure SetFloatParam(const P: TDAParam; const V: Variant);
begin
  P.DataType := ftFloat;
  if IsNullVar(V) then
    P.Clear
  else
    P.AsFloat := V;
end;

{ TfrmGoodsServicePricesDlg }

function TfrmGoodsServicePricesDlg.NewQuery: TIBCQuery;
begin
  if not FTransaction.Active then
    FTransaction.StartTransaction;
  Result := TIBCQuery.Create(nil);
  Result.Connection := dmDB.IBCConnection;
  Result.Transaction := FTransaction;
  Result.UpdateTransaction := FTransaction;
  Result.AutoCommit := False;
end;

procedure TfrmGoodsServicePricesDlg.Prepare;
begin
  if FTransaction = nil then
    raise Exception.Create('TfrmGoodsServicePricesDlg: lipseste tranzactia.');
  DialogTitle1.Text := 'Pretul serviciului pe fiecare produs al tipului #' + IntToStr(FGoodsTypeID);
  ShowServiceInfo;
  LoadRows;
end;

{ Denumirea serviciului + regula tipului pentru el (daca exista). }
procedure TfrmGoodsServicePricesDlg.ShowServiceInfo;
var
  q: TIBCQuery;
  s: string;
begin
  beService.Text := '';
  lbTypeRule.Caption := 'Alegeti serviciul.';
  FTypeRuleExists := False;
  if FServiceGoodsID <= 0 then
    Exit;

  q := NewQuery;
  try
    q.SQL.Text :=
      'SELECT g.TITLE, s.GSID, s.PRICE, s.PRICE_PERCENT, ' +
      '       (SELECT c.TITLE FROM TS_CURRENCY c WHERE c.CURRENCYID = s.CURRENCYID) AS CUR_TITLE ' +
      '  FROM TS_GOODS g ' +
      '  LEFT JOIN TS_GOODS_SERVICE s ' +
      '         ON s.SERVICE_GOODSID = g.GOODSID AND s.GOODSTYPEID = :gtid ' +
      ' WHERE g.GOODSID = :sid';
    q.ParamByName('gtid').AsInteger := FGoodsTypeID;
    q.ParamByName('sid').AsInteger := FServiceGoodsID;
    q.Open;
    beService.Text := q.FieldByName('TITLE').AsString;
    FTypeRuleExists := not q.FieldByName('GSID').IsNull;
    if FTypeRuleExists then
    begin
      if q.FieldByName('PRICE').IsNull then
        s := 'pretul din nomenclator'
      else
        s := FormatFloat('0.00', q.FieldByName('PRICE').AsFloat) + ' ' +
          q.FieldByName('CUR_TITLE').AsString;
      if (not q.FieldByName('PRICE_PERCENT').IsNull) and (q.FieldByName('PRICE_PERCENT').AsFloat <> 0) then
        s := s + ' + ' + FormatFloat('0.##', q.FieldByName('PRICE_PERCENT').AsFloat) + '%';
      lbTypeRule.Caption := 'Regula tipului: ' + s +
        '. Se aplica produselor bifate fara pret propriu.';
    end
    else
      lbTypeRule.Caption := 'Tipul nu are regula pentru acest serviciu: il primesc doar ' +
        'produsele bifate aici (fara pret propriu = pretul din nomenclator).';
  finally
    q.Free;
  end;
end;

procedure TfrmGoodsServicePricesDlg.LoadRows;
var
  q: TIBCQuery;
  dc: TcxCustomDataController;
  r: Integer;
  active: Boolean;
begin
  dc := cxGridTable.DataController;
  dc.BeginUpdate;
  try
    dc.RecordCount := 0;
    if FServiceGoodsID <= 0 then
      Exit;

    q := NewQuery;
    try
      q.SQL.Text :=
        'SELECT g.GOODSID, g.TITLE, gp.PRICE1 AS GOODS_PRICE, ' +
        '       s.GSID, s.PRICE, s.PRICE_PERCENT, s.FLG_DISABLED ' +
        '  FROM TS_GOODS g ' +
        '  LEFT JOIN TS_GOODS_PRICE gp ON gp.GOODSID = g.GOODSID ' +
        '  LEFT JOIN TS_GOODS_SERVICE s ' +
        '         ON s.GOODSID = g.GOODSID AND s.SERVICE_GOODSID = :sid ' +
        ' WHERE g.WEBGOODSTYPE_ID = :gtid AND COALESCE(g.FLG_FOLDER, 0) = 0 ' +
        ' ORDER BY g.TITLE';
      q.ParamByName('sid').AsInteger := FServiceGoodsID;
      q.ParamByName('gtid').AsInteger := FGoodsTypeID;
      q.Open;
      while not q.Eof do
      begin
        r := dc.AppendRecord;
        dc.Values[r, colGoodsID.Index] := q.FieldByName('GOODSID').AsInteger;
        dc.Values[r, colTitle.Index] := q.FieldByName('TITLE').AsString;
        if q.FieldByName('GOODS_PRICE').IsNull then
          dc.Values[r, colGoodsPrice.Index] := Null
        else
          dc.Values[r, colGoodsPrice.Index] := q.FieldByName('GOODS_PRICE').AsFloat;

        dc.Values[r, colHasRule.Index] := not q.FieldByName('GSID').IsNull;
        if q.FieldByName('GSID').IsNull then
          active := FTypeRuleExists
        else
          active := q.FieldByName('FLG_DISABLED').AsInteger <> 1;
        dc.Values[r, colActive.Index] := active;
        dc.Values[r, colOrigActive.Index] := active;

        if q.FieldByName('PRICE').IsNull then
          dc.Values[r, colPrice.Index] := Null
        else
          dc.Values[r, colPrice.Index] := q.FieldByName('PRICE').AsFloat;
        dc.Values[r, colOrigPrice.Index] := dc.Values[r, colPrice.Index];

        if q.FieldByName('PRICE_PERCENT').IsNull then
          dc.Values[r, colPercent.Index] := Null
        else
          dc.Values[r, colPercent.Index] := q.FieldByName('PRICE_PERCENT').AsFloat;
        dc.Values[r, colOrigPercent.Index] := dc.Values[r, colPercent.Index];
        q.Next;
      end;
    finally
      q.Free;
    end;
  finally
    dc.EndUpdate;
  end;
  lbCount.Caption := Format('Produse de acest tip: %d', [dc.RecordCount]);
end;

procedure TfrmGoodsServicePricesDlg.beServicePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  d: TfrmGoodsBrowser;
  startId: Integer;
begin
  if HasChanges and (MessageDlg('Modificarile facute pentru serviciul curent se pierd. Continuati?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
    Exit;
  if FServiceGoodsID > 0 then
    startId := FServiceGoodsID
  else
    startId := cServicesFolderGoodsID;
  d := TfrmGoodsBrowser.Create(Self);
  try
    if d.SelectGoods(startId, False, 0, 'Alegeti serviciul') and not d.GoodsIsFolder then
    begin
      FServiceGoodsID := d.GoodsID;
      ShowServiceInfo;
      LoadRows;
    end;
  finally
    d.Free;
  end;
end;

{ Seteaza pretul pe toate randurile VIZIBILE (dupa filtrul grilei). Camp gol =
  sterge pretul propriu (randul revine la regula tipului / nomenclator). }
procedure TfrmGoodsServicePricesDlg.btnFillClick(Sender: TObject);
var
  hasValue: Boolean;
  v: Double;
  i, rec: Integer;
  dc: TcxCustomDataController;
begin
  if not ParseOptionalFloat(edFillPrice.Text, hasValue, v) or (hasValue and (v < 0)) then
  begin
    ShowMessage('Pretul nu este un numar valid.');
    Exit;
  end;
  dc := cxGridTable.DataController;
  if cxGridTable.ViewData.RowCount = 0 then
    Exit;
  if MessageDlg(Format('Setati pretul pentru %d randuri vizibile?', [cxGridTable.ViewData.RowCount]),
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  dc.BeginUpdate;
  try
    for i := 0 to cxGridTable.ViewData.RowCount - 1 do
    begin
      rec := cxGridTable.ViewData.Rows[i].RecordIndex;
      if rec < 0 then
        Continue; { rand de grupare }
      if hasValue then
      begin
        dc.Values[rec, colPrice.Index] := v;
        dc.Values[rec, colActive.Index] := True;
      end
      else
        dc.Values[rec, colPrice.Index] := Null;
    end;
  finally
    dc.EndUpdate;
  end;
end;

function TfrmGoodsServicePricesDlg.RowChanged(const ARec: Integer): Boolean;
var
  dc: TcxCustomDataController;
begin
  dc := cxGridTable.DataController;
  Result := (VarToBool(dc.Values[ARec, colActive.Index]) <> VarToBool(dc.Values[ARec, colOrigActive.Index])) or
    not SameOptFloat(dc.Values[ARec, colPrice.Index], dc.Values[ARec, colOrigPrice.Index]) or
    not SameOptFloat(dc.Values[ARec, colPercent.Index], dc.Values[ARec, colOrigPercent.Index]);
end;

function TfrmGoodsServicePricesDlg.HasChanges: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to cxGridTable.DataController.RecordCount - 1 do
    if RowChanged(i) then
      Exit(True);
end;

function TfrmGoodsServicePricesDlg.ValidateRows: Boolean;
var
  i: Integer;
  dc: TcxCustomDataController;
  v: Variant;
begin
  Result := True;
  dc := cxGridTable.DataController;
  for i := 0 to dc.RecordCount - 1 do
  begin
    v := dc.Values[i, colPrice.Index];
    if (not IsNullVar(v)) and (Double(v) < 0) then
      Result := False;
    v := dc.Values[i, colPercent.Index];
    if (not IsNullVar(v)) and ((Double(v) < 0) or (Double(v) > 1000)) then
      Result := False;
    if not Result then
    begin
      ShowMessage(Format('Valoare invalida la produsul [%s]: pretul nu poate fi negativ, ' +
        'procentul trebuie sa fie intre 0 si 1000.', [VarToStr(dc.Values[i, colTitle.Index])]));
      Exit;
    end;
  end;
end;

procedure TfrmGoodsServicePricesDlg.SaveRows;
var
  i: Integer;
  dc: TcxCustomDataController;
  qUpsert, qDelete: TIBCQuery;
  gid: Integer;
  active, hasRule, hasPrice: Boolean;
  price, pct: Variant;

  procedure Upsert(const APrice, APct: Variant; const ADisabled: Integer);
  begin
    qUpsert.ParamByName('gid').AsInteger := gid;
    qUpsert.ParamByName('sid').AsInteger := FServiceGoodsID;
    SetFloatParam(qUpsert.ParamByName('price'), APrice);
    qUpsert.ParamByName('cur').DataType := ftInteger;
    if IsNullVar(APrice) then
      qUpsert.ParamByName('cur').Clear
    else
      qUpsert.ParamByName('cur').AsInteger := 498;
    SetFloatParam(qUpsert.ParamByName('pct'), APct);
    qUpsert.ParamByName('dis').AsInteger := ADisabled;
    qUpsert.Execute;
  end;

  procedure DeleteRule;
  begin
    qDelete.ParamByName('gid').AsInteger := gid;
    qDelete.ParamByName('sid').AsInteger := FServiceGoodsID;
    qDelete.Execute;
  end;

begin
  dc := cxGridTable.DataController;
  qUpsert := NewQuery;
  qDelete := NewQuery;
  try
    qUpsert.SQL.Text :=
      'UPDATE OR INSERT INTO TS_GOODS_SERVICE ' +
      '  (GOODSID, SERVICE_GOODSID, PRICE, CURRENCYID, PRICE_PERCENT, FLG_DISABLED) ' +
      'VALUES (:gid, :sid, :price, :cur, :pct, :dis) ' +
      'MATCHING (GOODSID, SERVICE_GOODSID)';
    qDelete.SQL.Text :=
      'DELETE FROM TS_GOODS_SERVICE WHERE GOODSID = :gid AND SERVICE_GOODSID = :sid';

    for i := 0 to dc.RecordCount - 1 do
    begin
      if not RowChanged(i) then
        Continue;
      gid := dc.Values[i, colGoodsID.Index];
      hasRule := VarToBool(dc.Values[i, colHasRule.Index]);
      price := dc.Values[i, colPrice.Index];
      pct := dc.Values[i, colPercent.Index];
      hasPrice := not (IsNullVar(price) and IsNullVar(pct));
      { un pret introdus inseamna ca produsul are serviciul }
      active := VarToBool(dc.Values[i, colActive.Index]) or hasPrice;

      if not active then
      begin
        if FTypeRuleExists then
          Upsert(Null, Null, 1)      { ascunde serviciul mostenit de la tip }
        else if hasRule then
          DeleteRule;
      end
      else if hasPrice then
        Upsert(price, pct, 0)        { pret propriu }
      else if FTypeRuleExists then
      begin
        if hasRule then
          DeleteRule;                { revine la regula tipului }
      end
      else
        Upsert(Null, Null, 0);       { fara regula pe tip: pretul din nomenclator }
    end;
  finally
    qUpsert.Free;
    qDelete.Free;
  end;
end;

function TfrmGoodsServicePricesDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  { editorul de celula deschis -> valoarea lui intra in DataController }
  cxGridTable.DataController.PostEditingData;
  if FServiceGoodsID <= 0 then
  begin
    ShowMessage('Alegeti serviciul.');
    Exit;
  end;
  if not ValidateRows then
    Exit;
  try
    SaveRows;
  except
    on e: Exception do
    begin
      if not ProcessSWNError(e) then
        MessageDlg('Preturile nu au fost salvate:' + #13#10 + e.Message, mtError, [mbOK], 0);
      Exit;
    end;
  end;
  Result := True;
end;

end.
