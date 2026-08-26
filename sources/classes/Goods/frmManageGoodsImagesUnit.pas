unit frmManageGoodsImagesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNBaseUnit, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, Vcl.NumberBox,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalc, cxLabel, cxPC, Vcl.ExtCtrls,
  Vcl.Menus, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData, dxBevel,
  cxImage, cxDBEdit, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxButtons,
  MemDS, DBAccess, IBC;

type
  TfrmManageGoodsImages = class(TSWNBaseFormClass)
    cxPageControl1: TcxPageControl;
    Panel1: TPanel;
    tbsResizeGoodsImages: TcxTabSheet;
    cxLabel1: TcxLabel;
    ceImageSize: TcxCalcEdit;
    cxButton1: TcxButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxDBImage1: TcxDBImage;
    dxBevel1: TdxBevel;
    Bevel1: TBevel;
    dxBevel2: TdxBevel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    lbImageWeight: TLabel;
    lbImageHeight: TLabel;
    lbImageSize: TLabel;
    IBCQueryGoodsImages: TIBCQuery;
    IBCDataSourceGoodsImages: TIBCDataSource;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxButton2: TcxButton;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    IBCTransaction1: TIBCTransaction;
    cxButton3: TcxButton;
    IBCQueryImages: TIBCQuery;
    IBCDataSourceImages: TIBCDataSource;
    cxButton4: TcxButton;
    procedure cxGrid1DBTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxDBImage1PropertiesAssignPicture(Sender: TObject; const Picture: TPicture);
  private
    { Private declarations }
    procedure ResizePngImage;

  protected
    procedure Prepare; override;
  public
    procedure UpdateImageInfo;
    { Public declarations }
  end;

var
  frmManageGoodsImages: TfrmManageGoodsImages;

implementation

uses
  Vcl.Imaging.pngimage, SWNUtils,
  dxGDIPlusClasses,
  dxSmartImage;

{$R *.dfm}


procedure TfrmManageGoodsImages.cxButton1Click(Sender: TObject);
begin
  IBCQueryGoodsImages.Close;
  IBCQueryGoodsImages.ParamByName('max_image_size').AsFloat := ceImageSize.Value;
  IBCQueryGoodsImages.Open;
  IBCQueryImages.Open;
end;

procedure TfrmManageGoodsImages.cxButton2Click(Sender: TObject);
begin
  ResizePngImage;
end;

procedure TfrmManageGoodsImages.cxButton3Click(Sender: TObject);
begin
  while not ibcquerygoodsimages.eof do begin
    ResizePngImage;
    application.ProcessMessages;
    ibcquerygoodsimages.next;
  end;
end;

procedure TfrmManageGoodsImages.cxDBImage1PropertiesAssignPicture(Sender: TObject; const Picture: TPicture);
begin
  ShowMessage('On Assign picture!');
end;

procedure TfrmManageGoodsImages.cxGrid1DBTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  UpdateImageInfo;
end;

procedure TfrmManageGoodsImages.Prepare;
begin
  inherited;
  IBCTransaction1.DefaultConnection := fIBCConnection;
end;

procedure TfrmManageGoodsImages.UpdateImageInfo;
var
  ImageSize: Integer;
begin
  lbImageSize.Caption := format('%d Kb', [0]);
  lbImageWeight.Caption := Format('%d px', [0]);
  lbImageHeight.Caption := Format('%d px', [0]);
end;

procedure TfrmManageGoodsImages.ResizePngImage;
var
  ms: TMemoryStream;
  png: TdxPngImage;
  MaxHeight: Integer;
  Bitmap: TcxAlphaBitmap;
  NewBitMap: TcxAlphaBitmap;

begin
  ms := TMemoryStream.Create;
  Bitmap := TcxAlphaBitMap.Create;
  png := TdxPNGImage.Create;
  try
    MaxHeight := 1000;
    TBlobField(IBCQueryImages.FieldByName('image')).SaveToStream(ms);
    ms.Position := 0;
    png.LoadFromStream(ms);
    Bitmap.Assign(png);

      NewBitMap := TcxAlphaBitmap.Create;
      try
        if Bitmap.Height > bitMap.Width then begin
          // imagine verticala
          NewBitMap.Height := MaxHeight;
          NewBitMap.Width := MulDiv(MaxHeight, Bitmap.Width, Bitmap.Height);
        end
        else if Bitmap.Height <= bitMap.Width then begin
          // imagine orizontala
          NewBitMap.Width := MaxHeight;
          NewBitMap.Height:= MulDiv(MaxHeight, Bitmap.Height, Bitmap.Width);
        end;

        cxSmoothResizeBitmap(BitMap, NewBitMap, true);
        png.SetBitmap(NewBitMap);

        ms.Clear;
        png.SaveToStream(ms);
        ibcqueryimages.Edit;
        tblobfield(ibcqueryimages.FieldByName('image')).loadfromstream(ms);
        ibcqueryimages.Post;
      finally
        NewBitMap.Free;
      end;
  finally
    png.Free;
    ms.Free;
    Bitmap.Free;
  end;
end;

end.

