unit frmАктОприходованияПоНакладнымImportGoodsAcntDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, dxBar, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxClasses, cxGridLevel, cxGrid, Vcl.ExtCtrls, DialogTitle,
  Vcl.StdCtrls, SWNBaseUnit, cxImageComboBox, Data.DB, MemDS, DBAccess, IBC, cxLabel, Vcl.ComCtrls,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type

  TGoodsAcntInfoRec = record
    GoodsAcntID:integer;
    GoodsAcntTitle:String;
    GoodsID:integer;
    GoodsTitle:String;
    GoodsUmID:Integer;
    HasInfo:Boolean;
  end;


  TFrame41ImportGoodsAcntDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbClear: TdxBarButton;
    bbPaste: TdxBarButton;
    btnClose: TButton;
    IBCQueryInfo: TIBCQuery;
    btnImport: TButton;
    pcPageControl: TPageControl;
    tbsGoods: TTabSheet;
    tbsErrors: TTabSheet;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    cxGridTable_IMG: TcxGridColumn;
    cxGridTable_ID: TcxGridColumn;
    cxGridTable_QTY: TcxGridColumn;
    cxGridTable_TITLE: TcxGridColumn;
    cxGridTable_TITLE2: TcxGridColumn;
    cxGridTable_ERROR: TcxGridColumn;
    cxGridTable_GOODSID: TcxGridColumn;
    cxGridTable_UMID: TcxGridColumn;
    cxGridLevel: TcxGridLevel;
    mmErrors: TMemo;
    procedure bbPasteClick(Sender: TObject);
    procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure bbClearClick(Sender: TObject);
  private
    FDOCID: integer;
    FDTDEP: integer;
    FCTDEP: integer;
    { Private declarations }
    procedure ImportFromClipboard;
    function GetGoodsAcntInfo(const GoodsAcntID:integer):TGoodsAcntInfoRec;
    function GetGoodGoodsCount:integer;
    function SaveImports:Boolean;
    procedure SetDOCID(const Value: integer);
    procedure SetDTDEP(const Value: integer);
    procedure SetCTDEP(const Value: integer);
    function GetGoodsACNTIndex(const GoodsAcntID:integer):Integer;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    property DOCID:integer read FDOCID write SetDOCID;
    property DTDEP:integer read FDTDEP write SetDTDEP;
    property CTDEP:integer read FCTDEP write SetCTDEP;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, ClipBrd, SWNUtils, SWNDBErrors;

{ TTFrame41ImportGoodsAcntDlg }

procedure TFrame41ImportGoodsAcntDlg.bbClearClick(Sender: TObject);
begin
     cxGridTable.DataController.BeginUpdate;
     try
        while cxGridTable.DataController.RecordCount>0 do
        cxGridTable.DataController.DeleteRecord(0);
     finally
        cxGridTable.DataController.EndUpdate;
     end;
end;

procedure TFrame41ImportGoodsAcntDlg.bbPasteClick(Sender: TObject);
begin
     ImportFromClipboard;
end;

procedure TFrame41ImportGoodsAcntDlg.cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if ARecord.Values[cxGridTable_ERROR.Index]=true then
     begin
          AStyle:=dmAdditions.cxStyle_TextColorRed;
     end;
end;

function TFrame41ImportGoodsAcntDlg.GetGoodGoodsCount: integer;
var i:integer;
begin
     Result:=0;
     for i := 0 to cxGridTable.DataController.RecordCount-1 do
     if (cxGridTable.DataController.Values[i,cxGridTable_ERROR.Index]=false) then Inc(Result);
end;

function TFrame41ImportGoodsAcntDlg.GetGoodsAcntInfo(const GoodsAcntID: integer): TGoodsAcntInfoRec;
begin
     Result.HasInfo:=False;
     IBCQueryInfo.Close;
     IBCQueryInfo.ParamByName('ID').AsInteger:=GoodsAcntID;
     try
        IBCQueryInfo.Open;
        if (Not IBCQueryInfo.Eof) and (Not IBCQueryInfo.Fields[2].IsNull) then
        begin
             Result.GoodsAcntID:=IBCQueryInfo.Fields[0].AsInteger;
             Result.GoodsAcntTitle:=IBCQueryInfo.Fields[1].AsString;
             Result.GoodsID:=IBCQueryInfo.Fields[2].AsInteger;
             Result.GoodsTitle:=IBCQueryInfo.Fields[3].AsString;
             Result.GoodsUmID:=IBCQueryInfo.Fields[4].AsInteger;
             Result.HasInfo:=True;
        end;
     finally
        IBCQueryInfo.Close;
     end;
end;

function TFrame41ImportGoodsAcntDlg.GetGoodsACNTIndex(const GoodsAcntID: integer): Integer;
var i:integer;
begin
     Result:=-1;
     for i := 0 to cxGridTable.DataController.RecordCount-1 do
     if (cxGridTable.DataController.Values[i,cxGridTable_ID.Index])=GoodsAcntID then
     begin
          Result:=i;
          Break;
     end;
end;

procedure TFrame41ImportGoodsAcntDlg.ImportFromClipboard;
var List:TStringList;
    i,k,n,acntID:integer;
    Qty:double;
    S,s1,s2:String;
    info:TGoodsAcntInfoRec;
    existsIndex:integer;
    GoodCount,BadCount,RepeatCount:integer;
