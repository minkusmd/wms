unit frmWebCatalogDialog;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, dxBar,
    cxStyles, DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGrid, cxTL, ExtCtrls, cxDBTL, DBAccess,
    IBC, StdCtrls, System.UITypes, cxDBLabel, cxDBEdit, cxButtons, dxPSCore, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
    dxScrollbarAnnotations, cxImageComboBox, cxCheckBox, cxContainer, cxMaskEdit, cxTextEdit, cxLabel, cxTLdxBarBuiltInMenu,
    Vcl.Menus, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkGnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
    dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
    dxPScxPageControlProducer, dxPScxGridLnk, dxPScxGridLayoutViewLnk, dxPScxEditorProducers, dxPScxExtEditorProducers, MemDS,
    cxClasses, cxMemo, cxInplaceContainer, cxTLData, cxImage, cxGridTableView, cxGridCustomView, dxBarBuiltInMenu, cxPC,
    cxSplitter, dxShellDialogs, SWNUtils, dxUIAClasses;

type
    TfrmWebCatalogDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        dxBarDockControl1: TdxBarDockControl;
        dxBarManager: TdxBarManager;
        dxBarManagerBar1: TdxBar;
        bbNewFolderLevel2: TdxBarButton;
        bbModifyFolder: TdxBarButton;
        bbDeleteFolder: TdxBarButton;
        bbAddGoodsGroup: TdxBarButton;
        bbRemoveGoods: TdxBarButton;
        bbSortGoods: TdxBarButton;
        Panel2: TPanel;
        pnGoods: TPanel;
        pnTree: TPanel;
        dxBarDockControl2: TdxBarDockControl;
        dxBarManagerBar2: TdxBar;
        bbNewFolderLevel3: TdxBarButton;
        cxDBTreeList: TcxDBTreeList;
        IBCQueryTree: TIBCQuery;
        IBCDataSourceTree: TIBCDataSource;
        cxDBTreeList_TITLE: TcxDBTreeListColumn;
        cxDBTreeList_CATALOGID: TcxDBTreeListColumn;
        bbSortCatalog: TdxBarButton;
        cxDBTreeList_FLG_ENABLED: TcxDBTreeListColumn;
        IBCQueryGoods: TIBCQuery;
        IBCDataSourceGoods: TIBCDataSource;
        cxDBTreeList_TITLE_RUS: TcxDBTreeListColumn;
        bbCatalogFilters: TdxBarButton;
        bbVirtualFolders: TdxBarButton;
        cxDBTreeList_FILTER_COUNT: TcxDBTreeListColumn;
        IBCTrUpdate: TIBCTransaction;
        bbCompatibleGoods: TdxBarButton;
        cxDBTreeList_CUSTOM_PRICE_COLUMN_DISPLAY: TcxDBTreeListColumn;
        bbBanners: TdxBarButton;
        pnButtons: TPanel;
        cxDBTreeList_ORDERNO: TcxDBTreeListColumn;
        bbNewFolder: TdxBarSubItem;
        bbNewFolderLevel1: TdxBarButton;
        bbCopyNodeProps: TdxBarSubItem;
        bbGroupImage: TdxBarButton;
        IBCDataSourceImage: TIBCDataSource;
        IBCQueryImage: TIBCQuery;
        bbMoveFolder: TdxBarButton;
        dxBarButton1: TdxBarButton;
        bbPasteFromNode: TdxBarButton;
        bbAlsoBuy: TdxBarButton;
        cxDBTreeListcxDBTreeListColumn8: TcxDBTreeListColumn;
        cxDBTreeListcxDBTreeListColumn9: TcxDBTreeListColumn;
        btnCancel: TcxButton;
        IBCQueryCatalogSeo: TIBCQuery;
        IBCDataSourceCatalogSeo: TIBCDataSource;
        Panel1: TPanel;
        cxGridCatalog: TcxGrid;
        cxGridCatalogTable: TcxGridDBTableView;
        cxGridCatalog_IMG: TcxGridDBColumn;
        cxGridCatalog_GOODSPARENTID: TcxGridDBColumn;
        cxGridCatalog_TITLE: TcxGridDBColumn;
        cxGridCatalog_GOODS_COUNT: TcxGridDBColumn;
        cxGridCatalog_FLG_SEE_ALSO: TcxGridDBColumn;
        cxGridCatalogLevel: TcxGridLevel;
        pnImage: TPanel;
        imgIMAGE: TcxDBImage;
        cxDBLabel1: TcxDBLabel;
        dxBarDockControl3: TdxBarDockControl;
        dxBarManagerBar3: TdxBar;
        bbNewSeeAlso: TdxBarButton;
        bbDeleteSeeAlso: TdxBarButton;
        cxGridSeeAlsoView: TcxGridDBTableView;
        cxGridSeeAlsoLevel1: TcxGridLevel;
        cxGridSeeAlso: TcxGrid;
        cxGridSeeAlsoView_GOODSID: TcxGridDBColumn;
        cxGridSeeAlsoView_GOODS_NAME: TcxGridDBColumn;
        IBCQuerySeeAlso: TIBCQuery;
        IBCDataSourceSeeAlso: TIBCDataSource;
        dxComponentPrinter1: TdxComponentPrinter;
        dxBarButton2: TdxBarButton;
        cxDBTreeList_PoliticaPet: TcxDBTreeListColumn;
        cxGrid1DBTableView1: TcxGridDBTableView;
        cxGrid1Level1: TcxGridLevel;
        cxGrid1: TcxGrid;
        cxLabel1: TcxLabel;
        IBCQueryGoodsList: TIBCQuery;
        IBCDataSourceGoodsList: TIBCDataSource;
        cxGrid1DBTableView1Column1: TcxGridDBColumn;
        cxGrid1DBTableView1Column2: TcxGridDBColumn;
        bbNewFolderLevel4: TdxBarButton;
        dxBarButton3: TdxBarButton;
        dxBarPopupMenu1: TdxBarPopupMenu;
        bbNewFolderCurrentLevel: TdxBarButton;
        cxDBTreeList_PARENTID: TcxDBTreeListColumn;
        cxDBTreeListcx_FLG_POPULAR: TcxDBTreeListColumn;
        cxDBTreeListcx_URL_RO: TcxDBTreeListColumn;
        cxSplitter1: TcxSplitter;
        cxPageControl1: TcxPageControl;
        cxTabSheet1: TcxTabSheet;
        cxTabSheet2: TcxTabSheet;
        cxDBMemo1: TcxDBMemo;
        cxDBMemo2: TcxDBMemo;
        cxDBMemo3: TcxDBMemo;
        cxDBMemo4: TcxDBMemo;
        dxBarDockControl4: TdxBarDockControl;
        dxBarManagerBar4: TdxBar;
        bbNewArticle: TdxBarButton;
        bbEditArticle: TdxBarButton;
        bbDeleteArticle: TdxBarButton;
        cxGrid2DBTableView1: TcxGridDBTableView;
        cxGrid2Level1: TcxGridLevel;
        cxGrid2: TcxGrid;
        cxGrid2DBTableView1_ARTICLEID: TcxGridDBColumn;
        cxGrid2DBTableView1_TITLE_RO: TcxGridDBColumn;
        cxGrid2DBTableView1_TITLE_RU: TcxGridDBColumn;
        IBCQueryArticles: TIBCQuery;
        IBCDataSourceArticles: TIBCDataSource;
        SaveFileDialog1: TdxSaveFileDialog;
        cxGrid1DBTableView1Column3: TcxGridDBColumn;
        tbsReWriteURL: TcxTabSheet;
        edREWRITE_URL_RUS: TcxDBTextEdit;
        Label4: TLabel;
        edREWRITE_URL_ROM: TcxDBTextEdit;
        Label5: TLabel;
        cxButton1: TcxButton;
        dxBarButton4: TdxBarButton;
        bbCollapse: TdxBarButton;
        btnOK: TcxButton;
        btnVirtualCategories: TcxButton;
        dxBarDockControl5: TdxBarDockControl;
        dxBarManagerBar5: TdxBar;
        bbGenerate: TdxBarButton;
    cxDBTreeListcxDBTreeListColumn14: TcxDBTreeListColumn;
        procedure bbNewFolderLevel2Click(Sender: TObject);
        procedure bbNewFolderLevel3Click(Sender: TObject);
        procedure cxDBTreeListFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
        procedure bbModifyFolderClick(Sender: TObject);
        procedure cxDBTreeListStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode:
            TcxTreeListNode; var AStyle: TcxStyle);
        procedure bbAddGoodsGroupClick(Sender: TObject);
        procedure bbRemoveGoodsClick(Sender: TObject);
        procedure bbSortCatalogClick(Sender: TObject);
        procedure bbSortGoodsClick(Sender: TObject);
        procedure bbDeleteFolderClick(Sender: TObject);
        procedure cxGridCatalogTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
            TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure cxDBTreeList_FILTER_COUNTGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode; var Value: string);
        procedure bbCatalogFiltersClick(Sender: TObject);
        procedure bbVirtualFoldersClick(Sender: TObject);
        procedure bbCompatibleGoodsClick(Sender: TObject);
        procedure bbBannersClick(Sender: TObject);
        procedure btnVirtualCategoriesClick(Sender: TObject);
        procedure cxDBTreeListGetNodeImageIndex(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; AIndexType:
            TcxTreeListImageIndexType; var AIndex: TImageIndex);
        procedure bbNewFolderLevel1Click(Sender: TObject);
        procedure cxDBTreeList_CUSTOM_PRICE_COLUMN_DISPLAYGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode;
            var Value: string);
        procedure bbGroupImageClick(Sender: TObject);
        procedure bbMoveFolderClick(Sender: TObject);
        procedure dxBarButton1Click(Sender: TObject);
        procedure bbPasteFromNodeClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure bbAlsoBuyClick(Sender: TObject);
        procedure bbCollapseClick(Sender: TObject);
        procedure IBCQueryGoodsAfterInsert(DataSet: TDataSet);
        procedure bbNewSeeAlsoClick(Sender: TObject);
        procedure bbDeleteSeeAlsoClick(Sender: TObject);
        procedure dxBarButton2Click(Sender: TObject);
        procedure bbNewFolderLevel4Click(Sender: TObject);
        procedure dxBarButton3Click(Sender: TObject);
        procedure bbNewFolderCurrentLevelClick(Sender: TObject);
        procedure bbNewArticleClick(Sender: TObject);
        procedure bbEditArticleClick(Sender: TObject);
        procedure bbDeleteArticleClick(Sender: TObject);
        procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure cxButton1Click(Sender: TObject);
        procedure dxBarButton4Click(Sender: TObject);
        procedure bbGenerateClick(Sender: TObject);
    private    { Private declarations }
        fCatalogIdToCopy: Integer;
        FWebCatalogID: Integer;
        procedure SelectionChanged;
        procedure SelectedGoodsChanged;
        procedure ShowCreateLevel1ForlderDialog(ParentID: Integer);
        procedure ShowCreateLevel2ForlderDialog(ParentID: Integer);
        procedure ShowCreateLevel3FolderDialog(ParentID: Integer);
        procedure ShowCreateLevel4FolderDialog(ParentID: Integer);
        procedure ShowModifyLevelFolderDialog;
        procedure ShowAddGoodsFoldersDialog;
        procedure AddGoodsFolderDB(const GoodsParentID: Integer);
        procedure DeleteCatalogFolder;
        procedure DeleteSelectedGoodsFolder;
        procedure ShowSortCatalogDialog;
        procedure ShowSortGoodsFoldersDialog;
        procedure ShowCatalogFiltersDialog(const CatalogID: Integer; const TitleRom, TitleRus: string);
        procedure ShowVirtualFoldersDialog(const CatalogID: Integer);
        procedure RebuildCatalogLevels;
        procedure ShowCompatibleGoodsDialog;
        procedure ShowBannersEditor(const CatalogID: Integer);
        procedure ShowEditGroupImageDialog;
        procedure ShowMoveFolderDialog;
        procedure SetCatalogIdToCopy(const Value: Integer);
        procedure ShowCopyNodePropsDialog(const SourceCatalogID, TargetParentID: Integer);
        function CopyCatalogItem(const SourceCatalogID, TargetParentID: Integer; const CopyGoods, CopyFilters, CopyBaners,
            CopyAlsoBuyGoods: Boolean): Integer;
        procedure ShowAlsoBuyDialog;

    protected    { protected declarations }
        procedure Prepare; override;
        procedure LoadStates; override;
        procedure SaveStates; override;
        procedure SetupSecurityItems; override;
        procedure ShowArticleEditorDlg(IsNewRecord: Boolean);
        function IsFormDataPosted: boolean; override;
        property CatalogIdToCopy: Integer read fCatalogIdToCopy write SetCatalogIdToCopy;
    public
        FirmaID: Integer;
        procedure AddSeeAlsoFolder(const FolderID: Integer);
        procedure SelectWebCatalog;
        property WebCatalogID: Integer read FWebCatalogID write FWebCatalogID;
    { Public declarations }
    end;

