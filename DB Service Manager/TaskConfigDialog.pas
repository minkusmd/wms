unit TaskConfigDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DialogTitle, StdCtrls, AppSettingsClass, TaskClass;

type
  TfrmTaskConfigDlg = class(TForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cbEnabled: TCheckBox;
    Label1: TLabel;
    edTaskTitle: TEdit;
    Label2: TLabel;
    cmbCalendarTarget: TComboBox;
    edTime: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    cmbStoredProcedure: TComboBox;
    btnOk: TButton;
    btnCancel: TButton;
    cmbRunMode: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    n1,n2:integer;
    FTask: TSWNServiceTask;
    FServiceSettings: TSWNServiceManagerSettings;
    procedure SetTask(const Value: TSWNServiceTask);
    procedure SetServiceSettings(const Value: TSWNServiceManagerSettings);

    procedure PrepareView;
    function CheckValues:Boolean;
    procedure SaveValues;
  public
    { Public declarations }
    property ServiceSettings:TSWNServiceManagerSettings read FServiceSettings write SetServiceSettings;
    property Task:TSWNServiceTask read FTask write SetTask;
  end;


implementation

{$R *.dfm}

{ TfrmTaskConfigDlg }

procedure TfrmTaskConfigDlg.btnOkClick(Sender: TObject);
begin
     if CheckValues then
     begin
          SaveValues;
          ModalResult:=mrOk;
     end;
end;

function TfrmTaskConfigDlg.CheckValues: Boolean;
var S,SS:String;
    k:integer;
begin
     Result:=False;
     S:='';

     if Trim(edTaskTitle.Text)='' then S:=S+'Íàçâàíèå çàäà÷è? ';
     if (cmbCalendarTarget.ItemIndex=-1) or (cmbRunMode.ItemIndex=-1) then S:=S+'Âğåìÿ èñïîëíåíèÿ? ';
     if Trim(edTime.Text)='' then S:=S+'Âğåìÿ èñïîëíåíèÿ? '
     else
     begin
          SS:=Trim(edTime.Text);
          k:=Pos(':',SS);
          if k>0 then
          begin
               n1:=StrToIntDef(Copy(SS,1,k-1),-1);
               n2:=StrToIntDef(Copy(SS,k+1,Length(SS)),-1);
               if Not ((N1>=0) and (N1<=23) and (N2>=0) and (N2<=59)) then S:=S+'Âğåìÿ èñïîëíåíèÿ? '
          end
          else S:=S+'Âğåìÿ èñïîëíåíèÿ? ';
     end;

     if Trim(cmbStoredProcedure.Text)='' then S:=S+'Çàäà÷à äëÿ âûïîëíåíèÿ? ';

     if S='' then Result:=true
     else MessageDlg(S,mtError,[mbOk],0);
end;

procedure TfrmTaskConfigDlg.FormShow(Sender: TObject);
begin
     PrepareView;
end;

procedure TfrmTaskConfigDlg.PrepareView;
begin
     edTaskTitle.Text:=FTask.Title;
     cbEnabled.Checked:=FTask.Enabled;
     cmbCalendarTarget.ItemIndex:=Ord(FTask.CalendarTarget);
     cmbRunMode.ItemIndex:=Ord(fTask.RunMode);
     edTime.Text:=Format('%2.2d:%2.2d',[FTask.StartHour,FTask.StartMinutes]);
     cmbStoredProcedure.Text:=FTask.StoredProcedure;
end;

procedure TfrmTaskConfigDlg.SaveValues;
begin
     FTask.Title:=Trim(edTaskTitle.Text);
     FTask.Enabled:=cbEnabled.Checked;
     FTask.CalendarTarget:=TSWNServiceTaskCalendarTarget(cmbCalendarTarget.ItemIndex);
     fTask.RunMode:=TSWNServiceTaskRunMode(cmbRunMode.ItemIndex);
     FTask.StartHour:=N1;
     FTask.StartMinutes:=N2;
     FTask.StoredProcedure:=Trim(cmbStoredProcedure.Text);
end;

procedure TfrmTaskConfigDlg.SetServiceSettings(const Value: TSWNServiceManagerSettings);
begin
  FServiceSettings := Value;
end;

procedure TfrmTaskConfigDlg.SetTask(const Value: TSWNServiceTask);
begin
  FTask := Value;
end;

end.
