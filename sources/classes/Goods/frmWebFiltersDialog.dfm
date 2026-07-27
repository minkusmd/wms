object frmWebFiltersDlg: TfrmWebFiltersDlg
  Left = 0
  Top = 0
  Caption = 'Proprietatile produselor'
  ClientHeight = 695
  ClientWidth = 1107
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  DesignSize = (
    1107
    695)
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1107
    Height = 64
    Title = 'Proprietatile produselor'
    Text = 'Gestionarea proprietatilor produselor'
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
    ImageIndex = 5
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1091
    Height = 567
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object pnFilters: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 445
      Height = 567
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 0
      Align = alLeft
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 445
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridFilter: TcxGrid
        AlignWithMargins = True
        Left = 0
        Top = 31
        Width = 445
        Height = 533
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Align = alClient
        TabOrder = 1
        object cxGridFilterTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          FindPanel.ApplyInputDelay = 1500
          FindPanel.DisplayMode = fpdmAlways
          FindPanel.Layout = fplCompact
          FindPanel.Position = fppBottom
          FindPanel.UseExtendedSyntax = True
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridFilterTableCellDblClick
          OnFocusedRecordChanged = cxGridFilterTableFocusedRecordChanged
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
          Styles.OnGetContentStyle = cxGridFilterTableStylesGetContentStyle
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
    object pnParams: TPanel
      AlignWithMargins = True
      Left = 447
      Top = 0
      Width = 644
      Height = 567
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 644
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxPageControl1: TcxPageControl
        Left = 0
        Top = 30
        Width = 644
        Height = 537
        Align = alClient
        Focusable = False
        TabOrder = 1
        Properties.ActivePage = cxTabSheet1
        Properties.CustomButtons.Buttons = <>
        Properties.HideTabs = True
        ClientRectBottom = 533
        ClientRectLeft = 4
        ClientRectRight = 640
        ClientRectTop = 4
        object cxTabSheet1: TcxTabSheet
          Caption = 'Valorille filtrelor'
          ImageIndex = 0
          object cxGridParams: TcxGrid
            Left = 0
            Top = 0
            Width = 636
            Height = 306
            Margins.Left = 0
            Margins.Top = 1
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object cxGridParamsTable: TcxGridDBTableView
              PopupMenu = dxBarPopupMenu1
              Navigator.Buttons.CustomButtons = <>
              FilterBox.CriteriaDisplayStyle = fcdsText
              FilterBox.Visible = fvNever
              FindPanel.ApplyInputDelay = 1500
              FindPanel.Behavior = fcbFilter
              FindPanel.DisplayMode = fpdmAlways
              FindPanel.FocusViewOnApplyFilter = True
              FindPanel.Layout = fplCompact
              FindPanel.Position = fppBottom
              FindPanel.ShowCloseButton = False
              FindPanel.UseExtendedSyntax = True
              ScrollbarAnnotations.Active = True
              ScrollbarAnnotations.CustomAnnotations = <>
              OnCellDblClick = cxGridParamsTableCellDblClick
              OnFocusedRecordChanged = cxGridParamsTableFocusedRecordChanged
              DataController.DataModeController.GridModeBufferCount = 30
              DataController.DataSource = IBCDataSourceParams
              DataController.KeyFieldNames = 'FILTERID;FILTERPARAMID'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              DateTimeHandling.Grouping = dtgByDate
              OptionsBehavior.CopyCaptionsToClipboard = False
              OptionsBehavior.IncSearch = True
              OptionsBehavior.CopyPreviewToClipboard = False
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHorzSizing = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.MultiSelect = True
              OptionsSelection.CheckBoxPosition = cbpIndicator
              OptionsSelection.CheckBoxVisibility = [cbvDataRow]
              OptionsSelection.InvertSelect = False
              OptionsSelection.ShowCheckBoxesDynamically = True
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
              OptionsView.ColumnAutoWidth = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Styles.Header = dmAdditions.cxStyle_GridHeader
              Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
              object cxGridParams_IMAGE: TcxGridDBColumn
                DataBinding.IsNullValueType = True
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.DefaultImageIndex = 50
                Properties.Images = dmAdditions.cxImageList_SWN
                Properties.Items = <>
                HeaderAlignmentHorz = taCenter
                MinWidth = 24
                Options.Focusing = False
                Options.HorzSizing = False
                Options.Sorting = False
                VisibleForCustomization = False
                Width = 24
              end
              object cxGridParams_FILTERPARAMID: TcxGridDBColumn
                AlternateCaption = 'ID '#1087#1072#1088#1072#1084#1077#1090#1088#1072
                Caption = 'Cod'
                DataBinding.FieldName = 'FILTERPARAMID'
                DataBinding.IsNullValueType = True
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.HorzSizing = False
                Options.Sorting = False
                Width = 50
              end
              object cxGridParams_PARAM_VALUE: TcxGridDBColumn
                Caption = 'Valoarea'
                DataBinding.FieldName = 'PARAM_VALUE'
                DataBinding.IsNullValueType = True
                HeaderAlignmentHorz = taCenter
                Options.SortByDisplayText = isbtOff
                Options.Sorting = False
                VisibleForCustomization = False
                Width = 100
              end
              object cxGridParams_PARAM_VALUE_RUS: TcxGridDBColumn
                Caption = #1047#1085#1072#1095#1077#1085#1080#1077
                DataBinding.FieldName = 'PARAM_VALUE_RUS'
                DataBinding.IsNullValueType = True
                HeaderAlignmentHorz = taCenter
                Options.Sorting = False
                Width = 100
              end
              object cxGridParams_ORDERNO: TcxGridDBColumn
                DataBinding.FieldName = 'ORDERNO'
                DataBinding.IsNullValueType = True
                Visible = False
                HeaderAlignmentHorz = taCenter
                SortIndex = 0
                SortOrder = soAscending
                VisibleForCustomization = False
              end
              object cxGridParams_CREATED_BY_NAME: TcxGridDBColumn
                Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
                DataBinding.FieldName = 'CREATED_BY_NAME'
                DataBinding.IsNullValueType = True
                Visible = False
                HeaderAlignmentHorz = taCenter
                Width = 100
              end
            end
            object cxGridParamsLevel: TcxGridLevel
              GridView = cxGridParamsTable
            end
          end
          object cxGrid1: TcxGrid
            Left = 0
            Top = 314
            Width = 636
            Height = 215
            Align = alBottom
            TabOrder = 2
            object cxGrid1DBTableView1: TcxGridDBTableView
              OnKeyDown = cxGrid1DBTableView1KeyDown
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              DataController.DataSource = IBCDataSourceGoodsByFilter
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
              object cxGrid1DBTableView1_GOODSID: TcxGridDBColumn
                Caption = 'Cod'
                DataBinding.FieldName = 'GOODSID'
                DataBinding.IsNullValueType = True
                HeaderAlignmentHorz = taCenter
                Width = 48
              end
              object cxGrid1DBTableView1_WEBGoodsName: TcxGridDBColumn
                Caption = 'Tip produs'
                DataBinding.FieldName = 'WEB_GOODSTYPE_NAME'
                DataBinding.IsNullValueType = True
                Width = 100
              end
              object cxGrid1DBTableView1_GOODS_NAME: TcxGridDBColumn
                Caption = 'Produs'
                DataBinding.FieldName = 'GOODS_NAME'
                DataBinding.IsNullValueType = True
                HeaderAlignmentHorz = taCenter
                Width = 275
              end
              object cxGrid1DBTableView1_FLG_IN_PRICE: TcxGridDBColumn
                Caption = 'FP'
                DataBinding.FieldName = 'FLG_IN_PRICE'
                DataBinding.IsNullValueType = True
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                HeaderAlignmentHorz = taCenter
                Width = 24
              end
            end
            object cxGrid1Level1: TcxGridLevel
              GridView = cxGrid1DBTableView1
            end
          end
          object cxSplitter1: TcxSplitter
            Left = 0
            Top = 306
            Width = 636
            Height = 8
            AlignSplitter = salBottom
          end
        end
      end
    end
  end
  object btnOk: TcxButton
    Left = 898
    Top = 652
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 998
    Top = 652
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
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
    object dxBarManagerBar1: TdxBar
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
      FloatLeft = 650
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
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
    object dxBarManagerBar2: TdxBar
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
      FloatLeft = 650
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
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
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGoodsList'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbMergeFilters'
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
      ShortCut = 32781
      OnClick = bbFilterModifyClick
    end
    object bbParamNew: TdxBarButton
      Caption = 'Valoare noua'
      Category = 0
      Hint = 'Valoare noua'
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
      OnClick = bbFilterDeleteClick
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
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 29
      ShortCut = 16452
      OnClick = bbCloneValuesClick
    end
    object bbTools: TdxBarSubItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
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
          ItemName = 'bbMergeFilterValues'
        end
        item
          Visible = True
          ItemName = 'bbChangeFilterParent'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGoodsListByFiltersParam'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end>
    end
    object bbReadySet_YesNo: TdxBarButton
      Caption = #1047#1085#1072#1095#1077#1085#1080#1103'  ('#1076#1072'/'#1085#1077#1090')'
      Category = 0
      Hint = #1047#1085#1072#1095#1077#1085#1080#1103'  ('#1076#1072'/'#1085#1077#1090')'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbReadySet_YesNoClick
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
      ImageIndex = 12
      OnClick = bbGoodsListClick
    end
    object bbChangeFilterParent: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1088#1086#1076#1080#1090#1077#1083#1103
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1088#1086#1076#1080#1090#1077#1083#1103
      Visible = ivAlways
      ShortCut = 16461
      OnClick = bbChangeFilterParentClick
    end
    object bbMergeFilters: TdxBarButton
      Caption = #1054#1073#1100#1077#1076#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088#1072
      Category = 0
      Hint = #1054#1073#1100#1077#1076#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088#1072
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000021744558745469746C65004D657267653B4D657267696E673B436F6D
        62696E653B47726F7570BB8146A20000024249444154785E6D934F6B135114C5
        CF9BFCB349A412847E00D155C08552A1548874E14A14BA14DC04DDAB9BBA7253
        D28DB85217D245562E4A04176E45C12EA2E8420842BBA994AAB4E4AF6D2799F7
        E6BDEB7D97A409A1070E1766E6FE66CE199E82084A3CADF1353AF19492ECA052
        5BFC1004AA442080D478050407E0B8A73F55CA5F979EACCF533A93802312D2EA
        BDBA009452283DBC5D931B80059183239E60F35CADDE2DC98BCA5F1C865A599F
        9729006B09A169A239A8C33AC3D632639EB9D41CB4B6F0004CA8D7D5320301C4
        8476F803BF5A7574C25D84BA836E7F0F7F7B0DEC1F36A0238BE98E8CB1135F10
        3B58D2681EED884504C9994D15A0B5032BAD5818CB7A0B206640EC06201A97DC
        6DC5309AA03BFBC8E7D378F4EACA3FB9EB20CF75DB7AB3FAB4B12400E3019601
        8E3042A4A8806B971790CBCCA130B385E2A5AB52AC838173166B2FD7167D020F
        406C088601E77317A479E6E077BB8BC884DCC9378E7580ED66CB2F0A249DC8F2
        8EC40A3CC0FDD93DFEF8EC45F5868F40A4A480D97319443A923F91CFE630D021
        74DCC7C01C2119A44600292560A7468542849972A578B07C67017B9D9F70C36E
        FC2010177B16EF3776507BBE3D2B5FB0FCF862F4E0FECDC83A0BEF5BC5D7CABF
        6160FA30D602345C1E82A24023B612414907D611FA3AF419C5522C0342BEE60B
        86101468448A0C9CA531209B4B72B621800400FF6B23062455068E1C48C9B29C
        0E1D1B5801486E48216F37BE230A4F0E5C7CD8D29FDFBDD9BA2EB927CFA30C82
        8EDC2600A370BA12EC33ECF4E9475D509ADDFF0F469C7A0EBA2B851F00000000
        49454E44AE426082}
      OnClick = bbMergeFiltersClick
    end
    object dxBarButton2: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091' '#1080#1079' '#1079#1085#1072#1095#1077#1085#1080#1103
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091' '#1080#1079' '#1079#1085#1072#1095#1077#1085#1080#1103
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = #1054#1082#1088#1091#1075#1083#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1076#1086' '#1094#1077#1083#1086#1075#1086
      Category = 0
      Hint = #1054#1082#1088#1091#1075#1083#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1076#1086' '#1094#1077#1083#1086#1075#1086
      Visible = ivAlways
      OnClick = dxBarButton3Click
    end
    object bbMergeFilterValues: TdxBarButton
      Caption = #1054#1073#1100#1077#1076#1077#1085#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103
      Category = 1
      Hint = #1054#1073#1100#1077#1076#1077#1085#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103
      Visible = ivAlways
      ShortCut = 49219
      OnClick = bbMergeFilterValuesClick
    end
    object bbGoodsListByFiltersParam: TdxBarButton
      Caption = #1057#1087#1080#1089#1086#1082' '#1090#1086#1074#1072#1088#1072' '#1076#1083#1103' '#1072#1082#1090#1080#1074#1085#1086#1075#1086' '#1092#1080#1083#1100#1090#1088#1072
      Category = 1
      Hint = #1057#1087#1080#1089#1086#1082' '#1090#1086#1074#1072#1088#1072' '#1076#1083#1103' '#1072#1082#1090#1080#1074#1085#1086#1075#1086' '#1092#1080#1083#1100#1090#1088#1072
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = bbGoodsListByFiltersParamClick
    end
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
  object IBCQueryParams: TIBCQuery
    KeyFields = 'FILTERPARAMID'
    KeyGenerator = 'SQ_TS_FILTER_PARAMS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_FILTER_PARAMS'
      
        '  (FILTERID, FILTERPARAMID, PARAM_VALUE, PARAM_VALUE_RUS, PVALUE' +
        ', ORDERNO)'
      'VALUES'
      
        '  (:FILTERID, :FILTERPARAMID, :PARAM_VALUE, :PARAM_VALUE_RUS, :P' +
        'VALUE, :ORDERNO)')
    SQLDelete.Strings = (
      'DELETE FROM TS_FILTER_PARAMS'
      'WHERE'
      
        '  FILTERID = :Old_FILTERID AND FILTERPARAMID = :Old_FILTERPARAMI' +
        'D')
    SQLUpdate.Strings = (
      'UPDATE TS_FILTER_PARAMS'
      'SET'
      '  FILTERID = :FILTERID, '
      '  FILTERPARAMID = :FILTERPARAMID, '
      '  PARAM_VALUE = :PARAM_VALUE,'
      '  PARAM_VALUE_RUS = :PARAM_VALUE_RUS,'
      '  PVALUE = :PVALUE'
      'WHERE'
      
        '  FILTERID = :Old_FILTERID AND FILTERPARAMID = :Old_FILTERPARAMI' +
        'D')
    SQLRefresh.Strings = (
      'SELECT '
      ' FILTERID, '
      ' FILTERPARAMID, '
      ' PARAM_VALUE,'
      ' PARAM_VALUE_RUS,'
      ' PVALUE, '
      ' ORDERNO,'
      
        ' (SELECT FULL_NAME FROM TS_USERS WHERE TS_USERS.USERID=TS_FILTER' +
        '_PARAMS.CREATED_BY) CREATED_BY_NAME'
      'FROM '
      ' TS_FILTER_PARAMS'
      'WHERE'
      ' FILTERID = :FILTERID AND FILTERPARAMID = :Old_FILTERPARAMID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_FILTER_PARAMS'
      'WHERE'
      'FILTERID = :Old_FILTERID AND FILTERPARAMID = :Old_FILTERPARAMID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      ' FILTERID,'
      ' FILTERPARAMID,'
      ' PARAM_VALUE,'
      ' PARAM_VALUE_RUS,'
      ' PVALUE,'
      ' ORDERNO,'
      
        ' (SELECT FULL_NAME FROM TS_USERS WHERE TS_USERS.USERID=TS_FILTER' +
        '_PARAMS.CREATED_BY) CREATED_BY_NAME'
      'FROM'
      ' TS_FILTER_PARAMS'
      'ORDER BY PARAM_VALUE ')
    MasterFields = 'FILTERID'
    DetailFields = 'FILTERID'
    MasterSource = IBCDataSourceFilters
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 100
    LocalConstraints = False
    Left = 660
    Top = 236
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FILTERID'
        Value = nil
      end>
  end
  object IBCDataSourceParams: TIBCDataSource
    DataSet = IBCQueryParams
    Left = 660
    Top = 180
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 256
    Top = 212
  end
  object IBCQueryGoodsByFilter: TIBCQuery
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      
        'select g.*, g.title goods_name, gt.title web_goodstype_name, get' +
        '_flg_in_price(g.goodsid) flg_in_price, d.filterparamid, d.filter' +
        'id '
      'from ts_goods g'
      
        'join ts_goods_descriptions d on d.goodsid = g.goodsid and  filte' +
        'rparamid = :filterparamid'
      'join ts_goods_type gt on gt.goodstypeid=g.webgoodstype_id'
      'order by gt.title, g.title')
    MasterFields = 'FILTERPARAMID'
    DetailFields = 'FILTERPARAMID'
    MasterSource = IBCDataSourceParams
    AutoCommit = False
    Options.DetailDelay = 500
    Left = 560
    Top = 464
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'filterparamid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FILTERPARAMID'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsByFilter: TIBCDataSource
    DataSet = IBCQueryGoodsByFilter
    Left = 560
    Top = 416
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGoodsListByFiltersParam'
      end>
    UseOwnFont = False
    Left = 768
    Top = 232
    PixelsPerInch = 96
  end
end
