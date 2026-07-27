unit frmGoodsDescFilterButtonsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  dxBar, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, ExtCtrls, DialogTitle, StdCtrls, DBAccess, IBC,
  MemDS, cxCheckBox, cxNavigator, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations;

type
  TfrmGoodsDescFilterButtonsDlg = class(TSWNMasteredFormClass)
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
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
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
    procedure BindingDataSource;override;
    procedure Prepare;override;
  public
    { Public declarations }

    property ButtonsChanged:Boolean read fChanged;
  end;


implementation

uses DataModuleAdditions, DataModuleDB, frmGoodsDescFilterButtonEditorDialog, SWNUtils;

{$R *.dfm}

{ TfrmDescriptionLinkButtonsDlg }

procedure TfrmGoodsDescFilterButtonsDlg.bbAddClick(Sender: TObject);
begin
     ShowAddNewButtonDialog;
end;

procedure TfrmGoodsDescFilterButtonsDlg.bbModifyClick(Sender: TObject);
begin
     ShowModifyButtonDialog;
end;

procedure TfrmGoodsDescFilterButtonsDlg.bbRemoveClick(Sender: TObject);
begin
     DoDeleteButton;
end;

procedure TfrmGoodsDescFilterButtonsDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmGoodsDescFilterButtonsDlg.DoDeleteButton;
begin
     if ShowAskDialog('Sterge',Format('Stergeti butonul "%s"?',[IBCQueryButtons.FieldByName('FILTER_BUTTON_TITLE').AsString]))=mrYes then
     begin
          IBCQueryButtons.Delete;
          fChanged:=True;
     end;
end;

procedure TfrmGoodsDescFilterButtonsDlg.BindingDataSource;
begin
     IBCQueryButtons.Transaction:=fMasterDataSet.Transaction;
     IBCQueryButtons.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
end;

procedure TfrmGoodsDescFilterButtonsDlg.Prepare;
begin
     IBCQueryButtons.ParamByName('G_ID').AsInteger:=fMasterDataSet.FieldByName('GOODSID').AsInteger;
     IBCQueryButtons.ParamByName('D_ID').AsInteger:=fMasterDataSet.FieldByName('DESCRIPTIONID').AsInteger;
     IBCQueryButtons.Active:=True;
     SelectionChanged;
     fChanged:=False;
end;

procedure TfrmGoodsDescFilterButtonsDlg.SelectionChanged;
var fAdd,fEdit,fRemove:Boolean;
begin
     fAdd:=True;
     fEdit:=False;
     fRemove:=False;
     if (cxGridTable.DataController.RecNo>0) then
     begin
          fEdit:=True;
          fRemove:=True;
     end;
     bbAdd.Enabled:=fAdd;
     bbModify.Enabled:=fEdit;
     bbRemove.Enabled:=fRemove;
end;

procedure TfrmGoodsDescFilterButtonsDlg.ShowAddNewButtonDialog;
var dialog:TfrmGoodsDescFilterButtonEditorDlg;
begin
     dialog:=TfrmGoodsDescFilterButtonEditorDlg.Create(Self,IBCQueryButtons,IBCDataSourceButtons);
     try
        dialog.CreateNewButton:=True;
        dialog.GoodsID:=fMasterDataSet.FieldByName('GOODSID').AsInteger;
        dialog.DescriptionID:=fMasterDataSet.FieldByName('DESCRIPTIONID').AsInteger;
        if dialog.ShowModal=mrOk then fChanged:=True;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsDescFilterButtonsDlg.ShowModifyButtonDialog;
var dialog:TfrmGoodsDescFilterButtonEditorDlg;
begin
     dialog:=TfrmGoodsDescFilterButtonEditorDlg.Create(Self,IBCQueryButtons,IBCDataSourceButtons);
     try
        dialog.CreateNewButton:=False;
        dialog.GoodsID:=fMasterDataSet.FieldByName('GOODSID').AsInteger;
        dialog.DescriptionID:=fMasterDataSet.FieldByName('DESCRIPTIONID').AsInteger;
        if dialog.ShowModal=mrOk then fChanged:=True;
     finally
        dialog.Free;
     end;
end;

end.
