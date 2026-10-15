unit frmAddGoodsToIncomingInvoiceDlgUnit;

{
  Adaugarea produsului din factura de iesire (frame 10) intr-o factura de
  intrare (DOCTYPEID = 106, "Primirea de bunuri", frame 9): una deschisa sau
  una noua, creata aici pentru furnizorul ales.

  Factura deschisa:
  - lista: facturile de intrare ale firmei curente, neinchise si nesterse;
    primele sint cele al caror furnizor (CT) are produsul in TS_GOODS_FOREIGN;
  - pretul propus = TS_GOODS_FOREIGN.PRICE0 al furnizorului facturii, convertit
    in valuta facturii (EXCHANGE_RATE al valutei pretului0 / RATE al facturii);
  - daca produsul e deja in factura (acelasi depozit), cantitatea se adauga la
    cea existenta, pretul ramine cel din factura.
  Factura noua:
  - lista: furnizorii produsului din TS_GOODS_FOREIGN (+ "Alt furnizor..." din
    catalogul de clienti); primii sint cei cu produsul in stoc (FLG_IN_PRICE,
    bitul 3 din FLAGS), apoi dupa pretul0 in lei;
  - antetul ca in frame 9: SP_GET_DOCTYPE_DEFAULTS(106, firma) + valuta si
    FLG_ACNT din contractul implicit al furnizorului; pretul propus e pretul0
    in lei, convertit la scriere daca factura e in alta valuta.
  Implicit e ales furnizorul cu produsul in stoc si cel mai mic pret0: factura
  lui deschisa, daca are, altfel factura noua.

  Pozitiile facturilor deschise: nivelul detail al grilei (lvLines, legat prin DOCID); qLines
  citeste VW_TDB_JURNAL doar pentru DOCID-urile din qDocs (IN cu lista - un join cu view-urile
  dureaza zeci de secunde). Factura selectata se deschide singura; produsul ales e ingrosat.

  Scrierea: VW_TDB_JURNAL (triggerii calculeaza SUMA, SUMAVAT, COST, STOCK_QTY)
  + SP_EXPENSES2JURNAL, ca in frame 9 (TdmDB.IBCQueryJurnalAfterPost); factura
  noua si produsul se scriu in aceeasi tranzactie.
}

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.UITypes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  RzPanel,
  RzDlgBtn,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxDBData,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalc,
  cxLabel,
  cxCheckBox,
  cxCurrencyEdit,
  Data.DB,
  DBAccess,
  IBC,
  MemDS,
  SWNBaseUnit;

