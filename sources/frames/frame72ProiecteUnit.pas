unit frame72ProiecteUnit;

// СЧЕТА. Входные Счета
// DocTypeID = 3126
// Frame Index = 72

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit, cxLabel, cxCheckBox, cxImageComboBox, dxBar,
  cxClasses, cxSplitter, ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxControls, cxGridCustomView, cxGrid, IBC, cxLookAndFeels,
  cxLookAndFeelPainters, cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator, cxCalc, frameScanFiles,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  Tframe72Proiecte = class(TSWNBaseFrame)
    cxGridPTN: TcxGrid;
    cxGridPTNTable: TcxGridDBTableView;
    cxGridPTN_DOCID: TcxGridDBColumn;
    cxGridPTN_DATA: TcxGridDBColumn;
    cxGridPTN_CT_NAME: TcxGridDBColumn;
    cxGridPTN_SUMA: TcxGridDBColumn;
    cxGridPTN_CURRENCY_NAME: TcxGridDBColumn;
    cxGridPTN_VAT: TcxGridDBColumn;
    cxGridPTN_FLG_ACNT: TcxGridDBColumn;
    cxGridPTN_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridPTN_FLG_CLOSED: TcxGridDBColumn;
    cxGridPTNLevel: TcxGridLevel;
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    dxBarManager: TdxBarManager;
    bbAddGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbDeleteGoods: TdxBarButton;
    cxGridPTN_RATEUSD: TcxGridDBColumn;
    dxBarPopupMenuDOCS: TdxBarPopupMenu;
    cxGridPopupMenuDOCS: TcxGridPopupMenu;
    bbDocComments: TdxBarButton;
    cxGridPTN_CT: TcxGridDBColumn;
    cxGridPTN_SC2_NAME: TcxGridDBColumn;
    bbCustomerDebts: TdxBarButton;
    cxGridPopupMenuCOMPONENTS: TcxGridPopupMenu;
    frameScanFile1: TframeScanFile;
    procedure cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure dxBarPopupMenuDOCSPopup(Sender: TObject);
    procedure cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridPTN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
      TcxCustomGridRecord; var AText: string);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure frameScanFile1bbAddFileClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    procedure WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocSelectionChanged;
    procedure WhenDocumentPopupMenuOpen;
    procedure SetupQtyFields;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNConst, frmВходныеСчетаDocDialog, SWNUtils, SWNDBErrors,
  frmSelectGoodsToAddDialog, SWNSecurity, SWNSecurityFlags, SWNValueStorageUnit,
  frmImportGoodsPricesDialog, frmVhodnieScetaGoodsAnalyzeDialog, SWNCommonDialogs;

{$R *.dfm}

{ Tframe44ScetaVhodnieSceta }

procedure Tframe72Proiecte.bbCustomerDebtsClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe72Proiecte.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe72Proiecte.CreateNewRecord;
var
  dialog: TfrmVhodnieScetaDocDlg;
begin
  dialog := TfrmVhodnieScetaDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe72Proiecte.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Удалить запись №%d?', [dmDB.IBCQueryDocs.FieldByName
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
end;

procedure Tframe72Proiecte.DocSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete, fDebts, fImportGoods: Boolean;
  FLG_CLOSED: Boolean;
begin
  fDocNew := fSECURITY_CanNew;
  fDocEdit := False;
  fDocDelete := false;
  fDebts := False;
  fImportGoods := False;

  if cxGridPTNTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED;
    fDocDelete := fSECURITY_CanDelete and not FLG_CLOSED;
    fDebts := True;
    fImportGoods := not FLG_CLOSED;
  end
  else
  begin
    frameScanFile1.bbSaveAs.Enabled := False;
    frameScanFile1.bbDeleteFile.Enabled := False;
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

  bbCustomerDebts.Enabled := fDebts;
end;

procedure Tframe72Proiecte.DoFrameHide;
begin
     // Inchidem sursele din frame cu scan
  frameScanFile1.CloseDataSet;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridPTNTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridPTNTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe72Proiecte.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridPTNTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
  cxGridPTNTable.OnFocusedRecordChanged := WhenDocGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
  DocSelectionChanged;

     // 5. Open Dataset from ScanFrame
  frameScanFile1.OpenDataSet;
end;

procedure Tframe72Proiecte.dxBarPopupMenuDOCSPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

procedure Tframe72Proiecte.frameScanFile1bbAddFileClick(Sender: TObject);
begin
  inherited;
  frameScanFile1.bbAddFileClick(Sender);

end;

function Tframe72Proiecte.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe72Proiecte.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods];
end;

function Tframe72Proiecte.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe72Proiecte.InitFrameID: integer;
begin
     // Documentatia de proiect
  Result := 72;
  SetupQtyFields;
end;

procedure Tframe72Proiecte.ModifyRecord;
var
  dialog: TfrmVhodnieScetaDocDlg;
  FLG_CLOSED: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  if fSECURITY_CanEdit and not FLG_CLOSED then
  begin
    dialog := TfrmVhodnieScetaDocDlg.Create(Self);
    try
      dialog.CreateNewDocument := False;
      dialog.ShowModal;
    finally
      dialog.Free;
    end;
  end;
end;

procedure Tframe72Proiecte.SetupDefaultFocus;
begin
     // grid
  cxGridPTN.SetFocus;
     // columns
  cxGridPTN_CT_NAME.Focused := True;
end;

procedure Tframe72Proiecte.SetupQtyFields;
begin
     // Кол-во
end;

procedure Tframe72Proiecte.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Удалить);

  if not fSECURITY_CanEdit then
  begin
    bbAddGoods.Visible := ivNever;
    bbModifyGoods.Visible := ivNever;
    bbDeleteGoods.Visible := ivNever;
  end;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbCustomerDebts.Visible := ivNever;
    pnBottom.Visible := False;
  end;

  frameScanFile1.bbAddFile.Enabled := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_PROIECTE_DDP_Создать);
  frameScanFile1.bbDeleteFile.Enabled := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_PROIECTE_DDP_Удалить);
  frameScanFile1.bbSaveAs.Enabled := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_PROIECTE_DDP_Редактировать);

end;

procedure Tframe72Proiecte.WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocSelectionChanged;
end;

procedure Tframe72Proiecte.WhenDocumentPopupMenuOpen;
var
  fCreatePrihodRashod: Boolean;
  FLG_CLOSED: Boolean;
begin
  fCreatePrihodRashod := False;

  if (cxGridPTNTable.DataController.RecNo > 0) and (dmDB.IBCQueryDocs.FieldByName('HAS_JURNAL_GOODS').AsInteger
    = 1) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fCreatePrihodRashod := (not FLG_CLOSED);     // Создать Приходную накладную
  end;
     // popup menu
  bbDocComments.Enabled := fSECURITY_CanEdit;
end;

procedure Tframe72Proiecte.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe72Proiecte.cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and fSECURITY_CanEdit then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe72Proiecte.cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
  TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
                    // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := $008b8bc5
        else
          ACanvas.Font.Color := clGrayText;
      end;
    end;
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe72Proiecte.cxGridPTN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridPTN_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridPTN_DATA.Index]);
end;

end.

