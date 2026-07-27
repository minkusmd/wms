unit WebMailingSenderUnit;

interface

uses
  System.SysUtils, Classes, IBC, WebMailingTypesUnit;

type
  TWebMailingSender = class(TThread)
  private
    { Private declarations }
    fDBConnection: TIBCConnection;
    fMailingID: Integer;
    fTitle: string;
    fHTMLContent: string;
    fRecipients: TEMailTargetCollection;
    fRunningThreadsCount: Integer;
    fQueueLength: Integer;
    FOnStartSending: TWebMailingOnStartSending;
    FOnProgress: TWebMailingOnProgress;
    fJobFinished: Boolean;
    fStartTime: cardinal;
    fProgressTime: cardinal;
    fRecipientsLeft: Integer;
    fError: string;
    FOnError: TWebMailingOnError;
    FTestMode: Boolean;
    function LoadMailingGeneralInfo(const MailingID: Integer): Boolean;
    procedure ApplyCustomRecipients(const CustomRecipients: TStrings);
    function LoadRecipients(const MailingID: Integer): Boolean;
    procedure WhenRequestMesageInfo(var Host, Username, Password, Subject, Body: string);
    procedure WhenTerminateSendEMailTread(Sender: TObject);
    procedure SetOnProgress(const Value: TWebMailingOnProgress);
    procedure SetOnStartSending(const Value: TWebMailingOnStartSending);
    procedure NotifyStartSending;
    procedure NotifyProgress;
    procedure NotifyError;
    procedure SetOnError(const Value: TWebMailingOnError);
    function VerifyConnection: Boolean;
    procedure SetTestMode(const Value: Boolean);
  public
    { Public declarations }
    constructor Create(const Connection: TIBCConnection); reintroduce;
    destructor Destroy; override;
    property MailingTitle: string read fTitle;
    property JobFinished: Boolean read fJobFinished;
    property TestMode: Boolean read FTestMode write SetTestMode;
    property Error: string read fError;
    function LoadMailing(const MailingID: Integer; const CustomRecipients:
      TStrings): Boolean;
    procedure Execute; override;
    function GetTotalRecipients: Integer;
    function GetTotalSent: Integer;
    function GetTotalTime: cardinal;
    property OnStartSending: TWebMailingOnStartSending read FOnStartSending
      write SetOnStartSending;
    property OnProgress: TWebMailingOnProgress read FOnProgress write SetOnProgress;
    property OnError: TWebMailingOnError read FOnError write SetOnError;
  end;

implementation

uses
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  IdIOHandler, IdGlobalProtocols, IdSSLOpenSSL, IdMessage, IdText;

const
  cHost = 'mail.fantastic.md';
  cUserName = 'noreply';
  cPassword = 'QWEqwe!23';

  { TWebMailingSender }

procedure TWebMailingSender.ApplyCustomRecipients(const CustomRecipients: TStrings);
begin
  fRecipients.Add(CustomRecipients);
end;

constructor TWebMailingSender.Create(const Connection: TIBCConnection);
begin
  inherited Create(True);

  fDBConnection := Connection;
  fRecipients := TEMailTargetCollection.Create;
  fMailingID := -1;
  fQueueLength := 1; // mailing threads at once
  fJobFinished := True;
  FTestMode := False;
end;

destructor TWebMailingSender.Destroy;
begin
  fRecipients.Free;
  inherited;
end;

procedure TWebMailingSender.Execute;
var
  recipient: TEMailTarget;
  hasRecipients: Boolean;
begin
  if fMailingID = -1 then
    raise Exception.Create('Mailing not loaded!');
  if fRecipients.Count = 0 then
    raise Exception.Create('Recipients not loaded!');

  fJobFinished := False;
  Randomize;
  fRunningThreadsCount := 0;

  fRecipientsLeft := fRecipients.Count;
  Synchronize(NotifyStartSending);
  fStartTime := GetTickCount;
  fProgressTime := fStartTime;

  try
    if VerifyConnection then
      repeat
        while (fRecipientsLeft > 0) and not Terminated do
        begin
          hasRecipients := True;
          while hasRecipients and (fRunningThreadsCount < fQueueLength) and not
            Terminated do
          begin
            recipient := fRecipients.GetNextAvailableEMail;
            if recipient <> nil then
            begin
              Dec(fRecipientsLeft);
              recipient.State := etsSending;
              Inc(fRunningThreadsCount);

              with TEMailSendThread.Create(recipient, fDBConnection) do
              begin
                OnGetMessageInfo := WhenRequestMesageInfo;
                OnTerminate := WhenTerminateSendEMailTread;
                // DebugMode:=True;
                Start;
              end;
            end
            else
              hasRecipients := False;

            // if hasRecipients then sleep(10);
          end;

          // if Not Terminated then sleep(100);
        end;
        if not Terminated and (fRunningThreadsCount > 0) then
          sleep(100);
      until (fRunningThreadsCount = 0) or Terminated
    else
    begin
      fError := 'Can not authorize!';
      Synchronize(NotifyError);
    end;
  except
    on E: Exception do
    begin
      fError := E.Message;
      Synchronize(NotifyError);
    end;
  end;
  // mark end time
  fStartTime := GetTickCount - fStartTime;

  fJobFinished := True;
