unit frmGoodsImageEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, ExtCtrls, Menus, dxBar,
  StdCtrls, cxButtons, cxPC, cxImage, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxClasses;

type
  TfrmGoodsImageEditorDlg = class(TForm)
    dtDialogTitle: TDialogTitle;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    sbScrollBox: TScrollBox;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbOpenImage: TdxBarButton;
    dxBarButton2: TdxBarButton;
    Panel1: TPanel;
    dxBarSubItem2: TdxBarSubItem;
    bbResizeThumbnail: TdxBarButton;
    bbResizeGallery: TdxBarButton;
    bbContrast: TdxBarButton;
    lbImageSize: TLabel;
    imgIMAGE: TcxImage;
    procedure imgIMAGEPropertiesChange(Sender: TObject);
    procedure bbOpenImageClick(Sender: TObject);
  private
    { Private declarations }
    procedure DisplayImagePropertis;
    procedure LoadJPEGImage(const FileName:String);
    procedure LoadGIFImage(const FileName:String);
  public
    { Public declarations }
    procedure GetData(const Stream:TMemoryStream);
  end;


implementation
Uses ExtDlgs, SWNUtils,JPEG;

{$R *.dfm}

{ TfrmGoodsImageEditorDlg }

procedure TfrmGoodsImageEditorDlg.bbOpenImageClick(Sender: TObject);
var dialog:TOpenPictureDialog;
    fileExt:String;
begin
     dialog:=TOpenPictureDialog.Create(Self);
     try
        if dialog.Execute then
        begin
             fileExt:=LowerCase(ExtractFileExt(dialog.FileName));
             if fileExt='.png' then imgIMAGE.Picture.LoadFromFile(dialog.FileName)
             else
             if (fileExt='.jpg') or (fileExt='.jpeg') then LoadJPEGImage(dialog.FileName)
             else
             if (fileExt='.gif') then LoadGIFImage(dialog.FileName)
             else
             ShowErrorDialog('Image not supported','Selected image format is not supported!');
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsImageEditorDlg.DisplayImagePropertis;
begin
     lbImageSize.Caption:=Format('Dimensiunea imaginii: %dx%d',[imgIMAGE.Picture.Width,imgIMAGE.Picture.Height]);
end;

procedure TfrmGoodsImageEditorDlg.GetData(const Stream: TMemoryStream);
begin
     Stream.Clear;
     imgIMAGE.Picture.Graphic.SaveToStream(Stream);
end;

procedure TfrmGoodsImageEditorDlg.imgIMAGEPropertiesChange(Sender: TObject);
begin
     DisplayImagePropertis;
end;

procedure TfrmGoodsImageEditorDlg.LoadGIFImage(const FileName: String);
begin

end;

procedure TfrmGoodsImageEditorDlg.LoadJPEGImage(const FileName: String);
var jpg:TJPEGImage;
begin
     jpg:=TJPEGImage.Create;
     try
        jpg.LoadFromFile(FileName);
        imgIMAGE.Picture.Graphic.Assign(jpg);
     finally
        jpg.Free;
     end;
end;

end.
