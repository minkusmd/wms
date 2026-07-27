unit frmContractTypeDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  Vcl.StdCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS, dxBar, SWNBaseUnit, cxImageComboBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, frmPrintEngineWindow;

type
  TfrmContractTypeDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    IBCQueryCT: TIBCQuery;
    IBCDataSourceCT: TIBCDataSource;
    cxGridCTTable: TcxGridDBTableView;
    cxGridCTLevel: TcxGridLevel;
    cxGridCT: TcxGrid;
    btnOk: TButton;
    btnCancel: TButton;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGridCT_CONTRACTTYPEID: TcxGridDBColumn;
    cxGridCT_TITLE: TcxGridDBColumn;
    cxGridCT_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridCT_IMG: TcxGridDBColumn;
    bbHome: TdxBarButton;
    bbBack: TdxBarButton;
    bbForward: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    bbNewFolder: TdxBarButton;
    IBCTrUpdateCT: TIBCTransaction;
    dxBarButton1: TdxBarButton;
    procedure cxGridCTTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGridCTTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure bbHomeClick(Sender: TObject);
    procedure bbBackClick(Sender: TObject);
    procedure bbForwardClick(Sender: TObject);
    procedure cxGridCTTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
    procedure bbNewFolderClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fSelectMode: Boolean;
    fSECURITY_New,fSECURITY_Edit,fSECURITY_Delete:Boolean;
    fContractTypeID: integer;
    fCurrentParentID: integer;
    fInSearch: Boolean;
    fRootParentID:integer;
    fContractTypeTitle: String;
    procedure SelectionChanged;
    procedure SetSelectMode(const Value: Boolean);

    procedure NavigateForward;
    procedure NavigateBack;
    procedure NavigateToContractType(const ContractTypeID:integer);
//    procedure NavigateSearch(const WhereConditions:String);
    procedure NavigateToHome(const RootID:integer);
    procedure EnableCondition(const ConditionIndex:integer; const CustomCondition:String='');

    function ItemSelected:Boolean;

    procedure ShowCreateNewRecordDialog;
    procedure ShowModifyRecordDialog;
    procedure ShowCreateNewFolderDialog;
    procedure ShowModifyFolderDialog;
    procedure DeleteRecord;
    procedure SetContractTypeID(const Value: integer);
    procedure SetupReportParams(const ReportParams: TReportParamsList);
    procedure ShowPrintDialog;

  protected
    { protected declarations }
    procedure Prepare;override;
    procedure SetupSecurityItems;override;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    property SelectMode:Boolean read FSelectMode write SetSelectMode;
    property ContractTypeID:integer read fContractTypeID write SetContractTypeID;
    property ContractTypeTitle:String read fContractTypeTitle;
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNSecurityFlags, SWNUtils, SWNDBErrors, frmContractTypeEditorDialog,
  frmContractTypeFolderEditorDialog, SWNConst, frmPrintWizardDialog;

{$R *.dfm}

procedure TfrmContractTypeDlg.bbDeleteClick(Sender: TObject);
begin
     DeleteRecord;
end;

procedure TfrmContractTypeDlg.bbEditClick(Sender: TObject);
begin
     if IBCQueryCT.FieldByName('FLG_FOLDER').AsInteger=1
       then ShowModifyFolderDialog
       else ShowModifyRecordDialog;
end;

procedure TfrmContractTypeDlg.bbNewClick(Sender: TObject);
begin
     ShowCreateNewRecordDialog;
end;

procedure TfrmContractTypeDlg.bbNewFolderClick(Sender: TObject);
begin
     ShowCreateNewFolderDialog;
end;

procedure TfrmContractTypeDlg.btnOkClick(Sender: TObject);
begin
     if ItemSelected then ModalResult:=mrOk;
end;

constructor TfrmContractTypeDlg.Create(AOwner: TComponent);
begin
     inherited;
     fSelectMode:=False;
     fContractTypeID:=-1;
     fRootParentID:=0;
end;

procedure TfrmContractTypeDlg.cxGridCTTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if AButton=mbLeft then
     begin
          if IBCQueryCT.FieldByName('FLG_FOLDER').AsInteger=1 then NavigateForward
          else
          begin
               if fSelectMode and ItemSelected then ModalResult:=mrOk;
          end;
     end;
end;

procedure TfrmContractTypeDlg.cxGridCTTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmContractTypeDlg.cxGridCTTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if (Shift=[]) and (Key=13) then
     begin
          // ENTER
          if (cxGridCTTable.DataController.RecNo>0) then
          begin
               if IBCQueryCT.FieldByName('FLG_FOLDER').AsInteger=1
                then NavigateForward
                else if ItemSelected then ModalResult:=mrOk;
          end;
     end
     else
     // Back Space
     if (Key=8) and (Shift=[]) then NavigateBack;
