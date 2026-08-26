unit frmCasaDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, cxMemo, cxPC, FIBDatabase, pFIBDatabase, cxCheckBox,
  cxDBLookupComboBoxButton, DBClient, Provider, dxGDIPlusClasses, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxBarBuiltInMenu, Data.DB, FIBDataSet, pFIBDataSet,
  Vcl.StdCtrls, cxDBEdit, cxDropDownEdit, cxCalc, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxTextEdit;

  
type
  TfrmCasaDialog = class(TForm)
    dtDialogTitle: TDialogTitle;
    Label1: TLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    pFIBDataSetDocument: TpFIBDataSet;
    DataSourceDocument: TDataSource;
    pcPageControl: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    lbFirma: TLabel;
    lbClient: TLabel;
    Label4: TLabel;
    lbClientAnalitica: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    cmbFirmaAnalitica: TcxDBLookupComboBox;
    edSuma: TcxDBCalcEdit;
    edVAT: TcxDBTextEdit;
    cmbCurrency: TcxDBLookupComboBox;
    edRate: TcxDBCalcEdit;
    lbDocComments1: TLabel;
    lbDocComments2: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    pFIBDataSetAnalitica: TpFIBDataSet;
    DataSourceAnalitica: TDataSource;
    pFIBDataSetCurrency: TpFIBDataSet;
    DataSourceCurrency: TDataSource;
    cmbClientAnalitica: TcxDBLookupComboBox;
    cbFLGAcc: TcxDBCheckBox;
    pFIBDataSetCustomers: TpFIBDataSet;
    DataSourceCustomers: TDataSource;
    pFIBDataSetDocProps: TpFIBDataSet;
    edDocINBAZA: TcxDBTextEdit;
    mmDocCOMMENTS: TcxDBMemo;
    DataSourceDocProps: TDataSource;
    procedure edSumaPropertiesEditValueChanged(Sender: TObject);
    procedure cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure pFIBDataSetAnaliticaBeforeOpen(DataSet: TDataSet);
    procedure cbFLGAccPropertiesEditValueChanged(Sender: TObject);
    procedure cmbFirmaButtonClick(Sender: TObject);
    procedure cmbClientButtonClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    fDatabase: TFIBDatabase;
    fDocID:integer;
    function GetCurrencySubValue(const CurrencyID:integer; const ThroughAccount:Boolean):Double;
    procedure SetNewRecordDefaults;
    function SelectCustomer(const Title:String; const CurrentCustomerID:integer):integer;
    function CheckParams:Boolean;
    procedure AdjustDocViewByDocType(const DocTypeID:integer);
    procedure DocumentCommentsEnabled(const AllowComments:Boolean);
  public
    { Public declarations }
    constructor Create(const Database:TFIBDatabase);reintroduce;overload;
    procedure NewDoc(const DocTypeID,UserID:integer);
    procedure EditDoc(const DocID:integer);

    function GetDocID:integer;

  end;


implementation

uses SWNCustomerSelectorUnit, SWNUtils, SWNTypes;

{$R *.dfm}

procedure TfrmCasaDialog.AdjustDocViewByDocType(const DocTypeID: integer);
begin
     case DocTypeID of
     cDBID_DocType_ПКО: begin
                             // no need in changes, form is ready for this type of document
                             Caption:='Приходный кассовый ордер';
                             dtDialogTitle.Title:='Приходный кассовый ордер';
                        end;
     cDBID_DocType_РКО:  begin
                              Caption:='Расходный кассовый ордер';
                              dtDialogTitle.Title:='Расходный кассовый ордер';
                              // need changes:
                              // Change Labels
                              lbFirma.Caption:='Плательшик';
                              lbClient.Caption:='Получатель';
                        end;
     cDBID_DocType_НачСК: begin
                               Caption:='Начальное сальдо';
                               dtDialogTitle.Title:='Начальное сальдо';
                               // need changes:
                               // Change label
                               lbFirma.Caption:='Организация';
                               // hide controls
                               lbClient.Visible:=False;
                               cmbClient.Visible:=False;
                               lbClientAnalitica.Visible:=False;
                               cmbClientAnalitica.Visible:=False;
                          end;
     end;
end;

procedure TfrmCasaDialog.btnCancelClick(Sender: TObject);
begin
     if pFIBDataSetDocument.UpdateTransaction.InTransaction then pFIBDataSetDocument.UpdateTransaction.Rollback;
end;

