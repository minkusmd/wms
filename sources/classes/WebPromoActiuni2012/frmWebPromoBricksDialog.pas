unit frmWebPromoBricksDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, dxBar,
  cxClasses, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, DBAccess, IBC, MemDS, cxImage, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxDateRanges, dxScrollbarAnnotations;

type
  TfrmWebPromoBricksDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    pnButtons: TPanel;
    btnCancel: TButton;
    bbMoveUp: TdxBarButton;
    bbMoveDown: TdxBarButton;
    IBCQueryBlocks: TIBCQuery;
    IBCDataSourceBlocks: TIBCDataSource;
    cxGrid_IMAGE: TcxGridDBColumn;
    cxGrid_ORDERNO: TcxGridDBColumn;
    cxGridTableColumn1: TcxGridDBColumn;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure bbMoveUpClick(Sender: TObject);
    procedure bbMoveDownClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    { Private declarations }
    FPromoActionID: integer;
    procedure SetPromoActionID(const Value: integer);
    procedure SetUpdateTransaction(const Value: TIBCTransaction);
    procedure SelectionChanged;

    procedure ShowCreateNewImageBrickDialog;
    procedure ShowModifyImageBrickDialog;
    procedure DeleteImageBrick;

    function MoveBrickDB(const ImageBrickID,Direction:integer):Boolean;
    procedure MoveDown;
    procedure MoveUp;
  protected
    { protected declarations }
    procedure Prepare;override;
    procedure LoadStates;override;
    procedure SaveStates;override;
  public
    { Public declarations }
    property PromoActionID:integer read FPromoActionID write SetPromoActionID;
    property UpdateTransaction:TIBCTransaction write SetUpdateTransaction;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNValueStorageUnit, SWNUtils, SWNConst, SWNDBErrors,
  frmWebPromoBrickEditorDialog, SWNDBEvents;

{ TfrmWebPromoBricksDlg }

procedure TfrmWebPromoBricksDlg.bbDeleteClick(Sender: TObject);
begin
     DeleteImageBrick;
end;

procedure TfrmWebPromoBricksDlg.bbModifyClick(Sender: TObject);
begin
     ShowModifyImageBrickDialog;
end;

procedure TfrmWebPromoBricksDlg.bbMoveDownClick(Sender: TObject);
begin
     MoveDown;
end;

procedure TfrmWebPromoBricksDlg.bbMoveUpClick(Sender: TObject);
begin
     MoveUp;
end;

procedure TfrmWebPromoBricksDlg.bbNewClick(Sender: TObject);
begin
     ShowCreateNewImageBrickDialog;
end;

procedure TfrmWebPromoBricksDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if (AButton=mbLeft) and bbModify.Enabled then
     begin
          bbModifyClick(bbModify);
          AHandled:=True;
     end;
end;

procedure TfrmWebPromoBricksDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmWebPromoBricksDlg.DeleteImageBrick;
begin
     if ShowAskDialog('Blocuri de publicitate','Stergeti blocul selectat?')<>mrYes then Exit;

     if not IBCQueryBlocks.UpdateTransaction.Active then
       IBCQueryBlocks.UpdateTransaction.StartTransaction;

     try
        IBCQueryBlocks.Delete;
        IBCQueryBlocks.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQueryBlocks.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmWebPromoBricksDlg.LoadStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        // form position
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then Self.Position:=poDesigned;
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmWebPromoBricksDlg.MoveDown;
var ID:integer;
begin
     ID:=IBCQueryBlocks.FieldByName('PAIMAGEBRICKID').AsInteger;
     if (MoveBrickDB(ID,1)) then
     begin
          IBCQueryBlocks.Refresh;
          IBCQueryBlocks.Locate('PAIMAGEBRICKID',ID,[]);
     end;
end;

procedure TfrmWebPromoBricksDlg.MoveUp;
var ID:integer;
begin
     ID:=IBCQueryBlocks.FieldByName('PAIMAGEBRICKID').AsInteger;
     if (MoveBrickDB(ID,-1)) then
     begin
          IBCQueryBlocks.Refresh;
          IBCQueryBlocks.Locate('PAIMAGEBRICKID',ID,[]);
     end;
end;

function TfrmWebPromoBricksDlg.MoveBrickDB(const ImageBrickID, Direction: integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=IBCQueryBlocks.UpdateTransaction;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_PA_IMAGEBRICKS_MOVE(:ID,:DIR)';
        Query.ParamByName('ID').AsInteger:=ImageBrickID;
        Query.ParamByName('DIR').AsInteger:=Direction;

        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmWebPromoBricksDlg.Prepare;
begin
     IBCQueryBlocks.ParamByName('ID').AsInteger:=FPromoActionID;
     IBCQueryBlocks.Active:=True;
     SelectionChanged;
end;

procedure TfrmWebPromoBricksDlg.SaveStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        // form pos
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos)
          then AppUserConfigStorage.FormPositions.SaveFormPos(Self);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure TfrmWebPromoBricksDlg.SelectionChanged;
var fNew,fEdit,fDelete,fUp,fDown:Boolean;
begin
     fNew:=True;
     fEdit:=False;
     fDelete:=False;
     fUp:=False;
     fDown:=False;
     if (cxGridTable.DataController.RecNo>0) then
     begin
          fEdit:=True;
          fDelete:=True;

          fUp:=(cxGridTable.DataController.RecNo>1) and (cxGridTable.DataController.RecordCount>1);
          fDown:=(cxGridTable.DataController.RecNo<cxGridTable.DataController.RecordCount) and (cxGridTable.DataController.RecordCount>1);
     end;
     bbNew.Enabled:=fNew;
     bbModify.Enabled:=fEdit;
     bbDelete.Enabled:=fDelete;
     bbMoveUp.Enabled:=fUp;
     bbMoveDown.Enabled:=fDown;
end;

procedure TfrmWebPromoBricksDlg.SetPromoActionID(const Value: integer);
begin
     FPromoActionID := Value;
end;

procedure TfrmWebPromoBricksDlg.SetUpdateTransaction(const Value: TIBCTransaction);
begin
     IBCQueryBlocks.UpdateTransaction:=Value;
end;

procedure TfrmWebPromoBricksDlg.ShowCreateNewImageBrickDialog;
var dialog:TfrmWebPromoBrickEditorDlg;
begin
     dialog:=TfrmWebPromoBrickEditorDlg.Create(Self,IBCQueryBlocks,IBCDataSourceBlocks);
     try
        dialog.CreateNewRecord:=True;
        dialog.PromoActionID:=FPromoActionID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmWebPromoBricksDlg.ShowModifyImageBrickDialog;
var dialog:TfrmWebPromoBrickEditorDlg;
begin
     dialog:=TfrmWebPromoBrickEditorDlg.Create(Self,IBCQueryBlocks,IBCDataSourceBlocks);
     try
        dialog.CreateNewRecord:=False;
        dialog.PromoActionID:=FPromoActionID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

end.
