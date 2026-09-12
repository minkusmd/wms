unit frame05BankPDNSICUnit;

// OPERATIUNI BANCARE. Incasare bani in cont (din casa)
// DocTypeID = 121
// Frame Index = 5

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes,
  Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics,
  DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid,
  dxBar,
  cxGridPopupMenu, IBC, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxClasses, cxGridTableView, dxUIAClasses;

type
  Tframe05BankPDNSIC = class(TSWNBaseFrame)
    cxGridBankPDNSIC: TcxGrid;
    cxGridBankPDNSICDBTable: TcxGridDBTableView;
    cxGridBankPDNSIC_DATA: TcxGridDBColumn;
    cxGridBankPDNSICDBTableCtName: TcxGridDBColumn;
    cxGridBankPDNSICDBTableSuma: TcxGridDBColumn;
    cxGridBankPDNSICDBTableCurrencyName: TcxGridDBColumn;
    cxGridBankPDNSICDBTableVAT: TcxGridDBColumn;
    cxGridBankPDNSICDBTableRate: TcxGridDBColumn;
    cxGridBankPDNSICDBTableParentDocID: TcxGridDBColumn;
    cxGridBankPDNSICDBTableFlgACNT: TcxGridDBColumn;
    cxGridBankPDNSIC_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridBankPDNSICLevel1: TcxGridLevel;
    cxGridBankPDNSICDB_FLG_CLOSED: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    cxGridPopupMenu1: TcxGridPopupMenu;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bbProvesti: TdxBarButton;
    bbCancelProvodca: TdxBarButton;
    cxGridBankPDNSIC_RATEUSD: TcxGridDBColumn;
    bbDocComments: TdxBarButton;
    bbPDC: TdxBarButton;
    bbGoToParentDocID: TdxBarButton;
    cxGridBankPDNSICDBTableDOCID: TcxGridDBColumn;
    procedure cxGridBankPDNSICDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridBankPDNSICDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarPopupMenu1Popup(Sender: TObject);
    procedure bbProvestiClick(Sender: TObject);
    procedure bbCancelProvodcaClick(Sender: TObject);
    procedure cxGridBankPDNSICDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridBankPDNSIC_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbPDCClick(Sender: TObject);
    procedure bbGoToParentDocIDClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView,
    fSECURITY_CanNew,
    fSECURITY_CanEdit,
    fSECURITY_CanDelete:Boolean;


    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure PopupForSelection;

    procedure DoAction_Provesti;
    procedure DoAction_CancelProvodca;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;

    function GetExternalDataSourceTypes:TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    function GetFrameButtons:TFrameButtons;override;
    function GetFilterFields: TFrameFilterFields; override;

    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;

    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;

    procedure SetupSecurityItems;override;

    procedure DoCloseDocument(const DocID: Integer); override;
    procedure DoOpenDocument(const DocID: Integer); override;

  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
    function GetCurrentSearchContext:TSearchContextValue;override;
  end;

implementation

uses DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions,
     SWNDBErrors, SWNValueStorageUnit, SWNSecurity, SWNSecurityFlags, frmMoneyIncomeDialog, frmBankPDNSKDialog;

{$R *.dfm}

{ TTframe05BankPDNSIC }

