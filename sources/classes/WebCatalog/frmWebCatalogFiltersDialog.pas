unit frmWebCatalogFiltersDialog;

interface

uses
  Classes, Controls, DBAccess, DialogTitle, Dialogs, ExtCtrls, Forms, Graphics, IBC, MemDS, Messages, SWNBaseUnit,
  StdCtrls, SysUtils, Variants, Windows, cxButtons, cxCheckBox, cxClasses, cxControls, cxCustomData, cxDBData, cxData,
  cxDataStorage, cxEdit, cxFilter, cxGraphics, cxGrid, cxGridCustomTableView, cxGridCustomView, cxGridDBTableView,
  cxGridLevel, cxGridTableView, cxImageComboBox, cxLookAndFeelPainters, cxLookAndFeels, cxNavigator, cxStyles, dxBar,
  dxDateRanges, dxScrollbarAnnotations,

  Vcl.Menus, Data.DB, dxUIAClasses;

type
  TfrmWebCatalogFiltersDlg = class(TSWNMasteredFormClass)
    pnClient: TPanel;
    cxGridFilters: TcxGrid;
    cxGridFiltersTable: TcxGridDBTableView;
    cxGridFilters_IMAGE: TcxGridDBColumn;
    cxGridFilters_FILTERID: TcxGridDBColumn;
    cxGridFilters_FILTERNAME_ROM: TcxGridDBColumn;
    cxGridFilters_FLG_ENABLED: TcxGridDBColumn;
    cxGridFilters_FLG_OPEN_GROUP: TcxGridDBColumn;
    cxGridFiltersLevel: TcxGridLevel;
    cxGridFilters_FILTERNAME_RUS: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbFilterAdd: TdxBarButton;
    bbFilterEdit: TdxBarButton;
    bbFilterRemove: TdxBarButton;
    bbSortFilters: TdxBarButton;
    IBCQueryFilters: TIBCQuery;
    pnFilter: TPanel;
    edCatalog_ROM: TEdit;
    edCatalog_RUS: TEdit;
    Label2: TLabel;
    cxGridFilters_ORDERNO: TcxGridDBColumn;
    btnOk: TcxButton;
    Panel1: TPanel;
    IBCQ_RecomendedFilters: TIBCQuery;
    IBCDataSourceFilters: TIBCDataSource;
    DialogTitle1: TDialogTitle;
    IBCDS_RecomendedFilters: TIBCDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DB_FilterID: TcxGridDBColumn;
    cxGrid1DB_FilterNameRo: TcxGridDBColumn;
    cxGrid1DB_FilterNameRu: TcxGridDBColumn;
    dxBarDockControl2: TdxBarDockControl;
    bbAddFilter: TdxBarButton;
    bbFilterParams: TdxBarButton;
    dxBarManager1Bar2: TdxBar;
    dxBarButton1: TdxBarButton;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    IBCQueryParamUsedByUsers: TIBCQuery;
    IBCDataSourceParamUsedByUsers: TIBCDataSource;
    cxGrid2DBTableView1CREATED_BY: TcxGridDBColumn;
    cxGrid2DBTableView1FULL_NAME: TcxGridDBColumn;
    cxGrid2DBTableView1CNT: TcxGridDBColumn;
    procedure cxGridFiltersTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbFilterAddClick(Sender: TObject);
    procedure bbFilterEditClick(Sender: TObject);
    procedure bbFilterRemoveClick(Sender: TObject);
    procedure bbSortFiltersClick(Sender: TObject);
    procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    procedure cxGridFiltersTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbAddFilterClick(Sender: TObject);
    procedure bbFilterParamsClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fCatalogID: integer;
    procedure SetCatalogID(const Value: integer);

    procedure SelectionChanged;

    procedure ShowAddNewFilterDialog;
    procedure ShowModifyFilterDialog;
    procedure DeleteFilter;
    procedure ShowSortFiltersDialog;
  protected
    procedure AddToCatalogFilters(AFilterID: Integer);
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
  public
    { Public declarations }
    property CatalogID: integer read fCatalogID write SetCatalogID;
    procedure SetTitles(const TitleRom, TitleRus: string);
  end;

implementation

uses frmWebCatalogFilterEditorDialog, SWNUtils, frmChangeOrderNoDialog,
  SWNDBErrors, frmFilterParamsDialog, DataModuleDB;

{$R *.dfm}

procedure TfrmWebCatalogFiltersDlg.AddToCatalogFilters(AFilterID: Integer);
var
  q: TIBCQuery;
begin
  q := TIBCQuery.Create(self);
  try
    q.sql.Text := 'INSERT INTO VW_TWEB_CATALOG_FILTERS '+
                  '(CATALOGID, FILTERID, FLG_ENABLED, FLG_OPEN_GROUP) '+
                  'VALUES '+
                  '(:CATALOGID, :FILTERID, :FLG_ENABLED, :FLG_OPEN_GROUP)';
    q.ParamByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
    q.ParamByName('FILTERID').AsInteger := AFilterID;
    q.ParamByName('FLG_ENABLED').AsInteger := 1;
    q.ParamByName('FLG_OPEN_GROUP').AsInteger := 1;
    q.Transaction := fMasterDataSet.UpdateTransaction;
    if not q.Transaction.Active then
      q.Transaction.StartTransaction;

    q.Execute;
    q.Transaction.Commit;

    IBCQueryFilters.Refresh;
  finally
    q.Free;
  end;


end;

{ TfrmWebCatalogFiltersDlg }

procedure TfrmWebCatalogFiltersDlg.bbAddFilterClick(Sender: TObject);
begin
  AddToCatalogFilters(cxGrid1DBTableView1.Controller.FocusedRow.Values[cxGrid1DB_FilterID.Index]);
