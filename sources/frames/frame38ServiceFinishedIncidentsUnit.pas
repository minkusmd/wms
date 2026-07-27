unit frame38ServiceFinishedIncidentsUnit;
{
  СЕРВИС. Решённые инциденты
  DocTypeID = 1402
  Frame Index = 38
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  Vcl.ExtCtrls, cxGraphics,
  DB, cxDBData, cxPC, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar,
  DBAccess, IBC,
  cxDBEdit,
  Vcl.StdCtrls, cxSplitter, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxLabel, cxImageComboBox, dxBarBuiltInMenu,
  cxContainer, MemDS, cxClasses, cxTextEdit, cxMemo, dxUIAClasses;

type
  Tframe38ServiceFinishedIncidents = class(TSWNBaseFrame)
    pnClient: TPanel;
    pnBottom: TPanel;
    pnClientClient: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    cxGridIncidenteTable: TcxGridDBTableView;
    cxGridIncidenteLevel: TcxGridLevel;
    cxGridIncidente: TcxGrid;
    pcPageControl: TcxPageControl;
    dxBarManager: TdxBarManager;
    cxTabSheet3: TcxTabSheet;
    cxGridIncidente_DATA_FINISHED: TcxGridDBColumn;
    cxGridIncidente_DOC_CUSTOMER: TcxGridDBColumn;
    cxGridIncidente_TYPE_TITLE: TcxGridDBColumn;
    cxGridIncidente_VENDOR_TITLE: TcxGridDBColumn;
    cxGridIncidente_GOODS_MODEL: TcxGridDBColumn;
    cxGridIncidente_GOODS_SN: TcxGridDBColumn;
    cxGridIncidente_STATUS_TITLE: TcxGridDBColumn;
    cxGridIncidente_RETURN_DOCID: TcxGridDBColumn;
    dxBarPopupMenu1: TdxBarPopupMenu;
    dxBarButton1: TdxBarButton;
    cxGridIncidente_INCIDENTID: TcxGridDBColumn;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    IBC_Incident_Act: TIBCQuery;
    IBCDS_Incident_Act: TIBCDataSource;
    cxGrid1_ACTNO: TcxGridDBColumn;
    cxGrid1_INCIDENTID: TcxGridDBColumn;
    cxGrid1_ACCEPTED_BY_NAME: TcxGridDBColumn;
    cxGrid1ACCEPTED_DATE: TcxGridDBColumn;
    cxGrid1_CREATED_BY_NAME: TcxGridDBColumn;
    cxGrid1CREATED_DATE: TcxGridDBColumn;
    cxGrid1_DOCID: TcxGridDBColumn;
    dxBarManagerBar1: TdxBar;
    bbIncidentDescription: TdxBarButton;
    cxGridIncidente_RASHOD_DOCID: TcxGridDBColumn;
    cxGridIncidente_PAYER_RASHOD_DOCID: TcxGridDBColumn;
    cxSplitter: TcxSplitter;
    tbsGeneralInfo: TcxTabSheet;
    GridPanel1: TGridPanel;
    GridPanel2: TGridPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    lbDefectPresets: TLabel;
    mmDEFECTE_DSC: TcxDBMemo;
    lbAspect: TLabel;
    mmASPECT_VISUAL_DSC: TcxDBMemo;
    Label8: TLabel;
    mmCOMMENTS: TcxDBMemo;
    cxGrid1DBTable_IMG: TcxGridDBColumn;
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbIncidentDescriptionClick(Sender: TObject);
    procedure cxGridIncidenteTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridIncidente_DATA_FINISHEDGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridIncidenteTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    procedure WhenGridIncidenteTableRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure IncidentSelectionChnaged;

    procedure WhenCustomDataFilterGetSQL(var FilterSQL:String);

  protected
    { Protected declarations }
    function InitFrameID:integer;override;

    function GetExternalDataSourceTypes:TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;
    procedure WhenFilterDataChanged(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;

    function GetFilterFields:TFrameFilterFields;override;
    function GetFrameButtons:TFrameButtons;override;

    function GetPhoneNumber: string; override;

    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    procedure CreateAct1994(AINCIDENTID : INTEGER);

    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: String): Variant; override;

    function GetCurrentSearchContext: TSearchContextValue; override;
  end;


implementation

uses DataModuleDB, SWNDBErrors, frmServiceNewIncidentEditorDialog, SWNValueStorageUnit, frmSelectPhoneNumberUnit,
  SWNUtils;

{$R *.dfm}

{ Tframe38ServiceFinishedIncidents }

function Tframe38ServiceFinishedIncidents.GetPhoneNumber;
 begin
   inherited;
   Result := '';
   frmSelectPhoneNumber := TfrmSelectPhoneNumber.Create(Self);
   try
     frmSelectPhoneNumber.CustomerID := dmDB.IBCQueryIncidente.FieldByName('CT').AsInteger;
     if frmSelectPhoneNumber.ShowModal=mrOK then
     begin
         Result := frmSelectPhoneNumber.SelectedPhoneNumber;
     end;
   finally
     frmSelectPhoneNumber.Free;
   end;
 end;

procedure Tframe38ServiceFinishedIncidents.DoFrameHide;
begin
     // inchidem datele interne
     IBC_Incident_Act.Active:=False;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
     CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
     cxGridIncidenteTable.DataController.DataSource:=nil;
     mmDEFECTE_DSC.DataBinding.DataSource := nil;
     mmASPECT_VISUAL_DSC.DataBinding.DataSource := nil;
     mmCOMMENTS.DataBinding.DataSource := nil;
     cxGridIncidenteTable.DataController.DataSource:=nil;

     // 2. De deconectat sursele de date de la griduri
     cxGridIncidenteTable.OnFocusedRecordChanged:=nil;

     inherited;
end;

procedure Tframe38ServiceFinishedIncidents.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
var customizedFilterData:TFrameDataFilteringInfo;
begin
     inherited;

     pcPageControl.ActivePage:=tbsGeneralInfo;

     // 1. Legam grid-urile de datasource-sele
     mmDEFECTE_DSC.DataBinding.DataSource := dmDB.IBCDS_INCIDENTE_BLOB;
     mmASPECT_VISUAL_DSC.DataBinding.DataSource := dmDB.IBCDS_INCIDENTE_BLOB;
     mmCOMMENTS.DataBinding.DataSource := dmDB.IBCDS_INCIDENTE_BLOB;
     cxGridIncidenteTable.DataController.DataSource:=dmDB.IBCDataSourceIncidente;

     // 2. Selection handlers
     cxGridIncidenteTable.OnFocusedRecordChanged:=WhenGridIncidenteTableRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     // aici mai avem nevoie de un filtru special. indicam procedurile pentru call-back
     customizedFilterData:=TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
     try
        customizedFilterData.OnCustomDataFilterGetSQL:=WhenCustomDataFilterGetSQL;
        OpenExternalData(customizedFilterData);
     finally
        customizedFilterData.Free;
     end;
     // deschidem datele interne
     IBC_Incident_Act.Active:=True;

     // 4. Selection update
     cxGridIncidenteTable.ViewData.Expand(True);
end;

procedure Tframe38ServiceFinishedIncidents.dxBarButton1Click(Sender: TObject);
begin
  inherited;
  CreateAct1994(dmdb.IBCQueryIncidente.FieldByName('Incidentid').AsInteger);

end;

procedure Tframe38ServiceFinishedIncidents.bbIncidentDescriptionClick(Sender: TObject);
var
  dialog: TfrmServiceNewIncidentEditorDlg;
begin
  dialog := TfrmServiceNewIncidentEditorDlg.Create(Self, dmdb.IBCQueryIncidente, dmdb.IBCDataSourceIncidente);
  try
    dialog.ShowModal;

  finally
    dialog.Free;
  end;
end;

procedure Tframe38ServiceFinishedIncidents.CreateAct1994(AINCIDENTID : INTEGER);
var
  Query: TIBCQuery;
begin

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_NEW_ACT_1994(:IID)';
    Query.ParamByName('IID').AsInteger := AINCIDENTID;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
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


procedure Tframe38ServiceFinishedIncidents.cxGridIncidente_DATA_FINISHEDGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridIncidente_DATA_FINISHED.Index]) then AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridIncidente_DATA_FINISHED.Index]);
end;

