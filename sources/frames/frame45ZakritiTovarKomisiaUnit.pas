unit frame45ZakritiTovarKomisiaUnit;
{
  КОМИСИЯ. Закрытие товара в комисию
  DocTypeID = 1506
  Frame Index = 45
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit,
  cxLabel, cxCheckBox, cxImageComboBox, dxBar, MemDS, DBAccess, IBC, dxBarExtItems, cxClasses, cxPC, ExtCtrls, cxSplitter, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxControls, cxGridCustomView, cxGrid,
  cxLookAndFeels, cxLookAndFeelPainters, cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator, cxCalc,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  Tframe45ZakritiTovarKomisia = class(TSWNBaseFrame)
    cxGridNPN: TcxGrid;
    cxGridNPNTable: TcxGridDBTableView;
    cxGridNPNTableDocID: TcxGridDBColumn;
    cxGridNPN_DATA: TcxGridDBColumn;
    cxGridNPN_DTDEP_NAME: TcxGridDBColumn;
    cxGridNPN_CT_NAME: TcxGridDBColumn;
    cxGridNPNTableSuma: TcxGridDBColumn;
    cxGridNPN_CURRENCY_NAME: TcxGridDBColumn;
    cxGridNPNTableVAT: TcxGridDBColumn;
    cxGridNPNTableRate: TcxGridDBColumn;
    cxGridNPNTableParentDocID: TcxGridDBColumn;
    cxGridNPNTable_FLG_ACNT: TcxGridDBColumn;
    cxGridNPN_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridNPNLevel: TcxGridLevel;
    cxSplitter: TcxSplitter;
    pnBottom: TPanel;
    dxBarManager: TdxBarManager;
    bbNewGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbRemoveGoods: TdxBarButton;
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
    cxGridLevel: TcxGridLevel;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    pmPopupMenuDocs: TdxBarPopupMenu;
    dxBarManagerBar2: TdxBar;
    dxBarDockControl2: TdxBarDockControl;
    cxGridNPNTable_CUSTOMER_TYPE_ID: TcxGridDBColumn;
    cxGridNPN_CREATED_DATE: TcxGridDBColumn;
    cxGridNPN_RATEUSD: TcxGridDBColumn;
    cxGridPopupMenuNPN: TcxGridPopupMenu;
    cxGridNPN_CT: TcxGridDBColumn;
    cxGridNPN_DT: TcxGridDBColumn;
    cxGridNPN_FLG_CLOSED: TcxGridDBColumn;
    bbDocClose: TdxBarButton;
    bbDocOpen: TdxBarButton;
    bbImportGoods: TdxBarButton;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    bbCustomerDebts: TdxBarButton;
    dxBarButton1: TdxBarButton;
    procedure cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure bbNewGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbRemoveGoodsClick(Sender: TObject);
    procedure cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbDocCloseClick(Sender: TObject);
    procedure bbDocOpenClick(Sender: TObject);
    procedure bbImportGoodsClick(Sender: TObject);
    procedure cxGridNPN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fSYS_CreateDoc,fSYS_EditDoc,fSYS_DeleteDoc,fSYS_ViewDoc:Boolean;

    procedure WhenDocumentGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;

    procedure WhenGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;

    procedure ShowAddNewGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure ShowRemoveGoodsDialog;

    function WhenCheckIfGoodsExists(const GoodsID:integer):Boolean;

    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID:integer):Boolean;
    procedure DoOpenDocument;
    function DoOpenDocumentDB(const DocID:integer):Boolean;

    procedure ShowImportGoodsDialog;

    procedure SetupQtyFields;

  protected
    { Protected declarations }
    function InitFrameID:integer;override;

    function GetExternalDataSourceTypes:TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;

    procedure CreateNewRecord;override;
    procedure ModifyRecord;override;
    procedure DeleteRecord;override;

    procedure ReadFrameStates;override;
    procedure SaveFrameStates;override;

    function GetFrameButtons:TFrameButtons;override;
    function GetFilterFields:TFrameFilterFields;override;
    procedure ReturnGoodsToSupplier(DocID: Integer);

    procedure SetupSecurityItems;override;
  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;


implementation

uses
  DataModuleAdditions, IBCError, DataModuleDB, SWNUtils, SWNConst, SWNTypes, DateUtils,
  frmSelectGoodsToAddDialog, SWNValueStorageUnit, SWNDBErrors, SWNSecurity, frmZakritiTovarKomisiaDocDialog,
  SWNSecurityFlags, frmZTK_ImportGoodsDialog;

{$R *.dfm}

{ Tframe10NakladnieRN }

procedure Tframe45ZakritiTovarKomisia.bbCustomerDebtsClick(Sender: TObject);
begin
     dmDB.ShowCustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe45ZakritiTovarKomisia.bbDocCloseClick(Sender: TObject);
