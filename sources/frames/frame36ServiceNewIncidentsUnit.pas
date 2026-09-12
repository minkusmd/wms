unit frame36ServiceNewIncidentsUnit;
{
  SERVICE. Incidente noi
  DocTypeID = 1280
  Frame Index = 36
}

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ImgList, SWNDataFiltering,
   SWNBaseFrameUnit, cxGraphics, DB, cxDBData, cxGridCustomTableView,
   cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, dxBar, ExtCtrls,
   DBAccess, IBC, cxGridPopupMenu, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxLabel, dxBarBuiltInMenu,
  cxGridCustomPopupMenu, cxClasses, cxGridTableView, dxUIAClasses;

type
  Tframe36ServiceNewIncidents = class(TSWNBaseFrame)
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    cxGridIncidenteTable: TcxGridDBTableView;
    cxGridIncidenteLevel: TcxGridLevel;
    cxGridIncidente: TcxGrid;
    cxGridIncidente_INCIDENTID: TcxGridDBColumn;
    cxGridIncidente_DATA: TcxGridDBColumn;
    cxGridIncidente_TYPE_TITLE: TcxGridDBColumn;
    cxGridIncidente_GOODS_TITLE: TcxGridDBColumn;
    cxGridIncidente_GOODS_SN: TcxGridDBColumn;
    cxGridIncidente_PRIORITY_LEVEL: TcxGridDBColumn;
    cxGridIncidente_CREATED_FULL_NAME: TcxGridDBColumn;
    cxGridIncidente_DOC_CUSTOMER: TcxGridDBColumn;
    bbCreateIncidentTask: TdxBarButton;
    cxGridIncidente_GOODS_MODEL: TcxGridDBColumn;
    cxGridIncidente_CT: TcxGridDBColumn;
    cxGridPopupMenu1: TcxGridPopupMenu;
    pmGrid: TdxBarPopupMenu;
    bbGotoParentDoc: TdxBarButton;
    cxGridIncidentePlatitor: TcxGridDBColumn;
    cxGridIncidenteTable_GOODS_DOCID: TcxGridDBColumn;
    cxGridIncidente_DT_NAME: TcxGridDBColumn;
    cxGridIncidente_EXEC_PERSONAL_GROUP_TITLE: TcxGridDBColumn;
    cxGridIncidente_CREATED_DATE: TcxGridDBColumn;
    procedure cxGridIncidenteTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbCreateIncidentTaskClick(Sender: TObject);
    procedure cxGridIncidenteTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure cxGridIncidenteTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure cxGridIncidenteTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridIncidente_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridIncidente_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
    procedure IncidenteSelectionChanged;
    procedure ShowIncidentDescriptionDialog;

    procedure CreateÏåðåðàáîòêà(const IncidentID: Integer);
    function IncidentCanBeStarted(const IncidentID: Integer): Boolean;
    function DoStartIncidentDB(const IncidentID: Integer): Boolean;

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
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: String): Variant; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses DataModuleDB, SWNUtils,
     SWNDBErrors, frmServiceNewIncidentEditorDialog, SWNValueStorageUnit;

{$R *.dfm}
{ TSWNBaseFrame1 }

procedure Tframe36ServiceNewIncidents.bbCreateIncidentTaskClick(Sender: TObject);
begin
     CreateÏåðåðàáîòêà(dmDB.IBCQueryIncidente.FieldByName('INCIDENTID').AsInteger);
end;

procedure Tframe36ServiceNewIncidents.bbGotoParentDocClick(Sender: TObject);
begin
     FindDocument(dmDB.IBCQueryIncidente.FieldByName('GOODS_DOCID').AsInteger);
end;

procedure Tframe36ServiceNewIncidents.CreateÏåðåðàáîòêà(const IncidentID: Integer);
begin
     if IncidentCanBeStarted(IncidentID) and (ShowAskDialog('In prelucrare', 'Porniti incidentul in prelucrare?')= mrYes)
        and DoStartIncidentDB(IncidentID) then dmDB.IBCQueryIncidente.Refresh;
end;

procedure Tframe36ServiceNewIncidents.cxGridIncidenteTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if (AButton = mbLeft) then
     begin
          DoDocumentDoubleClick;
          AHandled := True;
     end;
end;

