unit frame97ClientBankUnit;

// Distribuirea rambursului
// FrameID = 96

interface

uses
  DBAccess, IBC, MemDS, SWNBaseFrameUnit, SWNDataFiltering, SWNDocumentFilters,
  cxCheckBox, cxClasses, cxControls, cxCustomData, cxDBData, cxData,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDataStorage,
  cxDropDownEdit, cxEdit, cxFilter, cxGraphics, cxGrid, cxGridCustomTableView,
  cxGridCustomView, cxGridDBTableView, cxGridLevel, cxGridTableView, cxLabel,
  cxLookAndFeelPainters, cxLookAndFeels, cxNavigator, cxSplitter, cxStyles,
  dxBar, dxDateRanges, dxScrollbarAnnotations, Data.DB, System.Classes,
  System.Variants, Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.Forms, Vcl.Graphics, Vcl.StdCtrls, Winapi.Messages, Winapi.Windows,
  cxCurrencyEdit, cxContainer, Vcl.Menus, cxButtons, cxTextEdit, cxMaskEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Datasnap.DBClient,
  Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, dxCore, dxCoreClasses, dxHashUtils,
  dxSpreadSheetCore, dxSpreadSheetCoreFormulas, dxSpreadSheetCoreHistory,
  dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs,
  dxSpreadSheetConditionalFormatting, dxSpreadSheetConditionalFormattingRules,
  dxSpreadSheetClasses, dxSpreadSheetContainers, dxSpreadSheetFormulas,
  dxSpreadSheetHyperlinks, dxSpreadSheetFunctions, dxSpreadSheetStyles,
  dxSpreadSheetGraphics, dxSpreadSheetPrinting, dxSpreadSheetTypes,
  dxSpreadSheetUtils, dxSpreadSheetFormattedTextUtils, dxBarBuiltInMenu,
  dxSpreadSheet, cxPC, dxUIAClasses, uZipDbfContentOnly;

type
  TBankCustomer = record
    Name: string;
    FiscalCode: string;
    account: string;
    BIC: string;
    BankName: string;
    CurrencyCode: string;
    Amount: Variant;
  end;


