unit frmGoodsServiceEditorDialog;

(* ============================================================================
  Editor pentru o regula de SERVICIU ADIACENT (tabela TS_GOODS_SERVICE).

  Editeaza randul curent al datasetului primit (TSWNMasteredFormClass).
  Folosit din doua locuri:
    - managerul pe tip de produs (frmGoodsTypeServicesDialog) -> GoodsTypeID;
    - tab-ul "Servicii" al editorului de continut (frameGoodsServicesUnit)
      -> GoodsID.
  Pe un rand e completat exact unul dintre ele (CK_TS_GOODS_SERVICE_SCOPE).

  Pretul si procentul sunt optionale. Semnificatia lor (calculul final e in
  SP_GET_GOODS_SERVICES, vezi DB Model\goods_services.sql):
    - regula pe tip:    pret gol = pretul serviciului din nomenclator;
    - regula pe produs: pret SI procent goale = se mosteneste pretul regulii de
      pe tip (daca exista), altfel pretul din nomenclator.
  Controalele NU sunt legate la date: valorile se scriu in IsFormDataPosted.
  Commit-ul il face fereastra parinte (tranzactia ei).
  ============================================================================ *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNBaseUnit, StdCtrls, ExtCtrls, DialogTitle, Data.DB, IBC, cxButtons, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  cxTextEdit, cxCheckBox, cxMaskEdit, cxSpinEdit, cxButtonEdit, cxDropDownEdit;

const
  { mapa SERVICII din nomenclator - pickerul de servicii se deschide pe ea }
  cServicesFolderGoodsID = 728;

type
  TfrmGoodsServiceEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    lbService: TLabel;
    lbStdPrice: TLabel;
    lbPrice: TLabel;
    lbCurrency: TLabel;
    lbPercent: TLabel;
    lbHint: TLabel;
    lbOrderNo: TLabel;
    lbNote: TLabel;
    beService: TcxButtonEdit;
    edPrice: TcxTextEdit;
    cbCurrency: TcxComboBox;
    edPercent: TcxTextEdit;
    chkDefault: TcxCheckBox;
    chkRequired: TcxCheckBox;
    chkDisabled: TcxCheckBox;
    edOrderNo: TcxSpinEdit;
    edNote: TcxTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure beServicePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    FCreateNewItem: Boolean;
    FGoodsTypeID: Integer;
    FGoodsID: Integer;
    FServiceGoodsID: Integer;
    FLockService: Boolean;
    FPresetDefault: Boolean;
    FPresetRequired: Boolean;
    FPresetOrderNo: Integer;
    procedure LoadCurrencies;
    procedure SetCurrency(const ACurrencyID: Integer);
    function GetCurrencyID: Integer;
    procedure ShowServiceInfo;
    function CheckParams(out APriceSet, APctSet: Boolean; out APrice, APct: Double): Boolean;
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { True = regula noua (Append); False = modifica randul curent (Edit) }
    property CreateNewItem: Boolean read FCreateNewItem write FCreateNewItem;
    { scopul regulii noi - se completeaza UNUL singur }
    property GoodsTypeID: Integer read FGoodsTypeID write FGoodsTypeID;
    property GoodsID: Integer read FGoodsID write FGoodsID;
    { serviciu presetat, ex. pret propriu pe produs pentru un serviciu al tipului }
    property ServiceGoodsID: Integer read FServiceGoodsID write FServiceGoodsID;
    property LockService: Boolean read FLockService write FLockService;
    property PresetDefault: Boolean read FPresetDefault write FPresetDefault;
    property PresetRequired: Boolean read FPresetRequired write FPresetRequired;
    property PresetOrderNo: Integer read FPresetOrderNo write FPresetOrderNo;
  end;

{ Numar optional introdus de utilizator: gol -> HasValue = False.
  Accepta virgula sau punct ca separator zecimal. False = text invalid. }
function ParseOptionalFloat(const S: string; out HasValue: Boolean; out Value: Double): Boolean;
{ Afisarea unui camp numeric optional: NULL -> '' }
function FormatOptionalFloat(const F: TField): string;

implementation

uses
  SWNUtils, SWNConst, SWNDBErrors, DataModuleDB, DBAccess, MemDS, System.UITypes, frmGoods;

{$R *.dfm}

function ParseOptionalFloat(const S: string; out HasValue: Boolean; out Value: Double): Boolean;
var
  t: string;
begin
  Value := 0;
  t := Trim(S);
  t := StringReplace(t, ' ', '', [rfReplaceAll]);
  t := StringReplace(t, ',', '.', [rfReplaceAll]);
  HasValue := t <> '';
  if not HasValue then
    Exit(True);
  Result := TryStrToFloat(t, Value, TFormatSettings.Invariant);
end;

function FormatOptionalFloat(const F: TField): string;
begin
  if (F = nil) or F.IsNull then
    Result := ''
  else
    Result := FormatFloat('0.##', F.AsFloat);
end;

{ TfrmGoodsServiceEditorDlg }

procedure TfrmGoodsServiceEditorDlg.BindingDataSource;
begin
  inherited;
  FCreateNewItem := False;
  FGoodsTypeID := 0;
  FGoodsID := 0;
  FServiceGoodsID := 0;
  FLockService := False;
  FPresetDefault := False;
  FPresetRequired := False;
  FPresetOrderNo := 0;
end;

procedure TfrmGoodsServiceEditorDlg.LoadCurrencies;
var
  q: TIBCQuery;
begin
  cbCurrency.Properties.Items.Clear;
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.SQL.Text := 'SELECT CURRENCYID, TITLE FROM TS_CURRENCY ORDER BY CURRENCYID';
    q.Open;
    while not q.Eof do
    begin
      cbCurrency.Properties.Items.AddObject(q.FieldByName('TITLE').AsString,
        TObject(NativeInt(q.FieldByName('CURRENCYID').AsInteger)));
      q.Next;
    end;
  finally
    q.Free;
  end;
end;

procedure TfrmGoodsServiceEditorDlg.SetCurrency(const ACurrencyID: Integer);
var
  i: Integer;
begin
  cbCurrency.ItemIndex := -1;
  for i := 0 to cbCurrency.Properties.Items.Count - 1 do
    if NativeInt(cbCurrency.Properties.Items.Objects[i]) = ACurrencyID then
    begin
      cbCurrency.ItemIndex := i;
      Break;
    end;
end;

function TfrmGoodsServiceEditorDlg.GetCurrencyID: Integer;
begin
  if cbCurrency.ItemIndex < 0 then
    Result := 498
  else
    Result := Integer(NativeInt(cbCurrency.Properties.Items.Objects[cbCurrency.ItemIndex]));
end;

{ Denumirea serviciului ales + pretul lui standard (PRICE1) din nomenclator. }
procedure TfrmGoodsServiceEditorDlg.ShowServiceInfo;
var
  q: TIBCQuery;
begin
  beService.Text := '';
  lbStdPrice.Caption := '';
  if FServiceGoodsID <= 0 then
    Exit;
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.SQL.Text :=
      'SELECT g.TITLE, gp.PRICE1, ' +
      '       (SELECT c.TITLE FROM TS_CURRENCY c ' +
      '         WHERE c.CURRENCYID = COALESCE(gp.CURRENCY1ID, 498)) AS CUR_TITLE ' +
      '  FROM TS_GOODS g ' +
      '  LEFT JOIN TS_GOODS_PRICE gp ON gp.GOODSID = g.GOODSID ' +
      ' WHERE g.GOODSID = :gid';
    q.ParamByName('gid').AsInteger := FServiceGoodsID;
    q.Open;
    if q.IsEmpty then
      Exit;
    beService.Text := q.FieldByName('TITLE').AsString;
    if q.FieldByName('PRICE1').IsNull or (q.FieldByName('PRICE1').AsFloat = 0) then
      lbStdPrice.Caption := 'Pret standard in nomenclator: nesetat (0)'
    else
      lbStdPrice.Caption := Format('Pret standard in nomenclator: %s %s',
        [FormatFloat('0.00', q.FieldByName('PRICE1').AsFloat), q.FieldByName('CUR_TITLE').AsString]);
  finally
    q.Free;
  end;
end;

procedure TfrmGoodsServiceEditorDlg.beServicePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  d: TfrmGoodsBrowser;
  startId: Integer;
begin
  if FLockService then
    Exit;
  if FServiceGoodsID > 0 then
    startId := FServiceGoodsID
  else
    startId := cServicesFolderGoodsID;
  d := TfrmGoodsBrowser.Create(Self);
  try
    if d.SelectGoods(startId, False, 0, 'Alegeti serviciul') then
    begin
      if d.GoodsIsFolder then
        Exit;
      if (FGoodsID > 0) and (d.GoodsID = FGoodsID) then
      begin
        ShowMessage('Produsul nu poate fi propriul lui serviciu.');
        Exit;
      end;
      FServiceGoodsID := d.GoodsID;
      ShowServiceInfo;
    end;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsServiceEditorDlg.Prepare;
var
  ds: TDataSet;
begin
  ds := fMasterDataSet;
  LoadCurrencies;

  if FCreateNewItem then
  begin
    if FLockService then
      dtDialogTitle.Text := 'Pret propriu pe produs pentru un serviciu al tipului'
    else
      dtDialogTitle.Text := 'Serviciu nou';
    ds.Append;
    if FGoodsTypeID > 0 then
      ds.FieldByName('GOODSTYPEID').AsInteger := FGoodsTypeID;
    if FGoodsID > 0 then
      ds.FieldByName('GOODSID').AsInteger := FGoodsID;
    edPrice.Text := '';
    edPercent.Text := '';
    edNote.Text := '';
    SetCurrency(498);
    chkDefault.Checked := FPresetDefault;
    chkRequired.Checked := FPresetRequired;
    chkDisabled.Checked := False;
    edOrderNo.Value := FPresetOrderNo;
  end
  else
  begin
    dtDialogTitle.Text := 'Modifica serviciul';
    ds.Edit;
    FServiceGoodsID := ds.FieldByName('SERVICE_GOODSID').AsInteger;
    FGoodsTypeID := ds.FieldByName('GOODSTYPEID').AsInteger;
    FGoodsID := ds.FieldByName('GOODSID').AsInteger;
    edPrice.Text := FormatOptionalFloat(ds.FieldByName('PRICE'));
    edPercent.Text := FormatOptionalFloat(ds.FieldByName('PRICE_PERCENT'));
    if ds.FieldByName('CURRENCYID').IsNull then
      SetCurrency(498)
    else
      SetCurrency(ds.FieldByName('CURRENCYID').AsInteger);
    chkDefault.Checked := ds.FieldByName('FLG_DEFAULT').AsInteger = 1;
    chkRequired.Checked := ds.FieldByName('FLG_REQUIRED').AsInteger = 1;
    chkDisabled.Checked := ds.FieldByName('FLG_DISABLED').AsInteger = 1;
    edOrderNo.Value := ds.FieldByName('ORDERNO').AsInteger;
    edNote.Text := ds.FieldByName('NOTE').AsString;
  end;

  { ascunderea are sens doar pe produs (anuleaza regula mostenita de la tip) }
  chkDisabled.Visible := FGoodsID > 0;
  beService.Enabled := not FLockService;

  if FGoodsID > 0 then
    lbHint.Caption := 'Pret si procent goale = se foloseste pretul regulii tipului, ' +
      'daca exista, altfel pretul din nomenclator. Completarea unuia dintre ele ' +
      'stabileste pretul doar pentru acest produs.'
  else
    lbHint.Caption := 'Pret gol = pretul serviciului din nomenclator. Procentul se ' +
      'aplica la pretul produsului si se aduna la pret.';

  ShowServiceInfo;
end;

function TfrmGoodsServiceEditorDlg.CheckParams(out APriceSet, APctSet: Boolean;
  out APrice, APct: Double): Boolean;
var
  ErrorStr: string;
begin
  ErrorStr := '';
  if FServiceGoodsID <= 0 then
    AddErrorToStr(ErrorStr, 'Serviciul (alegeti-l din nomenclator)!');

  if not ParseOptionalFloat(edPrice.Text, APriceSet, APrice) then
    AddErrorToStr(ErrorStr, 'Pretul nu este un numar valid!')
  else if APriceSet and (APrice < 0) then
    AddErrorToStr(ErrorStr, 'Pretul nu poate fi negativ!');

  if not ParseOptionalFloat(edPercent.Text, APctSet, APct) then
    AddErrorToStr(ErrorStr, 'Procentul nu este un numar valid!')
  else if APctSet and ((APct < 0) or (APct > 1000)) then
    AddErrorToStr(ErrorStr, 'Procentul trebuie sa fie intre 0 si 1000!');

  Result := ErrorStr = '';
  if not Result then
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

function TfrmGoodsServiceEditorDlg.IsFormDataPosted: Boolean;
var
  priceSet, pctSet: Boolean;
  price, pct: Double;
  ds: TDataSet;
begin
  Result := False;
  if not CheckParams(priceSet, pctSet, price, pct) then
    Exit;

  ds := fMasterDataSet;
  if not (ds.State in dsEditModes) then
    ds.Edit;

  ds.FieldByName('SERVICE_GOODSID').AsInteger := FServiceGoodsID;
  if priceSet then
  begin
    ds.FieldByName('PRICE').AsFloat := price;
    ds.FieldByName('CURRENCYID').AsInteger := GetCurrencyID;
  end
  else
  begin
    ds.FieldByName('PRICE').Clear;
    ds.FieldByName('CURRENCYID').Clear;
  end;
  if pctSet then
    ds.FieldByName('PRICE_PERCENT').AsFloat := pct
  else
    ds.FieldByName('PRICE_PERCENT').Clear;
  ds.FieldByName('FLG_DEFAULT').AsInteger := Ord(chkDefault.Checked or chkRequired.Checked);
  ds.FieldByName('FLG_REQUIRED').AsInteger := Ord(chkRequired.Checked);
  ds.FieldByName('FLG_DISABLED').AsInteger := Ord(chkDisabled.Visible and chkDisabled.Checked);
  ds.FieldByName('ORDERNO').AsInteger := StrToIntDef(VarToStr(edOrderNo.Value), 0);
  if Trim(edNote.Text) = '' then
    ds.FieldByName('NOTE').Clear
  else
    ds.FieldByName('NOTE').AsString := Trim(edNote.Text);

  try
    ds.Post;
  except
    on e: Exception do
    begin
      { randul ramane in editare - utilizatorul poate corecta si reincerca }
      if Pos('UQ_TS_GOODS_SERVICE', UpperCase(e.Message)) > 0 then
        MessageDlg('Acest serviciu este deja adaugat aici.', mtWarning, [mbOK], 0)
      else if not ProcessSWNError(e) then
        MessageDlg('Serviciul nu a fost salvat:' + #13#10 + e.Message, mtError, [mbOK], 0);
      Exit;
    end;
  end;
  Result := True;
end;

procedure TfrmGoodsServiceEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
end;

end.
