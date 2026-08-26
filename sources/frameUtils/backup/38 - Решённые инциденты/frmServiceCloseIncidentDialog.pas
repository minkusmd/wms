unit frmServiceCloseIncidentDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, ExtCtrls, DialogTitle,
  StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxPC, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, DB, cxDBData, cxCurrencyEdit, cxLabel, cxCheckBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxCheckListBox, cxDBCheckListBox, cxMemo,
  DBAccess, IBC, MemDS, Buttons, ControlGroup, frmPrintEngineWindow, FiscalPrinterUtilsUnit, OleServer, ZFPCOMLib_TLB,
  ComCtrls, cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, cxNavigator;

type
  TfrmServiceCloseIncidentDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    btnPrev: TButton;
    btnCancel: TButton;
    btnNext: TButton;
    pcPageControl: TcxPageControl;
    tbsIncident: TcxTabSheet;
    tbsRashod: TcxTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edTYPE_TITLE: TcxDBTextEdit;
    edGOODS_NAME: TcxDBTextEdit;
    edSN: TcxDBTextEdit;
    edGOODS_MODEL: TcxDBTextEdit;
    edCUSTOMER_FULLNAME: TcxDBTextEdit;
    Label7: TLabel;
    edDATA: TcxDBTextEdit;
    Label8: TLabel;
    edDATA_FINISHED: TcxDBTextEdit;
    Bevel1: TBevel;
    Label9: TLabel;
    edSTATUS_TITLE: TcxDBTextEdit;
    Label10: TLabel;
    edWARRANTY: TcxDBTextEdit;
    Label14: TLabel;
    Label15: TLabel;
    cbCheck_Rashod: TCheckBox;
    tbsGoods: TcxTabSheet;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    edGOODS_NAME2: TcxDBTextEdit;
    edSN2: TcxDBTextEdit;
    edGOODS_MODEL2: TcxDBTextEdit;
    mmEXTERNAL_DSC: TcxDBMemo;
    Label17: TLabel;
    Label21: TLabel;
    clbFLAGS_COMPLECT: TcxDBCheckListBox;
    cbCheck_Goods: TCheckBox;
    tbsDocsToPrint: TcxTabSheet;
    Label23: TLabel;
    edCUSTOMER_FULLNAME2: TcxDBTextEdit;
    Label24: TLabel;
    cbPrint_Receipt: TCheckBox;
    cbPrint_ScetFactura: TCheckBox;
    cbPrint_ActVipolnihRabot: TCheckBox;
    btnFinish: TButton;
    IBCQueryIncidents: TIBCQuery;
    IBCDataSourceIncidents: TIBCDataSource;
    IBCQueryJurnal: TIBCQuery;
    IBCDataSourceJurnal: TIBCDataSource;
    Label25: TLabel;
    Label26: TLabel;
    tbsCloseIncident: TcxTabSheet;
    cbCheck_PrintedDocs: TCheckBox;
    mmProgress: TMemo;
    lbFP_NotFound: TLabel;
    ControlGroup1: TControlGroup;
    ControlGroup2: TControlGroup;
    ControlGroup3: TControlGroup;
    ControlGroup4: TControlGroup;
    ControlGroup5: TControlGroup;
    Label1: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Bevel2: TBevel;
    edIncidentSum: TEdit;
    edTotalSum: TEdit;
    Edit1: TEdit;
    edPrintTotalSum: TEdit;
    pcPageControlGoods: TPageControl;
    tbsGoodsJurnal: TTabSheet;
    tbsGoodsACNT: TTabSheet;
    cxGridGoods: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridACNT: TcxGrid;
    cxGridACNTTable: TcxGridDBTableView;
    cxGridACNTTable_NAMEACNT: TcxGridDBColumn;
    cxGridACNTTable_QTY: TcxGridDBColumn;
    cxGridACNTTable_PRICE: TcxGridDBColumn;
    cxGridACNTTable_SUMA: TcxGridDBColumn;
    cxGridACNTLevel: TcxGridLevel;
    IBCDataSourceFP: TIBCDataSource;
    IBCQueryFP: TIBCQuery;
    cxGridACNTTable_GOODSID: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure cbCheck_PrintedDocsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridGoodsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
      TcxCustomGridTableItem; out AStyle: TcxStyle);
  private
    { Private declarations }
    FP: TZekaFP;
    fReportParams: TReportParamsList;
    FIncidentID: integer;
    fIncidentSuma: Currency;
    fTotalPaySuma: Currency;
    fCanCloseSuccesufully: Boolean;
    fCanStartClosingProcedure: Boolean;
    fCanCloseWindow: Boolean;
    fDOCID_VTK: integer; // DOCID Возврат товара клиенту

    fAllow_BonFiscal: Boolean;
    fAllow_ActWork: Boolean;
    fReportID_ActWork: integer;
    fAllow_ScetFactura: Boolean;
    fReportID_ScetFactura: integer;
    fPrinterExists: Boolean;
    fFiscalPrinterPort: integer;
    fFiscalPrinterBoundRate: integer;
    procedure SetIncidentID(const Value: integer);
    procedure LockIncident;
    procedure GotoPage(const NextPage: TcxTabSheet);
    procedure StartClosingProcedure;
    procedure DisableButtons;
    procedure EnableButtons;
    procedure DoAction_CloseIncidentDB;
    function PrintFiscalReceipt: Boolean;
    procedure PrintReports;
    procedure SetPrinterBoundRate(const Value: integer);
    procedure SetPrinterPort(const Value: integer);
    procedure DetectFiscalPrinter;
    procedure WhenDetectFiscalPrinterFinished(const Thread: TFiscalPrinterDetectThread);
    procedure SetIncidentPaySum(const Suma: Currency);
    procedure SetupTotalPaySum;
    procedure ReadIncidentDebtsDB;
    function FiscalPrinterError: Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
    property IncidentID: integer read FIncidentID write SetIncidentID;
    property FiscalPrinterExists: Boolean read fPrinterExists;
    property FiscalPrinterPort: integer read fFiscalPrinterPort write SetPrinterPort;
    property FiscalPrinterBoundRate: integer read fFiscalPrinterBoundRate write SetPrinterBoundRate;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNUtils;

