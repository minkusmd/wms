unit frame42CassaGlobalFirmeUnit;
{
   ¿——¿ -  ‡ÒÒ‡ ÔÓ ‚ÒÂÏ Ó„‡ÌËÁ‡ˆËˇÏ
  FrameInde = 42
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit, cxStyles, cxGraphics,
  DB, cxDBData, DBAccess, IBC, cxSplitter,
  cxLabel, Buttons, StdCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, ExtCtrls, dxBar,
  cxBarEditItem,
  DataModuleAdditions, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxContainer, cxCalendar,
  cxClasses, MemDS, cxGridCustomView, cxCalc, dxUIAClasses;

type
  Tframe42CassaGlobalFirme = class(TSWNBaseFrame)
    pnClient: TPanel;
    pnTop: TPanel;
    pnMoneyTransfer: TPanel;
    pnPersonalCassa: TPanel;
    pnLeft: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    Label4: TLabel;
    pnBottom: TPanel;
    cxLabel2: TcxLabel;
    IBCDataSourcePersonalCash: TIBCDataSource;
    IBCQueryPersonalCash: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    IBCQueryUsers: TIBCQuery;
    cxSplitter: TcxSplitter;
    Label5: TLabel;
    dxBarManager: TdxBarManager;
    bbAcceptMoneyTransfer: TdxBarButton;
    IBCDataSourceNonConfirmedTransfers: TIBCDataSource;
    IBCQueryNonConfirmedTransfers: TIBCQuery;
    pmNonConfirmedTransfers: TdxBarPopupMenu;
    pmTransferMoney: TdxBarPopupMenu;
    bbTransferMoneyToUser: TdxBarButton;
    bbTransferMoneyToSelf: TdxBarButton;
    IBCTrUpdate: TIBCTransaction;
    IBCDataSourceHist: TIBCDataSource;
    IBCQueryHist: TIBCQuery;
    bbChangeNotReceivedTarget: TdxBarButton;
    cxSpliter1: TcxSplitter;
    dxBarManagerBar1: TdxBar;
    bdcHistoryPeriod: TdxBarDockControl;
    edDateEditHistory1: TcxBarEditItem;
    cxBarEditItem2: TcxBarEditItem;
    cxBarEditItem3: TcxBarEditItem;
    cxBarEditItem4: TcxBarEditItem;
    dxBarButton1: TdxBarButton;
    cxGridHis: TcxGrid;
    cxGridHisTable: TcxGridDBTableView;
    cxGridHis_DATA_DT: TcxGridDBColumn;
    cxGridHis_DT_NAME: TcxGridDBColumn;
    cxGridHis_USER_DT_NAME: TcxGridDBColumn;
    cxGridHis_SUMA_DT: TcxGridDBColumn;
    cxGridHis_CURRENCY_DT_NAME: TcxGridDBColumn;
    cxGridHis_RATE_DT: TcxGridDBColumn;
    cxGridHis_FLG_ACNT_DT: TcxGridDBColumn;
    cxGridHis_DATA_CT: TcxGridDBColumn;
    cxGridHis_CT_NAME: TcxGridDBColumn;
    cxGridHis_USER_CT_NAME: TcxGridDBColumn;
    cxGridHis_FLG_CT_CONFIRMED: TcxGridDBColumn;
    cxGridHis_COMMENT: TcxGridDBColumn;
    cxGridHisLevel: TcxGridLevel;
    cxGridToMe: TcxGrid;
    cxGridToMeTable: TcxGridDBTableView;
    cxGridToMe_FLG_LIVRARE: TcxGridDBColumn;
    cxGridDB_DATA_DT: TcxGridDBColumn;
    cxGridDB_DT_NAME: TcxGridDBColumn;
    cxGridDB_USER_DT_NAME: TcxGridDBColumn;
    cxGridToMe_TRANSFERAT_PRIN: TcxGridDBColumn;
    cxGridDB_FLG_ACNT_DT: TcxGridDBColumn;
    cxGridDB_SUMA_DT: TcxGridDBColumn;
    cxGridDB_CURRENCY_DT_NAME: TcxGridDBColumn;
    cxGridDB_CT_NAME: TcxGridDBColumn;
    cxGridDB_USER_CT_NAME: TcxGridDBColumn;
    cxGridDB_FLG_ACNT_CT: TcxGridDBColumn;
    cxGridToMe_COMMENT: TcxGridDBColumn;
    cxGridToMe_ID: TcxGridDBColumn;
    cxGridToMeTableColumn1: TcxGridDBColumn;
    cxGridToMeTable_USERDT: TcxGridDBColumn;
    cxGridToMeTable_USERCT: TcxGridDBColumn;
    cxGridToMeLevel: TcxGridLevel;
    cxGrid ‡ÒÒ‡: TcxGrid;
    cxGrid ‡ÒÒ‡Table: TcxGridDBTableView;
    cxGrid ‡ÒÒ‡Table_CURRENCY_NAME: TcxGridDBColumn;
    cxGrid ‡ÒÒ‡Table_AMOUNT_ACCOUNT: TcxGridDBColumn;
    cxGrid ‡ÒÒ‡Table_AMOUNT_CASH: TcxGridDBColumn;
    cxGrid ‡ÒÒ‡Table_AMOUNT: TcxGridDBColumn;
    cxGrid ‡ÒÒ‡Level: TcxGridLevel;
    cxGridUsers: TcxGrid;
    cxGridUsersDBTable: TcxGridDBTableView;
    cxGridUsers_USERID: TcxGridDBColumn;
    cxGridUsers_USER_NAME: TcxGridDBColumn;
    cxGridUsers_CURRENCYTITLE: TcxGridDBColumn;
    cxGridUsers_SUMA_CONTAB: TcxGridDBColumn;
    cxGridUsers_SUMA_CASH: TcxGridDBColumn;
    cxGridUsers_SUMA_LIVRARE: TcxGridDBColumn;
    cxGridUsers_SUMA_TOTAL: TcxGridDBColumn;
    cxGridUsers_DISPLAYNAME: TcxGridDBColumn;
    cxGridUsersLevel: TcxGridLevel;
    procedure pmNonConfirmedTransfersPopup(Sender: TObject);
    procedure bbAcceptMoneyTransferClick(Sender: TObject);
    procedure bbTransferMoneyToSelfClick(Sender: TObject);
    procedure bbTransferMoneyToUserClick(Sender: TObject);
    procedure cxGridUsersDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGrid ‡ÒÒ‡TableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridToMeTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridHisTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbChangeNotReceivedTargetClick(Sender: TObject);
    procedure cxGridToMeTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridUsersDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridHis_DATA_DTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
      TcxCustomGridRecord; var AText: string);
    procedure cxGridHisTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridToMe_COMMENTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText:
        string);
    procedure cxGrid ‡ÒÒ‡TableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridUsersDBTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridUsersDBTableStylesGetGroupStyle(Sender: TcxGridTableView; ARecord:
      TcxCustomGridRecord; ALevel: Integer; var AStyle: TcxStyle);
    procedure cxGrid ‡ÒÒ‡TableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure WhenNonAcceptedMoneyTransferMenuPopup;
    procedure ShowMoneyTransferToUserDialog(const SourceDT: Integer = -1; const FirmaID: Integer = -
      1; const UserID: Integer = -1; const CurrencyID: Integer = -1);
    procedure ShowMoneyTransferToSelfDialog;
    procedure ShowMoneyAcceptDialog;
    procedure ShowChangeNotReceivedMoneyTargetDialog;
  protected
    { Protected declarations }
    function InitFrameID: Integer; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;
    procedure SetupSecurityItems; override;
    procedure RefreshData; override;
  public
    { Public declarations }
  end;