//    TBankTransactionRecord = record
//        OperationType: string;
//        DocumentDate: TDate;
//        DocumentNumber: string;
//        Transfer_type: string;
//        Transfer_code: string;
//        Ground: string;
//        Payer: TBankCustomer;
//        Receiver: TBankCustomer;
//    end;

  Tframe97ClientBank = class(TSWNBaseFrame)
    ADOConnectionMAIB: TADOConnection;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    IBCQueryPaymentsMAIB: TIBCQuery;
    IBCTrLocalUpdate: TIBCTransaction;
    IBCDataSourcePaymentsMAIB: TIBCDataSource;
    cxPageControl1: TcxPageControl;
    tbsMaib: TcxTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    tbsECB: TcxTabSheet;
    cxGrid1DBTableView1DOC_NUMBER: TcxGridDBColumn;
    cxGrid1DBTableView1DOC_DATE: TcxGridDBColumn;
    cxGrid1DBTableView1P_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1P_ACCOUNT: TcxGridDBColumn;
    cxGrid1DBTableView1P_FCODE: TcxGridDBColumn;
    cxGrid1DBTableView1P_BIC: TcxGridDBColumn;
    cxGrid1DBTableView1P_BANKNAME: TcxGridDBColumn;
    cxGrid1DBTableView1P_CURRCODE: TcxGridDBColumn;
    cxGrid1DBTableView1P_AMOUNT: TcxGridDBColumn;
    cxGrid1DBTableView1R_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1R_ACCOUNT: TcxGridDBColumn;
    cxGrid1DBTableView1R_FCODE: TcxGridDBColumn;
    cxGrid1DBTableView1R_BIC: TcxGridDBColumn;
    cxGrid1DBTableView1R_BANKNAME: TcxGridDBColumn;
    cxGrid1DBTableView1R_CURRCODE: TcxGridDBColumn;
    cxGrid1DBTableView1R_AMOUNT: TcxGridDBColumn;
    cxGrid1DBTableView1DESCRIPTION: TcxGridDBColumn;
    cxGrid1DBTableView1DOCID: TcxGridDBColumn;
    cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn;
    cxGrid1DBTableView1SC2: TcxGridDBColumn;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    IBCQueryECB: TIBCQuery;
    IBCDataSourceECB: TIBCDataSource;
    cxGrid2DBTableView1DOCID: TcxGridDBColumn;
    cxGrid2DBTableView1REFERID: TcxGridDBColumn;
    cxGrid2DBTableView1INTERNALNO: TcxGridDBColumn;
    cxGrid2DBTableView1DATADOC: TcxGridDBColumn;
    cxGrid2DBTableView1SUMADT: TcxGridDBColumn;
    cxGrid2DBTableView1SUMACT: TcxGridDBColumn;
    cxGrid2DBTableView1CUSTOMERNAME: TcxGridDBColumn;
    cxGrid2DBTableView1CUSTOMERIBAN: TcxGridDBColumn;
    cxGrid2DBTableView1CUSTOMERIDNO: TcxGridDBColumn;
    cxGrid2DBTableView1CUSTOMERMFO: TcxGridDBColumn;
    cxGrid2DBTableView1CUSTOMERBANKNAME: TcxGridDBColumn;
    cxGrid2DBTableView1DOC_DATE: TcxGridDBColumn;
    cxGrid2DBTableView1P_NAME: TcxGridDBColumn;
    cxGrid2DBTableView1P_ACCOUNT: TcxGridDBColumn;
    cxGrid2DBTableView1P_FCODE: TcxGridDBColumn;
    cxGrid2DBTableView1P_BIC: TcxGridDBColumn;
    cxGrid2DBTableView1P_BANKNAME: TcxGridDBColumn;
    cxGrid2DBTableView1P_CURRCODE: TcxGridDBColumn;
    cxGrid2DBTableView1P_AMOUNT: TcxGridDBColumn;
    cxGrid2DBTableView1R_NAME: TcxGridDBColumn;
    cxGrid2DBTableView1R_ACCOUNT: TcxGridDBColumn;
    cxGrid2DBTableView1R_FCODE: TcxGridDBColumn;
    cxGrid2DBTableView1R_BIC: TcxGridDBColumn;
    cxGrid2DBTableView1R_BANKNAME: TcxGridDBColumn;
    cxGrid2DBTableView1R_CURRCODE: TcxGridDBColumn;
    cxGrid2DBTableView1R_AMOUNT: TcxGridDBColumn;
    cxGrid2DBTableView1DESCRIPTION: TcxGridDBColumn;
    cxGrid2DBTableView1CUSTOMERID: TcxGridDBColumn;
    cxGrid2DBTableView1SC2: TcxGridDBColumn;
    dxBarPopupMenu1: TdxBarPopupMenu;
    dxBarManager1: TdxBarManager;
    bbCreateBankIncomeDocument: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbImportECB: TdxBarButton;
    bbOpenECB: TdxBarButton;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    bbOpenMAIB: TdxBarButton;
    bbImportMaib: TdxBarButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;

    procedure bbCreateBankIncomeDocumentClick(Sender: TObject);
    procedure bbImportMaibClick(Sender: TObject);
    procedure bbOpenECBClick(Sender: TObject);
    procedure bbImportECBClick(Sender: TObject);
  private
    dbf_folder: string;
    procedure SaveToDB;
  protected    { Protected declarations }
    fSECURITY_CanEdit: Boolean;
    fSECURITY_CanView: Boolean;
    function InitFrameID: integer; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;

    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;

    procedure RefreshData; override;
    procedure SetupSecurityItems; override;
    procedure SyncMAIBPayments;
  public    { Public declarations }
    procedure SetupDefaultFocus; override;

  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, SWNConst, SWNDBErrors, SWNSecurity, SWNSecurityFlags, SWNUtils, SWNValueStorageUnit,
  Import.ECBv4,
  System.IOUtils,
  System.SysUtils;
{$R *.dfm}


