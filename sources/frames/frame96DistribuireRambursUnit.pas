unit frame96DistribuireRambursUnit;

// Distribuirea rambursului
// FrameID = 96

interface

uses
  DBAccess, IBC, MemDS, SWNBaseFrameUnit, SWNDataFiltering, SWNDocumentFilters, cxCheckBox,
  cxClasses, cxControls, cxCustomData, cxDBData, cxData,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDataStorage, cxDropDownEdit, cxEdit,
  cxFilter, cxGraphics, cxGrid, cxGridCustomTableView, cxGridCustomView, cxGridDBTableView,
  cxGridLevel, cxGridTableView, cxLabel, cxLookAndFeelPainters, cxLookAndFeels, cxNavigator,
  cxSplitter, cxStyles, dxBar, dxDateRanges, dxScrollbarAnnotations, Data.DB, System.Classes,
  System.SysUtils, System.Variants, Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics,
  Vcl.StdCtrls, Winapi.Messages, Winapi.Windows, cxCurrencyEdit, dxUIAClasses;

type
  Tframe96DistribuireRamburs = class(TSWNBaseFrame)
    cxSplitter1: TcxSplitter;
    Panel1: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxSplitter2: TcxSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    cxGridBankPDNS: TcxGrid;
    cxGridBankPDNSTable: TcxGridDBTableView;
    cxGridBankPDNS_FLG_CLOSED: TcxGridDBColumn;
    cxGridBankPDNSTableDocID: TcxGridDBColumn;
    cxGridBankPDNS_DATA: TcxGridDBColumn;
    cxGridBankPDNSTableCtName: TcxGridDBColumn;
    cxGridBankPDNSTableSuma: TcxGridDBColumn;
    cxGridBankPDNSTableCurrencyName: TcxGridDBColumn;
    cxGridBankPDNSTableVAT: TcxGridDBColumn;
    cxGridBankPDNSTableRate: TcxGridDBColumn;
    cxGridBankPDNS_RATEUSD: TcxGridDBColumn;
    cxGridBankPDNSTableParentDocID: TcxGridDBColumn;
    cxGridBankPDNSTableFlgACNT: TcxGridDBColumn;
    cxGridBankPDNSTableCreatedBy: TcxGridDBColumn;
    cxGridBankPDNS_CT: TcxGridDBColumn;
    cxGridBankPDNS_DTSC_NAME: TcxGridDBColumn;
    cxGridBankPDNS_SC2_NAME: TcxGridDBColumn;
    cxGridBankPDNSLevel1: TcxGridLevel;
    IBCQueryDistributieRamburs: TIBCQuery;
    IBCDataSourceDistributieRamburs: TIBCDataSource;
    cxGridRamburs: TcxGrid;
    cxGridRambursDBTableView: TcxGridDBTableView;
    cxGridRambursDBTableViewCUSTOMERID: TcxGridDBColumn;
    cxGridRambursDBTableViewCUSTOMER_NAME: TcxGridDBColumn;
    cxGridRambursDBTableViewAWB: TcxGridDBColumn;
    cxGridRambursDBTableViewRAMBURS: TcxGridDBColumn;
    cxGridRambursDBTableViewPRET_LIVRARE: TcxGridDBColumn;
    cxGridRambursDBTableViewCOMISION: TcxGridDBColumn;
    cxGridRambursDBTableViewCONTRACTID: TcxGridDBColumn;
    cxGridRambursLevel1: TcxGridLevel;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bbCloseDocument: TdxBarButton;
    bbOpenDocument: TdxBarButton;
    bbImport: TdxBarButton;
    bbImportSS: TdxBarButton;
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure cxGridBankPDNSTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridRambursDBTableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbCloseDocumentClick(Sender: TObject);
    procedure bbOpenDocumentClick(Sender: TObject);
    procedure cxGridBankPDNSTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridRambursDBTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridBankPDNSTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbImportClick(Sender: TObject);
    procedure bbImportSSClick(Sender: TObject);
  private    { Private declarations }
    fSECURITY_New, fSECURITY_Edit, fSECURITY_Delete: Boolean;
    procedure SelectionChanged;
    procedure ShowEditorDlg(AIsNewRecord: Boolean);
    procedure LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
  protected    { Protected declarations }
    fSECURITY_CanEdit: Boolean;
    fSECURITY_CanView: Boolean;
    function InitFrameID: integer; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;

    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;

    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;
    procedure CloneRecord; override;

    procedure SetupSecurityItems; override;
  public    { Public declarations }
    procedure SetupDefaultFocus; override;

  end;

implementation

{$R *.dfm}

