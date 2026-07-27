unit uPricesTypesDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBAccess, IBC,
  MemDS, Vcl.ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, dxBar, Vcl.Menus, Vcl.StdCtrls, cxButtons, SWNBaseUnit,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmPricesTypesDlg = class(TSWNCustomForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryPricesTypes: TIBCQuery;
    IBCDataSourcePricesTypes: TIBCDataSource;
    cxGrid1DBTableView1ID: TcxGridDBColumn;
    cxGrid1DBTableView1CURRENCY_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1NAME: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE_TYPE_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1BASIC_PRICE_TYPE_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1VAT: TcxGridDBColumn;
    cxGrid1DBTableView1PRICEING_METHOD_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1MARGIN: TcxGridDBColumn;
    cxGrid1DBTableView1ROUNDING: TcxGridDBColumn;
    cxGrid1DBTableView1ROUNDING_METHOD_NAME: TcxGridDBColumn;
    cxButton1: TcxButton;
    procedure bbNewClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure prepare; override;
  public
    { Public declarations }

  end;

var
  frmPricesTypesDlg: TfrmPricesTypesDlg;

implementation

uses
  uPricesTypesEditorDlg, DataModuleDB, DataModuleAdditions;

{$R *.dfm}

procedure TfrmPricesTypesDlg.bbNewClick(Sender: TObject);
var
  dialog: TfrmPricesTypesEditorDlg;
begin
  dialog := TfrmPricesTypesEditorDlg.Create(Self);
  try
    dialog.AddRecord := True;
    dialog.DataSet := IBCQueryPricesTypes;
    dialog.DataSource := IBCDataSourcePricesTypes;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPricesTypesDlg.prepare;
begin
  inherited;
  IBCQueryPricesTypes.Open;
end;

end.
