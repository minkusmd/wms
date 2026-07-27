unit frmWebCatalogCompatibleGroupsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, StdCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar, ExtCtrls,
  DBAccess, IBC, MemDS, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmWebCatalogCompatibleGroupsDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    btnClose: TButton;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    bbAdd: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCQueryCompatible: TIBCQuery;
    IBCDataSourceCompatible: TIBCDataSource;
    cxGrid_COMPATIBLE_CATALOGID: TcxGridDBColumn;
    cxGrid_COMPATIBLE_TITLE_ROM: TcxGridDBColumn;
    cxGrid_COMPATIBLE_TITLE_RUS: TcxGridDBColumn;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbAddClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    { Private declarations }
    procedure SelectionChanged;

    procedure ShowAddNewGroupDialog;
    procedure DoDeleteGroup;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
  public
    { Public declarations }
  end;

implementation

uses DataModuleAdditions, DataModuleDB, frmWebCatalogCompatibleSelectGroupsDialog;

{$R *.dfm}
{ TfrmWebCatalogCompatibleGroupsDlg }

procedure TfrmWebCatalogCompatibleGroupsDlg.bbAddClick(Sender: TObject);
begin
  ShowAddNewGroupDialog;
end;

procedure TfrmWebCatalogCompatibleGroupsDlg.bbDeleteClick(Sender: TObject);
begin
  DoDeleteGroup;
end;

procedure TfrmWebCatalogCompatibleGroupsDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmWebCatalogCompatibleGroupsDlg.DoDeleteGroup;
begin
  IBCQueryCompatible.Delete;
end;

procedure TfrmWebCatalogCompatibleGroupsDlg.BindingDataSource;
begin
  IBCQueryCompatible.Transaction := fMasterDataSet.UpdateTransaction;
  IBCQueryCompatible.UpdateTransaction := fMasterDataSet.UpdateTransaction;
end;

procedure TfrmWebCatalogCompatibleGroupsDlg.Prepare;
begin
  IBCQueryCompatible.ParamByName('id').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
  IBCQueryCompatible.Active := True;
  SelectionChanged;
end;

procedure TfrmWebCatalogCompatibleGroupsDlg.SelectionChanged;
var
  fAdd, fDelete: Boolean;
begin
  fAdd := True;
  fDelete := False;

  if (cxGridTable.DataController.RecNo > 0) then
  begin
    fDelete := True;
  end;
  bbAdd.Enabled := fAdd;
  bbDelete.Enabled := fDelete;
end;

procedure TfrmWebCatalogCompatibleGroupsDlg.ShowAddNewGroupDialog;
var
  dialog: TfrmWebCatalogCompatibleSelectGroupsDlg;
begin
  dialog := TfrmWebCatalogCompatibleSelectGroupsDlg.Create(Self, IBCQueryCompatible, IBCDataSourceCompatible);
  try
    dialog.CatalogID := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryCompatible.Insert;
      try
        IBCQueryCompatible.FieldByName('PARENT_CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
        IBCQueryCompatible.FieldByName('COMPATIBLE_CATALOGID').AsInteger := dialog.CompatibleCatalogID;
        IBCQueryCompatible.Post;
      except
        IBCQueryCompatible.Cancel;
        raise;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

end.
