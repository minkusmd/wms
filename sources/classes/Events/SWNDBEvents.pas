unit SWNDBEvents;

interface
Uses Classes, IBC;

type

  TSWNDBEventType = (dbetNone=0,
                     dbetRashod=1,
                     dbetSborka=2,
                     dbetRashodCommentsChanged=3,
                     dbetSborksCommentsChanged=4,
                     dbetPeremeshenieCommentsChanged=5,
                     dbetWebZakaz=6,
                     dbetWebCerereFinantare=7,
                     dbetSchedulerDelivery=8,
                     dbetGoodsPreOrder=9);
  TSWNDBEventTypeSet = set of TSWNDBEventType;


const
  cEventsComments = [dbetRashodCommentsChanged, dbetSborksCommentsChanged, dbetPeremeshenieCommentsChanged];


type

  TSWNDBEvent = class
  private
    { private declarations }
    fEventID: integer;
    fMsg: String;
    fEventType: TSWNDBEventType;
    fDateTime: TDateTime;
    fIsNew: Boolean;
    fValueInt: integer;
    fUserID: integer;
    fUserFullName: String;
    fDT: integer;
  protected
    { protected declarations }
    function GetTitle: String;
  public
    { public declarations }
    constructor Create;

    property EventID:integer read fEventID;
    property DT:integer read fDT;
    property DateTime:TDateTime read fDateTime;
    property EventType:TSWNDBEventType read fEventType;
    property Msg:String read fMsg;
    property ValueInt:integer read fValueInt;
    property UserID:integer read fUserID;
    property UserFullName:String read fUserFullName;

    property IsNew:Boolean read fIsNew;
    property Title:String read GetTitle;

    procedure MarkAsRead;
  end;


  TSWNDBEventOnNewEvent = procedure (const ListOfEvents:TList) of object;

  TSWNDBEventManager = class
  private
    { private declarations }
    FOnNewEvent: TSWNDBEventOnNewEvent;
    FEventTypes: TSWNDBEventTypeSet;

    function GetCount: integer;
    function GetEvent(Index: integer): TSWNDBEvent;
    procedure SetScanInterval(const Value: integer);
    procedure SetOnNewEvents(const Value: TSWNDBEventOnNewEvent);
    procedure SetFirma(const Value: Integer);
    procedure SetEventTypes(const Value: TSWNDBEventTypeSet);
  protected
    { protected declarations }
    fEvents:TList;
    fDBConnection:TIBCConnection;
    fDT:integer;
    fScanInterval:integer;

    procedure NotifyForNewEvent(const listOfEvents:TList);
    function GetEventTypesInStr:String;
  public
    { public declarations }
    constructor Create(const DBConnection:TIBCConnection);
    destructor Destroy;override;

    property Firma:Integer read fDT write SetFirma;
    property ScanInterval:integer read fScanInterval write SetScanInterval;
    property Count:integer read GetCount;
    property EventTypes:TSWNDBEventTypeSet read FEventTypes write SetEventTypes;
    property Events[Index:integer]:TSWNDBEvent read GetEvent;


    property OnNewEvent:TSWNDBEventOnNewEvent read FOnNewEvent write SetOnNewEvents;

    procedure Clear;
    function ScanForEvents:Boolean;
    function GetEventByID(const EventID:integer):TSWNDBEvent;

  end;



implementation
Uses SysUtils, DateUtils;

const
     cSWNDBEventTypeNames:array[TSWNDBEventType] of String =
     (
      'Unknown',
      'Nakladnaia de iesire',
      'Naryad de asamblare',
      'Iesire: comentariu',
      'Asamblare: comentariu',
      'Transfer: comentariu',
      'Comanda Web',
      'Cerere de finantare',
      'Grafic de livrare',
      'Comenzi preliminare'
     );


{ TSWNDBEvent }

constructor TSWNDBEvent.Create;
begin
     fEventID:=0;
     fDT:=0;
     fDateTime:=0;
     fEventType:=dbetNone;
     fMsg:='';
     fValueInt:=0;
     fUserID:=0;
     fUserFullName:='';

     fIsNew:=True;
end;

function TSWNDBEvent.GetTitle: String;
begin
     Result:=cSWNDBEventTypeNames[fEventType];
end;

procedure TSWNDBEvent.MarkAsRead;
begin
     fIsNew:=False;
end;