end;

procedure TfrmContractTypeDlg.DeleteRecord;
begin
     if ShowAskDialog(cMSG_DELETERECORD,Format('%s %s?',[cMSG_DELETERECORD, IBCQueryCT.FieldByName('TITLE').AsString]))<>mrYes then Exit;

     IBCQueryCT.UpdateTransaction.StartTransaction;
     try
        IBCQueryCT.Delete;
        IBCQueryCT.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQueryCT.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmContractTypeDlg.dxBarButton1Click(Sender: TObject);
begin
  ShowPrintDialog;
end;

procedure TfrmContractTypeDlg.ShowPrintDialog;
var
  printWizard: TfrmPrintWizardDlg;
begin
  printWizard := TfrmPrintWizardDlg.Create(Self, dmDB.CurrentFirma, -1);
  try
    printWizard.ShowReportsFromGroupOnly(29);
    printWizard.OnPrintWizardSetupReportParams := SetupReportParams;
    printWizard.ShowModal;
  finally
    printWizard.Free;
  end;
end;

procedure TfrmContractTypeDlg.SetupReportParams(const ReportParams: TReportParamsList);
var
  N: integer;
begin
  N := -1;
  if Assigned(cxGridCTTable.Controller.FocusedRow) then
    N := cxGridCTTable.Controller.FocusedRow.Values[cxGridCT_CONTRACTTYPEID.Index];
  // setup here general params
  ReportParams.SetParamValue('CONTRACT_TYPEID', N);
end;

procedure TfrmContractTypeDlg.bbHomeClick(Sender: TObject);
begin
     NavigateToHome(fRootParentID);
end;

procedure TfrmContractTypeDlg.bbBackClick(Sender: TObject);
begin
     NavigateBack;
end;

procedure TfrmContractTypeDlg.bbForwardClick(Sender: TObject);
begin
     NavigateForward;
end;

procedure TfrmContractTypeDlg.EnableCondition(const ConditionIndex: integer; const CustomCondition: String);
begin
     fInSearch:=False;
     IBCQueryCT.Close;
     case ConditionIndex of
     // forward
     0: IBCQueryCT.FilterSQL:='PARENTID=:ParentID';
     // backward
     1: IBCQueryCT.FilterSQL:='PARENTID=(SELECT PARENTID FROM TS_CONTRACT_TYPES WHERE CONTRACTTYPEID=:ParentID)';
     // search
     2: IBCQueryCT.FilterSQL:=CustomCondition;
     end;
end;

function TfrmContractTypeDlg.ItemSelected: Boolean;
begin
     Result:=False;
     if (cxGridCTTable.DataController.RecNo>0) and (IBCQueryCT.FieldByName('FLG_FOLDER').AsInteger=0) then
     begin
          if fSelectMode then
          begin
               fContractTypeID:=IBCQueryCT.FieldByName('CONTRACTTYPEID').AsInteger;
               fContractTypeTitle:=IBCQueryCT.FieldByName('TITLE').AsString;
               Result:=True;
          end;
     end;
end;

procedure TfrmContractTypeDlg.NavigateBack;
var ParentID: Integer;
begin
     if cxGridCTTable.DataController.RecNo>0 then
     begin
          ParentID:=IBCQueryCT.FieldByName('PARENTID').AsInteger;
     end
     else
     begin
          if fCurrentParentID<=0
           then ParentID := fRootParentID
           else ParentID := fCurrentParentID;
     end;

     if (ParentID>0) and (ParentID<>fRootParentID) then
     begin
          EnableCondition(1); // Browse Backward
          IBCQueryCT.ParamByName('ParentID').AsInteger:=ParentID;
          IBCQueryCT.Open;
          fCurrentParentID:=IBCQueryCT.FieldByName('PARENTID').AsInteger;
          IBCQueryCT.Locate('CONTRACTTYPEID',ParentID,[]);
     end;
end;

procedure TfrmContractTypeDlg.NavigateForward;
var ParentID: Integer;
begin
     if (IBCQueryCT.RecordCount=0)
      then ParentID := 0
      else ParentID := IBCQueryCT.FieldByName('CONTRACTTYPEID').AsInteger;

     EnableCondition(0); // Browse Forward
     IBCQueryCT.ParamByName('ParentID').AsInteger:=ParentID;
     fCurrentParentID:=ParentID;
     IBCQueryCT.Open;
     SelectionChanged;
end;

