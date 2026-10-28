unit PWReportUnit;

{ WMSPriceWatch - raportul Excel (TdxSpreadSheet, aceeasi biblioteca ca in WMS) si
  trimiterea lui in Telegram (sendDocument, canalul din TS_API_CONFIG / COMPETITORS,
  implicit PRICELISTS = "Online :: Fantastic").

  Foile:
    Rezumat       - produsele noastre din categoriile active: pretul nostru, cel mai mic
                    pret la concurenti, diferenta (rosu = sintem mai scumpi)
    Detalii       - fiecare pereche produs al nostru x produs la concurent (cu link)
    Modificari    - preturile schimbate la concurenti in ultimele N ore
    Neasociate    - produsele de pe site-urile concurentilor fara pereche la noi
    Fara concurenta - produsele noastre pentru care nu s-a gasit nimic

  Se ruleaza pe firul principal (VCL). }

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, PWTypes, PWDbUnit;

type
  TPWReportInfo = record
    FileName: string;
    OurGoods: Integer;
    WithCompetition: Integer;
    MoreExpensive: Integer;
    Cheaper: Integer;
    Changes: Integer;
    Unmatched: Integer;
    SiteItems: string;       // "xstore 540, neocomputer 611, ..."
    TopExpensive: string;    // primele rinduri pentru Telegram (HTML)
    function TelegramCaption(const ASinceHours: Double): string;
  end;

// construieste fisierul .xlsx in ADir (sau in "reports" linga exe daca ADir = '')
function PWBuildReport(ADb: TPWDb; AParent: TWinControl; const ADir: string; ASinceHours: Double): TPWReportInfo;
// trimite fisierul in Telegram; False + AError la esec. Scrie si TWEB_COMPETITOR_REPORTS.
function PWSendReport(ADb: TPWDb; const ACfg: TPWConfig; const AInfo: TPWReportInfo; ASinceHours: Double;
  out AError: string): Boolean;

implementation

uses
  System.Generics.Collections, System.Generics.Defaults, System.StrUtils, System.Math, System.DateUtils, Vcl.Graphics, IBC,
  dxSpreadSheet, dxSpreadSheetCore, dxSpreadSheetCoreStyles, dxSpreadSheetTypes, dxSpreadSheetFormatXLSX,
  TelegramApiUnit;

type
  TOurRow = record
    CatTitle: string;
    GoodsID: Integer;
    Code, Title: string;
    OurPrice, MinPrice: Double;
    MinSite: string;
    DiffLei, DiffPct: Double;
    SitesCnt: Integer;
  end;

const
  clLightRed = TColor($CCCCFF);
  clLightGreen = TColor($CCFFCC);
  clHeader = TColor($E0E0E0);

{ TPWReportInfo }

function TPWReportInfo.TelegramCaption(const ASinceHours: Double): string;
begin
  Result := Format('<b>Preturi concurenti</b> %s' + sLineBreak +
    'Produse ale noastre: %d, cu concurenta: %d' + sLineBreak +
    'Mai scumpi ca minimul: <b>%d</b>, mai ieftini: %d' + sLineBreak +
    'Schimbari de pret la concurenti (%.0fh): %d; neasociate: %d' + sLineBreak +
    'Site-uri: %s',
    [FormatDateTime('dd.mm.yyyy hh:nn', Now), OurGoods, WithCompetition, MoreExpensive, Cheaper,
     ASinceHours, Changes, Unmatched, SiteItems]);
  if TopExpensive <> '' then
    Result := Result + sLineBreak + sLineBreak + 'Cele mai mari diferente:' + sLineBreak + TopExpensive;
  if Length(Result) > 1000 then
    Result := Copy(Result, 1, 997) + '...';
end;

{ helpere foaie }

