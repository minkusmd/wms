unit SWNPNClasses;
{
 Numere de lot
}

interface

uses
   Classes, Variants, System.Types;

type
   TPNStatus = (pnstNew, pnstDeleted, pnstInUse, pnstInUseDeleted, pnstInUseUpdate);

   TSWNPartNoItem = class
   private
    { Private declarations }
      fStatus: TPNStatus;
      fPartNO: string;
      fComplect_SN: Variant;
      fQTY: double;
      fQTY_Initial: double;
      fComplect_SN_Initial: Variant;
      FCountryID: integer;
      FVendorID: integer;
      FUserName: string;
      procedure SetStatus(const Value: TPNStatus);
      procedure SetQTY(const Value: double);
      procedure SetComplect_SN(const Value: Variant);
      procedure SetCountryID(const Value: integer);
      procedure SetVendorID(const Value: integer);
      procedure SetUserName(const Value: string);
   protected
    { Protected declarations }
   public
    { Public declarations }
      constructor Create(const APartNO: string; const AQTY: double); overload;
      constructor Create(const APartNO: string; const AQTY: double; const CountryID, VendorID: Integer; const
         UserName: string); overload;
      constructor Create(const APartNO, AComplect_SN: string; const AQTY: double; const CountryID, VendorID:
         Integer; const UserName: string); overload;
      property PartNO: string read fPartNO;
      property QTY: double read fQTY write SetQTY;
      property QTY_initial: double read fQTY_Initial;
      property Status: TPNStatus read fStatus write SetStatus;
      property Complect_SN: Variant read fComplect_SN write SetComplect_SN;
      property Complect_SN_Initial: Variant read fComplect_SN_Initial;
      property CountryID: integer read FCountryID write SetCountryID;
      property VendorID: integer read FVendorID write SetVendorID;
      property UserName: string read FUserName write SetUserName;
   end;

   TSWNPartNoList = class
   private
      function getCount: integer;
      function GetItems(Index: Integer): TSWNPartNoItem;
    { Private declarations }
   protected
    { Protected declarations }
      fList: TList;
   public
    { Public declarations }
      constructor Create;
      destructor Destroy; override;
      property Count: integer read getCount;
      property Items[Index: Integer]: TSWNPartNoItem read GetItems; default;
      procedure Clear;
      function Add(const PartNo: string; const QTY: double): TSWNPartNoItem; overload;
      function Add(const PartNo: string; const QTY: double; const CountryID, VendorID: Integer; const UserName:
         string): TSWNPartNoItem; overload;
      function Add(const PartNo, Complect_SN: string; const QTY: double; const CountryID, VendorID: Integer;
         const UserName: string): TSWNPartNoItem; overload;
      function Remove(const PartNoItem: TSWNPartNoItem): Integer;
      procedure Delete(const Index: Integer);
      function Find(const PartNo: string; const Complect_SN: Variant): TSWNPartNoItem;
      function HasItemsOfStatus(const LookupStatus: TPNStatus): Boolean;
   end;

implementation

{ TSWNPNItem }

constructor TSWNPartNoItem.Create(const APartNO: string; const AQTY: double; const CountryID, VendorID:
   Integer; const UserName: string);
begin
   fPartNO := APartNO;
   fQTY := AQTY;
   fQTY_Initial := AQTY;
   fStatus := pnstNew;
   fComplect_SN := null;
   fComplect_SN_Initial := null;
   FCountryID := CountryID;
   FVendorID := VendorID;
   FUserName := UserName;
end;

constructor TSWNPartNoItem.Create(const APartNO, AComplect_SN: string; const AQTY: double; const CountryID,
   VendorID: Integer; const UserName: string);
begin
   fPartNO := APartNO;
   fQTY := AQTY;
   fQTY_Initial := AQTY;
   fStatus := pnstNew;
   fComplect_SN := AComplect_SN;
   fComplect_SN_Initial := AComplect_SN;
   FCountryID := CountryID;
   FVendorID := VendorID;
   FUserName := UserName;
end;

