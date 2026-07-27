unit LockFirmsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, StdCtrls, ComCtrls, Buttons,
  cxButtons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus;

type
  TfrmLockFirmsDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lvLockedFirms: TListView;
    sbUnlockItem: TSpeedButton;
    sbLockItem: TSpeedButton;
    sbLockAllItems: TSpeedButton;
    sbUnlockAllItems: TSpeedButton;
    lvOpenFirms: TListView;
    Label3: TLabel;
    Label4: TLabel;
    lbCounterLocked: TLabel;
    lbCounterOpen: TLabel;
    cbPartialAccess: TCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbLockItemClick(Sender: TObject);
    procedure sbUnlockItemClick(Sender: TObject);
    procedure sbUnlockAllItemsClick(Sender: TObject);
    procedure sbLockAllItemsClick(Sender: TObject);
    procedure lvLockedFirmsDblClick(Sender: TObject);
    procedure lvOpenFirmsDblClick(Sender: TObject);
    procedure lvOpenFirmsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
  private
    { Private declarations }
    fFirms:TList;
    procedure ClearFirms;
    procedure ReadFirms;
    procedure PrepareList;

    procedure SelectionChanged;
    procedure LockSelectedFirms;
    procedure OpenSelectedFirms;
    procedure DisplayCounters;

    function SaveFirms:Boolean;

  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

  public
    { Public declarations }
  end;


implementation

uses DataModuleDB, IBC, SWNDBErrors;

{$R *.dfm}

type
    PFirmaItemRec=^TFirmaItemRec;
    TFirmaItemRec=record
      CustomerID:integer;
      DisplayName:String;
      Original_Lock_Enabled:integer;
      Lock_Enabled:integer;
    end;

{ TfrmLockFirmsDlg }

procedure TfrmLockFirmsDlg.ClearFirms;
var i:integer;
begin
     for i := 0 to fFirms.Count - 1 do Dispose(PFirmaItemRec(fFirms[i]));
     fFirms.Clear;
end;

procedure TfrmLockFirmsDlg.DisplayCounters;
begin
     lbCounterLocked.Caption:=IntToStr(lvLockedFirms.Items.Count);
     lbCounterOpen.Caption:=IntToStr(lvOpenFirms.Items.Count);
end;

procedure TfrmLockFirmsDlg.FormCreate(Sender: TObject);
begin
     fFirms:=TList.Create;
end;

procedure TfrmLockFirmsDlg.FormDestroy(Sender: TObject);
begin
     ClearFirms;
     fFirms.Free;
end;

function TfrmLockFirmsDlg.IsFormDataPosted: Boolean;
begin
     Result:=SaveFirms;
end;


procedure TfrmLockFirmsDlg.LockSelectedFirms;
var i:integer;
    FirmaItem:PFirmaItemRec;
    T:TListItem;
begin
     lvLockedFirms.Items.BeginUpdate;
     lvOpenFirms.Items.BeginUpdate;
     try
        for i :=0 to lvOpenFirms.Items.Count-1do
        if lvOpenFirms.Items[i].Selected then
        begin
             FirmaItem:=PFirmaItemRec(lvOpenFirms.Items[i].Data);

             T:=lvLockedFirms.Items.Add;
             T.Caption:=FirmaItem^.DisplayName;
             T.ImageIndex:=11;
             T.Data:=FirmaItem;
             // mark as Locked
             FirmaItem^.Lock_Enabled:=1;
        end;
        lvOpenFirms.DeleteSelected;
     finally
        lvLockedFirms.Items.EndUpdate;
        lvOpenFirms.Items.EndUpdate;
     end;

     DisplayCounters;
end;

procedure TfrmLockFirmsDlg.lvLockedFirmsDblClick(Sender: TObject);
var P:TPoint;
begin
     GetCursorPos(P);
     P:=lvLockedFirms.ScreenToClient(P);
     if Assigned(lvLockedFirms.GetItemAt(P.X,P.Y)) then OpenSelectedFirms;
end;

procedure TfrmLockFirmsDlg.lvOpenFirmsDblClick(Sender: TObject);
var P:TPoint;
begin
     GetCursorPos(P);
     P:=lvOpenFirms.ScreenToClient(P);
     if Assigned(lvOpenFirms.GetItemAt(P.X,P.Y)) then LockSelectedFirms;
end;

procedure TfrmLockFirmsDlg.lvOpenFirmsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmLockFirmsDlg.OpenSelectedFirms;
var i:integer;
    FirmaItem:PFirmaItemRec;
    T:TListItem;
begin
     lvLockedFirms.Items.BeginUpdate;
     lvOpenFirms.Items.BeginUpdate;
     try
        for i :=0 to lvLockedFirms.Items.Count-1do
        if lvLockedFirms.Items[i].Selected then
        begin
             FirmaItem:=PFirmaItemRec(lvLockedFirms.Items[i].Data);

             T:=lvOpenFirms.Items.Add;
             T.Caption:=FirmaItem^.DisplayName;
             T.ImageIndex:=11;
             T.Data:=FirmaItem;
             // mark as Open
             FirmaItem^.Lock_Enabled:=0;
        end;
        lvLockedFirms.DeleteSelected;
     finally
        lvLockedFirms.Items.EndUpdate;
        lvOpenFirms.Items.EndUpdate;
     end;

     DisplayCounters;
end;

procedure TfrmLockFirmsDlg.Prepare;
begin
     ReadFirms;
     PrepareList;
     SelectionChanged;
     DisplayCounters;
end;

