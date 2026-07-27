unit frame03CasaNSUnit;

// КАССОВЫЕ ОПЕРАЦИИ. Начальное сальдо
// DocTypeID = 1193
// Frame Index = 3

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, SWNDataFiltering,
   SWNBaseFrameUnit, DB, cxDBData,
   cxGridLevel, cxGridCustomTableView, cxGridDBTableView,
   cxGridCustomView, cxGrid, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCurrencyEdit, cxLabel,
  cxCheckBox, cxGridTableView, cxClasses, dxUIAClasses;

type
   Tframe03CasaNS = class(TSWNBaseFrame)
      cxGridCasaNS: TcxGrid;
      cxGridCasaNSDBTable: TcxGridDBTableView;
      cxGridCasaNS_DOCID: TcxGridDBColumn;
      cxGridCasaNS_DATA: TcxGridDBColumn;
      cxGridCasaNS_SUMA: TcxGridDBColumn;
      cxGridCasaNS_VAT: TcxGridDBColumn;
      cxGridCasaNS_CURRENCY_NAME: TcxGridDBColumn;
      cxGridCasaNS_RATE: TcxGridDBColumn;
      cxGridCasaNS_PARENTDOCID: TcxGridDBColumn;
      cxGridCasaNS_FLG_ACNT: TcxGridDBColumn;
      cxGridCasaNS_CREATED_BY_NAME: TcxGridDBColumn;
      cxGridCasaNSLevel: TcxGridLevel;
      cxGridCasaNS_DT_NAME: TcxGridDBColumn;
      cxGridCasaNS_DT: TcxGridDBColumn;
      procedure cxGridCasaNSDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
         TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
      procedure cxGridCasaNSDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure cxGridCasaNS_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
         var AText: string);
   private
    { Private declarations }
      fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
      procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
         AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
      procedure SelectionChanged;
   protected
    { Protected declarations }
      function InitFrameID: Integer; override;
      function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
      procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
      procedure DoFrameHide; override;
      function GetFrameButtons: TFrameButtons; override;
      function GetFilterFields: TFrameFilterFields; override;
      procedure CreateNewRecord; override;
      procedure ModifyRecord; override;
      procedure DeleteRecord; override;
      procedure ReadFrameStates; override;
      procedure SaveFrameStates; override;
      procedure SetupSecurityItems; override;

      procedure DoCloseDocument(const DocID: Integer); override;
      procedure DoOpenDocument(const DocID: Integer); override;

   public
    { Public declarations }
      procedure SetupDefaultFocus; override;
      function GetCurrentSearchContext: TSearchContextValue; override;
   end;

implementation

uses
   DataModuleDB, SWNUtils, SWNConst, SWNDBErrors, dateUtils, SWNValueStorageUnit,
   SWNSecurityFlags, SWNSecurity, frmNSDocDialog;

{$R *.dfm}

{ TframeCasa03NS }

procedure Tframe03CasaNS.CreateNewRecord;
var
   casa: TfrmNSDocDlg;
begin
   casa := TfrmNSDocDlg.Create(Self);
   try
      casa.CreateNewDocument := True;
      casa.ShowModal;
   finally
      casa.Free;
   end;
end;

procedure Tframe03CasaNS.cxGridCasaNSDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
   TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
   if fSECURITY_CanEdit then
   begin
      DoDocumentDoubleClick;
      AHandled := True;
   end;
end;

procedure Tframe03CasaNS.cxGridCasaNSDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   swnutils.ProcessCommonKeys(self, cxGridCasaNSDBTable, Key, Shift);
end;

procedure Tframe03CasaNS.cxGridCasaNS_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
   TcxCustomGridRecord; var AText: string);
begin
   if not VarIsNull(ARecord.Values[cxGridCasaNS_DATA.Index]) then
      AText := FormatDateTime('dd.mm.yyyy HH:MM', ARecord.Values[cxGridCasaNS_DATA.Index]);
end;

procedure Tframe03CasaNS.DeleteRecord;
begin
       // verificam daca:
     // 1. cel care modifica este si owneru
     // 2. se poate de modificat documentul numai in ziua curenta

   if (SameDate(dmDB.IBCQueryDocs.FieldByName('CREATED_DATE').AsDateTime, dmDB.GetServerCurrentTime)) and (dmDB.IBCQueryDocs.FieldByName
      ('CREATED_BY').AsInteger = dmDB.CurrentUserID) then
   begin
      if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_КАССА_Начальное_сальдо, [dmDB.IBCQueryDocs.FieldByName
         ('DOCID').asInteger])) = mrYes then
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
   end
   else
      ShowErrorDialog(cMSG_ACCESS_DENIED, cMSG_ACCESS_DENIED_MSG_CASSA);
end;