procedure Tframe05BankPDNSIC.bbCancelProvodcaClick(Sender: TObject);
begin
  DoOpenDocument(dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe05BankPDNSIC.bbDocCommentsClick(Sender: TObject);
begin
     ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe05BankPDNSIC.bbGoToParentDocIDClick(Sender: TObject);
begin
   FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe05BankPDNSIC.bbPDCClick(Sender: TObject);
var dialog:TfrmMoneyIncomeDlg;
begin
     // Incasare bani in cont
     dialog:=TfrmMoneyIncomeDlg.Create(Self,dmDB.IBCQueryDocs,dmDB.IBCDataSourceDocs);
     try
        dialog.SetCustomTitle('Cont bancar','Ordin de incasare');

        if dialog.ShowModal=mrOk then
        begin
             // Incasare bani in cont
             if dmDB.CreateProhodDenegNaSciotMAIN(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger,dialog.CurrencyID,dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger,dialog.Rate,dialog.SUMA) then
             begin
                  dmDB.IBCQueryDocs.Refresh;
                  ShowInfoDialog('Ordin de incasare','Creat cu succes!');
             end;
        end;
     finally
        dialog.Free;
     end;
end;
procedure Tframe05BankPDNSIC.bbProvestiClick(Sender: TObject);
begin
  DoCloseDocument(dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe05BankPDNSIC.CreateNewRecord;
var editor: TfrmBankPDNSKDlg;
begin
     editor := TfrmBankPDNSKDlg.Create(Self, dmdb.IBCQueryDocs, dmdb.IBCDataSourceDocs);
     try
        editor.CreateNewDocument := True;
        editor.DocTypeID := dmdb.CurrentDocTypeID;
        editor.DataDoc := Now;
        editor.ShowModal;
     finally
        editor.Free;
     end;
end;

procedure Tframe05BankPDNSIC.cxGridBankPDNSICDBTableCellDblClick
  (Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
     if AButton=mbLeft then
     begin
          DoDocumentDoubleClick;
          AHandled := True;
     end;
end;

procedure Tframe05BankPDNSIC.cxGridBankPDNSICDBTableCustomDrawCell
  (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridBankPDNSICDB_FLG_CLOSED.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridBankPDNSICDB_FLG_CLOSED.index]=0 then
          begin
               if Not AViewInfo.Selected then
               begin
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGridBankPDNSICDBTableFlgACNT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
               end;
          end
          else
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    if AViewInfo.GridRecord.Values[cxGridBankPDNSICDBTableFlgACNT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
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

procedure Tframe05BankPDNSIC.cxGridBankPDNSIC_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridBankPDNSIC_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridBankPDNSIC_DATA.Index]);
end;

procedure Tframe05BankPDNSIC.cxGridBankPDNSICDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self, cxGridBankPDNSICDBTable,Key,Shift);
end;

procedure Tframe05BankPDNSIC.DeleteRecord;
begin
     if (dmDB.IBCQueryDocs.RecordCount = 0) then Exit;

     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_БАНК_ПДНСИК,[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger])) = mrYes then
     begin
          dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
          try
             dmDB.IBCQueryDocs.Delete;
             dmDB.IBCQueryDocs.UpdateTransaction.Commit;
          except on E: Exception do
             begin
                  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise ;
             end;
          end;
     end;
end;

procedure Tframe05BankPDNSIC.DoAction_CancelProvodca;
begin
     if ShowAskDialog('Ordin de incasare','Doriti sa anulati inregistrarea?')=mrYes then
     begin
          if dmDB.CancelDocumentProvodka(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger)
            then dmDB.IBCQueryDocs.Refresh;
     end;
end;

procedure Tframe05BankPDNSIC.DoAction_Provesti;
begin
     if ShowAskDialog('Confirmare','Doriti sa confirmati?')=mrYes then
     begin
          if dmDB.CreateDocumentProvodka(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger)
            then dmDB.IBCQueryDocs.Refresh;
     end;
end;

procedure Tframe05BankPDNSIC.DoCloseDocument(const DocID: Integer);
begin
  DoAction_Provesti;
end;

procedure Tframe05BankPDNSIC.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridBankPDNSICDBTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridBankPDNSICDBTable.DataController.DataSource := nil;

     inherited;
end;

procedure Tframe05BankPDNSIC.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridBankPDNSICDBTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
     cxGridBankPDNSICDBTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
     SelectionChanged;
end;

procedure Tframe05BankPDNSIC.DoOpenDocument(const DocID: Integer);
begin
  DoAction_CancelProvodca;
end;

procedure Tframe05BankPDNSIC.dxBarPopupMenu1Popup(Sender: TObject);
begin
     PopupForSelection;
end;