implementation

uses
    DataModuleDB, DataModuleAdditions, frmWebCatalogLevel2Dialog, frmWebCatalogLevel3Dialog, frmGoods, SWNDBErrors, SWNConst,
    frmChangeOrderNoDialog, frmWebCatalogFiltersDialog, frmWebCatalogCompatibleGroupsDialog, SWNSecurityFlags, SWNSecurity,
    frmWebCatalogBannersDialog, frmWebCatalogLevel1Dialog, frmWebCatalogImageDialog, frmChangeParentFolderDialog,
    frmWebCatalogCopyItemDialog, frmWebCatalogAlsoBuyDialog, frmWebArticleEditorDialog, cxTLExportLink, frmWebCatalogLevel4Dialog,
    frmWebCatalogVirtualFoldersDialog,
    frmWebVirtualCategoriesDialog;

{$R *.dfm}
{ TfrmWebCatalogDlg }

procedure TfrmWebCatalogDlg.AddGoodsFolderDB(const GoodsParentID: Integer);
begin
    IBCQueryGoods.UpdateTransaction.StartTransaction;
    try
        IBCQueryGoods.Append;
        IBCQueryGoods.FieldByName('GOODSPARENTID').AsInteger := GoodsParentID;
        IBCQueryGoods.Post;
        IBCQueryGoods.UpdateTransaction.Commit;
    except
        on E: Exception do
        begin
            IBCQueryGoods.Cancel;
            IBCQueryGoods.UpdateTransaction.Rollback;
            if not ProcessSWNError(E) then
                raise;
        end;
    end;
