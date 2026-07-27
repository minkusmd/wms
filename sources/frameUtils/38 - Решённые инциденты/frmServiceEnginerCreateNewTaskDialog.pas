unit frmServiceEnginerCreateNewTaskDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Buttons, StdCtrls, DialogTitle,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, DB, DBAccess, IBC, MemDS;

type
  TfrmServiceEnginerCreateNewTaskDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnNext: TButton;
    btnCancel: TButton;
    pnClient: TPanel;
    rbContinue: TRadioButton;
    rbFinish: TRadioButton;
    Label1: TLabel;
    lcbContinueTaskType: TcxLookupComboBox;
    lcbFinishTaskType: TcxLookupComboBox;
    Label2: TLabel;
    Label3: TLabel;
    mmComments: TcxMemo;
    IBCQueryCont: TIBCQuery;
    IBCQueryFinish: TIBCQuery;
    IBCDataSourceCont: TIBCDataSource;
    IBCDataSourceFinish: TIBCDataSource;
    procedure rbContinueClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateView;
    function CheckValues:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    function getTaskType:Integer;
    function getComments:String;
  end;


implementation

uses DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmServiceEnginerCreateNewTaskDlg }

function TfrmServiceEnginerCreateNewTaskDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     if rbContinue.Checked then
     begin
          if VarIsNull(lcbContinueTaskType.EditValue) or (lcbContinueTaskType.EditValue<=0) then AddErrorToStr(ErrorStr,'Новая задача!');
     end
     else
     begin
          if VarIsNull(lcbFinishTaskType.EditValue) or (lcbFinishTaskType.EditValue<=0) then AddErrorToStr(ErrorStr,'Результат выполнения!');
          if VarIsNull(mmComments.EditValue) or (Trim(mmComments.EditValue)='') then AddErrorToStr(ErrorStr,'Коментарий к выполненой задачи!');
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

function TfrmServiceEnginerCreateNewTaskDlg.getComments: String;
begin
     Result:='';
     if rbFinish.Checked and Not VarIsNull(mmComments.EditValue) then Result:=Trim(mmComments.EditValue);
end;

function TfrmServiceEnginerCreateNewTaskDlg.getTaskType: Integer;
begin
     Result:=-1;
     if rbContinue.Checked and VarIsNumeric(lcbContinueTaskType.EditValue) then Result:=lcbContinueTaskType.EditValue
     else
     if rbFinish.Checked and VarIsNumeric(lcbFinishTaskType.EditValue) then Result:=lcbFinishTaskType.EditValue;
end;

function TfrmServiceEnginerCreateNewTaskDlg.IsFormDataPosted: Boolean;
begin
     Result:=CheckValues;
end;

procedure TfrmServiceEnginerCreateNewTaskDlg.Prepare;
begin
     // defaults
     rbContinue.Checked:=True;
     lcbContinueTaskType.EditValue:=-1;
     lcbFinishTaskType.EditValue:=-1;
     mmComments.EditValue:='';

     UpdateView;

     // data
     IBCQueryCont.Active:=True;
     IBCQueryFinish.Active:=True;

end;

procedure TfrmServiceEnginerCreateNewTaskDlg.rbContinueClick(Sender: TObject);
begin
     UpdateView;
end;

procedure TfrmServiceEnginerCreateNewTaskDlg.UpdateView;
begin
     if rbContinue.Checked then
     begin
          // enable
          Label1.Enabled:=True;
          lcbContinueTaskType.Enabled:=True;
          // disable
          Label2.Enabled:=False;
          lcbFinishTaskType.Enabled:=False;
          lcbFinishTaskType.EditValue:=-1;
          Label3.Enabled:=False;
          mmComments.Enabled:=False;
          mmComments.EditValue:='';
     end
     else
     begin
          // enable
          Label2.Enabled:=True;
          lcbFinishTaskType.Enabled:=True;
          Label3.Enabled:=True;
          mmComments.Enabled:=True;
          // disable
          Label1.Enabled:=False;
          lcbContinueTaskType.Enabled:=False;
          lcbContinueTaskType.EditValue:=-1;
     end;
end;

end.
