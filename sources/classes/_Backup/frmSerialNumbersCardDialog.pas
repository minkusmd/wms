unit frmSerialNumbersCardDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxImageComboBox, cxLabel, Menus, cxLookAndFeelPainters, dxBar, DBAccess, IBC, MemDS,
  cxClasses, StdCtrls, cxButtons, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxControls, cxGridCustomView,
  cxGrid, cxContainer, cxTextEdit, ExtCtrls, DialogTitle, cxLookAndFeels;

type
  TfrmSerialNumbersCardDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbModifySerial: TdxBarButton;
    bbRemoveSerial: TdxBarButton;
    dxBarButton3: TdxBarButton;
    cxGridSerialsTable: TcxGridDBTableView;
    cxGridSerialsLevel: TcxGridLevel;
    cxGridSerials: TcxGrid;
    cxGridSerialsTable_SN: TcxGridDBColumn;
    cxGridSerialsTable_PRICECOLUMN: TcxGridDBColumn;
    cxGridSerialsTable_SERVICEDISCOUNT: TcxGridDBColumn;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    IBCQuerySNCard: TIBCQuery;
    IBCDataSourceSNCard: TIBCDataSource;
    cxGridSerialsTable_IMG: TcxGridDBColumn;
    pnGoods: TPanel;
    edGoodsName: TcxTextEdit;
    edGoodsID: TcxTextEdit;
    cxLabel1: TcxLabel;
    bbGenerateSerials: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarDelPopupMenu: TdxBarPopupMenu;
    bbNewSerial: TdxBarButton;
    bbRemoveAllSerials: TdxBarButton;
    cxLabel2: TLabel;
    edQTY: TcxTextEdit;
    lbInfo: TLabel;
    procedure bbNewSerialClick(Sender: TObject);
    procedure bbModifySerialClick(Sender: TObject);
    procedure bbRemoveSerialClick(Sender: TObject);
    procedure cxGridSerialsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure bbScannerClick(Sender: TObject);
    procedure bbCopyClick(Sender: TObject);
    procedure cxGridSerialsTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure cxGridSerialsTable_SERVICEDISCOUNTGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbRemoveAllSerialsClick(Sender: TObject);
  private
    { Private declarations }
    fParentGoodsID:integer;
    fGoodsID:integer;
    fGoodsQuantity:integer;
    fComplectSN:String;
    FReadOnly: Boolean;
    procedure ShowAddNewSerialDialog;
    procedure ShowModifySerialDialog;
    procedure ShowRemoveSerialDialog;
    procedure ShowInputFromScannerDialog;
    procedure DeleteAllSerials;

    procedure SelectionChanged;

    procedure DisplayGoodsInfo;
    procedure ShowInfoForUser;

    function AddNewRecord(const SerialNumber:String; const PriceColumn,ServiceDiscount:integer; var ErrorStr:String):Boolean;
    procedure WhenAddSerialFromScanner(const SerialNumber:String; const Param1,Param2, CountryID, VendorID :integer; var Added:Boolean);
    procedure WhenBeginToAddSerials(Sender:TObject);
    procedure WhenEndToAddSerials(Sender:TObject);

    procedure SetReadOnly(const Value: Boolean);
  protected
    { Protected declarations }
    procedure InitValues;override;
    procedure Prepare;override;

    procedure LoadStates;override;
    procedure SaveStates;override;
  public
    { Public declarations }
    property ReadOnly:Boolean read FReadOnly write SetReadOnly;
  end;


implementation

uses DataModuleAdditions, ClipBrd, frmSerialNumberCardEditorDialog, frmSerialScannerDialog,
     SWNUtils, cxGridExportLink, SWNValueStorageUnit, SWNConst, SWNDBErrors;

{$R *.dfm}

{ TfrmSerialNumbersDlg }

function TfrmSerialNumbersCardDlg.AddNewRecord(const SerialNumber: String; const PriceColumn,ServiceDiscount:integer; var ErrorStr: String): Boolean;
begin
     Result:=False;
     IBCQuerySNCard.Append;
     try
        IBCQuerySNCard.FieldByName('SN').AsString:=SerialNumber;
        IBCQuerySNCard.FieldByName('COMPLECT_SN').AsString:=fComplectSN;
        IBCQuerySNCard.FieldByName('CREATED_BY').AsInteger:=UserID;
        IBCQuerySNCard.FieldByName('PRICECOLUMN').AsInteger:=PriceColumn;
        IBCQuerySNCard.FieldByName('SERVICEDISCOUNT').AsInteger:=ServiceDiscount;
        IBCQuerySNCard.Post;
        Result:=True;
     except on E:Exception do
        begin
             IBCQuerySNCard.Cancel;
             ErrorStr:=E.Message;
        end;
     end;
