unit PriceListContentTransferUnit;

{
  Copierea continutului preluat de la furnizori in tabelele de productie - procedura universala,
  pentru orice furnizor / pricelist (folosita in frame78PriceList).

  Sursa (completata de loader-ele de continut: Mamico, Imperia, Arvaliscom, parsere Python etc.):
    TS_PRICELIST_ITEMS_IMAGES       (SUPPLIERID, SUPPLIER_GOODS_CODE, ORDERNO, IMAGE - PNG)
    TS_PRICELIST_ITEMS_DESCRIPTION  (SUPPLIERID, SUPPLIER_GOODS_CODE, DESCRIPTION_RO, DESCRIPTION_RU)
  Destinatia:
    TS_GOODS_IMAGE  (GOODSID, IMAGE; ID, ORDERNO, CREATED_BY, IMAGE_HASH le pun trigger-ele)
    TS_GOODS_DSC    (GOODSID, DESCRIPTION_RO = romana, DESCRIPTION = rusa)

  Produsul unui rind din pricelist: TS_PRICELIST_ITEMS.GOODSID, iar daca e gol - legatura
  TS_GOODS_FOREIGN (CUSTOMERID = furnizorul, GOODS_CODE = SUPPLIER_GOODS_CODE); la un cod legat
  de mai multe produse (dubluri) se ia cel cu ID minim. Doar produse reale (FLG_FOLDER = 0).

  Reguli (nu se suprascrie nimic din ce exista):
    - imaginile se copiaza doar la produsele care nu au nicio imagine, in ordinea ORDERNO de la
      furnizor, fara imaginile identice (acelasi hash) repetate in setul furnizorului;
    - descrierea: produsul fara rind in TS_GOODS_DSC primeste RO + RU; la cel care are rind se
      completeaza doar limba goala (text sub cMinDescLen caractere = gol);
    - blob-urile se copiaza pe server (INSERT ... SELECT / MERGE), nu trec prin client;
    - commit la fiecare cCommitEvery produse; oprirea pastreaza ce s-a copiat pina atunci.

  CREATED_BY vine din contextul sesiunii (USER_SESSION.UserID), setat de WMS la logare.
}

interface

uses
  System.SysUtils, System.Classes, IBC;

type
  TContentTransferStats = record
    Pairs: Integer;          // perechi produs - cod procesate
    GoodsImages: Integer;    // produse care au primit imagini
    Images: Integer;         // imagini copiate
    Descriptions: Integer;   // produse la care s-a scris / completat descrierea
    Stopped: Boolean;
  end;

  // progresul: Done / Total; intoarce False pentru oprire
  TContentTransferProgress = reference to function(Done, Total: Integer;
    const Stats: TContentTransferStats): Boolean;

  TPriceListContentTransfer = class
  public
    // estimarea inainte de copiere: produse legate, cite pot primi imagini / descriere
    class procedure Preview(AConnection: TIBCConnection; ASupplierID, APLID: Integer;
      out AGoods, AForImages, AForDescriptions: Integer);
    // copierea propriu-zisa, fara interfata
    class function Execute(AConnection: TIBCConnection; ASupplierID, APLID: Integer;
      AProgress: TContentTransferProgress = nil): TContentTransferStats;
    // cu confirmare, fereastra de progres si rezumat - apelata din frame78
    class function Run(AConnection: TIBCConnection; ASupplierID, APLID: Integer): Boolean;
  end;

implementation

uses
  Winapi.Windows, System.StrUtils, System.UITypes, IBCClasses, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Dialogs;

