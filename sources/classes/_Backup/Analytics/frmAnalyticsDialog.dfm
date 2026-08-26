object frmAnalyticsDlg: TfrmAnalyticsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderIcons = [biSystemMenu]
  Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  ClientHeight = 608
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    601
    608)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 601
    Height = 64
    Title = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
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
    ImageIndex = 11
    ExplicitWidth = 611
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 585
    Height = 483
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 585
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
      ExplicitWidth = 595
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 585
      Height = 453
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 595
      ExplicitHeight = 331
      object cxGridTable: TcxGridDBTableView
        OnKeyDown = cxGridTableKeyDown
        NavigatorButtons.ConfirmDelete = False
        OnCellDblClick = cxGridTableCellDblClick
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceAnalytics
        DataController.KeyFieldNames = 'ANALITICAID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridTable_ANALITICAID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'ANALITICAID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_FLG_FOLDER: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_FOLDER'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 50
              Value = 0
            end
            item
              ImageIndex = 13
              Value = 1
            end>
          Properties.ReadOnly = True
          MinWidth = 24
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Options.ShowCaption = False
          VisibleForCustomization = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridTable_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
          Width = 100
        end
        object cxGridTable_DESCRIPTION: TcxGridDBColumn
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          DataBinding.FieldName = 'DESCRIPTION'
          Width = 100
        end
        object cxGridTable_FLG_NOT_CHANGE_BALANS: TcxGridDBColumn
          Caption = #1053#1077#1048#1041
          DataBinding.FieldName = 'FLG_NOT_CHANGE_BALANS'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 34
          Options.HorzSizing = False
          Width = 34
        end
        object cxGridTable_FLG_CHANGE_BALANS: TcxGridDBColumn
          Caption = #1048#1041
          DataBinding.FieldName = 'FLG_CHANGE_BALANS'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 34
          Options.HorzSizing = False
          Width = 34
        end
        object cxGridTable_FLG_EXPENSES: TcxGridDBColumn
          Caption = #1047#1072#1090#1088
          DataBinding.FieldName = 'FLG_EXPENSES'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 34
          Options.HorzSizing = False
          Width = 34
        end
        object cxGridTable_FLG_CALC_SALDO: TcxGridDBColumn
          Caption = #1056#1072#1089#1057#1083#1076
          DataBinding.FieldName = 'FLG_CALC_SALDO'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
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
  object btnOk: TcxButton
    AlignWithMargins = True
    Left = 490
    Top = 563
    Width = 90
    Height = 29
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 16
    Margins.Bottom = 12
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 6
    ExplicitLeft = 500
    ExplicitTop = 447
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
    Left = 400
    Top = 8
    DockControlHeights = (
      0
      0
      0
      0)
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
      FloatLeft = 635
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbNavHome'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbNavPrev'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbNavNext'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbNewAnalytics'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyAnalytics'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteAnalytics'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewAnalytics: TdxBarSubItem
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Visible = ivAlways
      ImageIndex = 40
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewAnalyticsItem'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbNewAnalyticsFolder'
        end>
    end
    object bbNewAnalyticsItem: TdxBarButton
      Caption = #1053#1086#1074#1072#1103' '#1072#1085#1072#1083#1080#1090#1080#1082#1072
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1072#1085#1072#1083#1080#1090#1080#1082#1072
      Visible = ivAlways
      ShortCut = 45
      OnClick = bbNewAnalyticsItemClick
    end
    object bbNewAnalyticsFolder: TdxBarButton
      Caption = #1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
      Visible = ivAlways
      OnClick = bbNewAnalyticsFolderClick
    end
    object bbModifyAnalytics: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyAnalyticsClick
    end
    object bbDeleteAnalytics: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteAnalyticsClick
    end
    object bbNavPrev: TdxBarButton
      Caption = #1053#1072#1079#1072#1076
      Category = 0
      Hint = #1053#1072#1079#1072#1076
      Visible = ivAlways
      ImageIndex = 6
      OnClick = bbNavPrevClick
    end
    object bbNavNext: TdxBarButton
      Caption = #1042#1087#1077#1088#1077#1076
      Category = 0
      Hint = #1042#1087#1077#1088#1077#1076
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbNavNextClick
    end
    object bbNavHome: TdxBarButton
      Caption = #1042' '#1085#1072#1095#1072#1083#1086
      Category = 0
      Hint = #1042' '#1085#1072#1095#1072#1083#1086
      Visible = ivAlways
      ImageIndex = 5
      ShortCut = 36
      OnClick = bbNavHomeClick
    end
  end
  object IBCQueryAnalytics: TIBCQuery
    KeyFields = 'ANALITICAID'
    KeyGenerator = 'SQ_TS_ANALYTICS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_ANALYTICS'
      '  (ANALITICAID, PARENTID, TITLE, DESCRIPTION, FLG_FOLDER, '
      
        '   FLG_NOT_CHANGE_BALANS, FLG_CHANGE_BALANS, FLG_EXPENSES, FLG_C' +
        'ALC_SALDO)'
      'VALUES'
      '  (:ANALITICAID, :PARENTID, :TITLE, :DESCRIPTION, :FLG_FOLDER, '
      
        '   :FLG_NOT_CHANGE_BALANS, :FLG_CHANGE_BALANS, :FLG_EXPENSES, :F' +
        'LG_CALC_SALDO)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_ANALYTICS'
      'WHERE'
      '  ANALITICAID = :Old_ANALITICAID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_ANALYTICS'
      'SET'
      
        '  ANALITICAID = :ANALITICAID, PARENTID = :PARENTID, TITLE = :TIT' +
        'LE, DESCRIPTION = :DESCRIPTION, FLG_FOLDER = :FLG_FOLDER, '
      '  FLG_NOT_CHANGE_BALANS = :FLG_NOT_CHANGE_BALANS, '
      '  FLG_CHANGE_BALANS = :FLG_CHANGE_BALANS, '
      '  FLG_EXPENSES = :FLG_EXPENSES,'
      '  FLG_CALC_SALDO = :FLG_CALC_SALDO'
      'WHERE'
      '  ANALITICAID = :Old_ANALITICAID')
    SQLRefresh.Strings = (
      'SELECT '
      ' ANALITICAID, PARENTID, TITLE, DESCRIPTION, FLG_FOLDER, '
      
        ' FLG_NOT_CHANGE_BALANS, FLG_CHANGE_BALANS, FLG_EXPENSES, FLG_CAL' +
        'C_SALDO'
      'FROM '
      ' VW_TS_ANALYTICS'
      'WHERE'
      ' ANALITICAID = :ANALITICAID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_ANALYTICS'
      'WHERE'
      'ANALITICAID = :Old_ANALITICAID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' * '
      'FROM '
      ' VW_TS_ANALYTICS '
      'WHERE '
      ' PARENTID=:ParentID '
      'ORDER BY'
      ' FLG_FOLDER DESC, TITLE')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 84
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ParentID'
      end>
  end
  object IBCDataSourceAnalytics: TIBCDataSource
    DataSet = IBCQueryAnalytics
    Left = 84
    Top = 204
  end
end
