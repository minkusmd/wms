unit frmWebShopsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar, StdCtrls,
  IBC, cxCheckBox, cxNavigator, Vcl.Menus, cxButtons, cxCustomData, cxFilter, cxData, dxDateRanges,
  dxScrollbarAnnotations, DBAccess, MemDS;

type
  TfrmWebShopsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    pnCity: TPanel;
    pnShop: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    cxGridCityTable: TcxGridDBTableView;
    cxGridCityLeve: TcxGridLevel;
    cxGridCity: TcxGrid;
    cxGridShopTable: TcxGridDBTableView;
    cxGridShopLevel: TcxGridLevel;
    cxGridShop: TcxGrid;
    dxBarManagerBar1: TdxBar;
    dxBarManagerBar2: TdxBar;
    bbCity_New: TdxBarButton;
    bbCity_Modify: TdxBarButton;
    bbCity_Delete: TdxBarButton;
    bbCity_Sort: TdxBarButton;
    bbShop_New: TdxBarButton;
    bbShop_Modify: TdxBarButton;
    bbShop_Delete: TdxBarButton;
    bbShop_Sort: TdxBarButton;
    IBCQueryCity: TIBCQuery;
    IBCDataSourceCity: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGridCity_CITYID: TcxGridDBColumn;
    cxGridCity_CITY_TITLE: TcxGridDBColumn;
    cxGridCity_TELEFOANE: TcxGridDBColumn;
    cxGridCity_EMAIL: TcxGridDBColumn;
    cxGridCity_ORDERNO: TcxGridDBColumn;
    IBCQueryShop: TIBCQuery;
    IBCDataSourceShop: TIBCDataSource;
    cxGridShop_CUSTOMER_NAME: TcxGridDBColumn;
    cxGridShop_ADRESA: TcxGridDBColumn;
    cxGridShop_TELEFOANE: TcxGridDBColumn;
    cxGridShop_FAX: TcxGridDBColumn;
    cxGridShop_EMAIL: TcxGridDBColumn;
    cxGridShop_ORDERNO: TcxGridDBColumn;
    cxGridShopTableColumn1: TcxGridDBColumn;
    btnClose: TcxButton;
    procedure cxGridCityTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridShopTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbCity_NewClick(Sender: TObject);
    procedure bbCity_ModifyClick(Sender: TObject);
    procedure bbCity_DeleteClick(Sender: TObject);
    procedure bbCity_SortClick(Sender: TObject);
    procedure bbShop_NewClick(Sender: TObject);
    procedure bbShop_ModifyClick(Sender: TObject);
    procedure cxGridCityTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure cxGridShopTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
  private
    { Private declarations }
    procedure Selection_City_Changed;
    procedure Selection_Shop_Changed;

    procedure ShowAddNewCityDialog;
    procedure ShowModifyCityDialog;
    procedure DeleteCity;
    procedure ShowSortCityDialog;

    procedure ShowAddNewShopDialog;
    procedure ShowModifyShopDialog;
    procedure DeleteShop;
    procedure ShowSortShopsDialog;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
  end;

implementation

uses DataModuleDB, frmCityEditorDialog, SWNUtils, SWNDBErrors, frmMagazinEditorDialog;

{$R *.dfm}

procedure TfrmWebShopsDlg.bbCity_DeleteClick(Sender: TObject);
begin
     DeleteCity;
end;

procedure TfrmWebShopsDlg.bbCity_ModifyClick(Sender: TObject);
begin
     ShowModifyCityDialog;
end;

procedure TfrmWebShopsDlg.bbCity_NewClick(Sender: TObject);
begin
     ShowAddNewCityDialog;
end;

procedure TfrmWebShopsDlg.bbCity_SortClick(Sender: TObject);
begin
     ShowSortCityDialog;
end;

procedure TfrmWebShopsDlg.bbShop_ModifyClick(Sender: TObject);
begin
     ShowModifyShopDialog;
end;

procedure TfrmWebShopsDlg.bbShop_NewClick(Sender: TObject);
begin
     ShowAddNewShopDialog;
end;

procedure TfrmWebShopsDlg.cxGridCityTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if (AButton=mbLeft) and bbCity_Modify.Enabled then
     begin
          ShowModifyCityDialog;
          AHandled:=True;
     end;
end;

procedure TfrmWebShopsDlg.cxGridCityTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     Selection_City_Changed;
end;

procedure TfrmWebShopsDlg.cxGridShopTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if (AButton=mbLeft) and bbShop_Modify.Enabled then
     begin
          ShowModifyShopDialog;
          AHandled:=True;
     end;
end;

