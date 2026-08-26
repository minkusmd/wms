unit frmReceiptPrintDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, StdCtrls, dxGDIPlusClasses, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, ComCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxClasses,
  cxGridLevel, cxGrid, cxLabel, cxCurrencyEdit, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, DialogTitle;

type
  TfrmReceiptPrintDlg = class(TSWNCustomForm)
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    cxGridTable_NO: TcxGridColumn;
    cxGridTable_TITLE: TcxGridColumn;
    cxGridTable_QTY: TcxGridColumn;
    cxGridTable_RPICE: TcxGridColumn;
    cxGridTable_SUMA: TcxGridColumn;
    btnPrint: TButton;
    btnOpenTill: TButton;
    btnClose: TButton;
    rbPF: TRadioButton;
    rbPJ: TRadioButton;
    lbBonNumber: TLabel;
    lbLastSuma: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnCancelReceipt: TButton;
    DialogTitle1: TDialogTitle;
    pnPrinterInfo: TPanel;
    lbInfo1: TLabel;
    lbInfo2: TLabel;
    lbPrinterInfo: TLabel;
    lbIDEN: TLabel;
    lbVAT: TLabel;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOpenTillClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnCancelReceiptClick(Sender: TObject);
    procedure rbPFClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fPrinterPort: integer;
    fPrinterBoundRate: integer;
    fPrinterExists: Boolean;
    fIsPersoanaJuridica: Boolean;
    fTotalSuma:double;
    fDOCID: integer;
    procedure SetPrinterBoundRate(const Value: integer);
    procedure SetPrinterPort(const Value: integer);

    procedure TryOpenFiscalPrinter;
    procedure SetupButtons;

    procedure DoPrintReceipt;
    procedure DoOpenTill;
    procedure DoCancelReceipt;
    procedure SetIsPersoanaJuridica(const Value: Boolean);
    function GetIsPersoanaJuridica: Boolean;
    procedure SetDOCID(const Value: integer);
    procedure AddGoods(const GoodsName:String; const QTY:double; const Price:double);

    procedure WhenTimeToDetectFiscalPrinter(Sender:TObject);
    procedure ReadGoods(const DOCID:integer);
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property DOCID:integer read fDOCID write SetDOCID;

    property PrinterExists:Boolean read fPrinterExists;
    property PrinterPort:integer read fPrinterPort write SetPrinterPort;
    property PrinterBoundRate:integer read fPrinterBoundRate write SetPrinterBoundRate;
    property IsPersoanaJuridica:Boolean read GetIsPersoanaJuridica write SetIsPersoanaJuridica;
    property TotalSuma:Double read fTotalSuma;

  end;


implementation

uses ZFPCOMLib_TLB, DataModuleAdditions, SWNUtils, IBC, DataModuleDB;

{$R *.dfm}

{ TfrmReceiptPrintDlg }

procedure TfrmReceiptPrintDlg.AddGoods(const GoodsName: String; const QTY, Price: double);
var N:integer;
    Suma:Double;
begin
     N:=cxGridTable.DataController.AppendRecord;
     cxGridTable.DataController.Values[N,cxGridTable_NO.Index]:=N+1;
     cxGridTable.DataController.Values[N,cxGridTable_TITLE.Index]:=GoodsName;
     cxGridTable.DataController.Values[N,cxGridTable_QTY.Index]:=QTY;
     cxGridTable.DataController.Values[N,cxGridTable_RPICE.Index]:=Price;
     Suma:=Price*QTY;
     cxGridTable.DataController.Values[N,cxGridTable_SUMA.Index]:=Suma;
     fTotalSuma:=fTotalSuma+Suma;
end;

procedure TfrmReceiptPrintDlg.btnCancelReceiptClick(Sender: TObject);
begin
     DoCancelReceipt;
     btnCancelReceipt.Visible:=False;
end;

procedure TfrmReceiptPrintDlg.btnOpenTillClick(Sender: TObject);
begin
     DoOpenTill;
     btnClose.SetFocus;
end;

procedure TfrmReceiptPrintDlg.btnPrintClick(Sender: TObject);
var S:String;
begin
     S:=#13#10;
     if rbPF.Checked
      then S:=S+'Физического лица'
      else S:=S+'Юридического лица';
     S:=S+#13#10+'на сумму '+FormatFloat('0,00.00',fTotalSuma)+' Лей?';
     if ShowAskDialog('Печать фискального чека','Вы хотите напечатать чек для'+S)=mrYes then
     begin
          DoPrintReceipt;
          rbPF.Enabled:=False;
          rbPJ.Enabled:=False;
          btnPrint.Enabled:=False;
          btnOpenTill.SetFocus;
     end;
