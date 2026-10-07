unit frameDeliveryUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxScrollbarAnnotations, cxEdit, cxButtonEdit, cxCalc, cxCheckBox, cxCalendar, cxDBLookupComboBox, cxMemo,
  dxBar, cxClasses, Data.DB, DBAccess, IBC, MemDS, cxVGrid, cxDBVGrid, cxInplaceContainer,
  SWNUtils, SWNBaseFrameUnit,frmPrintEngineWindow,frmScetFacturaNomerDialog,frmCustomersDlg, cxFilter, cxTextEdit,
  cxContainer, cxDBEdit, cxSpinEdit, cxTimeEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxMaskEdit, cxLabel,
  cxGroupBox;

type
  TframeDelivery = class(TFrame)
    IBCQueryCities: TIBCQuery;
    IBCDataSourceCities: TIBCDataSource;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbModifyDelivery: TdxBarButton;
    bbSaveDelivery: TdxBarButton;
    bbDeleteDelivery: TdxBarButton;
    bbPrint: TdxBarButton;
    bbSendECC: TdxBarButton;
    IBCQueryDelivery: TIBCQuery;
    IBCDSDelivery: TIBCDataSource;
    IBCQueryDistricts: TIBCQuery;
    IBCDataSourceDistricts: TIBCDataSource;
    IBCQueryStatutLivrari: TIBCQuery;
    IBCDataSourceStatutLivrari: TIBCDataSource;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    beCurier: TcxDBButtonEdit;
    cxLabel2: TcxLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBCheckBox2: TcxDBCheckBox;
    cxDBCheckBox3: TcxDBCheckBox;
    cxDBCheckBox4: TcxDBCheckBox;
    cxDBCheckBox5: TcxDBCheckBox;
    cxGroupBox2: TcxGroupBox;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    cxLabel3: TcxLabel;
    cxDBLookupComboBox2: TcxDBLookupComboBox;
    cxLabel4: TcxLabel;
    cxDBLookupComboBox3: TcxDBLookupComboBox;
    cxLabel5: TcxLabel;
    cxDBDateEdit1: TcxDBDateEdit;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxDBTimeEdit1: TcxDBTimeEdit;
    cxLabel8: TcxLabel;
    cxDBMemo1: TcxDBMemo;
    cxLabel9: TcxLabel;
    cxDBTextEdit2: TcxDBTextEdit;
    cxLabel10: TcxLabel;
    cxDBMemo2: TcxDBMemo;
    procedure bbModifyDeliveryClick(Sender: TObject);
    procedure bbSaveDeliveryClick(Sender: TObject);
    procedure IBCDSDeliveryStateChange(Sender: TObject);
    procedure bbDeleteDeliveryClick(Sender: TObject);
    procedure bbPrintClick(Sender: TObject);
    procedure cxDBVerticalGrid1COURIER_NAMEEditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure IBCQueryDeliveryAfterInsert(DataSet: TDataSet);
    procedure cxDBVerticalGrid1DBMultiEditorRow2Editors1EditPropertiesInitPopup(Sender: TObject);
    procedure cxDBVerticalGrid1DBMultiEditorRow2Editors0EditPropertiesChange(Sender: TObject);
    procedure beCurierPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure bbSendECCClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModuleDB, System.UITypes, ECCDeliveryUnit;

procedure TframeDelivery.bbDeleteDeliveryClick(Sender: TObject);
begin
  if ShowAskDialog('Livrari', 'Sterge inregistrarea?') = mrYes then
  begin
    if IBCQueryDelivery.RecNo > 0 then
      IBCQueryDelivery.Delete;
  end;
end;

procedure TframeDelivery.bbModifyDeliveryClick(Sender: TObject);
begin
  IBCQueryDelivery.Open;
  IBCQueryDelivery.Edit;
end;

procedure TframeDelivery.bbPrintClick(Sender: TObject);
var
  PrintEngine: TfrmPrintEngine;
  ReportParams: TReportParamsList;
  ReportOk: Boolean;
    //FacturaNO:String;
  dialog: TfrmScetFacturaNomerDlg;
