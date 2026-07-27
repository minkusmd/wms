unit frmGoodsGroupsEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, SWNBaseUnit, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxPCdxBarPopupMenu, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData, dxBar,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxMemo, cxDBEdit, cxTextEdit,
  Vcl.StdCtrls, cxPC, DBAccess, IBC, MemDS, cxImageComboBox, dxBarBuiltInMenu,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmGoodsGroupsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pcPageControl: TcxPageControl;
    tbsGeneral: TcxTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    edTITLE: TcxDBTextEdit;
    mmDESCRIPTION: TcxDBMemo;
    tbsGoodsTypes: TcxTabSheet;
    tbsVendors: TcxTabSheet;
    tbsGoodsList: TcxTabSheet;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    cxGridTypesTable: TcxGridDBTableView;
    cxGridTypesLevel: TcxGridLevel;
    cxGridTypes: TcxGrid;
    bbGT_New: TdxBarButton;
    bbGT_Delete: TdxBarButton;
    cxGridVendorsTable: TcxGridDBTableView;
    cxGridVendorsLevel: TcxGridLevel;
    cxGridVendors: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    dxBarDockControl2: TdxBarDockControl;
    dxBarDockControl3: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    bbVendor_New: TdxBarButton;
    bbVendor_Delete: TdxBarButton;
    bbGL_New: TdxBarButton;
    bbGL_Delete: TdxBarButton;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryGT: TIBCQuery;
    IBCDataSourceGT: TIBCDataSource;
    cxGridTypesTable_GOODSTYPEID: TcxGridDBColumn;
    cxGridTypesTable_GOODSTYPE_TITLE: TcxGridDBColumn;
    cxGridTypesTable_CREATED_BY_NAME: TcxGridDBColumn;
    IBCQueryVendors: TIBCQuery;
    IBCDataSourceVendors: TIBCDataSource;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGridVendorsTable_VENDORID: TcxGridDBColumn;
    cxGridVendorsTable_VENDOR_TITLE: TcxGridDBColumn;
    cxGridVendorsTable_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridGoodsTable_GOODS_NAME: TcxGridDBColumn;
    cxGridGoodsTable_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridGoodsTable_GOODSID: TcxGridDBColumn;
    cxGridTypesTable_IMG: TcxGridDBColumn;
    cxGridVendorsTable_IMG: TcxGridDBColumn;
    cxGridGoodsTable_FLG_FOLDER: TcxGridDBColumn;
    cxGridGoodsTable_IMG: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    tbsSupplier: TcxTabSheet;
    dxBarManager1Bar4: TdxBar;
    bbNewSupplier: TdxBarButton;
    bbDeleteSupplier: TdxBarButton;
    dxBarDockControl4: TdxBarDockControl;
    cxGridSupplier: TcxGrid;
    cxGridSupplierTableView: TcxGridDBTableView;
    cxGridSupplierTableView_SUPPLIERID: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridSupplierLevel: TcxGridLevel;
    IBCQuerySuppliers: TIBCQuery;
    IBCDataSourceSuppliers: TIBCDataSource;
    procedure cxGridTypesTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridTypesTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridVendorsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbGT_DeleteClick(Sender: TObject);
    procedure bbVendor_DeleteClick(Sender: TObject);
    procedure bbGL_DeleteClick(Sender: TObject);
    procedure bbGT_NewClick(Sender: TObject);
    procedure bbVendor_NewClick(Sender: TObject);
    procedure bbGL_NewClick(Sender: TObject);
    procedure cxGridGoodsTable_GOODS_NAMEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure bbNewSupplierClick(Sender: TObject);
    procedure bbDeleteSupplierClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);

    function CheckValues:Boolean;

    procedure GoodsTypeSelectionChanged;
    procedure VendorSelectionChanged;
    procedure GoodsListSelectionChanged;

    procedure WhenVerifyGoodsExsists(const GoodsID:Integer; var Exists:Boolean);
    procedure WhenVerifyGoodsTypeExists(const GoodsTypeID:Integer; var Exists:Boolean);
    procedure WhenVerifyVendorExists(const VendorID:Integer; var Exists:Boolean);
    procedure WhenVerifySupplierExists(const SupplierID: Integer; var Exists: Boolean);
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    procedure SupplierSelectionChanged;
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, SWNConst, SWNUtils, SWNDBErrors, frmGoodsGroupGoodsTypeEditorDialog, frmGoodsGroupVendorEditorDialog,
  frmGoodsGroupGoodsEditorDialog, frmGoodsGroupSupplierEditorDialog, vcl.Clipbrd;

