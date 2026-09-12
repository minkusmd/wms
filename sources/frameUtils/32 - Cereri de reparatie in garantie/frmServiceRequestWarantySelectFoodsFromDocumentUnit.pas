unit frmServiceRequestWarantySelectFoodsFromDocumentUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit, Vcl.Controls, Vcl.Forms,
    Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter,
    cxData, cxDataStorage, cxNavigator, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, Vcl.Menus,
    Vcl.Buttons, Vcl.StdCtrls, cxButtons, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, dxBar, cxClasses, DBAccess, IBC, MemDS,
    cxGridLevel, cxGridCustomView, cxGrid, Vcl.ExtCtrls, DialogTitle, cxLabel, cxTextEdit, cxMaskEdit, cxButtonEdit, cxDropDownEdit,
    cxMRUEdit, dxScrollbarAnnotations;

type
    TfrmServiceRequestWarantySelectFoodsFromDocumentDlg = class(TSWNBaseFormClass)
        cxLabel1: TcxLabel;
        DialogTitle1: TDialogTitle;
        Panel1: TPanel;
        cxGrid1Level1: TcxGridLevel;
        cxGrid1: TcxGrid;
        IBCQueryRezerve: TIBCQuery;
        IBCDataSourceRezerve: TIBCDataSource;
        dxBarDockControl1: TdxBarDockControl;
        dxBarManager1: TdxBarManager;
        dxBarManager1Bar1: TdxBar;
        bbComplectatia: TdxBarButton;
        cxButton1: TcxButton;
        cxButton2: TcxButton;
        cxGrid2: TcxGrid;
        cxGridLevel1: TcxGridLevel;
        btnToVinzari: TSpeedButton;
        btnToRetur: TSpeedButton;
        beDOCID: TcxButtonEdit;
        tvVinzari: TcxGridTableView;
        tvVinzari_GOODSID: TcxGridColumn;
        tvVinzari_GOODSNAME: TcxGridColumn;
        tvVinzari_SN: TcxGridColumn;
        cxLabel2: TcxLabel;
        beCustomer: TcxButtonEdit;
        tvRetur: TcxGridTableView;
        tvRetur_GOODSID: TcxGridColumn;
        tvRetur_GOODSNAME: TcxGridColumn;
        tvRetur_SN: TcxGridColumn;
        tvVinzari_QTY: TcxGridColumn;
        tvVinzari_PRICE: TcxGridColumn;
        tvRetur_QTY: TcxGridColumn;
        tvRetur_PRICE: TcxGridColumn;
        cxLabel3: TcxLabel;
        cxLabel4: TcxLabel;
        IBCQueryJurnalRetur: TIBCQuery;
    tvVinzari_UM: TcxGridColumn;
    Panel2: TPanel;
    cxLabel5: TcxLabel;
    lbDocumentSum: TcxLabel;
    cxLabel6: TcxLabel;
    lbCreatedBy: TcxLabel;
    label1: TcxLabel;
    cxLabel9: TcxLabel;
    btnMoveAllToRetur: TSpeedButton;
    tvRetur_SUMA: TcxGridColumn;
    tvRetur_UM: TcxGridColumn;
        procedure beDOCIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
        procedure btnMoveAllToReturClick(Sender: TObject);
        procedure btnToVinzariClick(Sender: TObject);
        procedure btnToReturClick(Sender: TObject);
    private    { Private declarations }
        procedure LoadDataDocumentVinzari;
        procedure MoveRecordToRetur(ARowIndex: Integer; ARowInfo: TcxRowInfo);
    protected
        procedure AddGoodsToRetur;
        procedure DeleteRecordsFromVinzari(ARowIndex: Integer; ARowInfo: TcxRowInfo);
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure LoadDataDocumentRetur;
        procedure PrepareCustomerInfo(ADocID: Integer);
        procedure UpdateSNParts(docid, dtdep, ctdep, GOODSID, QTY, Price, UMID, WARRANTY, GOODSCOMPLECT_ID: string;
            GoodsTypeID, VinzareDOCID: Integer);
        procedure WhenCancelForm; override;
    public
        procedure FillDataGrid;
    { Public declarations }
    end;

var
    frmServiceRequestWarantySelectFoodsFromDocumentDlg: TfrmServiceRequestWarantySelectFoodsFromDocumentDlg;


implementation

uses
    DataModuleDB, DataModuleAdditions, System.UITypes;

{$R *.dfm}

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.AddGoodsToRetur;
var
    i: Integer;
    q: TIBCQuery;
