unit frmServiceRequestWarrantyCreateZBPGDocDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls,
  Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalc, cxDBEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxButtonEdit, IBC, dxCoreGraphics;

type
  TfrmServiceRequestWarrantyCreateZBPGDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    edSuma: TcxCalcEdit;
    Label2: TLabel;
    Label3: TLabel;
    edGoodsInfo: TcxTextEdit;
    cxLabel3: TLabel;
    edRate: TcxCalcEdit;
    lcbCurrency: TcxLookupComboBox;
    edGoodsIDENT: TcxTextEdit;
    Label4: TLabel;
    beCustomer: TcxButtonEdit;
    Label5: TLabel;
    edDocInfo: TcxTextEdit;
    Label6: TLabel;
    beFirma: TcxButtonEdit;
    procedure lcbCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beFirmaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    FGoodsID: Integer;
    FGoodsIDENT: string;
    FGoodsSerialType: Integer;
    fCustomerDocID: integer;
    fCustomerID: integer;
    fFirmaID: integer;
    { Private declarations }
    function GetSuma: Double;
    function CheckValues: Boolean;
    function GetCurrencyID: integer;
    function GetCurrencyRate: Double;
    procedure SetGoodsID(const Value: Integer);
    procedure SetGoodsIDENT(const Value: string);
    procedure SetGoodsSerialType(const Value: Integer);
    procedure ReadCustomerAndGoodsInfo;
    procedure SelectCustomer;
    procedure SelectFirma;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    // input
    property GoodsID: Integer read FGoodsID write SetGoodsID;
    property GoodsSerialType: Integer read FGoodsSerialType write SetGoodsSerialType;
    property GoodsIDENT: string read FGoodsIDENT write SetGoodsIDENT;
    // output
    property CustomerDocID: integer read fCustomerDocID;
    property CustomerID: integer read fCustomerID;
    property FirmaID: integer read fFirmaID;
    property Suma: Double read GetSuma;
    property CurrencyID: integer read GetCurrencyID;
    property CurrencyRate: Double read GetCurrencyRate;
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst, frmCustomersDlg,
  SWNCustomersTypesUnit;

{ TfrmServiceRequestWarrantyCreateZBPGDocDlg }

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCustomer;
end;

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.beFirmaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectFirma;
end;

function TfrmServiceRequestWarrantyCreateZBPGDocDlg.CheckValues: Boolean;
var
  Errors: string;
begin
  Result := False;
  Errors := '';

  if fCustomerID = -1 then
    AddErrorToStr(Errors, 'Контрагент!');
  if VarIsNull(edSuma.EditValue) or (edSuma.EditValue <= 0) then
    AddErrorToStr(Errors, 'Сумма зачета!');

  if Errors = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.FormCreate(Sender: TObject);
begin
  fCustomerDocID := -1;
  fCustomerID := -1;
end;

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.FormDestroy(Sender: TObject);
begin
  dmDB.IBCQueryCurrency.Close;
end;

function TfrmServiceRequestWarrantyCreateZBPGDocDlg.GetCurrencyID: integer;
begin
  Result := lcbCurrency.EditValue;
end;

function TfrmServiceRequestWarrantyCreateZBPGDocDlg.GetCurrencyRate: Double;
begin
  Result := edRate.EditValue;
end;

function TfrmServiceRequestWarrantyCreateZBPGDocDlg.GetSuma: Double;
begin
  Result := edSuma.EditValue;
end;

function TfrmServiceRequestWarrantyCreateZBPGDocDlg.IsFormDataPosted: Boolean;
begin
  Result := CheckValues;
end;

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.lcbCurrencyPropertiesEditValueChanged(Sender: TObject);
begin
  edRate.EditValue := dmDB.GetCurrencyExchangeValue(lcbCurrency.EditValue, False);
end;

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.Prepare;
begin
  beCustomer.Text := '';
  edDocInfo.Text := '';
  edGoodsInfo.Text := '';

  ReadCustomerAndGoodsInfo;
  edGoodsIDENT.Text := FGoodsIDENT;

  edSuma.EditValue := 0;
  dmDB.IBCQueryCurrency.Active := True;
  lcbCurrency.EditValue := 840;
end;

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.ReadCustomerAndGoodsInfo;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
        // gautam clientul dupa produs
    Query.SQL.Text := 'SELECT DOCID,CUSTOMER_ID,CUSTOMER_TITLE,DOCTYPE_TITLE FROM SP_52_GETDOCBYSN(:GOODS_ID, :GOODS_SERIAL_TYPE, :GOODS_IDENT)';
    Query.ParamByName('GOODS_ID').AsInteger := FGoodsID;
    Query.ParamByName('GOODS_SERIAL_TYPE').AsInteger := FGoodsSerialType;
    Query.ParamByName('GOODS_IDENT').AsString := FGoodsIDENT;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      fCustomerDocID := Query.Fields[0].AsInteger;
      fCustomerID := Query.Fields[1].AsInteger;
      beCustomer.Text := Format('#%d - %s', [fCustomerID, Query.Fields[2].AsString]);
      edDocInfo.Text := Format('#%d - %s', [fCustomerDocID, Query.Fields[3].AsString]);
    end;
    Query.Close;
        // citim info despre produs
    Query.SQL.Text := 'SELECT TITLE FROM TS_GOODS WHERE GOODSID=:GOODS_ID';
    Query.ParamByName('GOODS_ID').AsInteger := FGoodsID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      edGoodsInfo.Text := Format('#%d - %s', [FGoodsID, Query.Fields[0].AsString]);
    end;

  finally
    Query.Free;
  end;
end;

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.SelectCustomer;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fCustomerID, false, 0, '') then
    begin
      fCustomerDocID := -1;
      fCustomerID := dialog.CustomerID;
      beCustomer.Text := Format('#%d - %s', [fCustomerID, dialog.CustomerTitle]);
      edDocInfo.Text := '';
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.SelectFirma;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(fFirmaID, false, 0, '') then
    begin
      fFirmaID := dialog.CustomerID;
      beFirma.Text := Format('#%d - %s', [fFirmaID, dialog.CustomerTitle]);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.SetGoodsID(const Value: Integer);
begin
  FGoodsID := Value;
end;

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.SetGoodsIDENT(const Value: string);
begin
  FGoodsIDENT := Value;
end;

procedure TfrmServiceRequestWarrantyCreateZBPGDocDlg.SetGoodsSerialType(const Value: Integer);
begin
  FGoodsSerialType := Value;
end;

end.

