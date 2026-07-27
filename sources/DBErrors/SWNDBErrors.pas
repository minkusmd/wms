unit SWNDBErrors;
{
 Procesarea erorilor din baza de date in baza clasului de eroare EIBCError.

 Descrierea erorilor se incarca din baza de date. Tabelul: RDB$EXCEPTIONS
}

interface
Uses Classes, SysUtils, IBC, IBCError;

type

  TSWNDBError = class
  private
    { private declarations }
    fMessage: String;
    fException: String;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const AException, AMessage:String);

    property Exception:String read fException;
    property Message:String read fMessage;
  end;


  TSWNException = class(TSWNDBError)
  private
    { private declarations }
    fAdditionalText: String;
    fExceptionID: integer;
    fProcedureInfo: String;
    fGoodsList: String;
    fTriggerInfo: String;
    fHasLockRecordInfo: Boolean;
    fLockedUserName: String;
    fLockedUserID: Integer;
    fLockedFirmaID: integer;
    fLockedFirmaName: String;
    fLockedProcess:String;
    fLockedIPAddress:String;
    fDocID: integer;
    function GetLockRecordInfo: String;
  protected
    { protected declarations }
  public
    { public declarations }
    property ExceptionID:integer read fExceptionID;
    property AdditionalText:String read fAdditionalText;
    property ProcedureInfo:String read fProcedureInfo;
    property GoodsList:String read fGoodsList;
    property HasLockRecordInfo:Boolean read fHasLockRecordInfo;
    property LockRecordInfo:String read GetLockRecordInfo;
    property DocID:integer read fDocID;
  end;

  TSWNDBErrors = class
  private
    { private declarations }
  protected
    { protected declarations }
    fErrors:TList;
    fExceptions:TList;
    procedure ClearErrors;
    procedure ClearExceptions;
    function GetExceptionFromText(const ExceptionText:String):TSWNDBError;
    procedure GetAdditionalExceptionInfo(const ErrorText:String; const SWNException:TSWNException);
    procedure ReadLockTransactionInfo(const TransactionID:Integer; const SWNException:TSWNException);
    procedure AddManualErrors;
    function GetDocumentTypeTitle(const DocID:integer):String;
  public
    { public declarations }
    constructor Create;
    destructor Destroy;override;

    procedure ReadErrorsFromDB(const Connection:TIBCConnection);


    function GetSWNException(const AException:Exception):TSWNException;
    function FormatSWNException(const SWNException:TSWNException):String;

  end;

  function ProcessSWNError(const AException:Exception):Boolean;

var
  SWNDatabaseErrors:TSWNDBErrors;


implementation
Uses SWNUtils;

function ProcessSWNError(const AException:Exception):Boolean;
var Error:TSWNDBError;
    SWNException:TSWNException;
begin
     Result:=False;
     if Assigned(SWNDatabaseErrors) then
     begin
          if (AException is EIBCError) then
          begin
               Error:=SWNDatabaseErrors.GetExceptionFromText(AException.Message);
               if Assigned(Error) then
               begin
                    SWNException:=TSWNException.Create(Error.Exception,Error.Message);
                    try
                       SWNDatabaseErrors.GetAdditionalExceptionInfo(AException.Message,SWNException);
//                       if (SWNSecurityManager.LoggedUser.IsInAdminGroup) then
                           ShowErrorDialog('Eroare!', Error.Message, SWNDatabaseErrors.FormatSWNException(SWNException), AException.Message);
//                       else
//                           ShowErrorDialog('Ошибка базы данных!', Error.Message, SWNDatabaseErrors.FormatSWNException(SWNException));
                       //ShowErrorDialog('Ошибка базы данных!',Error.Message, AException.Message {SWNDatabaseErrors.FormatSWNException(SWNException)});
                       Result:=True;
                    finally
                       SWNException.Free;
                    end;
               end;
          end
          else
          begin
               Error:=SWNDatabaseErrors.GetExceptionFromText(AException.Message);
               if Assigned(Error) then
               begin
                    SWNException:=TSWNException.Create(Error.fException,Error.fMessage);
                    try
                       SWNDatabaseErrors.GetAdditionalExceptionInfo(AException.Message,SWNException);
                       ShowErrorDialog('Eroare!', Error.Message, SWNDatabaseErrors.FormatSWNException(SWNException), AException.Message);
