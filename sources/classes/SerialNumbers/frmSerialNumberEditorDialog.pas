unit frmSerialNumberEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, DB, IBC, MemDS, StdCtrls, cxDBEdit,
  ExtCtrls, cxButtonEdit, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, DBAccess, cxCurrencyEdit, cxMaskEdit, cxTextEdit, cxMemo;

type
  TfrmSerialNumberEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnInputs: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    cxLabel4: TLabel;
    mmCOMMENTS: TcxDBMemo;
    edVENDORWARRANTY: TcxDBMaskEdit;
    edOWNWARRANTY: TcxDBMaskEdit;
    edSN: TcxDBMaskEdit;
    cxLabel5: TLabel;
    edSUMA_ACCIZE: TcxDBCurrencyEdit;
    cxLabel6: TLabel;
    IBCQuerySN_Comments: TIBCQuery;
    IBCDataSourceSN_Comments: TIBCDataSource;
    Label1: TLabel;
    Label2: TLabel;
    beCountryID: TcxButtonEdit;
    beVendorID: TcxButtonEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure beCountryIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beVendorIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fCreateNewSerial: Boolean;
    FComplect_SN: String;
    FDefaultVendorWarranty: Integer;
    FDefaultOwnWarranty: Integer;
    FGoodsID: Integer;
    procedure SetCreateNewSerial(const Value: Boolean);
    function CheckParams: Boolean;
    procedure SetComplect_SN(const Value: String);
    procedure SetDefaultVendorWarranty(const Value: Integer);
    procedure SetDefaultOwnWarranty(const Value: Integer);

    procedure SelectCountry;
    procedure SelectVendor;
    procedure SetGoodsID(const Value: Integer);

  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;

    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewSerial: Boolean read fCreateNewSerial write SetCreateNewSerial;
    property Complect_SN: String write SetComplect_SN;
    property DefaultVendorWarranty: Integer write SetDefaultVendorWarranty;
    property DefaultOwnWarranty: Integer write SetDefaultOwnWarranty;
    property GoodsID: Integer read FGoodsID write SetGoodsID;
  end;

implementation

uses SWNUtils, SWNConst, frmSyssEditorWindow, DataModuleDB, SWNValueStorageUnit;

{$R *.dfm}
{ TfrmSerialNumberEditorDlg }

procedure TfrmSerialNumberEditorDlg.beCountryIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCountry;
end;

procedure TfrmSerialNumberEditorDlg.beVendorIDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectVendor;
end;