type
  TfrmAddGoodsToIncomingInvoiceDlg = class(TSWNCustomForm)
    pnlTop: TPanel;
    lbGoods: TcxLabel;
    lbInfo: TcxLabel;
    pnlMode: TPanel;
    rbExistingDoc: TRadioButton;
    rbNewDoc: TRadioButton;
    cxGridDocs: TcxGrid;
    tvDocs: TcxGridDBTableView;
    tvDocsDOCID: TcxGridDBColumn;
    tvDocsDATA: TcxGridDBColumn;
    tvDocsCT_NAME: TcxGridDBColumn;
    tvDocsDTDEP_NAME: TcxGridDBColumn;
    tvDocsSUMA: TcxGridDBColumn;
    tvDocsCURRENCY_NAME: TcxGridDBColumn;
    tvDocsSUPPLIER_PRICE0: TcxGridDBColumn;
    tvDocsCURRENCY0_NAME: TcxGridDBColumn;
    tvDocsDOC_PRICE: TcxGridDBColumn;
    tvDocsQTY_IN_DOC: TcxGridDBColumn;
    tvDocsCREATED_BY_NAME: TcxGridDBColumn;
    lvDocs: TcxGridLevel;
    pnlSuppliers: TPanel;
    pnlSuppliersTop: TPanel;
    btnOtherSupplier: TButton;
    lbSuppliersInfo: TcxLabel;
    cxGridSuppliers: TcxGrid;
    tvSuppliers: TcxGridDBTableView;
    tvSuppliersNAME: TcxGridDBColumn;
    tvSuppliersFLG_IN_STOCK: TcxGridDBColumn;
    tvSuppliersPRICE0: TcxGridDBColumn;
    tvSuppliersCURRENCY0_NAME: TcxGridDBColumn;
    tvSuppliersPRICE0_MDL: TcxGridDBColumn;
    tvSuppliersLAST_PRICE_DATE: TcxGridDBColumn;
    tvSuppliersOPEN_DOCS: TcxGridDBColumn;
    lvSuppliers: TcxGridLevel;
    pnlBottom: TPanel;
    lbQty: TcxLabel;
    ceQty: TcxCalcEdit;
    lbPrice: TcxLabel;
    cePrice: TcxCalcEdit;
    lbPriceCurrency: TcxLabel;
    RzDialogButtons1: TRzDialogButtons;
    qDocs: TIBCQuery;
    dsDocs: TIBCDataSource;
    qSuppliers: TIBCQuery;
    dsSuppliers: TIBCDataSource;
    trWrite: TIBCTransaction;
    tvLines: TcxGridDBTableView;
    tvLinesGOODSID: TcxGridDBColumn;
    tvLinesGOODS_NAME: TcxGridDBColumn;
    tvLinesDTDEP_NAME: TcxGridDBColumn;
    tvLinesUM_NAME: TcxGridDBColumn;
    tvLinesQTY: TcxGridDBColumn;
    tvLinesPRICE: TcxGridDBColumn;
    tvLinesSUMA: TcxGridDBColumn;
    lvLines: TcxGridLevel;
    qLines: TIBCQuery;
    dsLines: TIBCDataSource;
    procedure dsDocsDataChange(Sender: TObject; Field: TField);
    procedure dsSuppliersDataChange(Sender: TObject; Field: TField);
    procedure tvDocsCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure rbModeClick(Sender: TObject);
    procedure btnOtherSupplierClick(Sender: TObject);
    procedure tvLinesCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    FGoodsID: Integer;
    FGoodsName: string;
    FQty: Double;
    FDocID: Integer;
    FIsNewDocument: Boolean;
    function IsNewDocumentMode: Boolean;
    procedure OpenLines;
    procedure DocsFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure OpenSuppliers(const ExtraSupplierID: Integer);
    procedure UpdateMode;
    procedure UpdatePrice;
    function GetExistingQty(const DocID, DTDEP, CTDEP: Integer): Variant;
    procedure ExecGoodsRow(const q: TIBCQuery; const DocID, DTDEP, CTDEP, FlgAcnt: Integer; const Qty, Price: Double;
      const AddToExisting: Boolean);
    procedure WriteGoodsToDocument(const DocID, DTDEP, CTDEP, FlgAcnt: Integer; const Qty, Price: Double;
      const AddToExisting: Boolean);
    function CreateDocumentWithGoods(const SupplierID: Integer; const Qty, PriceMDL: Double): Integer;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    property GoodsID: Integer read FGoodsID write FGoodsID;
    property GoodsName: string read FGoodsName write FGoodsName;
    property Qty: Double read FQty write FQty;
    // factura de intrare in care s-a adaugat produsul (dupa mrOk)
    property DocID: Integer read FDocID;
    // True = factura a fost creata in acest dialog
    property IsNewDocument: Boolean read FIsNewDocument;
  end;

// Deschide dialogul; intoarce DOCID-ul facturii de intrare sau 0 la renuntare.
function ShowAddGoodsToIncomingInvoiceDialog(const AOwner: TComponent; const GoodsID: Integer;
  const GoodsName: string; const Qty: Double): Integer;

implementation

uses
  DataModuleDB,
  SWNDBErrors,
  SWNUtils,
  frmCustomersDlg,
  frmCustomerContractsDialog;

{$R *.dfm}

const
  cDocTypeID_FacturaIntrare = 106; // "Primirea de bunuri", frame 9
  cCurrencyMDL = 498;
  cCurrencyUSD = 840;

function ShowAddGoodsToIncomingInvoiceDialog(const AOwner: TComponent; const GoodsID: Integer;
  const GoodsName: string; const Qty: Double): Integer;
var
  d: TfrmAddGoodsToIncomingInvoiceDlg;
