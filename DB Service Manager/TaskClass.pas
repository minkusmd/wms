unit TaskClass;

interface
Uses Classes;

type

  TSWNServiceTaskCalendarTarget = (tctDay, tctWeek, tctMonth);
  TSWNServiceTaskRunMode = (trmExactTime, trmInterval);

  TSWNServiceTask = class
  private
    { Private declarations }
    FTitle: String;
    FEnabled: Boolean;
    FCalendarTarget: TSWNServiceTaskCalendarTarget;
    FStoredProcedure: String;
    FStartHour: integer;
    FStartMinutes: integer;
    FRunMode: TSWNServiceTaskRunMode;
    procedure SetTitle(const Value: String);
    procedure SetEnabled(const Value: Boolean);
    procedure SetCalendarTarget(const Value: TSWNServiceTaskCalendarTarget);
    procedure SetStoredProcedure(const Value: String);
    procedure SetStartHour(const Value: integer);
    procedure SetStartMinutes(const Value: integer);
    procedure SetRunMode(const Value: TSWNServiceTaskRunMode);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create;

    property Title:String read FTitle write SetTitle;
    property Enabled:Boolean read FEnabled write SetEnabled;
    property CalendarTarget:TSWNServiceTaskCalendarTarget read FCalendarTarget write SetCalendarTarget;
    property RunMode:TSWNServiceTaskRunMode read FRunMode write SetRunMode;
    property StartHour:integer read FStartHour write SetStartHour;
    property StartMinutes:integer read FStartMinutes write SetStartMinutes;

    property StoredProcedure:String read FStoredProcedure write SetStoredProcedure;

    procedure LoadFromStream(const Stream:TStream);
    procedure SaveToStream(const Stream: TStream);
  end;


  TSWNServiceTaskCollection = class
  private
    { Private declarations }
    function getCount: integer;
    function GetTask(index: integer): TSWNServiceTask;
  protected
    { Protected declarations }
    fTaskList:TList;

    procedure LoadFromStream(const Stream:TStream);
    procedure SaveToStream(const Stream:TStream);
  public
    { Public declarations }
    constructor Create;
    destructor Destroy;override;

    property Count:integer read getCount;
    property Task[index:integer]:TSWNServiceTask read GetTask; default;

    procedure Clear;
    procedure AddTask(const Task:TSWNServiceTask);
    procedure RemoveTask(const Task:TSWNServiceTask);

    procedure LoadFromFile(const FileName:String);
    procedure SaveToFile(const FileName:String);
  end;



implementation
Uses SysUtils;

{ TSWNServiceTask }

constructor TSWNServiceTask.Create;
begin
     FCalendarTarget := tctDay;
     FEnabled := False;
     FStartHour := 0;
     FStartMinutes := 0;
     FStoredProcedure := '';
     FTitle := '';
     FRunMode := trmExactTime;
end;

procedure TSWNServiceTask.LoadFromStream(const Stream: TStream);
var N:integer;
begin
     // Title
     Stream.Read(N,SizeOf(Integer));
     SetLength(FTitle,N);
     if N>0 then Stream.Read(FTitle[1],N*SizeOf(Char));

     // Enabled
     Stream.Read(FEnabled,SizeOf(Boolean));

     // CalendarTarget
     Stream.Read(N,SizeOf(Integer));
     FCalendarTarget:=TSWNServiceTaskCalendarTarget(N);

     // Stored Procedure
     Stream.Read(N,SizeOf(Integer));
     SetLength(FStoredProcedure,N);
     if N>0 then Stream.Read(FStoredProcedure[1],N*SizeOf(Char));

     // StartHour
     Stream.Read(FStartHour,SizeOf(Integer));

     // StartMinutes
     Stream.Read(FStartMinutes,SizeOf(Integer));

     // Run Mode
     Stream.Read(N,SizeOf(Integer));
     FRunMode:=TSWNServiceTaskRunMode(N);
end;

