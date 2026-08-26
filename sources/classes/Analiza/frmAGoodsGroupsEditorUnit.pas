unit frmAGoodsGroupsEditorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxLabel, cxTextEdit, cxDBEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls;

type
  TfrmAGoodsGroupsEditorDlg = class(TSWNMasteredFormClass)
    Panel1: TPanel;
    cxLabel1: TcxLabel;
    teTITLE: TcxDBTextEdit;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure Prepare; override;
    procedure BindingDataSource; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    IsNewRecord: Boolean;
  end;

var
  frmAGoodsGroupsEditorDlg: TfrmAGoodsGroupsEditorDlg;

implementation

{$R *.dfm}

uses db;

{ TfrmAGoodsGroupsEditorDlg }

procedure TfrmAGoodsGroupsEditorDlg.BindingDataSource;
begin
  teTITLE.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmAGoodsGroupsEditorDlg.IsFormDataPosted: Boolean;
begin

  try
  if fMasterDataSet.State in [dsEdit, dsInsert] then
    fMasterDataSet.Post;

  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Commit;
  Result := True;
  except on E: Exception do
  begin
    Result := False;
    raise Exception.Create('Eroare la salvarea informatiei');
  end;
  end;
end;

procedure TfrmAGoodsGroupsEditorDlg.Prepare;
begin
  inherited;
  if IsNewRecord then
    fMasterDataSet.Append
  else
    fMasterDataSet.Edit;
end;

procedure TfrmAGoodsGroupsEditorDlg.WhenCancelForm;
begin
 if fMasterDataSet.State in [dsEdit, dsInsert] then
    fMasterDataSet.Cancel;

  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