end;

procedure TfrmWebCatalogDlg.AddSeeAlsoFolder(const FolderID: Integer);
begin
    IBCQuerySeeAlso.UpdateTransaction.StartTransaction;
    try
        IBCQuerySeeAlso.Append;
        IBCQuerySeeAlso.FieldByName('GOODSFOLDERID').AsInteger := FolderID;
        IBCQuerySeeAlso.Post;
        if IBCQuerySeeAlso.UpdateTransaction.Active then
            IBCQuerySeeAlso.UpdateTransaction.Commit;
    except
        on E: Exception do
        begin
            IBCQuerySeeAlso.Cancel;
            IBCQuerySeeAlso.UpdateTransaction.Rollback;
            if not ProcessSWNError(E) then
                raise;
        end;
    end;
end;

procedure TfrmWebCatalogDlg.bbAddGoodsGroupClick(Sender: TObject);
begin
    ShowAddGoodsFoldersDialog;
end;

procedure TfrmWebCatalogDlg.bbAlsoBuyClick(Sender: TObject);
begin
    ShowAlsoBuyDialog;
end;

procedure TfrmWebCatalogDlg.bbBannersClick(Sender: TObject);
begin
    ShowBannersEditor(cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex]);
end;

procedure TfrmWebCatalogDlg.bbCatalogFiltersClick(Sender: TObject);
begin
    ShowCatalogFiltersDialog(cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex], cxDBTreeList.FocusedNode.Values
        [cxDBTreeList_TITLE.Position.ColIndex], cxDBTreeList.FocusedNode.Values[cxDBTreeList_TITLE_RUS.Position.ColIndex]);
end;

procedure TfrmWebCatalogDlg.bbVirtualFoldersClick(Sender: TObject);
begin
    ShowVirtualFoldersDialog(cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex]);
end;

procedure TfrmWebCatalogDlg.bbCollapseClick(Sender: TObject);
begin
    cxDBTreeList.FullCollapse;
end;

procedure TfrmWebCatalogDlg.bbCompatibleGoodsClick(Sender: TObject);
begin
    ShowCompatibleGoodsDialog;
end;

