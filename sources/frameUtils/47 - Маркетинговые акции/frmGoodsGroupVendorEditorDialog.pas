unit frmGoodsGroupVendorEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, SWNBaseUnit, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.StdCtrls, cxGroupBox,
  cxRadioGroup, cxDBEdit, Data.DB, DBAccess, IBC, MemDS;

type

  TfrmGoodsGroupVendorEditorVerifyVendorExistsEvent = procedure(const VendorID:Integer; var Exists:Boolean) of object;

  TfrmGoodsGroupVendorEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    lcbVENDORID: TcxDBLookupComboBox;
    rgFLG_EXCLUDE: TcxDBRadioGroup;
    btnCancel: TButton;
    btnOk: TButton;
    IBCQueryVendor: TIBCQuery;
    IBCDataSourceVendor: TIBCDataSource;
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    FGGID: Integer;
    FOnVerifyVendorExists: TfrmGoodsGroupVendorEditorVerifyVendorExistsEvent;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues:Boolean;
    procedure SetGGID(const Value: Integer);
    procedure SetOnVerifyVendorExists(const Value: TfrmGoodsGroupVendorEditorVerifyVendorExistsEvent);
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
    property OnVerifyVendorExists:TfrmGoodsGroupVendorEditorVerifyVendorExistsEvent read FOnVerifyVendorExists write SetOnVerifyVendorExists;
  end;


implementation

{$R *.dfm}

uses DataModuleDB, SWNConst, SWNUtils;

{ TfrmGoodsGroupVendorEditorDlg }

function TfrmGoodsGroupVendorEditorDlg.CheckValues: Boolean;
var Error:String;
    exists:Boolean;
begin
     Result:=False;
     Error:='';

     if fMasterDataSet.FieldByName('VENDORID').IsNull or (fMasterDataSet.FieldByName('VENDORID').AsInteger<=0)
       then AddErrorToStr(Error,'Производитель!');

     if Assigned(FOnVerifyVendorExists) then
     begin
          FOnVerifyVendorExists(fMasterDataSet.FieldByName('VENDORID').AsInteger,exists);
          if exists then AddErrorToStr(Error,'Этот производитель уже выбран!');
     end;

     if Error='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Error);
end;

procedure TfrmGoodsGroupVendorEditorDlg.BindingDataSource;
begin
     lcbVENDORID.DataBinding.DataSource:=fMasterDataSource;
     rgFLG_EXCLUDE.DataBinding.DataSource:=fMasterDataSource;
     FOnVerifyVendorExists := nil;
end;

function TfrmGoodsGroupVendorEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          Result:=True;
     end;
end;

procedure TfrmGoodsGroupVendorEditorDlg.Prepare;
begin
     try
        if fCreateNewRecord then
        begin
             dtDialogTitle.Text:='Добавление нового производителя';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('FLG_EXCLUDE').AsInteger:=0;
             fMasterDataSet.FieldByName('GG_ID').AsInteger:=FGGID;
        end
        else
        begin
             dtDialogTitle.Text:='Изменение записи';
             fMasterDataSet.Edit;
        end;
        IBCQueryVendor.Active:=True;
     except
        fMasterDataSet.Cancel;
        raise;
     end;
end;

procedure TfrmGoodsGroupVendorEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmGoodsGroupVendorEditorDlg.SetGGID(const Value: Integer);
begin
     FGGID := Value;
end;

procedure TfrmGoodsGroupVendorEditorDlg.SetOnVerifyVendorExists(const Value: TfrmGoodsGroupVendorEditorVerifyVendorExistsEvent);
begin
     FOnVerifyVendorExists := Value;
end;

procedure TfrmGoodsGroupVendorEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
end;

end.
