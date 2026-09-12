unit frame61OstatkiDenegNaScetuUnit;
{
  OPERATIUNI BANCARE. Sold bani in cont
  DocTypeID = 3036
  Frame Index = 61
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, cxCurrencyEdit, cxCalc, cxLabel, dxBar, cxGridCustomPopupMenu, cxGridPopupMenu,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  Tframe61OstatkiDenegNaScetu = class(TSWNBaseFrame)
    cxGridDocsTable: TcxGridDBTableView;
    cxGridDocsLevel: TcxGridLevel;
    cxGridDocs: TcxGrid;
    cxGridDocs_DOCID: TcxGridDBColumn;
    cxGridDocs_DATA: TcxGridDBColumn;
    cxGridDocs_SUMA: TcxGridDBColumn;
    cxGridDocs_CURRENCY_NAME: TcxGridDBColumn;
    cxGridDocs_FLG_ACNT: TcxGridDBColumn;
    cxGridDocs_RATE: TcxGridDBColumn;
    cxGridDocs_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridDocs_FLG_CLOSED: TcxGridDBColumn;
    cxGridDocs_BANKNAME: TcxGridDBColumn;
    cxGridDocs_BANKACCOUNT: TcxGridDBColumn;
    cxGridDocs_ACCOUNTNAME: TcxGridDBColumn;
    cxGridDocs_ACCOUNTNUMBER: TcxGridDBColumn;
    cxGridPopupMenuDocs: TcxGridPopupMenu;
    dxBarPopupMenuDocs: TdxBarPopupMenu;
    dxBarManager61: TdxBarManager;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    procedure cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete:Boolean;

    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;

    function DoCloseDocumentDB(const DocID:integer):Boolean;
    function DoOpenDocumentDB(const DocID:integer):Boolean;

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

{$R *.dfm}

uses System.UITypes, IBC, DataModuleAdditions, SWNSecurity, SWNSecurityFlags, frmOstatokDenegNaScetuDocDialog, DataModuleDB, SWNUtils, SWNConst,
  SWNDBErrors, SWNValueStorageUnit;

{ Tframe61OstatkiDenegNaScetu }

procedure Tframe61OstatkiDenegNaScetu.bbCloseDocClick(Sender: TObject);
var docID:Integer;
begin
     docID:=dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger;
     if (ShowAskDialog(cMSG_CLOSEDOC_TITLE,Format(cMSG_CLOSEDOC_TEXT,[docID]))=mrYes) and DoCloseDocumentDB(docID) then RefreshData;
end;

procedure Tframe61OstatkiDenegNaScetu.bbOpenDocClick(Sender: TObject);
var docID:Integer;
begin
     docID:=dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger;
     if (ShowAskDialog(cMSG_OPENDOC_TITLE,Format(cMSG_OPENDOC_TEXT,[docID]))=mrYes) and DoOpenDocumentDB(docID) then RefreshData;
end;

procedure Tframe61OstatkiDenegNaScetu.CreateNewRecord;
var dialog:TfrmOstatokDenegNaScetuDocDlg;
begin
     dialog:=TfrmOstatokDenegNaScetuDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=True;
        if dialog.ShowModal=mrOk then dmDB.IBCQueryDocs.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure Tframe61OstatkiDenegNaScetu.cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if (AButton=mbLeft)  then
     begin
          DoDocumentDoubleClick;
          AHandled:=True;
     end;
end;

procedure Tframe61OstatkiDenegNaScetu.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridDocs_FLG_CLOSED.Index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridDocs_FLG_CLOSED.Index] = 1 then
          begin
               ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
               if Not AViewInfo.Selected then ACanvas.Font.Color := clGrayText;
          end;
     end;

     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe61OstatkiDenegNaScetu.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     SWNUtils.ProcessCommonKeys(Self, cxGridDocsTable,Key,Shift);
end;

procedure Tframe61OstatkiDenegNaScetu.cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridDocs_DATA.Index]) then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridDocs_DATA.Index]);
end;

procedure Tframe61OstatkiDenegNaScetu.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format(cMSG_DELETERECORD_61,[dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]))=mrYes then
     begin
          dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
          try
             dmDB.IBCQueryDocs.Delete;
             dmDB.IBCQueryDocs.UpdateTransaction.Commit;
          except on E: Exception do
             begin
                  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

