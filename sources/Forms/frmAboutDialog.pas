unit frmAboutDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  cxButtons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxGDIPlusClasses, Vcl.Imaging.pngimage;

type
  TfrmAboutDlg = class(TForm)
    pnClient: TPanel;
    imgLogo: TImage;
    lbVersion: TLabel;
    cxLabel3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure imgLogoClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadLogoImage;
  public
    { Public declarations }
  end;

implementation

uses
  SWNConst, SWNUpdateToolsDBUnit;

{$R *.dfm}

procedure TfrmAboutDlg.FormCreate(Sender: TObject);
var
  VI: TFileVersionInfo;
begin
  if GetMyFileVersion(Application.ExeName, VI) then
    lbVersion.Caption := Format(cAPP_Version, [FileVersionToStr(VI)])
  else
    lbVersion.Caption := 'No version!';

//     LoadLogoImage;
end;

procedure TfrmAboutDlg.imgLogoClick(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TfrmAboutDlg.LoadLogoImage;
//var png:TdxPNGImage;
//    RS:TResourceStream;
begin
//     png:=TdxPNGImage.Create;
//     RS:=TResourceStream.Create(HInstance,'PNG_SWNLOGOBIG','PNG');
//     try
//        png.LoadFromStream(RS);
//        imgLogo.Picture.Assign(png);
//     finally
//        RS.Free;
//        png.Free;
//     end;
end;

end.

