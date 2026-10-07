unit PriceListReevaluationUnit;

{ Cele 4 reevaluari ale unui pricelist nou, fara interfata - acelasi algoritm ca butonul
  "Toate reevaluarile" din WMS (Tframe78PriceList.bbToateReevaluarileClick + DoCreateReevaluare):

    1. produse noi              (IBCQueryNewGoods,   FLG_IN_PRICE = 1)
    2. produse vechi            (IBCQueryOldGoods,   FLG_IN_PRICE = 0 - ies din price)
    3. produse cu preturi marite  (IBCQueryPricesUp,   FLG_IN_PRICE = 1)
    4. produse cu preturi scazute (IBCQueryPricesDown, FLG_IN_PRICE = 1)

  Interogarile sint copiate din frame78PriceListUnit.dfm. Ca in WMS, ele compara pricelistul nou cu
  starea curenta din TS_GOODS_FOREIGN a furnizorului (pricelistul "de comparat" din WMS nu intra in
  aceste 4 interogari). Toate 4 se citesc o singura data, inainte de primul document (in WMS grilele
  sint incarcate la analiza, inaintea reevaluarilor).

  Fiecare reevaluare, intr-o singura tranzactie:
    sp_create_new_document (DOCTYPEID 1414, firma = /firma:, CT = furnizorul)
    TDB_GOODS_PRICE - regulile din DoCreateReevaluare (vezi BuildRow)
    ADJUST_RRP_REEVALUATION(docid, TS_CUSTOMER.RRP_DISCOUNT)
    CLOSE_REEVALUARE(docid) - un produs respins ("goodscode: <cod>[...") se scoate si se reia
  La sfirsit pricelistul se marcheaza prelucrat (TS_PRICELISTS.FLAGS bit 4 = FLG_DONE).

  Diferente fata de WMS (intentionate):
    - o selectie goala nu mai creeaza un document gol;
    - valorile nu se mai "mostenesc" de la randul anterior (goodsid / valute nule in WMS);
    - un rand fara valuta 7 se sare cu mesaj in jurnal (in WMS oprea tot documentul);
    - inchiderile reevaluarilor (CLOSE_REEVALUARE atinge TS_GOODS_FOREIGN / TS_GOODS_PRICE ale
      produselor comune mai multor furnizori) trec pe rind intre joburile paralele - un lacat comun. }

interface

uses
  System.SysUtils, IBC;

type
  TReevaluationSummary = record
    DocIDs: array[0..3] of Integer;
    Rows: array[0..3] of Integer;
    Skipped: Integer;
    Rejected: Integer;
    function Text: string;
  end;

// ALog e apelat din firul apelant. ACancelled (optional) opreste inainte de urmatoarea reevaluare.
// ATestOnly: tot procesul (documente, ADJUST, CLOSE), dar fiecare reevaluare se anuleaza (ROLLBACK)
// la sfirsit si pricelistul nu se marcheaza prelucrat - pentru verificare pe baza reala.
function CreatePriceListReevaluations(AConnection: TIBCConnection; APLID, AFirmaID, AUserID: Integer;
  const ALog: TProc<string>; const ACancelled: TFunc<Boolean> = nil;
  ATestOnly: Boolean = False): TReevaluationSummary;

implementation

uses
  System.Classes, System.Math, System.SyncObjs, System.Variants, System.Generics.Collections, Data.DB, IBCClasses;

