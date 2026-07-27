unit frmWebCatalogImageDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxImage, cxDBEdit, Vcl.StdCtrls, Data.DB,
  DBAccess, IBC, MemDS, dxUIAClasses;

type
  TfrmWebCatalogImageDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
    btnDelete: TButton;
    IBCQueryImage: TIBCQuery;
    IBCDataSourceImage: TIBCDataSource;
    imgBIG_IMAGE: TcxDBImage;
    Label19: TLabel;
    imgIMAGE: TcxDBImage;
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions;

{ TForm2 }

procedure TfrmWebCatalogImageDlg.btnDeleteClick(Sender: TObject);
begin
  IBCQueryImage.Delete;
  ModalResult := mrOK;
end;

procedure TfrmWebCatalogImageDlg.BindingDataSource;
begin
  IBCQueryImage.MasterSource := fMasterDataSource;
  IBCQueryImage.Transaction := fMasterDataSet.UpdateTransaction;
  IBCQueryImage.UpdateTransaction := fMasterDataSet.UpdateTransaction;
end;

function TfrmWebCatalogImageDlg.IsFormDataPosted: Boolean;
begin
  if IBCQueryImage.State in dsEditModes then
    IBCQueryImage.Post;
  IBCQueryImage.UpdateTransaction.Commit;
  Result := True;
end;

procedure TfrmWebCatalogImageDlg.Prepare;
begin
  IBCQueryImage.UpdateTransaction.StartTransaction;
  try
    IBCQueryImage.Active := True;
    if IBCQueryImage.Eof then
    begin
      dtDialogTitle.Text := 'Adaugare imagine';
      btnDelete.Visible := False;
      IBCQueryImage.Insert;
      IBCQueryImage.FieldByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
    end
    else
    begin
      dtDialogTitle.Text := 'Modificare imagine';
      IBCQueryImage.Edit;
    end;
  except
    IBCQueryImage.Cancel;
    IBCQueryImage.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmWebCatalogImageDlg.WhenCancelForm;
begin
  if IBCQueryImage.State in dsEditModes then
    IBCQueryImage.Cancel;
  IBCQueryImage.UpdateTransaction.Rollback;
end;

end.
