unit frmConfigurationDocDialog;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  SWNBaseUnit,
  Dialogs,
  DialogTitle,
  cxDBEdit,
  cxDBLookupComboBox,
  ExtCtrls,
  Menus,
  StdCtrls,
  cxButtons,
  DB,
  DBAccess,
  IBC,
  cxButtonEdit,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  MemDS,
  cxCheckBox,
  cxCalendar,
  cxMemo,
  cxDropDownEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxTextEdit,
  cxMaskEdit,
  cxCalc,
  dxUIAClasses,
  dxCoreGraphics,
  cxImageComboBox, cxScrollBox,
  frameDocsDeliveryUnit;

type
  TfrmConfigurationDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    IBCQuery1: TIBCQuery;
    cxScrollBox1: TcxScrollBox;
    cxLabel5: TLabel;
    deDATA: TcxDBDateEdit;
    cxLabel1: TLabel;
    beDT_NAME: TcxButtonEdit;
    Bevel1: TBevel;
    cxLabel2: TLabel;
    cxLabel6: TLabel;
    lbContractInfo: TLabel;
    lcbDTSC: TcxDBLookupComboBox;
    lcbDTDEP: TcxDBLookupComboBox;
    beCT_NAME: TcxButtonEdit;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    cxLabel3: TLabel;
    cxLabel8: TLabel;
    Label1: TLabel;
    lbContractTitle: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ceRATE: TcxDBCalcEdit;
    mmCOMMENTS: TcxDBMemo;
    cbFLG_ACNT: TcxDBCheckBox;
    ceRATEUSD: TcxDBCalcEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    beContract: TcxButtonEdit;
    lcbCURRENCY: TcxDBLookupComboBox;
    cbFLG_FURNITURE: TcxDBCheckBox;
    lbCashback: TLabel;
    ceCashback: TcxDBCalcEdit;
    IBCQueryCashback: TIBCQuery;
    IBCDataSourceCashback: TIBCDataSource;
    lblSecDocument: TLabel;
    lblAnaliticaOrg: TLabel;
    lblSecFinante: TLabel;
    bvFinante: TBevel;
    lblSecLivrare: TLabel;
    bvLivrare: TBevel;
    bvMentiuni: TBevel;
    frameDelivery: TframeDocsDelivery;
    procedure beContractKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCTButtonClick(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxDBLookupComboBox1PropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    FNewComment: string;
    fRealRateValue: Double;
    fSECURITY_CanSetupPastDate, fSECURITY_ALLOW_CONTRACT: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SelectCT;
    procedure ShowDocumentCommentsEditorDialog;
    procedure ShowSelectContractDialog;
    procedure SetNewComment(const Value: string);
// TODO: FillTcxDBImageComboBoxItems
//  procedure FillTcxDBImageComboBoxItems(ACombo: TcxDBImageComboBox; ADataSet: TDataSet; const AValueField, ATextField:
//    string; AImageList: TcxImageList; const AImageIndexField: string);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property NewComment: string read FNewComment write SetNewComment;
  end;

implementation

uses
  SWNDealsUnit,
  DateUtils,
  DataModuleDB,
  SWNUtils,
  SWNConst,
  frmCustomersDlg,
  SWNSecurityFlags,
  SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog,
  SWNDBErrors,
  frmCustomerContractsDialog,
  SWNSecurity;

{$R *.dfm}

procedure TfrmConfigurationDocDlg.beContractKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    beContract.Tag := 0;
    beContract.Text := '';
    dmdb.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := -1;
  end;
end;

{ TfrmConfigurationDocDlg }

procedure TfrmConfigurationDocDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectContractDialog;
end;

procedure TfrmConfigurationDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmConfigurationDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmConfigurationDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Data documentului!');

    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica documentului!');

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Organizatia!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica 2!');

    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Client!');

    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Depozit!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Valuta!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Rata documentului!');

    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Rata USD a documentului!');

  end;

//  AskCustomerAboutUs;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmConfigurationDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

function TfrmConfigurationDocDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  try
//        if dmDB.IBCQueryDocs.FieldByName('CTSC').IsNull or (dmDB.IBCQueryDocs.FieldByName('CTSC').AsInteger = -1) then
//            ShowErrorDialog('Chestionar', 'De unde a aflat clientul despre noi ?');

    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Post;

    frameDelivery.PostData(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);

    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;

    if dmDB.IBCQueryDocs.Active then
      dmDB.IBCQueryDocs.UpdateTransaction.Commit;

    Result := True;
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmConfigurationDocDlg.lcbCTButtonClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Alege client') then
    begin
      if dialog.ItemsChanged then
      begin
        dmDB.IBCQueryCustomers.Close;
        dmDB.IBCQueryCustomers.Open;
      end;
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmConfigurationDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
var
  currID: Integer;
  acnt: Boolean;
begin
  if (dmDB.IBCQueryDocs.State in dsEditModes) and (not dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull) then
  begin
    currID := dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger;
    acnt := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1;
    fRealRateValue := dmDB.GetCurrencyExchangeValue(currID, acnt);
    dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := fRealRateValue;
  end;
end;

procedure TfrmConfigurationDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

// TODO: FillTcxDBImageComboBoxItems
//procedure TfrmConfigurationDocDlg.FillTcxDBImageComboBoxItems(ACombo: TcxDBImageComboBox; ADataSet: TDataSet; const
//AValueField, ATextField: string; AImageList: TcxImageList = nil; const AImageIndexField: string = ''  // dacă ai în dataset un câmp cu indexul imaginii
//);
//var
//Bmk: TBookmark;
//Item: TcxImageComboBoxItem;
//ImgIndex: Integer;
//begin
//if ACombo = nil then
//  Exit;
//if ADataSet = nil then
//  raise EArgumentNilException.Create('ADataSet is nil');
//if (AValueField = '') or (ATextField = '') then
//  raise EArgumentException.Create('AValueField / ATextField cannot be empty');
//
//// Setări vizuale opționale
//if AImageList <> nil then
//  ACombo.Properties.Images := AImageList;
//
//ACombo.Properties.Items.BeginUpdate;
//try
//  ACombo.Properties.Items.Clear;
//
//  if not ADataSet.Active then
//    ADataSet.Open;
//
//  Bmk := ADataSet.GetBookmark;
//  try
//    ADataSet.DisableControls;
//    try
//      ADataSet.First;
//      while not ADataSet.Eof do
//      begin
//        Item := ACombo.Properties.Items.Add;
//
//        // Value: ce se scrie în câmpul DB legat (Key)
//        Item.Value := ADataSet.FieldByName(AValueField).Value;
//
//        // Description: ce vede utilizatorul
//        Item.Description := ADataSet.FieldByName(ATextField).AsString;
//
//        // ImageIndex (opțional)
//        ImgIndex := -1;
//        if (AImageList <> nil) then
//        begin
//          if (AImageIndexField <> '') and (ADataSet.FindField(AImageIndexField) <> nil) then
//            ImgIndex := ADataSet.FieldByName(AImageIndexField).AsInteger
//          else
//            ImgIndex := -1; // sau calculezi tu după reguli
//        end;
//        Item.ImageIndex := ImgIndex;
//
//        ADataSet.Next;
//      end;
//    finally
//      ADataSet.EnableControls;
//    end;
//  finally
//    if Bmk <> nil then
//    begin
//      ADataSet.GotoBookmark(Bmk);
//      ADataSet.FreeBookmark(Bmk);
//    end;
//  end;
//
//finally
//  ACombo.Properties.Items.EndUpdate;
//end;
//end;

procedure TfrmConfigurationDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  ActiveControl := beCT_NAME;

  dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryStocks.Active := True;

    IBCQueryDocProps.Active := True;

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

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName
        ('FLG_ACNT').AsInteger = 1);

             // local defaults
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('VAT').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := Now;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      if beCT_NAME.Tag > 0 then
      begin
        dmDB.IBCQueryDocs.FieldByName('CT').AsInteger := beCT_NAME.Tag;
        dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString := beCT_NAME.Text;
      end
      else
      begin
        beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);
        beCT_NAME.Tag := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      end;

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
      IBCQueryDocProps.Append;
      IBCQueryDocProps.FieldByName('COMMENTS').AsString := NewComment;
    end
    else
    begin
      dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
             // Edit
      dmDB.IBCQueryDocs.Edit;

      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;

      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      beCT_NAME.Tag := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;

      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName
        ('FLG_ACNT').AsInteger = 1);

      if not dmDB.IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
      begin
        beContract.Text := Format('%s (№%s din %s)', [dmDB.IBCQueryDocs.FieldByName('CONTRACT_TYPE_TITLE').AsString,
          dmDB.IBCQueryDocs.FieldByName('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy', dmDB.IBCQueryDocs.FieldByName
          ('CONTRACT_SIGN_DATE').AsDateTime)]);
                  // ??? daca cumva acest document are contract, aratam info fortat
        if not fSECURITY_ALLOW_CONTRACT then
        begin
          lbContractTitle.Visible := True;
          beContract.Visible := True;
        end;
      end
      else
        beContract.Text := '';
    end;

    // cashback folosit in comanda de pe site (TDB_DOCS_CASHBACK_USED) - doar la afisare, cind exista
    IBCQueryCashback.Close;
    lbCashback.Visible := False;
    ceCashback.Visible := False;
    if not fCreateNewDocument then
    begin
      IBCQueryCashback.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
      IBCQueryCashback.Open;
      lbCashback.Visible := not IBCQueryCashback.IsEmpty;
      ceCashback.Visible := lbCashback.Visible;
    end;

    dmDB.IBCQueryAnalitica.Active := True;
    dmDB.IBCQuerySYSSList.ParambyName('PARENTID').AsInteger := 46;
    dmDB.IBCQuerySYSSList.Active := True;

    dmDB.OpenAnalyticsDataSource;

    frameDelivery.ReadOnly := False;
    frameDelivery.PrepareData(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);

