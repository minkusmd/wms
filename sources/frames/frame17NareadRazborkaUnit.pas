unit frame17NareadRazborkaUnit;

// СБОРКА. Наряд на разборку
// DocTypeID = 1249
// Frame Index = 17

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxGraphics, DB, cxDBData,
  dxBar, DBAccess, IBC, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, cxPC, ExtCtrls, cxSplitter,
  cxCalc, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxLabel, cxCurrencyEdit,
  cxCheckBox, MemDS, cxClasses, dxUIAClasses;

type
  Tframe17NareadRazborka = class(TSWNBaseFrame)
    cxSplitter1: TcxSplitter;
    pnBottom: TPanel;
    cxPageControlComplect: TcxPageControl;
    tbsGoods: TcxTabSheet;
    tbsKitContent: TcxTabSheet;
    cxGridRazborka: TcxGrid;
    cxGridRazborkaTable: TcxGridDBTableView;
    cxGridRazborkaTableDocID: TcxGridDBColumn;
    cxGridRazborka_DATA: TcxGridDBColumn;
    cxGridRazborkaTableWarehouse: TcxGridDBColumn;
    cxGridRazborkaTableCtName: TcxGridDBColumn;
    cxGridRazborkaTableSuma: TcxGridDBColumn;
    cxGridRazborkaTableCurrencyName: TcxGridDBColumn;
    cxGridRazborkaTableVAT: TcxGridDBColumn;
    cxGridRazborkaTableRate: TcxGridDBColumn;
    cxGridRazborkaTableParentDocID: TcxGridDBColumn;
    cxGridRazborka_FLG_ACNT: TcxGridDBColumn;
    cxGridRazborkaTableCreatedBy: TcxGridDBColumn;
    cxGridRazborka_FLG_CLOSED: TcxGridDBColumn;
    cxGridRazborkaLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbSerialPartNumbers: TdxBarButton;
    IBCQueryJurnalKit: TIBCQuery;
    IBCDataSourceJurnalKit: TIBCDataSource;
    dxBarPopupMenu: TdxBarPopupMenu;
    cxGridComponents: TcxGrid;
    cxGridComponentsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    cxGridComplect: TcxGrid;
    cxGridComplectTable: TcxGridDBTableView;
    cxGridComplect_GOODSID: TcxGridDBColumn;
    cxGridComplect_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridComplect_GOODS_NAME: TcxGridDBColumn;
    cxGridComplect_UM_NAME: TcxGridDBColumn;
    cxGridComplect_QTY: TcxGridDBColumn;
    cxGridComplect_PRICE: TcxGridDBColumn;
    cxGridComplect_SUMA: TcxGridDBColumn;
    cxGridComplect_SUMAVAT: TcxGridDBColumn;
    cxGridComplect_FLG_ACNT: TcxGridDBColumn;
    cxGridComplect_WARRANTY: TcxGridDBColumn;
    cxGridComplect_STOCK_QTY: TcxGridDBColumn;
    cxGridComplect_FLG_ACTIVE: TcxGridDBColumn;
    cxGridComplect_FLG_READY: TcxGridDBColumn;
    cxGridComplectLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    IBCQueryJurnalLocal: TIBCQuery;
    IBCDataSourceJurnalLocal: TIBCDataSource;
    cxGridComponents_SN: TcxGridDBColumn;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    bbAddGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbRemoveGoods: TdxBarButton;
    bbGoodsSerial: TdxBarButton;
    bbAddGoodsComplect: TdxBarButton;
    bbModifyGoodsComplect: TdxBarButton;
    bbRemoveGoodsComplect: TdxBarButton;
    bbKitsDisassembled: TdxBarButton;
    cxGridComponents_UMID: TcxGridDBColumn;
    cxGridComplect_UMID: TcxGridDBColumn;
    bbCloseDocument: TdxBarButton;
    bbOpenDocument: TdxBarButton;
    procedure bbSerialPartNumbersClick(Sender: TObject);
    procedure cxPageControlComplectChange(Sender: TObject);
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbGoodsSerialClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbRemoveGoodsClick(Sender: TObject);
    procedure bbAddGoodsComplectClick(Sender: TObject);
    procedure bbModifyGoodsComplectClick(Sender: TObject);
    procedure bbRemoveGoodsComplectClick(Sender: TObject);
    procedure cxGridRazborkaTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbKitsDisassembledClick(Sender: TObject);
    procedure cxGridComplectTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure dxBarPopupMenuPopup(Sender: TObject);
    procedure cxGridRazborkaTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridRazborkaTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComplectTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridRazborka_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbCloseDocumentClick(Sender: TObject);
    procedure bbOpenDocumentClick(Sender: TObject);
  private
    { Private declarations }
    fLastDocID:integer;
    procedure WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;

    procedure WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;

    procedure WhenGoodsComplectGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsComplectSelectionChanged;

    procedure WhenDocumentPopupMenuOpen;

    procedure ShowSetupSerialNumbersForComplectDialog;
    procedure ShowSetupSerialNumbersForItemDialog(const ViewOnly:Boolean);
    procedure ShowSetupPartNumbersForItemDialog(const ViewOnly:Boolean);

    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;

    procedure ShowAddGoodComplectDialog;
    procedure ShowModifyGoodsComplectDialog;
    procedure DelectedSelectedGoodsComplect;

    function CreateKitBySerialNumber:Boolean;

    procedure ShowKitsDisassembled;
    function DoActionDB_KitsDisassembled(const DocID:integer):Boolean;

    procedure SetupQtyFields;
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
    procedure SetupSecurityItems; override;

  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    function CloseDocument(const DocID: integer): Boolean;
    function OpenDocument(const DocID: integer): Boolean;
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNTypes, frmSerialNumbersDialog,
  frmNareadRazborkaDocDialog,
  SWNUtils, frmSelectGoodsToAddDialog, SWNDBErrors, frmDocumentDeleteDialog, frmPartNumbersDialog,
  frmSelectSNDialog, SWNSecurityFlags, SWNSecurity, SWNConst;

