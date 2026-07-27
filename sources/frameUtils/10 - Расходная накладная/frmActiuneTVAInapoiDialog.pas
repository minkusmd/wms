unit frmActiuneTVAInapoiDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, StdCtrls, cxTextEdit;

type

  TDocumentInfo = class
  public
    { Public declarations }
    DocID:integer;
    Data:TDateTime;
    CT_ID:integer;
    CT_Name:String;
    CT_Phone:String;
  end;



  TfrmActiuneTVAInapoiDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edCODE: TcxTextEdit;
    btnCheckCode: TButton;
    Label3: TLabel;
    Label4: TLabel;
    edCustomer: TcxTextEdit;
    Label5: TLabel;
    Label6: TLabel;
    btnYes: TButton;
    Button3: TButton;
    Label7: TLabel;
    Label8: TLabel;
    edPhone: TcxTextEdit;
    Label9: TLabel;
    Label10: TLabel;
    edCurrentCustomer: TcxTextEdit;
    procedure btnCheckCodeClick(Sender: TObject);
  private
    { Private declarations }
    FSourceCustomerID: integer;
    FSourceCustomerName: String;
    fTargetCustomerID: integer;
    fTargetCode: String;
    fTargetDocID: integer;

    procedure CheckCode;
    function GetDocumentInfoByCode(const Code:String):TDocumentInfo;
    procedure SetSourceCustomerID(const Value: integer);
    procedure SetSourceCustomerName(const Value: String);

  protected
    { protected declarations }
    procedure Prepare;override;

  public
    { Public declarations }

    property SourceCustomerID:integer read FSourceCustomerID write SetSourceCustomerID;
    property SourceCustomerName:String read FSourceCustomerName write SetSourceCustomerName;

    property TargetCode:String read fTargetCode;
    property TargetDocID:integer read fTargetDocID;
    property TargetCustomerID:integer read fTargetCustomerID;

  end;


implementation
Uses IBC, DataModuleDB, SWNUtils;

{$R *.dfm}

procedure TfrmActiuneTVAInapoiDlg.btnCheckCodeClick(Sender: TObject);
begin
     CheckCode;
end;

procedure TfrmActiuneTVAInapoiDlg.CheckCode;
var info:TDocumentInfo;
    code:String;
begin
     code:=Trim(edCODE.Text);
     info:=GetDocumentInfoByCode(code);
     if Assigned(info) then
     begin
          edCustomer.Text:=info.CT_Name;
          edPhone.Text:=info.CT_Phone;
          btnCheckCode.Default:=False;
          btnCheckCode.Enabled:=False;
          edCODE.Enabled:=False;
          edCustomer.Style.TextColor:=clNavy;
          edPhone.Style.TextColor:=clNavy;
          if info.CT_ID=FSourceCustomerID then
          begin
               // save values
               fTargetCustomerID:=info.CT_ID;
               fTargetDocID:=info.DocID;
               fTargetCode:=code;
               btnYes.Enabled:=True;
               btnYes.Default:=True;
               btnYes.SetFocus;
          end
          else
          begin
               edCurrentCustomer.Style.TextColor:=clRed;
          end
     end
     else
     begin
          ShowErrorDialog('Eroare','Cod inexistent!');
     end;

end;

function TfrmActiuneTVAInapoiDlg.GetDocumentInfoByCode(const Code: String): TDocumentInfo;
var Query:TIBCQuery;
begin
     Result:=nil;

     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDb.IBCConnection;
        Query.SQL.Add('SELECT');
        Query.SQL.Add(' TDB_TVA_DISCOUNT.DOCID,');
        Query.SQL.Add(' VW_TDB_DOCS.DATA,');
        Query.SQL.Add(' VW_TDB_DOCS.CT,');
        Query.SQL.Add(' VW_TDB_DOCS.CT_NAME,');
        Query.SQL.Add(' TS_CUST_INFO.MOBILE');
        Query.SQL.Add('FROM TDB_TVA_DISCOUNT');
        Query.SQL.Add('INNER JOIN VW_TDB_DOCS ON (VW_TDB_DOCS.DOCID=TDB_TVA_DISCOUNT.DOCID)');
        Query.SQL.Add('LEFT OUTER JOIN TS_CUST_INFO ON (TS_CUST_INFO.CUSTOMERID = VW_TDB_DOCS.CT)');
        Query.SQL.Add('WHERE (TVA_DISC_CODE = :code) AND (FLG_USED=0)');

        Query.ParamByName('code').AsString:=Code;

        Query.ExecSQL;

        if Not Query.Eof then
        begin
             Result:=TDocumentInfo.Create;
             Result.DocID:=Query.Fields[0].AsInteger;
             Result.Data:=Query.Fields[1].AsDateTime;
             Result.CT_ID:=Query.Fields[2].AsInteger;
             Result.CT_Name:=Query.Fields[3].AsString;
             Result.CT_Phone:=Query.Fields[4].AsString;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmActiuneTVAInapoiDlg.Prepare;
begin
     edCurrentCustomer.Text:=FSourceCustomerName;
     btnYes.Enabled:=False;
end;

procedure TfrmActiuneTVAInapoiDlg.SetSourceCustomerID(const Value: integer);
begin
     FSourceCustomerID := Value;
end;

procedure TfrmActiuneTVAInapoiDlg.SetSourceCustomerName(const Value: String);
begin
     FSourceCustomerName := Value;
end;

end.
