unit frmRNDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle,
  cxGraphics, cxCalendar, cxDBEdit, cxMemo, cxDropDownEdit, cxCalc, cxTextEdit,
  cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, SWNDBLookupComboBoxClasses, cxControls,
  cxContainer, cxEdit, cxLabel, ExtCtrls, Menus, StdCtrls, cxButtons, DB, DBAccess,
  IBC, MemDS, cxCheckBox, cxButtonEdit;

type
  TfrmRNDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    lcbCURRENCY: TSWNDBLookupComboBox;
    ceRATE: TcxDBCalcEdit;
    lcbDTSC: TcxDBLookupComboBox;
    lcbCTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    edINBAZA: TcxDBTextEdit;
    cxLabel8: TLabel;
    cxLabel7: TLabel;
    deDATA: TcxDBDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cbFLG_ACNT: TcxDBCheckBox;
    cxLabel6: TLabel;
    lcbDTDEP: TcxDBLookupComboBox;
    cxLabel5: TLabel;
    Bevel1: TBevel;
    lcbSC: TcxDBLookupComboBox;
    beDT_NAME: TcxButtonEdit;
    beCT_NAME: TcxButtonEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fRealRateValue:double;
    FCustomCT: integer;
    FAllowChangeCT: Boolean;
    FAllowChangeDT: Boolean;
    FCustomStock: integer;
    FAllowChangeStock: Boolean;
    FCustomCurrency: integer;
    FAllowChangeCurrency: Boolean;
    fSECURITY_CanSetupPastDate:Boolean;

    procedure SetCreateNewDocument(const Value: Boolean);
    procedure SetCustomCT(const Value: integer);
    procedure SetAllowChangeCT(const Value: Boolean);
    procedure SetAllowChangeDT(const Value: Boolean);
    procedure SetCustomStock(const Value: integer);
    procedure SetAllowChangeStock(const Value: Boolean);
    procedure SetCustomCurrency(const Value: integer);
    procedure SetAllowChangeCurrency(const Value: Boolean);

    function CheckParams:Boolean;
    procedure CloseAdditionalDataSources;

    procedure SelectDT;
    procedure SelectCT;

    procedure SetupSecurityItems;
  protected
    { protected declarations }

    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewDocument:Boolean read fCreateNewDocument write SetCreateNewDocument;
    procedure SetCustomTitle(const Title:String);

    property AllowChangeDT:Boolean read FAllowChangeDT write SetAllowChangeDT;
    property CustomCT:integer read FCustomCT write SetCustomCT;
    property AllowChangeCT:Boolean read FAllowChangeCT write SetAllowChangeCT;
    property CustomStock:integer read FCustomStock write SetCustomStock;
    property AllowChangeStock:Boolean read FAllowChangeStock write SetAllowChangeStock;
    property CustomCurrency:integer read FCustomCurrency write SetCustomCurrency;
    property AllowChangeCurrency:Boolean read FAllowChangeCurrency write SetAllowChangeCurrency;
  end;


implementation

uses DateUtils, DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions,
     frmCustomersDlg, SWNValueStorageUnit, SWNSecurityFlags;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmRNDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectCT;
end;

procedure TfrmRNDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectDT;
end;

function TfrmRNDocDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;
     ErrorStr:='';

     with dmDB.IBCQueryDocs do
     begin
          if FieldByName('DATA').IsNull then AddErrorToStr(ErrorStr,'Дата документа!')
          else
          begin
               if DateOf(FieldByName('DATA').asDateTime)<DateOf(NOW) then AddErrorToStr(ErrorStr,'Дата документа слишком стара!');
          end;

          if FieldByName('SC').IsNull then AddErrorToStr(ErrorStr,'Аналитика документа!');

          if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger=-1) then AddErrorToStr(ErrorStr,'Организация!');
          if FieldByName('DTSC').IsNull then AddErrorToStr(ErrorStr,'Аналитика организации!');

          if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger=-1) then AddErrorToStr(ErrorStr,'Контрагент!');
          if FieldByName('CTSC').IsNull then AddErrorToStr(ErrorStr,'Аналитика контрагента!');

          if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger=-1) then AddErrorToStr(ErrorStr,'Склад!');
          if FieldByName('CURRENCYID').IsNull then AddErrorToStr(ErrorStr,'Валюта!');
          if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat<1) then AddErrorToStr(ErrorStr,'Курс документа!')
          else
          if (FieldByName('RATE').AsFloat<fRealRateValue) then AddErrorToStr(ErrorStr,'Курс документа занижен!')
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmRNDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     CloseAdditionalDataSources;
end;

procedure TfrmRNDocDlg.FormCreate(Sender: TObject);
begin
     FAllowChangeDT := True;
     FCustomCT := -1;
     FAllowChangeCT := True;
     FCustomStock := -1;
     FAllowChangeStock := True;
     FCustomCurrency := -1;
end;

function TfrmRNDocDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          dmDB.IBCQueryDocs.Post;
          if IBCQueryDocProps.State in dsEditModes then IBCQueryDocProps.Post;
          dmDB.IBCQueryDocs.UpdateTransaction.Commit;

          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmRNDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
var currID:integer;
    acnt:Boolean;
