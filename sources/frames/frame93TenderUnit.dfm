inherited frame93Tender: Tframe93Tender
  Width = 631
  Height = 427
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 631
  ExplicitHeight = 427
  object cxGridBRK: TcxGrid
    Left = 0
    Top = 0
    Width = 631
    Height = 93
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridBRKDBTable: TcxGridDBTableView
      OnKeyDown = cxGridBRKDBTableKeyDown
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
      FindPanel.DisplayMode = fpdmManual
      FindPanel.UseExtendedSyntax = True
      OnCellDblClick = cxGridBRKDBTableCellDblClick
      OnCustomDrawCell = cxGridBRKDBTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      OptionsBehavior.CellHints = True
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
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridBRKDBTableColumn1: TcxGridDBColumn
        Caption = '...'
        DataBinding.FieldName = 'FLG_UPDATE_DATE'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = dmAdditions.cxImageDocs
        Properties.Items = <
          item
            ImageIndex = 1
            Value = '1'
          end>
        MinWidth = 19
        Options.Editing = False
        Options.Focusing = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.ShowCaption = False
        Options.Sorting = False
        Width = 19
      end
      object cxGridBRKDBTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridBRKDB_CREATED_DATE: TcxGridDBColumn
        Caption = 'Data crearii'
        DataBinding.FieldName = 'CREATED_DATE'
        MinWidth = 16
        SortIndex = 0
        SortOrder = soAscending
      end
      object cxGridBRKDBTableData: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridBRKDBTableDataGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridBRKDB_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 48
        Width = 80
      end
      object cxGridBRKDB_CT_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 112
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 112
      end
      object cxGridBRKDBTableSuma: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridBRKDB_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridBRKDBTableVAT: TcxGridDBColumn
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
      object cxGridBRKDBTableRate: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridBRKDBTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridBRKDB_RATEUSD: TcxGridDBColumn
        Caption = 'Rata $'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridBRK_FLG_ACNT: TcxGridDBColumn
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
      object cxGridBRKDB_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 64
        Width = 80
      end
      object cxGridBRKDB_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridBRKDB_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridBRK_FLG_CLOSED: TcxGridDBColumn
        DataBinding.FieldName = 'FLG_CLOSED'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridBRKDB_dtsc_name: TcxGridDBColumn
        Caption = 'subcont 1'
        DataBinding.FieldName = 'dtsc_name'
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridBRKDB_CTSC_NAME: TcxGridDBColumn
        Caption = 'subsconto 2'
        DataBinding.FieldName = 'ctsc_name'
        Visible = False
        MinWidth = 80
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 80
      end
      object cxGridBRKDB_STATE_NAME: TcxGridDBColumn
        Caption = 'Statut'
        DataBinding.FieldName = 'STATE_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 64
      end
      object cxGridBRKDBTableColumn2: TcxGridDBColumn
        Caption = 'doc.p.'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
      end
    end
    object cxGridBRKLevel: TcxGridLevel
      GridView = cxGridBRKDBTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 101
    Width = 631
    Height = 326
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object cxPageControlComplect: TcxPageControl
      Left = 0
      Top = 0
      Width = 631
      Height = 326
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Focusable = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Properties.ActivePage = tbsGoods
      Properties.CustomButtons.Buttons = <>
      Properties.TabPosition = tpBottom
      ClientRectBottom = 302
      ClientRectLeft = 4
      ClientRectRight = 627
      ClientRectTop = 4
      object tbsGoods: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Produse (&1)'
        ImageIndex = 0
        ExplicitLeft = 3
        ExplicitTop = 3
        ExplicitWidth = 625
        ExplicitHeight = 300
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 30
          Width = 623
          Height = 268
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          ExplicitTop = 27
          ExplicitWidth = 625
          ExplicitHeight = 273
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
            DataController.DataSource = IBCDataSourceTenderItems
            DataController.KeyFieldNames = 'UID'
            DataController.Summary.DefaultGroupSummaryItems = <
              item
                Format = '%d'
                Position = spFooter
              end>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                FieldName = 'QTY'
                Column = cxGridComponentsTableQTY
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'SUMA'
                Column = cxGridComponentsTableSUMA
              end>
            OptionsBehavior.IncSearch = True
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
            object cxGridComponentsTableUID: TcxGridDBColumn
              DataBinding.FieldName = 'UID'
              Visible = False
              MinWidth = 16
            end
            object cxGridComponentsTableDOCID: TcxGridDBColumn
              DataBinding.FieldName = 'DOCID'
              Visible = False
              MinWidth = 16
            end
            object cxGridComponentsTableCPV: TcxGridDBColumn
              DataBinding.FieldName = 'CPV'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 50
            end
            object cxGridComponentsTableDENUMIREA_BUNULUI: TcxGridDBColumn
              Caption = 'Denumirea bunului'
              DataBinding.FieldName = 'DENUMIREA_BUNULUI'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 114
            end
            object cxGridComponentsTableFDA_SPECIFICATION: TcxGridDBColumn
              Caption = 'FDA'
              DataBinding.FieldName = 'FDA_SPECIFICATION'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 158
            end
            object cxGridComponentsTableGOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 30
            end
            object cxGridComponentsTableGOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'GOODS_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 146
            end
            object cxGridComponentsTableCOUNTRY_NAME: TcxGridDBColumn
              Caption = 'Tara de origine'
              DataBinding.FieldName = 'COUNTRY_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 62
            end
            object cxGridComponentsTableMANUFACTURER: TcxGridDBColumn
              Caption = 'Producator'
              DataBinding.FieldName = 'MANUFACTURER'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 66
            end
            object cxGridComponentsTableWARANTY: TcxGridDBColumn
              Caption = 'Garantie'
              DataBinding.FieldName = 'WARANTY'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 53
            end
            object cxGridComponentsTableSTANDARD: TcxGridDBColumn
              Caption = 'Standarde'
              DataBinding.FieldName = 'STANDARD'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 50
            end
            object cxGridComponentsTableQTY: TcxGridDBColumn
              Caption = 'Cant'
              DataBinding.FieldName = 'QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 39
            end
            object cxGridComponentsTablePRICE: TcxGridDBColumn
              Caption = 'Pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCalcEditProperties'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 54
            end
            object cxGridComponentsTableSUMA: TcxGridDBColumn
              Caption = 'Suma'
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCalcEditProperties'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 59
            end
            object cxGridComponentsTableVAT: TcxGridDBColumn
              DataBinding.FieldName = 'VAT'
              Visible = False
              MinWidth = 16
            end
          end
          object cxGridLevel: TcxGridLevel
            GridView = cxGridComponentsTable
          end
        end
        object DockControlGoods: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 623
          Height = 30
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
          ExplicitWidth = 625
          ExplicitHeight = 34
        end
      end
      object tbsKitContent: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Complectatie (&2)'
        ImageIndex = 1
        ExplicitLeft = 3
        ExplicitTop = 3
        ExplicitWidth = 625
        ExplicitHeight = 300
        object cxGridComplect: TcxGrid
          Left = 0
          Top = 30
          Width = 623
          Height = 268
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          ExplicitTop = 27
          ExplicitWidth = 625
          ExplicitHeight = 273
          object cxGridComplectTable: TcxGridDBTableView
            OnKeyDown = cxGridComplectTableKeyDown
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
            OnCellDblClick = cxGridComplectTableCellDblClick
            OnCustomDrawCell = cxGridComplectTableCustomDrawCell
            DataController.DataSource = IBCDataSourceJurnalKit
            DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
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
                Kind = skSum
                Column = cxGridComplect_QTY
              end>
            OptionsBehavior.IncSearch = True
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
            object cxGridComplect_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 48
              Options.HorzSizing = False
              Width = 48
            end
            object cxGridComplect_IMG: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Items = <>
              MinWidth = 19
              Options.Editing = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.FilteringPopup = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.ShowCaption = False
              Width = 19
            end
            object cxGridComplect_FLG_SUPPLIER_PROMO: TcxGridDBColumn
              Caption = 'P'
              DataBinding.FieldName = 'FLG_SUPPLIER_PROMO'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.ilFlags
              Properties.Items = <
                item
                  Description = 'Promotie Furnizor'
                  ImageIndex = 3
                  Value = '1'
                end>
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 16
            end
            object cxGridComplect_GOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'GOODS_NAME'
              MinWidth = 16
              Width = 160
            end
            object cxGridComplect_QTY: TcxGridDBColumn
              Caption = 'Cant'
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
            object cxGridComplect_PRICE: TcxGridDBColumn
              Caption = 'Pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridComplect_SUMA: TcxGridDBColumn
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
            object cxGridComplect_SUMAVAT: TcxGridDBColumn
              Caption = 'TVA'
              DataBinding.FieldName = 'SUMAVAT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridComplect_FLG_ACNT: TcxGridDBColumn
              Caption = 'Cnt'
              DataBinding.FieldName = 'FLG_ACNT'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridComplect_WARRANTY: TcxGridDBColumn
              Caption = #1043#1072#1088
              DataBinding.FieldName = 'WARRANTY'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
            end
            object cxGridComplect_STOCK_QTY: TcxGridDBColumn
              Caption = 'Sold'
              DataBinding.FieldName = 'STOCK_QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridComplect_QTYGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
            end
            object cxGridComplect_FLG_ACTIVE: TcxGridDBColumn
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
            object cxGridComplect_FLG_READY: TcxGridDBColumn
              Caption = #1043#1086#1090#1086#1074
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              VisibleForCustomization = False
              Width = 32
            end
            object cxGridComplect_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = 'Cod factura'
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 48
              Options.HorzSizing = False
              Width = 48
            end
            object cxGridComplect_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = 'Denumirea factura'
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              MinWidth = 40
              Width = 56
            end
            object cxGridComplect_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
              MinWidth = 16
              VisibleForCustomization = False
            end
            object cxGridComplect_FLG_ADDON: TcxGridDBColumn
              Caption = '...'
              DataBinding.FieldName = 'FLG_FORCED_ADDON'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.ilFlags
              Properties.Items = <
                item
                  ImageIndex = 1
                  Value = 1
                end>
              MinWidth = 16
              Options.HorzSizing = False
              Width = 16
            end
          end
          object cxGridComplectLevel1: TcxGridLevel
            GridView = cxGridComplectTable
          end
        end
        object DockControlComplect: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 623
          Height = 30
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
          ExplicitWidth = 625
          ExplicitHeight = 34
        end
      end
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 93
    Width = 631
    Height = 8
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    DragThreshold = 2
    PositionAfterOpen = 24
    MinSize = 160
    Control = pnBottom
    ExplicitTop = 94
  end
  object dxBarManager: TdxBarManager
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default'
      'General'
      'Prices'
      'Tools'
      'PopupMenu'
      'inComplect')
    Categories.ItemsVisibles = (
      2
      2
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    SunkenBorder = True
    UseSystemFont = False
    Left = 32
    Top = 68
    PixelsPerInch = 96
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Goods'
      CaptionButtons = <>
      DockControl = DockControlGoods
      DockedDockControl = DockControlGoods
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1057
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
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
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbPriceColSelector'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Complect'
      CaptionButtons = <>
      DockControl = DockControlComplect
      DockedDockControl = DockControlComplect
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1057
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsComplectAdd'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsComplectEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsComplectDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbPriceColSelector'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbGoodsComplectAdd: TdxBarButton
      Caption = 'Adauga in complect'
      Category = 0
      Hint = 'Adauga in complect'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbGoodsComplectAddClick
    end
    object bbGoodsComplectEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbGoodsComplectEditClick
    end
    object bbGoodsComplectDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbGoodsComplectDeleteClick
    end
    object dxBarSubItem3: TdxBarSubItem
      Caption = 'Intrumente'
      Category = 0
      Visible = ivAlways
      ImageIndex = 81
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbAddFromKit'
        end
        item
          Visible = True
          ItemName = 'dxBarButton6'
        end
        item
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAddToQTYComplect'
        end
        item
          Visible = True
          ItemName = 'bbAddSumaToComplect'
        end>
    end
    object bbAddSumaToComplect: TdxBarButton
      Caption = 'Modifica suma...'
      Category = 0
      Hint = 'Modifica suma'
      Visible = ivAlways
      OnClick = bbAddSumaToComplectClick
    end
    object bbPriceCol6: TdxBarButton
      Tag = 6
      Caption = '6 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 0
      Hint = '6 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivAlways
      ShortCut = 16438
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol7: TdxBarButton
      Tag = 7
      Caption = '7 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 0
      Hint = '7 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivAlways
      ShortCut = 16439
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol0: TdxBarButton
      Caption = 'Pret intrare'
      Category = 0
      Hint = 'Pret intrare'
      Visible = ivAlways
      OnClick = bbPriceCol1Click
    end
    object bbMoveGoodsInComplect: TdxBarButton
      Caption = 'Transfera produsele in complect'
      Category = 0
      Hint = 'Transfera produsele in complect'
      Visible = ivAlways
      OnClick = bbMoveGoodsInComplectClick
    end
    object bbGoodsInfoCard: TdxBarButton
      Caption = 'Miscarea marfii...'
      Category = 0
      Hint = 'Miscarea marfii'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsInfoCardClick
    end
    object bbGoodsPrice: TdxBarButton
      Caption = 'Reevaluarea preturilor ...'
      Category = 0
      Hint = 'Reevaluarea preturilor '
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbGoodsPriceClick
    end
    object bbGoodsForeignCode: TdxBarButton
      Caption = 'Produsele de la furnizor...'
      Category = 0
      Hint = 'Produsele de la furnizor'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCodeClick
    end
    object bbKitGoodsInfoCard: TdxBarButton
      Caption = 'Miscarea marfii...'
      Category = 0
      Hint = 'Miscarea marfii'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbKitGoodsInfoCardClick
    end
    object bbKitGoodsPrice: TdxBarButton
      Caption = 'Reevaluarea preturilor la marfa...'
      Category = 0
      Hint = 'Reevaluarea preturilor la marfa'
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbKitGoodsPriceClick
    end
    object bbKitGoodsForeignCode: TdxBarButton
      Caption = 'Produse de la furnizor...'
      Category = 0
      Hint = 'Produse de la furnizor'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbKitGoodsForeignCodeClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Din Clipboard...'
      Category = 0
      Hint = 'Din Clipboard'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Tag = 9
      Caption = 'Grila de preturi a  clientului'
      Category = 0
      Hint = 'Grila de preturi a  clientului'
      Visible = ivAlways
      OnClick = bbPriceCol1Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Calcula Credit'
      Category = 0
      Hint = 'Calcula Credit'
      Visible = ivAlways
      ShortCut = 49228
      OnClick = dxBarButton3Click
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Reaminteste de contactat clientul...'
      Category = 0
      Hint = 'Reaminteste de contactat clientul'
      Visible = ivAlways
      ShortCut = 49234
      OnClick = dxBarButton4Click
    end
    object bbKitchenTemplate: TdxBarButton
      Caption = 'Bucatarie'
      Category = 0
      Hint = 'Bucatarie'
      Visible = ivAlways
      ShortCut = 16450
      OnClick = bbKitchenTemplateClick
    end
    object dxBarButton6: TdxBarButton
      Caption = 'Import din document...'
      Category = 0
      Hint = 'Import din document'
      Visible = ivAlways
    end
    object dxBarButton7: TdxBarButton
      Caption = 'Din alt document'
      Category = 0
      Hint = 'Din alt document'
      Visible = ivAlways
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Importa'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbAddFromKit'
        end
        item
          Visible = True
          ItemName = 'bbInsertFromTemplate'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end>
    end
    object dxBarButton9: TdxBarButton
      Caption = 'Paste from clipboard'
      Category = 0
      Hint = 'Paste from clipboard'
      Visible = ivAlways
      OnClick = dxBarButton9Click
    end
    object bbTVA0: TdxBarButton
      Caption = 'TVA 0%'
      Category = 0
      Hint = 'TVA 0%'
      Visible = ivAlways
      OnClick = bbTVA0Click
    end
    object dxBarButton10: TdxBarButton
      Caption = 'Importa din SpreadSheet'
      Category = 0
      Hint = 'Importa din SpreadSheet'
      Visible = ivAlways
      ShortCut = 16457
      OnClick = dxBarButton10Click
    end
    object bbCreateOffer: TdxBarButton
      Caption = 'Creaza oferta...'
      Category = 0
      Hint = 'Creaza oferta'
      Visible = ivAlways
      OnClick = bbCreateOfferClick
    end
    object bbGoodsNew: TdxBarButton
      Caption = 'Produs nou'
      Category = 1
      Hint = 'Produs nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbGoodsNewClick
    end
    object bbGoodsModify: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbGoodsModifyClick
    end
    object bbGoodsDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbGoodsDeleteClick
    end
    object bbPriceColSelector: TdxBarSubItem
      Caption = 'Preturi'
      Category = 2
      Visible = ivAlways
      ImageIndex = 49
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbPriceCol0'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbPriceCol1'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol2'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol3'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol4'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol5'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol6'
        end
        item
          Visible = True
          ItemName = 'bbPriceCol7'
        end>
    end
    object bbPriceCol1: TdxBarButton
      Tag = 1
      Caption = '1 grila'
      Category = 2
      Hint = '1 grila'
      Visible = ivAlways
      ShortCut = 16433
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol2: TdxBarButton
      Tag = 2
      Caption = '2 grila'
      Category = 2
      Hint = '2 grila'
      Visible = ivAlways
      ShortCut = 16434
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol3: TdxBarButton
      Tag = 3
      Caption = '3 grila'
      Category = 2
      Hint = '3 grila'
      Visible = ivAlways
      ShortCut = 16435
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol4: TdxBarButton
      Tag = 4
      Caption = '4 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 2
      Hint = '4 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivAlways
      ShortCut = 16436
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol5: TdxBarButton
      Tag = 5
      Caption = '5 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 2
      Hint = '5 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivAlways
      ShortCut = 16437
      OnClick = bbPriceCol1Click
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = 'Intrumente'
      Category = 3
      Visible = ivAlways
      ImageIndex = 81
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAddToQTY'
        end>
    end
    object bbAddFromKit: TdxBarButton
      Caption = 'Din complect'
      Category = 3
      Hint = 'Din complect'
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbAddFromKitClick
    end
    object bbInsertFromTemplate: TdxBarButton
      Caption = 'Din sablon'
      Category = 3
      Hint = 'Din sablon'
      Visible = ivAlways
      ShortCut = 32852
      OnClick = bbInsertFromTemplateClick
    end
    object bbCalcKit: TdxBarButton
      Caption = 'Calcul configuratie'
      Category = 3
      Hint = 'Calcul configuratie'
      Visible = ivAlways
      OnClick = bbCalcKitClick
    end
    object bbAddToQTY: TdxBarButton
      Caption = 'Modifica cantitatea...'
      Category = 3
      Hint = 'Modifica cantitatea'
      Visible = ivAlways
      OnClick = bbAddToQTYClick
    end
    object bbIncreaseSum: TdxBarButton
      Caption = 'Modifica suma...'
      Category = 3
      Hint = 'Modifica suma'
      Visible = ivAlways
      OnClick = bbIncreaseSumClick
    end
    object bbPopup_Menu2: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' "'#1056#1072#1089#1093#1086#1076#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102' '#1074' '#1089#1077#1088#1074#1080#1089'"...'
      Category = 4
      Hint = #1057#1086#1079#1076#1072#1090#1100' "'#1056#1072#1089#1093#1086#1076#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102' '#1074' '#1089#1077#1088#1074#1080#1089'"'
      Visible = ivAlways
      OnClick = bbPopup_Menu2Click
    end
    object bbAddToQTYComplect: TdxBarButton
      Caption = 'Modifica cantitatea'
      Category = 5
      Hint = 'Modifica cantitatea'
      Visible = ivAlways
      OnClick = bbAddToQTYComplectClick
    end
  end
  object IBCQueryJurnalKit: TIBCQuery
    UpdatingTable = 'VW_TDB_JURNAL'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_JURNAL'
      
        '  (DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLECT_ID' +
        ', GOODSCOMPLECT_NAME, GOODSID, GOODS_NAME, '
      
        '   GOODS_TYPE_ID, UMID, UM_NAME, QTY, PRICE, SUMA, SUMAVAT, WARR' +
        'ANTY, STOCK_QTY, COST, '
      '   FLG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, :GOODSCOMPL' +
        'ECT_ID, :GOODSCOMPLECT_NAME, :GOODSID, :GOODS_NAME, :GOODS_TYPE_' +
        'ID, :UMID, :UM_NAME, :QTY, :PRICE, :SUMA, :SUMAVAT, :WARRANTY, :' +
        'STOCK_QTY, :COST, :FLG_ACTIVE, :FLG_ACNT, :FLG_READY, :FLG_DELET' +
        'E)')
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
      ' VW_TDB_JURNAL.DOCID, '
      ' VW_TDB_JURNAL.DTDEP, '
      ' VW_TDB_JURNAL.DTDEP_NAME, '
      ' VW_TDB_JURNAL.CTDEP, '
      ' VW_TDB_JURNAL.CTDEP_NAME, '
      ' VW_TDB_JURNAL.GOODSCOMPLECT_ID, '
      ' VW_TDB_JURNAL.GOODSCOMPLECT_NAME, '
      ' VW_TDB_JURNAL.GOODSID, '
      ' VW_TDB_JURNAL.GOODS_NAME, '
      ' VW_TDB_JURNAL.GOODS_TYPE_ID, '
      ' VW_TDB_JURNAL.UMID, '
      ' VW_TDB_JURNAL.UM_NAME, '
      ' VW_TDB_JURNAL.QTY, '
      ' VW_TDB_JURNAL.PRICE, '
      ' VW_TDB_JURNAL.SUMA, '
      ' VW_TDB_JURNAL.SUMAVAT, '
      ' VW_TDB_JURNAL.WARRANTY, '
      ' VW_TDB_JURNAL.STOCK_QTY, '
      ' VW_TDB_JURNAL.COST, '
      ' VW_TDB_JURNAL.FLG_ACTIVE, '
      ' VW_TDB_JURNAL.FLG_ACNT, '
      ' VW_TDB_JURNAL.FLG_READY, '
      ' VW_TDB_JURNAL.FLG_DELETE'
      'FROM '
      ' VW_TDB_JURNAL'
      'WHERE'
      
        '  DOCID = :DOCID AND DTDEP = :DTDEP AND CTDEP = :CTDEP AND GOODS' +
        'COMPLECT_ID = :GOODSCOMPLECT_ID AND GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_JURNAL'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' GOODSCOMPLECT_ID<>-1')
    MasterFields = 'DOCID;DTDEP;CTDEP;GOODSID'
    DetailFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID'
    MasterSource = dmDB.IBCDataSourceJurnal
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Left = 668
    Top = 140
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DTDEP'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CTDEP'
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
    Left = 668
    Top = 68
  end
  object dxPopupMenuRBK: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCreateOffer'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton4'
      end>
    ItemOptions.ShowDescriptions = False
    ItemOptions.Size = misNormal
    UseOwnFont = False
    OnPopup = dxPopupMenuRBKPopup
    Left = 120
    Top = 68
    PixelsPerInch = 96
  end
  object cxGridPopupMenuBRK: TcxGridPopupMenu
    Grid = cxGridBRK
    PopupMenus = <
      item
        GridView = cxGridBRKDBTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxPopupMenuRBK
      end>
    Left = 292
    Top = 168
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
    Left = 236
    Top = 68
  end
  object dxBarPopupMenuCOMPONENTS: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGoodsModify'
      end
      item
        Visible = True
        ItemName = 'bbGoodsDelete'
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
    Left = 500
    Top = 224
    PixelsPerInch = 96
  end
  object dxBarPopupMenuCOMPLECT: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGoodsComplectEdit'
      end
      item
        Visible = True
        ItemName = 'bbGoodsComplectDelete'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbKitGoodsInfoCard'
      end
      item
        Visible = True
        ItemName = 'bbKitGoodsPrice'
      end
      item
        Visible = True
        ItemName = 'bbKitGoodsForeignCode'
      end>
    UseOwnFont = False
    Left = 144
    Top = 171
    PixelsPerInch = 96
  end
  object cxGridPopupMenuCOMPLECT: TcxGridPopupMenu
    Grid = cxGridComplect
    PopupMenus = <
      item
        GridView = cxGridComplectTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuCOMPLECT
      end>
    Left = 464
    Top = 68
  end
  object IBCQueryTenderItems: TIBCQuery
    KeyFields = 'UID'
    KeyGenerator = 'gen_tdb_tender_id'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_TENDER'
      
        '  (UID, DOCID, CPV, DENUMIREA_BUNULUI, FDA_SPECIFICATION, GOODSI' +
        'D, GOODS_NAME, COUNTRY_NAME, MANUFACTURER, WARANTY, STANDARD, QT' +
        'Y, PRICE, SUMA, VAT)'
      'VALUES'
      
        '  (:UID, :DOCID, :CPV, :DENUMIREA_BUNULUI, :FDA_SPECIFICATION, :' +
        'GOODSID, :GOODS_NAME, :COUNTRY_NAME, :MANUFACTURER, :WARANTY, :S' +
        'TANDARD, :QTY, :PRICE, :SUMA, :VAT)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_TENDER'
      'WHERE'
      '  UID = :Old_UID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_TENDER'
      'SET'
      
        '  UID = :UID, DOCID = :DOCID, CPV = :CPV, DENUMIREA_BUNULUI = :D' +
        'ENUMIREA_BUNULUI, FDA_SPECIFICATION = :FDA_SPECIFICATION, GOODSI' +
        'D = :GOODSID, GOODS_NAME = :GOODS_NAME, COUNTRY_NAME = :COUNTRY_' +
        'NAME, MANUFACTURER = :MANUFACTURER, WARANTY = :WARANTY, STANDARD' +
        ' = :STANDARD, QTY = :QTY, PRICE = :PRICE, SUMA = :SUMA, VAT = :V' +
        'AT'
      'WHERE'
      '  UID = :Old_UID')
    SQLRefresh.Strings = (
      
        'SELECT UID, DOCID, CPV, DENUMIREA_BUNULUI, FDA_SPECIFICATION, GO' +
        'ODSID, GOODS_NAME, COUNTRY_NAME, MANUFACTURER, WARANTY, STANDARD' +
        ', QTY, PRICE, SUMA, VAT FROM VW_TDB_TENDER'
      'WHERE'
      '  UID = :UID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_TENDER'
      'WHERE'
      'UID = :Old_UID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_TENDER'
      ''
      ') q')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from vw_tdb_tender')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    Left = 592
    Top = 496
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceTenderItems: TIBCDataSource
    DataSet = IBCQueryTenderItems
    Left = 496
    Top = 496
  end
end
