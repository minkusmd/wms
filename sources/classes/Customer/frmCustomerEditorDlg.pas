unit frmCustomerEditorDlg;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, cxGraphics,
    DBAccess, IBC, MemDS, StdCtrls, cxDBEdit, cxDBLookupComboBox, cxDropDownEdit, ComCtrls, cxDBLabel, cxCustomData,
    cxGridDBTableView, cxGridLevel, cxGrid, cxButtons, dxBar, frameCustomerEventsUnit, cxPC, frameCustomerPhonesUnit,
    frameCustomerAddressUnit, Data.DB, frameCustomerEmailUnit, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
    cxEdit, Vcl.Menus, dxBarBuiltInMenu, cxStyles, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges,
    dxScrollbarAnnotations, cxDBData, System.ImageList, Vcl.ImgList, cxImageList, cxClasses, cxGridCustomTableView,
    cxGridTableView, cxGridCustomView, cxButtonEdit, cxLabel, cxMemo, cxCheckBox, cxCalendar, cxMaskEdit, cxLookupEdit,
    cxDBLookupEdit, cxTextEdit, dxStatusBar, Vcl.WinXPanels, Vcl.ExtCtrls, Vcl.CheckLst, Vcl.Buttons, dxUIAClasses,
  cxCalc;

type
    TfrmCustomerEditorDialog = class(TSWNMasteredFormClass)
        dtDialogTitle: TDialogTitle;
        pcPageControl: TPageControl;
        tbsGeneral: TTabSheet;
        cxLabel15: TLabel;
        cxLabel16: TLabel;
        cmbCustomerType: TcxDBLookupComboBox;
        cmbCustomerStatus: TcxDBLookupComboBox;
        IBCQueryCity: TIBCQuery;
        IBCDataSourceCity: TIBCDataSource;
        IBCQueryCustomerType: TIBCQuery;
        IBCDataSourceCustomerType: TIBCDataSource;
        IBCQueryCustomerStatus: TIBCQuery;
        IBCDataSourceCustomerStatus: TIBCDataSource;
        tbsClientPrices: TTabSheet;
        lbLogPriceColumn: TLabel;
        cxGridLogPCTable: TcxGridDBTableView;
        cxGridLogPCLevel: TcxGridLevel;
        cxGridLogPC: TcxGrid;
        cxGridLogPC_DATA_CHANGED: TcxGridDBColumn;
        cxGridLogPC_USER_NAME: TcxGridDBColumn;
        cxGridLogPC_CHANGES: TcxGridDBColumn;
        IBCQueryLogPC: TIBCQuery;
        IBCDataSourceLogPC: TIBCDataSource;
        dxBarManager1: TdxBarManager;
        dxBarButtonNewPhone: TdxBarButton;
        dxBarButton1: TdxBarButton;
        dxBarButton2: TdxBarButton;
        Label2: TLabel;
        edWEBPAGE: TcxDBTextEdit;
        cxPageControl1: TcxPageControl;
        tbsCustomerEvents: TcxTabSheet;
        tbsComunicationTypes: TcxTabSheet;
        tbsAddr: TcxTabSheet;
        cxImageList1: TcxImageList;
        tsEmail: TcxTabSheet;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        dxStatusBar1: TdxStatusBar;
        cxButton1: TcxButton;
        cxLabel17: TLabel;
        cmbPriceColumn: TcxDBComboBox;
        frameCustomerPhones1: TframeCustomerPhones;
        frameCustomerAddr1: TframeCustomerAddr;
        frameCustomerEMail1: TframeCustomerEMail;
        frameCustomerEvents1: TframeCustomerEvents;
    ceRRPDiscount: TcxDBCalcEdit;
    Label4: TLabel;
    cxButton2: TcxButton;
    deBIRTH_DATE: TcxDBDateEdit;
    Label1: TLabel;
    Label6: TLabel;
    cbGender: TcxDBComboBox;
    Label7: TLabel;
    edName: TcxDBTextEdit;
    btnDeleteSufix: TcxButton;
    cxLabel18: TLabel;
    cmbVAT: TcxDBComboBox;
    cxLabel7: TLabel;
    cxLabel8: TLabel;
    cxLabel10: TLabel;
    cxLabel11: TLabel;
    btnGetSFSData: TSpeedButton;
    cbRezident: TcxDBCheckBox;
    edChief: TcxDBTextEdit;
    edAccountant: TcxDBTextEdit;
    edIDEN: TcxDBTextEdit;
    edVAT: TcxDBTextEdit;
    cbsFurnizor: TcxDBCheckBox;
    cbsCumparator: TcxDBCheckBox;
        procedure cxButton1Click(Sender: TObject);
        procedure FormActivate(Sender: TObject);
        procedure frameCustomerAddrUnit1IBCQueryCustomerAddrBeforePost(DataSet: TDataSet);
        procedure edIDENPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error:
            Boolean);
        procedure cmbCustomerTypePropertiesChange(Sender: TObject);
        procedure teNumeOrganizatiePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
            var Error: Boolean);
        procedure cxButton2Click(Sender: TObject);
    procedure btnDeleteSufixClick(Sender: TObject);
        procedure btnGetSFSDataClick(Sender: TObject);
    private    { Private declarations }
        fCreateNewRecord: Boolean;
        fCustomerID: Integer;
        fParentID: Integer;
        fReadOnly: Boolean;
        FLocalUpdateTransaction: TIBCTransaction;
        procedure SetCustomerID(const Value: Integer);
        procedure SetCreateNewRecord(const Value: Boolean);
        procedure SetParentID(const Value: Integer);
        function GetParentTypeID(const CustomerID: Integer): Integer;
        function CheckParams: Boolean;
        procedure BuildPriceColumnList;
        procedure SetReadOnly(const Value: Boolean);
        procedure SetLocalUpdateTransaction(const Value: TIBCTransaction);
        procedure SetFieldName;
        procedure SplitFieldName;
        procedure PrepareNewRecord;
        procedure PrepareEditRecord;
        procedure PrepareCustomerAdditionalData;
    protected
        function CheckCustomerHasPhoneNumber: Boolean;
    { Protected declarations }
        procedure BindingDataSource; override;
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
        procedure SetupSecurityItems; override;
        function ValidateFiscalCode(IDNO: string): Boolean;
    public    { Public declarations }
        property CreateNewRecord: Boolean write SetCreateNewRecord;
        property ParentID: Integer write SetParentID;
        property CustomerID: Integer read fCustomerID write SetCustomerID;
        property readonly: Boolean read fReadOnly write SetReadOnly;
        property LocalUpdateTransaction: TIBCTransaction read FLocalUpdateTransaction write SetLocalUpdateTransaction;
    end;

