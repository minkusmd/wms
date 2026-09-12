unit frmCerereDePlataDBDialog;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, Vcl.Menus,
    cxButtonEdit, Vcl.StdCtrls, cxButtons, cxCalc, cxTextEdit, cxMaskEdit, cxDropDownEdit,
    cxCalendar, cxLabel, SWNBaseUnit, Vcl.ExtCtrls, DialogTitle, cxMemo, Data.DB, MemDS, DBAccess,
    IBC, cxDBEdit, System.DateUtils, System.Math, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
    cxClasses, dxUIAClasses, dxCoreGraphics, RzPanel, RzDlgBtn;

type
    TfrmCerereDePlataDBDlg = class(TSWNMasteredFormClass)
        Panel1: TPanel;
        cxLabel1: TcxLabel;
        cxLabel2: TcxLabel;
        cxLabel3: TcxLabel;
        beCT: TcxButtonEdit;
        DialogTitle1: TDialogTitle;
        cxLabel4: TcxLabel;
        dePaymentDate: TcxDBDateEdit;
        ceSuma: TcxDBCalcEdit;
        cxDBMemo1: TcxDBMemo;
        IBCQueryDocProps: TIBCQuery;
        IBCDataSourceDocProps: TIBCDataSource;
        beDT: TcxButtonEdit;
        cxLabel5: TcxLabel;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        ceRATE: TcxDBCalcEdit;
        ceRATEUSD: TcxDBCalcEdit;
        lcbCURRENCY: TcxDBLookupComboBox;
    RzDialogButtons1: TRzDialogButtons;
        procedure beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
        procedure beDTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
        procedure FormShow(Sender: TObject);
    private
        FCreateNewDocument: Boolean;
        procedure SetCreateNewDocument(const Value: Boolean);
        procedure UpdateRequestPaymentDocument;
        function CheckParams: Boolean;    { Private declarations }
    protected    { Protected declaration }
        procedure Prepare; override;
        function IsFormDataPosted: boolean; override;
        procedure BindingDataSource; override;
        procedure WhenCancelForm; override;
    public    { Public declarations }
        Amount: Currency;
        CustomerID: Integer;
        CustomerName: string;
        PaymentDate: TDateTime;
        Comment: string;
        procedure AddRequestPaymentDocument;
        property CreateNewDocument: Boolean read FCreateNewDocument write SetCreateNewDocument;
    end;

//var
//  frmCerereDePlataDlg: TfrmCerereDePlataDlg;

implementation

uses
    frmCustomersDlg, DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst;

{$R *.dfm}

procedure TfrmCerereDePlataDBDlg.AddRequestPaymentDocument;
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

        if (Comment <> '') then
            if Tr.Active then
                Tr.Commit;
        dmDB.ibcqueryDocs.Refresh;
    finally
        Tr.Free;
        Query.Free;
    end;
end;

procedure TfrmCerereDePlataDBDlg.UpdateRequestPaymentDocument;
begin

end;

procedure TfrmCerereDePlataDBDlg.WhenCancelForm;
begin
  inherited;
  if dmdb.IBCQueryDocs.State in dsEditModes then
    dmdb.ibcquerydocs.Cancel;

  if dmdb.IBCQueryDocs.UpdateTransaction.Active then
    dmdb.ibcquerydocs.UpdateTransaction.Rollback;

end;

procedure TfrmCerereDePlataDBDlg.beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
    dialog: TfrmCustomersDlg;
    ok: Boolean;
begin
    dialog := TfrmCustomersDlg.Create(Self);
    try
        if ((beCT.Text <> '') and (beCT.Tag < 1)) then
            ok := dialog.SelectCustomerBySearch(beCT.Text, 'Selectati destinatarul platii')
        else
            ok := dialog.SelectCustomer(CustomerID, False, 0, 'Selectati destinatarul platii');

        if ok then
        begin
            beCT.Tag := dialog.CustomerID;
            beCT.Text := dialog.CustomerTitle;
            dmdb.ibcquerydocs.fieldbyName('ct').AsInteger := dialog.customerid;
            dmdb.ibcquerydocs.fieldbyname('ct_name').Asstring := dialog.customerTitle;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmCerereDePlataDBDlg.beDTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
    dialog: TfrmCustomersDlg;
    ok: Boolean;
