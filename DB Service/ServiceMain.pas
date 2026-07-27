unit ServiceMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs, ExtCtrls,
  AppSettingsClass, TaskClass, ServiceActionClass, UtilsUnit;

type
  TServiceSWN = class(TService)
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
  private
    { Private declarations }
    fTimer:TTimerThread;
    fAppInstalled:Boolean;
    fAppPath:String;
    fServiceSettings:TSWNServiceManagerSettings;
    fTaskList:TSWNServiceTaskCollection;
    fActionList:TServiceActionCollection;

    // last value of timer
    fLastTime:TDateTime;
    fCurrentTime:TDateTime;

    function ReadAppPath:Boolean;
    procedure CreateActionList;

    procedure ProcessTimer;

    procedure ActivateActionsByCalendarMode(const CalendarMode:TSWNServiceTaskCalendarTarget);
    procedure RunAction(const Action:TServiceAction);
    procedure WhenActionThreadTerminated(const Action:TServiceAction; const Error:String);

    procedure ProcessTaskTimers;

  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  ServiceSWN: TServiceSWN;

implementation

uses
  System.IniFiles;
Uses Registry, DateUtils;

{$R *.DFM}

const
     cFILENAME_AppSettings = 'settings.dat';
     cFILENAME_Tasks = 'tasks.dat';


procedure ServiceController(CtrlCode: DWord); stdcall;
begin
     ServiceSWN.Controller(CtrlCode);
end;

procedure TServiceSWN.CreateActionList;
var i:integer;
    task:TSWNServiceTask;
    action:TServiceAction;
begin
     for i := 0 to fTaskList.Count - 1 do
     begin
          task:=fTaskList[i];

          action:=TServiceAction.Create(task.Title,task.CalendarTarget,task.RunMode,task.StartHour,task.StartMinutes,task.StoredProcedure);
          fActionList.AddAction(action);
     end;
end;

function TServiceSWN.GetServiceController: TServiceController;
begin
     Result := ServiceController;
end;

procedure TServiceSWN.ProcessTaskTimers;
var i:integer;
    action:TServiceAction;
    hh,mm,ss,ms:word;
begin
     //LogMessage('Timer tick: '+DateTimeToStr(fCurrentTime),EVENTLOG_SUCCESS);

     DecodeTime(fCurrentTime,hh,mm,ss,ms);
     for i := 0 to fActionList.Count - 1 do
     begin
          action:=fActionList[i];
          if (action.Status=stsRunning) or (action.Status=stsDisabled) then Continue;

          // interval action
          if (action.CalendarMode=tctDay) and (action.RunMode=trmInterval) then
          begin
               action.SkipMinutes:=action.SkipMinutes-1;
               if action.SkipMinutes<0 then RunAction(action); // run action
          end
          else
          begin
               if (action.Hour=hh) and (action.Minutes=mm) then RunAction(action); // run action
          end;

     end;
end;

procedure TServiceSWN.ProcessTimer;
var oldYear,oldMonth,oldWeek,oldWeekDay:word;
    curYear,cuMonth,curWeek,curWeekDay:word;
    trgNewDay,trgNewWeek,trgNewMonth{,trgNewYear}:Boolean;
begin
     fCurrentTime:=NOW;
     try
        DecodeDateMonthWeek(fLastTime,oldYear,oldMonth,oldWeek,oldWeekDay);
        DecodeDateMonthWeek(fCurrentTime,curYear,cuMonth,curWeek,curWeekDay);

        // compute triggers
        trgNewDay:=curWeekDay<>oldWeekDay;
        trgNewWeek:=curWeek<>oldWeek;
        trgNewMonth:=cuMonth<>oldMonth;
        //trgNewYear:=curYear<>oldYear;

        // fire triggers
        if trgNewDay then ActivateActionsByCalendarMode(tctDay);
        if trgNewWeek then ActivateActionsByCalendarMode(tctWeek);
        if trgNewMonth then ActivateActionsByCalendarMode(tctMonth);
        //if trgNewYear then RecalcTimersForYearlyTasks;

        ProcessTaskTimers;


     finally
        fLastTime:=fCurrentTime;
     end;

