unit frame60PredvaritelnieZakaziUnit;
{
  СЧЕТА. Предварительные заказы
  DocTypeID = 104
  Frame Index = 60
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  SWNDataFiltering, SWNBaseFrameUnit,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Vcl.ExtCtrls, cxSplitter, cxLabel, dxBar, MemDS, DBAccess, IBC, cxImageComboBox, cxCurrencyEdit,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu,
  dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  Tframe60PredvaritelnieZakazi = class(TSWNBaseFrame)
    cxGridPZDocs: TcxGrid;
    cxGridPZDocsTable: TcxGridDBTableView;
    cxGridPZDocs_DOCID: TcxGridDBColumn;
    cxGridPZDocs_DATA: TcxGridDBColumn;
    cxGridPZDocs_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridPZDocs_FLG_CLOSED: TcxGridDBColumn;
    cxGridPZDocsLevel: TcxGridLevel;
    cxSplitter: TcxSplitter;
    pnBottom: TPanel;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbGoodsAdd: TdxBarButton;
    bbGoodsEdit: TdxBarButton;
    bbGoodsRemove: TdxBarButton;
    bbGoodsApprove: TdxBarButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGridGoods_GOODSID: TcxGridDBColumn;
    cxGridGoods_IMG: TcxGridDBColumn;
    cxGridGoods_GOODS_TITLE: TcxGridDBColumn;
    cxGridGoods_QTY: TcxGridDBColumn;
    cxGridGoods_FLG_APPROVED: TcxGridDBColumn;
    cxGridGoods_SUPPLIER_QTY: TcxGridDBColumn;
    cxGridGoods_SELL_PRICE: TcxGridDBColumn;
    cxGridGoods_SELL_CURRENCY_TITLE: TcxGridDBColumn;
    cxGridGoods_SUPPLIER_TITLE: TcxGridDBColumn;
    cxGridGoods_SUPPLIER_PRICE: TcxGridDBColumn;
    cxGridGoods_SUPRLIER_CURRENCY_TITLE: TcxGridDBColumn;
    cxGridGoods_STOCK_QTY: TcxGridDBColumn;
    cxGridGoods_ACNT_QTY: TcxGridDBColumn;
    cxGridGoods_APPROVED_BY_NAME: TcxGridDBColumn;
    cxGridGoods_CREATED_BY_NAME: TcxGridDBColumn;
    dxBarPopupMenuDocs: TdxBarPopupMenu;
    cxGridPopupMenuDocs: TcxGridPopupMenu;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    cxGridGoods_FLG_ACNT: TcxGridDBColumn;
    bbRecalcQTY: TdxBarButton;
    cxGridGoods_FLG_CLOSED: TcxGridDBColumn;
    cxGridGoods_SUPPLIER_ID: TcxGridDBColumn;
    bbSubItemsTools: TdxBarSubItem;
    bbCreateVhodnieSceta: TdxBarButton;
    dxBarPopupMenuGrid: TdxBarPopupMenu;
    cxGridPopupMenuGrid: TcxGridPopupMenu;
    procedure cxGridPZDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridPZDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridPZDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridPZDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbGoodsAddClick(Sender: TObject);
    procedure bbGoodsEditClick(Sender: TObject);
    procedure bbGoodsRemoveClick(Sender: TObject);
    procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridGoods_SUPPLIER_TITLEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbRecalcQTYClick(Sender: TObject);
    procedure cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure bbGoodsApproveClick(Sender: TObject);
    procedure bbCreateVhodnieScetaClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete, fSECURITY_CanDeleteGoods, fSECURITY_CanApproveGoods:Boolean;

    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure GoodsSelectionChanged;

    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DoDeleteGoods;

    procedure DoRecalcStocksQty(const DocID, GoodsID:Integer);
    function DoCreateApprovmentDB(const DocID, GoodsID:Integer):Boolean;

    function DoCreateVhodnieScetaDB:Boolean;
  protected
    { Protected declarations }
    function InitFrameID:integer;override;

    function GetExternalDataSourceTypes:TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;

    function GetFilterFields:TFrameFilterFields;override;
    function GetFrameButtons:TFrameButtons;override;

    procedure CreateNewRecord;override;
    procedure ModifyRecord;override;
    procedure DeleteRecord;override;
    procedure RefreshData;override;

    procedure ReadFrameStates;override;
    procedure SaveFrameStates;override;

    procedure SetupSecurityItems;override;
  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

{$R *.dfm}

uses System.UITypes, DataModuleAdditions, SWNSecurity, SWNSecurityFlags, SWNValueStorageUnit, frmPredvaritelnieZakaziDocDialog,
     SWNUtils, SWNConst, SWNDBErrors, DataModuleDB, frmPredvaritelnieZakaziGoodsDialog;

{ Tframe60PredvaritelnieZakazi }

procedure Tframe60PredvaritelnieZakazi.bbCreateVhodnieScetaClick(Sender: TObject);
begin
     if ShowAskDialog('Creaza "Proforma intrare marfa"',
                      'Doriti sa creati "Proforma intrare marfa" pe toate produsele care au fost confirmate?',
                      'Documentelele cu produsele confirmate vor fi inchise')=mrYes then
     begin
          if DoCreateVhodnieScetaDB then RefreshData;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.bbGoodsAddClick(Sender: TObject);
begin
     ShowAddGoodsDialog;
end;

procedure Tframe60PredvaritelnieZakazi.bbGoodsApproveClick(Sender: TObject);
begin
     if ShowAskDialog('Confirmare precomanda produse',
                      Format('Confirmati precomanda produsului '#13#10'"%s" ?'#13#10#13#10'Cant= %d ',
                             [IBCQueryGoods.FieldByName('GOODS_TITLE').asString,IBCQueryGoods.FieldByName('SUPPLIER_QTY').asInteger]))=mrYes then
     begin
          if DoCreateApprovmentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger,IBCQueryGoods.FieldByName('GOODSID').asInteger) then
          begin
               IBCQueryGoods.Refresh;
               ShowInfoDialog('Confirmare precomanda produse','Finisat cu succes!');
          end;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.bbGoodsEditClick(Sender: TObject);
