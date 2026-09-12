unit frame49ZacetBalansGarantiaUnit;
{
  SERVICE. Trecere in bilant pe garantie
  DocTypeID = 1726
  Frame Index = 49
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Vcl.FileCtrl, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit,
  cxLabel, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxControls, cxGridCustomView,
  cxGrid, cxLookAndFeels, cxLookAndFeelPainters, cxGridCustomPopupMenu, cxGridPopupMenu, dxBar, cxNavigator, Vcl.ExtCtrls, cxSplitter, DBAccess, IBC,
  MemDS, cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  Tframe49ZacetBalansGarantia = class(TSWNBaseFrame)
    cxGridSK: TcxGrid;
    cxGridSKTable: TcxGridDBTableView;
    cxGridSK_DOCID: TcxGridDBColumn;
    cxGridSK_DATA: TcxGridDBColumn;
    cxGridSK_CT_NAME: TcxGridDBColumn;
    cxGridSK_SUMA: TcxGridDBColumn;
    cxGridSK_CURRENCY_NAME: TcxGridDBColumn;
    cxGridSK_VAT: TcxGridDBColumn;
    cxGridSK_FLG_ACNT: TcxGridDBColumn;
    cxGridSK_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridSKLevel: TcxGridLevel;
    cxGridPopupMenu: TcxGridPopupMenu;
    dxBarPopupMenu: TdxBarPopupMenu;
    dxBarManagerSK: TdxBarManager;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    cxGridSK_FLG_CLOSED: TcxGridDBColumn;
    cxSplitter: TcxSplitter;
    pnBottom: TPanel;
    cxGridFiles: TcxGrid;
    cxGridFilesTable: TcxGridDBTableView;
    cxGridFiles_FILENAME: TcxGridDBColumn;
    cxGridFiles_FILESIZE: TcxGridDBColumn;
    cxGridFilesLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerSKBar1: TdxBar;
    bbAddNewFile: TdxBarButton;
    bbDeleteFile: TdxBarButton;
    bbSaveFileAs: TdxBarButton;
    IBCQueryFiles: TIBCQuery;
    IBCDataSourceFiles: TIBCDataSource;
    cxGridSK_RATE: TcxGridDBColumn;
    cxGridSK_RATEUSD: TcxGridDBColumn;
    procedure cxGridSKTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dxBarPopupMenuPopup(Sender: TObject);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure cxGridSKTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridSKTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridFilesTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbAddNewFileClick(Sender: TObject);
    procedure bbDeleteFileClick(Sender: TObject);
    procedure bbSaveFileAsClick(Sender: TObject);
    procedure cxGridSK_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
    fSECURITY_CanView,fSECURITY_CanCreate,fSECURITY_CanEdit,fSECURITY_CanDelete:Boolean;
    fLastFilePath:String;

    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure PopupMenu_SK;

    procedure ChangeDocumentCloseFlag(const DocID, FLG_CLOSED:integer);

    procedure FileSelectionChanged;
    procedure ShowAddNewFileDialog;
    procedure DeleteSelectedFile;
    procedure SaveAsSelectedFile;
    procedure SaveFileFromDB(const AttID:integer; const FilePath:String);
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

    procedure SaveFrameStates; override;
    procedure ReadFrameStates; override;

    procedure SetupSecurityItems;override;

  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;



implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, frmZacetBalansGarantiaDialog,
  SWNSecurity, SWNSecurityFlags, frm53RPPFileEditorDialog, SWNValueStorageUnit;


{$R *.dfm}

{ Tframe23—‡Î¸‰Ó ÓÌÚ‡„ÂÌÚÓ‚ }

procedure Tframe49ZacetBalansGarantia.bbAddNewFileClick(Sender: TObject);
begin
     ShowAddNewFileDialog;
end;

procedure Tframe49ZacetBalansGarantia.bbCloseDocClick(Sender: TObject);
begin
     if ShowAskDialog('Inchide documentul','Doriti sa inchideti documentul?')=mrYes then
     begin
          ChangeDocumentCloseFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger,1);
          dmDB.IBCQueryDocs.Refresh;
     end;
end;

procedure Tframe49ZacetBalansGarantia.bbDeleteFileClick(Sender: TObject);
begin
     DeleteSelectedFile;
end;

procedure Tframe49ZacetBalansGarantia.bbOpenDocClick(Sender: TObject);
begin
     if ShowAskDialog('Deschide documentul','Doriti sa deschideti documentul?')=mrYes then
     begin
          ChangeDocumentCloseFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger,0);
          dmDB.IBCQueryDocs.Refresh;
     end;
