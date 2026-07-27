unit frame43CashTransferUnit;
{
  КАССА. Передача денег
  DocTypeID = 1427
  Frame Index = 43
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  dxBar, cxStyles, cxGraphics,
  DB, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridDBTableView, cxGrid, dxBarExtItems,
  ExtCtrls, IBC, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxCheckBox, cxImageComboBox, cxCurrencyEdit,
  cxLabel, MemDS, DBAccess, cxClasses, cxGridTableView, dxUIAClasses;

type
  Tframe43CashTransfer = class(TSWNBaseFrame)
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    dxBarManagerBar2: TdxBar;
    pnMyTransfer: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar3: TdxBar;
    dxBarStatic1: TdxBarStatic;
    bbTransferMoneyToUser: TdxBarButton;
    cxGridMyTransfersTable: TcxGridDBTableView;
    cxGridMyTransfersLevel: TcxGridLevel;
    cxGridMyTransfers: TcxGrid;
    IBCDataSourceMyTransfers: TIBCDataSource;
    IBCQueryMyTransfers: TIBCQuery;
    cxGridMyTransfers_DATA_DT: TcxGridDBColumn;
    Suma: TcxGridDBColumn;
    Cntb: TcxGridDBColumn;
    cxGridMyTransfers_USER_CT_NAME: TcxGridDBColumn;
    cxGridMyTransfers_CT_NAME: TcxGridDBColumn;
    cxGridMyTransfers_CURRENCY_DT_NAME: TcxGridDBColumn;
    cxGridMyTransfers_DT_NAME: TcxGridDBColumn;
    cxGridMyTransfers_USER_DT_NAME: TcxGridDBColumn;
    cxGridMyTransfers_FLG_ACNT_CT: TcxGridDBColumn;
    bbMoneyTransfer: TdxBarButton;
    cxGridMyTransfers_FLG_CLOSE_DOC: TcxGridDBColumn;
    cxGridMyTransfersTableColumn1: TcxGridDBColumn;
    cxGridMyTransfers_SUMA_CT: TcxGridDBColumn;
    cxGridMyTransfers_RATE_DT: TcxGridDBColumn;
    cxGridMyTransfers_RATE_CT: TcxGridDBColumn;
    bbCurrencyEchange: TdxBarButton;
    bbExchangeLog: TdxBarButton;
    cxGridMyTransfersTableColumn2: TcxGridDBColumn;
    cxGridMyTransfersTableColumn3: TcxGridDBColumn;
    procedure bbMoneyTransferClick(Sender: TObject);
    procedure bbTransferMoneyToUserClick(Sender: TObject);
    procedure cxGridMyTransfersTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure bbCurrencyEchangeClick(Sender: TObject);
    procedure bbExchangeLogClick(Sender: TObject);
    procedure cxGridMyTransfersTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridMyTransfersTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    procedure ShowMoneyTransferToUserDialog;
    procedure ShowMoneyTransferDialog;
    procedure ShowCurrencyExchangeDialog;
    procedure ShowExchangeLogDialog;

    procedure OpenData(const FrameDataFilterInfo:TFrameDataFilteringInfo);
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
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;


implementation

uses DataModuleDB, DataModuleAdditions, frmMoneyTransferToUserDialog, frmMoneyTransferDialog,
  frmCurrencyExchangeDialog, frmExchangeLogDialog, SWNUtils;

{$R *.dfm}

{ Tframe43CashTransfer }

procedure Tframe43CashTransfer.bbCurrencyEchangeClick(Sender: TObject);
begin
     ShowCurrencyExchangeDialog;
end;

procedure Tframe43CashTransfer.bbExchangeLogClick(Sender: TObject);
begin
     ShowExchangeLogDialog;
end;

procedure Tframe43CashTransfer.bbMoneyTransferClick(Sender: TObject);
begin
     ShowMoneyTransferDialog;
end;

procedure Tframe43CashTransfer.bbTransferMoneyToUserClick(Sender: TObject);
begin
     ShowMoneyTransferToUserDialog;
end;

procedure Tframe43CashTransfer.cxGridMyTransfersTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridMyTransfers_FLG_CLOSE_DOC.index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridMyTransfers_FLG_CLOSE_DOC.index]=0 then
          begin
               if Not AViewInfo.Selected then
               begin
                    // Document prin contabilitate
                    if AViewInfo.GridRecord.Values[cxGridMyTransfers_FLG_ACNT_CT.Index]=1 then ACanvas.Font.Color:=dmAdditions.cxStyle_TextColorRed.TextColor;
               end;
          end
          else
          begin
               ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
               if Not AViewInfo.Selected then
               begin
                    if AViewInfo.GridRecord.Values[cxGridMyTransfers_FLG_ACNT_CT.Index]=1 then ACanvas.Font.Color:=$008b8bc5
                    else ACanvas.Font.Color:=clGrayText;
               end;
          end;
     end;

     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure Tframe43CashTransfer.cxGridMyTransfersTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnUtils.ProcessCommonKeys(Self, cxGridMyTransfersTable,Key,Shift);
