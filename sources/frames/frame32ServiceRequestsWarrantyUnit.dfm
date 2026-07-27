inherited frame32ServiceRequestsWarranty: Tframe32ServiceRequestsWarranty
  Font.Height = -15
  PixelsPerInch = 120
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 358
    Width = 986
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 300
    Control = pnBottom
  end
  object pnBottom: TPanel
    Left = 0
    Top = 368
    Width = 986
    Height = 300
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object pcPageControl: TcxPageControl
      Left = 0
      Top = 0
      Width = 986
      Height = 300
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = tbsGoods
      Properties.CustomButtons.Buttons = <>
      Properties.TabPosition = tpBottom
      ClientRectBottom = 268
      ClientRectLeft = 4
      ClientRectRight = 982
      ClientRectTop = 4
      object tbsGoods: TcxTabSheet
        Caption = 'Produse (&1)'
        ImageIndex = 0
        ExplicitHeight = 267
        object cxGridGoods: TcxGrid
          Left = 0
          Top = 34
          Width = 978
          Height = 230
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          ExplicitHeight = 233
          object cxGridGoodsTable: TcxGridDBTableView
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
                Format = '#,##0.00'
                Kind = skSum
                Column = cxGridDBCol_Price
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = cxGridDBCol_SUMA
              end
              item
                Format = '#,##0.00'
                Kind = skSum
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
            Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = #1057#1082#1083#1072#1076
              DataBinding.FieldName = 'DTDEP_NAME'
              Visible = False
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
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <>
              MinWidth = 24
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'GOODS_NAME'
              Width = 200
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
            object cxGridDBCol_QTY: TcxGridDBColumn
              Caption = 'Cant'
              DataBinding.FieldName = 'QTY'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 50
            end
            object cxGridDBCol_Price: TcxGridDBColumn
              Caption = 'Pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridDBCol_SUMA: TcxGridDBColumn
              Caption = 'Suma'
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Styles.Footer = dmAdditions.cxStyle_Bold
              Width = 80
            end
            object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
              Caption = #1040#1082#1090
              DataBinding.FieldName = 'FLG_ACTIVE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridDBCol_FLG_ACNT: TcxGridDBColumn
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
            object cxGridDBCol_FLG_READY: TcxGridDBColumn
              Caption = 'G'
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridDBCol_WARRANTY: TcxGridDBColumn
              Caption = 'Garntie'
              DataBinding.FieldName = 'WARRANTY'
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
          end
          object cxGridGoodsLevel: TcxGridLevel
            GridView = cxGridGoodsTable
          end
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 978
          Height = 34
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
      end
      object cxTabSheet1: TcxTabSheet
        Caption = 'Descriere (&2)'
        ImageIndex = 2
        ExplicitHeight = 267
        object Label1: TLabel
          Left = 16
          Top = 52
          Width = 347
          Height = 20
          Caption = #1055#1088#1080#1077#1084' '#1090#1086#1074#1072#1088#1072' '#1086#1089#1091#1097#1077#1089#1090#1074#1083#1103#1077#1090#1089#1103' '#1085#1072' '#1073#1072#1079#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        end
        object Label3: TLabel
          Left = 176
          Top = 105
          Width = 15
          Height = 20
          Caption = #1086#1090
        end
        object Label4: TLabel
          Left = 16
          Top = 143
          Width = 145
          Height = 20
          Caption = #1062#1077#1083#1100' '#1087#1088#1080#1105#1084#1072' '#1090#1086#1074#1072#1088#1072
        end
        object Label2: TLabel
          Left = 16
          Top = 105
          Width = 17
          Height = 20
          Caption = #8470
        end
        object Label5: TLabel
          Left = 336
          Top = 52
          Width = 153
          Height = 20
          Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1072#1094#1080#1103' '#1090#1086#1074#1072#1088#1072
        end
        object Label6: TLabel
          Left = 644
          Top = 52
          Width = 271
          Height = 20
          Caption = #1044#1077#1092#1077#1082#1090#1099' '#1087#1088#1077#1076#1100#1103#1074#1083#1077#1085#1085#1099' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1077#1084
        end
        object Label7: TLabel
          Left = 644
          Top = 153
          Width = 222
          Height = 20
          Caption = #1044#1077#1092#1077#1082#1090#1099' '#1074#1085#1077#1096#1085#1077#1075#1086' '#1074#1080#1076#1072' '#1090#1086#1074#1072#1088#1072
        end
        object Label8: TLabel
          Left = 908
          Top = 52
          Width = 275
          Height = 20
          Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1090#1077#1093#1085#1080#1095#1077#1089#1082#1080#1081' '#1086#1089#1084#1086#1090#1088
        end
        object dxBarDockControl3: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 978
          Height = 34
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object edCERTIFICAT_NUMAR: TcxDBTextEdit
          Left = 35
          Top = 102
          TabStop = False
          DataBinding.DataField = 'CERTIFICAT_NUMAR'
          DataBinding.DataSource = IBCDataSourceINFO
          Properties.ReadOnly = True
          Style.TextColor = clNavy
          Style.TextStyle = [fsBold]
          TabOrder = 5
          Width = 121
        end
        object clbFLAGS_SCOP: TcxDBCheckListBox
          Left = 16
          Top = 163
          Width = 287
          Height = 44
          TabStop = False
          DataBinding.DataSource = IBCDataSourceINFO
          DataBinding.DataField = 'FLAGS_SCOP'
          IntegralHeight = True
          Items = <
            item
              Tag = 1
              Text = #1041#1077#1089#1087#1083#1072#1090#1085#1086#1077' '#1091#1089#1090#1088#1072#1085#1077#1085#1080#1077' '#1085#1077#1087#1086#1083#1072#1076#1086#1082' ('#1088#1077#1084#1086#1085#1090')'
            end
            item
              Tag = 2
              Text = #1055#1083#1072#1085#1086#1074#1086#1077' '#1090#1077#1093#1085#1080#1095#1077#1089#1082#1086#1077' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077
            end
            item
              Tag = 4
              Text = #1042#1086#1079#1074#1088#1072#1090
            end>
          ParentColor = False
          ReadOnly = True
          TabOrder = 7
        end
        object clbFLAGS_COMPLECTINFO: TcxDBCheckListBox
          Left = 336
          Top = 73
          Width = 287
          Height = 144
          TabStop = False
          DataBinding.DataSource = IBCDataSourceINFO
          DataBinding.DataField = 'FLAGS_COMPLECTINFO'
          IntegralHeight = True
          Items = <
            item
              Tag = 1
              Text = #1050#1086#1088#1086#1073#1082#1072
            end
            item
              Tag = 2
              Text = #1059#1087#1072#1082#1086#1074#1082#1072
            end
            item
              Tag = 4
              Text = #1057#1091#1084#1082#1072
            end
            item
              Tag = 8
              Text = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
            end
            item
              Tag = 16
              Text = #1050#1072#1073#1077#1083#1100' '#1087#1080#1090#1072#1085#1080#1103
            end
            item
              Tag = 32
              Text = #1050#1072#1073#1077#1083#1100' '#1076#1072#1085#1085#1099#1093
            end
            item
              Tag = 64
              Text = #1047#1072#1088#1103#1076#1085#1086#1077' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086' ('#1041#1083#1086#1082' '#1087#1084#1090#1072#1085#1080#1103')'
            end
            item
              Tag = 128
              Text = #1040#1082#1082#1091#1084#1091#1083#1103#1090#1086#1088' ('#1041#1072#1090#1072#1088#1077#1103')'
            end
            item
              Tag = 256
              Text = 'Plcu'#539#259' spate metal al pl'#259'cii de baz'#259
            end
            item
              Tag = 512
              Text = 'CD '#1089' '#1076#1088#1072#1081#1074#1077#1088#1072#1084#1080
            end
            item
              Tag = 1024
              Text = 'CD '#1089' '#1087#1088#1086#1075#1088#1072#1084#1085#1099#1084' '#1086#1073#1077#1089#1087#1077#1095#1077#1085#1080#1077#1084
            end>
          ParentColor = False
          ReadOnly = True
          TabOrder = 2
        end
        object mmDEFECTE_PRESUPUSE: TcxDBMemo
          Left = 644
          Top = 73
          TabStop = False
          DataBinding.DataField = 'DEFECTE_PRESUPUSE'
          DataBinding.DataSource = IBCDataSourceINFO
          Properties.ReadOnly = True
          Properties.ScrollBars = ssVertical
          Properties.VisibleLineCount = 4
          Style.TextColor = clNavy
          TabOrder = 3
          Width = 237
        end
        object mmDEFECTE_ESTETITE: TcxDBMemo
          Left = 644
          Top = 174
          TabStop = False
          DataBinding.DataField = 'DEFECTE_ESTETITE'
          DataBinding.DataSource = IBCDataSourceINFO
          Properties.ReadOnly = True
          Properties.ScrollBars = ssVertical
          Properties.VisibleLineCount = 4
          Style.TextColor = clNavy
          TabOrder = 8
          Width = 237
        end
        object mmEXAMINAREA_PREVENTIVA: TcxDBMemo
          Left = 908
          Top = 73
          TabStop = False
          DataBinding.DataField = 'EXAMINAREA_PREVENTIVA'
          DataBinding.DataSource = IBCDataSourceINFO
          Properties.ReadOnly = True
          Style.TextColor = clNavy
          TabOrder = 4
          Height = 169
          Width = 277
        end
        object edCERTIFICAT_DATA: TcxDBTextEdit
          Left = 194
          Top = 102
          TabStop = False
          DataBinding.DataField = 'CERTIFICAT_DATA'
          DataBinding.DataSource = IBCDataSourceINFO
          Properties.ReadOnly = True
          Style.TextColor = clNavy
          Style.TextStyle = [fsBold]
          TabOrder = 6
          Width = 109
        end
        object edCERTIFICAT_TIP: TcxDBTextEdit
          Left = 16
          Top = 73
          DataBinding.DataField = 'CERTIFICAT_TIP_TITLE'
          DataBinding.DataSource = IBCDataSourceINFO
          Properties.ReadOnly = True
          Style.TextColor = clNavy
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Width = 287
        end
      end
      object tbsFiles: TcxTabSheet
        Caption = 'Scan (&3)'
        ImageIndex = 1
        ExplicitHeight = 267
        object cxGridFiles: TcxGrid
          Left = 0
          Top = 34
          Width = 978
          Height = 230
          Align = alClient
          TabOrder = 1
          ExplicitTop = 30
          ExplicitWidth = 997
          ExplicitHeight = 240
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
              Caption = #1044#1072#1090#1072
              DataBinding.FieldName = 'DATA'
              OnGetDisplayText = cxGridFiles_DATAGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridFiles_FILENAME: TcxGridDBColumn
              Caption = #1060#1072#1081#1083
              DataBinding.FieldName = 'FILENAME'
              Width = 300
            end
            object cxGridFiles_FILESIZE: TcxGridDBColumn
              Caption = #1056#1072#1079#1084#1077#1088
              DataBinding.FieldName = 'FILESIZE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
            object cxGridFiles_CREATED_BY_NAME: TcxGridDBColumn
              Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
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
          Width = 978
          Height = 34
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
      end
    end
  end
  object cxGridDocs: TcxGrid
    Left = 0
    Top = 0
    Width = 986
    Height = 358
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridDocsTable: TcxGridDBTableView
      OnKeyDown = cxGridDocsTableKeyDown
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
      OnCellDblClick = cxGridDocsTableCellDblClick
      OnCustomDrawCell = cxGridDocsTableCustomDrawCell
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
      object cxGridDocsTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridDocs_CREATED_DATE: TcxGridDBColumn
        Caption = 'Data crearii'
        DataBinding.FieldName = 'CREATED_DATE'
        OnGetDisplayText = cxGridDocs_CREATED_DATEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridDocsTableData: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridDocsTableDataGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridDocsTableWarehouse: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        Width = 95
      end
      object cxGridNPNCol_CT_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 158
      end
      object cxGridDocs_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridDocs_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridDocs_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridDocs_RATE: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridDocs_RATEUSD: TcxGridDBColumn
        Caption = 'Curs $'
        DataBinding.FieldName = 'RATEUSD'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridDocsTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridDocsTableFlgACNT: TcxGridDBColumn
        Caption = 'Cnt'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridDocsTableCreatedBy: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 120
        Options.HorzSizing = False
        Width = 120
      end
      object cxGridDocsTableColumn1: TcxGridDBColumn
        Caption = 'Tip operatie'
        DataBinding.FieldName = 'sc2_name'
        Width = 90
      end
      object cxGridNPN_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridDocs_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridDocs_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridDocs_CTSC: TcxGridDBColumn
        DataBinding.FieldName = 'ctsc'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridDocsLevel: TcxGridLevel
      GridView = cxGridDocsTable
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Goods')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 36
    Top = 72
    PixelsPerInch = 120
    object dxBarManagerBar1: TdxBar
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
          ItemName = 'bbGoodsSerials'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSelectFromSell'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton3'
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
      Caption = 'sCAN'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 859
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddFile'
        end
        item
          Visible = True
          ItemName = 'bbSaveFile'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteFile'
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
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1235
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEditProductDescription'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbGoodsNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
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
    object bbGoodsSerials: TdxBarButton
      Caption = 'Serii si partide'
      Category = 0
      Hint = 'Serii si partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbGoodsSerialsClick
    end
    object bbCloseDoc: TdxBarButton
      Caption = 'Inchide document'
      Category = 0
      Hint = 'Inchide document'
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbCloseDocClick
    end
    object bbOpenDoc: TdxBarButton
      Caption = 'Deschide document'
      Category = 0
      Hint = 'Deschide document'
      Visible = ivAlways
      OnClick = bbOpenDocClick
    end
    object bbReturnGoodsToCustomer: TdxBarButton
      Caption = 'Retur marfa la client'
      Category = 0
      Hint = 'Retur marfa la client'
      Visible = ivAlways
      ImageIndex = 12
      OnClick = bbReturnGoodsToCustomerClick
    end
    object bbComments: TdxBarButton
      Caption = 'Comentariu'
      Category = 0
      Hint = 'Comentariu'
      Visible = ivAlways
      OnClick = bbCommentsClick
    end
    object bbAddFile: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbAddFileClick
    end
    object bbDeleteFile: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteFileClick
    end
    object bbSaveFile: TdxBarButton
      Caption = 'Salveaza'
      Category = 0
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
      PaintStyle = psCaptionGlyph
      OnClick = bbSaveFileClick
    end
    object bbSelectFromSell: TdxBarButton
      Caption = 'Lista produselor vindute'
      Category = 0
      Hint = 'Lista produselor vindute'
      Visible = ivAlways
      ImageIndex = 14
      OnClick = bbSelectFromSellClick
    end
    object bbEditProductDescription: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbEditProductDescriptionClick
    end
    object bbGoodsInfoCard: TdxBarButton
      Caption = 'Miscarile de marfa'
      Category = 0
      Hint = 'Miscarile de marfa'
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
      Caption = 'Produse cu codurile furnizorilor'
      Category = 0
      Hint = 'Produse cu codurile furnizorilor'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCodeClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Dispozitie de plata din casa...'
      Category = 0
      Hint = 'Dispozitie de plata din casa'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Alege dupa garantie'
      Category = 0
      Hint = 'Alege dupa garantie'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Pretul din realizare'
      Category = 0
      Hint = 'Pretul din realizare'
      Visible = ivAlways
      OnClick = dxBarButton3Click
    end
    object bbInvoice: TdxBarButton
      Caption = 'Factura Fiscala'
      Category = 0
      Hint = 'Factura Fiscala'
      Visible = ivAlways
      ShortCut = 16507
      OnClick = bbInvoiceClick
    end
  end
  object cxGridPopupMenuDocs: TcxGridPopupMenu
    Grid = cxGridDocs
    PopupMenus = <
      item
        GridView = cxGridDocsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuDoc
      end>
    Left = 56
    Top = 144
  end
  object dxBarPopupMenuDoc: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDoc'
      end
      item
        Visible = True
        ItemName = 'bbOpenDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbComments'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbReturnGoodsToCustomer'
      end
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end
      item
        Visible = True
        ItemName = 'bbInvoice'
      end>
    UseOwnFont = False
    Left = 60
    Top = 200
    PixelsPerInch = 120
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
    Left = 356
    Top = 211
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceFiles: TIBCDataSource
    DataSet = IBCQueryFiles
    Left = 304
    Top = 212
  end
  object IBCQueryINFO: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      'TDB_DOC_125INFO.*,'
      
        '(SELECT TITLE_RUS FROM TS_DOC125_CTYPES WHERE TS_DOC125_CTYPES.C' +
        'ERTIFICAT_TIP=TDB_DOC_125INFO.CERTIFICAT_TIP) CERTIFICAT_TIP_TIT' +
        'LE'
      'FROM TDB_DOC_125INFO')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    ReadOnly = True
    Left = 356
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceINFO: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryINFO
    Left = 292
    Top = 92
  end
  object dxBarPopupMenuGOODS: TdxBarPopupMenu
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
        ItemName = 'bbGoodsSerials'
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
    Left = 180
    Top = 232
    PixelsPerInch = 120
  end
  object cxGridPopupMenuGOODS: TcxGridPopupMenu
    Grid = cxGridGoods
    PopupMenus = <
      item
        GridView = cxGridGoodsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuGOODS
      end>
    Left = 180
    Top = 176
  end
end
