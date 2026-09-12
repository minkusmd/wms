unit frmCustomerCreditEditorDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  SWNBaseUnit, StdCtrls,
  cxDBEdit,
  ExtCtrls, DialogTitle,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxCalc,
  cxMemo, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type

  TfrmCustomerCreditEditorOnVerifyDateRange = function(const DateStart,
    DateEnd: TDate): Boolean of object;

  TfrmCustomerCreditEditorDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnCard: TPanel;
    cxLabel2: TLabel;
    deStartDate: TcxDBDateEdit;
    cxLabel1: TLabel;
    cxLabel3: TLabel;
    deEndDate: TcxDBDateEdit;
    cxLabel4: TLabel;
    mmComents: TcxDBMemo;
    ceSUMA_CASH: TcxDBCalcEdit;
    Label1: TLabel;
    ceSUMA_TRANSFER: TcxDBCalcEdit;
    Label2: TLabel;
    Label3: TLabel;
    btnCancel: TcxButton;
    btnOk: TcxButton;
  private
    { Private declarations }
    FCreateNewCredit: Boolean;
    FOnVerifyDateRange: TfrmCustomerCreditEditorOnVerifyDateRange;
    function CheckParams: Boolean;
    procedure SetCreateNewCredit(const Value: Boolean);
    procedure SetOnVerifyDateRange(const Value
      : TfrmCustomerCreditEditorOnVerifyDateRange);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;

    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewCredit: Boolean read FCreateNewCredit
      write SetCreateNewCredit;
    property OnVerifyDateRange: TfrmCustomerCreditEditorOnVerifyDateRange
      read FOnVerifyDateRange write SetOnVerifyDateRange;

  end;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}
{ TForm2 }

function TfrmCustomerCreditEditorDialog.CheckParams: Boolean;
var
  ErrorStr: String;
  f1, f2: Currency;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('DATA').IsNull then
    AddErrorToStr(ErrorStr, 'Inceputul perioadei de creditare!');
  if fMasterDataSet.FieldByName('DATE_END').IsNull then
    AddErrorToStr(ErrorStr, 'Sfarsitul perioadei de creditare!');
  if fMasterDataSet.FieldByName('DATE_END').AsDateTime <
    fMasterDataSet.FieldByName('DATA').AsDateTime then
    AddErrorToStr(ErrorStr,
      'Sfarsitul perioadei de creditare < Inceputul perioadei de creditare!');

  if Assigned(FOnVerifyDateRange) then
  begin
    if Not FOnVerifyDateRange(fMasterDataSet.FieldByName('DATA').AsDateTime,
      fMasterDataSet.FieldByName('DATE_END').AsDateTime) then
      AddErrorToStr(ErrorStr,
        'Perioada de creditare se suprapune cu alte credite!');
  end;

  f1 := 1;
  f2 := 1;
  if fMasterDataSet.FieldByName('SUMA_CASH').IsNull or
    (fMasterDataSet.FieldByName('SUMA_CASH').AsCurrency < 0) then
    AddErrorToStr(ErrorStr, 'Suma creditului in numerar!')
  else
    f1 := fMasterDataSet.FieldByName('SUMA_CASH').AsCurrency;
  if fMasterDataSet.FieldByName('SUMA_TRANSFER').IsNull or
    (fMasterDataSet.FieldByName('SUMA_TRANSFER').AsCurrency < 0) then
    AddErrorToStr(ErrorStr, 'Suma creditului fara numerar!')
  else
    f2 := fMasterDataSet.FieldByName('SUMA_TRANSFER').AsCurrency;
  if (f1 = 0) and (f2 = 0) then
    AddErrorToStr(ErrorStr, 'Suma creditarii!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text,
      ErrorStr);
end;

procedure TfrmCustomerCreditEditorDialog.BindingDataSource;
begin
  inherited;

  FCreateNewCredit := False;

  deStartDate.DataBinding.DataSource := fMasterDataSource;
  deEndDate.DataBinding.DataSource := fMasterDataSource;
  ceSUMA_CASH.DataBinding.DataSource := fMasterDataSource;
  ceSUMA_TRANSFER.DataBinding.DataSource := fMasterDataSource;
  mmComents.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmCustomerCreditEditorDialog.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fMasterDataSet.Post;
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmCustomerCreditEditorDialog.Prepare;
var
  D: TDateTime;
begin
  try
    if FCreateNewCredit then
    begin
      dtDialogTitle.Text := 'Creare credit nou';

      fMasterDataSet.Append;

      D := NOW;
      fMasterDataSet.FieldByName('DATA').AsDateTime := D;
      fMasterDataSet.FieldByName('DATE_END').AsDateTime := D + 1;
      // implicit pentru o zi
      fMasterDataSet.FieldByName('SUMA_CASH').AsCurrency := 0;
      fMasterDataSet.FieldByName('SUMA_TRANSFER').AsCurrency := 0;
      fMasterDataSet.FieldByName('DESCRIPTION').AsString := '';
      fMasterDataSet.FieldByName('USERID').AsInteger := UserID;
    end
    else
    begin
      dtDialogTitle.Text := 'Modificare credit';

      fMasterDataSet.Edit;
    end;
  except
    fMasterDataSet.Cancel;
    raise;
  end;
end;

procedure TfrmCustomerCreditEditorDialog.SetCreateNewCredit
  (const Value: Boolean);
begin
  FCreateNewCredit := Value;
end;

procedure TfrmCustomerCreditEditorDialog.SetOnVerifyDateRange
  (const Value: TfrmCustomerCreditEditorOnVerifyDateRange);
begin
  FOnVerifyDateRange := Value;
end;

procedure TfrmCustomerCreditEditorDialog.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
end;

end.
