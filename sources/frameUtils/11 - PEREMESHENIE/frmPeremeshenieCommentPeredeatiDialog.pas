unit frmPeremeshenieCommentPeredeatiDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, MemDS, DBAccess, IBC, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxContainer, dxBar, cxGridCustomPopupMenu, cxGridPopupMenu, cxTextEdit, cxMemo, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.StdCtrls, Vcl.ExtCtrls,
  DialogTitle, dxDateRanges, dxBarBuiltInMenu, dxScrollbarAnnotations;

type
  TfrmPeremeshenieCommentPeredeatiDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnAdd: TButton;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    cxGridTable_USER: TcxGridColumn;
    cxGridTable_DATA: TcxGridColumn;
    cxGridTable_COMMENTS: TcxGridColumn;
    cxGridLevel: TcxGridLevel;
    edComments: TcxMemo;
    btnOk: TButton;
    btnCancel: TButton;
    cxGridPopupMenu: TcxGridPopupMenu;
    dxBarManager: TdxBarManager;
    bbDeleteRecord: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    procedure btnAddClick(Sender: TObject);
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
  DataModuleDB, SWNDBErrors, SWNSecurity, SWNSecurityFlags;

{$R *.dfm}

{ TfrmPeremeshenieCommentPeredeatiDlg }

procedure TfrmPeremeshenieCommentPeredeatiDlg.btnAddClick(Sender: TObject);
begin
  DoAddNewComments;
end;

procedure TfrmPeremeshenieCommentPeredeatiDlg.DoAddNewComments;
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

function TfrmPeremeshenieCommentPeredeatiDlg.GetCommentsText: string;
var
  List: TStringList;
  i: integer;
begin
  List := TStringList.Create;
  try
    with cxGridTable.DataController do
      for i := 0 to RecordCount - 1 do
        List.Add(Format('%s (%s) - %s', [Values[i, cxGridTable_USER.Index], Values[i, cxGridTable_DATA.Index],
          Values[i, cxGridTable_COMMENTS.Index]]));

    Result := List.Text;
  finally
    List.Free;
  end;
end;

function TfrmPeremeshenieCommentPeredeatiDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  if fChanged then
    Result := SaveComments;

end;

procedure TfrmPeremeshenieCommentPeredeatiDlg.ParseComments;
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

procedure TfrmPeremeshenieCommentPeredeatiDlg.Prepare;
begin
  ReadComments;
  ParseComments;
  fChanged := False;
end;

procedure TfrmPeremeshenieCommentPeredeatiDlg.ReadComments;
//var Query:TIBCQuery;
begin
  fSourceComments := fMasterDataSet.FieldByName('COMMENTS').AsString;
//     Query:=TIBCQuery.Create(Self);
//     try
//        DocID := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
//        Query.Connection:=dmDB.IBCConnection;
//        Query.SQL.Text:='SELECT COMMENTS FROM TDB_DOCS_ADDONS WHERE DOCID=:id';
//        Query.ParamByName('id').AsInteger:=fDocID;
//        Query.ExecSQL;
//        if Not Query.Eof then fSourceComments:=Query.Fields[0].AsString;
//     finally
//        Query.Free;
//     end;
end;

function TfrmPeremeshenieCommentPeredeatiDlg.SaveComments: Boolean;
//var Query:TIBCQuery;
begin
  Result := False;
  fMasterDataSet.FieldByName('COMMENTS').AsString := GetCommentsText;
  Result := True;
//
//     Query:=TIBCQuery.Create(Self);
//     try
//        Query.AutoCommit:=False;
//        Query.Connection:=dmDB.IBCConnection;
//        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
//        Query.SQL.Text:='UPDATE OR INSERT INTO  TDB_DOCS_ADDONS (DOCID, COMMENTS) VALUES (:id,:comments) MATCHING (DOCID)';
//        Query.ParamByName('comments').AsString:=GetCommentsText;
//        Query.ParamByName('id').AsInteger:=fDocID;
////        Query.Transaction.StartTransaction;
//        try
//           Query.ExecSQL;
////           Query.Transaction.Commit;
//           Result:=True;
//        except on E: Exception do
//           begin
////                Query.Transaction.Rollback;
//                if Not ProcessSWNError(E) then raise;
//           end;
//        end;
//     finally
//        Query.Free;
//     end;
end;

procedure TfrmPeremeshenieCommentPeredeatiDlg.SetDocID(const Value: integer);
begin
  FDocID := Value;
end;

procedure TfrmPeremeshenieCommentPeredeatiDlg.SetupSecurityItems;
begin
  if not SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Администратор) then
    bbDeleteRecord.Visible := ivNever;
  if (dxBarPopupMenu1.ItemLinks.VisibleItemCount <= 0) then
    cxGridPopupMenu.PopupMenus[0].PopupMenu := nil;
end;

end.

