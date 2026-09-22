unit SupplierPriceSyncUnit;

{ Sincronizarea preturilor unui furnizor cu site-ul lui - partea comuna tuturor parserelor.

  Furnizorii trimit pricelist rar (ex. o data pe luna), dar pe site preturile se schimba zilnic.
  Un parser concret este doar o "sursa de pret": un descendent al TSupplierPriceSource care stie
  sa gaseasca pretul de pe site dupa codul furnizorului (HiTechPriceSourceUnit,
  MaximumPriceSourceUnit). Tot restul e aici si e identic pentru toti furnizorii.

  Pasii:
    1. articolele active ale furnizorului (FLG_IN_PRICE = bitul 3 din TS_GOODS_FOREIGN.FLAGS)
    2. pretul fiecaruia de pe site (TSupplierPriceSource.FindPrice)
       - fara tranzactie deschisa: parcurgerea dureaza minute
    3. PRICE3 = pret site - TS_CUSTOMER.RRP_DISCOUNT %, cu rotunjirea din ADJUST_RRP_REEVALUATION:
         ceil(round(p - abs(p / 100 * procent)))
       Doua moduri de scriere:
         hsmDirectUpdate (implicit) - UPDATE direct pe TS_GOODS_FOREIGN.PRICE3, doar unde pretul
           s-a schimbat, fiecare articol in tranzactia lui (un articol respins nu le blocheaza
           pe celelalte; celelalte cimpuri ale articolului nu sint atinse)
         hsmReevaluation - o reevaluare noua (DOCTYPEID 1414) cu toate pozitiile gasite, prin
           SP_SITE_REEVAL_ADD_ITEM (DB Model/site_price_reevaluation.sql) + CLOSE_REEVALUARE
    4. pretul de vinzare (PRICE1) si toate protectiile sint in triggerul TS_GOODS_FOREIGN_BIU,
       care ruleaza in ambele moduri

  Articolele negasite pe site (sau fara pret) nu sint atinse: pretul lor ramine neschimbat
  si apar in jurnal.

  In modul reevaluare: daca triggerul respinge un produs la inchidere (ex. mai multe politici de pret), pozitia
  se scoate din reevaluare, se noteaza in jurnal si inchiderea se reia - un singur produs
  cu probleme nu trebuie sa blocheze rularea zilnica. }

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, IBC;

type
  TSupplierSyncLogEvent = reference to procedure(const AMessage: string);

  TSupplierSyncMode = (hsmDirectUpdate, hsmReevaluation);

  // Sursa de pret a unui furnizor. Descendentii implementeaza cautarea pe site.
  TSupplierPriceSource = class
  public
    // numele scurt folosit in parametri si in numele jurnalului (ex. 'hitech')
    class function ParserName: string; virtual; abstract;
    // denumirea afisata (ex. 'Hi-Tech (h-t.md)')
    class function DisplayName: string; virtual; abstract;
    // TS_CUSTOMER.CUSTOMERID al furnizorului
    class function SupplierID: Integer; virtual; abstract;
    // pauza implicita intre cererile catre site
    class function DefaultDelayMs: Integer; virtual;
    constructor Create; virtual;
    // False = produsul nu a fost gasit SIGUR (cod neidentic, mai multe rezultate, fara pret).
    // Erorile de retea se ridica sub forma de exceptie.
    function FindPrice(const ACode: string; out APrice: Currency; out ATitle: string): Boolean; virtual; abstract;
  end;

  TSupplierPriceSourceClass = class of TSupplierPriceSource;

  TSupplierSyncStats = record
    Active: Integer;        // articole active la furnizor
    Found: Integer;         // gasite pe site cu pret
    NotFound: Integer;      // negasite / fara pret - raman neschimbate
    ScrapeErrors: Integer;  // erori de retea / parsare
    Changed: Integer;       // PRICE3 nou diferit de cel vechi
    Rejected: Integer;      // respinse de baza la adaugare sau la inchidere
    DocID: Integer;         // reevaluarea creata (0 = niciuna; mereu 0 in modul direct)
  end;

  TSupplierPriceSync = class
  private
    type
      TItem = record
        GoodsID: Integer;
        GoodsCode: string;
        OldPrice3: Currency;
        SitePrice: Currency;
        Title: string;
      end;
  private
    FConnection: TIBCConnection;
    FFirmaID: Integer;
    FSessionUserID: Integer;
    FSourceClass: TSupplierPriceSourceClass;
    FSupplierID: Integer;
    FRequestDelayMs: Integer;
    FOnLog: TSupplierSyncLogEvent;
    FMode: TSupplierSyncMode;
    FCancelled: Boolean;
    procedure Log(const AMessage: string); overload;
    procedure Log(const AFormat: string; const AArgs: array of const); overload;
    function LoadActiveItems: TList<TItem>;
    procedure ScrapePrices(AItems: TList<TItem>; var AStats: TSupplierSyncStats);
    procedure CreateReevaluation(AItems: TList<TItem>; var AStats: TSupplierSyncStats);
    procedure UpdateDirect(AItems: TList<TItem>; var AStats: TSupplierSyncStats);
    procedure SetSessionUser(AQuery: TIBCQuery);
  public
    // ASessionUserID > 0: seteaza USER_SESSION.UserID pe conexiune (programul de consola);
    // 0 = sesiunea are deja utilizatorul setat (SWN.exe)
    constructor Create(AConnection: TIBCConnection; ASourceClass: TSupplierPriceSourceClass; AFirmaID: Integer;
      ASessionUserID: Integer = 0);
    function Run: TSupplierSyncStats;
    procedure Cancel;
    property Mode: TSupplierSyncMode read FMode write FMode;
    property RequestDelayMs: Integer read FRequestDelayMs write FRequestDelayMs;
    property OnLog: TSupplierSyncLogEvent read FOnLog write FOnLog;
  end;

