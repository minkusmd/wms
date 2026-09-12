unit frame30CassaFirmaUnit;
{
  CASA - Casa organizatiei
  DocTypeID = 1212
  Frame Index = 30
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxStyles, cxGraphics, DB, cxDBData,
  IBC, cxSplitter, cxLabel, Buttons, StdCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, dxBar,
  cxGridPopupMenu, Vcl.ComCtrls, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCurrencyEdit, cxCheckBox, cxContainer,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, DBAccess, cxClasses, MemDS, cxGridTableView, cxGridCustomView, dxUIAClasses;

type
  Tframe30CassaFirma = class(TSWNBaseFrame)
    pnClient: TPanel;
    pnTop: TPanel;
    pnPersonalCassa: TPanel;
    cxGrid ‡ÒÒ‡: TcxGrid;
    cxGrid ‡ÒÒ‡Table: TcxGridDBTableView;
    cxGrid ‡ÒÒ‡Table_CURRENCY_NAME: TcxGridDBColumn;
    cxGrid ‡ÒÒ‡Table_AMOUNT: TcxGridDBColumn;
    cxGrid ‡ÒÒ‡Table_AMOUNT_ACCOUNT: TcxGridDBColumn;
    cxGrid ‡ÒÒ‡Table_AMOUNT_CASH: TcxGridDBColumn;
    cxGrid ‡ÒÒ‡Level: TcxGridLevel;
    pnLeft: TPanel;
    cxGridUsers: TcxGrid;
    cxGridUsersDBTable: TcxGridDBTableView;
    cxGridUsersLevel: TcxGridLevel;
    cxGridUsers_USERID: TcxGridDBColumn;
    cxGridUsers_USER_NAME: TcxGridDBColumn;
    cxGridOI: TcxGrid;
    cxGridOITable: TcxGridDBTableView;
    cxGridOI_DOCID: TcxGridDBColumn;
    cxGridOI_DATA: TcxGridDBColumn;
    cxGridOI_CT_NAME: TcxGridDBColumn;
    cxGridOI_DOCTYPE_NAME: TcxGridDBColumn;
    cxGridOI_SUMA: TcxGridDBColumn;
    cxGridOI_CURRENCY_NAME: TcxGridDBColumn;
    cxGridOI_RATE: TcxGridDBColumn;
    cxGridOI_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridOILevel: TcxGridLevel;
    IBCDataSourcePersonalCash: TIBCDataSource;
    IBCQueryPersonalCash: TIBCQuery;
    IBCQueryOI: TIBCQuery;
    IBCDataSourceOI: TIBCDataSource;
    IBCDataSourceUsers: TIBCDataSource;
    IBCQueryUsers: TIBCQuery;
    Label5: TLabel;
    cxGridUsers_CURRENCYTITLE: TcxGridDBColumn;
    cxGridUsers_SUMA_TOTAL: TcxGridDBColumn;
    dxBarManager: TdxBarManager;
    bbAcceptMoneyTransfer: TdxBarButton;
    IBCQueryNonConfirmedTransfers: TIBCQuery;
    IBCDataSourceNonConfirmedTransfers: TIBCDataSource;
    pmNonConfirmedTransfers: TdxBarPopupMenu;
    cxGridToMe: TcxGrid;
    cxGridToMeTable: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridToMeLevel: TcxGridLevel;
    pmTransferMoney: TdxBarPopupMenu;
    bbTransferMoneyToUser: TdxBarButton;
    bbTransferMoneyToSelf: TdxBarButton;
    IBCTrUpdate: TIBCTransaction;
    cxGridPopupMenuMe: TcxGridPopupMenu;
    cxGridDBColumn10: TcxGridDBColumn;
    cxGridToMe_COMMENT: TcxGridDBColumn;
    cxGridUsers_SUMA_CASH: TcxGridDBColumn;
    cxGridUsersDB_SUMA_CONTAB: TcxGridDBColumn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    pnBottom: TPanel;
    cxLabel2: TcxLabel;
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
    cxSplitter: TcxSplitter;
    Label2: TLabel;
    IBCQueryHist: TIBCQuery;
    IBCDataSourceHist: TIBCDataSource;
    cxGridToMeTRANSFERAT_PRIN: TcxGridDBColumn;
    cxGridToMeTableColumn1: TcxGridDBColumn;
    procedure IBCDataSourceUsersDataChange(Sender: TObject; Field: TField);
    procedure pmNonConfirmedTransfersPopup(Sender: TObject);
    procedure bbAcceptMoneyTransferClick(Sender: TObject);
    procedure bbTransferMoneyToUserClick(Sender: TObject);
    procedure bbTransferMoneyToSelfClick(Sender: TObject);
    procedure cxGridUsersDBTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridUsersDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGrid ‡ÒÒ‡TableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridToMeTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridOITableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridUsersDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid ‡ÒÒ‡TableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridOITableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridToMeTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridHis_DATA_DTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridHisTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    procedure WhenNonAcceptedMoneyTransferMenuPopup;

    procedure ShowMoneyTransferToUserDialog(const UserID:integer=-1; const CurrencyID:integer=-1);
    procedure ShowMoneyTransferToSelfDialog;
    procedure ShowMoneyAcceptDialog;

    procedure OpenData(const FrameDataFilterInfo:TFrameDataFilteringInfo);
    procedure CloseData;
  protected
    { Protected declarations }
    function InitFrameID:integer;override;

    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;

    function GetFrameButtons:TFrameButtons;override;
    function GetFilterFields:TFrameFilterFields;override;

    procedure RefreshData;override;
    procedure WhenFilterDataChanged(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
  public
    { Public declarations }
  end;

implementation

uses DateUtils, DataModuleDB, DataModuleAdditions, frmMoneyAcceptDialog,
  frmMoneyTransferToUserDialog, frmMoneyTransferDialog, SWNSecurity, SWNUtils;

{$R *.dfm}

{ Tframe30CassaFirma }

procedure Tframe30CassaFirma.bbAcceptMoneyTransferClick(Sender: TObject);
begin
     ShowMoneyAcceptDialog;
end;

procedure Tframe30CassaFirma.bbTransferMoneyToSelfClick(Sender: TObject);
begin
     ShowMoneyTransferToSelfDialog;
end;

procedure Tframe30CassaFirma.bbTransferMoneyToUserClick(Sender: TObject);
var targetUser:integer;
    targetCurrency:integer;
begin
     targetUser:=-1;
     targetCurrency:=-1;
     if Not IBCQueryUsers.FieldByName('CURRENCYID').IsNull then targetCurrency:=IBCQueryUsers.FieldByName('CURRENCYID').AsInteger;
     if Not IBCQueryUsers.FieldByName('UserID').IsNull then targetUser:=IBCQueryUsers.FieldByName('USERID').AsInteger;

     ShowMoneyTransferToUserDialog(targetUser,targetCurrency);
end;

procedure Tframe30CassaFirma.CloseData;
begin
     IBCQueryHist.Close;
     IBCQueryNonConfirmedTransfers.Close;
     IBCQueryPersonalCash.Close;
     IBCQueryUsers.Close;
end;

procedure Tframe30CassaFirma.cxGridHisTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe30CassaFirma.cxGridHis_DATA_DTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridHis_DATA_DT.Index])
       then AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridHis_DATA_DT.Index]);