begin
    // delete all record from current document retur
    while not dmdb.IBCQueryJurnal.Eof do
        dmdb.IBCQueryJurnal.Delete;
    // insert new records to current document
    q := TIBCQuery.Create(self);
    q.Transaction := dmDB.IBCQueryJurnal.UpdateTransaction;
    if not q.Transaction.Active then
        q.Transaction.StartTransaction;
    try
        q.SQL.Add('insert into tdb_jurnal (docid, dtdep, ctdep, goodsid, umid, qty, price, warranty, GOODSCOMPLECT_ID)');
        q.SQL.Add('values(:docid, :dtdep, :ctdep, :goodsid, :umid, :qty, :price, :warranty,  :GOODSCOMPLECT_ID)');
        q.Prepare;
        for i := 0 to tvRetur.DataController.RecordCount - 1 do
        begin
            q.ParamByName('DOCID').AsString :=    dmdb.IBCQueryDocs.FieldByName('DOCID').AsString;
            q.ParamByName('dtdep').AsString :=    dmdb.IBCQueryDocs.FieldByName('DTDEP').AsString;
            q.ParamByName('ctdep').AsString :=    dmdb.IBCQueryDocs.FieldByName('CTDEp').AsString;
            q.ParamByName('goodsid').AsString :=  tvRetur.DataController.Values[i, tvRetur_GOODSID.Index];
            q.ParamByName('qty').AsString :=      tvRetur.DataController.Values[i, tvRetur_QTY.Index];
            q.ParamByName('price').AsString :=    tvRetur.DataController.Values[i, tvRetur_PRICE.Index];
            q.ParamByName('UMID').AsString :=     tvRetur.DataController.Values[i, tvRetur_UM.Index];
            q.ParamByName('WARRANTY').AsString := '24';
            q.ParamByName('GOODSCOMPLECT_ID').AsString := '-1';
            q.ExecSQL;

            UpdateSNParts(
                dmdb.IBCQueryDocs.FieldByName('DOCID').AsString,
                dmdb.IBCQueryDocs.FieldByName('DTDEP').AsString,
                dmdb.IBCQueryDocs.FieldByName('CTDEp').AsString,
                tvRetur.DataController.Values[i, tvRetur_GOODSID.Index],
                tvRetur.DataController.Values[i, tvRetur_QTY.Index],
                tvRetur.DataController.Values[i, tvRetur_PRICE.Index],
                tvRetur.DataController.Values[i, tvRetur_UM.Index],
                '24',
                '-1',
                4203,
                StrToInt(beDOCID.Text)
                );
        end;
        q.Transaction.Commit;
    finally
        q.Free;
    end;
end;

{ TfrmServiceRequestWarantySelectFoodsFromDocumentDlg }

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.beDOCIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
    IBCQueryRezerve.Close;
    IBCQueryRezerve.ParamByName('DOCID').AsString := beDOCID.Text;
    IBCQueryRezerve.Open;
    beCustomer.Tag := IBCQueryRezerve.FieldByName('CT').AsInteger;
    beCustomer.Text := IBCQueryRezerve.FieldByName('CT_NAME').AsString;
    FillDataGrid;
    PrepareCustomerInfo(IBCQueryRezerve.FieldByName('DOCID').AsInteger);
end;

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.MoveRecordToRetur(ARowIndex: Integer; ARowInfo: TcxRowInfo);
var
    N: Integer;
begin
    N := tvRetur.DataController.AppendRecord;
    tvRetur.DataController.Values[N, tvRetur_GOODSID.Index] := tvVinzari.DataController.Values[ARowIndex, tvVinzari_GOODSID.Index];
    tvRetur.DataController.Values[N, tvRetur_GOODSNAME.Index] := tvVinzari.DataController.Values[ARowIndex, tvVinzari_GOODSNAME.Index];
    tvRetur.DataController.Values[N, tvRetur_SN.Index] := tvVinzari.DataController.Values[ARowIndex, tvVinzari_SN.Index];
    tvRetur.DataController.Values[N, tvRetur_QTY.Index] := tvVinzari.DataController.Values[ARowIndex, tvVinzari_QTY.Index];;
    tvRetur.DataController.Values[N, tvRetur_PRICE.Index] := tvVinzari.DataController.Values[ARowIndex, tvVinzari_PRICE.Index];
    tvRetur.DataController.Values[N, tvRetur_UM.Index] := tvVinzari.DataController.Values[ARowIndex, tvVinzari_UM.Index];