implementation

uses
  Data.DB, Vcl.Forms;

const
  cMaxCloseRetries = 50;

{ TSupplierPriceSource }

constructor TSupplierPriceSource.Create;
begin
  inherited Create;
end;

class function TSupplierPriceSource.DefaultDelayMs: Integer;
begin
  Result := 250;
end;

{ TSupplierPriceSync }

constructor TSupplierPriceSync.Create(AConnection: TIBCConnection; ASourceClass: TSupplierPriceSourceClass;
  AFirmaID, ASessionUserID: Integer);
begin
  inherited Create;
  FConnection := AConnection;
  FSourceClass := ASourceClass;
  FFirmaID := AFirmaID;
  FSessionUserID := ASessionUserID;
  FSupplierID := ASourceClass.SupplierID;
  FRequestDelayMs := ASourceClass.DefaultDelayMs; // pauza intre cereri, ca sa nu incarcam site-ul
  FMode := hsmDirectUpdate;
end;

procedure TSupplierPriceSync.Cancel;
begin
  FCancelled := True;
end;

procedure TSupplierPriceSync.Log(const AMessage: string);
begin
  if Assigned(FOnLog) then
    FOnLog(AMessage);
end;

procedure TSupplierPriceSync.Log(const AFormat: string; const AArgs: array of const);
begin
  Log(Format(AFormat, AArgs));
end;

function TSupplierPriceSync.LoadActiveItems: TList<TItem>;
var
  Query: TIBCQuery;
  Tr: TIBCTransaction;
  Item: TItem;
begin
  Result := TList<TItem>.Create;
  Query := TIBCQuery.Create(nil);
  Tr := TIBCTransaction.Create(nil);
  try
    Tr.DefaultConnection := FConnection;
    Query.Connection := FConnection;
    Query.Transaction := Tr;
    Tr.StartTransaction;
    try
      Query.SQL.Text :=
        'select GF.GOODSID, GF.GOODS_CODE, coalesce(GF.PRICE3, 0) PRICE3 ' +
        'from TS_GOODS_FOREIGN GF ' +
        'where GF.CUSTOMERID = :CUSTOMERID and get_flg_value(GF.FLAGS, 3) = 1 ' +
        'order by GF.GOODS_CODE';
      Query.ParamByName('CUSTOMERID').AsInteger := FSupplierID;
      Query.Open;
      while not Query.Eof do
      begin
        Item := Default(TItem);
        Item.GoodsID := Query.FieldByName('GOODSID').AsInteger;
        Item.GoodsCode := Trim(Query.FieldByName('GOODS_CODE').AsString);
        Item.OldPrice3 := Query.FieldByName('PRICE3').AsCurrency;
        if Item.GoodsCode <> '' then
          Result.Add(Item);
        Query.Next;
      end;
      Query.Close;
    finally
      if Tr.Active then
        Tr.Rollback;
    end;
  finally
    Query.Free;
    Tr.Free;
  end;
