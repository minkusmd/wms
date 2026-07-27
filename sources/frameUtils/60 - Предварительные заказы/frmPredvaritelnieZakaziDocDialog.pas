unit frmPredvaritelnieZakaziDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Data.DB, DBAccess, IBC, MemDS, Vcl.StdCtrls,
  cxButtonEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.ExtCtrls;

type
  TfrmPredvaritelnieZakaziDocDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    cxLabel8: TLabel;
    deDATA: TcxDBDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    Bevel1: TBevel;
    cxLabel5: TLabel;
    beDT_NAME: TcxButtonEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fReadOnly: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure ShowDocumentCommentsEditorDialog;
    procedure SetReadOnly(const Value: Boolean);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  DateUtils, DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions,
  frmCustomersDlg, SWNSecurityFlags, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, SWNDBErrors, frmCustomerContractsDialog,
  SWNSecurity;

{$R *.dfm}

{ TfrmPredvaritelnieZakaziDocDlg }

procedure TfrmPredvaritelnieZakaziDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmPredvaritelnieZakaziDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with fMasterDataSet do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Дата документа!');
    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика документа!');
    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Организация!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика организации!');
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmPredvaritelnieZakaziDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmPredvaritelnieZakaziDocDlg.BindingDataSource;
begin
  deDATA.DataBinding.DataSource := fMasterDataSource;
  lcbAnalytics.DataBinding.DataSource := fMasterDataSource;
  lcbDTSC.DataBinding.DataSource := fMasterDataSource;
  IBCQueryDocProps.MasterSource := fMasterDataSource;
end;

function TfrmPredvaritelnieZakaziDocDlg.IsFormDataPosted: Boolean;
begin
  Result := fReadOnly;
  if not fReadOnly and CheckParams then
  begin
    fMasterDataSet.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmPredvaritelnieZakaziDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmPredvaritelnieZakaziDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  if not fReadOnly then
    fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    IBCQueryDocProps.Active := True;

    if fCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
             // Append
      fMasterDataSet.Append;

      fMasterDataSet.FieldByName('DOCTYPEID').AsInteger := dmDB.CurrentDocTypeID;
             // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, TIBCQuery(fMasterDataSet), DocumentAdditionalFlags) then
      begin
        fMasterDataSet.FieldByName('SC2').AsInteger := -1;
        fMasterDataSet.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //fMasterDataSet.FieldByName('DTSC').AsInteger:=-1;
        fMasterDataSet.FieldByName('CURRENCYID').AsInteger := 498;
        fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 0;
      end;
      fMasterDataSet.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1);
             // local defaults
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('VAT').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
    end
    else
    begin
      if fReadOnly then
      begin
                  // view ReadOnly
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        pnClient.Enabled := False;
        btnOk.Visible := False;
        btnCancel.Caption := cMSG_ButtonClose;
        btnCancel.Default := True;
      end
      else
      begin
                  // Edit
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dmDB.IBCQueryDocs.Edit;
      end;
      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
    end;

    dmDB.IBCQueryAnalitica.Active := True;
    dmDB.OpenAnalyticsDataSource;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    if not fReadOnly then
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
    CloseAdditionalDataSources;
    raise;
  end;
end;

procedure TfrmPredvaritelnieZakaziDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Выбор организации для Предварительного заказа') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPredvaritelnieZakaziDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmPredvaritelnieZakaziDocDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmPredvaritelnieZakaziDocDlg.SetupSecurityItems;
begin
end;

procedure TfrmPredvaritelnieZakaziDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmPredvaritelnieZakaziDocDlg.WhenCancelForm;
begin
  if not fReadOnly then
  begin
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Cancel;
    dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
  end;
end;

procedure TfrmPredvaritelnieZakaziDocDlg.CloseAdditionalDataSources;
begin
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
end;

end.

