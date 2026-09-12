unit frmRascetKonfiguratiiDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  DB, Menus, IBC,
  StdCtrls, cxButtons, cxGridLevel, cxGridDBTableView,
  cxGrid, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxImageComboBox,
  cxCurrencyEdit, DBAccess, MemDS, cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView, dxUIAClasses;

type
  TfrmRascetKonfiguratiiDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    btnClose: TcxButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGridTable_GOODSID: TcxGridDBColumn;
    cxGridTable_GOODS_NAME: TcxGridDBColumn;
    cxGridTable_COST: TcxGridDBColumn;
    cxGridTable_AMOUNT: TcxGridDBColumn;
    cxGridTable_PROFIT: TcxGridDBColumn;
    cxGridTable_IMG: TcxGridDBColumn;
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
  end;



implementation




{$R *.dfm}

{ TfrmRascetKonfiguratiiDlg }

procedure TfrmRascetKonfiguratiiDlg.Prepare;
begin
     // title
     dtDialogTitle.Text := Format('Document nr.%d',[fMasterDataSet.FieldByName('DOCID').AsInteger]);
     // open data
     IBCQueryGoods.ParamByName('DOCID').AsInteger:=fMasterDataSet.FieldByName('DOCID').AsInteger;
     IBCQueryGoods.Active:=True;
end;


end.
