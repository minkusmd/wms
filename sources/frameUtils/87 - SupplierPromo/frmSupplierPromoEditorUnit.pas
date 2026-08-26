unit frmSupplierPromoEditorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu,
  cxContainer, cxEdit, cxMemo, cxDBEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.StdCtrls, cxPC, cxCheckListBox, cxDBCheckListBox,
  cxCheckBox, cxButtonEdit, cxCalc, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, dxBarBuiltInMenu, cxCustomListBox,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, cxClasses, dxBar, Vcl.ExtCtrls, dxDateRanges, DBAccess, IBC,
  MemDS, dxScrollbarAnnotations, cxLabel, cxImage;

type
  TfrmSupplierPromoEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pcPageControl: TcxPageControl;
    tbsGeneral: TcxTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    deSTART_DATE: TcxDBDateEdit;
    edTITLE: TcxDBTextEdit;
    deEND_DATE: TcxDBDateEdit;
    btnOk: TButton;
    Button2: TButton;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNewGoods: TdxBarButton;
    bbDelete: TdxBarButton;
    dxBarManager1Bar2: TdxBar;
    bbNewDiscountRange: TdxBarButton;
    bbDeleteDiscountRange: TdxBarButton;
    Label21: TLabel;
    bePROMO_GOODS_GROUP_ID: TcxButtonEdit;
    Label22: TLabel;
    beCT: TcxButtonEdit;
    Label2: TLabel;
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure bePROMO_GOODS_GROUP_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckInputValues:Boolean;
    procedure SelectPromoGoods;
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

uses DataModuleAdditions, DataModuleDB, SWNConst, SWNUtils, System.Math , frmGoodsGroupsManagerDialog, frmCustomersDlg;

function TfrmSupplierPromoEditorDlg.CheckInputValues: Boolean;
var Errors:String;
begin

     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

procedure TfrmSupplierPromoEditorDlg.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('SUPPLIERID').asInteger, False, 0, 'Alege furnizorul') then
    begin
      fMasterDataSet.FieldByName('SUPPLIERID').asInteger := dialog.CustomerID;
      beCT.Tag := dialog.CustomerID;
      beCT.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSupplierPromoEditorDlg.bePROMO_GOODS_GROUP_IDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  SelectPromoGoods;
end;

procedure TfrmSupplierPromoEditorDlg.BindingDataSource;
begin
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     deSTART_DATE.DataBinding.DataSource:=fMasterDataSource;
     deEND_DATE.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmSupplierPromoEditorDlg.IsFormDataPosted: Boolean;
begin
     Result := False;
     if CheckInputValues then
     begin
          if fMasterDataSet.State in dsEditModes then
            fMasterDataSet.Post;

          if fMasterDataSet.UpdateTransaction.Active then
            fMasterDataSet.UpdateTransaction.Commit;

          Result:=True;
     end;
end;

procedure TfrmSupplierPromoEditorDlg.Prepare;
begin
     pcPageControl.ActivePage:=tbsGeneral;
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewRecord then
        begin
             dtDialogTitle.Text:='Inregistrare noua';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('DATA1').AsDateTime:=NOW;
             fMasterDataSet.FieldByName('DATA2').AsDateTime:=NOW;

             bePROMO_GOODS_GROUP_ID.Text := '';
             bePROMO_GOODS_GROUP_ID.Tag := -1;

        end
        else
        begin
             dtDialogTitle.Text:='Modifica inregistrarea';
             fMasterDataSet.Edit;

             bePROMO_GOODS_GROUP_ID.Text := fMasterDataSet.FieldByName('GG_NAME').AsString;
             bePROMO_GOODS_GROUP_ID.Tag := fMasterDataSet.FieldByName('GGID').AsInteger;
             beCT.Text := fMasterDataSet.FieldByName('SUPPLIER_NAME').AsString;
             beCT.Tag := fMasterDataSet.FieldByName('SUPPLIERID').AsInteger;
        end;
     except
        fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmSupplierPromoEditorDlg.SelectPromoGoods;
var dialog:TfrmGoodsGroupsManagerDlg;
begin
     dialog := TfrmGoodsGroupsManagerDlg.Create(Self);
     try
        if dialog.SelectGoodsGroup(fMasterDataSet.FieldByName('GGID').AsInteger) then
        begin
             fMasterDataSet.FieldByName('GGID').AsInteger:=dialog.GG_ID;
             bePROMO_GOODS_GROUP_ID.Tag := fMasterDataSet.FieldByName('GGID').AsInteger;
             bePROMO_GOODS_GROUP_ID.Text:=dialog.GG_Title;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmSupplierPromoEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmSupplierPromoEditorDlg.WhenCancelForm;
begin
     if fMasterDataSet.State in dsEditModes then
       fMasterDataSet.Cancel;

     if fMasterDataSet.UpdateTransaction.Active then
       fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

