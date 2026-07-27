unit uPricesTypesEditorDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, cxDropDownEdit, cxCalc, cxDBEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxTextEdit, cxLabel, Data.DB, MemDS, DBAccess, IBC;

type
  TfrmPricesTypesEditorDlg = class(TSWNCustomForm)
    cxLabel1: TcxLabel;
    teID: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    teName: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    cbCurrency: TcxDBLookupComboBox;
    cxLabel4: TcxLabel;
    cbVAT: TcxDBLookupComboBox;
    cxLabel5: TcxLabel;
    cbPricesTypes: TcxDBLookupComboBox;
    cxLabel6: TcxLabel;
    cbCalcMethod: TcxDBLookupComboBox;
    cxLabel7: TcxLabel;
    cbBasicPricesType: TcxDBLookupComboBox;
    cxLabel8: TcxLabel;
    ceMargin: TcxDBCalcEdit;
    cxLabel9: TcxLabel;
    cbRoundingMethod: TcxDBLookupComboBox;
    cxLabel10: TcxLabel;
    ceRound: TcxDBCalcEdit;
    btnOK: TcxButton;
    btnCancel: TcxButton;
  private
    fAddRecord: Boolean;
    fDataSet: TIBCQuery;
    fDataSource: TIBCDataSource;
    procedure SetAddRecord(const Value: Boolean);
    procedure SetDataSet(const Value: TIBCQuery);
    procedure SetDataSource(const Value: TIBCDatasource);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    function CheckParams: boolean;
  published
    property AddRecord: Boolean read fAddRecord write SetAddRecord;
    property DataSet: TIBCQuery read fDataSet write SetDataSet;
    property DataSource: TIBCDatasource read fDataSource write SetDataSource;
  end;

var
  frmPricesTypesEditorDlg: TfrmPricesTypesEditorDlg;

implementation

uses
  SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmPricesTypesEditorDlg }

function TfrmPricesTypesEditorDlg.CheckParams: boolean;

var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';
  if (DataSet.FieldByName('NAME').IsNull) or (Trim(DataSet.FieldByName('Name').AsString) = '') then
    AddErrorToStr(ErrorStr, 'Denumirea!');

  if DataSet.FieldByName('CURRENCYID').AsInteger =- 1 then
    AddErrorToStr(ErrorStr, 'Valuta');

  if DataSet.FieldByName('VAT').AsInteger =- 1 then
    AddErrorToStr(ErrorStr, 'TVA');

  if DataSet.FieldByName('PRICE_TYPE').AsInteger =- 1 then
    AddErrorToStr(ErrorStr, 'Tipul de preturi');

  if DataSet.FieldByName('PRICEING_METHOD').AsInteger =- 1 then
    AddErrorToStr(ErrorStr, 'Metoda de calcul');

  if DataSet.FieldByName('BASIC_PRICE_TYPE').AsInteger =- 1 then
    AddErrorToStr(ErrorStr, 'Preturile de baza');

  if DataSet.FieldByName('ROUNDING_METHOD').AsInteger =- 1 then
    AddErrorToStr(ErrorStr, 'Metoda de rotungire');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text,
      ErrorStr);
end;


function TfrmPricesTypesEditorDlg.IsFormDataPosted: Boolean;
begin
   if CheckParams then
   begin
    fDataSet.Post;
    // comit chnages
    fDataSet.UpdateTransaction.Commit;

    // done
    Result := True;
   end
   else
     Result := False;
end;

procedure TfrmPricesTypesEditorDlg.Prepare;
begin
  inherited;

  teID.DataBinding.DataSource := DataSource;
  teName.DataBinding.DataSource := DataSource;
  cbCurrency.DataBinding.DataSource := DataSource;
  cbVAT.DataBinding.DataSource := DataSource;
  cbPricesTypes.DataBinding.DataSource := DataSource;
  cbCalcMethod.DataBinding.DataSource := DataSource;
  cbBasicPricesType.DataBinding.DataSource := DataSource;
  cbRoundingMethod.DataBinding.DataSource := DataSource;
  ceMargin.DataBinding.DataSource := DataSource;
  ceRound.DataBinding.DataSource := DataSource;

  if AddRecord=True then
    fDataSet.Append
  else
    fDataSet.Edit;
end;

procedure TfrmPricesTypesEditorDlg.SetAddRecord(const Value: Boolean);
begin
  fAddRecord := Value;
end;

procedure TfrmPricesTypesEditorDlg.SetDataSet(const Value: TIBCQuery);
begin
  fDataSet := Value;
end;

procedure TfrmPricesTypesEditorDlg.SetDataSource(const Value: TIBCDatasource);
begin
  fDataSource := Value;
end;

procedure TfrmPricesTypesEditorDlg.WhenCancelForm;
begin
  inherited;
  if DataSet.UpdateTransaction.Active then
  begin
    DataSet.Cancel;
    DataSet.UpdateTransaction.Rollback;
  end;
end;

end.
