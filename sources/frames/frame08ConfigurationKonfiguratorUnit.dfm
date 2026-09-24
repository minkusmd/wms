inherited frame08ConfigurationBRK: Tframe08ConfigurationBRK
  Width = 1238
  Height = 594
  Margins.Left = 3
  Margins.Top = 3
  Margins.Right = 3
  Margins.Bottom = 3
  Font.Height = -12
  ExplicitWidth = 1238
  ExplicitHeight = 594
  object cxGridBRK: TcxGrid
    Left = 0
    Top = 0
    Width = 1238
    Height = 324
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
    object cxGridBRKDBTable: TcxGridDBTableView
      PopupMenu = dxPopupMenuRBK
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
        MinWidth = 15
        Options.Editing = False
        Options.Focusing = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.ShowCaption = False
        Options.Sorting = False
        Width = 15
      end
      object cxGridBRKDBTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridBRKDB_CREATED_DATE: TcxGridDBColumn
        Caption = 'Data crearii'
        DataBinding.FieldName = 'CREATED_DATE'
        MinWidth = 112
        Options.HorzSizing = False
        Width = 112
      end
      object cxGridBRKDBTableData: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridBRKDBTableDataGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 112
        Options.HorzSizing = False
        Width = 112
      end
      object cxGridBRKDB_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 38
        Width = 64
      end
      object cxGridBRKDB_CT_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 90
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
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridBRKDBTableVAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 64
      end
      object cxGridBRKDBTableRate: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridBRKDBTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridBRKDB_RATEUSD: TcxGridDBColumn
        Caption = 'Rata $'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridBRK_FLG_ACNT: TcxGridDBColumn
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.HorzSizing = False
        Width = 30
      end
      object cxGridBRKDB_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 51
        Width = 64
      end
      object cxGridBRKDB_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        MinWidth = 13
        VisibleForCustomization = False
      end
      object cxGridBRKDB_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 13
        VisibleForCustomization = False
      end
      object cxGridBRK_FLG_CLOSED: TcxGridDBColumn
        DataBinding.FieldName = 'FLG_CLOSED'
        Visible = False
        MinWidth = 13
        VisibleForCustomization = False
      end
      object cxGridBRKDB_dtsc_name: TcxGridDBColumn
        Caption = 'subcont 1'
        DataBinding.FieldName = 'dtsc_name'
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridBRKDB_CTSC_NAME: TcxGridDBColumn
        Caption = 'subsconto 2'
        DataBinding.FieldName = 'ctsc_name'
        Visible = False
        MinWidth = 64
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 64
      end
      object cxGridBRKDBTableColumn2: TcxGridDBColumn
        Caption = 'doc.p.'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
      end
      object cxGridBRKDB_FLG_REZERVA: TcxGridDBColumn
        DataBinding.FieldName = 'FLG_HAS_REZERVA'
        Visible = False
        MinWidth = 13
        VisibleForCustomization = False
      end
      object cxGridBRKDB_FLG_PROFORMA: TcxGridDBColumn
        DataBinding.FieldName = 'FLG_HAS_PROFORMA'
        Visible = False
        MinWidth = 13
        VisibleForCustomization = False
      end
      object cxGridBRKDBTableColumn3: TcxGridDBColumn
        Caption = 'Responsabil'
        DataBinding.FieldName = 'RESPONSIBLE_USERNAME'
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
    end
    object cxGridBRKLevel: TcxGridLevel
      GridView = cxGridBRKDBTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 332
    Width = 1238
    Height = 262
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object cxPageControlComplect: TcxPageControl
      Left = 0
      Top = 0
      Width = 1238
      Height = 262
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Focusable = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Properties.ActivePage = tbsGoods
      Properties.CustomButtons.Buttons = <>
      Properties.TabPosition = tpBottom
      ClientRectBottom = 236
      ClientRectLeft = 4
      ClientRectRight = 1234
      ClientRectTop = 4
      object tbsGoods: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Produse (&1)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ImageIndex = 0
        ParentFont = False
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 30
          Width = 1230
          Height = 202
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
          LookAndFeel.SkinName = ''
          object cxGridComponentsTable: TcxGridDBTableView
            PopupMenu = dxBarPopupMenuCOMPONENTS
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
            DataController.Summary.DefaultGroupSummaryItems = <
              item
                Format = '%d'
                Position = spFooter
                Column = cxGridDBCol_SUMA
              end>
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
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.FooterAutoHeight = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
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
            object cxGrid_FLG_SUPPLIER_PROMO: TcxGridDBColumn
              Caption = 'P'
              DataBinding.FieldName = 'FLG_SUPPLIER_PROMO'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.ilFlags
              Properties.Items = <
                item
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
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'GOODS_NAME'
              MinWidth = 13
              Width = 305
            end
            object cxGridDBCol_QTY: TcxGridDBColumn
              Caption = 'Cant'
              DataBinding.FieldName = 'QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_STOCK_QTYGetDisplayText
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
              Caption = 'Sold'
              DataBinding.FieldName = 'STOCK_QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_STOCK_QTYGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridComponents_FLG_FORCED: TcxGridDBColumn
              Caption = 'F'
              DataBinding.FieldName = 'FLG_FORCED'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 26
              Options.HorzSizing = False
              Width = 26
            end
            object cxGridDBCol_UM_NAME: TcxGridDBColumn
              Caption = 'UM'
              DataBinding.FieldName = 'UM_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Sorting = False
              Width = 64
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
              Properties.DisplayFormat = '#,##0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              Visible = False
              MinWidth = 13
              VisibleForCustomization = False
            end
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = 'Depozit'
              DataBinding.FieldName = 'DTDEP_NAME'
              MinWidth = 38
              Width = 63
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
              VisibleForCustomization = False
              Width = 26
            end
            object cxGridDBCol_GOODSCOMPLECTID: TcxGridDBColumn
              DataBinding.FieldName = 'GOODSCOMPLECT_ID'
              Visible = False
              MinWidth = 13
              VisibleForCustomization = False
            end
            object cxGridDBCol_FLG_HAS_COMPLECT_GOODS: TcxGridDBColumn
              DataBinding.FieldName = 'FLG_HAS_COMPLECT_GOODS'
              Visible = False
              MinWidth = 13
              VisibleForCustomization = False
            end
            object cxGridComponents_PRICE_COLUMN: TcxGridDBColumn
              Caption = 'GP'
              DataBinding.FieldName = 'PRICE_COLUMN'
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.HorzSizing = False
              Width = 38
            end
            object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = 'Cod cntb'
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
            end
            object cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = 'Denumirea factura'
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              MinWidth = 96
              Width = 139
            end
            object cxGridComponents_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
              MinWidth = 13
              VisibleForCustomization = False
            end
            object cxGridComponentsTable_FLG_FORCED_ADDON: TcxGridDBColumn
              Caption = '...'
              DataBinding.FieldName = 'FLG_FORCED_ADDON'
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
              MinWidth = 13
              Options.Editing = False
              Options.IncSearch = False
              Options.HorzSizing = False
              Options.Moving = False
              Width = 13
            end
          end
          object cxGridComponentsDBTableView1: TcxGridDBTableView
            DataController.DataSource = dmDB.IBCDataSourceAchizitii
            DataController.DetailKeyFieldNames = 'docid;dtdep;goodsid'
            DataController.KeyFieldNames = 'docid;dtdep;goodsid'
            DataController.MasterKeyFieldNames = 'docid;dtdep;goodsid'
            object cxGridComponentsDBTableView1DOCID: TcxGridDBColumn
              DataBinding.FieldName = 'DOCID'
              Visible = False
            end
            object cxGridComponentsDBTableView1DTDEP: TcxGridDBColumn
              DataBinding.FieldName = 'DTDEP'
              Visible = False
            end
            object cxGridComponentsDBTableView1SUPPLIERID: TcxGridDBColumn
              DataBinding.FieldName = 'SUPPLIERID'
            end
            object cxGridComponentsDBTableView1SUPPLIER_NAME: TcxGridDBColumn
              DataBinding.FieldName = 'SUPPLIER_NAME'
            end
            object cxGridComponentsDBTableView1GOODS_CODE: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_CODE'
            end
            object cxGridComponentsDBTableView1GOODSID: TcxGridDBColumn
              DataBinding.FieldName = 'GOODSID'
            end
            object cxGridComponentsDBTableView1GOODS_NAME: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_NAME'
            end
            object cxGridComponentsDBTableView1SUPPLIER_QTY: TcxGridDBColumn
              DataBinding.FieldName = 'SUPPLIER_QTY'
            end
            object cxGridComponentsDBTableView1PRICE: TcxGridDBColumn
              DataBinding.FieldName = 'PRICE'
            end
            object cxGridComponentsDBTableView1MENTIUNI: TcxGridDBColumn
              DataBinding.FieldName = 'MENTIUNI'
            end
            object cxGridComponentsDBTableView1SUMA: TcxGridDBColumn
              DataBinding.FieldName = 'SUMA'
            end
          end
          object cxGridLevel: TcxGridLevel
            GridView = cxGridComponentsTable
            object cxGridComponentsLevel1: TcxGridLevel
              GridView = cxGridComponentsDBTableView1
            end
          end
        end
        object DockControlGoods: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1230
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
      object tbsKitContent: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Complectatie (&2)'
        ImageIndex = 1
        object cxGridComplect: TcxGrid
          Left = 0
          Top = 30
          Width = 1230
          Height = 202
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
          object cxGridComplectTable: TcxGridDBTableView
            PopupMenu = dxBarPopupMenuCOMPLECT
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
              MinWidth = 80
              Width = 80
            end
            object cxGridComplect_IMG: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Items = <>
              MinWidth = 24
              Options.Editing = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.FilteringPopup = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.ShowCaption = False
              Width = 24
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
              MinWidth = 24
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridComplect_GOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'GOODS_NAME'
              MinWidth = 13
              Width = 422
            end
            object cxGridComplect_QTY: TcxGridDBColumn
              Caption = 'Cant'
              DataBinding.FieldName = 'QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridComplect_QTYGetDisplayText
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridComplect_UM_NAME: TcxGridDBColumn
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
            object cxGridComplect_PRICE: TcxGridDBColumn
              Caption = 'Pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
              Width = 64
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
              MinWidth = 64
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridComplect_FLG_ACNT: TcxGridDBColumn
              Caption = 'Cnt'
              DataBinding.FieldName = 'FLG_ACNT'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
            end
            object cxGridComplect_WARRANTY: TcxGridDBColumn
              Caption = #1043#1072#1088
              DataBinding.FieldName = 'WARRANTY'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 26
              Options.HorzSizing = False
              Width = 26
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
              MinWidth = 26
              Options.HorzSizing = False
              Width = 26
            end
            object cxGridComplect_FLG_READY: TcxGridDBColumn
              Caption = #1043#1086#1090#1086#1074
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 26
              Options.HorzSizing = False
              VisibleForCustomization = False
              Width = 26
            end
            object cxGridComplect_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = 'Cod factura'
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridComplect_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = 'Denumirea factura'
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              MinWidth = 32
              Width = 147
            end
            object cxGridComplect_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
              MinWidth = 13
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
              MinWidth = 13
              Options.HorzSizing = False
              Width = 13
            end
          end
          object cxGridComplectLevel1: TcxGridLevel
            GridView = cxGridComplectTable
          end
        end
        object DockControlComplect: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1230
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
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 324
    Width = 1238
    Height = 8
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    DragThreshold = 2
    PositionAfterOpen = 19
    MinSize = 128
    Control = pnBottom
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
          ItemName = 'dxBarButton14'
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
        end
        item
          Visible = True
          ItemName = 'bbLibrareSubMenu'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem4'
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
    object bbDocDiscount: TdxBarButton
      Caption = 'Reduceri'
      Category = 0
      Hint = 'Reduceri'
      Visible = ivAlways
      OnClick = bbDocDiscountClick
    end
    object bbCustomerDebts: TdxBarButton
      Caption = 'Datoriile curente...'
      Category = 0
      Hint = 'Datoriile curente'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object bbPriceCol6: TdxBarButton
      Tag = 6
      Caption = 'Pret - diler'
      Category = 0
      Hint = 'Pret - diler'
      Visible = ivAlways
      ShortCut = 32822
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol7: TdxBarButton
      Tag = 7
      Caption = '7 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 0
      Enabled = False
      Hint = '7 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivNever
      ShortCut = 32823
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol0: TdxBarButton
      Caption = 'Pret intrare'
      Category = 0
      Hint = 'Pret intrare'
      Visible = ivNever
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
      OnClick = dxBarButton4Click
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Urmareste acest document...'
      Category = 0
      Hint = 'Urmareste acest document'
      Visible = ivAlways
      OnClick = dxBarButton5Click
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
      OnClick = dxBarButton6Click
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
        end
        item
          Visible = True
          ItemName = 'bbFromAnotherDocument'
        end>
    end
    object dxBarButton8: TdxBarButton
      Caption = 'Modifica numele clientului'
      Category = 0
      Hint = 'Modifica numele clientului'
      Visible = ivAlways
      OnClick = dxBarButton8Click
    end
    object dxBarButton9: TdxBarButton
      Caption = 'Paste from clipboard'
      Category = 0
      Hint = 'Paste from clipboard'
      Visible = ivAlways
      OnClick = dxBarButton9Click
    end
    object bbTVA0: TdxBarButton
      Caption = 'Minus -20% din Pret grila 1'
      Category = 0
      Hint = 'Minus -20% din Pret grila 1'
      Visible = ivAlways
      OnClick = bbTVA0Click
    end
    object dxBarButton10: TdxBarButton
      Caption = 'Minus -20% din pretul curent'
      Category = 0
      Hint = 'Minus -20% din pretul curent'
      Visible = ivAlways
      OnClick = dxBarButton10Click
    end
    object bbFromAnotherDocument: TdxBarButton
      Caption = 'din alt document...'
      Category = 0
      Hint = 'din alt document'
      Visible = ivAlways
      OnClick = bbFromAnotherDocumentClick
    end
    object bbAddFreeDelivery: TdxBarButton
      Caption = 'Adauga "Livrare Chisinau"'
      Category = 0
      Hint = 'Adauga "Livrare Chisinau"'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.SourceHeight = 16
      Glyph.SourceWidth = 16
      Glyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222076696577426F783D2230203020333220333222207374796C653D
        22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
        3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
        303B3C7374796C6520747970653D22746578742F6373732220786D6C3A737061
        63653D227072657365727665223E2E59656C6C6F777B66696C6C3A2346464231
        31353B7D262331333B262331303B2623393B2E5265647B66696C6C3A23443131
        4331433B7D262331333B262331303B2623393B2E426C61636B7B66696C6C3A23
        3732373237323B7D262331333B262331303B2623393B2E477265656E7B66696C
        6C3A233033394332333B7D262331333B262331303B2623393B2E426C75657B66
        696C6C3A233131373744373B7D3C2F7374796C653E0D0A3C672069643D224465
        6C6976657279223E0D0A09093C7061746820636C6173733D22426C7565222064
        3D224D32392E372C31352E376C2D352E342D352E34632D302E322D302E322D30
        2E342D302E332D302E372D302E33483232563763302D302E352D302E342D312D
        312D31483343322E342C362C322C362E352C322C37763135683263302C322E32
        2C312E382C342C342C3420202623393B2623393B73342D312E382C342D346838
        63302C322E322C312E382C342C342C3473342D312E382C342D346832762D352E
        364333302C31362E312C32392E392C31352E392C32392E372C31352E377A204D
        382C3234632D312E312C302D322D302E392D322D3263302D312E312C302E392D
        322C322D3273322C302E392C322C3220202623393B2623393B4331302C32332E
        312C392E312C32342C382C32347A204D32342C3234632D312E312C302D322D30
        2E392D322D3263302D312E312C302E392D322C322D3273322C302E392C322C32
        4332362C32332E312C32352E312C32342C32342C32347A204D32322C3136762D
        3468312E326C342C344832327A222F3E0D0A093C2F673E0D0A3C2F7376673E0D
        0A}
      OnClick = bbAddFreeDeliveryClick
    end
    object bbTender: TdxBarButton
      Caption = 'Creaza oferta pentru tender'
      Category = 0
      Hint = 'Creaza oferta pentru tender'
      Visible = ivAlways
      OnClick = bbTenderClick
    end
    object dxBarButton11: TdxBarButton
      Caption = 'Rotungeste preturile'
      Category = 0
      Hint = 'Rotungeste preturile'
      Visible = ivAlways
      OnClick = dxBarButton11Click
    end
    object dxBarButton12: TdxBarButton
      Caption = 'TVA conform preturilor de pe Fantastic.md'
      Category = 0
      Hint = 'TVA conform preturilor de pe Fantastic.md'
      Visible = ivAlways
      OnClick = dxBarButton12Click
    end
    object bbCredit: TdxBarButton
      Caption = 'Credit 1%'
      Category = 0
      Hint = 'Credit 1%'
      Visible = ivAlways
      OnClick = bbCreditClick
    end
    object btnVinzarePartener: TdxBarButton
      Caption = 'Creare vinzare prin partener'
      Category = 0
      Hint = 'Creare vinzare prin partener'
      Visible = ivAlways
      ShortCut = 49238
      OnClick = btnVinzarePartenerClick
    end
    object dxBarSubItem4: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end>
    end
    object dxBarButton13: TdxBarButton
      Caption = 'Lista produse pentru partener'
      Category = 0
      Hint = 'Lista produse pentru partener'
      Visible = ivAlways
      OnClick = dxBarButton13Click
    end
    object dxBarButton14: TdxBarButton
      Caption = 'Alege furnizor'
      Category = 0
      Hint = 'Alege furnizor'
      Visible = ivAlways
      OnClick = dxBarButton14Click
    end
    object bbLibrareSubMenu: TdxBarSubItem
      Caption = 'Livrare'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddFreeDelivery'
        end
        item
          Visible = True
          ItemName = 'bbLivrareRepublica'
        end
        item
          Visible = True
          ItemName = 'bbLivrareSuburbii'
        end>
    end
    object bbLivrareRepublica: TdxBarButton
      Caption = 'Livrare republica'
      Category = 0
      Hint = 'Livrare republica'
      Visible = ivAlways
      OnClick = bbLivrareRepublicaClick
    end
    object bbLivrareSuburbii: TdxBarButton
      Caption = 'Livrare suburbii'
      Category = 0
      Hint = 'Livrare suburbii'
      Visible = ivAlways
      OnClick = bbLivrareSuburbiiClick
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
          ItemName = 'dxBarButton2'
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
    object bbPriceCol1: TdxBarButton
      Tag = 1
      Caption = 'Pret online'
      Category = 2
      Hint = 'Pret online'
      Visible = ivAlways
      ShortCut = 32817
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol2: TdxBarButton
      Tag = 2
      Caption = '2 grila'
      Category = 2
      Enabled = False
      Hint = '2 grila'
      Visible = ivNever
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol3: TdxBarButton
      Tag = 3
      Caption = '3 grila'
      Category = 2
      Enabled = False
      Hint = '3 grila'
      Visible = ivNever
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol4: TdxBarButton
      Tag = 4
      Caption = '4 '#1082#1086#1083#1086#1085#1082#1072'...'
      Category = 2
      Enabled = False
      Hint = '4 '#1082#1086#1083#1086#1085#1082#1072
      Visible = ivNever
      OnClick = bbPriceCol1Click
    end
    object bbPriceCol5: TdxBarButton
      Tag = 5
      Caption = 'Pret - discount card'
      Category = 2
      Hint = 'Pret - discount card'
      Visible = ivAlways
      ShortCut = 32821
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
          ItemName = 'bbKitchenTemplate'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbTVA0'
        end
        item
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          Visible = True
          ItemName = 'dxBarButton12'
        end
        item
          Visible = True
          ItemName = 'bbCredit'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbMoveGoodsInComplect'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCalcKit'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAddToQTY'
        end
        item
          Visible = True
          ItemName = 'bbIncreaseSum'
        end
        item
          Visible = True
          ItemName = 'dxBarButton11'
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
    object bbPopup_CreateRashod: TdxBarButton
      Caption = 'Creaza "Rezerva"...'
      Category = 4
      Hint = 'Creaza "Rezerva"'
      Visible = ivAlways
      ShortCut = 49234
      OnClick = bbPopup_CreateRashodClick
    end
    object bbPopup_Menu2: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' "'#1056#1072#1089#1093#1086#1076#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102' '#1074' '#1089#1077#1088#1074#1080#1089'"...'
      Category = 4
      Hint = #1057#1086#1079#1076#1072#1090#1100' "'#1056#1072#1089#1093#1086#1076#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102' '#1074' '#1089#1077#1088#1074#1080#1089'"'
      Visible = ivAlways
      OnClick = bbPopup_Menu2Click
    end
    object bbPopup_CreateScet: TdxBarButton
      Caption = 'Creaza "Proforma"...'
      Category = 4
      Hint = 'Creaza "Proforma"'
      Visible = ivAlways
      ShortCut = 49232
      OnClick = bbPopup_CreateScetClick
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
      '  DOCID = :Old_DOCID AND '
      '  DTDEP = :Old_DTDEP AND '
      '  CTDEP = :Old_CTDEP AND '
      '  GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND '
      '  GOODSID = :Old_GOODSID')
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
      '  DOCID = :DOCID AND DTDEP = :DTDEP AND CTDEP = :CTDEP AND '
      '  GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID AND GOODSID = :GOODSID')
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
      'order by rdb$get_context('#39'USER_TRANSACTION'#39', '#39'row#'#39') '
      '')
    MasterFields = 'DOCID;DTDEP;CTDEP;GOODSID'
    DetailFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID'
    MasterSource = dmDB.IBCDataSourceJurnal
    AutoCommit = False
    Left = 668
    Top = 132
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
        ItemName = 'bbPopup_CreateScet'
      end
      item
        Visible = True
        ItemName = 'bbPopup_CreateRashod'
      end
      item
        Visible = True
        ItemName = 'btnVinzarePartener'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbTender'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocDiscount'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCustomerDebts'
      end
      item
        Visible = True
        ItemName = 'dxBarButton4'
      end
      item
        Visible = True
        ItemName = 'dxBarButton8'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton5'
      end>
    ItemOptions.ShowDescriptions = False
    ItemOptions.Size = misNormal
    UseOwnFont = False
    OnPopup = dxPopupMenuRBKPopup
    Left = 128
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
    Left = 236
    Top = 128
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
    Left = 468
    Top = 136
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
    Left = 128
    Top = 131
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
end
