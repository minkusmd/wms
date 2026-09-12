unit WebNewsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxContainer, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxTextEdit, cxMemo, cxDBEdit, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, dxBar, MemDS, DBAccess, IBC, StdCtrls;

type
  TfrmWebNewsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxGridNews: TcxGrid;
    cxGridNewsTable: TcxGridDBTableView;
    cxGridNews_NEWSID: TcxGridDBColumn;
    cxGridNews_TITLE: TcxGridDBColumn;
    cxGridNews_POSTEDTIME: TcxGridDBColumn;
    cxGridNewsLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbAddNew: TdxBarButton;
    bbModifyNews: TdxBarButton;
    bbDeleteNews: TdxBarButton;
    IBCQueryNews: TIBCQuery;
    IBCDataSourceNews: TIBCDataSource;
    btnClose: TButton;
    procedure cxGridNewsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbAddNewClick(Sender: TObject);
    procedure bbModifyNewsClick(Sender: TObject);
    procedure cxGridNewsTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure bbDeleteNewsClick(Sender: TObject);
  private
    { Private declarations }
    procedure SelectionChanged;

    procedure ShowCreateNewNewsDialog;
    procedure ShowModifyNewsDialog;
    procedure DeleteSelectedNews;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
  end;



implementation

uses DataModuleDB, DataModuleAdditions, WebNewsEditorDialog, SWNUtils, SWNDBErrors;

{$R *.dfm}

procedure TfrmWebNewsDlg.bbAddNewClick(Sender: TObject);
begin
     ShowCreateNewNewsDialog;
end;

procedure TfrmWebNewsDlg.bbDeleteNewsClick(Sender: TObject);
begin
     DeleteSelectedNews;
end;

procedure TfrmWebNewsDlg.bbModifyNewsClick(Sender: TObject);
begin
     ShowModifyNewsDialog;
end;

procedure TfrmWebNewsDlg.cxGridNewsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if bbModifyNews.Enabled then bbModifyNewsClick(bbModifyNews);
end;

procedure TfrmWebNewsDlg.cxGridNewsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmWebNewsDlg.DeleteSelectedNews;
var S:String;
begin
     S:=Format('Doriti sa stergeti stirea "%s"?',[IBCQueryNews.FieldByName('TITLE').AsString]);
     if ShowAskDialog('Stergere stire',S)=mrYes then
     begin
          IBCQueryNews.UpdateTransaction.StartTransaction;
          try
             IBCQueryNews.Delete;
             IBCQueryNews.UpdateTransaction.Commit;
          except on E:Exception do
             begin
                  IBCQueryNews.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

procedure TfrmWebNewsDlg.Prepare;
begin
     IBCQueryNews.Active:=True;
     SelectionChanged;
end;

procedure TfrmWebNewsDlg.SelectionChanged;
var fAdd,fModify,fDelete:Boolean;
begin
     fAdd:=True;
     fModify:=False;
     fDelete:=False;
     if (cxGridNewsTable.DataController.RecNo>0) then
     begin
          fModify:=True;
          fDelete:=True;
     end;
     bbAddNew.Enabled:=fAdd;
     bbModifyNews.Enabled:=fModify;
     bbDeleteNews.Enabled:=fDelete;
end;

procedure TfrmWebNewsDlg.ShowCreateNewNewsDialog;
var dialog:TfrmWebNewsEditorDlg;
begin
     dialog:=TfrmWebNewsEditorDlg.Create(Self,IBCQueryNews,IBCDataSourceNews);
     try
        dialog.CreateNewNews:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmWebNewsDlg.ShowModifyNewsDialog;
var dialog:TfrmWebNewsEditorDlg;
begin
     dialog:=TfrmWebNewsEditorDlg.Create(Self,IBCQueryNews,IBCDataSourceNews);
     try
        dialog.CreateNewNews:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

end.
