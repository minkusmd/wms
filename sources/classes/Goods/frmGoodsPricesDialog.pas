unit frmGoodsPricesDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, ExtCtrls, StdCtrls,

  cxButtonEdit, Menus, Buttons, cxDBLookupComboBox, Data.DB,
  DBAccess, IBC, cxButtons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxControls, cxContainer, cxEdit, MemDS,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxTextEdit, cxMaskEdit;

type
  TfrmGoodsPricesDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    Notebook: TNotebook;
    pnPrices: TPanel;
    Label1: TLabel;
    lbPrice0: TLabel;
    lbPrice1: TLabel;
    lbPrice2: TLabel;
    lbPrice3: TLabel;
    lbPrice4: TLabel;
    lbPrice5: TLabel;
    lbPrice6: TLabel;
    lbPrice7: TLabel;
    lbMargin1: TLabel;
    lbMargin2: TLabel;
    lbMargin3: TLabel;
    lbMargin4: TLabel;
    lbMargin5: TLabel;
    lbMargin6: TLabel;
    lbMargin7: TLabel;
    mmGoods: TMemo;
    edPrice0: TEdit;
    edPrice1: TEdit;
    edPrice2: TEdit;
    edPrice3: TEdit;
    edPrice4: TEdit;
    edPrice5: TEdit;
    edPrice6: TEdit;
    edPrice7: TEdit;
    edMargin1: TEdit;
    edMargin2: TEdit;
    edMargin3: TEdit;
    edMargin4: TEdit;
    edMargin5: TEdit;
    edMargin6: TEdit;
    edMargin7: TEdit;
    pnSave: TPanel;
    rbNewDocument: TRadioButton;
    rbSelectDocument: TRadioButton;
    beDocument: TcxButtonEdit;
    lbFinish: TLabel;
    Label20: TLabel;
    mmComments: TMemo;
    lbCurrencyTitle: TLabel;
    Label21: TLabel;
    edPrice1_LEI: TEdit;
    edPrice2_LEI: TEdit;
    edPrice3_LEI: TEdit;
    edPrice4_LEI: TEdit;
    edPrice5_LEI: TEdit;
    edPrice6_LEI: TEdit;
    edPrice7_LEI: TEdit;
    Label2: TLabel;
    edPrice0_LEI: TEdit;
    pmPrices: TPopupMenu;
    miPriceCalcPreset1: TMenuItem;
    sbPopupMenu: TSpeedButton;
    IBCQuerySuppliers: TIBCQuery;
    IBCDataSourceSuppliers: TIBCDataSource;
    lcbSupplier: TcxLookupComboBox;
    Label3: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    btnNext: TcxButton;
    btnPrevious: TcxButton;
    procedure btnNextClick(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure edPrice0Exit(Sender: TObject);
    procedure edPrice1Exit(Sender: TObject);
    procedure edPrice2Exit(Sender: TObject);
    procedure edPrice3Exit(Sender: TObject);
    procedure edPrice4Exit(Sender: TObject);
    procedure edPrice5Exit(Sender: TObject);
    procedure edPrice6Exit(Sender: TObject);
    procedure edPrice7Exit(Sender: TObject);
    procedure edMargin1Exit(Sender: TObject);
    procedure edMargin2Exit(Sender: TObject);
    procedure edMargin3Exit(Sender: TObject);
    procedure edMargin4Exit(Sender: TObject);
    procedure edMargin5Exit(Sender: TObject);
    procedure edMargin6Exit(Sender: TObject);
    procedure edMargin7Exit(Sender: TObject);
    procedure beDocumentPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure rbSelectDocumentClick(Sender: TObject);
    procedure sbPopupMenuClick(Sender: TObject);
    procedure miPriceCalcPreset1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fGoodsID: integer;
    fPrice0: Double;
    fPrice1: Double;
    fPrice2: Double;
    fPrice3: Double;
    fPrice4: Double;
    fPrice5: Double;
    fPrice6: Double;
    fPrice7: Double;
    fMargin1: Double;
    fMargin2: Double;
    fMargin3: Double;
    fMargin4: Double;
    fMargin5: Double;
    fMargin6: Double;
    fMargin7: Double;
    fCurrencyID: integer;
    fCurrencyTitle: string;
    fTargetDocID: integer;
    fPrice0Changed: Boolean;
    fExchangeRate: Double;
    procedure ReadGoodsPriceInfo(const GoodsID: integer);
    procedure DisplayValues;
    procedure ShowSelectTargetDocumentDlg;
    procedure CheckFinalStep;
    function CreateNewDocRecord: Boolean;
    function AddToExistingRecord: Boolean;
    procedure DisplayLeiValues;
    procedure RecalcMargins;
    procedure SetupPreset1;
  protected
    function CheckFirstPage: boolean;
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetGoodsInfo(const GoodsID: Integer; const GoodsTitle: string);
  end;

implementation

uses
  DataModuleDB, Math, frmDocumentBrowserDialog,
  SWNDBErrors, SWNUtils, SWNConst, SWNSecurityFlags;

{$R *.dfm}

{ TfrmGoodsPricesDlg }

function TfrmGoodsPricesDlg.AddToExistingRecord: Boolean;
var
  Query: TIBCQuery;
  Transaction: TIBCTransaction;
begin
  Result := False;
  Transaction := TIBCTransaction.Create(Self);
  try
    Transaction.DefaultConnection := dmDB.IBCConnection;

    Query := TIBCQuery.Create(Self);
    try
      Query.Connection := dmDB.IBCConnection;
      Query.AutoCommit := false;
      Query.Transaction := Transaction;
      Transaction.StartTransaction;
      try
              // create price record
        Query.SQL.Text := 'INSERT INTO TDB_GOODS_PRICE (DOCID,GOODSID,CURRENCYID,PRICE0,PRICE1,PRICE2,PRICE3,PRICE4,PRICE5,PRICE6,PRICE7,MODIFIED_BY)' +
        ' VALUES (:doc,:goods,:curr,:p0,:p1,:p2,:p3,:p4,:p5,:p6,:p7,:user)';
        Query.ParamByName('doc').AsInteger := fTargetDocID;
        Query.ParamByName('goods').AsInteger := fGoodsID;
        Query.ParamByName('curr').AsInteger := fCurrencyID;
        Query.ParamByName('p0').AsFloat := fPrice0;
        Query.ParamByName('p1').AsFloat := fPrice1;
        Query.ParamByName('p2').AsFloat := fPrice2;
        Query.ParamByName('p3').AsFloat := fPrice3;
        Query.ParamByName('p4').AsFloat := fPrice4;
        Query.ParamByName('p5').AsFloat := fPrice5;
        Query.ParamByName('p6').AsFloat := fPrice6;
        Query.ParamByName('p7').AsFloat := fPrice7;
        Query.ParamByName('user').AsInteger := dmDB.CurrentUserID;
        Query.ExecSQL;

        Transaction.Commit;
        Result := true;
      except
        on E: Exception do
        begin
          Transaction.Rollback;
          if not ProcessSWNError(E) then
            raise;
        end;
      end;
    finally
      Query.Free;
    end;
  finally
    Transaction.Free;
  end;
end;

procedure TfrmGoodsPricesDlg.beDocumentPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectTargetDocumentDlg;
end;

procedure TfrmGoodsPricesDlg.btnNextClick(Sender: TObject);
begin
  if CheckFirstPage then
        Notebook.PageIndex := 1;
end;

procedure TfrmGoodsPricesDlg.btnPreviousClick(Sender: TObject);
begin
  Notebook.PageIndex := 0;
end;

procedure TfrmGoodsPricesDlg.CheckFinalStep;
begin
  if (rbNewDocument.Checked and (fTargetDocID = -1)) or (rbSelectDocument.Checked and (fTargetDocID > 0)) then
  begin
    btnOk.Enabled := True;
    lbFinish.Visible := True;
    btnOk.SetFocus;
  end
  else
  begin
    btnOk.Enabled := False;
    lbFinish.Visible := False;
  end;
end;

function TfrmGoodsPricesDlg.CheckFirstPage: boolean;
begin
   Result := True;
   if lcbSupplier.Tag < 0 then
        Result := false;
end;

function TfrmGoodsPricesDlg.CreateNewDocRecord: Boolean;
var
  Query: TIBCQuery;
  Transaction: TIBCTransaction;
  docID: integer;
begin
  Result := False;
  Transaction := TIBCTransaction.Create(Self);
  try
    Transaction.DefaultConnection := dmDB.IBCConnection;

    Query := TIBCQuery.Create(Self);
    try
      Query.Connection := dmDB.IBCConnection;
      Query.AutoCommit := false;
      Query.Transaction := Transaction;
      Transaction.StartTransaction;
      try
              // create document
        Query.SQL.Text := 'SELECT DOCID FROM SP_CREATE_NEW_DOC_1414(:DT, :CT)';
        Query.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
        Query.ParamByName('CT').AsInteger := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
        Query.ExecSQL;
        if not Query.Eof then
        begin
          docID := Query.Fields[0].AsInteger;
          Query.Close;

                   // create price record
          Query.SQL.Text := 'INSERT INTO TDB_GOODS_PRICE(DOCID,GOODSID,CURRENCYID,PRICE0,PRICE1,PRICE2,PRICE3,PRICE4,PRICE5,PRICE6,PRICE7,MODIFIED_BY) ' +
          ' VALUES (:doc,:goods,:curr,:p0,:p1,:p2,:p3,:p4,:p5,:p6,:p7,:user)';
          Query.ParamByName('doc').AsInteger := docID;
          Query.ParamByName('goods').AsInteger := fGoodsID;
          Query.ParamByName('curr').AsInteger := fCurrencyID;
          Query.ParamByName('p0').AsFloat := fPrice0;
          Query.ParamByName('p1').AsFloat := fPrice1;
          Query.ParamByName('p2').AsFloat := fPrice2;
          Query.ParamByName('p3').AsFloat := fPrice3;
          Query.ParamByName('p4').AsFloat := fPrice4;
          Query.ParamByName('p5').AsFloat := fPrice5;
          Query.ParamByName('p6').AsFloat := fPrice6;
          Query.ParamByName('p7').AsFloat := fPrice7;
          Query.ParamByName('user').AsInteger := dmDB.CurrentUserID;
//          Query.ParamByName('comm').AsString := mmComments.Text;
          Query.ExecSQL;

          Result := true;
        end;

        Transaction.Commit;
      except
        on E: Exception do
        begin
          Result := False;
          Transaction.Rollback;
          if not ProcessSWNError(E) then
            raise;
        end;
      end;
    finally
      Query.Free;
    end;
  finally
    Transaction.Free;
  end;
end;

procedure TfrmGoodsPricesDlg.DisplayLeiValues;
begin
  edPrice0_LEI.Text := FormatFloat('#,##0.00', RoundTo(fExchangeRate * fPrice0, -2));
  edPrice1_LEI.Text := FormatFloat('#,##0.00', RoundTo(fExchangeRate * fPrice1, -2));
  edPrice2_LEI.Text := FormatFloat('#,##0.00', RoundTo(fExchangeRate * fPrice2, -2));
  edPrice3_LEI.Text := FormatFloat('#,##0.00', RoundTo(fExchangeRate * fPrice3, -2));
  edPrice4_LEI.Text := FormatFloat('#,##0.00', RoundTo(fExchangeRate * fPrice4, -2));
  edPrice5_LEI.Text := FormatFloat('#,##0.00', RoundTo(fExchangeRate * fPrice5, -2));
  edPrice6_LEI.Text := FormatFloat('#,##0.00', RoundTo(fExchangeRate * fPrice6, -2));
  edPrice7_LEI.Text := FormatFloat('#,##0.00', RoundTo(fExchangeRate * fPrice7, -2));
end;

procedure TfrmGoodsPricesDlg.DisplayValues;
begin
  edPrice0.Text := FloatToStr(fPrice0);
  lbCurrencyTitle.Caption := fCurrencyTitle;
  edPrice1.Text := FloatToStr(fPrice1);
  edPrice2.Text := FloatToStr(fPrice2);
  edPrice3.Text := FloatToStr(fPrice3);
  edPrice4.Text := FloatToStr(fPrice4);
  edPrice5.Text := FloatToStr(fPrice5);
  edPrice6.Text := FloatToStr(fPrice6);
  edPrice7.Text := FloatToStr(fPrice7);
  edMargin1.Text := FloatToStr(fMargin1);
  edMargin2.Text := FloatToStr(fMargin2);
  edMargin3.Text := FloatToStr(fMargin3);
  edMargin4.Text := FloatToStr(fMargin4);
  edMargin5.Text := FloatToStr(fMargin5);
  edMargin6.Text := FloatToStr(fMargin6);
  edMargin7.Text := FloatToStr(fMargin7);

  DisplayLeiValues;
end;

procedure TfrmGoodsPricesDlg.edMargin1Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edMargin1.Text, -1);
  if (N < 0) then
    N := 0;
  if (N <> fMargin1) then
  begin
    fMargin1 := N;
    edMargin1.Text := FloatToStr(fMargin1);
          // recalc price 1
    fPrice1 := fPrice0 + (fMargin1 * fPrice0 / 100);
    edPrice1.Text := FloatToStr(RoundTo(fPrice1, -2));
  end;
