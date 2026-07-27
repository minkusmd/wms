unit frmMarketingActiuneEditorDialog;

interface

uses
  DBAccess, DialogTitle, IBC, MemDS, SWNBaseUnit, cxButtonEdit, cxCalc, cxCalendar, cxCheckBox, cxCheckListBox, cxClasses,
  cxContainer, cxControls, cxCustomData, cxCustomListBox, cxDBCheckListBox, cxDBData, cxDBEdit, cxDBLookupComboBox,
  cxDBLookupEdit, cxData, cxDataControllerConditionalFormattingRulesManagerDialog, cxDataStorage, cxDropDownEdit, cxEdit,
  cxFilter, cxGraphics, cxGrid, cxGridCustomTableView, cxGridCustomView, cxGridDBTableView, cxGridLevel, cxGridTableView,
  cxLabel, cxLookAndFeelPainters, cxLookAndFeels, cxLookupEdit, cxMaskEdit, cxMemo, cxNavigator, cxPC, cxPCdxBarPopupMenu,
  cxStyles, cxTextEdit, dxBar, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,

  Data.DB,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,

  Winapi.Messages,
  Winapi.Windows;

type
  TfrmMarketingActiuneEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pcPageControl: TcxPageControl;
    tbsGeneral: TcxTabSheet;
    tbsTriggers: TcxTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    deSTART_DATE: TcxDBDateEdit;
    edTITLE: TcxDBTextEdit;
    mmDESCRIPTION: TcxDBMemo;
    deEND_DATE: TcxDBDateEdit;
    clbWEEK_DAYS: TcxDBCheckListBox;
    cbFLG_ENABLED: TcxDBCheckBox;
    Label16: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    Label17: TLabel;
    cbFLG_CLIENT: TcxDBCheckBox;
    cbFLG_CLIENT_CARD: TcxDBCheckBox;
    cbFLG_CLIENT_DEALER: TcxDBCheckBox;
    Label18: TLabel;
    cbFLG_POST_RC: TcxDBCheckBox;
    btnOk: TButton;
    Button2: TButton;
    cxTabSheet1: TcxTabSheet;
    Label20: TLabel;
    clbFirme: TcxDBCheckListBox;
    cxTabSheet2: TcxTabSheet;
    Label21: TLabel;
    bePROMO_GOODS_GROUP_ID: TcxButtonEdit;
    Label22: TLabel;
    cxPageControl1: TcxPageControl;
    cxTabSheet3: TcxTabSheet;
    cbFLG_DIST_CNT: TcxDBCheckBox;
    Label5: TLabel;
    ceDIST_CNT_VALUE: TcxDBCalcEdit;
    Label7: TLabel;
    beDIST_CNT_GROUP_ID: TcxButtonEdit;
    Label6: TLabel;
    cxTabSheet4: TcxTabSheet;
    cbFLG_SINGLE_QTY: TcxDBCheckBox;
    ceSINGLE_QTY_VALUE: TcxDBCalcEdit;
    Label8: TLabel;
    cxTabSheet5: TcxTabSheet;
    cbFLG_TOTAL_QTY: TcxDBCheckBox;
    ceTOTAL_QTY_VALUE: TcxDBCalcEdit;
    Label12: TLabel;
    beTOTAL_QTY_GROUP_ID: TcxButtonEdit;
    Label11: TLabel;
    cxTabSheet6: TcxTabSheet;
    ceTOTAL_SUM_VALUE: TcxDBCalcEdit;
    beTOTAL_SUM_GROUP_ID: TcxButtonEdit;
    cbFLG_TOTAL_SUM: TcxDBCheckBox;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Panel1: TPanel;
    cbFLG_Qty_Discount: TcxDBCheckBox;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1_QTY: TcxGridDBColumn;
    cxGrid1DBTableView1_DiscountPercent: TcxGridDBColumn;
    cxGrid1DBTableView1_DiscountValue: TcxGridDBColumn;
    Label23: TLabel;
    cxPageControl2: TcxPageControl;
    tbsDiscount: TcxTabSheet;
    tbsFixedAmount: TcxTabSheet;
    tbsGoods: TcxTabSheet;
    ceDISCOUNT: TcxDBCalcEdit;
    Label19: TLabel;
    ceDiscountAmount: TcxDBCalcEdit;
    Label24: TLabel;
    Label25: TLabel;
    ceCurrency: TcxButtonEdit;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGrid2DBTableView1Column1: TcxGridDBColumn;
    cxGrid2DBTableView1Column2: TcxGridDBColumn;
    dxBarDockControl3: TdxBarDockControl;
    bbNewGoods: TdxBarButton;
    bbDelete: TdxBarButton;
    dxBarManager1Bar2: TdxBar;
    cxGrid2DBTableView1Column3: TcxGridDBColumn;
    cxGrid2DBTableView1Column4: TcxGridDBColumn;
    cxTabSheet7: TcxTabSheet;
    cxTabSheet8: TcxTabSheet;
    bbNewDiscountRange: TdxBarButton;
    bbDeleteDiscountRange: TdxBarButton;
    cbDiscount: TcxDBLookupComboBox;
    IBCQueryDiscountType: TIBCQuery;
    IBCDataSourceDiscountType: TIBCDataSource;
    tbsCashback: TcxTabSheet;
    Label9: TLabel;
    cxLabel1: TcxLabel;
    cxDBCalcEdit1: TcxDBCalcEdit;
    cbCashback: TcxDBCheckBox;
    Label10: TLabel;
    beCashback: TcxButtonEdit;
    Label26: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure clbFirmeCheckStatesToEditValue(Sender: TObject; const ACheckStates: TcxCheckStates; out AEditValue: Variant);
    procedure clbFirmeEditValueToCheckStates(Sender: TObject; const AEditValue: Variant; var ACheckStates: TcxCheckStates);
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beDIST_CNT_GROUP_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beTOTAL_QTY_GROUP_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beTOTAL_SUM_GROUP_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cbDiscountPropertiesChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure beCashbackPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckInputValues:Boolean;
    procedure ReadFirmeList;

    procedure SelectPromoGoods;
    procedure ClearPromoGoods;
    procedure Select_DIST_CNT_VALUE_GoodsGroup;
    procedure Select_TOTAL_QTY_VALUE_GoodsGroup;
    procedure Select_TOTAL_SUM_VALUE_GoodsGroup;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNConst, SWNUtils, System.Math , frmGoodsGroupsManagerDialog;

