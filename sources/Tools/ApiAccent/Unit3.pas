unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm3 = class(TForm)
    NetHTTPClient1: TNetHTTPClient;
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    httpclient1.get('ftp://ftp.accent.md/aeimages/img80154_3.jpg', ms);
    ms.seek(0);
    image1.loadfromstream(ms);
  finally
    ms.Free;
  end;
end;

end.
