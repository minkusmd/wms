program SWNServiceManager;

uses
  Forms,
  frmMain in 'frmMain.pas' {fMain},
  SetupConnectionDialog in 'SetupConnectionDialog.pas' {frmSetupConnectionDlg},
  AppSettingsClass in 'AppSettingsClass.pas',
  TaskConfigDialog in 'TaskConfigDialog.pas' {frmTaskConfigDlg},
  SelectDBUserDialog in 'SelectDBUserDialog.pas' {frmSelectDBUserDlg},
  TaskClass in 'TaskClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
