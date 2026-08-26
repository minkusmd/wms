unit frmEditPriceListUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxCore,
  dxCoreClasses, dxHashUtils, dxSpreadSheetCore, dxSpreadSheetCoreFormulas, dxSpreadSheetCoreHistory,
  dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs, dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetClasses, dxSpreadSheetContainers, dxSpreadSheetFormulas,
  dxSpreadSheetHyperlinks, dxSpreadSheetFunctions, dxSpreadSheetStyles, dxSpreadSheetGraphics, dxSpreadSheetPrinting,
  dxSpreadSheetTypes, dxSpreadSheetUtils, dxSpreadSheetFormattedTextUtils, dxBarBuiltInMenu, dxSpreadSheet, cxContainer,
  cxEdit, Vcl.Menus, cxSplitter, Vcl.StdCtrls, cxButtons, cxLabel, cxMemo, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit, Vcl.ExtCtrls;

type
  TfrmEditPriceListDialog = class(TForm)
    dxSpreadSheet1: TdxSpreadSheet;
    Panel1: TPanel;
    teCode: TcxTextEdit;
    teCodeRu: TcxTextEdit;
    lcbGoodsType: TcxLookupComboBox;
    lcbVendor: TcxLookupComboBox;
    teBaseParams: TcxTextEdit;
    teBaseParamsRu: TcxTextEdit;
    teDetails: TcxTextEdit;
    meTitle: TcxMemo;
    cxLabel1: TcxLabel;
    lasdf: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    Panel2: TPanel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxSplitter1: TcxSplitter;
  private
    { Private declarations }
  procedure Prepare;
  public
    { Public declarations }
  end;

var
  frmEditPriceListDialog: TfrmEditPriceListDialog;

implementation

{$R *.dfm}

{ TfrmEditPriceListDialog }

procedure TfrmEditPriceListDialog.Prepare;
begin
end;

end.
