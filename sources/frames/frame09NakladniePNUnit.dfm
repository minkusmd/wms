inherited frame09NakladniePN: Tframe09NakladniePN
  Width = 1225
  Height = 608
  Margins.Left = 3
  Margins.Top = 3
  Margins.Right = 3
  Margins.Bottom = 3
  Font.Height = -12
  ExplicitWidth = 1225
  ExplicitHeight = 608
  object cxGridNPN: TcxGrid
    Left = 0
    Top = 0
    Width = 1225
    Height = 344
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridNPNTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenuDoc
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
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '0.00'
          Kind = skSum
          Column = cxGridNPN_SUMA_MDL
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0.00'
          Kind = skSum
          Column = cxGridNPN_SUMA_MDL
        end>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsView.CellEndEllipsis = True
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridNPN_FLG_CLOSED: TcxGridDBColumn
        AlternateCaption = #1047#1072#1082#1088#1099#1090
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
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
        MinWidth = 14
        Options.HorzSizing = False
        Width = 14
        IsCaptionAssigned = True
      end
      object cxGridNPNTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridNPN_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridNPN_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridNPN_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 26
        Width = 63
      end
      object cxGridNPNTableCT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 13
      end
      object cxGridNPN_CT_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 38
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 127
      end
      object cxGridNPN_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 45
      end
      object cxGridNPN_SUMA_MDL: TcxGridDBColumn
        Caption = 'Suma, MDL'
        DataBinding.ValueType = 'Float'
        DataBinding.Expression = #1'IF([Valuta]<>498,([Suma]*[Curs doc]),[Suma])'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 13
      end
      object cxGridNPN_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridNPNTableVAT: TcxGridDBColumn
        Caption = #1053#1044#1057
        DataBinding.FieldName = 'VAT'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 45
      end
      object cxGridNPN_RATE: TcxGridDBColumn
        Caption = 'Curs doc'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 38
        Options.HorzSizing = False
        Width = 38
      end
      object cxGridNPNTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxGridNPN_RATEUSD: TcxGridDBColumn
        Caption = 'Curs $'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 38
        Options.HorzSizing = False
        Width = 38
      end
      object cxGridNPNTableFlgACNT: TcxGridDBColumn
        Caption = 'Cnt'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 26
        Options.HorzSizing = False
        Width = 26
      end
      object cxGridNPN_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 38
        Width = 63
      end
      object cxGridNPN_SC2_NAME: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'SC2_NAME'
        MinWidth = 51
        Width = 64
      end
      object cxGridNPN_DTSC_NAME: TcxGridDBColumn
        Caption = #1040#1085#1072#1083#1080#1090' '#1089#1091#1073#1082#1086#1085#1090
        DataBinding.FieldName = 'DTSC_NAME'
        Visible = False
        MinWidth = 13
        Width = 51
      end
      object cxGridNPN_FLG_FACTURA_FISCALA: TcxGridDBColumn
        Caption = 'FF'
        DataBinding.FieldName = 'flg_factura_fiscala'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueGrayed = 0
        Properties.ValueUnchecked = '0'
        MinWidth = 15
        Options.HorzSizing = False
        Width = 15
      end
    end
    object cxGridNPNLevel: TcxGridLevel
      GridView = cxGridNPNTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 344
    Width = 1225
    Height = 8
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    DragThreshold = 2
    PositionAfterOpen = 19
    MinSize = 192
    Control = pnBottom
  end
  object pnBottom: TPanel
    Left = 0
    Top = 352
    Width = 1225
    Height = 256
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object cxPageControlGeneral: TcxPageControl
      Left = 0
      Top = 0
      Width = 1225
      Height = 256
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = tbsGoods
      Properties.CustomButtons.Buttons = <>
      Properties.Options = [pcoAlwaysShowGoDialogButton, pcoGradient, pcoGradientClientArea, pcoRedrawOnResize, pcoTopToBottomText]
      Properties.TabPosition = tpBottom
      ClientRectBottom = 230
      ClientRectLeft = 4
      ClientRectRight = 1221
      ClientRectTop = 4
      object tbsGoods: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Lista de marfa (&1)'
        ImageIndex = 0
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 30
          Width = 1217
          Height = 196
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object cxGridGoodsTable: TcxGridDBTableView
            PopupMenu = pmPopupMenuGoods
            OnKeyDown = cxGridGoodsTableKeyDown
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
            OnCellDblClick = cxGridGoodsTableCellDblClick
            OnCustomDrawCell = cxGridGoodsTableCustomDrawCell
            DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '0'
                Kind = skSum
                FieldName = 'QTY'
                Column = cxGridDBCol_QTY
              end
              item
                Kind = skSum
                FieldName = 'SUMA'
              end
              item
                Kind = skSum
                FieldName = 'SUMAVAT'
              end
              item
                Kind = skCount
                Column = cxGridDBCol_GOODSID
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = cxGridGoods_PRICE
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = cxGridGoods_SUMA
              end
              item
                Format = '#,##0.00'
                Kind = skSum
              end>
            OptionsBehavior.CopyCaptionsToClipboard = False
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
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = 'Depozit'
              DataBinding.FieldName = 'DTDEP_NAME'
              MinWidth = 96
              Options.HorzSizing = False
              Width = 96
            end
            object cxGridDBCol_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 51
              Options.HorzSizing = False
              Width = 51
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
            object cxGridGoodsTableColumn1: TcxGridDBColumn
              DataBinding.FieldName = 'FLG_PROMO'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.ilGoodsProperties
              Properties.Items = <
                item
                  Description = 'Promo'
                  ImageIndex = 6
                  Value = 1
                end>
              MinWidth = 19
              Options.HorzSizing = False
              Width = 19
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
              MinWidth = 51
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 51
            end
            object cxGridDBCol_UM_NAME: TcxGridDBColumn
              Caption = 'UM'
              DataBinding.FieldName = 'UM_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Sorting = False
              Width = 38
            end
            object cxGridGoods_PRICE: TcxGridDBColumn
              Caption = 'Pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridGoodsCOST: TcxGridDBColumn
              Caption = 'Cost'
              DataBinding.FieldName = 'COST'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.IncSearch = False
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridGoods_SUMA: TcxGridDBColumn
              Caption = 'Suma'
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
              Styles.Footer = dmAdditions.cxStyle_Bold
              Width = 64
            end
            object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
              Caption = 'Act'
              DataBinding.FieldName = 'FLG_ACTIVE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 30
              Options.HorzSizing = False
              Width = 30
            end
            object cxGridDBCol_FLG_ACNT: TcxGridDBColumn
              Caption = 'Cnt'
              DataBinding.FieldName = 'FLG_ACNT'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 30
              Options.HorzSizing = False
              Width = 30
            end
            object cxGridDBCol_FLG_READY: TcxGridDBColumn
              Caption = 'G'
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 19
              Options.HorzSizing = False
              Width = 19
            end
            object cxGridDBCol_WARRANTY: TcxGridDBColumn
              AlternateCaption = #1043#1072#1088#1072#1085#1090#1080#1103' '#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1103
              Caption = 'Grnt'
              DataBinding.FieldName = 'WARRANTY'
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.HorzSizing = False
              Width = 38
            end
            object cxGridGoods_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = 'Contab'
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.HorzSizing = False
              Styles.OnGetContentStyle = cxGridGoods_GOODS_ACNT_IDStylesGetContentStyle
              Width = 38
            end
            object cxGridGoods_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = 'Denumire facturi'
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              MinWidth = 32
              Styles.OnGetContentStyle = cxGridGoods_GOODS_ACNT_IDStylesGetContentStyle
              Width = 64
            end
            object cxGridComponents_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
              MinWidth = 13
              VisibleForCustomization = False
            end
          end
          object cxGridLevel: TcxGridLevel
            GridView = cxGridGoodsTable
          end
        end
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1217
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
      object tbsExpenses: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Cheltuieli (&2)'
        ImageIndex = 1
        object cxGridExpenses: TcxGrid
          Left = 0
          Top = 30
          Width = 1217
          Height = 196
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          ExplicitWidth = 982
          object cxGridExpensesTable: TcxGridDBTableView
            OnKeyDown = cxGridExpensesTableKeyDown
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
            OnCellDblClick = cxGridExpensesTableCellDblClick
            DataController.DataSource = IBCDataSourceExpenses
            DataController.KeyFieldNames = 'DOCID;EXPENSE_ID;EXPENSE_DOC_ID'
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                FieldName = 'QTY'
              end
              item
                Kind = skSum
                FieldName = 'SUMA'
              end
              item
                Kind = skSum
                FieldName = 'SUMAVAT'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = cxGridExpenses_EXPENSE_DOC_SUMA
              end
              item
                Kind = skCount
                Column = cxGridExpenses_NAME
              end
              item
                Kind = skSum
                Column = cxGridExpensesSuma_USD
              end>
            OptionsBehavior.CopyCaptionsToClipboard = False
            OptionsBehavior.IncSearch = True
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
            object cxGridExpenses_NAME: TcxGridDBColumn
              Caption = 'Denumirea'
              DataBinding.FieldName = 'EXPENSE_TITLE'
              MinWidth = 90
              Width = 112
            end
            object cxGridExpenses_CT_NAME: TcxGridDBColumn
              Caption = 'Client'
              DataBinding.FieldName = 'CT_NAME'
              MinWidth = 13
              Width = 128
            end
            object cxGridExpenses_EXPENSE_DOC_ID: TcxGridDBColumn
              Caption = 'Docid'
              DataBinding.FieldName = 'EXPENSE_DOC_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 51
              Options.HorzSizing = False
              Width = 51
            end
            object cxGridExpenses_EXPENSE_DOC_DOCTYPE_TITLE: TcxGridDBColumn
              Caption = 'Tip document'
              DataBinding.FieldName = 'EXPENSE_DOC_DOCTYPE_TITLE'
              MinWidth = 13
              Width = 64
            end
            object cxGridExpenses_EXPENSE_DOC_SUMA: TcxGridDBColumn
              Caption = 'Suma'
              DataBinding.FieldName = 'EXPENSE_DOC_SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 51
              Options.HorzSizing = False
              Styles.Footer = dmAdditions.cxStyle_Bold
              Width = 51
            end
            object cxGridExpenses_RATE: TcxGridDBColumn
              Caption = 'Curs'
              DataBinding.FieldName = 'EXPENSE_DOC_RATE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
            end
            object cxGridExpenses_EXPENSE_DOC_CURRENCY_NAME: TcxGridDBColumn
              Caption = 'Valuta'
              DataBinding.FieldName = 'EXPENSE_DOC_CURRENCY_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
            end
            object cxGridExpensesSuma_USD: TcxGridDBColumn
              Caption = 'Suma $'
              HeaderAlignmentHorz = taCenter
              MinWidth = 13
            end
            object cxGridExpenses_CURSDOC_USD: TcxGridDBColumn
              Caption = 'Curs $'
              HeaderAlignmentHorz = taCenter
              MinWidth = 13
            end
          end
          object cxGridExpensesLevel: TcxGridLevel
            GridView = cxGridExpensesTable
          end
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1217
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
      object tbsFiles: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Scanuri (&3)'
        ImageIndex = 1
        object cxGridFiles: TcxGrid
          Left = 0
          Top = 28
          Width = 1217
          Height = 198
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          ExplicitWidth = 982
          object cxGridFilesTable: TcxGridDBTableView
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
            object cxGridFiles_IMG: TcxGridDBColumn
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.DefaultImageIndex = 22
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <>
              MinWidth = 15
              Options.HorzSizing = False
              Width = 15
            end
            object cxGridFiles_DATA: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'DATA'
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridFiles_FILENAME: TcxGridDBColumn
              Caption = 'File'
              DataBinding.FieldName = 'FILENAME'
              MinWidth = 13
              Width = 192
            end
            object cxGridFiles_FILESIZE: TcxGridDBColumn
              Caption = 'Marime'
              DataBinding.FieldName = 'FILESIZE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 77
              Options.HorzSizing = False
              Width = 77
            end
            object cxGridFiles_CREATED_BY_NAME: TcxGridDBColumn
              Caption = 'Utilizator'
              DataBinding.FieldName = 'CREATED_BY_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 13
              Width = 64
            end
          end
          object cxGridFilesLevel: TcxGridLevel
            GridView = cxGridFilesTable
          end
        end
        object dxBarDockControl3: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1217
          Height = 28
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = dalTop
          BarManager = dxBarManager
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
      'Goods'
      'PopupMenuDocs'
      'Expenses'
      #1057#1082#1072#1085#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074)
    Categories.ItemsVisibles = (
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 696
    Top = 80
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Goods'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 3
      FloatTop = 386
      FloatClientWidth = 98
      FloatClientHeight = 100
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
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsDelete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsSerialPartNumbers'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
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
      Caption = 'Expenses'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 906
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbExpenseNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbExpenseModify'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbExpenseDelete'
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
      Caption = 'Scans'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1097
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewFile'
        end
        item
          Visible = True
          ItemName = 'bbFileDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbFileSaveAs'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbGoodsNew: TdxBarButton
      Caption = 'Produs nou'
      Category = 0
      Hint = 'Produs nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbGoodsNewClick
    end
    object bbGoodsModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbGoodsModifyClick
    end
    object bbGoodsDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbGoodsDeleteClick
    end
    object bbGoodsSerialPartNumbers: TdxBarButton
      Caption = 'Numere de serii / partide'
      Category = 0
      Hint = 'Numere de serii / partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbGoodsSerialPartNumbersClick
    end
    object bbExpenseNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbExpenseNewClick
    end
    object bbExpenseModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbExpenseModifyClick
    end
    object bbExpenseDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbExpenseDeleteClick
    end
    object bbCustomerDebts: TdxBarButton
      Caption = 'Creante...'
      Category = 0
      Hint = 'Creante'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object bbDocComments: TdxBarButton
      Caption = 'Comentarii'
      Category = 0
      Hint = 'Comentarii'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbGoodsForeignCode: TdxBarButton
      Caption = 'Produsele de la furnizori'
      Category = 0
      Hint = 'Produsele de la furnizori'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCodeClick
    end
    object bbGoodsInfoCard: TdxBarButton
      Caption = 'Miscarea produsului'
      Category = 0
      Hint = 'Miscarea produsului'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsInfoCardClick
    end
    object bbGoodsPrice: TdxBarButton
      Caption = 'Modifica preturile...'
      Category = 0
      Hint = 'Modifica preturile'
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbGoodsPriceClick
    end
    object bbImportAmb: TdxBarButton
      Caption = 'Importa...'
      Category = 0
      Hint = 'Importa'
      Visible = ivAlways
      ShortCut = 16457
      OnClick = bbImportAmbClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbImportDocument'
        end
        item
          Visible = True
          ItemName = 'bbAcntName'
        end>
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Seteaza toate pozitiile ca active'
      Category = 0
      Hint = 'Seteaza toate pozitiile ca active'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Treci la documentul parinte'
      Category = 0
      Hint = 'Treci la documentul parinte'
      Visible = ivAlways
      ShortCut = 32805
      OnClick = dxBarButton2Click
    end
    object bbActCasare: TdxBarButton
      Caption = 'Creaza "Act de casare" ...'
      Category = 0
      Hint = 'Creaza "Act de casare" '
      Visible = ivAlways
      OnClick = bbActCasareClick
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Imaginea produsului'
      Category = 0
      Hint = 'Imaginea produsului'
      Visible = ivAlways
      ShortCut = 16457
      OnClick = dxBarButton3Click
    end
    object bbImportDocument: TdxBarButton
      Caption = 'Importa din document'
      Category = 0
      Hint = 'Importa din document'
      Visible = ivAlways
      OnClick = bbImportDocumentClick
    end
    object bbRequestPayment: TdxBarButton
      Caption = 'Cerere de plata...'
      Category = 0
      Hint = 'Cerere de plata'
      Visible = ivAlways
      OnClick = bbRequestPaymentClick
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Creaza factura fiscala de intrare...'
      Category = 0
      Hint = 'Creaza factura fiscala de intrare'
      Visible = ivAlways
      ShortCut = 122
      OnClick = dxBarButton4Click
    end
    object bbCreateVanzarePrime: TdxBarButton
      Caption = 'Creaza vinzare multimpla catre Prime'
      Category = 0
      Hint = 'Creaza vinzare multimpla catre Prime'
      Visible = ivAlways
      OnClick = bbCreateVanzarePrimeClick
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Creaza vinzare in alta companie'
      Category = 0
      Hint = 'Creaza vinzare in alta companie'
      Visible = ivAlways
      OnClick = dxBarButton5Click
    end
    object bbAcntName: TdxBarButton
      Caption = 'Denumire factura'
      Category = 0
      Hint = 'Denumire factura'
      Visible = ivAlways
      ShortCut = 32834
      OnClick = bbAcntNameClick
    end
    object bbActionRashodniiKasoviiOrder: TdxBarButton
      Caption = 'Creaza "Dispozitie de plata din casa"'
      Category = 1
      Hint = 'Creaza "Dispozitie de plata din casa"'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbActionRashodniiKasoviiOrderClick
    end
    object bbActionPlatejnoePorucenie: TdxBarButton
      Caption = 'Creaza "Dispozitie de plata bancara"'
      Category = 1
      Hint = 'Creaza "Dispozitie de plata bancara"'
      Visible = ivAlways
      ShortCut = 16450
      OnClick = bbActionPlatejnoePorucenieClick
    end
    object bbNewFile: TdxBarButton
      Caption = 'Nou'
      Category = 3
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 0
      PaintStyle = psCaptionGlyph
      OnClick = bbNewFileClick
    end
    object bbFileDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 3
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 2
      OnClick = bbFileDeleteClick
    end
    object bbFileSaveAs: TdxBarButton
      Caption = 'Salveaza...'
      Category = 3
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
      PaintStyle = psCaptionGlyph
      OnClick = bbFileSaveAsClick
    end
  end
  object IBCQueryExpenses: TIBCQuery
    UpdatingTable = 'VW_TDB_DOCS_EXPENSES'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS_EXPENSES'
      '  (DOCID, EXPENSE_ID, EXPENSE_DOC_ID, MODIFIED_BY)'
      'VALUES'
      '  (:DOCID, :EXPENSE_ID, :EXPENSE_DOC_ID, :MODIFIED_BY)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DOCS_EXPENSES'
      'WHERE'
      ' DOCID = :DOCID '
      ' AND '
      ' EXPENSE_ID = :EXPENSE_ID '
      ' AND '
      ' EXPENSE_DOC_ID = :EXPENSE_DOC_ID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DOCS_EXPENSES'
      'SET'
      
        '  DOCID = :DOCID, EXPENSE_ID = :EXPENSE_ID, EXPENSE_DOC_ID = :EX' +
        'PENSE_DOC_ID, MODIFIED_BY = :MODIFIED_BY'
      'WHERE'
      ' DOCID = :Old_DOCID '
      ' AND '
      ' EXPENSE_ID = :Old_EXPENSE_ID '
      ' AND '
      ' EXPENSE_DOC_ID = :Old_EXPENSE_DOC_ID')
    SQLRefresh.Strings = (
      'SELECT'
      ' DOCID,'
      ' EXPENSE_ID,'
      ' EXPENSE_DOC_ID,'
      ' MODIFIED_BY,'
      ' EXPENSE_TITLE,'
      ' MODIFIED_BY_NAME,'
      ' EXPENSE_DOC_SUMA,'
      ' EXPENSE_DOC_CURRENCYID,'
      ' EXPENSE_DOC_RATE,'
      ' EXPENSE_DOC_CURRENCY_NAME,'
      ' EXPENSE_DOC_DOCTYPEID,'
      ' EXPENSE_DOC_DOCTYPE_TITLE'
      'FROM'
      ' VW_TDB_DOCS_EXPENSES'
      'WHERE'
      ' DOCID = :DOCID '
      ' AND '
      ' EXPENSE_ID = :EXPENSE_ID '
      ' AND '
      ' EXPENSE_DOC_ID = :EXPENSE_DOC_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TDB_DOCS_EXPENSES'
      'WHERE'
      ' DOCID = :Old_DOCID '
      ' AND '
      ' EXPENSE_ID = :Old_EXPENSE_ID '
      ' AND '
      ' EXPENSE_DOC_ID = :Old_EXPENSE_DOC_ID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT E.DOCID, E.EXPENSE_ID, CT, CT_NAME, E.EXPENSE_DOC_ID,'
      
        '       E.MODIFIED_BY, E.EXPENSE_TITLE, E.MODIFIED_BY_NAME, E.EXP' +
        'ENSE_DOC_SUMA,'
      
        '       E.EXPENSE_DOC_CURRENCYID, E.EXPENSE_DOC_RATE, E.EXPENSE_D' +
        'OC_CURRENCY_NAME,'
      '       E.EXPENSE_DOC_DOCTYPEID, E.EXPENSE_DOC_DOCTYPE_TITLE'
      'FROM VW_TDB_DOCS_EXPENSES E')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.BooleanDomainFields = True
    Left = 472
    Top = 132
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceExpenses: TIBCDataSource
    DataSet = IBCQueryExpenses
    Left = 472
    Top = 84
  end
  object pmPopupMenuGoods: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGoodsModify'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGoodsDelete'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGoodsSerialPartNumbers'
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
    Left = 69
    Top = 382
    PixelsPerInch = 96
  end
  object dxBarPopupMenuDoc: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbActionRashodniiKasoviiOrder'
      end
      item
        Visible = True
        ItemName = 'bbActionPlatejnoePorucenie'
      end
      item
        Visible = True
        ItemName = 'bbActCasare'
      end
      item
        Visible = True
        ItemName = 'bbRequestPayment'
      end
      item
        Visible = True
        ItemName = 'dxBarButton4'
      end
      item
        Visible = True
        ItemName = 'bbCreateVanzarePrime'
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
        ItemName = 'bbCustomerDebts'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbImportAmb'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton2'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuDocPopup
    Left = 77
    Top = 74
    PixelsPerInch = 96
  end
  object cxGridPopupMenuDOCS: TcxGridPopupMenu
    Grid = cxGridNPN
    PopupMenus = <
      item
        GridView = cxGridNPNTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuDoc
      end>
    Left = 207
    Top = 76
  end
  object cxGridPopupMenuGOODS: TcxGridPopupMenu
    Grid = cxGridComponents
    PopupMenus = <
      item
        GridView = cxGridGoodsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmPopupMenuGoods
      end>
    Left = 189
    Top = 382
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
    Options.DetailDelay = 100
    Left = 340
    Top = 84
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceFiles: TIBCDataSource
    DataSet = IBCQueryFiles
    Left = 336
    Top = 132
  end
end
