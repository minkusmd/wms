unit frmGoodsInfoCardDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, DBAccess,
  IBC, MemDS, cxCurrencyEdit, cxLabel, StdCtrls, ExtCtrls, cxCheckBox,
  cxNavigator, cxCalc, cxImageComboBox, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges,
  dxScrollbarAnnotations, Vcl.Menus, cxButtons;

type
  TfrmGoodsInfoCardDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    IBCQueryInfo: TIBCQuery;
    IBCDataSourceInfo: TIBCDataSource;
    cxGridDBTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridDBTableDOCID: TcxGridDBColumn;
    cxGridDBTable_DT: TcxGridDBColumn;
    cxGridDBTable_DTNAME: TcxGridDBColumn;
    cxGridDBTable_CT: TcxGridDBColumn;
    cxGridDBTable_CTNAME: TcxGridDBColumn;
    cxGridDBTable_DOCTYPEID: TcxGridDBColumn;
    cxGridDBTableDOCTYPE_NAME: TcxGridDBColumn;
    cxGridDBTable_CREATED_BY: TcxGridDBColumn;
    cxGridDBTable_GOODSID: TcxGridDBColumn;
    cxGridDBTable_QTY: TcxGridDBColumn;
    cxGridDBTable_SEMN: TcxGridDBColumn;
    cxGridDBTable_SUMA: TcxGridDBColumn;
    cxGridDBTable_BALANCE_QTY: TcxGridDBColumn;
    cxGridDBTable_Пользователь: TcxGridDBColumn;
    cxGridDBTable_DATA: TcxGridDBColumn;
    cxGridDBTable_CREATED_DATE: TcxGridDBColumn;
    cxGridDBTable_PRICE: TcxGridDBColumn;
    pnBottom: TPanel;
    cxGridDB_FLG_CLOSED: TcxGridDBColumn;
    cxGridDB_FLG_ACNT: TcxGridDBColumn;
    cxGridDBTable_DOC_SUMA: TcxGridDBColumn;
    cxGridDBTable_DOC_RATEUSD: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView1: TcxGridDBTableView;
    IBCQueryJurnal: TIBCQuery;
    IBCDataSourceJurnal: TIBCDataSource;
    cxGridDBTableView1_GOODSID: TcxGridDBColumn;
    cxGridDBTableView1_GOODS_NAME: TcxGridDBColumn;
    cxGridDBTableView1_QTY: TcxGridDBColumn;
    cxGridDBTableView1_PRICE: TcxGridDBColumn;
    cxGridDBTableView1_SUMA: TcxGridDBColumn;
    cxGridDBTableView1_IMG: TcxGridDBColumn;
    cxGridDBTable_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBTable_CTDEP_NAME: TcxGridDBColumn;
    cxGridDBTable_DTDEP: TcxGridDBColumn;
    cxGridDBTable_CTDEP: TcxGridDBColumn;
    cxGridDBTable_VALUTA: TcxGridDBColumn;
    cxGridDBTableView1_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBTableView1_PRICE_USD: TcxGridDBColumn;
    cxGridDBTableView1_SUMA_USD: TcxGridDBColumn;
    cxGridDBTable_QTY_IN: TcxGridDBColumn;
    cxGridDBTable_QTY_OUT: TcxGridDBColumn;
    btnClose: TcxButton;
    procedure cxGridDBTable_SEMNGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDBTable_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDBTable_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cxGridDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBTable_CTDEP_NAMEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDBTable_CTNAMEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridDBTableDOCTYPE_NAMEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure cxGridDBTable_SEMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    fGoodsID: integer;
    fDetailMode: Boolean;
    fAcntID: integer;
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetGoodsInfo(const GoodsID: integer; const Title: string);
    procedure SetAcntGoodsInfo(const AcntID: integer; const AcntTitle: string);
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNValueStorageUnit, SWNSecurity,
  SWNSecurityFlags, SWNUtils, SWNConst, frmCustomerCurrentDebtsContractDialog, SWNCommonDialogs;

{$R *.dfm}

