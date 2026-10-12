unit frmSupplierPickupListDialog;

(* ============================================================================
   Ridicari de marfa de la furnizori - lista pentru operatori si soferi.

   Sursa: VW_TDB_SUPPLIER_PICKUP (sarcinile create din comanda clientului prin
   TfrmSupplierPickupConfirmDlg). Actiunile de stare lucreaza pe randurile
   selectate (selectie multipla) si se salveaza imediat, intr-o tranzactie:

     Atribuie soferul / Scoate soferul  - prin dispecerat (SP_DISPATCH_PICKUP_ASSIGN / _UNASSIGN):
                                          ridicarea intra/iese din traseul soferului
     Ridicata                           - STATEID = 2 (PICKED_AT din trigger)
     Anuleaza                           - STATEID = 3
     Redeschide                         - ridicata/anulata -> noua sau atribuita

   Modifica (sau dublu-click) deschide ridicarea curenta in dialogul de
   confirmare: furnizori, cantitate, data ridicarii, nota.

   Doua moduri:
     - general (meniul principal): toate ridicarile de facut + istoric 60 zile;
     - filtrat pe o linie de comanda (ShowSupplierPickupsForOrderLine): toate
       ridicarile produsului din document, plus butonul "Ridicare noua".

   Starea "atribuita" (1) o pune triggerul cand sarcina noua primeste sofer.
   Grila se poate grupa dupa sofer sau dupa furnizorul de ridicare (traseul).
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
    cxGridCustomView, cxGrid, cxButtons, cxTextEdit, cxCheckBox, cxCalendar,
    cxDBData, dxScrollbarAnnotations, dxDateRanges, Vcl.Menus;

type
    TfrmSupplierPickupListDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        IBCQueryPickups: TIBCQuery;
        IBCDataSourcePickups: TIBCDataSource;
        pnTop: TPanel;
        chkOnlyActive: TcxCheckBox;
        btnRefresh: TcxButton;
        btnRules: TcxButton;
        btnNewPickup: TcxButton;
        cxGridPickups: TcxGrid;
        cxGridPickupsTable: TcxGridDBTableView;
        cxGridPickupsLevel: TcxGridLevel;
        colPICKUPID: TcxGridDBColumn;
        colPLAN_DATE: TcxGridDBColumn;
        colSTATE_NAME: TcxGridDBColumn;
        colDRIVER_NAME: TcxGridDBColumn;
        colPICKUP_SUPPLIER_NAME: TcxGridDBColumn;
        colGOODS_TITLE: TcxGridDBColumn;
        colGOODS_CODE: TcxGridDBColumn;
        colQTY: TcxGridDBColumn;
        colSTOCK_SUPPLIER_NAME: TcxGridDBColumn;
        colORDER_SUPPLIER_NAME: TcxGridDBColumn;
        colDOCID: TcxGridDBColumn;
        colDOC_DATA: TcxGridDBColumn;
        colCLIENT_NAME: TcxGridDBColumn;
        colNOTE: TcxGridDBColumn;
        colPICKED_AT: TcxGridDBColumn;
        colCREATED_BY_NAME: TcxGridDBColumn;
        colCREATED_AT: TcxGridDBColumn;
        pnBottom: TPanel;
        btnModify: TcxButton;
        btnAssignDriver: TcxButton;
        btnClearDriver: TcxButton;
        btnPicked: TcxButton;
        btnCancelPickup: TcxButton;
        btnReopen: TcxButton;
        btnClose: TcxButton;
        procedure btnRefreshClick(Sender: TObject);
        procedure btnRulesClick(Sender: TObject);
        procedure btnNewPickupClick(Sender: TObject);
        procedure chkOnlyActivePropertiesChange(Sender: TObject);
        procedure btnModifyClick(Sender: TObject);
        procedure btnAssignDriverClick(Sender: TObject);
        procedure btnClearDriverClick(Sender: TObject);
        procedure btnPickedClick(Sender: TObject);
        procedure btnCancelPickupClick(Sender: TObject);
        procedure btnReopenClick(Sender: TObject);
        procedure cxGridPickupsTableCellDblClick(Sender: TcxCustomGridTableView;
            ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
            AShift: TShiftState; var AHandled: Boolean);
    private
        FFilterDocID: Integer;
        FFilterGoodsID: Integer;
        FFilterDTDEP: Integer;
        FFilterOrderQty: Integer;
        function IsFiltered: Boolean;
        function SelectedIDs: TArray<Integer>;
        function ApplyToSelected(const ASql: string; const ADriverID: Integer = 0): Integer;
        procedure ApplyDispatchToSelected(const ASql: string; const ACourierID: Integer);
        procedure RefreshData;
    protected
        procedure Prepare; override;
    public
        { filtrarea pe o linie de comanda; se seteaza inainte de ShowModal }
        procedure SetOrderLineFilter(const ADocID, ADTDEP, AGoodsID, AOrderQty: Integer);
    end;

{ Butonul "Alege furnizorul" din comanda:
  - linia nu are ridicari active -> alegere furnizor + ridicare noua;
  - o singura ridicare activa care acopera toata cantitatea -> se deschide ea;
  - altfel -> lista ridicarilor liniei (modificare / ridicare noua). }
procedure ShowSupplierPickupsForOrderLine(AOwner: TComponent;
    const ADocID, ADTDEP, AGoodsID, AOrderQty: Integer);

implementation

uses
    DataModuleDB, frmCustomersDlg, frmSupplierOrderRulesDialog, frmSupplierPickupConfirmDialog,
    SWNCustomersTypesUnit, DispatchCommonUnit, System.Math, System.UITypes;

{$R *.dfm}

procedure ShowSupplierPickupsForOrderLine(AOwner: TComponent;
    const ADocID, ADTDEP, AGoodsID, AOrderQty: Integer);
var
    q: TIBCQuery;
    activeCount, singleID: Integer;
    activeQty: Double;
    dialog: TfrmSupplierPickupListDlg;
begin
    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.SQL.Text :=
            'SELECT COUNT(*), COALESCE(SUM(QTY), 0), MAX(PICKUPID) FROM TDB_SUPPLIER_PICKUP ' +
            'WHERE DOCID = :DOCID AND GOODSID = :GOODSID AND STATEID <> 3';
        q.ParamByName('DOCID').AsInteger := ADocID;
        q.ParamByName('GOODSID').AsInteger := AGoodsID;
        q.Open;
        activeCount := q.Fields[0].AsInteger;
        activeQty := q.Fields[1].AsFloat;
        singleID := q.Fields[2].AsInteger;
    finally
        q.Free;
    end;

    if activeCount = 0 then
    begin
        PlanNewSupplierPickup(AOwner, ADocID, ADTDEP, AGoodsID, AOrderQty);
        Exit;
    end;

    if (activeCount = 1) and (Ceil(activeQty) >= AOrderQty) then
    begin
        EditSupplierPickup(AOwner, singleID, AOrderQty);
        Exit;
    end;

    dialog := TfrmSupplierPickupListDlg.Create(AOwner);
    try
        dialog.SetOrderLineFilter(ADocID, ADTDEP, AGoodsID, AOrderQty);
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

{ TfrmSupplierPickupListDlg }

procedure TfrmSupplierPickupListDlg.SetOrderLineFilter(const ADocID, ADTDEP, AGoodsID, AOrderQty: Integer);
begin
    FFilterDocID := ADocID;
    FFilterDTDEP := ADTDEP;
    FFilterGoodsID := AGoodsID;
    FFilterOrderQty := AOrderQty;
end;

function TfrmSupplierPickupListDlg.IsFiltered: Boolean;
begin
    Result := (FFilterDocID > 0) and (FFilterGoodsID > 0);
end;

procedure TfrmSupplierPickupListDlg.Prepare;
begin
    IBCQueryPickups.Connection := dmDB.IBCConnection;

    if IsFiltered then
    begin
        Caption := Format('Ridicari pentru comanda %d', [FFilterDocID]);
        dtDialogTitle.Title := Caption;
        dtDialogTitle.Text := 'Ridicarile acestui produs din comanda. Modifica (sau dublu-click) pentru ' +
            'data, cantitate si furnizori; Ridicare noua pentru restul cantitatii.';
        chkOnlyActive.Visible := False;
        btnNewPickup.Visible := True;
        { in filtru se vede o singura comanda - coloanele ei nu mai sunt utile }
        colDOCID.Visible := False;
        colDOC_DATA.Visible := False;
        colCLIENT_NAME.Visible := False;
    end
    else
    begin
        dtDialogTitle.Text := 'Marfa de ridicat de la furnizori pentru comenzile clientilor';
        btnNewPickup.Visible := False;
    end;

    RefreshData;
end;

procedure TfrmSupplierPickupListDlg.RefreshData;
var
    focusedID: Integer;
begin
    focusedID := 0;
    if IBCQueryPickups.Active and not IBCQueryPickups.IsEmpty then
        focusedID := IBCQueryPickups.FieldByName('PICKUPID').AsInteger;

    IBCQueryPickups.Close;
    if IsFiltered then
        IBCQueryPickups.SQL.Text := Format(
            'SELECT * FROM VW_TDB_SUPPLIER_PICKUP ' +
            'WHERE DOCID = %d AND GOODSID = %d ' +
            'ORDER BY PICKUPID', [FFilterDocID, FFilterGoodsID])
    else if chkOnlyActive.Checked then
        IBCQueryPickups.SQL.Text :=
            'SELECT * FROM VW_TDB_SUPPLIER_PICKUP ' +
            'WHERE STATEID IN (0, 1) ' +
            'ORDER BY PLAN_DATE, PICKUP_SUPPLIER_NAME, PICKUPID'
    else
        IBCQueryPickups.SQL.Text :=
            'SELECT * FROM VW_TDB_SUPPLIER_PICKUP ' +
            'WHERE STATEID IN (0, 1) OR CREATED_AT >= DATEADD(-60 DAY TO CURRENT_DATE) ' +
            'ORDER BY PLAN_DATE, PICKUP_SUPPLIER_NAME, PICKUPID';
    IBCQueryPickups.Open;

    if focusedID > 0 then
        IBCQueryPickups.Locate('PICKUPID', focusedID, []);
end;

function TfrmSupplierPickupListDlg.SelectedIDs: TArray<Integer>;
var
    i, n: Integer;
    rec: TcxCustomGridRecord;
    v: Variant;
begin
    SetLength(Result, cxGridPickupsTable.Controller.SelectedRecordCount);
    n := 0;
    for i := 0 to cxGridPickupsTable.Controller.SelectedRecordCount - 1 do
    begin
        rec := cxGridPickupsTable.Controller.SelectedRecords[i];
        if not rec.IsData then
            Continue;
        v := rec.Values[colPICKUPID.Index];
        if VarIsNull(v) or VarIsEmpty(v) then
            Continue;
        Result[n] := v;
        Inc(n);
    end;
    SetLength(Result, n);
end;

{ Executa ASql (cu parametrii :PICKUPID, :USERID si optional :DRIVERID) pentru
  fiecare rand selectat, intr-o singura tranzactie. Intoarce numarul de randuri
  modificate efectiv (conditiile de stare din SQL pot exclude unele randuri). }
function TfrmSupplierPickupListDlg.ApplyToSelected(const ASql: string; const ADriverID: Integer): Integer;
var
    ids: TArray<Integer>;
    id: Integer;
    tr: TIBCTransaction;
    q: TIBCQuery;
begin
    Result := 0;
    ids := SelectedIDs;
    if Length(ids) = 0 then
    begin
        ShowMessage('Selectati cel putin o ridicare.');
        Exit;
    end;

    tr := TIBCTransaction.Create(nil);
    q := TIBCQuery.Create(nil);
    try
        tr.DefaultConnection := dmDB.IBCConnection;
        q.Connection := dmDB.IBCConnection;
        q.Transaction := tr;
        q.SQL.Text := ASql;
        tr.StartTransaction;
        try
            for id in ids do
            begin
                q.ParamByName('PICKUPID').AsInteger := id;
                q.ParamByName('USERID').AsInteger := dmDB.CurrentUserID;
                if q.Params.FindParam('DRIVERID') <> nil then
                    q.ParamByName('DRIVERID').AsInteger := ADriverID;
                q.Execute;
                Inc(Result, q.RowsAffected);
            end;
            tr.Commit;
        except
            if tr.Active then
                tr.Rollback;
            raise;
        end;
    finally
        q.Free;
        tr.Free;
    end;

    RefreshData;

    if Result < Length(ids) then
        ShowMessage(Format('Modificate: %d din %d. Celelalte nu erau in starea potrivita pentru aceasta actiune.',
            [Result, Length(ids)]));
end;

procedure TfrmSupplierPickupListDlg.btnModifyClick(Sender: TObject);
begin
    if IBCQueryPickups.IsEmpty then
        Exit;

    if EditSupplierPickup(Self, IBCQueryPickups.FieldByName('PICKUPID').AsInteger, FFilterOrderQty) then
        RefreshData;
end;

procedure TfrmSupplierPickupListDlg.cxGridPickupsTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
    var AHandled: Boolean);
