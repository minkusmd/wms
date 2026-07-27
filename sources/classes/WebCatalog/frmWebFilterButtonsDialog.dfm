object frmWebFilterButtonsDlg: TfrmWebFilterButtonsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderStyle = bsDialog
  Caption = 'Butoane de trecere pentru filtre web'
  ClientHeight = 664
  ClientWidth = 733
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    733
    664)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 733
    Height = 64
    Title = 'Butoane de trecere pentru filtre web'
    Text = 'Gestiune'
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
    ImageIndex = 7
  end
  object pnClient: TPanel
    Left = 0
    Top = 64
    Width = 733
    Height = 546
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 8
      Top = 8
      Width = 717
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 8
      Top = 38
      Width = 717
      Height = 508
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTableCellDblClick
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceButtons
        DataController.KeyFieldNames = 'FILTER_BUTTON_ID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
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
        Styles.OnGetContentStyle = cxGridTableStylesGetContentStyle
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGrid_FILTER_BUTTON_ID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'FILTER_BUTTON_ID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGrid_SYS_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'SYS_TITLE'
          DataBinding.IsNullValueType = True
          Width = 100
        end
        object cxGrid_TITLE_ROM: TcxGridDBColumn
          Caption = 'Denumire buton'
          DataBinding.FieldName = 'TITLE_ROM'
          DataBinding.IsNullValueType = True
          Width = 80
        end
        object cxGrid_TITLE_RUS: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1085#1086#1087#1082#1080' '#1085#1072' '#1088#1091#1089#1089#1082#1086#1084
          DataBinding.FieldName = 'TITLE_RUS'
          DataBinding.IsNullValueType = True
          Width = 80
        end
        object cxGrid_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          DataBinding.IsNullValueType = True
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
        object cxGrid_FLG_ACTIVE: TcxGridDBColumn
          Caption = 'Activ'
          DataBinding.FieldName = 'FLG_ACTIVE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 36
          Options.HorzSizing = False
          Width = 36
        end
        object cxGrid_FLG_USE_FILTERS: TcxGridDBColumn
          Caption = 'Filtru'
          DataBinding.FieldName = 'FLG_USE_FILTERS'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 36
          Options.HorzSizing = False
          Width = 36
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnOk: TButton
    Left = 522
    Top = 621
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 626
    Top = 621
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object dxBarManager: TdxBarManager
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
    Left = 424
    Top = 24
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
      FloatLeft = 667
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
  object IBCQueryButtons: TIBCQuery
    KeyFields = 'FILTER_BUTTON_ID'
    KeyGenerator = 'SQ_TS_FILTER_BUTTON_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_FILTER_BUTTON'
      
        '  (FILTER_BUTTON_ID, SYS_TITLE, TITLE_ROM, TITLE_RUS, NAV_URL, S' +
        'TYLE_INDEX, CUSTOM_FILTERID, FLG_ACTIVE, FLG_USE_FILTERS, FLG_FI' +
        'LTER_BY_VALUE)'
      'VALUES'
      
        '  (:FILTER_BUTTON_ID, :SYS_TITLE, :TITLE_ROM, :TITLE_RUS, :NAV_U' +
        'RL, :STYLE_INDEX, :CUSTOM_FILTERID, :FLG_ACTIVE, :FLG_USE_FILTER' +
        'S, :FLG_FILTER_BY_VALUE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_FILTER_BUTTON'
      'WHERE'
      '  FILTER_BUTTON_ID = :Old_FILTER_BUTTON_ID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_FILTER_BUTTON'
      'SET'
      '  FILTER_BUTTON_ID = :FILTER_BUTTON_ID, '
      '  SYS_TITLE = :SYS_TITLE, '
      '  TITLE_ROM = :TITLE_ROM, '
      '  TITLE_RUS = :TITLE_RUS, '
      '  NAV_URL = :NAV_URL, '
      '  STYLE_INDEX = :STYLE_INDEX, '
      '  CUSTOM_FILTERID = :CUSTOM_FILTERID,'
      '  FLG_ACTIVE = :FLG_ACTIVE,'
      '  FLG_USE_FILTERS = :FLG_USE_FILTERS,'
      '  FLG_FILTER_BY_VALUE = :FLG_FILTER_BY_VALUE'
      'WHERE'
      '  FILTER_BUTTON_ID = :Old_FILTER_BUTTON_ID')
    SQLRefresh.Strings = (
      'SELECT '
      ' FILTER_BUTTON_ID, '
      ' SYS_TITLE, '
      ' TITLE_ROM, '
      ' TITLE_RUS, '
      ' NAV_URL, '
      ' STYLE_INDEX, '
      ' CUSTOM_FILTERID, '
      ' CUSTOM_FILTER_TITLE_ROM, '
      ' CUSTOM_FILTER_TITLE_RUS,'
      ' ORDERNO,'
      ' FLG_ACTIVE,'
      ' FLG_USE_FILTERS,'
      ' FLG_FILTER_BY_VALUE '
      'FROM '
      ' VW_TS_FILTER_BUTTON'
      'WHERE'
      '  FILTER_BUTTON_ID = :FILTER_BUTTON_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_FILTER_BUTTON'
      'WHERE'
      'FILTER_BUTTON_ID = :Old_FILTER_BUTTON_ID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' FILTER_BUTTON_ID, '
      ' SYS_TITLE, '
      ' TITLE_ROM, '
      ' TITLE_RUS, '
      ' NAV_URL, '
      ' STYLE_INDEX, '
      ' CUSTOM_FILTERID, '
      ' CUSTOM_FILTER_TITLE_ROM, '
      ' CUSTOM_FILTER_TITLE_RUS,'
      ' ORDERNO,'
      ' FLG_ACTIVE,'
      ' FLG_USE_FILTERS,'
      ' FLG_FILTER_BY_VALUE '
      'FROM '
      ' VW_TS_FILTER_BUTTON')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 76
    Top = 232
  end
  object IBCDataSourceButtons: TIBCDataSource
    DataSet = IBCQueryButtons
    Left = 76
    Top = 184
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 172
    Top = 204
  end
end
