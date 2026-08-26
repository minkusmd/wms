unit frmServiceEndTaskDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, StdCtrls, cxGraphics, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxMemo, DB, DBAccess, IBC, MemDS, ControlGroup, cxLookAndFeels,
  cxLookAndFeelPainters;

type
  TfrmServiceEndTaskDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryTaskStatus: TIBCQuery;
    IBCDataSourceTaskStatus: TIBCDataSource;
    IBCQueryIncidentStatus: TIBCQuery;
    IBCDataSourceIncidentStatus: TIBCDataSource;
    IBCQueryTaskTypes: TIBCQuery;
    IBCDataSourceTaskTypes: TIBCDataSource;
    IBCQueryAssignedUsers: TIBCQuery;
    IBCDataSourceAssignedUsers: TIBCDataSource;
    IBCQueryTaskDSC: TIBCQuery;
    IBCDataSourceTaskDSC: TIBCDataSource;
    ControlGroup1: TControlGroup;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    edTYPE_TITLE: TcxDBTextEdit;
    cmbSTATUS_ID: TcxLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    ControlGroup2: TControlGroup;
    lbNew_Task: TLabel;
    lbNew_NewStatus: TLabel;
    lbNew_AssignedUser: TLabel;
    lbNew_Comments: TLabel;
    cbCreateNewTask: TCheckBox;
    cmbNew_TYPE_ID: TcxLookupComboBox;
    cmbNew_STATUS_ID: TcxLookupComboBox;
    cmbNew_ASSIGNED_USER_ID: TcxLookupComboBox;
    mmNewTaskComments: TcxMemo;
    ControlGroup3: TControlGroup;
    Label8: TLabel;
    cmbI_STATUS_ID: TcxLookupComboBox;
    Label1: TLabel;
    procedure cbCreateNewTaskClick(Sender: TObject);
  private
    { Private declarations }
    function CheckParams:Boolean;
    procedure UpdateTaskIncidentStatus;
    procedure CreateNewTask;
  protected
    { protected declarations }
    procedure InitValues;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmServiceEndTaskDlg }

procedure TfrmServiceEndTaskDlg.cbCreateNewTaskClick(Sender: TObject);
var B:Boolean;
begin
     B:=cbCreateNewTask.Checked;

     lbNew_Task.Enabled:=B;
     lbNew_NewStatus.Enabled:=B;
     lbNew_AssignedUser.Enabled:=B;
     cmbNew_TYPE_ID.Enabled:=B;
     cmbNew_STATUS_ID.Enabled:=B;
     cmbNew_ASSIGNED_USER_ID.Enabled:=B;
     lbNew_Comments.Enabled:=B;
     mmNewTaskComments.Enabled:=B;
end;

function TfrmServiceEndTaskDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if VarIsNull(cmbSTATUS_ID.EditValue) then AddErrorToStr(ErrorStr,'Статус завершения задачи!');
     if VarIsNull(cmbI_STATUS_ID.EditValue) then AddErrorToStr(ErrorStr,'Статус Инцидента!');

     if cbCreateNewTask.Checked then
     begin
          if VarIsNull(cmbNew_TYPE_ID.EditValue) or (cmbNew_TYPE_ID.EditValue<=0)  then AddErrorToStr(ErrorStr,'Тип новой задачи!');
          if VarIsNull(cmbNew_STATUS_ID.EditValue) or (cmbNew_STATUS_ID.EditValue<=0)  then AddErrorToStr(ErrorStr,'Начальный статус новой задачи!');
          if VarIsNull(cmbNew_ASSIGNED_USER_ID.EditValue) or (cmbNew_ASSIGNED_USER_ID.EditValue<=0)  then AddErrorToStr(ErrorStr,'Исполнительное лицо новой задачи!');
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmServiceEndTaskDlg.CreateNewTask;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_SC_CREATE_NEW_TASK(:IID,:ASSIGNED_USER_ID,:STATUS_ID,:TYPE_ID,:COMMENTS)';
        Query.ParamByName('IID').AsInteger:=fMasterDataSet.FieldByName('IID').AsInteger;
        Query.ParamByName('ASSIGNED_USER_ID').AsInteger:=cmbNew_ASSIGNED_USER_ID.EditValue;
        Query.ParamByName('STATUS_ID').AsInteger:=cmbNew_STATUS_ID.EditValue;
        Query.ParamByName('TYPE_ID').AsInteger:=cmbNew_TYPE_ID.EditValue;
        if Trim(mmNewTaskComments.Lines.Text)=''
         then Query.ParamByName('COMMENTS').Value:=NULL
         else Query.ParamByName('COMMENTS').AsString:=Trim(mmNewTaskComments.Lines.Text);
        Query.ExecSQL;
     finally
        Query.Free;
     end;
end;

procedure TfrmServiceEndTaskDlg.InitValues;
begin
     inherited;

     edTYPE_TITLE.DataBinding.DataSource:=fMasterDataSource;
     IBCQueryTaskDSC.MasterSource:=fMasterDataSource;
     IBCQueryTaskDSC.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
end;

function TfrmServiceEndTaskDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          if IBCQueryTaskDSC.State in dsEditModes then IBCQueryTaskDSC.Post;

          // change task and indicent status
          UpdateTaskIncidentStatus;
          // create New task
          if cbCreateNewTask.Checked then CreateNewTask;

          fMasterDataSet.UpdateTransaction.Commit;

          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmServiceEndTaskDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        fMasterDataSet.Lock;

        IBCQueryTaskStatus.Active:=True;
        IBCQueryIncidentStatus.Active:=True;
        IBCQueryTaskTypes.Active:=True;
        IBCQueryAssignedUsers.Active:=True;
        IBCQueryTaskDSC.Active:=True;

        cmbSTATUS_ID.EditValue:=6303; // Завершена
        cmbI_STATUS_ID.EditValue:=fMasterDataSet.FieldByName('I_STATUS_ID').AsInteger;
     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmServiceEndTaskDlg.UpdateTaskIncidentStatus;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_SC_UPDATE_TASK(:IID,:TASKID,:TASK_STATUSID,:INCIDENT_STATUSID)';
        Query.ParamByName('IID').AsInteger:=fMasterDataSet.FieldByName('IID').AsInteger;
        Query.ParamByName('TASKID').AsInteger:=fMasterDataSet.FieldByName('TASKID').AsInteger;
        Query.ParamByName('TASK_STATUSID').AsInteger:=cmbSTATUS_ID.EditValue;
        Query.ParamByName('INCIDENT_STATUSID').AsInteger:=cmbI_STATUS_ID.EditValue;
        Query.ExecSQL;
     finally
        Query.Free;
     end;
end;

procedure TfrmServiceEndTaskDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     if IBCQueryTaskDSC.State in dsEditModes then IBCQueryTaskDSC.Cancel;

     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
