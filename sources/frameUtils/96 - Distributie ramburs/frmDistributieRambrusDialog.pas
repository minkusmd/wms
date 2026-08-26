unit frmDistributieRambrusEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit;

type
  TfrmDistributieRambursDlg = class(TSWNMasteredFormClass)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: boolean;
  public
    { Public declarations }
  end;

var
  frmDistributieRambursDlg: TfrmDistributieRambursDlg;

implementation

{$R *.dfm}

{ TfrmDistributieRambursDlg }

function TfrmDistributieRambursDlg.IsFormDataPosted: boolean;
begin
  Result := True;
end;

procedure TfrmDistributieRambursDlg.Prepare;
begin
  inherited;

end;

end.
