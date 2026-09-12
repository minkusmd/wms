unit frame80InventariereUnit;
{
  INVENTARIERE. Inventariere
  DocTypeID = 1968
  Frame Index = 80
}

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   System.UITypes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics,
   cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
   cxEdit, DB, cxDBData, cxCheckBox, cxCurrencyEdit, cxLabel, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView,
   cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxSplitter, cxGridCustomPopupMenu,
   cxGridPopupMenu, dxBar, DBAccess, IBC, MemDS, cxGridBandedTableView, cxGridDBBandedTableView, cxNavigator,
   cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges,
   dxSpreadSheetReportDesignerActions, dxSpreadSheetConditionalFormattingRulesActions, dxSpreadSheetActions,
   dxPrinting, System.Actions, Vcl.ActnList, dxActions, System.ImageList, Vcl.ImgList, cxImageList, dxScrollbarAnnotations,
  dxUIAClasses;

type
   Tframe80Inventariere = class(TSWNBaseFrame)
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
      cxGrid_CREATED_BY_NAME: TcxGridDBColumn;
      cxGridDocsLevel: TcxGridLevel;
      pnBottom: TPanel;
      cxSplitter: TcxSplitter;
//    pmDocs: TdxBarPopupMenu;
      cxGridDocsPopupMenu: TcxGridPopupMenu;
      dxBarManager1: TdxBarManager;
      bbCloseDoc: TdxBarButton;
      bbOpenDoc: TdxBarButton;
      dxBarDockControl1: TdxBarDockControl;
      dxBarManager1Bar1: TdxBar;
      cxGrid_DT_NAME: TcxGridDBColumn;
      pmDocs: TdxBarPopupMenu;
      dxBarButton1: TdxBarButton;
      cxGridInventDBTableView: TcxGridDBTableView;
      cxGridInventLevel1: TcxGridLevel;
      cxGridInvent: TcxGrid;
      IBCDataSourceInvent: TIBCDataSource;
      IBCQueryInvent: TIBCQuery;
      dxBarCombo1: TdxBarCombo;
      ActionList1: TActionList;
      cxImageList1: TcxImageList;
      dxSpreadSheetNewDocument: TdxSpreadSheetNewDocument;
      dxSpreadSheetOpenDocument: TdxSpreadSheetOpenDocument;
      dxSpreadSheetSaveDocumentAs: TdxSpreadSheetSaveDocumentAs;
      dxSpreadSheetShowPrintForm: TdxSpreadSheetShowPrintForm;
      dxSpreadSheetShowPrintPreviewForm: TdxSpreadSheetShowPrintPreviewForm;
      dxSpreadSheetShowPageSetupForm: TdxSpreadSheetShowPageSetupForm;
      dxSpreadSheetPasteSelection: TdxSpreadSheetPasteSelection;
      dxSpreadSheetCutSelection: TdxSpreadSheetCutSelection;
      dxSpreadSheetCopySelection: TdxSpreadSheetCopySelection;
      dxSpreadSheetChangeFontName: TdxSpreadSheetChangeFontName;
      dxSpreadSheetChangeFontSize: TdxSpreadSheetChangeFontSize;
      dxSpreadSheetIncreaseFontSize: TdxSpreadSheetIncreaseFontSize;
      dxSpreadSheetDecreaseFontSize: TdxSpreadSheetDecreaseFontSize;
      dxSpreadSheetToggleFontBold: TdxSpreadSheetToggleFontBold;
      dxSpreadSheetToggleFontItalic: TdxSpreadSheetToggleFontItalic;
      dxSpreadSheetToggleFontUnderline: TdxSpreadSheetToggleFontUnderline;
      dxSpreadSheetToggleFontStrikeout: TdxSpreadSheetToggleFontStrikeout;
      dxSpreadSheetBordersBottom: TdxSpreadSheetBordersBottom;
      dxSpreadSheetBordersTop: TdxSpreadSheetBordersTop;
      dxSpreadSheetBordersLeft: TdxSpreadSheetBordersLeft;
      dxSpreadSheetBordersRight: TdxSpreadSheetBordersRight;
      dxSpreadSheetBordersNone: TdxSpreadSheetBordersNone;
      dxSpreadSheetBordersAll: TdxSpreadSheetBordersAll;
      dxSpreadSheetBordersOutside: TdxSpreadSheetBordersOutside;
      dxSpreadSheetBordersOutsideThick: TdxSpreadSheetBordersOutsideThick;
      dxSpreadSheetBordersBottomDouble: TdxSpreadSheetBordersBottomDouble;
      dxSpreadSheetBordersBottomThick: TdxSpreadSheetBordersBottomThick;
      dxSpreadSheetBordersTopAndBottom: TdxSpreadSheetBordersTopAndBottom;
      dxSpreadSheetBordersTopAndBottomThick: TdxSpreadSheetBordersTopAndBottomThick;
      dxSpreadSheetBordersTopAndBottomDouble: TdxSpreadSheetBordersTopAndBottomDouble;
      dxSpreadSheetBordersMore: TdxSpreadSheetBordersMore;
      dxSpreadSheetChangeFillColor: TdxSpreadSheetChangeFillColor;
      dxSpreadSheetChangeFontColor: TdxSpreadSheetChangeFontColor;
      dxSpreadSheetAlignVerticalTop: TdxSpreadSheetAlignVerticalTop;
      dxSpreadSheetAlignVerticalCenter: TdxSpreadSheetAlignVerticalCenter;
      dxSpreadSheetAlignVerticalBottom: TdxSpreadSheetAlignVerticalBottom;
      dxSpreadSheetAlignHorizontalLeft: TdxSpreadSheetAlignHorizontalLeft;
      dxSpreadSheetAlignHorizontalCenter: TdxSpreadSheetAlignHorizontalCenter;
      dxSpreadSheetAlignHorizontalRight: TdxSpreadSheetAlignHorizontalRight;
      dxSpreadSheetTextIndentDecrease: TdxSpreadSheetTextIndentDecrease;
      dxSpreadSheetTextIndentIncrease: TdxSpreadSheetTextIndentIncrease;
      dxSpreadSheetTextWrap: TdxSpreadSheetTextWrap;
      dxSpreadSheetMergeCellsAndCenter: TdxSpreadSheetMergeCellsAndCenter;
      dxSpreadSheetMergeCellsAcross: TdxSpreadSheetMergeCellsAcross;
      dxSpreadSheetMergeCells: TdxSpreadSheetMergeCells;
      dxSpreadSheetUnmergeCells: TdxSpreadSheetUnmergeCells;
      dxSpreadSheetInsertRows: TdxSpreadSheetInsertRows;
      dxSpreadSheetInsertColumns: TdxSpreadSheetInsertColumns;
      dxSpreadSheetInsertSheet: TdxSpreadSheetInsertSheet;
      dxSpreadSheetDeleteRows: TdxSpreadSheetDeleteRows;
      dxSpreadSheetDeleteColumns: TdxSpreadSheetDeleteColumns;
      dxSpreadSheetDeleteSheet: TdxSpreadSheetDeleteSheet;
      dxSpreadSheetAutoFitRowHeight: TdxSpreadSheetAutoFitRowHeight;
      dxSpreadSheetAutoFitColumnWidth: TdxSpreadSheetAutoFitColumnWidth;
      dxSpreadSheetHideRows: TdxSpreadSheetHideRows;
      dxSpreadSheetHideColumns: TdxSpreadSheetHideColumns;
      dxSpreadSheetHideSheet: TdxSpreadSheetHideSheet;
      dxSpreadSheetUnhideRows: TdxSpreadSheetUnhideRows;
      dxSpreadSheetUnhideColumns: TdxSpreadSheetUnhideColumns;
      dxSpreadSheetUnhideSheet: TdxSpreadSheetUnhideSheet;
      dxSpreadSheetClearAll: TdxSpreadSheetClearAll;
      dxSpreadSheetClearFormats: TdxSpreadSheetClearFormats;
      dxSpreadSheetClearContents: TdxSpreadSheetClearContents;
      dxSpreadSheetUndo: TdxSpreadSheetUndo;
      dxSpreadSheetRedo: TdxSpreadSheetRedo;
      dxSpreadSheetFindAndReplace: TdxSpreadSheetFindAndReplace;
      dxSpreadSheetInsertPicture: TdxSpreadSheetInsertPicture;
      dxSpreadSheetShowHyperlinkEditor: TdxSpreadSheetShowHyperlinkEditor;
      dxSpreadSheetPageMarginsGallery: TdxSpreadSheetPageMarginsGallery;
      dxSpreadSheetMorePageMargins: TdxSpreadSheetMorePageMargins;
      dxSpreadSheetSetPortraitPageOrientation: TdxSpreadSheetSetPortraitPageOrientation;
      dxSpreadSheetSetLandscapePageOrientation: TdxSpreadSheetSetLandscapePageOrientation;
      dxSpreadSheetPaperSizeGallery: TdxSpreadSheetPaperSizeGallery;
      dxSpreadSheetMorePaperSizes: TdxSpreadSheetMorePaperSizes;
      dxSpreadSheetSetPrintArea: TdxSpreadSheetSetPrintArea;
      dxSpreadSheetClearPrintArea: TdxSpreadSheetClearPrintArea;
      dxSpreadSheetInsertPageBreak: TdxSpreadSheetInsertPageBreak;
      dxSpreadSheetRemovePageBreak: TdxSpreadSheetRemovePageBreak;
      dxSpreadSheetResetAllPageBreaks: TdxSpreadSheetResetAllPageBreaks;
      dxSpreadSheetPrintTitles: TdxSpreadSheetPrintTitles;
      dxSpreadSheetAutoSumGallery: TdxSpreadSheetAutoSumGallery;
      dxSpreadSheetFinancialFormulasGallery: TdxSpreadSheetFinancialFormulasGallery;
      dxSpreadSheetLogicalFormulasGallery: TdxSpreadSheetLogicalFormulasGallery;
      dxSpreadSheetTextFormulasGallery: TdxSpreadSheetTextFormulasGallery;
      dxSpreadSheetDateAndTimeFormulasGallery: TdxSpreadSheetDateAndTimeFormulasGallery;
      dxSpreadSheetLookupAndReferenceFormulasGallery: TdxSpreadSheetLookupAndReferenceFormulasGallery;
      dxSpreadSheetMathAndTrigFormulasGallery: TdxSpreadSheetMathAndTrigFormulasGallery;
      dxSpreadSheetStatisticalFormulasGallery: TdxSpreadSheetStatisticalFormulasGallery;
      dxSpreadSheetInformationFormulasGallery: TdxSpreadSheetInformationFormulasGallery;
      dxSpreadSheetCompatibilityFormulasGallery: TdxSpreadSheetCompatibilityFormulasGallery;
      dxSpreadSheetSortAscending: TdxSpreadSheetSortAscending;
      dxSpreadSheetSortDescending: TdxSpreadSheetSortDescending;
      dxSpreadSheetGroupColumns: TdxSpreadSheetGroupColumns;
      dxSpreadSheetGroupRows: TdxSpreadSheetGroupRows;
      dxSpreadSheetUngroupColumns: TdxSpreadSheetUngroupColumns;
      dxSpreadSheetUngroupRows: TdxSpreadSheetUngroupRows;
      dxSpreadSheetNewComment: TdxSpreadSheetNewComment;
      dxSpreadSheetEditComment: TdxSpreadSheetEditComment;
      dxSpreadSheetDeleteComments: TdxSpreadSheetDeleteComments;
      dxSpreadSheetPreviousComment: TdxSpreadSheetPreviousComment;
      dxSpreadSheetNextComment: TdxSpreadSheetNextComment;
      dxSpreadSheetShowHideComments: TdxSpreadSheetShowHideComments;
      dxSpreadSheetProtectSheet: TdxSpreadSheetProtectSheet;
      dxSpreadSheetProtectWorkbook: TdxSpreadSheetProtectWorkbook;
      dxSpreadSheetZoomOut: TdxSpreadSheetZoomOut;
      dxSpreadSheetZoomIn: TdxSpreadSheetZoomIn;
      dxSpreadSheetZoomDefault: TdxSpreadSheetZoomDefault;
      dxSpreadSheetFreezePanes: TdxSpreadSheetFreezePanes;
      dxSpreadSheetUnfreezePanes: TdxSpreadSheetUnfreezePanes;
      dxSpreadSheetFreezeTopRow: TdxSpreadSheetFreezeTopRow;
      dxSpreadSheetFreezeFirstColumn: TdxSpreadSheetFreezeFirstColumn;
      dxSpreadSheetConditionalFormattingTopBottomRulesGallery: TdxSpreadSheetConditionalFormattingTopBottomRulesGallery;
      dxSpreadSheetConditionalFormattingMoreRules: TdxSpreadSheetConditionalFormattingMoreRules;
      dxSpreadSheetConditionalFormattingDataBarsGallery: TdxSpreadSheetConditionalFormattingDataBarsGallery;
      dxSpreadSheetConditionalFormattingColorScalesGallery: TdxSpreadSheetConditionalFormattingColorScalesGallery;
      dxSpreadSheetConditionalFormattingIconSetsGallery: TdxSpreadSheetConditionalFormattingIconSetsGallery;
      dxSpreadSheetConditionalFormattingNewRule: TdxSpreadSheetConditionalFormattingNewRule;
      dxSpreadSheetConditionalFormattingClearRulesFromSelectedCells:
         TdxSpreadSheetConditionalFormattingClearRulesFromSelectedCells;
      dxSpreadSheetConditionalFormattingClearRulesFromEntireSheet:
         TdxSpreadSheetConditionalFormattingClearRulesFromEntireSheet;
      dxSpreadSheetShowConditionalFormattingRulesManager: TdxSpreadSheetShowConditionalFormattingRulesManager;
      dxSpreadSheetReportDesignerSingleSheetReportMode: TdxSpreadSheetReportDesignerSingleSheetReportMode;
      dxSpreadSheetReportDesignerMultipleSheetsReportMode: TdxSpreadSheetReportDesignerMultipleSheetsReportMode;
      dxSpreadSheetReportDesignerMultipleDocumentsReportMode: TdxSpreadSheetReportDesignerMultipleDocumentsReportMode;
      dxSpreadSheetReportDesignerHorizontalOrientation: TdxSpreadSheetReportDesignerHorizontalOrientation;
      dxSpreadSheetReportDesignerVerticalOrientation: TdxSpreadSheetReportDesignerVerticalOrientation;
      dxSpreadSheetReportDesignerHeaderSection: TdxSpreadSheetReportDesignerHeaderSection;
      dxSpreadSheetReportDesignerFooterSection: TdxSpreadSheetReportDesignerFooterSection;
      dxSpreadSheetReportDesignerDetailSection: TdxSpreadSheetReportDesignerDetailSection;
      dxSpreadSheetReportDesignerDetailLevel: TdxSpreadSheetReportDesignerDetailLevel;
      dxSpreadSheetReportDesignerDataMember: TdxSpreadSheetReportDesignerDataMember;
      dxSpreadSheetReportDesignerResetSection: TdxSpreadSheetReportDesignerResetSection;
      dxSpreadSheetReportDesignerSortFields: TdxSpreadSheetReportDesignerSortFields;
      dxSpreadSheetReportDesignerGroupHeaderSection: TdxSpreadSheetReportDesignerGroupHeaderSection;
      dxSpreadSheetReportDesignerGroupFooterSection: TdxSpreadSheetReportDesignerGroupFooterSection;
      dxSpreadSheetReportDesignerEditFilter: TdxSpreadSheetReportDesignerEditFilter;
      dxSpreadSheetReportDesignerResetFilter: TdxSpreadSheetReportDesignerResetFilter;
      dxSpreadSheetReportDesignerDesignView: TdxSpreadSheetReportDesignerDesignView;
      dxSpreadSheetReportDesignerReportPreview: TdxSpreadSheetReportDesignerReportPreview;
      cxGridInventDBTableViewGOODSID: TcxGridDBColumn;
      cxGridInventDBTableViewGOODSNAME: TcxGridDBColumn;
      cxGridInventDBTableViewIMAGE_INDEX: TcxGridDBColumn;
      cxGridInventDBTableViewBALANCE_QTY: TcxGridDBColumn;
      cxGridInventDBTableViewREZERV_QTY: TcxGridDBColumn;
      cxGridInventDBTableViewREAL_QTY: TcxGridDBColumn;
      cxGridInventDBTableViewCOMMENT: TcxGridDBColumn;
      cxGridInventDBTableViewCREATED_BY: TcxGridDBColumn;
      cxGridInventDBTableViewCREATE_BY_NAME: TcxGridDBColumn;
      cxGridInventDBTableViewMODIFIED_BY: TcxGridDBColumn;
      cxGridInventDBTableViewMODIFIED_BY_NAME: TcxGridDBColumn;
      dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton5: TdxBarButton;
      procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
         TcxGridTableDataCellViewInfo; var ADone: Boolean);
      procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure bbGoodsDeleteClick(Sender: TObject);
      procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
         TcxGridTableDataCellViewInfo; var ADone: Boolean);
      procedure bbCloseDocClick(Sender: TObject);
      procedure bbOpenDocClick(Sender: TObject);
      procedure dxBarCombo1Change(Sender: TObject);
      procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton5Click(Sender: TObject);
   private
      fLastGoodsFolderID: Integer;
    { Private declarations }
      fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
      procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
         AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
      procedure DocumentSelectionChanged;
      procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
         AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
      procedure DeleteGoods;
      procedure DoCloseDocument;
      function CloseDocumentDB(const DocID: Integer): Boolean;
      procedure DoOpenDocument;
      function OpenDocumentDB(const DocID: Integer): Boolean;
      procedure ShowAddGoodsFoldersDialog;
      procedure AddGoodsFromFolderToGrid(const GoodsFolderID: Integer; const DTDEP: integer);
      procedure ShowNewSelectedGoodsDialog;
   protected
      procedure ApplyInventFilter(CurItemIndex: Integer);
    { Protected declarations }
      function InitFrameID: Integer; override;
      function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
      procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
      procedure DoFrameHide; override;
      function GetFilterFields: TFrameFilterFields; override;
      function GetFrameButtons: TFrameButtons; override;
      procedure CreateNewRecord; override;
      procedure ModifyRecord; override;
      procedure DeleteRecord; override;
      procedure ImportFromGoodsDirectoryFolder;
      procedure RefreshData; override;
      procedure SaveFrameStates; override;
      procedure ReadFrameStates; override;
      procedure SetupSecurityItems; override;
   public
    { Public declarations }
      procedure SetupDefaultFocus; override;
      function GetCurrentSearchContext: TSearchContextValue; override;
   end;

