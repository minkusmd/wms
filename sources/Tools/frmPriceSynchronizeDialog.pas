unit frmPriceSynchronizeDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, ExtCtrls, StdCtrls, dxBar,
  cxStyles, cxCustomData,
  cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxGridLevel, cxGrid,
  ComCtrls, DB, DBAccess, IBC, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxLabel, cxCurrencyEdit, Vcl.Menus,
  MemDS, cxClasses;

type

  TSearchResultItem = class
  public
    { Public declarations }
    GoodsID:integer;
    Title:String;
    Price0:Double;
    Price1_USD:Double;
    Price2_USD:Double;
    CurrencyID:integer;
    CurrencyTitle:String;
    Linked:Boolean;
  end;

  TSearchResultSet = class
  private
    { Private declarations }
    fList:TList;
    function GetCount: integer;
    function GetItem(Index: integer): TSearchResultItem;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy;override;

    property Count:integer read GetCount;
    property Items[Index:integer]:TSearchResultItem read GetItem;default;

    procedure Delete(const Item:TSearchResultItem);
    procedure Clear;
    procedure AddItem(const GoodsID:integer; const Title:String; const Price0, Price1, Price2:Double; const CurrencyID:integer; const CurrencyTitle:String; const Linked:Boolean);
  end;



  TfrmPriceSynchronizeDlg = class(TForm)
    dtDialogTitle: TDialogTitle;
    Notebook: TNotebook;
    pnStep1: TPanel;
    Label1: TLabel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    cxGridSourceLevel: TcxGridLevel;
    cxGridSource: TcxGrid;
    cxGridSourceTable: TcxGridTableView;
    cxGridSource_CODE: TcxGridColumn;
    cxGridSource_TITLE: TcxGridColumn;
    cxGridSource_PRICE: TcxGridColumn;
    bbSourceInsertCodes: TdxBarButton;
    bbSourceInsertTitles: TdxBarButton;
    bbSourceDeleteAll: TdxBarButton;
    bbSourceInsertPrices: TdxBarButton;
    bbSourceInsertAll: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    pnProcessSource: TPanel;
    Label2: TLabel;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    cxGridProcessSourceLevel: TcxGridLevel;
    cxGridProcessSource: TcxGrid;
    cxGridProcessSourceTable: TcxGridTableView;
    dxBarDockControl3: TdxBarDockControl;
    dxBarManager1Bar3: TdxBar;
    cxGridProcessResultsLevel: TcxGridLevel;
    cxGridProcessResults: TcxGrid;
    cxGridProcessResultsTable: TcxGridTableView;
    cxGridProcessSource_CODE: TcxGridColumn;
    cxGridProcessSource_TITLE: TcxGridColumn;
    cxGridProcessSource_PRICE: TcxGridColumn;
    cxGridProcessResults_GOODSID: TcxGridColumn;
    cxGridProcessResults_TITLE: TcxGridColumn;
    cxGridProcessResults_PRICE0: TcxGridColumn;
    cxGridProcessResults_PRICE1: TcxGridColumn;
    cxGridProcessResults_PRICE2: TcxGridColumn;
    cxGridProcessResults_SELECTED: TcxGridColumn;
    bbStartSearchLinks: TdxBarButton;
    bbSelectGoodsAsLinked: TdxBarButton;
    IBCQuery: TIBCQuery;
    cxStyleRepositoryLocal: TcxStyleRepository;
    cxStyle_NoMatches: TcxStyle;
    cxStyle_TooMany: TcxStyle;
    cxStyle_Exact: TcxStyle;
    beSourceProgressFirma: TdxBarEdit;
    bbSourceProgressSelectedFirma: TdxBarButton;
    bbSelectGoods: TdxBarButton;
    cxStyle_Like: TcxStyle;
    pnProgress: TPanel;
    lbProgress: TLabel;
    pbProgressBar: TProgressBar;
    bbDeleteProcessSource: TdxBarButton;
    cxGridProcessSource_RESULTINDEX: TcxGridColumn;
    pnDBActions: TPanel;
    Label3: TLabel;
    dxBarDockControl4: TdxBarDockControl;
    dxBarManager1Bar4: TdxBar;
    cmbFinalAction: TdxBarCombo;
    bbProcessData: TdxBarButton;
    cxGridToDo: TcxGrid;
    cxGridToDoTable: TcxGridTableView;
    cxGrid_CODE: TcxGridColumn;
    cxGrid_TITLE: TcxGridColumn;
    cxGrid_OLD_PRICE: TcxGridColumn;
    cxGridToDoLevel: TcxGridLevel;
    cxGrid_FIRMA: TcxGridColumn;
    cxGrid_GOODS_TITLE: TcxGridColumn;
    cxGrid_GOODSID: TcxGridColumn;
    cxGrid_NEW_PRICE: TcxGridColumn;
    IBCQueryUpdate: TIBCQuery;
    IBCTrUpdate: TIBCTransaction;
    cxGrid_NEEDLINK: TcxGridColumn;
    lbStopProgress: TcxButton;
    btnPrev: TcxButton;
    btnNext: TcxButton;
    btnCancel: TcxButton;
    procedure bbSourceInsertAllClick(Sender: TObject);
    procedure bbSourceDeleteAllClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure bbStartSearchLinksClick(Sender: TObject);
    procedure cxGridProcessSourceTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure bbSourceProgressSelectedFirmaClick(Sender: TObject);
    procedure cxGridProcessSourceTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure lbStopProgressClick(Sender: TObject);
    procedure cxGridProcessResultsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbDeleteProcessSourceClick(Sender: TObject);
    procedure bbSelectGoodsAsLinkedClick(Sender: TObject);
    procedure bbSelectGoodsClick(Sender: TObject);
    procedure bbProcessDataClick(Sender: TObject);
    procedure bbSourceInsertCodesClick(Sender: TObject);
    procedure bbSourceInsertTitlesClick(Sender: TObject);
    procedure bbSourceInsertPricesClick(Sender: TObject);
  private
    { Private declarations }
    fCurrentPageIndex:integer;
    fSearchResult:TList;
    fTargetFirmaID:integer;
    fToStopProgress:Boolean;
    fLastSearchGoodsID:integer;
    procedure ClearSearchResult;
    procedure ChangePage(const NewIndex:Integer);
    procedure ClearGrid(const Grid:TcxGridTableView);

    procedure DoInsertWholeData;
    procedure DoInsertCodesColumn;
    procedure DoInsertTitleColumn;
    procedure DoInsertPriceColumn;

    function GetSourceTextInfo(const Text:String; var Code:String; var Title:String; var Price:Double):Boolean;
    procedure ProcessSourceSelectionChanged;
    procedure CopySourceDataToSourceProcessingData;
    procedure SelectFirmaForSourceProgress;
    procedure StartSearchingForGoodsLinks;
    procedure DisplaySearchResult(const Index:integer);
    procedure FoundGoodsSelectionChanged;
    procedure DeleteProcessSourceGoods;

    procedure DoGoodsSearchByCodeInDB(const Code:String; const Results:TSearchResultSet);
    procedure DoGoodsSearchByTitleInDB(const Title:String; const Results:TSearchResultSet);

    procedure CopyResultsToFinalProcess;
    procedure DoFinalActionsDB;

    function CheckStateForStep0to1:Boolean;
    function CheckStateForStep1to2:Boolean;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  end;