begin
     DoCloseDocument;
end;

procedure Tframe45ZakritiTovarKomisia.bbDocOpenClick(Sender: TObject);
begin
     DoOpenDocument;
end;

procedure Tframe45ZakritiTovarKomisia.bbImportGoodsClick(Sender: TObject);
begin
     ShowImportGoodsDialog;
end;

procedure Tframe45ZakritiTovarKomisia.bbModifyGoodsClick(Sender: TObject);
begin
     ShowModifyGoodsDialog;
end;

procedure Tframe45ZakritiTovarKomisia.bbNewGoodsClick(Sender: TObject);
begin
     ShowAddNewGoodsDialog;
end;

procedure Tframe45ZakritiTovarKomisia.bbRemoveGoodsClick(Sender: TObject);
begin
     ShowRemoveGoodsDialog;
end;

procedure Tframe45ZakritiTovarKomisia.CreateNewRecord;
var dialog:TfrmZakritiTovarKomisiaDlg;
begin
     dialog:=TfrmZakritiTovarKomisiaDlg.Create(self);
     try
        dialog.CreateNewDocument:=True;
        if dialog.ShowModal=mrOk then
        begin
             DocumentSelectionChanged;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe45ZakritiTovarKomisia.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if bbModifyGoods.Enabled then
     begin
          ShowModifyGoodsDialog;
          AHandled:=True;
     end;
end;

procedure Tframe45ZakritiTovarKomisia.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe45ZakritiTovarKomisia.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(Self, cxGridComponentsTable,Key,Shift);
end;

procedure Tframe45ZakritiTovarKomisia.cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if ARecord.Values[cxGridDBCol_STOCK_QTY.Index]<0 then AStyle:=dmAdditions.cxStyle_GoodsOutOfStock;
end;

procedure Tframe45ZakritiTovarKomisia.cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if AButton=mbLeft then
     begin
          DoDocumentDoubleClick;
          AHandled:=True;
     end;
end;

procedure Tframe45ZakritiTovarKomisia.cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridNPN_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridNPN_FLG_CLOSED.index]=0 then
          begin
               if Not AViewInfo.Selected then
               begin
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
               end;
          end
          else
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    if AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
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

procedure Tframe45ZakritiTovarKomisia.cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(Self, cxGridNPNTable,Key,Shift);
end;

procedure Tframe45ZakritiTovarKomisia.cxGridNPN_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridNPN_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridNPN_DATA.Index]);
end;

procedure Tframe45ZakritiTovarKomisia.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format('Удалить запись номер %d?',[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))=mrYes then
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

procedure Tframe45ZakritiTovarKomisia.DoCloseDocument;
begin
     if ShowAskDialog('Закрыть документ','Вы хотите закрыть документ?')=mrYes then
     begin
          if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger)
            then dmDB.IBCQueryDocs.Refresh;
     end;
end;

function Tframe45ZakritiTovarKomisia.DoCloseDocumentDB(const DocID: integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_CLOSE_ZAKRITNAKOMISIA(:DOCID)';
        Query.ParamByName('DOCID').AsInteger:=DocID;
        Query.Transaction.StartTransaction;
        try
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

procedure Tframe45ZakritiTovarKomisia.DocumentSelectionChanged;
var fDocNew,fDocEdit,fDocDelete:Boolean;
    FLG_CLOSED:Boolean;
    fClose,fOpen,fDebts:Boolean;
begin
     fDocNew:=fSYS_CreateDoc;      // New Doc + Security
     fDocEdit:=False;
     fDocDelete:=False;

     fClose:=False;
     fOpen:=False;
     fDebts:=False;

     if (cxGridNPNTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fDocEdit:=fSYS_EditDoc and Not FLG_CLOSED or fSYS_ViewDoc;
          fDocDelete:=fSYS_DeleteDoc and Not FLG_CLOSED;

          fClose:=Not FLG_CLOSED;
          fOpen:=FLG_CLOSED;

          fDebts:=True;
     end;

     // doc
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);

     // popup docs
     bbDocClose.Enabled:=fClose;
     bbDocOpen.Enabled:=fOpen;
     bbCustomerDebts.Enabled:=fDebts;

     SelectionChanged;
end;

procedure Tframe45ZakritiTovarKomisia.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridNPNTable.OnFocusedRecordChanged:=nil;
     cxGridComponentsTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridNPNTable.DataController.DataSource:=nil;
     cxGridComponentsTable.DataController.DataSource:=nil;

     inherited;
end;

procedure Tframe45ZakritiTovarKomisia.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridNPNTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;
     cxGridComponentsTable.DataController.DataSource:=dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
     cxGridNPNTable.OnFocusedRecordChanged:=WhenDocumentGrid_FocusedRecordChanged;
     cxGridComponentsTable.OnFocusedRecordChanged:=WhenGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
     DocumentSelectionChanged;
end;

procedure Tframe45ZakritiTovarKomisia.DoOpenDocument;
begin
     if ShowAskDialog('Открыть документ','Вы хотите открыть документ?')=mrYes then
     begin
          if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger)
            then dmDB.IBCQueryDocs.Refresh;
     end;
