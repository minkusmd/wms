unit ActivityMonitorUnit;

interface
uses Classes, DB, IBC, SWNUtils, VCL.Graphics, Vcl.Imaging.jpeg;

type

  TUserActivityMonitor = class
  private
    { private declarations }
    fDBConnection:TIBCConnection;
    fUserID:integer;
    fInterval:integer;
    fThread:TDelayThread;
    FDBServer: String;
    fUserName, fFirmaName:String;
    procedure StartMonitoring;
    procedure ProcessUserActivity;
    procedure WhenTimeToProcessUserActivity(Sender:TObject);
    function GetScreenShot:VCL.Graphics.TBitmap;
    procedure ConvertBitmapToJPEG(const Bmp:VCL.Graphics.TBitmap; const OutputStream:TMemoryStream);
    procedure SaveInfoToDB(const DataStream:TMemoryStream);
    procedure SetDBServer(const Value: String);
  public
    { public declarations }
    constructor Create(const UserID:Integer; const UserName,FirmaName:String; const DBConnection:TIBCConnection);reintroduce;
    destructor Destroy;override;

    property Interval:integer read fInterval;
    property DBServer:String read FDBServer write SetDBServer;

    procedure LoadFromDB;
    procedure MarkActivity;

  end;

implementation
uses Windows, Forms, SysUtils;

{ TUserActivityMonitor }

procedure TUserActivityMonitor.ConvertBitmapToJPEG(const Bmp:VCL.Graphics.TBitmap; const OutputStream:TMemoryStream);
var JPeg:TJPEGImage;
begin
     JPeg:=TJPEGImage.Create;
     try
        //JPeg.Grayscale:=True;
        JPeg.CompressionQuality:=40;
        JPeg.Assign(Bmp);
        JPeg.SaveToStream(OutputStream);
     finally
        JPeg.Free;
     end;
end;

constructor TUserActivityMonitor.Create(const UserID:Integer; const UserName, FirmaName:String; const DBConnection:TIBCConnection);
begin
     inherited Create;
     fDBConnection:=DBConnection;
     fUserID:=UserID;
     fInterval:=0;
     fThread:=nil;
     fUserName:=UserName;
     fFirmaName:=FirmaName;
end;

destructor TUserActivityMonitor.Destroy;
begin
     if fThread<>nil then fThread.Terminate;
     inherited;
end;

procedure TUserActivityMonitor.LoadFromDB;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(nil);
     try
        Query.Connection:=fDBConnection;
        Query.SQL.Text:='SELECT INTERVAL FROM TDB_SCREENSHOT_USERS WHERE (USERID=:ID) AND (FLG_ENABLED=1)';
        Query.ParamByName('ID').AsInteger:=fUserID;
        Query.ExecSQL;
        if Not Query.Eof then
        begin
             fInterval:=Query.Fields[0].AsInteger;
             if fInterval>=1 then StartMonitoring;
        end;
     finally
        Query.Free;
     end;
end;

procedure TUserActivityMonitor.MarkActivity;
begin
     ProcessUserActivity;
end;

procedure TUserActivityMonitor.ProcessUserActivity;
var Bmp:VCL.Graphics.TBitmap;
    Data:TMemoryStream;
begin
     fThread:=nil;
     // process user activity
     Bmp:=GetScreenShot;
     try
        if Not Bmp.Empty then
        begin
             Data:=TMemoryStream.Create;
             try
                ConvertBitmapToJPEG(Bmp,Data);
                SaveInfoToDB(Data);
             finally
                Data.Free;
             end;
        end;
     finally
        Bmp.Free;
     end;
end;

procedure TUserActivityMonitor.WhenTimeToProcessUserActivity(Sender: TObject);
begin
     ProcessUserActivity;
     // start again
     StartMonitoring;
end;

function TUserActivityMonitor.GetScreenShot:VCL.Graphics.TBitmap;
var DC : HDC;
begin
     Result:=VCL.Graphics.TBitmap.Create;
     DC:=GetDC(GetDesktopWindow);
     try
        Result.Width:=Screen.DesktopWidth;
        Result.Height:=Screen.DesktopHeight;
        BitBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height, DC, Screen.DesktopLeft, Screen.DesktopTop, SRCCOPY);
     finally
        ReleaseDC(GetDesktopWindow, DC);
     end;
end;

procedure TUserActivityMonitor.SaveInfoToDB(const DataStream: TMemoryStream);
var Query:TIBCQuery;
    Trans:TIBCTransaction;
    Conn:TIBCConnection;
begin
     Conn:=TIBCConnection.Create(nil);
     try
        Conn.ClientLibrary:='fbclient.dll';
        Conn.Database:='SW_MON';
        Conn.LoginPrompt:=False;
        Conn.Server:=FDBServer;
        Conn.Username:='SYSDBA';
        Conn.Password:='uigres321';
        try
           Conn.Connect;

           Query:=TIBCQuery.Create(nil);
           Trans:=TIBCTransaction.Create(nil);
           try
              Query.Connection:=Conn;
              Conn.DefaultTransaction:=Trans;
              Trans.DefaultConnection:=Conn;
              Query.Transaction:=Trans;
              Query.SQL.Text:='INSERT INTO TDB_SCREENSHOTS (USERID,SCREEN,USER_NAME,FIRMA_NAME) VALUES (:ID,:IMG, :US, :FM)';
              Query.ParamByName('ID').AsInteger:=fUserID;
              Query.ParamByName('IMG').LoadFromStream(DataStream,ftBlob);
              Query.ParamByName('US').AsString:=fUserName;
              Query.ParamByName('FM').AsString:=fFirmaName;
              try
                 Query.Transaction.StartTransaction;
                 Query.Execute;
                 Query.Transaction.Commit;
              except
                 Query.Transaction.Rollback;
              end;
           finally
              Query.Free;
              Trans.Free;
           end;
        except
        end;
     finally
        Conn.Free;
     end;
end;

procedure TUserActivityMonitor.SetDBServer(const Value: String);
begin
  FDBServer := Value;
end;

procedure TUserActivityMonitor.StartMonitoring;
begin
     fThread:=TDelayThread.Create(fInterval*60*1000,WhenTimeToProcessUserActivity);
     fThread.Start;
end;

end.