function NewSheet(ASS: TdxSpreadSheet; const ACaption: string; AFirst: Boolean): TdxSpreadSheetTableView;
begin
  if AFirst and (ASS.SheetCount > 0) and (ASS.Sheets[0] is TdxSpreadSheetTableView) then
    Result := TdxSpreadSheetTableView(ASS.Sheets[0])
  else
    Result := TdxSpreadSheetTableView(ASS.AddSheet(ACaption, TdxSpreadSheetTableView));
  Result.Caption := ACaption;
end;

procedure SetHeader(AView: TdxSpreadSheetTableView; const ATitles: array of string; const AWidths: array of Integer);
var
  I: Integer;
begin
  for I := 0 to High(ATitles) do
  begin
    with AView.CreateCell(0, I) do
    begin
      AsString := ATitles[I];
      Style.Font.Style := [fsBold];
      Style.Brush.BackgroundColor := clHeader;
    end;
    if I <= High(AWidths) then
      AView.Columns.CreateItem(I).Size := AWidths[I];
  end;
  AView.FrozenRow := 0;
end;

procedure PutStr(AView: TdxSpreadSheetTableView; ARow, ACol: Integer; const AValue: string);
begin
  if AValue <> '' then
    AView.CreateCell(ARow, ACol).AsString := AValue;
end;

procedure PutNum(AView: TdxSpreadSheetTableView; ARow, ACol: Integer; AValue: Double; const AFormat: string = '#,##0');
begin
  with AView.CreateCell(ARow, ACol) do
  begin
    AsFloat := AValue;
    Style.DataFormat.FormatCode := AFormat;
  end;
end;

procedure PutNumOpt(AView: TdxSpreadSheetTableView; ARow, ACol: Integer; AValue: Double; const AFormat: string = '#,##0');
begin
  if AValue <> 0 then
    PutNum(AView, ARow, ACol, AValue, AFormat);
end;

procedure PutLink(AView: TdxSpreadSheetTableView; ARow, ACol: Integer; const AUrl: string);
begin
  if AUrl = '' then
    Exit;
  AView.CreateCell(ARow, ACol).AsString := 'link';
  AView.Hyperlinks.Add(ARow, ACol).Value := AUrl;
end;

procedure FillRow(AView: TdxSpreadSheetTableView; ARow, AColCount: Integer; AColor: TColor);
var
  I: Integer;
begin
  for I := 0 to AColCount - 1 do
    AView.CreateCell(ARow, I).Style.Brush.BackgroundColor := AColor;
end;

function PWBuildReport(ADb: TPWDb; AParent: TWinControl; const ADir: string; ASinceHours: Double): TPWReportInfo;
var
  SS: TdxSpreadSheet;
  V: TdxSpreadSheetTableView;
  Q: TIBCQuery;
  Tr: TIBCTransaction;
  Row: Integer;
  Dir: string;
  Our: TDictionary<Integer, TOurRow>;
  OurList: TList<TOurRow>;
  R: TOurRow;
  Top: TList<TOurRow>;
  I: Integer;
  Site: string;
  Cnt: Integer;
  Since: TDateTime;
