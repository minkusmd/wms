unit frame85ApeluriUnit;

// Регистр звонков

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs, SWNDataFiltering,
  SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit,
  cxLabel, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, StdCtrls, ExtCtrls, cxLookAndFeels, cxLookAndFeelPainters, dxBar, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxNavigator, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu,
  DBAccess, IBC, MemDS, dxScrollbarAnnotations, Vcl.Menus, cxButtons, cxCalc, cxImageComboBox, dxUIAClasses;

type
  Tframe85Apeluri = class(TSWNBaseFrame)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete, fSECURITY_OnlyOwnDocuments: Boolean;
    procedure WhenCustomDataFilterGetSQL(var FilterSQL: string);
    procedure WhenCustomDataFilterSetParams(const Query: TIBCQuery);

  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure ModifyRecord; override;
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
  frm82DocumentEditUnit;

{$R *.dfm}

procedure Tframe85Apeluri.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

//     // 1. De scos la griduri event handles for OnFocusedRecordChanged
//  cxGridLivrari_WAYBILL.OnFocusedRecordChanged := nil;
//
//     // 2. De deconectat sursele de date de la griduri
//  cxGridLivrari_WAYBILL.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe85Apeluri.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customDataFilter: TFrameDataFilteringInfo;
begin
  inherited;

//
//     // 1. Legam grid-urile de datasource-sele
//  cxGridLivrari_WAYBILL.DataController.DataSource := IBCDataSourceWaybill;
//
//     // 2. Selection handlers
//  cxGridLivrari_WAYBILL.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;

  customDataFilter := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
  try
    customDataFilter.OnCustomDataFilterGetSQL := WhenCustomDataFilterGetSQL;
    customDataFilter.OnCustomDataFilterSetParams := WhenCustomDataFilterSetParams;
    OpenExternalData(customDataFilter);
  finally
    customDataFilter.Free;
  end;



  //  customDataFilter := FrameDataFilterInfo.Clone;
  try
        // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
//    customDataFilter.FilterByCurrentUser := fSECURITY_OnlyOwnDocuments;
    OpenExternalData(customDataFilter);

  finally
//    customDataFilter.Free;
  end;

     // 4. Selection update
//  SelectionChanged;
end;

function Tframe85Apeluri.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

//  if cxGridLivrariDBTableView1.Site.Focused then
//  begin
//          // context from Docs
//    if cxGridCasaPKO_CT_NAME.Focused then
//    begin
//        // Плательщик
//      Result.Context := ffCustomer;
//      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
//      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
//    end
//    else if cxGridCasaPKO_DATA.Focused then
//    begin
//        // Дата
//      Result.Context := ffDate;
//      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
//    end;
//  end
end;

function Tframe85Apeluri.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
//  Result := [fedsDocs];
end;

function Tframe85Apeluri.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer];
end;

function Tframe85Apeluri.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//  if fSECURITY_CanNew then
//    Result := Result + [fbtADD];
//  if fSECURITY_CanEdit or fSECURITY_CanView then
//    Result := Result + [fbtMODIFY];
//  if fSECURITY_CanDelete then
//    Result := Result + [fbtDELETE];
end;

procedure Tframe85Apeluri.GetParamsListForReport(const ParamsList: TStringList);
begin
//  if (cxGridLivrari_WAYBILL.DataController.RecNo > 0) then
//  begin
//    ParamsList.Add('WAYBILLID');
//  end;
end;

function Tframe85Apeluri.GetParamValueForReport(const ParamName: string): Variant;
begin
//  if (cxGridLivrari_WAYBILL.DataController.RecNo > 0) then
//  begin
//    if SameText(ParamName, 'WAYBILLID') then
//      Result := IBCQueryWaybill.FieldByName('WAYBILLID').AsInteger;
//  end;

end;

function Tframe85Apeluri.InitFrameID: integer;
begin
     // Registrul apelurilor telefonice
  Result := 85;

end;

procedure Tframe85Apeluri.ModifyRecord;
//var
//  dialog: Tfrm82DocumentEditDlg;
//  readonly: Boolean;
begin
//  if fSECURITY_CanEdit then
//    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
//  else
//    readonly := fSECURITY_CanView;
//
//  dialog := Tfrm82DocumentEditDlg.Create(Self, IBCQueryWaybill, IBCDataSourceWaybill);
//  try
//    dialog.IsNewRecord := False;
//    dialog.readonly := readonly;
//    dialog.ShowModal;
//  finally
//    dialog.Free;
//  end;
end;

procedure Tframe85Apeluri.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    ReadGridColumnsSettings(cxGridLivrari_WAYBILL);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe85Apeluri.RefreshData;
begin
//  IBCQueryWaybill.Refresh;
//  IBCQueryWaybillItems.Refresh;
//  IBCQueryOpenedWaybills.Refresh;
end;

procedure Tframe85Apeluri.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    SaveGridColumnsSettings(cxGridLivrari_WAYBILL);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe85Apeluri.SetupDefaultFocus;
begin
//     // grid
//  cxGridLivrari.SetFocus;
//     // columns
//  cxGridLivrari_WAYBILL.Focused := True;
end;

procedure Tframe85Apeluri.SetupSecurityItems;
begin
  fSECURITY_CanView := True;
  fSECURITY_CanNew := False;
  fSECURITY_CanEdit := False;
  fSECURITY_CanDelete := False;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
//    cxGridCasaPKO_FLG_ACNT.VisibleForCustomization := False;
//    cxGridCasaPKO_FLG_ACNT.Visible := False;
  end;
end;

procedure Tframe85Apeluri.WhenCustomDataFilterGetSQL(var FilterSQL: string);
begin
  FilterSQL := FilterSQL;
end;

procedure Tframe85Apeluri.WhenCustomDataFilterSetParams(const Query: TIBCQuery);
begin
//  Query.ParamByName('STATUS').AsInteger:=6101; // Incidente noi
end;

procedure Tframe85Apeluri.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customDataFilter: TFrameDataFilteringInfo;
begin
  customDataFilter := FrameDataFilterInfo.Clone;
  try
    customDataFilter.FilterByCurrentUser := fSECURITY_OnlyOwnDocuments;
    inherited WhenFilterDataChanged(customDataFilter);
  finally
    customDataFilter.Free;
  end;
end;

end.

