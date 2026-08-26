unit frmGoodsByCategoryFolderDlgUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Data.DB, DBAccess, IBC,
  MemDS, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, Vcl.ExtCtrls, RzPanel, RzDlgBtn;

type
  TfrmGoodsByCategoryFolderDlg = class(TSWNBaseFormClass)
    IBCQuery: TIBCQuery;
    IBCDataSource: TIBCDataSource;
    RzDialogButtons1: TRzDialogButtons;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1DBTableView1WEBGOODSTYPE_ID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1CNT: TcxGridDBColumn;
  private
    FParentid: Integer;
    procedure SetParentid(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    property Parentid: Integer read FParentid write SetParentid;
    { Public declarations }
  end;

//var
//  frmGoodsByCategoryFolderDlg: TfrmGoodsByCategoryFolderDlg;

implementation

{$R *.dfm}

{ TfrmGoodsByCategoryFolderDlg }

procedure TfrmGoodsByCategoryFolderDlg.Prepare;
begin
  inherited;
  ibcquery.Close;
  ibcquery.ParamByName('parentid').AsINteger := fParentID;
  ibcquery.OPen;
end;

procedure TfrmGoodsByCategoryFolderDlg.SetParentid(const Value: Integer);
begin
  FParentid := Value;
end;

end.