begin
     ShowModifyGoodsDialog;
end;

procedure Tframe60PredvaritelnieZakazi.bbGoodsRemoveClick(Sender: TObject);
begin
     DoDeleteGoods;
end;

procedure Tframe60PredvaritelnieZakazi.bbRecalcQTYClick(Sender: TObject);
begin
     if ShowAskDialog('Atualizare sold',
                      Format('Actualizarea soldului pentru produsul:'#13#10'"%s" ?',[IBCQueryGoods.FieldByName('GOODS_TITLE').AsString]))=mrYes then
     begin
          DoRecalcStocksQty(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger,IBCQueryGoods.FieldByName('GOODSID').AsInteger);
          IBCQueryGoods.Refresh;
          ShowInfoDialog('Actualizare sold','Finisat cu succes!');
     end;
end;

procedure Tframe60PredvaritelnieZakazi.CreateNewRecord;
var dialog:TfrmPredvaritelnieZakaziDocDlg;
begin
     dialog:=TfrmPredvaritelnieZakaziDocDlg.Create(Self,dmDB.IBCQueryDocs,dmDb.IBCDataSourceDocs);
     try
        dialog.CreateNewDocument:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if (AButton=mbLeft) and bbGoodsEdit.Enabled then
     begin
          ShowModifyGoodsDialog;
          AHandled:=True;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // CLOSED
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridGoods_FLG_CLOSED.Index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridGoods_FLG_CLOSED.Index] = 1 then
          begin
               ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
               if Not AViewInfo.Selected then ACanvas.Font.Color := clGrayText;
          end;
     end;
     // ACNT
     if Not AViewInfo.Selected and (VarIsNumeric(AViewInfo.GridRecord.Values[cxGridGoods_FLG_ACNT.Index])) and (AViewInfo.GridRecord.Values[cxGridGoods_FLG_ACNT.Index] = 1)
       then ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;

     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe60PredvaritelnieZakazi.cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsSelectionChanged;
end;

procedure Tframe60PredvaritelnieZakazi.cxGridGoods_SUPPLIER_TITLEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if VarIsNull(ARecord.Values[cxGridGoods_SUPPLIER_ID.Index]) or (ARecord.Values[cxGridGoods_SUPPLIER_ID.Index]<=0) then AText:='';
end;

procedure Tframe60PredvaritelnieZakazi.cxGridPZDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if AButton=mbLeft then
     begin
          DoDocumentDoubleClick;
          AHandled:=True;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.cxGridPZDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridPZDocs_FLG_CLOSED.Index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridPZDocs_FLG_CLOSED.Index] = 1 then
          begin
               ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
               if Not AViewInfo.Selected then ACanvas.Font.Color := clGrayText;
          end;
     end;

     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe60PredvaritelnieZakazi.cxGridPZDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     SWNUtils.ProcessCommonKeys(Self, cxGridPZDocsTable,Key,Shift);