end;

procedure TfrmReceiptPrintDlg.TryOpenFiscalPrinter;
var FP:TZekaFP;
    N:cardinal;
    BaundRate:WORD;
    COMPort:Word;
    fFactoryNumber:String;
begin
     FP:=TZekaFP.Create(Self);
     try
        FP.Setup(fPrinterPort,fPrinterBoundRate,3,1000);
        fFactoryNumber:=FP.GetFactoryNumber;
        if FP.errorCode=0 then fPrinterExists:=True
        else
        begin
             // error
             N:=FP.FindFirstFPCOM;
             if N>0 then
             begin
                  COMPort:=N and $0000FFFF;
                  BaundRate:=N shr 16;

                  FP.Setup(COMPort,BaundRate,3,1000);
                  fFactoryNumber:=FP.GetFactoryNumber;
                  if FP.errorCode=0 then
                  begin
                       // save found values
                       fPrinterPort:=COMPort;
                       fPrinterBoundRate:=BaundRate;
                       // mark as found
                       fPrinterExists:=True;
                  end;
             end
             else
             begin
                  lbPrinterInfo.Font.Color:=clRed;
                  lbPrinterInfo.Caption:='Фискальный принтер не найден!';
             end;
        end;

        if fPrinterExists then
        begin
             // printer found, show info
             lbInfo1.Visible:=True;
             lbInfo2.Visible:=True;

             lbInfo1.Caption:='Фискальный номер: '+FP.GetFiscalNumber;
             lbInfo2.Caption:='Налоговый номер: '+FP.GetTaxNumber;

             lbPrinterInfo.Font.Color:=clGreen;
             lbPrinterInfo.Caption:='Фискальный принтер '+fFactoryNumber+' ('+FP.GetVersion+') на COM'+IntToStr(fPrinterPort);
             fPrinterExists:=True;
        end;

     finally
        FP.Free;
     end;

end;

procedure TfrmReceiptPrintDlg.WhenTimeToDetectFiscalPrinter(Sender: TObject);
begin
     lbPrinterInfo.Caption:='Поиск фискального принтера...';
     Application.ProcessMessages;
     try
        TryOpenFiscalPrinter;
     finally
        SetupButtons;
     end;
end;

procedure TfrmReceiptPrintDlg.DoCancelReceipt;
var FP:TZekaFP;
begin
     FP:=TZekaFP.Create(Self);
     try
        FP.Setup(fPrinterPort,fPrinterBoundRate,3,1000);
        FP.TerminateBon(0);
     finally
        FP.Free;
     end;
end;

procedure TfrmReceiptPrintDlg.DoOpenTill;
var FP:TZekaFP;
begin
     FP:=TZekaFP.Create(Self);
     try
        FP.Setup(fPrinterPort,fPrinterBoundRate,3,1000);
        FP.OpenTill;
     finally
        FP.Free;
     end;
end;

procedure TfrmReceiptPrintDlg.DoPrintReceipt;
var FP:TZekaFP;
    N,i:integer;
    GoodsTitle:String;
    GoodsQTY:double;
    GoodsPrice:double;
    hasError:Boolean;
begin
     hasError:=False;
     FP:=TZekaFP.Create(Self);
     try
        FP.Setup(fPrinterPort,fPrinterBoundRate,3,1000);
        FP.OpenFiscalBon(Ord(fIsPersoanaJuridica)+1,'0000',0,0);
        if FP.errorCode=0 then
        for i := 0 to cxGridTable.DataController.RecordCount-1 do
        begin
             GoodsTitle:=cxGridTable.DataController.Values[i,cxGridTable_TITLE.Index];
             GoodsQTY:=cxGridTable.DataController.Values[i,cxGridTable_QTY.Index];
             GoodsPrice:=cxGridTable.DataController.Values[i,cxGridTable_RPICE.Index];

             FP.SellFree(GoodsTitle,1,GoodsPrice,GoodsQTY,0);
             if FP.errorCode<>0 then
             begin
                  hasError:=True;
                  break;
             end;
        end
        else hasError:=True;

        if Not hasError then
        begin
             FP.Payment(fTotalSuma,0,1);
             if FP.errorCode=0 then
             begin
                  FP.CloseFiscalBon;
                  N:=Fp.GetBonNumber;

                  Label5.Visible:=True;
                  lbBonNumber.Visible:=True;
                  Label6.Visible:=True;
                  lbLastSuma.Visible:=True;

                  lbBonNumber.Caption:=Format('%4.4d',[N]);
                  lbLastSuma.Caption:=Format('%f Лей',[fTotalSuma]);
             end
             else hasError:=True;
        end;
        if hasError then btnCancelReceipt.Visible:=True;
     finally
        FP.Free;
     end;