const
  cGoodsSQL = { 'SELECT' +
                  ' A.*,' +
                  ' IIF(A.CT=-1,'''',A.CTNAME) CT_NAME2,' +
                  ' VW_TDB_DOCS.FLG_ACNT,' +
                  ' VW_TDB_DOCS.FLG_CLOSED,' +
                  ' VW_TDB_DOCS.SUMA DOC_SUMA,' +
                  ' VW_TDB_DOCS.RATEUSD DOC_RATEUSD' +
                  ' FROM' +
                  ' SP_GOODS_TURNOVER1(:ID) A' +
                  ' INNER JOIN VW_TDB_DOCS ON (VW_TDB_DOCS.DOCID=A.DOCID)';  }
                    'SELECT A.*, IIF(A.CT = -1, '''', A.CTNAME) CT_NAME2, A.FLG_ACNT, A.FLG_CLOSED, A.DOC_SUMA, A.DOC_RATEUSD ' +
                    'FROM SP_GOODS_TURNOVER_v2(:ID) A';

const
  cAcntGoodsSQL = {'SELECT ' +
                  ' A.*,' +
                  ' IIF(A.CT=-1,'''',A.CTNAME) CT_NAME2,' +
                  ' VW_TDB_DOCS.FLG_ACNT,' +
                  ' VW_TDB_DOCS.FLG_CLOSED,' +
                  ' VW_TDB_DOCS.SUMA DOC_SUMA,' +
                  ' VW_TDB_DOCS.RATEUSD DOC_RATEUSD' +
                  ' FROM' +
                  ' SP_GOODS_TURNOVER_ACNT(:ID) A' +
                  ' INNER JOIN VW_TDB_DOCS ON (VW_TDB_DOCS.DOCID=A.DOCID)';    }
                    'SELECT A.*, IIF(A.CT = -1, '''', A.CTNAME) CT_NAME2, A.FLG_ACNT, A.FLG_CLOSED, A.DOC_SUMA, A.DOC_RATEUSD ' + 'FROM SP_GOODS_TURNOVER_ACNT_V2(:ID) A';

{ TfrmGoodsInfoCardDlg }

procedure TfrmGoodsInfoCardDlg.cxGridDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
    ACanvas.Font.Color := clBlack;
  end;
end;

procedure TfrmGoodsInfoCardDlg.cxGridDBTableDOCTYPE_NAMEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
//  if not VarIsNull(ARecord.Values[cxGridDB_FLG_ACNT.Index]) then
//  begin
//    if ARecord.Values[cxGridDB_FLG_ACNT.Index] = 1 then
//      AStyle := dmAdditions.cxStyle_TextColorRed;
//  end;

end;

procedure TfrmGoodsInfoCardDlg.cxGridDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  CT: Integer;
begin
     // Ctrl+C
  if (Key = 67) and (Shift = [ssCtrl]) then
  begin
          // copy cell content in clipboard
        dmdb.CopyGridCellTextToClipboard(cxGridDBTable);
    Key := 0;
    Shift := [];
  end;

  if ((Key = Ord('d')) or (Key = Ord('D'))) and (Shift = [ssCtrl]) then
  begin
     CT := cxGridDBTable.DataController.Values[cxGridDBTable.DataController.FocusedRecordIndex, cxGridDBTable_CT.Index];
     TSWNCommonDialogs.CustomerDebts(CT);
  end;
end;

procedure TfrmGoodsInfoCardDlg.cxGridDBTable_SEMNGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if VarIsNumeric(ARecord.Values[cxGridDBTable_SEMN.Index]) then
  begin
    if ARecord.Values[cxGridDBTable_SEMN.Index] < 0 then
      AText := '-'
    else
      AText := '+';
  end;
end;

procedure TfrmGoodsInfoCardDlg.cxGridDBTable_SEMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarIsNumeric(ARecord.Values[cxGridDBTable_SEMN.Index]) then
  begin
    if ARecord.Values[cxGridDBTable_SEMN.Index] < 0 then
      AStyle := dmAdditions.cxStyle_TextColorRed
    else
      AStyle := dmAdditions.cxStyle_TextColorGreen;
  end;
end;

procedure TfrmGoodsInfoCardDlg.cxGridDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure TfrmGoodsInfoCardDlg.cxGridDBTableView1KeyDown(Sender: TObject; var
    Key: Word; Shift: TShiftState);
begin
     // Ctrl+C
  if (Key = 67) and (Shift = [ssCtrl]) then
  begin
          // copy cell content in clipboard
    dmdb.CopyGridCellTextToClipboard(cxGridDBTableView1);
    Key := 0;
    Shift := [];
  end
end;

procedure TfrmGoodsInfoCardDlg.cxGridDBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarIsNumeric(ARecord.Values[cxGridDBTableView1_GOODSID.Index]) then
  begin
    if (ARecord.Values[cxGridDBTableView1_GOODSID.Index] = fGoodsID) then
      AStyle := dmAdditions.cxStyle_Bold;
  end;

end;

procedure TfrmGoodsInfoCardDlg.cxGridDBTable_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDBTable_CREATED_DATE.Index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridDBTable_CREATED_DATE.Index]);
end;

