inherited frame79AnalizePriceList: Tframe79AnalizePriceList
  Width = 1120
  Height = 644
  Font.Height = -12
  ExplicitWidth = 1120
  ExplicitHeight = 644
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 644
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 13
      Top = 52
      Width = 78
      Height = 15
      Caption = 'Pricelist curent'
    end
    object Label2: TLabel
      Left = 13
      Top = 102
      Width = 85
      Height = 15
      Caption = 'Pricelist anterior'
    end
    object Label3: TLabel
      Left = 13
      Top = 2
      Width = 43
      Height = 15
      Caption = 'Supplier'
    end
    object lcbCurrentPrice: TcxLookupComboBox
      Left = 13
      Top = 73
      Enabled = False
      Properties.GridMode = True
      Properties.ImmediatePost = True
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'PLID;DATA'
      Properties.ListColumns = <
        item
          FieldName = 'PLID'
        end
        item
          FieldName = 'DATA'
        end>
      Properties.ListSource = IBCDataSourceCurrentPriceList
      TabOrder = 1
      Width = 161
    end
    object lcbOldPricelist: TcxLookupComboBox
      Left = 13
      Top = 123
      Enabled = False
      Properties.GridMode = True
      Properties.ImmediatePost = True
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'PLID;DATA'
      Properties.ListColumns = <
        item
          FieldName = 'PLID'
        end
        item
          FieldName = 'DATA'
        end>
      Properties.ListSource = IBCDataSourceOldPriceList
      TabOrder = 2
      Width = 161
    end
    object cxButton1: TcxButton
      Left = 94
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 3
      OnClick = cxButton1Click
    end
    object beCustomer: TcxButtonEdit
      Left = 13
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 0
      OnClick = beCustomerClick
      Width = 161
    end
  end
  object Panel2: TPanel
    Left = 185
    Top = 0
    Width = 935
    Height = 644
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object cxPageControl1: TcxPageControl
      Left = 1
      Top = 29
      Width = 933
      Height = 436
      Align = alClient
      TabOrder = 1
      Properties.ActivePage = tbsAllPriceList
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 432
      ClientRectLeft = 4
      ClientRectRight = 929
      ClientRectTop = 26
      object tbsAllPriceList: TcxTabSheet
        Caption = 'Toate produsele'
        ImageIndex = 0
        object cxGrid1: TcxGrid
          Left = 0
          Top = 0
          Width = 925
          Height = 406
          Align = alClient
          TabOrder = 0
          object cxGrid1DBTableView1: TcxGridDBTableView
            DataController.DataSource = IBCDataSourcePriceItems
            DataController.Summary.DefaultGroupSummaryItems = <
              item
                Kind = skCount
                Column = cxGrid1DBTableView1FLAGS
              end
              item
                Kind = skCount
                Position = spFooter
                Column = cxGrid1DBTableView1FLAGS
              end>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skCount
                Column = cxGrid1DBTableView1SUPPLIER_GOODS_CODE
              end>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            object cxGrid1DBTableView1SUPPLIER_GOODS_CODE: TcxGridDBColumn
              Caption = 'cod produs furnizor'
              DataBinding.FieldName = 'SUPPLIER_GOODS_CODE'
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
            object cxGrid1DBTableView1OLD_PRICE0: TcxGridDBColumn
              Caption = 'Pret 0'
              DataBinding.FieldName = 'OLD_PRICE0'
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGrid1DBTableView1OLD_PRICE7: TcxGridDBColumn
              Caption = 'Pret 7'
              DataBinding.FieldName = 'OLD_PRICE7'
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGrid1DBTableView1SUPPLIER_GOODS_CODE_1: TcxGridDBColumn
              Caption = 'Denumire produs'
              DataBinding.FieldName = 'SUPPLIER_GOODS_CODE_1'
              PropertiesClassName = 'TcxMemoProperties'
            end
            object cxGrid1DBTableView1NEW_PRICE0: TcxGridDBColumn
              Caption = 'Pret 0'
              DataBinding.FieldName = 'NEW_PRICE0'
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGrid1DBTableView1NEW_PRICE7: TcxGridDBColumn
              Caption = 'Pret 7'
              DataBinding.FieldName = 'NEW_PRICE7'
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGrid1DBTableView1FLAGS: TcxGridDBColumn
              Caption = 'Starea produsului'
              DataBinding.FieldName = 'GOODS_STATE'
              Visible = False
              GroupIndex = 0
              Width = 55
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
      object cxTabSheet1: TcxTabSheet
        Caption = 'Produse noi'
        ImageIndex = 1
        OnHide = cxTabSheet1Hide
        OnShow = cxTabSheet1Show
        object cxGrid3: TcxGrid
          Left = 0
          Top = 0
          Width = 624
          Height = 406
          Align = alClient
          TabOrder = 0
          object cxGridDBTableView1: TcxGridDBTableView
            DataController.DataSource = IBCDataSourceNewGoods
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '0'
                Kind = skCount
                Column = cxGridDBTableView1SUPPLIER_GOODS_CODE
              end>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.MultiSelect = True
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object cxGridDBTableView1SUPPLIER_GOODS_CODE: TcxGridDBColumn
              Caption = 'cod produs furnizor'
              DataBinding.FieldName = 'SUPPLIER_GOODS_CODE'
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
            object cxGridDBTableView1SUPPLIER_GOODS_NAME: TcxGridDBColumn
              Caption = 'Denumire produs'
              DataBinding.FieldName = 'SUPPLIER_GOODS_NAME'
              Width = 608
            end
            object cxGridDBTableView1NEW_PRICE0: TcxGridDBColumn
              Caption = 'Pret 0'
              DataBinding.FieldName = 'PRICE0'
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridDBTableView1NEW_PRICE7: TcxGridDBColumn
              Caption = 'Pret 7'
              DataBinding.FieldName = 'PRICE7'
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridDBTableView1
          end
        end
        object Panel4: TPanel
          Left = 624
          Top = 0
          Width = 301
          Height = 406
          Align = alRight
          TabOrder = 1
          object Splitter1: TSplitter
            Left = 1
            Top = 1
            Height = 404
            ExplicitLeft = 152
            ExplicitTop = 152
            ExplicitHeight = 100
          end
          object cxDBTreeList1: TcxDBTreeList
            Left = 4
            Top = 1
            Width = 296
            Height = 404
            Align = alClient
            Bands = <
              item
              end>
            DataController.DataSource = IBCDataSourceGoods
            RootValue = -1
            ScrollbarAnnotations.CustomAnnotations = <>
            TabOrder = 0
            object cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn
              DataBinding.FieldName = 'GOODSID'
              Width = 57
              Position.ColIndex = 0
              Position.RowIndex = 0
              Position.BandIndex = 0
              Summary.FooterSummaryItems = <>
              Summary.GroupFooterSummaryItems = <>
            end
            object cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn
              DataBinding.FieldName = 'TITLE'
              Width = 218
              Position.ColIndex = 1
              Position.RowIndex = 0
              Position.BandIndex = 0
              Summary.FooterSummaryItems = <>
              Summary.GroupFooterSummaryItems = <>
            end
          end
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = 'Produse eliminate'
        ImageIndex = 2
        OnHide = cxTabSheet2Hide
        OnShow = cxTabSheet2Show
        object cxGrid2: TcxGrid
          Left = 0
          Top = 0
          Width = 925
          Height = 406
          Align = alClient
          TabOrder = 0
          object cxGrid2DBTableViewOldGoods: TcxGridDBTableView
            DataController.DataSource = IBCDataSourceOldGoods
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '0'
                Kind = skCount
                Column = cxGrid2DBTableViewOldGoodsSUPPLIER_GOODS_CODE
              end>
            OptionsSelection.MultiSelect = True
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object cxGrid2DBTableViewOldGoodsSUPPLIER_GOODS_CODE: TcxGridDBColumn
              Caption = 'cod produs furnizor'
              DataBinding.FieldName = 'SUPPLIER_GOODS_CODE'
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
            object cxGrid2DBTableViewOldGoodsSUPPLIER_GOODS_NAME: TcxGridDBColumn
              Caption = 'Denumire produs'
              DataBinding.FieldName = 'SUPPLIER_GOODS_NAME'
              Width = 561
            end
            object cxGrid2DBTableViewOldGoodsNEW_PRICE0: TcxGridDBColumn
              Caption = 'Pret 0 '
              DataBinding.FieldName = 'NEW_PRICE0'
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGrid2DBTableViewOldGoodsNEW_PRICE7: TcxGridDBColumn
              Caption = 'Pret 7'
              DataBinding.FieldName = 'NEW_PRICE7'
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
          end
          object cxGrid2Level1: TcxGridLevel
            GridView = cxGrid2DBTableViewOldGoods
          end
        end
      end
      object cxTabSheet3: TcxTabSheet
        Caption = 'Preturi marite'
        ImageIndex = 3
        OnHide = cxTabSheet3Hide
        OnShow = cxTabSheet3Show
        DesignSize = (
          925
          406)
        object cxGrid4: TcxGrid
          Left = 3
          Top = 3
          Width = 919
          Height = 400
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 0
          object cxGridDBTableView2: TcxGridDBTableView
            DataController.DataSource = IBCDataSourcePricesUp
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '0'
                Kind = skCount
                Column = cxGridDBTableView2SUPPLIER_GOODS_CODE
                DisplayText = '0'
              end>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsSelection.MultiSelect = True
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object cxGridDBTableView2SUPPLIER_GOODS_CODE: TcxGridDBColumn
              Caption = 'cod produs furnizor'
              DataBinding.FieldName = 'SUPPLIER_GOODS_CODE'
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
            object cxGridDBTableView2SUPPLIER_GOODS_NAME: TcxGridDBColumn
              Caption = 'Denumire'
              DataBinding.FieldName = 'SUPPLIER_GOODS_NAME'
              Width = 577
            end
            object cxGridDBTableView2NEW_PRICE7: TcxGridDBColumn
              Caption = 'P.7 nou'
              DataBinding.FieldName = 'NEW_PRICE7'
              Width = 70
            end
            object cxGridDBTableView2OLD_PRICE7: TcxGridDBColumn
              Caption = 'P.7 vechi'
              DataBinding.FieldName = 'OLD_PRICE7'
            end
            object cxGridDBTableView2DEVIATION: TcxGridDBColumn
              Caption = 'Devierea'
              DataBinding.FieldName = 'DEVIATION'
              Width = 70
            end
          end
          object cxGridLevel2: TcxGridLevel
            GridView = cxGridDBTableView2
          end
        end
      end
      object cxTabSheet4: TcxTabSheet
        Caption = 'Preturi scazute'
        ImageIndex = 4
        OnHide = cxTabSheet4Hide
        OnShow = cxTabSheet4Show
        DesignSize = (
          925
          406)
        object cxGrid5: TcxGrid
          Left = 3
          Top = 3
          Width = 919
          Height = 400
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 0
          object cxGridDBTableView3: TcxGridDBTableView
            DataController.DataSource = IBCDataSourcePricesSown
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '0'
                Kind = skCount
                Column = cxGridDBTableView3SUPPLIER_GOODS_CODE
                DisplayText = '0'
              end>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsSelection.MultiSelect = True
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object cxGridDBTableView3SUPPLIER_GOODS_CODE: TcxGridDBColumn
              Caption = 'cod produs furnizor'
              DataBinding.FieldName = 'SUPPLIER_GOODS_CODE'
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
            object cxGridDBTableView3SUPPLIER_GOODS_NAME: TcxGridDBColumn
              Caption = 'Denumire produs'
              DataBinding.FieldName = 'SUPPLIER_GOODS_NAME'
              Width = 576
            end
            object cxGridDBTableView3NEW_PRICE0: TcxGridDBColumn
              Caption = 'Pret 0'
              DataBinding.FieldName = 'NEW_PRICE0'
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridDBTableView3NEW_PRICE7: TcxGridDBColumn
              Caption = 'Pret 7'
              DataBinding.FieldName = 'NEW_PRICE7'
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridDBTableView3DEVIATION: TcxGridDBColumn
              Caption = 'Deviere'
              DataBinding.FieldName = 'DEVIATION'
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
          end
          object cxGridLevel3: TcxGridLevel
            GridView = cxGridDBTableView3
          end
        end
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 1
      Top = 1
      Width = 933
      Height = 28
      Align = dalTop
      BarManager = dxBarManager1
    end
    object Panel3: TPanel
      Left = 1
      Top = 465
      Width = 933
      Height = 178
      Align = alBottom
      BevelKind = bkFlat
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
  object IBCQueryPriceItems: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      '/* toate produsele  */'
      
        'select PLI1.SUPPLIER_GOODS_CODE, PLI1.PRICE0 OLD_PRICE0, PLI1.PR' +
        'ICE7 OLD_PRICE7,'
      
        '       PLI2.SUPPLIER_GOODS_CODE, PLI2.PRICE0 NEW_PRICE0, PLI2.PR' +
        'ICE7 NEW_PRICE7,'
      
        '       iif( pli2.supplier_goods_code is null, pli1.supplier_good' +
        's_name, pli2.supplier_goods_name) supplier_goods_name,'
      '       iif( pli2.supplier_goods_code is null, '#39'old'#39','
      '         iif(pli1.supplier_goods_code is null, '#39'new'#39','
      '           iif(pli2.price7>pli1.price7, '#39'Up'#39','
      '              iif((pli2.price7=pli1.price7 ), '#39'='#39', '#39'<'#39')'
      '           )'
      '         )'
      '       ) GOODS_STATE'
      'from TS_PRICELIST_ITEMS PLI1'
      'full outer join TS_PRICELIST_ITEMS PLI2 on'
      '     (PLI1.SUPPLIER_GOODS_CODE = PLI2.SUPPLIER_GOODS_CODE) and'
      '     (pli2.PLID = :NEW_PLID)'
      'where PLI1.PLID = :OLD_PLID')
    Left = 688
    Top = 192
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NEW_PLID'
        Value = 27
      end
      item
        DataType = ftInteger
        Name = 'OLD_PLID'
        Value = 25
      end>
  end
  object IBCDataSourcePriceItems: TIBCDataSource
    DataSet = IBCQueryPriceItems
    Left = 688
    Top = 136
  end
  object IBCQueryOldPriceList: TIBCQuery
    SQL.Strings = (
      'select first 10 * from '
      
        '(select * from ts_pricelists where supplierid=:supplierid  order' +
        ' by plid desc)')
    Left = 72
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'supplierid'
        Value = nil
      end>
  end
  object IBCQueryCurrentPriceList: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select first 25 * from '
      
        '(select * from ts_pricelists where supplierid=:supplierid  order' +
        ' by plid desc)')
    Left = 56
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'supplierid'
        Value = nil
      end>
  end
  object IBCQueryOldGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* produse vechi  */'
      
        'select PLI2.SUPPLIER_GOODS_CODE, PLI2.PRICE0 NEW_PRICE0, PLI2.PR' +
        'ICE7 NEW_PRICE7, PLI2.SUPPLIER_GOODS_NAME'
      'from TS_PRICELIST_ITEMS PLI2'
      'where PLI2.PLID = :old_PLID and'
      '      not exists(select PLI1.SUPPLIER_GOODS_CODE'
      '                 from TS_PRICELIST_ITEMS PLI1'
      
        '                 where PLI1.PLID = :new_PLID and pli1.supplier_g' +
        'oods_code = pli2.supplier_goods_code)')
    Left = 296
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'old_PLID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'new_PLID'
        Value = nil
      end>
  end
  object IBCDataSourceOldGoods: TIBCDataSource
    DataSet = IBCQueryOldGoods
    Left = 296
    Top = 136
  end
  object IBCQueryPricesUp: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* produsele la care sau marit preturile  */'
      
        'select PLI2.SUPPLIER_GOODS_CODE, PLI2.PRICE0 NEW_PRICE0, PLI2.PR' +
        'ICE7 NEW_PRICE7, PLI1.PRICE7-PLI2.PRICE7 DEVIATION, PLI2.SUPPLIE' +
        'R_GOODS_NAME, PLI1.price7 old_price7'
      'from TS_PRICELIST_ITEMS PLI1'
      
        'inner join TS_PRICELIST_ITEMS PLI2 on PLI1.SUPPLIER_GOODS_CODE =' +
        ' PLI2.SUPPLIER_GOODS_CODE and coalesce(pli1.price7,0)<coalesce(p' +
        'li2.price7,0) and'
      '      PLI2.PLID = :NEW_PLID'
      'where PLI1.PLID = :OLD_PLID')
    Left = 440
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'new_PLID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'old_PLID'
        Value = nil
      end>
  end
  object IBCDataSourcePricesUp: TIBCDataSource
    DataSet = IBCQueryPricesUp
    Left = 440
    Top = 136
  end
  object IBCQueryPricesDown: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* produsele la care sau micsorat preturile  */'
      'select PLI2.SUPPLIER_GOODS_CODE, g.title SUPPLIER_GOODS_NAME, '
      
        '       PLI2.PRICE0 NEW_PRICE0, PLI2.PRICE7 NEW_PRICE7, PLI2.PRIC' +
        'E7 - PLI1.PRICE7 DEVIATION'
      'from TS_PRICELIST_ITEMS PLI1'
      
        'inner join TS_PRICELIST_ITEMS PLI2 on PLI1.SUPPLIER_GOODS_CODE =' +
        ' PLI2.SUPPLIER_GOODS_CODE and coalesce(pli1.price7,0) > coalesce' +
        '(pli2.price7,0) and'
      '      PLI2.PLID = :NEW_PLID'
      'inner join ts_goods g on g.goodsid=pli2.goodsid'
      'where PLI1.PLID = :OLD_PLID')
    Left = 552
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'new_PLID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'old_PLID'
        Value = nil
      end>
  end
  object IBCDataSourcePricesSown: TIBCDataSource
    DataSet = IBCQueryPricesDown
    Left = 552
    Top = 136
  end
  object IBCQueryNewGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select PLI1.*'
      'from TS_PRICELIST_ITEMS PLI1'
      'where PLI1.PLID = :NEW_PLID and'
      '      not exists(select 1'
      '                 from TS_PRICELIST_ITEMS PLI2'
      '                 where PLI2.PLID = :OLD_PLID and'
      
        '                       PLI2.SUPPLIER_GOODS_CODE = PLI1.SUPPLIER_' +
        'GOODS_CODE)')
    Left = 208
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'new_PLID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'OLD_PLID'
        Value = nil
      end>
  end
  object IBCDataSourceNewGoods: TIBCDataSource
    DataSet = IBCQueryNewGoods
    Left = 208
    Top = 136
  end
  object IBCDataSourceCurrentPriceList: TIBCDataSource
    DataSet = IBCQueryCurrentPriceList
    Left = 56
    Top = 128
  end
  object IBCDataSourceOldPriceList: TIBCDataSource
    DataSet = IBCQueryOldPriceList
    Left = 64
    Top = 240
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 296
    Top = 272
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1126
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbLinkGoods'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbLinkGoods: TdxBarButton
      Caption = 'Prelucreaza produsele'
      Category = 0
      Hint = 'Prelucreaza produsele'
      Visible = ivAlways
      ShortCut = 115
      OnClick = bbLinkGoodsClick
    end
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from vw_tdb_goods')
    Left = 976
    Top = 224
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 864
    Top = 224
  end
end