end;

procedure TfrmReceiptPrintDlg.FormCreate(Sender: TObject);
begin
     fPrinterPort:=1; // COM1
     fPrinterBoundRate:=9600;
     fPrinterExists:=False;
     fIsPersoanaJuridica:=False;
     fTotalSuma:=0;
     btnCancelReceipt.Visible:=False;
     btnPrint.Caption:='Печать'+#13#10+'чека';

     lbInfo1.Visible:=False;
     lbInfo2.Visible:=False;

     Label5.Visible:=False;
     lbBonNumber.Visible:=False;
     Label6.Visible:=False;
     lbLastSuma.Visible:=False;

     SetupButtons;
end;

procedure TfrmReceiptPrintDlg.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if (Shift=[]) then
     begin
          if (Key=112) and (rbPF.Enabled) then rbPF.Checked:=True
          else
          if (Key=116) and (rbPJ.Enabled) then rbPJ.Checked:=True;
     end;
end;

procedure TfrmReceiptPrintDlg.FormShow(Sender: TObject);
var DelayTread:TDelayThread;
begin
     DelayTread:=TDelayThread.Create(200,WhenTimeToDetectFiscalPrinter);
     DelayTread.Resume;
end;

function TfrmReceiptPrintDlg.GetIsPersoanaJuridica: Boolean;
begin
     Result:=rbPJ.Checked;
end;

procedure TfrmReceiptPrintDlg.Prepare;
var FP:TZekaFP;
begin
     // check if Fiscal Printer COM is installed on system
     FP:=TZekaFP.Create(Self);
     try
     finally
        FP.Free;
     end;

     ReadGoods(fDOCID);
end;

procedure TfrmReceiptPrintDlg.rbPFClick(Sender: TObject);
begin
     fIsPersoanaJuridica:=rbPJ.Checked;
     if fIsPersoanaJuridica then
     begin
          rbPF.Font.Style:=[];
          rbPJ.Font.Style:=[fsBold];
     end
     else
     begin
          rbPF.Font.Style:=[fsBold];
          rbPJ.Font.Style:=[];
     end;
end;

procedure TfrmReceiptPrintDlg.ReadGoods(const DOCID: integer);
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT * FROM GET_GOODS_FOR_RECEIPT(:DOCID)';
        Query.ParamByName('DOCID').AsInteger:=DOCID;
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             AddGoods(Query.FieldByName('NAMEACNT').AsString,Query.FieldByName('QTY').AsFloat,Query.FieldByName('PRICE').AsFloat);
             Query.Next;
        end;
        Query.Close;
     finally

     end;
end;

procedure TfrmReceiptPrintDlg.SetDOCID(const Value: integer);
begin
     fDOCID := Value;
end;

procedure TfrmReceiptPrintDlg.SetIsPersoanaJuridica(const Value: Boolean);
begin
     fIsPersoanaJuridica:= Value;
     rbPF.Checked:=Not Value;
     rbPJ.Checked:=Value;
end;

procedure TfrmReceiptPrintDlg.SetPrinterBoundRate(const Value: integer);
begin
     fPrinterBoundRate := Value;
end;

procedure TfrmReceiptPrintDlg.SetPrinterPort(const Value: integer);
begin
     fPrinterPort:= Value;
end;

procedure TfrmReceiptPrintDlg.SetupButtons;
var AllowPrint:Boolean;
begin
     AllowPrint:=fPrinterExists and (cxGridTable.DataController.RecordCount>0);

     btnPrint.Enabled:=AllowPrint;
     btnOpenTill.Enabled:=fPrinterExists;
     rbPF.Enabled:=AllowPrint;
     rbPJ.Enabled:=AllowPrint;

     if AllowPrint then
     begin
          Self.ActiveControl:=btnPrint;
     end
     else
     begin
          btnClose.Default:=True;
          Self.ActiveControl:=btnClose;
     end;
end;

end.
