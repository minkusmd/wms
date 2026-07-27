object frmWebStaticPagesDlg: TfrmWebStaticPagesDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pagini statice pe site'
  ClientHeight = 634
  ClientWidth = 1108
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
    Width = 1108
    Height = 64
    Title = 'Pagini statice pe site'
    Text = 'Gestionarea paginilor statice pe site'
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
    Width = 1092
    Height = 505
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1092
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 1092
      Height = 475
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourcePages
        DataController.KeyFieldNames = 'PAGEID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTableColumn1: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'CREATED_DATE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid_PAGEID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'PAGEID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Options.Moving = False
          Width = 64
        end
        object cxGrid_FLG_ENABLED: TcxGridDBColumn
          Caption = 'Activ'
          DataBinding.FieldName = 'FLG_ENABLED'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGrid_TITLE_RUS: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE_RUS'
          DataBinding.IsNullValueType = True
          Width = 200
        end
        object cxGrid_TITLE_ROM: TcxGridDBColumn
          Caption = 'Denumirea'
          DataBinding.FieldName = 'TITLE_ROM'
          DataBinding.IsNullValueType = True
          Width = 200
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnClose: TButton
    Left = 496
    Top = 597
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
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
    Left = 480
    Top = 16
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
      FloatLeft = 748
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
          ItemName = 'bbModify'
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
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
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
  end
  object IBCQueryPages: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TWEB_PAGES'
      
        '  (PAGEID, TITLE_ROM, TITLE_RUS, BODY_ROM, BODY_RUS, CREATED_DAT' +
        'E, MODIFIED_DATE, CREATED_BY, MODIFIED_BY, FLG_ENABLED, META_TIT' +
        'LE_RO, META_TITLE_RU, META_DESC_RO, META_DESC_RU, META_KEY_RO, M' +
        'ETA_KEY_RU)'
      'VALUES'
      
        '  (:PAGEID, :TITLE_ROM, :TITLE_RUS, :BODY_ROM, :BODY_RUS, :CREAT' +
        'ED_DATE, :MODIFIED_DATE, :CREATED_BY, :MODIFIED_BY, :FLG_ENABLED' +
        ', :META_TITLE_RO, :META_TITLE_RU, :META_DESC_RO, :META_DESC_RU, ' +
        ':META_KEY_RO, :META_KEY_RU)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_PAGES'
      'WHERE'
      '  PAGEID = :Old_PAGEID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_PAGES'
      'SET'
      
        '  PAGEID = :PAGEID, TITLE_ROM = :TITLE_ROM, TITLE_RUS = :TITLE_R' +
        'US, BODY_ROM = :BODY_ROM, BODY_RUS = :BODY_RUS, CREATED_DATE = :' +
        'CREATED_DATE, MODIFIED_DATE = :MODIFIED_DATE, CREATED_BY = :CREA' +
        'TED_BY, MODIFIED_BY = :MODIFIED_BY, FLG_ENABLED = :FLG_ENABLED, ' +
        'META_TITLE_RO = :META_TITLE_RO, META_TITLE_RU = :META_TITLE_RU, ' +
        'META_DESC_RO = :META_DESC_RO, META_DESC_RU = :META_DESC_RU, META' +
        '_KEY_RO = :META_KEY_RO, META_KEY_RU = :META_KEY_RU'
      'WHERE'
      '  PAGEID = :Old_PAGEID')
    SQLRefresh.Strings = (
      
        'SELECT PAGEID, TITLE_ROM, TITLE_RUS, BODY_ROM, BODY_RUS, CREATED' +
        '_DATE, MODIFIED_DATE, CREATED_BY, MODIFIED_BY, FLG_ENABLED, META' +
        '_TITLE_RO, META_TITLE_RU, META_DESC_RO, META_DESC_RU, META_KEY_R' +
        'O, META_KEY_RU FROM TWEB_PAGES'
      'WHERE'
      '  PAGEID = :PAGEID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_PAGES'
      'WHERE'
      'PAGEID = :Old_PAGEID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_PAGES'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      '*'
      'FROM '
      ' TWEB_PAGES'
      'ORDER BY CREATED_DATE DESC')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 128
    Top = 156
  end
  object IBCDataSourcePages: TIBCDataSource
    DataSet = IBCQueryPages
    Left = 128
    Top = 216
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 128
    Top = 280
  end
end
