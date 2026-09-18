object frmRNDocDlg: TfrmRNDocDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 545
  ClientWidth = 1140
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    1140
    545)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1140
    Height = 64
    Title = 'Rezerva'
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
    Width = 1124
    Height = 431
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
    object cxLabel5: TLabel
      Left = 16
      Top = 42
      Width = 82
      Height = 15
      Caption = 'Data document'
      Transparent = True
    end
    object Bevel1: TBevel
      Left = 16
      Top = 27
      Width = 608
      Height = 4
      Shape = bsTopLine
    end
    object cxLabel1: TLabel
      Left = 16
      Top = 146
      Width = 74
      Height = 15
      Caption = 'Intreprinderea'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 16
      Top = 206
      Width = 64
      Height = 15
      Caption = 'Cumparator'
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 16
      Top = 324
      Width = 32
      Height = 15
      Caption = 'Valuta'
      Transparent = True
    end
    object cxLabel8: TLabel
      Left = 16
      Top = 364
      Width = 63
      Height = 15
      Caption = 'Comentariu'
      Transparent = True
    end
    object cxLabel6: TLabel
      Left = 16
      Top = 176
      Width = 40
      Height = 15
      Caption = 'Depozit'
      Transparent = True
    end
    object Label1: TLabel
      Left = 356
      Top = 324
      Width = 49
      Height = 15
      Caption = 'Curs USD'
      Transparent = True
    end
    object lbContractTitle: TLabel
      Left = 16
      Top = 236
      Width = 46
      Height = 15
      Caption = 'Contract'
      Transparent = True
    end
    object lbContractInfo: TLabel
      Left = 132
      Top = 259
      Width = 358
      Height = 15
      Caption = #1042#1085#1080#1084#1072#1085#1080#1077'! '#1041#1091#1076#1077#1090' '#1087#1088#1080#1084#1077#1085#1077#1085#1072' '#1074#1072#1083#1102#1090#1072' '#1080' '#1082#1086#1083#1086#1085#1082#1072' '#1094#1077#1085' '#1080#1079' '#1082#1086#1085#1090#1088#1072#1082#1090#1072'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label4: TLabel
      Left = 16
      Top = 72
      Width = 31
      Height = 15
      Caption = 'Statut'
      Transparent = True
    end
    object lblSecLivrare: TLabel
      Left = 648
      Top = 8
      Width = 39
      Height = 15
      Caption = 'Livrare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object bvLivrare: TBevel
      Left = 648
      Top = 27
      Width = 460
      Height = 4
      Shape = bsTopLine
    end
    object lblSecDocument: TLabel
      Left = 16
      Top = 8
      Width = 59
      Height = 15
      Caption = 'Document'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblSecParti: TLabel
      Left = 16
      Top = 112
      Width = 26
      Height = 15
      Caption = 'Parti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblSecValuta: TLabel
      Left = 16
      Top = 290
      Width = 71
      Height = 15
      Caption = 'Valuta si curs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object bvParti: TBevel
      Left = 16
      Top = 131
      Width = 608
      Height = 4
      Shape = bsTopLine
    end
    object bvValuta: TBevel
      Left = 16
      Top = 309
      Width = 608
      Height = 4
      Shape = bsTopLine
    end
    object lbAnalytics: TLabel
      Left = 312
      Top = 42
      Width = 46
      Height = 15
      Caption = 'Analitica'
      Transparent = True
    end
    object lbRate: TLabel
      Left = 228
      Top = 324
      Width = 24
      Height = 15
      Caption = 'Curs'
      Transparent = True
    end
    object ceRATE: TcxDBCalcEdit
      Left = 260
      Top = 320
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 12
      Width = 80
    end
    object lcbDTSC: TcxDBLookupComboBox
      Left = 440
      Top = 142
      Hint = 'Analitica 2 (analitica intreprinderii)'
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
      TabOrder = 7
      Width = 184
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 132
      Top = 360
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocProps
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      TabOrder = 14
      OnClick = mmCOMMENTSClick
      OnEnter = mmCOMMENTSClick
      Width = 492
    end
    object deDATA: TcxDBDateEdit
      Left = 132
      Top = 38
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DateButtons = [btnNow]
      Properties.ImmediatePost = True
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      TabOrder = 1
      Width = 160
    end
    object cbFLG_ACNT: TcxDBCheckBox
      Left = 528
      Top = 4
      Caption = 'Contabilitate'
      DataBinding.DataField = 'FLG_ACNT'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Properties.OnEditValueChanged = lcbCURRENCYPropertiesEditValueChanged
      TabOrder = 0
    end
    object lcbDTDEP: TcxDBLookupComboBox
      Left = 132
      Top = 172
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
      TabOrder = 8
      Width = 300
    end
    object beDT_NAME: TcxButtonEdit
      Left = 132
      Top = 142
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
      TabOrder = 6
      Text = 'beDT_NAME'
      Width = 300
    end
    object beCT_NAME: TcxButtonEdit
      Left = 132
      Top = 202
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
      TabOrder = 9
      Text = 'beCT_NAME'
      Width = 492
    end
    object ceRATEUSD: TcxDBCalcEdit
      Left = 412
      Top = 320
      DataBinding.DataField = 'RATEUSD'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 13
      Width = 80
    end
    object lcbAnalytics: TcxDBLookupComboBox
      Left = 376
      Top = 38
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
      TabOrder = 2
      Width = 248
    end
    object beContract: TcxButtonEdit
      Left = 132
      Top = 232
      Properties.BeepOnError = True
      Properties.Buttons = <
        item
          Caption = 'Alege contract'
          Default = True
          ImageIndex = 14
          Kind = bkGlyph
        end
        item
          Caption = 'Sterge contractul'
          ImageIndex = 35
          Kind = bkGlyph
        end>
      Properties.ClearKey = 119
      Properties.ClickKey = 115
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.IncrementalSearch = False
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beContractPropertiesButtonClick
      TabOrder = 10
      Width = 492
    end
    object lcbCURRENCY: TcxDBLookupComboBox
      Left = 132
      Top = 320
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
      Width = 80
    end
    inline frameDelivery: TframeDocsDelivery
      Left = 648
      Top = 38
      Width = 460
      Height = 376
      TabOrder = 3
      ExplicitLeft = 648
      ExplicitTop = 38
      ExplicitWidth = 460
      ExplicitHeight = 376
      inherited lbEmptyHint: TLabel
        Width = 460
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 460
      end
      inherited cxDBVerticalGrid1: TcxDBVerticalGrid
        Width = 460
        Height = 279
        ExplicitWidth = 460
        ExplicitHeight = 279
        Version = 1
        inherited cxDBVerticalGrid1DOCID: TcxDBEditorRow
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
        inherited cxDBVerticalGrid1COURIERID: TcxDBEditorRow
          ID = 1
          ParentID = -1
          Index = 1
          Version = 1
        end
        inherited cxDBVerticalGrid1CategoryRow2: TcxCategoryRow
          ID = 2
          ParentID = -1
          Index = 2
          Version = 1
        end
        inherited cxDBVerticalGrid1COURIER_NAME: TcxDBEditorRow
          ID = 3
          ParentID = 2
          Index = 0
          Version = 1
        end
        inherited cxDBVerticalGrid1AWB: TcxDBEditorRow
          ID = 4
          ParentID = 2
          Index = 1
          Version = 1
        end
        inherited cxDBVerticalGrid1DBMultiEditorRow1: TcxDBMultiEditorRow
          ID = 5
          ParentID = 2
          Index = 2
          Version = 1
        end
        inherited cxDBVerticalGrid1CategoryRow1: TcxCategoryRow
          ID = 6
          ParentID = -1
          Index = 3
          Version = 1
        end
        inherited cxDBVerticalGrid1DELIVERY_DATE: TcxDBEditorRow
          ID = 7
          ParentID = 6
          Index = 0
          Version = 1
        end
        inherited cxDBVerticalGrid1DELIVERY_TIME: TcxDBEditorRow
          ID = 8
          ParentID = 6
          Index = 1
          Version = 1
        end
        inherited cxDBVerticalGrid1DELIVERY_ADDRESS: TcxDBEditorRow
          ID = 9
          ParentID = 6
          Index = 2
          Version = 1
        end
      end
      inherited pnButtons: TPanel
        Top = 339
        Width = 460
        StyleElements = [seFont, seClient, seBorder]
        ExplicitTop = 339
        ExplicitWidth = 460
      end
      inherited IBCQueryDelivery: TIBCQuery
        SQLRefresh.Strings = (
          
            'SELECT DOCID, COURIERID, COURIER_NAME, DELIVERY_ADDRESS, DELIVER' +
            'Y_TIME, DELIVERY_DATE, FLG_CASHONDELIVERY, FLG_INVOICE_ONDELIVER' +
            'Y, TRANSMIS_CURIER, AWB FROM VW_TDB_DOCS_DELIVERY'
          'WHERE'
          '  DOCID = :DOCID')
        SQL.Strings = (
          'select DOCID, COURIERID, COURIER_NAME, FLG_CASHONDELIVERY, '
          
            'DELIVERY_ADDRESS, DELIVERY_TIME, DELIVERY_DATE, FLG_INVOICE_ONDE' +
            'LIVERY,TRANSMIS_CURIER,'
          'AWB'
          'from VW_TDB_DOCS_DELIVERY DD')
      end
    end
  end
  object btnOk: TButton
    Left = 946
    Top = 509
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 1042
    Top = 509
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
    Left = 272
    Top = 276
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocProps: TIBCDataSource
    DataSet = IBCQueryDocProps
    Left = 272
    Top = 228
  end
end