implementation

uses
  DateUtils,
  frmMoneyAcceptDialog, frmMoneyTransferToUserDialog, frmMoneyTransferDialog,
  SWNSecurityFlags, SWNSecurity, frmChangeMoneyReceiverDialog, DataModuleDB, SWNUtils;

{$R *.dfm}
{ Tframe30CassaFirma }

procedure Tframe42CassaGlobalFirme.bbAcceptMoneyTransferClick(Sender: TObject);
begin
  ShowMoneyAcceptDialog;
end;

procedure Tframe42CassaGlobalFirme.bbChangeNotReceivedTargetClick(Sender: TObject);
begin
  ShowChangeNotReceivedMoneyTargetDialog;
end;

procedure Tframe42CassaGlobalFirme.bbTransferMoneyToSelfClick(Sender: TObject);
begin
  ShowMoneyTransferToSelfDialog;
end;

procedure Tframe42CassaGlobalFirme.bbTransferMoneyToUserClick(Sender: TObject);
var
  targetFirma, targetUser, targetCurrency, SourceFirma: Integer;
begin
  targetFirma := -1;
  targetUser := -1;
  targetCurrency := -1;
  SourceFirma := 5213;

  if not IBCQueryUsers.FieldByName('DT').IsNull then
    targetFirma := IBCQueryUsers.FieldByName('DT').AsInteger;

  if not IBCQueryUsers.FieldByName('CURRENCYID').IsNull then
    targetCurrency := IBCQueryUsers.FieldByName('CURRENCYID').AsInteger;

  if not IBCQueryUsers.FieldByName('UserID').IsNull then
    targetUser := IBCQueryUsers.FieldByName('USERID').AsInteger;

  if not IBCQueryUsers.FieldByName('DT').IsNull then
    SourceFirma := IBCQueryUsers.FieldByName('DT').AsInteger
  else
    Exception.Create('Nu este introdusa intreprinderea sursa');

  ShowMoneyTransferToUserDialog(SourceFirma, targetFirma, targetUser, targetCurrency);
