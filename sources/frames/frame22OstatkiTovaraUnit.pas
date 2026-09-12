unit frame22OstatkiTovaraUnit;
{
  STOCURI. Stoc marfa
  DocTypeID = 122
  Frame Index = 22
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxGraphics,
  DB, cxDBData, DBAccess, IBC, dxBar, cxSplitter,
  cxPC, ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid,
  cxGridPopupMenu, cxCalc, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCurrencyEdit, cxLabel, cxCheckBox,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, MemDS, cxClasses, dxUIAClasses;

type
  Tframe22OstatkiTovara = class(TSWNBaseFrame)
    cxGridOT: TcxGrid;
    cxGridOTTable: TcxGridDBTableView;
    cxGridOT_DOCID: TcxGridDBColumn;
    cxGridOT_DATA: TcxGridDBColumn;
    cxGridOT_DT_NAME: TcxGridDBColumn;
    cxGridOT_SUMA: TcxGridDBColumn;
    cxGridOT_CURRENCY_NAME: TcxGridDBColumn;
    cxGridOT_VAT: TcxGridDBColumn;
    cxGridOT_FLG_ACNT: TcxGridDBColumn;
    cxGridOT_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridOTLevel: TcxGridLevel;
    cxGridOT_DTDEP: TcxGridDBColumn;
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    cxPageControl: TcxPageControl;
    tbsGoods: TcxTabSheet;
    cxGridComponents: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_COST: TcxGridDBColumn;
    cxGridDBCol_Price: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_ACNT: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    tbsExpenses: TcxTabSheet;
    cxGridExpenses: TcxGrid;
    cxGridExpensesTable: TcxGridDBTableView;
    cxGridExpenses_NAME: TcxGridDBColumn;
    cxGridExpenses_EXPENSE_DOC_ID: TcxGridDBColumn;
    cxGridExpenses_EXPENSE_DOC_DOCTYPE_TITLE: TcxGridDBColumn;
    cxGridExpenses_SUMA: TcxGridDBColumn;
    cxGridExpenses_CURRENCY: TcxGridDBColumn;
    cxGridExpenses_RATE: TcxGridDBColumn;
    cxGridExpensesLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbAddGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbDeleteGoods: TdxBarButton;
    dxPopupMenuDocs: TdxBarPopupMenu;
    dxBarManagerBar2: TdxBar;
    bbAddExpense: TdxBarButton;
    bbEditExpense: TdxBarButton;
    bbDeleteExpense: TdxBarButton;
    IBCQueryExpenses: TIBCQuery;
    IBCDataSourceExpenses: TIBCDataSource;
    bbActionCloseDocument: TdxBarButton;
    bbActionOpenDocument: TdxBarButton;
    cxGridOT_FLG_CLOSED: TcxGridDBColumn;
    bbSerialNumbers: TdxBarButton;
    cxGridGoods_DTDEP: TcxGridDBColumn;
    cxGridGoods_FLG_READY: TcxGridDBColumn;
    cxGridGoods_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridGoods_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridDocsPopupMenu: TcxGridPopupMenu;
    procedure cxPageControlChange(Sender: TObject);
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbDeleteGoodsClick(Sender: TObject);
    procedure bbAddExpenseClick(Sender: TObject);
    procedure bbEditExpenseClick(Sender: TObject);
    procedure bbDeleteExpenseClick(Sender: TObject);
    procedure cxGridOTTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbActionCloseDocumentClick(Sender: TObject);
    procedure bbActionOpenDocumentClick(Sender: TObject);
    procedure cxGridOTTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridExpensesTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure dxPopupMenuDocsPopup(Sender: TObject);
    procedure bbSerialNumbersClick(Sender: TObject);
    procedure cxGridOTTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridExpensesTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    fLastDocID:integer;
    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;

    procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;

    procedure WhenExpenseGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure ExpenseSelectionChanged;

    procedure WhenDocumentPopupMenuOpen;

    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;

    procedure ShowAddExpenseDialog;
    procedure ShowModifyExpenseDialog;
    procedure DeleteSelectedExpense;

    function DoActionDB(const ActionID:integer):Boolean;
    procedure DoActionCloseDocument;
    procedure DoActionOpenDocument;

    procedure ShowInputSerialNumbersDialog(const ViewOnly:Boolean);
    procedure ShowInputPartNumbersDialog(const ViewOnly:Boolean);

    procedure RefreshJurnal_Smart;

    procedure SetuQtyFields;

  protected
    { Protected declarations }
    function InitFrameID:integer;override;

    function GetExternalDataSourceTypes:TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;

    function GetFilterFields:TFrameFilterFields;override;

    procedure CreateNewRecord;override;
    procedure ModifyRecord;override;
    procedure DeleteRecord;override;
    procedure RefreshData;override;

    procedure ReadFrameStates;override;
    procedure SaveFrameStates;override;
  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;


implementation

uses DataModuleDB, SWNConst, SWNUtils, SWNDBErrors,
     frmОстаткиТовараDocDialog, frmSelectGoodsToAddDialog, frmNakladnaiaPNExpenseDialog,
  frmPartNumbersDialog, frmSerialNumbersDialog, SWNTypes, SWNValueStorageUnit;

{$R *.dfm}

{ Tframe22ОстаткиТовара }

procedure Tframe22OstatkiTovara.bbActionCloseDocumentClick(Sender: TObject);
begin
     DoActionCloseDocument;
end;

procedure Tframe22OstatkiTovara.bbActionOpenDocumentClick(Sender: TObject);
begin
     DoActionOpenDocument;
end;

procedure Tframe22OstatkiTovara.bbAddExpenseClick(Sender: TObject);
begin
     ShowAddExpenseDialog;
end;

procedure Tframe22OstatkiTovara.bbAddGoodsClick(Sender: TObject);
begin
     ShowAddGoodsDialog;
end;

procedure Tframe22OstatkiTovara.bbDeleteExpenseClick(Sender: TObject);
begin
     DeleteSelectedExpense;
end;

procedure Tframe22OstatkiTovara.bbDeleteGoodsClick(Sender: TObject);
begin
     DeleteSelectedGoods;
end;

procedure Tframe22OstatkiTovara.bbEditExpenseClick(Sender: TObject);
begin
     ShowModifyExpenseDialog;
end;

procedure Tframe22OstatkiTovara.bbModifyGoodsClick(Sender: TObject);
begin
     ShowModifyGoodsDialog;
end;

procedure Tframe22OstatkiTovara.bbSerialNumbersClick(Sender: TObject);
var viewOnly:Boolean;
begin
     viewOnly:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

     if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger=cSYSS_GOODS_SERIAL_TYPE_Серийный_учет
      then ShowInputSerialNumbersDialog(viewOnly)
      else
      if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger=cSYSS_GOODS_SERIAL_TYPE_Партийный_учет
       then ShowInputPartNumbersDialog(viewOnly);
end;

procedure Tframe22OstatkiTovara.CreateNewRecord;
var dialog:TfrmOstatkiTovaraDocDlg;
begin
     dialog:=TfrmOstatkiTovaraDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe22OstatkiTovara.cxGridExpensesTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if bbEditExpense.Enabled then
     begin
          ShowModifyExpenseDialog;
          AHandled:=True;
     end;
end;

procedure Tframe22OstatkiTovara.cxGridExpensesTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self, cxGridExpensesTable,Key,Shift);
end;