const
  cKindNames: array[0..3] of string = ('produse noi', 'produse vechi', 'preturi marite', 'preturi scazute');
  // al treilea parametru al DoCreateReevaluare in bbToateReevaluarileClick
  cKindInPrice: array[0..3] of Boolean = (True, False, True, True);
  cMaxCloseRetries = 50;
  cBatchRows = 500;

  // frame78PriceListUnit.dfm: IBCQueryNewGoods
  cSqlNewGoods =
    'select gf.goodsid, pli1.*, pli1.price0 new_price0, 1 flg_in_price, get_flg_value(gf.flags, 4) flg_epp ' +
    'from ts_pricelist_items pli1 ' +
    'join ts_goods_foreign gf on (gf.goods_code = pli1.supplier_goods_code and gf.customerid = :supplierid) ' +
    'where pli1.plid = :new_plid and ' +
    '      not exists(select 1 ' +
    '                 from ts_goods_foreign gfo ' +
    '                 where (gfo.goods_code = pli1.supplier_goods_code and ' +
    '                       gfo.customerid = :supplierid and ' +
    '                       get_flg_value(gfo.flags, 3) = 1))';

  // IBCQueryOldGoods
  cSqlOldGoods =
    'SELECT gf.GOODS_CODE AS SUPPLIER_GOODS_CODE, gf.PRICE0 AS NEW_PRICE0, gf.PRICE3 AS NEW_PRICE3, ' +
    '  gf.PRICE7 AS NEW_PRICE7, gf.CURRENCY3ID, gf.CURRENCY7ID, gf.GOODS_TITLE AS SUPPLIER_GOODS_NAME, ' +
    '  gf.GOODSID, get_flg_value(gf.FLAGS, 3) AS FLG_IN_PRICE, get_flg_value(gf.FLAGS, 4) AS FLG_EPP ' +
    'FROM TS_GOODS_FOREIGN gf ' +
    'JOIN TS_PRICELISTS pl ON pl.PLID = :NEW_PLID ' +
    'WHERE gf.CUSTOMERID = pl.SUPPLIERID ' +
    '  AND get_flg_value(gf.FLAGS, 3) = 1 ' +
    '  AND NOT EXISTS (SELECT 1 FROM TS_PRICELIST_ITEMS pi ' +
    '                  WHERE pi.PLID = pl.PLID AND pi.SUPPLIER_GOODS_CODE = gf.GOODS_CODE)';

  // IBCQueryPricesUp
  cSqlPricesUp =
    'select P_new.plid, pl.supplierid, P_new.SUPPLIER_GOODS_CODE, gf.PRICE0 OLD_PRICE0, ' +
    '  gf.PRICE3 OLD_PRICE3, P_NEW.CURRENCY3ID NEW_CURRENCY3ID, ' +
    '  gf.PRICE7 OLD_PRICE7, P_NEW.CURRENCY7ID NEW_CURRENCY7ID, ' +
    '  P_NEW.PRICE7 - gf.PRICE7 DEVIATION, P_NEW.SUPPLIER_GOODS_NAME, ' +
    '  P_NEW.PRICE0 NEW_PRICE0, P_NEW.PRICE3 NEW_PRICE3, ' +
    '  P_NEW.PRICE7 NEW_PRICE7, P_NEW.PRICE3 - gf.PRICE3 DEVIATION3, ' +
    '  GF.GOODSID GOODSID, GET_FLG_IN_PRICE(GF.GOODSID) FLG_IN_PRICE, ' +
    '  get_flg_value(GF.flags, 4) flg_epp ' +
    'from TS_PRICELIST_ITEMS P_NEW ' +
    'join ts_pricelists pl on pl.plid = p_new.plid ' +
    'join TS_GOODS_FOREIGN GF on (GF.GOODS_CODE = P_NEW.SUPPLIER_GOODS_CODE and GF.CUSTOMERID = pl.supplierid) and ' +
    '  ( ' +
    '    (coalesce(P_NEW.PRICE7, 0) > coalesce(gf.PRICE7, 0)) or ' +
    '    (coalesce(P_NEW.PRICE0, 0) > 0 and coalesce(P_NEW.PRICE0, 0) > coalesce(gf.PRICE0, 0)) or ' +
    '    iif(get_flg_value(GF.flags, 4) = 1, (coalesce(P_NEW.PRICE3, 0) > coalesce(gf.PRICE3, 0)), false) ' +
    '  ) ' +
    'where p_new.plid = :new_plid and GET_FLG_IN_PRICE(GF.GOODSID)=1';

  // IBCQueryPricesDown
  cSqlPricesDown =
    'select P_old.plid, pl.supplierid, P_old.SUPPLIER_GOODS_CODE, gf.PRICE0 OLD_PRICE0, ' +
    '  gf.PRICE3 OLD_PRICE3, P_old.CURRENCY3ID NEW_CURRENCY3ID, ' +
    '  gf.PRICE7 OLD_PRICE7, P_old.CURRENCY7ID NEW_CURRENCY7ID, ' +
    '  P_old.PRICE7 - gf.PRICE7 DEVIATION, P_old.SUPPLIER_GOODS_NAME, ' +
    '  P_old.PRICE0 NEW_PRICE0, P_old.PRICE3 NEW_PRICE3, ' +
    '  P_old.PRICE7 NEW_PRICE7, P_old.PRICE3 - gf.PRICE3 DEVIATION3, ' +
    '  GF.GOODSID GOODSID, GET_FLG_IN_PRICE(GF.GOODSID) FLG_IN_PRICE, ' +
    '  get_flg_value(GF.flags, 4) flg_epp ' +
    'from TS_PRICELIST_ITEMS P_old ' +
    'join ts_pricelists pl on pl.plid = P_old.plid ' +
    'join TS_GOODS_FOREIGN GF on (GF.GOODS_CODE = P_old.SUPPLIER_GOODS_CODE and GF.CUSTOMERID = pl.supplierid) and ' +
    '  ( ' +
    '    (coalesce(P_old.PRICE7, 0) < coalesce(gf.PRICE7, 0)) or ' +
    '    (coalesce(P_old.PRICE0, 0) > 0 and coalesce(P_old.PRICE0, 0) < coalesce(gf.PRICE0, 0)) or ' +
    '    iif(get_flg_value(GF.flags, 4) = 1, (coalesce(P_old.PRICE3, 0) < coalesce(gf.PRICE3, 0)), false) ' +
    '  ) ' +
    'where P_old.plid = :new_plid and (GET_FLG_IN_PRICE(GF.GOODSID) = 1)';

