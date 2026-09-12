unit frmKitTemplateItemsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, cxStyles,
  StdCtrls, cxButtons, DBAccess, IBC, MemDS, cxLookAndFeels, cxNavigator, cxGraphics, cxControls, cxLookAndFeelPainters,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, Vcl.Menus, dxBar, cxClasses, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, Vcl.ExtCtrls, cxCheckBox;

type
  TfrmKitTemplatesDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    cxGridTemplateDetails: TcxGrid;
    cxGridTemplateDetailsTable: TcxGridDBTableView;
    cxGridTemplateLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTemplate: TcxGrid;
    cxGridTemplateTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbNew: TdxBarButton;
    cxGridTemplateColID: TcxGridDBColumn;
    cxGridTemplateColTITLE: TcxGridDBColumn;
    cxGridTemplateItemCol_GOODS_NAME: TcxGridDBColumn;
    cxGridTemplateItemCol_UM_NAME: TcxGridDBColumn;
    cxGridTemplateItemCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridTemplateItemCol_QTY: TcxGridDBColumn;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    bbNewGoods: TdxBarButton;
    IBCQueryKit: TIBCQuery;
    IBCDataSourceKit: TIBCDataSource;
    IBCDataSourceItems: TIBCDataSource;
    IBCQueryItems: TIBCQuery;
    IBCTrUpdateKit: TIBCTransaction;
    cxGridTemplateItemCol_ID: TcxGridDBColumn;
    bsModifyMenu: TdxBarSubItem;
    bbModifyTemplate: TdxBarButton;
    bbModifyItem: TdxBarButton;
    bsRemoveMenu: TdxBarSubItem;
    bbRemoveTemplate: TdxBarButton;
    bbRemoveItem: TdxBarButton;
    IBCTrUpdateItems: TIBCTransaction;
    procedure FormShow(Sender: TObject);
    procedure IBCDataSourceKitDataChange(Sender: TObject; Field: TField);
    procedure bbNewClick(Sender: TObject);
    procedure bbNewGoodsClick(Sender: TObject);
    procedure bbModifyTemplateClick(Sender: TObject);
    procedure bbModifyItemClick(Sender: TObject);
    procedure bbRemoveTemplateClick(Sender: TObject);
    procedure bbRemoveItemClick(Sender: TObject);
    procedure cxGridTemplateTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridTemplateDetailsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure btnOkClick(Sender: TObject);
    procedure IBCDataSourceItemsDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FSelectMode: Boolean;
    fKitTemplateID: integer;
    procedure SetSelectMode(const Value: Boolean);
    procedure PrepareView;
    procedure SelectedTemplateChanged;
    procedure SelectedTemplateItemChanged;
    procedure ShowAddNewKitTemplateDialog;
    procedure ShowModifySelectedKitTemplateDialog;
    procedure ShowAddNewTemplateItemDialog;
    procedure ShowModifySelectedTemplateItemDialog;
    procedure DeleteCurrentSelectedTemplate;
    procedure DeleteCurrentSelectedTemplateItem;
    procedure ChangeGoodsRecord(const CreateNewRecord: Boolean; const GoodsID: integer; const QTY: single; const Active:
      Boolean);
    procedure TemplateSelected;
  protected
    { protected declarations }
    procedure InitValues; override;
  public
    { Public declarations }

    property SelectMode: Boolean read FSelectMode write SetSelectMode;
    property KitTemplateID: integer read fKitTemplateID;
  end;

implementation

uses
  DataModuleAdditions, frmKitTemplateEditorDialog, frmGoodsTreeBrowser, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmKitTemplatesDlg }

procedure TfrmKitTemplatesDlg.ChangeGoodsRecord(const CreateNewRecord: Boolean; const GoodsID: integer; const QTY:
  single; const Active: Boolean);