end;

procedure Tframe60PredvaritelnieZakazi.cxGridPZDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridPZDocs_DATA.Index]) then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridPZDocs_DATA.Index]);
end;

procedure Tframe60PredvaritelnieZakazi.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format(cMSG_DELETERECORD_60,[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))=mrYes then
     begin
          dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
          try
             dmDB.IBCQueryDocs.Delete;
             dmDB.IBCQueryDocs.UpdateTransaction.Commit;
          except on E:Exception do
             begin
                  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

function Tframe60PredvaritelnieZakazi.DoCreateApprovmentDB(const DocID, GoodsID: Integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_60_APPROVE(:ID,:GID)';
        Query.ParamByName('ID').AsInteger:=DocID;
        Query.ParamByName('GID').AsInteger:=GoodsID;
        Query.Transaction.StartTransaction;
        try
           Query.Execute;
           Query.Transaction.Commit;
           Result:=True;
        except on E: Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

function Tframe60PredvaritelnieZakazi.DoCreateVhodnieScetaDB: Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_60_CREATE_VSC(:ID)';
        Query.ParamByName('ID').AsInteger:=dmDB.CurrentFirma;
        Query.Transaction.StartTransaction;
        try
           Query.Execute;
           Query.Transaction.Commit;
           Result:=True;
        except on E: Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.DocumentSelectionChanged;
var fAdd,fEdit,fDelete:Boolean;
    fCloseDoc, fOpenDoc, fCreateDoc:Boolean;
    FLG_CLOSED:Boolean;
begin
     fAdd:=fSECURITY_CanNew;
     fEdit:=False;
     fDelete:=False;

     fCloseDoc:=False;
     fOpenDoc:=False;
     fCreateDoc:=True;

     if (cxGridPZDocsTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
          fEdit:=fSECURITY_CanEdit and Not FLG_CLOSED or fSECURITY_CanView;
          fDelete:=fSECURITY_CanDelete and Not FLG_CLOSED;
          fCloseDoc:=Not FLG_CLOSED;
          fOpenDoc:=FLG_CLOSED;
     end;
     // doc
     ButtonStateChanged(fbtADD,fAdd);
     ButtonStateChanged(fbtMODIFY,fEdit);
     ButtonStateChanged(fbtDELETE,fDelete);

     // popup
     bbCloseDoc.Enabled:=fCloseDoc;
     bbOpenDoc.Enabled:=fOpenDoc;
     bbCreateVhodnieSceta.Enabled:=fCreateDoc;

     // goods
     GoodsSelectionChanged;
end;

procedure Tframe60PredvaritelnieZakazi.DoDeleteGoods;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteGoods,Format('Sterge'#13#10'%s'#13#10'din precomanda?',[IBCQueryGoods.FieldByName('GOODS_TITLE').asString]))=mrYes then
     begin
          IBCQueryGoods.UpdateTransaction.StartTransaction;
          try
             IBCQueryGoods.Delete;
             IBCQueryGoods.UpdateTransaction.Commit;
          except on E:Exception do
             begin
                  IBCQueryGoods.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.DoFrameHide;
begin
     // inchidem datele interne
     IBCQueryGoods.Close;

     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridPZDocsTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridPZDocsTable.DataController.DataSource:=nil;
end;

procedure Tframe60PredvaritelnieZakazi.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridPZDocsTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
     cxGridPZDocsTable.OnFocusedRecordChanged:=WhenDocGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
     IBCQueryGoods.Active:=True;

     // 4. Selection update
     DocumentSelectionChanged;
end;

procedure Tframe60PredvaritelnieZakazi.DoRecalcStocksQty(const DocID, GoodsID:Integer);
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_60_RECALCQTY(:ID,:GID)';
        Query.ParamByName('ID').AsInteger:=DocID;
        Query.ParamByName('GID').AsInteger:=GoodsID;
        Query.Transaction.StartTransaction;
        try
           Query.Execute;
           Query.Transaction.Commit;
        except on E: Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

function Tframe60PredvaritelnieZakazi.GetCurrentSearchContext: TSearchContextValue;
begin
     if cxGridPZDocsTable.Site.Focused then
     begin
          // context from Docs
          if cxGridPZDocs_DATA.Focused then
          begin
               // Дата
               Result.Context := ffDate;
               Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
          end;
     end;
end;

function Tframe60PredvaritelnieZakazi.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe60PredvaritelnieZakazi.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate];
end;

function Tframe60PredvaritelnieZakazi.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_CanNew then Result:=Result+[fbtADD];
     if fSECURITY_CanDelete then Result:=Result+[fbtDELETE];
     if fSECURITY_CanView or fSECURITY_CanEdit then Result:=Result+[fbtMODIFY];
end;

procedure Tframe60PredvaritelnieZakazi.GoodsSelectionChanged;
var fAdd,fEdit,fRemove,fApprove,fRecalcQty:Boolean;
    DOC_FLG_CLOSED, GOODS_FLG_CLOSED, GOODS_FLG_APPROVED:Boolean;
begin
     fAdd:=False;
     fEdit:=False;
     fRemove:=False;
     fApprove:=False;
     fRecalcQty:=False;

     if cxGridPZDocsTable.DataController.RecNo>0 then
     begin
          DOC_FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fAdd:=fSECURITY_CanEdit and Not DOC_FLG_CLOSED;

          if cxGridGoodsTable.DataController.RecNo>0 then
          begin
               GOODS_FLG_CLOSED:=IBCQueryGoods.FieldByName('FLG_CLOSED').AsInteger=1;
               GOODS_FLG_APPROVED:=IBCQueryGoods.FieldByName('FLG_APPROVED').AsInteger=1;

               fEdit:=fSECURITY_CanEdit and Not GOODS_FLG_APPROVED and Not DOC_FLG_CLOSED and Not GOODS_FLG_CLOSED or fSECURITY_CanNew;
               fRemove:=fSECURITY_CanDeleteGoods and Not DOC_FLG_CLOSED and Not (GOODS_FLG_CLOSED or GOODS_FLG_APPROVED);
               fApprove:=fSECURITY_CanApproveGoods and Not GOODS_FLG_APPROVED and Not GOODS_FLG_CLOSED and Not DOC_FLG_CLOSED;
               fRecalcQty:=fSECURITY_CanApproveGoods and Not GOODS_FLG_APPROVED and Not GOODS_FLG_CLOSED and Not DOC_FLG_CLOSED;
          end;
     end;
     bbGoodsAdd.Enabled:=fAdd;
     bbGoodsEdit.Enabled:=fEdit;
     bbGoodsRemove.Enabled:=fRemove;
     bbGoodsApprove.Enabled:=fApprove;
     bbRecalcQTY.Enabled:=fRecalcQty;
end;

function Tframe60PredvaritelnieZakazi.InitFrameID: integer;
begin
     // Предварительные заказы
     Result:=60;
end;

procedure Tframe60PredvaritelnieZakazi.ModifyRecord;
var dialog:TfrmPredvaritelnieZakaziDocDlg;
    ReadOnly:Boolean;
begin
     if Not(fSECURITY_CanEdit or fSECURITY_CanView) then Exit;

     if fSECURITY_CanEdit
       then ReadOnly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
       else ReadOnly := fSECURITY_CanView;

     dialog:=TfrmPredvaritelnieZakaziDocDlg.Create(Self,dmDB.IBCQueryDocs,dmDb.IBCDataSourceDocs);
     try
        dialog.CreateNewDocument:=False;
        dialog.ReadOnly:=ReadOnly;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        pnBottom.Height:=AppUserConfigStorage.IntValues.GetValue('BottomHeight',300);
//        cxSplitter.State:=TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridPZDocsTable);
        ReadGridColumnsSettings(cxGridGoodsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;

     // aratam colonitele pentru aprobare
     cxGridGoods_SUPPLIER_TITLE.Visible:=fSECURITY_CanApproveGoods;
     cxGridGoods_SUPPLIER_TITLE.VisibleForCustomization:=fSECURITY_CanApproveGoods;
     cxGridGoods_SUPPLIER_PRICE.Visible:=fSECURITY_CanApproveGoods;
     cxGridGoods_SUPPLIER_PRICE.VisibleForCustomization:=fSECURITY_CanApproveGoods;
     cxGridGoods_SUPRLIER_CURRENCY_TITLE.Visible:=fSECURITY_CanApproveGoods;
     cxGridGoods_SUPRLIER_CURRENCY_TITLE.VisibleForCustomization:=fSECURITY_CanApproveGoods;
     cxGridGoods_STOCK_QTY.Visible:=fSECURITY_CanApproveGoods;
     cxGridGoods_STOCK_QTY.VisibleForCustomization:=fSECURITY_CanApproveGoods;
     cxGridGoods_ACNT_QTY.Visible:=fSECURITY_CanApproveGoods;
     cxGridGoods_ACNT_QTY.VisibleForCustomization:=fSECURITY_CanApproveGoods;
     cxGridGoods_APPROVED_BY_NAME.Visible:=fSECURITY_CanApproveGoods;
     cxGridGoods_APPROVED_BY_NAME.VisibleForCustomization:=fSECURITY_CanApproveGoods;
end;

procedure Tframe60PredvaritelnieZakazi.RefreshData;
begin
     inherited;
     IBCQueryGoods.Refresh;
end;

procedure Tframe60PredvaritelnieZakazi.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight',pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState',Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridPZDocsTable);
        SaveGridColumnsSettings(cxGridGoodsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.SetupDefaultFocus;
begin
     // focused grid
     cxGridPZDocs.SetFocus;
     // column
     cxGridPZDocs_CREATED_BY_NAME.Focused:=True;
     cxGridGoods_GOODS_TITLE.Focused:=True;
end;

procedure Tframe60PredvaritelnieZakazi.SetupSecurityItems;
begin
     // Предварительные заказы
     fSECURITY_CanView:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ПЗ_Просмотр);
     fSECURITY_CanNew:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ПЗ_Создать);
     fSECURITY_CanEdit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ПЗ_Изменить);
     fSECURITY_CanDelete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ПЗ_Удалить);
     fSECURITY_CanDeleteGoods:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ПЗ_Удалить_товар);
     fSECURITY_CanApproveGoods:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ПЗ_Утвердить);

     if Not fSECURITY_CanEdit then bbGoodsAdd.Visible:=ivNever; // hide goods new button
     if Not (fSECURITY_CanEdit or fSECURITY_CanView) then bbGoodsEdit.Visible:=ivNever;// hide goods edit button
     if Not fSECURITY_CanDeleteGoods then bbGoodsRemove.Visible:=ivNever; // hide goods delete button
     if Not fSECURITY_CanApproveGoods then
     begin
          bbGoodsApprove.Visible:=ivNever;
          bbRecalcQTY.Visible:=ivNever;
     end;

     if bbSubItemsTools.ItemLinks.VisibleItemCount=0 then bbSubItemsTools.Visible:=ivNever;

     if dxBarManager1Bar1.ItemLinks.VisibleItemCount=0 then
     begin
          dxBarManager1Bar1.Visible:=False;
          dxBarDockControl1.Visible:=False;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.ShowAddGoodsDialog;
var dialog:TfrmPredvaritelnieZakaziGoodsDlg;
begin
     dialog:=TfrmPredvaritelnieZakaziGoodsDlg.Create(Self,IBCQueryGoods,IBCDataSourceGoods);
     try
        dialog.CreateNewDocument:=True;
        dialog.GoodsPartOnly:=Not fSECURITY_CanApproveGoods;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.ShowModifyGoodsDialog;
var dialog:TfrmPredvaritelnieZakaziGoodsDlg;
    readOnly:Boolean;
begin
     if fSECURITY_CanEdit
       then readOnly:=(IBCQueryGoods.FieldByName('FLG_CLOSED').AsInteger=1) or (IBCQueryGoods.FieldByName('FLG_APPROVED').AsInteger=1)
       else readOnly:=fSECURITY_CanView;

     dialog:=TfrmPredvaritelnieZakaziGoodsDlg.Create(Self,IBCQueryGoods,IBCDataSourceGoods);
     try
        dialog.CreateNewDocument:=False;
        dialog.GoodsPartOnly:=Not fSECURITY_CanApproveGoods;
        dialog.ReadOnly:=readOnly;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe60PredvaritelnieZakazi.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     DocumentSelectionChanged;
end;

end.
