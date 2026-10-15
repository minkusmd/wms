object frmCompanyCardDlg: TfrmCompanyCardDlg
  Left = 0
  Top = 0
  Caption = 'Fisa companiei'
  ClientHeight = 700
  ClientWidth = 980
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 860
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object pnButtons: TPanel
    Left = 0
    Top = 652
    Width = 980
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object lblRequired: TLabel
      Left = 16
      Top = 16
      Width = 200
      Height = 15
      Caption = '* - obligatoriu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object btnSave: TcxButton
      Left = 744
      Top = 9
      Width = 110
      Height = 31
      Anchors = [akTop, akRight]
      Caption = 'Salveaza'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 860
      Top = 9
      Width = 110
      Height = 31
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object lcMain: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 980
    Height = 652
    Align = alClient
    TabOrder = 0
    LayoutLookAndFeel = lafCx
    object imgHeaderLogo: TcxImage
      Left = 0
      Top = 0
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.PopupMenuLayout.MenuItems = []
      Properties.ReadOnly = True
      Properties.ShowFocusRect = False
      Properties.Stretch = True
      Style.BorderStyle = ebsNone
      Style.HotTrack = False
      Transparent = True
      Height = 72
      Width = 72
    end
    object lblTitle: TcxLabel
      Left = 0
      Top = 0
      Caption = 'Companie noua'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -21
      Style.Font.Name = 'Segoe UI Semibold'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
      Style.HotTrack = False
    end
    object lblSubtitle: TcxLabel
      Left = 0
      Top = 0
      Caption = 'Datele de la ASP, SFS si BNS, rechizitele bancare, logotipul si semnaturile'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clGrayText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
      Style.HotTrack = False
    end
    object cbKind: TcxComboBox
      Left = 0
      Top = 0
      Properties.Items.Strings = (
        'Persoana juridica'
        'Subdiviziune (filiala, reprezentanta, punct de vinzare)'
        'Intreprinzator individual')
      Properties.DropDownListStyle = lsFixedList
      Properties.OnChange = cbKindPropertiesChange
      Style.HotTrack = False
      Width = 360
    end
    object lcbParent: TcxLookupComboBox
      Left = 0
      Top = 0
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsFirms
      Properties.OnEditValueChanged = lcbParentPropertiesEditValueChanged
      Style.HotTrack = False
      Width = 420
    end
    object beIDNO: TcxButtonEdit
      Left = 0
      Top = 0
      ParentShowHint = False
      Properties.Buttons = <
        item
          Caption = 'SFS'
          Default = True
          Hint = 'Date din Registrul fiscal (API e-Factura): denumire, adresa, cod TVA, conturi'
          Kind = bkText
        end
        item
          Caption = 'ASP'
          Hint = 'Date din registrul de stat (copia CUSTOMERS_REGISTRU): forma, CAEM, fondatori, conducator'
          Kind = bkText
        end>
      Properties.MaxLength = 13
      Properties.OnButtonClick = beIDNOPropertiesButtonClick
      ShowHint = True
      Style.HotTrack = False
      Width = 200
    end
    object edName: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 280
    end
    object edFullName: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 512
      Style.HotTrack = False
      Width = 280
    end
    object cbOrgForm: TcxComboBox
      Left = 0
      Top = 0
      Properties.Items.Strings = (
        'Societate cu raspundere limitata'
        'Societate pe actiuni'
        'Intreprindere individuala'
        'Gospodarie taraneasca (de fermier)'
        'Cooperativa de productie'
        'Intreprindere de stat'
        'Asociatie obsteasca'
        'Institutie publica')
      Properties.MaxLength = 128
      Style.HotTrack = False
      Width = 280
    end
    object deRegDate: TcxDateEdit
      Left = 0
      Top = 0
      Style.HotTrack = False
      Width = 130
    end
    object edRegAuthority: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 280
    end
    object ceCapital: TcxCurrencyEdit
      Left = 0
      Top = 0
      Properties.DisplayFormat = ',0.00;-,0.00'
      Style.HotTrack = False
      Width = 150
    end
    object chkVatPayer: TcxCheckBox
      Left = 0
      Top = 0
      Caption = 'Platitor de TVA'
      Properties.OnChange = chkVatPayerPropertiesChange
      Transparent = True
      Style.HotTrack = False
    end
    object edVatCode: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 32
      Style.HotTrack = False
      Width = 150
    end
    object deVatRegDate: TcxDateEdit
      Left = 0
      Top = 0
      Style.HotTrack = False
      Width = 130
    end
    object cbVatRate: TcxComboBox
      Left = 0
      Top = 0
      Properties.Items.Strings = (
        '20'
        '12'
        '8'
        '0')
      Properties.DropDownListStyle = lsFixedList
      Style.HotTrack = False
      Width = 80
    end
    object cbChiefPosition: TcxComboBox
      Left = 0
      Top = 0
      Properties.Items.Strings = (
        'Administrator'
        'Director'
        'Director general'
        'Presedinte'
        'Conducator')
      Properties.MaxLength = 64
      Style.HotTrack = False
      Width = 280
    end
    object edChief: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 32
      Style.HotTrack = False
      Width = 280
    end
    object edAccountant: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 32
      Style.HotTrack = False
      Width = 280
    end
    object edCashier: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 64
      Style.HotTrack = False
      Width = 280
    end
    object mmFounders: TcxMemo
      Left = 0
      Top = 0
      Properties.MaxLength = 4000
      Properties.ScrollBars = ssVertical
      Style.HotTrack = False
      Height = 52
      Width = 280
    end
    object lcbCityJ: TcxLookupComboBox
      Left = 0
      Top = 0
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'CITYID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsCities
      Properties.OnEditValueChanged = lcbCityJPropertiesEditValueChanged
      Style.HotTrack = False
      Width = 280
    end
    object lcbDistrictJ: TcxLookupComboBox
      Left = 0
      Top = 0
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'DISTRICTID'
      Properties.ListColumns = <
        item
          FieldName = 'DISTRICT_NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsDistrictJ
      Style.HotTrack = False
      Width = 280
    end
    object edStreetJ: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 520
    end
    object chkSameAddress: TcxCheckBox
      Left = 0
      Top = 0
      Caption = 'Coincide cu adresa juridica'
      Properties.OnChange = chkSameAddressPropertiesChange
      Transparent = True
      Style.HotTrack = False
    end
    object lcbCityF: TcxLookupComboBox
      Left = 0
      Top = 0
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'CITYID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsCities
      Properties.OnEditValueChanged = lcbCityFPropertiesEditValueChanged
      Style.HotTrack = False
      Width = 280
    end
    object lcbDistrictF: TcxLookupComboBox
      Left = 0
      Top = 0
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'DISTRICTID'
      Properties.ListColumns = <
        item
          FieldName = 'DISTRICT_NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsDistrictF
      Style.HotTrack = False
      Width = 280
    end
    object edStreetF: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 520
    end
    object edPhone: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 16
      Style.HotTrack = False
      Width = 180
    end
    object edMobile: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 16
      Style.HotTrack = False
      Width = 180
    end
    object edEmail: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 128
      Style.HotTrack = False
      Width = 280
    end
    object edWeb: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 280
    end
    object edSfsOffice: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 420
    end
    object edSubdivCode: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 16
      Style.HotTrack = False
      Width = 150
    end
    object edCUIIO: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 16
      Style.HotTrack = False
      Width = 150
    end
    object edCFOJ: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 8
      Style.HotTrack = False
      Width = 100
    end
    object edCFP: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 8
      Style.HotTrack = False
      Width = 100
    end
    object edCUATM: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 16
      Style.HotTrack = False
      Width = 100
    end
    object edCAEMMain: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 16
      Style.HotTrack = False
      Width = 100
    end
    object mmCAEMList: TcxMemo
      Left = 0
      Top = 0
      Properties.MaxLength = 2000
      Properties.ScrollBars = ssVertical
      Style.HotTrack = False
      Height = 60
      Width = 280
    end
    object btnAccAdd: TcxButton
      Left = 0
      Top = 0
      Caption = 'Adauga cont'
      OnClick = btnAccAddClick
      Height = 27
      Width = 120
    end
    object btnAccDelete: TcxButton
      Left = 0
      Top = 0
      Caption = 'Sterge contul'
      OnClick = btnAccDeleteClick
      Height = 27
      Width = 120
    end
    object btnAccSfs: TcxButton
      Left = 0
      Top = 0
      Caption = 'Conturile din SFS'
      Hint = 'Adauga conturile IBAN inregistrate la SFS care lipsesc din lista'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnAccSfsClick
      Height = 27
      Width = 150
    end
    object gridAccounts: TcxGrid
      Left = 0
      Top = 0
      Width = 700
      Height = 300
      object tvAccounts: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.NoDataToDisplayInfoText = '<Niciun cont: Adauga cont sau Conturile din SFS>'
        object colAccDefault: TcxGridColumn
          Caption = 'Implicit'
          DataBinding.ValueType = 'Boolean'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.OnEditValueChanged = colAccDefaultPropertiesEditValueChanged
          Width = 55
        end
        object colAccCurrent: TcxGridColumn
          Caption = 'Cont curent'
          DataBinding.ValueType = 'Boolean'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Width = 75
        end
        object colAccName: TcxGridColumn
          Caption = 'Denumire'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.MaxLength = 60
          Width = 150
        end
        object colAccIBAN: TcxGridColumn
          Caption = 'IBAN'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.CharCase = ecUpperCase
          Properties.MaxLength = 32
          Width = 200
        end
        object colAccBank: TcxGridColumn
          Caption = 'Codul bancii'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.CharCase = ecUpperCase
          Properties.DropDownRows = 20
          Properties.MaxLength = 32
          Properties.Sorted = True
          Properties.OnEditValueChanged = colAccBankPropertiesEditValueChanged
          Width = 110
        end
        object colAccBankName: TcxGridColumn
          Caption = 'Banca'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.MaxLength = 255
          Width = 220
        end
        object colAccOrig: TcxGridColumn
          Caption = 'IBAN initial'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object lvAccounts: TcxGridLevel
        GridView = tvAccounts
      end
    end
    object lblAccHint: TcxLabel
      Left = 0
      Top = 0
      Caption = 'IBAN: MD + 22 caractere, verificat dupa cifrele de control. Contul "Implicit" apare pe documente cind nu e ales altul.'
      Properties.WordWrap = True
      Style.TextColor = clGrayText
      Transparent = True
      Style.HotTrack = False
      Width = 700
    end
    object imgLogo: TcxImage
      Left = 0
      Top = 0
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.Stretch = True
      Properties.OnChange = imgLogoPropertiesChange
      Style.HotTrack = False
      Height = 130
      Width = 220
    end
    object btnImgLoadLogo: TcxButton
      Left = 0
      Top = 0
      Tag = 0
      Caption = 'Incarca...'
      OnClick = btnImgLoadClick
      Height = 27
      Width = 100
    end
    object btnImgClearLogo: TcxButton
      Left = 0
      Top = 0
      Tag = 0
      Caption = 'Sterge'
      OnClick = btnImgClearClick
      Height = 27
      Width = 100
    end
    object imgStamp: TcxImage
      Left = 0
      Top = 0
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.Stretch = True
      Style.HotTrack = False
      Height = 130
      Width = 220
    end
    object btnImgLoadStamp: TcxButton
      Left = 0
      Top = 0
      Tag = 1
      Caption = 'Incarca...'
      OnClick = btnImgLoadClick
      Height = 27
      Width = 100
    end
    object btnImgClearStamp: TcxButton
      Left = 0
      Top = 0
      Tag = 1
      Caption = 'Sterge'
      OnClick = btnImgClearClick
      Height = 27
      Width = 100
    end
    object imgSignature: TcxImage
      Left = 0
      Top = 0
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.Stretch = True
      Style.HotTrack = False
      Height = 130
      Width = 220
    end
    object btnImgLoadSignature: TcxButton
      Left = 0
      Top = 0
      Tag = 2
      Caption = 'Incarca...'
      OnClick = btnImgLoadClick
      Height = 27
      Width = 100
    end
    object btnImgClearSignature: TcxButton
      Left = 0
      Top = 0
      Tag = 2
      Caption = 'Sterge'
      OnClick = btnImgClearClick
      Height = 27
      Width = 100
    end
    object imgCeoSign: TcxImage
      Left = 0
      Top = 0
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.Stretch = True
      Style.HotTrack = False
      Height = 130
      Width = 220
    end
    object btnImgLoadCeoSign: TcxButton
      Left = 0
      Top = 0
      Tag = 3
      Caption = 'Incarca...'
      OnClick = btnImgLoadClick
      Height = 27
      Width = 100
    end
    object btnImgClearCeoSign: TcxButton
      Left = 0
      Top = 0
      Tag = 3
      Caption = 'Sterge'
      OnClick = btnImgClearClick
      Height = 27
      Width = 100
    end
    object imgAccSign: TcxImage
      Left = 0
      Top = 0
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.Stretch = True
      Style.HotTrack = False
      Height = 130
      Width = 220
    end
    object btnImgLoadAccSign: TcxButton
      Left = 0
      Top = 0
      Tag = 4
      Caption = 'Incarca...'
      OnClick = btnImgLoadClick
      Height = 27
      Width = 100
    end
    object btnImgClearAccSign: TcxButton
      Left = 0
      Top = 0
      Tag = 4
      Caption = 'Sterge'
      OnClick = btnImgClearClick
      Height = 27
      Width = 100
    end
    object imgWarranty: TcxImage
      Left = 0
      Top = 0
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.Stretch = True
      Style.HotTrack = False
      Height = 130
      Width = 220
    end
    object btnImgLoadWarranty: TcxButton
      Left = 0
      Top = 0
      Tag = 5
      Caption = 'Incarca...'
      OnClick = btnImgLoadClick
      Height = 27
      Width = 100
    end
    object btnImgClearWarranty: TcxButton
      Left = 0
      Top = 0
      Tag = 5
      Caption = 'Sterge'
      OnClick = btnImgClearClick
      Height = 27
      Width = 100
    end
    object lblImgHint: TcxLabel
      Left = 0
      Top = 0
      Caption = 'Recomandat: PNG cu fundal transparent; semnaturile olografe scanate la 300 dpi si decupate. Imaginile se folosesc pe facturi, oferte si contracte.'
      Properties.WordWrap = True
      Style.TextColor = clGrayText
      Transparent = True
      Style.HotTrack = False
      Width = 700
    end
    object chk1C: TcxCheckBox
      Left = 0
      Top = 0
      Caption = 'Unitatea se leaga de 1C'
      Properties.OnChange = chk1CPropertiesChange
      Transparent = True
      Style.HotTrack = False
    end
    object ed1CFirmaCod: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 9
      Style.HotTrack = False
      Width = 110
    end
    object ed1CFirmaName: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 50
      Style.HotTrack = False
      Width = 280
    end
    object ed1CPfCode: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 9
      Style.HotTrack = False
      Width = 110
    end
    object ed1CPfTitle: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 280
    end
    object ed1CSkladCod: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 9
      Style.HotTrack = False
      Width = 110
    end
    object ed1CTitle: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 50
      Style.HotTrack = False
      Width = 280
    end
    object cb1CType: TcxComboBox
      Left = 0
      Top = 0
      Properties.MaxLength = 50
      Style.HotTrack = False
      Width = 280
    end
    object chk1CActive: TcxCheckBox
      Left = 0
      Top = 0
      Caption = 'Activ (FLAGS = 1)'
      Transparent = True
      Style.HotTrack = False
    end
    object chkCopyDefaults: TcxCheckBox
      Left = 0
      Top = 0
      Caption = 'Copiaza setarile documentelor (firma, depozit, valuta) de la firma-model'
      Properties.OnChange = chkCopyDefaultsPropertiesChange
      Transparent = True
      Style.HotTrack = False
    end
    object lcbModelFirm: TcxLookupComboBox
      Left = 0
      Top = 0
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsFirms
      Style.HotTrack = False
      Width = 420
    end
    object lcbDepot: TcxLookupComboBox
      Left = 0
      Top = 0
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'STOCKID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsStocks
      Style.HotTrack = False
      Width = 420
    end
    object chkGrantAccess: TcxCheckBox
      Left = 0
      Top = 0
      Caption = 'Acorda-mi acces la unitatea noua (lista firmelor din bara principala)'
      Transparent = True
      Style.HotTrack = False
    end
    object chkEcc: TcxCheckBox
      Left = 0
      Top = 0
      Caption = 'Firma emite bonuri fiscale prin casa de marcat virtuala ECC (Fiscal Partner)'
      Properties.OnChange = chkEccPropertiesChange
      Transparent = True
      Style.HotTrack = False
    end
    object cbEccCode: TcxComboBox
      Left = 0
      Top = 0
      Properties.MaxLength = 30
      Properties.CharCase = ecUpperCase
      Properties.OnEditValueChanged = cbEccCodePropertiesEditValueChanged
      Style.HotTrack = False
      Width = 200
    end
    object cbEccServer: TcxComboBox
      Left = 0
      Top = 0
      Properties.Items.Strings = (
        'https://sc.fiscalpartner.md'
        'https://demo-13.fiscalpartner.md')
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 300
    end
    object edEccApiKey: TcxTextEdit
      Left = 0
      Top = 0
      Properties.EchoMode = eemPassword
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 300
    end
    object edEccPosId: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 300
    end
    object edEccPosName: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 300
    end
    object edEccCashier: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 300
    end
    object edEccTax20: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 2
      Style.HotTrack = False
      Width = 45
    end
    object edEccTax8: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 2
      Style.HotTrack = False
      Width = 45
    end
    object edEccTax0: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 2
      Style.HotTrack = False
      Width = 45
    end
    object edEccTaxNone: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 2
      Style.HotTrack = False
      Width = 45
    end
    object lcbEccWorkstation: TcxLookupComboBox
      Left = 0
      Top = 0
      Properties.ClearKey = 46
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'WS_ID'
      Properties.ListColumns = <
        item
          FieldName = 'COMPUTER_NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsWorkstations
      Style.HotTrack = False
      Width = 260
    end
    object edEccDescription: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 260
    end
    object chkEccEnabled: TcxCheckBox
      Left = 0
      Top = 0
      Caption = 'Casa activa'
      Transparent = True
      Style.HotTrack = False
    end
    object edEccTermPosId: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 260
    end
    object edEccTermPosName: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 260
    end
    object edEccTermApiKey: TcxTextEdit
      Left = 0
      Top = 0
      Properties.EchoMode = eemPassword
      Properties.MaxLength = 255
      Style.HotTrack = False
      Width = 260
    end
    object edEccTermTimeout: TcxTextEdit
      Left = 0
      Top = 0
      Properties.MaxLength = 5
      Style.HotTrack = False
      Width = 70
    end
    object btnEccTest: TcxButton
      Left = 0
      Top = 0
      Caption = 'Verifica legatura'
      Hint = 'GET /status pe serverul ECC cu valorile din forma (fara salvare)'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnEccTestClick
      Height = 27
      Width = 150
    end
    object lblEccInfo: TcxLabel
      Left = 0
      Top = 0
      Caption = 'Bonurile din facturi, POS, platile online (@ECC_ONLINE) si livrarile (@ECC_DELIVERY) folosesc casa ECC a firmei din FP_DEVICES. Cheia API se ia din BackOffice ECC > API/Keys.'
      Properties.WordWrap = True
      Style.TextColor = clGrayText
      Transparent = True
      Style.HotTrack = False
      Width = 700
    end
    object mmNote: TcxMemo
      Left = 0
      Top = 0
      Properties.MaxLength = 1024
      Properties.ScrollBars = ssVertical
      Style.HotTrack = False
      Height = 200
      Width = 280
    end
    object lcMainGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object grpHeader: TdxLayoutGroup
      Parent = lcMainGroup_Root
      CaptionOptions.Text = 'Antet'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 0
    end
    object liHeaderLogo: TdxLayoutItem
      Parent = grpHeader
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Logo'
      Control = imgHeaderLogo
      ControlOptions.ShowBorder = False
      AlignVert = avCenter
      Index = 0
    end
    object grpHeaderText: TdxLayoutGroup
      Parent = grpHeader
      CaptionOptions.Text = 'Titlu'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      AlignHorz = ahClient
      AlignVert = avCenter
      Index = 1
    end
    object liTitle: TdxLayoutItem
      Parent = grpHeaderText
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Titlu'
      Control = lblTitle
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liSubtitle: TdxLayoutItem
      Parent = grpHeaderText
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Subtitlu'
      Control = lblSubtitle
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object grpTabs: TdxLayoutGroup
      Parent = lcMainGroup_Root
      CaptionOptions.Text = 'File'
      ButtonOptions.Buttons = <>
      LayoutDirection = ldTabbed
      AlignHorz = ahClient
      AlignVert = avClient
      ShowBorder = False
      Index = 1
    end
    object tabGeneral: TdxLayoutGroup
      Parent = grpTabs
      CaptionOptions.Text = 'General'
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object grpKind: TdxLayoutGroup
      Parent = tabGeneral
      CaptionOptions.Text = 'Tipul unitatii'
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object liKind: TdxLayoutItem
      Parent = grpKind
      CaptionOptions.Text = 'Tipul'
      Control = cbKind
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liParent: TdxLayoutItem
      Parent = grpKind
      CaptionOptions.Text = 'Persoana juridica (firma-mama)'
      Control = lcbParent
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object grpGenCols: TdxLayoutGroup
      Parent = tabGeneral
      CaptionOptions.Text = 'Coloane'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object grpIdent: TdxLayoutGroup
      Parent = grpGenCols
      CaptionOptions.Text = 'Identificare (ASP)'
      ButtonOptions.Buttons = <>
      AlignHorz = ahClient
      Index = 0
    end
    object liIDNO: TdxLayoutItem
      Parent = grpIdent
      CaptionOptions.Text = 'IDNO / cod fiscal *'
      Control = beIDNO
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liName: TdxLayoutItem
      Parent = grpIdent
      CaptionOptions.Text = 'Denumirea in WMS *'
      Control = edName
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liFullName: TdxLayoutItem
      Parent = grpIdent
      CaptionOptions.Text = 'Denumirea completa'
      Control = edFullName
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liOrgForm: TdxLayoutItem
      Parent = grpIdent
      CaptionOptions.Text = 'Forma organizatorico-juridica'
      Control = cbOrgForm
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object liRegDate: TdxLayoutItem
      Parent = grpIdent
      CaptionOptions.Text = 'Data inregistrarii de stat'
      Control = deRegDate
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object liRegAuthority: TdxLayoutItem
      Parent = grpIdent
      CaptionOptions.Text = 'Organul de inregistrare'
      Control = edRegAuthority
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object liCapital: TdxLayoutItem
      Parent = grpIdent
      CaptionOptions.Text = 'Capital social, lei'
      Control = ceCapital
      ControlOptions.ShowBorder = False
      Index = 6
    end
    object grpRight: TdxLayoutGroup
      Parent = grpGenCols
      CaptionOptions.Text = 'Dreapta'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      AlignHorz = ahClient
      Index = 1
    end
    object grpVat: TdxLayoutGroup
      Parent = grpRight
      CaptionOptions.Text = 'TVA'
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object liVatPayer: TdxLayoutItem
      Parent = grpVat
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Platitor'
      Control = chkVatPayer
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liVatCode: TdxLayoutItem
      Parent = grpVat
      CaptionOptions.Text = 'Codul TVA'
      Control = edVatCode
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liVatRegDate: TdxLayoutItem
      Parent = grpVat
      CaptionOptions.Text = 'Data inregistrarii TVA'
      Control = deVatRegDate
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liVatRate: TdxLayoutItem
      Parent = grpVat
      CaptionOptions.Text = 'Cota TVA implicita, %'
      Control = cbVatRate
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object grpManagement: TdxLayoutGroup
      Parent = grpRight
      CaptionOptions.Text = 'Conducere'
      ButtonOptions.Buttons = <>
      Index = 1
    end
    object liChiefPosition: TdxLayoutItem
      Parent = grpManagement
      CaptionOptions.Text = 'Functia conducatorului'
      Control = cbChiefPosition
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liChief: TdxLayoutItem
      Parent = grpManagement
      CaptionOptions.Text = 'Conducator'
      Control = edChief
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liAccountant: TdxLayoutItem
      Parent = grpManagement
      CaptionOptions.Text = 'Contabil-sef'
      Control = edAccountant
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liCashier: TdxLayoutItem
      Parent = grpManagement
      CaptionOptions.Text = 'Casier'
      Control = edCashier
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object liFounders: TdxLayoutItem
      Parent = tabGeneral
      CaptionOptions.Text = 'Fondatori'
      Control = mmFounders
      ControlOptions.ShowBorder = False
      AlignHorz = ahClient
      Index = 2
    end
    object tabAddress: TdxLayoutGroup
      Parent = grpTabs
      CaptionOptions.Text = 'Adrese si contacte'
      ButtonOptions.Buttons = <>
      Index = 1
    end
    object grpAddrJ: TdxLayoutGroup
      Parent = tabAddress
      CaptionOptions.Text = 'Adresa juridica (din registru)'
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object liCityJ: TdxLayoutItem
      Parent = grpAddrJ
      CaptionOptions.Text = 'Localitatea'
      Control = lcbCityJ
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liDistrictJ: TdxLayoutItem
      Parent = grpAddrJ
      CaptionOptions.Text = 'Sectorul'
      Control = lcbDistrictJ
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liStreetJ: TdxLayoutItem
      Parent = grpAddrJ
      CaptionOptions.Text = 'Strada, nr., oficiu'
      Control = edStreetJ
      ControlOptions.ShowBorder = False
      AlignHorz = ahClient
      Index = 2
    end
    object grpAddrF: TdxLayoutGroup
      Parent = tabAddress
      CaptionOptions.Text = 'Adresa fizica (de facto)'
      ButtonOptions.Buttons = <>
      Index = 1
    end
    object liSameAddress: TdxLayoutItem
      Parent = grpAddrF
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Aceeasi'
      Control = chkSameAddress
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liCityF: TdxLayoutItem
      Parent = grpAddrF
      CaptionOptions.Text = 'Localitatea'
      Control = lcbCityF
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liDistrictF: TdxLayoutItem
      Parent = grpAddrF
      CaptionOptions.Text = 'Sectorul'
      Control = lcbDistrictF
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liStreetF: TdxLayoutItem
      Parent = grpAddrF
      CaptionOptions.Text = 'Strada, nr., oficiu'
      Control = edStreetF
      ControlOptions.ShowBorder = False
      AlignHorz = ahClient
      Index = 3
    end
    object grpContacts: TdxLayoutGroup
      Parent = tabAddress
      CaptionOptions.Text = 'Contacte'
      ButtonOptions.Buttons = <>
      Index = 2
    end
    object liPhone: TdxLayoutItem
      Parent = grpContacts
      CaptionOptions.Text = 'Telefon (serviciu)'
      Control = edPhone
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liMobile: TdxLayoutItem
      Parent = grpContacts
      CaptionOptions.Text = 'Telefon mobil'
      Control = edMobile
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liEmail: TdxLayoutItem
      Parent = grpContacts
      CaptionOptions.Text = 'E-mail'
      Control = edEmail
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liWeb: TdxLayoutItem
      Parent = grpContacts
      CaptionOptions.Text = 'Site web'
      Control = edWeb
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object tabFiscal: TdxLayoutGroup
      Parent = grpTabs
      CaptionOptions.Text = 'Fisc si statistica'
      ButtonOptions.Buttons = <>
      Index = 2
    end
    object grpSfs: TdxLayoutGroup
      Parent = tabFiscal
      CaptionOptions.Text = 'Serviciul Fiscal de Stat'
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object liSfsOffice: TdxLayoutItem
      Parent = grpSfs
      CaptionOptions.Text = 'Subdiviziunea teritoriala SFS'
      Control = edSfsOffice
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liSubdivCode: TdxLayoutItem
      Parent = grpSfs
      CaptionOptions.Text = 'Codul subdiviziunii (atribuit de SFS)'
      Control = edSubdivCode
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object grpBns: TdxLayoutGroup
      Parent = tabFiscal
      CaptionOptions.Text = 'Clasificatoare (BNS)'
      ButtonOptions.Buttons = <>
      Index = 1
    end
    object liCUIIO: TdxLayoutItem
      Parent = grpBns
      CaptionOptions.Text = 'CUIIO (Registrul statistic)'
      Control = edCUIIO
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liCFOJ: TdxLayoutItem
      Parent = grpBns
      CaptionOptions.Text = 'CFOJ (forma org.-juridica)'
      Control = edCFOJ
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liCFP: TdxLayoutItem
      Parent = grpBns
      CaptionOptions.Text = 'CFP (forma de proprietate)'
      Control = edCFP
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liCUATM: TdxLayoutItem
      Parent = grpBns
      CaptionOptions.Text = 'CUATM (unitatea teritoriala)'
      Control = edCUATM
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object liCAEMMain: TdxLayoutItem
      Parent = grpBns
      CaptionOptions.Text = 'CAEM - activitatea principala'
      Control = edCAEMMain
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object liCAEMList: TdxLayoutItem
      Parent = grpBns
      CaptionOptions.Text = 'CAEM - alte activitati'
      Control = mmCAEMList
      ControlOptions.ShowBorder = False
      AlignHorz = ahClient
      Index = 5
    end
    object tabAccounts: TdxLayoutGroup
      Parent = grpTabs
      CaptionOptions.Text = 'Conturi bancare'
      ButtonOptions.Buttons = <>
      Index = 3
    end
    object grpAccButtons: TdxLayoutGroup
      Parent = tabAccounts
      CaptionOptions.Text = 'Butoane'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 0
    end
    object liAccAdd: TdxLayoutItem
      Parent = grpAccButtons
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Adauga'
      Control = btnAccAdd
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liAccDelete: TdxLayoutItem
      Parent = grpAccButtons
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Sterge'
      Control = btnAccDelete
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liAccSfs: TdxLayoutItem
      Parent = grpAccButtons
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'SFS'
      Control = btnAccSfs
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liAccGrid: TdxLayoutItem
      Parent = tabAccounts
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Conturi'
      Control = gridAccounts
      ControlOptions.ShowBorder = False
      AlignHorz = ahClient
      AlignVert = avClient
      Index = 1
    end
    object liAccHint: TdxLayoutItem
      Parent = tabAccounts
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Nota'
      Control = lblAccHint
      ControlOptions.ShowBorder = False
      AlignHorz = ahClient
      Index = 2
    end
    object tabImages: TdxLayoutGroup
      Parent = grpTabs
      CaptionOptions.Text = 'Logo, stampila, semnaturi'
      ButtonOptions.Buttons = <>
      Index = 4
    end
    object grpImgRow0: TdxLayoutGroup
      Parent = tabImages
      CaptionOptions.Text = 'Rind'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 0
    end
    object grpImgLogo: TdxLayoutGroup
      Parent = grpImgRow0
      CaptionOptions.Text = 'Logotipul'
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object liImgLogo: TdxLayoutItem
      Parent = grpImgLogo
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Logotipul'
      Control = imgLogo
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object grpImgBtnLogo: TdxLayoutGroup
      Parent = grpImgLogo
      CaptionOptions.Text = 'Butoane'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object liImgLoadLogo: TdxLayoutItem
      Parent = grpImgBtnLogo
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Incarca'
      Control = btnImgLoadLogo
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liImgClearLogo: TdxLayoutItem
      Parent = grpImgBtnLogo
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Sterge'
      Control = btnImgClearLogo
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object grpImgStamp: TdxLayoutGroup
      Parent = grpImgRow0
      CaptionOptions.Text = 'Stampila'
      ButtonOptions.Buttons = <>
      Index = 1
    end
    object liImgStamp: TdxLayoutItem
      Parent = grpImgStamp
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Stampila'
      Control = imgStamp
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object grpImgBtnStamp: TdxLayoutGroup
      Parent = grpImgStamp
      CaptionOptions.Text = 'Butoane'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object liImgLoadStamp: TdxLayoutItem
      Parent = grpImgBtnStamp
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Incarca'
      Control = btnImgLoadStamp
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liImgClearStamp: TdxLayoutItem
      Parent = grpImgBtnStamp
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Sterge'
      Control = btnImgClearStamp
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object grpImgSignature: TdxLayoutGroup
      Parent = grpImgRow0
      CaptionOptions.Text = 'Semnatura (facsimil)'
      ButtonOptions.Buttons = <>
      Index = 2
    end
    object liImgSignature: TdxLayoutItem
      Parent = grpImgSignature
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Semnatura (facsimil)'
      Control = imgSignature
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object grpImgBtnSignature: TdxLayoutGroup
      Parent = grpImgSignature
      CaptionOptions.Text = 'Butoane'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object liImgLoadSignature: TdxLayoutItem
      Parent = grpImgBtnSignature
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Incarca'
      Control = btnImgLoadSignature
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liImgClearSignature: TdxLayoutItem
      Parent = grpImgBtnSignature
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Sterge'
      Control = btnImgClearSignature
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object grpImgRow1: TdxLayoutGroup
      Parent = tabImages
      CaptionOptions.Text = 'Rind'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object grpImgCeoSign: TdxLayoutGroup
      Parent = grpImgRow1
      CaptionOptions.Text = 'Semnatura conducatorului'
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object liImgCeoSign: TdxLayoutItem
      Parent = grpImgCeoSign
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Semnatura conducatorului'
      Control = imgCeoSign
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object grpImgBtnCeoSign: TdxLayoutGroup
      Parent = grpImgCeoSign
      CaptionOptions.Text = 'Butoane'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object liImgLoadCeoSign: TdxLayoutItem
      Parent = grpImgBtnCeoSign
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Incarca'
      Control = btnImgLoadCeoSign
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liImgClearCeoSign: TdxLayoutItem
      Parent = grpImgBtnCeoSign
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Sterge'
      Control = btnImgClearCeoSign
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object grpImgAccSign: TdxLayoutGroup
      Parent = grpImgRow1
      CaptionOptions.Text = 'Semnatura contabilului-sef'
      ButtonOptions.Buttons = <>
      Index = 1
    end
    object liImgAccSign: TdxLayoutItem
      Parent = grpImgAccSign
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Semnatura contabilului-sef'
      Control = imgAccSign
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object grpImgBtnAccSign: TdxLayoutGroup
      Parent = grpImgAccSign
      CaptionOptions.Text = 'Butoane'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object liImgLoadAccSign: TdxLayoutItem
      Parent = grpImgBtnAccSign
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Incarca'
      Control = btnImgLoadAccSign
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liImgClearAccSign: TdxLayoutItem
      Parent = grpImgBtnAccSign
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Sterge'
      Control = btnImgClearAccSign
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object grpImgWarranty: TdxLayoutGroup
      Parent = grpImgRow1
      CaptionOptions.Text = 'Stampila de garantie'
      ButtonOptions.Buttons = <>
      Index = 2
    end
    object liImgWarranty: TdxLayoutItem
      Parent = grpImgWarranty
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Stampila de garantie'
      Control = imgWarranty
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object grpImgBtnWarranty: TdxLayoutGroup
      Parent = grpImgWarranty
      CaptionOptions.Text = 'Butoane'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object liImgLoadWarranty: TdxLayoutItem
      Parent = grpImgBtnWarranty
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Incarca'
      Control = btnImgLoadWarranty
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liImgClearWarranty: TdxLayoutItem
      Parent = grpImgBtnWarranty
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Sterge'
      Control = btnImgClearWarranty
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liImgHint: TdxLayoutItem
      Parent = tabImages
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Nota'
      Control = lblImgHint
      ControlOptions.ShowBorder = False
      AlignHorz = ahClient
      Index = 2
    end
    object tabSetup: TdxLayoutGroup
      Parent = grpTabs
      CaptionOptions.Text = 'Integrare 1C si setari'
      ButtonOptions.Buttons = <>
      Index = 5
    end
    object grp1C: TdxLayoutGroup
      Parent = tabSetup
      CaptionOptions.Text = 'Legatura cu 1C (TS_CUST_1C)'
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object li1C: TdxLayoutItem
      Parent = grp1C
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Export'
      Control = chk1C
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object grp1CCols: TdxLayoutGroup
      Parent = grp1C
      CaptionOptions.Text = 'Coloane'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object grp1CLeft: TdxLayoutGroup
      Parent = grp1CCols
      CaptionOptions.Text = 'Stinga'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = 0
    end
    object li1CFirmaCod: TdxLayoutItem
      Parent = grp1CLeft
      CaptionOptions.Text = 'Codul organizatiei in 1C'
      Control = ed1CFirmaCod
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object li1CFirmaName: TdxLayoutItem
      Parent = grp1CLeft
      CaptionOptions.Text = 'Organizatia in 1C'
      Control = ed1CFirmaName
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object li1CPfCode: TdxLayoutItem
      Parent = grp1CLeft
      CaptionOptions.Text = 'Codul persoanei fizice (1C)'
      Control = ed1CPfCode
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object li1CPfTitle: TdxLayoutItem
      Parent = grp1CLeft
      CaptionOptions.Text = 'Persoana fizica (1C)'
      Control = ed1CPfTitle
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object grp1CRight: TdxLayoutGroup
      Parent = grp1CCols
      CaptionOptions.Text = 'Dreapta'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = 1
    end
    object li1CSkladCod: TdxLayoutItem
      Parent = grp1CRight
      CaptionOptions.Text = 'Codul depozitului in 1C'
      Control = ed1CSkladCod
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object li1CTitle: TdxLayoutItem
      Parent = grp1CRight
      CaptionOptions.Text = 'Depozitul in 1C'
      Control = ed1CTitle
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object li1CType: TdxLayoutItem
      Parent = grp1CRight
      CaptionOptions.Text = 'Tipul depozitului (1C)'
      Control = cb1CType
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object li1CActive: TdxLayoutItem
      Parent = grp1CRight
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Activ'
      Control = chk1CActive
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object grpSetup: TdxLayoutGroup
      Parent = tabSetup
      CaptionOptions.Text = 'La crearea unitatii in WMS'
      ButtonOptions.Buttons = <>
      Index = 1
    end
    object liCopyDefaults: TdxLayoutItem
      Parent = grpSetup
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Copiaza'
      Control = chkCopyDefaults
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liModelFirm: TdxLayoutItem
      Parent = grpSetup
      CaptionOptions.Text = 'Firma-model'
      Control = lcbModelFirm
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liDepot: TdxLayoutItem
      Parent = grpSetup
      CaptionOptions.Text = 'Depozitul documentelor'
      Control = lcbDepot
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liGrantAccess: TdxLayoutItem
      Parent = grpSetup
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Acces'
      Control = chkGrantAccess
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object tabEcc: TdxLayoutGroup
      Parent = grpTabs
      CaptionOptions.Text = 'Casa ECC online'
      ButtonOptions.Buttons = <>
      Index = 6
    end
    object liEcc: TdxLayoutItem
      Parent = tabEcc
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'ECC'
      Control = chkEcc
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object grpEccCols: TdxLayoutGroup
      Parent = tabEcc
      CaptionOptions.Text = 'Coloane'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object grpEccCash: TdxLayoutGroup
      Parent = grpEccCols
      CaptionOptions.Text = 'Casa (TS_API_CONFIG)'
      ButtonOptions.Buttons = <>
      AlignHorz = ahClient
      Index = 0
    end
    object liEccCode: TdxLayoutItem
      Parent = grpEccCash
      CaptionOptions.Text = 'Codul casei *'
      Control = cbEccCode
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liEccServer: TdxLayoutItem
      Parent = grpEccCash
      CaptionOptions.Text = 'Serverul (BASE_URL) *'
      Control = cbEccServer
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liEccApiKey: TdxLayoutItem
      Parent = grpEccCash
      CaptionOptions.Text = 'Cheia API *'
      Control = edEccApiKey
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liEccPosId: TdxLayoutItem
      Parent = grpEccCash
      CaptionOptions.Text = 'POS ID *'
      Control = edEccPosId
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object liEccPosName: TdxLayoutItem
      Parent = grpEccCash
      CaptionOptions.Text = 'Denumirea POS'
      Control = edEccPosName
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object liEccCashier: TdxLayoutItem
      Parent = grpEccCash
      CaptionOptions.Text = 'Casierul implicit *'
      Control = edEccCashier
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object grpEccTax: TdxLayoutGroup
      Parent = grpEccCash
      CaptionOptions.Text = 'Literele cotelor TVA din ECC'
      ButtonOptions.Buttons = <>
      LayoutDirection = ldHorizontal
      Index = 6
    end
    object liEccTax20: TdxLayoutItem
      Parent = grpEccTax
      CaptionOptions.Text = 'TVA 20 %'
      Control = edEccTax20
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liEccTax8: TdxLayoutItem
      Parent = grpEccTax
      CaptionOptions.Text = 'TVA 8 %'
      Control = edEccTax8
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liEccTax0: TdxLayoutItem
      Parent = grpEccTax
      CaptionOptions.Text = 'TVA 0 %'
      Control = edEccTax0
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liEccTaxNone: TdxLayoutItem
      Parent = grpEccTax
      CaptionOptions.Text = 'Fara TVA'
      Control = edEccTaxNone
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object grpEccRight: TdxLayoutGroup
      Parent = grpEccCols
      CaptionOptions.Text = 'Dreapta'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      AlignHorz = ahClient
      Index = 1
    end
    object grpEccDevice: TdxLayoutGroup
      Parent = grpEccRight
      CaptionOptions.Text = 'Legatura cu firma (FP_DEVICES)'
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object liEccWorkstation: TdxLayoutItem
      Parent = grpEccDevice
      CaptionOptions.Text = 'Calculatorul (gol = oricare)'
      Control = lcbEccWorkstation
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liEccDescription: TdxLayoutItem
      Parent = grpEccDevice
      CaptionOptions.Text = 'Descriere'
      Control = edEccDescription
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liEccEnabled: TdxLayoutItem
      Parent = grpEccDevice
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Activa'
      Control = chkEccEnabled
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object grpEccTerminal: TdxLayoutGroup
      Parent = grpEccRight
      CaptionOptions.Text = 'Terminal bancar smart (optional)'
      ButtonOptions.Buttons = <>
      Index = 1
    end
    object liEccTermPosId: TdxLayoutItem
      Parent = grpEccTerminal
      CaptionOptions.Text = 'POS ID terminal'
      Control = edEccTermPosId
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liEccTermPosName: TdxLayoutItem
      Parent = grpEccTerminal
      CaptionOptions.Text = 'Denumirea terminalului'
      Control = edEccTermPosName
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liEccTermApiKey: TdxLayoutItem
      Parent = grpEccTerminal
      CaptionOptions.Text = 'Cheia terminalului'
      Control = edEccTermApiKey
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liEccTermTimeout: TdxLayoutItem
      Parent = grpEccTerminal
      CaptionOptions.Text = 'Asteptarea platii, sec'
      Control = edEccTermTimeout
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object grpEccTest: TdxLayoutGroup
      Parent = grpEccRight
      CaptionOptions.Text = 'Verificare'
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      LayoutDirection = ldHorizontal
      Index = 2
    end
    object liEccTest: TdxLayoutItem
      Parent = grpEccTest
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Test'
      Control = btnEccTest
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liEccInfo: TdxLayoutItem
      Parent = tabEcc
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Nota'
      Control = lblEccInfo
      ControlOptions.ShowBorder = False
      AlignHorz = ahClient
      Index = 2
    end
    object tabNote: TdxLayoutGroup
      Parent = grpTabs
      CaptionOptions.Text = 'Note'
      ButtonOptions.Buttons = <>
      Index = 7
    end
    object liNote: TdxLayoutItem
      Parent = tabNote
      CaptionOptions.Visible = False
      CaptionOptions.Text = 'Note'
      Control = mmNote
      ControlOptions.ShowBorder = False
      AlignHorz = ahClient
      AlignVert = avClient
      Index = 0
    end
  end
  object lafList: TdxLayoutLookAndFeelList
    Left = 880
    Top = 8
    object lafCx: TdxLayoutCxLookAndFeel
      PixelsPerInch = 96
    end
  end
  object qFirms: TIBCQuery
    SQL.Strings = (
      'SELECT CUSTOMERID, DISPLAYNAME FROM VW_GET_FIRME')
    ReadOnly = True
    Left = 880
    Top = 60
  end
  object dsFirms: TIBCDataSource
    DataSet = qFirms
    Left = 920
    Top = 60
  end
  object qCities: TIBCQuery
    SQL.Strings = (
      'SELECT DISTINCT CITYID, TITLE FROM GET_CITIES ORDER BY TITLE')
    ReadOnly = True
    Left = 880
    Top = 108
  end
  object dsCities: TIBCDataSource
    DataSet = qCities
    Left = 920
    Top = 108
  end
  object qDistrictJ: TIBCQuery
    SQL.Strings = (
      'SELECT DISTRICTID, DISTRICT_NAME FROM GET_CITY_DISTRICT(:CITYID) ORDER BY DISTRICT_NAME')
    ReadOnly = True
    Left = 880
    Top = 156
  end
  object dsDistrictJ: TIBCDataSource
    DataSet = qDistrictJ
    Left = 920
    Top = 156
  end
  object qDistrictF: TIBCQuery
    SQL.Strings = (
      'SELECT DISTRICTID, DISTRICT_NAME FROM GET_CITY_DISTRICT(:CITYID) ORDER BY DISTRICT_NAME')
    ReadOnly = True
    Left = 880
    Top = 204
  end
  object dsDistrictF: TIBCDataSource
    DataSet = qDistrictF
    Left = 920
    Top = 204
  end
  object qStocks: TIBCQuery
    SQL.Strings = (
      'SELECT STOCKID, TITLE FROM TS_STOCKS WHERE FLG_FOLDER = 0 ORDER BY TITLE')
    ReadOnly = True
    Left = 880
    Top = 252
  end
  object dsStocks: TIBCDataSource
    DataSet = qStocks
    Left = 920
    Top = 252
  end
  object qWorkstations: TIBCQuery
    SQL.Strings = (
      'SELECT WS_ID, COMPUTER_NAME FROM WS_WORK_STATIONS ORDER BY COMPUTER_NAME')
    ReadOnly = True
    Left = 880
    Top = 300
  end
  object dsWorkstations: TIBCDataSource
    DataSet = qWorkstations
    Left = 920
    Top = 300
  end
  object trWrite: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 880
    Top = 380
  end
  object dlgOpenImage: TOpenDialog
    Filter = 'Imagini (*.png;*.jpg;*.jpeg;*.bmp;*.gif)|*.png;*.jpg;*.jpeg;*.bmp;*.gif|Toate fisierele (*.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Alegeti imaginea'
    Left = 880
    Top = 428
  end
end