begin
  IBCTrUpdateItems.StartTransaction;
  try
    if CreateNewRecord then
      IBCQueryItems.Append
    else
      IBCQueryItems.Edit;
    IBCQueryItems.FieldByName('GOODSID').AsInteger := GoodsID;
    IBCQueryItems.FieldByName('QTY').AsFloat := QTY;
    IBCQueryItems.FieldByName('FLG_ACTIVE').AsBoolean := Active;
    IBCQueryItems.Post;
    IBCTrUpdateItems.Commit;
  except
    IBCQueryItems.Cancel;
    IBCTrUpdateItems.Rollback;
    raise;
  end;
end;

procedure TfrmKitTemplatesDlg.bbModifyItemClick(Sender: TObject);
begin
  ShowModifySelectedTemplateItemDialog
end;

procedure TfrmKitTemplatesDlg.bbModifyTemplateClick(Sender: TObject);
begin
  ShowModifySelectedKitTemplateDialog;
end;

procedure TfrmKitTemplatesDlg.bbNewClick(Sender: TObject);
begin
  ShowAddNewKitTemplateDialog;
end;

procedure TfrmKitTemplatesDlg.bbNewGoodsClick(Sender: TObject);
begin
  ShowAddNewTemplateItemDialog;
end;

procedure TfrmKitTemplatesDlg.bbRemoveItemClick(Sender: TObject);
begin
  DeleteCurrentSelectedTemplateItem;
end;

procedure TfrmKitTemplatesDlg.bbRemoveTemplateClick(Sender: TObject);
begin
  DeleteCurrentSelectedTemplate;
end;

procedure TfrmKitTemplatesDlg.btnOkClick(Sender: TObject);
begin
  if IBCQueryKit.RecordCount > 0 then
    TemplateSelected;
end;

procedure TfrmKitTemplatesDlg.cxGridTemplateDetailsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  ShowModifySelectedTemplateItemDialog;
  AHandled := True;
end;

procedure TfrmKitTemplatesDlg.cxGridTemplateTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if FSelectMode then
    TemplateSelected
  else
    ShowModifySelectedKitTemplateDialog;
  AHandled := True;
end;

procedure TfrmKitTemplatesDlg.DeleteCurrentSelectedTemplate;
var
  S: WideString;
begin
  S := WideFormat(cMSG_DELETERECORD_KitTemplate_DeleteTemplate, [IBCQueryKit.FieldByName('TITLE').AsWideString]);
  if ShowAskDialog(cMSG_DELETERECORD_Title, S) = mrYes then
  begin
    IBCQueryKit.Delete;
    IBCTrUpdateKit.Commit;
  end;
end;

procedure TfrmKitTemplatesDlg.DeleteCurrentSelectedTemplateItem;
var
  S: WideString;
begin
  S := WideFormat(cMSG_DELETERECORD_KitTemplate_DeleteItem, [IBCQueryItems.FieldByName('GOODS_NAME').AsWideString]);
  if ShowAskDialog(cMSG_DELETERECORD_Title, S) = mrYes then
  begin
    IBCQueryItems.Delete;
    IBCTrUpdateItems.Commit;
  end;
end;

procedure TfrmKitTemplatesDlg.FormShow(Sender: TObject);
begin
  PrepareView;
     // Open data
  IBCQueryKit.Active := True;
  IBCQueryItems.Active := True;
end;

procedure TfrmKitTemplatesDlg.IBCDataSourceItemsDataChange(Sender: TObject; Field: TField);
begin
  SelectedTemplateItemChanged;
end;

procedure TfrmKitTemplatesDlg.IBCDataSourceKitDataChange(Sender: TObject; Field: TField);
begin
  SelectedTemplateChanged;
end;

procedure TfrmKitTemplatesDlg.InitValues;
begin
  inherited;

  FSelectMode := True;
  IBCQueryKit.Connection := fIBCConnection;
  IBCQueryItems.Connection := fIBCConnection;
end;

