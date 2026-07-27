unit ServiceActionClass;

interface
Uses Classes, TaskClass;

type

  TServiceActionStatus = (stsIdle,stsRunning,stsDisabled);

  TServiceAction = class
  private
    { Private declarations }
    fTitle:String;
    FStoredProcedure: String;
    fMinutes: integer;
    fHour: integer;
    fCalendarMode: TSWNServiceTaskCalendarTarget;
    fRunMode: TSWNServiceTaskRunMode;
    FStatus: TServiceActionStatus;
    FSkipMinutes: integer;
    procedure SetStatus(const Value: TServiceActionStatus);
    procedure SetSkipMinutes(const Value: integer);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(const Title:String; const CalendarMode:TSWNServiceTaskCalendarTarget; const RunMode:TSWNServiceTaskRunMode;
                       const StartHour, StartMinutes:integer; const StoredProcedureName:String);

    property Status:TServiceActionStatus read FStatus write SetStatus;
    property Title:String read fTitle;
    property CalendarMode:TSWNServiceTaskCalendarTarget read fCalendarMode;
    property RunMode:TSWNServiceTaskRunMode read fRunMode;
    property StoredProcedure:String read FStoredProcedure;
    property Hour:integer read fHour;
    property Minutes:integer read fMinutes;

    property SkipMinutes:integer read FSkipMinutes write SetSkipMinutes;
  end;


  TServiceActionCollection = class
  private
    { Private declarations }
    function GetCount: integer;
    function getAction(index: integer): TServiceAction;
  protected
    { Protected declarations }
    fList:TList;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy;override;

    property Count:integer read GetCount;
    property Actions[index:integer]:TServiceAction read getAction; default;

    procedure Clear;
    procedure AddAction(const Action:TServiceAction);
  end;


implementation

{ TServiceAction }

constructor TServiceAction.Create(const Title:String; const CalendarMode: TSWNServiceTaskCalendarTarget;
  const RunMode: TSWNServiceTaskRunMode; const StartHour, StartMinutes: integer;
  const StoredProcedureName: String);
begin
     fTitle:=Title;
     fCalendarMode:=CalendarMode;
     fRunMode:=RunMode;
     fHour:=StartHour;
     fMinutes:=StartMinutes;
     FStoredProcedure:=StoredProcedureName;
     FStatus := stsIdle;
     FSkipMinutes := 0;
     if (CalendarMode=tctDay) and (RunMode=trmInterval) then FSkipMinutes := StartHour*60+StartMinutes;
end;

procedure TServiceAction.SetSkipMinutes(const Value: integer);
begin
     FSkipMinutes := Value;
end;

procedure TServiceAction.SetStatus(const Value: TServiceActionStatus);
begin
     FStatus := Value;
end;

{ TServiceActionCollection }

procedure TServiceActionCollection.AddAction(const Action: TServiceAction);
begin
     fList.Add(Action);
end;

procedure TServiceActionCollection.Clear;
var i:integer;
    action:TServiceAction;
begin
     for i := 0 to fList.Count - 1 do
     begin
          action:=TServiceAction(fList[i]);
          action.Free;
     end;
     fList.Clear;
end;

constructor TServiceActionCollection.Create;
begin
     fList:=TList.Create;
end;

destructor TServiceActionCollection.Destroy;
begin
     Clear;
     fList.Free;
     inherited;
end;

function TServiceActionCollection.getAction(index: integer): TServiceAction;
begin
     Result:=TServiceAction(fList[index]);
end;

function TServiceActionCollection.GetCount: integer;
begin
     Result:=fList.Count;
end;

end.
