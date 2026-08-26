unit MailCIDListClass;

interface
Uses Classes;

type

  TImageCIDItem = class
  private
    FFileName: string;
    FCID: string;
    procedure SetCID(const Value: string);
    procedure SetFileName(const Value: string);
  public
    { public declarations }
    property CID:string read FCID write SetCID;
    property FileName:string read FFileName write SetFileName;
  end;

  TImagesCIDList = class
  private
    fList:TList;
    function GetItem(index: integer): TImageCIDItem;
    function GetCount: integer;
  public
    { public declarations }
    constructor Create;
    destructor Destroy;override;

    property Items[index:integer]:TImageCIDItem read GetItem;
    property Count:integer read GetCount;

    procedure Clear;
    function RegisterFileName(const FileName:String):TImageCIDItem;
  end;


implementation
Uses SysUtils;

{ TImageCIDItem }

procedure TImageCIDItem.SetCID(const Value: string);
begin
     FCID := Value;
end;

procedure TImageCIDItem.SetFileName(const Value: string);
begin
     FFileName := Value;
end;

{ TImagesCIDList }

procedure TImagesCIDList.Clear;
var i:integer;
begin
     for i := 0 to fList.Count - 1 do TImageCIDItem(fList[i]).Free;
     fList.Clear;
end;

constructor TImagesCIDList.Create;
begin
     fList:=TList.Create;
end;

destructor TImagesCIDList.Destroy;
begin
     Clear;
     fList.Free;
     inherited;
end;

function TImagesCIDList.GetCount: integer;
begin
     Result:=fList.Count;
end;

function TImagesCIDList.GetItem(index: integer): TImageCIDItem;
begin
     Result:=TImageCIDItem(fList[Index]);
end;

function TImagesCIDList.RegisterFileName(const FileName: String): TImageCIDItem;
begin
     Result:=TImageCIDItem.Create;
     Result.FFileName:=FileName;
     Result.CID:=Format('cid:image%2.2d',[fList.Count]);
     fList.Add(Result);
end;

end.