{ TfrmMarketingActiuneEditorDlg }

procedure TfrmMarketingActiuneEditorDlg.beCashbackPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var dialog:TfrmGoodsGroupsManagerDlg;
begin
     dialog:=TfrmGoodsGroupsManagerDlg.Create(Self);
     try
        if dialog.SelectGoodsGroup(fMasterDataSet.FieldByName('DEST_GOODS_GROUPS_ID').AsInteger) then
        begin
             fMasterDataSet.FieldByName('DEST_GOODS_GROUPS_ID').AsInteger:=dialog.GG_ID;
             beCashback.Text:=dialog.GG_Title;
        end;
     finally
        dialog.Free;
     end;
end;
procedure TfrmMarketingActiuneEditorDlg.beDIST_CNT_GROUP_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     case AButtonIndex of
     0: Select_DIST_CNT_VALUE_GoodsGroup;
     1: begin
             fMasterDataSet.FieldByName('DIST_CNT_GROUP_ID').Value:=NULL;
             beDIST_CNT_GROUP_ID.Text:='';
        end;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.beTOTAL_QTY_GROUP_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     case AButtonIndex of
     0: Select_TOTAL_QTY_VALUE_GoodsGroup;
     1: begin
             fMasterDataSet.FieldByName('TOTAL_QTY_GROUP_ID').Value:=NULL;
             beTOTAL_QTY_GROUP_ID.Text:='';
        end;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.beTOTAL_SUM_GROUP_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     case AButtonIndex of
     0: Select_TOTAL_SUM_VALUE_GoodsGroup;
     1: begin
             fMasterDataSet.FieldByName('TOTAL_SUM_GROUP_ID').Value:=NULL;
             beTOTAL_SUM_GROUP_ID.Text:='';
        end;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.cbDiscountPropertiesChange(Sender: TObject);
begin
   cxPageControl2.ActivePageIndex := cbDiscount.ItemIndex;
end;

