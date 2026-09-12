unit frmDescriptionLinkButtonsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  dxBar, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, ExtCtrls, DialogTitle, StdCtrls, DBAccess, IBC,
  MemDS, cxCheckBox, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TfrmDescriptionLinkButtonsDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    bbAdd: TdxBarButton;
    bbRemove: TdxBarButton;
    cxGrid_FILTER_BUTTON_ID: TcxGridDBColumn;
    cxGrid_FILTER_BUTON_TITLE: TcxGridDBColumn;
    cxGridTableColumn3: TcxGridDBColumn;
    btnClose: TButton;
    IBCQueryButtons: TIBCQuery;
    IBCDataSourceButtons: TIBCDataSource;
    cxGrid_ORDERNO: TcxGridDBColumn;
    bbModify: TdxBarButton;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbAddClick(Sender: TObject);
    procedure bbRemoveClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
  private
    { Private declarations }
    fChanged: Boolean;
    procedure SelectionChanged;
    procedure ShowAddNewButtonDialog;
    procedure ShowModifyButtonDialog;
    procedure DoDeleteButton;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
  public
    { Public declarations }

    property ButtonsChanged: Boolean read fChanged;
  end;

implementation

uses DataModuleAdditions, DataModuleDB, frmDescriptionLinkButtonEditorDialog, SWNUtils;

{$R *.dfm}
{ TfrmDescriptionLinkButtonsDlg }

procedure TfrmDescriptionLinkButtonsDlg.bbAddClick(Sender: TObject);
begin
  ShowAddNewButtonDialog;
end;

procedure TfrmDescriptionLinkButtonsDlg.bbModifyClick(Sender: TObject);
begin
  ShowModifyButtonDialog;
end;

procedure TfrmDescriptionLinkButtonsDlg.bbRemoveClick(Sender: TObject);
begin
  DoDeleteButton;
end;

procedure TfrmDescriptionLinkButtonsDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmDescriptionLinkButtonsDlg.DoDeleteButton;
begin
  if ShowAskDialog('Stergere buton', Format('Doriti sa stergeti butonul "%s" din lista?',
    [IBCQueryButtons.FieldByName('FILTER_BUTTON_TITLE').AsString])) = mrYes then
  begin
    IBCQueryButtons.Delete;
    fChanged := True;
  end;
end;

procedure TfrmDescriptionLinkButtonsDlg.BindingDataSource;
begin
  IBCQueryButtons.Transaction := fMasterDataSet.Transaction;
  IBCQueryButtons.UpdateTransaction := fMasterDataSet.UpdateTransaction;
end;

procedure TfrmDescriptionLinkButtonsDlg.Prepare;
begin
  IBCQueryButtons.ParamByName('T_ID').AsInteger := fMasterDataSet.FieldByName('TEMPLATEID').AsInteger;
  IBCQueryButtons.ParamByName('S_ID').AsInteger := fMasterDataSet.FieldByName('STRUCTID').AsInteger;
  IBCQueryButtons.Active := True;
  SelectionChanged;
  fChanged := False;
end;

procedure TfrmDescriptionLinkButtonsDlg.SelectionChanged;
var
  fAdd, fEdit, fRemove: Boolean;
begin
  fAdd := True;
  fEdit := False;
  fRemove := False;

  if (cxGridTable.DataController.RecNo > 0) then
  begin
    fEdit := True;
    fRemove := True;
  end;
  bbAdd.Enabled := fAdd;
  bbModify.Enabled := fEdit;
  bbRemove.Enabled := fRemove;
end;

procedure TfrmDescriptionLinkButtonsDlg.ShowAddNewButtonDialog;
var
  dialog: TfrmDescriptionLinkButtonEditorDlg;
begin
  dialog := TfrmDescriptionLinkButtonEditorDlg.Create(Self, IBCQueryButtons, IBCDataSourceButtons);
  try
    dialog.CreateNewButton := True;
    dialog.TemplateID := fMasterDataSet.FieldByName('TEMPLATEID').AsInteger;
    dialog.StructID := fMasterDataSet.FieldByName('STRUCTID').AsInteger;
    if dialog.ShowModal = mrOk then
      fChanged := True;
  finally
    dialog.Free;
  end;
end;

procedure TfrmDescriptionLinkButtonsDlg.ShowModifyButtonDialog;
var
  dialog: TfrmDescriptionLinkButtonEditorDlg;
begin
  dialog := TfrmDescriptionLinkButtonEditorDlg.Create(Self, IBCQueryButtons, IBCDataSourceButtons);
  try
    dialog.CreateNewButton := False;
    dialog.TemplateID := fMasterDataSet.FieldByName('TEMPLATEID').AsInteger;
    dialog.StructID := fMasterDataSet.FieldByName('STRUCTID').AsInteger;
    if dialog.ShowModal = mrOk then
      fChanged := True;
  finally
    dialog.Free;
  end;
end;

end.