implementation

{$R *.dfm}

uses
   SWNSecurity, SWNSecurityFlags, DataModuleDB, SWNConst, SWNUtils, SWNDBErrors, DataModuleAdditions,
   frm52ZamenaTovaraEditorDialog, frm54InventarizatiaDocDialog, SWNValueStorageUnit, frmGoods, frmSelectGoodsToAddDialog;

procedure Tframe80Inventariere.ApplyInventFilter(CurItemIndex: Integer);
begin
   IBCQueryInvent.Close;
   case CurItemIndex of
      0: // fara filtru, toate inregistrarile
         IBCQueryInvent.FilterSQL := '';
      1: // surplus de marfa
         IBCQueryInvent.FilterSQL := '((BALANCE_QTY + REZERV_QTY) < REAL_QTY)';
      2: // lipsa marfa
         IBCQueryInvent.FilterSQL := '((BALANCE_QTY + REZERV_QTY) > REAL_QTY)';
      3: // Produse in stoc
         IBCQueryInvent.FilterSQL := '(BALANCE_QTY + REZERV_QTY) > 0';
      4: // Produse noi
         IBCQueryInvent.FilterSQL := '((BALANCE_QTY + REZERV_QTY) = 0) and (REAL_QTY > 0)';
   end;
   IBCQueryInvent.Open;