procedure Tframe36ServiceNewIncidents.cxGridIncidente_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridIncidente_CREATED_DATE.Index])
        then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridIncidente_CREATED_DATE.Index]);
end;

procedure Tframe36ServiceNewIncidents.cxGridIncidenteTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if AViewInfo.RecordViewInfo.Selected and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color := $E8E8E8;
     end;


{    Õ if Not VarIsNull(AViewInfo.GridRecord.Values[cxGridIncidente_TYPE_TITLE.index]) and
     (AViewInfo.GridRecord.Values[cxGridIncidente_TYPE_TITLE.index]='Reparatie in garantie') then
     if Not VarIsNull(AViewInfo.GridRecord.Values[cxGridIncidente_DATA.index]) then
     begin
      ndays := Date - AViewInfo.GridRecord.Values[cxGridIncidente_DATA.index];
          if (ndays>=1) and (ndays<=3) then
          begin
               ACanvas.Brush.Color := $00DDFFDD;
          end
          else
          if (ndays>3) and (ndays<=5) then
          begin
               ACanvas.Brush.Color := $00CCFFFF;
          end
          else
          if (ndays>5) and (ndays<=8) then
          begin
               ACanvas.Brush.Color := $00CCEAFF;
          end
          else
          if (ndays>8) and (ndays<=10) then
          begin
               ACanvas.Brush.Color := $00A9C9FE;
          end
          else
          if (ndays>10) and (ndays<=13) then
          begin
               ACanvas.Brush.Color := $008080FF;
          end
          else
          if (ndays>13)  then
          begin
               ACanvas.Brush.Color := clRed;
          end;

          if AViewInfo.Selected then
          begin
            ACanvas.Brush.Color := clActiveCaption;
            ACanvas.Font.Color := clCaptionText;
          end;
     end;
     }
     // highlight selected row
//     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
//     begin
//          ACanvas.Brush.Color:=$E8E8E8;
//     end;
end;

procedure Tframe36ServiceNewIncidents.cxGridIncidenteTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  IncidenteSelectionChanged;
end;

procedure Tframe36ServiceNewIncidents.cxGridIncidenteTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridIncidenteTable, Key, Shift);
end;

procedure Tframe36ServiceNewIncidents.cxGridIncidente_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridIncidente_DATA.Index])
        then AText:=FormatDateTime('dd.mm.yyyy hh:nn',ARecord.Values[cxGridIncidente_DATA.Index]);
end;

procedure Tframe36ServiceNewIncidents.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridIncidenteTable.DataController.DataSource:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridIncidenteTable.OnFocusedRecordChanged:=nil;

     inherited;
end;

procedure Tframe36ServiceNewIncidents.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
var customizedFilterData:TFrameDataFilteringInfo;
begin
     inherited;

     // 1. Legam grid-urile de datasource-sele
     cxGridIncidenteTable.DataController.DataSource:=dmDB.IBCDataSourceIncidente;

     // 2. Selection handlers
     cxGridIncidenteTable.OnFocusedRecordChanged:=cxGridIncidenteTableFocusedRecordChanged;

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

     // 4. Selection update
     IncidenteSelectionChanged;
     //cxGridIncidenteTable.ViewData.Expand(True);
end;

function Tframe36ServiceNewIncidents.DoStartIncidentDB(const IncidentID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    // Indicam in ce stare trebuie sa se schimbe incidentul!!!!1

    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_SC_START_INCIDENT(:id)';
    Query.ParamByName('id').AsInteger := IncidentID;
    try
      Query.Transaction.StartTransaction;
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

function Tframe36ServiceNewIncidents.GetCurrentSearchContext: TSearchContextValue;
begin
     Result := Inherited;

     if cxGridIncidenteTable.Site.Focused then
     begin
          // context from Incidente
          if cxGridIncidente_DOC_CUSTOMER.Focused then
          begin
               // Contraagent
               Result.Context := ffCustomer;
               Result.ValueInt := dmDB.IBCQueryIncidente.FieldByName('CT').AsInteger;
               Result.ValueStr := dmDB.IBCQueryIncidente.FieldByName('DOC_CUSTOMER').AsString;
          end
          else
              if cxGridIncidente_GOODS_TITLE.Focused then
              begin
                   // Produs
                   Result.Context := ffGoods;
                   Result.ValueInt := dmDB.IBCQueryIncidente.FieldByName('GOODS_DOCID').AsInteger;
                   Result.ValueStr := dmDB.IBCQueryIncidente.FieldByName('GOODS_TITLE').AsString;
              end
              else
                  if cxGridIncidente_GOODS_SN.Focused then
                  begin
                       // Numar serial
                       Result.Context := ffGoodsSN;
                       Result.ValueStr := dmDB.IBCQueryIncidente.FieldByName('GOODS_SN').AsString;
                  end;
     end;
end;

function Tframe36ServiceNewIncidents.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsIncidente];
end;