implementation

uses Clipbrd, StrUtils, frmCustomersDlg, frmGoods, SWNUtils, SWNConst;

{$R *.dfm}

procedure TfrmPriceSynchronizeDlg.bbDeleteProcessSourceClick(Sender: TObject);
begin
     DeleteProcessSourceGoods;
end;

procedure TfrmPriceSynchronizeDlg.bbProcessDataClick(Sender: TObject);
begin
     if ShowAskDialog(cmbFinalAction.Text,'Sigur doriti sa faceti acest lucru?')=mrYes then
     begin
          cmbFinalAction.Enabled:=False;
          bbProcessData.Enabled:=False;

          DoFinalActionsDB;

          btnPrev.Visible:=False;
          btnNext.Visible:=False;
          btnCancel.Caption:='Inchide';
     end;
end;

procedure TfrmPriceSynchronizeDlg.bbSelectGoodsAsLinkedClick(Sender: TObject);
var item,item2:TSearchResultItem;
    result:TSearchResultSet;
begin
     if cxGridProcessResultsTable.DataController.FocusedRecordIndex>=0 then
     begin
          result:=TSearchResultSet(fSearchResult[cxGridProcessSourceTable.DataController.FocusedRecordIndex]);
          item:=result[cxGridProcessResultsTable.DataController.FocusedRecordIndex];

          while result.Count>1 do
          begin
               item2:=result[0];
               if item2=item then item2:=result[1];

               result.Delete(item2);
               item2.Free;
          end;

          DisplaySearchResult(cxGridProcessSourceTable.DataController.FocusedRecordIndex);
     end;
end;

procedure TfrmPriceSynchronizeDlg.bbSelectGoodsClick(Sender: TObject);
var dialog:TfrmGoodsBrowser;
    result:TSearchResultSet;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.SelectGoods(fLastSearchGoodsID,false) then
        begin
             result:=TSearchResultSet(fSearchResult[cxGridProcessSourceTable.DataController.FocusedRecordIndex]);
             result.AddItem(dialog.GoodsID,dialog.GoodsTitle,dialog.GoodsPrice[0],dialog.GoodsPrice[1],dialog.GoodsPrice[2],dialog.GoodsPriceCurrencyID,'',False);
             DisplaySearchResult(cxGridProcessSourceTable.DataController.FocusedRecordIndex);

             fLastSearchGoodsID:=dialog.GoodsID;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmPriceSynchronizeDlg.bbSourceDeleteAllClick(Sender: TObject);