constructor TSWNPartNoItem.Create(const APartNO: string; const AQTY: double);
begin
   fPartNO := APartNO;
   fQTY := AQTY;
   fQTY_Initial := AQTY;
   fStatus := pnstNew;
   fComplect_SN := null;
   fComplect_SN_Initial := null;
   FCountryID := -1;
   FVendorID := -1;
   FUserName := '';
end;

procedure TSWNPartNoItem.SetComplect_SN(const Value: Variant);
begin
   fComplect_SN := Value;
end;

procedure TSWNPartNoItem.SetCountryID(const Value: integer);
begin
   FCountryID := Value;
end;

procedure TSWNPartNoItem.SetQTY(const Value: double);
begin
   fQTY := Value;
end;

procedure TSWNPartNoItem.SetStatus(const Value: TPNStatus);
begin
   fStatus := Value;
end;

procedure TSWNPartNoItem.SetUserName(const Value: string);
begin
   FUserName := Value;
end;

procedure TSWNPartNoItem.SetVendorID(const Value: integer);
begin
   FVendorID := Value;
end;

{ TSWNPartNoList }

function TSWNPartNoList.Add(const PartNo: string; const QTY: double; const CountryID, VendorID: Integer; const
   UserName: string): TSWNPartNoItem;
begin
   Result := TSWNPartNoItem.Create(PartNo, QTY, CountryID, VendorID, UserName);
   fList.Add(Result);
end;

function TSWNPartNoList.Add(const PartNo, Complect_SN: string; const QTY: double; const CountryID, VendorID:
   Integer; const UserName: string): TSWNPartNoItem;
begin
   Result := TSWNPartNoItem.Create(PartNo, Complect_SN, QTY, CountryID, VendorID, UserName);
   fList.Add(Result);
end;

function TSWNPartNoList.Add(const PartNo: string; const QTY: double): TSWNPartNoItem;
begin
   Result := TSWNPartNoItem.Create(PartNo, QTY);
   fList.Add(Result);
end;

procedure TSWNPartNoList.Clear;
var
   i: integer;
   PartNoItem: TSWNPartNoItem;
begin
   for i := 0 to fList.Count - 1 do
   begin
      PartNoItem := TSWNPartNoItem(fList[i]);
      PartNoItem.Free;
   end;
   fList.Clear;
end;

constructor TSWNPartNoList.Create;
begin
   fList := Tlist.Create;
end;

procedure TSWNPartNoList.Delete(const Index: Integer);
begin
   fList.Delete(Index);
end;

destructor TSWNPartNoList.Destroy;
begin
   Clear;
   fList.Free;
   inherited;
end;

function TSWNPartNoList.Find(const PartNo: string; const Complect_SN: Variant): TSWNPartNoItem;
var
   i: integer;
   PartNoItem: TSWNPartNoItem;
begin
   Result := nil;
   for i := 0 to fList.Count - 1 do
   begin
      PartNoItem := TSWNPartNoItem(fList[i]);
      if (PartNoItem.fPartNO = PartNo) and (PartNoItem.fComplect_SN = Complect_SN) then
      begin
         Result := PartNoItem;
         break;
      end;
   end;
end;

function TSWNPartNoList.getCount: integer;
begin
   Result := fList.Count;
end;

function TSWNPartNoList.GetItems(Index: Integer): TSWNPartNoItem;
begin
   Result := TSWNPartNoItem(fList[Index]);
end;

function TSWNPartNoList.HasItemsOfStatus(const LookupStatus: TPNStatus): Boolean;
var
   i: integer;
   PartNoItem: TSWNPartNoItem;
begin
   Result := False;
   for i := 0 to fList.Count - 1 do
   begin
      PartNoItem := TSWNPartNoItem(fList[i]);
      if PartNoItem.fStatus = LookupStatus then
      begin
         Result := True;
         break;
      end;
   end;
end;

function TSWNPartNoList.Remove(const PartNoItem: TSWNPartNoItem): Integer;
begin
   Result := fList.Remove(PartNoItem);
end;

end.

