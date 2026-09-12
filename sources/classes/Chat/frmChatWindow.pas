unit frmChatWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL, cxLabel,
  cxMaskEdit, cxTLdxBarBuiltInMenu, cxContainer, cxEdit, Vcl.Menus, cxFilter,
  cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData, cxImageComboBox, Vcl.StdCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxSplitter, cxButtons, cxTextEdit, cxMemo,
  Vcl.ExtCtrls, cxInplaceContainer, cxDBTL, cxTLData, cxGridCustomPopupMenu,
  cxGridPopupMenu, dxBar, DBAccess, IBC, MemDS, dxDateRanges, dxBarBuiltInMenu, dxScrollbarAnnotations;

const
  WM_REENABLE = WM_USER + $100;

type
  TwinChatWindow = class(TForm)
    cxDBTreeListChat: TcxDBTreeList;
    cxDBTreeListChat_TEXT: TcxDBTreeListColumn;
    cxDBTreeListChat_AUTHOR_TIME_NAME: TcxDBTreeListColumn;
    cxDBTreeListChat_CREATED: TcxDBTreeListColumn;
    cxDBTreeListChat_FLG_UNREAD: TcxDBTreeListColumn;
    cxDBTreeListChat_AUTHORID: TcxDBTreeListColumn;
    cxDBTreeListChat_MESSAGEID: TcxDBTreeListColumn;
    cxDBTreeListChat_AUTHOR_NAME: TcxDBTreeListColumn;
    Panel1: TPanel;
    lbChatPrivatePerson: TLabel;
    mmChatMessage: TcxMemo;
    btnChatSendMsg: TcxButton;
    cxSplitterChat: TcxSplitter;
    pnChatRight: TPanel;
    cxGridChatGroups: TcxGrid;
    cxGridChatGroupsTable: TcxGridDBTableView;
    cxGridChatGroups_ROOMID: TcxGridDBColumn;
    cxGridChatGroups_IMG: TcxGridDBColumn;
    cxGridChatGroups_COMPOSITE_TITLE: TcxGridDBColumn;
    cxGridChatGroups_NEW_MSG_COUNT: TcxGridDBColumn;
    cxGridChatGroups_FLG_PRIVATE: TcxGridDBColumn;
    cxGridChatGroups_CREATED_BY: TcxGridDBColumn;
    cxGridChatGroups_DESCRIPTION: TcxGridDBColumn;
    cxGridChatGroups_ORDERNO: TcxGridDBColumn;
    cxGridChatGroupsLevel: TcxGridLevel;
    pnCharRightBottom: TPanel;
    Label1: TLabel;
    cmbChatPeriod: TComboBox;
    cxGridPopupMenuChat: TcxGridPopupMenu;
    dxBarManagerChat: TdxBarManager;
    bbChat_NewGroup: TdxBarButton;
    bbChat_ModifyGroup: TdxBarButton;
    bbChat_CloseGroup: TdxBarButton;
    IBCSQLChat: TIBCSQL;
    IBCTrUpdateChat: TIBCTransaction;
    dxBarPopupMenuUnselected: TdxBarPopupMenu;
    dxBarPopupMenuSelected: TdxBarPopupMenu;
    IBCQueryChatRooms: TIBCQuery;
    IBCDataSourceRooms: TIBCDataSource;
    IBCDataSourceChatMSG: TIBCDataSource;
    IBCQueryChatMSG: TIBCQuery;
    procedure bbChat_ModifyGroupClick(Sender: TObject);
    procedure bbChat_NewGroupClick(Sender: TObject);
    procedure cxGridChatGroupsTableFocusedRecordChanged(Sender:
      TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cmbChatPeriodChange(Sender: TObject);
    procedure cxDBTreeListChatDblClick(Sender: TObject);
    procedure cxDBTreeListChatEnter(Sender: TObject);
    procedure cxDBTreeListChatStylesGetContentStyle(Sender: TcxCustomTreeList;
      AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
    procedure cxDBTreeListChat_CREATEDGetDisplayText(Sender: TcxTreeListColumn;
      ANode: TcxTreeListNode; var Value: string);
    procedure cxGridChatGroupsTableCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift:
      TShiftState; var AHandled: Boolean);
    procedure IBCQueryChatMSGAfterOpen(DataSet: TDataSet);
    procedure btnChatSendMsgClick(Sender: TObject);
    procedure mmChatMessageKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxDBTreeListChatKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cxGridChatGroupsTableStylesGetContentStyle(Sender:
      TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
      TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    procedure ChatGroupsSelectionChanged;
    function GetChatDateFilterValue: TDate;
    procedure CopyChatCellContent;
    procedure OpenChat;
    procedure MarkRoomAsRead(const RoomID, UserID: Integer);
    function MarkRoomAsReadDB(const RoomID, UserID: Integer): Boolean;
    procedure SendChatMessage;
    function SendChatMessageDB(const TargetRoomID, SenderUserID: Integer; const
      ChatMessage: string; const ParentMessageID: Integer = 0): Boolean;
    procedure RefreshChat;
  public
    { Public declarations }
    procedure ShowChatWindow;
    procedure UpdateChat;
    procedure WMEnable(var Message: TWMEnable); message WM_ENABLE;
    procedure WMReenable(var Message: TMessage); message WM_REENABLE;
  end;

var
  winChatWindow: TwinChatWindow;

implementation

{$R *.dfm}

uses
  System.DateUtils, Clipbrd, DataModuleAdditions, DataModuleDB,
  frmChatGroupSetupDialog, SWNUtils, SWNDBErrors, SWNConst;

procedure TwinChatWindow.bbChat_ModifyGroupClick(Sender: TObject);
var
  dialog: TfrmChatGroupSetupDlg;
begin
  dialog := TfrmChatGroupSetupDlg.Create(Self, IBCQueryChatRooms, IBCDataSourceRooms);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TwinChatWindow.bbChat_NewGroupClick(Sender: TObject);
var
  dialog: TfrmChatGroupSetupDlg;
begin
  dialog := TfrmChatGroupSetupDlg.Create(Self, IBCQueryChatRooms, IBCDataSourceRooms);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TwinChatWindow.btnChatSendMsgClick(Sender: TObject);
begin
  SendChatMessage;
end;

procedure TwinChatWindow.ChatGroupsSelectionChanged;
var
  fAdd, fEdit, fClose: Boolean;
    //FLG_PRIVATE:Boolean;
  currentUserIsOwner: Boolean;
begin
  fAdd := True;
  fEdit := False;
  fClose := False;
  if (cxGridChatGroupsTable.DataController.RecNo > 0) then
  begin
          //FLG_PRIVATE:=IBCQueryChatRooms.FieldByName('FLG_PRIVATE').AsInteger=1;
    currentUserIsOwner := IBCQueryChatRooms.FieldByName('CREATED_BY').AsInteger
      = dmDb.CurrentUserID;
    fEdit := currentUserIsOwner;
    fClose := currentUserIsOwner;
  end;
  bbChat_NewGroup.Enabled := fAdd;
  bbChat_ModifyGroup.Enabled := fEdit;
  bbChat_CloseGroup.Enabled := fClose;
end;

procedure TwinChatWindow.cmbChatPeriodChange(Sender: TObject);
begin
  IBCQueryChatMSG.Close;
  IBCQueryChatMSG.ParamByName('DATE').AsDate := GetChatDateFilterValue;

  cxDBTreeListChat.BeginUpdate;
  try
    IBCQueryChatMSG.Active := True;
    cxDBTreeListChat.FullExpand;
    if Assigned(cxDBTreeListChat.LastNode) then
      cxDBTreeListChat.Select(cxDBTreeListChat.LastNode);
  finally
    cxDBTreeListChat.EndUpdate;
  end;
end;

procedure TwinChatWindow.CopyChatCellContent;
begin
  if Assigned(cxDBTreeListChat.FocusedNode) then
  begin
    Clipboard.AsText := Format('%s [%s]'#13#10'%s'#13#10, [cxDBTreeListChat.FocusedNode.Values
      [cxDBTreeListChat_AUTHOR_NAME.ItemIndex], cxDBTreeListChat.FocusedNode.Values
      [cxDBTreeListChat_CREATED.ItemIndex], cxDBTreeListChat.FocusedNode.Values[cxDBTreeListChat_TEXT.ItemIndex]]);
  end;
end;

procedure TwinChatWindow.cxDBTreeListChatDblClick(Sender: TObject);
var
  hitTest: TcxTreeListHitTest;
begin
  hitTest := cxDBTreeListChat.HitTest;
  if (hitTest.HitAtNode) and Assigned(hitTest.HitNode) then
  begin
    lbChatPrivatePerson.Caption := Format('pentru'#13#10'%s:', [hitTest.HitNode.Values
      [cxDBTreeListChat_AUTHOR_NAME.ItemIndex]]);
    lbChatPrivatePerson.Visible := True;
    lbChatPrivatePerson.Tag := hitTest.HitNode.Values[cxDBTreeListChat_MESSAGEID.ItemIndex];
    mmChatMessage.SetFocus;
  end;
