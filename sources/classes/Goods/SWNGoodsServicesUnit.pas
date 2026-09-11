unit SWNGoodsServicesUnit;

(* ============================================================================
  SERVICII ADIACENTE in documentele de vanzare (TS_GOODS_SERVICE).

  Apelat din frame-urile documentelor de vanzare, DUPA ce dialogul de adaugare
  a salvat linia produsului:
    - OfferGoodsServices   : propune serviciile produsului (SP_GET_GOODS_SERVICES)
                             si insereaza liniile bifate in TDB_JURNAL;
    - DeleteLinkedServices : dupa stergerea unui produs, propune stergerea
                             liniilor de serviciu legate de el.

  Linia de serviciu e o linie NORMALA TDB_JURNAL (factura, bon, rapoarte), cu
  TDB_JURNAL.SERVICE_FOR_GOODSID = produsul caruia ii apartine. Pretul vine din
  SP_GET_GOODS_SERVICES, in moneda documentului, pe coloana de pret a liniei
  produsului; procentele se aplica la pretul produsului din document.
  PK-ul TDB_JURNAL nu permite acelasi serviciu de doua ori pe document: daca
  serviciul exista deja, se cumuleaza cantitatea (pret = media ponderata) si
  legatura ramane la primul produs.

  Totul e inactiv pana cand DB Model\goods_services.sql e rulat pe baza
  (GoodsServicesAvailable). Verificarea se face o singura data pe sesiune.
  Tranzactie proprie: Commit la final, Rollback la eroare.
  ============================================================================ *)

interface

{ True daca baza are schema serviciilor adiacente (coloana + procedura). }
function GoodsServicesAvailable: Boolean;

{ Dupa adaugarea produsului AGoodsID in documentul ADocID. True daca s-a
  adaugat cel putin o linie de serviciu (documentul trebuie reincarcat). }
function OfferGoodsServices(const ADocID, AGoodsID: Integer): Boolean;

{ Dupa stergerea produsului AGoodsID din documentul ADocID. True daca s-au
  sters linii de serviciu legate de el. }
function DeleteLinkedServices(const ADocID, AGoodsID: Integer): Boolean;

implementation

uses
  System.SysUtils, System.Variants, System.Classes, System.UITypes, Vcl.Forms, Vcl.Controls,
  Vcl.Dialogs, Data.DB, DBAccess, IBC, MemDS, DataModuleDB, SWNDBErrors,
  frmSelectGoodsServicesDialog;

var
  { -1 = neverificat, 0 = schema lipseste, 1 = schema exista }
  GAvailability: Integer = -1;

function NewQuery(const ATr: TIBCTransaction): TIBCQuery;
begin
  Result := TIBCQuery.Create(nil);
  Result.Connection := dmDB.IBCConnection;
  Result.Transaction := ATr;
  Result.UpdateTransaction := ATr;
  Result.AutoCommit := False;
end;

function NewTransaction: TIBCTransaction;
begin
  Result := TIBCTransaction.Create(nil);
  Result.DefaultConnection := dmDB.IBCConnection;
end;

function GoodsServicesAvailable: Boolean;
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
        '  (SELECT COUNT(*) FROM RDB$RELATION_FIELDS ' +
        '    WHERE RDB$RELATION_NAME = ''TDB_JURNAL'' ' +
        '      AND RDB$FIELD_NAME = ''SERVICE_FOR_GOODSID'') AS C_FIELD, ' +
        '  (SELECT COUNT(*) FROM RDB$PROCEDURES ' +
        '    WHERE RDB$PROCEDURE_NAME = ''SP_GET_GOODS_SERVICES'') AS C_PROC ' +
        'FROM RDB$DATABASE';
      try
        q.Open;
        if (q.FieldByName('C_FIELD').AsInteger > 0) and (q.FieldByName('C_PROC').AsInteger > 0) then
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

function DialogOwner: TComponent;
begin
  if Screen.ActiveForm <> nil then
    Result := Screen.ActiveForm
  else
    Result := Application;
end;

function OfferGoodsServices(const ADocID, AGoodsID: Integer): Boolean;
var
  tr: TIBCTransaction;
  q, qLine: TIBCQuery;
  d: TfrmSelectGoodsServicesDlg;
  dtdep, ctdep, priceColumn, lineFlags, i: Integer;
  qty, goodsPrice, oldQty, oldPrice, newQty: Double;
  currencyID: Integer;
  goodsTitle, currencyTitle: string;
