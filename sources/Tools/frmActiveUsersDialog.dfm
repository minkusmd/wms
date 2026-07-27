object frmActiveUsersDlg: TfrmActiveUsersDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1040#1082#1090#1080#1074#1085#1099#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080' '#1080' '#1087#1088#1086#1094#1077#1089#1089#1099
  ClientHeight = 649
  ClientWidth = 826
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
    Width = 826
    Height = 64
    Title = #1040#1082#1090#1080#1074#1085#1099#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080' '#1080' '#1087#1088#1086#1094#1077#1089#1089#1099
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
    ImageIndex = 2
  end
  object btnClose: TButton
    Left = 720
    Top = 604
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 810
    Height = 529
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 810
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxPageControl1: TcxPageControl
      Left = 0
      Top = 30
      Width = 810
      Height = 499
      Align = alTop
      TabOrder = 1
      Properties.ActivePage = tbsUsers
      Properties.CustomButtons.Buttons = <>
      Properties.TabPosition = tpBottom
      ClientRectBottom = 473
      ClientRectLeft = 4
      ClientRectRight = 806
      ClientRectTop = 4
      object tbsUsers: TcxTabSheet
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
        ImageIndex = 0
        object cxGridUsers: TcxGrid
          Left = 0
          Top = 0
          Width = 802
          Height = 469
          Align = alClient
          TabOrder = 0
          object cxGridUsersTable: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = IBCDataSourceUsers
            DataController.KeyFieldNames = 'USERID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skCount
                Column = cxGridUsers_FULL_NAME
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.CellEndEllipsis = True
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Group = dmAdditions.cxStyle_Bold
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridUsers_USERID: TcxGridDBColumn
              Caption = 'UserID'
              DataBinding.FieldName = 'USERID'
              DataBinding.IsNullValueType = True
              Visible = False
              Width = 40
            end
            object cxGridUsers_ICON: TcxGridDBColumn
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.DefaultImageIndex = 20
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <>
              MinWidth = 24
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridUsers_FULL_NAME: TcxGridDBColumn
              Caption = #1060'.'#1048'.'#1054
              DataBinding.FieldName = 'FULL_NAME'
              DataBinding.IsNullValueType = True
              SortIndex = 0
              SortOrder = soAscending
              Width = 200
            end
            object cxGridUsers_FUNCTIA_DETINUTA: TcxGridDBColumn
              Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
              DataBinding.FieldName = 'FUNCTIA_DETINUTA'
              DataBinding.IsNullValueType = True
              Width = 100
            end
            object cxGridUsers_TELEFON: TcxGridDBColumn
              Caption = #1058#1077#1083#1077#1092#1086#1085
              DataBinding.FieldName = 'TELEFON'
              DataBinding.IsNullValueType = True
              Width = 100
            end
            object cxGridUsers_DEFAULT_DT: TcxGridDBColumn
              Caption = #1060#1080#1088#1084#1072
              DataBinding.FieldName = 'DEFAULT_DT'
              DataBinding.IsNullValueType = True
              Visible = False
              OnGetDataText = cxGridUsers_DEFAULT_DTGetDataText
              GroupIndex = 0
              Options.SortByDisplayText = isbtOff
              Width = 100
            end
            object cxGridUsers_DISPLAYNAME: TcxGridDBColumn
              Caption = #1060#1080#1088#1084#1072
              DataBinding.FieldName = 'DISPLAYNAME'
              DataBinding.IsNullValueType = True
              Visible = False
              VisibleForCustomization = False
              Width = 100
            end
          end
          object cxGridUsersLevel: TcxGridLevel
            GridView = cxGridUsersTable
          end
        end
      end
      object tbsProcesses: TcxTabSheet
        Caption = #1055#1088#1086#1094#1077#1089#1089#1099
        ImageIndex = 1
        object cxGridProc: TcxGrid
          Left = 0
          Top = 0
          Width = 802
          Height = 469
          Align = alClient
          TabOrder = 0
          object cxGridProcTable: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = IBCDataSourceProcs
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skCount
                Column = cxGridProc_REMOTE_ADDRESS
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.CellEndEllipsis = True
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridProcTableColumn1: TcxGridDBColumn
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.DefaultImageIndex = 45
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <>
              MinWidth = 24
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridProc_REMOTE_ADDRESS: TcxGridDBColumn
              Caption = 'IP '#1040#1076#1088#1077#1089
              DataBinding.FieldName = 'MON$REMOTE_ADDRESS'
              DataBinding.IsNullValueType = True
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
            object cxGridProc_REMOTE_PROCESS: TcxGridDBColumn
              Caption = #1055#1088#1086#1094#1077#1089#1089
              DataBinding.FieldName = 'MON$REMOTE_PROCESS'
              DataBinding.IsNullValueType = True
              Width = 240
            end
            object cxGridProc_MEMORY_USED: TcxGridDBColumn
              Caption = #1055#1072#1084#1103#1090#1100
              DataBinding.FieldName = 'MON$MEMORY_USED'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DecimalPlaces = 0
              Properties.DisplayFormat = '# ### ###'
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
          end
          object cxGridProcLevel: TcxGridLevel
            GridView = cxGridProcTable
          end
        end
      end
    end
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCTrSelect
    SQL.Strings = (
      'SELECT DISTINCT'
      ' MON$CONTEXT_VARIABLES.MON$VARIABLE_VALUE USERID,'
      ' TS_USERS.FULL_NAME,'
      ' TS_USERS.FUNCTIA_DETINUTA,'
      ' TS_USERS.TELEFON,'
      ' TS_USERS.DEFAULT_DT,'
      ' TS_CUSTOMER.DISPLAYNAME'
      'FROM MON$ATTACHMENTS'
      
        'INNER JOIN MON$CONTEXT_VARIABLES ON (MON$CONTEXT_VARIABLES.MON$A' +
        'TTACHMENT_ID=MON$ATTACHMENTS.MON$ATTACHMENT_ID AND MON$CONTEXT_V' +
        'ARIABLES.MON$VARIABLE_NAME='#39'UserID'#39')'
      
        'INNER JOIN TS_USERS ON (TS_USERS.USERID=MON$CONTEXT_VARIABLES.MO' +
        'N$VARIABLE_VALUE)'
      
        'INNER JOIN TS_CUSTOMER ON (TS_CUSTOMER.CUSTOMERID=TS_USERS.DEFAU' +
        'LT_DT)')
    ReadOnly = True
    AutoCommit = False
    Left = 160
    Top = 160
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 160
    Top = 220
  end
  object IBCQueryProcs: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCTrSelect
    SQL.Strings = (
      'SELECT'
      ' MON$ATTACHMENTS.MON$REMOTE_ADDRESS,'
      ' MON$ATTACHMENTS.MON$REMOTE_PROCESS,'
      ' MON$MEMORY_USAGE.MON$MEMORY_USED'
      'FROM MON$ATTACHMENTS'
      
        'LEFT OUTER JOIN MON$CONTEXT_VARIABLES ON (MON$CONTEXT_VARIABLES.' +
        'MON$ATTACHMENT_ID=MON$ATTACHMENTS.MON$ATTACHMENT_ID AND MON$CONT' +
        'EXT_VARIABLES.MON$VARIABLE_NAME='#39'UserID'#39')'
      
        'INNER JOIN MON$MEMORY_USAGE ON (MON$MEMORY_USAGE.MON$STAT_ID=MON' +
        '$ATTACHMENTS.MON$STAT_ID)'
      'WHERE MON$CONTEXT_VARIABLES.MON$VARIABLE_VALUE IS NULL'
      'ORDER BY 1')
    ReadOnly = True
    AutoCommit = False
    Left = 296
    Top = 160
  end
  object IBCDataSourceProcs: TIBCDataSource
    DataSet = IBCQueryProcs
    Left = 296
    Top = 224
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
    Left = 620
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
      FloatLeft = 850
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
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
    object bbRefresh: TdxBarButton
      Align = iaClient
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Category = 0
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 36
      ShortCut = 116
      OnClick = bbRefreshClick
    end
  end
  object IBCTrSelect: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    DefaultCloseAction = taCommit
    IsolationLevel = iblReadOnlyReadCommitted
    Left = 232
    Top = 296
  end
end
