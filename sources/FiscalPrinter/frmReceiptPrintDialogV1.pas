unit frmReceiptPrintDialogV1;

interface

uses
  Classes, ComCtrls, Controls, DBAccess, DialogTitle, Dialogs, ExtCtrls, Forms, Graphics, IBC, MemDS, Messages,
  SWNBaseUnit, StdCtrls, SysUtils, Variants, Windows, ZFPCOMLib_TLB, cxButtons, cxCalc, cxClasses, cxContainer,
  cxControls, cxCurrencyEdit, cxCustomData, cxDBLookupComboBox, cxDBLookupEdit, cxData, cxDataStorage, cxDropDownEdit,
  cxEdit, cxFilter, cxGraphics, cxGrid, cxGridCustomTableView, cxGridCustomView, cxGridLevel, cxGridTableView, cxLabel,
  cxLookAndFeelPainters, cxLookAndFeels, cxLookupEdit, cxMaskEdit, cxNavigator, cxStyles, cxTextEdit, dxDateRanges,
  dxScrollbarAnnotations,

  Data.DB,

  Vcl.Menus, dxUIAClasses;

type
    TDocumentInfo = class
        DocID: Integer;
        DocTypeID: Integer;
        DT: Integer;
        CT: Integer;
        Suma: Currency;
        FLG_ACNT: Boolean;
        SumaByReceips: Currency;

        constructor Create;
    end;

    TfrmReceiptPrintV1Dlg = class(TSWNCustomForm)
        DialogTitle1: TDialogTitle;
        cxPageControl: TPageControl;
        tbsInfo: TTabSheet;
        lbPrinterInfo: TLabel;
        lbInfo1: TLabel;
        lbIDEN: TLabel;
        lbInfo2: TLabel;
        lbVAT: TLabel;
        Label3: TLabel;
        Label10: TLabel;
        lbFP_DateTime: TLabel;
        lbFPDateTimeWarning: TLabel;
        tbsGoods: TTabSheet;
        cxGrid: TcxGrid;
        cxGridTable: TcxGridTableView;
        cxGridTable_NO: TcxGridColumn;
        cxGridTable_TITLE: TcxGridColumn;
        cxGridTable_QTY: TcxGridColumn;
        cxGridTable_RPICE: TcxGridColumn;
        cxGridTable_SUMA: TcxGridColumn;
        cxGridLevel: TcxGridLevel;
        tbsReceipt: TTabSheet;
        Label9: TLabel;
        tbsReceiptSummary: TTabSheet;
        tbsError: TTabSheet;
        Label11: TLabel;
        mmErrors: TMemo;
        lbReceiptSummaryInfo: TLabel;
        cxGridReceipts: TcxGrid;
        cxGridTableViewR: TcxGridTableView;
        cxGridTableViewR_Col0: TcxGridColumn;
        cxGridTableViewR_Col1: TcxGridColumn;
        cxGridTableViewR_Col2: TcxGridColumn;
        cxGridTableViewR_Col3: TcxGridColumn;
        cxGridLevelR: TcxGridLevel;
        Label4: TLabel;
        cxGridTableViewR_Col4: TcxGridColumn;
        Label12: TLabel;
        Label13: TLabel;
        cmbFR_PersoanaType: TComboBox;
        cmbFR_PaymentType: TComboBox;
        Label2: TLabel;
        cmbCekType: TComboBox;
        lbMaxSuma: TLabel;
        cxGridTableViewR_Col5: TcxGridColumn;
        lbPriceZeroWarning: TLabel;
        edPaySuma: TEdit;
        tbsPrintProgress: TTabSheet;
        Label1: TLabel;
        Label5: TLabel;
        cxGridTable_GOODSID: TcxGridColumn;
        lbCustomerVAT: TLabel;
        lbInvalidTVAGroup: TLabel;
        tbsPrihodSceot: TTabSheet;
        Label8: TLabel;
        lcbFacturaSelect: TcxLookupComboBox;
        IBCQueryPKO: TIBCQuery;
        IBCDataSourcePKO: TIBCDataSource;
        Panel2: TPanel;
        rbCreateSF: TRadioButton;
        rbUseExistingSF: TRadioButton;
        cbDocsChecked: TCheckBox;
        IBCQueryFactura: TIBCQuery;
        IBCDataSourceFactura: TIBCDataSource;
        Label6: TLabel;
        cmbHalfReceipeText: TComboBox;
        rbCreateœ Œ: TRadioButton;
        rbUseExistingDocument: TRadioButton;
        lcbExistingDocumentSelector: TcxLookupComboBox;
        rbCreateœƒÕ—: TRadioButton;
        Label7: TLabel;
        IBCTrUpdate: TIBCTransaction;
        btnClose: TcxButton;
        btnNextToReceipt: TcxButton;
        btnCheckDocs: TcxButton;
        btnPrintReceipt: TcxButton;
        btnOpenTill: TcxButton;
        btnAbortReceipt: TcxButton;
        cxGridTable_SumaTVA: TcxGridColumn;
        cxGridTable_TVA: TcxGridColumn;
        Label14: TLabel;
    cbIncasareNumerarStatus: TcxLookupComboBox;
    IBCQueryStatutIncasare: TIBCQuery;
    IBCDataSourceStatutIncasare: TIBCDataSource;
        procedure FormCreate(Sender: TObject);
        procedure btnOpenTillClick(Sender: TObject);
        procedure btnPrintReceiptClick(Sender: TObject);
        procedure cmbCekTypeClick(Sender: TObject);
        procedure btnNextToReceiptClick(Sender: TObject);
        procedure cxGridTableViewR_Col1GetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure btnAbortReceiptClick(Sender: TObject);
        procedure btnCheckDocsClick(Sender: TObject);
        procedure cbDocsCheckedEnter(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
        procedure rbCreateœ ŒClick(Sender: TObject);
        procedure rbUseExistingSFClick(Sender: TObject);
        procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
            TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure cxGridTableViewRStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
            TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    private
    { Private declarations }
        fPrinterPort: Integer;
        fPrinterBoundRate: Integer;
        fPrinterExists: Boolean;
        fCanPrintOnFP: Boolean;
        fIsPersoanaJuridica: Boolean;
        fTotalSuma: Currency;
        fFactura_DOCID: Integer;
        fReceiptPrinted: Boolean;
        fDataBon: TDateTime;
        fNumarBon: Integer;
        fReceiptSuma: Currency;
        fSumaPartial: Currency;
        FPrintWithoutPrinter: Boolean;
        fVAT: Integer;
        fPKO_DOCID: Integer;
        fRASHOD_DOCID: Integer;
        fRashodDocInfo: TDocumentInfo;
        fPrihodDocInfo: TDocumentInfo;
        fFacturaDocInfo: TDocumentInfo;
        fTargetPrihodDocInfo: TDocumentInfo;
        fTargetFacturaDocInfo: TDocumentInfo;
        procedure TryOpenFiscalPrinter;
        function DoPrintReceipt: Boolean;
        procedure DoOpenTill;
        procedure AbortReceipt;
        procedure SetIsPersoanaJuridica(const Value: Boolean);
        function GetIsPersoanaJuridica: Boolean;
        procedure SetDOCID(const Value: Integer);
        procedure AddGoods(const GoodsID: Integer; const GoodsName: string; const QTY: Double; const Price:
            Currency; SumaTVA: Double);
        procedure AddSummaryReceipt(const NumarBon: Integer; const PrintedDate: TDateTime; const Suma:
            Currency; const PersJuridica, BonPartial, Numerar: Boolean; const UserName: string; const
            IsJustPrinted: Boolean = False);
        function FP_Error(const FP: TZekaFP; const CriticalProcedure: Boolean = False): Boolean;
        procedure WhenTimeToDetectFiscalPrinter(Sender: TObject);
        procedure ReadGoods;
        function GetIsBonPartial: Boolean;
        function GetIsNumerar: Boolean;
        function CheckParams: Boolean;
        function SaveReceiptToDB2(const DocID, NumarBon: Integer; const PersJuridica,
            BonPartial, Numerar: Boolean; const DataBon: TDateTime; const Suma:
            Currency): Boolean;
        procedure SetPrintWithoutPrinter(const Value: Boolean);
        procedure NotifyInvalidTaxGroup(TaxGroup: string);
        procedure SetPKO_DOCID(const Value: Integer);
        procedure SetRASHOD_DOCID(const Value: Integer);
        procedure ReadDocumentInfo(const DocID: Integer; const TargetDocInfo: TDocumentInfo; const
            LoadReceipsSuma: Boolean = False);
        procedure DisplayPrifodFacturaInfo;
        function CheckDocs: Boolean;
        procedure ApplyDocsInfo;
    protected
    { protected declarations }
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
    public
    { Public declarations }
        property PrintWithoutPrinter: Boolean read FPrintWithoutPrinter write SetPrintWithoutPrinter;

    // documentul Rashod
        property RASHOD_DOCID: Integer read fRASHOD_DOCID write SetRASHOD_DOCID;
    // documentul factura
        property FACTURA_DOCID: Integer read fFactura_DOCID write SetDOCID;
    // documentul Phihodnii Kassovii Order
        property PKO_DOCID: Integer read fPKO_DOCID write SetPKO_DOCID;
        property IsPersoanaJuridica: Boolean read GetIsPersoanaJuridica write SetIsPersoanaJuridica;
        property IsBonPartial: Boolean read GetIsBonPartial;
        property IsNumerar: Boolean read GetIsNumerar;
        property ReceiptSuma: Currency read fReceiptSuma;
        property ReceiptPrinted: Boolean read fReceiptPrinted;
        property NumarBon: Integer read fNumarBon;
        property DataBon: TDateTime read fDataBon;
    end;

implementation

uses
  DataModuleAdditions, DataModuleDB, DateUtils, SWNConst, SWNDBErrors, SWNUtils, SWNValueStorageUnit;

{$R *.dfm}
{ TfrmReceiptPrintDlg }

procedure TfrmReceiptPrintV1Dlg.AbortReceipt;
var
    FP: TZekaFP;
begin
    FP := TZekaFP.Create(Self);
    try
        FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
        FP.TerminateBon(0);
        if not FP_Error(FP) then
            ShowInfoDialog('Bon fiscal', 'Bonul fiscal a fost anulat!');
    finally
        FP.Free;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.AddGoods(const GoodsID: Integer; const GoodsName: string; const QTY: Double;
    const Price: Currency; SumaTVA: Double);
var
    N: Integer;
    Suma: Currency;
begin
    N := cxGridTable.DataController.AppendRecord;
    cxGridTable.DataController.Values[N, cxGridTable_NO.Index] := N + 1;
    cxGridTable.DataController.Values[N, cxGridTable_GOODSID.Index] := GoodsID;
    cxGridTable.DataController.Values[N, cxGridTable_TITLE.Index] := Copy(StringReplace(GoodsName, '  ', '', [rfReplaceAll]),
        1, 34);
    cxGridTable.DataController.Values[N, cxGridTable_QTY.Index] := QTY;
    cxGridTable.DataController.Values[N, cxGridTable_RPICE.Index] := Price;
    Suma := Price * QTY;
    cxGridTable.DataController.Values[N, cxGridTable_SUMA.Index] := Suma;
    cxGridTable.DataController.Values[N, cxGridTable_SumaTVA.Index] := SumaTVA;
    cxGridTable.DataController.Values[N, cxGridTable_TVA.Index] := Round(100 * SumaTVA / (Suma - SumaTVA));
end;

procedure TfrmReceiptPrintV1Dlg.AddSummaryReceipt(const NumarBon: Integer; const PrintedDate: TDateTime; const
    Suma: Currency; const PersJuridica, BonPartial, Numerar: Boolean; const UserName: string; const
    IsJustPrinted: Boolean = False);
var
    N: Integer;
    S: string;
begin
    if BonPartial then
        S := 'Bon fiscal partial pentru '
    else
        S := 'Bon fiscal pentru ';
    if PersJuridica then
        S := S + 'persoana juridica, '
    else
        S := S + 'persoana fizica, ';
    if Numerar then
        S := S + 'prin Numerar'
    else
        S := S + 'prin Card Bancar';

    N := cxGridTableViewR.DataController.AppendRecord;
    cxGridTableViewR.DataController.Values[N, cxGridTableViewR_Col0.Index] := NumarBon;
    cxGridTableViewR.DataController.Values[N, cxGridTableViewR_Col1.Index] := PrintedDate;
    cxGridTableViewR.DataController.Values[N, cxGridTableViewR_Col2.Index] := S;
    cxGridTableViewR.DataController.Values[N, cxGridTableViewR_Col3.Index] := Suma;
    cxGridTableViewR.DataController.Values[N, cxGridTableViewR_Col4.Index] := IsJustPrinted;
    cxGridTableViewR.DataController.Values[N, cxGridTableViewR_Col5.Index] := UserName;
end;

procedure TfrmReceiptPrintV1Dlg.ApplyDocsInfo;
begin
     // load œËıÓ‰Ì˚È Í‡ÒÒÓ‚˚È Ó‰Â / œËıÓ‰ ‰ÂÌÂ„ Ì‡ Ò˜ÂÚ info
    if rbUseExistingDocument.Checked and not VarIsNull(lcbExistingDocumentSelector.EditValue) and (lcbExistingDocumentSelector.EditValue
        <> -1) then
    begin
        ReadDocumentInfo(lcbExistingDocumentSelector.EditValue, fTargetPrihodDocInfo);
          // corelatia dintre suma prohodului si suma rashodului
        if (fTargetPrihodDocInfo.Suma <> fRashodDocInfo.Suma) then
        begin
               // suma difera, numai cek partial
            cmbCekType.Enabled := False;
            cmbCekType.ItemIndex := 1;
        end;
          // suma nu poate fi modificata
        edPaySuma.Enabled := False;
        edPaySuma.Tag := 1; // indica ca Enabled si Suma nu poate fi modificat
          // daca nu exista rashod, luam suma din factura
        if (fRashodDocInfo.DocID = -1) then
            edPaySuma.Text := FloatToStr(fFacturaDocInfo.Suma)
        else
            edPaySuma.Text := FloatToStr(fTargetPrihodDocInfo.Suma);

          // daca nu este rashod, activam selectia tipului cekului
        if (fRashodDocInfo.DocID = -1) then
        begin
            cmbCekType.Enabled := True;
            cmbCekType.ItemIndex := 0;
            cmbHalfReceipeText.Enabled := True;
        end;

          // setam payment type conform tipului documentului
        case fTargetPrihodDocInfo.DocTypeID of
            116:
                cmbFR_PaymentType.ItemIndex := 0;
            120:
                cmbFR_PaymentType.ItemIndex := 1;
        end;
          // userul nu poate selecta
        cmbFR_PaymentType.Enabled := False;
    end
    else
    begin
        edPaySuma.Tag := 0;
        edPaySuma.Enabled := True;
        if fSumaPartial <> 0 then
            cmbCekType.ItemIndex := 1
        else
        begin
            cmbCekType.ItemIndex := 0;
            edPaySuma.Enabled := False;
        end;
        edPaySuma.Text := FloatToStr(fTotalSuma - fSumaPartial);

          // setam payment type conform tipului documentului
        if rbCreateœ Œ.Checked then
        begin
            fTargetPrihodDocInfo.DocTypeID := 116;
            cmbFR_PaymentType.ItemIndex := 0   // œËıÓ‰Ì˚È Í‡ÒÒÓ‚˚È Ó‰Â (Õ‡ÎË˜Ì˚È ‡Ò˜ÂÚ)
        end
        else if rbCreateœƒÕ—.Checked then
        begin
            fTargetPrihodDocInfo.DocTypeID := 120;
            cmbFR_PaymentType.ItemIndex := 1; // œËıÓ‰ ‰ÂÌÂ„ Ì‡ Ò˜ÂÚ (¡‡ÌÍÓ‚ÒÍ‡ˇ Í‡ÚÓ˜Í‡)
        end;
          // userul nu poate selecta
        cmbFR_PaymentType.Enabled := False;
    end;

     // load œËıÓ‰Ì˚È Í‡ÒÒÓ‚˚È Ó‰Â / œËıÓ‰ ‰ÂÌÂ„ Ì‡ Ò˜ÂÚ info
    if rbUseExistingSF.Checked and not VarIsNull(lcbFacturaSelect.EditValue) and (lcbFacturaSelect.EditValue <> -1) then
    begin
        ReadDocumentInfo(lcbFacturaSelect.EditValue, fTargetFacturaDocInfo, True);
          // verificam daca se mai poate de eliberat ceck
        if (fTargetFacturaDocInfo.SumaByReceips >= fFacturaDocInfo.Suma) then
        begin
               // blockam imprimarea
            btnPrintReceipt.Enabled := False;
            lbMaxSuma.Caption := Format(lbMaxSuma.Caption, [fTargetFacturaDocInfo.SumaByReceips,
                fRashodDocInfo.Suma - fTargetFacturaDocInfo.SumaByReceips]);
        end;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.btnAbortReceiptClick(Sender: TObject);
begin
    if ShowAskDialog('Bon fiscal', 'Anularea ultimului bon fiscal tiparit neinchis?') = mrYes then
        AbortReceipt;
end;

procedure TfrmReceiptPrintV1Dlg.btnNextToReceiptClick(Sender: TObject);
begin
    cxPageControl.ActivePage := tbsPrihodSceot;
end;

procedure TfrmReceiptPrintV1Dlg.btnOpenTillClick(Sender: TObject);
begin
    DoOpenTill;
    btnClose.SetFocus;
end;

procedure TfrmReceiptPrintV1Dlg.btnPrintReceiptClick(Sender: TObject);
var
    S, S2: string;
begin
    if CheckParams then
    begin
        fIsPersoanaJuridica := cmbFR_PersoanaType.ItemIndex = 1;

        if (cmbCekType.ItemIndex = 0) then
            S2 := 'deplin'
        else
            S2 := 'partial';
        S := #13#10;

        if (fIsPersoanaJuridica) then
            S := S + 'persoana juridica'
        else
            S := S + 'persoana fizica';
        S := S + #13#10;

        if (cmbFR_PaymentType.ItemIndex = 0) then
            S := S + 'in numerar'
        else
            S := S + 'cu card bancar';
        S := S + #13#10 + 'in suma de ' + FormatFloat('0,00.00', StrToCurr(edPaySuma.Text)) + ' Lei?';

        if ShowAskDialog('Bon fiscal', 'Tipar ' + S2 + ' bon fiscal pentru ' + S) = mrYes then
        begin
            btnPrintReceipt.Enabled := False;
            tbsPrintProgress.TabVisible := True;
            cxPageControl.ActivePage := tbsPrintProgress;
            Application.ProcessMessages;

            if (fPrinterExists and fCanPrintOnFP) then
            begin
                if DoPrintReceipt then
                    SaveReceiptToDB2(fFactura_DOCID, fNumarBon, fIsPersoanaJuridica, GetIsBonPartial,
                        GetIsNumerar, fDataBon, fReceiptSuma);
                fReceiptPrinted := True;
            end
            else if FPrintWithoutPrinter then
            begin
                fNumarBon := Random(200) + 800;
                fDataBon := Now;
                fReceiptSuma := StrToCurr(edPaySuma.Text);
                SaveReceiptToDB2(fFactura_DOCID, fNumarBon, fIsPersoanaJuridica, GetIsBonPartial, GetIsNumerar,
                    fDataBon, fReceiptSuma);
                fReceiptPrinted := True;

                MessageDlg('Bonul nu poate fi tiparit pe MCC!!!', mtError, [mbOK], 0);
                ModalResult := mrOk;
            end
        end;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.btnCheckDocsClick(Sender: TObject);
begin
    if CheckDocs then
    begin
        ApplyDocsInfo;
        cxPageControl.ActivePage := tbsReceipt;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.cbDocsCheckedEnter(Sender: TObject);
begin
    rbUseExistingDocument.Checked
end;

function TfrmReceiptPrintV1Dlg.CheckDocs: Boolean;
var
    ErrorStr: string;
    PrihodInfo: TDocumentInfo;
    FacturaInfo: TDocumentInfo;
begin
    Result := False;
    ErrorStr := '';

    if not (rbCreateœ Œ.Checked or rbCreateœƒÕ—.Checked or rbUseExistingDocument.Checked) then
        AddErrorToStr(ErrorStr, 'Nu este ales tipul operatiei!');

    if rbUseExistingDocument.Checked and (VarIsNull(lcbExistingDocumentSelector.EditValue) or (lcbExistingDocumentSelector.EditValue
        = -1)) then
        AddErrorToStr(ErrorStr, 'Nu este ales documentul de incasare a mijloacelor finantiare');

    if rbUseExistingSF.Checked and (VarIsNull(lcbFacturaSelect.EditValue) or (lcbFacturaSelect.EditValue = -1)) then
        AddErrorToStr(ErrorStr, 'Nu este aleasa Factura Fiscala!');

    PrihodInfo := TDocumentInfo.Create;
    FacturaInfo := TDocumentInfo.Create;

    if rbUseExistingDocument.Checked and not VarIsNull(lcbExistingDocumentSelector.EditValue) and (lcbExistingDocumentSelector.EditValue
        <> -1) then
    begin
          // load œËıÓ‰Ì˚È Í‡ÒÒÓ‚˚È Ó‰Â / œËıÓ‰ ‰ÂÌÂ„ Ì‡ Ò˜ÂÚ info
        ReadDocumentInfo(lcbExistingDocumentSelector.EditValue, PrihodInfo);

          // daca nu este indicat Rashodu, nu se verifica
        if (fRashodDocInfo.DocID <> -1) then
        begin
            if (PrihodInfo.Suma > fRashodDocInfo.Suma) then
                AddErrorToStr(ErrorStr, 'Suma pe documentul dat este mai mare ca in documentul "Rezervare"!');
        end;
    end;

    if rbUseExistingSF.Checked and not VarIsNull(lcbFacturaSelect.EditValue) and (lcbFacturaSelect.EditValue <> -1) then
    begin
          // —˜ÂÚ-Ù‡ÍÚÛ‡
        ReadDocumentInfo(lcbFacturaSelect.EditValue, FacturaInfo, True);

        if fRashodDocInfo.DocID > 1 then
        begin
            if (FacturaInfo.Suma > fRashodDocInfo.Suma) then
                AddErrorToStr(ErrorStr, 'Suma in factura fiscala e mai mare decit in "Rezerva"!');
            if (FacturaInfo.SumaByReceips >= fRashodDocInfo.Suma) then
                AddErrorToStr(ErrorStr, 'Pentru documentul dat toate bonurile au fost eliberate!');
        end;
    end;

    if (PrihodInfo.DocID <> -1) and (FacturaInfo.DocID <> -1) then
    begin
          // daca nu este indicat Rashodu, nu se verifica
        if (fRashodDocInfo.DocID <> -1) then
        begin
               // daca suma PKO este mai mare dekit suma facturii
            if (PrihodInfo.Suma > FacturaInfo.Suma) then
                AddErrorToStr(ErrorStr, 'Suma Orinului de Incasare este mai mare decit in factura!');
        end;
    end;

    PrihodInfo.Free;
    FacturaInfo.Free;

    if (ErrorStr = '') and not cbDocsChecked.Checked then
        AddErrorToStr(ErrorStr, 'Nu au fost verificate toate datele!');

    if ErrorStr = '' then
        Result := True
    else
        ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

function TfrmReceiptPrintV1Dlg.CheckParams: Boolean;
var
    ErrorStr: string;
    Value: Currency;
begin
    Result := False;
    ErrorStr := '';

    Value := 0;

    if Trim(edPaySuma.Text) = '' then
        AddErrorToStr(ErrorStr, 'Nu este indicata suma spre plata!')
    else
    begin
        Value := StrToCurrDef(edPaySuma.Text, -1);
        if Value <= 0 then
            AddErrorToStr(ErrorStr, 'Suma din Bon nu corespunde cu suma din "Factura"!');
        if (Value <> fTotalSuma) and (cmbCekType.ItemIndex = 0) then
            AddErrorToStr(ErrorStr,
                'Suma din Bon nu corespunde cu suma din "Factura" pentru bonul fiscal! Verficati cifrele dupa virgula ca cantitate > 1');
//        if (Value = fTotalSuma) and (cmbCekType.ItemIndex <> 0) then
//            AddErrorToStr(ErrorStr, 'Suma din Bon nu corespunde cu suma din "Factura" pentru bonul fiscal partial!');

        // daca clientul e persoana juridica atunci suma nu poate fi mai mare de 10000 pentru achitare numerar
        if (cmbFR_PersoanaType.ItemIndex = 1) and // persoana juridica
            (cmbFR_PaymentType.ItemIndex=0) and // plata in numerar
            (StrToFloat(edPaySuma.Text) >= 10000) then
        begin
          AddErrorToStr(ErrorStr, 'Suma achitata in numerar de la persoana juridica nu poate fi mai mare decit 10000.00 LEI');
        end;

        if cbIncasareNumerarStatus.ItemIndex = -1 then
          AddErrorToStr(ErrorStr, 'Alegeti tipul achitarii');
    end;

    if ErrorStr = '' then
        Result := True
    else
        ShowErrorDialog('Eroare!!!', ErrorStr);
end;

procedure TfrmReceiptPrintV1Dlg.cmbCekTypeClick(Sender: TObject);
begin
    if (edPaySuma.Tag = 1) then
        Exit;

    if (cmbCekType.ItemIndex = 0) then
    begin
        edPaySuma.Enabled := False;
        edPaySuma.Text := FloatToStr(fTotalSuma);
        cmbHalfReceipeText.Enabled := False;
    end
    else
    begin
        edPaySuma.Enabled := True;
        edPaySuma.Text := FloatToStr(fTotalSuma - fSumaPartial);
        cmbHalfReceipeText.Enabled := True;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
    TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    if ARecord.Values[cxGridTable_RPICE.Index] <= 0 then
        AStyle := dmAdditions.cxStyle_TextColorRed;
end;

procedure TfrmReceiptPrintV1Dlg.cxGridTableViewRStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
    TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    if VarIsOrdinal(ARecord.Values[cxGridTableViewR_Col4.Index]) and (ARecord.Values[cxGridTableViewR_Col4.Index]
        = True) then
        AStyle := dmAdditions.cxStyle_Bold;
end;

procedure TfrmReceiptPrintV1Dlg.cxGridTableViewR_Col1GetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
    TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridTableViewR_Col1.Index]) then
        AText := FormatDateTime('dd-mm-yyyy HH:NN', ARecord.Values[cxGridTableViewR_Col1.Index]);
