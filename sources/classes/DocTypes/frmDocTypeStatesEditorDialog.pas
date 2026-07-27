unit frmDocTypeStatesEditorDialog;

interface

uses
  SWNBaseUnit, cxCalc, cxContainer, cxControls, cxDBEdit, cxDropDownEdit, cxEdit, cxGraphics, cxLabel,
  cxLookAndFeelPainters, cxLookAndFeels, cxMaskEdit, cxTextEdit,

  Data.DB,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,

  Winapi.Messages,
  Winapi.Windows;

type
  TfrmDocTypeStatesEditorDlg = class(TSWNMasteredFormClass)
    btnOK: TButton;
    btnCancel: TButton;
    Panel1: TPanel;
    teTitle: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    lbP1: TcxLabel;
    teIntVal: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    teStrVal: TcxDBTextEdit;
    teOrderNO: TcxDBTextEdit;
    cxLabel3: TcxLabel;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    DocTypeID: Integer;
    IsNewRecord: Boolean;
    { Public declarations }
  end;

var
  frmDocTypeStatesEditorDlg: TfrmDocTypeStatesEditorDlg;

implementation

{$R *.dfm}

function TfrmDocTypeStatesEditorDlg.IsFormDataPosted: Boolean;
begin
//  Result := False;
  try
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Post;

    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Commit;

    Result := True;
  except on E: Exception do
  begin
    Result := False;
    MessageDlg('Eroare la salvarea datelor'+#13#10+E.Message, mtError, [mbOK], 0);
  end;
  end;
end;

procedure TfrmDocTypeStatesEditorDlg.Prepare;
begin
  if not fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.StartTransaction;

  if IsNewRecord then
  begin
    fMasterDataSet.Append;
    fMasterDataSet.FieldByName('DOCTYPEID').AsInteger := DOCTYPEID;
  end
  else
    fMasterDataSet.Edit;

  teTitle.DataBinding.DataSource := fMasterDataSource;
  teTitle.DataBinding.DataField := 'TITLE';
  teIntVal.DataBinding.DataSource := fMasterDataSource;
  teIntVal.DataBinding.DataField := 'INT_VALUE';
  teStrVal.DataBinding.DataSource := fMasterDataSource;
  teStrVal.DataBinding.DataField := 'STR_VALUE';
  teOrderNO.DataBinding.DataSource := fMasterDataSource;
  teOrderNO.DataBinding.DataField := 'ORDERNO';
end;

procedure TfrmDocTypeStatesEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;

  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

