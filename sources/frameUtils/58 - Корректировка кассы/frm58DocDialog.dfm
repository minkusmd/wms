object frm58DocDlg: Tfrm58DocDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1082#1072#1089#1089#1099
  ClientHeight = 492
  ClientWidth = 665
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
    665
    492)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 665
    Height = 64
    Title = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1082#1072#1089#1089#1099
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
  object btnOk: TButton
    Left = 447
    Top = 446
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 551
    Top = 446
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 75
    Width = 649
    Height = 357
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object lbFirma: TLabel
      Left = 12
      Top = 83
      Width = 38
      Height = 15
      Caption = #1060#1080#1088#1084#1072
    end
    object Label6: TLabel
      Left = 509
      Top = 157
      Width = 38
      Height = 15
      Caption = #1057#1091#1084#1084#1072
    end
    object Label8: TLabel
      Left = 253
      Top = 157
      Width = 41
      Height = 15
      Caption = #1042#1072#1083#1102#1090#1072
    end
    object Label9: TLabel
      Left = 397
      Top = 157
      Width = 26
      Height = 15
      Caption = #1050#1091#1088#1089
    end
    object lbDocComments2: TLabel
      Left = 16
      Top = 253
      Width = 68
      Height = 15
      Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080
    end
    object Label1: TLabel
      Left = 12
      Top = 20
      Width = 86
      Height = 15
      Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object Bevel1: TBevel
      Left = 12
      Top = 60
      Width = 613
      Height = 5
      Shape = bsTopLine
    end
    object Label2: TLabel
      Left = 340
      Top = 206
      Width = 51
      Height = 15
      Caption = #1050#1091#1088#1089' USD'
      Transparent = True
    end
    object edSuma: TcxDBCalcEdit
      Left = 509
      Top = 174
      DataBinding.DataField = 'SUMA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DisplayFormat = '#,##0.00'
      Properties.Precision = 15
      TabOrder = 7
      Width = 116
    end
    object edRate: TcxDBCalcEdit
      Left = 397
      Top = 174
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DisplayFormat = '#,##0.0000'
      Properties.Precision = 4
      TabOrder = 5
      Width = 97
    end
    object cbFLG_ACNT: TcxDBCheckBox
      Left = 12
      Top = 174
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080
      DataBinding.DataField = 'FLG_ACNT'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Properties.OnEditValueChanged = cbFLGAccPropertiesEditValueChanged
      TabOrder = 3
      Transparent = True
    end
    object mmDocCOMMENTS: TcxDBMemo
      Left = 100
      Top = 253
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocProps
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 5
      TabOrder = 4
      OnClick = mmDocCOMMENTSClick
      Width = 525
    end
    object deDATA: TcxDBDateEdit
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
    object ceRATEUSD: TcxDBCalcEdit
      Left = 397
      Top = 203
      DataBinding.DataField = 'RATEUSD'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 6
      Width = 97
    end
    object lcbAnalytics: TcxDBLookupComboBox
      Left = 342
      Top = 17
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
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
      TabOrder = 1
      Width = 283
    end
    object lcbCURRENCY: TcxDBLookupComboBox
      Left = 253
      Top = 177
      DataBinding.DataField = 'CURRENCYID'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          FieldName = 'SHORTNAME'
        end>
      Properties.ListSource = dmDB.IBCDataSourceCurrency
      TabOrder = 8
      Width = 93
    end
    object lcbDTSC: TcxDBLookupComboBox
      Left = 413
      Top = 80
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      DataBinding.DataField = 'DTSC'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentShowHint = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceAnalitica
      ShowHint = True
      TabOrder = 9
      Width = 212
    end
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
    Top = 344
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
end
