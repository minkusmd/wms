unit SWNSNClasses;
{
 Numere de serie
}

interface
Uses Classes;

type

  TSNStatus = (snstNew,snstInUse,snstInUseDeleted,snstInUseNew,snstInUseUpdate);
  TSNStatusSet = set of TSNStatus;

  TSWNSNItem=class
  private
    { Private declarations }
    fStatus: TSNStatus;
    fSN: String;
    fComplect_SN: Variant;
    fComplect_SN_Initial: Variant;
    FCountryID: integer;
    FVendorID: integer;
    FUserID: integer;
    FUserName: String;
    procedure SetStatus(const Value: TSNStatus);
    procedure SetComplect_SN(const Value: Variant);
    procedure SetCountryID(const Value: integer);
    procedure SetVendorID(const Value: integer);
    procedure SetUserID(const Value: integer);
    procedure SetUserName(const Value: String);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(const ASN:String); overload;
    constructor Create(const ASN:String; const CountryID,VendorID:integer); overload;
    constructor Create(const ASN:String; const CountryID,VendorID:integer; const AComplect_SN:String); overload;

    property SN:String read fSN;
    property Status:TSNStatus read fStatus write SetStatus;
    property Complect_SN:Variant read fComplect_SN write SetComplect_SN;
    property Complect_SN_Initial:Variant read fComplect_SN_Initial;
    property CountryID:integer read FCountryID write SetCountryID;
    property VendorID:integer read FVendorID write SetVendorID;
    property UserID:integer read FUserID write SetUserID;
    property UserName:String read FUserName write SetUserName;
  end;


  TSWNSNList = class
  private
    { Private declarations }
    function GetItems(Index: Integer): TSWNSNItem;
    function getCount: integer;
  protected
    { Protected declarations }
    fList:TList;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy;override;

    property Count:integer read getCount;
    property Items [Index: Integer]: TSWNSNItem read GetItems; default;

    procedure Clear;
    function Add(const SN: String): TSWNSNItem; overload;
    function Add(const SN: String; const CountryID,VendorID:integer): TSWNSNItem; overload;
    function Add(const SN: String; const CountryID,VendorID:integer; const CustomStatus:TSNStatus): TSWNSNItem; overload;
    function Add(const SN: String; const CountryID,VendorID:integer; const CustomStatus:TSNStatus; const AComplect_SN:String): TSWNSNItem; overload;

    function Remove(const SNItem: TSWNSNItem): Integer;
    procedure Delete(const Index:Integer);
    function Find(const SN:String):TSWNSNItem;
    function Find2(const SN:String; const StatusList:TSNStatusSet):TSWNSNItem;

    function HasItemsOfStatus(const LookupStatus:TSNStatus):Boolean;
  end;



implementation
Uses Variants;

{ TSNItem }

constructor TSWNSNItem.Create(const ASN: String; const CountryID, VendorID:integer);
begin
     fSN:=ASN;
     fStatus:=snstNew;
     fComplect_SN:=null;
     fComplect_SN_Initial:=null;
     FCountryID:=CountryID;
     FVendorID:=VendorID;
     FUserID:=0;
     FUserName:='';
end;

constructor TSWNSNItem.Create(const ASN:String; const CountryID,VendorID:integer; const AComplect_SN: String);
begin
     fSN:=ASN;
     fStatus:=snstNew;
     fComplect_SN:=AComplect_SN;
     fComplect_SN_Initial:=AComplect_SN;
     FCountryID:=CountryID;
     FVendorID:=VendorID;
     FUserID:=0;
     FUserName:='';
end;

constructor TSWNSNItem.Create(const ASN: String);
begin
     fSN:=ASN;
     fStatus:=snstNew;
     fComplect_SN:=null;
     fComplect_SN_Initial:=null;
     FCountryID:=-1;
     FVendorID:=-1;
     FUserID:=0;
     FUserName:='';
end;

