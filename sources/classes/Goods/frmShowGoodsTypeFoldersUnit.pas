unit frmShowGoodsTypeFoldersUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, DBAccess, IBC, MemDS, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Vcl.StdCtrls, Vcl.ExtCtrls, cxCheckBox;

type
  TfrmShowGoodsTypeFoldersDlg = class(TSWNCustomForm)
    Panel1: TPanel;
    Button1: TButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1CNT_IN_PRICE: TcxGridDBColumn;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    IBCQueryGoods: TIBCQuery;
    IBCDataSource2: TIBCDataSource;
    cxGrid2DBTableView1Column1: TcxGridDBColumn;
    cxGrid2DBTableView1Column2: TcxGridDBColumn;
    cxGrid2DBTableView1Column3: TcxGridDBColumn;
    cxGrid2DBTableView1Column4: TcxGridDBColumn;
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
  public
    constructor Create(AOwner: TComponent; AWebGoodsTypeID: integer); reintroduce;
  end;

var
  frmShowGoodsTypeFoldersDlg: TfrmShowGoodsTypeFoldersDlg;

implementation

uses
  SWNUtils;

{$R *.dfm}

constructor TfrmShowGoodsTypeFoldersDlg.Create(AOwner: TComponent;
  AWebGoodsTypeID: integer);
begin
  inherited Create(AOwner);
  ibcquery1.Close;
  IBCQuery1.ParamByName('WebGoodsType_ID').AsInteger := AWebGoodsTypeID;
  ibcquery1.Prepare;
  IBCQuery1.Open;
end;

procedure TfrmShowGoodsTypeFoldersDlg.cxGrid1DBTableView1KeyDown(Sender:
    TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGrid1DBTableView1, Key, Shift);
end;

procedure TfrmShowGoodsTypeFoldersDlg.FormShow(Sender: TObject);
begin
  cxGrid1.SetFocus;
end;

function TfrmShowGoodsTypeFoldersDlg.IsFormDataPosted: boolean;
begin
  Result := True;
end;

procedure TfrmShowGoodsTypeFoldersDlg.Prepare;
begin
  IBCQueryGoods.Open;
end;

end.
