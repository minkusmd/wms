unit TelegramBot;

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient, System.Net.URLClient,
  System.JSON, System.Net.HttpClientComponent;

type
  TTelegramBot = class
  private
    FToken: string;
    FHttpClient: TNetHTTPClient;
    FHttpRequest: TNetHTTPRequest;
    function GetAPIUrl(const Method: string): string;

  public
    constructor Create(const BotToken: string);
    destructor Destroy; override;

    // Trimite mesaj simplu în grup
    function SendMessage(const ChatID: string; const Text: string): Boolean;

    // Trimite mesaj cu formatare HTML
    function SendMessageHTML(const ChatID: string; const Text: string): Boolean;

    // Trimite mesaj cu formatare Markdown
    function SendMessageMarkdown(const ChatID: string; const Text: string): Boolean;

    // Obține update-uri (pentru a afla Chat ID)
    function GetUpdates: string;

    // Obține informații despre bot
    function GetMe: string;

     property Token: String read FToken write FToken;
  end;

// Funcții helper pentru escape
function EscapeHTML(const Text: string): string;
function EscapeMarkdownV2(const Text: string): string;

implementation

{ TTelegramBot }

constructor TTelegramBot.Create(const BotToken: string);
begin
  inherited Create;
  FToken := BotToken;
  FHttpClient := TNetHTTPClient.Create(nil);
  FHttpRequest := TNetHTTPRequest.Create(nil);
  FHttpRequest.Client := FHttpClient;

  // Setări timeout
  FHttpClient.ConnectionTimeout := 10000; // 10 secunde
  FHttpClient.ResponseTimeout := 30000;   // 30 secunde
end;

destructor TTelegramBot.Destroy;
begin
  FHttpRequest.Free;
  FHttpClient.Free;
  inherited;
end;

function TTelegramBot.GetAPIUrl(const Method: string): string;
begin
  Result := Format('https://api.telegram.org/bot%s/%s', [FToken, Method]);
end;

function TTelegramBot.SendMessage(const ChatID: string; const Text: string): Boolean;
var
  Response: IHTTPResponse;
  JsonObj: TJSONObject;
  PostData: TStringStream;
begin
  Result := False;

  try
    // Creează JSON cu parametrii
    JsonObj := TJSONObject.Create;
    try
      JsonObj.AddPair('chat_id', ChatID);
      JsonObj.AddPair('text', Text);

      // Convertește JSON în stream
      PostData := TStringStream.Create(JsonObj.ToString, TEncoding.UTF8);
      try
        // Setează header-ul pentru JSON
        FHttpRequest.CustomHeaders['Content-Type'] := 'application/json';

        // Trimite request
        Response := FHttpRequest.Post(GetAPIUrl('sendMessage'), PostData);

        // Verifică răspunsul
        Result := Response.StatusCode = 200;

        if not Result then
          raise Exception.CreateFmt('Eroare Telegram API: %d - %s',
            [Response.StatusCode, Response.ContentAsString]);

      finally
        PostData.Free;
      end;
    finally
      JsonObj.Free;
    end;

  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create('Eroare la trimiterea mesajului: ' + E.Message);
    end;
  end;
end;

function TTelegramBot.SendMessageHTML(const ChatID: string; const Text: string): Boolean;
var
  Response: IHTTPResponse;
  JsonObj: TJSONObject;
  PostData: TStringStream;
begin
  Result := False;

  try
    JsonObj := TJSONObject.Create;
    try
      JsonObj.AddPair('chat_id', ChatID);
      JsonObj.AddPair('text', Text);
      JsonObj.AddPair('parse_mode', 'HTML');

      PostData := TStringStream.Create(JsonObj.ToString, TEncoding.UTF8);
      try
        FHttpRequest.CustomHeaders['Content-Type'] := 'application/json';
        Response := FHttpRequest.Post(GetAPIUrl('sendMessage'), PostData);
        Result := Response.StatusCode = 200;

        if not Result then
          raise Exception.CreateFmt('Eroare Telegram API: %d - %s',
            [Response.StatusCode, Response.ContentAsString]);
      finally
        PostData.Free;
      end;
    finally
      JsonObj.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('Eroare la trimiterea mesajului HTML: ' + E.Message);
  end;
