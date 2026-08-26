unit Import.ECBv4;

interface

uses
    System.Classes, DBAccess, IBC;

type
    TStruct60 = record
    {
         F1    Не используется                             X
         F2    Дата начало периода (в формате YYYYMMDD)    20000218
         F3    Код валюты счета                            USD
         F4    Остаток на начало периода в валюте          1000.00
         F5    Код лея                                     MDL
         F6    Остаток на начало периода в леях            12474.00
         F7    Курс валюты                                 12.47400000
         F8    Метка закрытый или открытый опердень        С (или О)
    }
        F1: string;
        F2: string;
        F3: string;
        F4: string;
        F5: string;
        F6: string;
        F7: string;
        F8: string;
    end;

    TStruct61 = record
{
Формат поля :61:
:61:F1*F2*F3*F4*F5*F6*F7*F8*F9*F10*F11*F12*F13*F14*F15*F16*F17*F18*F19*F20*F21*F22*F23*F24*F25*F26*F27*F28*F29*F30*F31*F32*F33
Пример поля :61:
:61: 12345*20000218*12.47400000*0**D*300.00*0.00*3742.20*0.00*C*2*07*1*20000215*
USD*USD*300.00*300.00*EXAMPLE SRL*882000*225179991004** B.C.'EuroCreditBank'S.A.* ECBMMD2X *BENEFICIAR SAI*104976*0724997015**BC'MOLDOVA-AGROINDBANK'SA f.11 Chisin.* AGRNMD2X433*PLATA PENTRU MARFA*Suma comisiei: 85.54 USD

 Поле  Описание                                    Пример
 F1    Ссылка на документ                          12345
 F2    Дата проводки (в формате YYYYMMDD)          20000218
 F3    Курс валюты                                 12.47400000
 F4    Не используется                             0
 F5    Внутрений счет
 F6    Метка дебет или кредит                      D (или C)
 F7    Сумма дебета (в валюте)                     300.00
 F8    Сумма кредита (в валюте)                    0.00
 F9    Сумма дебета (в леях)                       3742.20
 F10   Сумма кредита (в леях)                      0.00
 F11   Метка закрытый или открытый опердень        С (или О)
 F12   Вид документа                               2
 F13   Номер документа                             07
 F14   Тип и вид документа                         1
 F15   Дата документа                              20000215
 F16   Валюта документа                            USD
 F17   Строка валюты                               USD
 F18   Сумма платежа                               300.00
 F19   Строка суммы                                300.00
 F20   Сумма платежа в леях                300.00
 F21   Строка суммы в леях      300.00
 F22   Наименование плательщика                    Example SRL
 F23   Ф.к. плательщика                            882000
 F24   Счет плательщика                            225179991004 (IBAN)
 F25   2-й счет плательщика
 F26   Наименование банка плательщика              B.C.'EuroCreditBank'S.A.
 F27   Код банка плательщика                       ECBMMD2X

 F28   Наименование бенефициара                    BENEFICIAR SA
 F29   Ф.к. бенефициара                            104976
 F30   Счет бенефициара                            0724997015 (IBAN)
 F31   2-й счет бенефициара
 F32   Наименование банка бенефициара	BC'MOLDOVA-AGROINDBANK'SA f.11 Chisin.
 F33   Код банка бенефициара 		AGRNMD2X433
 F34   Назначение платежа                          PLATA PENTRU MARFA
 F35   Доп. метки банка                            Suma comisionului: 85.54 USD
}
        F1: string; /// Ссылка на документ
        F2: string;
        F3: string;
        F4: string;
        F5: string;
        F6: string;
        F7: string;
        F8: string;
        F9: string;
        F10: string;
        F11: string;
        F12: string;
        F13: string;
        F14: string;
        F15: string;
        F16: string;
        F17: string;
        F18: string;
        F19: string;
        F20: string;
        F21: string;
        F22: string;
        F23: string;
        F24: string;
        F25: string;
        F26: string;
        F27: string;
        F28: string;
        F29: string;
        F30: string;
        F31: string;
        F32: string;
        F33: string;
        F34: string;
        F35: string;
    end;

    TStruct62 = record
        {
         F1    Не используется                             X
         F2    Дата конца периода (в формате YYYYMMDD)     20000218
         F3    Код валюты счета                            USD
         F4    Остаток на конец периода в валюте           1000.00
         F5    Код лея                                     MDL
         F6    Остаток на конец периода в леях             12474.00
         F7    Курс валюты                                 12.47400000
         F8    Метка закрытый или открытый опердень        С (или О)
        }
        F1: string;
        F2: string;
        F3: string;
        F4: string;
        F5: string;
        F6: string;
        F7: string;
        F8: string;
    end;

    TImportECBv4 = class(TObject)
    private
        FData: TStringList;
        FEndDate: TDateTime;
        FStartDate: TDateTime;
        IBCConnection: TIBCConnection;
        IBCTrUpdate: TIBCTransaction;
        R60: TStruct60;
        R61: TStruct61;
        R62: TStruct62;
        FFirmaID: integer;
        FFiscalCode: string;
        function CheckReferID(ReferID: string): Boolean;
        procedure Setdata(const Value: TStringList);
        procedure SetEndDate(const Value: TDateTime);
        procedure SetStartDate(const Value: TDateTime);
    public
        ErrorStr: string;
        constructor Create(AOwner: TComponent; AFileName: string; AFirmaID: integer); reintroduce; virtual;
        destructor Destroy; override;
        procedure Parse60(s: string);
        procedure Parse61(var s: string);
        procedure Parse62(s: string);
        procedure SyncWithDocuments;
        procedure Start;

        function SaveDataToTable: Boolean;

        property FirmaID: integer read FFirmaID write FFirmaID;
        property data: TStringList read Fdata write Setdata;
        property EndDate: TDateTime read FEndDate write SetEndDate;
        property FiscalCode: string read FFiscalCode write FFiscalCode;
        property StartDate: TDateTime read FStartDate write SetStartDate;
    end;

