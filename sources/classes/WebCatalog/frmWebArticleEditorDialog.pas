unit frmWebArticleEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxLabel, cxTextEdit, cxDBEdit, dxBarBuiltInMenu, SynEditHighlighter, SynHighlighterHtml, SynEdit,
  SynDBEdit, cxPC, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxMemo;

type
  TfrmWebArticleEditorDlg = class(TSWNMasteredFormClass)
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    synEditRo: TDBSynEdit;
    cxTabSheet2: TcxTabSheet;
    synEditRu: TDBSynEdit;
    SynHTMLSyn1: TSynHTMLSyn;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    teTitleRo: TcxDBMemo;
    teTitleRu: TcxDBMemo;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    procedure BindingDataSource; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    IsNewRecord: Boolean;
    { Public declarations }

  end;

var
  frmWebArticleEditorDlg: TfrmWebArticleEditorDlg;

implementation

uses DB;

{$R *.dfm}

{ TfrmWebArticleEditorDlg }

procedure TfrmWebArticleEditorDlg.BindingDataSource;
begin
  inherited;
  synEditRo.DataSource := fMasterDataSource;
  synEditRu.DataSource := fMasterDataSource;

  teTitleRo.DataBinding.DataSource := fMasterDataSource;
  teTitleRu.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmWebArticleEditorDlg.IsFormDataPosted: Boolean;
begin
  try
    if (fMasterDataSet.State in [dsInsert, dsEdit]) then begin
      fMasterDataSet.Post;
      if (fMasterDataSet.UpdateTransaction.Active) then
      fMasterDataSet.UpdateTransaction.Commit;
      Result := True;
    end;

  except begin

      if (fMasterDataSet.UpdateTransaction.Active) then
      fMasterDataSet.UpdateTransaction.Rollback;
  end;

  end;

end;

procedure TfrmWebArticleEditorDlg.Prepare;
begin
    if IsNewRecord then
    begin
        fMasterDataSet.Append;
        MasterDataSet.FieldByName('CREATED_DATE').AsDateTime := Now;
    end
    else
    begin
        fMasterDataSet.Edit;
    end;

end;

procedure TfrmWebArticleEditorDlg.WhenCancelForm;
begin
  inherited;
    if (fMasterDataSet.UpdateTransaction.Active) then
      fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