const
  cCommitEvery = 50;
  cMinDescLen = 20;

  // perechile produs - cod din pricelist
  cSqlPairs =
    'select p.GOODSID, p.CODE ' +
    'from (select coalesce(i.GOODSID, ' +
    '               (select min(f.GOODSID) from TS_GOODS_FOREIGN f ' +
    '                where f.CUSTOMERID = :SUPPLIERID and f.GOODS_CODE = i.SUPPLIER_GOODS_CODE)) GOODSID, ' +
    '             i.SUPPLIER_GOODS_CODE CODE ' +
    '      from TS_PRICELIST_ITEMS i where i.PLID = :PLID) p ' +
    'join TS_GOODS g on g.GOODSID = p.GOODSID and coalesce(g.FLG_FOLDER, 0) = 0 ' +
    'order by p.GOODSID, p.CODE';

  cSqlPreview =
    'select count(distinct p.GOODSID), ' +
    '  count(distinct iif(not exists(select 1 from TS_GOODS_IMAGE x where x.GOODSID = p.GOODSID) ' +
    '    and exists(select 1 from TS_PRICELIST_ITEMS_IMAGES pi where pi.SUPPLIERID = :SUPPLIERID ' +
    '      and pi.SUPPLIER_GOODS_CODE = p.CODE and pi.IMAGE is not null), p.GOODSID, null)), ' +
    '  count(distinct iif(exists(select 1 from TS_PRICELIST_ITEMS_DESCRIPTION pd ' +
    '      where pd.SUPPLIERID = :SUPPLIERID and pd.SUPPLIER_GOODS_CODE = p.CODE ' +
    '        and (char_length(trim(pd.DESCRIPTION_RO)) >= 20 or char_length(trim(pd.DESCRIPTION_RU)) >= 20)) ' +
    '    and not exists(select 1 from TS_GOODS_DSC d where d.GOODSID = p.GOODSID ' +
    '      and char_length(trim(d.DESCRIPTION_RO)) >= 20 and char_length(trim(d.DESCRIPTION)) >= 20), ' +
    '    p.GOODSID, null)) ' +
    'from (select coalesce(i.GOODSID, ' +
    '               (select min(f.GOODSID) from TS_GOODS_FOREIGN f ' +
    '                where f.CUSTOMERID = :SUPPLIERID and f.GOODS_CODE = i.SUPPLIER_GOODS_CODE)) GOODSID, ' +
    '             i.SUPPLIER_GOODS_CODE CODE ' +
    '      from TS_PRICELIST_ITEMS i where i.PLID = :PLID) p ' +
    'join TS_GOODS g on g.GOODSID = p.GOODSID and coalesce(g.FLG_FOLDER, 0) = 0';

  cSqlHasImages =
    'select count(*) from TS_GOODS_IMAGE where GOODSID = :GOODSID';

  // imaginile furnizorului, in ordinea lui, fara repetarea aceleiasi imagini
  cSqlCopyImages =
    'insert into TS_GOODS_IMAGE (GOODSID, IMAGE) ' +
    'select cast(:GOODSID as integer), pi.IMAGE from TS_PRICELIST_ITEMS_IMAGES pi ' +
    'where pi.SUPPLIERID = :SUPPLIERID and pi.SUPPLIER_GOODS_CODE = :CODE and pi.IMAGE is not null ' +
    '  and not exists(select 1 from TS_PRICELIST_ITEMS_IMAGES p2 ' +
    '    where p2.SUPPLIERID = pi.SUPPLIERID and p2.SUPPLIER_GOODS_CODE = pi.SUPPLIER_GOODS_CODE ' +
    '      and p2.IMAGE is not null and coalesce(p2.ORDERNO, 0) < coalesce(pi.ORDERNO, 0) ' +
    '      and hash(p2.IMAGE) = hash(pi.IMAGE)) ' +
    'order by pi.ORDERNO';

  // descrierea: rind nou sau completarea limbii goale
  cSqlMergeDesc =
    'merge into TS_GOODS_DSC d ' +
    'using (select cast(:GOODSID as integer) GOODSID, ' +
    '         iif(char_length(trim(pd.DESCRIPTION_RO)) >= 20, pd.DESCRIPTION_RO, null) RO, ' +
    '         iif(char_length(trim(pd.DESCRIPTION_RU)) >= 20, pd.DESCRIPTION_RU, null) RU ' +
    '       from TS_PRICELIST_ITEMS_DESCRIPTION pd ' +
    '       where pd.SUPPLIERID = :SUPPLIERID and pd.SUPPLIER_GOODS_CODE = :CODE) s ' +
    'on d.GOODSID = s.GOODSID ' +
    'when matched and ((coalesce(char_length(trim(d.DESCRIPTION_RO)), 0) < 20 and s.RO is not null) ' +
    '               or (coalesce(char_length(trim(d.DESCRIPTION)), 0) < 20 and s.RU is not null)) then ' +
    '  update set ' +
    '    DESCRIPTION_RO = iif(coalesce(char_length(trim(d.DESCRIPTION_RO)), 0) < 20, ' +
    '                         coalesce(s.RO, d.DESCRIPTION_RO), d.DESCRIPTION_RO), ' +
    '    DESCRIPTION = iif(coalesce(char_length(trim(d.DESCRIPTION)), 0) < 20, ' +
    '                      coalesce(s.RU, d.DESCRIPTION), d.DESCRIPTION) ' +
    'when not matched and (s.RO is not null or s.RU is not null) then ' +
    '  insert (GOODSID, DESCRIPTION_RO, DESCRIPTION) values (s.GOODSID, s.RO, s.RU)';

function NewQuery(AConnection: TIBCConnection; ATransaction: TIBCTransaction;
  const ASql: string): TIBCQuery;
begin
  Result := TIBCQuery.Create(nil);
  Result.Connection := AConnection;
  Result.Transaction := ATransaction;
  Result.UpdateTransaction := ATransaction;
  Result.AutoCommit := False;
  Result.SQL.Text := ASql;
end;

{ TPriceListContentTransfer }

