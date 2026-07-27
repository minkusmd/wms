unit frmBrandsImagesDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer,
  cxEdit, Data.DB, MemDS, DBAccess, IBC, cxImage, cxDBEdit, Vcl.ExtCtrls, Vcl.StdCtrls, cxButtons, DialogTitle, cxLabel;

type
  TfrmBrandsImagesDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    Panel1: TPanel;
    cxDBImage1: TcxDBImage;
    IBCDataSourceBrandsImage: TIBCDataSource;
    IBCQueryBrandsImage: TIBCQuery;
    cxLabel1: TcxLabel;
    procedure IBCQueryBrandsImageAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  protected
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmBrandsImagesDlg: TfrmBrandsImagesDlg;

implementation

uses
  DataModuleAdditions, DataModuleDB;

{$R *.dfm}

{ TfrmBrandsImagesDlg }

procedure TfrmBrandsImagesDlg.IBCQueryBrandsImageAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('BRANDID').AsInteger := fMasterDataSet.FieldByName('SYSSID').AsInteger;
end;

function TfrmBrandsImagesDlg.IsFormDataPosted: Boolean;
begin
//  Result := False;
  try
    if IBCQueryBrandsImage.State in [dsEdit, dsInsert] then
    begin
      IBCQueryBrandsImage.Post;
      if IBCQueryBrandsImage.UpdateTransaction.Active then
        IBCQueryBrandsImage.UpdateTransaction.Commit;
    end;
    Result := True;
  except
    on e: Exception do
    begin
      WhenCancelForm;
      raise e;
    end
  end
end;

procedure TfrmBrandsImagesDlg.Prepare;
begin
  inherited;
  IBCQueryBrandsImage.Close;
  IBCQueryBrandsImage.ParamByName('SYSSID').AsInteger := fMasterDataSet.FieldByName('SYSSID').AsInteger;
  IBCQueryBrandsImage.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryBrandsImage.Open;

end;

procedure TfrmBrandsImagesDlg.WhenCancelForm;
begin
  inherited;
  if IBCQueryBrandsImage.State in [dsEdit, dsInsert] then
    IBCQueryBrandsImage.Cancel;
  if IBCQueryBrandsImage.UpdateTransaction.Active then
    IBCQueryBrandsImage.UpdateTransaction.Rollback;
end;

end.

