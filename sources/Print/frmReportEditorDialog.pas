unit frmReportEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, frmPrintEngineWindow, Dialogs, DialogTitle, frxDCtrl,
  frxChBox, frxRich, frxClass, frxIBDACComponents, frxDesgn,
  DB, DBAccess, IBC, cxButtonEdit, StdCtrls,
  cxDBLookupComboBox, cxDBEdit,
  ExtCtrls, frxExportMail,
  frxExportXLS, frxExportPDF, fs_ipascal,
  ComCtrls, cxCustomData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGrid, frxExportImage, Buttons, dxBar,
  frxBarcode, frxExportText,
  frxExportDOCX, frxExportHTMLDiv, frxExportBIFF, frxExportXML, frxGaugeView, frxCellularTextObject,
  frxTableObject, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxStyles, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox,
  Vcl.Menus, frxExportHelpers, frxExportBaseDialog, cxClasses, frxDACComponents, MemDS, cxGridCustomView, cxCheckBox,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxMemo, cxTextEdit, dxUIAClasses, dxCoreGraphics,
  frCoreClasses;

type
  TfrmReportEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    IBCQueryReportGroup: TIBCQuery;
    IBCDataSourceReportGroup: TIBCDataSource;
    IBCDataSourceTabSheetIndex: TIBCDataSource;
    IBCQueryTabSheetIndex: TIBCQuery;
    frxDesigner: TfrxDesigner;
    frxReport: TfrxReport;
    frxRichObject1: TfrxRichObject;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    frxDialogControls1: TfrxDialogControls;
    fsPascal: TfsPascal;
    pcPageControl: TPageControl;
    tbsGeneral: TTabSheet;
    tbsAccess: TTabSheet;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    lbReportGroup: TLabel;
    lbTabSheetIndex: TLabel;
    cxLabel3: TLabel;
    lbReportChanged: TLabel;
    edTITLE: TcxDBTextEdit;
    mmDESCRIPTION: TcxDBMemo;
    lcbREPORTGROUP: TcxDBLookupComboBox;
    lcbTabSheetIndex: TcxDBLookupComboBox;
    beDocType: TcxButtonEdit;
    gbFlags: TGroupBox;
    cbFLG_DISABLED: TcxDBCheckBox;
    cbFLG_NO_DIRECT_PRINT: TcxDBCheckBox;
    cxLabel14: TLabel;
    cxLabel15: TLabel;
    cxGridUserGroups: TcxGrid;
    cxGridUserGroupsTable: TcxGridTableView;
    cxGridUserGroups_IMAGE: TcxGridColumn;
    cxGridUserGroups_TITLE: TcxGridColumn;
    cxGridUserGroups_GROUPID: TcxGridColumn;
    cxGridUserGroupsLevel: TcxGridLevel;
    cxGridAvailableUserGroups: TcxGrid;
    cxGridAUGTable: TcxGridTableView;
    cxGridAUG_IMAGE: TcxGridColumn;
    cxGridAUG_TITLE: TcxGridColumn;
    cxGridAUG_GROUPID: TcxGridColumn;
    cxGridAUGLevel: TcxGridLevel;
    cbFLG_QUICK_ACCESS: TcxDBCheckBox;
    sbCustomReportGroup: TSpeedButton;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    dxBarButton1: TdxBarButton;
    frxJPEGExport1: TfrxJPEGExport;
    frxXLSExport1: TfrxXLSExport;
    frxBarCodeObject1: TfrxBarCodeObject;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    cxGridSelFirms: TcxGrid;
    cxGridSelFirmsTable: TcxGridTableView;
    cxGridSelFirms_IMG: TcxGridColumn;
    cxGridSelFirms_TITLE: TcxGridColumn;
    cxGridSelFirms_ID: TcxGridColumn;
    cxGridSelFirmsLevel: TcxGridLevel;
    cxGridAvFirms: TcxGrid;
    cxGridAvFirmsTable: TcxGridTableView;
    cxGridAvFirms_IMG: TcxGridColumn;
    cxGridAvFirms_TITLE: TcxGridColumn;
    cxGridAvFirms_ID: TcxGridColumn;
    cxGridAvFirmsLevel: TcxGridLevel;
    frxPDFExport1: TfrxPDFExport;
    frxMailExport1: TfrxMailExport;
    teOrderno: TcxDBTextEdit;
    Label5: TLabel;
    frxReportTableObject1: TfrxReportTableObject;
    frxReportCellularTextObject1: TfrxReportCellularTextObject;
    frxGaugeObject1: TfrxGaugeObject;
    frxXMLExport1: TfrxXMLExport;
    frxBIFFExport1: TfrxBIFFExport;
    frxHTML5DivExport1: TfrxHTML5DivExport;
    frxDOCXExport1: TfrxDOCXExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    btnOk: TcxButton;
    btnClose: TcxButton;
    btnAddUserGroup: TcxButton;
    btnRemoveUserGroup: TcxButton;
    btnAddFirms: TcxButton;
    btnRemoveFirms: TcxButton;
    frxIBDACComponents1: TfrxIBDACComponents;
    function frxDesignerSaveReport(Report: TfrxReport; SaveAs: Boolean): Boolean;
    procedure beDocTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnAddUserGroupClick(Sender: TObject);
    procedure btnRemoveUserGroupClick(Sender: TObject);
    procedure cxGridUserGroupsTableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure cxGridAUGTableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure cxGridAUGTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridUserGroupsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure sbCustomReportGroupClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure cxGridAvFirmsTableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure btnAddFirmsClick(Sender: TObject);
    procedure btnRemoveFirmsClick(Sender: TObject);
    procedure cxGridSelFirmsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridAvFirmsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    FDocTypeID: integer;
    fReportTemplateLoaded: Boolean;
    fReportTemplateData: TMemoryStream;
    fLoadedReportTemplateID: integer;
    fReportTemplateChanged: Boolean;
    fFirmsChanged: Boolean;
    FCreateNewReport: Boolean;
    FReportParamsList: TReportParamsList;
    fQuickAccessReportsChanged: Boolean;
    fInitialQuickAccessFlagValue: integer;
    fDT: integer;
    function CheckParams: Boolean;
    procedure SetDocTypeID(const Value: integer);
    procedure ModifyReportTemplate;
    procedure EditReportTemplate;
    procedure LoadReportTemplate(const ReportID: integer);
    procedure SaveReportTemplate;
    procedure SetCreateNewReport(const Value: Boolean);
    procedure ShowSelectDocTypeDialog;
    procedure SetReportParamsList(const Value: TReportParamsList);
    procedure WhenReportGetValue(const VarName: string; var Value: Variant);
    procedure SetDT(const Value: integer);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
    procedure LoadReportUserGroups;
    procedure UserGroupsSelectionChanged;
    procedure AddSelectedAvailableGroups;
    procedure RemoveSelectedUserGroups;
    procedure SetReportAccessValue;
    procedure ShowReportGroupsEditor;
    procedure LoadFirmsInfo(const UserID, ReportID: integer);
    procedure FirmsSelectionChanged;
    procedure AddFirmsToSelected;
    procedure RemoveFirmsFromSelected;
    procedure SaveReportFirms(const FirmaID, ReportID: integer);
  public
    { Public declarations }
    destructor Destroy; override;
    property CreateNewReport: Boolean read FCreateNewReport write SetCreateNewReport;
    property DocTypeID: integer read FDocTypeID write SetDocTypeID;
    property DT: integer read FDT write SetDT;
    property ReportParamsList: TReportParamsList read FReportParamsList write SetReportParamsList;
    property QuickAccessReportsChanged: Boolean read fQuickAccessReportsChanged;
  end;