begin
  Result := 0;
  d := TfrmAddGoodsToIncomingInvoiceDlg.Create(AOwner);
  try
    d.GoodsID := GoodsID;
    d.GoodsName := GoodsName;
    d.Qty := Qty;
    if d.ShowModal = mrOk then
      Result := d.DocID;
  finally
    d.Free;
  end;
end;

{ TfrmAddGoodsToIncomingInvoiceDlg }

procedure TfrmAddGoodsToIncomingInvoiceDlg.Prepare;
var
  UseNew: Boolean;
begin
  inherited;
  FDocID := 0;
  FIsNewDocument := False;
  lbGoods.Caption := Format('%s  (cod %d)', [FGoodsName, FGoodsID]);
  ceQty.Value := FQty;

  trWrite.DefaultConnection := dmDB.IBCConnection;

  qDocs.Close;
  qDocs.Connection := dmDB.IBCConnection;
  qDocs.ParamByName('GOODSID').AsInteger := FGoodsID;
  qDocs.ParamByName('GOODSID_F').AsInteger := FGoodsID;
  qDocs.ParamByName('DOCTYPEID').AsInteger := cDocTypeID_FacturaIntrare;
  qDocs.ParamByName('FIRMA').AsInteger := dmDB.CurrentFirma;
  qDocs.Open;
  OpenLines;
  tvDocs.OnFocusedRecordChanged := DocsFocusedRecordChanged;

  OpenSuppliers(0);

  // implicit: furnizorul cu produsul in stoc si cel mai mic pret0 (primul rind din lista);
  // factura lui deschisa, daca are, altfel factura noua
  UseNew := qDocs.IsEmpty;
  if not qSuppliers.IsEmpty and (qSuppliers.FieldByName('FLG_IN_STOCK').AsInteger = 1) then
    UseNew := not qDocs.Locate('CT', qSuppliers.FieldByName('CUSTOMERID').AsInteger, []);

  rbExistingDoc.Enabled := not qDocs.IsEmpty;
  if UseNew then
    rbNewDoc.Checked := True
  else
    rbExistingDoc.Checked := True;
  UpdateMode;
end;

procedure TfrmAddGoodsToIncomingInvoiceDlg.OpenSuppliers(const ExtraSupplierID: Integer);
begin
  qSuppliers.Close;
  qSuppliers.Connection := dmDB.IBCConnection;
  qSuppliers.ParamByName('GOODSID').AsInteger := FGoodsID;
  qSuppliers.ParamByName('GOODSID_F').AsInteger := FGoodsID;
  qSuppliers.ParamByName('DOCTYPEID').AsInteger := cDocTypeID_FacturaIntrare;
  qSuppliers.ParamByName('FIRMA').AsInteger := dmDB.CurrentFirma;
  qSuppliers.ParamByName('EXTRA_CT').AsInteger := ExtraSupplierID;
  qSuppliers.Open;
end;

// Pozitiile (VW_TDB_JURNAL) tuturor facturilor din lista; grila le leaga de factura prin DOCID.
procedure TfrmAddGoodsToIncomingInvoiceDlg.OpenLines;
var
  Ids: TStringList;
begin
  qLines.Close;
  qLines.Connection := dmDB.IBCConnection;
  Ids := TStringList.Create;
  try
    qDocs.DisableControls;
    try
      qDocs.First;
      while not qDocs.Eof do
      begin
        Ids.Add(IntToStr(qDocs.FieldByName('DOCID').AsInteger));
        qDocs.Next;
      end;
      qDocs.First;
    finally
      qDocs.EnableControls;
    end;
    if Ids.Count = 0 then
      Ids.Add('-1');
    Ids.Delimiter := ',';
    Ids.StrictDelimiter := True;
    qLines.SQL.Text := 'SELECT J.DOCID, J.DTDEP, J.CTDEP, J.GOODSCOMPLECT_ID, J.GOODSID, J.GOODS_NAME, ' +
      'J.DTDEP_NAME, J.UM_NAME, J.QTY, J.PRICE, J.SUMA ' +
      'FROM VW_TDB_JURNAL J WHERE J.DOCID IN (' + Ids.DelimitedText + ') ' +
      'ORDER BY J.DOCID, J.GOODS_NAME';
  finally
    Ids.Free;
  end;
  qLines.Open;
