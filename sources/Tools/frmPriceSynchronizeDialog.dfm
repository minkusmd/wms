object frmPriceSynchronizeDlg: TfrmPriceSynchronizeDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1072#1094#1080#1103' '#1094#1077#1085' '#1080#1079' '#1076#1088#1091#1075#1080#1093' '#1092#1080#1088#1084
  ClientHeight = 665
  ClientWidth = 928
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 928
    Height = 64
    Title = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1072#1094#1080#1103' '#1094#1077#1085' '#1080#1079' '#1076#1088#1091#1075#1080#1093' '#1092#1080#1088#1084
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 11
  end
  object Notebook: TNotebook
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 912
    Height = 529
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    PageIndex = 1
    TabOrder = 1
    object TPage
      Left = 0
      Top = 0
      Caption = 'Sourse'
      object pnStep1: TPanel
        Left = 0
        Top = 0
        Width = 912
        Height = 529
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 876
          Height = 15
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 12
          Align = alTop
          Caption = '1. '#1042#1099#1073#1086#1088' '#1085#1072#1095#1072#1083#1100#1085#1099#1093' '#1076#1072#1085#1085#1099#1093
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15552050
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 166
        end
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 39
          Width = 908
          Height = 30
          Align = dalTop
          BarManager = dxBarManager1
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object cxGridSource: TcxGrid
          Left = 0
          Top = 69
          Width = 908
          Height = 456
          Align = alClient
          TabOrder = 1
          ExplicitLeft = 16
          ExplicitTop = 75
          object cxGridSourceTable: TcxGridTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnFiltering = False
            OptionsData.CancelOnExit = False
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
            object cxGridSource_CODE: TcxGridColumn
              Caption = #1050#1086#1076
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridSource_TITLE: TcxGridColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            end
            object cxGridSource_PRICE: TcxGridColumn
              Caption = #1062#1077#1085#1072', USD'
              DataBinding.ValueType = 'Float'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 110
              Options.HorzSizing = False
              Width = 110
            end
          end
          object cxGridSourceLevel: TcxGridLevel
            GridView = cxGridSourceTable
          end
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Process source'
      object pnProcessSource: TPanel
        Left = 0
        Top = 0
        Width = 912
        Height = 529
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 876
          Height = 15
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 12
          Align = alTop
          Caption = '2. '#1055#1086#1080#1089#1082' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1091#1102#1097#1080#1093' '#1090#1086#1074#1072#1088#1086#1074
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15552050
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 207
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 39
          Width = 908
          Height = 30
          Align = dalTop
          BarManager = dxBarManager1
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object cxGridProcessSource: TcxGrid
          Left = 0
          Top = 69
          Width = 908
          Height = 272
          Align = alTop
          TabOrder = 1
          object cxGridProcessSourceTable: TcxGridTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnFocusedRecordChanged = cxGridProcessSourceTableFocusedRecordChanged
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.CopyCaptionsToClipboard = False
            OptionsBehavior.CopyPreviewToClipboard = False
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
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
            object cxGridProcessSource_CODE: TcxGridColumn
              Caption = #1050#1086#1076
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridProcessSource_TITLE: TcxGridColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            end
            object cxGridProcessSource_PRICE: TcxGridColumn
              Caption = #1062#1077#1085#1072', USD'
              DataBinding.ValueType = 'Float'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 110
              Options.HorzSizing = False
              Width = 110
            end
            object cxGridProcessSource_RESULTINDEX: TcxGridColumn
              DataBinding.ValueType = 'Integer'
              Visible = False
              VisibleForCustomization = False
            end
          end
          object cxGridProcessSourceLevel: TcxGridLevel
            GridView = cxGridProcessSourceTable
          end
        end
        object dxBarDockControl3: TdxBarDockControl
          AlignWithMargins = True
          Left = 0
          Top = 345
          Width = 908
          Height = 30
          Margins.Left = 0
          Margins.Top = 4
          Margins.Right = 0
          Margins.Bottom = 0
          Align = dalTop
          BarManager = dxBarManager1
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object cxGridProcessResults: TcxGrid
          Left = 0
          Top = 375
          Width = 908
          Height = 150
          Align = alClient
          TabOrder = 4
          object cxGridProcessResultsTable: TcxGridTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnFocusedRecordChanged = cxGridProcessResultsTableFocusedRecordChanged
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
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
            object cxGridProcessResults_GOODSID: TcxGridColumn
              Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072
              DataBinding.ValueType = 'Integer'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridProcessResults_TITLE: TcxGridColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            end
            object cxGridProcessResults_PRICE0: TcxGridColumn
              Caption = #1062#1077#1085#1072' 0'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridProcessResults_PRICE1: TcxGridColumn
              Caption = #1062#1077#1085#1072' 1, USD'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridProcessResults_PRICE2: TcxGridColumn
              Caption = #1062#1077#1085#1072' 2, USD'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridProcessResults_SELECTED: TcxGridColumn
              DataBinding.ValueType = 'Boolean'
              Visible = False
              VisibleForCustomization = False
            end
          end
          object cxGridProcessResultsLevel: TcxGridLevel
            GridView = cxGridProcessResultsTable
          end
        end
        object pnProgress: TPanel
          Left = 289
          Top = 192
          Width = 329
          Height = 141
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 2
          object lbProgress: TLabel
            AlignWithMargins = True
            Left = 8
            Top = 36
            Width = 309
            Height = 15
            Margins.Left = 8
            Margins.Top = 8
            Margins.Right = 8
            Margins.Bottom = 0
            AutoSize = False
            Caption = 'lbProgress'
          end
          object pbProgressBar: TProgressBar
            AlignWithMargins = True
            Left = 8
            Top = 55
            Width = 309
            Height = 17
            Margins.Left = 8
            Margins.Top = 4
            Margins.Right = 8
            Margins.Bottom = 0
            TabOrder = 0
          end
          object lbStopProgress: TcxButton
            Left = 103
            Top = 92
            Width = 118
            Height = 25
            Cancel = True
            Caption = #1086#1089#1090#1072#1085#1086#1074#1080#1090#1100' (ESC)'
            Default = True
            TabOrder = 1
            OnClick = lbStopProgressClick
          end
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Database'
      object pnDBActions: TPanel
        Left = 0
        Top = 0
        Width = 912
        Height = 529
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object Label3: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 876
          Height = 15
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 12
          Align = alTop
          Caption = '3. '#1057#1086#1079#1076#1072#1085#1080#1077' '#1089#1074#1103#1079#1077#1081' '#1080' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1094#1077#1085
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15552050
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 222
        end
        object dxBarDockControl4: TdxBarDockControl
          Left = 0
          Top = 39
          Width = 908
          Height = 30
          Align = dalTop
          BarManager = dxBarManager1
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object cxGridToDo: TcxGrid
          Left = 0
          Top = 69
          Width = 908
          Height = 456
          Align = alClient
          TabOrder = 1
          object cxGridToDoTable: TcxGridTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnFiltering = False
            OptionsData.CancelOnExit = False
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
            object cxGrid_FIRMA: TcxGridColumn
              Caption = #1060#1080#1088#1084#1072
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
            object cxGrid_CODE: TcxGridColumn
              Caption = #1050#1086#1076
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGrid_TITLE: TcxGridColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              HeaderAlignmentHorz = taCenter
            end
            object cxGrid_GOODSID: TcxGridColumn
              Caption = 'GOODSID'
              DataBinding.ValueType = 'Integer'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGrid_GOODS_TITLE: TcxGridColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              HeaderAlignmentHorz = taCenter
            end
            object cxGrid_OLD_PRICE: TcxGridColumn
              Caption = #1089#1090#1072#1088#1072#1103', USD'
              DataBinding.ValueType = 'Float'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGrid_NEW_PRICE: TcxGridColumn
              Caption = #1085#1086#1074#1072#1103', USD'
              DataBinding.ValueType = 'Float'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGrid_NEEDLINK: TcxGridColumn
              DataBinding.ValueType = 'Boolean'
              Visible = False
              VisibleForCustomization = False
            end
          end
          object cxGridToDoLevel: TcxGridLevel
            GridView = cxGridToDoTable
          end
        end
      end
    end
  end
  object btnPrev: TcxButton
    Left = 540
    Top = 616
    Width = 90
    Height = 29
    Caption = '<< '#1053#1072#1079#1072#1076
    TabOrder = 2
    OnClick = btnPrevClick
  end
  object btnNext: TcxButton
    Left = 640
    Top = 616
    Width = 90
    Height = 29
    Caption = #1044#1072#1083#1077#1077' >>'
    TabOrder = 3
    OnClick = btnNextClick
  end
  object btnCancel: TcxButton
    Left = 812
    Top = 616
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 4
  end
  object dxBarManager1: TdxBarManager
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 636
    Top = 24
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
      FloatLeft = 952
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSourceInsertAll'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSourceDeleteAll'
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
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 952
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 206
          Visible = True
          ItemName = 'beSourceProgressFirma'
        end
        item
          Visible = True
          ItemName = 'bbSourceProgressSelectedFirma'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbStartSearchLinks'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteProcessSource'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 952
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSelectGoodsAsLinked'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSelectGoods'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 4'
      CaptionButtons = <>
      DockControl = dxBarDockControl4
      DockedDockControl = dxBarDockControl4
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 952
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 232
          Visible = True
          ItemName = 'cmbFinalAction'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbProcessData'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbSourceInsertCodes: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1050#1086#1076#1099
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1082#1086#1083#1086#1085#1082#1091' '#1050#1086#1076
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 16433
      OnClick = bbSourceInsertCodesClick
    end
    object bbSourceInsertTitles: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1082#1086#1083#1086#1085#1082#1091' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 16434
      OnClick = bbSourceInsertTitlesClick
    end
    object bbSourceDeleteAll: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbSourceDeleteAllClick
    end
    object bbSourceInsertPrices: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1062#1077#1085#1099
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1082#1086#1083#1086#1085#1082#1091' '#1062#1077#1085#1072
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 16435
      OnClick = bbSourceInsertPricesClick
    end
    object bbSourceInsertAll: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1074#1089#1077' '#1082#1086#1083#1086#1085#1082#1080' '#1089#1088#1072#1079#1091
      Visible = ivAlways
      ButtonStyle = bsDropDown
      DropDownMenu = dxBarPopupMenu1
      ImageIndex = 24
      OnClick = bbSourceInsertAllClick
    end
    object bbStartSearchLinks: TdxBarButton
      Caption = #1055#1086#1080#1089#1082' '#1090#1086#1074#1072#1088#1086#1074
      Category = 0
      Hint = #1055#1086#1080#1089#1082' '#1090#1086#1074#1072#1088#1086#1074
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 114
      OnClick = bbStartSearchLinksClick
    end
    object bbSelectGoodsAsLinked: TdxBarButton
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1074#1072#1088
      Category = 0
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 43
      ShortCut = 13
      OnClick = bbSelectGoodsAsLinkedClick
    end
    object beSourceProgressFirma: TdxBarEdit
      Caption = #1060#1080#1088#1084#1072
      Category = 0
      Hint = #1060#1080#1088#1084#1072
      Visible = ivAlways
      ShowCaption = True
      ReadOnly = True
    end
    object bbSourceProgressSelectedFirma: TdxBarButton
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Category = 0
      Hint = #1042#1099#1073#1088#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbSourceProgressSelectedFirmaClick
    end
    object bbSelectGoods: TdxBarButton
      Caption = #1056#1091#1095#1085#1086#1081' '#1087#1086#1080#1089#1082
      Category = 0
      Hint = #1056#1091#1095#1085#1086#1081' '#1087#1086#1080#1089#1082
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 16454
      OnClick = bbSelectGoodsClick
    end
    object bbDeleteProcessSource: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 35
      ShortCut = 46
      OnClick = bbDeleteProcessSourceClick
    end
    object cmbFinalAction: TdxBarCombo
      Caption = #1044#1077#1081#1089#1090#1074#1080#1077
      Category = 0
      Hint = #1044#1077#1081#1089#1090#1074#1080#1077
      Visible = ivAlways
      ShowCaption = True
      Text = #1057#1086#1079#1076#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1089#1074#1103#1079#1080
      ShowEditor = False
      Items.Strings = (
        #1057#1086#1079#1076#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1089#1074#1103#1079#1080
        #1057#1086#1079#1076#1072#1090#1100' '#1089#1074#1103#1079#1080' '#1080' '#1086#1073#1085#1086#1074#1080#1090#1100' '#1094#1077#1085#1099)
      ItemIndex = 0
    end
    object bbProcessData: TdxBarButton
      Caption = #1057#1076#1077#1083#1072#1090#1100
      Category = 0
      Hint = #1057#1076#1077#1083#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 45
      OnClick = bbProcessDataClick
    end
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        UserDefine = [udPaintStyle]
        UserPaintStyle = psCaptionGlyph
        Visible = True
        ItemName = 'bbSourceInsertCodes'
      end
      item
        UserDefine = [udPaintStyle]
        UserPaintStyle = psCaptionGlyph
        Visible = True
        ItemName = 'bbSourceInsertTitles'
      end
      item
        UserDefine = [udPaintStyle]
        UserPaintStyle = psCaptionGlyph
        Visible = True
        ItemName = 'bbSourceInsertPrices'
      end>
    UseOwnFont = False
    Left = 744
    Top = 24
    PixelsPerInch = 96
  end
  object IBCQuery: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    AutoCommit = False
    Left = 44
    Top = 608
  end
  object cxStyleRepositoryLocal: TcxStyleRepository
    Left = 496
    Top = 12
    PixelsPerInch = 96
    object cxStyle_NoMatches: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clGray
    end
    object cxStyle_TooMany: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clRed
    end
    object cxStyle_Exact: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clGreen
    end
    object cxStyle_Like: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = 33023
    end
  end
  object IBCQueryUpdate: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    AutoCommit = False
    Left = 156
    Top = 608
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 264
    Top = 608
  end
end