implementation

uses
  SWNUtils, SWNConst, ReportVariablesUnit, frmReportSelectDocTypeDialog,
  DataModuleDB,
  frmReportGroupDialog;

{$R *.dfm}

{ TfrmReportEditorDlg }

procedure TfrmReportEditorDlg.AddFirmsToSelected;
var
  i, N: integer;
begin
  cxGridSelFirmsTable.DataController.BeginUpdate;
  cxGridAvFirmsTable.DataController.BeginUpdate;
  try
        // adaugam
    for i := 0 to cxGridAvFirmsTable.Controller.SelectedRowCount - 1 do
    begin
      N := cxGridSelFirmsTable.DataController.AppendRecord;
      cxGridSelFirmsTable.DataController.Values[N, cxGridSelFirms_ID.Index] := cxGridAvFirmsTable.Controller.SelectedRows[i].Values[cxGridAvFirms_ID.Index];
      cxGridSelFirmsTable.DataController.Values[N, cxGridSelFirms_TITLE.Index] := cxGridAvFirmsTable.Controller.SelectedRows[i].Values[cxGridAvFirms_TITLE.Index];
    end;
        // stergem
    cxGridAvFirmsTable.Controller.DeleteSelection;

    fFirmsChanged := True;
  finally
    cxGridSelFirmsTable.DataController.EndUpdate;
    cxGridAvFirmsTable.DataController.EndUpdate;
  end;
