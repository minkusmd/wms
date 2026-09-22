unit frmWebPopularCategoriesDialog;

{
  Categoriile populare de pe prima pagina a site-ului: lista, ordinea si reducerea afisata.

  Cum le citeste site-ul (fantastic.web, models/PopularCategories.php):
    WEB_GET_POPULAR_CATEGORIES intoarce categoriile din TWEB_CATALOG cu bitul 12 din FLAGS
    (FLG_POPULAR), iar TWEB_POPULAR_CATEGORIES (CATALOGID, ORDERNO, CATEGORY_DISCOUNT) le da,
    prin LEFT JOIN, ordinea si reducerea.
  De aceea forma tine cele doua sincronizate:
    adaugare = rind in TWEB_POPULAR_CATEGORIES + FLG_POPULAR = 1 pe categorie
    stergere = rindul sters + FLG_POPULAR = 0
  Bifa "Popular" din dialogul catalogului web (VW_TWEB_CATALOG.FLG_POPULAR) ramine valabila:
  o categorie bifata acolo apare aici la sfirsitul listei, fara ordine, si o primeste la salvare.

  Totul se lucreaza in memorie si se scrie intr-o singura tranzactie la "Salveaza";
  ORDERNO se renumeroteaza 1..N. Site-ul tine lista in cache 24h (homePopularCategories).
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.Generics.Collections, SWNBaseUnit;

type
  TPopularCategory = record
    CatalogID: Integer;
    TitleRo: string;
    TitleRu: string;
    ParentTitle: string;
    Discount: Integer;      // -1 = fara reducere (NULL in baza)
  end;

  TfrmWebPopularCategoriesDlg = class(TSWNCustomForm)
    lblInfo: TLabel;
    lvCategories: TListView;
    btnUp: TButton;
    btnDown: TButton;
    btnRemove: TButton;
    lblDiscount: TLabel;
    edDiscount: TEdit;
    btnApplyDiscount: TButton;
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
    procedure btnApplyDiscountClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure cmbFoundChange(Sender: TObject);
    procedure lvCategoriesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvCategoriesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDiscountKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    fItems: TList<TPopularCategory>;
    fRemoved: TList<Integer>;
    fModified: Boolean;
    procedure LoadData;
    procedure ShowList(const ASelectIndex: Integer);
    function SelectedIndex: Integer;
    function IndexOfCatalog(const ACatalogID: Integer): Integer;
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
  System.UITypes, Data.DB, IBC, DataModuleDB;

{$R *.dfm}

// FLG_POPULAR = bitul 12 din TWEB_CATALOG.FLAGS (acelasi pe care il citeste WEB_GET_POPULAR_CATEGORIES)

constructor TfrmWebPopularCategoriesDlg.Create(AOwner: TComponent);
begin
  inherited;
  fItems := TList<TPopularCategory>.Create;
  fRemoved := TList<Integer>.Create;
end;

destructor TfrmWebPopularCategoriesDlg.Destroy;
begin
  fRemoved.Free;
  fItems.Free;
  inherited;
end;

procedure TfrmWebPopularCategoriesDlg.Prepare;
begin
  LoadData;
  ShowList(0);
  fModified := False;
end;

// Reuniunea: categoriile cu FLG_POPULAR si rindurile din TWEB_POPULAR_CATEGORIES.
procedure TfrmWebPopularCategoriesDlg.LoadData;
var
  Query: TIBCQuery;
  Item: TPopularCategory;
begin
  fItems.Clear;
  fRemoved.Clear;
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultSelect;
    Query.SQL.Text :=
      'select C.CATALOGID, C.TITLE, C.TITLE_RUS, P.CATEGORY_DISCOUNT, ' +
      '  (select CP.TITLE from TWEB_CATALOG CP where CP.CATALOGID = C.PARENTID) PARENT_TITLE ' +
      'from TWEB_CATALOG C ' +
      'left join TWEB_POPULAR_CATEGORIES P on P.CATALOGID = C.CATALOGID ' +
      'where (get_flg_value(C.FLAGS, 12) = 1) or (P.CATALOGID is not null) ' +
      'order by P.ORDERNO nulls last, C.ORDERNO';
    Query.Open;
    while not Query.Eof do
    begin
      Item.CatalogID := Query.FieldByName('CATALOGID').AsInteger;
      Item.TitleRo := Trim(Query.FieldByName('TITLE').AsString);
      Item.TitleRu := Trim(Query.FieldByName('TITLE_RUS').AsString);
      Item.ParentTitle := Trim(Query.FieldByName('PARENT_TITLE').AsString);
      if Query.FieldByName('CATEGORY_DISCOUNT').IsNull then
        Item.Discount := -1
      else
        Item.Discount := Query.FieldByName('CATEGORY_DISCOUNT').AsInteger;
      fItems.Add(Item);
      Query.Next;
    end;
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebPopularCategoriesDlg.ShowList(const ASelectIndex: Integer);
var
  I: Integer;
  Row: TListItem;
begin
  lvCategories.Items.BeginUpdate;
  try
    lvCategories.Items.Clear;
    for I := 0 to fItems.Count - 1 do
    begin
      Row := lvCategories.Items.Add;
      Row.Caption := IntToStr(I + 1);
      Row.SubItems.Add(fItems[I].TitleRo);
      Row.SubItems.Add(fItems[I].TitleRu);
      Row.SubItems.Add(fItems[I].ParentTitle);
      if fItems[I].Discount >= 0 then
        Row.SubItems.Add(IntToStr(fItems[I].Discount) + '%')
      else
        Row.SubItems.Add('');
      Row.SubItems.Add(IntToStr(fItems[I].CatalogID));
    end;
  finally
    lvCategories.Items.EndUpdate;
  end;
  if (ASelectIndex >= 0) and (ASelectIndex < lvCategories.Items.Count) then
  begin
    lvCategories.Items[ASelectIndex].Selected := True;
    lvCategories.Items[ASelectIndex].Focused := True;
    lvCategories.Items[ASelectIndex].MakeVisible(False);
  end;
  UpdateButtons;
end;

function TfrmWebPopularCategoriesDlg.SelectedIndex: Integer;
begin
  if lvCategories.Selected <> nil then
    Result := lvCategories.Selected.Index
  else
    Result := -1;
end;

function TfrmWebPopularCategoriesDlg.IndexOfCatalog(const ACatalogID: Integer): Integer;
var
  I: Integer;
begin
  for I := 0 to fItems.Count - 1 do
    if fItems[I].CatalogID = ACatalogID then
      Exit(I);
  Result := -1;
end;

procedure TfrmWebPopularCategoriesDlg.UpdateButtons;
var
  Index: Integer;
begin
  Index := SelectedIndex;
  btnUp.Enabled := Index > 0;
  btnDown.Enabled := (Index >= 0) and (Index < fItems.Count - 1);
  btnRemove.Enabled := Index >= 0;
  edDiscount.Enabled := Index >= 0;
  btnApplyDiscount.Enabled := Index >= 0;
  if Index >= 0 then
  begin
    if fItems[Index].Discount >= 0 then
      edDiscount.Text := IntToStr(fItems[Index].Discount)
    else
      edDiscount.Text := '';
  end
  else
    edDiscount.Text := '';
  btnAdd.Enabled := cmbFound.ItemIndex >= 0;
end;

procedure TfrmWebPopularCategoriesDlg.lvCategoriesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    UpdateButtons;
end;

procedure TfrmWebPopularCategoriesDlg.MoveSelected(const ADelta: Integer);
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
  if lvCategories.CanFocus then
    lvCategories.SetFocus;
end;

procedure TfrmWebPopularCategoriesDlg.btnUpClick(Sender: TObject);
begin
  MoveSelected(-1);
end;

procedure TfrmWebPopularCategoriesDlg.btnDownClick(Sender: TObject);
begin
  MoveSelected(1);
end;

procedure TfrmWebPopularCategoriesDlg.lvCategoriesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Ctrl+Sus / Ctrl+Jos muta categoria; Del o scoate
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

procedure TfrmWebPopularCategoriesDlg.btnRemoveClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := SelectedIndex;
  if Index < 0 then
    Exit;
  if MessageDlg(Format('Scoateti "%s" din categoriile populare?', [fItems[Index].TitleRo]), mtConfirmation,
    [mbYes, mbNo], 0) <> mrYes then
    Exit;
  fRemoved.Add(fItems[Index].CatalogID);
  fItems.Delete(Index);
  fModified := True;
  if Index >= fItems.Count then
    Index := fItems.Count - 1;
  ShowList(Index);
end;

procedure TfrmWebPopularCategoriesDlg.btnApplyDiscountClick(Sender: TObject);
var
  Index, Value: Integer;
  Item: TPopularCategory;
  Text: string;
begin
  Index := SelectedIndex;
  if Index < 0 then
    Exit;
  Text := Trim(StringReplace(edDiscount.Text, '%', '', [rfReplaceAll]));
  if Text = '' then
    Value := -1
  else if not TryStrToInt(Text, Value) or (Value < 0) or (Value > 100) then
  begin
    MessageDlg('Reducerea trebuie sa fie un numar intre 0 si 100 (gol = fara reducere).', mtError, [mbOK], 0);
    Exit;
  end;
  Item := fItems[Index];
  if Item.Discount <> Value then
  begin
    Item.Discount := Value;
    fItems[Index] := Item;
    fModified := True;
  end;
  ShowList(Index);
  if lvCategories.CanFocus then
    lvCategories.SetFocus;
end;

procedure TfrmWebPopularCategoriesDlg.edDiscountKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    btnApplyDiscountClick(nil);
  end;
end;

procedure TfrmWebPopularCategoriesDlg.btnSearchClick(Sender: TObject);
var
  Query: TIBCQuery;
  Text, Line: string;
begin
  Text := Trim(edSearch.Text);
  if Length(Text) < 2 then
  begin
    MessageDlg('Scrieti cel putin 2 caractere din denumirea categoriei.', mtInformation, [mbOK], 0);
    Exit;
  end;
  cmbFound.Items.BeginUpdate;
  try
    cmbFound.Items.Clear;
    Query := TIBCQuery.Create(nil);
    try
      Query.Connection := dmDB.IBCConnection;
      Query.Transaction := dmDB.IBCTrDefaultSelect;
      Query.SQL.Text :=
        'select first 60 C.CATALOGID, C.TITLE, C.CATALOG_LEVEL, ' +
        '  (select CP.TITLE from TWEB_CATALOG CP where CP.CATALOGID = C.PARENTID) PARENT_TITLE ' +
        'from TWEB_CATALOG C ' +
        'where (C.TITLE containing :TXT or C.TITLE_RUS containing :TXT2) ' +
        'order by C.CATALOG_LEVEL, C.TITLE';
      Query.ParamByName('TXT').AsString := Text;
      Query.ParamByName('TXT2').AsString := Text;
      Query.Open;
      while not Query.Eof do
      begin
        // cele deja in lista nu se mai propun
        if IndexOfCatalog(Query.FieldByName('CATALOGID').AsInteger) < 0 then
        begin
          Line := Trim(Query.FieldByName('TITLE').AsString);
          if Trim(Query.FieldByName('PARENT_TITLE').AsString) <> '' then
            Line := Line + '   <  ' + Trim(Query.FieldByName('PARENT_TITLE').AsString);
          Line := Format('%s   (nivel %d, id %d)', [Line, Query.FieldByName('CATALOG_LEVEL').AsInteger,
            Query.FieldByName('CATALOGID').AsInteger]);
          cmbFound.Items.AddObject(Line, TObject(Query.FieldByName('CATALOGID').AsInteger));
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
    MessageDlg('Nicio categorie gasita (sau toate cele gasite sint deja in lista).', mtInformation, [mbOK], 0)
  else
  begin
    cmbFound.ItemIndex := 0;
    if cmbFound.CanFocus then
      cmbFound.SetFocus;
    cmbFound.DroppedDown := cmbFound.Items.Count > 1;
  end;
  UpdateButtons;
end;

procedure TfrmWebPopularCategoriesDlg.cmbFoundChange(Sender: TObject);
begin
  btnAdd.Enabled := cmbFound.ItemIndex >= 0;
end;

procedure TfrmWebPopularCategoriesDlg.edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    btnSearchClick(nil);
  end;
end;

procedure TfrmWebPopularCategoriesDlg.btnAddClick(Sender: TObject);
var
  CatalogID, P: Integer;
  Query: TIBCQuery;
  Item: TPopularCategory;
begin
  if cmbFound.ItemIndex < 0 then
    Exit;
  CatalogID := Integer(cmbFound.Items.Objects[cmbFound.ItemIndex]);
  if IndexOfCatalog(CatalogID) >= 0 then
    Exit;

  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultSelect;
    Query.SQL.Text :=
      'select C.TITLE, C.TITLE_RUS, ' +
      '  (select CP.TITLE from TWEB_CATALOG CP where CP.CATALOGID = C.PARENTID) PARENT_TITLE ' +
      'from TWEB_CATALOG C where C.CATALOGID = :ID';
    Query.ParamByName('ID').AsInteger := CatalogID;
    Query.Open;
    if Query.Eof then
      Exit;
    Item.CatalogID := CatalogID;
    Item.TitleRo := Trim(Query.FieldByName('TITLE').AsString);
    Item.TitleRu := Trim(Query.FieldByName('TITLE_RUS').AsString);
    Item.ParentTitle := Trim(Query.FieldByName('PARENT_TITLE').AsString);
    Item.Discount := -1;
    Query.Close;
  finally
    Query.Free;
  end;

  fItems.Add(Item);
  // daca fusese scoasa in aceeasi sesiune, nu mai trebuie stearsa la salvare
  P := fRemoved.IndexOf(CatalogID);
  if P >= 0 then
    fRemoved.Delete(P);
  fModified := True;
  cmbFound.Items.Delete(cmbFound.ItemIndex);
  cmbFound.ItemIndex := -1;
  ShowList(fItems.Count - 1);
end;

// La "Renunta" / X cu modificari nesalvate intrebam o data; TSWNCustomForm cheama acest handler
// inaintea logicii proprii de inchidere.
procedure TfrmWebPopularCategoriesDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if fModified and (ModalResult <> mrOk) then
    CanClose := MessageDlg('Modificarile nu au fost salvate. Inchideti fara salvare?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes;
end;

function TfrmWebPopularCategoriesDlg.IsFormDataPosted: Boolean;
var
  Query: TIBCQuery;
  Tr: TIBCTransaction;
  I: Integer;
begin
  Result := False;
  Query := TIBCQuery.Create(nil);
  Tr := TIBCTransaction.Create(nil);
  try
    Tr.DefaultConnection := dmDB.IBCConnection;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := Tr;
    Tr.StartTransaction;
    try
      // scoase: rindul + bifa "Popular" de pe categorie
      for I := 0 to fRemoved.Count - 1 do
      begin
        Query.SQL.Text := 'delete from TWEB_POPULAR_CATEGORIES where CATALOGID = :ID';
        Query.ParamByName('ID').AsInteger := fRemoved[I];
        Query.Execute;
        Query.SQL.Text :=
          'update TWEB_CATALOG set FLAGS = set_flg_value(FLAGS, 12, 0) ' +
          'where CATALOGID = :ID and get_flg_value(FLAGS, 12) = 1';
        Query.ParamByName('ID').AsInteger := fRemoved[I];
        Query.Execute;
      end;

      // ramase / adaugate: ordinea renumerotata 1..N, reducerea, bifa "Popular"
      for I := 0 to fItems.Count - 1 do
      begin
        Query.SQL.Text :=
          'update or insert into TWEB_POPULAR_CATEGORIES (CATALOGID, ORDERNO, CATEGORY_DISCOUNT) ' +
          'values (:ID, :ORDERNO, :DISCOUNT) matching (CATALOGID)';
        Query.ParamByName('ID').AsInteger := fItems[I].CatalogID;
        Query.ParamByName('ORDERNO').AsInteger := I + 1;
        if fItems[I].Discount >= 0 then
          Query.ParamByName('DISCOUNT').AsInteger := fItems[I].Discount
        else
        begin
          Query.ParamByName('DISCOUNT').DataType := ftInteger;
          Query.ParamByName('DISCOUNT').Clear;
        end;
        Query.Execute;

        Query.SQL.Text :=
          'update TWEB_CATALOG set FLAGS = set_flg_value(FLAGS, 12, 1) ' +
          'where CATALOGID = :ID and get_flg_value(FLAGS, 12) = 0';
        Query.ParamByName('ID').AsInteger := fItems[I].CatalogID;
        Query.Execute;
      end;

      Tr.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        if Tr.Active then
          Tr.Rollback;
        MessageDlg('Categoriile populare nu au putut fi salvate: ' + E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    Query.Free;
    Tr.Free;
  end;
end;

end.
