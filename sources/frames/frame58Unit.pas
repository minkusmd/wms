unit frame58Unit;
{
  КАССОВЫЕ ОПЕРАЦИИ. Корректировка кассы
  DocTypeID = 2003
  Frame Index = 58
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit,
  cxLabel, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxControls, cxGridCustomView,
  cxGrid, cxLookAndFeels, cxLookAndFeelPainters, dxBar, cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  Tframe58 = class(TSWNBaseFrame)
    cxGridKBP: TcxGrid;
    cxGridKBPTable: TcxGridDBTableView;
    cxGridKBPTableDocID: TcxGridDBColumn;
    cxGridKBP_DATA: TcxGridDBColumn;
    cxGridKBPTableSuma: TcxGridDBColumn;
    cxGridKBPTableVAT: TcxGridDBColumn;
    cxGridKBPTableCurrencyName: TcxGridDBColumn;
    cxGridKBPTableRate: TcxGridDBColumn;
    cxGridKBPTableParentDocID: TcxGridDBColumn;
    cxGridKBP_FLG_ACNT: TcxGridDBColumn;
    cxGridKBPTableCreatedBy: TcxGridDBColumn;
    cxGridKBPLevel: TcxGridLevel;
    dxBarManagerKBP: TdxBarManager;
    cxGridCasaRKO_RATEUSD: TcxGridDBColumn;
    cxGridPopupMenu: TcxGridPopupMenu;
    cxGridKBP_DT_NAME: TcxGridDBColumn;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bbDocComments: TdxBarButton;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    cxGridKBP_FLG_CLOSED: TcxGridDBColumn;
    procedure cxGridKBPTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridKBPTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridKBPTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure cxGridKBP_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private
    { Private declarations }
    fSYS_Add,fSYS_Edit,fSYS_View,fSYS_Delete:Boolean;
    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;

    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID:integer):Boolean;
    procedure DoOpenDocument;
    function DoOpenDocumentDB(const DocID:integer):Boolean;

  protected
    { Protected declarations }
    function InitFrameID:integer;override;

    function GetExternalDataSourceTypes:TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;

    function GetFrameButtons:TFrameButtons;override;
    function GetFilterFields:TFrameFilterFields;override;

    procedure CreateNewRecord;override;
    procedure ModifyRecord;override;
    procedure DeleteRecord;override;

    procedure ReadFrameStates;override;
    procedure SaveFrameStates;override;

    procedure SetupSecurityItems;override;
  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext:TSearchContextValue;override;
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, IBC,
     DateUtils, SWNValueStorageUnit, frmCustomerCurrentDebtsDialog, SWNSecurity, frmKBPDocDialog,
  SWNSecurityFlags, frm58DocDialog;

{$R *.dfm}

{ TTframeCasa02RKO }

procedure Tframe58.bbCloseDocClick(Sender: TObject);
begin
     DoCloseDocument;
end;

procedure Tframe58.bbDocCommentsClick(Sender: TObject);
begin
     ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe58.bbOpenDocClick(Sender: TObject);
begin
     DoOpenDocument;
end;

procedure Tframe58.CreateNewRecord;
var dialog:Tfrm58DocDlg;
begin
     dialog:=Tfrm58DocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe58.cxGridKBPTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if AButton=mbLeft then
     begin
          DoDocumentDoubleClick;
          AHandled:=True;
     end;
end;

procedure Tframe58.cxGridKBPTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridKBP_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridKBP_FLG_CLOSED.index]=0 then
          begin
               if Not AViewInfo.Selected then
               begin
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGridKBP_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
               end;
          end
          else
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    if AViewInfo.GridRecord.Values[cxGridKBP_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
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

procedure Tframe58.cxGridKBPTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     SWNUtils.ProcessCommonKeys(Self, cxGridKBPTable,Key,Shift);
end;

procedure Tframe58.cxGridKBP_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridKBP_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridKBP_DATA.Index]);
end;

procedure Tframe58.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format(cMSG_DELETERECORD_48,[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))=mrYes then
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

