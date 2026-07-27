unit uSystemPeriodDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, Vcl.Menus, DBAccess, IBC, MemDS, Vcl.StdCtrls, cxButtons,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxBar, cxCheckBox, cxCalendar, cxMemo, dxLayoutContainer,
  cxGridInplaceEditForm, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmSystemPeriodDlg = class(TSWNCustomForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    btnClose: TcxButton;
    IBCQuerySystemPeriods: TIBCQuery;
    IBCDataSourceSystemPeriods: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGrid1DBTableView1ID: TcxGridDBColumn;
    cxGrid1DBTableView1DATA1: TcxGridDBColumn;
    cxGrid1DBTableView1DATA2: TcxGridDBColumn;
    cxGrid1DBTableView1DESCRIPTION: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Prepare; override;
//    procedure SaveStates; virtual;
//    procedure LoadStates; virtual;
//    function SecurityFlagEnabled(const SecurityFlag: integer): Boolean;
//    function UserHasUserGroup(const UserGroupID: integer): Boolean;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
  end;

var
  frmSystemPeriodDlg: TfrmSystemPeriodDlg;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNMessageDialog, SWNDBErrors, frmPeriodAccessGroupsDialog,
  SWNConst, SWNUtils;

{$R *.dfm}

{ TfrmSystemPeriodDlg }

procedure TfrmSystemPeriodDlg.cxGrid1DBTableView1DblClick(Sender: TObject);
begin
  dxBarButton3Click(Sender);
end;

procedure TfrmSystemPeriodDlg.dxBarButton1Click(Sender: TObject);
var
  dialog: TfrmPeriodsSecurityDlg;
begin
  dialog := TfrmPeriodsSecurityDlg.Create(Self, IBCQuerySystemPeriods, IBCDataSourceSystemPeriods);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSystemPeriodDlg.dxBarButton2Click(Sender: TObject);
begin
  if ShowAskDialog('Perioada de gestiune', 'Sterge inregistrare?') = mrYes then
  begin
    IBCQuerySystemPeriods.Delete;
  end;
end;

procedure TfrmSystemPeriodDlg.dxBarButton3Click(Sender: TObject);
var
  dialog: TfrmPeriodsSecurityDlg;
begin
  dialog := TfrmPeriodsSecurityDlg.Create(Self, IBCQuerySystemPeriods, IBCDataSourceSystemPeriods);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSystemPeriodDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IBCQuerySystemPeriods.Close;
end;

procedure TfrmSystemPeriodDlg.Prepare;
begin
  inherited;
  IBCQuerySystemPeriods.Open;
end;

procedure TfrmSystemPeriodDlg.SetupSecurityItems;
begin
  inherited;

end;

end.