end;

// factura selectata isi arata pozitiile fara clic pe "+"
procedure TfrmAddGoodsToIncomingInvoiceDlg.DocsFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if AFocusedRecord is TcxGridMasterDataRow then
    TcxGridMasterDataRow(AFocusedRecord).Expanded := True;
end;

// produsul ales e deja in factura: rindul lui in pozitii e ingrosat
procedure TfrmAddGoodsToIncomingInvoiceDlg.tvLinesCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  V: Variant;
begin
  V := AViewInfo.GridRecord.Values[tvLinesGOODSID.Index];
  if VarIsNumeric(V) and (V = FGoodsID) then
    ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
end;

function TfrmAddGoodsToIncomingInvoiceDlg.IsNewDocumentMode: Boolean;
begin
  Result := rbNewDoc.Checked;
end;

procedure TfrmAddGoodsToIncomingInvoiceDlg.rbModeClick(Sender: TObject);
begin
  UpdateMode;
end;

procedure TfrmAddGoodsToIncomingInvoiceDlg.UpdateMode;
begin
  cxGridDocs.Visible := not IsNewDocumentMode;
  pnlSuppliers.Visible := IsNewDocumentMode;
  if IsNewDocumentMode then
    lbInfo.Caption := 'Se creeaza o factura de intrare noua pentru furnizorul ales. Pretul propus ' +
      '= pretul0 al furnizorului, in lei. Primii sint furnizorii cu produsul in stoc, dupa pret.'
  else
    lbInfo.Caption := 'Facturile de intrare deschise ale firmei curente. Pretul propus ' +
      '= pretul0 al produsului de la furnizorul facturii, in valuta facturii.';
  UpdatePrice;
end;

procedure TfrmAddGoodsToIncomingInvoiceDlg.UpdatePrice;
begin
  if IsNewDocumentMode then
  begin
    if qSuppliers.Active and not qSuppliers.IsEmpty then
      cePrice.Value := qSuppliers.FieldByName('PRICE0_MDL').AsFloat
    else
      cePrice.Value := 0;
    lbPriceCurrency.Caption := 'MDL';
  end
  else if qDocs.Active and not qDocs.IsEmpty then
  begin
    cePrice.Value := qDocs.FieldByName('DOC_PRICE').AsFloat;
    lbPriceCurrency.Caption := qDocs.FieldByName('CURRENCY_NAME').AsString;
  end;
end;

procedure TfrmAddGoodsToIncomingInvoiceDlg.dsDocsDataChange(Sender: TObject; Field: TField);
begin
  // la schimbarea facturii propunem pretul0 al furnizorului ei
  if (Field <> nil) or IsNewDocumentMode then
    Exit;
  UpdatePrice;
end;

procedure TfrmAddGoodsToIncomingInvoiceDlg.dsSuppliersDataChange(Sender: TObject; Field: TField);
begin
  // la schimbarea furnizorului propunem pretul0 lui
  if (Field <> nil) or not IsNewDocumentMode then
    Exit;
  UpdatePrice;
end;

procedure TfrmAddGoodsToIncomingInvoiceDlg.btnOtherSupplierClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
  SupplierID: Integer;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if not dialog.SelectCustomer(-1, False, 0, 'Selecteaza furnizorul') then
      Exit;
    SupplierID := dialog.CustomerID;
  finally
    dialog.Free;
  end;
  if SupplierID <= 0 then
    Exit;
  OpenSuppliers(SupplierID);
  qSuppliers.Locate('CUSTOMERID', SupplierID, []);
  UpdatePrice;
  cxGridSuppliers.SetFocus;
end;

procedure TfrmAddGoodsToIncomingInvoiceDlg.tvDocsCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  AHandled := True;
  ModalResult := mrOk;
end;

function TfrmAddGoodsToIncomingInvoiceDlg.IsFormDataPosted: Boolean;
var
  ExistingQty: Variant;
  DocID, DTDEP, CTDEP: Integer;
  NewQty, NewPrice: Double;
  AddToExisting: Boolean;
  SupplierName: string;