end;

function TWebMailingSender.GetTotalRecipients: Integer;
begin
  Result := fRecipients.Count;
end;

function TWebMailingSender.GetTotalSent: Integer;
begin
  Result := fRecipients.GetSentRecipientsCount;
end;

function TWebMailingSender.GetTotalTime: cardinal;
begin
  Result := fStartTime;
end;

function TWebMailingSender.LoadMailing(const MailingID: Integer; const
  CustomRecipients: TStrings): Boolean;
begin
  Result := False;
  fRecipients.Clear;

  if not LoadMailingGeneralInfo(MailingID) then
    Exit;
  if Assigned(CustomRecipients) then
  begin
    ApplyCustomRecipients(CustomRecipients);
    Result := fRecipients.Count > 0;
  end
  else
    Result := LoadRecipients(MailingID);

  if Result then
    fMailingID := MailingID;
end;

function TWebMailingSender.LoadMailingGeneralInfo(const MailingID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := fDBConnection;
    Query.SQL.Add('SELECT TITLE, HTML_CONTENT');
    Query.SQL.Add('FROM TWEB_MAILINGS M');
    Query.SQL.Add('INNER JOIN TWEB_MAILING_CONTENT C ON C.MAILINGID = M.MAILINGID');
    if FTestMode then
      Query.SQL.Add('WHERE (M.MAILINGID=:id) AND (M.STATE=1)')
    else
      Query.SQL.Add('WHERE (M.MAILINGID=:id) AND (M.STATE=2)');
    Query.ParamByName('id').AsInteger := MailingID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      fTitle := Query.Fields[0].AsString;
      fHTMLContent := Query.Fields[1].AsString;
      Result := True;
    end;
  finally
    Query.Free;
  end;
end;

function TWebMailingSender.LoadRecipients(const MailingID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := fDBConnection;
    Query.SQL.Add('SELECT TARGETID, EMAIL, UIC FROM TWEB_MAILING_TARGETS WHERE MAILINGID=:id AND FLG_SENT=0');
    Query.ParamByName('ID').AsInteger := MailingID;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      fRecipients.Add(Query.Fields[0].AsInteger, Query.Fields[1].AsString, Query.Fields
        [2].AsString);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
  Result := fRecipients.Count > 0;
end;

procedure TWebMailingSender.NotifyError;
begin
  if Assigned(FOnError) then
    FOnError(fError);
end;

procedure TWebMailingSender.NotifyProgress;
begin
  if Assigned(FOnProgress) then
    FOnProgress(fRecipients.GetSentRecipientsCount);
end;

procedure TWebMailingSender.NotifyStartSending;
begin
  if Assigned(FOnStartSending) then
    FOnStartSending(fRecipients.Count);
end;

procedure TWebMailingSender.SetOnError(const Value: TWebMailingOnError);
begin
  FOnError := Value;
end;

procedure TWebMailingSender.SetOnProgress(const Value: TWebMailingOnProgress);
begin
  FOnProgress := Value;
end;

procedure TWebMailingSender.SetOnStartSending(const Value: TWebMailingOnStartSending);
begin
  FOnStartSending := Value;
end;

procedure TWebMailingSender.SetTestMode(const Value: Boolean);
begin
  FTestMode := Value;
end;

function TWebMailingSender.VerifyConnection: Boolean;
var
  smtp: TidSMTP;
//  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  smtp := TidSMTP.Create(nil);
//  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    smtp.Host := cHost;
    smtp.Username := cUserName;
    smtp.Password := cPassword;

//    SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
//    SSLHandler.SSLOptions.Method := sslvTLSv1;
//    SSLHandler.SSLOptions.Mode := sslmUnassigned;
//    SSLHandler.SSLOptions.VerifyMode := [];
//    SSLHandler.SSLOptions.VerifyDepth := 0;
//
//    smtp.IOHandler := SSLHandler;
//    smtp.UseTLS := utUseRequireTLS;

    smtp.Connect;

    Result := smtp.Authenticate;
  finally
    smtp.Free;
//    SSLHandler.Free;
  end;
end;

procedure TWebMailingSender.WhenRequestMesageInfo(var Host, Username, Password,
  Subject, Body: string);
begin
  Host := cHost;
  Username := cUserName;
  Password := cPassword;
  Subject := fTitle;
  Body := fHTMLContent;
end;

procedure TWebMailingSender.WhenTerminateSendEMailTread(Sender: TObject);
var
  elapsedTime: cardinal;
begin
  Dec(fRunningThreadsCount);

  elapsedTime := GetTickCount - fProgressTime;
  if (elapsedTime >= 1000) then
  begin
    Synchronize(NotifyProgress);
    fProgressTime := GetTickCount;
  end;
end;

end.

