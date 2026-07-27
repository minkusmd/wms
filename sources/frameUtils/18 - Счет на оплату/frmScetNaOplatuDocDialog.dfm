object frmScetNaOplatuDocDlg: TfrmScetNaOplatuDocDlg
  Left = 0
  Top = 0
  ActiveControl = edDT_NAME
  BorderStyle = bsDialog
  Caption = 'Proforma'
  ClientHeight = 602
  ClientWidth = 657
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  DesignSize = (
    657
    602)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 657
    Height = 64
    Title = 'Proforma'
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
    Height = 474
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
    ExplicitHeight = 421
    object Bevel1: TBevel
      Left = 12
      Top = 56
      Width = 613
      Height = 4
      Shape = bsTopLine
    end
    object cxLabel1: TLabel
      Left = 13
      Top = 78
      Width = 63
      Height = 15
      Caption = 'Organizatia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 10
      Top = 174
      Width = 41
      Height = 15
      Caption = 'Platitor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 12
      Top = 307
      Width = 32
      Height = 15
      Caption = 'Valuta'
      Transparent = True
    end
    object cxLabel8: TLabel
      Left = 12
      Top = 359
      Width = 48
      Height = 15
      Caption = 'Mentiuni'
      Transparent = True
    end
    object cxLabel5: TLabel
      Left = 12
      Top = 19
      Width = 82
      Height = 15
      Caption = 'Data document'
      Transparent = True
    end
    object cxLabel6: TLabel
      Left = 13
      Top = 137
      Width = 40
      Height = 15
      Caption = 'Depozit'
      Transparent = True
    end
    object cxLabel11: TLabel
      Left = 13
      Top = 109
      Width = 27
      Height = 15
      Caption = 'IBAN'
      Transparent = True
    end
    object cxLabel10: TLabel
      Left = 11
      Top = 204
      Width = 27
      Height = 15
      Caption = 'IBAN'
      Transparent = True
    end
    object cxLabel13: TLabel
      Left = 291
      Top = 307
      Width = 49
      Height = 15
      Caption = 'Rata doc.'
      Transparent = True
    end
    object cxLabel12: TLabel
      Left = 12
      Top = 334
      Width = 30
      Height = 15
      Caption = 'Suma'
      Transparent = True
    end
    object Label1: TLabel
      Left = 449
      Top = 307
      Width = 22
      Height = 15
      Caption = 'USD'
      Transparent = True
    end
    object lbContractTitle: TLabel
      Left = 10
      Top = 225
      Width = 46
      Height = 15
      Caption = 'Contract'
      Transparent = True
    end
    object lbContractInfo: TLabel
      Left = 403
      Top = 193
      Width = 210
      Height = 30
      Caption = 'Atentie, va fi aplicata grila de preturi din contract'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object lcbDTSC: TcxDBLookupComboBox
      Left = 413
      Top = 75
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
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
      TabOrder = 2
      Width = 212
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 70
      Top = 361
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocProps
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 6
      TabOrder = 11
      OnClick = mmCOMMENTSClick
      OnEnter = mmCOMMENTSClick
      Width = 552
    end
    object deDATA: TcxDBDateEdit
      Left = 108
      Top = 16
      TabStop = False
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DateButtons = [btnNow]
      Properties.ImmediatePost = True
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      TabOrder = 0
      Width = 133
    end
    object cbFLG_ACNT: TcxDBCheckBox
      Left = 12
      Top = 262
      Caption = 'Contab'
      DataBinding.DataField = 'FLG_ACNT'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Enabled = False
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Properties.OnEditValueChanged = lcbCURRENCYPropertiesEditValueChanged
      TabOrder = 9
    end
    object lcbDT_CD: TcxDBLookupComboBox
      Left = 108
      Top = 105
      Hint = #1056#1077#1082#1074#1080#1079#1080#1090#1099' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
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
      TabOrder = 4
      Width = 291
    end
    object lcbCT_CD: TcxDBLookupComboBox
      Left = 107
      Top = 200
      Hint = #1056#1077#1082#1074#1080#1079#1080#1090#1099' '#1087#1083#1072#1090#1077#1083#1100#1097#1080#1082#1072
      DataBinding.DataField = 'CT_CD'
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
          Width = 120
          FieldName = 'ACCOUNTNUMBER'
        end
        item
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1095#1077#1090#1072
          Width = 50
          FieldName = 'ACCOUNTNAME'
        end
        item
          Caption = #1057#1095#1077#1090' '#1073#1072#1085#1082#1072
          Width = 80
          FieldName = 'BANKACCOUNT'
        end>
      Properties.ListSource = IBCDataSourceCT_Accounts
      Properties.OnInitPopup = lcbCT_AccountPropertiesInitPopup
      ShowHint = True
      TabOrder = 7
      Width = 291
    end
    object edDT_NAME: TcxDBTextEdit
      Left = 108
      Top = 76
      TabStop = False
      DataBinding.DataField = 'DT_NAME'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ReadOnly = True
      TabOrder = 3
      Width = 291
    end
    object edDTDEP_NAME: TcxDBTextEdit
      Left = 108
      Top = 134
      TabStop = False
      DataBinding.DataField = 'DTDEP_NAME'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ReadOnly = True
      TabOrder = 5
      Width = 212
    end
    object edRATE: TcxDBTextEdit
      Left = 350
      Top = 304
      TabStop = False
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Enabled = False
      Properties.ReadOnly = True
      TabOrder = 12
      Width = 81
    end
    object edSUMA: TcxDBCurrencyEdit
      Left = 72
      Top = 330
      DataBinding.DataField = 'SUMA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Enabled = False
      Properties.DisplayFormat = '#,##0.00'
      Properties.ReadOnly = True
      TabOrder = 14
      Width = 208
    end
    object beCT_NAME: TcxButtonEdit
      Left = 106
      Top = 170
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
      TabOrder = 6
      Text = 'beCT_NAME'
      Width = 291
    end
    object ceRATEUSD: TcxDBCalcEdit
      Left = 477
      Top = 304
      DataBinding.DataField = 'RATEUSD'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 13
      Width = 81
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
    object beContract: TcxButtonEdit
      Left = 106
      Top = 229
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
      TabOrder = 8
      Width = 517
    end
    object lcbCURRENCY: TcxDBLookupComboBox
      Left = 72
      Top = 303
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
      TabOrder = 10
      Width = 208
    end
  end
  object btnOk: TcxButton
    Left = 443
    Top = 557
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitTop = 504
  end
  object btnCancel: TcxButton
    Left = 547
    Top = 557
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
    ExplicitTop = 504
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
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    Left = 312
    Top = 52
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocProps: TIBCDataSource
    DataSet = IBCQueryDocProps
    Left = 312
    Top = 4
  end
  object IBCDataSourceRechizite: TIBCDataSource
    DataSet = IBCQueryRechizite
    Left = 464
  end
  object IBCQueryRechizite: TIBCQuery
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
    Options.BooleanDomainFields = True
    Left = 464
    Top = 44
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDT_Accounts: TIBCDataSource
    DataSet = IBCQueryDT_Accounts
    Left = 232
    Top = 272
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
    Left = 232
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceCT_Accounts: TIBCDataSource
    DataSet = IBCQueryCT_Accounts
    Left = 388
    Top = 272
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
    Left = 388
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end>
  end
end
