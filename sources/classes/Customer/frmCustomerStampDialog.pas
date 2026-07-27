unit frmCustomerStampDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, StdCtrls, cxDBEdit, ExtCtrls, DialogTitle, DB, IBC, MemDS,
  cxPC, cxButtons, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, DBAccess, cxImage;

type
  TfCustomerStampDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    IBCQueryStamp: TIBCQuery;
    IBCDataSourceStamp: TIBCDataSource;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    Label5: TLabel;
    imageLOGO: TcxDBImage;
    imageSTAMP_IMAGE: TcxDBImage;
    Label6: TLabel;
    lbLogoSize: TLabel;
    lbStamSize: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    cxDBImage1: TcxDBImage;
    cxDBImage2: TcxDBImage;
    Label4: TLabel;
    Label1: TLabel;
    lbSignatureSize: TLabel;
    ImageSignature: TcxDBImage;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure imgStampPropertiesAssignPicture(Sender: TObject; const Picture: TPicture);
    procedure imageLOGOPropertiesAssignPicture(Sender: TObject; const Picture: TPicture);
    procedure cxDBImage1PropertiesAssignPicture(Sender: TObject; const Picture: TPicture);
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;

    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
  end;


implementation



{$R *.dfm}

{ TfCustomerStampDlg }

procedure TfCustomerStampDlg.cxDBImage1PropertiesAssignPicture(Sender: TObject; const Picture: TPicture);
begin
     lbSignatureSize.Caption:=Format('Размер: %d x %d',[Picture.Width,Picture.Height]);
end;

procedure TfCustomerStampDlg.imageLOGOPropertiesAssignPicture(Sender: TObject; const Picture: TPicture);
begin
     lbLogoSize.Caption:=Format('Размер: %d x %d',[Picture.Width,Picture.Height]);
end;

procedure TfCustomerStampDlg.imgStampPropertiesAssignPicture(Sender: TObject; const Picture: TPicture);
begin
     lbStamSize.Caption:=Format('Размер: %d x %d',[Picture.Width,Picture.Height]);
end;

procedure TfCustomerStampDlg.BindingDataSource;
begin
     inherited;

     IBCQueryStamp.MasterSource:=fMasterDataSource;
     IBCQueryStamp.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
end;

function TfCustomerStampDlg.IsFormDataPosted: Boolean;
begin
     IBCQueryStamp.Post;
     IBCQueryStamp.UpdateTransaction.Commit;
     Result:=True;
end;

procedure TfCustomerStampDlg.Prepare;
var
  fStamp: Boolean;
begin
     IBCQueryStamp.Active:=True;
     IBCQueryStamp.UpdateTransaction.StartTransaction;
     try
        if IBCQueryStamp.Eof then
        begin
             IBCQueryStamp.Insert;
        end
        else
        begin
             IBCQueryStamp.Edit;
        end;

        fStamp := True;//fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4002;
        imageLOGO.Enabled := fStamp;
        imageSTAMP_IMAGE.Enabled := fStamp;

        lbLogoSize.Caption:=Format('Размер: %d x %d',[imageLOGO.Picture.Width,imageLOGO.Picture.Height]);
        lbStamSize.Caption:=Format('Размер: %d x %d',[imageSTAMP_IMAGE.Picture.Width,imageSTAMP_IMAGE.Picture.Height]);
        lbSignatureSize.Caption:=Format('Размер: %d x %d',[ImageSIGNATURE.Picture.Width,ImageSIGNATURE.Picture.Height]);

        Panel1.Visible := (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4002);
        if Panel1.Visible then
          Height := 520
        else
          Height := 330;

     except
        IBCQueryStamp.Cancel;
        IBCQueryStamp.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfCustomerStampDlg.WhenCancelForm;
begin
     IBCQueryStamp.Cancel;
     IBCQueryStamp.UpdateTransaction.Rollback;
end;

end.
