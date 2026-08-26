unit frame104ReclamatiiUnit;

// imperia.md Parser
// Frame Index = 102

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, DB,
  cxDBData, cxGrid, dxBar, cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.ExtCtrls,
  DBAccess, IBC, Vcl.StdCtrls, cxGridDBBandedTableView, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel, dxBarBuiltInMenu,
  MemDS, cxClasses, cxGridBandedTableView, cxGridTableView, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGridCustomView,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.Menus, cxButtons, cxImageComboBox, cxContainer, cxTextEdit, cxMemo, cxDBEdit, dxUIAClasses;

type
  Tframe104Reclamatii = class(TSWNBaseFrame)
    Panel1: TPanel;
    cxGridBRK: TcxGrid;
    cxGridBRKDBTable: TcxGridDBTableView;
    cxGridBRKDBTableColumn1: TcxGridDBColumn;
    cxGridBRKDBTableDocID: TcxGridDBColumn;
    cxGridBRKDB_CREATED_DATE: TcxGridDBColumn;
    cxGridBRKDBTableData: TcxGridDBColumn;
    cxGridBRKDB_DTDEP_NAME: TcxGridDBColumn;
    cxGridBRKDB_CT_NAME: TcxGridDBColumn;
    cxGridBRKDBTableSuma: TcxGridDBColumn;
    cxGridBRKDB_CURRENCY_NAME: TcxGridDBColumn;
    cxGridBRKDBTableVAT: TcxGridDBColumn;
    cxGridBRKDBTableRate: TcxGridDBColumn;
    cxGridBRKDBTableParentDocID: TcxGridDBColumn;
    cxGridBRKDB_RATEUSD: TcxGridDBColumn;
    cxGridBRK_FLG_ACNT: TcxGridDBColumn;
    cxGridBRKDB_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridBRKDB_DT: TcxGridDBColumn;
    cxGridBRKDB_CT: TcxGridDBColumn;
    cxGridBRK_FLG_CLOSED: TcxGridDBColumn;
    cxGridBRKDB_dtsc_name: TcxGridDBColumn;
    cxGridBRKDB_CTSC_NAME: TcxGridDBColumn;
    cxGridBRKDB_STATE_NAME: TcxGridDBColumn;
    cxGridBRKDBTableColumn2: TcxGridDBColumn;
    cxGridBRKDB_FLG_REZERVA: TcxGridDBColumn;
    cxGridBRKDB_FLG_PROFORMA: TcxGridDBColumn;
    cxGridBRKLevel: TcxGridLevel;
    Panel2: TPanel;
    cxDBMemo1: TcxDBMemo;
  private    { Private declarations }
    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;
    procedure SelectionChanged;
  protected    { Protected declarations }
    function InitFrameID: Integer; override;

    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;

    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;

    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;

    procedure SetupSecurityItems; override;

  public    { Public declarations }
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: string): Variant; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors,
  SWNValueStorageUnit, SWNSecurity, SWNSecurityFlags,
  frmCustomerCurrentDebtsDialog, frmCerereDePlataDialog,
  frmCerereDePlataDBDialog, MuncitorulParserUnit, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, System.IOUtils;

{$R *.dfm}

procedure Tframe104Reclamatii.CreateNewRecord;
begin

end;

procedure Tframe104Reclamatii.DeleteRecord;
begin
end;

procedure Tframe104Reclamatii.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  inherited;
end;

procedure Tframe104Reclamatii.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
  SelectionChanged;
end;

function Tframe104Reclamatii.GetCurrentSearchContext: TSearchContextValue;
begin
end;

function Tframe104Reclamatii.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe104Reclamatii.GetFilterFields: TFrameFilterFields;
begin
    Result := [ffDate, ffCustomer];
end;

function Tframe104Reclamatii.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
    if fSYS_Add then
        Result := Result + [fbtADD];
    if fSYS_Edit or fSYS_View then
        Result := Result + [fbtMODIFY];
    if fSYS_Delete then
        Result := Result + [fbtDELETE];
end;

procedure Tframe104Reclamatii.GetParamsListForReport(const ParamsList: TStringList);
begin
//    ParamsList.Add('FAST_MONEY_TRANSFER');
end;

function Tframe104Reclamatii.GetParamValueForReport(const ParamName: string): Variant;
begin
//    if ParamName = 'FAST_MONEY_TRANSFER' then
//    begin
//        if (dmDb.IBCQueryDocs.FieldByName('SUMA').AsFloat >= 100000) then
//            Result := '1'
//        else
//            Result := '0';
//    end;
end;

function Tframe104Reclamatii.InitFrameID: Integer;
begin
  Result := 104;
end;

procedure Tframe104Reclamatii.ModifyRecord;
begin
end;

procedure Tframe104Reclamatii.ReadFrameStates;
begin

end;

procedure Tframe104Reclamatii.RefreshData;
begin
  inherited;
end;

procedure Tframe104Reclamatii.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;
end;

procedure Tframe104Reclamatii.SelectionChanged;
var
  fDocNew, fDocModify, fDocDelete: Boolean;
begin
  fDocNew := fSYS_Add;     // New Document + Security
  fDocModify := False;
  fDocDelete := False;

  // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocModify);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
end;

procedure Tframe104Reclamatii.SetupSecurityItems;
begin
  inherited;
end;

end.

