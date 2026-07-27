unit uCreditePromoGoodsDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, DBAccess, IBC, MemDS, dxBar,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, SWNBaseUnit,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmCreditePromoGoodsDlg = class(TSWNBaseFormClass)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton5: TdxBarButton;
    IBCQueryCreditPromoGoods: TIBCQuery;
    IBCDataSourceCreditPromoGoods: TIBCDataSource;
    cxGridGoodsTableGOODSID: TcxGridDBColumn;
    IBCTrUpdate: TIBCTransaction;
    cxGridGoodsTableGOODSNAME: TcxGridDBColumn;
    cxGridGoodsTableDATA1: TcxGridDBColumn;
    cxGridGoodsTableDATA2: TcxGridDBColumn;
    cxGridGoodsTablePREPAY_AMOUNT: TcxGridDBColumn;
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure dxBarButton5Click(Sender: TObject);
  private
    FUID: Integer;
    procedure SetUID(const Value: Integer);
    { Private declarations }
    procedure WhenVerifyGoodsExsists(const GoodsID:Integer; var Exists:Boolean);
    procedure ShowCreditePromoGoodsEditor(fIsNewRecord: Boolean);
  protected
    procedure Prepare; override;
  public
    property UID: Integer read FUID write SetUID;
    { Public declarations }
  end;


implementation

uses
  uCreditePromoGoodsEditorDlg, DataModuleAdditions, SWNUtils;

{$R *.dfm}

procedure TfrmCreditePromoGoodsDlg.bbNewClick(Sender: TObject);
begin
  ShowCreditePromoGoodsEditor(True);
end;

procedure TfrmCreditePromoGoodsDlg.bbEditClick(Sender: TObject);
begin
  ShowCreditePromoGoodsEditor(False);
end;

procedure TfrmCreditePromoGoodsDlg.bbDeleteClick(Sender: TObject);
begin
  if ShowAskDialog('Credite', 'Stergeti inregistrarea ?')=mrYes then
  begin
    IBCQueryCreditPromoGoods.Delete;
  end;
end;

procedure TfrmCreditePromoGoodsDlg.dxBarButton5Click(Sender: TObject);
begin
  ModalResult := mrOK
end;

procedure TfrmCreditePromoGoodsDlg.Prepare;
begin
  IBCTrUpdate.DefaultConnection := fIBCConnection;
  with IBCQueryCreditPromoGoods do
  begin
    Connection := fIBCConnection;
    ParamByName('UID').AsInteger := UID;
    Open;
    if RecordCount=0 then
    begin
      bbEdit.Enabled := False;
      bbDelete.Enabled := False;
    end;
  end;
end;

procedure TfrmCreditePromoGoodsDlg.SetUID(const Value: Integer);
begin
  FUID := Value;
end;

procedure TfrmCreditePromoGoodsDlg.ShowCreditePromoGoodsEditor(fIsNewRecord:
    Boolean);
var
  dialog: TfrmCreditePromoGoodsEditorDlg;
begin
  dialog := TfrmCreditePromoGoodsEditorDlg.Create(self, IBCQueryCreditPromoGoods, IBCDataSourceCreditPromoGoods);
  try
    dialog.OnVerifyGoodsExists := WhenVerifyGoodsExsists;
    dialog.UID := UID;
    dialog.IsNewRecord := fIsNewRecord;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCreditePromoGoodsDlg.WhenVerifyGoodsExsists(const GoodsID: Integer; var Exists: Boolean);
var
  i:integer;
begin
     Exists:=False;
     for i := 0 to cxGridGoodsTable.DataController.RecordCount-1 do
     if (i<>cxGridGoodsTable.DataController.EditingRecordIndex) and (cxGridGoodsTable.DataController.Values[i,cxGridGoodsTableGOODSID.Index]=GoodsID) then
     begin
          Exists:=True;
          Break;
     end;
end;

end.