begin
    btnModifyClick(btnModify);
    AHandled := True;
end;

procedure TfrmSupplierPickupListDlg.btnNewPickupClick(Sender: TObject);
begin
    if not IsFiltered then
        Exit;

    if PlanNewSupplierPickup(Self, FFilterDocID, FFilterDTDEP, FFilterGoodsID, FFilterOrderQty) then
        RefreshData;
end;

{ Soferul se pune prin dispecerat (SP_DISPATCH_PICKUP_ASSIGN): ridicarea intra pe
  traseul curierului in ziua ridicarii, iar DRIVERID/PLAN_DATE sint copia traseului.
  Doar colaboratorii cu profil de curier (TS_COURIER) pot fi alesi. }
procedure TfrmSupplierPickupListDlg.btnAssignDriverClick(Sender: TObject);
var
    dialog: TfrmCustomersDlg;
    driverID: Integer;
begin
    if Length(SelectedIDs) = 0 then
    begin
        ShowMessage('Selectati cel putin o ridicare.');
        Exit;
    end;

    driverID := 0;
    dialog := TfrmCustomersDlg.Create(Self);
    try
        dialog.CustomFilter := [cfColaboratori];
        if dialog.SelectCustomer(IBCQueryPickups.FieldByName('DRIVERID').AsInteger, False, 0,
            'Selecteaza soferul') then
            driverID := dialog.CustomerID;
    finally
        dialog.Free;
    end;

    if driverID <= 0 then
        Exit;

    ApplyDispatchToSelected(
        'SELECT O_STOPID FROM SP_DISPATCH_PICKUP_ASSIGN(:ID, :COURIER, ' +
        '(SELECT COALESCE(PLAN_DATE, CURRENT_DATE) FROM TDB_SUPPLIER_PICKUP WHERE PICKUPID = :ID2))',
        driverID);
