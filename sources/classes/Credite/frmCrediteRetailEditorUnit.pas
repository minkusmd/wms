unit frmCrediteRetailEditorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, Vcl.StdCtrls, Vcl.Menus, cxMaskEdit, cxDropDownEdit, cxCalc, cxButtons, Vcl.ExtCtrls,
  SWNBaseUnit;

type
  TfrmCrediteRetailEditorDlg = class(TSWNMasteredFormClass)
    Panel1: TPanel;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edTitleRo: TcxDBTextEdit;
    edTitleRu: TcxDBTextEdit;
    Label3: TLabel;
    ceCost: TcxDBCalcEdit;
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure Prepare; override;
    procedure BindingDataSource; override;
    function IsFormDataPosted: boolean; override;
    procedure WhenCancelForm; override;
  public
    IsNewRecord: Boolean;
    { Public declarations }
  end;

var
  frmCrediteRetailEditorDlg: TfrmCrediteRetailEditorDlg;

implementation

uses
  Data.DB;

{$R *.dfm}

{ TfrmCrediteRetailEditorDlg }

procedure TfrmCrediteRetailEditorDlg.BindingDataSource;
begin
  edTitleRo.DataBinding.DataSource := fMasterDataSource;
  edTitleRo.DataBinding.DataField := 'TITLE_RO';
  edTitleRu.DataBinding.DataSource := fMasterDataSource;
  edTitleRu.DataBinding.DataField := 'TITLE_RU';
  ceCost.DataBinding.DataSource := fMasterDataSource;
  ceCost.DataBinding.DataField := 'COST';
end;

function TfrmCrediteRetailEditorDlg.IsFormDataPosted: boolean;
begin
  Result := True;
  try
    if fMasterDataSet.State in dsEditmodes then
      fMasterDataSet.Post;
    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Commit;
  except on E: Exception do
  begin
    Result := False;
    raise;
  end;
  end;
end;

procedure TfrmCrediteRetailEditorDlg.Prepare;
begin
  if IsNewRecord then begin
    fMasterDataSet.Append;
  end
  else
    fMasterDataSet.Edit;

end;

procedure TfrmCrediteRetailEditorDlg.WhenCancelForm;
begin
    if fMasterDataSet.State in dsEditmodes then
      fMasterDataSet.Cancel;
    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Rollback
end;

end.
