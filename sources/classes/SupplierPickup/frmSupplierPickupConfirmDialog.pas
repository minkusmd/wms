unit frmSupplierPickupConfirmDialog;

(* ============================================================================
   Ridicare de marfa de la furnizor (TDB_SUPPLIER_PICKUP): creare si modificare.

   Se confirma / se modifica:
     - furnizorul cu stoc (butonul deschide TfrmGoodsForeignCodeDlg);
     - furnizorul prin care se plaseaza comanda (intermediar). La o ridicare
       noua vine implicit din regula TS_SUPPLIER_ORDER_RULE; "Direct" = fara;
     - de unde ridica soferul marfa (la furnizorul cu stoc sau la intermediar);
     - cantitatea: 1 .. (cantitatea din comanda - ce e planificat in celelalte
       ridicari ale aceluiasi produs din acelasi document, fara cele anulate);
     - data ridicarii si nota.

   Mod nou:        PickupID = 0, se seteaza DocID/DTDEP/GoodsID/StockSupplierID/OrderQty.
   Mod modificare: PickupID > 0, restul se citeste din baza. Ridicarile deja
                   ridicate sau anulate se deschid doar pentru vizualizare.
   OrderQty = 0 -> se ia SUM(QTY) din TDB_JURNAL pentru document + produs.

   Utilizare: Execute (nu ShowModal). Salvarea se face la OK, intr-o tranzactie
   proprie. PlanNewSupplierPickup = fluxul complet din comanda (alegere
   furnizor cu stoc + confirmare).
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Vcl.Menus,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxSpinEdit, cxButtonEdit,
    cxRadioGroup, cxButtons, cxLabel, dxScrollbarAnnotations, Data.DB, IBC;

type
    TfrmSupplierPickupConfirmDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        pnClient: TPanel;
        lbGoodsCaption: TLabel;
        lbGoods: TLabel;
        lbStockSupplierCaption: TLabel;
        beStockSupplier: TcxButtonEdit;
        lbOrderSupplier: TLabel;
        beOrderSupplier: TcxButtonEdit;
        lbRuleInfo: TLabel;
        rgPickupFrom: TcxRadioGroup;
        lbQty: TLabel;
        seQty: TcxSpinEdit;
        lbQtyInfo: TLabel;
        lbPlanDate: TLabel;
        dePlanDate: TcxDateEdit;
        lbNote: TLabel;
        edNote: TcxTextEdit;
        lbState: TLabel;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        procedure beOrderSupplierPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
        procedure beStockSupplierPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    private
        FPickupID: Integer;
        FDocID: Integer;
        FDTDEP: Integer;
        FGoodsID: Integer;
        FStockSupplierID: Integer;
        FOrderQty: Integer;
        FPlannedQty: Double;       { planificat in ALTE ridicari (fara cea curenta si fara anulate) }
        FGoodsCode: string;
        FOrderSupplierID: Integer; { 0 = comanda directa la furnizorul cu stoc }
        { valori citite din baza in modul modificare }
        FLoadedQty: Double;
        FLoadedPickupSupplierID: Integer;
        FLoadedPlanDate: TDateTime;
        FLoadedNote: string;
        FStateID: Integer;
        FStateName: string;
        FDriverName: string;
        function IsEditMode: Boolean;
        function IsReadOnly: Boolean;
        function LoadPickup: Boolean;
        procedure LoadInfo;
        procedure ApplyRuleDefaults;
        procedure ShowStockSupplier;
        procedure SetOrderSupplier(const ACustomerID: Integer; const AName: string);
        procedure UpdateControlsState;
        procedure UpdateQtyLimits(const ADefaultQty: Integer);
        function MaxQty: Integer;
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
    public
        function Execute: Boolean;
        property PickupID: Integer read FPickupID write FPickupID;
        property DocID: Integer read FDocID write FDocID;
        property DTDEP: Integer read FDTDEP write FDTDEP;
        property GoodsID: Integer read FGoodsID write FGoodsID;
        property StockSupplierID: Integer read FStockSupplierID write FStockSupplierID;
        property OrderQty: Integer read FOrderQty write FOrderQty;
    end;

const
    cPickupFrom_StockSupplier = 0;
    cPickupFrom_OrderSupplier = 1;

    cPickupState_New      = 0;
    cPickupState_Assigned = 1;
    cPickupState_PickedUp = 2;
    cPickupState_Canceled = 3;

{ Alege furnizorul cu stoc (TfrmGoodsForeignCodeDlg) si confirma o ridicare
  noua. Intoarce True daca ridicarea a fost salvata. }
function PlanNewSupplierPickup(AOwner: TComponent; const ADocID, ADTDEP, AGoodsID,
    AOrderQty: Integer): Boolean;

{ Deschide o ridicare existenta pentru vizualizare / modificare. }
function EditSupplierPickup(AOwner: TComponent; const APickupID: Integer;
    const AOrderQty: Integer = 0): Boolean;

{ Alegerea furnizorului cu stoc prin TfrmGoodsForeignCodeDlg; -1 = renuntat. }
function SelectStockSupplier(AOwner: TComponent; const AGoodsID, AQty: Integer): Integer;

implementation

uses
    DataModuleDB, frmCustomersDlg, frmGoodsForeignCodeDialog, System.Math, System.UITypes;

{$R *.dfm}

function QueryScalar(const ASql: string; const AParams: array of Variant): Variant;
var
    q: TIBCQuery;
    i: Integer;
begin
    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.SQL.Text := ASql;
        for i := Low(AParams) to High(AParams) do
            q.Params[i].Value := AParams[i];
        q.Open;
        if q.IsEmpty then
            Result := Null
        else
            Result := q.Fields[0].Value;
    finally
        q.Free;
    end;
end;

function VarAsFloat(const V: Variant): Double;
begin
    if VarIsNull(V) or VarIsEmpty(V) then
        Result := 0
    else
        Result := V;
end;

function SelectStockSupplier(AOwner: TComponent; const AGoodsID, AQty: Integer): Integer;
var
    d: TfrmGoodsForeignCodeDlg;
begin
    Result := -1;
    d := TfrmGoodsForeignCodeDlg.Create(AOwner);
    try
        d.GoodsID := AGoodsID;
        d.Qty := AQty;
        if d.ShowModal = mrOk then
            Result := d.SupplierID;
    finally
        d.Free;
    end;
end;

function PlanNewSupplierPickup(AOwner: TComponent; const ADocID, ADTDEP, AGoodsID,
    AOrderQty: Integer): Boolean;
var
    stockSupplierID: Integer;
    confirm: TfrmSupplierPickupConfirmDlg;
begin
    Result := False;

    stockSupplierID := SelectStockSupplier(AOwner, AGoodsID, AOrderQty);
    if stockSupplierID <= 0 then
        Exit;

    confirm := TfrmSupplierPickupConfirmDlg.Create(AOwner);
    try
        confirm.DocID := ADocID;
        confirm.DTDEP := ADTDEP;
        confirm.GoodsID := AGoodsID;
        confirm.StockSupplierID := stockSupplierID;
        confirm.OrderQty := AOrderQty;
        Result := confirm.Execute;
    finally
        confirm.Free;
    end;
end;

function EditSupplierPickup(AOwner: TComponent; const APickupID: Integer;
    const AOrderQty: Integer): Boolean;
var
    confirm: TfrmSupplierPickupConfirmDlg;
begin
    confirm := TfrmSupplierPickupConfirmDlg.Create(AOwner);
    try
        confirm.PickupID := APickupID;
        confirm.OrderQty := AOrderQty;
        Result := confirm.Execute;
    finally
        confirm.Free;
    end;
end;

{ TfrmSupplierPickupConfirmDlg }

function TfrmSupplierPickupConfirmDlg.IsEditMode: Boolean;
begin
    Result := FPickupID > 0;
end;

function TfrmSupplierPickupConfirmDlg.IsReadOnly: Boolean;
begin
    Result := IsEditMode and not (FStateID in [cPickupState_New, cPickupState_Assigned]);
end;

function TfrmSupplierPickupConfirmDlg.MaxQty: Integer;
begin
    Result := FOrderQty - Ceil(FPlannedQty);
end;

function TfrmSupplierPickupConfirmDlg.LoadPickup: Boolean;
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.SQL.Text := 'SELECT * FROM VW_TDB_SUPPLIER_PICKUP WHERE PICKUPID = :PICKUPID';
        q.ParamByName('PICKUPID').AsInteger := FPickupID;
        q.Open;
        Result := not q.IsEmpty;
        if not Result then
            Exit;

        FDocID := q.FieldByName('DOCID').AsInteger;
        FDTDEP := q.FieldByName('DTDEP').AsInteger;
        FGoodsID := q.FieldByName('GOODSID').AsInteger;
        FStockSupplierID := q.FieldByName('STOCK_SUPPLIERID').AsInteger;
        if q.FieldByName('ORDER_SUPPLIERID').AsInteger <> FStockSupplierID then
            FOrderSupplierID := q.FieldByName('ORDER_SUPPLIERID').AsInteger
        else
            FOrderSupplierID := 0;
        FLoadedPickupSupplierID := q.FieldByName('PICKUP_SUPPLIERID').AsInteger;
        FLoadedQty := q.FieldByName('QTY').AsFloat;
        if q.FieldByName('PLAN_DATE').IsNull then
            FLoadedPlanDate := 0
        else
            FLoadedPlanDate := q.FieldByName('PLAN_DATE').AsDateTime;
        FLoadedNote := q.FieldByName('NOTE').AsString;
        FStateID := q.FieldByName('STATEID').AsInteger;
        FStateName := q.FieldByName('STATE_NAME').AsString;
        FDriverName := q.FieldByName('DRIVER_NAME').AsString;
    finally
        q.Free;
    end;
end;

procedure TfrmSupplierPickupConfirmDlg.LoadInfo;
begin
    if FOrderQty <= 0 then
        FOrderQty := Round(VarAsFloat(QueryScalar(
            'SELECT COALESCE(SUM(QTY), 0) FROM TDB_JURNAL WHERE DOCID = :DOCID AND GOODSID = :GOODSID',
            [FDocID, FGoodsID])));

    FPlannedQty := VarAsFloat(QueryScalar(
        'SELECT COALESCE(SUM(QTY), 0) FROM TDB_SUPPLIER_PICKUP ' +
        'WHERE DOCID = :DOCID AND GOODSID = :GOODSID AND STATEID <> 3 AND PICKUPID <> :PICKUPID',
        [FDocID, FGoodsID, FPickupID]));

    FGoodsCode := VarToStr(QueryScalar(
        'SELECT FIRST 1 GOODS_CODE FROM TS_GOODS_FOREIGN ' +
        'WHERE GOODSID = :GOODSID AND CUSTOMERID = :CUSTOMERID',
        [FGoodsID, FStockSupplierID]));
end;

function TfrmSupplierPickupConfirmDlg.Execute: Boolean;
begin
    Result := False;

    if IsEditMode then
    begin
        if not LoadPickup then
        begin
            ShowMessage(Format('Ridicarea nr. %d nu mai exista.', [FPickupID]));
            Exit;
        end;
    end
    else if (FDocID <= 0) or (FGoodsID <= 0) or (FStockSupplierID <= 0) then
        raise Exception.Create('Nu este selectat documentul, produsul sau furnizorul.');

    LoadInfo;

    if not IsEditMode then
    begin
        if FOrderQty <= 0 then
        begin
            ShowMessage('Cantitatea din comanda trebuie sa fie mai mare ca zero.');
            Exit;
        end;
        if MaxQty <= 0 then
        begin
            ShowMessage(Format('Pentru acest produs sunt deja planificate ridicari pentru toata ' +
                'cantitatea din comanda (%d din %d).', [Ceil(FPlannedQty), FOrderQty]));
            Exit;
        end;
    end;

    Result := ShowModal = mrOk;
end;

procedure TfrmSupplierPickupConfirmDlg.ShowStockSupplier;
begin
    beStockSupplier.Text := VarToStr(QueryScalar(
        'SELECT NAME FROM TS_CUSTOMER WHERE CUSTOMERID = :ID', [FStockSupplierID]));

    lbGoods.Caption := VarToStr(QueryScalar(
        'SELECT TITLE FROM TS_GOODS WHERE GOODSID = :GOODSID', [FGoodsID]));
    if FGoodsCode <> '' then
        lbGoods.Caption := lbGoods.Caption + '  [cod furnizor: ' + FGoodsCode + ']';
end;

procedure TfrmSupplierPickupConfirmDlg.ApplyRuleDefaults;
var
    q: TIBCQuery;
begin
    SetOrderSupplier(0, '');
    rgPickupFrom.ItemIndex := cPickupFrom_StockSupplier;
    lbRuleInfo.Caption := 'Nu exista regula: comanda se plaseaza direct la furnizorul cu stoc.';

    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.SQL.Text :=
            'SELECT R.ORDER_SUPPLIERID, R.PICKUP_FROM, C.NAME ' +
            'FROM TS_SUPPLIER_ORDER_RULE R ' +
            'LEFT JOIN TS_CUSTOMER C ON C.CUSTOMERID = R.ORDER_SUPPLIERID ' +
            'WHERE R.STOCK_SUPPLIERID = :ID AND R.FLG_ACTIVE = 1';
        q.ParamByName('ID').AsInteger := FStockSupplierID;
        q.Open;
        if not q.IsEmpty then
        begin
            SetOrderSupplier(q.FieldByName('ORDER_SUPPLIERID').AsInteger, q.FieldByName('NAME').AsString);
            rgPickupFrom.ItemIndex := q.FieldByName('PICKUP_FROM').AsInteger;
            UpdateControlsState;
            lbRuleInfo.Caption := 'Valori implicite din regula furnizorului (se pot modifica).';
        end;
    finally
        q.Free;
    end;
end;

procedure TfrmSupplierPickupConfirmDlg.UpdateQtyLimits(const ADefaultQty: Integer);
var
    maxValue: Integer;
begin
    maxValue := Max(MaxQty, 1);
    seQty.Properties.MinValue := 1;
    seQty.Properties.MaxValue := maxValue;
    seQty.Value := EnsureRange(ADefaultQty, 1, maxValue);

    if FPlannedQty > 0 then
        lbQtyInfo.Caption := Format('din comanda: %d, in alte ridicari: %d, maxim: %d',
            [FOrderQty, Ceil(FPlannedQty), MaxQty])
    else
        lbQtyInfo.Caption := Format('din comanda: %d', [FOrderQty]);
end;

procedure TfrmSupplierPickupConfirmDlg.Prepare;
begin
    ShowStockSupplier;

    if IsEditMode then
    begin
        Caption := Format('Ridicarea nr. %d', [FPickupID]);
        dtDialogTitle.Title := Caption;

        SetOrderSupplier(FOrderSupplierID, VarToStr(QueryScalar(
            'SELECT NAME FROM TS_CUSTOMER WHERE CUSTOMERID = :ID', [FOrderSupplierID])));
        if (FOrderSupplierID > 0) and (FLoadedPickupSupplierID = FOrderSupplierID) then
            rgPickupFrom.ItemIndex := cPickupFrom_OrderSupplier
        else
            rgPickupFrom.ItemIndex := cPickupFrom_StockSupplier;
        UpdateControlsState;
        lbRuleInfo.Caption := '';

        UpdateQtyLimits(Round(FLoadedQty));
        if FLoadedPlanDate > 0 then
            dePlanDate.Date := FLoadedPlanDate
        else
            dePlanDate.Clear;
        edNote.Text := FLoadedNote;

        lbState.Caption := 'Stare: ' + FStateName;
        if FDriverName <> '' then
            lbState.Caption := lbState.Caption + ',  sofer: ' + FDriverName;

        if IsReadOnly then
        begin
            dtDialogTitle.Text := 'Ridicarea este ' + LowerCase(FStateName) +
                ' - se poate doar vizualiza. Redeschideti-o din lista ridicarilor pentru a o modifica.';
            pnClient.Enabled := False;
            btnOk.Visible := False;
            btnCancel.Caption := 'Inchide';
        end
        else
            dtDialogTitle.Text := 'Verificati sau modificati furnizorii, cantitatea si data ridicarii';
    end
    else
    begin
        dtDialogTitle.Text := 'Confirmati furnizorul prin care comandam, locul ridicarii si cantitatea';
        ApplyRuleDefaults;
        UpdateQtyLimits(MaxQty);
        dePlanDate.Date := Date;
        edNote.Text := '';
        lbState.Caption := '';
    end;
end;

procedure TfrmSupplierPickupConfirmDlg.SetOrderSupplier(const ACustomerID: Integer; const AName: string);
begin
    FOrderSupplierID := ACustomerID;
    if ACustomerID > 0 then
        beOrderSupplier.Text := AName
    else
        beOrderSupplier.Text := beStockSupplier.Text + '  (direct, fara intermediar)';
    UpdateControlsState;
end;

procedure TfrmSupplierPickupConfirmDlg.UpdateControlsState;
begin
    { fara intermediar ridicarea se face obligatoriu la furnizorul cu stoc }
    if FOrderSupplierID <= 0 then
        rgPickupFrom.ItemIndex := cPickupFrom_StockSupplier;
    rgPickupFrom.Enabled := FOrderSupplierID > 0;
end;

procedure TfrmSupplierPickupConfirmDlg.beStockSupplierPropertiesButtonClick(Sender: TObject;
    AButtonIndex: Integer);
var
    newID: Integer;
begin
    newID := SelectStockSupplier(Self, FGoodsID, FOrderQty);
    if (newID <= 0) or (newID = FStockSupplierID) then
        Exit;

    FStockSupplierID := newID;
    FGoodsCode := VarToStr(QueryScalar(
        'SELECT FIRST 1 GOODS_CODE FROM TS_GOODS_FOREIGN ' +
        'WHERE GOODSID = :GOODSID AND CUSTOMERID = :CUSTOMERID',
        [FGoodsID, FStockSupplierID]));
    ShowStockSupplier;

    { alt furnizor cu stoc -> intermediarul si locul ridicarii vin din regula lui }
    ApplyRuleDefaults;
end;

procedure TfrmSupplierPickupConfirmDlg.beOrderSupplierPropertiesButtonClick(Sender: TObject;
    AButtonIndex: Integer);
var
    dialog: TfrmCustomersDlg;
begin
    { butonul 0 = alege intermediarul, butonul 1 = comanda directa }
    if AButtonIndex = 1 then
    begin
        SetOrderSupplier(0, '');
        Exit;
    end;

    dialog := TfrmCustomersDlg.Create(Self);
    try
        if dialog.SelectCustomer(FOrderSupplierID, False, 0, 'Furnizorul prin care se plaseaza comanda') then
        begin
            if dialog.CustomerID = FStockSupplierID then
                SetOrderSupplier(0, '')
            else
                SetOrderSupplier(dialog.CustomerID, dialog.CustomerTitle);
        end;
    finally
        dialog.Free;
    end;
end;

function TfrmSupplierPickupConfirmDlg.IsFormDataPosted: Boolean;
var
    qty: Integer;
    orderSupplierID, pickupSupplierID: Integer;
    q: TIBCQuery;
    tr: TIBCTransaction;
    isNew: Boolean;
begin
    Result := False;
    isNew := not IsEditMode;

    if IsReadOnly then
    begin
        Result := True;
        Exit;
    end;

    qty := Round(VarAsFloat(seQty.Value));
    if (qty < 1) or (qty > MaxQty) then
    begin
        if MaxQty < 1 then
            ShowMessage(Format('Nu mai ramane cantitate de ridicat: din comanda %d, in alte ridicari %d.',
                [FOrderQty, Ceil(FPlannedQty)]))
        else
            ShowMessage(Format('Cantitatea trebuie sa fie intre 1 si %d.', [MaxQty]));
        seQty.SetFocus;
        Exit;
    end;

    if FOrderSupplierID > 0 then
        orderSupplierID := FOrderSupplierID
    else
        orderSupplierID := FStockSupplierID;

    if rgPickupFrom.ItemIndex = cPickupFrom_OrderSupplier then
        pickupSupplierID := orderSupplierID
    else
        pickupSupplierID := FStockSupplierID;

    { tranzactie proprie: nu comitem modificarile altor ferestre deschise }
    tr := TIBCTransaction.Create(nil);
    q := TIBCQuery.Create(nil);
    try
        tr.DefaultConnection := dmDB.IBCConnection;
        q.Connection := dmDB.IBCConnection;
        q.Transaction := tr;
        tr.StartTransaction;
        try
            if not isNew then
            begin
                q.SQL.Text :=
                    'UPDATE TDB_SUPPLIER_PICKUP SET ' +
                    '  GOODS_CODE = :GOODS_CODE, QTY = :QTY, STOCK_SUPPLIERID = :STOCK_SUPPLIERID, ' +
                    '  ORDER_SUPPLIERID = :ORDER_SUPPLIERID, PICKUP_SUPPLIERID = :PICKUP_SUPPLIERID, ' +
                    '  PLAN_DATE = :PLAN_DATE, NOTE = :NOTE, UPDATED_BY = :USERID ' +
                    'WHERE PICKUPID = :PICKUPID AND STATEID IN (0, 1)';
            end
            else
            begin
                q.SQL.Text := 'SELECT NEXT VALUE FOR SQ_TDB_SUPPLIER_PICKUP_ID FROM RDB$DATABASE';
                q.Open;
                FPickupID := q.Fields[0].AsInteger;
                q.Close;

                q.SQL.Text :=
                    'INSERT INTO TDB_SUPPLIER_PICKUP ' +
                    '  (PICKUPID, DOCID, DTDEP, GOODSID, GOODS_CODE, QTY, STOCK_SUPPLIERID, ORDER_SUPPLIERID, ' +
                    '   PICKUP_SUPPLIERID, PLAN_DATE, NOTE, CREATED_BY) ' +
                    'VALUES ' +
                    '  (:PICKUPID, :DOCID, :DTDEP, :GOODSID, :GOODS_CODE, :QTY, :STOCK_SUPPLIERID, :ORDER_SUPPLIERID, ' +
                    '   :PICKUP_SUPPLIERID, :PLAN_DATE, :NOTE, :USERID)';
                q.ParamByName('DOCID').AsInteger := FDocID;
                if FDTDEP > 0 then
                    q.ParamByName('DTDEP').AsInteger := FDTDEP
                else
                    q.ParamByName('DTDEP').Clear;
                q.ParamByName('GOODSID').AsInteger := FGoodsID;
            end;

            q.ParamByName('PICKUPID').AsInteger := FPickupID;
            if FGoodsCode <> '' then
                q.ParamByName('GOODS_CODE').AsString := Copy(FGoodsCode, 1, 128)
            else
                q.ParamByName('GOODS_CODE').Clear;
            q.ParamByName('QTY').AsFloat := qty;
            q.ParamByName('STOCK_SUPPLIERID').AsInteger := FStockSupplierID;
            q.ParamByName('ORDER_SUPPLIERID').AsInteger := orderSupplierID;
            q.ParamByName('PICKUP_SUPPLIERID').AsInteger := pickupSupplierID;
            if dePlanDate.Date > 0 then
                q.ParamByName('PLAN_DATE').AsDate := dePlanDate.Date
            else
                q.ParamByName('PLAN_DATE').Clear;
            if Trim(edNote.Text) <> '' then
                q.ParamByName('NOTE').AsString := Copy(Trim(edNote.Text), 1, 512)
            else
                q.ParamByName('NOTE').Clear;
            q.ParamByName('USERID').AsInteger := dmDB.CurrentUserID;
            q.Execute;

            if (not isNew) and (q.RowsAffected = 0) then
                raise Exception.Create('Ridicarea nu a putut fi salvata: intre timp a fost ridicata sau anulata.');

            tr.Commit;
        except
            if isNew then
                FPickupID := 0;
            if tr.Active then
                tr.Rollback;
            raise;
        end;
    finally
        q.Free;
        tr.Free;
    end;

    Result := True;
end;

end.
