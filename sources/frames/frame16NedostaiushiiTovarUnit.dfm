inherited frame16NedostaiushiiTovar: Tframe16NedostaiushiiTovar
  Width = 1453
  Height = 638
  Font.Height = -15
  ExplicitWidth = 1453
  ExplicitHeight = 638
  PixelsPerInch = 120
  object cxGridGoods: TcxGrid
    AlignWithMargins = True
    Left = 308
    Top = 0
    Width = 1145
    Height = 638
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = True
    object cxGridGoodsTable: TcxGridDBTableView
      OnKeyDown = cxGridGoodsTableKeyDown
      DataController.DataModeController.GridMode = True
      DataController.DataSource = IBCDataSourceGoods
      DataController.KeyFieldNames = 'GOODSID'
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NavigatorOffset = 63
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090#1091' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridGoodsTable_GOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridGoodsTable_PARENT_TITLE: TcxGridDBColumn
        Caption = 'Grupa'
        DataBinding.FieldName = 'PARENT_TITLE'
        Visible = False
        GroupIndex = 0
      end
      object cxGridGoodsTable_TITLE: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'GOODS_TITLE'
      end
      object cxGridGoodsTable_QTY: TcxGridDBColumn
        Caption = 'Cantitate'
        DataBinding.FieldName = 'QTY'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 70
      end
      object cxGridGoodsTable_PARENTID: TcxGridDBColumn
        DataBinding.FieldName = 'PARENTID'
        Visible = False
        MinWidth = 80
        Options.HorzSizing = False
      end
    end
    object cxGridGoodsLevel: TcxGridLevel
      GridView = cxGridGoodsTable
    end
  end
  object pnStocks: TPanel
    Left = 0
    Top = 0
    Width = 305
    Height = 638
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object CheckTree: TRzCheckTree
      Left = 0
      Top = 34
      Width = 305
      Height = 604
      Images = dmAdditions.cxImageList_SWN
      Align = alClient
      Indent = 21
      SelectionPen.Color = clBtnShadow
      ShowRoot = False
      StateImages = CheckTree.CheckImages
      TabOrder = 1
      OnCollapsing = CheckTreeCollapsing
      ExplicitTop = 38
      ExplicitHeight = 600
    end
    object dxBarDockControl: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 305
      Height = 34
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
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
    Left = 368
    Top = 92
    PixelsPerInch = 120
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl
      DockedDockControl = dxBarDockControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 781
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRefresh'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbRefresh: TdxBarButton
      Caption = 'Refresh'
      Category = 0
      Hint = 'Refresh'
      Visible = ivAlways
      ImageIndex = 36
      OnClick = bbRefreshClick
    end
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' GOODSID,'
      ' PARENTID,'
      ' QTY,'
      ' GOODS_TITLE,'
      ' PARENT_TITLE'
      'FROM'
      ' GET_GOODS_QTY_BY_STOCK_LIST(:DT,:DTDEPLIST)'
      'ORDER BY'
      ' PARENT_TITLE, PARENTID, QTY')
    Left = 572
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DTDEPLIST'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 572
    Top = 116
  end
end
