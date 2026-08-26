unit frmCustomImportXlsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  cxControls, dxCore, dxCoreClasses, dxHashUtils, dxSpreadSheetCore, dxSpreadSheetCoreFormulas,
  dxSpreadSheetCoreHistory, dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs, dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetClasses, dxSpreadSheetContainers, dxSpreadSheetFormulas,
  dxSpreadSheetHyperlinks, dxSpreadSheetFunctions, dxSpreadSheetStyles, dxSpreadSheetGraphics, dxSpreadSheetPrinting,
  dxSpreadSheetTypes, dxSpreadSheetUtils, dxSpreadSheetFormattedTextUtils, dxBarBuiltInMenu, dxSpreadSheetFormulaBar,
  dxSpreadSheet, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, Data.DB, DBAccess, IBC, MemDS;

type
  TOnImportValidate = function(ASpreadSheet: TdxSpreadSheet): Boolean of object;
  TOnPrepareSpreadSheet = procedure(ASpreadSheet: TdxSpreadSheet) of object;
  TOnAfterImport = procedure(ASpreadSheet: TdxSpreadSheet) of object;
  TOnDoImport = function(ASpreadSheet: TdxSpreadSheet): Boolean of object;

  TfrmCustomImportXLS = class(TSWNBaseFormClass)
    Panel1: TPanel;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    dxSpreadSheetFormulaBar1: TdxSpreadSheetFormulaBar;
    dxSpreadSheet1: TdxSpreadSheet;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
      { Private declarations }
    FOnAfterImport: TOnAfterImport;
    FOnDoImport: TOnDoImport;
    FOnPrepareSpreadSheet: TOnPrepareSpreadSheet;
    FOnImportValidate: TOnImportValidate;

    procedure SetOnAfterImport(const Value: TOnAfterImport);
    procedure SetOnDoImport(const Value: TOnDoImport);
    procedure SetOnPrepareSpreadSheet(const Value: TOnPrepareSpreadSheet);
    procedure SetOnImportValidate(const Value: TOnImportValidate);

  protected

  public
      { Public declarations }
    property OnAfterImport: TOnAfterImport read FOnAfterImport write
        SetOnAfterImport;
    property OnDoImport: TOnDoImport read FOnDoImport write SetOnDoImport;
    property OnPrepareSpreadSheet: TOnPrepareSpreadSheet read FOnPrepareSpreadSheet
        write SetOnPrepareSpreadSheet;
    property OnImportValidate: TOnImportValidate read FOnImportValidate write
        SetOnImportValidate;
    constructor Create(const AOwner: TComponent; const IBCConnection: TIBCConnection); override;
  end;

var
  frmCustomImportXLS: TfrmCustomImportXLS;

implementation

{$R *.dfm}

{ TfrmCustomImportXLS }

constructor TfrmCustomImportXLS.Create(const AOwner: TComponent; const IBCConnection: TIBCConnection);
begin
  inherited Create(AOwner, IBCConnection);
  FOnImportValidate := nil;
  FOnAfterImport := nil;
  FOnPrepareSpreadSheet := nil;
  FOnDoImport := nil;
end;

procedure TfrmCustomImportXLS.btnOKClick(Sender: TObject);
begin
  if Assigned(fOnImportValidate) then
   if not fOnImportValidate(dxSpreadSheet1) then
       Exit;

  if Assigned(FOnDoImport) then
    if FOnDoImport(dxSpreadSheet1) then
      ModalResult := mrOk
    else
      ModalResult := mrNone;

//  if Assigned(OnAfterImport) then
//    OnAfterImport(dxSpreadSheet1);
end;

procedure TfrmCustomImportXLS.FormShow(Sender: TObject);
begin
  if Assigned(FOnPrepareSpreadSheet) then
    FOnPrepareSpreadSheet(dxSpreadSheet1);
end;

procedure TfrmCustomImportXLS.SetOnAfterImport(const Value: TOnAfterImport);
begin
    FOnAfterImport := Value;
end;

procedure TfrmCustomImportXLS.SetOnDoImport(const Value: TOnDoImport);
begin
    FOnDoImport := Value;
end;

procedure TfrmCustomImportXLS.SetOnPrepareSpreadSheet(const Value:
    TOnPrepareSpreadSheet);
begin
    FOnPrepareSpreadSheet := Value;
end;

procedure TfrmCustomImportXLS.SetOnImportValidate(const Value:
    TOnImportValidate);
begin
    FOnImportValidate := Value;
end;

end.
