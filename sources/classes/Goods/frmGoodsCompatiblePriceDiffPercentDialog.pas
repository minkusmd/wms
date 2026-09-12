unit frmGoodsCompatiblePriceDiffPercentDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, StdCtrls, cxDBEdit,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxTextEdit,
  cxMaskEdit, cxDropDownEdit;

type
  TfrmGoodsCompatiblePriceDiffPercentDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    cmbDIFFSUMPERCENT: TcxDBComboBox;
    Label2: TLabel;
    cbMakeDefault: TCheckBox;
    Label3: TLabel;
    edCOMPATIBLE_GOODS_NAME: TcxDBTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    function CheckParams:Boolean;
    function getMakeDefault: Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
    property MakeDefault:Boolean read getMakeDefault;
  end;


implementation

uses SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmGoodsCompatiblePriceDiffPercentDlg }

function TfrmGoodsCompatiblePriceDiffPercentDlg.CheckParams: Boolean;
var ErrorStr:String;
begin
     ErrorStr:='';
     Result:=False;

     if fMasterDataSet.FieldByName('DIFFSUMPERCENT').IsNull then AddErrorToStr(ErrorStr,'Diferenta de pret!');

     if ErrorStr=''
      then Result:=True
      else ShowErrorDialog(cMSG_GeneralInputError_Title,ErrorStr);
end;

function TfrmGoodsCompatiblePriceDiffPercentDlg.getMakeDefault: Boolean;
begin
     Result:=cbMakeDefault.Checked;
end;

procedure TfrmGoodsCompatiblePriceDiffPercentDlg.BindingDataSource;
begin
     inherited;

     edCOMPATIBLE_GOODS_NAME.DataBinding.DataSource:=fMasterDataSource;
     cmbDIFFSUMPERCENT.DataBinding.DataSource:=fMasterDataSource;
end;

function TfrmGoodsCompatiblePriceDiffPercentDlg.IsFormDataPosted: Boolean;
begin
     if CheckParams then
     begin
          fMasterDataSet.Post;
          Result:=True;
     end
     else Result:=False;
end;

procedure TfrmGoodsCompatiblePriceDiffPercentDlg.Prepare;
begin
     try
        fMasterDataSet.Edit;
        dtDialogTitle.Text:=Format('Marfa nr.%d',[fMasterDataSet.FieldByName('COMPATIBLE_GOODSID').AsInteger]);
     except
        fMasterDataSet.Cancel;
        raise;
     end;
end;

procedure TfrmGoodsCompatiblePriceDiffPercentDlg.WhenCancelForm;
begin
     fMasterDataSet.Cancel;
end;

end.
