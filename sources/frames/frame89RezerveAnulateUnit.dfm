inherited frame89RezerveAnulate: Tframe89RezerveAnulate
  Width = 1372
  Height = 739
  Font.Height = -15
  ParentDoubleBuffered = False
  ExplicitWidth = 1372
  ExplicitHeight = 739
  PixelsPerInch = 120
  object cxGridNPN: TcxGrid
    Left = 0
    Top = 0
    Width = 1372
    Height = 429
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridNPNTable: TcxGridDBTableView
      OnKeyDown = cxGridNPNTableKeyDown
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
      OnCellDblClick = cxGridNPNTableCellDblClick
      OnCustomDrawCell = cxGridNPNTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting]
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxGridNPNTableSuma
        end
        item
          Kind = skCount
          Column = cxGridNPNTableDocID
        end>
      FilterRow.SeparatorWidth = 8
      FilterRow.ApplyChanges = fracDelayed
      FilterRow.OperatorCustomization = True
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsBehavior.IncSearch = True
      OptionsBehavior.EditAutoHeight = eahRow
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NavigatorOffset = 63
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridNPNTable_FLG_CLOSE: TcxGridDBColumn
        AlternateCaption = #1047#1072#1082#1088#1099#1090
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        HeaderGlyph.SourceDPI = 96
        HeaderGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          00000000000074120000741200000000000000000000000000020000000A0000
          000F000000100000001000000010000000100000001100000011000000110000
          00110000001100000011000000100000000A0000000200000009845E4FC1B683
          6EFFB7826DFFB5816DFFB5806CFFB5806CFFB4806CFFB47E6BFFB47E6AFFB37D
          69FFB37D68FFB27D69FFB27C68FF80584AC20000000A0000000EBC8B76FFF8F2
          EDFFF6EFEBFFF6EEEAFFF6EFEAFFF6EFEAFFF6EEE9FFF6EEE9FFF5EEE9FFF6ED
          E8FFF5EEE8FFF5EDE8FFF6EFEBFFBB8774FF0000000E0000000EBE8D79FFF8F3
          EFFFF5EEE9FFF6EEE9FFF5EEEBFFF4F0ECFFEBE8E5FFEEE9E8FFF5EFEAFFF5EC
          E7FFF4ECE6FFF4EBE6FFF6F0ECFFBD8A76FF0000000F0000000DC08F7CFFFAF3
          F1FFF7EFEAFFF6F0EBFFF2EEECFFCEBDB2FFA36442FFB08C7AFFEBE8E5FFF5EE
          E9FFF5EDE7FFF5ECE7FFF7F1EDFFBD8B78FF0000000E0000000CC2917EFFFAF5
          F3FFF8F1EDFFF5F1EFFFD3C2B8FFB57E59FFE2BD8BFFAB724DFFC7B5ABFFF1ED
          EBFFF5EEE9FFF5EEE9FFF8F3EDFFBF8E7BFF0000000D0000000CC39581FFFBF8
          F4FFF6F3F1FFD9C8BFFFB9845EFFE4C18FFFE6C393FFDCB687FFA36D4FFFDDD6
          D2FFF6F0EDFFF6EFEAFFF9F3EFFFC0907DFF0000000D0000000BC59785FFFAF7
          F5FFE1D1C7FFBE8D6AFFEACCA5FFF1DEBFFFF5E4CAFFEBCCA1FFCEA276FFAB7F
          6AFFE8E6E3FFF6F2EEFFF9F3F1FFC29380FF0000000C0000000AC69A88FFFBF9
          F7FFDBC5B8FFC99F81FFE4CCB4FFCAA082FFB98463FFEAD5BBFFEBCEA4FFC493
          6BFFB89786FFEEEAE8FFF8F3F0FFC39683FF0000000B0000000AC89D8BFFFCFA
          F8FFFAF7F6FFD9C3B4FFC1957BFFD4BDAFFFDED3CDFFBC8E71FFEBD7BEFFEED3
          ADFFBB8661FFC4AEA2FFF0ECE9FFC49885FF0000000A00000009CAA08EFFFBFA
          F8FFFCF9F6FFFAF7F6FFF8F5F3FFF9F6F4FFF8F6F4FFE8DFDAFFBC8E71FFE5CD
          B5FFF1DEBDFFBA8562FFE9E6E3FFC59A88FF0000000A00000008CCA391FFFCFB
          FAFFFCF8F5FFFCF8F5FFFBF7F4FFFBF7F4FFFAF6F5FFFAF7F6FFEBE5E1FFC096
          7BFFC5987AFFD1C3BAFFF1EFECFFC99E8CFF0000000900000007CDA593FFFDFB
          FAFFFCF9F7FFFCF9F7FFFCF8F6FFFBF9F5FFFBF8F5FFFBF8F5FFFAF8F6FFF4F2
          F1FFEEECEBFFF4F2F0FFFAF7F6FFCBA18FFF0000000800000006CEA796FFFDFB
          FAFFFEFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBF9FFFCFB
          FBFFFAF9F8FFFBFAF8FFFCFAF8FFCCA391FF00000007000000049A7E71C1CFA9
          98FFCFA898FFCFA997FFCFA997FFCFA897FFCEA796FFCFA796FFCFA896FFCFA7
          96FFCEA696FFCEA794FFCEA694FF987B6FC10000000500000001000000040000
          0005000000060000000600000006000000060000000600000006000000060000
          00060000000600000006000000060000000400000001}
        MinWidth = 22
        Options.HorzSizing = False
        Width = 22
        IsCaptionAssigned = True
      end
      object cxGridNPNTableDocID: TcxGridDBColumn
        Caption = 'docid'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridNPNTable_FLG_WITH_DELIVERY: TcxGridDBColumn
        Caption = 'L'
        DataBinding.FieldName = 'FLG_WITH_DELIVERY'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = dmAdditions.cxImageDocs
        Properties.Items = <
          item
            Description = 'cu livrare Chisinau'
            ImageIndex = 0
            Value = 1
          end
          item
            Description = 'Livrare RM'
            ImageIndex = 2
            Value = 2
          end>
        HeaderAlignmentHorz = taCenter
        MinWidth = 24
        Options.Editing = False
        Options.Focusing = False
        Options.IgnoreTimeForFiltering = False
        Options.IncSearch = False
        Options.FilteringPopupIncrementalFiltering = True
        Options.HorzSizing = False
        Options.ShowCaption = False
        Options.Sorting = False
        Width = 24
      end
      object cxGridNPN_DATA: TcxGridDBColumn
        Caption = 'data doc'
        DataBinding.FieldName = 'DATA'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = cxGridNPN_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridNPN_CREATED_DATE: TcxGridDBColumn
        Caption = 'data crearii'
        DataBinding.FieldName = 'CREATED_DATE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = cxGridNPN_CREATED_DATEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridNPN_DELIVERY_DATE: TcxGridDBColumn
        Caption = 'Data livrarii'
        DataBinding.FieldName = 'DELIVERY_DATE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
      end
      object cxGridNPN_DTDEP_NAME: TcxGridDBColumn
        Caption = 'depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Width = 100
      end
      object cxGridNPN_CT_NAME: TcxGridDBColumn
        Caption = 'client'
        DataBinding.FieldName = 'CT_NAME'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        HeaderAlignmentHorz = taCenter
        MinWidth = 200
        Options.Editing = False
        Options.FilterRowOperator = foLess
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 200
      end
      object cxGridNPN_PHONELIST: TcxGridDBColumn
        AlternateCaption = 'telefon'
        Caption = 'telefon'
        DataBinding.FieldName = 'PHONELIST'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridNPNTableSuma: TcxGridDBColumn
        Caption = 'suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridNPN_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridNPNTableVAT: TcxGridDBColumn
        Caption = 'tva'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 60
      end
      object cxGridNPNTableRate: TcxGridDBColumn
        Caption = 'rata'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 40
      end
      object cxGridNPNTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridNPN_RATEUSD: TcxGridDBColumn
        Caption = 'rata usd'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridNPNTable_FLG_ACNT: TcxGridDBColumn
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
      object cxGridNPNTable_FLG_SHIP: TcxGridDBColumn
        AlternateCaption = #1054#1090#1075#1088#1091#1078#1077#1085
        Caption = 'exped'
        DataBinding.FieldName = 'FLG_SHIP'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridNPNTable_CUSTOMER_TYPE_ID: TcxGridDBColumn
        DataBinding.FieldName = 'CUSTOMER_TYPE_ID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
      end
      object cxGridNPN_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Width = 100
      end
      object cxGridNPN_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
      end
      object cxGridNPN_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
      end
      object cxGridNPN_SC2_NAME: TcxGridDBColumn
        Caption = 'analitica'
        DataBinding.FieldName = 'SC2_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridNPN_DTSC_NAME: TcxGridDBColumn
        Caption = 'subcont'
        DataBinding.FieldName = 'DTSC_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.FilteringPopupIncrementalFiltering = True
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridNPNTableFLG_SALARY: TcxGridDBColumn
        Caption = '...'
        DataBinding.FieldName = 'FLG_SALARY'
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
      end
      object cxGridNPN_CTSC_NAME: TcxGridDBColumn
        Caption = 'subsconto 2'
        DataBinding.FieldName = 'CTSC_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridNPNTableColumn2: TcxGridDBColumn
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
      end
    end
    object cxGridNPNLevel: TcxGridLevel
      GridView = cxGridNPNTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 429
    Width = 1372
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 200
    Control = pnBottom
  end
  object pnBottom: TPanel
    Left = 0
    Top = 439
    Width = 1372
    Height = 300
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxPageControl1: TcxPageControl
      Left = 0
      Top = 0
      Width = 1368
      Height = 296
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      Properties.TabPosition = tpBottom
      ClientRectBottom = 267
      ClientRectLeft = 4
      ClientRectRight = 1364
      ClientRectTop = 4
      object cxTabSheet1: TcxTabSheet
        Caption = 'produse (&1)'
        ImageIndex = 0
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 34
          Width = 1360
          Height = 229
          Align = alClient
          BorderStyle = cxcbsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object cxGridComponentsTable: TcxGridDBTableView
            PopupMenu = ppJurnal
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
              end
              item
                Kind = skCount
                Column = cxGridDBCol_GOODSID
              end
              item
                Format = '-0.00'
                Kind = skSum
              end
              item
                Format = '$0.00'
                Kind = skSum
              end>
            FilterRow.SeparatorWidth = 8
            FixedDataRows.SeparatorWidth = 8
            Images = dmAdditions.ilGoodsProperties
            NewItemRow.SeparatorWidth = 8
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.MultiSelect = True
            OptionsSelection.InvertSelect = False
            OptionsView.CellEndEllipsis = True
            OptionsView.NavigatorOffset = 63
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ColumnAutoWidth = True
            OptionsView.FixedColumnSeparatorWidth = 3
            OptionsView.Footer = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.LeftIndent = 25
            Preview.RightIndent = 6
            RowLayout.MinValueWidth = 100
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = 'depozit'
              DataBinding.FieldName = 'DTDEP_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Width = 100
            end
            object cxGridDBCol_GOODSID: TcxGridDBColumn
              Caption = 'id'
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridDBCol_IMG: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.cxImageList1
              Properties.Items = <>
              HeaderAlignmentHorz = taCenter
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
              Caption = 'produs'
              DataBinding.FieldName = 'GOODS_NAME'
              HeaderAlignmentHorz = taCenter
              Width = 300
            end
            object cxGridDBCol_QTY: TcxGridDBColumn
              AlternateCaption = 'cantitate'
              Caption = 'cant'
              DataBinding.FieldName = 'QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridComponents_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
              HeaderAlignmentHorz = taCenter
              VisibleForCustomization = False
            end
            object cxGridDBCol_UM_NAME: TcxGridDBColumn
              AlternateCaption = 'unitate metrica'
              Caption = 'um'
              DataBinding.FieldName = 'UM_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Options.Sorting = False
              Width = 32
            end
            object cxGridDBCol_PRICE: TcxGridDBColumn
              Caption = 'pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridDBCol_SUMA: TcxGridDBColumn
              Caption = 'suma'
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
            object cxGridComponents_CREATED_BY_NAME: TcxGridDBColumn
              AlternateCaption = 'utilizator'
              Caption = 'utilizator'
              DataBinding.FieldName = 'CREATED_BY_NAME'
              BestFitMaxWidth = 150
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.Editing = False
              Options.Focusing = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Sorting = False
              Width = 100
            end
            object cxGridComponentsTableColumn1: TcxGridDBColumn
              Caption = 'sold'
              DataBinding.FieldName = 'STOCK_QTY'
              HeaderAlignmentHorz = taCenter
              MinWidth = 36
              Options.HorzSizing = False
              Width = 36
            end
          end
          object cxGridLevel: TcxGridLevel
            GridView = cxGridComponentsTable
          end
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1360
          Height = 34
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
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
    CanCustomize = False
    Categories.Strings = (
      'PopupDoc'
      'Goods')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 184
    Top = 78
    PixelsPerInch = 120
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Goods'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 949
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewGoods'
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
          ItemName = 'bbRemoveGoods'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCheckStock'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbActionOtgruziti: TdxBarButton
      Caption = 'Inhide documentul'
      Category = 0
      Hint = 'Inhide documentul'
      Visible = ivAlways
      ImageIndex = 43
      ShortCut = 120
      OnClick = bbActionOtgruzitiClick
    end
    object bbRollbackOtgruzka: TdxBarButton
      Caption = 'Deschide documentul'
      Category = 0
      Hint = 'Deschide documentul'
      Visible = ivAlways
      ShortCut = 8312
      OnClick = bbRollbackOtgruzkaClick
    end
    object bbPrintWarranty: TdxBarButton
      Caption = 'Tipar garantie...'
      Category = 0
      Hint = 'Tipar garantie'
      Visible = ivAlways
      ImageIndex = 28
      ShortCut = 24656
    end
    object bbDocComments: TdxBarButton
      Caption = 'Mentiuni'
      Category = 0
      Hint = 'Mentiuni'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbCheckStock: TdxBarButton
      Caption = 'refresh stoc'
      Category = 0
      Hint = 'refresh stoc'
      Visible = ivAlways
      ImageIndex = 38
      PaintStyle = psCaptionGlyph
      OnClick = bbCheckStockClick
    end
    object bbNewGoods: TdxBarButton
      Caption = 'produs nou'
      Category = 1
      Hint = 'produs nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
    end
    object bbModifyGoods: TdxBarButton
      Caption = 'modifica'
      Category = 1
      Hint = 'modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyGoodsClick
    end
    object bbRemoveGoods: TdxBarButton
      Caption = 'sterge'
      Category = 1
      Hint = 'sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
    end
    object bbGoodsTurnover: TdxBarButton
      Caption = 'Miscarea produsului'
      Category = 1
      Hint = 'Miscarea produsului'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsTurnoverClick
    end
  end
  object pmPopupMenuDocs: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbActionOtgruziti'
      end
      item
        Visible = True
        ItemName = 'bbRollbackOtgruzka'
      end>
    UseOwnFont = False
    OnPopup = pmPopupMenuDocsPopup
    Left = 42
    Top = 77
    PixelsPerInch = 120
  end
  object cxGridPopupMenuNPN: TcxGridPopupMenu
    Grid = cxGridNPN
    PopupMenus = <
      item
        GridView = cxGridNPNTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmPopupMenuDocs
      end>
    Left = 275
    Top = 81
  end
  object ppJurnal: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbModifyGoods'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbRemoveGoods'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGoodsTurnover'
      end>
    UseOwnFont = False
    Left = 40
    Top = 132
    PixelsPerInch = 120
  end
  object cxGridPopupmMenuComponents: TcxGridPopupMenu
    PopupMenus = <
      item
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = ppJurnal
      end>
    Left = 273
    Top = 132
  end
  object IBCQueryCashback: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from vw_tdb_docs_cashback'
      'where docid = :docid')
    Left = 440
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end>
  end
  object IBCDataSourceCashback: TIBCDataSource
    DataSet = IBCQueryCashback
    Left = 336
    Top = 344
  end
end
