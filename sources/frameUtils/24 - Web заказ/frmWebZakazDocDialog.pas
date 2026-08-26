unit frmWebZakazDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, DB, IBC,
  StdCtrls, cxButtonEdit, cxDBEdit, cxDBLookupComboBox, ExtCtrls, cxButtons, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DBAccess, MemDS, cxCheckBox, cxCalendar, cxMemo, cxDropDownEdit,
  cxCalc, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, dxStatusBar,
  dxCoreGraphics, dxUIAClasses, frameDocsDeliveryUnit;

type
  TfrmWebZakazDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    IBCQueryCashback: TIBCQuery;
    IBCDataSourceCashback: TIBCDataSource;
    dxStatusBar1: TdxStatusBar;
    Timer1: TTimer;
    pnClient: TScrollBox;
    lblSecDocument: TLabel;
    bvDocument: TBevel;
    cxLabel5: TLabel;
    lblStare: TLabel;
    lblOrganizatie: TLabel;
    lblAnaliticaOrg: TLabel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel6: TLabel;
    lblSecFinante: TLabel;
    bvFinante: TBevel;
    cxLabel3: TLabel;
    lblRata: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblSecLivrare: TLabel;
    bvLivrare: TBevel;
    cxLabel8: TLabel;
    bvMentiuni: TBevel;
    deDATA: TcxDBDateEdit;
    lcbSTATEID: TcxDBLookupComboBox;
    beDT_NAME: TcxButtonEdit;
    lcbDTSC: TcxDBLookupComboBox;
    lcbAnalytics: TcxDBLookupComboBox;
    beCT_NAME: TcxButtonEdit;
    lcbDTDEP: TcxDBLookupComboBox;
    lcbCURRENCY: TcxDBLookupComboBox;
    ceRATE: TcxDBCalcEdit;
    ceRATEUSD: TcxDBCalcEdit;
    ceCashback: TcxDBCalcEdit;
    cbFLG_ACNT: TcxDBCheckBox;
    frameDelivery: TframeDocsDelivery;
    mmCOMMENTS: TcxDBMemo;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fReadOnly: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams: Boolean;
    procedure CloseAdditionaldataSources;
    procedure SelectDT;
    procedure SelectCT;
    procedure ShowDocumentCommentsEditorDialog;
    procedure SetReadOnly(const Value: Boolean);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property readonly: Boolean read fReadOnly write SetReadOnly;
  end;

implementation

uses
  DateUtils, DataModuleDB, SWNUtils, SWNConst, frmCustomersDlg, SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog,
  SWNSecurity;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmWebZakazDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmWebZakazDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmWebZakazDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Дата документа!');

    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика документа!');

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Организация!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика организации!');

    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Контрагент!');

    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Склад!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Валюта!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Курс документа!');
    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Курс USD!');
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebZakazDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionaldataSources;
end;

function TfrmWebZakazDocDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    dmDB.IBCQueryDocs.Post;
    frameDelivery.PostData(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
    if dmdb.IBCQueryDocComments.State in dsEditModes then
      dmdb.IBCQueryDocComments.Post;
    dmDB.IBCQueryDocs.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmWebZakazDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmWebZakazDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  if not fReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryStocks.Active := True;

//    IBCQueryDocProps.Active := True;
    dmdb.IBCQueryDocComments.Active := True;

    if fCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;

        // Append
      dmDB.IBCQueryDocs.Append;

      dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger := dmDB.CurrentDocTypeID;
        // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
        //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

        // local defaults
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('VAT').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
      dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger := -1;
    end
    else
    begin
        // Edit
      if fReadOnly then
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        pnClient.Enabled := False;
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        btnOk.Visible := False;
        btnCancel.Caption := cMSG_ButtonClose;
      end
      else
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dmDB.IBCQueryDocs.Edit;
      end;

    end;

    beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
    beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;

    dmDB.IBCQueryAnalitica.Active := True;

    dmdb.IBCQueryDocTypeStates.Close;
    dmdb.IBCQueryDocTypeStates.ParamByName('DOCTYPEID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger;
    dmdb.IBCQueryDocTypeStates.Open;

    IBCQueryCashback.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    IBCQueryCashback.Open;

    frameDelivery.ReadOnly := fReadOnly;
    frameDelivery.PrepareData(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);

    dmDB.OpenAnalyticsDataSource;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmdb.IBCQueryDocComments.Close;
    if not fReadOnly then
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionaldataSources;

    raise;
  end;

end;

procedure TfrmWebZakazDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Выбор контрагента для WEB заказа') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebZakazDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Выбор организации для WEB заказа') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebZakazDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmWebZakazDocDlg.SetReadOnly(const Value: Boolean);
begin
  fReadOnly := Value;
end;

procedure TfrmWebZakazDocDlg.SetupSecurityItems;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;

end;

procedure TfrmWebZakazDocDlg.ShowDocumentCommentsEditorDialog;
var
  dialog: TfrmDocumentCommentsEditorDlg;
begin
  dialog := TfrmDocumentCommentsEditorDlg.Create(Self, dmdb.IBCQueryDocComments, dmdb.IBCDataSourceDocComments);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebZakazDocDlg.WhenCancelForm;
begin
  if dmdb.IBCQueryDocComments.State in dsEditModes then
    dmdb.IBCQueryDocComments.Cancel;

  frameDelivery.CancelData;

  dmDB.IBCQueryDocs.Cancel;
  if not fReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmWebZakazDocDlg.CloseAdditionaldataSources;
begin
     // close additional datasets
  frameDelivery.CloseData;
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
  dmdb.IBCQueryDocTypeStates.Close;
end;

procedure TfrmWebZakazDocDlg.Timer1Timer(Sender: TObject);
begin
  if (dmdb.ibcquerydocs.fieldbyname('responsible_userid').asinteger = 0) and
  (dmdb.ibcquerydocs.state in [dsEdit]) then
  begin
    dmdb.ibcquerydocs.fieldbyname('responsible_userid').AsInteger := dmdb.CurrentUserID;
    dmdb.ibcquerydocs.fieldbyname('responsible_username').AsString := dmdb.CurrentUserFullName;
  end;
  timer1.Enabled := false;
end;

end.

