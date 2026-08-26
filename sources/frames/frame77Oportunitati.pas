unit frame77OportunitatiUnit;
{
  СЕРВИС. Новые инциденты
  DocTypeID = 1280
  Frame Index = 36
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ImgList,
  SWNDataFiltering, SWNBaseFrameUnit, SWNDocumentFilters,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, dxBar, ExtCtrls, DBAccess, IBC, MemDS,
  cxLabel, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxNavigator, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges;

type
  Tframe77Oportunitati = class(TSWNBaseFrame)
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    cxGridOportunitatiTable: TcxGridDBTableView;
    cxGridOportunitatiLevel: TcxGridLevel;
    cxGridOportunitati: TcxGrid;
    procedure cxGridOportunitatiTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure cxGridOportunitatiTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure WhenCustomDataFilterGetSQL(var FilterSQL:String);
    procedure WhenCustomDataFilterSetParams(const Query:TIBCQuery);


  protected
    { Protected declarations }
    function InitFrameID: Integer; override;

    function GetExternalDataSourceTypes:TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure WhenFilterDataChanged(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;

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

uses DataModuleAdditions, frmCustomersDlg, DataModuleDB, SWNConst, SWNUtils,
     SWNDBErrors, SWNTypes, VCL.Dialogs, frmServiceNewIncidentEditorDialog, SWNValueStorageUnit;

{$R *.dfm}
procedure Tframe77Oportunitati.cxGridOportunitatiTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if (AButton = mbLeft) then
     begin
          DoDocumentDoubleClick;
          AHandled := True;
     end;
end;

procedure Tframe77Oportunitati.cxGridOportunitatiTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ProcessCommonKeys(cxGridOportunitatiTable, Key, Shift);
end;

procedure Tframe77Oportunitati.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridOportunitatiTable.DataController.DataSource:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridOportunitatiTable.OnFocusedRecordChanged:=nil;

     inherited;
end;

procedure Tframe77Oportunitati.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
var customizedFilterData:TFrameDataFilteringInfo;
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridOportunitatiTable.DataController.DataSource:=dmDB.IBCDataSourceIncidente;

     // 2. Selection handlers
//     cxGridOportunitatiTable.OnFocusedRecordChanged:=cxGridOportunitatiTableFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     // aici mai avem nevoie de un filtru special. indicam procedurile pentru call-back
     customizedFilterData:=TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
     try
        customizedFilterData.OnCustomDataFilterGetSQL:=WhenCustomDataFilterGetSQL;
        customizedFilterData.OnCustomDataFilterSetParams:=WhenCustomDataFilterSetParams;
        OpenExternalData(customizedFilterData);
     finally
        customizedFilterData.Free;
     end;
end;

function Tframe77Oportunitati.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsOportunitati];
end;

function Tframe77Oportunitati.GetFilterFields: TFrameFilterFields;
begin
     Result := [];
end;

function Tframe77Oportunitati.GetFrameButtons: TFrameButtons;
begin
     Result := [fbtREFRESH, fbtMODIFY];
end;

function Tframe77Oportunitati.InitFrameID: Integer;
begin
     Result := 77;  // Oportunitati
end;

procedure Tframe77Oportunitati.ModifyRecord;
begin
end;

procedure Tframe77Oportunitati.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        ReadGridColumnsSettings(cxGridOportunitatiTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe77Oportunitati.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        SaveGridColumnsSettings(cxGridOportunitatiTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe77Oportunitati.SetupDefaultFocus;
begin
     // focused grid
     cxGridOportunitati.SetFocus;
     // set default focused column
end;

procedure Tframe77Oportunitati.WhenCustomDataFilterGetSQL(var FilterSQL: String);
begin
     FilterSQL:=FilterSQL+' AND (STATUS_ID=:STATUS)';
end;

procedure Tframe77Oportunitati.WhenCustomDataFilterSetParams(const Query: TIBCQuery);
begin
     Query.ParamByName('STATUS').AsInteger:=6101; // Incidente noi
end;

procedure Tframe77Oportunitati.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var customizedFilterData:TFrameDataFilteringInfo;
begin
     customizedFilterData:=TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
     try
        customizedFilterData.OnCustomDataFilterGetSQL:=WhenCustomDataFilterGetSQL;
        customizedFilterData.OnCustomDataFilterSetParams:=WhenCustomDataFilterSetParams;
        inherited WhenFilterDataChanged(customizedFilterData);
     finally
        customizedFilterData.Free;
     end;
end;

end.
