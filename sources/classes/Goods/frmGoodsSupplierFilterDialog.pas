unit frmGoodsSupplierFilterDialog;

{ Filtru pe furnizor in nomenclatorul de produse (TfrmGoodsBrowser).
  Lista contine doar furnizorii (TS_GOODS_FOREIGN.CUSTOMERID) care au produse
  in datele afisate acum in grid - aceeasi apelare SP_GET_TS_GOODS si acelasi
  FilterSQL de baza ca in nomenclator. }

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls,
    cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
    cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
    dxScrollbarAnnotations, Data.DB, cxDBData, DBAccess, IBC, MemDS, cxGridLevel,
    cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
    cxGridDBTableView, cxGrid, Vcl.StdCtrls, Vcl.ExtCtrls, cxContainer, cxLabel;

type
    TfrmGoodsSupplierFilterDlg = class(TSWNCustomForm)
        PanelBottom: TPanel;
        btnApply: TButton;
        btnClearFilter: TButton;
        btnClose: TButton;
        lblInfo: TcxLabel;
        cxGridSuppliers: TcxGrid;
        cxGridSuppliersTable: TcxGridDBTableView;
        cxGridSuppliersTable_NAME: TcxGridDBColumn;
        cxGridSuppliersTable_CNT: TcxGridDBColumn;
        cxGridSuppliersTable_CUSTOMERID: TcxGridDBColumn;
        cxGridSuppliersLevel: TcxGridLevel;
        IBCQuerySuppliers: TIBCQuery;
        IBCDataSourceSuppliers: TIBCDataSource;
        procedure FormShow(Sender: TObject);
        procedure cxGridSuppliersTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    private
        fSourceQuery: TIBCQuery;
        fBaseFilterSQL: string;
        fSupplierID: Integer;
        fSupplierName: string;
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
    public
        constructor Create(AOwner: TComponent; ASourceQuery: TIBCQuery; const ABaseFilterSQL: string; const ACurrentSupplierID: Integer); reintroduce;
        property SupplierID: Integer read fSupplierID;
        property SupplierName: string read fSupplierName;
    end;

implementation

uses
    DataModuleDB;

{$R *.dfm}

constructor TfrmGoodsSupplierFilterDlg.Create(AOwner: TComponent; ASourceQuery: TIBCQuery; const ABaseFilterSQL: string; const ACurrentSupplierID: Integer);
begin
    inherited Create(AOwner);
    fSourceQuery := ASourceQuery;
    fBaseFilterSQL := ABaseFilterSQL;
    fSupplierID := ACurrentSupplierID;
    fSupplierName := '';
    btnClearFilter.Enabled := ACurrentSupplierID > 0;
end;

procedure TfrmGoodsSupplierFilterDlg.Prepare;
    // valoarea parametrului din grid ca literal SQL (NULL daca nu e setat)
    function SourceValue(const ParamName: string; const IsText: Boolean): string;
    var
        V: Variant;
    begin
        V := fSourceQuery.ParamByName(ParamName).Value;
        if VarIsNull(V) or VarIsEmpty(V) then
            Result := 'NULL'
        else if IsText then
            Result := QuotedStr(VarToStr(V))
        else
            Result := IntToStr(Integer(V));
    end;

begin
    IBCQuerySuppliers.Close;
    IBCQuerySuppliers.Connection := dmDB.IBCConnection;
    // fara parametri: valorile grid-ului intra ca literali (SEARCH poate contine ':')
    IBCQuerySuppliers.ParamCheck := False;
    IBCQuerySuppliers.SQL.Clear;
    IBCQuerySuppliers.SQL.Add('select f.customerid, max(c.name) name, count(distinct g.goodsid) cnt');
    IBCQuerySuppliers.SQL.Add('from (select a.goodsid');
    IBCQuerySuppliers.SQL.Add(Format('      from SP_GET_TS_GOODS(%s, %s, %s, %s, %s) a', [
        SourceValue('MODE', False), SourceValue('DT', False), SourceValue('PARENTID', False),
        SourceValue('SEARCH', True), SourceValue('FLG_ONLY_IN_PRICE', False)]));
    IBCQuerySuppliers.SQL.Add('      where a.flg_folder = 0');
    if fBaseFilterSQL <> '' then
        IBCQuerySuppliers.SQL.Add('        and (' + fBaseFilterSQL + ')');
    IBCQuerySuppliers.SQL.Add('     ) g');
    IBCQuerySuppliers.SQL.Add('join ts_goods_foreign f on f.goodsid = g.goodsid');
    IBCQuerySuppliers.SQL.Add('left join ts_customer c on c.customerid = f.customerid');
    IBCQuerySuppliers.SQL.Add('group by f.customerid');
    IBCQuerySuppliers.SQL.Add('order by 2');

    Screen.Cursor := crHourGlass;
    try
        IBCQuerySuppliers.Open;
    finally
        Screen.Cursor := crDefault;
    end;

    lblInfo.Caption := Format('Furnizorii produselor din lista curenta: %d', [IBCQuerySuppliers.RecordCount]);

    if fSupplierID > 0 then
        IBCQuerySuppliers.Locate('CUSTOMERID', fSupplierID, []);
end;

procedure TfrmGoodsSupplierFilterDlg.FormShow(Sender: TObject);
begin
    cxGridSuppliers.SetFocus;
end;

procedure TfrmGoodsSupplierFilterDlg.cxGridSuppliersTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    AHandled := True;
    ModalResult := mrOk;
end;

function TfrmGoodsSupplierFilterDlg.IsFormDataPosted: Boolean;
begin
    Result := True;
    if ModalResult <> mrOk then
        Exit;

    if IBCQuerySuppliers.IsEmpty then
    begin
        ShowMessage('Nu este selectat niciun furnizor.');
        Result := False;
        Exit;
    end;

    fSupplierID := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
    fSupplierName := Trim(IBCQuerySuppliers.FieldByName('NAME').AsString);
    if fSupplierName = '' then
        fSupplierName := IntToStr(fSupplierID);
end;

end.
