inherited frame28NakladnieRNS: Tframe28NakladnieRNS
  Font.Height = -15
  PixelsPerInch = 120
  object cxGridNPN: TcxGrid
    Left = 0
    Top = 0
    Width = 789
    Height = 200
    Align = alClient
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
      DataController.DataSource = dmDB.IBCDataSourceDocs
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
      OptionsView.NavigatorOffset = 63
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssNone
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
      object cxGridNPNTable_FLG_CLOSED: TcxGridDBColumn
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
        Options.HorzSizing = False
        Width = 20
        IsCaptionAssigned = True
      end
      object cxGridNPNTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridNPNTableData: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
      end
      object cxGridNPNTableWarehouse: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        Width = 149
      end
      object cxGridNPNTableCtName: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 200
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 299
      end
      object cxGridNPNTableSuma: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridNPNTableCurrencyName: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridNPNTableVAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridNPNTableRate: TcxGridDBColumn
        Caption = 'Rata doc.'
        DataBinding.FieldName = 'RATE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridNPN_RATEUSD: TcxGridDBColumn
        Caption = 'Rata $'
        DataBinding.FieldName = 'RATEUSD'
        HeaderAlignmentHorz = taCenter
        Width = 76
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
      object cxGridNPNTableFlgACNT: TcxGridDBColumn
        Caption = 'Contab'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridNPNTableCreatedBy: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 188
      end
      object cxGridNPNTable_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridNPNTable_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridNPNLevel: TcxGridLevel
      GridView = cxGridNPNTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 200
    Width = 789
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 200
    Control = pnBottom
  end
  object pnBottom: TPanel
    Left = 0
    Top = 210
    Width = 789
    Height = 324
    Align = alBottom
    Caption = 'pnBottom'
    TabOrder = 2
    object cxPageControl1: TcxPageControl
      Left = 1
      Top = 1
      Width = 787
      Height = 322
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = tbGoods
      Properties.CustomButtons.Buttons = <>
      Properties.TabPosition = tpBottom
      ClientRectBottom = 290
      ClientRectLeft = 4
      ClientRectRight = 783
      ClientRectTop = 4
      object tbGoods: TcxTabSheet
        Caption = 'Produse (&1)'
        ImageIndex = 0
        ExplicitLeft = 5
        ExplicitTop = 5
        ExplicitWidth = 776
        ExplicitHeight = 284
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 34
          Width = 779
          Height = 252
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          ExplicitTop = 38
          ExplicitWidth = 776
          ExplicitHeight = 246
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
            Styles.Footer = dmAdditions.cxStyle_GridHeader
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = 'Depozit'
              DataBinding.FieldName = 'DTDEP_NAME'
              MinWidth = 140
              Options.HorzSizing = False
              Width = 140
            end
            object cxGridDBCol_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
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
                  ImageIndex = 44
                  Value = 4203
                end>
              MinWidth = 26
              Options.Editing = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.ShowCaption = False
              Options.Sorting = False
              VisibleForCustomization = False
              Width = 26
              IsCaptionAssigned = True
            end
            object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
              Caption = 'Denumire'
              DataBinding.FieldName = 'GOODS_NAME'
              Width = 200
            end
            object cxGridDBCol_QTY: TcxGridDBColumn
              Caption = 'Cant'
              DataBinding.FieldName = 'QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridDBCol_UM_NAME: TcxGridDBColumn
              Caption = 'UM'
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
              Caption = 'Pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridDBCol_SUMA: TcxGridDBColumn
              Caption = 'Suma'
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
              Caption = 'TVA'
              DataBinding.FieldName = 'SUMAVAT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              Visible = False
              VisibleForCustomization = False
            end
            object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
              Caption = 'Activ'
              DataBinding.FieldName = 'FLG_ACTIVE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridDBCol_FLG_READY: TcxGridDBColumn
              Caption = 'Gata'
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
              Caption = 'Sold'
              DataBinding.FieldName = 'STOCK_QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = 'Cont contab'
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = 'Denumire facturi'
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              MinWidth = 50
              Width = 70
            end
            object cxGridComponents_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
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
          Width = 779
          Height = 34
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
          ExplicitWidth = 776
        end
      end
      object tbFiles: TcxTabSheet
        Caption = 'Scan (&2)'
        ImageIndex = 1
        ExplicitLeft = 5
        ExplicitTop = 5
        ExplicitWidth = 776
        ExplicitHeight = 284
        object cxGridFiles: TcxGrid
          Left = 0
          Top = 32
          Width = 779
          Height = 254
          Align = alClient
          TabOrder = 1
          ExplicitTop = 35
          ExplicitWidth = 776
          ExplicitHeight = 249
          object cxGridFilesTable: TcxGridDBTableView
            DataController.DataSource = IBCDataSourceFiles
            DataController.KeyFieldNames = 'ATTID'
            FilterRow.SeparatorWidth = 8
            FixedDataRows.SeparatorWidth = 8
            NewItemRow.SeparatorWidth = 8
            OptionsCustomize.ColumnFiltering = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.InvertSelect = False
            OptionsView.NavigatorOffset = 63
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.FixedColumnSeparatorWidth = 3
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.LeftIndent = 25
            Preview.RightIndent = 6
            RowLayout.MinValueWidth = 100
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridFiles_IMG: TcxGridDBColumn
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.DefaultImageIndex = 22
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <>
              MinWidth = 24
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridFiles_DATA: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'DATA'
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridFiles_FILENAME: TcxGridDBColumn
              Caption = 'File'
              DataBinding.FieldName = 'FILENAME'
              Width = 300
            end
            object cxGridFiles_FILESIZE: TcxGridDBColumn
              Caption = 'Marime'
              DataBinding.FieldName = 'FILESIZE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
            object cxGridFiles_CREATED_BY_NAME: TcxGridDBColumn
              Caption = 'Utilizator'
              DataBinding.FieldName = 'CREATED_BY_NAME'
              Width = 100
            end
          end
          object cxGridFilesLevel: TcxGridLevel
            GridView = cxGridFilesTable
          end
        end
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 779
          Height = 32
          Align = dalTop
          BarManager = dxBarManager
          ExplicitWidth = 776
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
      'PopupDoc'
      'Goods'
      'PopupCOMPONENTS'
      'Scans')
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
    Left = 39
    Top = 80
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
          Visible = True
          ItemName = 'dxBarSubItem1'
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
          ItemName = 'bbShowSerialDialog'
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
    object dxBarManagerBar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Complect'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 949
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
    object dxBarManagerBar1: TdxBar
      Caption = 'Scans'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 473
      FloatTop = 649
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewFile'
        end
        item
          Visible = True
          ItemName = 'bbDeleteFile'
        end
        item
          Visible = True
          ItemName = 'bbSaveAs'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbActionRKO: TdxBarButton
      Caption = 'Dispozitie de plata casa'
      Category = 0
      Hint = 'Dispozitie de plata casa'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbActionRKOClick
    end
    object bbActionOtgruziti: TdxBarButton
      Caption = 'Inchide document'
      Category = 0
      Hint = 'Inchide document'
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbActionOtgruzitiClick
    end
    object bbActionVSF: TdxBarButton
      Caption = 'Elibereaza Factura Fiscala...'
      Category = 0
      Hint = 'Elibereaza Factura Fiscala'
      Visible = ivAlways
      OnClick = bbActionVSFClick
    end
    object bbOpenDoc: TdxBarButton
      Caption = 'Deschide document'
      Category = 0
      Hint = 'Deschide document'
      Visible = ivAlways
      OnClick = bbOpenDocClick
    end
    object bbCustomerDebts: TdxBarButton
      Caption = 'Datoriile clientului...'
      Category = 0
      Hint = 'Datoriile clientului'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerDebtsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = #1042#1099#1087#1080#1089#1072#1090#1100' '#1058#1058#1053
      Category = 0
      Hint = #1042#1099#1087#1080#1089#1072#1090#1100' '#1058#1058#1053
      Visible = ivAlways
      OnClick = dxBarButton1Click
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
      Caption = '1 grila...'
      Category = 0
      Hint = '1 grila'
      Visible = ivAlways
      ShortCut = 32817
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol2: TdxBarButton
      Tag = 2
      Caption = '2 grila...'
      Category = 0
      Hint = '2 grila'
      Visible = ivAlways
      ShortCut = 16434
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol3: TdxBarButton
      Tag = 3
      Caption = '3 grila...'
      Category = 0
      Hint = '3 grila'
      Visible = ivAlways
      ShortCut = 16435
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol4: TdxBarButton
      Tag = 4
      Caption = '4 grila...'
      Category = 0
      Hint = '4 grila'
      Visible = ivAlways
      ShortCut = 16436
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol5: TdxBarButton
      Tag = 5
      Caption = '5 grila...'
      Category = 0
      Hint = '5 grila'
      Visible = ivAlways
      ShortCut = 32821
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol6: TdxBarButton
      Tag = 6
      Caption = '6 grila...'
      Category = 0
      Hint = '6 grila'
      Visible = ivAlways
      ShortCut = 32822
      OnClick = bbPriceCol0Click
    end
    object bbPriceCol7: TdxBarButton
      Tag = 7
      Caption = '7 grila...'
      Category = 0
      Hint = '7 grila'
      Visible = ivAlways
      ShortCut = 16439
      OnClick = bbPriceCol0Click
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
      Caption = 'Modifica preturile'
      Category = 0
      Hint = 'Modifica preturile'
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbGoodsPriceClick
    end
    object bbGoodsForeignCode: TdxBarButton
      Caption = 'Coduri produse furnizori'
      Category = 0
      Hint = 'Coduri produse furnizori'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCodeClick
    end
    object bbSelectFromSell: TdxBarButton
      Caption = 'Selecteaza din "Vinzari"'
      Category = 0
      Hint = 'Selecteaza din "Vinzari"'
      Visible = ivAlways
      OnClick = bbSelectFromSellClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Nou'
      Category = 0
      Visible = ivAlways
      ImageIndex = 40
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewGoods'
        end
        item
          Visible = True
          ItemName = 'bbSelectFromSell'
        end>
    end
    object bbNewGoods: TdxBarButton
      Caption = 'Produs nou'
      Category = 1
      Hint = 'Produs nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewGoodsClick
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
    object bbRemoveGoods: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbRemoveGoodsClick
    end
    object bbShowSerialDialog: TdxBarButton
      Caption = 'Numere de serii/partide'
      Category = 1
      Hint = 'Numere de serii/partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbShowSerialDialogClick
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
    object bbDeleteFile: TdxBarButton
      Caption = 'Sterge'
      Category = 3
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 2
      PaintStyle = psCaptionGlyph
      OnClick = bbDeleteFileClick
    end
    object bbSaveAs: TdxBarButton
      Caption = 'Salveaza...'
      Category = 3
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
      PaintStyle = psCaptionGlyph
      OnClick = bbSaveAsClick
    end
  end
  object pmPopupMenuDocs: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbActionRKO'
      end
      item
        Visible = True
        ItemName = 'bbActionVSF'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbActionOtgruziti'
      end
      item
        Visible = True
        ItemName = 'bbOpenDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCustomerDebts'
      end>
    UseOwnFont = False
    Left = 220
    Top = 128
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
    Left = 56
    Top = 164
  end
  object dxBarPopupMenuCOMPONENTS: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbModifyGoods'
      end
      item
        Visible = True
        ItemName = 'bbRemoveGoods'
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
      end>
    UseOwnFont = False
    Left = 400
    Top = 120
    PixelsPerInch = 120
  end
  object cxGridPopupMenuCOMPONENTS: TcxGridPopupMenu
    PopupMenus = <
      item
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuCOMPONENTS
      end>
    Left = 224
    Top = 312
  end
  object IBCDataSourceFiles: TIBCDataSource
    DataSet = IBCQueryFiles
    Left = 749
    Top = 528
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
    Left = 745
    Top = 471
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
end