begin
  Result := Default(TPWReportInfo);
  Dir := ADir;
  if Dir = '' then
    Dir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'reports';
  ForceDirectories(Dir);
  Result.FileName := IncludeTrailingPathDelimiter(Dir) +
    Format('preturi_concurenti_%s.xlsx', [FormatDateTime('yyyymmdd_hhnn', Now)]);
  Since := IncMinute(Now, -Round(ASinceHours * 60));

  Our := TDictionary<Integer, TOurRow>.Create;
  OurList := TList<TOurRow>.Create;
  Top := TList<TOurRow>.Create;
  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  SS := TdxSpreadSheet.Create(nil);
  try
    SS.Visible := False;
    SS.Parent := AParent;
    Tr.DefaultConnection := ADb.Connection;
    Q.Connection := ADb.Connection;
    Q.Transaction := Tr;
    Tr.StartTransaction;
    SS.BeginUpdate;
    try
      { ---- Rezumat ---- }
      V := NewSheet(SS, 'Rezumat', True);
      SetHeader(V, ['Categorie', 'GOODSID', 'Cod', 'Denumire', 'Pretul nostru', 'Min concurent', 'Site', 'Diferenta lei',
        'Diferenta %', 'Nr site-uri'], [130, 70, 160, 420, 95, 95, 100, 90, 80, 70]);
      Q.SQL.Text := 'SELECT * FROM SP_COMPETITOR_SUMMARY ORDER BY CAT_TITLE, TITLE';
      Q.Open;
      Row := 1;
      while not Q.Eof do
      begin
        R := Default(TOurRow);
        R.CatTitle := Trim(Q.FieldByName('CAT_TITLE').AsString);
        R.GoodsID := Q.FieldByName('GOODSID').AsInteger;
        R.Code := Trim(Q.FieldByName('CODE').AsString);
        R.Title := Trim(Q.FieldByName('TITLE').AsString);
        R.OurPrice := Q.FieldByName('OUR_PRICE').AsFloat;
        R.MinPrice := Q.FieldByName('MIN_PRICE').AsFloat;
        R.MinSite := Trim(Q.FieldByName('MIN_SITE').AsString);
        R.DiffLei := Q.FieldByName('DIFF_LEI').AsFloat;
        R.DiffPct := Q.FieldByName('DIFF_PCT').AsFloat;
        R.SitesCnt := Q.FieldByName('SITES_CNT').AsInteger;
        Our.AddOrSetValue(R.GoodsID, R);
        OurList.Add(R);
        Inc(Result.OurGoods);

        PutStr(V, Row, 0, R.CatTitle);
        PutNum(V, Row, 1, R.GoodsID, '0');
        PutStr(V, Row, 2, R.Code);
        PutStr(V, Row, 3, R.Title);
        PutNum(V, Row, 4, R.OurPrice);
        if R.MinPrice > 0 then
        begin
          Inc(Result.WithCompetition);
          PutNum(V, Row, 5, R.MinPrice);
          PutStr(V, Row, 6, R.MinSite);
          PutNum(V, Row, 7, R.DiffLei);
          PutNum(V, Row, 8, R.DiffPct, '0.0');
          PutNum(V, Row, 9, R.SitesCnt, '0');
          if R.DiffLei > 0.5 then
          begin
            Inc(Result.MoreExpensive);
            FillRow(V, Row, 10, clLightRed);
            Top.Add(R);
          end
          else if R.DiffLei < -0.5 then
          begin
            Inc(Result.Cheaper);
            FillRow(V, Row, 10, clLightGreen);
          end;
        end;
        Inc(Row);
        Q.Next;
      end;
      Q.Close;

      { ---- Detalii ---- }
      V := NewSheet(SS, 'Detalii', False);
      SetHeader(V, ['Categorie', 'GOODSID', 'Denumirea noastra', 'Pretul nostru', 'Site', 'Denumire pe site', 'Pret site',
        'Pret vechi site', 'In stoc', 'Diferenta lei', 'Diferenta %', 'Asociere', 'Link'],
        [130, 70, 380, 95, 100, 380, 90, 90, 60, 90, 80, 70, 50]);
      Q.SQL.Text :=
        'SELECT c.TITLE AS CAT_TITLE, c.ORDERNO, i.GOODSID, i.TITLE AS SITE_TITLE, i.PRICE, i.OLD_PRICE, i.FLG_IN_STOCK, ' +
        'i.ITEM_URL, i.MATCH_TYPE, s.SITE_CODE ' +
        'FROM TWEB_COMPETITOR_ITEMS i ' +
        'JOIN TWEB_COMPETITOR_SITES s ON s.SITEID = i.SITEID ' +
        'JOIN TWEB_COMPETITOR_CATEGORIES c ON c.CATID = i.CATID ' +
        'WHERE i.FLG_ACTIVE = 1 AND i.GOODSID IS NOT NULL AND i.MATCH_TYPE IN (1, 2) ' +
        'ORDER BY c.ORDERNO, i.GOODSID, s.SITE_CODE';
      Q.Open;
      Row := 1;
      while not Q.Eof do
      begin
        if Our.TryGetValue(Q.FieldByName('GOODSID').AsInteger, R) then
        begin
          PutStr(V, Row, 0, R.CatTitle);
          PutNum(V, Row, 1, R.GoodsID, '0');
          PutStr(V, Row, 2, R.Title);
          PutNum(V, Row, 3, R.OurPrice);
          PutStr(V, Row, 4, Trim(Q.FieldByName('SITE_CODE').AsString));
          PutStr(V, Row, 5, Trim(Q.FieldByName('SITE_TITLE').AsString));
          PutNum(V, Row, 6, Q.FieldByName('PRICE').AsFloat);
          PutNumOpt(V, Row, 7, Q.FieldByName('OLD_PRICE').AsFloat);
          PutStr(V, Row, 8, IfThen(Q.FieldByName('FLG_IN_STOCK').AsInteger = 1, 'da', 'nu'));
          if Q.FieldByName('PRICE').AsFloat > 0 then
          begin
            PutNum(V, Row, 9, R.OurPrice - Q.FieldByName('PRICE').AsFloat);
            PutNum(V, Row, 10, (R.OurPrice - Q.FieldByName('PRICE').AsFloat) * 100 / Q.FieldByName('PRICE').AsFloat, '0.0');
            if R.OurPrice - Q.FieldByName('PRICE').AsFloat > 0.5 then
              FillRow(V, Row, 13, clLightRed)
            else if R.OurPrice - Q.FieldByName('PRICE').AsFloat < -0.5 then
              FillRow(V, Row, 13, clLightGreen);
          end;
          PutStr(V, Row, 11, IfThen(Q.FieldByName('MATCH_TYPE').AsInteger = 2, 'manual', 'auto'));
          PutLink(V, Row, 12, Trim(Q.FieldByName('ITEM_URL').AsString));
          Inc(Row);
        end;
        Q.Next;
      end;
      Q.Close;

      { ---- Modificari ---- }
      V := NewSheet(SS, 'Modificari', False);
      SetHeader(V, ['Cind', 'Site', 'Categorie', 'Denumire pe site', 'Pret vechi', 'Pret nou', 'Diferenta', 'Produsul nostru',
        'Pretul nostru', 'Link'], [110, 100, 130, 420, 90, 90, 90, 380, 95, 50]);
      Q.SQL.Text :=
        'SELECT i.LAST_PRICE_CHANGE, s.SITE_CODE, c.TITLE AS CAT_TITLE, i.TITLE AS SITE_TITLE, i.PREV_PRICE, i.PRICE, ' +
        'i.GOODSID, i.MATCH_TYPE, i.ITEM_URL ' +
        'FROM TWEB_COMPETITOR_ITEMS i ' +
        'JOIN TWEB_COMPETITOR_SITES s ON s.SITEID = i.SITEID ' +
        'JOIN TWEB_COMPETITOR_CATEGORIES c ON c.CATID = i.CATID ' +
        'WHERE i.LAST_PRICE_CHANGE >= :SINCE AND i.PREV_PRICE IS NOT NULL ' +
        'ORDER BY i.LAST_PRICE_CHANGE DESC';
      Q.ParamByName('SINCE').AsDateTime := Since;
      Q.Open;
      Row := 1;
      while not Q.Eof do
      begin
        Inc(Result.Changes);
        PutStr(V, Row, 0, FormatDateTime('dd.mm hh:nn', Q.FieldByName('LAST_PRICE_CHANGE').AsDateTime));
        PutStr(V, Row, 1, Trim(Q.FieldByName('SITE_CODE').AsString));
        PutStr(V, Row, 2, Trim(Q.FieldByName('CAT_TITLE').AsString));
        PutStr(V, Row, 3, Trim(Q.FieldByName('SITE_TITLE').AsString));
        PutNum(V, Row, 4, Q.FieldByName('PREV_PRICE').AsFloat);
        PutNum(V, Row, 5, Q.FieldByName('PRICE').AsFloat);
        PutNum(V, Row, 6, Q.FieldByName('PRICE').AsFloat - Q.FieldByName('PREV_PRICE').AsFloat);
        if (Q.FieldByName('MATCH_TYPE').AsInteger in [1, 2]) and Our.TryGetValue(Q.FieldByName('GOODSID').AsInteger, R) then
        begin
          PutStr(V, Row, 7, R.Title);
          PutNum(V, Row, 8, R.OurPrice);
        end;
        PutLink(V, Row, 9, Trim(Q.FieldByName('ITEM_URL').AsString));
        Inc(Row);
        Q.Next;
      end;
      Q.Close;

      { ---- Neasociate ---- }
      V := NewSheet(SS, 'Neasociate', False);
      SetHeader(V, ['Site', 'Categorie', 'Denumire pe site', 'Cod site', 'Pret', 'In stoc', 'Vazut prima data', 'Link'],
        [100, 130, 480, 90, 90, 60, 110, 50]);
      Q.SQL.Text :=
        'SELECT s.SITE_CODE, c.TITLE AS CAT_TITLE, i.TITLE AS SITE_TITLE, i.SITE_CODE AS ICODE, i.PRICE, i.FLG_IN_STOCK, ' +
        'i.FIRST_SEEN, i.ITEM_URL ' +
        'FROM TWEB_COMPETITOR_ITEMS i ' +
        'JOIN TWEB_COMPETITOR_SITES s ON s.SITEID = i.SITEID ' +
        'JOIN TWEB_COMPETITOR_CATEGORIES c ON c.CATID = i.CATID ' +
        'WHERE i.FLG_ACTIVE = 1 AND (i.GOODSID IS NULL OR i.MATCH_TYPE NOT IN (1, 2)) ' +
        'ORDER BY c.ORDERNO, s.SITE_CODE, i.TITLE';
      Q.Open;
      Row := 1;
      while not Q.Eof do
      begin
        Inc(Result.Unmatched);
        PutStr(V, Row, 0, Trim(Q.FieldByName('SITE_CODE').AsString));
        PutStr(V, Row, 1, Trim(Q.FieldByName('CAT_TITLE').AsString));
        PutStr(V, Row, 2, Trim(Q.FieldByName('SITE_TITLE').AsString));
        PutStr(V, Row, 3, Trim(Q.FieldByName('ICODE').AsString));
        PutNum(V, Row, 4, Q.FieldByName('PRICE').AsFloat);
        PutStr(V, Row, 5, IfThen(Q.FieldByName('FLG_IN_STOCK').AsInteger = 1, 'da', 'nu'));
        PutStr(V, Row, 6, FormatDateTime('dd.mm.yyyy hh:nn', Q.FieldByName('FIRST_SEEN').AsDateTime));
        PutLink(V, Row, 7, Trim(Q.FieldByName('ITEM_URL').AsString));
        Inc(Row);
        Q.Next;
      end;
      Q.Close;

      { ---- Fara concurenta ---- }
      V := NewSheet(SS, 'Fara concurenta', False);
      SetHeader(V, ['Categorie', 'GOODSID', 'Cod', 'Denumire', 'Pretul nostru'], [130, 70, 160, 480, 95]);
      Row := 1;
      for I := 0 to OurList.Count - 1 do
        if OurList[I].MinPrice <= 0 then
        begin
          PutStr(V, Row, 0, OurList[I].CatTitle);
          PutNum(V, Row, 1, OurList[I].GoodsID, '0');
          PutStr(V, Row, 2, OurList[I].Code);
          PutStr(V, Row, 3, OurList[I].Title);
          PutNum(V, Row, 4, OurList[I].OurPrice);
          Inc(Row);
        end;

      { ---- produse per site (pentru legenda) ---- }
      Q.SQL.Text := 'SELECT s.SITE_CODE, COUNT(*) AS CNT FROM TWEB_COMPETITOR_ITEMS i ' +
        'JOIN TWEB_COMPETITOR_SITES s ON s.SITEID = i.SITEID WHERE i.FLG_ACTIVE = 1 GROUP BY s.SITE_CODE ORDER BY s.SITE_CODE';
      Q.Open;
      while not Q.Eof do
      begin
        Site := LowerCase(Trim(Q.FieldByName('SITE_CODE').AsString));
        Cnt := Q.FieldByName('CNT').AsInteger;
        Result.SiteItems := Result.SiteItems + IfThen(Result.SiteItems = '', '', ', ') + Format('%s %d', [Site, Cnt]);
        Q.Next;
      end;
      Q.Close;
      if Result.SiteItems = '' then
        Result.SiteItems := '-';

      { ---- top diferente pentru Telegram ---- }
      Top.Sort(TComparer<TOurRow>.Construct(
        function(const L, Rr: TOurRow): Integer
        begin
          Result := CompareValue(Rr.DiffPct, L.DiffPct);
        end));
      for I := 0 to Min(Top.Count, 8) - 1 do
        Result.TopExpensive := Result.TopExpensive + Format('%s: %.0f vs %.0f lei (%s, +%.0f%%)' + sLineBreak,
          [TelegramEscapeHtml(Copy(Top[I].Title, 1, 60)), Top[I].OurPrice, Top[I].MinPrice,
           LowerCase(Top[I].MinSite), Top[I].DiffPct]);

      SS.ActiveSheet := SS.Sheets[0];
    finally
      SS.EndUpdate;
    end;
    SS.SaveToFile(Result.FileName);
    Tr.Commit;
  finally
    SS.Free;
    Q.Free;
    Tr.Free;
    Our.Free;
    OurList.Free;
    Top.Free;
  end;
