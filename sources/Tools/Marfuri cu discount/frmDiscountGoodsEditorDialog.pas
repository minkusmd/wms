unit frmDiscountGoodsEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, StdCtrls, ExtCtrls, cxDBEdit;

type
  TfrmDiscountGoodsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    beGOODS: TcxButtonEdit;
    Label2: TLabel;
    edDISCOUNT_VALUE: TcxDBTextEdit;
    lbDiscountType: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    edPRICE: TcxDBTextEdit;
    Label3: TLabel;
    procedure beGOODSPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fLastDiscountValue:integer;
    fCreateNewGoods: Boolean;
    fGoodsDiscountID: integer;
    procedure SetCreateNewGoods(const Value: Boolean);
    function CheckInputParams:Boolean;
    procedure SelectGoods;
    procedure SetGoodsDiscountID(const Value: integer);
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewGoods:Boolean read FCreateNewGoods write SetCreateNewGoods;
    property GoodsDiscountID:integer read FGoodsDiscountID write SetGoodsDiscountID;
    procedure SetDiscountType(const DiscountType:String; const LastDiscountValue:integer=0);
  end;


implementation

uses DataModuleAdditions, SWNUtils, SWNConst, frmGoods;

{$R *.dfm}

{ TfrmDiscountGoodsEditorDlg }

procedure TfrmDiscountGoodsEditorDlg.beGOODSPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     SelectGoods;
end;

function TfrmDiscountGoodsEditorDlg.CheckInputParams: Boolean;
var ErrorStr:String;
    N:integer;
begin
     Result:=False;
     ErrorStr:='';

     if fMasterDataSet.FieldByName('GOODSID').IsNull then AddErrorToStr(ErrorStr,'Marfa!');
     if fMasterDataSet.FieldByName('DISCOUNT_VALUE').IsNull then AddErrorToStr(ErrorStr,'Discount!')
     else
     begin
          N:=StrToIntDef(fMasterDataSet.FieldByName('DISCOUNT_VALUE').asString,0);
          if (N<=0) then AddErrorToStr(ErrorStr,'Discount!')
     end;

     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmDiscountGoodsEditorDlg.BindingDataSource;
begin
     fLastDiscountValue:=0;
     edPRICE.DataBinding.DataSource:=fMasterDataSource;
     edDISCOUNT_VALUE.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmDiscountGoodsEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end;
end;

procedure TfrmDiscountGoodsEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if fCreateNewGoods then
        begin
             dtDialogTitle.Text:='Creare inregistrare noua';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('GDISCOUNTID').AsInteger:=fGoodsDiscountID;
             fMasterDataSet.FieldByName('DISCOUNT_VALUE').AsInteger:=fLastDiscountValue;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare inregistrare';
             fMasterDataSet.Edit;
             beGOODS.Text:=fMasterDataSet.FieldByName('TITLE').AsString;
        end;

     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmDiscountGoodsEditorDlg.SelectGoods;
var dialog:TfrmGoodsBrowser;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.SelectGoods(fMasterDataSet.FieldByName('GOODSID').AsInteger,False,0,'Selectati marfa cu discount') then
        begin
             fMasterDataSet.FieldByName('GOODSID').AsInteger:=dialog.GoodsID;
             beGOODS.Text:=dialog.GoodsTitle;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmDiscountGoodsEditorDlg.SetCreateNewGoods(const Value: Boolean);
begin
     fCreateNewGoods := Value;
end;

procedure TfrmDiscountGoodsEditorDlg.SetDiscountType(const DiscountType: String; const LastDiscountValue:integer);
begin
     lbDiscountType.Caption:=DiscountType;
     fLastDiscountValue:=LastDiscountValue;
end;

procedure TfrmDiscountGoodsEditorDlg.SetGoodsDiscountID(const Value: integer);
begin
     fGoodsDiscountID := Value;
end;

procedure TfrmDiscountGoodsEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