begin
  Result := False;
  if (ADocID <= 0) or (AGoodsID <= 0) or not GoodsServicesAvailable then
    Exit;

  tr := NewTransaction;
  q := NewQuery(tr);
  qLine := NewQuery(tr);
  d := nil;
  try
    try
      tr.StartTransaction;

      { linia produsului (nivel superior, nu componenta de complect) + documentul }
      q.SQL.Text :=
        'SELECT FIRST 1 j.DTDEP, j.CTDEP, j.QTY, j.PRICE, j.PRICE_COLUMN, j.FLAGS, ' +
        '       d.CURRENCYID, g.TITLE, ' +
        '       (SELECT c.TITLE FROM TS_CURRENCY c WHERE c.CURRENCYID = d.CURRENCYID) AS CUR_TITLE ' +
        '  FROM TDB_JURNAL j ' +
        '  JOIN TDB_DOCS d ON d.DOCID = j.DOCID ' +
        '  JOIN TS_GOODS g ON g.GOODSID = j.GOODSID ' +
        ' WHERE j.DOCID = :docid AND j.GOODSID = :gid AND j.GOODSCOMPLECT_ID = -1';
      q.ParamByName('docid').AsInteger := ADocID;
      q.ParamByName('gid').AsInteger := AGoodsID;
      q.Open;
      if q.IsEmpty then
        Exit;
      dtdep := q.FieldByName('DTDEP').AsInteger;
      ctdep := q.FieldByName('CTDEP').AsInteger;
      qty := q.FieldByName('QTY').AsFloat;
      if qty <= 0 then
        qty := 1;
      goodsPrice := q.FieldByName('PRICE').AsFloat;
      if q.FieldByName('PRICE_COLUMN').IsNull or (q.FieldByName('PRICE_COLUMN').AsInteger <= 0) then
        priceColumn := 1
      else
        priceColumn := q.FieldByName('PRICE_COLUMN').AsInteger;
      lineFlags := q.FieldByName('FLAGS').AsInteger;
      if q.FieldByName('CURRENCYID').IsNull then
        currencyID := 498
      else
        currencyID := q.FieldByName('CURRENCYID').AsInteger;
      goodsTitle := q.FieldByName('TITLE').AsString;
      currencyTitle := q.FieldByName('CUR_TITLE').AsString;
      q.Close;

      { serviciile propuse pentru produs, cu pretul in moneda documentului }
      q.SQL.Text :=
        'SELECT s.SERVICE_GOODSID, s.TITLE, s.UMID, s.PRICE, s.FLG_DEFAULT, s.FLG_REQUIRED ' +
        '  FROM SP_GET_GOODS_SERVICES(:gid, :pc, :cur, :price) s ' +
        ' ORDER BY s.ORDERNO, s.TITLE';
      q.ParamByName('gid').AsInteger := AGoodsID;
      q.ParamByName('pc').AsInteger := priceColumn;
      q.ParamByName('cur').AsInteger := currencyID;
      q.ParamByName('price').AsFloat := goodsPrice;
      q.Open;
      if q.IsEmpty then
        Exit;

      d := TfrmSelectGoodsServicesDlg.Create(DialogOwner);
      d.GoodsTitle := goodsTitle;
      d.CurrencyTitle := currencyTitle;
      d.Qty := qty;
      while not q.Eof do
      begin
        d.AddService(q.FieldByName('SERVICE_GOODSID').AsInteger, q.FieldByName('UMID').AsInteger,
          q.FieldByName('TITLE').AsString, q.FieldByName('PRICE').AsFloat,
          q.FieldByName('FLG_DEFAULT').AsInteger = 1, q.FieldByName('FLG_REQUIRED').AsInteger = 1);
        q.Next;
      end;
      q.Close;

      if d.ShowModal <> mrOk then
        Exit;

      for i := 0 to d.ServiceCount - 1 do
      begin
        if not d.IsSelected(i) then
          Continue;

        { serviciul exista deja in document? -> cumulam (PK TDB_JURNAL) }
        qLine.SQL.Text :=
          'SELECT QTY, PRICE FROM TDB_JURNAL ' +
          ' WHERE DOCID = :docid AND DTDEP = :dtdep AND CTDEP = :ctdep ' +
          '   AND GOODSCOMPLECT_ID = -1 AND GOODSID = :sid';
        qLine.ParamByName('docid').AsInteger := ADocID;
        qLine.ParamByName('dtdep').AsInteger := dtdep;
        qLine.ParamByName('ctdep').AsInteger := ctdep;
        qLine.ParamByName('sid').AsInteger := d.ServiceID(i);
        qLine.Open;
        if not qLine.IsEmpty then
        begin
          oldQty := qLine.FieldByName('QTY').AsFloat;
          oldPrice := qLine.FieldByName('PRICE').AsFloat;
          qLine.Close;
          newQty := oldQty + qty;
          { SUMA / SUMAVAT / COST le recalculeaza TRG_TDB_JURNAL_BU }
          qLine.SQL.Text :=
            'UPDATE TDB_JURNAL SET QTY = :qty, PRICE = :price ' +
            ' WHERE DOCID = :docid AND DTDEP = :dtdep AND CTDEP = :ctdep ' +
            '   AND GOODSCOMPLECT_ID = -1 AND GOODSID = :sid';
          qLine.ParamByName('qty').AsFloat := newQty;
          qLine.ParamByName('price').AsFloat := Round((oldPrice * oldQty + d.Price(i) * qty) / newQty * 100) / 100;
        end
        else
        begin
          qLine.Close;
          { SUMA / SUMAVAT / COST / STOCK_QTY le calculeaza TRG_TDB_JURNAL_BI }
          qLine.SQL.Text :=
            'INSERT INTO TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, ' +
            '  QTY, PRICE, SUMA, SUMAVAT, COST, WARRANTY, STOCK_QTY, PRICE_COLUMN, FLAGS, ' +
            '  SERVICE_FOR_GOODSID) ' +
            'VALUES (:docid, :dtdep, :ctdep, -1, :sid, :umid, ' +
            '  :qty, :price, 0, 0, 0, 0, 0, :pc, :flags, :forgid)';
          qLine.ParamByName('umid').AsInteger := d.UMID(i);
          qLine.ParamByName('qty').AsFloat := qty;
          qLine.ParamByName('price').AsFloat := d.Price(i);
          qLine.ParamByName('pc').AsInteger := priceColumn;
          { FLG_ACTIVE (bit 0) + FLG_ACNT (bit 1) copiat de pe linia produsului,
            ca in dialogul de adaugare a produselor }
          qLine.ParamByName('flags').AsInteger := 1 or (lineFlags and 2);
          qLine.ParamByName('forgid').AsInteger := AGoodsID;
        end;
        qLine.ParamByName('docid').AsInteger := ADocID;
        qLine.ParamByName('dtdep').AsInteger := dtdep;
        qLine.ParamByName('ctdep').AsInteger := ctdep;
        qLine.ParamByName('sid').AsInteger := d.ServiceID(i);
        qLine.Execute;
        Result := True;
      end;

      tr.Commit;
    except
      on e: Exception do
      begin
        Result := False;
        if tr.Active then
          tr.Rollback;
        if not ProcessSWNError(e) then
          MessageDlg('Serviciile nu au fost adaugate:' + #13#10 + e.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    if tr.Active then
      tr.Rollback;
    d.Free;
    qLine.Free;
    q.Free;
    tr.Free;
  end;
end;

function DeleteLinkedServices(const ADocID, AGoodsID: Integer): Boolean;
var
  tr: TIBCTransaction;
  q: TIBCQuery;
  list: string;
begin
  Result := False;
  if (ADocID <= 0) or (AGoodsID <= 0) or not GoodsServicesAvailable then
    Exit;

  tr := NewTransaction;
  q := NewQuery(tr);
  try
    try
      tr.StartTransaction;
      q.SQL.Text :=
        'SELECT g.TITLE, j.QTY FROM TDB_JURNAL j ' +
        '  JOIN TS_GOODS g ON g.GOODSID = j.GOODSID ' +
        ' WHERE j.DOCID = :docid AND j.SERVICE_FOR_GOODSID = :gid AND j.GOODSCOMPLECT_ID = -1';
      q.ParamByName('docid').AsInteger := ADocID;
      q.ParamByName('gid').AsInteger := AGoodsID;
      q.Open;
      if q.IsEmpty then
        Exit;
      list := '';
      while not q.Eof do
      begin
        list := list + #13#10 + '  - ' + q.FieldByName('TITLE').AsString +
          Format(' (cant. %s)', [FormatFloat('0.##', q.FieldByName('QTY').AsFloat)]);
        q.Next;
      end;
      q.Close;

      if MessageDlg('Produsul sters avea servicii adaugate pentru el:' + list + #13#10#13#10 +
        'Stergeti si aceste servicii din document?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

      q.SQL.Text :=
        'DELETE FROM TDB_JURNAL ' +
        ' WHERE DOCID = :docid AND SERVICE_FOR_GOODSID = :gid AND GOODSCOMPLECT_ID = -1';
      q.ParamByName('docid').AsInteger := ADocID;
      q.ParamByName('gid').AsInteger := AGoodsID;
      q.Execute;
      tr.Commit;
      Result := True;
    except
      on e: Exception do
      begin
        Result := False;
        if tr.Active then
          tr.Rollback;
        if not ProcessSWNError(e) then
          MessageDlg('Serviciile nu au fost sterse:' + #13#10 + e.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    if tr.Active then
      tr.Rollback;
    q.Free;
    tr.Free;
  end;
end;

end.