{$R *.dfm}

{ Tframe17NareadRazborka }


procedure Tframe17NareadRazborka.bbAddGoodsClick(Sender: TObject);
begin
     ShowAddGoodsDialog;
end;

procedure Tframe17NareadRazborka.bbGoodsSerialClick(Sender: TObject);
begin
     ShowSetupSerialNumbersForComplectDialog;
end;

procedure Tframe17NareadRazborka.bbKitsDisassembledClick(Sender: TObject);
begin
     ShowKitsDisassembled;
end;

procedure Tframe17NareadRazborka.bbAddGoodsComplectClick(Sender: TObject);
begin
     ShowAddGoodComplectDialog;
end;

procedure Tframe17NareadRazborka.bbModifyGoodsComplectClick(Sender: TObject);
begin
     ShowModifyGoodsComplectDialog;
end;

procedure Tframe17NareadRazborka.bbRemoveGoodsComplectClick(Sender: TObject);
begin
     DelectedSelectedGoodsComplect;
end;

procedure Tframe17NareadRazborka.bbModifyGoodsClick(Sender: TObject);
begin
     ShowModifyGoodsDialog;
end;

procedure Tframe17NareadRazborka.bbRemoveGoodsClick(Sender: TObject);
begin
     DeleteSelectedGoods;
end;

procedure Tframe17NareadRazborka.bbSerialPartNumbersClick(Sender: TObject);
var N:integer;
    viewOnly:Boolean;
begin
     viewOnly:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
     N:=IBCQueryJurnalKit.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;

     if (N=cSYSS_GOODS_SERIAL_TYPE_Серийный_учет)
      then ShowSetupSerialNumbersForItemDialog(viewOnly)  // Серийный учет
      else
      if (N=cSYSS_GOODS_SERIAL_TYPE_Партийный_учет)
       then ShowSetupPartNumbersForItemDialog(viewOnly); // Партийный учет
end;

