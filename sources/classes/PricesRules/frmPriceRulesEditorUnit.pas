unit frmPriceRulesEditorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxDropDownEdit, cxCalc, cxDBEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, cxLabel, DialogTitle, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, DB, Vcl.ExtCtrls, cxMemo;

type
  TfrmPriceRulesEditorDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Panel1: TPanel;
    cxLabel1: TcxLabel;
    seGrilaPret: TcxDBSpinEdit;
    cxLabel2: TcxLabel;
    ceMinValue: TcxDBCalcEdit;
    ceMaxValue: TcxDBCalcEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    ceMinMargin: TcxDBCalcEdit;
    cxLabel6: TcxLabel;
    ceRoundUp: TcxDBCalcEdit;
    cxLabel7: TcxLabel;
    ceAdjust: TcxDBCalcEdit;
    teFormula: TcxDBMemo;
    ceMinMarginPercent: TcxDBCalcEdit;
    cxLabel8: TcxLabel;
  private
    FIsNewRecord: Boolean;
    FLastPriceColumn: Integer;
    FPGT_ID: Integer;
    FSupplierID: Integer;
    procedure SetIsNewRecord(const Value: Boolean);
    procedure SetLastPriceColumn(const Value: Integer);
    procedure SetPGT_ID(const Value: Integer);
    procedure SetSupplierID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    function CheckParams: Boolean;
  public
    property IsNewRecord: Boolean read FIsNewRecord write SetIsNewRecord;
    property LastPriceColumn: Integer read FLastPriceColumn write SetLastPriceColumn;
    property PGT_ID: Integer read FPGT_ID write SetPGT_ID;
    { Public declarations }
  published
    property SupplierID: Integer read FSupplierID write SetSupplierID;
  end;

var
  frmPriceRulesEditorDlg: TfrmPriceRulesEditorDlg;

implementation

uses
  DataModuleAdditions, SWNDBErrors, SWNUtils, SWNConst, SWNCommonDialogs;

{$R *.dfm}

{ TfrmPriceRulesEditorDlg }

function TfrmPriceRulesEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if (fMasterDataSet.FieldByName('FORMULA').IsNull or (Trim(fMasterDataSet.FieldByName('FORMULA').AsString) = '')) then
    AddErrorToStr(ErrorStr, 'Formula!');

  if (fMasterDataSet.FieldByName('MIN_VALUE').IsNull or (fMasterDataSet.FieldByName('MIN_VALUE').AsFloat < 0)) then
    AddErrorToStr(ErrorStr, 'DIAPAZON - Valoare minima!');

  if (fMasterDataSet.FieldByName('MAX_VALUE').IsNull or (fMasterDataSet.FieldByName('MAX_VALUE').AsFloat < 0)) then
    AddErrorToStr(ErrorStr, 'DIAPAZON - Valoare maxima!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

function TfrmPriceRulesEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  if CheckParams then
  begin
    try
      if fMasterDataSet.State in [dsEdit, dsInsert] then
        fMasterDataSet.Post;
    except
      on e: Exception do
      begin
        Result := False;
        if not ProcessSWNError(e) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmPriceRulesEditorDlg.Prepare;
begin
  seGrilaPret.DataBinding.DataSource := fMasterDataSource;
  seGrilaPret.DataBinding.DataField := 'PRICECOLUMN';
  ceMinValue.DataBinding.DataSource := fMasterDataSource;
  ceMinValue.DataBinding.DataField := 'MIN_VALUE';
  ceMaxValue.DataBinding.DataSource := fMasterDataSource;
  ceMaxValue.DataBinding.DataField := 'MAX_VALUE';
  teFormula.DataBinding.DataSource := fMasterDataSource;
  teFormula.DataBinding.DataField := 'FORMULA';
  ceAdjust.DataBinding.DataSource := fMasterDataSource;
  ceAdjust.DataBinding.DataField := 'ADJUST';
  ceRoundUp.DataBinding.DataSource := fMasterDataSource;
  ceRoundUp.DataBinding.DataField := 'ROUND_UP';
  ceMinMargin.DataBinding.DataSource := fMasterDataSource;
  ceMinMargin.DataBinding.DataField := 'MIN_MARGIN';
  ceMinMarginPercent.DataBinding.DataSource := fMasterDataSource;
  ceMinMarginPercent.DataBinding.DataField := 'MIN_MARGIN_PERCENT';

  if IsNewRecord then
  begin
    fMasterDataSet.Append;
    fMasterDataSet.FieldByName('PGT_ID').AsInteger := PGT_ID;
    fMasterDataSet.FieldByName('PRICECOLUMN').AsInteger := LastPriceColumn;
    fMasterDataSet.FieldByName('SUPPLIERID').AsInteger := fSupplierID;
    fMasterDataSet.FieldByName('MIN_MARGIN').AsInteger := 0;
    fMasterDataSet.FieldByName('ADJUST').AsInteger := 0;
    fMasterDataSet.FieldByName('ROUND_UP').AsInteger := 1;
  end
  else
    fMasterDataSet.Edit;

end;

procedure TfrmPriceRulesEditorDlg.SetIsNewRecord(const Value: Boolean);
begin
  FIsNewRecord := Value;
end;

procedure TfrmPriceRulesEditorDlg.SetLastPriceColumn(const Value: Integer);
begin
  FLastPriceColumn := Value;
end;

procedure TfrmPriceRulesEditorDlg.SetPGT_ID(const Value: Integer);
begin
  FPGT_ID := Value;
end;

procedure TfrmPriceRulesEditorDlg.SetSupplierID(const Value: Integer);
begin
  FSupplierID := Value;
end;

procedure TfrmPriceRulesEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in [dsEdit, dsInsert] then
    fMasterDataSet.Cancel;
end;

end.

