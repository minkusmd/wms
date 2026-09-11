unit frameGoodsServicesUnit;

(* ============================================================================
  Frame pentru SERVICIILE ADIACENTE ale unui PRODUS concret.
  Se embedeaza in tab-ul "Servicii" al editorului de continut
  (frmContentGoodsEditorDialog).

  Grila arata ce se propune la produs:
    - regulile TIPULUI lui (TS_GOODS_SERVICE.GOODSTYPEID = WEBGOODSTYPE_ID),
      daca produsul nu are regula proprie pentru acelasi serviciu;
    - regulile PRODUSULUI (TS_GOODS_SERVICE.GOODSID), inclusiv cele "ascunse"
      (FLG_DISABLED = 1), ca sa poata fi restabilite.
  "Pret final" = SP_GET_GOODS_SERVICES pe grila de pret 1, in MDL.

  Actiuni:
    - Adauga            -> regula noua pe produs;
    - Modifica          -> pe regula produsului: editare; pe regula tipului:
                           creeaza pret propriu pe produs pentru acel serviciu;
    - Sterge / Ascunde  -> pe regula produsului: o sterge (produsul revine la
                           regula tipului, daca exista); pe regula tipului:
                           o ascunde pentru produs (FLG_DISABLED = 1).
  Scrierile folosesc tranzactia editorului de produs -> "Renunta" le anuleaza.
  ============================================================================ *)

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, DBAccess, IBC, MemDS,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxClasses,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, cxButtons,
  dxScrollbarAnnotations, dxDateRanges, Vcl.Menus, cxDBData, cxCheckBox, cxCurrencyEdit;

type
  TframeGoodsServices = class(TFrame)
    IBCQueryView: TIBCQuery;
    IBCDataSourceView: TIBCDataSource;
    IBCQueryRules: TIBCQuery;
    IBCDataSourceRules: TIBCDataSource;
    pnTop: TPanel;
    btnAdd: TcxButton;
    btnEdit: TcxButton;
    btnDelete: TcxButton;
    lbInfo: TLabel;
    cxGridSvc: TcxGrid;
    cxGridSvcTable: TcxGridDBTableView;
    cxGridSvcLevel: TcxGridLevel;
    colTitle: TcxGridDBColumn;
    colSource: TcxGridDBColumn;
    colPrice: TcxGridDBColumn;
    colCurrency: TcxGridDBColumn;
    colPercent: TcxGridDBColumn;
    colFinalPrice: TcxGridDBColumn;
    colDefault: TcxGridDBColumn;
    colRequired: TcxGridDBColumn;
    colOrderNo: TcxGridDBColumn;
    colNote: TcxGridDBColumn;
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cxGridSvcTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure IBCDataSourceViewDataChange(Sender: TObject; Field: TField);
  private
    FGoodsID: Integer;
    FGoodsTypeID: Integer;
    FTransaction: TIBCTransaction;
    procedure EnsureTransaction;
    procedure OpenRules;
    procedure RefreshData(const ALocateServiceID: Integer);
    function CurrentIsProductRule: Boolean;
  public
    { Incarca serviciile produsului, in tranzactia editorului. }
    procedure LoadData(const AGoodsID, AGoodsTypeID: Integer; const ATr: TIBCTransaction);
  end;

implementation

uses
  SWNDBErrors, DataModuleDB, System.UITypes, frmGoodsServiceEditorDialog;

{$R *.dfm}

