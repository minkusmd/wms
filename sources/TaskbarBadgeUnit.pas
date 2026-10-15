unit TaskbarBadgeUnit;

{ Numarul pe butonul SWN din taskbar, ca la mesagerii (Viber, Telegram): un cerc rosu cu
  cifra alba, pus peste iconita aplicatiei prin ITaskbarList3.SetOverlayIcon.

  SetTaskbarBadge(Handle, N) - N <= 0 scoate insigna. Ultima valoare se tine minte:
  la mesajul TaskbarButtonCreatedMessage (butonul abia creat sau Explorer repornit, cand
  insigna se pierde) fereastra apeleaza ReapplyTaskbarBadge(Handle). }

interface

uses
  Winapi.Windows;

procedure SetTaskbarBadge(AWnd: HWND; ACount: Integer);
procedure ReapplyTaskbarBadge(AWnd: HWND);

var
  TaskbarButtonCreatedMessage: UINT = 0;

implementation

uses
  System.SysUtils,
  System.Win.ComObj,
  Winapi.ShlObj,
  Winapi.GDIPAPI,
  Winapi.GDIPOBJ;

var
  GTaskbar: ITaskbarList3;
  GLastCount: Integer = 0;

function Taskbar: ITaskbarList3;
// Creat la nevoie; dupa o eroare (Explorer repornit) se recreeaza la urmatorul apel.
begin
  if GTaskbar = nil then
  try
    GTaskbar := CreateComObject(CLSID_TaskbarList) as ITaskbarList3;
    if Failed(GTaskbar.HrInit) then
      GTaskbar := nil;
  except
    GTaskbar := nil;
  end;
  Result := GTaskbar;
end;

function CreateBadgeIcon(ACount, ASize: Integer): HICON;
var
  Bmp: TGPBitmap;
  G: TGPGraphics;
  Brush: TGPSolidBrush;
  Font: TGPFont;
  Fmt: TGPStringFormat;
  Text: string;
  FontSize, Border: Single;
begin
  Result := 0;
  if ACount > 99 then
    Text := '99+'
  else
    Text := IntToStr(ACount);
  case Length(Text) of
    1: FontSize := ASize * 0.72;
    2: FontSize := ASize * 0.6;
  else
    FontSize := ASize * 0.42;
  end;
  // marginea alba desparte cercul de iconita de dedesubt
  Border := ASize / 16;

  Bmp := TGPBitmap.Create(ASize, ASize, PixelFormat32bppARGB);
  try
    G := TGPGraphics.Create(Bmp);
    try
      G.SetSmoothingMode(SmoothingModeAntiAlias);
      G.SetTextRenderingHint(TextRenderingHintAntiAlias);
      G.Clear(MakeColor(0, 0, 0, 0));
      Brush := TGPSolidBrush.Create(MakeColor(255, 255, 255, 255));
      try
        G.FillEllipse(Brush, 0.0, 0.0, ASize * 1.0, ASize * 1.0);
        Brush.SetColor(MakeColor(255, 229, 57, 53));
        G.FillEllipse(Brush, Border, Border, ASize - 2 * Border, ASize - 2 * Border);
        Brush.SetColor(MakeColor(255, 255, 255, 255));
        Font := TGPFont.Create('Segoe UI', FontSize, FontStyleBold, UnitPixel);
        Fmt := TGPStringFormat.Create;
        try
          Fmt.SetAlignment(StringAlignmentCenter);
          Fmt.SetLineAlignment(StringAlignmentCenter);
          Fmt.SetFormatFlags(StringFormatFlagsNoWrap);
          G.DrawString(Text, -1, Font, MakeRect(0.0, 0.0, ASize * 1.0, ASize * 1.0), Fmt, Brush);
        finally
          Fmt.Free;
          Font.Free;
        end;
      finally
        Brush.Free;
      end;
    finally
      G.Free;
    end;
    Bmp.GetHICON(Result);
  finally
    Bmp.Free;
  end;
end;

procedure SetTaskbarBadge(AWnd: HWND; ACount: Integer);
var
  TB: ITaskbarList3;
  Icon: HICON;
  Descr: string;
begin
  if ACount < 0 then
    ACount := 0;
  GLastCount := ACount;
  if AWnd = 0 then
    Exit;
  TB := Taskbar;
  if TB = nil then
    Exit;

  if ACount = 0 then
  begin
    if Failed(TB.SetOverlayIcon(AWnd, 0, nil)) then
      GTaskbar := nil;
    Exit;
  end;

  try
    Icon := CreateBadgeIcon(ACount, GetSystemMetrics(SM_CXSMICON));
  except
    Icon := 0;
  end;
  if Icon = 0 then
    Exit;
  try
    // taskbar-ul isi face propria copie a iconitei
    Descr := Format('Comenzi web noi: %d', [ACount]);
    if Failed(TB.SetOverlayIcon(AWnd, Icon, PChar(Descr))) then
      GTaskbar := nil;
  finally
    DestroyIcon(Icon);
  end;
end;

procedure ReapplyTaskbarBadge(AWnd: HWND);
begin
  if GLastCount > 0 then
  begin
    GTaskbar := nil;
    SetTaskbarBadge(AWnd, GLastCount);
  end;
end;

initialization
  TaskbarButtonCreatedMessage := RegisterWindowMessage('TaskbarButtonCreated');

finalization
  GTaskbar := nil;

end.