begin
     if Not Clipboard.HasFormat(CF_TEXT) then
     begin
          ShowErrorDialog('Ошибка','Нет данный в буфере!');
          Exit;
     end;

     GoodCount:=0;
     BadCount:=0;
     RepeatCount:=0;

     cxGridTable.DataController.BeginUpdate;
     mmErrors.Lines.BeginUpdate;
     List:=TStringList.Create;
     try
        mmErrors.Lines.Clear;

        List.Text:=Clipboard.AsText;
        for i := 0 to List.Count-1 do
        begin
             // parse line
             S:=Trim(List[i]);
             k:=pos(#9,S);
             if k=0 then Continue;

             s1:=Trim(Copy(S,1,k-1));
             s2:=Trim(Copy(S,k+1,Length(S)));

             // parse AcntID
             k:=pos(' ',s1);
             if (k>0) then s1:=Copy(s1,1,k-1);
             acntID:=StrToIntDef(s1,-1);

             // parse QTY. Remove fraction part
             //k:=pos(',',s2);
             //if (k=0) then k:=pos('.',s2);
             //if (k>0) then s2:=StringReplace(Copy(s2,1,k-1),' ','',[rfReplaceAll]);
             Qty:=StrToFloatDef(s2,0);

             if (acntID>0) then
             begin
                  existsIndex:=GetGoodsACNTIndex(acntID);
                  if existsIndex>=0 then
                  begin
                       Qty:=Qty+cxGridTable.DataController.Values[existsIndex,cxGridTable_QTY.Index];
                       cxGridTable.DataController.Values[existsIndex,cxGridTable_QTY.Index]:=Qty;
                       cxGridTable.DataController.Values[existsIndex,cxGridTable_ERROR.Index]:=(Qty<=0);
                       mmErrors.Lines.Add(Format('Повторение: %d',[acntID]));
                       inc(RepeatCount);
                  end
                  else
                  begin
                       info:=GetGoodsAcntInfo(acntID);

                       N:=cxGridTable.DataController.AppendRecord;
                       cxGridTable.DataController.Values[N,cxGridTable_ID.Index]:=acntID;
                       cxGridTable.DataController.Values[N,cxGridTable_QTY.Index]:=Qty;

                       if info.HasInfo then
                       begin
                            cxGridTable.DataController.Values[N,cxGridTable_TITLE.Index]:=info.GoodsAcntTitle;
                            cxGridTable.DataController.Values[N,cxGridTable_TITLE2.Index]:=info.GoodsTitle;
                            cxGridTable.DataController.Values[N,cxGridTable_GOODSID.Index]:=info.GoodsID;
                            cxGridTable.DataController.Values[N,cxGridTable_UMID.Index]:=info.GoodsUmID;
                            cxGridTable.DataController.Values[N,cxGridTable_ERROR.Index]:=(Qty<=0);

                            if (Qty<=0) then inc(BadCount)
                            else inc(GoodCount);
                       end
                       else
                       begin
                            inc(BadCount);
                            cxGridTable.DataController.Values[N,cxGridTable_ERROR.Index]:=True;
                            mmErrors.Lines.Add(Format('Нет товара с таким кодом по бухгалтерии: %d',[acntID]));
                       end;
                  end;
             end;
        end;
     finally
        List.Free;
        cxGridTable.DataController.EndUpdate;
        mmErrors.Lines.EndUpdate;
     end;
     ShowInfoDialog('Вставка',Format('Итого:'#13#10'Для импорта: %d'#13#10'Без количества: %d'#13#10'Повторений: %d',[GoodCount,BadCount,RepeatCount]));
end;

function TFrame41ImportGoodsAcntDlg.IsFormDataPosted: Boolean;
var S:String;
begin
     S:='Всего наименовании: '+IntToStr(GetGoodGoodsCount);
     Result:=(ShowAskDialog('Импорт наименований по бухгалтерии','Вы хотите импортировать наименования по бухгалтерии?',S)=mrYes) and SaveImports;
end;

procedure TFrame41ImportGoodsAcntDlg.Prepare;
begin
     pcPageControl.ActivePage:=tbsGoods;
end;

function TFrame41ImportGoodsAcntDlg.SaveImports: Boolean;
var Query:TIBCQuery;
    i:integer;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Add('INSERT INTO TDB_JURNAL (DOCID,DTDEP,CTDEP,GOODSCOMPLECT_ID,GOODSID,UMID,QTY,PRICE,WARRANTY)');
        Query.SQL.Add('VALUES (:DOCID,:DTDEP,:CTDEP,-1,:GOODSID,:UMID,:QTY,0,0)');
        Query.ParamByName('DOCID').AsInteger:=FDOCID;
        Query.ParamByName('DTDEP').AsInteger:=FDTDEP;
        Query.ParamByName('CTDEP').AsInteger:=FCTDEP;
        try
           Query.Transaction.StartTransaction;
           for i := 0 to cxGridTable.DataController.RecordCount-1 do
           if cxGridTable.DataController.Values[i,cxGridTable_ERROR.Index]=false then
           begin
                Query.ParamByName('GOODSID').AsInteger:=cxGridTable.DataController.Values[i,cxGridTable_GOODSID.Index];
                Query.ParamByName('QTY').AsFloat:=cxGridTable.DataController.Values[i,cxGridTable_QTY.Index];
                Query.ParamByName('UMID').AsInteger:=cxGridTable.DataController.Values[i,cxGridTable_UMID.Index];
                Query.ExecSQL;
           end;

           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TFrame41ImportGoodsAcntDlg.SetCTDEP(const Value: integer);
begin
  FCTDEP := Value;
end;

procedure TFrame41ImportGoodsAcntDlg.SetDOCID(const Value: integer);
begin
  FDOCID := Value;
end;

procedure TFrame41ImportGoodsAcntDlg.SetDTDEP(const Value: integer);
begin
  FDTDEP := Value;
end;

end.