implementation

uses
    SWNUtils, SWNConst, SWNSecurityFlags, SWNSecurity, frmCustomerCommentsV2Dialog, DataModuleDB, SWNDBErrors,
    System.StrUtils, EFacturaApiClient, EFacturaManager;

{$R *.dfm}
{ TfrmCustomerEditorDialog }

procedure TfrmCustomerEditorDialog.btnDeleteSufixClick(Sender: TObject);
begin
  MasterDataSet.FieldByName('SufixName').AsString := '';
end;

procedure TfrmCustomerEditorDialog.BuildPriceColumnList;
begin
    cmbPriceColumn.Properties.Items.Clear;
//    if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_1) then
    cmbPriceColumn.Properties.Items.Add('1');
//    if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_2) then
//        cmbPriceColumn.Properties.Items.Add('2');
//    if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_3) then
//        cmbPriceColumn.Properties.Items.Add('3');
//    if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_4) then
//        cmbPriceColumn.Properties.Items.Add('4');
    cmbPriceColumn.Properties.Items.Add('5');
    if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_6) then
        cmbPriceColumn.Properties.Items.Add('6');
    if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_7) then
        cmbPriceColumn.Properties.Items.Add('7');
    if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_0) then
        cmbPriceColumn.Properties.Items.Add('0');
end;

function TfrmCustomerEditorDialog.CheckCustomerHasPhoneNumber: Boolean;
var
    I: Integer;
begin
    Result := False;
    for I := 0 to frameCustomerPhones1.cxGridDBTableView1.DataController.RowCount - 1 do
    begin
        if VarToStr(frameCustomerPhones1.cxGridDBTableView1.DataController.Values[I, frameCustomerPhones1.cxGridDBTableView1_NUMAR_TELEFON.Index])
            <> '' then
        begin
            Result := True;
            Break;
        end
    end;
end;

function TfrmCustomerEditorDialog.CheckParams: Boolean;
var
    ErrorStr: string;
begin
    Result := False;
    ErrorStr := '';
    // base info
    //    if fMasterDataSet.FieldByName('NAME').IsNull then
    //        AddErrorToStr(ErrorStr, 'Nume client!');
    if fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').IsNull or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').asInteger <=
        0) then
        AddErrorToStr(ErrorStr, 'Tip client!');
    if fMasterDataSet.FieldByName('CUSTOMER_STATUS_ID').IsNull or (fMasterDataSet.FieldByName('CUSTOMER_STATUS_ID').asInteger
        <= 0) then
        AddErrorToStr(ErrorStr, 'Statut client!');
    // additional info
    // phones
    //  if frameCustomerPhones1.IBCQueryCustomerPhones.RecordCount<=0 then
    if not CheckCustomerHasPhoneNumber then
        AddErrorToStr(ErrorStr, 'Indicati un numar de telefon!');

    if fMasterDataSet.FieldByName('CITY_ID').IsNull then
        fMasterDataSet.FieldByName('CITY_ID').AsInteger := 2000;
    //        AddErrorToStr(ErrorStr, 'Indicat orasul!');

    if fMasterDataSet.FieldByName('REZIDENT').IsNull then
        fMasterDataSet.FieldByName('REZIDENT').AsString := 'R';