procedure TfrmCasaDialog.btnOkClick(Sender: TObject);
begin
     if CheckParams then
     begin
          pFIBDataSetDocument.Post;

          if pFIBDataSetDocProps.State in dsEditModes then pFIBDataSetDocProps.Post;

          //if pFIBDataSetDocument.UpdateTransaction.InTransaction then pFIBDataSetDocument.UpdateTransaction.Commit;
          fDocID:=pFIBDataSetDocument.FieldByName('DOCID').AsInteger;
          ModalResult:=mrOk;
     end;
end;

procedure TfrmCasaDialog.cbFLGAccPropertiesEditValueChanged(Sender: TObject);
var flg:Boolean;
begin
     if (Not pFIBDataSetDocument.Active) or Not (pFIBDataSetDocument.State in dsEditModes) then Exit;

     flg:=pFIBDataSetDocument.FieldByName('FLG_ACNT').AsBoolean;
     if Not pFIBDataSetDocument.FieldByName('CURRENCYID').IsNull then
     begin
          pFIBDataSetDocument.FieldByName('RATE').AsFloat := GetCurrencySubValue(pFIBDataSetDocument.FieldByName('CURRENCYID').asInteger, flg);
     end;
end;

function TfrmCasaDialog.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;

     if pFIBDataSetDocument.FieldByName('DT').IsNull then AddErrorToStr(ErrorStr,'Фирма');
     if pFIBDataSetDocument.FieldByName('DTSC').IsNull then AddErrorToStr(ErrorStr,'Аналитика фирма');

     if pFIBDataSetDocument.FieldByName('DOCTYPEID').AsInteger<>cDBID_DocType_НачСК then
     begin
          if pFIBDataSetDocument.FieldByName('CT').IsNull then AddErrorToStr(ErrorStr,'Клиент');
          if pFIBDataSetDocument.FieldByName('CTSC').IsNull then AddErrorToStr(ErrorStr,'Аналитика клиент');
     end;

     if pFIBDataSetDocument.FieldByName('CURRENCYID').IsNull then AddErrorToStr(ErrorStr,'Валюта');
     if pFIBDataSetDocument.FieldByName('RATE').IsNull then AddErrorToStr(ErrorStr,'Курс');
     if pFIBDataSetDocument.FieldByName('SUMA').IsNull then AddErrorToStr(ErrorStr,'Сумма');

  
     if ErrorStr=''
      then Result:=True
      else MEssageDlg(ErrorStr,mtError,[mbOk],0);
end;

procedure TfrmCasaDialog.cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
var id1:integer;
    r:double;
begin
     if (Not pFIBDataSetDocument.Active) or Not (pFIBDataSetDocument.State in dsEditModes) then Exit;
     
     pFIBDataSetDocument.FieldByName('RATE').AsFloat :=
      GetCurrencySubValue(pFIBDataSetDocument.FieldByName('CURRENCYID').asInteger, pFIBDataSetDocument.FieldByName('FLG_ACNT').AsBoolean);
end;

procedure TfrmCasaDialog.cmbFirmaButtonClick(Sender: TObject);
var CustID:integer;
begin
     CustID:=SelectCustomer('Выбрать клиента',pFIBDataSetDocument.FieldByName('DT').AsInteger);
     if CustID<>-1 then pFIBDataSetDocument.FieldByName('DT').AsInteger:=CustID;
end;

constructor TfrmCasaDialog.Create(const Database: TFIBDatabase);
begin
     inherited Create(nil);
     fDatabase:=Database;
     fDocID:=-1;
     pcPageControl.ActivePageIndex:=0;
end;

procedure TfrmCasaDialog.DocumentCommentsEnabled(const AllowComments: Boolean);
begin
     lbDocComments1.Enabled:=AllowComments;
     lbDocComments2.Enabled:=AllowComments;
     edDocINBAZA.Enabled:=AllowComments;
     mmDocCOMMENTS.Enabled:=AllowComments;
end;

