object frmSalaryInfoDlg: TfrmSalaryInfoDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1079#1072#1088#1087#1083#1072#1090#1077
  ClientHeight = 649
  ClientWidth = 659
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 600
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
    Width = 659
    Height = 64
    Title = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1079#1072#1088#1087#1083#1072#1090#1077
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
    ImageIndex = 28
  end
  object pnButtons: TPanel
    Left = 0
    Top = 599
    Width = 659
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 5
    Padding.Right = 24
    Padding.Bottom = 16
    ShowCaption = False
    TabOrder = 6
    object btnCancel: TcxButton
      Left = 545
      Top = 5
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 0
    end
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 643
    Height = 519
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnClient'
    TabOrder = 4
    object pnNavigator: TPanel
      Left = 0
      Top = 0
      Width = 173
      Height = 519
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 173
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridNav: TcxGrid
        Left = 0
        Top = 30
        Width = 173
        Height = 489
        Align = alClient
        TabOrder = 1
        object cxGridNavTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnFocusedRecordChanged = cxGridNavTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceNav
          DataController.KeyFieldNames = 'DATA_YEAR;DATA_MONTH'
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
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.GroupRowStyle = grsOffice11
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridNav_DATA_YEAR: TcxGridDBColumn
            DataBinding.FieldName = 'DATA_YEAR'
            Visible = False
            GroupIndex = 0
            SortIndex = 0
            SortOrder = soDescending
            IsCaptionAssigned = True
          end
          object cxGridNav_DATA_MONTH: TcxGridDBColumn
            Caption = #1052#1077#1089#1103#1094
            DataBinding.FieldName = 'DATA_MONTH'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            OnGetDisplayText = cxGridNav_DATA_MONTHGetDisplayText
            SortIndex = 1
            SortOrder = soDescending
          end
        end
        object cxGridNavLevel: TcxGridLevel
          GridView = cxGridNavTable
        end
      end
    end
    object pnCustomers: TPanel
      AlignWithMargins = True
      Left = 175
      Top = 0
      Width = 468
      Height = 519
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object cxGrid: TcxGrid
        AlignWithMargins = True
        Left = 2
        Top = 30
        Width = 466
        Height = 489
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        TabOrder = 0
        object cxGridTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.PriorPage.Visible = True
          Navigator.Buttons.NextPage.Visible = True
          Navigator.Buttons.Append.Visible = True
          Navigator.Buttons.SaveBookmark.Visible = False
          Navigator.Buttons.GotoBookmark.Visible = False
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridTableCellDblClick
          OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceSalary
          DataController.KeyFieldNames = 'CUSTOMERID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGrid_CUSTOMER_NAME
            end>
          DataController.Summary.SummaryGroups = <>
          NewItemRow.InfoText = #1053#1072#1078#1084#1080#1090#1077' '#1089#1102#1076#1072' '#1076#1083#1103' '#1085#1086#1074#1086#1081' '#1079#1072#1087#1080#1089#1080
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.IncSearch = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsBehavior.ImmediateEditor = False
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
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGrid_CUSTOMERID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'CUSTOMERID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGrid_CUSTOMER_NAME: TcxGridDBColumn
            Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
            DataBinding.FieldName = 'CUSTOMER_NAME'
            SortIndex = 0
            SortOrder = soAscending
            Width = 168
          end
          object cxGrid_DATA: TcxGridDBColumn
            Caption = #1044#1072#1090#1072
            DataBinding.FieldName = 'DATA'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.DateButtons = [btnClear, btnNow, btnToday]
            Properties.SaveTime = False
            Properties.ShowTime = False
            Properties.WeekNumbers = True
            Visible = False
            MinWidth = 100
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 100
          end
          object cxGrid_BASE_SALARY: TcxGridDBColumn
            Caption = #1057#1090#1072#1074#1082#1072
            DataBinding.FieldName = 'BASE_SALARY'
            PropertiesClassName = 'TcxCalcEditProperties'
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGrid_QTY_WORK_HOURS: TcxGridDBColumn
            Caption = #1056#1072#1073#1086#1095#1080#1077' '#1095#1072#1089#1099
            DataBinding.FieldName = 'QTY_WORK_HOURS'
            PropertiesClassName = 'TcxCalcEditProperties'
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridTable_K_GRAD: TcxGridDBColumn
            Caption = 'K'
            DataBinding.FieldName = 'K_GRAD'
            HeaderAlignmentHorz = taCenter
            Width = 44
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridTable
        end
      end
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 468
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
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
    Left = 396
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
      FloatLeft = 671
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCopyMonthData'
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
      FloatLeft = 643
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
    object bbCopyMonthData: TdxBarButton
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 29
      OnClick = bbCopyMonthDataClick
    end
    object bbNew: TdxBarButton
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Hint = #1053#1086#1074#1099#1081
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 113
      OnClick = bbEditClick
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
  end
  object IBCQuerySalary: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_EMP_SALARY_INFO'
      '  (CUSTOMERID, DATA, BASE_SALARY, QTY_WORK_HOURS, K_GRAD)'
      'VALUES'
      '  (:CUSTOMERID, :DATA, :BASE_SALARY, :QTY_WORK_HOURS, :K_GRAD)')
    SQLDelete.Strings = (
      'DELETE FROM TS_EMP_SALARY_INFO'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND DATA = :Old_DATA')
    SQLUpdate.Strings = (
      'UPDATE TS_EMP_SALARY_INFO'
      'SET'
      
        '  CUSTOMERID = :CUSTOMERID, DATA = :DATA, BASE_SALARY = :BASE_SA' +
        'LARY, QTY_WORK_HOURS = :QTY_WORK_HOURS, '
      'K_GRAD = :K_GRAD'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND DATA = :Old_DATA')
    SQLRefresh.Strings = (
      
        'SELECT CUSTOMERID, DATA, BASE_SALARY, QTY_WORK_HOURS, DATA_YEAR,' +
        ' DATA_MONTH, K_GRAD '
      'FROM VW_TS_EMP_SALARY_INFO'
      'WHERE'
      '  CUSTOMERID = :CUSTOMERID AND DATA = :DATA')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_EMP_SALARY_INFO'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID AND DATA = :Old_DATA'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' CUSTOMERID, '
      ' DATA, '
      ' BASE_SALARY, '
      ' QTY_WORK_HOURS,'
      ' DATA_YEAR, '
      ' DATA_MONTH,'
      ' CUSTOMER_NAME,'
      ' K_GRAD'
      'FROM VW_TS_EMP_SALARY_INFO'
      'ORDER BY CUSTOMER_NAME')
    MasterFields = 'DATA_YEAR;DATA_MONTH'
    DetailFields = 'DATA_YEAR;DATA_MONTH'
    MasterSource = IBCDataSourceNav
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 500
    LocalConstraints = False
    Left = 324
    Top = 196
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA_YEAR'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA_MONTH'
        Value = nil
      end>
  end
  object IBCDataSourceSalary: TIBCDataSource
    DataSet = IBCQuerySalary
    Left = 324
    Top = 248
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 324
    Top = 140
  end
  object IBCQueryNav: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT DISTINCT'
      
        ' EXTRACT(YEAR FROM DATA) DATA_YEAR, EXTRACT(MONTH FROM DATA) DAT' +
        'A_MONTH'
      'FROM TS_EMP_SALARY_INFO'
      'ORDER BY 1 DESC, 2 DESC')
    ReadOnly = True
    Left = 88
    Top = 220
  end
  object IBCDataSourceNav: TIBCDataSource
    DataSet = IBCQueryNav
    Left = 88
    Top = 268
  end
end