{ TfrmGoodsGroupsEditorDlg }

procedure TfrmGoodsGroupsEditorDlg.bbDeleteSupplierClick(Sender: TObject);
begin
   if ShowAskDialog('Furnizor',
                    Format('Doriti sa stergeti furnizorul "%s"?',[IBCQuerySuppliers.FieldByName('SUPPLIER_NAME').AsString])
                   )<>mrYes then Exit;

   try
      IBCQuerySuppliers.Delete;
   except on E:Exception do
      if Not ProcessSWNError(E) then raise;
   end;
end;

procedure TfrmGoodsGroupsEditorDlg.bbGL_DeleteClick(Sender: TObject);
begin
     if ShowAskDialog('Producator',
                      Format('Stergeti produsul "%s"?',[IBCQueryGoods.FieldByName('GOODS_NAME').AsString])
                     )<>mrYes then Exit;

     try
        IBCQueryGoods.Delete;
     except on E:Exception do
        if Not ProcessSWNError(E) then raise;
     end;
end;

procedure TfrmGoodsGroupsEditorDlg.bbGL_NewClick(Sender: TObject);
var dialog:TfrmGoodsGroupGoodsEditorDlg;
begin
     dialog:=TfrmGoodsGroupGoodsEditorDlg.Create(Self,IBCQueryGoods,IBCDataSourceGoods);
     try
        dialog.CreateNewRecord:=True;
        dialog.GGID:=fMasterDataSet.FieldByName('GG_ID').AsInteger;
        dialog.OnVerifyGoodsExsists:=WhenVerifyGoodsExsists;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsGroupsEditorDlg.bbGT_DeleteClick(Sender: TObject);
begin
     if ShowAskDialog('Tipuri de produse',
                      Format('Doriti sa stergeti tipul de produse "%s"?',[IBCQueryGT.FieldByName('GOODSTYPE_TITLE').AsString])
                     )<>mrYes then Exit;

     try
        IBCQueryGT.Delete;
     except on E:Exception do
        if Not ProcessSWNError(E) then raise;
     end;
end;

procedure TfrmGoodsGroupsEditorDlg.bbGT_NewClick(Sender: TObject);
var dialog:TfrmGoodsGroupGoodsTypeEditorDlg;
begin
     dialog:=TfrmGoodsGroupGoodsTypeEditorDlg.Create(Self,IBCQueryGT,IBCDataSourceGT);
     try
        dialog.CreateNewRecord:=True;
        dialog.GGID:=fMasterDataSet.FieldByName('GG_ID').AsInteger;
        dialog.OnVerifyGoodsTypeExists:=WhenVerifyGoodsTypeExists;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsGroupsEditorDlg.bbNewSupplierClick(Sender: TObject);
var dialog:TfrmGoodsGroupSupplierEditorDlg;
begin
     dialog:=TfrmGoodsGroupSupplierEditorDlg.Create(Self,IBCQuerySuppliers,IBCDataSourceSuppliers);
     try
        dialog.CreateNewRecord:=True;
        dialog.GGID:=fMasterDataSet.FieldByName('GG_ID').AsInteger;
        dialog.OnVerifySupplierExists:=WhenVerifySupplierExists;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
//     IBCQuerySuppliers.Refresh;
end;

procedure TfrmGoodsGroupsEditorDlg.bbVendor_DeleteClick(Sender: TObject);
begin
     if ShowAskDialog('Producator',
                      Format('Doriti sa stergeti producatorul "%s"?',[IBCQueryVendors.FieldByName('VENDOR_TITLE').AsString])
                     )<>mrYes then Exit;

     try
        IBCQueryVendors.Delete;
     except on E:Exception do
        if Not ProcessSWNError(E) then raise;
     end;
