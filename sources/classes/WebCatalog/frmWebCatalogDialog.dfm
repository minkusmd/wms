object frmWebCatalogDlg: TfrmWebCatalogDlg
  Left = 0
  Top = 0
  ActiveControl = cxDBTreeList
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Web Catalog'
  ClientHeight = 578
  ClientWidth = 1149
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1149
    Height = 64
    Title = 'Web Catalog'
    Text = 'Administrarea web catalogului de produse'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 30
  end
  object Panel2: TPanel
    Left = 0
    Top = 64
    Width = 1149
    Height = 463
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object pnGoods: TPanel
      Left = 742
      Top = 0
      Width = 407
      Height = 463
      Align = alRight
      BevelOuter = bvNone
      Color = clWindow
      Padding.Left = 1
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      object dxBarDockControl2: TdxBarDockControl
        Left = 1
        Top = 0
        Width = 406
        Height = 28
        Align = dalTop
        BarManager = dxBarManager
      end
      object Panel1: TPanel
        Left = 1
        Top = 28
        Width = 406
        Height = 281
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel1'
        TabOrder = 1
        object cxGridCatalog: TcxGrid
          AlignWithMargins = True
          Left = 1
          Top = 0
          Width = 405
          Height = 239
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          TabOrder = 0
          object cxGridCatalogTable: TcxGridDBTableView
            OnFocusedRecordChanged = cxGridCatalogTableFocusedRecordChanged
            DataController.DataSource = IBCDataSourceGoods
            DataController.KeyFieldNames = 'CATALOGID;GOODSPARENTID'
            OptionsBehavior.CopyCaptionsToClipboard = False
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridCatalog_IMG: TcxGridDBColumn
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.DefaultImageIndex = 12
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <>
              MinWidth = 24
              Options.Editing = False
              Options.ShowEditButtons = isebNever
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridCatalog_GOODSPARENTID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSPARENTID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridCatalog_TITLE: TcxGridDBColumn
              Caption = 'Grupa de produse'
              DataBinding.FieldName = 'TITLE'
            end
            object cxGridCatalog_GOODS_COUNT: TcxGridDBColumn
              Caption = 'Total'
              DataBinding.FieldName = 'GOODS_COUNT'
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridCatalog_FLG_SEE_ALSO: TcxGridDBColumn
              Caption = 'Vezi alte'
              DataBinding.FieldName = 'FLG_SEE_ALSO'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              MinWidth = 50
              Options.HorzSizing = False
              Width = 50
            end
          end
          object cxGridCatalogLevel: TcxGridLevel
            GridView = cxGridCatalogTable
          end
        end
        object pnImage: TPanel
          AlignWithMargins = True
          Left = 1
          Top = 241
          Width = 404
          Height = 40
          Margins.Left = 1
          Margins.Top = 2
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alBottom
          BevelOuter = bvNone
          Padding.Left = 8
          Padding.Top = 8
          Padding.Right = 8
          Padding.Bottom = 8
          ParentBackground = False
          TabOrder = 1
          object imgIMAGE: TcxDBImage
            Left = 8
            Top = 8
            Align = alLeft
            DataBinding.DataField = 'IMAGE'
            DataBinding.DataSource = IBCDataSourceImage
            Properties.GraphicClassName = 'TdxPNGImage'
            Properties.PopupMenuLayout.MenuItems = []
            Properties.ReadOnly = True
            Properties.ShowFocusRect = False
            Style.BorderStyle = ebsNone
            Style.Color = clGray
            TabOrder = 0
            Height = 24
            Width = 24
          end
          object cxDBLabel1: TcxDBLabel
            AlignWithMargins = True
            Left = 40
            Top = 8
            Margins.Left = 8
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            DataBinding.DataField = 'TITLE_RUS'
            DataBinding.DataSource = IBCDataSourceImage
            ParentColor = False
            ParentFont = False
            Properties.Alignment.Vert = taVCenter
            Style.Color = clGray
            Style.Font.Charset = RUSSIAN_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -11
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.TextColor = clWhite
            Style.TextStyle = [fsBold]
            Style.IsFontAssigned = True
            TabOrder = 1
            Height = 24
            Width = 356
            AnchorY = 20
          end
        end
      end
      object dxBarDockControl3: TdxBarDockControl
        Left = 1
        Top = 309
        Width = 406
        Height = 28
        Align = dalTop
        BarManager = dxBarManager
      end
      object cxGridSeeAlso: TcxGrid
        Left = 1
        Top = 337
        Width = 406
        Height = 144
        Align = alTop
        TabOrder = 3
        object cxGridSeeAlsoView: TcxGridDBTableView
          DataController.DataSource = IBCDataSourceSeeAlso
          DataController.KeyFieldNames = 'CATALOGID;GOODSFOLDERID'
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGridSeeAlsoView_GOODSID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GOODSFOLDERID'
            HeaderAlignmentHorz = taCenter
          end
          object cxGridSeeAlsoView_GOODS_NAME: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'GOODSFOLDER_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 300
          end
        end
        object cxGridSeeAlsoLevel1: TcxGridLevel
          GridView = cxGridSeeAlsoView
        end
      end
      object cxGrid1: TcxGrid
        Left = 1
        Top = 500
        Width = 406
        Height = 16
        Align = alClient
        TabOrder = 5
        object cxGrid1DBTableView1: TcxGridDBTableView
          OnKeyDown = cxGrid1DBTableView1KeyDown
          FindPanel.DisplayMode = fpdmAlways
          DataController.DataSource = IBCDataSourceGoodsList
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGrid1DBTableView1Column1: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GoodsID'
            Width = 51
          end
          object cxGrid1DBTableView1Column2: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'TITLE'
            Width = 330
          end
          object cxGrid1DBTableView1Column3: TcxGridDBColumn
            Caption = 'P'
            DataBinding.FieldName = 'FLG_IN_PRICE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.NullStyle = nssUnchecked
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            Width = 23
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
      object cxLabel1: TcxLabel
        Left = 1
        Top = 481
        Align = alTop
        Caption = 'Produse in catalog'
        ParentFont = False
        TabOrder = 4
      end
    end
    object pnTree: TPanel
      Left = 0
      Top = 0
      Width = 742
      Height = 463
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        742
        463)
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 742
        Height = 28
        Align = dalTop
        BarManager = dxBarManager
      end
      object cxDBTreeList: TcxDBTreeList
        Left = 10
        Top = 34
        Width = 730
        Height = 208
        Anchors = [akLeft, akTop, akRight, akBottom]
        Bands = <
          item
          end>
        DataController.DataSource = IBCDataSourceTree
        DataController.ImageIndexField = 'IMAGEINDEX'
        DataController.ParentField = 'PARENTID'
        DataController.KeyField = 'CATALOGID'
        FindPanel.ApplyInputDelay = 500
        FindPanel.DisplayMode = fpdmAlways
        FindPanel.Layout = fplCompact
        FindPanel.UseExtendedSyntax = True
        Images = dmAdditions.cxImageList_SWN
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = True
        OptionsBehavior.ChangeDelay = 1000
        OptionsBehavior.IncSearch = True
        OptionsCustomizing.ColumnCustomizing = False
        OptionsCustomizing.ColumnHorzSizing = False
        OptionsData.Editing = False
        OptionsSelection.CellSelect = False
        OptionsSelection.MultiSelect = True
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Indicator = True
        PopupMenu = dxBarPopupMenu1
        RootValue = 0
        ScrollbarAnnotations.CustomAnnotations = <>
        Styles.OnGetContentStyle = cxDBTreeListStylesGetContentStyle
        Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
        TabOrder = 2
        OnFocusedNodeChanged = cxDBTreeListFocusedNodeChanged
        object cxDBTreeList_TITLE: TcxDBTreeListColumn
          Caption.Text = 'Denumirea'
          DataBinding.FieldName = 'TITLE'
          Width = 70
          Position.ColIndex = 0
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeList_TITLE_RUS: TcxDBTreeListColumn
          Caption.Text = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE_RUS'
          Width = 50
          Position.ColIndex = 1
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeListcx_URL_RO: TcxDBTreeListColumn
          Caption.Text = 'Url'
          DataBinding.FieldName = 'REWRITE_URL_RUS'
          Width = 60
          Position.ColIndex = 2
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeList_CATALOGID: TcxDBTreeListColumn
          Caption.AlignHorz = taCenter
          Caption.Text = 'ID'
          DataBinding.FieldName = 'CATALOGID'
          Options.Sizing = False
          Options.Focusing = False
          Width = 40
          Position.ColIndex = 3
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeList_FLG_ENABLED: TcxDBTreeListColumn
          Visible = False
          DataBinding.FieldName = 'FLG_ENABLED'
          Width = 100
          Position.ColIndex = 4
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeList_FILTER_COUNT: TcxDBTreeListColumn
          Caption.AlignHorz = taCenter
          Caption.Text = 'Filtre'
          DataBinding.FieldName = 'FILTER_COUNT'
          Options.Sizing = False
          Options.Focusing = False
          Width = 40
          Position.ColIndex = 5
          Position.RowIndex = 0
          Position.BandIndex = 0
          OnGetDisplayText = cxDBTreeList_FILTER_COUNTGetDisplayText
        end
        object cxDBTreeList_PoliticaPet: TcxDBTreeListColumn
          Caption.AlignHorz = taCenter
          Caption.GlyphAlignHorz = taCenter
          Caption.Text = 'Politica pret'
          DataBinding.FieldName = 'PGT_NAME'
          Options.Sizing = False
          Width = 60
          Position.ColIndex = 10
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeList_CUSTOM_PRICE_COLUMN_DISPLAY: TcxDBTreeListColumn
          Styles.Content = dmAdditions.cxStyle_TextBoldRed
          Caption.AlignHorz = taCenter
          Caption.Text = 'GP'
          DataBinding.FieldName = 'CUSTOM_PRICE_COLUMN_DISPLAY'
          Options.Sizing = False
          Width = 32
          Position.ColIndex = 6
          Position.RowIndex = 0
          Position.BandIndex = 0
          OnGetDisplayText = cxDBTreeList_CUSTOM_PRICE_COLUMN_DISPLAYGetDisplayText
        end
        object cxDBTreeList_ORDERNO: TcxDBTreeListColumn
          Visible = False
          DataBinding.FieldName = 'ORDERNO'
          Width = 100
          Position.ColIndex = 7
          Position.RowIndex = 0
          Position.BandIndex = 0
          SortOrder = soAscending
          SortIndex = 0
        end
        object cxDBTreeListcxDBTreeListColumn8: TcxDBTreeListColumn
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Caption.AlignHorz = taCenter
          Caption.Text = 'Promo'
          DataBinding.FieldName = 'FLG_PROMO'
          Options.Sizing = False
          Width = 36
          Position.ColIndex = 8
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeListcxDBTreeListColumn9: TcxDBTreeListColumn
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Caption.AlignHorz = taCenter
          Caption.Text = 'New'
          DataBinding.FieldName = 'FLG_NEW'
          Options.Sizing = False
          Width = 36
          Position.ColIndex = 9
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeList_PARENTID: TcxDBTreeListColumn
          VisibleForExpressionEditor = bFalse
          Visible = False
          DataBinding.FieldName = 'PARENTID'
          Width = 100
          Position.ColIndex = 11
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeListcx_FLG_POPULAR: TcxDBTreeListColumn
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Caption.Text = 'Popular'
          DataBinding.FieldName = 'FLG_POPULAR'
          Options.Sizing = False
          Width = 20
          Position.ColIndex = 12
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeListcxDBTreeListColumn14: TcxDBTreeListColumn
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Caption.Text = 'Cat Img'
          DataBinding.FieldName = 'HASCATEGORYIMAGE'
          Options.Sizing = False
          Width = 48
          Position.ColIndex = 13
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
      end
      object cxSplitter1: TcxSplitter
        Left = 0
        Top = 28
        Width = 8
        Height = 220
      end
      object cxPageControl1: TcxPageControl
        Left = 0
        Top = 248
        Width = 742
        Height = 215
        Align = alBottom
        TabOrder = 3
        Properties.ActivePage = tbsReWriteURL
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 211
        ClientRectLeft = 4
        ClientRectRight = 738
        ClientRectTop = 26
        object cxTabSheet2: TcxTabSheet
          Caption = 'Meta descriere'
          ImageIndex = 1
          object cxDBMemo1: TcxDBMemo
            Left = 0
            Top = 28
            Align = alTop
            DataBinding.DataField = 'META_TITLE_RO'
            DataBinding.DataSource = IBCDataSourceCatalogSeo
            ParentFont = False
            Properties.VisibleLineCount = 1
            Style.Font.Charset = RUSSIAN_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -12
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.IsFontAssigned = True
            TabOrder = 0
            Width = 734
          end
          object cxDBMemo2: TcxDBMemo
            Left = 0
            Top = 51
            Align = alTop
            DataBinding.DataField = 'META_TITLE_RU'
            DataBinding.DataSource = IBCDataSourceCatalogSeo
            ParentFont = False
            Properties.VisibleLineCount = 1
            Style.Font.Charset = RUSSIAN_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -12
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.IsFontAssigned = True
            TabOrder = 1
            Width = 734
          end
          object cxDBMemo3: TcxDBMemo
            Left = 0
            Top = 74
            Align = alTop
            DataBinding.DataField = 'META_DESCRIPTION_RO'
            DataBinding.DataSource = IBCDataSourceCatalogSeo
            ParentFont = False
            Properties.VisibleLineCount = 3
            Style.Font.Charset = RUSSIAN_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -12
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.IsFontAssigned = True
            TabOrder = 2
            Width = 734
          end
          object cxDBMemo4: TcxDBMemo
            Left = 0
            Top = 127
            Align = alTop
            DataBinding.DataField = 'META_DESCRIPTION_RU'
            DataBinding.DataSource = IBCDataSourceCatalogSeo
            ParentFont = False
            Properties.VisibleLineCount = 3
            Style.Font.Charset = RUSSIAN_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -12
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.IsFontAssigned = True
            TabOrder = 4
            Width = 734
          end
          object dxBarDockControl5: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 734
            Height = 28
            Align = dalTop
            BarManager = dxBarManager
          end
        end
        object cxTabSheet1: TcxTabSheet
          Caption = 'Articole SEO'
          ImageIndex = 0
          object dxBarDockControl4: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 734
            Height = 28
            Align = dalTop
            BarManager = dxBarManager
          end
          object cxGrid2: TcxGrid
            Left = 0
            Top = 28
            Width = 734
            Height = 157
            Align = alClient
            TabOrder = 1
            ExplicitWidth = 1037
            object cxGrid2DBTableView1: TcxGridDBTableView
              OptionsView.GroupByBox = False
              object cxGrid2DBTableView1_ARTICLEID: TcxGridDBColumn
                Caption = 'Cod'
                DataBinding.FieldName = 'ARTICLEID'
              end
              object cxGrid2DBTableView1_TITLE_RO: TcxGridDBColumn
                Caption = 'Title'
                DataBinding.FieldName = 'TITLE_RO'
                Width = 500
              end
              object cxGrid2DBTableView1_TITLE_RU: TcxGridDBColumn
                Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
                DataBinding.FieldName = 'TITLE_RU'
                Width = 500
              end
            end
            object cxGrid2Level1: TcxGridLevel
              GridView = cxGrid2DBTableView1
            end
          end
        end
        object tbsReWriteURL: TcxTabSheet
          Caption = #1063#1055#1059
          ImageIndex = 2
          object Label4: TLabel
            Left = 267
            Top = 3
            Width = 93
            Height = 15
            Caption = 'ReWrite URL RU'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 3
            Top = 3
            Width = 93
            Height = 15
            Caption = 'ReWrite URL RO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edREWRITE_URL_RUS: TcxDBTextEdit
            Left = 267
            Top = 21
            DataBinding.DataField = 'REWRITE_URL_RUS'
            DataBinding.DataSource = IBCDataSourceTree
            ParentFont = False
            Properties.CharCase = ecLowerCase
            TabOrder = 2
            Width = 237
          end
          object edREWRITE_URL_ROM: TcxDBTextEdit
            Left = 3
            Top = 21
            DataBinding.DataField = 'REWRITE_URL_ROM'
            DataBinding.DataSource = IBCDataSourceTree
            ParentFont = False
            Properties.CharCase = ecLowerCase
            TabOrder = 1
            Width = 237
          end
          object cxButton1: TcxButton
            Left = 519
            Top = 19
            Width = 75
            Height = 25
            Caption = 'Genereaza'
            TabOrder = 0
            OnClick = cxButton1Click
          end
        end
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 527
    Width = 1149
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 8
    Padding.Right = 12
    Padding.Bottom = 12
    TabOrder = 2
    object btnVirtualCategories: TcxButton
      Left = 12
      Top = 8
      Width = 150
      Height = 31
      Caption = 'Categorii virtuale'
      TabOrder = 2
      OnClick = btnVirtualCategoriesClick
    end
    object btnCancel: TcxButton
      Left = 1047
      Top = 8
      Width = 90
      Height = 31
      Align = alRight
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 1
    end
    object btnOK: TcxButton
      Left = 957
      Top = 8
      Width = 90
      Height = 31
      Align = alRight
      Cancel = True
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      Visible = False
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
      'See Also'
      'Main tree'
      'Articles'
      'Meta tags')
    Categories.ItemsVisibles = (
      2
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 364
    Top = 12
    PixelsPerInch = 96
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
      FloatLeft = 588
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewFolder'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyFolder'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteFolder'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCopyNodeProps'
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
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 588
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddGoodsGroup'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbRemoveGoods'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbSortGoods'
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
      Caption = 'See Also Toolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1383
      FloatTop = 518
      FloatClientWidth = 165
      FloatClientHeight = 48
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewSeeAlso'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteSeeAlso'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar4: TdxBar
      Caption = 'Articles'
      CaptionButtons = <>
      DockControl = dxBarDockControl4
      DockedDockControl = dxBarDockControl4
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1427
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewArticle'
        end
        item
          Visible = True
          ItemName = 'bbEditArticle'
        end
        item
          Visible = True
          ItemName = 'bbDeleteArticle'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar5: TdxBar
      Caption = 'Meta tags'
      CaptionButtons = <>
      DockControl = dxBarDockControl5
      DockedDockControl = dxBarDockControl5
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1480
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGenerate'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNewFolderLevel2: TdxBarButton
      Caption = 'Grupa nivelul 2'
      Category = 0
      Hint = 'Grupa nivelul 2'
      Visible = ivAlways
      OnClick = bbNewFolderLevel2Click
    end
    object bbModifyFolder: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyFolderClick
    end
    object bbDeleteFolder: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteFolderClick
    end
    object bbAddGoodsGroup: TdxBarButton
      Caption = 'Adauga grupe cu produse'
      Category = 0
      Hint = 'Adauga grupe cu produse'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 8237
      OnClick = bbAddGoodsGroupClick
    end
    object bbRemoveGoods: TdxBarButton
      Caption = 'Sterge grupa de produse'
      Category = 0
      Hint = 'Sterge grupa de produse'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbRemoveGoodsClick
    end
    object bbSortGoods: TdxBarButton
      Caption = 'Sortarea / aranjeaza'
      Category = 0
      Hint = 'Sortarea / aranjeaza'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortGoodsClick
    end
    object bbNewFolderLevel3: TdxBarButton
      Caption = 'Grupa nivelul 3'
      Category = 0
      Hint = 'Grupa nivelul 3'
      Visible = ivAlways
      OnClick = bbNewFolderLevel3Click
    end
    object bbSortCatalog: TdxBarButton
      Caption = 'Sortare / Aranjare'
      Category = 0
      Hint = 'Sortare / Aranjare'
      Visible = ivAlways
      ImageIndex = 38
      ShortCut = 16467
      OnClick = bbSortCatalogClick
    end
    object bbCatalogFilters: TdxBarButton
      Caption = 'Filtre...'
      Category = 0
      Hint = 'Filtre'
      Visible = ivAlways
      ImageIndex = 26
      ShortCut = 16454
      OnClick = bbCatalogFiltersClick
    end
    object bbVirtualFolders: TdxBarButton
      Caption = 'Mape virtuale...'
      Category = 0
      Hint = 'Mape virtuale (subcategorii pe atribut)'
      Visible = ivAlways
      ImageIndex = 26
      ShortCut = 32845
      OnClick = bbVirtualFoldersClick
    end
    object bbCompatibleGoods: TdxBarButton
      Caption = 'Produse compatibile'
      Category = 0
      Hint = 'Produse compatibile'
      Visible = ivNever
      ImageIndex = 25
      OnClick = bbCompatibleGoodsClick
    end
    object bbBanners: TdxBarButton
      Caption = 'Banere...'
      Category = 0
      Hint = 'Banere'
      Visible = ivAlways
      ImageIndex = 3
      ShortCut = 16450
      OnClick = bbBannersClick
    end
    object bbNewFolder: TdxBarSubItem
      Caption = 'Grupa noua...'
      Category = 0
      Visible = ivAlways
      ImageIndex = 13
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewFolderLevel1'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbNewFolderLevel2'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbNewFolderLevel3'
        end
        item
          Visible = True
          ItemName = 'bbNewFolderLevel4'
        end>
    end
    object bbNewFolderLevel1: TdxBarButton
      Caption = 'Grupa nivelul 1'
      Category = 0
      Hint = 'Grupa nivelul 1'
      Visible = ivAlways
      OnClick = bbNewFolderLevel1Click
    end
    object bbCopyNodeProps: TdxBarSubItem
      Caption = 'Intrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSortCatalog'
        end
        item
          Visible = True
          ItemName = 'bbMoveFolder'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbCatalogFilters'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbVirtualFolders'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCompatibleGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbBanners'
        end
        item
          Visible = True
          ItemName = 'bbGroupImage'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAlsoBuy'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'bbPasteFromNode'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'bbCollapse'
        end>
    end
    object bbGroupImage: TdxBarButton
      Caption = 'Imagini grupa'
      Category = 0
      Hint = 'Imagini grupa'
      Visible = ivAlways
      ShortCut = 16457
      OnClick = bbGroupImageClick
    end
    object bbMoveFolder: TdxBarButton
      Caption = 'Schimba parintele'
      Category = 0
      Hint = 'Schimba parintele'
      Visible = ivAlways
      ShortCut = 16461
      OnClick = bbMoveFolderClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Copy'
      Category = 0
      Hint = 'Copy'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object bbPasteFromNode: TdxBarButton
      Caption = 'Paste'
      Category = 0
      Hint = 'Paste'
      Visible = ivAlways
      ImageIndex = 24
      OnClick = bbPasteFromNodeClick
    end
    object bbAlsoBuy: TdxBarButton
      Caption = 'Cu acest produs mai cumpara...'
      Category = 0
      Hint = 'Cu acest produs mai cumpara'
      Visible = ivAlways
      ImageIndex = 12
      ShortCut = 16464
      OnClick = bbAlsoBuyClick
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Export Tree to Excel...'
      Category = 0
      Hint = 'Export Tree to Excel'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object bbNewFolderLevel4: TdxBarButton
      Caption = 'Grupa nivelul 4'
      Category = 0
      Hint = 'Grupa nivelul 4'
      Visible = ivAlways
      OnClick = bbNewFolderLevel4Click
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Expand all'
      Category = 0
      Hint = 'Expand all'
      Visible = ivAlways
      OnClick = dxBarButton4Click
    end
    object bbCollapse: TdxBarButton
      Caption = 'Collapse all'
      Category = 0
      Hint = 'Collapse all'
      Visible = ivAlways
      OnClick = bbCollapseClick
    end
    object bbNewSeeAlso: TdxBarButton
      Caption = 'Adauga grupa de produse "Vezi alte"'
      Category = 1
      Hint = 'Adauga grupa de produse "Vezi alte"'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewSeeAlsoClick
    end
    object bbDeleteSeeAlso: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteSeeAlsoClick
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Grupa noua in urmatorul nivel'
      Category = 2
      Hint = 'Grupa noua in urmatorul nivel'
      Visible = ivAlways
      ShortCut = 16429
      OnClick = dxBarButton3Click
    end
    object bbNewFolderCurrentLevel: TdxBarButton
      Caption = 'Grupa noua in nivelul curent'
      Category = 2
      Hint = 'Grupa noua in nivelul curent'
      Visible = ivAlways
      ShortCut = 45
      OnClick = bbNewFolderCurrentLevelClick
    end
    object bbNewArticle: TdxBarButton
      Caption = 'Nou'
      Category = 3
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewArticleClick
    end
    object bbEditArticle: TdxBarButton
      Caption = 'Modifica'
      Category = 3
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbEditArticleClick
    end
    object bbDeleteArticle: TdxBarButton
      Caption = 'Sterge'
      Category = 3
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteArticleClick
    end
    object bbGenerate: TdxBarButton
      Caption = 'Genereaza'
      Category = 4
      Hint = 'Genereaza'
      Visible = ivAlways
      ImageIndex = 71
      ShortCut = 117
      OnClick = bbGenerateClick
    end
  end
  object IBCQueryTree: TIBCQuery
    KeyFields = 'CATALOGID'
    KeyGenerator = 'SQ_TWEB_CATALOG_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_CATALOG'
      
        '  (CATALOGID, PARENTID, DT, TITLE, TITLE_RUS, ORDERNO, FLG_ENABL' +
        'ED, FLG_4LEVEL, FLG_GOODS_GROUP, FLG_DELIMITER, FLG_CUSTOM_PRICE' +
        '_COLUMN, FILTER_COUNT, GOODS_GROUP_NAME, CUSTOM_PRICE_COLUMN, CU' +
        'STOM_PRICE_COLUMN_DISPLAY, FLG_VIEWMODE_VITRINA, FLG_DISABLE_VIE' +
        'WMODE_CHANGE, REWRITE_URL_ROM, REWRITE_URL_RUS, PGT_ID, PGT_NAME' +
        ', FLG_PROMO, FLG_NEW, FLG_GROUP_IS_LINK, URL_RO, URL_RU, FLG_POP' +
        'ULAR, FLG_VIRTUAL_CATALOG)'
      'VALUES'
      
        '  (:CATALOGID, :PARENTID, :DT, :TITLE, :TITLE_RUS, :ORDERNO, :FL' +
        'G_ENABLED, :FLG_4LEVEL, :FLG_GOODS_GROUP, :FLG_DELIMITER, :FLG_C' +
        'USTOM_PRICE_COLUMN, :FILTER_COUNT, :GOODS_GROUP_NAME, :CUSTOM_PR' +
        'ICE_COLUMN, :CUSTOM_PRICE_COLUMN_DISPLAY, :FLG_VIEWMODE_VITRINA,' +
        ' :FLG_DISABLE_VIEWMODE_CHANGE, :REWRITE_URL_ROM, :REWRITE_URL_RU' +
        'S, :PGT_ID, :PGT_NAME, :FLG_PROMO, :FLG_NEW, :FLG_GROUP_IS_LINK,' +
        ' :URL_RO, :URL_RU, :FLG_POPULAR, :FLG_VIRTUAL_CATALOG)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TWEB_CATALOG'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_CATALOG'
      'SET'
      
        '  CATALOGID = :CATALOGID, PARENTID = :PARENTID, DT = :DT, TITLE ' +
        '= :TITLE, TITLE_RUS = :TITLE_RUS, ORDERNO = :ORDERNO, FLG_ENABLE' +
        'D = :FLG_ENABLED, FLG_4LEVEL = :FLG_4LEVEL, FLG_GOODS_GROUP = :F' +
        'LG_GOODS_GROUP, FLG_DELIMITER = :FLG_DELIMITER, FLG_CUSTOM_PRICE' +
        '_COLUMN = :FLG_CUSTOM_PRICE_COLUMN, FILTER_COUNT = :FILTER_COUNT' +
        ', GOODS_GROUP_NAME = :GOODS_GROUP_NAME, CUSTOM_PRICE_COLUMN = :C' +
        'USTOM_PRICE_COLUMN, CUSTOM_PRICE_COLUMN_DISPLAY = :CUSTOM_PRICE_' +
        'COLUMN_DISPLAY, FLG_VIEWMODE_VITRINA = :FLG_VIEWMODE_VITRINA, FL' +
        'G_DISABLE_VIEWMODE_CHANGE = :FLG_DISABLE_VIEWMODE_CHANGE, REWRIT' +
        'E_URL_ROM = :REWRITE_URL_ROM, REWRITE_URL_RUS = :REWRITE_URL_RUS' +
        ', PGT_ID = :PGT_ID, PGT_NAME = :PGT_NAME, FLG_PROMO = :FLG_PROMO' +
        ', FLG_NEW = :FLG_NEW, FLG_GROUP_IS_LINK = :FLG_GROUP_IS_LINK, UR' +
        'L_RO = :URL_RO, URL_RU = :URL_RU, FLG_POPULAR = :FLG_POPULAR, FL' +
        'G_VIRTUAL_CATALOG = :FLG_VIRTUAL_CATALOG'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLRefresh.Strings = (
      
        'SELECT CATALOGID, PARENTID, DT, TITLE, TITLE_RUS, ORDERNO, FLG_E' +
        'NABLED, FLG_4LEVEL, FLG_GOODS_GROUP, FLG_DELIMITER, FLG_CUSTOM_P' +
        'RICE_COLUMN, FILTER_COUNT, GOODS_GROUP_NAME, CUSTOM_PRICE_COLUMN' +
        ', CUSTOM_PRICE_COLUMN_DISPLAY, FLG_VIEWMODE_VITRINA, FLG_DISABLE' +
        '_VIEWMODE_CHANGE, REWRITE_URL_ROM, REWRITE_URL_RUS, PGT_ID, PGT_' +
        'NAME, FLG_PROMO, FLG_NEW, FLG_GROUP_IS_LINK, URL_RO, URL_RU, FLG' +
        '_POPULAR, FLG_VIRTUAL_CATALOG FROM VW_TWEB_CATALOG'
      'WHERE'
      '  CATALOGID = :CATALOGID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TWEB_CATALOG'
      'WHERE'
      'CATALOGID = :Old_CATALOGID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TWEB_CATALOG'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TWEB_CATALOG.*,'
      
        ' IIF(EXISTS(SELECT * FROM TWEB_CATALOG_ITEMS WHERE TWEB_CATALOG_' +
        'ITEMS.CATALOGID=VW_TWEB_CATALOG.CATALOGID),14,13) AS IMAGEINDEX,'
      ' iif(exists( SELECT * FROM TWEB_CATALOG_IMAGE I'
      
        '                where VW_TWEB_CATALOG.CATALOGID = i.catalogid an' +
        'd'
      
        '                octet_length(i.big_image)>0), 1, 0) HasCategoryI' +
        'mage'
      'FROM'
      ' VW_TWEB_CATALOG'
      'WHERE'
      ' DT=:DT'
      'ORDER BY'
      ' ORDERNO'
      '')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.StrictUpdate = False
    Left = 125
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceTree: TIBCDataSource
    DataSet = IBCQueryTree
    Left = 124
    Top = 280
  end
  object IBCQueryGoods: TIBCQuery
    KeyFields = 'CATALOGID;GOODSPARENTID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_CATALOG_ITEMS'
      '  (CATALOGID, GOODSPARENTID, FLG_MAIN_GROUP, FLG_SEE_ALSO)'
      'VALUES'
      '  (:CATALOGID, :GOODSPARENTID, :FLG_MAIN_GROUP, :FLG_SEE_ALSO)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TWEB_CATALOG_ITEMS'
      'WHERE'
      
        '  CATALOGID = :Old_CATALOGID AND GOODSPARENTID = :Old_GOODSPAREN' +
        'TID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_CATALOG_ITEMS'
      'SET'
      
        '  CATALOGID = :CATALOGID, GOODSPARENTID = :GOODSPARENTID, FLG_MA' +
        'IN_GROUP = :FLG_MAIN_GROUP, FLG_SEE_ALSO = :FLG_SEE_ALSO'
      'WHERE'
      
        '  CATALOGID = :Old_CATALOGID AND GOODSPARENTID = :Old_GOODSPAREN' +
        'TID')
    SQLRefresh.Strings = (
      'SELECT '
      ' CATALOGID,'
      ' GOODSPARENTID,'
      ' get_flg_value(flags, 0) FLG_MAIN_GROUP,'
      ' get_flg_value(flags, 1) flg_see_also,'
      ' (SELECT TITLE FROM TS_GOODS WHERE GOODSID=GOODSPARENTID) TITLE'
      
        '-- ,(SELECT COUNT(GOODSID) FROM TS_GOODS WHERE PARENTID=GOODSPAR' +
        'ENTID) GOODS_COUNT'
      'FROM'
      ' TWEB_CATALOG_ITEMS'
      
        'WHERE   CATALOGID = :CATALOGID AND GOODSPARENTID = :GOODSPARENTI' +
        'D'
      '')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_CATALOG_ITEMS'
      'WHERE'
      
        'CATALOGID = :Old_CATALOGID AND GOODSPARENTID = :Old_GOODSPARENTI' +
        'D'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TWEB_CATALOG_ITEMS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' CATALOGID,'
      ' GOODSPARENTID,'
      ' get_flg_value(flags, 0) FLG_MAIN_GROUP,'
      ' get_flg_value(flags, 1) flg_see_also,'
      ' (SELECT TITLE FROM TS_GOODS WHERE GOODSID=GOODSPARENTID) TITLE'
      
        '-- ,(SELECT COUNT(GOODSID) FROM TS_GOODS WHERE PARENTID=GOODSPAR' +
        'ENTID) GOODS_COUNT'
      'FROM'
      ' TWEB_CATALOG_ITEMS'
      'ORDER BY'
      ' ORDERNO'
      ''
      '/*SELECT '
      ' CATALOGID,'
      ' GOODSPARENTID,'
      ' FLG_MAIN_GROUP,'
      ' FLG_SEE_ALSO, '
      ' (SELECT TITLE FROM TS_GOODS WHERE GOODSID=GOODSPARENTID) TITLE,'
      
        ' (SELECT COUNT(GOODSID) FROM TS_GOODS WHERE PARENTID=GOODSPARENT' +
        'ID) GOODS_COUNT'
      'FROM'
      ' VW_TWEB_CATALOG_ITEMS'
      'ORDER BY'
      ' ORDERNO'
      '*/')
    MasterFields = 'CATALOGID'
    DetailFields = 'CATALOGID'
    MasterSource = IBCDataSourceTree
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 500
    Options.LocalMasterDetail = True
    AfterInsert = IBCQueryGoodsAfterInsert
    Left = 848
    Top = 248
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 848
    Top = 192
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 304
    Top = 236
  end
  object IBCDataSourceImage: TIBCDataSource
    DataSet = IBCQueryImage
    Left = 528
    Top = 442
  end
  object IBCQueryImage: TIBCQuery
    KeyFields = 'CATALOGID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_CATALOG_IMAGE'
      '  (CATALOGID, IMAGE, BIG_IMAGE)'
      'VALUES'
      '  (:CATALOGID, :IMAGE, :BIG_IMAGE)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_CATALOG_IMAGE'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_CATALOG_IMAGE'
      'SET'
      '  CATALOGID = :CATALOGID, IMAGE = :IMAGE, BIG_IMAGE = :BIG_IMAGE'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLRefresh.Strings = (
      'SELECT * FROM TWEB_CATALOG_IMAGE'
      'WHERE'
      '  CATALOGID = :CATALOGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_CATALOG_IMAGE'
      'WHERE'
      'CATALOGID = :Old_CATALOGID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_CATALOG_IMAGE'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      '      I.CATALOGID,'
      '      I.IMAGE,'
      '      C.TITLE,'
      '      C.TITLE_RUS,'
      '      I.BIG_IMAGE'
      'FROM TWEB_CATALOG_IMAGE I'
      'INNER JOIN TWEB_CATALOG C ON C.CATALOGID = I.CATALOGID')
    MasterFields = 'CATALOGID'
    DetailFields = 'I.CATALOGID'
    MasterSource = IBCDataSourceTree
    AutoCommit = False
    Options.DetailDelay = 500
    Left = 408
    Top = 442
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CATALOGID'
        Value = nil
      end>
  end
  object IBCQueryCatalogSeo: TIBCQuery
    KeyFields = 'CATALOGID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_CATALOG_SEO'
      
        '  (CATALOGID, META_TITLE_RO, META_TITLE_RU, META_DESCRIPTION_RO,' +
        ' META_DESCRIPTION_RU, META_KEYWORDS_RO, META_KEYWORDS_RU, SEO_AR' +
        'TICLE_RO, SEO_ARTICLE_RU)'
      'VALUES'
      
        '  (:CATALOGID, :META_TITLE_RO, :META_TITLE_RU, :META_DESCRIPTION' +
        '_RO, :META_DESCRIPTION_RU, :META_KEYWORDS_RO, :META_KEYWORDS_RU,' +
        ' :SEO_ARTICLE_RO, :SEO_ARTICLE_RU)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_CATALOG_SEO'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_CATALOG_SEO'
      'SET'
      
        '  CATALOGID = :CATALOGID, META_TITLE_RO = :META_TITLE_RO, META_T' +
        'ITLE_RU = :META_TITLE_RU, META_DESCRIPTION_RO = :META_DESCRIPTIO' +
        'N_RO, META_DESCRIPTION_RU = :META_DESCRIPTION_RU, META_KEYWORDS_' +
        'RO = :META_KEYWORDS_RO, META_KEYWORDS_RU = :META_KEYWORDS_RU, SE' +
        'O_ARTICLE_RO = :SEO_ARTICLE_RO, SEO_ARTICLE_RU = :SEO_ARTICLE_RU'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLRefresh.Strings = (
      
        'SELECT CATALOGID, META_TITLE_RO, META_TITLE_RU, META_DESCRIPTION' +
        '_RO, META_DESCRIPTION_RU, META_KEYWORDS_RO, META_KEYWORDS_RU, SE' +
        'O_ARTICLE_RO, SEO_ARTICLE_RU FROM TWEB_CATALOG_SEO'
      'WHERE'
      '  CATALOGID = :CATALOGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_CATALOG_SEO'
      'WHERE'
      'CATALOGID = :Old_CATALOGID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_CATALOG_SEO'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'select * from tweb_catalog_seo')
    MasterFields = 'CATALOGID'
    DetailFields = 'CATALOGID'
    MasterSource = IBCDataSourceTree
    Left = 496
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CATALOGID'
        Value = nil
      end>
  end
  object IBCDataSourceCatalogSeo: TIBCDataSource
    DataSet = IBCQueryCatalogSeo
    Left = 496
    Top = 240
  end
  object IBCQuerySeeAlso: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_CATALOG_SEE_ALSO'
      '  (CATALOGID, GOODSFOLDERID, GOODSFOLDER_NAME)'
      'VALUES'
      '  (:CATALOGID, :GOODSFOLDERID, :GOODSFOLDER_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TWEB_CATALOG_SEE_ALSO'
      'WHERE'
      
        '  CATALOGID = :Old_CATALOGID AND GOODSFOLDERID = :Old_GOODSFOLDE' +
        'RID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_CATALOG_SEE_ALSO'
      'SET'
      
        '  CATALOGID = :CATALOGID, GOODSFOLDERID = :GOODSFOLDERID, GOODSF' +
        'OLDER_NAME = :GOODSFOLDER_NAME'
      'WHERE'
      
        '  CATALOGID = :Old_CATALOGID AND GOODSFOLDERID = :Old_GOODSFOLDE' +
        'RID')
    SQLRefresh.Strings = (
      
        'SELECT CATALOGID, GOODSFOLDERID, GOODSFOLDER_NAME FROM VW_TWEB_C' +
        'ATALOG_SEE_ALSO'
      'WHERE'
      '  CATALOGID = :CATALOGID AND GOODSFOLDERID = :GOODSFOLDERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_CATALOG_SEE_ALSO'
      'WHERE'
      
        'CATALOGID = :Old_CATALOGID AND GOODSFOLDERID = :Old_GOODSFOLDERI' +
        'D'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TWEB_CATALOG_SEE_ALSO'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'select * from VW_TWEB_CATALOG_SEE_ALSO')
    MasterFields = 'CATALOGID'
    DetailFields = 'CATALOGID'
    MasterSource = IBCDataSourceTree
    RefreshOptions = [roAfterInsert]
    Left = 854
    Top = 442
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CATALOGID'
        Value = nil
      end>
  end
  object IBCDataSourceSeeAlso: TIBCDataSource
    DataSet = IBCQuerySeeAlso
    Left = 850
    Top = 404
  end
  object dxComponentPrinter1: TdxComponentPrinter
    Version = 0
    Left = 144
    Top = 160
    PixelsPerInch = 96
  end
  object IBCQueryGoodsList: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select goodsid, title,  GET_FLG_IN_PRICE(goodsid) FLG_IN_PRICE f' +
        'rom ts_goods'
      'order by 3 desc, title')
    MasterFields = 'GOODSPARENTID'
    DetailFields = 'PARENTID'
    MasterSource = IBCDataSourceGoods
    Left = 1117
    Top = 648
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSPARENTID'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsList: TIBCDataSource
    DataSet = IBCQueryGoodsList
    Left = 1005
    Top = 648
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbNewFolderCurrentLevel'
      end
      item
        Visible = True
        ItemName = 'dxBarButton3'
      end>
    UseOwnFont = False
    Left = 304
    Top = 160
    PixelsPerInch = 96
  end
  object IBCQueryArticles: TIBCQuery
    KeyFields = 'articleid'
    KeyGenerator = 'gen_tweb_articles_id'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_ARTICLES'
      
        '  (ARTICLEID, CREATED_DATE, TITLE_RO, TITLE_RU, ARTICLE_BODY_RO,' +
        ' ARTICLE_BODY_RU, CATALOGID, PROMOTIONID, CREATED_BY)'
      'VALUES'
      
        '  (:ARTICLEID, :CREATED_DATE, :TITLE_RO, :TITLE_RU, :ARTICLE_BOD' +
        'Y_RO, :ARTICLE_BODY_RU, :CATALOGID, :PROMOTIONID, :CREATED_BY)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_ARTICLES'
      'WHERE'
      '  ARTICLEID = :Old_ARTICLEID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_ARTICLES'
      'SET'
      
        '  ARTICLEID = :ARTICLEID, CREATED_DATE = :CREATED_DATE, TITLE_RO' +
        ' = :TITLE_RO, TITLE_RU = :TITLE_RU, ARTICLE_BODY_RO = :ARTICLE_B' +
        'ODY_RO, ARTICLE_BODY_RU = :ARTICLE_BODY_RU, CATALOGID = :CATALOG' +
        'ID, PROMOTIONID = :PROMOTIONID, CREATED_BY = :CREATED_BY'
      'WHERE'
      '  ARTICLEID = :Old_ARTICLEID')
    SQLRefresh.Strings = (
      
        'SELECT ARTICLEID, CREATED_DATE, TITLE_RO, TITLE_RU, ARTICLE_BODY' +
        '_RO, ARTICLE_BODY_RU, CATALOGID, PROMOTIONID, CREATED_BY FROM TW' +
        'EB_ARTICLES'
      'WHERE'
      '  ARTICLEID = :ARTICLEID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_ARTICLES'
      'WHERE'
      'ARTICLEID = :Old_ARTICLEID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_ARTICLES'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'select * from tweb_articles'
      'order by CREATED_DATE desc')
    MasterFields = 'CATALOGID'
    DetailFields = 'CATALOGID'
    MasterSource = IBCDataSourceTree
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DefaultValues = True
    LocalConstraints = False
    Left = 208
    Top = 688
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CATALOGID'
        Value = nil
      end>
  end
  object IBCDataSourceArticles: TIBCDataSource
    DataSet = IBCQueryArticles
    Left = 208
    Top = 632
  end
  object SaveFileDialog1: TdxSaveFileDialog
    Left = 720
    Top = 408
  end
end