procedure Tframe38ServiceFinishedIncidents.cxGridIncidenteTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe38ServiceFinishedIncidents.cxGridIncidenteTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnUtils.ProcessCommonKeys(Self, cxGridIncidenteTable, Key, Shift);
end;

function Tframe38ServiceFinishedIncidents.GetCurrentSearchContext: TSearchContextValue;
begin
     Result := Inherited;

     if cxGridIncidenteTable.Site.Focused then
     begin
          // context from Incidente
          if cxGridIncidente_DOC_CUSTOMER.Focused then
          begin
               // Контрагент
               Result.Context := ffCustomer;
               Result.ValueInt := dmDB.IBCQueryIncidente.FieldByName('CT').AsInteger;
               Result.ValueStr := dmDB.IBCQueryIncidente.FieldByName('DOC_CUSTOMER').AsString;
          end
          else
              if cxGridIncidente_GOODS_MODEL.Focused then
              begin
                   // Товар
                   Result.Context := ffGoods;
                   Result.ValueInt := dmDB.IBCQueryIncidente.FieldByName('GOODS_DOCID').AsInteger;
                   Result.ValueStr := dmDB.IBCQueryIncidente.FieldByName('GOODS_TITLE').AsString;
              end
              else
                  if cxGridIncidente_GOODS_SN.Focused then
                  begin
                       // Серийный номер
                       Result.Context := ffGoodsSN;
                       Result.ValueStr := dmDB.IBCQueryIncidente.FieldByName('GOODS_SN').AsString;
                  end;
     end;
