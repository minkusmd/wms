unit frmServiceNewIncidentEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPC, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, cxImage, StdCtrls, cxMemo, cxCheckListBox, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCalendar, cxStyles, cxClasses, cxGridLevel, cxGrid,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxCheckBox, cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, DB, DBAccess, IBC, MemDS, ExtCtrls, Menus, cxTL, cxTLdxBarBuiltInMenu, cxInplaceContainer,
  ComCtrls, RzTreeVw, cxPCdxBarPopupMenu, cxNavigator, cxButtonEdit, cxButtons, cxMRUEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses,
  dxCoreGraphics;

type

  TServiceAimItem = class
    SCOPID: integer;
    FLG_FOLDER: Boolean;
    Title: String;
    Description: String;
    Hours: integer;
  end;

  TfrmServiceNewIncidentEditorDlg = class(TSWNMasteredFormClass)
    btnOK: TButton;
    btnCancel: TButton;
    IBCQueryVendors: TIBCQuery;
    IBCDataSourceVendors: TIBCDataSource;
    IBCQueryPriority: TIBCQuery;
    IBCDataSourcePriority: TIBCDataSource;
    IBC_SYSS: TIBCQuery;
    IBCDS_SYSS: TIBCDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edGOODS_SN: TcxDBTextEdit;
    edGOODS_MODEL: TcxDBTextEdit;
    lcbVENDOR_ID: TcxDBLookupComboBox;
    mmGOODS_TITLE: TcxDBTextEdit;
    Label13: TLabel;
    Label14: TLabel;
    Panel2: TPanel;
    Label9: TLabel;
    lbDefectPresets: TLabel;
    Label7: TLabel;
    lbAspect: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    mmDEFECTE_DSC: TcxDBMemo;
    CheckTreeAIMs: TRzCheckTree;
    mmASPECT_VISUAL_DSC: TcxDBMemo;
    cxGridGarn: TcxGrid;
    cxGridGarnTable: TcxGridTableView;
    cxGridGarnID: TcxGridColumn;
    cxGridGarnSELECTION: TcxGridColumn;
    cxGridGarnTITLE: TcxGridColumn;
    cxGridGarnLevel: TcxGridLevel;
    lcbPRIORITY_LEVEL_ID: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    Label5: TLabel;
    Label6: TLabel;
    lcbINBAZA_DOC_NAME: TcxDBComboBox;
    edINBAZA_DOCNO: TcxDBTextEdit;
    Label11: TLabel;
    Label12: TLabel;
    edINBAZA_DATE: TcxDBDateEdit;
    edClient: TcxTextEdit;
    lbcTypeID: TcxDBLookupComboBox;
    Label15: TLabel;
    clbSolvedBy: TcxDBLookupComboBox;
    IBC_USERS: TIBCQuery;
    IBCDS_USERS: TIBCDataSource;
    beCTSC_NAME: TcxButtonEdit;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    Label16: TLabel;
    Label17: TLabel;
    teComments: TcxTextEdit;
    btnAddComments: TcxButton;
    lcbEXEC_PERSONAL_GROUP: TcxDBLookupComboBox;
    Label18: TLabel;
    IBCDS_EXEC_PERSONAL_GROUP: TIBCDataSource;
    IBC_EXEC_PERSONAL_GROUP: TIBCQuery;
    procedure lbDefectPresetsClick(Sender: TObject);
    procedure cxGridGarnTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridGarnTableDataControllerRecordChanged(ADataController: TcxCustomDataController;
      ARecordIndex, AItemIndex: integer);
    procedure cxGridAimTableDataControllerRecordChanged(ADataController: TcxCustomDataController;
      ARecordIndex, AItemIndex: integer);
    procedure FormDestroy(Sender: TObject);
    procedure CheckTreeAIMsChange(Sender: TObject; Node: TTreeNode);
    procedure beCTSC_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure btnAddCommentsClick(Sender: TObject);
    procedure clbSolvedByPropertiesCloseUp(Sender: TObject);
    procedure lbAspectClick(Sender: TObject);
    procedure lbcTypeIDPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure beCTSC_NAMEPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    { Private declarations }
    fRepairType: integer;
    fAimsChanged: Boolean;
    fGarnituraChanged: Boolean;
    FPlatitor_Name: String;
    FSolvedby: integer;

    function CheckInputValues: Boolean;
    procedure SetPlatitor_Name(const Value: String);

    procedure ShowRepairAims(const ParentNode: TTreeNode; const ScopParentID: integer);
    function HasRepairAims: Boolean;
    procedure SaveRepairAims;
    procedure ClearAIMTree;
    function GetNodeSelectionType(const ParentNode: TTreeNode): TRzCheckState;

    procedure AppendTextToDefecte(const Text:String);
    procedure ShowSelecteDefecteProdusDialog;

    procedure AppendTextToAspectVizual(const Text:String);
    procedure ShowSelectAspectVizualDialog;

    procedure ShowGranitura;
    function HasGarnituraSelection: Boolean;
    procedure SaveGarnitura;
    procedure SetPlatitorName(const Value: String);

  protected
    procedure InitializeEditors;
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    property Platitor_Name: String read FPlatitor_Name write SetPlatitorName;

  end;

implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, DateUtils, frmCustomersDlg, frmServiceNewIncidentVVTDialog,
  frmServiceNewIncidentOPDDialog;

{$R *.dfm}
{ TfrmServiceNewIncidentEditorDlg }

procedure TfrmServiceNewIncidentEditorDlg.AppendTextToAspectVizual(const Text: String);
var S, delimiter: String;
    C: Char;
begin
     if mmASPECT_VISUAL_DSC.EditModified then mmASPECT_VISUAL_DSC.PostEditValue;

     S := dmDB.IBC_INCIDENTE_BLOB.FieldByName('ASPECT_VISUAL_DSC').AsString;
     delimiter:='';
     if S <> '' then
     begin
          C := S[Length(S)];
          if (C <> ' ') and (C <> #10) then delimiter:=' ';
     end;
     dmDB.IBC_INCIDENTE_BLOB.Edit;
     dmDB.IBC_INCIDENTE_BLOB.FieldByName('ASPECT_VISUAL_DSC').AsString := S + delimiter + Text + #13#10;
     mmASPECT_VISUAL_DSC.SelStart := Length(dmDB.IBC_INCIDENTE_BLOB.FieldByName('ASPECT_VISUAL_DSC').AsString);
end;

procedure TfrmServiceNewIncidentEditorDlg.AppendTextToDefecte(const Text: String);
var S,delimiter: String;
    C: Char;
begin
     delimiter:='';
     if mmDEFECTE_DSC.EditModified then mmDEFECTE_DSC.PostEditValue;
     S := dmDB.IBC_INCIDENTE_BLOB.FieldByName('DEFECTE_DSC').AsString;
     if S <> '' then
     begin
          C := S[Length(S)];
          if (C <> ' ') and (C <> #10) then delimiter:=' ';
     end;
     dmDB.IBC_INCIDENTE_BLOB.Edit;
     dmDB.IBC_INCIDENTE_BLOB.FieldByName('DEFECTE_DSC').AsString := S + delimiter + Text + #13#10;
     mmDEFECTE_DSC.SelStart := Length(dmDB.IBC_INCIDENTE_BLOB.FieldByName('DEFECTE_DSC').AsString);
end;

procedure TfrmServiceNewIncidentEditorDlg.beCTSC_NAMEPropertiesButtonClick(Sender: TObject;
  AButtonIndex: integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    // dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('PAYERID').asInteger, False, 0,
      'Alegerea platitorului pentru reparatia in garantie') then
    begin
      fMasterDataSet.FieldByName('PAYERID').asInteger := dialog.CustomerID;
      beCTSC_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceNewIncidentEditorDlg.beCTSC_NAMEPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
var
     fIsSetValue: boolean;
begin
   Error := False;
   fIsSetValue := (vartostr(DisplayValue)<>'NULL');

   if not (fIsSetValue) then
   begin
        Error := True;
        ErrorText := 'Setati platitorul incidentului...';
   end;
end;

procedure TfrmServiceNewIncidentEditorDlg.btnAddCommentsClick(Sender: TObject);
//var
//  q: TIBCQuery;
begin
  if teComments.Text = '' then
    exit;

  dmDB.IBC_INCIDENTE_BLOB.Edit;
  // q := TIBCQuery.Create(Self);

  if dmDB.IBC_INCIDENTE_BLOB.FieldByName('Comments').AsString = '' then
    dmDB.IBC_INCIDENTE_BLOB.FieldByName('Comments').AsString :=
      Format('%s (%s) - %s', [dmDB.CurrentUserFullName, FormatDateTime('dd.mm.yyyy hh:nn', NOW),
      teComments.Text])
  else
    dmDB.IBC_INCIDENTE_BLOB.FieldByName('Comments').AsString :=
      dmDB.IBC_INCIDENTE_BLOB.FieldByName('Comments').AsString + #13#10 +
      Format('%s (%s) - %s', [dmDB.CurrentUserFullName, FormatDateTime('dd.mm.yyyy hh:nn', NOW),
      teComments.Text]);

//  q.Transaction := dmDB.IBCTrDefaultUpdate;
//  q.SQL.Text := 'Update sc_incidente set comments=:comments where INCIDENTID=:INCIDENTID';

  // if q.FieldByName('Comments').AsString = '' then
  // q.ParamByName('Comments').AsString :=
  // Format('%s (%s) - %s', [dmDB.CurrentUserFullName, FormatDateTime('dd.mm.yyyy hh:nn', NOW),
  // teComments.Text])
  // else
  // q.ParamByName('Comments').AsString := dmDB.IBC_INCIDENTE_BLOB.FieldByName('Comments').AsString + #13#10
  // + Format('%s (%s) - %s', [dmDB.CurrentUserFullName, FormatDateTime('dd.mm.yyyy hh:nn', NOW),
  // teComments.Text]);

  // q.ParamByName('INCIDENTID').asInteger := dmDB.IBCQueryIncidente.FieldByName('INCIDENTID').asInteger;
  //
  // if not dmDB.IBCTrDefaultUpdate.Active then
  // q.Transaction.StartTransaction;
  //
  // q.ExecSQL;
  // q.Transaction.Commit;
  // finally
  // FreeAndNil(q);
  // end;
  dmDB.IBC_INCIDENTE_BLOB.Post;
  dmDB.IBC_INCIDENTE_BLOB.RefreshRecord;
  teComments.Text := '';
end;

function TfrmServiceNewIncidentEditorDlg.CheckInputValues: Boolean;
var
  ErrorStr: String;
begin
  ErrorStr := '';
  Result := False;

  // Описание товара
  if fMasterDataSet.FieldByName('VENDOR_ID').IsNull or (fMasterDataSet.FieldByName('VENDOR_ID').asInteger = -1)
  then
    AddErrorToStr(ErrorStr, 'Producator!');
  if fMasterDataSet.FieldByName('GOODS_MODEL').IsNull or
    (Trim(fMasterDataSet.FieldByName('GOODS_MODEL').AsString) = '') then
    AddErrorToStr(ErrorStr, 'Model!');

  // Цель и описание дефекта
  if Not HasRepairAims then
    AddErrorToStr(ErrorStr, 'Scopul reparatiei!');
  if dmDB.IBC_INCIDENTE_BLOB.FieldByName('DEFECTE_DSC').IsNull or
    (Trim(dmDB.IBC_INCIDENTE_BLOB.FieldByName('DEFECTE_DSC').AsString) = '') then
    AddErrorToStr(ErrorStr, 'Descrierea presupusului defect!');

  // Внешний вид и комплектация
  if dmDB.IBC_INCIDENTE_BLOB.FieldByName('ASPECT_VISUAL_DSC').IsNull or
    (Trim(dmDB.IBC_INCIDENTE_BLOB.FieldByName('ASPECT_VISUAL_DSC').AsString) = '') then
    AddErrorToStr(ErrorStr, 'Aspectul exterior al produsului!');
  if Not HasGarnituraSelection then
    AddErrorToStr(ErrorStr, 'Complectatia!');

  // дата окончания работы приблизительная
  // or
  // (DateOf(fMasterDataSet.FieldByName('DATA_EST_FINISH').AsDateTime) <= DateOf(NOW))
  if fMasterDataSet.FieldByName('DATA_EST_FINISH').IsNull then
    AddErrorToStr(ErrorStr, 'Nu este indicat timpul estimativ de finisare!');

  if fMasterDataSet.FieldByName('PRIORITY_LEVEL_ID').IsNull or
    (fMasterDataSet.FieldByName('PRIORITY_LEVEL_ID').asInteger = -1) then
    AddErrorToStr(ErrorStr, 'Prioritatea executarii!');

  // Тип инцидента
  if fMasterDataSet.FieldByName('TYPE_ID').IsNull or (fMasterDataSet.FieldByName('TYPE_ID').asInteger = -1)
  then
    AddErrorToStr(ErrorStr, 'Tip incident!');

  // Ответственный инцидент!
  // if fMasterDataSet.FieldByName(' SOLVED_BY').IsNull or (fMasterDataSet.FieldByName(' SOLVED_BY').asInteger = -1)
  // then
  // AddErrorToStr(ErrorStr, 'Ответственный инцидент!');
  //
  if fMasterDataSet.FieldByName('TYPE_ID').asInteger = 6002 then // гарантийный ремонт
  begin
    // Документ на основании
    if fMasterDataSet.FieldByName('inbaza_doc_name').IsNull or
      (Trim(fMasterDataSet.FieldByName('inbaza_doc_name').AsString) = '') then
      AddErrorToStr(ErrorStr, 'In baza documentului!');

    // Документ на основании Дата
    if fMasterDataSet.FieldByName('INBAZA_DATE').IsNull or
      (DateOf(fMasterDataSet.FieldByName('INBAZA_DATE').AsDateTime) > DateOf(NOW)) then
      AddErrorToStr(ErrorStr, 'Data documentului in baza caruie este creat!');
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmServiceNewIncidentEditorDlg.CheckTreeAIMsChange(Sender: TObject; Node: TTreeNode);
begin
  fAimsChanged := True;
end;

procedure TfrmServiceNewIncidentEditorDlg.clbSolvedByPropertiesCloseUp(Sender: TObject);
begin
  if FSolvedby <> IBCDS_USERS.DataSet.FieldByName('USERID').asInteger then
  begin
    try
      dmDB.IBC_INCIDENTE_BLOB.Edit;
      dmDB.IBC_INCIDENTE_BLOB.FieldByName('Comments').AsString := dmDB.IBC_INCIDENTE_BLOB.FieldByName('Comments').AsString + #13#10
        + Format('%s (%s) - %s', [dmDB.CurrentUserFullName, FormatDateTime('dd.mm.yyyy hh:nn', NOW),
        'Responsabil: ' + IBCDS_USERS.DataSet.FieldByName('FULL_NAME').AsString]);
    finally
      dmDB.IBC_INCIDENTE_BLOB.Post;
    end;
//    dmDB.IBC_INCIDENTE_BLOB.RefreshRecord;

  end;
end;

procedure TfrmServiceNewIncidentEditorDlg.ClearAIMTree;
var
  Node, Node2: TTreeNode;
  Data: TServiceAimItem;
begin
  Node := CheckTreeAIMs.Items.GetFirstNode;
  while Node <> nil do
  begin
    Data := TServiceAimItem(Node.Data);
    Data.Free;
    // check children
    Node2 := Node.getFirstChild;
    while Node2 <> nil do
    begin
      Data := TServiceAimItem(Node2.Data);
      Data.Free;
      Node2 := Node2.getNextSibling;
    end;
    Node := Node.getNextSibling;
  end;
  CheckTreeAIMs.Items.Clear;
end;

procedure TfrmServiceNewIncidentEditorDlg.cxGridAimTableDataControllerRecordChanged
  (ADataController: TcxCustomDataController; ARecordIndex, AItemIndex: integer);
begin
  fAimsChanged := True;
end;

procedure TfrmServiceNewIncidentEditorDlg.cxGridGarnTableDataControllerRecordChanged
  (ADataController: TcxCustomDataController; ARecordIndex, AItemIndex: integer);
begin
  fGarnituraChanged := True;
end;

procedure TfrmServiceNewIncidentEditorDlg.cxGridGarnTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if Not VarIsNull(ARecord.Values[cxGridGarnSELECTION.Index]) then
  begin
    if ARecord.Values[cxGridGarnSELECTION.Index] then
      AStyle := dmAdditions.cxStyle_SCSelection;
  end;
end;

procedure TfrmServiceNewIncidentEditorDlg.FormDestroy(Sender: TObject);
begin
  ClearAIMTree;
end;

function TfrmServiceNewIncidentEditorDlg.GetNodeSelectionType(const ParentNode: TTreeNode): TRzCheckState;
var
  Node: TTreeNode;
  nodes, checked: integer;
begin
  nodes := 0;
  checked := 0;
  Node := ParentNode.getFirstChild;
  while Node <> nil do
  begin
    inc(nodes);
    if CheckTreeAIMs.ItemState[Node.AbsoluteIndex] = csChecked then
      inc(checked);
    Node := Node.getNextSibling;
  end;
  if nodes = 0 then
    Result := csUnchecked
  else if (checked > 0) and (checked <> nodes) then
    Result := csPartiallyChecked
  else if (checked = nodes) then
    Result := csChecked;
end;

function TfrmServiceNewIncidentEditorDlg.HasGarnituraSelection: Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to cxGridGarnTable.DataController.RecordCount - 1 do
    if (cxGridGarnTable.DataController.Values[i, cxGridGarnSELECTION.Index] = True) then
    begin
      Result := True;
      Break;
    end;
end;

function TfrmServiceNewIncidentEditorDlg.HasRepairAims: Boolean;
var
  Node: TTreeNode;
begin
  Result := False;
  Node := CheckTreeAIMs.Items.GetFirstNode;
  while Node <> nil do
  begin
    if (CheckTreeAIMs.ItemState[Node.Index] = csChecked) or
      (CheckTreeAIMs.ItemState[Node.Index] = csPartiallyChecked) then
    begin
      Result := True;
      Break;
    end;
    Node := Node.getNextSibling;
  end;
end;

procedure TfrmServiceNewIncidentEditorDlg.InitializeEditors;
begin
     beCTSC_NAME.Properties.ErrorIcon.Assign(cxEditErrorIcon);
//     cbAddress.Properties.ErrorIcon.Assign(cxEditInfoIcon);
end;

procedure TfrmServiceNewIncidentEditorDlg.BindingDataSource;
begin
  inherited;
  fMasterDataSource.DataSet.Open;
  mmGOODS_TITLE.DataBinding.DataSource := fMasterDataSource;
  edGOODS_SN.DataBinding.DataSource := fMasterDataSource;
  lcbVENDOR_ID.DataBinding.DataSource := fMasterDataSource;
  edGOODS_MODEL.DataBinding.DataSource := fMasterDataSource;
  lcbPRIORITY_LEVEL_ID.DataBinding.DataSource := fMasterDataSource;

  cxDBTextEdit1.DataBinding.DataSource := fMasterDataSource;
  cxDBTextEdit1.DataBinding.DataSource := fMasterDataSource;

  edINBAZA_DATE.DataBinding.DataSource := fMasterDataSource;
  edINBAZA_DOCNO.DataBinding.DataSource := fMasterDataSource;
  lcbINBAZA_DOC_NAME.DataBinding.DataSource := fMasterDataSource;
  lbcTypeID.DataBinding.DataSource := fMasterDataSource;
  clbSolvedBy.DataBinding.DataSource := fMasterDataSource;
  lcbEXEC_PERSONAL_GROUP.DataBinding.DataSource := fMasterDataSource;

  FSolvedby := clbSolvedBy.DataBinding.DataSource.DataSet.FieldByName('Solved_By').asInteger;
  lbcTypeID.Properties.ListSource := IBCDS_SYSS;

  edClient.Text := fMasterDataSource.DataSet.FieldByName('DOC_CUSTOMER').AsString;
  beCTSC_NAME.Text := dmDB.GetCustomerDisplayName(fMasterDataSource.DataSet.FieldByName('PAYERID').Value);

  dmDB.IBC_INCIDENTE_BLOB.Close;
  dmDB.IBC_INCIDENTE_BLOB.FilterSQL := 'INCIDENTID=' + fMasterDataSet.FieldByName('INCIDENTID').AsString;
  dmDB.IBC_INCIDENTE_BLOB.Open;

  mmCOMMENTS.DataBinding.DataSource := dmDB.IBCDS_INCIDENTE_BLOB;
  mmDEFECTE_DSC.DataBinding.DataSource := dmDB.IBCDS_INCIDENTE_BLOB;
  mmASPECT_VISUAL_DSC.DataBinding.DataSource := dmDB.IBCDS_INCIDENTE_BLOB;

end;

function TfrmServiceNewIncidentEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckInputValues then
  begin
    if fMasterDataSet.State in [dsEdit, dsInsert] then
      fMasterDataSet.Post;

    if dmDB.IBC_INCIDENTE_BLOB.State in [dsEdit, dsInsert] then
      dmDB.IBC_INCIDENTE_BLOB.Post;

    if fAimsChanged then
      SaveRepairAims;
    if fGarnituraChanged then
      SaveGarnitura;

    dmDB.IBC_INCIDENTE_BLOB.Close;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmServiceNewIncidentEditorDlg.lbAspectClick(Sender: TObject);
begin
     ShowSelectAspectVizualDialog;
end;

procedure TfrmServiceNewIncidentEditorDlg.lbcTypeIDPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  if dmDB.IBCQueryINCIDENTE.FieldByName('Type_ID').AsString ='' then
  begin
     Error := True;
     ErrorText := 'Indicati tipul reparatiei!';
  end;
end;

procedure TfrmServiceNewIncidentEditorDlg.lbDefectPresetsClick(Sender: TObject);
begin
     ShowSelecteDefecteProdusDialog;
end;

procedure TfrmServiceNewIncidentEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    fRepairType := fMasterDataSet.FieldByName('TYPE_ID').asInteger;

    fMasterDataSet.Edit;

    IBCQueryVendors.Active := True;

    ShowRepairAims(nil, 0);
    ShowGranitura;
    IBCQueryPriority.Active := True;
    IBC_SYSS.Open;
    IBC_USERS.Open;
    IBC_EXEC_PERSONAL_GROUP.Open;
    dmDB.IBC_INCIDENTE_BLOB.Open;
    InitializeEditors;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmServiceNewIncidentEditorDlg.SaveGarnitura;
var
  Query: TIBCQuery;
  i: integer;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    // 1. delete old content
    Query.SQL.Text := 'DELETE FROM SC_INCIDENT_GARNITURA WHERE INCIDENTID=:id';
    Query.ParamByName('id').asInteger := fMasterDataSet.FieldByName('INCIDENTID').asInteger;
    Query.ExecSQL;
    // 2. create new list
    Query.SQL.Text := 'INSERT INTO SC_INCIDENT_GARNITURA (INCIDENTID,GARNITURA_ID) VALUES (:id,:id2)';
    Query.ParamByName('id').asInteger := fMasterDataSet.FieldByName('INCIDENTID').asInteger;
    for i := 0 to cxGridGarnTable.DataController.RecordCount - 1 do
      if cxGridGarnTable.DataController.Values[i, cxGridGarnSELECTION.Index] = True then
      begin
        Query.ParamByName('id2').asInteger := cxGridGarnTable.DataController.Values[i, cxGridGarnID.Index];
        Query.ExecSQL;
      end;
  finally
    Query.Free;
  end;
end;

procedure TfrmServiceNewIncidentEditorDlg.SaveRepairAims;
var
  Query: TIBCQuery;
  Node, Node2: TTreeNode;
  Data: TServiceAimItem;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    // 1. delete old content
    Query.SQL.Text := 'DELETE FROM SC_INCIDENT_SCOP WHERE INCIDENTID=:id';
    Query.ParamByName('id').asInteger := fMasterDataSet.FieldByName('INCIDENTID').asInteger;
    Query.ExecSQL;
    // 2. create new list
    Query.SQL.Text := 'INSERT INTO SC_INCIDENT_SCOP (INCIDENTID,SCOPID) VALUES (:id,:id2)';
    Query.ParamByName('id').asInteger := fMasterDataSet.FieldByName('INCIDENTID').asInteger;

    Node := CheckTreeAIMs.Items.GetFirstNode;
    while Node <> nil do
    begin
      Data := TServiceAimItem(Node.Data);
      if Not Data.FLG_FOLDER and (CheckTreeAIMs.ItemState[Node.AbsoluteIndex] = csChecked) then
      begin
        Query.ParamByName('id2').asInteger := Data.SCOPID;
        Query.ExecSQL;
      end;
      // check children
      if Data.FLG_FOLDER then
      begin
        Node2 := Node.getFirstChild;
        while Node2 <> nil do
        begin
          Data := TServiceAimItem(Node2.Data);
          if (CheckTreeAIMs.ItemState[Node2.AbsoluteIndex] = csChecked) then
          begin
            Query.ParamByName('id2').asInteger := Data.SCOPID;
            Query.ExecSQL;
          end;
          Node2 := Node2.getNextSibling;
        end;
      end;
      Node := Node.getNextSibling;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmServiceNewIncidentEditorDlg.SetPlatitor_Name(const Value: String);
begin
  FPlatitor_Name := Value;
end;

procedure TfrmServiceNewIncidentEditorDlg.SetPlatitorName(const Value: String);
begin
  FPlatitor_Name := Value;
end;

procedure TfrmServiceNewIncidentEditorDlg.ShowGranitura;
var
  Query: TIBCQuery;
  N: integer;
begin
  cxGridGarnTable.BeginUpdate;
  Query := TIBCQuery.Create(Self);
  try
    Query.SQL.Add
      ('SELECT SYSSID, TITLE, IIF(EXISTS(SELECT GARNITURA_ID FROM SC_INCIDENT_GARNITURA WHERE INCIDENTID=:id AND GARNITURA_ID=SYSSID),1,0)');
    Query.SQL.Add('FROM TS_SYSS WHERE PARENTID=29');
    Query.ParamByName('id').asInteger := fMasterDataSet.FieldByName('INCIDENTID').asInteger;
    Query.ExecSQL;
    while Not Query.Eof do
    begin
      N := cxGridGarnTable.DataController.AppendRecord;
      cxGridGarnTable.DataController.Values[N, cxGridGarnID.Index] := Query.Fields[0].asInteger;
      cxGridGarnTable.DataController.Values[N, cxGridGarnSELECTION.Index] := Query.Fields[2].asInteger = 1;
      cxGridGarnTable.DataController.Values[N, cxGridGarnTITLE.Index] := Query.Fields[1].AsString;
      Query.Next;
    end;
  finally
    Query.Free;
    cxGridGarnTable.EndUpdate;
    fGarnituraChanged := False;
  end;
end;

procedure TfrmServiceNewIncidentEditorDlg.ShowRepairAims(const ParentNode: TTreeNode;
  const ScopParentID: integer);
var
  Query: TIBCQuery;
  Node: TTreeNode;
  Data: TServiceAimItem;
  checked: Boolean;
begin
  if ParentNode = nil then
    CheckTreeAIMs.Items.BeginUpdate;
  Query := TIBCQuery.Create(Self);
  try
    Query.SQL.Add('SELECT * FROM (');
    Query.SQL.Add('SELECT SCOPID, FLG_FOLDER, TITLE, DESCRIPTION, ESTIMATED_HOURS,');
    Query.SQL.Add
      ('IIF(EXISTS(SELECT SCOPID FROM SC_INCIDENT_SCOP WHERE INCIDENTID=:idIncident AND SCOPID=A.SCOPID),1,0) FLG_SELECTED,');
    Query.SQL.Add
      ('IIF(FLG_FOLDER=0,1,IIF(EXISTS(SELECT SCOPID FROM SC_REF_INCIDENT_SCOP B WHERE B.PARENTID=A.SCOPID),1,0)) CHILD_COUNT');
    Query.SQL.Add
      ('FROM SC_REF_INCIDENT_SCOP A WHERE (PARENTID=:id) AND (GET_FLG_VALUE(FLAGS,0)=1) ORDER BY ORDERNO');
    Query.SQL.Add(') WHERE CHILD_COUNT>0');
    Query.ParamByName('id').asInteger := ScopParentID;
    Query.ParamByName('idIncident').asInteger := fMasterDataSet.FieldByName('INCIDENTID').asInteger;
    Query.ExecSQL;
    while Not Query.Eof do
    begin
      Data := TServiceAimItem.Create;
      Data.SCOPID := Query.Fields[0].asInteger;
      Data.FLG_FOLDER := Query.Fields[1].asInteger = 1;
      Data.Title := Query.Fields[2].AsString;
      Data.Description := Query.Fields[3].AsString;
      Data.Hours := Query.Fields[4].asInteger;

      checked := Query.Fields[5].asInteger = 1;

      // tree item
      Node := CheckTreeAIMs.Items.AddChild(ParentNode, Query.Fields[2].AsString);
      Node.Data := Data;

      if Data.FLG_FOLDER then
      begin
        Node.ImageIndex := 13;
        Node.SelectedIndex := 13;
        // populate branch
        ShowRepairAims(Node, Data.SCOPID);
        // update check state
        CheckTreeAIMs.ForceCheckState(Node, GetNodeSelectionType(Node));
      end
      else
      begin
        Node.ImageIndex := 58;
        Node.SelectedIndex := 58;
      end;

      if Not Data.FLG_FOLDER and checked then
      begin
        CheckTreeAIMs.ChangeNodeCheckState(Node, csChecked);
        if Node.Parent <> nil then
          Node.Parent.Expanded := True;
      end;

      Query.Next;
    end;
  finally
    Query.Free;
    if ParentNode = nil then
      CheckTreeAIMs.Items.EndUpdate;
    fAimsChanged := False;
  end;
end;

procedure TfrmServiceNewIncidentEditorDlg.ShowSelectAspectVizualDialog;
var dialog:TfrmServiceNewIncidentVVTDlg;
begin
     dialog:=TfrmServiceNewIncidentVVTDlg.Create(Self);
     try
        if dialog.ShowModal=mrOk then AppendTextToAspectVizual(dialog.GetText);
     finally
        dialog.Free;
     end;
end;

procedure TfrmServiceNewIncidentEditorDlg.ShowSelecteDefecteProdusDialog;
var dialog:TfrmServiceNewIncidentOPDDlg;
begin
     dialog:=TfrmServiceNewIncidentOPDDlg.Create(Self);
     try
        if dialog.ShowModal=mrOK then AppendTextToDefecte(dialog.GetText);
     finally
        dialog.Free;
     end;
end;

procedure TfrmServiceNewIncidentEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  if dmDB.IBC_INCIDENTE_BLOB.State in [dsEdit, dsInsert] then
    dmDB.IBC_INCIDENTE_BLOB.Cancel;

  fMasterDataSet.UpdateTransaction.Rollback;

end;


end.
