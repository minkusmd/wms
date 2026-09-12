unit frame04BankPDNSUnit;

// OPERATIUNI BANCARE. Incasare bani in cont
// DocTypeID = 120
// Frame Index = 4

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes,
  Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGridCustomView, cxGrid,
  dxBar, cxGridPopupMenu, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  dxBarBuiltInMenu, cxClasses, cxGridCustomPopupMenu, cxGridTableView, dxUIAClasses;

type
  Tframe04BankPDNS = class(TSWNBaseFrame)
    cxGridBankPDNS: TcxGrid;
    cxGridBankPDNSTable: TcxGridDBTableView;
    cxGridBankPDNSTableDocID: TcxGridDBColumn;
    cxGridBankPDNS_DATA: TcxGridDBColumn;
    cxGridBankPDNSTableCtName: TcxGridDBColumn;
    cxGridBankPDNSTableSuma: TcxGridDBColumn;
    cxGridBankPDNSTableVAT: TcxGridDBColumn;
    cxGridBankPDNSTableCurrencyName: TcxGridDBColumn;
    cxGridBankPDNSTableRate: TcxGridDBColumn;
    cxGridBankPDNSTableParentDocID: TcxGridDBColumn;
    cxGridBankPDNSTableFlgACNT: TcxGridDBColumn;
    cxGridBankPDNSTableCreatedBy: TcxGridDBColumn;
    cxGridBankPDNSLevel1: TcxGridLevel;
    cxGridBankPDNS_FLG_CLOSED: TcxGridDBColumn;
    cxGridPopupMenu1: TcxGridPopupMenu;
    dxBarManager1: TdxBarManager;
    bbProvesti: TdxBarButton;
    bbCancelProvodca: TdxBarButton;
    cxGridBankPDNS_RATEUSD: TcxGridDBColumn;
    bbGotoParentDoc: TdxBarButton;
    bbDocComments: TdxBarButton;
    cxGridBankPDNS_CT: TcxGridDBColumn;
    bbCustomerDebts: TdxBarButton;
    cxGridBankPDNS_DTSC_NAME: TcxGridDBColumn;
    dxBarPopupMenu1: TdxBarPopupMenu;
    cxGridBankPDNS_SC2_NAME: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    bbDistribuireRamburs: TdxBarButton;
    cxGridBankPDNSTableCREATED_DATE: TcxGridDBColumn;
    procedure cxGridBankPDNSTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridBankPDNSTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarPopupMenu1Popup(Sender: TObject);
    procedure bbProvestiClick(Sender: TObject);
    procedure bbCancelProvodcaClick(Sender: TObject);
    procedure cxGridBankPDNSTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridBankPDNS_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbDistribuireRambursClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView,
    fSECURITY_CanNew,
    fSECURITY_CanEdit,
    fSECURITY_CanDelete:Boolean;

    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure PopupForSelection;

    procedure DoAction_Provesti;
    procedure DoAction_CancelProvodca;

    procedure ShowCustomerDebts;
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

    procedure DoCloseDocument(const DocID: Integer); override;
    procedure DoOpenDocument(const DocID: Integer); override;

    public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext:TSearchContextValue;override;
  end;



implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, frmBankPDNSDialog, SWNDBErrors, SWNValueStorageUnit,
  SWNSecurity, SWNSecurityFlags, frmCustomerCurrentDebtsDialog,
  uSelectDateDialog, IBC, frmDistributieRambursDialog;

{$R *.dfm}

{ Tframe04BankPDNS }

procedure Tframe04BankPDNS.bbCancelProvodcaClick(Sender: TObject);
begin
     DoAction_CancelProvodca;
end;

procedure Tframe04BankPDNS.bbCustomerDebtsClick(Sender: TObject);
begin
     ShowCustomerDebts;
end;

procedure Tframe04BankPDNS.bbDistribuireRambursClick(Sender: TObject);
begin
    try
        if SWNUtils.ShowAskDialog('Distribuirea ramburs, credit.', 'Doriti sa creati discifrarea pe Ramburs sau Credit ?')=mrYes then
        begin
            dmdb.ExecuteQuery('execute procedure sp_create_distribuire_ramburs(:docid)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
            SWNUtils.ShowInfoDialog('Distributie ramburs', 'Documentul a fost creat cu succes!');
        end;
    except on E: Exception do
        raise;
    end;
end;

procedure Tframe04BankPDNS.bbDocCommentsClick(Sender: TObject);
begin
     ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe04BankPDNS.bbGotoParentDocClick(Sender: TObject);
begin
     FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe04BankPDNS.bbProvestiClick(Sender: TObject);
begin
     DoAction_Provesti;
end;

procedure Tframe04BankPDNS.CreateNewRecord;
var editor:TfrmBankPDNSDlg;
begin
     editor:=TfrmBankPDNSDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
     try
        editor.CreateNewDocument:=True;
        editor.DocTypeID := dmdb.CurrentDocTypeID;
        editor.ShowModal;
     finally
        editor.Free;
     end;
end;

procedure Tframe04BankPDNS.cxGridBankPDNSTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if (AButton=mbLeft) then
     begin
          DoDocumentDoubleClick;
          AHandled:=True;
     end;
end;

procedure Tframe04BankPDNS.cxGridBankPDNSTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridBankPDNS_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridBankPDNS_FLG_CLOSED.index]=0 then
          begin