function Tframe36ServiceNewIncidents.GetFilterFields: TFrameFilterFields;
begin
     Result := [ffCustomer, ffGoods, ffGoodsSN];
end;

function Tframe36ServiceNewIncidents.GetFrameButtons: TFrameButtons;
begin
     Result := [fbtREFRESH, fbtMODIFY];
end;

procedure Tframe36ServiceNewIncidents.GetParamsListForReport(const ParamsList: TStringList);
begin
  if (cxGridIncidenteTable.DataController.RecNo > 0) then
  begin
    ParamsList.Add('INCIDENTID');
  end;
end;

function Tframe36ServiceNewIncidents.GetParamValueForReport(const ParamName: String): Variant;
begin
  if (cxGridIncidenteTable.DataController.RecNo > 0) then
  begin
    if SameText(ParamName, 'INCIDENTID') then
      Result := dmDB.IBCQueryIncidente.FieldByName('INCIDENTID').AsInteger;
  end;
end;

function Tframe36ServiceNewIncidents.IncidentCanBeStarted(const IncidentID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_SC_CAN_INCIDENT_STARTED(:id)';
    Query.ParamByName('id').AsInteger := IncidentID;
    try
      Query.ExecSQL;
      Result := True;
    except
      on E: Exception do
        if Not ProcessSWNError(E) then
          raise;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe36ServiceNewIncidents.IncidenteSelectionChanged;
var
  fEditDesc, fCreateTask, fGotoParent: Boolean;
begin
  fEditDesc := False;
  fCreateTask := False;
  fGotoParent := False;
  if (cxGridIncidenteTable.DataController.RecNo > 0) then
  begin
    fEditDesc := True;
    fCreateTask := True;
    fGotoParent := True;
  end;
  ButtonStateChanged(fbtMODIFY, fEditDesc);

  bbCreateIncidentTask.Enabled := fCreateTask;
  bbGotoParentDoc.Enabled := fGotoParent;
end;

function Tframe36ServiceNewIncidents.InitFrameID: Integer;
begin
     Result := 36; // SERVICE - Incidente noi
end;

procedure Tframe36ServiceNewIncidents.ModifyRecord;
begin
     ShowIncidentDescriptionDialog;
end;

procedure Tframe36ServiceNewIncidents.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        ReadGridColumnsSettings(cxGridIncidenteTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe36ServiceNewIncidents.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        SaveGridColumnsSettings(cxGridIncidenteTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe36ServiceNewIncidents.SetupDefaultFocus;
begin
     // focused grid
     cxGridIncidente.SetFocus;
     // set focused column
     cxGridIncidente_DOC_CUSTOMER.Focused := True;
end;

procedure Tframe36ServiceNewIncidents.ShowIncidentDescriptionDialog;
var dialog: TfrmServiceNewIncidentEditorDlg;
begin
     dialog := TfrmServiceNewIncidentEditorDlg.Create(Self, dmDB.IBCQueryIncidente, dmDB.IBCDataSourceIncidente);
     try
        if (dialog.ShowModal=mrOk) then dmDB.IBCQueryIncidente.RefreshRecord;
     finally
        dialog.Free;
     end;
end;

procedure Tframe36ServiceNewIncidents.WhenCustomDataFilterGetSQL(var FilterSQL: String);
begin
     FilterSQL:=FilterSQL+' AND (STATUS_ID=:STATUS)';
end;

procedure Tframe36ServiceNewIncidents.WhenCustomDataFilterSetParams(const Query: TIBCQuery);
begin
     Query.ParamByName('STATUS').AsInteger:=6101; // Incidente noi
end;

procedure Tframe36ServiceNewIncidents.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
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
