unit frame41AktOprihodPoNakladnim;
{
  ÈÍÂÅÍÒÀÐÈÇÀÖÈß. Àêò îïðèõîäîâàíèÿ ïî íàêëàäíûì
  DocTypeID = 1421
  Frame Index = 41
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit,
  cxLabel, cxCheckBox, cxImageComboBox, dxBar, cxClasses, cxSplitter, ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxControls, cxGridCustomView, cxGrid, cxLookAndFeels, cxLookAndFeelPainters,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator, cxCalc, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  Tframe41AktOprihodPoNakladnim = class(TSWNBaseFrame)
    cxGridPTN: TcxGrid;
    cxGridPTNTable: TcxGridDBTableView;
    cxGridPTN_DOCID: TcxGridDBColumn;
    cxGridPTN_DATA: TcxGridDBColumn;
    cxGridPTN_DTDEP_NAME: TcxGridDBColumn;
    cxGridPTN_CT_NAME: TcxGridDBColumn;
    cxGridPTN_SUMA: TcxGridDBColumn;
    cxGridPTN_CURRENCY_NAME: TcxGridDBColumn;
    cxGridPTN_VAT: TcxGridDBColumn;
    cxGridPTN_FLG_ACNT: TcxGridDBColumn;
    cxGridPTN_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridPTNLevel: TcxGridLevel;
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbAddGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbDeleteGoods: TdxBarButton;
    dxPopupMenu: TdxBarPopupMenu;
    dxBarDockControl1: TdxBarDockControl;
    cxGridComponents: TcxGrid;
    cxGridComponentsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    bbActionCloseDoc: TdxBarButton;
    bbActionOpenDoc: TdxBarButton;
    cxGridPTN_FLG_CLOSED: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    bbImport: TdxBarButton;
    cxGridPopupMenu1: TcxGridPopupMenu;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridComponents_UMID: TcxGridDBColumn;
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbDeleteGoodsClick(Sender: TObject);
    procedure bbActionCloseDocClick(Sender: TObject);
    procedure bbActionOpenDocClick(Sender: TObject);
    procedure cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridPTNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbImportClick(Sender: TObject);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
    fSECURITY_New,fSECURITY_View,fSECURITY_Edit,fSECURITY_Delete:Boolean;
    procedure WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocSelectionChanged;

    procedure WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;

    procedure ShowAddNewGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;

    function DoActionCloseDocument(const DocID:integer):Boolean;
    function DoActionOpenDocument(const DocID:integer):Boolean;

    procedure ImportFromXLS;

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

    procedure ReadFrameStates;override;
    procedure SaveFrameStates;override;

    procedure SetupSecurityItems;override;
  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses DataModuleDB, DataModuleAdditions, IBCError,
     frmÀêòÎïðèõîäîâàíèÿÏîÍàêëàäíûìDocDialog, frmSelectGoodsToAddDialog, frmMoneyIncomeDialog,
     SWNConst, SWNUtils, IBC, SWNValueStorageUnit, SWNDBErrors,
  frmÀêòÎïðèõîäîâàíèÿÏîÍàêëàäíûìImportGoodsAcntDialog, SWNSecurityFlags,
  SWNSecurity;


{$R *.dfm}

{ Tframe20ÏðèõîäÒîâàðàÏîÍàêëàäíûì }

procedure Tframe41AktOprihodPoNakladnim.bbActionCloseDocClick(Sender: TObject);
begin
     if ShowAskDialog('Çàêðûòü íàêëàäíóþ','Âû õîòèòå çàêðûòü íàêëàäíóþ?')=mrYes then
     begin
          if DoActionCloseDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
          begin
               dmDB.IBCQueryDocs.Refresh;
          end;
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.bbActionOpenDocClick(Sender: TObject);
begin
     if ShowAskDialog('Îòêðûòü íàêëàäíóþ','Âû õîòèòå îòêðûòü íàêëàäíóþ?')=mrYes then
     begin
          if DoActionOpenDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
          begin
               dmDB.IBCQueryDocs.Refresh;
          end;
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.bbAddGoodsClick(Sender: TObject);
begin
     ShowAddNewGoodsDialog;
end;

procedure Tframe41AktOprihodPoNakladnim.bbDeleteGoodsClick(Sender: TObject);
begin
     DeleteSelectedGoods;
end;

procedure Tframe41AktOprihodPoNakladnim.bbImportClick(Sender: TObject);
begin
     ImportFromXLS;
end;

procedure Tframe41AktOprihodPoNakladnim.bbModifyGoodsClick(Sender: TObject);
begin
     ShowModifyGoodsDialog;
end;

procedure Tframe41AktOprihodPoNakladnim.CreateNewRecord;
var dialog:TfrmAktOprihodPoNakladnimDocDlg;
begin
     dialog:=TfrmAktOprihodPoNakladnimDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if bbModifyGoods.Enabled then
     begin
          ShowModifyGoodsDialog;
          AHandled:=True;
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if AViewInfo.RecordViewInfo.Selected and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnUtils.ProcessCommonKeys(Self, cxGridComponentsTable,Key,Shift);
end;

procedure Tframe41AktOprihodPoNakladnim.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
     if Not VarIsNull(ARecord.Values[Sender.Index]) then
     begin
          if (ARecord.Values[cxGridComponents_UMID.Index]=1) then AText:=StringReplace(AText,QtyReplaceMask,'',[]);
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     DoDocumentDoubleClick;
     AHandled:=True;
end;

procedure Tframe41AktOprihodPoNakladnim.cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // Document prin contabilitate
     if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;

     if AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.Index]=1 then
     begin
          ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
          if Not AViewInfo.Selected then
          begin
               if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
               else ACanvas.Font.Color:=clGrayText;
          end;
     end;
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.cxGridPTNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnUtils.ProcessCommonKeys(Self, cxGridPTNTable,Key,Shift);
end;

