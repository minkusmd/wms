unit SWNAttributeNameUnit;

(* ============================================================================
  WMS - Motor de compunere a denumirii produsului din template + filtre.

  Compune denumirea unui produs pe baza template-ului definit per (tip, context)
  in TS_GOODS_NAME_TEMPLATE, inlocuind placeholder-ele:

     {goods_type_name}  -> TS_GOODS_TYPE.TITLE / TITLE_RUS
     {brand_name}       -> TS_SYSS.TITLE (vendor; fara RU separat)
     {code}             -> TS_GOODS.CODE / CODE_RU
     {base_param}       -> TS_GOODS.BASE_PARAM / BASE_PARAM_RU
     {attr:Nume}        -> valoarea filtrului cu denumirea data (TS_FILTERS.FILTERNAME)

  Sursa valorilor sunt FILTRELE, nu atributele: TS_GOODS_FILTERS -> TS_FILTER_PARAMS
  (vezi DB Model\plan_migrare_atribute_in_filtre.md). Placeholder-ul si-a pastrat
  numele {attr:...} ca sa nu se strice template-urile deja scrise.
  La valoare se lipeste unitatea de masura a filtrului (TS_FILTERS.UOM_RO / UOM_RU),
  iar filtrele multi-valoare se insira cu virgula, in ordinea
  TS_FILTERS.ORDERNO, TS_GOODS_FILTERS.ORDERNO.

  Legatura produs->tip se face prin TS_GOODS.WEBGOODSTYPE_ID -> TS_GOODS_TYPE.GOODSTYPEID.
  Contextul fiscal/bon NU se compune aici (ramane pe TS_GOODS_ACNT).
  ============================================================================ *)

interface

uses
    IBC, System.SysUtils, System.Classes;

const
    { Contexte de denumire (TS_GOODS_NAME_TEMPLATE.CONTEXT) }
    cNameContext_Catalog = 1; { catalog / web }
    cNameContext_Invoice = 2; { factura }
    cNameContext_Label   = 3; { eticheta / raft }

{ Compune denumirea produsului pentru (context, limba).
  Ru = False -> RO, Ru = True -> RU.
  Tr: tranzactia in care se citeste (optional); daca nil se foloseste
  tranzactia implicita de select. Utila pentru preview live in timpul editarii,
  cand valorile atributelor pot fi inca necomise. }
function ComposeGoodsName(GoodsID: Integer; Context: Integer; Ru: Boolean;
    Tr: TIBCTransaction = nil): string;

implementation

uses
    System.StrUtils, DataModuleDB;

{ Pregateste un query cu conexiunea si tranzactia corecte. }
procedure PrepareQuery(Q: TIBCQuery; const ASql: string; Tr: TIBCTransaction);
begin
    Q.Connection := dmDB.IBCConnection;
    if Assigned(Tr) then
        Q.Transaction := Tr
    else
        Q.Transaction := dmDB.IBCTrDefaultSelect;
    Q.SQL.Text := ASql;
end;

{ Inlocuieste toate token-urile de forma attr:Nume cu valoarea din AValues (Name=Value). }
function ReplaceAttrTokens(const ATemplate: string; AValues: TStringList): string;
var
    P, Q: Integer;
    token, attrName, val: string;
begin
    Result := ATemplate;
    P := Pos('{attr:', Result);
    while P > 0 do
    begin
        Q := PosEx('}', Result, P);
        if Q = 0 then
            Break;
        token := Copy(Result, P, Q - P + 1);         { tokenul complet attr:Nume }
        attrName := Trim(Copy(Result, P + 6, Q - (P + 6)));
        val := AValues.Values[attrName];
        Result := StringReplace(Result, token, val, [rfReplaceAll, rfIgnoreCase]);
        P := Pos('{attr:', Result);
    end;
end;

(* Elimina token-uri nerezolvate {...}, comprima spatiile si curata virgulele. *)
function CleanupName(const S: string): string;
var
    P, Q: Integer;
begin
    Result := S;
    P := Pos('{', Result);
    while P > 0 do
    begin
        Q := PosEx('}', Result, P);
        if Q = 0 then
            Break;
        Delete(Result, P, Q - P + 1);
        P := Pos('{', Result);
    end;

    while Pos('  ', Result) > 0 do
        Result := StringReplace(Result, '  ', ' ', [rfReplaceAll]);

    Result := StringReplace(Result, ' ,', ',', [rfReplaceAll]);
    Result := StringReplace(Result, ',,', ',', [rfReplaceAll]);
    Result := Trim(Result);

    { curata o eventuala virgula la final }
    while (Length(Result) > 0) and CharInSet(Result[Length(Result)], [',', ' ']) do
        Delete(Result, Length(Result), 1);
end;

function ComposeGoodsName(GoodsID: Integer; Context: Integer; Ru: Boolean;
    Tr: TIBCTransaction = nil): string;
var
    qHead, qAttr: TIBCQuery;
    tmpl, goodsType, brand, code, baseParam, nm, vv, um: string;
    vals: TStringList;