class procedure TPriceListContentTransfer.Preview(AConnection: TIBCConnection; ASupplierID,
  APLID: Integer; out AGoods, AForImages, AForDescriptions: Integer);
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
begin
  AGoods := 0;
  AForImages := 0;
  AForDescriptions := 0;
  Tr := TIBCTransaction.Create(nil);
  Q := nil;
  try
    Tr.DefaultConnection := AConnection;
    Tr.IsolationLevel := iblReadOnlyReadCommitted;
    Q := NewQuery(AConnection, Tr, cSqlPreview);
    Tr.StartTransaction;
    try
      Q.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
      Q.ParamByName('PLID').AsInteger := APLID;
      Q.Open;
      AGoods := Q.Fields[0].AsInteger;
      AForImages := Q.Fields[1].AsInteger;
      AForDescriptions := Q.Fields[2].AsInteger;
      Q.Close;
    finally
      Tr.Commit;
    end;
  finally
    Q.Free;
    Tr.Free;
  end;
end;

class function TPriceListContentTransfer.Execute(AConnection: TIBCConnection; ASupplierID,
  APLID: Integer; AProgress: TContentTransferProgress): TContentTransferStats;
type
  TPair = record
    GoodsID: Integer;
    Code: string;
  end;
var
  TrRead, TrWrite: TIBCTransaction;
  QPairs, QHas, QImg, QDsc: TIBCQuery;
  Pairs: TArray<TPair>;
  I, N, Copied: Integer;
  Stats: TContentTransferStats;
begin
  Stats := Default(TContentTransferStats);
  TrRead := TIBCTransaction.Create(nil);
  TrWrite := TIBCTransaction.Create(nil);
  QPairs := nil;
  QHas := nil;
  QImg := nil;
  QDsc := nil;
  try
    TrRead.DefaultConnection := AConnection;
    TrRead.IsolationLevel := iblReadOnlyReadCommitted;
    TrWrite.DefaultConnection := AConnection;

    // 1. lista perechilor, citita integral inainte de scriere
    QPairs := NewQuery(AConnection, TrRead, cSqlPairs);
    TrRead.StartTransaction;
    try
      QPairs.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
      QPairs.ParamByName('PLID').AsInteger := APLID;
      QPairs.Open;
      N := 0;
      SetLength(Pairs, 1024);
      while not QPairs.Eof do
      begin
        if N = Length(Pairs) then
          SetLength(Pairs, N * 2);
        Pairs[N].GoodsID := QPairs.Fields[0].AsInteger;
        Pairs[N].Code := QPairs.Fields[1].AsString;
        Inc(N);
        QPairs.Next;
      end;
      SetLength(Pairs, N);
      QPairs.Close;
    finally
      TrRead.Commit;
    end;

    QHas := NewQuery(AConnection, TrWrite, cSqlHasImages);
    QImg := NewQuery(AConnection, TrWrite, cSqlCopyImages);
    QDsc := NewQuery(AConnection, TrWrite, cSqlMergeDesc);

    // 2. copierea, cu commit la fiecare cCommitEvery perechi
    TrWrite.StartTransaction;
    try
      for I := 0 to High(Pairs) do
      begin
        // imaginile - doar la produsul fara nicio imagine
        QHas.ParamByName('GOODSID').AsInteger := Pairs[I].GoodsID;
        QHas.Open;
        try
          Copied := 0;
          if QHas.Fields[0].AsInteger = 0 then
          begin
            QImg.ParamByName('GOODSID').AsInteger := Pairs[I].GoodsID;
            QImg.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
            QImg.ParamByName('CODE').AsString := Pairs[I].Code;
            QImg.ExecSQL;
            Copied := QImg.RowsAffected;
          end;
        finally
          QHas.Close;
        end;
        if Copied > 0 then
        begin
          Inc(Stats.GoodsImages);
          Inc(Stats.Images, Copied);
        end;

        // descrierea - rind nou sau limba lipsa
        QDsc.ParamByName('GOODSID').AsInteger := Pairs[I].GoodsID;
        QDsc.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
        QDsc.ParamByName('CODE').AsString := Pairs[I].Code;
        QDsc.ExecSQL;
        if QDsc.RowsAffected > 0 then
          Inc(Stats.Descriptions);

        Stats.Pairs := I + 1;
        if (I + 1) mod cCommitEvery = 0 then
        begin
          TrWrite.Commit;
          TrWrite.StartTransaction;
        end;

        if Assigned(AProgress) and not AProgress(I + 1, Length(Pairs), Stats) then
        begin
          Stats.Stopped := True;
          Break;
        end;
      end;
      TrWrite.Commit;
    except
      if TrWrite.Active then
        TrWrite.Rollback;
      raise;
    end;
  finally
    QDsc.Free;
    QImg.Free;
    QHas.Free;
    QPairs.Free;
    TrWrite.Free;
    TrRead.Free;
  end;
  Result := Stats;