begin
  ReportOk := False;
     // 1. imprimam "facturi fiscale"
  ReportParams := TReportParamsList.Create;
  PrintEngine := TfrmPrintEngine.Create(Self);
  try
    ReportParams.SetParamValue('DOCID', dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
    ReportParams.SetParamValue('USER_NAME', dmDB.CurrentUserFullName);

    // get system params
//    if Assigned(OnCustomPrintSetupReportParams) then
//      OnCustomPrintSetupReportParams(ReportParams);

        // give param to printer
    PrintEngine.ReportParams := ReportParams;

    PrintEngine.AddReport(577); // Act transportator
    PrintEngine.ShowModal;

    if PrintEngine.Printed then
      ReportOk := True
    else
      raise Exception.Create('Error on prepare report');
  finally
    PrintEngine.Free;
    ReportParams.Free;
  end;
end;

// Livrarea cu plata la livrare pleaca in aplicatia ECC a curierului (faza 7 ECC Fiscal Partner):
// curierul emite bonul la predare, iar @ECC_DELIVERY din SWNService inregistreaza bonul si incasarea.
procedure TframeDelivery.bbSendECCClick(Sender: TObject);
var
  DocID: Integer;
  Msg: string;
begin
  if IBCQueryDelivery.Active and (IBCQueryDelivery.State in [dsEdit, dsInsert]) then
    IBCQueryDelivery.Post;
  if IBCQueryDelivery.Active and not IBCQueryDelivery.IsEmpty then
    DocID := IBCQueryDelivery.FieldByName('DOCID').AsInteger
  else
    DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
  if ShowAskDialog('Livrare', 'Trimiteti livrarea in aplicatia ECC a curierului? Bonul fiscal il va emite ' +
    'curierul la predarea marfii.') <> mrYes then
    Exit;
  Screen.Cursor := crHourGlass;
  try
    try
      Msg := ECCSendDelivery(dmDB.IBCConnection, DocID, dmDB.CurrentUserID);
    finally
      Screen.Cursor := crDefault;
    end;
    MessageDlg(Msg, mtInformation, [mbOK], 0);
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TframeDelivery.bbSaveDeliveryClick(Sender: TObject);
begin
  if IBCQueryDelivery.Active then
  begin
    if IBCQueryDelivery.State in [dsEdit, dsInsert] then
    begin
      IBCQueryDelivery.Post;
      bbSaveDelivery.Enabled := false;
    end;
  end;
end;

procedure TframeDelivery.beCurierPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(IBCQueryDelivery.FieldByName('COURIERID').AsInteger, False, 0, 'Alege transportator') then
    begin
      IBCQueryDelivery.Edit;
      IBCQueryDelivery.FieldByName('COURIERID').AsInteger := dialog.CustomerID;
      IBCQueryDelivery.FieldByName('COURIER_NAME').Asstring := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TframeDelivery.cxDBVerticalGrid1COURIER_NAMEEditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(IBCQueryDelivery.FieldByName('COURIERID').AsInteger, False, 0, 'Alege transportator') then
    begin
      IBCQueryDelivery.Edit;
      IBCQueryDelivery.FieldByName('COURIERID').AsInteger := dialog.CustomerID;
      IBCQueryDelivery.FieldByName('COURIER_NAME').Asstring := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TframeDelivery.cxDBVerticalGrid1DBMultiEditorRow2Editors0EditPropertiesChange(Sender: TObject);
begin
   ibcqueryDelivery.Edit;
   ibcqueryDelivery.FieldByName('CityID').AsInteger := -1;
end;

procedure TframeDelivery.cxDBVerticalGrid1DBMultiEditorRow2Editors1EditPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCities.Open;
end;

procedure TframeDelivery.IBCDSDeliveryStateChange(Sender: TObject);
begin
    bbSaveDelivery.Enabled := (IBCDSDelivery.DataSet.State in [dsEdit, dsInsert]);
end;

procedure TframeDelivery.IBCQueryDeliveryAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('CourierID').AsInteger := dmdb.CurrentFirma;
  DataSet.FieldByName('Courier_Name').AsString := dmdb.CurrentFirmaName;
end;

end.
