inherited frame24WebZakaz: Tframe24WebZakaz
  Width = 974
  Height = 626
  Margins.Left = 3
  Margins.Top = 3
  Margins.Right = 3
  Margins.Bottom = 3
  Font.Height = -12
  ExplicitWidth = 974
  ExplicitHeight = 626
  object cxGridWZ: TcxGrid
    Left = 0
    Top = 0
    Width = 974
    Height = 380
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    ExplicitTop = -4
    object cxGridWZTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu
      OnKeyDown = cxGridWZTableKeyDown
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
      OnCellDblClick = cxGridWZTableCellDblClick
      OnCustomDrawCell = cxGridWZTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = cxGridWZ_CT_NAME
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
      object cxGridWZ_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridWZ_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridWZ_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridWZ_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridWZ_CreatedDate: TcxGridDBColumn
        Caption = 'Creat'
        DataBinding.FieldName = 'CREATED_DATE'
        MinWidth = 64
        Options.Grouping = False
        Options.HorzSizing = False
      end
      object cxGridWZ_DTDEP_NAME: TcxGridDBColumn
        Caption = #1057#1082#1083#1072#1076
        DataBinding.FieldName = 'DTDEP_NAME'
        Visible = False
        MinWidth = 13
        Width = 64
      end
      object cxGridWZ_CT_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 13
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 178
      end
      object cxGridWZ_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 51
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 51
      end
      object cxGridWZ_VALUTA: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridWZ_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridWZ_RATE: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' '#1044#1086#1082'.'
        DataBinding.FieldName = 'RATE'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 51
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 51
      end
      object cxGridWZ_PARENTDOCID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridWZ_FLG_ACNT: TcxGridDBColumn
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 26
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 26
      end
      object cxGridWZ_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 13
      end
      object cxGridWZ_DTSC_NAME: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'DTSC_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.Editing = False
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridWZ_RESPONSIBLE_USERNAME: TcxGridDBColumn
        Caption = 'Responsabil'
        DataBinding.FieldName = 'RESPONSIBLE_USERNAME'
        MinWidth = 77
        Options.HorzSizing = False
        Width = 77
      end
      object cxGridWZ_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Creat de'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 64
        Options.Editing = False
        Options.HorzSizing = False
        Width = 64
      end
    end
    object cxGridWZLevel: TcxGridLevel
      GridView = cxGridWZTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 388
    Width = 974
    Height = 238
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object cxGridComponents: TcxGrid
      Left = 0
      Top = 30
      Width = 974
      Height = 208
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      ExplicitTop = 34
      ExplicitHeight = 165
      object cxGridComponentsTable: TcxGridDBTableView
        PopupMenu = dxBarPopupMenuJurnal
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
            Kind = skSum
            FieldName = 'QTY'
            Column = cxGridDBCol_QTY
          end
          item
            Kind = skSum
            FieldName = 'SUMA'
            Column = cxGridDBCol_SUMA
          end
          item
            Kind = skSum
            FieldName = 'SUMAVAT'
            Column = cxGridDBCol_SUMAVAT
          end
          item
            Kind = skCount
            Column = cxGridDBCol_GOODSID
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
        Styles.OnGetContentStyle = cxGridComponentsTableStylesGetContentStyle
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridDBCol_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
          Caption = 'Depozit'
          DataBinding.FieldName = 'DTDEP_NAME'
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
        object cxGridDBCol_IMG: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 12
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 12
            end
            item
              ImageIndex = 44
              Value = 4203
            end>
          MinWidth = 24
          Options.Editing = False
          Options.Focusing = False
          Options.IncSearch = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          VisibleForCustomization = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridComponentsTable_FLD_FORCED_ADDON: TcxGridDBColumn
          Caption = '...'
          DataBinding.FieldName = 'flg_forced_addon'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilFlags
          Properties.Items = <
            item
              ImageIndex = 0
              Value = 2
            end
            item
              ImageIndex = 1
              Value = 1
            end
            item
              ImageIndex = 2
              Value = 4
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.Editing = False
          Options.Focusing = False
          Options.IncSearch = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 24
        end
        object cxGridComponents_FLG_SUPPLIER_PROMO: TcxGridDBColumn
          Caption = 'P'
          DataBinding.FieldName = 'FLG_SUPPLIER_PROMO'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilFlags
          Properties.Items = <
            item
              Description = 'Promotie furnizor'
              ImageIndex = 3
              Value = '1'
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridComponents_FLG_PROMO: TcxGridDBColumn
          Caption = 'FP'
          DataBinding.FieldName = 'FLG_PROMO'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilGoodsProperties
          Properties.Items = <
            item
              ImageIndex = 6
              Value = 1
            end>
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_NAME'
          MinWidth = 13
          Width = 264
        end
        object cxGridDBCol_QTY: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 64
        end
        object cxGridDBCol_UM_NAME: TcxGridDBColumn
          Caption = 'UM'
          DataBinding.FieldName = 'UM_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 64
        end
        object cxGridComponentsFLG_FORCED: TcxGridDBColumn
          Caption = 'FF'
          DataBinding.FieldName = 'FLG_FORCED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
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
        object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
          Caption = 'Sold'
          DataBinding.FieldName = 'STOCK_QTY'
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.HorzSizing = False
          Width = 30
        end
        object cxGridDBCol_SUMAVAT: TcxGridDBColumn
          Caption = 'TVA'
          DataBinding.FieldName = 'SUMAVAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 45
          Options.HorzSizing = False
          Width = 45
        end
        object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          Visible = False
          MinWidth = 13
          VisibleForCustomization = False
        end
        object cxGridDBCol_FLG_READY: TcxGridDBColumn
          Caption = #1043#1086#1090#1086#1074
          DataBinding.FieldName = 'FLG_READY'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 26
          Options.HorzSizing = False
          Width = 26
        end
        object cxGridComponents_UMID: TcxGridDBColumn
          DataBinding.FieldName = 'UMID'
          Visible = False
          MinWidth = 13
          VisibleForCustomization = False
        end
        object cxGridComponentsTableColumn1: TcxGridDBColumn
          Caption = 'FA'
          DataBinding.FieldName = 'FLG_FORCED_ADDON'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilFlags
          Properties.Items = <
            item
              ImageIndex = 1
              Value = 1
            end>
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridComponentsTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 974
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
  end
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 380
    Width = 974
    Height = 8
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    DragThreshold = 2
    PositionAfterOpen = 19
    MinSize = 192
    Control = pnBottom
    ExplicitTop = 308
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Popup Goods'
      'Default'
      'Jurnal')
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
    Left = 136
    Top = 80
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
      FloatLeft = 939
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
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
    object bbDocState: TdxBarButton
      Caption = 'Statutul documentului'
      Category = 0
      Hint = 'Statutul documentului'
      Visible = ivAlways
      OnClick = bbDocStateClick
    end
    object bbAddGoods: TdxBarButton
      Caption = 'Adauga'
      Category = 1
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddGoodsClick
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
    object bbDeleteGoods: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteGoodsClick
    end
    object bbAction_Rashod: TdxBarButton
      Caption = 'Creaza document "Vinzare"'
      Category = 1
      Hint = 'Creaza document "Vinzare"'
      Visible = ivNever
      ShortCut = 49238
      OnClick = bbAction_RashodClick
    end
    object bbAction_Sceot: TdxBarButton
      Caption = 'Creaza document "Proforma"'
      Category = 1
      Hint = 'Creaza document "Proforma"'
      Visible = ivNever
      ShortCut = 49232
      OnClick = bbAction_SceotClick
    end
    object bbDocClose: TdxBarButton
      Caption = 'Inchide document'
      Category = 1
      Hint = 'Inchide document'
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbDocCloseClick
    end
    object bbAction_Configurator: TdxBarButton
      Caption = 'Creaza "Oferta"...'
      Category = 1
      Hint = 'Creaza "Oferta"'
      Visible = ivAlways
      ShortCut = 49219
      OnClick = bbAction_ConfiguratorClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Reaminteste de sunat clientul...'
      Category = 1
      Hint = 'Reaminteste de sunat clientul'
      Visible = ivAlways
      ShortCut = 49234
      OnClick = dxBarButton1Click
    end
    object bbEcommInfo: TdxBarButton
      Caption = 'Info transactie Ecomm'
      Category = 1
      Hint = 'Info transactie Ecomm'
      Visible = ivAlways
      ShortCut = 16453
      OnClick = bbEcommInfoClick
    end
    object bbCancelCashback: TdxBarButton
      Caption = 'Anuleaza cashback'
      Category = 1
      Hint = 'Anuleaza cashback'
      Visible = ivAlways
      OnClick = bbCancelCashbackClick
    end
    object bbAssignToMe: TdxBarButton
      Caption = 'Atribuie mie...'
      Category = 1
      Hint = 'Atribuie mie'
      Visible = ivAlways
      ShortCut = 32833
      OnClick = bbAssignToMeClick
    end
    object bbGoodsBalance: TdxBarButton
      Caption = 'Miscarea produsului'
      Category = 2
      Hint = 'Miscarea produsului'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsBalanceClick
    end
    object bbForeignGoodsKey: TdxBarButton
      Caption = 'Produse in functie de furnizori'
      Category = 2
      Hint = 'Produse in functie de furnizori'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbForeignGoodsKeyClick
    end
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbDocClose'
      end
      item
        Visible = True
        ItemName = 'bbAssignToMe'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbAction_Configurator'
      end
      item
        Visible = True
        ItemName = 'bbAction_Sceot'
      end
      item
        Visible = True
        ItemName = 'bbAction_Rashod'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton1'
      end
      item
        Visible = True
        ItemName = 'bbEcommInfo'
      end
      item
        Visible = True
        ItemName = 'bbCancelCashback'
      end>
    UseOwnFont = False
    Left = 64
    Top = 140
    PixelsPerInch = 96
  end
  object dxBarPopupMenuJurnal: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGoodsBalance'
      end
      item
        Visible = True
        ItemName = 'bbForeignGoodsKey'
      end>
    UseOwnFont = False
    Left = 136
    Top = 140
    PixelsPerInch = 96
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 5242944
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFCF8F6FFF9F3EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD6AD98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD6AD98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD6AD98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD6AD98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD6AD98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD2A58EFFFEFCFBFFFFFFFFFFFBF6F3FFE3C6B8FFCB977DFFBC79
          57FFB46944FFB2643EFFC08162FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF9A3401FF9D3B0AFF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF993300FF993300FF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF993300FF993300FF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF993300FF993300FF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF993300FF993300FF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF993300FF993300FF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFEDDBD1FF993300FF993300FF993300FF993300FF9A3402FFA74F23FFBA75
          52FFC4896CFFBF7E5EFFBB7755FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFECD8CEFFDDBBAAFFE0C0B0FFECD9CFFFFBF7F5FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFF8FCF6FFF3F9EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFADD698FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFADD698FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFADD698FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFADD698FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFADD698FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFA5D28EFFFCFEFBFFFFFFFFFFF6FBF3FFC6E3B8FF97CB7DFF79BC
          57FF69B444FF64B23EFF81C062FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF349A01FF3B9D0AFF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF339900FF339900FF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF339900FF339900FF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF339900FF339900FF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF339900FF339900FF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF339900FF339900FF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFDBEDD1FF339900FF339900FF339900FF339900FF349A02FF4FA723FF75BA
          52FF89C46CFF7EBF5EFF77BB55FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFD8ECCEFFBBDDAAFFC0E0B0FFD9ECCFFFF7FBF5FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFF6F6FFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF9898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF9898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF9898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF9898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF9898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF8E8EFFFFFBFBFFFFFFFFFFFFF3F3FFFFB8B8FFFF7D7DFFFF5757
          FFFF4444FFFF3E3EFFFF6262FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0101FFFF0A0AFFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD1D1FFFF0000FFFF0000FFFF0000FFFF0000FFFF0202FFFF2323FFFF5252
          FFFF6C6CFFFF5E5EFFFF5555FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFCECEFFFFAAAAFFFFB0B0FFFFCFCFFFFFF5F5FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFF6FDFFFFEFFBFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF98E3F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF98E3F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF98E3F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF98E3F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF98E3F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF8EE0F4FFFBFEFFFFFFFFFFFFF3FCFEFFB8ECF8FF7DDCF2FF57D1
          EEFF44CCECFF3ECAECFF62D4EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF01BAE6FF0ABCE6FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD1F3FBFF00B9E5FF00B9E5FF00B9E5FF00B9E5FF02BAE6FF23C3E9FF52D0
          EEFF6CD7F0FF5ED3EFFF55D1EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFCEF2FAFFAAE8F7FFB0EAF7FFCFF2FBFFF5FDFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end>
  end
end
