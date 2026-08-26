unit uValidateVoucherGiftDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, IBC, SWNBaseUnit;

type
  TfrmValidateVoucherGiftDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    edCode: TEdit;
    btnCheck: TButton;
    btnClose: TButton;
    Label2: TLabel;
    btnApply: TButton;
    lbInfo: TLabel;
    procedure btnCheckClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FDocID: Integer;
    FDT: integer;
    procedure SetDocID(const Value: Integer);
    procedure SetDT(const Value: integer);
    { Private declarations }
  protected
     function DoCheckCode(const CodeStr: String; const DT: integer): Boolean;
     procedure Prepare; override;
  public
    property DocID: Integer read FDocID write SetDocID;
    property DT: integer read FDT write SetDT;
    { Public declarations }
  end;

var
  frmValidateVoucherGiftDlg: TfrmValidateVoucherGiftDlg;

implementation

{$R *.dfm}

uses
  SWNUtils, DataModuleDB;

procedure TfrmValidateVoucherGiftDlg.btnCheckClick(Sender: TObject);
begin
  if Not DoCheckCode(Trim(edCode.Text),fDocID) then ShowErrorDialog('Eroare','Asa cod nu a fost gasit!');
end;

function TfrmValidateVoucherGiftDlg.DoCheckCode(const CodeStr: String; const DT: integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     btnApply.Enabled := False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT * FROM check_voucher_code(:DT, :CODE)';
        Query.ParamByName('CODE').AsString := CodeStr;
        Query.ParamByName('DT').AsInteger := DT;
        Query.Open;

        if not Query.Eof then
        begin
            lbInfo.Caption := format('Suma voucherului = %f'#13#10'Perioada %s - %s'#13#10'Clientul care a achitat voucherul: #%d - %s'#13#10'Documentul de vinzare: %d',
              [
                Query.FieldByName('AMOUNT').AsFloat,
                Query.FieldByName('DATA1').AsString,
                Query.FieldByName('DATA2').AsString,
                Query.FieldByName('CUSTOMERID').AsInteger,
                Query.FieldByName('CUSTOMER_NAME').AsString,
                Query.FieldByName('RASHOD_DOCID').AsInteger
              ]);

             lbInfo.Font.Color:=clGreen;
             btnApply.Enabled:=True;

             Result:=True;
        end
        else
        begin
          lbInfo.Caption := 'Eroare: Nu este gasit nici un voucher cu acest cod.';
          lbInfo.Font.Color:=clRed;
        end;
     finally
       Query.Free;
     end;
end;

procedure TfrmValidateVoucherGiftDlg.FormShow(Sender: TObject);
begin
  edCode.SetFocus;
end;

procedure TfrmValidateVoucherGiftDlg.Prepare;
begin

  btnApply.Enabled := False;
end;

procedure TfrmValidateVoucherGiftDlg.SetDocID(const Value: Integer);
begin
  FDocID := Value;
end;

procedure TfrmValidateVoucherGiftDlg.SetDT(const Value: integer);
begin
  FDT := Value;
end;


end.