end;

procedure Tframe42CassaGlobalFirme.cxGridHisTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe42CassaGlobalFirme.cxGridHisTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridHisTable, Key, Shift);
end;

procedure Tframe42CassaGlobalFirme.cxGridHis_DATA_DTGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridHis_DATA_DT.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridHis_DATA_DT.Index]);
end;

procedure Tframe42CassaGlobalFirme.cxGridToMeTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
//  if Not VarIsNull(AViewInfo.GridRecord.Values[cxGridDB_FLG_ACNT_DT.Index]) then
//  begin
//    // Document prin contabilitate
//    if AViewInfo.GridRecord.Values[cxGridDB_FLG_ACNT_DT.Index] = 1 then
//      ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
//  end;

//  // highlight selected row
//  if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
//  begin
//    ACanvas.Brush.Color := $E8E8E8;
//  end;


end;

procedure Tframe42CassaGlobalFirme.cxGridToMeTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridToMeTable, Key, Shift);
end;

procedure Tframe42CassaGlobalFirme.cxGridToMe_COMMENTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
    TcxCustomGridRecord; var AText: string);
begin
//    if not ((dmdb.CurrentUserID = ARecord.Values[cxGridToMeTable_USERDT.Index]) and
//    (dmdb.CurrentUserID = ARecord.Values[cxGridToMeTable_USERCT.Index])) then
//        AText := '';
end;


procedure Tframe42CassaGlobalFirme.cxGridUsersDBTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe42CassaGlobalFirme.cxGridUsersDBTableKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridUsersDBTable, Key, Shift);
end;

procedure Tframe42CassaGlobalFirme.cxGridUsersDBTableStylesGetContentStyle(Sender:
  TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarIsNumeric(ARecord.Values[cxGridUsers_SUMA_TOTAL.Index]) then
  begin
    if ARecord.Values[cxGridUsers_SUMA_TOTAL.Index] < 0 then
      AStyle := dmAdditions.cxStyle_TextColorRed;
  end;
end;

procedure Tframe42CassaGlobalFirme.cxGridUsersDBTableStylesGetGroupStyle(Sender: TcxGridTableView;
  ARecord: TcxCustomGridRecord; ALevel: Integer; var AStyle: TcxStyle);
begin
  if ALevel = 0 then
    AStyle := dmAdditions.cxStyle_Bold
  else if ALevel = 1 then
    AStyle := dmAdditions.cxStyle_TextColorGreen;
end;

procedure Tframe42CassaGlobalFirme.cxGrid ‡ÒÒ‡TableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe42CassaGlobalFirme.cxGrid ‡ÒÒ‡TableKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGrid ‡ÒÒ‡Table, Key, Shift);
end;

procedure Tframe42CassaGlobalFirme.cxGrid ‡ÒÒ‡TableStylesGetContentStyle(Sender:
  TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarIsNumeric(ARecord.Values[cxGrid ‡ÒÒ‡Table_AMOUNT.Index]) then
  begin
    if ARecord.Values[cxGrid ‡ÒÒ‡Table_AMOUNT.Index] < 0 then
      AStyle := dmAdditions.cxStyle_TextColorRed;
  end;
end;

procedure Tframe42CassaGlobalFirme.DoFrameHide;
begin
  // IBCQueryOI.Options.DetailDelay:=0;
  // IBCQueryOI.Active:=False;

  IBCQueryPersonalCash.Options.DetailDelay := 0;
  IBCQueryPersonalCash.Active := False;

  IBCQueryUsers.Active := False;

  inherited;
end;

procedure Tframe42CassaGlobalFirme.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  // users
  IBCQueryUsers.Active := True;
  // œÂÒÓÌ‡Î¸Ì‡ˇ Í‡ÒÒ‡
  IBCQueryPersonalCash.Active := True;
  // ÕÂÔËÌˇÚ˚Â ÔÂÂ‰‡˜Ë
  IBCQueryNonConfirmedTransfers.Active := True;
  // »ÒÚÓËˇ
//  edDateEditHistory1.Properties.
  IBCQueryHist.Active := True;

  cxGridUsersDBTable.DataController.Groups.FullExpand;
end;

procedure Tframe42CassaGlobalFirme.dxBarButton1Click(Sender: TObject);
begin
  inherited;
  IBCQueryHist.Close;
end;

function Tframe42CassaGlobalFirme.GetFilterFields: TFrameFilterFields;
begin
  Result := [];
end;

function Tframe42CassaGlobalFirme.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
end;

function Tframe42CassaGlobalFirme.InitFrameID: Integer;
begin
  Result := 42; //  ¿——¿ -  ‡ÒÒ‡ ÔÓ ‚ÒÂÏ Ó„‡ÌËÁ‡ˆËˇÏ
end;

procedure Tframe42CassaGlobalFirme.pmNonConfirmedTransfersPopup(Sender: TObject);
begin
  WhenNonAcceptedMoneyTransferMenuPopup;
end;

procedure Tframe42CassaGlobalFirme.RefreshData;
begin
  IBCQueryUsers.Refresh;
  IBCQueryNonConfirmedTransfers.Refresh;
  IBCQueryPersonalCash.Refresh;
  IBCQueryHist.Refresh;
end;

procedure Tframe42CassaGlobalFirme.SetupSecurityItems;
begin
//  if not ((SWNSecurityManager.UserIsPartOfGroup(cUserGroup_¿‰ÏËÌËÒÚ‡ÚÓ)) or (SWNSecurityManager.UserIsPartOfGroup(cUserGroup_ADM_Aprovizionari))) then
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_CASA_CPO_Modifica_beneficialul_transferului) then
    bbChangeNotReceivedTarget.Visible := ivNever;

  if not SWNSecurityManager.LoggedUser.IsSuperAdminUser then
    bdcHistoryPeriod.Visible := false;
