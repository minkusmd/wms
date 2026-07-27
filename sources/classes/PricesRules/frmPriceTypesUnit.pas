unit frmPriceTypesUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
    cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, Vcl.Menus, dxBar, cxClasses,
    Vcl.StdCtrls, cxButtons, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBAccess, IBC,
    MemDS, dxBarBuiltInMenu, cxPC, DialogTitle, Vcl.ExtCtrls, dxDateRanges, cxCalc, dxScrollbarAnnotations, cxCheckBox,
  cxTL, cxTextEdit, cxMaskEdit, cxTLdxBarBuiltInMenu, System.ImageList, Vcl.ImgList, cxImageList, cxInplaceContainer,
  cxDBTL, cxTLData, dxUIAClasses;

type
    TfrmPriceTypesDlg = class(TSWNBaseFormClass)
        cxButton1: TcxButton;
        dxBarManager1: TdxBarManager;
        dxBarManager1Bar1: TdxBar;
        dxBarButton1: TdxBarButton;
        dxBarButton2: TdxBarButton;
        dxBarButton3: TdxBarButton;
        IBCQueryPriceTypes: TIBCQuery;
        IBCDataSourcePriceTypes: TIBCDataSource;
        IBCTrLocalUpdate: TIBCTransaction;
        IBCQueryPriceRules: TIBCQuery;
        IBCDataSourcePriceRules: TIBCDataSource;
        IBCQueryGoodsInPrice: TIBCQuery;
        IBCDataSourceGoodsInPrice: TIBCDataSource;
        dxBarSubItem1: TdxBarSubItem;
        dxBarButton5: TdxBarButton;
        dxBarManager1Bar2: TdxBar;
        bbprNew: TdxBarButton;
        bbprEdit: TdxBarButton;
        bbprDelete: TdxBarButton;
        bbImport: TdxBarButton;
        Panel1: TPanel;
        cxGrid2: TcxGrid;
        cxGridDBTableView1: TcxGridDBTableView;
        cxGridDBColumn1: TcxGridDBColumn;
        cxGridDBColumn2: TcxGridDBColumn;
        cxGrid1DBTableView1Column3: TcxGridDBColumn;
        cxGrid1DBTableView1Column4: TcxGridDBColumn;
        cxGridLevel1: TcxGridLevel;
        dxBarDockControl1: TdxBarDockControl;
        DialogTitle1: TDialogTitle;
        dxBarButton6: TdxBarButton;
        Panel3: TPanel;
        cxGrid3: TcxGrid;
        cxGrid3DBTableView1: TcxGridDBTableView;
        cxGrid3DBTableView1_GOODSID: TcxGridDBColumn;
        cxGrid3DBTableView1_GOODSNAME: TcxGridDBColumn;
        cxGrid3DBTableView1Column1: TcxGridDBColumn;
        cxGrid3Level1: TcxGridLevel;
        dxBarManager1Bar3: TdxBar;
        bbSupplierNew: TdxBarButton;
        bbSupplierDelete: TdxBarButton;
        IBCQuerySuppliers: TIBCQuery;
        IBCDataSourceSuppliers: TIBCDataSource;
        dxBarButton7: TdxBarButton;
        dxBarSubItem2: TdxBarSubItem;
        bbDuplicateRules: TdxBarButton;
        bbImportFromDefaultSupplier: TdxBarButton;
        cxGridDBTableView1_ADJUST: TcxGridDBColumn;
        cxGridDBTableView1_MIN_MARGIN: TcxGridDBColumn;
        cxGridDBTableView1_ROUND_UP: TcxGridDBColumn;
    IBCQuerySupplierGroups: TIBCQuery;
    IBCDataSourceSupplierGroups: TIBCDataSource;
    cxGrid3DBTableView1Column2: TcxGridDBColumn;
    cxGrid3DB_VENDORNAME: TcxGridDBColumn;
    btnFilterGoods: TdxBarButton;
    cxGridDBTableView1_MIN_MARGIN_PERCENT: TcxGridDBColumn;
    Panel4: TPanel;
    dxBarDockControl3: TdxBarDockControl;
    cxGridSupplier: TcxGrid;
    cxGridSupplierDBTableView1: TcxGridDBTableView;
    cxGridSupplierDBTableView1SUPPLIER_NAME: TcxGridDBColumn;
    cxGridSupplierLevel1: TcxGridLevel;
    cxGrid3DBTableView1_PRICE5_MDL: TcxGridDBColumn;
    cxGrid3DBTableView1_PRICE6_MDL: TcxGridDBColumn;
    cxGrid3DBTableView1_PRICE7_MDL: TcxGridDBColumn;
    cxGrid3DBTableView1_CURRENCY7ID: TcxGridDBColumn;
    cxGrid3DBTableView1_CURRENCY6ID: TcxGridDBColumn;
    cxGrid3DBTableView1_CURRENCY5ID: TcxGridDBColumn;
    cxGrid3DBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    cxPageControl1: TcxPageControl;
    tbsOld: TcxTabSheet;
    Panel2: TPanel;
    dxBarDockControl2: TdxBarDockControl;
    tbsTree: TcxTabSheet;
    cxDBTreeList1: TcxDBTreeList;
    cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn3: TcxDBTreeListColumn;
    cxImageList1: TcxImageList;
    dxBarDockControl4: TdxBarDockControl;
    dxBarManager1Bar4: TdxBar;
    bbNewFolder: TdxBarButton;
    bbNewItem: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    bbChangeParent: TdxBarButton;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    IBCQueryPoliciesTree: TIBCQuery;
    IBCDataSourcePoliciesTree: TIBCDataSource;
    cxGrid3DBTableView1Column3: TcxGridDBColumn;
        procedure dxBarButton1Click(Sender: TObject);
        procedure dxBarButton2Click(Sender: TObject);
        procedure dxBarButton3Click(Sender: TObject);
        procedure dxBarButton5Click(Sender: TObject);
        procedure bbprNewClick(Sender: TObject);
        procedure bbprEditClick(Sender: TObject);
        procedure bbprDeleteClick(Sender: TObject);
        procedure bbImportClick(Sender: TObject);
        procedure dxBarButton6Click(Sender: TObject);
        procedure bbSupplierNewClick(Sender: TObject);
        procedure dxBarButton7Click(Sender: TObject);
        procedure bbDuplicateRulesClick(Sender: TObject);
        procedure bbImportFromDefaultSupplierClick(Sender: TObject);
        procedure bbSupplierDeleteClick(Sender: TObject);
        procedure cxGrid3DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFilterGoodsClick(Sender: TObject);
    procedure bbNewFolderClick(Sender: TObject);
    procedure cxGrid1DBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure FormShow(Sender: TObject);
        procedure IBCQueryPriceTypesAfterInsert(DataSet: TDataSet);
    private
        FGoodsID: Integer;
        FPGT_ID: Integer;
        procedure SetGoodsID(const Value: Integer);
        procedure SetPGT_ID(const Value: Integer);
    { Private declarations }
    protected
        procedure DoImPORTFromDefaultSupplier;
        procedure Prepare; override;
        procedure UpdateGoodsTable;
    public
        procedure CreateNewFolderDialog(ParentID: integer);
        procedure CreateNewFolderDialog1(CurrentFolderID: Integer);
        property GoodsID: Integer read FGoodsID write SetGoodsID;
    { Public declarations }
        property PGT_ID: Integer read FPGT_ID write SetPGT_ID;
    end;

