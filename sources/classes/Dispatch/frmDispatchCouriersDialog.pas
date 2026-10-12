unit frmDispatchCouriersDialog;

(* ============================================================================
   Dispecerat: curierii (TS_COURIER) si setarile firmei (TS_DISPATCH_SETTINGS).

   Curierul e un colaborator din TS_CUSTOMER (tip 4006 "Angajati") cu profil
   logistic: activ, face ridicari / livrari, depozitul masinii (marfa din
   masina e urmarita in acest depozit), telefon si loginul aplicatiei web.

   "Cod de activare": genereaza in baza un cod de 8 cifre valabil 24 de ore
   (SP_COURIER_WEB_ACTIVATION). Soferul il introduce in aplicatie impreuna cu
   loginul si isi alege parola. Codul nou anuleaza parola veche.

   Setarile firmei curente: depozitul de baza (destinatia la sosirea soferului)
   si utilizatorul WMS sub care aplicatia creeaza documente (Intrare marfa).

   "Creeaza depozitul masinii": depozit nou in folderul depozitelor mobile
   (146, din TS_DISPATCH_SETTINGS), nevizibil la vanzare, legat de curier.
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
    cxGridCustomView, cxGrid, cxButtons, cxTextEdit, cxMaskEdit, cxCheckBox,
    cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
    cxDBData, dxScrollbarAnnotations, dxDateRanges, Vcl.Menus;

type
    TfrmDispatchCouriersDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        pnSettings: TPanel;
        lbBaseStock: TLabel;
        lcbBaseStock: TcxLookupComboBox;
        lbWebUser: TLabel;
        lcbWebUser: TcxLookupComboBox;
        cxGridCouriers: TcxGrid;
        cxGridCouriersTable: TcxGridDBTableView;
        cxGridCouriersLevel: TcxGridLevel;
        colCUSTOMERID: TcxGridDBColumn;
        colNAME: TcxGridDBColumn;
        colFLG_ACTIVE: TcxGridDBColumn;
        colFLG_CAN_PICKUP: TcxGridDBColumn;
        colFLG_CAN_DELIVER: TcxGridDBColumn;
        colSTOCKID: TcxGridDBColumn;
        colPHONE: TcxGridDBColumn;
        colWEB_LOGIN: TcxGridDBColumn;
        colHAS_WEB_PASSWORD: TcxGridDBColumn;
        colWEB_ACTIVATION_EXPIRES: TcxGridDBColumn;
        colWEB_LAST_LOGIN_AT: TcxGridDBColumn;
        colNOTE: TcxGridDBColumn;
        btnAdd: TcxButton;
        btnActivation: TcxButton;
        btnCreateStock: TcxButton;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        IBCQueryCouriers: TIBCQuery;
        IBCDataSourceCouriers: TIBCDataSource;
        IBCQueryStocks: TIBCQuery;
        IBCDataSourceStocks: TIBCDataSource;
        IBCQueryUsers: TIBCQuery;
        IBCDataSourceUsers: TIBCDataSource;
        IBCTransactionUpdate: TIBCTransaction;
        procedure btnAddClick(Sender: TObject);
        procedure btnActivationClick(Sender: TObject);
        procedure btnCreateStockClick(Sender: TObject);
        procedure IBCQueryCouriersNewRecord(DataSet: TDataSet);
        procedure IBCQueryCouriersBeforePost(DataSet: TDataSet);
    private
        procedure LoadSettings;
        function SaveAll: Boolean;
        procedure ReopenAfterCommit(const ACourierID: Integer);
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    end;

implementation

uses
    DataModuleDB, frmCustomersDlg, SWNCustomersTypesUnit, DispatchCommonUnit, System.UITypes;

{$R *.dfm}

{ TfrmDispatchCouriersDlg }

procedure TfrmDispatchCouriersDlg.Prepare;
begin
    dtDialogTitle.Text := 'Colaboratorii care fac ridicari si livrari, depozitul masinii si contul aplicatiei';

    if not IBCTransactionUpdate.Active then
        IBCTransactionUpdate.StartTransaction;

    IBCQueryStocks.Connection := dmDB.IBCConnection;
    IBCQueryStocks.Transaction := IBCTransactionUpdate;
    IBCQueryStocks.Open;
    IBCQueryUsers.Connection := dmDB.IBCConnection;
    IBCQueryUsers.Transaction := IBCTransactionUpdate;
    IBCQueryUsers.Open;

    IBCQueryCouriers.Connection := dmDB.IBCConnection;
    IBCQueryCouriers.Transaction := IBCTransactionUpdate;
    IBCQueryCouriers.UpdateTransaction := IBCTransactionUpdate;
    IBCQueryCouriers.Open;

    LoadSettings;
end;

procedure TfrmDispatchCouriersDlg.LoadSettings;
var
    q: TIBCQuery;
begin
    lbBaseStock.Caption := Format('Depozitul de baza (%s):', [dmDB.CurrentFirmaName]);
    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.Transaction := IBCTransactionUpdate;
        q.SQL.Text := 'SELECT BASE_STOCKID, WEB_USERID FROM TS_DISPATCH_SETTINGS WHERE FIRMAID = :FIRMAID';
        q.ParamByName('FIRMAID').AsInteger := dmDB.CurrentFirma;
        q.Open;
        if not q.IsEmpty then
        begin
            lcbBaseStock.EditValue := q.FieldByName('BASE_STOCKID').Value;
            lcbWebUser.EditValue := q.FieldByName('WEB_USERID').Value;
        end;
    finally
        q.Free;
    end;
end;

{ Salveaza profilurile si setarile firmei in tranzactia formei, apoi COMMIT. }
function TfrmDispatchCouriersDlg.SaveAll: Boolean;
var
    q: TIBCQuery;
    hasStock, hasUser: Boolean;
begin
    Result := False;
    if IBCQueryCouriers.State in dsEditModes then
        IBCQueryCouriers.Post;

    hasStock := not VarIsNull(lcbBaseStock.EditValue) and not VarIsEmpty(lcbBaseStock.EditValue);
    hasUser := not VarIsNull(lcbWebUser.EditValue) and not VarIsEmpty(lcbWebUser.EditValue);
    if hasStock <> hasUser then
    begin
        ShowMessage('Alegeti si depozitul de baza, si utilizatorul WMS pentru documentele aplicatiei.');
        Exit;
    end;

    if hasStock then
    begin
        q := TIBCQuery.Create(nil);
        try
            q.Connection := dmDB.IBCConnection;
            q.Transaction := IBCTransactionUpdate;
            q.SQL.Text :=
                'UPDATE OR INSERT INTO TS_DISPATCH_SETTINGS (FIRMAID, BASE_STOCKID, WEB_USERID) ' +
                'VALUES (:FIRMAID, :BASE_STOCKID, :WEB_USERID) MATCHING (FIRMAID)';
            q.ParamByName('FIRMAID').AsInteger := dmDB.CurrentFirma;
            q.ParamByName('BASE_STOCKID').AsInteger := lcbBaseStock.EditValue;
            q.ParamByName('WEB_USERID').AsInteger := lcbWebUser.EditValue;
            q.Execute;
        finally
            q.Free;
        end;
    end;

    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Commit;
    Result := True;
end;

procedure TfrmDispatchCouriersDlg.btnAddClick(Sender: TObject);
var
    dialog: TfrmCustomersDlg;
    id: Integer;
begin
    if IBCQueryCouriers.State in dsEditModes then
        IBCQueryCouriers.Post;

    id := 0;
    dialog := TfrmCustomersDlg.Create(Self);
    try
        dialog.CustomFilter := [cfColaboratori];
        if dialog.SelectCustomer(0, False, 0, 'Colaboratorul care devine curier') then
            id := dialog.CustomerID;
    finally
        dialog.Free;
    end;
    if id <= 0 then
        Exit;

    if IBCQueryCouriers.Locate('CUSTOMERID', id, []) then
    begin
        ShowMessage('Colaboratorul are deja profil de curier.');
        Exit;
    end;

    IBCQueryCouriers.Append;
    { numele vine din SQLRefresh dupa Post }
    IBCQueryCouriers.FieldByName('CUSTOMERID').AsInteger := id;
    IBCQueryCouriers.FieldByName('PHONE').AsString := VarToStr(DispatchExec(
        'SELECT FIRST 1 PHONENUMBER FROM TS_CUST_PHONES WHERE CUSTOMERID = :ID ' +
        'ORDER BY IIF(PHONETYPEID = 7468, 0, 1), PHONEID', ['ID'], [id]));
    IBCQueryCouriers.Post;
end;

procedure TfrmDispatchCouriersDlg.btnActivationClick(Sender: TObject);
var
    id: Integer;
    name, code: string;
begin
    if IBCQueryCouriers.IsEmpty then
        Exit;
    if IBCQueryCouriers.State in dsEditModes then
        IBCQueryCouriers.Post;
    if Trim(IBCQueryCouriers.FieldByName('WEB_LOGIN').AsString) = '' then
    begin
        ShowMessage('Scrieti intai loginul curierului (de exemplu numele de familie).');
        Exit;
    end;

    id := IBCQueryCouriers.FieldByName('CUSTOMERID').AsInteger;
    name := IBCQueryCouriers.FieldByName('NAME').AsString;
    if IBCQueryCouriers.FieldByName('HAS_WEB_PASSWORD').AsInteger = 1 then
        if MessageDlg(Format('%s are deja parola. Un cod nou o anuleaza si soferul trebuie sa-si aleaga alta. Continuati?',
            [name]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
            Exit;

    { codul se genereaza intr-o alta tranzactie: modificarile din forma se salveaza intai }
    if not SaveAll then
        Exit;
    try
        code := VarToStr(DispatchExec('SELECT O_CODE FROM SP_COURIER_WEB_ACTIVATION(:ID)', ['ID'], [id]));
    except
        on E: Exception do
        begin
            ShowMessage(DispatchErrorText(E.Message));
            code := '';
        end;
    end;

    ReopenAfterCommit(id);

    if code <> '' then
        MessageDlg(Format('Codul de activare pentru %s: %s' + sLineBreak + sLineBreak +
            'Login: %s. Codul e valabil 24 de ore si se arata o singura data. ' +
            'Soferul il introduce in aplicatie la "Am primit un cod de activare".',
            [name, code, IBCQueryCouriers.FieldByName('WEB_LOGIN').AsString]), mtInformation, [mbOK], 0);
end;

{ Dupa SaveAll (COMMIT): tranzactie noua, listele recitite, curierul focalizat. }
procedure TfrmDispatchCouriersDlg.ReopenAfterCommit(const ACourierID: Integer);
begin
    if not IBCTransactionUpdate.Active then
        IBCTransactionUpdate.StartTransaction;
    IBCQueryStocks.Close;
    IBCQueryStocks.Open;
    IBCQueryCouriers.Close;
    IBCQueryCouriers.Open;
    IBCQueryCouriers.Locate('CUSTOMERID', ACourierID, []);
end;

{ Depozitul masinii: in folderul "Depozite mobile" (TS_DISPATCH_SETTINGS.COURIER_STOCK_FOLDERID),
  creat si legat de curier de SP_COURIER_CREATE_STOCK. }
procedure TfrmDispatchCouriersDlg.btnCreateStockClick(Sender: TObject);
var
    id: Integer;
    title: string;
    stockID: Variant;
begin
    if IBCQueryCouriers.IsEmpty then
        Exit;
    if IBCQueryCouriers.State in dsEditModes then
        IBCQueryCouriers.Post;
    if not IBCQueryCouriers.FieldByName('STOCKID').IsNull then
    begin
        ShowMessage('Curierul are deja un depozit. Pentru alt depozit stergeti-l intai din coloana "Depozitul masinii".');
        Exit;
    end;

    id := IBCQueryCouriers.FieldByName('CUSTOMERID').AsInteger;
    title := Copy(IBCQueryCouriers.FieldByName('NAME').AsString, 1, 60);
    if not InputQuery('Depozitul masinii', 'Denumirea depozitului (de exemplu soferul si masina):', title) then
        Exit;

    { procedura citeste profilul salvat: modificarile din forma se salveaza intai }
    if not SaveAll then
        Exit;
    try
        stockID := DispatchExec('SELECT O_STOCKID FROM SP_COURIER_CREATE_STOCK(:ID, :FIRMAID, :TITLE)',
            ['ID', 'FIRMAID', 'TITLE'], [id, dmDB.CurrentFirma, Trim(title)]);
    except
        on E: Exception do
        begin
            ReopenAfterCommit(id);
            ShowMessage(DispatchErrorText(E.Message));
            Exit;
        end;
    end;

    ReopenAfterCommit(id);
    ShowMessage(Format('Depozitul "%s" (%s) a fost creat si legat de curier.', [Trim(title), VarToStr(stockID)]));
end;

procedure TfrmDispatchCouriersDlg.IBCQueryCouriersNewRecord(DataSet: TDataSet);
begin
    DataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
    DataSet.FieldByName('FLG_CAN_PICKUP').AsInteger := 1;
    DataSet.FieldByName('FLG_CAN_DELIVER').AsInteger := 1;
end;

procedure TfrmDispatchCouriersDlg.IBCQueryCouriersBeforePost(DataSet: TDataSet);
begin
    if DataSet.FieldByName('CUSTOMERID').AsInteger <= 0 then
        raise Exception.Create('Alegeti colaboratorul.');
    DataSet.FieldByName('WEB_LOGIN').AsString := Trim(DataSet.FieldByName('WEB_LOGIN').AsString);
end;

function TfrmDispatchCouriersDlg.IsFormDataPosted: Boolean;
begin
    Result := SaveAll;
end;

procedure TfrmDispatchCouriersDlg.WhenCancelForm;
begin
    if IBCQueryCouriers.State in dsEditModes then
        IBCQueryCouriers.Cancel;

    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Rollback;
end;

end.