end;

procedure TSupplierPriceSync.ScrapePrices(AItems: TList<TItem>; var AStats: TSupplierSyncStats);
var
  Scraper: TSupplierPriceSource;
  I: Integer;
  Item: TItem;
begin
  Scraper := FSourceClass.Create;
  try
    for I := 0 to AItems.Count - 1 do
    begin
      if FCancelled then
        Break;
      Item := AItems[I];
      try
        if Scraper.FindPrice(Item.GoodsCode, Item.SitePrice, Item.Title) then
          Inc(AStats.Found)
        else
        begin
          Item.SitePrice := 0;
          Inc(AStats.NotFound);
          Log('NEGASIT  %s (produs %d) - pretul ramine neschimbat', [Item.GoodsCode, Item.GoodsID]);
        end;
      except
        on E: Exception do
        begin
          Item.SitePrice := 0;
          Inc(AStats.ScrapeErrors);
          Log('EROARE   %s (produs %d): %s', [Item.GoodsCode, Item.GoodsID, E.Message]);
        end;
      end;
      AItems[I] := Item;

      if (I + 1) mod 50 = 0 then
        Log('... %d / %d verificate', [I + 1, AItems.Count]);
      // in SWN.exe ruleaza pe firul principal: lasam interfata sa respire
      if Application <> nil then
        Application.ProcessMessages;
      Sleep(FRequestDelayMs);
    end;
  finally
    Scraper.Free;
  end;
end;

procedure TSupplierPriceSync.SetSessionUser(AQuery: TIBCQuery);
begin
  if FSessionUserID <= 0 then
    Exit;
  AQuery.SQL.Text := 'select rdb$set_context(''USER_SESSION'', ''UserID'', :USERID) from rdb$database';
  AQuery.ParamByName('USERID').AsInteger := FSessionUserID;
  AQuery.Open;
  AQuery.Close;
end;

procedure TSupplierPriceSync.UpdateDirect(AItems: TList<TItem>; var AStats: TSupplierSyncStats);
const
  // aceeasi formula ca in ADJUST_RRP_REEVALUATION; procentul vine de pe furnizor
  cNewPrice3 =
    'ceil(round(cast(:SITE as double precision) - abs(cast(:SITE2 as double precision) / 100 * ' +
    'coalesce((select RRP_DISCOUNT from TS_CUSTOMER where CUSTOMERID = :CUSTOMERID), 0))))';
var
  Query: TIBCQuery;
  Tr: TIBCTransaction;
  I: Integer;
  Item: TItem;
  NewPrice3: Currency;
