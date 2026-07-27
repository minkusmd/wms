inherited frame18SciotNaOplatu: Tframe18SciotNaOplatu
  Width = 1130
  Height = 554
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 1130
  ExplicitHeight = 554
  object cxGridScetOplata: TcxGrid
    Left = 0
    Top = 0
    Width = 1130
    Height = 282
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
    object cxGridScetOplataTable: TcxGridDBTableView
      PopupMenu = dxPopupMenuDOCS
      OnKeyDown = cxGridScetOplataTableKeyDown
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
      OnCellDblClick = cxGridScetOplataTableCellDblClick
      OnCustomDrawCell = cxGridScetOplataTableCustomDrawCell
      DataController.DataSource = dmDB.IBCDataSourceDocs
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
      object cxGridScetOplata_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridScetOplata_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridScetOplata_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 88
        Options.HorzSizing = False
        Width = 88
      end
      object cxGridScetOplata_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 16
        Width = 80
      end
      object cxGridScetOplata_CT_NAME: TcxGridDBColumn
        Caption = 'Beneficiar'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 16
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 160
      end
      object cxGridScetOplata_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridScetOplata_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridScetOplata_VAT: TcxGridDBColumn
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
      object cxGridScetOplata_RATEUSD: TcxGridDBColumn
        Caption = 'Rata $'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridScetOplata_RATE: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' '#1044#1086#1082'.'
        DataBinding.FieldName = 'RATE'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridScetOplata_PARENTDOCID: TcxGridDBColumn
        Caption = 'Cod parinte'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridScetOplata_FLG_ACNT: TcxGridDBColumn
        Caption = #1041#1091#1093#1075
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridScetOplata_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 16
        Width = 90
      end
      object cxGridScetOplata_FLG_PAID: TcxGridDBColumn
        Caption = 'Platit'
        DataBinding.FieldName = 'FLG_PAID'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridScetOplata_FLG_INVOICE: TcxGridDBColumn
        Caption = 'Vinzare'
        DataBinding.FieldName = 'FLG_INVOICE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridScetOplata_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
      object cxGridScetOplata_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
    end
    object cxGridScetOplataLevel: TcxGridLevel
      GridView = cxGridScetOplataTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 290
    Width = 1130
    Height = 264
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
      Width = 1130
      Height = 264
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
      ClientRectBottom = 238
      ClientRectLeft = 4
      ClientRectRight = 1126
      ClientRectTop = 4
      object tbsGoods: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Lista produselor (&1)'
        ImageIndex = 0
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 28
          Width = 1122
          Height = 206
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
          ExplicitTop = 0
          ExplicitHeight = 234
          object cxGridComponentsTable: TcxGridDBTableView
            PopupMenu = dxBarPopupMenuComponents
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
            OnCustomDrawCell = cxGridComponentsTableCustomDrawCell
            DataController.DataSource = dmDB.IBCDataSourceJurnal
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
            Styles.Footer = dmAdditions.cxStyle_GridHeader
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = 'Depozit'
              DataBinding.FieldName = 'DTDEP_NAME'
              MinWidth = 112
              Options.HorzSizing = False
              Width = 112
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
              Caption = 'TVA'
              DataBinding.FieldName = 'SUMAVAT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              Visible = False
              MinWidth = 16
              VisibleForCustomization = False
            end
            object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
              Caption = 'Act'
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
              MinWidth = 32
              Options.HorzSizing = False
              VisibleForCustomization = False
              Width = 32
            end
            object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
              Caption = 'Sold'
              DataBinding.FieldName = 'STOCK_QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 48
              Options.HorzSizing = False
              Width = 48
            end
            object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = 'Contab'
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 48
              Options.HorzSizing = False
              Width = 48
            end
            object cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = 'Denumire facturi'
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              MinWidth = 40
              Width = 56
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
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1122
          Height = 28
          Align = dalTop
          BarManager = dxBarManager
        end
      end
      object tbsKitContent: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Complectatia (&2)'
        ImageIndex = 1
        object cxGridComplect: TcxGrid
          Left = 0
          Top = 0
          Width = 1122
          Height = 234
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 0
          LookAndFeel.NativeStyle = True
          object cxGridComplectTable: TcxGridDBTableView
            PopupMenu = dxBarPopupMenuComponents
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
            OnCustomDrawCell = cxGridComplectTableCustomDrawCell
            DataController.DataSource = IBCDataSourceJurnalKit
            DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = cxGridComplect_SUMA
                VisibleForCustomization = False
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = cxGridComplect_SUMAVAT
                VisibleForCustomization = False
              end
              item
                Kind = skCount
                Column = cxGridComplect_GOODSID
                VisibleForCustomization = False
              end
              item
                Format = '0'
                Kind = skSum
                Column = cxGridComplect_QTY
                VisibleForCustomization = False
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
            object cxGridComplect_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 48
              Options.HorzSizing = False
              Width = 48
            end
            object cxGridComplectTableCol_IMG: TcxGridDBColumn
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
              MinWidth = 80
              Options.HorzSizing = False
              Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
              Width = 80
            end
            object cxGridComplect_SUMAVAT: TcxGridDBColumn
              Caption = 'TVA'
              DataBinding.FieldName = 'SUMAVAT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
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
              VisibleForCustomization = False
              Width = 40
            end
            object cxGridComplect_WARRANTY: TcxGridDBColumn
              Caption = 'Grnt'
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
              MinWidth = 40
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridComplect_FLG_ACTIVE: TcxGridDBColumn
              Caption = 'Act'
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
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              VisibleForCustomization = False
              Width = 32
            end
            object cxGridComplect_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = 'Cod FF'
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridComplect_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = 'Denumire FF'
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
          end
          object cxGridComplectLevel: TcxGridLevel
            GridView = cxGridComplectTable
          end
        end
      end
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 282
    Width = 1130
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
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'PopupDocs'
      'PopupComponents'
      'PopupComplect')
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
    Left = 348
    Top = 76
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      Caption = 'Items'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 1
      DockedTop = 0
      FloatLeft = 1140
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbGoodsPrice_Complect'
        end
        item
          Visible = True
          ItemName = 'bbChangeGoods'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbAction_PrihodDenegNaScet: TdxBarButton
      Caption = 'Creaza "Ordin Incasare" bancar'
      Category = 0
      Hint = 'Creaza "Ordin Incasare" bancar'
      Visible = ivAlways
      ShortCut = 49225
      OnClick = bbAction_PrihodDenegNaScetClick
    end
    object bbAction_CreateRashod: TdxBarButton
      Caption = 'Creaza "Rezerva"'
      Category = 0
      Hint = 'Creaza "Rezerva"'
      Visible = ivAlways
      ShortCut = 49234
      OnClick = bbAction_CreateRashodClick
    end
    object bbAction_RashodService: TdxBarButton
      Caption = 'Creaza "Rezervare service"'
      Category = 0
      Hint = 'Creaza "Rezervare service"'
      Visible = ivAlways
      OnClick = bbAction_RashodServiceClick
    end
    object bbGotoParentDoc: TdxBarButton
      Caption = 'Treci la documentul parinte'
      Category = 0
      Hint = 'Treci la documentul parinte'
      Visible = ivAlways
      ShortCut = 32805
      OnClick = bbGotoParentDocClick
    end
    object bbDocComments: TdxBarButton
      Caption = 'Comentariu'
      Category = 0
      Hint = 'Comentariu'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbCustomerDebts: TdxBarButton
      Caption = 'Creante si datorii'
      Category = 0
      Hint = 'Creante si datorii'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Reaminteste de contactat clientul...'
      Category = 0
      Hint = 'Reaminteste de contactat clientul'
      Visible = ivAlways
      ShortCut = 49234
      OnClick = dxBarButton1Click
    end
    object bbGoodsInfoCard_Components: TdxBarButton
      Caption = 'Miscarea produsului'
      Category = 1
      Hint = 'Miscarea produsului'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsInfoCard_ComponentsClick
    end
    object bbGoodsPrice_Components: TdxBarButton
      Caption = 'Modificare preturi'
      Category = 1
      Hint = 'Modificare preturi'
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbGoodsPrice_ComponentsClick
    end
    object bbGoodsForeignCode_Components: TdxBarButton
      Caption = 'Codurile produselor de la furnizori'
      Category = 1
      Hint = 'Codurile produselor de la furnizori'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCode_ComponentsClick
    end
    object bbGoodsInfoCard_Complect: TdxBarButton
      Caption = 'Miscarea produsului'
      Category = 2
      Hint = 'Miscarea produsului'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsInfoCard_ComplectClick
    end
    object bbGoodsPrice_Complect: TdxBarButton
      Caption = 'Modificarea preturilor'
      Category = 2
      Hint = 'Modificarea preturilor'
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbGoodsPrice_ComplectClick
    end
    object bbGoodsForeignCode_Complect: TdxBarButton
      Caption = 'Codurile produselor de la furnizori'
      Category = 2
      Hint = 'Codurile produselor de la furnizori'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCode_ComplectClick
    end
    object bbChangeGoods: TdxBarButton
      Caption = 'Modifica produs'
      Category = 2
      Hint = 'Modifica produs'
      Visible = ivAlways
      OnClick = bbChangeGoodsClick
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
      ' * '
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
    Options.BooleanDomainFields = True
    Options.DetailDelay = 50
    Left = 380
    Top = 312
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
    Left = 380
    Top = 272
  end
  object dxPopupMenuDOCS: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbAction_PrihodDenegNaScet'
      end
      item
        Visible = True
        ItemName = 'bbAction_CreateRashod'
      end
      item
        Visible = True
        ItemName = 'bbAction_RashodService'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        Visible = True
        ItemName = 'bbCustomerDebts'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGotoParentDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton1'
      end>
    ItemOptions.ShowDescriptions = False
    ItemOptions.Size = misNormal
    UseOwnFont = False
    OnPopup = dxPopupMenuDOCSPopup
    Left = 68
    Top = 140
    PixelsPerInch = 96
  end
  object cxGridPopupMenuDOCS: TcxGridPopupMenu
    Grid = cxGridScetOplata
    PopupMenus = <
      item
        GridView = cxGridScetOplataTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxPopupMenuDOCS
      end>
    Left = 68
    Top = 80
  end
  object cxGridPopupMenuComponents: TcxGridPopupMenu
    Grid = cxGridComponents
    PopupMenus = <
      item
        GridView = cxGridComponentsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuComponents
      end>
    Left = 64
    Top = 268
  end
  object cxGridPopupMenuComplect: TcxGridPopupMenu
    Grid = cxGridComplect
    PopupMenus = <
      item
        GridView = cxGridComplectTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuComplect
      end>
    Left = 212
    Top = 268
  end
  object dxBarPopupMenuComponents: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGoodsInfoCard_Components'
      end
      item
        Visible = True
        ItemName = 'bbGoodsPrice_Components'
      end
      item
        Visible = True
        ItemName = 'bbGoodsForeignCode_Components'
      end>
    UseOwnFont = False
    Left = 64
    Top = 316
    PixelsPerInch = 96
  end
  object dxBarPopupMenuComplect: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGoodsInfoCard_Complect'
      end
      item
        Visible = True
        ItemName = 'bbGoodsPrice_Complect'
      end
      item
        Visible = True
        ItemName = 'bbGoodsForeignCode_Complect'
      end>
    UseOwnFont = False
    Left = 216
    Top = 316
    PixelsPerInch = 96
  end
end
