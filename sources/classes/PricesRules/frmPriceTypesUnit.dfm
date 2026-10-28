object frmPriceTypesDlg: TfrmPriceTypesDlg
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight]
  BorderStyle = bsDialog
  Caption = 'Politica de preturi'
  ClientHeight = 638
  ClientWidth = 1393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnShow = FormShow
  DesignSize = (
    1393
    638)
  TextHeight = 13
  object cxButton1: TcxButton
    Left = 647
    Top = 601
    Width = 90
    Height = 29
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 1
    TabOrder = 5
  end
  object Panel1: TPanel
    Left = 631
    Top = 70
    Width = 790
    Height = 201
    Anchors = [akLeft, akTop, akRight]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    ExplicitWidth = 782
    object cxGrid2: TcxGrid
      Left = 0
      Top = 28
      Width = 786
      Height = 169
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      ExplicitWidth = 770
      object cxGridDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourcePriceRules
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Appending = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridDBColumn1: TcxGridDBColumn
          Caption = 'GP'
          DataBinding.FieldName = 'PRICECOLUMN'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridDBColumn2: TcxGridDBColumn
          Caption = 'Min $'
          DataBinding.FieldName = 'MIN_VALUE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGrid1DBTableView1Column3: TcxGridDBColumn
          Caption = 'Max $'
          DataBinding.FieldName = 'MAX_VALUE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGrid1DBTableView1Column4: TcxGridDBColumn
          Caption = 'Formula'
          DataBinding.FieldName = 'FORMULA'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Styles.Content = dmAdditions.cxStyle2
          Width = 207
        end
        object cxGridDBTableView1_ADJUST: TcxGridDBColumn
          Caption = 'Ajustare'
          DataBinding.FieldName = 'ADJUST'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridDBTableView1_MIN_MARGIN: TcxGridDBColumn
          Caption = 'Adaos'
          DataBinding.FieldName = 'MIN_MARGIN'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridDBTableView1_MIN_MARGIN_PERCENT: TcxGridDBColumn
          Caption = '% adaos'
          DataBinding.FieldName = 'MIN_MARGIN_PERCENT'
          DataBinding.IsNullValueType = True
          MinWidth = 52
          Options.HorzSizing = False
          Width = 52
        end
        object cxGridDBTableView1_ROUND_UP: TcxGridDBColumn
          Caption = 'Round'
          DataBinding.FieldName = 'ROUND_UP'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 786
      Height = 28
      Align = dalTop
      BarManager = dxBarManager1
      ExplicitWidth = 778
    end
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1393
    Height = 64
    Title = 'Gestiunea politicii de preturi'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -26
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -21
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 7
  end
  object Panel3: TPanel
    Left = 379
    Top = 277
    Width = 1006
    Height = 307
    Anchors = [akLeft, akTop, akRight]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 3
    object cxGrid3: TcxGrid
      Left = 0
      Top = 0
      Width = 1002
      Height = 303
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      object cxGrid3DBTableView1: TcxGridDBTableView
        OnKeyDown = cxGrid3DBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        FindPanel.DisplayMode = fpdmAlways
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.GridModeBufferCount = 50
        DataController.DataSource = IBCDataSourceGoodsInPrice
        DataController.KeyFieldNames = 'GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGrid3DBTableView1_GOODSID
          end>
        DataController.Summary.SummaryGroups = <>
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
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGrid3DB_VENDORNAME: TcxGridDBColumn
          Caption = 'Producator'
          DataBinding.FieldName = 'VENDOR_NAME'
          DataBinding.IsNullValueType = True
          Width = 147
        end
        object cxGrid3DBTableView1_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 67
        end
        object cxGrid3DBTableView1_GOODSNAME: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 419
        end
        object cxGrid3DBTableView1Column1: TcxGridDBColumn
          Caption = 'p4'
          DataBinding.FieldName = 'PRICE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          Width = 70
        end
        object cxGrid3DBTableView1_PRICE5_MDL: TcxGridDBColumn
          Caption = 'P5'
          DataBinding.FieldName = 'PRICE5_MDL'
          DataBinding.IsNullValueType = True
          Width = 52
        end
        object cxGrid3DBTableView1_CURRENCY5ID: TcxGridDBColumn
          Caption = 'Val 5'
          DataBinding.FieldName = 'CURRENCY5ID'
          DataBinding.IsNullValueType = True
        end
        object cxGrid3DBTableView1_PRICE6_MDL: TcxGridDBColumn
          Caption = 'P6'
          DataBinding.FieldName = 'PRICE6_MDL'
          DataBinding.IsNullValueType = True
          Width = 53
        end
        object cxGrid3DBTableView1_CURRENCY6ID: TcxGridDBColumn
          Caption = 'Val 6'
          DataBinding.FieldName = 'CURRENCY6ID'
          DataBinding.IsNullValueType = True
        end
        object cxGrid3DBTableView1_COST_MDL: TcxGridDBColumn
          Caption = 'Cost'
          DataBinding.FieldName = 'COST_MDL'
          DataBinding.IsNullValueType = True
          HeaderHint = 'Costul (PRICE0, altfel PRICE7) - baza politicii de preturi'
          Width = 53
        end
        object cxGrid3DBTableView1_PRICE7_MDL: TcxGridDBColumn
          Caption = 'P7'
          DataBinding.FieldName = 'PRICE7_MDL'
          DataBinding.IsNullValueType = True
          Width = 53
        end
        object cxGrid3DBTableView1_CURRENCY7ID: TcxGridDBColumn
          Caption = 'Val 7'
          DataBinding.FieldName = 'CURRENCY7ID'
          DataBinding.IsNullValueType = True
          Width = 53
        end
        object cxGrid3DBTableView1Column2: TcxGridDBColumn
          Caption = 'p.ind ($)'
          DataBinding.FieldName = 'PRICE7'
          DataBinding.IsNullValueType = True
          Width = 69
        end
        object cxGrid3DBTableView1Column3: TcxGridDBColumn
          Caption = 'AC'
          DataBinding.Expression = #1'ABS(1-([p4]/[Cost]))'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid3DBTableView1_FLG_IN_PRICE: TcxGridDBColumn
          Caption = 'F'
          DataBinding.FieldName = 'FLG_IN_PRICE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
      end
      object cxGrid3Level1: TcxGridLevel
        GridView = cxGrid3DBTableView1
      end
    end
  end
  object Panel4: TPanel
    Left = 383
    Top = 70
    Width = 242
    Height = 203
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object dxBarDockControl3: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 242
      Height = 28
      Align = dalTop
      BarManager = dxBarManager1
    end
    object cxGridSupplier: TcxGrid
      Left = 0
      Top = 28
      Width = 242
      Height = 175
      Align = alClient
      TabOrder = 1
      object cxGridSupplierDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceSuppliers
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.HideFocusRectOnExit = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridSupplierDBTableView1SUPPLIER_NAME: TcxGridDBColumn
          Caption = 'Furnizor'
          DataBinding.FieldName = 'SUPPLIER_NAME'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 250
        end
      end
      object cxGridSupplierLevel1: TcxGridLevel
        GridView = cxGridSupplierDBTableView1
      end
    end
  end
  object cxPageControl1: TcxPageControl
    Left = 8
    Top = 70
    Width = 369
    Height = 514
    TabOrder = 0
    Properties.ActivePage = tbsOld
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 510
    ClientRectLeft = 4
    ClientRectRight = 365
    ClientRectTop = 24
    object tbsOld: TcxTabSheet
      Caption = 'General'
      ImageIndex = 0
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 355
        Height = 480
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 351
          Height = 28
          Align = dalTop
          BarManager = dxBarManager1
        end
        object cxGrid1: TcxGrid
          Left = 0
          Top = 28
          Width = 351
          Height = 448
          Align = alClient
          BevelInner = bvNone
          BorderStyle = cxcbsNone
          TabOrder = 1
          object cxGrid1DBTableView1: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            FindPanel.DisplayMode = fpdmAlways
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = IBCDataSourcePriceTypes
            DataController.KeyFieldNames = 'PGT_ID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsSelection.HideFocusRectOnExit = False
            OptionsSelection.InvertSelect = False
            OptionsSelection.UnselectFocusedRecordOnExit = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            Styles.OnGetContentStyle = cxGrid1DBTableView1StylesGetContentStyle
            object cxGrid1DBTableView1Column1: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'PGT_ID'
              DataBinding.IsNullValueType = True
              HeaderAlignmentHorz = taCenter
              Width = 48
            end
            object cxGrid1DBTableView1Column2: TcxGridDBColumn
              Caption = 'Denumire'
              DataBinding.FieldName = 'TITLE'
              DataBinding.IsNullValueType = True
              HeaderAlignmentHorz = taCenter
              Width = 286
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
    end
    object tbsTree: TcxTabSheet
      Caption = 'Tree'
      ImageIndex = 1
      object cxDBTreeList1: TcxDBTreeList
        Left = 0
        Top = 28
        Width = 361
        Height = 458
        Align = alClient
        Bands = <
          item
          end>
        DataController.DataSource = IBCDataSourcePoliciesTree
        DataController.ImageIndexField = 'FLG_FOLDER'
        DataController.ParentField = 'PARENTID'
        DataController.KeyField = 'PGT_ID'
        Images = cxImageList1
        Navigator.Buttons.CustomButtons = <>
        OptionsBehavior.ImmediateEditor = False
        OptionsBehavior.HotTrack = True
        OptionsBehavior.IncSearch = True
        RootValue = -1
        ScrollbarAnnotations.CustomAnnotations = <>
        TabOrder = 1
        object cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn
          PropertiesClassName = 'TcxTextEditProperties'
          Caption.Text = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          Options.Footer = False
          Options.GroupFooter = False
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringWithFindPanel = False
          Options.IgnoreTimeForFiltering = False
          Options.Moving = False
          Options.Sorting = False
          Options.TabStop = False
          Width = 202
          Position.ColIndex = 1
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn
          DataBinding.FieldName = 'PGT_ID'
          Width = 95
          Position.ColIndex = 0
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList1cxDBTreeListColumn3: TcxDBTreeListColumn
          DataBinding.FieldName = 'PARENTID'
          Width = 37
          Position.ColIndex = 2
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
      end
      object dxBarDockControl4: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 361
        Height = 28
        Align = dalTop
        BarManager = dxBarManager1
      end
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Price rules'
      'Furnizori'
      'Tree')
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 320
    Top = 144
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 416
      FloatTop = 537
      FloatClientWidth = 86
      FloatClientHeight = 103
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton5'
        end>
      OneOnRow = True
      Row = 0
      ShowMark = False
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Price Rules'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 683
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbprNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbprEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbprDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem2'
        end>
      OneOnRow = True
      Row = 0
      ShowMark = False
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Furnizor'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1176
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSupplierNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbSupplierDelete'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton7'
        end>
      OneOnRow = True
      Row = 0
      ShowMark = False
      UseOwnFont = False
      UseRecentItems = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'tree toolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl4
      DockedDockControl = dxBarDockControl4
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1394
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewFolder'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbNewItem'
        end
        item
          Visible = True
          ItemName = 'bbModify'
        end
        item
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbChangeParent'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 90
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Modificare'
      Category = 0
      Hint = 'Modificare'
      Visible = ivAlways
      ImageIndex = 91
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      OnClick = dxBarButton3Click
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ImageIndex = 58
      ItemLinks = <>
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Recalcula preturile'
      Category = 0
      Hint = 'Recalcula preturile'
      Visible = ivAlways
      ImageIndex = 71
      ShortCut = 117
      OnClick = dxBarButton5Click
    end
    object bbImport: TdxBarButton
      Caption = 'Import'
      Category = 0
      Hint = 'Import'
      Visible = ivAlways
      ImageIndex = 34
      ShortCut = 49225
      OnClick = bbImportClick
    end
    object dxBarButton6: TdxBarButton
      Caption = 'Istoric'
      Category = 0
      Hint = 'Istoric'
      Visible = ivAlways
      ShortCut = 16456
      OnClick = dxBarButton6Click
    end
    object dxBarButton7: TdxBarButton
      Caption = 'Nou implicit..'
      Category = 0
      Hint = 'Nou implicit..'
      Visible = ivAlways
      ImageIndex = 90
      OnClick = dxBarButton7Click
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ImageIndex = 52
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbImport'
        end
        item
          Visible = True
          ItemName = 'bbImportFromDefaultSupplier'
        end
        item
          Visible = True
          ItemName = 'dxBarButton6'
        end
        item
          Visible = True
          ItemName = 'bbDuplicateRules'
        end
        item
          Visible = True
          ItemName = 'btnFilterGoods'
        end>
    end
    object bbDuplicateRules: TdxBarButton
      Caption = 'Dubleaza inregistrarea'
      Category = 0
      Hint = 'Dubleaza inregistrarea'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbDuplicateRulesClick
    end
    object bbImportFromDefaultSupplier: TdxBarButton
      Caption = 'Importa din furnizorul implicit'
      Category = 0
      Hint = 'Importa din furnizorul implicit'
      Visible = ivAlways
      OnClick = bbImportFromDefaultSupplierClick
    end
    object btnFilterGoods: TdxBarButton
      Caption = 'Arata produsele'
      Category = 0
      Hint = 'Arata produsele'
      Visible = ivAlways
      ShortCut = 116
      OnClick = btnFilterGoodsClick
    end
    object bbprNew: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 90
      ShortCut = 45
      OnClick = bbprNewClick
    end
    object bbprEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 91
      ShortCut = 115
      OnClick = bbprEditClick
    end
    object bbprDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      OnClick = bbprDeleteClick
    end
    object bbSupplierNew: TdxBarButton
      Caption = 'Furnizor nou'
      Category = 2
      Hint = 'Furnizor nou'
      Visible = ivAlways
      ImageIndex = 90
      OnClick = bbSupplierNewClick
    end
    object bbSupplierDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      OnClick = bbSupplierDeleteClick
    end
    object bbNewFolder: TdxBarButton
      Caption = 'Mapa noua'
      Category = 3
      Hint = 'Mapa noua'
      Visible = ivAlways
      ImageIndex = 80
      OnClick = bbNewFolderClick
    end
    object bbNewItem: TdxBarButton
      Caption = 'Nou'
      Category = 3
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 3
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 3
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
    end
    object bbChangeParent: TdxBarButton
      Caption = 'Schimba parintele'
      Category = 3
      Hint = 'Schimba parintele'
      Visible = ivAlways
      ImageIndex = 84
    end
  end
  object IBCQueryPriceTypes: TIBCQuery
    KeyFields = 'PGT_ID'
    KeyGenerator = 'gen_tprice_id'
    SQLInsert.Strings = (
      'INSERT INTO TPRICE'
      '  (PGT_ID, TITLE)'
      'VALUES'
      '  (:PGT_ID, :TITLE)')
    SQLDelete.Strings = (
      'DELETE FROM TPRICE'
      'WHERE'
      '  PGT_ID = :Old_PGT_ID')
    SQLUpdate.Strings = (
      'UPDATE TPRICE'
      'SET'
      '  PGT_ID = :PGT_ID, TITLE = :TITLE'
      'WHERE'
      '  PGT_ID = :Old_PGT_ID')
    SQLRefresh.Strings = (
      'SELECT PGT_ID, TITLE FROM TPRICE'
      'WHERE'
      '  PGT_ID = :PGT_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TPRICE'
      'WHERE'
      'PGT_ID = :Old_PGT_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TPRICE'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * from TPRICE'
      'where pgt_id <>0 and flg_folder = 0'
      'order by pgt_id'
      '')
    Options.DetailDelay = 100
    AfterInsert = IBCQueryPriceTypesAfterInsert
    Left = 160
    Top = 120
  end
  object IBCDataSourcePriceTypes: TIBCDataSource
    DataSet = IBCQueryPriceTypes
    Left = 160
    Top = 184
  end
  object IBCTrLocalUpdate: TIBCTransaction
    Left = 392
    Top = 88
  end
  object IBCQueryPriceRules: TIBCQuery
    KeyFields = 'PGT_ID;PRICECOLUMN;MIN_VALUE;SUPPLIERID'
    SQLInsert.Strings = (
      'INSERT INTO TPRICE_GOODSTYPE'
      
        '  (PGT_ID, PRICECOLUMN, MIN_VALUE, MAX_VALUE, FORMULA, SUPPLIERI' +
        'D, MIN_MARGIN, ROUND_UP, ADJUST, MIN_MARGIN_PERCENT)'
      'VALUES'
      
        '  (:PGT_ID, :PRICECOLUMN, :MIN_VALUE, :MAX_VALUE, :FORMULA, :SUP' +
        'PLIERID, :MIN_MARGIN, :ROUND_UP, :ADJUST, :MIN_MARGIN_PERCENT)')
    SQLDelete.Strings = (
      'DELETE FROM TPRICE_GOODSTYPE'
      'WHERE'
      
        '  PGT_ID = :Old_PGT_ID AND PRICECOLUMN = :Old_PRICECOLUMN AND MI' +
        'N_VALUE = :Old_MIN_VALUE AND SUPPLIERID = :Old_SUPPLIERID')
    SQLUpdate.Strings = (
      'UPDATE TPRICE_GOODSTYPE'
      'SET'
      
        '  PGT_ID = :PGT_ID, PRICECOLUMN = :PRICECOLUMN, MIN_VALUE = :MIN' +
        '_VALUE, MAX_VALUE = :MAX_VALUE, FORMULA = :FORMULA, SUPPLIERID =' +
        ' :SUPPLIERID, MIN_MARGIN = :MIN_MARGIN, ROUND_UP = :ROUND_UP, AD' +
        'JUST = :ADJUST, MIN_MARGIN_PERCENT = :MIN_MARGIN_PERCENT'
      'WHERE'
      
        '  PGT_ID = :Old_PGT_ID AND PRICECOLUMN = :Old_PRICECOLUMN AND MI' +
        'N_VALUE = :Old_MIN_VALUE AND SUPPLIERID = :Old_SUPPLIERID')
    SQLRefresh.Strings = (
      
        'SELECT PGT_ID, PRICECOLUMN, MIN_VALUE, MAX_VALUE, FORMULA, SUPPL' +
        'IERID, MIN_MARGIN, ROUND_UP, ADJUST, MIN_MARGIN_PERCENT FROM TPR' +
        'ICE_GOODSTYPE'
      'WHERE'
      
        '  PGT_ID = :P_1_PGT_ID AND PRICECOLUMN = :PRICECOLUMN AND MIN_VA' +
        'LUE = :MIN_VALUE AND SUPPLIERID = :P_1_SUPPLIERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TPRICE_GOODSTYPE'
      'WHERE'
      
        'PGT_ID = :Old_PGT_ID AND PRICECOLUMN = :Old_PRICECOLUMN AND MIN_' +
        'VALUE = :Old_MIN_VALUE AND SUPPLIERID = :Old_SUPPLIERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TPRICE_GOODSTYPE'
      ''
      ') q')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * from tprice_GOODSTYPE'
      'where pgt_id = :pgt_id and supplierid = :supplierid'
      'order by pricecolumn, min_value')
    MasterFields = 'PGT_ID;SUPPLIERID'
    DetailFields = 'PGT_ID;SUPPLIERID;PRICECOLUMN;MIN_VALUE'
    MasterSource = IBCDataSourceSuppliers
    Options.DefaultValues = True
    Left = 808
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pgt_id'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SUPPLIERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'PGT_ID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SUPPLIERID'
        Value = nil
      end>
  end
  object IBCDataSourcePriceRules: TIBCDataSource
    DataSet = IBCQueryPriceRules
    Left = 808
    Top = 200
  end
  object IBCQueryGoodsInPrice: TIBCQuery
    KeyFields = 'GOODSID'
    SQL.Strings = (
      'select distinct'
      '        c.pgt_id,  g.goodsid, g.title, '
      
        '        (select title from ts_syss where syssid = g.vendor_id) v' +
        'endor_name,'
      
        '        (select price_mdl from get_goods_price(g.goodsid, 1, 498' +
        ')) price,'
      
        '        (select price_mdl from get_goods_price(g.goodsid, 5, 498' +
        ')) price5_mdl,'
      
        '        (select price_mdl from get_goods_price(g.goodsid, 6, 498' +
        ')) price6_mdl,'
      
        '        (select price from get_goods_price7(g.goodsid, 498)) pri' +
        'ce7_mdl,'
      
        '        (select price from get_goods_price7(g.goodsid, 840)) pri' +
        'ce7, '

        '        (select price from get_goods_cost(g.goodsid, 498, 0)) co' +
        'st_mdl, '
      '        gp.currency5id,'
      '        gp.currency6id,'
      '        gp.currency7id,'
      'get_flg_in_price(gf.goodsid) flg_in_price'
      '    from tweb_catalog c'
      
        '        join tweb_catalog_items i on i.catalogid = c.catalogid a' +
        'nd c.pgt_id=:pgt_id'
      '        join ts_goods g on g.parentid = i.goodsparentid'
      '        join ts_goods_price gp on gp.goodsid = g.goodsid'
      
        '        join tdb_goods_flags gf on gf.goodsid=g.goodsid and gf.f' +
        'lagtypeid in (3,5)'
      
        '        join get_goods_cost(g.goodsid, 840, 0) z on z.price betw' +
        'een :MIN_VALUE and :MAX_VALUE'
      '')
    DetailFields = 'PGT_ID'
    Left = 160
    Top = 368
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pgt_id'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'MIN_VALUE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'MAX_VALUE'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsInPrice: TIBCDataSource
    DataSet = IBCQueryGoodsInPrice
    Left = 160
    Top = 312
  end
  object IBCQuerySuppliers: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TPRICE_SUPPLIERS'
      '  (PGT_ID, SUPPLIERID, SUPPLIER_NAME)'
      'VALUES'
      '  (:PGT_ID, :SUPPLIERID, :SUPPLIER_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TPRICE_SUPPLIERS'
      'WHERE'
      '  PGT_ID = :Old_PGT_ID AND SUPPLIERID = :Old_SUPPLIERID')
    SQLUpdate.Strings = (
      'UPDATE VW_TPRICE_SUPPLIERS'
      'SET'
      
        '  PGT_ID = :PGT_ID, SUPPLIERID = :SUPPLIERID, SUPPLIER_NAME = :S' +
        'UPPLIER_NAME'
      'WHERE'
      '  PGT_ID = :Old_PGT_ID AND SUPPLIERID = :Old_SUPPLIERID')
    SQLRefresh.Strings = (
      
        'SELECT PGT_ID, SUPPLIERID, SUPPLIER_NAME FROM VW_TPRICE_SUPPLIER' +
        'S'
      'WHERE'
      '  PGT_ID = :PGT_ID AND SUPPLIERID = :SUPPLIERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TPRICE_SUPPLIERS'
      'WHERE'
      'PGT_ID = :Old_PGT_ID AND SUPPLIERID = :Old_SUPPLIERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TPRICE_SUPPLIERS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * from vw_tprice_suppliers')
    MasterFields = 'PGT_ID'
    DetailFields = 'PGT_ID'
    MasterSource = IBCDataSourcePriceTypes
    Left = 544
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PGT_ID'
        Value = nil
      end>
  end
  object IBCDataSourceSuppliers: TIBCDataSource
    DataSet = IBCQuerySuppliers
    Left = 544
    Top = 184
  end
  object IBCQuerySupplierGroups: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from tprice_supplier_groups sg'
      'join tprice_supplier_group_items sgi on sg.sgid=sgi.sgid'
      'join tprice_goodstype gt on 1=2'
      '--join tprice_goodstype gt on gt.groupsupplierid=sg.sgid')
    MasterFields = 'PGT_ID'
    DetailFields = 'PGT_ID'
    MasterSource = IBCDataSourcePriceTypes
    Options.DetailDelay = 1000
    Left = 632
    Top = 376
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PGT_ID'
        Value = nil
      end>
  end
  object IBCDataSourceSupplierGroups: TIBCDataSource
    DataSet = IBCQuerySupplierGroups
    Left = 632
    Top = 320
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 21496488
    ImageInfo = <
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000026744558745469746C6500446F4E6F745265706561744974656D4C61
          62656C735069766F745461626C653B43D5B0DF0000014449444154785E8593CD
          4AC3501085DBD274E3A2F82CBE9408A2882045AA14114514940A826EBA10152A
          8AA888E0C68DE0CF8B88A2D536CD7F8E33436653E7D2C00703E7CB6192DC9400
          94E82AB74F5F0EF6CFDE300EF6D8E7FB182DA8EC1D3F23CF8134CB5D48CE1EFB
          A305D5EDCE139234C7D4F48D10C6193ADD574667C9D9637FB4C0DB387C242143
          10A52E24678FFDD1825AABFD8038C9E087A9A21BE82C397BECFF2B58D9BD4744
          C220485C484E9E5DB0BC7387304EF1EBC78A6EA0B3E4E4D9058DAD5B79CEDE20
          7221397976C1D2E6358624E857F8EA47BA81CE929367172CAE5FC10F137CFE84
          2E2427CF2E5858BB841F24F8E8058A6EA0B3E4E4D905F3AD0B79D3EFDF810BC9
          C9330BBCB9D57339AEFD61EC4272F2CC83549D699C1CCD36BB18077BD651AE10
          356282A8139306F522AF593F53B928A9121E4B061EE78557D6823F0CD5A0BA93
          E74EC50000000049454E44AE426082}
        FileName = 'Images\Spreadsheet\DoNotRepeatItemLabelsPivotTable_16x16.png'
        Keywords = 'Spreadsheet;DoNotRepeatItemLabelsPivotTable'
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222076696577426F783D2230203020333220333222207374796C653D
          22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
          3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
          303B3C7374796C6520747970653D22746578742F6373732220786D6C3A737061
          63653D227072657365727665223E2E426C75657B66696C6C3A23313137374437
          3B7D262331333B262331303B2623393B2E59656C6C6F777B66696C6C3A234646
          423131353B7D262331333B262331303B2623393B2E426C61636B7B66696C6C3A
          233732373237323B7D262331333B262331303B2623393B2E477265656E7B6669
          6C6C3A233033394332333B7D262331333B262331303B2623393B2E5265647B66
          696C6C3A234431314331433B7D262331333B262331303B2623393B2E7374307B
          6F7061636974793A302E37353B7D262331333B262331303B2623393B2E737431
          7B6F7061636974793A302E353B7D3C2F7374796C653E0D0A3C672069643D2246
          6F6C6465724F70656E223E0D0A09093C6720636C6173733D22737430223E0D0A
          0909093C7061746820636C6173733D2259656C6C6F772220643D224D322E322C
          32352E326C352E352D313063302E332D302E372C312D312E322C312E382D312E
          32483234762D3363302D302E362D302E342D312D312D31483132563763302D30
          2E362D302E342D312D312D31483343322E342C362C322C362E352C322C377631
          3820202623393B2623393B2623393B63302C302E322C302C302E332C302E312C
          302E3443322E312C32352E342C322E322C32352E332C322E322C32352E327A22
          2F3E0D0A09093C2F673E0D0A09093C7061746820636C6173733D2259656C6C6F
          772220643D224D32392E332C313648392E364C342C32366831392E3863302E35
          2C302C312E312D302E322C312E332D302E366C342E392D382E394333302E312C
          31362E322C32392E382C31362C32392E332C31367A222F3E0D0A093C2F673E0D
          0A3C2F7376673E0D0A}
        FileName = 'SVG Images\Icon Builder\Actions_FolderOpen.svg'
        Keywords = 'Icon Builder;Actions;FolderOpen'
      end>
  end
  object IBCQueryPoliciesTree: TIBCQuery
    KeyFields = 'PGT_ID'
    KeyGenerator = 'gen_tprice_id'
    SQLInsert.Strings = (
      'INSERT INTO TPRICE'
      '  (PGT_ID, TITLE)'
      'VALUES'
      '  (:PGT_ID, :TITLE)')
    SQLDelete.Strings = (
      'DELETE FROM TPRICE'
      'WHERE'
      '  PGT_ID = :Old_PGT_ID')
    SQLUpdate.Strings = (
      'UPDATE TPRICE'
      'SET'
      '  PGT_ID = :PGT_ID, TITLE = :TITLE'
      'WHERE'
      '  PGT_ID = :Old_PGT_ID')
    SQLRefresh.Strings = (
      'SELECT PGT_ID, TITLE FROM TPRICE'
      'WHERE'
      '  PGT_ID = :PGT_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TPRICE'
      'WHERE'
      'PGT_ID = :Old_PGT_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TPRICE'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * from TPRICE'
      'where (pgt_id > 0)'
      'order by title'
      '')
    Options.DetailDelay = 100
    Left = 264
    Top = 120
  end
  object IBCDataSourcePoliciesTree: TIBCDataSource
    DataSet = IBCQueryPoliciesTree
    Left = 264
    Top = 184
  end
end
