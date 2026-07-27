unit frame53ARPPUnit;
{
  Акты. Реестр передачи документов
  DocTypeID = 1959
  Frame Index = 53
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxCurrencyEdit,
  cxLabel, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView,
  cxGrid, StdCtrls, ExtCtrls, cxLookAndFeels, cxLookAndFeelPainters, dxBar, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxBlobEdit, cxSplitter, DBAccess, IBC,
  MemDS, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges,
  dxScrollbarAnnotations, dxUIAClasses;

type
  Tframe53ARPP = class(TSWNBaseFrame)
    cxGridDocsTable: TcxGridDBTableView;
    cxGridDocsLevel: TcxGridLevel;
    cxGridDocs: TcxGrid;
    cxGridDocs_DOCID: TcxGridDBColumn;
    cxGridDocs_DATA: TcxGridDBColumn;
    cxGridDocs_CT_NAME: TcxGridDBColumn;
    cxGridDocsTableSuma: TcxGridDBColumn;
    cxGridDocsTableVAT: TcxGridDBColumn;
    cxGridDocsTableCurrencyName: TcxGridDBColumn;
    cxGridDocs_PARENTDOCID: TcxGridDBColumn;
    cxGridDocs_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridDocsTableRate: TcxGridDBColumn;
    cxGridCasaPKO_FLG_ACNT: TcxGridDBColumn;
    dxBarManagerPKO: TdxBarManager;
    dxBarPopupMenuPKO: TdxBarPopupMenu;
    cxGridCasaPKO_RATEUSD: TcxGridDBColumn;
    cxGridCasaPKO_CT: TcxGridDBColumn;
    cxGridPopupMenuDoc: TcxGridPopupMenu;
    bbGotoParentDoc: TdxBarButton;
    bbDocComments: TdxBarButton;
    cxGridDocs_FLG_CLOSED: TcxGridDBColumn;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    cxGridCasaPKODB_SC2_NAME: TcxGridDBColumn;
    bbDocs: TdxBarButton;
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerPKOBar1: TdxBar;
    cxGridFilesTable: TcxGridDBTableView;
    cxGridFilesLevel: TcxGridLevel;
    cxGridFiles: TcxGrid;
    IBCQueryFiles: TIBCQuery;
    IBCDataSourceFiles: TIBCDataSource;
    cxGridFiles_FILENAME: TcxGridDBColumn;
    cxGridFiles_FILESIZE: TcxGridDBColumn;
    bbFileNew: TdxBarButton;
    bbFileEdit: TdxBarButton;
    bbFileDelete: TdxBarButton;
    bbFileSave: TdxBarButton;
    procedure cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBarPopupMenuPKOPopup(Sender: TObject);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure bbFileNewClick(Sender: TObject);
    procedure bbFileEditClick(Sender: TObject);
    procedure bbFileDeleteClick(Sender: TObject);
    procedure bbFileSaveClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    fLastFilePath: String;

    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenPopupMenuPopup;
    procedure WhenGridFilesFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure FilesSelectionChanged;

    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID: integer): Boolean;
    procedure DoOpenDocument;
    function DoOpenDocumentDB(const DocID: integer): Boolean;

    procedure ShowAddNewAttachmentDialog;
    procedure ShowModifyAttachmentDialog;
    procedure DeleteAttachment;

    procedure SaveFile;
    procedure SaveFileFromDB(const AttID: integer; const FilePath: String);

  protected
    { Protected declarations }
    function InitFrameID: integer; override;

    function GetExternalDataSourceTypes:TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;

    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;

    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;

    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;

  end;

implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, DateUtils, SWNValueStorageUnit,
  SWNSecurity, SWNSecurityFlags, frm53RPPDocDialog, frm53RPPFileEditorDialog, Vcl.FileCtrl;

{$R *.dfm}
{ TSWNBaseFrame1 }

procedure Tframe53ARPP.bbCloseDocClick(Sender: TObject);
begin
  DoCloseDocument;
end;

procedure Tframe53ARPP.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe53ARPP.bbFileDeleteClick(Sender: TObject);
begin
  DeleteAttachment;
end;

procedure Tframe53ARPP.bbFileEditClick(Sender: TObject);
begin
  ShowModifyAttachmentDialog;
end;

procedure Tframe53ARPP.bbFileNewClick(Sender: TObject);
begin
  ShowAddNewAttachmentDialog;