type
  // un rand al interogarii, cu numele de coloane ale fiecarei grile din WMS
  TSourceRow = record
    GoodsID: Variant;
    Code: string;
    Price0: Variant;
    Price3: Variant;
    Currency3: Variant;
    Price7: Variant;
    Currency7: Variant;
    FlgEpp: Integer;
  end;

  // randul gata de scris in TDB_GOODS_PRICE
  TReevalRow = record
    GoodsID: Integer;
    Code: string;
    Price0: Double;
    Currency0ID: Integer;
    Price3: Double;
    Currency3ID: Integer;
    Price7: Double;          // 0 = randul "vinzare" (fara PRICE7 / CURRENCY7ID)
    Currency7ID: Integer;
    FlgEpp: Boolean;
  end;

var
  // inchiderile reevaluarilor trec pe rind intre joburile paralele
  GCloseLock: TCriticalSection;

function TReevaluationSummary.Text: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to 3 do
  begin
    if Result <> '' then
      Result := Result + ', ';
    if DocIDs[I] > 0 then
      Result := Result + Format('%s: doc %d (%d)', [cKindNames[I], DocIDs[I], Rows[I]])
    else
      Result := Result + Format('%s: -', [cKindNames[I]]);
  end;
  Result := Result + Format('; sarite %d, respinse la inchidere %d', [Skipped, Rejected]);
end;

function VarFloat(const V: Variant): Double;
begin
  if VarIsNull(V) or VarIsEmpty(V) then
    Result := 0
  else
    Result := V;
end;

function FieldVar(AQuery: TIBCQuery; const AName: string): Variant;
begin
  Result := AQuery.FieldByName(AName).Value;
end;

// citeste o interogare cu numele de coloane ale grilei din WMS (GetGoodsPrice0Index & co)
function LoadRows(AQuery: TIBCQuery; AKind: Integer): TArray<TSourceRow>;
var
  List: TList<TSourceRow>;
  R: TSourceRow;
  P0, P3, C3, P7, C7: string;
