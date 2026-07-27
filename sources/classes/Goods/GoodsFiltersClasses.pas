unit GoodsFiltersClasses;

interface
uses Classes;

type

  TGoodsFilterParam = class
  private
    { Private declarations }
    fFilterParamID:integer;
    fFilterValue:String;
    fGoodsCount:integer;
    fMinValue:integer;
    fMaxValue:integer;
    fRangeValues:Boolean;
  public
    { Public declarations }
    constructor Create(const FilterParamID:integer; const FilterValue:String; const GoodsCount:integer);reintroduce;overload;
    constructor Create(const FilterParamID:integer; const FilterValue:String; const MinValue, MaxValue, GoodsCount:integer);reintroduce;overload;

    property FilterParamID:integer read fFilterParamID;
    property FilterValue:String read fFilterValue;
    property GoodsCount:integer read fGoodsCount;
    property MinValue:integer read fMinValue;
    property MaxValue:integer read fMaxValue;
    property RangeValues:Boolean read fRangeValues;

    procedure SetFilterValue(const Title:String);
  end;


  TGoodsFilterGroup = class
  private
    { Private declarations }
    fFilterID:integer;
    fFilterName:String;
    fIsOpened:Boolean;
    fList:TList;
    function GetHasItems: Boolean;
    function GetCount: integer;
    function GetFilterParams(index: integer): TGoodsFilterParam;

  public
    { Public declarations }
    constructor Create(const FilterID:integer; const FilterName:String; const IsOpened:Boolean);reintroduce;
    destructor Destroy;override;

    property FilterID:integer read fFilterID;
    property FilterName:String read fFilterName;
    property isOpened:Boolean read fIsOpened;

    property HasItems:Boolean read GetHasItems;
    property Count:integer read GetCount;
    property FilterParams[index:integer]:TGoodsFilterParam read GetFilterParams; default;

    procedure Clear;
    function AddFilterParam(const FilterParamID:integer; const FilterValue:String; const GoodsCount:integer):TGoodsFilterParam; overload;
    function AddFilterParam(const FilterParamID:integer; const FilterValue:String; const MinValue, MaxValue, GoodsCount:integer):TGoodsFilterParam; overload;

  end;


  TGoodsFilterCollection = class
  private
    { Private declarations }
    fGoodsParentID:integer;
    fList:TList;
    function GetCount: integer;
    function GetGroup(index: integer): TGoodsFilterGroup;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy;override;

    property GoodsParentID:integer read fGoodsParentID write fGoodsParentID;
    property Count:integer read GetCount;
    property Groups[index:integer]:TGoodsFilterGroup read GetGroup; default;

    procedure Clear;
    function AddFilterGroup(const FilterID:integer; const FilterName:String; const IsOpened:Boolean):TGoodsFilterGroup;
  end;



implementation

{ TGoodsFilterParam }

constructor TGoodsFilterParam.Create(const FilterParamID: integer; const FilterValue: String; const GoodsCount: integer);
begin
     inherited Create;
     fFilterParamID := FilterParamID;
     fFilterValue := FilterValue;
     fGoodsCount := GoodsCount;
     fMinValue:=0;
     fMaxvalue:=0;
     fRangeValues:=false;
end;

constructor TGoodsFilterParam.Create(const FilterParamID: integer; const FilterValue: String; const MinValue,MaxValue, GoodsCount: integer);
begin
     inherited Create;
     fFilterParamID := FilterParamID;
     fFilterValue := FilterValue;
     fGoodsCount := GoodsCount;
     fMinValue:=MinValue;
     fMaxValue:=MaxValue;
     fRangeValues:=True;
end;

procedure TGoodsFilterParam.SetFilterValue(const Title: String);
begin
     fFilterValue:=Title;
end;

{ TGoodsFilterGroup }

function TGoodsFilterGroup.AddFilterParam(const FilterParamID: integer; const FilterValue: String; const GoodsCount: integer): TGoodsFilterParam;
begin
     Result:=TGoodsFilterParam.Create(FilterParamID,FilterValue,GoodsCount);
     fList.Add(Result);
end;

function TGoodsFilterGroup.AddFilterParam(const FilterParamID: integer; const FilterValue: String;
  const MinValue, MaxValue, GoodsCount: integer): TGoodsFilterParam;
begin
     Result:=TGoodsFilterParam.Create(FilterParamID, FilterValue, MinValue, MaxValue, GoodsCount);
     fList.Add(Result);
end;

procedure TGoodsFilterGroup.Clear;
var i:integer;
    item:TGoodsFilterParam;
begin
     for i := 0 to fList.Count - 1 do
     begin
          item:=TGoodsFilterParam(fList[i]);
          item.Free;
     end;
     fList.Clear;
end;

constructor TGoodsFilterGroup.Create(const FilterID: integer; const FilterName: String; const IsOpened:Boolean);
begin
     inherited Create;
     fList:=TList.Create;
     fFilterID := FilterID;
     fFilterName := FilterName;
     fIsOpened := IsOpened;
end;

destructor TGoodsFilterGroup.Destroy;
begin
     Clear;
     fList.Clear;
     inherited;
end;

function TGoodsFilterGroup.GetCount: integer;
begin
     Result:=fList.Count;
end;

function TGoodsFilterGroup.GetFilterParams(index: integer): TGoodsFilterParam;
begin
     Result:=TGoodsFilterParam(fList[Index]);
end;

function TGoodsFilterGroup.GetHasItems: Boolean;
begin
     Result:=fList.Count>0;
end;

{ TGoodsFilterCollection }

function TGoodsFilterCollection.AddFilterGroup(const FilterID: integer; const FilterName: String; const IsOpened:Boolean): TGoodsFilterGroup;
begin
     Result:=TGoodsFilterGroup.Create(FilterID,FilterName,IsOpened);
     fList.Add(Result);
end;

procedure TGoodsFilterCollection.Clear;
var i:integer;
    group:TGoodsFilterGroup;
begin
     for i := 0 to fList.Count - 1 do
     begin
          group:=TGoodsFilterGroup(fList[i]);
          group.Free;
     end;
     fList.Clear;
end;

constructor TGoodsFilterCollection.Create;
begin
     fGoodsParentID:=-1;
     fList:=Tlist.Create;
end;

destructor TGoodsFilterCollection.Destroy;
begin
     Clear;
     fList.Free;
     inherited;
end;

function TGoodsFilterCollection.GetCount: integer;
begin
     Result:=fList.Count;
end;

function TGoodsFilterCollection.GetGroup(index: integer): TGoodsFilterGroup;
begin
     Result:=TGoodsFilterGroup(fList[index]);
end;

end.
