inherited frame11PeremeshenieP: Tframe11PeremeshenieP
  Width = 543
  Height = 332
  Margins.Left = 3
  Margins.Top = 3
  Margins.Right = 3
  Margins.Bottom = 3
  Font.Height = -12
  ExplicitWidth = 543
  ExplicitHeight = 332
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 132
    Width = 543
    Height = 8
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    DragThreshold = 2
    PositionAfterOpen = 19
    MinSize = 128
    Control = pnBottom
  end
  object cxGridPP: TcxGrid
    Left = 0
    Top = 0
    Width = 543
    Height = 132
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridPPTable: TcxGridDBTableView
      OnKeyDown = cxGridPPTableKeyDown
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
      OnCellDblClick = cxGridPPTableCellDblClick
      OnCustomDrawCell = cxGridPPTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      OptionsBehavior.CopyCaptionsToClipboard = False
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
      Styles.OnGetContentStyle = cxGridPPTableStylesGetContentStyle
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      Styles.OnGetGroupStyle = cxGridPPTableStylesGetGroupStyle
      object cxGridPPTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 38
        Width = 80
      end
      object cxGridPPTable_CREATED_DATE: TcxGridDBColumn
        Caption = 'Data creare'
        DataBinding.FieldName = 'CREATED_DATE'
        OnGetDisplayText = cxGridPPTable_CREATED_DATEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 13
        Width = 80
      end
      object cxGridPPTableData: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridPPTableDataGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Width = 80
      end
      object cxGridPPTable_DT_NAME: TcxGridDBColumn
        Caption = 'Furnizor'
        DataBinding.FieldName = 'DT_NAME'
        MinWidth = 13
        Width = 72
      end
      object cxGridPPTable_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Dep. Furnizor'
        DataBinding.FieldName = 'DTDEP_NAME'
        MinWidth = 13
        Width = 36
      end
      object cxGridPPTable_CT_NAME: TcxGridDBColumn
        Caption = 'Beneficiar'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 13
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 73
      end
      object cxGridPPTable_CTDEP_NAME: TcxGridDBColumn
        Caption = 'Dep. Beneficiar'
        DataBinding.FieldName = 'CTDEP_NAME'
        MinWidth = 13
        Width = 37
      end
      object cxGridPPTableParentDocID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Width = 56
      end
      object Valuta: TcxGridDBColumn
        Caption = #1042#1072#1083#1102#1090#1072
        DataBinding.FieldName = 'CURRENCY_NAME'
        MinWidth = 13
        Width = 36
      end
      object cxGridPP_RATEUSD: TcxGridDBColumn
        Caption = 'Curs USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 38
        Options.HorzSizing = False
        Width = 38
      end
      object cxGridPPTable_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        MinWidth = 13
        Width = 37
      end
      object cxGridPPTableCreatedBy: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 13
        Width = 40
      end
      object cxGridPPTable_FLG_ACNT: TcxGridDBColumn
        AlternateCaption = #1041#1091#1093#1075#1072#1083#1090#1077#1088#1080#1103
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
      object cxGridPPTable_FLG_SEND: TcxGridDBColumn
        AlternateCaption = #1055#1077#1088#1077#1084#1077#1096#1077#1085#1080#1077' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1085#1086
        Caption = 'Transmis'
        DataBinding.FieldName = 'FLG_SEND'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 26
        Options.HorzSizing = False
        Width = 26
      end
      object cxGridPPTable_FLG_RECEIVE: TcxGridDBColumn
        AlternateCaption = 'Tranfer primit'
        Caption = 'Primit'
        DataBinding.FieldName = 'FLG_RECEIVE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        OnGetDisplayText = cxGridPPTable_FLG_RECEIVEGetDisplayText
        GroupIndex = 1
        MinWidth = 26
        Width = 32
      end
      object cxGridPPTable_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 32
      end
      object cxGridPPTable_INCOMING_DOC: TcxGridDBColumn
        AlternateCaption = 'Transfer in asteptare'
        Caption = 'Transfer in asteptare'
        DataBinding.FieldName = 'INCOMING_DOC'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        OnGetDisplayText = cxGridPPTable_INCOMING_DOCGetDisplayText
        FooterAlignmentHorz = taRightJustify
        GroupIndex = 0
        MinWidth = 26
        Width = 32
      end
      object cxGridPP_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        MinWidth = 13
        VisibleForCustomization = False
      end
    end
    object cxGridPPLevel: TcxGridLevel
      GridView = cxGridPPTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 140
    Width = 543
    Height = 192
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object pcPageControlBottom: TcxPageControl
      Left = 0
      Top = 0
      Width = 543
      Height = 192
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = tbsGoods
      Properties.CustomButtons.Buttons = <>
      Properties.Options = [pcoAlwaysShowGoDialogButton, pcoGradient, pcoGradientClientArea, pcoRedrawOnResize, pcoTopToBottomText]
      Properties.TabPosition = tpBottom
      Properties.TabsScroll = False
      LookAndFeel.SkinName = ''
      ClientRectBottom = 166
      ClientRectLeft = 4
      ClientRectRight = 539
      ClientRectTop = 4
      object tbsGoods: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Produse (&1)'
        ImageIndex = 0
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 535
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
        object cxGridJurnal: TcxGrid
          Left = 0
          Top = 30
          Width = 535
          Height = 132
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object cxGridJurnalTable: TcxGridDBTableView
            OnKeyDown = cxGridJurnalTableKeyDown
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
            OnCellDblClick = cxGridJurnalTableCellDblClick
            OnCustomDrawCell = cxGridJurnalTableCustomDrawCell
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
                Column = cxGridJurnal_SUMA
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
              end
              item
                Format = '#,##0.00'
                Kind = skSum
              end
              item
                Kind = skSum
              end>
            OptionsBehavior.CopyCaptionsToClipboard = False
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
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = 'Dep. Furnizor'
              DataBinding.FieldName = 'DTDEP_NAME'
              MinWidth = 32
              Width = 44
            end
            object cxGridDBCol_CTDEP_NAME: TcxGridDBColumn
              Caption = 'Dep. Beneficiar'
              DataBinding.FieldName = 'CTDEP_NAME'
              MinWidth = 32
              Width = 40
            end
            object cxGridDBCol_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 26
              Styles.Footer = dmAdditions.cxStyle_Bold
              Width = 32
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
              MinWidth = 17
              Options.Focusing = False
              Options.HorzSizing = False
              VisibleForCustomization = False
              Width = 17
              IsCaptionAssigned = True
            end
            object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
              Caption = 'Denumire'
              DataBinding.FieldName = 'GOODS_NAME'
              MinWidth = 13
              Width = 107
            end
            object cxGridDBCol_QTY: TcxGridDBColumn
              Caption = 'Cant'
              DataBinding.FieldName = 'QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 38
            end
            object cxGridDBCol_UM_NAME: TcxGridDBColumn
              AlternateCaption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
              Caption = 'UM'
              DataBinding.FieldName = 'UM_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 26
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Sorting = False
              Width = 26
            end
            object cxGridJurna_PRICE: TcxGridDBColumn
              Caption = 'Pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
            end
            object cxGridJurnal_SUMA: TcxGridDBColumn
              Caption = 'Suma'
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
            end
            object cxGridDBCol_FLG_READY: TcxGridDBColumn
              AlternateCaption = 'Valid'
              Caption = 'G'
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 26
              Options.HorzSizing = False
              Width = 26
            end
            object cxGridJurnal_STOCK_QTY: TcxGridDBColumn
              Caption = 'Sold'
              DataBinding.FieldName = 'STOCK_QTY'
              PropertiesClassName = 'TcxCalcEditProperties'
              OnGetDisplayText = cxGridDBCol_QTYGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 38
              Options.HorzSizing = False
              Width = 38
            end
            object cxGridJurna_GOODS_ACNT_ID: TcxGridDBColumn
              AlternateCaption = 'Cod produs pe contabilitlate'
              Caption = 'Cod cont'
              DataBinding.FieldName = 'GOODS_ACNT_ID'
              MinWidth = 26
              Options.HorzSizing = False
              Width = 26
            end
            object cxGridJurnal_GOODS_NAMEACNT: TcxGridDBColumn
              Caption = 'Denumire facturi'
              DataBinding.FieldName = 'GOODS_NAMEACNT'
              MinWidth = 13
              Width = 37
            end
            object cxGridJurnal_PRICE_COLUMN: TcxGridDBColumn
              AlternateCaption = 'Grila de pret'
              Caption = 'P'
              DataBinding.FieldName = 'PRICE_COLUMN'
              HeaderAlignmentHorz = taCenter
              MinWidth = 19
              Options.HorzSizing = False
              Width = 19
            end
            object cxGridJurnal_CREATED_BY_NAME: TcxGridDBColumn
              Caption = 'Utilizator'
              DataBinding.FieldName = 'CREATED_BY_NAME'
              MinWidth = 13
              Width = 28
            end
            object cxGridJurnal_FLG_ACTIVE: TcxGridDBColumn
              Caption = 'Act'
              DataBinding.FieldName = 'FLG_ACTIVE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              MinWidth = 16
              Options.HorzSizing = False
              Width = 16
            end
            object cxGridJurnal_UMID: TcxGridDBColumn
              DataBinding.FieldName = 'UMID'
              Visible = False
              MinWidth = 13
              VisibleForCustomization = False
            end
          end
          object cxGridJurnalLevel: TcxGridLevel
            GridView = cxGridJurnalTable
          end
        end
      end
      object tbsExpenses: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Cheltuieli suplimentare (&2)'
        ImageIndex = 1
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 535
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
        object cxGridExp: TcxGrid
          Left = 0
          Top = 30
          Width = 535
          Height = 132
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          object cxGridExpTable: TcxGridDBTableView
            OnCustomDrawCell = cxGridExpTableCustomDrawCell
            DataController.DataSource = IBCDataSourceExp
            DataController.KeyFieldNames = 'ADDEXPENSEID'
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridExp_ADDEXPENSEID: TcxGridDBColumn
              Caption = 'ID'
              DataBinding.FieldName = 'ADDEXPENSEID'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 45
              Options.HorzSizing = False
              Width = 45
            end
            object cxGridExp_CREATED_DATE: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'CREATED_DATE'
              OnGetDisplayText = cxGridExp_CREATED_DATEGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 77
              Options.HorzSizing = False
              Width = 77
            end
            object cxGridExp_DT_NAME: TcxGridDBColumn
              DataBinding.FieldName = 'DT_NAME'
              Visible = False
              MinWidth = 13
              VisibleForCustomization = False
            end
            object cxGridExp_CT_NAME: TcxGridDBColumn
              DataBinding.FieldName = 'CT_NAME'
              Visible = False
              MinWidth = 13
              VisibleForCustomization = False
            end
            object cxGridExp_ANALITICAID: TcxGridDBColumn
              Caption = 'Analitica'
              DataBinding.FieldName = 'ANALITICA_TITLE'
              MinWidth = 13
              Width = 64
            end
            object cxGridExp_DETAILS: TcxGridDBColumn
              Caption = 'Descrierea'
              DataBinding.FieldName = 'DETAILS'
              MinWidth = 13
              Width = 128
            end
            object cxGridExp_SUMA: TcxGridDBColumn
              Caption = 'Suma, lei'
              DataBinding.FieldName = 'SUMA'
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
              Width = 64
            end
            object cxGridExp_CREATED_BY_NAME: TcxGridDBColumn
              Caption = 'Utilizator'
              DataBinding.FieldName = 'CREATED_BY_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 102
              Options.HorzSizing = False
              Width = 102
            end
          end
          object cxGridExpLevel: TcxGridLevel
            GridView = cxGridExpTable
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
    Categories.Strings = (
      'Default'
      'General'
      'PopupDOCS'
      'PopupJURNAL')
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
    Left = 52
    Top = 80
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'NPN'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 3
      FloatTop = 386
      FloatClientWidth = 110
      FloatClientHeight = 79
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewItem'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyItem'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveItem'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSerials'
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
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1209
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbExpNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbExpEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbExpDelete'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbCreateScetFactura: TdxBarButton
      Caption = 'Creaza factura fiscala...'
      Category = 0
      Hint = 'Creaza factura fiscala'
      Visible = ivAlways
      OnClick = bbCreateScetFacturaClick
    end
    object bbSendGoods: TdxBarButton
      Caption = '2. Transfera produsele'
      Category = 0
      Hint = '2. Transfera produsele'
      Visible = ivAlways
      OnClick = bbSendGoodsClick
    end
    object bbPrintShipmentPaper: TdxBarButton
      Caption = 'Tiparul documentelor,,,'
      Category = 0
      Hint = 'Tiparul documentelor,,,'
      Visible = ivAlways
      ImageIndex = 28
      OnClick = bbPrintShipmentPaperClick
    end
    object bbDocComments: TdxBarButton
      Caption = 'Comentarii'
      Category = 0
      Hint = 'Comentarii'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbUpdateByPriceColumn: TdxBarButton
      Caption = 'Preturi conform grilei de preturi a clientului'
      Category = 0
      Hint = 'Preturi conform grilei de preturi a clientului'
      Visible = ivNever
      ImageIndex = 49
      OnClick = bbUpdateByPriceColumnClick
    end
    object bbExpNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbExpNewClick
    end
    object bbExpEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbExpEditClick
    end
    object bbExpDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbExpDeleteClick
    end
    object bbCancelSendGoods: TdxBarButton
      Caption = 'Anuleaza transmiterea transferului'
      Category = 0
      Hint = 'Anuleaza transmiterea transferului'
      Visible = ivAlways
      OnClick = bbCancelSendGoodsClick
    end
    object bbEnterSerial: TdxBarButton
      Caption = 'Incepe introducerea numerilor de serie'
      Category = 0
      Hint = 'Incepe introducerea numerilor de serie'
      Visible = ivNever
      ShortCut = 16471
      OnClick = bbEnterSerialClick
    end
    object bbObnovitiOstatki: TdxBarButton
      Caption = 'Actualizare solduri'
      Category = 0
      Hint = 'Actualizare solduri'
      Visible = ivAlways
      ImageIndex = 36
      PaintStyle = psCaptionGlyph
      OnClick = bbObnovitiOstatkiClick
    end
    object dxBarLargeButton1: TdxBarLargeButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Intrumente'
      Category = 0
      Hint = 'Intrumente'
      Visible = ivAlways
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbUpdateByPriceColumn'
        end
        item
          Visible = True
          ItemName = 'bbObnovitiOstatki'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbImportSN'
        end
        item
          Visible = True
          ItemName = 'bbImportFromDocument'
        end>
    end
    object bbCompositeScetFactura: TdxBarButton
      Caption = 'Factura fiscala complexa'
      Category = 0
      Hint = 'Factura fiscala complexa'
      Visible = ivAlways
      OnClick = bbCompositeScetFacturaClick
    end
    object bbGoodsInfoCard: TdxBarButton
      Caption = 'Cartela produsului...'
      Category = 0
      Hint = 'Cartela produsului'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsInfoCardClick
    end
    object bbGoodsPrice: TdxBarLargeButton
      Caption = 'Modifica preturile produselor'
      Category = 0
      Hint = 'Modifica preturile produselor'
      Visible = ivAlways
      ShortCut = 16465
      OnClick = bbGoodsPriceClick
    end
    object bbGoodsForeignCode: TdxBarButton
      Caption = 'Coduri de produse de la parteneri...'
      Category = 0
      Hint = 'Coduri de produse de la parteneri'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbGoodsForeignCodeClick
    end
    object btnImportPN: TdxBarButton
      Caption = 'Import din factura de intrare'
      Category = 0
      Hint = 'Import din factura de intrare'
      Visible = ivAlways
      OnClick = btnImportPNClick
    end
    object bbImportSN: TdxBarButton
      Caption = 'Import serii produse...'
      Category = 0
      Hint = 'Import serii produse'
      Visible = ivAlways
      OnClick = bbImportSNClick
    end
    object bbImportFromDocument: TdxBarButton
      Caption = 'Impota din alt document...'
      Category = 0
      Hint = 'Impota din alt document'
      Visible = ivAlways
      OnClick = bbImportFromDocumentClick
    end
    object bbNewItem: TdxBarButton
      Caption = 'Produs nou'
      Category = 1
      Hint = 'Produs nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewItemClick
    end
    object bbModifyItem: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyItemClick
    end
    object bbRemoveItem: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbRemoveItemClick
    end
    object bbSerials: TdxBarButton
      Caption = 'Serii / partide'
      Category = 1
      Hint = 'Serii / partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 117
      OnClick = bbSerialsClick
    end
    object bbDescribeSend: TdxBarButton
      Caption = '1. Pregatirea transferului'
      Category = 2
      Hint = '1. Pregatirea transferului'
      Visible = ivAlways
      ImageIndex = 51
      OnClick = bbDescribeSendClick
    end
    object bbReceiveGoods: TdxBarButton
      Caption = '3. Primeste produsele din transfer'
      Category = 2
      Hint = '3. Primeste produsele din transfer'
      Visible = ivAlways
      OnClick = bbReceiveGoodsClick
    end
  end
  object pmPopupMenuDoc: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'btnImportPN'
      end
      item
        Visible = True
        ItemName = 'bbCreateScetFactura'
      end
      item
        Visible = True
        ItemName = 'bbCompositeScetFactura'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbEnterSerial'
      end
      item
        Visible = True
        ItemName = 'bbDescribeSend'
      end
      item
        Visible = True
        ItemName = 'bbSendGoods'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbReceiveGoods'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCancelSendGoods'
      end
      item
        Visible = True
        ItemName = 'bbPrintShipmentPaper'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end>
    UseOwnFont = False
    OnPopup = pmPopupMenuDocPopup
    Left = 56
    Top = 204
    PixelsPerInch = 96
  end
  object cxGridPopupMenuPP: TcxGridPopupMenu
    Grid = cxGridPP
    PopupMenus = <
      item
        GridView = cxGridPPTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmPopupMenuDoc
      end>
    Left = 52
    Top = 148
  end
  object IBCQueryExp: TIBCQuery
    KeyFields = 'ADDEXPENSEID'
    KeyGenerator = 'SQ_TDB_ADD_EXPENSES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_ADD_EXPENSES'
      '  (ADDEXPENSEID, DOCID, DT, CT, ANALITICAID, DETAILS, SUMA)'
      'VALUES'
      
        '  (:ADDEXPENSEID, :DOCID, :DT, :CT, :ANALITICAID, :DETAILS, :SUM' +
        'A)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_ADD_EXPENSES'
      'WHERE'
      '  ADDEXPENSEID = :Old_ADDEXPENSEID')
    SQLUpdate.Strings = (
      'UPDATE TDB_ADD_EXPENSES'
      'SET'
      ' DOCID = :DOCID, '
      ' DT = :DT, '
      ' CT = :CT, '
      ' ANALITICAID = :ANALITICAID,'
      ' DETAILS = :DETAILS, '
      ' SUMA = :SUMA'
      'WHERE'
      ' ADDEXPENSEID = :Old_ADDEXPENSEID')
    SQLRefresh.Strings = (
      'SELECT '
      '*'
      'FROM '
      ' VW_TDB_ADD_EXPENSES'
      'WHERE'
      ' ADDEXPENSEID = :ADDEXPENSEID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_ADD_EXPENSES'
      'WHERE'
      ' ADDEXPENSEID = :Old_ADDEXPENSEID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM '
      ' VW_TDB_ADD_EXPENSES')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 500
    Left = 416
    Top = 140
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceExp: TIBCDataSource
    DataSet = IBCQueryExp
    Left = 416
    Top = 204
  end
  object cxGridPopupMenuJURNAL: TcxGridPopupMenu
    Grid = cxGridJurnal
    PopupMenus = <
      item
        GridView = cxGridJurnalTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuJURNAL
      end>
    Left = 224
    Top = 100
  end
  object dxBarPopupMenuJURNAL: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbModifyItem'
      end
      item
        Visible = True
        ItemName = 'bbRemoveItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbSerials'
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
    Left = 228
    Top = 212
    PixelsPerInch = 96
  end
end