procedure TSWNServiceTask.SaveToStream(const Stream: TStream);
var N:integer;
begin
     // Title
     N:=Length(FTitle);
     Stream.Write(N,SizeOf(Integer));
     Stream.Write(FTitle[1],N*SizeOf(Char));

     // Enabled
     Stream.Write(FEnabled,SizeOf(Boolean));

     // CalendarTarget
     N:=Ord(FCalendarTarget);
     Stream.Write(N,SizeOf(Integer));

     // Stored Procedure
     N:=Length(FStoredProcedure);
     Stream.Write(N,SizeOf(Integer));
     Stream.Write(FStoredProcedure[1],N*SizeOf(Char));

     // StartHour
     Stream.Write(FStartHour,SizeOf(Integer));

     // StartMinutes
     Stream.Write(FStartMinutes,SizeOf(Integer));

     // Run Mode
     N:=Ord(FRunMode);
     Stream.Write(N,SizeOf(Integer));
end;

procedure TSWNServiceTask.SetCalendarTarget(const Value: TSWNServiceTaskCalendarTarget);
begin
  FCalendarTarget := Value;
end;

procedure TSWNServiceTask.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TSWNServiceTask.SetRunMode(const Value: TSWNServiceTaskRunMode);
begin
     FRunMode := Value;
end;

procedure TSWNServiceTask.SetStartHour(const Value: integer);
begin
  FStartHour := Value;
end;

procedure TSWNServiceTask.SetStartMinutes(const Value: integer);
begin
  FStartMinutes := Value;
end;

procedure TSWNServiceTask.SetStoredProcedure(const Value: String);
begin
  FStoredProcedure := Value;
end;

procedure TSWNServiceTask.SetTitle(const Value: String);
begin
  FTitle := Value;
end;

{ TSWNServiceTaskCollection }

procedure TSWNServiceTaskCollection.AddTask(const Task: TSWNServiceTask);
begin
     fTaskList.Add(Task);
end;

procedure TSWNServiceTaskCollection.Clear;
var i:integer;
    Task:TSWNServiceTask;
begin
     for i := 0 to fTaskList.Count - 1 do
     begin
          Task:=TSWNServiceTask(fTaskList[i]);
          Task.Free;
     end;
     fTaskList.Clear;
end;

constructor TSWNServiceTaskCollection.Create;
begin
     fTaskList:=TList.Create;
end;

destructor TSWNServiceTaskCollection.Destroy;
begin
     Clear;
     fTaskList.Free;
     inherited;
end;

function TSWNServiceTaskCollection.getCount: integer;
begin
     Result:=fTaskList.Count;
end;

function TSWNServiceTaskCollection.GetTask(index: integer): TSWNServiceTask;
begin
     Result:=TSWNServiceTask(fTaskList[index]);
end;

procedure TSWNServiceTaskCollection.LoadFromFile(const FileName: String);
var F:TFileStream;
begin
     if Not FileExists(FileName) then Exit;

     Clear;

     F:=TFileStream.Create(FileName,fmOpenRead);
     try
        LoadFromStream(F);
     finally
        F.Free;
     end;
end;

procedure TSWNServiceTaskCollection.LoadFromStream(const Stream: TStream);
var i,N:integer;
    task:TSWNServiceTask;
begin
     Stream.Read(N,SizeOf(Integer));

     for i := 1 to N do
     begin
          task:=TSWNServiceTask.Create;
          task.LoadFromStream(Stream);
          fTaskList.Add(task);
     end;
end;

procedure TSWNServiceTaskCollection.RemoveTask(const Task: TSWNServiceTask);
begin
     fTaskList.Remove(Task);
end;

procedure TSWNServiceTaskCollection.SaveToFile(const FileName: String);
var F:TFileStream;
begin
     F:=TFileStream.Create(FileName,fmCreate);
     try
        SaveToStream(F);
     finally
        F.Free;
     end;
end;

procedure TSWNServiceTaskCollection.SaveToStream(const Stream: TStream);
var i,N:integer;
    task:TSWNServiceTask;
begin
     N:=fTaskList.Count;

     Stream.Write(N,SizeOf(Integer));

     for i := 0 to fTaskList.Count - 1 do
     begin
          task:=TSWNServiceTask(fTaskList[i]);
          task.SaveToStream(Stream);
     end;
end;

end.