procedure Tframe22OstatkiTovara.cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if bbModifyGoods.Enabled then
     begin
          ShowModifyGoodsDialog;
          AHandled:=True;
     end;
end;

procedure Tframe22OstatkiTovara.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color := $E8E8E8;
     end;
end;

procedure Tframe22OstatkiTovara.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self, cxGridGoodsTable,Key,Shift);
end;

procedure Tframe22OstatkiTovara.cxGridOTTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     DoDocumentDoubleClick;
     AHandled:=True;
end;

procedure Tframe22OstatkiTovara.cxGridOTTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if Not VarIsNull(AViewInfo.GridRecord.Values[cxGridOT_FLG_CLOSED.Index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridOT_FLG_CLOSED.Index]=1 then
          begin
               ACanvas.Font.Style:=[fsStrikeOut];
               ACanvas.Font.Color:=clGrayText;
          end;
     end;

     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color := $E8E8E8;
     end;
end;

procedure Tframe22OstatkiTovara.cxGridOTTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self, cxGridOTTable,Key,Shift);
end;

procedure Tframe22OstatkiTovara.cxPageControlChange(Sender: TObject);
begin
     GoodsSelectionChanged;
end;

procedure Tframe22OstatkiTovara.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format('Stergeti inregistrarea numarul %d?',[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))=mrYes then
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

