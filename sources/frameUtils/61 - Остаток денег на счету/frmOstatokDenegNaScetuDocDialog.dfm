object frmOstatokDenegNaScetuDocDlg: TfrmOstatokDenegNaScetuDocDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054#1089#1090#1072#1090#1086#1082' '#1076#1077#1085#1077#1075' '#1085#1072' '#1089#1095#1077#1090#1091
  ClientHeight = 525
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    667
    525)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 667
    Height = 64
    Title = #1054#1089#1090#1072#1090#1086#1082' '#1076#1077#1085#1077#1075' '#1085#1072' '#1089#1095#1077#1090#1091
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
    Left = 458
    Top = 480
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 562
    Top = 480
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 651
    Height = 393
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    ExplicitLeft = 3
    ExplicitTop = 75
    object cxLabel5: TLabel
      Left = 16
      Top = 21
      Width = 86
      Height = 15
      Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Transparent = True
    end
    object Bevel1: TBevel
      Left = 16
      Top = 56
      Width = 614
      Height = 13
      Shape = bsTopLine
    end
    object cxLabel1: TLabel
      Left = 16
      Top = 79
      Width = 72
      Height = 15
      Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 16
      Top = 109
      Width = 87
      Height = 15
      Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 16
      Top = 176
      Width = 41
      Height = 15
      Caption = #1042#1072#1083#1102#1090#1072
      Transparent = True
    end
    object cxLabel4: TLabel
      Left = 16
      Top = 234
      Width = 26
      Height = 15
      Caption = #1050#1091#1088#1089
      Transparent = True
    end
    object cxLabel6: TLabel
      Left = 16
      Top = 204
      Width = 38
      Height = 15
      Caption = #1057#1091#1084#1084#1072
      Transparent = True
    end
    object cxLabel8: TLabel
      Left = 16
      Top = 285
      Width = 77
      Height = 15
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Transparent = True
    end
    object ceRATE: TcxDBCalcEdit
      Left = 112
      Top = 232
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DisplayFormat = '0.0000'
      Properties.ImmediatePost = True
      TabOrder = 8
      Width = 137
    end
    object ceSUMA: TcxDBCalcEdit
      Left = 112
      Top = 203
      DataBinding.DataField = 'SUMA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.ImmediatePost = True
      TabOrder = 6
      Width = 137
    end
    object lcbDTSC: TcxDBLookupComboBox
      Left = 418
      Top = 75
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
      TabOrder = 4
      Width = 212
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 112
      Top = 282
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocProps
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 5
      TabOrder = 7
      OnClick = mmCOMMENTSClick
      OnEnter = mmCOMMENTSClick
      Width = 518
    end
    object lcbDT_CD: TcxDBLookupComboBox
      Left = 112
      Top = 105
      Hint = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      DataBinding.DataField = 'DT_CD'
      DataBinding.DataSource = IBCDataSourceRechizite
      ParentShowHint = False
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
      Properties.OnInitPopup = lcbDT_AccountPropertiesInitPopup
      ShowHint = True
      TabOrder = 3
      Width = 291
    end
    object deDATA: TcxDBDateEdit
      Left = 112
      Top = 18
      TabStop = False
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DateButtons = [btnNow]
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      TabOrder = 0
      Width = 245
    end
    object beDT_NAME: TcxButtonEdit
      Left = 112
      Top = 75
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
    object lcbAnalytics: TcxDBLookupComboBox
      Left = 418
      Top = 17
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      DataBinding.DataField = 'SC2'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentShowHint = False
      Properties.DropDownAutoSize = True
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 600
      Properties.KeyFieldNames = 'ANALITICAID'
      Properties.ListColumns = <
        item
          FieldName = 'ANALITICAID'
        end
        item
          FieldName = 'TITLE'
        end
        item
          FieldName = 'PARENT_TITLE'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceAnalytics
      ShowHint = True
      TabOrder = 1
      Width = 212
    end
    object cbFLG_ACNT: TcxDBCheckBox
      Left = 16
      Top = 134
      Caption = #1055#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
      DataBinding.DataField = 'FLG_ACNT'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Properties.OnEditValueChanged = cbFLG_ACNTPropertiesEditValueChanged
      TabOrder = 5
    end
    object lcbCURRENCY: TcxDBLookupComboBox
      Left = 112
      Top = 174
      DataBinding.DataField = 'CURRENCYID'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          FieldName = 'SHORTNAME'
        end>
      Properties.ListSource = dmDB.IBCDataSourceCurrency
      TabOrder = 9
      Width = 137
    end
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
    Left = 420
    Top = 52
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceDT_Accounts: TIBCDataSource
    DataSet = IBCQueryDT_Accounts
    Left = 420
    Top = 12
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
    Left = 272
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceRechizite: TIBCDataSource
    DataSet = IBCQueryRechizite
    Left = 272
    Top = 8
  end
  object IBCDataSourceDocProps: TIBCDataSource
    DataSet = IBCQueryDocProps
    Left = 524
    Top = 332
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
      ' DOCID = :DOCID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' DOCID,'
      ' INBAZA,'
      ' COMMENTS'
      'FROM'
      ' TDB_DOCS_PROPS')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    Left = 524
    Top = 380
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
end
