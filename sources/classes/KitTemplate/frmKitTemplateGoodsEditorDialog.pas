unit frmKitTemplateGoodsEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxDropDownEdit, cxCalc, cxDBEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, cxCheckBox,
  dxUIAClasses, dxCoreGraphics;

type
  TfrmKitTemplateGoodsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    beGoods: TcxButtonEdit;
    ceQTY: TcxDBCalcEdit;
    cbFLG_ACTIVE: TcxDBCheckBox;
    procedure beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    FCreateNewRecord: Boolean;
    { Private declarations }
    procedure SetupQtyFields;
    function CheckValues:Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure SelectGoods;
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

uses DB, DataModuleAdditions, SWNValueStorageUnit, SWNConst, SWNUtils, frmGoods;

{ TfrmKitTemplateGoodsEditorDlg }

procedure TfrmKitTemplateGoodsEditorDlg.beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectGoods;
end;

function TfrmKitTemplateGoodsEditorDlg.CheckValues: Boolean;
var Errors:String;
begin
     Result:=False;
     Errors:='';

     if fMasterDataSet.FieldByName('GOODSID').IsNull or (fMasterDataSet.FieldByName('GOODSID').asInteger<=0)
       then AddErrorToStr(Errors,'Наименование!');
     if fMasterDataSet.FieldByName('QTY').IsNull or (fMasterDataSet.FieldByName('QTY').AsFloat<=0)
       then AddErrorToStr(Errors,'Количество!');

     if (Errors='') then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure TfrmKitTemplateGoodsEditorDlg.BindingDataSource;
begin
     ceQTY.DataBinding.DataSource:=fMasterDataSource;
     cbFLG_ACTIVE.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmKitTemplateGoodsEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          if fMasterDataSet.State in dsEditModes then fMasterDataSet.Post;
          Result:=True;
     end;
end;

procedure TfrmKitTemplateGoodsEditorDlg.Prepare;
begin
     SetupQtyFields;

     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Создание новой записи';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('QTY').AsFloat:=0;
             fMasterDataSet.FieldByName('FLG_ACTIVE').AsInteger:=1;
        end
        else
        begin
             dtDialogTitle.Text:='Изменение записи';
             fMasterDataSet.Edit;
             Self.ActiveControl:=ceQTY;
        end;
        beGoods.Text:=fMasterDataSet.FieldByName('GOODS_NAME').AsString;
     except
        if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
        raise;
     end;
end;

procedure TfrmKitTemplateGoodsEditorDlg.SelectGoods;
var dialog:TfrmGoodsBrowser;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.SelectGoods(fMasterDataSet.FieldByName('GOODSID').asInteger,false,0,'Выберите товар для шаблона') then
        begin
             beGoods.Text:=dialog.GoodsTitle;
             fMasterDataSet.FieldByName('GOODSID').AsInteger:=dialog.GoodsID;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmKitTemplateGoodsEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmKitTemplateGoodsEditorDlg.SetupQtyFields;
var qtyDigitsMode:Integer;
begin
     // Numarul de zecimale in QTY :
     qtyDigitsMode:=AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits,cAppDefault_QtyDigits);
     // Товарные позиции: Кол-во
     TcxCalcEditProperties(ceQTY.Properties).DisplayFormat:=cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmKitTemplateGoodsEditorDlg.WhenCancelForm;
begin
     if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
end;

end.