{$R *.dfm}

{ TfrmServiceCloseIncidentDlg }

procedure TfrmServiceCloseIncidentDlg.btnNextClick(Sender: TObject);
begin
  if pcPageControl.ActivePage = tbsIncident then
    GotoPage(tbsRashod)
  else if pcPageControl.ActivePage = tbsRashod then
    GotoPage(tbsGoods)
  else if pcPageControl.ActivePage = tbsGoods then
    GotoPage(tbsDocsToPrint)
  else if pcPageControl.ActivePage = tbsDocsToPrint then
    GotoPage(tbsCloseIncident);
end;

procedure TfrmServiceCloseIncidentDlg.btnPrevClick(Sender: TObject);
begin
  if pcPageControl.ActivePage = tbsRashod then
    GotoPage(tbsIncident)
  else if pcPageControl.ActivePage = tbsGoods then
    GotoPage(tbsRashod)
  else if pcPageControl.ActivePage = tbsDocsToPrint then
    GotoPage(tbsGoods)
  else if pcPageControl.ActivePage = tbsCloseIncident then
    GotoPage(tbsDocsToPrint);
end;

procedure TfrmServiceCloseIncidentDlg.cbCheck_PrintedDocsClick(Sender: TObject);
begin
  btnNext.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmServiceCloseIncidentDlg.cxGridGoodsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridDBCol_FLG_ACTIVE.Index] = 0 then
    AStyle := dmAdditions.cxStyle_TextGray;
end;

procedure TfrmServiceCloseIncidentDlg.DetectFiscalPrinter;
var
  Thread: TFiscalPrinterDetectThread;
begin
  Thread := TFiscalPrinterDetectThread.Create;
  Thread.PrinterPort := fFiscalPrinterPort;
  Thread.PrinterBoundRate := fFiscalPrinterBoundRate;
  Thread.OnDetectFinished := WhenDetectFiscalPrinterFinished;
  Thread.Start;
end;