implementation

uses
    SysUtils, System.RegularExpressions, Vcl.Dialogs, ActivityMonitorUnit;

{ TImportECBv4 }

constructor TImportECBv4.Create(AOwner: TComponent; AFileName: string; AFirmaID: integer);
begin
    inherited create;

    data := TStringList.Create;
    FirmaID := AFirmaID;
    IBCConnection := TIBCConnection.Create(AOwner,
        'Data Source=192.168.106.254;Database=sw;User ID=SYSDBA;Password=uigres321;Client Library=fbclient.dll;Login Prompt=False');
    IBCTrUpdate := TIBCTransaction.Create(AOwner);
    ibctrupdate.DefaultConnection := IBCConnection;
    IBCConnection.Connected := True;
    data.LoadFromFile(AFileName);
    var q:=TIBCQuery.Create(nil);
    try
        q.SQL.Text := 'select iden_number from ts_cust_info where customerid = :customerid';
        q.ParamByName('customerid').AsINteger := AFirmaID;
        q.Open;
        FiscalCode := q.FieldByName('iden_number').AsString;
    finally
        q.Free;
    end;

    ErrorStr := '';
end;

destructor TImportECBv4.Destroy;
begin
    data.Free;
    if IBCTrUpdate.Active then
    begin
        try
            IBCTrUpdate.Commit;
        except
            on E: Exception do
                IBCTrUpdate.Rollback;
        end;
    end;

    IBCTrUpdate.Free;

    inherited;
end;

