unit frmUserActivityMonitorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, Vcl.ComCtrls,
  cxClasses, dxBar, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS,
  cxImageComboBox, SWNBaseUnit, cxTL, cxTLdxBarBuiltInMenu, cxInplaceContainer,
  cxTLData, cxDBTL, cxCalendar, dxBarExtItems, cxBarEditItem, cxImage, cxVGrid,
  cxDBVGrid, cxContainer, cxDBEdit, Vcl.ExtCtrls, cxCheckBox, cxNavigator,
  cxLabel, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmUserActivityMonitorDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    dxBarManager1: TdxBarManager;
    IBCQueryTree: TIBCQuery;
    IBCDataSourceTree: TIBCDataSource;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    dxBarDateCombo1: TdxBarDateCombo;
    bbClearAll: TdxBarButton;
    cxGridTreeTable: TcxGridDBTableView;
    cxGridTreeLevel1: TcxGridLevel;
    cxGridTree: TcxGrid;
    cxGridTree_USER_NAME: TcxGridDBColumn;
    cxGridTree_IMG: TcxGridDBColumn;
    bdeDate: TdxBarDateCombo;
    IBCQueryTime: TIBCQuery;
    IBCDataSourceTime: TIBCDataSource;
    cxGridTimesTable: TcxGridDBTableView;
    cxGridTimesLevel1: TcxGridLevel;
    cxGridTimes: TcxGrid;
    dxBarButton1: TdxBarButton;
    cxGridTimes_CREATED: TcxGridDBColumn;
    IBCQueryImage: TIBCQuery;
    IBCDataSourceImage: TIBCDataSource;
    pnImage: TPanel;
    cxDBImage1: TcxDBImage;
    IBCConnection2: TIBCConnection;
    IBCTrSelect2: TIBCTransaction;
    IBCTrUpdate2: TIBCTransaction;
    cxGridTree_COMPUTER_NAME: TcxGridDBColumn;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bntView: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBtn1: TdxBarButton;
    cxgrdbclmnGridTimes_FLG_IMPORTANT: TcxGridDBColumn;
    dxBtn2: TdxBarButton;
    procedure bdeDateChange(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure cxDBImage1DblClick(Sender: TObject);
    procedure bbClearAllClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bntViewClick(Sender: TObject);
    procedure cxGridTimes_CREATEDGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure dxBtn1Click(Sender: TObject);
    procedure dxBtn2Click(Sender: TObject);
  private
    { Private declarations }
    procedure ShowBigImage;
    procedure DeleteAllRecords;
    procedure GotoNextImage(Sender: TObject);
    procedure GotoPrevImage(Sender: TObject);
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
  public

    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, DataModuleDB, SWNSecurityFlags, SWNUtils, SWNDBErrors,
  frmUserActivityBigScreenDialog;

procedure TfrmUserActivityMonitorDlg.bbClearAllClick(Sender: TObject);
begin
  // DeleteAllRecords;
end;

procedure TfrmUserActivityMonitorDlg.cxDBImage1DblClick(Sender: TObject);
begin
  ShowBigImage;
  cxGridTimes.SetFocus;
end;

procedure TfrmUserActivityMonitorDlg.cxGridTimes_CREATEDGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNullDate(ARecord.Values[cxGridTimes_CREATED.Index]) then
    AText := FormatDateTime('hh:nn', ARecord.Values[cxGridTimes_CREATED.Index]);
end;

procedure TfrmUserActivityMonitorDlg.DeleteAllRecords;
var
  Query: TIBCQuery;
begin
  if ShowAskDialog('Удаление все записей', 'Вы точно хотите удалить все записи?') = mrYes then
  begin
    Query := TIBCQuery.Create(Self);
    try
      Query.Connection := IBCConnection2;
      Query.Transaction := IBCTrUpdate2;
      Query.SQL.Text := 'DELETE FROM TDB_SS where ip=:ip and cast(CAPTURETIME as date)=:data';
      Query.ParamByName('IP').AsString := IBCQueryTree.FieldByName('IP').AsString;
      Query.ParamByName('DATA').AsDateTime := bdeDate.Date;
      Query.Transaction.StartTransaction;
      try
        // Query.Execute;
        Query.Transaction.Commit;
        IBCQueryTree.Refresh;
        IBCQueryTime.Refresh;
      except
        on E: Exception do
        begin
          Query.Transaction.Rollback;
          if not ProcessSWNError(E) then
            raise;
        end;
      end;
    finally
      Query.Free;
    end;
  end;
end;

procedure TfrmUserActivityMonitorDlg.dxBarButton1Click(Sender: TObject);
begin
  IBCQueryTree.Refresh;
  IBCQueryTime.Refresh;
end;

procedure TfrmUserActivityMonitorDlg.dxBtn1Click(Sender: TObject);
begin
  IBCQueryTime.Edit;
  IBCQueryTime.FieldByName('FLG_IMPORTANT').AsInteger := 1;
  IBCQueryTime.Post;
end;

procedure TfrmUserActivityMonitorDlg.dxBtn2Click(Sender: TObject);
begin
  IBCQueryTime.Edit;
  IBCQueryTime.FieldByName('FLG_IMPORTANT').AsInteger := 0;
  IBCQueryTime.Post;
end;

procedure TfrmUserActivityMonitorDlg.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Escape then
  begin
    ModalResult := mrCancel;
  end;
end;

procedure TfrmUserActivityMonitorDlg.GotoNextImage(Sender: TObject);
begin
  if not IBCQueryTime.Eof then
    IBCQueryTime.Next;
end;

procedure TfrmUserActivityMonitorDlg.GotoPrevImage(Sender: TObject);
begin
  if not IBCQueryTime.Bof then
    IBCQueryTime.Prior;
end;

procedure TfrmUserActivityMonitorDlg.bdeDateChange(Sender: TObject);
begin
  IBCQueryTree.Close;
  IBCQueryTime.Close;
  IBCQueryTree.ParamByName('DATA').AsDate := bdeDate.Date;
  IBCQueryTime.ParamByName('DATA').AsDate := bdeDate.Date;
  IBCQueryTree.Active := True;
  // cxGridTreeTable.DataController.Groups.FullExpand;
  IBCQueryTime.Active := True;
end;

procedure TfrmUserActivityMonitorDlg.bntViewClick(Sender: TObject);
begin
  cxDBImage1DblClick(Sender);
end;

procedure TfrmUserActivityMonitorDlg.Prepare;
begin
  bdeDate.Date := NOW;
  if (dmDB.CurrentUserID = 1) then
  begin
    try
      IBCConnection2.Connected := False;
      IBCConnection2.Server := dmDB.IBCConnection.Server;
      IBCConnection2.Connect;

      IBCQueryTree.SQL.Text := 'SELECT * FROM (SELECT DISTINCT TDB_USERS.ID AS USERID, ' +
                               'TDB_USERS.USER_NAME, ' +
                               'TDB_COMPUTERS.ID AS COMPUTERID, ' +
                               'TDB_COMPUTERS.COMPUTER_NAME ' +
                               'FROM TDB_SS ' +
                               'INNER JOIN TDB_USERS ON TDB_USERS.ID = TDB_SS.USER_ID ' +   //AND TDB_SS.USER_ID NOT IN (1,2,4)
                               'INNER JOIN TDB_COMPUTERS ON TDB_COMPUTERS.ID = TDB_SS.COMPUTER_ID WHERE CAST(TDB_SS.CREATED AS DATE) = :DATA ' +
                               'ORDER BY TDB_SS.ID ) ORDER BY 3';

      IBCQueryTree.ParamByName('DATA').AsDate := bdeDate.Date;
      IBCQueryTime.ParamByName('DATA').AsDate := bdeDate.Date;
      IBCQueryTree.Active := True;
      IBCQueryTime.Active := True;
      IBCQueryImage.Active := True;
    except
      raise;
    end;
  end
  else
  begin
    IBCConnection2.Connected := False;
    try
      // IBCConnection2.Server:=dmDB.IBCConnection.Server;
      // IBCConnection2.Connect;
      // IBCQueryTree.SQL.Text := 'SELECT DISTINCT '+
      // 'TDB_USERS.ID AS USERID, '+
      // 'TDB_COMPUTERS.ID AS COMPUTERID, '+
      // 'TDB_USERS.USER_NAME, '+
      // 'TDB_COMPUTERS.COMPUTER_NAME  '+
      // 'FROM TDB_SS  '+
      // 'INNER JOIN TDB_USERS ON TDB_USERS.ID = TDB_SS.USER_ID  '+
      // 'INNER JOIN TDB_COMPUTERS ON TDB_COMPUTERS.ID = TDB_SS.COMPUTER_ID  '+
      // 'WHERE CAST(TDB_SS.CREATED AS DATE) = :DATA and USERID NOT IN (17, 27, 2)  '+
      // 'ORDER BY 3,4';
      //
      // IBCQueryTree.ParamByName('DATA').AsDate:=bdeDate.Date;
      // IBCQueryTime.ParamByName('DATA').AsDate:=bdeDate.Date;
      // IBCQueryTree.Active:=True;
      // //cxGridTreeTable.DataController.Groups.FullExpand;
      // IBCQueryTime.Active:=True;
      // IBCQueryImage.Active:=True;
    except
      raise;
    end;
  end;
end;

procedure TfrmUserActivityMonitorDlg.SetupSecurityItems;
begin
  // tbsMonitor.TabVisible:=SecurityFlagEnabled(cSecurityFlag_Инструменты_МА_Смотреть);
end;

procedure TfrmUserActivityMonitorDlg.ShowBigImage;
var
  dialog: TfrmUserActivityBigScreenDlg;
begin
  dialog := TfrmUserActivityBigScreenDlg.Create(Self, IBCQueryImage, IBCDataSourceImage);
  try
    dialog.OnNextImage := GotoNextImage;
    dialog.OnPrevImage := GotoPrevImage;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.

