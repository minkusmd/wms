unit frmWebStaticPagesDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, Vcl.StdCtrls, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar,
  Vcl.ExtCtrls, DBAccess, IBC, MemDS, cxCheckBox, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges,
  dxScrollbarAnnotations;

type
  TfrmWebStaticPagesDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    btnClose: TButton;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCQueryPages: TIBCQuery;
    IBCDataSourcePages: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGrid_PAGEID: TcxGridDBColumn;
    cxGrid_TITLE_RUS: TcxGridDBColumn;
    cxGrid_TITLE_ROM: TcxGridDBColumn;
    cxGrid_FLG_ENABLED: TcxGridDBColumn;
    cxGridTableColumn1: TcxGridDBColumn;
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
  private
    { Private declarations }
    procedure SelectionChanged;
    procedure ShowCreateNewPageDialog;
    procedure ShowModifyPageDialog;
    procedure DeletePage;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, DataModuleDB, frmWebStaticPageEditorDialog, SWNUtils,
  SWNDBErrors;

{ TfrmWebStaticPagesDlg }

procedure TfrmWebStaticPagesDlg.bbDeleteClick(Sender: TObject);
begin
  DeletePage;
end;

procedure TfrmWebStaticPagesDlg.bbModifyClick(Sender: TObject);
begin
  ShowModifyPageDialog;
end;

procedure TfrmWebStaticPagesDlg.bbNewClick(Sender: TObject);
begin
  ShowCreateNewPageDialog;
end;

procedure TfrmWebStaticPagesDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmWebStaticPagesDlg.DeletePage;
begin
  if ShowAskDialog('Pagini statice pe web', Format('Doriti sa stergeti pagina "%s"?', [IBCQueryPages.FieldByName('PAGEID').AsString])) <> mrYes then
    Exit;

  IBCQueryPages.UpdateTransaction.StartTransaction;
  try
    IBCQueryPages.Delete;
    IBCQueryPages.UpdateTransaction.Commit;
  except
    on E: Exception do begin
      IBCQueryPages.UpdateTransaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmWebStaticPagesDlg.Prepare;
begin
  IBCQueryPages.Active := True;
  SelectionChanged;
end;

procedure TfrmWebStaticPagesDlg.SelectionChanged;
var
  fNew, fEdit, fDelete: Boolean;
begin
  fNew := True;
  fEdit := False;
  fDelete := False;
  if (cxGridTable.DataController.RecNo > 0) then begin
    fEdit := True;
    fDelete := True;
  end;
  bbNew.Enabled := fNew;
  bbModify.Enabled := fEdit;
  bbDelete.Enabled := fDelete;
end;

procedure TfrmWebStaticPagesDlg.ShowCreateNewPageDialog;
var
  dialog: TfrmWebStaticPageEditorDlg;
begin
  dialog := TfrmWebStaticPageEditorDlg.Create(Self, IBCQueryPages, IBCDataSourcePages);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebStaticPagesDlg.ShowModifyPageDialog;
var
  dialog: TfrmWebStaticPageEditorDlg;
begin
  dialog := TfrmWebStaticPageEditorDlg.Create(Self, IBCQueryPages, IBCDataSourcePages);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.