end;

procedure TfrmGoodsPricesDlg.edMargin2Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edMargin2.Text, -1);
  if (N < 0) then
    N := 0;
  if (N <> fMargin2) then
  begin
    fMargin2 := N;
    edMargin2.Text := FloatToStr(fMargin2);
          // recalc price 1
    fPrice2 := fPrice0 + (fMargin2 * fPrice0 / 100);
    edPrice2.Text := FloatToStr(RoundTo(fPrice2, -2));
  end;
end;

procedure TfrmGoodsPricesDlg.edMargin3Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edMargin3.Text, -1);
  if (N < 0) then
    N := 0;
  if (N <> fMargin3) then
  begin
    fMargin3 := N;
    edMargin3.Text := FloatToStr(fMargin3);
          // recalc price 3
    fPrice3 := fPrice0 + (fMargin3 * fPrice0 / 100);
    edPrice3.Text := FloatToStr(RoundTo(fPrice3, -2));
  end;
end;

procedure TfrmGoodsPricesDlg.edMargin4Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edMargin4.Text, -1);
  if (N < 0) then
    N := 0;
  if (N <> fMargin4) then
  begin
    fMargin4 := N;
    edMargin4.Text := FloatToStr(fMargin4);
          // recalc price 4
    fPrice4 := fPrice0 + (fMargin4 * fPrice0 / 100);
    edPrice4.Text := FloatToStr(RoundTo(fPrice4, -2));
  end;
