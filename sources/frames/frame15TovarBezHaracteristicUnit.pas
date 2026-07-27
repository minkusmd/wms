unit frame15TovarBezHaracteristicUnit;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    SWNDataFiltering, SWNBaseFrameUnit, cxStyles, cxCustomData, DB, cxDBData,
    cxLabel, cxTL, dxBar, DBAccess, IBC, cxInplaceContainer, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
    Vcl.ExtCtrls, cxDBLabel, cxButtons, cxPC, cxGraphics, cxControls,
    cxLookAndFeels, cxLookAndFeelPainters, cxFilter, cxData, cxDataStorage,
    cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox,
    cxTextEdit, cxTLdxBarBuiltInMenu, dxBarBuiltInMenu, cxContainer, Vcl.Menus,
    cxClasses, MemDS, Vcl.StdCtrls, cxGridCustomView, cxSplitter, System.UITypes,
    frmContentGoodsEditorDialog, dxUIAClasses, cxMaskEdit, cxDBTL, cxTLData;

type
    Tframe15TovarBezHaracteristic = class(TSWNBaseFrame)
        IBCQueryMissGoods: TIBCQuery;
        IBCDataSourceMissGoods: TIBCDataSource;
        IBCQueryTree: TIBCQuery;
        dxBarPopupMenu: TdxBarPopupMenu;
        dxBarManager: TdxBarManager;
        bbGoodsDescriptions: TdxBarButton;
        bbGotoGoods: TdxBarButton;
        bbGoodsQuickInfo: TdxBarButton;
        dxBarSubItem1: TdxBarSubItem;
        bbCheckDesc: TdxBarButton;
        bbCheckPrice: TdxBarButton;
        bbCheckImage: TdxBarButton;
        dxBarButton1: TdxBarButton;
        dxBarButton2: TdxBarButton;
        IBCQuerySalariu: TIBCQuery;
        Panel1: TPanel;
        cxTree: TcxTreeList;
        cxTree_TITLE: TcxTreeListColumn;
        cxTree_GOODSID: TcxTreeListColumn;
        cxTree_SPECIAL: TcxTreeListColumn;
        cxTree_SCANNED: TcxTreeListColumn;
        IBCDataSourceSalariu: TIBCDataSource;
        Panel3: TPanel;
        cxGridGoods: TcxGrid;
        cxGridGoodsTable: TcxGridDBTableView;
        cxGridGoods_GOODSID: TcxGridDBColumn;
        cxGridGoods_GOODS_NAME: TcxGridDBColumn;
        cxGridGoods_MISSINFO: TcxGridDBColumn;
        cxGridGoods_DATA: TcxGridDBColumn;
        cxGridGoodsTableColumn1: TcxGridDBColumn;
        cxGridGoodsLevel: TcxGridLevel;
        cxSplitter1: TcxSplitter;
        cxPageControl2: TcxPageControl;
        tbGoodsNoProperties: TcxTabSheet;
        tbPackages: TcxTabSheet;
        IBCDataSourcePackages: TIBCDataSource;
        tvPacheteWebDB: TcxGridDBTableView;
        cxGridPacheteWebLevel1: TcxGridLevel;
        cxGridPacheteWeb: TcxGrid;
        tvPacheteWebDB_DATASTART: TcxGridDBColumn;
        tvPacheteWebDB_FLG_CLOSED: TcxGridDBColumn;
        tvPacheteWebDB_DATAEND: TcxGridDBColumn;
        tvPacheteWebDB_RESPONSABLE_USERID: TcxGridDBColumn;
        tvPacheteWebDB_PACHETNO: TcxGridDBColumn;
        tvPacheteWebDB_VERIFIED_BY: TcxGridDBColumn;
        dxBarDockControl2: TdxBarDockControl;
        dxBarManagerBar2: TdxBar;
        bbNewPachet: TdxBarButton;
        bbEditPachet: TdxBarButton;
        bbDeletePackage: TdxBarButton;
        tvPacheteWebDB_DATA_ESTIMATIVA: TcxGridDBColumn;
        tvPacheteWebDB_DESCRIPTION: TcxGridDBColumn;
        IBCDataSourcePackageGoods: TIBCDataSource;
        bbDescription: TdxBarButton;
        bbReady: TdxBarButton;
        dxBarSubItem2: TdxBarSubItem;
        dxBarPopupMenuPackage: TdxBarPopupMenu;
        bbApproved: TdxBarButton;
        bbRefreshGoodsInfo: TdxBarButton;
        dxBarPopupMenuPackageGoods: TdxBarPopupMenu;
        bbBadDescription: TdxBarButton;
        tvPacheteWebDB_FLG_CAN_VERITY: TcxGridDBColumn;
        dxBarDockControl3: TdxBarDockControl;
        dxBarManagerBar3: TdxBar;
        bbNewGoods: TdxBarButton;
        bbEditGoods: TdxBarButton;
        bbDeleteGoods: TdxBarButton;
        dxBarDockControl1: TdxBarDockControl;
        dxBarManagerBar1: TdxBar;
        dxBarButton4: TdxBarButton;
        dxBarButton5: TdxBarButton;
        bbCorrectDescription: TdxBarButton;
        bbClosePackage: TdxBarButton;
        tvPacheteWebDB_PRICE: TcxGridDBColumn;
        bbModifyPackage: TdxBarButton;
        cxGridGoods_BRAND: TcxGridDBColumn;
        IBCQueryPackages: TIBCQuery;
        IBCQueryPackageGoods: TIBCQuery;
        dxBarButton6: TdxBarButton;
        Panel2: TPanel;
        cxGrid1: TcxGrid;
        cxGrid1DBTableView1: TcxGridDBTableView;
        cxGrid1Level1: TcxGridLevel;
        cxGridGoodsDesc: TcxGrid;
        tvGoodsDescDB: TcxGridDBTableView;
        tvGoodsDesc_GOODSTYPE_NAME: TcxGridDBColumn;
        tvGoodsDesc_VENDOR_NAME: TcxGridDBColumn;
        tvGoodsDesc_GOODSID: TcxGridDBColumn;
        tvGoodsDesc_GOODSNAME: TcxGridDBColumn;
        tvGoodsDesc_IMAGE_CNT: TcxGridDBColumn;
        tvGoodsDesc_DESC_CNT: TcxGridDBColumn;
        tvGoodsDesc_MODEL_RO: TcxGridDBColumn;
        tvGoodsDesc_PARAM_RO: TcxGridDBColumn;
        tvGoodsDesc_AUX: TcxGridDBColumn;
        tvGoodsDesc_TRY_CNT: TcxGridDBColumn;
        tvGoodsDescDB_BAD_DESCRIPTION: TcxGridDBColumn;
        tvGoodsDesc_FLG_READY: TcxGridDBColumn;
        tvGoodsDesc_FLG_IN_PRICE: TcxGridDBColumn;
        cxGridGoodsDescLevel1: TcxGridLevel;
        cxGrid1DBTableView1Column1: TcxGridDBColumn;
        cxGrid1DBTableView1Column2: TcxGridDBColumn;
        IBCQueryGoodsForeign: TIBCQuery;
        IBCDataSourceGoodsForeign: TIBCDataSource;
        bbSarcinaOperatorilor: TdxBarButton;
        cxGridGoods_GOODSTYPE: TcxGridDBColumn;
        tvPacheteWebDBFLG_NO_SALARY: TcxGridDBColumn;
        tsWebCatalog: TcxTabSheet;
        qWebCatalogImages: TIBCQuery;
        dsWebCatalogImages: TIBCDataSource;
        cxDBTreeList: TcxDBTreeList;
        cxDBTreeList_TITLE: TcxDBTreeListColumn;
        cxDBTreeList_TITLE_RUS: TcxDBTreeListColumn;
        cxDBTreeListcx_URL_RO: TcxDBTreeListColumn;
        cxDBTreeList_CATALOGID: TcxDBTreeListColumn;
        cxDBTreeListcx_FLG_HAS_IMAGE: TcxDBTreeListColumn;
        dxBarDockControl4: TdxBarDockControl;
        dxBarManagerBar4: TdxBar;
        bbModify: TdxBarButton;
        IBCDataSourceImage: TIBCDataSource;
        IBCQueryImage: TIBCQuery;
    bbNotAprooved: TdxBarButton;
        procedure cxGridGoods_MISSINFOGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
        procedure cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure bbGoodsDescriptionsClick(Sender: TObject);
        procedure cxGridGoodsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
        procedure cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure bbGotoGoodsClick(Sender: TObject);
        procedure cxTreeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
        procedure cxTreeFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
        procedure cxTreeExpanding(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
        procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure bbGoodsQuickInfoClick(Sender: TObject);
        procedure bbCheckDescClick(Sender: TObject);
        procedure dxBarButton1Click(Sender: TObject);
        procedure bbDescriptionClick(Sender: TObject);
        procedure bbReadyClick(Sender: TObject);
        procedure bbApprovedClick(Sender: TObject);
        procedure bbRefreshGoodsInfoClick(Sender: TObject);
        procedure bbDeletePackageClick(Sender: TObject);
        procedure tvGoodsDescDBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure bbBadDescriptionClick(Sender: TObject);
        procedure tvGoodsDescDBCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure bbNewGoodsClick(Sender: TObject);
        procedure bbDeleteGoodsClick(Sender: TObject);
        procedure dxBarButton4Click(Sender: TObject);
        procedure tvGoodsDescDBDblClick(Sender: TObject);
        procedure bbCorrectDescriptionClick(Sender: TObject);
        procedure bbModifyPackageClick(Sender: TObject);
        procedure bbClosePackageClick(Sender: TObject);
        procedure tvPacheteWebDBCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure bbSarcinaOperatorilorClick(Sender: TObject);
        procedure tsWebCatalogHide(Sender: TObject);
        procedure tsWebCatalogShow(Sender: TObject);
        procedure bbModifyClick(Sender: TObject);
    procedure bbNotAproovedClick(Sender: TObject);
    private
    { Private declarations }
        fFirstLoad: Boolean;
        procedure CreateTree;
        procedure DisplayMissingGoods(const ParentID: integer);
        procedure ScanGoodsLevel(const ParentID: integer; const ParentNode: TcxTreeListNode);
        procedure SelectionChanged;
        procedure ShowGoodsDescriptionsDialog;
        procedure ShowGoodsEditor(const GoodsID: Integer);
        procedure ShowQuickInfoDialog(const GoodsID: integer);
        procedure ReloadData;
        function SendSelectedGoodsToPackage(const OperatorID: Integer; const GoodsList: string): Boolean;
        function GetSelectionIDList: string;
        procedure RefreshSalaryData;
    protected
    { Protected declarations }
        function InitFrameID: integer; override;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        procedure DoModifyPackage;
        procedure RefreshData; override;
        procedure SetupSecurityItems; override;
    public
        procedure LoadData;
    { Public declarations }
    end;

implementation

uses
    DataModuleAdditions, DataModuleDB, frmGoods, ClipBrd,
    frmGoodsQuickInfoDialog, frmGoodsSendGoodsToNPSCDialog, SWNUtils,
    Vcl.Dialogs, frmSendGoodsToPackage, SWNSecurity, frmContentCommentUnit,
    frmContentPackage, frmSarcinaOperatorilorUnit, frmWebCatalogLevel3Dialog,
    frmWebCatalogImageDialog;

{$R *.dfm}

{ Tframe15TovarBezHaracteristic }

procedure Tframe15TovarBezHaracteristic.bbApprovedClick(Sender: TObject);
var
    query: TIBCQuery;
begin
    if IBCQueryPackages.RecordCount > 0 then
    begin
        query := TIBCQuery.Create(self);
        try
            query.Transaction := dmDB.IBCTrDefaultUpdate;
            query.SQL.Text := 'execute procedure close_content_package(:ID)';
            query.ParamByName('ID').AsInteger := IBCQueryPackages.FieldByName('ID').AsInteger;
            query.Execute;

            IBCQueryPackages.Refresh;
        finally
            query.Free;
        end;
    end;
end;

procedure Tframe15TovarBezHaracteristic.bbBadDescriptionClick(Sender: TObject);
begin
    with IBCQueryPackageGoods do
    begin
        if not UpdateTransaction.Active then
            UpdateTransaction.StartTransaction;

        Edit;
        FieldByName('flg_bad_description').AsInteger := 1;
        FieldByName('retry_count').AsInteger := FieldByName('Retry_Count').AsInteger + 1;
        Post;

        if UpdateTransaction.Active then
            UpdateTransaction.Commit;
    end;

end;

procedure Tframe15TovarBezHaracteristic.bbCheckDescClick(Sender: TObject);
begin
    ReloadData;
end;

procedure Tframe15TovarBezHaracteristic.bbCorrectDescriptionClick(Sender: TObject);
begin
    with IBCQueryPackageGoods do
    begin
        if not UpdateTransaction.Active then
            UpdateTransaction.StartTransaction;

        Edit;
        FieldByName('flg_bad_description').AsInteger := 0;
//    FieldByName('retry_count').AsInteger := FieldByName('Retry_Count').AsInteger + 1;
        Post;

        if UpdateTransaction.Active then
            UpdateTransaction.Commit;
    end;
end;

procedure Tframe15TovarBezHaracteristic.bbDeleteGoodsClick(Sender: TObject);
begin
    if MessageDlg('Stergeti inregistrare?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        IBCQueryPackageGoods.Delete;
end;

procedure Tframe15TovarBezHaracteristic.bbDeletePackageClick(Sender: TObject);
begin
    inherited;
    if MessageDlg('Stergeti packetul Nr ' + IBCQueryPackages.FieldByName('ID').AsString, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
        IBCQueryPackages.Delete;
    end;
end;

procedure Tframe15TovarBezHaracteristic.bbGoodsDescriptionsClick(Sender: TObject);
begin
    ShowGoodsDescriptionsDialog;
end;

procedure Tframe15TovarBezHaracteristic.bbGoodsQuickInfoClick(Sender: TObject);
begin
    ShowQuickInfoDialog(cxGridGoodsTable.DataController.Values[cxGridGoodsTable.DataController.FocusedRecordIndex, cxGridGoods_GOODSID.Index]);
end;

procedure Tframe15TovarBezHaracteristic.bbGotoGoodsClick(Sender: TObject);
begin
    ShowGoodsEditor(IBCQueryMissGoods.FieldByName('GoodsID').AsInteger);
end;

procedure Tframe15TovarBezHaracteristic.bbNewGoodsClick(Sender: TObject);
var
    dialog: TfrmGoodsBrowser;
begin
    dialog := TfrmGoodsBrowser.Create(Self);
    try
        if dialog.SelectGoods(-1, false) then
        begin
            with IBCQueryPackageGoods do
            begin
                Append;
                FieldByName('GOODSID').AsInteger := dialog.GoodsID;
                Post;
            end;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe15TovarBezHaracteristic.bbNotAproovedClick(Sender: TObject);
begin
    if SWNSecurityManager.IsAdmin then
    begin
        IBCQueryPackages.Edit;
        IBCQueryPackages.FieldByName('FLG_CLOSED').AsInteger := 0;
        IBCQueryPackages.Post;
    end;

end;

procedure Tframe15TovarBezHaracteristic.bbReadyClick(Sender: TObject);
begin

    if MessageDlg('Ati finisat toate produsele din pachetul Nr.' + IBCQueryPackages.FieldByName('ID').AsString + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
        if IBCQueryPackages.RecordCount > 0 then
        begin
            IBCQueryPackages.Edit;
            IBCQueryPackages.FieldByName('flg_ready_for_verification').AsInteger := 1;
            IBCQueryPackages.Post;
            bbRefreshGoodsInfoClick(Sender);
        end;
    end;
end;

procedure Tframe15TovarBezHaracteristic.CreateTree;
var
    Node: TcxTreeListNode;
begin
    cxTree.BeginUpdate;
    try
        cxTree.Clear;
        cxTree.SetFocusedNode(nil, []);
        cxTree.Select(nil, []);

        // Root node
        Node := cxTree.Add;
        Node.Texts[0] := 'Toate produsele fara caracteristici';
        Node.Values[1] := -1;
        Node.Values[2] := True;
        Node.Values[3] := True;
        Node.ImageIndex := 12;
        Node.SelectedIndex := 12;

        ScanGoodsLevel(0, nil);

        cxTree.SetFocusedNode(nil, []);
        cxTree.Select(nil, []);

    finally
        cxTree.EndUpdate;
    end;
end;

procedure Tframe15TovarBezHaracteristic.cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    if bbGoodsDescriptions.Enabled then
        bbGoodsDescriptionsClick(bbGoodsDescriptions);
end;

procedure Tframe15TovarBezHaracteristic.cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    SelectionChanged;
end;

procedure Tframe15TovarBezHaracteristic.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if (Key = VK_DOWN) and (ssCtrl in Shift) then
    begin
        ShowMessage('Add to work table');
    end;

    if Key = VK_F2 then
    begin
        bbGoodsDescriptionsClick(bbGoodsDescriptions);
    end;
    swnutils.ProcessCommonKeys(self, cxGridGoodsTable, Key, Shift);
end;

procedure Tframe15TovarBezHaracteristic.cxGridGoodsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
    if ARecord.Values[cxGridGoods_MISSINFO.Index] = 0 then
        AStyle := dmAdditions.cxStyle_SerialDisabled;
end;

procedure Tframe15TovarBezHaracteristic.cxGridGoods_MISSINFOGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
var
    B: byte;
begin
    B := ARecord.Values[cxGridGoods_MISSINFO.Index];
    if B = 0 then
        AText := 'Ok'
    else
    begin
        AText := '';
        if ((B and 1) = 1) and bbCheckDesc.Down then
            AText := AText + 'Caracteristici ';
        if ((B and 2) = 2) and bbCheckImage.Down then
            AText := AText + 'Imagini ';
        if ((B and 4) = 4) and bbCheckPrice.Down then
            AText := AText + 'Preturi ';
    end;
end;

procedure Tframe15TovarBezHaracteristic.cxTreeExpanding(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
begin
    if ANode.Values[3] = False then
    begin
        cxTree.BeginUpdate;
        try
            ANode.getFirstChild.Delete;
            ANode.Values[3] := True; // mark as scanned
            ScanGoodsLevel(ANode.Values[1], ANode)
        finally
            cxTree.EndUpdate;
        end;
    end;
end;

procedure Tframe15TovarBezHaracteristic.cxTreeFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
    if Assigned(AFocusedNode) then
        DisplayMissingGoods(AFocusedNode.Values[1])
    else
        IBCQueryMissGoods.Close;
end;

procedure Tframe15TovarBezHaracteristic.cxTreeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
begin
    if ANode.Values[2] = True then
        AStyle := dmAdditions.cxStyle_Bold;
end;

procedure Tframe15TovarBezHaracteristic.DisplayMissingGoods(const ParentID: integer);
begin
    IBCQueryMissGoods.Close;
    IBCQueryMissGoods.ParamByName('PARENTID').AsInteger := ParentID;
    IBCQueryMissGoods.Open;
    SelectionChanged;
end;

procedure Tframe15TovarBezHaracteristic.DoFrameHide;
begin
    IBCQueryMissGoods.Close;
    IBCQueryPackages.Open;
    inherited;
end;

procedure Tframe15TovarBezHaracteristic.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    if fFirstLoad then
    begin
        CreateTree;
        SelectionChanged;
        fFirstLoad := False;

//    RefreshSalaryData;
        IBCQueryGoodsForeign.Open;

    end;
    if not IBCQueryPackages.Active then
    begin
        if not SWNSecurityManager.IsAdmin then
            IBCQueryPackages.Macros.MacroByName('CurrentUser').Value := 'responsable_userid=' + dmdb.CurrentUserID.ToString
        else
            IBCQueryPackages.Macros.MacroByName('CurrentUser').Value := '';

        IBCQueryPackages.Active := True
    end
    else
        IBCQueryPackages.Refresh;
end;

procedure Tframe15TovarBezHaracteristic.dxBarButton1Click(Sender: TObject);
var
    dialog: TfrmSendGoodsToPackageDlg;
begin
    if cxGridGoodsTable.Controller.SelectedRecordCount <= 150 then
    begin
        dialog := TfrmSendGoodsToPackageDlg.Create(Self);
        try
            dialog.SetGoodsQty(cxGridGoodsTable.Controller.SelectedRecordCount);
            if dialog.ShowModal = mrOk then
            begin
                if SendSelectedGoodsToPackage(dialog.GetOperatorID, GetSelectionIDList) then
                    ShowInfoDialog('Transmite la operatori content', 'Done!');
            end;
        finally
            dialog.Free;
        end;
    end;
end;

procedure Tframe15TovarBezHaracteristic.bbClosePackageClick(Sender: TObject);
begin
    IBCQueryPackageGoods.Edit;
    IBCQueryPackageGoods.FieldByName('FLG_READY').AsInteger := 1;
    IBCQueryPackageGoods.Post;
end;

procedure Tframe15TovarBezHaracteristic.bbDescriptionClick(Sender: TObject);
var
    dialog: TfrmContentGoodsEditorDlg;
begin
    if ((IBCQueryPackages.FieldByName('FLG_CLOSED').AsInteger = 0) or (not SWNSecurityManager.IsLimitedUser)) then
    begin
        if (IBCQueryPackageGoods.RecNo > 0) then
        begin
            dialog := TfrmContentGoodsEditorDlg.Create(Self, IBCQueryPackageGoods, IBCDataSourcePackageGoods);
            try
                if dialog.ShowModal = mrOk then
                begin
                    dmDB.ExecuteQuery('EXECUTE PROCEDURE CHECK_CONTENT_PACKAGE_GOODS(:PACKAGEID, :GoodsID)', [IBCQueryPackageGoods.FieldByName('PACKAGEID').AsInteger, IBCQueryPackageGoods.FieldByName('GOODSID').AsInteger]);

                    IBCQueryPackageGoods.RefreshRecord;
                end;
            finally
                dialog.Free;
            end;
        end;
    end;
end;

procedure Tframe15TovarBezHaracteristic.bbModifyClick(Sender: TObject);
var
    dialog: TfrmWebCatalogImageDlg;
begin
//
//  if qWebCatalogImages.FieldByName('CATALOG_LEVEL').AsInteger = 3 then
//  begin
//
    dialog := TfrmWebCatalogImageDlg.Create(Self, qWebCatalogImages, dsWebCatalogImages);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
//  try
//    dialog.CreateNewFolder := True;
//    dialog.DT := dmdb.CurrentFirma;
//    dialog.DataSourceImage := IBCDataSourceImage;
////    if (cxDBTreeList.FocusedNode.Level = 1) then
////      parentID := cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex]
////    else
////    if (cxDBTreeList.FocusedNode.Level = 2) then
////      parentID := cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex]
////    else if (cxDBTreeList.FocusedNode.Level = 3) then
////      parentID := cxDBTreeList.FocusedNode.Values[cxDBTreeList_CATALOGID.Position.ColIndex]
////    else
////      parentID := -1;
//
//    dialog.parentID := qWebCatalogImages.FieldByName('PARENTID').AsInteger;
//    dialog.ShowModal;
//  finally
//    dialog.Free;
//  end;
////  SelectionChanged;
//  end;
end;

procedure Tframe15TovarBezHaracteristic.bbModifyPackageClick(Sender: TObject);
begin
    inherited;
    if {(IBCQueryPackages.fieldbyname('flg_closed').Asinteger = 0) or } (SWNSecurityManager.IsAdmin) then
        DoModifyPackage;
end;

procedure Tframe15TovarBezHaracteristic.dxBarButton4Click(Sender: TObject);
var
    dialog: TfrmContentCommentDlg;
begin
    dialog := TfrmContentCommentDlg.Create(Self, dmDB.IBCConnection);
    try
        dialog.PackageID := IBCQueryPackageGoods.FieldByName('PACKAGEID').AsInteger;
        dialog.GoodsID := IBCQueryPackageGoods.FieldByName('GOODSID').AsInteger;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe15TovarBezHaracteristic.bbRefreshGoodsInfoClick(Sender: TObject);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.AutoCommit := False;
        Query.SQL.Text := 'EXECUTE PROCEDURE CHECK_CONTENT_PACKAGE(:PACKAGEID)';
        Query.ParamByName('PACKAGEID').AsInteger := IBCQueryPackages.FieldByName('ID').AsInteger;
        Query.Transaction.StartTransaction;
        try
            Query.Execute;
            Query.Transaction.Commit;
            if IBCQueryPackageGoods.Active then
                IBCQueryPackageGoods.Refresh;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure Tframe15TovarBezHaracteristic.bbSarcinaOperatorilorClick(Sender: TObject);
var
    d: TfrmSarcinaOperatorilorDlg;
begin
    d := TfrmSarcinaOperatorilorDlg.Create(self, dmdb.IBCConnection);
    try
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure Tframe15TovarBezHaracteristic.DoModifyPackage;
var
    dialog: TfrmContentPackageDlg;
begin
//  if (IBCQueryPackages.FieldByName('FLG_CLOSED').AsInteger = 0) then
//  begin
    dialog := TfrmContentPackageDlg.Create(Self, IBCQueryPackages, IBCDataSourcePackages);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
//  end;
end;

function Tframe15TovarBezHaracteristic.GetSelectionIDList: string;
var
    i: integer;
begin
    Result := '';
    for i := 0 to cxGridGoodsTable.Controller.SelectedRecordCount - 1 do
    begin
        if Result <> '' then
            Result := Result + ',';
        Result := Result + IntToStr(cxGridGoodsTable.Controller.SelectedRecords[i].Values[cxGridGoods_GOODSID.Index]);
    end;
end;

function Tframe15TovarBezHaracteristic.SendSelectedGoodsToPackage(const OperatorID: Integer; const GoodsList: string): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.AutoCommit := False;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_SEND_GOODS_TO_PACKAGE(:opID, :gList)';
        Query.ParamByName('opID').AsInteger := OperatorID;
        Query.ParamByName('gList').AsString := GoodsList;
        Query.Transaction.StartTransaction;
        try
            if not dmdb.IBCTrDefaultUpdate.Active then
                dmdb.IBCTrDefaultUpdate.StartTransaction;

            Query.Execute;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure Tframe15TovarBezHaracteristic.SetupSecurityItems;
begin
//    bbOpenPackage.Visible := ivNever;
    bbClosePackage.Visible := ivNever;

    if SWNSecurityManager.IsLimitedUser then
    begin
        tbGoodsNoProperties.TabVisible := False;
        tbGoodsNoProperties.Visible := False;
        cxPageControl2.ActivePage := tbPackages;

        IBCQueryPackages.Close;
        IBCQueryPackages.FilterSQL := 'responsable_userid = ' + dmDB.CurrentUserID.ToString;
        IBCQueryPackages.Open;

        bbRefreshGoodsInfo.Visible := ivNever;
        bbApproved.Visible := ivNever;
        bbDeletePackage.Visible := ivNever;
        bbNewGoods.Visible := ivNever;
        bbDeleteGoods.Visible := ivNever;
        bbBadDescription.Visible := ivNever;
        tvPacheteWebDB_PRICE.Visible := False;
        bbModifyPackage.Visible := ivNever;
        bbCorrectDescription.Visible := ivNever;
        bbSarcinaOperatorilor.Visible := ivNever;
    end
    else
    begin
        tbGoodsNoProperties.TabVisible := True;
        tbGoodsNoProperties.Visible := True;

        IBCQueryPackages.Close;
        IBCQueryPackages.FilterSQL := '';
        IBCQueryPackages.Open;

        bbRefreshGoodsInfo.Visible := ivAlways;
        bbApproved.Visible := ivAlways;
        bbDeletePackage.Visible := ivAlways;
        tvPacheteWebDB_PRICE.Visible := True;
        bbModifyPackage.Visible := ivAlways;
        bbCorrectDescription.Visible := ivAlways;
    end;

    if SWNSecurityManager.IsAdmin then
    begin
//        bbOpenPackage.Visible := ivAlways;
        bbClosePackage.Visible := ivAlways;
    end;

end;

function Tframe15TovarBezHaracteristic.GetFilterFields: TFrameFilterFields;
begin
    Result := [];
end;

function Tframe15TovarBezHaracteristic.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
end;

function Tframe15TovarBezHaracteristic.InitFrameID: integer;
begin
    Result := 15;  // Товар без характеристик
    fFirstLoad := true;
    LoadData;
end;

procedure Tframe15TovarBezHaracteristic.LoadData;
begin
    IBCQueryPackages.Open;
    IBCQueryPackageGoods.Open;
end;

procedure Tframe15TovarBezHaracteristic.RefreshData;
begin
    inherited;
    if cxPageControl2.ActivePage = tbGoodsNoProperties then
    begin
        IBCQueryMissGoods.Refresh;
    end;

    if cxPageControl2.ActivePage = tbPackages then
    begin
        if IBCQueryPackages.Active then
            IBCQueryPackages.Refresh
        else
            IBCQueryPackages.Open;

        if IBCQueryPackageGoods.Active then
            IBCQueryPackageGoods.Refresh
        else
            IBCQueryPackageGoods.Open;

//    bbRefreshGoodsInfoClick(self);
    end;
end;

procedure Tframe15TovarBezHaracteristic.RefreshSalaryData;
begin
    IBCQuerySalariu.Close;
    IBCQuerySalariu.ParamByName('Userid').AsInteger := dmDB.CurrentUserID;
    IBCQuerySalariu.ParamByName('DATA1').AsDate := Date;
    IBCQuerySalariu.ParamByName('DATA2').AsDate := Date;
    IBCQuerySalariu.Open;
//  if IBCQuerySalariu.FieldByName('GOODS_CNT').AsInteger < 40 then
//    cxDBLabel5.Style.Font.Color := clRed
//  else
//    cxDBLabel5.Style.Font.Color := clWindowText;
end;

procedure Tframe15TovarBezHaracteristic.ReloadData;
var
    S: TStringList;
begin
    IBCQueryMissGoods.Close;
    if (bbCheckDesc.Down or bbCheckImage.Down or bbCheckPrice.Down) then
    begin
        S := TStringList.Create;
        try
            if bbCheckDesc.Down then
                S.Add('BIN_AND(MISSING_PARTS,1)=1');
            if bbCheckImage.Down then
            begin
                if S.Count > 0 then
                    S.Add('OR');
                S.Add('BIN_AND(MISSING_PARTS,2)=2');
            end;
            if bbCheckPrice.Down then
            begin
                if S.Count > 0 then
                    S.Add('OR');
                S.Add('BIN_AND(MISSING_PARTS,4)=4');
            end;
            IBCQueryMissGoods.FilterSQL := Format('(%s)', [S.Text]);
        finally
            S.Free;
        end;
    end
    else
        IBCQueryMissGoods.FilterSQL := '';
    IBCQueryMissGoods.Active := True;
end;

procedure Tframe15TovarBezHaracteristic.ScanGoodsLevel(const ParentID: integer; const ParentNode: TcxTreeListNode);
var
    Node: TcxTreeListNode;
begin
    cxTree.BeginUpdate;
    try
        IBCQueryTree.ParamByName('PARENTID').AsInteger := ParentID;
        IBCQueryTree.ExecSQL;
        while not IBCQueryTree.Eof do
        begin
            if Assigned(ParentNode) then
                Node := cxTree.AddChild(ParentNode)
            else
                Node := cxTree.Add;

            Node.Texts[0] := IBCQueryTree.FieldByName('TITLE').AsString;
            Node.Values[1] := IBCQueryTree.FieldByName('GOODSID').AsInteger;
            Node.Values[2] := False; // not special
            Node.ImageIndex := 13;
            Node.SelectedIndex := 13;

            if IBCQueryTree.FieldByName('CHILD_COUNT').AsInteger > 0 then
            begin
                Node.Values[3] := False; // not scanned
                  // create temp node to force tree display "+"
                cxTree.AddChild(Node);
            end
            else
                Node.Values[3] := True; // scanned, not children

            IBCQueryTree.Next;
        end;
    finally
        IBCQueryTree.Close;
        cxTree.EndUpdate;
    end;
end;

procedure Tframe15TovarBezHaracteristic.SelectionChanged;
var
    f1, f2: Boolean;
begin
    f1 := False;
    f2 := False;
    if cxGridGoodsTable.DataController.RecNo > 0 then
    begin
        f1 := True; // Modify Goods Description + Security
        f2 := True; // Open Goods Catalog + Security
    end;
    bbGoodsDescriptions.Enabled := f1;
    bbGoodsQuickInfo.Enabled := f1;
    bbGotoGoods.Enabled := f2;
end;

procedure Tframe15TovarBezHaracteristic.ShowGoodsDescriptionsDialog;
var
    dialog: TfrmContentGoodsEditorDlg;
begin
    dialog := TfrmContentGoodsEditorDlg.Create(Self, IBCQueryMissGoods, IBCDataSourceMissGoods);
    try
        if dialog.ShowModal = mrOk then
//      IBCQueryMissGoods.RefreshRecord; // can not refresh because record can be missing due all info is present



    finally
        dialog.Free;
    end;
end;

procedure Tframe15TovarBezHaracteristic.ShowGoodsEditor(const GoodsID: Integer);
var
    goodsEditor: TfrmGoodsBrowser;
begin
    goodsEditor := TfrmGoodsBrowser.Create(Self);
    try
        goodsEditor.BrowseGoods(GoodsID);
    finally
        goodsEditor.Free;
    end;
end;

procedure Tframe15TovarBezHaracteristic.ShowQuickInfoDialog(const GoodsID: integer);
var
    dialog: TfrmGoodsQuickInfoDlg;
begin
    dialog := TfrmGoodsQuickInfoDlg.Create(Self);
    try
        dialog.GoodsID := GoodsID;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe15TovarBezHaracteristic.tsWebCatalogHide(Sender: TObject);
begin
    inherited;
    qWebCatalogImages.Close;
end;

procedure Tframe15TovarBezHaracteristic.tsWebCatalogShow(Sender: TObject);
begin
    inherited;
    qWebCatalogImages.Open;
    IBCQueryImage.Active := True;
end;

procedure Tframe15TovarBezHaracteristic.tvGoodsDescDBCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    if AViewInfo.GridRecord.Values[tvGoodsDescDB_BAD_DESCRIPTION.Index] = 1 then
    begin
        ACanvas.Font.Color := clRed;
    end;
    if AViewInfo.GridRecord.Values[tvGoodsDesc_FLG_READY.Index] = 1 then
        ACanvas.Font.Style := [fsStrikeOut];

    if AViewInfo.GridRecord.Values[tvGoodsDesc_FLG_IN_PRICE.Index] = 0 then
        ACanvas.Brush.Color := clRed;
end;

procedure Tframe15TovarBezHaracteristic.tvGoodsDescDBDblClick(Sender: TObject);
begin
    bbDescriptionClick(Sender);
end;

procedure Tframe15TovarBezHaracteristic.tvGoodsDescDBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    swnUtils.ProcessCommonKeys(self, tvGoodsDescDB, Key, Shift);
end;

procedure Tframe15TovarBezHaracteristic.tvPacheteWebDBCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    if AViewInfo.GridRecord.Values[tvPacheteWebDB_FLG_CLOSED.Index] = 1 then
        ACanvas.Font.Style := [fsStrikeOut];
end;

end.

