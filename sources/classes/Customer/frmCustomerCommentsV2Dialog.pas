unit frmCustomerCommentsV2Dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, cxClasses, cxGridLevel, cxGrid, StdCtrls, cxTextEdit, ExtCtrls, Data.DB, DBAccess, IBC,
  MemDS, dxBar, cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator;

type
  TfrmCustomerCommentsV2Dlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edComments: TcxTextEdit;
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
    IBCTrUpdate: TIBCTransaction;
    procedure btnAddClick(Sender: TObject);
    procedure bbDeleteRecordClick(Sender: TObject);
  private
    { Private declarations }
    fChanged:Boolean;
    fCustomerID: integer;
    fSourceComments:String;
    fAutoCommit: boolean;

    procedure ParseComments;
    procedure DoAddNewComments;
    function GetCommentsText:String;

    procedure ReadComments;
    procedure SetCustomerID(const Value: integer);
    procedure SetAutoCommit(const Value: boolean);
    function SaveComments:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure SetupSecurityItems;override;
  public
    { Public declarations }
    property CustomerID:integer read fCustomerID write SetCustomerID;
    property AutoCommit: boolean read fAutoCommit write SetAutoCommit default True;
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNDBErrors, SWNSecurity, SWNSecurityFlags;

{$R *.dfm}

{ TfrmDocumentCommentsEditorDlg }

procedure TfrmCustomerCommentsV2Dlg.bbDeleteRecordClick(Sender: TObject);
begin
     cxGridTable.DataController.DeleteFocused;
     fChanged:=True;
end;

procedure TfrmCustomerCommentsV2Dlg.btnAddClick(Sender: TObject);
begin
     DoAddNewComments;
end;

procedure TfrmCustomerCommentsV2Dlg.DoAddNewComments;
var S:String;
    recIndex:integer;
begin
     S:=Trim(edComments.Text);
     if S='' then exit;

     cxGridTable.DataController.BeginUpdate;
     try
        recIndex:=cxGridTable.DataController.AppendRecord;
        cxGridTable.DataController.Values[recIndex,cxGridTable_DATA.Index]:=FormatDateTime('dd.mm.yyyy hh:nn',NOW);
        cxGridTable.DataController.Values[recIndex,cxGridTable_USER.Index]:=dmDB.CurrentUserFullName;
        cxGridTable.DataController.Values[recIndex,cxGridTable_COMMENTS.Index]:=S;

        edComments.Text:='';
        fChanged:=True;
     finally
       cxGridTable.DataController.EndUpdate;
     end;
end;

function TfrmCustomerCommentsV2Dlg.GetCommentsText: String;
var List:TStringList;
    i:integer;
begin
     List:=TStringList.Create;
     try
        with cxGridTable.DataController do
        for i := 0 to RecordCount - 1 do
        List.Add(Format('%s (%s) - %s',[Values[i,cxGridTable_USER.Index],Values[i,cxGridTable_DATA.Index],Values[i,cxGridTable_COMMENTS.Index]]));

        Result:=List.Text;
     finally
        List.Free;
     end;
end;

function TfrmCustomerCommentsV2Dlg.IsFormDataPosted: Boolean;
begin
     Result:=True;
     if fChanged then Result:=SaveComments;
end;

procedure TfrmCustomerCommentsV2Dlg.ParseComments;
var List:TStringList;
    i,k,recIndex:integer;
    S:String;
    dateStr,userStr,comStr:String;
begin
     List:=TStringList.Create;
     cxGridTable.DataController.BeginUpdate;
     try
        // convert to lines
        List.Text:=fSourceComments;

        for i := 0 to List.Count - 1 do
        begin
             S:=Trim(List[i]);
             if S='' then Continue;

             dateStr:='(??.??.?? ??:??)';
             userStr:='unknown';

             k:=pos(' (',S);
             if (k>0) then
             begin
                  // user
                  userStr:=Trim(Copy(S,1,k-1));
                  Delete(S,1,k+1);
                  k:=pos(') - ',S);
                  if (k>0) then
                  begin
                       // date time
                       dateStr:=Trim(Copy(S,1,k-1));
                       Delete(S,1,k+3);
                  end
             end;
             comStr:=Trim(S);

             recIndex:=cxGridTable.DataController.AppendRecord;
             cxGridTable.DataController.Values[recIndex,cxGridTable_DATA.Index]:=dateStr;
             cxGridTable.DataController.Values[recIndex,cxGridTable_USER.Index]:=userStr;
             cxGridTable.DataController.Values[recIndex,cxGridTable_COMMENTS.Index]:=comStr;
        end;
     finally
        List.Free;
        cxGridTable.DataController.EndUpdate;
     end;
end;

procedure TfrmCustomerCommentsV2Dlg.Prepare;
begin
     ReadComments;
     ParseComments;
     fChanged:=False;
end;

procedure TfrmCustomerCommentsV2Dlg.ReadComments;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT COMMENTS FROM TS_CUST_COMMENTS WHERE CUSTOMERID=:id';
        Query.ParamByName('id').AsInteger:=fCustomerID;
        Query.ExecSQL;
        if Not Query.Eof then fSourceComments:=Query.Fields[0].AsString;
     finally
        Query.Free;
     end;
end;

function TfrmCustomerCommentsV2Dlg.SaveComments: Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=IBCTrUpdate;
        Query.SQL.Text:='UPDATE OR INSERT INTO TS_CUST_COMMENTS (CUSTOMERID, COMMENTS) VALUES (:id,:comments) MATCHING (CUSTOMERID)';
        Query.ParamByName('comments').AsString:=GetCommentsText;
        Query.ParamByName('id').AsInteger:=fCustomerID;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           if fAutoCommit then
           begin
              Query.Transaction.Commit;
           end;

           Result:=True;
        except on E: Exception do
           begin
                if fAutoCommit then
                begin
                     Query.Transaction.Rollback;
                end;

                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmCustomerCommentsV2Dlg.SetAutoCommit(const Value: boolean);
begin
  fAutoCommit := Value;
end;

procedure TfrmCustomerCommentsV2Dlg.SetCustomerID(const Value: integer);
begin
     fCustomerID := Value;
end;

procedure TfrmCustomerCommentsV2Dlg.SetupSecurityItems;
begin
     if Not SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Администратор) then bbDeleteRecord.Visible:=ivNever;
     if (dxBarPopupMenu1.ItemLinks.VisibleItemCount<=0) then cxGridPopupMenu.PopupMenus[0].PopupMenu:=nil;
end;

end.