end;

procedure TfrmReceiptPrintV1Dlg.TryOpenFiscalPrinter;
var
    FP: TZekaFP;
    N: Cardinal;
    BaundRate: Word;
    COMPort: Word;
    fFactoryNumber: string;
    D: TDateTime;
    TaxPerc: ITaxNumbers;
    Query: TIBCQuery;
begin
    FP := TZekaFP.Create(Self);
    try
        try
            FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
            fFactoryNumber := FP.GetFactoryNumber;

            Query := TIBCQuery.Create(Self);
            try
                Query.SQL.Text := 'SELECT CANPRINT FPDeviceFound from SP_CANPRINTFPDEVICE(:FIRMAID, :SERIAL_NUMBER)';
                Query.ParamByName('FIRMAID').AsInteger := dmDB.FirmaInfo.FirmaID;
                Query.ParamByName('SERIAL_NUMBER').AsString := fFactoryNumber;
                Query.Open;
                fCanPrintOnFP := Query.FieldByName('FPDeviceFound').AsInteger = 1;
            finally
                Query.Free;
            end;

            if (fCanPrintOnFP) and (FP.errorCode = 0) then
                fPrinterExists := True
            else
            begin
        // error
                N := FP.FindFirstFPCOM;
                if N > 0 then
                begin
                    COMPort := N and $0000FFFF;
                    BaundRate := N shr 16;

                    FP.Setup(COMPort, BaundRate, 3, 1000);
                    fFactoryNumber := FP.GetFactoryNumber;
                    if FP.errorCode = 0 then
                    begin
            // save found values
                        fPrinterPort := COMPort;
                        fPrinterBoundRate := BaundRate;
            // mark as found
                        fPrinterExists := True;

            // save settings
                        AppConfigStorage.IntValues.SetValue(cSETTINGS_AppFiscalPrinterComPort, fPrinterPort);
                        AppConfigStorage.IntValues.SetValue(cSETTINGS_AppFiscalPrinterBoundRate, fPrinterBoundRate);
                    end;
                end
                else
                begin
                    lbPrinterInfo.Font.Color := clRed;
                    lbPrinterInfo.Caption := 'MCC nu a fost gasita!';
                end;
            end;

            if (fCanPrintOnFP) and fPrinterExists then
            begin
        // printer found, show info
                lbInfo1.Visible := True;
                lbInfo2.Visible := True;

                lbInfo1.Caption := 'Fiscal Number: ' + FP.GetFiscalNumber;
                lbInfo2.Caption := 'Tax Number: ' + FP.GetTaxNumber;

                lbPrinterInfo.Font.Color := clGreen;
                lbPrinterInfo.Caption := 'MCC ' + fFactoryNumber + ' (' + FP.GetVersion + ') Ì‡ COM' +
                    IntToStr(fPrinterPort);
                fPrinterExists := True;

                D := FP.GetDateTime;
                lbFP_DateTime.Caption := FormatDateTime('dd MMMM yyyy, HH:NN', D);

        // check time differences
                N := MinutesBetween(Now, D);
                if N >= cFISCAL_PRINTER_MaxMinutesDifferenceAllowed then
                begin
                    lbFP_DateTime.Caption := lbFP_DateTime.Caption + ' (Diferenta in minute: ' + IntToStr(N) + ')';
                    lbFPDateTimeWarning.Visible := True;
                end;

        // get fiscal groups (TVA groups)
                TaxPerc := ITaxNumbers(FP.GetTaxPercents);
                if (TaxPerc.taxgrp1 <> 20) then
                begin
                    fPrinterExists := False;

          // disable print
                    btnNextToReceipt.Enabled := False;
                    btnPrintReceipt.Enabled := False;
                    cmbFR_PersoanaType.Enabled := False;
                    cmbFR_PaymentType.Enabled := False;
                    cmbCekType.Enabled := False;
                    edPaySuma.Enabled := False;

                    lbInvalidTVAGroup.Visible := True;
                    NotifyInvalidTaxGroup('TaxGroup A');
                end;

