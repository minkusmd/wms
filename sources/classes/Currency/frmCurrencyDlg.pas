unit frmCurrencyDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs,
  IBC, DB, cxDBData, dxBar, StdCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, DialogTitle, cxButtons, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxLabel, Vcl.Menus, DBAccess, MemDS,
  cxClasses, cxGridCustomView;

type
  TfrmCurrencyDialog = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridCurrencyTable: TcxGridDBTableView;
    cxGridCurrencyLevel: TcxGridLevel;
    cxGridCurrency: TcxGrid;
    cxGridCurrencyTableColumn1: TcxGridDBColumn;
    cxGridCurrency_TITLE: TcxGridDBColumn;
    cxGridCurrencyTableColumn3: TcxGridDBColumn;
    cxGridCurrencyTableColumn6: TcxGridDBColumn;
    dxBarSubItem1: TdxBarSubItem;
    dxBarManager1Bar1: TdxBar;
    IBCQueryCurrency: TIBCQuery;
    IBCDataSourceCurrency: TIBCDataSource;
    bbChangeRate: TdxBarButton;
    bbCurrencyHistory: TdxBarButton;
    Panel1: TPanel;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    procedure bbAddCurrencyClick(Sender: TObject);
    procedure bbEditCurrencyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IBCQueryCurrencyBeforePost(DataSet: TDataSet);
    procedure IBCDataSourceCurrencyDataChange(Sender: TObject; Field: TField);
    procedure cxGridCurrencyTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbChangeRateClick(Sender: TObject);
    procedure cxGridCurrencyTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbCurrencyHistoryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FReadOnly: Boolean;
    { Private declarations }
    procedure SelectionChanged;
    procedure ShowModifyCurrencyRateDialog;
    procedure ShowCurrencyHistory(const CurrencyID: integer; const Title: string);
    procedure SetReadOnly(const Value: Boolean);
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
  public
    IsCurrencyRateChanged: Boolean;
    { Public declarations }
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  SWNUtils, SWNConst, frmCurrencyEditorDialog, SWNSecurityFlags, frmCurrencyHistoryDialog;

{$R *.dfm}
{ TfrmCurrencyDialog }

procedure TfrmCurrencyDialog.bbAddCurrencyClick(Sender: TObject);
begin
  IBCQueryCurrency.Append;
end;

procedure TfrmCurrencyDialog.bbChangeRateClick(Sender: TObject);
begin
  ShowModifyCurrencyRateDialog;
end;

procedure TfrmCurrencyDialog.bbCurrencyHistoryClick(Sender: TObject);
begin
  ShowCurrencyHistory(IBCQueryCurrency.FieldByName('CURRENCYID').AsInteger, IBCQueryCurrency.FieldByName
    ('TITLE').asString);
end;

procedure TfrmCurrencyDialog.bbEditCurrencyClick(Sender: TObject);
begin
  IBCQueryCurrency.Edit;
  cxGridCurrencyTable.Columns[cxGridCurrencyTable.Controller.FocusedColumnIndex].Editing := True;
end;

procedure TfrmCurrencyDialog.cxGridCurrencyTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var
  AHandled: Boolean);
begin
  if bbChangeRate.Enabled and dxBarManager1Bar1.Visible then
  begin
    bbChangeRateClick(bbChangeRate);
    AHandled := True;
  end;
end;

procedure TfrmCurrencyDialog.cxGridCurrencyTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmCurrencyDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if IBCQueryCurrency.State in dsEditModes then
  begin
    case ShowAskDialog('Modificari efectuate!', 'Salvam modificarile?') of
      mrYes:
        IBCQueryCurrency.Post;
      mrNo:
        IBCQueryCurrency.Cancel;
      // mrCancel: Action:=caNone;
    end;
  end;
end;

procedure TfrmCurrencyDialog.FormCreate(Sender: TObject);
begin
  FReadOnly := False;
end;

procedure TfrmCurrencyDialog.IBCDataSourceCurrencyDataChange(Sender: TObject; Field: TField);
begin
  SelectionChanged;
end;

procedure TfrmCurrencyDialog.IBCQueryCurrencyBeforePost(DataSet: TDataSet);
var
  ErrorStr: string;
begin
  ErrorStr := '';
  // check fields
  if IBCQueryCurrency.FieldByName('CURRENCYID').IsNull then
    AddErrorToStr(ErrorStr, 'ID valuta nu este indicat!');
  if IBCQueryCurrency.FieldByName('TITLE').IsNull then
    AddErrorToStr(ErrorStr, 'Denumirea nu este indicata!');
  if IBCQueryCurrency.FieldByName('SHORTNAME').IsNull then
    AddErrorToStr(ErrorStr, 'Simbol valuta nu este indicat!');
  if IBCQueryCurrency.FieldByName('BNM_RATE').IsNull then
    AddErrorToStr(ErrorStr, 'Rata BNM nu este indicata!');
  if IBCQueryCurrency.FieldByName('EXCHANGE_RATE').IsNull then
    AddErrorToStr(ErrorStr, 'Rata numerar nu este indicata!');
  if IBCQueryCurrency.FieldByName('TRANSFER_RATE').IsNull then
    AddErrorToStr(ErrorStr, 'Rata transfer nu este indicata!');

  if ErrorStr <> '' then
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmCurrencyDialog.Prepare;
begin
  SetupSecurityItems;

  IBCQueryCurrency.Active := True;
  cxGridCurrency_TITLE.Focused := True;
  SelectionChanged;

  IsCurrencyRateChanged := false;

end;

procedure TfrmCurrencyDialog.SelectionChanged;
var
  fChangeRate: Boolean;
begin
  fChangeRate := False;
  if cxGridCurrencyTable.DataController.RecNo > 0 then
  begin
    fChangeRate := True; // Modifica cursul +Security
  end;
  bbChangeRate.Enabled := fChangeRate;
  bbCurrencyHistory.Enabled := fChangeRate;
end;

procedure TfrmCurrencyDialog.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmCurrencyDialog.SetupSecurityItems;
begin
  if SecurityFlagEnabled(cSecurityFlag_Справочники_Валюта_Изменить_курс_валюты) then
  begin
    dtDialogTitle.Text := 'Modifica ratele de schimb';
  end
  else
  begin
    dxBarManager1Bar1.Visible := False;
    dxBarDockControl1.Visible := False;
    dtDialogTitle.Text := 'Vizionarea ratelor de schimb';
  end;
end;

procedure TfrmCurrencyDialog.ShowCurrencyHistory(const CurrencyID: integer; const Title: string);
var
  dialog: TfrmCurrencyHistoryDlg;
begin
  dialog := TfrmCurrencyHistoryDlg.Create(Self);
  try
    dialog.SetCurrencyInfo(CurrencyID, Title);
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCurrencyDialog.ShowModifyCurrencyRateDialog;
var
  dialog: TfrmCurrencyEditorDlg;
  OldTransferRate: Double;
begin
  OldTransferRate := IBCQueryCurrency.FieldByName('TRANSFER_RATE').AsFloat;
  dialog := TfrmCurrencyEditorDlg.Create(Self, IBCQueryCurrency, IBCDataSourceCurrency);
  try
    if (dialog.ShowModal = mrOk) and (not IsCurrencyRateChanged) then
    begin
      IsCurrencyRateChanged := OldTransferRate <> IBCQueryCurrency.FieldByName('TRANSFER_RATE').AsFloat;
    end;
  finally
    dialog.Free;
  end;
end;

end.

