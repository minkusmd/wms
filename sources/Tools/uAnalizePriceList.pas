unit uAnalizePriceList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData,
  cxButtonEdit, cxCurrencyEdit, Vcl.Menus, cxButtons, Vcl.StdCtrls, DBAccess, IBC, MemDS, dxBar, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxTextEdit, cxMaskEdit, cxLabel, Vcl.ExtCtrls, Vcl.Controls, DialogTitle, Vcl.Forms,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfmAnalizePriceList = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    dxBarManager1: TdxBarManager;
    bbSourceInsertCodes: TdxBarButton;
    bbSourceInsertTitles: TdxBarButton;
    bbSourceDeleteAll: TdxBarButton;
    bbSourceInsertPrices: TdxBarButton;
    bbSourceInsertAll: TdxBarButton;
    bbStartSearchPrices: TdxBarButton;
    bbSelectGoodsAsLinked: TdxBarButton;
    beSourceProgressFirma: TdxBarEdit;
    bbSourceProgressSelectedFirma: TdxBarButton;
    bbSelectGoods: TdxBarButton;
    bbDeleteProcessSource: TdxBarButton;
    cmbFinalAction: TdxBarCombo;
    bbProcessData: TdxBarButton;
    dxBarButton1: TdxBarButton;
    IBCQueryPriceList: TIBCQuery;
    IBCDSPriceList: TIBCDataSource;
    Panel1: TPanel;
    cxLabel1: TcxLabel;
    beCT_NAME: TcxButtonEdit;
    cxGridPrice: TcxGrid;
    cxGridPriceTable: TcxGridDBTableView;
    cxGridPriceTableCUSTOMERID: TcxGridDBColumn;
    cxGridPriceTableDISPLAYNAME: TcxGridDBColumn;
    cxGridPriceTableGOODSID: TcxGridDBColumn;
    cxGridPriceTableGOODS_NAME: TcxGridDBColumn;
    cxGridPriceTableFK_GOODSID: TcxGridDBColumn;
    cxGridPriceTableFK_GOODS_TITLE: TcxGridDBColumn;
    cxGridPriceTableFK_PRICE: TcxGridDBColumn;
    cxGridPriceTablePRICECOLUMN: TcxGridDBColumn;
    cxGridPriceTableUPDATED_DATE: TcxGridDBColumn;
    cxGridPriceLevel: TcxGridLevel;
    cxGridPriceTableColumn1: TcxGridDBColumn;
    cxGridPriceTableColumn2: TcxGridDBColumn;
    cxGridPriceTableColumn3: TcxGridDBColumn;
    cxGridPriceTableColumn4: TcxGridDBColumn;
    btnSave: TButton;
    pnBottom: TPanel;
    btnClose: TcxButton;
    procedure bbSourceProgressSelectedFirmaClick(Sender: TObject);
    procedure bbStartSearchPricesClick(Sender: TObject);
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGrid1DBTableView1GOODS_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGridPriceTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cxGridPriceTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    FCustomerID: Integer;
    procedure SaveChanges;

  protected
    { protected declarations }
    procedure Prepare;override;
    procedure LoadStates;override;
    procedure SaveStates;override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure DoInsertWholeData;
    function GetSourceTextInfo(const Text: String; var Code: String; var Title: String; var Price: Double): Boolean;

  end;

implementation

uses Clipbrd, DateUtils, StrUtils, SWNUtils, SWNConst, DataModuleAdditions,
     SWNValueStorageUnit, frmCustomersDlg, SWNSecurityFlags, SWNCustomersTypesUnit, frmGoods;

{$R *.dfm}

procedure TfmAnalizePriceList.bbSourceProgressSelectedFirmaClick(Sender: TObject);
// var
// dialog:TfrmCustomersDlg;
begin
  // dialog := TfrmCustomersDlg.Create(Self);
  // try
  // dialog.CustomFilter:=[cfCustomers, cfVendors, cfDiler];
  // if dialog.SelectCustomer(FCustomerID, False, 0, 'Selectare contraagent pentru analiza preturilor') then
  // begin
  // FCustomerID := dialog.CustomerID;
  // beSourceProgressFirma.Text := dialog.CustomerTitle;
  // IBCQuery2.Close;
  // IBCQuery2.ParamByName('CUSTOMERID').AsInteger := FCustomerID;
  // IBCQuery2.Open;
  // end;
  // finally
  // dialog.Free;
  // end;
end;

procedure TfmAnalizePriceList.bbStartSearchPricesClick(Sender: TObject);
begin
  // if (FCustomerID>-1 )and (VarToDateTime(beDate.EditValue)>StrtoDate('01.11.2012') ) then
  // begin
  // with ibcquery do
  // begin
  // Close;
  // ParamByName('CUSTOMERID').AsInteger := FCustomerID;
  // ParamByName('DATA').AsDate := beDate.EditValue;
  // Open;
  // end;
  // end
  // else
  // begin
  // ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,'Nu sunt completati parametrii de intrare! Client si data!');
  // end;