//        AddErrorToStr(ErrorStr, 'Rezident ?');
  // price
    if fMasterDataSet.FieldByName('PRICECOLUMN').IsNull then
        fMasterDataSet.FieldByName('PRICECOLUMN').AsInteger := 4;
//        AddErrorToStr(ErrorStr, 'Grila de preturi!');

    if fMasterDataSet.FieldByName('VAT').IsNull then
        AddErrorToStr(ErrorStr, 'cota TVA!');

    if fMasterDataSet.FieldByName('PREFIXNAME').asString = '' then
        fMasterDataSet.FieldByName('PREFIXNAME').Value := Null;
    if fMasterDataSet.FieldByName('SUFIXNAME').asString = '' then
        fMasterDataSet.FieldByName('SUFIXNAME').Value := Null;

//    if not ValidateFiscalCode(fMasterDataSet.FieldByName('IDEN_NUMBER').asString) then
//      AddErrorToStr(ErrorStr, 'Acest cod fiscal este setat la un alt client');

    if ErrorStr = '' then
        Result := True
    else
        ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmCustomerEditorDialog.cmbCustomerTypePropertiesChange(Sender: TObject);
begin
    // persoane fizice sau angajati
    if (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4010) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger
        = 4006) then
    begin
//        CardPanel1.ActiveCard := CardPF;
//        teNume.Text := '';//fMasterDataSet.FieldByName('NAME').AsString;
//        tePrenume.Text := '';
//    ActiveControl := teNume;
    end;
   // Persoana juridica
    if (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4011) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger
        = 4012) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4002) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger
        = 4013) then
    begin
//        CardPanel1.ActiveCard := CardPJ;
//    ActiveControl := edName;
    end;

end;

procedure TfrmCustomerEditorDialog.cxButton1Click(Sender: TObject);
var
    dialog: TfrmCustomerCommentsV2Dlg;
begin
    dialog := TfrmCustomerCommentsV2Dlg.Create(Self);
    try
        dialog.CustomerID := fMasterDataSet.FieldByName('CUSTOMERID').asInteger;
        dialog.AutoCommit := True;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmCustomerEditorDialog.cxButton2Click(Sender: TObject);
var
    f: integer;
    cf: string;
begin
    f := Random(1000000000);
    cf := '200' + IntToStr(f);
    if fMasterDataSet.State in [dsEdit, dsInsert] then
        fMasterDataSet.FieldByName('IDEN_NUMBER').AsString := cf;
end;

procedure TfrmCustomerEditorDialog.edIDENPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText:
    TCaption; var Error: Boolean);
var
    Iden: string;
begin
    Error := False;
    Iden := VarToStr(DisplayValue);
    if not IsStrANumber(Iden) and (length(Iden) <= 12) then
    begin
        ErrorText := 'Codul Fiscal Trebuie sa contina doar cifre si nu mai mult de 12 caractere!';
        Error := True;
    end;
end;

procedure TfrmCustomerEditorDialog.FormActivate(Sender: TObject);
begin
    cxPageControl1.ActivePageIndex := 1;
end;

procedure TfrmCustomerEditorDialog.frameCustomerAddrUnit1IBCQueryCustomerAddrBeforePost(DataSet: TDataSet);
begin
    DataSet.FieldByName('CUSTOMERID').AsInteger := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
end;

procedure TfrmCustomerEditorDialog.BindingDataSource;
begin
    inherited;

//    lbUSER_NAME.DataBinding.DataSource := fMasterDataSource;
  // Generale
//    edPrefix.DataBinding.DataSource := fMasterDataSource;
    edName.DataBinding.DataSource := fMasterDataSource;
//    teCustomerName.DataBinding.DataSource := fMasterDataSource;
//    edSufix.DataBinding.DataSource := fMasterDataSource;
    cmbCustomerType.DataBinding.DataSource := fMasterDataSource;
    cmbCustomerStatus.DataBinding.DataSource := fMasterDataSource;

  // Contacte
//    cmbCity.DataBinding.DataSource := fMasterDataSource;
    cbRezident.DataBinding.DataSource := fMasterDataSource;
//    mmAddress.DataBinding.DataSource := fMasterDataSource;
    deBIRTH_DATE.DataBinding.DataSource := fMasterDataSource;
    edWEBPAGE.DataBinding.DataSource := fMasterDataSource;
  // Persoana juridica
    edChief.DataBinding.DataSource := fMasterDataSource;
    edAccountant.DataBinding.DataSource := fMasterDataSource;
    edIDEN.DataBinding.DataSource := fMasterDataSource;
    edVAT.DataBinding.DataSource := fMasterDataSource;
