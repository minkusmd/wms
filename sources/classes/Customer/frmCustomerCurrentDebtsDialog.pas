unit frmCustomerCurrentDebtsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, StdCtrls,
  ExtCtrls, cxGraphics, cxPC, DB, cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGrid, IBC, cxButtons,
  dxBarBuiltInMenu, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxCurrencyEdit, Vcl.Menus,
  DBAccess, MemDS, cxGridTableView, cxClasses, cxGridCustomView, System.Actions, Vcl.ActnList,
  dxUIAClasses;

type
  TfrmCustomerCurrentDebtsDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    pcPageControl: TcxPageControl;
    tbsGeneral: TcxTabSheet;
    edDISPLAYNAME: TEdit;
    edCUSTOMERID: TEdit;
    tbsNoAccess: TcxTabSheet;
    Label6: TLabel;
    IBCQueryFirms: TIBCQuery;
    IBCDataSourceFirms: TIBCDataSource;
    Shape1: TShape;
    Shape2: TShape;
    Label3: TLabel;
    Label4: TLabel;
    cxPageControl1: TcxPageControl;
    tbsContract: TcxTabSheet;
    tbsCashTransfer: TcxTabSheet;
    cxGridFirms: TcxGrid;
    cxGridFirmsTable: TcxGridDBTableView;
    cxGridFirms_BRAND_NAME: TcxGridDBColumn;
    cxGridFirmsCONTRACT: TcxGridDBColumn;
    cxGridFirms_SUMA_CASH: TcxGridDBColumn;
    cxGridFirms_SUMA_TRANSFER: TcxGridDBColumn;
    cxGridFirms_SUMA_TRANSFER_USD: TcxGridDBColumn;
    cxGridLevelFirms: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    IBCQueryCashTransfer: TIBCQuery;
    IBCDataSourceCashTransfer: TIBCDataSource;
    cxGridFirmsTableColumn1: TcxGridDBColumn;
    btnClose: TcxButton;
    btnHistoryContract: TcxButton;
    Button1: TcxButton;
    btnHistoryCash: TcxButton;
    btnHistoryTransfer: TcxButton;
    ActionList1: TActionList;
    actAccountingDebts: TAction;
    cxGridFirmsTable_DATA_END: TcxGridDBColumn;
    cxGridFirms_CONTRACTID: TcxGridDBColumn;
    procedure actAccountingDebtsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnHistoryCashClick(Sender: TObject);
    procedure btnHistoryTransferClick(Sender: TObject);
    procedure cxGridFirms_SUMA_TRANSFERCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridFirms_TOTALCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnHistoryContractClick(Sender: TObject);
    procedure cxGridFirmsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridFirmsTable_DATA_ENDCustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridFirms_SUMA_CASHCustomDrawCell(Sender: TcxCustomGridTableView;
        ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone:
        Boolean);
  private
    { Private declarations }
    FCustomerID: Integer;
    fActivePageIndex: Integer;
    procedure SetCustomerID(const Value: Integer);
    procedure ShowAccountingDebts;
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    { Public declarations }
    property CustomerID: Integer read FCustomerID write SetCustomerID;
  end;

implementation

uses
  DataModuleDB, SWNSecurityFlags, DateUtils, frmCustomerCurrentDebtsNalDialog, frmCustomerCurrentDebtsTransferDialog,
  frmCustomerCurrentDebtsContractDialog, SWNValueStorageUnit;

{$R *.dfm}

procedure TfrmCustomerCurrentDebtsDlg.actAccountingDebtsExecute(Sender: TObject);
begin
  ShowAccountingDebts;
end;

{ TfrmCustomerCurrentDebtsDlg }

procedure TfrmCustomerCurrentDebtsDlg.btnHistoryCashClick(Sender: TObject);
var
  dialog: TfrmCustomerCurrentDebtsNalDlg;
begin
  dialog := TfrmCustomerCurrentDebtsNalDlg.Create(Self);
  try
    dialog.CustomerID := FCustomerID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerCurrentDebtsDlg.btnHistoryContractClick(Sender: TObject);
var
  dialog: TfrmCustomerCurrentDebtsContractDlg;
begin
  if IBCQueryFirms.RecNo > 0 then
  begin
    dialog := TfrmCustomerCurrentDebtsContractDlg.Create(Self, dmDB.IBCConnection);
    try
      dialog.CustomerID := FCustomerID;
      dialog.OrgID := IBCQueryFirms.FieldByName('OrgID').AsInteger;
      dialog.FLG_Upr := 1;
      dialog.FLG_Buh := 0;
      dialog.ContractID := IBCQueryFirms.FieldByName('CONTRACTID').AsString;
      dialog.ShowModal;
      IBCQueryFirms.Close;
      IBCQueryFirms.Open;
    finally
      dialog.Free;
    end;
  end;
end;

procedure TfrmCustomerCurrentDebtsDlg.btnHistoryTransferClick(Sender: TObject);
var
  dialog: TfrmCustomerCurrentDebtsTransferDlg;
begin
  dialog := TfrmCustomerCurrentDebtsTransferDlg.Create(Self);
  try
    dialog.CustomerID := FCustomerID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerCurrentDebtsDlg.cxGridFirmsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
