object frmWebSelectFiltersDlg: TfrmWebSelectFiltersDlg
  Left = 0
  Top = 0
  Caption = 'Selecteaza un filtru'
  ClientHeight = 589
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  DesignSize = (
    774
    589)
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 92
    Width = 774
    Height = 453
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxGridFilter: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 760
      Height = 439
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      TabOrder = 0
      object cxGridFilterTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FindPanel.DisplayMode = fpdmAlways
        FindPanel.Layout = fplCompact
        FindPanel.Position = fppBottom
        FindPanel.UseExtendedSyntax = True
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceFilters
        DataController.KeyFieldNames = 'FILTERID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridFilter_FLG_FOLDER: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_FOLDER'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 26
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 13
              Value = 1
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.Focusing = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridFilte_FILTERID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1092#1080#1083#1100#1090#1088#1072
          Caption = 'Cod'
          DataBinding.FieldName = 'FILTERID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridFilter_FILTERNAME: TcxGridDBColumn
          Caption = 'Proprietati'
          DataBinding.FieldName = 'FILTERNAME'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          SortIndex = 1
          SortOrder = soAscending
          VisibleForCustomization = False
          Width = 100
        end
        object cxGridFilter_FILTERNAME_RUS: TcxGridDBColumn
          Caption = #1057#1074#1086#1081#1089#1090#1074#1072
          DataBinding.FieldName = 'FILTERNAME_RUS'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 100
        end
        object cxGridFilter_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          DataBinding.IsNullValueType = True
          Visible = False
          HeaderAlignmentHorz = taCenter
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
        end
        object cxGridFilter_FLG_ORDINARY_FILTER: TcxGridDBColumn
          AlternateCaption = 'Filtru ordinar'
          Caption = 'Ord'
          DataBinding.FieldName = 'FLG_ORDINARY_FILTER'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          MinWidth = 28
          Options.HorzSizing = False
          Width = 28
        end
      end
      object cxGridFilterLevel: TcxGridLevel
        GridView = cxGridFilterTable
      end
    end
  end
  object btnOk: TcxButton
    Left = 556
    Top = 554
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object btnCancel: TcxButton
    Left = 660
    Top = 554
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 6
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 774
    Height = 64
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -15
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
  end
  object IBCQueryFilters: TIBCQuery
    KeyFields = 'FILTERID'
    KeyGenerator = 'SQ_TS_FILTERS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO vw_TS_FILTERS'
      
        '  (FILTERID, FILTERNAME, FILTERNAME_RUS, FLG_FOLDER, PARENTID, F' +
        'LG_ORDINARY_FILTER)'
      'VALUES'
      
        '  (:FILTERID, :FILTERNAME, :FILTERNAME_RUS, :FLG_FOLDER, :PARENT' +
        'ID, :FLG_ORDINARY_FILTER)')
    SQLDelete.Strings = (
      'DELETE FROM TS_FILTERS'
      'WHERE'
      '  FILTERID = :Old_FILTERID')
    SQLUpdate.Strings = (
      'UPDATE vw_TS_FILTERS'
      'SET'
      '  FILTERID = :FILTERID,'
      '  FILTERNAME = :FILTERNAME, '
      '  FILTERNAME_RUS = :FILTERNAME_RUS, '
      '  FLG_FOLDER = :FLG_FOLDER, '
      '  PARENTID = :PARENTID,'
      '  FLG_ORDINARY_FILTER = :FLG_ORDINARY_FILTER'
      'WHERE'
      '  FILTERID = :Old_FILTERID')
    SQLRefresh.Strings = (
      'SELECT '
      ' FILTERID,'
      ' PARENTID,'
      ' FLG_FOLDER,'
      ' FILTERNAME,'
      ' FILTERNAME_RUS,'
      ' ORDERNO,'
      ' FLG_ORDINARY_FILTER'
      'FROM'
      ' vw_TS_FILTERS'
      'WHERE'
      '  FILTERID = :FILTERID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' FF.FILTERID,'
      ' FF.PARENTID,'
      
        ' (SELECT FILTERNAME FROM TS_FILTERS f WHERE f.FILTERID=ff.PARENT' +
        'ID) PARENT_FILTERNAME, '
      ' ff.FLG_FOLDER,'
      ' ff.FILTERNAME,'
      ' ff.FILTERNAME_RUS,'
      ' ff.ORDERNO,'
      ' FLG_ORDINARY_FILTER'
      'FROM'
      ' VW_TS_FILTERS ff'
      'ORDER BY'
      ' ff.FILTERNAME')
    Debug = True
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 96
    Top = 196
  end
  object IBCDataSourceFilters: TIBCDataSource
    DataSet = IBCQueryFilters
    Left = 96
    Top = 148
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Tools')
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
    Left = 480
    Top = 184
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 565
      FloatTop = 8
      FloatClientWidth = 181
      FloatClientHeight = 53
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNavHome'
        end
        item
          Visible = True
          ItemName = 'bbNavBack'
        end
        item
          Visible = True
          ItemName = 'bbNavForward'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbFolderNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbParamNew'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbParamModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbParamDelete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbValueOrder'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbChangeParent'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbTools'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object bbFilterNew: TdxBarButton
      Caption = 'Filtru nou'
      Category = 0
      Hint = 'Filtru nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 16429
    end
    object bbFilterModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 32781
    end
    object bbParamNew: TdxBarButton
      Caption = 'Filtru nou'
      Category = 0
      Hint = 'Filtru nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbParamNewClick
    end
    object bbParamModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbParamModifyClick
    end
    object bbParamDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbParamDeleteClick
    end
    object bbFilterDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
    end
    object bbValueOrder: TdxBarButton
      Caption = 'Sorteaza'
      Category = 0
      Hint = 'Sorteaza'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbValueOrderClick
    end
    object bbNavHome: TdxBarButton
      Caption = 'Home'
      Category = 0
      Hint = 'Home'
      Visible = ivAlways
      ImageIndex = 5
      ShortCut = 36
      OnClick = bbNavHomeClick
    end
    object bbNavBack: TdxBarButton
      Caption = 'Back'
      Category = 0
      Hint = 'Back'
      Visible = ivAlways
      ImageIndex = 6
      ShortCut = 8
      OnClick = bbNavBackClick
    end
    object bbNavForward: TdxBarButton
      Caption = 'Forward'
      Category = 0
      Hint = 'Forward'
      Visible = ivAlways
      ImageIndex = 7
      ShortCut = 13
      OnClick = bbNavForwardClick
    end
    object bbFolderNew: TdxBarButton
      Caption = 'Mapa noua...'
      Category = 0
      Hint = 'Mapa noua'
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbFolderNewClick
    end
    object bbSortFilters: TdxBarButton
      Caption = 'Sorteaza elementele'
      Category = 0
      Hint = 'Sorteaza elementele'
      Visible = ivAlways
      ImageIndex = 38
    end
    object bbChangeParent: TdxBarButton
      Caption = 'Modifica mapa parinte'
      Category = 0
      Hint = 'Modifica mapa parinte'
      Visible = ivAlways
      ImageIndex = 98
      OnClick = bbChangeParentClick
    end
    object bbCloneValues: TdxBarButton
      Caption = 'Copy'
      Category = 0
      Hint = 'Copy'
      Visible = ivAlways
      ImageIndex = 29
      ShortCut = 16452
    end
    object bbTools: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Hint = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbCloneValues'
        end
        item
          Visible = True
          ItemName = 'bbChangeFilterParent'
        end>
    end
    object bbReadySet_YesNo: TdxBarButton
      Caption = 'Set valori (da/nu)'
      Category = 0
      Hint = 'Set valori (da/nu)'
      Visible = ivAlways
      ImageIndex = 40
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Cauta'
      Category = 0
      Hint = 'Cauta'
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 16454
      OnClick = dxBarButton1Click
    end
    object bbGoodsList: TdxBarButton
      Caption = 'Lista produse'
      Category = 0
      Hint = 'Lista produse'
      Visible = ivAlways
    end
    object bbChangeFilterParent: TdxBarButton
      Caption = 'Schimba parintele'
      Category = 0
      Hint = 'Schimba parintele'
      Visible = ivAlways
      ShortCut = 16461
    end
    object bbMergeFilterValues: TdxBarButton
      Caption = 'Uniti valoarea filtrului'
      Category = 1
      Hint = 'Uniti valoarea filtrului'
      Visible = ivAlways
      ShortCut = 49219
    end
    object bbGoodsListByFiltersParam: TdxBarButton
      Caption = 'Completeaza si treci la lista de produse'
      Category = 1
      Hint = 'Completeaza si treci la lista de produse'
      Visible = ivAlways
    end
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 256
    Top = 212
  end
end
