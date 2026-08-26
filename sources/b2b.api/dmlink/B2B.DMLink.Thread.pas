unit B2B.DMLink.Thread;

interface

uses
  System.Classes, System.SysUtils, B2B.DMLinkClient;

type
  TB2BThreadMode = (tmLogin, tmGetProduct, tmGetToken);

  TB2BThreadResult = record
    Success: Boolean;
    ErrorMsg: string;
    Token: string;
    ProductInfo: TB2BProductInfo;
  end;

  // Event type for completion callback
  TB2BCompleteEvent = procedure(const AResult: TB2BThreadResult) of object;

  TB2BThread = class(TThread)
  private
    FMode: TB2BThreadMode;
    FDLLPath: string;
    FEmail: string;
    FPassword: string;
    FSKU: string;
    FResult: TB2BThreadResult;
    FOnComplete: TB2BCompleteEvent;
    procedure DoComplete;
  protected
    procedure Execute; override;
  public
    constructor Create(const ADLLPath: string); reintroduce;

    // Setup methods
    procedure SetupLogin(const AEmail, APassword: string;
      AOnComplete: TB2BCompleteEvent);
    // FIXED: Now requires email/password to re-authenticate
    procedure SetupGetProduct(const ASKU, AEmail, APassword: string;
      AOnComplete: TB2BCompleteEvent);
    procedure SetupGetToken(AOnComplete: TB2BCompleteEvent);

    property Result: TB2BThreadResult read FResult;
  end;

implementation

{ TB2BThread }

constructor TB2BThread.Create(const ADLLPath: string);
begin
  inherited Create(True); // Create suspended
  FreeOnTerminate := True;
  FDLLPath := ADLLPath;
  FillChar(FResult, SizeOf(FResult), 0);
end;

procedure TB2BThread.SetupLogin(const AEmail, APassword: string;
  AOnComplete: TB2BCompleteEvent);
begin
  FMode := tmLogin;
  FEmail := AEmail;
  FPassword := APassword;
  FOnComplete := AOnComplete;
end;

procedure TB2BThread.SetupGetProduct(const ASKU, AEmail, APassword: string;
  AOnComplete: TB2BCompleteEvent);
begin
  FMode := tmGetProduct;
  FSKU := ASKU;
  FEmail := AEmail;      // ← FIXED: Store credentials
  FPassword := APassword; // ← FIXED: Store credentials
  FOnComplete := AOnComplete;
end;

procedure TB2BThread.SetupGetToken(AOnComplete: TB2BCompleteEvent);
begin
  FMode := tmGetToken;
  FOnComplete := AOnComplete;
end;

procedure TB2BThread.Execute;
var
  Client: TB2BDMLinkClient;
begin
  Client := nil;
  FillChar(FResult, SizeOf(FResult), 0);

  try
    // Create client
    Client := TB2BDMLinkClient.Create(FDLLPath);
    try
      // Initialize
      if not Client.Initialize then
      begin
        FResult.Success := False;
        FResult.ErrorMsg := 'Failed to initialize: ' + Client.LastError;
        Exit;
      end;

      // Execute operation based on mode
      case FMode of
        tmLogin:
        begin
          FResult.Success := Client.Login(FEmail, FPassword);
          if FResult.Success then
            FResult.Token := Client.GetToken
          else
            FResult.ErrorMsg := Client.LastError;
        end;

        tmGetProduct:
        begin
          // ← FIXED: Login first, then get product
          if Client.Login(FEmail, FPassword) then
          begin
            FResult.Success := Client.GetProduct(FSKU, FResult.ProductInfo);
            if not FResult.Success then
              FResult.ErrorMsg := Client.LastError;
          end
          else
          begin
            FResult.Success := False;
            FResult.ErrorMsg := 'Login failed: ' + Client.LastError;
          end;
        end;

        tmGetToken:
        begin
          FResult.Token := Client.GetToken;
          FResult.Success := FResult.Token <> '';
          if not FResult.Success then
            FResult.ErrorMsg := 'No token available';
        end;
      end;
    finally
      Client.Free;
    end;
  except
    on E: Exception do
    begin
      FResult.Success := False;
      FResult.ErrorMsg := E.Message;
    end;
  end;

  // Call completion handler in main thread
  if Assigned(FOnComplete) then
    Synchronize(DoComplete);
end;

procedure TB2BThread.DoComplete;
begin
  if Assigned(FOnComplete) then
    FOnComplete(FResult);
end;

end.
