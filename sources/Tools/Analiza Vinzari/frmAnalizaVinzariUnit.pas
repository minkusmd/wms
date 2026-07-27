unit frmAnalizaVinzariUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxClasses, cxCustomData, cxStyles, cxEdit, Data.DB, DBAccess, IBC, MemDS, DialogTitle, dxStatusBar, cxCustomPivotGrid,
  cxDBPivotGrid, dxBar, dxBarExtItems, DataModuleAdditions;

type
  TfrmAnalizaVinzariDlg = class(TSWNBaseFormClass)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarDateCombo1: TdxBarDateCombo;
    dxBarDateCombo2: TdxBarDateCombo;
    dxBarButton1: TdxBarButton;
    cxDBPivotGrid1: TcxDBPivotGrid;
    dxStatusBar1: TdxStatusBar;
    DialogTitle1: TDialogTitle;
    IBCQueryAnalizaVinzari: TIBCQuery;
    IBCDataSourceAnalizaVinzari: TIBCDataSource;
    cxDBPivotGrid1GGID: TcxDBPivotGridField;
    cxDBPivotGrid1GG_NAME: TcxDBPivotGridField;
    cxDBPivotGrid1DT: TcxDBPivotGridField;
    cxDBPivotGrid1DOCID: TcxDBPivotGridField;
    cxDBPivotGrid1DATA: TcxDBPivotGridField;
    cxDBPivotGrid1GOODSID: TcxDBPivotGridField;
    cxDBPivotGrid1GOODS_NAME: TcxDBPivotGridField;
    cxDBPivotGrid1SUMAMDL_IN: TcxDBPivotGridField;
    cxDBPivotGrid1SUMAMDL_OUT: TcxDBPivotGridField;
    cxDBPivotGrid1WEBGOODSTYPE_ID: TcxDBPivotGridField;
    cxDBPivotGrid1WEBGOODSTYPE_NAME: TcxDBPivotGridField;
    cxDBPivotGrid1VENDORID: TcxDBPivotGridField;
    cxDBPivotGrid1VENDOR_NAME: TcxDBPivotGridField;
    cxDBPivotGrid1PARENTID: TcxDBPivotGridField;
    cxDBPivotGrid1PARENT_NAME: TcxDBPivotGridField;
    cxDBPivotGrid1USERID: TcxDBPivotGridField;
    cxDBPivotGrid1QTY: TcxDBPivotGridField;
    dxBarButton2: TdxBarButton;
    cxDBPivotGrid1_UserName: TcxDBPivotGridField;
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Prepare; override;

  public
    { Public declarations }
  end;

var
  frmAnalizaVinzariDlg: TfrmAnalizaVinzariDlg;

implementation

uses
  cxExportPivotGridLink;

{$R *.dfm}

procedure TfrmAnalizaVinzariDlg.dxBarButton1Click(Sender: TObject);
begin
   IBCQueryAnalizaVinzari.Close;
   IBCQueryAnalizaVinzari.ParamByName('DATA1').AsDate := dxBarDateCombo1.Date;
   IBCQueryAnalizaVinzari.ParamByName('DATA2').AsDate := dxBarDateCombo2.Date;
   IBCQueryAnalizaVinzari.Open;
end;

procedure TfrmAnalizaVinzariDlg.dxBarButton2Click(Sender: TObject);
var
    SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(Self);
  try
  if SaveDialog.Execute then
    cxExportPivotGridToExcel(SaveDialog.FileName, cxDBPivotGrid1, True);
  finally
      SaveDialog.Free;
  end;

end;

procedure TfrmAnalizaVinzariDlg.Prepare;
begin
  dxBarDateCombo1.Date := Date-92;
  dxBarDateCombo2.Date := Date;
end;

end.