function TfrmSerialNumberEditorDlg.CheckParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('SN').IsNull or (fMasterDataSet.FieldByName('SN').AsString = '') or
    (Not ValidateTextForSerial(fMasterDataSet.FieldByName('SN').AsString)) then
    AddErrorToStr(ErrorStr, 'Numar de serie!');
  if fMasterDataSet.FieldByName('VENDORWARRANTY').IsNull or (fMasterDataSet.FieldByName('VENDORWARRANTY').AsInteger < 0) then
    AddErrorToStr(ErrorStr, 'Garantia producatorului!');
  if fMasterDataSet.FieldByName('OWNWARRANTY').IsNull or (fMasterDataSet.FieldByName('OWNWARRANTY').AsInteger < 0) then
    AddErrorToStr(ErrorStr, 'Garantia vinzatorului!');

  if fMasterDataSet.FieldByName('COUNTRYID').IsNull or (fMasterDataSet.FieldByName('COUNTRYID').AsInteger < 0) then
    AddErrorToStr(ErrorStr, 'Tara producatoare!');
  if fMasterDataSet.FieldByName('VENDORID').IsNull or (fMasterDataSet.FieldByName('VENDORID').AsInteger < 0) then
    AddErrorToStr(ErrorStr, 'Producator!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmSerialNumberEditorDlg.BindingDataSource;
begin
  inherited;

  FGoodsID := -1;
  fCreateNewSerial := False;
  FComplect_SN := ''; // = NULL
  FDefaultVendorWarranty := 0;
  FDefaultOwnWarranty := 0;

  edSN.DataBinding.DataSource := fMasterDataSource;
  edVENDORWARRANTY.DataBinding.DataSource := fMasterDataSource;
  edOWNWARRANTY.DataBinding.DataSource := fMasterDataSource;
  edSUMA_ACCIZE.DataBinding.DataSource := fMasterDataSource;

  IBCQuerySN_Comments.Transaction := fMasterDataSet.UpdateTransaction;
  IBCQuerySN_Comments.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQuerySN_Comments.MasterSource := fMasterDataSource;

end;

function TfrmSerialNumberEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    if IBCQuerySN_Comments.State in dsEditModes then
      IBCQuerySN_Comments.FieldByName('CREATED_BY').AsInteger := UserID;
    fMasterDataSet.Post;
    if IBCQuerySN_Comments.State in dsEditModes then
      IBCQuerySN_Comments.Post;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmSerialNumberEditorDlg.Prepare;
var
  info: TGoodsInfo_VendorAndCountry;
begin
  try
    if fCreateNewSerial then
    begin
      dtDialogTitle.Text := 'Introduce numar de serie nou';
      fMasterDataSet.Append;
      fMasterDataSet.FieldByName('CREATED_BY').AsInteger := UserID;
      fMasterDataSet.FieldByName('VENDORWARRANTY').AsInteger := FDefaultVendorWarranty;
      fMasterDataSet.FieldByName('OWNWARRANTY').AsInteger := FDefaultOwnWarranty;
      fMasterDataSet.FieldByName('SUMA_ACCIZE').AsCurrency := 0;

      info := dmDB.GetGoodsInfo_SN_VendorCountry(FGoodsID);
      if Assigned(info) then
      begin
        if info.CountryID = -1 then
        begin
          info.CountryID := AppUserConfigStorage.IntValues.GetValue('SerialNumber_DefaultCountryID', -1);
          info.CountryTitle := dmDB.GetSyssTitleByID(info.CountryID);
        end;
        if info.VendorID = -1 then
        begin
          info.VendorID := AppUserConfigStorage.IntValues.GetValue('SerialNumber_DefaultVendorID', -1);
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
      dtDialogTitle.Text := 'Modifica numar de serie';
      fMasterDataSet.Edit;
      fMasterDataSet.FieldByName('CREATED_BY').AsInteger := UserID;
      edSUMA_ACCIZE.Enabled := False;

      beCountryID.Text := fMasterDataSet.FieldByName('COUNTRY_TITLE').AsString;
      beVendorID.Text := fMasterDataSet.FieldByName('VENDOR_TITLE').AsString;
    end;
    IBCQuerySN_Comments.Active := True;
  except
    fMasterDataSet.Cancel;
    IBCQuerySN_Comments.Cancel;
    IBCQuerySN_Comments.Close;
    raise;
  end;
end;

procedure TfrmSerialNumberEditorDlg.SelectCountry;
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
      AppUserConfigStorage.IntValues.SetValue('SerialNumber_DefaultCountryID', dialog.SYSSID);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSerialNumberEditorDlg.SelectVendor;
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
      AppUserConfigStorage.IntValues.SetValue('SerialNumber_DefaultVendorID', dialog.SYSSID);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSerialNumberEditorDlg.SetComplect_SN(const Value: String);
begin
  FComplect_SN := Value;
end;

procedure TfrmSerialNumberEditorDlg.SetCreateNewSerial(const Value: Boolean);
begin
  fCreateNewSerial := Value;
end;

procedure TfrmSerialNumberEditorDlg.SetDefaultOwnWarranty(const Value: Integer);
begin
  FDefaultOwnWarranty := Value;
end;

procedure TfrmSerialNumberEditorDlg.SetDefaultVendorWarranty(const Value: Integer);
begin
  FDefaultVendorWarranty := Value;
end;

procedure TfrmSerialNumberEditorDlg.SetGoodsID(const Value: Integer);
begin
  FGoodsID := Value;
end;

procedure TfrmSerialNumberEditorDlg.WhenCancelForm;
begin
  if IBCQuerySN_Comments.State in dsEditModes then
    IBCQuerySN_Comments.Cancel;
  fMasterDataSet.Cancel;
end;

end.
