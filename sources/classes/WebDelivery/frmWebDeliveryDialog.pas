unit frmWebDeliveryDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ComCtrls, DialogTitle, StdCtrls, dxBar,
  DB,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls,
  IBC, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxLabel, Vcl.Menus,
  DBAccess, MemDS, cxClasses, cxGridCustomView;

type
  TfrmWebDeliveryDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    pnDeliveryFirms: TPanel;
    pnDeliveryCities: TPanel;
    dxBarDockControl3: TdxBarDockControl;
    dxBarManagerBar3: TdxBar;
    cxGridFirmsTable: TcxGridDBTableView;
    cxGridFirmsLevel: TcxGridLevel;
    cxGridFirms: TcxGrid;
    cxGridCitiesTable: TcxGridDBTableView;
    cxGridCitiesLevel: TcxGridLevel;
    cxGridCities: TcxGrid;
    bbNewFirma: TdxBarButton;
    bbModifyFirma: TdxBarButton;
    bbDeleteFirma: TdxBarButton;
    bbSortFirms: TdxBarButton;
    bbNewLocation: TdxBarButton;
    bbModifyLocation: TdxBarButton;
    bbDeleteLocation: TdxBarButton;
    IBCQueryFirms: TIBCQuery;
    IBCTransactionUpdate: TIBCTransaction;
    IBCDataSourceFirms: TIBCDataSource;
    cxGridFirms_CUSTOMERID: TcxGridDBColumn;
    cxGridFirms_DISPLAYNAME: TcxGridDBColumn;
    cxGridFirms_ORDERNO: TcxGridDBColumn;
    IBCQueryCity: TIBCQuery;
    IBCDataSourceCity: TIBCDataSource;
    cxGridCities_DISTRICTID: TcxGridDBColumn;
    cxGridCities_CITYID: TcxGridDBColumn;
    cxGridCities_DISTRICT_TITLE: TcxGridDBColumn;
    cxGridCities_CITY_TITLE: TcxGridDBColumn;
    cxGridCities_PRICE_LEI: TcxGridDBColumn;
    cxGridCities_TIME_UNIT: TcxGridDBColumn;
    cxGridCities_TIME: TcxGridDBColumn;
    cxGridCities_TIME_MIN: TcxGridDBColumn;
    cxGridCities_TIME_MAX: TcxGridDBColumn;
    pnClient: TPanel;
    btnClose: TcxButton;
    procedure cxGridFirmsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewFirmaClick(Sender: TObject);
    procedure bbModifyFirmaClick(Sender: TObject);
    procedure bbDeleteFirmaClick(Sender: TObject);
    procedure bbSortFirmsClick(Sender: TObject);
    procedure bbNewLocationClick(Sender: TObject);
    procedure bbModifyLocationClick(Sender: TObject);
    procedure bbDeleteLocationClick(Sender: TObject);
    procedure cxGridCitiesTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridCities_TIME_UNITGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridCities_TIMEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridCities_CITY_TITLEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridCitiesTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    procedure Selection_Firms_Changed;
    procedure Selection_Locations_Changed;

    procedure ShowAddNewFirmaDialog;
    procedure ShowModifyFirmaDialog;
    procedure DeleteFirma;
    procedure ShowSortFirmeDialog;

    procedure ShowAddNewLocationDialog;
    procedure ShowModifyLocationDialog;
    procedure DeleteLocation;

  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
  end;

implementation

uses DataModuleDB, SWNDBErrors, SWNUtils, frmFirmaEditorDialog, frmLocationEditorDialog,
  frmChangeOrderNoDialog;

{$R *.dfm}
{ TfrmWebDeliveryDlg }

procedure TfrmWebDeliveryDlg.bbDeleteFirmaClick(Sender: TObject);
begin
  DeleteFirma;
end;

procedure TfrmWebDeliveryDlg.bbDeleteLocationClick(Sender: TObject);
begin
  DeleteLocation;
end;

procedure TfrmWebDeliveryDlg.bbModifyFirmaClick(Sender: TObject);
begin
  ShowModifyFirmaDialog;
end;

procedure TfrmWebDeliveryDlg.bbModifyLocationClick(Sender: TObject);
begin
  ShowModifyLocationDialog;
end;

procedure TfrmWebDeliveryDlg.bbNewFirmaClick(Sender: TObject);
begin
  ShowAddNewFirmaDialog;
end;

procedure TfrmWebDeliveryDlg.bbNewLocationClick(Sender: TObject);
begin
  ShowAddNewLocationDialog;
end;

procedure TfrmWebDeliveryDlg.bbSortFirmsClick(Sender: TObject);
begin
  ShowSortFirmeDialog;
end;

procedure TfrmWebDeliveryDlg.cxGridCitiesTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifyLocation.Enabled then
  begin
    bbModifyLocationClick(bbModifyLocation);
    AHandled := True;
  end;
end;

procedure TfrmWebDeliveryDlg.cxGridCitiesTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  Selection_Locations_Changed;
end;

procedure TfrmWebDeliveryDlg.cxGridCities_CITY_TITLEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if Not VarIsNull(ARecord.Values[cxGridCities_CITYID.Index]) then
  begin
    if ARecord.Values[cxGridCities_CITYID.Index] = -1 then
      AText := '(toate localitatile)';
  end;
end;