procedure Tframe41AktOprihodPoNakladnim.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format('Óäàëèòü çàïèñü íîìåð %d?',[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))=mrYes then
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

procedure Tframe41AktOprihodPoNakladnim.DeleteSelectedGoods;
var S:String;
begin
     S:='Óäàëèòü òîâàð'+#13#10+dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString+'?';
     if ShowAskDialog('Óäàëåíèå òîâàðà','Âû õîòèòå óäàëèòü òîâàð'+S)=mrYes then
     begin
          dmDB.IBCQueryJurnal.UpdateTransaction.StartTransaction;
          try
             dmDB.IBCQueryJurnal.Delete;
             dmDB.IBCQueryJurnal.UpdateTransaction.Commit;
             dmDB.IBCQueryDocs.Refresh;
          except on E:Exception do
             begin
                  dmDB.IBCQueryJurnal.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

function Tframe41AktOprihodPoNakladnim.DoActionCloseDocument(const DocID:integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=false;

     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
           Query.SQL.Text:='EXECUTE PROCEDURE SP_CLOSE_AKT_OPRIH_NAKL(:DOCID)';
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

function Tframe41AktOprihodPoNakladnim.DoActionOpenDocument(const DocID:integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=false;

     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
           Query.SQL.Text:='EXECUTE PROCEDURE SP_OPEN_AKT_OPRIH_NAKL(:DOCID)';
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

procedure Tframe41AktOprihodPoNakladnim.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridPTNTable.OnFocusedRecordChanged:=nil;
     cxGridComponentsTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridPTNTable.DataController.DataSource:=nil;
     cxGridComponentsTable.DataController.DataSource:=nil;

     inherited;
end;

procedure Tframe41AktOprihodPoNakladnim.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridPTNTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;
     cxGridComponentsTable.DataController.DataSource:=dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
     cxGridPTNTable.OnFocusedRecordChanged:=WhenDocGridFocusedRecordChanged;
     cxGridComponentsTable.OnFocusedRecordChanged:=WhenGoodsGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
     DocSelectionChanged;
end;

function Tframe41AktOprihodPoNakladnim.GetCurrentSearchContext: TSearchContextValue;
begin
     Result := Inherited;

     if cxGridComponentsTable.Site.Focused then
     begin
          // context from Jurnal: Êîä + Íàèìåíîâàíèå
          Result.Context := ffGoods;
          Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
          Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
     end
     else
         if cxGridPTNTable.Site.Focused then
         begin
              // context from Docs
              if cxGridPTN_DATA.Focused then
              begin
                   // Äàòà
                   Result.Context := ffDate;
                   Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
              end
              else
                  if cxGridPTN_DTDEP_NAME.Focused then
                  begin
                       // Ñêëàä
                       Result.Context := ffStock;
                       Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
                       Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
                  end;
         end
end;

function Tframe41AktOprihodPoNakladnim.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs,fedsJurnal];
end;

function Tframe41AktOprihodPoNakladnim.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffGoods, ffStock,ffGoodsFolders,ffAcntGoods];
end;

