unit frmSelectSerialPartNoUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.Menus,
  cxCheckBox, DialogTitle, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, Vcl.StdCtrls, cxButtons,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, DBAccess, IBC, MemDS,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges;

type
  TfrmSelectSerialPartNoDlg = class(TSWNBaseFormClass)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxButton3: TcxButton;
    cxButton4: TcxButton;
    DialogTitle1: TDialogTitle;
    IBCQueryAvailableSN: TIBCQuery;
    IBCDataSourceAvailableSN: TIBCDataSource;
  private
    FDocID: Integer;
    FGoodsID: Integer;
    procedure SetDocID(const Value: Integer);
    procedure SetGoodsID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
    property DocID: Integer read FDocID write SetDocID;
    property GoodsID: Integer read FGoodsID write SetGoodsID;
  end;

var
  frmSelectSerialPartNoDlg: TfrmSelectSerialPartNoDlg;

implementation

uses
  DataModuleAdditions;

{$R *.dfm}

procedure TfrmSelectSerialPartNoDlg.Prepare;
begin
  with IBCQueryAvailableSN do
  begin
    Close;
    ParamByName('DOCID').AsInteger := FDocID;
    ParamByName('GOODSID').AsInteger := fGoodsID;
    Open;
  end;

end;

procedure TfrmSelectSerialPartNoDlg.SetDocID(const Value: Integer);
begin
  FDocID := Value;
end;

procedure TfrmSelectSerialPartNoDlg.SetGoodsID(const Value: Integer);
begin
  FGoodsID := Value;
end;

end.
