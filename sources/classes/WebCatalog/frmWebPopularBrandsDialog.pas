unit frmWebPopularBrandsDialog;

{
  Brandurile populare de pe prima pagina a site-ului (blocul de dupa slider): lista si ordinea,
  plus logo-ul brandului (TS_BRANDS_IMAGE), fara de care brandul nu apare pe site.

  Cum le citeste site-ul (fantastic.web, models/PopularBrands.php):
    intii brandurile din TWEB_POPULAR_BRANDS in ordinea ORDERNO, apoi - pina la 12 -
    completeaza automat dupa suma scorurilor TWEB_GOODS_RANK a produselor de pe site.
    Un brand fara logo in TS_BRANDS_IMAGE e sarit (si cel ales aici).
    Lista e in cache o ora; logo-ul se regenereaza singur cind i se schimba marimea.

  BRANDID = TS_SYSS.SYSSID = TS_GOODS.VENDOR_ID = TS_BRANDS_IMAGE.BRANDID.
  Tabela se creeaza cu DB Model/web_popular_brands.sql.

  Totul se lucreaza in memorie si se scrie intr-o singura tranzactie la "Salveaza";
  ORDERNO se renumeroteaza 1..N.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.Generics.Collections, SWNBaseUnit;

type
  TPopularBrand = record
    BrandID: Integer;
    Title: string;
    HasLogo: Boolean;
    Products: Integer;    // produse ale brandului afisate pe site (TWEB_CACHE_GOODS)
    NewLogo: TBytes;      // logo incarcat in aceasta sesiune, se scrie la salvare
  end;

  TfrmWebPopularBrandsDlg = class(TSWNCustomForm)
    lblInfo: TLabel;
    lvBrands: TListView;
    btnUp: TButton;
    btnDown: TButton;
    btnRemove: TButton;
    pnlLogo: TPanel;
    imgLogo: TImage;
    lblLogoState: TLabel;
    btnLoadLogo: TButton;
    gbAdd: TGroupBox;
    edSearch: TEdit;
    btnSearch: TButton;
    cmbFound: TComboBox;
    btnAdd: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnLoadLogoClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure cmbFoundChange(Sender: TObject);
    procedure lvBrandsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvBrandsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    fItems: TList<TPopularBrand>;
    fRemoved: TList<Integer>;
    fModified: Boolean;
    fTableMissing: Boolean;
    procedure LoadData;
    procedure ShowList(const ASelectIndex: Integer);
    procedure ShowLogo;
    function SelectedIndex: Integer;
    function IndexOfBrand(const ABrandID: Integer): Integer;
    function SiteState(const AIndex: Integer): string;
    procedure MoveSelected(const ADelta: Integer);
    procedure UpdateButtons;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  System.UITypes, System.IOUtils, Data.DB, IBC, DataModuleDB;

{$R *.dfm}

const
  // cite branduri afiseaza blocul de pe site (PopularBrands::LIMIT)
  cSiteLimit = 12;
  cMaxLogoBytes = 2 * 1024 * 1024;

  // cite produse ale brandului sint pe site
  cSqlProducts =
    '(select count(distinct C.GOODSID) from TS_GOODS G ' +
    ' join TWEB_CACHE_GOODS C on C.GOODSID = G.GOODSID where G.VENDOR_ID = %s)';
  cSqlHasLogo =
    'iif(exists(select 1 from TS_BRANDS_IMAGE B where B.BRANDID = %s and B.IMAGE is not null), 1, 0)';

constructor TfrmWebPopularBrandsDlg.Create(AOwner: TComponent);
begin
  inherited;
  fItems := TList<TPopularBrand>.Create;
  fRemoved := TList<Integer>.Create;
end;

destructor TfrmWebPopularBrandsDlg.Destroy;
begin
  fRemoved.Free;
  fItems.Free;
  inherited;
end;

procedure TfrmWebPopularBrandsDlg.Prepare;
begin
  try
    LoadData;
  except
    on E: Exception do
    begin
      // tabela lipseste pina cind DBA ruleaza DB Model/web_popular_brands.sql
      fTableMissing := True;
      MessageDlg('Lista brandurilor populare nu a putut fi citita.' + sLineBreak +
        'Probabil tabela TWEB_POPULAR_BRANDS nu exista inca (DB Model/web_popular_brands.sql).' +
        sLineBreak + sLineBreak + E.Message, mtError, [mbOK], 0);
    end;
  end;
  ShowList(0);
  fModified := False;
end;

procedure TfrmWebPopularBrandsDlg.LoadData;
var
  Query: TIBCQuery;
  Item: TPopularBrand;
begin
  fItems.Clear;
  fRemoved.Clear;
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultSelect;
    Query.SQL.Text :=
      'select P.BRANDID, S.TITLE, ' +
      Format(cSqlHasLogo, ['P.BRANDID']) + ' HAS_LOGO, ' +
      Format(cSqlProducts, ['P.BRANDID']) + ' PRODUCTS ' +
      'from TWEB_POPULAR_BRANDS P ' +
      'join TS_SYSS S on S.SYSSID = P.BRANDID ' +
      'order by P.ORDERNO nulls last, S.TITLE';
    Query.Open;
    while not Query.Eof do
    begin
      Item.BrandID := Query.FieldByName('BRANDID').AsInteger;
      Item.Title := Trim(Query.FieldByName('TITLE').AsString);
      Item.HasLogo := Query.FieldByName('HAS_LOGO').AsInteger = 1;
      Item.Products := Query.FieldByName('PRODUCTS').AsInteger;
      Item.NewLogo := nil;
      fItems.Add(Item);
      Query.Next;
    end;
    Query.Close;
  finally
    Query.Free;
  end;
end;

// Ce se intimpla cu brandul pe site - de aici se vede de ce un brand ales nu apare.
function TfrmWebPopularBrandsDlg.SiteState(const AIndex: Integer): string;
var
  I, Shown: Integer;
begin
  if not fItems[AIndex].HasLogo then
    Exit('nu apare: fara logo');
  if fItems[AIndex].Products = 0 then
    Exit('nu apare: 0 produse');
  // al citelea brand afisabil e (cele fara logo / fara produse se sar)
  Shown := 0;
  for I := 0 to AIndex do
    if fItems[I].HasLogo and (fItems[I].Products > 0) then
      Inc(Shown);
  if Shown > cSiteLimit then
    Result := Format('nu apare: peste %d', [cSiteLimit])
  else
    Result := 'da';
end;

procedure TfrmWebPopularBrandsDlg.ShowList(const ASelectIndex: Integer);
var
  I: Integer;
  Row: TListItem;
begin
  lvBrands.Items.BeginUpdate;
  try
    lvBrands.Items.Clear;
    for I := 0 to fItems.Count - 1 do
    begin
      Row := lvBrands.Items.Add;
      Row.Caption := IntToStr(I + 1);
      Row.SubItems.Add(fItems[I].Title);
      if Length(fItems[I].NewLogo) > 0 then
        Row.SubItems.Add('nou')
      else if fItems[I].HasLogo then
        Row.SubItems.Add('da')
      else
        Row.SubItems.Add('LIPSA');
      Row.SubItems.Add(IntToStr(fItems[I].Products));
      Row.SubItems.Add(SiteState(I));
      Row.SubItems.Add(IntToStr(fItems[I].BrandID));
    end;
  finally
    lvBrands.Items.EndUpdate;
  end;
  if (ASelectIndex >= 0) and (ASelectIndex < lvBrands.Items.Count) then
  begin
    lvBrands.Items[ASelectIndex].Selected := True;
    lvBrands.Items[ASelectIndex].Focused := True;
    lvBrands.Items[ASelectIndex].MakeVisible(False);
  end;
  UpdateButtons;
  ShowLogo;
end;

// Previzualizarea logo-ului brandului selectat: cel incarcat acum sau cel din baza.
procedure TfrmWebPopularBrandsDlg.ShowLogo;
var
  Index: Integer;
  Query: TIBCQuery;
  MS: TMemoryStream;
  Wic: TWICImage;
begin
  imgLogo.Picture.Assign(nil);
  Index := SelectedIndex;
  if Index < 0 then
  begin
    lblLogoState.Caption := '';
    Exit;
  end;
  if not fItems[Index].HasLogo then
  begin
    lblLogoState.Caption := 'Fara logo - brandul nu apare pe site. Incarcati un PNG (ideal cu fundal transparent).';
    Exit;
  end;

  MS := TMemoryStream.Create;
  Wic := TWICImage.Create;
  try
    if Length(fItems[Index].NewLogo) > 0 then
      MS.WriteBuffer(fItems[Index].NewLogo[0], Length(fItems[Index].NewLogo))
    else
    begin
      Query := TIBCQuery.Create(nil);
      try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultSelect;
        Query.SQL.Text := 'select IMAGE from TS_BRANDS_IMAGE where BRANDID = :ID';
        Query.ParamByName('ID').AsInteger := fItems[Index].BrandID;
        Query.Open;
        if not Query.Eof then
          TBlobField(Query.FieldByName('IMAGE')).SaveToStream(MS);
        Query.Close;
      finally
        Query.Free;
      end;
    end;
    if MS.Size = 0 then
    begin
      lblLogoState.Caption := 'Logo gol in baza.';
      Exit;
    end;
    MS.Position := 0;
    try
      Wic.LoadFromStream(MS);
      imgLogo.Picture.Assign(Wic);
      if Length(fItems[Index].NewLogo) > 0 then
        lblLogoState.Caption := Format('Logo nou (%d x %d), se scrie la "Salveaza".', [Wic.Width, Wic.Height])
      else
        lblLogoState.Caption := Format('Logo din baza: %d x %d, %d KB.', [Wic.Width, Wic.Height, MS.Size div 1024]);
    except
      lblLogoState.Caption := 'Logo-ul din baza nu poate fi afisat (format necunoscut).';
    end;
  finally
    Wic.Free;
    MS.Free;
  end;
end;

function TfrmWebPopularBrandsDlg.SelectedIndex: Integer;
begin
  if lvBrands.Selected <> nil then
    Result := lvBrands.Selected.Index
  else
    Result := -1;
end;

function TfrmWebPopularBrandsDlg.IndexOfBrand(const ABrandID: Integer): Integer;
var
  I: Integer;
begin
  for I := 0 to fItems.Count - 1 do
    if fItems[I].BrandID = ABrandID then
      Exit(I);
  Result := -1;
end;

procedure TfrmWebPopularBrandsDlg.UpdateButtons;
var
  Index: Integer;
begin
  Index := SelectedIndex;
  btnUp.Enabled := Index > 0;
  btnDown.Enabled := (Index >= 0) and (Index < fItems.Count - 1);
  btnRemove.Enabled := Index >= 0;
  btnLoadLogo.Enabled := Index >= 0;
  btnAdd.Enabled := (cmbFound.ItemIndex >= 0) and not fTableMissing;
  btnSearch.Enabled := not fTableMissing;
  btnOK.Enabled := not fTableMissing;
end;

procedure TfrmWebPopularBrandsDlg.lvBrandsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    UpdateButtons;
    ShowLogo;
  end;
end;

procedure TfrmWebPopularBrandsDlg.MoveSelected(const ADelta: Integer);
var
  Index, Target: Integer;
begin
  Index := SelectedIndex;
  Target := Index + ADelta;
  if (Index < 0) or (Target < 0) or (Target >= fItems.Count) then
    Exit;
  fItems.Exchange(Index, Target);
  fModified := True;
  ShowList(Target);
  if lvBrands.CanFocus then
    lvBrands.SetFocus;
end;

procedure TfrmWebPopularBrandsDlg.btnUpClick(Sender: TObject);
begin
  MoveSelected(-1);
end;

procedure TfrmWebPopularBrandsDlg.btnDownClick(Sender: TObject);
begin
  MoveSelected(1);
end;

procedure TfrmWebPopularBrandsDlg.lvBrandsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Ctrl+Sus / Ctrl+Jos muta brandul; Del il scoate
  if (ssCtrl in Shift) and (Key = VK_UP) then
  begin
    Key := 0;
    MoveSelected(-1);
  end
  else if (ssCtrl in Shift) and (Key = VK_DOWN) then
  begin
    Key := 0;
    MoveSelected(1);
  end
  else if (Key = VK_DELETE) and btnRemove.Enabled then
  begin
    Key := 0;
    btnRemoveClick(nil);
  end;
end;

procedure TfrmWebPopularBrandsDlg.btnRemoveClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := SelectedIndex;
  if Index < 0 then
    Exit;
  if MessageDlg(Format('Scoateti "%s" din brandurile populare?', [fItems[Index].Title]), mtConfirmation,
    [mbYes, mbNo], 0) <> mrYes then
    Exit;
  fRemoved.Add(fItems[Index].BrandID);
  fItems.Delete(Index);
  fModified := True;
  if Index >= fItems.Count then
    Index := fItems.Count - 1;
  ShowList(Index);
end;

procedure TfrmWebPopularBrandsDlg.btnLoadLogoClick(Sender: TObject);
var
  Index: Integer;
  Dlg: TOpenDialog;
  Data: TBytes;
  MS: TMemoryStream;
  Wic: TWICImage;
  Item: TPopularBrand;
begin
  Index := SelectedIndex;
  if Index < 0 then
    Exit;
  Dlg := TOpenDialog.Create(nil);
  try
    Dlg.Title := 'Logo pentru ' + fItems[Index].Title;
    Dlg.Filter := 'Imagini PNG sau JPG (*.png;*.jpg;*.jpeg)|*.png;*.jpg;*.jpeg';
    Dlg.Options := Dlg.Options + [ofFileMustExist];
    if not Dlg.Execute then
      Exit;
    Data := TFile.ReadAllBytes(Dlg.FileName);
  finally
    Dlg.Free;
  end;

  if Length(Data) = 0 then
    Exit;
  if Length(Data) > cMaxLogoBytes then
  begin
    MessageDlg('Fisierul are peste 2 MB. Micsorati logo-ul (pe site se afiseaza la cel mult 320 x 160).',
      mtError, [mbOK], 0);
    Exit;
  end;

  // verificam ca imaginea se poate citi, inainte s-o punem in baza
  MS := TMemoryStream.Create;
  Wic := TWICImage.Create;
  try
    MS.WriteBuffer(Data[0], Length(Data));
    MS.Position := 0;
    try
      Wic.LoadFromStream(MS);
    except
      MessageDlg('Fisierul nu este o imagine PNG/JPG valida.', mtError, [mbOK], 0);
      Exit;
    end;
  finally
    Wic.Free;
    MS.Free;
  end;

  Item := fItems[Index];
  Item.NewLogo := Data;
  Item.HasLogo := True;
  fItems[Index] := Item;
  fModified := True;
  ShowList(Index);
end;

procedure TfrmWebPopularBrandsDlg.btnSearchClick(Sender: TObject);
var
  Query: TIBCQuery;
  Text, Line: string;
begin
  Text := Trim(edSearch.Text);
  if Length(Text) < 2 then
  begin
    MessageDlg('Scrieti cel putin 2 caractere din denumirea brandului.', mtInformation, [mbOK], 0);
    Exit;
  end;
  cmbFound.Items.BeginUpdate;
  try
    cmbFound.Items.Clear;
    Query := TIBCQuery.Create(nil);
    try
      Query.Connection := dmDB.IBCConnection;
      Query.Transaction := dmDB.IBCTrDefaultSelect;
      // doar brandurile care au produse (TS_GOODS.VENDOR_ID); cele de pe site primele
      Query.SQL.Text :=
        'select first 60 S.SYSSID, S.TITLE, ' +
        Format(cSqlHasLogo, ['S.SYSSID']) + ' HAS_LOGO, ' +
        Format(cSqlProducts, ['S.SYSSID']) + ' PRODUCTS ' +
        'from TS_SYSS S ' +
        'where S.TITLE containing :TXT ' +
        '  and exists (select 1 from TS_GOODS G where G.VENDOR_ID = S.SYSSID) ' +
        'order by 4 desc, S.TITLE';
      Query.ParamByName('TXT').AsString := Text;
      Query.Open;
      while not Query.Eof do
      begin
        // cele deja in lista nu se mai propun
        if IndexOfBrand(Query.FieldByName('SYSSID').AsInteger) < 0 then
        begin
          Line := Trim(Query.FieldByName('TITLE').AsString);
          if Query.FieldByName('HAS_LOGO').AsInteger = 1 then
            Line := Format('%s   (%d produse pe site, cu logo, id %d)', [Line,
              Query.FieldByName('PRODUCTS').AsInteger, Query.FieldByName('SYSSID').AsInteger])
          else
            Line := Format('%s   (%d produse pe site, FARA LOGO, id %d)', [Line,
              Query.FieldByName('PRODUCTS').AsInteger, Query.FieldByName('SYSSID').AsInteger]);
          cmbFound.Items.AddObject(Line, TObject(Query.FieldByName('SYSSID').AsInteger));
        end;
        Query.Next;
      end;
      Query.Close;
    finally
      Query.Free;
    end;
  finally
    cmbFound.Items.EndUpdate;
  end;
  if cmbFound.Items.Count = 0 then
    MessageDlg('Niciun brand gasit (sau toate cele gasite sint deja in lista).', mtInformation, [mbOK], 0)
  else
  begin
    cmbFound.ItemIndex := 0;
    if cmbFound.CanFocus then
      cmbFound.SetFocus;
    cmbFound.DroppedDown := cmbFound.Items.Count > 1;
  end;
  UpdateButtons;
end;

procedure TfrmWebPopularBrandsDlg.cmbFoundChange(Sender: TObject);
begin
  btnAdd.Enabled := (cmbFound.ItemIndex >= 0) and not fTableMissing;
end;

procedure TfrmWebPopularBrandsDlg.edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    btnSearchClick(nil);
  end;
end;

procedure TfrmWebPopularBrandsDlg.btnAddClick(Sender: TObject);
var
  BrandID, P: Integer;
  Query: TIBCQuery;
  Item: TPopularBrand;
begin
  if cmbFound.ItemIndex < 0 then
    Exit;
  BrandID := Integer(cmbFound.Items.Objects[cmbFound.ItemIndex]);
  if IndexOfBrand(BrandID) >= 0 then
    Exit;

  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultSelect;
    Query.SQL.Text :=
      'select S.TITLE, ' +
      Format(cSqlHasLogo, ['S.SYSSID']) + ' HAS_LOGO, ' +
      Format(cSqlProducts, ['S.SYSSID']) + ' PRODUCTS ' +
      'from TS_SYSS S where S.SYSSID = :ID';
    Query.ParamByName('ID').AsInteger := BrandID;
    Query.Open;
    if Query.Eof then
      Exit;
    Item.BrandID := BrandID;
    Item.Title := Trim(Query.FieldByName('TITLE').AsString);
    Item.HasLogo := Query.FieldByName('HAS_LOGO').AsInteger = 1;
    Item.Products := Query.FieldByName('PRODUCTS').AsInteger;
    Item.NewLogo := nil;
    Query.Close;
  finally
    Query.Free;
  end;

  fItems.Add(Item);
  // daca fusese scos in aceeasi sesiune, nu mai trebuie sters la salvare
  P := fRemoved.IndexOf(BrandID);
  if P >= 0 then
    fRemoved.Delete(P);
  fModified := True;
  cmbFound.Items.Delete(cmbFound.ItemIndex);
  cmbFound.ItemIndex := -1;
  ShowList(fItems.Count - 1);
end;

// La "Renunta" / X cu modificari nesalvate intrebam o data; TSWNCustomForm cheama acest handler
// inaintea logicii proprii de inchidere.
procedure TfrmWebPopularBrandsDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if fModified and (ModalResult <> mrOk) then
    CanClose := MessageDlg('Modificarile nu au fost salvate. Inchideti fara salvare?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes;
end;

function TfrmWebPopularBrandsDlg.IsFormDataPosted: Boolean;
var
  Query: TIBCQuery;
  Tr: TIBCTransaction;
  MS: TMemoryStream;
  I: Integer;
begin
  Result := False;
  if fTableMissing then
    Exit;
  Query := TIBCQuery.Create(nil);
  Tr := TIBCTransaction.Create(nil);
  MS := TMemoryStream.Create;
  try
    Tr.DefaultConnection := dmDB.IBCConnection;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := Tr;
    Tr.StartTransaction;
    try
      for I := 0 to fRemoved.Count - 1 do
      begin
        Query.SQL.Text := 'delete from TWEB_POPULAR_BRANDS where BRANDID = :ID';
        Query.ParamByName('ID').AsInteger := fRemoved[I];
        Query.Execute;
      end;

      for I := 0 to fItems.Count - 1 do
      begin
        // ordinea renumerotata 1..N
        Query.SQL.Text :=
          'update or insert into TWEB_POPULAR_BRANDS (BRANDID, ORDERNO) ' +
          'values (:ID, :ORDERNO) matching (BRANDID)';
        Query.ParamByName('ID').AsInteger := fItems[I].BrandID;
        Query.ParamByName('ORDERNO').AsInteger := I + 1;
        Query.Execute;

        // logo-ul incarcat in aceasta sesiune
        if Length(fItems[I].NewLogo) > 0 then
        begin
          MS.Clear;
          MS.WriteBuffer(fItems[I].NewLogo[0], Length(fItems[I].NewLogo));
          MS.Position := 0;
          Query.SQL.Text :=
            'update or insert into TS_BRANDS_IMAGE (BRANDID, IMAGE) ' +
            'values (:ID, :IMAGE) matching (BRANDID)';
          Query.ParamByName('ID').AsInteger := fItems[I].BrandID;
          Query.ParamByName('IMAGE').LoadFromStream(MS, ftBlob);
          Query.Execute;
        end;
      end;

      Tr.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        if Tr.Active then
          Tr.Rollback;
        MessageDlg('Brandurile populare nu au putut fi salvate: ' + E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    MS.Free;
    Query.Free;
    Tr.Free;
  end;
end;

end.
