unit frmDocumentPreviewUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Data.DB, DBAccess, IBC, MemDS, cxGraphics,
    cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxButtonEdit, cxCheckBox,
    cxDBEdit, cxCalendar, cxMemo, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
    cxTextEdit, cxMaskEdit, cxCalc, Vcl.StdCtrls, Vcl.ExtCtrls, cxStyles, cxCustomData, cxFilter,
    cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData,
    cxImageComboBox, cxLabel, cxCurrencyEdit, Vcl.Menus, cxButtons, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, dxCoreGraphics,
  RzPanel, RzDlgBtn;

type
    TfrmDocumentPreviewDlg = class(TSWNBaseFormClass)
        IBCQueryDT_Accounts: TIBCQuery;
        IBCDataSourceDT_Accounts: TIBCDataSource;
        IBCDataSourceCT_Accounts: TIBCDataSource;
        IBCQueryCT_Accounts: TIBCQuery;
        IBCQueryRechizite: TIBCQuery;
        IBCDataSourceRechizite: TIBCDataSource;
        IBCDataSourceDocProps: TIBCDataSource;
        IBCQueryDocProps: TIBCQuery;
        pnClient: TPanel;
        Label5: TLabel;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label8: TLabel;
        Label6: TLabel;
        Label11: TLabel;
        Label10: TLabel;
        Label12: TLabel;
        ceRATE: TcxDBCalcEdit;
        lcbDTSC: TcxDBLookupComboBox;
        mmCOMMENTS: TcxDBMemo;
        deDATA: TcxDBDateEdit;
        cbFLG_ACNT: TcxDBCheckBox;
        lcbDTDEP: TcxDBLookupComboBox;
        lcbDT_Account: TcxDBLookupComboBox;
        lcbCT_Account: TcxDBLookupComboBox;
        lcbCTDEP: TcxDBLookupComboBox;
        beDT_NAME: TcxButtonEdit;
        beCT_NAME: TcxButtonEdit;
        ceRATEUSD: TcxDBCalcEdit;
        lcbAnalytics: TcxDBLookupComboBox;
        lcbCURRENCY: TcxDBLookupComboBox;
        lcbCTSC: TcxDBLookupComboBox;
        ceSuma: TcxDBCalcEdit;
        lbSuma: TLabel;
        Label7: TLabel;
        Panel1: TPanel;
        cxGridJurnal: TcxGrid;
        cxGridJurnalTable: TcxGridDBTableView;
        cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
        cxGridDBCol_CTDEP_NAME: TcxGridDBColumn;
        cxGridDBCol_GOODSID: TcxGridDBColumn;
        cxGridDBCol_IMG: TcxGridDBColumn;
        cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
        cxGridDBCol_QTY: TcxGridDBColumn;
        cxGridDBCol_UM_NAME: TcxGridDBColumn;
        cxGridJurna_PRICE: TcxGridDBColumn;
        cxGridJurnal_SUMA: TcxGridDBColumn;
        cxGridDBCol_FLG_READY: TcxGridDBColumn;
        cxGridJurnal_STOCK_QTY: TcxGridDBColumn;
        cxGridJurna_GOODS_ACNT_ID: TcxGridDBColumn;
        cxGridJurnal_GOODS_NAMEACNT: TcxGridDBColumn;
        cxGridJurnal_PRICE_COLUMN: TcxGridDBColumn;
        cxGridJurnal_CREATED_BY_NAME: TcxGridDBColumn;
        cxGridJurnal_FLG_ACTIVE: TcxGridDBColumn;
        cxGridJurnal_UMID: TcxGridDBColumn;
        cxGridJurnalLevel: TcxGridLevel;
        IBCDataSourceDocs: TIBCDataSource;
        IBCQueryDocs: TIBCQuery;
        IBCQueryJurnal: TIBCQuery;
        IBCDataSourceJurnal: TIBCDataSource;
    RzDialogButtons1: TRzDialogButtons;
    Label4: TLabel;
    teUsername: TcxDBTextEdit;
    Label9: TLabel;
    cxDBDateEdit1: TcxDBDateEdit;
    cxDBCheckBox1: TcxDBCheckBox;
    Label13: TLabel;
    cxDBTextEdit1: TcxDBTextEdit;
        procedure cxGridJurnalTableKeyDown(Sender: TObject; var Key: Word; Shift:
            TShiftState);
    private
        FCurrentDT: Integer;
        FDocID: Integer;
        procedure SetCurrentDT(const Value: Integer);
        procedure SetDocID(const Value: Integer);
    { Private declarations }
    protected
        procedure Prepare; override;
        procedure BindingDataSource; override;
    public
        function ShowPreviewDocument(DocID: Integer): tModalResult;
        property CurrentDT: Integer read FCurrentDT write SetCurrentDT;
        property DocID: Integer read FDocID write SetDocID;
    { Public declarations }
    end;

var
    frmDocumentPreviewDlg: TfrmDocumentPreviewDlg;


implementation

uses
  SWNUtils, DataModuleDB;

{$R *.dfm}

{ TfrmDocumentPreviewDlg }

procedure TfrmDocumentPreviewDlg.BindingDataSource;
begin
    inherited;

end;

procedure TfrmDocumentPreviewDlg.cxGridJurnalTableKeyDown(Sender: TObject; var
    Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeys(self, cxGridJurnalTable, Key, Shift);
end;

procedure TfrmDocumentPreviewDlg.Prepare;
begin
    inherited;
    dmDB.IBCQueryStocks.Open;
    dmDB.IBCQueryCurrency.Open;
    IBCQueryDocs.Close;
    IBCQueryDocs.ParamByName('DOCID').AsInteger := DocID;
    IBCQueryDocs.parambyname('DT').Asinteger := CurrentDT;
    IBCQueryDocs.Open;
    IBCQueryJurnal.Open;
    IBCQueryDT_Accounts.Open;
    IBCQueryCT_Accounts.Open;
    IBCQueryRechizite.Open;

    dmDB.IBCQueryAnalytics.ParamByName('DOCTYPE').AsInteger := IBCQueryDocs.FieldByName('DOCTYPEID').AsINteger;
    dmDB.IBCQueryAnalytics.Open;
    dmDB.IBCQueryAnalitica.Open;

    beDT_NAME.Text := IBCQueryDocs.FieldByName('DT_NAME').AsString;
    beDT_NAME.Tag := IBCQueryDocs.FieldByName('DT').AsInteger;
    beCT_NAME.Text := IBCQueryDocs.FieldByName('CT_NAME').AsString;
    beCT_NAME.Tag := IBCQueryDocs.FieldByName('CT').AsInteger;
end;

procedure TfrmDocumentPreviewDlg.SetCurrentDT(const Value: Integer);
begin
    FCurrentDT := Value;
end;

procedure TfrmDocumentPreviewDlg.SetDocID(const Value: Integer);
begin
    FDocID := Value;
end;

function TfrmDocumentPreviewDlg.ShowPreviewDocument(DocID: Integer): tModalResult;
begin
    FDocID := DocID;
    Prepare;
    result := ShowModal;
end;

end.