procedure TfrmWebCatalogDlg.bbDeleteArticleClick(Sender: TObject);
begin
    if MessageDlg('Stergeti articolul dat ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
        if not IBCTrUpdate.Active then
            IBCTrUpdate.StartTransaction;

        IBCQueryArticles.Delete;
        IBCTrUpdate.Commit;
    end;
end;

procedure TfrmWebCatalogDlg.bbDeleteFolderClick(Sender: TObject);
begin
    DeleteCatalogFolder;
end;

procedure TfrmWebCatalogDlg.bbDeleteSeeAlsoClick(Sender: TObject);
begin
    if MessageDlg('Stergeti inregistrarea: #' + IBCQuerySeeAlso.FieldByName('GOODSFOLDERID').AsString + ' ?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
    begin
        IBCQuerySeeAlso.Delete;
    end;
end;

procedure TfrmWebCatalogDlg.bbEditArticleClick(Sender: TObject);
begin
    ShowArticleEditorDlg(True);
end;

procedure TfrmWebCatalogDlg.bbGenerateClick(Sender: TObject);
begin
    dmdb.executequery('Execute PROCEDURE SP_META_CATALOG(:catalogid)', [IBCQueryTree.fieldbyname('catalogid').AsInteger]);
    IBCQueryCatalogSeo.Refresh;
end;

procedure TfrmWebCatalogDlg.bbGroupImageClick(Sender: TObject);
begin
    ShowEditGroupImageDialog;
end;

procedure TfrmWebCatalogDlg.bbModifyFolderClick(Sender: TObject);
begin
    ShowModifyLevelFolderDialog;
end;

procedure TfrmWebCatalogDlg.bbMoveFolderClick(Sender: TObject);
begin
    ShowMoveFolderDialog;
end;

procedure TfrmWebCatalogDlg.bbNewArticleClick(Sender: TObject);
begin
    ShowArticleEditorDlg(True);
end;

procedure TfrmWebCatalogDlg.bbNewFolderCurrentLevelClick(Sender: TObject);
var
    ParentID: Integer;
begin
    ParentID := cxDBTreeList.FocusedNode.Values[cxDBTreeList_PARENTID.Position.ColIndex];
    case cxDBTreeList.FocusedNode.Level of
        0:
            begin
                ParentID := -1;
                ShowCreateLevel1ForlderDialog(ParentID);
            end;
        1:
            ShowCreateLevel2ForlderDialog(ParentID);
        2:
            ShowCreateLevel3FolderDialog(ParentID);
        3:
            ShowCreateLevel4FolderDialog(ParentID);
//    else
//        begin
//            ParentID := -1;
//            ShowCreateLevel1ForlderDialog(ParentID);
//        end;
    end;
end;

procedure TfrmWebCatalogDlg.bbNewFolderLevel1Click(Sender: TObject);
begin
    ShowCreateLevel1ForlderDialog(-1);
end;

procedure TfrmWebCatalogDlg.bbNewFolderLevel2Click(Sender: TObject);
begin
//  ShowCreateLevel2ForlderDialog(;
end;

procedure TfrmWebCatalogDlg.cxButton1Click(Sender: TObject);
var
    s: string;
begin
    if not IBCTrUpdate.Active then
        IBCTrUpdate.StartTransaction;
    IBCQueryTree.Edit;

    try
        s := IBCQueryTree.FieldByName('TITLE').AsString;
        s := StringReplace(s, ',', '-', [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, ' ', '-', [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, '/', '-', [rfReplaceAll, rfIgnoreCase]);
        s := BestFit(s);
        IBCQueryTree.FieldByName('REWRITE_URL_ROM').AsString := s.ToLower;
        IBCQueryTree.FieldByName('REWRITE_URL_RUS').AsString := s.ToLower;

//        s := IBCQueryTree.FieldByName('TITLE').AsString;
//        s := StringReplace(s, ', ', ' ', [rfReplaceAll, rfIgnoreCase]);
//        s := StringReplace(s, ' ', '-', [rfReplaceAll, rfIgnoreCase]);
//        s := StringReplace(s, '/', '-', [rfReplaceAll, rfIgnoreCase]);
//        IBCQueryTree.FieldByName('REWRITE_URL_RUS').AsString := TranslitRus2Lat(s.ToLower);

        IBCQueryTree.Post;
        IBCTrUpdate.Commit;
    except
        begin
            IBCQueryTree.Cancel;
            IBCTrUpdate.Rollback;
            raise;
        end;
    end;
end;

procedure TfrmWebCatalogDlg.cxDBTreeListFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode:
    TcxTreeListNode);
begin
    if (AFocusedNode <> APrevFocusedNode) then
        SelectionChanged;
end;

procedure TfrmWebCatalogDlg.cxDBTreeListGetNodeImageIndex(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; AIndexType:
    TcxTreeListImageIndexType; var AIndex: TImageIndex);
var
    itemEnabled: Boolean;
begin
    if not VarIsNull(ANode.Values[cxDBTreeList_FLG_ENABLED.Position.ColIndex]) then
    begin
        itemEnabled := ANode.Values[cxDBTreeList_FLG_ENABLED.Position.ColIndex] = 1;
        if itemEnabled then
            case ANode.Level of
                0:
                    if ANode.HasChildren then
                        AIndex := 14
                    else
                        AIndex := 13;
                1:
                    if ANode.HasChildren then
                        AIndex := 14
                    else
                        AIndex := 13;
                2:
                    if ANode.HasChildren then
                        AIndex := 14;
            end
        else
            AIndex := 55;
    end;
end;

procedure TfrmWebCatalogDlg.cxDBTreeListStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode:
    TcxTreeListNode; var AStyle: TcxStyle);
begin
    if ANode.Values[cxDBTreeList_FLG_ENABLED.ItemIndex] = 0 then
        AStyle := dmAdditions.cxStyle_TextGray
end;

procedure TfrmWebCatalogDlg.cxDBTreeList_CUSTOM_PRICE_COLUMN_DISPLAYGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
begin
    if (ANode.Level <> 2) then
        Value := '';
end;

procedure TfrmWebCatalogDlg.cxDBTreeList_FILTER_COUNTGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode; var
    Value: string);
begin
    if (ANode.Level <> 2) then
        Value := '';
end;

procedure TfrmWebCatalogDlg.cxGridCatalogTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
    AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    SelectedGoodsChanged;
end;

procedure TfrmWebCatalogDlg.DeleteCatalogFolder;
var
    CurrentNode, NextNode: TcxTreeListNode;
begin
    if ShowAskDialog(Caption, Format('Stergeti mapa "%s"?', [IBCQueryTree.FieldByName('TITLE').AsString])) = mrYes then
    begin
//    IBCQueryTree.UpdateTransaction.StartTransaction;
        try
            // Obtine nodul curent
            CurrentNode := cxDBTreeList.FocusedNode;
            cxDBTreeList.BeginUpdate;
            try
            if Assigned(CurrentNode) then
            begin
            // Incearca sa obtii nodul urmator de pe acelasi nivel
                NextNode := CurrentNode.GetNextSibling;
            // Daca nu exista nodul urmator, treci la nodul parinte
                if not Assigned(NextNode) then
                    NextNode := CurrentNode.Parent;
            // Sterge nodul curent
                if not IBCQueryTree.UpdateTransaction.Active then
                begin
                  IBCQueryTree.UpdateTransaction.StartTransaction;
                  IBCQueryTree.Delete;
                  IBCQueryTree.UpdateTransaction.Commit;
                end;

                //cxDBTreeList.DataController.DeleteFocused
                // Seteaza focus pe nodul calculat (urmator sau parinte)
                if Assigned(NextNode) then
                    cxDBTreeList.FocusedNode := NextNode;
            end;
            finally
                cxDBTreeList.EndUpdate;
            end;

//      cxDBTreeList.DataController.Post(True);
//      IBCQueryTree.Delete;
//      IBCQueryTree.UpdateTransaction.Commit;
        except
            on E: Exception do
            begin
                IBCQueryTree.UpdateTransaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    end;
end;

procedure TfrmWebCatalogDlg.DeleteSelectedGoodsFolder;
begin
    if ShowAskDialog(Caption, Format('Stergeti grupa de produse "%s"?', [IBCQueryGoods.FieldByName('TITLE').AsString])) =
        mrYes then
    begin
        IBCQueryGoods.UpdateTransaction.StartTransaction;
        try
            IBCQueryGoods.Delete;
            IBCQueryGoods.UpdateTransaction.Commit;
        except
            on E: Exception do
            begin
//        IBCQueryGoods.UpdateTransaction.Rollback;
//        if not ProcessSWNError(E) then
                raise;
            end;
        end;
    end;
end;

procedure TfrmWebCatalogDlg.dxBarButton1Click(Sender: TObject);
begin
    CatalogIdToCopy := IBCQueryTree.FieldByName('CATALOGID').AsInteger;

end;

procedure TfrmWebCatalogDlg.dxBarButton2Click(Sender: TObject);
begin
    cxDBTreeList.FullExpand;
    cxDBTreeList.CopyAllToClipboard;
    if SaveFileDialog1.Execute then
    begin
        cxExportTLToExcel(ExtractFilePath(Application.ExeName) + '\webtree.xls', cxDBTreeList, True, True, True);
    end;
end;

procedure TfrmWebCatalogDlg.dxBarButton3Click(Sender: TObject);
var
    ParentID: Integer;
begin
    ParentID := cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex];
    case cxDBTreeList.FocusedNode.Level of
        0:
            ShowCreateLevel2ForlderDialog(ParentID);
        1:
            ShowCreateLevel3FolderDialog(ParentID);
        2:
            ShowCreateLevel4FolderDialog(ParentID);
    end;