procedure TfrmWebDeliveryDlg.cxGridCities_TIMEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if Not VarIsNull(ARecord.Values[cxGridCities_TIME_MIN.Index]) and Not VarIsNull(ARecord.Values[cxGridCities_TIME_MAX.Index]) then
  begin
    AText := Format('%d-%d', [Integer(ARecord.Values[cxGridCities_TIME_MIN.Index]), Integer(ARecord.Values[cxGridCities_TIME_MAX.Index])]);
  end;
end;

procedure TfrmWebDeliveryDlg.cxGridCities_TIME_UNITGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if Not VarIsNull(ARecord.Values[cxGridCities_TIME_UNIT.Index]) then
  begin
    case ARecord.Values[cxGridCities_TIME_UNIT.Index] of
      1:
        AText := 'Ore';
      2:
        AText := 'Zile';
    end;
  end;
end;

procedure TfrmWebDeliveryDlg.cxGridFirmsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  Selection_Firms_Changed;
end;

procedure TfrmWebDeliveryDlg.DeleteFirma;
begin
  if ShowAskDialog('Stergere firma pentru livrare', Format('Doriti sa stergeti firma "%s"?',
    [IBCQueryFirms.FieldByName('DISPLAYNAME').AsString]), 'Toate localitatile vor fi de asemenea sterse!') <> mrYes then
    Exit;

  IBCQueryFirms.UpdateTransaction.StartTransaction;
  try
    IBCQueryFirms.Delete;
    IBCQueryFirms.UpdateTransaction.Commit;
  except
    on E: Exception do
    begin
      IBCQueryFirms.UpdateTransaction.Rollback;
      if Not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmWebDeliveryDlg.DeleteLocation;
var
  S: String;
begin
  S := 'Doriti sa stergeti urmatoarele puncte de livrare' + #13#10 + 'Raion: ' + IBCQueryCity.FieldByName('DISTRICT_TITLE').AsString;
  S := S + #13#10 + 'Oras: ';
  if IBCQueryCity.FieldByName('CITYID').AsInteger = -1 then
    S := S + '(toate orasele din raion)'
  else
    S := S + IBCQueryCity.FieldByName('CITY_TITLE').AsString;
  S := S + #13#10 + 'din lista?';
  if ShowAskDialog('Stergere raion sau oras', S) <> mrYes then
    Exit;

  try
    IBCQueryCity.UpdateTransaction.StartTransaction;
    IBCQueryCity.Delete;
    IBCQueryCity.UpdateTransaction.Commit;
  except
    on E: Exception do
    begin
      if IBCQueryCity.UpdateTransaction.Active then
        IBCQueryCity.UpdateTransaction.Rollback;
      if Not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmWebDeliveryDlg.Prepare;
begin
  inherited;

  dtDialogTitle.Title := Format('Livrare Web pentru "%s"', [dmDB.CurrentFirmaName]);
  Caption := dtDialogTitle.Title;

  // open data
  IBCQueryFirms.ParamByName('firma').AsInteger := dmDB.CurrentFirma;
  IBCQueryFirms.Active := True;
  IBCQueryCity.Active := True;

  // selections update
  Selection_Firms_Changed;
end;

procedure TfrmWebDeliveryDlg.Selection_Firms_Changed;
var
  fAdd, fEdit, fDelete, fSort: Boolean;
  fAddLocation: Boolean;
begin
  fAdd := True;
  fEdit := false;
  fDelete := false;
  fSort := cxGridFirmsTable.DataController.RecordCount > 1;
  fAddLocation := false;
  if Assigned(cxGridFirmsTable.Controller.FocusedRecord) then
  begin
    fEdit := True;
    fDelete := True;
    fAddLocation := True;
  end;
  bbNewFirma.Enabled := fAdd;
  bbModifyFirma.Enabled := fEdit;
  bbDeleteFirma.Enabled := fDelete;
  bbSortFirms.Enabled := fSort;
  bbNewLocation.Enabled := fAddLocation;

  Selection_Locations_Changed;
end;

procedure TfrmWebDeliveryDlg.Selection_Locations_Changed;
var
  fEdit, fDelete: Boolean;
begin
  fEdit := false;
  fDelete := false;

  if Assigned(cxGridCitiesTable.Controller.FocusedRecord) then
  begin
    fEdit := True;
    fDelete := True;
  end;
  bbModifyLocation.Enabled := fEdit;
  bbDeleteLocation.Enabled := fDelete;
end;

procedure TfrmWebDeliveryDlg.ShowAddNewFirmaDialog;
var
  dialog: TfrmFirmaEditorDlg;
begin
  dialog := TfrmFirmaEditorDlg.Create(Self, IBCQueryFirms, IBCDataSourceFirms);
  try
    dialog.CreateNewFirma := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDeliveryDlg.ShowAddNewLocationDialog;
var
  dialog: TfrmLocationEditorDlg;
begin
  dialog := TfrmLocationEditorDlg.Create(Self, IBCQueryCity, IBCDataSourceCity);
  try
    dialog.CreateNewLocation := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDeliveryDlg.ShowModifyFirmaDialog;
var
  dialog: TfrmFirmaEditorDlg;
begin
  dialog := TfrmFirmaEditorDlg.Create(Self, IBCQueryFirms, IBCDataSourceFirms);
  try
    dialog.CreateNewFirma := false;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDeliveryDlg.ShowModifyLocationDialog;
var
  dialog: TfrmLocationEditorDlg;
begin
  dialog := TfrmLocationEditorDlg.Create(Self, IBCQueryCity, IBCDataSourceCity);
  try
    dialog.CreateNewLocation := false;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDeliveryDlg.ShowSortFirmeDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self);
  try
    dialog.DBTable := cosWebDeliveryFirms;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryFirms.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

end.