//    mmADDRESS2.DataSource := fMasterDataSource;
  // Preturi
    cmbPriceColumn.DataBinding.DataSource := fMasterDataSource;
    cmbVAT.DataBinding.DataSource := fMasterDataSource;

    cbGender.DataBinding.DataSource := fMasterDataSource;

    cbsFurnizor.DataBinding.DataSource := fMasterDataSource;
    cbsCumparator.DataBinding.DataSource := fMasterDataSource;
//    teCodFiscalPF.DataBinding.DataSource := fMasterDataSource;
    ceRRPDiscount.DataBinding.DataSource := fMasterDataSource;

    pcPageControl.ActivePageIndex := 0;

end;

function TfrmCustomerEditorDialog.IsFormDataPosted: Boolean;
begin
    if CheckParams then
    begin
        if fCreateNewRecord and (not fMasterDataSet.FieldByName('IDEN_NUMBER').IsNull) and (not fMasterDataSet.FieldByName('VAT_NUMBER').IsNull)
            then
            fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').asInteger := 4011;

        SetFieldName;

        fMasterDataSet.FieldByName('PREFIXNAME').AsString := '';

        if (fMasterDataSet.State in dsEditModes) then
            fMasterDataSet.Post;

    // Phones
        try
            if frameCustomerPhones1.IBCQueryCustomerPhones.State in (dsEditModes) then
            begin
                frameCustomerPhones1.IBCQueryCustomerPhones.FieldByName('customerid').AsInteger := fCustomerID;
                frameCustomerPhones1.IBCQueryCustomerPhones.Post;
            end;

            frameCustomerPhones1.IBCQueryCustomerPhones.ApplyUpdates;
            frameCustomerPhones1.IBCQueryCustomerPhones.CommitUpdates;

        except
            on E: Exception do
            begin
                frameCustomerPhones1.IBCQueryCustomerPhones.CancelUpdates;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    // Events
        try
            if frameCustomerEvents1.IBCQueryCustomerEvents.State in (dsEditModes) then
            begin
                frameCustomerEvents1.IBCQueryCustomerEvents.FieldByName('customerid').AsInteger := fCustomerID;
                frameCustomerEvents1.IBCQueryCustomerEvents.Post;
            end;

            frameCustomerEvents1.IBCQueryCustomerEvents.ApplyUpdates;
            frameCustomerEvents1.IBCQueryCustomerEvents.CommitUpdates;
        except
            on E: Exception do
            begin

                frameCustomerEvents1.IBCQueryCustomerEvents.CancelUpdates;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    // Addresses
        try
            if frameCustomerAddr1.IBCQueryCustomerAddr.State in (dsEditModes) then
            begin
                frameCustomerAddr1.IBCQueryCustomerAddr.FieldByName('customerid').AsInteger := fCustomerID;
                frameCustomerAddr1.IBCQueryCustomerAddr.Post;
            end;
         // flush cache

            frameCustomerAddr1.IBCQueryCustomerAddr.ApplyUpdates;
            frameCustomerAddr1.IBCQueryCustomerAddr.CommitUpdates;
        except
            on E: Exception do
            begin
                frameCustomerAddr1.IBCQueryCustomerAddr.CancelUpdates;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
       // EMail
        try
            if frameCustomerEMail1.IBCQueryCustomerEMail.State in (dsEditModes) then
            begin
                frameCustomerEMail1.IBCQueryCustomerEMail.FieldByName('customerid').asinteger := fcustomerid;
                frameCustomerEMail1.IBCQueryCustomerEMail.Post;
            end;

         // flush cache
            frameCustomerEMail1.IBCQueryCustomerEMail.ApplyUpdates;
            frameCustomerEMail1.IBCQueryCustomerEMail.CommitUpdates;
        except
            on E: Exception do
            begin
                frameCustomerEMail1.IBCQueryCustomerEMail.CancelUpdates;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;

        try
            if LocalUpdateTransaction.Active then
                LocalUpdateTransaction.Commit;
        except
            on E: Exception do
            begin
                LocalUpdateTransaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
        frameCustomerPhones1.IBCQueryCustomerPhones.Close;
        frameCustomerEvents1.IBCQueryCustomerEvents.Close;
        frameCustomerEMail1.IBCQueryCustomerEMail.Close;

        Result := True;
    end
    else
        Result := False;
end;

procedure TfrmCustomerEditorDialog.Prepare;
begin
    BuildPriceColumnList;

    IBCQueryCustomerType.Active := True;
    IBCQueryCustomerStatus.Active := True;
    IBCQueryCity.Active := True;

    btnOk.Visible := not fReadOnly;
    tbsGeneral.Enabled := not fReadOnly;
//  tbsContacts.Enabled := not fReadOnly;
//    tbsJuridic.Enabled := not fReadOnly;
    tbsClientPrices.TabVisible := tbsClientPrices.TabVisible and (not fReadOnly);

    if not fReadOnly then
        LocalUpdateTransaction.StartTransaction;
    try
        if fCreateNewRecord then
        begin
            PrepareNewRecord;
        end
        else
        begin
            PrepareEditRecord;
        end;

        PrepareCustomerAdditionalData;

