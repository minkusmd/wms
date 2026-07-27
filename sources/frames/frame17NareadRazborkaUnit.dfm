inherited frame17NareadRazborka: Tframe17NareadRazborka
  Width = 631
  Height = 427
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 631
  ExplicitHeight = 427
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 104
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
  end
  object pnBottom: TPanel
    Left = 0
    Top = 112
    Width = 631
    Height = 315
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    Caption = 'pnBottom'
    TabOrder = 2
    object cxPageControlComplect: TcxPageControl
      Left = 1
      Top = 1
      Width = 629
      Height = 313
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = tbsGoods
      Properties.CustomButtons.Buttons = <>
      Properties.TabPosition = tpBottom
      OnChange = cxPageControlComplectChange
      ClientRectBottom = 287
      ClientRectLeft = 4
      ClientRectRight = 625
      ClientRectTop = 4
      object tbsGoods: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Produse (&1)'
        ImageIndex = 0
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 30
          Width = 621
          Height = 253
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
            Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = 'Depozit'
              DataBinding.FieldName = 'DTDEP_NAME'
              MinWidth = 112
              Options.HorzSizing = False
              Width = 112
            end
            object cxGridComponents_SN: TcxGridDBColumn
              Caption = 'Numar de serie'
              DataBinding.FieldName = 'SN'
              HeaderAlignmentHorz = taCenter
              MinWidth = 88
              Options.HorzSizing = False
              Width = 88
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
            object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'GOODS_NAME'
              MinWidth = 16
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
              Options.Focusing = False
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
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridDBCol_SUMA: TcxGridDBColumn
              Caption = 'Suma'
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
              Caption = #1053#1044#1057
              DataBinding.FieldName = 'SUMAVAT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              Visible = False
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
              Caption = 'Sold'
              DataBinding.FieldName = 'STOCK_QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
            end
            object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              Visible = False
              MinWidth = 16
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
              MinWidth = 32
              Options.HorzSizing = False
              VisibleForCustomization = False
              Width = 32
            end
            object cxGridDBCol_FLG_READY: TcxGridDBColumn
              Caption = 'G'
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
            end
            object cxGridComponents_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
              MinWidth = 16
              VisibleForCustomization = False
            end
          end
          object cxGridLevel: TcxGridLevel
            GridView = cxGridComponentsTable
          end
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 621
          Height = 30
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = dalTop
          BarManager = dxBarManager
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
          Width = 621
          Height = 253
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          ExplicitTop = 27
          ExplicitWidth = 623
          ExplicitHeight = 258
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
                Kind = skSum
                Column = cxGridComplect_SUMA
              end
              item
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
            Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
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
              Width = 19
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
              Options.Grouping = False
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
              MinWidth = 56
              Options.HorzSizing = False
              Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
              Width = 56
            end
            object cxGridComplect_SUMAVAT: TcxGridDBColumn
              Caption = #1053#1044#1057
              DataBinding.FieldName = 'SUMAVAT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              Visible = False
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridComplect_FLG_ACNT: TcxGridDBColumn
              Caption = #1041#1091#1093
              DataBinding.FieldName = 'FLG_ACNT'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridComplect_WARRANTY: TcxGridDBColumn
              Caption = 'G-tie'
              DataBinding.FieldName = 'WARRANTY'
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
              Caption = #1040#1082#1090#1080#1074
              DataBinding.FieldName = 'FLG_ACTIVE'
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
            object cxGridComplect_FLG_READY: TcxGridDBColumn
              Caption = 'G'
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
            end
            object cxGridComplect_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
              MinWidth = 16
              VisibleForCustomization = False
            end
          end
          object cxGridComplectLevel: TcxGridLevel
            GridView = cxGridComplectTable
          end
        end
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 621
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
  object cxGridRazborka: TcxGrid
    Left = 0
    Top = 0
    Width = 631
    Height = 104
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridRazborkaTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu
      OnKeyDown = cxGridRazborkaTableKeyDown
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
      OnCellDblClick = cxGridRazborkaTableCellDblClick
      OnCustomDrawCell = cxGridRazborkaTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
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
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridRazborka_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridRazborkaTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridRazborka_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridRazborka_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridRazborkaTableWarehouse: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 16
        Width = 80
      end
      object cxGridRazborkaTableCtName: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 16
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 160
      end
      object cxGridRazborkaTableSuma: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridRazborkaTableCurrencyName: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridRazborkaTableVAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridRazborkaTableRate: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridRazborkaTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridRazborka_FLG_ACNT: TcxGridDBColumn
        Caption = 'cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridRazborkaTableCreatedBy: TcxGridDBColumn
        Caption = 'Autor'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 16
        Width = 80
      end
    end
    object cxGridRazborkaLevel: TcxGridLevel
      GridView = cxGridRazborkaTable
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
      'Complect'
      'Popup')
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
    SunkenBorder = True
    UseSystemFont = True
    Left = 508
    Top = 140
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Kit'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 3
      FloatTop = 386
      FloatClientWidth = 110
      FloatClientHeight = 79
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddGoodsComplect'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyGoodsComplect'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveGoodsComplect'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSerialPartNumbers'
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
      Caption = 'Complect'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 820
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
          ItemName = 'bbGoodsSerial'
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
    object bbRemoveGoods: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbRemoveGoodsClick
    end
    object bbGoodsSerial: TdxBarButton
      Caption = 'Numar de serie/partida'
      Category = 0
      Hint = 'Numar de serie/partida'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbGoodsSerialClick
    end
    object bbCloseDocument: TdxBarButton
      Caption = 'Inchide document'
      Category = 0
      Hint = 'Inchide document'
      Visible = ivAlways
      OnClick = bbCloseDocumentClick
    end
    object bbOpenDocument: TdxBarButton
      Caption = 'Deschide document'
      Category = 0
      Hint = 'Deschide document'
      Visible = ivAlways
      OnClick = bbOpenDocumentClick
    end
    object bbAddGoodsComplect: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddGoodsComplectClick
    end
    object bbModifyGoodsComplect: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyGoodsComplectClick
    end
    object bbRemoveGoodsComplect: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbRemoveGoodsComplectClick
    end
    object bbSerialPartNumbers: TdxBarButton
      Caption = 'Numere de serii/partide'
      Category = 1
      Hint = 'Numere de serii/partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbSerialPartNumbersClick
    end
    object bbKitsDisassembled: TdxBarButton
      Caption = #1056#1072#1079#1086#1073#1088#1072#1090#1100' '#1082#1086#1084#1087#1083#1077#1082#1090#1099'...'
      Category = 2
      Hint = #1056#1072#1079#1086#1073#1088#1072#1090#1100' '#1082#1086#1084#1087#1083#1077#1082#1090#1099
      Visible = ivAlways
      OnClick = bbKitsDisassembledClick
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
        'FLG_READY = :FLG_READY, FLG_DELETE = :FLG_DELETE '
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
      ' VW_TDB_JURNAL'
      'WHERE'
      ' GOODSCOMPLECT_ID<>-1')
    MasterFields = 'DOCID;DTDEP;CTDEP;GOODSID'
    DetailFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID'
    MasterSource = IBCDataSourceJurnalLocal
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.BooleanDomainFields = True
    Options.DetailDelay = 50
    Left = 424
    Top = 476
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
    Left = 428
    Top = 428
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbKitsDisassembled'
      end
      item
        Visible = True
        ItemName = 'bbCloseDocument'
      end
      item
        Visible = True
        ItemName = 'bbOpenDocument'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuPopup
    Left = 433
    Top = 94
    PixelsPerInch = 96
  end
  object IBCQueryJurnalLocal: TIBCQuery
    UpdatingTable = 'VW_TDB_JURNAL'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_JURNAL'
      
        '  (DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLECT_ID' +
        ', GOODSCOMPLECT_NAME, GOODSID, GOODS_NAME, GOODS_TYPE_ID, UMID, ' +
        'UM_NAME, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY, COST, F' +
        'LG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE, GOODS_SERIAL_TYPE_ID' +
        ')'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, :GOODSCOMPL' +
        'ECT_ID, :GOODSCOMPLECT_NAME, :GOODSID, :GOODS_NAME, :GOODS_TYPE_' +
        'ID, :UMID, :UM_NAME, :QTY, :PRICE, :SUMA, :SUMAVAT, :WARRANTY, :' +
        'STOCK_QTY, :COST, :FLG_ACTIVE, :FLG_ACNT, :FLG_READY, :FLG_DELET' +
        'E, :GOODS_SERIAL_TYPE_ID)')
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
        'P = :CTDEP, CTDEP_NAME = :CTDEP_NAME, GOODSCOMPLECT_ID = :GOODSC' +
        'OMPLECT_ID, GOODSCOMPLECT_NAME = :GOODSCOMPLECT_NAME, GOODSID = ' +
        ':GOODSID, GOODS_NAME = :GOODS_NAME, GOODS_TYPE_ID = :GOODS_TYPE_' +
        'ID, UMID = :UMID, UM_NAME = :UM_NAME, QTY = :QTY, PRICE = :PRICE' +
        ', SUMA = :SUMA, SUMAVAT = :SUMAVAT, WARRANTY = :WARRANTY, STOCK_' +
        'QTY = :STOCK_QTY, COST = :COST, FLG_ACTIVE = :FLG_ACTIVE, FLG_AC' +
        'NT = :FLG_ACNT, FLG_READY = :FLG_READY, FLG_DELETE = :FLG_DELETE' +
        ', GOODS_SERIAL_TYPE_ID = :GOODS_SERIAL_TYPE_ID'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' (SELECT FIRST 1 SN FROM TDB_SN WHERE (TDB_SN.DOCID=VW_TDB_JURNA' +
        'L.DOCID AND TDB_SN.DTDEP=VW_TDB_JURNAL.DTDEP'
      
        '                        AND TDB_SN.CTDEP=VW_TDB_JURNAL.CTDEP AND' +
        ' TDB_SN.GOODSCOMPLECT_ID=VW_TDB_JURNAL.GOODSCOMPLECT_ID'
      
        '                        AND TDB_SN.GOODSID=VW_TDB_JURNAL.GOODSID' +
        ')) SN'
      'FROM'
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
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' (SELECT FIRST 1 SN FROM TDB_SN WHERE (TDB_SN.DOCID=VW_TDB_JURNA' +
        'L.DOCID AND TDB_SN.DTDEP=VW_TDB_JURNAL.DTDEP'
      
        '                        AND TDB_SN.CTDEP=VW_TDB_JURNAL.CTDEP AND' +
        ' TDB_SN.GOODSCOMPLECT_ID=VW_TDB_JURNAL.GOODSCOMPLECT_ID'
      
        '                        AND TDB_SN.GOODSID=VW_TDB_JURNAL.GOODSID' +
        ')) SN'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' (GOODSCOMPLECT_ID=-1)')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.BooleanDomainFields = True
    Options.DetailDelay = 50
    Left = 136
    Top = 464
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnalLocal: TIBCDataSource
    DataSet = IBCQueryJurnalLocal
    Left = 136
    Top = 416
  end
end
