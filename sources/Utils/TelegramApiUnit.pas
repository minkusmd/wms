unit TelegramApiUnit;

(* Client minimal Telegram Bot API (sendMessage / getMe) fara exceptii spre apelant.

   Folosit de SWNService (TelegramServiceUnit - coada TELEGRAM_MESSAGES) si de
   dialogul WMS frmTelegramDialog ("Trimite test"). TelegramBot.pas (mai vechi)
   ramine neatins: el arunca exceptie la orice cod <> 200 si nu citeste retry_after.

   Tokenul face parte din URL - nu se scrie niciodata in jurnale. *)

interface

uses
  System.SysUtils;

type
  TTelegramSendResult = record
    Ok: Boolean;
    HttpCode: Integer;      // 0 = fara raspuns (retea, DNS, timeout)
    ErrorCode: Integer;     // error_code din raspunsul Telegram
    RetryAfter: Integer;    // parameters.retry_after (secunde) la 429
    MessageId: Int64;       // result.message_id la succes
    Description: string;
    // merita reincercat mai tirziu: retea, 5xx, 429
    function IsRetryable: Boolean;
    // 400 "can't parse entities" - HTML-ul mesajului e invalid
    function IsParseError: Boolean;
  end;

function TelegramSendMessage(const AToken, AChatId: string; AThreadId: Integer;
  const AText, AParseMode: string; ASilent: Boolean): TTelegramSendResult;
// sendDocument (multipart): un fisier (ex. Excel) cu legenda optionala (max 1024 caractere).
// Folosit de WMSPriceWatch pentru raportul preturilor concurentilor.
function TelegramSendDocument(const AToken, AChatId: string; AThreadId: Integer;
  const AFileName, ACaption, AParseMode: string; ASilent: Boolean): TTelegramSendResult;
// AInfo = "@username (Nume)" la succes, altfel textul erorii
function TelegramGetMe(const AToken: string; out AInfo: string): Boolean;
// chat-urile din ultimele update-uri ale botului (pentru aflarea CHAT_ID):
// o linie "id  tip  titlu" per chat; botul trebuie sa fie membru/admin si sa existe
// un mesaj recent in chat
function TelegramGetRecentChats(const AToken: string; out AText: string): Boolean;

function TelegramStripHtml(const AText: string): string;
function TelegramEscapeHtml(const AText: string): string;

const
  cTelegramMaxTextLength = 4096;

var
  // adresa API; schimbata doar de teste (server local care imita Telegram)
  TelegramApiBaseUrl: string = 'https://api.telegram.org';

implementation

uses
  System.Classes, System.JSON, System.Net.HttpClient, System.Net.URLClient, System.Net.Mime;

{ TTelegramSendResult }

function TTelegramSendResult.IsRetryable: Boolean;
begin
  Result := (not Ok) and ((HttpCode = 0) or (HttpCode >= 500) or (HttpCode = 429) or (ErrorCode = 429));
end;

function TTelegramSendResult.IsParseError: Boolean;
begin
  Result := (not Ok) and (ErrorCode = 400) and
    (Description.Contains('parse entities') or Description.Contains('Unsupported start tag') or
     Description.Contains('Can''t find end tag'));
end;

procedure ParseResponse(const AJson: string; var R: TTelegramSendResult; out AResult: TJSONValue);
var
  Root: TJSONValue;
  Obj, Params: TJSONObject;
begin
  AResult := nil;
  Root := TJSONObject.ParseJSONValue(AJson);
  if not (Root is TJSONObject) then
  begin
    Root.Free;
    if R.Description = '' then
      R.Description := Copy(AJson, 1, 300);
    Exit;
  end;
  Obj := TJSONObject(Root);
  R.Ok := Obj.GetValue<Boolean>('ok', False);
  R.ErrorCode := Obj.GetValue<Integer>('error_code', 0);
  R.Description := Obj.GetValue<string>('description', '');
  if Obj.TryGetValue<TJSONObject>('parameters', Params) then
    R.RetryAfter := Params.GetValue<Integer>('retry_after', 0);
  // rezultatul ramine in viata cit timp traieste Root -> il clonam
  if Obj.GetValue('result') <> nil then
    AResult := TJSONValue(Obj.GetValue('result').Clone);
  Root.Free;
end;

