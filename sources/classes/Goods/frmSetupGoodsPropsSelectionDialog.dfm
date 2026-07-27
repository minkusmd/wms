object frmSetupGoodsPropsSelectionDlg: TfrmSetupGoodsPropsSelectionDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Setarea proprietatilor pentru elementele alese'
  ClientHeight = 598
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    516
    598)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 516
    Height = 64
    Title = 'Setarea proprietatilor pentru elementele alese'
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
    ImageIndex = 1
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 500
    Height = 470
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
    ExplicitLeft = 3
    object lbInfoText: TLabel
      Left = 20
      Top = 16
      Width = 121
      Height = 15
      Caption = 'Total produse selectate'
    end
    object lbGoodsCount: TLabel
      Left = 166
      Top = 16
      Width = 6
      Height = 15
      Caption = '0'
    end
    object cbWebGoodsType: TCheckBox
      Left = 20
      Top = 69
      Width = 121
      Height = 17
      Caption = 'Tip produs(web)'
      TabOrder = 1
      OnClick = cbWebGoodsTypeClick
    end
    object lcbWebGoodsType: TcxLookupComboBox
      Left = 216
      Top = 65
      Enabled = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 400
      Properties.KeyFieldNames = 'GOODSTYPEID'
      Properties.ListColumns = <
        item
          Caption = 'Rom'#226'nesc'
          FieldName = 'TITLE'
        end
        item
          Caption = #1056#1091#1089#1089#1082#1080#1081
          SortOrder = soAscending
          FieldName = 'TITLE_RUS'
        end>
      Properties.ListSource = IBCDataSourceWebGoodsType
      EditValue = 0
      TabOrder = 0
      Width = 265
    end
    object lcbVendorID: TcxLookupComboBox
      Left = 216
      Top = 94
      Enabled = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'VENDORID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceVendors
      EditValue = 0
      TabOrder = 2
      Width = 265
    end
    object cbVendorID: TCheckBox
      Left = 20
      Top = 97
      Width = 121
      Height = 17
      Caption = 'Producator'
      TabOrder = 3
      OnClick = cbWebGoodsTypeClick
    end
    object cbBaseParam: TCheckBox
      Left = 20
      Top = 126
      Width = 133
      Height = 17
      Caption = 'Parametru de baza'
      TabOrder = 5
      OnClick = cbWebGoodsTypeClick
    end
    object edBaseParam: TEdit
      Left = 216
      Top = 123
      Width = 265
      Height = 23
      Enabled = False
      TabOrder = 4
      Text = 'edBaseParam'
    end
    object cbGoodsACNT: TCheckBox
      Left = 20
      Top = 156
      Width = 185
      Height = 17
      Caption = 'Denumire factura'
      TabOrder = 7
      OnClick = cbWebGoodsTypeClick
    end
    object beGoodsACNT: TcxButtonEdit
      Left = 216
      Top = 152
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
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beGoodsACNTPropertiesButtonClick
      TabOrder = 6
      Width = 265
    end
    object cbGoodsType: TCheckBox
      Left = 20
      Top = 185
      Width = 121
      Height = 17
      Caption = 'Tip produs'
      Color = clWindow
      ParentColor = False
      TabOrder = 9
      OnClick = cbWebGoodsTypeClick
    end
    object lcbTipEvidenta: TcxLookupComboBox
      Left = 216
      Top = 249
      Enabled = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceTipEvidenta
      EditValue = 0
      TabOrder = 12
      Width = 265
    end
    object cbTipEvidenta: TCheckBox
      Left = 20
      Top = 252
      Width = 121
      Height = 17
      Caption = 'Tip evidenta'
      TabOrder = 13
      OnClick = cbWebGoodsTypeClick
    end
    object cbUM: TCheckBox
      Left = 20
      Top = 281
      Width = 133
      Height = 17
      Caption = 'Unitate metrica'
      TabOrder = 15
      OnClick = cbWebGoodsTypeClick
    end
    object cbWaranty: TCheckBox
      Left = 20
      Top = 219
      Width = 133
      Height = 17
      Caption = 'Garantia'
      Color = clWindow
      ParentColor = False
      TabOrder = 11
      OnClick = cbWebGoodsTypeClick
    end
    object lcbUM: TcxLookupComboBox
      Left = 216
      Top = 278
      Enabled = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'UMID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceUM
      Properties.OnInitPopup = cxLookupComboBox2PropertiesInitPopup
      EditValue = 0
      TabOrder = 14
      Width = 265
    end
    object cbPrefix: TCheckBox
      Left = 20
      Top = 313
      Width = 133
      Height = 17
      Caption = 'Prefix denumire'
      TabOrder = 17
      OnClick = cbWebGoodsTypeClick
    end
    object cbFilterParams: TCheckBox
      Left = 20
      Top = 342
      Width = 133
      Height = 17
      Caption = 'Filtre si parametri'
      TabOrder = 20
      OnClick = cbWebGoodsTypeClick
    end
    object edPrefixName: TEdit
      Left = 216
      Top = 307
      Width = 265
      Height = 23
      Enabled = False
      TabOrder = 16
    end
    object edWaranty: TEdit
      Left = 216
      Top = 211
      Width = 265
      Height = 23
      Enabled = False
      TabOrder = 10
      Text = '24'
    end
    object lcbGoodsType: TcxLookupComboBox
      Left = 216
      Top = 181
      Enabled = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 400
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDSSysS
      EditValue = 0
      TabOrder = 8
      Width = 265
    end
    object NumberBox1: TNumberBox
      Left = 216
      Top = 336
      Width = 49
      Height = 23
      TabOrder = 18
    end
    object Edit1: TEdit
      Left = 271
      Top = 336
      Width = 210
      Height = 23
      TabOrder = 19
      Text = 'Edit1'
    end
    object cxButtonEdit1: TcxButtonEdit
      Left = 32
      Top = 365
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 21
      Text = 'cxButtonEdit1'
      Width = 266
    end
    object cxButtonEdit2: TcxButtonEdit
      Left = 304
      Top = 365
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 22
      Text = 'cxButtonEdit1'
      Width = 177
    end
  end
  object btnOk: TcxButton
    Left = 308
    Top = 553
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 404
    Top = 553
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCDataSourceVendors: TIBCDataSource
    DataSet = IBCQueryVendors
    Left = 272
    Top = 17
  end
  object IBCQueryVendors: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' VENDORID,'
      ' TITLE'
      'FROM'
      ' GET_VENDORS')
    Left = 268
    Top = 69
  end
  object IBCQueryWebGoodsType: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' GOODSTYPEID,'
      ' TITLE,'
      ' TITLE_RUS'
      'FROM'
      ' TS_GOODS_TYPE'
      'WHERE'
      ' GOODSTYPEID<>-1')
    Left = 400
    Top = 68
  end
  object IBCDataSourceWebGoodsType: TIBCDataSource
    DataSet = IBCQueryWebGoodsType
    Left = 400
    Top = 16
  end
  object IBCQuerySysS: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT *'
      'FROM TS_SYSS'
      'WHERE PARENTID = 6')
    Left = 448
    Top = 196
  end
  object IBCDSSysS: TIBCDataSource
    DataSet = IBCQuerySysS
    Left = 448
    Top = 144
  end
  object IBCQueryTipEvidenta: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * From ts_syss '
      'where parentid = 8')
    Left = 416
    Top = 320
  end
  object IBCDataSourceTipEvidenta: TIBCDataSource
    DataSet = IBCQueryTipEvidenta
    Left = 416
    Top = 272
  end
  object IBCQueryUM: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_um'
      'order by TITLE')
    Left = 256
    Top = 256
  end
  object IBCDataSourceUM: TIBCDataSource
    DataSet = IBCQueryUM
    Left = 256
    Top = 216
  end
  object IBCDataSourceFilters: TIBCDataSource
    DataSet = IBCQueryFilters
    Left = 168
    Top = 464
  end
  object IBCDataSourceFilterParams: TIBCDataSource
    DataSet = IBCQueryFilterParams
    Left = 272
    Top = 464
  end
  object IBCQueryFilters: TIBCQuery
    KeyFields = 'FilterID'
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_filters f order by filtername')
    Left = 168
    Top = 524
  end
  object IBCQueryFilterParams: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * From ts_filter_params')
    MasterFields = 'FILTERID'
    DetailFields = 'FILTERID'
    MasterSource = IBCDataSourceFilters
    Left = 272
    Top = 524
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FILTERID'
        Value = nil
      end>
  end
end
