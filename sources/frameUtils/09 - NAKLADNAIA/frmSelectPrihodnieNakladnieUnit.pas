unit frmSelectPrihodnieNakladnieUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, MemDS, DBAccess, IBC, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, RzPanel, RzDlgBtn, Vcl.ExtCtrls, dxUIAClasses;

type
  TfrmSelectPrihodnieNakladnieDlg = class(TSWNCustomForm)
    pnlMain: TPanel;
    RzDialogButtons1: TRzDialogButtons;
    Panel1: TPanel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    Panel2: TPanel;
    qDocs: TIBCQuery;
  private
    { Private declarations }
    protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure SetupSecurityItems; override;

  public
    { Public declarations }
  end;

var
  frmSelectPrihodnieNakladnieDlg: TfrmSelectPrihodnieNakladnieDlg;

implementation

{$R *.dfm}

{ TfrmSelectPrihodnieNakladnieDlg }

function TfrmSelectPrihodnieNakladnieDlg.IsFormDataPosted: Boolean;
begin

end;

procedure TfrmSelectPrihodnieNakladnieDlg.Prepare;
begin
  inherited;

end;

procedure TfrmSelectPrihodnieNakladnieDlg.SetupSecurityItems;
begin
  inherited;

end;

end.
