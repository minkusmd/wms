inherited frame60PredvaritelnieZakazi: Tframe60PredvaritelnieZakazi
  Font.Height = -15
  PixelsPerInch = 120
  object cxGridPZDocs: TcxGrid
    Left = 0
    Top = 0
    Width = 986
    Height = 358
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridPZDocsTable: TcxGridDBTableView
      OnKeyDown = cxGridPZDocsTableKeyDown
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
      OnCellDblClick = cxGridPZDocsTableCellDblClick
      OnCustomDrawCell = cxGridPZDocsTableCustomDrawCell
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
      object cxGridPZDocs_DOCID: TcxGridDBColumn
        Caption = 'Cod doc'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridPZDocs_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = cxGridPZDocs_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridPZDocs_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 80
        Width = 100
      end
      object cxGridPZDocs_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.Focusing = False
        Options.HorzSizing = False
        Width = 50
      end
    end
    object cxGridPZDocsLevel: TcxGridLevel
      GridView = cxGridPZDocsTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 358
    Width = 986
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 200
    Control = pnBottom
  end
  object pnBottom: TPanel
    Left = 0
    Top = 368
    Width = 986
    Height = 300
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object cxGridGoods: TcxGrid
      Left = 0
      Top = 34
      Width = 986
      Height = 266
      Align = alClient
      TabOrder = 1
      object cxGridGoodsTable: TcxGridDBTableView
        OnCellDblClick = cxGridGoodsTableCellDblClick
        OnCustomDrawCell = cxGridGoodsTableCustomDrawCell
        OnFocusedRecordChanged = cxGridGoodsTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceGoods
        DataController.KeyFieldNames = 'DOCID;GOODSID'
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGridGoods_GOODSID
          end>
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
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
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridGoods_FLG_CLOSED: TcxGridDBColumn
          Caption = 'Proforma Furnizor'
          DataBinding.FieldName = 'FLG_CLOSED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridGoods_FLG_APPROVED: TcxGridDBColumn
          Caption = 'Confirmat'
          DataBinding.FieldName = 'FLG_APPROVED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 70
        end
        object cxGridGoods_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 60
        end
        object cxGridGoods_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 12
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Focusing = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 24
        end
        object cxGridGoods_GOODS_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'GOODS_TITLE'
          VisibleForCustomization = False
          Width = 200
        end
        object cxGridGoods_QTY: TcxGridDBColumn
          AlternateCaption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 60
        end
        object cxGridGoods_SELL_PRICE: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'SELL_PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridGoods_SELL_CURRENCY_TITLE: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'SELL_CURRENCY_TITLE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridGoods_FLG_ACNT: TcxGridDBColumn
          Caption = 'Cnt'
          DataBinding.FieldName = 'FLG_ACNT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 34
          Options.HorzSizing = False
          Width = 34
        end
        object cxGridGoods_CREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Creat de'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          Width = 80
        end
        object cxGridGoods_SUPPLIER_QTY: TcxGridDBColumn
          AlternateCaption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1086#1089#1090#1091#1087#1085#1086
          Caption = 'Cant disponibil'
          DataBinding.FieldName = 'SUPPLIER_QTY'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridGoods_SUPPLIER_TITLE: TcxGridDBColumn
          Caption = 'Furnizor'
          DataBinding.FieldName = 'SUPPLIER_TITLE'
          OnGetDisplayText = cxGridGoods_SUPPLIER_TITLEGetDisplayText
          Styles.Content = dmAdditions.cxStyle_EventGrid
          Width = 100
        end
        object cxGridGoods_SUPPLIER_PRICE: TcxGridDBColumn
          AlternateCaption = #1062#1077#1085#1072' '#1091' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
          Caption = 'Pret furnizor'
          DataBinding.FieldName = 'SUPPLIER_PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00'
          OnGetDisplayText = cxGridGoods_SUPPLIER_TITLEGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridGoods_SUPRLIER_CURRENCY_TITLE: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'SUPRLIER_CURRENCY_TITLE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          OnGetDisplayText = cxGridGoods_SUPPLIER_TITLEGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridGoods_STOCK_QTY: TcxGridDBColumn
          Caption = 'Sold'
          DataBinding.FieldName = 'STOCK_QTY'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridGoods_ACNT_QTY: TcxGridDBColumn
          AlternateCaption = #1054#1089#1090#1072#1090#1086#1082' '#1087#1086'  '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
          Caption = 'Sold Cnt'
          DataBinding.FieldName = 'ACNT_QTY'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridGoods_APPROVED_BY_NAME: TcxGridDBColumn
          Caption = 'Confirmat de'
          DataBinding.FieldName = 'APPROVED_BY_NAME'
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object cxGridGoods_SUPPLIER_ID: TcxGridDBColumn
          DataBinding.FieldName = 'SUPPLIER_ID'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridGoodsLevel: TcxGridLevel
        GridView = cxGridGoodsTable
      end
    end
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
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 632
    Top = 104
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
      FloatLeft = 1062
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsAdd'
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
          ItemName = 'bbGoodsRemove'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSubItemsTools'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbGoodsAdd: TdxBarButton
      Caption = 'Produs nou'
      Category = 0
      Hint = 'Produs nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbGoodsAddClick
    end
    object bbGoodsEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbGoodsEditClick
    end
    object bbGoodsRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbGoodsRemoveClick
    end
    object bbGoodsApprove: TdxBarButton
      Caption = 'Confirmarea produsului din precomanda'
      Category = 0
      Hint = 'Confirmarea produsului din precomanda'
      Visible = ivAlways
      ImageIndex = 25
      ShortCut = 16469
      OnClick = bbGoodsApproveClick
    end
    object bbCloseDoc: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      ShortCut = 120
    end
    object bbOpenDoc: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
    end
    object bbRecalcQTY: TdxBarButton
      Caption = 'Refresh cantitate in stoc'
      Category = 0
      Hint = 'Refresh cantitate in stoc'
      Visible = ivAlways
      ImageIndex = 36
      OnClick = bbRecalcQTYClick
    end
    object bbSubItemsTools: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsApprove'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRecalcQTY'
        end>
    end
    object bbCreateVhodnieSceta: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' "'#1042#1093#1086#1076#1085#1099#1077' '#1089#1095#1077#1090#1072'"...'
      Category = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' "'#1042#1093#1086#1076#1085#1099#1077' '#1089#1095#1077#1090#1072'"'
      Visible = ivAlways
      OnClick = bbCreateVhodnieScetaClick
    end
  end
  object IBCQueryGoods: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_GOODS_PREORDER'
      
        '  (DOCID, GOODSID, QTY, SELL_PRICE, SELL_CURRENCY_ID, FLG_ACNT, ' +
        'FLG_APPROVED, FLG_CLOSED, SUPPLIER_ID, SUPPLIER_QTY, SUPPLIER_PR' +
        'ICE, SUPRLIER_CURRENCY_ID)'
      'VALUES'
      
        '  (:DOCID, :GOODSID, :QTY, :SELL_PRICE, :SELL_CURRENCY_ID, :FLG_' +
        'ACNT, :FLG_APPROVED, :FLG_CLOSED, :SUPPLIER_ID, :SUPPLIER_QTY, :' +
        'SUPPLIER_PRICE, :SUPRLIER_CURRENCY_ID)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_GOODS_PREORDER'
      'WHERE'
      '  DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_GOODS_PREORDER'
      'SET'
      '  DOCID = :DOCID, '
      '  GOODSID = :GOODSID, '
      '  QTY = :QTY, '
      '  SELL_PRICE = :SELL_PRICE, '
      '  SELL_CURRENCY_ID = :SELL_CURRENCY_ID, '
      '  FLG_ACNT = :FLG_ACNT, '
      '  FLG_APPROVED = :FLG_APPROVED,'
      '  FLG_CLOSED = :FLG_CLOSED,'
      '  SUPPLIER_ID = :SUPPLIER_ID, '
      '  SUPPLIER_QTY = :SUPPLIER_QTY, '
      '  SUPPLIER_PRICE = :SUPPLIER_PRICE, '
      '  SUPRLIER_CURRENCY_ID = :SUPRLIER_CURRENCY_ID'
      'WHERE'
      '  DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' DOCID,'
      ' GOODSID,'
      ' GOODS_TITLE,'
      ' QTY,'
      ' SELL_PRICE,'
      ' SELL_CURRENCY_ID,'
      ' SELL_CURRENCY_TITLE,'
      ' FLG_ACNT,'
      ' FLG_APPROVED,'
      ' FLG_CLOSED,'
      ' SUPPLIER_ID,'
      ' SUPPLIER_TITLE,'
      ' SUPPLIER_QTY,'
      ' SUPPLIER_PRICE,'
      ' SUPRLIER_CURRENCY_ID,'
      ' SUPRLIER_CURRENCY_TITLE,'
      ' STOCK_QTY,'
      ' ACNT_QTY,'
      ' CREATE_DATE,'
      ' CREATED_BY,'
      ' CREATED_BY_NAME,'
      ' APPROVE_DATE,'
      ' APPROVED_BY,'
      ' APPROVED_BY_NAME '
      'FROM '
      ' VW_TDB_GOODS_PREORDER'
      'WHERE'
      ' (DOCID = :DOCID) AND (GOODSID = :GOODSID)')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_GOODS_PREORDER'
      'WHERE'
      'DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_GOODS_PREORDER'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' DOCID,'
      ' GOODSID,'
      ' GOODS_TITLE,'
      ' QTY,'
      ' SELL_PRICE,'
      ' SELL_CURRENCY_ID,'
      ' SELL_CURRENCY_TITLE,'
      ' FLG_ACNT,'
      ' FLG_APPROVED,'
      ' FLG_CLOSED,'
      ' SUPPLIER_ID,'
      ' SUPPLIER_TITLE,'
      ' SUPPLIER_QTY,'
      ' SUPPLIER_PRICE,'
      ' SUPRLIER_CURRENCY_ID,'
      ' SUPRLIER_CURRENCY_TITLE,'
      ' STOCK_QTY,'
      ' ACNT_QTY,'
      ' CREATE_DATE,'
      ' CREATED_BY,'
      ' CREATED_BY_NAME,'
      ' APPROVE_DATE,'
      ' APPROVED_BY,'
      ' APPROVED_BY_NAME '
      'FROM '
      ' VW_TDB_GOODS_PREORDER')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    Left = 200
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 200
    Top = 228
  end
  object dxBarPopupMenuDocs: TdxBarPopupMenu
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
        ItemName = 'bbCreateVhodnieSceta'
      end>
    UseOwnFont = False
    Left = 512
    Top = 112
    PixelsPerInch = 120
  end
  object cxGridPopupMenuDocs: TcxGridPopupMenu
    Grid = cxGridPZDocs
    PopupMenus = <
      item
        GridView = cxGridPZDocsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuDocs
      end>
    Left = 368
    Top = 104
  end
  object dxBarPopupMenuGrid: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCreateVhodnieSceta'
      end>
    UseOwnFont = False
    Left = 516
    Top = 168
    PixelsPerInch = 120
  end
  object cxGridPopupMenuGrid: TcxGridPopupMenu
    Grid = cxGridPZDocs
    PopupMenus = <
      item
        GridView = cxGridPZDocsTable
        HitTypes = [gvhtGridNone, gvhtNone]
        Index = 0
        PopupMenu = dxBarPopupMenuGrid
      end>
    Left = 364
    Top = 164
  end
end
