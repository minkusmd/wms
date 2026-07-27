unit frmLocationEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, StdCtrls, ExtCtrls, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMemo, cxDBEdit, cxSpinEdit, cxDropDownEdit, cxMaskEdit,
  cxDBLookupComboBox, DB, IBC, MemDS, Buttons, cxButtonEdit, Vcl.Menus, cxButtons, DBAccess, cxLookupEdit,
  cxDBLookupEdit;

type
  TfrmLocationEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    mmCOMMENTS_ROM: TcxDBMemo;
    mmCOMMENTS_RUS: TcxDBMemo;
    lcbDISTRICTID: TcxDBLookupComboBox;
    lcbCITYID: TcxDBLookupComboBox;
    cmbTimeUnit: TcxComboBox;
    seTIME_MIN: TcxDBSpinEdit;
    seTIME_MAX: TcxDBSpinEdit;
    IBCQueryDistrict: TIBCQuery;
    IBCQueryCity: TIBCQuery;
    IBCDataSourceDistrict: TIBCDataSource;
    IBCDataSourceCity: TIBCDataSource;
    SpeedButton1: TSpeedButton;
    beGOODS: TcxButtonEdit;
    Label9: TLabel;
    Label10: TLabel;
    edTITLE_ROM: TcxDBTextEdit;
    edTITLE_RUS: TcxDBTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure lcbDISTRICTIDPropertiesEditValueChanged(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure beGOODSPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);

  private
    { Private declarations }
    fCreateNewLocation: Boolean;
    procedure SetCreateNewLocation(const Value: Boolean);
    function CheckInputParams: Boolean;
    procedure SelectGoods;

  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    property CreateNewLocation: Boolean read fCreateNewLocation write SetCreateNewLocation;
  end;

implementation

uses SWNConst, SWNUtils, DataModuleDB, frmGoods;

{$R *.dfm}
{ TfrmLocationEditorDlg }

procedure TfrmLocationEditorDlg.beGOODSPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectGoods;
end;

function TfrmLocationEditorDlg.CheckInputParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('DISTRICTID').IsNull then
    AddErrorToStr(ErrorStr, 'Район!');
  if fMasterDataSet.FieldByName('GOODSID').IsNull then
    AddErrorToStr(ErrorStr, 'Услуга!');
  if fMasterDataSet.FieldByName('TIME_MIN').IsNull then
    AddErrorToStr(ErrorStr, 'Время, мин!');
  if fMasterDataSet.FieldByName('TIME_MAX').IsNull then
    AddErrorToStr(ErrorStr, 'Время, макс!');
  fMasterDataSet.FieldByName('TIME_UNIT').AsInteger := cmbTimeUnit.ItemIndex + 1;

  if fMasterDataSet.FieldByName('TITLE_ROM').IsNull or (fMasterDataSet.FieldByName('TITLE_ROM').AsString = '') then
    AddErrorToStr(ErrorStr, 'Denumirea!');
  if fMasterDataSet.FieldByName('TITLE_RUS').IsNull or (fMasterDataSet.FieldByName('TITLE_RUS').AsString = '') then
    AddErrorToStr(ErrorStr, 'Название!');
  if fMasterDataSet.FieldByName('COMMENTS_ROM').IsNull or (fMasterDataSet.FieldByName('COMMENTS_ROM').AsString = '') then
    AddErrorToStr(ErrorStr, 'Timpul de livrare!');
  if fMasterDataSet.FieldByName('COMMENTS_RUS').IsNull or (fMasterDataSet.FieldByName('COMMENTS_RUS').AsString = '') then
    AddErrorToStr(ErrorStr, 'Время доставки!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmLocationEditorDlg.BindingDataSource;
begin
  inherited;
  fCreateNewLocation := False;

  IBCQueryCity.MasterSource := fMasterDataSource;
  IBCQueryCity.MasterFields := 'DISTRICTID';
  IBCQueryCity.DetailFields := 'VALUE_INT';

  lcbDISTRICTID.DataBinding.DataSource := fMasterDataSource;
  lcbCITYID.DataBinding.DataSource := fMasterDataSource;
  seTIME_MIN.DataBinding.DataSource := fMasterDataSource;
  seTIME_MAX.DataBinding.DataSource := fMasterDataSource;
  edTITLE_ROM.DataBinding.DataSource := fMasterDataSource;
  edTITLE_RUS.DataBinding.DataSource := fMasterDataSource;
  mmCOMMENTS_ROM.DataBinding.DataSource := fMasterDataSource;
  mmCOMMENTS_RUS.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmLocationEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckInputParams then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmLocationEditorDlg.lcbDISTRICTIDPropertiesEditValueChanged(Sender: TObject);
begin
  IBCQueryCity.Active := False;
  IBCQueryCity.Active := True;
end;

procedure TfrmLocationEditorDlg.Prepare;
begin
  try
    fMasterDataSet.UpdateTransaction.StartTransaction;

    if fCreateNewLocation then
    begin
      dtDialogTitle.Text := 'Добавление нового района или населенного пункта';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FIRMAID').AsInteger := FirmaID;
      fMasterDataSet.FieldByName('CITYID').AsInteger := -1;
      fMasterDataSet.FieldByName('TIME_MIN').AsInteger := 3;
      fMasterDataSet.FieldByName('TIME_MAX').AsInteger := 7;
    end
    else
    begin
      dtDialogTitle.Text := 'Изменение записи';
      fMasterDataSet.Edit;

      cmbTimeUnit.ItemIndex := fMasterDataSet.FieldByName('TIME_UNIT').AsInteger - 1;
      beGOODS.Text := fMasterDataSet.FieldByName('GOODS_TITLE').AsString;
    end;

    IBCQueryDistrict.Active := True;
    IBCQueryCity.Active := True;

  except
    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;

end;

procedure TfrmLocationEditorDlg.SelectGoods;
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    dialog.SetCompactMode;
    if dialog.SelectGoods(fMasterDataSet.FieldByName('GOODSID').AsInteger, False, 0, 'Выберите услугу доставки') then
    begin
      fMasterDataSet.FieldByName('GOODSID').AsInteger := dialog.GoodsID;
      beGOODS.Text := dialog.GoodsTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmLocationEditorDlg.SetCreateNewLocation(const Value: Boolean);
begin
  fCreateNewLocation := Value;
end;

procedure TfrmLocationEditorDlg.SpeedButton1Click(Sender: TObject);
begin
  fMasterDataSet.FieldByName('CITYID').AsInteger := -1;
end;

procedure TfrmLocationEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.