procedure TfrmLockFirmsDlg.PrepareList;
var i:integer;
    FirmaItem:PFirmaItemRec;
    T:TListItem;
begin
     lvLockedFirms.Items.BeginUpdate;
     lvOpenFirms.Items.BeginUpdate;
     try
        for i := 0 to fFirms.Count - 1 do
        begin
             FirmaItem:=PFirmaItemRec(fFirms[i]);
             if FirmaItem^.Lock_Enabled=1
              then T:=lvLockedFirms.Items.Add
              else T:=lvOpenFirms.Items.Add;

             T.Caption:=FirmaItem^.DisplayName;
             T.ImageIndex:=11;
             T.Data:=FirmaItem;
        end;
     finally
        lvLockedFirms.Items.EndUpdate;
        lvOpenFirms.Items.EndUpdate;
     end;
end;

procedure TfrmLockFirmsDlg.ReadFirms;
var Query:TIBCQuery;
    FirmaItem:PFirmaItemRec;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDb.IBCConnection;
        Query.SQL.Add('SELECT A.CUSTOMERID, A.DISPLAYNAME,');
        Query.SQL.Add(' IIF(EXISTS(SELECT DT FROM TSS_DBLOCKS WHERE TSS_DBLOCKS.DT=A.CUSTOMERID),1,0)');
        Query.SQL.Add('FROM GET_FIRMS_BY_USER(:USERID) A');
        Query.ParamByName('USERID').AsInteger:=dmDB.CurrentUserID;
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             New(FirmaItem);

             FirmaItem^.CustomerID:=Query.Fields[0].AsInteger;
             FirmaItem^.DisplayName:=Query.Fields[1].AsString;
             FirmaItem^.Original_Lock_Enabled:=Query.Fields[2].AsInteger;
             FirmaItem^.Lock_Enabled:=Query.Fields[2].AsInteger;

             fFirms.Add(FirmaItem);

             Query.Next;
        end;
        Query.Close;
     finally
        Query.Free;
     end;
end;

function TfrmLockFirmsDlg.SaveFirms:Boolean;
var Query:TIBCQuery;
    FirmaItem:PFirmaItemRec;
    i: Integer;
    NeedToShutdown:Boolean;
begin
     Result:=False;
     NeedToShutdown:=False;

     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDb.IBCConnection;
        Query.Transaction:=dmDb.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
           // 1. remove or set the Lock
           Query.SQL.Text:='DELETE FROM TSS_DBLOCKS WHERE DT=:DT';
           for i := 0 to fFirms.Count - 1 do
           begin
                FirmaItem:=PFirmaItemRec(fFirms[i]);
                if (FirmaItem^.Lock_Enabled=0) and (FirmaItem^.Lock_Enabled<>FirmaItem^.Original_Lock_Enabled) then
                begin
                     Query.ParamByName('DT').AsInteger:=FirmaItem^.CustomerID;
                     Query.ExecSQL;
                end;
           end;

           // 2. add new Lock
           Query.SQL.Text:='INSERT INTO TSS_DBLOCKS (DT,USERID,FLG_ALLOW_PARTIAL_ACCESS) VALUES (:DT,:USERID,:Acc)';
           Query.ParamByName('USERID').AsInteger:=dmDB.CurrentUserID;
           Query.ParamByName('Acc').AsInteger:=Ord(cbPartialAccess.Checked);
           for i := 0 to fFirms.Count - 1 do
           begin
                FirmaItem:=PFirmaItemRec(fFirms[i]);
                if (FirmaItem^.Lock_Enabled=1) and (FirmaItem^.Lock_Enabled<>FirmaItem^.Original_Lock_Enabled) then
                begin
                     Query.ParamByName('DT').AsInteger:=FirmaItem^.CustomerID;
                     Query.ExecSQL;

                     if (FirmaItem^.CustomerID=dmDB.CurrentFirma) and (FirmaItem^.Lock_Enabled=1) then NeedToShutdown:=True;
                end;
           end;

           if NeedToShutdown then
           begin
                Query.SQL.Text:='EXECUTE PROCEDURE SEND_CUSTOM_EVENT(:EVENT)';
                Query.ParamByName('EVENT').AsString:='EVENT_CLOSEAPPIMMEDIATE';
                Query.ExecSQL;
           end;

           // commit
           Query.Transaction.Commit;
           Result:=True;

        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmLockFirmsDlg.sbLockAllItemsClick(Sender: TObject);
begin
     lvOpenFirms.SelectAll;
     LockSelectedFirms;
     SelectionChanged;
end;

procedure TfrmLockFirmsDlg.sbLockItemClick(Sender: TObject);
begin
     LockSelectedFirms;
end;

procedure TfrmLockFirmsDlg.sbUnlockAllItemsClick(Sender: TObject);
begin
     lvLockedFirms.SelectAll;
     OpenSelectedFirms;
     SelectionChanged;
end;

procedure TfrmLockFirmsDlg.sbUnlockItemClick(Sender: TObject);
begin
     OpenSelectedFirms;
end;

procedure TfrmLockFirmsDlg.SelectionChanged;
begin
     sbUnlockItem.Enabled:=lvLockedFirms.SelCount>0;
     sbUnlockAllItems.Enabled:=lvLockedFirms.Items.Count>0;
     sbLockItem.Enabled:=lvOpenFirms.SelCount>0;
     sbLockAllItems.Enabled:=lvOpenFirms.Items.Count>0;
end;

procedure TfrmLockFirmsDlg.WhenCancelForm;
begin

end;

end.
