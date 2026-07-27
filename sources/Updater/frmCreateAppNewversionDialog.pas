unit frmCreateAppNewversionDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, StdCtrls, ComCtrls, SWNUpdateToolsDBUnit, SWNVersionBuilderUnit, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons;

type
  TfrmCreateAppNewversionDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lbAppVersion: TLabel;
    lbDBAppVersion: TLabel;
    lbTitle: TLabel;
    mmInfo: TMemo;
    pbProgressBar: TProgressBar;
    lbProgress: TLabel;
    cbCritical: TCheckBox;
    mmPrevVersion: TMemo;
    rbFullInstall: TRadioButton;
    rbUpdate: TRadioButton;
    rbSpecialUpdate: TRadioButton;
    btnCreate: TcxButton;
    btnClose: TcxButton;
    procedure btnCreateClick(Sender: TObject);
  private
    { Private declarations }
    fFileList:TStringList;
    fCurrAppVersion:TFileVersionInfo;
    fDBAppVersion:TFileVersionInfo;
    fOutputDataStream:TMemoryStream;
    procedure ReadDBAppVersion;
    procedure DoCreateOutputStream;
    procedure SaveNewVersionDB;
    procedure WhenProgress(const ProgressType:TSWNVersionBuilderProgressType; const Value:integer);
    procedure LoadBuildFiles;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  end;



implementation

uses DB, IBC, DataModuleDB, SWNVersionBuilderTypesUnit, System.IniFiles;

{$R *.dfm}

procedure TfrmCreateAppNewversionDlg.btnCreateClick(Sender: TObject);
begin
     DoCreateOutPutStream;
     ModalResult := mrClose;
end;

constructor TfrmCreateAppNewversionDlg.Create(AOwner: TComponent);
begin
     inherited;
     fFileList:=TStringList.Create;
     fOutputDataStream:=TMemoryStream.Create;

     ZeroMemory(@fCurrAppVersion,SizeOf(TFileVersionInfo));
     ZeroMemory(@fDBAppVersion,SizeOf(TFileVersionInfo));
end;

destructor TfrmCreateAppNewversionDlg.Destroy;
begin
     fOutputDataStream.Free;
     fFileList.Free;
     inherited;
end;

procedure TfrmCreateAppNewversionDlg.DoCreateOutputStream;
var builder:TSWNVersionBuilder;
    result:Boolean;
begin
     LoadBuildFiles;


     // show progress
     pbProgressBar.Visible:=True;
     lbProgress.Caption:='crearea arhivei';
     lbProgress.Visible:=True;
     Application.ProcessMessages;
     btnCreate.Visible:=False;
     cbCritical.Enabled:=True;
     lbTitle.Enabled:=False;
     mmInfo.Enabled:=False;
     try
        // 1. create list of files
        fFileList.Add(Application.ExeName);

        // 2. compress all files
        builder:=TSWNVersionBuilder.Create;
        try
           builder.FileList:=fFileList;
           builder.OnProgress:=WhenProgress;
           result:=builder.BuildOutputStream(fOutputDataStream);
        finally
           builder.Free;
        end;

        // 3. post to DB

        if result then
        begin
             //fOutputDataStream.SaveToFile('compresed.dat');
             lbProgress.Caption:='inscrierea in baza de date';
             pbProgressBar.Position:=pbProgressBar.Position+1;
             Application.ProcessMessages;
             SaveNewVersionDB;
             lbProgress.Caption:='Done!';
        end
        else
        begin
             lbProgress.Caption:='Eroare! nu pot arhiva fisierele!';
        end;
     finally
        pbProgressBar.Visible:=False;
     end;
end;

procedure TfrmCreateAppNewversionDlg.LoadBuildFiles;
var ini:TIniFile;
    tmpFiles:TStrings;
    filename,sectionName,mask:String;
    i: Integer;
    path,appPath:String;
