unit frmUserWorkHoursDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Menus, cxStyles,

  cxGridCustomTableView, cxGridTableView,
  cxGridLevel, cxGrid, ExtCtrls,
  StdCtrls, cxButtons, DialogTitle, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxControls, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox,
  cxDropDownEdit, cxClasses, cxGridCustomView;

type

  TUserWorkHourDay = class
  private
    { Private declarations }
    fWorkStartHour: integer;
    fWorkEndHour: integer;
    fDayIndex: integer;
    fAccessStartHour: integer;
    fAccessEndHour: integer;
    procedure SetDayIndex(const Value: integer);
    procedure SetWorkEndHour(const Value: integer);
    procedure SetWorkStartHour(const Value: integer);
    procedure SetAccessEndHour(const Value: integer);
    procedure SetAccessStartHour(const Value: integer);
  public
    { Public declarations }
    constructor Create; overload;
    constructor Create(const ADayIndex, AWorkStartHour, AWorkEndHour,
      AAccessStartHour, AAccessEndHour: integer); overload;
    property DayIndex: integer read fDayIndex write SetDayIndex;
    property WorkStartHour: integer read fWorkStartHour write SetWorkStartHour;
    property WorkEndHour: integer read fWorkEndHour write SetWorkEndHour;
    property AccessStartHour: integer read fAccessStartHour
      write SetAccessStartHour;
    property AccessEndHour: integer read fAccessEndHour write SetAccessEndHour;
  end;

  TUserWorkWeek = class
  private
    { Private declarations }
    fDays: TList;
    FOnChange: TNotifyEvent;
    fHasChanged: Boolean;
    procedure ClearDayList;
    function GetCount: integer;
    function GetDay(index: integer): TUserWorkHourDay;
    procedure SetOnChange(const Value: TNotifyEvent);
    procedure NotifyOfChange;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

    property HasChanged: Boolean read fHasChanged;
    property Count: integer read GetCount;
    property Day[index: integer]: TUserWorkHourDay read GetDay;

    procedure Clear;

    function GetTotalWorkHours: integer;
    function GetTotalAccessHours: integer;

    function AddDay(const DayIndex: integer; const AccessStartHour, StartHour,
      EndHour, AccessEndHour: integer): TUserWorkHourDay;
    function GetUserWorkHourDayByDay(const DayIndex: integer): TUserWorkHourDay;
    procedure MarkChangePoint;

    property OnChange: TNotifyEvent read FOnChange write SetOnChange;
  end;

  TfrmUserWorkHoursDialog = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    Panel1: TPanel;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    cxGridTable_ENABLED: TcxGridColumn;
    cxGridTable_DAY: TcxGridColumn;
    cxGridTable_HOURSTART: TcxGridColumn;
    cxGridTable_HOUREND: TcxGridColumn;
    Label1: TLabel;
    cxGridTable_ACCESS_START: TcxGridColumn;
    cxGridTable_ACCESS_END: TcxGridColumn;
    procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AStyle: TcxStyle);
  private
    { Private declarations }
    fUserWorkWeek: TUserWorkWeek;
    function CheckHours: Boolean;
    procedure SaveHours;
    procedure DisplayWorkHours;
    procedure CreateDefaultHours;
    procedure CreateDaysOfTheWeek;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent;
      const UserWorkWeek: TUserWorkWeek); reintroduce;
  end;

implementation

uses SWNUtils, SWNConst, DataModuleAdditions;

{$R *.dfm}

function CompareDaysASC(Item1, Item2: Pointer): integer;
var
  Data1, Data2: TUserWorkHourDay;
begin
  Data1 := TUserWorkHourDay(Item1);
  Data2 := TUserWorkHourDay(Item2);
  if Data1.fDayIndex < Data2.fDayIndex then
    Result := -1
  else if Data1.fDayIndex > Data2.fDayIndex then
    Result := 1
  else
    Result := 0;
end;

{ TfrmUserWorkHoursDialog }

function TfrmUserWorkHoursDialog.CheckHours: Boolean;
var
  i: integer;
  ErrorStr: String;
  sh, eh: integer;