function Tframe17NareadRazborka.CreateKitBySerialNumber:Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;

        Query.Transaction.StartTransaction;
        try
           Query.SQL.Text:='EXECUTE PROCEDURE SP_NAREADRAZBORKA_CREATEKIT(:DOCID,:DTDEP,:CTDEP,:GOODSID,:SN,:USERID)';
           Query.ParamByName('DOCID').AsInteger:=dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
           Query.ParamByName('DTDEP').AsInteger:=dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
           Query.ParamByName('CTDEP').AsInteger:=dmDB.IBCQueryDocs.FieldByName('CTDEP').AsInteger;
           Query.ParamByName('GOODSID').AsInteger:=IBCQueryJurnalLocal.FieldByName('GOODSID').AsInteger;
           Query.ParamByName('SN').AsString:=IBCQueryJurnalLocal.FieldByName('SN').AsString;
           Query.ParamByName('USERID').AsInteger:=dmDB.CurrentUserID;
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure Tframe17NareadRazborka.CreateNewRecord;
var dialog:TfrmNareaRazborkaDocDlg;
begin
     dialog:=TfrmNareaRazborkaDocDlg.Create(self);
     try
        dialog.CreateNewDocument:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe17NareadRazborka.cxGridComplectTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if bbModifyGoodsComplect.Enabled then
     begin
          ShowModifyGoodsComplectDialog;
          AHandled:=True;
     end;
end;

procedure Tframe17NareadRazborka.cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe17NareadRazborka.cxGridComplectTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self, cxGridComplectTable,key,Shift);
end;

procedure Tframe17NareadRazborka.cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[Sender.Index]) then
     begin
          if (ARecord.Values[cxGridComplect_UMID.Index]=1) then AText:=StringReplace(AText,QtyReplaceMask,'',[]);
     end;
end;

procedure Tframe17NareadRazborka.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if bbModifyGoods.Enabled then
     begin
          ShowModifyGoodsDialog;
          AHandled:=True;
     end;
end;

procedure Tframe17NareadRazborka.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe17NareadRazborka.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self, cxGridComponentsTable,Key,Shift);
end;

procedure Tframe17NareadRazborka.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[Sender.Index]) then
     begin
          if (ARecord.Values[cxGridComponents_UMID.Index]=1) then AText:=StringReplace(AText,QtyReplaceMask,'',[]);
     end;
end;

procedure Tframe17NareadRazborka.cxGridRazborkaTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if (AButton=mbLeft) then
     begin
          DoDocumentDoubleClick;
          AHandled:=True;
     end;
end;

procedure Tframe17NareadRazborka.cxGridRazborkaTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridRazborka_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridRazborka_FLG_CLOSED.index]=0 then
          begin
               if Not AViewInfo.Selected then
               begin
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGridRazborka_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
               end;
          end
          else
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    if AViewInfo.GridRecord.Values[cxGridRazborka_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
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

procedure Tframe17NareadRazborka.cxGridRazborka_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridRazborka_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridRazborka_DATA.Index]);
end;

procedure Tframe17NareadRazborka.cxGridRazborkaTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self, cxGridRazborkaTable,Key,Shift);
end;

procedure Tframe17NareadRazborka.cxPageControlComplectChange(Sender: TObject);
begin
     GoodsSelectionChanged;
end;

procedure Tframe17NareadRazborka.DelectedSelectedGoodsComplect;
var S,S2:String;
begin
     S:=#13#10+IBCQueryJurnalKit.FieldByName('GOODS_NAME').AsString+#13#10;
     S2:='Complect: '+IBCQueryJurnalLocal.FieldByName('GOODS_NAME').AsString;

     if ShowAskDialog('Dezasamblare','Doriti sa stergeti produsul '+S+' din complect?',S2)=mrYes then
     begin
          IBCQueryJurnalKit.UpdateTransaction.StartTransaction;
          try
             IBCQueryJurnalKit.Delete;
             IBCQueryJurnalKit.UpdateTransaction.Commit;
             dmDB.IBCQueryDocs.Refresh;
          except on E:Exception do
             begin
                  IBCQueryJurnalKit.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

procedure Tframe17NareadRazborka.DeleteRecord;
begin
     DeleteCurrentSWNDocument(Self);
end;