//    FillTcxDBImageComboBoxItems(cxDBImageComboBox1, FDQueryDocTypes, 'DOCTYPEID', 'TITLE', cxImageList1, 'IMG_INDEX');

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
  AttachDealToDialog(Self, dmDB.IBCQueryDocs);
end;

procedure TfrmConfigurationDocDlg.SelectCT;
var
  ContractCurrencyID: Integer;
  ContractID: Integer;
  ContractName: string;
  dialog: TfrmCustomersDlg;
  FlgAcnt: boolean;
  ok: Boolean;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if ((beCT_NAME.Text <> '') and (beCT_NAME.Tag < 1)) then
      ok := dialog.SelectCustomerBySearch(beCT_NAME.Text, 'Selecteaza platitorul')
    else
      ok := dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, False, 0, 'Selecteaza platitorul');

    if ok then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
      beCT_NAME.Tag := dialog.CustomerID;

      if fSECURITY_ALLOW_CONTRACT then
      begin
        dmDB.LoadDefaultContract(dialog.CustomerID, dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime, ContractID,
          ContractName, FlgAcnt, ContractCurrencyID);
        if ContractID > 0 then
        begin
          dmDB.IBCQueryDocs.FieldByName('CONTRACTID').asInteger := ContractID;
          dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger := ContractCurrencyID;
          beContract.Text := ContractName;
          beContract.Tag := ContractID;
          cbFLG_ACNT.Checked := FlgAcnt;
          lbContractInfo.Visible := True;
        end
        else
        begin
          dmDB.IBCQueryDocs.FieldByName('CONTRACTID').Value := Null;
          beContract.Text := ContractName;
          lbContractInfo.Visible := False;
        end;

      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmConfigurationDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Alege organizatia') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmConfigurationDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmConfigurationDocDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := False;

     // Contract
  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Показывать_Контракт);
  if not fSECURITY_ALLOW_CONTRACT then
  begin
    lbContractTitle.Visible := False;
    beContract.Visible := False;
    lbContractInfo.Visible := False;
    beContract.Properties.Buttons.Clear;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Контракты_Администрирование) then
    beContract.Properties.Buttons.Clear;

  lcbDTSC.Enabled := SWNSecurityManager.LoggedUser.IsInAdminGroup;
