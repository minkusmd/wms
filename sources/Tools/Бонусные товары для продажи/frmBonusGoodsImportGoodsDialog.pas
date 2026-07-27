unit frmBonusGoodsImportGoodsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, Vcl.StdCtrls, Vcl.ExtCtrls,
  cxPC, DialogTitle, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, dxBar, cxClasses, cxGridLevel, cxGrid, cxContainer, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCalc,
  cxDBEdit, cxTextEdit, cxMaskEdit, cxCalendar, cxImageComboBox, Vcl.ComCtrls, dxCore, cxDateUtils, dxBarBuiltInMenu,
  dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations, dxUIAClasses;

type

  TImportBonusGoodsInfo = record
    GoodsList:String;
    DateStart:TDateTime;
    DateEnd:TDateTime;
    BonusType:Integer;
    BonusValue:Double;
    BonusCurrencyID:Integer;
    ClearPreviousGoods:Boolean;
  end;

  TfrmBonusGoodsImportGoodsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pcPageControl: TcxPageControl;
    tbsGoods: TcxTabSheet;
    tbsDefaults: TcxTabSheet;
    pnBottom: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    dxBarSubItem1: TdxBarSubItem;
    bbVendorCode: TdxBarButton;
    bbNeuronCode: TdxBarButton;
    bbImport: TdxBarButton;
    bbVerify: TdxBarButton;
    cxGridTable: TcxGridTableView;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    rbFixedSum: TRadioButton;
    rbPercent: TRadioButton;
    lcbCurrency: TcxLookupComboBox;
    cxGridTable_IMG: TcxGridColumn;
    cxGridTable_VCODE: TcxGridColumn;
    cxGridTable_NCODE: TcxGridColumn;
    cxGridTable_TITLE: TcxGridColumn;
    cxGridTable_STATUS: TcxGridColumn;
    cxGridTable_STATUSCODE: TcxGridColumn;
    bbClearAll: TdxBarButton;
    deDATA1: TcxDateEdit;
    deDATA2: TcxDateEdit;
    edSUMA_BONUS: TcxCalcEdit;
    edPERCENT_BONUS: TcxCalcEdit;
    Label4: TLabel;
    cbDeletePreviousGoods: TCheckBox;
    Label7: TLabel;
    procedure bbVendorCodeClick(Sender: TObject);
    procedure bbClearAllClick(Sender: TObject);
    procedure bbImportClick(Sender: TObject);
    procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AStyle: TcxStyle);
    procedure bbVerifyClick(Sender: TObject);
  private
    { Private declarations }
    procedure GoodsCodeSourceChanged;
    procedure ClearAllRecords;
    procedure PasteGoods(const ClearAll:Boolean);
    procedure PasteByVendor;
    procedure PasteByNeuron;
    procedure VerifyByNeuronCode;
    procedure VerifyByVendorCode;

    function VerifyInputData:Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
  public
    { Public declarations }
    function GetImportInfo:TImportBonusGoodsInfo;
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions, SWNUtils, Vcl.Clipbrd, SWNConst, IBC, DataModuleDB;

{ TForm2 }

procedure TfrmBonusGoodsImportGoodsDlg.bbClearAllClick(Sender: TObject);
begin
     if ShowAskDialog('Удаление записей','Удалить все записи?')=mrYes then ClearAllRecords;
end;

procedure TfrmBonusGoodsImportGoodsDlg.bbImportClick(Sender: TObject);
var S:String;
    clearAll:Boolean;
begin
     if bbNeuronCode.Down then S:='из Неурона' else S:='поставщика';
     if Not Clipboard.HasFormat(CF_TEXT) or (Clipboard.AsText='') then
     begin
          ShowErrorDialog(cMSG_GeneralError_Title,'В буфере обмена нет данных!');
          Exit;
     end;

     clearAll:=False;
     if ShowAskDialogVerification('Вставка товаров',Format('Вы хотите вставить товары по коду %s?',[S]),'Удалить текущие товары','',clearAll)=mrYes then PasteGoods(clearAll);
end;

procedure TfrmBonusGoodsImportGoodsDlg.bbVendorCodeClick(Sender: TObject);
begin
     GoodsCodeSourceChanged;
