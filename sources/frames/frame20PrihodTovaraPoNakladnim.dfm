inherited frame20PrihotTovaraPoNakladnim: Tframe20PrihotTovaraPoNakladnim
  Width = 748
  Height = 461
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 748
  ExplicitHeight = 461
  object cxGridPTN: TcxGrid
    Left = 0
    Top = 0
    Width = 748
    Height = 191
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
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
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
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
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
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
      object cxGridPTN_CREATED_DATE: TcxGridDBColumn
        Caption = 'Creat la'
        DataBinding.FieldName = 'created_date'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taRightJustify
        MinWidth = 16
        Width = 80
      end
      object cxGridPTN_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridPTN_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridPTN_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 16
        Width = 54
      end
      object cxGridPTN_CT_NAME: TcxGridDBColumn
        Caption = 'Funizor'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 16
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 106
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
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
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
        Caption = 'Rata USD'
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
        Width = 54
      end
      object cxGridPTN_SC2_NAME: TcxGridDBColumn
        AlternateCaption = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Caption = 'Analitica'
        DataBinding.FieldName = 'SC2_NAME'
        MinWidth = 16
        Width = 42
      end
      object cxGridPTN_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridPTN_FLG_EXPORTED: TcxGridDBColumn
        AlternateCaption = 'Exported'
        Caption = 'Exp'
        DataBinding.FieldName = 'FLG_EXPORTED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridPTN_HasFilesScanned: TcxGridDBColumn
        Caption = 'Scan'
        DataBinding.FieldName = 'HasDoc_Attached'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        MinWidth = 26
        Options.HorzSizing = False
        Width = 26
      end
      object cxGridPTNTable_PARENTDOCID: TcxGridDBColumn
        Caption = 'P.Doc'
        DataBinding.FieldName = 'PARENTDOCID'
        MinWidth = 16
      end
    end
    object cxGridPTNLevel: TcxGridLevel
      GridView = cxGridPTNTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 191
    Width = 748
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
    Control = cxPageControlDetails
  end
  object cxPageControlDetails: TcxPageControl
    Left = 0
    Top = 199
    Width = 748
    Height = 262
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 2
    TabStop = False
    Properties.ActivePage = tbsGoods
    Properties.CustomButtons.Buttons = <>
    Properties.TabPosition = tpBottom
    ClientRectBottom = 236
    ClientRectLeft = 4
    ClientRectRight = 744
    ClientRectTop = 4
    object tbsGoods: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Produse si servicii (&1)'
      object cxGridComponents: TcxGrid
        Left = 0
        Top = 30
        Width = 740
        Height = 202
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
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
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ShowEditButtons = gsebForFocusedRecord
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Footer = dmAdditions.cxStyle_GridHeader
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
            Caption = 'Depozit'
            DataBinding.FieldName = 'DTDEP_NAME'
            MinWidth = 112
            Options.Editing = False
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 112
          end
          object cxGridDBCol_GOODSID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GOODSID'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 56
            Options.Editing = False
            Options.ShowEditButtons = isebNever
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
            Options.Editing = False
            Options.Focusing = False
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Options.Moving = False
            VisibleForCustomization = False
            Width = 21
            IsCaptionAssigned = True
          end
          object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
            Caption = 'Produs'
            DataBinding.FieldName = 'GOODS_NAME'
            MinWidth = 16
            Options.Editing = False
            Options.ShowEditButtons = isebNever
            Options.Moving = False
            Width = 160
          end
          object cxGridDBCol_QTY: TcxGridDBColumn
            Caption = 'Cant'
            DataBinding.FieldName = 'QTY'
            PropertiesClassName = 'TcxCalcEditProperties'
            OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.Editing = False
            Options.Focusing = False
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridDBCol_UM_NAME: TcxGridDBColumn
            Caption = 'UM'
            DataBinding.FieldName = 'UM_NAME'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 32
            Options.Editing = False
            Options.ShowEditButtons = isebNever
            Options.Grouping = False
            Options.HorzSizing = False
            Options.Sorting = False
            Width = 32
          end
          object cxGridComponents_PRICE_ACNT_LOW_BOUND: TcxGridDBColumn
            AlternateCaption = #1053#1080#1078#1085#1080#1081' '#1087#1086#1088#1086#1075' '#1091#1095#1077#1090#1085#1086#1081' '#1094#1077#1085#1099
            Caption = #1053#1055
            DataBinding.FieldName = 'PRICE_ACNT_LOW_BOUND'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.HorzSizing = False
            Styles.Content = dmAdditions.cxStyle_DocInSpector_Parent
            Width = 48
          end
          object cxGridDBCol_PRICE: TcxGridDBColumn
            Caption = 'Pret'
            DataBinding.FieldName = 'PRICE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 64
            Options.Editing = False
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 64
          end
          object cxGridComponents_PRICE_ACNT_HIGH_BOUND: TcxGridDBColumn
            AlternateCaption = #1042#1077#1088#1093#1085#1080#1081' '#1087#1086#1088#1086#1075' '#1091#1095#1077#1090#1085#1086#1081' '#1094#1077#1085#1099
            Caption = #1042#1055
            DataBinding.FieldName = 'PRICE_ACNT_HIGH_BOUND'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.HorzSizing = False
            Styles.Content = dmAdditions.cxStyle_DocInSpector_Parent
            Width = 48
          end
          object cxGridDBCol_SUMA: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 64
            Options.Editing = False
            Options.ShowEditButtons = isebNever
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
            Options.Editing = False
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 64
          end
          object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
            Caption = 'Act'
            DataBinding.FieldName = 'FLG_ACTIVE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 32
            Options.Editing = False
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 32
          end
          object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
            Caption = 'Sold'
            DataBinding.FieldName = 'STOCK_QTY'
            PropertiesClassName = 'TcxCalcEditProperties'
            OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.Editing = False
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
            AlternateCaption = 'Cod in facturi'
            Caption = 'Cntb'
            DataBinding.FieldName = 'GOODS_ACNT_ID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 48
            Options.Editing = False
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 48
          end
          object cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn
            Caption = 'Den. facturi'
            DataBinding.FieldName = 'GOODS_NAMEACNT'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086' '#1085#1072#1082#1083#1072#1076#1085#1099#1084
                Kind = bkEllipsis
              end>
            Properties.ClearKey = 16430
            Properties.ViewStyle = vsHideCursor
            Properties.OnButtonClick = cxGridComponents_GOODS_NAMEACNTPropertiesButtonClick
            MinWidth = 40
            Width = 56
          end
          object cxGridComponents_UMID: TcxGridDBColumn
            DataBinding.FieldName = 'UMID'
            Visible = False
            MinWidth = 16
            Options.Editing = False
            Options.ShowEditButtons = isebNever
            VisibleForCustomization = False
          end
          object cxGridComponents_ACNT_PRICE: TcxGridDBColumn
            Caption = 'Pret evidenta'
            DataBinding.FieldName = 'ACNT_PRICE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 64
            Options.HorzSizing = False
            Styles.Content = dmAdditions.cxStyle_DocInSpector_CurrDoc
            Width = 64
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridComponentsTable
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 740
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
    object tbsInvoice: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Facturi (&2)'
      ImageIndex = 1
      object cxGridInvoice: TcxGrid
        Left = 0
        Top = 30
        Width = 740
        Height = 202
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = True
        LookAndFeel.SkinName = ''
        object cxGridInvoiceTable: TcxGridDBTableView
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
          OnFocusedRecordChanged = cxGridInvoiceTableFocusedRecordChanged
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
            Options.Focusing = False
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 19
            IsCaptionAssigned = True
          end
          object cxGridInvoiceTable_FACTURANO: TcxGridDBColumn
            Caption = 'Serie si numar factura'
            DataBinding.FieldName = 'FACTURANO'
            MinWidth = 128
            Options.HorzSizing = False
            Width = 128
          end
          object cxGridInvoiceTable_DATA_ELIBERARII: TcxGridDBColumn
            Caption = 'Data eliberarii'
            DataBinding.FieldName = 'DATA_ELIBERARII'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.ShowTime = False
            MinWidth = 128
            Options.HorzSizing = False
            Width = 128
          end
          object cxGridInvoiceTable_USERID_NAME: TcxGridDBColumn
            Caption = 'Utilizator'
            DataBinding.FieldName = 'USERID_NAME'
            MinWidth = 16
            Width = 160
          end
          object cxGridInvoiceTable_REDIRIJARI: TcxGridDBColumn
            Caption = 'Redirijari'
            DataBinding.FieldName = 'REDIRIJARI'
            MinWidth = 16
          end
        end
        object cxGridInvoiceLevel: TcxGridLevel
          GridView = cxGridInvoiceTable
        end
      end
      object dxBarDockControlInvoices: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 740
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
    object tsScans: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Documente scanate (&3)'
      ImageIndex = 2
      object cxGridFiles: TcxGrid
        Left = 0
        Top = 30
        Width = 740
        Height = 202
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 1
        object cxGridFilesTable: TcxGridDBTableView
          OnFocusedRecordChanged = cxGridFilesTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceFiles
          DataController.KeyFieldNames = 'ATTID'
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridFiles_FILENAME: TcxGridDBColumn
            Caption = 'File'
            DataBinding.FieldName = 'FILENAME'
            MinWidth = 16
          end
          object cxGridFiles_FILESIZE: TcxGridDBColumn
            Caption = 'Marime'
            DataBinding.FieldName = 'FILESIZE'
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
        end
        object cxGridFilesLevel: TcxGridLevel
          GridView = cxGridFilesTable
        end
      end
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 740
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
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Toolbar'
      'PopupMenu'
      #1060#1072#1081#1083#1099' '#1076#1083#1103' '#1089#1082#1072#1085#1072)
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
    Left = 32
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
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBarInvoice: TdxBar
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
      FloatLeft = 1133
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbInvoiceNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbInvoiceEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbInvoiceDelete'
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
      Caption = #1060#1072#1081#1083#1099
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 374
      FloatTop = 468
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbAttachFileNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAttachFileModify'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAttachFileRemove'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAttachFileSaveAs'
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
    object bbImportRashod: TdxBarButton
      Caption = #1048#1084#1087#1086#1088#1090' '#1080#1079' '#1055#1088#1080#1093#1086#1076' '#1090#1086#1074#1072#1088#1072' ('#1053#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090')'
      Category = 0
      Hint = #1048#1084#1087#1086#1088#1090' '#1080#1079' '#1055#1088#1080#1093#1086#1076' '#1090#1086#1074#1072#1088#1072' ('#1053#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090')'
      Visible = ivAlways
      OnClick = bbImportRashodClick
    end
    object bbDocComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'...'
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbInvoiceNew: TdxBarButton
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Hint = #1053#1086#1074#1072#1103
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbInvoiceNewClick
    end
    object bbInvoiceEdit: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbInvoiceEditClick
    end
    object bbInvoiceDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbInvoiceDeleteClick
    end
    object dxBarButton1: TdxBarButton
      Caption = #1044#1086#1083#1075#1080' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072'...'
      Category = 0
      Hint = #1044#1086#1083#1075#1080' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
      Visible = ivAlways
      ShortCut = 16452
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = #1048#1084#1087#1086#1088#1090' '#1080#1079' '#1055#1088#1080#1093#1086#1076' '#1058#1086#1074#1072#1088#1072' (Update)'
      Category = 0
      Hint = #1048#1084#1087#1086#1088#1090' '#1080#1079' '#1055#1088#1080#1093#1086#1076' '#1058#1086#1074#1072#1088#1072' (Update)'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = #1048#1084#1087#1086#1088#1090' ('#1079#1072#1082#1088#1099#1090#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1082#1086#1084#1080#1089#1080#1102')'
      Category = 0
      Hint = #1048#1084#1087#1086#1088#1090' ('#1079#1072#1082#1088#1099#1090#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1082#1086#1084#1080#1089#1080#1102')'
      Visible = ivAlways
      OnClick = dxBarButton3Click
    end
    object dxBarButton4: TdxBarButton
      Caption = #1048#1084#1087#1086#1088#1090' ('#1055#1088#1080#1085#1103#1090#1080#1077' '#1074' '#1073#1072#1083#1072#1085#1089' '#1089' '#1082#1086#1084#1080#1089#1080#1080')'
      Category = 0
      Hint = #1048#1084#1087#1086#1088#1090' ('#1055#1088#1080#1085#1103#1090#1080#1077' '#1074' '#1073#1072#1083#1072#1085#1089' '#1089' '#1082#1086#1084#1080#1089#1080#1080')'
      Visible = ivAlways
      OnClick = dxBarButton4Click
    end
    object bbAttachFileModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbAttachFileModifyClick
    end
    object dxBarButton5: TdxBarButton
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1092#1083#1072#1075' "'#1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1085#1085#1099#1081'"'
      Category = 0
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1092#1083#1072#1075' "'#1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1085#1085#1099#1081'"'
      Visible = ivAlways
      OnClick = dxBarButton5Click
    end
    object bbActionPlatejnoePorucenie: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' "'#1041#1072#1085#1082#1086#1074#1089#1082#1086#1077' '#1087#1083#1072#1090#1077#1078#1085#1086#1077' '#1087#1086#1088#1091#1095#1077#1085#1080#1077'"...'
      Category = 1
      Hint = #1057#1086#1079#1076#1072#1090#1100' "'#1041#1072#1085#1082#1086#1074#1089#1082#1086#1077' '#1087#1083#1072#1090#1077#1078#1085#1086#1077' '#1087#1086#1088#1091#1095#1077#1085#1080#1077'"'
      Visible = ivAlways
      OnClick = bbActionPlatejnoePorucenieClick
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
    object bbAttachFileNew: TdxBarButton
      Caption = 'Adauga'
      Category = 2
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      PaintStyle = psCaptionGlyph
      OnClick = bbAttachFileNewClick
    end
    object bbAttachFileRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      PaintStyle = psCaptionGlyph
      ShortCut = 16430
      OnClick = bbAttachFileRemoveClick
    end
    object bbAttachFileSaveAs: TdxBarButton
      Caption = 'Salveaza...'
      Category = 2
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
      PaintStyle = psCaptionGlyph
      OnClick = bbAttachFileSaveAsClick
    end
  end
  object dxPopupMenuPTN: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbActionPlatejnoePorucenie'
      end
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbActionCloseDoc'
      end
      item
        Visible = True
        ItemName = 'bbActionOpenDoc'
      end
      item
        Visible = True
        ItemName = 'dxBarButton5'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbImportRashod'
      end
      item
        Visible = True
        ItemName = 'dxBarButton2'
      end
      item
        Visible = True
        ItemName = 'dxBarButton3'
      end
      item
        Visible = True
        ItemName = 'dxBarButton4'
      end>
    ItemOptions.ShowDescriptions = False
    ItemOptions.Size = misNormal
    UseOwnFont = False
    Left = 265
    Top = 84
    PixelsPerInch = 96
  end
  object cxGridPopupMenuDOCS: TcxGridPopupMenu
    Grid = cxGridPTN
    PopupMenus = <
      item
        GridView = cxGridPTNTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxPopupMenuPTN
      end
      item
        GridView = cxGridPTNTable
        HitTypes = [gvhtNone]
        Index = 1
        PopupMenu = dxBarPopupMenuPTNUnselected
      end>
    Left = 124
    Top = 84
  end
  object IBCQueryINVOICES: TIBCQuery
    KeyFields = 'INVOICEID'
    KeyGenerator = 'SQ_TDB_INVOICES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_INVOICES'
      '  (DOCID, INVOICEID, FACTURANO, DATA_ELIBERARII)'
      'VALUES'
      '  (:DOCID, :INVOICEID, :FACTURANO, :DATA_ELIBERARII)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_INVOICES'
      'WHERE'
      '  INVOICEID = :Old_INVOICEID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_INVOICES'
      'SET'
      '  DOCID = :DOCID,'
      '  INVOICEID = :INVOICEID, '
      '  FACTURANO = :FACTURANO, '
      '  DATA_ELIBERARII = :DATA_ELIBERARII'
      'WHERE'
      '  DOCID = :Old_DOCID AND INVOICEID = :Old_INVOICEID')
    SQLRefresh.Strings = (
      'SELECT '
      ' *'
      'FROM '
      ' VW_TDB_INVOICES'
      'WHERE'
      ' DOCID = :DOCID AND INVOICEID = :INVOICEID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_INVOICES'
      'WHERE'
      'DOCID = :Old_DOCID AND INVOICEID = :Old_INVOICEID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_INVOICES')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 50
    Left = 260
    Top = 436
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceINVOICES: TIBCDataSource
    DataSet = IBCQueryINVOICES
    Left = 260
    Top = 372
  end
  object dxBarPopupMenuPTNUnselected: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbImportRashod'
      end
      item
        Visible = True
        ItemName = 'dxBarButton3'
      end
      item
        Visible = True
        ItemName = 'dxBarButton4'
      end>
    UseOwnFont = False
    Left = 420
    Top = 80
    PixelsPerInch = 96
  end
  object IBCQueryFiles: TIBCQuery
    KeyFields = 'ATTID'
    KeyGenerator = 'SQ_TDB_DOCS_ATTACHMENTS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_DOCS_ATTACHMENTS'
      '  (ATTID, DOCID, FILENAME, FILESIZE)'
      'VALUES'
      '  (:ATTID, :DOCID, :FILENAME, :FILESIZE)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_DOCS_ATTACHMENTS'
      'WHERE'
      '  ATTID = :Old_ATTID')
    SQLUpdate.Strings = (
      'UPDATE TDB_DOCS_ATTACHMENTS'
      'SET'
      '  ATTID = :ATTID, '
      '  DOCID = :DOCID, '
      '  FILENAME = :FILENAME, '
      '  FILESIZE = :FILESIZE'
      'WHERE'
      '  ATTID = :Old_ATTID')
    SQLRefresh.Strings = (
      'SELECT '
      '*'
      'FROM VW_TDB_DOCS_ATTACHMENTS'
      'WHERE'
      '  ATTID = :ATTID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_ATTACHMENTS'
      'WHERE'
      'ATTID = :Old_ATTID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      '*'
      'FROM VW_TDB_DOCS_ATTACHMENTS')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 50
    Left = 120
    Top = 164
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceFiles: TIBCDataSource
    DataSet = IBCQueryFiles
    Left = 120
    Top = 216
  end
end