function CallApi(const AToken, AMethod, ABody: string; out AResult: TJSONValue): TTelegramSendResult;
var
  Http: THTTPClient;
  Src: TStringStream;
  Resp: IHTTPResponse;
begin
  Result := Default(TTelegramSendResult);
  AResult := nil;
  if Trim(AToken) = '' then
  begin
    Result.Description := 'Lipseste BOT_TOKEN (TS_API_CONFIG, TELEGRAM)';
    Result.ErrorCode := 401;
    Exit;
  end;

  Http := THTTPClient.Create;
  Src := nil;
  try
    Http.ConnectionTimeout := 10000;
    Http.ResponseTimeout := 30000;
    try
      if ABody <> '' then
      begin
        Src := TStringStream.Create(ABody, TEncoding.UTF8);
        Resp := Http.Post(TelegramApiBaseUrl + '/bot' + Trim(AToken) + '/' + AMethod, Src, nil,
          [TNetHeader.Create('Content-Type', 'application/json')]);
      end
      else
        Resp := Http.Get(TelegramApiBaseUrl + '/bot' + Trim(AToken) + '/' + AMethod);
    except
      on E: Exception do
      begin
        // mesajul exceptiei nu contine URL-ul, deci nici tokenul
        Result.Description := 'Telegram nu raspunde: ' + E.Message;
        Exit;
      end;
    end;
    Result.HttpCode := Resp.StatusCode;
    ParseResponse(Resp.ContentAsString(TEncoding.UTF8), Result, AResult);
    if (not Result.Ok) and (Result.ErrorCode = 0) then
      Result.ErrorCode := Result.HttpCode;
  finally
    Src.Free;
    Http.Free;
  end;
end;

function TelegramSendMessage(const AToken, AChatId: string; AThreadId: Integer;
  const AText, AParseMode: string; ASilent: Boolean): TTelegramSendResult;
var
  Body: TJSONObject;
  Res: TJSONValue;
  Text: string;
begin
  Text := AText;
  if Length(Text) > cTelegramMaxTextLength then
    Text := Copy(Text, 1, cTelegramMaxTextLength - 3) + '...';

  Body := TJSONObject.Create;
  try
    Body.AddPair('chat_id', Trim(AChatId));
    Body.AddPair('text', Text);
    if AThreadId > 0 then
      Body.AddPair('message_thread_id', TJSONNumber.Create(AThreadId));
    if AParseMode <> '' then
      Body.AddPair('parse_mode', AParseMode);
    if ASilent then
      Body.AddPair('disable_notification', TJSONBool.Create(True));
    Body.AddPair('link_preview_options', TJSONObject.Create.AddPair('is_disabled', TJSONBool.Create(True)));
    Result := CallApi(AToken, 'sendMessage', Body.ToJSON, Res);
  finally
    Body.Free;
  end;
  try
    if Result.Ok and (Res is TJSONObject) then
      Result.MessageId := TJSONObject(Res).GetValue<Int64>('message_id', 0);
  finally
    Res.Free;
  end;
end;

function TelegramSendDocument(const AToken, AChatId: string; AThreadId: Integer;
  const AFileName, ACaption, AParseMode: string; ASilent: Boolean): TTelegramSendResult;
var
  Http: THTTPClient;
  Form: TMultipartFormData;
  Resp: IHTTPResponse;
  Res: TJSONValue;
begin
  Result := Default(TTelegramSendResult);
  if Trim(AToken) = '' then
  begin
    Result.Description := 'Lipseste BOT_TOKEN (TS_API_CONFIG, TELEGRAM)';
    Result.ErrorCode := 401;
    Exit;
  end;
  if not FileExists(AFileName) then
  begin
    Result.Description := 'Fisierul nu exista: ' + AFileName;
    Result.ErrorCode := 404;
    Exit;
  end;

  Http := THTTPClient.Create;
  Form := TMultipartFormData.Create;
  try
    Http.ConnectionTimeout := 10000;
    Http.ResponseTimeout := 120000;
    Form.AddField('chat_id', Trim(AChatId));
    if AThreadId > 0 then
      Form.AddField('message_thread_id', IntToStr(AThreadId));
    if ACaption <> '' then
      Form.AddField('caption', Copy(ACaption, 1, 1024));
    if AParseMode <> '' then
      Form.AddField('parse_mode', AParseMode);
    if ASilent then
      Form.AddField('disable_notification', 'true');
    Form.AddFile('document', AFileName);
    try
      Resp := Http.Post(TelegramApiBaseUrl + '/bot' + Trim(AToken) + '/sendDocument', Form);
    except
      on E: Exception do
      begin
        Result.Description := 'Telegram nu raspunde: ' + E.Message;
        Exit;
      end;
    end;
    Result.HttpCode := Resp.StatusCode;
    Res := nil;
    ParseResponse(Resp.ContentAsString(TEncoding.UTF8), Result, Res);
    try
      if Result.Ok and (Res is TJSONObject) then
        Result.MessageId := TJSONObject(Res).GetValue<Int64>('message_id', 0);
    finally
      Res.Free;
    end;
    if (not Result.Ok) and (Result.ErrorCode = 0) then
      Result.ErrorCode := Result.HttpCode;
  finally
    Form.Free;
    Http.Free;
  end;