//               if Not AViewInfo.Selected then
//               begin
//                    // Document prin contabilitate
//                    if AViewInfo.GridRecord.Values[cxGridBankPDNSTableFlgACNT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
//               end;
          end
          else
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
//               if Not AViewInfo.Selected then
//               begin
//                if AViewInfo.GridRecord.Values[cxGridBankPDNSTableFlgACNT.Index]=1 then ACanvas.Font.Color:=clRed
//                    else ACanvas.Font.Color:=clGrayText;
//               end;
          end;
     end;

//     // highlight selected row
//     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
//     begin
//          ACanvas.Brush.Color:=$E8E8E8;
//     end;
end;

procedure Tframe04BankPDNS.cxGridBankPDNS_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridBankPDNS_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridBankPDNS_DATA.Index]);
end;

procedure Tframe04BankPDNS.cxGridBankPDNSTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self,cxGridBankPDNSTable,Key,Shift);
end;

procedure Tframe04BankPDNS.DeleteRecord;
begin
     if (dmDB.IBCQueryDocs.RecordCount=0) then exit;
     
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format(cMSG_DELETERECORD_БАНК_ПДНС,[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))=mrYes then
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

procedure Tframe04BankPDNS.DoAction_CancelProvodca;
begin
     if ShowAskDialog('Ordin de incasare','Deschide documentul?')=mrYes then
     begin
          if dmDB.CancelDocumentProvodka(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger)
            then dmDB.IBCQueryDocs.Refresh;
     end;
end;

procedure Tframe04BankPDNS.DoAction_Provesti;
begin
     if ShowAskDialog('Ordin de incasare','Inchide documentul?')=mrYes then
     begin
          if dmDB.CreateDocumentProvodka(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger)
            then dmDB.IBCQueryDocs.Refresh;
     end;
end;

procedure Tframe04BankPDNS.DoCloseDocument(const DocID: Integer);
begin
  DoAction_Provesti;
end;

procedure Tframe04BankPDNS.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridBankPDNSTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridBankPDNSTable.DataController.DataSource:=nil;

     inherited;
end;

procedure Tframe04BankPDNS.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridBankPDNSTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
     cxGridBankPDNSTable.OnFocusedRecordChanged:=WhenGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
     SelectionChanged;
end;

procedure Tframe04BankPDNS.DoOpenDocument(const DocID: Integer);
begin
  DoAction_CancelProvodca
end;

procedure Tframe04BankPDNS.dxBarButton1Click(Sender: TObject);
var
  DataDoc: TDate;
  Query: TIBCQuery;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
      DataDoc := AppUserConfigStorage.DateTimeValues.GetValue('DocumentDate', dmdb.IBCQueryDocs.FieldByName('DATA').AsDateTime);
    finally
        AppUserConfigStorage.CloseSection;
    end;

  if DateInputDialog(DataDoc) then
  begin
    try
      Query := TIBCQuery.Create(Self);
      Query.Transaction := dmDB.IBCTrDefaultUpdate;
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_RAMBURS(:DOCID, :DATA)';
      Query.ParamByName('DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
      Query.ParamByName('DATA').AsDate := DataDoc;
      Query.ExecSQL;

      if Query.Transaction.Active then
        Query.Transaction.Commit;
    finally
      Query.Free;
    end;

    dmDB.IBCQueryDocs.Refresh;
  end;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
      AppUserConfigStorage.DateTimeValues.SetValue('DocumentDate', DataDoc);
  finally
      AppUserConfigStorage.CloseSection;
  end;

end;

procedure Tframe04BankPDNS.dxBarPopupMenu1Popup(Sender: TObject);
begin
     PopupForSelection;
end;

function Tframe04BankPDNS.GetCurrentSearchContext: TSearchContextValue;
begin
     Result:=Inherited;

     if cxGridBankPDNSTable.Site.Focused then
     begin
          // context from Docs
          if cxGridBankPDNSTableCtName.Focused then
          begin
               // Primit de la
               Result.Context:=ffCustomer;
               Result.ValueInt:=dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
               Result.ValueStr:=dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
          end
          else
          if cxGridBankPDNS_DATA.Focused then
          begin
               // Data
               Result.Context:=ffDate;
               Result.ValueDateTime:=dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
          end
     end
end;

function Tframe04BankPDNS.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe04BankPDNS.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffCustomer];
end;

