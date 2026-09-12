unit frmBonusGoodsEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, StdCtrls, cxCalc, cxDBEdit, cxDropDownEdit, cxCalendar,
  cxGroupBox, cxRadioGroup, SWNUtils, Vcl.Menus, cxButtons, SWNClasses,
  dxUIAClasses, dxCoreGraphics;

type
  TfrmBonusGoodsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    beGOODS: TcxButtonEdit;
    Label2: TLabel;
    Label3: TLabel;
    deDATA1: TcxDBDateEdit;
    deDATA2: TcxDBDateEdit;
    rgFLG_CALC_BY_SUMA: TcxDBRadioGroup;
    Label4: TLabel;
    edSUMA_BONUS: TcxDBCalcEdit;
    Label5: TLabel;
    edPERCENT_BONUS: TcxDBCalcEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure beGOODSPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    fGoodsIDList: TIntegerList;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckInputParams:Boolean;
    procedure SelectGoods;

    procedure WhenBurstAddGoods(const GoodsID:integer; const GoodsTitle:String; var Added:Boolean; var Count:integer);
    function WhenCheckIfGoodsExists(const GoodsID:integer):Boolean;

    procedure DisplayMultiGoodsTitle;

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

uses DataModuleAdditions, SWNConst, frmGoods, Math, SWNValueStorageUnit;

{$R *.dfm}

{ TfrmBonusGoodsEditorDlg }

procedure TfrmBonusGoodsEditorDlg.beGOODSPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectGoods;
end;

function TfrmBonusGoodsEditorDlg.CheckInputParams: Boolean;
var Errors:String;
begin
     Result:=False;
     Errors:='';

     if fMasterDataSet.FieldByName('GOODSID').IsNull then AddErrorToStr(Errors,'Marfa!');
     if fMasterDataSet.FieldByName('DATA1').IsNull then AddErrorToStr(Errors,'Data, inceput!');
     if fMasterDataSet.FieldByName('DATA2').IsNull then AddErrorToStr(Errors,'Data, sfarsit!');

     if (Not fMasterDataSet.FieldByName('DATA1').IsNull) and (Not fMasterDataSet.FieldByName('DATA2').IsNull)
        and (fMasterDataSet.FieldByName('DATA2').AsDateTime<=fMasterDataSet.FieldByName('DATA1').AsDateTime) then AddErrorToStr(Errors,'Este necesara o perioada de timp!');

     if fMasterDataSet.FieldByName('FLG_CALC_BY_SUMA').asInteger=1 then
     begin
          if fMasterDataSet.FieldByName('SUMA_BONUS').IsNull or (fMasterDataSet.FieldByName('SUMA_BONUS').AsFloat<=0) then AddErrorToStr(Errors,'Suma bonusului, $!');
     end
     else
     begin
          if fMasterDataSet.FieldByName('PERCENT_BONUS').IsNull or (fMasterDataSet.FieldByName('PERCENT_BONUS').AsFloat<=0) or (fMasterDataSet.FieldByName('PERCENT_BONUS').AsFloat>30)  then AddErrorToStr(Errors,'Procentul bonusului, %!');
     end;

     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure TfrmBonusGoodsEditorDlg.DisplayMultiGoodsTitle;
begin
     if fGoodsIDList.Count>1 then beGOODS.Text:=Format('Multiple marfuri: %d',[fGoodsIDList.Count]);
end;

procedure TfrmBonusGoodsEditorDlg.FormCreate(Sender: TObject);
begin
     fGoodsIDList:=TIntegerList.Create;
end;

procedure TfrmBonusGoodsEditorDlg.FormDestroy(Sender: TObject);
begin
     fGoodsIDList.Free;
end;

procedure TfrmBonusGoodsEditorDlg.BindingDataSource;
begin
     deDATA1.DataBinding.DataSource:=fMasterDataSource;
     deDATA2.DataBinding.DataSource:=fMasterDataSource;
     edSUMA_BONUS.DataBinding.DataSource:=fMasterDataSource;
     rgFLG_CALC_BY_SUMA.DataBinding.DataSource:=fMasterDataSource;
     edPERCENT_BONUS.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmBonusGoodsEditorDlg.IsFormDataPosted: Boolean;
var i:integer;
    v:Double;
    flg:integer;
    d1,d2:TDateTime;