function TfrmMarketingActiuneEditorDlg.CheckInputValues: Boolean;
var Errors:String;
begin
     Result:=False;
     Errors:='';

     if fMasterDataSet.FieldByName('DIST_CNT_VALUE').IsNull then fMasterDataSet.FieldByName('DIST_CNT_VALUE').asInteger:=0;
     if fMasterDataSet.FieldByName('SINGLE_QTY_VALUE').IsNull then fMasterDataSet.FieldByName('SINGLE_QTY_VALUE').asInteger:=0;
     if fMasterDataSet.FieldByName('TOTAL_QTY_VALUE').IsNull then fMasterDataSet.FieldByName('TOTAL_QTY_VALUE').asInteger:=0;
     if fMasterDataSet.FieldByName('TOTAL_SUM_VALUE').IsNull then fMasterDataSet.FieldByName('TOTAL_SUM_VALUE').asInteger:=0;


     if fMasterDataSet.FieldByName('TITLE').IsNull or (Trim(fMasterDataSet.FieldByName('TITLE').AsString)='') then AddErrorToStr(Errors, 'Название!');
     if fMasterDataSet.FieldByName('START_DATE').IsNull or fMasterDataSet.FieldByName('END_DATE').IsNull
        or (fMasterDataSet.FieldByName('END_DATE').AsDateTime<fMasterDataSet.FieldByName('START_DATE').AsDateTime) then AddErrorToStr(Errors, 'Дата проведения!');
     if fMasterDataSet.FieldByName('WEEK_DAYS').IsNull or (fMasterDataSet.FieldByName('WEEK_DAYS').AsInteger=0) then AddErrorToStr(Errors, 'Дни недели!');

     if fMasterDataSet.FieldByName('DISCOUNT').IsNull or
        (fMasterDataSet.FieldByName('DISCOUNT').AsFloat<=0) or
        (fMasterDataSet.FieldByName('DISCOUNT').AsFloat>=100) then AddErrorToStr(Errors, 'Скидка!');

     if Not ((fMasterDataSet.FieldByName('FLG_CLIENT').AsInteger=1) or (fMasterDataSet.FieldByName('FLG_CLIENT_CARD').AsInteger=1) or (fMasterDataSet.FieldByName('FLG_CLIENT_DEALER').AsInteger=1))
       then AddErrorToStr(Errors, 'Участники акции!');

     // Количество разных товаров
     if fMasterDataSet.FieldByName('FLG_DIST_CNT').AsInteger=1 then
     begin
          if fMasterDataSet.FieldByName('DIST_CNT_VALUE').IsNull or (fMasterDataSet.FieldByName('DIST_CNT_VALUE').AsInteger<=0) then AddErrorToStr(Errors, 'Количество разных товаров!');
     end;
     // Количество товара
     if fMasterDataSet.FieldByName('FLG_SINGLE_QTY').AsInteger=1 then
     begin
          if fMasterDataSet.FieldByName('SINGLE_QTY_VALUE').IsNull or (fMasterDataSet.FieldByName('SINGLE_QTY_VALUE').AsInteger<=0) then AddErrorToStr(Errors, 'Количество товара!');
     end;
     // Общее количество товара в реализации
     if fMasterDataSet.FieldByName('FLG_TOTAL_QTY').AsInteger=1 then
     begin
          if fMasterDataSet.FieldByName('TOTAL_QTY_VALUE').IsNull or (fMasterDataSet.FieldByName('TOTAL_QTY_VALUE').AsInteger<=0) then AddErrorToStr(Errors, 'Общее количество товара!');
     end;
     // Сумма реализации
     if fMasterDataSet.FieldByName('FLG_TOTAL_SUM').AsInteger=1 then
     begin
          if fMasterDataSet.FieldByName('TOTAL_SUM_VALUE').IsNull or (fMasterDataSet.FieldByName('TOTAL_SUM_VALUE').AsInteger<=0) then AddErrorToStr(Errors, 'Сумма реализации!');
     end;

     if Not ((fMasterDataSet.FieldByName('FLG_DIST_CNT').AsInteger=1) or
             (fMasterDataSet.FieldByName('FLG_SINGLE_QTY').AsInteger=1) or
             (fMasterDataSet.FieldByName('FLG_TOTAL_QTY').AsInteger=1) or
             (fMasterDataSet.FieldByName('FLG_TOTAL_SUM').AsInteger=1))
       then AddErrorToStr(Errors, 'Триггер акции!');


     if fMasterDataSet.FieldByName('SELECTED_FIRME').IsNull or (Trim(fMasterDataSet.FieldByName('SELECTED_FIRME').AsString)='') then AddErrorToStr(Errors, 'Фирмы которые участвуют в акции!');


     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure TfrmMarketingActiuneEditorDlg.clbFirmeCheckStatesToEditValue(Sender: TObject; const ACheckStates: TcxCheckStates;
  out AEditValue: Variant);
var i:integer;
    S:String;
begin
     S:='';
     for i:=0 to clbFirme.Items.Count-1 do
     if clbFirme.Items[i].Checked then
     begin
          if S<>'' then S:=S+',';
          S:=S+IntToStr(clbFirme.Items[i].Tag);
     end;
     AEditValue:=S;
