unit frmBanksBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, Menus,
  DB,
  cxDBData, dxBar, IBC, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, ExtCtrls, StdCtrls,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, DBAccess, MemDS, cxClasses, cxGridTableView;

type
  TfrmBanksBrowserDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    cxGridBanks: TcxGrid;
    cxGridBanksDB: TcxGridDBTableView;
    cxGridBanksLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarManager1Bar2: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbRemove: TdxBarButton;
    cxGridBanksDBBANKACCOUNT: TcxGridDBColumn;
    cxGridBanksDB_BANKNAME: TcxGridDBColumn;
    cxGridBanksDBSWIFT_BIC: TcxGridDBColumn;
    cxGridBanksDBADDRESS: TcxGridDBColumn;
    IBCQueryBanks: TIBCQuery;
    IBCDataSourceBanks: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    dxBarPopupMenu: TdxBarPopupMenu;
    bbSearch: TdxBarButton;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbRemoveClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxGridBanksDBCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridBanksDBFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbSearchClick(Sender: TObject);
  private
    { private declarations }
    fBankAccount: string;
    fBankName: string;
    fSelectMode: Boolean;
    fListOfBanksChanged: Boolean;
    fInSearch: Boolean;
    procedure SelectionChanged;
    procedure ShowCreateNewBankDialog;
    procedure ShowModifyCurrentBankDialog;
    procedure DeleteCurrentRecord;
    procedure ShowSearchDialog;
    procedure NavigateSearch(const WhereCondition: string);
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property SelectMode: Boolean read fSelectMode write fSelectMode;
    property BankAccount: string read fBankAccount write fBankAccount;
    property BankName: string read fBankName;
    property ListOfBanksChanged: Boolean read fListOfBanksChanged;
    function SelectBank(const DefaultBankAccount: string = ''): Boolean;
    procedure BrowseBanks(const DefaultBankAccount: string = '');
  end;

implementation

uses
  frmBankEditorDlg, SWNUtils,
  SWNSecurityFlags, SWNDBErrors, SWNSearchUnit;

{$R *.dfm}
{ TfrmBanksBrowser }

procedure TfrmBanksBrowserDlg.bbModifyClick(Sender: TObject);
begin
  ShowModifyCurrentBankDialog;
end;

procedure TfrmBanksBrowserDlg.bbNewClick(Sender: TObject);
begin
  ShowCreateNewBankDialog;
end;

procedure TfrmBanksBrowserDlg.bbRemoveClick(Sender: TObject);
begin
  DeleteCurrentRecord;
end;

procedure TfrmBanksBrowserDlg.bbSearchClick(Sender: TObject);
begin
  if fInSearch then
  begin
    IBCQueryBanks.Active := False;
    IBCQueryBanks.FilterSQL := '';
    IBCQueryBanks.Active := True;
    fInSearch := False;
    bbSearch.Caption := 'Cauta';
  end
  else
    ShowSearchDialog;
end;

procedure TfrmBanksBrowserDlg.btnOkClick(Sender: TObject);
begin
  if (IBCQueryBanks.RecordCount > 0) and (not IBCQueryBanks.FieldByName('BANKACCOUNT').IsNull) then
  begin
    fBankAccount := IBCQueryBanks.FieldByName('BANKACCOUNT').AsString;
    fBankName := IBCQueryBanks.FieldByName('BANKNAME').AsString;
    ModalResult := mrOk;
  end;
end;

constructor TfrmBanksBrowserDlg.Create(AOwner: TComponent);
begin
  inherited;
  fInSearch := False;
end;

procedure TfrmBanksBrowserDlg.cxGridBanksDBCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if fSelectMode then
    btnOkClick(btnOk)
  else if bbModify.Enabled and (bbModify.Visible = ivAlways) then
    bbModifyClick(bbModify);
end;

procedure TfrmBanksBrowserDlg.cxGridBanksDBFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmBanksBrowserDlg.ShowCreateNewBankDialog;
var
  editor: TfrmBankEditorDialog;
begin
  editor := TfrmBankEditorDialog.Create(Self, IBCQueryBanks, IBCDataSourceBanks);
  try
    editor.CreateNewBank := True;
    if editor.ShowModal = mrOk then
    begin
      fListOfBanksChanged := True;
    end;
  finally
    editor.Free;
  end;
end;

procedure TfrmBanksBrowserDlg.ShowModifyCurrentBankDialog;
var
  editor: TfrmBankEditorDialog;
