unit uLoanEditorDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxImage, cxDBEdit, cxGroupBox, cxLabel, cxMaskEdit,
  cxDropDownEdit, cxCalc, cxTextEdit, DB, cxButtonEdit;

type
  TfrmLoanEditorDlg = class(TSWNMasteredFormClass)
    teTitle: TcxDBTextEdit;
    ceMonths: TcxDBCalcEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel3: TcxLabel;
    ceSuma: TcxDBCalcEdit;
    ceAvansSuma: TcxDBCalcEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    ceAvansProcent: TcxDBCalcEdit;
    cxLabel6: TcxLabel;
    ceComsion: TcxDBCalcEdit;
    cxGroupBox2: TcxGroupBox;
    cxLabel7: TcxLabel;
    ceAvantCompanieProcent: TcxDBCalcEdit;
    cxLabel8: TcxLabel;
    IconImage: TcxDBImage;
    cxLabel9: TcxLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    bePROMO_GOODS_GROUP_ID: TcxButtonEdit;
    Label21: TLabel;
    procedure bePROMO_GOODS_GROUP_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    FIsNewRecord: Boolean;
    procedure SetIsNewRecord(const Value: Boolean);
    { Private declarations }
  protected
    procedure ClearPromoGoods;
    { Protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure SelectPromoGoods;
    procedure WhenCancelForm; override;

  public
    property IsNewRecord: Boolean read FIsNewRecord write SetIsNewRecord;
    { Public declarations }
  end;

var
  frmLoanEditorDlg: TfrmLoanEditorDlg;

implementation

uses
  frmCrediteGoodsGroupsDialog;

{$R *.dfm}

{ TfrmLoanEditorDlg }

procedure TfrmLoanEditorDlg.bePROMO_GOODS_GROUP_IDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     case AButtonIndex of
     0: SelectPromoGoods;
     1: ClearPromoGoods;
     end;
end;

procedure TfrmLoanEditorDlg.ClearPromoGoods;
begin
  // TODO -cMM: TfrmLoanEditorDlg.ClearPromoGoods default body inserted
     fMasterDataSet.FieldByName('PROMO_GOODS_GROUP_ID').Value:=NULL;
     bePROMO_GOODS_GROUP_ID.Text:='';

end;

function TfrmLoanEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  fMasterDataSet.Post;
end;

procedure TfrmLoanEditorDlg.Prepare;
begin
  teTitle.DataBinding.DataSource := fMasterDataSource;
  teTitle.DataBinding.DataField := 'TITLE';
  ceMonths.DataBinding.DataSource := fMasterDataSource;
  ceMonths.DataBinding.DataField := 'MONTHS';
  ceSuma.DataBinding.DataSource := fMasterDataSource;
  ceSuma.DataBinding.DataField :='CUST_PAY_M_AMOUNT';
  ceAvansSuma.DataBinding.DataSource := fMasterDataSource;
  ceAvansSuma.DataBinding.DataField := 'CUST_PREPAY_AMOUNT';
  ceAvansProcent.DataBinding.DataSource := fMasterDataSource;
  ceAvansProcent.DataBinding.DataField := 'CUST_PREPAY_PERCENT';
  ceComsion.DataBinding.DataSource := fMasterDataSource;
  ceComsion.DataBinding.DataField := 'CUST_MONTHLY_COMISION';

  ceAvantCompanieProcent.DataBinding.DataSource := fMasterDataSource;
  ceAvantCompanieProcent.DataBinding.DataField:= 'OUR_PAY_PERCENT';

  IconImage.DataBinding.DataSource := fMasterDataSource;
  IconImage.DataBinding.DataField := 'LOAN_IMAGE';
  if FIsNewRecord then
    fMasterDataSet.Append
  else
    fMasterDataSet.Edit;


end;

procedure TfrmLoanEditorDlg.SelectPromoGoods;
var dialog:TfrmCrediteGoodsGroupsDlg;
begin
     dialog:=TfrmCrediteGoodsGroupsDlg.Create(Self);
     try
        if dialog.SelectGoodsGroup(fMasterDataSet.FieldByName('GOODS_GROUP_ID').AsInteger) then
        begin
             fMasterDataSet.FieldByName('GOODS_GROUP_ID').AsInteger:=dialog.GG_ID;
             bePROMO_GOODS_GROUP_ID.Text:=dialog.GG_Title;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmLoanEditorDlg.SetIsNewRecord(const Value: Boolean);
begin
  FIsNewRecord := Value;
end;

procedure TfrmLoanEditorDlg.WhenCancelForm;
begin
  inherited;
  if fMasterDataSet.State in [dsEdit, dsInsert] then
    fMasterDataSet.Cancel;

end;

end.
