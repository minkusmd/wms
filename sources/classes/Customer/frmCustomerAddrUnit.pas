unit frmCustomerAddrUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  cxControls, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, Data.DB,
  cxDBData, DBAccess, IBC, MemDS, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Vcl.StdCtrls, cxButtons, dxBar, cxClasses;

type
  TfrmCustomerAddrDlg = class(TSWNMasteredFormClass)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryCustAddr: TIBCQuery;
    IBCDataSourceCustAddr: TIBCDataSource;
    cxGrid1DBTableView1ADDRID: TcxGridDBColumn;
    cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn;
    cxGrid1DBTableView1ADDRTYPEID: TcxGridDBColumn;
    cxGrid1DBTableView1ADDRTYPE_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1COUNTRYID: TcxGridDBColumn;
    cxGrid1DBTableView1COUNTRY_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1CITYID: TcxGridDBColumn;
    cxGrid1DBTableView1CITY_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1DISTRICTID: TcxGridDBColumn;
    cxGrid1DBTableView1DISTRINCT_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1STREET: TcxGridDBColumn;
    cxGrid1DBTableView1FULL_ADDRESS: TcxGridDBColumn;
    cxGrid1DBTableView1COMMENTS: TcxGridDBColumn;
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
//    procedure ShowCustomerAddrEditDlg(NewRecord: boolean);
    { Private declarations }
  protected
    { Protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmCustomerAddrDlg: TfrmCustomerAddrDlg;

implementation

uses
   frmCustomerAddrEditUnit;

{$R *.dfm}

{ TfrmCustomerAddrDlg }

procedure TfrmCustomerAddrDlg.bbDeleteClick(Sender: TObject);
begin
  IBCQueryCustAddr.Delete;
end;

procedure TfrmCustomerAddrDlg.bbEditClick(Sender: TObject);
begin
//  ShowCustomerAddrEditDlg(False);
end;

procedure TfrmCustomerAddrDlg.bbNewClick(Sender: TObject);
begin
//  ShowCustomerAddrEditDlg(True);
end;

procedure TfrmCustomerAddrDlg.Prepare;
begin
   IBCQueryCustAddr.Transaction := fMasterDataSet.Transaction;
   IBCQueryCustAddr.UpdateTransaction := fMasterDataSet.UpdateTransaction;
   IBCQueryCustAddr.AutoCommit := False;

   IBCQueryCustAddr.ParamByName('CUSTOMERID').AsInteger := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
   IBCQueryCustAddr.Open;
end;

end.