const
  cRulesSelect =
    'SELECT GSID, GOODSTYPEID, GOODSID, SERVICE_GOODSID, PRICE, CURRENCYID, ' +
    '       PRICE_PERCENT, FLG_DEFAULT, FLG_REQUIRED, FLG_DISABLED, ORDERNO, NOTE ' +
    '  FROM TS_GOODS_SERVICE WHERE GOODSID = :gid';
  cRulesInsert =
    'INSERT INTO TS_GOODS_SERVICE ' +
    '  (GSID, GOODSTYPEID, GOODSID, SERVICE_GOODSID, PRICE, CURRENCYID, ' +
    '   PRICE_PERCENT, FLG_DEFAULT, FLG_REQUIRED, FLG_DISABLED, ORDERNO, NOTE) ' +
    'VALUES ' +
    '  (:GSID, :GOODSTYPEID, :GOODSID, :SERVICE_GOODSID, :PRICE, :CURRENCYID, ' +
    '   :PRICE_PERCENT, :FLG_DEFAULT, :FLG_REQUIRED, :FLG_DISABLED, :ORDERNO, :NOTE)';
  cRulesUpdate =
    'UPDATE TS_GOODS_SERVICE SET ' +
    '  SERVICE_GOODSID = :SERVICE_GOODSID, PRICE = :PRICE, CURRENCYID = :CURRENCYID, ' +
    '  PRICE_PERCENT = :PRICE_PERCENT, FLG_DEFAULT = :FLG_DEFAULT, ' +
    '  FLG_REQUIRED = :FLG_REQUIRED, FLG_DISABLED = :FLG_DISABLED, ' +
    '  ORDERNO = :ORDERNO, NOTE = :NOTE ' +
    'WHERE GSID = :Old_GSID';
  cRulesDelete =
    'DELETE FROM TS_GOODS_SERVICE WHERE GSID = :Old_GSID';

  { Regulile produsului + regulile tipului neacoperite de produs. Parametrii
    au nume diferite ca sa nu depindem de felul in care IBDAC trateaza
    parametrii repetati. }
  cViewSelect =
    'SELECT x.GSID, x.SERVICE_GOODSID, x.RULE_SOURCE, x.PRICE, x.CURRENCYID, ' +
    '       x.PRICE_PERCENT, x.FLG_DEFAULT, x.FLG_REQUIRED, x.FLG_DISABLED, ' +
    '       x.ORDERNO, x.NOTE, ' +
    '       g.TITLE AS SERVICE_TITLE, ' +
    '       c.TITLE AS CURRENCY_TITLE, ' +
    '       CASE ' +
    '         WHEN x.RULE_SOURCE = 1 AND x.FLG_DISABLED = 1 THEN ''Tip (dezactivat)'' ' +
    '         WHEN x.RULE_SOURCE = 1 THEN ''Tip de produs'' ' +
    '         WHEN x.FLG_DISABLED = 1 THEN ''Produs - ascuns'' ' +
    '         ELSE ''Produs'' ' +
    '       END AS SOURCE_TEXT, ' +
    '       (SELECT r.PRICE FROM SP_GET_GOODS_SERVICES(:gid3, 1, 498, NULL) r ' +
    '         WHERE r.SERVICE_GOODSID = x.SERVICE_GOODSID) AS FINAL_PRICE ' +
    '  FROM ( ' +
    '        SELECT s.GSID, s.SERVICE_GOODSID, 2 AS RULE_SOURCE, s.PRICE, s.CURRENCYID, ' +
    '               s.PRICE_PERCENT, s.FLG_DEFAULT, s.FLG_REQUIRED, s.FLG_DISABLED, ' +
    '               s.ORDERNO, s.NOTE ' +
    '          FROM TS_GOODS_SERVICE s ' +
    '         WHERE s.GOODSID = :gid1 ' +
    '        UNION ALL ' +
    '        SELECT s.GSID, s.SERVICE_GOODSID, 1, s.PRICE, s.CURRENCYID, ' +
    '               s.PRICE_PERCENT, s.FLG_DEFAULT, s.FLG_REQUIRED, s.FLG_DISABLED, ' +
    '               s.ORDERNO, s.NOTE ' +
    '          FROM TS_GOODS_SERVICE s ' +
    '         WHERE s.GOODSTYPEID = :gtid ' +
    '           AND NOT EXISTS (SELECT 1 FROM TS_GOODS_SERVICE p ' +
    '                            WHERE p.GOODSID = :gid2 ' +
    '                              AND p.SERVICE_GOODSID = s.SERVICE_GOODSID) ' +
    '       ) x ' +
    '  JOIN TS_GOODS g ON g.GOODSID = x.SERVICE_GOODSID ' +
    '  LEFT JOIN TS_CURRENCY c ON c.CURRENCYID = x.CURRENCYID ' +
    ' ORDER BY x.ORDERNO, g.TITLE';