//                if (TaxPerc.taxgrp2 <> 8) then
//                begin
//                    fPrinterExists := False;
//
//          // disable print
//                    btnNextToReceipt.Enabled := False;
//                    btnPrintReceipt.Enabled := False;
//                    cmbFR_PersoanaType.Enabled := False;
//                    cmbFR_PaymentType.Enabled := False;
//                    cmbCekType.Enabled := False;
//                    edPaySuma.Enabled := False;
//
//                    lbInvalidTVAGroup.Visible := True;
//                    NotifyInvalidTaxGroup('TaxGroup B');
//                end;

            end
            else
            begin
                if (not fCanPrintOnFP) then
                begin
                    fPrinterExists := False;
                    lbPrinterInfo.Font.Color := clRed;
                    lbPrinterInfo.Caption := 'Nu aveti dreptul de a tipari la acest MCC din aceasta firma!';
                end;
            end;
        except
            fPrinterExists := False;
            lbPrinterInfo.Font.Color := clRed;
            lbPrinterInfo.Caption := 'Nu a fost gasit support sofrware pentru imprimanta fiscala !';
        end;
    finally
        FP.Free;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.WhenTimeToDetectFiscalPrinter(Sender: TObject);
begin
    lbPrinterInfo.Caption := 'Caut MCC...';
    Application.ProcessMessages;
    try
        TryOpenFiscalPrinter;
        ReadGoods;
    finally
    // SetupButtons;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.DisplayPrifodFacturaInfo;