end;

procedure TfrmReportEditorDlg.AddSelectedAvailableGroups;
var
  i, N: integer;
  row: TcxCustomGridRow;
  groupID: integer;
  groupTitle: string;
begin
  cxGridAUGTable.DataController.BeginUpdate;
  cxGridUserGroupsTable.DataController.BeginUpdate;
  try
        // add selected groups
    for i := 0 to cxGridAUGTable.Controller.SelectedRowCount - 1 do
    begin
      Row := cxGridAUGTable.Controller.SelectedRows[i];

      groupID := Row.Values[cxGridAUG_GROUPID.Index];
      groupTitle := Row.Values[cxGridAUG_TITLE.Index];

      N := cxGridUserGroupsTable.DataController.AppendRecord;
      cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_GROUPID.Index] := groupID;
      cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_TITLE.Index] := groupTitle;
    end;
        // remove selected groups
    for i := cxGridAUGTable.Controller.SelectedRowCount - 1 downto 0 do
    begin
      Row := cxGridAUGTable.Controller.SelectedRows[i];
      cxGridAUGTable.DataController.DeleteRecord(Row.RecordIndex);
    end;
    cxGridAUGTable.Controller.ClearSelection;
  finally
    cxGridAUGTable.DataController.EndUpdate;
    cxGridUserGroupsTable.DataController.EndUpdate;
  end;
end;

procedure TfrmReportEditorDlg.beDocTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectDocTypeDialog;
end;

function TfrmReportEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsString = '') then
    AddErrorToStr(ErrorStr, 'Denumire raport');
  if fMasterDataSet.FieldByName('DOCTYPEID').IsNull then
    AddErrorToStr(ErrorStr, 'Tip document!');
  if cxGridUserGroupsTable.DataController.RecordCount = 0 then
    AddErrorToStr(ErrorStr, 'Nu este aleasa grupa de acces!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmReportEditorDlg.cxGridAUGTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  AddSelectedAvailableGroups;
end;

procedure TfrmReportEditorDlg.cxGridAUGTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
  UserGroupsSelectionChanged;
end;

procedure TfrmReportEditorDlg.cxGridAvFirmsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  AddFirmsToSelected;
end;

procedure TfrmReportEditorDlg.cxGridAvFirmsTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
  FirmsSelectionChanged;
end;

procedure TfrmReportEditorDlg.cxGridSelFirmsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  RemoveFirmsFromSelected;
end;

procedure TfrmReportEditorDlg.cxGridUserGroupsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  RemoveSelectedUserGroups;
end;

procedure TfrmReportEditorDlg.cxGridUserGroupsTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
  UserGroupsSelectionChanged;
end;

procedure TfrmReportEditorDlg.btnAddFirmsClick(Sender: TObject);
begin
  AddFirmsToSelected;
end;

procedure TfrmReportEditorDlg.btnAddUserGroupClick(Sender: TObject);
begin
  AddSelectedAvailableGroups;
end;

procedure TfrmReportEditorDlg.btnRemoveFirmsClick(Sender: TObject);
begin
  RemoveFirmsFromSelected;
end;

procedure TfrmReportEditorDlg.btnRemoveUserGroupClick(Sender: TObject);
begin
  RemoveSelectedUserGroups;
end;

destructor TfrmReportEditorDlg.Destroy;
begin
  fReportTemplateData.Free;
  inherited;
end;

procedure TfrmReportEditorDlg.dxBarButton1Click(Sender: TObject);
begin
  ModifyReportTemplate;
end;

procedure TfrmReportEditorDlg.EditReportTemplate;
begin
  fReportTemplateData.Position := 0;
  if fReportTemplateData.Size > 0 then
  begin
    frxReport.LoadFromStream(fReportTemplateData);
  end;

  SetReportVariables(frxReport);

  frxReport.DesignReport;
end;

procedure TfrmReportEditorDlg.FirmsSelectionChanged;
begin
  btnAddFirms.Enabled := cxGridAvFirmsTable.Controller.SelectedRowCount > 0;
  btnRemoveFirms.Enabled := cxGridSelFirmsTable.Controller.SelectedRowCount > 0;
end;

procedure TfrmReportEditorDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if fReportTemplateChanged and (ModalResult <> mrOk) then
    if ShowAskDialog('Alerta!', 'Sursele raportului au fost modificate, sigur doriti sa iesiti?') <> mrYes then
      CanClose := False;
end;

function TfrmReportEditorDlg.frxDesignerSaveReport(Report: TfrxReport; SaveAs: Boolean): Boolean;
var
  dialog: TSaveDialog;
  f: TFileStream;
begin
  Result := False;
  if SaveAs then
  begin
    dialog := TSaveDialog.Create(Self);
    try
      dialog.DefaultExt := '.fr3';
      dialog.Filter := 'Fast Report files (*.fr3)|*.fr3';
      if dialog.Execute then
      begin
        F := TFileStream.Create(dialog.FileName, fmCreate);
        try
          Report.SaveToStream(F);
          Result := True;
        finally
          F.Free;
        end;
      end;
    finally
      dialog.Free;
    end;
  end
  else
  begin
    fReportTemplateData.Clear;
    Report.SaveToStream(fReportTemplateData);
    fReportTemplateChanged := True;
    lbReportChanged.Visible := True;
    Result := True;
  end;
end;

procedure TfrmReportEditorDlg.BindingDataSource;
begin
  inherited;

  edTITLE.DataBinding.DataSource := fMasterDataSource;
  mmDESCRIPTION.DataBinding.DataSource := fMasterDataSource;
  lcbREPORTGROUP.DataBinding.DataSource := fMasterDataSource;
  lcbTabSheetIndex.DataBinding.DataSource := fMasterDataSource;
  cbFLG_DISABLED.DataBinding.DataSource := fMasterDataSource;
  cbFLG_NO_DIRECT_PRINT.DataBinding.DataSource := fMasterDataSource;
  cbFLG_QUICK_ACCESS.DataBinding.DataSource := fMasterDataSource;
  teOrderno.DataBinding.DataSource := fMasterDataSource;

  FDocTypeID := -1;
  FCreateNewReport := False;
  FReportParamsList := nil;
  fQuickAccessReportsChanged := false;

  fReportTemplateLoaded := False;
  fReportTemplateChanged := False;
  fReportTemplateData := TMemoryStream.Create;

  lbReportChanged.Visible := False;

end;

function TfrmReportEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    SetReportAccessValue;

    fQuickAccessReportsChanged := fInitialQuickAccessFlagValue <> fMasterDataSet.FieldByName('FLG_QUICK_ACCESS').AsInteger;

    fMasterDataSet.Post;
    if fReportTemplateLoaded and fReportTemplateChanged then
      SaveReportTemplate;
    if fFirmsChanged then
      SaveReportFirms(dmDB.CurrentFirma, fMasterDataSet.FieldByName('REPORTID').AsInteger);

    fMasterDataSet.UpdateTransaction.Commit;
    fReportTemplateChanged := False;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmReportEditorDlg.LoadFirmsInfo(const UserID, ReportID: integer);
var
  Query: TIBCQuery;
  custID, N: integer;
  firmaTitle: string;
begin
  cxGridSelFirmsTable.DataController.BeginUpdate;
  cxGridAvFirmsTable.DataController.BeginUpdate;

  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT CUSTOMERID, DISPLAYNAME,');
    Query.SQL.Add('IIF(EXISTS(SELECT REPORTID FROM TS_REPORTS2_DT WHERE CUSTOMERID=F.CUSTOMERID AND REPORTID=:ReportID),1,0)');
    Query.SQL.Add('FROM GET_FIRMS_BY_USER(:UserID) F');
    Query.ParamByName('ReportID').AsInteger := ReportID;
    Query.ParamByName('UserID').AsInteger := UserID;
    Query.Open;
    while not Query.Eof do
    begin
      custID := Query.Fields[0].AsInteger;
      firmaTitle := Query.Fields[1].AsString;

      if Query.Fields[2].AsInteger = 1 then
      begin
                  // firma este selectata
        N := cxGridSelFirmsTable.DataController.AppendRecord;
        cxGridSelFirmsTable.DataController.Values[N, cxGridSelFirms_ID.Index] := custID;
        cxGridSelFirmsTable.DataController.Values[N, cxGridSelFirms_TITLE.Index] := firmaTitle;
      end
      else
      begin
                  // firma este disponibila
        N := cxGridAvFirmsTable.DataController.AppendRecord;
        cxGridAvFirmsTable.DataController.Values[N, cxGridAvFirms_ID.Index] := custID;
        cxGridAvFirmsTable.DataController.Values[N, cxGridAvFirms_TITLE.Index] := firmaTitle;
      end;

      Query.Next;
    end;
    fFirmsChanged := False;
  finally
    Query.Free;

    cxGridSelFirmsTable.DataController.EndUpdate;
    cxGridAvFirmsTable.DataController.EndUpdate;
  end;
end;

procedure TfrmReportEditorDlg.LoadReportTemplate(const ReportID: integer);
var
  Query: TIBCQuery;
  compressedMS: TMemoryStream;
  ExpandedSize: integer;
begin
  Query := TIBCQuery.Create(nil);
  compressedMS := TMemoryStream.Create;
  try
    Query.Connection := fMasterDataSet.Connection;
    Query.SQL.Text := 'SELECT REPORT_TEMPLATE, EXPANDED_SIZE FROM TS_REPORTS2 WHERE (ReportID=:ReportID)';
    Query.ParamByName('ReportID').AsInteger := ReportID;
    Query.Open;
    if (not Query.Eof) then
    begin
      ExpandedSize := Query.Fields[1].AsInteger;

      if Query.Fields[0].IsBlob and (not Query.Fields[0].IsNull) then
      begin
        if ExpandedSize = 0 then
        begin
                       // load uncompressed
          TBlobField(Query.Fields[0]).SaveToStream(fReportTemplateData);
        end
        else
        begin
                       // load compressed
          TBlobField(Query.Fields[0]).SaveToStream(compressedMS);
          fReportTemplateData.SetSize(ExpandedSize);
          UnCompressStream(compressedMS, fReportTemplateData);
        end;
      end;

      fLoadedReportTemplateID := ReportID;
      fReportTemplateLoaded := True;
      fReportTemplateChanged := False;
    end;
  finally
    compressedMS.Free;
    Query.Close;
  end;
end;

procedure TfrmReportEditorDlg.LoadReportUserGroups;
var
  Query: TIBCQuery;
  mask: int64;
  n: integer;
  groupID: integer;
  groupTitle: string;
begin
  mask := fMasterDataSet.FieldByName('ACC$MASK').AsLargeInt;
  Query := TIBCQuery.Create(Self);
  cxGridUserGroupsTable.DataController.BeginUpdate;
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT GROUPID, GROUP_NAME FROM GET_GROUPS_BY_USER(:USERID)';
    Query.ParamByName('USERID').AsInteger := dmDB.CurrentUserID;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      groupID := Query.Fields[0].AsInteger;
      groupTitle := Query.Fields[1].AsString;
      if (mask and (1 shl (groupID - 1)) > 0) then
      begin
                  // group is selected
        N := cxGridUserGroupsTable.DataController.AppendRecord;
        cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_GROUPID.Index] := groupID;
        cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_TITLE.Index] := groupTitle;
      end
      else
      begin
                  // group is available
        N := cxGridAUGTable.DataController.AppendRecord;
        cxGridAUGTable.DataController.Values[N, cxGridAUG_GROUPID.Index] := groupID;
        cxGridAUGTable.DataController.Values[N, cxGridAUG_TITLE.Index] := groupTitle;
      end;

      Query.Next;
    end;
  finally
    cxGridUserGroupsTable.DataController.EndUpdate;
    Query.Free;
  end;
