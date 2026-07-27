inherited frame22OstatkiTovara: Tframe22OstatkiTovara
  Width = 631
  Height = 427
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 631
  ExplicitHeight = 427
  object cxGridOT: TcxGrid
    Left = 0
    Top = 0
    Width = 631
    Height = 149
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridOTTable: TcxGridDBTableView
      PopupMenu = dxPopupMenuDocs
      OnKeyDown = cxGridOTTableKeyDown
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
      OnCellDblClick = cxGridOTTableCellDblClick
      OnCustomDrawCell = cxGridOTTableCustomDrawCell
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
      object cxGridOT_DOCID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridOT_DATA: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridOT_DT_NAME: TcxGridDBColumn
        Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
        DataBinding.FieldName = 'DT_NAME'
        MinWidth = 16
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 160
      end
      object cxGridOT_DTDEP: TcxGridDBColumn
        Caption = #1057#1082#1083#1072#1076
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 16
        Width = 80
      end
      object cxGridOT_SUMA: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridOT_CURRENCY_NAME: TcxGridDBColumn
        Caption = #1042#1072#1083#1102#1090#1072
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridOT_VAT: TcxGridDBColumn
        Caption = #1053#1044#1057
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridOT_FLG_ACNT: TcxGridDBColumn
        Caption = #1041#1091#1093#1075
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridOT_CREATED_BY_NAME: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 16
        Width = 90
      end
      object cxGridOT_FLG_CLOSED: TcxGridDBColumn
        Caption = #1047#1072#1082#1088#1099#1090
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
    end
    object cxGridOTLevel: TcxGridLevel
      GridView = cxGridOTTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 157
    Width = 631
    Height = 270
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object cxPageControl: TcxPageControl
      Left = 0
      Top = 0
      Width = 631
      Height = 270
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
      OnChange = cxPageControlChange
      ClientRectBottom = 244
      ClientRectLeft = 4
      ClientRectRight = 627
      ClientRectTop = 4
      object tbsGoods: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1087#1080#1089#1086#1082' '#1090#1086#1074#1072#1088#1072' (&1)'
        ImageIndex = 0
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 30
          Width = 623
          Height = 210
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
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
            OnCustomDrawCell = cxGridGoodsTableCustomDrawCell
            DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
            DataController.Summary.FooterSummaryItems = <
              item
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
                Column = cxGridDBCol_COST
              end>
            OptionsBehavior.CopyCaptionsToClipboard = False
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
            object cxGridGoods_DTDEP: TcxGridDBColumn
              Caption = #1057#1082#1083#1072#1076' '#1082#1086#1076
              DataBinding.FieldName = 'DTDEP'
              Visible = False
              MinWidth = 48
              Options.HorzSizing = False
              Width = 48
            end
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = #1057#1082#1083#1072#1076
              DataBinding.FieldName = 'DTDEP_NAME'
              MinWidth = 112
              Options.HorzSizing = False
              Width = 112
            end
            object cxGridDBCol_GOODSID: TcxGridDBColumn
              Caption = #1050#1086#1076
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              DataBinding.FieldName = 'GOODS_NAME'
              MinWidth = 16
              Width = 160
            end
            object cxGridDBCol_QTY: TcxGridDBColumn
              Caption = #1050#1086#1083'-'#1074#1086
              DataBinding.FieldName = 'QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 48
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 48
            end
            object cxGridDBCol_UM_NAME: TcxGridDBColumn
              Caption = #1045#1048
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
            object cxGridDBCol_Price: TcxGridDBColumn
              Caption = #1062#1077#1085#1072
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridDBCol_COST: TcxGridDBColumn
              Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
              DataBinding.FieldName = 'COST'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridDBCol_SUMA: TcxGridDBColumn
              Caption = #1057#1091#1084#1084#1072
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
              Caption = #1040#1082#1090#1080#1074
              DataBinding.FieldName = 'FLG_ACTIVE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
            end
            object cxGridDBCol_FLG_ACNT: TcxGridDBColumn
              Caption = #1055#1041
              DataBinding.FieldName = 'FLG_ACNT'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
            end
            object cxGridGoods_FLG_READY: TcxGridDBColumn
              Caption = #1043#1086#1090#1086#1074
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
            end
            object cxGridGoods_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = #1050#1086#1076' '#1073#1091#1093#1075
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 48
              Options.HorzSizing = False
              Width = 48
            end
            object cxGridGoods_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086' '#1085#1072#1082#1083#1072#1076#1085#1099#1084
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              MinWidth = 40
              Width = 56
            end
          end
          object cxGridLevel: TcxGridLevel
            GridView = cxGridGoodsTable
          end
        end
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 623
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
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1079#1072#1090#1088#1072#1090#1099' (&2)'
        ImageIndex = 1
        object cxGridExpenses: TcxGrid
          Left = 0
          Top = 30
          Width = 623
          Height = 210
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          ExplicitTop = 27
          ExplicitWidth = 625
          ExplicitHeight = 215
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
                Kind = skSum
                Column = cxGridExpenses_SUMA
              end
              item
                Kind = skCount
                Column = cxGridExpenses_NAME
              end>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
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
            Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridExpenses_NAME: TcxGridDBColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1079#1072#1090#1088#1072#1090
              DataBinding.FieldName = 'EXPENSE_TITLE'
              MinWidth = 112
              Width = 140
            end
            object cxGridExpenses_EXPENSE_DOC_ID: TcxGridDBColumn
              Caption = #1053#1086#1084#1077#1088' '#1076#1086#1082'.'
              DataBinding.FieldName = 'EXPENSE_DOC_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridExpenses_EXPENSE_DOC_DOCTYPE_TITLE: TcxGridDBColumn
              Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
              DataBinding.FieldName = 'EXPENSE_DOC_DOCTYPE_TITLE'
              MinWidth = 16
              Width = 80
            end
            object cxGridExpenses_SUMA: TcxGridDBColumn
              Caption = #1057#1091#1084#1084#1072
              DataBinding.FieldName = 'EXPENSE_DOC_SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridExpenses_CURRENCY: TcxGridDBColumn
              Caption = #1042#1072#1083#1102#1090#1072
              DataBinding.FieldName = 'EXPENSE_DOC_CURRENCY_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridExpenses_RATE: TcxGridDBColumn
              Caption = #1050#1091#1088#1089
              DataBinding.FieldName = 'EXPENSE_DOC_RATE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
          end
          object cxGridExpensesLevel: TcxGridLevel
            GridView = cxGridExpensesTable
          end
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 623
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
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 149
    Width = 631
    Height = 8
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    DragThreshold = 2
    PositionAfterOpen = 240
    MinSize = 160
    Control = pnBottom
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Goods'
      'PopupMenu'
      'Expenses')
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
    Left = 384
    Top = 248
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = #1057#1087#1080#1089#1086#1082' '#1090#1086#1074#1072#1088#1086#1074
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 3
      FloatTop = 386
      FloatClientWidth = 82
      FloatClientHeight = 72
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
          BeginGroup = True
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
          ItemName = 'bbSerialNumbers'
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
      Caption = #1047#1072#1090#1088#1072#1090#1099
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1013
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddExpense'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEditExpense'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteExpense'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbAddGoods: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1090#1086#1074#1072#1088
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddGoodsClick
    end
    object bbModifyGoods: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyGoodsClick
    end
    object bbDeleteGoods: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteGoodsClick
    end
    object bbSerialNumbers: TdxBarButton
      Caption = #1057#1077#1088#1080#1081#1085#1099#1077'/'#1087#1072#1088#1090#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
      Category = 0
      Hint = #1057#1077#1088#1080#1081#1085#1099#1077'/'#1087#1072#1088#1090#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbSerialNumbersClick
    end
    object bbActionCloseDocument: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' "'#1054#1089#1090#1072#1090#1082#1080' '#1090#1086#1074#1072#1088#1072'"...'
      Category = 1
      Hint = #1047#1072#1082#1088#1099#1090#1100' "'#1054#1089#1090#1072#1090#1082#1080' '#1090#1086#1074#1072#1088#1072'"'
      Visible = ivAlways
      OnClick = bbActionCloseDocumentClick
    end
    object bbActionOpenDocument: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' "'#1054#1089#1090#1072#1090#1082#1080' '#1090#1086#1074#1072#1088#1072'"...'
      Category = 1
      Hint = #1054#1090#1082#1088#1099#1090#1100' "'#1054#1089#1090#1072#1090#1082#1080' '#1090#1086#1074#1072#1088#1072'"'
      Visible = ivAlways
      OnClick = bbActionOpenDocumentClick
    end
    object bbAddExpense: TdxBarButton
      Caption = #1053#1086#1074#1099#1077' '#1079#1072#1090#1088#1072#1090#1099
      Category = 2
      Hint = #1053#1086#1074#1099#1077' '#1079#1072#1090#1088#1072#1090#1099
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbAddExpenseClick
    end
    object bbEditExpense: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 2
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbEditExpenseClick
    end
    object bbDeleteExpense: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 2
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteExpenseClick
    end
  end
  object dxPopupMenuDocs: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbActionCloseDocument'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbActionOpenDocument'
      end>
    ItemOptions.ShowDescriptions = False
    ItemOptions.Size = misNormal
    UseOwnFont = False
    OnPopup = dxPopupMenuDocsPopup
    Left = 292
    Top = 124
    PixelsPerInch = 96
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
      ' VW_TDB_DOCS_EXPENSES')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.BooleanDomainFields = True
    Left = 332
    Top = 468
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceExpenses: TIBCDataSource
    DataSet = IBCQueryExpenses
    Left = 332
    Top = 420
  end
  object cxGridDocsPopupMenu: TcxGridPopupMenu
    Grid = cxGridOT
    PopupMenus = <
      item
        GridView = cxGridOTTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxPopupMenuDocs
      end>
    UseBuiltInPopupMenus = False
    Left = 428
    Top = 92
  end
end