end;

procedure TwinChatWindow.cxDBTreeListChatEnter(Sender: TObject);
begin
  if Assigned(cxGridChatGroupsTable.Controller.FocusedRecord) and (cxGridChatGroupsTable.Controller.FocusedRecord.Values
    [cxGridChatGroups_NEW_MSG_COUNT.Index] > 0) then
  begin
          // mark room as read
    MarkRoomAsRead(cxGridChatGroupsTable.Controller.FocusedRecord.Values[cxGridChatGroups_ROOMID.Index],
      dmDB.CurrentUserID);
  end;
end;

procedure TwinChatWindow.cxDBTreeListChatKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     // Ctrl+C
  if (Key = 67) and (Shift = [ssCtrl]) then
    CopyChatCellContent;
end;

procedure TwinChatWindow.cxDBTreeListChatStylesGetContentStyle(Sender:
  TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var
  AStyle: TcxStyle);
begin
  if (AColumn = cxDBTreeListChat_TEXT) then
  begin
    if VarIsNumeric(ANode.Values[cxDBTreeListChat_FLG_UNREAD.ItemIndex]) then
    begin
      if (ANode.Values[cxDBTreeListChat_FLG_UNREAD.ItemIndex] = 1) then
        AStyle := dmAdditions.cxStyle_ChatUnread;
    end;
  end;
