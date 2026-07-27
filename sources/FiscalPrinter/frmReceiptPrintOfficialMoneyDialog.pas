unit frmReceiptPrintOfficialMoneyDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBAccess, IBC, DialogTitle, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, Vcl.StdCtrls, Data.DB, MemDS, dxUIAClasses;

type
  TfrmReceiptPrintOfficialMoneyDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    IBCTrUpdate: TIBCTransaction;
    edPaySuma: TEdit;
    Label9: TLabel;
    btnPrintReceipt: TButton;
    lcbExistingDocumentSelector: TcxLookupComboBox;
    Label1: TLabel;
    Button1: TButton;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
  end;



var
  frmReceiptPrintOfficialMoneyDlg: TfrmReceiptPrintOfficialMoneyDlg;

implementation

{$R *.dfm}

procedure TfrmReceiptPrintOfficialMoneyDlg.Prepare;
begin
   IBCQueryUsers.Active := True;
end;

function TfrmReceiptPrintOfficialMoneyDlg.IsFormDataPosted: Boolean;
begin
  { checkparams}

  { call procedure to generate document}

  { when all done succesefull return True}
   Result := True;
end;

end.
