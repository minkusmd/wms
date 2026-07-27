inherited frame50Realizatia: Tframe50Realizatia
  Width = 1070
  Height = 603
  Font.Height = -15
  ExplicitWidth = 1070
  ExplicitHeight = 603
  PixelsPerInch = 120
  object cxGridRealizatia: TcxGrid
    Left = 0
    Top = 0
    Width = 1070
    Height = 303
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridRealizatiaTable: TcxGridDBTableView
      OnKeyDown = cxGridRealizatiaTableKeyDown
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
      OnCellDblClick = cxGridRealizatiaTableCellDblClick
      OnCustomDrawCell = cxGridRealizatiaTableCustomDrawCell
      DataController.DataSource = dmDB.IBCDataSourceDocs
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
      object cxGridRealizatia_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridRealizatia_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridRealizatia_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridRealizatia_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridRealizatia_CT_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 200
      end
      object cxGridRealizatia_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridRealizatia_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridRealizatia_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridRealizatia_RATE: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridRealizatia_RATEUSD: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridRealizatia_FLG_ACNT: TcxGridDBColumn
        Caption = #1041#1091#1093#1075
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taCenter
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 40
      end
      object cxGridRealizatia_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Operator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 100
      end
      object cxGridRealizatia_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridRealizatiaLevel: TcxGridLevel
      GridView = cxGridRealizatiaTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 313
    Width = 1070
    Height = 290
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1070
      Height = 34
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridGoods: TcxGrid
      Left = 0
      Top = 34
      Width = 1070
      Height = 256
      Align = alClient
      TabOrder = 1
      object cxGridGoodsTable: TcxGridDBTableView
        OnKeyDown = cxGridGoodsTableKeyDown
        OnCellDblClick = cxGridGoodsTableCellDblClick
        OnCustomDrawCell = cxGridGoodsTableCustomDrawCell
        DataController.DataSource = IBCDataSourceJurnalR
        DataController.KeyFieldNames = 'DOCID;GOODSID'
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = cxGridGoods_QTY
          end
          item
            Kind = skCount
            Column = cxGridGoods_GOODSID
          end>
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
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
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridGoods_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridGoods_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <>
          MinWidth = 24
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 24
        end
        object cxGridGoods_GOODS_TITLE: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_TITLE'
          Width = 200
        end
        object cxGridGoods_QTY: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridGoods_PRICE: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridGoods_SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridGoods_FLG_READY: TcxGridDBColumn
          Caption = 'Gata'
          DataBinding.FieldName = 'FLG_READY'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridGoods_GOODS_ACNT_ID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
          Caption = 'Cod cntb'
          DataBinding.FieldName = 'GOODS_ACNT_ID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridGoods_GOODS_NAMEACNT: TcxGridDBColumn
          Caption = 'Denumire cntb'
          DataBinding.FieldName = 'GOODS_NAMEACNT'
          MinWidth = 50
          Width = 70
        end
      end
      object cxGridGoodsLevel: TcxGridLevel
        GridView = cxGridGoodsTable
      end
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 303
    Width = 1070
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 200
    Control = pnBottom
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 528
    Top = 92
    PixelsPerInch = 120
    object dxBarGoods: TdxBar
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
      FloatLeft = 899
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
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsSerials'
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
    object bbGoodsSerials: TdxBarButton
      Caption = 'Serii / partide'
      Category = 0
      Hint = 'Serii / partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbGoodsSerialsClick
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
    object bbDocComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'...'
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbCustomerDebts: TdxBarButton
      Caption = #1058#1077#1082#1091#1097#1080#1077' '#1076#1086#1083#1075#1080' '#1082#1083#1080#1077#1085#1090#1072'...'
      Category = 0
      Hint = #1058#1077#1082#1091#1097#1080#1077' '#1076#1086#1083#1075#1080' '#1082#1083#1080#1077#1085#1090#1072
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
  end
  object pmRealizatia: TdxBarPopupMenu
    BarManager = dxBarManager
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
        ItemName = 'bbDocComments'
      end
      item
        Visible = True
        ItemName = 'bbCustomerDebts'
      end>
    UseOwnFont = False
    Left = 524
    Top = 212
    PixelsPerInch = 120
  end
  object cxGridPopupMenuDoc: TcxGridPopupMenu
    Grid = cxGridRealizatia
    PopupMenus = <
      item
        GridView = cxGridRealizatiaTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmRealizatia
      end>
    Left = 384
    Top = 144
  end
  object IBCQueryJurnalR: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_JURNAL_R'
      '  (DOCID, GOODSID, QTY, PRICE)'
      'VALUES'
      '  (:DOCID, :GOODSID, :QTY, :PRICE)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_JURNAL_R'
      'WHERE'
      '  DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TDB_JURNAL_R'
      'SET'
      '  DOCID = :DOCID, GOODSID = :GOODSID, QTY = :QTY, PRICE = :PRICE'
      'WHERE'
      '  DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT '
      '*'
      'FROM '
      ' VW_TDB_JURNAL_R'
      'WHERE'
      ' DOCID = :DOCID '
      ' AND '
      ' GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_JURNAL_R'
      'WHERE'
      'DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      ' VW_TDB_JURNAL_R')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    Left = 100
    Top = 536
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnalR: TIBCDataSource
    DataSet = IBCQueryJurnalR
    Left = 100
    Top = 484
  end
end
