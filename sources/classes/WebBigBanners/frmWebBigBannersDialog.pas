unit frmWebBigBannersDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxClasses, dxBar, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.ExtCtrls, DBAccess, IBC, MemDS, Vcl.StdCtrls, cxNavigator, dxDateRanges;

type
  TfrmWebBigBannersDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManagerBar1: TdxBar;
    IBCQueryBanner: TIBCQuery;
    IBCDataSourceBanner: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    btnClose: TButton;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGrid_BANNERID: TcxGridDBColumn;
    cxGrid_TITLE: TcxGridDBColumn;
    cxGrid_START_DATE: TcxGridDBColumn;
    cxGrid_END_DATE: TcxGridDBColumn;
    cxGrid_FLG_VISIBLE: TcxGridDBColumn;
    cxGrid_NAV_URL: TcxGridDBColumn;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    procedure SelectionChanged;

    procedure ShowAddNewBannerDialog;
    procedure ShowEditCurrentBannerDialog;
    procedure DeleteCurrentBanner;

  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, frmWebBigBannerEditorDialog, SWNUtils, SWNDBErrors;

procedure TfrmWebBigBannersDlg.bbDeleteClick(Sender: TObject);
begin
  DeleteCurrentBanner;
end;

procedure TfrmWebBigBannersDlg.bbEditClick(Sender: TObject);
begin
  ShowEditCurrentBannerDialog;
end;

procedure TfrmWebBigBannersDlg.bbNewClick(Sender: TObject);
begin
  ShowAddNewBannerDialog;
end;

procedure TfrmWebBigBannersDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbEdit.Enabled then
    bbEditClick(bbEdit);
end;

procedure TfrmWebBigBannersDlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGrid_FLG_VISIBLE.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGrid_FLG_VISIBLE.index] = 0 then
    begin
      if Not AViewInfo.Selected then
      begin
        ACanvas.Font.Color := clGrayText;
      end;
    end;
  end;
end;

procedure TfrmWebBigBannersDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmWebBigBannersDlg.DeleteCurrentBanner;
begin
  if ShowAskDialog('Stergere banner', Format('Doriti sa stergeti bannerul "%s"?', [IBCQueryBanner.FieldByName('TITLE').AsString])) = mrYes
  then
  begin
    IBCQueryBanner.UpdateTransaction.StartTransaction;
    try
      IBCQueryBanner.Delete;
      IBCQueryBanner.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryBanner.UpdateTransaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmWebBigBannersDlg.Prepare;
begin
  IBCQueryBanner.Active := True;
  SelectionChanged;
end;

procedure TfrmWebBigBannersDlg.SelectionChanged;
var
  fNew, fEdit, fDelete: Boolean;
begin
  fNew := True;
  fEdit := False;
  fDelete := False;

  if (cxGridTable.DataController.RecNo > 0) then
  begin
    fEdit := True;
    fDelete := True;
  end;

  bbNew.Enabled := fNew;
  bbEdit.Enabled := fEdit;
  bbDelete.Enabled := fDelete;
end;

procedure TfrmWebBigBannersDlg.ShowAddNewBannerDialog;
var
  dialog: TfrmWebBigBannerEditorDlg;
begin
  dialog := TfrmWebBigBannerEditorDlg.Create(Self, IBCQueryBanner, IBCDataSourceBanner);
  try
    dialog.CreateNewBanner := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebBigBannersDlg.ShowEditCurrentBannerDialog;
var
  dialog: TfrmWebBigBannerEditorDlg;
begin
  dialog := TfrmWebBigBannerEditorDlg.Create(Self, IBCQueryBanner, IBCDataSourceBanner);
  try
    dialog.CreateNewBanner := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.