procedure TImportECBv4.SyncWithDocuments;
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(nil);
    try
        if not IBCTrUpdate.Active then
            IBCTrUpdate.StartTransaction;

        Query.Connection := IBCConnection;
        Query.Transaction := IBCTrUpdate;
        Query.SQL.Text := 'select err_referid from SyncECBWithDocs(:dt, :data1,:data2)';
        Query.ParamByName('dt').AsInteger := FirmaID;
        Query.ParamByName('DATA1').AsDateTime := StartDate;
        Query.ParamByName('DATA2').AsDateTime := EndDate;
        try
            Query.Open;
            if ((Query.RecordCount > 0) and (Query.FieldByName('err_referid').AsString = '')) then
            begin
                if IBCTrUpdate.Active then
                    IBCTrUpdate.Commit;
            end
            else
                ShowMessage('Errors: ' + Query.FieldByName('err_referid').AsString);

        except
            on e: Exception do
            begin
                IBCTrUpdate.Rollback;
                raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TImportECBv4.Parse60(s: string);
var
    wYear, wMonth, wDay: Word;
begin
    R60.F1 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F2 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F3 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F4 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F5 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F6 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F7 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F8 := s;

    wYear := StrToInt(Copy(R60.F2, 1, 4));
    wMonth := StrToInt(Copy(R60.F2, 5, 2));
    wDay := StrToInt(Copy(R60.F2, 7, 2));

    StartDate := EncodeDate(wYear, wMonth, wDay);
end;

procedure TImportECBv4.Parse61(var s: string);
//var
//    N: Integer;
begin
    R61.F1 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F2 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F3 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F4 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F5 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F6 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F7 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F8 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F9 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F10 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F11 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F12 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F13 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F14 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F15 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F16 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F17 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F18 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F19 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F20 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F21 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F22 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F23 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F24 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F25 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F26 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F27 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F28 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F29 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F30 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F31 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F32 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F33 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F34 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R61.F35 := Copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
end;

procedure TImportECBv4.Parse62(s: string);
var
    wYear, wMonth, wDay: Word;
begin
    R60.F1 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F2 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F3 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F4 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F5 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F6 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F7 := copy(s, 1, pos('*', s) - 1);
    s := copy(s, pos('*', s) + 1, Length(s));
    R60.F8 := s;

    wYear := StrToInt(Copy(R60.F2, 1, 4));
    wMonth := StrToInt(Copy(R60.F2, 5, 2));
    wDay := StrToInt(Copy(R60.F2, 7, 2));

    EndDate := EncodeDate(wYear, wMonth, wDay);
end;

function TImportECBv4.SaveDataToTable: Boolean;
var
    I: Integer;
    q: TIBCQUery;
    wYear, wMonth, wDay: Word;