var
    frmPriceTypesDlg: TfrmPriceTypesDlg;

implementation

uses
    DataModuleAdditions, frmPriceTypesEditorUnit, DataModuleDB, frmPriceRulesEditorUnit, SWNUtils, frmPriceTypesHistoryUnit, frmGoods,
    frmCustomersDlg, System.UITypes,
  frmPricePolicyFolderUnit;

{$R *.dfm}

procedure TfrmPriceTypesDlg.bbDuplicateRulesClick(Sender: TObject);
begin
    dmDB.AppendCurrentRecord(IBCQueryPriceRules);
end;

procedure TfrmPriceTypesDlg.bbImportClick(Sender: TObject);
var
    OLD_PGT: string;
begin
    if ShowAskDialog('Tipuri de preturi', 'Datele curente din politica de preturi vor fi sterse! Continuam ?') = mrYes then
    begin
        if InputQuery('Codul politiicii pentru tipul produsului:', 'Cod: ', OLD_PGT) then
        begin
            dmDB.ExecuteQuery('execute procedure SP_IMPORT_PRICE_RULES(:old_pgt, :new_pgt, :old_supplierid, :new_supplierid)', [OLD_PGT.ToInteger,
                IBCQueryPriceTypes.FieldByName('PGT_ID').AsInteger, -1, IBCQuerySuppliers.FieldByName('SUPPLIERID').AsInteger]);
            IBCQueryPriceRules.Refresh;
        end;
    end;