procedure TfrmServiceCloseIncidentDlg.DisableButtons;
begin
  btnPrev.Enabled := False;
  btnNext.Enabled := False;
  btnFinish.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmServiceCloseIncidentDlg.DoAction_CloseIncidentDB;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'SELECT NEWDOCID FROM SP_SC_CLOSE_INCIDENT(:IID,:PAYD_SUM)';
    Query.ParamByName('IID').AsInteger := FIncidentID;
    Query.ParamByName('PAYD_SUM').AsCurrency := fTotalPaySuma;
    Query.ExecSQL;
    if Query.Eof then
      raise Exception.Create('Не найден код документа "Возврат товара клиенту"')
    else
      fDOCID_VTK := Query.Fields[0].AsInteger;
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmServiceCloseIncidentDlg.EnableButtons;
begin
  btnPrev.Enabled := not fCanCloseSuccesufully;
  btnNext.Enabled := False;
  btnFinish.Enabled := fCanCloseSuccesufully;
  if fCanCloseSuccesufully then
    btnFinish.Default := True;
  btnCancel.Enabled := not fCanCloseSuccesufully;
end;

function TfrmServiceCloseIncidentDlg.FiscalPrinterError: Boolean;
var
  Error: Integer;
begin
  Error := FP.errorCode;
  if Error = 0 then
    Result := false
  else
  begin
          // some actions
    raise Exception.Create(FP.GetErrorString(Error, 0));
  end;
end;

procedure TfrmServiceCloseIncidentDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOK then
  begin
    if dmDB.IBCTrDefaultUpdate.Active then
      dmDB.IBCTrDefaultUpdate.Rollback;
  end;
end;

procedure TfrmServiceCloseIncidentDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := fCanCloseWindow;
end;

procedure TfrmServiceCloseIncidentDlg.FormCreate(Sender: TObject);
begin
  FP := TZekaFP.Create(Self);

  FIncidentID := -1;
  fIncidentSuma := 0;
  fTotalPaySuma := 0;
  fDOCID_VTK := -1;
  fCanCloseWindow := True;
  fCanStartClosingProcedure := True;
  fCanCloseSuccesufully := False;

  fAllow_BonFiscal := True;
  lbFP_NotFound.Visible := False;
  fAllow_ActWork := True;
  fAllow_ScetFactura := True;

  fReportID_ActWork := 16;
  fReportID_ScetFactura := 3;

  fPrinterExists := False;
  fFiscalPrinterPort := 1;
  fFiscalPrinterBoundRate := 9600;

  fReportParams := TReportParamsList.Create;
     // setup general params
  fReportParams.SetParamValue('DT', dmDB.CurrentFirma);
  fReportParams.SetParamValue('USERID', dmDB.CurrentUserID);
  fReportParams.SetParamValue('USER_NAME', dmDB.CurrentUserFullName);

  pcPageControlGoods.ActivePage := tbsGoodsACNT;

  SetIncidentPaySum(0);
end;

procedure TfrmServiceCloseIncidentDlg.FormDestroy(Sender: TObject);
begin
  FP.Free;
  fReportParams.Free;
end;

procedure TfrmServiceCloseIncidentDlg.GotoPage(const NextPage: TcxTabSheet);
begin
  pcPageControl.ActivePage := NextPage;

  if NextPage = tbsIncident then
  begin
    btnPrev.Enabled := False;
    btnNext.Enabled := True;
  end
  else if NextPage = tbsRashod then
  begin
    btnPrev.Enabled := True;
    btnNext.Enabled := cbCheck_Rashod.Checked;
  end
  else if NextPage = tbsGoods then
  begin
    btnPrev.Enabled := True;
    btnNext.Enabled := cbCheck_Goods.Checked;
  end
  else if NextPage = tbsDocsToPrint then
  begin
    btnPrev.Enabled := True;
    btnNext.Enabled := cbCheck_PrintedDocs.Checked;
  end
  else if NextPage = tbsCloseIncident then
  begin
    btnPrev.Enabled := True;
    btnNext.Enabled := False;

    if fCanStartClosingProcedure then
      StartClosingProcedure;

  end;

  btnFinish.Enabled := fCanCloseSuccesufully;

end;

procedure TfrmServiceCloseIncidentDlg.LockIncident;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'SELECT NULL FROM SP_LOCK_INCIDENT(:IID)';
    Query.ParamByName('IID').AsInteger := FIncidentID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TfrmServiceCloseIncidentDlg.Prepare;