function Tframe04BankPDNS.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_CanNew then Result:=Result+[fbtADD];
     if fSECURITY_CanEdit or fSECURITY_CanView then Result:=Result+[fbtMODIFY];
     if fSECURITY_CanDelete then Result:=Result+[fbtDELETE];
end;

function Tframe04BankPDNS.InitFrameID: integer;
begin
     // BANCA. Incasare bani in cont
     Result:=4;
end;

procedure Tframe04BankPDNS.ModifyRecord;
var editor:TfrmBankPDNSDlg;
    FLG_CLOSED:Boolean;
    ReadOnly:Boolean;
begin
     if Not (fSECURITY_CanEdit or fSECURITY_CanView) then Exit;

     FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
     if fSECURITY_CanEdit then ReadOnly:=FLG_CLOSED
                          else ReadOnly:=fSECURITY_CanView;


     editor:=TfrmBankPDNSDlg.Create(Self, dmdb.IBCQueryDocs, dmdb.IBCDataSourceDocs);
     try
        editor.CreateNewDocument:=False;
        editor.ReadOnly:=ReadOnly;
        editor.DocTypeID := dmdb.CurrentDocTypeID;
        editor.ShowModal;
     finally
        editor.Free;
     end;
end;

procedure Tframe04BankPDNS.PopupForSelection;
begin
     bbGotoParentDoc.Enabled:=Not dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').IsNull;
     bbDocComments.Enabled:=fSECURITY_CanEdit;
end;

procedure Tframe04BankPDNS.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        ReadGridColumnsSettings(cxGridBankPDNSTable);
     finally
       AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe04BankPDNS.SaveFrameStates;
begin
     if SWNSecurityManager.IsPartialAccessMode then Exit;

     AppUserConfigStorage.OpenSection(Self.Name);
     try
        SaveGridColumnsSettings(cxGridBankPDNSTable);
     finally
       AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe04BankPDNS.SelectionChanged;
var fDocNew,fDocEdit,fDocDelete:Boolean;
    FLG_CLOSED:Boolean;
    fCloseDoc,fOpenDoc:Boolean;
begin
     fDocNew:=fSECURITY_CanNew;
     fDocEdit:=False;
     fDocDelete:=False;

     fCloseDoc:=False;
     fOpenDoc:=False;

     if cxGridBankPDNSTable.DataController.RecNo>0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fDocEdit:=fSECURITY_CanEdit and Not FLG_CLOSED or fSECURITY_CanView;
          fDocDelete:=fSECURITY_CanDelete and Not FLG_CLOSED;

          fCloseDoc:=Not FLG_CLOSED;
          fOpenDoc:=FLG_CLOSED;
     end;

     // doc
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);

     // popup
     bbProvesti.Enabled:=fCloseDoc;
     bbCancelProvodca.Enabled:=fOpenDoc;



end;

procedure Tframe04BankPDNS.SetupDefaultFocus;
begin
     // grid
     cxGridBankPDNS.SetFocus;
     // columns
     cxGridBankPDNSTableCtName.Focused:=True;
end;

procedure Tframe04BankPDNS.SetupSecurityItems;
begin
     fSECURITY_CanView:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНС_Просмотр);
     fSECURITY_CanNew:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНС_Создать);
     fSECURITY_CanEdit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНС_Изменить);
     fSECURITY_CanDelete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНС_Удалить);

     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНС_Закрыть_документ) then bbProvesti.Visible:=ivNever;
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНС_Открыть_документ) then bbCancelProvodca.Visible:=ivNever;

     if SWNSecurityManager.IsPartialAccessMode then
     begin
          bbCustomerDebts.Visible:=ivNever;
          cxGridBankPDNSTableFlgACNT.Visible:=False;
          cxGridBankPDNSTableFlgACNT.VisibleForCustomization:=False;
     end;
end;

procedure Tframe04BankPDNS.ShowCustomerDebts;
var dialog:TfrmCustomerCurrentDebtsDlg;
begin
     dialog:=TfrmCustomerCurrentDebtsDlg.Create(Self);
     try
        dialog.CustomerID:=dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe04BankPDNS.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

end.