end;

procedure Tframe53ARPP.bbFileSaveClick(Sender: TObject);
begin
  SaveFile;
end;

procedure Tframe53ARPP.bbGotoParentDocClick(Sender: TObject);
begin
  FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe53ARPP.bbOpenDocClick(Sender: TObject);
begin
  DoOpenDocument;
end;

procedure Tframe53ARPP.CreateNewRecord;
var
  dialog: Tfrm53RPPDocDlg;
begin
  dialog := Tfrm53RPPDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe53ARPP.cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
  DoDocumentDoubleClick;
  AHandled := True;
end;

procedure Tframe53ARPP.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridDocs_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridDocs_FLG_CLOSED.index] = 0 then
    begin
      if Not AViewInfo.Selected then
      begin
        // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridCasaPKO_FLG_ACNT.index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if Not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridCasaPKO_FLG_ACNT.index] = 1 then
          ACanvas.Font.Color := $008B8BC5
        else
          ACanvas.Font.Color := clGrayText;
      end;
    end;
  end;

  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe53ARPP.cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  if Not VarIsNull(ARecord.Values[cxGridDocs_DATA.index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:MM', ARecord.Values[cxGridDocs_DATA.index]);
end;

procedure Tframe53ARPP.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(Self, cxGridDocsTable, Key, Shift);
end;

procedure Tframe53ARPP.DeleteAttachment;
begin
  if ShowAskDialog('Удаление файла', Format('Вы хотите удалить файл "%s"?',
    [IBCQueryFiles.FieldByName('FILENAME').AsString])) = mrYes then
  begin
    IBCQueryFiles.UpdateTransaction.StartTransaction;
    try
      IBCQueryFiles.Delete;
      IBCQueryFiles.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryFiles.UpdateTransaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe53ARPP.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_53,
    [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger])) = mrYes then
  begin
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
    try
      dmDB.IBCQueryDocs.Delete;
      dmDB.IBCQueryDocs.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe53ARPP.DoCloseDocument;
var
  b: Boolean;
