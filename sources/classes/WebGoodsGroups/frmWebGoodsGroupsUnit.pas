unit frmWebGoodsGroupsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, DataModuleDB,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxCalendar, MemDS, DBAccess, IBC,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, Vcl.StdCtrls,
  Vcl.ExtCtrls, dxBar, cxClasses, DialogTitle, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type

  TOnAddGoods = procedure(const GroupGoodsID: integer; var Res: boolean) of object;

  TfrmWebGoodsGroupsDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbGroupModify: TdxBarButton;
    bbGroupDelete: TdxBarButton;
    Panel1: TPanel;
    btnCancel: TButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView_GGID: TcxGridDBColumn;
    cxGrid1DBTableView1_TITLE_RO: TcxGridDBColumn;
    cxGrid1DBTableView_Data1: TcxGridDBColumn;
    cxGrid1DBTableView_Data2: TcxGridDBColumn;
    IBCDataSourceGroups: TIBCDataSource;
    IBCQueryGroups: TIBCQuery;
    IBCTrUpdate: TIBCTransaction;
    dxBarButton1: TdxBarButton;
    cxGrid1DBTableView1_TITLE_RU: TcxGridDBColumn;
    cxGrid1DBTableView_CNT: TcxGridDBColumn;
    btnSelect: TButton;
    lbInfo: TLabel;
    dxBarButton2: TdxBarButton;
    procedure bbNewClick(Sender: TObject);
    procedure bbGroupModifyClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbGroupDeleteClick(Sender: TObject);
    procedure cxGrid1DBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dxBarButton2Click(Sender: TObject);
  private
    FOnAddGoods: TOnAddGoods;
    fSelectMode: Boolean;
    procedure SetOnAddGoods(const Value: TOnAddGoods);
    procedure SetSelectMode(const Value: Boolean);
    procedure DisplayBurstAddFailed;
    { Private declarations }
  protected
    procedure Prepare; override;
    procedure BindingDataSource; override;
    procedure ShowGoodsGroupEditorDlg(Value: TNomenclatorRecordState);
    function IsFormDataPosted: boolean; override;
  public
    { Public declarations }
    property SelectMode: Boolean read fSelectMode write SetSelectMode;
  published
    property OnAddGoods: TOnAddGoods read FOnAddGoods write SetOnAddGoods;
  end;

var
  frmWebGoodsGroupsDlg: TfrmWebGoodsGroupsDlg;

implementation

uses
  DataModuleAdditions, frmWebGoodsGroupsEditorUnit, frame40InventarizatiaPereotencaTovaraUnit, frmSortingWebGroupsUnit;

{$R *.dfm}

procedure TfrmWebGoodsGroupsDlg.bbGroupDeleteClick(Sender: TObject);
begin
  if MessageDlg('Stergeti inregistrare ?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    IBCQueryGroups.Delete;
  end;
end;

procedure TfrmWebGoodsGroupsDlg.bbGroupModifyClick(Sender: TObject);
begin
  ShowGoodsGroupEditorDlg(nsEdit);
end;

procedure TfrmWebGoodsGroupsDlg.bbNewClick(Sender: TObject);
begin
  ShowGoodsGroupEditorDlg(nsAppend);
end;

procedure TfrmWebGoodsGroupsDlg.cxGrid1DBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    if (ARecord.Values[cxGrid1DBTableView_Data2.Index] <= Date) then
      AStyle := dmAdditions.cxStyle_TextGray;
end;

procedure TfrmWebGoodsGroupsDlg.dxBarButton1Click(Sender: TObject);
var
   dialog: TfrmSortingWebGroupsDlg;
begin
     dialog := TfrmSortingWebGroupsDlg.Create(self, dmDB.IBCConnection);
     try
         if dialog.ShowModal = mrOk then
            IBCQueryGroups.Refresh;
     finally
         dialog.Free;
     end;
end;

procedure TfrmWebGoodsGroupsDlg.dxBarButton2Click(Sender: TObject);
begin
  inherited;
  IBCQueryGroups.Refresh;
end;

function TfrmWebGoodsGroupsDlg.IsFormDataPosted: boolean;
var
    WasAdded: Boolean;
begin
    Result := false;
    if Assigned(FOnAddGoods) then
    begin
        WasAdded := False;
        if Assigned(fOnAddGoods) then
            FOnAddGoods(IBCQueryGroups.FieldByName('GGID').AsInteger, WasAdded);
            if not WasAdded then
                DisplayBurstAddFailed
            else
                Result := True;
    end;
end;

procedure TfrmWebGoodsGroupsDlg.BindingDataSource;
begin
//  cxGrid1.SetFocus;
end;

procedure TfrmWebGoodsGroupsDlg.Prepare;
begin
    lbInfo.Caption := '';
  IBCQueryGroups.Open;
end;

procedure TfrmWebGoodsGroupsDlg.SetSelectMode(const Value: Boolean);
begin
  fSelectMode := Value;
  btnSelect.Visible := fSelectMode;
   if not fSelectMode then
   begin
     btnCancel.Caption := 'Inchide';
     btnCancel.ModalResult := mrClose;
   end
   else
   begin
     btnCancel.Caption := 'Renunta';
     btnCancel.ModalResult := mrCancel;
   end;
end;

procedure TfrmWebGoodsGroupsDlg.ShowGoodsGroupEditorDlg(Value:
    TNomenclatorRecordState);
var
  dialog: TfrmWebGoodsGroupsEditorDlg;
begin
  dialog:= TfrmWebGoodsGroupsEditorDlg.Create(Self, IBCQueryGroups, IBCDataSourceGroups);
  try
    dialog.OperationType := Value;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebGoodsGroupsDlg.DisplayBurstAddFailed;
begin
    lbInfo.Visible := True;
    lbInfo.Caption := 'Produsul nu e adaugat!';
    lbInfo.font.Color := clRed;
end;

procedure TfrmWebGoodsGroupsDlg.SetOnAddGoods(const Value: TOnAddGoods);
begin
    FOnAddGoods := Value;
end;


end.