end;

procedure TfrmGoodsPricesDlg.edMargin5Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edMargin5.Text, -1);
  if (N < 0) then
    N := 0;
  if (N <> fMargin5) then
  begin
    fMargin5 := N;
    edMargin5.Text := FloatToStr(fMargin5);
          // recalc price 5
    fPrice5 := fPrice0 + (fMargin5 * fPrice0 / 100);
    edPrice5.Text := FloatToStr(RoundTo(fPrice5, -2));
  end;
end;

procedure TfrmGoodsPricesDlg.edMargin6Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edMargin6.Text, -1);
  if (N < 0) then
    N := 0;
  if (N <> fMargin6) then
  begin
    fMargin6 := N;
    edMargin6.Text := FloatToStr(fMargin6);
          // recalc price 6
    fPrice6 := fPrice0 + (fMargin6 * fPrice0 / 100);
    edPrice6.Text := FloatToStr(RoundTo(fPrice6, -2));
  end;
end;

procedure TfrmGoodsPricesDlg.edMargin7Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edMargin7.Text, -1);
  if (N < 0) then
    N := 0;
  if (N <> fMargin7) then
  begin
    fMargin7 := N;
    edMargin7.Text := FloatToStr(fMargin7);
          // recalc price 7
    fPrice7 := fPrice0 + (fMargin7 * fPrice0 / 100);
    edPrice7.Text := FloatToStr(RoundTo(fPrice7, -2));
  end;