function Tframe41AktOprihodPoNakladnim.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];

     if fSECURITY_New then Result:=Result+[fbtADD];
     if fSECURITY_Edit or fSECURITY_View then Result:=Result+[fbtMODIFY];
     if fSECURITY_Delete then Result:=Result+[fbtDELETE];
end;

procedure Tframe41AktOprihodPoNakladnim.GoodsSelectionChanged;
var fGoodsNew,fGoodsEdit,fGoodsDelete:Boolean;
    FLG_CLOSED:Boolean;
begin
     fGoodsNew:=False;
     fGoodsEdit:=False;
     fGoodsDelete:=False;

     if (cxGridPTNTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          if Not FLG_CLOSED then
          begin
               fGoodsNew:=fSECURITY_Edit; // New Goods + Security
               if (cxGridComponentsTable.DataController.RecNo>0) then
               begin
                    fGoodsEdit:=fSECURITY_Edit;   // Edit Goods + Security
                    fGoodsDelete:=fSECURITY_Edit; // Delete Goods + Security
               end;
          end;
     end;
     // goods
     bbAddGoods.Enabled:=fGoodsNew;
     bbImport.Enabled:=fGoodsNew;
     bbModifyGoods.Enabled:=fGoodsEdit;
     bbDeleteGoods.Enabled:=fGoodsDelete;
end;

procedure Tframe41AktOprihodPoNakladnim.ImportFromXLS;
var dialog:TFrame41ImportGoodsAcntDlg;
begin
     dialog:=TFrame41ImportGoodsAcntDlg.Create(Self);
     try
        dialog.DOCID:=dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        dialog.DTDEP:=dmdb.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
        dialog.CTDEP:=dmdb.IBCQueryDocs.FieldByName('CTDEP').AsInteger;
        if dialog.ShowModal=mrOk then dmDB.IBCQueryJurnal.Refresh;
     finally
        dialog.Free;
     end;
end;

function Tframe41AktOprihodPoNakladnim.InitFrameID: integer;
begin
     Result:=41; // ÈÍÂÅÍÒÀÐÈÇÀÖÈß. Àêò îïðèõîäîâàíèÿ ïî íàêëàäíûì
     SetupQtyFields;
end;

procedure Tframe41AktOprihodPoNakladnim.ModifyRecord;
var dialog:TfrmAktOprihodPoNakladnimDocDlg;
    ReadOnly:Boolean;
begin
     if Not (fSECURITY_Edit or fSECURITY_View) then Exit;

     if fSECURITY_Edit
       then ReadOnly:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1
       else ReadOnly:=fSECURITY_View;

     dialog:=TfrmAktOprihodPoNakladnimDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=False;
        dialog.ReadOnly:=ReadOnly;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        pnBottom.Height:=AppUserConfigStorage.IntValues.GetValue('BottomHeight',300);
//        cxSplitter.State:=TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridPTNTable);
        ReadGridColumnsSettings(cxGridComponentsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight',pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState',Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridPTNTable);
        SaveGridColumnsSettings(cxGridComponentsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.SetupDefaultFocus;
begin
     // grid
     cxGridPTN.SetFocus;
     // columns
     cxGridPTN_CT_NAME.Focused:=True;
     cxGridDBCol_GOODS_NAME.Focused:=True;
end;

procedure Tframe41AktOprihodPoNakladnim.SetupQtyFields;
begin
     // Êîë-âî
     TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat:=QtyDisplayFormat;
     cxGridDBCol_QTY.Summary.FooterFormat:=QtyDisplayFormat;
     // Îñòàòîê
     TcxCalcEditProperties(cxGridDBCol_STOCK_QTY.Properties).DisplayFormat:=QtyDisplayFormat;
end;

procedure Tframe41AktOprihodPoNakladnim.SetupSecurityItems;
begin
     fSECURITY_New:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÈÍÂÅÍÒÀÐÈÇÀÖÈß_ÀÎÏÍ_Ñîçäàòü);
     fSECURITY_View:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÈÍÂÅÍÒÀÐÈÇÀÖÈß_ÀÎÏÍ_Ïðîñìîòð);
     fSECURITY_Edit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÈÍÂÅÍÒÀÐÈÇÀÖÈß_ÀÎÏÍ_Èçìåíèòü);
     fSECURITY_Delete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÈÍÂÅÍÒÀÐÈÇÀÖÈß_ÀÎÏÍ_Óäàëèòü);

     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÈÍÂÅÍÒÀÐÈÇÀÖÈß_ÀÎÏÍ_Çàêðûòü) then bbActionCloseDoc.Visible:=ivNever;
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÈÍÂÅÍÒÀÐÈÇÀÖÈß_ÀÎÏÍ_Îòêðûòü) then bbActionOpenDoc.Visible:=ivNever;

     if dxPopupMenu.ItemLinks.VisibleItemCount=0 then cxGridPopupMenu1.PopupMenus[0].PopupMenu:=nil;
