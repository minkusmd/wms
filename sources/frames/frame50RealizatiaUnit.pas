unit frame50RealizatiaUnit;
{
  COMISION. Primire in bilant din comision
  DocTypeID = 1757
  Frame Index = 50
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SYSTEM.UITypes, Dialogs,
  SWNDataFiltering, SWNDocumentFilters, SWNBaseFrameUnit,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit,
  cxLabel, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxControls, cxGridCustomView,
  cxGrid, StdCtrls, ExtCtrls, cxLookAndFeels, cxLookAndFeelPainters, dxBar, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxSplitter, DBAccess, IBC, MemDS, cxImageComboBox, cxNavigator, cxCalc,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  Tframe50Realizatia = class(TSWNBaseFrame)
    cxGridRealizatiaTable: TcxGridDBTableView;
    cxGridRealizatiaLevel: TcxGridLevel;
    cxGridRealizatia: TcxGrid;
    cxGridRealizatia_DOCID: TcxGridDBColumn;
    cxGridRealizatia_DATA: TcxGridDBColumn;
    cxGridRealizatia_CT_NAME: TcxGridDBColumn;
    cxGridRealizatia_SUMA: TcxGridDBColumn;
    cxGridRealizatia_VAT: TcxGridDBColumn;
    cxGridRealizatia_CURRENCY_NAME: TcxGridDBColumn;
    cxGridRealizatia_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridRealizatia_RATE: TcxGridDBColumn;
    cxGridRealizatia_FLG_ACNT: TcxGridDBColumn;
    dxBarManager: TdxBarManager;
    pmRealizatia: TdxBarPopupMenu;
    cxGridRealizatia_RATEUSD: TcxGridDBColumn;
    cxGridRealizatia_CT: TcxGridDBColumn;
    cxGridPopupMenuDoc: TcxGridPopupMenu;
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    dxBarDockControl1: TdxBarDockControl;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    dxBarGoods: TdxBar;
    bbGoodsAdd: TdxBarButton;
    bbGoodsEdit: TdxBarButton;
    bbGoodsRemove: TdxBarButton;
    bbGoodsSerials: TdxBarButton;
    IBCQueryJurnalR: TIBCQuery;
    IBCDataSourceJurnalR: TIBCDataSource;
    cxGridGoods_GOODSID: TcxGridDBColumn;
    cxGridGoods_GOODS_TITLE: TcxGridDBColumn;
    cxGridGoods_FLG_READY: TcxGridDBColumn;
    cxGridGoods_IMG: TcxGridDBColumn;
    cxGridGoods_QTY: TcxGridDBColumn;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    cxGridRealizatia_FLG_CLOSED: TcxGridDBColumn;
    cxGridGoods_PRICE: TcxGridDBColumn;
    cxGridGoods_SUMA: TcxGridDBColumn;
    bbDocComments: TdxBarButton;
    cxGridGoods_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridGoods_GOODS_NAMEACNT: TcxGridDBColumn;
    bbCustomerDebts: TdxBarButton;
    procedure cxGridRealizatiaTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridRealizatiaTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGoodsAddClick(Sender: TObject);
    procedure bbGoodsEditClick(Sender: TObject);
    procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGoodsRemoveClick(Sender: TObject);
    procedure cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure bbGoodsSerialsClick(Sender: TObject);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure cxGridRealizatiaTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridRealizatia_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbCustomerDebtsClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView,fSECURITY_CanNew,fSECURITY_CanEdit,fSECURITY_CanDelete:Boolean;

    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;

    procedure WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;

    procedure ShowAddGoodsDialog;
    function WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;
    procedure ShowSelectGoodsSerialNumbersDialog(const ReadOnly:Boolean);
    procedure ShowSelectGoodsPartNumbersDialog(const ReadOnly:Boolean);

    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID:integer):Boolean;
    procedure DoOpenDocument;
    function DoOpenDocumentDB(const DocID:integer):Boolean;

    procedure SmartRefreshJurnalR;

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

    procedure ReadFrameStates;override;
    procedure SaveFrameStates;override;

    procedure SetupSecurityItems;override;

  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, DateUtils, SWNValueStorageUnit,
  SWNSecurity, SWNSecurityFlags, frmRealizatiaDocDialog, frmRealizatiaGoodsToAddDialog, SWNTypes,
  frmRealizareaSelectSNDialog, frmRealizareaSelectPartNumbersDialog;

{$R *.dfm}

{ TSWNBaseFrame1 }

procedure Tframe50Realizatia.bbCloseDocClick(Sender: TObject);
begin
     DoCloseDocument;
end;

procedure Tframe50Realizatia.bbCustomerDebtsClick(Sender: TObject);
begin
     dmDB.ShowCustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe50Realizatia.bbDocCommentsClick(Sender: TObject);
