program SWN5Updater;

uses
  Windows,
  Forms,
  Main in 'Main.pas' {fMainForm},
  SwnUpdaterTools in 'SwnUpdaterTools.pas',
  SWNValueStorageUnit in 'SWNValueStorageUnit.pas',
  SWNUpdateToolsDBUnit in '..\sources\Updater\SWNUpdateToolsDBUnit.pas',
  SWNVersionBuilderTypesUnit in '..\sources\Updater\SWNVersionBuilderTypesUnit.pas',
  SZCRC32 in '..\sources\Utils\SZCRC32.pas';

{$R *.res}
var Mutex : THandle;
begin
     Mutex := CreateMutex(nil, True, 'SWNUpdateMutex');
     if (Mutex = 0) OR (GetLastError = ERROR_ALREADY_EXISTS) then
     begin
          // code to searh for, and activate
          // the previous (first) instance
     end
     else
     begin
          Application.Initialize;
          Application.MainFormOnTaskbar := True;
          Application.CreateForm(TfMainForm, fMainForm);
  Application.Run;
     end;
end.
