unit frmGoodsGroupReports;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar, cxClasses, Vcl.StdCtrls, Vcl.ExtCtrls,
  DialogTitle, DBAccess, IBC, MemDS, dxScrollbarAnnotations;

type
  TfrmGoodsGroupReportsDlg = class(TSWNBaseFormClass)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DialogTitle1: TDialogTitle;
    Splitter1: TSplitter;
    Button1: TButton;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    bbRGNew: TdxBarButton;
    bbRGEdit: TdxBarButton;
    bbRGDelete: TdxBarButton;
    bbGGNew: TdxBarButton;
    bbGGDelete: TdxBarButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    IBCQueryGoodsGroups: TIBCQuery;
    IBCDataSourceGoodsGroups: TIBCDataSource;
    cxGrid1DBTableView1RPGROUPID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    procedure bbRGNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const IBCConnection: TIBCConnection); override;
  end;

var
  frmGoodsGroupReportsDlg: TfrmGoodsGroupReportsDlg;

implementation

uses
   DataModuleAdditions;

{$R *.dfm}

{ TfrmGoodsGroupReportsDlg }


{ TfrmGoodsGroupReportsDlg }

procedure TfrmGoodsGroupReportsDlg.bbRGNewClick(Sender: TObject);
//var
//   dialog: TfrmGoodsGroupEditorDlg;
begin
//  dialog := TfrmGoodsGroupEditorDlg.Create(Self, TcxGridItemDataBinding.ibcconnection);
//  try
//     dialog.ShowModal;
//  finally
//      dialog.Free;
//  end;
end;

constructor TfrmGoodsGroupReportsDlg.Create(const AOwner: TComponent; const IBCConnection: TIBCConnection);
begin
//  inherited;
//  IBCQuery1.Connection := IBCConnection;

end;

end.
