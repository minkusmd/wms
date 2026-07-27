unit frame54InventarizatiaUnit;
{
  ИНВЕНТАРИЗАЦИЯ. Инвентаризация
  DocTypeID = 1968
  Frame Index = 54
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxCheckBox, cxCurrencyEdit, cxLabel, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxSplitter, cxGridCustomPopupMenu, cxGridPopupMenu,
  dxBar, DBAccess, IBC, MemDS, cxGridBandedTableView, cxGridDBBandedTableView, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  Tframe54Inventarizatia = class(TSWNBaseFrame)
    cxGridDocs: TcxGrid;
    cxGridDocsTable: TcxGridDBTableView;
    cxGrid_FLG_CLOSED: TcxGridDBColumn;
    cxGrid_DOCID: TcxGridDBColumn;
    cxGrid_DATA: TcxGridDBColumn;
    cxGrid_DTDEP_NAME: TcxGridDBColumn;
    cxGrid_SUMA: TcxGridDBColumn;
    cxGrid_CURRENCY_NAME: TcxGridDBColumn;
    cxGrid_VAT: TcxGridDBColumn;
    cxGrid_RATE: TcxGridDBColumn;
    cxGrid_PARENTDOCID: TcxGridDBColumn;
    cxGrid_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridDocsLevel: TcxGridLevel;
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    cxGrid_FLG_ACNT: TcxGridDBColumn;
//    pmDocs: TdxBarPopupMenu;
    cxGridDocsPopupMenu: TcxGridPopupMenu;
    dxBarManager1: TdxBarManager;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    bbGoodsNew: TdxBarButton;
    bbGoodsEdit: TdxBarButton;
    bbGoodsDelete: TdxBarButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGridGoodsTable: TcxGridDBBandedTableView;
    cxGridGoods_DT_DEP_TITLE: TcxGridDBBandedColumn;
    cxGridGoods_DT_GOODSID: TcxGridDBBandedColumn;
    cxGridGoods_DT_GOODS_TITLE: TcxGridDBBandedColumn;
    cxGridGoods_DT_IDENT: TcxGridDBBandedColumn;
    cxGridGoods_CT_DEP_TITLE: TcxGridDBBandedColumn;
    cxGridGoods_CT_GOODSID: TcxGridDBBandedColumn;
    cxGridGoods_CT_IDENT: TcxGridDBBandedColumn;
    cxGridGoods_CT_GOODS_TITLE: TcxGridDBBandedColumn;
    cxGrid_DT_NAME: TcxGridDBColumn;
    cxGridGoods_CT_DATE: TcxGridDBBandedColumn;
    cxGridGoods_CT_CREATED_BY_NAME: TcxGridDBBandedColumn;
    cxGridGoods_DT_CREATED_BY_NAME: TcxGridDBBandedColumn;
    cxGridGoods_DT_PRICE: TcxGridDBBandedColumn;
    cxGridGoods_CT_PRICE: TcxGridDBBandedColumn;
    pmDocs: TdxBarPopupMenu;
    procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGoodsNewClick(Sender: TObject);
    procedure bbGoodsEditClick(Sender: TObject);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure cxGrid_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridGoods_CT_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fSECURITY_CanView,
    fSECURITY_CanNew,
    fSECURITY_CanEdit,
    fSECURITY_CanDelete,
    fSECURITY_CanGoodsEdit,
    fSECURITY_CanGoodsDelete:Boolean;

    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;

    procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;

    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteGoods;

    procedure DoCloseDocument;
    function CloseDocumentDB(const DocID:integer):Boolean;
    procedure DoOpenDocument;
    function OpenDocumentDB(const DocID:integer):Boolean;

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

    procedure SaveFrameStates;override;
    procedure ReadFrameStates;override;

    procedure SetupSecurityItems;override;
  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext:TSearchContextValue;override;
  end;


implementation

{$R *.dfm}

uses SWNSecurity, SWNSecurityFlags, DataModuleDB, SWNConst, SWNUtils, SWNDBErrors,
  DataModuleAdditions, frm52ZamenaTovaraEditorDialog, frm54InventarizatiaDocDialog, SWNValueStorageUnit;

{ Tframe52ZamenaTovara }

procedure Tframe54Inventarizatia.bbCloseDocClick(Sender: TObject);
begin
     DoCloseDocument;
end;

procedure Tframe54Inventarizatia.bbGoodsDeleteClick(Sender: TObject);
begin
     DeleteGoods;
end;

procedure Tframe54Inventarizatia.bbGoodsEditClick(Sender: TObject);
begin
     ShowModifyGoodsDialog;
end;

procedure Tframe54Inventarizatia.bbGoodsNewClick(Sender: TObject);
begin
     ShowAddGoodsDialog;
end;

procedure Tframe54Inventarizatia.bbOpenDocClick(Sender: TObject);
begin
     DoOpenDocument;
end;

function Tframe54Inventarizatia.CloseDocumentDB(const DocID: integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_CLOSE_INV(:DOCID)';
        Query.ParamByName('DOCID').AsInteger:=DocID;
        try
           Query.Transaction.StartTransaction;
           Query.ExecSQL;
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

procedure Tframe54Inventarizatia.CreateNewRecord;
var dialog:Tfrm54InventarizatiaDocDlg;
begin
     dialog:=Tfrm54InventarizatiaDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe54Inventarizatia.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGrid_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGrid_FLG_CLOSED.index]=0 then
          begin
               if Not AViewInfo.Selected then
               begin
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGrid_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
               end;
          end
          else
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    if AViewInfo.GridRecord.Values[cxGrid_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
                    else ACanvas.Font.Color:=clGrayText;
               end;
          end;
     end;

     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe54Inventarizatia.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(Self, cxGridDocsTable,Key,Shift);
end;

procedure Tframe54Inventarizatia.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe54Inventarizatia.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(Self, TcxGridDBTableView(cxGridGoodsTable),Key,Shift);
end;

procedure Tframe54Inventarizatia.cxGridGoods_CT_DATEGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridGoods_CT_DATE.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridGoods_CT_DATE.Index]);
end;

