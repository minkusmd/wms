inherited frame101WebScrapMuncitorul: Tframe101WebScrapMuncitorul
  Width = 1273
  Height = 624
  Margins.Left = 2
  Margins.Top = 2
  Margins.Right = 2
  Margins.Bottom = 2
  Font.Height = -12
  ExplicitWidth = 1273
  ExplicitHeight = 624
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 1273
    Height = 624
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ExplicitWidth = 914
    ExplicitHeight = 406
    ClientRectBottom = 620
    ClientRectLeft = 4
    ClientRectRight = 1269
    ClientRectTop = 26
    object tsImages: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Imagini si caracteristici'
      ImageIndex = 0
      ExplicitWidth = 906
      ExplicitHeight = 376
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1265
        Height = 58
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 906
        object cbNoImages: TcxCheckBox
          Left = 7
          Top = 3
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1053#1077#1090' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
          Properties.OnChange = cbNoImagesPropertiesChange
          Style.TransparentBorder = False
          TabOrder = 0
        end
        object cbFLG_IN_PRICE: TcxCheckBox
          Left = 7
          Top = 27
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'In price'
          Properties.OnEditValueChanged = cbFLG_IN_PRICEPropertiesEditValueChanged
          Style.TransparentBorder = False
          TabOrder = 4
        end
        object cxButton1: TcxButton
          Left = 206
          Top = 3
          Width = 72
          Height = 23
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Incepe'
          Default = True
          OptionsImage.Spacing = 2
          TabOrder = 2
          OnClick = cxButton1Click
        end
        object cxButton2: TcxButton
          Left = 130
          Top = 3
          Width = 72
          Height = 23
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Set forced'
          OptionsImage.Spacing = 2
          TabOrder = 1
          OnClick = cxButton2Click
        end
        object cxButton3: TcxButton
          Left = 282
          Top = 3
          Width = 72
          Height = 23
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Parse JSON'
          OptionsImage.Spacing = 2
          TabOrder = 3
          OnClick = cxButton3Click
        end
      end
      object cxGridMuncitorulGoods: TcxGrid
        Left = 0
        Top = 58
        Width = 481
        Height = 536
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        TabOrder = 1
        LookAndFeel.NativeStyle = True
        LookAndFeel.SkinName = ''
        ExplicitTop = 62
        ExplicitHeight = 318
        object cxGridMuncitorulGoodsDBTableView1: TcxGridDBTableView
          OnKeyDown = cxGridMuncitorulGoodsDBTableView1KeyDown
          FindPanel.DisplayMode = fpdmAlways
          DataController.DataSource = IBCDataSource1
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object cxGridMuncitorulGoodsDBTableView1GOODSID: TcxGridDBColumn
            Caption = 'Cod produs'
            DataBinding.FieldName = 'GOODSID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 7
            Width = 32
          end
          object cxGridMuncitorulGoodsDBTableView1GOODS_CODE: TcxGridDBColumn
            Caption = 'CPF'
            DataBinding.FieldName = 'GOODS_CODE'
            HeaderAlignmentHorz = taCenter
            MinWidth = 7
            Width = 70
          end
          object cxGridMuncitorulGoodsDBTableView1_GOODS_TITLE: TcxGridDBColumn
            Caption = 'Produs'
            DataBinding.FieldName = 'GOODS_TITLE'
            HeaderAlignmentHorz = taCenter
            MinWidth = 7
            Width = 290
          end
          object cxGridMuncitorulGoodsDBTableView1_FLG_IN_PRICE: TcxGridDBColumn
            Caption = 'P'
            DataBinding.FieldName = 'FLG_IN_PRICE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.NullStyle = nssUnchecked
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            HeaderAlignmentHorz = taCenter
            MinWidth = 7
            Width = 75
          end
        end
        object cxGridMuncitorulGoodsLevel1: TcxGridLevel
          GridView = cxGridMuncitorulGoodsDBTableView1
        end
      end
      object Memo1: TMemo
        Left = 481
        Top = 58
        Width = 784
        Height = 536
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 2
        ExplicitLeft = 316
        ExplicitWidth = 590
        ExplicitHeight = 318
      end
    end
    object tsPromotii: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Promotii'
      ImageIndex = 1
      ExplicitWidth = 906
      ExplicitHeight = 376
      object cxButton4: TcxButton
        Left = 6
        Top = 6
        Width = 97
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Parse promotions'
        OptionsImage.Spacing = 2
        TabOrder = 0
        OnClick = cxButton4Click
      end
      object Memo2: TMemo
        Left = 6
        Top = 195
        Width = 264
        Height = 95
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Lines.Strings = (
          'Memo2')
        TabOrder = 2
      end
      object SynEdit1: TSynEdit
        Left = 6
        Top = 27
        Width = 264
        Height = 166
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -10
        Font.Name = 'Consolas'
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        TabOrder = 1
        UseCodeFolding = False
        BookMarkOptions.LeftMargin = 1
        BookMarkOptions.Xoffset = 5
        ExtraLineSpacing = 1
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -4
        Gutter.Font.Name = 'Consolas'
        Gutter.Font.Style = []
        Gutter.Font.Quality = fqClearTypeNatural
        Gutter.Bands = <
          item
            Kind = gbkMarks
            Width = 13
          end
          item
            Kind = gbkLineNumbers
          end
          item
            Kind = gbkFold
          end
          item
            Kind = gbkTrackChanges
          end
          item
            Kind = gbkMargin
            Width = 3
          end>
        Lines.Strings = (
          'from lxml import html'
          ''
          'import csv'
          ''
          'import asyncio'
          'import aiohttp'
          ''
          'products = []'
          ''
          'promo_url = []'
          ''
          'web_header = {'
          
            '    '#39'User-Agent'#39': '#39'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_' +
            '1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Sa' +
            'fari/537.36'#39','
          
            '    '#39'Accept'#39': '#39'text/html,application/xhtml+xml,application/xml;q' +
            '=0.9,image/avif,image/webp,*/*;q=0.8'#39','
          '    '#39'Accept-Language'#39': '#39'en-US,en;q=0.9,ro;q=0.8,ru;q=0.7'#39','
          '    '#39'Accept-Encoding'#39': '#39'gzip, deflate, br'#39','
          '    '#39'Referer'#39': '#39'https://www.google.com'#39
          '}'
          ''
          'open('#39'muncitorul.csv'#39', '#39'w'#39').close()'
          ''
          ''
          'def csv_export(Products: list, filepath: str):'
          
            '    with open(filepath, mode='#39'+a'#39', encoding="utf-8", newline='#39#39')' +
            ' as csv_file:'
          '        csv_writer = csv.writer(csv_file, delimiter='#39','#39')'
          ''
          '        for product in Products:'
          '            if len(product) > 0:'
          '                csv_writer.writerow(product)'
          ''
          ''
          
            'async def get_xpath_tree_aiohttp(url: str, proxy=None) -> html.d' +
            'ocument_fromstring:'
          
            '    async with aiohttp.ClientSession(headers=web_header, timeout' +
            '=aiohttp.ClientTimeout(10)) as sesion:'
          '        async with sesion.get(url, proxy=proxy) as response:'
          '            try:'
          
            '                xpath_tree = html.document_fromstring(await resp' +
            'onse.text())'
          ''
          '            except:'
          '                pass'
          ''
          '    return xpath_tree'
          ''
          ''
          'async def get_promos():'
          '    domain = '#39'https://muncitorul.md'#39
          ''
          
            '    xpath_tree = await get_xpath_tree_aiohttp('#39'https://muncitoru' +
            'l.md/ro/promotii'#39')'
          ''
          
            '    all_promo = xpath_tree.xpath('#39'//*[@class = "offers__page "]/' +
            'div[1]/a/@href'#39')'
          ''
          '    for promo in all_promo:'
          '        promo_url.append(domain + promo)'
          ''
          ''
          'async def get_products(url: str):'
          '    xpath_tree = await get_xpath_tree_aiohttp(url)'
          ''
          '    products = [[]]'
          ''
          
            '    product_id = xpath_tree.xpath('#39'//*[@class = "swiper-slide"]/' +
            '/div[@class = "card__price"]/p[2]/span/text()'#39')'
          ''
          
            '    product_name = xpath_tree.xpath('#39'//*[@class = "swiper-slide"' +
            ']/div/a/p//text()'#39')'
          ''
          '    product_price = xpath_tree.xpath('
          
            '        '#39'//*[@class = "swiper-slide"]/div/div[@class="card__pric' +
            'e"]/p[@class="card__price-number"]/text()'#39')'
          ''
          
            '    product_price_old_raw = xpath_tree.xpath('#39'//*[@class = "swip' +
            'er-slide"]/div/div[@class = "card__oldprice"]/text()'#39')'
          ''
          '    product_price_old = []'
          ''
          '    for product in product_price_old_raw:'
          '        product = product.strip()'
          '        if product.isnumeric():'
          '            product_price_old.append(str(product))'
          ''
          
            '    ## Cateodata reducerea lipseste ( promotie cumpara 1 si ea c' +
            'eva cadou )'
          '    try:'
          '        for item in range(len(product_id)):'
          '            products.append('
          
            '                [product_id[item], product_name[item], product_p' +
            'rice[item].strip(), product_price_old[item].strip()])'
          '    except:'
          '        for item in range(len(product_id)):'
          
            '            products.append([product_id[item], product_name[item' +
            '], product_price[item].strip()])'
          ''
          '    csv_export(products, '#39'muncitorul.csv'#39')'
          ''
          '    return'
          ''
          ''
          'def get_all_products():'
          '    task = []'
          ''
          '    for promo in promo_url:'
          '        task.append(get_products(promo))'
          ''
          '    return task'
          ''
          ''
          'async def main():'
          '    await get_promos()'
          ''
          '    await asyncio.gather(*get_all_products())'
          ''
          '    return'
          ''
          ''
          'if __name__ == "__main__":'
          
            '    asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLo' +
            'opPolicy())'
          '    asyncio.run(main())'
          '')
        SelectedColor.Alpha = 0.400000005960464500
      end
    end
    object cxTabSheet1: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'api'
      ImageIndex = 2
      ExplicitWidth = 906
      ExplicitHeight = 376
      object cxTextEdit1: TcxTextEdit
        Left = 6
        Top = 6
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 0
        Text = 'https://price.muncitorul.md/api/products.json'
        Width = 520
      end
      object btnLoadJSON: TcxButton
        Left = 529
        Top = 3
        Width = 78
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Load JSON'
        OptionsImage.Spacing = 2
        TabOrder = 1
        OnClick = btnLoadJSONClick
      end
      object Memo3: TMemo
        Left = 10
        Top = 31
        Width = 655
        Height = 111
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Lines.Strings = (
          'Memo3')
        ScrollBars = ssBoth
        TabOrder = 2
      end
      object cxButton5: TcxButton
        Left = 2
        Top = 145
        Width = 123
        Height = 24
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Load to dataset'
        OptionsImage.Spacing = 2
        TabOrder = 3
        OnClick = cxButton5Click
      end
      object cxGridImages: TcxGrid
        Left = 11
        Top = 173
        Width = 654
        Height = 152
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 4
        object cxGridImagesDBTableView1: TcxGridDBTableView
        end
        object cxGridLevelImages: TcxGridLevel
          GridView = cxGridImagesDBTableView1
        end
      end
      object cxGridFeatures: TcxGrid
        Left = 12
        Top = 329
        Width = 653
        Height = 240
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 5
        object cxGridFeaturesDBTableView2: TcxGridDBTableView
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridFeaturesDBTableView2
        end
      end
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 1024
    Top = 76
    PixelsPerInch = 96
    object bbProvesti: TdxBarButton
      Caption = 'Valideaza transactia'
      Category = 0
      Hint = 'Valideaza transactia'
      Visible = ivAlways
      ImageIndex = 43
      ShortCut = 120
    end
    object bbCancelProvodca: TdxBarButton
      Caption = 'Anuleaza validarea'
      Category = 0
      Hint = 'Anuleaza validarea'
      Visible = ivAlways
    end
    object bbDocComments: TdxBarButton
      Caption = 'Mentiuni'
      Category = 0
      Hint = 'Mentiuni'
      Visible = ivAlways
    end
    object bbCustomerDebts: TdxBarButton
      Caption = 'Creante si datorii'
      Category = 0
      Hint = 'Creante si datorii'
      Visible = ivAlways
      ShortCut = 16452
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Treci la documentul parinte'
      Category = 0
      Hint = 'Treci la documentul parinte'
      Visible = ivAlways
      ShortCut = 32805
    end
  end
  object cxGridPopupMenu: TcxGridPopupMenu
    PopupMenus = <
      item
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmPopupMenuDoc
      end>
    UseBuiltInPopupMenus = False
    AlwaysFireOnPopup = True
    Left = 876
    Top = 404
  end
  object pmPopupMenuDoc: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbProvesti'
      end
      item
        Visible = True
        ItemName = 'bbCancelProvodca'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCustomerDebts'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end>
    UseOwnFont = False
    Left = 1028
    Top = 148
    PixelsPerInch = 96
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select GF.GOODSID, GF.GOODS_CODE, gf.goods_title,'
      'get_flg_in_price(gf.goodsid) FLG_IN_PRICE'
      'from TS_GOODS_FOREIGN GF'
      'where GF.CUSTOMERID = 251465 and not exists(select * '
      
        '                                            from TS_GOODS_IMAGE ' +
        'GI'
      
        '                                            where GI.GOODSID = G' +
        'F.GOODSID and '
      
        '                                            coalesce(octet_lengt' +
        'h(GI.IMAGE), 0) > 0)'
      '      &HasFlg_In_Price'
      '      &HasNoImage')
    Left = 1128
    Top = 136
    MacroData = <
      item
        Name = 'HasFlg_In_Price'
      end
      item
        Name = 'HasNoImage'
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 1128
    Top = 72
  end
  object NetHTTPClient1: TNetHTTPClient
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 888
    Top = 72
  end
  object IBCSQL1: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCtrLocalUpdate
    SQL.Strings = (
      'insert into ts_goods_image (goodsid, image)'
      'values(:goodsid, :image)')
    Left = 880
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'image'
        Value = nil
      end>
  end
  object IBCtrLocalUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 888
    Top = 152
  end
  object IBCSQLGoods: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCtrLocalUpdate
    SQL.Strings = (
      
        ' update or insert into TS_GOODS_DSC (GOODSID, DESCRIPTION, DESCR' +
        'IPTION_RO)'
      ' values (:GOODSID, :DESCRIPTION_RU, :DESCRIPTION_RO)'
      ' matching (GOODSID)')
    Left = 872
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DESCRIPTION_RU'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DESCRIPTION_RO'
        Value = nil
      end>
  end
  object dxMemData1: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 1024
    Top = 216
    object dxMemData1Code: TStringField
      DisplayWidth = 128
      FieldName = 'Code'
      Size = 32
    end
    object dxMemData1Titlu: TStringField
      FieldName = 'Titlu'
      Size = 300
    end
    object dxMemData1pret_online: TFloatField
      FieldName = 'pret_online'
    end
    object dxMemData1pret_vinz: TFloatField
      FieldName = 'pret_vinz'
    end
    object dxMemData1stoc: TStringField
      FieldName = 'stoc'
      Size = 16
    end
  end
  object DataSource1: TDataSource
    DataSet = dxMemData1
    Left = 1016
    Top = 296
  end
  object dxMemProducts: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 256
    Top = 232
  end
  object dxMemImages: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 352
    Top = 232
  end
  object dxMemFeatures: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 448
    Top = 232
  end
  object dsMemProducts: TDataSource
    DataSet = dxMemProducts
    Left = 256
    Top = 152
  end
  object dsMemImages: TDataSource
    DataSet = dxMemImages
    Left = 352
    Top = 152
  end
  object dsMemFeatures: TDataSource
    DataSet = dxMemFeatures
    Left = 448
    Top = 152
  end
end
