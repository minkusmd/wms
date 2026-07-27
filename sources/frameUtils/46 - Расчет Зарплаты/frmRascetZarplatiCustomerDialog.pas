unit frmRascetZarplatiCustomerDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, StdCtrls, cxDropDownEdit, cxCalc, cxDBEdit, cxMemo,
  Buttons, cxLabel, Vcl.Menus, cxButtons;

type
  TfrmRascetZarplatiCustomerDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    beCUSTOMER: TcxButtonEdit;
    edSUMA_CARD: TcxDBCalcEdit;
    edSUMA_BONUS: TcxDBCalcEdit;
    edSUMA_PENALITATI: TcxDBCalcEdit;
    edORE_LIPSITE: TcxDBCalcEdit;
    mmCOMMENTS: TcxDBMemo;
    sbRecalcMissedHours: TSpeedButton;
    edSUMA_PENALITATI_MANUAL: TcxDBCalcEdit;
    edSUMA_IMPOZIT: TcxDBCalcEdit;
    Label1: TcxLabel;
    Label7: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure beCUSTOMERPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure sbRecalcMissedHoursClick(Sender: TObject);
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckInputParams: Boolean;
    procedure SelectCT;
    function RecalcMissedHours: integer;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, SWNConst, frmCustomersDlg, SWNUtils, IBC;

{$R *.dfm}

{ TfrmRascetZarplatiCustomerDlg }

procedure TfrmRascetZarplatiCustomerDlg.beCUSTOMERPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

function TfrmRascetZarplatiCustomerDlg.CheckInputParams: Boolean;
var
  Errors: string;
begin
  Result := False;
  Errors := '';

  if MasterDataSet.FieldByName('CT').IsNull or (MasterDataSet.FieldByName('CT').AsInteger = -1) then
    AddErrorToStr(Errors, 'Контрагент!');
  if MasterDataSet.FieldByName('SUMA_BONUS').IsNull or (MasterDataSet.FieldByName('SUMA_BONUS').AsFloat < 0) then
    AddErrorToStr(Errors, 'Бонус!');
  if MasterDataSet.FieldByName('SUMA_PENALITATI').IsNull then
    AddErrorToStr(Errors, 'Штраф!');
  if MasterDataSet.FieldByName('SUMA_CARD').IsNull or (MasterDataSet.FieldByName('SUMA_CARD').AsFloat < 0) then
    AddErrorToStr(Errors, 'Карточка!');
  if MasterDataSet.FieldByName('ORE_LIPSITE').IsNull or (MasterDataSet.FieldByName('ORE_LIPSITE').AsInteger < 0) then
    AddErrorToStr(Errors, 'Пропущенные часы!');

  if Errors = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmRascetZarplatiCustomerDlg.BindingDataSource;
begin
  edSUMA_BONUS.DataBinding.DataSource := fMasterDataSource;
  edSUMA_PENALITATI.DataBinding.DataSource := fMasterDataSource;
  edSUMA_CARD.DataBinding.DataSource := fMasterDataSource;
  edORE_LIPSITE.DataBinding.DataSource := fMasterDataSource;
  mmCOMMENTS.DataBinding.DataSource := fMasterDataSource;
  edSuma_PENALITATI_MANUAL.DataBinding.DataSource := fMasterDataSource;
  edSUMA_IMPOZIT.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmRascetZarplatiCustomerDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckInputParams then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmRascetZarplatiCustomerDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if fCreateNewRecord then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('CT').AsInteger := -1;
      fMasterDataSet.FieldByName('SUMA_BONUS').AsFloat := 0;
      fMasterDataSet.FieldByName('SUMA_PENALITATI').AsFloat := 0;
      fMasterDataSet.FieldByName('SUMA_CARD').AsFloat := 0;
      fMasterDataSet.FieldByName('ORE_LIPSITE').AsFloat := 0;
    end
    else
    begin
      dtDialogTitle.Text := '';
      fMasterDataSet.Edit;
    end;
    beCUSTOMER.Text := fMasterDataSet.FieldByName('CT_NAME').AsString;

  except
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;

end;

function TfrmRascetZarplatiCustomerDlg.RecalcMissedHours: integer;
var
  Query: TIBCQuery;
begin
  Result := 0;
  Query := TIBCQuery.Create(Self);
  try
    Query.SQL.Text := 'SELECT MISSED_HOURS FROM SP_GET_USER_MISSED_HOURS(:ct,:doc)';
    Query.ParamByName('ct').AsInteger := fMasterDataSet.FieldByName('CT').AsInteger;
    Query.ParamByName('doc').AsInteger := fMasterDataSet.FieldByName('DOCID').AsInteger;
    Query.ExecSQL;
    if not Query.Eof then
      Result := Query.Fields[0].AsInteger;
  finally
    Query.Free;
  end;
end;

procedure TfrmRascetZarplatiCustomerDlg.sbRecalcMissedHoursClick(Sender: TObject);
begin
  fMasterDataSet.FieldByName('ORE_LIPSITE').AsInteger := RecalcMissedHours;
end;

procedure TfrmRascetZarplatiCustomerDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('CT').AsInteger, false, 8, 'Выберите контрагента для Расчета Зарплаты') then
    begin
      fMasterDataSet.FieldByName('CT').AsInteger := dialog.CustomerID;
      beCUSTOMER.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmRascetZarplatiCustomerDlg.SetCreateNewRecord(const Value: Boolean);
begin
  fCreateNewRecord := Value;
end;

procedure TfrmRascetZarplatiCustomerDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

