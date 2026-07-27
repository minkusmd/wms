object frmOstatkiTovaraDocDlg: TfrmOstatkiTovaraDocDlg
  Left = 0
  Top = 0
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  ActiveControl = lcbDTDEP
  BorderStyle = bsDialog
  Caption = #1054#1089#1090#1072#1090#1082#1080' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 575
  ClientWidth = 844
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 120
  DesignSize = (
    844
    575)
  TextHeight = 20
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 844
    Height = 80
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Title = #1054#1089#1090#1072#1090#1082#1080' '#1090#1086#1074#1072#1088#1072
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
    Width = 824
    Height = 403
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
    object Bevel1: TBevel
      Left = 15
      Top = 70
      Width = 780
      Height = 5
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Shape = bsTopLine
    end
    object cxLabel1: TLabel
      Left = 15
      Top = 99
      Width = 93
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 330
      Top = 206
      Width = 98
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1042#1072#1083#1102#1090#1072' '#1080' '#1082#1091#1088#1089
      Transparent = True
    end
    object cxLabel8: TLabel
      Left = 15
      Top = 310
      Width = 91
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1055#1088#1080#1083#1086#1078#1077#1085#1080#1077
      Transparent = True
    end
    object cxLabel7: TLabel
      Left = 15
      Top = 274
      Width = 78
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077
      Transparent = True
    end
    object cxLabel6: TLabel
      Left = 15
      Top = 136
      Width = 61
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1053#1072' '#1089#1082#1083#1072#1076
      Transparent = True
    end
    object cxLabel5: TLabel
      Left = 15
      Top = 26
      Width = 109
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Transparent = True
    end
    object ceRATE: TcxDBCalcEdit
      Left = 654
      Top = 203
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 7
      Width = 141
    end
    object lcbDTSC: TcxDBLookupComboBox
      Left = 530
      Top = 94
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DTSC'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentShowHint = False
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceAnalitica
      ShowHint = True
      TabOrder = 3
      Width = 265
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 135
      Top = 306
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocProps
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      TabOrder = 9
      OnClick = mmCOMMENTSClick
      Width = 660
    end
    object edINBAZA: TcxDBTextEdit
      Left = 135
      Top = 270
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'INBAZA'
      DataBinding.DataSource = IBCDataSourceDocProps
      TabOrder = 8
      Width = 660
    end
    object deDATA: TcxDBDateEdit
      Left = 135
      Top = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabStop = False
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DateButtons = [btnNow]
      Properties.ImmediatePost = True
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      TabOrder = 1
      Width = 265
    end
    object cbFLG_ACNT: TcxDBCheckBox
      Left = 15
      Top = 201
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080
      DataBinding.DataField = 'FLG_ACNT'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Properties.OnEditValueChanged = lcbCURRENCYPropertiesEditValueChanged
      TabOrder = 5
    end
    object lcbDTDEP: TcxDBLookupComboBox
      Left = 135
      Top = 131
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DTDEP'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'STOCKID'
      Properties.ListColumns = <
        item
          FieldName = 'STOCKID'
        end
        item
          FieldName = 'TITLE'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceStocks
      TabOrder = 4
      Width = 265
    end
    object beDT_NAME: TcxButtonEdit
      Left = 135
      Top = 93
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      TabOrder = 2
      Text = 'beDT_NAME'
      Width = 371
    end
    object lcbAnalytics: TcxDBLookupComboBox
      Left = 436
      Top = 21
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'SC2'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
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
      ShowHint = True
      TabOrder = 0
      Width = 359
    end
    object lcbCURRENCY: TcxDBLookupComboBox
      Left = 436
      Top = 201
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      Properties.OnEditValueChanged = lcbCURRENCYPropertiesEditValueChanged
      TabOrder = 6
      Width = 194
    end
  end
  object btnOk: TcxButton
    Left = 574
    Top = 515
    Width = 112
    Height = 36
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    OptionsImage.Spacing = 5
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 704
    Top = 515
    Width = 112
    Height = 36
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    OptionsImage.Spacing = 5
    TabOrder = 3
  end
  object IBCQueryDocProps: TIBCQuery
    UpdatingTable = 'TDB_DOCS_PROPS'
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
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    Left = 340
    Top = 408
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocProps: TIBCDataSource
    DataSet = IBCQueryDocProps
    Left = 244
    Top = 408
  end
end