end;

{ Tframe52ZamenaTovara }

procedure Tframe80Inventariere.bbCloseDocClick(Sender: TObject);
begin
   DoCloseDocument;
end;

procedure Tframe80Inventariere.bbGoodsDeleteClick(Sender: TObject);
begin
   DeleteGoods;
end;

procedure Tframe80Inventariere.bbOpenDocClick(Sender: TObject);
begin
   DoOpenDocument;
end;

function Tframe80Inventariere.CloseDocumentDB(const DocID: Integer): Boolean;
var
   Query: TIBCQuery;
begin
   Result := False;
   Query := TIBCQuery.Create(Self);
   try
      Query.Connection := dmDB.IBCConnection;
      Query.Transaction := dmDB.IBCTrDefaultUpdate;
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_INV(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := DocID;
      try
         Query.Transaction.StartTransaction;
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

procedure Tframe80Inventariere.CreateNewRecord;
var
   dialog: Tfrm54InventarizatiaDocDlg;
begin
   dialog := Tfrm54InventarizatiaDocDlg.Create(Self);
   try
      dialog.CreateNewDocument := True;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure Tframe80Inventariere.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
   TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
   if VarIsNumeric(AViewInfo.GridRecord.Values[cxGrid_FLG_CLOSED.index]) then
   begin
      if AViewInfo.GridRecord.Values[cxGrid_FLG_CLOSED.index] = 0 then
      begin
         if not AViewInfo.Selected then
         begin
                    // Document prin contabilitate
//            if AViewInfo.GridRecord.Values[cxGrid_FLG_ACNT.Index] = 1 then
//               ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
         end;
      end
      else
      begin
         ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
         if not AViewInfo.Selected then
         begin
//            if AViewInfo.GridRecord.Values[cxGrid_FLG_ACNT.Index] = 1 then
//               ACanvas.Font.Color := $008b8bc5
//            else
//               ACanvas.Font.Color := clGrayText;
         end;
      end;
   end;

     // highlight selected row
   if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
   begin
      ACanvas.Brush.Color := $E8E8E8;
   end;
end;

procedure Tframe80Inventariere.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   SWNUtils.ProcessCommonKeys(Self, cxGridDocsTable, Key, Shift);
end;

procedure Tframe80Inventariere.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
   TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
   if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
   begin
      ACanvas.Brush.Color := $E8E8E8;
   end;
end;

procedure Tframe80Inventariere.DeleteGoods;
begin
end;

procedure Tframe80Inventariere.DeleteRecord;
begin
   if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Sterge inregistrarea nr.%d?', [dmDB.IBCQueryDocs.FieldByName
      ('DOCID').AsInteger])) = mrYes then
   begin
      dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
      try
         dmDB.IBCQueryDocs.Delete;
         dmDB.IBCQueryDocs.UpdateTransaction.Commit;
      except
         on E: Exception do
         begin
            dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
            if not ProcessSWNError(E) then
               raise;
         end;
      end;
   end;