procedure Tframe97ClientBank.bbCreateBankIncomeDocumentClick(Sender: TObject);
begin
  { creaza document de incasare bancare cu suma din grid si clientul din grid }
  if (IBCQueryECB.FieldByName('SUMA_CT').AsFloat > 0) then
  begin
    if (IBCQueryECB.FieldByName('CUSTOMERID').AsInteger > 0) then
    begin
      dmdb.ExecuteQuery('EXECUTE PROCEDURE UPDATE_BANK_REGISTER(:REFERERID, :CUSTOMERID, :SUMA_CT, :DATA)',
        [
         IBCQueryECB.FieldByName('REFERERID').AsInteger,
         IBCQueryECB.FieldByName('CUSTOMERID').AsInteger,
         IBCQueryECB.FieldByName('SUMA_CT').AsFloat,
         IBCQueryECB.FieldByName('DATA').AsDateTime
        ]);
    end;
  end;
end;

procedure Tframe97ClientBank.bbImportECBClick(Sender: TObject);
var
  ImportECB: TImportECBv4;
  FileDialog: TOpenDialog;
begin
  FileDialog := TOpenDialog.Create(Self);
  fileDialog.InitialDir := TDirectory.GetCurrentDirectory + dbf_folder;
  if FileDialog.Execute then
  begin
    ImportECB := TImportECBv4.Create(Self, FileDialog.FileName, dmdb.CurrentFirma);
    try
      ImportECB.Start;
    finally
      ImportECB.Free;
    end;
    bbOpenECBClick(Sender);
  end;
end;

function PrepareDbfForOpen(const LongName: string): string;
var
  ShortName: string;
begin
  ShortName := TPath.Combine(
    ExtractFilePath(LongName),
    'TMP' + IntToStr(Random(9999)) + '.dbf'
  );

  TFile.Copy(LongName, ShortName, True);
  Result := ShortName;
end;

procedure Tframe97ClientBank.bbImportMaibClick(Sender: TObject);
var
  Dialog: TOpenDialog;
  TableName: string;
  ShortDbf: String;
  ExtractDir, WorkDir: string;
begin
  AdoConnectionMAIB.Connected := False;
  dbf_folder := ExtractFilePath(ParamStr(0)) + 'ClientBank'; //set your dbf folder location here

  AdoConnectionMAIB.LoginPrompt := false;
  AdoConnectionMAIB.ConnectionString := Format('Provider=Microsoft.JET.OLEDB.4.0;Data Source=%s;Extended Properties=dBase IV;', [dbf_folder]);
  try
    AdoConnectionMAIB.Connected := True;
    ADODataSet1.Close;
    Dialog := TOpenDialog.Create(self);
    try
      Dialog.InitialDir := dbf_folder;
      workdir := dbf_folder;
      if Dialog.Execute then begin
        ShortDbf := TZipDbfContentOnly.ExtractContentDbfAsShortName(Dialog.FileName, ExtractDir, WorkDir);
        TableName := ExtractFileName(ShortDbf);

        ADODataSet1.CommandText := Format('select * from %s where ((p_fcode = %s) or (r_fcode = %s))',
                              [TableName, QuotedStr(dmdb.FirmaInfo.FiscalCode), QuotedStr(dmdb.FirmaInfo.FiscalCode)]);
        ADODataSet1.Open;
      end
    finally
      Dialog.Free;
    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

  if ADODataSet1.Active then begin
    SaveToDB;
  end;

  SyncMAIBPayments;
  TDirectory.Delete(ExtractFileDir(ExtractDir), True);
end;

procedure Tframe97ClientBank.bbOpenECBClick(Sender: TObject);
begin
  inherited;
  IBCQueryECB.Close;
  IBCQueryECB.Open;
end;

