unit frmSearchDocByDocNoDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, dxBar, dxBarExtItems, cxClasses, cxGridLevel, cxGridCustomView, cxGrid, ExtCtrls,
  DBAccess, IBC, MemDS, StdCtrls, cxNavigator;

type
  TfrmSearchDocByDocNoDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable_DOCID: TcxGridDBColumn;
    cxGridTable_DOCNO: TcxGridDBColumn;
    cxGridTable_DATA: TcxGridDBColumn;
    IBCQueryDocs: TIBCQuery;
    IBCDataSourceDocs: TIBCDataSource;
    btnSearch: TButton;
    edSeachText: TEdit;
    Label1: TLabel;
    cxGridTable_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridTable_CT_NAME: TcxGridDBColumn;
    cxGridTable_CURRENCY_NAME: TcxGridDBColumn;
    cxGridTable_SUMA: TcxGridDBColumn;
    cxGridTable_RATE: TcxGridDBColumn;
    cxGridTable_RATEUSD: TcxGridDBColumn;
    cxGridTable_FLG_PAID: TcxGridDBColumn;
    cxGridTable_FLG_INVOICE: TcxGridDBColumn;
    procedure btnSearchClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoSearch(const DocNO:integer);
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils;

{$R *.dfm}

{ TfrmSearchDocByDocNoDlg }

procedure TfrmSearchDocByDocNoDlg.btnSearchClick(Sender: TObject);
var N:integer;
begin
     N:=StrToIntDef(edSeachText.Text,-1);
     if N>0 then DoSearch(N)
     else ShowErrorDialog('Eroare','');
end;

procedure TfrmSearchDocByDocNoDlg.DoSearch(const DocNO: integer);
begin
     IBCQueryDocs.Close;
     IBCQueryDocs.ParamByName('docno').AsInteger:=DocNo;
     IBCQueryDocs.Active:=True;
end;

procedure TfrmSearchDocByDocNoDlg.Prepare;
begin
     inherited;

end;

end.
