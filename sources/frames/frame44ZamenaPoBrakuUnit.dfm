inherited frame44ZamenaPoBraku: Tframe44ZamenaPoBraku
  Font.Height = -12
  PixelsPerInch = 120
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 358
    Width = 986
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 300
    Control = pnBottom
  end
  object cxGridDocs: TcxGrid
    Left = 0
    Top = 0
    Width = 986
    Height = 358
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridDocsTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenuDocs
      OnKeyDown = cxGridDocsTableKeyDown
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
      OnCellDblClick = cxGridDocsTableCellDblClick
      OnCustomDrawCell = cxGridDocsTableCustomDrawCell
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
      OptionsView.ScrollBars = ssVertical
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
      object cxGridNPN_FLG_CLOSED: TcxGridDBColumn
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
      object cxGridDocsTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridDocs_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridDocs_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridDocsTableWarehouse: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        Width = 100
      end
      object cxGridNPNCol_CT_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 200
      end
      object cxGridDocs_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridDocs_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridDocs_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridDocs_RATE: TcxGridDBColumn
        Caption = 'Rata Doc.'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridDocs_RATEUSD: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridDocsTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridDocs_FLG_ACNT: TcxGridDBColumn
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridDocsTableCreatedBy: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 120
        Options.HorzSizing = False
        Width = 120
      end
      object cxGridDocs_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridDocs_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridDocsTable_SC2_NAME: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'SC2_NAME'
        MinWidth = 120
        Options.HorzSizing = False
        Width = 120
      end
    end
    object cxGridDocsLevel: TcxGridLevel
      GridView = cxGridDocsTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 368
    Width = 986
    Height = 300
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object cxGridGoods: TcxGrid
      Left = 0
      Top = 34
      Width = 986
      Height = 266
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridGoodsTable: TcxGridDBTableView
        OnKeyDown = cxGridGoodsTableKeyDown
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
        OnCustomDrawCell = cxGridGoodsTableCustomDrawCell
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            FieldName = 'QTY'
            Column = cxGridDBCol_QTY
          end
          item
            Kind = skSum
            FieldName = 'SUMA'
          end
          item
            Kind = skSum
            FieldName = 'SUMAVAT'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxGridDBCol_Price
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxGridDBCol_SUMA
          end
          item
            Format = '#,##0.00'
            Kind = skSum
          end>
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
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
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'DTDEP_NAME'
          Visible = False
          MinWidth = 140
          Options.HorzSizing = False
          Width = 140
        end
        object cxGridDBCol_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBCol_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Focusing = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 24
        end
        object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_NAME'
          Width = 200
        end
        object cxGridDBCol_Price: TcxGridDBColumn
          Caption = #1062#1077#1085#1072
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBCol_K_UM: TcxGridDBColumn
          Caption = 'UM'
          DataBinding.FieldName = 'UM_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 40
        end
        object cxGridDBCol_QTY: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridGoods_PRICE: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBCol_SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Styles.Footer = dmAdditions.cxStyle_Bold
          Width = 80
        end
        object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
          Caption = #1040#1082#1090
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridDBCol_FLG_ACNT: TcxGridDBColumn
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
        object cxGridDBCol_WARRANTY: TcxGridDBColumn
          Caption = 'Garantie'
          DataBinding.FieldName = 'WARRANTY'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBCol_FLG_READY: TcxGridDBColumn
          AlternateCaption = 'Finalizat'
          Caption = 'Fin.'
          DataBinding.FieldName = 'FLG_READY'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
      end
      object cxGridGoodsLevel: TcxGridLevel
        GridView = cxGridGoodsTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
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
    Categories.Strings = (
      'Goods'
      'PopupMenuDocs')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 544
    Top = 100
    PixelsPerInch = 120
    object dxBarManagerBar1: TdxBar
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
      FloatLeft = 3
      FloatTop = 386
      FloatClientWidth = 98
      FloatClientHeight = 100
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsDelete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSerials'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPrintWaranty'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbGoodsNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbGoodsNewClick
    end
    object bbGoodsModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbGoodsModifyClick
    end
    object bbGoodsDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbGoodsDeleteClick
    end
    object bbSerials: TdxBarButton
      Caption = 'Serii/Partide'
      Category = 0
      Hint = 'Serii/Partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbSerialsClick
    end
    object bbCloseDocument: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbCloseDocumentClick
    end
    object bbOpenDocument: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      OnClick = bbOpenDocumentClick
    end
    object bbDocComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'...'
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbCreateSF: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' "'#1057#1095#1077#1090'-'#1060#1072#1082#1090#1091#1088#1072'"...'
      Category = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' "'#1057#1095#1077#1090'-'#1060#1072#1082#1090#1091#1088#1072'"'
      Visible = ivAlways
      OnClick = bbCreateSFClick
    end
    object bbCreateTTN: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' "'#1058#1086#1074#1072#1088#1086'-'#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102'"...'
      Category = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' "'#1058#1086#1074#1072#1088#1086'-'#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102'"'
      Visible = ivAlways
      OnClick = bbCreateTTNClick
    end
    object bbPrintWaranty: TdxBarButton
      Caption = 'Tipar garantie'
      Category = 0
      Hint = 'Tipar garantie'
      Visible = ivAlways
      ImageIndex = 28
      ShortCut = 49232
      OnClick = bbPrintWarantyClick
    end
  end
  object cxGridPopupMenuDocs: TcxGridPopupMenu
    PopupMenus = <
      item
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuDocs
      end>
    Left = 436
    Top = 100
  end
  object dxBarPopupMenuDocs: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDocument'
      end
      item
        Visible = True
        ItemName = 'bbOpenDocument'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCreateSF'
      end
      item
        Visible = True
        ItemName = 'bbCreateTTN'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end>
    UseOwnFont = False
    Left = 320
    Top = 100
    PixelsPerInch = 120
  end
end
