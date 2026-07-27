unit frmScetFakturaDoverenostiDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, ExtCtrls,
  StdCtrls, DB, DBAccess, IBC, cxDBEdit, cxButtonEdit, cxContainer, cxEdit, cxGraphics, cxDBLookupComboBox, cxPC,
  cxButtons, cxImage, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxBarBuiltInMenu, System.ImageList,
  Vcl.ImgList, cxImageList, MemDS, dxGDIPlusClasses, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxMaskEdit,
  cxCalendar, cxTextEdit, dxCoreGraphics, dxUIAClasses;

type
  TfrmScetFakturaDoverenostiDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    GroupBox2: TGroupBox;
    cxLabel6: TLabel;
    cxLabel7: TLabel;
    cxDBTextEdit4: TcxDBTextEdit;
    cxDBTextEdit5: TcxDBTextEdit;
    cxLabel8: TLabel;
    cxDBTextEdit6: TcxDBTextEdit;
    cxLabel9: TLabel;
    cxDBTextEdit7: TcxDBTextEdit;
    cxLabel10: TLabel;
    cxDBTextEdit8: TcxDBTextEdit;
    IBCQueryINFO: TIBCQuery;
    IBCDataSourceINFO: TIBCDataSource;
    Label4: TLabel;
    cxDBTextEdit2: TcxDBTextEdit;
    Label2: TLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    IBCQuerySysS: TIBCQuery;
    IBCDataSourceSysS: TIBCDataSource;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    edNRMATRICULARE: TcxDBTextEdit;
    lbNRCar: TLabel;
    lbFoaie: TLabel;
    edNRFOAIEDEPARCURS: TcxDBTextEdit;
    deFPDATAELIBERARII: TcxDBDateEdit;
    Label7: TLabel;
    cxTabSheet3: TcxTabSheet;
    lbProcura: TLabel;
    bePROCURANO: TcxButtonEdit;
    edDELEGAT: TcxDBTextEdit;
    Label3: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    deDATA_ELIBERARII: TcxDBDateEdit;
    beFacturaNO: TcxDBButtonEdit;
    lcbTipFactura: TcxDBLookupComboBox;
    Label10: TLabel;
    lcbPunctIncarcare: TcxDBLookupComboBox;
    Label11: TLabel;
    lcbPunctDescarcare: TcxDBLookupComboBox;
    IBCQueryAddrDT: TIBCQuery;
    IBCQueryAddrCT: TIBCQuery;
    IBCDataSourceAddrDT: TIBCDataSource;
    IBCDataSourceAddrCT: TIBCDataSource;
    Label8: TLabel;
    edDOCUMENTE_ANEXATE: TcxDBTextEdit;
    Label6: TLabel;
    btnChangeCustomerInfo: TcxButton;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    Label12: TLabel;
    cbffOperationType: TcxDBLookupComboBox;
    IBCDataSourceSYSS52: TIBCDataSource;
    IBCQuerySysS52: TIBCQuery;
    cxImageList1: TcxImageList;
    cxImage1: TcxImage;
    lcbTransportator: TcxDBLookupComboBox;
    IBCQueryTransportator: TIBCQuery;
    IBCDataSourceTransportator: TIBCDataSource;
    IBCQueryRedirijari: TIBCQuery;
    IBCDataSourceRedirijari: TIBCDataSource;
    cbRedirijari: TcxDBLookupComboBox;
    lbTransportator: TLabel;
    beTRANSPORTATOR: TcxButtonEdit;
    Label13: TLabel;
    procedure beTRANSPORTATORPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure bePROCURA_DELEGATPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnChangeCustomerInfoClick(Sender: TObject);
    procedure cxDBButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure lcbTipFacturaPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    fCreateNewInvoice: Boolean;
    fCT: Integer;
    fDT: Integer;
    fCT_Name: string;
    fDT_Name: string;
    function CheckParams: Boolean;
    procedure ShowSelectProcuraDialog;
    procedure SetCreateNewInvoice(const Value: Boolean);
    procedure SetCT(const Value: Integer);
    procedure SetCT_Name(const Value: string);
    procedure SetDT(const Value: Integer);
    procedure SetDT_Name(const Value: string);
    procedure ShowChangeCustomerInfo;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewInvoice: Boolean read fCreateNewInvoice write SetCreateNewInvoice;
    procedure AtribuieNumarFactura;
    property DT: Integer read fDT write SetDT;
    property CT: Integer read fCT write SetCT;
    property DT_Name: string read fDT_Name write SetDT_Name;
    property CT_Name: string read fCT_Name write SetCT_Name;
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, frmProcuriBrowserDialog, frmCustomersDlg, SWNSecurityFlags, SWNSecurity;

