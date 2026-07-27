object frmWebCatalogFiltersDlg: TfrmWebCatalogFiltersDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1060#1080#1083#1100#1090#1088#1099' '#1074#1077#1073' '#1082#1072#1090#1072#1083#1086#1075#1072
  ClientHeight = 556
  ClientWidth = 1055
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    1055
    556)
  TextHeight = 15
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 593
    Height = 432
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxGridFilters: TcxGrid
      Left = 0
      Top = 86
      Width = 589
      Height = 342
      Align = alClient
      TabOrder = 2
      object cxGridFiltersTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridFiltersTableCellDblClick
        OnFocusedRecordChanged = cxGridFiltersTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceFilters
        DataController.KeyFieldNames = 'CATALOGID;FILTERID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridFilters_IMAGE: TcxGridDBColumn
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 26
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 24
        end
        object cxGridFilters_FILTERID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'FILTERID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridFilters_FILTERNAME_ROM: TcxGridDBColumn
          Caption = 'Filtru'
          DataBinding.FieldName = 'FILTERNAME_ROM'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 100
        end
        object cxGridFilters_FILTERNAME_RUS: TcxGridDBColumn
          Caption = #1060#1080#1083#1100#1090#1088
          DataBinding.FieldName = 'FILTERNAME_RUS'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 100
        end
        object cxGridFilters_FLG_ENABLED: TcxGridDBColumn
          Caption = 'Act'
          DataBinding.FieldName = 'FLG_ENABLED'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 60
        end
        object cxGridFilters_FLG_OPEN_GROUP: TcxGridDBColumn
          Caption = 'Deschis'
          DataBinding.FieldName = 'FLG_OPEN_GROUP'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 60
        end
        object cxGridFilters_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          DataBinding.IsNullValueType = True
          Visible = False
          HeaderAlignmentHorz = taCenter
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
        end
      end
      object cxGridFiltersLevel: TcxGridLevel
        GridView = cxGridFiltersTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 56
      Width = 589
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object pnFilter: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 589
      Height = 49
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 7
      Align = alTop
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      object Label2: TLabel
        Left = 12
        Top = 17
        Width = 41
        Height = 15
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Catalog'
      end
      object edCatalog_ROM: TEdit
        Left = 64
        Top = 14
        Width = 516
        Height = 23
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
      object edCatalog_RUS: TEdit
        Left = 590
        Top = 14
        Width = 402
        Height = 23
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object btnOk: TcxButton
    Left = 487
    Top = 519
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 1
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 612
    Top = 70
    Width = 439
    Height = 434
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object cxGrid1: TcxGrid
      Left = 0
      Top = 28
      Width = 435
      Height = 200
      Align = alTop
      TabOrder = 1
      object cxGrid1DBTableView1: TcxGridDBTableView
        OnDblClick = cxGrid1DBTableView1DblClick
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDS_RecomendedFilters
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object cxGrid1DB_FilterID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'FilterID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 49
        end
        object cxGrid1DB_FilterNameRo: TcxGridDBColumn
          Caption = 'Denumire filtru'
          DataBinding.FieldName = 'FILTERNAME'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 199
        end
        object cxGrid1DB_FilterNameRu: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1092#1080#1083#1100#1090#1088#1072
          DataBinding.FieldName = 'FILTERNAME_RUS'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 189
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object dxBarDockControl2: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 435
      Height = 28
      Align = dalTop
      BarManager = dxBarManager1
    end
    object cxGrid2: TcxGrid
      Left = 0
      Top = 234
      Width = 432
      Height = 200
      TabOrder = 2
      object cxGrid2DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceParamUsedByUsers
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object cxGrid2DBTableView1CREATED_BY: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_BY'
          DataBinding.IsNullValueType = True
          Visible = False
        end
        object cxGrid2DBTableView1FULL_NAME: TcxGridDBColumn
          Caption = 'Operator'
          DataBinding.FieldName = 'FULL_NAME'
          DataBinding.IsNullValueType = True
          Width = 317
        end
        object cxGrid2DBTableView1CNT: TcxGridDBColumn
          Caption = 'Cant produse'
          DataBinding.FieldName = 'CNT'
          DataBinding.IsNullValueType = True
        end
      end
      object cxGrid2Level1: TcxGridLevel
        GridView = cxGrid2DBTableView1
      end
    end
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1055
    Height = 64
    Title = 'Gestionarea filtrelor in webcatalog'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -17
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -13
    FontText.Name = 'Segoe UI'
    FontText.Style = []
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Filtre recomandate')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 360
    Top = 8
    PixelsPerInch = 96
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
      FloatLeft = 622
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFilterAdd'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFilterEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFilterRemove'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSortFilters'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Filtre recomadnate'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 983
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddFilter'
        end
        item
          Visible = True
          ItemName = 'bbFilterParams'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbFilterAdd: TdxBarButton
      Caption = 'Adauga filtru pentru produs'
      Category = 0
      Hint = 'Adauga filtru pentru produs'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbFilterAddClick
    end
    object bbFilterEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbFilterEditClick
    end
    object bbFilterRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbFilterRemoveClick
    end
    object bbSortFilters: TdxBarButton
      Caption = 'Sorteaza'
      Category = 0
      Hint = 'Sorteaza'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortFiltersClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Producator, Tip'
      Category = 0
      Hint = 'Producator, Tip'
      Visible = ivAlways
      ImageIndex = 71
      OnClick = dxBarButton1Click
    end
    object bbAddFilter: TdxBarButton
      Caption = 'Adauga'
      Category = 1
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 90
      ShortCut = 16421
      OnClick = bbAddFilterClick
    end
    object bbFilterParams: TdxBarButton
      Caption = 'Parametri filtru'
      Category = 1
      Hint = 'Parametri filtru'
      Visible = ivAlways
      ImageIndex = 58
      ShortCut = 117
      OnClick = bbFilterParamsClick
    end
  end
  object IBCQueryFilters: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_CATALOG_FILTERS'
      '  (CATALOGID, FILTERID, FLG_ENABLED, FLG_OPEN_GROUP)'
      'VALUES'
      '  (:CATALOGID, :FILTERID, :FLG_ENABLED, :FLG_OPEN_GROUP)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TWEB_CATALOG_FILTERS'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID AND FILTERID = :Old_FILTERID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_CATALOG_FILTERS'
      'SET'
      '  CATALOGID = :CATALOGID,'
      '  FILTERID = :FILTERID, '
      '  FLG_ENABLED = :FLG_ENABLED, '
      '  FLG_OPEN_GROUP = :FLG_OPEN_GROUP'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID AND FILTERID = :Old_FILTERID')
    SQLRefresh.Strings = (
      'SELECT '
      '  CATALOGID, '
      '  FILTERID, '
      '  FILTERNAME_ROM, '
      '  FILTERNAME_RUS, '
      '  ORDERNO, '
      '  FLG_ENABLED, '
      '  FLG_OPEN_GROUP '
      'FROM '
      '  VW_TWEB_CATALOG_FILTERS'
      'WHERE'
      '  CATALOGID = :CATALOGID AND FILTERID = :FILTERID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TWEB_CATALOG_FILTERS'
      'WHERE'
      ' CATALOGID = :CatalogID'
      'ORDER BY '
      ' ORDERNO')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 184
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CatalogID'
        Value = nil
      end>
  end
  object IBCQ_RecomendedFilters: TIBCQuery
    KeyFields = 'FILTERID'
    SQL.Strings = (
      
        'select distinct f.filterid, f.filtername, f.filtername_rus from ' +
        'tweb_catalog_items i'
      'inner join ts_goods g on g.parentid = i.goodsparentid'
      'join ts_goods_descriptions gd on gd.goodsid = g.goodsid'
      'join ts_filters f on f.filterid = gd.filterid'
      'where i.catalogid = :catalogid'
      'order by f.filtername')
    MasterSource = IBCDataSourceFilters
    Left = 744
    Top = 207
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'catalogid'
        Value = nil
      end>
  end
  object IBCDataSourceFilters: TIBCDataSource
    DataSet = IBCQueryFilters
    Left = 112
    Top = 296
  end
  object IBCDS_RecomendedFilters: TIBCDataSource
    DataSet = IBCQ_RecomendedFilters
    Left = 744
    Top = 144
  end
  object IBCQueryParamUsedByUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select  gd.created_by, u.full_name, gd.filterid, count(g.goodsid' +
        ') cnt from tweb_catalog_items i'
      'inner join ts_goods g on g.parentid = i.goodsparentid'
      'join ts_goods_descriptions gd on gd.goodsid = g.goodsid'
      'join ts_filters f on f.filterid = gd.filterid'
      'join ts_users u on u.userid = gd.created_by'
      'where i.catalogid = :catalogid'
      'group by gd.created_by, u.full_name, gd.filterid'
      'order by 4 desc')
    MasterFields = 'FILTERID'
    DetailFields = 'gd.filterid'
    MasterSource = IBCDS_RecomendedFilters
    Left = 874
    Top = 333
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'catalogid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FILTERID'
        Value = nil
      end>
  end
  object IBCDataSourceParamUsedByUsers: TIBCDataSource
    DataSet = IBCQueryParamUsedByUsers
    Left = 803
    Top = 334
  end
end
