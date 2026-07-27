unit AppSettingsClass;

interface
Uses Classes;

type

  TSWNServiceManagerSettings = class
  private
    { Private declarations }
    FUserPass: String;
    FPort: Integer;
    FDBName: String;
    FUserName: String;
    FServer: String;
    FDBUserID: integer;
    procedure SetDBName(const Value: String);
    procedure SetPort(const Value: Integer);
    procedure SetServer(const Value: String);
    procedure SetUserName(const Value: String);
    procedure SetUserPass(const Value: String);
    procedure SetDBUserID(const Value: integer);
  protected
    { Protected declarations }
    procedure LoadFromStream(const Stream:TStream);
    procedure SaveToStream(const Stream:TStream);
  public
    { Public declarations }
    constructor Create;

    property Server:String read FServer write SetServer;
    property Port:Integer read FPort write SetPort;
    property DBName:String read FDBName write SetDBName;
    property UserName:String read FUserName write SetUserName;
    property UserPass:String read FUserPass write SetUserPass;
    property DBUserID:integer read FDBUserID write SetDBUserID;

    procedure LoadFromFile(const FileName:String);
    procedure SaveToFile(const FileName:String);
  end;


implementation
uses SysUtils;

{ TSWNServiceManagerSettings }

constructor TSWNServiceManagerSettings.Create;
begin
     FDBName := '';
     FPort := 3050;
     FServer := '';
     FUserName := '';
     FUserPass := '';
     FDBUserID := -1;
end;

procedure TSWNServiceManagerSettings.LoadFromFile(const FileName: String);
var F:TFileStream;
begin
     if Not FileExists(FileName) then Exit;
     F:=TFileStream.Create(FileName,fmOpenRead);
     try
        LoadFromStream(F);
     finally
        F.Free;
     end;
end;

procedure TSWNServiceManagerSettings.LoadFromStream(const Stream: TStream);
var N:integer;
begin
     // Server
     Stream.Read(N,SizeOf(Integer));
     SetLength(FServer,N);
     if N>0 then Stream.Read(FServer[1],N*SizeOf(Char));

     // Port
     Stream.Read(FPort,SizeOf(Integer));

     // DBName
     Stream.Read(N,SizeOf(Integer));
     SetLength(FDBName,N);
     if N>0 then Stream.Read(FDBName[1],N*SizeOf(Char));

     // UserName
     Stream.Read(N,SizeOf(Integer));
     SetLength(FUserName,N);
     if N>0 then Stream.Read(FUserName[1],N*SizeOf(Char));

     // UserPass
     Stream.Read(N,SizeOf(Integer));
     SetLength(FUserPass,N);
     if N>0 then Stream.Read(FUserPass[1],N*SizeOf(Char));

     // DBUserID
     Stream.Read(FDBUserID,SizeOf(Integer));
end;

procedure TSWNServiceManagerSettings.SaveToFile(const FileName: String);
var F:TFileStream;
begin
     F:=TFileStream.Create(FileName,fmCreate);
     try
        SaveToStream(F);
     finally
        F.Free;
     end;
end;

procedure TSWNServiceManagerSettings.SaveToStream(const Stream: TStream);
var N:integer;
begin
     // Server
     N:=Length(FServer);
     Stream.Write(N,SizeOf(Integer));
     Stream.Write(FServer[1],N*SizeOf(Char));

     // Port
     Stream.Write(FPort,SizeOf(Integer));

     // DBName
     N:=Length(FDBName);
     Stream.Write(N,SizeOf(Integer));
     Stream.Write(FDBName[1],N*SizeOf(Char));

     // UserName
     N:=Length(FUserName);
     Stream.Write(N,SizeOf(Integer));
     Stream.Write(FUserName[1],N*SizeOf(Char));

     // UserPass
     N:=Length(FUserPass);
     Stream.Write(N,SizeOf(Integer));
     Stream.Write(FUserPass[1],N*SizeOf(Char));

     // DBUserID
     Stream.Write(FDBUserID,SizeOf(Integer));
end;

procedure TSWNServiceManagerSettings.SetDBName(const Value: String);
begin
  FDBName := Value;
end;

procedure TSWNServiceManagerSettings.SetDBUserID(const Value: integer);
begin
  FDBUserID := Value;
end;

procedure TSWNServiceManagerSettings.SetPort(const Value: Integer);
begin
  FPort := Value;
end;

procedure TSWNServiceManagerSettings.SetServer(const Value: String);
begin
  FServer := Value;
end;

procedure TSWNServiceManagerSettings.SetUserName(const Value: String);
begin
  FUserName := Value;
end;

procedure TSWNServiceManagerSettings.SetUserPass(const Value: String);
begin
  FUserPass := Value;
end;

end.