begin
  case AKind of
    0:
      begin P0 := 'PRICE0'; P3 := 'PRICE3'; C3 := 'CURRENCY3ID'; P7 := 'PRICE7'; C7 := 'CURRENCY7ID'; end;
    1:
      begin P0 := 'NEW_PRICE0'; P3 := 'NEW_PRICE3'; C3 := 'CURRENCY3ID'; P7 := 'NEW_PRICE7'; C7 := 'CURRENCY7ID'; end;
  else
    P0 := 'NEW_PRICE0'; P3 := 'NEW_PRICE3'; C3 := 'NEW_CURRENCY3ID'; P7 := 'NEW_PRICE7'; C7 := 'NEW_CURRENCY7ID';
  end;
  List := TList<TSourceRow>.Create;
  try
    AQuery.Open;
    while not AQuery.Eof do
    begin
      R.GoodsID := FieldVar(AQuery, 'GOODSID');
      R.Code := AQuery.FieldByName('SUPPLIER_GOODS_CODE').AsString;
      R.Price0 := FieldVar(AQuery, P0);
      R.Price3 := FieldVar(AQuery, P3);
      R.Currency3 := FieldVar(AQuery, C3);
      R.Price7 := FieldVar(AQuery, P7);
      R.Currency7 := FieldVar(AQuery, C7);
      R.FlgEpp := AQuery.FieldByName('FLG_EPP').AsInteger;
      List.Add(R);
      AQuery.Next;
    end;
    AQuery.Close;
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

// regulile din Tframe78PriceList.DoCreateReevaluare; False = randul nu intra (motivul in AReason)
function BuildRow(const S: TSourceRow; out R: TReevalRow; out AReason: string): Boolean;
var
  Cur3, Cur7: string;
begin
  Result := False;
  AReason := '';
  R := Default(TReevalRow);
  R.Code := S.Code;
  if VarIsNull(S.GoodsID) then
  begin
    AReason := 'fara GOODSID';
    Exit;
  end;
  R.GoodsID := S.GoodsID;
  R.FlgEpp := S.FlgEpp = 1;
  R.Price3 := VarFloat(S.Price3);
  R.Price7 := VarFloat(S.Price7);

  // furnizorul nu da pret indicativ: singurul reper e RRP-ul -> modul EPP
  if (R.Price7 = 0) and (R.Price3 > 0) then
    R.FlgEpp := True;

  Cur3 := '';
  if not VarIsNull(S.Currency3) then
    Cur3 := VarToStr(S.Currency3);

  // 03.10.2026: produs pe RRP fara RRP in pricelist - iese de pe RRP (FLG_EPP = 0, PRICE3 = 0)
  if R.FlgEpp and (R.Price3 = 0) then
  begin
    R.FlgEpp := False;
    AReason := 'iese de pe RRP (pricelistul nu are RRP)'; // informativ, randul intra
  end;

  // fara pret indicativ si fara RRP nu ramine nicio baza pentru pretul de vinzare
  if (R.Price7 = 0) and (R.Price3 = 0) then
  begin
    AReason := 'nici pret indicativ, nici RRP';
    Exit;
  end;

  Cur7 := '';
  if not VarIsNull(S.Currency7) then
    Cur7 := VarToStr(S.Currency7);
  R.Price0 := VarFloat(S.Price0);

  if (R.Price7 = 0) and R.FlgEpp then
  begin
    // pozitie fara pret indicativ: valuta 7 nu vine din pricelist, luam valuta RRP
    if Cur3 = '' then
      Cur7 := '840'
    else
      Cur7 := Cur3;
  end
  else if Cur7 = '' then
  begin
    AReason := 'valuta 7 nu este setata';
    Exit;
  end;

  if Cur3 = '' then
    Cur3 := '498';
  R.Currency3ID := StrToIntDef(Cur3, 498);
  R.Currency7ID := StrToIntDef(Cur7, 498);
  R.Currency0ID := R.Currency7ID;
  Result := True;
end;

procedure ExecSQL(AQuery: TIBCQuery; const ASql: string; const AParams: array of Variant);
var
  I: Integer;
begin
  AQuery.SQL.Text := ASql;
  for I := 0 to High(AParams) do
    AQuery.Params[I].Value := AParams[I];
  AQuery.Execute;
end;

// randurile intr-un lot: cele cu PRICE7 (AddRecordToReevaluare) si cele fara (AddRecordToReevaluareVinzare)
procedure InsertRows(AConnection: TIBCConnection; ATransaction: TIBCTransaction; ADocID: Integer;
  const ARows: TArray<TReevalRow>; AInPrice: Boolean);