end;

procedure Tframe80Inventariere.DoCloseDocument;
begin
   if ShowAskDialog('Inventariere', 'Doriti sa inchideti documentul?') = mrYes then
   begin
      if CloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
         dmDB.IBCQueryDocs.Refresh;
   end;
end;

procedure Tframe80Inventariere.DocumentSelectionChanged;
var
   fDocNew, fDocEdit, fDocDelete: Boolean;
   fCloseDoc, fOpenDoc: Boolean;
   FLG_CLOSED: Boolean;
begin
   fDocNew := True;      // New document + Security
   fDocEdit := False;
   fDocDelete := False;

   fCloseDoc := False;
   fOpenDoc := False;

   if cxGridDocsTable.DataController.RecNo > 0 then
   begin
      FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

      fDocEdit := not FLG_CLOSED;  // Edit document
      fDocDelete := not FLG_CLOSED; // Delete document

      fCloseDoc := not FLG_CLOSED;
      fOpenDoc := FLG_CLOSED;
   end;
     // doc
   ButtonStateChanged(fbtADD, fDocNew);
   ButtonStateChanged(fbtMODIFY, fDocEdit);
   ButtonStateChanged(fbtDELETE, fDocDelete);
     // popup
   bbCloseDoc.Enabled := fCloseDoc;
   bbOpenDoc.Enabled := fOpenDoc;
