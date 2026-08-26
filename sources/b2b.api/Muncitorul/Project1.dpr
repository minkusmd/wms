program Project1;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {Form1},
  Muncitorul.Data in 'Muncitorul.Data.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
