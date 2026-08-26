unit frmCustomerCardDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit,
  Dialogs, DialogTitle, Menus,
  DB, cxDBData,
  MemDS, DBAccess, IBC, dxBar,
  StdCtrls, cxButtons, cxGridLevel, cxGridCustomTableView,
  cxGridDBTableView, cxGrid,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxLabel, cxCheckBox,
  cxCalendar, cxClasses, cxGridTableView, cxGridCustomView;

type

  TfrmCustomerCardDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    cxGridCards: TcxGrid;
    cxGridCardsLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarManager1Bar2: TdxBar;
    bbAddCard: TdxBarButton;
    bbModifyCard: TdxBarButton;
    cxGridCardsDB: TcxGridDBTableView;
    cxGridCards_SN: TcxGridDBColumn;
    IBCDataSourceCards: TIBCDataSource;
    IBCQueryCards: TIBCQuery;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cxGridCards_FLG_ENABLED: TcxGridDBColumn;
    cxGridCards_PRICE_COLUMN: TcxGridDBColumn;
    bbRemoveCard: TdxBarButton;
    cxGridCards_REG_DATE: TcxGridDBColumn;
    cxGridCards_IMG: TcxGridDBColumn;
    cxGridCards_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridCards_VALID_UNTIL_DATE: TcxGridDBColumn;
    procedure bbModifyCardClick(Sender: TObject);
    procedure bbAddCardClick(Sender: TObject);
    procedure cxGridCards_PRICE_COLUMNGetDisplayText
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure bbRemoveCardClick(Sender: TObject);
    procedure cxGridCardsDBFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridCardsDBCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    procedure ModifySelectedCard;
    procedure CreateNewCardDialog;
    procedure DeleteCurrentSelectedCard;
    procedure SelectionChanged;

    procedure LockCustomerCreditCards;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
  end;

implementation

uses frmCustomerCardEditorDlg, SWNUtils;

{$R *.dfm}
{ TfrmCustomerCardDialog }

procedure TfrmCustomerCardDialog.bbModifyCardClick(Sender: TObject);
begin
  ModifySelectedCard;
end;

procedure TfrmCustomerCardDialog.bbAddCardClick(Sender: TObject);
begin
  CreateNewCardDialog;
end;

procedure TfrmCustomerCardDialog.CreateNewCardDialog;
var
  dialog: TfrmCustomerCardEditorDialog;
begin
  dialog := TfrmCustomerCardEditorDialog.Create(Self, IBCQueryCards,
    IBCDataSourceCards);
  try
    dialog.AddNewCard := True;
    dialog.CustomerID := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    if dialog.ShowModal = mrOK then
      IBCQueryCards.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerCardDialog.cxGridCardsDBCellDblClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifyCard.Enabled and (bbModifyCard.Visible = ivAlways) then
  begin
    bbModifyCardClick(bbModifyCard);
    AHandled := True;
  end;
end;

procedure TfrmCustomerCardDialog.cxGridCardsDBFocusedRecordChanged
  (Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord
  : TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmCustomerCardDialog.cxGridCards_PRICE_COLUMNGetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  N: integer;
begin
  if VarIsNull(ARecord.Values[cxGridCards_PRICE_COLUMN.Index]) then
    AText := ''
  else
  begin
    N := ARecord.Values[cxGridCards_PRICE_COLUMN.Index];
    case N of
      0:
        AText := Format('%d - Cost', [N]);
      1:
        AText := Format('%d - Retail', [N]);
      2:
        AText := Format('%d - Credit', [N]);
      3:
        AText := Format('%d - Reducere retail', [N]);
      4:
        AText := Format('%d - Online & Club', [N]);
      5:
        AText := Format('%d - Diler', [N]);
    end;
  end;
end;

procedure TfrmCustomerCardDialog.DeleteCurrentSelectedCard;
begin
  if ShowAskDialog('Sterge inregistrare', 'Sterge cardul cu numarul '
    + IBCQueryCards.FieldByName('SN').AsString + '?') = mrYes then
  begin
    IBCQueryCards.Delete;
  end;
end;

procedure TfrmCustomerCardDialog.bbRemoveCardClick(Sender: TObject);
begin
  DeleteCurrentSelectedCard;
end;

procedure TfrmCustomerCardDialog.BindingDataSource;
begin
  inherited;

  IBCQueryCards.Connection := fIBCConnection;
  IBCQueryCards.MasterSource := fMasterDataSource;
  IBCQueryCards.Transaction := fMasterDataSet.UpdateTransaction;
  IBCQueryCards.UpdateTransaction := fMasterDataSet.UpdateTransaction;
end;

function TfrmCustomerCardDialog.IsFormDataPosted: Boolean;
begin
  fMasterDataSet.UpdateTransaction.Commit;
  Result := True;
end;

procedure TfrmCustomerCardDialog.LockCustomerCreditCards;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := fMasterDataSet.Connection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text :=
      'SELECT NULL FROM TS_CUST_DISCOUNT WHERE CUSTOMERID = :CustomerID FOR UPDATE WITH LOCK';
    Query.ParamByName('CustomerID').AsInteger :=
      fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TfrmCustomerCardDialog.ModifySelectedCard;
var
  dialog: TfrmCustomerCardEditorDialog;
begin
  dialog := TfrmCustomerCardEditorDialog.Create(Self, IBCQueryCards,
    IBCDataSourceCards);
  try
    dialog.AddNewCard := False;
    if dialog.ShowModal = mrOK then
      IBCQueryCards.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerCardDialog.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    LockCustomerCreditCards;

    IBCQueryCards.Active := True;
    SelectionChanged;
  except
    on E: Exception do
    begin
      fMasterDataSet.UpdateTransaction.Rollback;
      raise;
    end;
  end;
end;

procedure TfrmCustomerCardDialog.SelectionChanged;
var
  f1, f2, f3: Boolean;
begin
  f1 := True; // Add card + Security
  f2 := False;
  f3 := False;
  if cxGridCardsDB.DataController.RecNo > 0 then
  begin
    f2 := True; // Edit + Security
    f3 := True; // Remove + Security
  end;
  bbAddCard.Enabled := f1;
  bbModifyCard.Enabled := f2;
  bbRemoveCard.Enabled := f3;
end;

procedure TfrmCustomerCardDialog.WhenCancelForm;
begin
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