procedure Tframe22OstatkiTovara.DeleteSelectedExpense;
var S:WideString;
begin
     S:=#13#10+Format('%s in suma de %f %s ?',[IBCQueryExpenses.FieldByName('EXPENSE_TITLE').AsString,
                                            IBCQueryExpenses.FieldByName('EXPENSE_DOC_SUMA').AsCurrency,
                                            IBCQueryExpenses.FieldByName('EXPENSE_DOC_CURRENCY_NAME').AsString]);
     if ShowAskDialog('Stergere cheltuieli','Stergeti cheltuielile suplimentare'+S)=mrYes then
     begin
          try
             IBCQueryExpenses.Delete;
             IBCQueryExpenses.UpdateTransaction.Commit;
          except
             IBCQueryExpenses.UpdateTransaction.Rollback;
             raise;
          end;
     end;
end;

procedure Tframe22OstatkiTovara.DeleteSelectedGoods;
var S:String;
begin
     S:=#13#10+dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString+' ?';
     if ShowAskDialog('Stergere produs','Sterge produsul'+S)=mrYes then
     begin
          try
             dmDB.IBCQueryJurnal.Delete;
             dmDB.IBCQueryJurnal.UpdateTransaction.Commit;
             dmDB.IBCQueryDocs.Refresh;
          except
             dmDB.IBCQueryJurnal.UpdateTransaction.Rollback;
             raise;
          end;
     end;
end;

procedure Tframe22OstatkiTovara.DoActionCloseDocument;
begin
     if ShowAskDialog('Inchidere "Stoc marfa"','Doriti sa inchideti "Stoc marfa"?')=mrYes then
     begin
          if DoActionDB(1) then
          begin
               dmDB.RefreshDocs;

               DocumentSelectionChanged;
               GoodsSelectionChanged;
               ExpenseSelectionChanged;
          end;
     end;
end;

function Tframe22OstatkiTovara.DoActionDB(const ActionID: integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=False;

     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
           case ActionID of
           // Inchide "Stoc marfa"
           1: Query.SQL.Text:='EXECUTE PROCEDURE SP_CLOSE_BALANCE_GOODS(:DOCID)';
           // Deschide "Stoc marfa"
           2: Query.SQL.Text:='EXECUTE PROCEDURE SP_OPEN_BALANCE_GOODS(:DOCID)';
           end;
           // set params
           Query.ParamByName('DOCID').AsInteger:=dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
           // exec
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

procedure Tframe22OstatkiTovara.DoActionOpenDocument;
begin
     if ShowAskDialog('Deschidere "Stoc marfa"','Doriti sa deschideti "Stoc marfa"?')=mrYes then
     begin
          if DoActionDB(2) then
          begin
               dmDB.RefreshDocs;

               DocumentSelectionChanged;
               GoodsSelectionChanged;
               ExpenseSelectionChanged;
          end;
     end;
end;

procedure Tframe22OstatkiTovara.DocumentSelectionChanged;
var fDocNew,fDocEdit,fDocDelete:Boolean;
    DocChanged:Boolean;
    FLG_CLOSED:Boolean;
begin
     fDocNew:=True; // New Document + Security
     fDocEdit:=False;
     fDocDelete:=false;

     DocChanged:=True;

     if cxGridOTTable.DataController.RecNo>0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          if Not FLG_CLOSED then
          begin
               fDocEdit:=True;   // Edit Document + Security
               fDocDelete:=True; // Delete Document + Security
          end;

          DocChanged:=fLastDocID<>dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
          fLastDocID:=dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
     end;
     // doc
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);

     if DocChanged then
     begin
          cxPageControl.ActivePage:=tbsGoods;
     end;

     WhenDocumentPopupMenuOpen;

     GoodsSelectionChanged;
     ExpenseSelectionChanged;
end;

procedure Tframe22OstatkiTovara.DoFrameHide;
begin
     // inchidem datele interne
     IBCQueryExpenses.Active:=False;

     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridExpensesTable.OnFocusedRecordChanged:=nil;
     cxGridGoodsTable.OnFocusedRecordChanged:=nil;
     cxGridOTTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridGoodsTable.DataController.DataSource:=nil;
     cxGridOTTable.DataController.DataSource:=nil;

     inherited;
end;

procedure Tframe22OstatkiTovara.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     fLastDocID:=-1;

     // 1. Legam grid-urile de datasource-sele
     cxGridOTTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;
     cxGridGoodsTable.DataController.DataSource:=dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
     cxGridOTTable.OnFocusedRecordChanged:=WhenDocGrid_FocusedRecordChanged;
     cxGridGoodsTable.OnFocusedRecordChanged:=WhenGoodsGrid_FocusedRecordChanged;
     cxGridExpensesTable.OnFocusedRecordChanged:=WhenExpenseGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
     IBCQueryExpenses.Active:=True;

     // 4. Selection update
     DocumentSelectionChanged;