begin
    Result := '';
    qHead := TIBCQuery.Create(nil);
    vals := TStringList.Create;
    try
        vals.CaseSensitive := False;

        PrepareQuery(qHead,
            'SELECT gt.TITLE, gt.TITLE_RUS, s.TITLE AS VENDOR_TITLE, ' +
            '       g.CODE, g.CODE_RU, g.BASE_PARAM, g.BASE_PARAM_RU, ' +
            '       t.TEMPLATE_RO, t.TEMPLATE_RU ' +
            'FROM TS_GOODS g ' +
            'LEFT JOIN TS_GOODS_TYPE gt ON gt.GOODSTYPEID = g.WEBGOODSTYPE_ID ' +
            'LEFT JOIN TS_SYSS s ON s.SYSSID = g.VENDOR_ID ' +
            'LEFT JOIN TS_GOODS_NAME_TEMPLATE t ' +
            '       ON t.GOODS_TYPE_ID = g.WEBGOODSTYPE_ID AND t.CONTEXT = :ctx ' +
            'WHERE g.GOODSID = :gid', Tr);
        qHead.ParamByName('ctx').AsInteger := Context;
        qHead.ParamByName('gid').AsInteger := GoodsID;
        qHead.Open;
        if qHead.Eof then
            Exit;

        if Ru then
        begin
            tmpl := qHead.FieldByName('TEMPLATE_RU').AsString;
            goodsType := qHead.FieldByName('TITLE_RUS').AsString;
            code := qHead.FieldByName('CODE_RU').AsString;
            baseParam := qHead.FieldByName('BASE_PARAM_RU').AsString;
        end
        else
        begin
            tmpl := qHead.FieldByName('TEMPLATE_RO').AsString;
            goodsType := qHead.FieldByName('TITLE').AsString;
            code := qHead.FieldByName('CODE').AsString;
            baseParam := qHead.FieldByName('BASE_PARAM').AsString;
        end;
        brand := qHead.FieldByName('VENDOR_TITLE').AsString; { fara RU }

        if Trim(tmpl) = '' then
            Exit; { nu exista template pentru acest context/tip }

        { incarca valorile atributelor produsului }
        qAttr := TIBCQuery.Create(nil);
        try
            PrepareQuery(qAttr,
                { valorile vin acum din filtre: TS_GOODS_FILTERS -> TS_FILTER_PARAMS;
                  aliasurile raman NAME_RO / VALUE_RO / VALUE_RU ca sa nu schimbam citirea }
                'SELECT f.FILTERNAME AS NAME_RO, p.PARAM_VALUE AS VALUE_RO, ' +
                '       p.PARAM_VALUE_RUS AS VALUE_RU, f.UOM_RO, f.UOM_RU ' +
                'FROM TS_GOODS_FILTERS gf ' +
                'JOIN TS_FILTERS f ON f.FILTERID = gf.FILTERID ' +
                'JOIN TS_FILTER_PARAMS p ON p.FILTERPARAMID = gf.FILTERPARAMID ' +
                'WHERE gf.GOODSID = :gid ' +
                'ORDER BY f.ORDERNO, gf.ORDERNO', Tr);
            qAttr.ParamByName('gid').AsInteger := GoodsID;
            qAttr.Open;
            while not qAttr.Eof do
            begin
                nm := Trim(qAttr.FieldByName('NAME_RO').AsString);
                if Ru then
                begin
                    vv := qAttr.FieldByName('VALUE_RU').AsString;
                    um := Trim(qAttr.FieldByName('UOM_RU').AsString);
                end
                else
                begin
                    vv := qAttr.FieldByName('VALUE_RO').AsString;
                    um := Trim(qAttr.FieldByName('UOM_RO').AsString);
                end;
                { unitatea de masura a atributului se lipeste de valoare }
                if (vv <> '') and (um <> '') then
                    vv := vv + ' ' + um;
                if nm <> '' then
                begin
                    { atribut multi-valoare -> valorile se insira cu virgula }
                    if (vals.Values[nm] <> '') and (vv <> '') then
                        vals.Values[nm] := vals.Values[nm] + ', ' + vv
                    else if vals.Values[nm] = '' then
                        vals.Values[nm] := vv;
                end;
                qAttr.Next;
            end;
        finally
            qAttr.Free;
        end;

        Result := tmpl;
        Result := StringReplace(Result, '{goods_type_name}', goodsType, [rfReplaceAll, rfIgnoreCase]);
        Result := StringReplace(Result, '{brand_name}', brand, [rfReplaceAll, rfIgnoreCase]);
        Result := StringReplace(Result, '{code}', code, [rfReplaceAll, rfIgnoreCase]);
        Result := StringReplace(Result, '{base_param}', baseParam, [rfReplaceAll, rfIgnoreCase]);
        Result := ReplaceAttrTokens(Result, vals);
        Result := CleanupName(Result);
    finally
        vals.Free;
        qHead.Free;
    end;
end;

end.
