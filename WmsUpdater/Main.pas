unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNUpdateToolsDBUnit,
  Dialogs, StdCtrls, ExtCtrls, SwnUpdaterTools, DB, DBAccess, IBC, dxGDIPlusClasses, DialogTitle;


const cDBLogin = 'USER_UPDATE';
      cDBPass = 'SWNUPDATE';
      cDBName = 'SW';
      cDBServer = '192.168.106.254';

      sConnecttoDBServer = 'Ne conectăm la serverul de actualizări...';
      sAppVersion = 'Versiunea programului pe server: ';
      sLoadingUpdates = 'Se descarcă actualizarea...';
      sCanNotLoadUpdates = 'Eroare! Nu se poate descărca actualizarea.';
      sNoNewVersion = 'Pe server nu există o versiune nouă.';
      sNoNewVersionInfo = 'Nu există informații despre versiuni noi!';
      sCanNotConnectToServer ='Eroare! Lipsesc datele pentru conectarea la server!';
      sConnectionEstablished = 'Conexiunea cu serverul de actualizări a fost stabilită.';
      sReadingSettings = 'Se citesc setările de conexiune...';
      sSettingsInfo = 'Parametri: server %s:%d, bază %s, utilizator %s';
      sConfigLoaded = 'Fișierul de configurare a fost încărcat: ';
      sConfigNotFound = 'EROARE! Fișierul de configurare nu a fost găsit. Căi verificate:';
      sConfigFromParam = 'Folder de configurare primit de la aplicație: ';
      sConfigUnreadable = 'EROARE! Fișierul de configurare există, dar nu a putut fi interpretat (deteriorat?): ';
      sConfigHint = 'Indicație: dacă updaterul rulează ca administrator, iar programul principal ca utilizator obișnuit, cele două folosesc profiluri diferite. Porniți-le sub același utilizator.';
      sNoServerAddress = 'EROARE! În configurare nu este specificată adresa serverului (SERVER_ADDRESS).';
      sNoServerPort = 'EROARE! În configurare nu este specificat portul serverului (SERVER_PORT).';
      sNoDatabaseAlias = 'EROARE! În configurare nu este specificat numele bazei de date (DATABASE_ALIAS).';
      sNoAppDataFolder = 'EROARE! Nu s-a putut determina folderul LOCAL_APPDATA.';
      sTargetFolder = 'Folderul de destinație pentru fișiere: ';
      sUpdateingFile = 'se actualizează fișierul: ';
type

  TfMainForm = class(TForm)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    btnClose: TButton;
    mmInfo: TMemo;
    lbVersion: TLabel;
    IBCConnection: TIBCConnection;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fTargetAppVersion:TFileVersionInfo;
    fDBAppVersion:TFileVersionInfo;
    fTargetAppFileName:String;
    fRunBackTargetApp:Boolean;
    fTargetAppPath:String;
    fTempDir:String;
    fDBVersionNumber:Int64;
    fDataStream:TMemoryStream;

    procedure Init;
    procedure TakeInitialActions;

    procedure RunCheckProcessThread;
    procedure WhenStartToUpdate(Sender:TObject);
    function DownloadDBVersion:Boolean;
    function DownloadFiles:Boolean;
    procedure DeleteTempFiles;
    procedure RunTargetApp;

    procedure ShowInfoMessage(const Text:String);
    procedure LogError(const AContext:String; E:Exception);

    function ProcessDataStream:Boolean;

    function ReadConnectionSettings(var DBName, DBServer: String; var DBPort:Integer):Boolean;
    function LocateConfigFile(out ConfigPath:String):Boolean;
    function GetApplicationAppFolderFromParams(const DefaultAppFolder:String):String;

  public
    { Public declarations }
  end;

var
  fMainForm: TfMainForm;

implementation

uses
  madZip, ShellApi, System.IOUtils, SWNVersionBuilderTypesUnit, SZCRC32, ActiveX, ShlObj, SWNValueStorageUnit;

{$R *.dfm}

