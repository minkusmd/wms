object frmReportGroupDlg: TfrmReportGroupDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1043#1088#1091#1087#1087#1099' '#1086#1090#1095#1077#1090#1086#1074
  ClientHeight = 390
  ClientWidth = 485
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
    Width = 485
    Height = 64
    Title = #1043#1088#1091#1087#1087#1099' '#1086#1090#1095#1077#1090#1086#1074
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
    ImageIndex = 8
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 469
    Height = 265
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
      Width = 469
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 469
      Height = 235
      Align = alClient
      TabOrder = 1
      object cxGridDBTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridDBTableCellDblClick
        OnFocusedRecordChanged = cxGridDBTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceReportGroup
        DataController.KeyFieldNames = 'REPORTGROUPID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1075#1088#1091#1087#1087'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGrid_REPORTGROUPID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'REPORTGROUPID'
          DataBinding.IsNullValueType = True
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGrid_ORDERNO: TcxGridDBColumn
          Caption = #8470
          DataBinding.FieldName = 'REPORTGROUPID'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 50
        end
        object cxGrid_TITLE: TcxGridDBColumn
          Caption = #1043#1088#1091#1087#1087#1072
          DataBinding.FieldName = 'TITLE'
          DataBinding.IsNullValueType = True
          Width = 300
        end
        object cxGrid_CODE: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1087#1086#1080#1089#1082#1072
          DataBinding.FieldName = 'CODE'
          DataBinding.IsNullValueType = True
          Width = 100
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridDBTable
      end
    end
  end
  object btnOk: TButton
    Left = 372
    Top = 348
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 2
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
    Left = 256
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
      FloatLeft = 509
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
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSort'
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
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Hint = #1053#1086#1074#1072#1103
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
    end
    object bbDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteClick
    end
    object bbSort: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortClick
    end
  end
  object IBCDataSourceReportGroup: TIBCDataSource
    DataSet = IBCQueryReportGroup
    Left = 80
    Top = 208
  end
  object IBCQueryReportGroup: TIBCQuery
    KeyFields = 'REPORTGROUPID'
    KeyGenerator = 'SQ_TS_REPORT_GROUPS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_REPORT_GROUPS'
      '  (REPORTGROUPID, TITLE, CODE)'
      'VALUES'
      '  (:REPORTGROUPID, :TITLE, :CODE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_REPORT_GROUPS'
      'WHERE'
      '  REPORTGROUPID = :Old_REPORTGROUPID')
    SQLUpdate.Strings = (
      'UPDATE TS_REPORT_GROUPS'
      'SET'
      '  REPORTGROUPID = :REPORTGROUPID, TITLE = :TITLE, CODE = :CODE'
      'WHERE'
      '  REPORTGROUPID = :Old_REPORTGROUPID')
    SQLRefresh.Strings = (
      'SELECT '
      ' REPORTGROUPID, '
      ' TITLE, '
      ' CODE,'
      ' ORDERNO'
      'FROM '
      ' TS_REPORT_GROUPS'
      'WHERE'
      ' REPORTGROUPID = :REPORTGROUPID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_REPORT_GROUPS'
      'WHERE'
      'REPORTGROUPID = :Old_REPORTGROUPID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' REPORTGROUPID,'
      ' TITLE,'
      ' CODE,'
      ' ORDERNO'
      'FROM'
      ' TS_REPORT_GROUPS'
      'ORDER BY ORDERNO')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 80
    Top = 260
  end
  object IBCTrDefaultUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 196
    Top = 232
  end
end