end;

procedure TfrmGoodsPricesDlg.edPrice0Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edPrice0.Text, -1);
  if (N < 0) then
    N := 0;
  fPrice0 := N;
  edPrice0.Text := FloatToStr(N);
  fPrice0Changed := True;

  RecalcMargins;
     //DisplayLeiValues;
end;

procedure TfrmGoodsPricesDlg.edPrice1Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edPrice1.Text, -1);
  if (N < 0) then
    N := 0;
  fPrice1 := N;
  edPrice1.Text := FloatToStr(N);
     // margin
  N := 0;
  if (fPrice0 <> 0) and (fPrice1 <> 0) then
    N := fPrice1 / fPrice0 * 100 - 100;
  edMargin1.Text := FloatToStr(RoundTo(N, -4));

  DisplayLeiValues;
end;

procedure TfrmGoodsPricesDlg.edPrice2Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edPrice2.Text, -1);
  if (N < 0) then
    N := 0;
  fPrice2 := N;
  edPrice2.Text := FloatToStr(N);
     // margin
  N := 0;
  if (fPrice0 <> 0) and (fPrice2 <> 0) then
    N := fPrice2 / fPrice0 * 100 - 100;
  edMargin2.Text := FloatToStr(RoundTo(N, -4));

  DisplayLeiValues;
