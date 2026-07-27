unit frmServiceRequestWarrantySelectGoodsFromSellDialog;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit, Vcl.Controls, Vcl.Forms,
    Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
    cxEdit, cxNavigator, cxCheckBox, Vcl.StdCtrls, cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxClasses, cxGridLevel, cxGrid,
    DialogTitle, cxLabel, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
    TfrmServiceRequestWarrantySelectGoodsFromSellDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        cxGridLevel: TcxGridLevel;
        cxGrid: TcxGrid;
        cxGridTable: TcxGridTableView;
        cxGridTable_Check: TcxGridColumn;
        cxGridTable_Title: TcxGridColumn;
        cxGridTable_SN: TcxGridColumn;
        btnOk: TButton;
        btnCancel: TButton;
        cxGridTable_Data: TcxGridColumn;
        Label1: TLabel;
        cxGridTable_GOODSID: TcxGridColumn;
        cxGridTable_Exists: TcxGridColumn;
        cxGridTable_PRICE: TcxGridColumn;
        cxGridTable_DOCID: TcxGridColumn;
        cxGridTable_Qty: TcxGridColumn;
        procedure btnOkClick(Sender: TObject);
        procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
            TcxCustomGridTableItem; var AStyle: TcxStyle);
    private    { Private declarations }
        FCustomerID: Integer;
        FDocID: Integer;
        FFlgViewOnly: Boolean;
        procedure SetCustomerID(const Value: Integer);
        procedure ReadData;
        function HasSelection: Boolean;
        function GetGoodsIDList: string;
        procedure SetDocID(const Value: Integer);
        function GetGoodsSNList: string;
        procedure SetFlgViewOnly(const Value: Boolean);
    protected
        procedure DoAddGoodsToDocument(goodsid: Integer; qty, price: double);
    { protected declarations }
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
    public    { Public declarations }
        property DocID: Integer read FDocID write SetDocID;
        property CustomerID: Integer read FCustomerID write SetCustomerID;
        property GoodsIDList: string read GetGoodsIDList;
        property GoodsSNList: string read GetGoodsSNList;
        property FlgViewOnly: Boolean read FFlgViewOnly write SetFlgViewOnly;
    end;

implementation

{$R *.dfm}

uses
    DataModuleAdditions, DataModuleDB, IBC;

procedure TfrmServiceRequestWarrantySelectGoodsFromSellDlg.btnOkClick(Sender: TObject);
var
    GoodsID: Integer;
    GoodsPrice: Double;
    GoodsQty: Double;
    i: Integer;
begin
    for i := 0 to cxGridTable.Controller.SelectedRowCount - 1 do
    begin
        GoodsID := cxGridTable.Controller.SelectedRecords[i].Values[cxGridTable_GOODSID.Index];
        GoodsQty := cxGridTable.Controller.SelectedRecords[i].Values[cxGridTable_Qty.Index];
        GoodsPrice := cxGridTable.Controller.SelectedRecords[i].Values[cxGridTable_PRICE.Index];
        DoAddGoodsToDocument(GoodsID, GoodsQty, GoodsPrice);
    end;
end;

{ TForm2 }

procedure TfrmServiceRequestWarrantySelectGoodsFromSellDlg.cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
    TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    if not VarIsNull(ARecord.Values[cxGridTable_Exists.Index]) then
    begin
        if (ARecord.Values[cxGridTable_Exists.Index] = true) then
            AStyle := dmAdditions.cxStyle_BackgroundRED;
    end;
end;

procedure TfrmServiceRequestWarrantySelectGoodsFromSellDlg.DoAddGoodsToDocument(goodsid: Integer; qty, price: double);
begin

end;

function TfrmServiceRequestWarrantySelectGoodsFromSellDlg.GetGoodsIDList: string;
var
    i: integer;
begin
    Result := '';
    for i := 0 to cxGridTable.DataController.RecordCount - 1 do
        if (cxGridTable.DataController.Values[i, cxGridTable_Check.Index] = true) // marcat
            and (cxGridTable.DataController.Values[i, cxGridTable_Exists.Index] = false) // sa nu existe
            then
        begin
            if Result <> '' then
                Result := Result + ',';
            Result := Result + IntToStr(cxGridTable.DataController.Values[i, cxGridTable_GOODSID.Index]);
        end;