end;

procedure TfrmPriceTypesDlg.bbImportFromDefaultSupplierClick(Sender: TObject);
begin
    DoImPORTFromDefaultSupplier
end;

procedure TfrmPriceTypesDlg.bbNewFolderClick(Sender: TObject);
begin
  inherited;
  CreateNewFolderDialog(IBCQueryPriceTypes.FieldByName('PGT_ID').AsInteger);
end;

procedure TfrmPriceTypesDlg.bbprDeleteClick(Sender: TObject);
begin
    if ShowAskDialog('Tipuri de preturi', 'Stergeti inregistrarea?') = mrYes then
        IBCQueryPriceRules.Delete;
end;

procedure TfrmPriceTypesDlg.bbprEditClick(Sender: TObject);
var
    dialog: TfrmPriceRulesEditorDlg;
begin
    dialog := TfrmPriceRulesEditorDlg.Create(Self, IBCQueryPriceRules, IBCDataSourcePriceRules);
    try
        dialog.IsNewRecord := False;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmPriceTypesDlg.bbprNewClick(Sender: TObject);
var
    dialog: TfrmPriceRulesEditorDlg;
begin
    dialog := TfrmPriceRulesEditorDlg.Create(Self, IBCQueryPriceRules, IBCDataSourcePriceRules);
    try
        dialog.IsNewRecord := True;
        dialog.PGT_ID := IBCQueryPriceTypes.FieldByName('PGT_ID').AsInteger;
        dialog.SupplierID := IBCQuerySuppliers.FieldByName('SUPPLIERID').AsInteger;
        dialog.LastPriceColumn := IBCQueryPriceRules.FieldByName('PRICECOLUMN').AsInteger;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmPriceTypesDlg.bbSupplierDeleteClick(Sender: TObject);