function Get_LOCAL_APPDATA_Folder(out FolderPath:String):Boolean;
var Allocator: IMalloc;
    SpecialDir: PItemIdList;
    FBuf: array[0..MAX_PATH] of WideChar;
begin
     Result:=False;
     if SHGetMalloc(Allocator) = NOERROR then
     begin
          if SHGetSpecialFolderLocation(0, CSIDL_LOCAL_APPDATA, SpecialDir)=S_OK then
          begin
               if SHGetPathFromIDList(SpecialDir, @FBuf[0]) then
               begin
                    Allocator.Free(SpecialDir);
                    FolderPath:=IncludeTrailingPathDelimiter(string(FBuf));
                    Result:=True;
               end;
          end;
     end;
end;

procedure TfMainForm.WhenStartToUpdate(Sender:TObject);
var DBName, DBServer:String;
    DBPort:Integer;
begin
     btnClose.Enabled:=False;

     if ReadConnectionSettings(DBName, DBServer, DBPort) then
     try
        ShowInfoMessage(Format(sSettingsInfo,[DBServer, DBPort, DBName, cDBLogin]));
        ShowInfoMessage(sConnecttoDBServer);
        IBCConnection.Database:=DBName;
        IBCConnection.Server:=DBServer;
        IBCConnection.Port:=IntToStr(DBPort);
        IBCConnection.Username:=cDBLogin;
        IBCConnection.Password:=cDBPass;

        try
           IBCConnection.Connect;
        except on E:Exception do
           begin
                LogError('conectare la baza de date '+DBServer+':'+IntToStr(DBPort), E);
                btnClose.Enabled:=True;
                Exit;
           end;
        end;
        ShowInfoMessage(sConnectionEstablished);

        if DownloadDBVersion then
        begin
            ShowInfoMessage(sAppVersion+FileVersionToStr(fDBAppVersion));
            if FileVersionBigger(fDBAppVersion,fTargetAppVersion) then
            begin
                 ShowInfoMessage(sLoadingUpdates);
                 if DownloadFiles then
                 begin
                      if ProcessDataStream then
                      begin
                           if fRunBackTargetApp then RunTargetApp;
                           Close;
                      end;
                 end
                 else ShowInfoMessage(sCanNotLoadUpdates);
            end
            else
            begin
                 ShowInfoMessage(sNoNewVersion);
            end;
        end
        else ShowInfoMessage(sNoNewVersionInfo);

     except on E:Exception do
        begin
             LogError('procesul de actualizare', E);
        end;
     end
     else
         ShowInfoMessage(sCanNotConnectToServer);

     btnClose.Enabled:=True;
end;

procedure TfMainForm.btnCloseClick(Sender: TObject);
begin
     Close;
end;

procedure TfMainForm.DeleteTempFiles;
begin

end;

function TfMainForm.DownloadDBVersion:Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     ShowInfoMessage('Se interoghează versiunea actuală de pe server...');
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=IBCConnection;
        Query.SQL.Text:='SELECT FIRST 1 "VERSION", VERSION_STR FROM TAU_FILEVERSIONS ORDER BY TAU_FILEVERSIONS."VERSION" DESC';
        try
           Query.ExecSQL;
        except on E:Exception do
           begin
                LogError('citirea versiunii din tabela TAU_FILEVERSIONS (lipsă drepturi pe tabelă?)', E);
                Exit;
           end;
        end;
        if Not Query.Eof then
        begin
             fDBVersionNumber:=Query.Fields[0].Value;
             Result:=VersionStrToNum(Query.Fields[1].AsString,fDBAppVersion);
             if not Result then ShowInfoMessage('EROARE! Nu s-a putut interpreta șirul versiunii: '+Query.Fields[1].AsString);
        end
        else ShowInfoMessage('EROARE! Tabela de versiuni TAU_FILEVERSIONS este goală.');
     finally
        Query.Free;
     end;
end;

