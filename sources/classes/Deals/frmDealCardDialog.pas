unit frmDealCardDialog;

(* ============================================================================
   Fisa unui deal (TDB_DEALS): contact, cele 4 axe de stare (PIPE / PAY / FIN /
   DLV), documentele legate, sumele din V_DEAL_ANALYTICS, istoricul starilor.

   Starile se calculeaza automat in baza (SP_DEAL_RECALC_STATES). De aici se pot
   pune manual (SP_DEAL_SET_STATE); bifa "Blocheaza" opreste recalcularea
   automata a axelor schimbate, "Deblocheaza" o reporneste.
   Fiecare actiune se salveaza imediat (tranzactie proprie), apoi fisa se
   reincarca.
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
    cxGridCustomView, cxGrid, cxButtons, cxDBData, dxScrollbarAnnotations, dxDateRanges;

type
    TfrmDealCardDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        pnHeader: TPanel;
        lbInfo: TLabel;
        lbTotals: TLabel;
        lbPipe: TLabel;
        lbPay: TLabel;
        lbFin: TLabel;
        lbDlv: TLabel;
        cbPipe: TComboBox;
        cbPay: TComboBox;
        cbFin: TComboBox;
        cbDlv: TComboBox;
        chkLock: TCheckBox;
        btnApplyStates: TcxButton;
        btnUnlock: TcxButton;
        lbDocs: TLabel;
        cxGridDocs: TcxGrid;
        cxGridDocsTable: TcxGridDBTableView;
        cxGridDocsLevel: TcxGridLevel;
        lbHistory: TLabel;
        cxGridHistory: TcxGrid;
        cxGridHistoryTable: TcxGridDBTableView;
        cxGridHistoryLevel: TcxGridLevel;
        lbNote: TLabel;
        memNote: TMemo;
        btnSaveNote: TcxButton;
        btnBindDoc: TcxButton;
        btnUnbindDoc: TcxButton;
        btnMerge: TcxButton;
        btnRecalc: TcxButton;
        btnClose: TcxButton;
        trRead: TIBCTransaction;
        qDeal: TIBCQuery;
        qDocs: TIBCQuery;
        dsDocs: TIBCDataSource;
        qHistory: TIBCQuery;
        dsHistory: TIBCDataSource;
        procedure btnApplyStatesClick(Sender: TObject);
        procedure btnUnlockClick(Sender: TObject);
        procedure btnSaveNoteClick(Sender: TObject);
        procedure btnBindDocClick(Sender: TObject);
        procedure btnUnbindDocClick(Sender: TObject);
        procedure btnMergeClick(Sender: TObject);
        procedure btnRecalcClick(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
    private
        FDealID: Int64;
        FCodes: array[0..3] of TStringList;     { codurile starilor, paralel cu Items }
        FCurrent: array[0..3] of string;        { codul curent pe fiecare axa }
        function Combo(const AIndex: Integer): TComboBox;
        procedure LoadDealStates;
        procedure LoadData;
        function SalesProfit: string;
        procedure SetGridCaptions(AView: TcxGridDBTableView; const APairs: array of string);
    protected
        procedure Prepare; override;
    public
        property DealID: Int64 read FDealID write FDealID;
    end;

implementation

uses
    System.UITypes, DataModuleDB, SWNDealsUnit;

{$R *.dfm}

const
    cGroups: array[0..3] of string = ('PIPE', 'PAY', 'FIN', 'DLV');

function TfrmDealCardDlg.Combo(const AIndex: Integer): TComboBox;
begin
    case AIndex of
        0: Result := cbPipe;
        1: Result := cbPay;
        2: Result := cbFin;
    else
        Result := cbDlv;
    end;
end;

procedure TfrmDealCardDlg.Prepare;
var
    i: Integer;
begin
    for i := 0 to 3 do
        if FCodes[i] = nil then
            FCodes[i] := TStringList.Create;

    trRead.DefaultConnection := dmDB.IBCConnection;
    qDeal.Connection := dmDB.IBCConnection;
    qDocs.Connection := dmDB.IBCConnection;
    qHistory.Connection := dmDB.IBCConnection;

    LoadDealStates;
    LoadData;
end;

procedure TfrmDealCardDlg.FormDestroy(Sender: TObject);
var
    i: Integer;
begin
    for i := 0 to 3 do
        FreeAndNil(FCodes[i]);
end;

procedure TfrmDealCardDlg.LoadDealStates;
var
    q: TIBCQuery;
    i: Integer;
begin
    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        for i := 0 to 3 do
        begin
            FCodes[i].Clear;
            Combo(i).Items.Clear;
            q.Close;
            q.SQL.Text :=
                'SELECT CODE, TITLE_RO FROM TS_DEAL_STATES ' +
                ' WHERE TRIM(GROUP_CODE) = :grp AND IS_ACTIVE = 1 ORDER BY SORT_ORDER';
            q.ParamByName('grp').AsString := cGroups[i];
            q.Open;
            while not q.Eof do
            begin
                FCodes[i].Add(Trim(q.FieldByName('CODE').AsString));
                Combo(i).Items.Add(q.FieldByName('TITLE_RO').AsString);
                q.Next;
            end;
        end;
    finally
        q.Free;
    end;
end;

procedure TfrmDealCardDlg.SetGridCaptions(AView: TcxGridDBTableView; const APairs: array of string);
var
    i: Integer;
    col: TcxGridDBColumn;
begin
    i := Low(APairs);
    while i < High(APairs) do
    begin
        col := AView.GetColumnByFieldName(APairs[i]);
        if col <> nil then
        begin
            if APairs[i + 1] = '' then
                col.Visible := False
            else
                col.Caption := APairs[i + 1];
        end;
        Inc(i, 2);
    end;
end;

{ Profitul vanzarilor deal-ului, fara TVA, cu procedura folosita si de dialogul de
  profitabilitate al vanzarii (TDB_JURNAL.COST din 107 nu e cost de achizitie). }
function TfrmDealCardDlg.SalesProfit: string;
var
    q: TIBCQuery;
begin
    Result := '-';
    q := TIBCQuery.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.Transaction := trRead;
        q.SQL.Text :=
            'SELECT SUM((SELECT SUM(z.SUMAMDL_OUT - z.SUMAMDL_IN) ' +
            '              FROM SP_GET_PROFIT_BY_DOCID_WO_VAT(d.DOCID, 1) z)) AS PROFIT ' +
            '  FROM TDB_DEAL_DOCS dd ' +
            '  JOIN TDB_DOCS d ON d.DOCID = dd.DOCID ' +
            ' WHERE dd.DEAL_ID = :dealid AND d.DOCTYPEID = 107 AND d.DELETED_DATE IS NULL';
        q.ParamByName('dealid').AsLargeInt := FDealID;
        try
            q.Open;
            if not q.FieldByName('PROFIT').IsNull then
                Result := FormatFloat('#,##0.00', q.FieldByName('PROFIT').AsFloat);
        except
            Result := '?';
        end;
    finally
        q.Free;
    end;
end;

procedure TfrmDealCardDlg.LoadData;
const
    cFields: array[0..3] of string = ('PIPE_CODE', 'PAY_CODE', 'FIN_CODE', 'DLV_CODE');
var
    i, flags: Integer;
    closed: string;
begin
    qDocs.Close;
    qHistory.Close;
    qDeal.Close;
    if trRead.Active then
        trRead.Commit;
    trRead.StartTransaction;

    qDeal.ParamByName('dealid').AsLargeInt := FDealID;
    qDeal.Open;
    if qDeal.IsEmpty then
    begin
        dtDialogTitle.Text := Format('Deal-ul %d nu exista.', [FDealID]);
        Exit;
    end;

    Caption := Format('Deal nr. %d', [FDealID]);
    dtDialogTitle.Title := Format('Deal nr. %d - %s', [FDealID, qDeal.FieldByName('CONTACT_NAME').AsString]);
    dtDialogTitle.Text := Format('Sursa: %s (document %s)   Creat: %s',
        [Trim(qDeal.FieldByName('SOURCE_CODE').AsString), qDeal.FieldByName('SOURCE_REF').AsString,
         FormatDateTime('dd.mm.yyyy hh:nn', qDeal.FieldByName('CREATED_AT').AsDateTime)]);

    if qDeal.FieldByName('CLOSED_AT').IsNull then
        closed := 'deschis'
    else
        closed := Format('INCHIS %s (%s)',
            [FormatDateTime('dd.mm.yyyy', qDeal.FieldByName('CLOSED_AT').AsDateTime),
             Trim(qDeal.FieldByName('CLOSED_RESULT').AsString)]);

    lbInfo.Caption := Format('Client: %s' + #13#10 + 'Telefon: %s    Email: %s' + #13#10 +
        'Livrare: %s' + #13#10 + 'Stare deal: %s   Motiv: %s   Canal: %s',
        [qDeal.FieldByName('CONTACT_NAME').AsString, qDeal.FieldByName('PHONE').AsString,
         qDeal.FieldByName('EMAIL').AsString, qDeal.FieldByName('DELIVERY_ADDRESS').AsString, closed,
         qDeal.FieldByName('REASON_TITLE').AsString, qDeal.FieldByName('CHANNEL_TITLE').AsString]);

    lbTotals.Caption := Format('Proforme: %s    Vanzari nete: %s    Incasat: %s' + #13#10 +
        'REST DE PLATA: %s    Profit vanzari (fara TVA): %s',
        [FormatFloat('#,##0.00', qDeal.FieldByName('PROFORMA_SUM').AsFloat),
         FormatFloat('#,##0.00', qDeal.FieldByName('NET_SALE_SUM').AsFloat),
         FormatFloat('#,##0.00', qDeal.FieldByName('PAID_SUM').AsFloat),
         FormatFloat('#,##0.00', qDeal.FieldByName('BALANCE_DUE').AsFloat),
         SalesProfit]);

    for i := 0 to 3 do
    begin
        FCurrent[i] := Trim(qDeal.FieldByName(cFields[i]).AsString);
        Combo(i).ItemIndex := FCodes[i].IndexOf(FCurrent[i]);
    end;

    flags := qDeal.FieldByName('FLAGS').AsInteger;
    btnUnlock.Enabled := (flags and 15) <> 0;
    lbPipe.Caption := 'Etapa (PIPE)';
    lbPay.Caption := 'Plata (PAY)';
    lbFin.Caption := 'Finantare (FIN)';
    lbDlv.Caption := 'Livrare (DLV)';
    if (flags and 1) <> 0 then lbPipe.Caption := lbPipe.Caption + ' [blocat]';
    if (flags and 2) <> 0 then lbPay.Caption := lbPay.Caption + ' [blocat]';
    if (flags and 4) <> 0 then lbFin.Caption := lbFin.Caption + ' [blocat]';
    if (flags and 8) <> 0 then lbDlv.Caption := lbDlv.Caption + ' [blocat]';
    chkLock.Checked := False;

    memNote.Lines.Text := qDeal.FieldByName('NOTE').AsString;

    qDocs.ParamByName('dealid').AsLargeInt := FDealID;
    qDocs.Open;
    qHistory.ParamByName('dealid').AsLargeInt := FDealID;
    qHistory.Open;

    if cxGridDocsTable.ColumnCount = 0 then
    begin
        cxGridDocsTable.DataController.CreateAllItems;
        SetGridCaptions(cxGridDocsTable, ['DOCID', 'Nr. document', 'DATA', 'Data', 'DOC_TYPE', 'Tip document',
            'SUMA', 'Suma', 'LINK_SUM', 'Suma atribuita', 'LINK_TYPE', 'Legatura',
            'IS_DELETED', 'Sters', 'PARENTDOCID', 'Parinte']);
        cxGridDocsTable.ApplyBestFit;
    end;
    if cxGridHistoryTable.ColumnCount = 0 then
    begin
        cxGridHistoryTable.DataController.CreateAllItems;
        SetGridCaptions(cxGridHistoryTable, ['CHANGED_AT', 'Data', 'GROUP_CODE', 'Axa', 'OLD_STATE', 'Din',
            'NEW_STATE', 'In', 'SOURCE', 'Sursa', 'CHANGED_BY', 'Utilizator']);
        cxGridHistoryTable.ApplyBestFit;
    end;
end;

procedure TfrmDealCardDlg.btnApplyStatesClick(Sender: TObject);
var
    i, lock: Integer;
    code: string;
    changed: Boolean;
begin
    changed := False;
    if chkLock.Checked then lock := 1 else lock := 0;
    for i := 0 to 3 do
    begin
        if Combo(i).ItemIndex < 0 then
            Continue;
        code := FCodes[i][Combo(i).ItemIndex];
        if code = FCurrent[i] then
            Continue;
        if not ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_SET_STATE(:dealid, :code, :userid, :lock)',
            ['dealid', FDealID, 'code', code, 'userid', dmDB.CurrentUserID, 'lock', lock]) then
            Break;
        changed := True;
    end;
    if not changed then
        MessageDlg('Nicio stare nu a fost schimbata.', mtInformation, [mbOK], 0);
    LoadData;
end;

procedure TfrmDealCardDlg.btnUnlockClick(Sender: TObject);
var
    i: Integer;
begin
    for i := 0 to 3 do
        if not ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_UNLOCK_AXIS(:dealid, :grp, :userid)',
            ['dealid', FDealID, 'grp', cGroups[i], 'userid', dmDB.CurrentUserID]) then
            Break;
    LoadData;