end;

procedure TfrmWebCatalogDlg.FormCreate(Sender: TObject);
begin
    fCatalogIdToCopy := -1;
end;

procedure TfrmWebCatalogDlg.IBCQueryGoodsAfterInsert(DataSet: TDataSet);
begin
    DataSet.FieldByName('CATALOGID').AsInteger := IBCQueryTree.FieldByName('CATALOGID').AsInteger;
end;

function TfrmWebCatalogDlg.IsFormDataPosted: boolean;
begin
    result := True;
    WebCatalogID := IBCQueryTree.FieldByName('CatalogID').AsInteger;
end;

procedure TfrmWebCatalogDlg.bbNewFolderLevel3Click(Sender: TObject);
begin
//  ShowCreateLevel3FolderDialog;
end;

procedure TfrmWebCatalogDlg.bbNewSeeAlsoClick(Sender: TObject);
var
    dialog: TfrmGoodsBrowser;
begin
    dialog := TfrmGoodsBrowser.Create(Self);
    try
        if dialog.SelectGoods(IBCQuerySeeAlso.FieldByName('GOODSFOLDERID').AsInteger, True, 0, Format('Alegeti grupa de produse "%s"',
            [IBCQueryTree.FieldByName('TITLE').AsString])) then
        begin
            if dialog.GoodsIsFolder then
            begin
                AddSeeAlsoFolder(dialog.GoodsID);
            end
            else
            begin
                ShowErrorDialog(cMSG_GeneralError_Title, 'Se accepta doar mape din nomenclatorul de produse!');
            end;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.bbPasteFromNodeClick(Sender: TObject);
var
    parentID: Integer;
begin
    parentID := -1;
    case cxDBTreeList.FocusedNode.Level of
        0:
            parentID := cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex];
        1:
            parentID := cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex];
        2:
            parentID := cxDBTreeList.FocusedNode.Parent.Values[cxDBTreeList_CATALOGID.Position.ColIndex];
    end;
    ShowCopyNodePropsDialog(fCatalogIdToCopy, parentID);
end;

procedure TfrmWebCatalogDlg.bbRemoveGoodsClick(Sender: TObject);
begin
    DeleteSelectedGoodsFolder;
end;

procedure TfrmWebCatalogDlg.bbSortCatalogClick(Sender: TObject);
begin
    ShowSortCatalogDialog;
end;

procedure TfrmWebCatalogDlg.bbSortGoodsClick(Sender: TObject);
begin
    ShowSortGoodsFoldersDialog;
end;

function TfrmWebCatalogDlg.CopyCatalogItem(const SourceCatalogID, TargetParentID: Integer; const CopyGoods, CopyFilters,
    CopyBaners, CopyAlsoBuyGoods: Boolean): Integer;
var
    Query: TIBCQuery;
