unit frmGoodsTypeFiltersDialog;

{ Manager pentru SABLONUL DE FILTRE al unui tip de produs (TS_GOODS_TYPE).
  Inlocuieste managerul de atribute (frmGoodsTypeAttributesDialog): dupa decizia
  din DB Model\plan_migrare_atribute_in_filtre.md, TS_FILTERS ramane sistemul
  unic, iar atributele se retrag.

  Doua grile:
    - Sablon: filtrele tipului = TS_GOODS_TYPE_FILTERS + TS_FILTERS (read-only,
      se modifica prin butoane);
    - Valori: dictionarul filtrului selectat = TS_FILTER_PARAMS (editabil in grila,
      master-detail dupa FILTERID).

  Sablonul e SUGESTIE, nu restrictie: filtrele marcate "Recomandat" doar semnaleaza
  lipsa lor la editarea produsului, nu blocheaza nimic.

  Butonul "Genereaza din produse" reface propunerile automate pentru tipul curent,
  dupa acoperirea reala din TS_GOODS_FILTERS. Randurile adaugate manual (FLG_AUTO=0)
  nu sunt atinse de generare.

  Tranzactie proprie: OK -> Commit, Renunta -> Rollback. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS, Vcl.Menus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView,
  cxGrid, cxButtons, dxScrollbarAnnotations, dxDateRanges, cxDBData, cxTextEdit, cxMemo;

type
  TfrmGoodsTypeFiltersDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    IBCTransactionUpdate: TIBCTransaction;
    IBCQueryTemplate: TIBCQuery;
    IBCDataSourceTemplate: TIBCDataSource;
    IBCQueryParams: TIBCQuery;
    IBCDataSourceParams: TIBCDataSource;
    IBCSQLExec: TIBCSQL;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    pnLeft: TPanel;
    pnRight: TPanel;
    lbTmpl: TLabel;
    lbVal: TLabel;
    Splitter1: TSplitter;
    cxGridTmpl: TcxGrid;
    cxGridTmplTable: TcxGridDBTableView;
    cxGridTmplLevel: TcxGridLevel;
    cxGridTmpl_FILTERNAME: TcxGridDBColumn;
    cxGridTmpl_FILTERNAME_RUS: TcxGridDBColumn;
    cxGridTmpl_FLG_RECOMMENDED: TcxGridDBColumn;
    cxGridTmpl_COVERAGE_PCT: TcxGridDBColumn;
    cxGridTmpl_FLG_AUTO: TcxGridDBColumn;
    cxGridTmpl_FLG_MULTI: TcxGridDBColumn;
    cxGridTmpl_UOM_RO: TcxGridDBColumn;
    cxGridVal: TcxGrid;
    cxGridValTable: TcxGridDBTableView;
    cxGridValLevel: TcxGridLevel;
    cxGridVal_PARAM_VALUE: TcxGridDBColumn;
    cxGridVal_PARAM_VALUE_RUS: TcxGridDBColumn;
    pnTmplButtons: TPanel;
    btnTmplAdd: TcxButton;
    btnTmplRemove: TcxButton;
    btnTmplRecommend: TcxButton;
    btnTmplUp: TcxButton;
    btnTmplDown: TcxButton;
    btnTmplGenerate: TcxButton;
    pnValButtons: TPanel;
    btnValNew: TcxButton;
    btnValDelete: TcxButton;
    IBCQueryNameTmpl: TIBCQuery;
    IBCDataSourceNameTmpl: TIBCDataSource;
    pnName: TPanel;
    lbName: TLabel;
    cxGridName: TcxGrid;
    cxGridNameTable: TcxGridDBTableView;
    cxGridNameLevel: TcxGridLevel;
    cxGridName_CONTEXT: TcxGridDBColumn;
    cxGridName_TEMPLATE_RO: TcxGridDBColumn;
    cxGridName_TEMPLATE_RU: TcxGridDBColumn;
    pnNameButtons: TPanel;
    btnNameNew: TcxButton;
    btnNameEdit: TcxButton;
    btnNameDelete: TcxButton;
    cxMemoPlaceholders: TcxMemo;
    procedure btnTmplAddClick(Sender: TObject);
    procedure btnTmplRemoveClick(Sender: TObject);
    procedure btnTmplRecommendClick(Sender: TObject);
    procedure btnTmplUpClick(Sender: TObject);
    procedure btnTmplDownClick(Sender: TObject);
    procedure btnTmplGenerateClick(Sender: TObject);
    procedure btnValNewClick(Sender: TObject);
    procedure btnValDeleteClick(Sender: TObject);
    procedure IBCQueryParamsNewRecord(DataSet: TDataSet);
    procedure btnNameNewClick(Sender: TObject);
    procedure btnNameEditClick(Sender: TObject);
    procedure btnNameDeleteClick(Sender: TObject);
  private
    FGoodsTypeID: Integer;
    procedure ExecSql(const ASql: string; const AParams: array of Variant);
    procedure ReopenTemplate(AKeepFilterID: Integer);
    function CurrentFilterID: Integer;
    procedure MoveCurrent(ADelta: Integer);
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property GoodsTypeID: Integer read FGoodsTypeID write FGoodsTypeID;
  end;

implementation

uses
  SWNUtils, DataModuleDB, System.UITypes, frmSelectFilterDialog,
  frmNameTemplateEditorDialog;

{$R *.dfm}

{ TfrmGoodsTypeFiltersDlg }

procedure TfrmGoodsTypeFiltersDlg.Prepare;
begin
  try
    IBCTransactionUpdate.StartTransaction;

    IBCQueryTemplate.ParamByName('gtid').AsInteger := FGoodsTypeID;
    IBCQueryNameTmpl.ParamByName('gtid').AsInteger := FGoodsTypeID;

    IBCQueryTemplate.Open;
    IBCQueryParams.Open; { detail: legat pe FILTERID prin master-detail }
    IBCQueryNameTmpl.Open;

    DialogTitle1.Text := 'Sablonul de filtre pentru tipul de produs #' + IntToStr(FGoodsTypeID);
  except
    if IBCTransactionUpdate.Active then
      IBCTransactionUpdate.Rollback;
    raise;
  end;
end;

function TfrmGoodsTypeFiltersDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if IBCQueryParams.State in dsEditModes then
    IBCQueryParams.Post;
  if IBCQueryNameTmpl.State in dsEditModes then
    IBCQueryNameTmpl.Post;

  if IBCTransactionUpdate.Active then
    IBCTransactionUpdate.Commit;
  Result := True;
end;

procedure TfrmGoodsTypeFiltersDlg.WhenCancelForm;
begin
  if IBCTransactionUpdate.Active then
    IBCTransactionUpdate.Rollback;
end;

{ ---------- utilitare ---------- }

procedure TfrmGoodsTypeFiltersDlg.ExecSql(const ASql: string;
  const AParams: array of Variant);
var
  i: Integer;
begin
  IBCSQLExec.SQL.Text := ASql;
  IBCSQLExec.Prepare;
  for i := 0 to High(AParams) do
    IBCSQLExec.Params[i].Value := AParams[i];
  IBCSQLExec.Execute;
end;

function TfrmGoodsTypeFiltersDlg.CurrentFilterID: Integer;
begin
  if IBCQueryTemplate.Active and (not IBCQueryTemplate.IsEmpty) then
    Result := IBCQueryTemplate.FieldByName('FILTERID').AsInteger
  else
    Result := 0;
end;

procedure TfrmGoodsTypeFiltersDlg.ReopenTemplate(AKeepFilterID: Integer);
begin
  IBCQueryTemplate.Close;
  IBCQueryTemplate.Open;
  if AKeepFilterID > 0 then
    IBCQueryTemplate.Locate('FILTERID', AKeepFilterID, []);
end;

{ ---------- sablon ---------- }

procedure TfrmGoodsTypeFiltersDlg.btnTmplAddClick(Sender: TObject);
var
  d: TfrmSelectFilterDlg;
  fid: Integer;
begin
  d := TfrmSelectFilterDlg.Create(Self);
  try
    d.GoodsTypeID := FGoodsTypeID;
    if d.ShowModal <> mrOk then
      Exit;
    fid := d.SelectedFilterID;
  finally
    d.Free;
  end;

  if fid <= 0 then
    Exit;

  if IBCQueryTemplate.Locate('FILTERID', fid, []) then
  begin
    ShowMessage('Filtrul este deja in sablon.');
    Exit;
  end;

  { FLG_AUTO = 0: adaugat manual, generatorul nu-l va sterge la re-rulare }
  ExecSql('INSERT INTO TS_GOODS_TYPE_FILTERS ' +
          '(GOODSTYPEID, FILTERID, FLG_RECOMMENDED, FLG_AUTO, CREATED_BY) ' +
          'VALUES (:gtid, :fid, 0, 0, :uid)',
          [FGoodsTypeID, fid, dmDB.CurrentUserID]);
  ReopenTemplate(fid);
end;

procedure TfrmGoodsTypeFiltersDlg.btnTmplRemoveClick(Sender: TObject);
var
  fid: Integer;
begin
  fid := CurrentFilterID;
  if fid = 0 then
    Exit;

  if MessageDlg(Format('Scoateti filtrul [%s] din sablonul acestui tip?' + sLineBreak +
    'Valorile deja puse pe produse NU se sterg.',
    [IBCQueryTemplate.FieldByName('FILTERNAME').AsString]),
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  ExecSql('DELETE FROM TS_GOODS_TYPE_FILTERS ' +
          'WHERE GOODSTYPEID = :gtid AND FILTERID = :fid',
          [FGoodsTypeID, fid]);
  ReopenTemplate(0);
end;

procedure TfrmGoodsTypeFiltersDlg.btnTmplRecommendClick(Sender: TObject);
var
  fid, rec: Integer;
begin
  fid := CurrentFilterID;
  if fid = 0 then
    Exit;

  rec := IBCQueryTemplate.FieldByName('FLG_RECOMMENDED').AsInteger;
  if rec = 1 then
    rec := 0
  else
    rec := 1;

  ExecSql('UPDATE TS_GOODS_TYPE_FILTERS SET FLG_RECOMMENDED = :rec ' +
          'WHERE GOODSTYPEID = :gtid AND FILTERID = :fid',
          [rec, FGoodsTypeID, fid]);
  ReopenTemplate(fid);
end;

procedure TfrmGoodsTypeFiltersDlg.MoveCurrent(ADelta: Integer);
var
  fid, ord1, fid2, ord2: Integer;
  bm: TBookmark;
begin
  fid := CurrentFilterID;
  if fid = 0 then
    Exit;

  ord1 := IBCQueryTemplate.FieldByName('ORDERNO').AsInteger;

  { vecinul in directia ceruta }
  bm := IBCQueryTemplate.GetBookmark;
  try
    if ADelta < 0 then
      IBCQueryTemplate.Prior
    else
      IBCQueryTemplate.Next;

    if IBCQueryTemplate.Bof or IBCQueryTemplate.Eof then
    begin
      IBCQueryTemplate.GotoBookmark(bm);
      Exit;
    end;

    fid2 := IBCQueryTemplate.FieldByName('FILTERID').AsInteger;
    ord2 := IBCQueryTemplate.FieldByName('ORDERNO').AsInteger;
  finally
    IBCQueryTemplate.FreeBookmark(bm);
  end;

  if ord1 = ord2 then
    Exit; { ordine necurata - lasam pe generator sa o refaca }

  ExecSql('UPDATE TS_GOODS_TYPE_FILTERS SET ORDERNO = :o ' +
          'WHERE GOODSTYPEID = :gtid AND FILTERID = :fid', [ord2, FGoodsTypeID, fid]);
  ExecSql('UPDATE TS_GOODS_TYPE_FILTERS SET ORDERNO = :o ' +
          'WHERE GOODSTYPEID = :gtid AND FILTERID = :fid', [ord1, FGoodsTypeID, fid2]);
  ReopenTemplate(fid);
end;

procedure TfrmGoodsTypeFiltersDlg.btnTmplUpClick(Sender: TObject);
begin
  MoveCurrent(-1);
end;

procedure TfrmGoodsTypeFiltersDlg.btnTmplDownClick(Sender: TObject);
begin
  MoveCurrent(1);
end;

procedure TfrmGoodsTypeFiltersDlg.btnTmplGenerateClick(Sender: TObject);
var
  s: string;
  prag: Integer;
begin
  s := '20';
  if not InputQuery('Genereaza sablon din produse',
    'Pragul de acoperire (%) - filtrele folosite de cel putin atatea procente ' +
    'dintre produsele tipului care au deja filtre:', s) then
    Exit;

  prag := StrToIntDef(Trim(s), -1);
  if (prag < 1) or (prag > 100) then
  begin
    ShowMessage('Pragul trebuie sa fie un numar intre 1 si 100.');
    Exit;
  end;

  if MessageDlg('Propunerile automate existente vor fi refacute.' + sLineBreak +
    'Filtrele adaugate manual raman neatinse. Continuati?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  { Acelasi algoritm ca in DB Model\generate_type_filter_templates.sql:
    baza de calcul = produsele tipului care au MACAR UN filtru completat. }
  ExecSql(
    'EXECUTE BLOCK (gtid INTEGER = :gtid, prag NUMERIC(5,1) = :prag, uid INTEGER = :uid) AS ' +
    'DECLARE VARIABLE BAZA INTEGER; ' +
    'DECLARE VARIABLE FID INTEGER; ' +
    'DECLARE VARIABLE PCT NUMERIC(5,1); ' +
    'DECLARE VARIABLE ORD INTEGER; ' +
    'BEGIN ' +
    '  SELECT COUNT(*) FROM TS_GOODS g WHERE g.WEBGOODSTYPE_ID = :gtid ' +
    '    AND EXISTS(SELECT 1 FROM TS_GOODS_FILTERS gf WHERE gf.GOODSID = g.GOODSID) ' +
    '    INTO :BAZA; ' +
    '  IF (COALESCE(:BAZA,0) = 0) THEN EXIT; ' +
    '  DELETE FROM TS_GOODS_TYPE_FILTERS t ' +
    '   WHERE t.GOODSTYPEID = :gtid AND COALESCE(t.FLG_AUTO,0) = 1; ' +
    '  ORD = 0; ' +
    '  FOR SELECT gf.FILTERID, ' +
    '             CAST(100.0 * COUNT(DISTINCT gf.GOODSID) / :BAZA AS NUMERIC(5,1)) ' +
    '        FROM TS_GOODS_FILTERS gf ' +
    '        JOIN TS_GOODS g ON g.GOODSID = gf.GOODSID ' +
    '       WHERE g.WEBGOODSTYPE_ID = :gtid ' +
    '       GROUP BY gf.FILTERID ' +
    '      HAVING 100.0 * COUNT(DISTINCT gf.GOODSID) / :BAZA >= :prag ' +
    '       ORDER BY 2 DESC ' +
    '        INTO :FID, :PCT ' +
    '  DO BEGIN ' +
    '    IF (NOT EXISTS(SELECT 1 FROM TS_GOODS_TYPE_FILTERS t ' +
    '                    WHERE t.GOODSTYPEID = :gtid AND t.FILTERID = :FID)) THEN ' +
    '    BEGIN ' +
    '      ORD = :ORD + 1; ' +
    '      INSERT INTO TS_GOODS_TYPE_FILTERS ' +
    '             (GOODSTYPEID, FILTERID, ORDERNO, FLG_RECOMMENDED, FLG_AUTO, ' +
    '              COVERAGE_PCT, CREATED_BY) ' +
    '      VALUES (:gtid, :FID, :ORD, IIF(:PCT >= 80, 1, 0), 1, :PCT, :uid); ' +
    '    END ' +
    '  END ' +
    'END',
    [FGoodsTypeID, prag, dmDB.CurrentUserID]);

  ReopenTemplate(0);
  ShowMessage(Format('Sablon generat: %d filtre.', [IBCQueryTemplate.RecordCount]));
end;

{ ---------- valorile filtrului ---------- }

procedure TfrmGoodsTypeFiltersDlg.IBCQueryParamsNewRecord(DataSet: TDataSet);
begin
  { master-detail completeaza FILTERID abia la Post; il punem explicit,
    iar CREATED_BY e NOT NULL si triggerul il ia din contextul sesiunii }
  DataSet.FieldByName('FILTERID').AsInteger := CurrentFilterID;
  DataSet.FieldByName('CREATED_BY').AsInteger := dmDB.CurrentUserID;
end;

procedure TfrmGoodsTypeFiltersDlg.btnValNewClick(Sender: TObject);
begin
  if CurrentFilterID = 0 then
  begin
    ShowMessage('Selectati mai intai un filtru din sablon.');
    Exit;
  end;
  IBCQueryParams.Append;
end;

procedure TfrmGoodsTypeFiltersDlg.btnValDeleteClick(Sender: TObject);
begin
  if IBCQueryParams.IsEmpty then
    Exit;
  if MessageDlg(Format('Stergeti valoarea [%s]?',
    [IBCQueryParams.FieldByName('PARAM_VALUE').AsString]),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    IBCQueryParams.Delete;
end;

(* ---------- template-uri de denumire ----------
  Denumirea produsului se compune din aceste template-uri prin
  SWNAttributeNameUnit.ComposeGoodsName. Placeholder-ul {attr:Nume} ia acum
  valoarea FILTRULUI cu denumirea data (numele placeholder-ului a ramas
  neschimbat ca sa nu se strice template-urile deja scrise).
  Comentariul foloseste stil paranteza-stea fiindca textul contine acolade. *)

procedure TfrmGoodsTypeFiltersDlg.btnNameNewClick(Sender: TObject);
var
  d: TfrmNameTemplateEditorDlg;
begin
  d := TfrmNameTemplateEditorDlg.Create(Self, IBCQueryNameTmpl, IBCDataSourceNameTmpl);
  try
    d.GoodsTypeID := FGoodsTypeID;
    d.CreateNewItem := True;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeFiltersDlg.btnNameEditClick(Sender: TObject);
var
  d: TfrmNameTemplateEditorDlg;
begin
  if IBCQueryNameTmpl.IsEmpty then
    Exit;
  d := TfrmNameTemplateEditorDlg.Create(Self, IBCQueryNameTmpl, IBCDataSourceNameTmpl);
  try
    d.CreateNewItem := False;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeFiltersDlg.btnNameDeleteClick(Sender: TObject);
begin
  if IBCQueryNameTmpl.IsEmpty then
    Exit;
  if MessageDlg('Stergeti acest template de denumire?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    IBCQueryNameTmpl.Delete;
end;

end.
