unit frmChangeGoodsTitleUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, dxmdaset, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, SWNBaseUnit, MemDS,
  DBAccess, IBC;

type
  TfrmChangeGoodsTitleDlg = class(TSWNCustomForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dxMemData1: TdxMemData;
    DataSource1: TDataSource;
    cxGrid1DBTableView_TITLE_OLD: TcxGridDBColumn;
    cxGrid1DBTableView_TITLE_NEW: TcxGridDBColumn;
    dxMemData1TITLE_OLD: TStringField;
    dxMemData1TITLE_NEW: TStringField;
    btnOK: TcxButton;
    cxButton2: TcxButton;
    cxGrid1DBTableView_GOODSID: TcxGridDBColumn;
  private
    FParentID: Integer;
    procedure SetParentID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  published
    property ParentID: Integer read FParentID write SetParentID;
  end;

var
  frmChangeGoodsTitleDlg: TfrmChangeGoodsTitleDlg;

implementation

{$R *.dfm}

uses DataModuleDB;

{ TfrmChangeGoodsTitleDlg }

procedure TfrmChangeGoodsTitleDlg.Prepare;
var
  query: TIBCQuery;
begin
  query := TIBCQuery.Create(nil);
  try
    dmdb.OpenQuery(query, 'select G.TITLE, Z.GOODSNAME_RO, Z.GOODSNAME_RU '+
                          'from TS_GOODS G ' +
                          'join GET_GOODS_NAMES(G.GOODSID) Z on 1 = 1 ' +
                          'where G.PARENTID = :PARENTID',[ParentID]);
  finally
    query.Free;
  end;
end;

procedure TfrmChangeGoodsTitleDlg.SetParentID(const Value: Integer);
begin
  FParentID := Value;
end;

end.