{$R *.dfm}

procedure TfrmScetFakturaDoverenostiDlg.AtribuieNumarFactura;
var
  q: TIBCQuery;
begin
  if IBCQuerySysS.FieldByName('SYSSID').AsInteger = 8556 then
  begin
      // act de primire/predare fara factura
    if (Length(ibcqueryInfo.FieldByName('IDEN_NUMBER').AsString) > 7) then
    begin
      q := TIBCQuery.Create(nil);
      try
        q.Connection := dmdb.IBCConnection;
        q.Transaction := dmDB.IBCTrDefaultSelect;
        q.SQL.Text := 'select lpad((next value for sq_tdb_invoice_app), 6, ' + QuotedStr('0') + ') N from rdb$database';

        q.Open;

        beFacturaNO.Text := 'FAPP ' + q.FieldByName('N').AsString;
        fMasterDataSet.FieldByName('FACTURANO').AsString := beFacturaNO.Text;
      finally
        q.Free;
      end;
    end
    else
    begin
      raise Exception.Create('Nu este indicat codul fiscal al cumparatorului');
    end;
  end;


  // select first 1 DSE_VALUES from GET_DSE_VALUES(12057)
//  q := TIBCQuery.Create(Owner);
//  try
//    q.Connection := dmdb.IBCConnection;
//    q.Transaction := dmdb.IBCTrDefaultUpdate;
//    q.SQL.Text := 'SELECT DSE_NO FROM GET_DSE_VALUES(:dse_typeid, :docid)';
//    q.ParamByName('DOCID').AsInteger := fMasterDataSet.FieldByName('DOCID').AsInteger;
//
//    if dmdb.IBCDataSourceDocs.DataSet.FieldByName('DOCTYPEID').AsInteger=2016 then // factura de expeditie
//       q.ParamByName('dse_typeid').AsInteger := 7229;
//    if dmdb.IBCDataSourceDocs.DataSet.FieldByName('DOCTYPEID').AsInteger=112 then // factura fiscala
//       q.ParamByName('dse_typeid').AsInteger := 7230;
//    q.Open;
//    // set dse_value in master dataset
//
//    fMasterDataSet.FieldByName('FACTURANO').AsString := q.FieldByName('DSE_NO').AsString;
//  finally
//    q.Free;
//  end;
//  if fMasterDataSet.FieldByName('FACTURANO').AsString = '' then
//      raise exception.Create('Eroare! Nu sunt numere disponibile!!!');

end;

procedure TfrmScetFakturaDoverenostiDlg.bePROCURA_DELEGATPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  case AButtonIndex of
    0:
      ShowSelectProcuraDialog;
    1:
      begin
        bePROCURANO.Text := '';
        fMasterDataSet.FieldByName('PROCURAID').Value := Null;
        fMasterDataSet.FieldByName('DELEGAT').Value := Null;
        edDELEGAT.Enabled := True;
      end;
  end;
end;

procedure TfrmScetFakturaDoverenostiDlg.beTRANSPORTATORPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
  q: TIBCQuery;