function Tframe61OstatkiDenegNaScetu.DoCloseDocumentDB(const DocID: integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_CLOSE_3036(:ID)';
        Query.ParamByName('ID').AsInteger:=DocID;
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

procedure Tframe61OstatkiDenegNaScetu.DocumentSelectionChanged;
var fAdd,fEdit,fDelete:Boolean;
    FLG_CLOSED:Boolean;
    fCloseDoc,fOpenDoc:Boolean;
begin
     fAdd:=fSECURITY_CanNew;
     fEdit:=False;
     fDelete:=False;
     fCloseDoc:=False;
     fOpenDoc:=False;

     if (cxGridDocsTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
          fEdit:=fSECURITY_CanEdit and Not FLG_CLOSED or fSECURITY_CanView;
          fDelete:=fSECURITY_CanDelete and Not FLG_CLOSED;
          fCloseDoc:=fSECURITY_CanEdit and Not FLG_CLOSED;
          fOpenDoc:=fSECURITY_CanEdit and FLG_CLOSED;
     end;

     ButtonStateChanged(fbtADD,fAdd);
     ButtonStateChanged(fbtMODIFY,fEdit);
     ButtonStateChanged(fbtDELETE,fDelete);

     bbCloseDoc.Enabled:=fCloseDoc;
     bbOpenDoc.Enabled:=fOpenDoc;
end;

procedure Tframe61OstatkiDenegNaScetu.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridDocsTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridDocsTable.DataController.DataSource:=nil;
end;

procedure Tframe61OstatkiDenegNaScetu.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridDocsTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
     cxGridDocsTable.OnFocusedRecordChanged:=WhenDocGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
     DocumentSelectionChanged;
end;

function Tframe61OstatkiDenegNaScetu.DoOpenDocumentDB(const DocID: integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_OPEN_3036(:ID)';
        Query.ParamByName('ID').AsInteger:=DocID;
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

function Tframe61OstatkiDenegNaScetu.GetCurrentSearchContext: TSearchContextValue;
begin
     if cxGridDocsTable.Site.Focused then
     begin
          // context from Docs
          if cxGridDocs_DATA.Focused then
          begin
               // Data
               Result.Context := ffDate;
               Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
          end;
     end;
end;

function Tframe61OstatkiDenegNaScetu.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe61OstatkiDenegNaScetu.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate];
end;

function Tframe61OstatkiDenegNaScetu.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_CanNew then Result:=Result+[fbtADD];
     if fSECURITY_CanDelete then Result:=Result+[fbtDELETE];
     if fSECURITY_CanView or fSECURITY_CanEdit then Result:=Result+[fbtMODIFY];
end;

function Tframe61OstatkiDenegNaScetu.InitFrameID: integer;
begin
     Result:=61; // Solduri bani in cont
end;

procedure Tframe61OstatkiDenegNaScetu.ModifyRecord;
var dialog:TfrmOstatokDenegNaScetuDocDlg;
    readOnly:Boolean;
begin
     if fSECURITY_CanEdit
       then readOnly:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1
       else readOnly:=fSECURITY_CanView;

     dialog:=TfrmOstatokDenegNaScetuDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=False;
        dialog.ReadOnly:=readOnly;
        if dialog.ShowModal=mrOk then dmDB.IBCQueryDocs.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure Tframe61OstatkiDenegNaScetu.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        ReadGridColumnsSettings(cxGridDocsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe61OstatkiDenegNaScetu.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        SaveGridColumnsSettings(cxGridDocsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe61OstatkiDenegNaScetu.SetupDefaultFocus;
begin
     // column
     cxGridDocs_BANKNAME.Focused:=True;
     // grid
     cxGridDocs.SetFocus;
end;

procedure Tframe61OstatkiDenegNaScetu.SetupSecurityItems;
begin
     // Solduri bani in cont
     fSECURITY_CanView:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ОДНС_Просмотр);
     fSECURITY_CanNew:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ОДНС_Создать);
     fSECURITY_CanEdit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ОДНС_Редактировать);
     fSECURITY_CanDelete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ОДНС_Удалить);

     if Not fSECURITY_CanEdit then
     begin
          bbCloseDoc.Visible:=ivNever;
          bbOpenDoc.Visible:=ivNever;
     end;
     if (dxBarPopupMenuDocs.ItemLinks.VisibleItemCount=0) then cxGridPopupMenuDocs.PopupMenus.Clear;
end;

procedure Tframe61OstatkiDenegNaScetu.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     DocumentSelectionChanged;
end;

end.