begin
  Result := False;

  if IsNewDocumentMode then
  begin
    if qSuppliers.IsEmpty then
    begin
      ShowErrorDialog('Factura de intrare', 'Alegeti furnizorul (sau "Alt furnizor...").');
      Exit;
    end;
    SupplierName := qSuppliers.FieldByName('NAME').AsString;
  end
  else
  begin
    if qDocs.IsEmpty then
    begin
      ShowErrorDialog('Factura de intrare', 'Alegeti factura de intrare.');
      Exit;
    end;
    SupplierName := qDocs.FieldByName('CT_NAME').AsString;
  end;

  NewQty := ceQty.Value;
  NewPrice := cePrice.Value;
  if NewQty <= 0 then
  begin
    ShowErrorDialog('Factura de intrare', 'Cantitatea trebuie sa fie mai mare ca 0.');
    Exit;
  end;
  if NewPrice < 0 then
  begin
    ShowErrorDialog('Factura de intrare', 'Pretul nu poate fi negativ.');
    Exit;
  end;

  if (NewPrice = 0) and (ShowAskDialog('Factura de intrare',
    Format('Furnizorul "%s" nu are pretul0 pentru acest produs.', [SupplierName]),
    'Adaugati produsul cu pretul 0?') <> mrYes) then
    Exit;

  if IsNewDocumentMode then
  begin
    if (qSuppliers.FieldByName('OPEN_DOCS').AsInteger > 0) and (ShowAskDialog('Factura de intrare',
      Format('Furnizorul "%s" are deja %d factur(i) de intrare deschise.',
        [SupplierName, qSuppliers.FieldByName('OPEN_DOCS').AsInteger]),
      'Creati totusi o factura noua?') <> mrYes) then
      Exit;

    try
      FDocID := CreateDocumentWithGoods(qSuppliers.FieldByName('CUSTOMERID').AsInteger, NewQty, NewPrice);
      FIsNewDocument := True;
      Result := True;
    except
      on E: Exception do
      begin
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
    Exit;
  end;

  DocID := qDocs.FieldByName('DOCID').AsInteger;
  DTDEP := qDocs.FieldByName('DTDEP').AsInteger;
  CTDEP := qDocs.FieldByName('CTDEP').AsInteger;

  // produsul exista deja pe acelasi depozit al facturii -> cheie primara ocupata
  ExistingQty := GetExistingQty(DocID, DTDEP, CTDEP);
  AddToExisting := not VarIsNull(ExistingQty);
  if AddToExisting and (ShowAskDialog('Factura de intrare',
    Format('Produsul exista deja in factura nr. %d (cantitatea %s).', [DocID, VarToStr(ExistingQty)]),
    'Adaugati cantitatea la cea existenta? Pretul ramine cel din factura.') <> mrYes) then
    Exit;

  try
    WriteGoodsToDocument(DocID, DTDEP, CTDEP, qDocs.FieldByName('FLG_ACNT').AsInteger, NewQty, NewPrice, AddToExisting);
    FDocID := DocID;
    Result := True;
  except
    on E: Exception do
    begin
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

function TfrmAddGoodsToIncomingInvoiceDlg.GetExistingQty(const DocID, DTDEP, CTDEP: Integer): Variant;
var
  q: TIBCQuery;
begin
  Result := Null;
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.SQL.Text := 'SELECT QTY FROM TDB_JURNAL WHERE DOCID = :DOCID AND DTDEP = :DTDEP AND CTDEP = :CTDEP ' +
      'AND GOODSCOMPLECT_ID = -1 AND GOODSID = :GOODSID';
    q.ParamByName('DOCID').AsInteger := DocID;
    q.ParamByName('DTDEP').AsInteger := DTDEP;
    q.ParamByName('CTDEP').AsInteger := CTDEP;
    q.ParamByName('GOODSID').AsInteger := FGoodsID;
    q.Open;
    if not q.IsEmpty then
      Result := q.FieldByName('QTY').Value;
  finally
    q.Free;
  end;
end;

// Rindul produsului in factura + repartizarea cheltuielilor; ruleaza in tranzactia lui q (trWrite).
procedure TfrmAddGoodsToIncomingInvoiceDlg.ExecGoodsRow(const q: TIBCQuery; const DocID, DTDEP, CTDEP,
  FlgAcnt: Integer; const Qty, Price: Double; const AddToExisting: Boolean);