end;

procedure Tframe22OstatkiTovara.dxPopupMenuDocsPopup(Sender: TObject);
begin
     WhenDocumentPopupMenuOpen;
end;

procedure Tframe22OstatkiTovara.ExpenseSelectionChanged;
var fExpenseNew,fExpenseEdit,fExpenseDelete:Boolean;
begin
     fExpenseNew:=False;
     fExpenseEdit:=False;
     fExpenseDelete:=False;

     if (cxGridOTTable.DataController.RecNo>0) and (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=0) then
     begin
          fExpenseNew:=True;  // Cheltuieli noi + Security
          if cxGridExpensesTable.DataController.RecNo>0 then
          begin
               fExpenseEdit:=True; // Modifica cheltuieli + Security
               fExpenseDelete:=True; // Sterge cheltuieli + Security
          end;
     end;
     // expenses
     bbAddExpense.Enabled:=fExpenseNew;
     bbEditExpense.Enabled:=fExpenseEdit;
     bbDeleteExpense.Enabled:=fExpenseDelete;
end;

function Tframe22OstatkiTovara.GetCurrentSearchContext: TSearchContextValue;
begin
     Result := Inherited;

     if cxGridGoodsTable.Site.Focused then
     begin
          // context from Jurnal: Cod + Denumire
          Result.Context := ffGoods;
          Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
          Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
     end
     else
         if cxGridOTTable.Site.Focused then
         begin
              if cxGridOT_DATA.Focused then
              begin
                   // Data
                   Result.Context := ffDate;
                   Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
              end
              else
                  if cxGridOT_DTDEP.Focused then
                  begin
                       // Depozit
                       Result.Context := ffStock;
                       Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
                       Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
                  end;
         end
end;

function Tframe22OstatkiTovara.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs,fedsJurnal];
end;

function Tframe22OstatkiTovara.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffGoods,ffStock,ffGoodsFolders,ffAcntGoods];
end;

function Tframe22OstatkiTovara.InitFrameID: integer;
begin
     Result:=22; // STOCURI. Stocuri marfa
     SetuQtyFields;
end;

procedure Tframe22OstatkiTovara.ModifyRecord;
var dialog:TfrmOstatkiTovaraDocDlg;
begin
     dialog:=TfrmOstatkiTovaraDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;

end;