end;

function TfrmServiceRequestWarrantySelectGoodsFromSellDlg.GetGoodsSNList: string;
var
    i: integer;
begin
    Result := '';
    for i := 0 to cxGridTable.DataController.RecordCount - 1 do
        if (cxGridTable.DataController.Values[i, cxGridTable_Check.Index] = true) // marcat
            and (cxGridTable.DataController.Values[i, cxGridTable_Exists.Index] = false) // sa nu existe
            then
        begin
            if Result <> '' then
                Result := Result + ',';
            Result := Result + cxGridTable.DataController.Values[i, cxGridTable_SN.Index];
        end;
end;

function TfrmServiceRequestWarrantySelectGoodsFromSellDlg.HasSelection: Boolean;
var
    i: integer;
begin
    Result := False;
    if cxGridTable.DataController.IsEditing then
        cxGridTable.DataController.PostEditingData;

    for i := 0 to cxGridTable.DataController.RecordCount - 1 do
        if (cxGridTable.DataController.Values[i, cxGridTable_Check.Index] = true) then
        begin
            Result := True;
            Break;
        end;
end;

function TfrmServiceRequestWarrantySelectGoodsFromSellDlg.IsFormDataPosted: Boolean;
begin
    Result := HasSelection;
end;

procedure TfrmServiceRequestWarrantySelectGoodsFromSellDlg.Prepare;
begin
    inherited;
    cxGridTable_Title.Focused := True;
    ReadData;
    btnOk.Enabled := not FlgViewOnly;
end;

procedure TfrmServiceRequestWarrantySelectGoodsFromSellDlg.ReadData;
var
    Query: TIBCQuery;
    N: Integer;
begin
    cxGridTable.DataController.BeginUpdate;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.SQL.Text := 'SELECT DOCID, DATA, GOODSID, TITLE, SNPN_NUMBER, QTY, FLG_EXISTS_IN_DOC, PRICE FROM SP_32_GET_GOODS_FROM_SELL(:ID,:DOC)';
        Query.ParamByName('ID').AsInteger := FCustomerID;
        Query.ParamByName('DOC').AsInteger := fDocID;
        Query.ExecSQL;
        while not Query.Eof do
        begin
            N := cxGridTable.DataController.AppendRecord;
            cxGridTable.DataController.Values[N, cxGridTable_Check.Index] := false;
            cxGridTable.DataController.Values[N, cxGridTable_Exists.Index] := Query.FieldByName('FLG_EXISTS_IN_DOC').AsInteger = 1;
            cxGridTable.DataController.Values[N, cxGridTable_Data.Index] := FormatDateTime('dd.mm.yyyy', Query.FieldByName('DATA').AsDateTime);
            cxGridTable.DataController.Values[N, cxGridTable_GOODSID.Index] := Query.FieldByName('GOODSID').AsInteger;
            cxGridTable.DataController.Values[N, cxGridTable_Title.Index] := Query.FieldByName('TITLE').AsString;
            cxGridTable.DataController.Values[N, cxGridTable_SN.Index] := Query.FieldByName('SNPN_NUMBER').AsString;
            cxGridTable.DataController.Values[N, cxGridTable_Qty.Index] := Query.FieldByName('QTY').AsString;
            cxGridTable.DataController.Values[N, cxGridTable_PRICE.Index] := Query.FieldByName('PRICE').AsString;
            cxGridTable.DataController.Values[N, cxGridTable_DOCID.Index] := Query.FieldByName('DOCID').AsString;
            Query.Next;
        end;
    finally
        Query.Free;
        cxGridTable.DataController.EndUpdate;
    end;
end;

procedure TfrmServiceRequestWarrantySelectGoodsFromSellDlg.SetCustomerID(const Value: Integer);
begin
    FCustomerID := Value;
end;

procedure TfrmServiceRequestWarrantySelectGoodsFromSellDlg.SetDocID(const Value: Integer);
begin
    FDocID := Value;
end;

procedure TfrmServiceRequestWarrantySelectGoodsFromSellDlg.SetFlgViewOnly(const Value: Boolean);
begin
    FFlgViewOnly := Value;
end;

end.

