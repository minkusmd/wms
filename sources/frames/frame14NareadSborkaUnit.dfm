inherited frame14NareadSborka: Tframe14NareadSborka
  Width = 1178
  Height = 621
  Margins.Left = 3
  Margins.Top = 3
  Margins.Right = 3
  Margins.Bottom = 3
  Font.Height = -12
  ExplicitWidth = 1178
  ExplicitHeight = 621
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 361
    Width = 1178
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
  object pnBottom: TPanel
    Left = 0
    Top = 369
    Width = 1178
    Height = 252
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
      Width = 1178
      Height = 252
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
      ClientRectBottom = 226
      ClientRectLeft = 4
      ClientRectRight = 1174
      ClientRectTop = 4
      object tbsGoods: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Complecte (&1)'
        ImageIndex = 0
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 30
          Width = 1170
          Height = 192
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object cxGridComponentsTable: TcxGridDBTableView
            PopupMenu = dxBarPopupMenuGoods
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
                Format = '0.00'
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
              end
              item
                Format = '$0.00'
                Kind = skSum
                Column = cxGridComponents_SUMA_USD
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
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = 'Depozit'
              DataBinding.FieldName = 'DTDEP_NAME'
              MinWidth = 90
              Options.HorzSizing = False
              Width = 90
            end
            object cxGridDBCol_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
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
              MinWidth = 15
              Options.Editing = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.ShowCaption = False
              Options.Sorting = False
              VisibleForCustomization = False
              Width = 15
              IsCaptionAssigned = True
            end
            object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'GOODS_NAME'
              MinWidth = 13
              Width = 128
            end
            object cxGridDBCol_QTY: TcxGridDBColumn
              Caption = 'Cant'
              DataBinding.FieldName = 'QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 38
            end
            object cxGridDBCol_UM_NAME: TcxGridDBColumn
              Caption = 'UM'
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
            object cxGridDBCol_PRICE: TcxGridDBColumn
              Caption = 'Pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
            end
            object cxGridComponents_PRICE_USD: TcxGridDBColumn
              Caption = #1062#1077#1085#1072' USD'
              DataBinding.FieldName = 'PRICE_USD'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
            end
            object cxGridDBCol_SUMA: TcxGridDBColumn
              Caption = 'Suma'
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
              Width = 45
            end
            object cxGridComponents_SUMA_USD: TcxGridDBColumn
              Caption = #1057#1091#1084#1084#1072' USD'
              DataBinding.FieldName = 'SUMA_USD'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
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
            object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
              Caption = 'Sold'
              DataBinding.FieldName = 'STOCK_QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
            end
            object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              Visible = False
              MinWidth = 13
              VisibleForCustomization = False
            end
            object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
              Caption = 'Activ'
              DataBinding.FieldName = 'FLG_ACTIVE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 26
              Options.HorzSizing = False
              Width = 26
            end
            object cxGridDBCol_FLG_READY: TcxGridDBColumn
              Caption = 'Gata'
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
            end
            object cxGridComponentsCOST: TcxGridDBColumn
              Caption = #1050#1086#1089#1090
              DataBinding.FieldName = 'COST'
              Visible = False
              MinWidth = 13
              Width = 15
            end
            object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = 'Cntb'
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.HorzSizing = False
              Width = 38
            end
            object cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = 'Denumire facturi'
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              MinWidth = 32
              Width = 45
            end
            object cxGridComponents_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
              MinWidth = 13
              VisibleForCustomization = False
            end
          end
          object cxGridLevel: TcxGridLevel
            GridView = cxGridComponentsTable
          end
        end
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1170
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
          Width = 1170
          Height = 192
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          object cxGridComplectTable: TcxGridDBTableView
            PopupMenu = dxBarPopupMenuGoods
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
              end
              item
                Format = '$0.00'
                Kind = skSum
                Column = cxGridComplect_SUMA_USD
              end
              item
                Format = '0.00'
                Kind = skSum
                Column = cxGridComplectCOST
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
              Caption = 'Depozit'
              DataBinding.FieldName = 'DTDEP_NAME'
              MinWidth = 90
              Options.HorzSizing = False
              Width = 90
            end
            object cxGridComplect_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.HorzSizing = False
              Width = 38
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
              MinWidth = 15
              Options.Editing = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.FilteringPopup = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.ShowCaption = False
              Width = 15
            end
            object cxGridComplect_GOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'GOODS_NAME'
              MinWidth = 13
              Width = 128
            end
            object cxGridComplectTableColumn1: TcxGridDBColumn
              Caption = '...'
              DataBinding.FieldName = 'FLG_FORCED_ADDON'
              PropertiesClassName = 'TcxImageComboBoxProperties'
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
                end
                item
                  ImageIndex = 3
                  Value = 3
                end>
              HeaderAlignmentHorz = taCenter
              MinWidth = 21
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 21
            end
            object cxGridComplect_QTY: TcxGridDBColumn
              Caption = 'Cant'
              DataBinding.FieldName = 'QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridComplect_QTYGetDisplayText
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 38
            end
            object cxGridComplect_UM_NAME: TcxGridDBColumn
              Caption = 'UM'
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
              Caption = 'Pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.000'
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
            end
            object cxGridComplect_PRICE_USD: TcxGridDBColumn
              Caption = #1062#1077#1085#1072' USD'
              DataBinding.FieldName = 'PRICE_USD'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
            end
            object cxGridComplect_SUMA: TcxGridDBColumn
              Caption = 'Suma'
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
              Width = 45
            end
            object cxGridComplect_SUMA_USD: TcxGridDBColumn
              Caption = #1057#1091#1084#1084#1072' USD'
              DataBinding.FieldName = 'SUMA_USD'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
            end
            object cxGridComplect_SUMAVAT: TcxGridDBColumn
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
            object cxGridComplect_FLG_ACNT: TcxGridDBColumn
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
            object cxGridComplect_WARRANTY: TcxGridDBColumn
              Caption = 'Garant'
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
              Properties.DisplayFormat = '0.000'
              OnGetDisplayText = cxGridComplect_QTYGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
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
            object cxGridComplectCOST: TcxGridDBColumn
              Caption = #1050#1086#1089#1090
              DataBinding.FieldName = 'COST'
              Visible = False
              MinWidth = 13
            end
            object cxGridComplect_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = 'Cod cntb'
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.HorzSizing = False
              Width = 38
            end
            object cxGridComplect_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = 'Denumire facturi'
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              MinWidth = 32
              Width = 45
            end
            object cxGridComplect_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
              MinWidth = 13
              VisibleForCustomization = False
            end
          end
          object cxGridComplectLevel: TcxGridLevel
            GridView = cxGridComplectTable
          end
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1170
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
  object cxGridSborka: TcxGrid
    Left = 0
    Top = 0
    Width = 1178
    Height = 361
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridSborkaTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenuDocs
      OnKeyDown = cxGridSborkaTableKeyDown
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
      OnCellDblClick = cxGridSborkaTableCellDblClick
      OnCustomDrawCell = cxGridSborkaTableCustomDrawCell
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
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridSborkaTable_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 38
        Options.HorzSizing = False
        Width = 38
      end
      object cxGridSborkaTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridSborka_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridSborka_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridSborkaTableWarehouse: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 13
        Width = 64
      end
      object cxGridSborkaTableCtName: TcxGridDBColumn
        Caption = 'Subdiviziune'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 13
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 128
      end
      object cxGridSborkaTableSuma: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 51
        Options.HorzSizing = False
        Width = 51
      end
      object cxGridSborkaTableCurrencyName: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridSborkaTableVAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridSborkaTableRate: TcxGridDBColumn
        Caption = 'Curs doc'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 51
        Options.HorzSizing = False
        Width = 51
      end
      object cxGridSborkaTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridSborka_FLG_ACNT: TcxGridDBColumn
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
      object cxGridSborkaTable_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 13
        Width = 64
      end
      object cxGridSborka_FLG_FURNITURE: TcxGridDBColumn
        Caption = 'M'
        DataBinding.FieldName = 'FLG_FURNITURE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        MinWidth = 15
        Options.HorzSizing = False
        Width = 15
      end
    end
    object cxGridSborkaLevel: TcxGridLevel
      GridView = cxGridSborkaTable
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'PopupMenu'
      'Complect'
      'Kit')
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
    Left = 276
    Top = 340
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Complect'
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
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSerialGoods'
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
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Kit'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1020
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
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
          ItemName = 'bbDeleteGoodsComplect'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSerialPartNumbers'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
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
    object bbMarkAsReady: TdxBarButton
      Caption = 'Valideaza asamblarea'
      Category = 0
      Hint = 'Valideaza asamblarea'
      Visible = ivAlways
      ImageIndex = 43
      ShortCut = 120
      OnClick = bbMarkAsReadyClick
    end
    object bbDocOpen: TdxBarButton
      Caption = 'Anuleaza validarea'
      Category = 0
      Hint = 'Anuleaza validarea'
      Visible = ivAlways
      OnClick = bbDocOpenClick
    end
    object bbCreateRazborca: TdxBarButton
      Caption = 'Creaza dezasamblarea'
      Category = 0
      Hint = 'Creaza dezasamblarea'
      Visible = ivAlways
      OnClick = bbCreateRazborcaClick
    end
    object bbDocComments: TdxBarButton
      Caption = 'Mentiuni'
      Category = 0
      Hint = 'Mentiuni'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbSubItemsPriceColumns: TdxBarSubItem
      Caption = 'Grila de preturi'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
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
    object bbPriceCol0: TdxBarButton
      Caption = 'Pret intrare'
      Category = 0
      Hint = 'Pret intrare'
      Visible = ivAlways
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol1: TdxBarButton
      Tag = 1
      Caption = 'Pret online'
      Category = 0
      Hint = 'Pret online'
      Visible = ivAlways
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol2: TdxBarButton
      Tag = 2
      Caption = '2 grila...'
      Category = 0
      Hint = '2 grila'
      Visible = ivAlways
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol3: TdxBarButton
      Tag = 3
      Caption = '3 grila...'
      Category = 0
      Hint = '3 grila'
      Visible = ivAlways
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol4: TdxBarButton
      Tag = 4
      Caption = '4 grila...'
      Category = 0
      Hint = '4 grila'
      Visible = ivAlways
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol5: TdxBarButton
      Tag = 5
      Caption = 'Pret discount card'
      Category = 0
      Hint = 'Pret discount card'
      Visible = ivAlways
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol6: TdxBarButton
      Tag = 6
      Caption = 'Pret diler'
      Category = 0
      Hint = 'Pret diler'
      Visible = ivAlways
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol7: TdxBarButton
      Tag = 7
      Caption = '7 grila...'
      Category = 0
      Hint = '7 grila'
      Visible = ivAlways
      OnClick = bbPriceCol0Click
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Modifica pretul'
      Category = 0
      Hint = 'Modifica pretul'
      Visible = ivAlways
      ShortCut = 16465
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Produse racordate de la furnizori'
      Category = 0
      Hint = 'Produse racordate de la furnizori'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = dxBarButton2Click
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Treci la documentul parinte'
      Category = 0
      Hint = 'Treci la documentul parinte'
      Visible = ivAlways
      ShortCut = 32805
      OnClick = dxBarButton4Click
    end
    object bbCost2Price: TdxBarButton
      Caption = 'Pret mobila'
      Category = 0
      Hint = 'Pret mobila'
      Visible = ivAlways
      OnClick = bbCost2PriceClick
    end
    object bbImport: TdxBarButton
      Caption = 'Import din intrari'
      Category = 0
      Hint = 'Import din intrari'
      Visible = ivAlways
      OnClick = bbImportClick
    end
    object bbGoodsBySupplier: TdxBarButton
      Caption = 'Lista produselor dupa furnizor'
      Category = 0
      Hint = 'Lista produselor dupa furnizor'
      Visible = ivAlways
      OnClick = bbGoodsBySupplierClick
    end
    object bbAddGoods: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
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
    object bbSerialGoods: TdxBarButton
      Caption = 'Numere serii / partide'
      Category = 1
      Hint = 'Numere serii / partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbSerialGoodsClick
    end
    object bbAddGoodsComplect: TdxBarButton
      Caption = 'Nou'
      Category = 2
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddGoodsComplectClick
    end
    object bbModifyGoodsComplect: TdxBarButton
      Caption = 'Modifica'
      Category = 2
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyGoodsComplectClick
    end
    object bbDeleteGoodsComplect: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteGoodsComplectClick
    end
    object bbSerialPartNumbers: TdxBarButton
      Caption = 'Numere de serii / partide'
      Category = 2
      Hint = 'Numere de serii / partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbSerialPartNumbersClick
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Adauga din complectatie'
      Category = 2
      Hint = 'Adauga din complectatie'
      Visible = ivAlways
      ShortCut = 117
      OnClick = dxBarButton3Click
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 2
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'bbCost2Price'
        end
        item
          Visible = True
          ItemName = 'bbImport'
        end
        item
          Visible = True
          ItemName = 'bbGoodsBySupplier'
        end>
    end
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
    MasterSource = dmDB.IBCDataSourceJurnal
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.BooleanDomainFields = True
    Options.StrictUpdate = False
    Options.DetailDelay = 50
    Left = 712
    Top = 356
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
    Left = 712
    Top = 308
  end
  object dxBarPopupMenuDocs: TdxBarPopupMenu
    BarManager = dxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbMarkAsReady'
      end
      item
        Visible = True
        ItemName = 'bbDocOpen'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCreateRazborca'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        Visible = True
        ItemName = 'dxBarButton4'
      end>
    UseOwnFont = True
    Left = 176
    Top = 116
    PixelsPerInch = 96
  end
  object cxGridPopupMenuDocs: TcxGridPopupMenu
    Grid = cxGridSborka
    PopupMenus = <
      item
        GridView = cxGridSborkaTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuDocs
      end>
    Left = 522
    Top = 101
  end
  object dxBarPopupMenuGoods: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        BeginGroup = True
        Visible = True
      end
      item
        Visible = True
      end
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end
      item
        Visible = True
        ItemName = 'dxBarButton2'
      end>
    UseOwnFont = False
    Left = 276
    Top = 424
    PixelsPerInch = 96
  end
  object cxGridPopupMenuGoods: TcxGridPopupMenu
    Grid = cxGridComponents
    PopupMenus = <
      item
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuDocs
      end>
    Left = 168
    Top = 376
  end
end
