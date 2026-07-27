object frmGoodsGroupsEditorDlg: TfrmGoodsGroupsEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Grupa de produse'
  ClientHeight = 454
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 550
    Height = 64
    Title = 'Grupa de produse'
    Text = ''
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
    ImageIndex = 22
  end
  object pcPageControl: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 534
    Height = 329
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    Properties.ActivePage = tbsGeneral
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 325
    ClientRectLeft = 4
    ClientRectRight = 530
    ClientRectTop = 26
    object tbsGeneral: TcxTabSheet
      Caption = 'Generale'
      ImageIndex = 0
      object Label1: TLabel
        Left = 16
        Top = 20
        Width = 52
        Height = 15
        Caption = 'Denumire'
      end
      object Label2: TLabel
        Left = 16
        Top = 72
        Width = 48
        Height = 15
        Caption = 'Descriere'
      end
      object edTITLE: TcxDBTextEdit
        Left = 16
        Top = 37
        DataBinding.DataField = 'TITLE'
        TabOrder = 0
        Width = 489
      end
      object mmDESCRIPTION: TcxDBMemo
        Left = 16
        Top = 93
        DataBinding.DataField = 'DESCRIPTION'
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 3
        TabOrder = 1
        Width = 489
      end
    end
    object tbsGoodsTypes: TcxTabSheet
      Caption = 'Tip produse'
      ImageIndex = 1
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 526
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridTypes: TcxGrid
        Left = 0
        Top = 30
        Width = 526
        Height = 269
        Align = alClient
        TabOrder = 1
        object cxGridTypesTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCustomDrawCell = cxGridTypesTableCustomDrawCell
          OnFocusedRecordChanged = cxGridTypesTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceGT
          DataController.KeyFieldNames = 'GG_ID;GOODSTYPEID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
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
          Styles.Footer = dmAdditions.cxStyle_GridHeader
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridTypesTable_GOODSTYPEID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GOODSTYPEID'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridTypesTable_IMG: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_EXCLUDE'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 50
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 43
                Value = 0
              end
              item
                ImageIndex = 42
                Value = 1
              end>
            MinWidth = 24
            Options.Focusing = False
            Options.HorzSizing = False
            Width = 24
            IsCaptionAssigned = True
          end
          object cxGridTypesTable_GOODSTYPE_TITLE: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'GOODSTYPE_TITLE'
            DataBinding.IsNullValueType = True
            SortIndex = 0
            SortOrder = soAscending
            Width = 200
          end
          object cxGridTypesTable_CREATED_BY_NAME: TcxGridDBColumn
            Caption = 'Utilizator'
            DataBinding.FieldName = 'CREATED_BY_NAME'
            DataBinding.IsNullValueType = True
            Width = 100
          end
        end
        object cxGridTypesLevel: TcxGridLevel
          GridView = cxGridTypesTable
        end
      end
    end
    object tbsVendors: TcxTabSheet
      Caption = 'Producator'
      ImageIndex = 2
      object cxGridVendors: TcxGrid
        Left = 0
        Top = 30
        Width = 526
        Height = 269
        Align = alClient
        TabOrder = 1
        object cxGridVendorsTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCustomDrawCell = cxGridTypesTableCustomDrawCell
          OnFocusedRecordChanged = cxGridVendorsTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceVendors
          DataController.KeyFieldNames = 'GG_ID;VENDORID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
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
          Styles.Footer = dmAdditions.cxStyle_GridHeader
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridVendorsTable_VENDORID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'VENDORID'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridVendorsTable_IMG: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_EXCLUDE'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 27
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 43
                Value = 0
              end
              item
                ImageIndex = 42
                Value = 1
              end>
            MinWidth = 24
            Options.Focusing = False
            Options.HorzSizing = False
            Width = 24
            IsCaptionAssigned = True
          end
          object cxGridVendorsTable_VENDOR_TITLE: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'VENDOR_TITLE'
            DataBinding.IsNullValueType = True
            SortIndex = 0
            SortOrder = soAscending
            Width = 200
          end
          object cxGridVendorsTable_CREATED_BY_NAME: TcxGridDBColumn
            Caption = 'Utilizator'
            DataBinding.FieldName = 'CREATED_BY_NAME'
            DataBinding.IsNullValueType = True
            Width = 100
          end
        end
        object cxGridVendorsLevel: TcxGridLevel
          GridView = cxGridVendorsTable
        end
      end
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 526
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
    object tbsGoodsList: TcxTabSheet
      Caption = 'Lista de produse'
      ImageIndex = 3
      object cxGridGoods: TcxGrid
        Left = 0
        Top = 30
        Width = 526
        Height = 269
        Align = alClient
        TabOrder = 1
        object cxGridGoodsTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCustomDrawCell = cxGridTypesTableCustomDrawCell
          OnFocusedRecordChanged = cxGridGoodsTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceGoods
          DataController.KeyFieldNames = 'GG_ID;GOODSID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Footer = dmAdditions.cxStyle_GridHeader
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridGoodsTable_GOODSID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GOODSID'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridGoodsTable_IMG: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_EXCLUDE'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 43
                Value = 0
              end
              item
                ImageIndex = 42
                Value = 1
              end>
            MinWidth = 24
            Options.Focusing = False
            Options.HorzSizing = False
            Width = 24
            IsCaptionAssigned = True
          end
          object cxGridGoodsTable_FLG_FOLDER: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_FOLDER'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 12
                Value = 0
              end
              item
                ImageIndex = 13
                Value = 1
              end>
            MinWidth = 24
            Options.Focusing = False
            Options.HorzSizing = False
            SortIndex = 0
            SortOrder = soDescending
            Width = 24
            IsCaptionAssigned = True
          end
          object cxGridGoodsTable_GOODS_NAME: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'GOODS_NAME'
            DataBinding.IsNullValueType = True
            SortIndex = 1
            SortOrder = soAscending
            Width = 200
          end
          object cxGridGoodsTable_CREATED_BY_NAME: TcxGridDBColumn
            Caption = 'Utilizator'
            DataBinding.FieldName = 'CREATED_BY_NAME'
            DataBinding.IsNullValueType = True
            Width = 100
          end
        end
        object cxGridGoodsLevel: TcxGridLevel
          GridView = cxGridGoodsTable
        end
      end
      object dxBarDockControl3: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 526
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
    object tbsSupplier: TcxTabSheet
      Caption = 'Furnizor'
      ImageIndex = 4
      object dxBarDockControl4: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 526
        Height = 28
        Align = dalTop
        BarManager = dxBarManager1
      end
      object cxGridSupplier: TcxGrid
        Left = 0
        Top = 28
        Width = 526
        Height = 271
        Align = alClient
        TabOrder = 1
        object cxGridSupplierTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCustomDrawCell = cxGridTypesTableCustomDrawCell
          OnFocusedRecordChanged = cxGridGoodsTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceSuppliers
          DataController.KeyFieldNames = 'GG_ID;SUPPLIERID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Footer = dmAdditions.cxStyle_GridHeader
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridSupplierTableView_SUPPLIERID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'SUPPLIERID'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridDBColumn2: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_EXCLUDE'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 43
                Value = 0
              end
              item
                ImageIndex = 42
                Value = 1
              end>
            MinWidth = 24
            Options.Focusing = False
            Options.HorzSizing = False
            Width = 24
            IsCaptionAssigned = True
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'SUPPLIER_NAME'
            DataBinding.IsNullValueType = True
            SortIndex = 0
            SortOrder = soAscending
            Width = 200
          end
          object cxGridDBColumn5: TcxGridDBColumn
            Caption = 'Utilizator'
            DataBinding.FieldName = 'CREATED_BY_NAME'
            DataBinding.IsNullValueType = True
            Width = 100
          end
        end
        object cxGridSupplierLevel: TcxGridLevel
          GridView = cxGridSupplierTableView
        end
      end
    end
  end
  object btnOk: TButton
    Left = 334
    Top = 412
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 436
    Top = 412
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Supplier')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 416
    Top = 24
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
      FloatLeft = 669
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGT_New'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGT_Delete'
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
      FloatLeft = 574
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbVendor_New'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbVendor_Delete'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
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
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 574
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGL_New'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGL_Delete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'SupplierToolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl4
      DockedDockControl = dxBarDockControl4
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 574
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewSupplier'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteSupplier'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbGT_New: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbGT_NewClick
    end
    object bbGT_Delete: TdxBarButton
      Caption = 'Delete'
      Category = 0
      Hint = 'Delete'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbGT_DeleteClick
    end
    object bbVendor_New: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbVendor_NewClick
    end
    object bbVendor_Delete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbVendor_DeleteClick
    end
    object bbGL_New: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbGL_NewClick
    end
    object bbGL_Delete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbGL_DeleteClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Paste'
      Category = 0
      Hint = 'Paste'
      Visible = ivAlways
      ImageIndex = 75
      PaintStyle = psCaptionGlyph
      OnClick = dxBarButton1Click
    end
    object bbNewSupplier: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewSupplierClick
    end
    object bbDeleteSupplier: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteSupplierClick
    end
  end
  object IBCQueryGT: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_MK_GG_TYPES'
      
        '  (GG_ID, GOODSTYPEID, GOODSTYPE_TITLE, FLG_EXCLUDE, CREATED_BY,' +
        ' CREATED_BY_NAME)'
      'VALUES'
      
        '  (:GG_ID, :GOODSTYPEID, :GOODSTYPE_TITLE, :FLG_EXCLUDE, :CREATE' +
        'D_BY, :CREATED_BY_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_MK_GG_TYPES'
      'WHERE'
      '  GG_ID = :Old_GG_ID AND GOODSTYPEID = :Old_GOODSTYPEID')
    SQLUpdate.Strings = (
      'UPDATE VW_MK_GG_TYPES'
      'SET'
      
        '  GG_ID = :GG_ID, GOODSTYPEID = :GOODSTYPEID, GOODSTYPE_TITLE = ' +
        ':GOODSTYPE_TITLE, FLG_EXCLUDE = :FLG_EXCLUDE, CREATED_BY = :CREA' +
        'TED_BY, CREATED_BY_NAME = :CREATED_BY_NAME'
      'WHERE'
      '  GG_ID = :Old_GG_ID AND GOODSTYPEID = :Old_GOODSTYPEID')
    SQLRefresh.Strings = (
      
        'SELECT GG_ID, GOODSTYPEID, GOODSTYPE_TITLE, FLG_EXCLUDE, CREATED' +
        '_BY, CREATED_BY_NAME FROM VW_MK_GG_TYPES'
      'WHERE'
      '  GG_ID = :GG_ID AND GOODSTYPEID = :GOODSTYPEID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_GG_TYPES'
      'WHERE'
      'GG_ID = :Old_GG_ID AND GOODSTYPEID = :Old_GOODSTYPEID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_MK_GG_TYPES'
      ''
      ') q')
    SQL.Strings = (
      'SELECT '
      ' GG_ID, '
      ' GOODSTYPEID, '
      ' GOODSTYPE_TITLE, '
      ' FLG_EXCLUDE, '
      ' CREATED_BY, '
      ' CREATED_BY_NAME '
      'FROM '
      ' VW_MK_GG_TYPES'
      'ORDER BY'
      ' GOODSTYPE_TITLE')
    MasterFields = 'GG_ID'
    DetailFields = 'GG_ID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 72
    Top = 284
  end
  object IBCDataSourceGT: TIBCDataSource
    DataSet = IBCQueryGT
    Left = 72
    Top = 332
  end
  object IBCQueryVendors: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_MK_GG_VENDORS'
      
        '  (GG_ID, VENDORID, VENDOR_TITLE, FLG_EXCLUDE, CREATED_BY, CREAT' +
        'ED_BY_NAME)'
      'VALUES'
      
        '  (:GG_ID, :VENDORID, :VENDOR_TITLE, :FLG_EXCLUDE, :CREATED_BY, ' +
        ':CREATED_BY_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_MK_GG_VENDORS'
      'WHERE'
      '  GG_ID = :Old_GG_ID AND VENDORID = :Old_VENDORID')
    SQLUpdate.Strings = (
      'UPDATE VW_MK_GG_VENDORS'
      'SET'
      
        '  GG_ID = :GG_ID, VENDORID = :VENDORID, VENDOR_TITLE = :VENDOR_T' +
        'ITLE, FLG_EXCLUDE = :FLG_EXCLUDE, CREATED_BY = :CREATED_BY, CREA' +
        'TED_BY_NAME = :CREATED_BY_NAME'
      'WHERE'
      '  GG_ID = :Old_GG_ID AND VENDORID = :Old_VENDORID')
    SQLRefresh.Strings = (
      
        'SELECT GG_ID, VENDORID, VENDOR_TITLE, FLG_EXCLUDE, CREATED_BY, C' +
        'REATED_BY_NAME FROM VW_MK_GG_VENDORS'
      'WHERE'
      '  GG_ID = :GG_ID AND VENDORID = :VENDORID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_MK_GG_VENDORS'
      'WHERE'
      'GG_ID = :Old_GG_ID AND VENDORID = :Old_VENDORID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_MK_GG_VENDORS'
      ''
      ') q')
    SQL.Strings = (
      'SELECT '
      ' GG_ID, '
      ' VENDORID, '
      ' VENDOR_TITLE, '
      ' FLG_EXCLUDE, '
      ' CREATED_BY, '
      ' CREATED_BY_NAME '
      'FROM '
      ' VW_MK_GG_VENDORS'
      'ORDER BY'
      ' VENDOR_TITLE')
    MasterFields = 'GG_ID'
    DetailFields = 'GG_ID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 176
    Top = 264
  end
  object IBCDataSourceVendors: TIBCDataSource
    DataSet = IBCQueryVendors
    Left = 176
    Top = 312
  end
  object IBCQueryGoods: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_MK_GG_GOODS'
      
        '  (GG_ID, GOODSID, GOODS_NAME, FLG_FOLDER, FLG_EXCLUDE, CREATED_' +
        'BY, CREATED_BY_NAME)'
      'VALUES'
      
        '  (:GG_ID, :GOODSID, :GOODS_NAME, :FLG_FOLDER, :FLG_EXCLUDE, :CR' +
        'EATED_BY, :CREATED_BY_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_MK_GG_GOODS'
      'WHERE'
      '  GG_ID = :Old_GG_ID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_MK_GG_GOODS'
      'SET'
      
        '  GG_ID = :GG_ID, GOODSID = :GOODSID, GOODS_NAME = :GOODS_NAME, ' +
        'FLG_FOLDER = :FLG_FOLDER, FLG_EXCLUDE = :FLG_EXCLUDE, CREATED_BY' +
        ' = :CREATED_BY, CREATED_BY_NAME = :CREATED_BY_NAME'
      'WHERE'
      '  GG_ID = :Old_GG_ID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT GG_ID, GOODSID, GOODS_NAME, FLG_FOLDER, FLG_EXCLUDE, CREA' +
        'TED_BY, CREATED_BY_NAME FROM VW_MK_GG_GOODS'
      'WHERE'
      '  GG_ID = :GG_ID AND GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_MK_GG_GOODS'
      'WHERE'
      'GG_ID = :Old_GG_ID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_MK_GG_GOODS'
      ''
      ') q')
    SQL.Strings = (
      'SELECT '
      ' GG_ID, '
      ' GOODSID, '
      ' GOODS_NAME, '
      ' FLG_EXCLUDE, '
      ' CREATED_BY, '
      ' CREATED_BY_NAME,'
      ' FLG_FOLDER'
      'FROM '
      ' VW_MK_GG_GOODS'
      'ORDER BY'
      ' FLG_FOLDER DESC, GOODS_NAME')
    MasterFields = 'GG_ID'
    DetailFields = 'GG_ID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 444
    Top = 168
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 444
    Top = 220
  end
  object IBCQuerySuppliers: TIBCQuery
    KeyFields = 'GG_ID;SUPPLIERID'
    SQLInsert.Strings = (
      'INSERT INTO VW_MK_GG_SUPPLIERS'
      '  (GG_ID, SUPPLIERID, SUPPLIER_NAME, FLG_EXCLUDE, CREATED_BY)'
      'VALUES'
      
        '  (:GG_ID, :SUPPLIERID, :SUPPLIER_NAME, :FLG_EXCLUDE, :CREATED_B' +
        'Y)')
    SQLDelete.Strings = (
      'DELETE FROM VW_MK_GG_SUPPLIERS'
      'WHERE'
      '  GG_ID = :Old_GG_ID AND SUPPLIERID = :Old_SUPPLIERID')
    SQLUpdate.Strings = (
      'UPDATE VW_MK_GG_SUPPLIERS'
      'SET'
      
        '  GG_ID = :GG_ID, SUPPLIERID = :SUPPLIERID, SUPPLIER_NAME = :SUP' +
        'PLIER_NAME, FLG_EXCLUDE = :FLG_EXCLUDE, CREATED_BY = :CREATED_BY'
      'WHERE'
      '  GG_ID = :Old_GG_ID AND SUPPLIERID = :Old_SUPPLIERID')
    SQLRefresh.Strings = (
      
        'SELECT GG_ID, SUPPLIERID, SUPPLIER_NAME, FLG_EXCLUDE, CREATED_BY' +
        ' FROM VW_MK_GG_SUPPLIERS'
      'WHERE'
      '  GG_ID = :GG_ID AND SUPPLIERID = :SUPPLIERID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_GG_SUPPLIERS'
      'WHERE'
      'GG_ID = :Old_GG_ID AND SUPPLIERID = :Old_SUPPLIERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_MK_GG_SUPPLIERS'
      ''
      ') q')
    SQL.Strings = (
      'SELECT * FROM VW_MK_GG_SUPPLIERS'
      'ORDER BY SUPPLIER_NAME')
    MasterFields = 'GG_ID'
    DetailFields = 'GG_ID'
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 304
    Top = 176
  end
  object IBCDataSourceSuppliers: TIBCDataSource
    DataSet = IBCQuerySuppliers
    Left = 240
    Top = 176
  end
end
