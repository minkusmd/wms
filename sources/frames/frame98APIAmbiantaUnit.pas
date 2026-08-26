unit frame98APIAmbiantaUnit;

// Distribuirea rambursului
// FrameID = 96

interface

uses
    DBAccess, IBC, MemDS, SWNBaseFrameUnit, SWNDataFiltering, SWNDocumentFilters, cxCheckBox, cxClasses, cxControls, cxCustomData, cxDBData,
    cxData, cxDataControllerConditionalFormattingRulesManagerDialog, cxDataStorage, cxDropDownEdit, cxEdit, cxFilter, cxGraphics, cxGrid,
    cxGridCustomTableView, cxGridCustomView, cxGridDBTableView, cxGridLevel, cxGridTableView, cxLabel, cxLookAndFeelPainters, cxLookAndFeels,
    cxNavigator, cxSplitter, cxStyles, dxBar, dxDateRanges, dxScrollbarAnnotations, Data.DB, System.Classes, System.SysUtils,
    System.Variants, Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics, Vcl.StdCtrls, Winapi.Messages, Winapi.Windows,
    cxCurrencyEdit, cxContainer, Vcl.Menus, cxButtons, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
    Datasnap.DBClient, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, dxActivityIndicator, System.SyncObjs, dxUIAClasses;

type
    Tframe98ApiAmbianta = class(TSWNBaseFrame)
      cxGrid1DBTableView1: TcxGridDBTableView;
      cxGrid1Level1: TcxGridLevel;
      cxGrid1: TcxGrid;
      Panel1: TPanel;
      cxLabel1: TcxLabel;
      IBCQueryAmbGoods: TIBCQuery;
      IBCDataSourceAmbGoods: TIBCDataSource;
      cxGrid1DBTableView1PPARENTID: TcxGridDBColumn;
      cxGrid1DBTableView1TITLE: TcxGridDBColumn;
      cxGrid1DBTableView1PARENTID: TcxGridDBColumn;
      cxGrid1DBTableView1PARENT_TITLE: TcxGridDBColumn;
      cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn;
      cxGrid1DBTableView1GOODS_TITLE: TcxGridDBColumn;
      cxGrid1DBTableView1COMPLECTID: TcxGridDBColumn;
      cxGrid1DBTableView1COMPLECT_NAME: TcxGridDBColumn;
      cxGrid1DBTableView1GOODS_TYPE_ID: TcxGridDBColumn;
      cxGrid1DBTableView1PRICE_IN: TcxGridDBColumn;
      cxGrid1DBTableView1PRICE_OUT: TcxGridDBColumn;
      cxGrid1DBTableView1OWNGOODSID: TcxGridDBColumn;
      cxGrid1DBTableView1PRICE_MDL: TcxGridDBColumn;
      cxStyleRepository1: TcxStyleRepository;
      cxStylePriceUp: TcxStyle;
      cxStylePriceDown: TcxStyle;
      cxGrid1DBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
      IBCAmbTransaction: TIBCTransaction;
    IBCAmbiantaConnection: TIBCConnection;
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGrid1DBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    private    { Private declarations }
//        MEvent: TEvent;
    protected    { Protected declarations }
        fSECURITY_CanEdit: Boolean;
        fSECURITY_CanView: Boolean;
        function InitFrameID: integer; override;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;

        procedure ReadFrameStates; override;
        procedure SaveFrameStates; override;

        procedure CreateNewRecord; override;
        procedure ModifyRecord; override;
        procedure DeleteRecord; override;
        procedure RefreshData; override;
        procedure CloneRecord; override;
    procedure PrepareView;
        procedure SetupSecurityItems; override;

    public    { Public declarations }
        procedure SetupDefaultFocus; override;

    end;

implementation

{$R *.dfm}

uses
    DataModuleDB, SWNSecurity, SWNSecurityFlags, SWNUtils, SWNDBErrors, SWNValueStorageUnit, DataModuleAdditions, SWNConst;

procedure Tframe98ApiAmbianta.CloneRecord;
begin
    inherited;
end;

procedure Tframe98ApiAmbianta.CreateNewRecord;
begin
    inherited;
end;

procedure Tframe98ApiAmbianta.cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    SWNUtils.ProcessCommonKeys(Self, cxGrid1DBTableView1, Key, Shift);
end;

