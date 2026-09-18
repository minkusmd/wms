unit frmDealPaymentsDialog;

(* ============================================================================
   Incasarile (casa 116 / banca 120) si distribuirea lor pe deal-uri
   (VW_DEAL_PAYMENTS).

   - "Potriveste automat": SP_DEAL_MATCH_PAYMENTS - leaga incasarile fara lant de
     documente de deal-ul platitorului, doar cand exista exact un deal deschis cu
     restul de plata egal cu suma.
   - "Adauga deal...": pentru platile agregate (decontari de carduri, companii de
     credit, curieri) - se alege un deal si suma atribuita lui (LINK_SUM); se
     repeta pana cand "Ramas" ajunge la zero.
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, ComCtrls, Data.DB, DBAccess, IBC, MemDS,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
    cxGridCustomView, cxGrid, cxButtons, cxDBData, dxScrollbarAnnotations, dxDateRanges;

type
    TfrmDealPaymentsDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        pnTop: TPanel;
        lbFrom: TLabel;
        dtFrom: TDateTimePicker;
        chkOnlyRemaining: TCheckBox;
        lbSearch: TLabel;
        edSearch: TEdit;
        btnRefresh: TcxButton;
        cxGridPay: TcxGrid;
        cxGridPayTable: TcxGridDBTableView;
        cxGridPayLevel: TcxGridLevel;
        btnAutoMatch: TcxButton;
        btnAddDeal: TcxButton;
        btnOpenDeal: TcxButton;
        btnClose: TcxButton;
        trRead: TIBCTransaction;
        qPay: TIBCQuery;
        dsPay: TIBCDataSource;
        procedure btnRefreshClick(Sender: TObject);
        procedure btnAutoMatchClick(Sender: TObject);
        procedure btnAddDealClick(Sender: TObject);
        procedure btnOpenDealClick(Sender: TObject);
        procedure edSearchKeyPress(Sender: TObject; var Key: Char);
    private
        procedure LoadData;
        procedure SetCaption(const AField, ACaption: string);
        function CountUnbound: Integer;
        function QueryFloat(const ASQL: string; const AID: Int64): Double;
    protected
        procedure Prepare; override;
    end;

implementation

uses
    System.UITypes, System.DateUtils, System.Math, DataModuleDB, SWNDealsUnit, frmDealsBrowserDialog;

{$R *.dfm}

procedure TfrmDealPaymentsDlg.Prepare;
begin
    trRead.DefaultConnection := dmDB.IBCConnection;
    qPay.Connection := dmDB.IBCConnection;

    dtDialogTitle.Text := 'Incasarile de casa si banca si cat din ele e atribuit deal-urilor. ' +
        'Platile agregate (carduri, credite, curieri) se distribuie pe mai multe deal-uri.';
    dtFrom.Date := StartOfTheYear(Date);
    chkOnlyRemaining.Checked := True;
    LoadData;
end;

procedure TfrmDealPaymentsDlg.SetCaption(const AField, ACaption: string);
var
    col: TcxGridDBColumn;
begin
    col := cxGridPayTable.GetColumnByFieldName(AField);
    if col = nil then
        Exit;
    if ACaption = '' then
        col.Visible := False
    else
        col.Caption := ACaption;
end;

procedure TfrmDealPaymentsDlg.LoadData;
var
    sql, txt: string;
    docID: Integer;
begin
    docID := 0;
    if qPay.Active and not qPay.IsEmpty then
        docID := qPay.FieldByName('DOCID').AsInteger;

    qPay.Close;
    if trRead.Active then
        trRead.Commit;
    trRead.StartTransaction;

    sql :=
        'SELECT p.DOCID, p.DATA, p.DOC_TYPE, p.CUSTOMER_NAME, p.SUMA, p.DEALS_COUNT, ' +
        '       p.DISTRIBUTED_SUM, p.REMAINING_SUM, p.FIRST_DEAL_ID, p.HAS_PARENT, p.CUSTOMERID ' +
        '  FROM VW_DEAL_PAYMENTS p ' +
        ' WHERE p.DATA >= :dfrom';
    if chkOnlyRemaining.Checked then
        sql := sql + ' AND p.REMAINING_SUM > 0.005';
    txt := Trim(edSearch.Text);
    if txt <> '' then
        sql := sql + ' AND COALESCE(p.CUSTOMER_NAME, '''') CONTAINING :txt';
    sql := sql + ' ORDER BY p.DATA DESC, p.DOCID DESC';

    qPay.SQL.Text := sql;
    qPay.ParamByName('dfrom').AsDateTime := Trunc(dtFrom.Date);
    if txt <> '' then
        qPay.ParamByName('txt').AsString := txt;
    qPay.Open;
    if docID > 0 then
        qPay.Locate('DOCID', docID, []);

    if cxGridPayTable.ColumnCount = 0 then
    begin
        cxGridPayTable.DataController.CreateAllItems;
        SetCaption('DOCID', 'Nr. document');
        SetCaption('DATA', 'Data');
        SetCaption('DOC_TYPE', 'Tip');
        SetCaption('CUSTOMER_NAME', 'Platitor');
        SetCaption('SUMA', 'Suma');
        SetCaption('DEALS_COUNT', 'Deal-uri');
        SetCaption('DISTRIBUTED_SUM', 'Atribuit');
        SetCaption('REMAINING_SUM', 'Ramas');
        SetCaption('FIRST_DEAL_ID', 'Primul deal');
        SetCaption('HAS_PARENT', 'Are parinte');
        SetCaption('CUSTOMERID', '');
        cxGridPayTable.ApplyBestFit;
    end;
end;

function TfrmDealPaymentsDlg.CountUnbound: Integer;
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.SQL.Text := 'SELECT COUNT(*) AS N FROM VW_DEAL_PAYMENTS p WHERE p.DATA >= :dfrom AND p.DEALS_COUNT = 0';
        q.ParamByName('dfrom').AsDateTime := Trunc(dtFrom.Date);
        q.Open;
        Result := q.FieldByName('N').AsInteger;
    finally
        q.Free;
    end;
end;

function TfrmDealPaymentsDlg.QueryFloat(const ASQL: string; const AID: Int64): Double;
var
    q: TIBCQuery;
begin
    Result := 0;
    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.SQL.Text := ASQL;
        q.ParamByName('id').AsLargeInt := AID;
        q.Open;
        if not q.IsEmpty and not q.Fields[0].IsNull then
            Result := q.Fields[0].AsFloat;
    finally
        q.Free;
    end;
end;

procedure TfrmDealPaymentsDlg.btnRefreshClick(Sender: TObject);
begin
    LoadData;
end;

procedure TfrmDealPaymentsDlg.edSearchKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
    begin
        Key := #0;
        LoadData;
    end;
end;

procedure TfrmDealPaymentsDlg.btnAutoMatchClick(Sender: TObject);
var
    before, after: Integer;
begin
    if MessageDlg('Se leaga automat incasarile fara deal ale caror platitori au exact un deal ' +
        'deschis cu restul de plata egal cu suma incasarii.' + #13#10#13#10 + 'Continuati?',
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

    before := CountUnbound;
    Screen.Cursor := crHourGlass;
    try
        if not ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_MATCH_PAYMENTS(:dfrom, :userid)',
            ['dfrom', VarFromDateTime(Trunc(dtFrom.Date)), 'userid', dmDB.CurrentUserID]) then
            Exit;
    finally
        Screen.Cursor := crDefault;
    end;
    after := CountUnbound;
    LoadData;
    MessageDlg(Format('Incasari legate automat: %d.' + #13#10 + 'Au ramas fara deal: %d.',
        [before - after, after]), mtInformation, [mbOK], 0);
end;

procedure TfrmDealPaymentsDlg.btnAddDealClick(Sender: TObject);
var
    browser: TfrmDealsBrowserDlg;
    docID, customerID: Integer;
    dealID: Int64;
    remaining, balance, linkSum: Double;
    s: string;
begin
    if not qPay.Active or qPay.IsEmpty then
        Exit;
    docID := qPay.FieldByName('DOCID').AsInteger;
    customerID := qPay.FieldByName('CUSTOMERID').AsInteger;
    remaining := qPay.FieldByName('REMAINING_SUM').AsFloat;
    if remaining <= 0.005 then
    begin
        MessageDlg('Incasarea este deja atribuita integral.', mtInformation, [mbOK], 0);
        Exit;
    end;

    { platitorul are deal-uri proprii? atunci lista porneste filtrata pe el }
    if QueryFloat('SELECT COUNT(*) FROM TDB_DEALS WHERE CONTACTID = :id AND CLOSED_AT IS NULL', customerID) = 0 then
        customerID := 0;

    browser := TfrmDealsBrowserDlg.Create(Self);
    try
        browser.SelectMode := True;
        browser.ContactID := customerID;
        browser.OnlyWithBalance := True;
        if browser.ShowModal <> mrOk then
            Exit;
        dealID := browser.SelectedDealID;
    finally
        browser.Free;
    end;
    if dealID = 0 then
        Exit;

    balance := QueryFloat('SELECT O_BALANCE FROM SP_DEAL_GET_BALANCE(:id)', dealID);
    if (balance > 0.005) and (balance < remaining) then
        linkSum := balance
    else
        linkSum := remaining;

    s := FormatFloat('0.00', linkSum);
    if not InputQuery('Atribuire pe deal',
        Format('Suma din incasarea %d atribuita deal-ului %d' + #13#10 +
            '(ramas din incasare: %s, rest de plata al deal-ului: %s):',
            [docID, dealID, FormatFloat('0.00', remaining), FormatFloat('0.00', balance)]), s) then
        Exit;
    s := StringReplace(Trim(s), ',', FormatSettings.DecimalSeparator, [rfReplaceAll]);
    s := StringReplace(s, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
    if not TryStrToFloat(s, linkSum) or (linkSum <= 0) or (linkSum > remaining + 0.005) then
    begin
        MessageDlg('Suma trebuie sa fie mai mare ca zero si cel mult cat a ramas din incasare.',
            mtError, [mbOK], 0);
        Exit;
    end;

    if ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_BIND_DOC_MANUAL(:dealid, :docid, :userid, :linksum)',
        ['dealid', dealID, 'docid', docID, 'userid', dmDB.CurrentUserID, 'linksum', linkSum]) then
        LoadData;
end;

procedure TfrmDealPaymentsDlg.btnOpenDealClick(Sender: TObject);
begin
    if not qPay.Active or qPay.IsEmpty or qPay.FieldByName('FIRST_DEAL_ID').IsNull then
    begin
        MessageDlg('Incasarea selectata nu este legata de niciun deal.', mtInformation, [mbOK], 0);
        Exit;
    end;
    ShowDealCard(Self, qPay.FieldByName('FIRST_DEAL_ID').AsLargeInt);
    LoadData;
end;

end.