begin
    q := TIBCQUery.Create(nil);
    q.Connection := IBCConnection;
    q.Transaction := IBCTrUpdate;
    Result := False;
    try
        q.AutoCommit := False;

        q.SQL.Text := 'update or insert into tdb_docs_banks (referid, internalno, datadoc, sumadt, sumact, ' +
            'customername, customeriban, customeridno, customermfo, customerbankname, description, customerid, sc2,' +
            'r_name, r_account, r_fcode, r_bic, r_amount, p_name, p_account, p_fcode, p_bic, p_amount) ' + sLineBreak +
            'values(:referid, :internalno, :datadoc, :sumadt, :sumact, :customername, :customeriban, :customeridno, ' +
            ':customermfo, :customerbankname, :description, :customerid, :sc2, ' +
            ':r_name, :r_account, :r_fcode, :r_bic, :r_amount, :p_name, :p_account, :p_fcode, :p_bic, :p_amount) ' +
            ' MATCHING  (referid)';

    //    q.ParamByName('DOCID').Value := 0;
        q.ParamByName('referid').AsString := trim(R61.F1);
        q.ParamByName('internalno').AsString := '';

        wYear := StrToInt(Copy(R61.F2, 1, 4));
        wMonth := StrToInt(Copy(R61.F2, 5, 2));
        wDay := StrToInt(Copy(R61.F2, 7, 2));

        q.ParamByName('datadoc').AsDateTime := EncodeDate(wYear, wMonth, wDay);
        q.ParamByName('sumadt').AsFloat := strtofloatdef(R61.F9, 0);
        q.ParamByName('sumact').AsFloat := strtofloatdef(R61.F10, 0);
        q.ParamByName('CUSTOMERID').Value := -1;
        q.ParamByName('sc2').AsInteger := -1;
        if (R61.F6 = 'D') and (FiscalCode = R61.F23) then // Debet
        begin
            q.ParamByName('customername').AsString := R61.F28;
            q.ParamByName('customeriban').AsString := R61.F30;
            q.ParamByName('customeridno').AsString := R61.F29;
            q.ParamByName('customermfo').AsString := R61.F33;

            q.ParamByName('r_name').AsString := R61.F28;
            q.ParamByName('r_account').AsString := R61.F30;
            q.ParamByName('r_fcode').AsString := R61.F29;
            q.ParamByName('r_bic').AsString := R61.F33;
            q.ParamByName('r_amount').AsString := R61.F9;

            if CheckReferID(R61.f1) then
            begin
            // comisionul bancar 2.5 lei
                q.ParamByName('CUSTOMERID').AsInteger := 141407;
                q.ParamByName('sc2').AsInteger := 79; // cheltuieli bancare operationale
            end;
        end
        else
        begin
            if (R61.F6 = 'C') and (FiscalCode = R61.F29) then
            begin
                q.ParamByName('customername').AsString := R61.F22;
                q.ParamByName('customeriban').AsString := R61.F24;
                q.ParamByName('customeridno').AsString := R61.F23;
                q.ParamByName('customermfo').AsString := R61.F27;

                q.ParamByName('p_name').AsString := R61.F22;
                q.ParamByName('p_account').AsString := R61.F24;
                q.ParamByName('p_fcode').AsString := R61.F23;
                q.ParamByName('p_bic').AsString := R61.F27;
                q.ParamByName('p_amount').AsString := R61.F10;
            end
        end;
        q.ParamByName('description').AsString := R61.F34;

        try
            if not IBCTrUpdate.Active then
                IBCTrUpdate.StartTransaction;

            q.ExecSQL;

            if IBCTrUpdate.Active then
                IBCTrUpdate.Commit;

            Result := True;
        except
            ErrorStr := ErrorStr + ' RefferID = ' + R61.F1 + #13#10;
            if IBCTrUpdate.Active then
                IBCTrUpdate.Rollback;
        end;
    finally
        q.Free;
    end;
end;

function TImportECBv4.CheckReferID(ReferID: string): Boolean;
begin
    Result := (pos('-2', ReferID) > 0)
end;

procedure TImportECBv4.Setdata(const Value: TStringList);
begin
    Fdata := Value;
end;

procedure TImportECBv4.SetEndDate(const Value: TDateTime);
begin
    FEndDate := Value;
end;

procedure TImportECBv4.SetStartDate(const Value: TDateTime);
begin
    FStartDate := Value;
end;

procedure TImportECBv4.Start;
var
    OperationCode: string;
begin
    for var I := 0 to data.count - 1 do
    begin
        var s: string := data[I];
        if I = 0 then
            OperationCode := copy(s, 1, pos('*', s) - 1);
        if I > 0 then
            OperationCode := copy(s, 2, pos(':', s, 2) - 2);

        if OperationCode = '60' then
        begin
            s := copy(s, pos(':60:', s) + 4, Length(s));
            Parse60(s);
        end;

        if OperationCode = '61' then
        begin
            s := copy(s, pos(':61:', s) + 4, Length(s));
            Parse61(s);
            SaveDataToTable();
        end;
        if OperationCode = '62' then
        begin
            s := copy(s, pos(':62:', s) + 4, Length(s));
            Parse62(s);
        end;
    end;
//  SaveDataToTable;

  /// adaugam datele importate in TDB_DOCS
    SyncWithDocuments;
end;

end.

