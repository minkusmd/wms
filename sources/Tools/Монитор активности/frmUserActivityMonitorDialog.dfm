object frmUserActivityMonitorDlg: TfrmUserActivityMonitorDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1052#1086#1085#1080#1090#1086#1088' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1080
  ClientHeight = 671
  ClientWidth = 1062
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1062
    Height = 64
    Title = #1052#1086#1085#1080#1090#1086#1088' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1080
    Text = #1055#1088#1086#1089#1084#1086#1090#1088' '#1079#1072#1087#1080#1089#1077#1081' '#1089' '#1082#1072#1084#1077#1088' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1081
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
    ImageIndex = 2
  end
  object dxBarDockControl2: TdxBarDockControl
    Left = 0
    Top = 64
    Width = 1062
    Height = 30
    Align = dalTop
    BarManager = dxBarManager1
    SunkenBorder = True
    UseOwnSunkenBorder = True
  end
  object cxGridTree: TcxGrid
    AlignWithMargins = True
    Left = 0
    Top = 94
    Width = 273
    Height = 577
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 0
    Align = alLeft
    TabOrder = 2
    object cxGridTreeTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceTree
      DataController.KeyFieldNames = 'USERID;computerid'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnsQuickCustomization = True
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
      OptionsView.GroupRowStyle = grsOffice11
      OptionsView.Indicator = True
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridTree_IMG: TcxGridDBColumn
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.DefaultImageIndex = 10
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.Items = <>
        MinWidth = 24
        Options.Filtering = False
        Options.HorzSizing = False
        Options.Sorting = False
        VisibleForCustomization = False
        Width = 24
      end
      object cxGridTree_USER_NAME: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'USER_NAME'
        MinWidth = 50
        SortIndex = 0
        SortOrder = soAscending
        VisibleForCustomization = False
        Width = 100
      end
      object cxGridTree_COMPUTER_NAME: TcxGridDBColumn
        Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
        DataBinding.FieldName = 'COMPUTER_NAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        SortIndex = 1
        SortOrder = soAscending
        Width = 100
      end
    end
    object cxGridTreeLevel1: TcxGridLevel
      GridView = cxGridTreeTable
    end
  end
  object cxGridTimes: TcxGrid
    AlignWithMargins = True
    Left = 275
    Top = 94
    Width = 102
    Height = 577
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 0
    Align = alLeft
    TabOrder = 4
    object cxGridTimesTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu1
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceTime
      DataController.KeyFieldNames = 'ID'
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
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridTimes_CREATED: TcxGridDBColumn
        Caption = #1042#1088#1077#1084#1103
        DataBinding.FieldName = 'CREATED'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        OnGetDisplayText = cxGridTimes_CREATEDGetDisplayText
        SortIndex = 0
        SortOrder = soAscending
        Width = 120
      end
      object cxgrdbclmnGridTimes_FLG_IMPORTANT: TcxGridDBColumn
        Caption = #1042#1078#1085
        DataBinding.FieldName = 'FLG_IMPORTANT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.DisplayChecked = '1'
        Properties.DisplayUnchecked = '0'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Width = 32
      end
    end
    object cxGridTimesLevel1: TcxGridLevel
      GridView = cxGridTimesTable
    end
  end
  object pnImage: TPanel
    Left = 379
    Top = 94
    Width = 683
    Height = 577
    Align = alClient
    BevelOuter = bvNone
    Color = clBlack
    ParentBackground = False
    TabOrder = 3
    object cxDBImage1: TcxDBImage
      Left = 0
      Top = 0
      TabStop = False
      Align = alClient
      DataBinding.DataField = 'IMAGE'
      DataBinding.DataSource = IBCDataSourceImage
      Properties.GraphicClassName = 'TdxPNGImage'
      Properties.ReadOnly = True
      Properties.ShowFocusRect = False
      Style.BorderStyle = ebsNone
      TabOrder = 0
      OnDblClick = cxDBImage1DblClick
      ExplicitLeft = 3
      Height = 577
      Width = 683
    end
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
    Top = 12
    PixelsPerInch = 96
    object dxBarManager1Bar2: TdxBar
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
      FloatLeft = 874
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          UserDefine = [udWidth]
          UserWidth = 162
          Visible = True
          ItemName = 'bdeDate'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bntView'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarDateCombo1: TdxBarDateCombo
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FF00000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
    object bbClearAll: TdxBarButton
      Align = iaRight
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1105' '#1079#1072#1087#1080#1089#1080'...'
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1105' '#1079#1072#1087#1080#1089#1080
      Visible = ivNever
      ImageIndex = 35
      OnClick = bbClearAllClick
    end
    object bdeDate: TdxBarDateCombo
      Caption = #1044#1072#1090#1072
      Category = 0
      Hint = #1044#1072#1090#1072
      Visible = ivAlways
      OnChange = bdeDateChange
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FF00000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ShowCaption = True
      ShowClearButton = False
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Refresh'
      Category = 0
      Hint = 'Refresh'
      Visible = ivAlways
      ImageIndex = 36
      ShortCut = 116
      OnClick = dxBarButton1Click
    end
    object bntView: TdxBarButton
      Caption = 'Full screen view'
      Category = 0
      Hint = 'Full screen view'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E0000000000000000000000000000000000001010
        104B2D2D2D7B2A2A2A792A2A2A792A2A2A792A2A2A792A2A2A792A2A2A792A2A
        2A792A2A2A792D2D2D7B1010104F000000000000000000000000000000006363
        63A8FFFFFFFFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6
        F6FFF6F6F6FFFFFFFFFF666666AF000000000000000000000000000000005C5C
        5C9FFCFCFCFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEF
        EFFFEFEFEFFFFCFCFCFF5E5E5EA6000000000000000000000000000000005D5D
        5D9FFFFFFFFFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3
        F3FFF3F3F3FFFFFFFFFF5F5F5FA6000000000000000000000000000000005E5E
        5E9FFFFFFFFFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7
        F7FFF7F7F7FFFFFFFFFF616161A6000000000000000000000000000000006060
        609FFFFFFFFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFB
        FBFFFBFBFBFFFFFFFFFF636363A6000000000000000000000000000000006161
        619FFFFFFFFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
        FEFFFEFEFEFFFFFFFFFF646464A6000000000000000000000000000000006161
        619FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF646464A6000000000000000000000000000000006161
        619FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF646464A6000000000000000000000000000000006161
        619FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
        FEFFF9F9F9FFFFFFFFFF616161A6000000000000000000000000000000006161
        619FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFFF2F2
        F2FFEAEAEAFFF4F4F4FF616161AA000000000000000000000000000000006161
        619FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFFF0F0F0FFDFDF
        DFFFD0D0D0FFE4E4E4FF3A3A3A83000000000000000000000000000000006161
        619FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFF3F3F3FFE1E1E1FFE7E7
        E7FFEFEFEFFF8F8F8FCB01010113000000000000000000000000000000006161
        619FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAFFECECECFFD4D4D4FFFFFF
        FFFFA1A1A1CD0202021900000000000000000000000000000000000000006A6A
        6AA6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4FFE9E9E9FF9696
        96CC020202190000000000000000000000000000000000000000000000003434
        34738B8B8BBB888888BA888888BA888888BA858585BA838383BB4D4D4D910101
        01130000000000000000000000000000000000000000}
      PaintStyle = psCaptionGlyph
      ShortCut = 115
      OnClick = bntViewClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbClearAll'
        end>
    end
    object dxBtn1: TdxBarButton
      Caption = #1042#1072#1078#1085#1086
      Category = 0
      Hint = #1042#1072#1078#1085#1086
      Visible = ivAlways
      OnClick = dxBtn1Click
    end
    object dxBtn2: TdxBarButton
      Caption = #1053#1077' '#1074#1072#1078#1085#1086
      Category = 0
      Hint = #1053#1077' '#1074#1072#1078#1085#1086
      Visible = ivAlways
      OnClick = dxBtn2Click
    end
  end
  object IBCQueryTree: TIBCQuery
    Connection = IBCConnection2
    Transaction = IBCTrSelect2
    SQL.Strings = (
      'SELECT * FROM (SELECT DISTINCT TDB_USERS.ID AS USERID, '
      '         TDB_USERS.USER_NAME, '
      '         TDB_COMPUTERS.ID AS COMPUTERID, '
      '         TDB_COMPUTERS.COMPUTER_NAME '
      'FROM TDB_SS '
      
        '         INNER JOIN TDB_USERS ON TDB_USERS.ID = TDB_SS.USER_ID a' +
        'nd tdb_ss.user_id not in (1,2,4)'
      
        '         INNER JOIN TDB_COMPUTERS ON TDB_COMPUTERS.ID = TDB_SS.C' +
        'OMPUTER_ID WHERE CAST(TDB_SS.CREATED AS DATE) = :DATA '
      '         ORDER BY TDB_SS.ID ) ORDER BY 3')
    ReadOnly = True
    Left = 52
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA'
        Value = nil
      end>
  end
  object IBCDataSourceTree: TIBCDataSource
    DataSet = IBCQueryTree
    Left = 52
    Top = 236
  end
  object IBCQueryTime: TIBCQuery
    SQLUpdate.Strings = (
      'UPDATE TDB_SS'
      'SET'
      '  ID = :ID, FLG_IMPORTANT = :FLG_IMPORTANT'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      'SELECT * FROM TDB_SS'
      'WHERE'
      '  ID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_SS'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TDB_SS'
      ''
      ') q')
    Connection = IBCConnection2
    Transaction = IBCTrSelect2
    UpdateTransaction = IBCTrUpdate2
    SQL.Strings = (
      'SELECT * FROM'
      '('
      'SELECT'
      '      TDB_SS.ID,'
      '      TDB_USERS.ID AS USERID,'
      '      TDB_COMPUTERS.ID AS COMPUTERID,'
      '      TDB_SS.CREATED,'
      '      TDB_SS.FLG_IMPORTANT'
      'FROM TDB_SS'
      'INNER JOIN TDB_USERS ON TDB_USERS.ID = TDB_SS.USER_ID'
      
        'INNER JOIN TDB_COMPUTERS ON TDB_COMPUTERS.ID = TDB_SS.COMPUTER_I' +
        'D'
      'WHERE CAST(TDB_SS.CREATED AS DATE) = :DATA'
      'ORDER BY TDB_SS.ID'
      ')'
      'ORDER BY 3')
    MasterFields = 'USERID;COMPUTERID'
    DetailFields = 'USERID;COMPUTERID'
    MasterSource = IBCDataSourceTree
    Options.DetailDelay = 500
    Left = 368
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'COMPUTERID'
        Value = nil
      end>
  end
  object IBCDataSourceTime: TIBCDataSource
    DataSet = IBCQueryTime
    Left = 368
    Top = 236
  end
  object IBCQueryImage: TIBCQuery
    Connection = IBCConnection2
    Transaction = IBCTrSelect2
    SQL.Strings = (
      'SELECT ID, IMAGE FROM TDB_SS_IMAGE')
    MasterFields = 'ID'
    DetailFields = 'ID'
    MasterSource = IBCDataSourceTime
    ReadOnly = True
    Options.DetailDelay = 200
    Left = 908
    Top = 376
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
  object IBCDataSourceImage: TIBCDataSource
    DataSet = IBCQueryImage
    Left = 908
    Top = 440
  end
  object IBCConnection2: TIBCConnection
    Database = 'SW_MON2'
    Options.Charset = 'UTF8'
    Options.UseUnicode = True
    Options.EnableMemos = True
    Options.KeepDesignConnected = False
    Options.LocalFailover = True
    Options.EnableBCD = True
    DefaultTransaction = IBCTrSelect2
    ClientLibrary = 'fbclient.dll'
    Port = '3050'
    SSLOptions.Enabled = False
    Username = 'sysdba'
    Server = '192.168.106.254'
    LoginPrompt = False
    Left = 708
    Top = 568
    EncryptedPassword = '8AFF96FF98FF8DFF9AFF8CFFCCFFCDFFCEFF'
  end
  object IBCTrSelect2: TIBCTransaction
    DefaultConnection = IBCConnection2
    IsolationLevel = iblReadOnlyReadCommitted
    Left = 616
    Top = 568
  end
  object IBCTrUpdate2: TIBCTransaction
    DefaultConnection = IBCConnection2
    Left = 812
    Top = 568
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBtn1'
      end
      item
        Visible = True
        ItemName = 'dxBtn2'
      end>
    UseOwnFont = False
    Left = 308
    Top = 324
    PixelsPerInch = 96
  end
end
