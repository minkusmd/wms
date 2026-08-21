object frmFiltersDialog: TfrmFiltersDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Filtre'
  ClientHeight = 690
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object cxGridFilter: TcxGrid
    AlignWithMargins = True
    Left = 5
    Top = 33
    Width = 629
    Height = 593
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 1
    object cxGridFilterTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FindPanel.ApplyInputDelay = 500
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.UseExtendedSyntax = True
      FindPanel.Location = fplGroupByBox
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceFilters
      DataController.KeyFieldNames = 'FILTERID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnFiltering = False
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
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'FILTERID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridFilter_FILTERNAME: TcxGridDBColumn
        Caption = 'Filtru'
        DataBinding.FieldName = 'FILTERNAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        SortIndex = 1
        SortOrder = soAscending
        VisibleForCustomization = False
        Width = 100
      end
      object cxGridFilter_FILTERNAME_RUS: TcxGridDBColumn
        Caption = #1060#1080#1083#1100#1090#1088
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
    end
    object cxGridFilterLevel: TcxGridLevel
      GridView = cxGridFilterTable
    end
  end
  object dxBarDockControl1: TdxBarDockControl
    Left = 0
    Top = 0
    Width = 639
    Height = 28
    Align = dalTop
    BarManager = dxBarManager
  end
  object cxButton1: TcxButton
    Left = 283
    Top = 653
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    Default = True
    ModalResult = 8
    TabOrder = 2
  end
  object IBCDataSourceFilters: TIBCDataSource
    DataSet = IBCQueryFilters
    Left = 96
    Top = 148
  end
  object IBCQueryFilters: TIBCQuery
    KeyFields = 'FILTERID'
    KeyGenerator = 'SQ_TS_FILTERS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_FILTERS'
      '  (FILTERID, FILTERNAME, FILTERNAME_RUS, FLG_FOLDER, PARENTID)'
      'VALUES'
      
        '  (:FILTERID, :FILTERNAME, :FILTERNAME_RUS, :FLG_FOLDER, :PARENT' +
        'ID)')
    SQLDelete.Strings = (
      'DELETE FROM TS_FILTERS'
      'WHERE'
      '  FILTERID = :Old_FILTERID')
    SQLUpdate.Strings = (
      'UPDATE TS_FILTERS'
      'SET'
      '  FILTERID = :FILTERID,'
      '  FILTERNAME = :FILTERNAME, '
      '  FILTERNAME_RUS = :FILTERNAME_RUS, '
      '  FLG_FOLDER = :FLG_FOLDER, '
      '  PARENTID = :PARENTID'
      'WHERE'
      '  FILTERID = :Old_FILTERID')
    SQLRefresh.Strings = (
      'SELECT '
      ' FILTERID,'
      ' PARENTID,'
      ' FLG_FOLDER,'
      ' FILTERNAME,'
      ' FILTERNAME_RUS,'
      ' ORDERNO'
      'FROM'
      ' TS_FILTERS'
      'WHERE'
      '  FILTERID = :FILTERID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' FILTERID,'
      ' PARENTID,'
      ' FLG_FOLDER,'
      ' FILTERNAME,'
      ' FILTERNAME_RUS,'
      ' ORDERNO'
      'FROM'
      ' TS_FILTERS'
      'ORDER BY'
      ' FILTERNAME')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 96
    Top = 196
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 256
    Top = 212
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
    Left = 240
    Top = 136
    PixelsPerInch = 96
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 650
      FloatTop = 8
      FloatClientWidth = 75
      FloatClientHeight = 169
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
          Visible = True
          ItemName = 'bbFilterNew'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFilterModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbFilterDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSortFilters'
        end
        item
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
          ItemName = 'dxBarButton3'
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
      OnClick = bbFilterNewClick
    end
    object bbFilterModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 113
      OnClick = bbFilterModifyClick
    end
    object bbParamNew: TdxBarButton
      Caption = 'Valoare noua'
      Category = 0
      Hint = 'Valoare noua'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
    end
    object bbParamModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
    end
    object bbParamDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
    end
    object bbFilterDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbFilterDeleteClick
    end
    object bbValueOrder: TdxBarButton
      Caption = 'Sorteaza'
      Category = 0
      Hint = 'Sorteaza'
      Visible = ivAlways
      ImageIndex = 38
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
      OnClick = bbSortFiltersClick
    end
    object bbChangeParent: TdxBarButton
      Caption = 'Modifica mapa parinte'
      Category = 0
      Hint = 'Modifica mapa parinte'
      Visible = ivAlways
      ImageIndex = 27
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
          ItemName = 'bbReadySet_YesNo'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton2'
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
    object dxBarButton3: TdxBarButton
      Caption = 'Lista de produse'
      Category = 0
      Hint = 'Lista de produse'
      Visible = ivAlways
      OnClick = dxBarButton3Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Uniti valoarea filtrului'
      Category = 1
      Hint = 'Uniti valoarea filtrului'
      Visible = ivAlways
      ShortCut = 49219
    end
  end
end