begin
  case AButtonIndex of
    0:
      begin
        // Перевозщик поставщик

        if fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger <> fDT then
        begin
          fMasterDataSet.FieldByName('PROCURAID').Value := Null;
          fMasterDataSet.FieldByName('DELEGAT').Value := Null;
          fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger := fDT;
          bePROCURANO.Text := '';
          beTRANSPORTATOR.Text := fDT_Name;
          edDELEGAT.Enabled := True;
        end;
      end;
    1:
      begin
        // Перевозщик получатель
        if fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger <> fCT then
        begin
          fMasterDataSet.FieldByName('PROCURAID').Value := Null;
          // fMasterDataSet.FieldByName('DELEGAT').Value:=NULL;
          fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger := fCT;
          bePROCURANO.Text := '';
          beTRANSPORTATOR.Text := fCT_Name;
          edDELEGAT.Enabled := True;
        end;
      end;
    2:
      begin
        // Перевозщик по умолчанию (из справочника
        q := TIBCQuery.Create(nil);
        try
          q.SQL.Text := 'select value_int from ts_syss where syssid=910';
          q.Open;
          fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger := q.FieldByName('VALUE_INT').AsInteger;

          q.close;
          q.SQL.Text := 'select name from ts_customer where customerid = :customerid';
          q.ParamByName('CUSTOMERID').AsInteger := fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger;
          q.Open;

          beTRANSPORTATOR.Text := q.FieldByName('NAME').AsString;
        finally
          q.Free;
        end;
      end;
    3:
      begin
          // выбрать переыозщика из справочника

        dialog := TfrmCustomersDlg.Create(Self);
        try
          if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, False, 0, 'Alege transportatorul') then
          begin
            fMasterDataSource.DataSet.Edit;
            fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger := dialog.CustomerID;
            beTRANSPORTATOR.Text := dialog.CustomerTitle;
          end;

          fMasterDataSet.FieldByName('PROCURAID').Value := Null;
          bePROCURANO.Text := '';
          edDELEGAT.Enabled := True;
          fMasterDataSource.DataSet.Post;

        finally
          dialog.Free;
        end;
      end;
    4:
      begin
        // удалить текущего перевозщика

        fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger := -1;
        beTRANSPORTATOR.Text := '';
      end;
  end;
end;

procedure TfrmScetFakturaDoverenostiDlg.btnChangeCustomerInfoClick(Sender: TObject);
begin
  ShowChangeCustomerInfo;
end;

function TfrmScetFakturaDoverenostiDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if MasterDataSet.FieldByName('TIP_FACTURA').AsInteger <> 8556 then // act intern de livrare, nu verificam adresa si cine este transportatorul
  begin
    if MasterDataSet.FieldByName('PUNCT_DESCARCARE').AsInteger < 1 then
      AddErrorToStr(ErrorStr, 'Nu este indicat adresa clientului.');

    if MasterDataSet.FieldByName('TRANSPORTATOR').AsInteger < 1 then
      AddErrorToStr(ErrorStr, 'Nu este indicat TRANSPORATORUL');

    if not fMasterDataSet.FieldByName('NRFOAIEDEPARCURS').IsNull and (Trim(fMasterDataSet.FieldByName('NRFOAIEDEPARCURS').AsString)
        <> '') then
      begin
        if fMasterDataSet.FieldByName('FPDATAELIBERARII').IsNull then
          AddErrorToStr(ErrorStr, 'Data eliberarii!');
      end;
  end;


  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmScetFakturaDoverenostiDlg.cxDBButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  AtribuieNumarFactura;
end;

procedure TfrmScetFakturaDoverenostiDlg.BindingDataSource;
begin
  inherited;

  fCreateNewInvoice := False;

  beFacturaNO.DataBinding.DataSource := fMasterDataSource;
  edDELEGAT.DataBinding.DataSource := fMasterDataSource;
  edNRMATRICULARE.DataBinding.DataSource := fMasterDataSource;
  edNRFOAIEDEPARCURS.DataBinding.DataSource := fMasterDataSource;
  deDATA_ELIBERARII.DataBinding.DataSource := fMasterDataSource;
  edDOCUMENTE_ANEXATE.DataBinding.DataSource := fMasterDataSource;
  deFPDATAELIBERARII.DataBinding.DataSource := fMasterDataSource;
  cbRedirijari.DataBinding.DataSource := fMasterDataSource;
  lcbTipFactura.DataBinding.DataSource := fMasterDataSource;
  cbffOperationType.DataBinding.DataSource := fMasterDataSource;
  lcbTransportator.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmScetFakturaDoverenostiDlg.FormShow(Sender: TObject);
