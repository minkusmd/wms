object frmGoodsGroupsManagerDlg: TfrmGoodsGroupsManagerDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1058#1086#1074#1072#1088#1085#1099#1077' '#1075#1088#1091#1087#1087#1099
  ClientHeight = 551
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 704
    Height = 64
    Title = #1058#1086#1074#1072#1088#1085#1099#1077' '#1075#1088#1091#1087#1087#1099
    Text = #1042#1099#1073#1086#1088' '#1080' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1085#1099#1093' '#1075#1088#1091#1087#1087' '#1076#1083#1103' '#1072#1082#1094#1080#1081
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
    ImageIndex = 1
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 688
    Height = 426
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 688
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridGG: TcxGrid
      Left = 0
      Top = 30
      Width = 688
      Height = 396
      Align = alClient
      TabOrder = 1
      object cxGridGGTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxGridGGTableCustomDrawCell
        OnFocusedRecordChanged = cxGridGGTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceGG
        DataController.KeyFieldNames = 'GG_ID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridGGTable_GG_ID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'GG_ID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridGGTable_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
          Width = 200
        end
        object cxGridGGTable_DESCRIPTION: TcxGridDBColumn
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          DataBinding.FieldName = 'DESCRIPTION'
          Width = 300
        end
        object cxGridGGTable_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_BY_NAME'
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
      end
      object cxGridGGLevel: TcxGridLevel
        GridView = cxGridGGTable
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 498
    Width = 704
    Height = 53
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 12
    Padding.Right = 24
    Padding.Bottom = 12
    ShowCaption = False
    TabOrder = 2
    object btnSelect: TButton
      AlignWithMargins = True
      Left = 492
      Top = 12
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alRight
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Default = True
      TabOrder = 0
      OnClick = btnSelectClick
    end
    object btnClose: TButton
      Left = 590
      Top = 12
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 1
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
    Left = 440
    Top = 16
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
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
      FloatLeft = 728
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
          ItemName = 'bbModify'
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
    object bbNew: TdxBarButton
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Hint = #1053#1086#1074#1072#1103
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyClick
    end
    object bbDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteClick
    end
  end
  object IBCQueryGG: TIBCQuery
    KeyFields = 'GG_ID'
    KeyGenerator = 'SQ_MK_GOODS_GROUPS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO MK_GOODS_GROUPS'
      '  (GG_ID, TITLE, DESCRIPTION)'
      'VALUES'
      '  (:GG_ID, :TITLE, :DESCRIPTION)')
    SQLDelete.Strings = (
      'DELETE FROM MK_GOODS_GROUPS'
      'WHERE'
      '  GG_ID = :Old_GG_ID')
    SQLUpdate.Strings = (
      'UPDATE MK_GOODS_GROUPS'
      'SET'
      '  GG_ID = :GG_ID, TITLE = :TITLE, DESCRIPTION = :DESCRIPTION'
      'WHERE'
      '  GG_ID = :Old_GG_ID')
    SQLRefresh.Strings = (
      'SELECT '
      ' GG_ID, '
      ' TITLE, '
      ' DESCRIPTION, '
      ' CREATED, '
      ' CREATED_BY, '
      ' CREATED_BY_NAME '
      'FROM '
      ' VW_MK_GOODS_GROUPS'
      'WHERE'
      ' GG_ID = :GG_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_GOODS_GROUPS'
      'WHERE'
      'GG_ID = :Old_GG_ID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrGGUpdate
    SQL.Strings = (
      'SELECT '
      ' GG_ID, '
      ' TITLE, '
      ' DESCRIPTION, '
      ' CREATED, '
      ' CREATED_BY, '
      ' CREATED_BY_NAME '
      'FROM '
      ' VW_MK_GOODS_GROUPS')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 96
    Top = 192
  end
  object IBCDataSourceGG: TIBCDataSource
    DataSet = IBCQueryGG
    Left = 96
    Top = 248
  end
  object IBCTrGGUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 96
    Top = 308
  end
end