//        if (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4010) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger
//            = 4006) then
//        begin
////            CardPanel1.ActiveCard := CardPF;
//            ActiveControl := teNume;
//        end;
//     // Persoana juridica
//        if (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4011) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger
//            = 4012) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4002) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger
//            = 4013) then
//        begin
//            if self.visible then
//            begin
////                CardPanel1.ActiveCard := CardPJ;
//                ActiveControl := edName;
//            end;
//        end;

        dxStatusBar1.Panels[0].Text := 'Creat de: ' + fMasterDataSet.FieldByName('USER_NAME').AsString
    except
        if not fReadOnly then
        begin
            fMasterDataSet.Cancel;
            LocalUpdateTransaction.Rollback;
        end;
        raise;
    end;
end;

procedure TfrmCustomerEditorDialog.SetCreateNewRecord(const Value: Boolean);
begin
    fCreateNewRecord := Value;
end;

procedure TfrmCustomerEditorDialog.SetCustomerID(const Value: Integer);
begin
    fCustomerID := Value;
end;

procedure TfrmCustomerEditorDialog.SetParentID(const Value: Integer);
begin
    fParentID := Value;
end;

procedure TfrmCustomerEditorDialog.SetReadOnly(const Value: Boolean);
begin
    fReadOnly := Value;
end;

function TfrmCustomerEditorDialog.GetParentTypeID(const CustomerID: Integer): Integer;
var
    Query: TIBCQuery;
begin
    Result := -1;
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := fIBCConnection;
        Query.SQL.Text := 'SELECT CUSTOMER_TYPE_ID FROM TS_CUSTOMER WHERE CUSTOMERID=:CustomerID';
        Query.ParamByName('CustomerID').asInteger := CustomerID;
        Query.ExecSQL;
        if not Query.Eof then
            Result := Query.Fields[0].asInteger;
        Query.Close;
    finally
        Query.Free;
    end;
end;

procedure TfrmCustomerEditorDialog.SetLocalUpdateTransaction(const Value: TIBCTransaction);
begin
    FLocalUpdateTransaction := Value;
end;

procedure TfrmCustomerEditorDialog.SetupSecurityItems;
var
    b: Boolean;
begin
  // price tab
    tbsClientPrices.TabVisible := SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Колонка_цен_клиента);

    if fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4006 then
    begin
    // daca clientul e de tip angagat atuni nu poate fi modificate datele lor decit de admingroup
        b := SWNSecurityManager.LoggedUser.IsInAdminGroup;
        cmbCustomerType.Enabled := b;
        frameCustomerEvents1.Enabled := b;
        frameCustomerPhones1.Enabled := b;
    end;

    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Редактировать_свои_организации) then
    begin
//        tbsGeneral.Enabled := False;
//        edName.Properties.ReadOnly := True;
//        cbRezident.Properties.ReadOnly := True;
//        edSufix.Properties.ReadOnly := True;
//        edChief.Properties.ReadOnly := True;
//        edAccountant.Properties.ReadOnly := True;
//        edIDEN.Properties.ReadOnly := True;
//        edVAT.Properties.ReadOnly := True;
//        cmbPriceColumn.Properties.ReadOnly := True;
//        cmbVAT.Properties.ReadOnly := True;
    end;

    b := SWNSecurityManager.LoggedUser.IsInAdminGroup;
    cmbCustomerType.Enabled := b;

    if not b then
    begin
        cxGridLogPC.Visible := False;
        lbLogPriceColumn.Visible := False;
        cmbCustomerStatus.Enabled := True;
    end;

    // evenimente client
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Date_importate_pentru_client_Nou) then
        frameCustomerEvents1.bbNewCustomerEvent.Visible := ivNever;
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Date_importate_pentru_client_Modifica) then
        frameCustomerEvents1.bbEditCustomerEvent.Visible := ivNever;
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Date_importate_pentru_client_Sterge) then
        frameCustomerEvents1.bbDeleteCustomerEvent.Visible := ivNever;

  // numere si tipuri de telefon
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Date_importate_pentru_client_Nou) then
        frameCustomerEvents1.bbNewCustomerEvent.Visible := ivNever;
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Date_importate_pentru_client_Modifica) then
        frameCustomerEvents1.bbEditCustomerEvent.Visible := ivNever;
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Date_importate_pentru_client_Sterge) then
        frameCustomerEvents1.bbDeleteCustomerEvent.Visible := ivNever;
end;

