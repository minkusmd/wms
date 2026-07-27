unit uPromoGoodsByDayDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxClasses, dxBar, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DialogTitle, DBAccess, IBC,
  MemDS, dxBarExtItems, cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TVerifyGoodsExistsProc = function(const GoodsID: integer): Boolean of object;

  TfrmPromoGoodsByDayDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    dxBarSubItem1: TdxBarSubItem;
    bbClose: TdxBarButton;
    bbNewGoods: TdxBarButton;
    dxBarButton3: TdxBarButton;
    IBCQueryPGBD: TIBCQuery;
    IBCDataSourcePGBD: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGrid2DBTableView1UID: TcxGridDBColumn;
    cxGrid2DBTableView1DATA: TcxGridDBColumn;
    cxGrid2DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid2DBTableView1WEBGOODSTYPE_NAME: TcxGridDBColumn;
    cxGrid2DBTableView1GOODSNAME: TcxGridDBColumn;
    dxBarDateCombo1: TdxBarDateCombo;
    procedure bbCloseClick(Sender: TObject);
    procedure bbNewGoodsClick(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
  private
    FOnVerifyGoodsExists: TVerifyGoodsExistsProc;
    procedure SetOnVerifyGoodsExists(const Value: TVerifyGoodsExistsProc);
    { Private declarations }
  protected
    function WhenVerifyGoodsExsists(const GoodsID: Integer): boolean;
    function IsFormDataPosted: boolean; override;
    procedure Prepare; override;
  public
    { Public declarations }
    procedure CheckIfGoodsExists(const GoodsID: integer);
    property OnVerifyGoodsExists: TVerifyGoodsExistsProc read FOnVerifyGoodsExists write
      SetOnVerifyGoodsExists;
  end;

var
  frmPromoGoodsByDayDlg: TfrmPromoGoodsByDayDlg;

implementation

uses
  DataModuleAdditions, frmGoods, SWNValueStorageUnit, SWNUtils;

{$R *.dfm}

procedure TfrmPromoGoodsByDayDlg.bbCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmPromoGoodsByDayDlg.CheckIfGoodsExists(const GoodsID: integer);
var
  Exists: Boolean;
begin
  Exists := False;
  try
    if Assigned(FOnVerifyGoodsExists) then
      Exists := FOnVerifyGoodsExists(GoodsID);
  finally
  end;
end;

procedure TfrmPromoGoodsByDayDlg.dxBarButton3Click(Sender: TObject);
begin
  if ShowAskDialog('Produse promo', 'Stergeti inregistrarea?') = mrYes then
    IBCQueryPGBD.Delete;
end;

procedure TfrmPromoGoodsByDayDlg.bbNewGoodsClick(Sender: TObject);
var
  dialog: TfrmGoodsBrowser;
  N: integer;
begin
  dialog := TfrmGoodsBrowser.Create(Parent);
  try
    N := AppUserTempConfigStorage.IntValues.GetValue(Owner.Name + '_LastSelectedGoodsID', -1);
    if not IBCQueryPGBD.FieldByName('GOODSID').IsNull then
      N := IBCQueryPGBD.FieldByName('GOODSID').AsInteger;

    if dialog.SelectGoods(N, False) then
    begin
      with IBCQueryPGBD do
      begin
        Append;
        try
          FieldByName('DATA').AsDateTime := dxBarDateCombo1.Date;
          FieldByName('GOODSID').AsInteger := dialog.GoodsID;
          FieldByName('GOODSNAME').AsString := dialog.GoodsTitle;
          Post;
          Refresh;
        except
          on e: Exception do
          begin
            Cancel;
            raise;
          end;
        end;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

function TfrmPromoGoodsByDayDlg.IsFormDataPosted: boolean;
begin
  AppUserTempConfigStorage.IntValues.SetValue(Owner.Name + '_LastSelectedGoodsID', IBCQueryPGBD.FieldByName
    ('GOODSID').asInteger);
end;

procedure TfrmPromoGoodsByDayDlg.Prepare;
begin
  IBCQueryPGBD.Connection := fIBCConnection;
  IBCQueryPGBD.UpdateTransaction := IBCTrUpdate;
  IBCtrUpdate.DefaultConnection := fIBCConnection;
  IBCQueryPGBD.Open;
  dxBarDateCombo1.Date := Date;
end;

procedure TfrmPromoGoodsByDayDlg.SetOnVerifyGoodsExists(const Value: TVerifyGoodsExistsProc);
begin
  FOnVerifyGoodsExists := Value;
end;

function TfrmPromoGoodsByDayDlg.WhenVerifyGoodsExsists(const GoodsID: Integer): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to cxGrid2DBTableView1.DataController.RecordCount - 1 do
    if (i <> cxGrid2DBTableView1.DataController.EditingRecordIndex) and (cxGrid2DBTableView1.DataController.Values
      [i, cxGrid2DBTableView1GOODSID.Index] = GoodsID) then
    begin
      Result := True;
      Break;
    end;
end;

end.

