unit frmRealizatiaGoodsToAddDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, DB, IBC, cxGraphics, Menus, cxLookAndFeelPainters,
  StdCtrls, cxButtons, cxButtonEdit, frameGoodsStockUnit, cxDBLabel, cxDBEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxDropDownEdit, cxTextEdit, cxMaskEdit, cxCalc, cxCheckBox, cxPC, cxControls, cxContainer, cxEdit, ExtCtrls, cxTL,
  DialogTitle, cxStyles, cxLabel, cxCurrencyEdit, cxLookAndFeels;

type

  TVerifyGoodsExistsProc = function(const GoodsID:integer):Boolean of object;

  TfrmRealizatiaGoodsToAddDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    beGoods: TcxButtonEdit;
    edGOODSID: TcxDBTextEdit;
    edQTY: TcxDBMaskEdit;
    lbQTY: TLabel;
    imgWarning: TImage;
    lbGoodsExistsWarning: TLabel;
    Label1: TLabel;
    lbCURRENCY_NAME: TcxDBLabel;
    edPRICE: TcxDBCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beGoodsDblClick(Sender: TObject);
    procedure frameGoodsStockcxTreeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode;
      var AStyle: TcxStyle);
  private
    { Private declarations }
    fAddNewGoods: Boolean;
    FOnVerifyGoodsExists: TVerifyGoodsExistsProc;

    fAutoOpenGoodsBrowser: Boolean;

    procedure SetAddNewGoods(const Value: Boolean);
    function CheckParams:Boolean;
    procedure ShowSelectGoodsDialog;

    procedure SetOnVerifyGoodsExists(const Value: TVerifyGoodsExistsProc);
    procedure CheckIfGoodsExists(const GoodsID:integer);

    procedure SetAutoOpenGoodsBrowser(const Value: Boolean);

    function GoodsHasSNPNNumbers:Boolean;

  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

  public
    { Public declarations }
    property AddNewGoods:Boolean read FAddNewGoods write SetAddNewGoods;
    property AutoOpenGoodsBrowser:Boolean read fAutoOpenGoodsBrowser write SetAutoOpenGoodsBrowser;
    property OnVerifyGoodsExists:TVerifyGoodsExistsProc read FOnVerifyGoodsExists write SetOnVerifyGoodsExists;
  end;


implementation

uses DataModuleAdditions, SWNUtils, SWNConst, DataModuleDB, SWNTypes, frmGoods, SWNValueStorageUnit;

{$R *.dfm}

{ TfrmConfigurationSelectGoodsDlg }

procedure TfrmRealizatiaGoodsToAddDlg.beGoodsDblClick(Sender: TObject);
begin
     ShowSelectGoodsDialog;
end;

procedure TfrmRealizatiaGoodsToAddDlg.beGoodsPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
     ShowSelectGoodsDialog;
end;

procedure TfrmRealizatiaGoodsToAddDlg.CheckIfGoodsExists(const GoodsID:integer);
var Exists:Boolean;
begin
     Exists:=False;
     try
        if Assigned(FOnVerifyGoodsExists) then Exists:=FOnVerifyGoodsExists(GoodsID);
     finally
        lbGoodsExistsWarning.Visible:=Exists;
        imgWarning.Visible:=Exists;
     end;
end;

function TfrmRealizatiaGoodsToAddDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     Result:=False;

     with fMasterDataSet do
     begin
          if FieldByName('GOODSID').isNull then AddErrorToStr(ErrorStr,'Товар не выбран!');
          if (FieldByName('QTY').isNull) or (FieldByName('QTY').AsFloat<=0) then AddErrorToStr(ErrorStr,'Количество не указанно!');
          if (FieldByName('PRICE').isNull) or (FieldByName('PRICE').AsFloat<=0) then AddErrorToStr(ErrorStr,'Цена не указанна!');
     end;
     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmRealizatiaGoodsToAddDlg.FormCreate(Sender: TObject);
begin
     FOnVerifyGoodsExists := nil;
     fAutoOpenGoodsBrowser := True;
     fAddNewGoods:=False;

     lbGoodsExistsWarning.Visible:=False;
     imgWarning.Visible:=False;
end;

procedure TfrmRealizatiaGoodsToAddDlg.frameGoodsStockcxTreeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn;
  ANode: TcxTreeListNode; var AStyle: TcxStyle);
begin
     if ANode.Values[1]>0 then AStyle:=dmAdditions.cxStyle_Bold;
end;