end;

procedure TfrmMarketingActiuneEditorDlg.clbFirmeEditValueToCheckStates(Sender: TObject; const AEditValue: Variant;
  var ACheckStates: TcxCheckStates);
var S:String;
    i:integer;
begin
     if VarIsStr(AEditValue) then
     begin
          S:=AEditValue;
          for i:=0 to clbFirme.Items.Count-1 do
          begin
               ACheckStates[i]:=cbsUnchecked;
               if Pos(IntToStr(clbFirme.Items[i].Tag),S)>0 then ACheckStates[i]:=cbsChecked;
          end;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.ClearPromoGoods;
begin
     fMasterDataSet.FieldByName('PROMO_GOODS_GROUP_ID').Value:=NULL;
     bePROMO_GOODS_GROUP_ID.Text:='';
end;

procedure TfrmMarketingActiuneEditorDlg.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     case AButtonIndex of
     0: SelectPromoGoods;
     1: ClearPromoGoods;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.FormClose(Sender: TObject; var Action:
    TCloseAction);
begin
   IBCQueryDiscountType.Close;
end;

procedure TfrmMarketingActiuneEditorDlg.FormDestroy(Sender: TObject);
begin
     dmDB.IBCQueryAnalytics.Close;
end;

procedure TfrmMarketingActiuneEditorDlg.BindingDataSource;
begin

     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     mmDESCRIPTION.DataBinding.DataSource:=fMasterDataSource;
     ceDISCOUNT.DataBinding.DataSource:=fMasterDataSource;
     ceDiscountAmount.DataBinding.DataSource:=fMasterDataSource;

     cbFLG_ENABLED.DataBinding.DataSource:=fMasterDataSource;
     deSTART_DATE.DataBinding.DataSource:=fMasterDataSource;
     deEND_DATE.DataBinding.DataSource:=fMasterDataSource;
     clbWEEK_DAYS.DataBinding.DataSource:=fMasterDataSource;
     lcbAnalytics.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_CLIENT.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_CLIENT_CARD.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_CLIENT_DEALER.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_POST_RC.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_DIST_CNT.DataBinding.DataSource:=fMasterDataSource;
     ceDIST_CNT_VALUE.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_SINGLE_QTY.DataBinding.DataSource:=fMasterDataSource;
     ceSINGLE_QTY_VALUE.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_TOTAL_QTY.DataBinding.DataSource:=fMasterDataSource;
     ceTOTAL_QTY_VALUE.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_TOTAL_SUM.DataBinding.DataSource:=fMasterDataSource;
     ceTOTAL_SUM_VALUE.DataBinding.DataSource:=fMasterDataSource;
     clbFirme.DataBinding.DataSource:=fMasterDataSource;
     cbDiscount.DataBinding.DataSource:=fMasterDataSource;
     cbCashback.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmMarketingActiuneEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputValues then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.Prepare;
begin
     pcPageControl.ActivePage:=tbsGeneral;
     ReadFirmeList;

     dmDB.IBCQueryAnalytics.ParamByName('doctype').AsInteger:=107;
     dmDB.IBCQueryAnalytics.Open;
     IBCQueryDiscountType.Open;
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Создание новой акции';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('START_DATE').AsDateTime:=NOW;
             fMasterDataSet.FieldByName('END_DATE').AsDateTime:=NOW;
             fMasterDataSet.FieldByName('WEEK_DAYS').AsInteger:=127;
             fMasterDataSet.FieldByName('DISCOUNT').AsInteger:=0;
             fMasterDataSet.FieldByName('ANALITICA_ID').AsInteger:=-1;
             fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger:=0;
             fMasterDataSet.FieldByName('FLG_DIST_CNT').AsInteger:=0;
             fMasterDataSet.FieldByName('DIST_CNT_VALUE').AsInteger:=0;
             fMasterDataSet.FieldByName('FLG_SINGLE_QTY').AsInteger:=0;
             fMasterDataSet.FieldByName('SINGLE_QTY_VALUE').AsInteger:=0;
             fMasterDataSet.FieldByName('FLG_TOTAL_QTY').AsInteger:=0;
             fMasterDataSet.FieldByName('TOTAL_QTY_VALUE').AsInteger:=0;
             fMasterDataSet.FieldByName('FLG_TOTAL_SUM').AsInteger:=0;
             fMasterDataSet.FieldByName('TOTAL_SUM_VALUE').AsInteger:=0;
             fMasterDataSet.FieldByName('FLG_CLIENT').AsInteger:=1;
             fMasterDataSet.FieldByName('FLG_CLIENT_CARD').AsInteger:=1;
             fMasterDataSet.FieldByName('FLG_CLIENT_DEALER').AsInteger:=1;
             fMasterDataSet.FieldByName('FLG_POST_RC').AsInteger:=0;
        end
        else
        begin
             dtDialogTitle.Text:='Изменение записи';
             fMasterDataSet.Edit;

             bePROMO_GOODS_GROUP_ID.Text:=fMasterDataSet.FieldByName('PROMO_GOODS_GROUP_TITLE').AsString;

             beCashback.Text := fMasterDataSet.FieldByName('DEST_GOODS_GROUPS_TITLE').AsString;
             beCashback.Tag  := fMasterDataSet.FieldByName('DEST_GOODS_GROUPS_ID').AsInteger;

             beDIST_CNT_GROUP_ID.Text:=fMasterDataSet.FieldByName('DIST_CNT_GROUP_TITLE').AsString;
             beTOTAL_QTY_GROUP_ID.Text:=fMasterDataSet.FieldByName('TOTAL_QTY_GROUP_TITLE').AsString;
             beTOTAL_SUM_GROUP_ID.Text:=fMasterDataSet.FieldByName('TOTAL_SUM_GROUP_TITLE').AsString;
        end;
     except
        fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.ReadFirmeList;