begin
  Query := TIBCQuery.Create(nil);
  Tr := TIBCTransaction.Create(nil);
  try
    Tr.DefaultConnection := FConnection;
    Query.Connection := FConnection;
    Query.Transaction := Tr;

    Tr.StartTransaction;
    try
      SetSessionUser(Query);
      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;

    for I := 0 to AItems.Count - 1 do
    begin
      Item := AItems[I];
      if Item.SitePrice <= 0 then
        Continue;
      // fiecare articol in tranzactia lui: triggerul TS_GOODS_FOREIGN_BIU poate respinge un produs
      Tr.StartTransaction;
      try
        Query.SQL.Text := 'select ' + cNewPrice3 + ' from rdb$database';
        Query.ParamByName('SITE').AsFloat := Item.SitePrice;
        Query.ParamByName('SITE2').AsFloat := Item.SitePrice;
        Query.ParamByName('CUSTOMERID').AsInteger := FSupplierID;
        Query.Open;
        NewPrice3 := Query.Fields[0].AsCurrency;
        Query.Close;

        if NewPrice3 = Item.OldPrice3 then
        begin
          Tr.Rollback;
          Continue;
        end;

        Query.SQL.Text :=
          'update TS_GOODS_FOREIGN set PRICE3 = :PRICE3, CURRENCY3ID = 498, LAST_PRICE_DATE = current_timestamp ' +
          'where CUSTOMERID = :CUSTOMERID and GOODSID = :GOODSID and GOODS_CODE = :GOODS_CODE';
        Query.ParamByName('PRICE3').AsFloat := NewPrice3;
        Query.ParamByName('CUSTOMERID').AsInteger := FSupplierID;
        Query.ParamByName('GOODSID').AsInteger := Item.GoodsID;
        Query.ParamByName('GOODS_CODE').AsString := Item.GoodsCode;
        Query.Execute;
        if Query.RowsAffected <> 1 then
          raise Exception.CreateFmt('UPDATE a atins %d rinduri in loc de 1.', [Query.RowsAffected]);
        Tr.Commit;

        Inc(AStats.Changed);
        Log('SCHIMBAT %s (produs %d): site %s -> PRICE3 %s (era %s)  %s',
          [Item.GoodsCode, Item.GoodsID, CurrToStr(Item.SitePrice), CurrToStr(NewPrice3),
           CurrToStr(Item.OldPrice3), Item.Title]);
      except
        on E: Exception do
        begin
          if Tr.Active then
            Tr.Rollback;
          Inc(AStats.Rejected);
          Log('RESPINS  %s (produs %d): %s', [Item.GoodsCode, Item.GoodsID, E.Message]);
        end;
      end;
    end;
  finally
    Query.Free;
    Tr.Free;
  end;
end;

procedure TSupplierPriceSync.CreateReevaluation(AItems: TList<TItem>; var AStats: TSupplierSyncStats);
var
  Query: TIBCQuery;
  Tr: TIBCTransaction;
  I, Retry, P: Integer;
  Item: TItem;
  NewPrice3: Currency;
  BadCode, Msg: string;
  Closed: Boolean;