begin
     if (dmDB.IBCQueryDocs.State in dsEditModes) and (Not dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull) then
     begin
          currID:=dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger;
          acnt:=dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger=1;
          fRealRateValue:=dmDB.GetCurrencyExchangeValue(currID,acnt);
          dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat:=fRealRateValue;
     end;
end;

procedure TfrmRNDocDlg.Prepare;
var DocumentAdditionalFlags:TDocumentAdditionalFlags;
begin
     SetupSecurityItems;

     if fCreateNewDocument
      then ActiveControl:=beCT_NAME
      else ActiveControl:=lcbDTDEP;

     dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
     try
        dmDB.IBCQueryCurrency.Active:=True;
        dmDB.IBCQueryStocks.Active:=True;
        IBCQueryDocProps.Active:=True;

        if fCreateNewDocument then
        begin
             dtDialogTitle.Text:=cMSG_DIALOG_DOCUMENT_New;
             // Append
             dmDB.IBCQueryDocs.Append;

             dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger:=dmDB.CurrentDocTypeID;
             // system defaults
             if Not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID,dmDB.CurrentFirma,dmDB.IBCQueryDocs,DocumentAdditionalFlags) then
             begin
                  dmDB.IBCQueryDocs.FieldByName('SC').AsInteger:=-1;
                  dmDB.IBCQueryDocs.FieldByName('DT').AsInteger:=dmDB.CurrentFirma;
                  dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
                  dmDB.IBCQueryDocs.FieldByName('CTSC').AsInteger:=-1;
                  dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger:=496;
                  dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger:=0;
             end;

             // user defaults
             if FCustomCT<>-1 then dmDB.IBCQueryDocs.FieldByName('CT').AsInteger:=FCustomCT;
             if FCustomStock<>-1 then dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger:=FCustomStock;
             if FCustomCurrency<>-1 then dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger:=FCustomCurrency;

             // local defaults

             dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency:=0;
             dmDB.IBCQueryDocs.FieldByName('VAT').AsCurrency:=0;
             dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime:=NOW;

             beDT_NAME.Text:=dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
             beCT_NAME.Text:=dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);
        end
        else
        begin
             dtDialogTitle.Text:=WideFormat(cMSG_DIALOG_DOCUMENT_Edit,[dmDB.IBCQueryDocs.FieldByName('DOCNO').AsInteger]);
             // Edit
             dmDB.IBCQueryDocs.Edit;

             beDT_NAME.Text:=dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
             beCT_NAME.Text:=dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
             fRealRateValue:=dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger,dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger=1)
        end;

        dmDB.IBCQueryAnalitica.Active:=True;
        dmDB.IBCQueryAnaliticaSC.Active:=True;

     except
        if dmDB.IBCQueryDocs.State in dsEditModes then dmDB.IBCQueryDocs.Cancel;
        dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

        CloseAdditionalDataSources;

        raise;
     end;
end;

procedure TfrmRNDocDlg.SelectCT;
var dialog:TfrmCustomersDlg;
begin
     dialog:=TfrmCustomersDlg.Create(Self);
     try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
        if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger,False,0,'Выбор контрагента для Расходной накладной') then
        begin
             dmDB.IBCQueryDocs.FieldByName('CT').asInteger:=dialog.CustomerID;
             beCT_NAME.Text:=dialog.CustomerTitle;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmRNDocDlg.SelectDT;
var dialog:TfrmCustomersDlg;
begin
     dialog:=TfrmCustomersDlg.Create(Self);
     try
        dialog.CustomFilter:=[cfFirms,cfFranchises];
        if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger,False,0,'Выбор организации для Расходной накладной') then
        begin
             dmDB.IBCQueryDocs.FieldByName('DT').asInteger:=dialog.CustomerID;
             beDT_NAME.Text:=dialog.CustomerTitle;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmRNDocDlg.SetAllowChangeCT(const Value: Boolean);
begin
     FAllowChangeCT := Value;
     beCT_NAME.Enabled:=Value;
end;

procedure TfrmRNDocDlg.SetAllowChangeCurrency(const Value: Boolean);
begin
     FAllowChangeCurrency := Value;
     lcbCURRENCY.Enabled:=Value;
end;

procedure TfrmRNDocDlg.SetAllowChangeDT(const Value: Boolean);
begin
     FAllowChangeDT := Value;
     beDT_NAME.Enabled:=Value;
end;

procedure TfrmRNDocDlg.SetAllowChangeStock(const Value: Boolean);
begin
     FAllowChangeStock := Value;
     lcbDTDEP.Enabled:=Value;
end;

procedure TfrmRNDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
     fCreateNewDocument := Value;
end;

procedure TfrmRNDocDlg.SetCustomCT(const Value: integer);
begin
     FCustomCT := Value;
end;

procedure TfrmRNDocDlg.SetCustomCurrency(const Value: integer);
begin
     FCustomCurrency := Value;
end;

procedure TfrmRNDocDlg.SetCustomStock(const Value: integer);
begin
     FCustomStock := Value;
end;

procedure TfrmRNDocDlg.SetCustomTitle(const Title: String);
begin
     dtDialogTitle.Title:=Title;
     Caption:=Title;
end;

procedure TfrmRNDocDlg.SetupSecurityItems;
begin
     fSECURITY_CanSetupPastDate:=SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);
end;

procedure TfrmRNDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
     dmDB.IBCQueryCurrency.Close;
     dmDB.IBCQueryAnalitica.Cl