begin
    Result := -1;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.AutoCommit := False;
        Query.Transaction := IBCTrUpdate;
        Query.SQL.Text :=
            'SELECT NEWCATALOGID FROM SP_WEB_COPY_CATALOG_ITEM(:sid,:tid,:copyGoods,:copyFilters,:copyBaners,:copyAlsoBuy)';
        Query.ParamByName('sid').Value := SourceCatalogID;
        Query.ParamByName('tid').Value := TargetParentID;
        Query.ParamByName('copyGoods').Value := Ord(CopyGoods);
        Query.ParamByName('copyFilters').Value := Ord(CopyFilters);
        Query.ParamByName('copyBaners').Value := Ord(CopyBaners);
        Query.ParamByName('copyAlsoBuy').Value := Ord(CopyAlsoBuyGoods);
        Query.Transaction.StartTransaction;
        try
            Query.Execute;
            if not Query.Eof then
            begin
                Result := Query.Fields[0].AsInteger;
            end;
            Query.Transaction.Commit;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmWebCatalogDlg.bbNewFolderLevel4Click(Sender: TObject);
begin
//  ShowCreateLevel3FolderDialog;
end;

procedure TfrmWebCatalogDlg.cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    SWNUtils.ProcessCommonKeys(Self, cxGrid1DBTableView1, Key, Shift);
end;

procedure TfrmWebCatalogDlg.dxBarButton4Click(Sender: TObject);
begin
    cxDBTreeList.FullExpand;
end;

procedure TfrmWebCatalogDlg.LoadStates;
begin
    inherited;

end;

procedure TfrmWebCatalogDlg.Prepare;
begin
//    if (FirmaID = 0) then
    FirmaID := dmdb.CurrentFirma;
    IBCQueryTree.ParamByName('DT').AsInteger := FirmaID;
    IBCQueryTree.Active := True;

    IBCQueryGoods.Active := True;
    IBCQueryImage.Active := True;
    IBCQueryCatalogSeo.Active := True;
    IBCQuerySeeAlso.Active := True;
    IBCQueryGoodsList.Active := True;
    cxDBTreeList.DataController.TreeList.FullCollapse;
    IBCQueryArticles.Active := True;
    SelectionChanged;
    dtDialogTitle.Title := Format('Catalogul de produse pentru intreprinderea "%d"', [FirmaID]);
end;

procedure TfrmWebCatalogDlg.SaveStates;
begin
    inherited;

end;

procedure TfrmWebCatalogDlg.SelectedGoodsChanged;
var
    fDelete, fSort: Boolean;
begin
    fDelete := False;
    fSort := cxGridCatalogTable.DataController.RecordCount > 1;
    if cxGridCatalogTable.DataController.RecNo > 0 then
    begin
        fDelete := True;
    end;
    bbRemoveGoods.Enabled := fDelete;
    bbSortGoods.Enabled := fSort;
end;

procedure TfrmWebCatalogDlg.SelectionChanged;
var
    fL1, fL2, fL3, fL4, fEdit, fDelete, fFilters, fCompatible: Boolean;
    fAddGoods, fBanners, fCopyID, fPaste: Boolean;
    parentLevel: Integer;
    Level: Integer;
begin
    fL1 := True;
    fL2 := False;
    fL3 := False;
    fL4 := False;
    fEdit := False;
    fDelete := False;
    fFilters := False;
    fAddGoods := False;
    fCompatible := False;
    fBanners := False;
    fCopyID := False;
    fPaste := False;

    if Assigned(cxDBTreeList.FocusedNode) then
    begin
        parentLevel := cxDBTreeList.FocusedNode.Parent.Level;
        Level := cxDBTreeList.FocusedNode.Level;

        fL2 := (parentLevel = 0) or (Level = 0);
        fL3 := (parentLevel = 1) or (Level = 1);
        fL4 := (parentLevel = 2) or (Level = 2);
        fEdit := True;
        fDelete := not cxDBTreeList.FocusedNode.HasChildren;
        fFilters := (Level >= 2);
        fCompatible := (Level >= 2);
    // goods
        fAddGoods := Level >= 2;
    // banners
        fBanners := Level >= 2;
        fCopyID := True;
        fPaste := fCatalogIdToCopy <> -1;
    end;
    bbNewFolderLevel1.Enabled := fL1;
    bbNewFolderLevel2.Enabled := fL2;
    bbNewFolderLevel3.Enabled := fL3;
    bbNewFolderLevel4.Enabled := fL4;
    bbNewFolder.Enabled := fL1 or fL2 or fL3;

    bbModifyFolder.Enabled := fEdit;
    bbDeleteFolder.Enabled := fDelete;

    bbMoveFolder.Enabled := fL2 or fL3 or fL4;
    bbCatalogFilters.Enabled := fFilters;
    bbVirtualFolders.Enabled := fFilters;
    bbCompatibleGoods.Enabled := fCompatible;
  // goods
    bbAddGoodsGroup.Enabled := fAddGoods;
  // banners
    bbBanners.Enabled := fBanners;
  // group image
//  bbGroupImage.Enabled := (fL3 or fL1);
    bbGroupImage.Enabled := True; //  02.11.2019 toate nivele pot avea imagini.
    bbAlsoBuy.Enabled := fFilters;

    bbCopyNodeProps.Enabled := fCopyID;
    bbPasteFromNode.Enabled := fPaste;

    SelectedGoodsChanged;
end;

procedure TfrmWebCatalogDlg.SelectWebCatalog;
begin
    WebCatalogID := -1;
    btnOK.Visible := True;
    btnCancel.Caption := 'Renunta';

    if (ShowModal = mrOK) then
    begin
        WebCatalogID := ibcqueryTree.FieldByName('CatalogID').AsInteger;
    end;
    btnOK.Visible := False;
    btnCancel.Caption := 'Inchide';
end;

procedure TfrmWebCatalogDlg.SetCatalogIdToCopy(const Value: Integer);
begin
    fCatalogIdToCopy := Value;
    SelectionChanged;
end;

