inherited frameScheduler: TframeScheduler
  Width = 1407
  Height = 852
  Font.Height = -15
  ExplicitWidth = 1407
  ExplicitHeight = 852
  PixelsPerInch = 120
  object Label48: TLabel
    Left = 63
    Top = 29
    Width = 66
    Height = 12
    Alignment = taRightJustify
    Caption = 'luna anterioara'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label52: TLabel
    Left = 59
    Top = 64
    Width = 70
    Height = 12
    Alignment = taRightJustify
    Caption = 'catre anul trecut'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pcPageControl: TcxPageControl
    Left = 0
    Top = 0
    Width = 1407
    Height = 852
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Properties.ActivePage = tbsDelivery
    Properties.CustomButtons.Buttons = <>
    OnChange = cxPageControl2Change
    OnEnter = pcPageControlEnter
    ClientRectBottom = 848
    ClientRectLeft = 4
    ClientRectRight = 1403
    ClientRectTop = 32
    object tbsPersonal: TcxTabSheet
      Caption = 'Evenimente  (&1)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ImageIndex = 0
      ParentFont = False
      object cxScheduler: TcxScheduler
        Left = 0
        Top = 0
        Width = 1399
        Height = 816
        DateNavigator.FirstWeekOfYear = fwyJan1
        DateNavigator.RowCount = 4
        DateNavigator.ShowDatesContainingHolidaysInColor = True
        ViewAgenda.DisplayMode = avmSelectedDays
        ViewDay.Active = True
        ViewDay.AlwaysShowEventTime = True
        ViewDay.AutoContentHeight = True
        ViewDay.DayHeaderModernStyleDisplayMode = hdmDayAndDate
        ViewDay.HeaderContainer = False
        ViewDay.ShowAllDayEventsInContentArea = True
        ViewDay.TimeRulerMinutes = True
        ViewDay.TimeRulerPopupMenu.Items = [rpmiNewEvent, rpmiNewAllDayEvent, rpmiNewReccuringEvent, rpmi60min, rpmi30min, rpmi15min]
        ViewWeek.GroupingKind = gkByResource
        ViewWeek.ShowEndTime = False
        ViewWeek.ShowTimeAsClock = True
        ViewWeeks.GroupingKind = gkByResource
        Align = alClient
        ContentPopupMenu.Items = [cpmiNewEvent, cpmiNewAllDayEvent, cpmiToday, cpmiGoToDate, cpmiGoToThisDay]
        ControlBox.Visible = False
        DialogsLookAndFeel.NativeStyle = True
        DialogsStyle = 'RibbonOffice365'
        EventImages = dmAdditions.cxImageList_SWN
        EventOperations.MovingBetweenResources = False
        EventOperations.Recurrence = False
        EventPopupMenu.Items = [epmiOpen, epmiShowTimeAs, epmiLabel, epmiDelete]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = True
        LookAndFeel.ScrollbarMode = sbmClassic
        LookAndFeel.SkinName = ''
        OptionsBehavior.SelectOnRightClick = True
        OptionsView.StartOfWeek = swMonday
        OptionsView.Style = svsClassic
        OptionsView.WorkDays = [dSunday, dMonday, dTuesday, dWednesday, dThursday, dFriday, dSaturday]
        OptionsView.WorkStart = 0.375000000000000000
        OptionsView.WorkFinish = 0.833333333333333400
        Storage = dmDB.cxSchedulerDBStorage
        TabOrder = 0
        Splitters = {
          17040000FCFFFFFFA604000001000000B004000001000000B50400002F030000}
        StoredClientBounds = {0100000001000000760500002F030000}
      end
    end
    object tbsGeneralInfo: TcxTabSheet
      Caption = 'Extras (&2)'
      ImageIndex = 2
      DesignSize = (
        1399
        816)
      object Label1: TLabel
        Left = 432
        Top = 320
        Width = 147
        Height = 20
        Caption = 'POS Terminal si ECOM'
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1399
        Height = 32
        Align = dalTop
        BarManager = dxBarManager1
      end
      object cxGrid1: TcxGrid
        Left = 4
        Top = 35
        Width = 422
        Height = 438
        TabOrder = 2
        object cxGrid1DBTableView1: TcxGridDBTableView
          DataController.DataSource = IBCDataSource1
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.InvertSelect = False
          OptionsView.NavigatorOffset = 63
          OptionsView.ColumnAutoWidth = True
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.GroupByBox = False
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          object cxGrid1DBTableView1Column1: TcxGridDBColumn
            Caption = 'Analitica'
            DataBinding.FieldName = 'OPERATIA'
            HeaderAlignmentHorz = taCenter
            Width = 271
          end
          object cxGrid1DBTableView1Column2: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '# ### ###.00;(# ###.0);Zero'
            HeaderAlignmentHorz = taCenter
            Width = 77
          end
          object cxGrid1DBTableView1Column3: TcxGridDBColumn
            Caption = 'Anul trecut'
            DataBinding.FieldName = 'PREV_SUMA'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '# ### ###.00;(# ###.0);Zero'
            HeaderAlignmentHorz = taCenter
            Width = 72
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
      object cxGrid3: TcxGrid
        Left = 432
        Top = 34
        Width = 956
        Height = 144
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        object cxGrid3DBTableView1: TcxGridDBTableView
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsView.NavigatorOffset = 63
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.GroupByBox = False
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
        end
        object cxGrid3DBCardView1: TcxGridDBCardView
          DataController.DataSource = IBCDataSourceByUser
          DataController.KeyFieldNames = 'CREATED_BY'
          OptionsView.NavigatorOffset = 63
          OptionsView.CardBorderWidth = 4
          OptionsView.CardIndent = 7
          OptionsView.CardWidth = 250
          OptionsView.CategoryIndent = 21
          OptionsView.CategorySeparatorWidth = 3
          OptionsView.SeparatorWidth = 3
          object cxGrid3DBCardView1Row1: TcxGridDBCardViewRow
            DataBinding.FieldName = 'USERNAME'
            Position.BeginsLayer = True
          end
          object cxGrid3DBCardView1Row2: TcxGridDBCardViewRow
            DataBinding.FieldName = 'SUMA'
            Position.BeginsLayer = True
          end
        end
        object cxGrid3DBChartView1: TcxGridDBChartView
          Categories.DataBinding.FieldName = 'USERNAME'
          DataController.DataSource = IBCDataSourceByUser
          DataController.KeyFieldNames = 'CREATED_BY'
          DiagramArea.Values.HotSpotSize = 19
          DiagramArea.Values.MarkerSize = 9
          DiagramColumn.Active = True
          DiagramColumn.AxisCategory.GridLines = False
          DiagramColumn.Styles.ValueCaptions = dmAdditions.cxStyle_ChatText
          DiagramColumn.Values.BorderWidth = 2
          DiagramColumn.Values.CaptionPosition = cdvcpOutsideEnd
          DiagramLine.Values.HotSpotSize = 19
          DiagramLine.Values.MarkerSize = 9
          DiagramStackedArea.Values.HotSpotSize = 19
          DiagramStackedArea.Values.MarkerSize = 9
          DiagramStackedBar.SideBySideIndentWidth = 3
          DiagramStackedColumn.SideBySideIndentWidth = 3
          object cxGrid3DBChartView1Series1: TcxGridDBChartSeries
            DataBinding.FieldName = 'VINZARI_CREATE'
            DisplayText = 'Create'
          end
          object cxGrid3DBChartView1Series2: TcxGridDBChartSeries
            DataBinding.FieldName = 'VINZARI_INCHISE'
            DisplayText = 'Inchise'
          end
        end
        object cxGrid3Level1: TcxGridLevel
          GridView = cxGrid3DBChartView1
        end
      end
      object cxGrid5: TcxGrid
        Left = 431
        Top = 183
        Width = 956
        Height = 127
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
        object cxgrdbtblvw1: TcxGridDBTableView
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsView.NavigatorOffset = 63
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.GroupByBox = False
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
        end
        object cxGridDBCardView1: TcxGridDBCardView
          DataController.DataSource = IBCDataSourceByUser
          DataController.KeyFieldNames = 'CREATED_BY'
          OptionsView.NavigatorOffset = 63
          OptionsView.CardBorderWidth = 4
          OptionsView.CardIndent = 7
          OptionsView.CardWidth = 250
          OptionsView.CategoryIndent = 21
          OptionsView.CategorySeparatorWidth = 3
          OptionsView.SeparatorWidth = 3
          object cxGridDBCardViewRow1: TcxGridDBCardViewRow
            DataBinding.FieldName = 'USERNAME'
            Position.BeginsLayer = True
          end
          object cxGridDBCardViewRow2: TcxGridDBCardViewRow
            DataBinding.FieldName = 'SUMA'
            Position.BeginsLayer = True
          end
        end
        object cxGridDBChartView1: TcxGridDBChartView
          Categories.DataBinding.FieldName = 'USERNAME'
          DataController.DataSource = IBCDataSourceByWebUser
          DataController.KeyFieldNames = 'CREATED_BY'
          DiagramArea.Values.HotSpotSize = 19
          DiagramArea.Values.MarkerSize = 9
          DiagramColumn.Active = True
          DiagramColumn.AxisCategory.GridLines = False
          DiagramColumn.Styles.ValueCaptions = dmAdditions.cxStyle_ChatText
          DiagramColumn.Values.BorderWidth = 2
          DiagramColumn.Values.CaptionPosition = cdvcpOutsideEnd
          DiagramLine.Values.HotSpotSize = 19
          DiagramLine.Values.MarkerSize = 9
          DiagramStackedArea.Values.HotSpotSize = 19
          DiagramStackedArea.Values.MarkerSize = 9
          DiagramStackedBar.SideBySideIndentWidth = 3
          DiagramStackedColumn.SideBySideIndentWidth = 3
          object cxGridDBChartSeries1: TcxGridDBChartSeries
            DataBinding.FieldName = 'VINZARI_CREATE'
            DisplayText = 'Create'
          end
          object cxGridDBChartSeries2: TcxGridDBChartSeries
            DataBinding.FieldName = 'VINZARI_INCHISE'
            DisplayText = 'Inchise'
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridDBChartView1
        end
      end
      object cxGrid2: TcxGrid
        Left = 4
        Top = 480
        Width = 422
        Height = 331
        Anchors = [akLeft, akTop, akBottom]
        TabOrder = 6
        object cxGridDBTableView1: TcxGridDBTableView
          DataController.DataSource = IBCDataSource2
          DataController.KeyFieldNames = 'OPERATIA;DT_NAME'
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.InvertSelect = False
          OptionsView.NavigatorOffset = 63
          OptionsView.ColumnAutoWidth = True
          OptionsView.FixedColumnSeparatorWidth = 3
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = 'Analitica'
            DataBinding.FieldName = 'OPERATIA'
            Visible = False
            GroupIndex = 0
            HeaderAlignmentHorz = taCenter
            Width = 493
          end
          object cxGridDBTableView1Column1: TcxGridDBColumn
            Caption = 'Organizatia'
            DataBinding.FieldName = 'DT_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 435
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '# ### ###.00;(# ###.0);Zero'
            HeaderAlignmentHorz = taCenter
            Width = 114
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
      object cxGridEComm: TcxGrid
        AlignWithMargins = True
        Left = 431
        Top = 336
        Width = 277
        Height = 209
        BevelOuter = bvRaised
        TabOrder = 4
        object cxGridEComm1: TcxGridDBTableView
          DataController.DataSource = IBCDataSourceBankPosEcomm
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NavigatorOffset = 63
          OptionsView.ColumnAutoWidth = True
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.GroupByBox = False
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          object cxGridEComm1_DATA: TcxGridDBColumn
            Caption = 'data'
            DataBinding.FieldName = 'DATA'
            HeaderAlignmentHorz = taCenter
            Width = 84
          end
          object cxGridEComm1_SumaPosTerminat: TcxGridDBColumn
            Caption = 'pos term.'
            DataBinding.FieldName = 'Suma_Pos'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '# ### ###.00;(# ###.0);Zero'
            HeaderAlignmentHorz = taCenter
            Width = 90
          end
          object cxGridEComm1_SUMA_ECOMM: TcxGridDBColumn
            Caption = 'ecomm'
            DataBinding.FieldName = 'SUMA_ECOMM'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '# ### ###.00;(# ###.0);Zero'
            HeaderAlignmentHorz = taCenter
            Width = 101
          end
        end
        object cxGridECommLevel1: TcxGridLevel
          GridView = cxGridEComm1
        end
      end
      object MonthCalendar1: TMonthCalendar
        Left = 714
        Top = 336
        Width = 191
        Height = 160
        Date = 44627.000000000000000000
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 5
      end
      object cxGrid9: TcxGrid
        Left = 440
        Top = 568
        Width = 937
        Height = 200
        TabOrder = 7
        object cxGrid9DBChartView1: TcxGridDBChartView
          Categories.DataBinding.FieldName = 'DATA'
          DataController.DataSource = IBCDataSourceByDate
          DataController.KeyFieldNames = 'DATA'
          DiagramArea.Values.HotSpotSize = 19
          DiagramArea.Values.MarkerSize = 9
          DiagramLine.Active = True
          DiagramLine.Values.HotSpotSize = 19
          DiagramLine.Values.MarkerSize = 9
          DiagramStackedArea.Values.HotSpotSize = 19
          DiagramStackedArea.Values.MarkerSize = 9
          DiagramStackedBar.SideBySideIndentWidth = 3
          DiagramStackedColumn.SideBySideIndentWidth = 3
          object cxGrid9DBChartView1DataGroup2: TcxGridDBChartDataGroup
            DataBinding.FieldName = 'DATA'
          end
          object cxGrid9DBChartView1DataGroup3: TcxGridDBChartDataGroup
            DataBinding.FieldName = 'VINZARI_INCHISE'
          end
          object cxGrid9DBChartView1DataGroup1: TcxGridDBChartDataGroup
            DataBinding.FieldName = 'VINZARI_CREATE'
          end
          object cxGrid9DBChartView1Series1: TcxGridDBChartSeries
            DataBinding.FieldName = 'VINZARI_CREATE'
          end
          object cxGrid9DBChartView1Series2: TcxGridDBChartSeries
            DataBinding.FieldName = 'VINZARI_INCHISE'
          end
        end
        object cxGrid9Level1: TcxGridLevel
          GridView = cxGrid9DBChartView1
        end
      end
    end
    object tbsCredite: TcxTabSheet
      Caption = 'Creante credite, livrari si plati electronice (&3)'
      ImageIndex = 3
      OnShow = tbsCrediteShow
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 1389
        Height = 806
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        BevelInner = bvRaised
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          1385
          802)
        object cxGrid4: TcxGrid
          AlignWithMargins = True
          Left = 11
          Top = 48
          Width = 530
          Height = 742
          Anchors = [akLeft, akTop, akBottom]
          BevelInner = bvNone
          BevelOuter = bvNone
          TabOrder = 1
          object cxGrid4DBTableView1: TcxGridDBTableView
            OnKeyDown = cxGrid4DBTableView1KeyDown
            FindPanel.DisplayMode = fpdmAlways
            FindPanel.UseExtendedSyntax = True
            DataController.DataSource = dsCrediteNeinchise
            DataController.KeyFieldNames = 'CT'
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '0.00'
                Kind = skSum
                FieldName = 'SUMA_BUH'
                Column = cxGrid4DBTableView1SUMA_TRANSFER
              end>
            FilterRow.SeparatorWidth = 8
            FixedDataRows.SeparatorWidth = 8
            NewItemRow.SeparatorWidth = 8
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NavigatorOffset = 63
            OptionsView.ColumnAutoWidth = True
            OptionsView.FixedColumnSeparatorWidth = 3
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            Preview.LeftIndent = 25
            Preview.RightIndent = 6
            RowLayout.MinValueWidth = 100
            object cxGrid4DBTableView1Column2: TcxGridDBColumn
              Caption = 'cod client'
              DataBinding.FieldName = 'CT'
              Width = 99
            end
            object cxGrid4DBTableView1CT_NAME: TcxGridDBColumn
              Caption = 'cumparator'
              DataBinding.FieldName = 'CUSTOMER_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              HeaderAlignmentHorz = taCenter
              Width = 474
            end
            object cxGrid4DBTableView1SUMA: TcxGridDBColumn
              Caption = 'Creanta gestiune'
              DataBinding.FieldName = 'SUMA_UPR'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              Width = 163
            end
            object cxGrid4DBTableView1SUMA_TRANSFER: TcxGridDBColumn
              Caption = 'Creanta contab'
              DataBinding.FieldName = 'SUMA_BUH'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              Width = 164
            end
          end
          object cxGrid4Level1: TcxGridLevel
            GridView = cxGrid4DBTableView1
          end
        end
        object cxSplitter1: TcxSplitter
          Left = 1
          Top = 796
          Width = 1383
          Height = 5
          AlignSplitter = salBottom
        end
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 1383
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label2: TLabel
            Left = 10
            Top = 13
            Width = 64
            Height = 20
            Caption = 'Nr de zile'
          end
          object ceNDays: TcxCalcEdit
            Left = 80
            Top = 10
            EditValue = 20.000000000000000000
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -15
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.IsFontAssigned = True
            TabOrder = 1
            Width = 49
          end
          object Button1: TButton
            Left = 135
            Top = 9
            Width = 106
            Height = 25
            Caption = 'Actualizeaza'
            ImageIndex = 36
            Images = dmAdditions.cxImageList_SWN
            TabOrder = 0
            OnClick = Button1Click
          end
        end
        object cxGridHistoryCash: TcxGrid
          AlignWithMargins = True
          Left = 567
          Top = 416
          Width = 810
          Height = 369
          Margins.Left = 8
          Margins.Top = 8
          Margins.Right = 8
          Margins.Bottom = 8
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 3
          object cxGridHistoryCashTable: TcxGridDBTableView
            PopupMenu = dxBarPopupMenu1
            OnKeyDown = cxGridHistoryCashTableKeyDown
            DataController.DataSource = IBCDataSourceHistoryCash
            DataController.KeyFieldNames = 'DOCID'
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '0.00'
                Kind = skSum
                FieldName = 'SUMA'
                Column = cxGridHistoryCash_SUMA
              end>
            FilterRow.SeparatorWidth = 8
            FixedDataRows.SeparatorWidth = 8
            NewItemRow.SeparatorWidth = 8
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
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
            OptionsView.Indicator = True
            Preview.LeftIndent = 25
            Preview.RightIndent = 6
            RowLayout.MinValueWidth = 100
            Styles.Group = dmAdditions.cxStyle_Bold
            Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridHistoryCash_DOCID: TcxGridDBColumn
              Caption = 'Nr. doc'
              DataBinding.FieldName = 'DOCID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 50
            end
            object cxGridHistoryCash_DATA: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'DATA'
              MinWidth = 60
              Options.Grouping = False
              Width = 60
            end
            object cxGridHistoryCash_DOCTYPE_NAME: TcxGridDBColumn
              Caption = 'Tip document'
              DataBinding.FieldName = 'DOCTYPE_NAME'
              MinWidth = 50
              Width = 200
            end
            object cxGridHistoryCash_SUMA: TcxGridDBColumn
              Caption = 'Suma Buh'
              DataBinding.FieldName = 'SUMA_BUH'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridHistoryCash_SUMA_USD: TcxGridDBColumn
              Caption = 'Suma Urp'
              DataBinding.FieldName = 'SUMA_UPR'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridHistoryCash_CURRENCY_NAME: TcxGridDBColumn
              Caption = 'Valuta'
              DataBinding.FieldName = 'CURRENCY_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridHistoryCash_RATE: TcxGridDBColumn
              Caption = 'Rata'
              DataBinding.FieldName = 'RATE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.0000'
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 50
            end
            object cxGridHistoryCash_CREATED_BY: TcxGridDBColumn
              Caption = 'Utilizator'
              DataBinding.FieldName = 'CREATED_BY_NAME'
              MinWidth = 40
              Width = 70
            end
          end
          object cxGridHistoryCashLevel: TcxGridLevel
            GridView = cxGridHistoryCashTable
          end
        end
        object cxGrid8: TcxGrid
          Left = 567
          Top = 48
          Width = 810
          Height = 357
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          object cxGrid8DBTableView1: TcxGridDBTableView
            OnKeyDown = cxGrid8DBTableView1KeyDown
            DataController.DataSource = IBCDataSourceAWB
            FilterRow.SeparatorWidth = 8
            FixedDataRows.SeparatorWidth = 8
            NewItemRow.SeparatorWidth = 8
            OptionsBehavior.CopyCaptionsToClipboard = False
            OptionsBehavior.CopyRecordsToClipboard = False
            OptionsBehavior.IncSearch = True
            OptionsBehavior.CopyPreviewToClipboard = False
            OptionsBehavior.ImmediateEditor = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NavigatorOffset = 63
            OptionsView.FixedColumnSeparatorWidth = 3
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.LeftIndent = 25
            Preview.RightIndent = 6
            RowLayout.MinValueWidth = 100
            object cxGrid8DBTableView1DOCID: TcxGridDBColumn
              DataBinding.FieldName = 'DOCID'
            end
            object cxGrid8DBTableView1DATA: TcxGridDBColumn
              DataBinding.FieldName = 'DATA'
            end
            object cxGrid8DBTableView1CT_NAME: TcxGridDBColumn
              DataBinding.FieldName = 'CT_NAME'
              Width = 306
            end
            object cxGrid8DBTableView1AWB: TcxGridDBColumn
              DataBinding.FieldName = 'AWB'
              Width = 166
            end
            object cxGrid8DBTableView1SUMA: TcxGridDBColumn
              DataBinding.FieldName = 'SUMA'
            end
            object cxGrid8DBTableView1DATORIE: TcxGridDBColumn
              Caption = 'DATORII'
              DataBinding.FieldName = 'SUMA_CREANTA'
            end
          end
          object cxGrid8Level1: TcxGridLevel
            GridView = cxGrid8DBTableView1
          end
        end
      end
    end
    object tsDashboard: TcxTabSheet
      Caption = 'Dash board (&4)'
      ImageIndex = 4
      OnShow = tsDashboardShow
      DesignSize = (
        1399
        816)
      object Label58: TLabel
        Left = 71
        Top = 37
        Width = 66
        Height = 12
        Alignment = taRightJustify
        Caption = 'luna anterioara'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label61: TLabel
        Left = 67
        Top = 72
        Width = 70
        Height = 12
        Alignment = taRightJustify
        Caption = 'catre anul trecut'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Panel2: TPanel
        Left = -16
        Top = 154
        Width = 369
        Height = 407
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 4
      end
      object Panel9: TPanel
        Left = 0
        Top = 2
        Width = 1081
        Height = 143
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object Label39: TLabel
          Left = 16
          Top = 8
          Width = 211
          Height = 32
          Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1088#1072#1073#1086#1090#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3487029
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Panel11: TPanel
          Left = 16
          Top = 56
          Width = 169
          Height = 73
          BevelOuter = bvNone
          Color = 15987175
          ParentBackground = False
          TabOrder = 3
          object lbSellAmountUSD: TLabel
            Left = 0
            Top = 32
            Width = 81
            Height = 30
            Alignment = taCenter
            AutoSize = False
            Caption = '000 000'
            Color = clBlack
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 9993760
            Font.Height = -19
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object Label49: TLabel
            AlignWithMargins = True
            Left = 8
            Top = 4
            Width = 153
            Height = 15
            Margins.Left = 8
            AutoSize = False
            Caption = 'Vinzari'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3487029
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbSellLastMonth: TLabel
            Left = 112
            Top = 22
            Width = 49
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lbSellAmountMDL: TLabel
            Left = 88
            Top = 32
            Width = 81
            Height = 30
            Alignment = taCenter
            AutoSize = False
            Caption = '000 000'
            Color = clBlack
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 9993760
            Font.Height = -19
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lbSellLastYear: TLabel
            Left = 145
            Top = 56
            Width = 15
            Height = 13
            Alignment = taRightJustify
            Caption = '0%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label59: TLabel
            Left = 35
            Top = 56
            Width = 70
            Height = 12
            Alignment = taRightJustify
            Caption = 'catre anul trecut'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label60: TLabel
            Left = 15
            Top = 21
            Width = 90
            Height = 12
            Alignment = taRightJustify
            Caption = 'catre luna anterioara'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object Panel10: TPanel
          Left = 192
          Top = 56
          Width = 169
          Height = 73
          BevelOuter = bvNone
          Color = 15987175
          ParentBackground = False
          TabOrder = 4
          object Label41: TLabel
            AlignWithMargins = True
            Left = 8
            Top = 4
            Width = 153
            Height = 15
            Margins.Left = 8
            AutoSize = False
            Caption = 'Achizitii'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3487029
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbBuyLastMonth: TLabel
            Left = 112
            Top = 22
            Width = 49
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label62: TLabel
            Left = 35
            Top = 56
            Width = 70
            Height = 12
            Alignment = taRightJustify
            Caption = 'catre anul trecut'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label63: TLabel
            Left = 15
            Top = 21
            Width = 90
            Height = 12
            Alignment = taRightJustify
            Caption = 'catre luna anterioara'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbBuyLastYear: TLabel
            Left = 104
            Top = 56
            Width = 57
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lbBuyAmountMDL: TLabel
            Left = 83
            Top = 32
            Width = 81
            Height = 30
            Alignment = taCenter
            AutoSize = False
            Caption = '000 000'
            Color = clBlack
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 9993760
            Font.Height = -19
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lbBuyAmountUSD: TLabel
            Left = 0
            Top = 32
            Width = 81
            Height = 30
            Alignment = taCenter
            AutoSize = False
            Caption = '000 000'
            Color = clBlack
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 9993760
            Font.Height = -19
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
        end
        object Panel12: TPanel
          Left = 368
          Top = 56
          Width = 169
          Height = 73
          BevelOuter = bvNone
          Color = 15987175
          ParentBackground = False
          TabOrder = 5
          object lbProfitBrutAmountMDL: TLabel
            Left = 8
            Top = 32
            Width = 153
            Height = 30
            Alignment = taCenter
            AutoSize = False
            Caption = '000 000'
            Color = clBlack
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 9993760
            Font.Height = -19
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object Label44: TLabel
            AlignWithMargins = True
            Left = 8
            Top = 4
            Width = 153
            Height = 15
            Margins.Left = 8
            AutoSize = False
            Caption = 'Profit, brut'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3487029
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label40: TLabel
            Left = 15
            Top = 21
            Width = 90
            Height = 12
            Alignment = taRightJustify
            Caption = 'catre luna anterioara'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbProfitBrutLastMonth: TLabel
            Left = 112
            Top = 21
            Width = 49
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lbProfitBrutLastYear: TLabel
            Left = 104
            Top = 56
            Width = 57
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label64: TLabel
            Left = 35
            Top = 56
            Width = 70
            Height = 12
            Alignment = taRightJustify
            Caption = 'catre anul trecut'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object Panel13: TPanel
          Left = 544
          Top = 56
          Width = 169
          Height = 73
          BevelOuter = bvNone
          Color = 15987175
          ParentBackground = False
          TabOrder = 6
          object Label47: TLabel
            AlignWithMargins = True
            Left = 8
            Top = 4
            Width = 153
            Height = 15
            Margins.Left = 8
            AutoSize = False
            Caption = 'Cecul mediu, MDL'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3487029
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbAvgCecLastMonth: TLabel
            Left = 146
            Top = 21
            Width = 15
            Height = 13
            Alignment = taRightJustify
            Caption = '0%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lbAvgCecLastYear: TLabel
            Left = 104
            Top = 56
            Width = 57
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lbSellsCount: TLabel
            Left = 0
            Top = 32
            Width = 81
            Height = 30
            Alignment = taCenter
            AutoSize = False
            Caption = '000 000'
            Color = clBlack
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 9993760
            Font.Height = -19
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lbAvgCec: TLabel
            Left = 88
            Top = 32
            Width = 81
            Height = 30
            Alignment = taCenter
            AutoSize = False
            Caption = '000 000'
            Color = clBlack
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 9993760
            Font.Height = -19
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lbCountLastMonth: TLabel
            Left = 8
            Top = 21
            Width = 68
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lbCountLastYear: TLabel
            Left = 19
            Top = 56
            Width = 57
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
        end
        object cxDateEdit1: TcxDateEdit
          Left = 480
          Top = 19
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -15
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 1
          Width = 97
        end
        object cxDateEdit2: TcxDateEdit
          Left = 584
          Top = 19
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -15
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 2
          Width = 97
        end
        object cxButton1: TcxButton
          Left = 687
          Top = 18
          Width = 33
          Height = 25
          OptionsImage.ImageIndex = 36
          OptionsImage.Images = dmAdditions.cxImageList_SWN
          TabOrder = 0
          OnClick = cxButton1Click
        end
      end
      object cxGrid6: TcxGrid
        Left = 24
        Top = 151
        Width = 697
        Height = 662
        Anchors = [akLeft, akTop, akBottom]
        TabOrder = 2
        LookAndFeel.ScrollMode = scmClassic
        object cxGrid6TableView1: TcxGridTableView
          OnKeyDown = cxGrid6TableView1KeyDown
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.IncSearch = True
          OptionsBehavior.CopyPreviewToClipboard = False
          OptionsBehavior.ImmediateEditor = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NavigatorOffset = 63
          OptionsView.ColumnAutoWidth = True
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.GroupByBox = False
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          object cxGrid6TableView1Column1: TcxGridColumn
            Caption = 'Cod'
          end
          object cxGrid6TableView1Column2: TcxGridColumn
            Caption = 'Tip produs'
            Width = 150
          end
          object cxGrid6TableView1Column3: TcxGridColumn
            Caption = 'Produs'
            Width = 350
          end
        end
        object cxGrid6Level1: TcxGridLevel
          GridView = cxGrid6TableView1
        end
      end
      object cxGrid7: TcxGrid
        Left = 736
        Top = 151
        Width = 649
        Height = 506
        TabOrder = 3
        object cxGrid7DBTableView1: TcxGridDBTableView
          DataController.DataSource = IBCDataSourceSupplierDebts
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsView.NavigatorOffset = 63
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.GroupByBox = False
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          object cxGrid7DBTableView1CUSTOMERID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'CUSTOMERID'
          end
          object cxGrid7DBTableView1CUSTOMER_NAME: TcxGridDBColumn
            Caption = 'Furnizor'
            DataBinding.FieldName = 'CUSTOMER_NAME'
            Width = 430
          end
          object cxGrid7DBTableView1SUMA_TRANSFER: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA_TRANSFER'
            PropertiesClassName = 'TcxCalcEditProperties'
            OnCustomDrawCell = cxGrid7DBTableView1SUMA_TRANSFERCustomDrawCell
          end
        end
        object cxGrid7Level1: TcxGridLevel
          GridView = cxGrid7DBTableView1
        end
      end
      object btnRefreshSupplierDebts: TcxButton
        Left = 1352
        Top = 120
        Width = 33
        Height = 25
        OptionsImage.ImageIndex = 36
        OptionsImage.Images = dmAdditions.cxImageList_SWN
        TabOrder = 1
        OnClick = btnRefreshSupplierDebtsClick
      end
    end
    object tbsVinzariOperatori: TcxTabSheet
      Caption = 'Vinzari operatori (&5)'
      ImageIndex = 5
      OnShow = tbsVinzariOperatoriShow
      DesignSize = (
        1399
        816)
      object cxDBPivotGrid1: TcxDBPivotGrid
        Left = 3
        Top = 40
        Width = 1393
        Height = 773
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = IBCDataSourceVinzariOperator
        Groups = <>
        TabOrder = 3
        object cxDBPivotGrid1Field1: TcxDBPivotGridField
          Area = faRow
          AreaIndex = 0
          DataBinding.FieldName = 'LOGIN_NAME'
          Visible = True
          UniqueName = 'LOGIN_NAME'
        end
        object cxDBPivotGrid1Field2: TcxDBPivotGridField
          Area = faColumn
          AreaIndex = 0
          DataBinding.FieldName = 'DATA'
          Visible = True
          UniqueName = 'DATA'
        end
        object cxDBPivotGrid1Field3: TcxDBPivotGridField
          Area = faData
          AreaIndex = 0
          DataBinding.FieldName = 'SUMA'
          Visible = True
          UniqueName = 'SUMA'
        end
        object cxDBPivotGrid1Field4: TcxDBPivotGridField
          AreaIndex = 0
          DataBinding.FieldName = 'AVG_SUMA'
          Visible = True
          UniqueName = 'AVG_SUMA'
        end
        object cxDBPivotGrid1Field5: TcxDBPivotGridField
          AreaIndex = 1
          DataBinding.FieldName = 'CNT'
          Visible = True
          UniqueName = 'CNT'
        end
      end
      object deVinzOper1: TcxDateEdit
        Left = 3
        Top = 9
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        Width = 97
      end
      object deVinzOper2: TcxDateEdit
        Left = 107
        Top = 9
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 1
        Width = 97
      end
      object cxButton2: TcxButton
        Left = 211
        Top = 9
        Width = 33
        Height = 25
        OptionsImage.ImageIndex = 36
        OptionsImage.Images = dmAdditions.cxImageList_SWN
        TabOrder = 2
        OnClick = cxButton2Click
      end
    end
    object tbsDelivery: TcxTabSheet
      Caption = 'Livrari'
      ImageIndex = 1
      OnShow = tbsDeliveryShow
      DesignSize = (
        1399
        816)
      object cxDBPivotGrid2: TcxDBPivotGrid
        Left = 16
        Top = 64
        Width = 1361
        Height = 733
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = IBCDataSourcePivot1
        Groups = <>
        OptionsView.RowGrandTotalWidth = 69
        TabOrder = 0
        object cxDBPivotGrid2LUNA: TcxDBPivotGridField
          Area = faColumn
          AreaIndex = 0
          IsCaptionAssigned = True
          Caption = 'Data'
          DataBinding.FieldName = 'LUNA'
          Visible = True
          UniqueName = 'Data'
        end
        object cxDBPivotGrid2WEBGOODSTYPE_NAME: TcxDBPivotGridField
          Area = faRow
          AreaIndex = 0
          IsCaptionAssigned = True
          Caption = 'Categorie'
          DataBinding.FieldName = 'WEBGOODSTYPE_NAME'
          Visible = True
          Width = 300
          UniqueName = 'Categorie'
        end
        object cxDBPivotGrid2VENIT: TcxDBPivotGridField
          Area = faData
          AreaIndex = 0
          IsCaptionAssigned = True
          Caption = 'Venit'
          DataBinding.FieldName = 'VENIT'
          Visible = True
          UniqueName = 'Venit'
        end
        object cxDBPivotGrid2RULAJ: TcxDBPivotGridField
          Area = faData
          AreaIndex = 1
          IsCaptionAssigned = True
          Caption = 'Rulaj'
          DataBinding.FieldName = 'RULAJ'
          Visible = True
          UniqueName = 'Rulaj'
        end
        object cxDBPivotGrid2PROCENT: TcxDBPivotGridField
          Area = faData
          AreaIndex = 3
          IsCaptionAssigned = True
          Caption = '%'
          DataBinding.FieldName = 'PROCENT'
          Visible = True
          UniqueName = '%'
        end
        object cxDBPivotGrid2QTY: TcxDBPivotGridField
          Area = faData
          AreaIndex = 2
          IsCaptionAssigned = True
          Caption = 'Cant'
          DataBinding.FieldName = 'CNT'
          Visible = True
          UniqueName = 'Cant'
        end
      end
      object dePivot1Begin: TcxDateEdit
        Left = 24
        Top = 24
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 1
        Width = 121
      end
      object dePivot1End: TcxDateEdit
        Left = 160
        Top = 24
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 2
        Width = 121
      end
      object cxButton3: TcxButton
        Left = 304
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Actualizeaza'
        TabOrder = 3
        OnClick = cxButton3Click
      end
    end
  end
  object IBCQueryGeneralFinanceReport: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from  DAYLY_REPORT(:data1, :data2)')
    Left = 552
    Top = 424
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'data1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'data2'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQueryGeneralFinanceReport
    Left = 416
    Top = 424
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Unpayed Documents')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 72
    Top = 368
    PixelsPerInch = 120
    object dxBarManager1Bar1: TdxBar
      Caption = 'General Information'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 418
      FloatTop = 236
      FloatClientWidth = 177
      FloatClientHeight = 73
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarDateCombo1'
        end
        item
          Visible = True
          ItemName = 'dxBarDateCombo2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Unpayed documents'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1244
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbRefreshUnpayedDocs'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = False
      WholeRow = False
    end
    object dxBarDateCombo1: TdxBarDateCombo
      Caption = 'perioada din'
      Category = 0
      Hint = 'perioada din'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        00000000000074120000741200000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FF00000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ShowCaption = True
      Width = 125
      ShowDayText = False
    end
    object dxBarDateCombo2: TdxBarDateCombo
      Caption = 'pina la '
      Category = 0
      Hint = 'pina la '
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        00000000000074120000741200000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FF00000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ShowCaption = True
      Width = 125
      ShowDayText = False
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Grid View'
      Category = 0
      Visible = ivAlways
      ImageIndex = 22
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end>
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Date'
      Category = 0
      Hint = 'Date'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Graphic'
      Category = 0
      Hint = 'Graphic'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object bbGotoDocument: TdxBarButton
      Caption = 'Treci la document...'
      Category = 0
      Hint = 'Treci la document'
      Visible = ivAlways
      OnClick = bbGotoDocumentClick
    end
    object bbRefreshUnpayedDocs: TdxBarButton
      Caption = 'Refresh'
      Category = 1
      Hint = 'Refresh'
      Visible = ivAlways
    end
  end
  object IBCDataSource2: TIBCDataSource
    DataSet = IBCQuery2
    Left = 416
    Top = 496
  end
  object IBCQuery2: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from Dayly_Report_Detailed (:Data1, :Data2)')
    Left = 552
    Top = 496
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'data1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'data2'
        Value = nil
      end>
  end
  object IBCQueryByUser: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select'
      '    d.created_by, u.first_name || '#39' '#39' || u.last_name username,'
      
        '    sum(iif(cast(d.created_date as date) >= :data1 and cast(d.cr' +
        'eated_date as date) <= :data2, suma * rate, 0)) vinzari_create,'
      
        '    sum(iif(get_flg_value(d.flags, 10) = 1, suma * rate, 0)) vin' +
        'zari_inchise'
      'from tdb_docs d'
      'inner join ts_users u on u.userid = d.created_by'
      'where cast(data as date) >= :data1 and'
      '      cast(data as date) <= :data2 and'
      '      doctypeid = 107'
      'group by 1, 2'
      
        'having(sum(iif(get_flg_value(d.flags, 10) = 0 and cast(d.created' +
        '_date as date) >= :data1 and cast(d.created_date as date) <= :da' +
        'ta2, suma * rate, 0)) <> 0) or (sum(iif(get_flg_value(d.flags, 1' +
        '0) = 1, suma * rate, 0)) <> 0)'
      'order by 1 desc  ')
    Left = 552
    Top = 176
    ParamData = <
      item
        DataType = ftDate
        Name = 'data1'
        ParamType = ptInput
        Value = 43171d
      end
      item
        DataType = ftDate
        Name = 'data2'
        ParamType = ptInput
        Value = 43171d
      end
      item
        DataType = ftDate
        Name = 'data1'
        ParamType = ptInput
        Value = 43171d
      end
      item
        DataType = ftDate
        Name = 'data2'
        ParamType = ptInput
        Value = 43171d
      end
      item
        DataType = ftDate
        Name = 'data1'
        ParamType = ptInput
        Value = 43171d
      end
      item
        DataType = ftDate
        Name = 'data2'
        ParamType = ptInput
        Value = 43171d
      end>
  end
  object IBCDataSourceByUser: TIBCDataSource
    DataSet = IBCQueryByUser
    Left = 416
    Top = 176
  end
  object qCrediteNeinchise: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from sp_customer_debts_ndays(:dt, :ndays)'
      'order by suma_buh')
    AfterScroll = qCrediteNeinchiseAfterScroll
    Left = 552
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'dt'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'NDAYS'
        Value = nil
      end>
  end
  object dsCrediteNeinchise: TIBCDataSource
    DataSet = qCrediteNeinchise
    Left = 416
    Top = 296
  end
  object IBCDataSourceByWebUser: TIBCDataSource
    DataSet = IBCQueryByWebUser
    Left = 416
    Top = 232
  end
  object IBCQueryByWebUser: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select'
      '    d.created_by, s.title username,'
      
        '    sum(iif(cast(d.created_date as date) >= :data1 and cast(d.cr' +
        'eated_date as date) <= :data2, suma * rate, 0)) vinzari_create,'
      
        '    sum(iif(get_flg_value(d.flags, 10) = 1, suma * rate, 0)) vin' +
        'zari_inchise'
      'from tdb_docs d'
      'inner join ts_syss s on s.syssid=d.dtsc'
      'where cast(data as date) >= :data1 and'
      '      cast(data as date) <= :data2 and'
      '      doctypeid = 107 and'
      '      d.created_by = 9'
      'group by 1, 2'
      
        'having(sum(iif(get_flg_value(d.flags, 10) = 0 and cast(d.created' +
        '_date as date) >= :data1 and cast(d.created_date as date) <= :da' +
        'ta2, suma * rate, 0)) <> 0) or (sum(iif(get_flg_value(d.flags, 1' +
        '0) = 1, suma * rate, 0)) <> 0)'
      'order by 1 desc  ')
    Left = 552
    Top = 232
    ParamData = <
      item
        DataType = ftDate
        Name = 'data1'
        ParamType = ptInput
        Value = 43171d
      end
      item
        DataType = ftDate
        Name = 'data2'
        ParamType = ptInput
        Value = 43171d
      end
      item
        DataType = ftDate
        Name = 'data1'
        ParamType = ptInput
        Value = 43171d
      end
      item
        DataType = ftDate
        Name = 'data2'
        ParamType = ptInput
        Value = 43171d
      end
      item
        DataType = ftDate
        Name = 'data1'
        ParamType = ptInput
        Value = 43171d
      end
      item
        DataType = ftDate
        Name = 'data2'
        ParamType = ptInput
        Value = 43171d
      end>
  end
  object IBCQueryDocsUnpayed: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'SELECT d.ct, CT_NAME, CURRENCY_NAME, sum(SUMA) dt_suma, sum(p.su' +
        'ma_cash) suma_numerar, sum(p.suma_transfer) suma_transfer '
      'FROM VW_TDB_DOCS D'
      'inner join ts_cust_1c c on c.customerid=d.dt'
      'left outer join sp_calc_debts_by_dt(d.ct) p on p.dt=c.dt'
      'WHERE D.FLG_CLOSED=0 AND d.DT=:DT AND d.DOCTYPEID=107'
      'group by 1, 2, 3')
    Left = 688
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceDocsUnpayed: TIBCDataSource
    DataSet = IBCQueryDocsUnpayed
    Left = 688
    Top = 176
  end
  object IBCQueryBankPosEcomm: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select cast(data as date) data,'
      'sum(iif(dtsc = 5114, suma*rate, 0)) suma_ecomm,'
      'sum(iif(dtsc = 5117, suma*rate, 0)) suma_pos'
      
        'from tdb_docs where doctypeid = 120 and cast(data as date)>=curr' +
        'ent_date-10 and dtsc in (5114, 5117)'
      'group by data'
      'order by data desc')
    Left = 552
    Top = 376
  end
  object IBCDataSourceBankPosEcomm: TIBCDataSource
    DataSet = IBCQueryBankPosEcomm
    Left = 416
    Top = 360
  end
  object IBCQueryGoods1: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select g.goodsid, gt.title goods_type_name, g.title'
      'from ts_goods g'
      
        'join tweb_cache_goods cg on cg.goodsid=g.goodsid and exists(sele' +
        'ct * from ts_goods_foreign gf where gf.goodsid = g.goodsid and g' +
        'et_flg_value(gf.flags, 3)=1 and price4=0)'
      'join ts_goods_type gt on gt.goodstypeid=g.webgoodstype_id')
    Left = 992
    Top = 272
  end
  object IBCDataSourceGoods1: TIBCDataSource
    DataSet = IBCQueryGoods1
    Left = 992
    Top = 200
  end
  object IBCQueryVinzariOperator: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select data, login_name,  sum(suma) suma, sum(cnt) cnt, sum(suma' +
        ') / sum(cnt) avg_suma from ('
      
        'select extract (year from d.data)||'#39'.'#39'||extract (month from d.da' +
        'ta) data,  u.login_name, sum(d.SUMA * d.RATE) suma, count(docid)' +
        ' cnt, avg (suma * rate) avg_suma'
      'from TDB_DOCS d'
      'join ts_users u on u.userid = d.created_by and userid <>9'
      'where d.DOCTYPEID = 107 and'
      '      cast(d.data as date) between :DATA1 and :DATA2 and'
      '      get_flg_value(d.flags, 10)=1 and d.suma > 0'
      'group by 1, 2'
      'union all'
      
        'select extract (year from d.data)||'#39'.'#39'||extract (month from d.da' +
        'ta) data,  u.login_name, sum(d.SUMA * d.RATE) suma, count(docid)' +
        ' cnt, avg (suma * rate) avg_suma'
      'from TDB_DOCS d'
      'join ts_syss s on s.syssid = d.dtsc'
      
        'join ts_users u on u.userid = (select value_int from ts_syss s w' +
        'here d.dtsc=s.syssid) and d.created_by = 9'
      'where d.DOCTYPEID = 107 and'
      '      cast(d.data as date) between :DATA1 and :DATA2 and'
      '      get_flg_value(d.flags, 10)=1  and d.suma > 0'
      'group by 1, 2'
      ')'
      'group by 1,2')
    Left = 1200
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA2'
        Value = nil
      end>
  end
  object IBCDataSourceVinzariOperator: TIBCDataSource
    DataSet = IBCQueryVinzariOperator
    Left = 1200
    Top = 120
  end
  object IBCQuerySupplerDebts: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from sp_get_customers_debts(227869)'
      'order by customer_name')
    Left = 992
    Top = 96
  end
  object IBCDataSourceSupplierDebts: TIBCDataSource
    DataSet = IBCQuerySupplerDebts
    Left = 992
    Top = 144
  end
  object IBCQueryHistoryCash: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/*SELECT * FROM SP_CUSTOMER_DEBTS_JOURNAL_ACNT(:CustomerID,NULL)'
      'order by data desc*/'
      ''
      
        'SELECT * FROM sp_calc_debts_new(:customerID, '#39'01.01.2022'#39', curre' +
        'nt_date)'
      'order by data desc')
    MasterSource = dsCrediteNeinchise
    Left = 1196
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
        Value = nil
      end>
  end
  object IBCDataSourceHistoryCash: TIBCDataSource
    DataSet = IBCQueryHistoryCash
    Left = 1196
    Top = 292
  end
  object IBCQueryAWB: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select dd.docid, d.data, d.ct, (select c.displayname from ts_cus' +
        'tomer c where c.customerid = d.ct) ct_name, dd.awb, d.suma,'
      
        '(select sum(z.SUMA_TRANSFER) from sp_calc_debts_by_dt(d.ct) z wh' +
        'ere z.dt = 218482) suma_creanta from tdb_docs_delivery dd'
      'join tdb_docs d on d.docid = dd.docid'
      
        'where dd.awb is not null and dd.courierid = 223850 and cast(d.da' +
        'ta as date)+60 >=current_date'
      
        'and not exists (select * from tdb_distributie_ramburs dr where d' +
        'd.awb = dr.awb)')
    Left = 849
    Top = 392
  end
  object IBCDataSourceAWB: TIBCDataSource
    DataSet = IBCQueryAWB
    Left = 848
    Top = 328
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGotoDocument'
      end>
    UseOwnFont = False
    Left = 849
    Top = 501
    PixelsPerInch = 120
  end
  object IBCQueryPivot1: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT distinct'
      '    luna,'
      '    webgoodstype_name,'
      '    count(*) over(partition by luna, webgoodstype_id) as cnt,'
      
        '    sum(sumamdl_out - sumamdl_in) over(partition by luna, webgoo' +
        'dstype_id) as venit,'
      
        '    sum(sumamdl_out) over(partition by luna, webgoodstype_id) as' +
        ' rulaj,'
      
        '    avg(iif(sumamdl_in = 0, 100, (sumamdl_out / sumamdl_in - 1) ' +
        '* 100)) over(partition by luna, webgoodstype_id) as procent'
      'from ('
      
        '    select extract(year from p.data)||'#39'-'#39'||extract(month from p.' +
        'data) luna, p.goodsid, p.webgoodstype_id, p.webgoodstype_name, s' +
        'um(sumamdl_in) sumamdl_in, sum(sumamdl_out) sumamdl_out'
      
        '    FROM RP_JURNALVINZARI_COST_PRODUSE(:data1, :data2, :vendorli' +
        'st,  :goodsfolderlist, :userid) p'
      '    inner join ts_goods g on g.goodsid=p.goodsid'
      '    left outer join ts_customer c on c.customerid = supplierid'
      '    group by 1, 2, 3, 4'
      ')'
      'ORDER BY luna, venit desc')
    Left = 208
    Top = 504
    ParamData = <
      item
        DataType = ftDate
        Name = 'data1'
        Value = 45474d
      end
      item
        DataType = ftDate
        Name = 'data2'
        Value = 45535d
      end
      item
        DataType = ftUnknown
        Name = 'vendorlist'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'goodsfolderlist'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'userid'
        Value = nil
      end>
  end
  object IBCDataSourcePivot1: TIBCDataSource
    DataSet = IBCQueryPivot1
    Left = 216
    Top = 440
  end
  object IBCQueryByDate: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select cast(D.data as date) data,'
      
        '       sum(iif(cast(D.CREATED_DATE as date) >= :DATA1 and cast(D' +
        '.CREATED_DATE as date) <= :DATA2, SUMA * RATE, 0)) VINZARI_CREAT' +
        'E,'
      
        '       sum(iif(GET_FLG_VALUE(D.FLAGS, 10) = 1, SUMA * RATE, 0)) ' +
        'VINZARI_INCHISE'
      'from TDB_DOCS D'
      'where cast(data as date) >= :DATA1 and'
      '      cast(data as date) <= :DATA2 and'
      '      DOCTYPEID = 107'
      'group by 1'
      'order by 1')
    Left = 1168
    Top = 416
    ParamData = <
      item
        DataType = ftDate
        Name = 'DATA1'
        Value = 45689d
      end
      item
        DataType = ftDate
        Name = 'DATA2'
        Value = 45716d
      end
      item
        DataType = ftDate
        Name = 'DATA1'
        Value = 45689d
      end
      item
        DataType = ftDate
        Name = 'DATA2'
        Value = 45716d
      end>
  end
  object IBCDataSourceByDate: TIBCDataSource
    DataSet = IBCQueryByDate
    Left = 1072
    Top = 416
  end
end