begin
  Result := false;
  ErrorStr := '';
  for i := 0 to cxGridTable.DataController.RecordCount - 1 do
  begin
    if cxGridTable.DataController.Values[i, cxGridTable_ENABLED.index]
    then
    begin
      if VarIsNull(cxGridTable.DataController.Values[i, cxGridTable_HOURSTART.
        index]) or VarIsNull(cxGridTable.DataController.Values[i,
        cxGridTable_HOUREND.index]) then
        AddErrorToStr(ErrorStr, cxGridTable.DataController.Values[i,
          cxGridTable_DAY.index] + ': Valori incorecte pentru timp!')
      else
      begin
        sh := cxGridTable.DataController.Values[i, cxGridTable_HOURSTART.index];
        eh := cxGridTable.DataController.Values[i, cxGridTable_HOUREND.index];
        if (sh >= eh) or (eh <= sh) then
          AddErrorToStr(ErrorStr, cxGridTable.DataController.Values[i,
            cxGridTable_DAY.index] + ': Timpul se suprapune!')
      end;
    end;
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text,
      ErrorStr);
end;

constructor TfrmUserWorkHoursDialog.Create(const AOwner: TComponent;
  const UserWorkWeek: TUserWorkWeek);
begin
  inherited Create(AOwner);
  fUserWorkWeek := UserWorkWeek;
end;

procedure TfrmUserWorkHoursDialog.CreateDaysOfTheWeek;
var
  N: integer;
begin
  // Luni
  N := cxGridTable.DataController.AppendRecord;
  cxGridTable.DataController.Values[N, cxGridTable_ENABLED.index] := True;
  cxGridTable.DataController.Values[N, cxGridTable_DAY.index] := 'Luni';
  // Marti
  N := cxGridTable.DataController.AppendRecord;
  cxGridTable.DataController.Values[N, cxGridTable_ENABLED.index] := True;
  cxGridTable.DataController.Values[N, cxGridTable_DAY.index] := 'Marti';
  // Miercuri
  N := cxGridTable.DataController.AppendRecord;
  cxGridTable.DataController.Values[N, cxGridTable_ENABLED.index] := True;
  cxGridTable.DataController.Values[N, cxGridTable_DAY.index] := 'Miercuri';
  // Joi
  N := cxGridTable.DataController.AppendRecord;
  cxGridTable.DataController.Values[N, cxGridTable_ENABLED.index] := True;
  cxGridTable.DataController.Values[N, cxGridTable_DAY.index] := 'Joi';
  // Vineri
  N := cxGridTable.DataController.AppendRecord;
  cxGridTable.DataController.Values[N, cxGridTable_ENABLED.index] := True;
  cxGridTable.DataController.Values[N, cxGridTable_DAY.index] := 'Vineri';
  // Sambata
  N := cxGridTable.DataController.AppendRecord;
  cxGridTable.DataController.Values[N, cxGridTable_ENABLED.index] := True;
  cxGridTable.DataController.Values[N, cxGridTable_DAY.index] := 'Sambata';
  // Duminica
  N := cxGridTable.DataController.AppendRecord;
  cxGridTable.DataController.Values[N, cxGridTable_ENABLED.index] := false;
  cxGridTable.DataController.Values[N, cxGridTable_DAY.index] := 'Duminica';

end;

procedure TfrmUserWorkHoursDialog.CreateDefaultHours;
var
  i: integer;
begin
  for i := 0 to 4 do
  begin
    cxGridTable.DataController.Values[i, cxGridTable_HOURSTART.index] := '9';
    cxGridTable.DataController.Values[i, cxGridTable_HOUREND.index] := '19';
  end;
  // Sambata
  cxGridTable.DataController.Values[5, cxGridTable_HOURSTART.index] := '10';
  cxGridTable.DataController.Values[5, cxGridTable_HOUREND.index] := '17';
  // Duminica
  cxGridTable.DataController.Values[6, cxGridTable_HOURSTART.index] := '10';
  cxGridTable.DataController.Values[6, cxGridTable_HOUREND.index] := '17';

end;

