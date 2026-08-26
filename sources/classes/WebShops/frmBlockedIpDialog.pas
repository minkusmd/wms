unit frmBlockedIpDialog;

(* ============================================================================
   Gestiunea IP-urilor blocate pe site (fantastic.md) - tabela TWEB_BLOCKED_IP.

   Site-ul (SecurityGuard.php) blocheaza automat un IP dupa 50 de cereri
   invalide in 10 minute si scrie blocarea in aceasta tabela. Dialogul permite:
     - vizualizarea listei (active / toate / manuale / lista alba);
     - blocarea manuala a unui IP (permanent, N minute sau pana la o data);
     - deblocarea (FLG_ACTIVE = 0) - pastreaza istoricul;
     - stergerea definitiva a intrarii.

   Fiecare actiune se comite imediat: dialogul este un instrument operational,
   nu un editor cu OK/Renunta.
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    SWNBaseUnit, DialogTitle, ExtCtrls, StdCtrls, Data.DB, DBAccess, IBC, MemDS, Vcl.Menus,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView,
    cxGrid, cxButtons, cxTextEdit, cxMaskEdit, cxRadioGroup, cxLabel,
    dxScrollbarAnnotations, dxDateRanges, cxDBData, cxGroupBox;

type
    TfrmBlockedIpDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        IBCQueryIps: TIBCQuery;
        IBCDataSourceIps: TIBCDataSource;
        IBCTransactionUpdate: TIBCTransaction;
        pnTop: TPanel;
        rgFilter: TcxRadioGroup;
        lbSearch: TLabel;
        edSearch: TcxTextEdit;
        btnRefresh: TcxButton;
        cxGridIps: TcxGrid;
        cxGridIpsTable: TcxGridDBTableView;
        cxGridIpsLevel: TcxGridLevel;
        cxGridIps_BLOCKID: TcxGridDBColumn;
        cxGridIps_STATE_CODE: TcxGridDBColumn;
        cxGridIps_IP_ADDRESS: TcxGridDBColumn;
        cxGridIps_STATE_NAME: TcxGridDBColumn;
        cxGridIps_SOURCE_NAME: TcxGridDBColumn;
        cxGridIps_REASON: TcxGridDBColumn;
        cxGridIps_BLOCKED_AT: TcxGridDBColumn;
        cxGridIps_EXPIRES_AT: TcxGridDBColumn;
        cxGridIps_BLOCK_COUNT: TcxGridDBColumn;
        cxGridIps_REQ_COUNT: TcxGridDBColumn;
        cxGridIps_LAST_HIT_AT: TcxGridDBColumn;
        cxGridIps_CREATED_BY: TcxGridDBColumn;
        cxGridIps_NOTE: TcxGridDBColumn;
        btnAdd: TcxButton;
        btnEdit: TcxButton;
        btnUnblock: TcxButton;
        btnDelete: TcxButton;
        btnClose: TcxButton;
        procedure btnAddClick(Sender: TObject);
        procedure btnEditClick(Sender: TObject);
        procedure btnUnblockClick(Sender: TObject);
        procedure btnDeleteClick(Sender: TObject);
        procedure btnRefreshClick(Sender: TObject);
        procedure rgFilterPropertiesChange(Sender: TObject);
        procedure edSearchPropertiesChange(Sender: TObject);
        procedure cxGridIpsTableCellDblClick(Sender: TcxCustomGridTableView;
            ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
            AShift: TShiftState; var AHandled: Boolean);
        procedure cxGridIpsTableCustomDrawCell(Sender: TcxCustomGridTableView;
            ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
            var ADone: Boolean);
    private
        procedure ExecUpdSql(const ASql: string; const AParams: array of Variant);
        procedure RefreshData;
        function CurrentBlockId: Integer;
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    end;

implementation

uses
    DataModuleDB, frmBlockIpEditorDialog;

{$R *.dfm}

const
    { rgFilter }
    cFlt_Active    = 0;
    cFlt_All       = 1;
    cFlt_Manual    = 2;
    cFlt_Whitelist = 3;

    { STATE_CODE }
    cState_Blocked   = 0;
    cState_Expired   = 1;
    cState_Unblocked = 2;
    cState_Whitelist = 3;

    cSource_Manual = 1;

{ TfrmBlockedIpDlg }

procedure TfrmBlockedIpDlg.Prepare;
begin
    dtDialogTitle.Text := 'IP-uri blocate pe site (peste 50 cereri invalide in 10 minute)';
    rgFilter.ItemIndex := cFlt_Active;
    RefreshData;
end;

{ Lista se reciteste cu un WHERE construit dupa filtrul ales. STATE_CODE si
  denumirile de stare/sursa se calculeaza in SELECT, ca sa fie sortabile. }
procedure TfrmBlockedIpDlg.RefreshData;
var
    sql, where: string;
    keepId: Integer;
begin
    keepId := CurrentBlockId;

    case rgFilter.ItemIndex of
        cFlt_All:
            where := '1 = 1';
        cFlt_Manual:
            where := 'B.SOURCE = 1';
        cFlt_Whitelist:
            where := 'B.FLG_WHITELIST = 1';
    else
        { blocate acum }
        where := 'B.FLG_ACTIVE = 1 AND B.FLG_WHITELIST = 0 ' +
                 'AND (B.EXPIRES_AT IS NULL OR B.EXPIRES_AT > CURRENT_TIMESTAMP)';
    end;

    if Trim(edSearch.Text) <> '' then
        where := where + ' AND B.IP_ADDRESS CONTAINING :ip';

    sql :=
        'SELECT B.BLOCKID, B.IP_ADDRESS, B.SOURCE, B.REASON, B.BLOCKED_AT, ' +
        '       B.EXPIRES_AT, B.FLG_ACTIVE, B.FLG_WHITELIST, B.BLOCK_COUNT, ' +
        '       B.REQ_COUNT, B.LAST_HIT_AT, B.CREATED_BY, B.NOTE, ' +
        '       CASE ' +
        '         WHEN B.FLG_WHITELIST = 1 THEN 3 ' +
        '         WHEN B.FLG_ACTIVE = 0 THEN 2 ' +
        '         WHEN B.EXPIRES_AT IS NOT NULL AND B.EXPIRES_AT <= CURRENT_TIMESTAMP THEN 1 ' +
        '         ELSE 0 END AS STATE_CODE, ' +
        '       CAST(CASE ' +
        '         WHEN B.FLG_WHITELIST = 1 THEN ''Lista alba'' ' +
        '         WHEN B.FLG_ACTIVE = 0 THEN ''Deblocat'' ' +
        '         WHEN B.EXPIRES_AT IS NOT NULL AND B.EXPIRES_AT <= CURRENT_TIMESTAMP THEN ''Expirat'' ' +
        '         WHEN B.EXPIRES_AT IS NULL THEN ''Blocat permanent'' ' +
        '         ELSE ''Blocat'' END AS VARCHAR(20)) AS STATE_NAME, ' +
        '       CAST(CASE B.SOURCE ' +
        '         WHEN 1 THEN ''Manual'' ' +
        '         WHEN 2 THEN ''Login'' ' +
        '         ELSE ''Automat'' END AS VARCHAR(10)) AS SOURCE_NAME ' +
        'FROM TWEB_BLOCKED_IP B ' +
        'WHERE ' + where + ' ' +
        'ORDER BY B.BLOCKED_AT DESC';

    IBCQueryIps.Close;
    IBCQueryIps.Connection := dmDB.IBCConnection;
    IBCQueryIps.UpdateTransaction := IBCTransactionUpdate;
    IBCQueryIps.SQL.Text := sql;
    if Trim(edSearch.Text) <> '' then
        IBCQueryIps.ParamByName('ip').AsString := Trim(edSearch.Text);
    IBCQueryIps.Open;

    if keepId > 0 then
        IBCQueryIps.Locate('BLOCKID', keepId, []);
end;

function TfrmBlockedIpDlg.CurrentBlockId: Integer;
begin
    if IBCQueryIps.Active and (not IBCQueryIps.IsEmpty) then
        Result := IBCQueryIps.FieldByName('BLOCKID').AsInteger
    else
        Result := 0;
end;

{ Executa un statement in tranzactia proprie si comite imediat. }
procedure TfrmBlockedIpDlg.ExecUpdSql(const ASql: string; const AParams: array of Variant);
var
    q: TIBCSQL;
    i: Integer;
begin
    q := TIBCSQL.Create(nil);
    try
        q.Connection := dmDB.IBCConnection;
        q.Transaction := IBCTransactionUpdate;
        q.SQL.Text := ASql;
        for i := 0 to High(AParams) do
            q.Params[i].Value := AParams[i];
        if not IBCTransactionUpdate.Active then
            IBCTransactionUpdate.StartTransaction;
        q.Execute;
        IBCTransactionUpdate.Commit;
    except
        if IBCTransactionUpdate.Active then
            IBCTransactionUpdate.Rollback;
        raise;
    end;
    q.Free;
end;

procedure TfrmBlockedIpDlg.btnAddClick(Sender: TObject);
var
    d: TfrmBlockIpEditorDlg;
    expires: Variant;
begin
    d := TfrmBlockIpEditorDlg.Create(Self);
    try
        d.CreateNewItem := True;
        if d.ShowModal <> mrOk then
            Exit;

        if d.ExpiresAt = 0 then
            expires := Null
        else
            expires := d.ExpiresAt;

        { acelasi IP poate exista deja (blocat automat inainte) -> UPDATE OR INSERT }
        ExecUpdSql(
            'UPDATE OR INSERT INTO TWEB_BLOCKED_IP ' +
            '  (IP_ADDRESS, SOURCE, REASON, NOTE, BLOCKED_AT, EXPIRES_AT, ' +
            '   FLG_ACTIVE, FLG_WHITELIST, CREATED_BY, UNBLOCKED_AT, UNBLOCKED_BY) ' +
            'VALUES (:ip, 1, :reason, :note, CURRENT_TIMESTAMP, :expires, ' +
            '        :active, :wl, :usr, NULL, NULL) ' +
            'MATCHING (IP_ADDRESS)',
            [d.IpAddress, d.Reason, d.Note, expires,
             Integer(not d.IsWhitelist), Integer(d.IsWhitelist), dmDB.CurrentUserFullName]);

        RefreshData;
        IBCQueryIps.Locate('IP_ADDRESS', d.IpAddress, []);
    finally
        d.Free;
    end;
end;

procedure TfrmBlockedIpDlg.btnEditClick(Sender: TObject);
var
    d: TfrmBlockIpEditorDlg;
    expires: Variant;
    id: Integer;
begin
    if IBCQueryIps.IsEmpty then
        Exit;
    id := CurrentBlockId;

    d := TfrmBlockIpEditorDlg.Create(Self);
    try
        d.CreateNewItem := False;
        d.IpAddress := IBCQueryIps.FieldByName('IP_ADDRESS').AsString;
        d.Reason := IBCQueryIps.FieldByName('REASON').AsString;
        d.Note := IBCQueryIps.FieldByName('NOTE').AsString;
        d.IsWhitelist := IBCQueryIps.FieldByName('FLG_WHITELIST').AsInteger = 1;
        if IBCQueryIps.FieldByName('EXPIRES_AT').IsNull then
            d.ExpiresAt := 0
        else
            d.ExpiresAt := IBCQueryIps.FieldByName('EXPIRES_AT').AsDateTime;

        if d.ShowModal <> mrOk then
            Exit;

        if d.ExpiresAt = 0 then
            expires := Null
        else
            expires := d.ExpiresAt;

        ExecUpdSql(
            'UPDATE TWEB_BLOCKED_IP SET REASON = :reason, NOTE = :note, ' +
            '   EXPIRES_AT = :expires, FLG_WHITELIST = :wl, FLG_ACTIVE = :active ' +
            ' WHERE BLOCKID = :id',
            [d.Reason, d.Note, expires, Integer(d.IsWhitelist),
             Integer(not d.IsWhitelist), id]);

        RefreshData;
    finally
        d.Free;
    end;
end;

{ Deblocare "moale": intrarea ramane in lista, cu istoricul intact. }
procedure TfrmBlockedIpDlg.btnUnblockClick(Sender: TObject);
var
    ip: string;
begin
    if IBCQueryIps.IsEmpty then
        Exit;
    if IBCQueryIps.FieldByName('FLG_ACTIVE').AsInteger = 0 then
    begin
        ShowMessage('Acest IP nu este blocat.');
        Exit;
    end;

    ip := IBCQueryIps.FieldByName('IP_ADDRESS').AsString;
    if MessageDlg(Format('Deblocati IP-ul %s?'#13#10 +
        'Intrarea ramane in lista, cu istoricul pastrat.', [ip]),
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

    ExecUpdSql(
        'UPDATE TWEB_BLOCKED_IP SET FLG_ACTIVE = 0, EXPIRES_AT = CURRENT_TIMESTAMP, ' +
        '   UNBLOCKED_AT = CURRENT_TIMESTAMP, UNBLOCKED_BY = :usr ' +
        ' WHERE BLOCKID = :id',
        [dmDB.CurrentUserFullName, CurrentBlockId]);

    RefreshData;
end;

{ Stergere definitiva - se pierde si istoricul intrarii. }
procedure TfrmBlockedIpDlg.btnDeleteClick(Sender: TObject);
var
    ip: string;
begin
    if IBCQueryIps.IsEmpty then
        Exit;
    ip := IBCQueryIps.FieldByName('IP_ADDRESS').AsString;
    if MessageDlg(Format('Stergeti definitiv intrarea pentru %s?'#13#10 +
        'Se pierde si istoricul blocarilor pentru acest IP.', [ip]),
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

    ExecUpdSql('DELETE FROM TWEB_BLOCKED_IP WHERE BLOCKID = :id', [CurrentBlockId]);
    RefreshData;
end;

procedure TfrmBlockedIpDlg.btnRefreshClick(Sender: TObject);
begin
    RefreshData;
end;

procedure TfrmBlockedIpDlg.rgFilterPropertiesChange(Sender: TObject);
begin
    if IBCQueryIps.Active then
        RefreshData;
end;

procedure TfrmBlockedIpDlg.edSearchPropertiesChange(Sender: TObject);
begin
    if IBCQueryIps.Active then
        RefreshData;
end;

procedure TfrmBlockedIpDlg.cxGridIpsTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
    var AHandled: Boolean);
begin
    AHandled := True;
    btnEditClick(btnEdit);
end;

{ Colorare dupa stare: blocat = rosu, expirat/deblocat = gri, lista alba = verde. }
procedure TfrmBlockedIpDlg.cxGridIpsTableCustomDrawCell(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
    st: Variant;
begin
    st := AViewInfo.GridRecord.Values[cxGridIps_STATE_CODE.Index];
    if VarIsNull(st) then
        Exit;
    case Integer(st) of
        cState_Blocked:
            begin
                ACanvas.Font.Color := clMaroon;
                ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
            end;
        cState_Expired, cState_Unblocked:
            ACanvas.Font.Color := clGrayText;
        cState_Whitelist:
            ACanvas.Font.Color := clGreen;
    end;
end;

function TfrmBlockedIpDlg.IsFormDataPosted: Boolean;
begin
    { toate actiunile au fost deja comise; nu ramane nimic de salvat }
    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Commit;
    Result := True;
end;

procedure TfrmBlockedIpDlg.WhenCancelForm;
begin
    if IBCTransactionUpdate.Active then
        IBCTransactionUpdate.Rollback;
end;

end.
