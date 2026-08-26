inherited frame98ApiAmbianta: Tframe98ApiAmbianta
  Width = 1361
  Height = 568
  Font.Height = -15
  ExplicitWidth = 1361
  ExplicitHeight = 568
  PixelsPerInch = 120
  object cxGrid1: TcxGrid
    Left = 0
    Top = 41
    Width = 1361
    Height = 527
    Align = alClient
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      OnKeyDown = cxGrid1DBTableView1KeyDown
      DataController.DataModeController.GridModeBufferCount = 30
      DataController.DataSource = IBCDataSourceAmbGoods
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = cxGrid1DBTableView1GOODS_CODE
          DisplayText = 'Total inregistrari :'
        end>
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsSelection.MultiSelect = True
      OptionsSelection.UnselectFocusedRecordOnExit = False
      OptionsView.NavigatorOffset = 63
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.OnGetContentStyle = cxGrid1DBTableView1StylesGetContentStyle
      object cxGrid1DBTableView1PPARENTID: TcxGridDBColumn
        DataBinding.FieldName = 'PPARENTID'
        Visible = False
      end
      object cxGrid1DBTableView1TITLE: TcxGridDBColumn
        DataBinding.FieldName = 'TITLE'
        Visible = False
        Width = 100
      end
      object cxGrid1DBTableView1PARENTID: TcxGridDBColumn
        DataBinding.FieldName = 'PARENTID'
        Visible = False
      end
      object cxGrid1DBTableView1PARENT_TITLE: TcxGridDBColumn
        DataBinding.FieldName = 'PARENT_TITLE'
        Visible = False
        Width = 100
      end
      object cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn
        Caption = 'CPF'
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object cxGrid1DBTableView1GOODS_TITLE: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 956
      end
      object cxGrid1DBTableView1COMPLECTID: TcxGridDBColumn
        DataBinding.FieldName = 'COMPLECTID'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGrid1DBTableView1COMPLECT_NAME: TcxGridDBColumn
        DataBinding.FieldName = 'COMPLECT_NAME'
        Visible = False
        VisibleForCustomization = False
        Width = 150
      end
      object cxGrid1DBTableView1GOODS_TYPE_ID: TcxGridDBColumn
        DataBinding.FieldName = 'GOODS_TYPE_ID'
        Visible = False
      end
      object cxGrid1DBTableView1PRICE_IN: TcxGridDBColumn
        Caption = 'Pret 7'
        DataBinding.FieldName = 'PRICE_MDL'
        HeaderAlignmentHorz = taCenter
        Width = 135
      end
      object cxGrid1DBTableView1PRICE_OUT: TcxGridDBColumn
        Caption = 'RRP'
        DataBinding.FieldName = 'PRICE_RRP_MDL'
        HeaderAlignmentHorz = taCenter
        Width = 136
      end
      object cxGrid1DBTableView1OWNGOODSID: TcxGridDBColumn
        DataBinding.FieldName = 'GOODSID'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGrid1DBTableView1PRICE_MDL: TcxGridDBColumn
        DataBinding.FieldName = 'PRICE_MDL'
        Visible = False
        VisibleForExpressionEditor = bTrue
      end
      object cxGrid1DBTableView1_FLG_IN_PRICE: TcxGridDBColumn
        Caption = 'PF'
        DataBinding.FieldName = 'FLG_IN_PRICE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 32
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1361
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 0
    object cxLabel1: TcxLabel
      Left = 24
      Top = 6
      Caption = 'Syncronizarea datelor cu Ambianta'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindow
      Style.Font.Height = -16
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 0
    end
  end
  object IBCQueryAmbGoods: TIBCQuery
    KeyFields = 'goodsid'
    Connection = IBCAmbiantaConnection
    Transaction = IBCAmbTransaction
    UpdateTransaction = IBCAmbTransaction
    SQL.Strings = (
      'select * from get_pricelist'
      ''
      '/*select Z.GOODSID GOODS_CODE,'
      '       Z.GOODS_TITLE,'
      '       Z.COMPLECTID,'
      '       Z.COMPLECT_NAME,'
      '       Z.PRICE_IN,'
      '       Z.PRICE_OUT,'
      '       GF.GOODSID,'
      '       GF.PRICE1 PRICE_MDL,'
      '       GET_FLG_IN_PRICE(GF.GOODSID) FLG_IN_PRICE'
      'from GET_AMB_GOODS Z'
      
        'left outer join TS_GOODS_FOREIGN GF on (cast(GF.GOODS_CODE as va' +
        'rchar(128)) = cast(Z.GOODSID as varchar(128)) and'
      '      GF.CUSTOMERID = 225870)'
      '*/'
      '  ')
    Left = 149
    Top = 232
  end
  object IBCDataSourceAmbGoods: TIBCDataSource
    DataSet = IBCQueryAmbGoods
    Left = 144
    Top = 160
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 464
    Top = 224
    PixelsPerInch = 120
    object cxStylePriceUp: TcxStyle
      AssignedValues = [svColor]
      Color = 8421631
    end
    object cxStylePriceDown: TcxStyle
      AssignedValues = [svColor]
      Color = clSkyBlue
    end
  end
  object IBCAmbTransaction: TIBCTransaction
    DefaultConnection = IBCAmbiantaConnection
    Left = 462
    Top = 119
  end
  object IBCAmbiantaConnection: TIBCConnection
    Database = 'ambianta'
    Options.Charset = 'UTF8'
    Options.UseUnicode = True
    Options.EnableMemos = True
    DefaultTransaction = IBCAmbTransaction
    ClientLibrary = 'fbclient.dll'
    Port = '3050'
    SSLOptions.Enabled = False
    Username = 'SYSDBA'
    Server = '192.168.1.200'
    LoginPrompt = False
    Left = 121
    Top = 49
    EncryptedPassword = 'BEFF92FF9DFF96FF9EFF91FF8BFF9EFFDEFFBFFFDCFFCBFFCAFF'
  end
end