begin
     ClearGrid(cxGridSourceTable);
end;

procedure TfrmPriceSynchronizeDlg.bbSourceInsertAllClick(Sender: TObject);
begin
     DoInsertWholeData;
end;

procedure TfrmPriceSynchronizeDlg.bbSourceInsertCodesClick(Sender: TObject);
begin
     DoInsertCodesColumn;
end;

procedure TfrmPriceSynchronizeDlg.bbSourceInsertPricesClick(Sender: TObject);
begin
     DoInsertPriceColumn;
end;

procedure TfrmPriceSynchronizeDlg.bbSourceInsertTitlesClick(Sender: TObject);
begin
     DoInsertTitleColumn;
end;

procedure TfrmPriceSynchronizeDlg.bbSourceProgressSelectedFirmaClick(Sender: TObject);
begin
     SelectFirmaForSourceProgress;
end;

procedure TfrmPriceSynchronizeDlg.bbStartSearchLinksClick(Sender: TObject);
begin
     StartSearchingForGoodsLinks;
end;

procedure TfrmPriceSynchronizeDlg.btnNextClick(Sender: TObject);
begin
     ChangePage(fCurrentPageIndex+1);
end;

procedure TfrmPriceSynchronizeDlg.btnPrevClick(Sender: TObject);
begin
     ChangePage(fCurrentPageIndex-1);
end;

procedure TfrmPriceSynchronizeDlg.ChangePage(const NewIndex: Integer);
var isForward,isBackward:Boolean;
    allowChange:Boolean;
begin
     isForward:=NewIndex>fCurrentPageIndex;
     isBackward:=NewIndex<fCurrentPageIndex;
     allowChange:=isBackward;
     case NewIndex of
     0: begin
             allowChange:=True;
             // states
             if allowChange then
             begin
                  btnPrev.Enabled:=False;
                  btnNext.Enabled:=True;
             end;
        end;
     1: begin
             if isForward then
             begin
                  if CheckStateForStep0to1 then
                  begin
                       CopySourceDataToSourceProcessingData;
                       allowChange:=true;
                  end;
             end;
             // states
             if allowChange then
             begin
                  btnPrev.Enabled:=true;
                  btnNext.Enabled:=True;
             end;
        end;
     2: begin
             if isForward then
             begin
                  if CheckStateForStep1to2 then
                  begin
                       CopyResultsToFinalProcess;
                       allowChange:=true;
                  end;
             end;

             // states
             if allowChange then
             begin
                  btnPrev.Enabled:=True;
                  btnNext.Enabled:=False;
             end;
        end;
     end;
     if allowChange then
     begin
          fCurrentPageIndex:=NewIndex;
          Notebook.PageIndex:=fCurrentPageIndex;
     end;
end;

function TfrmPriceSynchronizeDlg.CheckStateForStep0to1: Boolean;
var ErrorStr:String;
    i:integer;
    moneyWarning:Boolean;
