unit uLoanDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, DBAccess, IBC, MemDS,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, Vcl.ExtCtrls, dxBar, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmLoanDlg = class(TSWNCustomForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryLoan: TIBCQuery;
    IBCDataSourceLoan: TIBCDataSource;
    cxGrid1DBTableView1LOANID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1MONTHS: TcxGridDBColumn;
    cxGrid1DBTableView1CUST_PAY_M_AMOUNT: TcxGridDBColumn;
    cxGrid1DBTableView1OUR_PAY_PERCENT: TcxGridDBColumn;
    cxGrid1DBTableView1CUST_PREPAY_AMOUNT: TcxGridDBColumn;
    cxGrid1DBTableView1CUST_PREPAY_PERCENT: TcxGridDBColumn;
    cxGrid1DBTableView1CUST_MONTHLY_COMISION: TcxGridDBColumn;
    cxGrid1DBTableView1LOAN_IMAGE: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCTrUpdate: TIBCTransaction;
    dxBarButton1: TdxBarButton;
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    procedure EditLoan(fIsNewRecord: Boolean);
  public
    { Public declarations }
  end;

var
  frmLoanDlg: TfrmLoanDlg;

implementation

uses
  uLoanEditorDlg, DataModuleAdditions, SWNUtils;

{$R *.dfm}

procedure TfrmLoanDlg.bbDeleteClick(Sender: TObject);
begin
  inherited;
  if ShowAskDialog('Credite', 'Stergeti inregistrarea ?')=mrYes then
  begin
     IBCQueryLoan.Delete;
  end;
end;

procedure TfrmLoanDlg.bbEditClick(Sender: TObject);
begin
  inherited;
  EditLoan(False);
end;

procedure TfrmLoanDlg.bbNewClick(Sender: TObject);
begin
  inherited;
  EditLoan(True);
end;

procedure TfrmLoanDlg.dxBarButton1Click(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmLoanDlg.EditLoan(fIsNewRecord: Boolean);
var
  dialog: TfrmLoanEditorDlg;
begin
  dialog := TfrmLoanEditorDlg.Create(Self, IBCQueryLoan, IBCDataSourceLoan);
  try
    dialog.IsNewRecord := fIsNewRecord;
    dialog.ShowModal;

  finally
    dialog.Free;
  end;
end;

procedure TfrmLoanDlg.Prepare;
begin
  inherited;
  IBCTrUpdate.DefaultConnection := IBCConnection;
  IBCQueryLoan.Connection := fIBCConnection;
  IBCQueryLoan.UpdateTransaction := IBCTrUpdate;
  IBCQueryLoan.Open;
end;

end.
