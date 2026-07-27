unit frmWebPromoActiuneEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNBaseUnit, Vcl.ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckBox, cxDBEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxTextEdit, Vcl.StdCtrls, cxButtonEdit, Vcl.Menus,
  cxButtons, Data.DB, MemDS, DBAccess, IBC, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, dxUIAClasses;

type
  TfrmWebPromoActiuneEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edTITLE: TcxDBTextEdit;
    deSTART_DATE: TcxDBDateEdit;
    deEND_DATE: TcxDBDateEdit;
    cbFLG_SHOW_BANNER: TcxDBCheckBox;
    cbFLG_SHOW_GOODS: TcxDBCheckBox;
    cbFLG_SHOW_BRICKS: TcxDBCheckBox;
    cbFLG_ENABLED: TcxDBCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    Label4: TLabel;
    teMeta_title_ro: TcxDBTextEdit;
    Label5: TLabel;
    teMeta_title_ru: TcxDBTextEdit;
    teMeta_description_ru: TcxDBTextEdit;
    Label6: TLabel;
    Label7: TLabel;
    teMeta_description_ro: TcxDBTextEdit;
    cbFLG_FAKE_PROMOTION: TcxDBCheckBox;
    cbPromoTypes: TcxDBLookupComboBox;
    IBCQueryPromoTypes: TIBCQuery;
    IBCDataSourcePromoTypes: TIBCDataSource;
    Label8: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  private
    FCreateNewRecord: Boolean;
    FDT: Integer;
    { Private declarations }
    function CheckValues: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure SetDT(const Value: Integer);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
    property DT: Integer read FDT write SetDT;

  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, SWNUtils, SWNConst, frmGoodsGroupsManagerDialog;

procedure TfrmWebPromoActiuneEditorDlg.cxButton1Click(Sender: TObject);
var
  CurrentPromoActionID: string;
  q: TIBCQuery;
begin
  //read from table where id = PromoactionID
  CurrentPromoActionID := fMasterDataSet.FieldByName('promoactionid').AsString;
  q := TIBCQuery.Create(self);
  try
    q.SQL.Text := 'select * from VW_TWEB_PROMOS where promoactionid = :promoactionid';
    q.ParamByName('promoactionid').AsString := InputBox('codul promotiei', 'cod', '-1');
    q.Open;

    with fMasterDataSet do begin
      Edit;
      FieldByName('meta_title_ro').AsString := q.FieldByName('meta_title_ro').AsString;
      FieldByName('meta_title_ru').AsString := q.FieldByName('meta_title_ru').AsString;
      FieldByName('META_DESCRIPTION_RO').AsString := q.FieldByName('META_DESCRIPTION_RO').AsString;
      FieldByName('META_DESCRIPTION_RU').AsString := q.FieldByName('META_DESCRIPTION_RU').AsString;
      Post;
    end;
  finally
    q.Free;
  end;
end;

procedure TfrmWebPromoActiuneEditorDlg.cxButton2Click(Sender: TObject);
var
  q: TIBCQuery;
begin
  q := TIBCQuery.Create(nil);
  q.SQL.Text := 'SELECT * FROM VW_TWEB_PA_TOVAR WHERE PROMOACTIONID=:ID';
  q.ParamByName('ID').AsInteger := MasterDataSet.FieldByName('PROMOACTIONID').AsInteger;
  q.Open;

  MasterDataSet.FieldByName('META_TITLE_RO').AsString := q.FieldByName('TITLE_ROM').AsString;
  MasterDataSet.FieldByName('META_TITLE_RU').AsString := q.FieldByName('TITLE_RUS').AsString;
  MasterDataSet.FieldByName('META_DESCRIPTION_RO').AsString := q.FieldByName('TEXT_ROM').AsString;
  MasterDataSet.FieldByName('META_DESCRIPTION_RU').AsString := q.FieldByName('TEXT_RUS').AsString;

end;

function TfrmWebPromoActiuneEditorDlg.CheckValues: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('TITLE').IsNull or (fMasterDataSet.FieldByName('TITLE').AsString = '') then
    AddErrorToStr(ErrorStr, 'Denumire promotiei!');

  if fMasterDataSet.FieldByName('START_DATE').IsNull then
    AddErrorToStr(ErrorStr, 'Inceputul promotiei!');
  if fMasterDataSet.FieldByName('END_DATE').IsNull then
    AddErrorToStr(ErrorStr, 'Sfirsitul promotiei!');

  if fMasterDataSet.FieldByName('PROMO_TYPEID').IsNull then
    AddErrorToStr(ErrorStr, 'Tipul promotiei!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmWebPromoActiuneEditorDlg.BindingDataSource;
begin
  cbFLG_ENABLED.DataBinding.DataSource := fMasterDataSource;
  edTITLE.DataBinding.DataSource := fMasterDataSource;
  deSTART_DATE.DataBinding.DataSource := fMasterDataSource;
  deEND_DATE.DataBinding.DataSource := fMasterDataSource;

  cbFLG_SHOW_BANNER.DataBinding.DataSource := fMasterDataSource;
  cbFLG_SHOW_GOODS.DataBinding.DataSource := fMasterDataSource;
  cbFLG_SHOW_BRICKS.DataBinding.DataSource := fMasterDataSource;
  cbFLG_FAKE_PROMOTION.DataBinding.DataSource := fMasterDataSource;

  teMeta_title_ro.DataBinding.DataSource := fMasterDataSource;
  teMeta_title_ru.DataBinding.DataSource := fMasterDataSource;
  teMeta_description_ro.DataBinding.DataSource := fMasterDataSource;
  teMeta_description_ru.DataBinding.DataSource := fMasterDataSource;

  cbPromoTypes.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmWebPromoActiuneEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then begin
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmWebPromoActiuneEditorDlg.Prepare;
begin
  if not fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.StartTransaction;

  try
    if FCreateNewRecord then begin
      dtDialogTitle.Text := 'Inregistrare noua';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FLG_ENABLED').AsInteger := 0;
      fMasterDataSet.FieldByName('START_DATE').AsDateTime := NOW;
      fMasterDataSet.FieldByName('END_DATE').AsDateTime := NOW + 30;
      fMasterDataSet.FieldByName('FLG_SHOW_BANNER').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_SHOW_GOODS').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_SHOW_BRICKS').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_FAKE_PROMOTION').AsInteger := 0;
      fMasterDataSet.FieldByName('ORDERNO').AsInteger := 1;
      fMasterDataSet.FieldByName('DT').AsInteger := 5213; //fDT;
    end
    else begin
      dtDialogTitle.Text := 'Modifica inregistrarea';
      fMasterDataSet.Edit;
    end;

    IBCQueryPromoTypes.Open;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
  end;
end;

procedure TfrmWebPromoActiuneEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmWebPromoActiuneEditorDlg.SetDT(const Value: Integer);
begin
  FDT := Value;
end;

procedure TfrmWebPromoActiuneEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;

  if fMasterDataSet.UpdateTransaction.Active then
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