end;

procedure Tframe80Inventariere.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
   IBCQueryInvent.Close;
   CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
   cxGridDocsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
   cxGridDocsTable.DataController.DataSource := nil;
   cxGridInventDBTableView.DataController.DataSource := nil;

   inherited;
end;

procedure Tframe80Inventariere.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
   inherited;

     // 1. Legam grid-urile de datasource-sele
   cxGridDocsTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
   cxGridInventDBTableView.DataController.DataSource := IBCDataSourceInvent;


     // 2. Selection handlers
   cxGridDocsTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
   OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne

   IBCQueryInvent.Open;

     // 4. Selection update
   DocumentSelectionChanged;
end;

procedure Tframe80Inventariere.DoOpenDocument;
begin
   if ShowAskDialog('Inventariere', 'Deschideti documentul de inventariere?') = mrYes then
   begin
      if OpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
         dmDB.IBCQueryDocs.Refresh;
   end;
end;

procedure Tframe80Inventariere.dxBarButton2Click(Sender: TObject);
begin
   ImportFromGoodsDirectoryFolder;
end;

procedure Tframe80Inventariere.dxBarButton3Click(Sender: TObject);
begin
   ShowNewSelectedGoodsDialog;
end;

procedure Tframe80Inventariere.dxBarButton5Click(Sender: TObject);
begin
  if MessageDlg('Stergeti inregistrarea?', mtConfirmation, [mbYes, mbNo], 0)= mrYes then
  begin
     IBCQueryInvent.Delete;
  end;