{ TframeGoodsServices }

procedure TframeGoodsServices.LoadData(const AGoodsID, AGoodsTypeID: Integer;
  const ATr: TIBCTransaction);
begin
  FGoodsID := AGoodsID;
  FGoodsTypeID := AGoodsTypeID;
  FTransaction := ATr;

  btnAdd.Enabled := FGoodsID > 0;
  btnEdit.Enabled := FGoodsID > 0;
  btnDelete.Enabled := FGoodsID > 0;

  IBCQueryRules.Close;
  if FGoodsID <= 0 then
  begin
    IBCQueryView.Close;
    lbInfo.Caption := 'Salvati mai intai produsul, apoi adaugati servicii.';
    Exit;
  end;
  if FGoodsTypeID <= 0 then
    lbInfo.Caption := 'Produsul nu are tip web: se vad doar serviciile adaugate pe el.'
  else
    lbInfo.Caption := 'Randurile "Tip de produs" vin din regulile tipului. ' +
      'Pretul final e calculat pentru grila 1, in MDL.';

  RefreshData(0);
end;

procedure TframeGoodsServices.EnsureTransaction;
begin
  if not FTransaction.Active then
    FTransaction.StartTransaction;
end;

procedure TframeGoodsServices.RefreshData(const ALocateServiceID: Integer);
begin
  EnsureTransaction;
  IBCQueryView.Close;
  IBCQueryView.Connection := dmDB.IBCConnection;
  IBCQueryView.Transaction := FTransaction;
  IBCQueryView.SQL.Text := cViewSelect;
  IBCQueryView.ParamByName('gid1').AsInteger := FGoodsID;
  IBCQueryView.ParamByName('gid2').AsInteger := FGoodsID;
  IBCQueryView.ParamByName('gid3').AsInteger := FGoodsID;
  IBCQueryView.ParamByName('gtid').AsInteger := FGoodsTypeID;
  IBCQueryView.Open;
  if ALocateServiceID > 0 then
    IBCQueryView.Locate('SERVICE_GOODSID', ALocateServiceID, []);
  IBCDataSourceViewDataChange(nil, nil);
end;

{ Datasetul editabil cu regulile produsului - pe el lucreaza editorul de regula.
  Ambele tranzactii legate la tranzactia editorului de produs. }
procedure TframeGoodsServices.OpenRules;
begin
  EnsureTransaction;
  if IBCQueryRules.Active then
    Exit;
  IBCQueryRules.Connection := dmDB.IBCConnection;
  IBCQueryRules.Transaction := FTransaction;
  IBCQueryRules.UpdateTransaction := FTransaction;
  IBCQueryRules.KeyFields := 'GSID';
  IBCQueryRules.KeyGenerator := 'SQ_TS_GOODS_SERVICE_ID';
  IBCQueryRules.SQL.Text := cRulesSelect;
  IBCQueryRules.SQLInsert.Text := cRulesInsert;
  IBCQueryRules.SQLUpdate.Text := cRulesUpdate;
  IBCQueryRules.SQLDelete.Text := cRulesDelete;
  IBCQueryRules.ParamByName('gid').AsInteger := FGoodsID;
  IBCQueryRules.Open;
end;

function TframeGoodsServices.CurrentIsProductRule: Boolean;
begin
  Result := (not IBCQueryView.IsEmpty) and (IBCQueryView.FieldByName('RULE_SOURCE').AsInteger = 2);
end;

procedure TframeGoodsServices.IBCDataSourceViewDataChange(Sender: TObject; Field: TField);
begin
  if not IBCQueryView.Active or IBCQueryView.IsEmpty then
    btnDelete.Caption := 'Sterge / Ascunde'
  else if CurrentIsProductRule then
    btnDelete.Caption := 'Sterge regula produsului'
  else
    btnDelete.Caption := 'Ascunde pe acest produs';
end;

procedure TframeGoodsServices.btnAddClick(Sender: TObject);
var
  d: TfrmGoodsServiceEditorDlg;
