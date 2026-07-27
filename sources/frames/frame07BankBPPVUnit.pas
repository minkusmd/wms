unit frame07BankBPPVUnit;

// БАНКОВСКИЕ ОПЕРАЦИИ. Банковские платежные поручения, Валюта
// DocTypeID = 1199
// Frame Index = 7

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes,
  Dialogs, SWNDataFiltering, SWNBaseFrameUnit,
  cxGraphics, DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGridCustomView, cxGrid,
  dxBar, cxGridPopupMenu, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxClasses, cxGridTableView, dxUIAClasses;

type
  Tframe07BankBPPV = class(TSWNBaseFrame)
    cxGridBankBPPV: TcxGrid;
    cxGridBankBPPVDBTable: TcxGridDBTableView;
    cxGridBankBPPVDBTableDocID: TcxGridDBColumn;
    cxGridBankBPPV_DATA: TcxGridDBColumn;
    cxGridBankBPPVDBTableCtName: TcxGridDBColumn;
    cxGridBankBPPVDBTableSuma: TcxGridDBColumn;
    cxGridBankBPPVDBTableCurrencyName: TcxGridDBColumn;
    cxGridBankBPPVDBTableVAT: TcxGridDBColumn;
    cxGridBankBPPVDBTableRate: TcxGridDBColumn;
    cxGridBankBPPVDBTableParentDocID: TcxGridDBColumn;
    cxGridBankBPPV_FLG_ACNT: TcxGridDBColumn;
    cxGridBankBPPVDBTableCreatedBy: TcxGridDBColumn;
    cxGridBankBPPVLevel1: TcxGridLevel;
    cxGridBankBPPV_FLG_CLOSED: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    cxGridPopupMenu1: TcxGridPopupMenu;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bbProvesti: TdxBarButton;
    bbCancelProvodca: TdxBarButton;
    cxGridBankBPPV_RATEUSD: TcxGridDBColumn;
    bbDocComments: TdxBarButton;
    dxBarButton1: TdxBarButton;
    procedure cxGridBankBPPVDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridBankBPPVDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbProvestiClick(Sender: TObject);
    procedure bbCancelProvodcaClick(Sender: TObject);
    procedure cxGridBankBPPVDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridBankBPPV_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView,
    fSECURITY_CanNew,
    fSECURITY_CanEdit,
    fSECURITY_CanDelete:Boolean;

    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;

    procedure DoAction_Provesti;
    procedure DoAction_CancelProvodca;
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

uses SWNUtils, SWNConst, DataModuleDB, DataModuleAdditions, SWNDBErrors, SWNValueStorageUnit,
  SWNSecurity, SWNSecurityFlags, frmBankBPPVDialog;

{$R *.dfm}

{ Tframe07BankBPPV }

procedure Tframe07BankBPPV.bbCancelProvodcaClick(Sender: TObject);
begin
     DoAction_CancelProvodca;
end;

procedure Tframe07BankBPPV.bbDocCommentsClick(Sender: TObject);
begin
     ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe07BankBPPV.bbProvestiClick(Sender: TObject);
begin
     DoAction_Provesti;
end;

procedure Tframe07BankBPPV.CreateNewRecord;
var dialog:TfrmBankBPPVDlg;
begin
     dialog:=TfrmBankBPPVDlg.Create(Self);
     try
        dialog.CreateNewDocument:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe07BankBPPV.cxGridBankBPPVDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if (AButton=mbLeft) then
     begin
          DoDocumentDoubleClick;
          AHandled:=True;
     end;
end;

procedure Tframe07BankBPPV.cxGridBankBPPVDBTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridBankBPPV_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridBankBPPV_FLG_CLOSED.index]=0 then
          begin
               if Not AViewInfo.Selected then
               begin
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGridBankBPPV_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
               end;
          end
          else
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    if AViewInfo.GridRecord.Values[cxGridBankBPPV_FLG_ACNT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
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

procedure Tframe07BankBPPV.cxGridBankBPPVDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self, cxGridBankBPPVDBTable,Key,Shift);
end;

procedure Tframe07BankBPPV.cxGridBankBPPV_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridBankBPPV_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridBankBPPV_DATA.Index]);
end;

procedure Tframe07BankBPPV.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format('Sterge inregistrarea %d?',[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))=mrYes then
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

procedure Tframe07BankBPPV.DoAction_CancelProvodca;
begin
     if ShowAskDialog('Transactie','Anularea validarii documentului?')=mrYes then
     begin
          if dmDB.CancelDocumentProvodka(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger)
            then dmDB.IBCQueryDocs.Refresh;
     end;
end;

procedure Tframe07BankBPPV.DoAction_Provesti;
begin
     if ShowAskDialog('Transactie','Validarea documentului?')=mrYes then
     begin
          if dmDB.CreateDocumentProvodka(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger)
            then dmDB.IBCQueryDocs.Refresh;
     end;