end;

procedure TfrmSerialNumbersCardDlg.bbCopyClick(Sender: TObject);
begin
     ClipBoard.AsText:=IBCQuerySNCard.FieldByName('SN').AsString;
end;

procedure TfrmSerialNumbersCardDlg.bbModifySerialClick(Sender: TObject);
begin
     ShowModifySerialDialog;
end;

procedure TfrmSerialNumbersCardDlg.bbNewSerialClick(Sender: TObject);
begin
     ShowAddNewSerialDialog;
end;

procedure TfrmSerialNumbersCardDlg.bbRemoveAllSerialsClick(Sender: TObject);
begin
     DeleteAllSerials;
end;

procedure TfrmSerialNumbersCardDlg.bbRemoveSerialClick(Sender: TObject);
begin
     ShowRemoveSerialDialog;
end;

procedure TfrmSerialNumbersCardDlg.bbScannerClick(Sender: TObject);
begin
     ShowInputFromScannerDialog;
end;

procedure TfrmSerialNumbersCardDlg.btnOkClick(Sender: TObject);
begin
     fMasterDataSet.UpdateTransaction.Commit;
     ModalResult:=mrOk;
end;

procedure TfrmSerialNumbersCardDlg.cxGridSerialsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if bbModifySerial.Enabled then
     begin
          ShowModifySerialDialog;
          AHandled:=True;
     end;
end;

procedure TfrmSerialNumbersCardDlg.cxGridSerialsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmSerialNumbersCardDlg.cxGridSerialsTable_SERVICEDISCOUNTGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     AText:=AText+'%';
end;

procedure TfrmSerialNumbersCardDlg.DeleteAllSerials;
begin
     if ShowAskDialog('Удаление всех серийных номеров','Удалить все серийные номера?')=mrYes then
     begin
          IBCQuerySNCard.DisableControls;
          try
             try
                IBCQuerySNCard.First;
                while Not IBCQuerySNCard.Eof do IBCQuerySNCard.Delete;
             except on E:Exception do
                begin
                   if Not ProcessSWNError(E) then raise;
                end;
             end;
          finally
             IBCQuerySNCard.EnableControls;
             ShowInfoForUser;
          end;
     end;
end;

procedure TfrmSerialNumbersCardDlg.DisplayGoodsInfo;
begin
     edGoodsID.Text:=IntToStr(fMasterDataSet.FieldByName('GOODSID').AsInteger);
     edGoodsName.Text:=fMasterDataSet.FieldByName('GOODS_NAME').AsString;
     fGoodsQuantity:=fMasterDataSet.FieldByName('QTY').AsInteger;
     edQTY.Text:=IntToStr(fGoodsQuantity);
end;

procedure TfrmSerialNumbersCardDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if ModalResult<>mrOk then fMasterDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmSerialNumbersCardDlg.InitValues;
begin
     inherited;

     fParentGoodsID:=-1;
     fGoodsID:=-1;
     fComplectSN:='';
     fGoodsQuantity:=0;

     IBCQuerySNCard.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQuerySNCard.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
     IBCQuerySNCard.MasterSource:=fMasterDataSource;
end;

procedure TfrmSerialNumbersCardDlg.LoadStates;
begin
     AppUserConfigStorage.FormPositions.ReadFormPos(Self);
end;

procedure TfrmSerialNumbersCardDlg.Prepare;
begin
     if FReadOnly then
     begin
          dtDialogTitle.Color:=cCOLOR_DocReadOnly;
          dtDialogTitle.Text:='Просмотр серийных номеров товара';
          btnOk.Visible:=False;
          btnCancel.Default:=True;
          btnCancel.Caption:='Закрыть';

          IBCQuerySNCard.ReadOnly:=True;
          IBCQuerySNCard.UpdateTransaction:=nil;

          IBCQuerySNCard.Transaction:=fMasterDataSet.Transaction;
     end;

     pnClient.AutoSize:=True;
     SelectionChanged;

     DisplayGoodsInfo;

     try
        if Not FReadOnly then fMasterDataSet.UpdateTransaction.StartTransaction;

        IBCQuerySNCard.Active:=True;
        ShowInfoForUser;
     except
        IBCQuerySNCard.Close;
        if Not FReadOnly then
        begin
             if fMasterDataSet.UpdateTransaction.Active then fMasterDataSet.UpdateTransaction.Rollback;
        end;
        raise;
     end;