function TfMainForm.DownloadFiles:Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=IBCConnection;
        Query.SQL.Text:='SELECT FILEDATA FROM TAU_FILEVERSIONDATA WHERE "VERSION"=:id';
        Query.ParamByName('id').Value:=fDBVersionNumber;
        try
           Query.ExecSQL;
        except on E:Exception do
           begin
                LogError('încărcarea datelor de actualizare din tabela TAU_FILEVERSIONDATA', E);
                Exit;
           end;
        end;
        if Not Query.Eof then
        begin
             TBlobField(Query.Fields[0]).SaveToStream(fDataStream);
             Result:=fDataStream.Size>0;
             if Result then ShowInfoMessage(Format('Date de actualizare încărcate: %d octeți.',[fDataStream.Size]))
             else ShowInfoMessage('EROARE! Datele de actualizare sunt goale.');
        end
        else ShowInfoMessage('EROARE! Datele de actualizare nu au fost găsite în baza de date.');
     finally
        Query.Free;
     end;
end;

procedure TfMainForm.FormCreate(Sender: TObject);
var VI:TFileVersionInfo;
begin
     fDataStream:=TMemoryStream.Create;

     if GetMyFileVersion(Application.ExeName,VI)
      then lbVersion.Caption:=FileVersionToStr(VI)
      else lbVersion.Caption:='No version!';
     Init;
end;

procedure TfMainForm.FormDestroy(Sender: TObject);
begin
     fDataStream.Free;
end;

procedure TfMainForm.FormShow(Sender: TObject);
begin
     TakeInitialActions;
end;

function TfMainForm.GetApplicationAppFolderFromParams(const DefaultAppFolder: String): String;
const cPrefix = 'APPFOLDER=';
var i:Integer;
    S:String;
begin
     Result:=DefaultAppFolder;
     for i := 1 to ParamCount do
     begin
          S:=ParamStr(i);
          // comparam case-insensitive, dar pastram calea exact asa cum a fost transmisa
          if Pos(cPrefix,UpperCase(S))=1 then
          begin
               S:=Trim(Copy(S,Length(cPrefix)+1,Length(S)));
               if S<>'' then
               begin
                    Result:=ExcludeTrailingPathDelimiter(S);
                    Break;
               end;
          end;
     end;
end;

procedure TfMainForm.Init;
begin
     fTargetAppFileName:='';
     fRunBackTargetApp:=False;

     fTempDir:=IncludeTrailingPathDelimiter(GetTempDir);

     ZeroMemory(@fTargetAppVersion,SizeOf(TFileVersionInfo));
     ZeroMemory(@fDBAppVersion,SizeOf(TFileVersionInfo));
end;

function TfMainForm.ProcessDataStream:Boolean;
var header:TVersionFileHeader;
    i,N:integer;
    List:TList;
    S:String;
    FileSize:int64;
    CompressSize:int64;
    DataOffset:int64;
    info:TCompressedFileInfo2;
    Data:TMemoryStream;
    MS_Compresed:TMemoryStream;
    MS_UnCompresed:TMemoryStream;
