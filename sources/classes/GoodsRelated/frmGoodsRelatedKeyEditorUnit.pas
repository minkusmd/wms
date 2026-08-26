unit frmGoodsRelatedKeyEditorUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, StdCtrls,
  cxDBEdit, ExtCtrls, DialogTitle,
  Data.DB,
  IBC, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  cxCurrencyEdit, cxTextEdit;

type
  TfrmGoodsRelatedKeyEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    edTITLE: TcxDBTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    edKey: TcxDBTextEdit;
    Label1: TLabel;
  private
    { Private declarations }
    FCreateNewItem: Boolean;
    FGoodsModel: string;
    FParentID: string;
    FVendorName: string;
    procedure SetCreateNewItem(const Value: Boolean);
    procedure SetParentID(const Value: string);
    function CheckParams:Boolean;
    procedure SetGoodsModel(const Value: string);
    procedure SetVendorName(const Value: string);
  protected
    { Protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;

    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    { Public declarations }
    property ParentID:string read FParentID write SetParentID;
    property CreateNewItem:Boolean read FCreateNewItem write SetCreateNewItem;
    property GoodsModel: string read FGoodsModel write SetGoodsModel;
    property VendorName: string read FVendorName write SetVendorName;
  end;


implementation


uses SWNUtils, SWNConst, SWNValueStorageUnit;

{$R *.dfm}

{ TfrmGoodsAcntEditorDlg }

function TfrmGoodsRelatedKeyEditorDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     ErrorStr:='';
     Result:=False;

     with fMasterDataSet do
     begin
          if FieldByName('RELATED_KEY').IsNull or (FieldByName('RELATED_KEY').AsString='') then AddErrorToStr(ErrorStr,'Indicat codul!');
//          if FieldByName('TITLE').IsNull or (FieldByName('TITLE').AsString='') then AddErrorToStr(ErrorStr,'Denumire!');
     end;
     if ErrorStr='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,ErrorStr);
end;

procedure TfrmGoodsRelatedKeyEditorDlg.BindingDataSource;
begin
     inherited;
     FParentID := '';
     FCreateNewItem := False;
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     edKey.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmGoodsRelatedKeyEditorDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          fMasterDataSet.Post;
          fMasterDataSet.UpdateTransaction.Commit;
          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmGoodsRelatedKeyEditorDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
    Self.Position := poDesigned;
end;

procedure TfrmGoodsRelatedKeyEditorDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if FCreateNewItem then
        begin
             dtDialogTitle.Text:='Inregistrare noua';
             fMasterDataSet.Append;
             fMasterDataSet.FieldByName('PARENT_KEY').AsString:=FParentID;
             fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger:=0;
             fmasterdataSet.FieldByName('RELATED_KEY').AsSTring := GoodsModel + '-' + VendorName;
        end
        else
        begin
             dtDialogTitle.Text:='Modifica inregistrarea';
             fMasterDataSet.Edit;
        end;
     except
        if fMasterDataSet.State in dsEditModes then fMasterDataSet.Cancel;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmGoodsRelatedKeyEditorDlg.SaveStates;
begin
  inherited;
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

procedure TfrmGoodsRelatedKeyEditorDlg.SetCreateNewItem(const Value: Boolean);
begin
     FCreateNewItem := Value;
end;

procedure TfrmGoodsRelatedKeyEditorDlg.SetGoodsModel(const Value: string);
begin
    FGoodsModel := Value;
end;

procedure TfrmGoodsRelatedKeyEditorDlg.SetParentID(const Value: string);
begin
     FParentID := Value;
end;

procedure TfrmGoodsRelatedKeyEditorDlg.SetVendorName(const Value: string);
begin
    FVendorName := Value;
end;

procedure TfrmGoodsRelatedKeyEditorDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
