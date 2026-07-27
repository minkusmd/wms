object frmAnalyticsDlg: TfrmAnalyticsDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Analitica documente'
  ClientHeight = 633
  ClientWidth = 993
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    993
    633)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 993
    Height = 64
    Title = 'Analitica documentelor'
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
    ImageIndex = 11
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 101
    Width = 973
    Height = 483
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 973
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 281
      Top = 30
      Width = 692
      Height = 453
      Align = alClient
      TabOrder = 3
      object cxGridTable: TcxGridDBTableView
        OnKeyDown = cxGridTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
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
          Caption = 'Cod'
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
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          Width = 229
        end
        object cxGridTable_DESCRIPTION: TcxGridDBColumn
          Caption = 'Descriere'
          DataBinding.FieldName = 'DESCRIPTION'
          Width = 193
        end
        object cxGridTable_FLG_NOT_CHANGE_BALANS: TcxGridDBColumn
          Caption = #1053#1077#1048#1041
          DataBinding.FieldName = 'FLG_NOT_CHANGE_BALANS'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 34
          Options.HorzSizing = False
          Width = 34
        end
        object cxGridTable_FLG_CHANGE_BALANS: TcxGridDBColumn
          Caption = 'SB'
          DataBinding.FieldName = 'FLG_CHANGE_BALANS'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          HeaderHint = 'Schimba Bilanta'
          MinWidth = 34
          Options.HorzSizing = False
          Width = 34
        end
        object cxGridTable_FLG_EXPENSES: TcxGridDBColumn
          Caption = 'Chlt'
          DataBinding.FieldName = 'FLG_EXPENSES'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          HeaderHint = 'Cheltuieli'
          MinWidth = 34
          Options.HorzSizing = False
          Width = 34
        end
        object cxGridTable_FLG_CALC_SALDO: TcxGridDBColumn
          Caption = 'ClcSld'
          DataBinding.FieldName = 'FLG_CALC_SALDO'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          HeaderHint = 'Calcul Sold'
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object cxDBTreeList1: TcxDBTreeList
      Left = 0
      Top = 30
      Width = 273
      Height = 453
      Align = alLeft
      Bands = <
        item
        end>
      DataController.DataSource = IBCDataSourceAnalyticFolders
      DataController.ImageIndexField = 'FLG_CALC_SALDO'
      DataController.ParentField = 'PARENTID'
      DataController.KeyField = 'ANALITICAID'
      Images = dmAdditions.cxImageList_MainTabs
      Navigator.Buttons.CustomButtons = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.ChangeDelay = 1000
      OptionsBehavior.IncSearch = True
      OptionsSelection.HideFocusRect = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      RootValue = 0
      ScrollbarAnnotations.CustomAnnotations = <>
      TabOrder = 1
      OnChange = cxDBTreeList1Change
      object cxDBTreeList1ANALITICAID: TcxDBTreeListColumn
        Caption.AlignHorz = taCenter
        Caption.Text = 'cod'
        DataBinding.FieldName = 'ANALITICAID'
        Width = 37
        Position.ColIndex = 3
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
      object cxDBTreeList1PARENTID: TcxDBTreeListColumn
        Visible = False
        DataBinding.FieldName = 'PARENTID'
        Width = 100
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
      object cxDBTreeList1TITLE: TcxDBTreeListColumn
        Caption.Text = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        Width = 234
        Position.ColIndex = 1
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
      object cxDBTreeList1PATH: TcxDBTreeListColumn
        Visible = False
        DataBinding.FieldName = 'PATH'
        Width = 100
        Position.ColIndex = 2
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 273
      Top = 30
      Width = 8
      Height = 453
    end
  end
  object btnOk: TcxButton
    AlignWithMargins = True
    Left = 891
    Top = 592
    Width = 90
    Height = 29
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 16
    Margins.Bottom = 12
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 3
  end
  object lbPath: TcxLabel
    Left = 8
    Top = 71
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Style.BorderStyle = ebsOffice11
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = True
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = True
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.NativeStyle = True
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.NativeStyle = True
    Properties.LineOptions.Alignment = cxllaTop
    Properties.ShowEndEllipsis = True
    Height = 19
    Width = 977
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
      Caption = 'Adauga'
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
      Caption = 'Analitica noua'
      Category = 0
      Hint = 'Analitica noua'
      Visible = ivAlways
      ShortCut = 45
      OnClick = bbNewAnalyticsItemClick
    end
    object bbNewAnalyticsFolder: TdxBarButton
      Caption = 'Grupa noua'
      Category = 0
      Hint = 'Grupa noua'
      Visible = ivAlways
      ShortCut = 16429
      OnClick = bbNewAnalyticsFolderClick
    end
    object bbModifyAnalytics: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyAnalyticsClick
    end
    object bbDeleteAnalytics: TdxBarButton
      Caption = 'Elimina'
      Category = 0
      Hint = 'Elimina'
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
      'flg_folder=0'
      'ORDER BY'
      ' FLG_FOLDER DESC, TITLE')
    MasterFields = 'ANALITICAID'
    DetailFields = 'PARENTID'
    MasterSource = IBCDataSourceAnalyticFolders
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 452
    Top = 272
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ANALITICAID'
        ParamType = ptInput
        Value = 109
      end>
  end
  object IBCDataSourceAnalytics: TIBCDataSource
    DataSet = IBCQueryAnalytics
    Left = 452
    Top = 212
  end
  object IBCQueryAnalyticFolders: TIBCQuery
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
      ' vw_TS_ANALYTICS'
      'WHERE '
      ' flg_folder=1'
      'ORDER BY'
      ' FLG_FOLDER DESC, TITLE')
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 140
    Top = 279
  end
  object IBCDataSourceAnalyticFolders: TIBCDataSource
    DataSet = IBCQueryAnalyticFolders
    Left = 140
    Top = 220
  end
end
