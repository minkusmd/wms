object fmAnalizeSupplierPrice: TfmAnalizeSupplierPrice
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1040#1085#1072#1083#1080#1079' '#1087#1088#1072#1081#1089' '#1083#1080#1089#1090#1086#1074
  ClientHeight = 636
  ClientWidth = 962
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 962
    Height = 64
    Title = #1040#1085#1072#1083#1080#1079' '#1087#1088#1072#1081#1089' '#1083#1080#1089#1090#1086#1074
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
  object pcPageControl: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 946
    Height = 509
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = tbsOldGoods
    Align = alTop
    TabOrder = 1
    object tbsOldGoods: TTabSheet
      Caption = '1. '#1057#1090#1072#1088#1099#1081' '#1087#1088#1072#1081#1089
      object cxGridOld: TcxGrid
        Left = 0
        Top = 30
        Width = 938
        Height = 449
        Align = alClient
        TabOrder = 1
        object cxGridOldTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCustomDrawCell = cxGridOldTableCustomDrawCell
          DataController.DataSource = IBCDataSourceOldGoods
          DataController.KeyFieldNames = 'ID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGridOldTableARTICOL
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.CopyPreviewToClipboard = False
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.CellMultiSelect = True
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object cxGridOld_ID: TcxGridDBColumn
            DataBinding.FieldName = 'ID'
            Visible = False
            SortIndex = 0
            SortOrder = soAscending
            VisibleForCustomization = False
          end
          object cxGridOldTableARTICOL: TcxGridDBColumn
            Caption = #1040#1088#1090#1080#1082#1086#1083
            DataBinding.FieldName = 'ARTICOL'
            HeaderAlignmentHorz = taCenter
            MinWidth = 140
            Options.HorzSizing = False
            Width = 140
          end
          object cxGridOldTableTITLE: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'NAME'
          end
          object cxGridOldTablePRICE: TcxGridDBColumn
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'PRICE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
        end
        object cxGridOldLevel: TcxGridLevel
          GridView = cxGridOldTable
        end
      end
      object bardocOldGoods: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 938
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
    object tbsNewGoods: TTabSheet
      Caption = '2. '#1053#1086#1074#1099#1077' '#1087#1088#1072#1081#1089
      ImageIndex = 1
      object cxGridNew: TcxGrid
        Left = 0
        Top = 30
        Width = 938
        Height = 449
        Align = alClient
        TabOrder = 1
        object cxGridNewTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCustomDrawCell = cxGridNewTableCustomDrawCell
          DataController.DataSource = IBCDataSourceNewGoods
          DataController.KeyFieldNames = 'ID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGridNewTableARTICOL
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.CopyPreviewToClipboard = False
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.CellMultiSelect = True
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object cxGridNew_ID: TcxGridDBColumn
            DataBinding.FieldName = 'ID'
            Visible = False
            SortIndex = 0
            SortOrder = soAscending
            VisibleForCustomization = False
          end
          object cxGridNewTableARTICOL: TcxGridDBColumn
            Caption = #1040#1088#1090#1080#1082#1086#1083
            DataBinding.FieldName = 'ARTICOL'
            HeaderAlignmentHorz = taCenter
            MinWidth = 140
            Options.HorzSizing = False
            Width = 140
          end
          object cxGridNewTableTITLE: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'NAME'
          end
          object cxGridNewTablePRICE: TcxGridDBColumn
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'PRICE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
        end
        object cxGridNewLevel: TcxGridLevel
          GridView = cxGridNewTable
        end
      end
      object bardocNewGoods: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 938
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
    object tbsAnalyze: TTabSheet
      Caption = '3. '#1040#1085#1072#1083#1080#1079
      ImageIndex = 2
      object cxGridAnalyze: TcxGrid
        Left = 0
        Top = 30
        Width = 938
        Height = 449
        Align = alClient
        TabOrder = 1
        object cxGridAnalyzeTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCustomDrawCell = cxGridAnalyzeTableCustomDrawCell
          OnFocusedItemChanged = cxGridAnalyzeTableFocusedItemChanged
          OnFocusedRecordChanged = cxGridAnalyzeTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceAnalyze
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGridAnalyze_ARTICOL
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.CopyPreviewToClipboard = False
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.CellMultiSelect = True
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object cxGridAnalyze_FLAGS: TcxGridDBColumn
            DataBinding.FieldName = 'FLAGS'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Images = cxImageList_FLAGS
            Properties.Items = <
              item
                ImageIndex = 0
                Value = 1
              end
              item
                ImageIndex = 1
                Value = 2
              end
              item
                ImageIndex = 2
                Value = 3
              end
              item
                ImageIndex = 3
                Value = 4
              end>
            HeaderAlignmentHorz = taCenter
            MinWidth = 24
            Options.Focusing = False
            Options.HorzSizing = False
            SortIndex = 0
            SortOrder = soDescending
            Width = 24
            IsCaptionAssigned = True
          end
          object cxGridAnalyze_ARTICOL: TcxGridDBColumn
            Caption = #1040#1088#1090#1080#1082#1086#1083
            DataBinding.FieldName = 'ARTICOL'
            HeaderAlignmentHorz = taCenter
            MinWidth = 140
            Options.HorzSizing = False
            Width = 140
          end
          object cxGridAnalyze_NAME: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'NAME'
          end
          object cxGridAnalyze_PRICE_NEW: TcxGridDBColumn
            Caption = #1062#1077#1085#1072' '#1085#1086#1074#1072#1103
            DataBinding.FieldName = 'PRICE_NEW'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridAnalyze_PRICE_OLD: TcxGridDBColumn
            Caption = #1062#1077#1085#1072' '#1089#1090#1072#1088#1072#1103
            DataBinding.FieldName = 'PRICE_OLD'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
        end
        object cxGridAnalyzeLevel: TcxGridLevel
          GridView = cxGridAnalyzeTable
        end
      end
      object bardocAnalyze: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 938
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
  end
  object btnClose: TButton
    Left = 851
    Top = 592
    Width = 90
    Height = 29
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
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
      DockControl = bardocOldGoods
      DockedDockControl = bardocOldGoods
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 881
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
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
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = bardocNewGoods
      DockedDockControl = bardocNewGoods
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 881
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem2'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
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
      DockControl = bardocAnalyze
      DockedDockControl = bardocAnalyze
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 881
      FloatTop = 8
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
    end
    object bbSourceInsertTitles: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1082#1086#1083#1086#1085#1082#1091' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 16434
    end
    object bbSourceDeleteAll: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 35
    end
    object bbSourceInsertPrices: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1062#1077#1085#1099
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1082#1086#1083#1086#1085#1082#1091' '#1062#1077#1085#1072
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 16435
    end
    object bbSourceInsertAll: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1074#1089#1077' '#1082#1086#1083#1086#1085#1082#1080' '#1089#1088#1072#1079#1091
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 120
    end
    object bbSelectGoodsAsLinked: TdxBarButton
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1074#1072#1088
      Category = 0
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 43
      ShortCut = 13
    end
    object beSourceProgressFirma: TdxBarEdit
      Caption = #1050#1083#1080#1077#1085#1090
      Category = 0
      Hint = #1050#1083#1080#1077#1085#1090
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
    end
    object bbDeleteProcessSource: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 35
      ShortCut = 46
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
    end
    object bbStartSearchPrices: TdxBarButton
      Caption = #1055#1086#1080#1089#1082' '#1087#1088#1072#1081#1089#1072
      Category = 0
      Hint = #1055#1086#1080#1089#1082' '#1087#1088#1072#1081#1089#1072
      Visible = ivAlways
      ImageIndex = 4
      PaintStyle = psCaptionGlyph
      ShortCut = 114
      OnClick = bbStartSearchPricesClick
    end
    object btnPasteOld_Accent: TdxBarButton
      Tag = 1
      Caption = 'Accent Electronic'
      Category = 0
      Hint = 'Accent Electronic'
      Visible = ivAlways
      OnClick = btnPasteOld_AccentClick
    end
    object dxBarButton2: TdxBarButton
      Align = iaRight
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1072#1088#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1072#1088#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
      Visible = ivAlways
      ImageIndex = 35
      OnClick = cxButton2Click
    end
    object btnPasteNew: TdxBarButton
      Tag = 1
      Caption = 'Accent Electronic'
      Category = 0
      Hint = 'Accent Electronic'
      Visible = ivAlways
      OnClick = btnPasteNewClick
    end
    object dxBarButton3: TdxBarButton
      Align = iaRight
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1085#1086#1074#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1085#1086#1074#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
      Visible = ivAlways
      ImageIndex = 35
      OnClick = cxButton3Click
    end
    object dxBarButton1: TdxBarButton
      Caption = #1040#1085#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1040#1085#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 7
      OnClick = cxButton1Click
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Category = 0
      Visible = ivAlways
      ImageIndex = 24
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'btnPasteOld_Accent'
        end
        item
          Visible = True
          ItemName = 'btnPasteOld_Ultra'
        end>
    end
    object btnPasteOld_Ultra: TdxBarButton
      Tag = 2
      Caption = 'Ultra'
      Category = 0
      Hint = 'Ultra'
      Visible = ivAlways
      OnClick = btnPasteOld_AccentClick
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Category = 0
      Visible = ivAlways
      ImageIndex = 24
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'btnPasteNew'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end>
    end
    object dxBarButton4: TdxBarButton
      Tag = 2
      Caption = 'Ultra'
      Category = 0
      Hint = 'Ultra'
      Visible = ivAlways
      OnClick = btnPasteNewClick
    end
  end
  object IBCQueryNewGoods: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'SQ_TS_COMPARE_PRICE_NEW_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_COMPARE_PRICE_NEW'
      '  (ID, ARTICOL, NAME, PRICE, USERID)'
      'VALUES'
      '  (:ID, :ARTICOL, :NAME, :PRICE, :USERID)')
    SQLDelete.Strings = (
      'DELETE FROM TS_COMPARE_PRICE_NEW'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      'SELECT ARTICOL, NAME, PRICE, USERID '
      'FROM TS_COMPARE_PRICE_NEW'
      'WHERE'
      '  ID = :ID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' ID,'
      ' ARTICOL,'
      ' NAME,'
      ' PRICE,'
      ' USERID'
      'FROM TS_COMPARE_PRICE_NEW'
      'WHERE USERID = :USER_ID')
    AutoCommit = False
    Left = 216
    Top = 316
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USER_ID'
        Value = nil
      end>
  end
  object IBCDataSourceNewGoods: TIBCDataSource
    DataSet = IBCQueryNewGoods
    Left = 220
    Top = 256
  end
  object IBCQueryAnalyze: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' ARTICOL,'
      ' NAME,'
      ' PRICE_OLD,'
      ' PRICE_NEW,'
      ' FLAGS'
      'FROM SP_COMPARE_PRICE(:USER_ID)')
    Options.DetailDelay = 500
    Left = 356
    Top = 316
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USER_ID'
        Value = nil
      end>
  end
  object IBCDataSourceAnalyze: TIBCDataSource
    DataSet = IBCQueryAnalyze
    Left = 356
    Top = 256
  end
  object IBCQueryOldGoods: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'SQ_TS_COMPARE_PRICE_OLD_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_COMPARE_PRICE_OLD'
      '  (ID, ARTICOL, NAME, PRICE, USERID)'
      'VALUES'
      '  (:ID, :ARTICOL, :NAME, :PRICE, :USERID)')
    SQLDelete.Strings = (
      'DELETE FROM TS_COMPARE_PRICE_OLD'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      'SELECT ID, ARTICOL, NAME, PRICE, USERID '
      'FROM TS_COMPARE_PRICE_OLD'
      'WHERE'
      '  ID = :ID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' ID,'
      ' ARTICOL,'
      ' NAME,'
      ' PRICE,'
      ' USERID'
      'FROM TS_COMPARE_PRICE_OLD'
      'WHERE USERID = :USER_ID')
    Left = 60
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USER_ID'
        Value = nil
      end>
  end
  object IBCDataSourceOldGoods: TIBCDataSource
    DataSet = IBCQueryOldGoods
    Left = 60
    Top = 256
  end
  object cxImageList_FLAGS: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 18612920
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000100020527094F0B4F12A00E6A17D6107A1BF6107A1BF70F6E
          18E10C5613AF062B0A5700010002000000000000000000000000000000000000
          0000010401080C5914B5148323FF22A44AFF1EBA5CFF16C460FF1AC563FF25BF
          63FF29AC54FF178627FF0D6316C9020E031D0000000000000000000000000002
          01050D5E15BF208F35FF3EC476FF2DC76FFF1DC264FF3DB26EFF3DAF6DFF2FBA
          6BFF35C874FF48C47BFF26933BFF0F7119E4020F031E00000000000000000A47
          10901B872AFF54C583FF43C87CFF30C771FF2AB967FFEEEEEEFFDADADAFF5CB1
          80FF36C875FF4BC981FF60C98DFF2B943FFF0E6416CB0001000203190633117D
          1CFA5DBC7FFF5DCA8BFF48C980FF38C876FF35B96EFFFFFFFFFFEEEEEEFF63B2
          85FF3EC879FF4EC983FF60CA8EFF6BC792FF1B862AFF062A09560A4D119C3196
          45FF72CA98FF5FCA8DFF4EC983FF42C87CFF41BA75FFFFFFFFFFEEEEEEFF6BB3
          8AFF48C97FFF54C986FF62CA8EFF6ECA95FF49AA65FF0C5814B20F6F19E050AC
          6BFF6DC793FF95BBA5FF8FB49FFF8DB49EFF93B6A2FFFBFAFAFFF4F4F4FFA6BB
          AFFF8FB49FFF91B4A0FF91B19FFF6FBB8FFF66C38BFF0E7018E510791BF551B1
          6FFF65C48EFFE8EEEBFFF6F6F6FFF6F6F6FFF8F8F8FFFEFEFEFFFEFEFEFFF9F9
          F9FFF6F6F6FFF6F6F6FFDEDEDEFF71B78FFF6ACA93FF117B1BF910771AF149B0
          69FF5EC58AFFD3E2DAFFE4EDE8FFE5EDE8FFE6EDE9FFFFFFFFFFFDFDFDFFEEF1
          EFFFE6EDE9FFE5EDE8FFDDE6E1FF70BE92FF64C98FFF107A1BF70D5F15C139A3
          56FF5BC98AFF5AC688FF64C68EFF70C796FF79B995FFFFFFFFFFF0F0F0FF92B6
          A1FF7DC79DFF71C796FF65C68FFF61C98EFF57BD7EFF0E6A17D708390D731A86
          29FF5BC98AFF5FC98CFF6FCA96FF81CBA1FF8ABEA0FFFFFFFFFFEEEEEEFF97B5
          A4FF8DCCA8FF7CCB9EFF6CCA95FF62CA8FFF359F4FFF0A4E119D010902121074
          1AEB41AC61FF62CA8FFF77CB9BFF8CCCA7FF96BEA7FFFFFFFFFFF0F0F0FF9DB6
          A8FF95CCACFF82CBA1FF6FCA96FF5EC386FF148121FF04210743000000000526
          084C117B1DF74BB46EFF77CB9BFF90CCA9FF9FC4AFFFD4DDD8FFD2DCD6FFA6C3
          B3FF95CCADFF7FCBA0FF5BC083FF1E8B30FF0B4E119E00000001000000000000
          00000526084D117B1EF63BA75AFF6DC792FF8BCCA7FFA1CDB4FFA0CDB3FF8FCC
          A9FF77CB9BFF46B16AFF158223FF0B5012A20001000300000000000000000000
          000000000000042007400F6D18DD158222FF2E9C48FF3AA85AFF3CAA5CFF35A2
          52FF1E8C31FF10751AED07340C69000000010000000000000000000000000000
          0000000000000000000000020105062909530A4C119A0D6216C70E6617CE0C56
          13AE08390D74010B021600000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000001010107040404230C0C0C501414146A1414146B0B0B
          0B520505052C0101010D00000001000000000000000000000000000000000000
          0000000000000303031A2323238C606060EA737373FF747474FF747474FF7272
          72FE585858E31B1B1B8704040428000000030000000000000000000000000000
          000105050527494949C97E7E7EFF979797FF9B9B9BFF979797FF9B9B9BFFA1A1
          A1FF989898FF787878FD3C3C3CC0070707380000000200000000000000000303
          0316545454D58E8E8EFFB5B5B5FFA7A7A7FF9B9B9BFF959595FF9A9A9AFFA4A4
          A4FFB2B2B2FFB9B9B9FF7F7F7FFF3B3B3BBD0404042200000000000000012525
          2584878787FFC2C2C2FFB7B7B7FFAAAAAAFFA1A1A1FF9E9E9EFFA1A1A1FFA8A8
          A8FFB3B3B3FFBFBFBFFFC4C4C4FF7B7B7BFD1919197B01010108010101096060
          60E4C1C1C1FFC6C6C6FFBABABAFFB1B1B1FFAAAAAAFFA8A8A8FFAAAAAAFFB0B0
          B0FFB7B7B7FFC1C1C1FFCBCBCBFFA8A8A8FF505050D9040404210C0C0C3C8686
          86FFCDCDCDFFCCCCCCFFC4C4C4FFC2C2C2FFC1C1C1FFC0C0C0FFC1C1C1FFC2C2
          C2FFC3C3C3FFC5C5C5FFC1C1C1FFBABABAFF717171FD0A0A0A46151515589191
          91FFCDCDCDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFE3E3E3FFBEBEBEFF797979FF14141462151515598E8E
          8EFFC8C8C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFEAEAEAFFBABABAFF7B7B7BFF15151563111111478888
          88FFC0C0C0FFCFCFCFFFD1D1D1FFD4D4D4FFD8D8D8FFDADADAFFDADADAFFD8D8
          D8FFD6D6D6FFD3D3D3FFD0D0D0FFBEBEBEFF747474FF0F0F0F4F030303116F6F
          6FF3C0C0C0FFC3C3C3FFCCCCCCFFD7D7D7FFE1E1E1FFE6E6E6FFE6E6E6FFE2E2
          E2FFDBDBDBFFD1D1D1FFC8C8C8FFB1B1B1FF656565EE03030319000000003939
          399F959595FFC5C5C5FFD0D0D0FFDFDFDFFFEBEBEBFFF1F1F1FFF0F0F0FFEAEA
          EAFFE0E0E0FFD4D4D4FFC9C9C9FF8E8E8EFF2C2C2C9400000004000000000707
          0727666666EBA7A7A7FFD1D1D1FFE2E2E2FFF0F0F0FFF9F9F9FFF4F4F4FFEBEB
          EBFFE1E1E1FFD1D1D1FFA1A1A1FF565656D80303031500000000000000000000
          00000C0C0C36686868EE9C9C9CFFCFCFCFFFE5E5E5FFF1F1F1FFEEEEEEFFDFDF
          DFFFCCCCCCFF969696FF656565ED0A0A0A360000000000000000000000000000
          0000000000000B0B0B2E4A4A4AB77B7B7BFD949494FF9B9B9BFF9C9C9CFF9393
          93FF797979FD3F3F3FAE07070726000000000000000000000000000000000000
          00000000000000000000000000001010102C2F2F2F7736363693363636942525
          2573070707250000000100000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000F76000033B200002FAC00002EAC0000
          2EB2000025750000000000000000000000000000000000000000000000000000
          0000000000000000000000000000010140B00B0BF7FF0B0BE9FF0B0BE9FF0B0B
          EDFF050591C40000000000000000000000000000000000000000000000000000
          000000000000000000000000000003033DB01F1FF7FF1E1EEAFF1E1EEAFF1F1F
          EFFF0C0C91C40000000000000000000000000000000000000000000000000000
          0000000000000000000000000000080841B03636FBFF3434EEFF3434EEFF3636
          F3FF161692C40000000000000000000000000000000000000000000000000000
          00000000000000000000000000000D0D44B04F4FFFFF4B4BF3FF4B4BF3FF4E4E
          F8FF1F1F94C40000000000000000000000000000000000000000000000000000
          0000000000000000000000000000111144B06565FFFF6060F8FF6060F8FF6565
          FDFF272796C30000000000000000000000000000000000000000000000000000
          0000000000000000000000000000141445B07878FFFF7272FCFF7272FCFF7777
          FFFF2F2F99C30000000000000000000000000000000000000000000000000000
          0000000000110000001500000003161646B58484FFFF7E7EFFFF7E7EFFFF8383
          FFFF343496C70000010500000010000000060000000000000000000000000000
          000002021767242474E831317EEF4141AFF98383FFFF7F7FFFFF7F7FFFFF8383
          FFFF5D5DD0FB2B2B74EC2F2F84F709093D7C0000000000000000000000000000
          000000000000070742527575FFFF7B7BFFFF7474FDFF7474FDFF7474FDFF7474
          FDFF7777FEFF8080FFFF1F1F869B0000151D0000000000000000000000000000
          000000000000000000000C0C5B746262FAFF6060F8FF5F5FF8FF5F5FF8FF5F5F
          F8FF6565FCFF25259CB700000000000000000000000000000000000000000000
          00000000000000000000000000001313809E4848F6FF4545F2FF4545F2FF4848
          F5FF2A2ABDD80000090D00000000000000000000000000000000000000000000
          0000000000000000000000000000000000001414A5C52C2CEFFF2B2BEEFF2121
          D5EF000017210000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000D130C0CC2E31111E5FF0101
          2E40000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000002A3A00004A630000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000005070414080D08340000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000001535147C0D500CD30202
          020A000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000001326125E069D02FF01A300FF0F3E
          0DB5000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000D160D3A099506FA03A800FF05A800FF029E
          00FF0F290E8B0000000000000000000000000000000000000000000000000000
          00000000000000000000090F09270F860CEA02AC00FF05A800FF05A800FF04AD
          00FF049500FF0D1D0D6E00000000000000000000000000000000000000000000
          00000000000004060411107A0FDB00B000FF05AB00FF05AB00FF05AB00FF05AB
          00FF03B100FF049001FF0A12094B000000000000000000000000000000000000
          0000000000001F5E1EB20CAA07FF0CA707FB04AF00FF05AF00FF05AF00FF04AF
          00FF0CAB07FD10AD0BFD137811EB1126106D0000000000000000000000000000
          000000000000080E081B030403081C411B7602B400FF05B200FF05B200FF02B6
          00FF156313C30305030B080E081A060A06130000000000000000000000000000
          00000000000000000000000000001A3A196902B700FF05B500FF05B500FF03BB
          00FF0F570DBD0000000000000000000000000000000000000000000000000000
          00000000000000000000000000001A3A196902BB00FF05B800FF05B800FF03BE
          00FF105A0EBD0000000000000000000000000000000000000000000000000000
          00000000000000000000000000001A3B196A02BE00FF05BB00FF05BB00FF03C1
          00FF105C0EBD0000000000000000000000000000000000000000000000000000
          00000000000000000000000000001A3C196A02C100FF05BE00FF05BE00FF03C4
          00FF105D0EBD0000000000000000000000000000000000000000000000000000
          00000000000000000000000000001A3C196A02C400FF05C100FF05C100FF03C7
          00FF135B10BD0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000193D196A00CA00FF01C700FF01C700FF00CE
          00FF115C10BD0000000000000000000000000000000000000000000000000000
          00000000000000000000000000001930185A21981EE6218D1ED8208D1DD81D99
          1AE121531FA00000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
end
