unit frmAddGoodsToIncomingInvoiceDlgUnit;

{
  Adaugarea produsului din factura de iesire (frame 10) intr-o factura de
  intrare deschisa (DOCTYPEID = 106, "Primirea de bunuri", frame 9).

  - lista: facturile de intrare ale firmei curente, neinchise si nesterse;
    primele sint cele al caror furnizor (CT) are produsul in TS_GOODS_FOREIGN;
  - pretul propus = TS_GOODS_FOREIGN.PRICE0 al furnizorului facturii, convertit
    in valuta facturii (EXCHANGE_RATE al valutei pretului0 / RATE al facturii);
  - cantitatea propusa = cantitatea din factura de iesire;
  - daca produsul e deja in factura (acelasi depozit), cantitatea se adauga la
    cea existenta, pretul ramine cel din factura.
  Scrierea: VW_TDB_JURNAL (triggerii calculeaza SUMA, SUMAVAT, COST, STOCK_QTY)
  + SP_EXPENSES2JURNAL, ca in frame 9 (TdmDB.IBCQueryJurnalAfterPost).
}

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
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
    pnlBottom: TPanel;
    lbQty: TcxLabel;
    ceQty: TcxCalcEdit;
    lbPrice: TcxLabel;
    cePrice: TcxCalcEdit;
    lbPriceCurrency: TcxLabel;
    RzDialogButtons1: TRzDialogButtons;
    qDocs: TIBCQuery;
    dsDocs: TIBCDataSource;
    trWrite: TIBCTransaction;
    procedure dsDocsDataChange(Sender: TObject; Field: TField);
    procedure tvDocsCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  private
    FGoodsID: Integer;
    FGoodsName: string;
    FQty: Double;
    FDocID: Integer;
    function GetExistingQty(const DocID, DTDEP, CTDEP: Integer): Variant;
    procedure WriteGoodsToDocument(const DocID, DTDEP, CTDEP, FlgAcnt: Integer; const Qty, Price: Double;
      const AddToExisting: Boolean);
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    property GoodsID: Integer read FGoodsID write FGoodsID;
    property GoodsName: string read FGoodsName write FGoodsName;
    property Qty: Double read FQty write FQty;
    // factura de intrare in care s-a adaugat produsul (dupa mrOk)
    property DocID: Integer read FDocID;
  end;

// Deschide dialogul; intoarce DOCID-ul facturii de intrare sau 0 la renuntare.
function ShowAddGoodsToIncomingInvoiceDialog(const AOwner: TComponent; const GoodsID: Integer;
  const GoodsName: string; const Qty: Double): Integer;

implementation

uses
  DataModuleDB,
  SWNDBErrors,
  SWNUtils;

{$R *.dfm}

const
  cDocTypeID_FacturaIntrare = 106; // "Primirea de bunuri", frame 9

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
begin
  inherited;
  FDocID := 0;
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

  if qDocs.IsEmpty then
  begin
    ShowInfoDialog('Factura de intrare', 'Nu exista facturi de intrare deschise pentru firma curenta.');
    ModalResult := mrCancel;
  end;
end;

procedure TfrmAddGoodsToIncomingInvoiceDlg.dsDocsDataChange(Sender: TObject; Field: TField);
begin
  // la schimbarea facturii propunem pretul0 al furnizorului ei
  if (Field <> nil) or not qDocs.Active or qDocs.IsEmpty then
    Exit;
  cePrice.Value := qDocs.FieldByName('DOC_PRICE').AsFloat;
  lbPriceCurrency.Caption := qDocs.FieldByName('CURRENCY_NAME').AsString;
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
begin
  Result := False;

  if qDocs.IsEmpty then
  begin
    ShowErrorDialog('Factura de intrare', 'Alegeti factura de intrare.');
    Exit;
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

  DocID := qDocs.FieldByName('DOCID').AsInteger;
  DTDEP := qDocs.FieldByName('DTDEP').AsInteger;
  CTDEP := qDocs.FieldByName('CTDEP').AsInteger;

  if (NewPrice = 0) and (ShowAskDialog('Factura de intrare',
    Format('Furnizorul "%s" nu are pretul0 pentru acest produs.', [qDocs.FieldByName('CT_NAME').AsString]),
    'Adaugati produsul cu pretul 0?') <> mrYes) then
    Exit;

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