end;

procedure TfrmReportEditorDlg.ModifyReportTemplate;
begin
  if not fReportTemplateLoaded then
    LoadReportTemplate(fMasterDataSet.FieldByName('REPORTID').asInteger);

  if fReportTemplateLoaded then
  begin
    EditReportTemplate;
  end;
end;

procedure TfrmReportEditorDlg.Prepare;
begin
  SetupSecurityItems;

  pcPageControl.ActivePage := tbsGeneral;
  UserGroupsSelectionChanged;

  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    IBCQueryReportGroup.Active := True;
    IBCQueryTabSheetIndex.Active := True;

    if FCreateNewReport then
    begin
      fMasterDataSet.Append;
      fMasterDataSet.FieldByName('REPORTGROUP').AsInteger := -1; // Fara grup
      fMasterDataSet.FieldByName('TABSHEETINDEX').AsInteger := 0; // Fara parametri
      fMasterDataSet.FieldByName('FLG_DISABLED').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_NO_DIRECT_PRINT').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_QUICK_ACCESS').AsInteger := 0;
      fMasterDataSet.FieldByName('DOCTYPEID').AsInteger := FDocTypeID;

      beDocType.Text := '';

      dtDialogTitle.Text := 'Crearea unui raport nou';
    end
    else
    begin
      fMasterDataSet.Edit;
      dtDialogTitle.Text := 'Modificarea raportului №' + fMasterDataSet.FieldByName('REPORTID').AsString;
    end;
    LoadReportUserGroups;
    UserGroupsSelectionChanged;

    LoadFirmsInfo(dmDB.CurrentUserID, fMasterDataSet.FieldByName('REPORTID').AsInteger);
    FirmsSelectionChanged;

    beDocType.Text := Format('%d. %s', [fMasterDataSet.FieldByName('DOCTYPEID').AsInteger, fMasterDataSet.FieldByName('DOCTYPE_TITLE').AsString]);

    fInitialQuickAccessFlagValue := fMasterDataSet.FieldByName('FLG_QUICK_ACCESS').AsInteger;

  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;

    IBCQueryTabSheetIndex.Close;
    IBCQueryReportGroup.Close;

    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmReportEditorDlg.RemoveFirmsFromSelected;