end;

procedure TfrmBonusGoodsImportGoodsDlg.bbVerifyClick(Sender: TObject);
begin
     if bbNeuronCode.Down
       then VerifyByNeuronCode
       else VerifyByVendorCode;
end;

procedure TfrmBonusGoodsImportGoodsDlg.ClearAllRecords;
var i:integer;
begin
     cxGridTable.BeginUpdate;
     try
        for i := cxGridTable.DataController.RecordCount-1 downto 0 do cxGridTable.DataController.DeleteRecord(i);
     finally
       cxGridTable.EndUpdate;
       bbVerify.Enabled:=False;
     end;
end;

procedure TfrmBonusGoodsImportGoodsDlg.cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if VarIsNumeric(ARecord.Values[cxGridTable_STATUSCODE.Index]) then
     case ARecord.Values[cxGridTable_STATUSCODE.Index] of
     -1: ;
     0: AStyle:=dmAdditions.cxStyle_TextColorGreen;
     1: AStyle:=dmAdditions.cxStyle_TextColorRed;
     end;
end;

function TfrmBonusGoodsImportGoodsDlg.GetImportInfo: TImportBonusGoodsInfo;
var i:integer;
begin
     Result.ClearPreviousGoods:=cbDeletePreviousGoods.Checked;
     Result.GoodsList:='';
     Result.DateStart:=deDATA1.EditValue;
     Result.DateEnd:=deDATA2.EditValue;
     Result.BonusValue:=0;
     Result.BonusType:=0;
     Result.BonusCurrencyID:=-1;
     if rbFixedSum.Checked then
     begin
          Result.BonusType:=1;
          Result.BonusValue:=edSUMA_BONUS.EditValue;
          Result.BonusCurrencyID:=lcbCurrency.EditValue;
     end
     else
     begin
          Result.BonusValue:=edPERCENT_BONUS.EditValue;
     end;
     for i := 0 to cxGridTable.DataController.RecordCount-1 do
     if (cxGridTable.DataController.Values[i,cxGridTable_STATUSCODE.Index]=0) then
     begin
          if Result.GoodsList<>'' then Result.GoodsList:=Concat(Result.GoodsList,',');
          Result.GoodsList:=Concat(Result.GoodsList,IntToStr(cxGridTable.DataController.Values[i,cxGridTable_NCODE.Index]));
     end;
end;

procedure TfrmBonusGoodsImportGoodsDlg.GoodsCodeSourceChanged;
begin
     cxGridTable_VCODE.Visible:=bbVendorCode.Down;
     cxGridTable_NCODE.Visible:=bbNeuronCode.Down;
     ClearAllRecords;
     bbVerify.Enabled:=False;
end;

function TfrmBonusGoodsImportGoodsDlg.IsFormDataPosted: Boolean;
begin
     Result:=VerifyInputData;
end;

procedure TfrmBonusGoodsImportGoodsDlg.PasteByNeuron;
var Codes:TStrings;
    i,N,code:integer;
    S:String;
