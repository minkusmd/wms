unit frame12CassaPersonalUnit;

// CASA. Casa personala
// DocTypeID = 1206
// Frame Index = 12

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  cxGraphics, DB, cxDBData,
  dxBar, IBC, cxGridLevel, cxGridCustomTableView, cxGridDBTableView,
  cxGrid, cxLabel, ExtCtrls,
  cxGridPopupMenu, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCurrencyEdit, cxCheckBox,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, DBAccess, cxClasses, MemDS, cxGridTableView, cxGridCustomView, dxUIAClasses;

type
  Tframe12CassaPersonal = class(TSWNBaseFrame)
    IBCQueryPersonalCash: TIBCQuery;
    IBCDataSourcePersonalCash: TIBCDataSource;
    pnBottom: TPanel;
    cxLabel1: TcxLabel;
    cxGridOI: TcxGrid;
    cxGridOITable: TcxGridDBTableView;
    cxGridOILevel: TcxGridLevel;
    Panel7: TPanel;
    pnMoneyTransfer: TPanel;
    cxLabel2: TcxLabel;
    Panel1: TPanel;
    cxLabel8: TcxLabel;
    cxGridКасса: TcxGrid;
    cxGridКассаTable: TcxGridDBTableView;
    cxGridКассаTable_CURRENCY_NAME: TcxGridDBColumn;
    cxGridКассаTable_AMOUNT: TcxGridDBColumn;
    cxGridКассаTable_AMOUNT_ACCOUNT: TcxGridDBColumn;
    cxGridКассаTable_AMOUNT_CASH: TcxGridDBColumn;
    cxGridКассаLevel: TcxGridLevel;
    IBCQueryOI: TIBCQuery;
    IBCDataSourceOI: TIBCDataSource;
    cxGridOI_DOCID: TcxGridDBColumn;
    cxGridOI_DATA: TcxGridDBColumn;
    cxGridOI_CT_NAME: TcxGridDBColumn;
    cxGridOI_DOCTYPE_NAME: TcxGridDBColumn;
    cxGridOI_SUMA: TcxGridDBColumn;
    cxGridOI_CURRENCY_NAME: TcxGridDBColumn;
    cxGridOI_RATE: TcxGridDBColumn;
    cxGridOI_CREATED_BY_NAME: TcxGridDBColumn;
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
    IBCDataSourceNonConfirmedTransfers: TIBCDataSource;
    IBCQueryNonConfirmedTransfers: TIBCQuery;
    dxBarManager: TdxBarManager;
    bbAcceptMoneyTransfer: TdxBarButton;
    pmTransferMoney: TdxBarPopupMenu;
    bbTransferMoneyToUser: TdxBarButton;
    bbTransferMoneyToSelf: TdxBarButton;
    IBCTrUpdate: TIBCTransaction;
    cxGridPopupMenuMe: TcxGridPopupMenu;
    cxGridToMe_COMMENT: TcxGridDBColumn;
    pmNonConfirmedTransfers: TdxBarPopupMenu;
    procedure pmNonConfirmedTransfersPopup(Sender: TObject);
    procedure bbAcceptMoneyTransferClick(Sender: TObject);
    procedure bbTransferMoneyToUserClick(Sender: TObject);
    procedure bbTransferMoneyToSelfClick(Sender: TObject);
    procedure cxGridКассаTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridToMeTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridOITableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridToMeTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridOITableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridКассаTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    procedure OpenData;
    procedure CloseData;
    procedure WhenNonAcceptedMoneyTransferMenuPopup;

    procedure ShowMoneyTransferToUserDialog(const CurrencyID:integer=-1);
    procedure ShowMoneyTransferToSelfDialog;
    procedure ShowMoneyAcceptDialog;
  protected
    { Protected declarations }
    function InitFrameID:integer;override;

    function GetExternalDataSourceTypes:TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;
    function GetFrameButtons:TFrameButtons;override;
    function GetFilterFields:TFrameFilterFields;override;

    procedure RefreshData;override;
  public
    { Public declarations }
    procedure RefreshInfo;
  end;


implementation

uses DataModuleDB, frmMoneyAcceptDialog,
  frmMoneyTransferToUserDialog, frmMoneyTransferDialog, SWNUtils;

{$R *.dfm}

{ Tframe12CassaPersonal }

procedure Tframe12CassaPersonal.bbAcceptMoneyTransferClick(Sender: TObject);
begin
     ShowMoneyAcceptDialog;
end;

procedure Tframe12CassaPersonal.bbTransferMoneyToSelfClick(Sender: TObject);
begin
     ShowMoneyTransferToSelfDialog;