begin
  if FIncidentID = -1 then
    raise Exception.Create('Не установлен номер инцидента!');

  cbPrint_Receipt.Enabled := False;
  cbPrint_ScetFactura.Enabled := fAllow_ScetFactura and (fReportID_ScetFactura <> -1);
  cbPrint_ActVipolnihRabot.Enabled := fAllow_ActWork and (fReportID_ActWork <> -1);

  if fAllow_BonFiscal then
    DetectFiscalPrinter;

  GotoPage(tbsIncident);

  dmDB.IBCTrDefaultUpdate.StartTransaction;
  try
    LockIncident;
    IBCQueryIncidents.ParamByName('IID').AsInteger := FIncidentID;
    IBCQueryIncidents.Active := True;

    IBCQueryJurnal.ParamByName('IID').AsInteger := FIncidentID;
    IBCQueryJurnal.Active := True;

    IBCQueryFP.ParamByName('IID').AsInteger := FIncidentID;
    IBCQueryFP.Active := True;

    ReadIncidentDebtsDB;
  except
    dmDB.IBCTrDefaultUpdate.Rollback;
    raise;
  end;

end;

procedure TfrmServiceCloseIncidentDlg.PrintReports;
var
  print: TfrmPrintEngine;
begin
  print := TfrmPrintEngine.Create(Self);
  try
    print.ReportParams := fReportParams;

        // 1. Акт проделанных работ
    if cbPrint_ActVipolnihRabot.Checked then
    begin
      mmProgress.Lines.Add('Печать "Акт проделанных работ"...');
      print.AddReport(fReportID_ActWork);
      mmProgress.Lines.Add('Готово!');
      mmProgress.Lines.Add('');
    end;
        // 2. Счет-фактура
    if cbPrint_ScetFactura.Checked then
    begin
      mmProgress.Lines.Add('Печать "Счет-фактура"...');
      print.AddReport(fReportID_ScetFactura);
      mmProgress.Lines.Add('Готово!');
      mmProgress.Lines.Add('');
    end;
    print.ShowModal;
  finally
    print.Free;
  end;
end;

function TfrmServiceCloseIncidentDlg.PrintFiscalReceipt: Boolean;
var
  Query: TIBCQuery;
  FPOperator: byte;
  fTotalSuma: Currency;
  BonNumber: integer;
  DataBon: TDateTime;
begin
     // print fiscal receipt for each document attached to Incident
  Result := false;

  if True then
    FPOperator := 1 // Persoana Fizica
  else
    FPOperator := 2; // Persoana Juridica


  FP.Setup(fFiscalPrinterPort, fFiscalPrinterBoundRate, 3, 1000);
  FP.GetFactoryNumber;
  if FiscalPrinterError then
    Exit;

  FP.OpenFiscalBon(FPOperator, '0000', 0, 0);

     // scoatem lista marfurilor pentru tipar
  fTotalSuma := 0;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT * FROM GET_GOODS_FOR_RECEIPT_INCIDENT(:IID)';
    Query.ParamByName('IID').AsInteger := FIncidentID;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      fTotalSuma := fTotalSuma + Query.FieldByName('PRICE').AsCurrency * Query.FieldByName('QTY').AsFloat;
      FP.SellFree(Query.FieldByName('NAMEACNT').AsString, 1, Query.FieldByName('PRICE').AsCurrency, Query.FieldByName('QTY').AsFloat,
        0);
      if FiscalPrinterError then
        Exit;

      Query.Next;
    end;
    Query.Close;

  finally
    Query.Free;
  end;

     // achitam
  FP.Payment(fTotalSuma, 0, 1);  // NUMERAR
  if not FiscalPrinterError then
  begin
    FP.CloseFiscalBon;
    if not FiscalPrinterError then
    begin
      BonNumber := Fp.GetBonNumber;
      if not FiscalPrinterError then
      begin
        DataBon := FP.GetDateTime;

        Query := TIBCQuery.Create(Self);
        try
          Query.Connection := dmDB.IBCConnection;
          Query.Transaction := dmDB.IBCTrDefaultUpdate;
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_SC_INCIDENT_BON_DELIVERED(:IID,:NUMAR_BON,:DATA_BON)';
          Query.ParamByName('IID').AsInteger := FIncidentID;
          Query.ParamByName('NUMAR_BON').AsInteger := BonNumber;
          Query.ParamByName('DATA_BON').AsDateTime := DataBon;
          try
            Query.ExecSQL;
            Result := True;
          except
                          // anulam ultimu bon???
            raise;
          end;
        finally
          Query.Free;
        end;
      end;
    end;
  end;

