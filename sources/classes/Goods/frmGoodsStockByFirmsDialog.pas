unit frmGoodsStockByFirmsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxStyles, DB, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGrid, StdCtrls,
  IBC, cxDBEdit, cxTextEdit, ExtCtrls,
  cxCalc, cxCheckBox, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData,
  cxImageComboBox, Vcl.Menus, DBAccess, MemDS, cxGridTableView, cxClasses, cxGridCustomView, cxMemo;

type
  TfrmGoodsStockByFirmsDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    IBCQueryStockQTY: TIBCQuery;
    IBCDataSourceStockQTY: TIBCDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edGOODSID: TcxDBTextEdit;
    mmTITLE: TcxDBMemo;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridDBTableView;
    cxGridTable_IMG: TcxGridDBColumn;
    cxGridTable_FIRMA: TcxGridDBColumn;
    cxGridTable_QTY: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    Bevel1: TBevel;
    cxGridTable_TRANSIT_QTY: TcxGridDBColumn;
    cbShowOnlyAvailable: TcxCheckBox;
    btnClose: TcxButton;
    procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
    procedure cxGridTable_TRANSIT_QTYStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    FGoodsID: integer;
    fShowOnlyAvailable:Boolean;
    procedure SetGoodsID(const Value: integer);
    procedure WhenShowOnlyAvailableClick(Sender: TObject);
    procedure OpenDataDB;

  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
  public
    { Public declarations }
    property GoodsID:integer read FGoodsID write SetGoodsID;
  end;

implementation

uses DataModuleAdditions, SWNValueStorageUnit, SWNConst;

{$R *.dfm}

{ TForm1 }


procedure TfrmGoodsStockByFirmsDlg.cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
 trQTY : double;
 QTY:    double;
begin
     if VarIsFloat(ARecord.Values[cxGridTable_QTY.Index]) then
     begin
          trQTY:=ARecord.Values[cxGridTable_TRANSIT_QTY.Index];
          QTY:=ARecord.Values[cxGridTable_QTY.Index];

          if trQTY>0 then AStyle:=dmAdditions.cxStyle_TextColorGreen;

          if QTY>0 then AStyle:=dmAdditions.cxStyle_Bold
          else
          begin
               if (QTY<0)
               then AStyle:=dmAdditions.cxStyle_TextColorRed
               else
                   if (trQTY=0) then AStyle:=dmAdditions.cxStyle_TextGray;
          end;
     end;

end;


procedure TfrmGoodsStockByFirmsDlg.cxGridTable_TRANSIT_QTYStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  var
  trQty : double;
  begin
     if VarIsFloat(ARecord.Values[cxGridTable_TRANSIT_QTY.Index]) then
     begin
          trQTY:=ARecord.Values[cxGridTable_TRANSIT_QTY.Index];
          if trQTY<=0
            then AStyle:=dmAdditions.cxStyle_TextGray
            else
                if trQTY>0 then AStyle:=dmAdditions.cxStyle_TextColorGreen;
     end;
end;

procedure TfrmGoodsStockByFirmsDlg.BindingDataSource;
begin
     inherited;
     edGOODSID.DataBinding.DataSource:=fMasterDataSource;
     mmTITLE.DataBinding.DataSource:=fMasterDataSource;
     fShowOnlyAvailable:=AppUserConfigStorage.BooleanValues.GetValue('GoodsStockByFirms_ShowExistingOnly')
end;

procedure TfrmGoodsStockByFirmsDlg.Prepare;
var qtyDigitsMode:Integer;
begin
     // Numarul de zecimale in QTY :
     qtyDigitsMode:=AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits,cAppDefault_QtyDigits);
     // Остаток
     TcxCalcEditProperties(cxGridTable_QTY.Properties).DisplayFormat:=cQTY_DigitsMask[qtyDigitsMode];
     TcxCalcEditProperties(cxGridTable_TRANSIT_QTY.Properties).DisplayFormat:=cQTY_DigitsMask[qtyDigitsMode];

     OpenDataDB;
     cbShowOnlyAvailable.Checked:=fShowOnlyAvailable;
     cbShowOnlyAvailable.OnClick:=WhenShowOnlyAvailableClick;
end;

procedure TfrmGoodsStockByFirmsDlg.OpenDataDB;
begin
     IBCQueryStockQTY.Close;
     IBCQueryStockQTY.ParamByName('GOODSID').AsInteger := FGoodsID;
     if fShowOnlyAvailable
      then IBCQueryStockQTY.FilterSQL := '(QTY>0) OR (TRANSIT_QTY>0)'
      else IBCQueryStockQTY.FilterSQL := '';
     IBCQueryStockQTY.Active:=True;
end;

procedure TfrmGoodsStockByFirmsDlg.SetGoodsID(const Value: integer);
begin
     FGoodsID := Value;
end;

procedure TfrmGoodsStockByFirmsDlg.WhenShowOnlyAvailableClick(Sender: TObject);
begin
     fShowOnlyAvailable:=Not fShowOnlyAvailable;
     cbShowOnlyAvailable.Checked:=fShowOnlyAvailable;
     OpenDataDB;
     AppUserConfigStorage.BooleanValues.SetValue('GoodsStockByFirms_ShowExistingOnly',fShowOnlyAvailable);
end;

end.