var
  Full, Sale: TIBCSQL;
  WithP7, WithoutP7: TList<TReevalRow>;
  R: TReevalRow;

  procedure Flush(AQuery: TIBCSQL; AList: TList<TReevalRow>; AWithPrice7: Boolean);
  var
    I, N, K: Integer;
  begin
    I := 0;
    while I < AList.Count do
    begin
      N := Min(cBatchRows, AList.Count - I);
      AQuery.Params.ValueCount := N;
      for K := 0 to N - 1 do
      begin
        R := AList[I + K];
        AQuery.ParamByName('GOODSID')[K].AsInteger := R.GoodsID;
        AQuery.ParamByName('SUPPLIER_GOODS_CODE')[K].AsString := R.Code;
        AQuery.ParamByName('PRICE0')[K].AsFloat := R.Price0;
        AQuery.ParamByName('PRICE3')[K].AsFloat := R.Price3;
        AQuery.ParamByName('CURRENCYID')[K].AsInteger := R.Currency0ID;
        AQuery.ParamByName('CURRENCY3ID')[K].AsInteger := R.Currency3ID;
        if AWithPrice7 then
        begin
          AQuery.ParamByName('PRICE7')[K].AsFloat := R.Price7;
          AQuery.ParamByName('CURRENCY7ID')[K].AsInteger := R.Currency7ID;
        end;
        AQuery.ParamByName('FLG_EPP')[K].AsInteger := Ord(R.FlgEpp);
      end;
      AQuery.Execute(N);
      Inc(I, N);
    end;
  end;

  function Prepare(const ASql: string; AWithPrice7: Boolean): TIBCSQL;
  begin
    Result := TIBCSQL.Create(nil);
    Result.Connection := AConnection;
    Result.Transaction := ATransaction;
    Result.AutoCommit := False;
    Result.SQL.Text := ASql;
    Result.ParamByName('GOODSID').DataType := ftInteger;
    Result.ParamByName('SUPPLIER_GOODS_CODE').DataType := ftWideString;
    Result.ParamByName('PRICE0').DataType := ftFloat;
    Result.ParamByName('PRICE3').DataType := ftFloat;
    Result.ParamByName('CURRENCYID').DataType := ftInteger;
    Result.ParamByName('CURRENCY3ID').DataType := ftInteger;
    if AWithPrice7 then
    begin
      Result.ParamByName('PRICE7').DataType := ftFloat;
      Result.ParamByName('CURRENCY7ID').DataType := ftInteger;
    end;
    Result.ParamByName('FLG_EPP').DataType := ftInteger;
  end;

var
  Flags: string;
begin
  // BARCODE ramine '' ca in WMS (variabila Barcode din DoCreateReevaluare nu e completata)
  Flags := Format('set_flg_value(set_flg_value(0, 3, %d), 4, :FLG_EPP)', [Ord(AInPrice)]);
  WithP7 := TList<TReevalRow>.Create;
  WithoutP7 := TList<TReevalRow>.Create;
  Full := nil;
  Sale := nil;
  try
    for R in ARows do
      if R.Price7 > 0 then
        WithP7.Add(R)
      else
        WithoutP7.Add(R);
    if WithP7.Count > 0 then
    begin
      Full := Prepare(Format('insert into TDB_GOODS_PRICE (DOCID, GOODSID, SUPPLIER_GOODS_CODE, PRICE0, PRICE3, ' +
        'CURRENCYID, CURRENCY3ID, PRICE7, CURRENCY7ID, BARCODE, FLAGS) values (%d, :GOODSID, :SUPPLIER_GOODS_CODE, ' +
        ':PRICE0, :PRICE3, :CURRENCYID, :CURRENCY3ID, :PRICE7, :CURRENCY7ID, '''', %s)', [ADocID, Flags]), True);
      Flush(Full, WithP7, True);
    end;
    if WithoutP7.Count > 0 then
    begin
      Sale := Prepare(Format('insert into TDB_GOODS_PRICE (DOCID, GOODSID, SUPPLIER_GOODS_CODE, PRICE0, PRICE3, ' +
        'CURRENCYID, CURRENCY3ID, BARCODE, FLAGS) values (%d, :GOODSID, :SUPPLIER_GOODS_CODE, :PRICE0, :PRICE3, ' +
        ':CURRENCYID, :CURRENCY3ID, '''', %s)', [ADocID, Flags]), False);
      Flush(Sale, WithoutP7, False);
    end;
  finally
    Sale.Free;
    Full.Free;
    WithoutP7.Free;
    WithP7.Free;
  end;