end;

function TelegramGetMe(const AToken: string; out AInfo: string): Boolean;
var
  R: TTelegramSendResult;
  Res: TJSONValue;
begin
  R := CallApi(AToken, 'getMe', '', Res);
  try
    Result := R.Ok and (Res is TJSONObject);
    if Result then
      AInfo := '@' + TJSONObject(Res).GetValue<string>('username', '') +
        ' (' + TJSONObject(Res).GetValue<string>('first_name', '') + ')'
    else
      AInfo := Format('HTTP %d: %s', [R.HttpCode, R.Description]);
  finally
    Res.Free;
  end;
end;

function TelegramGetRecentChats(const AToken: string; out AText: string): Boolean;
const
  cKinds: array[0..4] of string = ('message', 'channel_post', 'edited_channel_post', 'my_chat_member', 'edited_message');
var
  R: TTelegramSendResult;
  Res: TJSONValue;
  Upd: TJSONValue;
  Chat: TJSONObject;
  Seen, Lines: TStringList;
  Kind, Id, Title: string;
begin
  R := CallApi(AToken, 'getUpdates?allowed_updates=' +
    '%5B%22message%22%2C%22channel_post%22%2C%22my_chat_member%22%5D', '', Res);
  Seen := TStringList.Create;
  Lines := TStringList.Create;
  try
    Result := R.Ok and (Res is TJSONArray);
    if not Result then
    begin
      AText := Format('HTTP %d: %s', [R.HttpCode, R.Description]);
      Exit;
    end;
    for Upd in TJSONArray(Res) do
      for Kind in cKinds do
        if (Upd is TJSONObject) and TJSONObject(Upd).TryGetValue<TJSONObject>(Kind + '.chat', Chat) then
        begin
          Id := Chat.GetValue<string>('id', '');
          if (Id = '') or (Seen.IndexOf(Id) >= 0) then
            Continue;
          Seen.Add(Id);
          Title := Chat.GetValue<string>('title', '');
          if Title = '' then
            Title := Trim(Chat.GetValue<string>('first_name', '') + ' ' + Chat.GetValue<string>('last_name', ''));
          Lines.Add(Id + '   ' + Chat.GetValue<string>('type', '') + '   ' + Title);
        end;
    if Lines.Count = 0 then
      AText := 'Niciun chat in update-urile recente. Adaugati botul ca administrator in canal, ' +
        'scrieti un mesaj in canal si incercati din nou.'
    else
      AText := Lines.Text;
  finally
    Lines.Free;
    Seen.Free;
    Res.Free;
  end;
end;

function TelegramStripHtml(const AText: string): string;
var
  i: Integer;
  InTag: Boolean;
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create(Length(AText));
  try
    InTag := False;
    for i := 1 to Length(AText) do
      if AText[i] = '<' then
        InTag := True
      else if AText[i] = '>' then
        InTag := False
      else if not InTag then
        SB.Append(AText[i]);
    Result := SB.ToString;
  finally
    SB.Free;
  end;
  Result := StringReplace(Result, '&lt;', '<', [rfReplaceAll]);
  Result := StringReplace(Result, '&gt;', '>', [rfReplaceAll]);
  Result := StringReplace(Result, '&quot;', '"', [rfReplaceAll]);
  Result := StringReplace(Result, '&amp;', '&', [rfReplaceAll]);
end;

function TelegramEscapeHtml(const AText: string): string;
begin
  Result := StringReplace(AText, '&', '&amp;', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);
end;

end.