//procedure TfrmContractTypeDlg.NavigateSearch(const WhereConditions: String);
//begin
//     EnableCondition(2,WhereConditions); // Search
//     fInSearch:=True;
//     IBCQueryCT.Open;
//     fCurrentParentID:=-1;
//     SelectionChanged;
//end;

procedure TfrmContractTypeDlg.NavigateToContractType(const ContractTypeID: integer);
begin
     EnableCondition(1); // Browse Backward
     IBCQueryCT.ParamByName('ParentID').AsInteger:=ContractTypeID;
     IBCQueryCT.Open;
     IBCQueryCT.Locate('CONTRACTTYPEID',ContractTypeID,[]);
     fCurrentParentID:=IBCQueryCT.FieldByName('ParentID').AsInteger;
     SelectionChanged;
end;

procedure TfrmContractTypeDlg.NavigateToHome(const RootID: integer);
begin
     EnableCondition(0); // Browse Forward
     IBCQueryCT.ParamByName('ParentID').AsInteger:=RootID;
     fCurrentParentID:=RootID;
     IBCQueryCT.Open;
     SelectionChanged;
end;

procedure TfrmContractTypeDlg.Prepare;
begin
     if Not fSelectMode then
     begin
          btnOk.Visible:=False;
          btnCancel.Caption := cMSG_ButtonClose;
     end;
     if fContractTypeID>0 then NavigateToContractType(fContractTypeID)
     else
     begin
          if fRootParentID>0
           then NavigateToHome(fRootParentID)
           else NavigateForward;
     end;
     SelectionChanged;
end;

procedure TfrmContractTypeDlg.SelectionChanged;
var fHome,fBack,fForw,fNewFolder,fNew,fEdit,fDelete:Boolean;
begin
     fHome:=fCurrentParentID<>fRootParentID;
     fBack:=fCurrentParentID<>fRootParentID;
     fForw:=False;
     fNewFolder:=(Not fInSearch) and (fCurrentParentID=0); // New folder

     fNew:=fSECURITY_New;
     fEdit:=False;
     fDelete:=False;
     if (cxGridCTTable.DataController.RecNo>0) then
     begin
          fForw:=IBCQueryCT.FieldByName('FLG_FOLDER').AsInteger=1;

          fEdit:=fSECURITY_Edit;
          fDelete:=fSECURITY_Delete;
     end;
     bbHome.Enabled:=fHome;
     bbBack.Enabled:=fBack;
     bbForward.Enabled:=fForw;

     bbNewFolder.Enabled:=fNewFolder;
     bbNew.Enabled:=fNew;
     bbEdit.Enabled:=fEdit;
     bbDelete.Enabled:=fDelete;
end;

procedure TfrmContractTypeDlg.SetContractTypeID(const Value: integer);
begin
     fContractTypeID := Value;
end;

procedure TfrmContractTypeDlg.SetSelectMode(const Value: Boolean);
begin
     fSelectMode := Value;
end;

procedure TfrmContractTypeDlg.SetupSecurityItems;
begin
     fSECURITY_New:=SecurityFlagEnabled(cSecurityFlag_Справочники_ТК_Создать);
     fSECURITY_Edit:=SecurityFlagEnabled(cSecurityFlag_Справочники_ТК_Редактировать);
     fSECURITY_Delete:=SecurityFlagEnabled(cSecurityFlag_Справочники_ТК_Удалить);
end;

procedure TfrmContractTypeDlg.ShowCreateNewFolderDialog;
var dialog:TfrmContractTypeFolderEditorDlg;
begin
     dialog:=TfrmContractTypeFolderEditorDlg.Create(Self,IBCQueryCT,IBCDataSourceCT);
     try
        dialog.ParentID:=fCurrentParentID;
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmContractTypeDlg.ShowCreateNewRecordDialog;
var dialog:TfrmContractTypeEditorDlg;
begin
     dialog:=TfrmContractTypeEditorDlg.Create(Self,IBCQueryCT,IBCDataSourceCT);
     try
        dialog.CreateNewRecord:=True;
        dialog.ParentID:=fCurrentParentID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmContractTypeDlg.ShowModifyFolderDialog;
var dialog:TfrmContractTypeFolderEditorDlg;
begin
     dialog:=TfrmContractTypeFolderEditorDlg.Create(Self,IBCQueryCT,IBCDataSourceCT);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmContractTypeDlg.ShowModifyRecordDialog;
var dialog:TfrmContractTypeEditorDlg;
begin
     dialog:=TfrmContractTypeEditorDlg.Create(Self,IBCQueryCT,IBCDataSourceCT);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

end.
