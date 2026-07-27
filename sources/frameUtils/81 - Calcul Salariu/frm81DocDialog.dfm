object frm81DocDlg: Tfrm81DocDlg
  Left = 0
  Top = 0
  ActiveControl = beCT_NAME
  BorderStyle = bsDialog
  Caption = 'Ordin de incasare'
  ClientHeight = 558
  ClientWidth = 657
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    657
    558)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 657
    Height = 64
    Title = 'Calculul salariului'
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
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 641
    Height = 419
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
    object lbFirma: TLabel
      Left = 12
      Top = 83
      Width = 52
      Height = 15
      Caption = 'Beneficiar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbClient: TLabel
      Left = 12
      Top = 113
      Width = 38
      Height = 15
      Caption = 'Salariat'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 12
      Top = 209
      Width = 73
      Height = 15
      Caption = 'Suma / Valuta'
    end
    object Label8: TLabel
      Left = 9
      Top = 246
      Width = 90
      Height = 15
      Caption = 'Rata / Document'
    end
    object lbDocComments2: TLabel
      Left = 20
      Top = 325
      Width = 48
      Height = 15
      Caption = 'Mentiuni'
    end
    object Label1: TLabel
      Left = 12
      Top = 20
      Width = 82
      Height = 15
      Caption = 'Data document'
    end
    object Bevel1: TBevel
      Left = 12
      Top = 60
      Width = 613
      Height = 5
      Shape = bsTopLine
    end
    object sbShowCurrencyCalc: TSpeedButton
      Left = 202
      Top = 206
      Width = 31
      Height = 27
      Glyph.Data = {
        C2020000424DC202000000000000C20100002800000010000000100000000100
        08000000000000010000120B0000120B0000630000006300000000000000FFFF
        FF00FF00FF00CFCECE00BAB8B700B8B6B500B2B0AF00CAC8C700E0C6AC00E4CB
        B200E6CDB500E7CFB700EEE2D6009C9A9800BBB9B700B1AFAD00E8E7E600E1E0
        DF00DDDCDB00DAD9D800CCCBCA00D1A47400CFB19000D2B69700D7BB9D00DBC1
        A400E1CBB300CBAD8B00CEB89F00CABBA900E6D1B200E4BB7D00D7C3A300BEBD
        BB00BCBBB900BBBAB800BAB9B700ABAAA800AAA9A700A8A7A500A7A6A400A6A5
        A300A3A2A000A2A19F00C9C8C600C5C4C200C1C0BE00C0BFBD0092918E00AAA9
        A600A3A29F00A9A9A600A8A8A500A5A5A200A4A4A100A3A3A000C9C9C600C3C3
        C000A7A7A500D9D9D700D6D6D400D5D5D300CDCDCB00CBCBC900CACAC800C8C8
        C600C6C6C400C5C5C300C2C2C000C0C0BE00BEBEBC00F5F5F400F2F2F100EDED
        EC00EBEBEA00EAEAE900E8E8E700E3E3E200E0E0DF00DDDDDC00D6D6D500D2D2
        D100CFCFCE00E5E6E400E4E5E300E2E3E100D0D1CF00EDEEED00E6E7E600E4E5
        E400E3E4E300E2E3E200FDFDFD00FBFBFB00FAFAFA00F7F7F700F0F0F000ECEC
        EC00E6E6E6000202020202020202020202020202020202050D0D0D0D0D0D0D0D
        0D0D0D0D0602020D4A105A114F135051031407420D02020D59332C283936462B
        2430300E0D02020D4D0134012901372F010130220D02020D5B3338332F352F32
        233030210D02020D530131013A0135012A01302E0D02020D4C25443140354335
        4530302D0D02020D6101250126012701290130410D02020D60494B5854554E12
        3B3D563E0D02020D1E1F1F1F1F1F1F1F1F1F1F200D02020D1A15151515151515
        1515151C0D02020D0C0B0B0A0908191817161B1D0D02020D5C5D5E5F47485762
        4F3C523F0D0202040D0D0D0D0D0D0D0D0D0D0D0D0F0202020202020202020202
        020202020202}
      ParentShowHint = False
      ShowHint = False
      OnClick = sbShowCurrencyCalcClick
    end
    object lbContractTitle: TLabel
      Left = 12
      Top = 160
      Width = 46
      Height = 15
      Caption = 'Contract'
      Transparent = True
    end
    object lbContractInfo: TLabel
      Left = 419
      Top = 103
      Width = 201
      Height = 30
      Caption = 'Atentie! Va fi aplicata valuta si grila de preturi din contract!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object edSuma: TcxDBCalcEdit
      Left = 108
      Top = 207
      DataBinding.DataField = 'SUMA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentFont = False
      Properties.DisplayFormat = '#,##0.00'
      Properties.Precision = 15
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 5
      Width = 97
    end
    object edRate: TcxDBCalcEdit
      Left = 239
      Top = 240
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DisplayFormat = '#,##0.0000'
      Properties.Precision = 4
      TabOrder = 8
      Width = 97
    end
    object cbFLG_ACNT: TcxDBCheckBox
      Left = 108
      Top = 279
      Caption = 'Contabilitate'
      DataBinding.DataField = 'FLG_ACNT'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Properties.OnEditValueChanged = cbFLGAccPropertiesEditValueChanged
      TabOrder = 9
      Transparent = True
    end
    object mmDocCOMMENTS: TcxDBMemo
      Left = 108
      Top = 322
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocProps
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 5
      TabOrder = 10
      OnClick = mmDocCOMMENTSClick
      OnEnter = mmDocCOMMENTSClick
      Width = 517
    end
    object h: TcxDBDateEdit
      Left = 108
      Top = 17
      TabStop = False
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ClearKey = 16430
      Properties.DateButtons = [btnNow]
      Properties.ImmediatePost = True
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      TabOrder = 0
      Width = 164
    end
    object beDT_NAME: TcxButtonEdit
      Left = 108
      Top = 79
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
            FF00FF00FF00B8C698FFA6AE7AFF948F55FFFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FF8DB4
            61FF92B266FF99B56DFF9EB975FF91884AFF718043FF757C43FF8F8C4DFF9284
            49FFA58D5EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4BD
            7EFFA4BD7EFFA4C17EFFA4C17EFF91884AFF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB1C58DFFA88559FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA4BD7EFFA4BD7EFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA6AE7AFFA4B97DFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA4B97DFFA6AE7AFFA4B97DFF928449FF96A67CFF98A57DFFB5CD98FFB5CD
            98FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA9AA78FFA6AE7AFFA4B97DFF967D46FF96A67CFF98A57DFFB6C596FFB6C5
            96FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFABA5
            76FFA9AA78FFA9AA78FFA4B97DFF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C997FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFADA1
            74FFABA576FFA9AA78FFB6B188FF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFADA1
            74FFADA174FFABA576FFBAB991FF967D46FF979E7AFF9A9D7BFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB09A70FFADA174FFBAB991FF9C7240FF979E7AFF9A9D7BFFB8BE94FFB8C0
            95FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB2966FFFB09A70FFC5B395FF967D46FF9A9777FF9A9D7BFFB8BE94FFB8BE
            94FFB8C095FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB2966FFFB2966FFFC5B395FF9C7240FF9A9D7BFF9A9D7BFFB8BE94FFB8BE
            94FFB8BE94FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB78E6BFFC1AC8CFFB9A882FF9C7240FF9A9D7BFFB1AE8AFFBAB991FFB8BE
            94FFB8BE94FF9E6E3EFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FF9F98
            5FFFA6AB76FF979357FFAA986AFFA49573FFBCB18DFFBCB18DFFBAB991FFBAB9
            91FFBCB18DFFAB7F56FFFF00FF00FF00FF00FF00FF00FF00FF0090B063FF90B0
            63FF88AA56FF87A755FF89A054FF8A9A52FF8C934FFF91884AFF928449FF9C72
            40FFA88559FFFF00FF00FF00FF00FF00FF00FF00FF00}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beDT_NAMEPropertiesButtonClick
      TabOrder = 2
      Text = 'beDT_NAME'
      Width = 291
    end
    object beCT_NAME: TcxButtonEdit
      Left = 108
      Top = 109
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
            FF00FF00FF00B8C698FFA6AE7AFF948F55FFFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FF8DB4
            61FF92B266FF99B56DFF9EB975FF91884AFF718043FF757C43FF8F8C4DFF9284
            49FFA58D5EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4BD
            7EFFA4BD7EFFA4C17EFFA4C17EFF91884AFF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB1C58DFFA88559FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA4BD7EFFA4BD7EFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA6AE7AFFA4B97DFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA4B97DFFA6AE7AFFA4B97DFF928449FF96A67CFF98A57DFFB5CD98FFB5CD
            98FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA9AA78FFA6AE7AFFA4B97DFF967D46FF96A67CFF98A57DFFB6C596FFB6C5
            96FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFABA5
            76FFA9AA78FFA9AA78FFA4B97DFF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C997FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFADA1
            74FFABA576FFA9AA78FFB6B188FF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFADA1
            74FFADA174FFABA576FFBAB991FF967D46FF979E7AFF9A9D7BFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB09A70FFADA174FFBAB991FF9C7240FF979E7AFF9A9D7BFFB8BE94FFB8C0
            95FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB2966FFFB09A70FFC5B395FF967D46FF9A9777FF9A9D7BFFB8BE94FFB8BE
            94FFB8C095FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB2966FFFB2966FFFC5B395FF9C7240FF9A9D7BFF9A9D7BFFB8BE94FFB8BE
            94FFB8BE94FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB78E6BFFC1AC8CFFB9A882FF9C7240FF9A9D7BFFB1AE8AFFBAB991FFB8BE
            94FFB8BE94FF9E6E3EFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FF9F98
            5FFFA6AB76FF979357FFAA986AFFA49573FFBCB18DFFBCB18DFFBAB991FFBAB9
            91FFBCB18DFFAB7F56FFFF00FF00FF00FF00FF00FF00FF00FF0090B063FF90B0
            63FF88AA56FF87A755FF89A054FF8A9A52FF8C934FFF91884AFF928449FF9C72
            40FFA88559FFFF00FF00FF00FF00FF00FF00FF00FF00}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beCT_NAMEPropertiesButtonClick
      TabOrder = 3
      Text = 'beCT_NAME'
      Width = 291
    end
    object ceRATEUSD: TcxDBCalcEdit
      Left = 108
      Top = 240
      DataBinding.DataField = 'RATEUSD'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 7
      Width = 97
    end
    object lcbAnalytics: TcxDBLookupComboBox
      Left = 296
      Top = 17
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      DataBinding.DataField = 'SC2'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentShowHint = False
      Properties.DropDownAutoSize = True
      Properties.DropDownRows = 16
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'ANALITICAID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 250
          FieldName = 'TITLE'
        end
        item
          Fixed = True
          Width = 150
          FieldName = 'PARENT_TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceAnalytics
      ShowHint = True
      TabOrder = 1
      Width = 329
    end
    object beContract: TcxButtonEdit
      Left = 108
      Top = 156
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
            FF00FF00FF00B8C698FFA6AE7AFF948F55FFFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FF8DB4
            61FF92B266FF99B56DFF9EB975FF91884AFF718043FF757C43FF8F8C4DFF9284
            49FFA58D5EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4BD
            7EFFA4BD7EFFA4C17EFFA4C17EFF91884AFF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB1C58DFFA88559FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA4BD7EFFA4BD7EFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA6AE7AFFA4B97DFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA4B97DFFA6AE7AFFA4B97DFF928449FF96A67CFF98A57DFFB5CD98FFB5CD
            98FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA9AA78FFA6AE7AFFA4B97DFF967D46FF96A67CFF98A57DFFB6C596FFB6C5
            96FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFABA5
            76FFA9AA78FFA9AA78FFA4B97DFF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C997FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFADA1
            74FFABA576FFA9AA78FFB6B188FF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFADA1
            74FFADA174FFABA576FFBAB991FF967D46FF979E7AFF9A9D7BFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB09A70FFADA174FFBAB991FF9C7240FF979E7AFF9A9D7BFFB8BE94FFB8C0
            95FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB2966FFFB09A70FFC5B395FF967D46FF9A9777FF9A9D7BFFB8BE94FFB8BE
            94FFB8C095FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB2966FFFB2966FFFC5B395FF9C7240FF9A9D7BFF9A9D7BFFB8BE94FFB8BE
            94FFB8BE94FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB78E6BFFC1AC8CFFB9A882FF9C7240FF9A9D7BFFB1AE8AFFBAB991FFB8BE
            94FFB8BE94FF9E6E3EFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FF9F98
            5FFFA6AB76FF979357FFAA986AFFA49573FFBCB18DFFBCB18DFFBAB991FFBAB9
            91FFBCB18DFFAB7F56FFFF00FF00FF00FF00FF00FF00FF00FF0090B063FF90B0
            63FF88AA56FF87A755FF89A054FF8A9A52FF8C934FFF91884AFF928449FF9C72
            40FFA88559FFFF00FF00FF00FF00FF00FF00FF00FF00}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beContractPropertiesButtonClick
      TabOrder = 4
      Width = 517
    end
    object cmbCurrency: TcxDBLookupComboBox
      Left = 239
      Top = 208
      DataBinding.DataField = 'CURRENCYID'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ColumnSorting = False
      Properties.ListOptions.GridLines = glHorizontal
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceCurrency
      Properties.OnEditValueChanged = cmbCurrencyPropertiesEditValueChanged
      TabOrder = 6
      Width = 78
    end
  end
  object btnOk: TcxButton
    Left = 447
    Top = 512
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 543
    Top = 512
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryDocProps: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_DOCS_PROPS'
      '  (DOCID, INBAZA, COMMENTS)'
      'VALUES'
      '  (:DOCID, :INBAZA, :COMMENTS)')
    SQLUpdate.Strings = (
      'UPDATE TDB_DOCS_PROPS'
      'SET'
      '  DOCID = :DOCID, INBAZA = :INBAZA, COMMENTS = :COMMENTS'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      
        'SELECT TDB_DOCS_PROPS.DOCID, TDB_DOCS_PROPS.INBAZA, TDB_DOCS_PRO' +
        'PS.COMMENTS FROM TDB_DOCS_PROPS'
      'WHERE'
      '  DOCID = :DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_PROPS'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      '    DOCID,'
      '    INBAZA,'
      '    COMMENTS'
      'FROM'
      '    TDB_DOCS_PROPS')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    Left = 288
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocProps: TIBCDataSource
    DataSet = IBCQueryDocProps
    Left = 288
    Top = 96
  end
  object IBCQueryDT_Accounts: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' CUSTOMERID,'
      ' ACCOUNTNUMBER,'
      ' ACCOUNTNAME,'
      ' DEFAULT_ACCOUNT,'
      ' BANKACCOUNT'
      'FROM'
      ' TS_CUST_ACCOUNTS'
      'ORDER BY'
      ' DEFAULT_ACCOUNT DESC')
    MasterFields = 'DT'
    DetailFields = 'CUSTOMERID'
    MasterSource = dmDB.IBCDataSourceDocs
    Options.BooleanDomainFields = True
    Left = 440
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceDT_Accounts: TIBCDataSource
    DataSet = IBCQueryDT_Accounts
    Left = 440
    Top = 96
  end
  object IBCDataSourceCT_Accounts: TIBCDataSource
    DataSet = IBCQueryCT_Accounts
    Left = 540
    Top = 96
  end
  object IBCQueryCT_Accounts: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' CUSTOMERID,'
      ' ACCOUNTNUMBER,'
      ' ACCOUNTNAME,'
      ' DEFAULT_ACCOUNT,'
      ' BANKACCOUNT'
      'FROM'
      ' TS_CUST_ACCOUNTS'
      'ORDER BY'
      ' DEFAULT_ACCOUNT DESC')
    MasterFields = 'CT'
    DetailFields = 'CUSTOMERID'
    MasterSource = dmDB.IBCDataSourceDocs
    Options.BooleanDomainFields = True
    Left = 540
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end>
  end
  object IBCQueryRechizite: TIBCQuery
    UpdatingTable = 'TDB_DOCS_RECHIZITE'
    KeyFields = 'DOCID'
    SQLInsert.Strings = (
      'INSERT INTO TDB_DOCS_RECHIZITE'
      '  (DOCID, DT_CD, CT_CD)'
      'VALUES'
      '  (:DOCID, :DT_CD, :CT_CD)')
    SQLUpdate.Strings = (
      'UPDATE TDB_DOCS_RECHIZITE'
      'SET'
      '  DOCID = :DOCID, DT_CD = :DT_CD, CT_CD = :CT_CD'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      'SELECT '
      ' DOCID, '
      ' DT_CD, '
      ' CT_CD'
      'FROM '
      ' TDB_DOCS_RECHIZITE'
      'WHERE'
      ' DOCID = :DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_RECHIZITE'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' DOCID,'
      ' DT_CD,'
      ' CT_CD'
      'FROM'
      ' TDB_DOCS_RECHIZITE')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    Left = 176
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceRechizite: TIBCDataSource
    DataSet = IBCQueryRechizite
    Left = 176
    Top = 104
  end
end