end;

procedure TfrmGoodsGroupsEditorDlg.bbVendor_NewClick(Sender: TObject);
var dialog:TfrmGoodsGroupVendorEditorDlg;
begin
     dialog:=TfrmGoodsGroupVendorEditorDlg.Create(Self,IBCQueryVendors,IBCDataSourceVendors);
     try
        dialog.CreateNewRecord:=True;
        dialog.GGID:=fMasterDataSet.FieldByName('GG_ID').AsInteger;
        dialog.OnVerifyVendorExists:=WhenVerifyVendorExists;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

function TfrmGoodsGroupsEditorDlg.CheckValues: Boolean;
var Errors:String;
begin
     Result:=False;
     Errors:='';

     if fMasterDataSet.FieldByName('TITLE').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE').asString)='') then AddErrorToStr(Errors,'Denumirea!');

     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure TfrmGoodsGroupsEditorDlg.cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsListSelectionChanged;
end;

procedure TfrmGoodsGroupsEditorDlg.cxGridGoodsTable_GOODS_NAMEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if VarIsNumeric(ARecord.Values[cxGridGoodsTable_FLG_FOLDER.Index]) then
     begin
          if ARecord.Values[cxGridGoodsTable_FLG_FOLDER.Index]=1 then AStyle:=dmAdditions.cxStyle_Bold;
     end;
end;

procedure TfrmGoodsGroupsEditorDlg.cxGridTypesTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color:=$E8E8E8;
end;

procedure TfrmGoodsGroupsEditorDlg.cxGridTypesTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsTypeSelectionChanged;
end;

procedure TfrmGoodsGroupsEditorDlg.cxGridVendorsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     VendorSelectionChanged;
end;

procedure TfrmGoodsGroupsEditorDlg.dxBarButton1Click(Sender: TObject);
var
  list: TSTringList;
  I: Integer;
begin
  list := TSTringList.Create;
  try
    list.Text := Clipboard.AsText;
    for I := 0 to list.count-1 do
    begin
      IBCQueryGoods.Append;
      IBCQueryGoods.FieldByName('GoodsID').AsString := list[i];
      ibcqueryGoods.FieldByName('FLG_EXCLUDE').AsInteger := 0;
      IBCQueryGoods.Post;
    end;
  finally
    list.Free;
  end;
end;

procedure TfrmGoodsGroupsEditorDlg.GoodsListSelectionChanged;
var fDelete:Boolean;
begin
     fDelete:=False;
     if cxGridGoodsTable.DataController.RecNo>0 then
     begin
          fDelete:=True;
     end;
     bbGL_Delete.Enabled:=fDelete;
end;

procedure TfrmGoodsGroupsEditorDlg.GoodsTypeSelectionChanged;
var fDelete:Boolean;
begin
     fDelete:=False;
     if cxGridTypesTable.DataController.RecNo>0 then
     begin
          fDelete:=True;
     end;
     bbGT_Delete.Enabled:=fDelete;
end;

procedure TfrmGoodsGroupsEditorDlg.BindingDataSource;
begin
     // Общие
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     mmDESCRIPTION.DataBinding.DataSource:=fMasterDataSource;
     // Тип товара
     IBCQueryGT.MasterSource:=fMasterDataSource;
     IBCQueryGT.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryGT.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
     // Производитель
     IBCQueryVendors.MasterSource:=fMasterDataSource;
     IBCQueryVendors.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryVendors.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
     // Список товаров
     IBCQueryGoods.MasterSource:=fMasterDataSource;
     IBCQueryGoods.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryGoods.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
     // ПОСТАВЩИК
     IBCQuerySuppliers.MasterSource:=fMasterDataSource;
     IBCQuerySuppliers.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQuerySuppliers.UpdateTransaction:=fMasterDataSet.UpdateTransaction;

end;

function TfrmGoodsGroupsEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmGoodsGroupsEditorDlg.Prepare;
begin
     pcPageControl.ActivePage:=tbsGeneral;
     cxGridTypesTable_GOODSTYPE_TITLE.Focused:=True;
     cxGridVendorsTable_VENDOR_TITLE.Focused:=True;
     cxGridGoodsTable_GOODS_NAME.Focused:=True;

     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             tbsGoodsTypes.Enabled:=False;
             tbsVendors.Enabled:=False;
             tbsGoodsList.Enabled:=False;
             tbsSupplier.Enabled := False;

             dtDialogTitle.Text:='Crearea unei grupe noi';
             fMasterDataSet.Insert;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare';
             fMasterDataSet.Edit;

             // open data
             IBCQueryGT.Active:=True;
             IBCQueryVendors.Active:=True;
             IBCQueryGoods.Active:=True;
             IBCQuerySuppliers.Active := True;

             // selection update
             GoodsTypeSelectionChanged;
             VendorSelectionChanged;
             GoodsListSelectionChanged;
             SupplierSelectionChanged;
        end;
     except
        fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;

end;

procedure TfrmGoodsGroupsEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmGoodsGroupsEditorDlg.SupplierSelectionChanged;
var
   fDelete:Boolean;
begin
     fDelete:=False;
     if cxGridSupplierTableView.DataController.RecNo>0 then
     begin
          fDelete:=True;
     end;
     bbDeleteSupplier.Enabled:=fDelete;
end;

procedure TfrmGoodsGroupsEditorDlg.VendorSelectionChanged;
var fDelete:Boolean;
begin
     fDelete:=False;
     if cxGridVendorsTable.DataController.RecNo>0 then
     begin
          fDelete:=True;
     end;
     bbVendor_Delete.Enabled:=fDelete;
end;

procedure TfrmGoodsGroupsEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmGoodsGroupsEditorDlg.WhenVerifyGoodsExsists(const GoodsID: Integer; var Exists: Boolean);
var i:integer;
begin
     Exists:=False;
     for i := 0 to cxGridGoodsTable.DataController.RecordCount-1 do
     if (i<>cxGridGoodsTable.DataController.EditingRecordIndex) and (cxGridGoodsTable.DataController.Values[i,cxGridGoodsTable_GOODSID.Index]=GoodsID) then
     begin
          Exists:=True;
          Break;
     end;
end;

procedure TfrmGoodsGroupsEditorDlg.WhenVerifyGoodsTypeExists(const GoodsTypeID: Integer; var Exists: Boolean);
var i:integer;
begin
     Exists:=False;
     for i := 0 to cxGridTypesTable.DataController.RecordCount-1 do
     if (i<>cxGridTypesTable.DataController.EditingRecordIndex) and (cxGridTypesTable.DataController.Values[i,cxGridTypesTable_GOODSTYPEID.Index]=GoodsTypeID) then
     begin
          Exists:=True;
          Break;
     end;
end;

procedure TfrmGoodsGroupsEditorDlg.WhenVerifyVendorExists(const VendorID: Integer; var Exists: Boolean);
var i:integer;
begin
     Exists:=False;
     for i := 0 to cxGridVendorsTable.DataController.RecordCount-1 do
     if (i<>cxGridVendorsTable.DataController.EditingRecordIndex) and (cxGridVendorsTable.DataController.Values[i,cxGridVendorsTable_VENDORID.Index]=VendorID) then
     begin
          Exists:=True;
          Break;
     end;
end;

procedure TfrmGoodsGroupsEditorDlg.WhenVerifySupplierExists(const SupplierID: Integer; var Exists: Boolean);
var i:integer;
begin
     Exists:=False;
     for i := 0 to cxGridSupplierTableView.DataController.RecordCount-1 do
     if (i<>cxGridSupplierTableView.DataController.EditingRecordIndex) and (cxGridSupplierTableView.DataController.Values[i,cxGridSupplierTableView_SUPPLIERID.Index]=SupplierID) then
     begin
          Exists:=True;
          Break;
     end;
end;


end.
