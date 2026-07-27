unit frmWebGoodsGroupsEditorUnit;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, DialogTitle,
   cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, cxContainer, cxEdit,
   cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
   cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridCustomTableView,
   cxGridTableView, cxGridDBTableView, dxBar, cxClasses, cxGridLevel, cxGridCustomView, cxGrid, cxDBEdit,
   cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxPC, DBAccess, IBC, MemDS, DataModuleDB, dxDateRanges,
   cxCheckBox, Vcl.ExtCtrls, dxScrollbarAnnotations, System.UITypes, dxUIAClasses, cxCheckGroup, cxDBCheckGroup,
  cxGroupBox, cxRadioGroup;

type
   TfrmWebGoodsGroupsEditorDlg = class(TSWNMasteredFormClass)
      DialogTitle1: TDialogTitle;
      Button1: TButton;
      Button2: TButton;
      cxPageControl1: TcxPageControl;
      tsGroupInfo: TcxTabSheet;
      Label1: TLabel;
      deStart: TcxDBDateEdit;
      deEnd: TcxDBDateEdit;
      teTITLE_RO: TcxDBTextEdit;
      teTITLE_RU: TcxDBTextEdit;
      Label2: TLabel;
      Label3: TLabel;
      dxBarManager1: TdxBarManager;
      dxBarManager1Bar1: TdxBar;
      bbGoodsNew: TdxBarButton;
      bbGoodsDelete: TdxBarButton;
      IBCQueryGroupGoods: TIBCQuery;
      IBCDataSourceGroupGoods: TIBCDataSource;
      IBCTransaction1: TIBCTransaction;
      dxBarButton1: TdxBarButton;
      Panel1: TPanel;
      dxBarDockControl2: TdxBarDockControl;
      cxGrid1: TcxGrid;
      cxGrid1DBTableView1: TcxGridDBTableView;
      cxGrid1DBTableView1_GOODSID: TcxGridDBColumn;
      cxGrid1DBTableView1_GOODS_NAME: TcxGridDBColumn;
      cxGrid1DBTableView1_PRICE4: TcxGridDBColumn;
      cxGrid1DBTableView_FLG_FORCED: TcxGridDBColumn;
      cxGrid1Level1: TcxGridLevel;
    dxBarButton2: TdxBarButton;
    bbEdit: TdxBarButton;
    dxBarButton3: TdxBarButton;
    Label4: TLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    Label5: TLabel;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBRadioGroup1: TcxDBRadioGroup;
    cxDBCheckGroup1: TcxDBCheckGroup;
      procedure bbGoodsNewClick(Sender: TObject);
      procedure bbGoodsDeleteClick(Sender: TObject);
      procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure cxGrid1DBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
         TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
      procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
   private
    { Private declarations }
      FOperationType: TNomenclatorRecordState;
      LastGoodsID: Integer;
      procedure AddGoodsToGGEditor(OperationType: TNomenclatorRecordState);
      procedure SetOperationType(const Value: TNomenclatorRecordState);
      function WhenCheckGoodsExists(const GoodsID: Integer): Boolean;
   protected
      procedure Prepare; override;
      procedure BindingDataSource; override;
      function IsFormDataPosted: Boolean; override;
      procedure WhenCancelForm; override;
      procedure WhenGoodsAddBurst(const GoodsID: Integer; const GoodsTitle: string; var Added: Boolean; var
         Count: Integer);
      function CheckGridForGoodsIDValue(const Grid: TcxGridDBTableView; var GoodsID: Integer): Boolean;
   public
      property OperationType: TNomenclatorRecordState read FOperationType write SetOperationType;
    { Public declarations }
   end;

var
   frmWebGoodsGroupsEditorDlg: TfrmWebGoodsGroupsEditorDlg;

implementation

uses
   DataModuleAdditions, frmGoods, SWNValueStorageUnit, SWNMessageDialog, SWNCommonDialogs, SWNUtils, frmWebPromoActiuniDialog,
  frmSortingWebGroupsGoodsUnit;

{$R *.dfm}

procedure TfrmWebGoodsGroupsEditorDlg.WhenGoodsAddBurst(const GoodsID: Integer; const GoodsTitle: string; var
   Added: Boolean; var Count: Integer);
