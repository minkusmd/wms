unit SWNClasses;

interface

uses
  System.Classes, Windows, Graphics, System.SysUtils, System.Generics.Collections;

type
 TIntList = class(TList<Integer>)
 end;

type
  TIntegerList = class(TList)
  private
    FOnChange: TNotifyEvent;
  { private declarations }
    function GetItems(Index: integer): integer;
    procedure SetItems(Index: integer; const Value: integer);
    procedure SetOnChange(const Value: TNotifyEvent);
    procedure NotifyChange;
  public
  { public declarations }
    constructor Create;
    procedure Clear; override;
    function Add(const ValueInt: integer): integer;
    property Items[Index: integer]: integer read GetItems write SetItems; default;
    function GetValueList: string;
    procedure CopyValues(const SourceList: TIntegerList);
    property OnChange: TNotifyEvent read FOnChange write SetOnChange;
  end;

implementation

{ TIntegerList }

function TIntegerList.Add(const ValueInt: integer): integer;
var
  n: ^integer;
begin
  New(n);
  n^ := ValueInt;
  Result := inherited Add(n);
  NotifyChange;
end;

procedure TIntegerList.Clear;
var
  i: integer;
  n: ^integer;
begin
  for i := 0 to Count - 1 do begin
    n := inherited Items[i];
    Dispose(n);
  end;
  inherited;
  NotifyChange;
end;

procedure TIntegerList.CopyValues(const SourceList: TIntegerList);
var
  i: integer;
begin
  Clear;
  for i := 0 to SourceList.Count - 1 do
    Add(SourceList.GetItems(i));
end;

constructor TIntegerList.Create;
begin
  inherited Create;
  FOnChange := nil;
end;

function TIntegerList.GetItems(Index: integer): integer;
var
  n: ^integer;
begin
  n := inherited Items[Index];
  Result := n^;
end;

function TIntegerList.GetValueList: string;
var
  i: integer;
  n: ^integer;
begin
  Result := '';
  for i := 0 to Count - 1 do begin
    n := inherited Items[i];
    Result := Result + IntToStr(n^) + ',';
  end;
  if Result <> '' then
    SetLength(Result, Length(Result) - 1);
end;

procedure TIntegerList.NotifyChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TIntegerList.SetItems(Index: integer; const Value: integer);
var
  n: ^integer;
begin
  n := inherited Items[Index];
  n^ := Value;
end;

procedure TIntegerList.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

end.