//                       ShowErrorDialog('Eroare!',Error.fMessage,SWNDatabaseErrors.FormatSWNException(SWNException));
                       Result:=True;
                    finally
                       SWNException.Free;
                    end;
               end;
          end;
     end;
end;

{ TSWNDBErrors }

procedure TSWNDBErrors.AddManualErrors;
var Error:TSWNDBError;
begin
     // lock conflict error
     Error:=TSWNDBError.Create('lock conflict on no wait transaction','Inregistrarea este blocata de alt utilizator!');
     fErrors.Add(Error);

     // Foreign key references
     Error:=TSWNDBError.Create('Foreign key references are present for the record','Exista referinta pentru aceasta inregistrare!');
     fErrors.Add(Error);

     // Internal: Счет фактуры
     Error:=TSWNDBError.Create('SYSERROR_SCETFACTURA','Eroare la eliberarea facturii!');
     fErrors.Add(Error);

     // Internal: Report not printed
     Error:=TSWNDBError.Create('SYSERROR_BADREPORT','Eroare la generarea raportului!');
     fErrors.Add(Error);

     // Internal: Report not loaded
     Error:=TSWNDBError.Create('SYSERROR_REPORTNOTFOUND','Eroare la generarea raportului! Sablonul nu este gasit!');
     fErrors.Add(Error);

end;

procedure TSWNDBErrors.ClearErrors;
var i:integer;
    Error:TSWNDBError;
begin
     for i := 0 to fErrors.Count-1 do
     begin
          Error:=TSWNDBError(fErrors[i]);
          Error.Free;
     end;
     fErrors.Clear;
end;

procedure TSWNDBErrors.ClearExceptions;
var i:integer;
    Excep:TSWNException;
begin
     for i := 0 to fExceptions.Count-1 do
     begin
          Excep:=TSWNException(fExceptions[i]);
          Excep.Free;
     end;
     fExceptions.Clear;
end;

constructor TSWNDBErrors.Create;
begin
     fErrors:=TList.Create;
     fExceptions:=TList.Create;
end;

destructor TSWNDBErrors.Destroy;
begin
     try
        ClearExceptions;
        fExceptions.Free;

        ClearErrors;
        fErrors.Free;
     finally
        inherited;
     end;
end;

function TSWNDBErrors.FormatSWNException(const SWNException: TSWNException): String;
begin
     Result:='';

     if SWNException.HasLockRecordInfo then AddErrorToStr(Result,SWNException.GetLockRecordInfo);
     if SWNException.DocID<>-1 then AddErrorToStr(Result,Format('Document: #%d - %s', [SWNException.fDocID,GetDocumentTypeTitle(SWNException.fDocID)]));
     if SWNException.AdditionalText<>'' then AddErrorToStr(Result,Format('Text: "%s"',[SWNException.AdditionalText]));
     if SWNException.fGoodsList<>'' then AddErrorToStr(Result,Format('Produse: [%s]',[SWNException.fGoodsList]));

//     if SWNSecurityManager.LoggedUser.IsSuperAdminUser then
//     begin
          //if SWNException.fExceptionID<>-1 then AddErrorToStr(Result,Format('ID ошибки: %d',[SWNException.fExceptionID]));
          AddErrorToStr(Result,'Eroare: '+SWNException.fException);
          if SWNException.fProcedureInfo<>'' then AddErrorToStr(Result,SWNException.fProcedureInfo);
          if SWNException.fTriggerInfo<>'' then AddErrorToStr(Result,SWNException.fTriggerInfo);
//     end;
end;

procedure TSWNDBErrors.GetAdditionalExceptionInfo(const ErrorText:String; const SWNException: TSWNException);
var L:TStrings;
    i,k,n1,n2:integer;
    S,S2,IDStr:String;
    tmp1:String;
    tmp2,tmp3:Integer;
