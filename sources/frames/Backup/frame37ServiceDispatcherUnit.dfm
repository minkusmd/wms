inherited frame37ServiceDispatcher: Tframe37ServiceDispatcher
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 0
    Top = 59
    Width = 451
    Height = 246
    Margins.Left = 0
    Margins.Top = 4
    Margins.Right = 0
    Margins.Bottom = 0
    ActivePage = TabSheet5
    Align = alBottom
    TabOrder = 0
    object TabSheet5: TTabSheet
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1080#1085#1094#1080#1076#1077#1085#1090#1077
      ImageIndex = 4
    end
    object TabSheet2: TTabSheet
      Caption = #1056#1072#1089#1093#1086#1076#1099' '#1087#1086' '#1080#1085#1094#1080#1076#1077#1085#1090#1091
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet4: TTabSheet
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1083#1080#1077#1085#1090#1077
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object cxGridTasks: TcxGrid
    Left = 0
    Top = 30
    Width = 201
    Height = 25
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridTasksDBTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenuTask
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      OnFocusedRecordChanged = cxGridTasksDBTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourceTasks
      DataController.KeyFieldNames = 'TASKID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnSorting = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.GroupRowStyle = grsOffice11
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridTasksDB_IID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1080#1085#1094'.'
        DataBinding.FieldName = 'IID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridTasksDBTableColumn1: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1079#1072#1076#1072#1095#1080
        DataBinding.FieldName = 'TASKID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridTasksDB_TYPE_TITLE_1: TcxGridDBColumn
        Caption = #1048#1085#1094#1080#1076#1077#1085#1090
        DataBinding.FieldName = 'I_TYPE_TITLE'
        MinWidth = 140
        Options.HorzSizing = False
        Width = 140
      end
      object cxGridTasksDB_DATA_ASSIGN: TcxGridDBColumn
        Caption = #1053#1072#1095#1072#1083#1086
        DataBinding.FieldName = 'DATA_ASSIGN'
        MinWidth = 110
        Options.Filtering = False
        Options.HorzSizing = False
        Width = 110
      end
      object cxGridTasksDB_ASSIGNED_USER_NAME: TcxGridDBColumn
        Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
        DataBinding.FieldName = 'ASSIGNED_USER_NAME'
        MinWidth = 140
        Options.HorzSizing = False
        Width = 140
      end
      object cxGridTasksDB_TYPE_TITLE: TcxGridDBColumn
        Caption = #1047#1072#1076#1072#1095#1072
        DataBinding.FieldName = 'TYPE_TITLE'
        MinWidth = 100
        Width = 200
      end
      object cxGridTasksDB_STATUS_TITLE: TcxGridDBColumn
        Caption = #1057#1090#1072#1090#1091#1089
        DataBinding.FieldName = 'STATUS_TITLE'
        MinWidth = 120
        Options.HorzSizing = False
        Width = 120
      end
      object cxGridTasksDB_PRIORITY: TcxGridDBColumn
        Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
        DataBinding.FieldName = 'I_PRIORITY'
        Visible = False
        MinWidth = 64
        Options.HorzSizing = False
      end
      object cxGridTasksDB_DATA_ESTIMATED_FINISH: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
        DataBinding.FieldName = 'I_DATA_ESTIMATED_FINISH'
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridTasksDB_STATUS_ID: TcxGridDBColumn
        DataBinding.FieldName = 'STATUS_ID'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridTasksLevel: TcxGridLevel
      GridView = cxGridTasksDBTable
    end
  end
  object dxBarDockControl1: TdxBarDockControl
    Left = 0
    Top = 0
    Width = 451
    Height = 30
    Align = dalTop
    BarManager = dxBarManager
    SunkenBorder = True
    UseOwnSunkenBorder = True
  end
  object pnTaskFilters: TPanel
    AlignWithMargins = True
    Left = 203
    Top = 30
    Width = 248
    Height = 25
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alRight
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 7
    object Label3: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 236
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 12
      Align = alTop
      Alignment = taCenter
      Caption = #1054#1087#1094#1080#1080' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1079#1072#1076#1072#1095
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 139
    end
    object sbPreset_AllTasks: TSpeedButton
      Left = 12
      Top = 46
      Width = 142
      Height = 25
      GroupIndex = 1
      Caption = #1042#1089#1077' '#1079#1072#1076#1072#1095#1080
      OnClick = sbPreset_AllTasksClick
    end
    object Label7: TLabel
      Left = 12
      Top = 71
      Width = 224
      Height = 30
      AutoSize = False
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1079#1072#1076#1072#1095#1080' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1080#1085#1094#1080#1076#1077#1085#1090#1086#1074'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object sbPreset_NewGoods: TSpeedButton
      Left = 12
      Top = 122
      Width = 142
      Height = 25
      GroupIndex = 1
      Down = True
      Caption = #1053#1086#1074#1099#1077' '#1090#1086#1074#1072#1088#1099
      OnClick = sbPreset_NewGoodsClick
    end
    object sbPreset_CurrentTasks: TSpeedButton
      Left = 12
      Top = 278
      Width = 142
      Height = 25
      GroupIndex = 1
      Caption = #1058#1077#1082#1091#1097#1080#1077' '#1079#1072#1076#1072#1095#1080
      OnClick = sbPreset_CurrentTasksClick
    end
    object sbPreset_CriticalTasks: TSpeedButton
      Left = 12
      Top = 362
      Width = 142
      Height = 25
      GroupIndex = 1
      Caption = #1050#1088#1080#1090#1080#1095#1077#1089#1082#1080#1077' '#1079#1072#1076#1072#1095#1080
      OnClick = sbPreset_CriticalTasksClick
    end
    object Label4: TLabel
      Left = 12
      Top = 147
      Width = 224
      Height = 30
      AutoSize = False
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1085#1099#1077' '#1090#1086#1074#1072#1088#1099'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label5: TLabel
      Left = 12
      Top = 305
      Width = 224
      Height = 30
      AutoSize = False
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1090#1077#1082#1091#1097#1080#1077' '#1079#1072#1076#1072#1095#1080'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label6: TLabel
      Left = 12
      Top = 387
      Width = 224
      Height = 30
      AutoSize = False
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1082#1088#1080#1090#1080#1095#1077#1089#1082#1080#1077' '#1079#1072#1076#1072#1095#1080'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object sbPreset_NewAssignment: TSpeedButton
      Left = 12
      Top = 202
      Width = 142
      Height = 25
      GroupIndex = 1
      Caption = #1053#1086#1074#1099#1077' '#1079#1072#1076#1072#1095#1080
      OnClick = sbPreset_NewAssignmentClick
    end
    object Label1: TLabel
      Left = 12
      Top = 229
      Width = 224
      Height = 30
      AutoSize = False
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1086#1074#1099#1077' '#1079#1072#1076#1072#1095#1080' '#1076#1083#1103' '#1080#1089#1087#1086#1083#1085#1077#1085#1080#1103'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object IBCDataSourceTasks: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryTasks
    Left = 76
    Top = 92
  end
  object IBCQueryTasks: TIBCQuery
    KeyFields = 'TASKID'
    KeyGenerator = 'SQ_TDB_SC_TASKS_ID'
    GeneratorMode = gmInsert
    SQLRefresh.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_SC_TASKS_INCIDENTE'
      'WHERE'
      ' (IID = :IID) AND (TASKID = :TASKID)')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_SC_TASKS'
      'WHERE'
      'TASKID = :Old_TASKID AND IID = :Old_IID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_SC_TASKS.*,'
      ' VW_TDB_SC_INCIDENTE.TYPE_TITLE I_TYPE_TITLE,'
      ' VW_TDB_SC_INCIDENTE.GOODS_MODEL I_GOODS_MODEL,'
      ' VW_TDB_SC_INCIDENTE.SN I_SN,'
      
        ' VW_TDB_SC_INCIDENTE.DATA_ESTIMATED_FINISH I_DATA_ESTIMATED_FINI' +
        'SH,'
      ' VW_TDB_SC_INCIDENTE.PRIORITY I_PRIORITY,'
      ' VW_TDB_SC_INCIDENTE.STATUS_ID I_STATUS_ID'
      'FROM'
      ' VW_TDB_SC_TASKS'
      
        ' INNER JOIN VW_TDB_SC_INCIDENTE ON (VW_TDB_SC_INCIDENTE.IID=VW_T' +
        'DB_SC_TASKS.IID and VW_TDB_SC_INCIDENTE.FLG_INCIDENT_SOLVED=0 an' +
        'd VW_TDB_SC_INCIDENTE.FLG_INCIDENT_CLOSED=0)'
      'ORDER BY'
      ' VW_TDB_SC_INCIDENTE.DATA_ESTIMATED_FINISH DESC,'
      ' VW_TDB_SC_INCIDENTE.PRIORITY DESC,'
      ' VW_TDB_SC_TASKS.TASKID,'
      ' VW_TDB_SC_TASKS.STATUS_ID')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Constraints = <>
    Left = 204
    Top = 92
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 452
    Top = 60
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
      Caption = #1047#1072#1076#1072#1095#1080
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1123
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEndTask'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton6'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRefresh'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbEndTask: TdxBarButton
      Caption = #1047#1072#1074#1077#1088#1096#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
      Category = 0
      Hint = #1047#1072#1074#1077#1088#1096#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
      Visible = ivAlways
      ImageIndex = 43
      OnClick = bbEndTaskClick
    end
    object dxBarButton6: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1090#1072#1090#1091#1089
      Category = 0
      Enabled = False
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1090#1072#1090#1091#1089
      Visible = ivAlways
      ImageIndex = 41
    end
    object bbRefresh: TdxBarButton
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Category = 0
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 36
      ShortCut = 116
      OnClick = bbRefreshClick
    end
    object bbGotoClientServiceCard: TdxBarButton
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1057#1077#1088#1074#1080#1089#1085#1086#1081' '#1082#1072#1088#1090#1099' '#1082#1083#1080#1077#1085#1090#1072
      Category = 0
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1057#1077#1088#1074#1080#1089#1085#1086#1081' '#1082#1072#1088#1090#1099' '#1082#1083#1080#1077#1085#1090#1072
      Visible = ivAlways
      ImageIndex = 10
      OnClick = bbGotoClientServiceCardClick
    end
  end
  object dxBarPopupMenuTask: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGotoClientServiceCard'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuTaskPopup
    Left = 344
    Top = 100
  end
end