procedure Tframe17NareadRazborka.DeleteSelectedGoods;
var S:String;
begin
     S:=#13#10+IBCQueryJurnalLocal.FieldByName('GOODS_NAME').AsString+' ?';
     if ShowAskDialog('Dezasamblare','Doriti sa stergeti complectul '+S)=mrYes then
     begin
          IBCQueryJurnalLocal.UpdateTransaction.StartTransaction;
          try
             IBCQueryJurnalLocal.Delete;
             IBCQueryJurnalLocal.UpdateTransaction.Commit;
             dmDB.IBCQueryDocs.Refresh;
          except on E:Exception do
             begin
                  IBCQueryJurnalLocal.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

function Tframe17NareadRazborka.DoActionDB_KitsDisassembled(const DocID:integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=false;

     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
           Query.SQL.Text:='EXECUTE PROCEDURE SP_DISASSEMBLY(:DOCID)';
           Query.ParamByName('DOCID').AsInteger:=DocID;
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure Tframe17NareadRazborka.DocumentSelectionChanged;
var fDocNew,fDocEdit,fDocDelete:Boolean;
    fDocChanged:Boolean;
    FLG_CLOSED:Boolean;
begin
     fDocNew:=True; // New Document + Security
     fDocEdit:=False;
     fDocDelete:=False;

     fDocChanged:=True;

     if cxGridRazborkaTable.DataController.RecNo>0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          if Not FLG_CLOSED then
          begin
               fDocEdit:=True;   // Edit Document + Security
               fDocDelete:=True; // Delete Document + Security
          end;

          fDocChanged:=fLastDocID<>dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
          fLastDocID:=dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
     end;
     // Document
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);
     // tabs
     if fDocChanged then
     begin
          cxPageControlComplect.ActivePage:=tbsGoods;
     end;

     WhenDocumentPopupMenuOpen;

     GoodsSelectionChanged;
end;

procedure Tframe17NareadRazborka.DoFrameHide;
begin
     // inchidem datele interne
     IBCQueryJurnalKit.Active:=False;
     IBCQueryJurnalLocal.Active:=False;

     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridRazborkaTable.OnFocusedRecordChanged:=nil;
     cxGridComplectTable.OnFocusedRecordChanged:=nil;
     cxGridComponentsTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridRazborkaTable.DataController.DataSource:=nil;
     cxGridComponentsTable.DataController.DataSource:=nil;

     inherited;
end;

procedure Tframe17NareadRazborka.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     fLastDocID:=-1;

     // 1. Legam grid-urile de datasource-sele
     cxGridRazborkaTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;
     cxGridComponentsTable.DataController.DataSource:=IBCDataSourceJurnalLocal;

     // 2. Selection handlers
     cxGridRazborkaTable.OnFocusedRecordChanged:=WhenDocGridFocusedRecordChanged;
     cxGridComponentsTable.OnFocusedRecordChanged:=WhenGoodsGridFocusedRecordChanged;
     cxGridComplectTable.OnFocusedRecordChanged:=WhenGoodsComplectGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
     IBCQueryJurnalLocal.Active:=True;
     IBCQueryJurnalKit.Active:=True;

     // 4. Selection update
     DocumentSelectionChanged;
     GoodsSelectionChanged;
     GoodsComplectSelectionChanged;
end;

procedure Tframe17NareadRazborka.bbCloseDocumentClick(Sender: TObject);
begin
  inherited;
  CloseDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
  dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe17NareadRazborka.bbOpenDocumentClick(Sender: TObject);
begin
  OpenDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
  dmDB.IBCQueryDocs.Refresh;
end;

