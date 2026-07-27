inherited frame59TTN: Tframe59TTN
  Font.Height = -15
  PixelsPerInch = 120
  object cxGridSF: TcxGrid
    Left = 0
    Top = 0
    Width = 986
    Height = 329
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridSFTable: TcxGridDBTableView
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
      object cxGridSF_FLG_CLOSED: TcxGridDBColumn
        Caption = #1047#1072#1082#1088#1099#1090
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridSFT_DOCID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridSF_CREATED_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
        DataBinding.FieldName = 'CREATED_DATE'
        OnGetDisplayText = cxGridSF_CREATED_DATEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridSFT_DATA: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridSFT_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridSFT_DTDEP_NAME: TcxGridDBColumn
        Caption = #1057#1082#1083#1072#1076
        DataBinding.FieldName = 'DTDEP_NAME'
        Width = 100
      end
      object cxGridSFT_CT_NAME: TcxGridDBColumn
        Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
        DataBinding.FieldName = 'CT_NAME'
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 200
      end
      object cxGridSFT_SUMA: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridSFT_CURRENCY_NAME: TcxGridDBColumn
        Caption = #1042#1072#1083#1102#1090#1072
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridSFT_VAT: TcxGridDBColumn
        Caption = #1053#1044#1057
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 60
      end
      object cxGridSFT_RATE: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' '#1044#1086#1082'.'
        DataBinding.FieldName = 'RATE'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridSF_RATEUSD: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridSFT_PARENTDOCID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridSF_FLG_ACNT: TcxGridDBColumn
        Caption = #1041#1091#1093#1075
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridSFT_CREATED_BY_NAME: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 100
      end
      object cxGridSF_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridSF_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridSF_SC2_NAME: TcxGridDBColumn
        Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072
        DataBinding.FieldName = 'SC2_NAME'
        Width = 100
      end
    end
    object cxGridSFLevel: TcxGridLevel
      GridView = cxGridSFTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 329
    Width = 986
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 300
    Control = cxPageControl
  end
  object cxPageControl: TcxPageControl
    Left = 0
    Top = 339
    Width = 986
    Height = 329
    Align = alBottom
    TabOrder = 0
    TabStop = False
    Properties.ActivePage = tbsSborkaComplect
    Properties.CustomButtons.Buttons = <>
    Properties.TabPosition = tpBottom
    ClientRectBottom = 297
    ClientRectLeft = 4
    ClientRectRight = 982
    ClientRectTop = 4
    object tbsGoods: TcxTabSheet
      Caption = '&1. '#1058#1086#1074#1072#1088#1099
      ImageIndex = 0
      ExplicitHeight = 296
      object dxBarDockControlGoods: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 978
        Height = 34
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridComponents: TcxGrid
        Left = 0
        Top = 34
        Width = 978
        Height = 259
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = True
        LookAndFeel.SkinName = ''
        ExplicitTop = 30
        ExplicitWidth = 443
        ExplicitHeight = 269
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
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.CellEndEllipsis = True
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
          object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
            Caption = #1057#1082#1083#1072#1076
            DataBinding.FieldName = 'DTDEP_NAME'
            MinWidth = 140
            Options.HorzSizing = False
            Width = 140
          end
          object cxGridDBCol_GOODSID: TcxGridDBColumn
            Caption = #1050#1086#1076
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
            Properties.DefaultImageIndex = 12
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 12
              end
              item
                ImageIndex = 13
                Value = 4203
              end>
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
            Width = 200
          end
          object cxGridDBCol_QTY: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'QTY'
            PropertiesClassName = 'TcxCalcEditProperties'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.Focusing = False
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridDBCol_UM_NAME: TcxGridDBColumn
            Caption = #1045#1048
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
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'PRICE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
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
          object cxGridDBCol_SUMAVAT: TcxGridDBColumn
            Caption = #1053#1044#1057
            DataBinding.FieldName = 'SUMAVAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridDB_FLG_ACTIVE: TcxGridDBColumn
            Caption = #1040#1082#1090#1080#1074
            DataBinding.FieldName = 'FLG_ACTIVE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridDBCol_FLG_READY: TcxGridDBColumn
            Caption = #1043#1086#1090#1086#1074
            DataBinding.FieldName = 'FLG_READY'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridComponentsTableColumn1: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1073#1091#1093#1075
            DataBinding.FieldName = 'GOODS_ACNT_ID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridDBCol_GOODS_NAMEACNT: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086' '#1085#1072#1082#1083#1072#1076#1085#1099#1084
            DataBinding.FieldName = 'GOODS_NAMEACNT'
            Width = 100
          end
          object cxGridComponents_PRICE_COLUMN: TcxGridDBColumn
            Caption = #1050#1086#1083'. '#1094#1077#1085
            DataBinding.FieldName = 'PRICE_COLUMN'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridDBCol_GOODS_ACNT_ID: TcxGridDBColumn
            DataBinding.FieldName = 'GOODS_ACNT_ID'
            Visible = False
            VisibleForCustomization = False
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridComponentsTable
        end
      end
    end
    object tbsInvoices: TcxTabSheet
      Caption = '&2. '#1060#1072#1082#1090#1091#1088#1099
      ImageIndex = 1
      ExplicitHeight = 296
      object dxBarDockControlInvoices: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 978
        Height = 34
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridInvoice: TcxGrid
        Left = 0
        Top = 34
        Width = 978
        Height = 259
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = True
        LookAndFeel.SkinName = ''
        ExplicitTop = 30
        ExplicitWidth = 1018
        ExplicitHeight = 269
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
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.CellEndEllipsis = True
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
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridInvoiceTable_INVOICEID: TcxGridDBColumn
            AlternateCaption = 'InvoiceID'
            Caption = 'InvoiceID'
            DataBinding.FieldName = 'INVOICEID'
            Visible = False
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
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
            MinWidth = 24
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 24
            IsCaptionAssigned = True
          end
          object cxGridInvoiceTable_FACTURANO: TcxGridDBColumn
            Caption = #1053#1086#1084#1077#1088' '#1092#1072#1082#1090#1091#1088#1099
            DataBinding.FieldName = 'FACTURANO'
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridInvoiceTable_DATA_ELIBERARII: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080
            DataBinding.FieldName = 'DATA_ELIBERARII'
            MinWidth = 120
            Options.HorzSizing = False
            Width = 120
          end
          object cxGridInvoiceTable_DELEGAT: TcxGridDBColumn
            Caption = #1044#1077#1083#1077#1075#1072#1090
            DataBinding.FieldName = 'DELEGAT'
            Width = 100
          end
          object cxGridInvoiceTable_TRANSPORTATOR_NAME: TcxGridDBColumn
            Caption = #1055#1077#1088#1077#1074#1086#1079#1095#1080#1082
            DataBinding.FieldName = 'TRANSPORTATOR_NAME'
            Width = 100
          end
          object cxGridInvoiceTable_NRMATRICULARE: TcxGridDBColumn
            Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
            DataBinding.FieldName = 'NRMATRICULARE'
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridInvoiceTable_NRFOAIEDEPARCURS: TcxGridDBColumn
            Caption = #1055#1091#1090#1077#1074#1086#1081' '#1083#1080#1089#1090
            DataBinding.FieldName = 'NRFOAIEDEPARCURS'
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridInvoiceTable_PROCURA_NO: TcxGridDBColumn
            Caption = #1044#1086#1074#1077#1088#1077#1085#1086#1089#1090#1100
            DataBinding.FieldName = 'PROCURA_NO'
            MinWidth = 140
            Options.HorzSizing = False
            Width = 140
          end
          object cxGridInvoiceTable_FLG_CANCELED: TcxGridDBColumn
            Caption = #1040#1085#1091#1083#1080#1088#1086#1074#1072#1085#1085#1072#1103
            DataBinding.FieldName = 'FLG_CANCELED'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridInvoice_DOCUMENTE_ANEXATE: TcxGridDBColumn
            Caption = #1055#1088#1080#1083#1072#1075#1072#1077#1084#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
            DataBinding.FieldName = 'DOCUMENTE_ANEXATE'
            Width = 70
          end
        end
        object cxGridInvoiceLevel: TcxGridLevel
          GridView = cxGridInvoiceTable
        end
      end
    end
    object tbsSborkaComplect: TcxTabSheet
      Caption = '&4. '#1050#1086#1084#1087#1083#1077#1082#1090#1072#1094#1080#1103' '#1080#1079' '#1089#1073#1086#1088#1082#1080
      ImageIndex = 3
      ExplicitHeight = 296
      object dxBarDockSborkaComplect: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 978
        Height = 34
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridComplect: TcxGrid
        Left = 0
        Top = 34
        Width = 978
        Height = 259
        Align = alClient
        TabOrder = 1
        LookAndFeel.NativeStyle = True
        ExplicitHeight = 262
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
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridComplect_DTDEP_NAME: TcxGridDBColumn
            Caption = #1057#1082#1083#1072#1076
            DataBinding.FieldName = 'DTDEP_NAME'
            Visible = False
            MinWidth = 100
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 100
          end
          object cxGridComplect_GOODSID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'GOODSID'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
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
            MinWidth = 24
            Options.Editing = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.FilteringPopup = False
            Options.Grouping = False
            Options.HorzSizing = False
            Options.Moving = False
            Options.ShowCaption = False
            VisibleForCustomization = False
            Width = 24
            IsCaptionAssigned = True
          end
          object cxGridComplect_GOODS_NAME: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'GOODS_NAME'
            Width = 300
          end
          object cxGridComplect_QTY: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'QTY'
            PropertiesClassName = 'TcxCalcEditProperties'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.Focusing = False
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridComplect_UM_NAME: TcxGridDBColumn
            Caption = #1045#1048
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
          object cxGridComplect_PRICE: TcxGridDBColumn
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'PRICE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridComplect_SUMA: TcxGridDBColumn
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
          object cxGridComplect_SUMAVAT: TcxGridDBColumn
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
          object cxGridComplect_FLG_ACTIVE: TcxGridDBColumn
            AlternateCaption = #1040#1082#1090#1080#1074
            Caption = #1040
            DataBinding.FieldName = 'FLG_ACTIVE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 24
            Options.HorzSizing = False
            Width = 24
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
            MinWidth = 24
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 24
          end
          object cxGridComplect_FLG_ACNT: TcxGridDBColumn
            Caption = #1055#1041
            DataBinding.FieldName = 'FLG_ACNT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 50
          end
          object cxGridComplect_WARRANTY: TcxGridDBColumn
            Caption = #1043#1072#1088
            DataBinding.FieldName = 'WARRANTY'
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 40
          end
          object cxGridComplect_COST: TcxGridDBColumn
            Caption = #1050#1086#1089#1090
            DataBinding.FieldName = 'COST'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridComplect_CREATED_BY_NAME: TcxGridDBColumn
            Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
            DataBinding.FieldName = 'CREATED_BY_NAME'
            Visible = False
            MinWidth = 100
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 100
          end
          object cxGridComplect_GOODS_ACNT_ID: TcxGridDBColumn
            AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
            Caption = #1050#1086#1076' '#1073#1091#1093#1075
            DataBinding.FieldName = 'GOODS_ACNT_ID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridComplect_GOODS_NAMEACNT: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086' '#1085#1072#1082#1083#1072#1076#1085#1099#1084
            DataBinding.FieldName = 'GOODS_NAMEACNT'
            MinWidth = 50
            Width = 100
          end
          object cxGridComplect_UMID: TcxGridDBColumn
            DataBinding.FieldName = 'UMID'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridComplect_ACNT_QTY: TcxGridDBColumn
            AlternateCaption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
            Caption = #1050#1086#1083'-'#1074#1086' '#1073#1091#1093#1075
            DataBinding.FieldName = 'ACNT_QTY'
            PropertiesClassName = 'TcxCalcEditProperties'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
        end
        object cxGridComplectLevel: TcxGridLevel
          GridView = cxGridComplectTable
        end
      end
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 540
    Top = 160
    PixelsPerInch = 120
    object dxBarManagerBarGoods: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
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
          ItemName = 'bbSubBringGoods'
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
          BeginGroup = True
          Visible = True
          ItemName = 'bbPrintFE'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCancelInvoice'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteInvoice'
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
      DockControl = dxBarDockSborkaComplect
      DockedDockControl = dxBarDockSborkaComplect
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1214
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = False
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      Caption = #1057#1073#1086#1088#1082#1072
      CaptionButtons = <>
      DockControl = dxBarDockSborkaComplect
      DockedDockControl = dxBarDockSborkaComplect
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 945
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          BeginGroup = True
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
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddGoodsClick
    end
    object bbModifyGoods: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyGoodsClick
    end
    object bbDeleteGoods: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteGoodsClick
    end
    object bbCancelInvoice: TdxBarButton
      Caption = #1040#1085#1085#1091#1083#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1040#1085#1085#1091#1083#1080#1088#1086#1074#1072#1090#1100' '#1089#1095#1077#1090' '#1092#1072#1082#1090#1091#1088#1099
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbCancelInvoiceClick
    end
    object bbNewInvoice: TdxBarButton
      Caption = #1053#1086#1074#1072#1103' '#1089#1095#1077#1090' '#1092#1072#1082#1090#1091#1088#1072
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1089#1095#1077#1090' '#1092#1072#1082#1090#1091#1088#1072
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewInvoiceClick
    end
    object bbCloseInvoice: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbCloseInvoiceClick
    end
    object bbDeleteInvoice: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1095#1077#1090' '#1092#1072#1082#1090#1091#1088#1099
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteInvoiceClick
    end
    object bbGotoParentDoc: TdxBarButton
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1085#1072#1095#1072#1083#1100#1085#1086#1084#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Category = 0
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1085#1072#1095#1072#1083#1100#1085#1086#1084#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Visible = ivAlways
      OnClick = bbGotoParentDocClick
    end
    object bbOpenInvoice: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      OnClick = bbOpenInvoiceClick
    end
    object bbDocComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'...'
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbModifyInvoice: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1095#1077#1090' '#1092#1072#1082#1090#1091#1088#1099
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyInvoiceClick
    end
    object bbSubBringGoods: TdxBarSubItem
      Caption = #1055#1088#1080#1074#1077#1089#1090#1080' '#1090#1086#1074#1072#1088#1099
      Category = 0
      Visible = ivAlways
      ImageIndex = 12
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbBringGoodsFromParent'
        end>
    end
    object bbBringGoodsFromParent: TdxBarButton
      Caption = #1048#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1088#1086#1076#1080#1090#1077#1083#1103'...'
      Category = 0
      Hint = #1048#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1088#1086#1076#1080#1090#1077#1083#1103
      Visible = ivAlways
      OnClick = bbBringGoodsFromParentClick
    end
    object bbPrintSF_horiz: TdxBarButton
      Caption = #1055#1077#1095#1072#1090#1100' "Factura de Expeditie" ('#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1072#1103')...'
      Category = 0
      Hint = #1055#1077#1095#1072#1090#1100' "Factura de Expeditie" ('#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1072#1103')'
      Visible = ivAlways
      ImageIndex = 28
      OnClick = bbPrintSF_horizClick
    end
    object bbPrintSF_vert: TdxBarButton
      Caption = #1055#1077#1095#1072#1090#1100' "Factura de Expeditie" ('#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1072#1103')...'
      Category = 0
      Hint = #1055#1077#1095#1072#1090#1100' "Factura de Expeditie" ('#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1072#1103')'
      Visible = ivAlways
      ImageIndex = 28
      OnClick = bbPrintSF_horizClick
    end
    object bbPrintFE: TdxBarSubItem
      Caption = #1055#1077#1095#1072#1090#1100' "Factura de Expeditie"'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbPrintSF_horiz'
        end
        item
          Visible = True
          ItemName = 'bbPrintSF_vert'
        end>
    end
    object dxBarButton1: TdxBarButton
      Caption = #1055#1088#1080#1085#1077#1089#1090#1080' '#1090#1086#1074#1072#1088' '#1080#1079' '#1089#1073#1086#1088#1082#1080
      Category = 0
      Hint = #1055#1088#1080#1085#1077#1089#1090#1080' '#1090#1086#1074#1072#1088' '#1080#1079' '#1089#1073#1086#1088#1082#1080
      Visible = ivAlways
      ImageIndex = 84
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 90
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 91
      OnClick = dxBarButton3Click
    end
    object dxBarButton4: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 92
      OnClick = dxBarButton4Click
    end
    object dxBarButton5: TdxBarButton
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1089#1093#1086#1076#1085#1091#1102' '#1094#1077#1085#1091
      Category = 0
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1089#1093#1086#1076#1085#1091#1102' '#1094#1077#1085#1091
      Visible = ivAlways
      OnClick = dxBarButton5Click
    end
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseInvoice'
      end
      item
        Visible = True
        ItemName = 'bbOpenInvoice'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbPrintSF_horiz'
      end
      item
        Visible = True
        ItemName = 'bbPrintSF_vert'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGotoParentDoc'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuPopup
    Left = 296
    Top = 148
    PixelsPerInch = 120
  end
  object IBCQueryINVOICES: TIBCQuery
    KeyFields = 'INVOICEID'
    KeyGenerator = 'SQ_TDB_INVOICES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_INVOICES'
      
        '  (DOCID, INVOICEID, FACTURANO, DELEGAT, PROCURAID, TRANSPORTATO' +
        'R, NRMATRICULARE, '
      
        '   NRFOAIEDEPARCURS, DATA_ELIBERARII, USERID, FLG_CANCELED, DOCU' +
        'MENTE_ANEXATE)'
      'VALUES'
      
        '  (:DOCID, :INVOICEID, :FACTURANO, :DELEGAT, :PROCURAID, :TRANSP' +
        'ORTATOR, '
      
        '   :NRMATRICULARE, :NRFOAIEDEPARCURS, :DATA_ELIBERARII, :USERID,' +
        ' :FLG_CANCELED, :DOCUMENTE_ANEXATE)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_INVOICES'
      'WHERE'
      '  INVOICEID = :Old_INVOICEID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_INVOICES'
      'SET'
      '  DOCID = :DOCID, '
      '  INVOICEID = :INVOICEID, '
      '  FACTURANO = :FACTURANO, '
      '  DELEGAT = :DELEGAT, '
      '  PROCURAID = :PROCURAID, '
      '  TRANSPORTATOR = :TRANSPORTATOR, '
      '  NRMATRICULARE = :NRMATRICULARE, '
      '  NRFOAIEDEPARCURS = :NRFOAIEDEPARCURS, '
      '  DATA_ELIBERARII = :DATA_ELIBERARII, '
      '  USERID = :USERID, '
      '  FLG_CANCELED = :FLG_CANCELED,'
      '  DOCUMENTE_ANEXATE = :DOCUMENTE_ANEXATE'
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
    Left = 416
    Top = 512
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceINVOICES: TIBCDataSource
    DataSet = IBCQueryINVOICES
    Left = 416
    Top = 456
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
      ' *'
      'FROM '
      ' VW_DOCS_RECEIPT'
      'WHERE'
      ' DOCID = :DOCID AND NUMAR_BON = :NUMAR_BON')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' *'
      'FROM VW_DOCS_RECEIPT')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    Options.DetailDelay = 500
    Left = 576
    Top = 508
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceReceipt: TIBCDataSource
    DataSet = IBCQueryReceipt
    Left = 576
    Top = 452
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
    Left = 432
    Top = 100
  end
  object IBCQueryJurnalKit: TIBCQuery
    KeyFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
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
    Left = 688
    Top = 512
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
    Left = 688
    Top = 452
  end
end
