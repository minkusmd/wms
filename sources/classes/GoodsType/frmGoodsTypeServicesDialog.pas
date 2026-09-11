unit frmGoodsTypeServicesDialog;

(* ============================================================================
  Manager SERVICII ADIACENTE pe un tip de produs (TS_GOODS_TYPE).
  Se lanseaza din editorul de tip (butonul "Servicii adiacente").

  Grila = regulile TS_GOODS_SERVICE cu GOODSTYPEID = tipul curent. Ele se
  propun la TOATE produsele tipului (TS_GOODS.WEBGOODSTYPE_ID).
  "Preturi pe produse" deschide frmGoodsServicePricesDialog: pret propriu pe
  fiecare produs al tipului (ex. montaj dupa dimensiunea dulapului).

  Tranzactie proprie (IBCTransactionUpdate): OK -> Commit, Renunta -> Rollback,
  inclusiv pentru ce s-a modificat in "Preturi pe produse".
  ============================================================================ *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS, Vcl.Menus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView,
  cxGrid, cxButtons, dxScrollbarAnnotations, dxDateRanges, cxDBData, cxCheckBox,
  cxCurrencyEdit;

type
  TfrmGoodsTypeServicesDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    IBCTransactionUpdate: TIBCTransaction;
    IBCQueryServices: TIBCQuery;
    IBCDataSourceServices: TIBCDataSource;
    pnButtons: TPanel;
    btnNew: TcxButton;
    btnEdit: TcxButton;
    btnDelete: TcxButton;
    btnProductPrices: TcxButton;
    lbInfo: TLabel;
    cxGridServices: TcxGrid;
    cxGridServicesTable: TcxGridDBTableView;
    cxGridServicesLevel: TcxGridLevel;
    colTitle: TcxGridDBColumn;
    colStdPrice: TcxGridDBColumn;
    colPrice: TcxGridDBColumn;
    colCurrency: TcxGridDBColumn;
    colPercent: TcxGridDBColumn;
    colDefault: TcxGridDBColumn;
    colRequired: TcxGridDBColumn;
    colOrderNo: TcxGridDBColumn;
    colOverrides: TcxGridDBColumn;
    colNote: TcxGridDBColumn;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnProductPricesClick(Sender: TObject);
    procedure cxGridServicesTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
  private
    FGoodsTypeID: Integer;
    function GetTypeTitle: string;
    procedure RefreshServices(const ALocateGSID: Integer);
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property GoodsTypeID: Integer read FGoodsTypeID write FGoodsTypeID;
  end;

implementation

uses
  SWNUtils, SWNDBErrors, DataModuleDB, System.UITypes,
  frmGoodsServiceEditorDialog, frmGoodsServicePricesDialog;

{$R *.dfm}

{ TfrmGoodsTypeServicesDlg }

function TfrmGoodsTypeServicesDlg.GetTypeTitle: string;
var
  q: TIBCQuery;
begin
  Result := '';
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.Transaction := IBCTransactionUpdate;
    q.SQL.Text := 'SELECT TITLE FROM TS_GOODS_TYPE WHERE GOODSTYPEID = :gtid';
    q.ParamByName('gtid').AsInteger := FGoodsTypeID;
    q.Open;
    Result := q.FieldByName('TITLE').AsString;
  finally
    q.Free;
  end;
end;

procedure TfrmGoodsTypeServicesDlg.Prepare;
begin
  try
    IBCTransactionUpdate.StartTransaction;
    IBCQueryServices.ParamByName('gtid').AsInteger := FGoodsTypeID;
    IBCQueryServices.Open;
    DialogTitle1.Text := Format('Tipul de produs: %s (#%d)', [GetTypeTitle, FGoodsTypeID]);
  except
    if IBCTransactionUpdate.Active then
      IBCTransactionUpdate.Rollback;
    raise;
  end;
end;

function TfrmGoodsTypeServicesDlg.IsFormDataPosted: Boolean;
begin
  if IBCQueryServices.State in dsEditModes then
    IBCQueryServices.Post;
  if IBCTransactionUpdate.Active then
    IBCTransactionUpdate.Commit;
  Result := True;
end;

procedure TfrmGoodsTypeServicesDlg.WhenCancelForm;
begin
  if IBCQueryServices.State in dsEditModes then
    IBCQueryServices.Cancel;
  if IBCTransactionUpdate.Active then
    IBCTransactionUpdate.Rollback;
end;

{ Recitire (coloanele calculate - denumire, pret standard, numar de preturi pe
  produse - nu se actualizeaza singure dupa Post). Aceeasi tranzactie, deci se
  vad si modificarile inca necomise. }
procedure TfrmGoodsTypeServicesDlg.RefreshServices(const ALocateGSID: Integer);
begin
  IBCQueryServices.Close;
  IBCQueryServices.Open;
  if ALocateGSID > 0 then
    IBCQueryServices.Locate('GSID', ALocateGSID, []);
end;

procedure TfrmGoodsTypeServicesDlg.btnNewClick(Sender: TObject);
var
  d: TfrmGoodsServiceEditorDlg;
  newId: Integer;
begin
  d := TfrmGoodsServiceEditorDlg.Create(Self, IBCQueryServices, IBCDataSourceServices);
  try
    d.CreateNewItem := True;
    d.GoodsTypeID := FGoodsTypeID;
    d.PresetOrderNo := IBCQueryServices.RecordCount + 1;
    if d.ShowModal = mrOk then
    begin
      newId := IBCQueryServices.FieldByName('GSID').AsInteger;
      RefreshServices(newId);
    end;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeServicesDlg.btnEditClick(Sender: TObject);
var
  d: TfrmGoodsServiceEditorDlg;
  id: Integer;
begin
  if IBCQueryServices.IsEmpty then
    Exit;
  id := IBCQueryServices.FieldByName('GSID').AsInteger;
  d := TfrmGoodsServiceEditorDlg.Create(Self, IBCQueryServices, IBCDataSourceServices);
  try
    d.CreateNewItem := False;
    if d.ShowModal = mrOk then
      RefreshServices(id);
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeServicesDlg.btnDeleteClick(Sender: TObject);
var
  msg: string;
begin
  if IBCQueryServices.IsEmpty then
    Exit;
  msg := Format('Scoateti serviciul [%s] de la acest tip de produs?',
    [IBCQueryServices.FieldByName('SERVICE_TITLE').AsString]);
  if IBCQueryServices.FieldByName('N_OVERRIDES').AsInteger > 0 then
    msg := msg + #13#10 + Format('Preturile proprii de pe produse (%d) raman; ' +
      'le puteti gestiona din "Preturi pe produse".',
      [IBCQueryServices.FieldByName('N_OVERRIDES').AsInteger]);
  if MessageDlg(msg, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  try
    IBCQueryServices.Delete;
  except
    on e: Exception do
      if not ProcessSWNError(e) then
        raise;
  end;
end;

procedure TfrmGoodsTypeServicesDlg.btnProductPricesClick(Sender: TObject);
var
  d: TfrmGoodsServicePricesDlg;
  id: Integer;
begin
  id := 0;
  d := TfrmGoodsServicePricesDlg.Create(Self);
  try
    d.Transaction := IBCTransactionUpdate;
    d.GoodsTypeID := FGoodsTypeID;
    if not IBCQueryServices.IsEmpty then
    begin
      id := IBCQueryServices.FieldByName('GSID').AsInteger;
      d.ServiceGoodsID := IBCQueryServices.FieldByName('SERVICE_GOODSID').AsInteger;
    end;
    if d.ShowModal = mrOk then
      RefreshServices(id);
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeServicesDlg.cxGridServicesTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
  btnEditClick(btnEdit);
  AHandled := True;
end;

end.
