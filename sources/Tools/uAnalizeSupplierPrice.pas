unit uAnalizeSupplierPrice;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, cxGraphics, cxControls,
  SWNBaseUnit, System.Contnrs, Vcl.Graphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxCurrencyEdit, cxImageComboBox, Vcl.ImgList, Vcl.Controls, dxBar,
  Vcl.StdCtrls, cxClasses, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, Vcl.ComCtrls, DBAccess, IBC, MemDS, DialogTitle,
  cxDataControllerConditionalFormattingRulesManagerDialog, System.ImageList, cxImageList, dxDateRanges,
  dxScrollbarAnnotations;

type

  TGoodsItem = class
    Articol:String;
    Title:String;
    Price:Double;
  end;

  TfmAnalizeSupplierPrice = class(TSWNCustomForm)
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
    IBCQueryNewGoods: TIBCQuery;
    IBCDataSourceNewGoods: TIBCDataSource;
    IBCQueryAnalyze: TIBCQuery;
    IBCDataSourceAnalyze: TIBCDataSource;
    IBCQueryOldGoods: TIBCQuery;
    IBCDataSourceOldGoods: TIBCDataSource;
    pcPageControl: TPageControl;
    tbsOldGoods: TTabSheet;
    tbsNewGoods: TTabSheet;
    tbsAnalyze: TTabSheet;
    cxGridOld: TcxGrid;
    cxGridOldTable: TcxGridDBTableView;
    cxGridOldTableARTICOL: TcxGridDBColumn;
    cxGridOldTableTITLE: TcxGridDBColumn;
    cxGridOldTablePRICE: TcxGridDBColumn;
    cxGridOldLevel: TcxGridLevel;
    cxGridNew: TcxGrid;
    cxGridNewTable: TcxGridDBTableView;
    cxGridNewTableARTICOL: TcxGridDBColumn;
    cxGridNewTableTITLE: TcxGridDBColumn;
    cxGridNewTablePRICE: TcxGridDBColumn;
    cxGridNewLevel: TcxGridLevel;
    cxGridAnalyze: TcxGrid;
    cxGridAnalyzeTable: TcxGridDBTableView;
    cxGridAnalyze_ARTICOL: TcxGridDBColumn;
    cxGridAnalyze_PRICE_OLD: TcxGridDBColumn;
    cxGridAnalyze_PRICE_NEW: TcxGridDBColumn;
    cxGridAnalyze_FLAGS: TcxGridDBColumn;
    cxGridAnalyzeLevel: TcxGridLevel;
    bardocOldGoods: TdxBarDockControl;
    bardocNewGoods: TdxBarDockControl;
    bardocAnalyze: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    btnPasteOld_Accent: TdxBarButton;
    dxBarButton2: TdxBarButton;
    btnPasteNew: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton1: TdxBarButton;
    btnClose: TButton;
    dxBarSubItem1: TdxBarSubItem;
    btnPasteOld_Ultra: TdxBarButton;
    cxGridOld_ID: TcxGridDBColumn;
    cxGridAnalyze_NAME: TcxGridDBColumn;
    dxBarSubItem2: TdxBarSubItem;
    dxBarButton4: TdxBarButton;
    cxGridNew_ID: TcxGridDBColumn;
    cxImageList_FLAGS: TcxImageList;
    procedure bbSourceProgressSelectedFirmaClick(Sender: TObject);
    procedure bbStartSearchPricesClick(Sender: TObject);
    procedure btnPasteOld_AccentClick(Sender: TObject);
    procedure btnPasteNewClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxGridAnalyzeTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridNewTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridOldTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridAnalyzeTableFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure cxGridAnalyzeTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
  private
    { Private declarations }
    FCustomerID: Integer;
    procedure AnalyzeSelectionChanged;
    procedure FindAndFocusArticol(const Articol:String; const Grid:TcxGridDBTableView; const ColumnIndex:Integer);

    procedure GetDataFromXLSText(const SourceText:String; const DataText:TStrings);
    procedure SplitText(const Separator, SourceText:String; const ArrayText:TStrings);
    function GetPriceValue(const PriceText:String):Double;

    procedure GetGoods_Accent(const SourceText:String; const GoodsList:TObjectList);
    function GetGoodsData_Accent(const TextLine:String; const PriceColumn:integer):TGoodsItem;

    procedure GetGoods_Ultra(const SourceText:String; const GoodsList:TObjectList);
    function GetGoodsData_Ultra(const TextLine:String; const PriceColumn:integer):TGoodsItem;

    procedure DoInsertWholeDataOldPrice(const PriceListVendor:integer);
    procedure DoInsertWholeDataNewPrice(const PriceListVendor:integer);

  protected
    { protected declarations }
    procedure Prepare;override;

  public
    { Public declarations }
  end;

