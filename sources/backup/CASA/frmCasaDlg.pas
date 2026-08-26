unit frmCasaDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxMaskEdit, cxButtonEdit, cxDBEdit, DB,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, cxCalc, cxMemo, cxPC,
  cxCheckBox, cxDBLookupComboBoxButton, DBClient, Provider, dxGDIPlusClasses,
  Menus, cxLookAndFeelPainters, cxButtons, SWNDBLookupComboBoxClasses, DBAccess,
  IBC, MemDS, cxNavigator, cxDBNavigator, dxBarBuiltInMenu, cxLookAndFeels;

type
  TfrmCasaDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
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
    cmbFirmaAnalitica: TSWNDBLookupComboBox;
    edSuma: TcxDBCalcEdit;
    edVAT: TcxDBTextEdit;
    cmbCurrency: TSWNDBLookupComboBox;
    edRate: TcxDBCalcEdit;
    lbDocComments1: TLabel;
    lbDocComments2: TLabel;
    cmbClientAnalitica: TSWNDBLookupComboBox;
    cbFLGAcc: TcxDBCheckBox;
    cmbFirma: TSWNDBLookupComboBoxButton;
    cmbClient: TSWNDBLookupComboBoxButton;
    edDocINBAZA: TcxDBTextEdit;
    mmDocCOMMENTS: TcxDBMemo;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    IBCQueryAnalitica: TIBCQuery;
    IBCDataSourceAnalitica: TIBCDataSource;
    IBCQueryCurrency: TIBCQuery;
    IBCDataSourceCurrency: TIBCDataSource;
    IBCQueryCustomers: TIBCQuery;
    IBCDataSourceCustomers: TIBCDataSource;
    IBCQueryFirme: TIBCQuery;
    IBCDataSourceFirme: TIBCDataSource;
    procedure edSumaPropertiesEditValueChanged(Sender: TObject);
    procedure cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure cbFLGAccPropertiesEditValueChanged(Sender: TObject);
    procedure cmbFirmaButtonClick(Sender: TObject);
    procedure cmbClientButtonClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    fDocID: integer;
    function GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
    procedure SetNewRecordDefaults;
    function SelectCustomer(const Title: string; const CurrentCustomerID: integer; const RootParentID: integer = 0): integer;
    function CheckParams: Boolean;
    procedure AdjustDocViewByDocType(const DocTypeID: integer);
    procedure DocumentCommentsEnabled(const AllowComments: Boolean);
  protected
    procedure InitValues; override;
  public
    { Public declarations }
    procedure NewDoc(const DocTypeID: integer);
    procedure EditCurrentDoc;
    function GetDocID: integer;
  end;

implementation

uses
  SWNCustomer, SWNUtils, SWNTypes, SWNConst, DataModuleDB;

{$R *.dfm}

procedure TfrmCasaDialog.AdjustDocViewByDocType(const DocTypeID: integer);
begin
  case DocTypeID of
    cDBID_DocType_КАССА_ПКО:
      begin
                             // no need in changes, form is ready for this type of document
        Caption := 'Приходный кассовый ордер';
        dtDialogTitle.Title := 'Приходный кассовый ордер';
      end;
    cDBID_DocType_КАССА_РКО:
      begin
        Caption := 'Расходный кассовый ордер';
        dtDialogTitle.Title := 'Расходный кассовый ордер';
                              // need changes:
                              // Change Labels
        lbFirma.Caption := 'Плательшик';
        lbClient.Caption := 'Получатель';
      end;
    cDBID_DocType_КАССА_НС:
      begin
        Caption := 'Начальное сальдо';
        dtDialogTitle.Title := 'Начальное сальдо';
                               // need changes:
                               // Change label
        lbFirma.Caption := 'Организация';
                               // hide controls
        lbClient.Visible := False;
        cmbClient.Visible := False;
        lbClientAnalitica.Visible := False;
        cmbClientAnalitica.Visible := False;
                               // new width
        cmbFirma.Width := 544;
      end;
  end;
end;

