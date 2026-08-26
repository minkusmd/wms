unit frmGoodsImageViewerUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxImage, cxDBEdit, IBC, Data.DB, DBAccess, MemDS;

type
  TfrmGoodsImageViewer = class(TForm)
    cxDBImage1: TcxDBImage;
    IBCQueryGoodsImage: TIBCQuery;
    IBCDataSourceGoodsImage: TIBCDataSource;
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FConnection: TIBCConnection;
    FMasterDataSource: TIBCDataSource;
    FMasterFields: String;
    procedure SetConnection(const Value: TIBCConnection);
    procedure SetMasterDataSource(const Value: TIBCDataSource);
    procedure SetMasterFields(const Value: String);
    { Private declarations }
  public
    { Public declarations }
  published
    property Connection: TIBCConnection read FConnection write SetConnection;
    property MasterDataSource: TIBCDataSource read FMasterDataSource write
        SetMasterDataSource;
    property MasterFields: String read FMasterFields write SetMasterFields;
  end;

var
  frmGoodsImageViewer: TfrmGoodsImageViewer;

implementation

{$R *.dfm}

procedure TfrmGoodsImageViewer.FormDestroy(Sender: TObject);
begin
  if Assigned(frmGoodsImageViewer) then
    frmGoodsImageViewer.Free;
end;

procedure TfrmGoodsImageViewer.FormHide(Sender: TObject);
begin
  IBCQueryGoodsImage.Close;
end;

procedure TfrmGoodsImageViewer.FormShow(Sender: TObject);
begin
  if not IBCQueryGoodsImage.Active then
  begin
    IBCQueryGoodsImage.DetailFields := 'GOODSID';
    IBCQueryGoodsImage.MasterFields := fMasterFields;
    IBCQueryGoodsImage.MasterSource := FMasterDataSource;
    IBCQueryGoodsImage.Open;
  end;
end;

procedure TfrmGoodsImageViewer.SetConnection(const Value: TIBCConnection);
begin
    FConnection := Value;
end;

procedure TfrmGoodsImageViewer.SetMasterDataSource(const Value: TIBCDataSource);
begin
    FMasterDataSource := Value;
end;

procedure TfrmGoodsImageViewer.SetMasterFields(const Value: String);
begin
    FMasterFields := Value;
end;


end.
