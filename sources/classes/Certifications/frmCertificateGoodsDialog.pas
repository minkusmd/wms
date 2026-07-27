unit frmCertificateGoodsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  DB, cxDBData, IBC, MemDS, dxBar, StdCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridDBTableView, cxGrid, cxDBEdit, ExtCtrls, DialogTitle,

  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Vcl.Menus, DBAccess, cxClasses,
  cxGridTableView, cxGridCustomView, cxTextEdit;

type

  TfrmCertificateGoodsDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    edDENUMIREA: TcxDBTextEdit;
    lbCertfCount: TLabel;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    pmPopupMenu: TdxBarPopupMenu;
    dxBarManagerBar1: TdxBar;
    bbAddGoods: TdxBarButton;
    bbRemoveGoods: TdxBarButton;
    cxGridGoods_GOODSID: TcxGridDBColumn;
    cxGridGoods_TITLE: TcxGridDBColumn;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    bbReplace: TdxBarButton;
    Bevel1: TBevel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbReplaceClick(Sender: TObject);
    procedure cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure bbRemoveGoodsClick(Sender: TObject);
  private
    { Private declarations }
    fNoDeleteAsk:Boolean;
    fSecurity_CanModify:Boolean;
    procedure SelectionChanged;
    procedure ShowAddGoodsDialog;
    procedure ShowReplaceGoodsDialog;
    procedure WhenGoodsAddBurst(const GoodsID:integer; const GoodsTitle:String; var Added:Boolean; var Count:integer);
    procedure RemoveSelectedGoods;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;

    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

    procedure SetupSecurityItems;override;
  public
    { Public declarations }
  end;


implementation

uses frmGoods, SWNUtils, SWNSecurityFlags, SWNDBErrors;

{$R *.dfm}

{ TfrmGoodsCertificatesDlg }

procedure TfrmCertificateGoodsDlg.bbAddGoodsClick(Sender: TObject);
begin
     ShowAddGoodsDialog;
end;

procedure TfrmCertificateGoodsDlg.bbRemoveGoodsClick(Sender: TObject);
begin
     RemoveSelectedGoods;
end;

procedure TfrmCertificateGoodsDlg.bbReplaceClick(Sender: TObject);
begin
     ShowReplaceGoodsDialog;
end;

procedure TfrmCertificateGoodsDlg.cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if bbReplace.Enabled then
     begin
          ShowReplaceGoodsDialog;
          AHandled:=True;
     end;
end;

procedure TfrmCertificateGoodsDlg.cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmCertificateGoodsDlg.BindingDataSource;
begin
     inherited;
     fSecurity_CanModify:=True;
     IBCQueryGoods.Connection:=fMasterDataSet.Connection;
     IBCQueryGoods.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryGoods.MasterSource:=fMasterDataSource;
     edDENUMIREA.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmCertificateGoodsDlg.IsFormDataPosted: Boolean;
begin
     fMasterDataSet.UpdateTransaction.Commit;
     ModalResult:=mrOK;
     Result:=True;
end;

procedure TfrmCertificateGoodsDlg.Prepare;
begin
     SetupSecurityItems;

     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        IBCQueryGoods.Active:=True;
        SelectionChanged;
     except on E:Exception do
        begin
             fMasterDataSet.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmCertificateGoodsDlg.RemoveSelectedGoods;
var S:String;
begin
     S:=IBCQueryGoods.FieldByName('GOODS_TITLE').asWideString;
     if fNoDeleteAsk or (ShowAskDialogVerification('Sterge produs','Produs'+#13#10+S,'Nu mai intreba','',fNoDeleteAsk)=mrYes) then
     begin
          IBCQueryGoods.Delete;
     end;
end;

procedure TfrmCertificateGoodsDlg.SelectionChanged;
var f1,f2,f3:Boolean;
begin
     f1:=fSecurity_CanModify;  // Add
     f2:=False; // Replace
     f3:=False; // Remove
     if cxGridGoodsTable.DataController.RecNo>0 then
     begin
          f2:=fSecurity_CanModify; // Replace + Security
          f3:=fSecurity_CanModify; // Remove + Security
     end;
     bbAddGoods.Enabled:=f1;
     bbReplace.Enabled:=f2;
     bbRemoveGoods.Enabled:=f3;
end;

procedure TfrmCertificateGoodsDlg.SetupSecurityItems;
begin
     if Not SecurityFlagEnabled(cSecurityFlag_Справочники_Сертификаты_Изменить_сертифицированные_товары) then
     begin
          fSecurity_CanModify:=False;
          dxBarManagerBar1.Visible:=False;
          dxBarDockControl1.Visible:=False;
          btnOk.Visible:=False;
          btnCancel.Caption:='Inchide';
     end;
end;

procedure TfrmCertificateGoodsDlg.ShowAddGoodsDialog;
var goods:TfrmGoodsBrowser;
    Added:Boolean;
    N:integer;
begin
     goods:=TfrmGoodsBrowser.Create(Self);
     try
        goods.SelectMode:=True;
        goods.BurstMode:=True;
        goods.OnBurstAddGoods:=WhenGoodsAddBurst;
        goods.SetCompactMode;
        goods.Title:='Adauga produse pentru certificat';

        if goods.ShowModal=mrOk then WhenGoodsAddBurst(goods.GoodsID,goods.GoodsTitle,Added,N);
     finally
        goods.Free;
     end;
end;

procedure TfrmCertificateGoodsDlg.ShowReplaceGoodsDialog;
var goods:TfrmGoodsBrowser;
begin
     goods:=TfrmGoodsBrowser.Create(Self);
     try
        goods.SelectMode:=True;
        goods.SetCompactMode;
        goods.Title:='Modificarea produselor in certificat';
        goods.GoodsID:=IBCQueryGoods.FieldByName('GOODSID').AsInteger;

        if goods.ShowModal=mrOk then
        try
           IBCQueryGoods.Edit;
           IBCQueryGoods.FieldByName('GOODSID').AsInteger:=goods.GoodsID;
           IBCQueryGoods.Post;
        except on E:Exception do
           begin
                IBCQueryGoods.Cancel;
                ShowErrorDialog('Eroare la modificare','NU este posibil de modificat produsul'+#13#10+goods.GoodsTitle,E.Message);
           end;
        end;
     finally
        goods.Free;
     end;
end;

procedure TfrmCertificateGoodsDlg.WhenCancelForm;
begin
     fMasterDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmCertificateGoodsDlg.WhenGoodsAddBurst(const GoodsID: integer; const GoodsTitle: String; var Added:Boolean; var Count:integer);
begin
     try
        IBCQueryGoods.Append;
        IBCQueryGoods.FieldByName('GOODSID').AsInteger:=GoodsID;
        IBCQueryGoods.Post;
        Count:=1;
        Added:=True;
     except on E:Exception do
        begin
             IBCQueryGoods.Cancel;
             Added:=False;
             ShowErrorDialog('Eroare la adaugare','Nu este posibil de adaugat produsul'+#13#10+GoodsTitle,E.Message);
        end;
     end;
end;

end.

