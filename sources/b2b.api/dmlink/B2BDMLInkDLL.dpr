library B2BDMLInkDLL;

uses
  System.SysUtils,
  System.Classes,
  B2B.DMlink in '..\B2B.DMlink.pas';

{$R *.res}

type
  // Product info structure for export
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

var
  APIInstance: TB2BDMlink = nil;
  LastError: string = '';

// Helper to copy string to char array safely
procedure StrToCharArray(const Source: string; var Dest: array of Char);
var
  Len: Integer;
begin
  FillChar(Dest, SizeOf(Dest), 0);
  Len := Length(Source);
  if Len > High(Dest) then
    Len := High(Dest);
  if Len > 0 then
    Move(Source[1], Dest[0], Len * SizeOf(Char));
end;

// Initialize API instance
function B2B_Initialize: Boolean; stdcall;
begin
  Result := False;
  LastError := '';
  try
    if Assigned(APIInstance) then
      FreeAndNil(APIInstance);

    APIInstance := TB2BDMlink.Create;
    Result := True;
  except
    on E: Exception do
      LastError := E.Message;
  end;
end;

// Finalize and free API instance
procedure B2B_Finalize; stdcall;
begin
  try
    if Assigned(APIInstance) then
      FreeAndNil(APIInstance);
  except
    // Silent cleanup
  end;
end;

// Login to API
function B2B_Login(const Email, Password: PChar): Boolean; stdcall;
begin
  Result := False;
  LastError := '';
  try
    if not Assigned(APIInstance) then
    begin
      LastError := 'API not initialized. Call B2B_Initialize first.';
      Exit;
    end;

    Result := APIInstance.Login(string(Email), string(Password));
    if not Result then
      LastError := 'Login failed. Check credentials.';
  except
    on E: Exception do
    begin
      LastError := E.Message;
      Result := False;
    end;
  end;
end;

// Get current token
function B2B_GetToken(Token: PChar; MaxLen: Integer): Boolean; stdcall;
var
  TokenStr: string;
begin
  Result := False;
  LastError := '';
  try
    if not Assigned(APIInstance) then
    begin
      LastError := 'API not initialized.';
      Exit;
    end;

    TokenStr := APIInstance.GetToken;
    if TokenStr = '' then
    begin
      LastError := 'No token available. Login first.';
      Exit;
    end;

    StrPLCopy(Token, TokenStr, MaxLen - 1);
    Result := True;
  except
    on E: Exception do
    begin
      LastError := E.Message;
      Result := False;
    end;
  end;
end;

// Get product information
function B2B_GetProduct(const SKU: PChar; ProductInfo: PB2BProductInfo): Boolean; stdcall;
var
  Product: TB2BProduct;
begin
  Result := False;
  LastError := '';
  try
    if not Assigned(APIInstance) then
    begin
      LastError := 'API not initialized.';
      Exit;
    end;

    if not Assigned(ProductInfo) then
    begin
      LastError := 'Invalid product info pointer.';
      Exit;
    end;

    FillChar(ProductInfo^, SizeOf(TB2BProductInfo), 0);

    Result := APIInstance.GetProduct(string(SKU), Product);

    if Result then
    begin
      StrToCharArray(Product.ID, ProductInfo^.ID);
      StrToCharArray(Product.Name, ProductInfo^.Name);
      StrToCharArray(Product.SKU, ProductInfo^.SKU);
      StrToCharArray(Product.EAN, ProductInfo^.EAN);
      StrToCharArray(Product.Brand.Name, ProductInfo^.BrandName);
      StrToCharArray(Product.Category.Name, ProductInfo^.CategoryName);
      StrToCharArray(Product.Description, ProductInfo^.Description);

      ProductInfo^.RPrice := Product.RPrice;
      ProductInfo^.SPrice := Product.SPrice;
      ProductInfo^.NPrice := Product.NPrice;
      ProductInfo^.Stock := Product.Stock;
      ProductInfo^.Transit := Product.Transit;
      ProductInfo^.WarrantyPeriod := Product.WarrantyPeriod;

      // Clean up cloned objects
      if Assigned(Product.Specifications) then
        Product.Specifications.Free;
      if Assigned(Product.Images) then
        Product.Images.Free;
      if Assigned(Product.Category.Parents) then
        Product.Category.Parents.Free;
    end
    else
      LastError := 'Product not found or API error.';
  except
    on E: Exception do
    begin
      LastError := E.Message;
      Result := False;
    end;
  end;
end;

// Get last error message
function B2B_GetLastError(ErrorMsg: PChar; MaxLen: Integer): Boolean; stdcall;
begin
  Result := False;
  try
    if LastError <> '' then
    begin
      StrPLCopy(ErrorMsg, LastError, MaxLen - 1);
      Result := True;
    end;
  except
    Result := False;
  end;
end;

// Check if API is initialized and logged in
function B2B_IsReady: Boolean; stdcall;
begin
  Result := Assigned(APIInstance) and (APIInstance.Token <> '');
end;

exports
  B2B_Initialize,
  B2B_Finalize,
  B2B_Login,
  B2B_GetToken,
  B2B_GetProduct,
  B2B_GetLastError,
  B2B_IsReady;

begin
  // DLL initialization
  IsMultiThread := True;
end.