procedure Tframe97ClientBank.SaveToDB;
var
  OwnFiscalCode: string;
begin
//  var query:=TIBCQuery.Create(nil);
//  query.SQL.Add('select iden_number from ts_cust_info where customerid = :customerid');
//  query.ParamByName('customerid').AsInteger := dmdb.CurrentFirma;
//  query.Open;
//  OwnFiscalCode := query.FieldByName('iden_number').AsString;

  ADODataSet1.First;
  IBCQueryPaymentsMAIB.AutoCommit := false;
//  ADODataSet1.Filter := 'p_fcode = ' + QuotedStr(OwnFiscalCode);
//  ADODataSet1.Filtered := True;

  IBCQueryPaymentsMAIB.Open;
  if not IBCTrLocalUpdate.Active then
    IBCTrLocalUpdate.StartTransaction;

  while not ADODataSet1.Eof do
  begin
    if not IBCQueryPaymentsMAIB.Locate('DOC_DATE;DOC_NUMBER;P_FCODE;R_FCODE',
        VarArrayOf([ADODataSet1.FieldByName('DOC_DATE').AsString,
                    ADODataSet1.FieldByName('DOC_NUMBER').AsString,
                    ADODataSet1.FieldByName('P_FCODE').AsString,
                    ADODataSet1.FieldByName('R_FCODE').AsString
                    ]), []) then
    begin  // plati
      IBCQueryPaymentsMAIB.Append;
      IBCQueryPaymentsMAIB.FieldByName('DOC_NUMBER').AsString := ADODataSet1.FieldByName('DOC_NUMBER').AsString;
      IBCQueryPaymentsMAIB.FieldByName('DOC_DATE').AsString := ADODataSet1.FieldByName('DOC_DATE').AsString;
      IBCQueryPaymentsMAIB.FieldByName('DESCRIPTION').AsString := ADODataSet1.FieldByName('GROUND').AsString;

      IBCQueryPaymentsMAIB.FieldByName('P_NAME').AsString := ADODataSet1.FieldByName('PAYER').AsString;
      IBCQueryPaymentsMAIB.FieldByName('P_FCODE').AsString := ADODataSet1.FieldByName('P_FCODE').AsString;
      IBCQueryPaymentsMAIB.FieldByName('P_BIC').AsString := ADODataSet1.FieldByName('P_BIC').AsString;
      IBCQueryPaymentsMAIB.FieldByName('P_BANKNAME').AsString := ADODataSet1.FieldByName('P_BANKNAME').AsString;
      IBCQueryPaymentsMAIB.FieldByName('P_CURRCODE').AsString := ADODataSet1.FieldByName('P_CURRCODE').AsString;
      IBCQueryPaymentsMAIB.FieldByName('P_ACCOUNT').AsString := ADODataSet1.FieldByName('P_ACCOUNT').AsString;
      IBCQueryPaymentsMAIB.FieldByName('P_AMOUNT').AsString := ADODataSet1.FieldByName('AMOUNT').AsString;

      IBCQueryPaymentsMAIB.FieldByName('R_NAME').AsString := ADODataSet1.FieldByName('RECEIVER').AsString;
      IBCQueryPaymentsMAIB.FieldByName('R_FCODE').AsString := ADODataSet1.FieldByName('R_FCODE').AsString;
      IBCQueryPaymentsMAIB.FieldByName('R_BIC').AsString := ADODataSet1.FieldByName('R_BIC').AsString;
      IBCQueryPaymentsMAIB.FieldByName('R_BANKNAME').AsString := ADODataSet1.FieldByName('R_BANKNAME').AsString;
      IBCQueryPaymentsMAIB.FieldByName('R_CURRCODE').AsString := ADODataSet1.FieldByName('R_CURRCODE').AsString;
      IBCQueryPaymentsMAIB.FieldByName('R_ACCOUNT').AsString := ADODataSet1.FieldByName('R_ACCOUNT').AsString;
      IBCQueryPaymentsMAIB.FieldByName('R_AMOUNT').AsString := ADODataSet1.FieldByName('NAT_AMOUNT').AsString;
      try
        IBCQueryPaymentsMAIB.Post;
      except
        IBCQueryPaymentsMAIB.Cancel;
      end;
    end;
    ADODataSet1.Next;
  end;

  IBCTrLocalUpdate.Commit;