end;

procedure Tframe80Inventariere.ShowNewSelectedGoodsDialog;
var dialog:TfrmGoodsBrowser;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.ShowModal=mrOk then
        begin
          IBCQueryInvent.Append;
          IBCQueryInvent.FieldByName('GOODSID').AsInteger := dialog.GoodsID ;
          IBCQueryInvent.FieldByName('GOODSNAME').AsString := dialog.GoodsTitle;
          IBCQueryInvent.FieldByName('IMAGE_INDEX').AsInteger := 0;
          IBCQueryInvent.FieldByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger ;
          IBCQueryInvent.Post;

          dmDB.IBCQueryDocs.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe80Inventariere.dxBarCombo1Change(Sender: TObject);
begin
   ApplyInventFilter(dxBarCombo1.CurItemIndex);
end;

function Tframe80Inventariere.GetCurrentSearchContext: TSearchContextValue;
begin
   Result := inherited;

   if cxGridDocsTable.Site.Focused then
   begin
          // context from Docs
      if cxGrid_DATA.Focused then
      begin
         Result.Context := ffDate;
         Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
      end
      else if cxGrid_DTDEP_NAME.Focused then
      begin
         // Depozit
         Result.Context := ffStock;
         Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
         Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
      end;
   end;

      // 07.05.2019 Sergiu
      // si pentru produse de utilizat valorile curente din grid
   if cxGridInventDBTableView.Site.Focused then
   begin
      Result.Context := ffGoods;
      Result.ValueInt := IBCQueryInvent.FieldByName('GOODSID').AsInteger;
   end
