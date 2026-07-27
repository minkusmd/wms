unit WebMailingTypesUnit;

interface

Uses Classes, SysUtils, IBC;

type

  TWebMailingOnStartSending = procedure(const TotalRecipients: Integer) of object;
  TWebMailingOnError = procedure(const ErrorText: String) of object;
  TWebMailingOnProgress = procedure(const SentRecipients: Integer) of object;
  TWebMailingOnGetMessageInfo = procedure(var Host, Username, Password, Subject, Body: String) of object;

  TEMailTargetState = (etsNew, etsSending, etsSent, etsError);

  TEMailTarget = class
  private
    { Private declarations }
    fTargetID: Integer;
    fEMail: String;
    fState: TEMailTargetState;
    fError: String;
    fUIC: String;
    procedure SetState(const Value: TEMailTargetState);
  public
    { Public declarations }
    constructor Create(const AEMail: String); overload;
    constructor Create(const ATargetID: Integer; const AEMail, AUIC: String); overload;

    property EMail: String read fEMail;
    property TargetID: Integer read fTargetID;
    property UIC: String read fUIC;
    property State: TEMailTargetState read fState write SetState;
  end;

  TEMailTargetCollection = class(TList)
  private
    function GetItems(Index: Integer): TEMailTarget;
    procedure SetItems(Index: Integer; const Value: TEMailTarget);
  public
    { Public declarations }

    property Items[Index: Integer]: TEMailTarget read GetItems write SetItems; default;

    function Add(const TargetID: Integer; const EMail, UIC: String): TEMailTarget; reintroduce; overload;
    procedure Add(const ListOfEMails: TStrings); overload;
    procedure Clear; override;

    function GetNewRecipientsCount: Integer;
    function GetSentRecipientsCount: Integer;
    function GetNextAvailableEMail: TEMailTarget;
  end;

  TEMailSendThread = class(TThread)
  private
    { Private declarations }
    fDBConnection: TIBCConnection;
    fEMailTarget: TEMailTarget;
    FOnGetMessageInfo: TWebMailingOnGetMessageInfo;
    FDebugMode: Boolean;
    procedure SetOnGetMessageInfo(const Value: TWebMailingOnGetMessageInfo);
    procedure SetDebugMode(const Value: Boolean);

    procedure MarkTargetAsSent;
  public
    { Public declarations }
    constructor Create(const EMailTarget: TEMailTarget; const DBConnection: TIBCConnection); reintroduce;
    property OnGetMessageInfo: TWebMailingOnGetMessageInfo read FOnGetMessageInfo write SetOnGetMessageInfo;
    property DebugMode: Boolean read FDebugMode write SetDebugMode;

    procedure Execute; override;
  end;

implementation

Uses IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, IdIOHandler, IdGlobalProtocols, IdSSLOpenSSL,
  IdMessage, IdText;

{ TEMailTarget }

constructor TEMailTarget.Create(const AEMail: String);
begin
  fTargetID := -1;
  fEMail := AEMail;
  fState := etsNew;
  fError := '';
end;

constructor TEMailTarget.Create(const ATargetID: Integer; const AEMail, AUIC: String);
begin
  fTargetID := ATargetID;
  fEMail := AEMail;
  fState := etsNew;
  fError := '';
  fUIC := AUIC;
end;

procedure TEMailTarget.SetState(const Value: TEMailTargetState);
begin
  fState := Value;
end;

{ TEMailTargetCollection }

function TEMailTargetCollection.Add(const TargetID: Integer; const EMail, UIC: String): TEMailTarget;
begin
  Result := TEMailTarget.Create(TargetID, EMail, UIC);
  inherited Add(Result);
end;

procedure TEMailTargetCollection.Add(const ListOfEMails: TStrings);
var
  i: Integer;
begin
  for i := 0 to ListOfEMails.Count - 1 do
    if Trim(ListOfEMails[i]) <> '' then
      Add(-1, ListOfEMails[i], '');
end;

procedure TEMailTargetCollection.Clear;
var
  i: Integer;
  obj: TEMailTarget;
begin
  for i := 0 to Count - 1 do
  begin
    obj := TEMailTarget(Items[i]);
    obj.Free;
  end;
  inherited Clear;
end;

function TEMailTargetCollection.GetItems(Index: Integer): TEMailTarget;
begin
  Result := TEMailTarget(inherited Items[Index]);
end;

function TEMailTargetCollection.GetNewRecipientsCount: Integer;
var
  obj: TEMailTarget;
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    obj := TEMailTarget(inherited Items[i]);
    if (obj.State = etsNew) then
      Inc(Result);
  end;
end;

