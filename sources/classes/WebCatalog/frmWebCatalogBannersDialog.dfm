object frmWebCatalogBannersDlg: TfrmWebCatalogBannersDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1041#1072#1085#1085#1077#1088#1099
  ClientHeight = 430
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 564
    Height = 64
    Title = 'Banere'
    Text = 'Banere pentru catalog Web'
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 548
    Height = 305
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 56
      Width = 548
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 86
      Width = 548
      Height = 219
      Align = alClient
      TabOrder = 2
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTableCellDblClick
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceBanners
        DataController.KeyFieldNames = 'BANNERID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTable_BANNERID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'BANNERID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridTable_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          Width = 100
        end
        object cxGridTable_START_DATE: TcxGridDBColumn
          Caption = 'Inceput'
          DataBinding.FieldName = 'START_DATE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridTable_END_DATE: TcxGridDBColumn
          Caption = 'Sfirsit'
          DataBinding.FieldName = 'END_DATE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridTable_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object pnTop: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 548
      Height = 54
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 2
      Align = alTop
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 12
        Top = 16
        Width = 101
        Height = 15
        Caption = 'Baner pentru mapa'
      end
      object edCatalogName: TcxTextEdit
        Left = 133
        Top = 13
        TabStop = False
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 392
      end
    end
  end
  object btnClose: TButton
    Left = 449
    Top = 388
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 1
    TabOrder = 2
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
    Left = 324
    Top = 12
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
      FloatLeft = 588
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSort'
        end
        item
          Visible = True
          ItemName = 'bbImport'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteClick
    end
    object bbSort: TdxBarButton
      Caption = #1059#1087#1086#1088#1103#1076#1086#1095#1080#1090#1100' '#1073#1072#1085#1085#1077#1088#1099
      Category = 0
      Hint = #1059#1087#1086#1088#1103#1076#1086#1095#1080#1090#1100' '#1073#1072#1085#1085#1077#1088#1099
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortClick
    end
    object bbImport: TdxBarButton
      Caption = 'Import'
      Category = 0
      Hint = 'Import'
      Visible = ivAlways
      ImageIndex = 143
      OnClick = bbImportClick
    end
  end
  object IBCQueryBanners: TIBCQuery
    KeyFields = 'BANNERID'
    KeyGenerator = 'SQ_TWEB_CATALOG_BANNERS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_CATALOG_BANNERS'
      
        '  (BANNERID, CATALOGID, TITLE, START_DATE, END_DATE, BACK_IMAGE,' +
        ' FRONT_IMAGE, '
      '   BACK_COLOR, FLG_HAS_BACKGROUND, FLG_BACK_COLOR, URL, URL_RU)'
      'VALUES'
      
        '  (:BANNERID, :CATALOGID, :TITLE, :START_DATE, :END_DATE, :BACK_' +
        'IMAGE, :FRONT_IMAGE, '
      
        '   :BACK_COLOR, :FLG_HAS_BACKGROUND, :FLG_BACK_COLOR, :URL, :URL' +
        '_RU)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_CATALOG_BANNERS'
      'WHERE'
      '  BANNERID = :Old_BANNERID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_CATALOG_BANNERS'
      'SET'
      '  BANNERID = :BANNERID, '
      '  CATALOGID = :CATALOGID, '
      '  TITLE = :TITLE, '
      '  START_DATE = :START_DATE, '
      '  END_DATE = :END_DATE, '
      '  BACK_IMAGE = :BACK_IMAGE,'
      '  FRONT_IMAGE = :FRONT_IMAGE,'
      '  BACK_COLOR = :BACK_COLOR, '
      '  FLG_HAS_BACKGROUND = :FLG_HAS_BACKGROUND, '
      '  FLG_BACK_COLOR = :FLG_BACK_COLOR,'
      '  URL = :URL,'
      '  URL_RU = :URL_RU'
      'WHERE'
      '  BANNERID = :Old_BANNERID')
    SQLRefresh.Strings = (
      'SELECT '
      '*'
      'FROM '
      ' VW_TWEB_CATALOG_BANNERS'
      'WHERE'
      ' BANNERID = :BANNERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_CATALOG_BANNERS'
      'WHERE'
      'BANNERID = :Old_BANNERID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' BANNERID, '
      ' CATALOGID, '
      ' TITLE, '
      ' START_DATE, '
      ' END_DATE, '
      ' BACK_IMAGE, '
      ' FRONT_IMAGE, '
      ' IMAGE_RO,'
      ' IMAGE_RU,'
      ' BACK_COLOR, '
      ' FLG_HAS_BACKGROUND, '
      ' FLG_BACK_COLOR,'
      ' ORDERNO,'
      ' URL,'
      ' URL_RU'
      'FROM '
      ' VW_TWEB_CATALOG_BANNERS'
      'WHERE CATALOGID=:ID')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 48
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
  object IBCDataSourceBanners: TIBCDataSource
    DataSet = IBCQueryBanners
    Left = 48
    Top = 272
  end
  object IBCTrLocal: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 328
    Top = 208
  end
end