procedure TfrmWebShopsDlg.cxGridShopTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     Selection_Shop_Changed;
end;

procedure TfrmWebShopsDlg.DeleteCity;
begin
     if ShowAskDialog('Stergere oras',
                      Format('Doriti sa stergeti orasul "%s"?',[IBCQueryCity.FieldByName('CITY_TITLE').AsString]),
                      'Atentie! Toate magazinele din acest oras vor fi sterse.')<>mrYes then Exit;

     IBCQueryCity.UpdateTransaction.StartTransaction;
     try
        IBCQueryCity.Delete;
        IBCQueryCity.UpdateTransaction.Commit;
     except on E:Exception do
        begin
             IBCQueryCity.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmWebShopsDlg.DeleteShop;
var S:String;
begin
     S:=Format('Doriti sa stergeti magazinul "%s" pe adresa "%s"?',[IBCQueryShop.FieldByName('CUSTOMER_NAME').AsString,IBCQueryShop.FieldByName('ADRESA').AsString]);
     if ShowAskDialog('Stergere magazin',S)<>mrYes then Exit;

     try
        IBCQueryShop.UpdateTransaction.StartTransaction;
        IBCQueryShop.Delete;
        IBCQueryShop.UpdateTransaction.Commit;
     except on E:Exception do
        begin
             if IBCQueryShop.UpdateTransaction.Active then IBCQueryShop.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmWebShopsDlg.Prepare;
begin
     inherited;

     dtDialogTitle.Title:=Format('Orase si magazine de vanzare pentru %s',[dmDB.CurrentFirmaName]);
     Caption:=dtDialogTitle.Title;

     IBCQueryCity.ParamByName('firma').AsInteger:=dmDB.CurrentFirma;
     IBCQueryCity.Active:=True;

     IBCQueryShop.Active:=True;

     Selection_City_Changed;

end;

procedure TfrmWebShopsDlg.Selection_City_Changed;
var fAdd,fEdit,fDelete,fSort:Boolean;
begin
     fAdd:=True;
     fEdit:=False;
     fDelete:=False;
     fSort:=cxGridCityTable.DataController.RecordCount>1;

     if Assigned(cxGridCityTable.Controller.FocusedRecord) then
     begin
          fEdit:=True;
          fDelete:=True;
     end;

     bbCity_New.Enabled:=fAdd;
     bbCity_Modify.Enabled:=fEdit;
     bbCity_Delete.Enabled:=fDelete;
     bbCity_Sort.Enabled:=fSort;

     Selection_Shop_Changed;
end;

procedure TfrmWebShopsDlg.Selection_Shop_Changed;
var fAdd,fEdit,fDelete,fSort:Boolean;
begin
     fAdd:=Assigned(cxGridCityTable.Controller.FocusedRecord);
     fEdit:=False;
     fDelete:=False;
     fSort:=false;
     if Assigned(cxGridShopTable.Controller.FocusedRecord) then
     begin
          fEdit:=True;
          fDelete:=True;
     end;
     bbShop_New.Enabled:=fAdd;
     bbShop_Modify.Enabled:=fEdit;
     bbShop_Delete.Enabled:=fDelete;
     bbShop_Sort.Enabled:=fSort;
end;

procedure TfrmWebShopsDlg.ShowAddNewCityDialog;
var dialog:TfrmCityEditorDlg;
begin
     dialog:=TfrmCityEditorDlg.Create(Self,IBCQueryCity,IBCDataSourceCity);
     try
        dialog.CreateNewCity:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmWebShopsDlg.ShowAddNewShopDialog;
var dialog:TfrmMagazinEditorDlg;
begin
     dialog:=TfrmMagazinEditorDlg.Create(Self,IBCQueryShop,IBCDataSourceShop);
     try
        dialog.CreateNewMagazin:=True;
        dialog.FirmaID:=dmDB.CurrentFirma;
        dialog.CityID:=IBCQueryCity.FieldByName('CITYID').AsInteger;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmWebShopsDlg.ShowModifyCityDialog;
var dialog:TfrmCityEditorDlg;
begin
     dialog:=TfrmCityEditorDlg.Create(Self,IBCQueryCity,IBCDataSourceCity);
     try
        dialog.CreateNewCity:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmWebShopsDlg.ShowModifyShopDialog;
var dialog:TfrmMagazinEditorDlg;
begin
     dialog:=TfrmMagazinEditorDlg.Create(Self,IBCQueryShop,IBCDataSourceShop);
     try
        dialog.CreateNewMagazin:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmWebShopsDlg.ShowSortCityDialog;
begin

end;

procedure TfrmWebShopsDlg.ShowSortShopsDialog;
begin

end;

end.