var
  i, N: integer;
begin
  cxGridSelFirmsTable.DataController.BeginUpdate;
  cxGridAvFirmsTable.DataController.BeginUpdate;
  try
        // adaugam
    for i := 0 to cxGridSelFirmsTable.Controller.SelectedRowCount - 1 do
    begin
      N := cxGridAvFirmsTable.DataController.AppendRecord;
      cxGridAvFirmsTable.DataController.Values[N, cxGridAvFirms_ID.Index] := cxGridSelFirmsTable.Controller.SelectedRows[i].Values[cxGridSelFirms_ID.Index];
      cxGridAvFirmsTable.DataController.Values[N, cxGridAvFirms_TITLE.Index] := cxGridSelFirmsTable.Controller.SelectedRows[i].Values[cxGridSelFirms_TITLE.Index];
    end;
        // stergem
    cxGridSelFirmsTable.Controller.DeleteSelection;

    fFirmsChanged := True;
  finally
    cxGridSelFirmsTable.DataController.EndUpdate;
    cxGridAvFirmsTable.DataController.EndUpdate;
  end;
end;

procedure TfrmReportEditorDlg.RemoveSelectedUserGroups;
var
  i, N: integer;
  row: TcxCustomGridRow;
  groupID: integer;
  groupTitle: string;