function Tframe05BankPDNSIC.GetCurrentSearchContext: TSearchContextValue;
begin
     Result:=Inherited;

     if cxGridBankPDNSICDBTable.Site.Focused then
     begin
          // context from Docs
          if cxGridBankPDNSICDBTableCtName.Focused then
          begin
               // Primit de la
               Result.Context:=ffCustomer;
               Result.ValueInt:=dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
               Result.ValueStr:=dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
          end
          else
          if cxGridBankPDNSIC_DATA.Focused then
          begin
               // Data
               Result.Context:=ffDate;
               Result.ValueDateTime:=dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
          end
     end
end;

function Tframe05BankPDNSIC.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe05BankPDNSIC.GetFilterFields: TFrameFilterFields;
begin
     Result := [ffDate, ffCustomer];
end;

function Tframe05BankPDNSIC.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_CanNew then Result:=Result+[fbtADD];
     if fSECURITY_CanEdit or fSECURITY_CanView then Result:=Result+[fbtMODIFY];
     if fSECURITY_CanDelete then Result:=Result+[fbtDELETE];
end;

function Tframe05BankPDNSIC.InitFrameID: integer;
begin
     // BANCA. Incasare bani in cont (din casa)
     Result := 5;
end;

procedure Tframe05BankPDNSIC.ModifyRecord;
var dialog: TfrmBankPDNSKDlg;
    FLG_CLOSED,ReadOnly:Boolean;
begin
     if Not (fSECURITY_CanEdit or fSECURITY_CanView) then Exit;

     FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
     if fSECURITY_CanEdit then ReadOnly:=FLG_CLOSED
                          else ReadOnly:=fSECURITY_CanView;


     dialog := TfrmBankPDNSKDlg.Create(Self, dmdb.IBCQueryDocs, dmdb.IBCDataSourceDocs);
     try
        dialog.CreateNewDocument := False;
        dialog.ReadOnly := ReadOnly;
        dialog.DocTypeID := dmdb.CurrentDocTypeID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe05BankPDNSIC.PopupForSelection;
begin
     bbDocComments.Enabled:=fSECURITY_CanEdit;
end;

procedure Tframe05BankPDNSIC.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    ReadGridColumnsSettings(cxGridBankPDNSICDBTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe05BankPDNSIC.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    SaveGridColumnsSettings(cxGridBankPDNSICDBTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe05BankPDNSIC.SelectionChanged;
var fDocNew, fDocEdit, fDocDelete, fCloseDoc, fOpenDoc: Boolean;
    FLG_CLOSED:Boolean;
begin
     fDocNew := fSECURITY_CanNew;
     fDocEdit := False;
     fDocDelete := False;

     fCloseDoc:=False;
     fOpenDoc:=False;

     if cxGridBankPDNSICDBTable.DataController.RecNo > 0 then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;

          fDocEdit:=fSECURITY_CanEdit and Not FLG_CLOSED or fSECURITY_CanView;
          fDocDelete:=fSECURITY_CanDelete and Not FLG_CLOSED;

          fCloseDoc:=Not FLG_CLOSED;  // Confirma
          fOpenDoc:=FLG_CLOSED;
     end;

     // doc
     ButtonStateChanged(fbtADD, fDocNew);
     ButtonStateChanged(fbtMODIFY, fDocEdit);
     ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
     bbProvesti.Enabled:=fCloseDoc;
     bbCancelProvodca.Enabled:=fOpenDoc;

end;

procedure Tframe05BankPDNSIC.SetupDefaultFocus;
begin
     // grid
     cxGridBankPDNSIC.SetFocus;
     // columns
     cxGridBankPDNSICDBTableCtName.Focused:=True;
end;

procedure Tframe05BankPDNSIC.SetupSecurityItems;
begin
     fSECURITY_CanView:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНСИК_Просмотр);
     fSECURITY_CanNew:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНСИК_Создать);
     fSECURITY_CanEdit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНСИК_Изменить);
     fSECURITY_CanDelete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНСИК_Удалить);

     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНСИК_Закрыть_документ) then bbProvesti.Visible:=ivNever;
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНСИК_Открыть_документ) then bbCancelProvodca.Visible:=ivNever;
end;

procedure Tframe05BankPDNSIC.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

end.