begin
  Query := TIBCQuery.Create(nil);
  Tr := TIBCTransaction.Create(nil);
  try
    Tr.DefaultConnection := FConnection;
    Query.Connection := FConnection;
    Query.Transaction := Tr;
    Tr.StartTransaction;
    try
      SetSessionUser(Query);

      // acelasi apel ca Tframe78PriceList.AddDocumentReeveluare
      Query.SQL.Text :=
        'select newdocid from sp_create_new_document (:dt, :ct, -1, -1, -1, -1, 0, 0, 498, 0, 1, 1, -1, 0, 1414, 0, -1, -1)';
      Query.ParamByName('DT').AsInteger := FFirmaID;
      Query.ParamByName('CT').AsInteger := FSupplierID;
      Query.Open;
      AStats.DocID := Query.FieldByName('NEWDOCID').AsInteger;
      Query.Close;
      if AStats.DocID <= 0 then
        raise Exception.Create('Reevaluarea nu a putut fi creata.');

      Query.SQL.Text :=
        'select OLD_PRICE3, NEW_PRICE3 from SP_SITE_REEVAL_ADD_ITEM(:ADOCID, :AGOODSID, :AGOODS_CODE, :ASITE_PRICE)';
      for I := 0 to AItems.Count - 1 do
      begin
        Item := AItems[I];
        if Item.SitePrice <= 0 then
          Continue;
        try
          Query.ParamByName('ADOCID').AsInteger := AStats.DocID;
          Query.ParamByName('AGOODSID').AsInteger := Item.GoodsID;
          Query.ParamByName('AGOODS_CODE').AsString := Item.GoodsCode;
          Query.ParamByName('ASITE_PRICE').AsCurrency := Item.SitePrice;
          Query.Open;
          NewPrice3 := Query.FieldByName('NEW_PRICE3').AsCurrency;
          Query.Close;
          if NewPrice3 <> Item.OldPrice3 then
          begin
            Inc(AStats.Changed);
            Log('SCHIMBAT %s (produs %d): site %s -> PRICE3 %s (era %s)  %s',
              [Item.GoodsCode, Item.GoodsID, CurrToStr(Item.SitePrice), CurrToStr(NewPrice3),
               CurrToStr(Item.OldPrice3), Item.Title]);
          end;
        except
          on E: Exception do
          begin
            Query.Close;
            Inc(AStats.Rejected);
            Log('RESPINS  %s (produs %d) la adaugare: %s', [Item.GoodsCode, Item.GoodsID, E.Message]);
          end;
        end;
      end;

      // inchiderea: un produs respins de trigger se scoate si se reia
      Closed := False;
      Retry := 0;
      while not Closed do
        try
          Query.SQL.Text := 'execute procedure close_reevaluare(:docid)';
          Query.ParamByName('DOCID').AsInteger := AStats.DocID;
          Query.Execute;
          Closed := True;
        except
          on E: Exception do
          begin
            Inc(Retry);
            Msg := E.Message;
            // CLOSE_REEVALUARE raporteaza produsul vinovat ca "goodscode: <cod>[..."
            BadCode := '';
            P := Pos('goodscode: ', Msg);
            if P > 0 then
            begin
              BadCode := Copy(Msg, P + Length('goodscode: '), MaxInt);
              P := Pos('[', BadCode);
              if P > 0 then
                BadCode := Copy(BadCode, 1, P - 1);
              BadCode := Trim(BadCode);
            end;
            if (BadCode = '') or (Retry > cMaxCloseRetries) then
              raise;
            Inc(AStats.Rejected);
            Log('RESPINS  %s la inchidere (scos din reevaluare): %s', [BadCode, Msg]);
            Query.SQL.Text := 'delete from TDB_GOODS_PRICE where DOCID = :DOCID and SUPPLIER_GOODS_CODE = :CODE';
            Query.ParamByName('DOCID').AsInteger := AStats.DocID;
            Query.ParamByName('CODE').AsString := BadCode;
            Query.Execute;
            if Query.RowsAffected = 0 then
              raise Exception.Create('Inchiderea reevaluarii a esuat: ' + Msg);
          end;
        end;

      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      AStats.DocID := 0;
      raise;
    end;
  finally
    Query.Free;
    Tr.Free;
  end;
end;

function TSupplierPriceSync.Run: TSupplierSyncStats;
var
  Items: TList<TItem>;
begin
  Result := Default(TSupplierSyncStats);
  FCancelled := False;
  Items := LoadActiveItems;
  try
    Result.Active := Items.Count;
    Log('%s, furnizor %d: %d articole active in pricelist.', [FSourceClass.DisplayName, FSupplierID, Items.Count]);
    if Items.Count = 0 then
      Exit;

    ScrapePrices(Items, Result);
    if FCancelled then
    begin
      Log('Oprit de utilizator - nu s-a creat nicio reevaluare.');
      Exit;
    end;
    Log('Site: %d gasite, %d negasite, %d erori.', [Result.Found, Result.NotFound, Result.ScrapeErrors]);

    if Result.Found = 0 then
    begin
      Log('Niciun pret citit de pe site - nu se modifica nimic.');
      Exit;
    end;
    // site-ul pare cazut sau si-a schimbat structura: mai bine nimic decit o actualizare partiala
    if Result.Found * 2 < Result.Active then
    begin
      Log('Mai putin de jumatate din articole au fost gasite pe site - nu se modifica nimic. ' +
        'Verificati site-ul / parserul.');
      Exit;
    end;

    if FMode = hsmReevaluation then
    begin
      CreateReevaluation(Items, Result);
      Log('Reevaluarea %d inchisa: %d pozitii, %d preturi schimbate, %d respinse.',
        [Result.DocID, Result.Found - Result.Rejected, Result.Changed, Result.Rejected]);
    end
    else
    begin
      UpdateDirect(Items, Result);
      Log('Gata: %d preturi schimbate direct in TS_GOODS_FOREIGN, %d respinse, %d neschimbate.',
        [Result.Changed, Result.Rejected, Result.Found - Result.Changed - Result.Rejected]);
    end;
  finally
    Items.Free;
  end;
end;

end.
