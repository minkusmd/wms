object frmWebZakazDocDlg: TfrmWebZakazDocDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Web comanda'
  ClientHeight = 580
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  DesignSize = (
    1000
    580)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1000
    Height = 64
    Title = 'Web comanda'
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
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 560
    Width = 1000
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 250
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object pnClient: TScrollBox
    Left = 8
    Top = 70
    Width = 984
    Height = 445
    Color = clWindow
    ParentColor = False
    TabOrder = 2
    UseWheelForScrolling = True
    object lblSecDocument: TLabel
      Left = 12
      Top = 8
      Width = 86
      Height = 15
      Caption = 'Date document'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object bvDocument: TBevel
      Left = 12
      Top = 27
      Width = 480
      Height = 4
      Shape = bsTopLine
    end
    object cxLabel5: TLabel
      Left = 12
      Top = 41
      Width = 25
      Height = 15
      Caption = 'Data'
      Transparent = True
    end
    object lblStare: TLabel
      Left = 282
      Top = 41
      Width = 30
      Height = 15
      Caption = 'Stare'
      Transparent = True
    end
    object lblOrganizatie: TLabel
      Left = 12
      Top = 77
      Width = 64
      Height = 15
      Caption = 'Organizatie'
      Transparent = True
    end
    object lblAnaliticaOrg: TLabel
      Left = 12
      Top = 113
      Width = 77
      Height = 15
      Caption = 'Analitica org.'
      Transparent = True
    end
    object cxLabel1: TLabel
      Left = 12
      Top = 149
      Width = 78
      Height = 15
      Caption = 'Analitica doc.'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 185
      Width = 31
      Height = 15
      Caption = 'Client'
      Transparent = True
    end
    object cxLabel6: TLabel
      Left = 12
      Top = 221
      Width = 40
      Height = 15
      Caption = 'Depozit'
      Transparent = True
    end
    object lblSecFinante: TLabel
      Left = 12
      Top = 258
      Width = 87
      Height = 15
      Caption = 'Valuta si sume'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object bvFinante: TBevel
      Left = 12
      Top = 277
      Width = 480
      Height = 4
      Shape = bsTopLine
    end
    object cxLabel3: TLabel
      Left = 12
      Top = 291
      Width = 35
      Height = 15
      Caption = 'Valuta'
      Transparent = True
    end
    object lblRata: TLabel
      Left = 248
      Top = 291
      Width = 25
      Height = 15
      Caption = 'Rata'
      Transparent = True
    end
    object Label1: TLabel
      Left = 12
      Top = 327
      Width = 48
      Height = 15
      Caption = 'Rata USD'
      Transparent = True
    end
    object Label2: TLabel
      Left = 248
      Top = 327
      Width = 51
      Height = 15
      Caption = 'Cashback'
      Transparent = True
    end
    object lblSecLivrare: TLabel
      Left = 516
      Top = 8
      Width = 42
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
      Left = 516
      Top = 27
      Width = 460
      Height = 4
      Shape = bsTopLine
    end
    object cxLabel8: TLabel
      Left = 516
      Top = 326
      Width = 55
      Height = 15
      Caption = 'Mentiuni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object bvMentiuni: TBevel
      Left = 516
      Top = 345
      Width = 460
      Height = 4
      Shape = bsTopLine
    end
    object deDATA: TcxDBDateEdit
      Left = 112
      Top = 38
      Hint = 'Data documentului'
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentShowHint = False
      Properties.DateButtons = [btnNow]
      Properties.ImmediatePost = True
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      ShowHint = True
      TabOrder = 0
      Width = 150
    end
    object beDT_NAME: TcxButtonEdit
      Left = 112
      Top = 74
      Hint = 'Organizatia emitenta - F4 pentru alegere'
      ParentShowHint = False
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
      ShowHint = True
      TabOrder = 2
      Text = 'beDT_NAME'
      Width = 380
    end
    object lcbDTSC: TcxDBLookupComboBox
      Left = 112
      Top = 110
      Hint = 'Analitica organizatiei'
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
      TabOrder = 3
      Width = 380
    end
    object lcbAnalytics: TcxDBLookupComboBox
      Left = 112
      Top = 146
      Hint = 'Analitica documentului'
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
      TabOrder = 4
      Width = 380
    end
    object beCT_NAME: TcxButtonEdit
      Left = 112
      Top = 182
      Hint = 'Clientul comenzii - F4 pentru alegere'
      ParentShowHint = False
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
      ShowHint = True
      TabOrder = 5
      Text = 'beCT_NAME'
      Width = 380
    end
    object lcbDTDEP: TcxDBLookupComboBox
      Left = 112
      Top = 218
      Hint = 'Depozitul de expediere'
      DataBinding.DataField = 'DTDEP'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      ParentShowHint = False
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
      ShowHint = True
      TabOrder = 6
      Width = 380
    end
    object lcbCURRENCY: TcxDBLookupComboBox
      Left = 112
      Top = 288
      DataBinding.DataField = 'CURRENCYID'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
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
      TabOrder = 7
      Width = 120
    end
    object ceRATE: TcxDBCalcEdit
      Left = 306
      Top = 288
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Enabled = False
      Properties.ImmediatePost = True
      TabOrder = 8
      Width = 100
    end
    object ceRATEUSD: TcxDBCalcEdit
      Left = 112
      Top = 324
      DataBinding.DataField = 'RATEUSD'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Enabled = False
      Properties.ImmediatePost = True
      TabOrder = 9
      Width = 120
    end
    object ceCashback: TcxDBCalcEdit
      Left = 306
      Top = 324
      Hint = 'Cashback utilizat in aceasta comanda'
      DataBinding.DataField = 'CASHBACK_USED'
      DataBinding.DataSource = IBCDataSourceCashback
      ParentShowHint = False
      Properties.ReadOnly = True
      ShowHint = True
      TabOrder = 10
      Width = 100
    end
    object cbFLG_ACNT: TcxDBCheckBox
      Left = 112
      Top = 360
      Caption = 'Contabilitate'
      DataBinding.DataField = 'FLG_ACNT'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Style.TransparentBorder = False
      TabOrder = 11
      Width = 130
    end
    inline frameDelivery: TframeDocsDelivery
      Left = 516
      Top = 34
      Width = 460
      Height = 280
      TabOrder = 12
      ExplicitLeft = 516
      ExplicitTop = 34
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 516
      Top = 356
      Hint = 'Click pentru a edita mentiunile documentului'
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = dmDB.IBCDataSourceDocComments
      ParentShowHint = False
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 4
      Properties.WantReturns = False
      ShowHint = True
      TabOrder = 13
      OnClick = mmCOMMENTSClick
      Width = 460
    end
  end
  object btnOk: TcxButton
    Left = 804
    Top = 523
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TcxButton
    Left = 902
    Top = 523
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
  end
  object IBCQueryCashback: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from TDB_DOCS_CASHBACK_USED cu'
      'where cu.docid=:DOCID')
    Left = 88
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceCashback: TIBCDataSource
    DataSet = IBCQueryCashback
    Left = 88
    Top = 240
  end
  object Timer1: TTimer
    Interval = 2500
    OnTimer = Timer1Timer
    Left = 368
    Top = 304
  end
end
