unit frmWebDescriptionTemplateDialog;

interface

uses
  Classes, Controls, DBAccess, DialogTitle, ExtCtrls, Forms, Graphics, IBC, MemDS, Messages, SWNBaseUnit,
  StdCtrls, SysUtils, Variants, Windows, cxBarEditItem, cxButtons, cxCheckBox, cxClasses, cxControls,
  cxCustomData, cxDBData, cxDBTL, cxData, cxDataStorage, cxEdit, cxFilter, cxGraphics, cxGrid,
  cxGridCustomTableView, cxGridCustomView, cxGridDBTableView, cxGridLevel, cxGridTableView, cxImageComboBox,
  cxInplaceContainer, cxLabel, cxLookAndFeelPainters, cxLookAndFeels, cxMaskEdit, cxNavigator, cxStyles, cxTL,
  cxTLData, cxTLdxBarBuiltInMenu, cxTextEdit, dxBar, dxDateRanges, dxScrollbarAnnotations, Data.DB, Vcl.Menus,
  Vcl.Dialogs;

type
  TfrmWebDescriptionTemplateDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    pnDetail: TPanel;
    dxBarManager1: TdxBarManager;
    pnTop: TPanel;
    cxGridTemplate: TcxGrid;
    cxGridTemplateTable: TcxGridDBTableView;
    cxGridTemplate_TEMPLATEID: TcxGridDBColumn;
    cxGridTemplate_TITLE_ROM: TcxGridDBColumn;
    cxGridTemplate_TITLE_RUS: TcxGridDBColumn;
    cxGridTemplateLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    pnDesc: TPanel;
    cxGridDesc: TcxGrid;
    cxGridDescTable: TcxGridDBTableView;
    cxGridDesc_STRUCTID: TcxGridDBColumn;
    cxGridDesc_FILTERNAME_ROM: TcxGridDBColumn;
    cxGridDesc_FILTERNAME_RUS: TcxGridDBColumn;
    cxGridDesc_FLG_VISIBLE: TcxGridDBColumn;
    cxGridDesc_FLG_COMPATIBILITY: TcxGridDBColumn;
    cxGridDescLevel: TcxGridLevel;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    bbTemplateNew: TdxBarButton;
    bbTemplateEdit: TdxBarButton;
    bbTemplateRemove: TdxBarButton;
    bbDescAdd: TdxBarButton;
    bbDescEdit: TdxBarButton;
    bbDescRemove: TdxBarButton;
    bbDescSort: TdxBarButton;
    cxGridDesc_PARAM_VALUE_ROM: TcxGridDBColumn;
    cxGridDesc_PARAM_VALUE_RUS: TcxGridDBColumn;
    cxGridDesc_FLG_COMPARE: TcxGridDBColumn;
    IBCQueryTemplates: TIBCQuery;
    IBCDataSourceTemplates: TIBCDataSource;
    IBCDataSourceDesc: TIBCDataSource;
    IBCQueryDesc: TIBCQuery;
    IBCTransactionUpdate: TIBCTransaction;
    cxGridDesc_FLG_GROUP: TcxGridDBColumn;
    cxGridDesc_ORDERNO: TcxGridDBColumn;
    bbTemplateCopy: TdxBarButton;
    bbSortTemplates: TdxBarButton;
    cxGridDesc_FLG_GOODS_LINK: TcxGridDBColumn;
    bbDescButtons: TdxBarButton;
    cxGridDesc_IMG: TcxGridDBColumn;
    cxGridTemplate_GOODSTYPE_TITLE: TcxGridDBColumn;
    bbGoodsTypes: TdxBarButton;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    dxBarManager1Bar3: TdxBar;
    bbNewGroup: TdxBarButton;
    bbModifyGroup: TdxBarButton;
    bbDeleteGroup: TdxBarButton;
    dxBarButton1: TdxBarButton;
    bbImportFromGoods: TdxBarButton;
    Panel1: TPanel;
    dxBarButton2: TdxBarButton;
    procedure cxGridTemplateTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridDescTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbTemplateNewClick(Sender: TObject);
    procedure bbTemplateEditClick(Sender: TObject);
    procedure bbTemplateRemoveClick(Sender: TObject);
    procedure bbDescAddClick(Sender: TObject);
    procedure bbDescEditClick(Sender: TObject);
    procedure bbDescRemoveClick(Sender: TObject);
    procedure bbDescSortClick(Sender: TObject);
    procedure cxGridDescTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure bbTemplateCopyClick(Sender: TObject);
    procedure bbSortTemplatesClick(Sender: TObject);
    procedure cxGridDescTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbDescButtonsClick(Sender: TObject);
    procedure bbGoodsTypesClick(Sender: TObject);
    procedure bbModifyGroupClick(Sender: TObject);
    procedure cxDBTreeListDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure bbImportFromGoodsClick(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
  private
    FTemplateID: Integer;
    FTemplateName: string;
    { Private declarations }
    procedure TemplateSelectionChanged;
    procedure DescSelectionChanged;
    procedure ShowAddNewTemplateDialog;
    procedure ShowModifyTemplateDialog;
    procedure DoDeleteTemplate;
    procedure ShowAddNewDescDialog;
    procedure ShowModifyDescDialog;
    procedure DoDeleteDescription;
    procedure ShowSortDescDialog;
    function DoCreateTemplateCopy(const SourceTemplateID: integer; var NewTemplateID: integer): Boolean;
    procedure ShowSortTemplatesDialog;
    procedure ShowDescriptionButtonsDialog;
    procedure ShowGoodsTypesDialog;
    procedure ShowTemplateEditorDialog(IsNewRecord: Boolean);
  protected
    procedure ChangeTemplateParent(ListOfTemplatesID: string; NewParentID: Integer);
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    procedure bbImportTemplateFromGoods(GoodsID: Integer);
    property TemplateID: Integer read FTemplateID write FTemplateID;
    property TemplateName: string read FTemplateName write FTemplateName;
    { Public declarations }
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, SWNDBErrors, SWNUtils, frmChangeOrderNoDialog,
  frmDescriptionLinkButtonsDialog, frmDescriptionTemplateEditorDialog, frmDescriptionTemplateGTEditorDialog,
  frmWebDescriptionElementEditorDialog, System.UITypes, frmGoods;

{$R *.dfm}
{ TfrmWebDescriptionTemplateDlg }

procedure TfrmWebDescriptionTemplateDlg.bbDescAddClick(Sender: TObject);
begin
  ShowAddNewDescDialog;
end;

procedure TfrmWebDescriptionTemplateDlg.bbDescButtonsClick(Sender: TObject);
begin
  ShowDescriptionButtonsDialog;
end;

procedure TfrmWebDescriptionTemplateDlg.bbDescEditClick(Sender: TObject);
begin
  ShowModifyDescDialog;
end;

procedure TfrmWebDescriptionTemplateDlg.bbDescRemoveClick(Sender: TObject);
begin
  DoDeleteDescription;
end;

procedure TfrmWebDescriptionTemplateDlg.bbDescSortClick(Sender: TObject);
begin
  ShowSortDescDialog;
end;

procedure TfrmWebDescriptionTemplateDlg.bbGoodsTypesClick(Sender: TObject);
begin
  ShowGoodsTypesDialog;
end;

procedure TfrmWebDescriptionTemplateDlg.bbImportFromGoodsClick(Sender: TObject);
var
  d: TfrmGoodsBrowser;
begin
  d := TfrmGoodsBrowser.Create(self);
  if (d.SelectGoods(-1, False)) then
  begin
    if not d.GoodsIsFolder then
    begin
      bbImportTemplateFromGoods(d.GoodsID);
      IBCQueryDesc.Refresh;
    end
    else
      raise Exception.Create('Trebuie sa fie ales un produs!');
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.bbImportTemplateFromGoods(GoodsID: Integer);
var
  Query: TIBCSQL;
begin
  Query := TIBCSQL.Create(nil);
  try
    Query.SQL.Text := 'execute procedure import_template_filters(:templateid, :goodsid)';
    Query.ParamByName('templateid').AsInteger := IBCQueryTemplates.FieldByName('templateid').Asinteger;
    Query.ParamByName('goodsid').AsInteger := Goodsid;
    Query.Transaction := IBCTransactionUpdate;

    if not ibctransactionUpdate.Active then
      ibctransactionUpdate.StartTransaction;

    Query.Execute;

    if ibctransactionUpdate.Active then
      ibctransactionUpdate.Commit;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.bbModifyGroupClick(Sender: TObject);
begin
  ShowTemplateEditorDialog(false);
end;

procedure TfrmWebDescriptionTemplateDlg.bbSortTemplatesClick(Sender: TObject);
begin
  ShowSortTemplatesDialog;
end;

procedure TfrmWebDescriptionTemplateDlg.bbTemplateCopyClick(Sender: TObject);
var
  newID: integer;
begin
  if ShowAskDialog('Copierea unui set de caracteristici', Format('Doriți să faceți o copie a setului de statistici "%s"?',
    [IBCQueryTemplates.FieldByName('TITLE_RUS').AsString])) = mrYes then
  begin
    if DoCreateTemplateCopy(IBCQueryTemplates.FieldByName('TEMPLATEID').AsInteger, newID) then
    begin
      IBCQueryTemplates.Refresh;
      IBCQueryTemplates.Locate('TEMPLATEID', newID, []);
    end;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.bbTemplateEditClick(Sender: TObject);
begin
  ShowModifyTemplateDialog;
end;

procedure TfrmWebDescriptionTemplateDlg.bbTemplateNewClick(Sender: TObject);
begin
  ShowAddNewTemplateDialog;
end;

procedure TfrmWebDescriptionTemplateDlg.bbTemplateRemoveClick(Sender: TObject);
begin
  DoDeleteTemplate;
end;

procedure TfrmWebDescriptionTemplateDlg.ChangeTemplateParent(ListOfTemplatesID: string; NewParentID: Integer);
var
  query: TIBCQuery;
begin
  query := TIBCQuery.Create(self);
  try
    query.Transaction := IBCTransactionUpdate;

    if not query.Transaction.Active then
      query.Transaction.StartTransaction;

    query.SQL.Text := 'EXECUTE PROCEDURE SP_CHANGE_TEMPLATE_PARENT(:LISTOFID, :PARENTID)';
    query.ParamByName('listofid').AsString := ListOfTemplatesID;
    query.ParamByName('parentid').AsInteger := NewParentID;
    query.Execute;
  finally
    query.Free;
  end;

end;

procedure TfrmWebDescriptionTemplateDlg.cxDBTreeListDragOver(Sender, Source: TObject; X, Y: Integer; State:
  TDragState; var Accept: Boolean);
begin
  Accept := (Source is TcxDragControlObject) and ((Source as TcxDragControlObject).Control is TcxGridSite);
end;

procedure TfrmWebDescriptionTemplateDlg.cxGridDescTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbDescEdit.Enabled then
  begin
    bbDescEditClick(bbDescEdit);
    AHandled := True;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.cxGridDescTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DescSelectionChanged;
end;

procedure TfrmWebDescriptionTemplateDlg.cxGridDescTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if not VarIsNull(ARecord.Values[cxGridDesc_FLG_GROUP.Index]) then
  begin
    if ARecord.Values[cxGridDesc_FLG_GROUP.Index] = 1 then
      AStyle := dmAdditions.cxStyle_BoldYellowBack
    else if ARecord.Values[cxGridDesc_FLG_GOODS_LINK.Index] = 1 then
      AStyle := dmAdditions.cxStyle_Link;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.cxGridTemplateTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  TemplateSelectionChanged;
end;

procedure TfrmWebDescriptionTemplateDlg.DescSelectionChanged;
var
  fAdd, fEdit, fDelete, fSort, fButtons: Boolean;
begin
  fAdd := Assigned(cxGridTemplateTable.Controller.FocusedRecord);
  fEdit := false;
  fDelete := false;
  fSort := cxGridDescTable.DataController.RecordCount > 1;
  fButtons := false;

  if Assigned(cxGridDescTable.Controller.FocusedRecord) then
  begin
    fEdit := True;
    fDelete := True;
    fButtons := True;
  end;

  bbDescAdd.Enabled := fAdd;
  bbDescEdit.Enabled := fEdit;
  bbDescRemove.Enabled := fDelete;
  bbDescButtons.Enabled := fButtons;
  bbDescSort.Enabled := fSort;
end;

function TfrmWebDescriptionTemplateDlg.DoCreateTemplateCopy(const SourceTemplateID: integer; var NewTemplateID:
  integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := false;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := false;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := IBCTransactionUpdate;
    Query.SQL.Text := 'SELECT NEW_TEMPLATEID FROM WEB_CLONE_GOODS_DESCRIPTIONS(:TEMPLATEID)';
    Query.ParamByName('TEMPLATEID').AsInteger := SourceTemplateID;
    try
      Query.ExecSQL;
      if not Query.Eof then
      begin
        NewTemplateID := Query.Fields[0].AsInteger;
        Result := True;
      end;
    except
      on E: Exception do
      begin
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.DoDeleteDescription;
begin
  if ShowAskDialog('Eliminarea unei caracteristici', Format('Doriți să ștergeți o caracteristică "%s"?', [IBCQueryDesc.FieldByName
    ('FILTERNAME_RUS').AsString])) = mrYes then
    IBCQueryDesc.Delete;
end;

procedure TfrmWebDescriptionTemplateDlg.DoDeleteTemplate;
begin
  if ShowAskDialog('Ștergerea unui șablon', Format('Doriți să ștergeți șablonul "%s"?', [IBCQueryTemplates.FieldByName
    ('TITLE_RUS').AsString])) = mrYes then
    IBCQueryTemplates.Delete;
  DescSelectionChanged;
end;

procedure TfrmWebDescriptionTemplateDlg.dxBarButton2Click(Sender: TObject);
var
     ARow: TcxGridDataRow;
     RecIndex: integer;
begin
    for var i:= 0 to cxGridDescTable.Controller.SelectedRowCount-1 do
    begin
        ARow := cxGridDescTable.Controller.SelectedRows[i] as TcxGridDataRow;
//        De obicei, când ai un Row din Controller.SelectedRows[i] (adică un TcxGridDataRow),
//        trebuie să-l transformi într-un record index din DataController → și de acolo în DataSet.
        RecIndex := ARow.RecordIndex;
        // Mutăm dataset-ul pe înregistrarea respectivă
        cxGridDescTable.DataController.FocusedRecordIndex := RecIndex;

        IBCQueryDesc.Edit;
        IBCQueryDesc.FieldByName('flg_visible').AsInteger := abs(integer(ARow.Values[cxGridDesc_FLG_VISIBLE.Index] - 1));
        IBCQueryDesc.Post;
    end;
end;

procedure TfrmWebDescriptionTemplateDlg.ShowSortDescDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self, IBCTransactionUpdate);
  try
    dialog.DBTable := cosDescriptionTemplateStruct;
    dialog.ParentID := IBCQueryTemplates.FieldByName('TEMPLATEID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryDesc.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.ShowSortTemplatesDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self, IBCTransactionUpdate);
  try
    dialog.DBTable := cosDescriptionTemplate;
    if dialog.ShowModal = mrOk then
    begin
//      IBCQueryTemplates.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

function TfrmWebDescriptionTemplateDlg.IsFormDataPosted: Boolean;
begin
  Result := False;

  TemplateID := IBCQueryTemplates.FieldByName('TEMPLATEID').AsInteger;
  TemplateName := IBCQueryTemplates.FieldByName('TITLE_ROM').AsString;

  try
    if IBCTransactionUpdate.Active then
      IBCTransactionUpdate.Commit;

    Result := True;
  except
    begin
      Result := False;
      raise;
    end;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.Prepare;
begin
  try
    IBCTransactionUpdate.StartTransaction;
    IBCQueryTemplates.Active := True;
    IBCQueryDesc.Active := True;

//    cxDBTreeList.Items[0].Focused := True;

    TemplateSelectionChanged;
    DescSelectionChanged;
//    DialogTitle1.Text := '#' + IBCQuerytREE.FieldByName('PARENTID').AsString + ' - ' + IBCQuerytREE.FieldByName
//      ('PARENT_TITLE').AsString;


  except
    if IBCTransactionUpdate.Active then
      IBCTransactionUpdate.Rollback;
    raise;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.ShowAddNewDescDialog;
var
  dialog: TfrmWebDescriptionElementEditorDlg;
begin
  dialog := TfrmWebDescriptionElementEditorDlg.Create(Self, IBCQueryDesc, IBCDataSourceDesc);
  try
    if (cxGridDescTable.DataController.RecNo > 0) then
    begin
      dialog.LastOpenedFilterID := IBCQueryDesc.FieldByName('FILTERID').AsInteger;
      dialog.LastOpenedFilterParamID := IBCQueryDesc.FieldByName('FILTERPARAMID').AsInteger;
    end;
    dialog.CreateNewDescription := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.ShowAddNewTemplateDialog;
//var
//  dialog: TfrmDescriptionTemplateEditorDlg;
begin
//  dialog := TfrmDescriptionTemplateEditorDlg.Create(Self, IBCQueryTemplates, IBCDataSourceTemplates);
//  try
//    dialog.CreateNewTemplate := True;
//    dialog.ParentID := IBCQueryTree.FieldByName('TemplateID').AsInteger;
//    dialog.ShowModal;
//  finally
//    dialog.Free;
//  end;
end;

procedure TfrmWebDescriptionTemplateDlg.ShowDescriptionButtonsDialog;
var
  dialog: TfrmDescriptionLinkButtonsDlg;
begin
  dialog := TfrmDescriptionLinkButtonsDlg.Create(Self, IBCQueryDesc, IBCDataSourceDesc);
  try
    dialog.ShowModal;
    if dialog.ButtonsChanged then
      IBCQueryDesc.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.ShowGoodsTypesDialog;
var
  dialog: TfrmDescriptionTemplateGTEditorDlg;
begin
  dialog := TfrmDescriptionTemplateGTEditorDlg.Create(Self, IBCQueryTemplates, IBCDataSourceTemplates);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.ShowModifyDescDialog;
var
  dialog: TfrmWebDescriptionElementEditorDlg;
begin
  dialog := TfrmWebDescriptionElementEditorDlg.Create(Self, IBCQueryDesc, IBCDataSourceDesc);
  try
    dialog.CreateNewDescription := false;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.ShowModifyTemplateDialog;
var
  dialog: TfrmDescriptionTemplateEditorDlg;
begin
  dialog := TfrmDescriptionTemplateEditorDlg.Create(Self, IBCQueryTemplates, IBCDataSourceTemplates);
  try
    dialog.CreateNewTemplate := false;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebDescriptionTemplateDlg.TemplateSelectionChanged;
var
  fAdd, fEdit, fDelete, fCopy, fSort, fGT: Boolean;
begin
  fAdd := True;
  fEdit := false;
  fDelete := false;
  fCopy := false;
  fGT := false;
  fSort := cxGridTemplateTable.DataController.RecordCount > 1;
  if Assigned(cxGridTemplateTable.Controller.FocusedRecord) then
  begin
    fEdit := True;
    fDelete := True;
    fCopy := True;
    fGT := True;
  end;
  bbTemplateNew.Enabled := fAdd;
  bbTemplateEdit.Enabled := fEdit;
  bbTemplateRemove.Enabled := fDelete;
  bbTemplateCopy.Enabled := fCopy;
  bbSortTemplates.Enabled := fSort;
  bbGoodsTypes.Enabled := fGT;
end;

procedure TfrmWebDescriptionTemplateDlg.WhenCancelForm;
begin
  if IBCTransactionUpdate.Active then
    IBCTransactionUpdate.Rollback;
end;

procedure TfrmWebDescriptionTemplateDlg.ShowTemplateEditorDialog(IsNewRecord: Boolean);
//var
//  Title: string;
//  curParentID: Integer;
//  DefaultTitle: string;
begin
//  DefaultTitle := 'Grupa noua';
//  if (IBCQueryTree.State = dsEdit) then
//    DefaultTitle := IBCQueryTree.FieldByName('TITLE_ROM').AsString;
//
//  Title := InputBox('Grupa de sabloane', 'Denumire sablon', DefaultTitle);
//  curParentID := IBCQueryTree.FieldByName('templateid').AsInteger;
//  if not IsNewRecord then
//  begin
//    IBCQueryTree.Edit;
//  end
//  else
//  begin
//    IBCQueryTree.Append;
//    IBCQueryTree.FieldByName('parentid').AsInteger := curParentID;
//    IBCQueryTree.FieldByName('FLG_FOLDER').AsInteger := 1;
//  end;
//  IBCQueryTree.FieldByName('title_rom').AsString := Title;
//  IBCQueryTree.Post;
end;

end.

