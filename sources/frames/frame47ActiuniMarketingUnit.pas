unit frame47ActiuniMarketingUnit;

// PUBLICITATE - Actiuni de marketing

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseFrameUnit, SWNDocumentFilters, SWNDataFiltering, Data.DB, DBAccess, IBC, MemDS, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxLabel, cxCheckBox, Vcl.StdCtrls,
  Vcl.ExtCtrls, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, cxDropDownEdit,
  dxScrollbarAnnotations;

type
  Tframe47ActiuniMarketing = class(TSWNBaseFrame)
    IBCQueryActiuni: TIBCQuery;
    IBCDataSourceActiuni: TIBCDataSource;
    cxGridActiuni: TcxGrid;
    cxGridActiuniTable: TcxGridDBTableView;
    cxGridActiuniLevel: TcxGridLevel;
    cxGridActiuniTable_ACTIUNE_ID: TcxGridDBColumn;
    cxGridActiuniTable_TITLE: TcxGridDBColumn;
    cxGridActiuniTable_START_DATE: TcxGridDBColumn;
    cxGridActiuniTable_END_DATE: TcxGridDBColumn;
    cxGridActiuniTable_FLG_ENABLED: TcxGridDBColumn;
    cxGridActiuniTable_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridActiuniTable_ANALITICA_TITLE: TcxGridDBColumn;
    Panel1: TPanel;
    Label1: TLabel;
    cxGridActiuniTable_DISCOUNT: TcxGridDBColumn;
    cxGridActiuniTableColumn1: TcxGridDBColumn;
    procedure cxGridActiuniTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridActiuniTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
  private
    { Private declarations }
    fSECURITY_New, fSECURITY_Edit, fSECURITY_Delete: Boolean;
    procedure SelectionChanged;
  protected
    { Protected declarations }
    function InitFrameID:integer;override;
    function GetFilterFields:TFrameFilterFields;override;
    function GetFrameButtons:TFrameButtons;override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;

    procedure CreateNewRecord;override;
    procedure ModifyRecord;override;
    procedure DeleteRecord;override;
    procedure RefreshData;override;
    procedure CloneRecord;override;

    procedure SetupSecurityItems;override;

  public
    { Public declarations }
    procedure SetupDefaultFocus;override;
  end;

implementation

{$R *.dfm}

uses DataModuleDB, SWNSecurity, SWNSecurityFlags, SWNUtils, SWNDBErrors, frmMarketingActiuneEditorDialog;

{ Tframe47ActiuniMarketing }

procedure Tframe47ActiuniMarketing.CloneRecord;
begin
  inherited;

end;

procedure Tframe47ActiuniMarketing.CreateNewRecord;
var dialog:TfrmMarketingActiuneEditorDlg;
begin
     dialog:=TfrmMarketingActiuneEditorDlg.Create(self,IBCQueryActiuni,IBCDataSourceActiuni);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe47ActiuniMarketing.cxGridActiuniTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color:=$E8E8E8;
end;

procedure Tframe47ActiuniMarketing.cxGridActiuniTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure Tframe47ActiuniMarketing.DeleteRecord;
begin
     if ShowAskDialog('Stergere actiune',
                      Format('Doriti sa stergeti actiunea "%s"?',[IBCQueryActiuni.FieldByName('TITLE').AsString]))<>mrYes then Exit;

     IBCQueryActiuni.UpdateTransaction.StartTransaction;
     try
        IBCQueryActiuni.Delete;
        IBCQueryActiuni.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQueryActiuni.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure Tframe47ActiuniMarketing.DoFrameHide;
begin
     IBCQueryActiuni.Close;
     inherited;
end;

procedure Tframe47ActiuniMarketing.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
     inherited;
     IBCQueryActiuni.Active:=True;
     SelectionChanged;
end;

function Tframe47ActiuniMarketing.GetFilterFields: TFrameFilterFields;
begin
     Result:=[];
end;

function Tframe47ActiuniMarketing.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_New then Result:=Result+[fbtADD,fbtCLONE];
     if fSECURITY_Edit then Result:=Result+[fbtMODIFY];
     if fSECURITY_Delete then Result:=Result+[fbtDELETE];
end;

function Tframe47ActiuniMarketing.InitFrameID: integer;
begin
     Result:=47;
end;

procedure Tframe47ActiuniMarketing.ModifyRecord;
var dialog:TfrmMarketingActiuneEditorDlg;
begin
     dialog:=TfrmMarketingActiuneEditorDlg.Create(self,IBCQueryActiuni,IBCDataSourceActiuni);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe47ActiuniMarketing.RefreshData;
begin
     IBCQueryActiuni.Refresh;
end;

procedure Tframe47ActiuniMarketing.SelectionChanged;
var fNew,fEdit,fDelete:Boolean;
begin
     fNew:=fSECURITY_New;
     fEdit:=False;
     fDelete:=False;

     if cxGridActiuniTable.DataController.RecNo>0 then
     begin
          fEdit:=fSECURITY_Edit;
          fDelete:=fSECURITY_Delete;
     end;

     ButtonStateChanged(fbtADD,fNew);
     ButtonStateChanged(fbtMODIFY,fEdit);
     ButtonStateChanged(fbtDELETE,fDelete);
end;

procedure Tframe47ActiuniMarketing.SetupDefaultFocus;
begin
     // grid
     cxGridActiuni.SetFocus;
     // column
     cxGridActiuniTable_TITLE.Focused:=True;
end;

procedure Tframe47ActiuniMarketing.SetupSecurityItems;
begin
     fSECURITY_New:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_—ÓÁ‰‡Ú¸);
     fSECURITY_Edit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_»ÁÏÂÌËÚ¸);
     fSECURITY_Delete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_”‰‡ÎËÚ¸);
end;

end.
