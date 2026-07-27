unit frmUMDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, DBAccess, IBC, MemDS, dxBar, Vcl.StdCtrls,
  Vcl.ExtCtrls, DialogTitle, SWNBaseUnit, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmUMDialog = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    btnCancel: TButton;
    dxBarManager: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarSubItem1: TdxBarSubItem;
    bbNewRecord: TdxBarButton;
    bbCurrencyHistory: TdxBarButton;
    IBCQueryUM: TIBCQuery;
    IBCDataSourceUM: TIBCDataSource;
    cxGridUM: TcxGrid;
    cxGridUMTable: TcxGridDBTableView;
    cxGridUMLevel: TcxGridLevel;
    cxGridUMTableUMID: TcxGridDBColumn;
    cxGridUMTableTITLE: TcxGridDBColumn;
    cxGridUMTableK_UM: TcxGridDBColumn;
    cxGridUMTableTITLE2: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    procedure bbNewRecordClick(Sender: TObject);
    procedure bbCurrencyHistoryClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure ShowAddEditUMDlg(fCreateNewRecord: boolean);
  end;

implementation

{$R *.dfm}

uses
  frmUMEditorDialog;

{ TfrmUMDialog }

procedure TfrmUMDialog.bbCurrencyHistoryClick(Sender: TObject);
begin
  ShowAddEditUMDlg(false);
end;

procedure TfrmUMDialog.bbNewRecordClick(Sender: TObject);
begin
  ShowAddEditUMDlg(true);
end;

procedure TfrmUMDialog.Prepare;
begin
  SetupSecurityItems;

  IBCQueryUM.Active := true;
  cxGridUMTableTITLE.Focused := true;

end;

procedure TfrmUMDialog.SetupSecurityItems;
begin

end;

procedure TfrmUMDialog.ShowAddEditUMDlg(fCreateNewRecord: boolean);
var
  dialog: TfrmUMEditorDlg;
begin
  dialog := TfrmUMEditorDlg.Create(Self, IBCQueryUM, IBCDataSourceUM);
  try
    dialog.FCreateNewRecord := fCreateNewRecord;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.

