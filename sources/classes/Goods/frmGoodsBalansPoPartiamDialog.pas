unit frmGoodsBalansPoPartiamDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu, DBAccess, IBC, MemDS, cxInplaceContainer, cxTLData, cxDBTL,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle,
  cxMaskEdit, cxLabel, dxScrollbarAnnotations, dxDateRanges;

type
  TfrmGoodsBalansPoPartiamDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    pnLeft: TPanel;
    pnClientCenter: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cxGridBPTable: TcxGridDBTableView;
    cxGridBPLevel: TcxGridLevel;
    cxGridBP: TcxGrid;
    cxDBTreeList: TcxDBTreeList;
    IBCQueryStocks: TIBCQuery;
    IBCDataSourceStocks: TIBCDataSource;
    cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn;
    btnClose: TButton;
    IBCQueryBP: TIBCQuery;
    IBCDataSourceBP: TIBCDataSource;
    cxGridBP_DOCID: TcxGridDBColumn;
    cxGridBP_DOCTYPE_TITLE: TcxGridDBColumn;
    cxGridBP_DATA: TcxGridDBColumn;
    cxGridBP_CT_NAME: TcxGridDBColumn;
    cxGridBP_DTDEP_NAME: TcxGridDBColumn;
    cxGridBP_CTDEP_NAME: TcxGridDBColumn;
    cxGridBP_PARTNO: TcxGridDBColumn;
    cxGridBP_QTY: TcxGridDBColumn;
    cxGridBP_QTY_B: TcxGridDBColumn;
    cxGridBP_DOCSIGN: TcxGridDBColumn;
    cxDBTreeListcxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeListcxDBTreeListColumn2: TcxDBTreeListColumn;
    procedure cxDBTreeListFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure cxGridBP_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridBPTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FGoodsID: Integer;
    procedure SetGoodsID(const Value: Integer);
    procedure StockSelectionChanged;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property GoodsID:Integer read FGoodsID write SetGoodsID;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils;

{ TfrmGoodsBalansPoPartiamDlg }

procedure TfrmGoodsBalansPoPartiamDlg.cxDBTreeListFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
     StockSelectionChanged;
end;

procedure TfrmGoodsBalansPoPartiamDlg.cxGridBPTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     // Ctrl+C
     if (Key = 67) and (Shift = [ssCtrl]) then
     begin
          CopyGridCellTextToClipboard(cxGridBPTable);
     end;
end;

procedure TfrmGoodsBalansPoPartiamDlg.cxGridBP_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridBP_DATA.Index])
       then AText:=FormatDateTime('dd.mm.yyyy hh:NN',ARecord.Values[cxGridBP_DATA.Index]);
end;

procedure TfrmGoodsBalansPoPartiamDlg.Prepare;
begin
     IBCQueryBP.ParamByName('DT').AsInteger:=dmDB.CurrentFirma;
     IBCQueryBP.ParamByName('GOODSID').AsInteger:=FGoodsID;

     IBCQueryStocks.Active:=True;
end;

procedure TfrmGoodsBalansPoPartiamDlg.SetGoodsID(const Value: Integer);
begin
     FGoodsID := Value;
end;

procedure TfrmGoodsBalansPoPartiamDlg.StockSelectionChanged;
begin
     if IBCQueryStocks.Active then
     begin
          IBCQueryBP.Close;
          if Assigned(cxDBTreeList.FocusedNode) and (cxDBTreeList.FocusedNode.Values[2]=0) then
          begin
               IBCQueryBP.ParamByName('DEP').AsInteger:=cxDBTreeList.FocusedNode.Values[0];
               IBCQueryBP.Active:=True;
          end;
     end;
end;

end.