function TfrmRealizatiaGoodsToAddDlg.GoodsHasSNPNNumbers: Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;
        Query.SQL.Add('SELECT');
        Query.SQL.Add('IIF(');
        Query.SQL.Add('EXISTS(SELECT SN FROM TDB_SN_R');
        Query.SQL.Add('WHERE DOCID=:DOCID AND GOODSID=:GOODSID)');
        Query.SQL.Add('OR');
        Query.SQL.Add('EXISTS(SELECT PARTNO FROM TDB_PARTS_R');
        Query.SQL.Add('WHERE DOCID=:DOCID AND GOODSID=:GOODSID)');
        Query.SQL.Add(',1,0)');
        Query.SQL.Add('FROM RDB$DATABASE');
        // params
        Query.ParamByName('DOCID').AsInteger:=fMasterDataSet.FieldByName('DOCID').AsInteger;
        Query.ParamByName('GOODSID').AsInteger:=fMasterDataSet.FieldByName('GOODSID').AsInteger;
        // exec
        Query.ExecSQL;
        if Not Query.Eof then Result:=Query.Fields[0].AsInteger=1;
     finally
        Query.Free;
     end;
end;

procedure TfrmRealizatiaGoodsToAddDlg.BindingDataSource;
begin
     edGOODSID.DataBinding.DataSource:=fMasterDataSource;
     edQTY.DataBinding.DataSource:=fMasterDataSource;
     edPRICE.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmRealizatiaGoodsToAddDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;

          AppUserTempConfigStorage.IntValues.SetValue(Owner.Name+'_LastSelectedGoodsID',fMasterDataSet.FieldByName('GOODSID').asInteger);

          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmRealizatiaGoodsToAddDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FAddNewGoods then
        begin
             dtDialogTitle.Text:='Выбор нового товара для добавления';
             fMasterDataSet.Append;

             // default values
             fMasterDataSet.FieldByName('QTY').asFloat:=1;
             fMasterDataSet.FieldByName('PRICE').asFloat:=0;
        end
        else
        begin
             dtDialogTitle.Text:='Изменение товара для конфигурации';

             // verificam daca produsul dat are numere de serii, daca are, se interzice modificarea depozitului
             if GoodsHasSNPNNumbers then
             begin
                  beGoods.Enabled:=False;
                  imgWarning.Visible:=True;
                  lbGoodsExistsWarning.Visible:=True;
                  lbGoodsExistsWarning.Caption:='Есть серийки или партийки!';
             end;

             fMasterDataSet.Edit;
        end;

        beGoods.Text:=fMasterDataSet.FieldByName('GOODS_TITLE').asString;

        if fAutoOpenGoodsBrowser and fMasterDataSet.FieldByName('GOODSID').IsNull then
        begin
             ShowSelectGoodsDialog;
             if fMasterDataSet.FieldByName('GOODSID').IsNull then
             begin
                  ModalResult:=mrCancel; // force to close dialog
                  WhenCancelForm; // rollback transaction
             end;
        end;

     except
        if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmRealizatiaGoodsToAddDlg.SetAddNewGoods(const Value: Boolean);
begin
     FAddNewGoods := Value;
end;

procedure TfrmRealizatiaGoodsToAddDlg.SetAutoOpenGoodsBrowser(const Value: Boolean);
begin
     fAutoOpenGoodsBrowser := Value;
end;

procedure TfrmRealizatiaGoodsToAddDlg.SetOnVerifyGoodsExists(const Value: TVerifyGoodsExistsProc);
begin
     FOnVerifyGoodsExists := Value;
end;

procedure TfrmRealizatiaGoodsToAddDlg.ShowSelectGoodsDialog;
var dialog:TfrmGoodsBrowser;
    N:integer;
    tmpRate:double;
    tmpPrice:Currency;
begin
     dialog:=TfrmGoodsBrowser.Create(Parent);
     try
        N:=AppUserTempConfigStorage.IntValues.GetValue(Owner.Name+'_LastSelectedGoodsID',-1);
        if Not fMasterDataSet.FieldByName('GOODSID').IsNull then N:=fMasterDataSet.FieldByName('GOODSID').asInteger;

        if dialog.SelectGoods(N,False) then
        begin
             // check if exists
             if fMasterDataSet.FieldByName('GOODSID').asInteger<>dialog.GoodsID then CheckIfGoodsExists(dialog.GoodsID);
             fMasterDataSet.FieldByName('GOODSID').asInteger:=dialog.GoodsID;
             beGoods.Text:=dialog.GoodsTitle;
             if fMasterDataSet.FieldByName('QTY').IsNull or (fMasterDataSet.FieldByName('QTY').asFloat<=0)
                then fMasterDataSet.FieldByName('QTY').asFloat:=1;

             // transformam pretul orifginal a marfei in valuta documentului in dependenta de FLG_ACNT
             tmpRate:=dmDB.IBCQueryDocs.FieldByName('RATE').asFloat;

             if Not dmDB.TransformCurrency1(dialog.GoodsPrice[0],dialog.GoodsPriceCurrencyID,
                    dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger,
                    dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').asInteger=1,tmpPrice,tmpRate,True,True,True)
               then tmpPrice:=dialog.GoodsPrice[0];

             fMasterDataSet.FieldByName('PRICE').asCurrency:=tmpPrice;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmRealizatiaGoodsToAddDlg.WhenCancelForm;
begin
     if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
