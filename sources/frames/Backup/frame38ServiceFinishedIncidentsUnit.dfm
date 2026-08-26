inherited frame38ServiceFinishedIncidents: Tframe38ServiceFinishedIncidents
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
  object pnClient: TPanel
    Left = 0
    Top = 30
    Width = 451
    Height = 6
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object cxGridIncidents: TcxGrid
      Left = 0
      Top = 0
      Width = 451
      Height = 6
      Align = alClient
      TabOrder = 0
      object cxGridIncidentsDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnFocusedRecordChanged = cxGridIncidentsDBTableViewFocusedRecordChanged
        DataController.DataSource = IBCDataSourceIncidents
        DataController.KeyFieldNames = 'IID;CALLID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
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
        object cxGridIncidentsDB_IID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'IID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridIncidentsDB_DATA: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridIncidentsDB_FLG_CLIENT_INFORMED: TcxGridDBColumn
          AlternateCaption = #1050#1083#1080#1077#1085#1090' '#1080#1085#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085
          DataBinding.FieldName = 'FLG_CLIENT_INFORMED'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 10
              Value = 1
            end>
          MinWidth = 26
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 26
          IsCaptionAssigned = True
        end
        object cxGridIncidentsDB_CUSTOMER_FULLNAME: TcxGridDBColumn
          Caption = #1050#1083#1080#1077#1085#1090
          DataBinding.FieldName = 'CUSTOMER_FULLNAME'
          Width = 160
        end
        object cxGridIncidentsDB_TYPE_NAME: TcxGridDBColumn
          Caption = #1048#1085#1094#1080#1076#1077#1085#1090
          DataBinding.FieldName = 'TYPE_TITLE'
          Width = 160
        end
        object cxGridIncidentsDB_STATUS_TITLE: TcxGridDBColumn
          Caption = #1057#1090#1072#1090#1091#1089
          DataBinding.FieldName = 'STATUS_TITLE'
          MinWidth = 160
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 160
        end
        object cxGridIncidentsDB_SN: TcxGridDBColumn
          Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
          DataBinding.FieldName = 'SN'
          MinWidth = 110
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 110
        end
        object cxGridIncidentsDB_GOODS_NAME: TcxGridDBColumn
          Caption = #1058#1086#1074#1072#1088
          DataBinding.FieldName = 'GOODS_NAME'
          Options.Filtering = False
          Width = 200
        end
      end
      object cxGridIncidentsLevel: TcxGridLevel
        GridView = cxGridIncidentsDBTableView
      end
    end
  end
  object pnBottom: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 37
    Width = 451
    Height = 268
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object dxBarDockControl2: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 451
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridCalls: TcxGrid
      Left = 0
      Top = 30
      Width = 451
      Height = 238
      Align = alClient
      TabOrder = 1
      object cxGridCallsDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnFocusedRecordChanged = cxGridCallsDBTableViewFocusedRecordChanged
        DataController.DataSource = IBCDataSourceCalls
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
        object cxGridCallsDB_PICKUP_DATE: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1087#1088#1080#1093#1086#1076#1072' '#1079#1072' '#1090#1086#1074#1072#1088#1086#1084
          DataBinding.FieldName = 'PICKUP_DATE'
          MinWidth = 160
          Options.HorzSizing = False
          Width = 160
        end
        object cxGridCallsDB_USER_FULLNAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'USER_FULLNAME'
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
      end
      object cxGridCallsLevel: TcxGridLevel
        GridView = cxGridCallsDBTableView
      end
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 732
    Top = 124
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
      Caption = 'Incident'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1027
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCloseIncident'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRestartIncident'
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
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1027
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewCall'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyCall'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveCall'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbCloseIncident: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090
      Category = 0
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090
      Visible = ivAlways
      ImageIndex = 43
      OnClick = bbCloseIncidentClick
    end
    object bbNewCall: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1079#1074#1086#1085#1086#1082
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1079#1074#1086#1085#1086#1082
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewCallClick
    end
    object bbModifyCall: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyCallClick
    end
    object bbRemoveCall: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbRemoveCallClick
    end
    object bbRestartIncident: TdxBarButton
      Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090
      Category = 0
      Hint = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbRestartIncidentClick
    end
  end
  object IBCQueryIncidents: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_SC_INCIDENTE.*,'
      
        ' IIF(EXISTS(SELECT CALLID FROM TDB_SC_INCIDENT_CALLS WHERE (TDB_' +
        'SC_INCIDENT_CALLS.IID=VW_TDB_SC_INCIDENTE.IID) AND (TDB_SC_INCID' +
        'ENT_CALLS.CALL_RESULT=6410)),1,0) FLG_CLIENT_INFORMED,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE (TS_CUSTOMER.CuSTOME' +
        'RID=VW_TDB_SC_INCIDENTE.CUSTOMERID)) CUSTOMER_FULLNAME'
      'FROM'
      ' VW_TDB_SC_INCIDENTE'
      'WHERE'
      ' (FLG_INCIDENT_SOLVED=1) and (FLG_INCIDENT_CLOSED=0)'
      'ORDER BY'
      ' DATA_FINISHED DESC')
    RefreshOptions = [roAfterUpdate]
    Constraints = <>
    Left = 204
    Top = 120
  end
  object IBCDataSourceIncidents: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryIncidents
    Left = 68
    Top = 120
  end
  object IBCQueryCalls: TIBCQuery
    KeyFields = 'CALLID'
    KeyGenerator = 'SQ_TDB_SC_INCIDENT_CALLS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_SC_INCIDENT_CALLS'
      
        '  (IID, CALLID, PHONE, CALL_TIME, PICKUP_DATE, COMMENTS, USERID,' +
        ' CALL_RESULT)'
      'VALUES'
      
        '  (:IID, :CALLID, :PHONE, :CALL_TIME, :PICKUP_DATE, :COMMENTS, :' +
        'USERID, :CALL_RESULT)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_SC_INCIDENT_CALLS'
      'WHERE'
      '  CALLID = :Old_CALLID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_SC_INCIDENT_CALLS'
      'SET'
      ' IID = :IID, '
      ' CALLID = :CALLID, '
      ' PHONE = :PHONE, '
      ' CALL_TIME = :CALL_TIME, '
      ' PICKUP_DATE = :PICKUP_DATE, '
      ' COMMENTS = :COMMENTS, '
      ' USERID = :USERID, '
      ' CALL_RESULT = :CALL_RESULT'
      'WHERE'
      ' CALLID = :Old_CALLID')
    SQLRefresh.Strings = (
      'SELECT '
      ' *'
      'FROM '
      ' VW_TDB_SC_INCIDENT_CALLS'
      'WHERE'
      ' CALLID = :CALLID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_SC_INCIDENT_CALLS'
      'WHERE'
      'CALLID = :Old_CALLID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_SC_INCIDENT_CALLS')
    MasterFields = 'IID'
    DetailFields = 'IID'
    MasterSource = IBCDataSourceIncidents
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Constraints = <>
    Left = 212
    Top = 496
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
        Value = nil
      end>
  end
  object IBCDataSourceCalls: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryCalls
    Left = 76
    Top = 496
  end
end