end;

// CLOSE_REEVALUARE; produsul raportat ca "goodscode: <cod>[..." se scoate din document si se reia
function CloseReevaluation(AQuery: TIBCQuery; ADocID: Integer; const ALog: TProc<string>): Integer;
var
  Closed: Boolean;
  Msg, BadCode: string;
  P: Integer;
begin
  Result := 0;
  Closed := False;
  while not Closed do
    try
      ExecSQL(AQuery, 'execute procedure close_reevaluare(:docid)', [ADocID]);
      Closed := True;
    except
      on E: Exception do
      begin
        Msg := E.Message;
        BadCode := '';
        P := Pos('goodscode: ', Msg);
        if P > 0 then
        begin
          BadCode := Copy(Msg, P + Length('goodscode: '), MaxInt);
          P := Pos('[', BadCode);
          if P > 0 then
            BadCode := Copy(BadCode, 1, P - 1);
          BadCode := Trim(BadCode);
        end;
        if (BadCode = '') or (Result >= cMaxCloseRetries) then
          raise;
        Inc(Result);
        if Assigned(ALog) then
          ALog(Format('  RESPINS %s la inchiderea documentului %d (scos din reevaluare): %s',
            [BadCode, ADocID, StringReplace(Msg, sLineBreak, ' ', [rfReplaceAll])]));
        ExecSQL(AQuery, 'delete from TDB_GOODS_PRICE where DOCID = :DOCID and SUPPLIER_GOODS_CODE = :CODE',
          [ADocID, BadCode]);
        if AQuery.RowsAffected = 0 then
          raise Exception.Create('Inchiderea reevaluarii a esuat: ' + Msg);
      end;
    end;
end;

function CreatePriceListReevaluations(AConnection: TIBCConnection; APLID, AFirmaID, AUserID: Integer;
  const ALog: TProc<string>; const ACancelled: TFunc<Boolean>; ATestOnly: Boolean): TReevaluationSummary;
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
  SupplierID, Kind, I: Integer;
  RrpDiscount: Double;
  Sources: array[0..3] of TArray<TSourceRow>;
  Rows: TList<TReevalRow>;
  R: TReevalRow;
  Reason: string;

  procedure Log(const S: string);
  begin
    if Assigned(ALog) then
      ALog(S);
  end;

