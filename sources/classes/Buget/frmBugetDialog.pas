unit frmBugetDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, SWNBaseUnit, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.Menus,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBAccess, IBC,
  MemDS, Vcl.StdCtrls, cxButtons, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, dxBar, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmBugetDlg = class(TSWNCustomForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    btnOK: TcxButton;
    IBCDataSourceBuget: TIBCDataSource;
    IBCQueryBuget: TIBCQuery;
    IBCTrUpdate: TIBCTransaction;
    cxGrid1DBTableView1BUGETID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    procedure cxGrid1DBTableView1EditKeyDown(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure PostDataSet;
  protected
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmBugetDlg: TfrmBugetDlg;

implementation

uses
  DataModuleAdditions, DataModuleDB, frmCurrencyDlg;

{$R *.dfm}

{ TfrmBugetDlg }

procedure TfrmBugetDlg.cxGrid1DBTableView1EditKeyDown(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    PostDataSet;

end;

function TfrmBugetDlg.IsFormDataPosted: Boolean;
begin
  if IBCQueryBuget.State in [dsEdit, dsInsert] then
  try
    IBCQueryBuget.Post;
  except
    on E: Exception do
      IBCQueryBuget.Cancel;
  end;

  try
    if IBCTrUpdate.Active then
      IBCTrUpdate.Commit;
  except
    on e: Exception do
      IBCTrUpdate.Rollback;
  end;

  Result := True;
end;

procedure TfrmBugetDlg.PostDataSet;
begin
  if IBCQueryBuget.State in [dsEdit, dsInsert] then
  begin
    try
      IBCQueryBuget.Post;
    except
      on e: Exception do
        IBCQueryBuget.Cancel;
    end;

  end;
end;

procedure TfrmBugetDlg.Prepare;
begin
  IBCQueryBuget.Open;

end;

procedure TfrmBugetDlg.SetupSecurityItems;
begin

end;

end.

