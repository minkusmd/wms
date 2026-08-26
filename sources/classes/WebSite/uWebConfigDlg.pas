unit uWebConfigDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Data.DB, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, Vcl.Menus,
  SynEditMiscClasses, SynEditSearch, SynEditHighlighter, SynEditCodeFolding, SynHighlighterJSON, SynEdit, DBAccess, IBC, MemDS,
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DialogTitle, SynDBEdit;

type
  TfrmWebConfigDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    Panel1: TPanel;
    cxButton1: TcxButton;
    IBCQueryWebSite: TIBCQuery;
    IBCDataSourceWebSite: TIBCDataSource;
    SynJSONSyn1: TSynJSONSyn;
    SynEditSearch1: TSynEditSearch;
    cxGrid1DBTableView1ID: TcxGridDBColumn;
    cxGrid1DBTableView1ORDERNO: TcxGridDBColumn;
    cxGrid1DBTableView1CATEGORY: TcxGridDBColumn;
    cxGrid1DBTableView1NAME_RO: TcxGridDBColumn;
    cxGrid1DBTableView1NAME_RU: TcxGridDBColumn;
    cxGrid1DBTableView1URL: TcxGridDBColumn;
    cxGrid1DBTableView1DT: TcxGridDBColumn;
    DBSynEdit1: TDBSynEdit;
  private
//    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
  public
    { Public declarations }
  end;

//var
//  frmWebConfigDlg: TfrmWebConfigDlg;

implementation

uses
  DataModuleDB;

{$R *.dfm}

function TfrmWebConfigDlg.IsFormDataPosted: boolean;
begin
  if IBCQueryWebSite.State in dsEditModes then
    IBCQueryWebSite.Post;

  IBCQueryWebSite.UpdateTransaction.Commit;
  Result := True;
end;

procedure TfrmWebConfigDlg.Prepare;
begin
  inherited;
  if not IBCQueryWebSite.UpdateTransaction.Active then
    IBCQueryWebSite.UpdateTransaction.StartTransaction;
end;

end.