uses
  DataModuleDB, SWNSecurity, SWNSecurityFlags, SWNUtils, SWNDBErrors,
  frmDistributieRambursEditorDialog, SWNValueStorageUnit, DataModuleAdditions, frmBankPDNSDialog,
  SWNConst, System.UITypes, Vcl.Clipbrd, frmCustomerContractsDialog, frmImportDistributieRambursUnit;

{ Tframe47ActiuniMarketing }

procedure Tframe96DistribuireRamburs.bbCloseDocumentClick(Sender: TObject);
begin
  dmDB.ExecuteQuery('execute procedure close_distributie_ramburs(:docid)', [dmDB.IBCQueryDocs.FieldByName
    ('DOCID').AsInteger]);
  dmdb.IBCQueryDocs.RefreshRecord;

end;

procedure Tframe96DistribuireRamburs.bbDeleteClick(Sender: TObject);
begin
  inherited;
  if (MessageDlg('Stergeti inregistrarea', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    IBCQueryDistributieRamburs.Delete;
end;

procedure Tframe96DistribuireRamburs.bbEditClick(Sender: TObject);
begin
  ShowEditorDlg(False);
end;

procedure Tframe96DistribuireRamburs.bbImportClick(Sender: TObject);
var
  AWB: string;
  I: Integer;
  q: TIBCQuery;
  slist: TStringList;
  clipboard_array: TArray<string>;
  PretLivrare: string;
  SumaRamburs: string;
begin
  slist := TStringlist.Create;

  q := TIBCQuery.Create(self);
  q.SQL.Text := 'SELECT DOCID, CUSTOMERID, CUSTOMER_NAME FROM GET_AWB_FULLINFO(:AWB)';
  q.Prepare;
  slist.Text := Clipboard.AsText;

  try
    for I := 0 to slist.count - 1 do
    begin
      clipboard_array := slist[I].Split([#9]);
      AWB := clipboard_array[0];
      PretLivrare := iif(clipboard_array[1]='', 0, clipboard_array[1]);
      SumaRamburs := clipboard_array[2].Replace(' ', '');

      q.CLose;
      q.ParamByName('awb').AsString := AWB;
      q.Open;

      IBCQueryDistributieRamburs.Append;
      IBCQueryDistributieRamburs.FieldByName('CUSTOMERID').AsInteger := q.FieldByName('CUSTOMERID').AsInteger;
      IBCQueryDistributieRamburs.FieldByName('PRET_LIVRARE').Asstring := PretLivrare;
      IBCQueryDistributieRamburs.FieldByName('RAMBURS').Asstring := SumaRamburs;
      IBCQueryDistributieRamburs.FieldByName('AWB').Asstring := AWB;
      IBCQueryDistributieRamburs.FieldByName('COMISION').AsFloat := 0;
      IBCQueryDistributieRamburs.FieldByName('CONTRACTID').AsFloat := -1;
      IBCQueryDistributieRamburs.FieldByName('REFERER_DOCID').AsInteger := q.FieldByName('DOCID').AsInteger;

        // Load contract default values
      LoadDefaultContract(q.FieldByName('CUSTOMERID').AsInteger, dmdb.ibcquerydocs.FieldByName('DATA').AsDateTime);

      IBCQueryDistributieRamburs.Post;
    end
  finally
    q.Free;
    slist.Free;
  end;
end;

procedure Tframe96DistribuireRamburs.bbImportSSClick(Sender: TObject);
var
  AWB: string;
  PretLivrare: string;
  q: TIBCQuery;
  SumaRamburs: string;
begin
  q := TIBCQuery.Create(self);
  q.SQL.Text := 'SELECT DOCID, CUSTOMERID, CUSTOMER_NAME FROM GET_AWB_FULLINFO(:AWB)';
  q.Prepare;
  var d:=TfrmImportDistributieRambursDlg.Create(self);
  try
    if d.ShowModal=mrOK then
    begin
      for var I := 1 to d.dxSpreadSheet1.ActiveSheetAsTable.Rows.Count - 1 do
      begin
//        clipboard_array := slist[I].Split([#9]);
        AWB := d.dxSpreadSheet1.ActiveSheetAsTable.Cells[i, 0].AsString;
        SumaRamburs := d.dxSpreadSheet1.ActiveSheetAsTable.Cells[i, 1].AsString;
        PretLivrare := d.dxSpreadSheet1.ActiveSheetAsTable.Cells[i, 2].AsString;


        q.CLose;
        q.ParamByName('awb').AsString := AWB;
        q.Open;

        IBCQueryDistributieRamburs.Append;
        IBCQueryDistributieRamburs.FieldByName('CUSTOMERID').AsInteger := q.FieldByName('CUSTOMERID').AsInteger;
        IBCQueryDistributieRamburs.FieldByName('PRET_LIVRARE').Asstring := PretLivrare;
        IBCQueryDistributieRamburs.FieldByName('RAMBURS').Asstring := SumaRamburs;
        IBCQueryDistributieRamburs.FieldByName('AWB').Asstring := AWB;
        IBCQueryDistributieRamburs.FieldByName('COMISION').AsFloat := 0;
        IBCQueryDistributieRamburs.FieldByName('CONTRACTID').AsFloat := -1;
        IBCQueryDistributieRamburs.FieldByName('REFERER_DOCID').AsInteger := q.FieldByName('DOCID').AsInteger;

          // Load contract default values
        LoadDefaultContract(q.FieldByName('CUSTOMERID').AsInteger, dmdb.ibcquerydocs.FieldByName('DATA').AsDateTime);

        IBCQueryDistributieRamburs.Post;
      end
    end;
  finally
    q.Free;
    d.Free;
  end;

end;

procedure Tframe96DistribuireRamburs.LoadDefaultContract(const CustomerID: Integer; const DocDate:
  TDateTime);
var
  contractInfo: TCustomerDefultContractInfo;
  dialog: TfrmContractsDlg;
begin
  dialog := TfrmContractsDlg.Create(self);
  try
//    contractInfo := LoadCustomerDefaultContractInfo(IBCQueryDistributieRamburs.FieldByName('DT').AsInteger, CustomerID, DocDate);
//    if Assigned(contractInfo) then
//    begin
//            dmdb.ibcquerydocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//            dmdb.ibcquerydocs.FieldByName('FLG_ACNT').AsInteger := 1;
//      contractInfo.Free;
//    end
//    else
//    begin
//            dmdb.ibcquerydocs.FieldByName('CONTRACTID').Value := -1;
//    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe96DistribuireRamburs.bbNewClick(Sender: TObject);
begin
  ShowEditorDlg(True);
end;

procedure Tframe96DistribuireRamburs.bbOpenDocumentClick(Sender: TObject);
begin
  inherited;
  dmDB.ExecuteQuery('execute procedure open_distributie_ramburs(:docid)', [dmDB.IBCQueryDocs.FieldByName
    ('DOCID').AsInteger]);
  dmdb.IBCQueryDocs.RefreshRecord;
end;

procedure Tframe96DistribuireRamburs.ShowEditorDlg(AIsNewRecord: Boolean);
var
  dialog: TfrmDistributieRambursEditorDlg;
begin
  dialog := TfrmDistributieRambursEditorDlg.Create(Self, IBCQueryDistributieRamburs,
    IBCDataSourceDistributieRamburs);
  try
    dialog.DocumentDate := dmdb.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    dialog.IsNewRecord := AIsNewRecord;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe96DistribuireRamburs.CloneRecord;
begin
  inherited;
end;

procedure Tframe96DistribuireRamburs.CreateNewRecord;
var
  editor: TfrmBankPDNSDlg;
begin
  editor := TfrmBankPDNSDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    editor.CreateNewDocument := True;
    editor.DocTypeID := dmdb.CurrentDocTypeID;
    editor.ShowModal;
  finally
    editor.Free;
  end;
end;

procedure Tframe96DistribuireRamburs.cxGridBankPDNSTableFocusedRecordChanged(Sender:
  TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
var
  ButtonState: Boolean;
begin
  if Sender.DataController.RecordCount > 0 then
    ButtonState := (AFocusedRecord.Values[cxGridBankPDNS_FLG_CLOSED.Index] = 0)
  else
    ButtonState := True;

  bbNew.Enabled := ButtonState;
  bbEdit.Enabled := ButtonState;
  bbDelete.Enabled := ButtonState;

  IBCQueryDistributieRamburs.Close;
  IBCQueryDistributieRamburs.DeleteWhere;
//    if (FrameDataFilterInfo.CustomerID > -1) then
//        ibcquerydistributieRamburs.Addwhere('customerid = ' + dmdb.IBCQueryDocs.FieldByName('CT').AsString);
  IBCQueryDistributieRamburs.Open;

end;

procedure Tframe96DistribuireRamburs.cxGridBankPDNSTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridBankPDNSTable, Key, Shift);
end;

procedure Tframe96DistribuireRamburs.cxGridBankPDNSTableStylesGetContentStyle(Sender:
  TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle:
  TcxStyle);
begin
  inherited;
  if not VarIsNull(ARecord.Values[cxGridBankPDNS_FLG_CLOSED.Index]) then
  begin
    if ARecord.Values[cxGridBankPDNS_FLG_CLOSED.Index] = 1 then
    begin
      AStyle := dmAdditions.cxStyle_TextGrayStrike;
      AStyle.Font.Style := AStyle.Font.Style + [fsStrikeOut];
    end;
  end;

end;

procedure Tframe96DistribuireRamburs.cxGridRambursDBTableViewFocusedRecordChanged(Sender:
  TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  SelectionChanged;
end;

procedure Tframe96DistribuireRamburs.cxGridRambursDBTableViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  SWNUtils.ProcessCommonKeys(Self, cxGridRambursDBTableView, Key, Shift);
end;

procedure Tframe96DistribuireRamburs.DeleteRecord;
begin
  if (dmDB.IBCQueryDocs.RecordCount = 0) then
    exit;

  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_ÁÀÍÊ_ÏÄÍÑ, [dmDB.IBCQueryDocs.FieldByName
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

procedure Tframe96DistribuireRamburs.DoFrameHide;
begin
  dmdb.IBCQueryDocs.Close;
  IBCQueryDistributieRamburs.Close;
     // 1. Legam grid-urile de datasource-sele
  cxGridBankPDNSTable.DataController.DataSource := nil;
  cxGridRambursDBTableView.DataController.DataSource := nil;

  inherited;
end;

function Tframe96DistribuireRamburs.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate];
end;

function Tframe96DistribuireRamburs.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH, fbtAdd, fbtMODIFY, fbtDELETE];
end;

function Tframe96DistribuireRamburs.InitFrameID: integer;
begin
  Result := 96;

end;

procedure Tframe96DistribuireRamburs.ModifyRecord;
var
  editor: TfrmBankPDNSDlg;
  FLG_CLOSED: Boolean;
  ReadOnly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;

  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  if fSECURITY_CanEdit then
    ReadOnly := FLG_CLOSED
  else
    ReadOnly := fSECURITY_CanView;

  editor := TfrmBankPDNSDlg.Create(Self, dmdb.IBCQueryDocs, dmdb.IBCDataSourceDocs);
  try
    editor.CreateNewDocument := False;
    editor.ReadOnly := ReadOnly;
    editor.DocTypeID := dmdb.CurrentDocTypeID;
    editor.ShowModal;
  finally
    editor.Free;
  end;
end;

procedure Tframe96DistribuireRamburs.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    ReadGridColumnsSettings(cxGridBankPDNSTable);
    ReadGridColumnsSettings(cxGridRambursDBTableView);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe96DistribuireRamburs.RefreshData;
begin
  dmDB.IBCQueryDocs.Refresh;
  IBCQueryDistributieRamburs.Refresh;
end;

procedure Tframe96DistribuireRamburs.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
    SaveGridColumnsSettings(cxGridBankPDNSTable);
    SaveGridColumnsSettings(cxGridRambursDBTableView);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe96DistribuireRamburs.SelectionChanged;
var
//    fNew:Boolean;
  fEdit, fDelete: Boolean;
begin
//    fNew := fSECURITY_New;
  fEdit := False;
  fDelete := False;

  if cxGridBankPDNSTable.DataController.RecNo > 0 then
  begin
    fEdit := fSECURITY_Edit;
    fDelete := fSECURITY_Delete;
  end;

//   ButtonStateChanged(fbtADD,fNew);
  ButtonStateChanged(fbtMODIFY, fEdit);
  ButtonStateChanged(fbtDELETE, fDelete);
end;

procedure Tframe96DistribuireRamburs.SetupDefaultFocus;
begin
  cxGridBankPDNS.SetFocus;
//  cxGridPromoTicketsTableTICKET_CODE.Focused := True;
end;

procedure Tframe96DistribuireRamburs.SetupSecurityItems;
begin
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Modifica_inregistrarea);
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Vizializare);
  fSECURITY_New := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Inregistrarea_noua);
  fSECURITY_Edit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Modifica_inregistrarea);
  fSECURITY_Delete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Sterge_inregistrarea);
end;

procedure Tframe96DistribuireRamburs.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  cxGridBankPDNSTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

  OpenExternalData(FrameDataFilterInfo);

  IBCQueryDistributieRamburs.Close;
  IBCQueryDistributieRamburs.MasterFields := 'DOCID';
  IBCQueryDistributieRamburs.DetailFields := 'DOCID';
  IBCQueryDistributieRamburs.MasterSource := dmDB.IBCDataSourceDocs;

//    IBCQueryDistributieRamburs.DeleteWhere;
//    if (FrameDataFilterInfo.CustomerID > -1) then
//        ibcquerydistributieRamburs.Addwhere('customerid = ' + dmdb.IBCQueryDocs.FieldByName('CT').AsString);
  IBCQueryDistributieRamburs.Open;

     // 1. Legam grid-urile de datasource-sele
  cxGridBankPDNSTable.DataController.DataSource := dmdb.IBCDataSourceDocs;
  cxGridRambursDBTableView.DataController.DataSource := IBCDataSourceDistributieRamburs;
end;

function Tframe96DistribuireRamburs.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs];
end;

end.

