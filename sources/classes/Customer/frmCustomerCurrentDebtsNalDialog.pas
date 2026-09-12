unit frmCustomerCurrentDebtsNalDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxCurrencyEdit, StdCtrls, ExtCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, DialogTitle, MemDS, DBAccess, IBC,
  cxLabel, cxNavigator, dxBar, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations;

type
  TfrmCustomerCurrentDebtsNalDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxGridHistoryCash: TcxGrid;
    cxGridHistoryCashTable: TcxGridDBTableView;
    cxGridHistoryCash_DOCID: TcxGridDBColumn;
    cxGridHistoryCash_DATA: TcxGridDBColumn;
    cxGridHistoryCash_DOCTYPE_NAME: TcxGridDBColumn;
    cxGridHistoryCash_SUMA: TcxGridDBColumn;
    cxGridHistoryCash_CURRENCY_NAME: TcxGridDBColumn;
    cxGridHistoryCash_RATE: TcxGridDBColumn;
    cxGridHistoryCash_SUMA_USD: TcxGridDBColumn;
    cxGridHistoryCash_CURRENT_USD_RATE: TcxGridDBColumn;
    cxGridHistoryCash_SUMA_BALANCE: TcxGridDBColumn;
    cxGridHistoryCashLevel: TcxGridLevel;
    pnBottom: TPanel;
    btnClose: TButton;
    IBCDataSourceHistoryCash: TIBCDataSource;
    IBCQueryHistoryCash: TIBCQuery;
    cxGridHistoryCash_DT_NAME: TcxGridDBColumn;
    cxGridHistoryCash_CREATED_BY: TcxGridDBColumn;
    cxGridHistoryCash_DOCTYPESIGN: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    dxBarPopupMenu1: TdxBarPopupMenu;
    dxBarButton1: TdxBarButton;
    procedure cxGridHistoryCash_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
      TcxCustomGridRecord; var AText: string);
    procedure cxGridHistoryCashTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridHistoryCashTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridHistoryCashTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fCustomerID: integer;
    procedure SetCustomerID(const Value: integer);
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    { Public declarations }
    property CustomerID: integer read fCustomerID write SetCustomerID;
  end;

implementation

uses
  SWNBaseFrameUnit, DataModuleAdditions, DataModuleDB, SWNValueStorageUnit, SWNUtils;

{$R *.dfm}

{ TfrmCustomerCurrentDebtsNalDlg }

procedure TfrmCustomerCurrentDebtsNalDlg.cxGridHistoryCashTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
//     // highlight selected row
//  if not AViewInfo.Selected then
//  begin
//    if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridHistoryCash_DOCTYPESIGN.Index]) then
//    begin
////      if AViewInfo.GridRecord.Values[cxGridHistoryCash_DOCTYPESIGN.Index] < 0 then
////      begin
////        Brush.Color := dmAdditions.cxStyle_TextColorRed.Color;
////        Font.Color := dmAdditions.cxStyle_TextColorRed.Font.Color;
////      end
////      else
////      begin
////        Brush.Color := dmAdditions.cxStyle_TextColorGreen.Color;
////        Font.Color := dmAdditions.cxStyle_TextColorGreen.Font.Color;
////      end
//    end;
//
////    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
////    begin
////      ACanvas.Brush.Color := clBlue;
////    end;
//  end;
end;

procedure TfrmCustomerCurrentDebtsNalDlg.cxGridHistoryCashTableKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  if (Key = 67) and (Shift = [ssAlt, ssCtrl]) then
  begin
    ShowCopyGridContent(Self, cxGridHistoryCashTable);
  end;
         // Ctrl+C
  if (Key = 67) and (Shift = [ssCtrl]) then
  begin
          // copy cell content in clipboard
    CopyGridCellTextToClipboard(cxGridHistoryCashTable);
    Key := 0;
  end
end;

procedure TfrmCustomerCurrentDebtsNalDlg.cxGridHistoryCashTableStylesGetContentStyle(Sender:
  TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
//
//  if VarIsNumeric(ARecord.Values[cxGridHistoryCash_DOCTYPESIGN.Index]) then
//  begin
//    if ARecord.Values[cxGridHistoryCash_DOCTYPESIGN.Index] < 0 then
//      AStyle := dmAdditions.cxStyle_TextColorRed
//    else
//      AStyle := dmAdditions.cxStyle_TextColorGreen;
//  end;
//
end;

procedure TfrmCustomerCurrentDebtsNalDlg.cxGridHistoryCash_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridHistoryCash_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridHistoryCash_DATA.Index]);
end;

procedure TfrmCustomerCurrentDebtsNalDlg.dxBarButton1Click(Sender: TObject);
var
  CurrencyRate: string;
  SavePlace: TBookmark;
begin
  //
  SavePlace := IBCQueryHistoryCash.GetBookmark;
  try
    CurrencyRate := Dialogs.InputBox('Modifica cursul documentului', 'Curs USD', IBCQueryHistoryCash.FieldByName('CURRENT_USD_RATE').AsString);
    dmdb.ExecuteQuery('execute procedure sp_update_doc_rate (:docid, :rateusd)', [IBCQueryHistoryCash.FieldByName
      ('DOCID').AsInteger, StrToFloat(CurrencyRate)]);
    IBCQueryHistoryCash.Refresh;

    IBCQueryHistoryCash.GotoBookmark(SavePlace);
  finally
    IBCQueryHistoryCash.FreeBookmark(SavePlace);
  end;
end;

procedure TfrmCustomerCurrentDebtsNalDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.ReadFormPos(Self);
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridHistoryCashTable);
end;

procedure TfrmCustomerCurrentDebtsNalDlg.Prepare;
begin
  IBCQueryHistoryCash.ParamByName('CustomerID').AsInteger := fCustomerID;
  IBCQueryHistoryCash.Active := True;
  dtDialogTitle.Text := Format('#%d - %s', [fCustomerID, dmDB.GetCustomerDisplayName(fCustomerID)]);
  cxGridHistoryCash_DOCTYPE_NAME.Focused := True;
end;

procedure TfrmCustomerCurrentDebtsNalDlg.SaveStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridHistoryCashTable);
end;

procedure TfrmCustomerCurrentDebtsNalDlg.SetCustomerID(const Value: integer);
begin
  fCustomerID := Value;
end;

end.

