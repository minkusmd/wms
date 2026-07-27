object frmPKODocDlg: TfrmPKODocDlg
  Left = 0
  Top = 0
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  BorderStyle = bsDialog
  Caption = 'Ordin de incasare'
  ClientHeight = 714
  ClientWidth = 819
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  DesignSize = (
    819
    714)
  TextHeight = 20
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 819
    Height = 80
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Title = 'Ordin de incasare'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -18
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -15
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 90
    Width = 799
    Height = 548
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object lbFirma: TLabel
      Left = 15
      Top = 84
      Width = 70
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Beneficiar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbClient: TLabel
      Left = 15
      Top = 173
      Width = 52
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Platitor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 15
      Top = 314
      Width = 37
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Suma'
    end
    object Label8: TLabel
      Left = 15
      Top = 376
      Width = 41
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Valuta'
    end
    object Label9: TLabel
      Left = 391
      Top = 376
      Width = 101
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Rata document'
    end
    object lbDocComments2: TLabel
      Left = 15
      Top = 426
      Width = 58
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Mentiuni'
    end
    object Label1: TLabel
      Left = 15
      Top = 25
      Width = 32
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Data'
    end
    object Bevel1: TBevel
      Left = 15
      Top = 65
      Width = 766
      Height = 6
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Shape = bsTopLine
    end
    object sbShowCurrencyCalc: TSpeedButton
      Left = 279
      Top = 308
      Width = 36
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      Left = 15
      Top = 260
      Width = 56
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Contract'
      Transparent = True
    end
    object lbContractInfo: TLabel
      Left = 506
      Top = 160
      Width = 238
      Height = 40
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Atentie! Va fi aplicata valuta si grila de preturi din contract!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object Label2: TLabel
      Left = 396
      Top = 314
      Width = 97
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Statut incasare'
    end
    object edSuma: TcxDBCalcEdit
      Left = 126
      Top = 310
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'SUMA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentFont = False
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000000473424954080808087C086488000001B249444154388D8D93BF6B14
        5110C73F33B731A041C540E2E6AE38107F81658A209114968114B692C24AB0B2
        53AF37FE050A76C2612D0A69C58008C15416879A85249CF7CB6088DC12B89CF7
        C6E2F6C5BDCB9E649AB7EF7DE6CBBCEF9B59997FF4B62622214361662D20047E
        88C84C168F9B51A869F1CB07F398610022329DACC7C4FFB8A0E9C3ABF973C349
        59DA540204002BCBB3DCBC360DC0DACAA27CABFDB6FB2F3E1EA9D31C20CDE5D6
        E377CE830F4F175928AD9A085EACC0111F8E7633D2010B9FBEB60612CCECFF16
        0CD4CC1A7E5F2A6FE0AB275DC0CCEA995AB31618019037B38107F39593F3C248
        EE1C4ABFCF2EF1EA0097ECEB89A83A92ABA22232A3825D2F9C3F34C32E8767BB
        A702752272114044F25916FA5CFA6D0C2F9CEE3D5B9ED537EB3B8777E68AB927
        E5CFBD4A755FFDB547B6D1CF41EDD741F0EAFD66E7E1D28DF1D76B51A752DD1F
        4F572B95378E5DC07F040085C933DD7BB7AFE49EAF563A77172EE5D6BFEF76BF
        6CEF8DF9A4930C9215A726FE6CB5E2A03835D1ABEF1D68B7E7D4CC3479B0CC68
        3722F57320DB3FE331116467370E12F1C9E6206E467990942BE8FF8F863987A8
        1646F1766393BF1145DD4989286AFC0000000049454E44AE426082}
      Properties.DisplayFormat = '#,##0.00'
      Properties.Precision = 15
      TabOrder = 7
      Width = 145
    end
    object edRate: TcxDBCalcEdit
      Left = 500
      Top = 373
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentFont = False
      Properties.DisplayFormat = '#,##0.0000'
      Properties.Precision = 4
      TabOrder = 10
      Width = 121
    end
    object cbFLG_ACNT: TcxDBCheckBox
      Left = 125
      Top = 348
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Contabilitate'
      DataBinding.DataField = 'FLG_ACNT'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Properties.OnEditValueChanged = cbFLGAccPropertiesEditValueChanged
      TabOrder = 8
      Transparent = True
    end
    object mmDocCOMMENTS: TcxDBMemo
      Left = 130
      Top = 423
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocProps
      ParentFont = False
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 5
      TabOrder = 12
      OnClick = mmDocCOMMENTSClick
      OnEnter = mmDocCOMMENTSClick
      Width = 641
    end
    object deDATA: TcxDBDateEdit
      Left = 125
      Top = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabStop = False
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentFont = False
      Properties.ClearKey = 16430
      Properties.DateButtons = [btnNow]
      Properties.ImmediatePost = True
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      TabOrder = 0
      Width = 116
    end
    object beDT_NAME: TcxButtonEdit
      Left = 125
      Top = 79
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            00000000000074120000741200000000000000000000FF00FF00FF00FF00FF00
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
      TabOrder = 3
      Text = 'beDT_NAME'
      Width = 364
    end
    object ceRATEUSD: TcxDBCalcEdit
      Left = 650
      Top = 373
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'RATEUSD'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentFont = False
      Properties.ImmediatePost = True
      TabOrder = 11
      Width = 121
    end
    object lcbAnalytics: TcxDBLookupComboBox
      Left = 250
      Top = 21
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'SC2'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentFont = False
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
      Width = 241
    end
    object beContract: TcxButtonEdit
      Left = 125
      Top = 255
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            00000000000074120000741200000000000000000000FF00FF00FF00FF00FF00
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
        end
        item
          Glyph.SourceDPI = 96
          Glyph.SourceHeight = 16
          Glyph.SourceWidth = 16
          Glyph.Data = {
            3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
            462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
            617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
            2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
            77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
            22307078222076696577426F783D2230203020333220333222207374796C653D
            22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
            3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
            303B3C7374796C6520747970653D22746578742F6373732220786D6C3A737061
            63653D227072657365727665223E2E426C75657B66696C6C3A23313137374437
            3B7D262331333B262331303B2623393B2E59656C6C6F777B66696C6C3A234646
            423131353B7D262331333B262331303B2623393B2E426C61636B7B66696C6C3A
            233732373237323B7D262331333B262331303B2623393B2E477265656E7B6669
            6C6C3A233033394332333B7D262331333B262331303B2623393B2E5265647B66
            696C6C3A234431314331433B7D262331333B262331303B2623393B2E7374307B
            6F7061636974793A302E37353B7D262331333B262331303B2623393B2E737431
            7B6F7061636974793A302E353B7D3C2F7374796C653E0D0A3C672069643D2244
            656C657465436972636C6564223E0D0A09093C7061746820636C6173733D2252
            65642220643D224D31362C3443392E342C342C342C392E342C342C313673352E
            342C31322C31322C31327331322D352E342C31322D31325332322E362C342C31
            362C347A204D32332E312C32302E326C2D322E382C322E384C31362C31382E38
            6C2D342E322C342E3220202623393B2623393B6C2D322E382D322E386C342E32
            2D342E326C2D342E322D342E326C322E382D322E386C342E322C342E326C342E
            322D342E326C322E382C322E384C31382E382C31364C32332E312C32302E327A
            222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beContractPropertiesButtonClick
      TabOrder = 6
      Width = 646
    end
    object lcbDTSC: TcxDBLookupComboBox
      Left = 500
      Top = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DTSC'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentFont = False
      ParentShowHint = False
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ColumnSorting = False
      Properties.ListOptions.GridLines = glNone
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceAnalitica
      ShowHint = True
      TabOrder = 2
      Width = 281
    end
    object cmbCurrency: TcxDBLookupComboBox
      Left = 129
      Top = 373
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'CURRENCYID'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentFont = False
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
      TabOrder = 9
      Width = 125
    end
    object lcbDT_CD: TcxDBLookupComboBox
      Left = 125
      Top = 116
      Hint = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DT_CD'
      DataBinding.DataSource = IBCDataSourceRechizite
      ParentFont = False
      ParentShowHint = False
      Properties.ClearKey = 16430
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownWidth = 500
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'ACCOUNTNUMBER'
      Properties.ListColumns = <
        item
          Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
          FieldName = 'ACCOUNTNUMBER'
        end
        item
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1095#1077#1090#1072
          FieldName = 'ACCOUNTNAME'
        end
        item
          Caption = #1057#1095#1077#1090' '#1073#1072#1085#1082#1072
          FieldName = 'BANKACCOUNT'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListSource = IBCDataSourceDT_Accounts
      Properties.OnInitPopup = lcbDT_CDPropertiesInitPopup
      ShowHint = True
      TabOrder = 4
      Width = 364
    end
    object lcbCT_CD: TcxDBLookupComboBox
      Left = 125
      Top = 205
      Hint = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090' '#1086#1090#1087#1088#1072#1074#1080#1090#1077#1083#1103
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'CT_CD'
      DataBinding.DataSource = IBCDataSourceRechizite
      ParentFont = False
      ParentShowHint = False
      Properties.ClearKey = 16430
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownWidth = 500
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'ACCOUNTNUMBER'
      Properties.ListColumns = <
        item
          Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
          FieldName = 'ACCOUNTNUMBER'
        end
        item
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1095#1077#1090#1072
          FieldName = 'ACCOUNTNAME'
        end
        item
          Caption = #1057#1095#1077#1090' '#1073#1072#1085#1082#1072
          FieldName = 'BANKACCOUNT'
        end>
      Properties.ListSource = IBCDataSourceCT_Accounts
      Properties.OnInitPopup = lcbCT_CDPropertiesInitPopup
      ShowHint = True
      TabOrder = 5
      Width = 364
    end
    object lcbDocumentState: TcxDBLookupComboBox
      Left = 500
      Top = 310
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'STATEID'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentFont = False
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'STATEID'
      Properties.ListColumns = <
        item
          Caption = 'cod'
          Fixed = True
          HeaderAlignment = taCenter
          MinWidth = 30
          Width = 30
          FieldName = 'STATEID'
        end
        item
          Caption = 'statut'
          HeaderAlignment = taCenter
          MinWidth = 100
          Width = 150
          FieldName = 'TITLE'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListSource = IBCDataSourceStates
      TabOrder = 13
      Width = 271
    end
    object beCT_NAME: TcxButtonEdit
      Left = 125
      Top = 168
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            00000000000074120000741200000000000000000000FF00FF00FF00FF00FF00
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
      Properties.IncrementalSearch = False
      Properties.OnButtonClick = beCT_NAMEPropertiesButtonClick
      TabOrder = 14
      Text = 'beDT_NAME'
      Width = 364
    end
  end
  object btnOk: TcxButton
    Left = 554
    Top = 656
    Width = 112
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = True
    ModalResult = 1
    OptionsImage.Spacing = 5
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 674
    Top = 656
    Width = 112
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    OptionsImage.Spacing = 5
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
    Left = 552
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocProps: TIBCDataSource
    DataSet = IBCQueryDocProps
    Left = 552
    Top = 296
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
    Top = 240
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
    Top = 200
  end
  object IBCDataSourceCT_Accounts: TIBCDataSource
    DataSet = IBCQueryCT_Accounts
    Left = 540
    Top = 200
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
    Top = 240
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
  object IBCQueryStates: TIBCQuery
    KeyFields = 'STATEID'
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_doctypes_states'
      'where doctypeid = :doctypeid')
    Options.CacheBlobs = False
    Left = 536
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'doctypeid'
        Value = nil
      end>
  end
  object IBCDataSourceStates: TIBCDataSource
    DataSet = IBCQueryStates
    Left = 536
    Top = 96
  end
end