procedure TfrmKitTemplatesDlg.PrepareView;
begin
  if not FSelectMode then
  begin
    btnOk.Visible := False;
    btnCancel.Caption := 'Inchide';
  end;
end;

procedure TfrmKitTemplatesDlg.SelectedTemplateChanged;
var
  f1, f2, f3, f4, f5, f6: Boolean;
begin
  f1 := True; // Sablon nou + Security
  f2 := False;
  f3 := False;
  f4 := False;
  f5 := False;
  f6 := False;
  if IBCQueryKit.RecordCount > 0 then
  begin
    f2 := True; // Produs nou + Security
    f3 := True; // Modifica sablonul + Security
    f4 := True; // Sterge sablonul + Security
    f5 := True; // Modifica marfa + Security
    f6 := True; // Sterge marfa + Security
  end;
  bbNew.Enabled := f1;
  bbNewGoods.Enabled := f2;
  bbModifyTemplate.Enabled := f3;
  bbRemoveTemplate.Enabled := f4;
  bbModifyItem.Enabled := f5;
  bbRemoveItem.Enabled := f6;
end;

procedure TfrmKitTemplatesDlg.SelectedTemplateItemChanged;
var
  f5, f6: Boolean;
begin
  f5 := False;
  f6 := False;
  if IBCQueryItems.RecordCount > 0 then
  begin
    f5 := True; // Modifica marfa + Security
    f6 := True; // Sterge marfa + Security
  end;
  bbModifyItem.Enabled := f5;
  bbRemoveItem.Enabled := f6;
end;

procedure TfrmKitTemplatesDlg.SetSelectMode(const Value: Boolean);
begin
  FSelectMode := Value;
end;

procedure TfrmKitTemplatesDlg.ShowAddNewKitTemplateDialog;
var
  dialog: TfrmKitTemplateEditorDlg;
begin
  dialog := TfrmKitTemplateEditorDlg.Create(Self, IBCQueryKit, IBCDataSourceKit);
  try
    dialog.CreateNewRecord := True;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryKit.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmKitTemplatesDlg.ShowAddNewTemplateItemDialog;
var
  goodsBrowser: TfrmGoodsTreeBrowserDlg;
begin
  goodsBrowser := TfrmGoodsTreeBrowserDlg.Create(nil, fIBCConnection);
  try
    if goodsBrowser.ShowModal = mrOk then
    begin
      ChangeGoodsRecord(True, goodsBrowser.GoodsID, goodsBrowser.Count, goodsBrowser.Active);
      IBCQueryItems.Refresh;
    end;
  finally
    goodsBrowser.Free;
  end;
end;

procedure TfrmKitTemplatesDlg.ShowModifySelectedKitTemplateDialog;
var
  dialog: TfrmKitTemplateEditorDlg;
begin
  dialog := TfrmKitTemplateEditorDlg.Create(Self, IBCQueryKit, IBCDataSourceKit);
  try
    dialog.CreateNewRecord := False;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryKit.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmKitTemplatesDlg.ShowModifySelectedTemplateItemDialog;
var
  goodsBrowser: TfrmGoodsTreeBrowserDlg;
begin
  goodsBrowser := TfrmGoodsTreeBrowserDlg.Create(nil, fIBCConnection);
  try
    goodsBrowser.GoodsID := IBCQueryItems.FieldByName('GOODSID').AsInteger;
    goodsBrowser.Count := IBCQueryItems.FieldByName('QTY').AsFloat;
    if goodsBrowser.ShowModal = mrOk then
    begin
      ChangeGoodsRecord(False, goodsBrowser.GoodsID, goodsBrowser.Count, goodsBrowser.Active);
      IBCQueryItems.Refresh;
    end;
  finally
    goodsBrowser.Free;
  end;
end;

procedure TfrmKitTemplatesDlg.TemplateSelected;
begin
  fKitTemplateID := IBCQueryKit.FieldByName('KITTEMPLATEID').AsInteger;
  ModalResult := mrOk;
end;

end.

