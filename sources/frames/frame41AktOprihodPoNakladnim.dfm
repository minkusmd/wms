inherited frame41AktOprihodPoNakladnim: Tframe41AktOprihodPoNakladnim
  Width = 1134
  Height = 633
  Font.Height = -15
  ExplicitWidth = 1134
  ExplicitHeight = 633
  PixelsPerInch = 120
  object cxGridPTN: TcxGrid
    Left = 0
    Top = 0
    Width = 1134
    Height = 338
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridPTNTable: TcxGridDBTableView
      OnKeyDown = cxGridPTNTableKeyDown
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
      OnCellDblClick = cxGridPTNTableCellDblClick
      OnCustomDrawCell = cxGridPTNTableCustomDrawCell
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
      OptionsView.NavigatorOffset = 63
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssNone
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
      object cxGridPTN_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridPTN_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
      end
      object cxGridPTN_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        Width = 100
      end
      object cxGridPTN_CT_NAME: TcxGridDBColumn
        Caption = 'Intreprindere'
        DataBinding.FieldName = 'DT_NAME'
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 200
      end
      object cxGridPTN_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridPTN_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridPTN_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridPTN_FLG_ACNT: TcxGridDBColumn
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridPTN_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Operator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 112
      end
      object cxGridPTN_FLG_CLOSED: TcxGridDBColumn
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
    end
    object cxGridPTNLevel: TcxGridLevel
      GridView = cxGridPTNTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 348
    Width = 1134
    Height = 285
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1134
      Height = 34
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridComponents: TcxGrid
      Left = 0
      Top = 34
      Width = 1134
      Height = 251
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
            Format = '0'
            Kind = skCount
            Column = cxGridDBCol_GOODSID
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
        object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
          Caption = 'Depozit'
          DataBinding.FieldName = 'DTDEP_NAME'
          MinWidth = 140
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 140
        end
        object cxGridDBCol_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBCol_IMG: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 12
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 44
              Value = 4203
            end>
          MinWidth = 26
          Options.Focusing = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          VisibleForCustomization = False
          Width = 26
          IsCaptionAssigned = True
        end
        object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_NAME'
          Options.Grouping = False
          Options.Moving = False
          Width = 200
        end
        object cxGridDBCol_QTY: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.Focusing = False
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridDBCol_UM_NAME: TcxGridDBColumn
          Caption = 'UM'
          DataBinding.FieldName = 'UM_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 40
        end
        object cxGridDBCol_PRICE: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridDBCol_SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Grouping = False
          Options.HorzSizing = False
          Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
          Width = 80
        end
        object cxGridDBCol_SUMAVAT: TcxGridDBColumn
          Caption = 'TVA'
          DataBinding.FieldName = 'SUMAVAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
          Caption = 'Activ'
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
          Caption = 'Sold'
          DataBinding.FieldName = 'STOCK_QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Grouping = False
          Options.HorzSizing = False
        end
        object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
          Caption = 'Cod cntb'
          DataBinding.FieldName = 'GOODS_ACNT_ID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn
          Caption = 'Denumire cntb'
          DataBinding.FieldName = 'GOODS_NAMEACNT'
          MinWidth = 50
          Width = 70
        end
        object cxGridComponents_UMID: TcxGridDBColumn
          DataBinding.FieldName = 'UMID'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridComponentsTable
      end
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 338
    Width = 1134
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 300
    Control = pnBottom
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Toolbar'
      'PopupMenu')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 228
    Top = 476
    PixelsPerInch = 120
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = #1057#1087#1080#1089#1086#1082' '#1090#1086#1074#1072#1088#1086#1074
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 3
      FloatTop = 386
      FloatClientWidth = 82
      FloatClientHeight = 72
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteGoods'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbImport'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbAddGoods: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddGoodsClick
    end
    object bbModifyGoods: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyGoodsClick
    end
    object bbDeleteGoods: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteGoodsClick
    end
    object bbImport: TdxBarButton
      Caption = 'Import...'
      Category = 0
      Hint = 'Import'
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbImportClick
    end
    object bbActionCloseDoc: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1085#1072#1082#1083#1072#1076#1085#1091#1102'...'
      Category = 1
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1085#1072#1082#1083#1072#1076#1085#1091#1102
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbActionCloseDocClick
    end
    object bbActionOpenDoc: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1085#1072#1082#1083#1072#1076#1085#1091#1102'...'
      Category = 1
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1085#1072#1082#1083#1072#1076#1085#1091#1102
      Visible = ivAlways
      OnClick = bbActionOpenDocClick
    end
  end
  object dxPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbActionCloseDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbActionOpenDoc'
      end>
    ItemOptions.ShowDescriptions = False
    ItemOptions.Size = misNormal
    UseOwnFont = False
    Left = 292
    Top = 124
    PixelsPerInch = 120
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGridPTN
    PopupMenus = <
      item
        GridView = cxGridPTNTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxPopupMenu
      end>
    Left = 528
    Top = 112
  end
end
