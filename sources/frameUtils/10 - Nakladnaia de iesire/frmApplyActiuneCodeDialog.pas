unit frmApplyActiuneCodeDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmApplyActiuneCodeDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edCode: TEdit;
    btnCheck: TButton;
    btnApply: TButton;
    Label2: TLabel;
    Label3: TLabel;
    edActiuneTitle: TEdit;
    edCustomer: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    lbInfo: TLabel;
    btnClose: TButton;
    edDiscount: TEdit;
    Label7: TLabel;
    Label6: TLabel;
    mmInfo: TMemo;
    procedure btnCheckClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
  private
    FDocID: integer;
    { Private declarations }
    fCode:String;
    function DoCheckCode(const CodeStr:String; const DocID:integer):Boolean;
    procedure SetDocID(const Value: integer);
    function DoApplyCode:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property DocID:integer read FDocID write SetDocID;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, IBC, DataModuleDB, SWNUpdateClientDBClass, SWNUtils, SWNDBErrors;

{ TfrmApplyActiuneCodeDlg }

procedure TfrmApplyActiuneCodeDlg.btnApplyClick(Sender: TObject);
begin
     if ShowAskDialog('Promo coduri','Aplicati acest promo cod pentru vinzarea selectata?')=mrYes then
     begin
          if DoApplyCode
           then ModalResult:=mrOK
           else lbInfo.Show;
     end;
end;

procedure TfrmApplyActiuneCodeDlg.btnCheckClick(Sender: TObject);
begin
     if Not DoCheckCode(Trim(edCode.Text),fDocID) then ShowErrorDialog('Eroare','Asa cod nu a fost gasit!');
end;

function TfrmApplyActiuneCodeDlg.DoApplyCode:Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_ACTIUNE_APPLY_CODE(:TDOC,:CODE)';
        Query.ParamByName('CODE').AsString:=fCode;
        Query.ParamByName('TDOC').AsInteger:=FDocID;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E: Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
       Query.Free;
     end;
end;

function TfrmApplyActiuneCodeDlg.DoCheckCode(const CodeStr: String; const DocID:integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT * FROM SP_ACTIUNE_CHECK_CODE(:CODE,:DOCID)';
        Query.ParamByName('CODE').AsString:=CodeStr;
        Query.ParamByName('DOCID').AsInteger:=DocID;
        Query.ExecSQL;
        if Not Query.Eof then
        begin
             fCode:=Query.FieldByName('CODE').AsString;
             edActiuneTitle.Text:=Query.FieldByName('TITLE').AsString;
             if (Query.FieldByName('CUSTOMERID').AsInteger=-1)
               then edCustomer.Text:=''
               else edCustomer.Text:=Format('#%d - %s',[Query.FieldByName('CUSTOMERID').AsInteger,Query.FieldByName('CUSTOMER_TITLE').AsString]);
             edDiscount.Text:=Query.FieldByName('DISCOUNT').AsString;
             if Query.FieldByName('ERRORS').IsNull then
             begin
                  mmInfo.Text:='Totul e excelent!';
                  mmInfo.Font.Color:=clGreen;
                  btnApply.Enabled:=True;
             end
             else
             begin
                  mmInfo.Text:=Trim(Query.FieldByName('ERRORS').AsString);
                  mmInfo.Font.Color:=clRed;
             end;

             Result:=True;
        end;
     finally
       Query.Free;
     end;
end;

procedure TfrmApplyActiuneCodeDlg.Prepare;
begin
     edActiuneTitle.Text:='';
     edCustomer.Text:='';
     edDiscount.Text:='';
     lbInfo.Visible:=False;
     btnApply.Enabled:=False;
end;

procedure TfrmApplyActiuneCodeDlg.SetDocID(const Value: integer);
begin
     fDocID := Value;
end;

end.
