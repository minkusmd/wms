unit frmContractsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  DBAccess, IBC, MemDS, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxBar, Vcl.ExtCtrls, DialogTitle, Vcl.StdCtrls;

type
  TfrmContractsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridCTable: TcxGridDBTableView;
    cxGridCLevel: TcxGridLevel;
    cxGridC: TcxGrid;
    IBCQueryC: TIBCQuery;
    IBCDataSourceC: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGridC_CONTRACTID: TcxGridDBColumn;
    cxGridC_DT_NAME: TcxGridDBColumn;
    cxGridC_CT_NAME: TcxGridDBColumn;
    cxGridC_SIGN_DATE: TcxGridDBColumn;
    cxGridC_EXPIRE_DATE: TcxGridDBColumn;
    cxGridC_CURRENCY_TITLE: TcxGridDBColumn;
    cxGridC_CODE: TcxGridDBColumn;
    btnCancel: TButton;
    cxGridC_CONTRACT_TYPE_TITLE: TcxGridDBColumn;
    cxGridC_CREATED_BY_NAME: TcxGridDBColumn;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    procedure cxGridCTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    { Private declarations }
    fCT: integer;
    procedure SelectionChanged;
    procedure SetCT(const Value: integer);

    procedure ShowCreateNewContractDialog;
    procedure ShowModicyContractDialog;
    procedure DeleteContract;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property CT:integer read FCT write SetCT;
  end;


implementation

{$R *.dfm}

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNDBErrors;

{ TForm2 }

procedure TfrmContractsDlg.bbDeleteClick(Sender: TObject);
begin
     DeleteContract;
end;

procedure TfrmContractsDlg.bbEditClick(Sender: TObject);
begin
     ShowModicyContractDialog;
end;

procedure TfrmContractsDlg.bbNewClick(Sender: TObject);
begin
     ShowCreateNewContractDialog;
end;

procedure TfrmContractsDlg.cxGridCTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmContractsDlg.DeleteContract;
begin
     if ShowAskDialog('Stergere contract',Format('Doriti sa stergeti contractul nr.%d ?',[IBCQueryC.FieldByName('CODE').AsInteger]))<>mrYes then Exit;

     IBCQueryC.UpdateTransaction.StartTransaction;
     try
        IBCQueryC.Delete;
        IBCQueryC.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQueryC.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmContractsDlg.Prepare;
begin
     IBCQueryC.ParamByName('CT').AsInteger:=fCT;
     IBCQueryC.Active:=True;
     SelectionChanged;
end;

procedure TfrmContractsDlg.SelectionChanged;
var fNew,fEdit,fDelete:Boolean;
begin
     fNew:=True;
     fEdit:=False;
     fDelete:=False;
     if (cxGridCTable.DataController.RecNo>0) then
     begin
          fEdit:=True;
          fDelete:=True;
     end;
     bbNew.Enabled:=fNew;
     bbEdit.Enabled:=fEdit;
     bbDelete.Enabled:=fDelete;
end;

procedure TfrmContractsDlg.SetCT(const Value: integer);
begin
     fCT := Value;
end;

procedure TfrmContractsDlg.ShowCreateNewContractDialog;
begin

end;

procedure TfrmContractsDlg.ShowModicyContractDialog;
begin

end;

end.