procedure TfrmCasaDialog.btnOkClick(Sender: TObject);
begin
  if CheckParams then
  begin
    fMasterDataSet.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    fDocID := fMasterDataSet.FieldByName('DOCID').AsInteger;
    ModalResult := mrOk;
  end;
end;

procedure TfrmCasaDialog.cbFLGAccPropertiesEditValueChanged(Sender: TObject);
var
  flg: Boolean;
begin
  if fMasterDataSet.State in dsEditModes then
  begin
    flg := fMasterDataSet.FieldByName('FLG_ACNT').AsBoolean;
    if not fMasterDataSet.FieldByName('CURRENCYID').IsNull then
    begin
      fMasterDataSet.FieldByName('RATE').AsFloat := GetCurrencySubValue(fMasterDataSet.FieldByName('CURRENCYID').asInteger, flg);
    end;
  end;
end;

function TfrmCasaDialog.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;

  if fMasterDataSet.FieldByName('DT').IsNull then
    AddErrorToStr(ErrorStr, 'Фирма');
  if fMasterDataSet.FieldByName('DTSC').IsNull then
    AddErrorToStr(ErrorStr, 'Аналитика фирма');

  if fMasterDataSet.FieldByName('DOCTYPEID').AsInteger <> cDBID_DocType_КАССА_НС then
  begin
    if fMasterDataSet.FieldByName('CT').IsNull then
      AddErrorToStr(ErrorStr, 'Клиент');
    if fMasterDataSet.FieldByName('CTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика клиент');
  end;

  if fMasterDataSet.FieldByName('CURRENCYID').IsNull then
    AddErrorToStr(ErrorStr, 'Валюта');
  if fMasterDataSet.FieldByName('RATE').IsNull then
    AddErrorToStr(ErrorStr, 'Курс');
  if fMasterDataSet.FieldByName('SUMA').IsNull then
    AddErrorToStr(ErrorStr, 'Сумма');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDlg(cMSG_LOGIN_GeneralInputError_Title, cMSG_LOGIN_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmCasaDialog.cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
var
  id1: integer;
  r: double;
begin
  if fMasterDataSet.State in dsEditModes then
  begin
    fMasterDataSet.FieldByName('RATE').AsFloat := GetCurrencySubValue(fMasterDataSet.FieldByName('CURRENCYID').asInteger, fMasterDataSet.FieldByName('FLG_ACNT').AsBoolean);
  end;
end;

procedure TfrmCasaDialog.cmbFirmaButtonClick(Sender: TObject);
var
  CustID: integer;
begin
  CustID := SelectCustomer('Выбрать Получателя', fMasterDataSet.FieldByName('DT').AsInteger);
  if CustID <> -1 then
    fMasterDataSet.FieldByName('DT').AsInteger := CustID;
end;

procedure TfrmCasaDialog.DocumentCommentsEnabled(const AllowComments: Boolean);
begin
  lbDocComments1.Enabled := AllowComments;
  lbDocComments2.Enabled := AllowComments;
  edDocINBAZA.Enabled := AllowComments;
  mmDocCOMMENTS.Enabled := AllowComments;
end;

procedure TfrmCasaDialog.EditCurrentDoc;
var
  tmpIndex: integer;
begin
     // open data
  IBCQueryCustomers.Active := True;
  IBCQueryFirme.Active := True;
  IBCQueryCurrency.Active := True;
  IBCQueryDocProps.Active := True;
  IBCQueryAnalitica.ParamByName('DocType').AsInteger := fMasterDataSet.FieldByName('DocTypeID').AsInteger;
  IBCQueryAnalitica.Active := True;

  AdjustDocViewByDocType(fMasterDataSet.FieldByName('DocTypeID').AsInteger);

  fMasterDataSet.UpdateTransaction.StartTransaction;
  fMasterDataSet.Edit;
end;

procedure TfrmCasaDialog.NewDoc(const DocTypeID: integer);
begin
     // open data
  IBCQueryCustomers.Active := True;
  IBCQueryFirme.Active := True;
  IBCQueryCurrency.Active := True;
  IBCQueryAnalitica.ParamByName('DocType').AsInteger := DocTypeID;
  IBCQueryAnalitica.Open;
  IBCQueryDocProps.Active := True;

  fMasterDataSet.UpdateTransaction.StartTransaction;
  fMasterDataSet.Append;
  fMasterDataSet.FieldByName('DOCTYPEID').AsInteger := DocTypeID;

  SetNewRecordDefaults;

  AdjustDocViewByDocType(DocTypeID);
end;

procedure TfrmCasaDialog.cmbClientButtonClick(Sender: TObject);
var
  CustID: integer;
begin
  CustID := SelectCustomer('Выбрать Плательщика', fMasterDataSet.FieldByName('CT').AsInteger);
  if CustID <> -1 then
    fMasterDataSet.FieldByName('CT').AsInteger := CustID;
end;

function TfrmCasaDialog.SelectCustomer(const Title: string; const CurrentCustomerID: integer; const RootParentID: integer = 0): integer;
var
  cs: TSWNCustomer;
begin
  Result := -1;
  cs := TSWNCustomer.Create(fIBCConnection);
  try
    if cs.SelectCustomer(CurrentCustomerID, False, RootParentID, Title) then
      Result := cs.CustomerID;
  finally
    cs.free;
  end;
end;

procedure TfrmCasaDialog.SetNewRecordDefaults;
begin
     // set default values
  fMasterDataSet.FieldByName('CREATED_BY').AsInteger := fUserID;
  fMasterDataSet.FieldByName('FLG_ACNT').AsBoolean := False;
  fMasterDataSet.FieldByName('SUMA').AsInteger := 0;
  fMasterDataSet.FieldByName('RATE').AsInteger := 1;

  fMasterDataSet.FieldByName('CREATED_BY').AsInteger := dmDB.CurrentUserID;
  fMasterDataSet.FieldByName('DT').AsInteger := dmDB.CurrentFirma;

  fMasterDataSet.FieldByName('CURRENCYID').AsInteger := 496; // MDL

  fMasterDataSet.FieldByName('CTSC').AsInteger := -1;
  fMasterDataSet.FieldByName('DTSC').AsInteger := -1;
end;

procedure TfrmCasaDialog.edSumaPropertiesEditValueChanged(Sender: TObject);
begin
  if fMasterDataSet.State in dsEditModes then
  begin
    fMasterDataSet.FieldByName('VAT').AsCurrency := fMasterDataSet.FieldByName('SUMA').AsCurrency / 6;
  end;
end;

procedure TfrmCasaDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
  begin
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Cancel;
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
  end;
end;

function TfrmCasaDialog.GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
begin
  if IBCQueryCurrency.Active and IBCQueryCurrency.Locate('CURRENCYID', CurrencyID, []) then
  begin
    if ThroughAccount then
      Result := IBCQueryCurrency.FieldByName('TRANSFER_RATE').AsFloat
    else
      Result := IBCQueryCurrency.FieldByName('EXCHANGE_RATE').AsFloat;
  end
  else
    Result := -1;
end;

function TfrmCasaDialog.GetDocID: integer;
begin
  Result := fDocID;
end;

procedure TfrmCasaDialog.InitValues;
begin
  inherited;

     // setup db connection
  IBCQueryCustomers.Connection := fIBCConnection;
  IBCQueryCurrency.Connection := fIBCConnection;
  IBCQueryAnalitica.Connection := fIBCConnection;
  IBCQueryDocProps.Connection := fIBCConnection;

  IBCQueryDocProps.MasterSource := fMasterDataSource;

  cmbFirma.DataBinding.DataSource := fMasterDataSource;
  cmbClient.DataBinding.DataSource := fMasterDataSource;
  cmbFirmaAnalitica.DataBinding.DataSource := fMasterDataSource;
  cmbClientAnalitica.DataBinding.DataSource := fMasterDataSource;
  cbFLGAcc.DataBinding.DataSource := fMasterDataSource;
  cmbCurrency.DataBinding.DataSource := fMasterDataSource;
  edRate.DataBinding.DataSource := fMasterDataSource;
  edSuma.DataBinding.DataSource := fMasterDataSource;
  edVAT.DataBinding.DataSource := fMasterDataSource;

  fDocID := -1;
  pcPageControl.ActivePageIndex := 0;
end;

end.

