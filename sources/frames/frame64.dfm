inherited frame64: Tframe64
  Font.Height = -15
  PixelsPerInch = 120
  object cxGridNPN: TcxGrid
    Left = 0
    Top = 0
    Width = 986
    Height = 358
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridNPNTable: TcxGridDBTableView
      OnKeyDown = cxGridNPNTableKeyDown
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
      OnCellDblClick = cxGridNPNTableCellDblClick
      OnCustomDrawCell = cxGridNPNTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting]
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
      object cxGridNPNTableColumn1: TcxGridDBColumn
        Caption = #1047#1072#1082#1088
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        MinWidth = 30
        Width = 30
      end
      object cxGridNPNTable_DT_NAME: TcxGridDBColumn
        Caption = #1060#1080#1088#1084#1072
        DataBinding.FieldName = 'DT_NAME'
        MinWidth = 30
        Width = 150
      end
      object cxGridNPNTableDocID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 60
      end
      object cxGridNPN_DATA: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATA'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = cxGridNPN_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 100
      end
      object cxGridNPN_CREATED_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
        DataBinding.FieldName = 'CREATED_DATE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = cxGridNPN_CREATED_DATEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 100
      end
      object cxGridNPN_DTDEP_NAME: TcxGridDBColumn
        Caption = #1057#1082#1083#1072#1076
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 30
        Width = 100
      end
      object cxGridNPN_CT_NAME: TcxGridDBColumn
        Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 30
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 200
      end
      object cxGridNPNTableSuma: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 100
      end
      object cxGridNPN_CURRENCY_NAME: TcxGridDBColumn
        Caption = #1042#1072#1083#1102#1090#1072
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 50
      end
      object cxGridNPNTableVAT: TcxGridDBColumn
        Caption = #1053#1044#1057
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.Sorting = False
        Width = 60
      end
      object cxGridNPNTableRate: TcxGridDBColumn
        Caption = #1050#1091#1088#1089
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.Sorting = False
        Width = 40
      end
      object cxGridNPNTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 70
      end
      object cxGridNPN_RATEUSD: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 50
      end
      object cxGridNPNTable_FLG_ACNT: TcxGridDBColumn
        Caption = #1055#1041
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 40
      end
      object cxGridNPNTable_FLG_SHIP: TcxGridDBColumn
        AlternateCaption = #1054#1090#1075#1088#1091#1078#1077#1085
        Caption = #1054#1090#1075#1088'.'
        DataBinding.FieldName = 'FLG_SHIP'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 40
      end
      object cxGridNPNTable_FLG_PROTECTED: TcxGridDBColumn
        AlternateCaption = #1047#1072#1096#1080#1097#1077#1085
        Caption = #1047#1072#1096'.'
        DataBinding.FieldName = 'FLG_PROTECTED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 40
      end
      object cxGridNPNTable_CUSTOMER_TYPE_ID: TcxGridDBColumn
        DataBinding.FieldName = 'CUSTOMER_TYPE_ID'
        Visible = False
        MinWidth = 30
        VisibleForCustomization = False
      end
      object cxGridNPN_CREATED_BY_NAME: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 30
        Width = 100
      end
      object cxGridNPN_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 30
        VisibleForCustomization = False
      end
      object cxGridNPN_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        MinWidth = 30
        VisibleForCustomization = False
      end
      object cxGridNPN_SC2_NAME: TcxGridDBColumn
        Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072
        DataBinding.FieldName = 'SC2_NAME'
        MinWidth = 30
        Width = 100
      end
      object cxGridNPN_DTSC_NAME: TcxGridDBColumn
        Caption = #1057#1091#1073#1082#1086#1085#1090#1086
        DataBinding.FieldName = 'DTSC_NAME'
        MinWidth = 30
        Width = 100
      end
    end
    object cxGridNPNLevel: TcxGridLevel
      GridView = cxGridNPNTable
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
    Caption = 'pnBottom'
    TabOrder = 2
    object cxGridComponents: TcxGrid
      Left = 0
      Top = 34
      Width = 986
      Height = 266
      Align = alClient
      TabOrder = 1
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridComponentsTable: TcxGridDBTableView
        OnKeyDown = cxGridComponentsTableKeyDown
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
        OnCellDblClick = cxGridComponentsTableCellDblClick
        OnCustomDrawCell = cxGridComponentsTableCustomDrawCell
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            FieldName = 'QTY'
            Column = cxGridDBCol_QTY
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'SUMA'
            Column = cxGridDBCol_SUMA
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'SUMAVAT'
            Column = cxGridDBCol_SUMAVAT
          end
          item
            Kind = skCount
            Column = cxGridDBCol_GOODSID
          end
          item
            Format = '-0.00'
            Kind = skSum
            Column = cxGridComponents_DISCOUNT_SUMA
          end
          item
            Format = '$0.00'
            Kind = skSum
            Column = cxGridComponents_SUMA_USD
          end>
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
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.OnGetContentStyle = cxGridComponentsTableStylesGetContentStyle
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'DTDEP_NAME'
          MinWidth = 60
          Width = 100
        end
        object cxGridDBCol_GOODSID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridDBCol_IMG: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <>
          MinWidth = 24
          Options.Editing = False
          Options.Focusing = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          VisibleForCustomization = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'GOODS_NAME'
          Width = 300
        end
        object cxGridDBCol_QTY: TcxGridDBColumn
          AlternateCaption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Caption = #1050#1086#1083'-'#1074#1086
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          OnGetDisplayText = cxGridDBCol_STOCK_QTYGetDisplayText
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridComponents_UMID: TcxGridDBColumn
          DataBinding.FieldName = 'UMID'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridDBCol_UM_NAME: TcxGridDBColumn
          AlternateCaption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
          Caption = #1045#1048
          DataBinding.FieldName = 'UM_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 32
        end
        object cxGridDBCol_PRICE: TcxGridDBColumn
          Caption = #1062#1077#1085#1072
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridComponents_PRICE_USD: TcxGridDBColumn
          Caption = #1062#1077#1085#1072' USD'
          DataBinding.FieldName = 'PRICE_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridComponents_DISCOUNT_P: TcxGridDBColumn
          AlternateCaption = #1057#1082#1080#1076#1082#1072', %'
          Caption = '-%'
          DataBinding.FieldName = 'DISCOUNT_P'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '-0%'
          Properties.Nullstring = ' '
          Properties.UseNullString = True
          Visible = False
          OnGetDisplayText = cxGridComponents_DISCOUNT_PGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridComponents_DISCOUNT_SUMA: TcxGridDBColumn
          Caption = #1057#1082#1080#1076#1082#1072
          DataBinding.FieldName = 'DISCOUNT_SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '-0.00'
          Visible = False
          OnGetDisplayText = cxGridComponents_DISCOUNT_SUMAGetDisplayText
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBCol_SUMA: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
          Width = 70
        end
        object cxGridComponents_SUMA_USD: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072' USD'
          DataBinding.FieldName = 'SUMA_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBCol_SUMAVAT: TcxGridDBColumn
          Caption = #1053#1044#1057
          DataBinding.FieldName = 'SUMAVAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
          AlternateCaption = #1040#1082#1090#1080#1074#1077#1085
          Caption = #1040
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridDBCol_FLG_READY: TcxGridDBColumn
          AlternateCaption = #1043#1086#1090#1086#1074
          Caption = #1043
          DataBinding.FieldName = 'FLG_READY'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
          AlternateCaption = #1054#1089#1090#1072#1090#1086#1082
          Caption = #1054#1089#1090'.'
          DataBinding.FieldName = 'STOCK_QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          OnGetDisplayText = cxGridDBCol_STOCK_QTYGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridComponents_PRICE_COLUMN: TcxGridDBColumn
          AlternateCaption = #1050#1086#1083#1086#1085#1082#1072' '#1094#1077#1085
          Caption = #1062
          DataBinding.FieldName = 'PRICE_COLUMN'
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.HorzSizing = False
          Styles.OnGetContentStyle = cxGridComponents_PRICE_COLUMNStylesGetContentStyle
          Width = 24
        end
        object cxGridComponents_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_BY_NAME'
          BestFitMaxWidth = 150
          MinWidth = 100
          Options.Editing = False
          Options.Focusing = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Options.GroupFooters = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 100
        end
        object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
          Caption = #1050#1086#1076' '#1073#1091#1093#1075
          DataBinding.FieldName = 'GOODS_ACNT_ID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086' '#1085#1072#1082#1083#1072#1076#1085#1099#1084
          DataBinding.FieldName = 'GOODS_NAMEACNT'
          MinWidth = 50
          Width = 70
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridComponentsTable
      end
    end
    object dxBarDockControl2: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 986
      Height = 34
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'PopupDoc'
      'Goods'
      'Complect')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 232
    Top = 68
    PixelsPerInch = 120
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Goods'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 949
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbCheckStock'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbShowSerialDialog'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbActionPKO: TdxBarButton
      Caption = #1055#1088#1080#1093#1086#1076#1085#1099#1081' '#1082#1072#1089#1089#1086#1074#1099#1081' '#1086#1088#1076#1077#1088'...'
      Category = 0
      Hint = #1055#1088#1080#1093#1086#1076#1085#1099#1081' '#1082#1072#1089#1089#1086#1074#1099#1081' '#1086#1088#1076#1077#1088
      Visible = ivAlways
      ShortCut = 16457
      OnClick = bbActionPKOClick
    end
    object bbActionRKO: TdxBarButton
      Caption = #1056#1072#1089#1093#1086#1076#1085#1099#1081' '#1082#1072#1089#1089#1086#1074#1099#1081' '#1086#1088#1076#1077#1088'...'
      Category = 0
      Hint = #1056#1072#1089#1093#1086#1076#1085#1099#1081' '#1082#1072#1089#1089#1086#1074#1099#1081' '#1086#1088#1076#1077#1088
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbActionRKOClick
    end
    object bbActionSNS: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1072#1088#1103#1076' '#1085#1072' '#1089#1073#1086#1088#1082#1091'...'
      Category = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1072#1088#1103#1076' '#1085#1072' '#1089#1073#1086#1088#1082#1091
      Visible = ivAlways
      ShortCut = 16467
      OnClick = bbActionSNSClick
    end
    object bbActionOtgruziti: TdxBarButton
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080' '#1080' '#1086#1090#1075#1088#1091#1079#1080#1090#1100'...'
      Category = 0
      Hint = #1055#1088#1086#1074#1077#1089#1090#1080' '#1080' '#1086#1090#1075#1088#1091#1079#1080#1090#1100
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbActionOtgruzitiClick
    end
    object bbActionVSF: TdxBarButton
      Caption = #1042#1099#1087#1080#1089#1072#1090#1100' "'#1057#1095#1077#1090' '#1092#1072#1082#1090#1091#1088#1091'"...'
      Category = 0
      Hint = #1042#1099#1087#1080#1089#1072#1090#1100' "'#1057#1095#1077#1090' '#1092#1072#1082#1090#1091#1088#1091'"'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbActionVSFClick
    end
    object bbActionStartEnterSerials: TdxBarButton
      Caption = #1053#1072#1095#1072#1090#1100' '#1074#1074#1086#1076#1080#1090#1100' '#1089#1077#1088#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072'...'
      Category = 0
      Hint = #1053#1072#1095#1072#1090#1100' '#1074#1074#1086#1076#1080#1090#1100' '#1089#1077#1088#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
      Visible = ivAlways
      ImageIndex = 30
      ShortCut = 16471
      OnClick = bbActionStartEnterSerialsClick
    end
    object bbRollbackOtgruzka: TdxBarButton
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1086#1076#1082#1091'...'
      Category = 0
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1086#1076#1082#1091
      Visible = ivAlways
      OnClick = bbRollbackOtgruzkaClick
    end
    object bbPrintWarranty: TdxBarButton
      Caption = #1055#1077#1095#1072#1090#1100' '#1075#1072#1088#1072#1085#1090#1080#1081#1085#1086#1075#1086' '#1090#1072#1083#1086#1085#1072'...'
      Category = 0
      Hint = #1055#1077#1095#1072#1090#1100' '#1075#1072#1088#1072#1085#1090#1080#1081#1085#1086#1075#1086' '#1090#1072#1083#1086#1085#1072
      Visible = ivAlways
      ImageIndex = 28
      ShortCut = 24656
      OnClick = bbPrintWarrantyClick
    end
    object bbBringGoods: TdxBarButton
      Caption = #1055#1088#1080#1085#1077#1089#1090#1080' '#1090#1086#1074#1072#1088'...'
      Category = 0
      Hint = #1055#1088#1080#1085#1077#1089#1090#1080' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      OnClick = bbBringGoodsClick
    end
    object bbCustomerDebts: TdxBarButton
      Caption = #1058#1077#1082#1091#1097#1080#1077' '#1076#1086#1083#1075#1080' '#1082#1083#1080#1077#1085#1090#1072'...'
      Category = 0
      Hint = #1058#1077#1082#1091#1097#1080#1077' '#1076#1086#1083#1075#1080' '#1082#1083#1080#1077#1085#1090#1072
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object bbCalcProfitability: TdxBarButton
      Caption = #1056#1072#1089#1095#1077#1090' '#1088#1077#1085#1090#1072#1073#1080#1083#1100#1085#1086#1089#1090#1080'...'
      Category = 0
      Hint = #1056#1072#1089#1095#1077#1090' '#1088#1077#1085#1090#1072#1073#1080#1083#1100#1085#1086#1089#1090#1080
      Visible = ivAlways
      ShortCut = 16466
      OnClick = bbCalcProfitabilityClick
    end
    object bbGotoParentDoc: TdxBarButton
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1085#1072#1095#1072#1083#1100#1085#1086#1084#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Category = 0
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1085#1072#1095#1072#1083#1100#1085#1086#1084#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Visible = ivAlways
      OnClick = bbGotoParentDocClick
    end
    object bbActiuneTVA: TdxBarButton
      Caption = #1040#1082#1094#1080#1103' "TVA '#238'napoi"...'
      Category = 0
      Hint = #1040#1082#1094#1080#1103' "TVA '#238'napoi"'
      Visible = ivNever
      OnClick = bbActiuneTVAClick
    end
    object bbDebtsNotify: TdxBarButton
      Caption = #1053#1072#1087#1086#1084#1080#1085#1072#1085#1080#1077' '#1086' '#1076#1086#1083#1075#1072#1093'...'
      Category = 0
      Hint = #1053#1072#1087#1086#1084#1080#1085#1072#1085#1080#1077' '#1086' '#1076#1086#1083#1075#1072#1093
      Visible = ivAlways
      OnClick = bbDebtsNotifyClick
    end
    object bbApplyPromoCode: TdxBarButton
      Caption = #1044#1080#1089#1082#1086#1091#1085#1090'-'#1082#1086#1076'...'
      Category = 0
      Hint = #1044#1080#1089#1082#1086#1091#1085#1090'-'#1082#1086#1076
      Visible = ivNever
      OnClick = bbApplyPromoCodeClick
    end
    object bbActiuni: TdxBarSubItem
      Caption = #1040#1082#1094#1080#1080
      Category = 0
      Visible = ivAlways
      ImageIndex = 3
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbActiuneTVA'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbApplyPromoCode'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbWinterPromoCode'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCodeActiune'
        end>
    end
    object bbWinterPromoCode: TdxBarButton
      Caption = #1053#1086#1074#1086#1075#1086#1076#1085#1080#1081' '#1087#1088#1086#1084#1086'-'#1082#1086#1076'...'
      Category = 0
      Hint = #1053#1086#1074#1086#1075#1086#1076#1085#1080#1081' '#1087#1088#1086#1084#1086'-'#1082#1086#1076
      Visible = ivNever
      OnClick = bbWinterPromoCodeClick
    end
    object bbDocComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'...'
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbCodeActiune: TdxBarButton
      Caption = #1050#1086#1076' '#1082' '#1072#1082#1094#1080#1080'...'
      Category = 0
      Hint = #1050#1086#1076' '#1082' '#1072#1082#1094#1080#1080
      Visible = ivAlways
      ImageIndex = 3
      OnClick = bbCodeActiuneClick
    end
    object bbChangeColumnPrice: TdxBarButton
      Tag = 9
      Caption = #1062#1077#1085#1072' '#1082#1083#1080#1077#1085#1090#1072'...'
      Category = 0
      Hint = #1062#1077#1085#1072' '#1082#1083#1080#1077#1085#1090#1072
      Visible = ivAlways
      ImageIndex = 49
      PaintStyle = psCaptionGlyph
      OnClick = bbChangeColumnPriceClick
    end
    object bbCreateProformaInvoice: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1089#1095#1077#1090' '#1085#1072' '#1086#1087#1083#1072#1090#1091
      Category = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1089#1095#1077#1090' '#1085#1072' '#1086#1087#1083#1072#1090#1091
      Visible = ivAlways
      OnClick = bbCreateProformaInvoiceClick
    end
    object bbCreateCec: TdxBarButton
      Caption = #1042#1099#1087#1080#1089#1072#1090#1100' '#1095#1077#1082'...'
      Category = 0
      Hint = #1042#1099#1087#1080#1089#1072#1090#1100' '#1095#1077#1082
      Visible = ivAlways
      ImageIndex = 47
      OnClick = bbCreateCecClick
    end
    object bbCheckStock: TdxBarButton
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1086#1089#1090#1072#1090#1082#1080
      Category = 0
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1086#1089#1090#1072#1090#1082#1080
      Visible = ivAlways
      ImageIndex = 38
      PaintStyle = psCaptionGlyph
      OnClick = bbCheckStockClick
    end
    object bbTTN: TdxBarButton
      Caption = #1042#1099#1087#1080#1089#1072#1090#1100' '#1090#1086#1074#1072#1088#1086'-'#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102'...'
      Category = 0
      Hint = #1042#1099#1087#1080#1089#1072#1090#1100' '#1090#1086#1074#1072#1088#1086'-'#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102
      Visible = ivAlways
      OnClick = bbTTNClick
    end
    object bbSubItemsPriceColumns: TdxBarSubItem
      Caption = #1050#1086#1083#1086#1085#1082#1072' '#1094#1077#1085
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbChangeColumnPrice'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbPriceCol0'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbPriceCol1'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol2'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol3'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol4'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol5'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol6'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol7'
        end>
    end
    object bbPriceCol1: TdxBarButton
      Tag = 1
      Caption = '1 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 0
      Hint = '1 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivAlways
      ShortCut = 16433
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol2: TdxBarButton
      Tag = 2
      Caption = '2 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 0
      Hint = '2 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivAlways
      ShortCut = 16434
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol3: TdxBarButton
      Tag = 3
      Caption = '3 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 0
      Hint = '3 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivAlways
      ShortCut = 16435
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol4: TdxBarButton
      Tag = 4
      Caption = '4 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 0
      Hint = '4 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivAlways
      ShortCut = 16436
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol5: TdxBarButton
      Tag = 5
      Caption = '5 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 0
      Hint = '5 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivAlways
      ShortCut = 16437
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol6: TdxBarButton
      Tag = 6
      Caption = '6 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 0
      Hint = '6 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivAlways
      ShortCut = 16438
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol7: TdxBarButton
      Tag = 7
      Caption = '7 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 0
      Hint = '7 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivAlways
      ShortCut = 16439
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol0: TdxBarButton
      Caption = #1042#1093#1086#1076#1085#1072#1103' '#1094#1077#1085#1072'...'
      Category = 0
      Hint = #1042#1093#1086#1076#1085#1072#1103' '#1094#1077#1085#1072
      Visible = ivAlways
      OnClick = bbChangeColumnPriceClick
    end
    object bbGoodsForeignCode: TdxBarButton
      Caption = #1057#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1076#1088#1091#1075#1080#1093' '#1092#1080#1088#1084#1072#1093'...'
      Category = 0
      Hint = #1057#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1076#1088#1091#1075#1080#1093' '#1092#1080#1088#1084#1072#1093
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCodeClick
    end
    object bbNewGoods: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
      Category = 1
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewGoodsClick
    end
    object bbModifyGoods: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 1
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyGoodsClick
    end
    object bbRemoveGoods: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 1
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveGoodsClick
    end
    object bbShowSerialDialog: TdxBarButton
      Caption = #1057#1077#1088#1080#1081#1085#1099#1077'/'#1087#1072#1088#1090#1080#1081#1085#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
      Category = 1
      Hint = #1057#1077#1088#1080#1081#1085#1099#1077'/'#1087#1072#1088#1090#1080#1081#1085#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbShowSerialDialogClick
    end
    object bbGoodsChangeUser: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103'...'
      Category = 1
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      Visible = ivAlways
      ImageIndex = 10
      OnClick = bbGoodsChangeUserClick
    end
    object bbGoodsPrice: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1094#1077#1085#1099' '#1090#1086#1074#1072#1088#1072'...'
      Category = 1
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1094#1077#1085#1099' '#1090#1086#1074#1072#1088#1072
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbGoodsPriceClick
    end
    object bbGoodsInfoCard: TdxBarButton
      Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1090#1086#1074#1072#1088#1072'...'
      Category = 1
      Hint = #1050#1072#1088#1090#1086#1095#1082#1072' '#1090#1086#1074#1072#1088#1072
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsInfoCardClick
    end
  end
  object pmPopupMenuDocs: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbActionPKO'
      end
      item
        Visible = True
        ItemName = 'bbActionRKO'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbActionSNS'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbActionVSF'
      end
      item
        Visible = True
        ItemName = 'bbTTN'
      end
      item
        Visible = True
        ItemName = 'bbCreateCec'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCreateProformaInvoice'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCustomerDebts'
      end
      item
        Visible = True
        ItemName = 'bbDebtsNotify'
      end
      item
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbBringGoods'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbActionOtgruziti'
      end
      item
        Visible = True
        ItemName = 'bbRollbackOtgruzka'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbActionStartEnterSerials'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGotoParentDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCalcProfitability'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbPrintWarranty'
      end>
    UseOwnFont = False
    OnPopup = pmPopupMenuDocsPopup
    Left = 100
    Top = 72
    PixelsPerInch = 120
  end
  object cxGridPopupMenuNPN: TcxGridPopupMenu
    Grid = cxGridNPN
    PopupMenus = <
      item
        GridView = cxGridNPNTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmPopupMenuDocs
      end>
    Left = 376
    Top = 68
  end
  object ppJurnal: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbShowSerialDialog'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGoodsInfoCard'
      end
      item
        Visible = True
        ItemName = 'bbGoodsPrice'
      end
      item
        Visible = True
        ItemName = 'bbGoodsForeignCode'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGoodsChangeUser'
      end>
    UseOwnFont = False
    Left = 96
    Top = 188
    PixelsPerInch = 120
  end
  object cxGridPopupmMenuComponents: TcxGridPopupMenu
    Grid = cxGridComponents
    PopupMenus = <
      item
        GridView = cxGridComponentsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = ppJurnal
      end>
    Left = 96
    Top = 248
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 232
    Top = 160
  end
  object IBCQueryDocs: TIBCQuery
    KeyFields = 'DOCID'
    KeyGenerator = 'SQ_TDB_DOCS_DOCID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS'
      '  (DOCID, DOCNO, DATA, '
      
        '   DT, DT_NAME, CT, CT_NAME, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAM' +
        'E, '
      '   DTSC, SC2,'
      '   SUMA, VAT, CURRENCYID, DISCOUNT, RATE, '
      ''
      '   FLG_SHIP, FLG_ACNT, FLG_DEL, FLG_PROTECTED,'
      '   FLG_SEND, FLG_RECEIVE, FLG_PAID, FLG_INVOICE, '
      '   FLG_GOODS_ARRIVAL, FLG_READY, FLG_CHILD, FLG_NEW_CEC,'
      ''
      '   CREATED_DATE, CREATED_BY, DELETED_DATE, DELETED_BY, '
      '   PARENTDOCID, ACC$MASK, DOCTYPEID,'
      '   RATEUSD,'
      '   CONTRACTID,'
      '   CTSC'
      '  )'
      'VALUES'
      
        '  (:DOCID, :DOCNO, :DATA, :DT, :DT_NAME, :CT, :CT_NAME, :DTDEP, ' +
        ':DTDEP_NAME, :CTDEP, :CTDEP_NAME, '
      '   :DTSC, :SC2,'
      '   :SUMA, :VAT, :CURRENCYID, :DISCOUNT, :RATE, '
      ''
      '   :FLG_SHIP, :FLG_ACNT, :FLG_DEL, :FLG_PROTECTED,'
      '   :FLG_SEND, :FLG_RECEIVE, :FLG_PAID, :FLG_INVOICE, '
      '   :FLG_GOODS_ARRIVAL, :FLG_READY, :FLG_CHILD, :FLG_NEW_CEC,'
      ' '
      '   :CREATED_DATE, :CREATED_BY, :DELETED_DATE, :DELETED_BY, '
      '   :PARENTDOCID, :"ACC$MASK", :DOCTYPEID,'
      '   :RATEUSD,'
      '   :CONTRACTID,'
      ':CTSC'
      '  )')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DOCS'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DOCS'
      'SET'
      '  DOCID = :DOCID, '
      '  DOCNO = :DOCNO, '
      '  DATA = :DATA, '
      '  DT = :DT, '
      '  DT_NAME = :DT_NAME, '
      '  CT = :CT, '
      '  CT_NAME = :CT_NAME, '
      '  DTDEP = :DTDEP, '
      '  DTDEP_NAME = :DTDEP_NAME, '
      '  CTDEP = :CTDEP, '
      '  CTDEP_NAME = :CTDEP_NAME, '
      '  DTSC = :DTSC, '
      '  SC2 = :SC2,'
      '  SUMA = :SUMA, '
      '  VAT = :VAT, '
      '  CURRENCYID = :CURRENCYID, '
      '  DISCOUNT = :DISCOUNT, '
      '  RATE = :RATE, '
      '  FLG_SHIP = :FLG_SHIP,'
      '  FLG_ACNT = :FLG_ACNT, '
      '  FLG_DEL = :FLG_DEL, '
      '  FLG_PROTECTED = :FLG_PROTECTED, '
      '  FLG_SEND = :FLG_SEND,'
      '  FLG_RECEIVE = :FLG_RECEIVE,'
      '  FLG_PAID = :FLG_PAID,'
      '  FLG_INVOICE = :FLG_INVOICE,'
      '  FLG_GOODS_ARRIVAL = :FLG_GOODS_ARRIVAL,'
      '  FLG_READY = :FLG_READY,'
      '  flg_child = :FLG_CHILD,'
      '  FLG_NEW_CEC = :FLG_NEW_CEC,'
      ''
      '  CREATED_DATE = :CREATED_DATE, '
      '  CREATED_BY = :CREATED_BY, '
      '  DELETED_DATE = :DELETED_DATE, '
      '  DELETED_BY = :DELETED_BY, '
      '  PARENTDOCID = :PARENTDOCID, '
      '  ACC$MASK = :"ACC$MASK", '
      '  DOCTYPEID = :DOCTYPEID,'
      ''
      '  RATEUSD = :RATEUSD,'
      '  CONTRACTID = :CONTRACTID'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      'SELECT'
      ' VW_TDB_DOCS.*,'
      ' IIF((CT=:DT),1,0) INCOMING_DOC,'
      
        ' IIF(EXISTS(SELECT GOODSID FROM TDB_JURNAL WHERE TDB_JURNAL.DOCI' +
        'D=VW_TDB_DOCS.DOCID),1,0) HAS_JURNAL_GOODS,'
      
        ' (SELECT CUSTOMER_TYPE_ID FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUS' +
        'TOMERID=VW_TDB_DOCS.CT) CUSTOMER_TYPE_ID,'
      
        ' iif (exists(select docid from tdb_docs_attachments da where (da' +
        '.docid=VW_TDB_DOCS.docid)),1,0) HasDoc_Attached,'
      
        ' COALESCE((SELECT pricecolumn FROM ts_cust_info WHERE customerid' +
        ' = VW_TDB_DOCS.CT),1) CUSTOMER_PRICE_COLUMN,'
      ' B.BANKNAME,'
      ' CA.BANKACCOUNT,'
      ' CA.ACCOUNTNAME,'
      ' CA.ACCOUNTNUMBER'
      'FROM'
      ' VW_TDB_DOCS'
      
        'LEFT JOIN TS_CUST_ACCOUNTS CA ON CA.CUSTOMERID = VW_TDB_DOCS.DT ' +
        'AND CA.ACCOUNTNUMBER = (SELECT DR.DT_CD FROM TDB_DOCS_RECHIZITE ' +
        'DR WHERE DR.DOCID = VW_TDB_DOCS.DOCID)'
      'LEFT JOIN TS_BANKS B ON B.BANKACCOUNT = CA.BANKACCOUNT'
      'WHERE'
      ' VW_TDB_DOCS.DOCID = :DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_DOCS.*,'
      ' IIF((CT=:DT),1,0) INCOMING_DOC,'
      
        ' IIF(EXISTS(SELECT GOODSID FROM TDB_JURNAL WHERE TDB_JURNAL.DOCI' +
        'D=VW_TDB_DOCS.DOCID),1,0) HAS_JURNAL_GOODS,'
      
        ' (SELECT CUSTOMER_TYPE_ID FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUS' +
        'TOMERID=VW_TDB_DOCS.CT) CUSTOMER_TYPE_ID,'
      
        ' iif (exists(select docid from tdb_docs_attachments da where (da' +
        '.docid=VW_TDB_DOCS.docid)),1,0) HasDoc_Attached,'
      
        ' COALESCE((SELECT pricecolumn FROM ts_cust_info WHERE customerid' +
        ' = VW_TDB_DOCS.CT),1) CUSTOMER_PRICE_COLUMN,'
      ' B.BANKNAME,'
      ' CA.BANKACCOUNT,'
      ' CA.ACCOUNTNAME,'
      ' CA.ACCOUNTNUMBER'
      'FROM'
      ' VW_TDB_DOCS'
      
        'LEFT JOIN TS_CUST_ACCOUNTS CA ON CA.CUSTOMERID = VW_TDB_DOCS.DT ' +
        'AND CA.ACCOUNTNUMBER = (SELECT DR.DT_CD FROM TDB_DOCS_RECHIZITE ' +
        'DR WHERE DR.DOCID = VW_TDB_DOCS.DOCID)'
      'LEFT JOIN TS_BANKS B ON B.BANKACCOUNT = CA.BANKACCOUNT'
      'WHERE DOCTYPEID=107 and VW_TDB_DOCS.FLG_CLOSED=0 ')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 100
    IndexFieldNames = 'DATA'
    Left = 232
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCQueryJurnal: TIBCQuery
    KeyFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_JURNAL'
      
        '  (DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLECT_ID' +
        ', GOODSCOMPLECT_NAME, '
      '   GOODSID, GOODS_NAME, GOODS_TYPE_ID, '
      
        '   UMID, UM_NAME, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY' +
        ', COST, '
      '   FLG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, :GOODSCOMPL' +
        'ECT_ID, :GOODSCOMPLECT_NAME, '
      '   :GOODSID, :GOODS_NAME, :GOODS_TYPE_ID, '
      
        '   :UMID, :UM_NAME, :QTY, :PRICE, :SUMA, :SUMAVAT, :WARRANTY, :S' +
        'TOCK_QTY, :COST, '
      '   :FLG_ACTIVE, :FLG_ACNT, :FLG_READY, :FLG_DELETE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_JURNAL'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_JURNAL'
      'SET'
      
        ' DOCID = :DOCID, DTDEP = :DTDEP, DTDEP_NAME = :DTDEP_NAME, CTDEP' +
        ' = :CTDEP, CTDEP_NAME = :CTDEP_NAME, '
      
        ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID, GOODSCOMPLECT_NAME = :GOO' +
        'DSCOMPLECT_NAME, '
      ' GOODSID = :GOODSID, GOODS_NAME = :GOODS_NAME, '
      
        ' GOODS_TYPE_ID = :GOODS_TYPE_ID, UMID = :UMID, UM_NAME = :UM_NAM' +
        'E, QTY = :QTY, '
      
        ' PRICE = :PRICE, SUMA = :SUMA, SUMAVAT = :SUMAVAT, WARRANTY = :W' +
        'ARRANTY, STOCK_QTY = :STOCK_QTY, '
      ' COST = :COST, '
      ''
      ' FLG_ACTIVE = :FLG_ACTIVE, '
      ' FLG_ACNT = :FLG_ACNT, '
      ' FLG_READY = :FLG_READY, '
      ' FLG_DELETE = :FLG_DELETE'
      ''
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' IIF(ACNT_PRICE<PRICE_ACNT_LOW_BOUND OR ACNT_PRICE>PRICE_ACNT_HI' +
        'GH_BOUND,1,0) FLG_ACNT_PRICE_OUT_OF_BOUNDS'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' DOCID = :DOCID AND '
      ' DTDEP = :DTDEP AND'
      ' CTDEP = :CTDEP AND'
      ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID AND'
      ' GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_JURNAL'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID'
      'FOR UPDATE WITH LOCK')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' IIF(ACNT_PRICE<PRICE_ACNT_LOW_BOUND OR ACNT_PRICE>PRICE_ACNT_HI' +
        'GH_BOUND,1,0) FLG_ACNT_PRICE_OUT_OF_BOUNDS'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceDocs
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    Left = 376
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 376
    Top = 160
  end
end
