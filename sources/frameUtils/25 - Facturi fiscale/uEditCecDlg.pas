unit uEditCecDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalc, cxDBEdit, cxLabel;

type
  TfrmEditCecDlg = class(TSWNMasteredFormClass)
    bntOK: TcxButton;
    cxLabel1: TcxLabel;
    cxDBCecEdit: TcxDBCalcEdit;
    cxButton1: TcxButton;
  private
    { Private declarations }
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
  end;

var
  frmEditCecDlg: TfrmEditCecDlg;

implementation

uses
  DB;

{$R *.dfm}

{ TfrmEditCecDlg }

procedure TfrmEditCecDlg.BindingDataSource;
begin
  inherited;
  cxDBCecEdit.DataBinding.DataSource := MasterDataSource;
  cxDBCecEdit.DataBinding.DataField := 'PRIHOD_DOCID';
end;

function TfrmEditCecDlg.IsFormDataPosted: Boolean;
begin
  if MasterDataSet.State in [dsEdit, dsInsert] then
    MasterDataSet.Post;

  if MasterDataSet.UpdateTransaction.Active then
    MasterDataSet.UpdateTransaction.Commit;
  Result := True;
end;

procedure TfrmEditCecDlg.Prepare;
begin
  inherited;

end;

procedure TfrmEditCecDlg.WhenCancelForm;
begin
  inherited;
  if MasterDataSet.State in [dsEdit, dsInsert] then
    MasterDataSet.Cancel;
  if MasterDataSet.UpdateTransaction.Active then
    MasterDataSet.UpdateTransaction.Rollback;
end;

end.