end;

type
  TTransferProgressForm = class(TForm)
  private
    FInfo: TLabel;
    FBar: TProgressBar;
    FStop: TButton;
    FStopRequested: Boolean;
    procedure StopClick(Sender: TObject);
    procedure DoCloseQuery(Sender: TObject; var CanClose: Boolean);
  public
    constructor CreateProgress(const ACaption: string);
    property StopRequested: Boolean read FStopRequested;
  end;

constructor TTransferProgressForm.CreateProgress(const ACaption: string);
begin
  inherited CreateNew(nil);
  Caption := ACaption;
  BorderStyle := bsDialog;
  Position := poMainFormCenter;
  ClientWidth := 520;
  ClientHeight := 120;
  OnCloseQuery := DoCloseQuery;

  FInfo := TLabel.Create(Self);
  FInfo.Parent := Self;
  FInfo.SetBounds(16, 14, 488, 17);
  FInfo.AutoSize := False;
  FInfo.Caption := 'Se citeste lista produselor...';

  FBar := TProgressBar.Create(Self);
  FBar.Parent := Self;
  FBar.SetBounds(16, 40, 488, 20);

  FStop := TButton.Create(Self);
  FStop.Parent := Self;
  FStop.SetBounds(214, 78, 92, 28);
  FStop.Caption := 'Opreste';
  FStop.OnClick := StopClick;
end;

procedure TTransferProgressForm.StopClick(Sender: TObject);
begin
  FStopRequested := True;
  FStop.Enabled := False;
  FInfo.Caption := 'Se opreste...';
end;

procedure TTransferProgressForm.DoCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // inchiderea ferestrei = oprire; fereastra o inchide Run la final
  StopClick(nil);
  CanClose := False;
end;

class function TPriceListContentTransfer.Run(AConnection: TIBCConnection; ASupplierID,
  APLID: Integer): Boolean;
var
  Goods, ForImages, ForDesc: Integer;
  Form: TTransferProgressForm;
  Stats: TContentTransferStats;
  LastTick: Cardinal;
begin
  Result := False;
  Screen.Cursor := crHourGlass;
  try
    Preview(AConnection, ASupplierID, APLID, Goods, ForImages, ForDesc);
  finally
    Screen.Cursor := crDefault;
  end;

  if Goods = 0 then
  begin
    MessageDlg('In acest pricelist nu sint articole legate de produse.', mtInformation, [mbOK], 0);
    Exit;
  end;
  if (ForImages = 0) and (ForDesc = 0) then
  begin
    MessageDlg(Format('Produse legate: %d.'#13#10 +
      'Nu este nimic de copiat: produsele au deja imagini si descrieri, ' +
      'sau furnizorul nu are continut pentru ele.', [Goods]), mtInformation, [mbOK], 0);
    Exit;
  end;
  if MessageDlg(Format('Pricelist %d, furnizor %d'#13#10#13#10 +
    'Produse legate: %d'#13#10 +
    '  vor primi imagini (nu au nicio imagine): %d'#13#10 +
    '  vor primi descriere RO/RU (lipsa sau incompleta): %d'#13#10#13#10 +
    'Imaginile si descrierile existente nu se modifica. Continuati?',
    [APLID, ASupplierID, Goods, ForImages, ForDesc]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  Form := TTransferProgressForm.CreateProgress('Imagini si descrieri -> produse');
  try
    Form.Show;
    Application.ProcessMessages;
    LastTick := 0;
    Stats := Execute(AConnection, ASupplierID, APLID,
      function(Done, Total: Integer; const S: TContentTransferStats): Boolean
      begin
        if (GetTickCount - LastTick > 150) or (Done = Total) then
        begin
          LastTick := GetTickCount;
          Form.FBar.Max := Total;
          Form.FBar.Position := Done;
          if not Form.StopRequested then
            Form.FInfo.Caption := Format('%d / %d   imagini: %d (la %d produse)   descrieri: %d',
              [Done, Total, S.Images, S.GoodsImages, S.Descriptions]);
          Application.ProcessMessages;
        end;
        Result := not Form.StopRequested;
      end);
  finally
    Form.OnCloseQuery := nil;
    Form.Free;
  end;

  MessageDlg(Format('%s'#13#10#13#10 +
    'Produse procesate: %d'#13#10 +
    'Imagini copiate: %d (la %d produse)'#13#10 +
    'Descrieri scrise / completate: %d',
    [IfThen(Stats.Stopped, 'Oprit de utilizator - ce s-a copiat pina acum ramine salvat.', 'Gata.'),
     Stats.Pairs, Stats.Images, Stats.GoodsImages, Stats.Descriptions]), mtInformation, [mbOK], 0);
  Result := True;
end;

end.
