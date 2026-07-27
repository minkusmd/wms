inherited frame37ServiceDispatcher: Tframe37ServiceDispatcher
  Font.Height = -15
  PixelsPerInch = 120
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 986
    Height = 261
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object pnTopClient: TPanel
      Left = 0
      Top = 0
      Width = 484
      Height = 261
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 484
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Padding.Left = 8
        Padding.Top = 2
        Padding.Right = 2
        Padding.Bottom = 2
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 2
          Width = 474
          Height = 18
          Align = alClient
          Caption = #1054#1078#1080#1076#1072#1085#1080#1077' '#1085#1072' '#1088#1077#1084#1086#1085#1090
          Color = clWindow
          ParentColor = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 150
          ExplicitHeight = 20
        end
      end
      object dxBarDockControlTopClient: TdxBarDockControl
        Left = 0
        Top = 22
        Width = 484
        Height = 34
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridWait: TcxGrid
        Left = 0
        Top = 56
        Width = 484
        Height = 205
        Align = alClient
        TabOrder = 2
        object cxGridWaitTable: TcxGridDBTableView
          OnFocusedRecordChanged = cxGridWaitTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceWait
          DataController.KeyFieldNames = 'INCIDENTID'
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsCustomize.ColumnSorting = False
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
          OptionsView.GroupByBox = False
          OptionsView.GroupRowStyle = grsOffice11
          OptionsView.Indicator = True
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          Styles.Group = dmAdditions.cxStyle_Bold
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridWait_INCIDENTID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'INCIDENTID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridWait_EXEC_PERSONAL_GROUP_TITLE: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072
            DataBinding.FieldName = 'EXEC_PERSONAL_GROUP_TITLE'
            Visible = False
            GroupIndex = 0
            Width = 100
          end
          object cxGridWait_VENDOR_TITLE: TcxGridDBColumn
            Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
            DataBinding.FieldName = 'VENDOR_TITLE'
            Width = 60
          end
          object cxGridWait_GOODS_MODEL: TcxGridDBColumn
            Caption = #1052#1086#1076#1077#1083#1100
            DataBinding.FieldName = 'GOODS_MODEL'
            Width = 80
          end
          object cxGridWait_GOODS_SN: TcxGridDBColumn
            Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
            DataBinding.FieldName = 'GOODS_SN'
            Width = 70
          end
          object cxGridWait_DATA_EST_FINISH: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
            DataBinding.FieldName = 'DATA_EST_FINISH'
            Visible = False
            Width = 50
          end
          object cxGridWait_DAYS_LEFT: TcxGridDBColumn
            Caption = #1054#1089#1090'.'#1076#1085#1077#1081
            DataBinding.FieldName = 'DAYS_LEFT'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            OnGetDisplayText = cxGridWait_DAYS_LEFTGetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Options.SortByDisplayText = isbtOff
            SortIndex = 1
            SortOrder = soAscending
            VisibleForCustomization = False
            Width = 80
          end
          object cxGridWait_PRIORITY_LEVEL_TITLE: TcxGridDBColumn
            Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
            DataBinding.FieldName = 'PRIORITY_LEVEL_TITLE'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridWait_PRIORITY_LEVEL_VALUE: TcxGridDBColumn
            Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
            DataBinding.FieldName = 'PRIORITY_LEVEL_VALUE'
            Visible = False
            SortIndex = 2
            SortOrder = soAscending
            VisibleForCustomization = False
          end
          object cxGridWait_FLG_TOP_PRIORITY: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_TOP_PRIORITY'
            Visible = False
            SortIndex = 0
            SortOrder = soDescending
            VisibleForCustomization = False
          end
        end
        object cxGridWaitLevel: TcxGridLevel
          GridView = cxGridWaitTable
        end
      end
    end
    object pnTopRight: TPanel
      Left = 496
      Top = 0
      Width = 490
      Height = 261
      Align = alRight
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object cxGridPer: TcxGrid
        Left = 0
        Top = 56
        Width = 490
        Height = 205
        Align = alClient
        TabOrder = 2
        object cxGridPerTable: TcxGridDBTableView
          OnFocusedRecordChanged = cxGridPerTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourcePererabotka
          DataController.KeyFieldNames = 'INCIDENTID'
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnGrouping = False
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
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridPer_INCIDENTID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'INCIDENTID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridPer_GOODS_TITLE: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'GOODS_TITLE'
            Width = 100
          end
          object cxGridPer_GOODS_MODEL: TcxGridDBColumn
            Caption = #1052#1086#1076#1077#1083#1100
            DataBinding.FieldName = 'GOODS_MODEL'
            Visible = False
            MinWidth = 40
            Width = 80
          end
          object cxGridPer_GOODS_SN: TcxGridDBColumn
            Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
            DataBinding.FieldName = 'GOODS_SN'
            MinWidth = 60
            Width = 100
          end
          object cxGridPer_DOC_CUSTOMER: TcxGridDBColumn
            Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
            DataBinding.FieldName = 'DOC_CUSTOMER'
            Visible = False
            MinWidth = 40
            Width = 80
          end
        end
        object cxGridPerLevel: TcxGridLevel
          GridView = cxGridPerTable
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 490
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Color = clWindow
        Padding.Left = 8
        Padding.Top = 2
        Padding.Right = 2
        Padding.Bottom = 2
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 2
          Width = 480
          Height = 18
          Align = alClient
          Caption = #1055#1077#1088#1077#1088#1072#1073#1086#1090#1082#1072
          Color = clWindow
          ParentColor = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 92
          ExplicitHeight = 20
        end
      end
      object dxBarDockControlTopRight: TdxBarDockControl
        Left = 0
        Top = 22
        Width = 490
        Height = 34
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
    object cxSplitterTopRight: TcxSplitter
      AlignWithMargins = True
      Left = 485
      Top = 0
      Width = 10
      Height = 261
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 0
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salRight
      MinSize = 300
      Control = pnTopRight
    end
  end
  object pnClient: TPanel
    Left = 0
    Top = 273
    Width = 986
    Height = 395
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object pnClientRight: TPanel
      Left = 496
      Top = 22
      Width = 490
      Height = 373
      Align = alRight
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object dxBarDockControlClientRight: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 490
        Height = 34
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxDBTreeList: TcxDBTreeList
        Left = 0
        Top = 34
        Width = 490
        Height = 339
        Align = alClient
        Bands = <
          item
          end>
        DataController.DataSource = IBCDataSourceTask
        DataController.ImageIndexField = 'IMAGE_INDEX'
        DataController.ParentField = 'PARENTID'
        DataController.KeyField = 'TASKID'
        Images = dmAdditions.cxImageList_SWN
        OptionsBehavior.ChangeDelay = 1000
        OptionsBehavior.ExpandOnIncSearch = True
        OptionsBehavior.IncSearch = True
        OptionsCustomizing.ColumnsQuickCustomization = True
        OptionsData.Editing = False
        OptionsSelection.InvertSelect = False
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        RootValue = 0
        ScrollbarAnnotations.CustomAnnotations = <>
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
        TabOrder = 1
        object cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn
          Caption.Text = #1047#1072#1076#1072#1095#1072
          DataBinding.FieldName = 'TASKTYPE_TITLE'
          Width = 200
          Position.ColIndex = 0
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn
          Caption.AlignHorz = taCenter
          Caption.Text = #1053#1072#1095#1072#1083#1086
          DataBinding.FieldName = 'DATA'
          Position.ColIndex = 1
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList1cxDBTreeListColumn3: TcxDBTreeListColumn
          Caption.AlignHorz = taCenter
          Caption.Text = #1048#1085#1078#1077#1085#1077#1088
          DataBinding.FieldName = 'USER_FULL_NAME'
          Position.ColIndex = 2
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
      end
    end
    object pnClientClient: TPanel
      Left = 0
      Top = 22
      Width = 484
      Height = 373
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 3
      object dxBarDockControlClientClient: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 484
        Height = 34
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridWork: TcxGrid
        Left = 0
        Top = 34
        Width = 484
        Height = 339
        Align = alClient
        TabOrder = 1
        object cxGridWorkTable: TcxGridDBTableView
          DataController.DataSource = IBCDataSourceInWork
          DataController.KeyFieldNames = 'INCIDENTID'
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.IncSearch = True
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
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridWork_INCIDENTID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'INCIDENTID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridWork_EXEC_PERSONAL_GROUP_TITLE: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072' '#1080#1085#1078#1077#1085#1077#1088#1086#1074
            DataBinding.FieldName = 'EXEC_PERSONAL_GROUP_TITLE'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridWork_GOODS_TITLE: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'GOODS_TITLE'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridWork_VENDOR_TITLE: TcxGridDBColumn
            Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
            DataBinding.FieldName = 'VENDOR_TITLE'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridWork_GOODS_MODEL: TcxGridDBColumn
            Caption = #1052#1086#1076#1077#1083#1100
            DataBinding.FieldName = 'GOODS_MODEL'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridWork_GOODS_SN: TcxGridDBColumn
            Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
            DataBinding.FieldName = 'GOODS_SN'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridWor_LEFT_HOURS: TcxGridDBColumn
            Caption = #1054#1089#1090'.'#1095#1072#1089#1086#1074
            DataBinding.FieldName = 'LEFT_HOURS'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridWork_ENGINER_FULL_NAME: TcxGridDBColumn
            Caption = #1048#1085#1078#1077#1085#1077#1088
            DataBinding.FieldName = 'ENGINER_FULL_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
        end
        object cxGridWorkLevel: TcxGridLevel
          GridView = cxGridWorkTable
        end
      end
    end
    object cxSplitterClientRight: TcxSplitter
      AlignWithMargins = True
      Left = 485
      Top = 22
      Width = 10
      Height = 373
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 0
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salRight
      MinSize = 300
      Control = pnClientRight
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 986
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      Padding.Left = 8
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      ParentBackground = False
      TabOrder = 0
      object Label3: TLabel
        Left = 8
        Top = 2
        Width = 976
        Height = 18
        Align = alClient
        Caption = #1048#1085#1094#1080#1076#1077#1085#1090#1099' '#1074' '#1088#1072#1073#1086#1090#1077
        Color = clWindow
        ParentColor = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 145
        ExplicitHeight = 20
      end
    end
  end
  object cxSplitterTop: TcxSplitter
    AlignWithMargins = True
    Left = 0
    Top = 262
    Width = 986
    Height = 10
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 1
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salTop
    MinSize = 200
    Control = pnTop
  end
  object IBCQueryPererabotka: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      'VW_SC_INCIDENTE.*,'
      
        '(SELECT LIST((SELECT TITLE FROM TS_SYSS WHERE SYSSID=GARNITURA_I' +
        'D),'#39', '#39') FROM SC_INCIDENT_GARNITURA WHERE SC_INCIDENT_GARNITURA.' +
        'INCIDENTID=VW_SC_INCIDENTE.INCIDENTID) GARNITURA_LIST'
      'FROM VW_SC_INCIDENTE'
      'WHERE STATUS_ID=6102')
    ReadOnly = True
    Left = 844
    Top = 124
  end
  object IBCDataSourcePererabotka: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryPererabotka
    Left = 844
    Top = 180
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
    Left = 436
    Top = 308
    PixelsPerInch = 120
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControlTopRight
      DockedDockControl = dxBarDockControlTopRight
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 952
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPererabotkaAccept'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControlTopClient
      DockedDockControl = dxBarDockControlTopClient
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1233
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbWaitingIncidentProps'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbWaitingIncidentRun'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarManagerBar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockControl = dxBarDockControlClientClient
      DockedDockControl = dxBarDockControlClientClient
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1233
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
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
      Visible = True
      WholeRow = True
    end
    object dxBarManagerBar4: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 4'
      CaptionButtons = <>
      DockControl = dxBarDockControlClientRight
      DockedDockControl = dxBarDockControlClientRight
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1233
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object bbPererabotkaAccept: TdxBarButton
      Caption = #1055#1088#1080#1085#1103#1090#1100' '#1090#1086#1074#1072#1088
      Category = 0
      Hint = #1055#1088#1080#1085#1103#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 43
      OnClick = bbPererabotkaAcceptClick
    end
    object bbWaitingIncidentProps: TdxBarButton
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072
      Category = 0
      Hint = #1057#1074#1086#1081#1089#1090#1074#1072
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbWaitingIncidentPropsClick
    end
    object bbWaitingIncidentRun: TdxBarButton
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1074' '#1088#1072#1073#1086#1090#1091
      Category = 0
      Hint = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1074' '#1088#1072#1073#1086#1090#1091
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbWaitingIncidentRunClick
    end
    object dxBarButton1: TdxBarButton
      Caption = #1055#1077#1088#1077#1085#1072#1079#1085#1072#1095#1080#1090#1100
      Category = 0
      Hint = #1055#1077#1088#1077#1085#1072#1079#1085#1072#1095#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 36
    end
    object dxBarButton2: TdxBarButton
      Caption = #1042#1077#1088#1085#1091#1090#1100
      Category = 0
      Hint = #1042#1077#1088#1085#1091#1090#1100
      Visible = ivAlways
      ImageIndex = 35
    end
  end
  object IBCQueryWait: TIBCQuery
    SQLUpdate.Strings = (
      'UPDATE VW_SC_INCIDENTE'
      'SET'
      '  PRIORITY_LEVEL_ID = :PRIORITY_LEVEL_ID, '
      '  EXEC_PERSONAL_GROUP_ID = :EXEC_PERSONAL_GROUP_ID,'
      '  FLG_TOP_PRIORITY = :FLG_TOP_PRIORITY,'
      '  COMMENTS = :COMMENTS'
      'WHERE'
      '  INCIDENTID = :Old_INCIDENTID')
    SQLRefresh.Strings = (
      'SELECT '
      ' VW_SC_INCIDENTE.*,'
      
        ' CAST(VW_SC_INCIDENTE.DATA_EST_FINISH AS DATE)-CURRENT_DATE DAYS' +
        '_LEFT'
      'FROM '
      ' VW_SC_INCIDENTE'
      'WHERE'
      ' INCIDENTID = :INCIDENTID')
    SQLLock.Strings = (
      'SELECT NULL FROM SC_INCIDENTE'
      'WHERE'
      'INCIDENTID = :Old_INCIDENTID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_SC_INCIDENTE.*,'
      
        ' CAST(VW_SC_INCIDENTE.DATA_EST_FINISH AS DATE)-CURRENT_DATE DAYS' +
        '_LEFT'
      'FROM '
      ' VW_SC_INCIDENTE'
      'WHERE'
      ' STATUS_ID=6103')
    AutoCommit = False
    RefreshOptions = [roAfterUpdate]
    Left = 200
    Top = 120
  end
  object IBCDataSourceWait: TIBCDataSource
    DataSet = IBCQueryWait
    Left = 200
    Top = 176
  end
  object IBCQueryInWork: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' VW_SC_INCIDENTE.*,'
      ' SC_TASK.USERID,'
      ' TS_USERS.FULL_NAME ENGINER_FULL_NAME,'
      
        ' DATEDIFF(HOUR FROM SC_TASK.DATA TO CURRENT_TIMESTAMP) ELAPSED_H' +
        'OURS,'
      
        ' DATEDIFF(HOUR FROM CURRENT_TIMESTAMP TO SC_TASK.END_ESTIMATED_T' +
        'IME) LEFT_HOURS'
      'FROM VW_SC_INCIDENTE'
      
        'INNER JOIN SC_TASK ON (SC_TASK.PARENTID=0 AND SC_TASK.INCIDENTID' +
        '=VW_SC_INCIDENTE.INCIDENTID AND SC_TASK.TASKTYPE_ID=1)'
      'INNER JOIN TS_USERS ON (TS_USERS.USERID=SC_TASK.USERID)'
      'WHERE'
      ' STATUS_ID=6104')
    Left = 160
    Top = 504
  end
  object IBCDataSourceInWork: TIBCDataSource
    DataSet = IBCQueryInWork
    Left = 160
    Top = 556
  end
  object IBCQueryTask: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      'VW_SC_TASK.*,'
      'IIF(TASKTYPE_ID in (1),14,'
      '    IIF(TASKTYPE_ID IN (5,6,7,8),'
      '        case VW_SC_TASK.TASKTYPE_VALUE_INT'
      '          when -1 then 60'
      '          when 0 then 61'
      '          when 1 then 59'
      '        end,'
      '    45)'
      ') IMAGE_INDEX'
      'FROM VW_SC_TASK'
      'ORDER BY DATA')
    MasterFields = 'INCIDENTID'
    DetailFields = 'INCIDENTID'
    MasterSource = IBCDataSourceInWork
    Options.DetailDelay = 500
    Left = 956
    Top = 472
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'INCIDENTID'
        Value = nil
      end>
  end
  object IBCDataSourceTask: TIBCDataSource
    DataSet = IBCQueryTask
    Left = 956
    Top = 524
  end
end
