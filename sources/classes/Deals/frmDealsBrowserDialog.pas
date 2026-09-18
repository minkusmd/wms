unit frmDealsBrowserDialog;

(* ============================================================================
   Lista deal-urilor (VW_DEALS_BROWSER): filtre pe perioada, deschise / cu rest
   de plata, cautare dupa client sau telefon. Dublu-click deschide fisa.

   SelectMode = True: dialogul alege un deal (legarea manuala a unei plati);
   ContactID <> 0 limiteaza lista la deal-urile deschise ale acelui client.
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
    TfrmDealsBrowserDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        pnTop: TPanel;
        lbFrom: TLabel;
        dtFrom: TDateTimePicker;
        chkOnlyOpen: TCheckBox;
        chkWithBalance: TCheckBox;
        lbSearch: TLabel;
        edSearch: TEdit;
        btnRefresh: TcxButton;
        cxGridDeals: TcxGrid;
        cxGridDealsTable: TcxGridDBTableView;
        cxGridDealsLevel: TcxGridLevel;
        btnOpen: TcxButton;
        btnSelect: TcxButton;
        btnClose: TcxButton;
        trRead: TIBCTransaction;
        qDeals: TIBCQuery;
        dsDeals: TIBCDataSource;
        procedure btnRefreshClick(Sender: TObject);
        procedure btnOpenClick(Sender: TObject);
        procedure btnSelectClick(Sender: TObject);
        procedure edSearchKeyPress(Sender: TObject; var Key: Char);
        procedure cxGridDealsTableCellDblClick(Sender: TcxCustomGridTableView;
            ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
            AShift: TShiftState; var AHandled: Boolean);
    private
        FSelectMode: Boolean;
        FContactID: Integer;
        FOnlyWithBalance: Boolean;
        FSelectedDealID: Int64;
        procedure LoadData;
        function CurrentDealID: Int64;
        procedure SetCaption(const AField, ACaption: string);
    protected
        procedure Prepare; override;
    public
        property SelectMode: Boolean read FSelectMode write FSelectMode;
        property ContactID: Integer read FContactID write FContactID;
        property OnlyWithBalance: Boolean read FOnlyWithBalance write FOnlyWithBalance;
        property SelectedDealID: Int64 read FSelectedDealID;
    end;

implementation

uses
    System.UITypes, DataModuleDB, SWNDealsUnit;

{$R *.dfm}

procedure TfrmDealsBrowserDlg.Prepare;
begin
    trRead.DefaultConnection := dmDB.IBCConnection;
    qDeals.Connection := dmDB.IBCConnection;

    dtFrom.Date := IncMonth(Date, -3);
    chkOnlyOpen.Checked := True;
    chkWithBalance.Checked := FOnlyWithBalance;
    btnSelect.Visible := FSelectMode;

    if FSelectMode then
    begin
        Caption := 'Alegeti deal-ul';
        dtDialogTitle.Title := 'Alegeti deal-ul';
        if FContactID <> 0 then
            dtDialogTitle.Text := 'Deal-urile deschise ale clientului documentului. ' +
                'Debifati filtrele pentru a vedea si altele.'
        else
            dtDialogTitle.Text := 'Alegeti deal-ul de care se leaga documentul.';
        dtFrom.Date := IncMonth(Date, -24);
    end
    else
        dtDialogTitle.Text := 'Starile se calculeaza automat din documente. Dublu-click deschide fisa deal-ului.';

    LoadData;
end;

procedure TfrmDealsBrowserDlg.SetCaption(const AField, ACaption: string);
var
    col: TcxGridDBColumn;
begin
    col := cxGridDealsTable.GetColumnByFieldName(AField);
    if col <> nil then
        col.Caption := ACaption;
end;

procedure TfrmDealsBrowserDlg.LoadData;
var
    sql, txt: string;
begin
    qDeals.Close;
    if trRead.Active then
        trRead.Commit;
    trRead.StartTransaction;

    sql :=
        'SELECT b.DEAL_ID, b.CREATED_AT, b.CONTACT_NAME, b.PHONE, b.SOURCE_CODE, ' +
        '       b.PIPE_TITLE, b.PAY_TITLE, b.FIN_TITLE, b.DLV_TITLE, b.DOCS_COUNT, ' +
        '       b.PROFORMA_SUM, b.NET_SALE_SUM, b.PAID_SUM, b.BALANCE_DUE, ' +
        '       b.REASON_TITLE, b.CHANNEL_TITLE, ' +
        '       b.LAST_DOC_DATE, b.CLOSED_AT, b.CLOSED_RESULT, b.NOTE ' +
        '  FROM VW_DEALS_BROWSER b ' +
        ' WHERE b.CREATED_AT >= :dfrom';
    if chkOnlyOpen.Checked then
        sql := sql + ' AND b.CLOSED_AT IS NULL';
    if chkWithBalance.Checked then
        sql := sql + ' AND b.BALANCE_DUE > 0.005';
    if FSelectMode and (FContactID <> 0) and chkOnlyOpen.Checked then
        sql := sql + ' AND b.CONTACTID = ' + IntToStr(FContactID);
    txt := Trim(edSearch.Text);
    if txt <> '' then
        sql := sql + ' AND (COALESCE(b.CONTACT_NAME, '''') || '' '' || COALESCE(b.PHONE, '''')) CONTAINING :txt';
    sql := sql + ' ORDER BY b.CREATED_AT DESC';

    qDeals.SQL.Text := sql;
    qDeals.ParamByName('dfrom').AsDateTime := Trunc(dtFrom.Date);
    if txt <> '' then
        qDeals.ParamByName('txt').AsString := txt;
    qDeals.Open;

    if cxGridDealsTable.ColumnCount = 0 then
    begin
        cxGridDealsTable.DataController.CreateAllItems;
        SetCaption('DEAL_ID', 'Deal');
        SetCaption('CREATED_AT', 'Creat');
        SetCaption('CONTACT_NAME', 'Client');
        SetCaption('PHONE', 'Telefon');
        SetCaption('SOURCE_CODE', 'Sursa');
        SetCaption('PIPE_TITLE', 'Etapa');
        SetCaption('PAY_TITLE', 'Plata');
        SetCaption('FIN_TITLE', 'Finantare');
        SetCaption('DLV_TITLE', 'Livrare');
        SetCaption('DOCS_COUNT', 'Doc.');
        SetCaption('PROFORMA_SUM', 'Proforme');
        SetCaption('NET_SALE_SUM', 'Vanzari nete');
        SetCaption('PAID_SUM', 'Incasat');
        SetCaption('BALANCE_DUE', 'Rest de plata');
        SetCaption('REASON_TITLE', 'Motiv');
        SetCaption('CHANNEL_TITLE', 'Canal');
        SetCaption('LAST_DOC_DATE', 'Ultimul document');
        SetCaption('CLOSED_AT', 'Inchis');
        SetCaption('CLOSED_RESULT', 'Rezultat');
        SetCaption('NOTE', 'Nota');
        cxGridDealsTable.ApplyBestFit;
    end;
end;

function TfrmDealsBrowserDlg.CurrentDealID: Int64;
begin
    Result := 0;
    if qDeals.Active and not qDeals.IsEmpty then
        Result := qDeals.FieldByName('DEAL_ID').AsLargeInt;
end;

procedure TfrmDealsBrowserDlg.btnRefreshClick(Sender: TObject);
begin
    LoadData;
end;

procedure TfrmDealsBrowserDlg.edSearchKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
    begin
        Key := #0;
        LoadData;
    end;
end;

procedure TfrmDealsBrowserDlg.btnOpenClick(Sender: TObject);
var
    id: Int64;
begin
    id := CurrentDealID;
    if id = 0 then
        Exit;
    ShowDealCard(Self, id);
    LoadData;
    qDeals.Locate('DEAL_ID', id, []);
end;

procedure TfrmDealsBrowserDlg.btnSelectClick(Sender: TObject);
begin
    FSelectedDealID := CurrentDealID;
    if FSelectedDealID = 0 then
    begin
        MessageDlg('Selectati un deal.', mtInformation, [mbOK], 0);
        Exit;
    end;
    ModalResult := mrOk;
end;

procedure TfrmDealsBrowserDlg.cxGridDealsTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
    AShift: TShiftState; var AHandled: Boolean);
begin
    AHandled := True;
    if FSelectMode then
        btnSelectClick(Sender)
    else
        btnOpenClick(Sender);
end;

end.
