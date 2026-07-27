object winChatWindow: TwinChatWindow
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1063#1072#1090
  ClientHeight = 482
  ClientWidth = 524
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Roboto'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cxDBTreeListChat: TcxDBTreeList
    AlignWithMargins = True
    Left = 2
    Top = 2
    Width = 374
    Height = 438
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 0
    Margins.Bottom = 2
    Align = alClient
    Bands = <
      item
      end>
    DataController.DataSource = IBCDataSourceChatMSG
    DataController.ParentField = 'PARENTID'
    DataController.KeyField = 'MESSAGEID'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Roboto Mono'
    Font.Style = []
    Navigator.Buttons.CustomButtons = <>
    OptionsBehavior.ChangeDelay = 1000
    OptionsBehavior.CopyCaptionsToClipboard = False
    OptionsData.Editing = False
    OptionsSelection.CellSelect = False
    OptionsSelection.HideSelection = True
    OptionsSelection.InvertSelect = False
    OptionsView.CellAutoHeight = True
    OptionsView.ScrollBars = ssVertical
    OptionsView.Buttons = False
    OptionsView.ColumnAutoWidth = True
    OptionsView.GridLineColor = 13750737
    OptionsView.Headers = False
    OptionsView.TreeLineColor = 13750737
    ParentFont = False
    RootValue = 0
    ScrollbarAnnotations.CustomAnnotations = <>
    Styles.Selection = dmAdditions.cxStyle_ChatSelection
    Styles.OnGetContentStyle = cxDBTreeListChatStylesGetContentStyle
    TabOrder = 2
    TabStop = False
    OnDblClick = cxDBTreeListChatDblClick
    OnEnter = cxDBTreeListChatEnter
    OnKeyUp = cxDBTreeListChatKeyUp
    ExplicitWidth = 293
    ExplicitHeight = 423
    object cxDBTreeListChat_TEXT: TcxDBTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.WordWrap = True
      Styles.Content = dmAdditions.cxStyle_ChatText
      DataBinding.FieldName = 'TEXT'
      Width = 100
      Position.ColIndex = 0
      Position.RowIndex = 1
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxDBTreeListChat_AUTHOR_TIME_NAME: TcxDBTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Styles.Content = dmAdditions.cxStyle_ChatUser
      Visible = False
      DataBinding.FieldName = 'AUTHOR_TIME_NAME'
      Width = 100
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxDBTreeListChat_CREATED: TcxDBTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Styles.Content = dmAdditions.cxStyle_ChatUser
      DataBinding.FieldName = 'CREATED'
      Options.Sizing = False
      Width = 100
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxDBTreeListChat_CREATEDGetDisplayText
    end
    object cxDBTreeListChat_FLG_UNREAD: TcxDBTreeListColumn
      Visible = False
      DataBinding.FieldName = 'FLG_UNREAD'
      Width = 100
      Position.ColIndex = 3
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxDBTreeListChat_AUTHORID: TcxDBTreeListColumn
      Visible = False
      DataBinding.FieldName = 'AUTHORID'
      Width = 100
      Position.ColIndex = 4
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxDBTreeListChat_MESSAGEID: TcxDBTreeListColumn
      Visible = False
      DataBinding.FieldName = 'MESSAGEID'
      Width = 100
      Position.ColIndex = 5
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxDBTreeListChat_AUTHOR_NAME: TcxDBTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Styles.Content = dmAdditions.cxStyle_ChatUser
      DataBinding.FieldName = 'AUTHOR_NAME'
      Width = 100
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 442
    Width = 524
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 3
    object lbChatPrivatePerson: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 19
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Caption = #1076#1083#1103
      Layout = tlCenter
      Visible = False
    end
    object mmChatMessage: TcxMemo
      AlignWithMargins = True
      Left = 25
      Top = 2
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 0
      TabStop = False
      Align = alClient
      ParentFont = False
      Properties.ScrollBars = ssVertical
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'Roboto Mono'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      OnKeyUp = mmChatMessageKeyUp
      Height = 36
      Width = 420
    end
    object btnChatSendMsg: TcxButton
      Left = 447
      Top = 2
      Width = 75
      Height = 36
      Align = alRight
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
      LookAndFeel.NativeStyle = True
      TabOrder = 1
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      OnClick = btnChatSendMsgClick
      ExplicitLeft = 366
    end
  end
  object cxSplitterChat: TcxSplitter
    Left = 376
    Top = 0
    Width = 8
    Height = 442
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salRight
    MinSize = 140
    Control = pnChatRight
    ExplicitLeft = 295
    ExplicitHeight = 427
  end
  object pnChatRight: TPanel
    Left = 384
    Top = 0
    Width = 140
    Height = 442
    Align = alRight
    BevelOuter = bvNone
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 1
    ExplicitLeft = 303
    ExplicitHeight = 427
    object cxGridChatGroups: TcxGrid
      Left = 0
      Top = 2
      Width = 138
      Height = 407
      Margins.Left = 0
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Roboto Mono'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = False
      ExplicitHeight = 392
      object cxGridChatGroupsTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellClick = cxGridChatGroupsTableCellClick
        OnFocusedRecordChanged = cxGridChatGroupsTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceRooms
        DataController.KeyFieldNames = 'ROOMID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1082#1086#1084#1085#1072#1090' '#1076#1083#1103' '#1095#1072#1090#1072'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.DataRowHeight = 32
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        Styles.OnGetContentStyle = cxGridChatGroupsTableStylesGetContentStyle
        Styles.Inactive = dmAdditions.cxStyle_ChatGroupInactive
        Styles.Selection = dmAdditions.cxStyle_ChatGroupSelected
        object cxGridChatGroups_ROOMID: TcxGridDBColumn
          DataBinding.FieldName = 'ROOMID'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridChatGroups_IMG: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_PRIVATE'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 15
              Value = 0
            end
            item
              ImageIndex = 10
              Value = 1
            end>
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridChatGroups_COMPOSITE_TITLE: TcxGridDBColumn
          DataBinding.FieldName = 'COMPOSITE_TITLE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          SortIndex = 2
          SortOrder = soAscending
        end
        object cxGridChatGroups_NEW_MSG_COUNT: TcxGridDBColumn
          DataBinding.FieldName = 'NEW_MSG_COUNT'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridChatGroups_FLG_PRIVATE: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_PRIVATE'
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
        end
        object cxGridChatGroups_CREATED_BY: TcxGridDBColumn
          DataBinding.FieldName = 'CREATED_BY'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridChatGroups_DESCRIPTION: TcxGridDBColumn
          DataBinding.FieldName = 'DESCRIPTION'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridChatGroups_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          Visible = False
          SortIndex = 1
          SortOrder = soAscending
          VisibleForCustomization = False
        end
      end
      object cxGridChatGroupsLevel: TcxGridLevel
        GridView = cxGridChatGroupsTable
      end
    end
    object pnCharRightBottom: TPanel
      Left = 0
      Top = 409
      Width = 138
      Height = 31
      Align = alBottom
      BevelOuter = bvNone
      Padding.Top = 4
      Padding.Bottom = 4
      TabOrder = 1
      ExplicitTop = 394
      object Label1: TLabel
        Left = 0
        Top = 4
        Width = 60
        Height = 23
        Align = alLeft
        Caption = #1056#1072#1079#1075#1086#1074#1086#1088#1099':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
      object cmbChatPeriod: TComboBox
        AlignWithMargins = True
        Left = 64
        Top = 4
        Width = 74
        Height = 23
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Roboto Mono'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 0
        Text = #1057#1077#1075#1086#1076#1085#1103
        OnChange = cmbChatPeriodChange
        Items.Strings = (
          #1057#1077#1075#1086#1076#1085#1103
          #1047#1072' 7 '#1076#1085#1077#1081
          #1042#1089#1077)
      end
    end
  end
  object cxGridPopupMenuChat: TcxGridPopupMenu
    Grid = cxGridChatGroups
    PopupMenus = <
      item
        GridView = cxGridChatGroupsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuSelected
      end
      item
        GridView = cxGridChatGroupsTable
        HitTypes = [gvhtGridNone, gvhtNone]
        Index = 1
        PopupMenu = dxBarPopupMenuUnselected
      end>
    Left = 69
    Top = 100
  end
  object dxBarManagerChat: TdxBarManager
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
    Left = 68
    Top = 32
    PixelsPerInch = 96
    object bbChat_NewGroup: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091'...'
      Category = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbChat_NewGroupClick
    end
    object bbChat_ModifyGroup: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1086#1089#1090#1072#1074' '#1075#1088#1091#1087#1087#1099'...'
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1086#1089#1090#1072#1074' '#1075#1088#1091#1087#1087#1099
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbChat_ModifyGroupClick
    end
    object bbChat_CloseGroup: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1075#1088#1091#1087#1087#1091'...'
      Category = 0
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1075#1088#1091#1087#1087#1091
      Visible = ivAlways
      ImageIndex = 35
    end
  end
  object IBCSQLChat: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdateChat
    Left = 237
    Top = 36
  end
  object IBCTrUpdateChat: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 237
    Top = 96
  end
  object dxBarPopupMenuUnselected: TdxBarPopupMenu
    BarManager = dxBarManagerChat
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbChat_NewGroup'
      end>
    UseOwnFont = False
    Left = 76
    Top = 164
    PixelsPerInch = 96
  end
  object dxBarPopupMenuSelected: TdxBarPopupMenu
    BarManager = dxBarManagerChat
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbChat_ModifyGroup'
      end
      item
        Visible = True
        ItemName = 'bbChat_CloseGroup'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbChat_NewGroup'
      end>
    UseOwnFont = False
    Left = 80
    Top = 216
    PixelsPerInch = 96
  end
  object IBCQueryChatRooms: TIBCQuery
    KeyFields = 'ROOMID'
    KeyGenerator = 'SQ_TCHAT_ROOMS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TCHAT_ROOMS'
      '  (ROOMID, TITLE, DESCRIPTION, FLG_NO_TITLE, FLG_PRIVATE)'
      'VALUES'
      '  (:ROOMID, :TITLE, :DESCRIPTION, :FLG_NO_TITLE, :FLG_PRIVATE)')
    SQLUpdate.Strings = (
      'UPDATE TCHAT_ROOMS'
      'SET'
      
        '  ROOMID = :ROOMID, TITLE = :TITLE, DESCRIPTION = :DESCRIPTION, ' +
        'FLG_NO_TITLE = :FLG_NO_TITLE, FLG_PRIVATE = :FLG_PRIVATE'
      'WHERE'
      '  ROOMID = :Old_ROOMID')
    SQLRefresh.Strings = (
      
        'SELECT ROOMID, TITLE, FLG_PRIVATE,  NEW_MSG_COUNT, COMPOSITE_TIT' +
        'LE, '
      
        '       LAST_MSG_DATETIME, CREATED_BY, ORDERNO, DESCRIPTION, FLG_' +
        'NO_TITLE'
      'FROM SP_CHAT_GET_GROUPS'
      'WHERE ROOMID=:ROOMID')
    SQLLock.Strings = (
      'SELECT NULL FROM TCHAT_ROOMS'
      'WHERE'
      'ROOMID = :Old_ROOMID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateChat
    SQL.Strings = (
      
        'SELECT ROOMID, TITLE, FLG_PRIVATE,  NEW_MSG_COUNT, COMPOSITE_TIT' +
        'LE, '
      
        '       LAST_MSG_DATETIME,  CREATED_BY, ORDERNO, DESCRIPTION, FLG' +
        '_NO_TITLE'
      'FROM SP_CHAT_GET_GROUPS')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.StrictUpdate = False
    LocalConstraints = False
    Left = 40
    Top = 308
  end
  object IBCDataSourceRooms: TIBCDataSource
    DataSet = IBCQueryChatRooms
    Left = 40
    Top = 360
  end
  object IBCDataSourceChatMSG: TIBCDataSource
    DataSet = IBCQueryChatMSG
    Left = 161
    Top = 360
  end
  object IBCQueryChatMSG: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateChat
    SQL.Strings = (
      
        'SELECT MESSAGEID, PARENTID, ROOMID, AUTHORID, AUTHOR_TIME_NAME, ' +
        'CREATED, TEXT, FLG_UNREAD, AUTHOR_NAME'
      'FROM'
      '('
      'SELECT'
      'MSG.MESSAGEID,'
      'MSG.PARENTID,'
      'MSG.ROOMID,'
      'MSG.AUTHORID,'
      
        '(SELECT U.FULL_NAME || '#39' - '#39' || RESULT FROM DATETIMETOSTR(MSG.CR' +
        'EATED)) AUTHOR_TIME_NAME,'
      'U.FULL_NAME AUTHOR_NAME,'
      'MSG.CREATED,'
      'MSG.TEXT,'
      
        'IIF(CU.FLG_HAS_NEW_MSG=0,0,IIF(MSG.MESSAGEID>=CU.NEW_MESSAGEID,1' +
        ',0)) FLG_UNREAD,'
      'U.FULL_NAME'
      'FROM TCHAT_MESSAGES MSG'
      'INNER JOIN TS_USERS U ON U.USERID = MSG.AUTHORID'
      
        'INNER JOIN TCHAT_USERS CU ON CU.ROOMID = MSG.ROOMID AND CU.USERI' +
        'D=:currUserID'
      'WHERE CAST(MSG.CREATED AS DATE)>=:DATE'
      'ORDER BY MSG.MESSAGEID'
      ')')
    MasterFields = 'ROOMID'
    DetailFields = 'ROOMID'
    MasterSource = IBCDataSourceRooms
    AutoCommit = False
    Options.DetailDelay = 50
    AfterOpen = IBCQueryChatMSGAfterOpen
    Left = 161
    Top = 308
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'currUserID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ROOMID'
        Value = nil
      end>
  end
end
