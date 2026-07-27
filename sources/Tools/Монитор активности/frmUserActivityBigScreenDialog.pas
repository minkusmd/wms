unit frmUserActivityBigScreenDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxImage, cxDBEdit;

type
  TfrmUserActivityBigScreenDlg = class(TSWNMasteredFormClass)
    ScrollBox1: TScrollBox;
    imgIMAGE: TcxDBImage;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgIMAGEKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FOnPrevImage: TNotifyEvent;
    FOnNextImage: TNotifyEvent;
    { Private declarations }
    procedure ShowNextImage;
    procedure ShowPrevImage;
    procedure SetOnNextImage(const Value: TNotifyEvent);
    procedure SetOnPrevImage(const Value: TNotifyEvent);
  protected
    { protected declarations }
    procedure BindingDataSource;override;
  public
    { Public declarations }
    property OnNextImage:TNotifyEvent read FOnNextImage write SetOnNextImage;
    property OnPrevImage:TNotifyEvent read FOnPrevImage write SetOnPrevImage;
  end;


implementation

{$R *.dfm}

{ TfrmUserActivityBigScreenDlg }

procedure TfrmUserActivityBigScreenDlg.FormCreate(Sender: TObject);
begin
     FOnNextImage:=nil;
     FOnPrevImage:=nil;
end;

procedure TfrmUserActivityBigScreenDlg.FormDblClick(Sender: TObject);
begin
     ModalResult:=mrOK;
end;

procedure TfrmUserActivityBigScreenDlg.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if key=27 then ModalResult:=mrOk;
end;

procedure TfrmUserActivityBigScreenDlg.imgIMAGEKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if key=27 then ModalResult:=mrOk
     else
     if key=32 then ShowNextImage
     else
     if key=8 then ShowPrevImage;
end;

procedure TfrmUserActivityBigScreenDlg.BindingDataSource;
begin
     imgIMAGE.DataBinding.DataSource:=fMasterDataSource;
end;

procedure TfrmUserActivityBigScreenDlg.SetOnNextImage(const Value: TNotifyEvent);
begin
     FOnNextImage := Value;
end;

procedure TfrmUserActivityBigScreenDlg.SetOnPrevImage(const Value: TNotifyEvent);
begin
     FOnPrevImage := Value;
end;

procedure TfrmUserActivityBigScreenDlg.ShowNextImage;
begin
     if Assigned(FOnNextImage) then FOnNextImage(Self);
end;

procedure TfrmUserActivityBigScreenDlg.ShowPrevImage;
begin
     if Assigned(FOnPrevImage) then FOnPrevImage(Self);
end;

end.