procedure Tframe98ApiAmbianta.cxGrid1DBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGrid1DBTableView1PRICE_OUT.Index] > ARecord.Values[cxGrid1DBTableView1PRICE_MDL.Index] then
    Astyle:= cxStylePriceUp;
  if ARecord.Values[cxGrid1DBTableView1PRICE_OUT.Index] < ARecord.Values[cxGrid1DBTableView1PRICE_MDL.Index] then
    Astyle:= cxStylePriceDown;
end;

procedure Tframe98ApiAmbianta.DeleteRecord;
begin
end;

procedure Tframe98ApiAmbianta.DoFrameHide;
begin
  IBCQueryAmbGoods.Close;
  IBCAmbiantaConnection.Connected := false;
end;

function Tframe98ApiAmbianta.GetFilterFields: TFrameFilterFields;
begin
    Result := [ffDate];
end;

function Tframe98ApiAmbianta.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH, fbtMODIFY, fbtDELETE];
end;

function Tframe98ApiAmbianta.InitFrameID: integer;
begin
    Result := 98;
end;

procedure Tframe98ApiAmbianta.ModifyRecord;
begin
end;

procedure Tframe98ApiAmbianta.ReadFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
//        ReadGridColumnsSettings(cxGridBankPDNSTable);
//        ReadGridColumnsSettings(cxGridRambursDBTableView);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe98ApiAmbianta.RefreshData;
begin
end;

procedure Tframe98ApiAmbianta.SaveFrameStates;
begin
    if SWNSecurityManager.IsPartialAccessMode then
        Exit;

    AppUserConfigStorage.OpenSection(Self.Name);
    try
//        SaveGridColumnsSettings(cxGridBankPDNSTable);
//        SaveGridColumnsSettings(cxGridRambursDBTableView);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe98ApiAmbianta.SetupDefaultFocus;
begin
//  cxGridBankPDNS.SetFocus;
//  cxGridPromoTicketsTableTICKET_CODE.Focused := True;
end;

procedure Tframe98ApiAmbianta.SetupSecurityItems;
begin
//    fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Modifica_inregistrarea);
//    fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Vizializare);
//    fSECURITY_New := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Inregistrarea_noua);
//    fSECURITY_Edit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Modifica_inregistrarea);
//    fSECURITY_Delete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Sterge_inregistrarea);
end;

procedure Tframe98ApiAmbianta.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
//    cxGridBankPDNSTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
//
//    OpenExternalData(FrameDataFilterInfo);
//
//    IBCQueryDistributieRamburs.Close;
//    IBCQueryDistributieRamburs.MasterFields := 'DOCID';
//    IBCQueryDistributieRamburs.DetailFields := 'DOCID';
//    IBCQueryDistributieRamburs.MasterSource := dmDB.IBCDataSourceDocs;
//
//    IBCQueryDistributieRamburs.DeleteWhere;
//    if (FrameDataFilterInfo.CustomerID > -1) then
//        ibcquerydistributieRamburs.Addwhere('customerid = ' + dmdb.IBCQueryDocs.FieldByName('CT').AsString);
//    IBCQueryDistributieRamburs.Open;
//
//     // 1. Legam grid-urile de datasource-sele
//    cxGridBankPDNSTable.DataController.DataSource := dmdb.IBCDataSourceDocs;
//    cxGridRambursDBTableView.DataController.DataSource := IBCDataSourceDistributieRamburs;
    ibcAmbiantaConnection.Connect;
    IBCQueryAmbGoods.Open;

//    TThread.CreateAnonymousThread(
//        procedure
//        begin
////           while not TThread.CurrentThread.CheckTerminated and (not application.terminated) do
////           begin
//            PrepareView;
//             TThread.Synchronize(nil,procedure
//             begin
//               Sleep(10);
//             end);
////            end;
//        end).Start;

end;

function Tframe98ApiAmbianta.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [fedsNONE];
end;

procedure Tframe98ApiAmbianta.PrepareView;
begin
    Application.ProcessMessages;
    try
    cxGrid1DBTableView1.BeginUpdate;
    IBCQueryAmbGoods.Open;
    finally
        cxGrid1DBTableView1.EndUpdate;
    end;
end;

end.