begin
   try
      IBCQueryGroupGoods.Append;
      IBCQueryGroupGoods.FieldByName('GGID').AsInteger := fMasterDataSet.FieldByName('GGID').AsInteger;
      IBCQueryGroupGoods.FieldByName('GOODSID').AsInteger := GoodsID;
      IBCQueryGroupGoods.FieldByName('GOODSNAME').AsString := GoodsTitle;
      IBCQueryGroupGoods.Post;
      Count := 1;
      Added := True;
   except
      on E: Exception do
      begin
         IBCQueryGroupGoods.Cancel;
         Added := False;
         ShowErrorDialog('Eroare la adaugare', 'Nu este posibil de adaugat produsul' + #13#10 + GoodsTitle, E.Message);
      end;
   end;
end;

procedure TfrmWebGoodsGroupsEditorDlg.AddGoodsToGGEditor(OperationType: TNomenclatorRecordState);
var
   dialog: TfrmGoodsBrowser;
begin
   dialog := TfrmGoodsBrowser.Create(Self);
   try
      dialog.OnCheckIfGoodsExists := WhenCheckGoodsExists;
      LastGoodsID := AppUserTempConfigStorage.IntValues.GetValue(Owner.Name + '_LastSelectedGoodsID', -1);
      if not IBCQueryGroupGoods.FieldByName('GOODSID').IsNull then
         LastGoodsID := IBCQueryGroupGoods.FieldByName('GOODSID').AsInteger;

      dialog.OnBurstAddGoods := WhenGoodsAddBurst;
      dialog.BurstMode := True;

      if dialog.SelectGoods(LastGoodsID, False) then
      begin
         with IBCQueryGroupGoods do
         begin
            if OperationType = nsAppend then
            begin
               Append;

            end
            else if OperationType = nsEdit then
            begin
               Edit;
            end;

            FieldByName('GGID').AsInteger := fMasterDataSet.FieldByName('GGID').AsInteger;
            FieldByName('GOODSID').AsInteger := dialog.GoodsID;
            FieldByName('GOODSNAME').AsString := dialog.GoodsTitle;

              // poate un try de pus. vedem pe parcurs!!!
              // 14.12.2018
            Post;
            AppUserTempConfigStorage.IntValues.SetValue(Owner.Name + '_LastSelectedGoodsID', dialog.GoodsID);
         end;
      end;
   finally          // nu era nimic in acest block, se pare ca era leadmemory!
      dialog.free;
   end;
end;

{ TForm2 }

procedure TfrmWebGoodsGroupsEditorDlg.WhenCancelForm;
begin
   if (IBCQueryGroupGoods.State in dsEditModes) then
      IBCQueryGroupGoods.Cancel;

   if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;

end;

function TfrmWebGoodsGroupsEditorDlg.WhenCheckGoodsExists(const GoodsID: Integer): Boolean;
var
   i: Integer;
begin
   Result := False;
   for i := 0 to cxGrid1DBTableView1.DataController.RecordCount - 1 do
      if (i <> cxGrid1DBTableView1.DataController.EditingRecordIndex) and (cxGrid1DBTableView1.DataController.Values
         [i, cxGrid1DBTableView1_GOODSID.Index] = GoodsID) then
      begin
         Result := True;
         Break;
      end;
end;

procedure TfrmWebGoodsGroupsEditorDlg.bbGoodsNewClick(Sender: TObject);
begin
   AddGoodsToGGEditor(nsAppend);
end;

procedure TfrmWebGoodsGroupsEditorDlg.cxGrid1DBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView;
   ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
   if TcxGridDBTableView(Sender).DataController.RecNo > 0 then
      if ARecord.Values[cxGrid1DBTableView_FLG_FORCED.Index] = 0 then
         AStyle := dmAdditions.cxStyle_TextGrayStrike;
end;

procedure TfrmWebGoodsGroupsEditorDlg.dxBarButton1Click(Sender: TObject);
begin
   if MessageDlg('Doriti sa stergeti toate inregistrarile inactive ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
      IBCQueryGroupGoods.DisableControls;
      IBCQueryGroupGoods.First;
      while not IBCQueryGroupGoods.Eof do
      begin
         if IBCQueryGroupGoods.FieldByName('FLG_FORCED').AsInteger = 0 then
            IBCQueryGroupGoods.Delete
         else
            IBCQueryGroupGoods.Next;
      end;
      IBCQueryGroupGoods.EnableControls;
   end;
end;

procedure TfrmWebGoodsGroupsEditorDlg.dxBarButton2Click(Sender: TObject);
var
   dialog: TfrmWebPromoActiuniDlg;
   query: TIBCQuery;
begin
   dialog := TfrmWebPromoActiuniDlg.Create(Self);

   query := TIBCQuery.Create(self);
   try
      dialog.FirmaID := dmdb.FirmaInfo.FirmaID;
      if dialog.SelectPromotion then
      begin
        query.Transaction := ibctransaction1;
        if not query.Transaction.Active then
            query.Transaction.StartTransaction;
        query.SQL.Text := 'EXECUTE PROCEDURE SP_IMPORT_FROM_PROMOTION(:GGID, :PROMOID)';
        query.ParamByName('GGID').AsInteger := fMasterDataSet.FieldByName('GGID').AsInteger;
        query.ParamByName('PROMOID').AsInteger := dialog.PromoID;
        try
        query.ExecSQL;
        if query.Transaction.Active then
          query.Transaction.Commit;
        except on E: Exception do begin
          query.Transaction.Rollback;
          raise;
        end;
        end;
        IBCQueryGroupGoods.Refresh;
      end;
   finally
      dialog.Free;
      query.Free;
   end;
end;

procedure TfrmWebGoodsGroupsEditorDlg.dxBarButton3Click(Sender: TObject);
var
   dialog: TfrmSortingWebGroupsGoodsDlg;
begin
     dialog := TfrmSortingWebGroupsGoodsDlg.Create(self, dmDB.IBCConnection);
     try
         dialog.GGID := IBCQueryGroupGoods.FieldByName('GGID').AsInteger;
         if dialog.ShowModal = mrOk then
            IBCQueryGroupGoods.Refresh;
     finally
         dialog.Free;
     end;
end;

procedure TfrmWebGoodsGroupsEditorDlg.bbEditClick(Sender: TObject);
begin
  AddGoodsToGGEditor(nsEdit);
end;

procedure TfrmWebGoodsGroupsEditorDlg.bbGoodsDeleteClick(Sender: TObject);
begin
   if ShowAskDialog('Produse in grupe...', 'Doriti sa stergeti inregistrarea ?') = mrYes then
      IBCQueryGroupGoods.Delete;
end;

function TfrmWebGoodsGroupsEditorDlg.CheckGridForGoodsIDValue(const Grid: TcxGridDBTableView; var GoodsID:
   Integer): Boolean;
var
   i: Integer;
   col: TcxGridDBColumn;
begin
   GoodsID := -1;
   Result := False;

   for i := 0 to Grid.ColumnCount - 1 do
   begin
      col := Grid.Columns[i];
      if (col.DataBinding.FieldName = 'GOODSID') and VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex,
         col.Index]) then
      begin
         GoodsID := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index];
         Result := True;
         Break;
      end;
   end;
