object frmWebMailingsDlg: TfrmWebMailingsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'E-mail '#1088#1072#1089#1089#1099#1083#1082#1072
  ClientHeight = 614
  ClientWidth = 879
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
    Width = 879
    Height = 80
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Title = 'E-mail '#1088#1072#1089#1089#1099#1083#1082#1072
    Text = #1056#1072#1089#1089#1099#1083#1082#1072' '#1101#1083#1077#1082#1090#1088#1086#1085#1085#1086#1081' '#1088#1077#1082#1083#1072#1084#1099
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
    ImageIndex = 30
  end
  object pnClient: TPanel
    Left = 0
    Top = 80
    Width = 879
    Height = 461
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 10
      Top = 10
      Width = 859
      Height = 30
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 10
      Top = 40
      Width = 859
      Height = 421
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTableCellDblClick
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceMailing
        DataController.KeyFieldNames = 'MAILINGID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1088#1072#1089#1089#1099#1083#1086#1082'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGrid_STATE: TcxGridDBColumn
          DataBinding.FieldName = 'STATE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 23
              Value = 0
            end
            item
              ImageIndex = 25
              Value = 1
            end
            item
              ImageIndex = 7
              Value = 2
            end
            item
              ImageIndex = 43
              Value = 3
            end>
          MinWidth = 24
          Options.HorzSizing = False
          Options.ShowCaption = False
          VisibleForCustomization = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGrid_MAILINGID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'MAILINGID'
          DataBinding.IsNullValueType = True
          MinWidth = 50
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 50
        end
        object cxGrid_CREATED: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'CREATED'
          DataBinding.IsNullValueType = True
          OnGetDisplayText = cxGrid_CREATEDGetDisplayText
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGrid_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
          DataBinding.IsNullValueType = True
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnClose: TButton
    Left = 745
    Top = 559
    Width = 113
    Height = 36
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
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
    Left = 356
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
      FloatLeft = 588
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
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
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPrint'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewEmpty: TdxBarButton
      Tag = 1
      Caption = #1055#1091#1089#1090#1072#1103' '#1072#1082#1094#1080#1103
      Category = 0
      Hint = #1055#1091#1089#1090#1072#1103' '#1072#1082#1094#1080#1103
      Visible = ivAlways
      OnClick = bbNewEmptyClick
    end
    object bbEdit: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteClick
    end
    object bbPrepareMailing: TdxBarButton
      Caption = #1055#1086#1076#1075#1086#1090#1086#1074#1080#1090#1100' '#1082'  '#1088#1072#1089#1089#1099#1083#1082#1077'...'
      Category = 0
      Hint = #1055#1086#1076#1075#1086#1090#1086#1074#1080#1090#1100' '#1082'  '#1088#1072#1089#1089#1099#1083#1082#1077
      Visible = ivAlways
      ImageIndex = 25
      OnClick = bbPrepareMailingClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1056#1072#1089#1089#1099#1083#1082#1072
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPrepareMailing'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbTestSend'
        end
        item
          Visible = True
          ItemName = 'bbStartSending'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbStopMailing'
        end>
    end
    object bbPrint: TdxBarButton
      Caption = #1054#1090#1095#1077#1090#1099
      Category = 0
      Hint = #1054#1090#1095#1077#1090#1099
      Visible = ivAlways
      ImageIndex = 28
      ShortCut = 16464
      OnClick = bbPrintClick
    end
    object bbTestSend: TdxBarButton
      Caption = #1058#1077#1089#1090#1086#1074#1072#1103' '#1088#1072#1089#1089#1099#1083#1082#1072'...'
      Category = 0
      Hint = #1058#1077#1089#1090#1086#1074#1072#1103' '#1088#1072#1089#1089#1099#1083#1082#1072
      Visible = ivAlways
      OnClick = bbTestSendClick
    end
    object bbNew: TdxBarSubItem
      Caption = #1053#1086#1074#1072#1103' '#1072#1082#1094#1080#1103
      Category = 0
      Visible = ivAlways
      ImageIndex = 40
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewEmpty'
        end
        item
          Visible = True
          ItemName = 'bbNewTemplated'
        end>
    end
    object bbNewTemplated: TdxBarButton
      Tag = 2
      Caption = #1057#1090#1072#1085#1076#1072#1088#1090#1085#1099#1081' '#1096#1072#1073#1083#1086#1085' '#1072#1082#1094#1080#1080
      Category = 0
      Hint = #1057#1090#1072#1085#1076#1072#1088#1090#1085#1099#1081' '#1096#1072#1073#1083#1086#1085' '#1072#1082#1094#1080#1080
      Visible = ivAlways
      OnClick = bbNewEmptyClick
    end
    object bbStopMailing: TdxBarButton
      Caption = #1053#1072#1079#1072#1076' '#1074' '#1088#1077#1078#1080#1084' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103'...'
      Category = 0
      Hint = #1053#1072#1079#1072#1076' '#1074' '#1088#1077#1078#1080#1084' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbStopMailingClick
    end
    object bbStartSending: TdxBarButton
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1088#1072#1089#1089#1099#1083#1082#1091'...'
      Category = 0
      Hint = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1088#1072#1089#1089#1099#1083#1082#1091
      Visible = ivAlways
      ImageIndex = 45
      OnClick = bbStartSendingClick
    end
  end
  object IBCQueryMailing: TIBCQuery
    SQLDelete.Strings = (
      'DELETE FROM TWEB_MAILINGS'
      'WHERE'
      '  MAILINGID = :Old_MAILINGID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_MAILINGS'
      'SET'
      '  MAILINGID = :MAILINGID, TITLE = :TITLE, '
      '  HEADER_TEXT = :HEADER_TEXT, HEADER_IMAGE = :HEADER_IMAGE, '
      '  FOOTER_TEXT = :FOOTER_TEXT, FOOTER_IMAGE = :FOOTER_IMAGE,'
      '  GOOGLETAG = :GOOGLETAG'
      'WHERE'
      '  MAILINGID = :Old_MAILINGID')
    SQLRefresh.Strings = (
      'SELECT '
      
        ' MAILINGID, TITLE, HEADER_TEXT, HEADER_IMAGE, FOOTER_TEXT, FOOTE' +
        'R_IMAGE, CREATED, STATE, GOOGLETAG'
      'FROM TWEB_MAILINGS'
      'WHERE'
      '  MAILINGID = :MAILINGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_MAILINGS'
      'WHERE'
      'MAILINGID = :Old_MAILINGID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      
        ' MAILINGID, TITLE, HEADER_TEXT, HEADER_IMAGE, FOOTER_TEXT, FOOTE' +
        'R_IMAGE, CREATED, STATE, GOOGLETAG'
      'FROM TWEB_MAILINGS'
      'ORDER BY MAILINGID DESC'
      '')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 56
    Top = 192
  end
  object IBCDataSourceMailing: TIBCDataSource
    DataSet = IBCQueryMailing
    Left = 56
    Top = 140
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 56
    Top = 252
  end
  object IBCQueryMailingContent: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from TWEB_MAILING_CONTENT where mailingID=:mailingID')
    Left = 200
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'mailingID'
        Value = nil
      end>
  end
  object dsMailingContent: TIBCDataSource
    DataSet = IBCQueryMailingContent
    Left = 200
    Top = 144
  end
  object IBCQueryEmailMessages: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO EMAIL_MESSAGES'
      
        '  (EMAILID, DATA_CREATED, EMAIL, SUBJECT, BODY, FLG_SENT, DATA_D' +
        'ELIVERED, SOURCE_TABLE, CC_LIST, PRIORITY, FLG_ERROR, ERROR_TEXT' +
        ')'
      'VALUES'
      
        '  (:EMAILID, :DATA_CREATED, :EMAIL, :SUBJECT, :BODY, :FLG_SENT, ' +
        ':DATA_DELIVERED, :SOURCE_TABLE, :CC_LIST, :PRIORITY, :FLG_ERROR,' +
        ' :ERROR_TEXT)')
    SQLDelete.Strings = (
      'DELETE FROM EMAIL_MESSAGES'
      'WHERE'
      '  EMAILID = :Old_EMAILID')
    SQLUpdate.Strings = (
      'UPDATE EMAIL_MESSAGES'
      'SET'
      
        '  EMAILID = :EMAILID, DATA_CREATED = :DATA_CREATED, EMAIL = :EMA' +
        'IL, SUBJECT = :SUBJECT, BODY = :BODY, FLG_SENT = :FLG_SENT, DATA' +
        '_DELIVERED = :DATA_DELIVERED, SOURCE_TABLE = :SOURCE_TABLE, CC_L' +
        'IST = :CC_LIST, PRIORITY = :PRIORITY, FLG_ERROR = :FLG_ERROR, ER' +
        'ROR_TEXT = :ERROR_TEXT'
      'WHERE'
      '  EMAILID = :Old_EMAILID')
    SQLRefresh.Strings = (
      
        'SELECT EMAILID, DATA_CREATED, EMAIL, SUBJECT, BODY, FLG_SENT, DA' +
        'TA_DELIVERED, SOURCE_TABLE, CC_LIST, PRIORITY, FLG_ERROR, ERROR_' +
        'TEXT FROM EMAIL_MESSAGES'
      'WHERE'
      '  EMAILID = :EMAILID')
    SQLLock.Strings = (
      'SELECT NULL FROM EMAIL_MESSAGES'
      'WHERE'
      'EMAILID = :Old_EMAILID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM EMAIL_MESSAGES'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'select * from email_messages')
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 424
    Top = 328
  end
end
