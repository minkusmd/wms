unit GoodsDescriptionClasses;

interface
uses Classes;

type

  TGoodsDescriptionItem = class
  private
    { Private declarations }
    fDescriptionID:integer;
    fFilterID:integer;
    fParamID:integer;
    fTitleRom: String;
    fTitleRus: String;
    fValueRom: String;
    fValueRus: String;
    fIsGroup: Boolean;
  public
    { Public declarations }
    constructor Create;

    property DescriptionID:integer read fDescriptionID write fDescriptionID;
    property FilterID:integer read fFilterID write fFilterID;
    property ParamID:integer read fParamID write fParamID;
    property TitleRom:String read fTitleRom write fTitleRom;
    property TitleRus:String read fTitleRus write fTitleRus;
    property ValueRom:String read fValueRom write fValueRom;
    property ValueRus:String read fValueRus write fValueRus;
    property IsGroup:Boolean read fIsGroup write fIsGroup;
  end;


  TGoodsDescriptionCollection = class
  private
    { Private declarations }
    fGoodsID:integer;
    fItems:TList;
    function GetCount: integer;
    function GetItem(index: integer): TGoodsDescriptionItem;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy;override;

    property GoodsID:integer read fGoodsID write fGoodsID;
    property Count:integer read GetCount;
    property Items[index:integer]:TGoodsDescriptionItem read GetItem;default;

    procedure ClearItems;
    function AddItem:TGoodsDescriptionItem;
    procedure OptimizeItems;
  end;


implementation

{ TGoodsDescriptionItem }

constructor TGoodsDescriptionItem.Create;
begin
    fDescriptionID:=0;
    fFilterID:=0;
    fParamID:=0;
    fTitleRom:='';
    fTitleRus:='';
    fValueRus:='';
    fValueRom:='';
    fTitleRus:='';
    fIsGroup:=false;
end;

{ TGoodsDescriptionCollection }

function TGoodsDescriptionCollection.AddItem: TGoodsDescriptionItem;
begin
     Result:=TGoodsDescriptionItem.Create;
     fItems.Add(Result);
end;

procedure TGoodsDescriptionCollection.ClearItems;
var i:integer;
begin
     for i := 0 to fItems.Count - 1 do TGoodsDescriptionItem(fItems[i]).Free;
     fItems.Clear;
end;

constructor TGoodsDescriptionCollection.Create;
begin
     fItems:=TList.Create;
end;

destructor TGoodsDescriptionCollection.Destroy;
begin
     ClearItems;
     fItems.Free;
     inherited;
end;

function TGoodsDescriptionCollection.GetCount: integer;
begin
     Result:=fItems.Count;
end;

function TGoodsDescriptionCollection.GetItem(index: integer): TGoodsDescriptionItem;
begin
     Result:=TGoodsDescriptionItem(fItems[Index]);
end;

procedure TGoodsDescriptionCollection.OptimizeItems;
var i,j:integer;
    item1,item2:TGoodsDescriptionItem;
    s:String;
    changed:Boolean;
begin
     i:=0;
     while(i<fItems.Count-1) do
     begin
          item1:=TGoodsDescriptionItem(fItems[i]);

          repeat
                j:=i+1;
                changed:=false;
                while(j<fItems.Count) do
                begin
                     item2:=TGoodsDescriptionItem(fItems[j]);
                     if (item2.fFilterID=item1.fFilterID) then
                     begin
                          // join values items
                          s:=item1.fValueRus;
                          if (s<>'') then s:=s+', ';
                          s:=s+item2.fValueRus;
                          item1.fValueRus:=s;

                          // delete item
                          fItems.Delete(j);
                          item2.Free;
                          changed:=true;
                          break;
                     end;
                     inc(j);
                end;
          until Not changed;
          inc(i);
     end;
end;

end.