begin
     Result:=False;
     if CheckInputParams then
     begin
          // save last DATA values
          AppUserTempConfigStorage.DateTimeValues.SetValue('BonusGoods_D1',fMasterDataSet.FieldByName('DATA1').AsDateTime);
          AppUserTempConfigStorage.DateTimeValues.SetValue('BonusGoods_D2',fMasterDataSet.FieldByName('DATA2').AsDateTime);

          fMasterDataSet.Post;
          // MultiSelection
          if fGoodsIDList.Count>1 then
          begin
               d1:=MasterDataSet.FieldByName('DATA1').AsDateTime;
               d2:=MasterDataSet.FieldByName('DATA2').AsDateTime;
               flg:=fMasterDataSet.FieldByName('FLG_CALC_BY_SUMA').AsInteger;
               if flg=1 then v:=fMasterDataSet.FieldByName('SUMA_BONUS').AsFloat
                        else v:=fMasterDataSet.FieldByName('PERCENT_BONUS').AsFloat;

               for i := 1 to fGoodsIDList.Count - 1 do
               begin
                    fMasterDataSet.Append;
                    fMasterDataSet.FieldByName('GOODSID').AsInteger:=fGoodsIDList[i];
                    fMasterDataSet.FieldByName('DATA1').AsDateTime:=d1;
                    fMasterDataSet.FieldByName('DATA2').AsDateTime:=d2;
                    fMasterDataSet.FieldByName('FLG_CALC_BY_SUMA').AsInteger:=flg;
                    fMasterDataSet.FieldByName('SUMA_BONUS').AsFloat:=v;
                    fMasterDataSet.FieldByName('PERCENT_BONUS').AsFloat:=v;
                    fMasterDataSet.Post;
               end;
          end;

          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmBonusGoodsEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if fCreateNewRecord then
        begin
             dtDialogTitle.Text:=cMSG_DIALOG_DOCUMENT_New;
             fMasterDataSet.Insert;

             fMasterDataSet.FieldByName('DATA1').AsDateTime:=AppUserTempConfigStorage.DateTimeValues.GetValue('BonusGoods_D1',NOW);
             fMasterDataSet.FieldByName('DATA2').AsDateTime:=AppUserTempConfigStorage.DateTimeValues.GetValue('BonusGoods_D2',NOW);
             fMasterDataSet.FieldByName('FLG_CALC_BY_SUMA').AsInteger:=1;
             fMasterDataSet.FieldByName('SUMA_BONUS').AsFloat:=0;
             fMasterDataSet.FieldByName('PERCENT_BONUS').AsFloat:=0;
             fMasterDataSet.FieldByName('CURRENCYID').AsInteger:=840;
        end
        else
        begin
             dtDialogTitle.Text:='Editare inregistrare';
             fMasterDataSet.Edit;
        end;
        beGOODS.Text:=fMasterDataSet.FieldByName('GOODSNAME').AsString;
     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmBonusGoodsEditorDlg.SelectGoods;
var dialog:TfrmGoodsBrowser;
    goodsID:integer;
begin
     if fMasterDataSet.FieldByName('GOODSID').IsNull
       then goodsID:=AppUserTempConfigStorage.IntValues.GetValue('BonusGoods_GOODSID')
       else goodsID:=fMasterDataSet.FieldByName('GOODSID').AsInteger;

     fGoodsIDList.Clear;

     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        dialog.BurstMode:=True;
        dialog.OnBurstAddGoods:=WhenBurstAddGoods;
        dialog.OnCheckIfGoodsExists:=WhenCheckIfGoodsExists;
        if dialog.SelectGoods(goodsID,false,0,'Selectati marfa pentru Marfuri Bonus') then
        begin
             if fGoodsIDList.Count=0 then
             begin
                  fMasterDataSet.FieldByName('GOODSID').AsInteger:=dialog.GoodsID;
                  beGOODS.Text:=dialog.GoodsTitle;
                  fGoodsIDList.Add(dialog.GoodsID);
             end
             else
             begin
                  if Not WhenCheckIfGoodsExists(dialog.GoodsID) then
                  begin
                       fGoodsIDList.Add(dialog.GoodsID);
                       DisplayMultiGoodsTitle;
                  end;
             end;
             AppUserTempConfigStorage.IntValues.SetValue('BonusGoods_GOODSID',dialog.GoodsID);
        end;
     finally
        dialog.Free;
     end;

     if fGoodsIDList.Count=0 then
     begin
          fMasterDataSet.FieldByName('GOODSID').Value:=NULL;
          beGOODS.Text:='';
     end;
end;

procedure TfrmBonusGoodsEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     fCreateNewRecord := Value;
end;

procedure TfrmBonusGoodsEditorDlg.WhenBurstAddGoods(const GoodsID: integer; const GoodsTitle: String;
  var Added: Boolean; var Count: integer);
begin
     if fGoodsIDList.Count=0 then
     begin
          fMasterDataSet.FieldByName('GOODSID').AsInteger:=GoodsID;
          beGOODS.Text:=GoodsTitle;
          fGoodsIDList.Add(GoodsID);
     end
     else
     begin
          fGoodsIDList.Add(GoodsID);
          DisplayMultiGoodsTitle;
     end;
     AppUserTempConfigStorage.IntValues.SetValue('BonusGoods_GOODSID',GoodsID);
     Added:=True;
     Count:=1;
end;

procedure TfrmBonusGoodsEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

function TfrmBonusGoodsEditorDlg.WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
var i:integer;
begin
     Result:=False;
     if fGoodsIDList.Count>0 then
     for i := 0 to fGoodsIDList.Count - 1 do
     if fGoodsIDList[i]=GoodsID then
     begin
          Result:=True;
          break;
     end;
end;

end.
