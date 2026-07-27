unit frmGoodsByTypeUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, Data.DB, cxDBData,
  Vcl.Menus, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBAccess, IBC, MemDS, Vcl.StdCtrls, cxButtons,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, DialogTitle, cxCheckBox, dxScrollbarAnnotations, dxBar;

type
  TfrmGoodsByType = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxButton1: TcxButton;
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1_FLG_FORCED: TcxGridDBColumn;
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure bbEditContentClick(Sender: TObject);
  private
    FGoodsTypeID: Integer;
    procedure SetGoodsTypeID(const Value: Integer);
    procedure ShowGoodsDialog(GoodsID: Integer);
    { Private declarations }
  protected
   procedure Prepare; override;
  public
    property GoodsTypeID: Integer read FGoodsTypeID write SetGoodsTypeID;
    { Public declarations }
  end;

var
  frmGoodsByType: TfrmGoodsByType;

implementation

uses
   frmGoods, DataModuleAdditions, SWNUtils, frmContentGoodsEditorDialog;

{$R *.dfm}

{ TfrmGoodsByType }

procedure TfrmGoodsByType.bbEditContentClick(Sender: TObject);
//var
//  d: TfrmContentGoodsEditorDlg;
begin
//  d := TfrmContentGoodsEditorDlg.Create(Self, IBCQuery1, IBCDataSource1);
//  try
//    d.ShowModal;
//  finally
//    d.Free;
//  end;
end;

procedure TfrmGoodsByType.cxGrid1DBTableView1KeyDown(Sender: TObject; var Key:
    Word; Shift: TShiftState);
begin
    ProcessCommonKeys(Self, cxGrid1DBTableView1, Key, shift );
end;

procedure TfrmGoodsByType.Prepare;
begin
  IBCQuery1.ParamByName('GOODSTYPEID').AsInteger := GoodsTypeID;
  IBCQuery1.Open;
end;

procedure TfrmGoodsByType.ShowGoodsDialog(GoodsID: Integer);
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    dialog.GoodsID := GoodsID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsByType.SetGoodsTypeID(const Value: Integer);
begin
   FGoodsTypeID := Value;
end;

end.
