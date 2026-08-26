inherited frame119PernaMea: Tframe119PernaMea
  Width = 1283
  Height = 692
  Font.Height = -15
  ExplicitWidth = 1283
  ExplicitHeight = 692
  PixelsPerInch = 120
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1283
    Height = 587
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxGrid3: TcxGrid
      Left = 8
      Top = 17
      Width = 601
      Height = 534
      TabOrder = 0
      object cxGrid3DBTableView1: TcxGridDBTableView
        FindPanel.DisplayMode = fpdmAlways
        DataController.DataModeController.GridMode = True
        DataController.DataModeController.GridModeBufferCount = 100
        DataController.DataSource = IBCDataSourceParseSupplierGoods
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NavigatorOffset = 63
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        object cxGrid3DBTableView1GOODS_CODE: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_CODE'
          Width = 99
        end
        object cxGrid3DBTableView1TITLE_RO: TcxGridDBColumn
          DataBinding.FieldName = 'TITLE_RO'
          Visible = False
        end
        object cxGrid3DBTableView1TITLE_RU: TcxGridDBColumn
          DataBinding.FieldName = 'TITLE_RU'
          Visible = False
        end
        object cxGrid3DBTableView1IMAGES: TcxGridDBColumn
          DataBinding.FieldName = 'IMAGES'
          Width = 473
        end
        object cxGrid3DBTableView1URL_RO: TcxGridDBColumn
          DataBinding.FieldName = 'URL_RO'
          Visible = False
        end
        object cxGrid3DBTableView1URL_RU: TcxGridDBColumn
          DataBinding.FieldName = 'URL_RU'
          Visible = False
        end
        object cxGrid3DBTableView1DESCRIPTIONS_RO: TcxGridDBColumn
          DataBinding.FieldName = 'DESCRIPTIONS_RO'
          Visible = False
        end
        object cxGrid3DBTableView1DESCRIPTIONS_RU: TcxGridDBColumn
          DataBinding.FieldName = 'DESCRIPTIONS_RU'
          Visible = False
        end
        object cxGrid3DBTableView1CARACTERISTICS_RO: TcxGridDBColumn
          DataBinding.FieldName = 'CARACTERISTICS_RO'
          Visible = False
        end
        object cxGrid3DBTableView1CARACTERISTICS_RU: TcxGridDBColumn
          DataBinding.FieldName = 'CARACTERISTICS_RU'
          Visible = False
        end
      end
      object cxGrid3Level1: TcxGridLevel
        GridView = cxGrid3DBTableView1
      end
    end
    object Memo1: TMemo
      Left = 624
      Top = 320
      Width = 241
      Height = 231
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssBoth
      TabOrder = 1
    end
    object cxImage1: TcxImage
      Left = 624
      Top = 17
      ParentFont = False
      Properties.GraphicClassName = 'TdxSmartImage'
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 2
      Height = 288
      Width = 505
    end
    object Memo2: TMemo
      Left = 888
      Top = 320
      Width = 241
      Height = 231
      ScrollBars = ssBoth
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 587
    Width = 1283
    Height = 105
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object btnLoadImages: TButton
      Left = 8
      Top = 20
      Width = 130
      Height = 39
      Caption = 'Start download'
      TabOrder = 0
      OnClick = btnLoadImagesClick
    end
    object cxProgressBar2: TcxProgressBar
      Left = 144
      Top = 30
      ParentFont = False
      Properties.PeakValue = 30.000000000000000000
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 745
    end
  end
  object IBCTrLocal: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 808
    Top = 72
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select GF.GOODSID, GF.GOODS_CODE, gf.goods_title,'
      'get_flg_in_price(gf.goodsid) FLG_IN_PRICE'
      'from TS_GOODS_FOREIGN GF'
      'where GF.CUSTOMERID = 198'
      '&FlgNoImage'
      '&FlgInPrice')
    Left = 448
    Top = 240
    MacroData = <
      item
        Name = 'FlgNoImage'
      end
      item
        Name = 'FlgInPrice'
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 448
    Top = 184
  end
  object IBCQueryImages: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select gf.goodsid, gf.goods_code, g.title, an.imageslist from'
      'ts_goods_foreign gf'
      'join ts_goods g on g.goodsid = gf.goodsid'
      
        'join tapi_accent_nomeclature an on an.product_code = gf.goods_co' +
        'de and gf.customerid = 198'
      'where not exists('
      
        '    select * from ts_goods_image gi where gi.goodsid = gf.goodsi' +
        'd'
      '    )')
    Left = 584
    Top = 240
  end
  object IBCDataSourceImages: TIBCDataSource
    DataSet = IBCQueryImages
    Left = 584
    Top = 184
  end
  object IBCQueryParseSupplierGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from TPARSE_SUPPLIER_GOODS gg'
      
        'join ts_goods_foreign gf on (gf.goods_code = gg.goods_code and g' +
        'f.customerid = gg.supplierid)'
      'where gg.supplierid = 307501 and'
      
        '      not exists(select * from ts_goods_image ii where ii.goodsi' +
        'd = gf.goodsid)')
    Left = 152
    Top = 120
  end
  object IBCDataSourceParseSupplierGoods: TIBCDataSource
    DataSet = IBCQueryParseSupplierGoods
    Left = 152
    Top = 64
  end
  object NetHTTPClient: TNetHTTPClient
    UserAgent = 
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KH' +
      'TML, like Gecko) Chrome/93.0.4577.82 Safari/537.36'
    Left = 528
    Top = 80
  end
end
