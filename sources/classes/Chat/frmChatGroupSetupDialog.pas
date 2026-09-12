unit frmChatGroupSetupDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, cxContainer, cxTextEdit, cxDBEdit, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxClasses,
  cxGridLevel, cxGrid, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, Vcl.Buttons, cxImageComboBox, cxMemo, cxCheckBox,
  dxDateRanges, dxScrollbarAnnotations;

type
  TfrmChatGroupSetupDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cxGridSLevel: TcxGridLevel;
    cxGridS: TcxGrid;
    cxGridSTable: TcxGridTableView;
    cxGridA: TcxGrid;
    cxGridATable: TcxGridTableView;
    cxGridALevel: TcxGridLevel;
    edTITLE: TcxDBTextEdit;
    btnOk: TButton;
    btnCancel: TButton;
    sbAddToSelected: TSpeedButton;
    sbRemoveFromSelected: TSpeedButton;
    cxGridSTable_ID: TcxGridColumn;
    cxGridSTable_NAME: TcxGridColumn;
    cxGridATable_ID: TcxGridColumn;
    cxGridATable_NAME: TcxGridColumn;
    cxGridSTable_IMG: TcxGridColumn;
    cxGridATable_IMG: TcxGridColumn;
    Label4: TLabel;
    mmDESCRIPTION: TcxDBMemo;
    cbFLG_PRIVATE: TcxDBCheckBox;
    procedure sbAddToSelectedClick(Sender: TObject);
    procedure sbRemoveFromSelectedClick(Sender: TObject);
    procedure cxGridATableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure cxGridSTableCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridATableCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridSTableCanSelectRecord(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure cxGridSTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues:Boolean;
    procedure SaveUserSelection;
    procedure ReadUsers;
    procedure GridSelectionChanged;
    procedure SelectedUsersChanged;
    function GetOtherUserName:String;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;


implementation

{$R *.dfm}

uses DB, IBC, DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst;

{ TfrmChatGroupSetupDlg }

function TfrmChatGroupSetupDlg.CheckValues: Boolean;
var Error:String;
begin
     Result:=False;
     Error:='';

     if (cxGridSTable.DataController.RecordCount<2) then AddErrorToStr(Error,'In grup trebuie sa fie minim 2 utilizatori!');

     if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').asString='')
      then AddErrorToStr(Error,'Denumirea grupului!');

     if Error='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Error);
end;

procedure TfrmChatGroupSetupDlg.cxGridATableCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     sbAddToSelectedClick(sbAddToSelected);
end;

procedure TfrmChatGroupSetupDlg.cxGridATableSelectionChanged(Sender: TcxCustomGridTableView);
begin
     GridSelectionChanged;
end;

procedure TfrmChatGroupSetupDlg.cxGridSTableCanSelectRecord(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; var AAllow: Boolean);
begin
     AAllow:=ARecord.Values[cxGridSTable_ID.Index]<>dmDB.CurrentUserID;
end;

procedure TfrmChatGroupSetupDlg.cxGridSTableCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     sbRemoveFromSelectedClick(sbRemoveFromSelected);
end;

procedure TfrmChatGroupSetupDlg.cxGridSTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
     if (ARecord.Values[cxGridSTable_ID.Index]=dmDB.CurrentUserID) then AStyle:=dmAdditions.cxStyle_TextColorGreen;
end;

function TfrmChatGroupSetupDlg.GetOtherUserName: String;
var i:integer;
begin
     for i := 0 to cxGridSTable.DataController.RecordCount-1 do
       if (cxGridSTable.DataController.Values[i,cxGridSTable_ID.Index]<>dmDB.CurrentUserID) then
       begin
            Result:=cxGridSTable.DataController.Values[i,cxGridSTable_NAME.Index];
            break;
       end;
end;

procedure TfrmChatGroupSetupDlg.GridSelectionChanged;
begin
     sbAddToSelected.Enabled:=cxGridATable.Controller.SelectedRecordCount>0;
     sbRemoveFromSelected.Enabled:=cxGridSTable.Controller.SelectedRecordCount>0;
end;

procedure TfrmChatGroupSetupDlg.BindingDataSource;
begin
     cbFLG_PRIVATE.DataBinding.DataSource:=fMasterDataSource;
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     mmDESCRIPTION.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmChatGroupSetupDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          SaveUserSelection;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmChatGroupSetupDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Creare grup nou';
             fMasterDataSet.Append;
             fMasterDataSet.FieldByName('FLG_NO_TITLE').AsInteger:=0;
             fMasterDataSet.FieldByName('FLG_PRIVATE').AsInteger:=1;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare inregistrare';
             fMasterDataSet.Edit;
        end;
        ReadUsers;
        GridSelectionChanged;
        SelectedUsersChanged;
     except
        if (fMasterDataSet.State in dsEditModes) then fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmChatGroupSetupDlg.ReadUsers;
var Query:TIBCQuery;
    N:Integer;
    id:Integer;
    name:String;
begin
     cxGridSTable.BeginUpdate;
     cxGridATable.BeginUpdate;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;
        Query.SQL.Text:='SELECT A.USERID, A.USER_FULLNAME, IIF(EXISTS(SELECT 1 FROM TCHAT_USERS WHERE ROOMID=:RID AND USERID=A.USERID),1,0) FROM GET_USERS_BY_USER2(1) A';
        Query.ParamByName('RID').AsInteger:=fMasterDataSet.FieldByName('ROOMID').AsInteger;
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             id:=Query.Fields[0].AsInteger;
             name:=Query.Fields[1].AsString;
             if (Query.Fields[2].AsInteger=1) or (FCreateNewRecord and (id=dmDB.CurrentUserID)) then
             begin
                  N:=cxGridSTable.DataController.AppendRecord;
                  cxGridSTable.DataController.Values[N,cxGridSTable_ID.Index]:=id;
                  cxGridSTable.DataController.Values[N,cxGridSTable_NAME.Index]:=name;
             end
             else
             begin
                  N:=cxGridATable.DataController.AppendRecord;
                  cxGridATable.DataController.Values[N,cxGridATable_ID.Index]:=id;
                  cxGridATable.DataController.Values[N,cxGridATable_NAME.Index]:=name;
             end;
             // next record
             Query.Next;
        end;
     finally
        Query.Free;
        cxGridSTable.EndUpdate;
        cxGridATable.EndUpdate;
     end;
end;

procedure TfrmChatGroupSetupDlg.SaveUserSelection;
var Query:TIBCSQL;
    i:Integer;
begin
     Query:=TIBCSQL.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;
        // 1. stergem datele curente
        Query.SQL.Text:='DELETE FROM TCHAT_USERS WHERE ROOMID=:ID';
        Query.ParamByName('ID').AsInteger:=fMasterDataSet.FieldByName('ROOMID').AsInteger;
        Query.Execute;
        // adaugam userii selectati
        Query.SQL.Text:='INSERT INTO TCHAT_USERS (ROOMID,USERID) VALUES(:RID,:UID)';
        Query.ParamByName('RID').AsInteger:=fMasterDataSet.FieldByName('ROOMID').AsInteger;
        for i := 0 to cxGridSTable.DataController.RecordCount-1 do
        begin
             Query.ParamByName('UID').AsInteger:=cxGridSTable.DataController.Values[i,cxGridSTable_ID.Index];
             Query.Execute;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmChatGroupSetupDlg.sbAddToSelectedClick(Sender: TObject);
var i,N,Index:Integer;
begin
     cxGridATable.BeginUpdate;
     cxGridSTable.BeginUpdate;
     try
        cxGridSTable.DataController.ClearSelection;
        for i := 0 to cxGridATable.Controller.SelectedRecordCount-1 do
        begin
             index:=cxGridATable.Controller.SelectedRecords[i].RecordIndex;
             N:=cxGridSTable.DataController.AppendRecord;
             cxGridSTable.DataController.Values[N,cxGridSTable_ID.Index]:=cxGridATable.DataController.Values[index,cxGridATable_ID.Index];
             cxGridSTable.DataController.Values[N,cxGridSTable_NAME.Index]:=cxGridATable.DataController.Values[index,cxGridATable_NAME.Index];
        end;
        cxGridATable.DataController.DeleteSelection;
     finally
        cxGridATable.EndUpdate;
        cxGridSTable.EndUpdate;
     end;
     GridSelectionChanged;
     SelectedUsersChanged;
end;

procedure TfrmChatGroupSetupDlg.sbRemoveFromSelectedClick(Sender: TObject);
var i,N,Index:Integer;
begin
     cxGridATable.BeginUpdate;
     cxGridSTable.BeginUpdate;
     try
        for i := 0 to cxGridSTable.Controller.SelectedRecordCount-1 do
        begin
             index:=cxGridSTable.Controller.SelectedRecords[i].RecordIndex;
             N:=cxGridATable.DataController.AppendRecord;
             cxGridATable.DataController.Values[N,cxGridATable_ID.Index]:=cxGridSTable.DataController.Values[index,cxGridSTable_ID.Index];
             cxGridATable.DataController.Values[N,cxGridATable_NAME.Index]:=cxGridSTable.DataController.Values[index,cxGridSTable_NAME.Index];
        end;
        cxGridSTable.DataController.DeleteSelection;
     finally
        cxGridATable.EndUpdate;
        cxGridSTable.EndUpdate;
     end;
     GridSelectionChanged;
     SelectedUsersChanged;
end;

procedure TfrmChatGroupSetupDlg.SelectedUsersChanged;
var userCount:Integer;
begin
     userCount:=cxGridSTable.DataController.RecordCount;
//     edTITLE.Enabled:=userCount>2;
     if (userCount<=1) then
     begin
          fMasterDataSet.FieldByName('TITLE').AsString:='';
          fMasterDataSet.FieldByName('FLG_NO_TITLE').AsInteger:=0;
     end
     else
     if (userCount=2) then
     begin
          fMasterDataSet.FieldByName('TITLE').AsString:=GetOtherUserName;
          fMasterDataSet.FieldByName('FLG_NO_TITLE').AsInteger:=1;
     end
     else
     begin
          fMasterDataSet.FieldByName('FLG_NO_TITLE').AsInteger:=0;
     end;
end;

procedure TfrmChatGroupSetupDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmChatGroupSetupDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