procedure TfrmUserWorkHoursDialog.cxGridTableStylesGetContentStyle
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridTable_ENABLED.index] = false then
    AStyle := dmAdditions.cxStyle_TextGray;
end;

procedure TfrmUserWorkHoursDialog.DisplayWorkHours;
var
  i: integer;
  UserWorkDay: TUserWorkHourDay;
begin
  for i := 0 to cxGridTable.DataController.RecordCount - 1 do
  begin
    UserWorkDay := fUserWorkWeek.GetUserWorkHourDayByDay(i + 1);
    if Assigned(UserWorkDay) then
    begin
      // day exists
      cxGridTable.DataController.Values[i, cxGridTable_ENABLED.index] := True;
      cxGridTable.DataController.Values[i, cxGridTable_HOURSTART.index] :=
        UserWorkDay.fWorkStartHour;
      cxGridTable.DataController.Values[i, cxGridTable_HOUREND.index] :=
        UserWorkDay.fWorkEndHour;
      cxGridTable.DataController.Values[i, cxGridTable_ACCESS_START.index] :=
        UserWorkDay.fAccessStartHour;
      cxGridTable.DataController.Values[i, cxGridTable_ACCESS_END.index] :=
        UserWorkDay.fAccessEndHour;
    end
    else
    begin
      // not exists
      cxGridTable.DataController.Values[i, cxGridTable_ENABLED.index] := false;
      cxGridTable.DataController.Values[i, cxGridTable_HOURSTART.index] := NULL;
      cxGridTable.DataController.Values[i, cxGridTable_HOUREND.index] := NULL;
      cxGridTable.DataController.Values[i, cxGridTable_ACCESS_START.
        index] := NULL;
      cxGridTable.DataController.Values[i, cxGridTable_ACCESS_END.
        index] := NULL;
    end;
  end;
end;

function TfrmUserWorkHoursDialog.IsFormDataPosted: Boolean;
begin
  if CheckHours then
  begin
    SaveHours;
    Result := True;
  end
  else
    Result := false;
end;

procedure TfrmUserWorkHoursDialog.Prepare;
begin
  CreateDaysOfTheWeek;
  if fUserWorkWeek.Count > 0 then
    DisplayWorkHours
  else
    CreateDefaultHours;
end;

procedure TfrmUserWorkHoursDialog.SaveHours;
var
  i: integer;
begin
  fUserWorkWeek.Clear;
  for i := 0 to cxGridTable.DataController.RecordCount - 1 do
  begin
    if cxGridTable.DataController.Values[i, cxGridTable_ENABLED.index]
    then
      fUserWorkWeek.AddDay(i + 1, cxGridTable.DataController.Values[i,
        cxGridTable_ACCESS_START.index], cxGridTable.DataController.Values[i,
        cxGridTable_HOURSTART.index], cxGridTable.DataController.Values[i,
        cxGridTable_HOUREND.index], cxGridTable.DataController.Values[i,
        cxGridTable_ACCESS_END.index]);
  end;
end;

{ TUserWorkHourDay }

constructor TUserWorkHourDay.Create;
begin
  fDayIndex := 1;
  fWorkStartHour := 0;
  fWorkEndHour := 24;
  fAccessStartHour := 0;
  fAccessEndHour := 24;
end;

constructor TUserWorkHourDay.Create(const ADayIndex, AWorkStartHour,
  AWorkEndHour, AAccessStartHour, AAccessEndHour: integer);
begin
  fDayIndex := ADayIndex;
  fWorkStartHour := AWorkStartHour;
  fWorkEndHour := AWorkEndHour;
  fAccessStartHour := AAccessStartHour;
  fAccessEndHour := AAccessEndHour;
end;

procedure TUserWorkHourDay.SetAccessEndHour(const Value: integer);
begin
  if (Value >= 0) and (Value <= 24) then
    fAccessEndHour := Value
  else
    raise Exception.Create('Access End Hour value error!');
end;

procedure TUserWorkHourDay.SetAccessStartHour(const Value: integer);
begin
  if (Value >= 0) and (Value <= 24) then
    fAccessStartHour := Value
  else
    raise Exception.Create('Access Start Hour value error!');