end;

function TTelegramBot.SendMessageMarkdown(const ChatID: string; const Text: string): Boolean;
var
  Response: IHTTPResponse;
  JsonObj: TJSONObject;
  PostData: TStringStream;
begin
  Result := False;

  try
    JsonObj := TJSONObject.Create;
    try
      JsonObj.AddPair('chat_id', ChatID);
      JsonObj.AddPair('text', Text);
      JsonObj.AddPair('parse_mode', 'MarkdownV2');

      PostData := TStringStream.Create(JsonObj.ToString, TEncoding.UTF8);
      try
        FHttpRequest.CustomHeaders['Content-Type'] := 'application/json';
        Response := FHttpRequest.Post(GetAPIUrl('sendMessage'), PostData);
        Result := Response.StatusCode = 200;

        if not Result then
          raise Exception.CreateFmt('Eroare Telegram API: %d - %s',
            [Response.StatusCode, Response.ContentAsString]);
      finally
        PostData.Free;
      end;
    finally
      JsonObj.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('Eroare la trimiterea mesajului Markdown: ' + E.Message);
  end;
end;

function TTelegramBot.GetUpdates: string;
var
  Response: IHTTPResponse;
  Url: string;
begin
  try
    // Adaugă parametri pentru a primi toate tipurile de update-uri
    Url := GetAPIUrl('getUpdates') + '?allowed_updates=["message","channel_post"]';
    Response := FHttpRequest.Get(Url);
    Result := Response.ContentAsString;
  except
    on E: Exception do
    begin
      Result := '';
      raise Exception.Create('Eroare la obținerea update-urilor: ' + E.Message);
    end;
  end;
end;

function TTelegramBot.GetMe: string;
var
  Response: IHTTPResponse;
begin
  try
    Response := FHttpRequest.Get(GetAPIUrl('getMe'));
    Result := Response.ContentAsString;
  except
    on E: Exception do
    begin
      Result := '';
      raise Exception.Create('Eroare la obținerea informațiilor bot: ' + E.Message);
    end;
  end;
end;

// ============================================================================
// FUNCȚII HELPER
// ============================================================================

function EscapeHTML(const Text: string): string;
begin
  Result := Text;
  Result := StringReplace(Result, '&', '&amp;', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);
end;

function EscapeMarkdownV2(const Text: string): string;
const
  SpecialChars = '_*[]()~`>#+-=|{}.!';
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Text) do
  begin
    if Pos(Text[i], SpecialChars) > 0 then
      Result := Result + '\' + Text[i]
    else
      Result := Result + Text[i];
  end;
end;

end.

// ============================================================================
// ============================================================================
// EXEMPLU DE UTILIZARE ÎN FORMULAR
// ============================================================================
// ============================================================================