end;

procedure Tframe30CassaFirma.cxGridOITableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe30CassaFirma.cxGridOITableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnUtils.ProcessCommonKeys(Self, cxGridOITable,Key,Shift);
end;

procedure Tframe30CassaFirma.cxGridToMeTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridDBColumn4.index]) then
     begin
          if Not AViewInfo.Selected then
          begin
               // Document prin contabilitate
               if AViewInfo.GridRecord.Values[cxGridDBColumn4.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
          end;
     end;

     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe30CassaFirma.cxGridToMeTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnUtils.ProcessCommonKeys(Self, cxGridToMeTable,Key,Shift);
end;

procedure Tframe30CassaFirma.cxGridUsersDBTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe30CassaFirma.cxGridUsersDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnUtils.ProcessCommonKeys(Self, cxGridUsersDBTable,Key,Shift);
end;

procedure Tframe30CassaFirma.cxGridUsersDBTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if VarIsNumeric(ARecord.Values[cxGridUsers_SUMA_TOTAL.Index]) then
     begin
          if ARecord.Values[cxGridUsers_SUMA_TOTAL.Index]<0 then AStyle:=dmAdditions.cxStyle_TextColorRed;
     end;
end;

procedure Tframe30CassaFirma.cxGrid ‡ÒÒ‡TableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe30CassaFirma.cxGrid ‡ÒÒ‡TableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnUtils.ProcessCommonKeys(Self, cxGrid ‡ÒÒ‡Table,Key,Shift);
end;

procedure Tframe30CassaFirma.DoFrameHide;
begin
     CloseData;

     inherited;
end;

procedure Tframe30CassaFirma.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     OpenData(FrameDataFilterInfo);
end;

function Tframe30CassaFirma.GetFilterFields: TFrameFilterFields;
begin
     Result:=[];
end;

function Tframe30CassaFirma.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
end;

procedure Tframe30CassaFirma.IBCDataSourceUsersDataChange(Sender: TObject; Field: TField);
begin
{
     IBCQueryMT.Close;
     IBCQueryMT.ParamByName('USERID').AsInteger:=IBCQueryUsers.FieldByName('USERID').AsInteger;
     IBCQueryMT.ParamByName('DATA1').AsDate:=fMTDate1;
     IBCQueryMT.ParamByName('DATA2').AsDate:=fMTDate2;
     IBCQueryMT.Open;
}
end;

function Tframe30CassaFirma.InitFrameID: integer;
begin
     Result:=30; // CASA - Casa organizatiei
end;

procedure Tframe30CassaFirma.OpenData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
     CloseData;

     // users
     IBCQueryUsers.ParamByName('DT').AsInteger:=FrameDataFilterInfo.FirmaID;
     IBCQueryUsers.Active:=True;
     // Casa personala
     IBCQueryPersonalCash.Active:=True;
     // Transferuri neacceptate
     IBCQueryNonConfirmedTransfers.Active:=True;
     // Clienti neinchisi
     IBCQueryOI.Active:=True;
     // Istoric transferuri de bani
     IBCQueryHist.Active:=True;

     cxGridUsersDBTable.DataController.Groups.FullExpand;
end;

procedure Tframe30CassaFirma.pmNonConfirmedTransfersPopup(Sender: TObject);
begin
     WhenNonAcceptedMoneyTransferMenuPopup;
end;

procedure Tframe30CassaFirma.RefreshData;
begin
     IBCQueryUsers.Refresh;
     IBCQueryPersonalCash.Refresh;
     IBCQueryNonConfirmedTransfers.Refresh;
     IBCQueryOI.Refresh;
     IBCQueryHist.Refresh;
end;

procedure Tframe30CassaFirma.ShowMoneyAcceptDialog;
var dialog:TfrmMoneyAcceptDlg;
begin
     dialog:=TfrmMoneyAcceptDlg.Create(Self,IBCQueryNonConfirmedTransfers,IBCDataSourceNonConfirmedTransfers);
     try
        if dialog.ShowModal=mrOk then IBCQueryNonConfirmedTransfers.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure Tframe30CassaFirma.ShowMoneyTransferToSelfDialog;
var dialog:TfrmMoneyTransferDlg;
begin
     dialog:=TfrmMoneyTransferDlg.Create(Self);
     try
        dialog.FromUserID := IBCQueryUsers.FieldByName('userid').AsInteger;
        dialog.FromUserName := IBCQueryUsers.FieldByName('userName').AsString;
        dialog.FromDT := dmDB.CurrentFirma;
        dialog.FromDTName := dmDB.CurrentFirmaName;
        if dialog.ShowModal=mrOk then IBCQueryPersonalCash.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure Tframe30CassaFirma.ShowMoneyTransferToUserDialog(const UserID:integer; const CurrencyID: integer);
var dialog:TfrmMoneyTransferToUserDlg;
begin
     dialog:=TfrmMoneyTransferToUserDlg.Create(Self);
     try
        dialog.TargetUserID:=UserID;
        dialog.ShowCurrentUser := True;
        dialog.TargetCurrencyID:=CurrencyID;
        if dialog.ShowModal=mrOk then IBCQueryPersonalCash.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure Tframe30CassaFirma.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
     OpenData(FrameDataFilterInfo);
end;

procedure Tframe30CassaFirma.WhenNonAcceptedMoneyTransferMenuPopup;
var Accept:Boolean;
    selectedUserID:integer;
begin
     Accept:=False;
     if cxGridToMeTable.DataController.RecNo>0 then
     begin
          selectedUserID:=IBCQueryNonConfirmedTransfers.FieldByName('USER_CT').AsInteger;
          Accept:=selectedUserID=SWNSecurityManager.LoggedUser.UserID;
     end;
     bbAcceptMoneyTransfer.Enabled:=Accept;
end;

end.