begin
    dialog := TfrmCustomersDlg.Create(Self);
    try
        if ((beDT.Text <> '') and (beDT.Tag < 1)) then
            ok := dialog.SelectCustomerBySearch(beDT.Text, 'Selectati platitorul')
        else
            ok := dialog.SelectCustomer(CustomerID, False, 0, 'Selectati platitorul');

        if ok then
        begin
            beDT.Tag := dialog.CustomerID;
            beDT.Text := dialog.CustomerTitle;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmCerereDePlataDBDlg.BindingDataSource;
begin
    inherited;
    dePaymentDate.DataBinding.DataSource := fMasterDataSource;
    ceSuma.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmCerereDePlataDBDlg.CheckParams: Boolean;
var
    ErrorStr: string;
begin
    Result := False;
    ErrorStr := '';

    with dmDB.IBCQueryDocs do
    begin
        if FieldByName('DATA').IsNull then
            AddErrorToStr(ErrorStr, 'Data documentului!')
        else
        begin
            if (DateOf(FieldByName('DATA').AsDateTime) < DateOf(NOW)) then
                AddErrorToStr(ErrorStr, 'Data documentului este prea veche!');
        end;

//        if FieldByName('SC2').IsNull then
//            AddErrorToStr(ErrorStr, 'Analitica documentului!');

        if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
            AddErrorToStr(ErrorStr, 'Organizatia!');
//        if FieldByName('DTSC').IsNull then
//            AddErrorToStr(ErrorStr, 'Analitica organizatiei!');

        if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
            AddErrorToStr(ErrorStr, 'Furnizor!');
//
//        if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
//            AddErrorToStr(ErrorStr, 'Depozitul organizatiei!');
        if FieldByName('CURRENCYID').IsNull then
            AddErrorToStr(ErrorStr, 'Valuta!');

//        if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
//            AddErrorToStr(ErrorStr, 'Cursul USD al documentului!')
    end;

    if ErrorStr = '' then
        Result := True
    else
        ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmCerereDePlataDBDlg.FormShow(Sender: TObject);
begin
   if fCreateNewDocument then BeCT.SetFocus
   else ceSuma.SetFocus;
end;

function TfrmCerereDePlataDBDlg.IsFormDataPosted: boolean;
begin
    if CheckParams then
    begin
        try
          if dmDB.IBCQueryDocs.State in dsEditModes then
            dmDB.IBCQueryDocs.Post;

          if IBCQueryDocProps.State in dsEditModes then
              IBCQueryDocProps.Post;

          dmDB.IBCQueryDocs.UpdateTransaction.Commit;

          Result := True;
        except on e: Exception do
          begin
            result := false;
            raise;
          end;
        end;
    end
    else
        Result := False;
end;

procedure TfrmCerereDePlataDBDlg.Prepare;
var
    DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
//    ceSuma.Value := Amount;
//    beCustomer.Tag := CustomerID;
//    beCustomer.Text := CustomerName;
//    dePaymentDate.Date := PaymentDate;
//    ceSuma.Value := Amount;
//    if (Comment <> '') and (meComment.Lines.Text <> Comment) then
//       meComment.Lines.Text := Comment + #13#10 + meComment.Lines.Text;
    dmdb.IBCQueryCurrency.Open;

    if fCreateNewDocument then
    begin
        dmDB.IBCQueryDocs.Append;
        dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger := dmDB.CurrentDocTypeID;
        // try to get default values
        if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs,
            DocumentAdditionalFlags) then
        begin
            dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
            beDT.Text := dmdb.CurrentFirmaName;
            dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
            dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
            dmdb.ibcquerydocs.FieldByName('DTSC').AsInteger := -1;
            dmdb.IBCQueryDocs.FieldByName('CTSC').AsInteger := -1;
            dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
        end;

        dmdb.IBCQueryDocs.FieldByName('CT').AsInteger := CustomerID;
        dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := PaymentDate;
        dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := Amount;
        dmDB.IBCQueryDocs.FieldByName('RATE').AsCurrency := 1;
        dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName
            ('FLG_ACNT').AsInteger = 1, True);

        beDT.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
        beCT.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);
    end
    else
    begin
             // Edit
        dmDB.IBCQueryDocs.Edit;
        beDT.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
        beCT.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
//      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1, True);
    end;

    IBCQueryDocProps.Active := True;
end;

procedure TfrmCerereDePlataDBDlg.SetCreateNewDocument(const Value: Boolean);
begin
    FCreateNewDocument := Value;
end;

end.