end;

function Tframe80Inventariere.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
   Result := [fedsDocs];
end;

function Tframe80Inventariere.GetFilterFields: TFrameFilterFields;
begin
   Result := [ffDate, ffGoods, ffStock];
end;

function Tframe80Inventariere.GetFrameButtons: TFrameButtons;
begin
   Result := [fbtREFRESH];
   if fSECURITY_CanNew then
      Result := Result + [fbtADD];
   if fSECURITY_CanEdit or fSECURITY_CanView then
      Result := Result + [fbtMODIFY];
   if fSECURITY_CanDelete then
      Result := Result + [fbtDELETE];
end;

procedure Tframe80Inventariere.ImportFromGoodsDirectoryFolder;
begin
   ShowAddGoodsFoldersDialog;
end;

procedure Tframe80Inventariere.ShowAddGoodsFoldersDialog;
var
   dialog: TfrmGoodsBrowser;
begin
   dialog := TfrmGoodsBrowser.Create(Self);
   try
      if dialog.SelectGoods(fLastGoodsFolderID, True, 0, 'Alegeti mapa de produse') then
      begin
         if dialog.GoodsIsFolder then
         begin
            AddGoodsFromFolderToGrid(dialog.GoodsID, dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger);
            fLastGoodsFolderID := dialog.GoodsID;
         end
         else
            ShowErrorDialog('Mape produse', 'Se poate adauga doar mape!');
      end;
   finally
      dialog.Free;
   end;