end;

procedure TfrmDealCardDlg.btnRecalcClick(Sender: TObject);
begin
    ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_RECALC_STATES(:dealid, :userid)',
        ['dealid', FDealID, 'userid', dmDB.CurrentUserID]);
    LoadData;
end;

procedure TfrmDealCardDlg.btnSaveNoteClick(Sender: TObject);
begin
    if ExecDealSQL('UPDATE TDB_DEALS SET NOTE = :note WHERE DEAL_ID = :dealid',
        ['note', Copy(Trim(memNote.Lines.Text), 1, 1000), 'dealid', FDealID]) then
        LoadData;
end;

procedure TfrmDealCardDlg.btnBindDocClick(Sender: TObject);
var
    s: string;
    docID: Integer;
begin
    s := '';
    if not InputQuery('Legare document', 'Numarul intern al documentului (DOCID):', s) then
        Exit;
    if not TryStrToInt(Trim(s), docID) or (docID <= 0) then
    begin
        MessageDlg('Numar de document invalid.', mtError, [mbOK], 0);
        Exit;
    end;
    if ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_BIND_DOC_MANUAL(:dealid, :docid, :userid, :linksum)',
        ['dealid', FDealID, 'docid', docID, 'userid', dmDB.CurrentUserID, 'linksum', Null]) then
        LoadData;