begin
  if FGoodsID <= 0 then
    Exit;
  OpenRules;
  d := TfrmGoodsServiceEditorDlg.Create(Self, IBCQueryRules, IBCDataSourceRules);
  try
    d.CreateNewItem := True;
    d.GoodsID := FGoodsID;
    if d.ShowModal = mrOk then
      RefreshData(IBCQueryRules.FieldByName('SERVICE_GOODSID').AsInteger);
  finally
    d.Free;
  end;
end;

procedure TframeGoodsServices.btnEditClick(Sender: TObject);
var
  d: TfrmGoodsServiceEditorDlg;
  serviceId: Integer;
begin
  if (FGoodsID <= 0) or IBCQueryView.IsEmpty then
    Exit;
  serviceId := IBCQueryView.FieldByName('SERVICE_GOODSID').AsInteger;
  OpenRules;
  d := TfrmGoodsServiceEditorDlg.Create(Self, IBCQueryRules, IBCDataSourceRules);
  try
    if CurrentIsProductRule then
    begin
      if not IBCQueryRules.Locate('GSID', IBCQueryView.FieldByName('GSID').AsInteger, []) then
        Exit;
      d.CreateNewItem := False;
    end
    else
    begin
      { regula tipului -> pret propriu pe produs pentru acelasi serviciu }
      d.CreateNewItem := True;
      d.GoodsID := FGoodsID;
      d.ServiceGoodsID := serviceId;
      d.LockService := True;
      d.PresetDefault := IBCQueryView.FieldByName('FLG_DEFAULT').AsInteger = 1;
      d.PresetRequired := IBCQueryView.FieldByName('FLG_REQUIRED').AsInteger = 1;
      d.PresetOrderNo := IBCQueryView.FieldByName('ORDERNO').AsInteger;
    end;
    if d.ShowModal = mrOk then
      RefreshData(serviceId);
  finally
    d.Free;
  end;
end;

procedure TframeGoodsServices.btnDeleteClick(Sender: TObject);
var
  serviceId: Integer;
  title: string;
begin
  if (FGoodsID <= 0) or IBCQueryView.IsEmpty then
    Exit;
  serviceId := IBCQueryView.FieldByName('SERVICE_GOODSID').AsInteger;
  title := IBCQueryView.FieldByName('SERVICE_TITLE').AsString;
  OpenRules;
  try
    if CurrentIsProductRule then
    begin
      if MessageDlg(Format('Stergeti regula produsului pentru serviciul [%s]?' + #13#10 +
        'Daca tipul de produs are regula pentru el, produsul revine la ea.', [title]),
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;
      if IBCQueryRules.Locate('GSID', IBCQueryView.FieldByName('GSID').AsInteger, []) then
        IBCQueryRules.Delete;
    end
    else
    begin
      if MessageDlg(Format('Ascundeti serviciul [%s] pentru acest produs?', [title]),
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;
      IBCQueryRules.Append;
      IBCQueryRules.FieldByName('GOODSID').AsInteger := FGoodsID;
      IBCQueryRules.FieldByName('SERVICE_GOODSID').AsInteger := serviceId;
      IBCQueryRules.FieldByName('FLG_DEFAULT').AsInteger := 0;
      IBCQueryRules.FieldByName('FLG_REQUIRED').AsInteger := 0;
      IBCQueryRules.FieldByName('FLG_DISABLED').AsInteger := 1;
      IBCQueryRules.FieldByName('ORDERNO').AsInteger := IBCQueryView.FieldByName('ORDERNO').AsInteger;
      IBCQueryRules.Post;
    end;
  except
    on e: Exception do
    begin
      if IBCQueryRules.State in dsEditModes then
        IBCQueryRules.Cancel;
      if not ProcessSWNError(e) then
        MessageDlg('Operatia nu a reusit:' + #13#10 + e.Message, mtError, [mbOK], 0);
    end;
  end;
  RefreshData(serviceId);
end;

procedure TframeGoodsServices.cxGridSvcTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
  btnEditClick(btnEdit);
  AHandled := True;
end;

end.
