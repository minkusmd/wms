unit frame57ActDeficienteUnit;
{
  Acte. Acte de expertiza tehnica
  DocTypeID = 1994
  Frame Index = 57
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
  MemDS, cxNavigator, cxMemo, cxDBEdit, cxPCdxBarPopupMenu, cxPC,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  Tframe57ActDeficiente = class(TSWNBaseFrame)
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
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerPKOBar1: TdxBar;
    IBC_ACTC: TIBCQuery;
    IBCDS_ACTC: TIBCDataSource;
    bbFileNew: TdxBarButton;
    bbFileEdit: TdxBarButton;
    bbFileDelete: TdxBarButton;
    bbFileSave: TdxBarButton;
    dxBarPopupMenuGrid2: TdxBarPopupMenu;
    bbAprove: TdxBarButton;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1INCIDENTID: TcxGridDBColumn;
    cxGrid1DBTableView1ACTNO: TcxGridDBColumn;
    cxGrid1DBTableView1CREATED_DATE: TcxGridDBColumn;
    cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1ACCEPTED_DATE: TcxGridDBColumn;
    cxGrid1DBTableView1ACCEPTED_BY_NAME: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    dxBarButton1: TdxBarButton;
    bbIncidentDescription: TdxBarButton;
    IBCDataSourceIncidente: TIBCDataSource;
    IBCQueryIncidente: TIBCQuery;
    procedure cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure bbFileEditClick(Sender: TObject);
    procedure bbFileDeleteClick(Sender: TObject);
    procedure bbFileSaveClick(Sender: TObject);
    procedure bbAproveClick(Sender: TObject);
    procedure IBCDS_ACTCDataChange(Sender: TObject; Field: TField);
    procedure bbIncidentDescriptionClick(Sender: TObject);
    procedure cxGrid1DBTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGrid1DBTableView1CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGrid1DBTableView1ACCEPTED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;

    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure ActSelectionChanged;

    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID: integer): Boolean;
    procedure DoOpenDocument;
    function DoOpenDocumentDB(const DocID: integer): Boolean;

    procedure ShowModifyActDialog;
    procedure DeleteAct;

    procedure SaveDataToDB;

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
  SWNSecurity, SWNSecurityFlags, Vcl.FileCtrl, frm57DocumentDialogUnit, u57ActEditorDialog,
  frmServiceNewIncidentEditorDialog;

{$R *.dfm}

{ TSWNBaseFrame1 }

