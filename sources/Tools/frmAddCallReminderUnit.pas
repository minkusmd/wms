unit frmAddCallReminderUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit, Vcl.ExtCtrls, DBAccess, IBC, DialogTitle, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxSpinEdit, cxTimeEdit, cxCalendar, cxMemo, Data.DB, MemDS;

type
  TAddCallReminderDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    IBCTrUpdate: TIBCTransaction;
    pnClient: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    edCUSTOMER: TcxTextEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Label2: TLabel;
    edTelefon: TcxTextEdit;
    Label3: TLabel;
    meReminderBody: TcxMemo;
    Label5: TLabel;
    deDate: TcxDateEdit;
    teTime: TcxTimeEdit;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    cxLookupComboBox1: TcxLookupComboBox;
  private
    FCustomerName: string;
    FCustomerPhone: string;
    FDocID: Integer;
    procedure SetCustomerName(const Value: string);
    procedure SetCustomerPhone(const Value: string);
    procedure SetDocID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CustomerName: string read FCustomerName write SetCustomerName;
    property CustomerPhone: string read FCustomerPhone write SetCustomerPhone;
    property DocID: Integer read FDocID write SetDocID;
  end;


implementation

uses
  DataModuleDB, System.DateUtils;

{$R *.dfm}

{ TAddCallReminderDlg }

function TAddCallReminderDlg.IsFormDataPosted: Boolean;
var
  Docid: Integer;
  ReminderTimeStamp: TDateTime;
  strDate: string;
  strTime: string;
  Query: TIBCQuery;
begin
  Result := True;
  Query := TIBCQuery.Create(Self);
  try
    if dmDB.IBCQueryDocs.Active then
      Docid := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

    strDate := DateToStr(deDate.Date);
    strTime := TimeToStr(teTime.Time + 5);
    ReminderTimeStamp := StrToDateTime(strDate + ' ' + strTime);

    Query.SQL.Text := 'EXECUTE PROCEDURE ADD_CALL_REMINDER(:DOCID, :CUSTOMER_NAME, :reminder_timestamp, :telefon, :reminder_body)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ParamByName('CUSTOMER_NAME').AsString := edCUSTOMER.Text;
    Query.ParamByName('reminder_timestamp').AsDateTime := ReminderTimeStamp;
    Query.ParamByName('telefon').AsString := edTelefon.Text;
    Query.ParamByName('reminder_body').Asstring := meReminderBody.Lines.Text;
    Query.Transaction := IBCTrUpdate;

    try
      Query.ExecSQL;
    finally
      Query.Free;
    end;

  except
    on e: Exception do
    begin
      result := False;
      raise;
    end;
  end;
end;

procedure TAddCallReminderDlg.Prepare;
begin
  inherited;
  IBCQueryUsers.Open;
  edCUSTOMER.Text := CustomerName;
  edTelefon.Text := CustomerPhone;
  deDate.Date := Date;
  teTime.Time := IncMinute(Time, 5)
end;

procedure TAddCallReminderDlg.SetCustomerName(const Value: string);
begin
  FCustomerName := Value;
end;

procedure TAddCallReminderDlg.SetCustomerPhone(const Value: string);
begin
  FCustomerPhone := Value;
end;

procedure TAddCallReminderDlg.SetDocID(const Value: Integer);
begin
  FDocID := Value;
end;

procedure TAddCallReminderDlg.WhenCancelForm;
begin
  inherited;

end;

end.

