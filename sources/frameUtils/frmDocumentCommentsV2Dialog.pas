unit frmDocumentCommentsV2Dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, cxClasses, cxGridLevel, cxGrid, StdCtrls, cxTextEdit,
  ExtCtrls, Data.DB, DBAccess, IBC, MemDS, dxBar, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxNavigator, cxMemo, dxDateRanges, dxBarBuiltInMenu;

type
  TfrmDocumentCommentsV2Dlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    btnAdd: TButton;
    Label2: TLabel;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    cxGridTable_DATA: TcxGridColumn;
    cxGridTable_USER: TcxGridColumn;
    cxGridTable_COMMENTS: TcxGridColumn;
    btnOk: TButton;
    btnCancel: TButton;
    cxGridPopupMenu: TcxGridPopupMenu;
    dxBarManager: TdxBarManager;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bbDeleteRecord: TdxBarButton;
    edComments: TcxMemo;
    procedure btnAddClick(Sender: TObject);
    procedure bbDeleteRecordClick(Sender: TObject);
  private
    { Private declarations }
    fChanged: Boolean;
    fDocID: integer;
    fSourceComments: string;
    procedure ParseComments;
    procedure DoAddNewComments;
    function GetCommentsText: string;
    procedure ReadComments;
    procedure SetDocID(const Value: integer);
    function SaveComments: Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property DocID: integer read FDocID write SetDocID;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNDBErrors, SWNSecurity, SWNSecurityFlags;

{$R *.dfm}

{ TfrmDocumentCommentsEditorDlg }

procedure TfrmDocumentCommentsV2Dlg.bbDeleteRecordClick(Sender: TObject);
begin
  cxGridTable.DataController.DeleteFocused;
  fChanged := True;
end;

procedure TfrmDocumentCommentsV2Dlg.btnAddClick(Sender: TObject);
begin
  DoAddNewComments;
end;

procedure TfrmDocumentCommentsV2Dlg.DoAddNewComments;
var
  S: string;
  recIndex: integer;
begin
  S := Trim(edComments.Text);
  if S = '' then
    exit;

  cxGridTable.DataController.BeginUpdate;
  try
    recIndex := cxGridTable.DataController.AppendRecord;
    cxGridTable.DataController.Values[recIndex, cxGridTable_DATA.Index] := FormatDateTime('dd.mm.yyyy hh:nn', NOW);
    cxGridTable.DataController.Values[recIndex, cxGridTable_USER.Index] := dmDB.CurrentUserFullName;
    cxGridTable.DataController.Values[recIndex, cxGridTable_COMMENTS.Index] := S;

    edComments.Text := '';
    fChanged := True;
  finally
    cxGridTable.DataController.EndUpdate;
  end;
end;

function TfrmDocumentCommentsV2Dlg.GetCommentsText: string;
var
  List: TStringList;
  i: integer;
begin
  List := TStringList.Create;
  try
    with cxGridTable.DataController do
      for i := 0 to RecordCount - 1 do
        List.Add(Format('%s (%s) - %s', [Values[i, cxGridTable_USER.Index], Values[i, cxGridTable_DATA.Index], Values[i, cxGridTable_COMMENTS.Index]]));

    Result := List.Text;
  finally
    List.Free;
  end;
end;

function TfrmDocumentCommentsV2Dlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  if fChanged then
    Result := SaveComments;
end;

procedure TfrmDocumentCommentsV2Dlg.ParseComments;
var
  List: TStringList;
  i, k, recIndex: integer;
  S: string;
  dateStr, userStr, comStr: string;
begin
  List := TStringList.Create;
  cxGridTable.DataController.BeginUpdate;
  try
        // convert to lines
    List.Text := fSourceComments;

    for i := 0 to List.Count - 1 do
    begin
      S := Trim(List[i]);
      if S = '' then
        Continue;

      dateStr := '(??.??.?? ??:??)';
      userStr := 'unknown';

      k := pos(' (', S);
      if (k > 0) then
      begin
                  // user
        userStr := Trim(Copy(S, 1, k - 1));
        Delete(S, 1, k + 1);
        k := pos(') - ', S);
        if (k > 0) then
        begin
                       // date time
          dateStr := Trim(Copy(S, 1, k - 1));
          Delete(S, 1, k + 3);
        end
      end;
      comStr := Trim(S);

      recIndex := cxGridTable.DataController.AppendRecord;
      cxGridTable.DataController.Values[recIndex, cxGridTable_DATA.Index] := dateStr;
      cxGridTable.DataController.Values[recIndex, cxGridTable_USER.Index] := userStr;
      cxGridTable.DataController.Values[recIndex, cxGridTable_COMMENTS.Index] := comStr;
    end;
  finally
    List.Free;
    cxGridTable.DataController.EndUpdate;
  end;
end;

procedure TfrmDocumentCommentsV2Dlg.Prepare;
begin
  ReadComments;
  ParseComments;
  fChanged := False;
end;

procedure TfrmDocumentCommentsV2Dlg.ReadComments;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT COMMENTS FROM TDB_DOCS_PROPS WHERE DOCID=:id';
    Query.ParamByName('id').AsInteger := fDocID;
    Query.ExecSQL;
    if not Query.Eof then
      fSourceComments := Query.Fields[0].AsString;
  finally
    Query.Free;
  end;
end;

function TfrmDocumentCommentsV2Dlg.SaveComments: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'UPDATE OR INSERT INTO TDB_DOCS_PROPS (DOCID, COMMENTS) VALUES (:id,:comments) MATCHING (DOCID)';
    Query.ParamByName('comments').AsString := GetCommentsText;
    Query.ParamByName('id').AsInteger := fDocID;
    Query.Transaction.StartTransaction;
    try
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

procedure TfrmDocumentCommentsV2Dlg.SetDocID(const Value: integer);
begin
  FDocID := Value;
end;

procedure TfrmDocumentCommentsV2Dlg.SetupSecurityItems;
begin
  if not SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Администратор) then
    bbDeleteRecord.Visible := ivNever;
  if (dxBarPopupMenu1.ItemLinks.VisibleItemCount <= 0) then
    cxGridPopupMenu.PopupMenus[0].PopupMenu := nil;
end;

end.

