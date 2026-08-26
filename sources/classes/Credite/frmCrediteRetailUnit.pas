unit frmCrediteRetailUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, Vcl.StdCtrls, dxBar, cxClasses,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxGridCustomView, cxGrid, Vcl.ExtCtrls, DialogTitle, SWNBaseUnit, DBAccess,
  IBC, MemDS;

type
  TfrmCrediteRetailDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    dxBarManager1: TdxBarManager;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1_CID: TcxGridDBColumn;
    cxGrid1DBTableView1_TITLE_RO: TcxGridDBColumn;
    cxGrid1DBTableView1_TITLE_RU: TcxGridDBColumn;
    cxGrid1DBTableView1_PERCENT_COST: TcxGridDBColumn;
    dxBarManager1Bar1: TdxBar;
    bbAdd: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    bbProductsList: TdxBarButton;
    btnCancel: TButton;
    IBCQueryCrediteRetail: TIBCQuery;
    IBCDataSourceCrediteRetail: TIBCDataSource;
    btnOK: TButton;
    IBCTrUpdate: TIBCTransaction;
    procedure bbAddClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    FCID: Integer;
    procedure SetCID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CID: Integer read FCID write SetCID;

  end;

var
  frmCrediteRetailDlg: TfrmCrediteRetailDlg;

implementation

uses
  DataModuleAdditions, frmCrediteRetailEditorUnit, DataModuleDB, Vcl.Dialogs;

{$R *.dfm}

{ TfrmCrediteRetailDlg }

procedure TfrmCrediteRetailDlg.bbAddClick(Sender: TObject);
var
  d: TfrmCrediteRetailEditorDlg;
begin
  d := TfrmCrediteRetailEditorDlg.Create(Self, IBCQueryCrediteRetail, IBCDataSourceCrediteRetail);
  try
    d.IsNewRecord := True;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmCrediteRetailDlg.bbDeleteClick(Sender: TObject);
begin
  if (MessageDlg('Stergem inregistrarea ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    IBCQueryCrediteRetail.Delete;
end;

procedure TfrmCrediteRetailDlg.bbEditClick(Sender: TObject);
var
  d: TfrmCrediteRetailEditorDlg;
begin
  d := TfrmCrediteRetailEditorDlg.Create(Self, IBCQueryCrediteRetail, IBCDataSourceCrediteRetail);
  try
    d.IsNewRecord := False;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

function TfrmCrediteRetailDlg.IsFormDataPosted: boolean;
begin
  result := True;
  CID := IBCQueryCrediteRetail.FieldByName('cid').AsInteger;
end;

procedure TfrmCrediteRetailDlg.Prepare;
begin
  inherited;
  IBCQueryCrediteRetail.Open;
end;

procedure TfrmCrediteRetailDlg.SetCID(const Value: Integer);
begin
  FCID := Value;
end;

procedure TfrmCrediteRetailDlg.WhenCancelForm;
begin
  inherited;
  CID := 0;
end;

end.

