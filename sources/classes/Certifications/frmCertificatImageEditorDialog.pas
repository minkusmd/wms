unit frmCertificatImageEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, StdCtrls,
  cxDBEdit, IBC, DB, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, DBAccess, MemDS, cxImage;

type
  TfrmCertificatImageEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label2: TLabel;
    IBCQueryImage: TIBCQuery;
    IBCDataSourceImage: TIBCDataSource;
    ScrollBox1: TScrollBox;
    cxDBImage: TcxDBImage;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    fCertificatID: integer;
    FCreateNewImage: Boolean;
    procedure SetCreateNewImage(const Value: Boolean);
    function CheckParams:Boolean;
    procedure GenerateThumbImage;
    procedure SetCertificatID(const Value: integer);

  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewImage:Boolean read FCreateNewImage write SetCreateNewImage;
    property CertificatID:integer read FCertificatID write SetCertificatID;
  end;



implementation

uses SWNUtils, SWNConst, JPEG;

{$R *.dfm}

{ TfrmCertificatImageEditorDlg }

function TfrmCertificatImageEditorDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;

     if IBCQueryImage.FieldByName('IMAGE').IsNull then AddErrorToStr(ErrorStr,'Фото сертификата!');

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmCertificatImageEditorDlg.GenerateThumbImage;
var jpeg:TJPEGImage;
    bmp:TBitmap;
    w,h:integer;
    mm:Double;
    MS:TMemoryStream;
begin
     jpeg:=TJPEGImage.Create;
     bmp:=TBitmap.Create;

     try
        bmp.Height:=96;
        jpeg.Assign(cxDBImage.Picture);
        w:=jpeg.Width;
        h:=jpeg.Height;
        mm:=h/96;
        bmp.Width:=round(w/mm);
        bmp.Canvas.StretchDraw(rect(0,0,bmp.Width,bmp.Height),jpeg);
        jpeg.Assign(bmp);
        jpeg.JPEGNeeded;
        MS:=TMemoryStream.Create;
        try
           jpeg.SaveToStream(MS);
           MS.Position:=0;
           TBlobField(IBCQueryImage.FieldByName('IMAGE_THUMB')).LoadFromStream(MS);
        finally
           MS.Free;
        end;
     finally
        jpeg.Free;
        bmp.Free;
     end;

end;

procedure TfrmCertificatImageEditorDlg.BindingDataSource;
begin
     inherited;
     FCreateNewImage := false;
     FCertificatID := -1;

     IBCQueryImage.Connection:=fMasterDataSet.Connection;
     IBCQueryImage.Transaction:=fMasterDataSet.Transaction;
     IBCQueryImage.ParamByName('imgID').AsInteger:=fMasterDataSet.FieldByName('IMAGEID').AsInteger;
end;

function TfrmCertificatImageEditorDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          GenerateThumbImage;
          IBCQueryImage.Post;
          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmCertificatImageEditorDlg.Prepare;
begin
     inherited;

     IBCQueryImage.ParamByName('certID').AsInteger:=FCertificatID;
     IBCQueryImage.Active:=True;

     if FCreateNewImage then
     begin
          dtDialogTitle.Text:='Salvarea imaginii certificatului';

          IBCQueryImage.Insert;
          IBCQueryImage.FieldByName('CERTIFICATID').AsInteger:=FCertificatID;
     end
     else
     begin
          dtDialogTitle.Text:='Modificarea imaginii certificatului';

          IBCQueryImage.Edit;
     end;
end;

procedure TfrmCertificatImageEditorDlg.SetCertificatID(const Value: integer);
begin
     FCertificatID := Value;
end;

procedure TfrmCertificatImageEditorDlg.SetCreateNewImage(const Value: Boolean);
begin
     FCreateNewImage := Value;
end;

procedure TfrmCertificatImageEditorDlg.WhenCancelForm;
begin
     IBCQueryImage.Cancel;
end;

end.