begin
  editor := TfrmBankEditorDialog.Create(Self, IBCQueryBanks, IBCDataSourceBanks);
  try
    editor.CreateNewBank := False;
    if editor.ShowModal = mrOk then
    begin
      fListOfBanksChanged := True;
    end;
  finally
    editor.Free;
  end;
end;

procedure TfrmBanksBrowserDlg.ShowSearchDialog;
var
  Search: TSWNSearchDialog;
  SearchInWhere: string;
  SC: TSearchCriteria;
  toSearch: Boolean;
  S: string;
begin
  toSearch := False;
  SearchInWhere := '';

  Search := TSWNSearchDialog.Create(Self);
  try
    if Search.GetSearchCritera(stBank) then
    begin
      SC := Search.SearchCriterias[0];
      S := PrepareTextForLIKE(SC.SearchText);
      AddConditionToWHERE(SearchInWhere, Format('(UPPER(BANKACCOUNT) LIKE %S) OR (UPPER(BANKNAME) LIKE %S)', [S, S]));
      toSearch := True;
    end;
  finally
    Search.Free;
  end;

  if toSearch then
    NavigateSearch(SearchInWhere);
end;

procedure TfrmBanksBrowserDlg.DeleteCurrentRecord;
var
  S: string;
begin
  with IBCQueryBanks do
    S := Format('Elimina BIC "%s"' + #13#10 + 'banca "%s"?', [FieldByName('BANKACCOUNT').AsString, FieldByName('BANKNAME').AsString]);
  if ShowAskDialog('Elimina element cu BIC', S) = mrYes then
  begin
    IBCQueryBanks.UpdateTransaction.StartTransaction;
    try
      IBCQueryBanks.Delete;
      IBCQueryBanks.UpdateTransaction.Commit;
      fListOfBanksChanged := True;
    except
      on E: Exception do
      begin
        IBCQueryBanks.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmBanksBrowserDlg.FormCreate(Sender: TObject);
begin
  fSelectMode := True;
  fListOfBanksChanged := False;
  fBankName := '';
end;

procedure TfrmBanksBrowserDlg.NavigateSearch(const WhereCondition: string);
begin
  IBCQueryBanks.Active := False;
  IBCQueryBanks.FilterSQL := WhereCondition;
  IBCQueryBanks.Active := True;
  fInSearch := True;
  bbSearch.Caption := 'Arata toate';
end;

procedure TfrmBanksBrowserDlg.BrowseBanks(const DefaultBankAccount: string);
begin
  SelectMode := False;
  BankAccount := DefaultBankAccount;
  ShowModal;
end;

procedure TfrmBanksBrowserDlg.Prepare;
begin
  SetupSecurityItems;

  if not fSelectMode then
  begin
    btnOk.Visible := False;
    btnCancel.Caption := 'Inchide';
  end;

  IBCQueryBanks.Active := True;
  if fBankAccount <> '' then
    IBCQueryBanks.Locate('BANKACCOUNT', fBankAccount, []);

  cxGridBanksDB_BANKNAME.Focused := True;
end;

function TfrmBanksBrowserDlg.SelectBank(const DefaultBankAccount: string): Boolean;
begin
  SelectMode := True;
  BankAccount := DefaultBankAccount;
  Result := ShowModal = mrOk;
end;

procedure TfrmBanksBrowserDlg.SelectionChanged;
var
  f1, f2: Boolean;
begin
  f1 := True; // security
  f2 := False;
  if cxGridBanksDB.DataController.RecNo > 0 then
  begin
    f2 := True;
  end;

  bbNew.Enabled := f1;
  bbModify.Enabled := f2; // security
  bbRemove.Enabled := f2; // security
  btnOk.Enabled := fSelectMode and f2;
end;

procedure TfrmBanksBrowserDlg.SetupSecurityItems;
var
  visAll: Boolean;
begin
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Банки_Создать) then
    bbNew.Visible := ivNever;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Банки_Редактировать) then
    bbModify.Visible := ivNever;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Банки_Удалить) then
    bbRemove.Visible := ivNever;

//  visAll := (bbNew.Visible = ivAlways) or (bbModify.Visible = ivAlways) or (bbRemove.Visible = ivAlways);
//  if not visAll then
//  begin
//    dxBarManager1Bar2.Visible := False;
//    dxBarDockControl1.Visible := False;
//  end;

  if dxBarPopupMenu.ItemLinks.VisibleItemCount = 0 then
    cxGridBanksDB.PopupMenu := nil;
end;

end.

