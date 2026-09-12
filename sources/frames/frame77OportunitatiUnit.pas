unit frame77OportunitatiUnit;
{
  SERVICE. Incidente noi
  DocTypeID = 1280
  Frame Index = 36
}

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ImgList, SWNDataFiltering,
   SWNBaseFrameUnit, SWNDocumentFilters, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
   cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView,
   cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, dxBar, ExtCtrls,
   DBAccess, IBC, MemDS, cxLabel, cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator, Vcl.Menus, Vcl.StdCtrls,
   cxButtons, cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges,
   cxCalendar, cxTextEdit, cxCalc, cxProgressBar, dxRatingControl, dxScrollbarAnnotations, dxUIAClasses;

type
   Tframe77Oportunitati = class(TSWNBaseFrame)
      pnClient: TPanel;
      dxBarManager: TdxBarManager;
      cxGridOportunitatiTable: TcxGridDBTableView;
      cxGridOportunitatiLevel: TcxGridLevel;
      cxGridOportunitati: TcxGrid;
      cxGridOportunitatiTableID: TcxGridDBColumn;
      cxGridOportunitatiTableDATA: TcxGridDBColumn;
      cxGridOportunitatiTableSUBIECT: TcxGridDBColumn;
      cxGridOportunitatiTableCLIENT_POTENTIAL: TcxGridDBColumn;
      cxGridOportunitatiTableDATA_ESTIMATA: TcxGridDBColumn;
      cxGridOportunitatiTableVENIT_ESTIMAT: TcxGridDBColumn;
      cxGridOportunitatiTablePROBABILITATE: TcxGridDBColumn;
      cxGridOportunitatiTableEVALUARE: TcxGridDBColumn;
      cxGridOportunitatiTableCREATED_BY_NAME: TcxGridDBColumn;
    cxGridOportunitatiTableRESPONSABIL: TcxGridDBColumn;
    cxGridOportunitatiTableStatus_ID: TcxGridDBColumn;
      procedure cxGridOportunitatiTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
         TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
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
      procedure CreateNewRecord; override;
      procedure ModifyRecord; override;
      procedure ReadFrameStates; override;
      procedure SaveFrameStates; override;
   public
    { Public declarations }
      procedure SetupDefaultFocus; override;
   end;

implementation

uses
   DataModuleAdditions, frmCustomersDlg, DataModuleDB, SWNConst, SWNUtils, SWNDBErrors, SWNTypes, Vcl.Dialogs,
   SWNValueStorageUnit, frmOportunitatiDialog;

{$R *.dfm}
procedure Tframe77Oportunitati.CreateNewRecord;
var
   dialog: TfrmOportunitatiDlg;
begin
   dialog := TfrmOportunitatiDlg.Create(Self);
   try
      dialog.CreateNewDocument := True;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure Tframe77Oportunitati.cxGridOportunitatiTableCellDblClick(Sender: TcxCustomGridTableView;
   ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
   if (AButton = mbLeft) then
   begin
      DoDocumentDoubleClick;
      AHandled := True;
   end;
end;

procedure Tframe77Oportunitati.cxGridOportunitatiTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   SWNUtils.ProcessCommonKeys(Self, cxGridOportunitatiTable, Key, Shift);
end;

procedure Tframe77Oportunitati.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
   CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
   cxGridOportunitatiTable.DataController.DataSource := nil;

     // 2. De deconectat sursele de date de la griduri
   cxGridOportunitatiTable.OnFocusedRecordChanged := nil;

   inherited;
end;

procedure Tframe77Oportunitati.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
   customizedFilterData: TFrameDataFilteringInfo;
begin
   inherited;

     // 1. Legam grid-urile de datasource-sele
   cxGridOportunitatiTable.DataController.DataSource := dmDB.IBCDataSourceOportunitati;

     // 2. Selection handlers
//     cxGridOportunitatiTable.OnFocusedRecordChanged:=cxGridOportunitatiTableFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     // aici mai avem nevoie de un filtru special. indicam procedurile pentru call-back
   customizedFilterData := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
   try
      customizedFilterData.OnCustomDataFilterGetSQL := WhenCustomDataFilterGetSQL;
      customizedFilterData.OnCustomDataFilterSetParams := WhenCustomDataFilterSetParams;
      OpenExternalData(customizedFilterData);
   finally
      customizedFilterData.Free;
   end;
   dmDB.IBCQueryOportunitati.Active := True;
end;

function Tframe77Oportunitati.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
   Result := [fedsOportunitati];
end;

function Tframe77Oportunitati.GetFilterFields: TFrameFilterFields;
begin
   Result := [ffDate];
end;

function Tframe77Oportunitati.GetFrameButtons: TFrameButtons;
begin
   Result := [fbtREFRESH, fbtADD, fbtMODIFY];
end;

function Tframe77Oportunitati.InitFrameID: Integer;
begin
   Result := 77;  // Oportunitati
end;

procedure Tframe77Oportunitati.ModifyRecord;
var
   dialog: TfrmOportunitatiDlg;
begin
   dialog := TfrmOportunitatiDlg.Create(Self);
   try
      dialog.CreateNewDocument := False;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
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

procedure Tframe77Oportunitati.WhenCustomDataFilterGetSQL(var FilterSQL: string);
begin
//   FilterSQL := FilterSQL + ' AND DT = :DT';
end;

procedure Tframe77Oportunitati.WhenCustomDataFilterSetParams(const Query: TIBCQuery);
begin
//   Query.ParamByName('DT').AsInteger := dmDB.FirmaInfo.FirmaID; // Subdiviziunea
end;

procedure Tframe77Oportunitati.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
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

