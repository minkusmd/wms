unit frmCerereDePlataDialog;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, Vcl.Menus,
    cxButtonEdit, Vcl.StdCtrls, cxButtons, cxCalc, cxTextEdit, cxMaskEdit, cxDropDownEdit,
    cxCalendar, cxLabel, SWNBaseUnit, Vcl.ExtCtrls, DialogTitle, cxMemo;

type
    TfrmCerereDePlataDlg = class(TSWNBaseFormClass)
        Panel1: TPanel;
        cxLabel1: TcxLabel;
        dePaymentDate: TcxDateEdit;
        cxLabel2: TcxLabel;
        ceSuma: TcxCalcEdit;
        cxLabel3: TcxLabel;
        beCustomer: TcxButtonEdit;
        DialogTitle1: TDialogTitle;
        Panel2: TPanel;
        cxButton1: TcxButton;
        cxButton2: TcxButton;
    meComment: TcxMemo;
    cxLabel4: TcxLabel;
        procedure beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    private
        procedure UpdateRequestPaymentDocument;    { Private declarations }
    protected    { Protected declaration }
        procedure Prepare; override;
        function IsFormDataPosted: boolean; override;
    public    { Public declarations }
        Amount: Currency;
        CustomerID: Integer;
        CustomerName: string;
        IsNewRecord: boolean;
        PaymentDate: TDateTime;
        Comment: string;
        procedure AddRequestPaymentDocument;
    end;

//var
//  frmCerereDePlataDlg: TfrmCerereDePlataDlg;

implementation

uses
    frmCustomersDlg, IBC, DataModuleDB, DataModuleAdditions;

{$R *.dfm}

procedure TfrmCerereDePlataDlg.AddRequestPaymentDocument;
var
    NewDocID: Integer;
    Query: TIBCQuery;
    Tr: TIBCTransaction;
begin
    Tr := TIBCTransaction.Create(self);
    Query := TIBCQuery.Create(self);
    try
        Tr.DefaultConnection := dmdb.IBCConnection;
        if not Tr.Active then
            Tr.StartTransaction;

        Query.Transaction := Tr;
        Query.SQL.Add('select newdocid from  SP_CREATE_NEW_DOCUMENT(:DT,');
        Query.SQL.Add(':CT,');
        Query.SQL.Add(':DTDEP,');
        Query.SQL.Add(':CTDEP,');
        Query.SQL.Add(':DTSC,');
        Query.SQL.Add(':CTSC,');
        Query.SQL.Add(':SUMA,');
        Query.SQL.Add(':VAT,');
        Query.SQL.Add(':CURRENCYID,');
        Query.SQL.Add(':DISCOUNT,');
        Query.SQL.Add(':RATE,');
        Query.SQL.Add(':RATEUSD,');
        Query.SQL.Add(':PARENTDOCID,');
        Query.SQL.Add(':ACC$MASK,');
        Query.SQL.Add(':DOCTYPEID,');
        Query.SQL.Add(':FLAGS,');
        Query.SQL.Add(':SC2,');
        Query.SQL.Add(':CONTRACTID)');

        Query.ParamByName('DT').AsInteger := dmdb.CurrentFirma;
        Query.ParamByName('CT').AsInteger := CustomerID;
        Query.ParamByName('DTDEP').AsInteger := -1;
        Query.ParamByName('CTDEP').AsInteger := -1;
        Query.ParamByName('DTSC').AsInteger := -1;
        Query.ParamByName('CTSC').AsInteger := -1;
        Query.ParamByName('SUMA').AsFloat := Amount;
        Query.ParamByName('VAT').AsFloat := Amount / 6;
        Query.ParamByName('CURRENCYID').AsInteger := 498;
        Query.ParamByName('DISCOUNT').AsInteger := 0;
        Query.ParamByName('RATE').AsInteger := 1;
        Query.ParamByName('RATEUSD').AsFloat := dmdb.ibcqueryDocs.FieldByName('RATEUSD').AsFloat;
        Query.ParamByName('PARENTDOCID').AsInteger := dmdb.ibcqueryDocs.FieldByName('DOCID').AsInteger;
        Query.ParamByName('ACC$MASK').AsInteger := 0;
        Query.ParamByName('DOCTYPEID').AsInteger := 3363;
        Query.ParamByName('FLAGS').AsInteger := 1;
        Query.ParamByName('SC2').AsInteger := -1;
        Query.Execute;
        NewDocID := Query.FieldByName('newdocid').AsInteger;

        if  (Comment<>'') then


        if Tr.Active then
            Tr.Commit;
        dmDB.ibcqueryDocs.Refresh;
    finally
        Tr.Free;
        Query.Free;
    end;
end;

procedure TfrmCerereDePlataDlg.UpdateRequestPaymentDocument;
begin

end;

procedure TfrmCerereDePlataDlg.beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
    dialog: TfrmCustomersDlg;
    ok: Boolean;
begin
    dialog := TfrmCustomersDlg.Create(Self);
    try
        if ((beCustomer.Text <> '') and (beCustomer.Tag < 1)) then
            ok := dialog.SelectCustomerBySearch(beCustomer.Text, 'Selectati destinatarul platii')
        else
            ok := dialog.SelectCustomer(CustomerID, False, 0, 'Selectati destinatarul platii');

        if ok then
        begin
            beCustomer.Tag := dialog.CustomerID;
            beCustomer.Text := dialog.CustomerTitle;
        end;
    finally
        dialog.Free;
    end;
end;

function TfrmCerereDePlataDlg.IsFormDataPosted: boolean;
var
    ParamByName: Boolean;
    Query: TIBCQuery;
    Tr: TIBCTransaction;
begin
    Amount := ceSuma.Value;
    CustomerID := beCustomer.Tag;
    PaymentDate := dePaymentDate.Date;
    Comment := meComment.Lines.Text;
  { TODO : De adaugat inregistrarea in tdb_docs }

    Result := True;
end;

procedure TfrmCerereDePlataDlg.Prepare;
begin
    ceSuma.Value := Amount;
    beCustomer.Tag := CustomerID;
    beCustomer.Text := CustomerName;
    dePaymentDate.Date := PaymentDate;
    ceSuma.Value := Amount;
    if (Comment <> '') and (meComment.Lines.Text <> Comment) then
       meComment.Lines.Text := Comment + #13#10 + meComment.Lines.Text;
end;

end.