procedure TfrmCustomerEditorDialog.PrepareCustomerAdditionalData;
begin
    SplitFieldName;

    CustomerID := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    frameCustomerPhones1.IBCQueryCustomerPhones.Transaction := dmDB.IBCTrDefaultSelect;
    frameCustomerPhones1.IBCQueryCustomerPhones.UpdateTransaction := LocalUpdateTransaction;
    frameCustomerPhones1.IBCQueryCustomerPhones.ParamByName('CUSTOMERID').AsInteger := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    frameCustomerPhones1.CustomerID := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    frameCustomerPhones1.IBCQueryCustomerPhones.CachedUpdates := true;
    frameCustomerPhones1.IBCQueryCustomerPhones.Open;
  // Data evenimentelor importante a clientului
    frameCustomerEvents1.IBCQueryCustomerEvents.Transaction := dmDB.IBCTrDefaultSelect;
    frameCustomerEvents1.IBCQueryCustomerEvents.UpdateTransaction := LocalUpdateTransaction;
    frameCustomerEvents1.IBCQueryCustomerEvents.ParamByName('CUSTOMERID').AsInteger := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    frameCustomerEvents1.CustomerID := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    frameCustomerEvents1.IBCQueryCustomerEvents.Open;
  // Adresele clientilor
    frameCustomerAddr1.IBCQueryCustomerAddr.Transaction := dmDB.IBCTrDefaultSelect;
    frameCustomerAddr1.IBCQueryCustomerAddr.UpdateTransaction := LocalUpdateTransaction;
    frameCustomerAddr1.IBCQueryCustomerAddr.ParamByName('CUSTOMERID').AsInteger := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    frameCustomerAddr1.CustomerID := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    frameCustomerAddr1.IBCQueryCustomerAddr.Open;
  // EMail-uri
    frameCustomerEMail1.IBCQueryCustomerEMail.Transaction := dmDB.IBCTrDefaultSelect;
    frameCustomerEMail1.IBCQueryCustomerEMail.UpdateTransaction := LocalUpdateTransaction;
    frameCustomerEMail1.IBCQueryCustomerEMail.ParamByName('CUSTOMERID').AsInteger := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    frameCustomerEMail1.CustomerID := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    frameCustomerEMail1.IBCQueryCustomerEMail.Open;
end;

procedure TfrmCustomerEditorDialog.PrepareEditRecord;
begin
    if fReadOnly then
    begin
        dtDialogTitle.Text := 'Vizualizare date';
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
    end
    else
    begin
        dtDialogTitle.Text := 'Modificare date';
        fMasterDataSet.Edit;
        if SWNSecurityManager.LoggedUser.IsInAdminGroup then
        begin
            IBCQueryLogPC.ParamByName('ID').asInteger := fMasterDataSet.FieldByName('CUSTOMERID').asInteger;
            IBCQueryLogPC.Active := True;
        end;
//    ActiveControl := edName;
    end;
end;

procedure TfrmCustomerEditorDialog.PrepareNewRecord;
begin
    dtDialogTitle.Text := 'Creare client nou';
    fMasterDataSet.Insert;
  // default values
    fMasterDataSet.FieldByName('FLG_FOLDER').asInteger := 0;
    fMasterDataSet.FieldByName('PARENTID').asInteger := fParentID;
    fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').asInteger := GetParentTypeID(fParentID);
    if fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').asInteger = -1 then
        fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').asInteger := 4010;
  // Clienti Fizice
    fMasterDataSet.FieldByName('CUSTOMER_STATUS_ID').asInteger := 4101;
  // Client obisnuit
    fMasterDataSet.FieldByName('CITY_ID').asInteger := 2000;
    fMasterDataSet.FieldByName('PRICECOLUMN').asInteger := 4;
    fMasterDataSet.FieldByName('VAT').asInteger := 20;
    fMasterDataSet.FieldByName('REZIDENT').asString := 'R';
    fMasterDataSet.FieldByName('FLG_FURNIZOR').asInteger := iif(fMasterDataSet.FieldByName('parentid').AsInteger = 227869, 1, 0);
    fMasterDataSet.FieldByName('FLG_CUMPARATOR').asInteger := iif(fMasterDataSet.FieldByName('parentid').AsInteger = 227869,
        0, 1);
//  ActiveControl := edName;
  // 02.02.2012
//    edPrefix.Enabled := False;
end;

procedure TfrmCustomerEditorDialog.SplitFieldName;
begin
//    if (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4010) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger
//        = 4006) then
//    begin
//        if (pos(' ', trim(fMasterDataSet.FieldByName('NAME').AsString)) > 0) then
//        begin
//            teNume.Text := Copy(MasterDataSet.FieldByName('NAME').AsString, 1, pos(' ', trim(fMasterDataSet.FieldByName('NAME').AsString))
//                - 1);
//            tePrenume.Text := Copy(fMasterDataSet.FieldByName('NAME').AsString, Pos(' ', fMasterDataSet.FieldByName('NAME').AsString)
//                + 1, Length(fMasterDataSet.FieldByName('NAME').AsString));
//        end
//        else
//            teNume.Text := trim(fMasterDataSet.FieldByName('NAME').AsString);
//    end
end;

