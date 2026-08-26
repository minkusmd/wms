unit SWNIDList;

interface
Uses Classes;

type

  TSWNIDListItemClass = class
  private
    { private declarations }
    fID: integer;
    fData: pointer;
    FModified: Boolean;
    FIsNew: Boolean;
    procedure SetModified(const Value: Boolean);
    procedure SetIsNew(const Value: Boolean);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const inID:integer; const inData:pointer);
    destructor Destroy;override;

    property ID:integer read fID;
    property Data:pointer read fData write fData;
    property Modified:Boolean read FModified write SetModified;
    property IsNew:Boolean read FIsNew write SetIsNew;
  end;


  TSWNIDListClass = class
  private
    { private declarations }
    function getCount: integer;
    function getItem(index: integer): TSWNIDListItemClass;
    function getCountDeleted: integer;
    function getItemDeleted(index: integer): TSWNIDListItemClass;
    function getCountModified: integer;
    function getCountNew: integer;
  protected
    { protected declarations }
    fList:TList;
    fDeletedList:TList;
    procedure ClearList(const List:TList);
  public
    { public declarations }
    constructor Create;
    destructor Destroy;override;

    property Count:integer read getCount;
    property Items[index:integer]:TSWNIDListItemClass read getItem;

    property CountDeleted:integer read getCountDeleted;
    property ItemsDeleted[index:integer]:TSWNIDListItemClass read getItemDeleted;

    property CountModified:integer read getCountModified;
    property CountNew:integer read getCountNew;

    procedure ClearIsNewFlag;
    function AddItem(const ID:integer; const Data:pointer):TSWNIDListItemClass;
    procedure MarkAsDelete(const Item:TSWNIDListItemClass);
  end;

implementation
Uses SysUtils;

{ TSWNIDListClass }

function TSWNIDListClass.AddItem(const ID: integer; const Data:pointer): TSWNIDListItemClass;
var item:TSWNIDListItemClass;
begin
     item:=TSWNIDListItemClass.Create(ID,Data);
     fList.Add(item);
     Result:=Item;
end;

procedure TSWNIDListClass.ClearIsNewFlag;
var i:integer;
    item:TSWNIDListItemClass;
begin
     for i := 0 to fList.Count - 1 do
     begin
          item:=TSWNIDListItemClass(fList[i]);
          item.FIsNew:=False;
     end;
end;

procedure TSWNIDListClass.ClearList(const List:TList);
var i:integer;
    item:TSWNIDListItemClass;
begin
     for i := 0 to List.Count - 1 do
     begin
          item:=TSWNIDListItemClass(List[i]);
          item.Free;
     end;
     List.Clear;
end;

constructor TSWNIDListClass.Create;
begin
     fList:=TList.Create;
     fDeletedList:=TList.Create;
end;

destructor TSWNIDListClass.Destroy;
begin
     ClearList(fList);
     ClearList(fDeletedList);
     fList.Free;
     fDeletedList.Free;
     inherited;
end;

function TSWNIDListClass.getCount: integer;
begin
     Result:=fList.Count;
end;

function TSWNIDListClass.getCountDeleted: integer;
begin
     Result:=fDeletedList.Count;
end;

function TSWNIDListClass.getCountModified: integer;
var i:integer;
    item:TSWNIDListItemClass;
begin
     Result:=0;
     for i := 0 to fList.Count - 1 do
     begin
          item:=TSWNIDListItemClass(fList[i]);
          if item.FModified then Inc(Result);
     end;
end;

function TSWNIDListClass.getCountNew: integer;
var i:integer;
    item:TSWNIDListItemClass;
begin
     Result:=0;
     for i := 0 to fList.Count - 1 do
     begin
          item:=TSWNIDListItemClass(fList[i]);
          if item.FIsNew then Inc(Result);
     end;
end;

function TSWNIDListClass.getItem(index: integer): TSWNIDListItemClass;
begin
     Result:=TSWNIDListItemClass(fList[index]);
end;

function TSWNIDListClass.getItemDeleted(index: integer): TSWNIDListItemClass;
begin
     Result:=TSWNIDListItemClass(fDeletedList[index]);
end;

procedure TSWNIDListClass.MarkAsDelete(const Item: TSWNIDListItemClass);
var N:integer;
begin
     N:=fList.IndexOf(Item);
     if N>=0 then
     begin
          fDeletedList.Add(Item);
          fList.Delete(N);
     end
     else raise Exception.Create('Item is not owned!');
end;

{ TSWNIDListItemClass }

constructor TSWNIDListItemClass.Create(const inID: integer; const inData:pointer);
begin
     fID:=inID;
     fData:=inData;
     FModified := False;
     FIsNew := True;
end;

destructor TSWNIDListItemClass.Destroy;
begin
     if Assigned(fData) then Dispose(fData);
     inherited;
end;

procedure TSWNIDListItemClass.SetIsNew(const Value: Boolean);
begin
     FIsNew := Value;
end;

procedure TSWNIDListItemClass.SetModified(const Value: Boolean);
begin
     FModified := Value;
end;

end.
