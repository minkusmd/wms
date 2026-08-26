unit frameCustomerEmailUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, dxBar, DBAccess, IBC, MemDS, cxCheckBox,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TframeCustomerEMail = class(TFrame)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNewCustomerEmail: TdxBarButton;
    bbEditCustomerEmail: TdxBarButton;
    bbDeleteCustomerEmail: TdxBarButton;
    cxGridCustEmail: TcxGrid;
    cxGridCustEmailDBTableView: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    IBCQueryCustomerEMail: TIBCQuery;
    IBCDataSourceCustomerEmail: TIBCDataSource;
    cxGridCustEmailDBTableViewUNSUBSCRIBED: TcxGridDBColumn;
    cxGridCustEmailDBTableViewCREATED_DATE: TcxGridDBColumn;
    cxGridCustEmailDBTableViewUNSUBSCRIBE_DATE: TcxGridDBColumn;
    cxGridCustEmailDBTableViewEMail: TcxGridDBColumn;
    bbClearEmails: TdxBarButton;
    cxGridCustEmailDBTableViewColumn1: TcxGridDBColumn;
    procedure bbNewCustomerEmailClick(Sender: TObject);
    procedure bbEditCustomerEmailClick(Sender: TObject);
    procedure bbDeleteCustomerEmailClick(Sender: TObject);
    procedure bbClearEmailsClick(Sender: TObject);
  private
    FConnection: TIBCConnection;
    FCustomerID: Integer;
    FSelectTransaction: TIBCTransaction;
    FUpdateTransaction: TIBCTransaction;
    procedure SetConnection(const Value: TIBCConnection);
    procedure SetCustomerID(const Value: Integer);
    procedure SetSelectTransaction(const Value: TIBCTransaction);
    procedure SetUpdateTransaction(const Value: TIBCTransaction);

    { Private declarations }
  protected
    procedure ShowCustomerPhonesEditorDialog(IsNewRecord: Boolean);
  public
    procedure OpenDataSet;
    property Connection: TIBCConnection read FConnection write SetConnection;
    property CustomerID: Integer read FCustomerID write SetCustomerID;
    property SelectTransaction: TIBCTransaction read FSelectTransaction write SetSelectTransaction;
    property UpdateTransaction: TIBCTransaction read FUpdateTransaction write SetUpdateTransaction;
    { Public declarations }
  end;

implementation

uses
  DataModuleAdditions, SWNUtils, frmCustomerEMailEditorDlgUnit;

{$R *.dfm}

{ TframeCustomerPhones }

procedure TframeCustomerEMail.bbClearEmailsClick(Sender: TObject);
var
  q: TIBCQuery;
  tr: TIBCTransaction;
begin
  q := TIBCQuery.Create(self);
  tr := TIBCTransaction.Create(self);
  tr.DefaultConnection := IBCQueryCustomerEMail.Transaction.DefaultConnection;
  try
    q.SQL.Text := 'delete from ts_cust_emails where customerid = :customerid';
    q.ParamByName('customerid').AsInteger := IBCQueryCustomerEMail.FieldByName('CustomerID').AsInteger;
    q.Transaction := tr;

    tr.StartTransaction;
    q.ExecSQL;
    if tr.Active then
      tr.Commit;
  finally
    q.Free;
    tr.Free;
    IBCQueryCustomerEMail.Refresh;
  end;
end;

procedure TframeCustomerEMail.bbDeleteCustomerEmailClick(Sender: TObject);
begin
  if ShowAskDialog('EMail', 'Stergeti inregistrarea ?') = mrYes then
  begin
    if not IBCQueryCustomerEMail.UpdateTransaction.Active then
      IBCQueryCustomerEMail.UpdateTransaction.StartTransaction;

    try
      IBCQueryCustomerEMail.Delete;
      IBCQueryCustomerEMail.UpdateTransaction.Commit;
    except
      begin
        IBCQueryCustomerEMail.UpdateTransaction.Rollback;
        raise;
      end;
    end;
  end;
end;

procedure TframeCustomerEMail.bbEditCustomerEmailClick(Sender: TObject);
begin
  ShowCustomerPhonesEditorDialog(False);
end;

procedure TframeCustomerEMail.bbNewCustomerEmailClick(Sender: TObject);
begin
  ShowCustomerPhonesEditorDialog(True);
end;

procedure TframeCustomerEMail.OpenDataSet;
begin
  IBCQueryCustomerEMail.Close;
  IBCQueryCustomerEMail.Connection := FConnection;
  IBCQueryCustomerEMail.UpdateTransaction := FUpdateTransaction;
  IBCQueryCustomerEMail.Transaction := FSelectTransaction;

  IBCQueryCustomerEMail.ParamByName('CUSTOMERID').AsInteger := FCustomerID;
  IBCQueryCustomerEMail.Open;
end;

procedure TframeCustomerEMail.SetConnection(const Value: TIBCConnection);
begin
  FConnection := Value;
end;

procedure TframeCustomerEMail.SetCustomerID(const Value: Integer);
begin
  FCustomerID := Value;
end;

procedure TframeCustomerEMail.SetSelectTransaction(const Value: TIBCTransaction);
begin
  FSelectTransaction := Value;
end;

procedure TframeCustomerEMail.SetUpdateTransaction(const Value: TIBCTransaction);
begin
  FUpdateTransaction := Value;
end;

procedure TframeCustomerEMail.ShowCustomerPhonesEditorDialog(IsNewRecord: Boolean);
var
  dialog: TfrmCustomerEmailEditorDialog;
begin
  dialog := TfrmCustomerEmailEditorDialog.Create(Self, IBCQueryCustomerEMail, IBCDataSourceCustomerEMail);
  try
    dialog.IsNewRecord := IsNewRecord;
    dialog.CustomerID := FCustomerID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.