begin
     Codes:=TStringList.Create;
     try
        Codes.Text:=Trim(Clipboard.AsText);
        for i := 0 to Codes.Count-1 do
        begin
             if (Codes[i]='') then Continue;

             S:=Codes[i];
             N:=Pos(#9,S);
             if (N>0) then S:=Copy(S,1,N-1);

             code:=StrToIntDef(S,-1);
             N:=cxGridTable.DataController.AppendRecord;
             if (code>0) then
             begin
                  cxGridTable.DataController.Values[N,cxGridTable_NCODE.Index]:=code;
                  cxGridTable.DataController.Values[N,cxGridTable_STATUS.Index]:='не проверен';
                  cxGridTable.DataController.Values[N,cxGridTable_STATUSCODE.Index]:=-1;
             end
             else
             begin
                  cxGridTable.DataController.Values[N,cxGridTable_TITLE.Index]:=S;
                  cxGridTable.DataController.Values[N,cxGridTable_STATUS.Index]:='плохой код';
                  cxGridTable.DataController.Values[N,cxGridTable_STATUSCODE.Index]:=1; // red
             end;

        end;
     finally
        Codes.Free;
     end;
end;

procedure TfrmBonusGoodsImportGoodsDlg.PasteByVendor;
var Codes:TStrings;
    i,N:integer;
    S:String;
begin
     Codes:=TStringList.Create;
     try
        Codes.Text:=Trim(Clipboard.AsText);
        for i := 0 to Codes.Count-1 do
        begin
             if (Codes[i]='') then Continue;

             S:=Codes[i];
             N:=Pos(#9,S);
             if (N>0) then S:=Copy(S,1,N-1);

             N:=cxGridTable.DataController.AppendRecord;
             cxGridTable.DataController.Values[N,cxGridTable_VCODE.Index]:=S;
             cxGridTable.DataController.Values[N,cxGridTable_STATUS.Index]:='не проверен';
             cxGridTable.DataController.Values[N,cxGridTable_STATUSCODE.Index]:=-1;
        end;
     finally
        Codes.Free;
     end;
end;

procedure TfrmBonusGoodsImportGoodsDlg.PasteGoods(const ClearAll: Boolean);
begin
     if ClearAll then ClearAllRecords;
     cxGridTable.BeginUpdate;
     try
        if bbNeuronCode.Down
          then PasteByNeuron
          else PasteByVendor;

        bbVerify.Enabled:=True;
     finally
        cxGridTable.EndUpdate;
     end;
end;

procedure TfrmBonusGoodsImportGoodsDlg.Prepare;
begin
     pcPageControl.ActivePage:=tbsGoods;
     deDATA1.EditValue:=NOW;
     deDATA2.EditValue:=NOW+30;
     lcbCurrency.EditValue:=840;
     bbVerify.Enabled:=False;
     GoodsCodeSourceChanged;
     dmDB.IBCQueryCurrency.Active:=True;
end;

procedure TfrmBonusGoodsImportGoodsDlg.VerifyByNeuronCode;
var i:integer;
    Query:TIBCQuery;
begin
     cxGridTable.BeginUpdate;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT GOODSID, TITLE FROM TS_GOODS WHERE GOODSID=:ID AND FLG_FOLDER=0';
        for i := 0 to cxGridTable.DataController.RecordCount-1 do
        begin
             Query.Close;
             Query.ParamByName('ID').AsInteger:=cxGridTable.DataController.Values[i,cxGridTable_NCODE.Index];
             Query.ExecSQL;
             if Query.Eof then
             begin
                  // not found
                  cxGridTable.DataController.Values[i,cxGridTable_STATUS.Index]:='не найден';
                  cxGridTable.DataController.Values[i,cxGridTable_STATUSCODE.Index]:=1; // red
             end
             else
             begin
                  // exists
                  cxGridTable.DataController.Values[i,cxGridTable_TITLE.Index]:=Query.Fields[1].AsString;
                  cxGridTable.DataController.Values[i,cxGridTable_STATUS.Index]:='ok';
                  cxGridTable.DataController.Values[i,cxGridTable_STATUSCODE.Index]:=0;
             end;
        end;
     finally
        Query.Free;
        cxGridTable.EndUpdate;
     end;
end;

procedure TfrmBonusGoodsImportGoodsDlg.VerifyByVendorCode;
var i,j,goodsCount,N:integer;
    Query:TIBCQuery;
begin
     cxGridTable.BeginUpdate;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Add('SELECT TOTAL_GOODS, T1.GOODSID, G.TITLE FROM');
        Query.SQL.Add('(SELECT');
        Query.SQL.Add('(SELECT COUNT(GOODSID) FROM TS_GOODS_FOREIGN WHERE GOODS_CODE=:CODE) TOTAL_GOODS,');
        Query.SQL.Add('(SELECT FIRST 1 GOODSID FROM TS_GOODS_FOREIGN WHERE GOODS_CODE=:CODE) GOODSID');
        Query.SQL.Add('FROM RDB$DATABASE) T1');
        Query.SQL.Add('LEFT OUTER JOIN TS_GOODS G ON G.GOODSID=T1.GOODSID');

        for i := 0 to cxGridTable.DataController.RecordCount-1 do
        begin
             Query.Close;
             Query.ParamByName('CODE').AsString:=cxGridTable.DataController.Values[i,cxGridTable_VCODE.Index];
             Query.ExecSQL;
             goodsCount:=Query.Fields[0].AsInteger;
             if goodsCount<=0 then
             begin
                  // not found
                  cxGridTable.DataController.Values[i,cxGridTable_STATUS.Index]:='не найден';
                  cxGridTable.DataController.Values[i,cxGridTable_STATUSCODE.Index]:=1; // red
             end
             else
             if (goodsCount>1) then
             begin
                  // too much
                  cxGridTable.DataController.Values[i,cxGridTable_STATUS.Index]:='найдено больше одного';
                  cxGridTable.DataController.Values[i,cxGridTable_STATUSCODE.Index]:=1; // red
             end
             else
             begin
                  // found one
                  cxGridTable.DataController.Values[i,cxGridTable_NCODE.Index]:=Query.Fields[1].AsInteger;
                  cxGridTable.DataController.Values[i,cxGridTable_TITLE.Index]:=Query.Fields[2].AsString;
                  cxGridTable.DataController.Values[i,cxGridTable_STATUS.Index]:='ok';
                  cxGridTable.DataController.Values[i,cxGridTable_STATUSCODE.Index]:=0;
             end;
        end;
        Query.Close;

        // verificam daca codurile fantastic se repeta
        for i := 0 to cxGridTable.DataController.RecordCount-2 do
        if (cxGridTable.DataController.Values[i,cxGridTable_STATUSCODE.Index]=0) then
        begin
             N:=cxGridTable.DataController.Values[i,cxGridTable_NCODE.Index];

             for j := i+1 to cxGridTable.DataController.RecordCount-1 do
             if (cxGridTable.DataController.Values[J,cxGridTable_STATUSCODE.Index]=0) then
             begin
                  if cxGridTable.DataController.Values[J,cxGridTable_NCODE.Index]=N then
                  begin
                       cxGridTable.DataController.Values[i,cxGridTable_STATUS.Index]:='повторяется';
                       cxGridTable.DataController.Values[i,cxGridTable_STATUSCODE.Index]:=1; // red
                       cxGridTable.DataController.Values[j,cxGridTable_STATUS.Index]:='повторяется';
                       cxGridTable.DataController.Values[j,cxGridTable_STATUSCODE.Index]:=1; // red
                  end;
             end;
        end;
     finally
        Query.Free;
        cxGridTable.EndUpdate;
     end;

end;

function TfrmBonusGoodsImportGoodsDlg.VerifyInputData: Boolean;
var Errors:String;
    i,Count:Integer;
begin
     Result:=False;
     Errors:='';
     // numaram kite produse bune sunt pentru import
     Count:=0;
     for i := 0 to cxGridTable.DataController.RecordCount-1 do
     if (cxGridTable.DataController.Values[i,cxGridTable_STATUSCODE.Index]=0) then Inc(Count);
     if (Count=0) then AddErrorToStr(Errors,'Нет товаров для импорта!');

     // perioada
     if VarIsNull(deDATA1.EditValue) or VarIsNull(deDATA2.EditValue) then AddErrorToStr(Errors,'Период действия бонусов!')
     else
     begin
          if (deDATA2.EditValue<deDATA1.EditValue) then AddErrorToStr(Errors,'Дата окончания менше даты начало!')
     end;

     if Not (rbFixedSum.Checked or rbPercent.Checked) then AddErrorToStr(Errors,'Тип бонуса!')
     else
     begin
          if rbFixedSum.Checked then
          begin
               if VarIsNull(edSUMA_BONUS.EditValue) or (edSUMA_BONUS.EditValue<=0) then AddErrorToStr(Errors,'Сумма бонуса!');
               if VarIsNull(lcbCurrency.EditValue) or (lcbCurrency.EditValue<=0) then AddErrorToStr(Errors,'Валюта суммы бонуса!');
          end
          else
          if rbPercent.Checked then
          begin
               if VarIsNull(edPERCENT_BONUS.EditValue) or (edPERCENT_BONUS.EditValue<=0) or (edPERCENT_BONUS.EditValue>100) then AddErrorToStr(Errors,'Процент бонуса!');
          end;
     end;

     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

end.

