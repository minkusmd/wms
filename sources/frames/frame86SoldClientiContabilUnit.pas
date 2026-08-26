
unit frame86SoldClientiContabilUnit;
{
  ОСТАТКИ. Сальдо контрагентов
  DocTypeID = 123
  Frame Index = 23
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxGraphics, DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxGridPopupMenu, dxBar, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  dxBarBuiltInMenu, cxClasses, cxGridCustomPopupMenu, cxGridTableView, dxUIAClasses;

type
  Tframe86SoldClientiContabil = class(TSWNBaseFrame)
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
    cxGridPopupMenuSK: TcxGridPopupMenu;
    dxBarManagerSK: TdxBarManager;
    bbSKCloseDoc: TdxBarButton;
    bbSKOpenDoc: TdxBarButton;
    cxGridSK_FLG_CLOSED: TcxGridDBColumn;
    bbDocComments: TdxBarButton;
    bbCustomerDebts: TdxBarButton;
    cxGridSK_CT: TcxGridDBColumn;
    dxBarPopupMenu1: TdxBarPopupMenu;
    procedure cxGridSKTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dxBarPopupMenuSKPopup(Sender: TObject);
    procedure bbSKCloseDocClick(Sender: TObject);
    procedure bbSKOpenDocClick(Sender: TObject);
    procedure cxGridSKTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridSKTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridSK_DATAGetDataText(Sender: TcxCustomGridTableItem; ARecordIndex: Integer;
      var AText: string);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure bbCustomerDebtsClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;

    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure PopupMenu_SK;

    procedure ChangeSKDocumentCloseFlag(const DocID, FLG_CLOSED:integer);
  protected
    { Protected declarations }
    function InitFrameID:integer;override;

    function GetExternalDataSourceTypes:TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;
    procedure WhenFilterDataChanged(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;

    procedure CreateNewRecord;override;
    procedure ModifyRecord;override;
    procedure DeleteRecord;override;

    function GetFrameButtons:TFrameButtons;override;
    function GetFilterFields:TFrameFilterFields;override;

    procedure SetupSecurityItems;override;
  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;



implementation

uses DataModuleDB, SWNUtils, SWNConst, SWNDBErrors, IBC, SWNSecurity, SWNSecurityFlags, frmSalidoKontragentaDocDialog;


{$R *.dfm}

{ Tframe23СальдоКонтрагентов }

procedure Tframe86SoldClientiContabil.bbCustomerDebtsClick(Sender: TObject);
begin
  dmdb.ShowCustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe86SoldClientiContabil.bbDocCommentsClick(Sender: TObject);
begin
     ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe86SoldClientiContabil.bbSKCloseDocClick(Sender: TObject);
begin
     if ShowAskDialog('Sold clienti contabilitate','Inchide document?')=mrYes then
     begin
          ChangeSKDocumentCloseFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger,1);
          dmDB.IBCQueryDocs.Refresh;
     end;
end;

procedure Tframe86SoldClientiContabil.bbSKOpenDocClick(Sender: TObject);
begin
     if ShowAskDialog('Sold clienti contabilitate','deschide document?')=mrYes then
     begin
          ChangeSKDocumentCloseFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger,0);
          dmDB.IBCQueryDocs.Refresh;
     end;
end;

procedure Tframe86SoldClientiContabil.ChangeSKDocumentCloseFlag(const DocID, FLG_CLOSED: integer);
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        try
           Query.Transaction.StartTransaction;
           Query.SQL.Text:='EXECUTE PROCEDURE SP_DOC_OPEN_CLOSE_SK(:DOCID,:FLG_CLOSED)';
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

procedure Tframe86SoldClientiContabil.CreateNewRecord;
var dialog:TfrmSalidoKontragentaDocDlg;
begin
     dialog:=TfrmSalidoKontragentaDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe86SoldClientiContabil.cxGridSKTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if AButton=mbLeft then
     begin
          DoDocumentDoubleClick;
          AHandled:=True;
     end;
end;