procedure TSWNSNItem.SetComplect_SN(const Value: Variant);
begin
     fComplect_SN := Value;
end;

procedure TSWNSNItem.SetCountryID(const Value: integer);
begin
  FCountryID := Value;
end;

procedure TSWNSNItem.SetStatus(const Value: TSNStatus);
begin
     fStatus := Value;
end;

procedure TSWNSNItem.SetUserID(const Value: integer);
begin
  FUserID := Value;
end;

procedure TSWNSNItem.SetUserName(const Value: String);
begin
  FUserName := Value;
end;

procedure TSWNSNItem.SetVendorID(const Value: integer);
begin
  FVendorID := Value;
end;

{ TSWNSNList }

function TSWNSNList.Add(const SN:String; const CountryID,VendorID:integer): TSWNSNItem;
begin
     Result:=TSWNSNItem.Create(SN,CountryID,VendorID);
     fList.Add(Result);
end;

function TSWNSNList.Add(const SN:String; const CountryID,VendorID:integer; const CustomStatus: TSNStatus): TSWNSNItem;
begin
     Result:=TSWNSNItem.Create(SN,CountryID,VendorID);
     Result.Status:=CustomStatus;
     fList.Add(Result);
end;

function TSWNSNList.Add(const SN: String; const CountryID,VendorID:integer; const CustomStatus: TSNStatus; const AComplect_SN: String): TSWNSNItem;
begin
     Result:=TSWNSNItem.Create(SN,CountryID,VendorID,AComplect_SN);
     Result.Status:=CustomStatus;
     fList.Add(Result);
end;

function TSWNSNList.Add(const SN: String): TSWNSNItem;
begin
     Result:=TSWNSNItem.Create(SN);
     fList.Add(Result);
end;

procedure TSWNSNList.Clear;
var i:integer;
    Item:TSWNSNItem;
begin
     for i := 0 to fList.Count - 1 do
     begin
          Item:=TSWNSNItem(fList[i]);
          Item.Free;
     end;
     fList.Clear;
end;

constructor TSWNSNList.Create;
begin
     fList:=TList.Create;
end;

procedure TSWNSNList.Delete(const Index: Integer);
begin
     fList.Delete(Index);
end;

destructor TSWNSNList.Destroy;
begin
     Clear;
     fList.Free;
     inherited;
end;

function TSWNSNList.Find(const SN: String): TSWNSNItem;
var i:integer;
    SNItem:TSWNSNItem;
begin
     Result:=nil;
     for i := 0 to fList.Count - 1 do
     begin
          SNItem:=TSWNSNItem(fList[i]);
          if SNItem.fSN=SN then
          begin
               Result:=SNItem;
               break;
          end;
     end;
end;

function TSWNSNList.Find2(const SN: String; const StatusList: TSNStatusSet): TSWNSNItem;
var i:integer;
    SNItem:TSWNSNItem;
begin
     Result:=nil;
     for i := 0 to fList.Count - 1 do
     begin
          SNItem:=TSWNSNItem(fList[i]);
          if (SNItem.fSN=SN) and (SNItem.fStatus in StatusList) then
          begin
               Result:=SNItem;
               break;
          end;
     end;
end;

function TSWNSNList.getCount: integer;
begin
     Result:=fList.Count;
end;

function TSWNSNList.GetItems(Index: Integer): TSWNSNItem;
begin
     Result:=TSWNSNItem(fList[Index]);
end;

function TSWNSNList.HasItemsOfStatus(const LookupStatus: TSNStatus): Boolean;
var i:integer;
    SNItem:TSWNSNItem;
begin
     Result:=False;
     for i := 0 to fList.Count - 1 do
     begin
          SNItem:=TSWNSNItem(fList[i]);
          if SNItem.fStatus=LookupStatus then
          begin
               Result:=True;
               break;
          end;
     end;
end;

function TSWNSNList.Remove(const SNItem: TSWNSNItem): Integer;
begin
     Result:=fList.Remove(SNItem);
end;

end.
