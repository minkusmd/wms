unit frmPartNumberEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, DB, MemDS, DBAccess, IBC, StdCtrls, cxDBEdit,
  cxTextEdit, ExtCtrls,
  DialogTitle, Buttons,
  cxButtonEdit, cxCalc, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxDropDownEdit, cxCalendar, cxCurrencyEdit, cxMaskEdit, cxMemo,
  dxCoreGraphics;

type
  TOnCheckPartNoExists = function(const PartNo: string): Boolean of object;

  TfrmPartNumberEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    cxLabel4: TLabel;
    mmCOMMENTS: TcxDBMemo;
    edVENDORWARRANTY: TcxDBMaskEdit;
    edOWNWARRANTY: TcxDBMaskEdit;
    edPARTNO: TcxDBMaskEdit;
    cxLabel5: TLabel;
    cxLabel6: TLabel;
    cxLabel7: TLabel;
    edSUMA_ACCIZE: TcxDBCurrencyEdit;
    IBCDataSourcePARTS_Comments: TIBCDataSource;
    IBCQueryPARTS_Comments: TIBCQuery;
    Label1: TLabel;
    Label2: TLabel;
    beCountryID: TcxButtonEdit;
    beVendorID: TcxButtonEdit;
    Label3: TLabel;
    deVALID_UNTIL_DATE: TcxDBDateEdit;
    sbCreateValidUntilDate: TSpeedButton;
    lbValidUntilInfo: TLabel;
    edQTY: TcxDBCalcEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure beCountryIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beVendorIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure sbCreateValidUntilDateClick(Sender: TObject);
  private
    { Private declarations }
    fCreateNewPartNo: Boolean;
    FComplect_SN: string;
    fDefaultPartNo: string;
    FDefaultVendorWarranty: integer;
    FDefaultOwnWarranty: integer;
    fDefaultQTY: Double;
    FOnCheckPartNoExists: TOnCheckPartNoExists;
    FGoodsID: integer;
    procedure SetCreateNewPartNo(const Value: Boolean);
    function CheckParams: Boolean;
    procedure SetComplect_SN(const Value: string);
    procedure SetDefaultVendorWarranty(const Value: integer);
    procedure SetDefaultOwnWarranty(const Value: integer);
    procedure SetDefaultQTY(const Value: Double);
    procedure SetDefaultPartNo(const Value: string);
    procedure SetOnCheckPartNoExists(const Value: TOnCheckPartNoExists);
    procedure SelectCountry;
    procedure SelectVendor;
    procedure SetGoodsID(const Value: integer);
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
//    function CalcNextPartNo: integer;
  public
    { Public declarations }
    property GoodsID: integer read FGoodsID write SetGoodsID;
    property CreateNewPartNo: Boolean read fCreateNewPartNo write SetCreateNewPartNo;
    property Complect_SN: string write SetComplect_SN;
    property DefaultPartNo: string write SetDefaultPartNo;
    property DefaultVendorWarranty: integer write SetDefaultVendorWarranty;
    property DefaultOwnWarranty: integer write SetDefaultOwnWarranty;
    property DefaultQTY: Double write SetDefaultQTY;
    property OnCheckPartNoExists: TOnCheckPartNoExists read FOnCheckPartNoExists write SetOnCheckPartNoExists;
  end;

implementation

uses
  SWNUtils, SWNConst, DataModuleDB, frmSyssEditorWindow,
  SWNValueStorageUnit, DateUtils;

{$R *.dfm}

{ TfrmSerialNumberEditorDlg }

procedure TfrmPartNumberEditorDlg.beCountryIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCountry;
end;

procedure TfrmPartNumberEditorDlg.beVendorIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectVendor;
end;


function TfrmPartNumberEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
  exists: Boolean;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('PARTNO').IsNull or (fMasterDataSet.FieldByName('PARTNO').AsString = '') or (not ValidateTextForPartNo(fMasterDataSet.FieldByName('PARTNO').AsString)) then
    AddErrorToStr(ErrorStr, 'Numarul partidei!')
  else
  begin
    exists := False;
    if Assigned(FOnCheckPartNoExists) then
      exists := FOnCheckPartNoExists(fMasterDataSet.FieldByName('PARTNO').AsString);
    if exists then
      AddErrorToStr(ErrorStr, 'Numarul partidei exista deja!')
  end;
  if fMasterDataSet.FieldByName('VENDORWARRANTY').IsNull or (fMasterDataSet.FieldByName('VENDORWARRANTY').AsInteger < 0) then
    AddErrorToStr(ErrorStr, 'Garantia producatorului!');
  if fMasterDataSet.FieldByName('OWNWARRANTY').IsNull or (fMasterDataSet.FieldByName('OWNWARRANTY').AsInteger < 0) then
    AddErrorToStr(ErrorStr, 'Garantia vanzatorului!');

  if fMasterDataSet.FieldByName('QTY').IsNull or (fMasterDataSet.FieldByName('QTY').AsFloat <= 0) then
    AddErrorToStr(ErrorStr, 'Cantitate!');

  if fMasterDataSet.FieldByName('COUNTRYID').IsNull or (fMasterDataSet.FieldByName('COUNTRYID').AsInteger < 0) then
    AddErrorToStr(ErrorStr, 'Tara producatoare!');
  if fMasterDataSet.FieldByName('VENDORID').IsNull or (fMasterDataSet.FieldByName('VENDORID').AsInteger < 0) then
    AddErrorToStr(ErrorStr, 'Producator!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmPartNumberEditorDlg.BindingDataSource;
var
  qtyDigitsMode: Integer;
begin
  inherited;

  FGoodsID := -1;
  fDefaultPartNo := '';
  fCreateNewPartNo := False;
  FComplect_SN := ''; // = NULL
  FDefaultVendorWarranty := 0;
  FDefaultOwnWarranty := 0;

  edPARTNO.DataBinding.DataSource := fMasterDataSource;
  edVENDORWARRANTY.DataBinding.DataSource := fMasterDataSource;
  edOWNWARRANTY.DataBinding.DataSource := fMasterDataSource;
  edQTY.DataBinding.DataSource := fMasterDataSource;
  edSUMA_ACCIZE.DataBinding.DataSource := fMasterDataSource;
  deVALID_UNTIL_DATE.DataBinding.DataSource := fMasterDataSource;

  IBCQueryPARTS_Comments.Transaction := fMasterDataSet.UpdateTransaction;
  IBCQueryPARTS_Comments.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryPARTS_Comments.MasterSource := fMasterDataSource;

     // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
     // Pozitii marfa: Cantitate
  TcxCalcEditProperties(edQTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

function TfrmPartNumberEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    if IBCQueryPARTS_Comments.State in dsEditModes then
      IBCQueryPARTS_Comments.FieldByName('CREATED_BY').AsInteger := UserID;
    fMasterDataSet.Post;
    if IBCQueryPARTS_Comments.State in dsEditModes then
      IBCQueryPARTS_Comments.Post;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmPartNumberEditorDlg.Prepare;
var
  info: TGoodsInfo_VendorAndCountry;
begin
  try
    if fCreateNewPartNo then
    begin
      dtDialogTitle.Text := 'Numar de partida nou';

      fMasterDataSet.Append;
      if fDefaultPartNo <> '' then
      begin
        fMasterDataSet.FieldByName('PARTNO').asString := Format('%s%5.5d', [fDefaultPartNo, dmdb.CalcNextPartNo(fDefaultPartNo, MasterDataSet.FieldByName('GOODSID').AsInteger)]);
      end;
      fMasterDataSet.FieldByName('CREATED_BY').asInteger := UserID;
      fMasterDataSet.FieldByName('VENDORWARRANTY').AsInteger := FDefaultVendorWarranty;
      fMasterDataSet.FieldByName('OWNWARRANTY').AsInteger := FDefaultOwnWarranty;
      fMasterDataSet.FieldByName('QTY').AsFloat := fDefaultQTY;
      fMasterDataSet.FieldByName('SUMA_ACCIZE').AsCurrency := 0;
      fMasterDataSet.FieldByName('COMPLECT_SN').asString := 'none';

      info := dmDB.GetGoodsInfo_PARTS_VendorCountry(FGoodsID);
      if Assigned(info) then
      begin
        if info.CountryID = -1 then
        begin
          info.CountryID := AppUserConfigStorage.IntValues.GetValue('PartNumber_DefaultCountryID', -1);
          info.CountryTitle := dmDB.GetSyssTitleByID(info.CountryID);
        end;
        if info.VendorID = -1 then
        begin
          info.VendorID := AppUserConfigStorage.IntValues.GetValue('PartNumber_DefaultVendorID', -1);
          info.VendorTitle := dmDB.GetSyssTitleByID(info.VendorID);
        end;

        fMasterDataSet.FieldByName('COUNTRYID').AsInteger := info.CountryID;
        beCountryID.Text := info.CountryTitle;
        fMasterDataSet.FieldByName('VENDORID').AsInteger := info.VendorID;
        beVendorID.Text := info.VendorTitle;

        info.Free;
      end;

    end
    else
    begin
      dtDialogTitle.Text := 'Modificare numar de partida';

      fMasterDataSet.Edit;
      edSUMA_ACCIZE.Enabled := False;

      beCountryID.Text := fMasterDataSet.FieldByName('COUNTRY_TITLE').AsString;
      beVendorID.Text := fMasterDataSet.FieldByName('VENDOR_TITLE').AsString;
    end;

    IBCQueryPARTS_Comments.Active := True;
  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
    IBCQueryPARTS_Comments.Close;
    raise;
  end;
end;

procedure TfrmPartNumberEditorDlg.sbCreateValidUntilDateClick(Sender: TObject);
var
  N: integer;
begin
  if not fMasterDataSet.FieldByName('OWNWARRANTY').IsNull then
  begin
    N := fMasterDataSet.FieldByName('OWNWARRANTY').AsInteger;
    fMasterDataSet.FieldByName('VALID_UNTIL_DATE').AsDateTime := IncMonth(Now, N);
    lbValidUntilInfo.Caption := Format('Adaugate luni: %d', [N]);
  end;
end;

procedure TfrmPartNumberEditorDlg.SelectCountry;
var
  dialog: TfrmSelectSyssEditorWin;
begin
  dialog := TfrmSelectSyssEditorWin.Create(self);
  try
    dialog.SelectMode := True;
    dialog.SetDefaultGroup(27);
    dialog.SYSSID := fMasterDataSet.FieldByName('COUNTRYID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      fMasterDataSet.FieldByName('COUNTRYID').AsInteger := dialog.SYSSID;
      beCountryID.Text := dialog.SyssTitle;
      AppUserConfigStorage.IntValues.SetValue('PartNumber_DefaultCountryID', dialog.SYSSID);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPartNumberEditorDlg.SelectVendor;
var
  dialog: TfrmSelectSyssEditorWin;
begin
  dialog := TfrmSelectSyssEditorWin.Create(self);
  try
    dialog.SelectMode := True;
    dialog.SetDefaultGroup(1);
    dialog.SYSSID := fMasterDataSet.FieldByName('VENDORID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      fMasterDataSet.FieldByName('VENDORID').AsInteger := dialog.SYSSID;
      beVendorID.Text := dialog.SyssTitle;
      AppUserConfigStorage.IntValues.SetValue('PartNumber_DefaultVendorID', dialog.SYSSID);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPartNumberEditorDlg.SetComplect_SN(const Value: string);
begin
  FComplect_SN := Value;
end;

procedure TfrmPartNumberEditorDlg.SetCreateNewPartNo(const Value: Boolean);
begin
  fCreateNewPartNo := Value;
end;

procedure TfrmPartNumberEditorDlg.SetDefaultOwnWarranty(const Value: integer);
begin
  FDefaultOwnWarranty := Value;
end;

procedure TfrmPartNumberEditorDlg.SetDefaultPartNo(const Value: string);
begin
  fDefaultPartNo := Value;
end;

procedure TfrmPartNumberEditorDlg.SetDefaultQTY(const Value: Double);
begin
  fDefaultQTY := Value;
end;

procedure TfrmPartNumberEditorDlg.SetDefaultVendorWarranty(const Value: integer);
begin
  FDefaultVendorWarranty := Value;
end;

procedure TfrmPartNumberEditorDlg.SetGoodsID(const Value: integer);
begin
  FGoodsID := Value;
end;

procedure TfrmPartNumberEditorDlg.SetOnCheckPartNoExists(const Value: TOnCheckPartNoExists);
begin
  FOnCheckPartNoExists := Value;
end;

procedure TfrmPartNumberEditorDlg.WhenCancelForm;
begin
  if IBCQueryPARTS_Comments.State in dsEditModes then
    IBCQueryPARTS_Comments.Cancel;
  fMasterDataSet.Cancel;
end;

end.

