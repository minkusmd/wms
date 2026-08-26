program dmlink_api;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {Form12},
  B2B.DMLink in 'B2B.DMLink.pas',
  B2B.DMLinkClient in 'B2B.DMLinkClient.pas',
  B2B.DMLink.Thread in 'B2B.DMLink.Thread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm12, Form12);
  Application.Run;
end.
