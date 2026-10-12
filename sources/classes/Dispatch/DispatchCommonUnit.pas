unit DispatchCommonUnit;

(* ============================================================================
   Dispecerat achizitii + livrari (plan: Documents/plan-dispecerat-achizitii-
   livrari-2026-10-08.md, DDL: DB Model/dispatch_logistics.sql).

   Functii comune pentru formele WMS ale dispeceratului. Regulile (atribuire,
   consolidarea opririlor, blocarea preluarii, publicarea) sint in procedurile
   SP_DISPATCH_* din baza - formele doar le apeleaza, fiecare actiune intr-o
   tranzactie proprie, si arata operatorului mesajul procedurii.
   ============================================================================ *)

interface

uses
    SysUtils, Classes, Variants, Data.DB, DBAccess, IBC;

const
    cDispatchActivityPickup = 1;
    cDispatchActivityDelivery = 2;

{ Textul pentru operator dintr-o eroare Firebird ridicata cu EXCEPTION ERR_*:
  linia de dupa numele exceptiei; altfel mesajul intreg. }
function DispatchErrorText(const AMessage: string): string;

{ Executa ASql (procedura sau DML) intr-o tranzactie proprie: COMMIT la succes,
  ROLLBACK la eroare (eroarea merge mai departe). Parametrii se dau pe nume.
  Intoarce prima coloana a primului rand pentru SELECT, altfel Null. }
function DispatchExec(const ASql: string; const ANames: array of string;
    const AValues: array of Variant): Variant;

{ Ca DispatchExec, dar eroarea se intoarce ca text pentru operator (AError).
  Intoarce True la succes. }
function DispatchTry(const ASql: string; const ANames: array of string;
    const AValues: array of Variant; out AError: string): Boolean;

implementation

uses
    DataModuleDB;

function DispatchErrorText(const AMessage: string): string;
var
    lines: TStringList;
    i: Integer;
    s: string;
begin
    Result := Trim(AMessage);
    lines := TStringList.Create;
    try
        lines.Text := AMessage;
        for i := 0 to lines.Count - 1 do
        begin
            s := Trim(lines[i]);
            if (s <> '') and (s[1] = '-') then
                s := Trim(Copy(s, 2, MaxInt));
            if s.StartsWith('ERR_') then
            begin
                { "ERR_DISPATCH" pe linia ei, mesajul pe urmatoarea }
                if Pos(' ', s) > 0 then
                    Exit(Trim(Copy(s, Pos(' ', s) + 1, MaxInt)));
                if i + 1 < lines.Count then
                begin
                    s := Trim(lines[i + 1]);
                    if (s <> '') and (s[1] = '-') then
                        s := Trim(Copy(s, 2, MaxInt));
                    if s <> '' then
                        Exit(s);
                end;
            end;
        end;
    finally
        lines.Free;
    end;
end;

function DispatchExec(const ASql: string; const ANames: array of string;
    const AValues: array of Variant): Variant;
var
    tr: TIBCTransaction;
    q: TIBCQuery;
    i: Integer;
begin
    Result := Null;
    tr := TIBCTransaction.Create(nil);
    q := TIBCQuery.Create(nil);
    try
        tr.DefaultConnection := dmDB.IBCConnection;
        q.Connection := dmDB.IBCConnection;
        q.Transaction := tr;
        q.SQL.Text := ASql;
        for i := 0 to High(ANames) do
            if VarIsNull(AValues[i]) or VarIsEmpty(AValues[i]) then
            begin
                { parametrii nuli sint identificatori (curier, zona): IBDAC cere tipul }
                q.ParamByName(ANames[i]).DataType := ftInteger;
                q.ParamByName(ANames[i]).Clear;
            end
            else
                q.ParamByName(ANames[i]).Value := AValues[i];

        tr.StartTransaction;
        try
            if SameText(Copy(TrimLeft(ASql), 1, 6), 'SELECT') then
            begin
                q.Open;
                if not q.IsEmpty then
                    Result := q.Fields[0].Value;
                q.Close;
            end
            else
                q.Execute;
            tr.Commit;
        except
            if tr.Active then
                tr.Rollback;
            raise;
        end;
    finally
        q.Free;
        tr.Free;
    end;
end;

function DispatchTry(const ASql: string; const ANames: array of string;
    const AValues: array of Variant; out AError: string): Boolean;
begin
    AError := '';
    try
        DispatchExec(ASql, ANames, AValues);
        Result := True;
    except
        on E: Exception do
        begin
            AError := DispatchErrorText(E.Message);
            Result := False;
        end;
    end;
end;

end.