procedure Tframe86SoldClientiContabil.cxGridSKTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if Not VarIsNull(AViewInfo.GridRecord.Values[cxGridSK_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridSK_FLG_CLOSED.index]=1 then
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    if AViewInfo.GridRecord.Values[cxGridSK_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
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

procedure Tframe86SoldClientiContabil.cxGridSKTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     SWNUtils.ProcessCommonKeys(Self, cxGridSKTable,Key,Shift);
end;

procedure Tframe86SoldClientiContabil.cxGridSK_DATAGetDataText(Sender: TcxCustomGridTableItem;
  ARecordIndex: Integer; var AText: string);
begin
     if Not VarIsNull(cxGridSKTable.DataController.Values[ARecordIndex,cxGridSK_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',cxGridSKTable.DataController.Values[ARecordIndex,cxGridSK_DATA.Index]);
end;

procedure Tframe86SoldClientiContabil.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format('Sterge inregistrarea nr. %d?',[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))=mrYes then
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

procedure Tframe86SoldClientiContabil.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridSKTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridSKTable.DataController.DataSource:=nil;

     inherited;
end;

procedure Tframe86SoldClientiContabil.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
var customDataFilter:TFrameDataFilteringInfo;
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridSKTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
     cxGridSKTable.OnFocusedRecordChanged:=WhenGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     if SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Администратор) then OpenExternalData(FrameDataFilterInfo)
     else
     begin
          customDataFilter:=FrameDataFilterInfo.Clone;
          try
             customDataFilter.FilterByCurrentUser:=True;
             OpenExternalData(customDataFilter);
          finally
             customDataFilter.Free;
          end;
     end;

     // 4. Selection update
     SelectionChanged;
end;

procedure Tframe86SoldClientiContabil.dxBarPopupMenuSKPopup(Sender: TObject);
begin
     PopupMenu_SK;
end;

function Tframe86SoldClientiContabil.GetCurrentSearchContext: TSearchContextValue;
begin
     Result := Inherited;

     if cxGridSKTable.Site.Focused then
     begin
          // context from Docs
          if cxGridSK_CT_NAME.Focused then
          begin
               // Контрагент
               Result.Context := ffCustomer;
               Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
               Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
          end
          else
              if cxGridSK_DATA.Focused then
              begin
                   // Дата
                   Result.Context := ffDate;
                   Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
              end
     end
end;

function Tframe86SoldClientiContabil.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe86SoldClientiContabil.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffCustomer];
end;

function Tframe86SoldClientiContabil.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_CanNew then Result:=Result+[fbtADD];
     if fSECURITY_CanEdit or fSECURITY_CanView then Result:=Result+[fbtMODIFY];
     if fSECURITY_CanDelete then Result:=Result+[fbtDELETE];
end;

function Tframe86SoldClientiContabil.InitFrameID: integer;
begin
     // ОСТАТКИ. Сальдо контрагентов по бухгалтерии
     Result:=86;
end;

procedure Tframe86SoldClientiContabil.ModifyRecord;
var dialog:TfrmSalidoKontragentaDocDlg;
    ReadOnly:Boolean;
begin
     if Not (fSECURITY_CanEdit or fSECURITY_CanView) then Exit;

     if fSECURITY_CanEdit
       then ReadOnly:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1
       else ReadOnly:=fSECURITY_CanView;

     dialog:=TfrmSalidoKontragentaDocDlg.Create(Self);
     try
        dialog.CreateNewDocument:=False;
        dialog.ReadOnly:=ReadOnly;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe86SoldClientiContabil.PopupMenu_SK;
begin
     bbDocComments.Enabled:=fSECURITY_CanEdit;
end;

procedure Tframe86SoldClientiContabil.SelectionChanged;
var fDocNew,fDocEdit,fDocDelete:Boolean;
    FLG_CLOSED:Boolean;
    fCanClose,fCanOpen:Boolean;
begin
     fDocNew:=fSECURITY_CanNew;
     fDocEdit:=False;
     fDocDelete:=False;

     fCanClose:=False;
     fCanOpen:=False;

     if (cxGridSKTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fDocEdit:=fSECURITY_CanEdit and Not FLG_CLOSED or fSECURITY_CanView;   // Edit
          fDocDelete:=fSECURITY_CanDelete and Not FLG_CLOSED; // Delete

          fCanClose:=Not FLG_CLOSED;
          fCanOpen:=FLG_CLOSED;
     end;
     // doc
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);

     // popup
     bbSKCloseDoc.Enabled:=fCanClose;
     bbSKOpenDoc.Enabled:=fCanOpen;
end;

procedure Tframe86SoldClientiContabil.SetupDefaultFocus;
begin
     // grid
     cxGridSK.SetFocus;
     // columns
     cxGridSK_CT_NAME.Focused:=True;
end;

procedure Tframe86SoldClientiContabil.SetupSecurityItems;
begin
     fSECURITY_CanView:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SOLDURI_SCC_Vizializare);
     fSECURITY_CanNew:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SOLDURI_SCC_Inregistrarea_noua);
     fSECURITY_CanEdit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SOLDURI_SCC_Modifica_inregistrarea);
     fSECURITY_CanDelete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SOLDURI_SCC_Sterge_inregistrarea);

     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SOLDURI_SCC_Inchide_documentul) then bbSKCloseDoc.Visible:=ivNever;
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SOLDURI_SCC_Deschide_documentul) then bbSKOpenDoc.Visible:=ivNever;
end;

procedure Tframe86SoldClientiContabil.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var customDataFilter:TFrameDataFilteringInfo;
begin
     if (SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Администратор) or SWNSecurityManager.UserIsPartOfGroup(cUserGroup_ADM_Aprovizionari))  then inherited WhenFilterDataChanged(FrameDataFilterInfo)
     else
     begin
          customDataFilter:=FrameDataFilterInfo.Clone;
          try
             customDataFilter.FilterByCurrentUser:=True;
             inherited WhenFilterDataChanged(customDataFilter);
          finally
             customDataFilter.Free;
          end;
     end;
end;

procedure Tframe86SoldClientiContabil.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

end.