begin
     SWNException.fAdditionalText:='';
     SWNException.fExceptionID:=-1;
     SWNException.fProcedureInfo:='';
     SWNException.fGoodsList:='';
     SWNException.fHasLockRecordInfo:=False;
     SWNException.fLockedUserName:='';
     SWNException.fLockedUserID:=-1;
     SWNException.fLockedFirmaID:=-1;
     SWNException.fLockedFirmaName:='';
     SWNException.fLockedProcess:='';
     SWNException.fLockedIPAddress:='';
     SWNException.fDocID:=-1;

     L:=TStringList.Create;
     try
        L.Text:=ErrorText;
        // remove system lines
        for i := L.Count-1 downto 0 do
        begin
             S:=WideLowerCase(L[i]);

             if Pos('<msg>',S)>0 then
             begin
                  // what remains is additional text
                  n1:=Pos('<msg>',S);
                  n2:=Pos('</msg>',S);
                  SWNException.fAdditionalText := UTF8ToString(Trim(Copy(L[i],n1+5,n2-n1-5)));
             end;

             if Pos('<docid>',S)>0 then
             begin
                  // DocID
                  n1:=Pos('<docid>',S);
                  n2:=Pos('</docid>',S);
                  SWNException.fDocID:=StrToIntDef(Trim(Copy(L[i],n1+7,n2-n1-7)),-1);
             end;


             if Pos('exception ',S)=1 then
             begin
                  SWNException.fExceptionID:=StrToIntDef(Copy(s,11,Length(S)),-1);
                  //L.Delete(i);
             end
             else
             if Pos('at procedure ',S)=1 then
             begin
                  S2:=L[i];
                  Delete(S2,1,14); // remove text at procedure '
                  k:=pos('''',S2);
                  if k>0 then
                  begin
                       tmp1:=Copy(S2,1,K-1);
                       tmp2:=-1;
                       tmp3:=-1;
                       Delete(S2,1,K+6);
                       K:=Pos(',',S2);
                       if k>0 then
                       begin
                            tmp2:=StrToIntDef(Copy(S2,1,K-1),-1);
                            Delete(S2,1,K);
                            K:=pos('col:',S2);
                            if K>0 then
                            begin
                                 Delete(S2,1,K+4);
                                 tmp3:=StrToIntDef(S2,-1);
                            end;
                       end;
                       if SWNException.fProcedureInfo<>'' then SWNException.fProcedureInfo:=SWNException.fProcedureInfo+#13#10;
                       SWNException.fProcedureInfo:=SWNException.fProcedureInfo+Format('Procedure: %s [%2.2d:%2.2d]',[tmp1,tmp2,tmp3]);
                  end;
                  //L.Delete(i);
             end
             else
             if Pos('at trigger ',S)=1 then
             begin
                  S2:=L[i];
                  Delete(S2,1,12); // remove text [at trigger ']
                  k:=pos('''',S2);
                  if k>0 then
                  begin
                       tmp1:=Copy(S2,1,K-1);
                       tmp2:=-1;
                       tmp3:=-1;
                       Delete(S2,1,K+6);
                       K:=Pos(',',S2);
                       if k>0 then
                       begin
                            tmp2:=StrToIntDef(Copy(S2,1,K-1),-1);
                            Delete(S2,1,K);
                            K:=pos('col:',S2);
                            if K>0 then
                            begin
                                 Delete(S2,1,K+4);
                                 tmp3:=StrToIntDef(S2,-1);
                            end;
                       end;
                       if SWNException.fTriggerInfo<>'' then SWNException.fTriggerInfo:=SWNException.fTriggerInfo+#13#10;
                       SWNException.fTriggerInfo:=SWNException.fTriggerInfo+Format('Trigger: %s [%2.2d:%2.2d]',[tmp1,tmp2,tmp3]);
                  end;
                  //L.Delete(i);
             end
             else
             if Pos('concurrent transaction number is ',S)>0 then
             begin
                  // concurrent transaction number is 9160557
                  n1:=Pos('number is ',S);
                  if (n1>0) then
                  begin
                       IDStr:=Trim(Copy(S,n1+10,Length(S)));
                       K:=StrToIntDef(IDStr,-1);
                       if (K>0) then ReadLockTransactionInfo(K,SWNException);
                  end;
                  //L.Delete(i);
             end;
        end;

     finally
        L.Free;
     end;
end;

function TSWNDBErrors.GetDocumentTypeTitle(const DocID: integer): String;
var Query:TIBCQuery;
begin
     Result:='';
     Query:=TIBCQuery.Create(nil);
     try
        Query.SQL.Add('SELECT (SELECT TITLE FROM TS_DOCTYPES WHERE TS_DOCTYPES.DOCTYPEID=TDB_DOCS.DOCTYPEID)');
        Query.SQL.Add('FROM TDB_DOCS WHERE DOCID=:DOCID');
        Query.ParamByName('DOCID').AsInteger:=DocID;
        Query.ExecSQL;
        if Not Query.Eof then Result:=Query.Fields[0].AsString;
     finally
        Query.Free;
     end;
end;

function TSWNDBErrors.GetExceptionFromText(const ExceptionText: String): TSWNDBError;
var i:integer;
    Error:TSWNDBError;
begin
     Result:=nil;
     for i := 0 to fErrors.Count-1 do
     begin
          Error:=TSWNDBError(fErrors[i]);
          if Pos(Error.fException,ExceptionText)>0 then
          begin
               Result:=Error;
               Break;
          end;
     end;
end;

function TSWNDBErrors.GetSWNException(const AException: Exception): TSWNException;
var Error:TSWNDBError;
begin
     Result:=nil;
     Error:=GetExceptionFromText(AException.Message);
     if Assigned(Error) then
     begin
          Result:=TSWNException.Create(Error.fException,Error.fMessage);
          fExceptions.Add(Result);
          GetAdditionalExceptionInfo(AException.Message,Result);
     end;
end;

procedure TSWNDBErrors.ReadErrorsFromDB(const Connection: TIBCConnection);
var Query:TIBCQuery;
    error,desc:String;
begin
     ClearErrors;

     AddManualErrors;

     Query:=TIBCQuery.Create(nil);
     try
        Query.Connection:=Connection;
        Query.SQL.Text:='SELECT RDB$EXCEPTION_NAME, RDB$MESSAGE FROM RDB$EXCEPTIONS';
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             error:=Query.Fields[0].AsString;
             desc:=Query.Fields[1].AsString;
             fErrors.Add(TSWNDBError.Create(error,desc));
             Query.Next;
        end;
        Query.Close;
     finally
        Query.Free;
     end;
end;

procedure TSWNDBErrors.ReadLockTransactionInfo(const TransactionID: Integer;
  const SWNException: TSWNException);
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(nil);
     try
        Query.SQL.Text:='SELECT * FROM SP_SYS_GET_TRANSACTION_INFO(:ID)';
        Query.ParamByName('ID').AsInteger:=TransactionID;
        Query.ExecSQL;
        if Not Query.Eof then
        begin
             SWNException.fHasLockRecordInfo:=True;
             SWNException.fLockedUserName:=Query.FieldByName('USER_FULL_NAME').AsString;
             SWNException.fLockedUserID:=Query.FieldByName('USERID').AsInteger;
             SWNException.fLockedFirmaID:=Query.FieldByName('DEFAULT_DT').AsInteger;
             SWNException.fLockedFirmaName:=Query.FieldByName('DEFAULT_DT_NAME').AsString;
             SWNException.fLockedProcess:=ExtractFileName(Query.FieldByName('APP_NAME').AsString);
             SWNException.fLockedIPAddress:=Query.FieldByName('REMOTE_ADDR').AsString;
        end;
     finally
        Query.Free;
     end;
end;

{ TSWNDBError }

constructor TSWNDBError.Create(const AException, AMessage:String);
begin
     fException:=AException;
     fMessage:=AMessage;
end;


{ TSWNException }

function TSWNException.GetLockRecordInfo: String;
begin
     Result:='';
     if fHasLockRecordInfo then
     begin
          Result:=Format('Пользователь: %s',[fLockedUserName]);
          if (fLockedFirmaName<>'') then Result:=Result+#13#10+Format('Фирма: %s',[fLockedFirmaName])
          else
          begin
               if (fLockedProcess<>'') then Result:=Result+#13#10+Format('Программа: %s',[fLockedProcess]);
               if (fLockedIPAddress<>'') then Result:=Result+#13#10+Format('IP адрес: %s',[fLockedIPAddress]);
          end;
     end;

end;

initialization

 SWNDatabaseErrors:=nil;

finalization

 if Assigned(SWNDatabaseErrors) then FreeAndNil(SWNDatabaseErrors);

end.
