unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, StdCtrls, ComCtrls, ExtCtrls, AppSettingsClass, Buttons, TaskClass;

type
  TfMain = class(TForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    lbTaskTitle: TLabel;
    lbServiceSettings: TLabel;
    lvTasks: TListView;
    lbViewLog: TLabel;
    btnClose: TButton;
    btnSave: TButton;
    sbNewTask: TSpeedButton;
    sbModifyTask: TSpeedButton;
    sbDeleteTask: TSpeedButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbServiceSettingsClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure lvTasksSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure sbNewTaskClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbModifyTaskClick(Sender: TObject);
    procedure sbDeleteTaskClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    fAppInstalled: Boolean;
    fAppPath: String;
    fServiceSettings: TSWNServiceManagerSettings;
    fTaskList: TSWNServiceTaskCollection;
    fChanged: Boolean;
    function ReadAppPath: Boolean;
    procedure WriteAppPathRegistry;

    procedure PrepareView;
    procedure ShowAppSettingsDialog;

    procedure SaveAllSettings;

    procedure SelectionChanged;
    procedure DisplayAllTasks;
    procedure ShowCreateNewTaskDialog;
    procedure AddTaskToDisplay(const Task: TSWNServiceTask);
    procedure ShowModifyTaskDialog;
    procedure ChangeTaskToDisplay(const Task: TSWNServiceTask; const Item: TListItem);

    procedure ShowRemoveTaskDialog;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

uses
  System.IniFiles, Registry, SetupConnectionDialog, TaskConfigDialog;

{$R *.dfm}

const
  cFILENAME_AppSettings = 'settings.dat';
  cFILENAME_Tasks = 'tasks.dat';

procedure TfMain.AddTaskToDisplay(const Task: TSWNServiceTask);
var
  Item: TListItem;
  S: String;
begin
  lvTasks.Items.BeginUpdate;
  try
    Item := lvTasks.Items.Add;
    Item.Caption := Task.Title;
    if Task.Enabled then
      Item.SubItems.Add('да')
    else
      Item.SubItems.Add('нет');
    case Task.CalendarTarget of
      tctDay:
        S := 'день';
      tctWeek:
        S := 'недел.';
      tctMonth:
        S := 'месяц';
    end;
    S := S + Format(' %2.2d:%2.2d', [Task.StartHour, Task.StartMinutes]);
    if Task.RunMode = trmInterval then
      S := S + '@';
    Item.SubItems.Add(S);
    Item.SubItems.Add(Task.StoredProcedure);
    Item.Data := Task;
  finally
    lvTasks.Items.EndUpdate;
  end;

end;

procedure TfMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.btnSaveClick(Sender: TObject);
begin
  SaveAllSettings;
end;

procedure TfMain.ChangeTaskToDisplay(const Task: TSWNServiceTask; const Item: TListItem);
var
  S: String;
begin
  lvTasks.Items.BeginUpdate;
  try
    Item.Caption := Task.Title;
    if Task.Enabled then
      S := 'да'
    else
      S := 'нет';
    Item.SubItems[0] := S;
    case Task.CalendarTarget of
      tctDay:
        S := 'день';
      tctWeek:
        S := 'недел.';
      tctMonth:
        S := 'месяц';
    end;
    S := S + Format(' %2.2d:%2.2d', [Task.StartHour, Task.StartMinutes]);
    if Task.RunMode = trmInterval then
      S := S + '@';
    Item.SubItems[1] := S;
    Item.SubItems[2] := Task.StoredProcedure;
  finally
    lvTasks.Items.EndUpdate;
  end;
end;

procedure TfMain.DisplayAllTasks;
var
  i: integer;
  Task: TSWNServiceTask;
begin
  lvTasks.Items.BeginUpdate;
  try
    for i := 0 to fTaskList.Count - 1 do
    begin
      Task := fTaskList[i];
      AddTaskToDisplay(Task);
    end;
  finally
    lvTasks.Items.EndUpdate;
  end;
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if fChanged and (MessageDlg('Есть изменения! Выйти из программы?', mtConfirmation, [mbYes, mbNo], 0) = mrNo) then
    CanClose := false;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  fServiceSettings := TSWNServiceManagerSettings.Create;
  fTaskList := TSWNServiceTaskCollection.Create;

  fAppInstalled := ReadAppPath;
  if fAppInstalled then
  begin
    fServiceSettings.LoadFromFile(fAppPath + '\' + cFILENAME_AppSettings);
    fTaskList.LoadFromFile(fAppPath + '\' + cFILENAME_Tasks);
  end;

  PrepareView;
  DisplayAllTasks;

  fChanged := false;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  fServiceSettings.Free;
  fTaskList.Free;
end;

procedure TfMain.lbServiceSettingsClick(Sender: TObject);
begin
  ShowAppSettingsDialog;
end;

procedure TfMain.lvTasksSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  SelectionChanged;
end;

procedure TfMain.PrepareView;
begin
  lbViewLog.Enabled := fAppInstalled;
  lvTasks.Enabled := fAppInstalled;
  lbTaskTitle.Enabled := fAppInstalled;
  btnSave.Enabled := fAppInstalled;

  SelectionChanged;
end;

function TfMain.ReadAppPath: Boolean;
var
  Reg: TRegistry;
  path: String;
begin
  Result := false;
  var
  ini := TIniFile.Create('c:\windows\swnServiceManager.ini');
  try
    fAppPath := ini.ReadString('Working Path', 'Path', extractfiledir(application.ExeName));
    Result := True;
  finally
    ini.Free;
  end;
  // Result:=False;
  // fAppPath  := extractfiledir(application.ExeName);
  // if fAppPath<> '' then
  // Result := True;
  // Reg:=TRegistry.Create;
  // try
  // Reg.RootKey:=HKEY_LOCAL_MACHINE;
  // if Reg.OpenKeyReadOnly('SOFTWARE\SWN\Service Manager') then
  // begin
  // if Reg.ValueExists('Working Path') then
  // begin
  // path:=IncludeTrailingPathDelimiter(Reg.ReadString('Working Path'));
  // if DirectoryExists(path) then
  // begin
  // fAppPath:=path;
  // Result:=True;
  // end;
  // end;
  // Reg.CloseKey;
  // end;
  // finally
  // Reg.Free;
  // end;
end;

procedure TfMain.SaveAllSettings;
begin
  // save config
  fServiceSettings.SaveToFile(fAppPath + '\' + cFILENAME_AppSettings);
  // save tasks
  fTaskList.SaveToFile(fAppPath + '\' + cFILENAME_Tasks);
  // save to registry
  WriteAppPathRegistry;

  fChanged := false;
end;

procedure TfMain.sbDeleteTaskClick(Sender: TObject);
begin
  ShowRemoveTaskDialog;
end;

procedure TfMain.sbModifyTaskClick(Sender: TObject);
begin
  ShowModifyTaskDialog;
end;

procedure TfMain.sbNewTaskClick(Sender: TObject);
begin
  ShowCreateNewTaskDialog;
end;

procedure TfMain.SelectionChanged;
var
  fNew, fEdit, fDel: Boolean;
begin
  fNew := fAppInstalled;
  fEdit := false;
  fDel := false;
  if fAppInstalled and Assigned(lvTasks.Selected) then
  begin
    fEdit := True;
    fDel := True;
  end;
  sbNewTask.Enabled := fNew;
  sbModifyTask.Enabled := fEdit;
  sbDeleteTask.Enabled := fDel;
end;

procedure TfMain.ShowAppSettingsDialog;
var
  dialog: TfrmSetupConnectionDlg;
begin
  dialog := TfrmSetupConnectionDlg.Create(Self);
  try
    dialog.AppPath := fAppPath;
    dialog.AppSettings := fServiceSettings;

    if dialog.ShowModal = mrOk then
    begin
      fAppPath := dialog.AppPath;
      fAppInstalled := True;
      PrepareView;
      fChanged := True;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfMain.ShowCreateNewTaskDialog;
var
  dialog: TfrmTaskConfigDlg;
  tmpTask: TSWNServiceTask;
begin
  dialog := TfrmTaskConfigDlg.Create(Self);
  try
    dialog.dtDialogTitle.Text := 'Создание новой задачи';
    tmpTask := TSWNServiceTask.Create;

    dialog.ServiceSettings := fServiceSettings;
    dialog.Task := tmpTask;
    if dialog.ShowModal = mrOk then
    begin
      fTaskList.AddTask(tmpTask);
      AddTaskToDisplay(tmpTask);
      fChanged := True;
    end
    else
      tmpTask.Free;
  finally
    dialog.Free;
  end;
end;

procedure TfMain.ShowModifyTaskDialog;
var
  Item: TListItem;
  dialog: TfrmTaskConfigDlg;
begin
  Item := lvTasks.Selected;
  if Assigned(Item) then
  begin
    dialog := TfrmTaskConfigDlg.Create(Self);
    try
      dialog.dtDialogTitle.Text := 'Изменение задачи';
      dialog.ServiceSettings := fServiceSettings;
      dialog.Task := TSWNServiceTask(Item.Data);
      if dialog.ShowModal = mrOk then
      begin
        ChangeTaskToDisplay(dialog.Task, Item);
        fChanged := True;
      end
    finally
      dialog.Free;
    end;
  end;
end;

procedure TfMain.ShowRemoveTaskDialog;
var
  Item: TListItem;
begin
  Item := lvTasks.Selected;
  if Assigned(Item) and (MessageDlg(Format('Удалить задачу "%s"?', [Item.Caption]), mtConfirmation, [mbYes, mbNo], 0)
    = mrYes) then
  begin
    lvTasks.Items.BeginUpdate;
    try
      fTaskList.RemoveTask(TSWNServiceTask(Item.Data));
      Item.Delete;
      fChanged := True;
    finally
      lvTasks.Items.EndUpdate;
    end;
  end;
end;

procedure TfMain.WriteAppPathRegistry;
// var Reg:TRegistry;
begin
  // Result:=False;
  var
  ini := TIniFile.Create('c:\windows\swnServiceManager.ini');
  try
    ini.WriteString('Working Path', 'Path', fAppPath);
    // Result := True;
  finally
    ini.Free;
  end;
  // Reg:=TRegistry.Create;
  // try
  // Reg.RootKey:=HKEY_LOCAL_MACHINE;
  // if Reg.OpenKey('SOFTWARE\SWN\Service Manager',True) then
  // begin
  // Reg.WriteString('Working Path',fAppPath);
  // Reg.CloseKey;
  // end;
  // finally
  // Reg.Free;
  // end;
  // fAppPath := application.GetNamePath;
end;

end.
