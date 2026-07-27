inherited frame55VozvratPriemService: Tframe55VozvratPriemService
  Font.Height = -15
  PixelsPerInch = 120
  object cxGridDocs: TcxGrid
    Left = 0
    Top = 0
    Width = 986
    Height = 397
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridDocsTable: TcxGridDBTableView
      OnKeyDown = cxGridDocsTableKeyDown
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      OnCustomDrawCell = cxGridDocsTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.NavigatorOffset = 63
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGrid_FLG_CLOSED: TcxGridDBColumn
        Caption = #1047#1072#1082#1088#1099#1090
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGrid_DOCID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGrid_DATA: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGrid_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 110
        Options.HorzSizing = False
        Width = 110
      end
      object cxGrid_DTDEP_NAME: TcxGridDBColumn
        Caption = #1057#1082#1083#1072#1076
        DataBinding.FieldName = 'DTDEP_NAME'
        Width = 100
      end
      object cxGrid_DT_NAME: TcxGridDBColumn
        Caption = #1060#1080#1088#1084#1072
        DataBinding.FieldName = 'DT_NAME'
        Width = 150
      end
      object cxGridDocs_CT_NAME: TcxGridDBColumn
        Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
        DataBinding.FieldName = 'CT_NAME'
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 200
      end
      object cxGrid_SUMA: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 70
      end
      object cxGrid_CURRENCY_NAME: TcxGridDBColumn
        Caption = #1042#1072#1083#1102#1090#1072
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGrid_VAT: TcxGridDBColumn
        Caption = #1053#1044#1057
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 70
      end
      object cxGrid_RATE: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' '#1044#1086#1082'.'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGrid_PARENTDOCID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGrid_FLG_ACNT: TcxGridDBColumn
        Caption = #1041#1091#1093#1075'.'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGrid_CREATED_BY_NAME: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 80
      end
    end
    object cxGridDocsLevel: TcxGridLevel
      GridView = cxGridDocsTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 407
    Width = 986
    Height = 261
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 986
      Height = 34
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridGoods: TcxGrid
      Left = 0
      Top = 34
      Width = 986
      Height = 227
      Align = alClient
      TabOrder = 1
      object cxGridGoodsTable: TcxGridDBBandedTableView
        OnKeyDown = cxGridGoodsTableKeyDown
        OnCustomDrawCell = cxGridGoodsTableCustomDrawCell
        DataController.DataSource = IBCDataSourceGoods
        DataController.KeyFieldNames = 'ROWID'
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = cxGridGoods_DT_PRICE
          end
          item
            Kind = skSum
            Column = cxGridGoods_CT_PRICE
          end
          item
            Kind = skCount
            Column = cxGridGoods_DT_GOODS_TITLE
          end>
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NavigatorOffset = 63
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        OptionsView.FixedBandSeparatorWidth = 3
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        Bands = <
          item
            Caption = #1058#1054#1042#1040#1056' '#1044#1051#1071' '#1047#1040#1052#1045#1053#1067
            Styles.Content = dmAdditions.cxStyle_MarginGroup
          end
          item
            Caption = #1058#1054#1042#1040#1056' '#1053#1040' '#1047#1040#1052#1045#1053#1059
          end>
        object cxGridGoods_DT_DEP_TITLE: TcxGridDBBandedColumn
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'DT_DEP_TITLE'
          Width = 100
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxGridGoods_DT_GOODSID: TcxGridDBBandedColumn
          Caption = #1050#1086#1076' '#1090#1086#1074'.'
          DataBinding.FieldName = 'DT_GOODSID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxGridGoods_DT_GOODS_TITLE: TcxGridDBBandedColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'DT_GOODS_TITLE'
          Width = 300
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxGridGoods_DT_IDENT: TcxGridDBBandedColumn
          Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          DataBinding.FieldName = 'DT_IDENT'
          Width = 100
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxGridGoods_DT_PRICE: TcxGridDBBandedColumn
          Caption = #1062#1077#1085#1072
          DataBinding.FieldName = 'DT_PRICE'
          Width = 80
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxGridGoods_DT_CREATED_BY_NAME: TcxGridDBBandedColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'DT_CREATED_BY_NAME'
          Visible = False
          Width = 80
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxGridGoods_CT_DEP_TITLE: TcxGridDBBandedColumn
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'CT_DEP_TITLE'
          Width = 100
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxGridGoods_CT_GOODSID: TcxGridDBBandedColumn
          Caption = #1050#1086#1076' '#1090#1086#1074'.'
          DataBinding.FieldName = 'CT_GOODSID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxGridGoods_CT_DATE: TcxGridDBBandedColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'CT_DATE'
          Visible = False
          OnGetDisplayText = cxGridGoods_CT_DATEGetDisplayText
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxGridGoods_CT_IDENT: TcxGridDBBandedColumn
          Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          DataBinding.FieldName = 'CT_IDENT'
          Width = 100
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxGridGoods_CT_PRICE: TcxGridDBBandedColumn
          Caption = #1062#1077#1085#1072
          DataBinding.FieldName = 'CT_PRICE'
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object cxGridGoods_CT_GOODS_TITLE: TcxGridDBBandedColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'CT_GOODS_TITLE'
          Width = 300
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxGridGoods_CT_CREATED_BY_NAME: TcxGridDBBandedColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CT_CREATED_BY_NAME'
          Visible = False
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
      end
      object cxGridGoodsLevel: TcxGridLevel
        GridView = cxGridGoodsTable
      end
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 397
    Width = 986
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 300
    Control = pnBottom
  end
  object cxGridDocsPopupMenu: TcxGridPopupMenu
    Grid = cxGridDocs
    PopupMenus = <
      item
        GridView = cxGridDocsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmDocs
      end>
    Left = 412
    Top = 108
  end
  object dxBarManager1: TdxBarManager
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 608
    Top = 72
    PixelsPerInch = 120
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1094
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsDelete'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbCloseDoc: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbCloseDocClick
    end
    object bbOpenDoc: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      OnClick = bbOpenDocClick
    end
    object bbGoodsNew: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1090#1086#1074#1072#1088
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbGoodsNewClick
    end
    object bbGoodsEdit: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbGoodsEditClick
    end
    object bbGoodsDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbGoodsDeleteClick
    end
    object bbTargetGoods: TdxBarButton
      Caption = #1053#1077#1079#1072#1082#1088#1099#1090#1099#1077' '#1090#1086#1074#1072#1088#1099' '#1091' '#1092#1080#1088#1084#1099
      Category = 0
      Hint = #1053#1077#1079#1072#1082#1088#1099#1090#1099#1077' '#1090#1086#1074#1072#1088#1099' '#1091' '#1092#1080#1088#1084#1099
      Visible = ivAlways
      ImageIndex = 27
      ShortCut = 16462
      OnClick = bbTargetGoodsClick
    end
  end
  object IBCQueryGoods: TIBCQuery
    KeyFields = 'ROWID'
    KeyGenerator = 'SQ_TDB_JURNAL_SP_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_JURNAL_SP'
      '  (ROWID, DOCID, '
      
        '   DT_DEP, DT_GOODSID, DT_IDENT, DT_PRICE, DT_GOODS_SERIAL_TYPE,' +
        ' DT_FLG_BALANCE, DT_FLG_PERESORT, '
      
        '   CT_DEP, CT_GOODSID, CT_IDENT, CT_PRICE, CT_GOODS_SERIAL_TYPE,' +
        ' CT_FLG_BALANCE, CT_FLG_PERESORT,'
      '   DT_COUNTRYID, DT_VENDORID, CT_COUNTRYID, CT_VENDORID)'
      'VALUES'
      '  (:ROWID, :DOCID, '
      
        '   :DT_DEP, :DT_GOODSID, :DT_IDENT, :DT_PRICE, :DT_GOODS_SERIAL_' +
        'TYPE, :DT_FLG_BALANCE, :DT_FLG_PERESORT, '
      
        '   :CT_DEP, :CT_GOODSID, :CT_IDENT, :CT_PRICE, :CT_GOODS_SERIAL_' +
        'TYPE, :CT_FLG_BALANCE, :CT_FLG_PERESORT,'
      '   :DT_COUNTRYID, :DT_VENDORID, :CT_COUNTRYID, :CT_VENDORID)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_JURNAL_SP'
      'WHERE'
      '  ROWID = :Old_ROWID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_JURNAL_SP'
      'SET'
      '  ROWID = :ROWID, '
      '  DOCID = :DOCID, '
      ''
      '  DT_DEP = :DT_DEP, '
      '  DT_GOODSID = :DT_GOODSID, '
      '  DT_IDENT = :DT_IDENT, '
      '  DT_PRICE = :DT_PRICE, '
      '  DT_GOODS_SERIAL_TYPE = :DT_GOODS_SERIAL_TYPE, '
      '  DT_FLG_BALANCE = :DT_FLG_BALANCE, '
      '  DT_FLG_PERESORT = :DT_FLG_PERESORT, '
      ''
      '  CT_DEP = :CT_DEP, '
      '  CT_GOODSID = :CT_GOODSID, '
      '  CT_IDENT = :CT_IDENT, '
      '  CT_PRICE = :CT_PRICE, '
      '  CT_GOODS_SERIAL_TYPE = :CT_GOODS_SERIAL_TYPE, '
      '  CT_FLG_BALANCE = :CT_FLG_BALANCE, '
      '  CT_FLG_PERESORT = :CT_FLG_PERESORT,'
      ''
      '  DT_COUNTRYID = :DT_COUNTRYID,'
      '  CT_COUNTRYID = :CT_COUNTRYID,'
      '  DT_VENDORID = :DT_VENDORID,'
      '  CT_VENDORID = :CT_VENDORID'
      ''
      'WHERE'
      '  ROWID = :Old_ROWID')
    SQLRefresh.Strings = (
      'SELECT '
      ' *'
      'FROM VW_TDB_JURNAL_SP'
      'WHERE'
      '  ROWID = :ROWID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_JURNAL_SP'
      'WHERE'
      'ROWID = :Old_ROWID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' *'
      'FROM VW_TDB_JURNAL_SP')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 500
    Left = 208
    Top = 236
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 204
    Top = 296
  end
  object pmDocs: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDoc'
      end
      item
        Visible = True
        ItemName = 'bbOpenDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbTargetGoods'
      end>
    UseOwnFont = False
    Left = 412
    Top = 244
    PixelsPerInch = 120
  end
end