end;

procedure Tframe43CashTransfer.cxGridMyTransfersTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if ARecord.Values[cxGridMyTransfers_FLG_CLOSE_DOC.Index]=0 then AStyle:=dmAdditions.cxStyle_Bold;
end;

procedure Tframe43CashTransfer.DoFrameHide;
begin
     IBCQueryMyTransfers.Active:=False;

     inherited;
end;

procedure Tframe43CashTransfer.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;
     OpenData(FrameDataFilterInfo);
end;

function Tframe43CashTransfer.GetCurrentSearchContext: TSearchContextValue;
begin
     if cxGridMyTransfersTable.Site.Focused then
     begin
          if cxGridMyTransfers_DATA_DT.Focused then
          begin
               // Дата
               Result.Context := ffDate;
               Result.ValueDateTime := IBCQueryMyTransfers.FieldByName('DATA_DT').AsDateTime;
          end
          else
              if cxGridMyTransfers_CT_NAME.Focused then
              begin
                   // В фирму
                   Result.Context := ffCustomer;
                   Result.ValueInt := IBCQueryMyTransfers.FieldByName('CT').AsInteger;
                   Result.ValueStr := IBCQueryMyTransfers.FieldByName('CT_NAME').AsString;
              end;
     end
end;

function Tframe43CashTransfer.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate,ffCustomer];
end;

function Tframe43CashTransfer.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
end;

function Tframe43CashTransfer.InitFrameID: integer;
begin
     Result:=43;  // КАССА - Передача денег
end;

procedure Tframe43CashTransfer.OpenData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var whereStr:String;
    filters:TFrameDataFilterSet;
begin
     filters:=FrameDataFilterInfo.FrameFilters;

     IBCQueryMyTransfers.Close;

     // create new filter
     whereStr:='(A.USER_DT=:USERID)';
     if (dfiDATE in filters) then whereStr:=whereStr+' AND (CAST(A.DATA_DT AS DATE)>=:DATA1 AND CAST(A.DATA_DT AS DATE)<=:DATA2)';
     if (dfiCustomerID in filters) then whereStr:=whereStr+' AND (A.CT=:CT)';
     // apply it
     IBCQueryMyTransfers.FilterSQL:=whereStr;
     // setup params
     IBCQueryMyTransfers.ParamByName('USERID').AsInteger:=dmDB.CurrentUserID;
     if (dfiDATE in filters) then
     begin
          IBCQueryMyTransfers.ParamByName('DATA1').AsDate:=FrameDataFilterInfo.DateStart;
          IBCQueryMyTransfers.ParamByName('DATA2').AsDate:=FrameDataFilterInfo.DateEnd;
     end;
     if (dfiCustomerID in filters) then IBCQueryMyTransfers.ParamByName('CT').AsInteger:=FrameDataFilterInfo.CustomerID;
     // open data
     IBCQueryMyTransfers.Active:=True;
end;

procedure Tframe43CashTransfer.RefreshData;
begin
     IBCQueryMyTransfers.Refresh;
end;

procedure Tframe43CashTransfer.ShowCurrencyExchangeDialog;
var dialog:TfrmCurrencyExchangeDlg;
begin
     dialog:=TfrmCurrencyExchangeDlg.Create(Self);
     try
        if dialog.ShowModal=mrOk then IBCQueryMyTransfers.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure Tframe43CashTransfer.ShowExchangeLogDialog;
var dialog:TfrmExchangeLogDlg;
begin
     dialog:=TfrmExchangeLogDlg.Create(Self);
     try
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe43CashTransfer.ShowMoneyTransferDialog;
var dialog:TfrmMoneyTransferDlg;
begin
     dialog:=TfrmMoneyTransferDlg.Create(Self);
     try
        if dialog.ShowModal=mrOk then IBCQueryMyTransfers.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure Tframe43CashTransfer.ShowMoneyTransferToUserDialog;
var dialog:TfrmMoneyTransferToUserDlg;
begin
     dialog:=TfrmMoneyTransferToUserDlg.Create(Self);
     try
        if dialog.ShowModal=mrOk then
        begin
             IBCQueryMyTransfers.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe43CashTransfer.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
     OpenData(FrameDataFilterInfo);
end;

end.
