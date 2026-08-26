unit frmMergeGoodsAcntUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, cxStyles, cxCustomData, cxGraphics, DB, cxDBData, Menus,
  IBC, StdCtrls, ExtCtrls, DialogTitle, cxButtons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  cxCurrencyEdit, cxCalc, DBAccess, MemDS, cxClasses;

type
  TfrmMergeGoodsAcntDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    cxGridAcnt: TcxGrid;
    cxGridAcntTable: TcxGridDBTableView;
    cxGridAcntLevel: TcxGridLevel;
    cxGridAcnt_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridAcnt_NAMEACNT: TcxGridDBColumn;
    cxGridAcnt_PRICE_ACNT: TcxGridDBColumn;
    cxGridAcnt_QTY_ACCOUNT: TcxGridDBColumn;
    cxGridAcnt_GOODS_COUNT: TcxGridDBColumn;
    cxGridAcnt_GOODS_TYPE_TITLE: TcxGridDBColumn;
    cxGridAcnt_PARENT_TITLE: TcxGridDBColumn;
    IBCQueryAcnt: TIBCQuery;
    IBCDataSourceAcnt: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    lbHint: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure cxGridAcntTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    fGoodsAcntIDs: TArray<integer>;
    fTargetGoodsAcntID: integer;
    fTargetGoodsAcntTitle: string;
    fMergedCount: integer;
    function GetIDListText: string;
    function DoMerge(const ATargetGoodsAcntID: integer): Boolean;
    procedure MergeSelectedRecords;
  protected
    procedure Prepare; override;
  public
    { Public declarations }
    procedure SetGoodsAcntIDs(const AIDs: TArray<integer>);
    property TargetGoodsAcntID: integer read fTargetGoodsAcntID;
    property TargetGoodsAcntTitle: string read fTargetGoodsAcntTitle;
    property MergedCount: integer read fMergedCount;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNUtils, SWNDBErrors;

{$R *.dfm}

{ TfrmMergeGoodsAcntDlg }

procedure TfrmMergeGoodsAcntDlg.btnOkClick(Sender: TObject);
begin
  MergeSelectedRecords;
end;

procedure TfrmMergeGoodsAcntDlg.cxGridAcntTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and (ssDouble in AShift) then
  begin
    MergeSelectedRecords;
    AHandled := True;
  end;
end;

function TfrmMergeGoodsAcntDlg.DoMerge(const ATargetGoodsAcntID: integer): Boolean;
var
  q: TIBCQuery;
  i: integer;
begin
  Result := False;
  fMergedCount := 0;

  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.Transaction := IBCTrUpdate;
    q.AutoCommit := False;
    q.SQL.Text := 'EXECUTE PROCEDURE MERGE_GOODS_ACNT(:OLD_GOODS_ACNT_ID, :NEW_GOODS_ACNT_ID)';
    q.Prepare;

    if not IBCTrUpdate.Active then
      IBCTrUpdate.StartTransaction;
    try
      for i := 0 to High(fGoodsAcntIDs) do
      begin
        if fGoodsAcntIDs[i] = ATargetGoodsAcntID then
          Continue;

        q.ParamByName('OLD_GOODS_ACNT_ID').AsInteger := fGoodsAcntIDs[i];
        q.ParamByName('NEW_GOODS_ACNT_ID').AsInteger := ATargetGoodsAcntID;
        q.Execute;
        Inc(fMergedCount);
      end;
      IBCTrUpdate.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        if IBCTrUpdate.Active then
          IBCTrUpdate.Rollback;
        fMergedCount := 0;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    q.Free;
  end;
end;

function TfrmMergeGoodsAcntDlg.GetIDListText: string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to High(fGoodsAcntIDs) do
  begin
    if Result <> '' then
      Result := Result + ',';
    Result := Result + IntToStr(fGoodsAcntIDs[i]);
  end;
  if Result = '' then
    Result := '-1';
end;

procedure TfrmMergeGoodsAcntDlg.MergeSelectedRecords;
var
  TargetID: integer;
  TargetTitle: string;
begin
  if IBCQueryAcnt.IsEmpty or (IBCQueryAcnt.FieldByName('GOODS_ACNT_ID').IsNull) then
    Exit;

  TargetID := IBCQueryAcnt.FieldByName('GOODS_ACNT_ID').AsInteger;
  TargetTitle := IBCQueryAcnt.FieldByName('NAMEACNT').AsWideString;

  if Length(fGoodsAcntIDs) < 2 then
  begin
    ShowInfoDialog('Unirea denumirilor', 'Pentru unire trebuie selectate cel putin doua denumiri.');
    Exit;
  end;

  if ShowAskDialog('Unirea denumirilor',
                   Format('Toate cele %d denumiri selectate vor fi unite in "%s" (cod %d).',
                          [Length(fGoodsAcntIDs), TargetTitle, TargetID]),
                   'Produsele, soldurile contabile si subordonatele trec pe denumirea pastrata, '
                   + 'iar celelalte inregistrari se sterg din nomenclator. Operatia nu poate fi anulata.') <> mrYes then
    Exit;

  if DoMerge(TargetID) then
  begin
    fTargetGoodsAcntID := TargetID;
    fTargetGoodsAcntTitle := TargetTitle;
    ModalResult := mrOk;
  end;
end;

procedure TfrmMergeGoodsAcntDlg.Prepare;
begin
  dtDialogTitle.Text := Format('Au fost selectate %d denumiri', [Length(fGoodsAcntIDs)]);

  IBCQueryAcnt.Close;
  IBCQueryAcnt.SQL.Text :=
    'SELECT'
    + ' A.GOODS_ACNT_ID,'
    + ' A.NAMEACNT,'
    + ' A.PRICE_ACNT,'
    + ' A.GOODS_TYPEID,'
    + ' (SELECT GT.TITLE FROM TS_GOODS_TYPE GT WHERE GT.GOODSTYPEID=A.GOODS_TYPEID) GOODS_TYPE_TITLE,'
    + ' (SELECT P.NAMEACNT FROM TS_GOODS_ACNT P WHERE P.GOODS_ACNT_ID=A.PARENTID) PARENT_TITLE,'
    + ' (SELECT COUNT(*) FROM TS_GOODS G WHERE G.GOODS_ACNT_ID=A.GOODS_ACNT_ID) GOODS_COUNT,'
    + ' (SELECT COALESCE(SUM(S.QTY_ACCOUNT),0) FROM TS_GOODS_ACNT_STOCK S WHERE S.GOODS_ACNT_ID=A.GOODS_ACNT_ID) QTY_ACCOUNT'
    + ' FROM TS_GOODS_ACNT A'
    + ' WHERE A.GOODS_ACNT_ID IN (' + GetIDListText + ')'
    + ' ORDER BY A.NAMEACNT';
  IBCQueryAcnt.Open;

  cxGridAcnt_NAMEACNT.Focused := True;
end;

procedure TfrmMergeGoodsAcntDlg.SetGoodsAcntIDs(const AIDs: TArray<integer>);
begin
  fGoodsAcntIDs := Copy(AIDs, 0, Length(AIDs));
  fTargetGoodsAcntID := -1;
  fTargetGoodsAcntTitle := '';
  fMergedCount := 0;
end;

end.