end;

procedure TUserWorkHourDay.SetDayIndex(const Value: integer);
begin
  if (Value >= 1) and (Value <= 7) then
    fDayIndex := Value
  else
    raise Exception.Create('Day index value error!');
end;

procedure TUserWorkHourDay.SetWorkEndHour(const Value: integer);
begin
  if (Value >= 0) and (Value <= 24) then
    fWorkEndHour := Value
  else
    raise Exception.Create('Work End Hour value error!');
end;

procedure TUserWorkHourDay.SetWorkStartHour(const Value: integer);
begin
  if (Value >= 0) and (Value <= 24) then
    fWorkStartHour := Value
  else
    raise Exception.Create('Work Start Hour value error!');
end;

{ TUserWorkWeek }

function TUserWorkWeek.AddDay(const DayIndex, AccessStartHour, StartHour,
  EndHour, AccessEndHour: integer): TUserWorkHourDay;
var
  i: integer;
begin
  // check if day already exists
  for i := 0 to fDays.Count - 1 do
    if TUserWorkHourDay(fDays[i]).fDayIndex = DayIndex then
      raise Exception.Create('Day already exists!');

  // check hours range
  if (StartHour >= EndHour) or (EndHour <= StartHour) then
    raise Exception.Create('Working hours are overlaped!');
  if (AccessStartHour >= AccessEndHour) or (AccessEndHour <= AccessStartHour)
  then
    raise Exception.Create('Access hours are overlaped!');

  // add new day
  Result := TUserWorkHourDay.Create(DayIndex, StartHour, EndHour,
    AccessStartHour, AccessEndHour);
  fDays.Add(Result);
  // sort ascending by DayIndex
  fDays.Sort(CompareDaysASC);

  NotifyOfChange;
end;

procedure TUserWorkWeek.NotifyOfChange;
begin
  fHasChanged := True;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TUserWorkWeek.Clear;
begin
  ClearDayList;
  NotifyOfChange;
end;

procedure TUserWorkWeek.ClearDayList;
var
  i: integer;
begin
  for i := 0 to fDays.Count - 1 do
    TUserWorkHourDay(fDays[i]).Free;
  fDays.Clear;
end;

constructor TUserWorkWeek.Create;
begin
  fDays := TList.Create;
  fHasChanged := false;
end;

destructor TUserWorkWeek.Destroy;
begin
  ClearDayList;
  fDays.Free;
  inherited;
end;

function TUserWorkWeek.GetCount: integer;
begin
  Result := fDays.Count;
end;

function TUserWorkWeek.GetDay(index: integer): TUserWorkHourDay;
begin
  Result := TUserWorkHourDay(fDays[index]);
end;

function TUserWorkWeek.GetTotalAccessHours: integer;
var
  i: integer;
  UWHD: TUserWorkHourDay;
begin
  Result := 0;
  for i := 0 to fDays.Count - 1 do
  begin
    UWHD := TUserWorkHourDay(fDays[i]);
    Inc(Result, UWHD.AccessEndHour - UWHD.AccessStartHour);
  end;
end;

function TUserWorkWeek.GetTotalWorkHours: integer;
var
  i: integer;
  UWHD: TUserWorkHourDay;
begin
  Result := 0;
  for i := 0 to fDays.Count - 1 do
  begin
    UWHD := TUserWorkHourDay(fDays[i]);
    Inc(Result, UWHD.WorkEndHour - UWHD.WorkStartHour);
  end;
end;

function TUserWorkWeek.GetUserWorkHourDayByDay(const DayIndex: integer)
  : TUserWorkHourDay;
var
  i: integer;
  UWHD: TUserWorkHourDay;
begin
  Result := nil;
  for i := 0 to fDays.Count - 1 do
  begin
    UWHD := TUserWorkHourDay(fDays[i]);
    if UWHD.fDayIndex = DayIndex then
    begin
      Result := UWHD;
      break;
    end;
  end;
end;

procedure TUserWorkWeek.MarkChangePoint;
begin
  fHasChanged := false;
end;

procedure TUserWorkWeek.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

end.
