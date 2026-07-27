unit frmDocTypeAnalyticsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, StdCtrls,
  cxTL, DB,
  Buttons, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxInplaceContainer, cxDBTL,
  DBAccess, IBC, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxImageComboBox,
  cxMaskEdit, cxTLdxBarBuiltInMenu, Vcl.Menus, MemDS, cxTLData, cxClasses;

type
  TfrmDocTypeAnalyticsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    edDOCTYPE: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    sbRemoveAnalytics: TSpeedButton;
    sbAddAnalytics: TSpeedButton;
    cxGridSelLevel: TcxGridLevel;
    cxGridSel: TcxGrid;
    cxDBTreeListAV: TcxDBTreeList;
    IBCQueryAv: TIBCQuery;
    IBCDataSourceAv: TIBCDataSource;
    cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn3: TcxDBTreeListColumn;
    IBCQuerySel: TIBCQuery;
    IBCDataSourceSel: TIBCDataSource;
    cxGridSelTable: TcxGridDBTableView;
    cxGridSel_TITLE: TcxGridDBColumn;
    cxGridSel_IMG: TcxGridDBColumn;
    cxGridSel_ANALITICAID: TcxGridDBColumn;
    IBCTrUpdate: TIBCTransaction;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure sbAddAnalyticsClick(Sender: TObject);
    procedure sbRemoveAnalyticsClick(Sender: TObject);
    procedure cxGridSelTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxDBTreeListAVFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
  private
    { Private declarations }
    fDocTypeID: integer;
    procedure SetDocTypeID(const Value: integer);

    procedure SelectionChanged;
    procedure SelectionAvailableChanged;

    procedure ReloadData;
    procedure ReadDocTypeAnalytics;
    procedure ReadAvailableAnalytics;

    function AppendAnalytics(const AnaliticaID:integer):Boolean;
    function RemoveAnalytics(const AnaliticaID:integer):Boolean;

    procedure SetDocTypeTitle(const Value: String);

  protected
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property DocTypeID:integer read FDocTypeID write SetDocTypeID;
    property DocTypeTitle:String write SetDocTypeTitle;
  end;


implementation

uses DataModuleDB, SWNDBErrors;

{$R *.dfm}

{ TfrmDocTypeAnalyticsDlg }

function TfrmDocTypeAnalyticsDlg.AppendAnalytics(const AnaliticaID:integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.AutoCommit:=False;
        Query.Transaction:=IBCTrUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_ANALYT_REGISTER_TO_DOCTYPE(:id,:analid)';
        Query.ParamByName('id').AsInteger:=fDocTypeID;
        Query.ParamByName('analid').AsInteger:=AnaliticaID;
        try
           Query.ExecSQL;
           Result:=True;
        except on E:Exception do
           if Not ProcessSWNError(E) then raise;
        end;
     finally
       Query.Free;
     end;
end;

procedure TfrmDocTypeAnalyticsDlg.cxDBTreeListAVFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
     SelectionAvailableChanged;
end;

procedure TfrmDocTypeAnalyticsDlg.cxGridSelTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

function TfrmDocTypeAnalyticsDlg.IsFormDataPosted: Boolean;
begin
     IBCTrUpdate.Commit;
     Result:=True;
end;

procedure TfrmDocTypeAnalyticsDlg.Prepare;
begin
     IBCTrUpdate.StartTransaction;
     try
        ReadDocTypeAnalytics;
        ReadAvailableAnalytics;

        SelectionChanged;
        SelectionAvailableChanged;
     except
        IBCTrUpdate.Rollback;
        raise;
     end;
end;

procedure TfrmDocTypeAnalyticsDlg.ReadAvailableAnalytics;
begin
     IBCQueryAv.ParamByName('id').AsInteger:=fDocTypeID;
     IBCQueryAv.Active:=True;
end;

procedure TfrmDocTypeAnalyticsDlg.ReadDocTypeAnalytics;
begin
     IBCQuerySel.ParamByName('id').AsInteger := fDocTypeID;
     IBCQuerySel.Active:=True;
end;

procedure TfrmDocTypeAnalyticsDlg.ReloadData;
begin
     cxGridSelTable.BeginUpdate;
     cxDBTreeListAV.BeginUpdate;
     try
        IBCQuerySel.Refresh;
        IBCQueryAv.Refresh;
     finally
        cxGridSelTable.EndUpdate;
        cxDBTreeListAV.EndUpdate;
     end;
end;

function TfrmDocTypeAnalyticsDlg.RemoveAnalytics(const AnaliticaID:integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.AutoCommit:=False;
        Query.Transaction:=IBCTrUpdate;
        Query.SQL.Text:='DELETE FROM TS_DOCS_ANALYTICS WHERE DOCTYPEID=:id AND ANALITICAID=:analid';
        Query.ParamByName('id').AsInteger:=fDocTypeID;
        Query.ParamByName('analid').AsInteger:=AnaliticaID;
        try
           Query.ExecSQL;
           Result:=True;
        except on E:Exception do
           if Not ProcessSWNError(E) then raise;
        end;
     finally
       Query.Free;
     end;
end;

procedure TfrmDocTypeAnalyticsDlg.sbAddAnalyticsClick(Sender: TObject);
begin
     if Assigned(cxDBTreeListAV.FocusedNode) then
     begin
          if AppendAnalytics(cxDBTreeListAV.FocusedNode.Values[0]) // ID
             then ReloadData;
     end;
end;

procedure TfrmDocTypeAnalyticsDlg.sbRemoveAnalyticsClick(Sender: TObject);
begin
     if Assigned(cxGridSelTable.Controller.FocusedRow) then
     begin
          if RemoveAnalytics(cxGridSelTable.Controller.FocusedRow.Values[cxGridSel_ANALITICAID.Index])
             then ReloadData;
     end;
end;

procedure TfrmDocTypeAnalyticsDlg.SelectionAvailableChanged;
var fAdd:Boolean;
begin
     fAdd:=false;
     if Assigned(cxDBTreeListAV.FocusedNode) then
     begin
          fAdd := true;
     end;
     sbAddAnalytics.Enabled := fAdd;
end;

procedure TfrmDocTypeAnalyticsDlg.SelectionChanged;
var fRemove:Boolean;
begin
     fRemove:=false;

     if (cxGridSelTable.Controller.FocusedRecordIndex>=0) then
     begin
          fRemove := true;
     end;

     sbRemoveAnalytics.Enabled := fRemove;
end;

procedure TfrmDocTypeAnalyticsDlg.SetDocTypeID(const Value: integer);
begin
     fDocTypeID := Value;
end;

procedure TfrmDocTypeAnalyticsDlg.SetDocTypeTitle(const Value: String);
begin
     edDOCTYPE.Text:=value;
end;

procedure TfrmDocTypeAnalyticsDlg.WhenCancelForm;
begin
     IBCTrUpdate.Rollback;
end;

end.