end;

procedure Tframe97ClientBank.DoFrameHide;
begin
  IBCQueryPaymentsMAIB.Close;
end;

function Tframe97ClientBank.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate];
end;

function Tframe97ClientBank.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH, fbtMODIFY, fbtDELETE];
end;

function Tframe97ClientBank.InitFrameID: integer;
begin
  Result := 97;
end;

procedure Tframe97ClientBank.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//        ReadGridColumnsSettings(cxGridBankPDNSTable);
//        ReadGridColumnsSettings(cxGridRambursDBTableView);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe97ClientBank.RefreshData;
begin
end;

procedure Tframe97ClientBank.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
//        SaveGridColumnsSettings(cxGridBankPDNSTable);
//        SaveGridColumnsSettings(cxGridRambursDBTableView);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe97ClientBank.SetupDefaultFocus;
begin
//  cxGridBankPDNS.SetFocus;
//  cxGridPromoTicketsTableTICKET_CODE.Focused := True;
end;

procedure Tframe97ClientBank.SetupSecurityItems;
begin
//    fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Modifica_inregistrarea);
//    fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Vizializare);
//    fSECURITY_New := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Inregistrarea_noua);
//    fSECURITY_Edit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Modifica_inregistrarea);
//    fSECURITY_Delete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_DR_Sterge_inregistrarea);
end;

procedure Tframe97ClientBank.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
//    cxGridBankPDNSTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
//
//    OpenExternalData(FrameDataFilterInfo);
//
//    IBCQueryDistributieRamburs.Close;
//    IBCQueryDistributieRamburs.MasterFields := 'DOCID';
//    IBCQueryDistributieRamburs.DetailFields := 'DOCID';
//    IBCQueryDistributieRamburs.MasterSource := dmDB.IBCDataSourceDocs;
//
//    IBCQueryDistributieRamburs.DeleteWhere;
//    if (FrameDataFilterInfo.CustomerID > -1) then
//        ibcquerydistributieRamburs.Addwhere('customerid = ' + dmdb.IBCQueryDocs.FieldByName('CT').AsString);
//    IBCQueryDistributieRamburs.Open;
//
//     // 1. Legam grid-urile de datasource-sele
//    cxGridBankPDNSTable.DataController.DataSource := dmdb.IBCDataSourceDocs;
//    cxGridRambursDBTableView.DataController.DataSource := IBCDataSourceDistributieRamburs;
  IBCQueryPaymentsMAIB.Open;
  dbf_folder := '\ClientBank';
end;

function Tframe97ClientBank.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

procedure Tframe97ClientBank.SyncMAIBPayments;
var
  q: TIBCQuery;
begin
//    OwnFiscalCode := '1004600055542';
  q := TIBCQuery.Create(nil);
  try
    q.Transaction := IBCTrLocalUpdate;
  //    q.AutoCommit := false;
    IBCQueryPaymentsMAIB.Open;
    IBCQueryPaymentsMAIB.First;
    IBCQueryPaymentsMAIB.DisableControls;

    if not IBCTrLocalUpdate.Active then
      IBCTrLocalUpdate.StartTransaction;
    try
        q.SQL.Text := 'execute procedure sp_import_bpp_maib(:dt)';
        q.ParamByName('dt').AsInteger := dmdb.CurrentFirma;
        q.ExecSQL;
    except
        raise;
    end;
    IBCQueryPaymentsMAIB.Refresh;

    if IBCTrLocalUpdate.Active then
      IBCTrLocalUpdate.Commit;
  finally
    IBCQueryPaymentsMAIB.EnableControls;
    q.Free;
  end;


end;

end.

