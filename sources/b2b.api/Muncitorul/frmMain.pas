unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Muncitorul.Data, Data.DB,
  Vcl.Grids, Vcl.DBGrids,  System.Diagnostics;

type
  TForm1 = class(TForm)
    Button1: TButton;
    MemoJson: TMemo;
    DsProducts: TDataSource;
    DsImages: TDataSource;
    DsFeatures: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FData:  TMuncitorulData;
    procedure BtnLoadJsonClick(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FData.Free;
end;

procedure TForm1.BtnLoadJsonClick(Sender: TObject);
begin
  if MemoJson.Text = '' then
  begin
    ShowMessage('Memo-ul JSON este gol.');
    Exit;
  end;

  try
    { Apelăm metoda de încărcare - Nicio schimbare aici }
    FData.LoadFromJson(MemoJson.Text);

    ShowMessage('Datele au fost încărcate cu succes!');
  except
    on E: Exception do
      ShowMessage('Eroare la parsarea JSON: ' + E.Message);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  var LStopwatch: TStopwatch;
  var LDownloadTime, LLoadTime, LTotalTime: Int64;

  { Creăm instanța clasei de date }
  FData := TMuncitorulData.Create;

  { Măsurăm timpul total }
  LStopwatch := TStopwatch.StartNew;

  { Măsurăm timpul de download }
  var LDownloadWatch := TStopwatch.StartNew;
  MemoJson.Lines.Text := FData.DownloadJsonAsString('https://price.muncitorul.md/api/products.json');
  LDownloadWatch.Stop;
  LDownloadTime := LDownloadWatch.ElapsedMilliseconds;

  { Măsurăm timpul de încărcare JSON }
  var LLoadWatch := TStopwatch.StartNew;
  FData.LoadFromJson(MemoJson.Lines.Text);
  LLoadWatch.Stop;
  LLoadTime := LLoadWatch.ElapsedMilliseconds;

  { Oprește cronometrul total }
  LStopwatch.Stop;
  LTotalTime := LStopwatch.ElapsedMilliseconds;

  { Conectăm sursele de date la seturile de date din clasa noastră }
  DsProducts.DataSet := FData.Products;
  DsImages.DataSet := FData.Images;
  DsFeatures.DataSet := FData.Features;

  { Afișăm timpii }
  ShowMessage(Format('Download: %d ms' + sLineBreak +
                     'Load JSON: %d ms' + sLineBreak +
                     'Total: %d ms',
                     [LDownloadTime, LLoadTime, LTotalTime]));
end;

end.
