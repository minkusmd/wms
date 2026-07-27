inherited frame26AktSpisania: Tframe26AktSpisania
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
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridASTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu
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
        VisibleForCustomization = False
        Width = 40
      end
      object cxGridAS_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridAS_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 88
        Options.HorzSizing = False
        Width = 88
      end
      object cxGridAS_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 16
        Width = 80
      end
      object cxGridAS_DT_NAME: TcxGridDBColumn
        Caption = 'Subdiviziune'
        DataBinding.FieldName = 'DT_NAME'
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
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
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
      object cxGridAsTable_VAT: TcxGridDBColumn
        Caption = #1053#1044#1057
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 56
        Options.HorzSizing = False
        Width = 56
      end
      object cxGridAS_RATE: TcxGridDBColumn
        Caption = 'Curs doc'
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
        Width = 64
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
    TabOrder = 2
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
                  ImageIndex = 51
                  Value = 4202
                end
                item
                  ImageIndex = 44
                  Value = 4203
                end
                item
                  ImageIndex = 51
                  Value = 4204
                end
                item
                  ImageIndex = 21
                  Value = 4205
                end
                item
                  ImageIndex = 52
                  Value = 4207
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
            object cxGridDBCol_SUMA: TcxGridDBColumn
              Caption = 'Suma'
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
              Caption = 'Act'
              DataBinding.FieldName = 'FLG_ACTIVE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 32
              Options.HorzSizing = False
              Width = 32
            end
            object cxGridComponents_FLG_READY: TcxGridDBColumn
              Caption = 'G'
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 20
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
      object cxtsAttachment: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Documente scanate (&2)'
        ImageIndex = 1
        object cxGridFiles: TcxGrid
          Left = 0
          Top = 28
          Width = 623
          Height = 187
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          ExplicitTop = 26
          ExplicitWidth = 625
          ExplicitHeight = 190
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
              MinWidth = 19
              Options.HorzSizing = False
              Width = 19
            end
            object cxGridFiles_DATA: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'DATA'
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridFiles_FILENAME: TcxGridDBColumn
              Caption = 'File'
              DataBinding.FieldName = 'FILENAME'
              MinWidth = 16
              Width = 240
            end
            object cxGridFiles_FILESIZE: TcxGridDBColumn
              Caption = 'Marime'
              DataBinding.FieldName = 'FILESIZE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 96
              Options.HorzSizing = False
              Width = 96
            end
            object cxGridFiles_CREATED_BY_NAME: TcxGridDBColumn
              Caption = 'Utilizator'
              DataBinding.FieldName = 'CREATED_BY_NAME'
              MinWidth = 16
              Width = 80
            end
          end
          object cxGridFilesLevel: TcxGridLevel
            GridView = cxGridFilesTable
          end
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 623
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
      'Scans'
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
    Left = 433
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
      Caption = 'Scan'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 424
      FloatTop = 556
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbAddFile'
        end
        item
          Visible = True
          ItemName = 'bbSaveFile'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbDeleteFile'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      ShowMark = False
      UseOwnFont = False
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
      Caption = 'Numere Serii / Partide'
      Category = 0
      Hint = 'Numere Serii / Partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbGoodsSPNumberClick
    end
    object bbOpenDoc: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100'...'
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100
      Visible = ivAlways
      OnClick = bbOpenDocClick
    end
    object bbDocComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'...'
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
      Category = 0
      Hint = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
      Visible = ivAlways
      ShortCut = 16466
      OnClick = dxBarButton1Click
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Grila de preturi'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbPrice4'
        end>
    end
    object bbPrice4: TdxBarButton
      Caption = 'Pret online'
      Category = 0
      Hint = 'Pret online'
      Visible = ivAlways
      OnClick = bbPrice4Click
    end
    object bbAddFile: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1092#1072#1081#1083
      Category = 1
      Hint = #1053#1086#1074#1099#1081' '#1092#1072#1081#1083
      Visible = ivAlways
      ImageIndex = 0
      PaintStyle = psCaptionGlyph
      OnClick = bbAddFileClick
    end
    object bbDeleteFile: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 1
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 2
      PaintStyle = psCaptionGlyph
      ShortCut = 16430
      OnClick = bbDeleteFileClick
    end
    object bbSaveFile: TdxBarButton
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
      Category = 1
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
      Visible = ivAlways
      ImageIndex = 32
      PaintStyle = psCaptionGlyph
      OnClick = bbSaveFileClick
    end
    object bbActionCloseDoc: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1040#1082#1090' '#1089#1087#1080#1089#1072#1085#1080#1103'...'
      Category = 2
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1040#1082#1090' '#1089#1087#1080#1089#1072#1085#1080#1103
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbActionCloseDocClick
    end
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbActionCloseDoc'
      end
      item
        Visible = True
        ItemName = 'bbOpenDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end>
    UseOwnFont = False
    Left = 280
    Top = 148
    PixelsPerInch = 96
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGridAS
    PopupMenus = <
      item
        GridView = cxGridASTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenu
      end>
    Left = 500
    Top = 156
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