end;

procedure Tframe80Inventariere.AddGoodsFromFolderToGrid(const GoodsFolderID:
    Integer; const DTDEP: integer);
begin
   cxGridInventDBTableView.BeginUpdate;
   try
      dmDB.ExecuteQuery('EXECUTE PROCEDURE SP_PERFORM_FILL_INVENT_DOC(:DOCID, :DTDEP, :GOODSFOLDERID)', [dmDB.IBCQueryDocs.FieldByName
         ('DOCID').AsInteger, DTDEP, GoodsFolderID]);
      IBCQueryInvent.Refresh;
   finally
      cxGridInventDBTableView.EndUpdate;
   end;
end;

function Tframe80Inventariere.InitFrameID: Integer;
begin
     // INVENTARIERE. Inventariere
   Result := 80;
end;

procedure Tframe80Inventariere.ModifyRecord;
var
   dialog: Tfrm54InventarizatiaDocDlg;
   ReadOnly: Boolean;
begin
   if not (fSECURITY_CanEdit or fSECURITY_CanView) then
      Exit;
   if fSECURITY_CanEdit then
      ReadOnly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
   else
      ReadOnly := fSECURITY_CanView;

   dialog := Tfrm54InventarizatiaDocDlg.Create(Self);
   try
      dialog.ReadOnly := ReadOnly;
      dialog.CreateNewDocument := False;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

function Tframe80Inventariere.OpenDocumentDB(const DocID: Integer): Boolean;
var
   Query: TIBCQuery;
begin
   Result := False;
   Query := TIBCQuery.Create(Self);
   try
      Query.Connection := dmDB.IBCConnection;
      Query.Transaction := dmDB.IBCTrDefaultUpdate;
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_INV(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := DocID;
      try
         Query.Transaction.StartTransaction;
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

procedure Tframe80Inventariere.ReadFrameStates;
begin
   AppUserConfigStorage.OpenSection(Self.Name);
   try
//      pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//      cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
      ReadGridColumnsSettings(cxGridDocsTable);
   finally
      AppUserConfigStorage.CloseSection;
   end;
end;

procedure Tframe80Inventariere.RefreshData;
begin
   inherited;
//     IBCQueryGoods.Refresh;
end;

procedure Tframe80Inventariere.SaveFrameStates;
begin
   AppUserConfigStorage.OpenSection(Self.Name);
   try
//      AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//      AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
      SaveGridColumnsSettings(cxGridDocsTable);
   finally
      AppUserConfigStorage.CloseSection;
   end;
end;

procedure Tframe80Inventariere.SetupDefaultFocus;
begin
     // grid
   cxGridDocs.SetFocus;
     // columns
   cxGrid_DT_NAME.Focused := True;
end;

procedure Tframe80Inventariere.SetupSecurityItems;
begin
   fSECURITY_CanView := True;
   fSECURITY_CanNew := True;
   fSECURITY_CanEdit := True;
   fSECURITY_CanDelete := True;
end;

procedure Tframe80Inventariere.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
   APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
   DocumentSelectionChanged;
end;

procedure Tframe80Inventariere.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
   APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
//     GoodsSelectionChanged;
end;

end.

