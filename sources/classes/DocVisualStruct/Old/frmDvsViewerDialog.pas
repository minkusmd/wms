unit frmDvsViewerDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit,
  cxLabel, cxCheckBox, StdCtrls, cxVGrid, cxDBVGrid, cxInplaceContainer, cxCustomData, cxFilter, cxData, cxDataStorage,
  DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Buttons, Menus, cxButtons, DBAccess, IBC, MemDS, cxCurrencyEdit, dxBar, cxGridCustomPopupMenu, cxGridPopupMenu,
  cxNavigator, dxDateRanges, dxBarBuiltInMenu;

type
  TfrmDvsViewerDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnClose: TButton;
    IBCQueryCurrDoc: TIBCQuery;
    IBCDataSourceCurrDoc: TIBCDataSource;
    IBCQueryParentDoc: TIBCQuery;
    IBCDataSourceParentDoc: TIBCDataSource;
    IBCQueryChildDoc: TIBCQuery;
    IBCDataSourceChildDoc: TIBCDataSource;
    cxGridNPN: TcxGrid;
    cxGridNPNTable: TcxGridDBTableView;
    cxGridNPNTableDocID: TcxGridDBColumn;
    cxGridNPNTableDocNo: TcxGridDBColumn;
    cxGridNPN_DATA: TcxGridDBColumn;
    cxGridNPN_CREATED_DATE: TcxGridDBColumn;
    cxGridNPN_DTDEP_NAME: TcxGridDBColumn;
    cxGridNPN_CT_NAME: TcxGridDBColumn;
    cxGridNPNTableSuma: TcxGridDBColumn;
    cxGridNPN_CURRENCY_NAME: TcxGridDBColumn;
    cxGridNPNTableVAT: TcxGridDBColumn;
    cxGridNPNTableRate: TcxGridDBColumn;
    cxGridNPNTableParentDocID: TcxGridDBColumn;
    cxGridNPN_RATEUSD: TcxGridDBColumn;
    cxGridNPNTable_FLG_ACNT: TcxGridDBColumn;
    cxGridNPNTable_FLG_SHIP: TcxGridDBColumn;
    cxGridNPNTable_FLG_PROTECTED: TcxGridDBColumn;
    cxGridNPNTable_CUSTOMER_TYPE_ID: TcxGridDBColumn;
    cxGridNPN_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridNPN_CT: TcxGridDBColumn;
    cxGridNPN_DT: TcxGridDBColumn;
    cxGridNPNLevel: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBColumn10: TcxGridDBColumn;
    cxGridDBColumn11: TcxGridDBColumn;
    cxGridDBColumn12: TcxGridDBColumn;
    cxGridDBColumn13: TcxGridDBColumn;
    cxGridDBColumn14: TcxGridDBColumn;
    cxGridDBColumn15: TcxGridDBColumn;
    cxGridDBColumn16: TcxGridDBColumn;
    cxGridDBColumn17: TcxGridDBColumn;
    cxGridDBColumn18: TcxGridDBColumn;
    cxGridDBColumn19: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridDBColumn20: TcxGridDBColumn;
    cxGridDBColumn21: TcxGridDBColumn;
    cxGridDBColumn22: TcxGridDBColumn;
    cxGridDBColumn23: TcxGridDBColumn;
    cxGridDBColumn24: TcxGridDBColumn;
    cxGridDBColumn25: TcxGridDBColumn;
    cxGridDBColumn26: TcxGridDBColumn;
    cxGridDBColumn27: TcxGridDBColumn;
    cxGridDBColumn28: TcxGridDBColumn;
    cxGridDBColumn29: TcxGridDBColumn;
    cxGridDBColumn30: TcxGridDBColumn;
    cxGridDBColumn31: TcxGridDBColumn;
    cxGridDBColumn32: TcxGridDBColumn;
    cxGridDBColumn33: TcxGridDBColumn;
    cxGridDBColumn34: TcxGridDBColumn;
    cxGridDBColumn35: TcxGridDBColumn;
    cxGridDBColumn36: TcxGridDBColumn;
    cxGridDBColumn37: TcxGridDBColumn;
    cxGridDBColumn38: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGridNPNTableColumn1: TcxGridDBColumn;
    cxGridDBTableView2Column1: TcxGridDBColumn;
    dxBarManager: TdxBarManager;
    cxGridPopupMenuCurrDoc: TcxGridPopupMenu;
    dxBarPopupMenuCurrDoc: TdxBarPopupMenu;
    bbGotoFromCurrentDoc: TdxBarButton;
    dxBarPopupMenuChild: TdxBarPopupMenu;
    dxBarPopupMenuParent: TdxBarPopupMenu;
    cxGridPopupMenuChildDoc: TcxGridPopupMenu;
    cxGridPopupMenuParentDoc: TcxGridPopupMenu;
    bbGotoFromChild: TdxBarButton;
    bbInspectChild: TdxBarButton;
    bbGotoFromParent: TdxBarButton;
    bbInspectParent: TdxBarButton;
    pnCurrDoc: TPanel;
    Label1: TLabel;
    Panel1: TPanel;
    Label4: TLabel;
    Panel2: TPanel;
    Label3: TLabel;
    procedure bbInspectChildClick(Sender: TObject);
    procedure bbInspectParentClick(Sender: TObject);
    procedure bbGotoFromCurrentDocClick(Sender: TObject);
    procedure bbGotoFromChildClick(Sender: TObject);
    procedure bbGotoFromParentClick(Sender: TObject);
  private
    { Private declarations }
    fFirstTime:Boolean;
    fRequireDocumentLookup: Boolean;
    fLookupDocument: integer;
    FTargetDocID: integer;
    procedure OpenData(const DocID:integer);
    procedure CloseAndLookup(const DocID:integer);
    procedure SetTargetDocID(const Value: integer);
  protected
    { protected declarations }
    procedure Prepare;override;
    procedure LoadStates;override;
    procedure SaveStates;override;

  public
    { Public declarations }
    property TargetDocID:integer read FTargetDocID write SetTargetDocID;
    property RequireDocumentLookup:Boolean read fRequireDocumentLookup;
    property LookupDocument:integer read fLookupDocument;
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNValueStorageUnit;