end;

function PWSendReport(ADb: TPWDb; const ACfg: TPWConfig; const AInfo: TPWReportInfo; ASinceHours: Double;
  out AError: string): Boolean;
var
  Token, Chat: string;
  ThreadID: Integer;
  Res: TTelegramSendResult;
begin
  AError := '';
  Result := False;
  ADb.TelegramTarget(ACfg.TelegramChannel, Token, Chat, ThreadID);
  if Token = '' then
    AError := 'Lipseste BOT_TOKEN (TS_API_CONFIG / TELEGRAM)'
  else if Chat = '' then
    AError := Format('Canalul %s nu are CHAT_ID (TELEGRAM_CHANNELS) si nici DEFAULT_CHAT_ID nu e completat', [ACfg.TelegramChannel])
  else
  begin
    Res := TelegramSendDocument(Token, Chat, ThreadID, AInfo.FileName, AInfo.TelegramCaption(ASinceHours), 'HTML', False);
    if Res.Ok then
      Result := True
    else
      AError := Format('Telegram HTTP %d: %s', [Res.HttpCode, Res.Description]);
    // legenda cu HTML gresit: reincercam fara formatare
    if (not Result) and Res.IsParseError then
    begin
      Res := TelegramSendDocument(Token, Chat, ThreadID, AInfo.FileName,
        TelegramStripHtml(AInfo.TelegramCaption(ASinceHours)), '', False);
      Result := Res.Ok;
      if Result then
        AError := '';
    end;
  end;
  try
    ADb.ReportLog(AInfo.FileName, AInfo.OurGoods, AInfo.WithCompetition, AInfo.Changes, Result, AError);
  except
    on E: Exception do
      if AError = '' then
        AError := 'Jurnal raport: ' + E.Message;
  end;
end;

end.