function TEMailTargetCollection.GetNextAvailableEMail: TEMailTarget;
var
  obj: TEMailTarget;
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    obj := TEMailTarget(inherited Items[i]);
    if (obj.State = etsNew) then
    begin
      Result := obj;
      break;
    end;
  end;
end;

function TEMailTargetCollection.GetSentRecipientsCount: Integer;
var
  obj: TEMailTarget;
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    obj := TEMailTarget(inherited Items[i]);
    if (obj.State = etsSent) then
      Inc(Result);
  end;
end;

procedure TEMailTargetCollection.SetItems(Index: Integer; const Value: TEMailTarget);
begin
  Items[Index] := Value;
end;

{ TEMailSendThread }

constructor TEMailSendThread.Create(const EMailTarget: TEMailTarget; const DBConnection: TIBCConnection);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  fEMailTarget := EMailTarget;
  FDebugMode := False;
  fDBConnection := DBConnection;
end;

procedure TEMailSendThread.Execute;
var
  smtp: TidSMTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  msg: TIdMessage;
  Host, Username, Password, Subject, html_body: String;
begin
  if FDebugMode then
  begin
    Sleep(Random(100));
    fEMailTarget.fState := etsSent;
    // if fEMailTarget.fTargetID<>-1 then MarkTargetAsSent(fEMailTarget.fTargetID);
    Exit;
  end;

  // get subject and body data
  FOnGetMessageInfo(Host, Username, Password, Subject, html_body);
  html_body := StringReplace(html_body, '$TARGETUIC', fEMailTarget.fUIC, [rfReplaceAll, rfIgnoreCase]);

  smtp := TidSMTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    smtp.Host := Host;
    smtp.Username := Username;
    smtp.Password := Password;
    {
      SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      SSLHandler.SSLOptions.Method := sslvTLSv1;
      SSLHandler.SSLOptions.Mode := sslmUnassigned;
      SSLHandler.SSLOptions.VerifyMode := [];
      SSLHandler.SSLOptions.VerifyDepth := 0;
    }
    // smtp.IOHandler := SSLHandler;
    // smtp.UseTLS := utUseRequireTLS;

    smtp.Connect;

    if smtp.Authenticate then
    begin
      msg := TIdMessage.Create(nil);
      try
        msg.Recipients.EMailAddresses := fEMailTarget.fEMail;
        msg.From.Name := 'Fantastic';
        msg.From.Address := 'noreply@fantastic.md';
        msg.Subject := Subject;

        msg.CharSet := 'UTF-8';
        msg.ContentTransferEncoding := 'BASE64';
        msg.ContentType := 'multipart/mixed';
        msg.Encoding := meMIME;

        with TIdText.Create(msg.MessageParts, nil) do
        begin
          // text/html
          ContentDisposition := 'inline';
          Body.Text := html_body;
          ContentType := 'text/html';
          CharSet := 'UTF-8';
        end;

        try
          // send message
          smtp.Send(msg);
          // mark as Sent
          fEMailTarget.fState := etsSent;

        except
          on E: Exception do
          begin
            fEMailTarget.fState := etsError;
            fEMailTarget.fError := E.Message;
          end;
        end;
      finally
        msg.Free;
      end;
    end
    else
    begin
      fEMailTarget.fState := etsError;
      fEMailTarget.fError := 'Can not Authenticate!';
    end;
  finally
    smtp.Free;
    SSLHandler.Free;
  end;
  if fEMailTarget.fTargetID <> -1 then
    MarkTargetAsSent;
end;

procedure TEMailSendThread.MarkTargetAsSent;
var
  Query: TIBCQuery;
  Transaction: TIBCTransaction;
begin
  Query := TIBCQuery.Create(nil);
  Transaction := TIBCTransaction.Create(nil);
  try
    Transaction.DefaultConnection := fDBConnection;
    Query.Connection := fDBConnection;
    Query.Transaction := Transaction;
    Query.AutoCommit := False;
    Query.SQL.Text := 'UPDATE TWEB_MAILING_TARGETS SET FLG_SENT=1, ERROR_TEXT=:err WHERE TARGETID=:id';
    Query.ParamByName('id').AsInteger := fEMailTarget.fTargetID;
    Query.ParamByName('err').AsString := fEMailTarget.fError;
    Query.Transaction.StartTransaction;
    try
      Query.Execute;
      Query.Transaction.Commit;
    except
      Query.Transaction.Rollback;
    end;
  finally
    Query.Free;
    Transaction.Free;
  end;
end;

procedure TEMailSendThread.SetDebugMode(const Value: Boolean);
begin
  FDebugMode := Value;
end;

procedure TEMailSendThread.SetOnGetMessageInfo(const Value: TWebMailingOnGetMessageInfo);
begin
  FOnGetMessageInfo := Value;
end;

end.
