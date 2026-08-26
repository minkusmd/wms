object frmGoodsForeignCodeEditorDlg: TfrmGoodsForeignCodeEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edGOODS_CODE
  Anchors = [akLeft]
  BorderStyle = bsDialog
  Caption = 'Cod produs furnizor'
  ClientHeight = 593
  ClientWidth = 863
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    863
    593)
  TextHeight = 15
  object Label14: TLabel
    Left = 328
    Top = 272
    Width = 10
    Height = 15
    Caption = '%'
  end
  object Label15: TLabel
    Left = 344
    Top = 272
    Width = 25
    Height = 15
    Caption = '4.5%'
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 863
    Height = 64
    Title = 'Cod produs furnizor'
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
    ImageIndex = 17
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 847
    Height = 473
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
      Left = 16
      Top = 25
      Width = 43
      Height = 15
      Caption = 'Furnizor'
    end
    object Label2: TLabel
      Left = 16
      Top = 54
      Width = 22
      Height = 15
      Caption = 'Cod'
    end
    object Label3: TLabel
      Left = 17
      Top = 95
      Width = 118
      Height = 15
      Caption = 'Denumirea produsului'
    end
    object bbGenerateCode: TSpeedButton
      Left = 320
      Top = 51
      Width = 76
      Height = 23
      Caption = 'Genereaza'
      OnClick = bbGenerateCodeClick
    end
    object sbTakeCode: TSpeedButton
      Left = 402
      Top = 51
      Width = 79
      Height = 23
      Caption = 'Din "code"'
      OnClick = sbTakeCodeClick
    end
    object Label4: TLabel
      Left = 63
      Top = 76
      Width = 71
      Height = 15
      Caption = 'case sensitive'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 572
      Top = 54
      Width = 43
      Height = 15
      Caption = 'Barcode'
    end
    object Label16: TLabel
      Left = 16
      Top = 197
      Width = 15
      Height = 15
      Caption = 'Url'
    end
    object beFirma: TcxButtonEdit
      Left = 65
      Top = 21
      ParentFont = False
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
      Properties.OnButtonClick = beFirmaPropertiesButtonClick
      TabOrder = 0
      Width = 416
    end
    object edGOODS_CODE: TcxDBTextEdit
      Left = 64
      Top = 51
      DataBinding.DataField = 'GOODS_CODE'
      ParentFont = False
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Width = 250
    end
    object mmGOODS_TITLE: TcxDBMemo
      Left = 16
      Top = 116
      DataBinding.DataField = 'GOODS_TITLE'
      ParentFont = False
      Properties.AutoSelect = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = True
      Style.LookAndFeel.ScrollbarMode = sbmClassic
      Style.Shadow = False
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.ScrollbarMode = sbmClassic
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.ScrollbarMode = sbmClassic
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.ScrollbarMode = sbmClassic
      StyleReadOnly.LookAndFeel.Kind = lfUltraFlat
      StyleReadOnly.LookAndFeel.NativeStyle = True
      StyleReadOnly.LookAndFeel.ScrollbarMode = sbmClassic
      TabOrder = 4
      Width = 804
    end
    object cbAvailable: TcxDBCheckBox
      Left = 685
      Top = 280
      TabStop = False
      Caption = 'Cant suficienta'
      DataBinding.DataField = 'FLG_AVAILABLE_QTY'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 9
    end
    object cbPromo: TcxDBCheckBox
      Left = 685
      Top = 256
      TabStop = False
      Caption = 'Furnizor prioritar'
      DataBinding.DataField = 'FLG_SUPPLIER_PRIORITY'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 8
    end
    object cbInPrice: TcxDBCheckBox
      Left = 685
      Top = 304
      TabStop = False
      Caption = 'In Stoc'
      DataBinding.DataField = 'FLG_IN_PRICE'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 10
    end
    object cbFLG_DRP: TcxDBCheckBox
      Left = 685
      Top = 351
      TabStop = False
      Caption = 'Diler pret pecomandat'
      DataBinding.DataField = 'FLG_DRP'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 12
    end
    object cbFLG_EPP: TcxDBCheckBox
      Left = 685
      Top = 231
      TabStop = False
      Caption = 'Pret recomandat'
      DataBinding.DataField = 'FLG_RRP'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 7
    end
    object sbTakeDesc: TcxButton
      Left = 666
      Top = 80
      Width = 154
      Height = 24
      Caption = 'Din descrierea produsului'
      TabOrder = 3
      TabStop = False
      OnClick = sbTakeDescClick
    end
    object edBarCode: TcxDBTextEdit
      Left = 621
      Top = 51
      TabStop = False
      DataBinding.DataField = 'BARCODE'
      ParentFont = False
      Style.TextStyle = []
      Style.TransparentBorder = True
      TabOrder = 2
      Width = 200
    end
    object cbPreOrder: TcxDBCheckBox
      Left = 685
      Top = 328
      TabStop = False
      Caption = 'Pre Order'
      DataBinding.DataField = 'FLG_PREORDER'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 11
    end
    object Panel1: TPanel
      Left = 16
      Top = 223
      Width = 649
      Height = 232
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 6
      object Label7: TLabel
        Left = 9
        Top = 13
        Width = 92
        Height = 15
        Caption = 'Indicativ | Valuta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 430
        Top = 13
        Width = 62
        Height = 15
        Caption = 'RRP | Valuta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 9
        Top = 144
        Width = 94
        Height = 15
        Caption = 'Club Card | Valuta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 8
        Top = 93
        Width = 65
        Height = 15
        Caption = 'Diler | Valuta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 431
        Top = 53
        Width = 43
        Height = 15
        Caption = 'Calculat'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 434
        Top = 98
        Width = 36
        Height = 15
        Caption = 'Promo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 431
        Top = 144
        Width = 80
        Height = 15
        Caption = 'Online | Valuta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 9
        Top = 44
        Width = 24
        Height = 15
        Caption = 'Cost'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lcbCurrency7: TcxDBLookupComboBox
        Left = 183
        Top = 9
        TabStop = False
        DataBinding.DataField = 'ORD_CURRENCY7ID'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.GridMode = True
        Properties.KeyFieldNames = 'CURRENCYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.RowSelect = False
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceCurrency7
        Properties.OnChange = lcbCurrency7PropertiesChange
        TabOrder = 3
        Width = 50
      end
      object cePrice7: TcxDBCalcEdit
        Left = 107
        Top = 8
        DataBinding.DataField = 'ORD_PRICE7'
        ParentFont = False
        Properties.DisplayFormat = '0.00'
        Properties.ImmediatePost = True
        Properties.QuickClose = True
        Properties.UseThousandSeparator = True
        TabOrder = 0
        OnExit = cePrice5Exit
        Width = 70
      end
      object lcbCurrency3: TcxDBLookupComboBox
        Left = 591
        Top = 9
        TabStop = False
        DataBinding.DataField = 'CURRENCY3ID'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'CURRENCYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.RowSelect = False
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceCurrency4
        TabOrder = 4
        Width = 50
      end
      object cePrice3: TcxDBCalcEdit
        Left = 516
        Top = 8
        DataBinding.DataField = 'PRICE3'
        ParentFont = False
        Properties.DisplayFormat = '0.00'
        Properties.ImmediatePost = True
        Properties.QuickClose = True
        Properties.UseLeftAlignmentOnEditing = False
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 2
        OnExit = cePrice3Exit
        Width = 70
      end
      object cePrice5: TcxDBCalcEdit
        Left = 107
        Top = 138
        TabStop = False
        DataBinding.DataField = 'PRICE5'
        ParentFont = False
        Properties.DisplayFormat = '0.00'
        Properties.ImmediatePost = True
        Properties.QuickClose = True
        Properties.UseThousandSeparator = True
        TabOrder = 17
        OnExit = cePrice5Exit
        Width = 70
      end
      object cePrice6: TcxDBCalcEdit
        Left = 107
        Top = 87
        TabStop = False
        DataBinding.DataField = 'PRICE6'
        ParentFont = False
        Properties.DisplayFormat = '0.00'
        Properties.ImmediatePost = True
        Properties.QuickClose = True
        Properties.UseThousandSeparator = True
        TabOrder = 8
        OnExit = cePrice5Exit
        Width = 70
      end
      object lcbCurrency6: TcxDBLookupComboBox
        Left = 183
        Top = 87
        TabStop = False
        DataBinding.DataField = 'CURRENCY6ID'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'CURRENCYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.RowSelect = False
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceCurrency4
        TabOrder = 9
        Width = 50
      end
      object lcbCurrency5: TcxDBLookupComboBox
        Left = 184
        Top = 138
        TabStop = False
        DataBinding.DataField = 'CURRENCY5ID'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'CURRENCYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.RowSelect = False
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceCurrency4
        TabOrder = 19
        Width = 50
      end
      object cePrice4: TcxDBCalcEdit
        Left = 517
        Top = 53
        DataBinding.DataField = 'PRICE4'
        Enabled = False
        ParentFont = False
        Properties.DisplayFormat = '0.00'
        Properties.ImmediatePost = True
        Properties.QuickClose = True
        Properties.UseThousandSeparator = True
        TabOrder = 6
        OnExit = cePrice5Exit
        Width = 70
      end
      object cePrice2: TcxDBCalcEdit
        Left = 518
        Top = 98
        DataBinding.DataField = 'PRICE2'
        Enabled = False
        ParentFont = False
        Properties.DisplayFormat = '0.00'
        Properties.ImmediatePost = True
        Properties.QuickClose = True
        Properties.UseThousandSeparator = True
        TabOrder = 11
        OnExit = cePrice5Exit
        Width = 70
      end
      object lcbCurrency2: TcxDBLookupComboBox
        Left = 592
        Top = 98
        TabStop = False
        DataBinding.DataField = 'CURRENCY2ID'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'CURRENCYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.RowSelect = False
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceCurrency4
        TabOrder = 13
        Width = 50
      end
      object lcbCurrency4: TcxDBLookupComboBox
        Left = 591
        Top = 53
        TabStop = False
        DataBinding.DataField = 'CURRENCY4ID'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'CURRENCYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.RowSelect = False
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceCurrency4
        TabOrder = 7
        Width = 50
      end
      object lcbCurrency1: TcxDBLookupComboBox
        Left = 591
        Top = 139
        TabStop = False
        DataBinding.DataField = 'CURRENCY1ID'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'CURRENCYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.RowSelect = False
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceCurrency4
        TabOrder = 24
        Width = 50
      end
      object cePrice1: TcxDBCalcEdit
        Left = 517
        Top = 139
        TabStop = False
        DataBinding.DataField = 'PRICE1'
        ParentFont = False
        Properties.DisplayFormat = '0.00'
        Properties.ImmediatePost = True
        Properties.QuickClose = True
        Properties.UseLeftAlignmentOnEditing = False
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 22
        OnExit = cePrice3Exit
        Width = 70
      end
      object btnMargin: TcxButton
        Left = 238
        Top = 8
        Width = 33
        Height = 25
        Caption = '20%'
        TabOrder = 1
        TabStop = False
        OnClick = btnMarginClick
      end
      object lbMargin37: TcxLabel
        Left = 536
        Top = 31
        AutoSize = False
        Caption = 'lbMargin37'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -9
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 12
        Height = 16
        Width = 50
        AnchorX = 586
      end
      object lbMargin47: TcxLabel
        Left = 536
        Top = 76
        AutoSize = False
        Caption = 'lbMargin47'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -9
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 14
        Height = 16
        Width = 50
        AnchorX = 586
      end
      object lbMargin57: TcxLabel
        Left = 129
        Top = 167
        AutoSize = False
        Caption = 'lbMargin57'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -9
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 15
        Height = 16
        Width = 49
        AnchorX = 178
      end
      object lbMargin67: TcxLabel
        Left = 127
        Top = 114
        AutoSize = False
        Caption = 'lbMargin67'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -9
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 16
        Height = 16
        Width = 50
        AnchorX = 177
      end
      object lbDiff67: TcxLabel
        Left = 183
        Top = 114
        AutoSize = False
        Caption = 'lbMargin67'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -9
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 18
        Height = 16
        Width = 50
        AnchorX = 233
      end
      object lbDiff57: TcxLabel
        Left = 185
        Top = 167
        AutoSize = False
        Caption = 'lbMargin57'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -9
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 21
        Height = 16
        Width = 49
        AnchorX = 234
      end
      object lbDiff37: TcxLabel
        Left = 592
        Top = 31
        AutoSize = False
        Caption = 'Diff37'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -9
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 23
        Height = 16
        Width = 50
        AnchorX = 642
      end
      object lbDiff47: TcxLabel
        Left = 592
        Top = 76
        AutoSize = False
        Caption = 'Diff47'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -9
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 25
        Height = 16
        Width = 50
        AnchorX = 642
      end
      object lbDiff17: TcxLabel
        Left = 591
        Top = 169
        AutoSize = False
        Caption = 'diff47'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -9
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 26
        Height = 16
        Width = 50
        AnchorX = 641
      end
      object lbMargin17: TcxLabel
        Left = 535
        Top = 168
        AutoSize = False
        Caption = 'lbMargin17'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -9
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 27
        Height = 16
        Width = 50
        AnchorX = 585
      end
      object ceMMargin6: TcxDBCalcEdit
        Left = 239
        Top = 87
        TabStop = False
        DataBinding.DataField = 'MARGIN6'
        ParentFont = False
        Properties.DisplayFormat = '0.0'
        Properties.ImmediatePost = True
        Properties.QuickClose = True
        Properties.UseThousandSeparator = True
        TabOrder = 10
        OnExit = cePrice5Exit
        Width = 48
      end
      object ceMMargin5: TcxDBCalcEdit
        Left = 240
        Top = 138
        TabStop = False
        DataBinding.DataField = 'MARGIN5'
        ParentFont = False
        Properties.DisplayFormat = '0.0'
        Properties.ImmediatePost = True
        Properties.QuickClose = True
        Properties.UseThousandSeparator = True
        TabOrder = 20
        OnExit = cePrice5Exit
        Width = 48
      end
      object lbPrice7LEICalc: TcxLabel
        Left = 277
        Top = 14
        AutoSize = False
        Caption = 'lbPrice7LEI'
        ParentFont = False
        Style.BorderStyle = ebsNone
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBtnText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.TextColor = clBtnText
        Style.TextStyle = [fsBold]
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 28
        Height = 16
        Width = 76
        AnchorX = 353
      end
      object ceCost: TcxDBCalcEdit
        Left = 107
        Top = 37
        TabStop = False
        DataBinding.DataField = 'PRICE0'
        ParentFont = False
        Properties.DisplayFormat = '0.00'
        Properties.ImmediatePost = True
        Properties.QuickClose = True
        Properties.UseThousandSeparator = True
        TabOrder = 5
        OnExit = cePrice5Exit
        Width = 70
      end
      object Label17: TLabel
        Left = 9
        Top = 200
        Width = 91
        Height = 15
        Caption = 'Rate 0% | 6 luni'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cePriceCredit0: TcxDBCalcEdit
        Left = 107
        Top = 196
        Hint = 
          'Pret de vinzare in rate 6 luni 0%, MDL. Calculat automat: max(Web, ' +
          'Indicativ in MDL + 16%).'
        DataBinding.DataField = 'PRICE_CREDIT0'
        ParentFont = False
        ParentShowHint = False
        Properties.DisplayFormat = '0.00'
        Properties.ImmediatePost = True
        Properties.QuickClose = True
        Properties.ReadOnly = True
        Properties.UseThousandSeparator = True
        ShowHint = True
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabStop = False
        TabOrder = 29
        Width = 70
      end
      object lbCredit0Info: TcxLabel
        Left = 190
        Top = 199
        AutoSize = False
        Caption = 'lbCredit0Info'
        ParentFont = False
        Style.BorderStyle = ebsNone
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clGrayText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.TextColor = clGrayText
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        TabOrder = 30
        Height = 16
        Width = 440
        AnchorX = 410
      end
    end
    object teURL: TcxDBTextEdit
      Left = 48
      Top = 194
      DataBinding.DataField = 'URL'
      ParentFont = False
      TabOrder = 5
      Width = 773
    end
  end
  object btnOk: TcxButton
    Left = 661
    Top = 556
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TcxButton
    Left = 757
    Top = 556
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
  end
  object btnResetValues: TcxButton
    Left = 25
    Top = 556
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Reset values'
    TabOrder = 2
    OnClick = btnResetValuesClick
  end
  object IBCQueryCurrency7: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_currency')
    Left = 120
    Top = 216
  end
  object IBCDataSourceCurrency7: TIBCDataSource
    DataSet = IBCQueryCurrency7
    Left = 120
    Top = 152
  end
  object IBCQueryCurrency4: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_currency')
    Left = 256
    Top = 216
  end
  object IBCDataSourceCurrency4: TIBCDataSource
    DataSet = IBCQueryCurrency4
    Left = 256
    Top = 152
  end
  object IBCQueryCurrency: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_currency')
    Left = 416
    Top = 216
  end
  object IBCDataSourceCurrency: TIBCDataSource
    DataSet = IBCQueryCurrency
    Left = 376
    Top = 176
  end
  object cxDefaultEditStyleController1: TcxDefaultEditStyleController
    Style.BorderStyle = ebsUltraFlat
    Style.Font.Charset = RUSSIAN_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -12
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = True
    Style.IsFontAssigned = True
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = True
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.NativeStyle = True
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.NativeStyle = True
    StyleReadOnly.LookAndFeel.Kind = lfUltraFlat
    StyleReadOnly.LookAndFeel.NativeStyle = True
    Left = 600
    Top = 16
    PixelsPerInch = 96
  end
  object IBCTrLocal: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 424
    Top = 264
  end
end
