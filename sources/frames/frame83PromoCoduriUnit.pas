unit frame83PromoCoduriUnit;

// PUBLICITATE - coduri promo

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNBaseFrameUnit, SWNDocumentFilters, SWNDataFiltering, Data.DB, DBAccess, IBC,
  MemDS, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, cxLabel, cxCheckBox, Vcl.StdCtrls,
  Vcl.ExtCtrls, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxDateRanges, cxDropDownEdit, dxScrollbarAnnotations, dxBar, cxSplitter;

type
  Tframe83PromoCoduri = class(TSWNBaseFrame)
    IBCQueryPromoTickets: TIBCQuery;
    IBCDataSourcePromoTickets: TIBCDataSource;
    cxGridPromoTickets: TcxGrid;
    cxGridPromoTicketsTable: TcxGridDBTableView;
    cxGridPromoTicketsLevel: TcxGridLevel;
    Panel1: TPanel;
    Label1: TLabel;
    cxGridPromoTicketsTableTICKETID: TcxGridDBColumn;
    cxGridPromoTicketsTableTITLE: TcxGridDBColumn;
    cxGridPromoTicketsTableTICKET_CODE: TcxGridDBColumn;
    cxGridPromoTicketsTableDATA1: TcxGridDBColumn;
    cxGridPromoTicketsTableDATA2: TcxGridDBColumn;
    cxGridPromoTicketsTableDISCOUNT_VALUE: TcxGridDBColumn;
    cxGridPromoTicketsTableDISCOUNT_PERCENT: TcxGridDBColumn;
    Panel2: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxSplitter1: TcxSplitter;
    IBCQueryPromoTicketsItems: TIBCQuery;
    IBCDataSourcePromoTicketsItems: TIBCDataSource;
    cxGrid1DBTableView1TICKETID: TcxGridDBColumn;
    cxGrid1DBTableView1PROMO_CODE: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    bbShowAllRecords: TdxBarButton;
    procedure cxGridPromoTicketsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridPromoTicketsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbShowAllRecordsClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_New, fSECURITY_Edit, fSECURITY_Delete: Boolean;
    procedure PrepareData;
    procedure SelectionChanged;
  protected
    { Protected declarations }
    function InitFrameID: Integer; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;
    procedure CloneRecord; override;

    procedure SetupSecurityItems; override;

  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
  end;

implementation

{$R *.dfm}

uses
  DataModuleDB, SWNSecurity, SWNSecurityFlags, SWNUtils, SWNDBErrors,
  frmMarketingActiuneEditorDialog, frmPromoCodesEditorUnit;

{ Tframe47ActiuniMarketing }

procedure Tframe83PromoCoduri.bbShowAllRecordsClick(Sender: TObject);
begin
  inherited;
  PrepareData;
end;

procedure Tframe83PromoCoduri.CloneRecord;
begin
  inherited;

end;

procedure Tframe83PromoCoduri.CreateNewRecord;
var
  dialog: TfrmPromoCodesEditorDlg;
begin
  dialog := TfrmPromoCodesEditorDlg.Create(Self, IBCQueryPromoTickets, IBCDataSourcePromoTickets);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe83PromoCoduri.cxGridPromoTicketsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe83PromoCoduri.cxGridPromoTicketsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure Tframe83PromoCoduri.DeleteRecord;
begin
  if ShowAskDialog('Sterge PromoCod', Format('Stergeti promo coddul "%s"?', [IBCQueryPromoTickets.FieldByName('TITLE').AsString])) <> mrYes then
    Exit;

  IBCQueryPromoTickets.UpdateTransaction.StartTransaction;
  try
    IBCQueryPromoTickets.Delete;
    IBCQueryPromoTickets.UpdateTransaction.Commit;
  except
    on E: Exception do begin
      IBCQueryPromoTickets.UpdateTransaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure Tframe83PromoCoduri.DoFrameHide;
begin
  IBCQueryPromoTickets.Close;
  inherited;
end;

procedure Tframe83PromoCoduri.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;
  bbShowAllRecords.Down := False;
  (*TODO: extracted code
  if bbShowAllRecords.Down then
    IBCQueryPromoTickets.MacroByName('m45Days').Value := ''
  else
    IBCQueryPromoTickets.MacroByName('m45Days').Value := 'where cast(data2 as date)> (current_date - 60)';
  IBCQueryPromoTickets.Active := True;
  *)
  PrepareData;
  SelectionChanged;
end;

function Tframe83PromoCoduri.GetFilterFields: TFrameFilterFields;
begin
  Result := [];
end;

function Tframe83PromoCoduri.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_New then
    Result := Result + [fbtADD, fbtCLONE];
  if fSECURITY_Edit then
    Result := Result + [fbtMODIFY];
  if fSECURITY_Delete then
    Result := Result + [fbtDELETE];
end;

function Tframe83PromoCoduri.InitFrameID: Integer;
begin
  Result := 83;
end;

procedure Tframe83PromoCoduri.ModifyRecord;
var
  dialog: TfrmPromoCodesEditorDlg;
begin
  dialog := TfrmPromoCodesEditorDlg.Create(Self, IBCQueryPromoTickets, IBCDataSourcePromoTickets);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe83PromoCoduri.PrepareData;
begin
  IBCQueryPromoTickets.Active := False;
  if bbShowAllRecords.Down then
    IBCQueryPromoTickets.MacroByName('m45Days').Value := ''
  else
    IBCQueryPromoTickets.MacroByName('m45Days').Value := 'where cast(data2 as date)> (current_date - 60)';
  IBCQueryPromoTickets.Active := True;
end;

procedure Tframe83PromoCoduri.RefreshData;
begin
  IBCQueryPromoTickets.Refresh;
end;

procedure Tframe83PromoCoduri.SelectionChanged;
var
  fNew, fEdit, fDelete: Boolean;
begin
  fNew := fSECURITY_New;
  fEdit := False;
  fDelete := False;

  if cxGridPromoTicketsTable.DataController.RecNo > 0 then begin
    fEdit := fSECURITY_Edit;
    fDelete := fSECURITY_Delete;
  end;

  ButtonStateChanged(fbtADD, fNew);
  ButtonStateChanged(fbtMODIFY, fEdit);
  ButtonStateChanged(fbtDELETE, fDelete);
end;

procedure Tframe83PromoCoduri.SetupDefaultFocus;
begin
  cxGridPromoTickets.SetFocus;
  cxGridPromoTicketsTableTITLE.Focused := True;
end;

procedure Tframe83PromoCoduri.SetupSecurityItems;
begin
//     fSECURITY_New:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_—ÓÁ‰‡Ú¸);
//     fSECURITY_Edit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_»ÁÏÂÌËÚ¸);
//     fSECURITY_Delete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_”‰‡ÎËÚ¸);

  fSECURITY_New := True;
  fSECURITY_Edit := True;
  fSECURITY_Delete := True;
end;

end.

