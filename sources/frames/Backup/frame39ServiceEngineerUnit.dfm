inherited frame39ServiceEngineer: Tframe39ServiceEngineer
  object Panel1: TPanel
    Left = -22
    Top = 0
    Width = 473
    Height = 305
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    Padding.Left = 2
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 2
      Top = 0
      Width = 471
      Height = 305
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1080#1085#1094#1080#1076#1077#1085#1090#1077
        object Label15: TLabel
          Left = 12
          Top = 289
          Width = 102
          Height = 15
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1076#1077#1092#1077#1082#1090#1072
        end
        object Label1: TLabel
          Left = 12
          Top = 413
          Width = 106
          Height = 15
          Caption = #1042#1085#1077#1096#1085#1077#1077' '#1086#1087#1080#1089#1072#1085#1080#1077
        end
        object Label2: TLabel
          Left = 240
          Top = 413
          Width = 80
          Height = 15
          Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1072#1094#1080#1103
        end
        object Label3: TLabel
          Left = 12
          Top = 20
          Width = 82
          Height = 15
          Caption = #1058#1080#1087' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
        end
        object Label4: TLabel
          Left = 12
          Top = 49
          Width = 33
          Height = 15
          Caption = #1058#1086#1074#1072#1088
        end
        object Label5: TLabel
          Left = 12
          Top = 107
          Width = 97
          Height = 15
          Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
        end
        object Label6: TLabel
          Left = 12
          Top = 78
          Width = 43
          Height = 15
          Caption = #1052#1086#1076#1077#1083#1100
        end
        object Label8: TLabel
          Left = 12
          Top = 156
          Width = 68
          Height = 15
          Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1086
        end
        object Label9: TLabel
          Left = 12
          Top = 185
          Width = 88
          Height = 15
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
        end
        object cxDBMemo1: TcxDBMemo
          Left = 12
          Top = 306
          TabStop = False
          DataBinding.DataField = 'DEFECT_DSC'
          DataBinding.DataSource = IBCDataSourceIncident
          ParentFont = False
          Properties.ReadOnly = True
          Properties.ScrollBars = ssVertical
          Properties.VisibleLineCount = 5
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -13
          Style.Font.Name = 'Courier New'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 0
          Width = 437
        end
        object clbFLAGS_COMPLECT: TcxDBCheckListBox
          Left = 242
          Top = 430
          Width = 206
          Height = 184
          TabStop = False
          DataBinding.DataSource = IBCDataSourceIncident
          DataBinding.DataField = 'FLAGS_COMPLECT'
          IntegralHeight = True
          Items = <
            item
              Text = #1055#1086#1083#1085#1099#1081' '#1082#1086#1084#1087#1083#1077#1082#1090
            end
            item
              Text = #1059#1087#1072#1082#1086#1074#1082#1072
            end
            item
              Text = #1056#1091#1082#1086#1074#1086#1076#1089#1090#1074#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
            end
            item
              Text = #1052#1072#1085#1091#1072#1083
            end
            item
              Text = #1050#1086#1084#1087#1072#1082#1090' '#1076#1080#1089#1082' '#1089' '#1076#1088#1072#1081#1074#1077#1088#1072#1084#1080
            end
            item
              Text = #1050#1072#1073#1077#1083#1100' '#1087#1080#1090#1072#1085#1080#1103
            end
            item
              Text = #1050#1072#1073#1077#1083#1100' USB'
            end
            item
              Text = #1050#1072#1073#1077#1083#1080' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
            end
            item
              Text = #1041#1083#1086#1082' '#1087#1080#1090#1072#1085#1080#1103
            end
            item
              Text = #1057#1091#1084#1082#1072
            end
            item
              Text = #1057#1087#1083#1080#1090#1090#1077#1088
            end
            item
              Text = #1053#1072#1091#1096#1085#1080#1082#1080
            end>
          ParentColor = False
          TabOrder = 1
        end
        object cxDBMemo2: TcxDBMemo
          Left = 12
          Top = 430
          TabStop = False
          DataBinding.DataField = 'EXTERNAL_DSC'
          DataBinding.DataSource = IBCDataSourceIncident
          ParentFont = False
          Properties.ReadOnly = True
          Properties.ScrollBars = ssVertical
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -13
          Style.Font.Name = 'Courier New'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 2
          Height = 184
          Width = 213
        end
        object edTYPE_TITLE: TcxDBTextEdit
          Left = 115
          Top = 17
          TabStop = False
          DataBinding.DataField = 'TYPE_TITLE'
          DataBinding.DataSource = IBCDataSourceIncident
          Properties.ReadOnly = True
          TabOrder = 3
          Width = 334
        end
        object edGOODS_NAME: TcxDBTextEdit
          Left = 115
          Top = 46
          TabStop = False
          DataBinding.DataField = 'GOODS_NAME'
          DataBinding.DataSource = IBCDataSourceIncident
          Properties.ReadOnly = True
          TabOrder = 4
          Width = 334
        end
        object edSN: TcxDBTextEdit
          Left = 115
          Top = 104
          TabStop = False
          DataBinding.DataField = 'SN'
          DataBinding.DataSource = IBCDataSourceIncident
          Properties.ReadOnly = True
          TabOrder = 5
          Width = 182
        end
        object edGOODS_MODEL: TcxDBTextEdit
          Left = 115
          Top = 75
          TabStop = False
          DataBinding.DataField = 'GOODS_MODEL'
          DataBinding.DataSource = IBCDataSourceIncident
          Properties.ReadOnly = True
          TabOrder = 6
          Width = 334
        end
        object edDATA: TcxDBTextEdit
          Left = 115
          Top = 153
          TabStop = False
          DataBinding.DataField = 'DATA'
          DataBinding.DataSource = IBCDataSourceIncident
          Properties.ReadOnly = True
          TabOrder = 7
          Width = 166
        end
        object edDATA_FINISHED: TcxDBTextEdit
          Left = 115
          Top = 182
          TabStop = False
          DataBinding.DataField = 'DATA_FINISHED'
          DataBinding.DataSource = IBCDataSourceIncident
          Properties.ReadOnly = True
          TabOrder = 8
          Width = 166
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1083#1080#1077#1085#1090#1077
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 817
    Height = 305
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 1
    object cxGridTasks: TcxGrid
      Left = 0
      Top = 30
      Width = 817
      Height = 395
      Align = alClient
      TabOrder = 0
      object cxGridTasksTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = IBCDataSourceTasks
        DataController.KeyFieldNames = 'TASKID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTasksTable_IID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'IID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTasksTable_I_TYPE_TITLE: TcxGridDBColumn
          Caption = #1048#1085#1094#1080#1076#1077#1085#1090
          DataBinding.FieldName = 'TYPE_TITLE'
          Width = 100
        end
        object cxGridTasksTable_I_DATA: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridTasksTable_I_DATA_ESTIMATED_FINISH: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
      end
      object cxGridTasksLevel: TcxGridLevel
        GridView = cxGridTasksTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 817
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object PageControl2: TPageControl
      AlignWithMargins = True
      Left = 0
      Top = -112
      Width = 817
      Height = 417
      Margins.Left = 0
      Margins.Top = 2
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = TabSheet3
      Align = alBottom
      TabOrder = 2
      object TabSheet3: TTabSheet
        Caption = #1047#1074#1086#1085#1082#1080' '#1082#1083#1080#1077#1085#1090#1091
        object cxGridCalls: TcxGrid
          Left = 0
          Top = 30
          Width = 809
          Height = 357
          Align = alClient
          TabOrder = 0
          object cxGridCallsDBTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.KeyFieldNames = 'IID;CALLID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
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
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridCallsDB_CALL_TIME: TcxGridDBColumn
              Caption = #1042#1088#1077#1084#1103
              DataBinding.FieldName = 'CALL_TIME'
              MinWidth = 110
              Options.HorzSizing = False
              Width = 110
            end
            object cxGridCallsDB_PHONE: TcxGridDBColumn
              Caption = #1058#1077#1083#1077#1092#1086#1085
              DataBinding.FieldName = 'PHONE'
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridCallsDB_CALL_RESULT_TEXT: TcxGridDBColumn
              Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1079#1074#1086#1085#1082#1072
              DataBinding.FieldName = 'CALL_RESULT_TEXT'
              MinWidth = 200
              Options.HorzSizing = False
              Width = 200
            end
            object cxGridCallsDB_COMMENTS: TcxGridDBColumn
              Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080
              DataBinding.FieldName = 'COMMENTS'
            end
          end
          object cxGridCallsLevel: TcxGridLevel
            GridView = cxGridCallsDBTableView
          end
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 809
          Height = 30
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
      end
      object TabSheet4: TTabSheet
        Caption = #1056#1072#1089#1093#1086#1076#1085#1099#1077' '#1085#1072#1082#1083#1072#1076#1085#1099#1077
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
      object TabSheet5: TTabSheet
        Caption = #1060#1086#1090#1086#1075#1088#1072#1092#1080#1080
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 300
    Top = 72
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
      FloatLeft = 1111
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
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
      Caption = 'PhoneCalls'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1238
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton6'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Visible = ivAlways
      ImageIndex = 17
    end
    object dxBarButton2: TdxBarButton
      Caption = #1043#1072#1088#1072#1085#1090#1080#1103
      Category = 0
      Hint = #1043#1072#1088#1072#1085#1090#1080#1103
      Visible = ivAlways
      ImageIndex = 45
    end
    object dxBarButton3: TdxBarButton
      Caption = #1058#1080#1087' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      Category = 0
      Hint = #1058#1080#1087' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      Visible = ivAlways
      ImageIndex = 45
    end
    object dxBarButton4: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1079#1074#1086#1085#1086#1082
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1079#1074#1086#1085#1086#1082
      Visible = ivAlways
      ImageIndex = 40
    end
    object dxBarButton5: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
    end
    object dxBarButton6: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
    end
  end
  object IBCQueryTasks: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' TDB_SC_TASKS.*,'
      ' VW_TDB_SC_INCIDENTE.TYPE_TITLE,'
      ' VW_TDB_SC_INCIDENTE.GOODS_MODEL,'
      ' VW_TDB_SC_INCIDENTE.SN'
      'FROM'
      ' TDB_SC_TASKS'
      
        ' INNER JOIN VW_TDB_SC_INCIDENTE ON (VW_TDB_SC_INCIDENTE.IID=TDB_' +
        'SC_TASKS.IID AND VW_TDB_SC_INCIDENTE.FLG_INCIDENT_SOLVED=0 AND V' +
        'W_TDB_SC_INCIDENTE.FLG_INCIDENT_CLOSED=0)'
      'WHERE'
      ' (ASSIGNED_USER_ID = :UserID)')
    RefreshOptions = [roAfterUpdate]
    Constraints = <>
    Left = 92
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UserID'
        Value = nil
      end>
  end
  object IBCDataSourceTasks: TIBCDataSource
    DataSet = IBCQueryTasks
    Left = 92
    Top = 84
  end
  object IBCQueryIncident: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_SC_INCIDENTE')
    MasterFields = 'IID'
    DetailFields = 'IID'
    MasterSource = IBCDataSourceTasks
    RefreshOptions = [roAfterUpdate]
    Options.DetailDelay = 500
    Constraints = <>
    Left = 1132
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
        Value = nil
      end>
  end
  object IBCDataSourceIncident: TIBCDataSource
    DataSet = IBCQueryIncident
    Left = 1132
    Top = 196
  end
end