end;

function Tframe45ZakritiTovarKomisia.DoOpenDocumentDB(const DocID: integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_OPEN_ZAKRITNAKOMISIA(:DOCID)';
        Query.ParamByName('DOCID').AsInteger:=DocID;
        Query.Transaction.StartTransaction;
        try
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

procedure Tframe45ZakritiTovarKomisia.dxBarButton1Click(Sender: TObject);
begin
  ReturnGoodsToSupplier(dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

function Tframe45ZakritiTovarKomisia.GetCurrentSearchContext: TSearchContextValue;
begin
     Result := Inherited;

     if cxGridComponentsTable.Site.Focused then
     begin
          // context from Jurnal: Код + Наименование
          Result.Context := ffGoods;
          Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
          Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
     end
     else
         if cxGridNPNTable.Site.Focused then
         begin
              // context from Docs
              if cxGridNPN_CT_NAME.Focused then
              begin
                   // Контрагент
                   Result.Context := ffCustomer;
                   Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
                   Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
              end
              else
                  if cxGridNPN_DATA.Focused then
                  begin
                       // Дата
                       Result.Context := ffDate;
                       Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
                  end
                  else
                      if cxGridNPN_DTDEP_NAME.Focused then
                      begin
                           // Склад
                           Result.Context := ffStock;
                           Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
                           Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
                      end;
         end
end;

function Tframe45ZakritiTovarKomisia.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs,fedsJurnal];
end;

function Tframe45ZakritiTovarKomisia.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffCustomer,ffGoods,ffStock,ffGoodsFolders,ffAcntGoods];
end;

function Tframe45ZakritiTovarKomisia.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSYS_CreateDoc then Result:=Result+[fbtADD];
     if fSYS_EditDoc or fSYS_ViewDoc then Result:=Result+[fbtMODIFY];
     if fSYS_DeleteDoc then Result:=Result+[fbtDELETE];
end;

function Tframe45ZakritiTovarKomisia.InitFrameID: integer;
begin
     Result := 45; // КОМИСИЯ. Закрытие товара в комисию
     SetupQtyFields;
     dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
end;

procedure Tframe45ZakritiTovarKomisia.ModifyRecord;
var dialog:TfrmZakritiTovarKomisiaDlg;
    ReadOnly:Boolean;
begin
     if Not (fSYS_EditDoc or fSYS_ViewDoc) then Exit;

     if fSYS_EditDoc
       then ReadOnly:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1
       else ReadOnly:=fSYS_ViewDoc;

     dialog:=TfrmZakritiTovarKomisiaDlg.Create(self);
     try
        dialog.CreateNewDocument:=False;
        dialog.ReadOnly:=ReadOnly;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe45ZakritiTovarKomisia.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        pnBottom.Height:=AppUserConfigStorage.IntValues.GetValue('BottomHeight',300);