begin
     ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe50Realizatia.bbGoodsAddClick(Sender: TObject);
begin
     ShowAddGoodsDialog;
end;

procedure Tframe50Realizatia.bbGoodsEditClick(Sender: TObject);
begin
     ShowModifyGoodsDialog;
end;

procedure Tframe50Realizatia.bbGoodsRemoveClick(Sender: TObject);
begin
     DeleteSelectedGoods;
end;

procedure Tframe50Realizatia.bbGoodsSerialsClick(Sender: TObject);
var SerialType:Integer;
    FLG_CLOSED:Boolean;
begin
     FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
     SerialType:=IBCQueryJurnalR.FieldByName('GOODS_SERIAL_TYPE_ID').asInteger;

     // Evidenta seriala
     if SerialType = cSYSS_GOODS_SERIAL_TYPE_Ñåðèéíûé_ó÷åò then ShowSelectGoodsSerialNumbersDialog(FLG_CLOSED)
     else
     // Evidenta pe partizi
     if SerialType = cSYSS_GOODS_SERIAL_TYPE_Ïàðòèéíûé_ó÷åò then ShowSelectGoodsPartNumbersDialog(FLG_CLOSED);
end;

procedure Tframe50Realizatia.bbOpenDocClick(Sender: TObject);
begin
     DoOpenDocument;
end;

procedure Tframe50Realizatia.CreateNewRecord;
var dialog:TfrmRealizatiaDocDlg;
begin
     dialog:=TfrmRealizatiaDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe50Realizatia.cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if bbGoodsEdit.Enabled then
     begin
          bbGoodsEditClick(bbGoodsEdit);
          AHandled:=True;
     end;
end;

procedure Tframe50Realizatia.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe50Realizatia.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(Self, cxGridGoodsTable,Key,Shift);
end;

procedure Tframe50Realizatia.cxGridRealizatiaTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if AButton=mbLeft then
     begin
          DoDocumentDoubleClick;
          AHandled:=True;
     end;
end;

procedure Tframe50Realizatia.cxGridRealizatiaTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridRealizatia_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridRealizatia_FLG_CLOSED.index]=0 then
          begin
               if Not AViewInfo.Selected then
               begin
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGridRealizatia_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
               end;
          end
          else
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    if AViewInfo.GridRecord.Values[cxGridRealizatia_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
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

procedure Tframe50Realizatia.cxGridRealizatiaTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(Self, cxGridRealizatiaTable,Key,Shift);
end;

procedure Tframe50Realizatia.cxGridRealizatia_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridRealizatia_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridRealizatia_DATA.Index]);
end;

procedure Tframe50Realizatia.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format(cMSG_DELETERECORD_50,[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))=mrYes then
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

procedure Tframe50Realizatia.DeleteSelectedGoods;
var S:String;
begin
     S:=Format('Sterge "%s"?',[IBCQueryJurnalR.FieldByName('GOODS_TITLE').asString]);
     if ShowAskDialog(cMSG_DELETERECORD_DeleteGoods,S)<>mrYes then Exit;

     IBCQueryJurnalR.UpdateTransaction.StartTransaction;
     try
        IBCQueryJurnalR.Delete;
        IBCQueryJurnalR.UpdateTransaction.Commit;
        dmDB.IBCQueryDocs.Refresh;
     except on E:Exception do
        begin
             IBCQueryJurnalR.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure Tframe50Realizatia.DoCloseDocument;
begin
     if ShowAskDialog('Inchide documentul','Doriti sa inchideti documentul?')=mrYes then
     begin
          if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then dmDB.RefreshDocs;
     end;
end;

