unit frmBlogEditorDialog;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxContainer, cxEdit, dxBarBuiltInMenu, SynEdit, SynDBEdit, cxPC, cxImage,
    cxDBEdit, cxTextEdit, cxLabel, Vcl.ExtCtrls, SynEditHighlighter, SynHighlighterHtml, Vcl.Menus,
    Vcl.StdCtrls, cxButtons, dxUIAClasses;

type
    TfrmBlogEditorDlg = class(TSWNMasteredFormClass)
        Panel1: TPanel;
        Panel2: TPanel;
        cxLabel1: TcxLabel;
        edtTitleRo: TcxDBTextEdit;
        cxLabel2: TcxLabel;
        edtTitleRu: TcxDBTextEdit;
        img_ro: TcxDBImage;
        img_ru: TcxDBImage;
        cxPageControl1: TcxPageControl;
        cxTabSheet1: TcxTabSheet;
        cxTabSheet2: TcxTabSheet;
        edsArticleRo: TDBSynEdit;
        SynHTMLSyn1: TSynHTMLSyn;
        edsArticleRu: TDBSynEdit;
        cxLabel3: TcxLabel;
        cxLabel4: TcxLabel;
        cxButton1: TcxButton;
        cxButton2: TcxButton;
    private    { Private declarations }
        FNewRecord: Boolean;
    protected
        procedure BindingDataSource; override;
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    public    { Public declarations }
        property NewRecord: Boolean read FNewRecord write FNewRecord;
    end;

var
    frmBlogEditorDlg: TfrmBlogEditorDlg;


implementation

uses
    Data.DB;

{$R *.dfm}

{ TfrmBlogEditorDlg }

procedure TfrmBlogEditorDlg.BindingDataSource;
begin
    inherited;
    edsArticleRo.DataSource := fMasterDataSource;
    edsArticleRo.DataField := 'Article_RO';
    edsArticleRu.DataSource := fMasterDataSource;
    edsArticleRu.DataField := 'Article_Ru';
    edtTitleRo.DataBinding.DataSource := fMasterDataSource;
    edtTitleRu.DataBinding.DataSource := fMasterDataSource;
    img_ro.DataBinding.DataSource := fMasterDataSource;
    img_ru.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmBlogEditorDlg.IsFormDataPosted: Boolean;
begin
    Result := False;
    try
        if MasterDataSet.State in dsEditModes then
            fmasterDataSet.Post;
        if fMasterDataSet.UpdateTransaction.Active then
            fMasterDataSet.UpdateTransaction.Commit;

        Result := True;
    except
        begin
            Result := false;
            raise;
        end;
    end;

end;

procedure TfrmBlogEditorDlg.Prepare;
begin
    inherited;
    if NewRecord then
    begin
        fMasterDataSet.Append;
        fMasterDataSet.FieldByName('DATA').AsDateTime := Date;
    end
    else
        fMasterDataSet.Edit;
end;

procedure TfrmBlogEditorDlg.WhenCancelForm;
begin
    inherited;
    if fMasterDataSet.State in dsEditModes then
        fMasterDataSet.Cancel;
    if fMasterDataSet.UpdateTransaction.Active then
        fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

