inherited frame33ServiceReturnToVendor: Tframe33ServiceReturnToVendor
  Width = 1077
  Height = 562
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 1077
  ExplicitHeight = 562
  object cxGridDocs: TcxGrid
    Left = 0
    Top = 0
    Width = 1077
    Height = 314
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridDocsTable: TcxGridDBTableView
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
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0.00'
          Kind = skSum
          FieldName = 'SUMA'
          Column = cxGridDocs_SUMA
        end>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
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
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridDocsTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridDocsTableData: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridDocsTableDataGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridDocsTable_CREATED_DATE: TcxGridDBColumn
        Caption = 'Data crearii'
        DataBinding.FieldName = 'CREATED_DATE'
        MinWidth = 16
        Width = 80
      end
      object cxGridDocsTableWarehouse: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 16
        Width = 80
      end
      object cxGridNPNCol_CT_NAME: TcxGridDBColumn
        Caption = 'Furnizor'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 16
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 160
      end
      object cxGridDocs_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridDocs_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridDocs_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridDocs_RATE: TcxGridDBColumn
        Caption = 'Curs doc'
        DataBinding.FieldName = 'RATE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridDocs_RATEUSD: TcxGridDBColumn
        Caption = 'Curs $'
        DataBinding.FieldName = 'RATEUSD'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridDocsTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridDocsTableFlgACNT: TcxGridDBColumn
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridDocsTableCreatedBy: TcxGridDBColumn
        Caption = 'Operator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 96
        Options.HorzSizing = False
        Width = 96
      end
      object cxGridDocs_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridDocs_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridDocsTable_SC2_NAME: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'SC2_NAME'
        MinWidth = 48
        Width = 80
      end
    end
    object cxGridDocsLevel: TcxGridLevel
      GridView = cxGridDocsTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 314
    Width = 1077
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
  object pnBottom: TPanel
    Left = 0
    Top = 322
    Width = 1077
    Height = 240
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
      Width = 1077
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
    object cxGridGoods: TcxGrid
      Left = 0
      Top = 30
      Width = 1077
      Height = 210
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 1
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridGoodsTable: TcxGridDBTableView
        PopupMenu = dxBarPopupMenuJurnal
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
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'DTDEP_NAME'
          Visible = False
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
        object cxGridGoods_DTDEP_NAME: TcxGridDBColumn
          Caption = 'Depozit'
          DataBinding.FieldName = 'DTDEP_NAME'
          MinWidth = 16
          Width = 80
        end
        object cxGridDBCol_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 19
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 19
        end
        object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_NAME'
          MinWidth = 16
          Width = 240
        end
        object cxGridDBCol_Price: TcxGridDBColumn
          Caption = #1062#1077#1085#1072
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
        end
        object cxGridDBCol_K_UM: TcxGridDBColumn
          Caption = 'UM'
          DataBinding.FieldName = 'UM_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 32
        end
        object cxGridDBCol_QTY: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridGoods_PRICE: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
        end
        object cxGridDBCol_SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Styles.Footer = dmAdditions.cxStyle_Bold
          Width = 64
        end
        object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
          Caption = #1040#1082#1090
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Options.HorzSizing = False
          Width = 32
        end
        object cxGridDBCol_FLG_ACNT: TcxGridDBColumn
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
        object cxGridDBCol_WARRANTY: TcxGridDBColumn
          Caption = 'Gar'
          DataBinding.FieldName = 'WARRANTY'
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
        end
        object cxGridDBCol_FLG_READY: TcxGridDBColumn
          Caption = 'Gata'
          DataBinding.FieldName = 'FLG_READY'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Options.HorzSizing = False
          Width = 32
        end
      end
      object cxGridGoodsLevel: TcxGridLevel
        GridView = cxGridGoodsTable
      end
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Goods'
      'PopupMenuDocs'
      'PopupMenuJurnal')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 592
    Top = 84
    PixelsPerInch = 96
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
      Caption = 'Serii si partide'
      Category = 0
      Hint = 'Serii si partide'
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
    object bbTTN: TdxBarButton
      Caption = 'Genereaza factura'
      Category = 0
      Hint = 'Genereaza factura'
      Visible = ivAlways
      ShortCut = 122
      OnClick = bbTTNClick
    end
    object dxBarButton1: TdxBarButton
      Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1090#1086#1074#1072#1088#1072
      Category = 2
      Hint = #1050#1072#1088#1090#1086#1095#1082#1072' '#1090#1086#1074#1072#1088#1072
      Visible = ivAlways
      ShortCut = 16463
      OnClick = dxBarButton1Click
    end
  end
  object cxGridPopupMenuDocs: TcxGridPopupMenu
    Grid = cxGridDocs
    PopupMenus = <
      item
        GridView = cxGridDocsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuDocs
      end>
    Left = 436
    Top = 116
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
        ItemName = 'bbTTN'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuDocsPopup
    Left = 312
    Top = 116
    PixelsPerInch = 96
  end
  object dxBarPopupMenuJurnal: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <>
    UseOwnFont = False
    Left = 536
    Top = 356
    PixelsPerInch = 96
  end
end