end;

procedure Tframe49ZacetBalansGarantia.bbSaveFileAsClick(Sender: TObject);
begin
     SaveAsSelectedFile;
end;

procedure Tframe49ZacetBalansGarantia.ChangeDocumentCloseFlag(const DocID, FLG_CLOSED: integer);
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        try
           Query.Transaction.StartTransaction;
           Query.SQL.Text:='EXECUTE PROCEDURE SP_DOC_OPEN_CLOSE_PTZ(:DOCID,:FLG_CLOSED)';
           Query.ParamByName('DOCID').AsInteger:=DocID;
           Query.ParamByName('FLG_CLOSED').AsInteger:=FLG_CLOSED;
           Query.ExecSQL;
           Query.Transaction.Commit;
        except on E:Exception do
           begin
                if Query.Transaction.Active then Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure Tframe49ZacetBalansGarantia.CreateNewRecord;
var dialog:TfrmZacetBalansGarantiaDlg;
begin
     dialog:=TfrmZacetBalansGarantiaDlg.Create(Self);
     try
        dialog.CreateNewDocument:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe49ZacetBalansGarantia.cxGridFilesTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     FileSelectionChanged;
end;

procedure Tframe49ZacetBalansGarantia.cxGridSKTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     DoDocumentDoubleClick;
     AHandled:=True;
end;

procedure Tframe49ZacetBalansGarantia.cxGridSKTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if Not VarIsNull(AViewInfo.GridRecord.Values[cxGridSK_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridSK_FLG_CLOSED.index]=1 then
          begin
               ACanvas.Font.Color:=clGrayText;
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
          end;
     end;

     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color:=$E8E8E8;
end;

procedure Tframe49ZacetBalansGarantia.cxGridSKTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(Self, cxGridSKTable,Key,Shift);
end;

procedure Tframe49ZacetBalansGarantia.cxGridSK_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridSK_DATA.Index]) then AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridSK_DATA.Index]);
end;

procedure Tframe49ZacetBalansGarantia.DeleteRecord;
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

procedure Tframe49ZacetBalansGarantia.DeleteSelectedFile;
begin
     if ShowAskDialog('Stergere fisier',Format('Doriti sa stergeti fisierul "%s"?',[IBCQueryFiles.FieldByName('FILENAME').asString]))<>mrYes then Exit;

     IBCQueryFiles.UpdateTransaction.StartTransaction;
     try
        IBCQueryFiles.Delete;
        IBCQueryFiles.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQueryFiles.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure Tframe49ZacetBalansGarantia.DoFrameHide;
begin
     // inchidem datele interne
     IBCQueryFiles.Close;

     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridSKTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridSKTable.DataController.DataSource:=nil;

     inherited;
end;

procedure Tframe49ZacetBalansGarantia.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridSKTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
     cxGridSKTable.OnFocusedRecordChanged:=WhenGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);
     // dechidem datele interne
     IBCQueryFiles.Open;

     // 4. Selection update
     SelectionChanged;
end;

procedure Tframe49ZacetBalansGarantia.dxBarPopupMenuPopup(Sender: TObject);
begin
     PopupMenu_SK;
end;

procedure Tframe49ZacetBalansGarantia.FileSelectionChanged;
var fAdd,fDelete,fSaveAs,FLG_CLOSED:Boolean;
begin
     fAdd:=False;
     fDelete:=False;
     fSaveAs:=False;

     if cxGridSKTable.DataController.RecNo>0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
          fAdd:=Not FLG_CLOSED;
          if (cxGridFilesTable.DataController.RecNo>0) then
          begin
               fDelete:=Not FLG_CLOSED;
               fSaveAs:=True;
          end;
     end;
     bbAddNewFile.Enabled:=fAdd;
     bbDeleteFile.Enabled:=fDelete;
     bbSaveFileAs.Enabled:=fSaveAs;
end;

function Tframe49ZacetBalansGarantia.GetCurrentSearchContext: TSearchContextValue;
begin
     if cxGridSKTable.Site.Focused then
     begin
          // context from Docs
          if cxGridSK_CT_NAME.Focused then
          begin
               // Contraagent
               Result.Context := ffCustomer;
               Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
               Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
          end
          else
              if cxGridSK_DATA.Focused then
              begin
                   // Data
                   Result.Context := ffDate;
                   Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
              end;
     end;
end;

function Tframe49ZacetBalansGarantia.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe49ZacetBalansGarantia.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffCustomer];
end;

