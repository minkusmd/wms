unit frmFirmsLocksLogDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DB, cxGridLevel,
  cxGridDBTableView, cxGrid, DialogTitle, StdCtrls, DBAccess, IBC,
  dxBar,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxCheckBox, Vcl.Menus, cxClasses,
  MemDS, cxGridCustomTableView, cxGridTableView, cxGridCustomView;

type
  TfrmFirmsLocksLogDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxGridLogTable: TcxGridDBTableView;
    cxGridLogLevel: TcxGridLevel;
    cxGridLog: TcxGrid;
    IBCQueryLog: TIBCQuery;
    IBCDataSourceLog: TIBCDataSource;
    cxGridLogTable_DATA: TcxGridDBColumn;
    cxGridLogTable_DT_NAME: TcxGridDBColumn;
    cxGridLogTable_USER_NAME: TcxGridDBColumn;
    cxGridLogTable_LOCK_ENABLED: TcxGridDBColumn;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbClearLog: TdxBarButton;
    btnCancel: TcxButton;
    procedure bbClearLogClick(Sender: TObject);
  private
    { Private declarations }
    procedure ClearLogDB;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleDB, SWNUtils, SWNDBErrors;

{$R *.dfm}

{ TfrmFirmsLocksLogDlg }

procedure TfrmFirmsLocksLogDlg.bbClearLogClick(Sender: TObject);
begin
     if ShowAskDialog('Очистка журнала','Вы хотите удалить все записи из журнала?')=mrYes then
     begin
          ClearLogDB;
          IBCQueryLog.Refresh;
     end;
end;

procedure TfrmFirmsLocksLogDlg.ClearLogDB;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
           Query.SQL.Text:='DELETE FROM TSS_DBLOCKS_LOG';
           Query.ExecSQL;
           Query.Transaction.Commit;
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

procedure TfrmFirmsLocksLogDlg.Prepare;
begin
     IBCQueryLog.Active:=True;
     bbClearLog.Enabled:=IBCQueryLog.RecordCount>0;
end;

end.
