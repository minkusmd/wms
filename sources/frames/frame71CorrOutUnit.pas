unit frame71CorrOutUnit;

// СЧЕТА. Входные Счета
// DocTypeID = 3126
// Frame Index = 71

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit,
  cxLabel, cxCheckBox, cxImageComboBox, dxBar, cxClasses, cxSplitter, ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxControls, cxGridCustomView, cxGrid, IBC, cxLookAndFeels, cxLookAndFeelPainters,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator, cxCalc, frameScanFiles,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  Tframe71CorrOut = class(TSWNBaseFrame)
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
    cxGridPTN_FLG_CLOSED: TcxGridDBColumn;
    cxGridPTNLevel: TcxGridLevel;
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    dxBarManager: TdxBarManager;
    bbAddGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbDeleteGoods: TdxBarButton;
    cxGridPTN_RATEUSD: TcxGridDBColumn;
    dxBarPopupMenuDOCS: TdxBarPopupMenu;
    cxGridPopupMenuDOCS: TcxGridPopupMenu;
    bbDocComments: TdxBarButton;
    cxGridPTN_CT: TcxGridDBColumn;
    cxGridPTN_SC2_NAME: TcxGridDBColumn;
    bbCustomerDebts: TdxBarButton;
    cxGridPopupMenuCOMPONENTS: TcxGridPopupMenu;
    frameScanFile1: TframeScanFile;
    procedure cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    
    procedure bbDocCommentsClick(Sender: TObject);
    procedure dxBarPopupMenuDOCSPopup(Sender: TObject);
    procedure cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridPTN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure bbCustomerDebtsClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView,
    fSECURITY_CanNew,
    fSECURITY_CanEdit,
    fSECURITY_CanDelete:Boolean;

    procedure WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocSelectionChanged;

    procedure WhenDocumentPopupMenuOpen;

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

    procedure SetupSecurityItems;override;

  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
  end;

implementation

uses DataModuleDB, DataModuleAdditions, SWNConst, frmВходныеСчетаDocDialog, SWNUtils, SWNDBErrors, frmSelectGoodsToAddDialog,
     SWNSecurity, SWNSecurityFlags, SWNValueStorageUnit, frmImportGoodsPricesDialog, frmVhodnieScetaGoodsAnalyzeDialog, SWNCommonDialogs;

{$R *.dfm}

{ Tframe44ScetaVhodnieSceta }

procedure Tframe71CorrOut.bbCustomerDebtsClick(Sender: TObject);
begin
     TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe71CorrOut.bbDocCommentsClick(Sender: TObject);
begin
     ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe71CorrOut.CreateNewRecord;
var dialog:TfrmVhodnieScetaDocDlg;
begin
     dialog:=TfrmVhodnieScetaDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe71CorrOut.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format('Удалить запись №%d?',[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))=mrYes then
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

procedure Tframe71CorrOut.DocSelectionChanged;
var fDocNew,fDocEdit,fDocDelete,fDebts,fImportGoods:Boolean;
    FLG_CLOSED:Boolean;
begin
     fDocNew:=fSECURITY_CanNew;
     fDocEdit:=False;
     fDocDelete:=false;
     fDebts:=False;
     fImportGoods:=False;

     if cxGridPTNTable.DataController.RecNo>0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fDocEdit:=fSECURITY_CanEdit and Not FLG_CLOSED;
          fDocDelete:=fSECURITY_CanDelete and Not FLG_CLOSED;
          fDebts:=True;
          fImportGoods:=Not FLG_CLOSED;
     end;
     // doc
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);

     bbCustomerDebts.Enabled:=fDebts;
end;

procedure Tframe71CorrOut.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridPTNTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridPTNTable.DataController.DataSource:=nil;

     inherited;
end;

procedure Tframe71CorrOut.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridPTNTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
     cxGridPTNTable.OnFocusedRecordChanged:=WhenDocGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
     DocSelectionChanged;
end;

procedure Tframe71CorrOut.dxBarPopupMenuDOCSPopup(Sender: TObject);
begin
     WhenDocumentPopupMenuOpen;
end;

function Tframe71CorrOut.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs,fedsJurnal];
end;

function Tframe71CorrOut.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffCustomer,ffGoods,ffGoodsFolders,ffAcntGoods];
end;

function Tframe71CorrOut.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_CanNew then Result:=Result+[fbtADD];
     if fSECURITY_CanEdit then Result:=Result+[fbtMODIFY];
     if fSECURITY_CanDelete then Result:=Result+[fbtDELETE];
end;

function Tframe71CorrOut.InitFrameID: integer;
begin
     // Договора - корреспондеция выходящяя
     Result := 71;
     SetupQtyFields;
end;

procedure Tframe71CorrOut.ModifyRecord;
var dialog:TfrmVhodnieScetaDocDlg;
    FLG_CLOSED:Boolean;
begin
     FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
     if fSECURITY_CanEdit and Not FLG_CLOSED then
     begin
          dialog:=TfrmVhodnieScetaDocDlg.Create(Self);
          try
             dialog.CreateNewDocument:=False;
             dialog.ShowModal;
          finally
             dialog.Free;
          end;
     end;
end;

procedure Tframe71CorrOut.SetupDefaultFocus;
begin
     // grid
     cxGridPTN.SetFocus;
     // columns
     cxGridPTN_CT_NAME.Focused:=True;
end;

procedure Tframe71CorrOut.SetupQtyFields;
begin
     // Кол-во
end;

procedure Tframe71CorrOut.SetupSecurityItems;
begin
     fSECURITY_CanView:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Просмотр);
     fSECURITY_CanNew:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Создать);
     fSECURITY_CanEdit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Изменить);
     fSECURITY_CanDelete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Удалить);

     if Not fSECURITY_CanEdit then
     begin
          bbAddGoods.Visible:=ivNever;
          bbModifyGoods.Visible:=ivNever;
          bbDeleteGoods.Visible:=ivNever;
     end;

     if SWNSecurityManager.IsPartialAccessMode then
     begin
       bbCustomerDebts.Visible := ivNever;
     end;
end;

procedure Tframe71CorrOut.WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     DocSelectionChanged;
end;

procedure Tframe71CorrOut.WhenDocumentPopupMenuOpen;
var fCreatePrihodRashod:Boolean;
    FLG_CLOSED:Boolean;
begin
     fCreatePrihodRashod:=False;

     if (cxGridPTNTable.DataController.RecNo>0) and (dmDB.IBCQueryDocs.FieldByName('HAS_JURNAL_GOODS').AsInteger=1) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
          fCreatePrihodRashod:=(Not FLG_CLOSED);     // Создать Приходную накладную
     end;
     // popup menu
     bbDocComments.Enabled:=fSECURITY_CanEdit;
end;


procedure Tframe71CorrOut.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe71CorrOut.cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if (AButton=mbLeft) and fSECURITY_CanEdit then
     begin
          DoDocumentDoubleClick;
          AHandled:=True;
     end;
end;

procedure Tframe71CorrOut.cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.index]=0 then
          begin
               if Not AViewInfo.Selected then
               begin
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
               end;
          end
          else
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
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

procedure Tframe71CorrOut.cxGridPTN_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridPTN_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridPTN_DATA.Index]);
end;

end.