procedure TfrmWebCatalogDlg.SetupSecurityItems;
begin
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_WКТ_Создать) then
    begin
        bbNewFolderLevel1.Visible := ivNever;
        bbNewFolderLevel2.Visible := ivNever;
    end;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_WКТ_Редактировать) then
    begin
        bbModifyFolder.Visible := ivNever;
        bbSortCatalog.Visible := ivNever;
    end;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_WКТ_Удалить) then
        bbDeleteFolder.Visible := ivNever;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_WКТ_Фильтры) then
        bbCatalogFilters.Visible := ivNever;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_WКТ_Совместимые_товары) then
        bbCompatibleGoods.Visible := ivNever;

    if dxBarManagerBar1.ItemLinks.VisibleItemCount = 0 then
    begin
        dxBarManagerBar1.Visible := False;
        dxBarDockControl1.Visible := False;
    end;

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_WКТ_Группы_товаров) then
    begin
        bbAddGoodsGroup.Visible := ivNever;
        bbRemoveGoods.Visible := ivNever;
        bbSortGoods.Visible := ivNever;
    end;

    if dxBarManagerBar2.ItemLinks.VisibleItemCount = 0 then
    begin
        dxBarManagerBar2.Visible := False;
        dxBarDockControl2.Visible := False;
    end;
end;

procedure TfrmWebCatalogDlg.ShowAddGoodsFoldersDialog;
var
    dialog: TfrmGoodsBrowser;
begin
    dialog := TfrmGoodsBrowser.Create(Self);
    try
        if dialog.SelectGoods(IBCQueryGoods.FieldByName('GOODSPARENTID').AsInteger, True, 0, Format('Alegeti grupa de produse "%s"',
            [IBCQueryTree.FieldByName('TITLE').AsString])) then
        begin
            if dialog.GoodsIsFolder then
            begin
                AddGoodsFolderDB(dialog.GoodsID);
            end
            else
            begin
                ShowErrorDialog(cMSG_GeneralError_Title, 'Se accepta doar mape din nomenclatorul de produse!');
            end;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowAlsoBuyDialog;
var
    dialog: TfrmWebCatalogAlsoBuyDlg;
begin
    dialog := TfrmWebCatalogAlsoBuyDlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowArticleEditorDlg(IsNewRecord: Boolean);
var
    dialog: TfrmWebArticleEditorDlg;
begin
    dialog := TfrmWebArticleEditorDlg.Create(Self, ibcqueryarticles, ibcdatasourcearticles);
    try
        dialog.IsNewRecord := IsNewRecord;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowBannersEditor(const CatalogID: Integer);
var
    dialog: TfrmWebCatalogBannersDlg;
begin
    dialog := TfrmWebCatalogBannersDlg.Create(Self, IBCTrUpdate);
    try
        dialog.CatalogID := CatalogID;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowCatalogFiltersDialog(const CatalogID: Integer; const TitleRom, TitleRus: string);
var
    dialog: TfrmWebCatalogFiltersDlg;
begin
    dialog := TfrmWebCatalogFiltersDlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
    try
        dialog.CatalogID := CatalogID;
        dialog.SetTitles(TitleRom, TitleRus);
        if dialog.ShowModal = mrOk then
            IBCQueryTree.Refresh;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowVirtualFoldersDialog(const CatalogID: Integer);
var
    dialog: TfrmWebCatalogVirtualFoldersDlg;
begin
    dialog := TfrmWebCatalogVirtualFoldersDlg.Create(Self, IBCTrUpdate);
    try
        dialog.CatalogID := CatalogID;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowCompatibleGoodsDialog;
var
    dialog: TfrmWebCatalogCompatibleGroupsDlg;
begin
    dialog := TfrmWebCatalogCompatibleGroupsDlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowCopyNodePropsDialog(const SourceCatalogID, TargetParentID: Integer);
var
    dialog: TfrmWebCatalogCopyItemDlg;
    newID: Integer;
begin
    dialog := TfrmWebCatalogCopyItemDlg.Create(Self);
    try
        dialog.SourceCatalogID := SourceCatalogID;
        dialog.TargetParentCatalogID := TargetParentID;
        if dialog.ShowModal = mrOk then
        begin
            newID := CopyCatalogItem(SourceCatalogID, TargetParentID, dialog.CopyGoods, dialog.CopyFilters, dialog.CopyBaners,
                dialog.CopyAlsoBuy);
            if newID > 0 then
            begin
                IBCQueryTree.Refresh;
                IBCQueryTree.Locate('CATALOGID', newID, []);
                ShowInfoDialog(Caption, 'Copiere cu succes!');
            end;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowCreateLevel1ForlderDialog(ParentID: Integer);
var
    dialog: TfrmWebCatalogLevel1Dlg;
begin
    dialog := TfrmWebCatalogLevel1Dlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
    try
        dialog.CreateNewFolder := True;
        dialog.DT := FirmaID;
        dialog.DataSourceImage := IBCDataSourceImage;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowCreateLevel2ForlderDialog(ParentID: Integer);
var
    dialog: TfrmWebCatalogLevel2Dlg;
begin
    dialog := TfrmWebCatalogLevel2Dlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
    try
        dialog.CreateNewFolder := True;
        dialog.DT := FirmaID;
//    if (cxDBTreeList.FocusedNode.Level = 0) then
//      parentID := cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex]
//    else if (cxDBTreeList.FocusedNode.Level = 1) then
//      parentID := cxDBTreeList.FocusedNode.Parent.Values[cxDBTreeList_CATALOGID.Position.ColIndex]
//    else
//      parentID := -1;
        dialog.parentID := ParentID;
        dialog.DataSourceImage := IBCDataSourceImage;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
    SelectionChanged;
end;

procedure TfrmWebCatalogDlg.ShowCreateLevel3FolderDialog(ParentID: Integer);
var
    dialog: TfrmWebCatalogLevel3Dlg;