begin
     // Prihod
    if fPrihodDocInfo.DocID = -1 then
    begin
        rbCreateœ Œ.Checked := False;
        rbCreateœƒÕ—.Checked := False;
        rbUseExistingDocument.Checked := False;
        lcbExistingDocumentSelector.Enabled := False;
    end
    else
    begin
        rbCreateœ Œ.Checked := False;
        rbCreateœƒÕ—.Checked := False;
        rbUseExistingDocument.Checked := True;
        lcbExistingDocumentSelector.Enabled := True;
        lcbExistingDocumentSelector.EditValue := fPrihodDocInfo.DocID;
    end;

     // Factura
    if fFacturaDocInfo.DocID = -1 then
    begin
        rbCreateSF.Checked := True;
        rbUseExistingSF.Checked := False;
        lcbFacturaSelect.Enabled := False;
    end
    else
    begin
        rbCreateSF.Checked := False;
        rbUseExistingSF.Checked := True;
        rbCreateSF.Enabled := False;
        lcbFacturaSelect.Enabled := True;
        lcbFacturaSelect.EditValue := fFacturaDocInfo.DocID;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.DoOpenTill;
var
    FP: TZekaFP;
begin
    FP := TZekaFP.Create(Self);
    try
        FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
        FP.OpenTill;
    finally
        FP.Free;
    end;