//        cxSplitter.State:=TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridNPNTable);
        ReadGridColumnsSettings(cxGridComponentsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe45ZakritiTovarKomisia.ReturnGoodsToSupplier(DocID: Integer);
begin
  dmdb.ExecuteQuery('EXECUTE PROCEDURE SP_RETURN_GOODS_TO_SUPPLIER(:DOCID)',[DocID]);

end;

procedure Tframe45ZakritiTovarKomisia.ShowAddNewGoodsDialog;
var dialog:TfrmSelectGoodsToAddDlg;
begin
     dialog:=TfrmSelectGoodsToAddDlg.Create(self,dmDB.IBCQueryJurnal,dmDB.IBCDataSourceJurnal,-1);
     try
        dialog.OnVerifyGoodsExists:=WhenCheckIfGoodsExists;
        dialog.AllowedActions:=dialog.AllowedActions+[acChangePrice]-[acChangeACNT,acChangeActive];
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


procedure Tframe45ZakritiTovarKomisia.ShowImportGoodsDialog;
var dialog:TfrmZTKImportGoodsDlg;
begin
     dialog:=TfrmZTKImportGoodsDlg.Create(Self);
     try
        dialog.DocID:=dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        dialog.SetVendorInfo(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString);
        if dialog.ShowModal=mrOK then
        begin
             dmDB.FullRefresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe45ZakritiTovarKomisia.ShowModifyGoodsDialog;
var dialog:TfrmSelectGoodsToAddDlg;
begin
     dialog:=TfrmSelectGoodsToAddDlg.Create(self,dmDB.IBCQueryJurnal,dmDB.IBCDataSourceJurnal,-1);
     try
        dialog.OnVerifyGoodsExists:=WhenCheckIfGoodsExists;
        dialog.AddNewGoods:=False;
        dialog.AllowedActions:=dialog.AllowedActions+[acChangePrice]-[acChangeACNT,acChangeActive];
        dialog.DefaultPriceColumn:=0; // dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;

        if dialog.ShowModal=mrOk then
        begin
             dmdb.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe45ZakritiTovarKomisia.ShowRemoveGoodsDialog;
var S:String;
    flag:Boolean;
begin
     flag:=AppUserConfigStorage.Confirmations.GetValue('ASK_GoodsDelete');
     if Not flag then
     begin
          S:=Format(cMSG_DELETERECORD_РасходнаяНакладная,[dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').asString]);
          // confirmation
          if ShowAskDialogVerification(cMSG_DELETERECORD_DeleteGoods,S,cMSG_CONFIRMATION_DoNotAskAgain,'',flag)<>mrYes then Exit;
          AppUserConfigStorage.Confirmations.SetValue('ASK_GoodsDelete',flag);
     end;

     dmDB.IBCQueryJurnal.UpdateTransaction.StartTransaction;
     try
        dmDB.IBCQueryJurnal.Delete;
        dmDB.IBCQueryJurnal.UpdateTransaction.Commit;
        dmdb.IBCQueryDocs.Refresh;
     except on E:Exception do
        begin
             dmDB.IBCQueryJurnal.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

function Tframe45ZakritiTovarKomisia.WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
var i:integer;
begin
     Result:=False;
     for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
     begin
          if cxGridComponentsTable.DataController.Values[i,cxGridDBCol_GOODSID.Index]=GoodsID then
          begin
               Result:=True;
               Break;
          end;
     end;
end;

procedure Tframe45ZakritiTovarKomisia.WhenDocumentGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     DocumentSelectionChanged;
end;

procedure Tframe45ZakritiTovarKomisia.WhenGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure Tframe45ZakritiTovarKomisia.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight',pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState',Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridNPNTable);
        SaveGridColumnsSettings(cxGridComponentsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe45ZakritiTovarKomisia.SelectionChanged;
var fGoodsAdd,fGoodsEdit,fGoodsDelete:boolean;
    FLG_CLOSED:Boolean;
begin
     // goods
     fGoodsAdd:=False;
     fGoodsEdit:=false;
     fGoodsDelete:=false;

     if (cxGridNPNTable.DataController.RecNo>0) and (cxGridNPNTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fGoodsAdd:=fSYS_EditDoc and Not FLG_CLOSED;

          if (cxGridComponentsTable.DataController.RecNo>0) then
          begin
               fGoodsEdit:=fSYS_EditDoc and (Not FLG_CLOSED);
               fGoodsDelete:=fSYS_EditDoc and (Not FLG_CLOSED);
          end;
     end;
     // goods
     bbNewGoods.Enabled:=fGoodsAdd;
     bbModifyGoods.Enabled:=fGoodsEdit;
     bbRemoveGoods.Enabled:=fGoodsDelete;
     bbImportGoods.Enabled:=fGoodsAdd;
end;


procedure Tframe45ZakritiTovarKomisia.SetupDefaultFocus;
begin
     // set focus to Doc Grid
     cxGridNPN.SetFocus;
     // set focused column
     cxGridNPN_CT_NAME.Focused:=True;
     cxGridDBCol_GOODS_NAME.Focused:=True;
end;

procedure Tframe45ZakritiTovarKomisia.SetupQtyFields;
begin
     // Кол-во
     TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat:=QtyDisplayFormat;
     cxGridDBCol_QTY.Summary.FooterFormat:=QtyDisplayFormat;
end;

procedure Tframe45ZakritiTovarKomisia.SetupSecurityItems;
begin
     fSYS_CreateDoc:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОМИСИЯ_ЗТВК_Создать);
     fSYS_EditDoc:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОМИСИЯ_ЗТВК_Редактировать);
     fSYS_DeleteDoc:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОМИСИЯ_ЗТВК_Удалить);
     fSYS_ViewDoc:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОМИСИЯ_ЗТВК_Просмотр_документа);

     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОМИСИЯ_ЗТВК_Закрыть_документ) then bbDocClose.Visible:=ivNever;
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОМИСИЯ_ЗТВК_Открыть_закрытый_документ) then bbDocOpen.Visible:=ivNever;

     if pmPopupMenuDocs.ItemLinks.VisibleItemCount=0 then cxGridPopupMenuNPN.PopupMenus[0].PopupMenu:=nil;

     if SWNSecurityManager.IsPartialAccessMode then
     begin
          bbCustomerDebts.Visible := ivNever;
     end;
end;

end.
