unit frame130PhoneCallsUnit;
{
  СЕРВИС. Новые инциденты
  DocTypeID = 1280
  Frame Index = 36
}

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    ImgList, SWNDataFiltering, SWNBaseFrameUnit, SWNDocumentFilters, cxGraphics,
    cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
    cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView,
    cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
    cxGrid, dxBar, ExtCtrls, DBAccess, IBC, MemDS, cxLabel,
    cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator, Vcl.Menus, Vcl.StdCtrls,
    cxButtons, cxDataControllerConditionalFormattingRulesManagerDialog,
    dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations;

type
    Tframe130PhoneCalls = class(TSWNBaseFrame)
        dxBarManager: TdxBarManager;
        procedure cxGridOportunitatiTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure cxGridOportunitatiTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    private
        procedure WhenCustomDataFilterGetSQL(var FilterSQL: string);
        procedure WhenCustomDataFilterSetParams(const Query: TIBCQuery);

    protected
    { Protected declarations }
        function InitFrameID: Integer; override;

        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        procedure WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;

        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;

        procedure ModifyRecord; override;

        procedure ReadFrameStates; override;
        procedure SaveFrameStates; override;

    public
    { Public declarations }
        procedure SetupDefaultFocus; override;
    end;

implementation

uses
    DataModuleAdditions, frmCustomersDlg, DataModuleDB, SWNConst, SWNUtils,
    SWNDBErrors, SWNTypes, VCL.Dialogs, frmServiceNewIncidentEditorDialog,
    SWNValueStorageUnit;

{$R *.dfm}
procedure Tframe130PhoneCalls.cxGridOportunitatiTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    if (AButton = mbLeft) then
    begin
        DoDocumentDoubleClick;
        AHandled := True;
    end;
end;

procedure Tframe130PhoneCalls.cxGridOportunitatiTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    ProcessCommonKeys(cxGridOportunitatiTable, Key, Shift);
end;

procedure Tframe130PhoneCalls.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
    CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
//    cxGridOportunitatiTable.DataController.DataSource := nil;

     // 2. De deconectat sursele de date de la griduri
//    cxGridOportunitatiTable.OnFocusedRecordChanged := nil;

    inherited;
end;

procedure Tframe130PhoneCalls.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
    customizedFilterData: TFrameDataFilteringInfo;
begin
    inherited;

     // 1. Legam grid-urile de datasource-sele
//     cxGridOportunitatiTable.DataController.DataSource:=dmDB.IBCDataSourceIncidente;

     // 2. Selection handlers
//     cxGridOportunitatiTable.OnFocusedRecordChanged:=cxGridOportunitatiTableFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     // aici mai avem nevoie de un filtru special. indicam procedurile pentru call-back
//     customizedFilterData:=TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
//     try
//        customizedFilterData.OnCustomDataFilterGetSQL:=WhenCustomDataFilterGetSQL;
//        customizedFilterData.OnCustomDataFilterSetParams:=WhenCustomDataFilterSetParams;
//        OpenExternalData(customizedFilterData);
//     finally
//        customizedFilterData.Free;
//     end;
end;

function Tframe130PhoneCalls.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [fedsOportunitati];
end;

function Tframe130PhoneCalls.GetFilterFields: TFrameFilterFields;
begin
    Result := [];
end;

function Tframe130PhoneCalls.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH, fbtMODIFY];
end;

function Tframe130PhoneCalls.InitFrameID: Integer;
begin
    Result := 130;  // Sunete
end;

procedure Tframe130PhoneCalls.ModifyRecord;
begin
end;

procedure Tframe130PhoneCalls.ReadFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
        ReadGridColumnsSettings(cxGridOportunitatiTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe130PhoneCalls.SaveFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
        SaveGridColumnsSettings(cxGridOportunitatiTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe130PhoneCalls.SetupDefaultFocus;
begin
     // focused grid
//     cxGridOportunitati.SetFocus;
     // set default focused column
end;

procedure Tframe130PhoneCalls.WhenCustomDataFilterGetSQL(var FilterSQL: string);
begin
//    FilterSQL := FilterSQL + ' AND (STATUS_ID=:STATUS)';
end;

procedure Tframe130PhoneCalls.WhenCustomDataFilterSetParams(const Query: TIBCQuery);
begin

end;

procedure Tframe130PhoneCalls.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
    customizedFilterData: TFrameDataFilteringInfo;
begin
    customizedFilterData := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
    try
        customizedFilterData.OnCustomDataFilterGetSQL := WhenCustomDataFilterGetSQL;
        customizedFilterData.OnCustomDataFilterSetParams := WhenCustomDataFilterSetParams;
        inherited WhenFilterDataChanged(customizedFilterData);
    finally
        customizedFilterData.Free;
    end;
end;

end.