end;

procedure Tframe41AktOprihodPoNakladnim.DocSelectionChanged;
var fDocNew,fDocEdit,fDocDelete,fDocOpen,fDocClose:Boolean;
    FLG_CLOSED:Boolean;
begin
     fDocNew:=fSECURITY_New;
     fDocEdit:=False;
     fDocDelete:=false;
     fDocOpen:=False;
     fDocClose:=False;

     if cxGridPTNTable.DataController.RecNo>0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
          fDocEdit:=Not FLG_CLOSED and (fSECURITY_View or fSECURITY_Edit);   // Edit Document + Security
          fDocDelete:=Not FLG_CLOSED and fSECURITY_Delete; // Delete Document + Security
          fDocOpen:=Not FLG_CLOSED;
          fDocClose:=FLG_CLOSED;
     end;
     // doc
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);

     // popup
     bbActionCloseDoc.Enabled:=fDocOpen;
     bbActionOpenDoc.Enabled:=fDocClose;

     // goods
     GoodsSelectionChanged;
end;

procedure Tframe41AktOprihodPoNakladnim.ShowAddNewGoodsDialog;
var dialog:TfrmSelectGoodsToAddDlg;
begin
     dialog:=TfrmSelectGoodsToAddDlg.Create(Self,dmDB.IBCQueryJurnal,dmDB.IBCDataSourceJurnal);
     try
        dialog.AddNewGoods:=True;
        if dialog.ShowModal=mrOk then
        begin
             dmDB.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.ShowModifyGoodsDialog;
var dialog:TfrmSelectGoodsToAddDlg;
begin

     dialog:=TfrmSelectGoodsToAddDlg.Create(Self,dmDB.IBCQueryJurnal,dmDB.IBCDataSourceJurnal);
     try
        dialog.AddNewGoods:=False;
        if dialog.ShowModal=mrOk then
        begin
             dmDB.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe41AktOprihodPoNakladnim.WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsSelectionChanged;
end;

procedure Tframe41AktOprihodPoNakladnim.WhenDocGridFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
     DocSelectionChanged;
end;

end.