begin
     Result:=False;
     fDataStream.Position:=0;
     ShowInfoMessage(sTargetFolder + fTargetAppPath);
     // read header
     fDataStream.Read(header,Sizeof(TVersionFileHeader));

     List:=TList.Create;
     Data:=TMemoryStream.Create;
     MS_Compresed:=TMemoryStream.Create;
     MS_UnCompresed:=TMemoryStream.Create;
     try
        // read files
        for i := 0 to header.FileCount - 1 do
        begin
             // File Name
             fDataStream.Read(N,SizeOf(Integer));
             SetLength(S,N);
             fDataStream.Read(S[1],SizeOf(Char)*N);
             // File Size
             fDataStream.Read(FileSize,SizeOf(Int64));
             // Compressed Size
             fDataStream.Read(CompressSize,SizeOf(Int64));
             // Data Offset
             fDataStream.Read(DataOffset,SizeOf(Int64));

             // create info record
             info:=TCompressedFileInfo2.Create(S,FileSize,CompressSize,DataOffset);
             List.Add(info);
        end;

        // get data only
        Data.CopyFrom(fDataStream,fDataStream.Size-fDataStream.Position);

        // verify CRC integrity
        Data.Position:=0;
        if SZCRC32FullStream(Data)=header.CRC then
        begin
             // CRC ok,
             for i := 0 to List.Count - 1 do
             begin
                  info:=TCompressedFileInfo2(List[i]);
                  ShowInfoMessage(sUpdateingFile+info.FileName+'...');

                  // read compressed data
                  Data.Position:=info.DataOffset;
                  MS_Compresed.Clear;
                  MS_Compresed.CopyFrom(Data,info.CompressedSize);
                  MS_UnCompresed.Clear;
                  MS_UnCompresed.Size:=info.FileSize;
                  Uncompress(MS_Compresed.Memory,MS_UnCompresed.Memory,MS_Compresed.Size,MS_UnCompresed.Size);

                  // save data to file
                  try
                     MS_UnCompresed.SaveToFile(fTargetAppPath+info.FileName);
                  except on E:Exception do
                     begin
                          LogError('scrierea fișierului '+fTargetAppPath+info.FileName+' (drepturi insuficiente?)', E);
                          Exit;
                     end;
                  end;
                  ShowInfoMessage(info.FileName+' - gata!');
             end;

             // done
             Result:=True;
        end
        else
            ShowInfoMessage('Eroare! Datele nu sunt certificate.');

     finally
        begin
             MS_Compresed.Free;
             MS_UnCompresed.Free;
             Data.Free;
             for i := 0 to List.Count - 1 do TCompressedFileInfo2(List[i]).Free;
             List.Free;
        end;
     end;

end;

function TfMainForm.LocateConfigFile(out ConfigPath: String): Boolean;
var candidates:TStringList;
    configName, appFolder, localAppData, paramFolder:String;
    i:Integer;
begin
     Result:=False;
     ConfigPath:='';

     configName:=ChangeFileExt(ExtractFileName(fTargetAppFileName), '.config');
     appFolder :=UpperCase(TPath.GetFileNameWithoutExtension(fTargetAppFileName));

     candidates:=TStringList.Create;
     try
        // 1. folderul transmis explicit de aplicatie (APPFOLDER=...).
        //    Are prioritate: este singurul valid atunci cand updaterul ruleaza elevat,
        //    sub alt profil de utilizator decat programul principal, iar %LOCALAPPDATA%
        //    se rezolva la profilul administratorului.
        paramFolder:=GetApplicationAppFolderFromParams('');
        if paramFolder<>'' then
        begin
             ShowInfoMessage(sConfigFromParam + paramFolder);
             candidates.Add(IncludeTrailingPathDelimiter(paramFolder) + configName);
        end;

        // 2. %LOCALAPPDATA%\<APP>\ - comportamentul istoric, pentru versiunile de
        //    aplicatie care nu transmit inca APPFOLDER=
        if Get_LOCAL_APPDATA_Folder(localAppData)
          then candidates.Add(IncludeTrailingPathDelimiter(localAppData + appFolder) + configName)
          else ShowInfoMessage(sNoAppDataFolder);

        // 3. langa executabilul care se actualizeaza - permite o interventie manuala
        if fTargetAppPath<>'' then candidates.Add(fTargetAppPath + configName);

        for i := 0 to candidates.Count - 1 do
        begin
             if FileExists(candidates[i]) then
             begin
                  ConfigPath:=candidates[i];
                  Result:=True;
                  Break;
             end;
        end;

        if Not Result then
        begin
             ShowInfoMessage(sConfigNotFound);
             for i := 0 to candidates.Count - 1 do ShowInfoMessage('    ' + candidates[i]);
             ShowInfoMessage(sConfigHint);
        end;
     finally
        candidates.Free;
     end;
end;

