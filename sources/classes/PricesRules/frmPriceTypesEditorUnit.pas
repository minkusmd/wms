unit frmPriceTypesEditorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxTextEdit, cxDBEdit, cxLabel, DialogTitle;

type
  TfrmPriceTypesEditorDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    cxLabel1: TcxLabel;
    tePGT_ID: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    teTitle: TcxDBTextEdit;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
  private
    FIsNewRecord: Boolean;
    procedure SetIsNewRecord(const Value: Boolean);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property IsNewRecord: Boolean read FIsNewRecord write SetIsNewRecord;
    { Public declarations }
  end;

var
  frmPriceTypesEditorDlg: TfrmPriceTypesEditorDlg;

implementation

uses
  DataModuleAdditions, DB;

{$R *.dfm}

{ TfrmPriceTypesEditorDlg }

function TfrmPriceTypesEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  try
    if fMasterDataSet.State in [dsEdit, dsInsert] then
      fMasterDataSet.Post;
  except
    on e: Exception do
    begin
      Result := False;
      raise;
    end;
  end;
end;

procedure TfrmPriceTypesEditorDlg.Prepare;
begin
  if IsNewRecord then
    fMasterDataSet.Insert
  else
    fMasterDataSet.Edit;

  tePGT_ID.DataBinding.DataSource := fMasterDataSource;
  tePGT_ID.DataBinding.DataField := 'PGT_ID';
  tePGT_ID.Enabled := True;

  teTitle.DataBinding.DataSource := fMasterDataSource;
  teTitle.DataBinding.DataField := 'TITLE';
end;

procedure TfrmPriceTypesEditorDlg.SetIsNewRecord(const Value: Boolean);
begin
  FIsNewRecord := Value;
end;

procedure TfrmPriceTypesEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in [dsEdit, dsinsert] then
    fMasterDataSet.Cancel;
end;

end.