procedure Tframe03CasaNS.DoCloseDocument(const DocID: Integer);
begin
  inherited;
  dmdb.ibcqueryDocs.edit;
  dmdb.ibcquerydocs.FieldByName('FLG_CLOSED').AsINteger := 1;
  dmdb.ibcqueryDocs.Post;
end;

procedure Tframe03CasaNS.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
   CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
   cxGridCasaNSDBTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
   cxGridCasaNSDBTable.DataController.DataSource := nil;

   inherited;
end;

procedure Tframe03CasaNS.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
   inherited;

     // 1. Legam grid-urile de datasource-sele
   cxGridCasaNSDBTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
   cxGridCasaNSDBTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
   OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
   SelectionChanged;
end;

procedure Tframe03CasaNS.DoOpenDocument(const DocID: Integer);
begin
  dmdb.ibcqueryDocs.edit;
  dmdb.ibcquerydocs.FieldByName('FLG_CLOSED').AsINteger := 0;
  dmdb.ibcqueryDocs.Post;
end;

function Tframe03CasaNS.GetCurrentSearchContext: TSearchContextValue;
begin
   Result := inherited;

   if cxGridCasaNSDBTable.Site.Focused then
   begin
          // context from Docs
      if cxGridCasaNS_DATA.Focused then
      begin
               // Дата
         Result.Context := ffDate;
         Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
      end
   end
end;

function Tframe03CasaNS.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
   Result := [fedsDocs];
end;

function Tframe03CasaNS.GetFilterFields: TFrameFilterFields;
begin
   Result := [ffDate, ffCustomer];
end;

function Tframe03CasaNS.GetFrameButtons: TFrameButtons;
begin
   Result := [fbtREFRESH];
   if fSECURITY_CanNew then
      Result := Result + [fbtADD];
   if fSECURITY_CanEdit then
      Result := Result + [fbtMODIFY];
   if fSECURITY_CanDelete then
      Result := Result + [fbtDELETE];
end;

function Tframe03CasaNS.InitFrameID: Integer;
begin
     //  КАССОВЫЕ ОПЕРАЦИИ. Начальное сальдо
   Result := 3;
end;

procedure Tframe03CasaNS.ModifyRecord;
var
   casa: TfrmNSDocDlg;
begin
     // verificam daca:
     // 1. cel care modifica este si owneru
     // 2. se poate de modificat documentul numai in ziua curenta

   if (SameDate(dmDB.IBCQueryDocs.FieldByName('CREATED_DATE').AsDateTime, dmDB.GetServerCurrentTime)) and (dmDB.IBCQueryDocs.FieldByName
      ('CREATED_BY').AsInteger = dmDB.CurrentUserID) then
   begin
      casa := TfrmNSDocDlg.Create(Self);
      try
         casa.CreateNewDocument := False;
         casa.ShowModal;
      finally
         casa.Free;
      end;
   end
   else
      ShowErrorDialog(cMSG_ACCESS_DENIED, cMSG_ACCESS_DENIED_MSG_CASSA);
end;

procedure Tframe03CasaNS.ReadFrameStates;
begin
   AppUserConfigStorage.OpenSection(Self.Name);
   try
      ReadGridColumnsSettings(cxGridCasaNSDBTable);
   finally
      AppUserConfigStorage.CloseSection;
   end;
end;

procedure Tframe03CasaNS.SaveFrameStates;
begin
   AppUserConfigStorage.OpenSection(Self.Name);
   try
      SaveGridColumnsSettings(cxGridCasaNSDBTable);
   finally
      AppUserConfigStorage.CloseSection;
   end;
end;

procedure Tframe03CasaNS.SelectionChanged;
var
   fDocNew, fDocEdit, fDocDelete: Boolean;
begin
   fDocNew := fSECURITY_CanNew;
   fDocEdit := False;
   fDocDelete := False;
   if cxGridCasaNSDBTable.DataController.RecNo > 0 then
   begin
      fDocEdit := fSECURITY_CanEdit;
      fDocDelete := fSECURITY_CanDelete;
   end;
     // doc
   ButtonStateChanged(fbtADD, fDocNew);
   ButtonStateChanged(fbtMODIFY, fDocEdit);
   ButtonStateChanged(fbtDELETE, fDocDelete);
end;

procedure Tframe03CasaNS.SetupDefaultFocus;
begin
     // grid
   cxGridCasaNS.SetFocus;
     // columns
   cxGridCasaNS_DT_NAME.Focused := True;
end;

procedure Tframe03CasaNS.SetupSecurityItems;
begin
   fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_НС_Создать);
   fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_НС_Изменить);
   fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_НС_Удалить);
end;

procedure Tframe03CasaNS.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
   AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
   SelectionChanged;
end;

end.

