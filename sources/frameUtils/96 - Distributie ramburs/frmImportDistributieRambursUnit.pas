unit frmImportDistributieRambursUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, dxUIAClasses, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxCore, dxCoreClasses, dxHashUtils, dxSpreadSheetCore, dxSpreadSheetCoreFormulas, dxSpreadSheetCoreHistory,
  dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs, dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetClasses, dxSpreadSheetContainers, dxSpreadSheetFormulas,
  dxSpreadSheetHyperlinks, dxSpreadSheetFunctions, dxSpreadSheetStyles, dxSpreadSheetGraphics, dxSpreadSheetPrinting,
  dxSpreadSheetTypes, dxSpreadSheetUtils, dxSpreadSheetFormattedTextUtils, dxBarBuiltInMenu, dxSpreadSheet,
  Vcl.ExtCtrls, RzPanel, RzDlgBtn, SWNBaseUnit;

type
  TfrmImportDistributieRambursDlg = class(TSWNCustomForm)
    RzDialogButtons1: TRzDialogButtons;
    dxSpreadSheet1: TdxSpreadSheet;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;

  public
    { Public declarations }
  end;

var
  frmImportDistributieRambursDlg: TfrmImportDistributieRambursDlg;

implementation

{$R *.dfm}

{ TfrmImportDistributieRambursDlg }

function TfrmImportDistributieRambursDlg.IsFormDataPosted: boolean;
begin
  Result := True;
end;

procedure TfrmImportDistributieRambursDlg.Prepare;
var
  ss: TdxSpreadSheetTableView;
  cell : TdxSpreadSheetCell;
begin
  inherited;
  ss := dxSpreadSheet1.ActiveSheetAsTable;
  cell := ss.CreateCell(0,0);
  cell.SetText('AWB');
  cell := ss.CreateCell(0,1);
  cell.SetText('ramburs');
  cell := ss.CreateCell(0, 2);
  cell.SetText('Livrare');
end;

end.