begin
     Result:=False;
     ErrorStr:='';
     moneyWarning:=False;

     if cxGridSourceTable.DataController.RecordCount=0 then AddErrorToStr(ErrorStr,'Nu sunt selectate datele initiale!')
     else
     begin
          // check Title column
          for i := 0 to cxGridSourceTable.DataController.RecordCount - 1 do
          if cxGridSourceTable.DataController.Values[i,cxGridSource_TITLE.Index]='' then
          begin
               AddErrorToStr(ErrorStr,'Nu sunt indicate denumirile marfurilor!');
               break;
          end;

          // check Money column
          for i := 0 to cxGridSourceTable.DataController.RecordCount - 1 do
          if cxGridSourceTable.DataController.Values[i,cxGridSource_PRICE.Index]=0 then
          begin
               moneyWarning:=True;
               break;
          end;

     end;

     if ErrorStr='' then
     begin
          if moneyWarning then
          begin
               cmbFinalAction.Enabled:=False;
               cmbFinalAction.ItemIndex:=0;
               ShowWarningDialog('Atentie','Nu sunt indicate preturile, functia de actualizare a preturilor va fi indisponibila.');
          end
          else
          begin
               cmbFinalAction.Enabled:=True;
          end;
          Result:=True;
     end
     else ShowErrorDialog(cMSG_GeneralError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

function TfrmPriceSynchronizeDlg.CheckStateForStep1to2: Boolean;
var ErrorStr:String;
    i,index:integer;
    results:TSearchResultSet;
begin
     Result:=False;
     ErrorStr:='';

     if fTargetFirmaID=-1 then AddErrorToStr(ErrorStr,'Selectati firma din care provin marfurile si efectuati cautarea marfurilor!')
     else
     begin
          // check if search result for each goods has exact 1 match
          for i := 0 to cxGridProcessSourceTable.DataController.RecordCount - 1 do
          begin
               index:=cxGridProcessSourceTable.DataController.Values[i,cxGridProcessSource_RESULTINDEX.Index];
               results:=TSearchResultSet(fSearchResult[index]);
               if results.Count>1 then
               begin
                    AddErrorToStr(ErrorStr,'La unele marfuri sunt indicate mai multe corespondente!');
                    break;
               end;
          end;
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmPriceSynchronizeDlg.ClearGrid(const Grid:TcxGridTableView);
begin
     Grid.BeginUpdate;
     try
        while Grid.DataController.RecordCount>0 do Grid.DataController.DeleteRecord(Grid.DataController.RecordCount-1);
     finally
        Grid.EndUpdate;
     end;
end;

procedure TfrmPriceSynchronizeDlg.ClearSearchResult;
var i:integer;
begin
     for i := 0 to fSearchResult.Count - 1 do TSearchResultSet(fSearchResult[i]).Free;
     fSearchResult.Clear;
end;

procedure TfrmPriceSynchronizeDlg.CopyResultsToFinalProcess;
var i,index,N:integer;
    Results:TSearchResultSet;
    item:TSearchResultItem;
begin
     cxGridToDoTable.BeginUpdate;
     try
        ClearGrid(cxGridToDoTable);

        for i := 0 to cxGridProcessSourceTable.DataController.RecordCount - 1 do
        begin
             index:=cxGridProcessSourceTable.DataController.Values[i,cxGridProcessSource_RESULTINDEX.Index];
             Results:=TSearchResultSet(fSearchResult[index]);
             if Results.Count=1 then
             begin
                  item:=Results[0];
                  N:=cxGridToDoTable.DataController.AppendRecord;
                  cxGridToDoTable.DataController.Values[N,cxGrid_FIRMA.Index]:=beSourceProgressFirma.Text;
                  cxGridToDoTable.DataController.Values[N,cxGrid_CODE.Index]:=cxGridProcessSourceTable.DataController.Values[i,cxGridProcessSource_CODE.Index];
                  cxGridToDoTable.DataController.Values[N,cxGrid_TITLE.Index]:=cxGridProcessSourceTable.DataController.Values[i,cxGridProcessSource_TITLE.Index];
                  cxGridToDoTable.DataController.Values[N,cxGrid_GOODSID.Index]:=item.GoodsID;
                  cxGridToDoTable.DataController.Values[N,cxGrid_GOODS_TITLE.Index]:=item.Title;
                  cxGridToDoTable.DataController.Values[N,cxGrid_OLD_PRICE.Index]:=item.Price0;
                  cxGridToDoTable.DataController.Values[N,cxGrid_NEW_PRICE.Index]:=cxGridProcessSourceTable.DataController.Values[i,cxGridProcessSource_PRICE.Index];
                  cxGridToDoTable.DataController.Values[N,cxGrid_NEEDLINK.Index]:=Not item.Linked;
             end;
        end;


     finally
        cxGridToDoTable.EndUpdate;
     end;
end;

procedure TfrmPriceSynchronizeDlg.CopySourceDataToSourceProcessingData;
var i,N:integer;
begin
     cxGridProcessSourceTable.BeginUpdate;
     try
        ClearGrid(cxGridProcessSourceTable);
        ClearGrid(cxGridProcessResultsTable);
        ClearSearchResult;

        for i := 0 to cxGridSourceTable.DataController.RecordCount-1 do
        begin
             N:=cxGridProcessSourceTable.DataController.AppendRecord;
             cxGridProcessSourceTable.DataController.Values[N,cxGridProcessSource_CODE.Index]:=cxGridSourceTable.DataController.Values[i,cxGridSource_CODE.Index];
             cxGridProcessSourceTable.DataController.Values[N,cxGridProcessSource_TITLE.Index]:=cxGridSourceTable.DataController.Values[i,cxGridSource_TITLE.Index];
             cxGridProcessSourceTable.DataController.Values[N,cxGridProcessSource_PRICE.Index]:=cxGridSourceTable.DataController.Values[i,cxGridSource_PRICE.Index];
             cxGridProcessSourceTable.DataController.Values[N,cxGridProcessSource_RESULTINDEX.Index]:=fSearchResult.Add(TSearchResultSet.Create);
        end;

     finally
        cxGridProcessSourceTable.EndUpdate;
     end;

     ProcessSourceSelectionChanged;
     FoundGoodsSelectionChanged;
end;

constructor TfrmPriceSynchronizeDlg.Create(AOwner:TComponent);
begin
     inherited;

     fSearchResult:=TList.Create;

     fLastSearchGoodsID:=0;
     fTargetFirmaID:=-1;
     fCurrentPageIndex:=0;
     bbStartSearchLinks.Enabled:=false;
     ChangePage(fCurrentPageIndex);
     pnProgress.Visible:=False;
end;

procedure TfrmPriceSynchronizeDlg.cxGridProcessResultsTableFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
     FoundGoodsSelectionChanged;
end;

procedure TfrmPriceSynchronizeDlg.cxGridProcessSourceTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     ProcessSourceSelectionChanged;
     // display search result for selected record
     if Assigned(AFocusedRecord) then DisplaySearchResult(AFocusedRecord.Index) else ClearGrid(cxGridProcessResultsTable);
end;

procedure TfrmPriceSynchronizeDlg.cxGridProcessSourceTableStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  out AStyle: TcxStyle);
var index:integer;
    Results:TSearchResultSet;
    count:integer;