end;

procedure TfrmSerialNumbersCardDlg.SaveStates;
begin
     AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

procedure TfrmSerialNumbersCardDlg.SelectionChanged;
var f1,f3,f4,f5:Boolean;
begin
     f1:=Not FReadOnly; // New + Security
     f3:=False;
     f4:=False;
     f5:=Not FReadOnly;
     if (not FReadOnly) and (cxGridSerialsTable.DataController.RecNo>0) then
     begin
          f3:=True; // Modify + Security
          f4:=True; // Delete + Security
     end;
     bbNewSerial.Enabled:=f1;
     bbModifySerial.Enabled:=f3;
     bbRemoveSerial.Enabled:=f4;
     bbGenerateSerials.Enabled:=f5;
end;

procedure TfrmSerialNumbersCardDlg.SetReadOnly(const Value: Boolean);
begin
     FReadOnly := Value;
end;

procedure TfrmSerialNumbersCardDlg.ShowAddNewSerialDialog;
var dialog:TfrmSerialNumberCardEditorDlg;
begin
     dialog:=TfrmSerialNumberCardEditorDlg.Create(Self,IBCQuerySNCard,IBCDataSourceSNCard);
     try
        dialog.CreateNewSerial:=True;

        if dialog.ShowModal=mrOk then
        begin
             ShowInfoForUser;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmSerialNumbersCardDlg.ShowInfoForUser;
var N:integer;
begin
     N:=cxGridSerialsTable.DataController.RecordCount;

     if N=fGoodsQuantity then
     begin
          lbInfo.Caption:=cMSG_SN_CountIsOk;
          lbInfo.Color:=cCOLOR_PARTNO_CountIsOk;
     end
     else
     if N<fGoodsQuantity then
     begin
          lbInfo.Caption:=cMSG_SN_CountIsLess;
          lbInfo.Color:=cCOLOR_PARTNO_CountIsLess;
     end
     else
     begin
          lbInfo.Caption:=cMSG_SN_CountIsBigger;
          lbInfo.Color:=cCOLOR_PARTNO_CountIsBigger;
     end;
end;

procedure TfrmSerialNumbersCardDlg.ShowInputFromScannerDialog;
var dialog:TfrmSerialScannerDlg;
begin
     dialog:=TfrmSerialScannerDlg.Create(Self);
     try
        dialog.RequiredCount:=fGoodsQuantity;
        dialog.OnBeginToAddSearials:=WhenBeginToAddSerials;
        dialog.OnAddSerialNumber:=WhenAddSerialFromScanner;
        dialog.OnEndToAddSearials:=WhenEndToAddSerials;

        if dialog.ShowModal=mrOk then
        begin
             ShowInfoForUser;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmSerialNumbersCardDlg.ShowModifySerialDialog;
var dialog:TfrmSerialNumberCardEditorDlg;
begin
     dialog:=TfrmSerialNumberCardEditorDlg.Create(Self,IBCQuerySNCard,IBCDataSourceSNCard);
     try
        dialog.CreateNewSerial:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmSerialNumbersCardDlg.ShowRemoveSerialDialog;
begin
     if ShowAskDialog('Удаление серийного номера карточки','Удалить серийный номер'+#13#10+IBCQuerySNCard.FieldByName('SN').asString+'?')=mrYes then
     begin
          try
             IBCQuerySNCard.Delete;
          except on E:Exception do
             begin
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
          ShowInfoForUser;
     end;
end;

procedure TfrmSerialNumbersCardDlg.WhenAddSerialFromScanner(const SerialNumber: String; const Param1,Param2, CountryID, VendorID:integer; var Added: Boolean);
var ErrorStr:String;
begin
     Added:=AddNewRecord(SerialNumber, 3, 0, ErrorStr);
end;

procedure TfrmSerialNumbersCardDlg.WhenBeginToAddSerials(Sender: TObject);
begin
     cxGridSerialsTable.DataController.BeginFullUpdate;
end;

procedure TfrmSerialNumbersCardDlg.WhenEndToAddSerials(Sender: TObject);
begin
     cxGridSerialsTable.DataController.EndFullUpdate;
end;

end.