begin
     if rbFullInstall.Checked then sectionName:='FULLINSTALL'
     else
     if rbSpecialUpdate.Checked then sectionName:='SPECIAL_BUILD'
     else
         sectionName:='UPDATE';

     appPath:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));

     ini:=TIniFile.Create(appPath+'install-files.ini');
     tmpFiles:=TStringList.Create;
     try
        if ini.SectionExists(sectionName) then
        begin
             ini.ReadSectionValues(sectionName,tmpFiles);
             if tmpFiles.Count>0 then
             for i := 0 to tmpFiles.Count-1 do
             begin
                  filename:=tmpFiles[i];
                  mask:=Format('file%d=',[i+1]);
                  if (Pos(mask,filename)=1) then Delete(filename,1,Length(mask));
                  path:=ExtractFilePath(filename);
                  if (path='')
                     then fFileList.Add(appPath+filename)
                     else fFileList.Add(filename);
             end;
        end;
     finally
        tmpFiles.Free;
        ini.Free;
     end;
end;

procedure TfrmCreateAppNewversionDlg.Prepare;
begin
     inherited;
     pbProgressBar.Visible:=false;
     lbProgress.Visible:=false;

     if GetMyFileVersion(Application.ExeName,fCurrAppVersion) then
     begin
          with fCurrAppVersion do
          lbAppVersion.Caption:=Format('%d.%d.%d.%d',[MajorVersion,MinorVersion,Release,Build]);

          ReadDBAppVersion;
          with fDBAppVersion do
          lbDBAppVersion.Caption:=Format('%d.%d.%d.%d',[MajorVersion,MinorVersion,Release,Build]);

         {$IFDEF DEBUG}
           btnCreate.Enabled := False;
         {$ELSE}
           btnCreate.Enabled := True;
         {$ENDIF}

          if FileVersionBigger(fCurrAppVersion,fDBAppVersion) then
          begin
               mmInfo.Text:='[+] Fixes';
          end
          else
          begin
               // no new version
               mmInfo.Enabled:=false;
               btnCreate.Visible:=false;
               cbCritical.Enabled:=false;
               lbTitle.Enabled:=false;
               rbFullInstall.Enabled:=false;
               rbUpdate.Enabled:=false;
               rbSpecialUpdate.Enabled:=false;

          end;
     end
     else
     begin
          // no version info
     end;
end;

procedure TfrmCreateAppNewversionDlg.ReadDBAppVersion;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultSelect;
        Query.SQL.Add('SELECT FIRST 1 VERSION, VERSION_STR,');
        Query.SQL.Add('(SELECT CHANGES FROM TAU_FILEVERSIONCHANGES A WHERE A."VERSION"=B."VERSION")');
        Query.SQL.Add('FROM TAU_FILEVERSIONS B ORDER BY VERSION DESC');

        Query.ExecSQL;
        if Not Query.Eof then
        begin
             if VersionStrToNum(Query.Fields[1].AsString, fDBAppVersion) then mmPrevVersion.Lines.Add(Query.Fields[2].AsString);
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmCreateAppNewversionDlg.SaveNewVersionDB;
var Query:TIBCQuery;
    MS:TMemoryStream;
begin
     MS:=TMemoryStream.Create;
     Query:=TIBCQuery.Create(Self);
     try
        mmInfo.Lines.SaveToStream(MS);
        MS.Position:=0;
        fOutputDataStream.Position:=0;

        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SPAU_CREATE_NEW_FILEVERSION(:VERSION,:VERSION_STR,:CHANGES,:FILEDATA,:CRIT)';
        Query.ParamByName('VERSION').AsLargeInt:=GetVersionNumber(fCurrAppVersion);
        Query.ParamByName('VERSION_STR').AsString:=FileVersionToStr(fCurrAppVersion);
        Query.ParamByName('CHANGES').LoadFromStream(MS,ftMemo);
        Query.ParamByName('FILEDATA').LoadFromStream(fOutputDataStream,ftBlob);
        Query.ParamByName('CRIT').AsInteger:=Ord(cbCritical.Checked);
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
        except
           Query.Transaction.Rollback;
           raise;
        end;
     finally
        Query.Free;
        MS.Free;
     end;
end;

procedure TfrmCreateAppNewversionDlg.WhenProgress(const ProgressType: TSWNVersionBuilderProgressType; const Value: integer);
begin
     case ProgressType of
       ptStart: begin pbProgressBar.Max:=Value+1; pbProgressBar.Position:=0; end;
       ptProgress: pbProgressBar.Position:=Value;
       ptEnd: ;
     end;
     Application.ProcessMessages;
end;

end.
