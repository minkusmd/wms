unit frmCustomerCategoryPricesDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, DBAccess, IBC, MemDS, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxBar, cxClasses, cxContainer,
  cxTextEdit, cxMemo, cxDBEdit;

type
  TfrmCustomerCategoryPricesDlg = class(TSWNMasteredFormClass)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryCust_Price_Categories: TIBCQuery;
    IBCDataSourceCust_Price_Categories: TIBCDataSource;
    cxGrid1DBTableView1_PRICE_CATEGORYID: TcxGridDBColumn;
    cxGrid1DBTableView1_TITLE: TcxGridDBColumn;
    IBCTrLocal: TIBCTransaction;
    cxDBMemo1: TcxDBMemo;
    IBCQueryCustSuppliers: TIBCQuery;
    IBCDataSourceCustSuppliers: TIBCDataSource;
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure IBCQueryCustSuppliersBeforePost(DataSet: TDataSet);
  private
    FCustomerID: Integer;
    { Private declarations }
  protected
    procedure Prepare; override;
    procedure ShowEditor(IsNewRecord: Boolean);
    function IsFormDataPosted: Boolean; override;
  public
    property CustomerID: Integer read FCustomerID write FCustomerID;
    { Public declarations }
  end;

var
  frmCustomerCategoryPricesDlg: TfrmCustomerCategoryPricesDlg;

implementation

uses
    DataModuleAdditions;

{$R *.dfm}

{ TfrmCustomerCategoryPricesDlg }

procedure TfrmCustomerCategoryPricesDlg.bbDeleteClick(Sender: TObject);
begin
  if MessageDlg('Stergeti inregistrarea ?', mtConfirmation, [mbYes, mbNo],0)=mrOk then
  begin
      if not IBCQueryCust_Price_Categories.Active then
          IBCQueryCust_Price_Categories.UpdateTransaction.StartTransaction;

      IBCQueryCust_Price_Categories.Delete;

      if IBCQueryCust_Price_Categories.Active then
          IBCQueryCust_Price_Categories.UpdateTransaction.Commit;
  end;
end;

procedure TfrmCustomerCategoryPricesDlg.bbModifyClick(Sender: TObject);
begin
  ShowEditor(False);
end;

procedure TfrmCustomerCategoryPricesDlg.bbNewClick(Sender: TObject);
begin
    ShowEditor(True);
end;

procedure TfrmCustomerCategoryPricesDlg.IBCQueryCustSuppliersBeforePost(
    DataSet: TDataSet);
begin
  DataSet.FieldByName('CUSTOMERID').AsInteger := fCustomerID;
end;

function TfrmCustomerCategoryPricesDlg.IsFormDataPosted: Boolean;
begin
  result := false;
  try
    if IBCQueryCustSuppliers.State in [dsEdit, dsInsert] then
      IBCQueryCustSuppliers.Post;

    Result := True;
  finally
    result := True;
  end;
end;

procedure TfrmCustomerCategoryPricesDlg.Prepare;
begin
  inherited;
  IBCTrLocal.DefaultConnection := fIBCConnection;
  IBCQueryCust_Price_Categories.ParamByName('customerid').AsInteger := fCustomerID;
  IBCQueryCust_Price_Categories.Open;

  IBCQueryCustSuppliers.Close;
  IBCQueryCustSuppliers.ParamByName('CUSTOMERID').AsInteger := fCustomerID;
  IBCQueryCustSuppliers.Open;
end;

procedure TfrmCustomerCategoryPricesDlg.ShowEditor(IsNewRecord: Boolean);
var
    s: string;
begin
    IBCTrLocal.Active := True;
    if IsNewRecord then
    begin
        IBCQueryCust_Price_Categories.Insert;
        IBCQueryCust_Price_Categories.FieldByName('customerid').AsInteger := FCustomerID;
        s:= 'Generala';
    end
    else
    begin
        IBCQueryCust_Price_Categories.Edit;
        s := IBCQueryCust_Price_Categories.FieldByName('TITLE').AsString;

    end;

    if InputQuery('Categorie pricelist', 'Denumire', S) then
    begin
        IBCQueryCust_Price_Categories.FieldByName('TITLE').AsString := S;
        IBCQueryCust_Price_Categories.Post;
    end
    else
        IBCQueryCust_Price_Categories.Cancel;

end;

end.
