inherited frame27AktOprihodovania: Tframe27AktOprihodovania
  Width = 631
  Height = 427
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 631
  ExplicitHeight = 427
  object cxGridAS: TcxGrid
    Left = 0
    Top = 0
    Width = 631
    Height = 174
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridASTable: TcxGridDBTableView
      OnKeyDown = cxGridASTableKeyDown
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
      OnCellDblClick = cxGridASTableCellDblClick
      OnCustomDrawCell = cxGridASTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridAS_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridAS_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridAS_DOCNO: TcxGridDBColumn
        Caption = #8470
        DataBinding.FieldName = 'DOCNO'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridAS_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridAS_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 16
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 160
      end
      object cxGridAS_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridAS_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridAS_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridAS_RATE: TcxGridDBColumn
        Caption = 'Curs Doc.'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridAS_PARENTDOCID: TcxGridDBColumn
        Caption = 'Cod parinte'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridAS_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 16
        Width = 80
      end
      object cxGridAS_FLG_ACNT: TcxGridDBColumn
        Caption = #1041#1091#1093#1075'.'
        DataBinding.FieldName = 'FLG_ACNT'
        Visible = False
        MinWidth = 16
        VisibleForCustomization = False
      end
    end
    object cxGridASLevel: TcxGridLevel
      GridView = cxGridASTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 182
    Width = 631
    Height = 245
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object cxPageControlGeneral: TcxPageControl
      Left = 0
      Top = 0
      Width = 631
      Height = 245
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
      ClientRectBottom = 219
      ClientRectLeft = 4
      ClientRectRight = 627
      ClientRectTop = 4
      object tbsGoods: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Produse (&1)'
        ImageIndex = 0
        object cxGridComponents: TcxGrid
          Left = 0
          Top = 30
          Width = 623
          Height = 185
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
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
                Kind = skSum
                Column = cxGridDBCol_Price
              end
              item
                Kind = skSum
                Column = cxGridDBCol_SUMA
              end
              item
                Kind = skSum
                Column = cxGridDBCol_COST
              end>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
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
              MinWidth = 21
              Options.Editing = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.ShowCaption = False
              Options.Sorting = False
              VisibleForCustomization = False
              Width = 21
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
            object cxGridDBCol_COST: TcxGridDBColumn
              Caption = 'Cost'
              DataBinding.FieldName = 'COST'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridDBCol_Price: TcxGridDBColumn
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
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridDBCol_FLG_READY: TcxGridDBColumn
              Caption = 'G'
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
            end
            object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
              Caption = 'Acnt'
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
        Caption = 'Articole de cheltuieli (&2)'
        ImageIndex = 1
        object cxGridExpenses: TcxGrid
          Left = 0
          Top = 30
          Width = 623
          Height = 185
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
          ExplicitHeight = 189
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
            OnCustomDrawCell = cxGridExpensesTableCustomDrawCell
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
            OptionsCustomize.ColumnFiltering = False
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
            Styles.Footer = dmAdditions.cxStyle_GridHeader
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridExpenses_NAME: TcxGridDBColumn
              Caption = 'Cheltuieli'
              DataBinding.FieldName = 'EXPENSE_TITLE'
              MinWidth = 112
              Width = 140
            end
            object cxGridExpenses_EXPENSE_DOC_ID: TcxGridDBColumn
              Caption = 'Nomer doc'
              DataBinding.FieldName = 'EXPENSE_DOC_ID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 56
              Options.HorzSizing = False
              Width = 56
            end
            object cxGridExpenses_EXPENSE_DOC_DOCTYPE_TITLE: TcxGridDBColumn
              Caption = 'Tip document'
              DataBinding.FieldName = 'EXPENSE_DOC_DOCTYPE_TITLE'
              MinWidth = 16
              Width = 80
            end
            object cxGridExpenses_SUMA: TcxGridDBColumn
              Caption = 'Suma'
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
              Caption = 'Valuta'
              DataBinding.FieldName = 'EXPENSE_DOC_CURRENCY_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridExpenses_RATE: TcxGridDBColumn
              Caption = 'Curs'
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
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 174
    Width = 631
    Height = 8
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    DragThreshold = 2
    PositionAfterOpen = 24
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
      'Goods'
      'Expenses'
      'PopupDoc')
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
    Left = 432
    Top = 492
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
      FloatLeft = 1119
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
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
          ItemName = 'bbGoodsEdit'
        end
        item
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
          ItemName = 'bbGoodsSPNumber'
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
      FloatLeft = 1119
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
          ItemName = 'bbExpenseEdit'
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
    object bbGoodsNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbGoodsNewClick
    end
    object bbGoodsEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbGoodsEditClick
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
    object bbGoodsSPNumber: TdxBarButton
      Caption = 'Numere de Serii / Partide'
      Category = 0
      Hint = 'Numere de Serii / Partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbGoodsSPNumberClick
    end
    object bbActionOpenDoc: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100'...'
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100
      Visible = ivAlways
      OnClick = bbActionOpenDocClick
    end
    object bbDocComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'...'
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbExpenseNew: TdxBarButton
      Caption = #1053#1086#1074#1099#1077' '#1079#1072#1090#1088#1072#1090#1099
      Category = 1
      Hint = #1053#1086#1074#1099#1077' '#1079#1072#1090#1088#1072#1090#1099
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbExpenseNewClick
    end
    object bbExpenseEdit: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 1
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbExpenseEditClick
    end
    object bbExpenseDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 1
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbExpenseDeleteClick
    end
    object bbActionCloseDoc: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1040#1082#1090' '#1086#1087#1088#1080#1093#1086#1076#1086#1074#1072#1085#1080#1103'...'
      Category = 2
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1040#1082#1090' '#1086#1087#1088#1080#1093#1086#1076#1086#1074#1072#1085#1080#1103
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbActionCloseDocClick
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
    Left = 696
    Top = 536
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceExpenses: TIBCDataSource
    DataSet = IBCQueryExpenses
    Left = 696
    Top = 488
  end
  object dxBarPopupMenuAS: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbActionCloseDoc'
      end
      item
        Visible = True
        ItemName = 'bbActionOpenDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end>
    UseOwnFont = False
    Left = 348
    Top = 88
    PixelsPerInch = 96
  end
  object cxGridPopupMenuAS: TcxGridPopupMenu
    Grid = cxGridAS
    PopupMenus = <
      item
        GridView = cxGridASTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuAS
      end>
    Left = 464
    Top = 88
  end
end
