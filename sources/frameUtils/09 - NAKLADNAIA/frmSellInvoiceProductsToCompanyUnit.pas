unit frmSellInvoiceProductsToCompanyUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzPanel, RzDlgBtn, Vcl.ExtCtrls, cxGraphics, dxUIAClasses, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxLabel, cxTextEdit, cxMaskEdit, cxCalc, cxCheckBox, Data.DB, DBAccess, IBC, MemDS, SWNBaseUnit;

type
  TfrmSellInvoiceProductsToCompanyDlg = class(TSWNCustomForm)
    Panel1: TPanel;
    RzDialogButtons1: TRzDialogButtons;
    cbVinzare: TcxCheckBox;
    ceMargin: TcxCalcEdit;
    cxLabel1: TcxLabel;
    cxLookupComboBox1: TcxLookupComboBox;
    cbFacturaVinzare: TcxCheckBox;
    cbIntrare: TcxCheckBox;
    cbFacturaIntrare: TcxCheckBox;
    cxLabel2: TcxLabel;
    dsCompanies: TIBCDataSource;
    qCompanies: TIBCQuery;
  private
    FCumparatorID: Integer;
    FFurnizorID: Integer;
    procedure SetCumparatorID(const Value: Integer);
    procedure SetFurnizorID(const Value: Integer);
  protected
    function CreazaFacturaIntrare(Query: TIBCQuery; DocID: Integer): Integer;
    function CreazaIntrare(Query: TIBCQuery; DocID: Integer): Integer;
    function CreazaFacturaVinzare(Query: TIBCQuery; DocID: integer): Integer;
    function CreazaVinzare(Query: TIBCQuery; DocID: integer): Integer;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    property CumparatorID: Integer read FCumparatorID write SetCumparatorID;
    property FurnizorID: Integer read FFurnizorID write SetFurnizorID;
    { Public declarations }
  end;

var
  frmSellInvoiceProductsToCompanyDlg: TfrmSellInvoiceProductsToCompanyDlg;

implementation

uses
  DataModuleDB;

{$R *.dfm}

function TfrmSellInvoiceProductsToCompanyDlg.CreazaFacturaIntrare(Query:
    TIBCQuery; DocID: Integer): Integer;
begin
    Query.SQL.Text := 'execute procedure create_factura_intrare(:docid, :ct)';
    Query.ParamByName('docid').AsInteger := DOCID;
    Query.ParamByName('ct').AsInteger := qCompanies.FieldByName('CUSTOMERID').AsInteger;
    Query.ExecSQL;
end;

function TfrmSellInvoiceProductsToCompanyDlg.CreazaIntrare(Query: TIBCQuery; DocID: Integer):
    Integer;
begin
    Query.SQL.Text := 'execute procedure create_intrare(:docid, :ct)';
    Query.ParamByName('docid').AsInteger := DOCID;
    Query.ParamByName('ct').AsInteger := qCompanies.FieldByName('CUSTOMERID').AsInteger;
    Query.ExecSQL;
end;

function TfrmSellInvoiceProductsToCompanyDlg.CreazaFacturaVinzare(Query: TIBCQuery; DocID: integer): Integer;
begin
    Query.SQL.Text := 'select new_docid from create_factura_vinzare(:docid, :ct)';
    Query.ParamByName('docid').AsInteger := DocID;
    Query.ParamByName('ct').AsInteger := qCompanies.FieldByName('CUSTOMERID').AsInteger;
    Query.Open;
    Result := Query.FieldByName('NEW_DOCID').AsInteger;
end;

function TfrmSellInvoiceProductsToCompanyDlg.CreazaVinzare(Query: TIBCQuery; DocID: integer): Integer;
begin
    Query.SQL.Text := 'select new_docid from create_vinzare(:docid, :ct, :Margin)';
    Query.ParamByName('docid').AsInteger := DocID;
    Query.ParamByName('ct').AsInteger := qCompanies.FieldByName('CUSTOMERID').AsInteger;
    Query.ParamByName('Margin').AsFloat := ceMargin.Value;
    Query.Open;
    Result := Query.FieldByName('NEW_DOCID').AsInteger;
end;

function TfrmSellInvoiceProductsToCompanyDlg.IsFormDataPosted: Boolean;
var
  LFacturaIntrareDocID: Integer;
  LFacturaVinzareDocID: integer;
  LIntrareDocID: Integer;
  LVinzareDocID: Integer;
begin
  Result:=false;
    var q:=TIBCQuery.Create(nil);
    try
      q.AutoCommit := false;
      q.Transaction := dmdb.IBCTrDefaultUpdate;
      if not q.Transaction.Active then
        q.Transaction.StartTransaction;

      LVinzareDocID := -1;
      LFacturaVinzareDocID := -1;
      if cbVinzare.Checked then
        LVinzareDocID := CreazaVinzare(q, dmdb.ibcquerydocs.fieldbyname('docid').asinteger);

      if cbFacturaVinzare.Checked then
        if LVinzareDocID>0 then
          LFacturaVinzareDocID := CreazaFacturaVinzare(q, LVinzareDocID)
        else
          MessageDlg('Nu este format document de vinzare!', mtError, [mbOK],0);

      if cbIntrare.Checked then
        if LVinzareDocID>0 then
          LIntrareDocID := CreazaIntrare(q, LVinzareDocID)
        else
          MessageDlg('Nu este format document de intrare!', mtError, [mbOK],0);

      if cbFacturaIntrare.Checked then
        if LFacturaVinzareDocID>0 then
          LFacturaIntrareDocID:=CreazaFacturaIntrare(q, LFacturaVinzareDocID)
        else
          MessageDlg('Nu este format document de Factura intrare!', mtError, [mbOK],0);


        q.SQL.Text := 'execute procedure set_document_flg_close(:docid, :flg_value)';
        q.Prepare;

        q.ParamByName('flg_value').AsInteger := 1;
        q.ParamByName('DOCID').AsInteger := LVinzareDocID;
        q.ExecSQL;

        q.ParamByName('DOCID').AsInteger := LFacturaVinzareDocID;
        q.ParamByName('flg_value').AsInteger := 1;
        q.ExecSQL;

        q.ParamByName('DOCID').AsInteger := LIntrareDocID;
        q.ParamByName('flg_value').AsInteger := 1;
        q.ExecSQL;

        q.ParamByName('DOCID').AsInteger := LFacturaIntrareDocID;
        q.ParamByName('flg_value').AsInteger := 1;
        q.ExecSQL;


       if q.Transaction.Active then
         q.Transaction.Commit;
       Result := True;
    finally
      q.Free;
    end;
end;

procedure TfrmSellInvoiceProductsToCompanyDlg.Prepare;
begin
  qCompanies.Open;
end;

procedure TfrmSellInvoiceProductsToCompanyDlg.SetCumparatorID(const Value:
    Integer);
begin
  FCumparatorID := Value;
end;

procedure TfrmSellInvoiceProductsToCompanyDlg.SetFurnizorID(const Value:
    Integer);
begin
  FFurnizorID := Value;
end;

end.