end;

procedure TfrmSupplierPickupListDlg.btnClearDriverClick(Sender: TObject);
begin
    ApplyDispatchToSelected('EXECUTE PROCEDURE SP_DISPATCH_PICKUP_UNASSIGN(:ID)', 0);
end;

procedure TfrmSupplierPickupListDlg.ApplyDispatchToSelected(const ASql: string; const ACourierID: Integer);
var
    ids: TArray<Integer>;
    id, ok: Integer;
    err, errors: string;
begin
    ids := SelectedIDs;
    if Length(ids) = 0 then
    begin
        ShowMessage('Selectati cel putin o ridicare.');
        Exit;
    end;

    ok := 0;
    errors := '';
    for id in ids do
    begin
        if ACourierID > 0 then
        begin
            if DispatchTry(ASql, ['ID', 'COURIER', 'ID2'], [id, ACourierID, id], err) then
                Inc(ok)
            else
                errors := errors + Format('%d: %s', [id, err]) + sLineBreak;
        end
        else if DispatchTry(ASql, ['ID'], [id], err) then
            Inc(ok)
        else
            errors := errors + Format('%d: %s', [id, err]) + sLineBreak;
    end;

    RefreshData;
    if ok < Length(ids) then
        ShowMessage(Format('Modificate: %d din %d.', [ok, Length(ids)]) + sLineBreak + sLineBreak + errors);