begin
  cxGridAUGTable.DataController.BeginUpdate;
  cxGridUserGroupsTable.DataController.BeginUpdate;
  try
        // add selected groups
    for i := 0 to cxGridUserGroupsTable.Controller.SelectedRowCount - 1 do
    begin
      Row := cxGridUserGroupsTable.Controller.SelectedRows[i];

      groupID := Row.Values[cxGridUserGroups_GROUPID.Index];
      groupTitle := Row.Values[cxGridUserGroups_TITLE.Index];

      N := cxGridAUGTable.DataController.AppendRecord;
      cxGridAUGTable.DataController.Values[N, cxGridAUG_GROUPID.Index] := groupID;
      cxGridAUGTable.DataController.Values[N, cxGridAUG_TITLE.Index] := groupTitle;
    end;
        // remove selected groups
    for i := cxGridUserGroupsTable.Controller.SelectedRowCount - 1 downto 0 do
    begin
      Row := cxGridUserGroupsTable.Controller.SelectedRows[i];
      cxGridUserGroupsTable.DataController.DeleteRecord(Row.RecordIndex);
    end;
    cxGridUserGroupsTable.Controller.ClearSelection;
  finally
    cxGridAUGTable.DataController.EndUpdate;
    cxGridUserGroupsTable.DataController.EndUpdate;
  end;
end;

procedure TfrmReportEditorDlg.SaveReportFirms(const FirmaID, ReportID: integer);
var
  Query: TIBCQuery;
  i: integer;
begin
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := fMasterDataSet.Connection;
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
        // stergem legaturile curente
    Query.SQL.Text := 'DELETE FROM TS_REPORTS2_DT WHERE REPORTID=:ReportID';
    Query.ParamByName('ReportID').AsInteger := ReportID;
    Query.ExecSQL;
        // facem legaturile
    Query.SQL.Text := 'INSERT INTO TS_REPORTS2_DT (REPORTID, CUSTOMERID) VALUES (:ReportID, :CustID)';
    Query.ParamByName('ReportID').AsInteger := ReportID;
    for i := 0 to cxGridSelFirmsTable.DataController.RecordCount - 1 do
    begin
      Query.ParamByName('CustID').AsInteger := cxGridSelFirmsTable.DataController.Values[i, cxGridSelFirms_ID.Index];
      Query.ExecSQL;
    end;
  finally
    Query.Close;
  end;
end;

procedure TfrmReportEditorDlg.SaveReportTemplate;
var
  Query: TIBCQuery;
  CompressMS: TMemoryStream;