end;

procedure Tframe12CassaPersonal.bbTransferMoneyToUserClick(Sender: TObject);
begin
     if IBCQueryPersonalCash.FieldByName('CURRENCYID').IsNull
      then ShowMoneyTransferToUserDialog
      else ShowMoneyTransferToUserDialog(IBCQueryPersonalCash.FieldByName('CURRENCYID').AsInteger);
end;

procedure Tframe12CassaPersonal.CloseData;
begin
     IBCQueryPersonalCash.Active:=False;
     IBCQueryOI.Active:=False;
end;

procedure Tframe12CassaPersonal.cxGridOITableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe12CassaPersonal.cxGridOITableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     ProcessCommonKeys(self, cxGridOITable,Key,Shift);
end;

procedure Tframe12CassaPersonal.cxGridToMeTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe12CassaPersonal.cxGridToMeTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self, cxGridToMeTable,Key,Shift);
end;

procedure Tframe12CassaPersonal.cxGridКассаTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe12CassaPersonal.cxGridКассаTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self, cxGridКассаTable,Key,Shift);
end;

procedure Tframe12CassaPersonal.DoFrameHide;
begin
     CloseData;

     inherited;
end;

procedure Tframe12CassaPersonal.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     OpenData;
end;

function Tframe12CassaPersonal.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[];
end;

function Tframe12CassaPersonal.GetFilterFields: TFrameFilterFields;
begin
     Result:=[];
end;

function Tframe12CassaPersonal.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
end;

function Tframe12CassaPersonal.InitFrameID: integer;
begin
     Result:=12; // CASA. Casa personala
end;

procedure Tframe12CassaPersonal.OpenData;
begin
      //IBCQueryPersonalCash.ParamByName('DT').AsInteger:=dmDB.CurrentFirma;
     IBCQueryPersonalCash.ParamByName('USERID').AsInteger:=dmDB.CurrentUserID;
     IBCQueryPersonalCash.Active:=True;

     IBCQueryNonConfirmedTransfers.ParamByName('USERID').AsInteger:=dmDB.CurrentUserID;
     IBCQueryNonConfirmedTransfers.Active:=True;

     IBCQueryOI.ParamByName('USERID').AsInteger:=dmDB.CurrentUserID;
     IBCQueryOI.ParamByName('DATA1').AsDate:=Date;
//     IBCQueryOI.ParamByName('DATA2').AsDate:=Date;
     IBCQueryOI.Active:=True;
end;

procedure Tframe12CassaPersonal.pmNonConfirmedTransfersPopup(Sender: TObject);
begin
     WhenNonAcceptedMoneyTransferMenuPopup;
end;

procedure Tframe12CassaPersonal.RefreshData;
begin
     IBCQueryPersonalCash.Refresh;
     IBCQueryNonConfirmedTransfers.Refresh;
     IBCQueryOI.Refresh;
end;

procedure Tframe12CassaPersonal.RefreshInfo;
begin
     RefreshData;
end;

procedure Tframe12CassaPersonal.ShowMoneyAcceptDialog;
var dialog:TfrmMoneyAcceptDlg;
begin
     dialog:=TfrmMoneyAcceptDlg.Create(Self,IBCQueryNonConfirmedTransfers,IBCDataSourceNonConfirmedTransfers);
     try
        if dialog.ShowModal=mrOk then IBCQueryNonConfirmedTransfers.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure Tframe12CassaPersonal.ShowMoneyTransferToSelfDialog;
var dialog:TfrmMoneyTransferDlg;
begin
     dialog:=TfrmMoneyTransferDlg.Create(Self);
     try
        if dialog.ShowModal=mrOk then IBCQueryPersonalCash.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure Tframe12CassaPersonal.ShowMoneyTransferToUserDialog(const CurrencyID:integer);
var dialog:TfrmMoneyTransferToUserDlg;
begin
     dialog:=TfrmMoneyTransferToUserDlg.Create(Self);
     try
        dialog.TargetCurrencyID:=CurrencyID;
        dialog.TargetUserID := IBCQueryPersonalCash.FieldByName('USERID').AsInteger;
        if dialog.ShowModal=mrOk then IBCQueryPersonalCash.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure Tframe12CassaPersonal.WhenNonAcceptedMoneyTransferMenuPopup;
var Accept:Boolean;
begin
     Accept:=False;
     if cxGridToMeTable.DataController.RecNo>0 then
     begin
          Accept:=True;
     end;
     bbAcceptMoneyTransfer.Enabled:=Accept;
end;

end.
