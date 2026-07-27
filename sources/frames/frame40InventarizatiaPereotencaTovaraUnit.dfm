inherited frame40InventarizatiaPereotencaTovara: Tframe40InventarizatiaPereotencaTovara
  Width = 938
  Height = 705
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Charset = RUSSIAN_CHARSET
  Font.Height = -12
  Font.Name = 'Tahoma'
  ExplicitWidth = 938
  ExplicitHeight = 705
  object cxGridDoc: TcxGrid
    Left = 0
    Top = 0
    Width = 938
    Height = 378
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    ExplicitTop = 4
    object cxGridDocTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenuDocs
      OnKeyDown = cxGridDocTableKeyDown
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
      OnCellDblClick = cxGridDocTableCellDblClick
      OnCustomDrawCell = cxGridDocTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      FilterRow.SeparatorWidth = 9
      FixedDataRows.SeparatorWidth = 9
      NewItemRow.SeparatorWidth = 9
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NavigatorOffset = 70
      OptionsView.NoDataToDisplayInfoText = '<Nu sunt date pentru afisare>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      OptionsView.IndicatorWidth = 21
      Preview.LeftIndent = 28
      Preview.RightIndent = 7
      Styles.OnGetContentStyle = cxGridDocTableStylesGetContentStyle
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridDoc_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridDoc_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridDoc_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 88
        Options.HorzSizing = False
        Width = 88
      end
      object cxGridDoc_DTNAME: TcxGridDBColumn
        Caption = 'Intreprinderea'
        DataBinding.FieldName = 'DT_NAME'
        MinWidth = 16
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 136
      end
      object cxGridDoc_CTNAME: TcxGridDBColumn
        Caption = 'Furnizor'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 16
        Width = 178
      end
      object cxGridDoc_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 160
        Width = 164
      end
      object cxGridDoc_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridDoc_FLG_CLOSED: TcxGridDBColumn
        Caption = #1047#1072#1082#1088#1099#1090
        DataBinding.FieldName = 'FLG_CLOSED'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 40
      end
      object cxGridDoc_CT: TcxGridDBColumn
        DataBinding.FieldName = '\'
        MinWidth = 16
      end
    end
    object cxGridDocLevel: TcxGridLevel
      GridView = cxGridDocTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 386
    Width = 938
    Height = 319
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnBottom'
    TabOrder = 2
    object cxGridPrices: TcxGrid
      Left = 0
      Top = 30
      Width = 938
      Height = 289
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      LookAndFeel.NativeStyle = True
      object cxGridPricesTable: TcxGridDBTableView
        OnKeyDown = cxGridPricesTableKeyDown
        Navigator.Buttons.First.Visible = False
        Navigator.Buttons.PriorPage.Visible = False
        Navigator.Buttons.Prior.Visible = False
        Navigator.Buttons.Next.Visible = False
        Navigator.Buttons.NextPage.Visible = False
        Navigator.Buttons.Last.Visible = False
        Navigator.Buttons.Insert.Visible = False
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Delete.Visible = False
        Navigator.Buttons.Edit.Visible = False
        Navigator.Buttons.Post.Visible = False
        Navigator.Buttons.Cancel.Visible = False
        Navigator.Buttons.Refresh.Visible = True
        Navigator.Buttons.SaveBookmark.Visible = False
        Navigator.Buttons.GotoBookmark.Visible = False
        Navigator.Buttons.Filter.Visible = True
        FindPanel.DisplayMode = fpdmAlways
        FindPanel.FocusViewOnApplyFilter = True
        FindPanel.UseExtendedSyntax = True
        OnCustomDrawCell = cxGridPricesTableCustomDrawCell
        DataController.DataModeController.GridModeBufferCount = 100
        DataController.DataSource = IBCDataSourceGoodsPrice
        DataController.KeyFieldNames = 'DOCID;GOODSID'
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skCount
            FieldName = 'GOODSID'
            Column = cxGridPrices_GOODSID
          end>
        FilterRow.SeparatorWidth = 9
        FixedDataRows.SeparatorWidth = 9
        NewItemRow.SeparatorWidth = 9
        OptionsBehavior.IncSearch = True
        OptionsBehavior.IncSearchItem = cxGridPrices_GOODSID
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.HideFocusRectOnExit = False
        OptionsSelection.InvertSelect = False
        OptionsView.NavigatorOffset = 70
        OptionsView.NoDataToDisplayInfoText = '<Nu sunt date pentru afisare>'
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        OptionsView.IndicatorWidth = 21
        Preview.LeftIndent = 28
        Preview.RightIndent = 7
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        Styles.Selection = dmAdditions.cxStyle_ChatGroupSelected
        object cxGridPrices_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 12
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 44
              Value = 4203
            end>
          MinWidth = 21
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Sorting = False
          VisibleForCustomization = False
          Width = 21
        end
        object cxGridPrices_SUPPLIER_GOODS_CODE: TcxGridDBColumn
          Caption = 'CPF'
          DataBinding.FieldName = 'SUPPLIER_GOODS_CODE'
          MinWidth = 16
          Width = 35
        end
        object cxGridPrices_GOODS_ACNT_ID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
          Caption = 'Acnt'
          DataBinding.FieldName = 'GOODS_ACNT_ID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridPrices_GOODS_NAMEACNT: TcxGridDBColumn
          Caption = 'Denumire facturi'
          DataBinding.FieldName = 'GOODS_NAMEACNT'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.ClickKey = 0
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = cxGridPrices_GOODS_NAMEACNTPropertiesButtonClick
          Visible = False
          MinWidth = 40
          Width = 88
        end
        object cxGridPrices_GOODS_PRICE_ACNT: TcxGridDBColumn
          Caption = 'Pret evidenta'
          DataBinding.FieldName = 'GOODS_PRICE_ACNT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Styles.Content = dmAdditions.cxStyle_DocInSpector_CurrDoc
          Width = 58
        end
        object cxGridPrices_FLG_SUPPLIER_PROMO: TcxGridDBColumn
          Caption = 'S Promo'
          DataBinding.FieldName = 'FLG_SUPPLIER_PROMO'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          MinWidth = 36
          Options.HorzSizing = False
          Width = 36
        end
        object cxGridPrices_FLG_PROMO: TcxGridDBColumn
          AlternateCaption = 'Promo'
          Caption = 'Promo'
          DataBinding.FieldName = 'FLG_PROMO'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 37
          Options.HorzSizing = False
          Width = 37
        end
        object cxGridPrices_FLG_PRICE_FORCED: TcxGridDBColumn
          AlternateCaption = 'Forced Price'
          Caption = 'PF'
          DataBinding.FieldName = 'FLG_PRICE_FORCED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridPrices_FLG_NEW: TcxGridDBColumn
          AlternateCaption = 'FLG_NEW'
          Caption = 'NF'
          DataBinding.FieldName = 'FLG_NEW'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridPrices_FLG_FORCED_ADDON: TcxGridDBColumn
          AlternateCaption = 'Cantitate multa la furnizor'
          Caption = 'FA'
          DataBinding.FieldName = 'FLG_FORCED_ADDON'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilFlags
          Properties.ImmediateDropDownWhenKeyPressed = False
          Properties.Items = <
            item
              ImageIndex = 1
              Value = 1
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Options.SortByDisplayText = isbtOff
          Width = 16
        end
        object cxGridPricesTable_EPP: TcxGridDBColumn
          Caption = 'RRP'
          DataBinding.FieldName = 'FLG_EPP'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          MinWidth = 26
          Options.Editing = False
          Options.HorzSizing = False
          Width = 26
        end
        object cxGridPricesTable_FLG_PRE_ORDER: TcxGridDBColumn
          Caption = 'PRE'
          DataBinding.FieldName = 'FLG_PRE_ORDER'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          MinWidth = 26
          Options.HorzSizing = False
          Width = 26
        end
        object cxGridPrices_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.Editing = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 48
        end
        object cxGridPrices_GOODS_NAME: TcxGridDBColumn
          AlternateCaption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_TITLE'
          MinWidth = 80
          Options.Editing = False
          Width = 134
        end
        object cxGridPrices_PRICE0: TcxGridDBColumn
          Caption = 'Pret 0'
          DataBinding.FieldName = 'PRICE0'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Styles.Content = dmAdditions.cxStyle_MarginGroup
          Width = 36
        end
        object cxGridPricesTableColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'CURRENCYID'
          MinWidth = 16
          Width = 34
        end
        object cxGridPrices_PRICE1: TcxGridDBColumn
          Caption = 'Vinzare, MDL'
          DataBinding.FieldName = 'PRICE1_LEI'
          MinWidth = 51
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_SCSelection
          Width = 51
        end
        object cxGridPrices_PRICE2: TcxGridDBColumn
          Caption = 'Promo'
          DataBinding.FieldName = 'PRICE2_LEI'
          MinWidth = 51
          Options.HorzSizing = False
          Width = 51
        end
        object cxGridPrices_PRICE3: TcxGridDBColumn
          Caption = 'RRP'
          DataBinding.FieldName = 'PRICE3'
          HeaderAlignmentHorz = taCenter
          MinWidth = 51
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
          Width = 51
        end
        object cxGridPrices_CURRENCY3_TITLE: TcxGridDBColumn
          AlternateCaption = 'Valuta de baza'
          Caption = 'Val. RRP'
          DataBinding.FieldName = 'CURRENCY3ID'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.KeyFieldNames = 'CURRENCYID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end>
          Properties.ListSource = dsCurrency
          HeaderAlignmentHorz = taCenter
          MinWidth = 51
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_CustomerDebtsNoiDatoram
          Styles.OnGetContentStyle = cxGridPrices_CURRENCY3_TITLEStylesGetContentStyle
          Width = 51
        end
        object cxGridPrices_PRICE4_LEI: TcxGridDBColumn
          Caption = 'Pret 4, MDL'
          DataBinding.FieldName = 'PRICE4_LEI'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '### ##0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 51
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_DocInSpector_CurrDoc
          Width = 51
        end
        object cxGridPrices_PRICE5_LEI: TcxGridDBColumn
          Caption = 'Pret 5, MDL'
          DataBinding.FieldName = 'PRICE5_LEI'
          PropertiesClassName = 'TcxCalcEditProperties'
          MinWidth = 51
          Options.HorzSizing = False
          Width = 51
        end
        object cxGridPrices_PRICE6_LEI: TcxGridDBColumn
          Caption = 'Pret 6, MDL'
          DataBinding.FieldName = 'PRICE6_LEI'
          PropertiesClassName = 'TcxCalcEditProperties'
          MinWidth = 51
          Options.HorzSizing = False
          Width = 51
        end
        object cxGridPrices_PRICE7_LEI: TcxGridDBColumn
          Caption = 'Pret 7, MDL'
          DataBinding.FieldName = 'PRICE7_LEI'
          HeaderAlignmentHorz = taCenter
          MinWidth = 51
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_DocInSpector_CurrDoc
          Width = 51
        end
        object cxGridPrices_DIFF47: TcxGridDBColumn
          Caption = 'Dif 47'
          DataBinding.FieldName = 'DIFF47'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
        end
        object cxGridPrices_Margin01: TcxGridDBColumn
          Caption = '%01'
          DataBinding.FieldName = 'MARGIN01'
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 23
        end
        object cxGridPrices_Margin71: TcxGridDBColumn
          Caption = '%71'
          DataBinding.FieldName = 'MARGIN74'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '0.0'
          OnCustomDrawCell = cxGridPrices_Margin71CustomDrawCell
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Options.Editing = False
          Options.ExpressionEditing = False
          Width = 22
        end
        object cxGridPrices_Margin61: TcxGridDBColumn
          Caption = '%61'
          DataBinding.FieldName = 'CURRENT_MARGIN61'
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 22
        end
        object cxGridPrices_PRICE4: TcxGridDBColumn
          AlternateCaption = 'Pret Vinzare Online'
          Caption = 'Pret 4'
          DataBinding.FieldName = 'PRICE4'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '### ##0.00'
          Properties.EditFormat = '### ##0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Width = 60
        end
        object cxGridPrices_PRICE5: TcxGridDBColumn
          AlternateCaption = 'Pret Card de reducere'
          Caption = 'Pret 5'
          DataBinding.FieldName = 'PRICE5'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '### ##0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.Sorting = False
          Width = 40
        end
        object cxGridPrices_PRICE6: TcxGridDBColumn
          AlternateCaption = 'Pret Diler'
          Caption = 'Pret 6'
          DataBinding.FieldName = 'Price6'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '### ##0.00'
          Properties.EditFormat = '### ##0'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 40
        end
        object cxGridPrices_PRICE7: TcxGridDBColumn
          AlternateCaption = 'Pret indicativ'
          Caption = 'Pret 7'
          DataBinding.FieldName = 'Price7'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '### ##0.00'
          Properties.EditFormat = '### ##0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 51
          Options.IncSearch = False
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_Bold
          Width = 51
        end
        object cxGridPrices_CURRENCY7_TITLE: TcxGridDBColumn
          AlternateCaption = 'Valuta indicativ'
          Caption = 'Valuta 7'
          DataBinding.FieldName = 'CURRENCY7_TITLE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.ShowAccelChar = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 51
          Options.Editing = False
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_TextBoldGreen
          Width = 51
        end
        object cxGridPrices_MODIFIED_BY_NAME: TcxGridDBColumn
          Caption = 'Utilizator'
          DataBinding.FieldName = 'MODIFIED_BY_NAME'
          Visible = False
          MinWidth = 40
          Options.Editing = False
          VisibleForCustomization = False
          Width = 64
        end
        object cxGridPrices_PRICE_ACNT_LOW_BOUND: TcxGridDBColumn
          AlternateCaption = #1053#1080#1078#1085#1080#1081' '#1087#1086#1088#1086#1075' '#1091#1095#1077#1090#1085#1086#1081' '#1094#1077#1085#1099
          Caption = 'PMin'
          DataBinding.FieldName = 'PRICE_ACNT_LOW_BOUND'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Styles.Content = dmAdditions.cxStyle_DocInSpector_Parent
          Width = 40
        end
        object cxGridPrices_PRICE_ACNT_HIGH_BOUND: TcxGridDBColumn
          AlternateCaption = #1042#1077#1088#1093#1085#1080#1081' '#1087#1086#1088#1086#1075' '#1091#1095#1077#1090#1085#1086#1081' '#1094#1077#1085#1099
          Caption = 'PMax'
          DataBinding.FieldName = 'PRICE_ACNT_HIGH_BOUND'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Styles.Content = dmAdditions.cxStyle_DocInSpector_Parent
          Width = 40
        end
        object cxGridPrices_STOCK_QTY: TcxGridDBColumn
          AlternateCaption = 'Sold'
          Caption = 'Sld'
          DataBinding.FieldName = 'STOCK_QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Options.ShowEditButtons = isebNever
          Width = 48
        end
        object cxGridPrices_WEBGOODSNAME_RO: TcxGridDBColumn
          Caption = 'Web RO'
          DataBinding.FieldName = 'WEB_GOODS_NAME_RO'
          Visible = False
          MinWidth = 16
          Options.Editing = False
          Width = 160
        end
        object cxGridPrices_WEBGOODSNAME_RU: TcxGridDBColumn
          Caption = 'Web RU'
          DataBinding.FieldName = 'WEB_GOODS_NAME_RU'
          Visible = False
          MinWidth = 16
          Options.Editing = False
          Width = 160
        end
        object cxGridPricesTable_HAS_IMAGES: TcxGridDBColumn
          Caption = '...'
          DataBinding.FieldName = 'HAS_IMAGES'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          MinWidth = 19
          Options.HorzSizing = False
          Width = 19
        end
      end
      object cxGridPricesLevel: TcxGridLevel
        GridView = cxGridPricesTable
      end
    end
    object dxBarDockControl: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 938
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
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 378
    Width = 938
    Height = 8
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    DragThreshold = 2
    PositionAfterOpen = 240
    MinSize = 240
    Control = pnBottom
  end
  object dxBarManager: TdxBarManager
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Toolbar'
      'Docs')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 48
    Top = 84
    PixelsPerInch = 96
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = #1055#1088#1072#1074#1082#1072' '#1094#1077#1085
      CaptionButtons = <>
      DockControl = dxBarDockControl
      DockedDockControl = dxBarDockControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 947
      FloatTop = 0
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbSubTools'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbImportFromFile'
        end
        item
          Visible = True
          ItemName = 'dxBarButton13'
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
          ItemName = 'bbEditGoodsDescription'
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
          ItemName = 'bbDeleteSelectedGoods'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSubGoodsFlags'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSetAllFlagForced'
        end
        item
          Visible = True
          ItemName = 'bbClearAllFlgForced'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton18'
        end
        item
          Visible = True
          ItemName = 'dxBarButton19'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAdjustRRP'
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
    object bbDeleteGoods: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteGoodsClick
    end
    object bbImportGoods: TdxBarButton
      Caption = 'Import produse din document'
      Category = 0
      Hint = 'Import produse din document'
      Visible = ivAlways
      OnClick = bbImportGoodsClick
    end
    object bbImportGoodsGroup: TdxBarButton
      Caption = 'Import produse din nomenclator'
      Category = 0
      Hint = 'Import produse din nomenclator'
      Visible = ivAlways
      OnClick = bbImportGoodsGroupClick
    end
    object bbSubTools: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbImportFromFile'
        end
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbImportGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbImportGoodsGroup'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton20'
        end
        item
          Visible = True
          ItemName = 'bbSetupCustomPriceColumn'
        end
        item
          Visible = True
          ItemName = 'bbSendToContent'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton17'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbRefreshPrices'
        end>
    end
    object bbSetupCustomPriceColumn: TdxBarButton
      Caption = 'Setari grila de preturi'
      Category = 0
      Hint = 'Setari grila de preturi'
      Visible = ivAlways
      OnClick = bbSetupCustomPriceColumnClick
    end
    object bbImportFromFile: TdxBarButton
      Caption = 'Import din XLS...'
      Category = 0
      Hint = 'Import din XLS'
      Visible = ivAlways
      ImageIndex = 141
      OnClick = bbImportFromFileClick
    end
    object bbSubGoodsFlags: TdxBarSubItem
      Caption = 'Setari'
      Category = 0
      Visible = ivAlways
      ImageIndex = 144
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem2'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem7'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem8'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem3'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem4'
        end
        item
          Visible = True
          ItemName = 'bbSupplierPromo'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem5'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem6'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton12'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSendToNGS'
        end>
    end
    object bbSetAllFlagForced: TdxBarButton
      Caption = 'Seteaza flag pentru tot...'
      Category = 0
      Hint = 'Seteaza flag pentru tot'
      Visible = ivAlways
      ImageIndex = 25
      OnClick = bbSetAllFlagForcedClick
    end
    object bbClearAllFlgForced: TdxBarButton
      Caption = 'Elimina FLG_FORCED'
      Category = 0
      Hint = 'Elimina FLG_FORCED'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbClearAllFlgForcedClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Intotdeauna arata in price'
      Category = 0
      Visible = ivAlways
      ImageIndex = 50
      ItemLinks = <>
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = 'Produs nou'
      Category = 0
      Visible = ivAlways
      ImageIndex = 50
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbFlagNewProduct'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton3'
        end>
    end
    object dxBarSubItem3: TdxBarSubItem
      Caption = 'Promo produs'
      Category = 0
      Enabled = False
      Visible = ivAlways
      ImageIndex = 50
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton4'
        end>
    end
    object bbFlagNewProduct: TdxBarButton
      Caption = 'Seteaza flag pentru tot...'
      Category = 0
      Hint = 'Seteaza flag pentru tot'
      Visible = ivAlways
      ImageIndex = 25
      OnClick = bbFlagNewProductClick
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Seteaza flag pentru tot...'
      Category = 0
      Hint = 'Seteaza flag pentru tot'
      Visible = ivAlways
      ImageIndex = 25
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = #1059#1073#1088#1072#1090#1100' '#1092#1083#1072#1075' '#1091' '#1074#1089#1077#1093'...'
      Category = 0
      Hint = 'Elimina FLG_NEW'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = dxBarButton3Click
    end
    object dxBarButton4: TdxBarButton
      Caption = #1059#1073#1088#1072#1090#1100' '#1092#1083#1072#1075' '#1091' '#1074#1089#1077#1093'...'
      Category = 0
      Hint = #1059#1073#1088#1072#1090#1100' '#1092#1083#1072#1075' '#1091' '#1074#1089#1077#1093
      Visible = ivAlways
      ImageIndex = 35
      OnClick = dxBarButton4Click
    end
    object bbGoodsForeignCode: TdxBarButton
      Caption = #1057#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1076#1088#1091#1075#1080#1093' '#1092#1080#1088#1084#1072#1093'...'
      Category = 0
      Hint = #1057#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1076#1088#1091#1075#1080#1093' '#1092#1080#1088#1084#1072#1093
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCodeClick
    end
    object bbSendToNGS: TdxBarButton
      Caption = 'NPSC - Transmite la Content'
      Category = 0
      Hint = 'NPSC - Transmite la Content'
      Visible = ivNever
      OnClick = bbSendToNGSClick
    end
    object bbDeleteSelectedGoods: TdxBarButton
      Caption = 'Sterge tot'
      Category = 0
      Hint = 'Sterge tot'
      Visible = ivAlways
      ImageIndex = 143
      OnClick = bbDeleteSelectedGoodsClick
    end
    object dxBarButton6: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1094#1077#1085#1099' '#1090#1086#1074#1072#1088#1072
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1094#1077#1085#1099' '#1090#1086#1074#1072#1088#1072
      Visible = ivAlways
      ShortCut = 16465
      OnClick = dxBarButton6Click
    end
    object dxBarSubItem4: TdxBarSubItem
      Caption = 'Addon Forced'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          Visible = True
          ItemName = 'dxBarButton8'
        end>
    end
    object dxBarButton7: TdxBarButton
      Tag = 1
      Caption = 'Disponibil'
      Category = 0
      Hint = 'Disponibil'
      Visible = ivAlways
      OnClick = dxBarButton7Click
    end
    object dxBarButton8: TdxBarButton
      Caption = 'Sterge Flg_addons'
      Category = 0
      Hint = 'Sterge Flg_addons'
      Visible = ivAlways
      OnClick = dxBarButton7Click
    end
    object dxBarButton11: TdxBarButton
      Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1090#1086#1074#1072#1088#1072
      Category = 0
      Hint = #1050#1072#1088#1090#1086#1095#1082#1072' '#1090#1086#1074#1072#1088#1072
      Visible = ivAlways
      ShortCut = 16463
      OnClick = dxBarButton11Click
    end
    object dxBarButton12: TdxBarButton
      Caption = 'Seteaza valuta 4'
      Category = 0
      Hint = 'Seteaza valuta 4'
      Visible = ivNever
      OnClick = dxBarButton12Click
    end
    object dxBarButton13: TdxBarButton
      Caption = 'Import toate produse de la un Furnizor'
      Category = 0
      Hint = 'Import toate produse de la un Furnizor'
      Visible = ivAlways
      ImageIndex = 142
      OnClick = dxBarButton13Click
    end
    object bbRefreshPrices: TdxBarButton
      Caption = 'Refresh'
      Category = 0
      Hint = 'Refresh'
      Visible = ivAlways
      OnClick = bbRefreshPricesClick
    end
    object bbSupplierPromo: TdxBarSubItem
      Caption = 'Produse in promotie la furnizor'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbSetSupplierPromo'
        end
        item
          Visible = True
          ItemName = 'bbDelSupplierPromo'
        end>
    end
    object bbSetSupplierPromo: TdxBarButton
      Caption = 'Seteaza produs din promotie la furnizor...'
      Category = 0
      Hint = 'Seteaza produs din promotie la furnizor'
      Visible = ivAlways
      ImageIndex = 25
      OnClick = bbSetSupplierPromoClick
    end
    object bbDelSupplierPromo: TdxBarButton
      Caption = 'Sterge produs din promotie furnizor'
      Category = 0
      Hint = 'Sterge produs din promotie furnizor'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbDelSupplierPromoClick
    end
    object dxBarSubItem5: TdxBarSubItem
      Caption = 'Produse excluse din politica de preturi'
      Category = 0
      Visible = ivNever
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          Visible = True
          ItemName = 'dxBarButton14'
        end>
    end
    object dxBarButton10: TdxBarButton
      Caption = 'Seteaza'
      Category = 0
      Hint = 'Seteaza'
      Visible = ivAlways
      ImageIndex = 25
      OnClick = dxBarButton10Click
    end
    object dxBarButton14: TdxBarButton
      Caption = 'Reseteaza'
      Category = 0
      Hint = 'Reseteaza'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = dxBarButton14Click
    end
    object dxBarButton9: TdxBarButton
      Caption = 'Actualizeaza preturile'
      Category = 0
      Hint = 'Actualizeaza preturile'
      Visible = ivAlways
      ImageIndex = 36
    end
    object dxBarSubItem6: TdxBarSubItem
      Caption = 'Col "D"'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton15'
        end
        item
          Visible = True
          ItemName = 'dxBarButton16'
        end>
    end
    object dxBarButton15: TdxBarButton
      Caption = 'Seteaza FLG_COL_D'
      Category = 0
      Hint = 'Seteaza FLG_COL_D'
      Visible = ivAlways
      ImageIndex = 25
    end
    object dxBarButton16: TdxBarButton
      Caption = 'Elimina FLG_COL_D'
      Category = 0
      Hint = 'Elimina FLG_COL_D'
      Visible = ivAlways
      ImageIndex = 35
    end
    object dxBarButton17: TdxBarButton
      Caption = 'Seteaza valuta in MDL'
      Category = 0
      Hint = 'Seteaza valuta in MDL'
      Visible = ivAlways
      OnClick = dxBarButton17Click
    end
    object bbEditGoodsDescription: TdxBarButton
      Caption = 'Modifica descrierea produsului'
      Category = 0
      Hint = 'Modifica descrierea produsului'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 16397
      OnClick = bbEditGoodsDescriptionClick
    end
    object dxBarSubItem7: TdxBarSubItem
      Caption = 'Seteaza EPP'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarButton18: TdxBarButton
      Caption = 'Seteaza EPP'
      Category = 0
      Hint = 'Seteaza EPP'
      Visible = ivAlways
      ImageIndex = 25
      OnClick = dxBarButton18Click
    end
    object dxBarButton19: TdxBarButton
      Caption = 'Sterge EPP'
      Category = 0
      Hint = 'Sterge EPP'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = dxBarButton19Click
    end
    object dxBarButton20: TdxBarButton
      Caption = 'Actualizeaza preturile'
      Category = 0
      Hint = 'Actualizeaza preturile'
      Visible = ivAlways
      OnClick = dxBarButton20Click
    end
    object dxBarSubItem8: TdxBarSubItem
      Caption = 'Pre-Comanda'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbsetPreorder'
        end
        item
          Visible = True
          ItemName = 'bbCancelPreOrder'
        end>
    end
    object bbsetPreorder: TdxBarButton
      Caption = 'Seteaza Pre-Comanda'
      Category = 0
      Hint = 'Seteaza Pre-Comanda'
      Visible = ivAlways
      OnClick = bbsetPreorderClick
    end
    object bbCancelPreOrder: TdxBarButton
      Caption = 'Anuleaza Pre-Comanda'
      Category = 0
      Hint = 'Anuleaza Pre-Comanda'
      Visible = ivAlways
      OnClick = bbCancelPreOrderClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Recalcula preturile'
      Category = 0
      Hint = 'Recalcula preturile'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object bbAdjustRRP: TdxBarButton
      Caption = 'RRP -1%'
      Category = 0
      Hint = 'RRP -1%'
      Visible = ivAlways
      OnClick = bbAdjustRRPClick
    end
    object bbSendToContent: TdxBarButton
      Caption = 'Adauga produsele pentru descriere...'
      Category = 0
      Hint = 'Adauga produsele pentru descriere'
      Visible = ivAlways
      OnClick = bbSendToContentClick
    end
    object dxBarButton21: TdxBarButton
      Caption = 'Poate fi vindut in credit'
      Category = 0
      Hint = 'Poate fi vindut in credit'
      Visible = ivAlways
      OnClick = dxBarButton21Click
    end
    object bbCloseDoc: TdxBarButton
      Caption = 'Inchide documentul'
      Category = 1
      Hint = 'Inchide documentul'
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbCloseDocClick
    end
    object bbOpenDoc: TdxBarButton
      Caption = 'Deschide documentul'
      Category = 1
      Hint = 'Deschide documentul'
      Visible = ivAlways
      OnClick = bbOpenDocClick
    end
  end
  object IBCTrGPUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    DefaultCloseAction = taCommit
    Left = 44
    Top = 140
  end
  object cxGridPopupMenuGoods: TcxGridPopupMenu
    Grid = cxGridPrices
    PopupMenus = <
      item
        GridView = cxGridPricesTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuGood
      end>
    Left = 144
    Top = 192
  end
  object dxBarPopupMenuGood: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbDeleteGoods'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton11'
      end
      item
        Visible = True
        ItemName = 'bbGoodsForeignCode'
      end
      item
        Visible = True
        ItemName = 'dxBarButton6'
      end>
    UseOwnFont = False
    Left = 148
    Top = 136
    PixelsPerInch = 96
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 17825943
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
  object IBCQueryCurrency: TIBCQuery
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT * FROM TS_CURRENCY')
    Left = 488
    Top = 152
  end
  object dsCurrency: TIBCDataSource
    DataSet = IBCQueryCurrency
    Left = 488
    Top = 96
  end
  object dxBarPopupMenuDocs: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDoc'
      end
      item
        Visible = True
        ItemName = 'bbOpenDoc'
      end>
    UseOwnFont = False
    Left = 143
    Top = 80
    PixelsPerInch = 96
  end
  object IBCQueryGoods: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_GOODS'
      
        '  (GOODSID, PARENTID, FLG_FOLDER, BASE_PARAM, BASE_PARAM_RU, COD' +
        'E, CODE_RU, TITLE, DETAILS, FLG_SOCIAL, FLG_OLD, FLG_REQUIRE_CER' +
        'TIFICAT, FLG_BEST_PRICE, FLG_PRICE_NBM, FLG_SUPPLIER_PROMO, WARR' +
        'ANTY, GOODS_ACNT_ID, GOODS_TYPE_ID, GOODS_TYPE_NAME, WEBGOODSTYP' +
        'E_ID, WEBGOODSTYPE_TITLE, WEBGOODSTYPE_TITLE_RU, VENDOR_ID, USER' +
        'ID, UMID, SERIAL_TYPE_ID, ORDERNO, USER_FULLNAME, CREATE_DATE, N' +
        'AMEACNT, PRICE1, PRICE2, PRICE3, PRICE4, PRICE5, PRICE6, PRICE7,' +
        ' PRICE1_LEI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRI' +
        'CE6_LEI, PRICE7_LEI, PRICEC1_LEI, PRICEC2_LEI, PRICEC3_LEI, PRIC' +
        'EC4_LEI, PRICEC5_LEI, PRICEC6_LEI, PRICEC7_LEI, PRICE1_USD, PRIC' +
        'E2_USD, PRICE3_USD, PRICE4_USD, PRICE5_USD, PRICE6_USD, PRICE7_U' +
        'SD, CURRENCYID, CURRENCY_TITLE, VENDOR, UM_TITLE, QTY_ACCOUNT, M' +
        'INQTY, DELIVERY_TYPEID, DELIVERY_TYPENAME, VAT, CASHBACK_PERCENT' +
        ', COLORID, COLOR_NAME_RO, COLOR_NAME_RU)'
      'VALUES'
      
        '  (:GOODSID, :PARENTID, :FLG_FOLDER, :BASE_PARAM, :BASE_PARAM_RU' +
        ', :CODE, :CODE_RU, :TITLE, :DETAILS, :FLG_SOCIAL, :FLG_OLD, :FLG' +
        '_REQUIRE_CERTIFICAT, :FLG_BEST_PRICE, :FLG_PRICE_NBM, :FLG_SUPPL' +
        'IER_PROMO, :WARRANTY, :GOODS_ACNT_ID, :GOODS_TYPE_ID, :GOODS_TYP' +
        'E_NAME, :WEBGOODSTYPE_ID, :WEBGOODSTYPE_TITLE, :WEBGOODSTYPE_TIT' +
        'LE_RU, :VENDOR_ID, :USERID, :UMID, :SERIAL_TYPE_ID, :ORDERNO, :U' +
        'SER_FULLNAME, :CREATE_DATE, :NAMEACNT, :PRICE1, :PRICE2, :PRICE3' +
        ', :PRICE4, :PRICE5, :PRICE6, :PRICE7, :PRICE1_LEI, :PRICE2_LEI, ' +
        ':PRICE3_LEI, :PRICE4_LEI, :PRICE5_LEI, :PRICE6_LEI, :PRICE7_LEI,' +
        ' :PRICEC1_LEI, :PRICEC2_LEI, :PRICEC3_LEI, :PRICEC4_LEI, :PRICEC' +
        '5_LEI, :PRICEC6_LEI, :PRICEC7_LEI, :PRICE1_USD, :PRICE2_USD, :PR' +
        'ICE3_USD, :PRICE4_USD, :PRICE5_USD, :PRICE6_USD, :PRICE7_USD, :C' +
        'URRENCYID, :CURRENCY_TITLE, :VENDOR, :UM_TITLE, :QTY_ACCOUNT, :M' +
        'INQTY, :DELIVERY_TYPEID, :DELIVERY_TYPENAME, :VAT, :CASHBACK_PER' +
        'CENT, :COLORID, :COLOR_NAME_RO, :COLOR_NAME_RU)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_GOODS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_GOODS'
      'SET'
      
        '  GOODSID = :GOODSID, PARENTID = :PARENTID, FLG_FOLDER = :FLG_FO' +
        'LDER, BASE_PARAM = :BASE_PARAM, BASE_PARAM_RU = :BASE_PARAM_RU, ' +
        'CODE = :CODE, CODE_RU = :CODE_RU, TITLE = :TITLE, DETAILS = :DET' +
        'AILS, FLG_SOCIAL = :FLG_SOCIAL, FLG_OLD = :FLG_OLD, FLG_REQUIRE_' +
        'CERTIFICAT = :FLG_REQUIRE_CERTIFICAT, FLG_BEST_PRICE = :FLG_BEST' +
        '_PRICE, FLG_PRICE_NBM = :FLG_PRICE_NBM, FLG_SUPPLIER_PROMO = :FL' +
        'G_SUPPLIER_PROMO, WARRANTY = :WARRANTY, GOODS_ACNT_ID = :GOODS_A' +
        'CNT_ID, GOODS_TYPE_ID = :GOODS_TYPE_ID, GOODS_TYPE_NAME = :GOODS' +
        '_TYPE_NAME, WEBGOODSTYPE_ID = :WEBGOODSTYPE_ID, WEBGOODSTYPE_TIT' +
        'LE = :WEBGOODSTYPE_TITLE, WEBGOODSTYPE_TITLE_RU = :WEBGOODSTYPE_' +
        'TITLE_RU, VENDOR_ID = :VENDOR_ID, USERID = :USERID, UMID = :UMID' +
        ', SERIAL_TYPE_ID = :SERIAL_TYPE_ID, ORDERNO = :ORDERNO, USER_FUL' +
        'LNAME = :USER_FULLNAME, CREATE_DATE = :CREATE_DATE, NAMEACNT = :' +
        'NAMEACNT, PRICE1 = :PRICE1, PRICE2 = :PRICE2, PRICE3 = :PRICE3, ' +
        'PRICE4 = :PRICE4, PRICE5 = :PRICE5, PRICE6 = :PRICE6, PRICE7 = :' +
        'PRICE7, PRICE1_LEI = :PRICE1_LEI, PRICE2_LEI = :PRICE2_LEI, PRIC' +
        'E3_LEI = :PRICE3_LEI, PRICE4_LEI = :PRICE4_LEI, PRICE5_LEI = :PR' +
        'ICE5_LEI, PRICE6_LEI = :PRICE6_LEI, PRICE7_LEI = :PRICE7_LEI, PR' +
        'ICEC1_LEI = :PRICEC1_LEI, PRICEC2_LEI = :PRICEC2_LEI, PRICEC3_LE' +
        'I = :PRICEC3_LEI, PRICEC4_LEI = :PRICEC4_LEI, PRICEC5_LEI = :PRI' +
        'CEC5_LEI, PRICEC6_LEI = :PRICEC6_LEI, PRICEC7_LEI = :PRICEC7_LEI' +
        ', PRICE1_USD = :PRICE1_USD, PRICE2_USD = :PRICE2_USD, PRICE3_USD' +
        ' = :PRICE3_USD, PRICE4_USD = :PRICE4_USD, PRICE5_USD = :PRICE5_U' +
        'SD, PRICE6_USD = :PRICE6_USD, PRICE7_USD = :PRICE7_USD, CURRENCY' +
        'ID = :CURRENCYID, CURRENCY_TITLE = :CURRENCY_TITLE, VENDOR = :VE' +
        'NDOR, UM_TITLE = :UM_TITLE, QTY_ACCOUNT = :QTY_ACCOUNT, MINQTY =' +
        ' :MINQTY, DELIVERY_TYPEID = :DELIVERY_TYPEID, DELIVERY_TYPENAME ' +
        '= :DELIVERY_TYPENAME, VAT = :VAT, CASHBACK_PERCENT = :CASHBACK_P' +
        'ERCENT, COLORID = :COLORID, COLOR_NAME_RO = :COLOR_NAME_RO, COLO' +
        'R_NAME_RU = :COLOR_NAME_RU'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT GOODSID, PARENTID, FLG_FOLDER, BASE_PARAM, BASE_PARAM_RU,' +
        ' CODE, CODE_RU, TITLE, DETAILS, FLG_SOCIAL, FLG_OLD, FLG_REQUIRE' +
        '_CERTIFICAT, FLG_BEST_PRICE, FLG_PRICE_NBM, FLG_SUPPLIER_PROMO, ' +
        'WARRANTY, GOODS_ACNT_ID, GOODS_TYPE_ID, GOODS_TYPE_NAME, WEBGOOD' +
        'STYPE_ID, WEBGOODSTYPE_TITLE, WEBGOODSTYPE_TITLE_RU, VENDOR_ID, ' +
        'USERID, UMID, SERIAL_TYPE_ID, ORDERNO, USER_FULLNAME, CREATE_DAT' +
        'E, NAMEACNT, PRICE1, PRICE2, PRICE3, PRICE4, PRICE5, PRICE6, PRI' +
        'CE7, PRICE1_LEI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI,' +
        ' PRICE6_LEI, PRICE7_LEI, PRICEC1_LEI, PRICEC2_LEI, PRICEC3_LEI, ' +
        'PRICEC4_LEI, PRICEC5_LEI, PRICEC6_LEI, PRICEC7_LEI, PRICE1_USD, ' +
        'PRICE2_USD, PRICE3_USD, PRICE4_USD, PRICE5_USD, PRICE6_USD, PRIC' +
        'E7_USD, CURRENCYID, CURRENCY_TITLE, VENDOR, UM_TITLE, QTY_ACCOUN' +
        'T, MINQTY, DELIVERY_TYPEID, DELIVERY_TYPENAME, VAT, CASHBACK_PER' +
        'CENT, COLORID, COLOR_NAME_RO, COLOR_NAME_RU FROM VW_TS_GOODS'
      'WHERE'
      '  GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_GOODS'
      ''
      ') q')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrGPUpdate
    SQL.Strings = (
      'select * From vw_ts_goods')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    MasterSource = IBCDataSourceGoodsPrice
    Left = 703
    Top = 153
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoodsPrice
    Left = 704
    Top = 96
  end
  object IBCQueryGoodsPrice: TIBCQuery
    KeyFields = 'DOCID;GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_GOODS_PRICE5213'
      
        '  (DOCID, GOODSID, GOODS_TITLE, CURRENCYID, CURRENCY_TITLE, CURR' +
        'ENCY_TITLE2, PRICE0, PRICE1, PRICE2, PRICE3, PRICE4, PRICE5, PRI' +
        'CE6, PRICE7, MODIFIED_BY, MODIFIED_BY_NAME, FLG_PRICE_FORCED, FL' +
        'G_NEW, FLG_PROMO, FLG_FORCED_ADDON, FLG_SUPPLIER_PROMO, PRICE1_L' +
        'EI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI, ' +
        'PRICE7_LEI, PRICE_FORCED_END_DATE, FLG_NEW_END_DATE, FLG_PROMO_E' +
        'ND_DATE, GOODS_ACNT_ID, GOODS_NAMEACNT, GOODS_PRICE_ACNT, STOCK_' +
        'QTY, PRICE_ACNT_LOW_BOUND, PRICE_ACNT_HIGH_BOUND, FLG_EPP, SUPPL' +
        'IER_GOODS_CODE, CURRENCY4ID, CURRENCY4_TITLE, CURRENCY7ID, CURRE' +
        'NCY7_TITLE, BARCODE, WEB_GOODS_NAME_RO, WEB_GOODS_NAME_RU, MARGI' +
        'N74, DIFF47, flg_pre_order)'
      'VALUES'
      
        '  (:DOCID, :GOODSID, :GOODS_TITLE, :CURRENCYID, :CURRENCY_TITLE,' +
        ' :CURRENCY_TITLE2, :PRICE0, :PRICE1, :PRICE2, :PRICE3, :PRICE4, ' +
        ':PRICE5, :PRICE6, :PRICE7, :MODIFIED_BY, :MODIFIED_BY_NAME, :FLG' +
        '_PRICE_FORCED, :FLG_NEW, :FLG_PROMO, :FLG_FORCED_ADDON, :FLG_SUP' +
        'PLIER_PROMO, :PRICE1_LEI, :PRICE2_LEI, :PRICE3_LEI, :PRICE4_LEI,' +
        ' :PRICE5_LEI, :PRICE6_LEI, :PRICE7_LEI, :PRICE_FORCED_END_DATE, ' +
        ':FLG_NEW_END_DATE, :FLG_PROMO_END_DATE, :GOODS_ACNT_ID, :GOODS_N' +
        'AMEACNT, :GOODS_PRICE_ACNT, :STOCK_QTY, :PRICE_ACNT_LOW_BOUND, :' +
        'PRICE_ACNT_HIGH_BOUND, :FLG_EPP, :SUPPLIER_GOODS_CODE, :CURRENCY' +
        '4ID, :CURRENCY4_TITLE, :CURRENCY7ID, :CURRENCY7_TITLE, :BARCODE,' +
        ' :WEB_GOODS_NAME_RO, :WEB_GOODS_NAME_RU, :MARGIN74, :DIFF47, :fl' +
        'g_pre_order)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_GOODS_PRICE5213'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID AND SUPPLIER_GOO' +
        'DS_CODE = :Old_SUPPLIER_GOODS_CODE')
    SQLUpdate.Strings = (
      'update VW_TDB_GOODS_PRICE5213'
      'set DOCID = :DOCID,'
      '    GOODSID = :GOODSID,'
      '    GOODS_TITLE = :GOODS_TITLE,'
      '    CURRENCYID = :CURRENCYID,'
      '    CURRENCY_TITLE = :CURRENCY_TITLE,'
      '    CURRENCY_TITLE2 = :CURRENCY_TITLE2,'
      '    PRICE0 = :PRICE0,'
      '    PRICE1 = :PRICE1,'
      '    PRICE2 = :PRICE2,'
      '    PRICE3 = :PRICE3,'
      '    PRICE4 = :PRICE4,'
      '    PRICE5 = :PRICE5,'
      '    PRICE6 = :PRICE6,'
      '    PRICE7 = :PRICE7,'
      '    MODIFIED_BY = :MODIFIED_BY,'
      '    MODIFIED_BY_NAME = :MODIFIED_BY_NAME,'
      '    FLG_PRICE_FORCED = :FLG_PRICE_FORCED,'
      '    FLG_NEW = :FLG_NEW,'
      '    FLG_PROMO = :FLG_PROMO,'
      '    FLG_FORCED_ADDON = :FLG_FORCED_ADDON,'
      '    FLG_SUPPLIER_PROMO = :FLG_SUPPLIER_PROMO,'
      '    flg_pre_order = :flg_pre_order,'
      '    PRICE1_LEI = :PRICE1_LEI,'
      '    PRICE2_LEI = :PRICE2_LEI,'
      '    PRICE3_LEI = :PRICE3_LEI,'
      '    PRICE4_LEI = :PRICE4_LEI,'
      '    PRICE5_LEI = :PRICE5_LEI,'
      '    PRICE6_LEI = :PRICE6_LEI,'
      '    PRICE7_LEI = :PRICE7_LEI,'
      '    PRICE_FORCED_END_DATE = :PRICE_FORCED_END_DATE,'
      '    FLG_NEW_END_DATE = :FLG_NEW_END_DATE,'
      '    FLG_PROMO_END_DATE = :FLG_PROMO_END_DATE,'
      '    GOODS_ACNT_ID = :GOODS_ACNT_ID,'
      '    GOODS_NAMEACNT = :GOODS_NAMEACNT,'
      '    GOODS_PRICE_ACNT = :GOODS_PRICE_ACNT,'
      '    STOCK_QTY = :STOCK_QTY,'
      '    PRICE_ACNT_LOW_BOUND = :PRICE_ACNT_LOW_BOUND,'
      '    PRICE_ACNT_HIGH_BOUND = :PRICE_ACNT_HIGH_BOUND,'
      '    FLG_EPP = :FLG_EPP,'
      '    SUPPLIER_GOODS_CODE = :SUPPLIER_GOODS_CODE,'
      ''
      '    CURRENCY3ID = :CURRENCY3ID,'
      '    CURRENCY3_TITLE = :CURRENCY3_TITLE,'
      ''
      '    CURRENCY4ID = :CURRENCY4ID,'
      '    CURRENCY4_TITLE = :CURRENCY4_TITLE,'
      ''
      '    CURRENCY7ID = :CURRENCY7ID,'
      '    CURRENCY7_TITLE = :CURRENCY7_TITLE,'
      '    BARCODE = :BARCODE,'
      '    WEB_GOODS_NAME_RO = :WEB_GOODS_NAME_RO,'
      '    WEB_GOODS_NAME_RU = :WEB_GOODS_NAME_RU,'
      '    MARGIN74 = :MARGIN74,'
      '    DIFF47 = :DIFF47'
      'where DOCID = :OLD_DOCID and'
      '      GOODSID = :OLD_GOODSID and'
      '      SUPPLIER_GOODS_CODE = :OLD_SUPPLIER_GOODS_CODE'
      ''
      '  ')
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TDB_GOODS_PRICE5213'
      'WHERE'
      
        '  DOCID = :DOCID AND GOODSID = :GOODSID AND SUPPLIER_GOODS_CODE ' +
        '= :SUPPLIER_GOODS_CODE')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_GOODS_PRICE'
      'WHERE'
      
        'DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID AND SUPPLIER_GOODS' +
        '_CODE = :Old_SUPPLIER_GOODS_CODE'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_GOODS_PRICE5213'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrGPUpdate
    SQL.Strings = (
      'SELECT'
      ' gg.*'
      'FROM VW_TDB_GOODS_PRICE5213 gg')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    Options.DetailDelay = 750
    BeforePost = IBCQueryGoodsPrice123BeforePost
    AfterPost = IBCQueryGoodsPrice123AfterPost
    AfterCancel = IBCQueryGoodsPrice123AfterCancel
    AfterDelete = IBCQueryGoodsPrice123AfterDelete
    Left = 607
    Top = 153
  end
  object IBCDataSourceGoodsPrice: TIBCDataSource
    DataSet = IBCQueryGoodsPrice
    Left = 608
    Top = 96
  end
  object IBCQuery1: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_GOODS_PRICE5213'
      
        '  (DOCID, GOODSID, GOODS_TITLE, CURRENCYID, CURRENCY_TITLE, CURR' +
        'ENCY_TITLE2, PRICE0, PRICE1, PRICE2, PRICE3, PRICE4, PRICE5, PRI' +
        'CE6, PRICE7, MODIFIED_BY, MODIFIED_BY_NAME, FLG_PRICE_FORCED, FL' +
        'G_NEW, FLG_PROMO, FLG_FORCED_ADDON, FLG_SUPPLIER_PROMO, PRICE1_L' +
        'EI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI, ' +
        'PRICE7_LEI, PRICE_FORCED_END_DATE, FLG_NEW_END_DATE, FLG_PROMO_E' +
        'ND_DATE, GOODS_ACNT_ID, GOODS_NAMEACNT, GOODS_PRICE_ACNT, STOCK_' +
        'QTY, PRICE_ACNT_LOW_BOUND, PRICE_ACNT_HIGH_BOUND, FLG_EXCLUDE_PP' +
        ', SUPPLIER_GOODS_CODE, CURRENCY4ID, CURRENCY4_TITLE, CURRENCY7ID' +
        ', CURRENCY7_TITLE, BARCODE, WEB_GOODS_NAME_RO, WEB_GOODS_NAME_RU' +
        ', MARGIN74, DIFF47)'
      'VALUES'
      
        '  (:DOCID, :GOODSID, :GOODS_TITLE, :CURRENCYID, :CURRENCY_TITLE,' +
        ' :CURRENCY_TITLE2, :PRICE0, :PRICE1, :PRICE2, :PRICE3, :PRICE4, ' +
        ':PRICE5, :PRICE6, :PRICE7, :MODIFIED_BY, :MODIFIED_BY_NAME, :FLG' +
        '_PRICE_FORCED, :FLG_NEW, :FLG_PROMO, :FLG_FORCED_ADDON, :FLG_SUP' +
        'PLIER_PROMO, :PRICE1_LEI, :PRICE2_LEI, :PRICE3_LEI, :PRICE4_LEI,' +
        ' :PRICE5_LEI, :PRICE6_LEI, :PRICE7_LEI, :PRICE_FORCED_END_DATE, ' +
        ':FLG_NEW_END_DATE, :FLG_PROMO_END_DATE, :GOODS_ACNT_ID, :GOODS_N' +
        'AMEACNT, :GOODS_PRICE_ACNT, :STOCK_QTY, :PRICE_ACNT_LOW_BOUND, :' +
        'PRICE_ACNT_HIGH_BOUND, :FLG_EXCLUDE_PP, :SUPPLIER_GOODS_CODE, :C' +
        'URRENCY4ID, :CURRENCY4_TITLE, :CURRENCY7ID, :CURRENCY7_TITLE, :B' +
        'ARCODE, :WEB_GOODS_NAME_RO, :WEB_GOODS_NAME_RU, :MARGIN74, :DIFF' +
        '47)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_GOODS_PRICE5213'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID AND SUPPLIER_GOO' +
        'DS_CODE = :Old_SUPPLIER_GOODS_CODE')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_GOODS_PRICE5213'
      'SET'
      
        '  DOCID = :DOCID, GOODSID = :GOODSID, GOODS_TITLE = :GOODS_TITLE' +
        ', CURRENCYID = :CURRENCYID, CURRENCY_TITLE = :CURRENCY_TITLE, CU' +
        'RRENCY_TITLE2 = :CURRENCY_TITLE2, PRICE0 = :PRICE0, PRICE1 = :PR' +
        'ICE1, PRICE2 = :PRICE2, PRICE3 = :PRICE3, PRICE4 = :PRICE4, PRIC' +
        'E5 = :PRICE5, PRICE6 = :PRICE6, PRICE7 = :PRICE7, MODIFIED_BY = ' +
        ':MODIFIED_BY, MODIFIED_BY_NAME = :MODIFIED_BY_NAME, FLG_PRICE_FO' +
        'RCED = :FLG_PRICE_FORCED, FLG_NEW = :FLG_NEW, FLG_PROMO = :FLG_P' +
        'ROMO, FLG_FORCED_ADDON = :FLG_FORCED_ADDON, FLG_SUPPLIER_PROMO =' +
        ' :FLG_SUPPLIER_PROMO, PRICE1_LEI = :PRICE1_LEI, PRICE2_LEI = :PR' +
        'ICE2_LEI, PRICE3_LEI = :PRICE3_LEI, PRICE4_LEI = :PRICE4_LEI, PR' +
        'ICE5_LEI = :PRICE5_LEI, PRICE6_LEI = :PRICE6_LEI, PRICE7_LEI = :' +
        'PRICE7_LEI, PRICE_FORCED_END_DATE = :PRICE_FORCED_END_DATE, FLG_' +
        'NEW_END_DATE = :FLG_NEW_END_DATE, FLG_PROMO_END_DATE = :FLG_PROM' +
        'O_END_DATE, GOODS_ACNT_ID = :GOODS_ACNT_ID, GOODS_NAMEACNT = :GO' +
        'ODS_NAMEACNT, GOODS_PRICE_ACNT = :GOODS_PRICE_ACNT, STOCK_QTY = ' +
        ':STOCK_QTY, PRICE_ACNT_LOW_BOUND = :PRICE_ACNT_LOW_BOUND, PRICE_' +
        'ACNT_HIGH_BOUND = :PRICE_ACNT_HIGH_BOUND, FLG_EXCLUDE_PP = :FLG_' +
        'EXCLUDE_PP, SUPPLIER_GOODS_CODE = :SUPPLIER_GOODS_CODE, CURRENCY' +
        '4ID = :CURRENCY4ID, CURRENCY4_TITLE = :CURRENCY4_TITLE, CURRENCY' +
        '7ID = :CURRENCY7ID, CURRENCY7_TITLE = :CURRENCY7_TITLE, BARCODE ' +
        '= :BARCODE, WEB_GOODS_NAME_RO = :WEB_GOODS_NAME_RO, WEB_GOODS_NA' +
        'ME_RU = :WEB_GOODS_NAME_RU, MARGIN74 = :MARGIN74, DIFF47 = :DIFF' +
        '47'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID AND SUPPLIER_GOO' +
        'DS_CODE = :Old_SUPPLIER_GOODS_CODE')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, GOODSID, GOODS_TITLE, CURRENCYID, CURRENCY_TITLE, ' +
        'CURRENCY_TITLE2, PRICE0, PRICE1, PRICE2, PRICE3, PRICE4, PRICE5,' +
        ' PRICE6, PRICE7, MODIFIED_BY, MODIFIED_BY_NAME, FLG_PRICE_FORCED' +
        ', FLG_NEW, FLG_PROMO, FLG_FORCED_ADDON, FLG_SUPPLIER_PROMO, PRIC' +
        'E1_LEI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_L' +
        'EI, PRICE7_LEI, PRICE_FORCED_END_DATE, FLG_NEW_END_DATE, FLG_PRO' +
        'MO_END_DATE, GOODS_ACNT_ID, GOODS_NAMEACNT, GOODS_PRICE_ACNT, ST' +
        'OCK_QTY, PRICE_ACNT_LOW_BOUND, PRICE_ACNT_HIGH_BOUND, FLG_EXCLUD' +
        'E_PP, SUPPLIER_GOODS_CODE, CURRENCY4ID, CURRENCY4_TITLE, CURRENC' +
        'Y7ID, CURRENCY7_TITLE, BARCODE, WEB_GOODS_NAME_RO, WEB_GOODS_NAM' +
        'E_RU, MARGIN74, DIFF47 FROM VW_TDB_GOODS_PRICE5213'
      'WHERE'
      
        '  DOCID = :DOCID AND GOODSID = :GOODSID AND SUPPLIER_GOODS_CODE ' +
        '= :SUPPLIER_GOODS_CODE')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_GOODS_PRICE'
      'WHERE'
      
        'DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID AND SUPPLIER_GOODS' +
        '_CODE = :Old_SUPPLIER_GOODS_CODE'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_GOODS_PRICE5213'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrGPUpdate
    SQL.Strings = (
      'SELECT'
      ' gg.*'
      'FROM VW_TDB_GOODS_PRICE5213 gg')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    BeforePost = IBCQueryGoodsPrice123BeforePost
    AfterPost = IBCQueryGoodsPrice123AfterPost
    AfterCancel = IBCQueryGoodsPrice123AfterCancel
    AfterDelete = IBCQueryGoodsPrice123AfterDelete
    Left = 816
    Top = 152
  end
end