procedure Tframe22OstatkiTovara.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        pnBottom.Height:=AppUserConfigStorage.IntValues.GetValue('BottomHeight',300);
//        cxSplitter.State:=TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridOTTable);
        ReadGridColumnsSettings(cxGridGoodsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe22OstatkiTovara.RefreshData;
begin
     inherited;
     IBCQueryExpenses.Refresh;
end;

procedure Tframe22OstatkiTovara.RefreshJurnal_Smart;
var n:integer;
begin
     n:=dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
     dmDB.IBCQueryJurnal.Refresh;
     dmDB.IBCQueryJurnal.Locate('GOODSID',n,[]);
end;

procedure Tframe22OstatkiTovara.GoodsSelectionChanged;
var fGoodsNew,fGoodsEdit,fGoodsDelete,fSNParts:Boolean;
    FLG_CLOSED:Boolean;
begin
     fGoodsNew:=False;
     fGoodsEdit:=False;
     fGoodsDelete:=False;
     fSNParts:=False;

     if (cxGridOTTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fGoodsNew:=Not FLG_CLOSED; // Produs nou + Security

          if (cxGridGoodsTable.DataController.RecNo>0) then
          begin
               fGoodsEdit:=Not FLG_CLOSED;   // Modifica marfa + Security
               fGoodsDelete:=Not FLG_CLOSED; // Sterge marfa + Security

               // Evidenta seriala, Evidenta pe partizi
               fSNParts:=(dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger=cSYSS_GOODS_SERIAL_TYPE_Серийный_учет)
                      or (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger=cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);
          end
     end;
     // goods
     bbAddGoods.Enabled:=fGoodsNew;
     bbModifyGoods.Enabled:=fGoodsEdit;
     bbDeleteGoods.Enabled:=fGoodsDelete;
     bbSerialNumbers.Enabled:=fSNParts;
end;

procedure Tframe22OstatkiTovara.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight',pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState',Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridOTTable);
        SaveGridColumnsSettings(cxGridGoodsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe22OstatkiTovara.SetupDefaultFocus;
begin
     // grid
     cxGridOT.SetFocus;
     // columns
     cxGridOT_DT_NAME.Focused:=True;
     cxGridDBCol_GOODS_NAME.Focused:=True;
end;

procedure Tframe22OstatkiTovara.SetuQtyFields;
begin
     // Cantitate
     TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat:=QtyDisplayFormat;
     cxGridDBCol_QTY.Summary.FooterFormat:=QtyDisplayFormat;
end;

procedure Tframe22OstatkiTovara.ShowAddExpenseDialog;
var dialog:TfrmNakladnaiaPNExpenseDlg;
begin
     dialog:=TfrmNakladnaiaPNExpenseDlg.Create(Self,IBCQueryExpenses,IBCDataSourceExpenses);
     try
        dialog.CreateNewExpense:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe22OstatkiTovara.ShowAddGoodsDialog;
var dialog:TfrmSelectGoodsToAddDlg;
begin
     dialog:=TfrmSelectGoodsToAddDlg.Create(Self,dmDB.IBCQueryJurnal,dmDB.IBCDataSourceJurnal);
     try
        dialog.AddNewGoods:=True;
        dialog.DefaultPriceColumn:=0;
        if dialog.ShowModal=mrOk then
        begin
             dmDB.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe22OstatkiTovara.ShowInputPartNumbersDialog(const ViewOnly: Boolean);
var dialog:TfrmPartNumbersDlg;
begin
     dialog:=TfrmPartNumbersDlg.Create(Self,dmDB.IBCQueryJurnal,dmDB.IBCDataSourceJurnal);
     try
        dialog.ReadOnly:=ViewOnly;
        dialog.NewPartNoTemplate:=CreatePartNoTemplate(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger,dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
        if dialog.ShowModal=mrOk then
        begin
             RefreshJurnal_Smart;
             //dmDB.IBCQueryJurnal.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe22OstatkiTovara.ShowInputSerialNumbersDialog(const ViewOnly: Boolean);
var dialog:TfrmSerialNumbersDlg;
begin
     dialog:=TfrmSerialNumbersDlg.Create(Self,dmDB.IBCQueryJurnal,dmDB.IBCDataSourceJurnal);
     try
        dialog.ReadOnly:=ViewOnly;
        if dialog.ShowModal=mrOk then
        begin
             RefreshJurnal_Smart;
             //dmDB.IBCQueryJurnal.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe22OstatkiTovara.ShowModifyExpenseDialog;
var dialog:TfrmNakladnaiaPNExpenseDlg;
begin
     dialog:=TfrmNakladnaiaPNExpenseDlg.Create(Self,IBCQueryExpenses,IBCDataSourceExpenses);
     try
        dialog.CreateNewExpense:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe22OstatkiTovara.ShowModifyGoodsDialog;
var dialog:TfrmSelectGoodsToAddDlg;
begin
     dialog:=TfrmSelectGoodsToAddDlg.Create(Self,dmDB.IBCQueryJurnal,dmDB.IBCDataSourceJurnal);
     try
        dialog.AddNewGoods:=False;
        dialog.DefaultPriceColumn:=0;
        if dialog.ShowModal=mrOk then
        begin
             dmDB.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe22OstatkiTovara.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     DocumentSelectionChanged;
end;

procedure Tframe22OstatkiTovara.WhenDocumentPopupMenuOpen;
var fActionOpenDoc,fActionCloseDoc,FLG_CLOSED,HAS_JURNAL_GOODS:Boolean;
begin
     fActionOpenDoc:=False;
     fActionCloseDoc:=False;

     if (cxGridOTTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
          HAS_JURNAL_GOODS:=dmDB.IBCQueryDocs.FieldByName('HAS_JURNAL_GOODS').AsInteger=1;

          fActionCloseDoc:=(Not FLG_CLOSED) and HAS_JURNAL_GOODS; // Inchide "Stoc marfa" + Security
          fActionOpenDoc:=FLG_CLOSED;        // Deschide "Stoc marfa" + Security
     end;
     // popup
     bbActionCloseDocument.Enabled:=fActionCloseDoc;
     bbActionOpenDocument.Enabled:=fActionOpenDoc;
end;

procedure Tframe22OstatkiTovara.WhenExpenseGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     ExpenseSelectionChanged;
end;

procedure Tframe22OstatkiTovara.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsSelectionChanged;
end;

end.