//  if not AViewInfo.Selected then
//    if (AViewInfo.GridRecord.Values[cxGridFirmsTable_DATA_END.Index] <= Date) and
//       (AViewInfo.GridRecord.Values[cxGridFirms_CONTRACTID.Index] > 0) then
//    begin
//      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
//    end;
end;

procedure TfrmCustomerCurrentDebtsDlg.cxGridFirmsTable_DATA_ENDCustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
if not VarIsNull(AViewInfo.Value) then
//  begin
//    if AViewInfo.Value < 0 then
//      ACanvas.Font.Color := clRed // Datoreaza noua
//    else if AViewInfo.Value > 0 then
//      ACanvas.Font.Color := clBlue;  // noi datoram
//  end;
end;

procedure TfrmCustomerCurrentDebtsDlg.cxGridFirms_SUMA_CASHCustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
//   if not VarIsNull(AViewInfo.Value) then
//  begin
//    if AViewInfo.Value < 0 then
//      ACanvas.Font.Color := clRed// Datorie
//    else if AViewInfo.Value > 0 then
//      ACanvas.Font.Color := clBlue;  // noi datoram
//  end;
end;

procedure TfrmCustomerCurrentDebtsDlg.cxGridFirms_SUMA_TRANSFERCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
  TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
//  if not VarIsNull(AViewInfo.Value) then
//  begin
//    if AViewInfo.Value < 0 then
//      ACanvas.Font.Color := clRed// Datorie
//    else if AViewInfo.Value > 0 then
//      ACanvas.Font.Color := clBlue;  // noi datoram
//  end;
end;

procedure TfrmCustomerCurrentDebtsDlg.cxGridFirms_TOTALCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
//  if not VarIsNull(AViewInfo.Value) then
//  begin
//    if AViewInfo.Value < 0 then
//      ACanvas.Font.Color := clRed// Datorie
//    else if AViewInfo.Value > 0 then
//      ACanvas.Font.Color := clBlue;  // noi datoram
//  end;
end;

procedure TfrmCustomerCurrentDebtsDlg.FormCreate(Sender: TObject);
begin
  FCustomerID := -1;
  pcPageControl.ActivePage := tbsGeneral;
end;

procedure TfrmCustomerCurrentDebtsDlg.LoadStates;
begin
  inherited;
  fActivePageIndex := AppUserConfigStorage.IntValues.GetValue('frmCustomerCurrentDebtsDialog_ActivePageIndex', 0);
end;

procedure TfrmCustomerCurrentDebtsDlg.Prepare;
begin
  SetupSecurityItems;
  edCUSTOMERID.Text := IntToStr(FCustomerID);
  edDISPLAYNAME.Text := dmDB.GetCustomerDisplayName(FCustomerID);
  pcPageControl.HideTabs := True;
  cxPageControl1.ActivePageIndex := fActivePageIndex;

  if dmDB.CheckIfCustomerIsEmployer(FCustomerID) then
  begin
    pcPageControl.ActivePage := tbsNoAccess;
  end
  else
  begin
    if cxPageControl1.ActivePageIndex = 0 then
    begin
      IBCQueryFirms.ParamByName('CustomerID').AsInteger := FCustomerID;
      IBCQueryFirms.Active := True;
    end;
    if cxPageControl1.ActivePageIndex = 1 then
    begin
      IBCQueryCashTransfer.Close;
      IBCQueryCashTransfer.ParamByName('CUSTOMERID').AsInteger := FCustomerID;
      IBCQueryCashTransfer.Open;
    end;
  end;
end;

procedure TfrmCustomerCurrentDebtsDlg.SaveStates;
begin
  inherited;
  AppUserConfigStorage.IntValues.SetValue('frmCustomerCurrentDebtsDialog_ActivePageIndex', cxPageControl1.ActivePageIndex);
end;

procedure TfrmCustomerCurrentDebtsDlg.SetCustomerID(const Value: Integer);
begin
  FCustomerID := Value;
end;

procedure TfrmCustomerCurrentDebtsDlg.SetupSecurityItems;
begin
  btnHistoryCash.Visible := SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Текущие_долги_контрагента_История_наличные);
  btnHistoryTransfer.Visible := SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Текущие_долги_контрагента_История_безналичные);
end;

procedure TfrmCustomerCurrentDebtsDlg.ShowAccountingDebts;
var
  dialog: TfrmCustomerCurrentDebtsContractDlg;
begin
  if IBCQueryFirms.RecNo > 0 then
  begin
    dialog := TfrmCustomerCurrentDebtsContractDlg.Create(Self, dmDB.IBCConnection);
    try
      dialog.CustomerID := FCustomerID;
      dialog.FLG_Upr := 0;
      dialog.FLG_Buh := 1;
      dialog.ContractID := IBCQueryFirms.FieldByName('CONTRACTID').AsString;
      dialog.OrgID := IBCQueryFirms.FieldByName('OrgID').AsInteger;
      dialog.ShowModal;
      IBCQueryFirms.Refresh;
    finally
      dialog.Free;
    end;
  end;
end;

end.

