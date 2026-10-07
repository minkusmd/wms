unit frmFiscalPrintersSetupDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxImageComboBox,
  cxCheckBox, DBAccess, IBC, MemDS, dxBar, cxClasses, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, Vcl.ExtCtrls, Vcl.StdCtrls, DialogTitle,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmFiscalPrintersSetupDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnClose: TButton;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridFPTable: TcxGridDBTableView;
    cxGridFPLevel: TcxGridLevel;
    cxGridFP: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCQueryFP: TIBCQuery;
    IBCDataSourceFP: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGridFPTable_FP_ID: TcxGridDBColumn;
    cxGridFPTable_SERIAL_NUMBER: TcxGridDBColumn;
    cxGridFPTable_DEVICE_TYPE: TcxGridDBColumn;
    cxGridFPTable_ECC_API_CODE: TcxGridDBColumn;
    cxGridFPTable_FIRMA_NAME: TcxGridDBColumn;
    cxGridFPTable_COMPUTER_NAME: TcxGridDBColumn;
    cxGridFPTable_SERVER_ADDRESS: TcxGridDBColumn;
    cxGridFPTable_DESCRIPTION: TcxGridDBColumn;
    cxGridFPTable_FLG_ENABLED: TcxGridDBColumn;
    cxGridFPTable_IMG: TcxGridDBColumn;
    bbFPSharing: TdxBarButton;
    procedure cxGridFPTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbFPSharingClick(Sender: TObject);
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
  DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst, SWNDBErrors, frmFiscalPrinterEditDialog,
  frmFiscalPrinterSharingDialog;

{ TfrmFiscalPrintersSetupDlg }

procedure TfrmFiscalPrintersSetupDlg.bbDeleteClick(Sender: TObject);
begin
  if ShowAskDialog('Sterge MCC', Format('Stergeti MCC cu numarul de serie "%s" din subdiviziunea "%s" ?',
    [IBCQueryFP.FieldByName('SERIAL_NUMBER').AsString, IBCQueryFP.FieldByName('FIRMA_NAME').AsString])) <> mrYes then
    Exit;

  IBCQueryFP.UpdateTransaction.StartTransaction;
  try
    IBCQueryFP.Delete;
    IBCQueryFP.UpdateTransaction.Commit;
  except
    on E: Exception do
    begin
      IBCQueryFP.UpdateTransaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end
  end;
end;

procedure TfrmFiscalPrintersSetupDlg.bbEditClick(Sender: TObject);
var
  dialog: TfrmFiscalPrinterEditDlg;
begin
  dialog := TfrmFiscalPrinterEditDlg.Create(Self, IBCQueryFP, IBCDataSourceFP);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmFiscalPrintersSetupDlg.bbFPSharingClick(Sender: TObject);
var
  dialog: TfrmFiscalPrinterSharingDlg;
begin
  dialog := TfrmFiscalPrinterSharingDlg.Create(Self, IBCQueryFP, IBCDataSourceFP);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmFiscalPrintersSetupDlg.bbNewClick(Sender: TObject);
var
  dialog: TfrmFiscalPrinterEditDlg;
begin
  dialog := TfrmFiscalPrinterEditDlg.Create(Self, IBCQueryFP, IBCDataSourceFP);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmFiscalPrintersSetupDlg.cxGridFPTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmFiscalPrintersSetupDlg.Prepare;
begin
  IBCQueryFP.Active := True;
  SelectionChanged;
end;

procedure TfrmFiscalPrintersSetupDlg.SelectionChanged;
var
  fNew, fEdit, fDelete: Boolean;
begin
  fNew := True;
  fEdit := False;
  fDelete := False;

  if (cxGridFPTable.DataController.RecNo > 0) then
  begin
    fEdit := True;
    fDelete := True;
  end;

  bbNew.Enabled := fNew;
  bbEdit.Enabled := fEdit;
  bbDelete.Enabled := fDelete;
  bbFPSharing.Enabled := fEdit;
end;

end.