procedure Tframe57ActDeficiente.ActSelectionChanged;
var FLG_CLOSED,fView,fEdit,fDelete,fApprove:Boolean;
begin
     fView:=False;
     fEdit:=False;
     fDelete:=False;
     fApprove:=False;

     if (cxGridDocsTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
          if (cxGrid1DBTableView1.DataController.RecNo>0) then
          begin
               fView:=True;
               fEdit:=Not FLG_CLOSED;
               fDelete:=Not FLG_CLOSED;
               fApprove:=Not FLG_CLOSED;
          end;
     end;
     bbIncidentDescription.Enabled:=fView;
     bbFileEdit.Enabled:=fEdit;
     bbFileDelete.Enabled:=fDelete;
     bbAprove.Enabled:=fApprove;
end;

procedure Tframe57ActDeficiente.bbAproveClick(Sender: TObject);
var Query: TIBCQuery;
begin
     if ShowAskDialog('Aprobare act',
                      Format('Doriti sa aprobati actul nr.%s?',[IBC_ACTC.FieldByName('ACTNO').AsString]))<>mrYes then Exit;

     Query := TIBCQuery.Create(Self);
     try
        Query.AutoCommit := False;
        Query.Transaction := IBC_ACTC.UpdateTransaction;
        Query.SQL.Text := 'execute procedure sp_aprove_act1(:docid)';
        Query.ParamByName('DOCID').AsInteger := IBC_ACTC.FieldByName('DOCID').AsInteger;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
           IBC_ACTC.Refresh;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end
end;

procedure Tframe57ActDeficiente.bbCloseDocClick(Sender: TObject);
begin
  DoCloseDocument;
end;

procedure Tframe57ActDeficiente.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe57ActDeficiente.bbFileDeleteClick(Sender: TObject);
begin
     DeleteAct;
end;

procedure Tframe57ActDeficiente.bbFileEditClick(Sender: TObject);
begin
     ShowModifyActDialog;
end;

procedure Tframe57ActDeficiente.bbFileSaveClick(Sender: TObject);
begin
  SaveDataToDB;
end;

procedure Tframe57ActDeficiente.bbGotoParentDocClick(Sender: TObject);
begin
  FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe57ActDeficiente.bbIncidentDescriptionClick(Sender: TObject);
var dialog: TfrmServiceNewIncidentEditorDlg;
begin
     IBCQueryIncidente.Close;
     IBCQueryIncidente.ParamByName('ID').AsInteger:=IBC_ACTC.FieldByName('INCIDENTID').AsInteger;
     IBCQueryIncidente.Open;

     dialog := TfrmServiceNewIncidentEditorDlg.Create(Self, IBCQueryIncidente, IBCDataSourceIncidente);
     try
        dialog.Panel1.Enabled := false;
        dialog.Panel2.Enabled := false;
        dialog.btnOK.Visible:=False;
        dialog.btnCancel.Caption:='Inchide';
        dialog.ShowModal;
     finally
        dialog.Free;
     end;

     IBCQueryIncidente.Close;
end;

procedure Tframe57ActDeficiente.bbOpenDocClick(Sender: TObject);
begin
  DoOpenDocument;
end;

procedure Tframe57ActDeficiente.CreateNewRecord;
var
  dialog: Tfrm57DocumentDialog;
begin
  dialog := Tfrm57DocumentDialog.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe57ActDeficiente.cxGrid1DBTableView1ACCEPTED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGrid1DBTableView1ACCEPTED_DATE.index]) then AText := FormatDateTime('dd.mm.yyyy HH:MM', ARecord.Values[cxGrid1DBTableView1ACCEPTED_DATE.index]);
end;

procedure Tframe57ActDeficiente.cxGrid1DBTableView1CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGrid1DBTableView1CREATED_DATE.index]) then AText := FormatDateTime('dd.mm.yyyy HH:MM', ARecord.Values[cxGrid1DBTableView1CREATED_DATE.index]);
end;

procedure Tframe57ActDeficiente.cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe57ActDeficiente.cxGrid1DBTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     ActSelectionChanged;
end;

procedure Tframe57ActDeficiente.cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
  DoDocumentDoubleClick;
  AHandled := True;
end;

procedure Tframe57ActDeficiente.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
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

procedure Tframe57ActDeficiente.cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridDocs_DATA.index]) then AText := FormatDateTime('dd.mm.yyyy HH:MM', ARecord.Values[cxGridDocs_DATA.index]);
end;

procedure Tframe57ActDeficiente.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridDocsTable, Key, Shift);
end;

procedure Tframe57ActDeficiente.DeleteAct;
begin
     if ShowAskDialog('Stergere inregistrare', Format('Doriti sa stergeti actul nr. %d?',[IBC_ACTC.FieldByName('DOCID').AsInteger])) <> mrYes then Exit;

     IBC_ACTC.UpdateTransaction.StartTransaction;
     try
        IBC_ACTC.Delete;
        IBC_ACTC.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBC_ACTC.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
    end;
end;

procedure Tframe57ActDeficiente.DeleteRecord;
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

procedure Tframe57ActDeficiente.DoCloseDocument;
var
  b: Boolean;
begin

  b := AppUserTempConfigStorage.BooleanValues.GetValue('PKO_CloseDocVerify');
  if b or (ShowAskDialogVerification('Inchide documentul', 'Doriti sa inchideti documentul?',
    'Nu mai intreba', '', b) = mrYes) then
  begin
    if b then
      AppUserTempConfigStorage.BooleanValues.SetValue('PKO_CloseDocVerify', b);
    if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe57ActDeficiente.DoCloseDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_1994(:DOCID)';
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