end;

procedure TfmAnalizePriceList.btnCloseClick(Sender: TObject);
begin
     SaveChanges;
end;

procedure TfmAnalizePriceList.btnSaveClick(Sender: TObject);
begin
     SaveChanges;
end;

constructor TfmAnalizePriceList.Create(AOwner: TComponent);
begin
  inherited;
  FCustomerID := -1;

end;

procedure TfmAnalizePriceList.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    // dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(beCT_NAME.Tag, False, 0, 'Selectare contraagent') then
    begin
      beCT_NAME.Tag := dialog.CustomerID;
      // IBCQueryPriceList.FieldByName('CUSTOMERID').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
  IBCQueryPriceList.Close;
  IBCQueryPriceList.ParamByName('CUSTOMERID').AsInteger := beCT_NAME.Tag;
  IBCQueryPriceList.Open;
end;

procedure TfmAnalizePriceList.cxGridPriceTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure TfmAnalizePriceList.cxGrid1DBTableView1GOODS_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmGoodsBrowser;
  N: Integer;
begin
  dialog := TfrmGoodsBrowser.Create(Parent);
  try

    N := AppUserTempConfigStorage.IntValues.GetValue(Owner.Name + '_LastSelectedGoodsID', -1);
    if Not IBCQueryPriceList.FieldByName('GOODSID').IsNull then
      N := IBCQueryPriceList.FieldByName('GOODSID').AsInteger;
    if VarToStr(TcxCustomEdit(Sender).EditingValue) <> '' then
    begin
      dialog.EnableCondition(2, '(UPPER(TS_GOODS.TITLE) LIKE ''%' + UpperCase(TcxCustomEdit(Sender).EditingValue) + '%'')', '');
      dialog.ExtFilter := true;
    end;
    if dialog.SelectGoods(N, False) then
    begin
      IBCQueryPriceList.Edit;
      IBCQueryPriceList.FieldByName('GOODSID').AsInteger := dialog.GoodsID;
      IBCQueryPriceList.FieldByName('GOODS_NAME').AsString := dialog.GoodsTitle;
      IBCQueryPriceList.Post
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfmAnalizePriceList.cxGridPriceTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     // Ctrl+C
     if (Key=67) and (Shift=[ssCtrl]) then
     begin
          // copy cell content in clipboard
          CopyGridCellTextToClipboard(cxGridPriceTable);
          Key:=0;
          Shift:=[];
     end
end;

procedure TfmAnalizePriceList.DoInsertWholeData;
var
  List: TStringList;
  s: string;
  Code, Title: string;
  Price: Double;
begin
  List := TStringList.Create;
  try
    List.Text := Clipboard.AsText;
    if List.Count > 0 then
    begin
      while List.Count > 0 do
      begin
        s := List[0];
        if pos('"', s) > 0 then
        begin
          // data is in more rows
          s := StringReplace(s, '"', '', [rfReplaceAll]);
          repeat
            s := s + ' ' + List[1];
            List.Delete(0);
          until pos('"', s) > 0;
          s := StringReplace(s, '"', '', [rfReplaceAll]);
        end;

        if GetSourceTextInfo(s, Code, Title, Price) then
        begin

        end;
        List.Delete(0);
      end;
    end;
  finally
    List.Free;
  end;
end;

function TfmAnalizePriceList.GetSourceTextInfo(const Text: String; var Code, Title: String; var Price: Double): Boolean;
var
  k1, k2: Integer;
  value: Double;
begin
  Result := False;
  if Trim(Text) = '' then
    Exit;

  k1 := pos(#9, Text);
  k2 := PosEx(#9, Text, k1 + 1);

  if Not((k1 > 0) and (k2 > k1)) then
    Exit;

  value := StrToFloatDef(Trim(copy(Text, k2 + 1, Length(Text))), 1);
  if value > 0 then
  begin
    Code := Trim(copy(Text, 1, k1 - 1));
    Title := Trim(copy(Text, k1 + 1, k2 - k1));
    Price := value;
    Result := true;
  end;
end;

procedure TfmAnalizePriceList.LoadStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then Self.Position:=poDesigned;
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridPriceTable);
end;

procedure TfmAnalizePriceList.Prepare;
begin

end;

procedure TfmAnalizePriceList.SaveChanges;
begin
     if (IBCQueryPriceList.State in dsEditModes) then IBCQueryPriceList.Post;
     if IBCQueryPriceList.UpdateTransaction.Active then IBCQueryPriceList.UpdateTransaction.Commit;
end;

procedure TfmAnalizePriceList.SaveStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then AppUserConfigStorage.FormPositions.SaveFormPos(Self);
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridPriceTable);
end;

end.
