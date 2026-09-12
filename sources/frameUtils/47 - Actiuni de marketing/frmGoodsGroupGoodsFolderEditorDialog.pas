unit frmGoodsGroupGoodsEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, SWNBaseUnit, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.StdCtrls, cxGroupBox,
  cxRadioGroup, cxDBEdit, Data.DB, DBAccess, IBC, MemDS, cxButtonEdit;

type

  TfrmGoodsGroupGoodsEditorVerifyGoodsExistsEvent = procedure(const GoodsID:Integer; var Exists:Boolean) of object;

  TfrmGoodsGroupGoodsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    rgFLG_EXCLUDE: TcxDBRadioGroup;
    btnCancel: TButton;
    btnOk: TButton;
    beGOODSID: TcxButtonEdit;
    lbExistsError: TLabel;
    procedure beGOODSIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    FGGID: Integer;
    FOnVerifyGoodsExists: TfrmGoodsGroupGoodsEditorVerifyGoodsExistsEvent;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckValues:Boolean;
    procedure SetGGID(const Value: Integer);
    procedure SetOnVerifyGoodsExists(const Value: TfrmGoodsGroupGoodsEditorVerifyGoodsExistsEvent);
  protected
    { protected declarations }
    procedure InitValues;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property CreateNewRecord:Boolean read FCreateNewRecord write SetCreateNewRecord;
    property GGID:Integer read FGGID write SetGGID;
    property OnVerifyGoodsExsists:TfrmGoodsGroupGoodsEditorVerifyGoodsExistsEvent read FOnVerifyGoodsExists write SetOnVerifyGoodsExists;
  end;


implementation

{$R *.dfm}

uses DataModuleDB, SWNConst, SWNUtils, DataModuleAdditions, frmGoods;

{ TfrmGoodsGroupVendorEditorDlg }

procedure TfrmGoodsGroupGoodsEditorDlg.beGOODSIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var dialog:TfrmGoodsBrowser;
    exists:Boolean;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.SelectGoods(fMasterDataSet.FieldByName('GOODSID').AsInteger,true,0,'') then
        begin
             fMasterDataSet.FieldByName('GOODSID').AsInteger:=dialog.GoodsID;
             beGOODSID.Text:=dialog.GoodsTitle;
             exists:=False;
             if Assigned(FOnVerifyGoodsExists) then FOnVerifyGoodsExists(dialog.GoodsID,exists);
             lbExistsError.Visible:=exists;
             btnOk.Enabled:=Not exists;
        end;
     finally
        // nu era nimic in acest block, se pare ca era leadmemory!
        dialog.free;
     end;
end;

function TfrmGoodsGroupGoodsEditorDlg.CheckValues: Boolean;
var Error:String;
begin
     Result:=False;
     Error:='';

     if fMasterDataSet.FieldByName('GOODSID').IsNull or (fMasterDataSet.FieldByName('GOODSID').AsInteger<=0)
       then AddErrorToStr(Error,'Mapa cu produse!');

     if Error='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Error);
end;

procedure TfrmGoodsGroupGoodsEditorDlg.InitValues;
begin
     rgFLG_EXCLUDE.DataBinding.DataSource:=fMasterDataSource;
     FOnVerifyGoodsExists := nil;
end;

function TfrmGoodsGroupGoodsEditorDlg.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckValues then
     begin
          fMasterDataSet.Post;
          Result:=True;
     end;
end;

procedure TfrmGoodsGroupGoodsEditorDlg.Prepare;
begin
     lbExistsError.Visible:=False;

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
             beGOODSID.Text:=fMasterDataSet.FieldByName('GOODS_NAME').AsString;
        end;
     except
        fMasterDataSet.Cancel;
        raise;
     end;
end;

procedure TfrmGoodsGroupGoodsEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
     FCreateNewRecord := Value;
end;

procedure TfrmGoodsGroupGoodsEditorDlg.SetGGID(const Value: Integer);
begin
     FGGID := Value;
end;

procedure TfrmGoodsGroupGoodsEditorDlg.SetOnVerifyGoodsExists(const Value: TfrmGoodsGroupGoodsEditorVerifyGoodsExistsEvent);
begin
     FOnVerifyGoodsExists := Value;
end;

procedure TfrmGoodsGroupGoodsEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
end;

end.