begin
  b := AppUserTempConfigStorage.BooleanValues.GetValue('PKO_CloseDocVerify');
  if b or (ShowAskDialogVerification('Закрыть документ', 'Вы хотите закрыть документ?',
    'Больше не спрашивать', '', b) = mrYes) then
  begin
    if b then
      AppUserTempConfigStorage.BooleanValues.SetValue('PKO_CloseDocVerify', b);
    if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe53ARPP.DoCloseDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_ARPP(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe53ARPP.DoFrameHide;
begin
     // incidem datele interne
     IBCQueryFiles.Active := False;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridDocsTable.OnFocusedRecordChanged := nil;
     cxGridFilesTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridDocsTable.DataController.DataSource := nil;

     inherited;
end;

procedure Tframe53ARPP.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridDocsTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
     cxGridDocsTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;
     cxGridFilesTable.OnFocusedRecordChanged := WhenGridFilesFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
     IBCQueryFiles.Active := True;

     // 4. Selection update
     SelectionChanged;
end;

procedure Tframe53ARPP.DoOpenDocument;
begin
  if ShowAskDialog('Открыть документ', 'Вы открыть документ?') = mrYes then
  begin
    if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe53ARPP.DoOpenDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_ARPP(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe53ARPP.dxBarPopupMenuPKOPopup(Sender: TObject);
begin
  WhenPopupMenuPopup;
end;

procedure Tframe53ARPP.FilesSelectionChanged;
var
  fNew, fEdit, fDelete, fSave: Boolean;
  FLG_CLOSED: Boolean;
begin
  fNew := False;
  fEdit := False;
  fDelete := False;
  fSave := False;
  if cxGridDocsTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    if Not FLG_CLOSED and fSECURITY_CanEdit then
    begin
      fNew := True;
      if cxGridFilesTable.DataController.RecNo > 0 then
      begin
        fEdit := True;
        fDelete := True;
      end;
    end;
    fSave := cxGridFilesTable.DataController.RecNo > 0;
  end;
  bbFileNew.Enabled := fNew;
  bbFileEdit.Enabled := fEdit;
  bbFileDelete.Enabled := fDelete;
  bbFileSave.Enabled := fSave;
end;

function Tframe53ARPP.GetCurrentSearchContext: TSearchContextValue;
begin
     Result := Inherited;

     if cxGridDocsTable.Site.Focused then
     begin
          // context from Docs
          if cxGridDocs_CT_NAME.Focused then
          begin
               // Контрагент
               Result.Context := ffCustomer;
               Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
               Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
          end
          else
              if cxGridDocs_DATA.Focused then
              begin
                   // Дата
                   Result.Context := ffDate;
                   Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
              end;
     end
end;

function Tframe53ARPP.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe53ARPP.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer];
end;

function Tframe53ARPP.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe53ARPP.InitFrameID: integer;
begin
     // Акты: Реестр передачи документов
     Result := 53;
     fLastFilePath := '';
end;

procedure Tframe53ARPP.ModifyRecord;
var
  dialog: Tfrm53RPPDocDlg;
begin
  if Not fSECURITY_CanEdit then
    Exit;

  dialog := Tfrm53RPPDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe53ARPP.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    ReadGridColumnsSettings(cxGridDocsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe53ARPP.RefreshData;
begin
     inherited;
     IBCQueryFiles.Refresh;
end;

procedure Tframe53ARPP.SaveFile;
var
  dir: String;
begin
  dir := fLastFilePath;
  if SelectDirectory('Выберите куда записать файл', '', dir) then
  begin
    SaveFileFromDB(IBCQueryFiles.FieldByName('ATTID').AsInteger, dir);
    fLastFilePath := dir;
  end;
end;

procedure Tframe53ARPP.SaveFileFromDB(const AttID: integer; const FilePath: String);
var
  Query: TIBCQuery;
  filename: String;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT FILENAME,FILEDATA FROM TDB_DOCS_ATTACHMENTS WHERE ATTID=:ID';
    Query.ParamByName('ID').AsInteger := AttID;
    Query.ExecSQL;
    if Not Query.Eof then
    begin
      filename := IncludeTrailingPathDelimiter(FilePath) + Query.Fields[0].AsString;
      TBlobField(Query.Fields[1]).SaveToFile(filename);
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe53ARPP.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
    SaveGridColumnsSettings(cxGridDocsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe53ARPP.SelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED, fCloseDoc, fOpenDoc, fDocs: Boolean;
begin
  fDocNew := fSECURITY_CanNew; // New document
  fDocEdit := False;
  fDocDelete := False;
  fCloseDoc := False;
  fOpenDoc := False;
  fDocs := False;
  if cxGridDocsTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit;
    fDocDelete := fSECURITY_CanDelete;
    fCloseDoc := Not FLG_CLOSED;
    fOpenDoc := FLG_CLOSED;
    fDocs := Not FLG_CLOSED and fSECURITY_CanEdit;
  end;
  // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

  // popup
  bbCloseDoc.Enabled := fCloseDoc;
  bbOpenDoc.Enabled := fOpenDoc;
  bbDocs.Enabled := fDocs;

  // files
  FilesSelectionChanged;
end;

procedure Tframe53ARPP.SetupDefaultFocus;
begin
     // grid
     cxGridDocs.SetFocus;
     // columns
     cxGridDocs_CT_NAME.Focused := True;
     cxGridFiles_FILENAME.Focused := True;
end;

procedure Tframe53ARPP.SetupSecurityItems;
begin
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Акты_РПД_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Акты_РПД_Редактировать);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Акты_РПД_Удалить);

  if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Акты_РПД_Закрыть_документ) then
    bbCloseDoc.Visible := ivNever;
  if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Акты_РПД_Открыть_документ) then
    bbOpenDoc.Visible := ivNever;
end;

procedure Tframe53ARPP.ShowAddNewAttachmentDialog;
var
  dialog: Tfrm53RPPFileEditorDlg;
begin
  dialog := Tfrm53RPPFileEditorDlg.Create(Self, IBCQueryFiles, IBCDataSourceFiles);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe53ARPP.ShowModifyAttachmentDialog;
var
  dialog: Tfrm53RPPFileEditorDlg;
begin
  dialog := Tfrm53RPPFileEditorDlg.Create(Self, IBCQueryFiles, IBCDataSourceFiles);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe53ARPP.WhenGridFilesFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  FilesSelectionChanged;
end;

procedure Tframe53ARPP.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure Tframe53ARPP.WhenPopupMenuPopup;
begin
  bbGotoParentDoc.Enabled := Not dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').IsNull;
  bbDocComments.Enabled := fSECURITY_CanEdit;
end;

end.