end;

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.btnMoveAllToReturClick(Sender: TObject);
var
    i: Integer;
begin
    tvVinzari.DataController.ForEachRow(False, MoveRecordToRetur);
    for i:=tvVinzari.DataController.RecordCount-1 downto 0 do
      tvVinzari.DataController.DeleteRecord(i);
end;


procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.FillDataGrid;
begin
    LoadDataDocumentVinzari;
    LoadDataDocumentRetur;
end;

function TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.IsFormDataPosted: Boolean;
begin
    try
        // Introducem documentul rezerva in parintele documentului de primire
        dmDB.ibcquerydocs.Edit;
        dmDB.ibcquerydocs.FieldByName('PARENTDOCID').AsString := beDOCID.Text;
        if dmDB.ibcquerydocs.FieldByName('CT').AsInteger <> IBCQueryRezerve.FieldByName('CT').AsInteger then
        begin
            MessageDlg('Clientii din garantie si cel din document nu corespund! Clientul din document va fi modificat!', mtConfirmation, [mbOK], 0);
            dmDB.ibcquerydocs.FieldByName('CT').AsInteger := IBCQueryRezerve.FieldByName('CT').AsInteger;
        end;
        dmDB.ibcquerydocs.Post;

        AddGoodsToRetur;

        if Assigned(dmDB.IBCQueryDocs.UpdateTransaction) and (dmDB.IBCQueryDocs.UpdateTransaction.Active) then
            dmDB.IBCQueryDocs.UpdateTransaction.Commit;
        Result := True;
    except
        Result := False;
        raise;
    end;
end;

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.LoadDataDocumentRetur;
var
    N: Integer;
begin
    tvRetur.DataController.BeginUpdate;
    ibcqueryjurnalRetur.Open;
    IBCQueryJurnalRetur.First;
    while not IBCQueryJurnalRetur.Eof do
    begin
        N := tvVinzari.DataController.AppendRecord;
        tvRetur.DataController.Values[N, tvRetur_GOODSID.Index] := IBCQueryJurnalRetur.FieldByName('GOODSID').AsInteger;
        tvRetur.DataController.Values[N, tvRetur_GOODSNAME.Index] := IBCQueryJurnalRetur.FieldByName('GOODS_NAME').AsString;
        tvRetur.DataController.Values[N, tvRetur_SN.Index] := IBCQueryJurnalRetur.FieldByName('SN').AsString;
        tvRetur.DataController.Values[N, tvRetur_QTY.Index] := IBCQueryJurnalRetur.FieldByName('QTY').AsString;
        tvRetur.DataController.Values[N, tvRetur_Price.Index] := IBCQueryJurnalRetur.FieldByName('Price').AsString;
        tvRetur.DataController.Values[N, tvRetur_UM.Index] := IBCQueryJurnalRetur.FieldByName('UMID').AsString;
        IBCQueryJurnalRetur.Next;
    end;
    tvRetur.DataController.EndUpdate;
end;

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.LoadDataDocumentVinzari;
var
    N: Integer;
begin
    IBCQueryRezerve.First;
    while not IBCQueryRezerve.Eof do
    begin
        N := tvVinzari.DataController.AppendRecord;
        tvVinzari.DataController.Values[N, tvVinzari_GOODSID.Index] := IBCQueryRezerve.FieldByName('GOODSID').AsInteger;
        tvVinzari.DataController.Values[N, tvVinzari_GOODSNAME.Index] := IBCQueryRezerve.FieldByName('GOODS_NAME').AsString;
        tvVinzari.DataController.Values[N, tvVinzari_SN.Index] := IBCQueryRezerve.FieldByName('SN').AsString;
        tvVinzari.DataController.Values[N, tvVinzari_QTY.Index] := IBCQueryRezerve.FieldByName('QTY').AsString;
        tvVinzari.DataController.Values[N, tvVinzari_PRICE.Index] := IBCQueryRezerve.FieldByName('PRICE').AsString;
        tvVinzari.DataController.Values[N, tvVinzari_UM.Index] :=  IBCQueryRezerve.FieldByName('UMID').AsString;
        IBCQueryRezerve.Next;
    end;
end;

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.Prepare;
begin
    LoadDataDocumentRetur;
end;

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.btnToVinzariClick(Sender: TObject);
var
    N: Integer;
    GoodsID: Integer;
    GoodsName: string;
    SN: string;
    QTY: Double;
    Price: Double;
