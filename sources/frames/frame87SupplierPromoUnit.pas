unit frame87SupplierPromoUnit;

// –≈ À¿Ã¿ - ÔÓÏÓ ÍÓ‰˚

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseFrameUnit, SWNDocumentFilters, SWNDataFiltering, Data.DB, DBAccess, IBC, MemDS, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxLabel, cxCheckBox, Vcl.StdCtrls,
  Vcl.ExtCtrls, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, cxDropDownEdit,
  dxScrollbarAnnotations;

type
  Tframe87SupplierPromo = class(TSWNBaseFrame)
    cxGridSupplierPromo: TcxGrid;
    cxGridSupplierPromoTable: TcxGridDBTableView;
    cxGridSupplierPromoLevel: TcxGridLevel;
    Panel1: TPanel;
    cxGridSupplierPromoTable_ID: TcxGridDBColumn;
    cxGridSupplierPromoTable_TITLE: TcxGridDBColumn;
    cxGridSupplierPromoTable_DATA1: TcxGridDBColumn;
    cxGridSupplierPromoTable_DATA2: TcxGridDBColumn;
    IBCQuerySupplierPromo: TIBCQuery;
    IBCDataSourceSupplierPromo: TIBCDataSource;
    cxGridSupplierPromoTable_SupplierID: TcxGridDBColumn;
    procedure cxGridSupplierPromoTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridSupplierPromoTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
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

uses DataModuleDB, SWNSecurity, SWNSecurityFlags, SWNUtils, SWNDBErrors, frmMarketingActiuneEditorDialog, frmPromoCodesEditorUnit, frmSupplierPromoEditorUnit;

{ Tframe47ActiuniMarketing }

procedure Tframe87SupplierPromo.CloneRecord;
begin
  inherited;

end;

procedure Tframe87SupplierPromo.CreateNewRecord;
var dialog: TfrmSupplierPromoEditorDlg;
begin
     dialog := TfrmSupplierPromoEditorDlg.Create(self,IBCQuerySupplierPromo,IBCDataSourceSupplierPromo);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe87SupplierPromo.cxGridSupplierPromoTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color:=$E8E8E8;
end;

procedure Tframe87SupplierPromo.cxGridSupplierPromoTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure Tframe87SupplierPromo.DeleteRecord;
begin
     if ShowAskDialog('Sterge promotie furnizor',
                      Format('Stergeti promotia nr. "%s"?',[IBCQuerySupplierPromo.FieldByName('TITLE').AsString]))<>mrYes then Exit;

     IBCQuerySupplierPromo.UpdateTransaction.StartTransaction;
     try
        IBCQuerySupplierPromo.Delete;
        IBCQuerySupplierPromo.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQuerySupplierPromo.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure Tframe87SupplierPromo.DoFrameHide;
begin
     IBCQuerySupplierPromo.Close;
     inherited;
end;

procedure Tframe87SupplierPromo.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
     inherited;
     IBCQuerySupplierPromo.Active:=True;
     SelectionChanged;
end;

function Tframe87SupplierPromo.GetFilterFields: TFrameFilterFields;
begin
     Result:=[];
end;

function Tframe87SupplierPromo.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
     if fSECURITY_New then Result:=Result+[fbtADD,fbtCLONE];
     if fSECURITY_Edit then Result:=Result+[fbtMODIFY];
     if fSECURITY_Delete then Result:=Result+[fbtDELETE];
end;

function Tframe87SupplierPromo.InitFrameID: integer;
begin
     Result:=87;  // Supplier Promotions
end;

procedure Tframe87SupplierPromo.ModifyRecord;
var dialog:TfrmSupplierPromoEditorDlg;
begin
     dialog:=TfrmSupplierPromoEditorDlg.Create(self, IBCQuerySupplierPromo, IBCDataSourceSupplierPromo);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe87SupplierPromo.RefreshData;
begin
     IBCQuerySupplierPromo.Refresh;
end;

procedure Tframe87SupplierPromo.SelectionChanged;
var fNew,fEdit,fDelete:Boolean;
begin
     fNew:=fSECURITY_New;
     fEdit:=False;
     fDelete:=False;

     if cxGridSupplierPromoTable.DataController.RecNo>0 then
     begin
          fEdit:=fSECURITY_Edit;
          fDelete:=fSECURITY_Delete;
     end;

     ButtonStateChanged(fbtADD,fNew);
     ButtonStateChanged(fbtMODIFY,fEdit);
     ButtonStateChanged(fbtDELETE,fDelete);
end;

procedure Tframe87SupplierPromo.SetupDefaultFocus;
begin
     cxGridSupplierPromo.SetFocus;
     cxGridSupplierPromoTable_TITLE.Focused:=True;
end;

procedure Tframe87SupplierPromo.SetupSecurityItems;
begin
//     fSECURITY_New:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_—ÓÁ‰‡Ú¸);
//     fSECURITY_Edit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_»ÁÏÂÌËÚ¸);
//     fSECURITY_Delete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_–≈ À¿Ã¿_Ã¿_”‰‡ÎËÚ¸);

     fSECURITY_New := True;
     fSECURITY_Edit := True;
     fSECURITY_Delete := True;
end;

end.