function Tframe17NareadRazborka.CloseDocument(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := false;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_1249(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
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

function Tframe17NareadRazborka.OpenDocument(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := false;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_1249(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
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



procedure Tframe17NareadRazborka.dxBarPopupMenuPopup(Sender: TObject);
begin
     WhenDocumentPopupMenuOpen;
end;

function Tframe17NareadRazborka.GetCurrentSearchContext: TSearchContextValue;
begin
     Result := Inherited;

     if cxGridComponentsTable.Site.Focused then
     begin
          // context from Jurnal: Код + Наименование
          Result.Context := ffGoods;
          Result.ValueInt := IBCQueryJurnalLocal.FieldByName('GOODSID').AsInteger;
          Result.ValueStr := IBCQueryJurnalLocal.FieldByName('GOODS_NAME').AsString;
     end
     else
         if cxGridRazborkaTable.Site.Focused then
         begin
              // context from Docs
              if cxGridRazborkaTableCtName.Focused then
              begin
                   // Контрагент
                   Result.Context := ffCustomer;
                   Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
                   Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
              end
              else
                  if cxGridRazborka_DATA.Focused then
                  begin
                       // Дата
                       Result.Context := ffDate;
                       Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
                  end
                  else
                      if cxGridRazborkaTableWarehouse.Focused then
                      begin
                           // Склад
                           Result.Context := ffStock;
                           Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
                           Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
                      end;
         end
end;

function Tframe17NareadRazborka.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe17NareadRazborka.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffCustomer,ffGoods,ffStock];
end;

function Tframe17NareadRazborka.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtADD,fbtMODIFY,fbtDELETE,fbtREFRESH];
end;

function Tframe17NareadRazborka.InitFrameID: integer;
begin
     Result:=17; // СБОРКА - Наряд на разборку
     SetupQtyFields;
end;

procedure Tframe17NareadRazborka.ModifyRecord;
var dialog:TfrmNareaRazborkaDocDlg;
begin
     dialog:=TfrmNareaRazborkaDocDlg.Create(self);
     try
        dialog.CreateNewDocument:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe17NareadRazborka.RefreshData;
begin
     inherited;
     IBCQueryJurnalLocal.Refresh;
     IBCQueryJurnalKit.Refresh;
end;

procedure Tframe17NareadRazborka.GoodsComplectSelectionChanged;
var fKitAdd,fKitEdit,fKitRemove,fSerialParts:Boolean;
    FLG_CLOSED:Boolean;
begin
     fKitAdd:=False;
     fKitEdit:=False;
     fKitRemove:=False;
     fSerialParts:=False;

     if (cxGridRazborkaTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
          if (cxGridComponentsTable.DataController.RecNo>0)
             and (dmdb.IsKit(IBCQueryJurnalLocal.FieldByName('GOODS_TYPE_ID').AsInteger)) then
          begin
               fKitAdd:=Not FLG_CLOSED; // Добавить товар

               if cxGridComplectTable.DataController.RecNo>0 then
               begin
                    fKitEdit:=Not FLG_CLOSED;   // Изменить товар
                    fKitRemove:=Not FLG_CLOSED; // Удалить товар

                    fSerialParts:=(IBCQueryJurnalKit.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger=cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) OR // Серийный учет
                                 (IBCQueryJurnalKit.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger=cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);  // Партийный учет
               end;
          end;
     end;
     // Комплектация
     bbAddGoodsComplect.Enabled:=fKitAdd;
     bbModifyGoodsComplect.Enabled:=fKitEdit;
     bbRemoveGoodsComplect.Enabled:=fKitRemove;
     bbSerialPartNumbers.Enabled:=fSerialParts;
end;

procedure Tframe17NareadRazborka.GoodsSelectionChanged;
var fKit:Boolean;
    fAdd,fEdit,fRemove,fSerial:Boolean;
    FLG_CLOSED:Boolean;
begin
     // additional buttons
     fKit:=False;

     fAdd:=False;
     fEdit:=False;
     fRemove:=False;
     fSerial:=False;

     if (cxGridRazborkaTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fAdd:=(Not FLG_CLOSED); // Добавить комплект + Security

          if cxGridComponentsTable.DataController.RecNo>0 then
          begin
               // Состав
               fEdit:=(Not FLG_CLOSED); // Изменить комплект + Security
               fRemove:=(Not FLG_CLOSED); // Удалить комплект + Security

               fKit:=dmDB.IsKit(IBCQueryJurnalLocal.FieldByName('GOODS_TYPE_ID').AsInteger);
               fSerial:=(IBCQueryJurnalLocal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger=cSYSS_GOODS_SERIAL_TYPE_Серийный_учет); // Серийный учет
          end;
     end;
     // tabs
     tbsKitContent.TabVisible:=fKit;
     // Состав
     bbAddGoods.Enabled:=fAdd;
     bbModifyGoods.Enabled:=fEdit;
     bbRemoveGoods.Enabled:=fRemove;
     bbGoodsSerial.Enabled:=fSerial;
end;

procedure Tframe17NareadRazborka.ShowAddGoodsDialog;
var dialog:TfrmSelectGoodsToAddDlg;
begin
     dialog:=TfrmSelectGoodsToAddDlg.Create(Self,IBCQueryJurnalLocal,IBCDataSourceJurnalLocal);
     try
        dialog.AddNewGoods:=True;

        dialog.AllowedActions:=dialog.AllowedActions-[acChangeACNT,acChangePrice,acChangeActive,acChangeEU,acChangeEUK,acChangeWarranty];
        dialog.GoodsTypeFilter:=[gtfComplect];

        if dialog.ShowModal=mrOk then
        begin
             dmDB.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe17NareadRazborka.ShowKitsDisassembled;
begin
     if ShowAskDialog('Dezasamblare','Doriti sa fie dezasamblate toate elementele complectului ?')=mrYes then
     begin
          if DoActionDB_KitsDisassembled(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
          begin
               dmDB.IBCQueryDocs.Refresh;
               DocumentSelectionChanged;
               GoodsSelectionChanged;
               GoodsComplectSelectionChanged;
          end;
     end;
end;

procedure Tframe17NareadRazborka.SetupDefaultFocus;
begin
     // grid
     cxGridRazborka.SetFocus;
     // columns
     cxGridRazborkaTableCtName.Focused:=True;
     cxGridDBCol_GOODS_NAME.Focused:=True;
end;

procedure Tframe17NareadRazborka.SetupQtyFields;
begin
     // Состав: Кол-во
     TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat:=QtyDisplayFormat;
     cxGridDBCol_QTY.Summary.FooterFormat:=QtyDisplayFormat;
     // Состав: Остаток
     TcxCalcEditProperties(cxGridDBCol_STOCK_QTY.Properties).DisplayFormat:=QtyDisplayFormat;
     // Комплектация: Кол-во
     TcxCalcEditProperties(cxGridComplect_QTY.Properties).DisplayFormat:=QtyDisplayFormat;
     cxGridComplect_QTY.Summary.FooterFormat:=QtyDisplayFormat;
     // Комплектация: Остаток
     TcxCalcEditProperties(cxGridComplect_STOCK_QTY.Properties).DisplayFormat:=QtyDisplayFormat;
end;

procedure Tframe17NareadRazborka.SetupSecurityItems;
begin
  inherited;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СБОРКА_ННР_Закрыть) then
  bbCloseDocument.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СБОРКА_ННР_Открыть) then
  bbOpenDocument.Visible := ivNever;

end;

procedure Tframe17NareadRazborka.ShowAddGoodComplectDialog;
var dialog:TfrmSelectGoodsToAddDlg;
begin
     dialog:=TfrmSelectGoodsToAddDlg.Create(Self,IBCQueryJurnalKit,IBCDataSourceJurnalKit,IBCQueryJurnalLocal.FieldByName('GOODSID').AsInteger);
     try
        dialog.AddNewGoods:=True;
        dialog.AllowedActions:=dialog.AllowedActions-[acChangeACNT,acChangePrice,acChangeActive,acChangeEU,acChangeEUK,acChangeWarranty];

        if dialog.ShowModal=mrOk then
        begin
             dmDB.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe17NareadRazborka.ShowModifyGoodsDialog;
var dialog:TfrmSelectGoodsToAddDlg;
begin
     dialog:=TfrmSelectGoodsToAddDlg.Create(Self,IBCQueryJurnalLocal,IBCDataSourceJurnalLocal);
     try
        dialog.AddNewGoods:=False;
        dialog.AllowedActions:=dialog.AllowedActions-[acChangeACNT,acChangePrice,acChangeActive,acChangeEU,acChangeEUK,acChangeWarranty];
        dialog.GoodsTypeFilter:=[gtfComplect];

        if dialog.ShowModal=mrOk then
        begin
             dmDB.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe17NareadRazborka.ShowModifyGoodsComplectDialog;
var dialog:TfrmSelectGoodsToAddDlg;
begin
     dialog:=TfrmSelectGoodsToAddDlg.Create(Self,IBCQueryJurnalKit,IBCDataSourceJurnalKit,IBCQueryJurnalLocal.FieldByName('GOODSID').AsInteger);
     try
        dialog.AddNewGoods:=False;
        dialog.AllowedActions:=dialog.AllowedActions-[acChangeACNT,acChangePrice,acChangeActive,acChangeEU,acChangeEUK,acChangeWarranty];

        if dialog.ShowModal=mrOk then
        begin
             dmDB.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe17NareadRazborka.ShowSetupPartNumbersForItemDialog(const ViewOnly:Boolean);
var dialog:TfrmPartNumbersDlg;
begin
     dialog := TfrmPartNumbersDlg.Create(self, IBCQueryJurnalKit, IBCDataSourceJurnalKit);
     try
        dialog.ReadOnly:=ViewOnly;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe17NareadRazborka.ShowSetupSerialNumbersForComplectDialog;
var dialog: TfrmSelectSNDlg;
    prevSN:String;
    ViewOnly:Boolean;
begin
     ViewOnly:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

     prevSN:='';
     if Not IBCQueryJurnalLocal.FieldByName('SN').IsNull then prevSN:=IBCQueryJurnalLocal.FieldByName('SN').AsString;

     dialog:=TfrmSelectSNDlg.Create(Self,IBCQueryJurnalLocal,IBCDataSourceJurnalLocal);
     try
        dialog.ReadOnly:=ViewOnly;
        dialog.DocsDataSet:=dmDB.IBCQueryDocs;

        if dialog.ShowModal=mrOk then
        begin
             IBCQueryJurnalLocal.Refresh;
             // daca o fost introdus seriiniku, atunci incercam sa gasim produsele din complect
             if (Not IBCQueryJurnalLocal.FieldByName('SN').IsNull) and (prevSN<>IBCQueryJurnalLocal.FieldByName('SN').AsString) then
             begin
                  // ask dialog
                  if CreateKitBySerialNumber then
                  begin
                       IBCQueryJurnalKit.Refresh;
                       ShowInfoDialog('Dezasamblare','Elementele din complect vor fi adaugate in lista de dezasamblare.');
                  end
                  else ShowErrorDialog('Dezasamblare','Elementele din complect nu au fost gasite. Introduceti manual.');
             end;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe17NareadRazborka.ShowSetupSerialNumbersForItemDialog(const ViewOnly:Boolean);
var frmSelectSNDlg: TfrmSerialNumbersDlg;
begin
     frmSelectSNDlg:=TfrmSerialNumbersDlg.Create(Self,IBCQueryJurnalKit,IBCDataSourceJurnalKit);
     try
        frmSelectSNDlg.ReadOnly:=ViewOnly;
        frmSelectSNDlg.ShowModal;
     finally
        frmSelectSNDlg.Free;
     end;
end;

procedure Tframe17NareadRazborka.WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     DocumentSelectionChanged;
end;

procedure Tframe17NareadRazborka.WhenDocumentPopupMenuOpen;
var fDisassembled:Boolean;
    FLG_SHIP:Boolean;
begin
     fDisassembled:=False;

     if (cxGridRazborkaTable.DataController.RecNo>0) and (dmDB.IBCQueryDocs.FieldByName('HAS_JURNAL_GOODS').AsInteger=1) then
     begin
          FLG_SHIP:=dmDB.IBCQueryDocs.FieldByName('FLG_SHIP').AsInteger=1;
          fDisassembled:=(Not FLG_SHIP); // Комплекты разобранны + Security
     end;
     // popup
     bbKitsDisassembled.Enabled:=fDisassembled; // Комплекты разобранны
end;

procedure Tframe17NareadRazborka.WhenGoodsComplectGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsComplectSelectionChanged;
end;

procedure Tframe17NareadRazborka.WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsSelectionChanged;
end;

end.
