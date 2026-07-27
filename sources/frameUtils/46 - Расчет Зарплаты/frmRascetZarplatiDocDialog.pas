unit frmRascetZarplatiDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, DB, DBAccess, IBC, MemDS,
  cxCalendar, cxDBEdit, cxMemo, cxCheckBox, cxDropDownEdit, cxCalc, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, ExtCtrls, StdCtrls, cxButtonEdit, Buttons, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxButtons, dxUIAClasses, dxCoreGraphics;

type
  TfrmRascetZarplatiDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    pnClient: TPanel;
    lbFirma: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbDocComments1: TLabel;
    lbDocComments2: TLabel;
    edRate: TcxDBCalcEdit;
    cbFLG_ACNT: TcxDBCheckBox;
    edDocINBAZA: TcxDBTextEdit;
    mmDocCOMMENTS: TcxDBMemo;
    deDATA: TcxDBDateEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    ceRATEUSD: TcxDBCalcEdit;
    Label2: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    cmbCurrency: TcxDBLookupComboBox;
    lcbDTSC: TcxDBLookupComboBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure cbFLGAccPropertiesEditValueChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmDocCOMMENTSClick(Sender: TObject);
  private
    { Private declarations }
    FCreateNewDocument: Boolean;
    fSECURITY_CanSetupPastDate: Boolean;
    FReadOnly: Boolean;
    function GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
    function CheckParams: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SetReadOnly(const Value: Boolean);
    procedure ShowDocumentCommentsEditorDialog;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read FCreateNewDocument write SetCreateNewDocument;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  DateUtils, SWNUtils, SWNTypes, SWNConst, DataModuleDB, DataModuleAdditions,
  frmCustomersDlg, frmBanknoteCounterDialog, SWNSecurityFlags, SWNSecurity,
  SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog;

{$R *.dfm}

procedure TfrmRascetZarplatiDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

procedure TfrmRascetZarplatiDocDlg.cbFLGAccPropertiesEditValueChanged(Sender: TObject);
var
  flg: Boolean;
begin
  if dmDB.IBCQueryDocs.State in dsEditModes then
  begin
    flg := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1;
    if flg then
    begin
      dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
      cmbCurrency.Enabled := False;
    end
    else
    begin
      cmbCurrency.Enabled := True;
      if not dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull then
      begin
        dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := GetCurrencySubValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger, flg);
      end;
    end;
  end;
end;

function TfrmRascetZarplatiDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;

  if dmDB.IBCQueryDocs.FieldByName('DATA').IsNull then
    AddErrorToStr(ErrorStr, 'Дата документа!');

  if dmDB.IBCQueryDocs.FieldByName('SC2').IsNull then
    AddErrorToStr(ErrorStr, 'Аналитика документа!');

  if dmDB.IBCQueryDocs.FieldByName('DT').IsNull then
    AddErrorToStr(ErrorStr, 'Фирма!');
  if dmDB.IBCQueryDocs.FieldByName('DTSC').IsNull then
    AddErrorToStr(ErrorStr, 'Аналитика!');

     // common fields
  if dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull then
    AddErrorToStr(ErrorStr, 'Валюта!');
  if dmDB.IBCQueryDocs.FieldByName('RATE').IsNull then
    AddErrorToStr(ErrorStr, 'Курс!');

  if dmDB.IBCQueryDocs.FieldByName('RATEUSD').IsNull or (dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat < 1) then
    AddErrorToStr(ErrorStr, 'Курс USD документа!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmRascetZarplatiDocDlg.cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
begin
  if dmDB.IBCQueryDocs.State in dsEditModes then
  begin
    dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := GetCurrencySubValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);
  end;
end;

procedure TfrmRascetZarplatiDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Выбор ' + lbFirma.Caption + ' для "' + Caption + '"') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmRascetZarplatiDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  FCreateNewDocument := Value;
end;

procedure TfrmRascetZarplatiDocDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmRascetZarplatiDocDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;

end;

procedure TfrmRascetZarplatiDocDlg.ShowDocumentCommentsEditorDialog;
var
  dialog: TfrmDocumentCommentsEditorDlg;
begin
  dialog := TfrmDocumentCommentsEditorDlg.Create(Self, IBCQueryDocProps, IBCDataSourceDocProps);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmRascetZarplatiDocDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmRascetZarplatiDocDlg.CloseAdditionalDataSources;
begin
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryCurrency.Close;
end;

procedure TfrmRascetZarplatiDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmRascetZarplatiDocDlg.FormCreate(Sender: TObject);
begin
  FCreateNewDocument := False;
  FReadOnly := False;
end;

function TfrmRascetZarplatiDocDlg.GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
begin
  if dmDB.IBCQueryCurrency.Active and dmDB.IBCQueryCurrency.Locate('CURRENCYID', CurrencyID, []) then
  begin
    if ThroughAccount then
      Result := dmDB.IBCQueryCurrency.FieldByName('TRANSFER_RATE').AsFloat
    else
      Result := dmDB.IBCQueryCurrency.FieldByName('EXCHANGE_RATE').AsFloat;
  end
  else
    Result := -1;
end;

function TfrmRascetZarplatiDocDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    dmDB.IBCQueryDocs.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    dmDB.IBCQueryDocs.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmRascetZarplatiDocDlg.mmDocCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmRascetZarplatiDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
        // open data
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryAnalitica.Active := True;
    dmDB.OpenAnalyticsDataSource;
    dmDB.OpenAnalyticsDataSource;

    IBCQueryDocProps.Active := True;

    if FCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;

      dmDB.IBCQueryDocs.Append;

             // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

             // local default
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsInteger := 0;
      dmDB.IBCQueryDocs.FieldByName('RATE').AsInteger := 1;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
    end
    else
    begin
      if FReadOnly then
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        pnClient.Enabled := False;
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
      end
      else
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dmDB.IBCQueryDocs.Edit;
      end;

      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
    end;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;

end;

end.