procedure Tframe57ActDeficiente.DoFrameHide;
begin
     // inchidem datele interne
     IBC_ACTC.Close;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridDocsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridDocsTable.DataController.DataSource := nil;

     inherited;
end;

procedure Tframe57ActDeficiente.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridDocsTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
     cxGridDocsTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
     IBC_ACTC.Active := True;

     // 4. Selection update
     SelectionChanged;
end;

procedure Tframe57ActDeficiente.DoOpenDocument;
begin
  if ShowAskDialog('Deschide documentul', 'Doriti sa deschideti documentul?') = mrYes then
  begin
    if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe57ActDeficiente.DoOpenDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_1994(:DOCID)';
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

function Tframe57ActDeficiente.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := Inherited;

  if cxGridDocsTable.Site.Focused then
  begin
    // context from Docs
    if cxGridDocs_CT_NAME.Focused then
    begin
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridDocs_DATA.Focused then
    begin
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end;
  end
end;

function Tframe57ActDeficiente.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsDocs];
end;

function Tframe57ActDeficiente.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer];
end;

function Tframe57ActDeficiente.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe57ActDeficiente.IBCDS_ACTCDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  bbAprove.Enabled := VarIsNull(IBC_ACTC.FieldByName('accepted_by').AsVariant);
end;

function Tframe57ActDeficiente.InitFrameID: integer;
begin
     // Acte. Acte de expertiza tehnica
     Result := 57;
end;

procedure Tframe57ActDeficiente.ModifyRecord;
var
  dialog: Tfrm57DocumentDialog;
begin
  if Not fSECURITY_CanEdit then
    Exit;

  dialog := Tfrm57DocumentDialog.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe57ActDeficiente.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//        cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridDocsTable);
        ReadGridColumnsSettings(cxGrid1DBTableView1);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe57ActDeficiente.RefreshData;
begin
     inherited;
     IBC_ACTC.Refresh;
end;

procedure Tframe57ActDeficiente.SaveDataToDB;
begin

end;

procedure Tframe57ActDeficiente.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridDocsTable);
        SaveGridColumnsSettings(cxGrid1DBTableView1);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe57ActDeficiente.SelectionChanged;
var fComments,fGotoParent,fClose,fOpen:Boolean;
    FLG_CLOSED:Boolean;
begin
     fComments:=False;
     fGotoParent:=False;
     fClose:=False;
     fOpen:=False;

     if (cxGridDocsTable.DataController.RecNo>0) then
     begin
          FLG_CLOSED:=dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger=1;
          fGotoParent := Not dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').IsNull;
          fComments:=fSECURITY_CanEdit;
          fClose:=Not FLG_CLOSED;
          fOpen:=FLG_CLOSED;
     end;

     bbCloseDoc.Enabled:=fClose;
     bbOpenDoc.Enabled:=fOpen;
     bbDocComments.Enabled := fComments;
     bbGotoParentDoc.Enabled := fGotoParent;

     ActSelectionChanged;
end;

procedure Tframe57ActDeficiente.SetupDefaultFocus;
begin
  // grid
  cxGridDocs.SetFocus;
  // columns
  cxGridDocs_CT_NAME.Focused := True;
  cxGrid1DBTableView1ACTNO.Focused := True;
end;

procedure Tframe57ActDeficiente.SetupSecurityItems;
begin
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(1995);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(1996);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(1997);

  if Not SWNSecurityManager.UserHasSecurityFlag(1999) then   // inchide documentul
    bbCloseDoc.Visible := ivNever;
  if Not SWNSecurityManager.UserHasSecurityFlag(2000) then   // deschide documentul
    bbOpenDoc.Visible := ivNever;

  if Not SWNSecurityManager.UserHasSecurityFlag(2001) then // aproba actul
    bbAprove.Visible := ivNever;

end;

procedure Tframe57ActDeficiente.ShowModifyActDialog;
var
  dialog: Tfrm57ActEditorDlg;
begin
  dialog := Tfrm57ActEditorDlg.Create(Self, IBC_ACTC, IBCDS_ACTC);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;


procedure Tframe57ActDeficiente.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

end.
