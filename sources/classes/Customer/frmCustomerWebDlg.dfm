object frmCustomerWebDialog: TfrmCustomerWebDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gestiune web accounts'
  ClientHeight = 504
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    493
    504)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 493
    Height = 64
    Title = 'Acces web'
    Text = ''
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
    ImageIndex = 2
  end
  object pnWeb: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 477
    Height = 375
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 20
      Width = 31
      Height = 15
      Caption = 'Client'
    end
    object edDISPLAYNAME: TcxDBTextEdit
      Left = 92
      Top = 17
      TabStop = False
      DataBinding.DataField = 'DISPLAYNAME'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 357
    end
    object pcPages: TPageControl
      Left = 24
      Top = 64
      Width = 429
      Height = 281
      ActivePage = tbsGeneral
      TabOrder = 1
      object tbsGeneral: TTabSheet
        Caption = 'Informatie'
        object cxLabel1: TLabel
          Left = 16
          Top = 56
          Width = 30
          Height = 15
          Caption = 'Login'
        end
        object cxLabel2: TLabel
          Left = 17
          Top = 123
          Width = 33
          Height = 15
          Caption = 'Parola'
        end
        object Label2: TLabel
          Left = 15
          Top = 156
          Width = 92
          Height = 15
          Caption = 'Limba preferabila'
        end
        object Label4: TLabel
          Left = 16
          Top = 85
          Width = 29
          Height = 15
          Caption = 'EMail'
        end
        object edLOGIN: TcxDBTextEdit
          Left = 107
          Top = 53
          DataBinding.DataField = 'LOGIN'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.CharCase = ecLowerCase
          Properties.MaxLength = 0
          TabOrder = 1
          Width = 285
        end
        object cbFLG_ENABLED: TcxDBCheckBox
          Left = 16
          Top = 16
          Caption = 'Web account'
          DataBinding.DataField = 'FLG_ENABLED'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 0
        end
        object btnSetPassword: TcxButton
          Left = 107
          Top = 119
          Width = 109
          Height = 25
          Caption = 'Seteaza parola'
          TabOrder = 3
          OnClick = btnSetPasswordClick
        end
        object btnRandomPass: TcxButton
          Left = 324
          Top = 120
          Width = 75
          Height = 25
          Caption = 'Standart'
          TabOrder = 4
          OnClick = btnRandomPassClick
        end
        object cxButton1: TcxButton
          Left = 272
          Top = 212
          Width = 129
          Height = 29
          Caption = 'Trimite scrisoare'
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000001E744558745469746C65004C65747465723B652D6D61696C3B656D61
            696C3B6D61696C1A9193DA0000021E49444154785EA5534D68134114FEDE6613
            AB260A226211440F165AF45228086253A98A0A391951A482DA83B7EA45417A92
            5AB18822B482820495824A5144A9882DF8D322FE81084A053535918A34E92A96
            68BAD99DE7ECEB364B45F19037FBCD7BB36FE67BDFECEC1033A3123350A15140
            02FA6BFEDFC61A8A2E5C7DFA206C9A4DCCC0CC76022F1D64A60C2480D76CBBF4
            F8506BBCD9CC64F34DED6D9B511531E12A2E7313F9E19F720DC2CFA28D8EB303
            8D328C45E7E3F6E05BA4B379E81C1C47A1E438B04B1AAE8EB5774A2E1CD711D2
            37EF3EE3F8995B8846E7C937343D695BE2B5181C1EC1FBD1716C5A5F8BA2CD70
            5D112E954321608EEE7A6F0CE1CBD7491CD8B71597FA5E8828C35580528CFA35
            2B411442776A0006B1B7482A870C0851FB895E14A718DB13EBC0CA2B20E4647A
            951804A580D88218AA972E4157CF1DB4EEDE80E5CB16219D19C7A9EE9BA8ABAB
            41CDAA153034A3CB04C7615F81AB84316715B43C0BDB9A57A36547232E5F7F88
            E4FED33897BA8B3DBB36229968C0843589FCB7C22C0538DA759F473EE6F8E2B5
            E76C7DFFC5394BC01F4627F8E5EB8C209DB5BC77924FE9794F5E8DF1C163FD0C
            2046873BEF71F5E22AB4241BA040FEB91308812F1B110C30AEF43DC3A7B1027A
            3A120BCDBCF5036D7BD7C275088A957FDA1C6096313844D899A8C791CE7E4998
            91B0F1E8E4F9E1B8549EF90BE5D14DD6976301F90AC3110C017008C05C0DD3BF
            13FFBF0B81445BA358F175FE0D92BE263C728CE3430000000049454E44AE4260
            82}
          TabOrder = 7
          OnClick = cxButton1Click
        end
        object cbRegisterNewCustomer: TcxCheckBox
          Left = 16
          Top = 192
          Caption = 'Scrisoare de inregistrare'
          Style.TransparentBorder = False
          TabOrder = 6
        end
        object cbChangePassword: TcxCheckBox
          Left = 16
          Top = 216
          Caption = 'Notificare de modificare a parolei'
          Style.TransparentBorder = False
          TabOrder = 8
        end
        object cbLanguage: TcxDBComboBox
          Left = 116
          Top = 150
          DataBinding.DataField = 'PREFFERED_LANGUAGE'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.DropDownListStyle = lsFixedList
          Properties.ImmediatePost = True
          Properties.ImmediateUpdateText = True
          Properties.Items.Strings = (
            'RO'
            'RU')
          TabOrder = 5
          Width = 60
        end
        object edEMail: TcxDBTextEdit
          Left = 107
          Top = 82
          DataBinding.DataField = 'EMAIL'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.CharCase = ecLowerCase
          Properties.MaxLength = 0
          TabOrder = 2
          Width = 285
        end
      end
      object tbsDoNotShow: TTabSheet
        Caption = 'Optiuni de vizualizare'
        ImageIndex = 1
        object cbFLG_NO_COMERCIALS: TcxDBCheckBox
          Left = 16
          Top = 16
          Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1088#1077#1082#1083#1072#1084#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102
          DataBinding.DataField = 'FLG_NO_COMERCIALS'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 0
        end
        object cbFLG_NO_FACEBOOK: TcxDBCheckBox
          Left = 16
          Top = 45
          Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089#1086#1094#1080#1072#1083#1100#1085#1099#1077' '#1089#1077#1090#1080
          DataBinding.DataField = 'FLG_NO_FACEBOOK'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 1
        end
        object cbFLG_NO_CHAT: TcxDBCheckBox
          Left = 16
          Top = 74
          Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1095#1072#1090
          DataBinding.DataField = 'FLG_NO_CHAT'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 2
        end
        object cbFLG_NO_CREDIT: TcxDBCheckBox
          Left = 16
          Top = 103
          Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1050#1088#1077#1076#1080#1090
          DataBinding.DataField = 'FLG_NO_CREDIT'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 3
        end
        object cbFLG_NO_ADDS_GOODS: TcxDBCheckBox
          Left = 16
          Top = 132
          Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' "'#1058#1072#1082#1078#1077' '#1089' '#1101#1090#1080#1084' '#1090#1086#1074#1072#1088#1086#1084' '#1087#1086#1082#1091#1087#1072#1102#1090'"'
          DataBinding.DataField = 'FLG_NO_ADDS_GOODS'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 4
        end
      end
      object tbsGoods: TTabSheet
        Caption = 'Produse'
        ImageIndex = 2
        object cbFLG_PRICE_BY_CLIENT: TcxDBCheckBox
          Left = 16
          Top = 45
          Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1094#1077#1085#1091' '#1087#1086' '#1082#1086#1083#1086#1085#1082#1077' '#1082#1083#1080#1077#1085#1090#1072
          DataBinding.DataField = 'FLG_PRICE_BY_CLIENT'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 1
        end
        object cbFLG_VIEW_REAL_STOCKS: TcxDBCheckBox
          Left = 16
          Top = 16
          Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1088#1077#1072#1083#1100#1085#1086#1077' '#1085#1072#1083#1080#1095#1080#1077' '#1090#1086#1074#1072#1088#1072
          DataBinding.DataField = 'FLG_VIEW_REAL_STOCKS'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 0
        end
      end
      object tbsAdmin: TTabSheet
        Caption = 'Administrativ'
        ImageIndex = 3
        object Label3: TLabel
          Left = 16
          Top = 16
          Width = 345
          Height = 15
          Caption = #1042#1085#1080#1084#1072#1085#1080#1077'! '#1057#1083#1077#1076#1091#1102#1097#1080#1077' '#1086#1087#1094#1080#1080' '#1090#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1076#1086#1074#1077#1088#1080#1090#1077#1083#1100#1085#1099#1093' '#1083#1080#1094'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object cbFLG_NPSC: TcxDBCheckBox
          Left = 16
          Top = 45
          Caption = #1062#1077#1085#1090#1088' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1090#1086#1074#1072#1088#1086#1074' (NPSC) - '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1080' '#1076#1077#1081#1089#1090#1074#1080#1103
          DataBinding.DataField = 'FLG_NPSC'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 0
        end
        object cbFLG_EDIT_GOODS: TcxDBCheckBox
          Left = 16
          Top = 74
          Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1086#1074' '#1085#1072' '#1089#1072#1081#1090#1077
          DataBinding.DataField = 'FLG_EDIT_GOODS'
          DataBinding.DataSource = IBCDataSourceWEB
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 1
        end
      end
    end
  end
  object btnOk: TcxButton
    Left = 280
    Top = 461
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 384
    Top = 461
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryWEB: TIBCQuery
    KeyFields = 'CUSTOMERID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_CUST_WEB'
      
        '  (CUSTOMERID, LOGIN, EMAIL, PASSWORD_HASH, PREFFERED_LANGUAGE, ' +
        'FLG_ENABLED, '
      
        '   FLG_NO_COMERCIALS, FLG_VIEW_REAL_STOCKS, FLG_NPSC, FLG_EDIT_G' +
        'OODS, FLG_NO_FACEBOOK, FLG_NO_CHAT, '
      
        '   FLG_PRICE_BY_CLIENT, FLG_PRICE_USD, FLG_NO_CREDIT, FLG_NO_ADD' +
        'S_GOODS)'
      'VALUES'
      
        '  (:CUSTOMERID, :LOGIN, :EMAIL, :PASSWORD_HASH, :PREFFERED_LANGU' +
        'AGE, :FLG_ENABLED, '
      
        '   :FLG_NO_COMERCIALS, :FLG_VIEW_REAL_STOCKS, :FLG_NPSC, :FLG_ED' +
        'IT_GOODS, :FLG_NO_FACEBOOK, :FLG_NO_CHAT, '
      
        '   :FLG_PRICE_BY_CLIENT, :FLG_PRICE_USD, :FLG_NO_CREDIT, :FLG_NO' +
        '_ADDS_GOODS)')
    SQLDelete.Strings = (
      'DELETE FROM TS_CUST_WEB'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_CUST_WEB'
      'SET'
      '  CUSTOMERID = :CUSTOMERID, '
      '  LOGIN = :LOGIN, '
      '  EMAIL = :EMAIL,'
      '  PASSWORD_HASH = :PASSWORD_HASH, '
      '  PREFFERED_LANGUAGE = :PREFFERED_LANGUAGE,'
      '  FLG_ENABLED = :FLG_ENABLED, '
      '  FLG_NO_COMERCIALS = :FLG_NO_COMERCIALS, '
      '  FLG_VIEW_REAL_STOCKS = :FLG_VIEW_REAL_STOCKS, '
      '  FLG_NPSC = :FLG_NPSC, '
      '  FLG_EDIT_GOODS = :FLG_EDIT_GOODS,'
      '  FLG_NO_FACEBOOK = :FLG_NO_FACEBOOK,'
      '  FLG_NO_CHAT = :FLG_NO_CHAT,'
      '  FLG_PRICE_BY_CLIENT = :FLG_PRICE_BY_CLIENT,'
      '  FLG_PRICE_USD = :FLG_PRICE_USD,'
      '  FLG_NO_CREDIT = :FLG_NO_CREDIT,'
      '  FLG_NO_ADDS_GOODS = :FLG_NO_ADDS_GOODS'
      ''
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLRefresh.Strings = (
      'SELECT '
      ' CUSTOMERID,'
      ' LOGIN,'
      ' EMAIL, '
      ' PASSWORD_HASH,'
      ' PREFFERED_LANGUAGE,'
      ' REG_DATE,'
      ' FLG_ENABLED, '
      ' FLG_NO_COMERCIALS,'
      ' FLG_VIEW_REAL_STOCKS,'
      ' FLG_NPSC,'
      ' FLG_EDIT_GOODS,'
      ' FLG_NO_FACEBOOK,'
      ' FLG_NO_CHAT,'
      ' FLG_PRICE_BY_CLIENT,'
      ' FLG_PRICE_USD,'
      ' FLG_NO_CREDIT,'
      ' FLG_NO_ADDS_GOODS'
      ''
      'FROM '
      ' VW_TS_CUST_WEB'
      'WHERE'
      ' CUSTOMERID = :CUSTOMERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_WEB'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' CUSTOMERID,'
      ' LOGIN,'
      ' email,'
      ' PASSWORD_HASH,'
      ' REG_DATE,'
      ' PREFFERED_LANGUAGE,'
      ' FLG_ENABLED, '
      ' FLG_NO_COMERCIALS,'
      ' FLG_VIEW_REAL_STOCKS,'
      ' FLG_NPSC,'
      ' FLG_EDIT_GOODS,'
      ' FLG_NO_FACEBOOK,'
      ' FLG_NO_CHAT,'
      ' FLG_PRICE_BY_CLIENT,'
      ' FLG_PRICE_USD,'
      ' FLG_NO_CREDIT,'
      ' FLG_NO_ADDS_GOODS'
      'FROM '
      ' VW_TS_CUST_WEB')
    MasterFields = 'CUSTOMERID'
    DetailFields = 'CUSTOMERID'
    AutoCommit = False
    LockMode = lmLockImmediate
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 280
    Top = 72
  end
  object IBCDataSourceWEB: TIBCDataSource
    DataSet = IBCQueryWEB
    Left = 280
    Top = 20
  end
end