procedure TfrmGoodsInfoCardDlg.cxGridDBTable_CTDEP_NAMEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if (ARecord.Values[cxGridDBTable_CTDEP.Index] = -1) then
    AText := '';
end;

procedure TfrmGoodsInfoCardDlg.cxGridDBTable_CTNAMEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
var
  DT, CT: Integer;
//  DTDEP: integer;
  CTDEP: Integer;
begin
  DT := ARecord.Values[cxGridDBTable_DT.Index];
  CT := ARecord.Values[cxGridDBTable_CT.Index];
//  DTDEP := ARecord.Values[cxGridDBTable_DTDEP.Index];
  CTDEP := ARecord.Values[cxGridDBTable_CTDEP.Index];

  if (CT = DT) and (CTDEP = -1) then
    AText := '';
end;

procedure TfrmGoodsInfoCardDlg.cxGridDBTable_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDBTable_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridDBTable_DATA.Index]);
end;

procedure TfrmGoodsInfoCardDlg.FormCreate(Sender: TObject);
begin
  fDetailMode := False;
  fGoodsID := -1;
  fAcntID := -1;
end;

procedure TfrmGoodsInfoCardDlg.LoadStates;
var
  qtyDigitsMode: Integer;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
        // form pos
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.ReadFormPos(Self);
        // grid structure
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridDBTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;

     // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
     // Количество
  TcxCalcEditProperties(cxGridDBTable_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  TcxCalcEditProperties(cxGridDBTableView1_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmGoodsInfoCardDlg.Prepare;
var
  paramValue: integer;
begin
  paramValue := -1;
  if fGoodsID <> -1 then
  begin
          // conform unui singlu produs
    IBCQueryInfo.SQL.Text := cGoodsSQL;
    paramValue := fGoodsID;
  end
  else if fAcntID <> -1 then
  begin
          // conform unui grup de produse dupa codul de contabilitate
    IBCQueryInfo.SQL.Text := cAcntGoodsSQL;
    paramValue := fAcntID;
  end;

  if not fDetailMode then
  begin
    dtDialogTitle.Title := Format('%s (%s)', [dtDialogTitle.Title, dmDB.CurrentFirmaName]);

    IBCQueryInfo.FilterSQL := '(A.DT = :DT) OR (A.CT = :DT)';
    IBCQueryInfo.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
  end;
  IBCQueryInfo.ParamByName('ID').AsInteger := paramValue;
  IBCQueryInfo.Active := True;
  IBCQueryJurnal.Active := True;
end;

procedure TfrmGoodsInfoCardDlg.SaveStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
        // form pos
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.SaveFormPos(Self);
        // grid structure
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridDBTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmGoodsInfoCardDlg.SetAcntGoodsInfo(const AcntID: integer; const AcntTitle: string);
begin
  fAcntID := AcntID;
  dtDialogTitle.Title := 'Miscarea produselor';
  dtDialogTitle.Text := Format('Grupa produselor: %s (%d)', [AcntTitle, AcntID]);
end;

procedure TfrmGoodsInfoCardDlg.SetGoodsInfo(const GoodsID: integer; const Title: string);
begin
  fGoodsID := GoodsID;
  dtDialogTitle.Text := Format('#%d - %s', [GoodsID, Title]);
end;

procedure TfrmGoodsInfoCardDlg.SetupSecurityItems;
begin
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Карточка_товара_Цены) then
  begin
    cxGridDBTable_PRICE.Visible := False;
    cxGridDBTable_SUMA.Visible := False;
  end;

  if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Карточка_товара_Все_фирмы) then
    fDetailMode := True;
end;

end.