begin
  deDATA_ELIBERARII.SetFocus;
end;

function TfrmScetFakturaDoverenostiDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Post;
    dmDB.IBCTrDefaultUpdate.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmScetFakturaDoverenostiDlg.lcbTipFacturaPropertiesChange(Sender: TObject);
var
  TipFactura: integer;
begin
  TipFactura := fMasterDataSet.FieldByName('TIP_FACTURA').AsInteger;
  case TipFactura of
    7586: // factura electronica (serie diapazon)
      beFacturaNO.Enabled := False;
    7587: // Factura pe suport de hirtie cu Seria si Numar
      beFacturaNO.Enabled := True;
    7588: // e-Factura
      beFacturaNO.Enabled := True;
    8556: // act de primire/predare fara factura
      beFacturaNO.Enabled := True;
  end;

end;

procedure TfrmScetFakturaDoverenostiDlg.Prepare;
var
  Query: TIBCQuery;
  IsElectronicInvoiceNO: Boolean;
begin
  dmDB.IBCTrDefaultUpdate.StartTransaction;
  try
    try
      Query := TIBCQuery.Create(self);
      Query.SQL.Text := 'SELECT S.VALUE_INT FROM TS_SYSS S WHERE S.SYSSID = 908';
      Query.Open;
      IsElectronicInvoiceNO := (Query.FieldByName('VALUE_INT').AsInteger = 1);
    finally
      Query.Free;
    end;

    if dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger = 2016 then
    begin  // daca e factura de expeditie interzicem introducerea manuala a numarului facturii
      beFacturaNo.Enabled := False;
    end;

    if dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger = 112 then
    begin  // daca e factura de expeditie interzicem introducerea manuala a numarului facturii
      if IsElectronicInvoiceNO then
      begin
        beFacturaNo.Enabled := False;
      end
      else
      begin
        beFacturaNo.Enabled := True;
      end;
    end
    else
    begin
      beFacturaNo.Enabled := True;
    end;

    if fCreateNewInvoice then
    begin
      fMasterDataSet.Append;
      lcbTipFactura.Enabled := True;
      dtDialogTitle.Text := 'Factura noua';

      fMasterDataSet.FieldByName('USERID').AsInteger := dmDB.CurrentUserID;
      fMasterDataSet.FieldByName('FLG_CANCELED').AsInteger := 0;
      fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger := -1; // fDT;
      fMasterDataSet.FieldbyName('DATA_ELIBERARII').AsDateTime := Date;
      fMasterDataSet.FieldByName('TIP_FACTURA').AsInteger := 7588;  //e-Factura
      fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger := fDT;
    end
    else
    begin
      dtDialogTitle.Text := 'Modifica factura';
      fMasterDataSet.Edit;

      bePROCURANO.Text := fMasterDataSet.FieldByName('PROCURA_NO').AsString;
      lcbTipFactura.Enabled := False;
    end;

    edDELEGAT.Enabled := fMasterDataSet.FieldByName('PROCURA_NO').IsNull;

    if fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger = fDT then
      beTRANSPORTATOR.Text := fDT_Name
    else if fMasterDataSet.FieldByName('TRANSPORTATOR').AsInteger = fCT then
      beTRANSPORTATOR.Text := fCT_Name;

    IBCQueryRedirijari.Open;
    IBCQueryINFO.ParamByName('DOCID').AsInteger := fMasterDataSet.FieldByName('DOCID').AsInteger;
    IBCQueryINFO.Active := True;

    IBCQuerySYSS.Active := True;
    IBCQuerySysS.Locate('SYSSID', 7586, []); // factura serie, diapazon

    IBCQueryAddrCT.ParamByName('CUSTOMERID').AsInteger := dmdb.IBCQueryDocs.FieldByName('CT').AsInteger;
    IBCQueryAddrCT.Open;

    IBCQueryAddrDT.ParamByName('CUSTOMERID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DT').AsInteger;
    IBCQueryAddrDT.Open;

    IBCQueryTransportator.ParamByName('DT').AsInteger := dmdb.IBCQueryDocs.FieldByName('DT').AsInteger;
    IBCQueryTransportator.ParamByName('CT').AsInteger := dmdb.IBCQueryDocs.FieldByName('CT').AsInteger;
    IBCQueryTransportator.Open;

    if Int(dmdb.IBCQueryDocs.FieldByName('DATA').AsDateTime) <> int(fMasterDataSet.FieldByName('DATA_ELIBERARII').AsDateTime)
      then
      deDATA_ELIBERARII.Style.Font.Color := clRed;

    lcbPunctIncarcare.DataBinding.DataSource := fMasterDataSource;
    lcbPunctDescarcare.DataBinding.DataSource := fMasterDataSource;

    Query := TIBCQuery.Create(self);
    try
      Query.SQL.Text := 'SELECT ADDRID, FULL_ADDRESS FROM VW_TS_CUST_ADDR WHERE CUSTOMERID=:CUSTOMERID';
      Query.ParamByName('CUSTOMERID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DT').AsInteger;
      Query.Open;
      fMasterDataSet.FieldByName('PUNCT_INCARCARE').AsInteger := Query.FieldByName('AddrID').AsInteger;

      Query.Close;
      Query.ParamByName('CUSTOMERID').AsInteger := dmdb.IBCQueryDocs.FieldByName('CT').AsInteger;
      Query.Open;
      fMasterDataSet.FieldByName('PUNCT_DESCARCARE').AsString := Query.FieldByName('AddrID').AsString;
    finally
      Query.Free;
    end;

    IBCQuerySysS.Open;
    IBCQuerySysS52.Open;
    cxPageControl1.ActivePageIndex := 0;
  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
    dmDB.IBCTrDefaultUpdate.Rollback;
    raise;
  end;