procedure TfrmCustomerEditorDialog.teNumeOrganizatiePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var
    ErrorText: TCaption; var Error: Boolean);
begin
    if VarToStr(DisplayValue) = '' then
    begin
        ErrorText := 'Denumirea trebuie completata!';
        Error := True;
    end;
end;

procedure TfrmCustomerEditorDialog.SetFieldName;
begin
//  // persoana fizica si angajati
//    if (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4010) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger
//        = 4006) then
//    begin
//        fMasterDataSet.FieldByName('NAME').AsString := teNume.Text + ' ' + tePrenume.Text;
//    end;
//  // Persoana juridica
//    if (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4011) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger
//        = 4012) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4002) or (fMasterDataSet.FieldByName('CUSTOMER_TYPE_ID').AsInteger
//        = 4013) then
//    begin
////    fMasterDataSet.FieldByName('NAME').AsString := teNumeOrganizatie.Text;
//    end;
end;

function TfrmCustomerEditorDialog.ValidateFiscalCode(IDNO: string): Boolean;
var
    q: TIBCQuery;
begin
    if (IDNO = '') then
    begin
        Result := True;
    end
    else
    begin
        Result := False;
        q := TIBCQuery.Create(self);
        try
            q.SQL.Text := 'select customerid from ts_cust_info where iden_number=:iden_number and customerid <> :customerid';
            q.ParamByName('iden_number').AsString := IDNO;
            q.ParamByName('customerid').AsInteger := fMasterDataSet.FieldByName('customerid').AsInteger;
            q.Open;
            Result := (q.RecordCount <= 1);
        finally
            q.Free;
        end;
    end;
end;

procedure TfrmCustomerEditorDialog.WhenCancelForm;
begin
    if not fReadOnly then
    begin
        if frameCustomerPhones1.IBCQueryCustomerPhones.State in [dsEdit, dsInsert] then
        begin
            frameCustomerPhones1.IBCQueryCustomerPhones.CancelUpdates;
            frameCustomerPhones1.IBCQueryCustomerPhones.Cancel;
        end;

        if frameCustomerEvents1.IBCQueryCustomerEvents.State in [dsEdit, dsInsert] then
        begin
            frameCustomerEvents1.IBCQueryCustomerEvents.CancelUpdates;
            frameCustomerEvents1.IBCQueryCustomerEvents.Cancel;
        end;

        if fMasterDataSet.State in [dsEdit, dsInsert] then
            fMasterDataSet.Cancel;

        if LocalUpdateTransaction.Active then
            LocalUpdateTransaction.Rollback;
    end;
    frameCustomerPhones1.IBCQueryCustomerPhones.Close;
    frameCustomerEvents1.IBCQueryCustomerEvents.Close;
end;