implementation

uses Clipbrd, DateUtils, StrUtils, SWNUtils, SWNConst, DataModuleAdditions,
  SWNValueStorageUnit, frmCustomersDlg, SWNSecurityFlags, SWNCustomersTypesUnit, frmGoods, SWNDBErrors,
  DataModuleDB;

{$R *.dfm}

procedure TfmAnalizeSupplierPrice.AnalyzeSelectionChanged;
var articol:String;
begin
     if Assigned(cxGridAnalyzeTable.Controller.FocusedRecord) then
     begin
          articol:=cxGridAnalyzeTable.Controller.FocusedRecord.Values[cxGridAnalyze_ARTICOL.Index];

          FindAndFocusArticol(articol,cxGridOldTable,cxGridOldTableARTICOL.Index);
          FindAndFocusArticol(articol,cxGridNewTable,cxGridNewTableARTICOL.Index);
     end
     else
     begin
          cxGridOldTable.Controller.ClearSelection;
          cxGridNewTable.Controller.ClearSelection;
     end;
end;

procedure TfmAnalizeSupplierPrice.bbSourceProgressSelectedFirmaClick(Sender: TObject);
// var
// dialog:TfrmCustomersDlg;
begin
  // dialog := TfrmCustomersDlg.Create(Self);
  // try
  // dialog.CustomFilter:=[cfCustomers, cfVendors, cfDiler];
  // if dialog.SelectCustomer(FCustomerID, False, 0, 'Выбор контрагента для анализа прайса') then
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

procedure TfmAnalizeSupplierPrice.bbStartSearchPricesClick(Sender: TObject);
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
  // ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,'Не заполнены входные параметры! Клиент и дата!');
  // end;
end;

procedure TfmAnalizeSupplierPrice.btnPasteNewClick(Sender: TObject);
begin
     DoInsertWholeDataNewPrice(TdxBarButton(Sender).Tag);
end;

procedure TfmAnalizeSupplierPrice.btnPasteOld_AccentClick(Sender: TObject);
begin
     DoInsertWholeDataOldPrice(TdxBarButton(Sender).Tag);
end;

procedure TfmAnalizeSupplierPrice.cxButton1Click(Sender: TObject);
begin
     IBCQueryAnalyze.Close;
     IBCQueryAnalyze.ParamByName('USER_ID').AsInteger:=dmDB.CurrentUserID;
     IBCQueryAnalyze.Open;
     AnalyzeSelectionChanged;
     cxGridAnalyze.SetFocus;
end;

procedure TfmAnalizeSupplierPrice.cxButton2Click(Sender: TObject);
begin
     dmdb.ExecuteQuery('delete from TS_COMPARE_PRICE_OLD where USERID=:id', [dmDB.CurrentUserID]);
     IBCQueryOldGoods.Refresh;
end;

procedure TfmAnalizeSupplierPrice.cxButton3Click(Sender: TObject);
begin
     dmdb.ExecuteQuery('delete from TS_COMPARE_PRICE_NEW where USERID=:id', [dmDB.CurrentUserID]);
     IBCQueryNewGoods.Refresh;
end;

procedure TfmAnalizeSupplierPrice.cxGridAnalyzeTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if Not AViewInfo.Selected and VarIsNumeric(AViewInfo.GridRecord.Values[cxGridAnalyze_FLAGS.Index]) then
     begin
          if AViewInfo.GridRecord.Values[cxGridAnalyze_FLAGS.Index]=2 then ACanvas.Font.Color := clGrayText;
     end;

     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color := $E8E8E8;
     end;