end;

procedure TfrmWebGoodsGroupsEditorDlg.cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   dialog: TfrmGoodsBrowser;
   GoodsID: Integer;
begin
   if (Key = 84) and (Shift = [ssCtrl, ssShift]) then
   begin
      if CheckGridForGoodsIDValue(cxGrid1DBTableView1, GoodsID) then
      begin
         dialog := TfrmGoodsBrowser.Create(Self);
         try
            dialog.GoodsID := GoodsID;
            dialog.ShowModal;
         finally
            dialog.Free;
         end;
      end;
   end
end;

procedure TfrmWebGoodsGroupsEditorDlg.BindingDataSource;
begin
   deStart.DataBinding.DataSource := fMasterDataSource;
   deEnd.DataBinding.DataSource := fMasterDataSource;
   teTITLE_RO.DataBinding.DataSource := fMasterDataSource;
   teTITLE_RU.DataBinding.DataSource := fMasterDataSource;

   deStart.Date := Date;
   deEnd.Date := Date;
   cxPageControl1.ActivePageIndex := 0;
end;

function TfrmWebGoodsGroupsEditorDlg.IsFormDataPosted: Boolean;
begin
   try
      if (IBCQueryGroupGoods.State in dsEditModes) then
         IBCQueryGroupGoods.Post;

      if fMasterDataSet.State in dsEditModes then
         fMasterDataSet.Post;

      Result := True;
   except
      IBCQueryGroupGoods.Cancel;
      fMasterDataSet.Cancel;

      raise;
   end;
end;

procedure TfrmWebGoodsGroupsEditorDlg.Prepare;
begin
   IBCQueryGroupGoods.MasterSource := MasterDataSource;
   IBCQueryGroupGoods.DetailFields := 'GGID';
   IBCQueryGroupGoods.MasterFields := 'GGID';
//   IBCQueryGroupGoods.ParamByName('GGID').AsInteger := fMasterDataSet.FieldByName('GGID').AsInteger;
   IBCQueryGroupGoods.Open;

   if OperationType = nsAppend then
   begin
      fMasterDataSet.Append;
   end;
   if OperationType = nsEdit then
   begin
      fMasterDataSet.Edit;
   end;
end;

procedure TfrmWebGoodsGroupsEditorDlg.SetOperationType(const Value: TNomenclatorRecordState);
begin
   FOperationType := Value;
end;

end.