{ Denumirea din Registrul fiscal in forma folosita in WMS: '"PRIME STORE" S.R.L.' -> 'PRIME STORE SRL'. }
function RegistryNameToWMS(const AName: string): string;
begin
  Result := StringReplace(StringReplace(AName, '"', '', [rfReplaceAll]), '''', '', [rfReplaceAll]);
  Result := UpperCase(Trim(Result));
  Result := StringReplace(Result, 'S.R.L.', 'SRL', [rfReplaceAll]);
  Result := StringReplace(Result, 'S.R.L', 'SRL', [rfReplaceAll]);
  Result := StringReplace(Result, 'S.A.', 'SA', [rfReplaceAll]);
  while Pos('  ', Result) > 0 do
    Result := StringReplace(Result, '  ', ' ', [rfReplaceAll]);
end;

{ Datele clientului din Registrul fiscal (SFS), prin API-ul e-Factura: denumire, adresa
  juridica, cod TVA si conturile IBAN inregistrate. Denumirea (doar daca lipseste) si codul
  TVA se completeaza in fisa si se salveaza cu OK; IBAN-urile lipsa se adauga direct in
  TS_CUST_ACCOUNTS, doar pentru clientii deja salvati (conturile au FK spre client). Adresa
  ramane de comparat manual: in WMS adresele sunt structurate (tara/oras/sector), iar
  Registrul o da ca text. }
procedure TfrmCustomerEditorDialog.btnGetSFSDataClick(Sender: TObject);
var
  Manager: TEFacturaManager;
  Taxpayer: TEFacturaTaxpayer;
  Accounts: TEFacturaBankAccounts;
  Acc: TEFacturaBankAccount;
  Q: TIBCQuery;
  IDNO, Info, Existing, NewAccounts, Changes: string;
  NewCount, Added: Integer;
  SetVat, SetName: Boolean;
begin
  IDNO := Trim(fMasterDataSet.FieldByName('IDEN_NUMBER').AsString);
  if IDNO = '' then
  begin
    ShowErrorDialog('e-Factura', 'Indicati codul fiscal (IDNO) al clientului.');
    Exit;
  end;

  Manager := TEFacturaManager.Create(dmDB.IBCConnection);
  try
    try
      Screen.Cursor := crHourGlass;
      try
        if not Manager.GetCompanyInfo(IDNO, dmDB.CurrentFirma, Taxpayer, Accounts) then
        begin
          Screen.Cursor := crDefault;
          ShowInfoDialog('Date din e-Factura', 'Codul fiscal ' + IDNO + ' nu a fost gasit in Registrul fiscal.');
          Exit;
        end;
      finally
        Screen.Cursor := crDefault;
      end;
    except
      on E: Exception do
      begin
        ShowErrorDialog('e-Factura', E.Message);
        Exit;
      end;
    end;

    // conturile deja existente in fisa clientului
    Existing := '|';
    if not fCreateNewRecord then
    begin
      Q := TIBCQuery.Create(nil);
      try
        Q.Connection := dmDB.IBCConnection;
        Q.SQL.Text := 'SELECT ACCOUNTNUMBER FROM TS_CUST_ACCOUNTS WHERE CUSTOMERID = :CUSTOMERID';
        Q.ParamByName('CUSTOMERID').AsInteger := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
        Q.Open;
        while not Q.Eof do
        begin
          Existing := Existing + UpperCase(Trim(Q.Fields[0].AsString)) + '|';
          Q.Next;
        end;
      finally
        Q.Free;
      end;
    end;

    Info := 'Denumire: ' + Taxpayer.Name + #13#10 +
      'Adresa juridica: ' + Taxpayer.Address + #13#10 +
      'Cod TVA: ' + IfThen(Taxpayer.CodTVA = '', '- (neplatitor de TVA)', Taxpayer.CodTVA) + #13#10 +
      'Foloseste e-Factura: ' + IfThen(Taxpayer.IsEFacturaActor, 'da', 'nu') + #13#10 +
      'Conturi IBAN in Registrul fiscal: ' + IntToStr(Length(Accounts));
    NewAccounts := '';
    NewCount := 0;
    for Acc in Accounts do
    begin
      Info := Info + #13#10 + '   ' + Acc.AccountNumber + ' - ' + Acc.BranchTitle;
      if Pos('|' + UpperCase(Trim(Acc.AccountNumber)) + '|', Existing) = 0 then
      begin
        NewAccounts := NewAccounts + #13#10 + '   ' + Acc.AccountNumber;
        Inc(NewCount);
      end;
    end;

    SetVat := (Taxpayer.CodTVA <> '') and (Trim(fMasterDataSet.FieldByName('VAT_NUMBER').AsString) <> Taxpayer.CodTVA);
    SetName := (Trim(Taxpayer.Name) <> '') and (Trim(fMasterDataSet.FieldByName('NAME').AsString) = '');
    Changes := '';
    if SetName then
      Changes := Changes + #13#10 + '- denumirea: ' + RegistryNameToWMS(Taxpayer.Name);
    if SetVat then
      Changes := Changes + #13#10 + '- codul TVA: ' + Taxpayer.CodTVA;
    if (NewCount > 0) and not fCreateNewRecord then
      Changes := Changes + #13#10 + Format('- %d cont(uri) IBAN noi:', [NewCount]) + NewAccounts;

    if fReadOnly or (Changes = '') then
    begin
      if (NewCount > 0) and fCreateNewRecord then
        Info := Info + #13#10#13#10 + 'Conturile IBAN se pot adauga dupa salvarea clientului.'
      else if not fReadOnly then
        Info := Info + #13#10#13#10 + 'Denumirea, codul TVA si conturile din fisa corespund Registrului fiscal.';
      ShowInfoDialog('Date din e-Factura', Info);
      Exit;
    end;

    if ShowAskDialog('Date din e-Factura', Info, 'Completati in fisa clientului:' + Changes) <> mrYes then
      Exit;

    if (SetName or SetVat) and not (fMasterDataSet.State in dsEditModes) then
      fMasterDataSet.Edit;
    if SetName then
      fMasterDataSet.FieldByName('NAME').AsString := RegistryNameToWMS(Taxpayer.Name);
    if SetVat then
    begin
      fMasterDataSet.FieldByName('VAT_NUMBER').AsString := Taxpayer.CodTVA;
    end;
    if (NewCount > 0) and not fCreateNewRecord then
    begin
      try
        Added := Manager.ImportBankAccounts(fMasterDataSet.FieldByName('CUSTOMERID').AsInteger, Accounts);
        ShowInfoDialog('Date din e-Factura', Format('Au fost adaugate %d conturi IBAN.', [Added]));
      except
        on E: Exception do
          if not ProcessSWNError(E) then
            ShowErrorDialog('e-Factura', E.Message);
      end;
    end;
  finally
    Manager.Free;
  end;
end;

end.