end;

procedure TfrmSupplierPickupListDlg.btnPickedClick(Sender: TObject);
begin
    ApplyToSelected(
        'UPDATE TDB_SUPPLIER_PICKUP SET STATEID = 2, UPDATED_BY = :USERID ' +
        'WHERE PICKUPID = :PICKUPID AND STATEID IN (0, 1)');
end;

procedure TfrmSupplierPickupListDlg.btnCancelPickupClick(Sender: TObject);
var
    ids: TArray<Integer>;
begin
    ids := SelectedIDs;
    if Length(ids) = 0 then
    begin
        ShowMessage('Selectati cel putin o ridicare.');
        Exit;
    end;

    if MessageDlg(Format('Anulati %d ridicari selectate?', [Length(ids)]),
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

    ApplyToSelected(
        'UPDATE TDB_SUPPLIER_PICKUP SET STATEID = 3, UPDATED_BY = :USERID ' +
        'WHERE PICKUPID = :PICKUPID AND STATEID IN (0, 1)');
end;

procedure TfrmSupplierPickupListDlg.btnReopenClick(Sender: TObject);
begin
    ApplyToSelected(
        'UPDATE TDB_SUPPLIER_PICKUP ' +
        'SET STATEID = CASE WHEN DRIVERID IS NULL THEN 0 ELSE 1 END, UPDATED_BY = :USERID ' +
        'WHERE PICKUPID = :PICKUPID AND STATEID IN (2, 3)');
end;

procedure TfrmSupplierPickupListDlg.btnRefreshClick(Sender: TObject);
begin
    RefreshData;
end;

procedure TfrmSupplierPickupListDlg.chkOnlyActivePropertiesChange(Sender: TObject);
begin
    if IBCQueryPickups.Connection <> nil then
        RefreshData;
end;

procedure TfrmSupplierPickupListDlg.btnRulesClick(Sender: TObject);
var
    dialog: TfrmSupplierOrderRulesDlg;
begin
    dialog := TfrmSupplierOrderRulesDlg.Create(Self);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

end.