begin
    tvRetur.DataController.BeginUpdate;
    tvVinzari.DataController.BeginUpdate;

    N := tvRetur.DataController.FocusedRecordIndex;

    GoodsID := tvRetur.DataController.Values[N, tvRetur_GOODSID.Index];
    GoodsName := tvRetur.DataController.Values[N, tvRetur_GOODSNAME.Index];
    SN := tvRetur.DataController.Values[N, tvRetur_SN.Index];
    QTY := tvRetur.DataController.Values[N, tvRetur_SN.Index];
    Price := tvRetur.DataController.Values[N, tvRetur_SN.Index];

    tvRetur.DataController.DeleteRecord(N);

    N := tvVinzari.DataController.AppendRecord;
    tvVinzari.DataController.Values[N, tvVinzari_GOODSID.Index] := GoodsID;
    tvVinzari.DataController.Values[N, tvVinzari_GOODSNAME.Index] := GoodsName;
    tvVinzari.DataController.Values[N, tvVinzari_SN.Index] := SN;
    tvVinzari.DataController.Values[N, tvVinzari_QTY.Index] := QTY;
    tvVinzari.DataController.Values[N, tvVinzari_PRICE.Index] := Price;

    tvVinzari.DataController.EndUpdate;
    tvRetur.DataController.EndUpdate;
end;

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.btnToReturClick(Sender: TObject);
var
    N: Integer;
    GoodsID: Integer;
    GoodsName: string;
    Price: Double;
    Qty: double;
    SN: string;
begin
    tvRetur.DataController.BeginUpdate;
    tvVinzari.DataController.BeginUpdate;

    N := tvVinzari.DataController.FocusedRecordIndex;

    GoodsID := tvVinzari.DataController.Values[N, tvRetur_GOODSID.Index];
    GoodsName := tvVinzari.DataController.Values[N, tvRetur_GOODSNAME.Index];
    Qty := tvVinzari.DataController.Values[N, tvRetur_QTY.Index];
    Price := tvVinzari.DataController.Values[N, tvRetur_PRICE.Index];
    SN := tvVinzari.DataController.Values[N, tvRetur_SN.Index];

    tvVinzari.DataController.DeleteRecord(N);

    N := tvRetur.DataController.AppendRecord;
    tvRetur.DataController.Values[N, tvRetur_GOODSID.Index] := GoodsID;
    tvRetur.DataController.Values[N, tvRetur_GOODSNAME.Index] := GoodsName;
    tvRetur.DataController.Values[N, tvRetur_SN.Index] := SN;
    tvRetur.DataController.Values[N, tvRetur_QTY.Index] := Qty;
    tvRetur.DataController.Values[N, tvRetur_PRICE.Index] := Price;

    tvVinzari.DataController.EndUpdate;
    tvRetur.DataController.EndUpdate;
end;

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.DeleteRecordsFromVinzari(ARowIndex: Integer; ARowInfo: TcxRowInfo);
begin
    tvVinzari.DataController.DeleteRecord(ARowIndex);
end;

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.PrepareCustomerInfo(ADocID: Integer);
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(nil);
    try
        q.SQL.Text := 'select ct_name, created_by_name, suma*rate suma from vw_tdb_docs where docid = :docid';
        q.ParamByName('DOCID').AsInteger := ADocID;
        q.Open;
        lbDocumentSum.Caption := Format('%2.2f', [q.FieldByName('SUMA').AsFloat]);
        lbCreatedBy.Caption := Format('%s', [q.FieldByName('CREATED_BY_NAME').AsString]);
//        lbCustomerName.Caption
    finally
        q.Free;
    end;

end;

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.UpdateSNParts(docid, dtdep, ctdep, GOODSID, QTY, Price,
    UMID, WARRANTY, GOODSCOMPLECT_ID: string; GoodsTypeID, VinzareDOCID: Integer);
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(Self);
    try
        if GoodsTypeID=4203 then
        begin
            q.SQL.Add('insert into tdb_sn (docid, dtdep, ctdep, goodscomplect_id, goodsid, sn, countryid, vendorID, warranty');
            q.sql.Add('select docid, dtdep, ctdep, goodscomplect_id, goodsid, sn, countryid, vendorid, warranty where docid=:docid');
            q.ParamByName('docid').AsInteger := VinzareDOCID;
        end
    finally
        q.Free;
    end;
end;

procedure TfrmServiceRequestWarantySelectFoodsFromDocumentDlg.WhenCancelForm;
begin
    inherited;

end;

end.

