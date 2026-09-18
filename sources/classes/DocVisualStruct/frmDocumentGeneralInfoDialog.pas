unit frmDocumentGeneralInfoDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  cxControls, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cxContainer, cxButtonEdit,
  cxCheckBox, cxDBEdit, cxCalendar, cxMemo, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxTextEdit, cxMaskEdit, cxCalc, MemDS, DBAccess, IBC;

type
  TfrmDocumentGeneralInfoDlg = class(TSWNBaseFormClass)
    Panel1: TPanel;
    Panel2: TPanel;
    pnlJurnal: TPanel;
    cxButton1: TcxButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxLabel5: TLabel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    cxLabel8: TLabel;
    cxLabel6: TLabel;
    Label1: TLabel;
    lbContractTitle: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ceRATE: TcxDBCalcEdit;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    deDATA: TcxDBDateEdit;
    cbFLG_ACNT: TcxDBCheckBox;
    lcbDTDEP: TcxDBLookupComboBox;
    beDT_NAME: TcxButtonEdit;
    beCT_NAME: TcxButtonEdit;
    ceRATEUSD: TcxDBCalcEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    beContract: TcxButtonEdit;
    lcbCURRENCY: TcxDBLookupComboBox;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    Label4: TLabel;
    IBCDataSourceDocs: TIBCDataSource;
    IBCDataSourceJurnal: TIBCDataSource;
    IBCQueryJurnal: TIBCQuery;
    IBCQueryDocs: TIBCQuery;
    cxGrid1DBTableView1DTDEP_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1UM_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1QTY: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE: TcxGridDBColumn;
    cxGrid1DBTableView1SUMA: TcxGridDBColumn;
    cxGrid1DBTableView1SUMAVAT: TcxGridDBColumn;
    cxGrid1DBTableView1STOCK_QTY: TcxGridDBColumn;
    cxGrid1DBTableView1FLG_ACTIVE: TcxGridDBColumn;
    cxGrid1DBTableView1FLG_ACNT: TcxGridDBColumn;
    cxGrid1DBTableView1FLG_READY: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_NAMEACNT: TcxGridDBColumn;
    cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1FLG_FORCED: TcxGridDBColumn;
  private
    FDocID: Integer;
    procedure SetDocID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    property DocID: Integer read FDocID write SetDocID;
    { Public declarations }
  end;

var
  frmDocumentGeneralInfoDlg: TfrmDocumentGeneralInfoDlg;

implementation

{$R *.dfm}

procedure TfrmDocumentGeneralInfoDlg.Prepare;
begin
  IBCQueryDocs.ParamByName('DOCID').AsInteger := FDocID;
  IBCQueryDocs.Open;
  IBCQueryJurnal.Open;
  beDT_NAME.Text := IBCQueryDocs.FieldByName('DT_NAME').AsString;

end;

procedure TfrmDocumentGeneralInfoDlg.SetDocID(const Value: Integer);
begin
    FDocID := Value;
end;

end.
