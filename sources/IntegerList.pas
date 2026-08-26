unit IntegerList;

interface

uses
  Classes;

type
  TIntegerList = class;

  TIntegerListSortCompare = function(List: TIntegerList; Index1, Index2: Integer): Integer;

  TIntegerList = class(TObject)
  private
    FList: TList;
    FDuplicates: TDuplicates;
    FSorted: Boolean;
    function GetItems(Index: Integer): Integer;
    procedure SetItems(Index: Integer; const Value: Integer);
    function GetCapacity: Integer;
    function GetCount: Integer;
    procedure SetCapacity(const Value: Integer);
    procedure SetCount(const Value: Integer);
    procedure SetSorted(const Value: Boolean);
  protected
    procedure Sort; virtual;
    procedure QuickSort(L, R: Integer; SCompare: TIntegerListSortCompare);
  public
    constructor Create;
    destructor Destroy; override;
    function Add(Item: Integer): Integer;
    procedure Insert(Index, Item: Integer);
    function First(): Integer;
    function Last(): Integer;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Find(aValue: Integer; var Index: Integer): Boolean; virtual;
    procedure Exchange(Index1, Index2: Integer);
    procedure Move(CurIndex, NewIndex: Integer);
    procedure Pack;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount write SetCount;
    property Duplicates: TDuplicates read FDuplicates write FDuplicates;
    property Items[Index: Integer]: Integer read GetItems write SetItems; default;
    property Sorted: Boolean read FSorted write SetSorted;
  end;
(*============================================================================*)
(*                           IMPLEMENTATION                                   *)
(*============================================================================*)

implementation
{ TIntegerList }

function IntegerListCompare(List: TIntegerList; Index1, Index2: Integer): Integer;
begin
  if (List[Index1] < List[Index2]) then
    Result := -1
  else if (List[Index1] > List[Index2]) then
    Result := 1
  else
    Result := 0;
end;

function TIntegerList.Add(Item: Integer): Integer;
begin
  if not Sorted then
    Result := FList.Add(Pointer(Item))
  else if Find(Item, Result) then
    case Duplicates of
      dupIgnore:
        Exit;
//        dupError  : Error(@SDuplicateString, 0);
      dupError:
        Exit;
    end;
  Insert(Result, Item);
end;

procedure TIntegerList.Clear;
begin
  FList.Clear;
end;

constructor TIntegerList.Create;
begin
  inherited;
  FList := TList.Create;
end;

procedure TIntegerList.Delete(Index: Integer);
begin
  FList.Delete(Index);
end;

destructor TIntegerList.Destroy;
begin
  FList.Free;
  inherited;
end;

procedure TIntegerList.Exchange(Index1, Index2: Integer);
begin
  FList.Exchange(Index1, Index2);
end;

function TIntegerList.Find(aValue: Integer; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;

  function IntegerCompare(aValue1, aValue2: Integer): Integer;
  begin
    if (aValue1 < aValue2) then
      Result := -1
    else if (aValue1 > aValue2) then
      Result := 1
    else
      Result := 0;
  end;

begin
  Result := False;
  L := 0;
  H := FList.Count - 1;
  while (L <= H) do begin
    I := (L + H) shr 1;
    C := IntegerCompare(Items[I], aValue);
    if (C < 0) then
      L := I + 1
    else begin
      H := I - 1;
      if (C = 0) then begin
        Result := True;
        if (Duplicates <> dupAccept) then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

function TIntegerList.First(): Integer;
begin
  Result := Integer(FList.First());
end;

function TIntegerList.GetCapacity(): Integer;
begin
  Result := FList.Capacity;
end;

function TIntegerList.GetCount(): Integer;
begin
  Result := FList.Count;
end;

function TIntegerList.GetItems(Index: Integer): Integer;
begin
  Result := Integer(FList.Items[Index]);
end;

procedure TIntegerList.Insert(Index, Item: Integer);
begin
  FList.Insert(Index, Pointer(Item));
end;

function TIntegerList.Last(): Integer;
begin
  Result := Integer(FList.Last());
end;

procedure TIntegerList.Move(CurIndex, NewIndex: Integer);
begin
  FList.Move(CurIndex, NewIndex);
end;

procedure TIntegerList.Pack;
begin
  FList.Pack;
end;

procedure TIntegerList.QuickSort(L, R: Integer; SCompare: TIntegerListSortCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while (SCompare(Self, I, P) < 0) do
        Inc(I);
      while (SCompare(Self, J, P) > 0) do
        Dec(J);
      if (I <= J) then begin
        Exchange(I, J);
        if (P = I) then
          P := J
        else if (P = J) then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until (I > J);
    if (L < J) then
      QuickSort(L, J, SCompare);
    L := I;
  until (I >= R);
end;

procedure TIntegerList.SetCapacity(const Value: Integer);
begin
  FList.Capacity := Value;
end;

procedure TIntegerList.SetCount(const Value: Integer);
begin
  FList.Count := Value;
end;

procedure TIntegerList.SetItems(Index: Integer; const Value: Integer);
begin
  FList.Items[Index] := Pointer(Value);
end;

procedure TIntegerList.SetSorted(const Value: Boolean);
begin
  if (FSorted <> Value) then begin
    if Value then
      Sort;
    FSorted := Value;
  end;
end;

procedure TIntegerList.Sort;
begin
  if not Sorted and (FList.Count > 1) then begin
//    Changing;
    QuickSort(0, FList.Count - 1, IntegerListCompare);
//    Changed;
  end;
end;

end.