end;

function Tframe38ServiceFinishedIncidents.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
     Result:=[fedsIncidente,fedsIncidenteBlob];
end;

function Tframe38ServiceFinishedIncidents.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate, ffCustomer, ffGoods, ffGoodsSN];
end;

function Tframe38ServiceFinishedIncidents.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
end;

procedure Tframe38ServiceFinishedIncidents.GetParamsListForReport(const ParamsList: TStringList);
begin
  inherited;
  if dmdb.IBCQueryIncidente.Active then
  begin
    ParamsList.Add('INCIDENTID');
    ParamsList.Add('DT');
  end;
end;

function Tframe38ServiceFinishedIncidents.GetParamValueForReport(const ParamName: String): Variant;
begin
   if dmdb.IBCQueryIncidente.Active then
  begin
    if SameText(ParamName, 'INCIDENTID') then
      Result := dmdb.IBCQueryIncidente.FieldByName('INCIDENTID').AsInteger;
    if SameText(ParamName, 'DT') then
      Result := dmDB.CurrentFirma;
  end;
end;

procedure Tframe38ServiceFinishedIncidents.IncidentSelectionChnaged;
var fDesc:Boolean;
begin
     fDesc:=False;

     if (cxGridIncidenteTable.DataController.RecNo>0) then
     begin
          fDesc:=True;
     end;

     bbIncidentDescription.Enabled:=fDesc;
end;

function Tframe38ServiceFinishedIncidents.InitFrameID: integer;
begin
     Result:=38; // СЕРВИС - Решённые инциденты
end;

procedure Tframe38ServiceFinishedIncidents.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//        cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridIncidenteTable);
        ReadGridColumnsSettings(cxGrid1DBTableView1);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe38ServiceFinishedIncidents.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridIncidenteTable);
        SaveGridColumnsSettings(cxGrid1DBTableView1);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe38ServiceFinishedIncidents.SetupDefaultFocus;
begin
     // focused grid
     cxGridIncidente.SetFocus;
     // set focused column
     cxGridIncidente_DOC_CUSTOMER.Focused := True;
end;

procedure Tframe38ServiceFinishedIncidents.WhenCustomDataFilterGetSQL(var FilterSQL: String);
begin
     FilterSQL:=FilterSQL+' AND (STATUS_ID IN (6110,6111,6112,6113))';
end;

procedure Tframe38ServiceFinishedIncidents.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var customizedFilterData:TFrameDataFilteringInfo;
begin
     customizedFilterData:=TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
     try
        customizedFilterData.OnCustomDataFilterGetSQL:=WhenCustomDataFilterGetSQL;
        inherited WhenFilterDataChanged(customizedFilterData);
        cxGridIncidenteTable.ViewData.Expand(True);
     finally
        customizedFilterData.Free;
     end;
end;

procedure Tframe38ServiceFinishedIncidents.WhenGridIncidenteTableRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     IncidentSelectionChnaged;
end;

end.
