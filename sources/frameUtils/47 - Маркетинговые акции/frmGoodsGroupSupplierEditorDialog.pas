unit frmGoodsGroupSupplierEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, SWNBaseUnit, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.StdCtrls, cxGroupBox,
  cxRadioGroup, cxDBEdit, Data.DB, DBAccess, IBC, MemDS, cxButtonEdit;

type

  TfrmGoodsGroupSupplierEditorVerifySupplierExistsEvent = procedure(const SupplierID:Integer; var Exists:Boolean) of object;

  TfrmGoodsGroupSupplierEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    rgFLG_EXCLUDE: TcxDBRadioGroup;
    btnCancel: TButton;
    btnOk: TButton;
    beSupplier: TcxButtonEdit;
    procedure beDIST_CNT_GROUP_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    FGGID: Integer;
    FOnVerifySupplierExists: TfrmGoodsGroupSupplierEditorVerifySupplierExistsEvent;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues:Boolean;
    procedure SetGGID(const Value: Integer);
    procedure SetOnVerifySupplierExists(const Value:
        TfrmGoodsGroupSupplierEditorVerifySupplierExistsEvent);
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
    property GGID:Integer read FGGID write SetGGID;
    property OnVerifySupplierExists:
        TfrmGoodsGroupSupplierEditorVerifySupplierExistsEvent read
        FOnVerifySupplierExists write SetOnVerifySupplierExists;
  end;


implementation

{$R *.dfm}

uses DataModuleDB, SWNConst, SWNUtils, frmCustomersDlg;

{ TfrmGoodsGroupVendorEditorDlg }

procedure TfrmGoodsGroupSupplierEditorDlg.beDIST_CNT_GROUP_IDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  if AButtonIndex = 0 then
  begin
     dialog := TfrmCustomersDlg.Create(Self);
     try
       //dialog.CustomFilter:=dialog.CustomFilter;   // Gheorghian, 28.03.2011
       if dialog.SelectCustomer(fMasterDataSet.FieldByName('SUPPLIERID').AsInteger, False, 0, 'Alege furnizorul') then
       begin
         fMasterDataSet.FieldByName('SupplierID').asInteger := dialog.CustomerID;
         beSupplier.Text := dialog.CustomerTitle;
       end;
     finally
       dialog.Free;
     end;
  end;
end;
function TfrmGoodsGroupSupplierEditorDlg.CheckValues: Boolean;
var Error:String;
    exists:Boolean;
begin
     Result:=False;
     Error:='';

     if fMasterDataSet.FieldByName('SUPPLIERID').IsNull or (fMasterDataSet.FieldByName('SUPPLIERID').AsInteger<=0)
       then AddErrorToStr(Error,'Furnizor!');

     if Assigned(FOnVerifySupplierExists) then
     begin
          FOnVerifySupplierExists(fMasterDataSet.FieldByName('SUPPLIERID').AsInteger,exists);
          if exists then AddErrorToStr(Error,'Acest furnizor este deja in lista!');
     end;

     if Error='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Error);
end;

procedure TfrmGoodsGroupSupplierEditorDlg.BindingDataSource;
begin
     rgFLG_EXCLUDE.DataBinding.DataSource:=fMasterDataSource;
     FOnVerifySupplierExists := nil;
end;

function TfrmGoodsGroupSupplierEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          Result:=True;
     end;
end;

procedure TfrmGoodsGroupSupplierEditorDlg.Prepare;
begin
     try
        if fCreateNewRecord then
        begin
             dtDialogTitle.Text:='Inregistrare noua';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('FLG_EXCLUDE').AsInteger:=0;
             fMasterDataSet.FieldByName('GG_ID').AsInteger:=FGGID;
        end
        else
        begin
             dtDialogTitle.Text:='Modifica inregistrarea';
             fMasterDataSet.Edit;
        end;
        beSupplier.Tag := fMasterDataSet.FieldByName('SUPPLIERID').AsInteger;
        beSupplier.Text := fMasterDataSet.FieldByName('SUPPLIER_NAME').AsString;
     except
        fMasterDataSet.Cancel;
        raise;
     end;
end;

procedure TfrmGoodsGroupSupplierEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmGoodsGroupSupplierEditorDlg.SetGGID(const Value: Integer);
begin
     FGGID := Value;
end;

procedure TfrmGoodsGroupSupplierEditorDlg.SetOnVerifySupplierExists(const
    Value: TfrmGoodsGroupSupplierEditorVerifySupplierExistsEvent);
begin
     FOnVerifySupplierExists := Value;
end;

procedure TfrmGoodsGroupSupplierEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
end;

end.