procedure Tframe54Inventarizatia.cxGrid_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGrid_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGrid_DATA.Index]);
end;

procedure Tframe54Inventarizatia.DeleteGoods;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteGoods,Format('Sterge %s?',[IBCQueryGoods.FieldByName('DT_GOODS_TITLE').asString]))=mrYes then
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

procedure Tframe54Inventarizatia.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format('Sterge inregistrarea nr.%d?',[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))=mrYes then
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

procedure Tframe54Inventarizatia.DoCloseDocument;
begin
     if ShowAskDialog('Inventariere','Doriti sa inchideti documentul?')=mrYes then
     begin
          if CloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger)
            then dmDB.IBCQueryDocs.Refresh;
     end;
end;

procedure Tframe54Inventarizatia.DocumentSelectionChanged;
var fDocNew,fDocEdit,fDocDelete:Boolean;
    fCloseDoc,fOpenDoc:Boolean;
    FLG_CLOSED:Boolean;
begin
     fDocNew:=True;      // New document + Security
     fDocEdit:=False;
     fDocDelete:=False;

     fCloseDoc:=False;
     fOpenDoc:=False;

     if cxGridDocsTable.DataController.RecNo>0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fDocEdit:=fSECURITY_CanEdit and Not FLG_CLOSED or fSECURITY_CanView;   // Edit document
          fDocDelete:=fSECURITY_CanEdit and Not FLG_CLOSED; // Delete document

          fCloseDoc:=Not FLG_CLOSED;
          fOpenDoc:=FLG_CLOSED;
     end;
     // doc
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);
     // popup
     bbCloseDoc.Enabled:=fCloseDoc;
     bbOpenDoc.Enabled:=fOpenDoc;

     GoodsSelectionChanged;
end;

procedure Tframe54Inventarizatia.DoFrameHide;
begin
     // inchidem datele interne
     IBCQueryGoods.Close;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridDocsTable.OnFocusedRecordChanged:=nil;
     cxGridGoodsTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridDocsTable.DataController.DataSource:=nil;
     cxGridGoodsTable.DataController.DataSource:=nil;

     inherited;
end;

procedure Tframe54Inventarizatia.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridDocsTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;
     cxGridGoodsTable.DataController.DataSource:=IBCDataSourceGoods;

     // 2. Selection handlers
     cxGridDocsTable.OnFocusedRecordChanged:=WhenDocGrid_FocusedRecordChanged;
     cxGridGoodsTable.OnFocusedRecordChanged:=WhenGoodsGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
     IBCQueryGoods.Active:=True;

     // 4. Selection update
     DocumentSelectionChanged;
end;

procedure Tframe54Inventarizatia.DoOpenDocument;
begin
     if ShowAskDialog('Inventariere','Deschideti documentul de inventariere?')=mrYes then
     begin
          if OpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger)
            then dmDB.IBCQueryDocs.Refresh;
     end;
end;

function Tframe54Inventarizatia.GetCurrentSearchContext: TSearchContextValue;
begin
     Result:=Inherited;

     if cxGridDocsTable.Site.Focused then
     begin
          // context from Docs
          if cxGrid_DATA.Focused then
          begin
               // cxGrid_DATA
               Result.Context:=ffDate;
               Result.ValueDateTime:=dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
          end
          else
              if cxGrid_DTDEP_NAME.Focused then
              begin
                   // Склад
                   Result.Context := ffStock;
                   Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
                   Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
              end;
     end
end;

function Tframe54Inventarizatia.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe54Inventarizatia.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffGoods,ffStock];
end;

function Tframe54Inventarizatia.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_CanNew then Result:=Result+[fbtADD];
     if fSECURITY_CanEdit or fSECURITY_CanView then Result:=Result+[fbtMODIFY];
     if fSECURITY_CanDelete then Result:=Result+[fbtDELETE];
end;

procedure Tframe54Inventarizatia.GoodsSelectionChanged;
var fNew,fEdit,fDelete:Boolean;
    FLG_CLOSED:Boolean;
