unit frmServiceEnginerAcceptAssignmentDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, cxMemo, cxTextEdit, StdCtrls, ExtCtrls, DialogTitle;

type
  TfrmServiceEnginerAcceptAssignmentDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edTITLE: TcxDBTextEdit;
    Label2: TLabel;
    mmCOMMENTS: TcxDBMemo;
    Label3: TLabel;
    Label4: TLabel;
    edSN: TcxDBTextEdit;
    dteEND_ESTIMATED_TIME: TcxDBDateEdit;
    Label5: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    Label6: TLabel;
    edCREATED_FULL_NAME: TcxDBTextEdit;
  private
    { Private declarations }
    procedure LockTask(const TaskID:integer);
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleAdditions, DataModuleDB, IBC;

{$R *.dfm}

{ TfrmServiceEnginerAcceptAssignmentDlg }

procedure TfrmServiceEnginerAcceptAssignmentDlg.BindingDataSource;
begin
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     mmCOMMENTS.DataBinding.DataSource:=fMasterDataSource;
     edSN.DataBinding.DataSource:=fMasterDataSource;
     dteEND_ESTIMATED_TIME.DataBinding.DataSource:=fMasterDataSource;
     edCREATED_FULL_NAME.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmServiceEnginerAcceptAssignmentDlg.IsFormDataPosted: Boolean;
begin
     dmDB.IBCTrDefaultUpdate.Commit;
     Result:=True;
end;

procedure TfrmServiceEnginerAcceptAssignmentDlg.LockTask(const TaskID: integer);
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='SELECT NULL FROM SC_TASK WHERE TASKID=:id FOR UPDATE WITH LOCK';
        Query.ParamByName('id').AsInteger:=TaskID;
        Query.ExecSQL;
     finally
        Query.Free;
     end;
end;

procedure TfrmServiceEnginerAcceptAssignmentDlg.Prepare;
begin
     // lock task
     dmDB.IBCTrDefaultUpdate.StartTransaction;
     try
        LockTask(fMasterDataSet.FieldByName('TASKID').AsInteger);
     except
        dmDB.IBCTrDefaultUpdate.Rollback;
        raise;
     end;
end;

procedure TfrmServiceEnginerAcceptAssignmentDlg.WhenCancelForm;
begin
     dmDB.IBCTrDefaultUpdate.Rollback;
end;

end.
