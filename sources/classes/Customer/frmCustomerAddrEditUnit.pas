unit frmCustomerAddrEditUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxDBEdit, DialogTitle, Data.DB, MemDS, DBAccess, IBC,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, dxUIAClasses;

type
  TfrmCustomerAddrEditDlg = class(TSWNMasteredFormClass)
    IBCDataSourceCity: TIBCDataSource;
    IBCQueryCity: TIBCQuery;
    DialogTitle1: TDialogTitle;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    IBCQueryTipAdresa: TIBCQuery;
    IBCDataSourceTipAdresa: TIBCDataSource;
    IBCDataSourceCountries: TIBCDataSource;
    IBCQueryCountries: TIBCQuery;
    IBCDataSourceDistricts: TIBCDataSource;
    IBCQueryDistricts: TIBCQuery;
    Panel1: TPanel;
    cxLabel14: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    lcbCity: TcxDBLookupComboBox;
    lcbCountry: TcxDBLookupComboBox;
    lcbDistrict: TcxDBLookupComboBox;
    teComments: TcxDBTextEdit;
    lcbAddrTypes: TcxDBLookupComboBox;
    teStreet: TcxDBTextEdit;
    procedure cmbCityPropertiesCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lcbDistrictPropertiesInitPopup(Sender: TObject);
    procedure lcbAddrTypesPropertiesChange(Sender: TObject);
    procedure lcbCountryPropertiesChange(Sender: TObject);
    procedure lcbCityPropertiesChange(Sender: TObject);
    procedure lcbDistrictPropertiesChange(Sender: TObject);
  private
    FIsNewRecord: Boolean;
    FCustomerID: integer;
    procedure SetIsNewRecord(const Value: Boolean);
    { Private declarations }
  protected
    procedure Prepare; override;
    procedure BindingDataSource; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    property IsNewRecord: Boolean read FIsNewRecord write SetIsNewRecord;
    property CustomerID: integer read FCustomerID write FCustomerID;
    { Public declarations }
  end;

var
  frmCustomerAddrEditDlg: TfrmCustomerAddrEditDlg;

implementation

{$R *.dfm}

uses DataModuleDB, DataModuleAdditions;

{ TfrmCustomerAddrEditDlg }

procedure TfrmCustomerAddrEditDlg.cmbCityPropertiesCloseUp(Sender: TObject);
begin
   IBCQueryDistricts.Close;
   IBCQueryDistricts.ParamByName('CITYID').AsInteger := IBCQueryCity.FieldByName('CITYID').AsInteger;
   IBCQueryDistricts.Open;

   fMasterDataSet.FieldByName('DISTRICTID').Clear;
end;

procedure TfrmCustomerAddrEditDlg.FormShow(Sender: TObject);
begin
   if IsNewRecord then
       lcbDistrict.SetFocus
   else
       teStreet.SetFocus;
end;

procedure TfrmCustomerAddrEditDlg.BindingDataSource;
begin
  inherited;
  lcbAddrTypes.DataBinding.DataSource := fMasterDataSource;
  lcbCountry.DataBinding.DataSource := fMasterDataSource;
  lcbCity.DataBinding.DataSource := fMasterDataSource;
  lcbDistrict.DataBinding.DataSource := fMasterDataSource;
  teStreet.DataBinding.DataSource := fMasterDataSource;
  teComments.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmCustomerAddrEditDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  try
  if fMasterDataSet.State in (dsEditModes) then
  begin
     fMasterDataSet.Post;
  end;
  except on e: Exception do
    raise;
  end;
end;

procedure TfrmCustomerAddrEditDlg.lcbAddrTypesPropertiesChange(Sender: TObject);
begin
    if fMasterDataSet.state in (dsEditModes) then
        fMasterDataSet.FieldByName('ADDRTYPE_NAME').AsString := IBCQueryTipAdresa.FieldByName('ADDRTYPE_NAME').AsString;
end;

procedure TfrmCustomerAddrEditDlg.lcbCityPropertiesChange(Sender: TObject);
begin
    if fMasterDataSet.state in (dsEditModes) then
        fMasterDataSet.FieldByName('CITY_NAME').AsString := IBCQueryCity.FieldByName('CITY_NAME').AsString;
end;

procedure TfrmCustomerAddrEditDlg.lcbCountryPropertiesChange(Sender: TObject);
begin
    if fMasterDataSet.state in (dsEditModes) then
        fMasterDataSet.FieldByName('Country_NAME').AsString := IBCQueryCountries.FieldByName('COUNTRY_NAME').AsString;
end;

procedure TfrmCustomerAddrEditDlg.lcbDistrictPropertiesChange(Sender: TObject);
begin
    if fMasterDataSet.state in (dsEditModes) then
        fMasterDataSet.FieldByName('DISTRICT_NAME').AsString := IBCQueryDistricts.FieldByName('DISTRICT_NAME').AsString;
end;

procedure TfrmCustomerAddrEditDlg.lcbDistrictPropertiesInitPopup(Sender: TObject);
begin
   IBCQueryDistricts.Close;
   IBCQueryDistricts.ParamByName('CITYID').AsInteger := IBCQueryCity.FieldByName('CITYID').AsInteger;
   IBCQueryDistricts.Open;
end;

procedure TfrmCustomerAddrEditDlg.Prepare;
begin
   IBCQueryTipAdresa.Transaction := fMasterDataSet.Transaction;
   IBCQueryTipAdresa.Open;

   IBCQueryCountries.Transaction := fMasterDataSet.Transaction;
   IBCQueryCountries.Open;

   IBCQueryCity.Transaction := fMasterDataSet.Transaction;
   IBCQueryCity.Open;


   IBCQueryDistricts.Close;
   IBCQueryDistricts.Transaction := fMasterDataSet.Transaction;
   IBCQueryDistricts.ParamByName('CITYID').AsInteger := IBCQueryCity.FieldByName('CITYID').AsInteger;
   IBCQueryDistricts.Open;

   if IsNewRecord then
   begin
      fMasterDataSet.Append;
      MasterDataSet.FieldByName('customerid').AsInteger := FCustomerID;
      fMasterDataSet.FieldByName('COUNTRYID').AsInteger := dmdb.CountryID;
      fMasterDataSet.FieldByName('COUNTRY_NAME').AsString := dmdb.CountryName;
      fMasterDataSet.FieldByName('CITYID').AsInteger := 2000;
      fMasterDataSet.FieldByName('CITY_NAME').AsString := 'Chisinau';
      fMasterDataSet.FieldByName('ADDRTYPEID').AsInteger:= 7662; // Adresa fizica
      fMasterDataSet.FieldByName('ADDRTYPE_NAME').AsString := 'Adresa fizica';
   end
   else
   begin
      fMasterDataSet.Edit;
   end;
end;

procedure TfrmCustomerAddrEditDlg.SetIsNewRecord(const Value: Boolean);
begin
   FIsNewRecord := Value;
end;

procedure TfrmCustomerAddrEditDlg.WhenCancelForm;
begin
   if (fMasterDataSet.State in (dsEditModes)) then
     fMasterDataSet.Cancel;
end;

end.