{
Adaugă în uses: TelegramBot

procedure TForm1.Button1Click(Sender: TObject);
var
  Bot: TTelegramBot;
  BotToken: string;
  ChatID: string;
begin
  // ÎNLOCUIEȘTE cu datele tale reale!
  BotToken := '123456789:ABCdefGHIjklMNOpqrsTUVwxyz';  // Token-ul de la BotFather
  ChatID := '-1001234567890';  // Chat ID-ul grupului (număr negativ)

  Bot := TTelegramBot.Create(BotToken);
  try
    // Mesaj simplu
    if Bot.SendMessage(ChatID, 'Salut din Delphi! 🚀') then
      ShowMessage('Mesaj trimis cu succes!')
    else
      ShowMessage('Eroare la trimiterea mesajului!');

  finally
    Bot.Free;
  end;
end;

// Pentru a afla Chat ID-ul grupului
procedure TForm1.Button2Click(Sender: TObject);
var
  Bot: TTelegramBot;
  Updates: string;
begin
  Bot := TTelegramBot.Create('TOKEN_TAU_AICI');
  try
    // Trimite mai întâi un mesaj în grup, apoi rulează asta
    Updates := Bot.GetUpdates;
    Memo1.Lines.Text := Updates;  // Caută "chat":{"id":-123456...
  finally
    Bot.Free;
  end;
end;

// ============================================================================
// EXEMPLE HTML - TOATE TAG-URILE SUPORTATE
// ============================================================================

procedure TForm1.ExempleHTML(Sender: TObject);
var
  Bot: TTelegramBot;
  ChatID: string;
  Msg: string;
begin
  Bot := TTelegramBot.Create('TOKEN_TAU');
  ChatID := '-1001234567890';
  try
    // 1. Formatare text de bază
    Bot.SendMessageHTML(ChatID,
      '<b>Bold text</b>' + #10 +
      '<strong>Strong text</strong>' + #10 +
      '<i>Italic text</i>' + #10 +
      '<em>Emphasized text</em>' + #10 +
      '<u>Underlined text</u>' + #10 +
      '<s>Strikethrough text</s>' + #10 +
      '<del>Deleted text</del>');

    // 2. Combinații de formatare
    Bot.SendMessageHTML(ChatID,
      '<b><i>Bold și Italic</i></b>' + #10 +
      '<u><b>Subliniat și Bold</b></u>' + #10 +
      '<s><i>Tăiat și Italic</i></s>');

    // 3. Cod și preformatare
    Bot.SendMessageHTML(ChatID,
      'Folosește funcția: <code>CalculateTotal()</code>' + #10 +
      '<pre>Bloc de cod:' + #10 +
      'var x: Integer;' + #10 +
      'x := 42;</pre>');

    // 4. Cod cu syntax highlighting
    Bot.SendMessageHTML(ChatID,
      '<pre><code class="language-delphi">' +
      'procedure Hello;' + #10 +
      'begin' + #10 +
      '  ShowMessage(' + #39 + 'Hello!' + #39 + ');' + #10 +
      'end;' +
      '</code></pre>');

    // 5. Link-uri
    Bot.SendMessageHTML(ChatID,
      'Vizitează <a href="https://www.embarcadero.com">Embarcadero</a>' + #10 +
      'Documentație: <a href="https://docwiki.embarcadero.com">DocWiki</a>');

    // 6. Spoiler
    Bot.SendMessageHTML(ChatID,
      'Ghici cine a câștigat? <span class="tg-spoiler">Echipa A!</span>');

    // 7. Blockquote
    Bot.SendMessageHTML(ChatID,
      'Cineva a spus:' + #10 +
      '<blockquote>Aceasta este o citație importantă</blockquote>');

    // 8. Blockquote expandabil
    Bot.SendMessageHTML(ChatID,
      '<blockquote expandable>' +
      'Acesta este un text lung care poate fi colaps...' + #10 +
      'Mai multe detalii aici...' + #10 +
      'Și încă mai mult text...' +
      '</blockquote>');

    // 9. Escape caractere speciale
    Bot.SendMessageHTML(ChatID,
      'Comparație: 5 &lt; 10 &amp; 10 &gt; 5' + #10 +
      'HTML: &lt;b&gt;text&lt;/b&gt;');

    // 10. EXEMPLU REAL: Notificare comandă ERP
    Msg := '<b>🛒 COMANDĂ NOUĂ #12345</b>' + #10 + #10 +
           '<b>Client:</b> <i>Ion Popescu</i>' + #10 +
           '<b>Email:</b> <code>ion@example.com</code>' + #10 +
           '<b>Telefon:</b> <code>+40 723 456 789</code>' + #10 + #10 +
           '<b>Produse:</b>' + #10 +
           '  • Laptop Dell - 1 buc × 3.500 RON' + #10 +
           '  • Mouse Logitech - 2 buc × 150 RON' + #10 + #10 +
           '<u>Total:</u> <b>3.800 RON</b>' + #10 + #10 +
           '<b>Status:</b> <span class="tg-spoiler">În așteptare plată</span>' + #10 +
           '<b>Data:</b> <code>23.12.2024 14:30</code>' + #10 + #10 +
           '<blockquote>Observații: Livrare urgentă</blockquote>' + #10 + #10 +
           '<a href="https://erp.example.com/orders/12345">Vezi detalii comandă</a>';

    Bot.SendMessageHTML(ChatID, Msg);

    // 11. EXEMPLU: Alertă stoc scăzut
    Msg := '⚠️ <b>ALERTĂ STOC SCĂZUT</b>' + #10 + #10 +
           '<b>Produs:</b> <code>Laptop Dell Inspiron 15</code>' + #10 +
           '<b>Cod:</b> <code>LAP-DELL-001</code>' + #10 +
           '<b>Stoc actual:</b> <u>3 bucăți</u>' + #10 +
           '<b>Stoc minim:</b> 10 bucăți' + #10 + #10 +
           '<s>Stoc anterior: 15 buc</s>' + #10 + #10 +
           '<i>Acțiune necesară: Comandă urgentă la furnizor</i>';

    Bot.SendMessageHTML(ChatID, Msg);

    // 12. EXEMPLU: Raport zilnic
    Msg := '📊 <b>RAPORT VÂNZĂRI - 23.12.2024</b>' + #10 + #10 +
           '<pre>' +
           'Comenzi:        47' + #10 +
           'Finalizate:     42' + #10 +
           'În procesare:    5' + #10 +
           'Anulate:         0' +
           '</pre>' + #10 +
           '<b>Vânzări:</b> <code>18.500 RON</code>' + #10 +
           '<b>Medie/comandă:</b> <code>440 RON</code>' + #10 + #10 +
           '<blockquote expandable>' +
           '<b>Top 3 produse:</b>' + #10 +
           '1. Laptop Dell (12 buc)' + #10 +
           '2. Mouse Logitech (25 buc)' + #10 +
           '3. Tastatură Razer (8 buc)' +
           '</blockquote>';

    Bot.SendMessageHTML(ChatID, Msg);

    // 13. Folosire funcție EscapeHTML pentru date dinamice
    var
      ClientName, ProductName: string;
    begin
      ClientName := 'Ion & Maria <VIP>';  // are caractere speciale
      ProductName := 'Laptop "Dell" (15")';

      Msg := '<b>Client:</b> ' + EscapeHTML(ClientName) + #10 +
             '<b>Produs:</b> ' + EscapeHTML(ProductName);

      Bot.SendMessageHTML(ChatID, Msg);
    end;

  finally
    Bot.Free;
  end;
end;

// ============================================================================
// EXEMPLE MARKDOWN - TOATE TAG-URILE SUPORTATE
// ============================================================================

procedure TForm1.ExempleMarkdown(Sender: TObject);
var
  Bot: TTelegramBot;
  ChatID: string;
  Msg: string;
begin
  Bot := TTelegramBot.Create('TOKEN_TAU');
  ChatID := '-1001234567890';
  try
    // 1. Formatare text de bază
    Bot.SendMessageMarkdown(ChatID,
      '*Bold text*' + #10 +
      '_Italic text_' + #10 +
      '__Underlined text__' + #10 +
      '~Strikethrough text~' + #10 +
      '||Spoiler text||' + #10 +
      '`Inline code`');

    // 2. Combinații de formatare
    Bot.SendMessageMarkdown(ChatID,
      '*_Bold și Italic_*' + #10 +
      '*__Bold și Subliniat__*' + #10 +
      '_~Italic și Tăiat~_' + #10 +
      '*_~__Toate combinate__~_*');

    // 3. Cod inline cu caractere speciale
    Bot.SendMessageMarkdown(ChatID,
      'SQL\: `SELECT * FROM users WHERE id > 100`' + #10 +
      'Funcție\: `CalculateTotal(price, tax)`');

    // 4. Bloc de cod simplu
    Bot.SendMessageMarkdown(ChatID,
      '```' + #10 +
      'var x: Integer;' + #10 +
      'x := 42;' + #10 +
      'ShowMessage(IntToStr(x));' + #10 +
      '```');

    // 5. Bloc de cod cu syntax highlighting
    Bot.SendMessageMarkdown(ChatID,
      '```delphi' + #10 +
      'procedure Hello;' + #10 +
      'begin' + #10 +
      '  ShowMessage(' + #39 + 'Hello World!' + #39 + ');' + #10 +
      'end;' + #10 +
      '```');

    // 6. Link-uri
    Bot.SendMessageMarkdown(ChatID,
      '[Google](https://google.com)' + #10 +
      '[Embarcadero](https://www.embarcadero.com)' + #10 +
      '[Documentație](https://docwiki.embarcadero.com)');

    // 7. Quote simplu
    Bot.SendMessageMarkdown(ChatID,
      'Cineva a spus\:' + #10 +
      '>Aceasta este o citație importantă');

    // 8. Quote pe mai multe linii
    Bot.SendMessageMarkdown(ChatID,
      '>Prima linie din citat' + #10 +
      '>A doua linie din citat' + #10 +
      '>A treia linie din citat');

    // 9. Quote expandabil
    Bot.SendMessageMarkdown(ChatID,
      '**>Text expandabil care poate fi colaps' + #10 +
      '**>Mai multe detalii aici' + #10 +
      '**>Și încă o linie');

    // 10. EXEMPLU REAL: Notificare comandă ERP
    Msg := '*🛒 COMANDĂ NOUĂ \#12345*' + #10 + #10 +
           '*Client\:* _Ion Popescu_' + #10 +
           '*Email\:* `ion@example.com`' + #10 +
           '*Telefon\:* `\+40 723 456 789`' + #10 + #10 +
           '*Produse\:*' + #10 +
           '  • Laptop Dell \- 1 buc × 3\.500 RON' + #10 +
           '  • Mouse Logitech \- 2 buc × 150 RON' + #10 + #10 +
           '__Total\:__ *3\.800 RON*' + #10 + #10 +
           '*Status\:* ||În așteptare plată||' + #10 +
           '*Data\:* `23\.12\.2024 14\:30`' + #10 + #10 +
           '>Observații\: Livrare urgentă' + #10 + #10 +
           '[Vezi detalii comandă](https://erp.example.com/orders/12345)';

    Bot.SendMessageMarkdown(ChatID, Msg);

    // 11. EXEMPLU: Alertă stoc scăzut
    Msg := '⚠️ *ALERTĂ STOC SCĂZUT*' + #10 + #10 +
           '*Produs\:* `Laptop Dell Inspiron 15`' + #10 +
           '*Cod\:* `LAP\-DELL\-001`' + #10 +
           '*Stoc actual\:* __3 bucăți__' + #10 +
           '*Stoc minim\:* 10 bucăți' + #10 + #10 +
           '~Stoc anterior\: 15 buc~' + #10 + #10 +
           '_Acțiune necesară\: Comandă urgentă la furnizor_';

    Bot.SendMessageMarkdown(ChatID, Msg);

    // 12. EXEMPLU: Raport zilnic cu cod
    Msg := '📊 *RAPORT VÂNZĂRI \- 23\.12\.2024*' + #10 + #10 +
           '```' + #10 +
           'Comenzi:        47' + #10 +
           'Finalizate:     42' + #10 +
           'În procesare:    5' + #10 +
           'Anulate:         0' + #10 +
           '```' + #10 +
           '*Vânzări\:* `18\.500 RON`' + #10 +
           '*Medie/comandă\:* `440 RON`' + #10 + #10 +
           '**>*Top 3 produse\:*' + #10 +
           '**>1\. Laptop Dell \(12 buc\)' + #10 +
           '**>2\. Mouse Logitech \(25 buc\)' + #10 +
           '**>3\. Tastatură Razer \(8 buc\)';

    Bot.SendMessageMarkdown(ChatID, Msg);

    // 13. EXEMPLU: Utilizare funcție helper pentru escape
    var
      ClientName, ProductName: string;
    begin
      ClientName := 'Ion_Popescu (VIP)';  // are caractere speciale
      ProductName := 'Laptop [Dell] - Model #15';

      Msg := '*Client\:* ' + EscapeMarkdownV2(ClientName) + #10 +
             '*Produs\:* ' + EscapeMarkdownV2(ProductName);

      Bot.SendMessageMarkdown(ChatID, Msg);
    end;

    // 14. EXEMPLU: Mesaj de eroare
    Msg := '❌ *EROARE SISTEM*' + #10 + #10 +
           '__Cod eroare\:__ `ERR\-500`' + #10 +
           '__Timp\:__ `23\.12\.2024 15\:45\:30`' + #10 + #10 +
           '```' + #10 +
           'Exception: Access violation' + #10 +
           'Module: OrderProcessor' + #10 +
           'Line: 427' + #10 +
           '```' + #10 + #10 +
           '||Stack trace complet disponibil||';

    Bot.SendMessageMarkdown(ChatID, Msg);

    // 15. EXEMPLU: Lista task-uri
    Msg := '📋 *TASK\-URI PRIORITARE*' + #10 + #10 +
           '✅ ~Procesare comenzi dimineață~ ‼️ *URGENT*' + #10 +
           '⏳ _Verificare stoc produse_' + #10 +
           '📦 __Pregătire expedieri__' + #10 +
           '📞 `Apel furnizor pentru restock`' + #10 + #10 +
           '[Vezi toate task\-urile](https://erp.example.com/tasks)';

    Bot.SendMessageMarkdown(ChatID, Msg);

  finally
    Bot.Free;
  end;
end;

// ============================================================================
// EXEMPLU COMPLET: INTEGRARE CU ERP
// ============================================================================

procedure TForm1.TrimiteNotificareComanda(OrderID: Integer);
var
  Bot: TTelegramBot;
  ChatID: string;
  Msg: string;
  ClientName, ClientEmail, ClientPhone: string;
  TotalAmount: Currency;
  OrderDate: TDateTime;
begin
  // Date din baza de date (exemplu)
  ClientName := 'Ion Popescu';
  ClientEmail := 'ion@example.com';
  ClientPhone := '+40 723 456 789';
  TotalAmount := 3800.00;
  OrderDate := Now;

  Bot := TTelegramBot.Create('TOKEN_TAU');
  ChatID := '-1001234567890';
  try
    // Creează mesajul HTML
    Msg := '<b>🛒 COMANDĂ NOUĂ #' + IntToStr(OrderID) + '</b>' + #10 + #10 +
           '<b>Client:</b> <i>' + EscapeHTML(ClientName) + '</i>' + #10 +
           '<b>Email:</b> <code>' + ClientEmail + '</code>' + #10 +
           '<b>Telefon:</b> <code>' + ClientPhone + '</code>' + #10 + #10 +
           '<u>Total:</u> <b>' + FormatFloat('#,##0.00', TotalAmount) + ' RON</b>' + #10 +
           '<b>Data:</b> <code>' + FormatDateTime('dd.mm.yyyy hh:nn', OrderDate) + '</code>' + #10 + #10 +
           '<a href="https://erp.example.com/orders/' + IntToStr(OrderID) + '">Vezi detalii comandă</a>';

    // Trimite notificarea
    if Bot.SendMessageHTML(ChatID, Msg) then
      ShowMessage('Notificare trimisă în Telegram!')
    else
      ShowMessage('Eroare la trimiterea notificării!');

  finally
    Bot.Free;
  end;
end;

}