begin
  Result := Default(TReevaluationSummary);
  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  Rows := TList<TReevalRow>.Create;
  try
    Tr.DefaultConnection := AConnection;
    Q.Connection := AConnection;
    Q.Transaction := Tr;
    Q.AutoCommit := False;

    // 1. cele 4 selectii, o singura data, intr-un instantaneu consistent
    Tr.IsolationLevel := iblSnapshot;
    Tr.StartTransaction;
    try
      Q.SQL.Text := 'select p.SUPPLIERID, coalesce(c.RRP_DISCOUNT, 0) RRP_DISCOUNT from TS_PRICELISTS p ' +
        'left join TS_CUSTOMER c on c.CUSTOMERID = p.SUPPLIERID where p.PLID = :PLID';
      Q.ParamByName('PLID').AsInteger := APLID;
      Q.Open;
      if Q.IsEmpty then
        raise Exception.CreateFmt('Pricelistul %d nu exista.', [APLID]);
      SupplierID := Q.Fields[0].AsInteger;
      RrpDiscount := Q.Fields[1].AsFloat;
      Q.Close;

      for Kind := 0 to 3 do
      begin
        case Kind of
          0: Q.SQL.Text := cSqlNewGoods;
          1: Q.SQL.Text := cSqlOldGoods;
          2: Q.SQL.Text := cSqlPricesUp;
        else
          Q.SQL.Text := cSqlPricesDown;
        end;
        if Q.Params.FindParam('SUPPLIERID') <> nil then
          Q.ParamByName('SUPPLIERID').AsInteger := SupplierID;
        Q.ParamByName('NEW_PLID').AsInteger := APLID;
        Sources[Kind] := LoadRows(Q, Kind);
      end;
      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
    Log(Format('Reevaluari pricelist %d: produse noi %d, vechi %d, preturi marite %d, scazute %d',
      [APLID, Length(Sources[0]), Length(Sources[1]), Length(Sources[2]), Length(Sources[3])]));

    // 2. cite un document pe fiecare selectie (in ordinea din WMS)
    Tr.IsolationLevel := iblReadCommitted;
    for Kind := 0 to 3 do
    begin
      if Assigned(ACancelled) and ACancelled() then
        Break;
      Rows.Clear;
      for I := 0 to High(Sources[Kind]) do
        if BuildRow(Sources[Kind][I], R, Reason) then
        begin
          Rows.Add(R);
          if Reason <> '' then
            Log(Format('  %s: %s - %s', [cKindNames[Kind], R.Code, Reason]));
        end
        else
        begin
          Inc(Result.Skipped);
          Log(Format('  %s: %s sarit - %s', [cKindNames[Kind], Sources[Kind][I].Code, Reason]));
        end;
      if Rows.Count = 0 then
        Continue;

      GCloseLock.Enter;
      try
        Tr.StartTransaction;
        try
          // ca in WMS: utilizatorul si firma curenta in contextul sesiunii (triggere, CREATED_BY)
          ExecSQL(Q, 'execute procedure PROC_USER_SET_DT(:DT)', [AFirmaID]);
          Q.SQL.Text := 'select rdb$set_context(''USER_SESSION'', ''UserID'', :USERID) from rdb$database';
          Q.ParamByName('USERID').AsInteger := AUserID;
          Q.Open;
          Q.Close;

          // acelasi apel ca Tframe78PriceList.AddDocumentReeveluare
          Q.SQL.Text :=
            'select newdocid from sp_create_new_document (:dt, :ct, -1, -1, -1, -1, 0, 0, 498, 0, 1, 1, -1, 0, ' +
            '1414, 0, -1, -1)';
          Q.ParamByName('DT').AsInteger := AFirmaID;
          Q.ParamByName('CT').AsInteger := SupplierID;
          Q.Open;
          Result.DocIDs[Kind] := Q.FieldByName('NEWDOCID').AsInteger;
          Q.Close;
          if Result.DocIDs[Kind] <= 0 then
            raise Exception.Create('Reevaluarea nu a putut fi creata.');

          InsertRows(AConnection, Tr, Result.DocIDs[Kind], Rows.ToArray, cKindInPrice[Kind]);
          // micsorarea RRP-ului cu procentul furnizorului (ca in WMS)
          ExecSQL(Q, 'execute procedure ADJUST_RRP_REEVALUATION(:DOCID, :PERCENT)',
            [Result.DocIDs[Kind], RrpDiscount]);
          Inc(Result.Rejected, CloseReevaluation(Q, Result.DocIDs[Kind], ALog));
          Result.Rows[Kind] := Rows.Count;
          if ATestOnly then
          begin
            Tr.Rollback;
            Log(Format('  %s: TEST - reevaluarea %d s-a inchis fara erori (%d produse) si s-a anulat',
              [cKindNames[Kind], Result.DocIDs[Kind], Rows.Count]));
          end
          else
          begin
            Tr.Commit;
            Log(Format('  %s: reevaluarea %d inchisa, %d produse', [cKindNames[Kind], Result.DocIDs[Kind], Rows.Count]));
          end;
        except
          on E: Exception do
          begin
            if Tr.Active then
              Tr.Rollback;
            Result.DocIDs[Kind] := 0;
            raise Exception.CreateFmt('Reevaluarea "%s" a esuat (anulata): %s', [cKindNames[Kind], E.Message]);
          end;
        end;
      finally
        GCloseLock.Leave;
      end;
    end;

    // 3. pricelistul e prelucrat (FLG_DONE = bitul 4, ca btnAnalizaReevaluareClick)
    if ATestOnly then
      Exit;
    Tr.StartTransaction;
    try
      ExecSQL(Q, 'update TS_PRICELISTS set FLAGS = set_flg_value(FLAGS, 4, 1) where PLID = :PLID', [APLID]);
      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
  finally
    Rows.Free;
    Q.Free;
    Tr.Free;
  end;
end;

initialization
  GCloseLock := TCriticalSection.Create;

finalization
  GCloseLock.Free;

end.
