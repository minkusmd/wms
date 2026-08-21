object frmWebCatalogVirtualFoldersDlg: TfrmWebCatalogVirtualFoldersDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Mape virtuale'
  ClientHeight = 430
  ClientWidth = 720
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
    Width = 720
    Height = 64
    Title = 'Mape virtuale'
    Text = 'Subcategorii pe atribut, afisate ca tile-uri in capul categoriei'
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
    Width = 704
    Height = 305
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object pnTop: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 704
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
        Width = 108
        Height = 15
        Caption = 'Mape virtuale pentru'
      end
      object edCatalogName: TcxTextEdit
        Left = 133
        Top = 13
        TabStop = False
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 548
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 56
      Width = 704
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 86
      Width = 704
      Height = 219
      Align = alClient
      TabOrder = 2
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTableCellDblClick
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceFolders
        DataController.KeyFieldNames = 'ID'
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
        OptionsView.NoDataToDisplayInfoText = '<nu sunt mape virtuale>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTable_ID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'ID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridTable_TITLE_ROM: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE_ROM'
          Width = 130
        end
        object cxGridTable_TITLE_RUS: TcxGridDBColumn
          Caption = 'Denumire RU'
          DataBinding.FieldName = 'TITLE_RUS'
          Width = 130
        end
        object cxGridTable_REWRITE_URL: TcxGridDBColumn
          Caption = 'Adresa URL'
          DataBinding.FieldName = 'REWRITE_URL'
          Width = 120
        end
        object cxGridTable_FILTER_NAME: TcxGridDBColumn
          Caption = 'Atribut'
          DataBinding.FieldName = 'FILTER_NAME'
          Width = 120
        end
        object cxGridTable_FLG_ENABLED: TcxGridDBColumn
          Caption = 'Activa'
          DataBinding.FieldName = 'FLG_ENABLED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ReadOnly = True
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_FLG_TILE: TcxGridDBColumn
          Caption = 'Tile'
          DataBinding.FieldName = 'FLG_TILE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ReadOnly = True
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridTable_HAS_IMAGE: TcxGridDBColumn
          Caption = 'Img'
          DataBinding.FieldName = 'HAS_IMAGE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ReadOnly = True
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridTable_ORDERNO: TcxGridDBColumn
          Caption = 'Ordine'
          DataBinding.FieldName = 'ORDERNO'
          HeaderAlignmentHorz = taCenter
          SortIndex = 0
          SortOrder = soAscending
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnClose: TButton
    Left = 605
    Top = 388
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 1
    TabOrder = 1
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
    Left = 460
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
      Caption = 'Noua'
      Category = 0
      Hint = 'Mapa virtuala noua'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica mapa virtuala'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge mapa virtuala'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteClick
    end
  end
  object IBCQueryFolders: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'GEN_TWEB_CATALOG_VIRTUAL_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_CATALOG_VIRTUAL'
      '  (ID, CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,'
      '   FILTERID, FILTERPARAMIDS, ORDERNO, FLG_ENABLED, FLG_TILE,'
      '   META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM,'
      '   META_DESCRIPTION_RUS, SEO_TEXT_ROM, SEO_TEXT_RUS)'
      'VALUES'
      '  (:ID, :CATALOGID, :TITLE_ROM, :TITLE_RUS, :H1_ROM, :H1_RUS, :REWRITE_URL,'
      '   :FILTERID, :FILTERPARAMIDS, :ORDERNO, :FLG_ENABLED, :FLG_TILE,'
      '   :META_TITLE_ROM, :META_TITLE_RUS, :META_DESCRIPTION_ROM,'
      '   :META_DESCRIPTION_RUS, :SEO_TEXT_ROM, :SEO_TEXT_RUS)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TWEB_CATALOG_VIRTUAL'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_CATALOG_VIRTUAL'
      'SET'
      '  CATALOGID = :CATALOGID,'
      '  TITLE_ROM = :TITLE_ROM,'
      '  TITLE_RUS = :TITLE_RUS,'
      '  H1_ROM = :H1_ROM,'
      '  H1_RUS = :H1_RUS,'
      '  REWRITE_URL = :REWRITE_URL,'
      '  FILTERID = :FILTERID,'
      '  FILTERPARAMIDS = :FILTERPARAMIDS,'
      '  ORDERNO = :ORDERNO,'
      '  FLG_ENABLED = :FLG_ENABLED,'
      '  FLG_TILE = :FLG_TILE,'
      '  META_TITLE_ROM = :META_TITLE_ROM,'
      '  META_TITLE_RUS = :META_TITLE_RUS,'
      '  META_DESCRIPTION_ROM = :META_DESCRIPTION_ROM,'
      '  META_DESCRIPTION_RUS = :META_DESCRIPTION_RUS,'
      '  SEO_TEXT_ROM = :SEO_TEXT_ROM,'
      '  SEO_TEXT_RUS = :SEO_TEXT_RUS'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TWEB_CATALOG_VIRTUAL'
      'WHERE'
      '  ID = :ID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT * FROM VW_TWEB_CATALOG_VIRTUAL'
      'WHERE CATALOGID = :ID'
      'ORDER BY ORDERNO, ID')
    AutoCommit = False
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
  object IBCDataSourceFolders: TIBCDataSource
    DataSet = IBCQueryFolders
    Left = 48
    Top = 272
  end
end