procedure Tframe58.DoCloseDocument;
begin
     if ShowAskDialog('Закрыть документ','Вы хотите закрыть документ?')=mrYes then
     begin
          if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then dmDB.IBCQueryDocs.Refresh;
     end;
end;

function Tframe58.DoCloseDocumentDB(const DocID: integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_CLOSE_2003(:DOCID)';
        Query.ParamByName('DOCID').AsInteger:=DocID;
        try
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

procedure Tframe58.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridKBPTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridKBPTable.DataController.DataSource:=nil;

     inherited;
end;

procedure Tframe58.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridKBPTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
     cxGridKBPTable.OnFocusedRecordChanged:=WhenGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
     SelectionChanged;
end;

procedure Tframe58.DoOpenDocument;
begin
     if ShowAskDialog('Открыть документ','Вы хотите открыть документ?')=mrYes then
     begin
          if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then dmDB.IBCQueryDocs.Refresh;
     end;
end;

function Tframe58.DoOpenDocumentDB(const DocID: integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_OPEN_2003(:DOCID)';
        Query.ParamByName('DOCID').AsInteger:=DocID;
        try
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

function Tframe58.GetCurrentSearchContext: TSearchContextValue;
begin
     Result:=Inherited;

     if cxGridKBPTable.Site.Focused then
     begin
          // context from Docs
          if cxGridKBP_DATA.Focused then
          begin
               Result.Context:=ffDate;
               Result.ValueDateTime:=dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
          end
     end
end;

function Tframe58.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe58.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate];
end;

function Tframe58.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSYS_Add then Result:=Result+[fbtADD];
     if fSYS_Edit or fSYS_View then Result:=Result+[fbtMODIFY];
     if fSYS_Delete then Result:=Result+[fbtDELETE];
end;

function Tframe58.InitFrameID: integer;
begin
     // Корректировка кассы
     Result:=58;
end;

procedure Tframe58.ModifyRecord;
var dialog:Tfrm58DocDlg;
    ReadOnly:Boolean;
begin
     if Not (fSYS_Edit or fSYS_View) then Exit;
     if fSYS_Edit
       then ReadOnly:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1
       else ReadOnly:=fSYS_View;

     dialog:=Tfrm58DocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=False;
        dialog.ReadOnly:=ReadOnly;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe58.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        ReadGridColumnsSettings(cxGridKBPTable);
     finally
       AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe58.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        SaveGridColumnsSettings(cxGridKBPTable);
     finally
       AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe58.SelectionChanged;
var fDocNew,fDocEdit,fDocDelete:Boolean;
    FLG_CLOSED:Boolean;
    fCloseDoc,fOpenDoc,fDocComments:Boolean;
begin
     fDocNew:=fSYS_Add;     // New document + Security
     fDocEdit:=False;
     fDocDelete:=False;

     fCloseDoc:=False;
     fOpenDoc:=False;
     fDocComments:=False;

     if cxGridKBPTable.DataController.RecNo>0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fDocEdit:=fSYS_Edit and Not FLG_CLOSED or fSYS_View;   // Edit document + Security
          fDocDelete:=fSYS_Delete and Not FLG_CLOSED; // Delete document + Security

          fCloseDoc:=Not FLG_CLOSED;
          fOpenDoc:=FLG_CLOSED;
          fDocComments:=fSYS_Edit;
     end;
     // doc
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);

     // popup
     bbCloseDoc.Enabled:=fCloseDoc;
     bbOpenDoc.Enabled:=fOpenDoc;
     bbDocComments.Enabled:=fDocComments;

end;

procedure Tframe58.SetupDefaultFocus;
begin
     // set focus to Doc Grid
     cxGridKBP.SetFocus;
     // column
     cxGridKBP_DT_NAME.Focused:=True;
end;

procedure Tframe58.SetupSecurityItems;
begin
     fSYS_Add:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_КК_Создать);
     fSYS_Edit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_КК_Изменить);
     fSYS_View:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_КК_Просмотр);
     fSYS_Delete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_КК_Удалить);

     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_КК_Закрыть_документ) then bbCloseDoc.Visible:=ivNever;
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_КК_Открыть_документ) then bbOpenDoc.Visible:=ivNever;
end;

procedure Tframe58.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

end.
