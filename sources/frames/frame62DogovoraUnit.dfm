inherited frame62Dogovora: Tframe62Dogovora
  object pnBottom: TPanel
    Left = 0
    Top = 5
    Width = 451
    Height = 300
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object pcTabs: TcxPageControl
      Left = 0
      Top = 0
      Width = 451
      Height = 300
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      Properties.TabPosition = tpBottom
      ClientRectBottom = 274
      ClientRectLeft = 4
      ClientRectRight = 447
      ClientRectTop = 4
      object tbsDocs: TcxTabSheet
        Caption = '&1. '#1044#1086#1082#1091#1084#1077#1085#1090#1099
        ImageIndex = 0
        object cxGridDocs: TcxGrid
          Left = 0
          Top = 30
          Width = 443
          Height = 240
          Align = alClient
          TabOrder = 0
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          ExplicitWidth = 1087
          object cxGridDocsTable: TcxGridDBTableView
            OnKeyDown = cxGridDocsTableKeyDown
            Navigator.Buttons.CustomButtons = <>
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
            OnCustomDrawCell = cxGridDocsTableCustomDrawCell
            OnFocusedRecordChanged = cxGridDocsTableFocusedRecordChanged
            DataController.DataSource = IBCDataSourceDocsLocal
            DataController.KeyFieldNames = 'DOCID'
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.CellEndEllipsis = True
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.GroupRowStyle = grsOffice11
            Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridDocs_FLG_CLOSED: TcxGridDBColumn
              Caption = #1047#1072#1082#1088#1099#1090
              DataBinding.FieldName = 'FLG_CLOSED'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.HorzSizing = False
              Width = 50
            end
            object cxGridDocs_DOCTYPE_NAME: TcxGridDBColumn
              Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
              DataBinding.FieldName = 'DOCTYPE_NAME'
              Width = 100
            end
            object cxGridDocs_DOCID: TcxGridDBColumn
              Caption = #1050#1086#1076
              DataBinding.FieldName = 'DOCID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridDocs_CREATED_DATE: TcxGridDBColumn
              Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
              DataBinding.FieldName = 'CREATED_DATE'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              VisibleForCustomization = False
              Width = 90
            end
            object cxGridDocs_DATA: TcxGridDBColumn
              Caption = #1044#1072#1090#1072
              DataBinding.FieldName = 'DATA'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              OnGetDisplayText = cxGridDocs_DATAGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.HorzSizing = False
              SortIndex = 0
              SortOrder = soAscending
              Width = 100
            end
            object cxGridDocs_CT_NAME: TcxGridDBColumn
              Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
              DataBinding.FieldName = 'CT_NAME'
              MinWidth = 140
              Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
              Width = 200
            end
            object cxGridDocs_SUMA: TcxGridDBColumn
              Caption = #1057#1091#1084#1084#1072
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridDocs_CURRENCY_NAME: TcxGridDBColumn
              Caption = #1042#1072#1083#1102#1090#1072
              DataBinding.FieldName = 'CURRENCY_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.HorzSizing = False
              Width = 50
            end
            object cxGridDocs_FLG_ACNT: TcxGridDBColumn
              Caption = #1041#1091#1093#1075
              DataBinding.FieldName = 'FLG_ACNT'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridDocs_CREATED_BY_NAME: TcxGridDBColumn
              Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
              DataBinding.FieldName = 'CREATED_BY_NAME'
              MinWidth = 80
              Width = 100
            end
            object cxGridDocs_CT: TcxGridDBColumn
              DataBinding.FieldName = 'CT'
              Visible = False
              VisibleForCustomization = False
            end
            object cxGridDocs_DT: TcxGridDBColumn
              DataBinding.FieldName = 'DT'
              Visible = False
              VisibleForCustomization = False
            end
          end
          object cxGridDocsLevel: TcxGridLevel
            GridView = cxGridDocsTable
          end
        end
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 443
          Height = 30
          Align = dalTop
          BarManager = dxBarManager1
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
      end
      object tbsJurnal: TcxTabSheet
        Caption = '&2. '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103' '#1080#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 0
          Width = 1087
          Height = 270
          Align = alClient
          TabOrder = 0
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object cxGridComponentsTable: TcxGridDBTableView
            OnKeyDown = cxGridComponentsTableKeyDown
            Navigator.Buttons.CustomButtons = <>
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
            DataController.DataSource = IBCDataSourceJurnalLocal
            DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
            DataController.Summary.DefaultGroupSummaryItems = <>
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
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.CellEndEllipsis = True
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Footer = dmAdditions.cxStyle_GridHeader
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = #1057#1082#1083#1072#1076
              DataBinding.FieldName = 'DTDEP_NAME'
              Visible = False
              MinWidth = 60
              Width = 100
            end
            object cxGridDBCol_GOODSID: TcxGridDBColumn
              Caption = #1050#1086#1076
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
            object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              DataBinding.FieldName = 'GOODS_NAME'
              Width = 300
            end
            object cxGridDBCol_QTY: TcxGridDBColumn
              AlternateCaption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
              Caption = #1050#1086#1083'-'#1074#1086
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
              VisibleForCustomization = False
            end
            object cxGridDBCol_UM_NAME: TcxGridDBColumn
              AlternateCaption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
              Caption = #1045#1048
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
              Caption = #1062#1077#1085#1072
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridDBCol_SUMA: TcxGridDBColumn
              Caption = #1057#1091#1084#1084#1072
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
              Caption = #1053#1044#1057
              DataBinding.FieldName = 'SUMAVAT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              Visible = False
              VisibleForCustomization = False
            end
            object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
              AlternateCaption = #1040#1082#1090#1080#1074#1077#1085
              Caption = #1040
              DataBinding.FieldName = 'FLG_ACTIVE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 24
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridDBCol_FLG_READY: TcxGridDBColumn
              AlternateCaption = #1043#1086#1090#1086#1074
              Caption = #1043
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 24
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
              AlternateCaption = #1054#1089#1090#1072#1090#1086#1082
              Caption = #1054#1089#1090'.'
              DataBinding.FieldName = 'STOCK_QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 30
              VisibleForCustomization = False
              Width = 40
            end
            object cxGridComponents_PRICE_COLUMN: TcxGridDBColumn
              AlternateCaption = #1050#1086#1083#1086#1085#1082#1072' '#1094#1077#1085
              Caption = #1062
              DataBinding.FieldName = 'PRICE_COLUMN'
              HeaderAlignmentHorz = taCenter
              MinWidth = 24
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridComponents_CREATED_BY_NAME: TcxGridDBColumn
              Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
              DataBinding.FieldName = 'CREATED_BY_NAME'
              BestFitMaxWidth = 150
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
            object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = #1050#1086#1076' '#1073#1091#1093#1075
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086' '#1085#1072#1082#1083#1072#1076#1085#1099#1084
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              MinWidth = 50
              Width = 70
            end
          end
          object cxGridLevel: TcxGridLevel
            GridView = cxGridComponentsTable
          end
        end
      end
      object cxTabSheet1: TcxTabSheet
        Caption = '&3. '#1060#1072#1081#1083#1099
        ImageIndex = 2
        object cxGridFiles: TcxGrid
          Left = 0
          Top = 30
          Width = 443
          Height = 240
          Align = alClient
          TabOrder = 1
          object cxGridFilesTable: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            OnFocusedRecordChanged = cxGridFilesTableFocusedRecordChanged
            DataController.DataSource = IBCDataSourceFiles
            DataController.KeyFieldNames = 'CONTRACTFILEID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
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
              Properties.DefaultImageIndex = 32
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <>
              MinWidth = 24
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridFiles_TITLE: TcxGridDBColumn
              Caption = #1053#1072#1079#1074#1072#1085#1080#1077'/'#1089#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1092#1072#1081#1083#1072
              DataBinding.FieldName = 'TITLE'
              Width = 300
            end
            object cxGridFiles_FILENAME: TcxGridDBColumn
              Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072
              DataBinding.FieldName = 'FILENAME'
              Width = 100
            end
            object cxGridFiles_FILESIZE: TcxGridDBColumn
              Caption = #1056#1072#1079#1084#1077#1088', bytes'
              DataBinding.FieldName = 'FILESIZE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
          end
          object cxGridFilesLevel: TcxGridLevel
            GridView = cxGridFilesTable
          end
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 443
          Height = 30
          Align = dalTop
          BarManager = dxBarManager1
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
      end
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = -3
    Width = 451
    Height = 8
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 200
    Control = pnBottom
  end
  object cxGridContracts: TcxGrid
    Left = 0
    Top = 0
    Width = 451
    Height = 464
    Align = alClient
    TabOrder = 1
    object cxGridContractsTable: TcxGridDBTableView
      OnKeyDown = cxGridContractsTableKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridContractsTableCustomDrawCell
      OnFocusedRecordChanged = cxGridContractsTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourceContracte
      DataController.KeyFieldNames = 'CONTRACTID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.Indicator = True
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridContracts_FLG_CLOSED: TcxGridDBColumn
        Caption = #1047#1072#1082#1088#1099#1090
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridContracts_CONTRACTID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'CONTRACTID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridContracts_CREATED_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'CREATED_DATE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = cxGridContracts_CREATED_DATEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 100
      end
      object cxGridContracts_CODE: TcxGridDBColumn
        Caption = #8470
        DataBinding.FieldName = 'CODE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridContracts_DT_NAME: TcxGridDBColumn
        Caption = #1060#1080#1088#1084#1072
        DataBinding.FieldName = 'DT_NAME'
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 150
      end
      object cxGridContracts_CT_NAME: TcxGridDBColumn
        Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
        DataBinding.FieldName = 'CT_NAME'
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 150
      end
      object cxGridContracts_SIGN_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1087#1086#1076#1087#1080#1089'.'
        DataBinding.FieldName = 'SIGN_DATE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 90
        Options.HorzSizing = False
        Width = 90
      end
      object cxGridContracts_EXPIRE_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1079#1072#1074#1077#1088#1096'.'
        DataBinding.FieldName = 'EXPIRE_DATE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 90
        Options.HorzSizing = False
        Width = 90
      end
      object cxGridContracts_CONTRACT_TYPE_TITLE: TcxGridDBColumn
        Caption = #1058#1080#1087' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
        DataBinding.FieldName = 'CONTRACT_TYPE_TITLE'
        Width = 100
      end
      object cxGridContracts_PRICE_COLUMN: TcxGridDBColumn
        Caption = #1050#1086#1083'. '#1094#1077#1085'.'
        DataBinding.FieldName = 'PRICE_COLUMN'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridContracts_FLG_ACNT: TcxGridDBColumn
        Caption = #1041#1091#1093#1075
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridContracts_CURRENCY_TITLE: TcxGridDBColumn
        Caption = #1042#1072#1083#1102#1090#1072
        DataBinding.FieldName = 'CURRENCY_TITLE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridContracts_CREATED_BY_NAME: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 80
      end
      object cxGridContracts_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridContracts_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridContractsLevel: TcxGridLevel
      GridView = cxGridContractsTable
    end
  end
  object IBCQueryContracte: TIBCQuery
    KeyFields = 'CONTRACTID'
    KeyGenerator = 'SQ_TDB_CONTRACTS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_CONTRACTS'
      
        '  (CONTRACTID, CODE, DT, CT, DT_RESPONSABILE_PERSON, CT_RESPONSA' +
        'BILE_PERSON, SIGN_DATE, EXPIRE_DATE, '
      '   CONTRACT_TYPE, PRICE_COLUMN, CURRENCYID)'
      'VALUES'
      
        '  (:CONTRACTID, :CODE, :DT, :CT, :DT_RESPONSABILE_PERSON, :CT_RE' +
        'SPONSABILE_PERSON, :SIGN_DATE, :EXPIRE_DATE, '
      '   :CONTRACT_TYPE, :PRICE_COLUMN, :CURRENCYID)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_CONTRACTS'
      'WHERE'
      '  CONTRACTID = :Old_CONTRACTID')
    SQLUpdate.Strings = (
      'UPDATE TDB_CONTRACTS'
      'SET'
      '  CONTRACTID = :CONTRACTID, '
      '  CODE = :CODE, '
      '  DT = :DT, '
      '  CT = :CT, '
      '  DT_RESPONSABILE_PERSON = :DT_RESPONSABILE_PERSON, '
      '  CT_RESPONSABILE_PERSON = :CT_RESPONSABILE_PERSON, '
      '  SIGN_DATE = :SIGN_DATE, '
      '  EXPIRE_DATE = :EXPIRE_DATE, '
      '  CONTRACT_TYPE = :CONTRACT_TYPE, '
      '  PRICE_COLUMN = :PRICE_COLUMN, '
      '  CURRENCYID = :CURRENCYID'
      'WHERE'
      '  CONTRACTID = :Old_CONTRACTID')
    SQLRefresh.Strings = (
      'SELECT '
      ' CONTRACTID, '
      ' CODE, '
      ' DT, '
      ' DT_NAME, '
      ' CT, '
      ' CT_NAME, '
      ' DT_RESPONSABILE_PERSON, '
      ' DT_RESPONSABILE_PERSON_NAME, '
      ' CT_RESPONSABILE_PERSON, '
      ' CT_RESPONSABILE_PERSON_NAME, '
      ' SIGN_DATE, '
      ' EXPIRE_DATE, '
      ' CONTRACT_TYPE, '
      ' CONTRACT_TYPE_TITLE, '
      ' PRICE_COLUMN, '
      ' CURRENCYID, '
      ' CURRENCY_TITLE, '
      ' CREATED_BY, '
      ' CREATED_BY_NAME, '
      ' CREATED_DATE, '
      ' FLG_ACNT, '
      ' FLG_CLOSED '
      'FROM '
      ' VW_TDB_CONTRACTS'
      'WHERE'
      ' CONTRACTID = :CONTRACTID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_CONTRACTS'
      'WHERE'
      'CONTRACTID = :Old_CONTRACTID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' CONTRACTID, '
      ' CODE, '
      ' DT, '
      ' DT_NAME, '
      ' CT, '
      ' CT_NAME, '
      ' DT_RESPONSABILE_PERSON, '
      ' DT_RESPONSABILE_PERSON_NAME, '
      ' CT_RESPONSABILE_PERSON, '
      ' CT_RESPONSABILE_PERSON_NAME, '
      ' SIGN_DATE, '
      ' EXPIRE_DATE, '
      ' CONTRACT_TYPE, '
      ' CONTRACT_TYPE_TITLE, '
      ' PRICE_COLUMN, '
      ' CURRENCYID, '
      ' CURRENCY_TITLE, '
      ' CREATED_BY, '
      ' CREATED_BY_NAME, '
      ' CREATED_DATE, '
      ' FLG_ACNT, '
      ' FLG_CLOSED '
      'FROM '
      ' VW_TDB_CONTRACTS'
      'ORDER BY '
      ' CREATED_DATE')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Constraints = <>
    Left = 224
    Top = 156
  end
  object IBCDataSourceContracte: TIBCDataSource
    DataSet = IBCQueryContracte
    Left = 220
    Top = 220
  end
  object IBCDataSourceDocsLocal: TIBCDataSource
    DataSet = IBCQueryDocsLocal
    Left = 388
    Top = 156
  end
  object IBCQueryDocsLocal: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_DOCS.*,'
      
        ' IIF(EXISTS(SELECT GOODSID FROM TDB_JURNAL WHERE TDB_JURNAL.DOCI' +
        'D=VW_TDB_DOCS.DOCID),1,0) HAS_JURNAL_GOODS'
      'FROM'
      ' VW_TDB_DOCS'
      'ORDER BY DATA')
    MasterFields = 'CONTRACTID'
    DetailFields = 'CONTRACTID'
    MasterSource = IBCDataSourceContracte
    Options.DetailDelay = 100
    Constraints = <>
    Left = 388
    Top = 212
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACTID'
        Value = nil
      end>
  end
  object IBCQueryJurnalLocal: TIBCQuery
    KeyFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceDocsLocal
    AutoCommit = False
    LockMode = lmLockImmediate
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    Constraints = <>
    Left = 528
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnalLocal: TIBCDataSource
    DataSet = IBCQueryJurnalLocal
    Left = 532
    Top = 160
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGridContracts
    PopupMenus = <
      item
        GridView = cxGridContractsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuContracts
      end>
    Left = 80
    Top = 84
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 188
    Top = 76
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1120
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGotoDoc'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1120
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFileNew'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFileRemove'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFileSave'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFileOpen'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbCalcProfitability: TdxBarButton
      Caption = #1056#1072#1089#1095#1077#1090' '#1088#1077#1085#1090#1072#1073#1080#1083#1100#1085#1086#1089#1090#1080'...'
      Category = 0
      Hint = #1056#1072#1089#1095#1077#1090' '#1088#1077#1085#1090#1072#1073#1080#1083#1100#1085#1086#1089#1090#1080
      Visible = ivAlways
      ShortCut = 16466
      OnClick = bbCalcProfitabilityClick
    end
    object bbCloseContract: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1082#1086#1085#1090#1088#1072#1082#1090'...'
      Category = 0
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1082#1086#1085#1090#1088#1072#1082#1090
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbCloseContractClick
    end
    object bbGotoDoc: TdxBarButton
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Category = 0
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbGotoDocClick
    end
    object bbFileSave: TdxBarButton
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      Category = 0
      Hint = #1047#1072#1087#1080#1089#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 32
      OnClick = bbFileSaveClick
    end
    object bbFileOpen: TdxBarButton
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Category = 0
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Visible = ivAlways
      ImageIndex = 4
      OnClick = bbFileOpenClick
    end
    object bbFileNew: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1092#1072#1081#1083
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1092#1072#1081#1083
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbFileNewClick
    end
    object bbFileRemove: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbFileRemoveClick
    end
  end
  object dxBarPopupMenuContracts: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCalcProfitability'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCloseContract'
      end>
    UseOwnFont = False
    Left = 76
    Top = 136
    PixelsPerInch = 96
  end
  object IBCQueryFiles: TIBCQuery
    KeyFields = 'CONTRACTFILEID'
    KeyGenerator = 'SQ_TDB_CONTRACT_FILES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_CONTRACT_FILES'
      '  (CONTRACTFILEID, CONTRACTID, TITLE, FILENAME, FILESIZE)'
      'VALUES'
      '  (:CONTRACTFILEID, :CONTRACTID, :TITLE, :FILENAME, :FILESIZE)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_CONTRACT_FILES'
      'WHERE'
      '  CONTRACTFILEID = :Old_CONTRACTFILEID')
    SQLRefresh.Strings = (
      'SELECT CONTRACTFILEID, CONTRACTID, TITLE, FILENAME, FILESIZE'
      'FROM TDB_CONTRACT_FILES'
      'WHERE CONTRACTFILEID = :CONTRACTFILEID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' CONTRACTFILEID, '
      ' CONTRACTID, '
      ' TITLE, '
      ' FILENAME, '
      ' FILESIZE'
      'FROM '
      ' TDB_CONTRACT_FILES')
    MasterFields = 'CONTRACTID'
    DetailFields = 'CONTRACTID'
    MasterSource = IBCDataSourceContracte
    AutoCommit = False
    RefreshOptions = [roAfterInsert]
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    Constraints = <>
    Left = 532
    Top = 404
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACTID'
        Value = nil
      end>
  end
  object IBCDataSourceFiles: TIBCDataSource
    DataSet = IBCQueryFiles
    Left = 532
    Top = 460
  end
end