end;

function TfrmReceiptPrintV1Dlg.DoPrintReceipt: Boolean;
var
    FP: TZekaFP;
    N, i: Integer;
    GoodsTitle: string;
    GoodsQTY: Double;
    GoodsPrice: Double;
    GoodsVAT: Integer;
    hasError: Boolean;
    paySuma: Currency;
    taxGroup: Integer;
begin
    Result := False;
    hasError := False;

    fReceiptPrinted := False;
    fNumarBon := -1;
    fDataBon := 0;
    paySuma := StrToCurr(edPaySuma.Text);

    FP := TZekaFP.Create(Self);
    try
        FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
        FP.OpenFiscalBon(Ord(fIsPersoanaJuridica) + 1, '0000', 0, 0);
        if not FP_Error(FP, True) then
        begin
            if cmbCekType.ItemIndex = 0 then
             // œÓÎÌ˚È ˜ÂÍ
                for i := 0 to cxGridTable.DataController.RecordCount - 1 do
                begin
                    GoodsTitle := cxGridTable.DataController.Values[i, cxGridTable_TITLE.Index];
                    GoodsQTY := cxGridTable.DataController.Values[i, cxGridTable_QTY.Index];
                    GoodsPrice := cxGridTable.DataController.Values[i, cxGridTable_RPICE.Index];
                    GoodsVAT := cxGridTable.DataController.Values[i, cxGridTable_TVA.Index];

                       case GoodsVat of
                           20: taxGroup := 1; // VAT=20%
                           10: taxGroup := 3;   // VAT=10% Horeca
                           8:  taxGroup := 2;  // VAT=8%
                           0:  taxGroup := 5; // Fara tva
                       else
                        taxGroup := 1;
                       end;
                    if (TaxGroup=5) and (SWNUtils.ShowAskDialog('SWN', 'Va fi tiparit cecul cu TVA 0!', 'Continuati?')=mrYes) then
                    begin
                        FP.SellFree(GoodsTitle, taxGroup, GoodsPrice, GoodsQTY, 0);
                        if FP_Error(FP, True) then
                        begin
                            hasError := True;
                            Break;
                        end;
                    end
                    else
                    begin
                        FP.SellFree(GoodsTitle, taxGroup, GoodsPrice, GoodsQTY, 0);
                        if FP_Error(FP, True) then
                        begin
                            hasError := True;
                            Break;
                        end;
                    end;
                end
            else             // œÓÎÓ‚ËÌÌ˚È ˜ÂÍ, print only 1 item with selected sum
            begin
                GoodsVAT := 20;                 // in avansuri TVA intotdeauna este 20%
                case GoodsVat of
                    20: taxGroup := 1; // VAT=20%
                    10: taxGroup := 3;   // VAT=10% Horeca
                    8:  taxGroup := 2;  // VAT=8%
                    0:  taxGroup := 5; // fara tva
                else
                    taxGroup := 1;
                end;

                if (TaxGroup=5) and (SWNUtils.ShowAskDialog('SWN', 'Va fi tiparit cecul cu TVA 0!', 'Continuati?')=mrYes) then
                begin
                    FP.SellFree(cmbHalfReceipeText.Text, taxGroup, paySuma, 1, 0);
                    if FP_Error(FP, True) then
                    begin
                        hasError := True;
                    end;
                end
                else
                begin
                    FP.SellFree(cmbHalfReceipeText.Text, taxGroup, paySuma, 1, 0);
                    if FP_Error(FP, True) then
                    begin
                        hasError := True;
                    end;
                end;
            end;
        end
        else
            hasError := True;

        if not hasError then
        begin
            case cmbFR_PaymentType.ItemIndex of

                0: // NUMERAR
                    FP.Payment(paySuma, 0, 1);
                1: // CARD BANCAR
                    FP.Payment(paySuma, 1, 1);
            end;

            if not FP_Error(FP, True) then
            begin
                FP.CloseFiscalBon;
                if not FP_Error(FP, True) then
                begin
                    N := FP.GetBonNumber;

                    fReceiptPrinted := True;
                    fNumarBon := N;
                    fDataBon := FP.GetDateTime;
                    fReceiptSuma := paySuma;

                    AddSummaryReceipt(fNumarBon, fDataBon, paySuma, fIsPersoanaJuridica, cmbCekType.ItemIndex
                        = 1, cmbFR_PaymentType.ItemIndex = 0, dmDB.CurrentUserFullName, True);

                    tbsReceipt.TabVisible := False;
                    tbsReceiptSummary.TabVisible := True;
                    cxPageControl.ActivePage := tbsReceiptSummary;

                    Result := True; // bonul este imprimat fara erori
                end;
            end;
        end;
    finally
        FP.Free;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.FormCreate(Sender: TObject);