end;

procedure TfrmWebCatalogFiltersDlg.bbFilterAddClick(Sender: TObject);
begin
  ShowAddNewFilterDialog;
end;

procedure TfrmWebCatalogFiltersDlg.bbFilterEditClick(Sender: TObject);
begin
  ShowModifyFilterDialog;
end;

procedure TfrmWebCatalogFiltersDlg.bbFilterParamsClick(Sender: TObject);
var
  dialog: TfrmFilterParamsDlg;
begin
  dialog := TfrmFilterParamsDlg.Create(Self, dmdb.IBCConnection);
  try
    dialog.FilterID := IBCQ_RecomendedFilters.FieldByName('FILTERID').AsInteger;
    dialog.filterName := IBCQ_RecomendedFilters.FieldByName('FILTERNAME').AsString;
    dialog.CurrentFirma := dmdb.CurrentFirma;
    dialog.CatalogID :=  MasterDataSet.FieldByName('CATALOGID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebCatalogFiltersDlg.bbFilterRemoveClick(Sender: TObject);
begin
  DeleteFilter;
end;

procedure TfrmWebCatalogFiltersDlg.bbSortFiltersClick(Sender: TObject);
begin
  ShowSortFiltersDialog;
end;

procedure TfrmWebCatalogFiltersDlg.cxGridFiltersTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    if bbFilterEdit.Enabled then
      bbFilterEditClick(bbFilterEdit);
    AHandled := True;
  end;
end;

procedure TfrmWebCatalogFiltersDlg.cxGridFiltersTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmWebCatalogFiltersDlg.DeleteFilter;
begin
  if ShowAskDialog('Удаление фильтра', Format('Вы хотите удалить фильтр "%s/%s"', [IBCQueryFilters.FieldByName('FILTERNAME_RUS').AsString,
    IBCQueryFilters.FieldByName('FILTERNAME_ROM').AsString])) = mrYes then
  begin
    IBCQueryFilters.UpdateTransaction.StartTransaction;
    try
      IBCQueryFilters.Delete;
      IBCQueryFilters.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryFilters.UpdateTransaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmWebCatalogFiltersDlg.dxBarButton1Click(Sender: TObject);
begin
  AddToCatalogFilters(10);
  AddToCatalogFilters(11);
end;

procedure TfrmWebCatalogFiltersDlg.BindingDataSource;
begin
  IBCQueryFilters.UpdateTransaction := fMasterDataSet.UpdateTransaction;
end;

procedure TfrmWebCatalogFiltersDlg.cxGrid1DBTableView1DblClick(Sender: TObject);
begin
  bbAddFilterClick(Sender);
end;

procedure TfrmWebCatalogFiltersDlg.Prepare;
begin
  IBCQueryFilters.ParamByName('CATALOGID').AsInteger := fCatalogID;
  IBCQueryFilters.Active := True;
  IBCQ_RecomendedFilters.ParamByName('CATALOGID').AsInteger := MasterDataSet.FieldByName('CATALOGID').AsInteger;
  IBCQ_RecomendedFilters.Open;

  IBCQueryParamUsedByUsers.Close;
//  IBCQueryParamUsedByUsers.DetailFields := 'DETAIL_FILTERID';
//  IBCQueryParamUsedByUsers.MasterFields := 'FILTERID';
//  IBCQueryParamUsedByUsers.MasterSource := IBCDS_RecomendedFilters;

  IBCQueryParamUsedByUsers.ParamByName('CATALOGID').AsInteger := MasterDataSet.FieldByName('CATALOGID').AsInteger;
  IBCQueryParamUsedByUsers.Open;
  SelectionChanged;
end;

procedure TfrmWebCatalogFiltersDlg.SelectionChanged;
var
  fAdd, fEdit, fDelete, fSort: Boolean;
begin
  fAdd := True;
  fEdit := false;
  fDelete := false;
  fSort := cxGridFiltersTable.DataController.RecordCount > 1;
  if Assigned(cxGridFiltersTable.Controller.FocusedRecord) then
  begin
    fEdit := True;
    fDelete := True;
  end;

  bbFilterAdd.Enabled := fAdd;
  bbFilterEdit.Enabled := fEdit;
  bbFilterRemove.Enabled := fDelete;
  bbSortFilters.Enabled := fSort;
end;

procedure TfrmWebCatalogFiltersDlg.SetCatalogID(const Value: integer);
begin
  fCatalogID := Value;
end;

procedure TfrmWebCatalogFiltersDlg.SetTitles(const TitleRom, TitleRus: string);
begin
  edCatalog_ROM.Text := TitleRom;
  edCatalog_RUS.Text := TitleRus;
end;

procedure TfrmWebCatalogFiltersDlg.ShowAddNewFilterDialog;
var
  dialog: TfrmWebCatalogFilterEditorDlg;
begin
  dialog := TfrmWebCatalogFilterEditorDlg.Create(self, IBCQueryFilters, IBCDataSourceFilters);
  try
    dialog.CreateNewFilter := True;
    dialog.CatalogID := fCatalogID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebCatalogFiltersDlg.ShowModifyFilterDialog;
var
  dialog: TfrmWebCatalogFilterEditorDlg;
begin
  dialog := TfrmWebCatalogFilterEditorDlg.Create(self, IBCQueryFilters, IBCDataSourceFilters);
  try
    dialog.CreateNewFilter := false;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebCatalogFiltersDlg.ShowSortFiltersDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(self);
  try
    dialog.DBTable := cosWebCatalogFilters;
    dialog.ParentID := fCatalogID;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryFilters.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

end.
