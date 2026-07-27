inherited frame10NakladnieRN: Tframe10NakladnieRN
  Width = 1410
  Height = 725
  Margins.Left = 2
  Margins.Top = 2
  Margins.Right = 2
  Margins.Bottom = 2
  Font.Height = -12
  ParentDoubleBuffered = False
  ExplicitWidth = 1410
  ExplicitHeight = 725
  object cxGridNPN: TcxGrid
    Left = 0
    Top = 0
    Width = 1410
    Height = 372
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    PopupMenu = pmPopupMenuDocs
    TabOrder = 0
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
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      FilterRow.OperatorCustomization = True
      OptionsBehavior.IncSearch = True
      OptionsBehavior.EditAutoHeight = eahRow
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridNPNTable_FLG_CLOSED: TcxGridDBColumn
        AlternateCaption = #1047#1072#1082#1088#1099#1090
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        HeaderGlyph.SourceDPI = 96
        HeaderGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
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
        MinWidth = 11
        Width = 44
        IsCaptionAssigned = True
      end
      object cxGridNPNTableDocID: TcxGridDBColumn
        Caption = 'docid'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 99
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
        MinWidth = 12
        Options.Editing = False
        Options.Focusing = False
        Options.IgnoreTimeForFiltering = False
        Options.IncSearch = False
        Options.FilteringPopupIncrementalFiltering = True
        Options.ShowCaption = False
        Options.Sorting = False
        Width = 17
      end
      object cxGridNPN_DATA: TcxGridDBColumn
        Caption = 'data doc'
        DataBinding.FieldName = 'DATA'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = cxGridNPN_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 51
        Width = 103
      end
      object cxGridNPN_CREATED_DATE: TcxGridDBColumn
        Caption = 'data crearii'
        DataBinding.FieldName = 'CREATED_DATE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = cxGridNPN_CREATED_DATEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 51
        Width = 102
      end
      object cxGridNPN_DELIVERY_DATE: TcxGridDBColumn
        Caption = 'Data livrarii'
        DataBinding.FieldName = 'DELIVERY_DATE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 51
        Width = 98
      end
      object cxGridNPN_DTDEP_NAME: TcxGridDBColumn
        Caption = 'depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 78
      end
      object cxGridNPN_CT_NAME: TcxGridDBColumn
        Caption = 'client'
        DataBinding.FieldName = 'CT_NAME'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        HeaderAlignmentHorz = taCenter
        MinWidth = 102
        Options.Editing = False
        Options.FilterRowOperator = foLess
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 197
      end
      object cxGridNPN_PHONELIST: TcxGridDBColumn
        AlternateCaption = 'Telefon'
        Caption = 'Telefon'
        DataBinding.FieldName = 'PHONELIST'
        HeaderAlignmentHorz = taCenter
        MinWidth = 41
        Width = 64
      end
      object cxGridNPNTableSuma: TcxGridDBColumn
        Caption = 'suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 33
        Width = 49
      end
      object cxGridNPN_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 21
        Width = 33
      end
      object cxGridNPNTableVAT: TcxGridDBColumn
        Caption = 'tva'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.Sorting = False
        Width = 46
      end
      object cxGridNPNTableRate: TcxGridDBColumn
        Caption = 'rata'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 21
        Options.Sorting = False
        Width = 33
      end
      object cxGridNPNTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 36
        Width = 36
      end
      object cxGridNPN_RATEUSD: TcxGridDBColumn
        Caption = 'rata usd'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 26
        Width = 39
      end
      object cxGridNPNTable_FLG_ACNT: TcxGridDBColumn
        Caption = 'cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 21
        Width = 41
      end
      object cxGridNPNTable_FLG_SHIP: TcxGridDBColumn
        AlternateCaption = #1054#1090#1075#1088#1091#1078#1077#1085
        Caption = 'exped'
        DataBinding.FieldName = 'FLG_SHIP'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 21
        Width = 45
      end
      object cxGridNPNTable_CUSTOMER_TYPE_ID: TcxGridDBColumn
        DataBinding.FieldName = 'CUSTOMER_TYPE_ID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 10
        VisibleForCustomization = False
      end
      object cxGridNPN_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 41
        Width = 76
      end
      object cxGridNPN_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 10
        VisibleForCustomization = False
      end
      object cxGridNPN_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 10
        VisibleForCustomization = False
      end
      object cxGridNPN_SC2_NAME: TcxGridDBColumn
        Caption = 'analitica'
        DataBinding.FieldName = 'SC2_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 41
        Width = 63
      end
      object cxGridNPN_DTSC_NAME: TcxGridDBColumn
        Caption = 'subcont'
        DataBinding.FieldName = 'DTSC_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 51
        Options.FilteringPopupIncrementalFiltering = True
        Width = 76
      end
      object cxGridNPN_FLG_SALARY: TcxGridDBColumn
        Caption = '...'
        DataBinding.FieldName = 'FLG_SALARY'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 10
        VisibleForCustomization = False
      end
      object cxGridNPN_RESPONSIBLE_USERNAME: TcxGridDBColumn
        Caption = 'Responsabil'
        DataBinding.FieldName = 'RESPONSIBLE_USERNAME'
        MinWidth = 62
        Width = 93
      end
    end
    object cxGridNPNLevel: TcxGridLevel
      GridView = cxGridNPNTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 372
    Width = 1410
    Height = 8
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    DragThreshold = 2
    PositionAfterOpen = 15
    MinSize = 102
    Control = pnBottom
  end
  object pnBottom: TPanel
    Left = 0
    Top = 380
    Width = 1410
    Height = 345
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object cxPageControl1: TcxPageControl
      Left = 0
      Top = 0
      Width = 1406
      Height = 341
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
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      Properties.Images = dmAdditions.cxImageDocs
      Properties.TabPosition = tpBottom
      OnPageChanging = cxPageControl1PageChanging
      ClientRectBottom = 315
      ClientRectLeft = 4
      ClientRectRight = 1402
      ClientRectTop = 4
      object cxTabSheet1: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'produse (&1)'
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 30
          Width = 1398
          Height = 281
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          BorderStyle = cxcbsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
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
                Column = cxGridDBCol_SUMAVAT
              end
              item
                Kind = skCount
                Column = cxGridDBCol_GOODSID
              end
              item
                Format = '-0.00'
                Kind = skSum
                Column = cxGridComponents_DISCOUNT_SUMA
              end
              item
                Format = '$0.00'
                Kind = skSum
                Column = cxGridComponents_SUMA_USD
              end>
            Images = dmAdditions.ilGoodsProperties
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.MultiSelect = True
            OptionsSelection.InvertSelect = False
            OptionsView.CellEndEllipsis = True
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.OnGetContentStyle = cxGridComponentsTableStylesGetContentStyle
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = 'depozit'
              DataBinding.FieldName = 'DTDEP_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 30
              Width = 51
            end
            object cxGridDBCol_GOODSID: TcxGridDBColumn
              Caption = 'id'
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 48
              Options.HorzSizing = False
              Width = 48
            end
            object cxGridDBCol_IMG: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.cxImageList1
              Properties.Items = <>
              HeaderAlignmentHorz = taCenter
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
            object cxGridComponentsTable_FLG_FA: TcxGridDBColumn
              Caption = '...'
              DataBinding.FieldName = 'flg_forced_addon'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.ilFlags
              Properties.Items = <
                item
                  ImageIndex = 1
                  Value = 1
                end>
              HeaderAlignmentHorz = taCenter
              MinWidth = 19
              Options.Focusing = False
              Options.IncSearch = False
              Options.HorzSizing = False
              Options.Moving = False
              Width = 19
            end
            object cxGridComponents_FLG_SUPPLIER_PROMO: TcxGridDBColumn
              Caption = 'P'
              DataBinding.FieldName = 'FLG_SUPPLIER_PROMO'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.ilGoodsProperties
              Properties.Items = <
                item
                  Description = 'Promotie Furnizor'
                  ImageIndex = 4
                  Value = 1
                end>
              HeaderAlignmentHorz = taCenter
              MinWidth = 19
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 19
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
              HeaderAlignmentHorz = taCenter
              MinWidth = 19
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 19
            end
            object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
              Caption = 'produs'
              DataBinding.FieldName = 'GOODS_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 10
              Width = 154
            end
            object cxGridDBCol_QTY: TcxGridDBColumn
              AlternateCaption = 'cantitate'
              Caption = 'cant'
              DataBinding.FieldName = 'QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_STOCK_QTYGetDisplayText
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 30
              Options.HorzSizing = False
              Width = 30
            end
            object cxGridComponents_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 10
              VisibleForCustomization = False
            end
            object cxGridComponents_FLG_FORCED: TcxGridDBColumn
              Caption = 'f'
              DataBinding.FieldName = 'FLG_FORCED'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 19
              Options.HorzSizing = False
              Width = 19
            end
            object cxGridDBCol_UM_NAME: TcxGridDBColumn
              AlternateCaption = 'unitate metrica'
              Caption = 'um'
              DataBinding.FieldName = 'UM_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 30
              Options.HorzSizing = False
              Options.Sorting = False
              Width = 30
            end
            object cxGridDBCol_PRICE: TcxGridDBColumn
              Caption = 'pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 36
              Width = 36
            end
            object cxGridComponents_PRICE_USD: TcxGridDBColumn
              Caption = #1062#1077#1085#1072' USD'
              DataBinding.FieldName = 'PRICE_USD'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 36
              Options.HorzSizing = False
              Width = 36
            end
            object cxGridComponents_DISCOUNT_P: TcxGridDBColumn
              AlternateCaption = #1057#1082#1080#1076#1082#1072', %'
              Caption = '-%'
              DataBinding.FieldName = 'DISCOUNT_P'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '-0%'
              Properties.Nullstring = ' '
              Properties.UseNullString = True
              Visible = False
              OnGetDisplayText = cxGridComponents_DISCOUNT_PGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 21
              Options.HorzSizing = False
              Width = 21
            end
            object cxGridComponents_DISCOUNT_SUMA: TcxGridDBColumn
              Caption = #1057#1082#1080#1076#1082#1072
              DataBinding.FieldName = 'DISCOUNT_SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '-0.00'
              Visible = False
              OnGetDisplayText = cxGridComponents_DISCOUNT_SUMAGetDisplayText
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 36
              Options.HorzSizing = False
              Width = 36
            end
            object cxGridDBCol_SUMA: TcxGridDBColumn
              Caption = 'suma'
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 36
              Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
              Width = 36
            end
            object cxGridComponents_SUMA_USD: TcxGridDBColumn
              Caption = #1057#1091#1084#1084#1072' USD'
              DataBinding.FieldName = 'SUMA_USD'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 36
              Options.HorzSizing = False
              Width = 36
            end
            object cxGridDBCol_SUMAVAT: TcxGridDBColumn
              Caption = 'tva'
              DataBinding.FieldName = 'SUMAVAT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 30
              Width = 30
            end
            object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 10
              VisibleForCustomization = False
            end
            object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
              AlternateCaption = 'activ'
              Caption = 'act'
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
              AlternateCaption = 'gata'
              Caption = 'g'
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 26
              Options.HorzSizing = False
              Width = 26
            end
            object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
              AlternateCaption = 'sold'
              Caption = 'sold'
              DataBinding.FieldName = 'STOCK_QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_STOCK_QTYGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 30
              Options.HorzSizing = False
              Width = 30
            end
            object cxGridComponents_PRICE_COLUMN: TcxGridDBColumn
              AlternateCaption = 'grila de preturi'
              Caption = 'gp'
              DataBinding.FieldName = 'PRICE_COLUMN'
              HeaderAlignmentHorz = taCenter
              MinWidth = 19
              Options.HorzSizing = False
              Styles.OnGetContentStyle = cxGridComponents_PRICE_COLUMNStylesGetContentStyle
              Width = 19
            end
            object cxGridComponents_CREATED_BY_NAME: TcxGridDBColumn
              AlternateCaption = 'utilizator'
              Caption = 'utilizator'
              DataBinding.FieldName = 'CREATED_BY_NAME'
              BestFitMaxWidth = 77
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
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
              Width = 64
            end
            object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = 'id cntb'
              Caption = 'id cntb'
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.HorzSizing = False
              Width = 38
            end
            object cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = 'denumire cntb'
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              HeaderAlignmentHorz = taCenter
              MinWidth = 26
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
          Width = 1398
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
      object tbCashback: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'cashback (&3)'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object cxGrid1: TcxGrid
          Left = 0
          Top = 0
          Width = 1398
          Height = 311
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 0
          object cxGrid1DBTableView1: TcxGridDBTableView
            DataController.DataSource = IBCDataSourceCashback
            DataController.KeyFieldNames = 'DOCID;GOODSID'
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                Column = cxGrid1DBTableView1CASHBACK
              end>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object cxGrid1DBTableView1DOCID: TcxGridDBColumn
              DataBinding.FieldName = 'DOCID'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 10
            end
            object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGrid1DBTableView1GOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'GOODS_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 10
              Width = 640
            end
            object cxGrid1DBTableView1CASHBACK: TcxGridDBColumn
              Caption = 'Suma cashback'
              DataBinding.FieldName = 'CASHBACK'
              HeaderAlignmentHorz = taCenter
              MinWidth = 96
              Options.HorzSizing = False
              Width = 96
            end
            object cxGrid1DBTableView1REGISTER_DATE: TcxGridDBColumn
              Caption = 'Data inregistrarii'
              DataBinding.FieldName = 'REGISTER_DATE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 96
              Options.HorzSizing = False
              Width = 96
            end
            object cxGrid1DBTableView1VALID_UNTIL: TcxGridDBColumn
              Caption = 'Valabil pina la '
              DataBinding.FieldName = 'VALID_UNTIL'
              HeaderAlignmentHorz = taCenter
              MinWidth = 96
              Options.HorzSizing = False
              Width = 96
            end
            object cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn
              DataBinding.FieldName = 'CUSTOMERID'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 10
            end
            object cxGrid1DBTableView1CUSTOMER_NAME: TcxGridDBColumn
              DataBinding.FieldName = 'CUSTOMER_NAME'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 10
            end
            object cxGrid1DBTableView1WEB_LOGIN: TcxGridDBColumn
              DataBinding.FieldName = 'WEB_LOGIN'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 10
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
      object tbsDelivery: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'livrari (&4)'
        ImageIndex = 2
        inline frameDelivery1: TframeDelivery
          Left = 0
          Top = 0
          Width = 1398
          Height = 311
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ExplicitWidth = 1398
          ExplicitHeight = 311
          inherited cxGroupBox1: TcxGroupBox
            ParentFont = False
            Style.Font.Charset = RUSSIAN_CHARSET
            Style.IsFontAssigned = True
            ExplicitWidth = 477
            ExplicitHeight = 203
            Height = 203
            Width = 477
            inherited cxLabel1: TcxLabel
              Left = 8
              Top = 50
              ExplicitLeft = 8
              ExplicitTop = 50
            end
            inherited beCurier: TcxDBButtonEdit
              Left = 78
              Top = 49
              ParentFont = False
              Properties.OnButtonClick = nil
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 78
              ExplicitTop = 49
              ExplicitHeight = 23
            end
            inherited cxLabel2: TcxLabel
              Left = 8
              Top = 19
              ExplicitLeft = 8
              ExplicitTop = 19
            end
            inherited cxDBTextEdit1: TcxDBTextEdit
              Left = 78
              Top = 18
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 78
              ExplicitTop = 18
              ExplicitHeight = 23
            end
            inherited cxDBCheckBox1: TcxDBCheckBox
              Left = 78
              Top = 80
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 78
              ExplicitTop = 80
              ExplicitWidth = 65
              ExplicitHeight = 19
            end
            inherited cxDBCheckBox2: TcxDBCheckBox
              Left = 298
              Top = 99
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 298
              ExplicitTop = 99
              ExplicitWidth = 57
              ExplicitHeight = 19
            end
            inherited cxDBCheckBox3: TcxDBCheckBox
              Left = 78
              Top = 99
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 78
              ExplicitTop = 99
              ExplicitWidth = 65
              ExplicitHeight = 19
            end
            inherited cxDBCheckBox4: TcxDBCheckBox
              Left = 188
              Top = 80
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 188
              ExplicitTop = 80
              ExplicitWidth = 82
              ExplicitHeight = 19
            end
            inherited cxDBCheckBox5: TcxDBCheckBox
              Left = 188
              Top = 99
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 188
              ExplicitTop = 99
              ExplicitWidth = 50
              ExplicitHeight = 19
            end
          end
          inherited cxGroupBox2: TcxGroupBox
            Left = 489
            Top = 30
            ParentFont = False
            Style.Font.Charset = RUSSIAN_CHARSET
            Style.IsFontAssigned = True
            ExplicitLeft = 489
            ExplicitTop = 30
            ExplicitWidth = 748
            ExplicitHeight = 203
            Height = 203
            Width = 748
            inherited cxDBLookupComboBox1: TcxDBLookupComboBox
              Left = 107
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 107
              ExplicitWidth = 300
              ExplicitHeight = 23
              Width = 300
            end
            inherited cxLabel3: TcxLabel
              Top = 20
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitTop = 20
            end
            inherited cxDBLookupComboBox2: TcxDBLookupComboBox
              Left = 107
              Top = 43
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 107
              ExplicitTop = 43
              ExplicitHeight = 23
            end
            inherited cxLabel4: TcxLabel
              Top = 42
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitTop = 42
            end
            inherited cxDBLookupComboBox3: TcxDBLookupComboBox
              Left = 303
              Top = 43
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 303
              ExplicitTop = 43
              ExplicitHeight = 23
            end
            inherited cxLabel5: TcxLabel
              Left = 275
              Top = 43
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 275
              ExplicitTop = 43
            end
            inherited cxDBDateEdit1: TcxDBDateEdit
              Left = 509
              Top = 43
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 509
              ExplicitTop = 43
              ExplicitWidth = 82
              ExplicitHeight = 23
              Width = 82
            end
            inherited cxLabel6: TcxLabel
              Left = 479
              Top = 43
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 479
              ExplicitTop = 43
            end
            inherited cxLabel7: TcxLabel
              Left = 606
              Top = 43
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 606
              ExplicitTop = 43
            end
            inherited cxDBTimeEdit1: TcxDBTimeEdit
              Left = 637
              Top = 43
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 637
              ExplicitTop = 43
              ExplicitHeight = 23
            end
            inherited cxLabel8: TcxLabel
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
            end
            inherited cxDBMemo1: TcxDBMemo
              Left = 111
              Top = 73
              ExplicitLeft = 111
              ExplicitTop = 73
              ExplicitWidth = 618
              Width = 618
            end
            inherited cxLabel9: TcxLabel
              Top = 119
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitTop = 119
            end
            inherited cxDBTextEdit2: TcxDBTextEdit
              Left = 107
              Top = 122
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 107
              ExplicitTop = 122
              ExplicitHeight = 23
            end
            inherited cxLabel10: TcxLabel
              Top = 148
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitTop = 148
            end
            inherited cxDBMemo2: TcxDBMemo
              Left = 107
              Top = 153
              ParentFont = False
              Style.Font.Charset = RUSSIAN_CHARSET
              Style.IsFontAssigned = True
              ExplicitLeft = 107
              ExplicitTop = 153
              ExplicitWidth = 622
              ExplicitHeight = 34
              Height = 34
              Width = 622
            end
          end
          inherited IBCQueryCities: TIBCQuery
            Left = 448
            Top = 96
          end
          inherited IBCDataSourceCities: TIBCDataSource
            Left = 152
            Top = 8
          end
          inherited dxBarManager1: TdxBarManager
            Left = 120
            Top = 144
            PixelsPerInch = 96
            inherited bbModifyDelivery: TdxBarButton
              ShortCut = 115
            end
            inherited bbSaveDelivery: TdxBarButton
              ShortCut = 16467
            end
            inherited bbPrint: TdxBarButton
              ShortCut = 49232
            end
          end
          inherited IBCQueryDelivery: TIBCQuery
            SQLInsert.Strings = (
              'INSERT INTO VW_TDB_DOCS_DELIVERY'
              
                '  (DOCID, COURIERID, COURIER_NAME, DELIVERY_ADDRESS, DELIVERY_TI' +
                'ME, DELIVERY_DATE, '
              
                '   FLG_CASHONDELIVERY, FLG_INVOICE_ONDELIVERY, FLG_POS_TERMINAL,' +
                ' FLG_CREDIT, FLG_RAMBURS,'
              
                '   TRANSMIS_CURIER, AWB, DRIVERID, DRIVER_NAME, DISTRICTID, DIST' +
                'RICT_NAME, CITYID, CITY_NAME, '
              '   COMMENTS, STATEID, STATE_NAME, PHONE_NUMBER)'
              'VALUES'
              
                '  (:DOCID, :COURIERID, :COURIER_NAME, :DELIVERY_ADDRESS, :DELIVE' +
                'RY_TIME, :DELIVERY_DATE, '
              
                '   :FLG_CASHONDELIVERY, :FLG_INVOICE_ONDELIVERY, :FLG_POS_TERMIN' +
                'AL, :FLG_CREDIT, :FLG_RAMBURS, '
              
                '   :TRANSMIS_CURIER, :AWB, :DRIVERID, :DRIVER_NAME, :DISTRICTID,' +
                ' :DISTRICT_NAME, :CITYID, :CITY_NAME, '
              '   :COMMENTS, :STATEID, :STATE_NAME, :PHONE_NUMBER)')
            SQLUpdate.Strings = (
              'UPDATE VW_TDB_DOCS_DELIVERY'
              'SET'
              '  DOCID = :DOCID, '
              '  COURIERID = :COURIERID, '
              '  COURIER_NAME = :COURIER_NAME, '
              '  DELIVERY_ADDRESS = :DELIVERY_ADDRESS, '
              '  DELIVERY_TIME = :DELIVERY_TIME, '
              '  DELIVERY_DATE = :DELIVERY_DATE, '
              '  FLG_CASHONDELIVERY = :FLG_CASHONDELIVERY, '
              '  FLG_INVOICE_ONDELIVERY = :FLG_INVOICE_ONDELIVERY, '
              '  FLG_POS_TERMINAL = :FLG_POS_TERMINAL, '
              '  FLG_CREDIT = :FLG_CREDIT, '
              '  FLG_RAMBURS = :FLG_RAMBURS, '
              '  TRANSMIS_CURIER = :TRANSMIS_CURIER, '
              '  AWB = :AWB, '
              '  DRIVERID = :DRIVERID, '
              '  DRIVER_NAME = :DRIVER_NAME, '
              '  DISTRICTID = :DISTRICTID, '
              '  DISTRICT_NAME = :DISTRICT_NAME, '
              '  CITYID = :CITYID, '
              '  CITY_NAME = :CITY_NAME, '
              '  COMMENTS = :COMMENTS, '
              '  STATEID = :STATEID, '
              '  STATE_NAME = :STATE_NAME, '
              '  PHONE_NUMBER = :PHONE_NUMBER'
              'WHERE'
              '  DOCID = :Old_DOCID')
            SQLRefresh.Strings = (
              'SELECT * FROM VW_TDB_DOCS_DELIVERY'
              'WHERE'
              '  DOCID = :DOCID')
          end
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
    CanCustomize = False
    Categories.Strings = (
      'PopupDoc'
      'Goods'
      'Complect'
      'Files'
      'cashback')
    Categories.ItemsVisibles = (
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
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 144
    Top = 78
    PixelsPerInch = 96
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
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbShowSerialDialog'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbActiuni'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSubItemsPriceColumns'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem5'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem4'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSelectSupplier'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbActionPKO: TdxBarButton
      Caption = 'Ordin de incasare in numerar...'#13#10
      Category = 0
      Hint = 'Ordin de incasare in numerar'#13#10
      Visible = ivAlways
      ShortCut = 32841
      OnClick = bbActionPKOClick
    end
    object bbActionRKO: TdxBarButton
      Caption = 'Ordin de plata in numerar'
      Category = 0
      Hint = 'Ordin de plata in numerar'
      Visible = ivAlways
      ShortCut = 32847
      OnClick = bbActionRKOClick
    end
    object bbActionSNS: TdxBarButton
      Caption = 'Asamblare'
      Category = 0
      Hint = 'Asamblare'
      Visible = ivAlways
      ShortCut = 24659
      OnClick = bbActionSNSClick
    end
    object bbActionVSF: TdxBarButton
      Caption = 'Factura fiscala'
      Category = 0
      Hint = 'Factura fiscala'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 122
      OnClick = bbActionVSFClick
    end
    object bbActionStartEnterSerials: TdxBarButton
      Caption = 'Blocarea documentului pentru introducerea seriilor si partidelor'
      Category = 0
      Hint = 'Blocarea documentului pentru introducerea seriilor si partidelor'
      Visible = ivNever
      ImageIndex = 30
      OnClick = bbActionStartEnterSerialsClick
    end
    object bbPrintWarranty: TdxBarButton
      Caption = 'Tipar garantie...'
      Category = 0
      Hint = 'Tipar garantie'
      Visible = ivAlways
      ImageIndex = 28
      ShortCut = 24656
      OnClick = bbPrintWarrantyClick
    end
    object bbBringGoods: TdxBarButton
      Caption = 'Mesaj "Aduceti marfa din depozit"'
      Category = 0
      Hint = 'Mesaj "Aduceti marfa din depozit"'
      Visible = ivAlways
      OnClick = bbBringGoodsClick
    end
    object bbCustomerDebts: TdxBarButton
      Caption = 'Creante si datorii'
      Category = 0
      Hint = 'Creante si datorii'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object bbCalcProfitability: TdxBarButton
      Caption = 'Calcul rentabilitate'
      Category = 0
      Hint = 'Calcul rentabilitate'
      Visible = ivAlways
      ShortCut = 16466
      OnClick = bbCalcProfitabilityClick
    end
    object bbGotoParentDoc: TdxBarButton
      Caption = 'Treci la documentul parinte'
      Category = 0
      Hint = 'Treci la documentul parinte'
      Visible = ivAlways
      ShortCut = 32805
      OnClick = bbGotoParentDocClick
    end
    object bbActiuneTVA: TdxBarButton
      Caption = 'actiunea "TVA '#238'napoi"...'
      Category = 0
      Hint = 'actiunea "TVA '#238'napoi"'
      Visible = ivNever
      OnClick = bbActiuneTVAClick
    end
    object bbDebtsNotify: TdxBarButton
      Caption = 'Alerta despre datoria nestinsa'
      Category = 0
      Hint = 'Alerta despre datoria nestinsa'
      Visible = ivAlways
      OnClick = bbDebtsNotifyClick
    end
    object bbApplyPromoCode: TdxBarButton
      Caption = 'cod discount...'
      Category = 0
      Hint = 'cod discount'
      Visible = ivNever
      OnClick = bbApplyPromoCodeClick
    end
    object bbActiuni: TdxBarSubItem
      Caption = 'actiuni'
      Category = 0
      Visible = ivAlways
      ImageIndex = 3
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbActiuneTVA'
        end
        item
          Visible = True
          ItemName = 'bbVoucherGift'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbApplyPromoCode'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbWinterPromoCode'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCodeActiune'
        end
        item
          Visible = True
          ItemName = 'bbApplyCashback'
        end>
    end
    object bbWinterPromoCode: TdxBarButton
      Caption = 'promo-cod Anul Nou...'
      Category = 0
      Hint = 'promo-cod Anul Nou'
      Visible = ivNever
      OnClick = bbWinterPromoCodeClick
    end
    object bbDocComments: TdxBarButton
      Caption = 'Mentiuni'
      Category = 0
      Hint = 'Mentiuni'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbCodeActiune: TdxBarButton
      Caption = 'Cod pentru actiune...'
      Category = 0
      Hint = 'Cod pentru actiune'
      Visible = ivAlways
      ImageIndex = 3
      OnClick = bbCodeActiuneClick
    end
    object bbChangeColumnPrice: TdxBarButton
      Tag = 9
      Caption = 'grila clientului...'
      Category = 0
      Hint = 'grila clientului'
      Visible = ivAlways
      ImageIndex = 49
      PaintStyle = psCaptionGlyph
      OnClick = bbChangeColumnPriceClick
    end
    object bbCreateProformaInvoice: TdxBarButton
      Caption = 'Proforma'
      Category = 0
      Hint = 'Proforma'
      Visible = ivAlways
      ShortCut = 32848
      OnClick = bbCreateProformaInvoiceClick
    end
    object bbCreateCec: TdxBarButton
      Caption = 'Tipar bon de '
      Category = 0
      Hint = 'Tipar bon de '
      Visible = ivAlways
      ImageIndex = 47
      ShortCut = 24642
      OnClick = bbCreateCecClick
    end
    object bbCheckStock: TdxBarButton
      Caption = 'refresh stoc'
      Category = 0
      Hint = 'refresh stoc'
      Visible = ivAlways
      ImageIndex = 38
      PaintStyle = psCaptionGlyph
      ShortCut = 16500
      OnClick = bbCheckStockClick
    end
    object bbTTN: TdxBarButton
      Caption = #1042#1099#1087#1080#1089#1072#1090#1100' '#1090#1086#1074#1072#1088#1086'-'#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102'...'
      Category = 0
      Hint = #1042#1099#1087#1080#1089#1072#1090#1100' '#1090#1086#1074#1072#1088#1086'-'#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102
      Visible = ivNever
      OnClick = bbTTNClick
    end
    object bbSubItemsPriceColumns: TdxBarSubItem
      Caption = 'grila de preturi'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbChangeColumnPrice'
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
      Category = 0
      Hint = 'Pret online'
      Visible = ivAlways
      ShortCut = 32817
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol2: TdxBarButton
      Tag = 2
      Caption = '2 grila...'
      Category = 0
      Enabled = False
      Hint = '2 grila'
      Visible = ivAlways
      ShortCut = 16434
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol3: TdxBarButton
      Tag = 3
      Caption = '3 grila...'
      Category = 0
      Enabled = False
      Hint = '3 grila'
      Visible = ivAlways
      ShortCut = 16435
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol4: TdxBarButton
      Tag = 4
      Caption = '4 grila...'
      Category = 0
      Enabled = False
      Hint = '4 grila'
      Visible = ivAlways
      ShortCut = 16436
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol5: TdxBarButton
      Tag = 5
      Caption = 'Pret - discount card'
      Category = 0
      Hint = 'Pret - discount card'
      Visible = ivAlways
      ShortCut = 32821
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol6: TdxBarButton
      Tag = 6
      Caption = 'Pret - diler'
      Category = 0
      Hint = 'Pret - diler'
      Visible = ivAlways
      ShortCut = 32822
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol7: TdxBarButton
      Tag = 7
      Caption = '7 grila...'
      Category = 0
      Enabled = False
      Hint = '7 grila'
      Visible = ivAlways
      ShortCut = 16439
      OnClick = bbChangeColumnPriceClick
    end
    object bbPriceCol0: TdxBarButton
      Caption = 'pret intrare...'
      Category = 0
      Hint = 'pret intrare'
      Visible = ivAlways
      OnClick = bbChangeColumnPriceClick
    end
    object bbGoodsForeignCode: TdxBarButton
      Caption = 'Racordarea codurilor produselor interne la codurile furnizorilor'
      Category = 0
      Hint = 'Codurile produselor de la furnizori'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCodeClick
    end
    object bbFLG_DOC_SALARY: TdxBarButton
      Caption = 'Acest document nu participa la calculul salariului'
      Category = 0
      Hint = 'Acest document nu participa la calculul salariului'
      Visible = ivAlways
      ImageIndex = 49
      OnClick = bbFLG_DOC_SALARYClick
    end
    object bbChangeDocUser: TdxBarButton
      Caption = 'Schimba utilizatorul documentului'
      Category = 0
      Hint = 'Schimba utilizatorul documentului'
      Visible = ivAlways
      OnClick = bbChangeDocUserClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Reaminteste de sunat clientul...'
      Category = 0
      Hint = 'Reaminteste de sunat clientul'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Cerere de livrare'
      Category = 0
      Hint = 'Cerere de livrare'
      Visible = ivAlways
      ShortCut = 24652
      OnClick = dxBarButton2Click
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Creaza document nou...'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbActionPKO'
        end
        item
          Visible = True
          ItemName = 'bbActionRKO'
        end
        item
          Visible = True
          ItemName = 'bbBankIn'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCreateProformaInvoice'
        end
        item
          Visible = True
          ItemName = 'bbActionVSF'
        end
        item
          Visible = True
          ItemName = 'bbActionSNS'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton2'
        end>
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbCustomerDebts'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'bbDebtsNotify'
        end
        item
          Visible = True
          ItemName = 'bbChangeDocUser'
        end
        item
          Visible = True
          ItemName = 'bbCalcProfitability'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end>
    end
    object dxBarSubItem3: TdxBarSubItem
      Caption = 'Tipar'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbCreateCec'
        end
        item
          Visible = True
          ItemName = 'bbPrintWarranty'
        end>
    end
    object bbApplyCashback: TdxBarButton
      Caption = 'Aplica cashback'
      Category = 0
      Hint = 'Aplica cashback'
      Visible = ivAlways
      OnClick = bbApplyCashbackClick
    end
    object bbBankIn: TdxBarButton
      Caption = 'Ordin de incasare bancar'
      Category = 0
      Hint = 'Ordin de incasare bancar'
      Visible = ivAlways
      OnClick = bbBankInClick
    end
    object bbVoucherGift: TdxBarButton
      Caption = 'Validare "Voucher Cadou"'
      Category = 0
      Hint = 'Validare "Voucher Cadou"'
      Visible = ivAlways
      ShortCut = 49238
      OnClick = bbVoucherGiftClick
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Reinoieste soldul produselor'
      Category = 0
      Hint = 'Reinoieste soldul produselor'
      Visible = ivAlways
      ShortCut = 24658
      OnClick = dxBarButton3Click
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Adauga livrare Chisinau'
      Category = 0
      Hint = 'Adauga livrare Chisinau'
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
      OnClick = dxBarButton4Click
    end
    object dxBarSubItem4: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          Visible = True
          ItemName = 'bbAddToSupplier'
        end>
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Lista produse pentru partener'
      Category = 0
      Hint = 'Lista produse pentru partener'
      Visible = ivAlways
      OnClick = dxBarButton5Click
    end
    object bbAddToSupplier: TdxBarButton
      Caption = 'Adauga in cont de achizitie'
      Category = 0
      Hint = 'Adauga in cont de achizitie'
      Visible = ivAlways
      ShortCut = 32849
      OnClick = bbAddToSupplierClick
    end
    object bbVindutPrinPartener: TdxBarButton
      Caption = 'Vindut prin partener'
      Category = 0
      Hint = 'Vindut prin partener'
      Visible = ivAlways
      OnClick = bbVindutPrinPartenerClick
    end
    object bbDocumentTree: TdxBarButton
      Caption = 'Ierarhia documentului'
      Category = 0
      Hint = 'Ierarhia documentului'
      Visible = ivAlways
      OnClick = bbDocumentTreeClick
    end
    object bbSelectSupplier: TdxBarButton
      Caption = 'Alege furnizorul'
      Category = 0
      Hint = 'Alege furnizorul'
      Visible = ivAlways
      DropDownMenu = frmSelectGoodsToAddDlg.dxBarPopupMenu1
      OnClick = bbSelectSupplierClick
    end
    object dxBarSubItem5: TdxBarSubItem
      Caption = 'Livrare'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'dxBarButton6'
        end>
    end
    object dxBarButton6: TdxBarButton
      Caption = 'Adauga livrare Moldova'
      Category = 0
      Hint = 'Adauga livrare Moldova'
      Visible = ivAlways
      OnClick = dxBarButton6Click
    end
    object bbNewGoods: TdxBarButton
      Caption = 'produs nou'
      Category = 1
      Hint = 'produs nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewGoodsClick
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
      OnClick = bbRemoveGoodsClick
    end
    object bbShowSerialDialog: TdxBarButton
      Caption = 'serii/partide'
      Category = 1
      Hint = 'serii/partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbShowSerialDialogClick
    end
    object bbGoodsChangeUser: TdxBarButton
      Caption = 'Modifica utilizator'
      Category = 1
      Hint = 'Modifica utilizator'
      Visible = ivAlways
      ImageIndex = 10
      OnClick = bbGoodsChangeUserClick
    end
    object bbGoodsPrice: TdxBarButton
      Caption = 'Modifica preturi produse'
      Category = 1
      Hint = 'Modifica preturi produse'
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbGoodsPriceClick
    end
    object bbGoodsInfoCard: TdxBarButton
      Caption = 'Miscarea de marfa'
      Category = 1
      Hint = 'Miscarea de marfa'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsInfoCardClick
    end
    object bbCashbackNew: TdxBarButton
      Caption = 'Nou'
      Category = 4
      Hint = 'Nou'
      Visible = ivAlways
    end
    object bbCashbackEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 4
      Hint = 'Modifica'
      Visible = ivAlways
    end
    object bbCashbackDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 4
      Hint = 'Sterge'
      Visible = ivAlways
    end
    object bbSendSMS: TdxBarButton
      Caption = 'Trimite SMS'
      Category = 4
      Hint = 'Trimite SMS'
      Visible = ivAlways
    end
  end
  object pmPopupMenuDocs: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarSubItem1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarSubItem3'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarSubItem2'
      end
      item
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        Visible = True
        ItemName = 'bbBringGoods'
      end
      item
        Visible = True
        ItemName = 'bbVindutPrinPartener'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbFLG_DOC_SALARY'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGotoParentDoc'
      end
      item
        Visible = True
        ItemName = 'bbDocumentTree'
      end>
    UseOwnFont = False
    OnPopup = pmPopupMenuDocsPopup
    Left = 42
    Top = 77
    PixelsPerInch = 96
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
    Left = 259
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
        Visible = True
        ItemName = 'bbAddToSupplier'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbShowSerialDialog'
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
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGoodsChangeUser'
      end>
    UseOwnFont = False
    Left = 400
    Top = 228
    PixelsPerInch = 96
  end
  object cxGridPopupmMenuComponents: TcxGridPopupMenu
    PopupMenus = <
      item
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = ppJurnal
      end>
    Left = 257
    Top = 132
  end
  object IBCQueryCashback: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from vw_tdb_docs_cashback'
      'where docid = :docid')
    Left = 648
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end>
  end
  object IBCDataSourceCashback: TIBCDataSource
    DataSet = IBCQueryCashback
    Left = 544
    Top = 224
  end
end