end;

procedure TfrmScetFakturaDoverenostiDlg.SetCreateNewInvoice(const Value: Boolean);
begin
  fCreateNewInvoice := Value;
end;

procedure TfrmScetFakturaDoverenostiDlg.SetCT(const Value: Integer);
begin
  fCT := Value;
end;

procedure TfrmScetFakturaDoverenostiDlg.SetCT_Name(const Value: string);
begin
  fCT_Name := Value;
end;

procedure TfrmScetFakturaDoverenostiDlg.SetDT(const Value: Integer);
begin
  fDT := Value;
end;

procedure TfrmScetFakturaDoverenostiDlg.SetDT_Name(const Value: string);
begin
  fDT_Name := Value;
end;

procedure TfrmScetFakturaDoverenostiDlg.SetupSecurityItems;
begin
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_DDSE_FF_E_Modifica_Tip_Factura) then
  begin
    lcbTipFactura.Enabled := False;
    beFacturaNO.Enabled := False;
  end;
end;

procedure TfrmScetFakturaDoverenostiDlg.ShowChangeCustomerInfo;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.BrowseCustomers(dmdb.IBCQueryDocs.FieldByName('CT').AsInteger);
    IBCQueryINFO.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure TfrmScetFakturaDoverenostiDlg.ShowSelectProcuraDialog;
var
  dialog: TfrmProcuriBrowserDlg;
begin
  dialog := TfrmProcuriBrowserDlg.Create(Self);
  try
    dialog.AllowSelect := True;
    // aratam numai procurile pentru firma data
    dialog.CustomerIDGroup := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
    // select Procura
    if not fMasterDataSet.FieldByName('PROCURAID').IsNull then
      dialog.ProcuraID := fMasterDataSet.FieldByName('PROCURAID').AsInteger;

    if dialog.ShowModal = mrOk then
    begin
      if not (fMasterDataSet.State in [dsEdit, dsInsert]) then
        fMasterDataSet.Edit;

      fMasterDataSet.FieldByName('PROCURAID').AsInteger := dialog.ProcuraID;
      bePROCURANO.Text := dialog.ProcuraNO;
      fMasterDataSet.FieldByName('DELEGAT').AsString := dialog.ProcuraDelegat;
      edDELEGAT.Enabled := False;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmScetFakturaDoverenostiDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
  dmDB.IBCTrDefaultUpdate.Rollback;
end;

end.