end;

procedure Tframe07BankBPPV.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridBankBPPVDBTable.OnFocusedRecordChanged:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridBankBPPVDBTable.DataController.DataSource:=nil;

     inherited;
end;

procedure Tframe07BankBPPV.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridBankBPPVDBTable.DataController.DataSource:=dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
     cxGridBankBPPVDBTable.OnFocusedRecordChanged:=WhenDocGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
     SelectionChanged;
end;

procedure Tframe07BankBPPV.dxBarButton1Click(Sender: TObject);
begin
   FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

function Tframe07BankBPPV.GetCurrentSearchContext: TSearchContextValue;
begin
     Result:=Inherited;

     if cxGridBankBPPVDBTable.Site.Focused then
     begin
          // context from Docs
          if cxGridBankBPPVDBTableCtName.Focused then
          begin
               // Получатель
               Result.Context:=ffCustomer;
               Result.ValueInt:=dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
               Result.ValueStr:=dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
          end
          else
          if cxGridBankBPPV_DATA.Focused then
          begin
               // Дата
               Result.Context:=ffDate;
               Result.ValueDateTime:=dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
          end
     end
end;

function Tframe07BankBPPV.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe07BankBPPV.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffCustomer];
end;

function Tframe07BankBPPV.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_CanNew then Result:=Result+[fbtADD,fbtCLONE];
     if fSECURITY_CanEdit or fSECURITY_CanView then Result:=Result+[fbtMODIFY];
     if fSECURITY_CanDelete then Result:=Result+[fbtDELETE];
end;

function Tframe07BankBPPV.InitFrameID: integer;
begin
     // БАНКОВСКИЕ ОПЕРАЦИИ. Банковские платежные поручения, Валюта
     Result:=7;
end;

procedure Tframe07BankBPPV.ModifyRecord;
var dialog:TfrmBankBPPVDlg;
    FLG_CLOSED, ReadOnly:Boolean;
begin
     if Not (fSECURITY_CanEdit or fSECURITY_CanView) then Exit;

     FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
     if fSECURITY_CanEdit then ReadOnly:=FLG_CLOSED
                          else ReadOnly:=fSECURITY_CanView;

     dialog:=TfrmBankBPPVDlg.Create(Self);
     try
        dialog.CreateNewDocument:=False;
        dialog.ReadOnly:=ReadOnly;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe07BankBPPV.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        ReadGridColumnsSettings(cxGridBankBPPVDBTable);
     finally
       AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe07BankBPPV.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        SaveGridColumnsSettings(cxGridBankBPPVDBTable);
     finally
       AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe07BankBPPV.SelectionChanged;
var fDocNew,fDocEdit,fDocDelete:Boolean;
    FLG_CLOSED:Boolean;
    fCloseDoc,fOpenDoc,fDocComments:Boolean;
begin
     fDocNew:=fSECURITY_CanNew;
     fDocEdit:=False;
     fDocDelete:=False;

     fCloseDoc:=False;
     fOpenDoc:=False;
     fDocComments:=False;

     if cxGridBankBPPVDBTable.DataController.RecNo>0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fDocEdit:=fSECURITY_CanEdit and Not FLG_CLOSED or fSECURITY_CanView;
          fDocDelete:=fSECURITY_CanDelete and Not FLG_CLOSED;
          fCloseDoc:=Not FLG_CLOSED;
          fOpenDoc:=FLG_CLOSED;
          fDocComments:=fSECURITY_CanEdit;
     end;

     // doc
     ButtonStateChanged(fbtADD,fDocNew);
     ButtonStateChanged(fbtMODIFY,fDocEdit);
     ButtonStateChanged(fbtDELETE,fDocDelete);

     // popup
     bbProvesti.Enabled:=fCloseDoc;
     bbCancelProvodca.Enabled:=fOpenDoc;
     bbDocComments.Enabled:=fDocComments;

end;

procedure Tframe07BankBPPV.SetupDefaultFocus;
begin
     // grid
     cxGridBankBPPV.SetFocus;
     // columns
     cxGridBankBPPVDBTableCtName.Focused:=True;
end;

procedure Tframe07BankBPPV.SetupSecurityItems;
begin
     fSECURITY_CanView:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППВ_Просмотр);
     fSECURITY_CanNew:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППВ_Создать);
     fSECURITY_CanEdit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППВ_Изменить);
     fSECURITY_CanDelete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППВ_Удалить);

     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППВ_Закрыть_документ) then bbProvesti.Visible:=ivNever;
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППВ_Открыть_документ) then bbCancelProvodca.Visible:=ivNever;
end;

procedure Tframe07BankBPPV.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

end.
