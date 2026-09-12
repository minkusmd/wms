unit frmGoodsGroupGoodsTypeEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, SWNBaseUnit, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.StdCtrls, cxGroupBox,
  cxRadioGroup, cxDBEdit, Data.DB, DBAccess, IBC, MemDS;

type

  TfrmGoodsGroupGoodsTypeEditorVerifyGoodsExistsEvent = procedure(const GoodsTypeID:Integer; var Exists:Boolean) of object;

  TfrmGoodsGroupGoodsTypeEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    lcbGOODSTYPEID: TcxDBLookupComboBox;
    rgFLG_EXCLUDE: TcxDBRadioGroup;
    btnCancel: TButton;
    btnOk: TButton;
    IBCQueryGT: TIBCQuery;
    IBCDataSourceGT: TIBCDataSource;
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    FGGID: Integer;
    FOnVerifyGoodsTypeExists: TfrmGoodsGroupGoodsTypeEditorVerifyGoodsExistsEvent;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues:Boolean;
    procedure SetGGID(const Value: Integer);
    procedure SetOnVerifyGoodsTypeExists(const Value: TfrmGoodsGroupGoodsTypeEditorVerifyGoodsExistsEvent);
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
    property OnVerifyGoodsTypeExists:TfrmGoodsGroupGoodsTypeEditorVerifyGoodsExistsEvent read FOnVerifyGoodsTypeExists write SetOnVerifyGoodsTypeExists;
  end;


implementation

{$R *.dfm}

uses DataModuleDB, SWNConst, SWNUtils;

{ TfrmGoodsGroupVendorEditorDlg }

function TfrmGoodsGroupGoodsTypeEditorDlg.CheckValues: Boolean;
var Error:String;
    exists:Boolean;
begin
     Result:=False;
     Error:='';

     if fMasterDataSet.FieldByName('GOODSTYPEID').IsNull or (fMasterDataSet.FieldByName('GOODSTYPEID').AsInteger<=0)
       then AddErrorToStr(Error,'Tip marfa!');

     if Assigned(FOnVerifyGoodsTypeExists) then
     begin
          FOnVerifyGoodsTypeExists(fMasterDataSet.FieldByName('GOODSTYPEID').AsInteger,exists);
          if exists then AddErrorToStr(Error,'Tipul de marfa este deja selectat!');
     end;

     if Error='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Error);
end;

procedure TfrmGoodsGroupGoodsTypeEditorDlg.BindingDataSource;
begin
     lcbGOODSTYPEID.DataBinding.DataSource:=fMasterDataSource;
     rgFLG_EXCLUDE.DataBinding.DataSource:=fMasterDataSource;
     FOnVerifyGoodsTypeExists := nil;
end;

function TfrmGoodsGroupGoodsTypeEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          Result:=True;
     end;
end;

procedure TfrmGoodsGroupGoodsTypeEditorDlg.Prepare;
begin
     try
        if fCreateNewRecord then
        begin
             dtDialogTitle.Text:='Adaugare tip nou de marfa';
             fMasterDataSet.Insert;
             fMasterDataSet.FieldByName('FLG_EXCLUDE').AsInteger:=0;
             fMasterDataSet.FieldByName('GG_ID').AsInteger:=FGGID;
        end
        else
        begin
             dtDialogTitle.Text:='Modificare inregistrare';
             fMasterDataSet.Edit;
        end;
        IBCQueryGT.Active:=True;
     except
        fMasterDataSet.Cancel;
        raise;
     end;
end;

procedure TfrmGoodsGroupGoodsTypeEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmGoodsGroupGoodsTypeEditorDlg.SetGGID(const Value: Integer);
begin
     FGGID := Value;
end;

procedure TfrmGoodsGroupGoodsTypeEditorDlg.SetOnVerifyGoodsTypeExists(const Value: TfrmGoodsGroupGoodsTypeEditorVerifyGoodsExistsEvent);
begin
     FOnVerifyGoodsTypeExists := Value;
end;

procedure TfrmGoodsGroupGoodsTypeEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
end;

end.
