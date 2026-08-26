unit frmAnalyticTypesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit;

type
  TfrmAnalyticTypesDlg = class(TSWNMasteredFormClass)
  private
    { Private declarations }
  protected
    procedure Prepare;override;

  public
    { Public declarations }
  end;

var
  frmAnalyticTypesDlg: TfrmAnalyticTypesDlg;

implementation

{$R *.dfm}

{ TfrmAnalyticTypesDlg }

procedure TfrmAnalyticTypesDlg.Prepare;
begin
  inherited;

end;

end.
