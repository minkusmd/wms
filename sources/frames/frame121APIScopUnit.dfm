inherited frame121ApiScop: Tframe121ApiScop
  Width = 1173
  Height = 554
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 1173
  ExplicitHeight = 554
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 1173
    Height = 554
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tsPriceList
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 550
    ClientRectLeft = 4
    ClientRectRight = 1169
    ClientRectTop = 26
    object tsPriceList: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Price list'
      ImageIndex = 0
      ExplicitLeft = 3
      ExplicitWidth = 1167
      DesignSize = (
        1165
        524)
      object lcbPriceCategory: TcxLookupComboBox
        Left = 224
        Top = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ParentFont = False
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'PRICE_CATEGORYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.GridLines = glHorizontal
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourcePriceCategories
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 1
        Width = 193
      end
      object cxLabel3: TcxLabel
        Left = 154
        Top = 15
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1056#1072#1079#1088#1077#1079' '#1087#1088#1072#1081#1089#1072
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 2
        Transparent = True
      end
      object btnGetPriceList: TButton
        Left = 20
        Top = 13
        Width = 129
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Actualizare lista de preturi'
        TabOrder = 0
        OnClick = btnGetPriceListClick
      end
      object cxPageControl2: TcxPageControl
        Left = 2
        Top = 58
        Width = 1143
        Height = 463
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 3
        Properties.ActivePage = cxTabSheet1
        Properties.CustomButtons.Buttons = <>
        ExplicitWidth = 1144
        ExplicitHeight = 464
        ClientRectBottom = 459
        ClientRectLeft = 4
        ClientRectRight = 1139
        ClientRectTop = 26
        object tbsPricelist: TcxTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1077#1088#1089#1080#1103' 1'
          ImageIndex = 0
          ExplicitLeft = 3
          ExplicitWidth = 1138
          ExplicitHeight = 436
          object cxGrid1: TcxGrid
            Left = 0
            Top = 0
            Width = 1135
            Height = 307
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 1138
            ExplicitHeight = 310
            object cxGrid1TableView1: TcxGridTableView
              Navigator.InfoPanel.Visible = True
              Navigator.Visible = True
              FindPanel.DisplayMode = fpdmAlways
              FindPanel.UseExtendedSyntax = True
              Filtering.ColumnExcelPopup.ApplyChanges = efacImmediately
              Filtering.ColumnFilteredItemsList = True
              Filtering.ColumnPopupMode = fpmExcel
              OptionsBehavior.IncSearch = True
              OptionsBehavior.CopyPreviewToClipboard = False
              OptionsBehavior.ImmediateEditor = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsSelection.MultiSelect = True
              OptionsSelection.UnselectFocusedRecordOnExit = False
              OptionsView.Footer = True
              OptionsView.GroupByBox = False
              Styles.OnGetContentStyle = cxGrid1TableView1StylesGetContentStyle
              object cxGrid1TableView1_PROMODESCRIPTION: TcxGridColumn
                Caption = 'Promotii'
                MinWidth = 16
                Width = 156
              end
              object cxGrid1TableView1_PROMOSTART: TcxGridColumn
                Caption = 'Start'
                MinWidth = 64
                Options.HorzSizing = False
                Width = 64
              end
              object cxGrid1TableView1_PROMOFINISH: TcxGridColumn
                Caption = 'Finish'
                MinWidth = 64
                Options.HorzSizing = False
                Width = 64
              end
              object cxGrid1TableView1_ROOTNAME: TcxGridColumn
                Caption = 'Root'
                MinWidth = 16
                Options.Sorting = False
                Width = 89
              end
              object cxGrid1TableView1_FOLDERNAME: TcxGridColumn
                Caption = 'Folder Name'
                MinWidth = 16
                Options.Sorting = False
                Width = 78
              end
              object cxGrid1TableView1_VENDORNAME: TcxGridColumn
                Caption = 'Producator'
                MinWidth = 16
                Options.Sorting = False
                Width = 91
              end
              object cxGrid1TableView1_INPRICELIST: TcxGridColumn
                Caption = 'Disponibil'
                DataBinding.ValueType = 'Integer'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.NullStyle = nssUnchecked
                Properties.ReadOnly = True
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                MinWidth = 16
                Width = 49
              end
              object cxGrid1TableView1_GOODS_CODE: TcxGridColumn
                Caption = 'CPF'
                HeaderAlignmentHorz = taCenter
                MinWidth = 16
                Width = 72
              end
              object cxGrid1TableView1_GOODSNAME: TcxGridColumn
                Caption = 'Denumire'
                MinWidth = 16
                Width = 255
              end
              object cxGrid1TableView1_PRICE3: TcxGridColumn
                Caption = 'PriceRRP'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                Properties.Alignment.Horz = taRightJustify
                MinWidth = 16
                Width = 59
              end
              object cxGrid1TableView1_promoprice: TcxGridColumn
                Caption = 'Promo Price'
                MinWidth = 16
                Width = 63
              end
              object cxGrid1TableView1_promopricevalute: TcxGridColumn
                Caption = 'Promo valute'
                MinWidth = 16
                Width = 60
              end
              object cxGrid1TableView1_PRICE7: TcxGridColumn
                Caption = 'Price7'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                MinWidth = 16
                Width = 46
              end
              object cxGrid1TableView1_COST: TcxGridColumn
                Caption = 'Cost'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                Visible = False
                MinWidth = 16
                Width = 41
              end
              object cxGrid1TableView1_PARENT_CODE: TcxGridColumn
                Caption = 'Parent'
                Visible = False
                MinWidth = 16
                Width = 70
              end
              object cxGrid1TableView1_QTY: TcxGridColumn
                Caption = 'Qty'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                Properties.Alignment.Horz = taRightJustify
                MinWidth = 16
              end
              object cxGrid1TableView1_OQTY: TcxGridColumn
                Caption = 'OQty'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                Visible = False
                MinWidth = 16
                VisibleForCustomization = False
              end
              object cxGrid1TableView1_MARGIN: TcxGridColumn
                Caption = '% B'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                Properties.DisplayFormat = '0.00'
                MinWidth = 16
              end
              object cxGrid1TableView1_MARGIN_RRP: TcxGridColumn
                Caption = '% RRP'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                Properties.DisplayFormat = '0.00'
                MinWidth = 16
              end
              object cxGrid1TableView1_IMAGESLIST: TcxGridColumn
                Caption = 'Img'
                MinWidth = 16
              end
            end
            object cxGrid1Level1: TcxGridLevel
              GridView = cxGrid1TableView1
            end
          end
          object Memo2: TMemo
            Left = 0
            Top = 307
            Width = 1135
            Height = 126
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alBottom
            Lines.Strings = (
              'Memo2')
            ScrollBars = ssBoth
            TabOrder = 1
          end
        end
        object cxTabSheet1: TcxTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Images'
          ImageIndex = 3
          OnShow = cxTabSheet1Show
          ExplicitLeft = 3
          ExplicitWidth = 1138
          ExplicitHeight = 436
          object cxGrid5: TcxGrid
            Left = 0
            Top = 0
            Width = 360
            Height = 433
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            TabOrder = 0
            ExplicitHeight = 436
            object cxGrid1DBTableView1: TcxGridDBTableView
              Navigator.InfoPanel.Visible = True
              Navigator.Visible = True
              DataController.DataSource = IBCDataSourceParseSupplierGoods
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              object cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn
                DataBinding.FieldName = 'GOODS_CODE'
                HeaderAlignmentHorz = taCenter
                MinWidth = 16
                Width = 145
              end
              object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
                DataBinding.FieldName = 'GOODSID'
                HeaderAlignmentHorz = taCenter
                MinWidth = 16
                Width = 58
              end
            end
            object cxGridLevel2: TcxGridLevel
              GridView = cxGrid1DBTableView1
            end
          end
          object cxButton1: TcxButton
            Left = 379
            Top = 170
            Width = 192
            Height = 20
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Start'
            Default = True
            OptionsImage.Spacing = 3
            TabOrder = 1
            OnClick = cxButton1Click
          end
          object cxImage1: TcxImage
            Left = 379
            Top = 0
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.GraphicClassName = 'TdxSmartImage'
            TabOrder = 2
            Height = 166
            Width = 192
          end
          object Memo1: TMemo
            Left = 379
            Top = 195
            Width = 192
            Height = 247
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Lines.Strings = (
              'Memo1')
            TabOrder = 3
          end
        end
      end
      object btnLoadFromFile: TButton
        Left = 24
        Top = 38
        Width = 60
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Load'
        TabOrder = 4
        OnClick = btnLoadFromFileClick
      end
      object btnSave: TButton
        Left = 89
        Top = 38
        Width = 60
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Save'
        TabOrder = 5
        OnClick = btnSaveClick
      end
      object cxProgressBar2: TcxProgressBar
        Left = 224
        Top = 38
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 6
        Width = 193
      end
    end
  end
  object IdHTTP1: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 920
    Top = 40
  end
  object IBCQueryPriceCategories: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from TS_CUST_PRICE_CATEGORIES'
      'where customerid = :customerid')
    Left = 1056
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'customerid'
        Value = nil
      end>
  end
  object IBCDataSourcePriceCategories: TIBCDataSource
    DataSet = IBCQueryPriceCategories
    Left = 1056
    Top = 256
  end
  object IBCTrLocal: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 616
    Top = 40
  end
  object IBCQueryCurrencyUSD: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select transfer_rate from ts_currency where currencyid = 840')
    Left = 1280
    Top = 256
  end
  object NetHTTPClient1: TNetHTTPClient
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 720
    Top = 40
  end
  object NetHTTPRequest1: TNetHTTPRequest
    Client = NetHTTPClient1
    Left = 800
    Top = 40
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select GF.GOODSID, GF.GOODS_CODE, gf.goods_title,'
      'get_flg_in_price(gf.goodsid) FLG_IN_PRICE'
      'from TS_GOODS_FOREIGN GF'
      'where GF.CUSTOMERID = 209280'
      '&FlgNoImage'
      '&FlgInPrice')
    Left = 896
    Top = 312
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
    Left = 896
    Top = 256
  end
  object IBCQuerySupplierGoods: TIBCQuery
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      
        'select goods_code, goodsid from ts_goods_foreign gf where custom' +
        'erid = 209280'
      
        'and not exists(select goodsid from ts_goods_image gi where gi.go' +
        'odsid = gf.goodsid)')
    Left = 776
    Top = 312
  end
  object IBCDataSourceSupplierGoods: TIBCDataSource
    DataSet = IBCQuerySupplierGoods
    Left = 776
    Top = 256
  end
  object IBCSQL1: TIBCSQL
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'insert into ts_goods_image (goodsid, image)'
      'values(:goodsid, :image)')
    Left = 1192
    Top = 256
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
  object IBCQueryParser: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'SELECT goods_code, images FROM TPARSE_SUPPLIER_GOODS WHERE image' +
        's IS NOT NULL and supplierid = 209280')
    Left = 480
    Top = 312
  end
  object IBCDataSourceParser: TIBCDataSource
    DataSet = IBCQueryParser
    Left = 480
    Top = 256
  end
  object IBCQueryParseSupplierGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from TPARSE_SUPPLIER_GOODS gg'
      
        'join ts_goods_foreign gf on (gf.goods_code = gg.goods_code and g' +
        'f.customerid = gg.supplierid)'
      'where gg.supplierid = 209280 and'
      
        '      not exists(select * from ts_goods_image ii where ii.goodsi' +
        'd = gf.goodsid)')
    Left = 656
    Top = 312
  end
  object IBCDataSourceParseSupplierGoods: TIBCDataSource
    DataSet = IBCQueryParseSupplierGoods
    Left = 656
    Top = 256
  end
end
