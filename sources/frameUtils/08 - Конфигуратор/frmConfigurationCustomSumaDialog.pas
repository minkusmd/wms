unit frmConfigurationCustomSumaDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Menus, SWNBaseUnit,
  StdCtrls, DialogTitle, ExtCtrls,
  cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, cxGridLevel, cxGrid,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxLabel, cxClasses,
  cxRadioGroup;

type

  TfrmConfigurationCustomSumaDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    lbCurrency: TLabel;
    lbInfo: TLabel;
    edAddSuma: TEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    edAddPercent: TEdit;
    Label1: TLabel;
    rbPercent: TcxRadioButton;
    rbSuma: TcxRadioButton;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure rbSumaClick(Sender: TObject);
  private
    fAddedPercent: Integer;
    { Private declarations }
    fInComplect: Boolean;
    fAddedSuma: Integer;
    fSuma: Currency;
    fSumaForTVA: Currency;
    procedure PrepareView;
    function CheckParams: Boolean;
    procedure SetInComplect(const Value: Boolean);
    procedure SetCurrencyTitle(const Value: String);
    procedure BuildPressetList;
    procedure SetAddedPercent(const Value: Integer);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    property InComplect: Boolean read fInComplect write SetInComplect;
    property AddedSuma: Integer read fAddedSuma;
    property Suma: Currency read fSuma write fSuma;
    property SumaForTVA: Currency read fSumaForTVA write fSumaForTVA;
    property CurrencyTitle: String write SetCurrencyTitle;
  published
    property AddedPercent: Integer read fAddedPercent write SetAddedPercent;
  end;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}
{ TfrmConfigurationCustomSumaCountDlg }

procedure TfrmConfigurationCustomSumaDlg.BuildPressetList;
// var
// N, K: Integer;
// i, Index: Integer;
// step: Integer;
// p: double;
begin
  // cxGridTable.BeginUpdate;
  // try
  // N := Round(fSuma);
  //
  // if fSuma <= 10000 then
  // step := 50
  // else
  // step := 100;
  //
  // N := (N div step) * step;
  // for i := 1 to 8 do
  // begin
  // Inc(N, step);
  // K := Round(N - fSuma);
  // p := (K * 100 / fSuma);
  //
  // Index := cxGridTable.DataController.AppendRecord;
  // cxGridTable.DataController.Values[Index, cxGridTable_SUMA.Index] := N;
  // cxGridTable.DataController.Values[Index, cxGridTable_ADDON.Index] := N - fSuma;
  // cxGridTable.DataController.Values[Index, cxGridTable_PERCENT.Index] := Format('%4.2f%%', [p]);
  // end;
  //
  // // TVA, inapoi
  // p := -20;
  // N := Round(fSumaForTVA - (fSumaForTVA / 6));
  // Index := cxGridTable.DataController.AppendRecord;
  // cxGridTable.DataController.Values[Index, cxGridTable_SUMA.Index] := 'Возврат НДС';
  // cxGridTable.DataController.Values[Index, cxGridTable_ADDON.Index] := N - fSumaForTVA;
  // cxGridTable.DataController.Values[Index, cxGridTable_PERCENT.Index] := Format('%4.2f%%', [p]);
   edAddPercent.Text := AddedPercent.ToString;
  // finally
  // cxGridTable.EndUpdate;
  // end;
end;

function TfrmConfigurationCustomSumaDlg.CheckParams: Boolean;
var
  ErrorStr: String;
  N: Integer;
begin
  Result := False;
  ErrorStr := '';

  N := StrToIntDef(edAddSuma.Text, 0);
  if (rbSuma.Checked) and (N = 0) then
    AddErrorToStr(ErrorStr, 'Неправильное значение для добавляемой суммы!');

  N := StrToIntDef(edAddPercent.Text, 0);
  if (rbPercent.Checked) and (N = 0) then
    AddErrorToStr(ErrorStr, 'Неправильное значение для процента!');

  if (N > fSuma) then
    AddErrorToStr(ErrorStr, 'Добавляемая сумма слишком большая!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, ErrorStr);
end;

procedure TfrmConfigurationCustomSumaDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  // if Assigned(AFocusedRecord) then
  // begin
  // edAddSuma.Text := AFocusedRecord.Values[cxGridTable_ADDON.Index];
  // end
  // else
  // edAddSuma.Text := '0';
end;

procedure TfrmConfigurationCustomSumaDlg.rbSumaClick(Sender: TObject);
begin
  edAddSuma.Enabled := rbSuma.Checked;
  edAddPercent.Enabled := rbPercent.Checked;
end;

function TfrmConfigurationCustomSumaDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fAddedSuma := StrToIntDef(edAddSuma.Text, 0);
    fAddedPercent := StrToIntDef(edAddPercent.Text, 0);
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmConfigurationCustomSumaDlg.Prepare;
begin
  BuildPressetList;
end;

procedure TfrmConfigurationCustomSumaDlg.PrepareView;
begin
  if fInComplect then
  begin
    dtDialogTitle.Title := 'Изменение суммы комплекта';
    lbInfo.Caption := '';
  end
  else
  begin
    dtDialogTitle.Title := 'Изменение суммы базового состава';
    lbInfo.Caption := 'Операция не изменяет сумму комплектов.';
  end;
  Caption := dtDialogTitle.Title;
end;

procedure TfrmConfigurationCustomSumaDlg.SetAddedPercent(const Value: Integer);
begin
  fAddedPercent := Value;
end;

procedure TfrmConfigurationCustomSumaDlg.SetCurrencyTitle(const Value: String);
begin
  lbCurrency.Caption := Value;
end;

procedure TfrmConfigurationCustomSumaDlg.SetInComplect(const Value: Boolean);
begin
  fInComplect := Value;
  PrepareView;
end;

end.
