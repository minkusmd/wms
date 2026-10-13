unit frmDispatchDialog;

(* ============================================================================
   Dispecerat achizitii + livrari - forma dispecerului (plan sect. 6, etapa 4).

   Ziua de lucru + firma curenta -> planul zilei (TDB_DISPATCH_PLAN). Paginile:
     Achizitii  - ridicarile de la furnizori (VW_DISPATCH_PICKUPS): ale zilei si
                  restantele neatribuite, care nu dispar la schimbarea datei;
     Retururi   - retururile catre furnizori (126) nefinalizate;
     Livrari    - vanzarile cu livrare (VW_DISPATCH_DELIVERIES) ale zilei si
                  cele neplanificate din ultimele 14 zile;
     Trasee     - curierii zilei si opririle lor in ordine (Sus / Jos);
     Probleme   - SP_DISPATCH_PLAN_PROBLEMS: erorile blocheaza publicarea.

   Curierul si zona se aleg o data in bara de sus; butoanele lucreaza pe
   randurile selectate. Fiecare rand e o actiune separata (procedurile
   SP_DISPATCH_*, tranzactie proprie): un rand refuzat nu le opreste pe celelalte.
   Planul se creeaza la prima atribuire; telefonul soferului vede traseul
   numai dupa "Publica planul". Dupa publicare orice schimbare ajunge imediat
   la sofer (versiunea planului creste).
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
    cxGridCustomView, cxGrid, cxButtons, cxTextEdit, cxMaskEdit, cxCheckBox,
    cxDropDownEdit, cxCalendar, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
    cxImageComboBox, cxPC, dxBarBuiltInMenu, cxDBData, dxScrollbarAnnotations,
    dxDateRanges, Vcl.Menus;

type
    TfrmDispatchDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        pnTop: TPanel;
        lbDay: TLabel;
        deDate: TcxDateEdit;
        btnPrevDay: TcxButton;
        btnNextDay: TcxButton;
        lbPlanState: TLabel;
        btnPublish: TcxButton;
        btnRefresh: TcxButton;
        btnCouriers: TcxButton;
        btnZones: TcxButton;
        pnAssign: TPanel;
        lbCourier: TLabel;
        lcbCourier: TcxLookupComboBox;
        lbZone: TLabel;
        lcbZone: TcxLookupComboBox;
        lbAssignHint: TLabel;
        pcMain: TcxPageControl;
        tsPickups: TcxTabSheet;
        tsReturns: TcxTabSheet;
        tsDeliveries: TcxTabSheet;
        tsRoutes: TcxTabSheet;
        tsProblems: TcxTabSheet;
        { Achizitii }
        cxGridPickups: TcxGrid;
        gvPickups: TcxGridDBTableView;
        glPickups: TcxGridLevel;
        gvPickupsPICKUPID: TcxGridDBColumn;
        gvPickupsCOURIER_NAME: TcxGridDBColumn;
        gvPickupsSTOP_ORDERNO: TcxGridDBColumn;
        gvPickupsPICKUP_SUPPLIER_NAME: TcxGridDBColumn;
        gvPickupsZONE_NAME: TcxGridDBColumn;
        gvPickupsGOODS_TITLE: TcxGridDBColumn;
        gvPickupsGOODS_CODE: TcxGridDBColumn;
        gvPickupsQTY: TcxGridDBColumn;
        gvPickupsORDER_SUPPLIER_NAME: TcxGridDBColumn;
        gvPickupsDOCID: TcxGridDBColumn;
        gvPickupsCLIENT_NAME: TcxGridDBColumn;
        gvPickupsPLAN_DATE: TcxGridDBColumn;
        gvPickupsSTATE_NAME: TcxGridDBColumn;
        gvPickupsPICKUP_DOC_STATE: TcxGridDBColumn;
        gvPickupsNOTE: TcxGridDBColumn;
        pnPickupsActions: TPanel;
        btnPickupAssign: TcxButton;
        btnPickupUnassign: TcxButton;
        { Retururi }
        cxGridReturns: TcxGrid;
        gvReturns: TcxGridDBTableView;
        glReturns: TcxGridLevel;
        gvReturnsDOCID: TcxGridDBColumn;
        gvReturnsCOURIER_NAME: TcxGridDBColumn;
        gvReturnsDISPATCH_DATE: TcxGridDBColumn;
        gvReturnsDOC_DATA: TcxGridDBColumn;
        gvReturnsSUPPLIER_NAME: TcxGridDBColumn;
        gvReturnsSUMA: TcxGridDBColumn;
        pnReturnsActions: TPanel;
        btnReturnAssign: TcxButton;
        btnReturnUnassign: TcxButton;
        { Livrari }
        cxGridDeliveries: TcxGrid;
        gvDeliveries: TcxGridDBTableView;
        glDeliveries: TcxGridLevel;
        gvDeliveriesDOCID: TcxGridDBColumn;
        gvDeliveriesCOURIER_NAME: TcxGridDBColumn;
        gvDeliveriesSTOP_ORDERNO: TcxGridDBColumn;
        gvDeliveriesZONE_NAME: TcxGridDBColumn;
        gvDeliveriesCLIENT_NAME: TcxGridDBColumn;
        gvDeliveriesDELIVERY_ADDRESS: TcxGridDBColumn;
        gvDeliveriesPHONE_NUMBER: TcxGridDBColumn;
        gvDeliveriesDELIVERY_DATE: TcxGridDBColumn;
        gvDeliveriesDELIVERY_TIME: TcxGridDBColumn;
        gvDeliveriesDISPATCH_STATE_NAME: TcxGridDBColumn;
        gvDeliveriesSUMA: TcxGridDBColumn;
        pnDeliveriesActions: TPanel;
        btnDeliveryAssign: TcxButton;
        btnDeliveryZoneOnly: TcxButton;
        btnDeliveryUnassign: TcxButton;
        { Trasee }
        cxGridRoutes: TcxGrid;
        gvRoutes: TcxGridDBTableView;
        glRoutes: TcxGridLevel;
        gvRoutesCOURIER_NAME: TcxGridDBColumn;
        gvRoutesN_STOPS: TcxGridDBColumn;
        gvRoutesN_DONE: TcxGridDBColumn;
        gvRoutesN_PROBLEMS: TcxGridDBColumn;
        gvRoutesSTATE_NAME: TcxGridDBColumn;
        gvRoutesHAS_WEB_ACCOUNT: TcxGridDBColumn;
        splRoutes: TSplitter;
        cxGridStops: TcxGrid;
        gvStops: TcxGridDBTableView;
        glStops: TcxGridLevel;
        gvStopsSTOPID: TcxGridDBColumn;
        gvStopsORDERNO: TcxGridDBColumn;
        gvStopsKIND_NAME: TcxGridDBColumn;
        gvStopsTITLE: TcxGridDBColumn;
        gvStopsADDRESS: TcxGridDBColumn;
        gvStopsZONE_NAME: TcxGridDBColumn;
        gvStopsPLAN_TIME: TcxGridDBColumn;
        gvStopsN_PICKUP: TcxGridDBColumn;
        gvStopsN_RETURN: TcxGridDBColumn;
        gvStopsN_DELIVERY: TcxGridDBColumn;
        gvStopsN_LOAD: TcxGridDBColumn;
        gvStopsSTATE_NAME: TcxGridDBColumn;
        gvStopsARRIVED_AT: TcxGridDBColumn;
        gvStopsDONE_AT: TcxGridDBColumn;
        pnRoutesActions: TPanel;
        btnStopUp: TcxButton;
        btnStopDown: TcxButton;
        { Probleme }
        cxGridProblems: TcxGrid;
        gvProblems: TcxGridDBTableView;
        glProblems: TcxGridLevel;
        gvProblemsNIVEL: TcxGridDBColumn;
        gvProblemsO_COURIER_NAME: TcxGridDBColumn;
        gvProblemsO_PROBLEM: TcxGridDBColumn;
        gvProblemsO_DOCID: TcxGridDBColumn;
        pnBottom: TPanel;
        btnClose: TcxButton;
        { date }
        qPickups: TIBCQuery;
        dsPickups: TIBCDataSource;
        qReturns: TIBCQuery;
        dsReturns: TIBCDataSource;
        qDeliveries: TIBCQuery;
        dsDeliveries: TIBCDataSource;
        qRoutes: TIBCQuery;
        dsRoutes: TIBCDataSource;
        qStops: TIBCQuery;
        dsStops: TIBCDataSource;
        qProblems: TIBCQuery;
        dsProblems: TIBCDataSource;
        qCouriers: TIBCQuery;
        dsCouriers: TIBCDataSource;
        qZones: TIBCQuery;
        dsZones: TIBCDataSource;
        procedure deDatePropertiesChange(Sender: TObject);
        procedure btnPrevDayClick(Sender: TObject);
        procedure btnNextDayClick(Sender: TObject);
        procedure btnRefreshClick(Sender: TObject);
        procedure btnPublishClick(Sender: TObject);
        procedure btnCouriersClick(Sender: TObject);
        procedure btnZonesClick(Sender: TObject);
        procedure btnPickupAssignClick(Sender: TObject);
        procedure btnPickupUnassignClick(Sender: TObject);
        procedure btnReturnAssignClick(Sender: TObject);
        procedure btnReturnUnassignClick(Sender: TObject);
        procedure btnDeliveryAssignClick(Sender: TObject);
        procedure btnDeliveryZoneOnlyClick(Sender: TObject);
        procedure btnDeliveryUnassignClick(Sender: TObject);
        procedure btnStopUpClick(Sender: TObject);
        procedure btnStopDownClick(Sender: TObject);
    private
        FPlanID: Integer;
        FPlanState: Integer;
        FLoading: Boolean;
        function WorkDate: TDate;
        function SelectedCourier(out ACourierID: Integer): Boolean;
        function SelectedZone: Variant;
        function SelectedIDs(AView: TcxGridDBTableView; AColumn: TcxGridDBColumn): TArray<Integer>;
        procedure RunForSelected(AView: TcxGridDBTableView; AColumn: TcxGridDBColumn;
            const ASql: string; const AExtraNames: array of string; const AExtraValues: array of Variant);
        procedure ReopenQuery(AQuery: TIBCQuery; const AKeyField: string);
        procedure LoadPlan;
        procedure RefreshAll;
        procedure ReloadLookups;
        procedure MoveStop(const ADelta: Integer);
    protected
        procedure Prepare; override;
    end;

implementation

uses
    DataModuleDB, DispatchCommonUnit, frmDispatchCouriersDialog, frmDispatchZonesDialog,
    System.UITypes, System.DateUtils;

{$R *.dfm}

{ TfrmDispatchDlg }

procedure TfrmDispatchDlg.Prepare;
var
    queries: TArray<TIBCQuery>;
    q: TIBCQuery;
begin
    dtDialogTitle.Text := Format('Ridicari de la furnizori si livrari catre clienti - %s', [dmDB.CurrentFirmaName]);

    queries := [qPickups, qReturns, qDeliveries, qRoutes, qStops, qProblems, qCouriers, qZones];
    for q in queries do
        q.Connection := dmDB.IBCConnection;

    FLoading := True;
    try
        deDate.Date := Date;
    finally
        FLoading := False;
    end;
    pcMain.ActivePage := tsPickups;

    ReloadLookups;
    RefreshAll;
end;

function TfrmDispatchDlg.WorkDate: TDate;
begin
    Result := DateOf(deDate.Date);
end;

procedure TfrmDispatchDlg.ReloadLookups;
var
    courier, zone: Variant;
begin
    courier := lcbCourier.EditValue;
    zone := lcbZone.EditValue;
    qCouriers.Close;
    qCouriers.Open;
    qZones.Close;
    qZones.Open;
    lcbCourier.EditValue := courier;
    lcbZone.EditValue := zone;
end;

procedure TfrmDispatchDlg.LoadPlan;
var
    q: TIBCQuery;
begin
    FPlanID := -1;
    FPlanState := -1;
    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.SQL.Text :=
            'SELECT PLANID, STATEID, VERSIONNO, PUBLISHED_AT FROM TDB_DISPATCH_PLAN ' +
            'WHERE FIRMAID = :FIRMAID AND PLAN_DATE = :DATA';
        q.ParamByName('FIRMAID').AsInteger := dmDB.CurrentFirma;
        q.ParamByName('DATA').AsDate := WorkDate;
        q.Open;
        if q.IsEmpty then
            lbPlanState.Caption := 'Planul zilei nu exista inca (se creeaza la prima atribuire)'
        else
        begin
            FPlanID := q.FieldByName('PLANID').AsInteger;
            FPlanState := q.FieldByName('STATEID').AsInteger;
            case FPlanState of
                0: lbPlanState.Caption := 'Plan: CIORNA - soferii nu il vad pana la publicare';
                1: lbPlanState.Caption := Format('Plan: PUBLICAT (versiunea %d, %s)',
                    [q.FieldByName('VERSIONNO').AsInteger,
                     FormatDateTime('dd.mm hh:nn', q.FieldByName('PUBLISHED_AT').AsDateTime)]);
                2: lbPlanState.Caption := Format('Plan: IN EXECUTARE (versiunea %d)', [q.FieldByName('VERSIONNO').AsInteger]);
            else
                lbPlanState.Caption := 'Plan: INCHIS';
            end;
        end;
    finally
        q.Free;
    end;

    btnPublish.Enabled := (FPlanID > 0) and (FPlanState in [0, 1, 2]);
    if FPlanState = 0 then
        btnPublish.Caption := 'Publica planul'
    else
        btnPublish.Caption := 'Republica planul';
end;

procedure TfrmDispatchDlg.ReopenQuery(AQuery: TIBCQuery; const AKeyField: string);
var
    key: Variant;
begin
    key := Null;
    if AQuery.Active and not AQuery.IsEmpty and (AKeyField <> '') then
        key := AQuery.FieldByName(AKeyField).Value;
    AQuery.Close;
    if AQuery.Params.FindParam('FIRMAID') <> nil then
        AQuery.ParamByName('FIRMAID').AsInteger := dmDB.CurrentFirma;
    if AQuery.Params.FindParam('DATA') <> nil then
        AQuery.ParamByName('DATA').AsDate := WorkDate;
    if AQuery.Params.FindParam('PLANID') <> nil then
        AQuery.ParamByName('PLANID').AsInteger := FPlanID;
    AQuery.Open;
    if not VarIsNull(key) then
        AQuery.Locate(AKeyField, key, []);
end;

procedure TfrmDispatchDlg.RefreshAll;
begin
    Screen.Cursor := crHourGlass;
    try
        LoadPlan;
        ReopenQuery(qPickups, 'PICKUPID');
        ReopenQuery(qReturns, 'DOCID');
        ReopenQuery(qDeliveries, 'DOCID');
        ReopenQuery(qRoutes, 'ROUTEID');
        if qStops.Active then
            qStops.Refresh
        else
            qStops.Open;
        ReopenQuery(qProblems, '');

        tsPickups.Caption := Format('Achizitii (%d)', [qPickups.RecordCount]);
        tsReturns.Caption := Format('Retururi (%d)', [qReturns.RecordCount]);
        tsDeliveries.Caption := Format('Livrari (%d)', [qDeliveries.RecordCount]);
        tsRoutes.Caption := Format('Trasee (%d)', [qRoutes.RecordCount]);
        tsProblems.Caption := Format('Probleme (%d)', [qProblems.RecordCount]);
    finally
        Screen.Cursor := crDefault;
    end;
end;

function TfrmDispatchDlg.SelectedCourier(out ACourierID: Integer): Boolean;
begin
    ACourierID := 0;
    Result := not VarIsNull(lcbCourier.EditValue) and not VarIsEmpty(lcbCourier.EditValue);
    if Result then
        ACourierID := lcbCourier.EditValue
    else
    begin
        ShowMessage('Alegeti curierul in bara de sus ("Curierul").');
        lcbCourier.SetFocus;
    end;
end;

function TfrmDispatchDlg.SelectedZone: Variant;
begin
    Result := lcbZone.EditValue;
    if VarIsEmpty(Result) then
        Result := Null;
end;

function TfrmDispatchDlg.SelectedIDs(AView: TcxGridDBTableView; AColumn: TcxGridDBColumn): TArray<Integer>;
var
    i, n: Integer;
    rec: TcxCustomGridRecord;
    v: Variant;
begin
    SetLength(Result, AView.Controller.SelectedRecordCount);
    n := 0;
    for i := 0 to AView.Controller.SelectedRecordCount - 1 do
    begin
        rec := AView.Controller.SelectedRecords[i];
        if not rec.IsData then
            Continue;
        v := rec.Values[AColumn.Index];
        if VarIsNull(v) or VarIsEmpty(v) then
            Continue;
        Result[n] := v;
        Inc(n);
    end;
    SetLength(Result, n);
end;

{ ASql primeste :ID (identificatorul randului) + parametrii din AExtraNames.
  Fiecare rand intr-o tranzactie proprie; la final un rezumat al refuzurilor. }
procedure TfrmDispatchDlg.RunForSelected(AView: TcxGridDBTableView; AColumn: TcxGridDBColumn;
    const ASql: string; const AExtraNames: array of string; const AExtraValues: array of Variant);
var
    ids: TArray<Integer>;
    id, ok, i: Integer;
    names: TArray<string>;
    values: TArray<Variant>;
    err: string;
    errors: TStringList;
begin
    ids := SelectedIDs(AView, AColumn);
    if Length(ids) = 0 then
    begin
        ShowMessage('Selectati cel putin un rand.');
        Exit;
    end;

    SetLength(names, Length(AExtraNames) + 1);
    SetLength(values, Length(AExtraNames) + 1);
    names[0] := 'ID';
    for i := 0 to High(AExtraNames) do
    begin
        names[i + 1] := AExtraNames[i];
        values[i + 1] := AExtraValues[i];
    end;

    ok := 0;
    errors := TStringList.Create;
    Screen.Cursor := crHourGlass;
    try
        for id in ids do
        begin
            values[0] := id;
            if DispatchTry(ASql, names, values, err) then
                Inc(ok)
            else if errors.Count < 8 then
                errors.Add(Format('%d: %s', [id, err]));
        end;
    finally
        Screen.Cursor := crDefault;
    end;

    try
        RefreshAll;
        if ok < Length(ids) then
            MessageDlg(Format('Reusite: %d din %d.', [ok, Length(ids)]) + sLineBreak + sLineBreak + errors.Text,
                mtWarning, [mbOK], 0);
    finally
        errors.Free;
    end;
end;

procedure TfrmDispatchDlg.deDatePropertiesChange(Sender: TObject);
begin
    if not FLoading and (qPickups.Connection <> nil) then
        RefreshAll;
end;

procedure TfrmDispatchDlg.btnPrevDayClick(Sender: TObject);
begin
    deDate.Date := IncDay(WorkDate, -1);
end;

procedure TfrmDispatchDlg.btnNextDayClick(Sender: TObject);
begin
    deDate.Date := IncDay(WorkDate, 1);
end;

procedure TfrmDispatchDlg.btnRefreshClick(Sender: TObject);
begin
    ReloadLookups;
    RefreshAll;
end;

procedure TfrmDispatchDlg.btnPublishClick(Sender: TObject);
var
    version: Variant;
begin
    if FPlanID <= 0 then
        Exit;
    if MessageDlg(Format('Publicati planul din %s? Soferii vor vedea traseele pe telefon.',
        [FormatDateTime('dd.mm.yyyy', WorkDate)]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

    try
        version := DispatchExec('SELECT O_VERSIONNO FROM SP_DISPATCH_PUBLISH(:PLANID)', ['PLANID'], [FPlanID]);
    except
        on E: Exception do
        begin
            RefreshAll;
            pcMain.ActivePage := tsProblems;
            ShowMessage(DispatchErrorText(E.Message));
            Exit;
        end;
    end;
    RefreshAll;
    ShowMessage(Format('Planul a fost publicat (versiunea %s).', [VarToStr(version)]));
end;

procedure TfrmDispatchDlg.btnCouriersClick(Sender: TObject);
var
    dialog: TfrmDispatchCouriersDlg;
begin
    dialog := TfrmDispatchCouriersDlg.Create(Self);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
    ReloadLookups;
    RefreshAll;
end;

procedure TfrmDispatchDlg.btnZonesClick(Sender: TObject);
var
    dialog: TfrmDispatchZonesDlg;
begin
    dialog := TfrmDispatchZonesDlg.Create(Self);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
    ReloadLookups;
    RefreshAll;
end;

procedure TfrmDispatchDlg.btnPickupAssignClick(Sender: TObject);
var
    courier: Integer;
begin
    if not SelectedCourier(courier) then
        Exit;
    RunForSelected(gvPickups, gvPickupsPICKUPID,
        'SELECT O_STOPID FROM SP_DISPATCH_PICKUP_ASSIGN(:ID, :COURIER, :DATA)',
        ['COURIER', 'DATA'], [courier, VarFromDateTime(WorkDate)]);
end;

procedure TfrmDispatchDlg.btnPickupUnassignClick(Sender: TObject);
begin
    RunForSelected(gvPickups, gvPickupsPICKUPID,
        'EXECUTE PROCEDURE SP_DISPATCH_PICKUP_UNASSIGN(:ID)', [], []);
end;

procedure TfrmDispatchDlg.btnReturnAssignClick(Sender: TObject);
var
    courier: Integer;
begin
    if not SelectedCourier(courier) then
        Exit;
    RunForSelected(gvReturns, gvReturnsDOCID,
        'SELECT O_STOPID FROM SP_DISPATCH_RETURN_ASSIGN(:ID, :COURIER, :DATA)',
        ['COURIER', 'DATA'], [courier, VarFromDateTime(WorkDate)]);
end;

procedure TfrmDispatchDlg.btnReturnUnassignClick(Sender: TObject);
begin
    RunForSelected(gvReturns, gvReturnsDOCID,
        'EXECUTE PROCEDURE SP_DISPATCH_RETURN_UNASSIGN(:ID)', [], []);
end;

procedure TfrmDispatchDlg.btnDeliveryAssignClick(Sender: TObject);
var
    courier: Integer;
begin
    if not SelectedCourier(courier) then
        Exit;
    RunForSelected(gvDeliveries, gvDeliveriesDOCID,
        'SELECT O_DELIVERYID FROM SP_DISPATCH_DELIVERY_ASSIGN(:ID, :COURIER, :DATA, :ZONE)',
        ['COURIER', 'DATA', 'ZONE'], [courier, VarFromDateTime(WorkDate), SelectedZone]);
end;

procedure TfrmDispatchDlg.btnDeliveryZoneOnlyClick(Sender: TObject);
begin
    if VarIsNull(SelectedZone) then
    begin
        ShowMessage('Alegeti zona in bara de sus ("Zona").');
        lcbZone.SetFocus;
        Exit;
    end;
    RunForSelected(gvDeliveries, gvDeliveriesDOCID,
        'SELECT O_DELIVERYID FROM SP_DISPATCH_DELIVERY_ASSIGN(:ID, :COURIER, :DATA, :ZONE)',
        ['COURIER', 'DATA', 'ZONE'], [Null, VarFromDateTime(WorkDate), SelectedZone]);
end;

procedure TfrmDispatchDlg.btnDeliveryUnassignClick(Sender: TObject);
begin
    RunForSelected(gvDeliveries, gvDeliveriesDOCID,
        'EXECUTE PROCEDURE SP_DISPATCH_DELIVERY_UNASSIGN(:ID)', [], []);
end;

procedure TfrmDispatchDlg.MoveStop(const ADelta: Integer);
var
    stopID: Integer;
    err: string;
begin
    if not qStops.Active or qStops.IsEmpty then
        Exit;
    stopID := qStops.FieldByName('STOPID').AsInteger;
    if not DispatchTry('EXECUTE PROCEDURE SP_DISPATCH_STOP_MOVE(:ID, :DELTA)', ['ID', 'DELTA'],
        [stopID, ADelta], err) then
    begin
        ShowMessage(err);
        Exit;
    end;
    qStops.Close;
    qStops.Open;
    qStops.Locate('STOPID', stopID, []);
end;

procedure TfrmDispatchDlg.btnStopUpClick(Sender: TObject);
begin
    MoveStop(-1);
end;

procedure TfrmDispatchDlg.btnStopDownClick(Sender: TObject);
begin
    MoveStop(1);
end;

end.