begin
  if AddToExisting then
  begin
    q.SQL.Text := 'UPDATE TDB_JURNAL SET QTY = QTY + :QTY ' +
      'WHERE DOCID = :DOCID AND DTDEP = :DTDEP AND CTDEP = :CTDEP AND GOODSCOMPLECT_ID = -1 AND GOODSID = :GOODSID';
  end
  else
  begin
    q.SQL.Text := 'INSERT INTO VW_TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, QTY, PRICE, SUMA, ' +
      'SUMAVAT, WARRANTY, STOCK_QTY, COST, FLG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE) ' +
      'SELECT :DOCID, :DTDEP, :CTDEP, -1, G.GOODSID, COALESCE(G.UMID, 1), :QTY, :PRICE, 0, ' +
      '0, COALESCE(G.WARRANTY, 0), 0, 0, 1, :FLG_ACNT, 0, 0 ' +
      'FROM TS_GOODS G WHERE G.GOODSID = :GOODSID';
    q.ParamByName('PRICE').AsFloat := Price;
    q.ParamByName('FLG_ACNT').AsInteger := FlgAcnt;
  end;
  q.ParamByName('DOCID').AsInteger := DocID;
  q.ParamByName('DTDEP').AsInteger := DTDEP;
  q.ParamByName('CTDEP').AsInteger := CTDEP;
  q.ParamByName('GOODSID').AsInteger := FGoodsID;
  q.ParamByName('QTY').AsFloat := Qty;
  q.ExecSQL;
  if q.RowsAffected = 0 then
    raise Exception.CreateFmt('Produsul %d nu a fost gasit in nomenclator.', [FGoodsID]);

  // repartizarea cheltuielilor aditionale pe produse (ca in frame 9)
  q.SQL.Text := 'EXECUTE PROCEDURE SP_EXPENSES2JURNAL(:DOCID)';
  q.ParamByName('DOCID').AsInteger := DocID;
  q.ExecSQL;
end;

procedure TfrmAddGoodsToIncomingInvoiceDlg.WriteGoodsToDocument(const DocID, DTDEP, CTDEP, FlgAcnt: Integer;
  const Qty, Price: Double; const AddToExisting: Boolean);
var
  q: TIBCQuery;
begin
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.Transaction := trWrite;
    q.AutoCommit := False;

    trWrite.StartTransaction;
    try
      ExecGoodsRow(q, DocID, DTDEP, CTDEP, FlgAcnt, Qty, Price, AddToExisting);
      trWrite.Commit;
    except
      trWrite.Rollback;
      raise;
    end;
  finally
    q.Free;
  end;
end;

// Factura de intrare noua (antetul ca in frame 9, frmNakladnaiaPNDocDlg) + produsul, intr-o tranzactie.
// PriceMDL se converteste in valuta facturii, daca contractul furnizorului o cere alta decit lei.
function TfrmAddGoodsToIncomingInvoiceDlg.CreateDocumentWithGoods(const SupplierID: Integer;
  const Qty, PriceMDL: Double): Integer;
var
  q: TIBCQuery;
  Contract: TCustomerDefultContractInfo;
  DT, DTDEP, DTSC, SC2, CurrencyID, FlgAcnt, ContractID: Integer;
  Rate, RateUSD, Price: Double;
