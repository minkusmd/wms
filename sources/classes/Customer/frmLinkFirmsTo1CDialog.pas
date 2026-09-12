unit frmLinkFirmsTo1CDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DialogTitle, Vcl.ExtCtrls, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar, DBAccess, IBC, MemDS;

type
  TfrmLinkFirmsTo1CDlg = class(TSWNCustomForm)
    pnClient: TPanel;
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbAddFirma: TdxBarButton;
    bbModifyFirma: TdxBarButton;
    bbDeleteFirma: TdxBarButton;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    IBCQuery1C: TIBCQuery;
    IBCDataSource1C: TIBCDataSource;
    cxGridT_CUSTOMERID: TcxGridDBColumn;
    cxGrid_CUSTOMER_TITLE: TcxGridDBColumn;
    cxGrid_FIRMA_COD: TcxGridDBColumn;
    cxGrid_FIRMA_NAME: TcxGridDBColumn;
    cxGrid_SKLAD_COD: TcxGridDBColumn;
    cxGrid_SKLAD_TITLE: TcxGridDBColumn;
    cxGrid_SKLAD_TYPE: TcxGridDBColumn;
    cxGrid_PERS_FIZ_CODE: TcxGridDBColumn;
    cxGrid_PERS_FIZ_TITLE: TcxGridDBColumn;
    cxGrid_DT_TITLE: TcxGridDBColumn;
    IBCTr1ÑUpdate: TIBCTransaction;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbAddFirmaClick(Sender: TObject);
    procedure bbDeleteFirmaClick(Sender: TObject);
    procedure bbModifyFirmaClick(Sender: TObject);
  private
    { Private declarations }
    fFirmaFolderID: Integer;
    procedure SetFirmaFolderID(const Value: Integer);
    procedure SelectionChanged;
    procedure ShowAddNewFirmaDialog;
    procedure ShowModifyFirmaDialog;
    procedure DeleteSelectedFirma;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property FirmaFolderID:Integer read fFirmaFolderID write SetFirmaFolderID;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNDBErrors, frmLinkFirmsTo1CEditorDialog;

{ TfrmLinkFirmsTo1CDlg }

procedure TfrmLinkFirmsTo1CDlg.bbAddFirmaClick(Sender: TObject);
begin
     ShowAddNewFirmaDialog;
end;

procedure TfrmLinkFirmsTo1CDlg.bbDeleteFirmaClick(Sender: TObject);
begin
     DeleteSelectedFirma;
end;

procedure TfrmLinkFirmsTo1CDlg.bbModifyFirmaClick(Sender: TObject);
begin
     ShowModifyFirmaDialog;
end;

procedure TfrmLinkFirmsTo1CDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmLinkFirmsTo1CDlg.DeleteSelectedFirma;
begin
     if ShowAskDialog('Stergere firma',Format('Doriti sa stergeti firma "%s"?',[IBCQuery1C.FieldByName('CUSTOMER_TITLE').asString]),
                      'Exportul datelor pentru aceasta firma in 1C nu va mai avea loc!')<>mrYes then Exit;

     IBCQuery1C.UpdateTransaction.StartTransaction;
     try
        IBCQuery1C.Delete;
        IBCQuery1C.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQuery1C.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmLinkFirmsTo1CDlg.Prepare;
begin
     IBCQuery1C.ParamByName('PARENTID').AsInteger:=fFirmaFolderID;
     IBCQuery1C.Active:=True;
     SelectionChanged;
end;

procedure TfrmLinkFirmsTo1CDlg.SelectionChanged;
var fAdd,fEdit,fDelete:Boolean;
begin
     fAdd:=True;
     fEdit:=False;
     fDelete:=False;
     if (cxGridTable.DataController.RecNo>0) then
     begin
          fEdit:=True;
          fDelete:=True;
     end;
     bbAddFirma.Enabled:=fAdd;
     bbModifyFirma.Enabled:=fEdit;
     bbDeleteFirma.Enabled:=fDelete;
end;

procedure TfrmLinkFirmsTo1CDlg.SetFirmaFolderID(const Value: Integer);
begin
     FFirmaFolderID := Value;
end;

procedure TfrmLinkFirmsTo1CDlg.ShowAddNewFirmaDialog;
var dialog:TfrmLinkFirmsTo1CEditorDlg;
begin
     dialog:=TfrmLinkFirmsTo1CEditorDlg.Create(Self,IBCQuery1C,IBCDataSource1C);
     try
        dialog.CreateNewRecord:=True;
        dialog.FolderParentID:=fFirmaFolderID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmLinkFirmsTo1CDlg.ShowModifyFirmaDialog;
var dialog:TfrmLinkFirmsTo1CEditorDlg;
begin
     dialog:=TfrmLinkFirmsTo1CEditorDlg.Create(Self,IBCQuery1C,IBCDataSource1C);
     try
        dialog.CreateNewRecord:=False;
        dialog.FolderParentID:=fFirmaFolderID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

end.
