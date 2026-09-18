object frmDocumentPreviewDlg: TfrmDocumentPreviewDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Preview document'
  ClientHeight = 621
  ClientWidth = 1287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1281
    Height = 579
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 0
    DesignSize = (
      1277
      575)
    object Label5: TLabel
      Left = 12
      Top = 20
      Width = 82
      Height = 15
      Caption = 'Data document'
      Transparent = True
    end
    object Label1: TLabel
      Left = 12
      Top = 79
      Width = 53
      Height = 15
      Caption = 'Societate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 12
      Top = 127
      Width = 32
      Height = 15
      Caption = 'Client'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 269
      Top = 20
      Width = 66
      Height = 15
      Caption = 'Valuta si rata'
      Transparent = True
    end
    object Label8: TLabel
      Left = 14
      Top = 175
      Width = 48
      Height = 15
      Caption = 'Mentiuni'
      Transparent = True
    end
    object Label6: TLabel
      Left = 674
      Top = 76
      Width = 60
      Height = 15
      Caption = 'Din depozit'
      Transparent = True
    end
    object Label11: TLabel
      Left = 471
      Top = 79
      Width = 27
      Height = 15
      Caption = 'IBAN'
      Transparent = True
    end
    object Label10: TLabel
      Left = 471
      Top = 128
      Width = 27
      Height = 15
      Caption = 'IBAN'
      Transparent = True
    end
    object Label12: TLabel
      Left = 674
      Top = 126
      Width = 52
      Height = 15
      Caption = 'In depozit'
      Transparent = True
    end
    object lbSuma: TLabel
      Left = 149
      Top = 20
      Width = 30
      Height = 15
      Caption = 'Suma'
      Transparent = True
    end
    object Label7: TLabel
      Left = 674
      Top = 17
      Width = 46
      Height = 15
      Caption = 'Analitica'
      Transparent = True
    end
    object Label4: TLabel
      Left = 674
      Top = 176
      Width = 44
      Height = 15
      Caption = 'Creat de'
      Transparent = True
    end
    object Label9: TLabel
      Left = 917
      Top = 175
      Width = 40
      Height = 15
      Caption = 'Creat la'
      Transparent = True
    end
    object Label13: TLabel
      Left = 471
      Top = 17
      Width = 74
      Height = 15
      Caption = 'Tip document'
      Transparent = True
    end
    object ceRATE: TcxDBCalcEdit
      Left = 335
      Top = 41
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      Properties.ImmediatePost = True
      Properties.ReadOnly = True
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 10
      Width = 63
    end
    object lcbDTSC: TcxDBLookupComboBox
      Left = 917
      Top = 97
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1086#1090#1087#1088#1072#1074#1080#1090#1077#1083#1103
      DataBinding.DataField = 'DTSC'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      ParentShowHint = False
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceAnalitica
      Properties.ReadOnly = True
      ShowHint = True
      Style.LookAndFeel.NativeStyle = False
      Style.ReadOnly = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 5
      Width = 212
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 18
      Top = 196
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocProps
      Enabled = False
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 4
      Style.LookAndFeel.NativeStyle = False
      Style.ReadOnly = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 12
      Width = 641
    end
    object deDATA: TcxDBDateEdit
      Left = 18
      Top = 41
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      Properties.DateButtons = [btnClear, btnNow]
      Properties.Kind = ckDateTime
      Properties.ReadOnly = True
      Properties.WeekNumbers = True
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 0
      Width = 125
    end
    object cbFLG_ACNT: TcxDBCheckBox
      Left = 917
      Top = 41
      Caption = 'Contabilitate'
      DataBinding.DataField = 'FLG_ACNT'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ReadOnly = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = False
      Style.TransparentBorder = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 1
    end
    object lcbDTDEP: TcxDBLookupComboBox
      Left = 674
      Top = 97
      DataBinding.DataField = 'DTDEP'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 300
      Properties.KeyFieldNames = 'STOCKID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 180
          FieldName = 'TITLE'
        end
        item
          Fixed = True
          Width = 120
          FieldName = 'PARENT_TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceStocks
      Properties.ReadOnly = True
      Style.LookAndFeel.NativeStyle = False
      Style.ReadOnly = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 4
      Width = 229
    end
    object lcbDT_Account: TcxDBLookupComboBox
      Left = 471
      Top = 97
      DataBinding.DataField = 'DT_CD'
      DataBinding.DataSource = IBCDataSourceRechizite
      Enabled = False
      Properties.ClearKey = 16430
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownWidth = 400
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
      Properties.ListSource = IBCDataSourceDT_Accounts
      Properties.ReadOnly = True
      Style.LookAndFeel.NativeStyle = False
      Style.ReadOnly = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 3
      Width = 188
    end
    object lcbCT_Account: TcxDBLookupComboBox
      Left = 471
      Top = 146
      DataBinding.DataField = 'CT_CD'
      DataBinding.DataSource = IBCDataSourceRechizite
      Enabled = False
      Properties.ClearKey = 16430
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownWidth = 400
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
      Properties.ReadOnly = True
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 7
      Width = 188
    end
    object lcbCTDEP: TcxDBLookupComboBox
      Left = 674
      Top = 147
      DataBinding.DataField = 'CTDEP'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 300
      Properties.KeyFieldNames = 'STOCKID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 180
          FieldName = 'TITLE'
        end
        item
          Fixed = True
          Width = 120
          FieldName = 'PARENT_TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceStocks
      Properties.ReadOnly = True
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 8
      Width = 229
    end
    object beDT_NAME: TcxButtonEdit
      Left = 18
      Top = 97
      Enabled = False
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
      Properties.ReadOnly = True
      Properties.ViewStyle = vsHideCursor
      Style.LookAndFeel.NativeStyle = False
      Style.ReadOnly = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 2
      Text = 'beDT_NAME'
      Width = 439
    end
    object beCT_NAME: TcxButtonEdit
      Left = 18
      Top = 146
      Enabled = False
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
      Properties.ReadOnly = True
      Properties.ViewStyle = vsHideCursor
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 6
      Text = 'beCT_NAME'
      Width = 439
    end
    object ceRATEUSD: TcxDBCalcEdit
      Left = 404
      Top = 41
      DataBinding.DataField = 'RATEUSD'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      Properties.ImmediatePost = True
      Properties.ReadOnly = True
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 11
      Width = 55
    end
    object lcbAnalytics: TcxDBLookupComboBox
      Left = 674
      Top = 38
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      DataBinding.DataField = 'SC2'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      ParentShowHint = False
      Properties.DropDownAutoSize = True
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'ANALITICAID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 180
          FieldName = 'TITLE'
        end
        item
          Fixed = True
          Width = 180
          FieldName = 'PARENT_TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceAnalytics
      Properties.ReadOnly = True
      ShowHint = True
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 14
      Width = 229
    end
    object lcbCURRENCY: TcxDBLookupComboBox
      Left = 264
      Top = 41
      DataBinding.DataField = 'CURRENCYID'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 150
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceCurrency
      Properties.ReadOnly = True
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 15
      Width = 65
    end
    object lcbCTSC: TcxDBLookupComboBox
      Left = 917
      Top = 146
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1086#1090#1087#1088#1072#1074#1080#1090#1077#1083#1103
      DataBinding.DataField = 'DTSC'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      ParentShowHint = False
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceAnalitica
      Properties.ReadOnly = True
      ShowHint = True
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 9
      Width = 212
    end
    object ceSuma: TcxDBCalcEdit
      Left = 149
      Top = 41
      DataBinding.DataField = 'SUMA'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      Properties.ImmediatePost = True
      Properties.ReadOnly = True
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 13
      Width = 109
    end
    object Panel1: TPanel
      Left = 12
      Top = 280
      Width = 1254
      Height = 285
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 16
      object cxGridJurnal: TcxGrid
        Left = 0
        Top = 0
        Width = 1250
        Height = 281
        Align = alClient
        TabOrder = 0
        LookAndFeel.NativeStyle = True
        LookAndFeel.SkinName = ''
        object cxGridJurnalTable: TcxGridDBTableView
          OnKeyDown = cxGridJurnalTableKeyDown
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = True
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.Prior.Visible = True
          Navigator.Buttons.Next.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Last.Visible = True
          Navigator.Buttons.Insert.Visible = True
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Delete.Visible = True
          Navigator.Buttons.Edit.Visible = True
          Navigator.Buttons.Post.Visible = True
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = True
          Navigator.Buttons.GotoBookmark.Visible = True
          Navigator.Buttons.Filter.Visible = True
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSourceJurnal
          DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'QTY'
              Column = cxGridDBCol_QTY
            end
            item
              Kind = skSum
              FieldName = 'SUMA'
              Column = cxGridJurnal_SUMA
            end
            item
              Kind = skSum
              FieldName = 'SUMAVAT'
            end
            item
              Kind = skCount
              Column = cxGridDBCol_GOODSID
            end
            item
              Format = '#,##0.00'
              Kind = skSum
            end
            item
              Format = '#,##0.00'
              Kind = skSum
            end
            item
              Kind = skSum
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
            Caption = 'Dep. Furnizor'
            DataBinding.FieldName = 'DTDEP_NAME'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Width = 113
          end
          object cxGridDBCol_CTDEP_NAME: TcxGridDBColumn
            Caption = 'Dep. Beneficiar'
            DataBinding.FieldName = 'CTDEP_NAME'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Width = 95
          end
          object cxGridDBCol_GOODSID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GOODSID'
            DataBinding.IsNullValueType = True
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Styles.Footer = dmAdditions.cxStyle_Bold
            Width = 42
          end
          object cxGridDBCol_IMG: TcxGridDBColumn
            DataBinding.FieldName = 'GOODS_TYPE_ID'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 12
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 44
                Value = 4203
              end>
            HeaderAlignmentHorz = taCenter
            MinWidth = 26
            Options.Focusing = False
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 26
            IsCaptionAssigned = True
          end
          object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'GOODS_NAME'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            Width = 504
          end
          object cxGridDBCol_QTY: TcxGridDBColumn
            Caption = 'Cant'
            DataBinding.FieldName = 'QTY'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxCalcEditProperties'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 36
            Options.Focusing = False
            Options.HorzSizing = False
            Width = 36
          end
          object cxGridDBCol_UM_NAME: TcxGridDBColumn
            AlternateCaption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
            Caption = 'UM'
            DataBinding.FieldName = 'UM_NAME'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 32
            Options.Grouping = False
            Options.HorzSizing = False
            Options.Sorting = False
            Width = 32
          end
          object cxGridJurna_PRICE: TcxGridDBColumn
            Caption = 'Pret'
            DataBinding.FieldName = 'PRICE'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridJurnal_SUMA: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridDBCol_FLG_READY: TcxGridDBColumn
            AlternateCaption = 'Valid'
            Caption = 'G'
            DataBinding.FieldName = 'FLG_READY'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridJurnal_FLG_ACTIVE: TcxGridDBColumn
            Caption = 'Act'
            DataBinding.FieldName = 'FLG_ACTIVE'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 25
            Options.HorzSizing = False
            Width = 25
          end
          object cxGridJurnal_STOCK_QTY: TcxGridDBColumn
            Caption = 'Sold'
            DataBinding.FieldName = 'STOCK_QTY'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxCalcEditProperties'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridJurna_GOODS_ACNT_ID: TcxGridDBColumn
            AlternateCaption = 'Cod produs pe contabilitlate'
            Caption = 'Cod cont'
            DataBinding.FieldName = 'GOODS_ACNT_ID'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridJurnal_GOODS_NAMEACNT: TcxGridDBColumn
            Caption = 'Denumire facturi'
            DataBinding.FieldName = 'GOODS_NAMEACNT'
            DataBinding.IsNullValueType = True
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 57
          end
          object cxGridJurnal_PRICE_COLUMN: TcxGridDBColumn
            AlternateCaption = 'Grila de pret'
            Caption = 'P'
            DataBinding.FieldName = 'PRICE_COLUMN'
            DataBinding.IsNullValueType = True
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 30
            Options.HorzSizing = False
            Width = 30
          end
          object cxGridJurnal_CREATED_BY_NAME: TcxGridDBColumn
            Caption = 'Utilizator'
            DataBinding.FieldName = 'CREATED_BY_NAME'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            Width = 75
          end
          object cxGridJurnal_UMID: TcxGridDBColumn
            DataBinding.FieldName = 'UMID'
            DataBinding.IsNullValueType = True
            Visible = False
            HeaderAlignmentHorz = taCenter
            VisibleForCustomization = False
          end
        end
        object cxGridJurnalLevel: TcxGridLevel
          GridView = cxGridJurnalTable
        end
      end
    end
    object teUsername: TcxDBTextEdit
      Left = 674
      Top = 197
      DataBinding.DataField = 'CREATED_BY_NAME'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 17
      Width = 229
    end
    object cxDBDateEdit1: TcxDBDateEdit
      Left = 917
      Top = 196
      DataBinding.DataField = 'CREATED_DATE'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      Properties.DateButtons = [btnClear, btnNow]
      Properties.Kind = ckDateTime
      Properties.ReadOnly = True
      Properties.WeekNumbers = True
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 18
      Width = 125
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 674
      Top = 237
      Caption = 'Doc. Inchis'
      DataBinding.DataField = 'FLG_CLOSED'
      DataBinding.DataSource = IBCDataSourceDocs
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ReadOnly = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Style.LookAndFeel.NativeStyle = False
      Style.TransparentBorder = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 19
    end
    object cxDBTextEdit1: TcxDBTextEdit
      Left = 471
      Top = 38
      DataBinding.DataField = 'DOCTYPE_NAME'
      DataBinding.DataSource = IBCDataSourceDocs
      Enabled = False
      Properties.ReadOnly = True
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      StyleReadOnly.LookAndFeel.NativeStyle = False
      TabOrder = 20
      Width = 188
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 585
    Width = 1287
    TabOrder = 1
  end
  object IBCQueryDT_Accounts: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
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
    MasterSource = IBCDataSourceDocs
    Left = 164
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceDT_Accounts: TIBCDataSource
    DataSet = IBCQueryDT_Accounts
    Left = 164
    Top = 144
  end
  object IBCDataSourceCT_Accounts: TIBCDataSource
    DataSet = IBCQueryCT_Accounts
    Left = 304
    Top = 136
  end
  object IBCQueryCT_Accounts: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
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
    MasterSource = IBCDataSourceDocs
    Left = 304
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end>
  end
  object IBCQueryRechizite: TIBCQuery
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
    MasterSource = IBCDataSourceDocs
    AutoCommit = False
    Left = 464
    Top = 60
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceRechizite: TIBCDataSource
    DataSet = IBCQueryRechizite
    Left = 464
    Top = 16
  end
  object IBCDataSourceDocProps: TIBCDataSource
    DataSet = IBCQueryDocProps
    Left = 356
    Top = 400
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
      '  INBAZA = :INBAZA, COMMENTS = :COMMENTS'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      'SELECT '
      ' INBAZA, '
      ' COMMENTS '
      'FROM '
      ' TDB_DOCS_PROPS'
      'WHERE'
      '  DOCID = :DOCID')
    Connection = dmDB.IBCConnection
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
    MasterSource = IBCDataSourceDocs
    AutoCommit = False
    Left = 356
    Top = 448
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 608
    Top = 24
  end
  object IBCQueryDocs: TIBCQuery
    KeyFields = 'DOCID'
    KeyGenerator = 'SQ_TDB_DOCS_DOCID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS'
      '  (DOCID, DOCNO, DATA, '
      '   DT, DT_NAME, CT, CT_NAME, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, '
      '   DTSC, SC2,'
      '   SUMA, VAT, CURRENCYID, DISCOUNT, RATE, '
      ''
      '   FLG_SHIP, FLG_ACNT, FLG_DEL, FLG_PROTECTED,'
      '   FLG_SEND, FLG_RECEIVE, FLG_PAID, FLG_INVOICE, '
      '   FLG_GOODS_ARRIVAL, FLG_READY, FLG_CHILD, FLG_NEW_CEC, FLG_SALARY, FLG_UPDATE_DATE,'
      '   FLG_FURNITURE, '
      ''
      '   CREATED_DATE, CREATED_BY, DELETED_DATE, DELETED_BY, '
      '   PARENTDOCID, ACC$MASK, DOCTYPEID,'
      '   RATEUSD,'
      '   CONTRACTID,'
      '   CTSC '
      '  )'
      'VALUES'
      '  (:DOCID, :DOCNO, :DATA, :DT, :DT_NAME, :CT, :CT_NAME, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, '
      '   :DTSC, :SC2,'
      '   :SUMA, :VAT, :CURRENCYID, :DISCOUNT, :RATE, '
      ''
      '   :FLG_SHIP, :FLG_ACNT, :FLG_DEL, :FLG_PROTECTED,'
      '   :FLG_SEND, :FLG_RECEIVE, :FLG_PAID, :FLG_INVOICE, '
      '   :FLG_GOODS_ARRIVAL, :FLG_READY, :FLG_CHILD, :FLG_NEW_CEC, :FLG_SALARY, :FLG_UPDATE_DATE,'
      '   :FLG_FURNITURE,'
      ' '
      '   :CREATED_DATE, :CREATED_BY, :DELETED_DATE, :DELETED_BY, '
      '   :PARENTDOCID, :"ACC$MASK", :DOCTYPEID,'
      '   :RATEUSD,'
      '   :CONTRACTID,'
      '   :CTSC'
      '  )')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DOCS'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DOCS'
      'SET'
      '  DOCID = :DOCID, '
      '  DOCNO = :DOCNO, '
      '  DATA = :DATA, '
      '  DT = :DT, '
      '  DT_NAME = :DT_NAME, '
      '  CT = :CT, '
      '  CT_NAME = :CT_NAME, '
      '  DTDEP = :DTDEP, '
      '  DTDEP_NAME = :DTDEP_NAME, '
      '  CTDEP = :CTDEP, '
      '  CTDEP_NAME = :CTDEP_NAME, '
      '  DTSC = :DTSC, '
      '  CTSC = :CTSC,'
      '  SC2 = :SC2,'
      '  SUMA = :SUMA, '
      '  VAT = :VAT, '
      '  CURRENCYID = :CURRENCYID, '
      '  DISCOUNT = :DISCOUNT, '
      '  RATE = :RATE, '
      '  FLG_SHIP = :FLG_SHIP,'
      '  FLG_ACNT = :FLG_ACNT, '
      '  FLG_DEL = :FLG_DEL, '
      '  FLG_PROTECTED = :FLG_PROTECTED, '
      '  FLG_SEND = :FLG_SEND,'
      '  FLG_RECEIVE = :FLG_RECEIVE,'
      '  FLG_PAID = :FLG_PAID,'
      '  FLG_INVOICE = :FLG_INVOICE,'
      '  FLG_GOODS_ARRIVAL = :FLG_GOODS_ARRIVAL,'
      '  FLG_READY = :FLG_READY,'
      '  flg_child = :FLG_CHILD,'
      '  FLG_NEW_CEC = :FLG_NEW_CEC,'
      '  FLG_SALARY = :FLG_SALARY,'
      '  FLG_UPDATE_DATE = :FLG_UPDATE_DATE,'
      '  FLG_FURNITURE = :FLG_FURNITURE,'
      ''
      '  CREATED_DATE = :CREATED_DATE, '
      '  CREATED_BY = :CREATED_BY, '
      '  DELETED_DATE = :DELETED_DATE, '
      '  DELETED_BY = :DELETED_BY, '
      '  PARENTDOCID = :PARENTDOCID, '
      '  ACC$MASK = :"ACC$MASK", '
      '  DOCTYPEID = :DOCTYPEID,'
      ''
      '  RATEUSD = :RATEUSD,'
      '  CONTRACTID = :CONTRACTID'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      'SELECT'
      ' VW_TDB_DOCS.*,'
      ' IIF((CT=:DT),1,0) INCOMING_DOC,'
      
        ' IIF(EXISTS(SELECT GOODSID FROM TDB_JURNAL WHERE TDB_JURNAL.DOCI' +
        'D=VW_TDB_DOCS.DOCID),1,0) HAS_JURNAL_GOODS,'
      
        ' (SELECT CUSTOMER_TYPE_ID FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUS' +
        'TOMERID=VW_TDB_DOCS.CT) CUSTOMER_TYPE_ID,'
      
        ' iif (exists(select docid from tdb_docs_attachments da where (da' +
        '.docid=VW_TDB_DOCS.docid)),1,0) HasDoc_Attached,'
      
        ' COALESCE((SELECT pricecolumn FROM ts_cust_info WHERE customerid' +
        ' = VW_TDB_DOCS.CT),1) CUSTOMER_PRICE_COLUMN,'
      ' B.BANKNAME,'
      ' CA.BANKACCOUNT,'
      ' CA.ACCOUNTNAME,'
      ' CA.ACCOUNTNUMBER'
      'FROM'
      ' VW_TDB_DOCS'
      
        'LEFT JOIN TS_CUST_ACCOUNTS CA ON CA.CUSTOMERID = VW_TDB_DOCS.DT ' +
        'AND CA.ACCOUNTNUMBER = (SELECT DR.DT_CD FROM TDB_DOCS_RECHIZITE ' +
        'DR WHERE DR.DOCID = VW_TDB_DOCS.DOCID)'
      'LEFT JOIN TS_BANKS B ON B.BANKACCOUNT = CA.BANKACCOUNT'
      'WHERE'
      ' VW_TDB_DOCS.DOCID = :DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'select'
      ' d.*,'
      ' iif((ct=:dt),1,0) incoming_doc,'
      
        ' iif(exists(select goodsid from tdb_jurnal where tdb_jurnal.doci' +
        'd=d.docid),1,0) has_jurnal_goods,'
      
        ' (select customer_type_id from ts_customer where ts_customer.cus' +
        'tomerid=d.ct) customer_type_id,'
      
        ' iif (exists(select docid from tdb_docs_attachments da where (da' +
        '.docid=d.docid)),1,0) hasdoc_attached,'
      
        ' coalesce((select pricecolumn from ts_cust_info where customerid' +
        ' = d.ct),1) customer_price_column,'
      ' b.bankname,'
      ' ca.bankaccount,'
      ' ca.accountname,'
      ' ca.accountnumber,'
      ' dd.delivery_date'
      'from'
      ' vw_tdb_docs d'
      'left join ts_cust_accounts ca on ca.customerid = d.dt'
      
        'left join tdb_docs_rechizite dr on dr.docid = d.docid and dr.dt_' +
        'cd = ca.accountnumber'
      'left join ts_banks b on b.bankaccount = ca.bankaccount'
      'left join tdb_docs_delivery dd on dd.docid=d.docid'
      'where flg_del=0 and d.docid = :docid')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 250
    IndexFieldNames = 'DATA'
    Left = 608
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end>
  end
  object IBCQueryJurnal: TIBCQuery
    KeyFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_JURNAL'
      
        '  (DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLECT_ID' +
        ', GOODSCOMPLECT_NAME, '
      '   GOODSID, GOODS_NAME, GOODS_TYPE_ID, '
      
        '   UMID, UM_NAME, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY' +
        ', COST, '
      '   FLG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, :GOODSCOMPL' +
        'ECT_ID, :GOODSCOMPLECT_NAME, '
      '   :GOODSID, :GOODS_NAME, :GOODS_TYPE_ID, '
      
        '   :UMID, :UM_NAME, :QTY, :PRICE, :SUMA, :SUMAVAT, :WARRANTY, :S' +
        'TOCK_QTY, :COST, '
      '   :FLG_ACTIVE, :FLG_ACNT, :FLG_READY, :FLG_DELETE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_JURNAL'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_JURNAL'
      'SET'
      
        ' DOCID = :DOCID, DTDEP = :DTDEP, DTDEP_NAME = :DTDEP_NAME, CTDEP' +
        ' = :CTDEP, CTDEP_NAME = :CTDEP_NAME, '
      
        ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID, GOODSCOMPLECT_NAME = :GOO' +
        'DSCOMPLECT_NAME, '
      ' GOODSID = :GOODSID, GOODS_NAME = :GOODS_NAME, '
      
        ' GOODS_TYPE_ID = :GOODS_TYPE_ID, UMID = :UMID, UM_NAME = :UM_NAM' +
        'E, QTY = :QTY, '
      
        ' PRICE = :PRICE, SUMA = :SUMA, SUMAVAT = :SUMAVAT, WARRANTY = :W' +
        'ARRANTY, STOCK_QTY = :STOCK_QTY, '
      ' COST = :COST, '
      ''
      ' FLG_ACTIVE = :FLG_ACTIVE, '
      ' FLG_ACNT = :FLG_ACNT, '
      ' FLG_READY = :FLG_READY, '
      ' FLG_DELETE = :FLG_DELETE'
      ''
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' IIF(ACNT_PRICE<PRICE_ACNT_LOW_BOUND OR ACNT_PRICE>PRICE_ACNT_HI' +
        'GH_BOUND,1,0) FLG_ACNT_PRICE_OUT_OF_BOUNDS'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' DOCID = :DOCID AND '
      ' DTDEP = :DTDEP AND'
      ' CTDEP = :CTDEP AND'
      ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID AND'
      ' GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_JURNAL'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' IIF(ACNT_PRICE<PRICE_ACNT_LOW_BOUND OR ACNT_PRICE>PRICE_ACNT_HI' +
        'GH_BOUND,1,0) FLG_ACNT_PRICE_OUT_OF_BOUNDS'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceDocs
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    Left = 720
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 720
    Top = 24
  end
end