end;

function TServiceSWN.ReadAppPath: Boolean;
var
    path:String;

begin
     Result:=False;
     var ini:=TIniFile.Create('c:\windows\swnServiceManager.ini');
     try
        fAppPath := ini.ReadString('Working Path', 'Path', 'D:\SWN Tools\');
        Result := True;
     finally
        ini.Free;
     end;
//     Reg:=TRegistry.Create;
//     try
//        Reg.RootKey:=HKEY_LOCAL_MACHINE;
//        if Reg.OpenKeyReadOnly('SOFTWARE\SWN\Service Manager') then
//        begin
//             if Reg.ValueExists('Working Path') then
//             begin
//                  path:=IncludeTrailingPathDelimiter(Reg.ReadString('Working Path'));
//                  if DirectoryExists(path) then
//                  begin
//                       fAppPath:= 'D:\SWN Tools\';
//                       Result:=True;
//                  end;
//             end;
//             Reg.CloseKey;
//        end;
//     finally
//        Reg.Free;
//     end;
end;

procedure TServiceSWN.RunAction(const Action: TServiceAction);
begin
     LogMessage(Format('Action started: "%s"!',[Action.Title]),EVENTLOG_SUCCESS);
     Action.Status:=stsRunning;
     TSQLThread.Create(fServiceSettings,Action,WhenActionThreadTerminated);
end;

procedure TServiceSWN.ActivateActionsByCalendarMode(const CalendarMode:TSWNServiceTaskCalendarTarget);
var i:integer;
    action:TServiceAction;
begin
     for i := 0 to fActionList.Count - 1 do
     begin
          action:=fActionList[i];
          if action.CalendarMode=CalendarMode then action.Status := stsIdle;
     end;
end;

procedure TServiceSWN.ServiceCreate(Sender: TObject);
begin
     fTimer:=TTimerThread.Create(1,ProcessTimer);
     fActionList:=TServiceActionCollection.Create;
     fServiceSettings:=TSWNServiceManagerSettings.Create;
     fTaskList:=TSWNServiceTaskCollection.Create;
end;

procedure TServiceSWN.ServiceDestroy(Sender: TObject);
begin
     fTimer.Terminate;

     fActionList.Free;
     fServiceSettings.Free;
     fTaskList.Free;
end;

procedure TServiceSWN.ServiceStart(Sender: TService; var Started: Boolean);
begin
     fLastTime:=NOW;
     fAppInstalled:=ReadAppPath;
     if fAppInstalled then
     begin
          fServiceSettings.LoadFromFile(fAppPath+cFILENAME_AppSettings);
          fTaskList.LoadFromFile(fAppPath+cFILENAME_Tasks);
          CreateActionList;

          fTimer.Start;

          LogMessage('Service started!',EVENTLOG_SUCCESS);
          Started:=True;
     end
     else
     begin
          LogMessage('Working path not found!',EVENTLOG_ERROR_TYPE);
          Started:=False;
     end;
end;

procedure TServiceSWN.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
     fTimer.Suspended:=True;
     LogMessage('Service stopped!',EVENTLOG_SUCCESS);
     Stopped:=True;
end;


procedure TServiceSWN.WhenActionThreadTerminated(const Action: TServiceAction; const Error: String);
var S:String;
begin
     if Error<>'' then
     begin
          S:=Format('Failed to execute action "%s"!',[Action.Title]) + sLineBreak + Error;
          LogMessage(S,EVENTLOG_ERROR_TYPE);
     end
     else LogMessage(Format('Action "%s" executed succesuful!',[Action.Title]),EVENTLOG_SUCCESS);

     if (Action.CalendarMode=tctDay) and (Action.RunMode=trmInterval) then
     begin
          Action.SkipMinutes:=Action.Hour*60+Action.Minutes;
          Action.Status:=stsIdle;
     end
     else Action.Status:=stsDisabled;
end;

end.