begin
    fPrinterPort := 1; // COM1
    fPrinterBoundRate := 9600;
    fPrinterExists := False;
    fIsPersoanaJuridica := False;
    fTotalSuma := 0;
    fReceiptSuma := 0;
    fReceiptPrinted := False;
    fNumarBon := -1;
    fDataBon := 0;
    FPrintWithoutPrinter := False;

    fRASHOD_DOCID := -1;
    fFactura_DOCID := -1;
    fPKO_DOCID := -1;

    fRashodDocInfo := TDocumentInfo.Create;
    fPrihodDocInfo := TDocumentInfo.Create;
    fFacturaDocInfo := TDocumentInfo.Create;
    fTargetPrihodDocInfo := TDocumentInfo.Create;
    fTargetFacturaDocInfo := TDocumentInfo.Create;

    cxPageControl.ActivePage := tbsInfo;
    lbFPDateTimeWarning.Visible := False;
    lbPriceZeroWarning.Visible := False;

  // hide tabs
    tbsPrintProgress.TabVisible := False;
    tbsGoods.TabVisible := False;
    tbsReceipt.TabVisible := False;
    tbsReceiptSummary.TabVisible := False;
    tbsError.TabVisible := False;
    tbsPrihodSceot.TabVisible := False;
end;

procedure TfrmReceiptPrintV1Dlg.FormDestroy(Sender: TObject);
begin
    fRashodDocInfo.Free;
    fPrihodDocInfo.Free;
    fFacturaDocInfo.Free;
    fTargetPrihodDocInfo.Free;
    fTargetFacturaDocInfo.Free;
end;

function TfrmReceiptPrintV1Dlg.FP_Error(const FP: TZekaFP; const CriticalProcedure: Boolean): Boolean;
var
    Error: Integer;
begin
    Error := FP.errorCode;
    Result := Error <> 0;
    if Result then
    begin
        mmErrors.Lines.Add(FP.GetErrorString(Error, 0));
    // check for specific error code and enable error recovery tab
        if CriticalProcedure then
        begin
            tbsReceipt.TabVisible := False;
            btnNextToReceipt.Visible := False;
            tbsError.TabVisible := True;
            cxPageControl.ActivePage := tbsError;
        end;
    end;
end;

function TfrmReceiptPrintV1Dlg.GetIsBonPartial: Boolean;
begin
    Result := cmbCekType.ItemIndex = 1;
end;

function TfrmReceiptPrintV1Dlg.GetIsNumerar: Boolean;
begin
    Result := cmbFR_PaymentType.ItemIndex = 0;
end;

function TfrmReceiptPrintV1Dlg.GetIsPersoanaJuridica: Boolean;
begin
    Result := cmbFR_PersoanaType.ItemIndex = 1;
end;

function TfrmReceiptPrintV1Dlg.IsFormDataPosted: Boolean;
begin
    Result := True;
end;

procedure TfrmReceiptPrintV1Dlg.NotifyInvalidTaxGroup(TaxGroup: string);
var
    Query: TIBCQuery;
