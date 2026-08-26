unit frmCrediteGoodsGroupsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses, dxBar, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, DBAccess, IBC, MemDS, Vcl.StdCtrls,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCrediteGoodsGroupsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridGGTable: TcxGridDBTableView;
    cxGridGGLevel: TcxGridLevel;
    cxGridGG: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCQueryGG: TIBCQuery;
    IBCDataSourceGG: TIBCDataSource;
    IBCTrGGUpdate: TIBCTransaction;
    cxGridGGTable_GG_ID: TcxGridDBColumn;
    cxGridGGTable_TITLE: TcxGridDBColumn;
    cxGridGGTable_DESCRIPTION: TcxGridDBColumn;
    cxGridGGTable_CREATED_BY_NAME: TcxGridDBColumn;
    pnButtons: TPanel;
    btnSelect: TButton;
    btnClose: TButton;
    procedure cxGridGGTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure cxGridGGTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
  private
    { Private declarations }
    fGG_Title: String;
    fGG_ID: Integer;
    fIDtoLocate: Integer;

    procedure SelectionChanged;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    function SelectGoodsGroup(const ExistingGGID:Integer):Boolean;

    property GG_ID:Integer read fGG_ID;
    property GG_Title:String read fGG_Title;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNConst, SWNUtils, SWNDBErrors, frmGoodsGroupsEditorDialog;

procedure TfrmCrediteGoodsGroupsDlg.bbDeleteClick(Sender: TObject);
begin
     if ShowAskDialog('Grupe produse pentru credit',
                      Format('Stergeti grupa de produse %s"?',[IBCQueryGG.FieldByName('TITLE').AsString]))<>mrYes then Exit;

     IBCQueryGG.UpdateTransaction.StartTransaction;
     try
        IBCQueryGG.Delete;
        IBCQueryGG.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQueryGG.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmCrediteGoodsGroupsDlg.bbModifyClick(Sender: TObject);
var dialog:TfrmGoodsGroupsEditorDlg;
begin
     dialog:=TfrmGoodsGroupsEditorDlg.Create(Self,IBCQueryGG,IBCDataSourceGG);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmCrediteGoodsGroupsDlg.bbNewClick(Sender: TObject);
var dialog:TfrmGoodsGroupsEditorDlg;
begin
     dialog:=TfrmGoodsGroupsEditorDlg.Create(Self,IBCQueryGG,IBCDataSourceGG);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmCrediteGoodsGroupsDlg.btnSelectClick(Sender: TObject);
begin
     if Assigned(cxGridGGTable.Controller.FocusedRecord) then
     begin
          fGG_ID:=IBCQueryGG.FieldByName('GG_ID').AsInteger;
          fGG_Title:=IBCQueryGG.FieldByName('TITLE').AsString;
          ModalResult:=mrOk;
     end;
end;

procedure TfrmCrediteGoodsGroupsDlg.cxGridGGTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color:=$E8E8E8;
end;

procedure TfrmCrediteGoodsGroupsDlg.cxGridGGTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmCrediteGoodsGroupsDlg.FormCreate(Sender: TObject);
begin
     btnSelect.Visible:=False;
     fIDtoLocate:=0;
end;

procedure TfrmCrediteGoodsGroupsDlg.Prepare;
begin
     cxGridGGTable_TITLE.Focused:=True;
     IBCQueryGG.Active:=True;
     if fIDtoLocate>0 then IBCQueryGG.Locate('GG_ID',fIDtoLocate,[]);

     SelectionChanged;
end;

function TfrmCrediteGoodsGroupsDlg.SelectGoodsGroup(const ExistingGGID:Integer): Boolean;
begin
     fIDtoLocate:=ExistingGGID;
     btnSelect.Visible:=True;
     Result:=ShowModal=mrOk;
end;

procedure TfrmCrediteGoodsGroupsDlg.SelectionChanged;
var fAdd,fEdit,fDelete:Boolean;
begin
     fAdd:=True;
     fEdit:=False;
     fDelete:=False;

     if cxGridGGTable.DataController.RecNo>0 then
     begin
          fEdit:=True;
          fDelete:=True;
     end;

     bbNew.Enabled:=fAdd;
     bbModify.Enabled:=fEdit;
     bbDelete.Enabled:=fDelete;
end;

end.