end;

procedure TfrmConfigurationDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmConfigurationDocDlg.ShowSelectContractDialog;
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy',
      contractInfo.SignDate)]);
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    lbContractInfo.Visible := True;
    if contractInfo.FLG_ACNT then
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
  end
end;

procedure TfrmConfigurationDocDlg.WhenCancelForm;
begin
  frameDelivery.CancelData;

  dmdb.QueryCancelUpdate(IBCQueryDocProps);
  dmdb.QueryCancelUpdate(dmDB.IBCQueryDocs);

  if dmDB.IBCQueryDocs.UpdateTransaction.Active then
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmConfigurationDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  frameDelivery.CloseData;
  IBCQueryCashback.Close;
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
  dmDB.IBCQueryStocks.FilterSQL := '';
end;

procedure TfrmConfigurationDocDlg.cxDBLookupComboBox1PropertiesValidate(Sender: TObject; var DisplayValue: Variant; var
  ErrorText: TCaption; var Error: Boolean);
begin
  Error := False;
  if DisplayValue = '' then
  begin
    ErrorText := 'Indicati de unde a aflat clientul despre noi!';
    Error := True;
  end
end;

procedure TfrmConfigurationDocDlg.SetNewComment(const Value: string);
begin
  FNewComment := Value;
end;

end.