{$R *.dfm}

{ TfrmDvsViewerDlg }



procedure TfrmDvsViewerDlg.bbGotoFromChildClick(Sender: TObject);
begin
     CloseAndLookup(IBCQueryChildDoc.FieldByName('DOCID').AsInteger);
end;

procedure TfrmDvsViewerDlg.bbGotoFromCurrentDocClick(Sender: TObject);
begin
     CloseAndLookup(IBCQueryCurrDoc.FieldByName('DOCID').AsInteger);
end;

procedure TfrmDvsViewerDlg.bbGotoFromParentClick(Sender: TObject);
begin
     CloseAndLookup(IBCQueryParentDoc.FieldByName('DOCID').AsInteger);
end;

procedure TfrmDvsViewerDlg.bbInspectChildClick(Sender: TObject);
begin
     OpenData(IBCQueryChildDoc.FieldByName('DOCID').AsInteger);
end;

procedure TfrmDvsViewerDlg.bbInspectParentClick(Sender: TObject);
begin
     OpenData(IBCQueryParentDoc.FieldByName('DOCID').AsInteger);
end;

procedure TfrmDvsViewerDlg.CloseAndLookup(const DocID: integer);
begin
     fRequireDocumentLookup:=True;
     fLookupDocument:=DocID;
     ModalResult:=mrOk;
end;

procedure TfrmDvsViewerDlg.LoadStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then AppUserConfigStorage.FormPositions.ReadFormPos(Self);
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
     begin
          AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridDBTableView1);
          AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridNPNTable);
          AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridDBTableView2);
     end;
end;

procedure TfrmDvsViewerDlg.OpenData(const DocID: integer);
begin
     IBCQueryCurrDoc.Close;
     IBCQueryCurrDoc.ParamByName('id').AsInteger:=DocID;
     IBCQueryCurrDoc.Active:=True;
     IBCQueryParentDoc.Active:=True;
     IBCQueryChildDoc.Active:=True;
end;

procedure TfrmDvsViewerDlg.Prepare;
begin
     inherited;
     fRequireDocumentLookup:=False;
     fLookupDocument:=-1;
     OpenData(FTargetDocID);
end;

procedure TfrmDvsViewerDlg.SaveStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then AppUserConfigStorage.FormPositions.SaveFormPos(Self);
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
     begin
          AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridDBTableView1);
          AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridNPNTable);
          AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridDBTableView2);
     end;
end;

procedure TfrmDvsViewerDlg.SetTargetDocID(const Value: integer);
begin
     FTargetDocID := Value;
end;

end.