end;

procedure Tframe42CassaGlobalFirme.ShowChangeNotReceivedMoneyTargetDialog;
var
  dialog: TfrmChangeMoneyReceiverDlg;
begin
  dialog := TfrmChangeMoneyReceiverDlg.Create(Self);
  try
    dialog.JurnalID := IBCQueryNonConfirmedTransfers.FieldByName('ID').AsInteger;
    dialog.DT_UserName := IBCQueryNonConfirmedTransfers.FieldByName('USER_DT_NAME').AsString;
    dialog.DT_Name := IBCQueryNonConfirmedTransfers.FieldByName('DT_NAME').AsString;
    dialog.CT := IBCQueryNonConfirmedTransfers.FieldByName('CT').AsInteger;
    dialog.UserID := IBCQueryNonConfirmedTransfers.FieldByName('USER_CT').AsInteger;
    dialog.ShowCurrentUsed := True;
    if dialog.ShowModal = mrOk then
      IBCQueryNonConfirmedTransfers.RefreshRecord;
  finally
    dialog.Free;
  end;
end;

procedure Tframe42CassaGlobalFirme.ShowMoneyAcceptDialog;
var
  dialog: TfrmMoneyAcceptDlg;
begin
  dialog := TfrmMoneyAcceptDlg.Create(Self, IBCQueryNonConfirmedTransfers,
    IBCDataSourceNonConfirmedTransfers);
  try
    if dialog.ShowModal = mrOk then
      IBCQueryNonConfirmedTransfers.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe42CassaGlobalFirme.ShowMoneyTransferToSelfDialog;
var
  dialog: TfrmMoneyTransferDlg;
begin
  dialog := TfrmMoneyTransferDlg.Create(Self);
  try
    dialog.FromDT := IBCQueryUsers.FieldByName('DT').AsInteger;
    dialog.FromUserID := IBCQueryUsers.FieldByName('USERID').AsInteger;
//    dialog.Suma := IBCQueryUsers.FieldByName('SUMA').AsFloat;
    if dialog.ShowModal = mrOk then
      IBCQueryPersonalCash.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe42CassaGlobalFirme.ShowMoneyTransferToUserDialog(const SourceDT, FirmaID, UserID,
  CurrencyID: Integer);
var
  dialog: TfrmMoneyTransferToUserDlg;
begin
  dialog := TfrmMoneyTransferToUserDlg.Create(Self);
  try
    dialog.SourceDT := SourceDT;
    dialog.TargetFirmaID := FirmaID;
    dialog.TargetUserID := UserID;
    dialog.TargetCurrencyID := CurrencyID;
    dialog.ShowCurrentUser := True;
    if dialog.ShowModal = mrOk then
      IBCQueryPersonalCash.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe42CassaGlobalFirme.WhenNonAcceptedMoneyTransferMenuPopup;
var
  Accept: Boolean;
begin
  Accept := False;
  if cxGridToMeTable.DataController.RecNo > 0 then
  begin
    Accept := True;
  end;
  bbAcceptMoneyTransfer.Enabled := Accept;
  bbChangeNotReceivedTarget.Enabled := Accept;
end;

end.

