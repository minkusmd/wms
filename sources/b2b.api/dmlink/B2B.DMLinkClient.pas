unit B2B.DMLinkClient;

interface

uses
  System.SysUtils, Winapi.Windows;

type
  // Product info structure (must match DLL)
  TB2BProductInfo = record
    ID: array[0..50] of Char;
    Name: array[0..255] of Char;
    SKU: array[0..50] of Char;
    EAN: array[0..50] of Char;
    BrandName: array[0..100] of Char;
    CategoryName: array[0..100] of Char;
    Description: array[0..1023] of Char;
    RPrice: Double;
    SPrice: Double;
    NPrice: Double;
    Stock: Integer;
    Transit: Integer;
    WarrantyPeriod: Integer;
  end;
  PB2BProductInfo = ^TB2BProductInfo;

  // Function types
  TB2B_Initialize = function: Boolean; stdcall;
  TB2B_Finalize = procedure; stdcall;
  TB2B_Login = function(const Email, Password: PChar): Boolean; stdcall;
  TB2B_GetToken = function(Token: PChar; MaxLen: Integer): Boolean; stdcall;
  TB2B_GetProduct = function(const SKU: PChar; ProductInfo: PB2BProductInfo): Boolean; stdcall;
  TB2B_GetLastError = function(ErrorMsg: PChar; MaxLen: Integer): Boolean; stdcall;
  TB2B_IsReady = function: Boolean; stdcall;

  // Safe wrapper class
  TB2BDMLinkClient = class
  private
    FDLLHandle: HMODULE;
    FInitialize: TB2B_Initialize;
    FFinalize: TB2B_Finalize;
    FLogin: TB2B_Login;
    FGetToken: TB2B_GetToken;
    FGetProduct: TB2B_GetProduct;
    FGetLastError: TB2B_GetLastError;
    FIsReady: TB2B_IsReady;
    function GetLastError: string;
  public
    constructor Create(const DLLPath: string = 'B2BDMlinkDLL.dll');
    destructor Destroy; override;

    function IsLoaded: Boolean;
    function Initialize: Boolean;
    procedure Finalize;
    function Login(const Email, Password: string): Boolean;
    function GetToken: string;
    function GetProduct(const SKU: string; out ProductInfo: TB2BProductInfo): Boolean;
    function IsReady: Boolean;

    property LastError: string read GetLastError;
  end;

implementation

{ TB2BDMLinkClient }

constructor TB2BDMLinkClient.Create(const DLLPath: string);
begin
  inherited Create;
  FDLLHandle := 0;

  // Load DLL
  FDLLHandle := LoadLibrary(PChar(DLLPath));
  if FDLLHandle = 0 then
    raise Exception.CreateFmt('Failed to load DLL: %s (Error: %d)',
      [DLLPath, Winapi.Windows.GetLastError()]);

  // Load functions
  @FInitialize := GetProcAddress(FDLLHandle, 'B2B_Initialize');
  @FFinalize := GetProcAddress(FDLLHandle, 'B2B_Finalize');
  @FLogin := GetProcAddress(FDLLHandle, 'B2B_Login');
  @FGetToken := GetProcAddress(FDLLHandle, 'B2B_GetToken');
  @FGetProduct := GetProcAddress(FDLLHandle, 'B2B_GetProduct');
  @FGetLastError := GetProcAddress(FDLLHandle, 'B2B_GetLastError');
  @FIsReady := GetProcAddress(FDLLHandle, 'B2B_IsReady');

  // Verify all functions loaded
  if not Assigned(FInitialize) or not Assigned(FFinalize) or
     not Assigned(FLogin) or not Assigned(FGetToken) or
     not Assigned(FGetProduct) or not Assigned(FGetLastError) or
     not Assigned(FIsReady) then
  begin
    FreeLibrary(FDLLHandle);
    FDLLHandle := 0;
    raise Exception.Create('Failed to load all DLL functions');
  end;
end;

destructor TB2BDMLinkClient.Destroy;
begin
  if FDLLHandle <> 0 then
  begin
    if Assigned(FFinalize) then
      FFinalize;
    FreeLibrary(FDLLHandle);
    FDLLHandle := 0;
  end;
  inherited;
end;

function TB2BDMLinkClient.IsLoaded: Boolean;
begin
  Result := FDLLHandle <> 0;
end;

function TB2BDMLinkClient.Initialize: Boolean;
begin
  Result := False;
  if not IsLoaded then
    Exit;
  Result := FInitialize;
end;

procedure TB2BDMLinkClient.Finalize;
begin
  if IsLoaded and Assigned(FFinalize) then
    FFinalize;
end;

function TB2BDMLinkClient.Login(const Email, Password: string): Boolean;
begin
  Result := False;
  if not IsLoaded then
    Exit;
  Result := FLogin(PChar(Email), PChar(Password));
end;

function TB2BDMLinkClient.GetToken: string;
var
  Buffer: array[0..511] of Char;
begin
  Result := '';
  if not IsLoaded then
    Exit;

  FillChar(Buffer, SizeOf(Buffer), 0);
  if FGetToken(@Buffer[0], Length(Buffer)) then
    Result := string(Buffer);
end;

function TB2BDMLinkClient.GetProduct(const SKU: string;
  out ProductInfo: TB2BProductInfo): Boolean;
begin
  Result := False;
  FillChar(ProductInfo, SizeOf(ProductInfo), 0);

  if not IsLoaded then
    Exit;

  Result := FGetProduct(PChar(SKU), @ProductInfo);
end;

function TB2BDMLinkClient.GetLastError: string;
var
  Buffer: array[0..1023] of Char;
begin
  Result := '';
  if not IsLoaded then
    Exit;

  FillChar(Buffer, SizeOf(Buffer), 0);
  if FGetLastError(@Buffer[0], Length(Buffer)) then
    Result := string(Buffer);
end;

function TB2BDMLinkClient.IsReady: Boolean;
begin
  Result := False;
  if not IsLoaded then
    Exit;
  Result := FIsReady;
end;

end.
