unit frmFilterParamsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, Vcl.ExtCtrls, DialogTitle, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, DBAccess, IBC, MemDS,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, cxSplitter, cxCheckBox, RzPanel, RzDlgBtn,
  dxUIAClasses;

type
  TfrmFilterParamsDlg = class(TSWNBaseFormClass)
    IBCQueryFilterParams: TIBCQuery;
    IBCDataSourceFilterParams: TIBCDataSource;
    DialogTitle1: TDialogTitle;
    Panel2: TPanel;
    tvGoods: TcxGridDBTableView;
    cxGridGoodsLevel1: TcxGridLevel;
    cxGridGoods: TcxGrid;
    tvGoods_GOODSID: TcxGridDBColumn;
    tvGoods_GOODSNAME: TcxGridDBColumn;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    tvGoods_FLG_IN_PRICE: TcxGridDBColumn;
    RzDialogButtons1: TRzDialogButtons;
    procedure tvGoodsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FCatalogID: Integer;
    FCurrentFirma: Integer;
    FFilterID: Integer;
    FfilterName: string;
    procedure SetCatalogID(const Value: Integer);
    procedure SetCurrentFirma(const Value: Integer);
    procedure SetFilterID(const Value: Integer);
    procedure SetfilterName(const Value: string);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    property CatalogID: Integer read FCatalogID write SetCatalogID;
    property CurrentFirma: Integer read FCurrentFirma write SetCurrentFirma;
    property FilterID: Integer read FFilterID write SetFilterID;
    property filterName: string read FfilterName write SetfilterName;
    { Public declarations }
  end;

var
  frmFilterParamsDlg: TfrmFilterParamsDlg;

implementation

uses
  DataModuleAdditions, SWNUtils;

{$R *.dfm}

{ TfrmFilterParamsDlg }

procedure TfrmFilterParamsDlg.Prepare;
begin
  inherited;
//  IBCQueryFilterParams.ParamByName('FILTERID').AsInteger := FilterID;
//  IBCQueryFilterParams.Open;

  IBCQueryGoods.ParamByName('CatalogID').AsInteger := CatalogID; //CurrentFirma;
  IBCQueryGoods.ParamByName('FILTERID').AsInteger := filterID;
  IBCQueryGoods.Open;

  DialogTitle1.Text := Format('Filtru #%d - "%s"', [FilterID, filterName]);
end;

procedure TfrmFilterParamsDlg.SetCatalogID(const Value: Integer);
begin
  FCatalogID := Value;
end;

procedure TfrmFilterParamsDlg.SetCurrentFirma(const Value: Integer);
begin
  FCurrentFirma := Value;
end;

procedure TfrmFilterParamsDlg.SetFilterID(const Value: Integer);
begin
  FFilterID := Value;
end;

procedure TfrmFilterParamsDlg.SetfilterName(const Value: string);
begin
  FfilterName := Value;
end;

procedure TfrmFilterParamsDlg.tvGoodsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeys(Self, tvGoods, Key, Shift);
end;

end.