function Tframe50Realizatia.DoCloseDocumentDB(const DocID: integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_CLOSE_REALIZAREA(:DOCID)';
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

procedure Tframe50Realizatia.DoFrameHide;
begin
     // inchidem datele interne
     IBCQueryJurnalR.Close;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridRealizatiaTable.DataController.DataSource:=nil;
     cxGridGoodsTable.DataController.DataSource:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridGoodsTable.OnFocusedRecordChanged:=nil;
     cxGridRealizatiaTable.OnFocusedRecordChanged:=nil;

     inherited;
end;

procedure Tframe50Realizatia.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridRealizatiaTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;
     cxGridGoodsTable.DataController.DataSource:=IBCDataSourceJurnalR;

     // 2. Selection handlers
     cxGridRealizatiaTable.OnFocusedRecordChanged:=WhenGridFocusedRecordChanged;
     cxGridGoodsTable.OnFocusedRecordChanged:=WhenGoodsGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
     IBCQueryJurnalR.Active:=True;

     // 4. Selection update
     SelectionChanged;
end;

function Tframe50Realizatia.DoOpenDocumentDB(const DocID: integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_OPEN_REALIZAREA(:DOCID)';
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

procedure Tframe50Realizatia.DoOpenDocument;
begin
     if ShowAskDialog('Deschide documentul','Doriti sa deschideti documentul?')=mrYes then
     begin
          if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then dmDB.RefreshDocs;
     end;
end;

function Tframe50Realizatia.GetCurrentSearchContext: TSearchContextValue;
begin
     Result := Inherited;

     if cxGridRealizatiaTable.Site.Focused then
     begin
          // context from Docs
          if cxGridRealizatia_CT_NAME.Focused then
          begin
               // Contraagent
               Result.Context := ffCustomer;
               Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
               Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
          end
          else
              if cxGridRealizatia_DATA.Focused then
              begin
                   // Data
                   Result.Context := ffDate;
                   Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
              end
     end
end;

function Tframe50Realizatia.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe50Realizatia.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffCustomer,ffGoods];
     // !!!
     // ffGoodsFolders, ffAcntGoods
     // produsele se afla in alt jurnal -> nu putem aplica aceste filtre
end;

function Tframe50Realizatia.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_CanNew then Result:=Result+[fbtADD];
     if fSECURITY_CanEdit or fSECURITY_CanView then Result:=Result+[fbtMODIFY];
     if fSECURITY_CanDelete then Result:=Result+[fbtDELETE];
end;

procedure Tframe50Realizatia.GoodsSelectionChanged;
var fAdd,fEdit,fDelete,fSN:Boolean;
    SerialType:Integer;
    FLG_CLOSED:Boolean;
begin
     fAdd:=False;
     fEdit:=False;
     fDelete:=False;
     fSN:=False;

     if cxGridRealizatiaTable.DataController.RecNo>0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fAdd:=Not FLG_CLOSED and fSECURITY_CanEdit;

          if (cxGridGoodsTable.DataController.RecNo>0) then
          begin
               SerialType:=IBCQueryJurnalR.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;

               fEdit:=fSECURITY_CanEdit and Not FLG_CLOSED;
               fDelete:=fSECURITY_CanEdit and Not FLG_CLOSED;
               fSN:=(SerialType=cSYSS_GOODS_SERIAL_TYPE_Ñåðèéíûé_ó÷åò) Or (SerialType=cSYSS_GOODS_SERIAL_TYPE_Ïàðòèéíûé_ó÷åò);
          end;
     end;

     bbGoodsAdd.Enabled:=fAdd;
     bbGoodsEdit.Enabled:=fEdit;
     bbGoodsRemove.Enabled:=fDelete;
     bbGoodsSerials.Enabled:=fSN;
end;

function Tframe50Realizatia.InitFrameID: integer;
begin
     // Primire in bilant din comision
     Result:=50;
     SetupQtyFields;
     dmDB.CreateGridImageColumnItems(cxGridGoods_IMG);
end;

procedure Tframe50Realizatia.ModifyRecord;
var dialog:TfrmRealizatiaDocDlg;
    ReadOnly:Boolean;
begin
     if Not (fSECURITY_CanEdit or fSECURITY_CanView) then Exit;

     if fSECURITY_CanEdit
       then ReadOnly:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1
       else ReadOnly:=fSECURITY_CanView;

     dialog:=TfrmRealizatiaDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=False;
        dialog.ReadOnly:=ReadOnly;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe50Realizatia.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//        cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridRealizatiaTable);
        ReadGridColumnsSettings(cxGridGoodsTable);
     finally
       AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe50Realizatia.RefreshData;
begin
     inherited;
     IBCQueryJurnalR.Refresh;
end;

procedure Tframe50Realizatia.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridRealizatiaTable);
        SaveGridColumnsSettings(cxGridGoodsTable);
     finally
       AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe50Realizatia.SelectionChanged;
var fDocNew,fDocEdit,fDocDelete:Boolean;
    FLG_CLOSED:Boolean;
    fClose,fOpen,fDebts:Boolean;
begin
     fDocNew:=fSECURITY_CanNew; // New document
     fDocEdit:=False;
     fDocDelete:=False;

     fClose:=False;
     fOpen:=False;
     fDebts:=False;

     if cxGridRealizatiaTable.DataController.RecNo>0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fDocEdit:=(not FLG_CLOSED and fSECURITY_CanEdit) or fSECURITY_CanView;   // Edit document
          fDocDelete:=not FLG_CLOSED and fSECURITY_CanDelete; // Delete document

          fClose:=Not FLG_CLOSED;
          fOpen:=FLG_CLOSED;

          fDebts:=True;
     end;
     // doc
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);

     // popup
     bbCloseDoc.Enabled:=fClose;
     bbOpenDoc.Enabled:=fOpen;
     bbDocComments.Enabled:=fSECURITY_CanEdit;
     bbCustomerDebts.Enabled:=fDebts;

     GoodsSelectionChanged;