function Tframe49ZacetBalansGarantia.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_CanCreate then Result:=Result+[fbtADD];
     if fSECURITY_CanView or fSECURITY_CanEdit then Result:=Result+[fbtMODIFY];
     if fSECURITY_CanDelete then Result:=Result+[fbtDELETE];
end;

function Tframe49ZacetBalansGarantia.InitFrameID: integer;
begin
     Result:=49; // SERVICE. Trecere in bilant pe garantie
end;

procedure Tframe49ZacetBalansGarantia.ModifyRecord;
var dialog:TfrmZacetBalansGarantiaDlg;
begin
     if Not (fSECURITY_CanEdit or fSECURITY_CanView) then Exit;

     dialog:=TfrmZacetBalansGarantiaDlg.Create(Self);
     try
        dialog.CreateNewDocument:=False;
        dialog.ReadOnly:=(Not fSECURITY_CanEdit) and fSECURITY_CanView;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe49ZacetBalansGarantia.PopupMenu_SK;
var FLG_CLOSED:Boolean;
begin
     FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
     bbCloseDoc.Enabled:=Not FLG_CLOSED;
     bbOpenDoc.Enabled:=FLG_CLOSED;
end;

procedure Tframe49ZacetBalansGarantia.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//        cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridSKTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe49ZacetBalansGarantia.RefreshData;
begin
    inherited;
    IBCQueryFiles.Refresh;
end;

procedure Tframe49ZacetBalansGarantia.SaveAsSelectedFile;
var dir:String;
begin
     dir:=fLastFilePath;
     if SelectDirectory('Alegeti unde sa salvati fisierul','',dir) then
     begin
          SaveFileFromDB(IBCQueryFiles.FieldByName('ATTID').AsInteger,dir);
          fLastFilePath:=dir;
     end;
end;

procedure Tframe49ZacetBalansGarantia.SaveFileFromDB(const AttID: integer; const FilePath: String);
var Query:TIBCQuery;
    filename:String;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT FILENAME,FILEDATA FROM TDB_DOCS_ATTACHMENTS WHERE ATTID=:ID';
        Query.ParamByName('ID').AsInteger:=AttID;
        Query.ExecSQL;
        if Not Query.Eof then
        begin
             filename:=IncludeTrailingPathDelimiter(FilePath)+Query.Fields[0].AsString;
             TBlobField(Query.Fields[1]).SaveToFile(filename);
        end;
     finally
        Query.Free;
     end;
end;

procedure Tframe49ZacetBalansGarantia.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridSKTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe49ZacetBalansGarantia.SelectionChanged;
var fDocNew,fDocEdit,fDocDelete:Boolean;
begin
     fDocNew:=True;     // New doc + Security
     fDocEdit:=False;
     fDocDelete:=False;

     if cxGridSKTable.DataController.RecNo>0 then
     begin
          fDocEdit:=True;   // Edit doc + Security
          fDocDelete:=True; // Delete doc + Security
     end;
     // doc
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);

     FileSelectionChanged;
end;

procedure Tframe49ZacetBalansGarantia.SetupDefaultFocus;
begin
     // grid
     cxGridSK.SetFocus;
     // columns
     cxGridSK_CT_NAME.Focused:=True;
end;

procedure Tframe49ZacetBalansGarantia.SetupSecurityItems;
begin
     fSECURITY_CanView:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_—≈–¬»—_«¬¡œ√_œÓÒÏÓÚ);
     fSECURITY_CanCreate:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_—≈–¬»—_«¬¡œ√_—ÓÁ‰‡Ú¸);
     fSECURITY_CanEdit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_—≈–¬»—_«¬¡œ√_–Â‰‡ÍÚËÓ‚‡Ú¸);
     fSECURITY_CanDelete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_—≈–¬»—_«¬¡œ√_”‰‡ÎËÚ¸);
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_—≈–¬»—_«¬¡œ√_«‡Í˚Ú¸_‰ÓÍÛÏÂÌÚ) then bbCloseDoc.Visible:=ivNever;
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_—≈–¬»—_«¬¡œ√_ŒÚÍ˚Ú¸_‰ÓÍÛÏÂÌÚ) then bbOpenDoc.Visible:=ivNever;
     if (dxBarPopupMenu.ItemLinks.VisibleItemCount=0) then cxGridPopupMenu.PopupMenus[0].PopupMenu:=nil;
end;

procedure Tframe49ZacetBalansGarantia.ShowAddNewFileDialog;
var dialog:Tfrm53RPPFileEditorDlg;
begin
     dialog:=Tfrm53RPPFileEditorDlg.Create(Self,IBCQueryFiles,IBCDataSourceFiles);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe49ZacetBalansGarantia.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

end.