end;

procedure TfrmServiceCloseIncidentDlg.ReadIncidentDebtsDB;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'SELECT SUMA_INCIDENT FROM SP_SC_GET_INCIDENT_DEBTS(:IID)';
    Query.ParamByName('IID').AsInteger := FIncidentID;
    Query.ExecSQL;
    if not Query.Eof then
      SetIncidentPaySum(Query.Fields[0].AsCurrency);
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmServiceCloseIncidentDlg.SetIncidentID(const Value: integer);
begin
  FIncidentID := Value;
  fReportParams.SetParamValue('IID', Value);
end;

procedure TfrmServiceCloseIncidentDlg.SetIncidentPaySum(const Suma: Currency);
begin
  fIncidentSuma := Suma;
  edIncidentSum.Text := Format('%2.2f', [fIncidentSuma]);
  SetupTotalPaySum;
end;

procedure TfrmServiceCloseIncidentDlg.SetPrinterBoundRate(const Value: integer);
begin
  fFiscalPrinterBoundRate := Value;
end;

procedure TfrmServiceCloseIncidentDlg.SetPrinterPort(const Value: integer);
begin
  fFiscalPrinterPort := Value;
end;

procedure TfrmServiceCloseIncidentDlg.SetupTotalPaySum;
begin
  fTotalPaySuma := fIncidentSuma;
  edTotalSum.Text := Format('%2.2f', [fTotalPaySuma]);
  edPrintTotalSum.Text := edTotalSum.Text;
end;

procedure TfrmServiceCloseIncidentDlg.StartClosingProcedure;
begin
  if ShowAskDialog('Закрытие инцидента', 'Вы хотите закрыть данный инцидент?') <> mrYes then
    Exit;


     // prepare
  fCanCloseWindow := False;
  mmProgress.Lines.Clear;
  DisableButtons;
  try
    try
           // 1. Inchidem incidentul
      mmProgress.Lines.Add('Закрытие инцидента...');
      DoAction_CloseIncidentDB;
      mmProgress.Lines.Add('Готово!');
      mmProgress.Lines.Add('');

           // 2. Imprimam documentele necesare
           // a. Фискальный чек
      if cbPrint_Receipt.Checked then
      begin
        mmProgress.Lines.Add('Печать "Фискальный чек"...');
        if PrintFiscalReceipt then
          mmProgress.Lines.Add('Готово!');
        mmProgress.Lines.Add('');
      end;

           // commit changes
      dmDB.IBCTrDefaultUpdate.Commit;

      fCanStartClosingProcedure := False;
      fCanCloseSuccesufully := True;


           // b. Print reports
      if cbPrint_ActVipolnihRabot.Checked or cbPrint_ScetFactura.Checked then
        PrintReports;

    except
      on E: Exception do
      begin
        mmProgress.Lines.Add('');
        mmProgress.Lines.Add('Ошибка! ' + E.Message);
      end;
    end;
  finally
    fCanCloseWindow := True;
    EnableButtons;
  end;

end;

procedure TfrmServiceCloseIncidentDlg.WhenDetectFiscalPrinterFinished(const Thread: TFiscalPrinterDetectThread);
begin
  case Thread.DeviceStatus of
    fpdsUnknown, fpdsNotFound, fpdsNotFoundDriver:
      begin
        fAllow_BonFiscal := False;
        lbFP_NotFound.Visible := True;
        if Thread.DeviceStatus = fpdsNotFoundDriver then
        begin
          cbPrint_Receipt.Caption := 'Нет программной поддержки!';
        end;
      end;
    fpdsFound, fpdsFoundNew:
      begin
        lbFP_NotFound.Visible := False;
        fAllow_BonFiscal := True;
        cbPrint_Receipt.Enabled := True;

        if Thread.DeviceStatus = fpdsFoundNew then
        begin
          fPrinterExists := True;
          fFiscalPrinterPort := Thread.PrinterPort;
          fFiscalPrinterBoundRate := Thread.PrinterBoundRate;
        end;
      end;
  end;
end;

end.