begin
    MessageDlg('Grupa Fiscala gresita! La MCC nu este corecta grupa '+TaxGroup+'!. Nu tipariti bonuri!', mtError, [mbOK], 0);
    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.SQL.Text := 'INSERT INTO EMAIL_MESSAGES(EMAIL,SUBJECT,BODY,SOURCE_TABLE) VALUES (:email,:subj,:body,-1)';
        Query.ParamByName('email').AsString := 'marketing@fantastic.md';
        Query.ParamByName('subj').AsString := 'Grupa fiscala gresita la aparatul de casa!';
        Query.ParamByName('body').AsString := Format('Firma: %s, Utilizator: %s. La Aparatul de casa nu este corecta grupa TVA A! Luati masuri imediat!',
            [dmDB.CurrentFirmaName, dmDB.CurrentUserFullName]);
        Query.Transaction := IBCTrUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            Query.Transaction.Commit;
        except
            Query.Transaction.Rollback;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.Prepare;
begin
  // settings
    fPrinterPort := AppConfigStorage.IntValues.GetValue(cSETTINGS_AppFiscalPrinterComPort, cFISCAL_PRINTER_DefaultCOMport);
    fPrinterBoundRate := AppConfigStorage.IntValues.GetValue(cSETTINGS_AppFiscalPrinterBoundRate,
        cFISCAL_PRINTER_DefaultBoundRate);

    lbInvalidTVAGroup.Visible := False;

  // read Rashod info
    if fRASHOD_DOCID <> -1 then
        ReadDocumentInfo(fRASHOD_DOCID, fRashodDocInfo);
  // if fRashodDocInfo.DocID=-1 then raise Exception.Create('Nu este indicat Rashodul pentru factura!');
     // citim Prohod
    if fPKO_DOCID <> -1 then
        ReadDocumentInfo(fPKO_DOCID, fPrihodDocInfo);

     // citim factura
    if fFactura_DOCID <> -1 then
        ReadDocumentInfo(fFactura_DOCID, fFacturaDocInfo);

     // combo "—Û˘ÂÒÚ‚Û˛˘ËÈ ‰ÓÍÛÏÂÌÚ"
    if fRashodDocInfo.DocID = -1 then
    begin
          // nu este rashod, luam datele din factura
        IBCQueryPKO.ParamByName('DT').AsInteger := fFacturaDocInfo.DT;
        IBCQueryPKO.ParamByName('CT').AsInteger := fFacturaDocInfo.CT;
    end
    else
    begin
        IBCQueryPKO.ParamByName('DT').AsInteger := fRashodDocInfo.DT;
        IBCQueryPKO.ParamByName('CT').AsInteger := fRashodDocInfo.CT;
          // IBCQueryPKO.ParamByName('SUMA').AsCurrency:=fRashodDocInfo.Suma;
    end;
    IBCQueryPKO.Active := True;

    IBCQueryFactura.ParamByName('DT').AsInteger := fFacturaDocInfo.DT;
    IBCQueryFactura.ParamByName('CT').AsInteger := fFacturaDocInfo.CT;
    IBCQueryFactura.ParamByName('SUMA').AsCurrency := fFacturaDocInfo.Suma;
    IBCQueryFactura.Active := True;
    IBCQueryStatutIncasare.Active := True;

    DisplayPrifodFacturaInfo;

     // detect printer
    with TDelayThread.Create(200, WhenTimeToDetectFiscalPrinter) do
        Start;

end;

procedure TfrmReceiptPrintV1Dlg.rbCreateœ ŒClick(Sender: TObject);
begin
    lcbExistingDocumentSelector.Enabled := rbUseExistingDocument.Checked;
end;

procedure TfrmReceiptPrintV1Dlg.rbUseExistingSFClick(Sender: TObject);
begin
    lcbFacturaSelect.Enabled := rbUseExistingSF.Checked;
end;

procedure TfrmReceiptPrintV1Dlg.ReadGoods;
var
    Query: TIBCQuery;
    isGood: Boolean;
    allowFullReceipt: Boolean;
    persJurApplied: Boolean;
    CUSTOMER_TYPE_ID: Integer;
