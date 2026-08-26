unit frmRelatedGoodsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBAccess, IBC, MemDS, cxGridLevel,
  cxGridCustomView, cxGrid, dxBar, cxClasses, SWNBaseUnit;

type
  TfrmRelatedGoodsDlg = class(TForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbOK: TdxBarButton;
    bbCancel: TdxBarButton;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryRelatedKeys: TIBCQuery;
    IBCDataSourceRelatedKeys: TIBCDataSource;
    cxGrid1DBTableView1RELATED_KEY: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    procedure bbOKClick(Sender: TObject);
    procedure bbCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatedGoodsDlg: TfrmRelatedGoodsDlg;

implementation

uses
    DataModuleAdditions;

{$R *.dfm}

procedure TfrmRelatedGoodsDlg.bbCancelClick(Sender: TObject);
begin
    ModalResult := mrCancel;
end;

procedure TfrmRelatedGoodsDlg.bbOKClick(Sender: TObject);
begin
    ModalResult := mrOk;
end;

end.