begin
    inherited;
    if MessageDlg('Sterge furnizorul ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        IBCQuerySuppliers.Delete;
end;

procedure TfrmPriceTypesDlg.bbSupplierNewClick(Sender: TObject);
var
    dialog: TfrmCustomersDlg;
begin
    dialog := TfrmCustomersDlg.Create(Self);
    try
        if dialog.SelectCustomer(IBCQuerySuppliers.FieldByName('SUPPLIERID').AsInteger, False, 0, 'Selecteaza furnizorul') then
        begin
            IBCQuerySuppliers.Append;
            IBCQuerySuppliers.FieldByName('SUPPLIERID').AsInteger := dialog.CustomerID;
            IBCQuerySuppliers.FieldByName('SUPPLIER_NAME').AsString := dialog.CustomerTitle;
            IBCQuerySuppliers.Post;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmPriceTypesDlg.btnFilterGoodsClick(Sender: TObject);
begin
  inherited;
  UpdateGoodsTable;
end;

procedure TfrmPriceTypesDlg.CreateNewFolderDialog(ParentID: integer);
var
  d: TfrmPricePolicyFolderDlg;
begin
  d := TfrmPricePolicyFolderDlg.Create(self);
  try
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmPriceTypesDlg.CreateNewFolderDialog1(CurrentFolderID: Integer);
begin
  // add new folder to price policy

end;

procedure TfrmPriceTypesDlg.cxGrid1DBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  if Arecord.Values[cxGrid1DBTableView1Column1.Index] = -1 then
  AStyle := dmAdditions.cxStyle_TextBoldRed;

end;

procedure TfrmPriceTypesDlg.cxGrid3DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    ProcessCommonKeys(Self, cxGrid3DBTableView1, Key, Shift);
end;

procedure TfrmPriceTypesDlg.DoImPORTFromDefaultSupplier;
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(self);
    try
        Query.SQL.Text := 'SELECT * FROM TPRICE_GOODSTYPE WHERE PGT_ID=:PGT_ID AND SUPPLIERID = -1 ORDER BY PRICECOLUMN, MIN_VALUE';
        Query.ParamByName('PGT_ID').AsInteger := IBCQuerySuppliers.FieldByName('PGT_ID').AsInteger;
        Query.Open;
        while not Query.Eof do
        begin
            with IBCQueryPriceRules do
            begin
                Append;
                FieldByName('PRICECOLUMN').AsInteger := Query.FieldByName('PRICECOLUMN').AsInteger;
                FieldByName('MIN_VALUE').AsInteger := Query.FieldByName('MIN_VALUE').AsInteger;
                FieldByName('MAX_VALUE').AsInteger := Query.FieldByName('MAX_VALUE').AsInteger;
                FieldByName('FORMULA').AsString := Query.FieldByName('FORMULA').AsString;
                FieldByName('MIN_MARGIN').AsInteger := Query.FieldByName('MIN_MARGIN').AsInteger;
                FieldByName('ROUND_UP').AsFloat := Query.FieldByName('ROUND_UP').AsFloat;
                FieldByName('ADJUST').AsInteger := Query.FieldByName('ADJUST').AsInteger;
//                FieldByName('GROUPSUPPLIERID').AsInteger := -1;
                Post;
            end;
            Query.Next;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmPriceTypesDlg.dxBarButton1Click(Sender: TObject);
var
    dialog: TfrmPriceTypesEditorDlg;
begin
    dialog := TfrmPriceTypesEditorDlg.Create(self, IBCQueryPriceTypes, IBCDataSourcePriceTypes);
    try
        dialog.IsNewRecord := True;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmPriceTypesDlg.dxBarButton2Click(Sender: TObject);
var
    dialog: TfrmPriceTypesEditorDlg;
begin
    dialog := TfrmPriceTypesEditorDlg.Create(self, IBCQueryPriceTypes, IBCDataSourcePriceTypes);
    try
        dialog.IsNewRecord := False;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmPriceTypesDlg.dxBarButton3Click(Sender: TObject);
begin
    if ShowAskDialog('Tipuri de preturi', 'Stergeti inregistrarea?') = mrYes then
        IBCQueryPriceTypes.Delete;
end;

procedure TfrmPriceTypesDlg.dxBarButton5Click(Sender: TObject);
begin
    dmDB.ExecuteQuery('EXECUTE PROCEDURE UPDATE_PRICES_WITH_RULE(:PGT_ID)', [IBCQueryPriceTypes.FieldByName('PGT_ID').AsInteger]);
end;

procedure TfrmPriceTypesDlg.dxBarButton6Click(Sender: TObject);
var
    dialog: TfrmPriceTypesHistoryDlg;
begin
    dialog := TfrmPriceTypesHistoryDlg.Create(Self, IBCQueryPriceRules, IBCDataSourcePriceRules);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmPriceTypesDlg.dxBarButton7Click(Sender: TObject);
begin
    with IBCQuerySuppliers do
    begin
        Append;
        FieldByName('SUPPLIERID').AsInteger := -1;
        Post;
        Refresh;
    end;
end;

procedure TfrmPriceTypesDlg.FormShow(Sender: TObject);
begin
  cxGrid1.SetFocus;
  cxPageControl1.ActivePageIndex := 0;
end;

procedure TfrmPriceTypesDlg.IBCQueryPriceTypesAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('PARENTID').AsInteger := 1;
  DataSet.FieldByName('FLG_FOLDER').AsInteger := 1;
end;

procedure TfrmPriceTypesDlg.Prepare;
begin
    IBCQueryPriceTypes.Transaction := fIBCConnection.DefaultTransaction;
    IBCTrLocalUpdate.DefaultConnection := fIBCConnection;
    IBCQueryPriceTypes.Open;
    IBCQueryPriceRules.Close;
    IBCQueryPriceRules.Open;

    IBCQueryPriceTypes.Locate('PGT_ID', PGT_ID, []);
    IBCQuerySuppliers.Active := True;
    IBCQuerySupplierGroups.Active := True;
    
end;

procedure TfrmPriceTypesDlg.SetGoodsID(const Value: Integer);
begin
    FGoodsID := Value;
end;

procedure TfrmPriceTypesDlg.SetPGT_ID(const Value: Integer);
begin
    FPGT_ID := Value;
end;

procedure TfrmPriceTypesDlg.UpdateGoodsTable;
begin
  if (IBCQueryPriceRules.Active) and (IBCQueryPriceRules.FieldByName('MAX_VALUE').AsInteger > 0) then
  begin
    IBCQueryGoodsInPrice.Close;
    IBCQueryGoodsInPrice.ParamByName('PGT_ID').AsInteger := IBCQueryPriceTypes.FieldByName('PGT_ID').AsInteger;
    IBCQueryGoodsInPrice.ParamByName('MIN_VALUE').AsInteger := IBCQueryPriceRules.FieldByName('MIN_VALUE').AsInteger;
    IBCQueryGoodsInPrice.ParamByName('MAX_VALUE').AsInteger := IBCQueryPriceRules.FieldByName('MAX_VALUE').AsInteger;
    IBCQueryGoodsInPrice.Open;
  end;
end;

end.