begin
  // valorile implicite ale tipului de document pe firma (Setari > tipuri de documente)
  DT := dmDB.CurrentFirma;
  DTDEP := -1;
  DTSC := -1;
  SC2 := -1;
  CurrencyID := cCurrencyMDL;
  FlgAcnt := 0;
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.SQL.Text := 'SELECT * FROM SP_GET_DOCTYPE_DEFAULTS(:DOCTYPEID, :FIRMA)';
    q.ParamByName('DOCTYPEID').AsInteger := cDocTypeID_FacturaIntrare;
    q.ParamByName('FIRMA').AsInteger := dmDB.CurrentFirma;
    q.Open;
    if not q.Eof then
    begin
      if not q.FieldByName('DT').IsNull then
        DT := q.FieldByName('DT').AsInteger;
      if not q.FieldByName('DTDEP').IsNull then
        DTDEP := q.FieldByName('DTDEP').AsInteger;
      if not q.FieldByName('DTSC').IsNull then
        DTSC := q.FieldByName('DTSC').AsInteger;
      if not q.FieldByName('SC').IsNull then
        SC2 := q.FieldByName('SC').AsInteger;
      if not q.FieldByName('CURRENCYID').IsNull then
        CurrencyID := q.FieldByName('CURRENCYID').AsInteger;
      FlgAcnt := q.FieldByName('FLG_ACNT').AsInteger;
    end;
  finally
    q.Free;
  end;
  if DTDEP <= 0 then
    raise Exception.Create('Pentru "Factura de intrare" nu e setat depozitul implicit al firmei curente ' +
      '(valorile implicite ale tipului de document). Creati factura din "Primirea de bunuri".');

  // contractul implicit al furnizorului da valuta si contabilitatea (ca SelectCT in frame 9)
  ContractID := -1;
  Contract := TCustomerDefultContractInfo.Create(nil, SupplierID, Now);
  try
    if Contract.ContractID > 0 then
    begin
      ContractID := Contract.ContractID;
      CurrencyID := Contract.CurrencyID;
      FlgAcnt := Ord(Contract.FLG_ACNT);
    end;
  finally
    Contract.Free;
  end;

  Rate := dmDB.GetCurrencyExchangeValue(CurrencyID, FlgAcnt = 1);
  RateUSD := dmDB.GetCurrencyExchangeValue(cCurrencyUSD, FlgAcnt = 1, True);
  if (Rate <= 0) or (RateUSD < 1) then
    raise Exception.Create('Cursul valutar al facturii nu a putut fi determinat.');
  if CurrencyID = cCurrencyMDL then
    Price := PriceMDL
  else
    Price := Round(PriceMDL / Rate * 100) / 100;

  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.Transaction := trWrite;
    q.AutoCommit := False;

    trWrite.StartTransaction;
    try
      q.SQL.Text := 'SELECT NEXT VALUE FOR SQ_TDB_DOCS_DOCID FROM RDB$DATABASE';
      q.Open;
      Result := q.Fields[0].AsInteger;
      q.Close;

      // DATA, CREATED_DATE, CREATED_BY, CTDEP / CTSC = -1 le pun triggerii (TRG_TDB_DOCS_BI)
      q.SQL.Text := 'INSERT INTO VW_TDB_DOCS (DOCID, DT, CT, DTDEP, DTSC, SC2, SUMA, VAT, CURRENCYID, DISCOUNT, ' +
        'RATE, RATEUSD, FLG_ACNT, ACC$MASK, DOCTYPEID, CONTRACTID) ' +
        'VALUES (:DOCID, :DT, :CT, :DTDEP, :DTSC, :SC2, 0, 0, :CURRENCYID, 0, ' +
        ':RATE, :RATEUSD, :FLG_ACNT, 0, :DOCTYPEID, :CONTRACTID)';
      q.ParamByName('DOCID').AsInteger := Result;
      q.ParamByName('DT').AsInteger := DT;
      q.ParamByName('CT').AsInteger := SupplierID;
      q.ParamByName('DTDEP').AsInteger := DTDEP;
      q.ParamByName('DTSC').AsInteger := DTSC;
      q.ParamByName('SC2').AsInteger := SC2;
      q.ParamByName('CURRENCYID').AsInteger := CurrencyID;
      q.ParamByName('RATE').AsFloat := Rate;
      q.ParamByName('RATEUSD').AsFloat := RateUSD;
      q.ParamByName('FLG_ACNT').AsInteger := FlgAcnt;
      q.ParamByName('DOCTYPEID').AsInteger := cDocTypeID_FacturaIntrare;
      q.ParamByName('CONTRACTID').AsInteger := ContractID;
      q.ExecSQL;

      ExecGoodsRow(q, Result, DTDEP, -1, FlgAcnt, Qty, Price, False);
      trWrite.Commit;
    except
      trWrite.Rollback;
      raise;
    end;
  finally
    q.Free;
  end;
end;

end.
