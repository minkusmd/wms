inherited frame25ScetFaktura: Tframe25ScetFaktura
  Width = 1235
  Height = 630
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 1235
  ExplicitHeight = 630
  object cxGridSF: TcxGrid
    Left = 0
    Top = 0
    Width = 1235
    Height = 358
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridSFTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu
      OnKeyDown = cxGridSFTableKeyDown
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
      OnCellDblClick = cxGridSFTableCellDblClick
      OnCustomDrawCell = cxGridSFTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0.00'
          Kind = skSum
          Column = cxGridSFT_SUMA
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
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridSF_FLG_CLOSED: TcxGridDBColumn
        Caption = 'inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridSFT_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridSF_CREATED_DATE: TcxGridDBColumn
        Caption = 'data crearii'
        DataBinding.FieldName = 'CREATED_DATE'
        OnGetDisplayText = cxGridSF_CREATED_DATEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridSFT_DATA: TcxGridDBColumn
        Caption = 'data doc'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridSFT_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridSFT_DTDEP_NAME: TcxGridDBColumn
        Caption = 'depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 16
        Width = 80
      end
      object cxGridSFT_CT_NAME: TcxGridDBColumn
        Caption = 'client'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 16
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 160
      end
      object cxGridSFT_SUMA: TcxGridDBColumn
        Caption = 'suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 96
        Options.HorzSizing = False
        Width = 96
      end
      object cxGridSFT_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridSFT_VAT: TcxGridDBColumn
        Caption = 'tva'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 48
      end
      object cxGridSFT_RATE: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' '#1044#1086#1082'.'
        DataBinding.FieldName = 'RATE'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridSF_RATEUSD: TcxGridDBColumn
        Caption = 'rata usd'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridSFT_PARENTDOCID: TcxGridDBColumn
        Caption = 'id parinte'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridSF_FLG_ACNT: TcxGridDBColumn
        Caption = 'cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridSFT_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 16
        Width = 80
      end
      object cxGridSF_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridSF_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridSF_SC2_NAME: TcxGridDBColumn
        Caption = 'analitica'
        DataBinding.FieldName = 'SC2_NAME'
        MinWidth = 16
        Width = 80
      end
      object cxGridSF_PAY_INFO: TcxGridDBColumn
        Caption = 'Plata'
        DataBinding.FieldName = 'PAY_INFO'
        HeaderAlignmentHorz = taCenter
        HeaderHint = 'Metoda de plata: credit (0% / standard), MIA, incasari legate (numerar, card, transfer) sau metoda aleasa pe site'
        MinWidth = 60
        Options.Editing = False
        Options.FilteringPopupIncrementalFiltering = True
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 110
      end
      object cxGridSF_DTSC_NAME: TcxGridDBColumn
        AlternateCaption = 'analitica DTSC (modalitatea de plata)'
        Caption = 'plata'
        DataBinding.FieldName = 'DTSC_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Options.Editing = False
        Options.FilteringPopupIncrementalFiltering = True
        Width = 80
      end
      object cxGridSF_FLG_EXPORTED: TcxGridDBColumn
        AlternateCaption = 'exportat'
        Caption = 'exp'
        DataBinding.FieldName = 'FLG_EXPORTED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridSF_FLG_NEW_CEC: TcxGridDBColumn
        AlternateCaption = 'cec'
        Caption = 'c'
        DataBinding.FieldName = 'FLG_NEW_CEC'
        MinWidth = 16
        Width = 20
      end
      object cxGridSFTableColumn1: TcxGridDBColumn
        Caption = 'L'
        DataBinding.FieldName = 'FLG_WITH_DELIVERY'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = dmAdditions.cxImageDocs
        Properties.Items = <
          item
            ImageIndex = 0
            Value = 1
          end
          item
            ImageIndex = 2
            Value = 2
          end>
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        MinWidth = 19
        Options.Editing = False
        Options.FilteringWithFindPanel = False
        Options.Focusing = False
        Options.IncSearch = False
        Options.FilteringAddValueItems = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopupMultiSelect = False
        Options.AutoWidthSizable = False
        Options.GroupFooters = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.Sorting = False
        Width = 19
      end
    end
    object cxGridSFLevel: TcxGridLevel
      GridView = cxGridSFTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 358
    Width = 1235
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
    Control = cxPageControl
  end
  object cxPageControl: TcxPageControl
    Left = 0
    Top = 366
    Width = 1235
    Height = 264
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 2
    TabStop = False
    Properties.ActivePage = tbsInvoices
    Properties.CustomButtons.Buttons = <>
    Properties.TabPosition = tpBottom
    LookAndFeel.NativeStyle = True
    OnChange = cxPageControlChange
    ClientRectBottom = 238
    ClientRectLeft = 4
    ClientRectRight = 1231
    ClientRectTop = 4
    object tbsGoods: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&1. Produse'
      ImageIndex = 0
      object dxBarDockControlGoods: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1227
        Height = 26
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
        Top = 26
        Width = 1227
        Height = 208
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        TabOrder = 1
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = True
        LookAndFeel.SkinName = ''
        ExplicitTop = 24
        ExplicitWidth = 1229
        ExplicitHeight = 211
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
          DataController.DataSource = dmDB.IBCDataSourceJurnal
          DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
          DataController.Summary.FooterSummaryItems = <
            item
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
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.NoDataToDisplayInfoText = 'Nu sunt inregistrari'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridDBCol_IMG: TcxGridDBColumn
            DataBinding.FieldName = 'GOODS_TYPE_ID'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 12
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 19
            Options.Editing = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Options.HorzSizing = False
            Options.Moving = False
            Options.ShowCaption = False
            Options.Sorting = False
            VisibleForCustomization = False
            Width = 19
            IsCaptionAssigned = True
          end
          object cxGridComponentsTableColumn1: TcxGridDBColumn
            Caption = 'cod produs'
            DataBinding.FieldName = 'GOODS_ACNT_ID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
            Caption = #1057#1082#1083#1072#1076
            DataBinding.FieldName = 'DTDEP_NAME'
            Visible = False
            MinWidth = 112
            Options.HorzSizing = False
            Width = 112
          end
          object cxGridDBCol_GOODS_NAMEACNT: TcxGridDBColumn
            Caption = 'produs'
            DataBinding.FieldName = 'GOODS_NAMEACNT'
            MinWidth = 16
            Width = 80
          end
          object cxGridDBCol_UM_NAME: TcxGridDBColumn
            Caption = 'um'
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
          object cxGridDBCol_QTY: TcxGridDBColumn
            Caption = 'cant'
            DataBinding.FieldName = 'QTY'
            PropertiesClassName = 'TcxCalcEditProperties'
            OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.Focusing = False
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridDBCol_PRICE: TcxGridDBColumn
            Caption = 'pret'
            DataBinding.FieldName = 'PRICE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 56
            Options.HorzSizing = False
            Width = 56
          end
          object cxGridDBCol_SUMA: TcxGridDBColumn
            Caption = 'suma'
            DataBinding.FieldName = 'SUMA'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 56
            Options.HorzSizing = False
            Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
            Width = 56
          end
          object cxGridDBCol_SUMAVAT: TcxGridDBColumn
            Caption = 'tva'
            DataBinding.FieldName = 'SUMAVAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 56
            Options.HorzSizing = False
            Width = 56
          end
          object cxGridDBCol_GOODSID: TcxGridDBColumn
            Caption = 'id'
            DataBinding.FieldName = 'GOODSID'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 56
            Options.HorzSizing = False
            Width = 56
          end
          object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
            Caption = 'descriere'
            DataBinding.FieldName = 'GOODS_NAME'
            MinWidth = 16
            Width = 160
          end
          object cxGridDB_FLG_ACTIVE: TcxGridDBColumn
            Caption = 'activ'
            DataBinding.FieldName = 'FLG_ACTIVE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridDBCol_FLG_READY: TcxGridDBColumn
            Caption = 'gata'
            DataBinding.FieldName = 'FLG_READY'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 32
            Options.HorzSizing = False
            Width = 32
          end
          object cxGridComponents_PRICE_COLUMN: TcxGridDBColumn
            Caption = 'grila'
            DataBinding.FieldName = 'PRICE_COLUMN'
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridDBCol_GOODS_ACNT_ID: TcxGridDBColumn
            DataBinding.FieldName = 'GOODS_ACNT_ID'
            Visible = False
            MinWidth = 16
            VisibleForCustomization = False
          end
          object cxGridComponents_UMID: TcxGridDBColumn
            DataBinding.FieldName = 'UMID'
            Visible = False
            MinWidth = 16
            VisibleForCustomization = False
          end
          object cxGridComponents_ACNT_QTY: TcxGridDBColumn
            AlternateCaption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
            Caption = 'cant cntb'
            DataBinding.FieldName = 'ACNT_QTY'
            PropertiesClassName = 'TcxCalcEditProperties'
            HeaderAlignmentHorz = taCenter
            MinWidth = 56
            Options.HorzSizing = False
            Width = 56
          end
          object cxGridDBCol_CREATED_DATE: TcxGridDBColumn
            AlternateCaption = 'Creat la'
            DataBinding.FieldName = 'CREATED_DATE'
            Visible = False
            MinWidth = 16
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridComponentsTable
        end
      end
    end
    object tbsInvoices: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&2. Facturi'
      ImageIndex = 1
      object dxBarDockControlInvoices: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1227
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
      object cxGridInvoice: TcxGrid
        Left = 0
        Top = 30
        Width = 1227
        Height = 204
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = True
        LookAndFeel.SkinName = ''
        object cxGridInvoiceTable: TcxGridDBTableView
          PopupMenu = dxBarPopupMenuGoods
          OnKeyDown = cxGridInvoiceTableKeyDown
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
          OnCellDblClick = cxGridInvoiceTableCellDblClick
          OnCustomDrawCell = cxGridInvoiceTableCustomDrawCell
          DataController.DataSource = IBCDataSourceINVOICES
          DataController.KeyFieldNames = 'DOCID;INVOICEID'
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'QTY'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'SUMA'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'SUMAVAT'
            end
            item
              Kind = skCount
            end>
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
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
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridInvoiceTable_INVOICEID: TcxGridDBColumn
            AlternateCaption = 'InvoiceID'
            Caption = 'InvoiceID'
            DataBinding.FieldName = 'INVOICEID'
            Visible = False
            MinWidth = 48
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridInvoiceTable_IMG: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_CANCELED'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 33
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 33
                Value = 0
              end
              item
                ImageIndex = 35
                Value = 1
              end>
            MinWidth = 19
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 19
            IsCaptionAssigned = True
          end
          object cxGridInvoiceTable_TipFacturaNAME: TcxGridDBColumn
            Caption = 'Tip factura'
            DataBinding.FieldName = 'TIP_FACTURA_NAME'
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridInvoiceTable_FACTURANO: TcxGridDBColumn
            Caption = 'numar factura'
            DataBinding.FieldName = 'FACTURANO'
            MinWidth = 67
            Width = 109
          end
          object cxGridInvoiceTable_EF_STATUS: TcxGridDBColumn
            Caption = 'e-Factura'
            DataBinding.FieldName = 'EF_STATUS'
            OnGetDisplayText = cxGridInvoiceTable_EF_STATUSGetDisplayText
            MinWidth = 90
            Width = 130
          end
          object cxGridInvoiceTable_EF_STATUS_DATE: TcxGridDBColumn
            Caption = 'status e-Factura la'
            DataBinding.FieldName = 'EF_STATUS_DATE'
            MinWidth = 80
            Width = 110
          end
          object cxGridInvoiceTable_EF_LAST_ERROR: TcxGridDBColumn
            Caption = 'eroare e-Factura'
            DataBinding.FieldName = 'EF_LAST_ERROR'
            MinWidth = 80
            Width = 200
          end
          object cxGridInvoiceTable_DATA_ELIBERARII: TcxGridDBColumn
            Caption = 'data eliberarii'
            DataBinding.FieldName = 'DATA_ELIBERARII'
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridInvoiceTable_FFType: TcxGridDBColumn
            Caption = 'operatie'
            DataBinding.FieldName = 'FFTYPE_NAME'
            MinWidth = 96
            Options.Editing = False
            Options.Focusing = False
            Options.IgnoreTimeForFiltering = False
            Options.IncSearch = False
            Options.GroupFooters = False
            Options.Grouping = False
            Options.HorzSizing = False
            Options.Moving = False
            Width = 96
          end
          object cxGridInvoiceTable_DELEGAT: TcxGridDBColumn
            Caption = 'delegat'
            DataBinding.FieldName = 'DELEGAT'
            MinWidth = 16
            Width = 84
          end
          object cxGridInvoiceTable_TRANSPORTATOR_NAME: TcxGridDBColumn
            Caption = 'transportator'
            DataBinding.FieldName = 'TRANSPORTATOR_NAME'
            MinWidth = 16
            Width = 83
          end
          object cxGridInvoiceTable_NRMATRICULARE: TcxGridDBColumn
            Caption = 'mijloc de transport'
            DataBinding.FieldName = 'NRMATRICULARE'
            MinWidth = 64
            Options.HorzSizing = False
            Width = 64
          end
          object cxGridInvoiceTable_NRFOAIEDEPARCURS: TcxGridDBColumn
            Caption = 'foia de parcurs'
            DataBinding.FieldName = 'NRFOAIEDEPARCURS'
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridInvoiceTable_PROCURA_NO: TcxGridDBColumn
            Caption = 'procura'
            DataBinding.FieldName = 'PROCURA_NO'
            MinWidth = 112
            Options.HorzSizing = False
            Width = 112
          end
          object cxGridInvoiceTable_FLG_CANCELED: TcxGridDBColumn
            Caption = #1040#1085#1091#1083#1080#1088#1086#1074#1072#1085#1085#1072#1103
            DataBinding.FieldName = 'FLG_CANCELED'
            Visible = False
            MinWidth = 16
            VisibleForCustomization = False
          end
          object cxGridInvoiceTable_FPDATAELIBERARII: TcxGridDBColumn
            AlternateCaption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080' '#1087#1091#1090#1077#1074#1086#1075#1086' '#1083#1080#1089#1090#1072
            Caption = 'data eliberarii foia de parcurs'
            DataBinding.FieldName = 'FPDATAELIBERARII'
            MinWidth = 16
            Width = 42
          end
          object cxGridInvoiceTableColumn1: TcxGridDBColumn
            Caption = 'Redirijari'
            DataBinding.FieldName = 'REDIRIJARI'
            MinWidth = 16
            Width = 54
          end
          object cxGridInvoiceTableColumn2: TcxGridDBColumn
            Caption = 'Redirijari 2'
            DataBinding.FieldName = 'REDIRIJARI_NAME'
            MinWidth = 16
            Width = 54
          end
        end
        object cxGridInvoiceLevel: TcxGridLevel
          GridView = cxGridInvoiceTable
        end
      end
    end
    object tbsReceipts: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&3. Cecuri MCC'
      ImageIndex = 2
      object dxBarDockControlReceipt: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1227
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
      object cxGridReceipts: TcxGrid
        Left = 0
        Top = 30
        Width = 1227
        Height = 204
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = True
        object cxGridReceiptsTable: TcxGridDBTableView
          OnDblClick = cxGridReceiptsTableDblClick
          OnKeyDown = cxGridReceiptsTableKeyDown
          OnCustomDrawCell = cxGridReceiptsTableCustomDrawCell
          DataController.DataSource = IBCDataSourceReceipt
          DataController.KeyFieldNames = 'DOCID;NUMAR_BON'
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '0'
              Kind = skCount
              Column = cxGridReceipts_NUMAR_BON
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Column = cxGridReceipts_SUMA
            end>
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
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
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridReceipts_IMG: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_CANCELED'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 47
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 47
                Value = 0
              end
              item
                ImageIndex = 35
                Value = 1
              end>
            MinWidth = 19
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 19
            IsCaptionAssigned = True
          end
          object cxGridReceipts_DATA_ELIBERARII: TcxGridDBColumn
            Caption = 'data eliberarii'
            DataBinding.FieldName = 'DATA_ELIBERARII'
            MinWidth = 96
            Options.HorzSizing = False
            Width = 96
          end
          object cxGridReceipts_NUMAR_BON: TcxGridDBColumn
            Caption = 'cec nr.'
            DataBinding.FieldName = 'NUMAR_BON'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = '####0000'
            FooterAlignmentHorz = taRightJustify
            MinWidth = 64
            Options.HorzSizing = False
            Width = 64
          end
          object cxGridReceipts_APARAT: TcxGridDBColumn
            Caption = 'aparat'
            DataBinding.FieldName = 'APARAT'
            HeaderAlignmentHorz = taCenter
            HeaderHint = 'Casa pe care a fost emis bonul: MCC Tremol (aparat fizic) sau casa ECC online'
            MinWidth = 104
            Options.HorzSizing = False
            Width = 104
          end
          object cxGridReceipts_SUMA: TcxGridDBColumn
            Caption = 'suma, lei'
            DataBinding.FieldName = 'SUMA'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridReceipts_USER_NAME: TcxGridDBColumn
            Caption = 'utilizator'
            DataBinding.FieldName = 'USER_NAME'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 128
            Options.HorzSizing = False
            Width = 128
          end
          object cxGridReceipts_FLG_NUMERAR: TcxGridDBColumn
            Caption = 'numerar'
            DataBinding.FieldName = 'FLG_NUMERAR'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridReceipts_FLG_BON_PARTIAL: TcxGridDBColumn
            Caption = 'avansuri'
            DataBinding.FieldName = 'FLG_BON_PARTIAL'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 56
            Options.HorzSizing = False
            Width = 56
          end
          object cxGridReceipts_FLG_PERSOANA_JURIDICA: TcxGridDBColumn
            Caption = 'persoana juridica'
            DataBinding.FieldName = 'FLG_PERSOANA_JURIDICA'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridReceipts_FLAGS: TcxGridDBColumn
            Caption = 'descriere'
            OnGetDisplayText = cxGridReceipts_FLAGSGetDisplayText
            MinWidth = 16
          end
          object cxGridReceipts_PRIHOD_DOCID: TcxGridDBColumn
            Caption = 'nr. ordin de incasare'
            DataBinding.FieldName = 'PRIHOD_DOCID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 96
            Options.HorzSizing = False
            Width = 96
          end
          object cxGridReceipts_MEV_LINK: TcxGridDBColumn
            Caption = 'link MEV'
            DataBinding.FieldName = 'MEV_LINK'
            HeaderHint = 'Verificarea bonului ECC pe site-ul SFS (dublu-clic deschide linkul)'
            MinWidth = 64
            Width = 160
          end
        end
        object cxGridReceiptLevel: TcxGridLevel
          GridView = cxGridReceiptsTable
        end
      end
    end
    object tbsSborkaComplect: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&4. Complectatia din asamblari'
      ImageIndex = 3
      object dxBarDockSborkaComplect: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1227
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
      object cxGridComplect: TcxGrid
        Left = 0
        Top = 30
        Width = 1227
        Height = 204
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = True
        ExplicitTop = 27
        ExplicitWidth = 1229
        ExplicitHeight = 208
        object cxGridComplectTable: TcxGridDBTableView
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
          OnCustomDrawCell = cxGridComplectTableCustomDrawCell
          DataController.DataSource = IBCDataSourceJurnalKit
          DataController.KeyFieldNames = 'DOCID;GOODSCOMPLECT_ID;GOODSID'
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              Column = cxGridComplect_SUMA
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Column = cxGridComplect_SUMAVAT
            end
            item
              Kind = skCount
              Column = cxGridComplect_GOODSID
            end
            item
              Format = '0'
              Kind = skSum
              Column = cxGridComplect_QTY
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
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridComplect_DTDEP_NAME: TcxGridDBColumn
            Caption = #1057#1082#1083#1072#1076
            DataBinding.FieldName = 'DTDEP_NAME'
            Visible = False
            MinWidth = 80
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 80
          end
          object cxGridComplect_GOODSID: TcxGridDBColumn
            Caption = 'id'
            DataBinding.FieldName = 'GOODSID'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridComplect_GOODS_TYPE_ID: TcxGridDBColumn
            DataBinding.FieldName = 'GOODS_TYPE_ID'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 12
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 44
                Value = 4203
              end>
            MinWidth = 19
            Options.Editing = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.FilteringPopup = False
            Options.Grouping = False
            Options.HorzSizing = False
            Options.Moving = False
            Options.ShowCaption = False
            VisibleForCustomization = False
            Width = 19
            IsCaptionAssigned = True
          end
          object cxGridComplect_GOODS_NAME: TcxGridDBColumn
            Caption = 'produs'
            DataBinding.FieldName = 'GOODS_NAME'
            MinWidth = 16
            Width = 240
          end
          object cxGridComplect_QTY: TcxGridDBColumn
            Caption = 'cant'
            DataBinding.FieldName = 'QTY'
            PropertiesClassName = 'TcxCalcEditProperties'
            OnGetDisplayText = cxGridComplect_QTYGetDisplayText
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.Focusing = False
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridComplect_UM_NAME: TcxGridDBColumn
            Caption = 'um'
            DataBinding.FieldName = 'UM_NAME'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 26
            Options.Grouping = False
            Options.HorzSizing = False
            Options.Sorting = False
            Width = 26
          end
          object cxGridComplect_PRICE: TcxGridDBColumn
            Caption = 'pret'
            DataBinding.FieldName = 'PRICE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 56
            Options.HorzSizing = False
            Width = 56
          end
          object cxGridComplect_SUMA: TcxGridDBColumn
            Caption = 'suma'
            DataBinding.FieldName = 'SUMA'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 56
            Options.HorzSizing = False
            Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
            Width = 56
          end
          object cxGridComplect_SUMAVAT: TcxGridDBColumn
            Caption = 'tva'
            DataBinding.FieldName = 'SUMAVAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridComplect_FLG_ACTIVE: TcxGridDBColumn
            AlternateCaption = 'activ'
            Caption = 'act'
            DataBinding.FieldName = 'FLG_ACTIVE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 19
            Options.HorzSizing = False
            Width = 19
          end
          object cxGridComplect_FLG_READY: TcxGridDBColumn
            AlternateCaption = #1043#1086#1090#1086#1074
            Caption = #1043
            DataBinding.FieldName = 'FLG_READY'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 19
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 19
          end
          object cxGridComplect_FLG_ACNT: TcxGridDBColumn
            Caption = #1055#1041
            DataBinding.FieldName = 'FLG_ACNT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 40
          end
          object cxGridComplect_WARRANTY: TcxGridDBColumn
            Caption = #1043#1072#1088
            DataBinding.FieldName = 'WARRANTY'
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 32
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 32
          end
          object cxGridComplect_COST: TcxGridDBColumn
            Caption = #1050#1086#1089#1090
            DataBinding.FieldName = 'COST'
            Visible = False
            MinWidth = 16
            VisibleForCustomization = False
          end
          object cxGridComplect_CREATED_BY_NAME: TcxGridDBColumn
            Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
            DataBinding.FieldName = 'CREATED_BY_NAME'
            Visible = False
            MinWidth = 80
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 80
          end
          object cxGridComplect_GOODS_ACNT_ID: TcxGridDBColumn
            AlternateCaption = 'id cntb'
            Caption = 'id cntb'
            DataBinding.FieldName = 'GOODS_ACNT_ID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridComplect_GOODS_NAMEACNT: TcxGridDBColumn
            Caption = 'denumire cntb'
            DataBinding.FieldName = 'GOODS_NAMEACNT'
            MinWidth = 40
            Width = 80
          end
          object cxGridComplect_UMID: TcxGridDBColumn
            DataBinding.FieldName = 'UMID'
            Visible = False
            MinWidth = 16
            VisibleForCustomization = False
          end
          object cxGridComplect_ACNT_QTY: TcxGridDBColumn
            AlternateCaption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
            Caption = 'cant cntb'
            DataBinding.FieldName = 'ACNT_QTY'
            PropertiesClassName = 'TcxCalcEditProperties'
            HeaderAlignmentHorz = taCenter
            MinWidth = 56
            Options.HorzSizing = False
            Width = 56
          end
        end
        object cxGridComplectLevel: TcxGridLevel
          GridView = cxGridComplectTable
        end
      end
    end
    object tbsDelivery: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&5. Livrari'
      ImageIndex = 4
      TabVisible = False
      OnShow = tbsDeliveryShow
      DesignSize = (
        1227
        234)
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1227
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = dalTop
        BarManager = dxBarManager
      end
      object cxDBVerticalGrid1: TcxDBVerticalGrid
        Left = 2
        Top = 27
        Width = 873
        Height = 206
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight, akBottom]
        LookAndFeel.NativeStyle = True
        OptionsView.ShowEditButtons = ecsbAlways
        OptionsView.RowHeaderMinWidth = 19
        OptionsView.RowHeaderWidth = 26
        OptionsView.ValueWidth = 80
        OptionsView.ValueMinWidth = 32
        OptionsView.NavigatorOffset = 40
        ScrollbarAnnotations.CustomAnnotations = <>
        TabOrder = 1
        DataController.DataSource = IBCDSDelivery
        DataController.GridMode = True
        ExplicitWidth = 875
        ExplicitHeight = 207
        Version = 1
        object cxDBVerticalGrid1DOCID: TcxDBEditorRow
          Properties.DataBinding.FieldName = 'DOCID'
          Visible = False
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
        object cxDBVerticalGrid1COURIERID: TcxDBEditorRow
          Properties.DataBinding.FieldName = 'COURIERID'
          Visible = False
          ID = 1
          ParentID = -1
          Index = 1
          Version = 1
        end
        object cxDBVerticalGrid1CategoryRow2: TcxCategoryRow
          Properties.Caption = 'Transportator'
          ID = 2
          ParentID = -1
          Index = 2
          Version = 1
        end
        object cxDBVerticalGrid1COURIER_NAME: TcxDBEditorRow
          Properties.Caption = 'Curier'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.EditProperties.OnButtonClick = cxDBVerticalGrid1COURIER_NAMEEditPropertiesButtonClick
          Properties.DataBinding.FieldName = 'COURIER_NAME'
          ID = 3
          ParentID = 2
          Index = 0
          Version = 1
        end
        object cxDBVerticalGrid1AWB: TcxDBEditorRow
          Properties.Caption = 'AWB #'
          Properties.EditPropertiesClassName = 'TcxCalcEditProperties'
          Properties.DataBinding.FieldName = 'AWB'
          ID = 4
          ParentID = 2
          Index = 1
          Version = 1
        end
        object cxDBVerticalGrid1DBMultiEditorRow1: TcxDBMultiEditorRow
          Properties.Editors = <
            item
              Caption = 'Factura'
              EditPropertiesClassName = 'TcxCheckBoxProperties'
              EditProperties.ValueChecked = '1'
              EditProperties.ValueUnchecked = '0'
              Width = 32
              DataBinding.FieldName = 'FLG_INVOICE_ONDELIVERY'
            end
            item
              Caption = 'Numerar'
              EditPropertiesClassName = 'TcxCheckBoxProperties'
              EditProperties.ValueChecked = '1'
              EditProperties.ValueUnchecked = '0'
              Width = 48
              DataBinding.FieldName = 'FLG_CASHONDELIVERY'
            end
            item
              Caption = 'Card bancar'
              EditPropertiesClassName = 'TcxCheckBoxProperties'
              EditProperties.Alignment = taLeftJustify
              EditProperties.ValueChecked = '1'
              EditProperties.ValueUnchecked = '0'
              Width = 40
              DataBinding.FieldName = 'FLG_POS_TERMINAL'
            end
            item
              Caption = 'Pe credit'
              EditPropertiesClassName = 'TcxCheckBoxProperties'
              EditProperties.ValueChecked = '1'
              EditProperties.ValueUnchecked = '0'
              Width = 40
              DataBinding.FieldName = 'FLG_CREDIT'
            end>
          ID = 5
          ParentID = 2
          Index = 2
          Version = 1
        end
        object cxDBVerticalGrid1CategoryRow1: TcxCategoryRow
          Properties.Caption = 'Destinatar'
          ID = 6
          ParentID = -1
          Index = 3
          Version = 1
        end
        object cxDBVerticalGrid1DELIVERY_DATE: TcxDBEditorRow
          Properties.Caption = 'Data'
          Properties.EditPropertiesClassName = 'TcxDateEditProperties'
          Properties.DataBinding.FieldName = 'DELIVERY_DATE'
          ID = 7
          ParentID = 6
          Index = 0
          Version = 1
        end
        object cxDBVerticalGrid1DELIVERY_TIME: TcxDBEditorRow
          Properties.Caption = 'Intervalul de timp'
          Properties.DataBinding.FieldName = 'DELIVERY_TIME'
          ID = 8
          ParentID = 6
          Index = 1
          Version = 1
        end
        object cxDBVerticalGrid1DBMultiEditorRow2: TcxDBMultiEditorRow
          Properties.Editors = <
            item
              Caption = 'Raion'
              EditPropertiesClassName = 'TcxLookupComboBoxProperties'
              EditProperties.GridMode = True
              EditProperties.ImmediatePost = True
              EditProperties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
              EditProperties.KeyFieldNames = 'SYSSID'
              EditProperties.ListColumns = <
                item
                  FieldName = 'TITLE'
                end>
              EditProperties.ListOptions.SyncMode = True
              EditProperties.ListSource = IBCDataSourceSysS
              EditProperties.PostPopupValueOnTab = True
              EditProperties.OnInitPopup = cxDBVerticalGrid1DBMultiEditorRow2Editors0EditPropertiesInitPopup
              Width = 40
              DataBinding.FieldName = 'DISTRICTID'
              Options.ExcelFilterPopup.ApplyChanges = efacOnTabOrOKButtonClick
              Options.ExcelFilterPopup.DefaultPage = dpValues
              Options.FilterPopup.IncrementalFiltering.Enabled = True
              Options.FilterPopupMode = fpmExcel
              Options.ShowEditButtons = eisbAlways
            end
            item
              Caption = 'Oras'
              EditPropertiesClassName = 'TcxLookupComboBoxProperties'
              EditProperties.GridMode = True
              EditProperties.ImmediatePost = True
              EditProperties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
              EditProperties.KeyFieldNames = 'SYSSID'
              EditProperties.ListColumns = <
                item
                  FieldName = 'TITLE'
                end>
              EditProperties.ListOptions.SyncMode = True
              EditProperties.ListSource = IBCDataSourceCities
              EditProperties.PostPopupValueOnTab = True
              EditProperties.OnInitPopup = cxDBVerticalGrid1DBMultiEditorRow2Editors1EditPropertiesInitPopup
              Width = 40
              DataBinding.FieldName = 'CITYID'
              Options.FilterPopup.IncrementalFiltering.Enabled = True
              Options.FilterPopupMode = fpmExcel
            end>
          ID = 9
          ParentID = 6
          Index = 2
          Version = 1
        end
        object cxDBVerticalGrid1DELIVERY_ADDRESS: TcxDBEditorRow
          Properties.Caption = 'Adresa'
          Properties.EditPropertiesClassName = 'TcxMemoProperties'
          Properties.EditProperties.VisibleLineCount = 2
          Properties.DataBinding.FieldName = 'DELIVERY_ADDRESS'
          ID = 10
          ParentID = 6
          Index = 3
          Version = 1
        end
        object cxDBVerticalGrid1DBEditorRow1: TcxDBEditorRow
          Properties.Caption = 'Mentiuni'
          Properties.EditPropertiesClassName = 'TcxMemoProperties'
          Properties.EditProperties.VisibleLineCount = 5
          Properties.DataBinding.FieldName = 'COMMENTS'
          ID = 11
          ParentID = -1
          Index = 4
          Version = 1
        end
      end
    end
    object tbsScanFiles: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '6. Scanuri'
      ImageIndex = 5
      OnHide = tbsScanFilesHide
      OnShow = tbsScanFilesShow
      inline frameScanFile1: TframeScanFile
        Left = 0
        Top = 0
        Width = 1227
        Height = 234
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 1227
        ExplicitHeight = 234
        inherited cxGridFiles: TcxGrid
          Width = 1227
          Height = 206
          ParentFont = False
          ExplicitWidth = 1227
          ExplicitHeight = 206
        end
        inherited dxBarDockControl1: TdxBarDockControl
          Width = 1227
          ExplicitWidth = 1227
        end
        inherited dxBarManager1: TdxBarManager
          PixelsPerInch = 96
        end
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
      'Default'
      'PopupDoc'
      'Delivery')
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
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 296
    Top = 68
    PixelsPerInch = 96
    object dxBarManagerBarGoods: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'Goods'
      CaptionButtons = <>
      DockControl = dxBarDockControlGoods
      DockedDockControl = dxBarDockControlGoods
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 939
      FloatTop = 0
      FloatClientWidth = 114
      FloatClientHeight = 77
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
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbBringGoodsFromDocs'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSubItemsPriceColumns'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControlInvoices
      DockedDockControl = dxBarDockControlInvoices
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1214
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewInvoice'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyInvoice'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteInvoice'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPrintInvoice'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbExport2eFactura'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbEFacturaSend'
        end
        item
          Visible = True
          ItemName = 'bbEFacturaSync'
        end
        item
          Visible = True
          ItemName = 'bbEFacturaPdf'
        end
        item
          Visible = True
          ItemName = 'bbEFacturaCancel'
        end
        item
          Visible = True
          ItemName = 'bbEFacturaMarkNotSent'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarReceipt: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControlReceipt
      DockedDockControl = dxBarDockControlReceipt
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1214
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbActionPrintReceipt'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbEditCec'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCancelReceipt'
        end
        item
          BeginGroup = True
          Visible = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          ItemName = 'bbPrintReceiptCopy'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteReceipt'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockControl = dxBarDockSborkaComplect
      DockedDockControl = dxBarDockSborkaComplect
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1247
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSborkaComplectBringGoods'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSborkaComplectAddGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSborkaComplectModifyGoods'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSborkaComplectRemoveGoods'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSubItemsPriceColumnsComplect'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar4: TdxBar
      Caption = 'Delivery'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 894
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeliveryAdd'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeliverySave'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeliveryDel'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton5'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
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
    object bbActionPrintReceipt: TdxBarButton
      Caption = 'Tipar cec...'
      Category = 0
      Hint = 'Tipar cec'
      Visible = ivAlways
      ImageIndex = 47
      OnClick = bbActionPrintReceiptClick
    end
    object bbPrintReceiptCopy: TdxBarButton
      Caption = 'Tipareste copia cecului...'
      Category = 0
      Hint = 
        'Tipareste cecul ECC selectat (imaginea salvata la emitere) pe imprimanta aleasa; ' +
        'nu emite un cec nou. Imprimanta aleasa ramine pentru cecurile ECC de pe acest calculator'
      Visible = ivAlways
      ImageIndex = 28
      OnClick = bbPrintReceiptCopyClick
    end
    object bbCancelReceipt: TdxBarButton
      Caption = 'Anulare "Bon Fiscal"'
      Category = 0
      Hint = 'Anulare "Bon Fiscal"'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbCancelReceiptClick
    end
    object bbNewInvoice: TdxBarButton
      Caption = 'factura noua'
      Category = 0
      Hint = 'factura noua'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewInvoiceClick
    end
    object bbDeleteInvoice: TdxBarButton
      Caption = 'sterge factura'
      Category = 0
      Hint = 'sterge factura'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteInvoiceClick
    end
    object bbDeleteReceipt: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteReceiptClick
    end
    object bbGotoParentDoc: TdxBarButton
      Caption = 'Treci la document parinte'
      Category = 0
      Hint = 'Treci la document parinte'
      Visible = ivAlways
      ShortCut = 32805
      OnClick = bbGotoParentDocClick
    end
    object bbDebtsNotify: TdxBarButton
      Caption = 'Aminteste despre creante'
      Category = 0
      Hint = 'Aminteste despre creante'
      Visible = ivAlways
      OnClick = bbDebtsNotifyClick
    end
    object bbCustomerDebts: TdxBarButton
      Caption = 'Alerta creante client...'
      Category = 0
      Hint = 'Alerta creante client'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object bbDocComments: TdxBarButton
      Caption = 'Comentariu'
      Category = 0
      Hint = 'Comentariu'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbBringGoodsFromRashod: TdxBarButton
      Caption = 'Copie din documentul parinte...'
      Category = 0
      Hint = 'Copie din documentul parinte'
      Visible = ivAlways
      OnClick = bbBringGoodsFromRashodClick
    end
    object bbChangeCasa: TdxBarButton
      Caption = 'Corectare casa..'
      Category = 0
      Hint = 'Corectare casa..'
      Visible = ivAlways
      OnClick = bbChangeCasaClick
    end
    object bbBringGoodsFromDocs: TdxBarSubItem
      Caption = 'Instrumente produse'
      Category = 0
      Visible = ivAlways
      ImageIndex = 12
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbBringGoodsFromRashod'
        end
        item
          Visible = True
          ItemName = 'bbBringGoodsFromCustomDoc'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbBringGoodsFromMultiSborka'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAccountName'
        end>
    end
    object bbBringGoodsFromCustomDoc: TdxBarButton
      Caption = 'Copie din alt document...'
      Category = 0
      Hint = 'Copie din alt document'
      Visible = ivAlways
      OnClick = bbBringGoodsFromCustomDocClick
    end
    object bbSborkaComplectBringGoods: TdxBarButton
      Caption = 'copie din asamblare'
      Category = 0
      Hint = 'copie din asamblare'
      Visible = ivAlways
      ImageIndex = 12
      OnClick = bbSborkaComplectBringGoodsClick
    end
    object bbSborkaComplectAddGoods: TdxBarButton
      Caption = 'produs nou'
      Category = 0
      Hint = 'produs nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbSborkaComplectAddGoodsClick
    end
    object bbSborkaComplectModifyGoods: TdxBarButton
      Caption = 'modifica'
      Category = 0
      Hint = 'modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbSborkaComplectModifyGoodsClick
    end
    object bbSborkaComplectRemoveGoods: TdxBarButton
      Caption = 'sterge'
      Category = 0
      Hint = 'sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbSborkaComplectRemoveGoodsClick
    end
    object bbPriceCol0: TdxBarButton
      Caption = 'Intrarea...'
      Category = 0
      Hint = 'Intrarea'
      Visible = ivAlways
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol1: TdxBarButton
      Tag = 1
      Caption = 'Pret online'
      Category = 0
      Hint = 'Pret online'
      Visible = ivAlways
      ShortCut = 32817
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol2: TdxBarButton
      Tag = 2
      Caption = '2 grila...'
      Category = 0
      Hint = '2 grila'
      Visible = ivAlways
      ShortCut = 16434
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol3: TdxBarButton
      Tag = 3
      Caption = '3 grila...'
      Category = 0
      Hint = '3 grila'
      Visible = ivAlways
      ShortCut = 16435
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol4: TdxBarButton
      Tag = 4
      Caption = '4 grila...'
      Category = 0
      Hint = '4 grila'
      Visible = ivAlways
      ShortCut = 16436
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol5: TdxBarButton
      Tag = 5
      Caption = 'Pret discount card'
      Category = 0
      Hint = 'Pret discount card'
      Visible = ivAlways
      ShortCut = 32821
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol6: TdxBarButton
      Tag = 6
      Caption = 'Pret diler'
      Category = 0
      Hint = 'Pret diler'
      Visible = ivAlways
      ShortCut = 32822
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol7: TdxBarButton
      Tag = 7
      Caption = '7 grila...'
      Category = 0
      Hint = '7 grila'
      Visible = ivAlways
      ShortCut = 16439
      OnClick = bbPriceCol0Click
    end
    object bbSubItemsPriceColumns: TdxBarSubItem
      Caption = 'Grile de preturi'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
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
          ItemName = 'bbPriceCol5'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol6'
        end>
    end
    object bbSubItemsPriceColumnsComplect: TdxBarSubItem
      Caption = 'grila de preturi'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbPriceCol0Complect'
        end>
    end
    object bbPriceCol0Complect: TdxBarButton
      Caption = 'pret intrare...'
      Category = 0
      Hint = 'pret intrare'
      Visible = ivAlways
      OnClick = bbPriceCol0ComplectClick
    end
    object bbBringGoodsFromMultiSborka: TdxBarButton
      Caption = 'Copie din mai multe documente de vinzari...'
      Category = 0
      Hint = 'Copie din mai multe documente de vinzari'
      Visible = ivAlways
      ImageIndex = 25
      OnClick = bbBringGoodsFromMultiSborkaClick
    end
    object bbGoodsForeignCode: TdxBarLargeButton
      Caption = #1057#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1076#1088#1091#1075#1080#1093' '#1092#1080#1088#1084#1072#1093'...'
      Category = 0
      Hint = #1057#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1076#1088#1091#1075#1080#1093' '#1092#1080#1088#1084#1072#1093
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCodeClick
    end
    object bbGoodsInfoCard: TdxBarButton
      Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1090#1086#1074#1072#1088#1072'...'
      Category = 0
      Hint = #1050#1072#1088#1090#1086#1095#1082#1072' '#1090#1086#1074#1072#1088#1072
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsInfoCardClick
    end
    object bbGoodsPrice: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1094#1077#1085#1099' '#1090#1086#1074#1072#1088#1072'...'
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1094#1077#1085#1099' '#1090#1086#1074#1072#1088#1072
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbGoodsPriceClick
    end
    object bbEditCec: TdxBarButton
      Caption = 'Modifica cec'
      Category = 0
      Hint = 'Modifica cec'
      Visible = ivAlways
      OnClick = bbEditCecClick
    end
    object bbPKO: TdxBarButton
      Caption = 'Dispozitie de incasare bancara...'
      Category = 0
      Hint = 'Dispozitie de incasare bancara'
      Visible = ivAlways
      ShortCut = 32837
      OnClick = bbPKOClick
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Tipar Act de primire/predare'
      Category = 0
      Hint = 'Tipar Act de primire/predare'
      Visible = ivAlways
      ImageIndex = 28
      OnClick = dxBarButton5Click
    end
    object bbPdncRamburs: TdxBarButton
      Caption = 'Dispozitie de incasare cu ramburs...'
      Category = 0
      Hint = 'Dispozitie de incasare cu ramburs'
      Visible = ivAlways
      ShortCut = 41029
      OnClick = bbPdncRambursClick
    end
    object bbBankOut: TdxBarButton
      Caption = 'Dispozitie de plata bancara...'
      Category = 0
      Hint = 'Dispozitie de plata bancara'
      Visible = ivAlways
      OnClick = bbBankOutClick
    end
    object bbFLG_Export_Cancel: TdxBarButton
      Caption = 'Anuleaza FLG_EXPORT'
      Category = 0
      Hint = 'Anuleaza FLG_EXPORT'
      Visible = ivAlways
      OnClick = bbFLG_Export_CancelClick
    end
    object bbEFacturaSend: TdxBarButton
      Caption = 'Trimite in e-Factura'
      Category = 0
      Hint = 'Trimite factura in e-Factura prin API (nesemnata, la "Facturi noi")'
      Visible = ivAlways
      OnClick = bbEFacturaSendClick
    end
    object bbEFacturaSync: TdxBarButton
      Caption = 'Actualizeaza status'
      Category = 0
      Hint = 'Preia din e-Factura statusul si seria/numarul facturii'
      Visible = ivAlways
      OnClick = bbEFacturaSyncClick
    end
    object bbEFacturaPdf: TdxBarButton
      Caption = 'PDF e-Factura'
      Category = 0
      Hint = 'Deschide PDF-ul facturii generat de e-Factura'
      Visible = ivAlways
      OnClick = bbEFacturaPdfClick
    end
    object bbEFacturaCancel: TdxBarButton
      Caption = 'Anuleaza in e-Factura'
      Category = 0
      Hint = 'Anuleaza factura in e-Factura (doar pana semneaza cumparatorul)'
      Visible = ivAlways
      OnClick = bbEFacturaCancelClick
    end
    object bbEFacturaMarkNotSent: TdxBarButton
      Caption = 'Marcheaza ca netrimisa'
      Category = 0
      Hint = 'Factura trimisa care nu exista in e-Factura (respinsa la procesare): dupa verificare in e-Factura poate fi stearsa sau retrimisa'
      Visible = ivAlways
      OnClick = bbEFacturaMarkNotSentClick
    end
    object bbExport2eFactura: TdxBarButton
      Caption = 'Export XML e-Factura'
      Category = 0
      Hint = 'Salveaza XML-ul facturii pentru importul manual in e-Factura'
      Visible = ivAlways
      ShortCut = 16453
      OnClick = bbExport2eFacturaClick
    end
    object bbDublicateDocument: TdxBarButton
      Caption = 'Creaza in baza doc. curent'
      Category = 0
      Hint = 'Creaza document nou in baza doc. curent'
      Visible = ivAlways
      OnClick = bbDublicateDocumentClick
    end
    object bbAccountName: TdxBarButton
      Caption = 'Denumire contabilitate'
      Category = 0
      Hint = 'Denumire contabilitate'
      Visible = ivAlways
      ShortCut = 24642
      OnClick = bbAccountNameClick
    end
    object bbModifyInvoice: TdxBarButton
      Caption = 'modifica factura'
      Category = 1
      Hint = 'modifica factura'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyInvoiceClick
    end
    object bbPrintInvoice: TdxBarButton
      Caption = 'Tipar factura'
      Category = 1
      Hint = 'Tipar factura'
      Visible = ivAlways
      ImageIndex = 28
      ShortCut = 24656
      OnClick = bbPrintInvoiceClick
    end
    object bbDeliveryAdd: TdxBarButton
      Caption = 'Modifica livrarea'
      Category = 2
      Hint = 'Modifica livrarea'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbDeliveryAddClick
    end
    object bbDeliveryDel: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeliveryDelClick
    end
    object bbDeliverySave: TdxBarButton
      Caption = 'Salveaza...'
      Category = 2
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
      OnClick = bbDeliverySaveClick
    end
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbPrintInvoice'
      end
      item
        Visible = True
        ItemName = 'bbActionPrintReceipt'
      end
      item
        Visible = True
        ItemName = 'bbPKO'
      end
      item
        Visible = True
        ItemName = 'bbPdncRamburs'
      end
      item
        Visible = True
        ItemName = 'bbBankOut'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDublicateDocument'
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
        ItemName = 'bbFLG_Export_Cancel'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        Visible = True
        ItemName = 'bbChangeCasa'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGotoParentDoc'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuPopup
    Left = 47
    Top = 73
    PixelsPerInch = 96
  end
  object IBCQueryINVOICES: TIBCQuery
    KeyFields = 'INVOICEID'
    KeyGenerator = 'SQ_TDB_INVOICES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      
        'INSERT INTO VW_TDB_INVOICES (DOCID, INVOICEID, FACTURANO, DELEGA' +
        'T, PROCURAID, TRANSPORTATOR, NRMATRICULARE,'
      
        '                             NRFOAIEDEPARCURS, DATA_ELIBERARII, ' +
        'USERID, FLG_CANCELED, TRANSPORTATOR_NAME,'
      
        '                             PROCURA_DELEGAT, PROCURA_NO, PROCUR' +
        'A_CUSTOMER_NAME, USERID_NAME, DOCUMENTE_ANEXATE,'
      
        '                             FPDATAELIBERARII, REDIRIJARI, TIP_F' +
        'ACTURA, TIP_FACTURA_NAME, PUNCT_INCARCARE,'
      
        '                             PUNCT_DESCARCARE, FFTYPEID, FFTYPE_' +
        'NAME, redirijariid, redirijari_name)'
      
        'VALUES (:DOCID, :INVOICEID, :FACTURANO, :DELEGAT, :PROCURAID, :T' +
        'RANSPORTATOR, :NRMATRICULARE, :NRFOAIEDEPARCURS,'
      
        '        :DATA_ELIBERARII, :USERID, :FLG_CANCELED, :TRANSPORTATOR' +
        '_NAME, :PROCURA_DELEGAT, :PROCURA_NO,'
      
        '        :PROCURA_CUSTOMER_NAME, :USERID_NAME, :DOCUMENTE_ANEXATE' +
        ', :FPDATAELIBERARII, :REDIRIJARI, :TIP_FACTURA,'
      
        '        :TIP_FACTURA_NAME, :PUNCT_INCARCARE, :PUNCT_DESCARCARE, ' +
        ':FFTYPEID, :FFTYPE_NAME, :redirijariid, :redirijari_name)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_INVOICES'
      'WHERE'
      '  INVOICEID = :Old_INVOICEID AND DOCID = :Old_DOCID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_INVOICES'
      'SET DOCID = :DOCID,'
      '    INVOICEID = :INVOICEID,'
      '    FACTURANO = :FACTURANO,'
      '    DELEGAT = :DELEGAT,'
      '    PROCURAID = :PROCURAID,'
      '    TRANSPORTATOR = :TRANSPORTATOR,'
      '    NRMATRICULARE = :NRMATRICULARE,'
      '    NRFOAIEDEPARCURS = :NRFOAIEDEPARCURS,'
      '    DATA_ELIBERARII = :DATA_ELIBERARII,'
      '    USERID = :USERID,'
      '    FLG_CANCELED = :FLG_CANCELED,'
      '    TRANSPORTATOR_NAME = :TRANSPORTATOR_NAME,'
      '    PROCURA_DELEGAT = :PROCURA_DELEGAT,'
      '    PROCURA_NO = :PROCURA_NO,'
      '    PROCURA_CUSTOMER_NAME = :PROCURA_CUSTOMER_NAME,'
      '    USERID_NAME = :USERID_NAME,'
      '    DOCUMENTE_ANEXATE = :DOCUMENTE_ANEXATE,'
      '    FPDATAELIBERARII = :FPDATAELIBERARII,'
      '    REDIRIJARI = :REDIRIJARI,'
      '    TIP_FACTURA = :TIP_FACTURA,'
      '    TIP_FACTURA_NAME = :TIP_FACTURA_NAME,'
      '    PUNCT_INCARCARE = :PUNCT_INCARCARE,'
      '    PUNCT_DESCARCARE = :PUNCT_DESCARCARE,'
      '    FFTYPEID = :FFTYPEID,'
      '    FFTYPE_NAME = :FFTYPE_NAME,'
      '    REDIRIJARIID = :REDIRIJARIID,'
      '    REDIRIJARI_NAME = :REDIRIJARI_NAME'
      'WHERE INVOICEID = :OLD_INVOICEID AND'
      '      DOCID = :OLD_DOCID'
      ''
      '  ')
    SQLRefresh.Strings = (
      'SELECT VW_TDB_INVOICES.*,'
      ' (SELECT E.EF_STATUS FROM TDB_EFACTURA E WHERE E.INVOICEID = VW_TDB_INVOICES.INVOICEID) EF_STATUS,'
      ' (SELECT E.EF_STATUS_DATE FROM TDB_EFACTURA E WHERE E.INVOICEID = VW_TDB_INVOICES.INVOICEID) EF_STATUS_DATE,'
      ' (SELECT E.SERIA || '#39' '#39' || E.EF_NUMBER FROM TDB_EFACTURA E WHERE E.INVOICEID = VW_TDB_INVOICES.INVOICEID) EF_SERIA_NUMBER,'
      ' (SELECT E.LAST_ERROR FROM TDB_EFACTURA E WHERE E.INVOICEID = VW_TDB_INVOICES.INVOICEID) EF_LAST_ERROR'
      'FROM VW_TDB_INVOICES'
      'WHERE'
      '  INVOICEID = :INVOICEID AND DOCID = :DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_INVOICES'
      'WHERE'
      'INVOICEID = :Old_INVOICEID AND DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_INVOICES'
      ''
      ') q')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_INVOICES.*,'
      ' (SELECT E.EF_STATUS FROM TDB_EFACTURA E WHERE E.INVOICEID = VW_TDB_INVOICES.INVOICEID) EF_STATUS,'
      ' (SELECT E.EF_STATUS_DATE FROM TDB_EFACTURA E WHERE E.INVOICEID = VW_TDB_INVOICES.INVOICEID) EF_STATUS_DATE,'
      ' (SELECT E.SERIA || '#39' '#39' || E.EF_NUMBER FROM TDB_EFACTURA E WHERE E.INVOICEID = VW_TDB_INVOICES.INVOICEID) EF_SERIA_NUMBER,'
      ' (SELECT E.LAST_ERROR FROM TDB_EFACTURA E WHERE E.INVOICEID = VW_TDB_INVOICES.INVOICEID) EF_LAST_ERROR'
      'FROM'
      ' VW_TDB_INVOICES')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 50
    AfterInsert = IBCQueryINVOICESAfterInsert
    Left = 329
    Top = 145
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceINVOICES: TIBCDataSource
    DataSet = IBCQueryINVOICES
    Left = 368
    Top = 68
  end
  object IBCQueryReceipt: TIBCQuery
    SQLDelete.Strings = (
      'DELETE FROM TDB_DOCS_RECEIPT'
      'WHERE'
      '  DOCID = :Old_DOCID AND NUMAR_BON = :Old_NUMAR_BON')
    SQLUpdate.Strings = (
      'UPDATE VW_DOCS_RECEIPT'
      'SET'
      '  FLG_CANCELED = :FLG_CANCELED'
      'WHERE'
      '  DOCID = :Old_DOCID AND NUMAR_BON = :Old_NUMAR_BON')
    SQLRefresh.Strings = (
      'SELECT '
      ' VW_DOCS_RECEIPT.*,'
      ' (SELECT CASE WHEN R.ECC_TRANS_ID IS NOT NULL OR D.DEVICE_TYPE = 1'
      '   THEN '#39'Casa ECC online'#39' ELSE '#39'MCC Tremol'#39' END'
      '  FROM TDB_DOCS_RECEIPT R LEFT JOIN FP_DEVICES D ON D.FP_ID = R.FP_ID'
      '  WHERE R.DOCID = VW_DOCS_RECEIPT.DOCID AND R.NUMAR_BON = VW_DOCS_RECEIPT.NUMAR_BON) AS APARAT,'
      ' (SELECT R.ECC_TRANS_ID FROM TDB_DOCS_RECEIPT R'
      '  WHERE R.DOCID = VW_DOCS_RECEIPT.DOCID AND R.NUMAR_BON = VW_DOCS_RECEIPT.NUMAR_BON) AS ECC_TRANS_ID,'
      ' (SELECT E.MEV_LINK FROM TDB_DOCS_RECEIPT R'
      '  JOIN TFP_ECC_TRANSACTION E ON E.TRANS_ID = R.ECC_TRANS_ID'
      '  WHERE R.DOCID = VW_DOCS_RECEIPT.DOCID AND R.NUMAR_BON = VW_DOCS_RECEIPT.NUMAR_BON) AS MEV_LINK'
      'FROM VW_DOCS_RECEIPT'
      'WHERE'
      ' VW_DOCS_RECEIPT.DOCID = :DOCID AND VW_DOCS_RECEIPT.NUMAR_BON = :NUMAR_BON')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' VW_DOCS_RECEIPT.*,'
      ' (SELECT CASE WHEN R.ECC_TRANS_ID IS NOT NULL OR D.DEVICE_TYPE = 1'
      '   THEN '#39'Casa ECC online'#39' ELSE '#39'MCC Tremol'#39' END'
      '  FROM TDB_DOCS_RECEIPT R LEFT JOIN FP_DEVICES D ON D.FP_ID = R.FP_ID'
      '  WHERE R.DOCID = VW_DOCS_RECEIPT.DOCID AND R.NUMAR_BON = VW_DOCS_RECEIPT.NUMAR_BON) AS APARAT,'
      ' (SELECT R.ECC_TRANS_ID FROM TDB_DOCS_RECEIPT R'
      '  WHERE R.DOCID = VW_DOCS_RECEIPT.DOCID AND R.NUMAR_BON = VW_DOCS_RECEIPT.NUMAR_BON) AS ECC_TRANS_ID,'
      ' (SELECT E.MEV_LINK FROM TDB_DOCS_RECEIPT R'
      '  JOIN TFP_ECC_TRANSACTION E ON E.TRANS_ID = R.ECC_TRANS_ID'
      '  WHERE R.DOCID = VW_DOCS_RECEIPT.DOCID AND R.NUMAR_BON = VW_DOCS_RECEIPT.NUMAR_BON) AS MEV_LINK'
      'FROM VW_DOCS_RECEIPT')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    Options.DetailDelay = 50
    Left = 812
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceReceipt: TIBCDataSource
    DataSet = IBCQueryReceipt
    Left = 808
    Top = 73
  end
  object cxGridPopupMenuDocs: TcxGridPopupMenu
    Grid = cxGridSF
    PopupMenus = <
      item
        GridView = cxGridSFTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenu
      end>
    Left = 132
    Top = 72
  end
  object IBCQueryJurnalKit: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_JURNAL'
      
        '  (DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLECT_ID' +
        ', GOODSCOMPLECT_NAME, GOODSID, GOODS_NAME, '
      
        '   GOODS_TYPE_ID, UMID, UM_NAME, QTY, PRICE, SUMA, SUMAVAT, WARR' +
        'ANTY, STOCK_QTY, COST, '
      '   FLG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, :GOODSCOMPL' +
        'ECT_ID, :GOODSCOMPLECT_NAME, :GOODSID, :GOODS_NAME, '
      
        '   :GOODS_TYPE_ID, :UMID, :UM_NAME, :QTY, :PRICE, :SUMA, :SUMAVA' +
        'T, :WARRANTY, :STOCK_QTY, :COST, '
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
      
        '  DOCID = :DOCID, DTDEP = :DTDEP, DTDEP_NAME = :DTDEP_NAME, CTDE' +
        'P = :CTDEP, CTDEP_NAME = :CTDEP_NAME, '
      
        '  GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID, GOODSCOMPLECT_NAME = :GO' +
        'ODSCOMPLECT_NAME, GOODSID = :GOODSID, '
      
        '  GOODS_NAME = :GOODS_NAME, GOODS_TYPE_ID = :GOODS_TYPE_ID, UMID' +
        ' = :UMID, UM_NAME = :UM_NAME, '
      
        '  QTY = :QTY, PRICE = :PRICE, SUMA = :SUMA, SUMAVAT = :SUMAVAT, ' +
        'WARRANTY = :WARRANTY, STOCK_QTY = :STOCK_QTY, '
      
        '  COST = :COST, FLG_ACTIVE = :FLG_ACTIVE, FLG_ACNT = :FLG_ACNT, ' +
        'FLG_READY = :FLG_READY, FLG_DELETE = :FLG_DELETE'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLRefresh.Strings = (
      'SELECT '
      '* '
      'FROM '
      ' VW_TDB_JURNAL'
      'WHERE'
      ' DOCID = :DOCID AND '
      ' DTDEP = :DTDEP AND '
      ' CTDEP = :CTDEP AND '
      ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID AND '
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
      ' *'
      'FROM'
      ' VW_TDB_JURNAL')
    MasterFields = 'DOCID;GOODSID'
    DetailFields = 'DOCID;GOODSCOMPLECT_ID'
    MasterSource = dmDB.IBCDataSourceJurnal
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 50
    Left = 604
    Top = 124
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnalKit: TIBCDataSource
    DataSet = IBCQueryJurnalKit
    OnStateChange = IBCDataSourceJurnalKitStateChange
    Left = 604
    Top = 76
  end
  object dxBarPopupMenuGoods: TdxBarPopupMenu
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
    Left = 43
    Top = 135
    PixelsPerInch = 96
  end
  object cxGridPopupMenuGoods: TcxGridPopupMenu
    Grid = cxGridComponents
    PopupMenus = <
      item
        GridView = cxGridComponentsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuGoods
      end>
    Left = 130
    Top = 136
  end
  object IBCDSDelivery: TIBCDataSource
    DataSet = IBCQueryDelivery
    OnStateChange = IBCDSDeliveryStateChange
    Left = 708
    Top = 77
  end
  object IBCQueryDelivery: TIBCQuery
    KeyFields = 'DOCID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS_DELIVERY'
      
        '  (DOCID, COURIERID, COURIER_NAME, DELIVERY_ADDRESS, DELIVERY_TI' +
        'ME, DELIVERY_DATE, FLG_CASHONDELIVERY, FLG_INVOICE_ONDELIVERY, F' +
        'LG_POS_TERMINAL, FLG_CREDIT, TRANSMIS_CURIER, AWB, DRIVERID, DRI' +
        'VER_NAME, DISTRICTID, DISTRICT_NAME, CITYID, CITY_NAME, COMMENTS' +
        ')'
      'VALUES'
      
        '  (:DOCID, :COURIERID, :COURIER_NAME, :DELIVERY_ADDRESS, :DELIVE' +
        'RY_TIME, :DELIVERY_DATE, :FLG_CASHONDELIVERY, :FLG_INVOICE_ONDEL' +
        'IVERY, :FLG_POS_TERMINAL, :FLG_CREDIT, :TRANSMIS_CURIER, :AWB, :' +
        'DRIVERID, :DRIVER_NAME, :DISTRICTID, :DISTRICT_NAME, :CITYID, :C' +
        'ITY_NAME, :COMMENTS)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DOCS_DELIVERY'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DOCS_DELIVERY'
      'SET'
      
        '  DOCID = :DOCID, COURIERID = :COURIERID, COURIER_NAME = :COURIE' +
        'R_NAME, DELIVERY_ADDRESS = :DELIVERY_ADDRESS, DELIVERY_TIME = :D' +
        'ELIVERY_TIME, DELIVERY_DATE = :DELIVERY_DATE, FLG_CASHONDELIVERY' +
        ' = :FLG_CASHONDELIVERY, FLG_INVOICE_ONDELIVERY = :FLG_INVOICE_ON' +
        'DELIVERY, FLG_POS_TERMINAL = :FLG_POS_TERMINAL, FLG_CREDIT = :FL' +
        'G_CREDIT, TRANSMIS_CURIER = :TRANSMIS_CURIER, AWB = :AWB, DRIVER' +
        'ID = :DRIVERID, DRIVER_NAME = :DRIVER_NAME, DISTRICTID = :DISTRI' +
        'CTID, DISTRICT_NAME = :DISTRICT_NAME, CITYID = :CITYID, CITY_NAM' +
        'E = :CITY_NAME, COMMENTS = :COMMENTS'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, COURIERID, COURIER_NAME, DELIVERY_ADDRESS, DELIVER' +
        'Y_TIME, DELIVERY_DATE, FLG_CASHONDELIVERY, FLG_INVOICE_ONDELIVER' +
        'Y, FLG_POS_TERMINAL, FLG_CREDIT, TRANSMIS_CURIER, AWB, DRIVERID,' +
        ' DRIVER_NAME, DISTRICTID, DISTRICT_NAME, CITYID, CITY_NAME, COMM' +
        'ENTS FROM VW_TDB_DOCS_DELIVERY'
      'WHERE'
      '  DOCID = :DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_DELIVERY'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_DOCS_DELIVERY'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select *'
      'from VW_TDB_DOCS_DELIVERY DD  ')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    Left = 708
    Top = 121
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCQuerySysS: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from SP_GET_SYSS_LIST(:parentid)'
      'order by title')
    Left = 448
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'parentid'
        Value = nil
      end>
  end
  object IBCDataSourceSysS: TIBCDataSource
    DataSet = IBCQuerySysS
    Left = 368
    Top = 208
  end
  object IBCQueryCities: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_syss where parentid=2 and value_int = :cityid')
    Left = 408
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cityid'
        Value = nil
      end>
  end
  object IBCDataSourceCities: TIBCDataSource
    DataSet = IBCQueryCities
    Left = 296
    Top = 304
  end
end
