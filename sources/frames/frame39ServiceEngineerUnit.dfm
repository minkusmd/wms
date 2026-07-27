inherited frame39ServiceEngineer: Tframe39ServiceEngineer
  Width = 1145
  Font.Height = -15
  ExplicitWidth = 1145
  PixelsPerInch = 120
  object pnRight: TPanel
    Left = 1030
    Top = 0
    Width = 115
    Height = 668
    Align = alRight
    BevelOuter = bvNone
    Padding.Left = 2
    ShowCaption = False
    TabOrder = 2
    Visible = False
    ExplicitLeft = 871
    object pnTaskRequest: TPanel
      Left = 2
      Top = 0
      Width = 113
      Height = 199
      Align = alTop
      BevelOuter = bvNone
      Padding.Bottom = 2
      ShowCaption = False
      TabOrder = 0
      object dxBarDockControlTaskRequest: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 113
        Height = 34
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridTR: TcxGrid
        Left = 0
        Top = 34
        Width = 113
        Height = 163
        Align = alClient
        TabOrder = 1
        object cxGridTRTable: TcxGridDBTableView
          OnFocusedRecordChanged = cxGridTRTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceRequest
          DataController.KeyFieldNames = 'TASKID'
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.NavigatorOffset = 63
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.CellAutoHeight = True
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
          object cxGridTR_TASKID: TcxGridDBColumn
            DataBinding.FieldName = 'TASKID'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridTR_IMG: TcxGridDBColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 64
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 24
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 24
          end
          object cxGridTR_TITLE: TcxGridDBColumn
            Caption = #1047#1072#1087#1088#1086#1089
            DataBinding.FieldName = 'TITLE'
            Width = 100
          end
          object cxGridTR_COMMENTS: TcxGridDBColumn
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077
            DataBinding.FieldName = 'COMMENTS'
            Width = 100
          end
          object cxGridTR_CREATED_FULL_NAME: TcxGridDBColumn
            Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
            DataBinding.FieldName = 'CREATED_FULL_NAME'
            Visible = False
            Width = 50
          end
        end
        object cxGridTRLevel: TcxGridLevel
          GridView = cxGridTRTable
        end
      end
    end
    object pnTasks: TPanel
      Left = 2
      Top = 209
      Width = 113
      Height = 459
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnTasks'
      Padding.Top = 2
      ShowCaption = False
      TabOrder = 2
      object cxDBTreeListTask: TcxDBTreeList
        Left = 0
        Top = 36
        Width = 113
        Height = 262
        Align = alClient
        Bands = <
          item
          end>
        DataController.DataSource = IBCDataSourceTask
        DataController.ImageIndexField = 'IMAGE_INDEX'
        DataController.ParentField = 'PARENTID'
        DataController.KeyField = 'TASKID'
        Images = dmAdditions.cxImageList_SWN
        OptionsBehavior.ImmediateEditor = False
        OptionsBehavior.ChangeDelay = 1000
        OptionsBehavior.Sorting = False
        OptionsCustomizing.ColumnsQuickCustomization = True
        OptionsData.Editing = False
        OptionsData.Deleting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        PopupMenu = dxBarPopupMenuTask
        RootValue = 0
        ScrollbarAnnotations.CustomAnnotations = <>
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        Styles.OnGetContentStyle = cxDBTreeListTaskStylesGetContentStyle
        Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
        TabOrder = 2
        OnDataChanged = cxDBTreeListTaskDataChanged
        OnFocusedNodeChanged = cxDBTreeListTaskFocusedNodeChanged
        object cxDBTreeListTaskcxDBTreeListColumn1: TcxDBTreeListColumn
          Caption.Text = #1047#1072#1076#1072#1095#1072
          DataBinding.FieldName = 'TASKTYPE_TITLE'
          Position.ColIndex = 0
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeListTaskcxDBTreeListColumn2: TcxDBTreeListColumn
          Visible = False
          Caption.Text = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
          DataBinding.FieldName = 'SN'
          Options.Sizing = False
          Position.ColIndex = 1
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeListTaskcxDBTreeListColumn3: TcxDBTreeListColumn
          Caption.Text = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
          DataBinding.FieldName = 'END_ESTIMATED_TIME'
          Width = 50
          Position.ColIndex = 3
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeListTaskcxDBTreeListColumn4: TcxDBTreeListColumn
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          Caption.Text = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'USER_FULL_NAME'
          Width = 60
          Position.ColIndex = 4
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeListTaskcxDBTreeListColumn5: TcxDBTreeListColumn
          Visible = False
          DataBinding.FieldName = 'USERID'
          Options.Customizing = False
          Position.ColIndex = 5
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeListTaskcxDBTreeListColumn6: TcxDBTreeListColumn
          Visible = False
          Caption.AlignHorz = taCenter
          Caption.Text = 'TaskID'
          DataBinding.FieldName = 'TASKID'
          Options.Sizing = False
          Width = 50
          Position.ColIndex = 6
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeListTaskcxDBTreeListColumn7: TcxDBTreeListColumn
          Visible = False
          DataBinding.FieldName = 'TASKTYPE_ID'
          Options.Customizing = False
          Position.ColIndex = 7
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeListTaskcxDBTreeListColumn8: TcxDBTreeListColumn
          Visible = False
          DataBinding.FieldName = 'CREATED_BY'
          Options.Customizing = False
          Position.ColIndex = 8
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeListTaskcxDBTreeList_DATA: TcxDBTreeListColumn
          Caption.Text = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          Width = 50
          Position.ColIndex = 2
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
      end
      object cxDBVerticalGrid2: TcxDBVerticalGrid
        Left = 0
        Top = 298
        Width = 113
        Height = 161
        Align = alBottom
        OptionsView.CellAutoHeight = True
        OptionsView.ScrollBars = ssVertical
        OptionsView.RowHeaderMinWidth = 150
        OptionsView.RowHeaderWidth = 150
        OptionsBehavior.RowTracking = False
        OptionsBehavior.AllowChangeRecord = False
        OptionsData.Editing = False
        OptionsData.Appending = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        ScrollbarAnnotations.CustomAnnotations = <>
        Styles.Content = dmAdditions.cxStyle_ServiceFont
        Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
        TabOrder = 0
        DataController.DataSource = IBCDataSourceTask
        Version = 1
        object cxDBVerticalGrid2DBEditorRow1: TcxDBEditorRow
          Properties.Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1086
          Properties.DataBinding.FieldName = 'DATA'
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
        object cxDBVerticalGrid2DBEditorRow2: TcxDBEditorRow
          Properties.Caption = #1053#1072#1079#1085#1072#1095#1077#1085
          Properties.DataBinding.FieldName = 'CREATED_FULL_NAME'
          ID = 1
          ParentID = -1
          Index = 1
          Version = 1
        end
        object cxDBVerticalGrid2DBEditorRow3: TcxDBEditorRow
          Properties.Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
          Properties.DataBinding.FieldName = 'SN'
          ID = 2
          ParentID = -1
          Index = 2
          Version = 1
        end
        object cxDBVerticalGrid2DBEditorRow4: TcxDBEditorRow
          Properties.Caption = #1050#1088#1072#1081#1085#1080#1081' '#1089#1088#1086#1082
          Properties.DataBinding.FieldName = 'END_ESTIMATED_TIME'
          ID = 3
          ParentID = -1
          Index = 3
          Version = 1
        end
        object cxDBVerticalGrid2DBEditorRow5: TcxDBEditorRow
          Properties.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Properties.DataBinding.FieldName = 'USER_FULL_NAME'
          ID = 4
          ParentID = -1
          Index = 4
          Version = 1
        end
        object cxDBVerticalGrid2DBEditorRow6: TcxDBEditorRow
          Properties.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
          Properties.DataBinding.FieldName = 'COMMENTS'
          ID = 5
          ParentID = -1
          Index = 5
          Version = 1
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 2
        Width = 113
        Height = 34
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
    object cxSplitter3: TcxSplitter
      Left = 2
      Top = 199
      Width = 113
      Height = 10
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salTop
      MinSize = 200
      Control = pnTaskRequest
    end
  end
  object pnClient: TPanel
    Left = 0
    Top = 0
    Width = 1020
    Height = 668
    Align = alClient
    BevelOuter = bvNone
    Padding.Right = 2
    ShowCaption = False
    TabOrder = 0
    ExplicitWidth = 861
    object pnBottom: TPanel
      Left = 0
      Top = 368
      Width = 1018
      Height = 300
      Align = alBottom
      BevelOuter = bvNone
      Padding.Top = 2
      ShowCaption = False
      TabOrder = 2
      ExplicitWidth = 859
      object pcPageControlDocs: TPageControl
        Left = 0
        Top = 2
        Width = 1018
        Height = 298
        ActivePage = tbsIncidentRashod
        Align = alClient
        TabOrder = 0
        TabStop = False
        ExplicitWidth = 859
        object tbsIncidentRashod: TTabSheet
          Caption = 'Document vinzare (client)'
          object dxBarDockControlRashod: TdxBarDockControl
            Left = 0
            Top = 96
            Width = 1010
            Height = 34
            Align = dalTop
            BarManager = dxBarManager
            SunkenBorder = True
            UseOwnSunkenBorder = True
            ExplicitWidth = 851
          end
          object cxGridDocGoods: TcxGrid
            Left = 0
            Top = 130
            Width = 1010
            Height = 133
            Align = alClient
            TabOrder = 3
            ExplicitWidth = 851
            ExplicitHeight = 138
            object cxGridDocGoodsTable: TcxGridDBTableView
              OnKeyDown = cxGridDocGoodsTableKeyDown
              OnCustomDrawCell = cxGridDocGoodsTableCustomDrawCell
              OnFocusedRecordChanged = cxGridDocGoodsTableFocusedRecordChanged
              DataController.DataSource = IBCDataSourceJurnal
              DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
              DataController.Summary.FooterSummaryItems = <
                item
                  Kind = skCount
                  Column = cxGridRashod_GOODSID
                end
                item
                  Format = '0.00'
                  Kind = skSum
                  Column = cxGridRashod_SUMA
                end
                item
                  Kind = skSum
                  Column = cxGridRashod_QTY
                end>
              FilterRow.SeparatorWidth = 8
              FixedDataRows.SeparatorWidth = 8
              NewItemRow.SeparatorWidth = 8
              OptionsBehavior.IncSearch = True
              OptionsCustomize.ColumnSorting = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.CellEndEllipsis = True
              OptionsView.NavigatorOffset = 63
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
              OptionsView.ScrollBars = ssVertical
              OptionsView.ColumnAutoWidth = True
              OptionsView.FixedColumnSeparatorWidth = 3
              OptionsView.Footer = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              Preview.LeftIndent = 25
              Preview.RightIndent = 6
              RowLayout.MinValueWidth = 100
              Styles.Footer = dmAdditions.cxStyle_GridHeader
              Styles.Header = dmAdditions.cxStyle_GridHeader
              Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
              object cxGridRashod_DTDEP_NAME: TcxGridDBColumn
                Caption = 'Depozit'
                DataBinding.FieldName = 'DTDEP_NAME'
                HeaderAlignmentHorz = taCenter
                MinWidth = 30
                Width = 50
              end
              object cxGridRashod_GOODSID: TcxGridDBColumn
                Caption = 'Cod'
                DataBinding.FieldName = 'GOODSID'
                FooterAlignmentHorz = taRightJustify
                HeaderAlignmentHorz = taCenter
                MinWidth = 60
                Options.HorzSizing = False
                Width = 60
              end
              object cxGridRashod_IMG: TcxGridDBColumn
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Alignment.Horz = taCenter
                Properties.Images = dmAdditions.cxImageList_SWN
                Properties.Items = <>
                MinWidth = 24
                Options.Focusing = False
                Options.HorzSizing = False
                VisibleForCustomization = False
                Width = 24
              end
              object cxGridRashod_GOODS_NAME: TcxGridDBColumn
                Caption = 'Denumire'
                DataBinding.FieldName = 'GOODS_NAME'
                Width = 200
              end
              object cxGridRashod_QTY: TcxGridDBColumn
                AlternateCaption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
                Caption = 'Cant'
                DataBinding.FieldName = 'QTY'
                FooterAlignmentHorz = taRightJustify
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.HorzSizing = False
                Width = 50
              end
              object cxGridRashod_UM_NAME: TcxGridDBColumn
                AlternateCaption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
                Caption = 'UM'
                DataBinding.FieldName = 'UM_NAME'
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.HorzSizing = False
                Width = 50
              end
              object cxGridRashod_PRICE: TcxGridDBColumn
                Caption = 'Pret'
                DataBinding.FieldName = 'PRICE'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 80
                Options.HorzSizing = False
                Width = 80
              end
              object cxGridRashod_SUMA: TcxGridDBColumn
                Caption = 'Suma'
                DataBinding.FieldName = 'SUMA'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                FooterAlignmentHorz = taRightJustify
                HeaderAlignmentHorz = taCenter
                MinWidth = 80
                Options.HorzSizing = False
                Width = 80
              end
              object cxGridRashod_FLG_ACTIVE: TcxGridDBColumn
                AlternateCaption = #1040#1082#1090#1080#1074
                Caption = 'Activ'
                DataBinding.FieldName = 'FLG_ACTIVE'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = 1
                Properties.ValueUnchecked = 0
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.HorzSizing = False
                Width = 50
              end
              object cxGridRashod_FLG_READY: TcxGridDBColumn
                Caption = 'Gata'
                DataBinding.FieldName = 'FLG_READY'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = 1
                Properties.ValueUnchecked = 0
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.HorzSizing = False
                Width = 50
              end
            end
            object cxGridDocGoodsLevel: TcxGridLevel
              GridView = cxGridDocGoodsTable
            end
          end
          object cxGridDocs: TcxGrid
            AlignWithMargins = True
            Left = 0
            Top = 34
            Width = 1010
            Height = 60
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 2
            Align = alTop
            TabOrder = 1
            LookAndFeel.NativeStyle = True
            LookAndFeel.SkinName = ''
            ExplicitWidth = 851
            object cxGridDocsTable: TcxGridDBTableView
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
              DataController.DataSource = IBCDataSourceDocs
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
              OptionsView.GroupByBox = False
              OptionsView.GroupRowStyle = grsOffice11
              Preview.LeftIndent = 25
              Preview.RightIndent = 6
              RowLayout.MinValueWidth = 100
              Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
              Styles.Header = dmAdditions.cxStyle_GridHeader
              Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
              object cxGridDocs_FLG_CLOSED: TcxGridDBColumn
                Caption = 'Inchis'
                DataBinding.FieldName = 'FLG_CLOSED'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = 1
                Properties.ValueUnchecked = 0
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.Editing = False
                Options.HorzSizing = False
                Width = 50
              end
              object cxGridDocs_DOCID: TcxGridDBColumn
                Caption = 'Cod'
                DataBinding.FieldName = 'DOCID'
                HeaderAlignmentHorz = taCenter
                MinWidth = 60
                Options.Editing = False
                Options.HorzSizing = False
                Width = 60
              end
              object cxGridDocs_DATA: TcxGridDBColumn
                Caption = 'Data'
                DataBinding.FieldName = 'DATA'
                OnGetDisplayText = cxGridDocs_DATAGetDisplayText
                HeaderAlignmentHorz = taCenter
                MinWidth = 100
                Options.Editing = False
                Options.HorzSizing = False
                Width = 100
              end
              object cxGridDocs_CT_NAME: TcxGridDBColumn
                Caption = 'Client'
                DataBinding.FieldName = 'CT_NAME'
                Options.Editing = False
                Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
                Width = 200
              end
              object cxGridDocs_SUMA: TcxGridDBColumn
                Caption = 'Suma'
                DataBinding.FieldName = 'SUMA'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 100
                Options.Editing = False
                Options.HorzSizing = False
                Width = 100
              end
              object cxGridDocs_CURRENCY_NAME: TcxGridDBColumn
                Caption = 'Valuta'
                DataBinding.FieldName = 'CURRENCY_NAME'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.Alignment.Horz = taCenter
                HeaderAlignmentHorz = taCenter
                MinWidth = 70
                Options.Editing = False
                Options.HorzSizing = False
                Width = 70
              end
            end
            object cxGridDocsLevel: TcxGridLevel
              GridView = cxGridDocsTable
            end
          end
          object dxBarDockControl2: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 1010
            Height = 34
            Align = dalTop
            BarManager = dxBarManager
            SunkenBorder = True
            UseOwnSunkenBorder = True
            ExplicitWidth = 851
          end
        end
        object TabSheet1: TTabSheet
          Caption = 'Document vinzare (platitor)'
          ImageIndex = 6
          object cxGridDocsPayer: TcxGrid
            AlignWithMargins = True
            Left = 0
            Top = 34
            Width = 1010
            Height = 60
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 2
            Align = alTop
            TabOrder = 0
            LookAndFeel.NativeStyle = True
            LookAndFeel.SkinName = ''
            ExplicitTop = 30
            ExplicitWidth = 318
            object cxGridDocsPayerTable: TcxGridDBTableView
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
              OnCustomDrawCell = cxGridDocsPayerTableCustomDrawCell
              OnFocusedRecordChanged = cxGridDocsPayerTableFocusedRecordChanged
              DataController.DataSource = IBCDS_DocsPay
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
              OptionsView.GroupByBox = False
              OptionsView.GroupRowStyle = grsOffice11
              Preview.LeftIndent = 25
              Preview.RightIndent = 6
              RowLayout.MinValueWidth = 100
              Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
              Styles.Header = dmAdditions.cxStyle_GridHeader
              Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
              object cxGridDocsPayer_FLG_CLOSED: TcxGridDBColumn
                Caption = 'Inchis'
                DataBinding.FieldName = 'FLG_CLOSED'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = 1
                Properties.ValueUnchecked = 0
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.Editing = False
                Options.HorzSizing = False
                Width = 50
              end
              object cxGridDocsPayer_DOCID: TcxGridDBColumn
                Caption = 'Cod'
                DataBinding.FieldName = 'DOCID'
                HeaderAlignmentHorz = taCenter
                MinWidth = 60
                Options.Editing = False
                Options.HorzSizing = False
                Width = 60
              end
              object cxGridDocsPayer_DATA: TcxGridDBColumn
                Caption = 'Data'
                DataBinding.FieldName = 'DATA'
                OnGetDisplayText = cxGridDocsPayer_DATAGetDisplayText
                HeaderAlignmentHorz = taCenter
                MinWidth = 100
                Options.Editing = False
                Options.HorzSizing = False
                Width = 100
              end
              object cxGridDocsPayer_CT_NAME: TcxGridDBColumn
                Caption = 'Platitor'
                DataBinding.FieldName = 'CT_NAME'
                Options.Editing = False
                Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
                Width = 200
              end
              object cxGridDocsPayer_SUMA: TcxGridDBColumn
                Caption = 'Suma'
                DataBinding.FieldName = 'SUMA'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 100
                Options.Editing = False
                Options.HorzSizing = False
                Width = 100
              end
              object cxGridDocsPayer_CURRENCY_NAME: TcxGridDBColumn
                Caption = 'Valuta'
                DataBinding.FieldName = 'CURRENCY_NAME'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.Alignment.Horz = taCenter
                HeaderAlignmentHorz = taCenter
                MinWidth = 70
                Options.Editing = False
                Options.HorzSizing = False
                Width = 70
              end
            end
            object cxGridDocsPayerLevel: TcxGridLevel
              GridView = cxGridDocsPayerTable
            end
          end
          object cxGridDocPayerGoods: TcxGrid
            Left = 0
            Top = 130
            Width = 1010
            Height = 133
            Align = alClient
            TabOrder = 3
            ExplicitTop = 122
            ExplicitWidth = 318
            ExplicitHeight = 146
            object cxGridDocPayerGoodsTable: TcxGridDBTableView
              OnCustomDrawCell = cxGridDocPayerGoodsTableCustomDrawCell
              OnFocusedRecordChanged = cxGridDocPayerGoodsTableFocusedRecordChanged
              DataController.DataSource = IBCDS_JurnalPayer
              DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
              DataController.Summary.FooterSummaryItems = <
                item
                  Kind = skCount
                  Column = cxGridDBPayer_GoodsID
                end
                item
                  Format = '0.00'
                  Kind = skSum
                  Column = cxGridDBColumn25
                end
                item
                  Kind = skSum
                  Column = cxGridDBColumn22
                end>
              FilterRow.SeparatorWidth = 8
              FixedDataRows.SeparatorWidth = 8
              NewItemRow.SeparatorWidth = 8
              OptionsBehavior.IncSearch = True
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnSorting = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.CellEndEllipsis = True
              OptionsView.NavigatorOffset = 63
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
              OptionsView.ScrollBars = ssVertical
              OptionsView.ColumnAutoWidth = True
              OptionsView.FixedColumnSeparatorWidth = 3
              OptionsView.Footer = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              Preview.LeftIndent = 25
              Preview.RightIndent = 6
              RowLayout.MinValueWidth = 100
              Styles.Footer = dmAdditions.cxStyle_GridHeader
              Styles.Header = dmAdditions.cxStyle_GridHeader
              Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
              object cxGridDBColumn19: TcxGridDBColumn
                Caption = 'Depozit'
                DataBinding.FieldName = 'DTDEP_NAME'
                HeaderAlignmentHorz = taCenter
                MinWidth = 30
                Width = 50
              end
              object cxGridDBPayer_GoodsID: TcxGridDBColumn
                Caption = 'Cod'
                DataBinding.FieldName = 'GOODSID'
                FooterAlignmentHorz = taRightJustify
                HeaderAlignmentHorz = taCenter
                MinWidth = 60
                Options.HorzSizing = False
                Width = 60
              end
              object cxGridDocPayerGoods_IMG: TcxGridDBColumn
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Alignment.Horz = taCenter
                Properties.Images = dmAdditions.cxImageList_SWN
                Properties.Items = <>
                MinWidth = 24
                Options.Focusing = False
                Options.HorzSizing = False
                VisibleForCustomization = False
                Width = 24
              end
              object cxGridDocPayerGoods_GOODS_NAME: TcxGridDBColumn
                Caption = 'Denumire'
                DataBinding.FieldName = 'GOODS_NAME'
                Width = 200
              end
              object cxGridDBColumn22: TcxGridDBColumn
                AlternateCaption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
                Caption = 'Cant'
                DataBinding.FieldName = 'QTY'
                FooterAlignmentHorz = taRightJustify
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.HorzSizing = False
                Width = 50
              end
              object cxGridDBColumn23: TcxGridDBColumn
                AlternateCaption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
                Caption = 'UM'
                DataBinding.FieldName = 'UM_NAME'
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.HorzSizing = False
                Width = 50
              end
              object cxGridDBColumn24: TcxGridDBColumn
                Caption = 'Pret'
                DataBinding.FieldName = 'PRICE'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 80
                Options.HorzSizing = False
                Width = 80
              end
              object cxGridDBColumn25: TcxGridDBColumn
                Caption = 'Suma'
                DataBinding.FieldName = 'SUMA'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                FooterAlignmentHorz = taRightJustify
                HeaderAlignmentHorz = taCenter
                MinWidth = 80
                Options.HorzSizing = False
                Width = 80
              end
              object cxGridDBColumn26: TcxGridDBColumn
                Caption = 'Activ'
                DataBinding.FieldName = 'FLG_ACTIVE'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = 1
                Properties.ValueUnchecked = 0
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.HorzSizing = False
                Width = 50
              end
              object cxGridDBColumn27: TcxGridDBColumn
                Caption = 'Gata'
                DataBinding.FieldName = 'FLG_READY'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = 1
                Properties.ValueUnchecked = 0
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.HorzSizing = False
                Width = 50
              end
            end
            object cxGridDocPayerGoodsLevel: TcxGridLevel
              GridView = cxGridDocPayerGoodsTable
            end
          end
          object dxBarDockControl3: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 1010
            Height = 34
            Align = dalTop
            BarManager = dxBarManager
            SunkenBorder = True
            UseOwnSunkenBorder = True
            ExplicitWidth = 851
          end
          object dxBarDockControl4: TdxBarDockControl
            Left = 0
            Top = 96
            Width = 1010
            Height = 34
            Align = dalTop
            BarManager = dxBarManager
            SunkenBorder = True
            UseOwnSunkenBorder = True
            ExplicitWidth = 851
          end
        end
        object tsIncidentStatus: TTabSheet
          Caption = 'Statutul incidentului'
          ImageIndex = 5
          object cxGridIncidentStatuses: TcxGrid
            Left = 0
            Top = 0
            Width = 1030
            Height = 268
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 983
            object cxGridIncidentStatusesTable: TcxGridDBTableView
              DataController.DataSource = IBCDS_Incident_Status
              FilterRow.SeparatorWidth = 8
              FixedDataRows.SeparatorWidth = 8
              NewItemRow.SeparatorWidth = 8
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
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
              Styles.Footer = dmAdditions.cxStyle_GridHeader
              Styles.Header = dmAdditions.cxStyle_GridHeader
              Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
              object cxGridIncidentStatuses_DATA: TcxGridDBColumn
                Caption = 'Data'
                DataBinding.FieldName = 'DATA'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.Alignment.Horz = taCenter
                OnGetDisplayText = cxGridIncidentStatuses_DATAGetDisplayText
                HeaderAlignmentHorz = taCenter
                MinWidth = 110
                Options.HorzSizing = False
                Width = 110
              end
              object cxGridIncidentStatusesTableColumn2: TcxGridDBColumn
                Caption = 'Statut'
                DataBinding.FieldName = 'STATUSID_NAME'
                Width = 100
              end
              object cxGridIncidentStatusesTableColumn3: TcxGridDBColumn
                Caption = 'Responsabil'
                DataBinding.FieldName = 'CHANGED_BY_NAME'
                Width = 100
              end
              object cxGridIncidentStatusesTableColumn4: TcxGridDBColumn
                Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                DataBinding.FieldName = 'COMMENTS'
                Width = 300
              end
            end
            object cxGridIncidentStatusesLevel: TcxGridLevel
              GridView = cxGridIncidentStatusesTable
            end
          end
        end
      end
    end
    object cxSplitter2: TcxSplitter
      Left = 0
      Top = 358
      Width = 1018
      Height = 10
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salBottom
      MinSize = 300
      Control = pnBottom
      ExplicitWidth = 859
    end
    object pnTop: TPanel
      Left = 0
      Top = 0
      Width = 1018
      Height = 358
      Align = alClient
      BevelOuter = bvNone
      Padding.Bottom = 2
      ShowCaption = False
      TabOrder = 0
      ExplicitWidth = 859
      object cxGridIncident: TcxGrid
        Left = 0
        Top = 34
        Width = 1018
        Height = 322
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 859
        object cxGridIncidentTable: TcxGridDBTableView
          PopupMenu = pmIncident
          OnKeyDown = cxGridIncidentTableKeyDown
          OnCustomDrawCell = cxGridIncidentTableCustomDrawCell
          OnFocusedRecordChanged = cxGridIncidentTableFocusedRecordChanged
          DataController.KeyFieldNames = 'INCIDENTID'
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsSelection.InvertSelect = False
          OptionsSelection.UnselectFocusedRecordOnExit = False
          OptionsView.CellEndEllipsis = True
          OptionsView.NavigatorOffset = 63
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.GroupRowStyle = grsOffice11
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridIncident_INCIDENTID: TcxGridDBColumn
            Caption = 'Nr'
            DataBinding.FieldName = 'INCIDENTID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 60
          end
          object cxGridIncident_CREATE_DATE: TcxGridDBColumn
            Caption = 'Creat la '
            DataBinding.FieldName = 'CREATED_DATE'
          end
          object cxGridIncidentTable_Data: TcxGridDBColumn
            DataBinding.FieldName = 'Data'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            OnGetDisplayText = cxGridIncidentTable_DataGetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridIncident_EXEC_PERSONAL_GROUP_TITLE: TcxGridDBColumn
            Caption = 'Caterogia reparatiei'
            DataBinding.FieldName = 'EXEC_PERSONAL_GROUP_TITLE'
            MinWidth = 130
            Width = 130
          end
          object cxGridIncident_DT_NAME: TcxGridDBColumn
            Caption = 'Firma'
            DataBinding.FieldName = 'DT_NAME'
            Width = 94
          end
          object cxGridIncident_TYPE_TITLE: TcxGridDBColumn
            Caption = 'Tip'
            DataBinding.FieldName = 'TYPE_TITLE'
            Width = 71
          end
          object cxGridIncident_DOC_CUSTOMER: TcxGridDBColumn
            Caption = 'Client'
            DataBinding.FieldName = 'DOC_CUSTOMER'
            MinWidth = 140
            Styles.Content = dmAdditions.cxStyle_Bold
            Width = 140
          end
          object cxGridIncident_GOODS_TITLE: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'GOODS_TITLE'
            Visible = False
            MinWidth = 200
            Width = 200
          end
          object cxGridIncident_VENDOR_TITLE: TcxGridDBColumn
            Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
            DataBinding.FieldName = 'VENDOR_TITLE'
            Visible = False
            MinWidth = 140
            Width = 140
          end
          object cxGridIncident_PAYER_NAME: TcxGridDBColumn
            Caption = 'Platitor'
            DataBinding.FieldName = 'PAYER_NAME'
            Width = 133
          end
          object cxGridIncident_GOODS_MODEL: TcxGridDBColumn
            Caption = 'Model'
            DataBinding.FieldName = 'GOODS_MODEL'
            MinWidth = 100
            Width = 122
          end
          object cxGridIncident_GOODS_SN: TcxGridDBColumn
            Caption = 'Serie'
            DataBinding.FieldName = 'GOODS_SN'
            MinWidth = 70
            Width = 102
          end
          object cxGridIncident_SOLVED_BY_NAME: TcxGridDBColumn
            Caption = 'Responsabil'
            DataBinding.FieldName = 'SOLVED_BY_NAME'
            Width = 136
          end
        end
        object cxGridIncidentLevel: TcxGridLevel
          GridView = cxGridIncidentTable
        end
      end
      object dxBarDockControlIncidents: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1018
        Height = 34
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
        ExplicitWidth = 859
      end
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 1020
    Top = 0
    Width = 10
    Height = 668
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salRight
    MinSize = 200
    Control = pnRight
    ExplicitLeft = 861
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      #1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1082#1083#1080#1077#1085#1090
      #1056#1072#1089#1093#1086#1076' '#1087#1083#1072#1090#1077#1083#1100#1097#1080#1082)
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    LookAndFeel.NativeStyle = True
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 500
    Top = 88
    PixelsPerInch = 120
    object dxBarManagerBar1: TdxBar
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
      FloatLeft = 1158
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbTaskNew'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbTaskAssign'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbTaskComments'
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
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControlIncidents
      DockedDockControl = dxBarDockControlIncidents
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1185
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCloseIncident'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbIncidentDesc'
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
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockControl = dxBarDockControlRashod
      DockedDockControl = dxBarDockControlRashod
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1168
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRashodGoodsAdd'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRashodEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRashodDelete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRashodSN'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar4: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 4'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1168
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
    object dxBarManagerBarAkt: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 5'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1168
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = False
      WholeRow = False
    end
    object dxBarManagerBar5: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 7'
      CaptionButtons = <>
      DockControl = dxBarDockControlTaskRequest
      DockedDockControl = dxBarDockControlTaskRequest
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1038
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRequestAccept'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar6: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Docs'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 0
      FloatTop = 555
      FloatClientWidth = 51
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbCreateDocument'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar7: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Docs Payer'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1112
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnRashodPayer'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar8: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Goods_Payer'
      CaptionButtons = <>
      DockControl = dxBarDockControl4
      DockedDockControl = dxBarDockControl4
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1112
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbRashodPayerGoodsAdd'
        end
        item
          Visible = True
          ItemName = 'bbRashodPayerGoodsEdit'
        end
        item
          Visible = True
          ItemName = 'bbRashodPayerGoodsRemove'
        end
        item
          Visible = True
          ItemName = 'bbRashodPayerGoodsSN'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbTaskNew: TdxBarButton
      Caption = #1053#1086#1074#1072#1103' '#1079#1072#1076#1072#1095#1072
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1079#1072#1076#1072#1095#1072
      Visible = ivAlways
      ImageIndex = 45
      OnClick = bbTaskNewClick
    end
    object bbTaskComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbTaskCommentsClick
    end
    object bbTaskAssign: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1079#1072#1087#1088#1086#1089
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1079#1072#1087#1088#1086#1089
      Visible = ivAlways
      ImageIndex = 63
      OnClick = bbTaskAssignClick
    end
    object bbRequestAccept: TdxBarButton
      Caption = #1055#1088#1080#1085#1103#1090#1100' '#1079#1072#1087#1088#1086#1089
      Category = 0
      Hint = #1055#1088#1080#1085#1103#1090#1100' '#1079#1072#1087#1088#1086#1089
      Visible = ivAlways
      ImageIndex = 63
      OnClick = bbRequestAcceptClick
    end
    object bbCloseIncident: TdxBarButton
      Caption = 'Incident finisat'
      Category = 0
      Hint = 'Incident finisat'
      Visible = ivAlways
      ImageIndex = 43
      OnClick = bbCloseIncidentClick
    end
    object dxBarLookupCombo1: TdxBarLookupCombo
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        00000000000074120000741200000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFF8080
        80FF808080FFFFFFFFFF000000FFFFFFFFFF808080FF808080FF808080FF8080
        80FF808080FF808080FFFFFFFFFF000000FFFF00FF00000000FFFF0000FFFF00
        00FFFF0000FFFF0000FF000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00
        00FFFF0000FFFF0000FFFF0000FF000000FFFF00FF00000000FFFF0000FF8080
        80FF808080FFFF0000FF000000FFFF0000FF808080FF808080FF808080FF8080
        80FF808080FF808080FFFF0000FF000000FFFF00FF00000000FFFF0000FFFF00
        00FFFF0000FFFF0000FF000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00
        00FFFF0000FFFF0000FFFF0000FF000000FFFF00FF00000000FFFFFFFFFF8080
        80FF808080FFFFFFFFFF000000FFFFFFFFFF808080FF808080FF808080FF8080
        80FF808080FF808080FFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFF8080
        80FF808080FFFFFFFFFF000000FFFFFFFFFF808080FF808080FF808080FF8080
        80FF808080FF808080FFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFF0000FFFF0000FFFF0000FFFF0000FFFFFFFFFFFFFFFFFFFFFF
        FFFF000000FFFF00FF00FF00FF00FF00FF00FF00FF00000000FFFFFFFFFF8080
        80FF808080FF808080FF808080FF808080FF808080FFFFFFFFFFFFFFFFFFFFFF
        FFFF000000FFFF00FF00FF00FF00FF00FF00FF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFF0000FFFF0000FFFF0000FFFF0000FFFFFFFFFFFFFFFFFFFFFF
        FFFF000000FFFF00FF00FF00FF00FF00FF00FF00FF00000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFFF00FF00FF00FF00FF00FF00FF00FF00}
      Width = 125
      ShowEditor = False
      KeyField = 'SYSSID'
      ListField = 'SYSSID;title'
      ListFieldIndex = 1
      RowCount = 7
    end
    object bbNewAct: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' "'#1040#1082#1090' '#1086#1073' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1085#1099#1093' '#1085#1077#1087#1086#1083#1072#1076#1082#1072#1093'"'
      Category = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' "'#1040#1082#1090' '#1086#1073' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1085#1099#1093' '#1085#1077#1087#1086#1083#1072#1076#1082#1072#1093'"'
      Visible = ivAlways
      OnClick = bbNewActClick
    end
    object bbIncidentDesc: TdxBarButton
      Caption = 'Descrierea incidentului'
      Category = 0
      Hint = 'Descrierea incidentului'
      Visible = ivAlways
      ImageIndex = 19
      ShortCut = 115
      OnClick = bbIncidentDescClick
    end
    object dxBarButton2: TdxBarButton
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 1
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 41
    end
    object bbRashodGoodsAdd: TdxBarButton
      Caption = 'Adauga produs/serviciu'
      Category = 1
      Hint = 'Adauga produs/serviciu'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbRashodGoodsAddClick
    end
    object bbRashodEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbRashodEditClick
    end
    object bbRashodSN: TdxBarButton
      Caption = 'Serii/Partide'
      Category = 1
      Hint = 'Serii/Partide'
      Visible = ivAlways
      ImageIndex = 31
      OnClick = bbRashodSNClick
    end
    object bbRashodDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbRashodDeleteClick
    end
    object bbCreateDocument: TdxBarButton
      Caption = 'Creaza vinzare'
      Category = 1
      Hint = 'Creaza vinzare'
      Visible = ivAlways
      ImageIndex = 0
      PaintStyle = psCaptionGlyph
      OnClick = bbCreateDocumentClick
    end
    object btnRashodPayer: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1088#1072#1089#1093#1086#1076' '#1076#1083#1103' '#1087#1083#1072#1090#1077#1083#1100#1097#1080#1082#1072
      Category = 2
      Hint = 'Creaza document vinzare pentru platitor'
      Visible = ivAlways
      ImageIndex = 0
      PaintStyle = psCaptionGlyph
      OnClick = btnRashodPayerClick
    end
    object bbRashodPayerGoodsAdd: TdxBarButton
      Caption = 'Produs nou'
      Category = 2
      Hint = 'Produs nou'
      Visible = ivAlways
      ImageIndex = 40
      PaintStyle = psCaptionGlyph
      OnClick = bbRashodPayerGoodsAddClick
    end
    object bbRashodPayerGoodsEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 2
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      PaintStyle = psCaptionGlyph
      OnClick = bbRashodPayerGoodsEditClick
    end
    object bbRashodPayerGoodsRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      PaintStyle = psCaptionGlyph
      OnClick = bbRashodPayerGoodsRemoveClick
    end
    object bbRashodPayerGoodsSN: TdxBarButton
      Caption = 'Serii / Partide'
      Category = 2
      Hint = 'Serii / Partide'
      Visible = ivAlways
      ImageIndex = 31
      PaintStyle = psCaptionGlyph
      OnClick = bbRashodPayerGoodsSNClick
    end
  end
  object IBCDataSourceTask: TIBCDataSource
    DataSet = IBCQueryTask
    Left = 1244
    Top = 444
  end
  object IBCQueryTask: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      'A.*,'
      'IIF(TASKTYPE_ID in (1),14,'
      '    IIF(TASKTYPE_ID IN (5,6,7,8),'
      '        case A.TASKTYPE_VALUE_INT'
      '          when -1 then 60'
      '          when 0 then 61'
      '          when 1 then 59'
      '        end,'
      '        /* Waiting request accept */'
      '        IIF(TASKTYPE_ID=18,4,'
      '            /* FLG_OTHER_EXECUTANT */'
      '            IIF(GET_FLG_VALUE(TASKTYPE_FLAGS,4)=1,63,45)'
      '           )'
      '    )'
      ') IMAGE_INDEX'
      'FROM SP_SC_GET_INGINER_TASKS(:id) A'
      'ORDER BY DATA')
    MasterFields = 'INCIDENTID'
    DetailFields = 'INCIDENTID'
    Options.DetailDelay = 500
    Left = 1244
    Top = 392
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'INCIDENTID'
        Value = nil
      end>
  end
  object IBCQueryRequest: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' TASKID,'
      ' TITLE,'
      ' COMMENTS,'
      ' CREATED_FULL_NAME,'
      ' END_ESTIMATED_TIME,'
      ' SN'
      'FROM '
      ' SP_SC_GET_INGINER_REQUESTS(:id)')
    Left = 1248
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSourceRequest: TIBCDataSource
    DataSet = IBCQueryRequest
    Left = 1248
    Top = 132
  end
  object cxGridPopupMenuTR: TcxGridPopupMenu
    Grid = cxGridTR
    PopupMenus = <
      item
        GridView = cxGridTRTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuTR
      end>
    Left = 812
    Top = 72
  end
  object dxBarPopupMenuTR: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbRequestAccept'
      end>
    UseOwnFont = False
    Left = 812
    Top = 124
    PixelsPerInch = 120
  end
  object dxBarPopupMenuTask: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbTaskNew'
      end
      item
        Visible = True
        ItemName = 'bbTaskAssign'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbTaskComments'
      end>
    UseOwnFont = False
    Left = 1044
    Top = 64
    PixelsPerInch = 120
  end
  object IBCQueryDocs: TIBCQuery
    KeyFields = 'docid'
    SQLRefresh.Strings = (
      
        'SELECT DOCID, DOCNO, DATA, DT, DT_NAME, CT, CT_NAME, DTDEP, DTDE' +
        'P_NAME, CTDEP, CTDEP_NAME, DTSC, DTSC_NAME, CTSC, SC2, SC2_NAME,' +
        ' SUMA, VAT, CURRENCYID, CURRENCY_NAME, DISCOUNT, RATE, RATEUSD, ' +
        'FLG_SHIP, FLG_ACNT, FLG_DEL, FLG_PROTECTED, FLG_SEND, FLG_RECEIV' +
        'E, FLG_PAID, FLG_INVOICE, FLG_GOODS_ARRIVAL, FLG_READY, FLG_CLOS' +
        'ED, FLG_EXPORTED, FLG_CHILD, CREATED_DATE, CREATED_BY, CREATED_B' +
        'Y_NAME, DELETED_DATE, DELETED_BY, DELETED_BY_NAME, PARENTDOCID, ' +
        'ACC$MASK, DOCTYPEID, DOCTYPE_NAME, CONTRACTID, CONTRACT_CODE, CO' +
        'NTRACT_SIGN_DATE, CONTRACT_CURRENCYID, CONTRACT_TYPE_TITLE, CONT' +
        'RACT_PRICECOLUMN FROM VW_TDB_DOCS'
      'WHERE'
      '  DOCID = :DOCID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_DOCS.*,'
      
        ' COALESCE((SELECT pricecolumn FROM ts_cust_info WHERE customerid' +
        ' = VW_TDB_DOCS.CT),1) CUSTOMER_PRICE_COLUMN'
      'FROM'
      ' VW_TDB_DOCS'
      'where doctypeid=107 and cast(data as date)>=current_date-60')
    MasterFields = 'RASHOD_DOCID'
    DetailFields = 'DOCID'
    AutoCommit = False
    LockMode = lmLockImmediate
    Left = 40
    Top = 148
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RASHOD_DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 40
    Top = 200
  end
  object IBCQueryJurnal: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_JURNAL'
      
        '  (DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLECT_ID' +
        ', GOODSCOMPLECT_NAME, '
      '   GOODSID, GOODS_NAME, GOODS_TYPE_ID, '
      
        '   UMID, UM_NAME, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY' +
        ', COST, '
      '   FLG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, :GOODSCOMPL' +
        'ECT_ID, :GOODSCOMPLECT_NAME, '
      '   :GOODSID, :GOODS_NAME, :GOODS_TYPE_ID, '
      
        '   :UMID, :UM_NAME, :QTY, :PRICE, :SUMA, :SUMAVAT, :WARRANTY, :S' +
        'TOCK_QTY, :COST, '
      '   :FLG_ACTIVE, :FLG_ACNT, :FLG_READY, :FLG_DELETE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_JURNAL'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_JURNAL'
      'SET'
      
        ' DOCID = :DOCID, DTDEP = :DTDEP, DTDEP_NAME = :DTDEP_NAME, CTDEP' +
        ' = :CTDEP, CTDEP_NAME = :CTDEP_NAME, '
      
        ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID, GOODSCOMPLECT_NAME = :GOO' +
        'DSCOMPLECT_NAME, '
      ' GOODSID = :GOODSID, GOODS_NAME = :GOODS_NAME, '
      
        ' GOODS_TYPE_ID = :GOODS_TYPE_ID, UMID = :UMID, UM_NAME = :UM_NAM' +
        'E, QTY = :QTY, '
      
        ' PRICE = :PRICE, SUMA = :SUMA, SUMAVAT = :SUMAVAT, WARRANTY = :W' +
        'ARRANTY, STOCK_QTY = :STOCK_QTY, '
      ' COST = :COST, '
      ''
      ' FLG_ACTIVE = :FLG_ACTIVE, '
      ' FLG_ACNT = :FLG_ACNT, '
      ' FLG_READY = :FLG_READY, '
      ' FLG_DELETE = :FLG_DELETE'
      ''
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' DOCID = :DOCID AND '
      ' DTDEP=:DTDEP AND'
      ' CTDEP=:CTDEP AND'
      ' GOODSCOMPLECT_ID=-1 AND'
      ' GOODSID=:GOODSID')
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
      ' GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceDocs
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Left = 64
    Top = 516
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 64
    Top = 564
  end
  object IBC_Incident_Status: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_SC_INCIDENTE_STATUS'
      
        '  (INCIDENTID, STATUSID, DATA, CHANGED_BY, CHANGED_BY_NAME, COMM' +
        'ENTS)'
      'VALUES'
      
        '  (:INCIDENTID, :STATUSID, :DATA, :CHANGED_BY, :CHANGED_BY_NAME,' +
        ' :COMMENTS)')
    SQLDelete.Strings = (
      'DELETE FROM VW_SC_INCIDENTE_STATUS'
      'WHERE'
      '  INCIDENTID = :Old_INCIDENTID AND STATUSID = :Old_STATUSID')
    SQLUpdate.Strings = (
      'UPDATE VW_SC_INCIDENTE_STATUS'
      'SET'
      
        '  INCIDENTID = :INCIDENTID, STATUSID = :STATUSID, DATA = :DATA, ' +
        'CHANGED_BY = :CHANGED_BY, CHANGED_BY_NAME = :CHANGED_BY_NAME, CO' +
        'MMENTS = :COMMENTS'
      'WHERE'
      '  INCIDENTID = :Old_INCIDENTID AND STATUSID = :Old_STATUSID')
    SQLRefresh.Strings = (
      
        'SELECT INCIDENTID, STATUSID, DATA, CHANGED_BY, CHANGED_BY_NAME, ' +
        'COMMENTS FROM VW_SC_INCIDENTE_STATUS'
      'WHERE'
      '  INCIDENTID = :INCIDENTID AND STATUSID = :STATUSID')
    SQLLock.Strings = (
      'SELECT NULL FROM SC_INCIDENTE_STATUS'
      'WHERE'
      'INCIDENTID = :Old_INCIDENTID AND STATUSID = :Old_STATUSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT * FROM VW_SC_INCIDENTE_STATUS '
      'order by data')
    MasterFields = 'INCIDENTID'
    DetailFields = 'INCIDENTID'
    Left = 572
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'incidentid'
        Value = nil
      end>
  end
  object IBCDS_Incident_Status: TIBCDataSource
    DataSet = IBC_Incident_Status
    Left = 476
    Top = 216
  end
  object pmIncident: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbNewAct'
      end>
    UseOwnFont = False
    Left = 228
    Top = 380
    PixelsPerInch = 120
  end
  object IBCDocs_Pay: TIBCQuery
    KeyFields = 'docid'
    SQLRefresh.Strings = (
      
        'SELECT DOCID, DOCNO, DATA, DT, DT_NAME, CT, CT_NAME, DTDEP, DTDE' +
        'P_NAME, CTDEP, CTDEP_NAME, DTSC, DTSC_NAME, CTSC, SC2, SC2_NAME,' +
        ' SUMA, VAT, CURRENCYID, CURRENCY_NAME, DISCOUNT, RATE, RATEUSD, ' +
        'FLG_SHIP, FLG_ACNT, FLG_DEL, FLG_PROTECTED, FLG_SEND, FLG_RECEIV' +
        'E, FLG_PAID, FLG_INVOICE, FLG_GOODS_ARRIVAL, FLG_READY, FLG_CLOS' +
        'ED, FLG_EXPORTED, FLG_CHILD, CREATED_DATE, CREATED_BY, CREATED_B' +
        'Y_NAME, DELETED_DATE, DELETED_BY, DELETED_BY_NAME, PARENTDOCID, ' +
        'ACC$MASK, DOCTYPEID, DOCTYPE_NAME, CONTRACTID, CONTRACT_CODE, CO' +
        'NTRACT_SIGN_DATE, CONTRACT_CURRENCYID, CONTRACT_TYPE_TITLE, CONT' +
        'RACT_PRICECOLUMN FROM VW_TDB_DOCS'
      'WHERE'
      '  DOCID = :DOCID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_DOCS.*,'
      
        ' COALESCE((SELECT pricecolumn FROM ts_cust_info WHERE customerid' +
        ' = VW_TDB_DOCS.CT),1) CUSTOMER_PRICE_COLUMN'
      'FROM'
      ' VW_TDB_DOCS'
      'where doctypeid=107 and cast(data as date)>=current_date-60')
    MasterFields = 'PAYER_RASHOD_DOCID'
    DetailFields = 'DOCID'
    AutoCommit = False
    LockMode = lmLockImmediate
    Left = 268
    Top = 164
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PAYER_RASHOD_DOCID'
        Value = nil
      end>
  end
  object IBCDS_DocsPay: TIBCDataSource
    DataSet = IBCDocs_Pay
    Left = 268
    Top = 220
  end
  object IBCDS_JurnalPayer: TIBCDataSource
    DataSet = IBC_JurnalPayer
    Left = 392
    Top = 540
  end
  object IBC_JurnalPayer: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_JURNAL'
      
        '  (DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLECT_ID' +
        ', GOODSCOMPLECT_NAME, '
      '   GOODSID, GOODS_NAME, GOODS_TYPE_ID, '
      
        '   UMID, UM_NAME, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY' +
        ', COST, '
      '   FLG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, :GOODSCOMPL' +
        'ECT_ID, :GOODSCOMPLECT_NAME, '
      '   :GOODSID, :GOODS_NAME, :GOODS_TYPE_ID, '
      
        '   :UMID, :UM_NAME, :QTY, :PRICE, :SUMA, :SUMAVAT, :WARRANTY, :S' +
        'TOCK_QTY, :COST, '
      '   :FLG_ACTIVE, :FLG_ACNT, :FLG_READY, :FLG_DELETE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_JURNAL'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_JURNAL'
      'SET'
      
        ' DOCID = :DOCID, DTDEP = :DTDEP, DTDEP_NAME = :DTDEP_NAME, CTDEP' +
        ' = :CTDEP, CTDEP_NAME = :CTDEP_NAME, '
      
        ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID, GOODSCOMPLECT_NAME = :GOO' +
        'DSCOMPLECT_NAME, '
      ' GOODSID = :GOODSID, GOODS_NAME = :GOODS_NAME, '
      
        ' GOODS_TYPE_ID = :GOODS_TYPE_ID, UMID = :UMID, UM_NAME = :UM_NAM' +
        'E, QTY = :QTY, '
      
        ' PRICE = :PRICE, SUMA = :SUMA, SUMAVAT = :SUMAVAT, WARRANTY = :W' +
        'ARRANTY, STOCK_QTY = :STOCK_QTY, '
      ' COST = :COST, '
      ''
      ' FLG_ACTIVE = :FLG_ACTIVE, '
      ' FLG_ACNT = :FLG_ACNT, '
      ' FLG_READY = :FLG_READY, '
      ' FLG_DELETE = :FLG_DELETE'
      ''
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' DOCID = :DOCID AND '
      ' DTDEP=:DTDEP AND'
      ' CTDEP=:CTDEP AND'
      ' GOODSCOMPLECT_ID=-1 AND'
      ' GOODSID=:GOODSID')
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
      ' GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDS_DocsPay
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Left = 392
    Top = 496
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
end
