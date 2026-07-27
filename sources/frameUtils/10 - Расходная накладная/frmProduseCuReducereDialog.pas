unit frmProduseCuReducereDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, StdCtrls, cxTextEdit, cxMemo;

type

  TDocumentInfo = class
  public
    { Public declarations }
    DocID:integer;
    Data:TDateTime;
    CT_ID:integer;
    CT_Name:String;
    CT_Phone:String;
    DiscountType:integer;
    DiscountValue:integer;
  end;


  TfrmProduseCuReducereDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnYes: TButton;
    Button3: TButton;
    Notebook: TNotebook;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edCODE: TcxTextEdit;
    btnCheckCode: TButton;
    mmInfo: TcxMemo;
    pnFinish: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure btnCheckCodeClick(Sender: TObject);

  private
    { Private declarations }
    FCurrentCustomerID: integer;
    FCurrentCustomerName: String;
    fTargetCustomerID: integer;
    fPromoCode: String;
    fOriginalDocID: integer;
    FCurrentDocID: integer;
    fDiscountValue: Integer;
    fDiscountType: Integer;

    procedure CheckCode;
    function GetDocumentInfoByCode(const Code:String):TDocumentInfo;
    procedure SetCurrentCustomerID(const Value: integer);
    procedure SetCurrentCustomerName(const Value: String);
    procedure CheckRelatedInfoDB(const DocID:integer; const PromoCode:String; const Errors:TStringList);
    procedure SetCurrentDocID(const Value: integer);

    procedure btnNextClick(Sender: TObject);
  protected
    { protected declarations }
    procedure Prepare;override;

  public
    { Public declarations }

    property CurrentCustomerID:integer read FCurrentCustomerID write SetCurrentCustomerID;
    property CurrentCustomerName:String read FCurrentCustomerName write SetCurrentCustomerName;
    property CurrentDocID:integer read FCurrentDocID write SetCurrentDocID;

    property PromoCode:String read fPromoCode;
    property OriginalDocID:integer read fOriginalDocID;
    property DiscountType:Integer read fDiscountType;
    property DiscountValue:Integer read fDiscountValue;

  end;


implementation
Uses IBC, DataModuleDB, SWNUtils;

{$R *.dfm}

procedure TfrmProduseCuReducereDlg.btnCheckCodeClick(Sender: TObject);
begin
     CheckCode;
end;

procedure TfrmProduseCuReducereDlg.btnNextClick(Sender: TObject);
begin
     Notebook.PageIndex:=1;
     btnYes.OnClick:=nil;
     btnYes.ModalResult:=mrYes;
     btnYes.Caption:='Aplica codul de reducere';
end;

procedure TfrmProduseCuReducereDlg.CheckCode;
var info:TDocumentInfo;
    code:String;
    Errors:TStringList;
begin
     mmInfo.Lines.Clear;

     code:=Trim(edCODE.Text);
     info:=GetDocumentInfoByCode(code);
     if Assigned(info) then
     begin
          mmInfo.Lines.Add(Format('Cumparatorul primei cumparaturi: #%d - %s',[info.CT_ID,info.CT_Name]));
          mmInfo.Lines.Add(Format('Nr de telefon al cumparatorului: %s',[info.CT_Phone]));
          mmInfo.Lines.Add('');
          mmInfo.Lines.Add(Format('Cumparatorul cu codul de reducere: #%d - %s',[FCurrentCustomerID,FCurrentCustomerName]));
          mmInfo.Lines.Add('');

          btnCheckCode.Default:=False;
          btnCheckCode.Enabled:=False;
          edCODE.Enabled:=False;

          Errors:=TStringList.Create;
          try
             CheckRelatedInfoDB(fCurrentDocID,code,Errors);
             if Errors.Count>0 then
             begin
                  mmInfo.Lines.Add('Eroare!');
                  mmInfo.Lines.Add(Errors.Text);
             end
             else
             begin
                  // Ok
                  mmInfo.Lines.Add('Puteti aplica pentru codul de reducere!');
                  // save values
                  fTargetCustomerID:=info.CT_ID;
                  fOriginalDocID:=info.DocID;
                  fPromoCode:=code;
                  fDiscountType:=info.DiscountType;
                  fDiscountValue:=info.DiscountValue;

                  btnYes.Enabled:=True;
                  btnYes.Default:=True;
                  btnYes.SetFocus;
             end;
          finally
             Errors.Free;
          end;

     end
     else
     begin
          mmInfo.Lines.Add('Eroare! Cod inexistent!');
     end;
end;

procedure TfrmProduseCuReducereDlg.CheckRelatedInfoDB(const DocID: integer; const PromoCode: String; const Errors:TStringList);
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDb.IBCConnection;
        Query.SQL.Text:='SELECT ERROR_STR FROM SP_VERIFY_GOODS_DISCOUNT_CODE(:DOCID,:CODE)';
        Query.ParamByName('DOCID').AsInteger:=DocID;
        Query.ParamByName('CODE').AsString:=PromoCode;
        Query.ExecSQL;
        While Not Query.Eof do
        begin
             Errors.Add(Query.Fields[0].AsString);
             Query.Next;
        end;
     finally
        Query.Free;
     end;
end;

function TfrmProduseCuReducereDlg.GetDocumentInfoByCode(const Code: String): TDocumentInfo;
var Query:TIBCQuery;
begin
     Result:=nil;

     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDb.IBCConnection;
        Query.SQL.Add('SELECT TDB_GOODS_DISCOUNT_TICKET.DOCID, VW_TDB_DOCS.DATA, VW_TDB_DOCS.CT, VW_TDB_DOCS.CT_NAME, TS_CUST_INFO.MOBILE,');
        Query.SQL.Add(' DISCOUNT_TYPE, DISCOUNT_VALUE');
        Query.SQL.Add('FROM TDB_GOODS_DISCOUNT_TICKET');
        Query.SQL.Add('INNER JOIN VW_TDB_DOCS ON (VW_TDB_DOCS.DOCID=TDB_GOODS_DISCOUNT_TICKET.DOCID)');
        Query.SQL.Add('LEFT OUTER JOIN TS_CUST_INFO ON (TS_CUST_INFO.CUSTOMERID = VW_TDB_DOCS.CT)');
        Query.SQL.Add('WHERE (DISCOUNT_TICKET= :code) AND (FLG_USED=0)');
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
             Result.DiscountType:=Query.Fields[5].AsInteger;
             Result.DiscountValue:=Query.Fields[6].AsInteger;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmProduseCuReducereDlg.Prepare;
begin
     mmInfo.Lines.Clear;
     btnYes.Enabled:=False;
     btnYes.OnClick:=btnNextClick;
     btnYes.ModalResult:=mrNone;
     btnYes.Caption:='Inainte >>';
     Notebook.PageIndex:=0;
     ActiveControl:=edCODE;
end;

procedure TfrmProduseCuReducereDlg.SetCurrentCustomerID(const Value: integer);
begin
     FCurrentCustomerID := Value;
end;

procedure TfrmProduseCuReducereDlg.SetCurrentCustomerName(const Value: String);
begin
     FCurrentCustomerName := Value;
end;

procedure TfrmProduseCuReducereDlg.SetCurrentDocID(const Value: integer);
begin
     fCurrentDocID := Value;
end;


end.
