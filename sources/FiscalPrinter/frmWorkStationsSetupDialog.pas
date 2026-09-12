unit frmWorkStationsSetupDialog;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  SWNBaseUnit,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  Data.DB,
  cxDBData,
  cxImageComboBox,
  cxCheckBox,
  DBAccess,
  IBC,
  MemDS,
  dxBar,
  cxClasses,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGridCustomView,
  cxGrid,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  DialogTitle,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxDateRanges,
  dxScrollbarAnnotations;

type
  TfrmWorkStationsSetupDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnClose: TButton;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridWSTable: TcxGridDBTableView;
    cxGridWSLevel: TcxGridLevel;
    cxGridWS: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCQueryWS: TIBCQuery;
    IBCDataSourceWS: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGridWSTable_WS_ID: TcxGridDBColumn;
    cxGridWSTable_FLG_ENABLED: TcxGridDBColumn;
    cxGridWSTable_COMPUTER_NAME: TcxGridDBColumn;
    cxGridWSTable_FIRMA_NAME: TcxGridDBColumn;
    cxGridWSTable_DESCRIPTION: TcxGridDBColumn;
    cxGridWSTable_CREATED_DATE: TcxGridDBColumn;
    procedure cxGridWSTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
  private
    { Private declarations }
    procedure SelectionChanged;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions,
  DataModuleDB,
  SWNUtils,
  SWNConst,
  SWNDBErrors,
  frmWorkStationEditDialog;

{ TfrmWorkStationsSetupDlg }

procedure TfrmWorkStationsSetupDlg.bbDeleteClick(Sender: TObject);
begin
  if ShowAskDialog('Sterge statia de lucru', Format('Stergeti calculatorul "%s" din subdiviziunea "%s" ?', [IBCQueryWS.FieldByName
    ('COMPUTER_NAME').AsString, IBCQueryWS.FieldByName('FIRMA_NAME').AsString])) <> mrYes then
    Exit;

  IBCQueryWS.UpdateTransaction.StartTransaction;
  try
    IBCQueryWS.Delete;
    IBCQueryWS.UpdateTransaction.Commit;
  except
    on E: Exception do
    begin
      IBCQueryWS.UpdateTransaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end
  end;
end;

procedure TfrmWorkStationsSetupDlg.bbEditClick(Sender: TObject);
var
  dialog: TfrmWorkStationEditDlg;
begin
  dialog := TfrmWorkStationEditDlg.Create(Self, IBCQueryWS, IBCDataSourceWS);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWorkStationsSetupDlg.bbNewClick(Sender: TObject);
var
  dialog: TfrmWorkStationEditDlg;
begin
  dialog := TfrmWorkStationEditDlg.Create(Self, IBCQueryWS, IBCDataSourceWS);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWorkStationsSetupDlg.cxGridWSTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmWorkStationsSetupDlg.Prepare;
begin
  IBCQueryWS.Active := True;
  SelectionChanged;
end;

procedure TfrmWorkStationsSetupDlg.SelectionChanged;
var
  fRecordSelected: Boolean;
begin
  fRecordSelected := cxGridWSTable.DataController.RecNo > 0;

  bbNew.Enabled := True;
  bbEdit.Enabled := fRecordSelected;
  bbDelete.Enabled := fRecordSelected;
end;

end.