var item:TcxCheckListBoxItem;
begin
     clbFirme.Items.BeginUpdate;
     try
        dmDB.IBCQueryFirms.Open;
        while Not dmDB.IBCQueryFirms.Eof do
        begin
             item:=clbFirme.Items.Add;
             item.Text:=dmDB.IBCQueryFirms.FieldByName('DISPLAYNAME').AsString;
             item.Tag:=dmDB.IBCQueryFirms.FieldByName('CUSTOMERID').AsInteger;
             item.ImageIndex:=11;
             dmDB.IBCQueryFirms.Next;
        end;
        dmDB.IBCQueryFirms.Close;
     finally
        clbFirme.Items.EndUpdate;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.SelectPromoGoods;
var dialog:TfrmGoodsGroupsManagerDlg;
begin
     dialog:=TfrmGoodsGroupsManagerDlg.Create(Self);
     try
        if dialog.SelectGoodsGroup(fMasterDataSet.FieldByName('PROMO_GOODS_GROUP_ID').AsInteger) then
        begin
             fMasterDataSet.FieldByName('PROMO_GOODS_GROUP_ID').AsInteger:=dialog.GG_ID;
             bePROMO_GOODS_GROUP_ID.Text:=dialog.GG_Title;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.Select_DIST_CNT_VALUE_GoodsGroup;
var dialog:TfrmGoodsGroupsManagerDlg;
begin
     dialog:=TfrmGoodsGroupsManagerDlg.Create(Self);
     try
        if dialog.SelectGoodsGroup(fMasterDataSet.FieldByName('DIST_CNT_GROUP_ID').AsInteger) then
        begin
             fMasterDataSet.FieldByName('DIST_CNT_GROUP_ID').AsInteger:=dialog.GG_ID;
             beDIST_CNT_GROUP_ID.Text:=dialog.GG_Title;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.Select_TOTAL_QTY_VALUE_GoodsGroup;
var dialog:TfrmGoodsGroupsManagerDlg;
begin
     dialog:=TfrmGoodsGroupsManagerDlg.Create(Self);
     try
        if dialog.SelectGoodsGroup(fMasterDataSet.FieldByName('TOTAL_QTY_GROUP_ID').AsInteger) then
        begin
             fMasterDataSet.FieldByName('TOTAL_QTY_GROUP_ID').AsInteger:=dialog.GG_ID;
             beTOTAL_QTY_GROUP_ID.Text:=dialog.GG_Title;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.Select_TOTAL_SUM_VALUE_GoodsGroup;
var dialog:TfrmGoodsGroupsManagerDlg;
begin
     dialog:=TfrmGoodsGroupsManagerDlg.Create(Self);
     try
        if dialog.SelectGoodsGroup(fMasterDataSet.FieldByName('TOTAL_SUM_GROUP_ID').AsInteger) then
        begin
             fMasterDataSet.FieldByName('TOTAL_SUM_GROUP_ID').AsInteger:=dialog.GG_ID;
             beTOTAL_SUM_GROUP_ID.Text:=dialog.GG_Title;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmMarketingActiuneEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmMarketingActiuneEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