begin
    dialog := TfrmWebCatalogLevel3Dlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
    try
        dialog.CreateNewFolder := True;
        dialog.DT := FirmaID;
        dialog.DataSourceImage := IBCDataSourceImage;
//    if (cxDBTreeList.FocusedNode.Level = 1) then
//      parentID := cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex]
//    else
//    if (cxDBTreeList.FocusedNode.Level = 2) then
//      parentID := cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex]
//    else if (cxDBTreeList.FocusedNode.Level = 3) then
//      parentID := cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex]
//    else
//      parentID := -1;

        dialog.parentID := ParentID;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
    SelectionChanged;
end;

procedure TfrmWebCatalogDlg.ShowCreateLevel4FolderDialog(ParentID: Integer);
var
    dialog: TfrmWebCatalogLevel4Dlg;
begin
    dialog := TfrmWebCatalogLevel4Dlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
    try
        dialog.CreateNewFolder := True;
        dialog.DT := FirmaID;
        dialog.DataSourceImage := IBCDataSourceImage;
        dialog.ParentID := ParentID;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
    SelectionChanged;
end;


procedure TfrmWebCatalogDlg.ShowEditGroupImageDialog;
var
    dialog: TfrmWebCatalogImageDlg;
begin
    dialog := TfrmWebCatalogImageDlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
    try
        if dialog.ShowModal = mrOk then
            IBCQueryImage.Refresh;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowModifyLevelFolderDialog;
var
    dialog1: TfrmWebCatalogLevel1Dlg;
    dialog2: TfrmWebCatalogLevel2Dlg;
    dialog3: TfrmWebCatalogLevel3Dlg;
    dialog4: TfrmWebCatalogLevel4Dlg;
//  Level: Integer;
begin
//  Level := cxDBTreeList.FocusedNode.Level;

    case cxDBTreeList.FocusedNode.Level of
        0:
            begin
        // LEVEL 1
                dialog1 := TfrmWebCatalogLevel1Dlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
                try
                    dialog1.DataSourceImage := IBCDataSourceImage;
                    dialog1.CreateNewFolder := False;
                    dialog1.ShowModal;
                finally
                    dialog1.Free;
                end;
            end;
        1:
            begin
        // LEVEL 2
                dialog2 := TfrmWebCatalogLevel2Dlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
                try
                    dialog2.DataSourceImage := IBCDataSourceImage;
                    dialog2.CreateNewFolder := False;
                    dialog2.ShowModal;
                finally
                    dialog2.Free;
                end;
            end;
        2:
            begin
        // LEVEL 3
                dialog3 := TfrmWebCatalogLevel3Dlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
                try
                    dialog3.DataSourceImage := IBCDataSourceImage;
                    dialog3.CreateNewFolder := False;
                    dialog3.ShowModal;
                finally
                    dialog3.Free;
                end;
            end;
        3:
            begin
        // LEVEL 4
                dialog4 := TfrmWebCatalogLevel4Dlg.Create(Self, IBCQueryTree, IBCDataSourceTree);
                try
                    dialog4.DataSourceImage := IBCDataSourceImage;
                    dialog4.CreateNewFolder := False;
                    dialog4.ShowModal;
                finally
                    dialog4.Free;
                end;
            end;

    end;
    SelectionChanged;
end;

procedure TfrmWebCatalogDlg.ShowMoveFolderDialog;
var
    dialog: TfrmChangeParentFolderDlg;
begin
    dialog := TfrmChangeParentFolderDlg.Create(Self);
    try
        dialog.DBTable := dbtWebCatalog;
        dialog.FolderObjectID := IBCQueryTree.FieldByName('PARENTID').AsInteger;
        dialog.AddObjectInfo(IBCQueryTree.FieldByName('CATALOGID').AsInteger, IBCQueryTree.FieldByName('TITLE_RUS').AsString);
        dialog.CurrentFirmaID := FirmaID;
        if dialog.ShowModal = mrOk then
        begin
            RebuildCatalogLevels;
            IBCQueryTree.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

{ CATALOG_LEVEL este denormalizat si se strica la fiecare mutare de nod. Nu il
  citeste nimeni pe site (adancimea vine din WEB_GET_CATALOG_TREE4), deci daca
  procedura lipseste inca in baza nu are rost sa blocam mutarea. }
procedure TfrmWebCatalogDlg.RebuildCatalogLevels;
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(nil);
    try
        try
            q.Transaction := IBCTrUpdate;
            q.SQL.Text := 'EXECUTE PROCEDURE SP_REBUILD_CATALOG_LEVEL';
            if not IBCTrUpdate.Active then
                IBCTrUpdate.StartTransaction;
            q.ExecSQL;
            IBCTrUpdate.Commit;
        except
            if IBCTrUpdate.Active then
                IBCTrUpdate.Rollback;
        end;
    finally
        q.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowSortCatalogDialog;
var
    dialog: TfrmChangeOrderNoDlg;
begin
    dialog := TfrmChangeOrderNoDlg.Create(Self);
    try
        dialog.DBTable := cotWebCatalog;
        dialog.parentID := IBCQueryTree.FieldByName('PARENTID').AsInteger;
        dialog.WhereParam := IntToStr(FirmaID);

        if dialog.ShowModal = mrOk then
        begin
            IBCQueryTree.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.ShowSortGoodsFoldersDialog;
var
    dialog: TfrmChangeOrderNoDlg;
begin
    dialog := TfrmChangeOrderNoDlg.Create(Self);
    try
        dialog.DBTable := cotWebCatalogGoods;
        dialog.parentID := IBCQueryTree.FieldByName('CATALOGID').AsInteger;
        if dialog.ShowModal = mrOk then
        begin
            IBCQueryGoods.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebCatalogDlg.btnVirtualCategoriesClick(Sender: TObject);
var
    d: TfrmWebVirtualCategoriesDlg;
begin
    d := TfrmWebVirtualCategoriesDlg.Create(Self);
    try
        d.ShowModal;
    finally
        d.Free;
    end;
end;

end.