begin
     index:=ARecord.Values[cxGridProcessSource_RESULTINDEX.Index];
     results:=TSearchResultSet(fSearchResult[index]);
     if Assigned(Results) then
     begin
          count:=Results.Count;
          if Count=0 then AStyle:=cxStyle_NoMatches
          else
          if Count=1 then AStyle:=cxStyle_Exact
          else AStyle:=cxStyle_TooMany;
     end;
end;

procedure TfrmPriceSynchronizeDlg.DeleteProcessSourceGoods;
begin
     if cxGridProcessSourceTable.DataController.FocusedRecordIndex>=0 then
     begin
          cxGridProcessSourceTable.BeginUpdate;
          try
             cxGridProcessSourceTable.DataController.DeleteRecord(cxGridProcessSourceTable.DataController.FocusedRecordIndex);
          finally
             cxGridProcessSourceTable.EndUpdate;
          end;
     end;
end;

destructor TfrmPriceSynchronizeDlg.Destroy;
begin
     ClearSearchResult;
     fSearchResult.Free;
     inherited;
end;

procedure TfrmPriceSynchronizeDlg.DisplaySearchResult(const Index: integer);
var i,N:integer;
    results:TSearchResultSet;
    item:TSearchResultItem;
begin
     cxGridProcessResultsTable.BeginUpdate;
     try
        ClearGrid(cxGridProcessResultsTable);
        results:=TSearchResultSet(fSearchResult[Index]);
        for i := 0 to results.Count - 1 do
        begin
             item:=results[i];
             N:=cxGridProcessResultsTable.DataController.AppendRecord;
             cxGridProcessResultsTable.DataController.Values[N,cxGridProcessResults_GOODSID.Index]:=item.GoodsID;
             cxGridProcessResultsTable.DataController.Values[N,cxGridProcessResults_TITLE.Index]:=item.Title;
             cxGridProcessResultsTable.DataController.Values[N,cxGridProcessResults_PRICE0.Index]:=item.Price0;
             cxGridProcessResultsTable.DataController.Values[N,cxGridProcessResults_PRICE1.Index]:=item.Price1_USD;
             cxGridProcessResultsTable.DataController.Values[N,cxGridProcessResults_PRICE2.Index]:=item.Price2_USD;
        end;
     finally
        cxGridProcessResultsTable.EndUpdate;
     end;
     FoundGoodsSelectionChanged;
end;

procedure TfrmPriceSynchronizeDlg.DoFinalActionsDB;
var i:integer;
    foreign_Code:String;
    foreign_Title:String;
    GoodsID:integer;
    GodosTitle:String;
    //oldPrice:Double;
    //newPrice:Double;