end;

procedure TfrmGoodsPricesDlg.edPrice3Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edPrice3.Text, -1);
  if (N < 0) then
    N := 0;
  fPrice3 := N;
  edPrice3.Text := FloatToStr(N);
     // margin
  N := 0;
  if (fPrice0 <> 0) and (fPrice3 <> 0) then
    N := fPrice3 / fPrice0 * 100 - 100;
  edMargin3.Text := FloatToStr(RoundTo(N, -4));

  DisplayLeiValues;
end;

procedure TfrmGoodsPricesDlg.edPrice4Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edPrice4.Text, -1);
  if (N < 0) then
    N := 0;
  fPrice4 := N;
  edPrice4.Text := FloatToStr(N);
     // margin
  N := 0;
  if (fPrice0 <> 0) and (fPrice4 <> 0) then
    N := fPrice4 / fPrice0 * 100 - 100;
  edMargin4.Text := FloatToStr(RoundTo(N, -4));

  DisplayLeiValues;
end;

procedure TfrmGoodsPricesDlg.edPrice5Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edPrice5.Text, -1);
  if (N < 0) then
    N := 0;
  fPrice5 := N;
  edPrice5.Text := FloatToStr(N);
     // margin
  N := 0;
  if (fPrice0 <> 0) and (fPrice5 <> 0) then
    N := fPrice5 / fPrice0 * 100 - 100;
  edMargin5.Text := FloatToStr(RoundTo(N, -4));

  DisplayLeiValues;
end;

procedure TfrmGoodsPricesDlg.edPrice6Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edPrice6.Text, -1);
  if (N < 0) then
    N := 0;
  fPrice6 := N;
  edPrice6.Text := FloatToStr(N);
     // margin
  N := 0;
  if (fPrice0 <> 0) and (fPrice6 <> 0) then
    N := fPrice6 / fPrice0 * 100 - 100;
  edMargin6.Text := FloatToStr(RoundTo(N, -4));

  DisplayLeiValues;
end;

procedure TfrmGoodsPricesDlg.edPrice7Exit(Sender: TObject);
var
  N: double;
begin
  N := StrToFloatDef(edPrice7.Text, -1);
  if (N < 0) then
    N := 0;
  fPrice7 := N;
  edPrice7.Text := FloatToStr(N);
     // margin
  N := 0;
  if (fPrice0 <> 0) and (fPrice7 <> 0) then
    N := fPrice7 / fPrice0 * 100 - 100;
  edMargin7.Text := FloatToStr(RoundTo(N, -4));

  DisplayLeiValues;
end;

procedure TfrmGoodsPricesDlg.FormCreate(Sender: TObject);
begin
  fGoodsID := -1;
  fTargetDocID := -1;
  fPrice0 := 0;
  fPrice1 := 0;
  fPrice2 := 0;
  fPrice3 := 0;
  fPrice4 := 0;
  fPrice5 := 0;
  fPrice6 := 0;
  fPrice7 := 0;
  fMargin1 := 0;
  fMargin2 := 0;
  fMargin3 := 0;
  fMargin4 := 0;
  fMargin5 := 0;
  fMargin6 := 0;
  fMargin7 := 0;
  fPrice0Changed := false;
  fExchangeRate := 1;

  Notebook.PageIndex := 0;
  lbFinish.Visible := False;
  btnOk.Enabled := False;
  beDocument.Enabled := False;
end;

function TfrmGoodsPricesDlg.IsFormDataPosted: Boolean;
begin
  if fTargetDocID = -1 then
    Result := CreateNewDocRecord
  else
    Result := AddToExistingRecord();
  if not Result then
    ShowErrorDialog(cMSG_GeneralError_Title, 'Не получилось! Видно не судьба.');
