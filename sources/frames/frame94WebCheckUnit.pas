unit frame94WebCheckUnit;

{
  Товары в прайс листах которые не показываются на сайте
  DocTypeID = ?
  Frame Index = 94
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNDataFiltering,
  SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, DB, cxDBData, dxBar, DBAccess, IBC,
  cxSplitter, cxPC, ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxGridPopupMenu, cxCalc, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, MemDS, cxClasses, dxBarBuiltInMenu, dxUIAClasses;

type
  TStringArray = array of string;

  Tframe94WebCheck = class(TSWNBaseFrame)
    IBCQueryGoodsNotInWeb: TIBCQuery;
    IBCDataSourceGoodsNotInWeb: TIBCDataSource;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1PATH: TcxGridDBColumn;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_NAME: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbOpen: TdxBarButton;
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbOpenClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
    function GetFrameButtons: TFrameButtons; override;
  public
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  frmConfigurationDocDialog, DataModuleAdditions, System.UITypes, SWNUtils, SWNConst,
  frmConfigurationCustomSumaDialog, frmConfigurationCustomCountDialog, SWNTypes,
  frmSelectGoodsToAddDialog, frmRascetKonfiguratiiDialog, SWNValueStorageUnit, frmKitTemplatesDialog,
  SWNDBErrors, frmDocumentDiscountDialog, frmCreateCustomNareadSborkaDialog, SWNSecurity,
  SWNSecurityFlags, SWNCommonDialogs, frmSelectPhoneNumberUnit, Vcl.Clipbrd, vcl.dialogs,
  uCreditFinalInfoDialog, frmKitchenTemplateUnit, frmDocumentImportBrowserDialog, System.Types,
  frmAddItemsToTenderUnit, frmCustomImportXlsUnit;

{$R *.dfm}

procedure Tframe94WebCheck.bbOpenClick(Sender: TObject);
begin
  if ibcqueryGoodsNotInWeb.Active then
    ibcqueryGoodsNotInWeb.Refresh
  else
    ibcqueryGoodsNotInWeb.Open;
end;

procedure Tframe94WebCheck.cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  inherited;
  SWNUtils.ProcessCommonKeys(Self, cxGrid1DBTableView1, Key, Shift);
end;


{ Tframe08ConfigurationBRK }

procedure Tframe94WebCheck.SaveFrameStates;
begin
end;

procedure Tframe94WebCheck.DoFrameHide;
begin
  CloseExternalData;

  IBCQueryGoodsNotInWeb.Close;

  cxGrid1DBTableView1.DataController.DataSource := nil;
  cxGrid1DBTableView1.OnFocusedRecordChanged := nil;

  inherited;
end;

procedure Tframe94WebCheck.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  cxGrid1DBTableView1.DataController.DataSource := IBCDataSourceGoodsNotInWeb;
  OpenExternalData(FrameDataFilterInfo);
end;

function Tframe94WebCheck.GetCurrentSearchContext: TSearchContextValue;
begin
  result := inherited;
end;

function Tframe94WebCheck.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  result := [];
end;

function Tframe94WebCheck.GetFrameButtons: TFrameButtons;
begin
  result := [fbtREFRESH];
end;

function Tframe94WebCheck.InitFrameID: integer;
begin
  result := 94;
end;

procedure Tframe94WebCheck.ReadFrameStates;
begin
end;

procedure Tframe94WebCheck.RefreshData;
begin
  inherited;
  IBCQueryGoodsNotInWeb.Refresh;
end;

procedure Tframe94WebCheck.SetupDefaultFocus;
begin
end;

procedure Tframe94WebCheck.SetupSecurityItems;
begin
  if SWNSecurityManager.IsPartialAccessMode then
  begin

  end;
end;

end.