begin
  Query := TIBCQuery.Create(nil);
  CompressMS := TMemoryStream.Create;
  try
    CompressStream(fReportTemplateData, CompressMS);

    Query.Connection := fMasterDataSet.Connection;
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;

    Query.SQL.Text := 'UPDATE TS_REPORTS2 SET REPORT_TEMPLATE=:Data, EXPANDED_SIZE=:ExpandedSize WHERE (ReportID=:ReportID)';
    Query.ParamByName('ReportID').AsInteger := fLoadedReportTemplateID;
    fReportTemplateData.Position := 0;
    Query.ParamByName('Data').LoadFromStream(CompressMS, ftBlob);
    Query.ParamByName('ExpandedSize').AsInteger := fReportTemplateData.Size;
    Query.ExecSQL;
  finally
    CompressMS.Free;
    Query.Close;
  end;
end;

procedure TfrmReportEditorDlg.sbCustomReportGroupClick(Sender: TObject);
begin
  ShowReportGroupsEditor;
end;

procedure TfrmReportEditorDlg.SetCreateNewReport(const Value: Boolean);
begin
  FCreateNewReport := Value;
end;

procedure TfrmReportEditorDlg.SetDocTypeID(const Value: integer);
begin
  FDocTypeID := Value;
end;

procedure TfrmReportEditorDlg.SetDT(const Value: integer);
begin
  fDT := Value;
end;

procedure TfrmReportEditorDlg.SetReportAccessValue;
var
  i, groupID: integer;
  N: int64;
begin
  N := 0;
  for i := 0 to cxGridUserGroupsTable.DataController.RecordCount - 1 do
  begin
    groupID := cxGridUserGroupsTable.DataController.Values[i, cxGridUserGroups_GROUPID.Index];
    N := N or (1 shl (groupID - 1));
  end;
  fMasterDataSet.FieldByName('ACC$MASK').Value := N;
end;

procedure TfrmReportEditorDlg.SetReportParamsList(const Value: TReportParamsList);
begin
  if Assigned(Value) then
  begin
    FReportParamsList := Value;
    frxReport.OnGetValue := WhenReportGetValue;
  end
  else
    frxReport.OnGetValue := nil;
end;

procedure TfrmReportEditorDlg.SetupSecurityItems;
begin
//     if Not UserHasUserGroup(cSecurityFlag_Справочники_Склады_Права_пользователей) then
//     begin
//          tbsAccess.TabVisible:=False;
//     end;
end;

procedure TfrmReportEditorDlg.ShowReportGroupsEditor;
var
  dialog: TfrmReportGroupDlg;
begin
  dialog := TfrmReportGroupDlg.Create(Self);
  try
    dialog.ReportGroupID := fMasterDataSet.FieldByName('REPORTGROUP').AsInteger;
    dialog.ShowModal;
    if dialog.DataChanged then
    begin
      IBCQueryReportGroup.Close;
      IBCQueryReportGroup.Active := True;
      if fMasterDataSet.FieldByName('REPORTGROUP').AsInteger = -1 then
        fMasterDataSet.FieldByName('REPORTGROUP').AsInteger := dialog.ReportGroupID;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmReportEditorDlg.ShowSelectDocTypeDialog;
var
  dialog: TfrmReportSelectDocTypeDlg;
begin
  dialog := TfrmReportSelectDocTypeDlg.Create(Self);
  try
    dialog.DocTypeID := fMasterDataSet.FieldByName('DOCTYPEID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      fMasterDataSet.FieldByName('DOCTYPEID').AsInteger := dialog.DocTypeID;
      beDocType.Text := Format('%d. %s', [dialog.DocTypeID, dialog.DocType_Title]);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmReportEditorDlg.UserGroupsSelectionChanged;
begin
  btnAddUserGroup.Enabled := cxGridAUGTable.Controller.SelectedRowCount > 0;
  btnRemoveUserGroup.Enabled := cxGridUserGroupsTable.Controller.SelectedRowCount > 0;
end;

procedure TfrmReportEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmReportEditorDlg.WhenReportGetValue(const VarName: string; var Value: Variant);
var
  Param: TReportParamItem;
begin
  Param := FReportParamsList.GetParamByName(VarName);
  if Assigned(Param) then
    Value := Param.Value;
end;

end.

