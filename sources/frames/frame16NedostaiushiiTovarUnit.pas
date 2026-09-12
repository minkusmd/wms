unit frame16NedostaiushiiTovarUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit, cxStyles, DB, DBAccess, IBC, swnUtils,
  dxBar, ComCtrls, ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, RzTreeVw, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, MemDS, cxClasses, cxGridCustomView,
  dxUIAClasses;

type
  Tframe16NedostaiushiiTovar = class(TSWNBaseFrame)
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    cxGridGoodsTable_GOODSID: TcxGridDBColumn;
    cxGridGoodsTable_TITLE: TcxGridDBColumn;
    cxGridGoodsTable_QTY: TcxGridDBColumn;
    cxGridGoodsTable_PARENTID: TcxGridDBColumn;
    cxGridGoodsTable_PARENT_TITLE: TcxGridDBColumn;
    pnStocks: TPanel;
    CheckTree: TRzCheckTree;
    dxBarDockControl: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbRefresh: TdxBarButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    procedure CheckTreeCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
    procedure bbRefreshClick(Sender: TObject);
    procedure cxGridGoodsTableStylesGetGroupStyle(Sender: TcxGridTableView; ARecord: TcxCustomGridRecord;
      ALevel: Integer; out AStyle: TcxStyle);
    procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CreateStockTree;
    procedure ReadStockListDB(const ParentNode:TTreeNode);
    procedure UpdateStockInfo;
    function GetCheckedStockIDList:String;
  protected
    { Protected declarations }
    function InitFrameID:integer;override;
    function GetFilterFields:TFrameFilterFields;override;
    function GetFrameButtons:TFrameButtons;override;
    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;
  public
    { Public declarations }
  end;

var
  frame16NedostaiushiiTovar: Tframe16NedostaiushiiTovar;

implementation

uses DataModuleAdditions, DataModuleDB;

{$R *.dfm}

type

  TItemData = class
    StockID:integer;
  end;

{ Tframe16NedostaiushiiTovar }

procedure Tframe16NedostaiushiiTovar.bbRefreshClick(Sender: TObject);
begin
     UpdateStockInfo;
end;

procedure Tframe16NedostaiushiiTovar.CheckTreeCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
begin
     if Node=CheckTree.Items[0] then AllowCollapse:=False;
end;

procedure Tframe16NedostaiushiiTovar.CreateStockTree;
var Node:TTreeNode;
    Data:TItemData;
begin
     CheckTree.Items.BeginUpdate;
     try
        CheckTree.Items.Clear;

        Node:=CheckTree.Items.AddChild(nil,'Toate depozitele');
        Data:=TItemData.Create;
        Data.StockID:=-1;
        Node.Data:=Data;

        Node.ImageIndex:=27;
        Node.SelectedIndex:=27;
        ReadStockListDB(Node);
     finally
        CheckTree.Items.EndUpdate;
     end;
end;

procedure Tframe16NedostaiushiiTovar.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     swnutils.ProcessCommonKeys(self, cxGridGoodsTable,Key,Shift);
end;

procedure Tframe16NedostaiushiiTovar.cxGridGoodsTableStylesGetGroupStyle(Sender: TcxGridTableView;
  ARecord: TcxCustomGridRecord; ALevel: Integer; out AStyle: TcxStyle);
begin
     if ALevel=0 then AStyle:=dmAdditions.cxStyle_Bold;
end;

procedure Tframe16NedostaiushiiTovar.DoFrameHide;
begin
     IBCQueryGoods.Close;
     inherited;
end;

procedure Tframe16NedostaiushiiTovar.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;
     CreateStockTree;
end;

function Tframe16NedostaiushiiTovar.GetCheckedStockIDList: String;
var Node:TTreeNode;
    i:integer;
    Data:TItemData;
begin
     Result:='';
     for i := 0 to CheckTree.Items.Count - 1 do
     begin
          Node:=CheckTree.Items[i];
          if (Node.Level=2) and (CheckTree.ItemState[i]=csChecked) then
          begin
               if Result<>'' then Result:=Result+',';
               Data:=TItemData(Node.Data);
               Result:=Result+IntToStr(Data.StockID);
          end;
     end;
end;

function Tframe16NedostaiushiiTovar.GetFilterFields: TFrameFilterFields;
begin
     Result:=[];
end;

function Tframe16NedostaiushiiTovar.GetFrameButtons: TFrameButtons;
begin
     Result:=[];
end;

function Tframe16NedostaiushiiTovar.InitFrameID: integer;
begin
     Result:=16; //  Marfa lipsa
end;

procedure Tframe16NedostaiushiiTovar.ReadStockListDB(const ParentNode:TTreeNode);
var Query:TIBCQuery;
    Node,Node2:TTreeNode;
    Data,Data2:TItemData;
begin
     CheckTree.Items.BeginUpdate;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT STOCKID, PARENTID, FLG_FOLDER, TITLE FROM TS_STOCKS WHERE (STOCKID<>-1) ORDER BY TITLE';

        Query.ExecSQL;
        while not Query.Eof do
        begin
             if (Query.FieldByName('FLG_FOLDER').asInteger=1) and (Query.FieldByName('PARENTID').asInteger=0) then
             begin
                  Node:=CheckTree.Items.AddChild(ParentNode,Query.FieldByName('TITLE').AsString);
                  // attach additional data
                  Data:=TItemData.Create;
                  Data.StockID:=Query.FieldByName('STOCKID').AsInteger;
                  Node.Data:=Data;

                  Node.ImageIndex:=13;
                  Node.SelectedIndex:=13;
                  // uncheck all
                  CheckTree.ChangeNodeCheckState(Node,csUnchecked);
             end;
             Query.Next;
        end;

        Node:=ParentNode.getFirstChild;
        while Node<>nil do
        begin
             Data:=TItemData(Node.Data);
             Query.First;
             while not Query.Eof do
             begin
                  if (Query.FieldByName('FLG_FOLDER').asInteger=0) and (Query.FieldByName('PARENTID').asInteger=Data.StockID) then
                  begin
                       Node2:=CheckTree.Items.AddChild(Node,Query.FieldByName('TITLE').AsString);
                       // attach additional data
                       Data2:=TItemData.Create;
                       Data2.StockID:=Query.FieldByName('STOCKID').AsInteger;
                       Node2.Data:=Data2;

                       Node2.StateIndex:=Query.FieldByName('STOCKID').AsInteger;
                       Node2.ImageIndex:=27;
                       Node2.SelectedIndex:=27;
                       // uncheck all
                       CheckTree.ChangeNodeCheckState(Node2,csUnchecked);
                  end;
                  Query.Next;
             end;
             //Node.Expanded:=True;
             Node:=Node.getNextSibling;
        end;
        Query.Close;
        ParentNode.Expanded:=True;
     finally
        Query.Free;
        CheckTree.Items.EndUpdate;
     end;
end;

procedure Tframe16NedostaiushiiTovar.UpdateStockInfo;
var InList:String;
begin
     InList:=GetCheckedStockIDList;
     IBCQueryGoods.Close;
     if InList<>'' then
     begin
          IBCQueryGoods.ParamByName('DT').AsInteger:=dmDB.CurrentFirma;
          IBCQueryGoods.ParamByName('DTDEPLIST').AsString:=InList;
          IBCQueryGoods.Open;
          cxGridGoodsTable.DataController.Groups.FullExpand;
     end;
end;

end.