end;

procedure TwinChatWindow.cxDBTreeListChat_CREATEDGetDisplayText(Sender:
  TcxTreeListColumn; ANode: TcxTreeListNode; var Value: string);
var
  d: TDateTime;
begin
  if not VarIsNull(ANode.Values[cxDBTreeListChat_CREATED.ItemIndex]) then
  begin
    d := ANode.Values[cxDBTreeListChat_CREATED.ItemIndex];
    if DateOf(d) = DateOf(Now) then
      Value := FormatDateTime('hh:mm', d)
    else
      Value := FormatDateTime('dd.mm.yyyy hh:mm', d);
  end;
end;

procedure TwinChatWindow.cxGridChatGroupsTableCellClick(Sender:
  TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton:
  TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if VarIsNumeric(ACellViewInfo.RecordViewInfo.GridRecord.Values[cxGridChatGroups_NEW_MSG_COUNT.Index])
    then
  begin
    if ACellViewInfo.RecordViewInfo.GridRecord.Values[cxGridChatGroups_NEW_MSG_COUNT.Index]
      > 0 then
    begin
               // mark room as read
      MarkRoomAsRead(ACellViewInfo.RecordViewInfo.GridRecord.Values[cxGridChatGroups_ROOMID.Index],
        dmDB.CurrentUserID);
    end;
  end;
end;

procedure TwinChatWindow.cxGridChatGroupsTableFocusedRecordChanged(Sender:
  TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
  TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  ChatGroupsSelectionChanged;
end;

procedure TwinChatWindow.cxGridChatGroupsTableStylesGetContentStyle(Sender:
  TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
  TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarIsNumeric(ARecord.Values[cxGridChatGroups_NEW_MSG_COUNT.Index]) then
  begin
    if ARecord.Values[cxGridChatGroups_NEW_MSG_COUNT.Index] > 0 then
      AStyle := dmAdditions.cxStyle_Bold;
  end;
end;

procedure TwinChatWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TwinChatWindow.FormCreate(Sender: TObject);
begin
     //SetWindowLong(Self.Handle,  GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

function TwinChatWindow.GetChatDateFilterValue: TDate;
begin
  case cmbChatPeriod.ItemIndex of
    1:
      Result := DateOf(NOW) - 7;
    2:
      Result := DateOf(NOW) - 999;
  else
    Result := DateOf(NOW); // -1, 0
  end;
end;

procedure TwinChatWindow.IBCQueryChatMSGAfterOpen(DataSet: TDataSet);
begin
  cxDBTreeListChat.BeginUpdate;
  try
    cxDBTreeListChat.FullExpand;
    if Assigned(cxDBTreeListChat.LastNode) then
      cxDBTreeListChat.Select(cxDBTreeListChat.LastNode);
  finally
    cxDBTreeListChat.EndUpdate;
  end;
end;

procedure TwinChatWindow.MarkRoomAsRead(const RoomID, UserID: Integer);
begin
  if MarkRoomAsReadDB(RoomID, UserID) then
  begin
    IBCQueryChatRooms.RefreshRecord;
  end;
end;

function TwinChatWindow.MarkRoomAsReadDB(const RoomID, UserID: Integer): Boolean;
begin
  Result := False;
  IBCSQLChat.SQL.Text :=
    'UPDATE TCHAT_USERS SET FLG_HAS_NEW_MSG=0, NEW_MESSAGEID=-1 WHERE ROOMID=:RID AND USERID=:UID';
  IBCSQLChat.ParamByName('RID').AsInteger := RoomID;
  IBCSQLChat.ParamByName('UID').AsInteger := UserID;
  IBCSQLChat.Transaction.StartTransaction;
  try
    IBCSQLChat.Execute;
    IBCSQLChat.Transaction.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      IBCSQLChat.Transaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TwinChatWindow.mmChatMessageKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = 13) then
  begin
    SendChatMessage;
    Key := 0;
  end;
end;

procedure TwinChatWindow.OpenChat;
begin
  IBCQueryChatMSG.ParamByName('currUserID').AsInteger := dmDB.CurrentUserID;
  IBCQueryChatMSG.ParamByName('DATE').AsDate := GetChatDateFilterValue;
  IBCQueryChatRooms.Active := True;
  ChatGroupsSelectionChanged;

  cxDBTreeListChat.BeginUpdate;
  try
    IBCQueryChatMSG.Active := True;
    cxDBTreeListChat.FullExpand;
    if Assigned(cxDBTreeListChat.LastNode) then
      cxDBTreeListChat.Select(cxDBTreeListChat.LastNode);
  finally
    cxDBTreeListChat.EndUpdate;
  end;
end;

procedure TwinChatWindow.RefreshChat;
var
  i, beforeNewMsgCount, afterNewMsgCount: Integer;
begin
     // numaram kite sunt mesaje noi la moment
  beforeNewMsgCount := 0;
  for i := 0 to cxGridChatGroupsTable.DataController.RecordCount - 1 do
    beforeNewMsgCount := beforeNewMsgCount + cxGridChatGroupsTable.DataController.Values
      [i, cxGridChatGroups_NEW_MSG_COUNT.Index];

     // refresh groups
  IBCQueryChatRooms.Refresh;
  ChatGroupsSelectionChanged;

  if Assigned(cxGridChatGroupsTable.Controller.FocusedRecord) then
  begin
    IBCQueryChatMSG.Refresh;
          // scroll bottom
    if Assigned(cxDBTreeListChat.LastNode) then
      cxDBTreeListChat.Select(cxDBTreeListChat.LastNode);
  end;

  afterNewMsgCount := 0;
  for i := 0 to cxGridChatGroupsTable.DataController.RecordCount - 1 do
    afterNewMsgCount := afterNewMsgCount + cxGridChatGroupsTable.DataController.Values
      [i, cxGridChatGroups_NEW_MSG_COUNT.Index];

     //if (afterNewMsgCount<>beforeNewMsgCount) then FlashWindow;
end;

procedure TwinChatWindow.SendChatMessage;
var
  TargetRoomID, SenderUserID, ParentMessageID: Integer;
  Msg: string;
begin
  Msg := Trim(mmChatMessage.Text);
  if Msg = '' then
    Exit;

  if Assigned(cxGridChatGroupsTable.Controller.FocusedRecord) then
    TargetRoomID := cxGridChatGroupsTable.Controller.FocusedRecord.Values[cxGridChatGroups_ROOMID.Index]
  else
  begin
    ShowErrorDialog(cMSG_GeneralError_Title, 'Selectati camera de chat!');
    Exit;
  end;

  SenderUserID := dmDB.CurrentUserID;
  ParentMessageID := 0;
  if lbChatPrivatePerson.Visible then
    ParentMessageID := lbChatPrivatePerson.Tag;

     // disable controls
  mmChatMessage.Enabled := False;
  btnChatSendMsg.Enabled := False;

  try
    if SendChatMessageDB(TargetRoomID, SenderUserID, Msg, ParentMessageID) then
    begin
      mmChatMessage.Text := '';
      lbChatPrivatePerson.Visible := False;
      lbChatPrivatePerson.Tag := 0;
    end;
  finally
    mmChatMessage.Enabled := True;
    btnChatSendMsg.Enabled := True;
  end;
end;

function TwinChatWindow.SendChatMessageDB(const TargetRoomID, SenderUserID:
  Integer; const ChatMessage: string; const ParentMessageID: Integer): Boolean;
begin
  Result := False;
  IBCSQLChat.SQL.Text := 'EXECUTE PROCEDURE SP_CHAT_NEW_MESSAGE(:RID,:UID,:MSG,:PID)';
  IBCSQLChat.ParamByName('RID').AsInteger := TargetRoomID;
  IBCSQLChat.ParamByName('UID').AsInteger := SenderUserID;
  IBCSQLChat.ParamByName('MSG').AsString := ChatMessage;
  IBCSQLChat.ParamByName('PID').AsInteger := ParentMessageID;
  IBCSQLChat.Transaction.StartTransaction;
  try
    IBCSQLChat.Execute;
    IBCSQLChat.Transaction.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      IBCSQLChat.Transaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TwinChatWindow.ShowChatWindow;
begin
  OpenChat;
  Left := Screen.DesktopRect.Right - Width;
  Top := 100;
  Show;
end;

procedure TwinChatWindow.UpdateChat;
begin
  RefreshChat;
end;

procedure TwinChatWindow.WMEnable(var Message: TWMEnable);
begin
  if not Message.Enabled then
  begin
    PostMessage(Self.Handle, WM_REENABLE, 1, 0);
  end;
end;

procedure TwinChatWindow.WMReenable(var Message: TMessage);
begin
  EnableWindow(Self.Handle, True);
end;

end.