end;

procedure TfmAnalizeSupplierPrice.cxGridAnalyzeTableFocusedItemChanged(Sender: TcxCustomGridTableView;
  APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
begin
     AnalyzeSelectionChanged;
end;

procedure TfmAnalizeSupplierPrice.cxGridAnalyzeTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     AnalyzeSelectionChanged;
end;

procedure TfmAnalizeSupplierPrice.cxGridNewTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color := $E8E8E8;
     end;
end;

procedure TfmAnalizeSupplierPrice.cxGridOldTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color := $E8E8E8;
     end;
end;

procedure TfmAnalizeSupplierPrice.DoInsertWholeDataNewPrice(const PriceListVendor:integer);
var goodsList:TObjectList;
    i:integer;
    item:TGoodsItem;
begin
     goodsList:=TObjectList.Create;
     try
        // prepare goods list by price list Vendor
        case PriceListVendor of
        // Accent electronic
        1: GetGoods_Accent(Clipboard.AsText, goodsList);
        // Ultra
        2: GetGoods_Ultra(Clipboard.AsText, goodsList);
        end;

        if goodsList.Count>0 then
        begin
             if ShowAskDialog('Вставка из нового прайс-листа',Format('Вы хотите вставить %d товаров из нового прайс-листа?',[goodsList.Count]))=mrYes then
             begin
                  IBCQueryNewGoods.DisableControls;
                  try
                     IBCQueryNewGoods.UpdateTransaction.StartTransaction;
                     try
                        for i := 0 to goodsList.Count-1 do
                        begin
                             item:=TGoodsItem(goodsList[i]);

                             IBCQueryNewGoods.Insert;
                             IBCQueryNewGoods.FieldByName('ARTICOL').AsString := item.Articol;
                             IBCQueryNewGoods.FieldByName('NAME').AsString := item.Title;
                             IBCQueryNewGoods.FieldByName('PRICE').AsFloat := item.Price;
                             IBCQueryNewGoods.FieldByName('USERID').AsInteger := dmDB.CurrentUserID;
                             IBCQueryNewGoods.Post;
                        end;
                        // done
                        IBCQueryNewGoods.UpdateTransaction.Commit;
                     except on E:Exception do
                        begin
                             if IBCQueryNewGoods.State in dsEditModes then IBCQueryNewGoods.Cancel;
                             IBCQueryNewGoods.UpdateTransaction.Rollback;
                             if Not ProcessSWNError(E) then raise;
                        end;
                     end;
                  finally
                     IBCQueryNewGoods.EnableControls;
                  end;
             end;
        end
        else ShowErrorDialog('Ошибка','Нет товаров!');
     finally
        goodsList.Free;
     end;end;

procedure TfmAnalizeSupplierPrice.DoInsertWholeDataOldPrice(const PriceListVendor:integer);
var goodsList:TObjectList;
    i:integer;
    item:TGoodsItem;
begin
     goodsList:=TObjectList.Create;
     try
        // prepare goods list by price list Vendor
        case PriceListVendor of
        // Accent electronic
        1: GetGoods_Accent(Clipboard.AsText, goodsList);
        // Ultra
        2: GetGoods_Ultra(Clipboard.AsText, goodsList);
        end;

        if goodsList.Count>0 then
        begin
             if ShowAskDialog('Вставка из старого прайс-листа',Format('Вы хотите вставить %d товаров из старого прайс-листа?',[goodsList.Count]))=mrYes then
             begin
                  IBCQueryOldGoods.DisableControls;
                  try
                     IBCQueryOldGoods.UpdateTransaction.StartTransaction;
                     try
                        for i := 0 to goodsList.Count-1 do
                        begin
                             item:=TGoodsItem(goodsList[i]);

                             IBCQueryOldGoods.Insert;
                             IBCQueryOldGoods.FieldByName('ARTICOL').AsString := item.Articol;
                             IBCQueryOldGoods.FieldByName('NAME').AsString := item.Title;
                             IBCQueryOldGoods.FieldByName('PRICE').AsFloat := item.Price;
                             IBCQueryOldGoods.FieldByName('USERID').AsInteger := dmDB.CurrentUserID;
                             IBCQueryOldGoods.Post;
                        end;
                        // done
                        IBCQueryOldGoods.UpdateTransaction.Commit;
                     except on E:Exception do
                        begin
                             if IBCQueryOldGoods.State in dsEditModes then IBCQueryOldGoods.Cancel;
                             IBCQueryOldGoods.UpdateTransaction.Rollback;
                             if Not ProcessSWNError(E) then raise;
                        end;
                     end;
                  finally
                     IBCQueryOldGoods.EnableControls;
                  end;
             end;
        end
        else ShowErrorDialog('Ошибка','Нет товаров!');
     finally
        goodsList.Free;
     end;
end;

procedure TfmAnalizeSupplierPrice.FindAndFocusArticol(const Articol: String; const Grid:TcxGridDBTableView; const ColumnIndex:Integer);
var i,N:integer;
begin
     Grid.BeginUpdate;
     try
        Grid.Controller.ClearSelection;

        for i := 0 to Grid.DataController.RecordCount-1 do
        if (Grid.DataController.Values[i,ColumnIndex]=Articol) then
        begin
             N:=Grid.DataController.GetRowIndexByRecordIndex(i,True);
             Grid.Controller.FocusedRowIndex:=N;
             Grid.Controller.SelectAllColumns;
             Grid.DataController.SelectRows(N,N);
             break;
        end;
     finally
       Grid.EndUpdate;
     end;
end;

procedure TfmAnalizeSupplierPrice.FormCreate(Sender: TObject);
begin
     FCustomerID:=1;
     pcPageControl.ActivePage:=tbsOldGoods;
end;

procedure TfmAnalizeSupplierPrice.GetDataFromXLSText(const SourceText: String; const DataText: TStrings);
var text: TStringList;
    textLine,s:String;
    needMoreData:Boolean;
    k:integer;
begin
     text:=TStringList.Create;
     try
        text.Text:=SourceText;
        needMoreData:=false;

        while (text.Count>0) do
        begin
             if needMoreData then
             begin
                  s:=text[0];
                  //k:=OccurrencesOfText('"',s);
                  //if (k>0) and Odd(k) then needMoreData:=false;
                  k:=Pos('"'#9,s);
                  if (k>0) then needMoreData:=False;

                  s:=StringReplace(s, '"', '', [rfReplaceAll]);
                  textLine:=textLine+' '+s;
                  text.Delete(0);
             end
             else
             begin
                  textLine:=text[0];
                  //k:=OccurrencesOfText('"',textLine);
                  //if (k>0) and Odd(k) then needMoreData:=True;

                  k:=Pos(#9'"',textLine);
                  if (k>0) then needMoreData:=True;

                  textLine:=StringReplace(textLine, '"', '', [rfReplaceAll]);
                  text.Delete(0);
             end;

             if Not needMoreData then
             DataText.Add(textLine);
        end;
     finally
        text.Free;
     end;
end;

function TfmAnalizeSupplierPrice.GetGoodsData_Accent(const TextLine: String; const PriceColumn:integer): TGoodsItem;
var data:TStringList;
    price:Double;
    PriceColumnIndex:integer;
begin
     Result:=nil;
     // Accent price list structure
     // 0. P/N
     // 1. Description
     // 2. Recom RETAIL [1]
     // 3. Recom ONLINE [2]
     // 4. Dealer A, USD [3]
     // 5. Dealer B, USD [4]

     case PriceColumn of
     2: PriceColumnIndex:=3;
     3: PriceColumnIndex:=4;
     4: PriceColumnIndex:=5;
     else PriceColumnIndex:=2;
     end;

     // parse data
     data:=TStringList.Create;
     try
        SplitText(#9,TextLine,data);
        if (data.Count>PriceColumnIndex) then
        begin
             price:=GetPriceValue(data[PriceColumnIndex]);
             if (data[0]<>'') and (data[1]<>'') and (price>=0) then
             begin
                  // got some data, create object
                  Result:=TGoodsItem.Create;
                  Result.Articol:=data[0];
                  Result.Title:=data[1];
                  Result.Price:=price;
             end;
        end;
     finally
       data.Free;
     end;
end;

function TfmAnalizeSupplierPrice.GetGoodsData_Ultra(const TextLine: String; const PriceColumn: integer): TGoodsItem;
var data:TStringList;
    price:Double;
    priceColumnIndex:integer;
begin
     Result:=nil;
     // Ultra price list structure
     // 0. Код
     // 1. Наименование
     // 2. Кол-во
     // 3. Гар
     // 4. ЦенаА, MDL [1]
     // 5. ЦенаА, USD [2]
     // 6. <empty>
     // 7. ЦенаD, USD [3]

     case PriceColumn of
     2: priceColumnIndex:=5;
     3: priceColumnIndex:=7;
     else priceColumnIndex:=4;
     end;

     // parse data
     data:=TStringList.Create;
     try
        SplitText(#9,TextLine,data);
        if (data.Count>priceColumnIndex) then
        begin
             price:=GetPriceValue(data[PriceColumnIndex]);
             if (data[0]<>'') and (data[1]<>'') and (price>=0) then
             begin
                  // got some data, create object
                  Result:=TGoodsItem.Create;
                  Result.Articol:=data[0];
                  Result.Title:=data[1];
                  Result.Price:=price;
             end;
        end;
     finally
       data.Free;
     end;
end;

procedure TfmAnalizeSupplierPrice.GetGoods_Accent(const SourceText: String; const GoodsList: TObjectList);
var dataText: TStringList;
    goodsItem:TGoodsItem;
  i: Integer;
begin
     dataText:=TStringList.Create;
     try
        GetDataFromXLSText(SourceText, dataText);
        for i := 0 to dataText.Count-1 do
        begin
             goodsItem:=GetGoodsData_Accent(dataText[i], 4); // 4 colonita: "Dealer B, USD"
             if Assigned(goodsItem) then GoodsList.Add(goodsItem);
        end;
     finally
        dataText.Free;
     end;
end;

procedure TfmAnalizeSupplierPrice.GetGoods_Ultra(const SourceText: String; const GoodsList: TObjectList);
var dataText: TStringList;
    goodsItem:TGoodsItem;
  i: Integer;
begin
     dataText:=TStringList.Create;
     try
        GetDataFromXLSText(SourceText, dataText);
        for i := 0 to dataText.Count-1 do
        begin
             goodsItem:=GetGoodsData_Ultra(dataText[i], 3); // 3 colonita: "ЦенаD, USD"
             if Assigned(goodsItem) then GoodsList.Add(goodsItem);
        end;
     finally
        dataText.Free;
     end;
end;

function TfmAnalizeSupplierPrice.GetPriceValue(const PriceText: String): Double;
var S:String;
    N:Double;
begin
     Result:=-1;
     // scapam de delimitator de mii
     S:=StringReplace(PriceText,FormatSettings.ThousandSeparator,'',[rfReplaceAll]);
     // scapam de cuvintul "MDL"
     S:=StringReplace(S,'MDL','',[rfReplaceAll]);

     N:=StrToFloatDef(Trim(S),-1);
     if (N>=0) then Result:=N;
end;

procedure TfmAnalizeSupplierPrice.Prepare;
begin
     IBCQueryOldGoods.ParamByName('USER_ID').AsInteger:=dmDB.CurrentUserID;
     IBCQueryNewGoods.ParamByName('USER_ID').AsInteger:=dmDB.CurrentUserID;
     IBCQueryOldGoods.Open;
     IBCQueryNewGoods.Open;
     cxGridOldTableARTICOL.Selected:=True;
     cxGridNewTableARTICOL.Selected:=True;
     cxGridAnalyze_ARTICOL.Selected:=True;
end;

procedure TfmAnalizeSupplierPrice.SplitText(const Separator, SourceText: String; const ArrayText: TStrings);
var k:integer;
    S:String;
begin
     S:=SourceText;
     k:=Pos(Separator,S);
     while (k>0) do
     begin
          ArrayText.Add(Trim(Copy(S,1,k-1)));
          Delete(S,1,k);
          k:=Pos(Separator,S);
     end;
     if Length(S)>0 then ArrayText.Add(Trim(S));
end;

end.