{ TSWNDBEventManager }

procedure TSWNDBEventManager.Clear;
var i:integer;
begin
     for i := 0 to fEvents.Count - 1 do TSWNDBEvent(fEvents[i]).Free;
     fEvents.Clear;
end;

constructor TSWNDBEventManager.Create(const DBConnection: TIBCConnection);
begin
     fEvents:=TList.Create;
     fDT:=0;
     fDBConnection:=DBConnection;
     fScanInterval:=60; //sec
     FOnNewEvent := nil;
     FEventTypes := [];
end;

destructor TSWNDBEventManager.Destroy;
begin
     Clear;
     fEvents.Free;
     inherited;
end;

function TSWNDBEventManager.GetCount: integer;
begin
     Result:=fEvents.Count;
end;

function TSWNDBEventManager.GetEvent(Index: integer): TSWNDBEvent;
begin
     Result:=TSWNDBEvent(fEvents[Index]);
end;

function TSWNDBEventManager.GetEventByID(const EventID: integer): TSWNDBEvent;
var i:integer;
    Event:TSWNDBEvent;
begin
     Result:=Nil;
     for i := fEvents.Count - 1 downto 0 do
     begin
          Event:=TSWNDBEvent(fEvents[i]);
          if Event.fEventID=EventID then
          begin
               Result:=Event;
               break;
          end;
     end;
end;

function TSWNDBEventManager.GetEventTypesInStr: String;
var i:TSWNDBEventType;
begin
     Result:='';
     for i := Low(TSWNDBEventType) to High(TSWNDBEventType) do
     begin
          if i in FEventTypes then
          begin
               if Result<>'' then Result:=Result+',';
               Result:=Result+IntToStr(Ord(i));
          end;
     end;
end;

procedure TSWNDBEventManager.NotifyForNewEvent(const listOfEvents:TList);
begin
     if Assigned(FOnNewEvent) then FOnNewEvent(listOfEvents);
end;

function TSWNDBEventManager.ScanForEvents:Boolean;
var Query:TIBCQuery;
    Event:TSWNDBEvent;
    justAdded:TList;
begin
     justAdded:=TList.Create;
     Query:=TIBCQuery.Create(nil);
     try
        Query.Connection:=fDBConnection;
        Query.SQL.Text:='SELECT * FROM SP_GET_LAST_EVENTS(:DT,:types,:last)';
        Query.ParamByName('DT').AsInteger:=fDT;
        Query.ParamByName('types').AsString:=GetEventTypesInStr;
        if fEvents.Count>0 then
        begin
             Event:=fEvents.Items[fEvents.Count-1];
             Query.ParamByName('last').AsInteger:=Event.fEventID;
        end;
        Query.ExecSQL;
        while(Not Query.Eof) do
        begin
             Event:=TSWNDBEvent.Create;
             Event.fEventID:=Query.FieldByName('EVENTID').AsInteger;
             Event.fDT:=Query.FieldByName('DT').AsInteger;
             Event.fDateTime:=Query.FieldByName('DATETIME').AsDateTime;
             Event.fEventType:=TSWNDBEventType(Query.FieldByName('EVENT_TYPE').AsInteger);
             Event.fMsg:=Query.FieldByName('MESSAGE').AsString;
             Event.fValueInt:=Query.FieldByName('VALUE_INT').AsInteger;
             Event.fUserID:=Query.FieldByName('USERID').AsInteger;
             Event.fUserFullName:=Query.FieldByName('FULL_NAME').AsString;
             // register
             fEvents.Add(Event);
             justAdded.Add(Event);
             // notify
             NotifyForNewEvent(justAdded);

             // next
             Query.Next;
        end;
        Result:=justAdded.Count>0;
     finally
        Query.Free;
        justAdded.Free;
     end;
end;

procedure TSWNDBEventManager.SetEventTypes(const Value: TSWNDBEventTypeSet);
begin
     FEventTypes := Value;
end;

procedure TSWNDBEventManager.SetFirma(const Value: Integer);
begin
     fDT := Value;
end;

procedure TSWNDBEventManager.SetOnNewEvents(const Value: TSWNDBEventOnNewEvent);
begin
     FOnNewEvent:=Value;
end;

procedure TSWNDBEventManager.SetScanInterval(const Value: integer);
begin
     if Value>0 then FScanInterval := Value;
end;

end.