begin
     IBCQueryUpdate.Close;
     IBCTrUpdate.StartTransaction;
     try
        IBCQueryUpdate.SQL.Text:='UPDATE OR INSERT INTO TS_GOODS_FOREIGN (GOODSID,CUSTOMERID,GOODS_CODE,GOODS_TITLE) VALUES (:goodsID,:custID,:code,:title)';
        // create links
        for i := 0 to cxGridToDoTable.DataController.RecordCount - 1 do
        if cxGridToDoTable.DataController.Values[i,cxGrid_NEEDLINK.Index]=true then
        begin
             foreign_Code:=cxGridToDoTable.DataController.Values[i,cxGrid_CODE.Index];
             foreign_Title:=cxGridToDoTable.DataController.Values[i,cxGrid_TITLE.Index];
             GoodsID:=cxGridToDoTable.DataController.Values[i,cxGrid_GOODSID.Index];
             GodosTitle:=cxGridToDoTable.DataController.Values[i,cxGrid_GOODS_TITLE.Index];
             //oldPrice:=cxGridToDoTable.DataController.Values[i,cxGrid_OLD_PRICE.Index];
             //newPrice:=cxGridToDoTable.DataController.Values[i,cxGrid_NEW_PRICE.Index];

             IBCQueryUpdate.ParamByName('goodsID').AsInteger:=GoodsID;
             IBCQueryUpdate.ParamByName('custID').AsInteger:=fTargetFirmaID;
             if foreign_Code<>'' then IBCQueryUpdate.ParamByName('code').AsString:=foreign_Code
             else IBCQueryUpdate.ParamByName('code').Value:=NULL;
             IBCQueryUpdate.ParamByName('title').AsString:=foreign_Title;
             IBCQueryUpdate.ExecSQL;
        end;

        // update prices
        if cmbFinalAction.ItemIndex=1 then
        begin


             for i := 0 to cxGridToDoTable.DataController.RecordCount - 1 do
             begin

             end;
        end;

        IBCTrUpdate.Commit;
     except on E:Exception do
        begin
             IBCTrUpdate.RollBack;
        end;
     end;
     IBCQueryUpdate.Close;
end;

procedure TfrmPriceSynchronizeDlg.DoGoodsSearchByCodeInDB(const Code: String; const Results: TSearchResultSet);
begin
     IBCQuery.Close;
     IBCQuery.SQL.Text:='SELECT GOODSID, TITLE, PRICE0, PRICE1_USD, PRICE2_USD, CURRENCYID, CURRENCY_TITLE'+
                        ' FROM VW_TS_GOODS WHERE GOODSID=(SELECT FIRST 1 GOODSID FROM TS_GOODS_FOREIGN WHERE CUSTOMERID=:firma AND GOODS_CODE=:code)';
     IBCQuery.ParamByName('firma').AsInteger:=fTargetFirmaID;
     IBCQuery.ParamByName('code').AsString:=Code;
     IBCQuery.ExecSQL;
     while Not IBCQuery.Eof do
     begin
          Results.AddItem(IBCQuery.FieldByName('GOODSID').AsInteger,IBCQuery.FieldByName('TITLE').AsString,
                          IBCQuery.FieldByName('PRICE0').AsFloat,IBCQuery.FieldByName('PRICE1_USD').AsFloat,IBCQuery.FieldByName('PRICE1_USD').AsFloat,
                          IBCQuery.FieldByName('CURRENCYID').AsInteger,IBCQuery.FieldByName('CURRENCY_TITLE').AsString,True);

          IBCQuery.Next;
     end;
     IBCQuery.Close;
end;

procedure TfrmPriceSynchronizeDlg.DoGoodsSearchByTitleInDB(const Title: String; const Results: TSearchResultSet);
begin
     // strategies:
     // 1. exact compare
     IBCQuery.Close;
     IBCQuery.SQL.Text:='SELECT * FROM VW_TS_GOODS WHERE GOODSID=(SELECT FIRST 1 GOODSID FROM TS_GOODS_FOREIGN WHERE CUSTOMERID=:firma AND UPPER(GOODS_TITLE)=UPPER(:title))';
     IBCQuery.ParamByName('firma').asInteger:=fTargetFirmaID;
     IBCQuery.ParamByName('title').AsString:=Title;
     IBCQuery.ExecSQL;
     while Not IBCQuery.Eof do
     begin
          Results.AddItem(IBCQuery.FieldByName('GOODSID').AsInteger,IBCQuery.FieldByName('TITLE').AsString,
                          IBCQuery.FieldByName('PRICE0').AsFloat,IBCQuery.FieldByName('PRICE1_USD').AsFloat,IBCQuery.FieldByName('PRICE1_USD').AsFloat,
                          IBCQuery.FieldByName('CURRENCYID').AsInteger,IBCQuery.FieldByName('CURRENCY_TITLE').AsString,False);
          IBCQuery.Next;
     end;
end;

procedure TfrmPriceSynchronizeDlg.DoInsertCodesColumn;
var List:TStringList;
    i,N:integer;
begin
     List:=TStringList.Create;
     cxGridSourceTable.BeginUpdate;
     try
        List.Text:=Clipboard.AsText;
        for i := 0 to List.Count - 1 do
        begin
             if (i>=cxGridSourceTable.DataController.RecordCount) then
             begin
                  // create new record
                  N:=cxGridSourceTable.DataController.AppendRecord;
                  cxGridSourceTable.DataController.Values[N,cxGridSource_CODE.Index]:=Trim(List[i]);
                  cxGridSourceTable.DataController.Values[N,cxGridSource_TITLE.Index]:='';
                  cxGridSourceTable.DataController.Values[N,cxGridSource_PRICE.Index]:=0;
             end
             else
             cxGridSourceTable.DataController.Values[i,cxGridSource_CODE.Index]:=Trim(List[i]);
        end;
     finally
        List.Free;
        cxGridSourceTable.EndUpdate;
     end;
