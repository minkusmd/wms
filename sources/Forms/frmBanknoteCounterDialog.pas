unit frmBanknoteCounterDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Menus, cxCustomData,
  cxGridLevel, cxGridTableView,
  cxGrid, StdCtrls, cxButtons, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxLabel, cxMaskEdit,
  cxGridCustomTableView, cxClasses, cxGridCustomView;

type
  TfrmBanknoteCounterDlg = class(TForm)
    dtDialogTitle: TDialogTitle;
    cxGridBanknotesLevel: TcxGridLevel;
    cxGridBanknotes: TcxGrid;
    cxGridBanknotesTable: TcxGridTableView;
    cxGridBanknotesTableCol1: TcxGridColumn;
    cxGridBanknotesTableCol2: TcxGridColumn;
    cxGridBanknotesTableCol3: TcxGridColumn;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure cxGridBanknotesTableCol2PropertiesValidate(Sender: TObject; var DisplayValue: Variant;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function GetTotalSum: integer;
  public
    { Public declarations }
    property TotalSum:integer read GetTotalSum;
  end;

implementation



{$R *.dfm}

{ TfrmBanknoteCounterDlg }

procedure TfrmBanknoteCounterDlg.cxGridBanknotesTableCol2PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
     cxGridBanknotesTable.ViewData.EditingRecord.Values[2]:=cxGridBanknotesTable.ViewData.EditingRecord.Values[0]*DisplayValue;
end;

procedure TfrmBanknoteCounterDlg.FormCreate(Sender: TObject);
begin
     //cxGridBanknotesTable.DataController.SelectRows(0,0);
     cxGridBanknotesTable.DataController.FocusedRowIndex:=0;
end;

function TfrmBanknoteCounterDlg.GetTotalSum: integer;
begin
     Result:=Integer(cxGridBanknotesTable.DataController.Summary.FooterSummaryValues[0]);
end;


end.
