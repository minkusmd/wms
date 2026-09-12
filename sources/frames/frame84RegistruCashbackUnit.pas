unit frame84RegistruCashbackUnit;

// PUBLICITATE - coduri promo

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseFrameUnit, SWNDocumentFilters, SWNDataFiltering, Data.DB, DBAccess, IBC, MemDS, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxLabel, cxCheckBox, Vcl.StdCtrls,
  Vcl.ExtCtrls, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, cxDropDownEdit,
  dxScrollbarAnnotations, dxBarBuiltInMenu, cxPC, dxBar;

type
  Tframe84RegistruCashback = class(TSWNBaseFrame)
    IBCDataSourceCashback: TIBCDataSource;
    cxGridCashback: TcxGrid;
    cxGridCashbackTable: TcxGridDBTableView;
    cxGridCashbackLevel: TcxGridLevel;
    IBCQueryCashback: TIBCQuery;
    cxGridCashbackTableCUSTOMERID: TcxGridDBColumn;
    cxGridCashbackTableCUSTOMER_NAME: TcxGridDBColumn;
    cxGridCashbackTableDATA: TcxGridDBColumn;
    cxGridCashbackTableAMOUNT: TcxGridDBColumn;
    cxGridCashbackTableDATA_START: TcxGridDBColumn;
    cxGridCashbackTableDATA_END: TcxGridDBColumn;
    cxGridCashbackTableCREATED_BY: TcxGridDBColumn;
    cxGridCashbackTableCREATE_BY_NAME: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    cxGridCashbackTablePHONES: TcxGridDBColumn;
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    procedure cxGridCashbackTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridCashbackTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
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

uses DataModuleDB, SWNSecurity, SWNSecurityFlags, SWNUtils, SWNDBErrors, frmMarketingActiuneEditorDialog, frmRegistruCashbackEditorUnit;

{ Tframe47ActiuniMarketing }

procedure Tframe84RegistruCashback.CloneRecord;
begin
  inherited;

end;

procedure Tframe84RegistruCashback.CreateNewRecord;
var dialog: TfrmRegistruCashbackEditorDlg;
begin
     dialog:=TfrmRegistruCashbackEditorDlg.Create(self, IBCQueryCashback,IBCDataSourceCashback);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe84RegistruCashback.cxGridCashbackTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color:=$E8E8E8;
end;

procedure Tframe84RegistruCashback.cxGridCashbackTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure Tframe84RegistruCashback.DeleteRecord;
begin
     if ShowAskDialog('Sterge PromoCod',
                      Format('Stergeti cashback pentru "%s"?',[IBCQueryCashBack.FieldByName('CUSTOMER_NAME').AsString]))<>mrYes then Exit;

     IBCQueryCashBack.UpdateTransaction.StartTransaction;
     try
        IBCQueryCashBack.Delete;
        IBCQueryCashBack.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQueryCashBack.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure Tframe84RegistruCashback.DoFrameHide;
begin
     IBCQueryCashBack.Close;
     inherited;
end;

procedure Tframe84RegistruCashback.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
     inherited;
     IBCQueryCashBack.Active:=True;
     SelectionChanged;
end;

function Tframe84RegistruCashback.GetFilterFields: TFrameFilterFields;
begin
     Result:=[];
end;

function Tframe84RegistruCashback.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_New then Result:=Result+[fbtADD,fbtCLONE];
     if fSECURITY_Edit then Result:=Result+[fbtMODIFY];
     if fSECURITY_Delete then Result:=Result+[fbtDELETE];
end;

function Tframe84RegistruCashback.InitFrameID: integer;
begin
     Result:=84;
end;

procedure Tframe84RegistruCashback.ModifyRecord;
var dialog:TfrmRegistruCashbackEditorDlg;
begin
     dialog:=TfrmRegistruCashbackEditorDlg.Create(self, IBCQueryCashback,IBCDataSourceCashback);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe84RegistruCashback.RefreshData;
begin
     IBCQueryCashBack.Refresh;
end;

procedure Tframe84RegistruCashback.SelectionChanged;
var fNew,fEdit,fDelete:Boolean;
begin
     fNew:=fSECURITY_New;
     fEdit:=False;
     fDelete:=False;

     if cxGridCashbackTable.DataController.RecNo>0 then
     begin
          fEdit:=fSECURITY_Edit;
          fDelete:=fSECURITY_Delete;
     end;

     ButtonStateChanged(fbtADD,fNew);
     ButtonStateChanged(fbtMODIFY,fEdit);
     ButtonStateChanged(fbtDELETE,fDelete);
end;

procedure Tframe84RegistruCashback.SetupDefaultFocus;
begin
     cxGridCashback.SetFocus;
     cxGridCashbackTableCUSTOMER_NAME.Focused:=True;
end;

procedure Tframe84RegistruCashback.SetupSecurityItems;
begin
//     fSECURITY_New:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_—ÓÁ‰‡Ú¸);
//     fSECURITY_Edit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_»ÁÏÂÌËÚ¸);
//     fSECURITY_Delete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_”‰‡ÎËÚ¸);

     fSECURITY_New := True;
     fSECURITY_Edit := True;
     fSECURITY_Delete := True;
end;

end.
