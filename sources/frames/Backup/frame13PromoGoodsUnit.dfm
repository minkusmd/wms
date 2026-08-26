inherited frame13PromoGoods: Tframe13PromoGoods
  Width = 1200
  Height = 655
  object cxGridPromoGoods: TcxGrid
    Left = 0
    Top = 30
    Width = 1200
    Height = 625
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    ExplicitWidth = 451
    ExplicitHeight = 274
    object cxGridPromoGoodsTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu
      OnKeyDown = cxGridPromoGoodsTableKeyDown
      NavigatorButtons.ConfirmDelete = False
      OnCellDblClick = cxGridPromoGoodsTableCellDblClick
      OnFocusedRecordChanged = cxGridPromoGoodsTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourcePromoGoods
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.GroupRowStyle = grsOffice11
      OptionsView.Indicator = True
      Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.OnGetGroupStyle = cxGridPromoGoodsTableStylesGetGroupStyle
      object cxGridPromoGoods_GOODSID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridPromoGoods_GOODS_NAME: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
        DataBinding.FieldName = 'GOODS_NAME'
      end
      object cxGridPromoGoods_DATA_START: TcxGridDBColumn
        Caption = #1053#1072#1095#1072#1083#1086
        DataBinding.FieldName = 'DATA_START'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridPromoGoods_DATA_END: TcxGridDBColumn
        Caption = #1050#1086#1085#1077#1094
        DataBinding.FieldName = 'DATA_END'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridPromoGoods_DATA_GROUP: TcxGridDBColumn
        Caption = #1055#1088#1086#1084#1086' '#1087#1077#1088#1080#1086#1076
        DataBinding.FieldName = 'DATA_GROUP'
        Visible = False
        OnGetDisplayText = cxGridPromoGoods_DATA_GROUPGetDisplayText
        GroupIndex = 0
      end
      object cxGridPromoGoods_QTY_AVAILABLE: TcxGridDBColumn
        Caption = #1054#1089#1090#1072#1090#1086#1082
        DataBinding.FieldName = 'QTY_AVAILABLE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
    end
    object cxGridPromoGoodsLevel: TcxGridLevel
      GridView = cxGridPromoGoodsTable
    end
  end
  object dxBarDockControl1: TdxBarDockControl
    Left = 0
    Top = 0
    Width = 1200
    Height = 30
    Align = dalTop
    BarManager = dxBarManager
    SunkenBorder = True
    UseOwnSunkenBorder = True
    ExplicitWidth = 451
  end
  object IBCQueryPromoGoods: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_PROMO_GOODS'
      '  (GOODSID, DATA_START, DATA_END, DATA_GROUP)'
      'VALUES'
      '  (:GOODSID, :DATA_START, :DATA_END, :DATA_GROUP)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_PROMO_GOODS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_PROMO_GOODS'
      'SET'
      
        '  GOODSID = :GOODSID, DATA_START = :DATA_START, DATA_END = :DATA' +
        '_END, DATA_GROUP = :DATA_GROUP'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' GOODSID,'
      ' DATA_START,'
      ' DATA_END,'
      ' DATA_GROUP,'
      ' GOODS_NAME,'
      ' QTY_AVAILABLE'
      'FROM'
      ' VW_TDB_PROMO_GOODS'
      'WHERE'
      '  GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TDB_PROMO_GOODS'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' GOODSID,'
      ' DATA_START,'
      ' DATA_END,'
      ' DATA_GROUP,'
      ' GOODS_NAME,'
      ' QTY_AVAILABLE'
      'FROM'
      ' VW_TDB_PROMO_GOODS')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 248
    Top = 200
  end
  object IBCDataSourcePromoGoods: TIBCDataSource
    DataSet = IBCQueryPromoGoods
    Left = 248
    Top = 152
  end
  object dxBarManager: TdxBarManager
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
    Left = 436
    Top = 96
    DockControlHeights = (
      0
      0
      0
      0)
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Goods'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 745
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddPromoGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemove'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbAddPromoGoods: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbAddPromoGoodsClick
    end
    object bbRemove: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbRemoveClick
    end
    object bbModify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyClick
    end
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbAddPromoGoods'
      end
      item
        Visible = True
        ItemName = 'bbModify'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbRemove'
      end>
    UseOwnFont = False
    Left = 120
    Top = 108
  end
end
