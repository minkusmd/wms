unit frmWebUrlsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, dxBar, cxClasses, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid,
  DBAccess, IBC, MemDS, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmWebUrlsDialog = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    Button2: TButton;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbNewURL: TdxBarButton;
    bbModifyURL: TdxBarButton;
    bbDeleteURL: TdxBarButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1_URL_ID: TcxGridDBColumn;
    cxGrid1DBTableView1_TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1_FLG_ACTIVE: TcxGridDBColumn;
    cxGrid1DBTableView1_HUMAN_URL: TcxGridDBColumn;
    cxGrid1DBTableView1_URL: TcxGridDBColumn;
    IBCQuerySeoURL: TIBCQuery;
    IBCDataSourceSeoURL: TIBCDataSource;
    procedure bbNewURLClick(Sender: TObject);
    procedure bbModifyURLClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure AddSeoURL(ANewRecord: Boolean);
  public
    { Public declarations }
  end;

var
  frmWebUrlsDialog: TfrmWebUrlsDialog;

implementation

uses
  DataModuleAdditions, frmWebUrlsEditorUnit;

{$R *.dfm}

procedure TfrmWebUrlsDialog.AddSeoURL(ANewRecord: Boolean);
var
  dialog:   TfrmWebUrlsEditorDialog;
begin
   dialog :=   TfrmWebUrlsEditorDialog.Create(Self, IBCQuerySeoURL, IBCDataSourceSeoURL);
end;

procedure TfrmWebUrlsDialog.bbModifyURLClick(Sender: TObject);
begin
    AddSeoURL(False);
end;

procedure TfrmWebUrlsDialog.bbNewURLClick(Sender: TObject);
begin
  AddSeoURL(True);
end;

end.