begin
    isGood := True;
    fTotalSuma := 0;
    allowFullReceipt := True;
    fSumaPartial := 0;
    persJurApplied := False;

    CUSTOMER_TYPE_ID := 4001;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        fVAT := dmDB.FirmaInfo.Vat;
        if (fVAT > 0) then
        begin
      // read Customer Info: Type and VAT
            Query.SQL.Text :=
                'SELECT CUSTOMER_TYPE_ID, VAT FROM TS_CUSTOMER WHERE CUSTOMERID=(SELECT CT FROM TDB_DOCS WHERE DOCID=:DOCID)';
            Query.ParamByName('DOCID').AsInteger := fRASHOD_DOCID;
            Query.ExecSQL;
            if not Query.Eof then
            begin
                CUSTOMER_TYPE_ID := Query.Fields[0].AsInteger;
                fVAT := Query.Fields[1].AsInteger;
            end;
            Query.Close;
        end;



    // load list of goods
        Query.SQL.Text := 'SELECT * FROM GET_GOODS_FOR_RECEIPT(:DOCID)';
        if fFactura_DOCID <> -1 then
            Query.ParamByName('DOCID').AsInteger := fFactura_DOCID
        else
            Query.ParamByName('DOCID').AsInteger := fRASHOD_DOCID;

        Query.ExecSQL;
        while not Query.Eof do
        begin
            AddGoods(Query.FieldByName('GOODSID').AsInteger, Trim(Query.FieldByName('NAMEACNT').AsString),
                Query.FieldByName('QTY').AsFloat, Query.FieldByName('PRICE').AsCurrency, Query.FieldByName('SUMAVAT').AsCurrency);

            fTotalSuma := fTotalSuma + Query.FieldByName('PRICE').AsCurrency * Query.FieldByName('QTY').AsFloat;

            if (Query.FieldByName('PRICE').AsCurrency <= 0) or (Query.FieldByName('QTY').AsFloat <= 0) then
                isGood := False;
            Query.Next;
        end;
        Query.Close;

        fIsPersoanaJuridica := dmDB.IsCustomerPersoanaJuridica(CUSTOMER_TYPE_ID);

        if fFactura_DOCID <> -1 then
        begin
      // check for previous printed receipts
            Query.SQL.Text := 'SELECT * FROM VW_DOCS_RECEIPT WHERE (DOCID=:DOCID) AND (FLG_CANCELED=0)';
            Query.ParamByName('DOCID').AsInteger := fFactura_DOCID;
            Query.ExecSQL;
            while not Query.Eof do
            begin
                AddSummaryReceipt(Query.FieldByName('NUMAR_BON').AsInteger, Query.FieldByName('DATA_ELIBERARII').AsDateTime,
                    Query.FieldByName('SUMA').AsCurrency, Query.FieldByName('FLG_PERSOANA_JURIDICA').AsInteger
                    = 1, Query.FieldByName('FLG_BON_PARTIAL').AsInteger = 1, Query.FieldByName('FLG_NUMERAR').AsInteger
                    = 1, Query.FieldByName('USER_NAME').AsString);
                if not persJurApplied then
                begin
                    if (fIsPersoanaJuridica <> (Query.FieldByName('FLG_PERSOANA_JURIDICA').AsInteger = 1)) then
                    begin
                        fIsPersoanaJuridica := Query.FieldByName('FLG_PERSOANA_JURIDICA').AsInteger = 1;
                    end;
                    persJurApplied := True;
                end;

                fSumaPartial := fSumaPartial + Query.FieldByName('SUMA').AsCurrency;
                allowFullReceipt := False;

                Query.Next;
            end;
            Query.Close;
        end;

    // fTotalSuma
    // SumaPartial
    // isGood
    // allowFullReceipt
        if (fTotalSuma - fSumaPartial) <= 0 then
        begin
      // no more receipts, show summary
            tbsReceiptSummary.TabVisible := True;
            cxPageControl.ActivePage := tbsReceiptSummary;
            btnNextToReceipt.Visible := False;
            btnOpenTill.Visible := False;
            tbsPrihodSceot.TabVisible := False;
            lbReceiptSummaryInfo.Caption := 'Pentru documentul dat au fost eliberate toate bonurile!';
        end
        else
        begin
      // allow to print receipt
            cmbFR_PersoanaType.ItemIndex := Ord(fIsPersoanaJuridica);
            tbsGoods.TabVisible := True;
      // tbsReceipt.TabVisible:=isGood and (fPrinterExists or FPrintWithoutPrinter);
            tbsReceipt.TabVisible := False;
            tbsPrihodSceot.TabVisible := isGood and (fPrinterExists or FPrintWithoutPrinter);
            btnNextToReceipt.Visible := tbsPrihodSceot.TabVisible;
            lbPriceZeroWarning.Visible := not isGood;

            if lbFPDateTimeWarning.Visible then
                cxPageControl.ActivePage := tbsInfo
            else
                cxPageControl.ActivePage := tbsGoods;

            if fSumaPartial = 0 then
            begin
                lbMaxSuma.Visible := False;
                edPaySuma.Text := FloatToStr(fTotalSuma);
                edPaySuma.Enabled := False;
                cmbHalfReceipeText.Enabled := False;
            end
            else
            begin
                lbMaxSuma.Caption := Format(lbMaxSuma.Caption, [fSumaPartial, fTotalSuma - fSumaPartial]);
                edPaySuma.Text := FloatToStr(fTotalSuma - fSumaPartial);
                tbsReceiptSummary.TabVisible := True;
                cmbHalfReceipeText.Enabled := True;
            end;

            if not allowFullReceipt then
            begin
                cmbCekType.ItemIndex := 1;
                cmbCekType.Enabled := False;
            end;
        end;

        if fVAT = 0 then
            lbCustomerVAT.Caption := 'Fara TVA'
        else
            lbCustomerVAT.Caption := 'TVA - 20%';

    finally
        Query.Free;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.ReadDocumentInfo(const DocID: Integer; const TargetDocInfo: TDocumentInfo; const
    LoadReceipsSuma: Boolean);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.SQL.Add('SELECT DOCID,DT,CT,SUMA,GET_FLG_VALUE(FLAGS,0),DOCTYPEID');
        if LoadReceipsSuma then
            Query.SQL.Add(',(SELECT COALESCE(SUM(SUMA),0) FROM TDB_DOCS_RECEIPT WHERE DOCID=TDB_DOCS.DOCID and get_flg_value(flags,3)=0)');
        Query.SQL.Add('FROM TDB_DOCS WHERE (DOCID=:id)');
        Query.ParamByName('id').AsInteger := DocID;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            TargetDocInfo.DocID := Query.Fields[0].AsInteger;
            TargetDocInfo.DT := Query.Fields[1].AsInteger;
            TargetDocInfo.CT := Query.Fields[2].AsInteger;
            TargetDocInfo.Suma := Query.Fields[3].AsCurrency;
            TargetDocInfo.FLG_ACNT := Query.Fields[4].AsInteger = 1;
            TargetDocInfo.DocTypeID := Query.Fields[5].AsInteger;
            if LoadReceipsSuma then
                TargetDocInfo.SumaByReceips := Query.Fields[6].AsCurrency;
        end;
    finally
        Query.Free;
    end;
end;

function TfrmReceiptPrintV1Dlg.SaveReceiptToDB2(const DocID, NumarBon: Integer;
    const PersJuridica, BonPartial, Numerar: Boolean; const DataBon: TDateTime;
    const Suma: Currency): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := IBCTrUpdate; // am pus o transactie locala, pentru a preveni eroare daca transactia globala cumva a ramas deschisa
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Add('EXECUTE PROCEDURE SP_CREATE_RECEIPT3(');
            Query.SQL.Add(':RDOCID, :TARGET_DOCID, :TARGET_DOCTYPEID, :FACT_DOCID, :FLG_PERSOANA_JURIDICA, :NUMAR_BON, :DATA_ELIBERARII, :FLG_BON_PARTIAL, :FLG_NUMERAR, :SUMA)');

            Query.ParamByName('RDOCID').AsInteger := fTargetFacturaDocInfo.DocID;
            Query.ParamByName('TARGET_DOCID').AsInteger := fTargetPrihodDocInfo.DocID;
            Query.ParamByName('TARGET_DOCTYPEID').AsInteger := fTargetPrihodDocInfo.DocTypeID;
            Query.ParamByName('FACT_DOCID').AsInteger := fTargetFacturaDocInfo.DocID;

            Query.ParamByName('FLG_PERSOANA_JURIDICA').AsInteger := Ord(PersJuridica);
            Query.ParamByName('NUMAR_BON').AsInteger := NumarBon;
            Query.ParamByName('DATA_ELIBERARII').AsDateTime := DataBon;
            Query.ParamByName('FLG_BON_PARTIAL').AsInteger := Ord(BonPartial);
            Query.ParamByName('FLG_NUMERAR').AsInteger := Ord(Numerar);
            Query.ParamByName('SUMA').AsCurrency := Suma;
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmReceiptPrintV1Dlg.SetDOCID(const Value: Integer);
begin
    fFactura_DOCID := Value;
end;

procedure TfrmReceiptPrintV1Dlg.SetIsPersoanaJuridica(const Value: Boolean);
begin
    fIsPersoanaJuridica := Value;
end;

procedure TfrmReceiptPrintV1Dlg.SetPKO_DOCID(const Value: Integer);
begin
    fPKO_DOCID := Value;
end;

procedure TfrmReceiptPrintV1Dlg.SetPrintWithoutPrinter(const Value: Boolean);
begin
    FPrintWithoutPrinter := Value;
end;

procedure TfrmReceiptPrintV1Dlg.SetRASHOD_DOCID(const Value: Integer);
begin
    fRASHOD_DOCID := Value;
end;

{ TReceiptDocumentInfo }

constructor TDocumentInfo.Create;
begin
    DocID := -1;
    SumaByReceips := 0;
end;

end.


