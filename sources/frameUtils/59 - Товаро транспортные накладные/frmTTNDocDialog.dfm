object frmTTNDocDlg: TfrmTTNDocDlg
  Left = 0
  Top = 0
  ActiveControl = beCT_NAME
  BorderStyle = bsDialog
  Caption = #1058#1086#1074#1072#1088#1086'-'#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
  ClientHeight = 544
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    660
    544)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 660
    Height = 64
    Title = #1058#1086#1074#1072#1088#1086'-'#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
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
    Width = 644
    Height = 410
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
    object Bevel1: TBevel
      Left = 12
      Top = 56
      Width = 612
      Height = 4
      Shape = bsTopLine
    end
    object cxLabel1: TLabel
      Left = 12
      Top = 79
      Width = 77
      Height = 15
      Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 175
      Width = 68
      Height = 15
      Caption = #1055#1086#1083#1091#1095#1072#1090#1077#1083#1100
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
      Top = 256
      Width = 79
      Height = 15
      Caption = #1042#1072#1083#1102#1090#1072' '#1080' '#1082#1091#1088#1089
      Transparent = True
    end
    object cxLabel8: TLabel
      Left = 12
      Top = 305
      Width = 77
      Height = 15
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Transparent = True
    end
    object cxLabel6: TLabel
      Left = 12
      Top = 137
      Width = 33
      Height = 15
      Caption = #1057#1082#1083#1072#1076
      Transparent = True
    end
    object cxLabel11: TLabel
      Left = 12
      Top = 108
      Width = 58
      Height = 15
      Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099
      Transparent = True
    end
    object cxLabel10: TLabel
      Left = 12
      Top = 205
      Width = 58
      Height = 15
      Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099
      Transparent = True
    end
    object cxLabel5: TLabel
      Left = 12
      Top = 21
      Width = 86
      Height = 15
      Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Transparent = True
    end
    object Label1: TLabel
      Left = 454
      Top = 256
      Width = 51
      Height = 15
      Caption = #1050#1091#1088#1089' USD'
      Transparent = True
    end
    object lcbDTSC: TcxDBLookupComboBox
      Left = 412
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
      TabOrder = 3
      Width = 212
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 108
      Top = 302
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocProps
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 5
      TabOrder = 10
      OnClick = mmCOMMENTSClick
      OnEnter = mmCOMMENTSClick
      Width = 516
    end
    object deDATA: TcxDBDateEdit
      Left = 108
      Top = 18
      TabStop = False
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DateButtons = [btnNow]
      Properties.ImmediatePost = True
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      TabOrder = 0
      Width = 212
    end
    object lcbDT_Account: TcxDBLookupComboBox
      Left = 108
      Top = 105
      DataBinding.DataField = 'DT_CD'
      DataBinding.DataSource = IBCDataSourceRechizite
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
      TabOrder = 4
      Width = 212
    end
    object lcbCT_Account: TcxDBLookupComboBox
      Left = 108
      Top = 201
      DataBinding.DataField = 'CT_CD'
      DataBinding.DataSource = IBCDataSourceRechizite
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
      Properties.OnInitPopup = lcbCT_AccountPropertiesInitPopup
      TabOrder = 7
      Width = 212
    end
    object ceRATE: TcxDBCalcEdit
      Left = 280
      Top = 253
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 8
      Width = 105
    end
    object beDT_NAME: TcxButtonEdit
      Left = 108
      Top = 75
      Properties.Buttons = <
        item
          Default = True
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000120B0000120B0000000100000000000000000000FFFF
            FF00FF00FF00B78E6B00AB7F56009E6E3E009D703F009C724000A8855900B296
            6F00C1AC8C00C5B39500A58D5E00B09A7000967D4600B9A88200A4957300AA98
            6A00BCB18D0092844900ADA1740091884A009F985F00ABA57600B6B18800948F
            55009A977700B1AE8A00979357008F8C4D00BAB99100A9AA78009A9D7B008C93
            4F00A6AB7600757C4300A6AE7A00B8BE9400B8C09500979E7A008A9A52007180
            430089A05400B8C6980098A57D00B6C59600A4B97D00B1C58D0087A7550099B5
            6D009EB97500A4BD7E0096A67C00B6C9970088AA560090B0630092B2660098AA
            7F00A4C17E00B5CD980086B057008DB4610086B5580000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000020202022B24
            19020202020202020202023E3D3831321529231D130C02020202023E33333A3A
            1534393B3B2F08020202023E2E3333331334393B3B3B07020202023E2E242E33
            1334393B3B3B07020202023E1F2E242E13342C3B3B3B06020202023E1F1F242E
            0E342C2D2D3B06020202023E171F1F2E0E272C2D2D3506020202023E14171F18
            0E272C2D2D2D06020202023C1414171E0E27202D2D2D06020202023C090D141E
            07272025262D06020202023C09090D0B0E1A2025252606020202023C0309090B
            07202025252506020202023C03030A0F07201B1E252505020202023C16221C11
            1012121E1E120402020202373736302A28211513070802020202}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beDT_NAMEPropertiesButtonClick
      TabOrder = 2
      Text = 'beDT_NAME'
      Width = 291
    end
    object lcbDTDEP: TcxDBLookupComboBox
      Left = 108
      Top = 134
      DataBinding.DataField = 'DTDEP'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
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
      TabOrder = 5
      Width = 212
    end
    object beCT_NAME: TcxButtonEdit
      Left = 108
      Top = 171
      Properties.Buttons = <
        item
          Default = True
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000120B0000120B0000000100000000000000000000FFFF
            FF00FF00FF00B78E6B00AB7F56009E6E3E009D703F009C724000A8855900B296
            6F00C1AC8C00C5B39500A58D5E00B09A7000967D4600B9A88200A4957300AA98
            6A00BCB18D0092844900ADA1740091884A009F985F00ABA57600B6B18800948F
            55009A977700B1AE8A00979357008F8C4D00BAB99100A9AA78009A9D7B008C93
            4F00A6AB7600757C4300A6AE7A00B8BE9400B8C09500979E7A008A9A52007180
            430089A05400B8C6980098A57D00B6C59600A4B97D00B1C58D0087A7550099B5
            6D009EB97500A4BD7E0096A67C00B6C9970088AA560090B0630092B2660098AA
            7F00A4C17E00B5CD980086B057008DB4610086B5580000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000020202022B24
            19020202020202020202023E3D3831321529231D130C02020202023E33333A3A
            1534393B3B2F08020202023E2E3333331334393B3B3B07020202023E2E242E33
            1334393B3B3B07020202023E1F2E242E13342C3B3B3B06020202023E1F1F242E
            0E342C2D2D3B06020202023E171F1F2E0E272C2D2D3506020202023E14171F18
            0E272C2D2D2D06020202023C1414171E0E27202D2D2D06020202023C090D141E
            07272025262D06020202023C09090D0B0E1A2025252606020202023C0309090B
            07202025252506020202023C03030A0F07201B1E252505020202023C16221C11
            1012121E1E120402020202373736302A28211513070802020202}
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
      Left = 511
      Top = 253
      DataBinding.DataField = 'RATEUSD'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 9
      Width = 113
    end
    object lcbAnalytics: TcxDBLookupComboBox
      Left = 341
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
      Left = 108
      Top = 252
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
      TabOrder = 11
      Width = 158
    end
  end
  object btnOk: TButton
    Left = 446
    Top = 498
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 550
    Top = 498
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
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
    Left = 468
    Top = 404
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocProps: TIBCDataSource
    DataSet = IBCQueryDocProps
    Left = 468
    Top = 356
  end
  object IBCDataSourceRechizite: TIBCDataSource
    DataSet = IBCQueryRechizite
    Left = 464
    Top = 16
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
    Top = 60
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDT_Accounts: TIBCDataSource
    DataSet = IBCQueryDT_Accounts
    Left = 280
    Top = 464
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
    MasterSource = dmDB.IBCDataSourceDocs
    Options.BooleanDomainFields = True
    Left = 280
    Top = 512
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceCT_Accounts: TIBCDataSource
    DataSet = IBCQueryCT_Accounts
    Left = 436
    Top = 464
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
    MasterSource = dmDB.IBCDataSourceDocs
    Options.BooleanDomainFields = True
    Left = 436
    Top = 512
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end>
  end
end
