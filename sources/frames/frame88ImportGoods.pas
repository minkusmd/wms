unit frame88ImportGoods;

// Livrare
// DocTypeID = 3232
// Frame Index = 1

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs, SWNDataFiltering,
  SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit,
  cxLabel, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, StdCtrls, ExtCtrls, cxLookAndFeels, cxLookAndFeelPainters, dxBar, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxNavigator, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu,
  DBAccess, IBC, MemDS, dxScrollbarAnnotations, Vcl.Menus, cxButtons, cxCalc, cxImageComboBox;

type
  Tframe88ImportGoods = class(TSWNBaseFrame)
  private
    { Private declarations }

  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: string): Variant; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, DateUtils, SWNValueStorageUnit,
  frmCustomerCurrentDebtsDialog, SWNSecurity, frmPKODocDialog, SWNSecurityFlags, frmCustomerNotifyDebtsDialog, frm81DocDialog,
  frm82DocumentEditUnit, frmCustomersDlg, cxDataUtils;

{$R *.dfm}

{ TSWNBaseFrame1 }

procedure Tframe88ImportGoods.CreateNewRecord;
begin

end;

//    ProcessCommonKeys(cxGridDBTableView1, Key, Shift);

procedure Tframe88ImportGoods.DeleteRecord;
begin

end;

procedure Tframe88ImportGoods.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

  inherited;
end;

procedure Tframe88ImportGoods.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customDataFilter: TFrameDataFilteringInfo;
begin
  inherited;
end;

function Tframe88ImportGoods.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;
end;

function Tframe88ImportGoods.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs];
end;

function Tframe88ImportGoods.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffGoods, ffGoodsFolders];
end;

function Tframe88ImportGoods.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];

end;

procedure Tframe88ImportGoods.GetParamsListForReport(const ParamsList: TStringList);
begin

end;

function Tframe88ImportGoods.GetParamValueForReport(const ParamName: string): Variant;
begin

end;

function Tframe88ImportGoods.InitFrameID: integer;
begin
     // Import goods
  Result := 88;

end;

procedure Tframe88ImportGoods.ModifyRecord;
begin

end;

procedure Tframe88ImportGoods.ReadFrameStates;
begin

end;

procedure Tframe88ImportGoods.RefreshData;
begin

end;

procedure Tframe88ImportGoods.SaveFrameStates;
begin

end;

procedure Tframe88ImportGoods.SetupDefaultFocus;
begin

end;

procedure Tframe88ImportGoods.SetupSecurityItems;
begin

end;

end.

