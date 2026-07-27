object frameGoodsStock: TframeGoodsStock
  Left = 0
  Top = 0
  Width = 1039
  Height = 553
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  TabOrder = 0
  PixelsPerInch = 120
  object cxTree: TcxTreeList
    Left = 0
    Top = 0
    Width = 1039
    Height = 553
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    Bands = <
      item
        MinWidth = 25
      end>
    Images = dmAdditions.cxImageList_SWN
    OptionsBehavior.ChangeDelay = 1000
    OptionsSelection.CellSelect = False
    OptionsView.ColumnAutoWidth = True
    OptionsView.FixedSeparatorWidth = 3
    OptionsView.IndicatorWidth = 15
    OptionsView.NavigatorOffset = 63
    Preview.LeftIndent = 6
    Preview.RightIndent = 6
    ScrollbarAnnotations.CustomAnnotations = <>
    Styles.OnGetContentStyle = cxTreeStylesGetContentStyle
    Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
    TabOrder = 0
    OnDblClick = cxTreeDblClick
    object cxTree_TITLE: TcxTreeListColumn
      Caption.Text = 'Depozit'
      MinWidth = 25
      Width = 125
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxTree_QTY: TcxTreeListColumn
      PropertiesClassName = 'TcxCalcEditProperties'
      Properties.Alignment.Horz = taRightJustify
      Caption.AlignHorz = taCenter
      Caption.Text = 'Sold'
      DataBinding.ValueType = 'Float'
      MinWidth = 25
      Options.Sizing = False
      Width = 100
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxTree_STOCKID: TcxTreeListColumn
      Visible = False
      DataBinding.ValueType = 'Integer'
      MinWidth = 25
      Width = 125
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object IBCQueryStockQTY: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' STOCKID,'
      ' PARENTID,'
      ' FLG_FOLDER,'
      ' TITLE,'
      ' QTY'
      'FROM'
      ' GET_GOODS_QTY_BY_STOCK(:GOODSID,:DT)'
      'ORDER BY QTY DESC')
    Left = 88
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
end