end;

procedure TfrmPriceSynchronizeDlg.DoInsertPriceColumn;
var List:TStringList;
    i,N:integer;
    value:Double;
begin
     List:=TStringList.Create;
     cxGridSourceTable.BeginUpdate;
     try
        List.Text:=Clipboard.AsText;
        for i := 0 to List.Count - 1 do
        begin
             value:=StrToFloatDef(Trim(List[i]),-1);
             if (value<0) then value:=0;
             if (i>=cxGridSourceTable.DataController.RecordCount) then
             begin
                  // create new record
                  N:=cxGridSourceTable.DataController.AppendRecord;
                  cxGridSourceTable.DataController.Values[N,cxGridSource_CODE.Index]:='';
                  cxGridSourceTable.DataController.Values[N,cxGridSource_TITLE.Index]:='';
                  cxGridSourceTable.DataController.Values[N,cxGridSource_PRICE.Index]:=Value;
             end
             else
             cxGridSourceTable.DataController.Values[i,cxGridSource_PRICE.Index]:=Value;
        end;
     finally
        List.Free;
        cxGridSourceTable.EndUpdate;
     end;
end;

procedure TfrmPriceSynchronizeDlg.DoInsertTitleColumn;
var List:TStringList;
    i,N:integer;
    s:string;
begin
     List:=TStringList.Create;
     cxGridSourceTable.BeginUpdate;
     try
        List.Text:=Clipboard.AsText;
        i:=0;
        while (List.Count>0) do
        begin
             s:=List[0];
             if (pos('"',s)>0) and (List.Count>1) then
             begin
                  repeat
                        s:=StringReplace(s,'"','',[rfReplaceAll]);
                        s:=s+' '+List[1];
                        List.Delete(0);
                  until pos('"',s)>0;
                  s:=StringReplace(s,'"','',[rfReplaceAll]);
             end;

             if (i>=cxGridSourceTable.DataController.RecordCount) then
             begin
                  // create new record
                  N:=cxGridSourceTable.DataController.AppendRecord;
                  cxGridSourceTable.DataController.Values[N,cxGridSource_CODE.Index]:='';
                  cxGridSourceTable.DataController.Values[N,cxGridSource_TITLE.Index]:=Trim(s);
                  cxGridSourceTable.DataController.Values[N,cxGridSource_PRICE.Index]:=0;
             end
             else
             cxGridSourceTable.DataController.Values[i,cxGridSource_TITLE.Index]:=Trim(s);

             List.Delete(0);
             inc(i);
        end;
     finally
        List.Free;
        cxGridSourceTable.EndUpdate;
     end;
end;

procedure TfrmPriceSynchronizeDlg.DoInsertWholeData;
var List:TStringList;
    N:integer;
    s:string;
    code,title:string;
    price:double;
begin
     cxGridSourceTable.BeginUpdate;
     List:=TStringList.Create;
     try
        ClearGrid(cxGridSourceTable);

        List.Text:=Clipboard.AsText;
        if List.Count>0 then
        begin
             while List.Count>0 do
             begin
                  s:=List[0];
                  if pos('"',s)>0 then
                  begin
                       // data is in more rows
                       s:=StringReplace(s,'"','',[rfReplaceAll]);
                       repeat
                             s:=s+' '+List[1];
                             List.Delete(0);
                       until pos('"',s)>0;
                       s:=StringReplace(s,'"','',[rfReplaceAll]);
                  end;


                  if GetSourceTextInfo(s,code,title,price) then
                  begin
                       N:=cxGridSourceTable.DataController.AppendRecord;
                       cxGridSourceTable.DataController.Values[N,cxGridSource_CODE.Index]:=code;
                       cxGridSourceTable.DataController.Values[N,cxGridSource_TITLE.Index]:=title;
                       cxGridSourceTable.DataController.Values[N,cxGridSource_PRICE.Index]:=price;
                  end;
                  List.Delete(0);
             end;
        end;
     finally
        List.Free;
        cxGridSourceTable.EndUpdate;
     end;

end;

procedure TfrmPriceSynchronizeDlg.FoundGoodsSelectionChanged;
var fMakeDefault:Boolean;
begin
     fMakeDefault:=False;
     if cxGridProcessResultsTable.DataController.RecordCount>0 then
     begin
          if cxGridProcessResultsTable.DataController.RecordCount>1 then
          begin
               fMakeDefault:=True;
          end;
     end;
     bbSelectGoodsAsLinked.Enabled:=fMakeDefault;
