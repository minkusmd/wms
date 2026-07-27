object frmCustomerAddrEditDlg: TfrmCustomerAddrEditDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Adresele clientilor'
  ClientHeight = 364
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 583
    Height = 64
    Title = 'Adresele clientilor'
    Text = 'Gestionarea adreselor clientilor'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 3
  end
  object cxButton1: TcxButton
    Left = 184
    Top = 325
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object cxButton2: TcxButton
    Left = 288
    Top = 324
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 8
    Top = 70
    Width = 567
    Height = 241
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxLabel14: TLabel
      Left = 18
      Top = 90
      Width = 24
      Height = 15
      Caption = 'Oras'
      Transparent = True
    end
    object Label1: TLabel
      Left = 18
      Top = 53
      Width = 22
      Height = 15
      Caption = 'Tara'
      Transparent = True
    end
    object Label2: TLabel
      Left = 18
      Top = 126
      Width = 86
      Height = 15
      Caption = 'Localitate/Raion'
      Transparent = True
    end
    object Label4: TLabel
      Left = 16
      Top = 199
      Width = 63
      Height = 15
      Caption = 'Comentariu'
      Transparent = True
    end
    object Label5: TLabel
      Left = 18
      Top = 17
      Width = 54
      Height = 15
      Caption = 'Tip adresa'
      Transparent = True
    end
    object Label3: TLabel
      Left = 18
      Top = 163
      Width = 33
      Height = 15
      Caption = 'Strada'
      Transparent = True
    end
    object lcbCity: TcxDBLookupComboBox
      Left = 98
      Top = 87
      DataBinding.DataField = 'CITYID'
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 350
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'CITYID'
      Properties.ListColumns = <
        item
          FieldName = 'CITY_NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceCity
      Properties.OnChange = lcbCityPropertiesChange
      Properties.OnCloseUp = cmbCityPropertiesCloseUp
      TabOrder = 2
      Width = 199
    end
    object lcbCountry: TcxDBLookupComboBox
      Left = 98
      Top = 50
      DataBinding.DataField = 'COUNTRYID'
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 350
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'COUNTRYID'
      Properties.ListColumns = <
        item
          FieldName = 'COUNTRY_NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceCountries
      Properties.OnChange = lcbCountryPropertiesChange
      TabOrder = 1
      Width = 199
    end
    object lcbDistrict: TcxDBLookupComboBox
      Left = 98
      Top = 123
      DataBinding.DataField = 'DISTRICTID'
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 350
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'DISTRICTID'
      Properties.ListColumns = <
        item
          FieldName = 'DISTRICT_NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceDistricts
      Properties.OnChange = lcbDistrictPropertiesChange
      Properties.OnInitPopup = lcbDistrictPropertiesInitPopup
      TabOrder = 3
      Width = 199
    end
    object teComments: TcxDBTextEdit
      Left = 98
      Top = 196
      DataBinding.DataField = 'COMMENTS'
      TabOrder = 5
      Width = 447
    end
    object lcbAddrTypes: TcxDBLookupComboBox
      Left = 98
      Top = 14
      DataBinding.DataField = 'ADDRTYPEID'
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 350
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'ADDRTYPEID'
      Properties.ListColumns = <
        item
          Caption = 'Denumire'
          Width = 150
          FieldName = 'ADDRTYPE_NAME'
        end
        item
          Caption = 'Cod'
          Width = 40
          FieldName = 'ADDRTYPEID'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceTipAdresa
      Properties.OnChange = lcbAddrTypesPropertiesChange
      TabOrder = 0
      Width = 199
    end
    object teStreet: TcxDBTextEdit
      Left = 98
      Top = 160
      DataBinding.DataField = 'STREET'
      TabOrder = 4
      Width = 447
    end
  end
  object IBCDataSourceCity: TIBCDataSource
    DataSet = IBCQueryCity
    Left = 463
    Top = 54
  end
  object IBCQueryCity: TIBCQuery
    SQL.Strings = (
      'SELECT DISTINCT'
      'CITYID,'
      'TITLE CITY_NAME'
      'FROM'
      ' GET_CITIES')
    MasterSource = IBCDataSourceCountries
    Left = 463
    Top = 92
  end
  object IBCQueryTipAdresa: TIBCQuery
    SQL.Strings = (
      'select * from GET_ADDR_TYPES')
    Left = 539
    Top = 92
  end
  object IBCDataSourceTipAdresa: TIBCDataSource
    DataSet = IBCQueryTipAdresa
    Left = 539
    Top = 54
  end
  object IBCDataSourceCountries: TIBCDataSource
    DataSet = IBCQueryCountries
    Left = 539
    Top = 16
  end
  object IBCQueryCountries: TIBCQuery
    SQL.Strings = (
      'select * from GET_CONTRIES')
    Left = 539
    Top = 130
  end
  object IBCDataSourceDistricts: TIBCDataSource
    DataSet = IBCQueryDistricts
    Left = 463
    Top = 16
  end
  object IBCQueryDistricts: TIBCQuery
    KeyFields = 'DISTRICTID'
    SQL.Strings = (
      'select * from get_city_district (:cityid)')
    Left = 463
    Top = 130
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cityid'
        Value = nil
      end>
  end
end
