inherited frame19ScetaVhodnieSceta: Tframe19ScetaVhodnieSceta
  Width = 1092
  Height = 639
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 1092
  ExplicitHeight = 639
  object cxGridPTN: TcxGrid
    Left = 0
    Top = 0
    Width = 1092
    Height = 403
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridPTNTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenuDOCS
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
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '0.00'
          Kind = skSum
          FieldName = 'SUMA'
          Column = cxGridPTN_SUMA
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0.00'
          Kind = skSum
          FieldName = 'SUMA'
          Column = cxGridPTN_SUMA
        end>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridPTN_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridPTN_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridPTN_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridPTN_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 88
        Options.HorzSizing = False
        Width = 88
      end
      object cxGridPTN_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 16
        Width = 118
      end
      object cxGridPTN_CT_NAME: TcxGridDBColumn
        Caption = 'Furnizor'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 16
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 186
      end
      object cxGridPTN_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridPTN_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridPTN_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 56
      end
      object cxGridPTN_RATEUSD: TcxGridDBColumn
        Caption = 'Curs $'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridPTN_FLG_ACNT: TcxGridDBColumn
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridPTN_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 16
        Width = 93
      end
      object cxGridPTN_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridPTN_SC2_NAME: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'SC2_NAME'
        MinWidth = 16
        Width = 46
      end
    end
    object cxGridPTNLevel: TcxGridLevel
      GridView = cxGridPTNTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 411
    Width = 1092
    Height = 228
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1092
      Height = 30
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridComponents: TcxGrid
      Left = 0
      Top = 30
      Width = 1092
      Height = 198
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 1
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridComponentsTable: TcxGridDBTableView
        PopupMenu = dxBarPopupMenuCOMPONENTS
        OnKeyDown = cxGridComponentsTableKeyDown
        OnKeyPress = cxGridComponentsTableKeyPress
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
        OnCustomDrawCell = cxGridComponentsTableCustomDrawCell
        DataController.DataSource = dmDB.IBCDataSourceJurnal
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
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
          Caption = 'Depozit beneficiar'
          DataBinding.FieldName = 'DTDEP_NAME'
          MinWidth = 112
          Options.HorzSizing = False
          Width = 112
        end
        object cxGridDBCol_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
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
          MinWidth = 21
          Options.Focusing = False
          Options.HorzSizing = False
          Options.Moving = False
          VisibleForCustomization = False
          Width = 21
          IsCaptionAssigned = True
        end
        object cxGridComponentsTableColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_PROMO'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilGoodsProperties
          Properties.Items = <
            item
              Description = 'Promotie'
              ImageIndex = 6
              Value = 1
            end>
          MinWidth = 22
          Options.HorzSizing = False
          Width = 22
          IsCaptionAssigned = True
        end
        object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_NAME'
          MinWidth = 16
          Options.Moving = False
          Width = 160
        end
        object cxGridDBCol_QTY: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
          Caption = 'Sold'
          DataBinding.FieldName = 'STOCK_QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 38
          Options.HorzSizing = False
          Width = 38
        end
        object cxGridDBCol_UM_NAME: TcxGridDBColumn
          Caption = 'UM'
          DataBinding.FieldName = 'UM_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 32
        end
        object cxGridDBCol_PRICE: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
        end
        object cxGridDBCol_SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
          Width = 64
        end
        object cxGridDBCol_SUMAVAT: TcxGridDBColumn
          Caption = 'TVA'
          DataBinding.FieldName = 'SUMAVAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
        end
        object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
          Caption = 'Activ'
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Options.HorzSizing = False
          Width = 32
        end
        object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
          Caption = 'Cntb'
          DataBinding.FieldName = 'GOODS_ACNT_ID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn
          Caption = 'Denumire facturi'
          DataBinding.FieldName = 'GOODS_NAMEACNT'
          MinWidth = 40
          Width = 56
        end
        object cxGridComponents_PRICE_USD: TcxGridDBColumn
          Caption = 'Pret, $'
          DataBinding.FieldName = 'PRICE_USD'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '# ##0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 29
        end
        object cxGridComponents_SUMA_USD: TcxGridDBColumn
          Caption = #425', $'
          DataBinding.FieldName = 'SUMA_USD'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '# ##0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 29
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridComponentsTable
      end
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 403
    Width = 1092
    Height = 8
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    DragThreshold = 2
    PositionAfterOpen = 24
    MinSize = 240
    Control = pnBottom
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 264
    Top = 68
    PixelsPerInch = 96
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
          Visible = True
          ItemName = 'bbGoodsTools'
        end
        item
          BeginGroup = True
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
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteGoods'
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
      ShortCut = 115
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
    object bbCreatePrihodRashod: TdxBarButton
      Caption = 'Creaza factura de intrare...'
      Category = 0
      Hint = 'Creaza factura de intrare'
      Visible = ivAlways
      OnClick = bbCreatePrihodRashodClick
    end
    object bbDocComments: TdxBarButton
      Caption = 'Mentiuni'
      Category = 0
      Hint = 'Mentiuni'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbCustomerDebts: TdxBarButton
      Caption = 'Datoriile curente...'
      Category = 0
      Hint = 'Datoriile curente'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object bbGoodsTools: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbImportGoods'
        end
        item
          Visible = True
          ItemName = 'bbAnalyzeGoods'
        end>
    end
    object bbImportGoods: TdxBarButton
      Caption = 'Import produse din lista furnizorului'
      Category = 0
      Hint = 'Import produse din lista furnizorului'
      Visible = ivAlways
      ImageIndex = 141
      ShortCut = 16457
      OnClick = bbImportGoodsClick
    end
    object bbAnalyzeGoods: TdxBarButton
      Caption = 'Analiza produselor'
      Category = 0
      Hint = 'Analiza produselor'
      Visible = ivAlways
      OnClick = bbAnalyzeGoodsClick
    end
    object bbGoodsInfoCard: TdxBarButton
      Caption = 'Miscarea produsului'
      Category = 0
      Hint = 'Miscarea produsului'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsInfoCardClick
    end
    object bbGoodsPrice: TdxBarButton
      Caption = 'Modifica preturi produse'
      Category = 0
      Hint = 'Modifica preturi produse'
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbGoodsPriceClick
    end
    object bbGoodsForeignCode: TdxBarButton
      Caption = 'Preturi furnizori'
      Category = 0
      Hint = 'Preturi furnizori'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCodeClick
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Creaza in baza documentului curent...'
      Category = 0
      Hint = 'Creaza in baza documentului curent'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object bbXMLExport: TdxBarButton
      Caption = 'Exporta in XML'
      Category = 0
      Hint = 'Exporta in XML'
      Visible = ivAlways
      OnClick = bbXMLExportClick
    end
    object bbPaymentRequest: TdxBarButton
      Caption = 'Cerere de plata'
      Category = 0
      Hint = 'Cerere de plata'
      Visible = ivAlways
      OnClick = bbPaymentRequestClick
    end
  end
  object dxBarPopupMenuDOCS: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCreatePrihodRashod'
      end
      item
        Visible = True
        ItemName = 'dxBarButton2'
      end
      item
        Visible = True
        ItemName = 'bbPaymentRequest'
      end
      item
        Visible = True
        ItemName = 'bbXMLExport'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        Visible = True
        ItemName = 'bbCustomerDebts'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuDOCSPopup
    Left = 88
    Top = 152
    PixelsPerInch = 96
  end
  object cxGridPopupMenuDOCS: TcxGridPopupMenu
    Grid = cxGridPTN
    PopupMenus = <
      item
        GridView = cxGridPTNTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuDOCS
      end>
    Left = 88
    Top = 92
  end
  object dxBarPopupMenuCOMPONENTS: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbModifyGoods'
      end
      item
        Visible = True
        ItemName = 'bbDeleteGoods'
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
      end>
    UseOwnFont = False
    Left = 344
    Top = 392
    PixelsPerInch = 96
  end
  object cxGridPopupMenuCOMPONENTS: TcxGridPopupMenu
    Grid = cxGridComponents
    PopupMenus = <
      item
        GridView = cxGridComponentsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuCOMPONENTS
      end>
    Left = 108
    Top = 388
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'XML'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofNoNetworkButton, ofEnableSizing]
    Left = 536
    Top = 296
  end
end