end;

function TfrmPriceSynchronizeDlg.GetSourceTextInfo(const Text: String; var Code, Title: String;
  var Price: Double): Boolean;
var k1,k2:integer;
    value:Double;
begin
     Result:=False;
     if Trim(Text)='' then Exit;

     k1:=Pos(#9,Text);
     k2:=PosEx(#9,Text,k1+1);

     if Not ((k1>0) and (k2>k1)) then Exit;

      value:=StrToFloatDef(Trim(copy(Text,k2+1,Length(Text))),1);
      if Value>0 then
      begin
           Code:=Trim(Copy(Text,1,k1-1));
           Title:=Trim(Copy(Text,k1+1,k2-k1));
           Price:=value;
           Result:=True;
      end;
end;

procedure TfrmPriceSynchronizeDlg.lbStopProgressClick(Sender: TObject);
begin
     fToStopProgress:=True;
end;

procedure TfrmPriceSynchronizeDlg.ProcessSourceSelectionChanged;
var fCanDelete,fSelectGoods:Boolean;
begin
     fCanDelete:=False;
     fSelectGoods:=False;

     if cxGridProcessSourceTable.Controller.FocusedRow<>nil then
     begin
          fCanDelete:=True;
          fSelectGoods:=True;
     end;

     bbDeleteProcessSource.Enabled:=fCanDelete;
     bbSelectGoods.Enabled:=fSelectGoods;
end;

procedure TfrmPriceSynchronizeDlg.SelectFirmaForSourceProgress;
var dialog:TfrmCustomersDlg;
begin
     dialog:=TfrmCustomersDlg.Create(Self);
     try
        if dialog.SelectCustomer(fTargetFirmaID) then
        begin
             fTargetFirmaID:=dialog.CustomerID;
             beSourceProgressFirma.Text:=dialog.CustomerTitle;
             bbStartSearchLinks.Enabled:=True;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmPriceSynchronizeDlg.StartSearchingForGoodsLinks;
var i,index:integer;
    code,title:string;
    results:TSearchResultSet;
begin
     fToStopProgress:=False;
     pnProgress.Visible:=True;
     pbProgressBar.Max:=cxGridProcessSourceTable.DataController.RecordCount;

     for i := 0 to cxGridProcessSourceTable.DataController.RecordCount - 1 do
     begin
          if fToStopProgress then break;

          code:=cxGridProcessSourceTable.DataController.Values[i,cxGridProcessSource_CODE.Index];
          title:=cxGridProcessSourceTable.DataController.Values[i,cxGridProcessSource_TITLE.Index];
          index:=cxGridProcessSourceTable.DataController.Values[i,cxGridProcessSource_RESULTINDEX.Index];
          results:=TSearchResultSet(fSearchResult[index]);

          lbProgress.Caption:=title;
          pbProgressBar.Position:=i;
          Application.ProcessMessages;

          // 1. search by code
          if code<>'' then DoGoodsSearchByCodeInDB(code,results);

          // 2. search bu title
          if results.Count=0 then DoGoodsSearchByTitleInDB(title,results);

          cxGridProcessSourceTable.Controller.FocusRecord(i,false);

          Application.ProcessMessages;
     end;
     pnProgress.Visible:=False;
     cxGridProcessSourceTable.Controller.FocusRecord(0,false);
end;

{ TSearchResultSet }

procedure TSearchResultSet.AddItem(const GoodsID: integer; const Title: String; const Price0, Price1, Price2: Double;
                                   const CurrencyID:integer; const CurrencyTitle:String; const Linked:Boolean);
var item:TSearchResultItem;
begin
     item:=TSearchResultItem.Create;
     item.GoodsID:=GoodsID;
     item.Title:=Title;
     item.Price0:=Price0;
     item.Price1_USD:=Price1;
     item.Price2_USD:=Price2;
     item.CurrencyID:=CurrencyID;
     item.CurrencyTitle:=CurrencyTitle;
     item.Linked:=Linked;
     fList.Add(item);
end;

procedure TSearchResultSet.Clear;
var i:integer;
begin
     for i := 0 to fList.Count - 1 do TSearchResultItem(fList[i]).Free;
     fList.Clear;
end;

constructor TSearchResultSet.Create;
begin
     fList:=TList.Create;
end;

procedure TSearchResultSet.Delete(const Item: TSearchResultItem);
begin
     fList.Remove(Item);
end;

destructor TSearchResultSet.Destroy;
begin
     Clear;
     fList.Free;
     inherited;
end;

function TSearchResultSet.GetCount: integer;
begin
     Result:=fList.Count;
end;

function TSearchResultSet.GetItem(Index: integer): TSearchResultItem;
begin
     Result:=TSearchResultItem(fList[Index]);
end;

end.