end;

procedure TfrmDealCardDlg.btnUnbindDocClick(Sender: TObject);
var
    docID: Integer;
begin
    if not qDocs.Active or qDocs.IsEmpty then
        Exit;
    docID := qDocs.FieldByName('DOCID').AsInteger;
    if MessageDlg(Format('Scoateti documentul %d (%s) din acest deal?',
        [docID, qDocs.FieldByName('DOC_TYPE').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;
    if ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_UNBIND_DOC(:dealid, :docid, :userid)',
        ['dealid', FDealID, 'docid', docID, 'userid', dmDB.CurrentUserID]) then
        LoadData;
end;

procedure TfrmDealCardDlg.btnMergeClick(Sender: TObject);
var
    s: string;
    fromID: Int64;
begin
    s := '';
    if not InputQuery('Unire deal-uri',
        'Numarul deal-ului care va fi ABSORBIT in acesta (documentele lui trec aici):', s) then
        Exit;
    if not TryStrToInt64(Trim(s), fromID) or (fromID <= 0) or (fromID = FDealID) then
    begin
        MessageDlg('Numar de deal invalid.', mtError, [mbOK], 0);
        Exit;
    end;
    if MessageDlg(Format('Deal-ul %d va fi inchis (MERGED), iar documentele lui trec in deal-ul %d. Continuati?',
        [fromID, FDealID]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;
    if ExecDealSQL('EXECUTE PROCEDURE SP_DEAL_MERGE(:intoid, :fromid, :userid)',
        ['intoid', FDealID, 'fromid', fromID, 'userid', dmDB.CurrentUserID]) then
        LoadData;
end;

end.
