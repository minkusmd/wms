object frmDocumentGeneralInfoDlg: TfrmDocumentGeneralInfoDlg
  Left = 0
  Top = 0
  Caption = 'Vizualizare document'
  ClientHeight = 697
  ClientWidth = 1184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1184
    Height = 225
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = -4
    ExplicitWidth = 1002
    object cxLabel5: TLabel
      Left = 12
      Top = 21
      Width = 73
      Height = 13
      Caption = 'Data document'
      Transparent = True
    end
    object cxLabel1: TLabel
      Left = 12
      Top = 48
      Width = 55
      Height = 13
      Caption = 'Organizatie'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 709
      Top = 48
      Width = 27
      Height = 13
      Caption = 'Client'
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 21
      Top = 182
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valuta'
      Transparent = True
    end
    object cxLabel8: TLabel
      Left = 709
      Top = 146
      Width = 40
      Height = 13
      Caption = 'Mentiuni'
      Transparent = True
    end
    object cxLabel6: TLabel
      Left = 12
      Top = 73
      Width = 36
      Height = 13
      Caption = 'Depozit'
      Transparent = True
    end
    object Label1: TLabel
      Left = 210
      Top = 182
      Width = 86
      Height = 13
      Caption = 'Rata Doc / Rata $'
      Transparent = True
    end
    object lbContractTitle: TLabel
      Left = 16
      Top = 106
      Width = 42
      Height = 13
      Caption = 'Contract'
      Transparent = True
    end
    object Label2: TLabel
      Left = 395
      Top = 182
      Width = 10
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = '/'
      Transparent = True
    end
    object Label3: TLabel
      Left = 12
      Top = 142
      Width = 40
      Height = 13
      Caption = 'Analitica'
      Transparent = True
    end
    object Label4: TLabel
      Left = 709
      Top = 77
      Width = 56
      Height = 13
      Caption = 'Analitica SC'
      Transparent = True
    end
    object ceRATE: TcxDBCalcEdit
      Left = 306
      Top = 179
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 12
      Width = 87
    end
    object lcbDTSC: TcxDBLookupComboBox
      Left = 306
      Top = 74
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      DataBinding.DataField = 'DTSC'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentShowHint = False
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceAnalitica
      ShowHint = True
      TabOrder = 5
      Width = 194
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 771
      Top = 148
      DataBinding.DataField = 'COMMENTS'
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 4
      TabOrder = 10
      Width = 398
    end
    object deDATA: TcxDBDateEdit
      Left = 108
      Top = 17
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = IBCDataSourceDocs
      Properties.DateButtons = [btnNow]
      Properties.ImmediatePost = True
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      TabOrder = 0
      Width = 125
    end
    object cbFLG_ACNT: TcxDBCheckBox
      Left = 1038
      Top = 21
      Caption = 'Reflecta in contabilitate'
      DataBinding.DataField = 'FLG_ACNT'
      DataBinding.DataSource = IBCDataSourceDocs
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
    end
    object lcbDTDEP: TcxDBLookupComboBox
      Left = 112
      Top = 74
      DataBinding.DataField = 'DTDEP'
      DataBinding.DataSource = IBCDataSourceDocs
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
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = dmDB.IBCDataSourceStocks
      TabOrder = 4
      Width = 188
    end
    object beDT_NAME: TcxButtonEdit
      Left = 108
      Top = 44
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
      TabOrder = 2
      Text = 'beDT_NAME'
      Width = 388
    end
    object beCT_NAME: TcxButtonEdit
      Left = 771
      Top = 44
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
      TabOrder = 3
      Text = 'beCT_NAME'
      Width = 398
    end
    object ceRATEUSD: TcxDBCalcEdit
      Left = 411
      Top = 179
      DataBinding.DataField = 'RATEUSD'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 13
      Width = 89
    end
    object lcbAnalytics: TcxDBLookupComboBox
      Left = 108
      Top = 139
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      DataBinding.DataField = 'SC2'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentShowHint = False
      Properties.DropDownAutoSize = True
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
      ShowHint = True
      TabOrder = 8
      Width = 245
    end
    object beContract: TcxButtonEdit
      Left = 106
      Top = 101
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
      Properties.ClearKey = 46
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      TabOrder = 7
      Width = 394
    end
    object lcbCURRENCY: TcxDBLookupComboBox
      Left = 108
      Top = 179
      DataBinding.DataField = 'CURRENCYID'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
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
      TabOrder = 11
      Width = 73
    end
    object cxDBLookupComboBox1: TcxDBLookupComboBox
      Left = 771
      Top = 74
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      DataBinding.DataField = 'CTSC'
      DataBinding.DataSource = IBCDataSourceDocs
      ParentShowHint = False
      Properties.GridMode = True
      Properties.ImmediateDropDownWhenActivated = True
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceSYSSList
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = [evoRaiseException, evoShowErrorIcon]
      ShowHint = True
      TabOrder = 6
      Visible = False
      Width = 182
    end
    object lcbDocumentState: TcxDBLookupComboBox
      Left = 359
      Top = 139
      DataBinding.DataField = 'STATEID'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DropDownWidth = 300
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
      Properties.ListSource = dmDB.IBCDataSourceDocTypeStates
      TabOrder = 9
      Width = 141
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 656
    Width = 1184
    Height = 41
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    ExplicitWidth = 1000
    object cxButton1: TcxButton
      Left = 533
      Top = 2
      Width = 90
      Height = 29
      Caption = 'Inchide'
      Default = True
      ModalResult = 8
      TabOrder = 0
    end
  end
  object pnlJurnal: TPanel
    Left = 0
    Top = 225
    Width = 1184
    Height = 431
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 217
    ExplicitWidth = 1002
    ExplicitHeight = 439
    object cxGrid1: TcxGrid
      Left = 0
      Top = 0
      Width = 1180
      Height = 427
      Align = alClient
      TabOrder = 0
      ExplicitLeft = -2
      ExplicitTop = 2
      ExplicitWidth = 998
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceJurnal
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object cxGrid1DBTableView1DTDEP_NAME: TcxGridDBColumn
          Caption = 'Depozit'
          DataBinding.FieldName = 'DTDEP_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 200
        end
        object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
          Caption = 'Cod produs'
          DataBinding.FieldName = 'GOODSID'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1GOODS_NAME: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'GOODS_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 537
        end
        object cxGrid1DBTableView1UM_NAME: TcxGridDBColumn
          Caption = 'UM'
          DataBinding.FieldName = 'UM_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 48
        end
        object cxGrid1DBTableView1QTY: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          HeaderAlignmentHorz = taCenter
          Width = 48
        end
        object cxGrid1DBTableView1PRICE: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1SUMAVAT: TcxGridDBColumn
          Caption = 'Suma TVA'
          DataBinding.FieldName = 'SUMAVAT'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1STOCK_QTY: TcxGridDBColumn
          Caption = '...'
          DataBinding.FieldName = 'STOCK_QTY'
          HeaderAlignmentHorz = taCenter
          Width = 24
        end
        object cxGrid1DBTableView1FLG_ACTIVE: TcxGridDBColumn
          Caption = 'A'
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taRightJustify
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 24
        end
        object cxGrid1DBTableView1FLG_FORCED: TcxGridDBColumn
          Caption = 'F'
          DataBinding.FieldName = 'FLG_FORCED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taRightJustify
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 24
        end
        object cxGrid1DBTableView1FLG_ACNT: TcxGridDBColumn
          Caption = 'Cntb'
          DataBinding.FieldName = 'FLG_ACNT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taRightJustify
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 32
        end
        object cxGrid1DBTableView1FLG_READY: TcxGridDBColumn
          Caption = 'R'
          DataBinding.FieldName = 'FLG_READY'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taRightJustify
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 24
        end
        object cxGrid1DBTableView1GOODS_NAMEACNT: TcxGridDBColumn
          Caption = 'Denumire contab'
          DataBinding.FieldName = 'GOODS_NAMEACNT'
          HeaderAlignmentHorz = taCenter
          Width = 200
        end
        object cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Creat de'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 100
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 304
    Top = 40
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 416
    Top = 40
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
    Active = True
    Left = 416
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCQueryDocs: TIBCQuery
    KeyFields = 'DOCID'
    KeyGenerator = 'SQ_TDB_DOCS_DOCID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS'
      '  (DOCID, DOCNO, DATA, '
      
        '   DT, DT_NAME, CT, CT_NAME, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAM' +
        'E, '
      '   DTSC, SC2,'
      '   SUMA, VAT, CURRENCYID, DISCOUNT, RATE, '
      ''
      '   FLG_SHIP, FLG_ACNT, FLG_DEL, FLG_PROTECTED,'
      '   FLG_SEND, FLG_RECEIVE, FLG_PAID, FLG_INVOICE, '
      
        '   FLG_GOODS_ARRIVAL, FLG_READY, FLG_CHILD, FLG_NEW_CEC, FLG_SAL' +
        'ARY, FLG_UPDATE_DATE,'
      '   FLG_FURNITURE, '
      ''
      '   CREATED_DATE, CREATED_BY, DELETED_DATE, DELETED_BY, '
      '   PARENTDOCID, ACC$MASK, DOCTYPEID,'
      '   RATEUSD,'
      '   CONTRACTID,'
      '   CTSC,'
      '   stateid '
      '  )'
      'VALUES'
      
        '  (:DOCID, :DOCNO, :DATA, :DT, :DT_NAME, :CT, :CT_NAME, :DTDEP, ' +
        ':DTDEP_NAME, :CTDEP, :CTDEP_NAME, '
      '   :DTSC, :SC2,'
      '   :SUMA, :VAT, :CURRENCYID, :DISCOUNT, :RATE, '
      ''
      '   :FLG_SHIP, :FLG_ACNT, :FLG_DEL, :FLG_PROTECTED,'
      '   :FLG_SEND, :FLG_RECEIVE, :FLG_PAID, :FLG_INVOICE, '
      
        '   :FLG_GOODS_ARRIVAL, :FLG_READY, :FLG_CHILD, :FLG_NEW_CEC, :FL' +
        'G_SALARY, :FLG_UPDATE_DATE,'
      '   :FLG_FURNITURE,'
      ' '
      '   :CREATED_DATE, :CREATED_BY, :DELETED_DATE, :DELETED_BY, '
      '   :PARENTDOCID, :"ACC$MASK", :DOCTYPEID,'
      '   :RATEUSD,'
      '   :CONTRACTID,'
      '   :CTSC, :STATEID'
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
      '  CONTRACTID = :CONTRACTID,'
      '  STATEID = :STATEID'
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
      ' CA.ACCOUNTNUMBER,'
      ' dd.delivery_date'
      ''
      'FROM'
      ' VW_TDB_DOCS'
      
        'LEFT JOIN TS_CUST_ACCOUNTS CA ON CA.CUSTOMERID = VW_TDB_DOCS.DT ' +
        'AND CA.ACCOUNTNUMBER = (SELECT DR.DT_CD FROM TDB_DOCS_RECHIZITE ' +
        'DR WHERE DR.DOCID = VW_TDB_DOCS.DOCID)'
      'LEFT JOIN TS_BANKS B ON B.BANKACCOUNT = CA.BANKACCOUNT'
      'LEFT JOIN tdb_docs_delivery dd on dd.docid=vw_tdb_docs.docid'
      'where DOCID = :DOCID')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 250
    IndexFieldNames = 'DATA'
    Left = 304
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
end
