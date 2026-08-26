unit unitUserAccessLogSearchDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, Vcl.Menus, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxLabel, Vcl.StdCtrls, cxButtons, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, DBAccess, IBC, MemDS;

type
  TfrmUserAccessLogSearchDialog = class(TSWNCustomForm)
    Panel1: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    btnClose: TcxButton;
    cxLabel1: TcxLabel;
    cxDateEdit1: TcxDateEdit;
    cxDateEdit2: TcxDateEdit;
    cxLabel2: TcxLabel;
    edIP: TcxTextEdit;
    edSearch: TcxTextEdit;
    cxLabel3: TcxLabel;
    cxButton2: TcxButton;
    IBCQuerySearch: TIBCQuery;
    IBCDataSourceSearch: TIBCDataSource;
    cxGrid1DBTableView1UID: TcxGridDBColumn;
    cxGrid1DBTableView1DATA: TcxGridDBColumn;
    cxGrid1DBTableView1IP: TcxGridDBColumn;
    cxGrid1DBTableView1USERAGENT: TcxGridDBColumn;
    cxGrid1DBTableView1URL: TcxGridDBColumn;
    cxGrid1DBTableView1SESSIONID: TcxGridDBColumn;
    cxGrid1DBTableView1SHOPCARTID: TcxGridDBColumn;
    cxGrid1DBTableView1IS_BOT: TcxGridDBColumn;
    cxGrid1DBTableView1CUSTOMER: TcxGridDBColumn;
    procedure cxButton2Click(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoSearch;
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmUserAccessLogSearchDialog: TfrmUserAccessLogSearchDialog;

implementation

{$R *.dfm}

{ TfrmUserAccessLogSearchDialog }

procedure TfrmUserAccessLogSearchDialog.cxButton2Click(Sender: TObject);
begin
  DoSearch;
end;

procedure TfrmUserAccessLogSearchDialog.DoSearch;
begin
  IBCQuerySearch.Close;
  IBCQuerySearch.DeleteWhere;

  if (cxDateEdit1.Date >= StrToDate('01.01.2020')) then
    IBCQuerySearch.AddWhere('CAST(DATA AS DATE) >= '+QuotedStr(DateToStr(cxDateEdit1.Date)));
  if (cxDateEdit2.Date >= StrToDate('01.01.2020')) then
    IBCQuerySearch.AddWhere('CAST(DATA AS DATE) <= '+QuotedStr(DateToStr(cxDateEdit2.Date)));
  if (edIP.Text<>'') then
    IBCQuerySearch.AddWhere('IP = '+QuotedStr(edIP.Text));
  if (edSearch.Text <> '') then
    IBCQuerySearch.AddWhere('URL containing '+QuotedStr(edSearch.Text));

  IBCQuerySearch.Open;
end;

procedure TfrmUserAccessLogSearchDialog.Prepare;
begin
  cxDateEdit1.Date := Date;
  cxDateEdit2.Date := Date;
end;

end.
