unit frmServiceEnginerCreateNewAssignmentDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  StdCtrls, cxDropDownEdit, cxCalendar, cxTextEdit, cxMemo, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  DB, DBAccess, IBC, MemDS;

type
  TfrmServiceEnginerCreateNewAssignmentDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    lcbTaskTypeID: TcxLookupComboBox;
    Label2: TLabel;
    mmComments: TcxMemo;
    Label3: TLabel;
    edSN: TcxTextEdit;
    Label4: TLabel;
    deEndDateTime: TcxDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryTasks: TIBCQuery;
    IBCDataSourceTasks: TIBCDataSource;
  private
    { Private declarations }
    fParentTaskID: integer;
    procedure SetParentTaskID(const Value: integer);

    function CheckValues:Boolean;

  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;

  public
    { Public declarations }
    function getTaskTypeID:integer;
    function getComents:String;
    function getSN:String;
    function getFinalDateTime:TDateTime;
  end;


implementation

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmServiceEnginerCreateNewAssignmentDlg }

function TfrmServiceEnginerCreateNewAssignmentDlg.CheckValues: Boolean;
var ErrorStr:String;
begin
     Result:=false;
     ErrorStr:='';

     if VarisNull(lcbTaskTypeID.EditValue) or (lcbTaskTypeID.EditValue<=0) then AddErrorToStr(ErrorStr,'Cerere!');
     if VarIsNull(mmComments.EditValue) or (Trim(mmComments.EditValue)='') then AddErrorToStr(ErrorStr,'Comentariu!');
     if VarIsNull(deEndDateTime.EditValue) or (deEndDateTime.Date<NOW) then AddErrorToStr(ErrorStr,'Efectuati sarcina pana la...!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

function TfrmServiceEnginerCreateNewAssignmentDlg.getComents: String;
begin
     Result:='';
     if Not VarIsNull(mmComments.EditValue) then Result:=Trim(mmComments.EditValue);
end;

function TfrmServiceEnginerCreateNewAssignmentDlg.getFinalDateTime: TDateTime;
begin
     Result:=0;
     if VarIsNull(deEndDateTime.EditValue) or (deEndDateTime.Date<NOW) then Result:=deEndDateTime.Date;
end;

function TfrmServiceEnginerCreateNewAssignmentDlg.getSN: String;
begin
     Result:='';
     if Not VarIsNull(edSN.EditValue) then Result:=Trim(edSN.EditValue);
end;

function TfrmServiceEnginerCreateNewAssignmentDlg.getTaskTypeID: integer;
begin
     Result:=-1;
     if Not VarisNull(lcbTaskTypeID.EditValue) then Result:=lcbTaskTypeID.EditValue;
end;

function TfrmServiceEnginerCreateNewAssignmentDlg.IsFormDataPosted: Boolean;
begin
     Result:=CheckValues;
end;

procedure TfrmServiceEnginerCreateNewAssignmentDlg.Prepare;
begin
     IBCQueryTasks.Active:=True;
     mmComments.EditValue:='';
     edSN.EditValue:='';
     deEndDateTime.Date:=NOW;
end;

procedure TfrmServiceEnginerCreateNewAssignmentDlg.SetParentTaskID(const Value: integer);
begin
     fParentTaskID := Value;
end;

end.
