unit frmWebBlogDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  cxControls, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBAccess, IBC,
  MemDS, cxGridLevel, cxGridCustomView, cxGrid, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, dxBar, cxClasses, DialogTitle,
  dxUIAClasses;

type
  TfrmWebBlogDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    Panel1: TPanel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryBlog: TIBCQuery;
    IBCDataSourceBlog: TIBCDataSource;
    cxGrid1DBTableView1BLOGID: TcxGridDBColumn;
    cxGrid1DBTableView1DATA: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE_RO: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE_RU: TcxGridDBColumn;
    IBCTrLocal: TIBCTransaction;
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ShowBlogEditorDialog(ANewRecord: Boolean);
    procedure Prepare; override;
    { Protected declarations }
  public
    { Public declarations }
  end;

implementation

uses
    DataModuleAdditions, frmBlogEditorDialog;

{$R *.dfm}

procedure TfrmWebBlogDlg.bbDeleteClick(Sender: TObject);
begin
  if MessageDlg('Doriti sa stergeti inregistrarea?', mtConfirmation, [mbYes, mbNo],0)=mrYes then
    IBCQueryBlog.Delete;
end;

procedure TfrmWebBlogDlg.bbEditClick(Sender: TObject);
begin
  ShowBlogEditorDialog(False);
end;

procedure TfrmWebBlogDlg.bbNewClick(Sender: TObject);
begin
  ShowBlogEditorDialog(true);
end;

procedure TfrmWebBlogDlg.Prepare;
begin
    IBCTrLocal.DefaultConnection := fIBCConnection;
    IBCQueryBlog.Open;
end;

procedure TfrmWebBlogDlg.ShowBlogEditorDialog(ANewRecord: Boolean);
var
    dialog: TfrmBlogEditorDlg;
begin
    dialog := TfrmBlogEditorDlg.Create(Self, IBCQueryBlog, IBCDataSourceBlog);
    try
        dialog.NewRecord := ANewRecord;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

end.