end;

procedure TfrmGoodsPricesDlg.miPriceCalcPreset1Click(Sender: TObject);
begin
  SetupPreset1;
end;

procedure TfrmGoodsPricesDlg.Prepare;
begin
  inherited;

  SetupSecurityItems;

  ReadGoodsPriceInfo(fGoodsID);
  DisplayValues;
  if fGoodsID = -1 then
    Notebook.Enabled := false;
  IBCQuerySuppliers.ParamByName('GOODSID').AsInteger := fGoodsID;
  IBCQuerySuppliers.Open;

  lcbSupplier.Tag := IBCquerySuppliers.FieldByName('CUSTOMERID').AsInteger;
  lcbSupplier.Text := IBCquerySuppliers.FieldByName('NAME').AsString;
end;

procedure TfrmGoodsPricesDlg.rbSelectDocumentClick(Sender: TObject);
begin
  if rbNewDocument.Checked then
  begin
    beDocument.Enabled := false;
    beDocument.Text := '';
    fTargetDocID := -1;
  end
  else if rbSelectDocument.Checked then
  begin
    beDocument.Enabled := true;
  end;

  CheckFinalStep;
end;

procedure TfrmGoodsPricesDlg.ReadGoodsPriceInfo(const GoodsID: integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT');
    Query.SQL.Add(' TS_GOODS_PRICE.*,');
    Query.SQL.Add(' TS_CURRENCY.TITLE,');
    Query.SQL.Add(' TS_CURRENCY.EXCHANGE_RATE');
    Query.SQL.Add('FROM TS_GOODS_PRICE');
    Query.SQL.Add(' INNER JOIN TS_CURRENCY ON (TS_CURRENCY.CURRENCYID=TS_GOODS_PRICE.CURRENCYID)');
    Query.SQL.Add('WHERE GOODSID=:id');
    Query.ParamByName('id').AsInteger := fGoodsID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      fPrice0 := Query.FieldByName('PRICE0').AsFloat;
      fPrice1 := Query.FieldByName('PRICE1').AsFloat;
      fPrice2 := Query.FieldByName('PRICE2').AsFloat;
      fPrice3 := Query.FieldByName('PRICE3').AsFloat;
      fPrice4 := Query.FieldByName('PRICE4').AsFloat;
      fPrice5 := Query.FieldByName('PRICE5').AsFloat;
      fPrice6 := Query.FieldByName('PRICE6').AsFloat;
      fPrice7 := Query.FieldByName('PRICE7').AsFloat;
      fMargin1 := Query.FieldByName('MARGIN1').AsFloat;
      fMargin2 := Query.FieldByName('MARGIN2').AsFloat;
      fMargin3 := Query.FieldByName('MARGIN3').AsFloat;
      fMargin4 := Query.FieldByName('MARGIN4').AsFloat;
      fMargin5 := Query.FieldByName('MARGIN5').AsFloat;
      fMargin6 := Query.FieldByName('MARGIN6').AsFloat;
      fMargin7 := Query.FieldByName('MARGIN7').AsFloat;
      fCurrencyID := Query.FieldByName('CURRENCYID').AsInteger;
      fCurrencyTitle := Query.FieldByName('TITLE').AsString;
      fExchangeRate := Query.FieldByName('EXCHANGE_RATE').AsFloat;
    end;
        // recalc if needed
    if (fPrice0 <> 0) then
    begin
      if (fPrice1 <> 0) and (fMargin1 = 0) then
        fMargin1 := RoundTo(fPrice1 / fPrice0 * 100 - 100, -4);
      if (fPrice2 <> 0) and (fMargin2 = 0) then
        fMargin2 := RoundTo(fPrice2 / fPrice0 * 100 - 100, -4);
      if (fPrice3 <> 0) and (fMargin3 = 0) then
        fMargin3 := RoundTo(fPrice3 / fPrice0 * 100 - 100, -4);
      if (fPrice4 <> 0) and (fMargin4 = 0) then
        fMargin4 := RoundTo(fPrice4 / fPrice0 * 100 - 100, -4);
      if (fPrice5 <> 0) and (fMargin5 = 0) then
        fMargin5 := RoundTo(fPrice5 / fPrice0 * 100 - 100, -4);
      if (fPrice6 <> 0) and (fMargin6 = 0) then
        fMargin6 := RoundTo(fPrice6 / fPrice0 * 100 - 100, -4);
      if (fPrice7 <> 0) and (fMargin7 = 0) then
        fMargin7 := RoundTo(fPrice7 / fPrice0 * 100 - 100, -4);
    end;

  finally
    Query.Free;
  end;
end;

procedure TfrmGoodsPricesDlg.RecalcMargins;
begin
  edPrice1Exit(edPrice1);
  edPrice2Exit(edPrice2);
  edPrice3Exit(edPrice3);
  edPrice4Exit(edPrice4);
  edPrice5Exit(edPrice5);
  edPrice6Exit(edPrice6);
  edPrice7Exit(edPrice7);
end;

procedure TfrmGoodsPricesDlg.sbPopupMenuClick(Sender: TObject);
var
  P: TPoint;
begin
  P.X := sbPopupMenu.Left;
  P.Y := sbPopupMenu.Top;
  P := pnPrices.ClientToScreen(P);
  pmPrices.Popup(P.X, P.Y);
end;

procedure TfrmGoodsPricesDlg.SetGoodsInfo(const GoodsID: Integer; const GoodsTitle: string);
begin
  fGoodsID := GoodsID;
  mmGoods.Text := Format('#%d %s', [fGoodsID, GoodsTitle]);
end;

procedure TfrmGoodsPricesDlg.SetupPreset1;
var
  N, N2: Double;
begin
  N := StrToFloatDef(edPrice1.Text, -1);
  if (N > 0) then
  begin
          // -3%
    N2 := RoundTo(N * 97 / 100, -2);
    edPrice2.Text := FloatToStr(N2);

          // -5%
    N2 := RoundTo(N * 95 / 100, -2);
    edPrice3.Text := FloatToStr(N2);

    RecalcMargins;
  end;
end;

procedure TfrmGoodsPricesDlg.SetupSecurityItems;
begin
     // Price columns
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_0) then
  begin
    edPrice0.Visible := False;
    lbPrice0.Visible := False;
    edPrice0_LEI.Visible := False;
    btnNext.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_1) then
  begin
    edPrice1.Visible := False;
    edMargin1.Visible := False;
    lbPrice1.Visible := False;
    lbMargin1.Visible := False;
    edPrice1_LEI.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_2) then
  begin
    edPrice2.Visible := False;
    edMargin2.Visible := False;
    lbPrice2.Visible := False;
    lbMargin2.Visible := False;
    edPrice2_LEI.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_3) then
  begin
    edPrice3.Visible := False;
    edMargin3.Visible := False;
    lbPrice3.Visible := False;
    lbMargin3.Visible := False;
    edPrice3_LEI.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_4) then
  begin
    edPrice4.Visible := False;
    edMargin4.Visible := False;
    lbPrice4.Visible := False;
    lbMargin4.Visible := False;
    edPrice4_LEI.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_5) then
  begin
    edPrice5.Visible := False;
    edMargin5.Visible := False;
    lbPrice5.Visible := False;
    lbMargin5.Visible := False;
    edPrice5_LEI.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_6) then
  begin
    edPrice6.Visible := False;
    edMargin6.Visible := False;
    lbPrice6.Visible := False;
    lbMargin6.Visible := False;
    edPrice6_LEI.Visible := False;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_7) then
  begin
    edPrice7.Visible := False;
    edMargin7.Visible := False;
    lbPrice7.Visible := False;
    lbMargin7.Visible := False;
    edPrice7_LEI.Visible := False;
  end;

end;

procedure TfrmGoodsPricesDlg.ShowSelectTargetDocumentDlg;
var
  dialog: TfrmDocumentBrowserDlg;
begin
  dialog := TfrmDocumentBrowserDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.DefaultDocTypeID := 1414;
    dialog.FixedDocTypeID := True;
    dialog.FixedFirmaID := True;
    dialog.FixedUserID := True;
    dialog.FixedDate := True;

    if dialog.ShowModal = mrOk then
    begin
      fTargetDocID := dialog.DocID;
      beDocument.Text := Format('#%d - %s', [fTargetDocID, dialog.DocDT]);
    end;
  finally
    dialog.Free;
  end;
  CheckFinalStep;
end;

end.

