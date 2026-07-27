unit frmExchangeLogDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar, ExtCtrls, StdCtrls, dxBarExtItems,
  DBAccess, IBC, MemDS, cxDBLookupComboBox, cxBarEditItem, dxBarExtDBItems, cxCheckBox, cxGridBandedTableView,
  cxGridDBBandedTableView, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Vcl.Menus, cxButtons;

type
  TfrmExchangeLogDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dcStartDate: TdxBarDateCombo;
    dcEndDate: TdxBarDateCombo;
    bbRefresh: TdxBarButton;
    IBCQuery: TIBCQuery;
    IBCDataSource: TIBCDataSource;
    dxBarLookupCombo1: TdxBarLookupCombo;
    lcbUserID: TcxBarEditItem;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    cxGridTable: TcxGridDBBandedTableView;
    cxGridTable_ID: TcxGridDBBandedColumn;
    cxGridTable_FLG_CLOSE_DOC: TcxGridDBBandedColumn;
    cxGridTable_FLG_DELETE: TcxGridDBBandedColumn;
    cxGridTable_FLG_DT_CONFIRMED: TcxGridDBBandedColumn;
    cxGridTable_DT_NAME: TcxGridDBBandedColumn;
    cxGridTable_USER_DT_NAME: TcxGridDBBandedColumn;
    cxGridTable_DATA_DT: TcxGridDBBandedColumn;
    cxGridTable_SUMA_DT: TcxGridDBBandedColumn;
    cxGridTable_RATE_DT: TcxGridDBBandedColumn;
    cxGridTable_CURRENCY_DT_NAME: TcxGridDBBandedColumn;
    cxGridTable_CURRENCY_CT_NAME: TcxGridDBBandedColumn;
    cxGridTable_SUMA_CT: TcxGridDBBandedColumn;
    cxGridTable_RATE_CT: TcxGridDBBandedColumn;
    dxBarButton1: TdxBarButton;
    btnCancel: TcxButton;
    procedure bbRefreshClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshData;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
  end;

implementation

uses DataModuleDB, DataModuleAdditions, DateUtils, frmEditDateExchange;

{$R *.dfm}
{ TfrmExchangeLogDlg }

procedure TfrmExchangeLogDlg.bbRefreshClick(Sender: TObject);
begin
  RefreshData;
end;

procedure TfrmExchangeLogDlg.dxBarButton1Click(Sender: TObject);
var
  dialog: TfrmEditDateExchangeDlg;
  q :TIBCQuery;
begin
  dialog := TfrmEditDateExchangeDlg.Create(Application);
  q := TIBCQuery.Create(self);
  try
    dialog.ExchangeData := IBCQuery.FieldByName('DATA_DT').AsDateTime;
    if (dialog.ShowModal = mrOk) then
    begin
      q.Transaction := dmdb.IBCTrDefaultUpdate;

      q.sql.Text := 'update tdb_cash_jurnal set data_dt=cast(:data as date), data_ct=cast(:data as date) where id=' +
         ':id';;
      q.ParamByName('DATA').AsDateTime := dialog.ExchangeData;
      q.ParamByName('ID').AsInteger := IBCQuery.FieldByName('ID').AsInteger;
      q.Execute;
      if q.Transaction.Active then
          q.Transaction.Commit;

      IBCQuery.Refresh;

    end;
  finally
    dialog.Free;
    q.Free;
  end;

end;

procedure TfrmExchangeLogDlg.Prepare;
begin
  IBCQueryUsers.Active := True;
  lcbUserID.EditValue := dmdb.CurrentUserID;
end;

procedure TfrmExchangeLogDlg.RefreshData;
begin
  IBCQuery.Close;
  IBCQuery.ParamByName('USERID').AsInteger := lcbUserID.EditValue;
  IBCQuery.ParamByName('DATA1').AsDate := DateOf(dcStartDate.Date);
  IBCQuery.ParamByName('DATA2').AsDate := DateOf(dcEndDate.Date);
  IBCQuery.Active := True;
end;

end.