function TfMainForm.ReadConnectionSettings(var DBName, DBServer: String; var DBPort:Integer): Boolean;
var fullConfigPath:String;
begin
     Result:=False;

     ShowInfoMessage(sReadingSettings);

     if Not LocateConfigFile(fullConfigPath) then Exit;

     try
        AppConfigStorage.LoadFromFile(fullConfigPath);
     except on E:Exception do
        begin
             LogError('citirea fișierului de configurare '+fullConfigPath, E);
             Exit;
        end;
     end;
     ShowInfoMessage(sConfigLoaded + fullConfigPath);

     DBServer:=AppConfigStorage.TextValues.GetValue('SERVER_ADDRESS');
     DBPort:=AppConfigStorage.IntValues.GetValue('SERVER_PORT');
     DBName:=AppConfigStorage.TextValues.GetValue('DATABASE_ALIAS');

     // LoadFromFile nu ridica exceptie daca antetul sau CRC-ul nu corespund: in acest
     // caz toate valorile raman goale. Raportam separat de "lipseste o setare anume".
     if (DBServer='') and (DBPort<=0) and (DBName='') then
     begin
          ShowInfoMessage(sConfigUnreadable + fullConfigPath);
          Exit;
     end;

     if DBServer='' then begin ShowInfoMessage(sNoServerAddress); Exit; end;
     if DBPort<=0 then begin ShowInfoMessage(sNoServerPort); Exit; end;
     if DBName='' then begin ShowInfoMessage(sNoDatabaseAlias); Exit; end;

     Result:=True;
end;

procedure TfMainForm.RunCheckProcessThread;
var CheckProcessToFinishThread:TCheckProcessToFinishThread;
begin
     ShowInfoMessage('Se așteaptă închiderea programului "'+ExtractFileName(fTargetAppFileName)+'"...');
     CheckProcessToFinishThread:=TCheckProcessToFinishThread.Create(ExtractFileName(fTargetAppFileName));
     CheckProcessToFinishThread.OnTerminate:=WhenStartToUpdate;
     CheckProcessToFinishThread.Resume;
end;

procedure TfMainForm.RunTargetApp;
begin
     ShowInfoMessage('Se pornește programul...');
     ShellExecute(0,PWideChar('open'),PWideChar(fTargetAppFileName),nil,nil,SW_SHOWNORMAL);
end;

procedure TfMainForm.ShowInfoMessage(const Text: String);
begin
     mmInfo.Lines.Add(FormatDateTime('[hh:nn:ss] ', Now)+Text);
     Application.ProcessMessages;
end;

procedure TfMainForm.LogError(const AContext: String; E: Exception);
begin
     ShowInfoMessage(Format('EROARE [%s]: %s (%s)',[AContext, E.Message, E.ClassName]));
end;

procedure TfMainForm.TakeInitialActions;
var canStartUpdate:Boolean;
    i:Integer;
begin
     canStartUpdate:=false;

     // input params
     if ParamCount>=1 then
     begin
          fTargetAppFileName:=ParamStr(1);

          // RUNAPP nu mai este obligatoriu al doilea parametru: dupa el poate urma
          // (sau il poate preceda) APPFOLDER=..., asa ca il cautam printre toti
          for i := 2 to ParamCount do
              if SameText(ParamStr(i),'RUNAPP') then fRunBackTargetApp:=True;

          // check if file exists
          if FileExists(fTargetAppFileName) then
          begin
               fTargetAppPath:=IncludeTrailingPathDelimiter(ExtractFilePath(fTargetAppFileName));
               canStartUpdate:=GetMyFileVersion(fTargetAppFileName,fTargetAppVersion);
               if canStartUpdate then ShowInfoMessage('Versiunea programului curent: '+FileVersionToStr(fTargetAppVersion));
          end
          else
          ShowInfoMessage('Parametri insuficienți pentru funcționarea serviciului de actualizare.');
     end
     else ShowInfoMessage('Parametri insuficienți pentru funcționarea serviciului de actualizare.');

     if canStartUpdate then RunCheckProcessThread
     else btnClose.Enabled:=True;
end;

end.
