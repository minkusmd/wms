unit frmActiveUsersDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, SWNBaseUnit,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, Vcl.StdCtrls, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DialogTitle,
  Vcl.ExtCtrls, DBAccess, IBC, MemDS, cxImage, cxImageComboBox, cxCurrencyEdit, dxBar, Vcl.ComCtrls,
  cxPCdxBarPopupMenu, cxPC, cxNavigator, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmActiveUsersDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnClose: TButton;
    pnClient: TPanel;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    IBCQueryProcs: TIBCQuery;
    IBCDataSourceProcs: TIBCDataSource;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    bbRefresh: TdxBarButton;
    IBCTrSelect: TIBCTransaction;
    cxPageControl1: TcxPageControl;
    tbsUsers: TcxTabSheet;
    tbsProcesses: TcxTabSheet;
    cxGridUsers: TcxGrid;
    cxGridUsersTable: TcxGridDBTableView;
    cxGridUsers_USERID: TcxGridDBColumn;
    cxGridUsers_ICON: TcxGridDBColumn;
    cxGridUsers_FULL_NAME: TcxGridDBColumn;
    cxGridUsers_FUNCTIA_DETINUTA: TcxGridDBColumn;
    cxGridUsers_TELEFON: TcxGridDBColumn;
    cxGridUsers_DEFAULT_DT: TcxGridDBColumn;
    cxGridUsers_DISPLAYNAME: TcxGridDBColumn;
    cxGridUsersLevel: TcxGridLevel;
    cxGridProc: TcxGrid;
    cxGridProcTable: TcxGridDBTableView;
    cxGridProcTableColumn1: TcxGridDBColumn;
    cxGridProc_REMOTE_ADDRESS: TcxGridDBColumn;
    cxGridProc_REMOTE_PROCESS: TcxGridDBColumn;
    cxGridProc_MEMORY_USED: TcxGridDBColumn;
    cxGridProcLevel: TcxGridLevel;
    procedure cxGridUsers_DEFAULT_DTGetDataText(Sender: TcxCustomGridTableItem; ARecordIndex: Integer;
      var AText: string);
    procedure bbRefreshClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataModuleDB, DataModuleAdditions, SWNSecurity;

{ TForm2 }

procedure TfrmActiveUsersDlg.bbRefreshClick(Sender: TObject);
begin
     IBCQueryUsers.Close;
     IBCQueryProcs.Close;
     IBCTrSelect.Active:=False;

     IBCQueryUsers.Active:=True;
     IBCQueryProcs.Active:=True;
end;

procedure TfrmActiveUsersDlg.cxGridUsers_DEFAULT_DTGetDataText(Sender: TcxCustomGridTableItem;
  ARecordIndex: Integer; var AText: string);
begin
     if Not VarIsNull(cxGridUsersTable.DataController.Values[ARecordIndex,cxGridUsers_DISPLAYNAME.Index]) then AText:=cxGridUsersTable.DataController.Values[ARecordIndex,cxGridUsers_DISPLAYNAME.Index];
end;

procedure TfrmActiveUsersDlg.Prepare;
begin
     // nu aratam SuperUser
     if Not SWNSecurityManager.LoggedUser.IsSuperAdminUser then IBCQueryUsers.FilterSQL:='TS_USERS.USERID<>1';

     IBCQueryUsers.Active:=True;
     cxGridUsersTable.DataController.Groups.FullCollapse;
     IBCQueryProcs.Active:=True;
end;

end.