procedure TfrmCasaDialog.EditDoc(const DocID: integer);
var tmpIndex:integer;
begin
     // setup db connection
     pFIBDataSetCustomers.Database:=fDatabase;
     pFIBDataSetCurrency.Database:=fDatabase;
     pFIBDataSetAnalitica.Database:=fDatabase;
     pFIBDataSetDocument.Database:=fDatabase;
     pFIBDataSetDocProps.Database:=fDatabase;

     // open data
     pFIBDataSetCustomers.Active:=True;
     pFIBDataSetCurrency.Active:=True;
     pFIBDataSetDocProps.Active:=True;

     pFIBDataSetDocument.ParamByName('DocID').AsInteger:=DocID;
     pFIBDataSetDocument.Active:=True;

     pFIBDataSetAnalitica.ParamByName('DocType').AsInteger:=pFIBDataSetDocument.FieldByName('DocTypeID').AsInteger;
     pFIBDataSetAnalitica.Active:=True;

     AdjustDocViewByDocType(pFIBDataSetDocument.FieldByName('DocTypeID').AsInteger);

     pFIBDataSetDocument.Edit;
end;

procedure TfrmCasaDialog.NewDoc(const DocTypeID,UserID:integer);
begin
     // setup db connection
     pFIBDataSetCustomers.Database:=fDatabase;
     pFIBDataSetCurrency.Database:=fDatabase;
     pFIBDataSetAnalitica.Database:=fDatabase;
     pFIBDataSetDocument.Database:=fDatabase;
     pFIBDataSetDocProps.Database:=fDatabase;

     // open data
     pFIBDataSetCustomers.Active:=True;
     pFIBDataSetCurrency.Active:=True;
     pFIBDataSetAnalitica.Active:=True;
     pFIBDataSetDocument.Active:=True;
     pFIBDataSetDocProps.Active:=True;

     // create new record
     pFIBDataSetDocument.Append;
     pFIBDataSetDocument.FieldByName('CREATED_BY').AsInteger:=UserID;
     pFIBDataSetDocument.FieldByName('DOCTYPEID').AsInteger:=DocTypeID;

     SetNewRecordDefaults;
     AdjustDocViewByDocType(DocTypeID);
end;

procedure TfrmCasaDialog.cmbClientButtonClick(Sender: TObject);
var CustID:integer;
begin
     CustID:=SelectCustomer('Выбрать клиента',pFIBDataSetDocument.FieldByName('CT').AsInteger);
     if CustID<>-1 then pFIBDataSetDocument.FieldByName('CT').AsInteger:=CustID;
end;

function TfrmCasaDialog.SelectCustomer(const Title:String; const CurrentCustomerID: integer): integer;
var cs:TSWNCustomerSelector;
begin
     Result:=-1;
     cs:=TSWNCustomerSelector.Create(nil);
     try
        if cs.SelectCustomer(CurrentCustomerID,False,Title) then Result:=cs.CustomerID;
     finally
        cs.free;
     end;
end;

procedure TfrmCasaDialog.SetNewRecordDefaults;
begin
     // set default values
     pFIBDataSetDocument.FieldByName('SUMA').AsInteger := 0;
     pFIBDataSetDocument.FieldByName('RATE').AsInteger := 1;
     if Not pFIBDataSetCurrency.Eof
      then pFIBDataSetDocument.FieldByName('CURRENCYID').AsInteger := pFIBDataSetCurrency.FieldByName('CURRENCYID').AsInteger;
     if Not pFIBDataSetAnalitica.Eof
      then pFIBDataSetDocument.FieldByName('DTSC').AsInteger := pFIBDataSetAnalitica.FieldByName('ANALITICAID').AsInteger;
end;

procedure TfrmCasaDialog.edSumaPropertiesEditValueChanged(Sender: TObject);
begin
     if pFIBDataSetDocument.State in [dsEdit,dsInsert] then
     pFIBDataSetDocument.FieldByName('VAT').AsCurrency := pFIBDataSetDocument.FieldByName('SUMA').AsCurrency / 6;
end;

function TfrmCasaDialog.GetCurrencySubValue(const CurrencyID: integer;
  const ThroughAccount: Boolean): Double;
begin
     if pFIBDataSetCurrency.Locate('CURRENCYID',CurrencyID,[]) then
     begin
          if ThroughAccount
             then Result:=pFIBDataSetCurrency.FieldByName('TRANSFER_RATE').AsFloat
             else Result:=pFIBDataSetCurrency.FieldByName('EXCHANGE_RATE').AsFloat;
     end
     else Result:=-1;
end;

function TfrmCasaDialog.GetDocID: integer;
begin
     Result:=fDocID;
end;

procedure TfrmCasaDialog.pFIBDataSetAnaliticaBeforeOpen(DataSet: TDataSet);
begin
     pFIBDataSetAnalitica.ParamByName('DocType').AsInteger:=0;
end;

end.