end;

procedure Tframe50Realizatia.SetupDefaultFocus;
begin
     // set focus to Doc Grid
     cxGridRealizatia.SetFocus;
     cxGridRealizatia_CT_NAME.Focused:=True;
     cxGridGoods_GOODS_TITLE.Focused:=True;
end;


procedure Tframe50Realizatia.SetupQtyFields;
begin
     // Cantitate
     TcxCalcEditProperties(cxGridGoods_QTY.Properties).DisplayFormat:=QtyDisplayFormat;
     cxGridGoods_QTY.Summary.FooterFormat:=QtyDisplayFormat;
end;

procedure Tframe50Realizatia.SetupSecurityItems;
begin
     fSECURITY_CanView:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÊÎÌÈÑÈß_ÏÂÁÑÊ_Ïðîñìîòð);
     fSECURITY_CanNew:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÊÎÌÈÑÈß_ÏÂÁÑÊ_Ñîçäàòü);
     fSECURITY_CanEdit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÊÎÌÈÑÈß_ÏÂÁÑÊ_Èçìåíèòü);
     fSECURITY_CanDelete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÊÎÌÈÑÈß_ÏÂÁÑÊ_Óäàëèòü);

     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÊÎÌÈÑÈß_ÏÂÁÑÊ_Çàêðûòü_äîêóìåíò) then bbCloseDoc.Visible:=ivNever;
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÊÎÌÈÑÈß_ÏÂÁÑÊ_Îòêðûòü_äîêóìåíò) then bbCloseDoc.Visible:=ivNever;

end;

procedure Tframe50Realizatia.ShowAddGoodsDialog;
var dialog:TfrmRealizatiaGoodsToAddDlg;
begin
     dialog:=TfrmRealizatiaGoodsToAddDlg.Create(Self,IBCQueryJurnalR,IBCDataSourceJurnalR);
     try
        dialog.AddNewGoods:=True;
        dialog.OnVerifyGoodsExists:=WhenCheckIfGoodsExists;
        if dialog.ShowModal=mrOk then
        begin
             dmDB.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe50Realizatia.ShowModifyGoodsDialog;
var dialog:TfrmRealizatiaGoodsToAddDlg;
begin
     dialog:=TfrmRealizatiaGoodsToAddDlg.Create(Self,IBCQueryJurnalR,IBCDataSourceJurnalR);
     try
        dialog.AddNewGoods:=False;
        dialog.OnVerifyGoodsExists:=WhenCheckIfGoodsExists;
        if dialog.ShowModal=mrOk then
        begin
             dmDB.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe50Realizatia.ShowSelectGoodsPartNumbersDialog(const ReadOnly: Boolean);
var dialog:TfrmRealizareaSelectPartNumbersDlg;
begin
     dialog:=TfrmRealizareaSelectPartNumbersDlg.Create(Self,IBCQueryJurnalR,IBCDataSourceJurnalR);
     try
        dialog.ReadOnly:=ReadOnly;
        dialog.DocsDataSet:=dmDB.IBCQueryDocs;
        if dialog.ShowModal=mrOk then SmartRefreshJurnalR;
     finally
        dialog.Free;
     end;
end;

procedure Tframe50Realizatia.ShowSelectGoodsSerialNumbersDialog(const ReadOnly: Boolean);
var dialog:TfrmRealizareaSelectSNDlg;
begin
     dialog:=TfrmRealizareaSelectSNDlg.Create(Self,IBCQueryJurnalR,IBCDataSourceJurnalR);
     try
        dialog.ReadOnly:=ReadOnly;
        dialog.DocsDataSet:=dmDB.IBCQueryDocs;
        if dialog.ShowModal=mrOk then SmartRefreshJurnalR;
     finally
        dialog.Free;
     end;
end;

procedure Tframe50Realizatia.SmartRefreshJurnalR;
var GoodsID:integer;
begin
     IBCQueryJurnalR.DisableControls;
     try
        GoodsID:=IBCQueryJurnalR.FieldByName('GOODSID').AsInteger;
        IBCQueryJurnalR.Refresh;
        IBCQueryJurnalR.Locate('GOODSID',GoodsID,[]);
     finally
        IBCQueryJurnalR.EnableControls;
     end;
end;

function Tframe50Realizatia.WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
var i:integer;
begin
     Result:=False;
     for i := 0 to cxGridGoodsTable.DataController.RecordCount - 1 do
     if cxGridGoodsTable.DataController.Values[i,cxGridGoods_GOODSID.Index]=GoodsID then
     begin
          Result:=True;
          Break;
     end;
end;

procedure Tframe50Realizatia.WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsSelectionChanged;
end;

procedure Tframe50Realizatia.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;


end.
