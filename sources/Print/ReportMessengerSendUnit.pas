unit ReportMessengerSendUnit;

{
  Trimiterea semi-automata a unui raport (PDF) pe Viber / WhatsApp / Telegram.

  Niciuna dintre aplicatii nu are un API gratuit care sa trimita un fisier catre un numar de
  telefon oarecare, iar prin linkurile lor nu se poate atasa un fisier. De aceea:
    1. PDF-ul se pune in clipboard ca FISIER (CF_HDROP), exact ca la Copy din Explorer;
    2. se deschide conversatia cu numarul respectiv in aplicatia de pe calculator;
    3. operatorul apasa Ctrl+V si Enter in conversatie.

  Linkuri:
    Viber     viber://chat?number=%2B<numar>
    WhatsApp  whatsapp://send?phone=<numar>      (rezerva: https://wa.me/<numar>)
    Telegram  tg://resolve?phone=<numar>         (rezerva: https://t.me/+<numar>)
  <numar> = format international, doar cifre (ex. 37379123456).
}

interface

uses
  System.SysUtils, System.Classes;

type
  TReportMessenger = (rmViber, rmWhatsApp, rmTelegram);

const
  cReportMessengerNames: array[TReportMessenger] of string = ('Viber', 'WhatsApp', 'Telegram');

// Numarul in format international, doar cifre. Numerele locale din Moldova
// (0XXXXXXXX, 9 cifre) primesc prefixul 373. '' = numarul nu poate fi folosit.
function NormalizePhoneForMessenger(const APhone: string): string;

// Primul telefon al clientului documentului (TDB_DOCS.CT -> TS_CUST_PHONES), '' daca nu exista.
function GetDocumentCustomerPhone(const ADocID: Integer): string;

// Pune fisierul in clipboard ca fisier (CF_HDROP), ca la Copy din Explorer.
procedure CopyFileToClipboard(const AFileName: string);

// Deschide conversatia cu APhoneDigits (deja normalizat). False = nicio aplicatie nu a raspuns.
function OpenMessengerChat(const AMessenger: TReportMessenger; const APhoneDigits: string): Boolean;

implementation

uses
  Winapi.Windows, Winapi.ShellAPI, Winapi.ShlObj, Winapi.ActiveX, Vcl.Clipbrd, IBC, DataModuleDB;

function NormalizePhoneForMessenger(const APhone: string): string;
var
  Ch: Char;
  Digits: string;
begin
  Digits := '';
  for Ch in APhone do
    if CharInSet(Ch, ['0'..'9']) then
      Digits := Digits + Ch;

  // 00373... -> 373...
  if Copy(Digits, 1, 2) = '00' then
    Delete(Digits, 1, 2);

  if (Length(Digits) = 9) and (Digits[1] = '0') then
    // 079123456 -> 37379123456
    Digits := '373' + Copy(Digits, 2, MaxInt)
  else if Length(Digits) = 8 then
    // 79123456 -> 37379123456
    Digits := '373' + Digits;

  if (Length(Digits) < 10) or (Length(Digits) > 15) then
    Digits := '';
  Result := Digits;
end;

function GetDocumentCustomerPhone(const ADocID: Integer): string;
var
  Query: TIBCQuery;
begin
  Result := '';
  if ADocID <= 0 then
    Exit;
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultSelect;
    try
      Query.SQL.Text :=
        'select first 1 P.PHONENUMBER from TDB_DOCS D ' +
        'inner join TS_CUST_PHONES P on P.CUSTOMERID = D.CT ' +
        'where D.DOCID = :DOCID and coalesce(P.PHONENUMBER, '''') <> '''' ' +
        'order by P.PHONEID desc';
      Query.ParamByName('DOCID').AsInteger := ADocID;
      Query.Open;
      if not Query.Eof then
        Result := Trim(Query.Fields[0].AsString);
      Query.Close;
    except
      // telefonul e doar o propunere; fara el operatorul il scrie de mina
      Result := '';
    end;
  finally
    Query.Free;
  end;
end;

procedure CopyFileToClipboard(const AFileName: string);
var
  DropFiles: PDropFiles;
  HGlobal, HEffect: THandle;
  Size: NativeUInt;
  Effect: PDWORD;
  EffectFormat: UINT;
begin
  if not FileExists(AFileName) then
    raise Exception.CreateFmt('Fisierul %s nu exista.', [AFileName]);

  // DROPFILES + calea (Unicode) + dublu terminator
  Size := SizeOf(TDropFiles) + (Length(AFileName) + 2) * SizeOf(WideChar);
  HGlobal := GlobalAlloc(GMEM_MOVEABLE or GMEM_ZEROINIT, Size);
  if HGlobal = 0 then
    RaiseLastOSError;
  DropFiles := GlobalLock(HGlobal);
  try
    DropFiles^.pFiles := SizeOf(TDropFiles);
    DropFiles^.fWide := True;
    Move(PWideChar(AFileName)^, (PByte(DropFiles) + SizeOf(TDropFiles))^, Length(AFileName) * SizeOf(WideChar));
  finally
    GlobalUnlock(HGlobal);
  end;

  // "Preferred DropEffect" = copy; fara el unele aplicatii trateaza lipirea ca mutare
  EffectFormat := RegisterClipboardFormat(CFSTR_PREFERREDDROPEFFECT);
  HEffect := GlobalAlloc(GMEM_MOVEABLE or GMEM_ZEROINIT, SizeOf(DWORD));
  if HEffect <> 0 then
  begin
    Effect := GlobalLock(HEffect);
    Effect^ := DROPEFFECT_COPY;
    GlobalUnlock(HEffect);
  end;

  Clipboard.Open;
  try
    Clipboard.Clear;
    // din acest moment memoria apartine clipboard-ului
    Clipboard.SetAsHandle(CF_HDROP, HGlobal);
    if HEffect <> 0 then
      Clipboard.SetAsHandle(EffectFormat, HEffect);
  finally
    Clipboard.Close;
  end;
end;

function ShellOpen(const AUrl: string): Boolean;
begin
  Result := ShellExecute(0, 'open', PChar(AUrl), nil, nil, SW_SHOWNORMAL) > 32;
end;

function OpenMessengerChat(const AMessenger: TReportMessenger; const APhoneDigits: string): Boolean;
begin
  Result := False;
  if APhoneDigits = '' then
    Exit;
  case AMessenger of
    rmViber:
      Result := ShellOpen('viber://chat?number=%2B' + APhoneDigits);
    rmWhatsApp:
      // aplicatia de pe calculator; daca nu e instalata - varianta web
      Result := ShellOpen('whatsapp://send?phone=' + APhoneDigits) or ShellOpen('https://wa.me/' + APhoneDigits);
    rmTelegram:
      Result := ShellOpen('tg://resolve?phone=' + APhoneDigits) or ShellOpen('https://t.me/+' + APhoneDigits);
  end;
end;

end.
