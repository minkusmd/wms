unit frmGoodsImagePreviewDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,

  ExtCtrls, DialogTitle,
  PNGImage, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxImage;

type
  TfrmGoodsImagePreview = class(TForm)
    dtDialogTitle: TDialogTitle;
    cxImage1: TcxImage;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    fImage: TPngImage;
  public
    { Public declarations }
    procedure ShowImageFromStream(const ImageStream: TMemoryStream);
    procedure SetCustomTitle(const Title: String);
  end;

implementation



{$R *.dfm}

procedure TfrmGoodsImagePreview.FormCreate(Sender: TObject);
begin
//  fImage := TPngImage.Create;
end;

procedure TfrmGoodsImagePreview.FormDestroy(Sender: TObject);
begin
//  fImage.Free;
end;

procedure TfrmGoodsImagePreview.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

procedure TfrmGoodsImagePreview.FormPaint(Sender: TObject);
//var
//  x, y: integer;
begin
//  y := dtDialogTitle.Top + dtDialogTitle.Height;
//  y := y + (ClientHeight - y - fImage.Height) div 2;
//  x := (ClientWidth - fImage.Width) div 2;
//  Canvas.Draw(x, y, fImage);
end;

procedure TfrmGoodsImagePreview.SetCustomTitle(const Title: String);
begin
  dtDialogTitle.Title := Title;
  Caption := Title;
end;

procedure TfrmGoodsImagePreview.ShowImageFromStream(const ImageStream
  : TMemoryStream);
begin
//  ImageStream.Position := 0;
//  fImage.LoadFromStream(ImageStream);
//
//  dtDialogTitle.Text := Format(dtDialogTitle.Text, [fImage.Width, fImage.Height,
//    ImageStream.Size div 1024]);
//
//  // adjust window size
//  ClientWidth := fImage.Width + 20;
//  ClientHeight := fImage.Height + 20 + dtDialogTitle.Height;

  with cxImage1.Picture.Create do
  begin
    cxImage1.Properties.GraphicClassName := 'TdxSmartImage';
    ImageStream.Position := 0;
    LoadFromStream(ImageStream);
    Invalidate;
  end;
end;

end.
