inherited frame45ZakritiTovarKomisia: Tframe45ZakritiTovarKomisia
  Width = 1062
  Height = 614
  Font.Height = -15
  ExplicitWidth = 1062
  ExplicitHeight = 614
  PixelsPerInch = 120
  object cxGridNPN: TcxGrid
    Left = 0
    Top = 0
    Width = 1062
    Height = 280
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
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
      object cxGridNPNTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridNPN_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridNPN_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridNPN_CREATED_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
        DataBinding.FieldName = 'CREATED_DATE'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 85
      end
      object cxGridNPN_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 60
        Width = 100
      end
      object cxGridNPN_CT_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 100
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 200
      end
      object cxGridNPNTableSuma: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridNPN_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridNPNTableVAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 70
      end
      object cxGridNPNTableRate: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 60
      end
      object cxGridNPNTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridNPN_RATEUSD: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridNPNTable_FLG_ACNT: TcxGridDBColumn
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
      object cxGridNPNTable_CUSTOMER_TYPE_ID: TcxGridDBColumn
        DataBinding.FieldName = 'CUSTOMER_TYPE_ID'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridNPN_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Operator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 60
        Width = 100
      end
      object cxGridNPN_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridNPN_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridNPNLevel: TcxGridLevel
      GridView = cxGridNPNTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 280
    Width = 1062
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 200
    Control = pnBottom
  end
  object pnBottom: TPanel
    Left = 0
    Top = 290
    Width = 1062
    Height = 324
    Align = alBottom
    Caption = 'pnBottom'
    TabOrder = 2
    object dxBarDockControl2: TdxBarDockControl
      Left = 1
      Top = 1
      Width = 1060
      Height = 34
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridComponents: TcxGrid
      Left = 1
      Top = 35
      Width = 1060
      Height = 288
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
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_NAME'
          Width = 200
        end
        object cxGridDBCol_QTY: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
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
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBCol_SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
          Width = 80
        end
        object cxGridDBCol_SUMAVAT: TcxGridDBColumn
          Caption = #1053#1044#1057
          DataBinding.FieldName = 'SUMAVAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 70
        end
        object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
          Caption = #1040#1082#1090#1080#1074
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 40
        end
        object cxGridDBCol_FLG_READY: TcxGridDBColumn
          Caption = #1043#1086#1090#1086#1074
          DataBinding.FieldName = 'FLG_READY'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 40
        end
        object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
          Caption = #1054#1089#1090#1072#1090#1086#1082
          DataBinding.FieldName = 'STOCK_QTY'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          VisibleForCustomization = False
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
          Caption = 'Denumirea cntb'
          DataBinding.FieldName = 'GOODS_NAMEACNT'
          MinWidth = 50
          Width = 70
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridComponentsTable
      end
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
      'Goods')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 376
    Top = 108
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
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewGoods'
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
          ItemName = 'bbRemoveGoods'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbImportGoods'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbDocClose: TdxBarButton
      Caption = 'Inchide document...'
      Category = 0
      Hint = 'Inchide document'
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbDocCloseClick
    end
    object bbDocOpen: TdxBarButton
      Caption = 'Deschide document...'
      Category = 0
      Hint = 'Deschide document'
      Visible = ivAlways
      OnClick = bbDocOpenClick
    end
    object bbImportGoods: TdxBarButton
      Caption = 'Import produse'
      Category = 0
      Hint = 'Import produse'
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbImportGoodsClick
    end
    object bbCustomerDebts: TdxBarButton
      Caption = 'Datoriile curente...'
      Category = 0
      Hint = 'Datoriile curente'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Creaza document "Retur de Marfa"'
      Category = 0
      Hint = 'Creaza document "Retur de Marfa"'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object bbNewGoods: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewGoodsClick
    end
    object bbModifyGoods: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyGoodsClick
    end
    object bbRemoveGoods: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbRemoveGoodsClick
    end
  end
  object pmPopupMenuDocs: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbDocClose'
      end
      item
        Visible = True
        ItemName = 'bbDocOpen'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCustomerDebts'
      end
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end>
    UseOwnFont = False
    Left = 552
    Top = 116
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
    Left = 248
    Top = 108
  end
end