begin
     fNew:=False;
     fEdit:=False;
     fDelete:=False;
     if (cxGridDocsTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
          fNew:=Not FLG_CLOSED and fSECURITY_CanEdit;

          if (cxGridGoodsTable.DataController.RecNo>0) then
          begin
               fEdit:=Not FLG_CLOSED and fSECURITY_CanGoodsEdit or fSECURITY_CanView;
               fDelete:=Not FLG_CLOSED and fSECURITY_CanGoodsDelete;
          end;
     end;

     bbGoodsNew.Enabled:=fNew;
     bbGoodsEdit.Enabled:=fEdit;
     bbGoodsDelete.Enabled:=fDelete;
end;

function Tframe54Inventarizatia.InitFrameID: integer;
begin
     // ИНВЕНТАРИЗАЦИЯ. Инвентаризация
     Result:=54;
end;

procedure Tframe54Inventarizatia.ModifyRecord;
var dialog:Tfrm54InventarizatiaDocDlg;
    ReadOnly:Boolean;
begin
     if Not (fSECURITY_CanEdit or fSECURITY_CanView) then Exit;
     if fSECURITY_CanEdit
       then ReadOnly:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1
       else ReadOnly:=fSECURITY_CanView;

     dialog:=Tfrm54InventarizatiaDocDlg.Create(Self);
     try
        dialog.ReadOnly:=ReadOnly;
        dialog.CreateNewDocument:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

function Tframe54Inventarizatia.OpenDocumentDB(const DocID: integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_OPEN_INV(:DOCID)';
        Query.ParamByName('DOCID').AsInteger:=DocID;
        try
           Query.Transaction.StartTransaction;
           Query.ExecSQL;
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

procedure Tframe54Inventarizatia.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//        cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridDocsTable);
        ReadGridColumnsSettings(cxGridGoodsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe54Inventarizatia.RefreshData;
begin
     inherited;
     IBCQueryGoods.Refresh;
end;

procedure Tframe54Inventarizatia.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridDocsTable);
        SaveGridColumnsSettings(cxGridGoodsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe54Inventarizatia.SetupDefaultFocus;
begin
     // grid
     cxGridDocs.SetFocus;
     // columns
     cxGrid_DT_NAME.Focused:=True;
end;

procedure Tframe54Inventarizatia.SetupSecurityItems;
begin
     fSECURITY_CanView:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Просмотр);
     fSECURITY_CanNew:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Создать);
     fSECURITY_CanEdit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Изменить);
     fSECURITY_CanDelete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Удалить);
     fSECURITY_CanGoodsEdit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Редактировать_товар);
     fSECURITY_CanGoodsDelete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Удалить_товар);

     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Закрыть_документ) then bbCloseDoc.Visible:=ivNever;
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_Инвентаризация_Открыть_документ) then bbOpenDoc.Visible:=ivNever;

     if pmDocs.ItemLinks.VisibleItemCount=0 then cxGridDocsPopupMenu.PopupMenus[0].PopupMenu:=nil;

     if Not fSECURITY_CanEdit then bbGoodsNew.Visible:=ivNever;
     if Not fSECURITY_CanGoodsDelete then bbGoodsDelete.Visible:=ivNever;

     if Not (fSECURITY_CanGoodsEdit or fSECURITY_CanView) then bbGoodsEdit.Visible:=ivNever
     else
         if Not fSECURITY_CanGoodsEdit and fSECURITY_CanView then bbGoodsEdit.Caption:='Vizualizare';

     if dxBarManager1Bar1.ItemLinks.VisibleItemCount=0 then
     begin
          dxBarManager1Bar1.Visible:=False;
          dxBarDockControl1.Visible:=False;
     end;
end;

procedure Tframe54Inventarizatia.ShowAddGoodsDialog;
var dialog:Tfrm52ZamenaTovaraEditorDlg;
begin
     dialog:=Tfrm52ZamenaTovaraEditorDlg.Create(Self,IBCQueryGoods,IBCDataSourceGoods);
     try
        dialog.DocID:=dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        dialog.DT_DEP:=dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
        dialog.DocData:=dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
        dialog.DocCurrencyID:=dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger;
        dialog.DocFlgACNT:=dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger=1;
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe54Inventarizatia.ShowModifyGoodsDialog;
var dialog:Tfrm52ZamenaTovaraEditorDlg;
    ReadOnly:Boolean;
begin
     if Not (fSECURITY_CanGoodsEdit or fSECURITY_CanView) then Exit;
     if fSECURITY_CanGoodsEdit
       then ReadOnly:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1
       else ReadOnly:=fSECURITY_CanView;

     dialog:=Tfrm52ZamenaTovaraEditorDlg.Create(Self,IBCQueryGoods,IBCDataSourceGoods);
     try
        dialog.DocID:=dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        dialog.DT_DEP:=dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
        dialog.DocData:=dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
        dialog.DocCurrencyID:=dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger;
        dialog.DocFlgACNT:=dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger=1;
        dialog.CreateNewRecord:=False;
        dialog.ReadOnly:=ReadOnly;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe54Inventarizatia.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     DocumentSelectionChanged;
end;

procedure Tframe54Inventarizatia.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsSelectionChanged;
end;

end.
